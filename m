Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAE4B7164
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 17:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiBOQGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 11:06:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiBOQGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:06:19 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411F6D3BE;
        Tue, 15 Feb 2022 08:06:09 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK0L8-0021ZA-Eq; Tue, 15 Feb 2022 16:06:06 +0000
Date:   Tue, 15 Feb 2022 16:06:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Xavier Roche <xavier.roche@algolia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
Message-ID: <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
References: <20220214210708.GA2167841@xavier-xps>
 <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:37:40PM +0000, Al Viro wrote:
> On Tue, Feb 15, 2022 at 10:56:29AM +0100, Miklos Szeredi wrote:
> 
> > Doing "lock_rename() + lookup last components" would fix this race.
> 
> No go - thanks to the possibility of AT_SYMLINK_FOLLOW there.
> Think of it - we'd need to
> 	* lock parents (both at the same time)
> 	* look up the last component of source
> 	* if it turns a symlink - unlock parents and repeat the entire
> thing for its body, except when asked not to.
> 	* when we are done with the source, look the last component of
> target up
> 
> ... and then there is sodding -ESTALE handling, with all the elegance
> that brings in.
> 
> > If this was only done on retry, then that would prevent possible
> > performance regressions, at the cost of extra complexity.
> 
> Extra compared to the above, that is.  How delightful...

Actually, it's even viler than that: lock_rename() relies upon the
directories being locked sitting on the same fs.  Now, surely link(2)
would fail if source and target are on the different filesystem,
wouldn't it?  Alas, with AT_SYMLINK_FOLLOW it's quite possible to have
the source resolving to a symlink that does lead to the same fs as the
target, while the symlink itself is on a different fs.  So it's not
even straight lock_rename() - it has to be a special version that would
handle cross-fs invocations (somehow - e.g. ordering them on superblock
or mount in-core address in such case; ordering between dentries could
be arbitrary for cross-fs cases).

Worse, you need to deal with the corner cases.  "/" or anything ending on
"." or ".." can be rejected (no links to directories) and thankfully we
do not allow AT_EMPTY for linkat(2), but...  procfs symlinks are in the
game, since AT_SYMLINK_FOLLOW is there.

And _that_ is a real bitch - what "parent" would you lock for (followed)
/proc/self/fd/0?  It can change right under you; one solution would
be to grab ->vfs_rename_mutex first, same parent or not, then do what
lock_rename() does, relying upon ->d_parent having been stabilized
by ->vfs_rename_mutex.  But that would have to be conditional upon
running into that case - you don't want to serialize the shit out of
(same-directory) link(2) on given filesystem.  Which makes the entire
thing even harder to follow and reason about.

And to make it even more fun, you'll need to either duplicate pick_link()
guts, or try and make it usable in this situation.  Might or might not
be easy - I hadn't tried to go into that.

"Fucking ugly" is inadequate for the likely results of that approach.
It's guaranteed to be a source of headache for pretty much ever after.

Does POSIX actually make any promises in that area?  That would affect
how high a cost we ought to pay for that - I agree that it would be nicer
to have atomicity from userland point of view, but there's a difference
between hard bug and QoI issue.

Again, what really makes it painful is AT_SYMLINK_FOLLOW support in
linkat(2).  For plain link(2) it would be easier to deal with.

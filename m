Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB74B7EDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 04:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiBPDuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 22:50:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBPDuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:50:09 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B4B1FA6F;
        Tue, 15 Feb 2022 19:49:58 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKBKG-002AeZ-O2; Wed, 16 Feb 2022 03:49:56 +0000
Date:   Wed, 16 Feb 2022 03:49:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 1/4] dcache: sweep cached negative dentries to the end
 of list of siblings
Message-ID: <Ygx0ZJbn3cdUwnQ1@zeniv-ca.linux.org.uk>
References: <20220209231406.187668-1-stephen.s.brennan@oracle.com>
 <20220209231406.187668-2-stephen.s.brennan@oracle.com>
 <YgSjo5wascR9mfnA@zeniv-ca.linux.org.uk>
 <875ypf8s5m.fsf@stepbren-lnx.us.oracle.com>
 <YgxvK03Q3wBVfLYS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgxvK03Q3wBVfLYS@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 03:27:39AM +0000, Al Viro wrote:
> On Tue, Feb 15, 2022 at 06:24:53PM -0800, Stephen Brennan wrote:
> 
> > It seems to me that, if we had taken a reference on child by
> > incrementing the reference count prior to unlocking it, then
> > dentry_unlist could never have been called, since we would never have
> > made it into __dentry_kill. child would still be on the list, and any
> > cursor (or sweep_negative) list updates would now be reflected in
> > child->d_child.next. But dput is definitely not safe while holding a
> > lock on a parent dentry (even more so now thanks to my patch), so that
> > is out of the question.
> > 
> > Would dput_to_list be an appropriate solution to that issue? We can
> > maintain a dispose list in d_walk and then for any dput which really
> > drops the refcount to 0, we can handle them after d_walk is done. It
> > shouldn't be that many dentries anyway.
> 
> 	Interesting idea, but... what happens to behaviour of e.g.
> shrink_dcache_parent()?  You'd obviously need to modify the test in
> select_collect(), but then the selected dentries become likely candidates
> for d_walk() itself wanting to move them over to its internal shrink list.
> OTOH, __dput_to_list() will just decrement the count and skip the sucker
> if it's already on a shrink list...
> 
> 	It might work, but it really needs a careful analysis wrt.
> parallel d_walk().  What happens when you have two threads hitting
> shrink_dcache_parent() on two different places, one being an ancestor
> of another?  That can happen in parallel, and currently it does work
> correctly, but that's fairly delicate and there are places where a minor
> change could turn O(n) into O(n^2), etc.
> 
> 	Let me think about that - I'm not saying it's hopeless, and it
> would be nice to avoid that subtlety in dentry_unlist(), but there
> might be dragons.

PS: another obvious change is that d_walk() would become blocking.
So e.g.

int path_has_submounts(const struct path *parent)
{
        struct check_mount data = { .mnt = parent->mnt, .mounted = 0 };

	read_seqlock_excl(&mount_lock);
	d_walk(parent->dentry, &data, path_check_mount);
	read_sequnlock_excl(&mount_lock);

	return data.mounted;
} 

would need a rework - d_walk() is under a spinlock here.  Another
potential headache in that respect is d_genocide() - currently non-blocking,
with this change extremely likely to do evictions.  That, however, is
not a problem for current in-tree callers - they are all shortly followed
by shrink_dcache_parent() or equivalents.

path_has_submounts(), though...  I'd really hate to reintroduce the
"call this on entry/call this on exit" callbacks.  Perhaps it would
be better to pass the dispose list to d_walk() and have the callers
deal with evictions?  For that matter, shrink_dcache_parent() and
friends would be just fine passing the same list they are collecting
into.

<looks at path_has_submounts() callers>
*growl*
autofs_d_automount() has it called under sbi->fs_lock.  So we'd need
to take the disposal all the way out there, and export shrink_dentry_list()
while we are at it.  Not pretty ;-/

And no, we can't make the disposal async, so offloading it to a worker or
thread is not feasible...

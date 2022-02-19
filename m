Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736804BC5F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 07:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbiBSGII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 01:08:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbiBSGIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 01:08:07 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3719859A70;
        Fri, 18 Feb 2022 22:07:49 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLIuJ-002v4X-W6; Sat, 19 Feb 2022 06:07:48 +0000
Date:   Sat, 19 Feb 2022 06:07:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, paulmck@kernel.org,
        gscrivan@redhat.com, Eric Biederman <ebiederm@xmission.com>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] vfs: free vfsmount through rcu work from kern_unmount
Message-ID: <YhCJM3oFbjlln77a@zeniv-ca.linux.org.uk>
References: <20220218183114.2867528-1-riel@surriel.com>
 <20220218183114.2867528-2-riel@surriel.com>
 <YhCF4Xre/iyyOgT5@zeniv-ca.linux.org.uk>
 <YhCG9cdw2JZSKbDZ@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhCG9cdw2JZSKbDZ@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 19, 2022 at 05:58:13AM +0000, Al Viro wrote:
> On Sat, Feb 19, 2022 at 05:53:37AM +0000, Al Viro wrote:
> > On Fri, Feb 18, 2022 at 01:31:13PM -0500, Rik van Riel wrote:
> > 
> > >  struct super_block;
> > >  struct vfsmount;
> > > @@ -73,6 +74,7 @@ struct vfsmount {
> > >  	struct super_block *mnt_sb;	/* pointer to superblock */
> > >  	int mnt_flags;
> > >  	struct user_namespace *mnt_userns;
> > > +	struct rcu_work free_rwork;
> > >  } __randomize_layout;
> > 
> > Wait, what?  First of all, that has no business being in vfsmount -
> > everything that deeply internal belongs in struct mount, not in
> > its public part.  Moreover, there's already mount->mnt_rcu, so what's
> > the point duplicating that?
> 
> Argh... You need rcu_work there...
> 
> OK, so make that a member of the same union mnt_rcu is.  In struct mount,
> please.  And I'm not sure I like the idea of shoving that much into
> struct mount, TBH...

We might have a plenty of struct mount instances.  Very few of them will
ever be internal, in the first place.  Fewer yet - using kern_unmount_rcu().
And it's not small.  If anything, I would consider something like
	call_rcu(&m->mnt_rcu, callback)
with callback adding struct mount to llist and doing schedule_delayed_work()
on that.  With work consisting of doing mntput on everything in it.

I'll get some sleep and put together something along those lines tomorrow
morning.

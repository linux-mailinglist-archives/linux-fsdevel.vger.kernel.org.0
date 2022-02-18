Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8B4BC187
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiBRVGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 16:06:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBRVGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:06:52 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3CB261F;
        Fri, 18 Feb 2022 13:06:33 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLASV-002pya-10; Fri, 18 Feb 2022 21:06:31 +0000
Date:   Fri, 18 Feb 2022 21:06:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, paulmck@kernel.org,
        gscrivan@redhat.com, Eric Biederman <ebiederm@xmission.com>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] vfs: free vfsmount through rcu work from kern_unmount
Message-ID: <YhAKV5cjXEz2JTBB@zeniv-ca.linux.org.uk>
References: <20220218183114.2867528-1-riel@surriel.com>
 <20220218183114.2867528-2-riel@surriel.com>
 <Yg/y6qv6dZ2fc5z1@zeniv-ca.linux.org.uk>
 <5f442a7770fe4ac06b2837e4f937d559f5d17b8b.camel@surriel.com>
 <Yg/273dWmTKDW5Mu@zeniv-ca.linux.org.uk>
 <YhAAaU5wSoFdMsQf@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhAAaU5wSoFdMsQf@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 08:24:09PM +0000, Al Viro wrote:
> On Fri, Feb 18, 2022 at 07:43:43PM +0000, Al Viro wrote:
> > On Fri, Feb 18, 2022 at 02:33:31PM -0500, Rik van Riel wrote:
> > > On Fri, 2022-02-18 at 19:26 +0000, Al Viro wrote:
> > > > On Fri, Feb 18, 2022 at 01:31:13PM -0500, Rik van Riel wrote:
> > > > > After kern_unmount returns, callers can no longer access the
> > > > > vfsmount structure. However, the vfsmount structure does need
> > > > > to be kept around until the end of the RCU grace period, to
> > > > > make sure other accesses have all gone away too.
> > > > > 
> > > > > This can be accomplished by either gating each kern_unmount
> > > > > on synchronize_rcu (the comment in the code says it all), or
> > > > > by deferring the freeing until the next grace period, where
> > > > > it needs to be handled in a workqueue due to the locking in
> > > > > mntput_no_expire().
> > > > 
> > > > NAK.  There's code that relies upon kern_unmount() being
> > > > synchronous.  That's precisely the reason why MNT_INTERNAL
> > > > is treated that way in mntput_no_expire().
> > > 
> > > Fair enough. Should I make a kern_unmount_rcu() version
> > > that gets called just from mq_put_mnt()?
> > 
> > Umm...  I'm not sure you can afford having struct ipc_namespace
> > freed and reused before the mqueue superblock gets at least to
> > deactivate_locked_super().
> 
> BTW, that's a good demonstration of the problems with making those
> beasts async.  struct mount is *not* accessed past kern_unmount(),
> but the objects used by the superblock might very well be - in
> this case they (struct ipc_namespace, pointed to by s->s_fs_data)
> are freed by the caller after kern_unmount() returns.  And possibly
> reused.  Now note that they are used as search keys by
> mqueue_get_tree() and it becomes very fishy.
> 
> If you want to go that way, make it something like
> 
> void put_ipc_ns(struct ipc_namespace *ns)
> {
>         if (refcount_dec_and_lock(&ns->ns.count, &mq_lock)) {
> 		mq_clear_sbinfo(ns);
> 		spin_unlock(&mq_lock);
> 		kern_unmount_rcu(ns->mq_mnt);
> 	}
> }
> 
> and give mqueue this for ->kill_sb():
> 
> static void mqueue_kill_super(struct super_block *sb)
> {
> 	struct ipc_namespace *ns = sb->s_fs_info;
> 	kill_litter_super(sb);
> 	do the rest of free_ipc_ns();
> }
> 
> One thing: kern_unmount_rcu() needs a very big warning about
> the caution needed from its callers.  It's really not safe
> for general use, and it will be a temptation for folks with
> scalability problems like this one to just use it instead of
> kern_unmount() and declare the problem solved.

FWIW, that won't work correctly wrt failure exits.  I'm digging
through the lifetime rules in there right now, will post when
I'm done.

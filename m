Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7E4BBDB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 17:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiBRQmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 11:42:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiBRQmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC785A5A0;
        Fri, 18 Feb 2022 08:41:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22F0A61EC0;
        Fri, 18 Feb 2022 16:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7780FC340E9;
        Fri, 18 Feb 2022 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645202511;
        bh=vKRNU8uLHWj+Dc1BXAEL+wsvbYk0VLxDqNwdEAWoFsY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BqJyr/Avwb1+Z5+Yq0hXORx5IV0mlzVbLtQoHAAa0V1H3lV+a2SGTxfB54txLApoh
         yNi0mW+EqRmM7hCQh2olst0mXbwPVZ2Hm8jWfMwuR8bqUqDTnaH7elbnqpv8DDv43s
         +14oaZsEQPaquK6ue5SFK+QXiRg2kbkC4Idde8BJRz/g9ICWIAs3ujMJMoU+OE2U+/
         g31lspOnY9j9NlMHDUI/i9J6i5td+/8I77UQIPIOE5lr5VTwcylu21hLpOz+ZpOFUW
         JQu2wMdc3GMGuHFrbtgU4EoC0RP9dJmhYlD6OdRAdF65D81fKu1WBDOuHd0ogAAHe3
         J1Mcmw7BrXgYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2CB0D5C0292; Fri, 18 Feb 2022 08:41:51 -0800 (PST)
Date:   Fri, 18 Feb 2022 08:41:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Chris Mason <clm@fb.com>,
        linux-fsdevel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH][RFC] ipc,fs: use rcu_work to free struct ipc_namespace
Message-ID: <20220218164151.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220217153620.4607bc28@imladris.surriel.com>
 <87iltcf996.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iltcf996.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 10:08:05AM -0600, Eric W. Biederman wrote:
> 
> Maybe I am reading the lifetimes wrong but is there
> any chance the code can just do something like the diff below?
> 
> AKA have a special version of kern_umount that does the call_rcu?
> 
> Looking at rcu_reclaim_tiny I think this use of mnt_rcu is valid.
> AKA reusing the rcu_head in the rcu callback.

As long as you don't try to pass a given rcu_head structure to call_rcu()
before some previous call_rcu() has invoked the corresponding callback,
this can work.  Careful, though, because rcu_reclaim_tiny() is part of
Tiny RCU, which assumes NR_CPUS=1.  ;-)

The DEBUG_OBJECTS_RCU_HEAD Kconfig option checks for double-call_rcu()
of a single rcu_head structure.  Of course, you would need a test that
actually forces a race between the other uses of ->mnt_rcu.

Except that it looks like mntput_no_expire() is using ->mnt_rcu for
other purposes, which DEBUG_OBJECTS_RCU_HEAD is blissfully unaware of.

But doesn't mntput() call mntput_no_expire(), which in turn calls
lock_mount_hash(), which calls write_seqlock(), which is not going to
be happy in an RCU callback's BH-disabled execution context?  Or did
I miss a turn in there somewhere?

							Thanx, Paul

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 40b994a29e90..7d7aaef1592e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4395,6 +4395,22 @@ void kern_unmount(struct vfsmount *mnt)
>  }
>  EXPORT_SYMBOL(kern_unmount);
>  
> +static void rcu_mntput(struct rcu_head *head)
> +{
> +       struct mount *mnt = container_of(head, struct mount, mnt_rcu);
> +       mntput(&mnt->mnt);
> +}
> +
> +void kern_rcu_unmount(struct vfsmount *mnt)
> +{
> +       /* release long term mount so mount point can be released */
> +       if (!IS_ERR_OR_NULL(mnt)) {
> +               struct mount *m = real_mount(mnt);
> +               m->mnt_ns = NULL;
> +               call_rcu(&m->mnt_rcu, rcu_mntput);
> +       }
> +}
> +
>  void kern_unmount_array(struct vfsmount *mnt[], unsigned int num)
>  {
>         unsigned int i;
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 5becca9be867..e54742f82e7d 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -1700,7 +1700,7 @@ void mq_clear_sbinfo(struct ipc_namespace *ns)
>  
>  void mq_put_mnt(struct ipc_namespace *ns)
>  {
> -       kern_unmount(ns->mq_mnt);
> +       kern_rcu_unmount(ns->mq_mnt);
>  }
>  
>  static int __init init_mqueue_fs(void)
> 
> Eric

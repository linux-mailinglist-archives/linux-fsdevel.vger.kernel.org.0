Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E181683784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 21:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjAaU0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 15:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjAaU0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:26:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7256ED8;
        Tue, 31 Jan 2023 12:26:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62CE4615A7;
        Tue, 31 Jan 2023 20:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA80C433D2;
        Tue, 31 Jan 2023 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675196795;
        bh=gq2zoV3fgp96Ze7JcC1BY/MySF5tsWqOBisbKmRgfYI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ccZC3G6ntKeYo84IV6BMZL2L9iGDG+TyMIuIQ3HPttMWnSXSvip7Dlm0dgHSkR2Km
         Rc8yFFmi2Oas8Ql5d75DKnxSFhyuGaT3u344pexGbv94pg1zh5pIpCgdQnmTPPujRP
         mTedh3xYPk/OncYTa5PvyZXiae6KchaFvPyMUnE8Pp++ciLfZc1HYT1rl1v6UQyxfV
         y2Rlw77fSNPo4pbAq/eeeQ+6L11X2TTfYJh0EZn63fDji0+pzNrSR0bFECmQvfwcty
         1Z1n1fB2f4qG0cC8XA1NyQkAt2tAOX4J+SMvE9NS6uIknVhX+59e9HXlH2Usm7FhA9
         RZxz60x/7NLAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 511B75C0510; Tue, 31 Jan 2023 12:26:35 -0800 (PST)
Date:   Tue, 31 Jan 2023 12:26:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [maple_tree] 120b116208:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <20230131202635.GA3019407@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202301310940.4a37c7af-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301310940.4a37c7af-yujie.liu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:18:22PM +0800, kernel test robot wrote:
> Hi Liam,
> 
> We caught a "task blocked" dmesg in maple tree test. Not sure if this
> is expected for maple tree test, so we are sending this report for
> your information. Thanks.
> 
> Greeting,
> 
> FYI, we noticed INFO:task_blocked_for_more_than#seconds due to commit (built with clang-14):
> 
> commit: 120b116208a0877227fc82e3f0df81e7a3ed4ab1 ("maple_tree: reorganize testing to restore module testing")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [   17.318428][    T1] calling  maple_tree_seed+0x0/0x15d0 @ 1
> [   17.319219][    T1] 
> [   17.319219][    T1] TEST STARTING
> [   17.319219][    T1] 
> [  999.249871][   T23] INFO: task rcu_scale_shutd:59 blocked for more than 491 seconds.
> [  999.253363][   T23]       Not tainted 6.1.0-rc4-00003-g120b116208a0 #1
> [  999.254249][   T23] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  999.255390][   T23] task:rcu_scale_shutd state:D stack:30968 pid:59    ppid:2      flags:0x00004000
> [  999.256934][   T23] Call Trace:
> [  999.257418][   T23]  <TASK>
> [  999.257900][   T23]  __schedule+0x169b/0x1f90
> [  999.261677][   T23]  schedule+0x151/0x300
> [  999.262281][   T23]  ? compute_real+0xe0/0xe0
> [  999.263364][   T23]  rcu_scale_shutdown+0xdd/0x130
> [  999.264093][   T23]  ? wake_bit_function+0x2c0/0x2c0
> [  999.268985][   T23]  kthread+0x309/0x3a0
> [  999.269958][   T23]  ? compute_real+0xe0/0xe0
> [  999.270552][   T23]  ? kthread_unuse_mm+0x200/0x200
> [  999.271281][   T23]  ret_from_fork+0x1f/0x30
> [  999.272385][   T23]  </TASK>
> [  999.272865][   T23] 
> [  999.272865][   T23] Showing all locks held in the system:
> [  999.273988][   T23] 2 locks held by swapper/0/1:
> [  999.274684][   T23] 1 lock held by khungtaskd/23:
> [  999.275400][   T23]  #0: ffffffff88346e00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x8/0x30
> [  999.277171][   T23] 
> [  999.277525][   T23] =============================================
> [  999.277525][   T23] 
> [ 1049.050884][    T1] maple_tree: 12610686 of 12610686 tests passed
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202301310940.4a37c7af-yujie.liu@intel.com

Liam brought this to my attention on IRC, and it looks like the root
cause is that the rcuscale code does not deal gracefully with grace
periods that are in much excess of a second in duration.

Now, it might well be worth looking into why the grace periods were taking
that long, but if you were running Maple Tree stress tests concurrently
with rcuscale, this might well be expected behavior.

So, does the patch below clear this up for you?

							Thanx, Paul

------------------------------------------------------------------------

commit 8e44d51e3411994091f7c7c136286d82c5757a4a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jan 31 12:08:54 2023 -0800

    rcuscale: Move shutdown from wait_event() to wait_event_idle()
    
    The rcu_scale_shutdown() and kfree_scale_shutdown() kthreads/functions
    use wait_event() to wait for the rcuscale test to complete.  However,
    each updater thread in such a test waits for at least 100 grace periods.
    If each grace period takes more than 1.2 seconds, which is long, but
    not insanely so, this can trigger the hung-task timeout.
    
    This commit therefore replaces those wait_event() calls with calls to
    wait_event_idle(), which do not trigger the hung-task timeout.
    
    Reported-by: kernel test robot <yujie.liu@intel.com>
    Reported-by: Liam Howlett <liam.howlett@oracle.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008f..4120f94030c3c 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -631,8 +631,7 @@ static int compute_real(int n)
 static int
 rcu_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
+	wait_event_idle(shutdown_wq, atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
 	smp_mb(); /* Wake before output. */
 	rcu_scale_cleanup();
 	kernel_power_off();
@@ -771,8 +770,8 @@ kfree_scale_cleanup(void)
 static int
 kfree_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq,
-		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
+	wait_event_idle(shutdown_wq,
+			atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 

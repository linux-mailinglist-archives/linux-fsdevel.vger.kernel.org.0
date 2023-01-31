Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6A6837E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjAaUw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 15:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaUwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:52:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D71ADC0;
        Tue, 31 Jan 2023 12:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 007A5616C9;
        Tue, 31 Jan 2023 20:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55263C4339C;
        Tue, 31 Jan 2023 20:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675198342;
        bh=OGoBKtZbg1Gxn6addTD9QmWM3qC69M1PJemUynGtSEY=;
        h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
        b=Xsaf6jaIeAdOVNxk4xKGxZbbmwZpvLkujHyHNOpqNZISVqEFAEx6THr4cErEdoIXJ
         Wtmi6euUpqmjQxV+4Yo+cKawmw1cUOQxfkMZDTv8kekLT8/sWOnYICYwGCSu64aBLd
         vLpJqCHdp1YYenon4bSAhgik4jb+GxrrSYIywhub++KnM7OVr1jyLAwkpzp2xFbwDx
         q3g7FHIKkYThfi1/QA8VL85WJK5omxV2itfE3JrPV7mm78EAJyVvD0xTqu4at/mvd+
         0U17HH/1JPdXGeZnx4kR6gpzOTLu7kv6Z3vlYzj3LvED1QSaVc2rk61Qkjs7bNgYPy
         EFO2/DrVD64og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1DD75C0510; Tue, 31 Jan 2023 12:52:21 -0800 (PST)
Date:   Tue, 31 Jan 2023 12:52:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <yujie.liu@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [maple_tree] 120b116208:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <20230131205221.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202301310940.4a37c7af-yujie.liu@intel.com>
 <20230131202635.GA3019407@paulmck-ThinkPad-P17-Gen-1>
 <20230131204520.ad6cf4lvtw5uf27s@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131204520.ad6cf4lvtw5uf27s@revolver>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:45:20PM -0500, Liam R. Howlett wrote:
> * Paul E. McKenney <paulmck@kernel.org> [230131 15:26]:
> > On Tue, Jan 31, 2023 at 03:18:22PM +0800, kernel test robot wrote:
> > > Hi Liam,
> > > 
> > > We caught a "task blocked" dmesg in maple tree test. Not sure if this
> > > is expected for maple tree test, so we are sending this report for
> > > your information. Thanks.
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed INFO:task_blocked_for_more_than#seconds due to commit (built with clang-14):
> > > 
> > > commit: 120b116208a0877227fc82e3f0df81e7a3ed4ab1 ("maple_tree: reorganize testing to restore module testing")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: boot
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > [   17.318428][    T1] calling  maple_tree_seed+0x0/0x15d0 @ 1
> > > [   17.319219][    T1] 
> > > [   17.319219][    T1] TEST STARTING
> > > [   17.319219][    T1] 
> > > [  999.249871][   T23] INFO: task rcu_scale_shutd:59 blocked for more than 491 seconds.
> > > [  999.253363][   T23]       Not tainted 6.1.0-rc4-00003-g120b116208a0 #1
> > > [  999.254249][   T23] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [  999.255390][   T23] task:rcu_scale_shutd state:D stack:30968 pid:59    ppid:2      flags:0x00004000
> > > [  999.256934][   T23] Call Trace:
> > > [  999.257418][   T23]  <TASK>
> > > [  999.257900][   T23]  __schedule+0x169b/0x1f90
> > > [  999.261677][   T23]  schedule+0x151/0x300
> > > [  999.262281][   T23]  ? compute_real+0xe0/0xe0
> > > [  999.263364][   T23]  rcu_scale_shutdown+0xdd/0x130
> > > [  999.264093][   T23]  ? wake_bit_function+0x2c0/0x2c0
> > > [  999.268985][   T23]  kthread+0x309/0x3a0
> > > [  999.269958][   T23]  ? compute_real+0xe0/0xe0
> > > [  999.270552][   T23]  ? kthread_unuse_mm+0x200/0x200
> > > [  999.271281][   T23]  ret_from_fork+0x1f/0x30
> > > [  999.272385][   T23]  </TASK>
> > > [  999.272865][   T23] 
> > > [  999.272865][   T23] Showing all locks held in the system:
> > > [  999.273988][   T23] 2 locks held by swapper/0/1:
> > > [  999.274684][   T23] 1 lock held by khungtaskd/23:
> > > [  999.275400][   T23]  #0: ffffffff88346e00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x8/0x30
> > > [  999.277171][   T23] 
> > > [  999.277525][   T23] =============================================
> > > [  999.277525][   T23] 
> > > [ 1049.050884][    T1] maple_tree: 12610686 of 12610686 tests passed
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > | Reported-by: kernel test robot <yujie.liu@intel.com>
> > > | Link: https://lore.kernel.org/oe-lkp/202301310940.4a37c7af-yujie.liu@intel.com
> > 
> > Liam brought this to my attention on IRC, and it looks like the root
> > cause is that the rcuscale code does not deal gracefully with grace
> > periods that are in much excess of a second in duration.
> > 
> > Now, it might well be worth looking into why the grace periods were taking
> > that long, but if you were running Maple Tree stress tests concurrently
> > with rcuscale, this might well be expected behavior.
> > 
> 
> This could be simply cpu starvation causing no foward progress in your
> tests with the number of concurrent running tests and "-smp 2".
> 
> It's also worth noting that building in the rcu test module makes the
> machine turn off once the test is complete.  This can be seen in your
> console message:
> [   13.254240][    T1] rcu-scale:--- Start of test: nreaders=2 nwriters=2 verbose=1 shutdown=1
> 
> so your machine may not have finished running through the array of tests
> you have specified to build in - which is a lot.  I'm not sure if this
> is the best approach considering the load that produces on the system
> and how difficult it is (was) to figure out which test is causing a
> stall, or other issue.

Agreed, both rcuscale and refscale when built in turn the machine off at
the end of the test.  For providing background stress for some other test
(in this case Maple Tree tests), rcutorture, locktorture, or scftorture
might be better choices.

							Thanx, Paul

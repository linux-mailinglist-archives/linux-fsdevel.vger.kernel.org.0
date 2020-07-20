Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714DD226F7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgGTUMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgGTUMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:12:13 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCA2C0619D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 13:12:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b4so16863671qkn.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gufroq3ZLK6QdGAL8wDHAFBHZWpw/Rpc6niq7LgVOX0=;
        b=L8IvjmH7ZXtn4jpxvkf7GiSjkywR/ofWtLxBvhRIkb0t4Q7ms5GyVD6rCqISV2MHnc
         a5X12+JllGRmc0hX8naT1BQ4JF/xCeFEibOhpiOgGPILqhXSRebBNQvtOEwxOEO7BwB5
         +6L1UlEMMVezIKgAl6QBOqFXrkgAjiSLLZvJHVJ5Ft7Lfkvn2GWjcNzina7XxnxmaCtE
         c5xnU2k5KvYHFWJbPgsM/8HnZ1MyziPguRQ0MvIODVWtbs4KpCNyxn8EeH4GaY/aPla6
         yKtG7LmN2CjABlocxexAM6nkbwsXiLEbxthIvgkp4flxQIELWPViDdkormWfDqKlDWYQ
         JcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gufroq3ZLK6QdGAL8wDHAFBHZWpw/Rpc6niq7LgVOX0=;
        b=Uikw3RVC66eTfMxIb2r1qi1l/jsJlI1JUBpfT0+2CCNd4W+u8gPB/8y5ryrp8QJgSh
         kMMUxuMzot/9kEJn6bUnqvQ1mpuwWcyZCWL20skIMqXwAahaXsxkUb+GAerl/XqVUckr
         Hcm1DqjHdKBueBxN686cvwqFGcChcmYpec723OYubW1KhNjtUNQRtSoJgXIOeo1xnfnG
         deJvbH0+QzHpD2JNaUzE7q3ExVLxzHhb6qMtLhq9CiwhkvMzM9h6RwCe3sTZ5W/NTshd
         OlhfArm20VneL1zqTAg1URcQ0y2aKcMS9Px+qZr7j/O2XvDmzhbbxY+c+nvc4S0cpN5g
         UWWQ==
X-Gm-Message-State: AOAM533KwnC2rtbMQy/mYCum22CmqF2E0PGh69qGGfAFuQ8fm12KLzZ4
        tgTVEi/0tAr5dCTUvEGd7hH+YJWfjIrHCg==
X-Google-Smtp-Source: ABdhPJw7xDTenwANdauxipEFY2jHjN//1NckKbZSSzcmaQUmHVrT3RLOTZhGpgU9gywArScCImZDeQ==
X-Received: by 2002:a37:9c58:: with SMTP id f85mr456879qke.345.1595275932562;
        Mon, 20 Jul 2020 13:12:12 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a20sm20950223qtw.54.2020.07.20.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:12:11 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:12:04 -0400
From:   Qian Cai <cai@lca.pw>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: splice() rcu_sched self-detected stall on CPU
Message-ID: <20200720201204.GA1280@lca.pw>
References: <89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw>
 <20200505185732.GP2869@paulmck-ThinkPad-P72>
 <8678900D-8D52-4195-A767-9E6923EE0AAF@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8678900D-8D52-4195-A767-9E6923EE0AAF@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 03:00:34PM -0400, Qian Cai wrote:
> 
> 
> > On May 5, 2020, at 2:57 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Mon, May 04, 2020 at 03:11:09PM -0400, Qian Cai wrote:
> >> Running a syscall fuzzer inside a container on linux-next floods
> >> systems with soft lockups. It looks like stuck in this line at
> >> iov_iter_copy_from_user_atomic(), Thoughts?
> >> 
> >> iterate_all_kinds(i, bytes, v,
> >>                copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len),
> >>                memcpy_from_page((p += v.bv_len) - v.bv_len, v.bv_page,
> >>                                 v.bv_offset, v.bv_len),
> >>                memcpy((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len)
> >>        )
> > 
> > If the size being copied is large enough, something like this might happen.
> > 
> > Is this a CONFIG_PREEMPT=n kernel?  And is the size passed in to
> 
> Yes, CONFIG_PREEMPT=n.
> 
> > iov_iter_copy_from_user_atomic() quite large, given that this is generated
> > by a fuzzer?  If so, one thing to try is to add cond_resched() in the
> > iterate_bvec(), iterate_kvec(), and iterate_iovec() macros.
> 
> I’ll try that.

Finally, had a chance to try it, but in
iov_iter_copy_from_user_atomic(), it calls kmap_atomic() first which
calls preempt_disable(). Thus, in_atomic() == 1. Later, those
cond_resched() would trigger the "sleeping function called from invalid
context" warnings.

Just to refresh the memory, it is quite easy to still reproduce this
today.

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random -x 0-100 -f

[10605.410827][   C34] watchdog: BUG: soft lockup - CPU#34 stuck for 23s! [trinity-c47:134866]
[10605.419192][   C34] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_type1 vfio loop processor ip_tables x_tables sd_mod ahci libahci mlx5_core firmware_class libata dm_mirror dm_region_hash dm_log dm_mod efivarfs
[10605.438424][   C34] irq event stamp: 439794
[10605.442615][   C34] hardirqs last  enabled at (439793): [<ffffa000101d38c4>] el1_irq+0xc4/0x140
[10605.451313][   C34] hardirqs last disabled at (439794): [<ffffa000101d387c>] el1_irq+0x7c/0x140
[10605.460013][   C34] softirqs last  enabled at (439790): [<ffffa000101d1b50>] efi_header_end+0xb50/0x14d4
[10605.469494][   C34] softirqs last disabled at (439783): [<ffffa000102bd898>] irq_exit+0x440/0x510
[10605.478368][   C34] CPU: 34 PID: 134866 Comm: trinity-c47 Not tainted 5.8.0-rc5-next-20200717+ #2
[10605.487236][   C34] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[10605.497669][   C34] pstate: 40400009 (nZcv daif +PAN -UAO BTYPE=--)
[10605.503938][   C34] pc : iov_iter_copy_from_user_atomic+0x640/0xa68
[10605.510208][   C34] lr : generic_perform_write+0x24c/0x370
[10605.515691][   C34] sp : ffff008921b57580
[10605.519697][   C34] x29: ffff008921b57580 x28: 0000000000000000
[10605.525712][   C34] x27: dfffa00000000000 x26: ffff00895cbe6500
[10605.531726][   C34] x25: 0000000000000000 x24: 0000000000000003
[10605.537740][   C34] x23: ffff008921b57b90 x22: 0000000000000000
[10605.543754][   C34] x21: 0000000000000000 x20: 0000000000000004
[10605.549769][   C34] x19: ffff000c5e817d39 x18: 0000000000000000
[10605.555782][   C34] x17: 0000000000000000 x16: 0000000000000000
[10605.561796][   C34] x15: 0000000000000000 x14: 1fffe0112436ae4a
[10605.567809][   C34] x13: ffff8012adcac617 x12: 1fffe012adcac616
[10605.573823][   C34] x11: 1fffe012adcac616 x10: ffff8012adcac616
[10605.579838][   C34] x9 : dfffa00000000000 x8 : ffff00956e5630b7
[10605.585852][   C34] x7 : ffff80112436af75 x6 : ffff8012adcac617
[10605.591865][   C34] x5 : 0000000000000000 x4 : 0000000000000004
[10605.597886][   C34] x3 : ffff00895cbe6500 x2 : 1fffe0112b97cca1
[10605.603926][   C34] x1 : 0000000000000007 x0 : ffff00895cbe650c
[10605.609941][   C34] Call trace:
[10605.613083][   C34]  iov_iter_copy_from_user_atomic+0x640/0xa68
[10605.619003][   C34]  generic_perform_write+0x24c/0x370
[10605.624140][   C34]  __generic_file_write_iter+0x280/0x428
[10605.629624][   C34]  generic_file_write_iter+0x2a4/0x8e0
[10605.634936][   C34]  do_iter_readv_writev+0x348/0x590
[10605.639986][   C34]  do_iter_write+0x124/0x468
[10605.644428][   C34]  vfs_iter_write+0x54/0x98
[10605.648786][   C34]  iter_file_splice_write+0x4a0/0x860
[10605.654009][   C34]  do_splice_from+0x60/0x120
[10605.658452][   C34]  do_splice+0x7ac/0x1310
[10605.662633][   C34]  __arm64_sys_splice+0x118/0x1e0
[10605.667510][   C34]  do_el0_svc+0x124/0x228
[10605.671693][   C34]  el0_sync_handler+0x260/0x410
[10605.676395][   C34]  el0_sync+0x140/0x180
[10648.198030][   C34] rcu: INFO: rcu_sched self-detected stall on CPU
[10648.204756][   C34] rcu: 	34-....: (6472 ticks this GP) idle=666/1/0x4000000000000002 softirq=36485/36485 fqs=1901
[10648.216008][   C34] 	(t=6501 jiffies g=587637 q=293554)
[10648.221240][   C34] Task dump for CPU 34:
[10648.225248][   C34] trinity-c47     R  running task    25856 134866 106496 0x00000007
[10648.233097][   C34] Call trace:
[10648.236245][   C34]  dump_backtrace+0x0/0x398
[10648.240603][   C34]  show_stack+0x14/0x20
[10648.244615][   C34]  sched_show_task+0x498/0x608
[10648.249232][   C34]  dump_cpu_task+0xcc/0xdc
[10648.253503][   C34]  rcu_dump_cpu_stacks+0x248/0x294
[10648.258467][   C34]  rcu_sched_clock_irq+0x12f4/0x1998
[10648.263606][   C34]  update_process_times+0x2c/0x90
[10648.268484][   C34]  tick_sched_handle+0x68/0x120
[10648.273187][   C34]  tick_sched_timer+0x60/0x128
[10648.277802][   C34]  __hrtimer_run_queues+0x7b4/0x1388
[10648.282940][   C34]  hrtimer_interrupt+0x284/0x640
[10648.287732][   C34]  arch_timer_handler_phys+0x48/0x68
[10648.292871][   C34]  handle_percpu_devid_irq+0x248/0xde0
[10648.298194][   C34]  generic_handle_irq+0x74/0xa0
[10648.302907][   C34]  __handle_domain_irq+0xa0/0x160
[10648.307784][   C34]  gic_handle_irq+0xc0/0x1a0
[10648.312227][   C34]  el1_irq+0xbc/0x140
[10648.316064][   C34]  iov_iter_copy_from_user_atomic+0x668/0xa68
[10648.321984][   C34]  generic_perform_write+0x24c/0x370
[10648.327121][   C34]  __generic_file_write_iter+0x280/0x428
[10648.332605][   C34]  generic_file_write_iter+0x2a4/0x8e0
[10648.337916][   C34]  do_iter_readv_writev+0x348/0x590
[10648.342966][   C34]  do_iter_write+0x124/0x468
[10648.347407][   C34]  vfs_iter_write+0x54/0x98
[10648.351764][   C34]  iter_file_splice_write+0x4a0/0x860
[10648.356987][   C34]  do_splice_from+0x60/0x120
[10648.361430][   C34]  do_splice+0x7ac/0x1310
[10648.365611][   C34]  __arm64_sys_splice+0x118/0x1e0
[10648.370489][   C34]  do_el0_svc+0x124/0x228
[10648.374672][   C34]  el0_sync_handler+0x260/0x410
[10648.379374][   C34]  el0_sync+0x140/0x180

[10718.696867][ T1302] INFO: task trinity-c44:135125 blocked for more than 123 seconds.
[10718.704644][ T1302]       Tainted: G             L    5.8.0-rc5-next-20200717+ #2
[10718.712163][ T1302] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10718.720728][ T1302] trinity-c44     D25760 135125      1 0x00000001
[10718.727040][ T1302] Call trace:
[10718.730222][ T1302]  __switch_to+0x1a0/0x258
[10718.734496][ T1302]  __schedule+0x770/0x18d0
[10718.738804][ T1302]  schedule+0x1e4/0x3e8
[10718.742824][ T1302]  rwsem_down_write_slowpath+0x80c/0xe28
[10718.748359][ T1302]  down_write+0x208/0x230
[10718.752547][ T1302]  generic_file_write_iter+0xd0/0x8e0
[10718.757774][ T1302]  do_iter_readv_writev+0x348/0x590
[10718.762864][ T1302]  do_iter_write+0x124/0x468
[10718.767311][ T1302]  vfs_writev+0x15c/0x250
[10718.771543][ T1302]  do_pwritev+0x128/0x160
[10718.775732][ T1302]  __arm64_sys_pwritev+0x88/0xc8
[10718.780561][ T1302]  do_el0_svc+0x124/0x228
[10718.784749][ T1302]  el0_sync_handler+0x260/0x410
[10718.789491][ T1302]  el0_sync+0x140/0x180

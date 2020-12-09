Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263A22D4D28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 22:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbgLIVzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 16:55:23 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50118 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLIVzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:55:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7Q1-001gO4-Ci; Wed, 09 Dec 2020 14:54:41 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7Q0-00025k-Im; Wed, 09 Dec 2020 14:54:41 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Yahu Gao <yahu.gao@windriver.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201209112100.47653-1-yahu.gao@windriver.com>
Date:   Wed, 09 Dec 2020 15:54:02 -0600
In-Reply-To: <20201209112100.47653-1-yahu.gao@windriver.com> (Yahu Gao's
        message of "Wed, 9 Dec 2020 19:20:59 +0800")
Message-ID: <87zh2mprwl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kn7Q0-00025k-Im;;;mid=<87zh2mprwl.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+8DidLiK3xuGsZRPuNCOhwUzv0QdyZRiI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_12,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4964]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Yahu Gao <yahu.gao@windriver.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 465 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.6 (1.0%), b_tie_ro: 3.2 (0.7%), parse: 1.14
        (0.2%), extract_message_metadata: 12 (2.6%), get_uri_detail_list: 3.3
        (0.7%), tests_pri_-1000: 4.0 (0.9%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 81 (17.4%), check_bayes:
        79 (17.1%), b_tokenize: 8 (1.6%), b_tok_get_all: 12 (2.6%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 54 (11.6%), b_finish: 0.73
        (0.2%), tests_pri_0: 347 (74.7%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 0.65 (0.1%), tests_pri_10:
        3.0 (0.6%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Review request 0/1: fs/proc: Fix NULL pointer dereference in
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yahu Gao <yahu.gao@windriver.com> writes:

> There is a kernel NULL pointer dereference was found in Linux system.
> The details of kernel NULL is shown at bellow.
>
> Currently, we do not have a way to provoke this fault on purpose, but
> the reproduction rate in out CI loops is high enough that we could go
> for a trace patch in black or white UP and get a reproduction in few
> weeks.
>
> Our kernel version is 4.1.21, but via analyzing the source code of the
> call trace. The upstream version should be affected. Really sorry for
> havn't reproduced this in upstream version. But it's easier to be safe
> than to prove it can't happen, right?

Except I there are strong invariants that suggests that it takes
a memory stomp to get a NULL pointer deference here.

For the life of a proc inode PROC_I(inode)->pid should be non-NULL.

For a non-NULL pid pointer ->tasks[PIDTYPE_PID].first simply reads
an entry out of the struct pid.  Only pid needs to be non-NULL.

So I don't see how you are getting a NULL pointer derference.

Have you decoded the oops, looked at the assembly and seen which field
is NULL?  I expec that will help you track down what is wrong.


> Details of kernel crash:
> ----------------------------------------------------------------------
> [1446.285834] Unable to handle kernel NULL pointer dereference at
> virtual address 00000008
> [ 1446.293943] pgd = e4af0880
> [ 1446.296656] [00000008] *pgd=10cc3003, *pmd=04153003, *pte=00000000
> [ 1446.302898] Internal error: Oops: 207 1 PREEMPT SMP ARM
> [ 1446.302950] Modules linked in: adkNetD ncp
> lttng_ring_buffer_client_mmap_overwrite(C)
> lttng_ring_buffer_client_mmap_discard(C)
> lttng_ring_buffer_client_discard(C)
> lttng_ring_buffer_metadata_mmap_client(C) lttng_probe_printk(C)
> lttng_probe_irq(C) lttng_ring_buffer_metadata_client(C)
> lttng_ring_buffer_client_overwrite(C) lttng_probe_signal(C)
> lttng_probe_sched(C) lttng_tracer(C) lttng_statedump(C)
> lttng_lib_ring_buffer(C) lttng_clock_plugin_arm_cntpct(C) lttng_clock(C)
> [ 1446.302963] CPU: 0 PID: 12086 Comm: netstat Tainted: G C
> 4.1.21-rt13-* #1
> [ 1446.302967] Hardware name: Ericsson CPM1
> [ 1446.302972] task: cbd75480 ti: c4a68000 task.ti: c4a68000
> [ 1446.302984] PC is at pid_delete_dentry+0x8/0x18
> [ 1446.302992] LR is at dput+0x1a8/0x2b4
> [ 1446.303003] pc : [] lr : [] psr: 20070013
> [ 1446.303003] sp : c4a69e88 ip : 00000000 fp : 00000000
> [ 1446.303007] r10: 000218cc r9 : cd228000 r8 : e5f44320
> [ 1446.303011] r7 : 00000001 r6 : 00080040 r5 : c4aa97d0 r4 : c4aa9780
> [ 1446.303015] r3 : 00000000 r2 : cbd75480 r1 : 00000000 r0 : c4aa9780
> [ 1446.303020] Flags: nzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment
> user
> [ 1446.303026] Control: 30c5387d Table: 24af0880 DAC: 000000fd
> [ 1446.303033] Process netstat (pid: 12086, stack limit = 0xc4a68218)
> [ 1446.303039] Stack: (0xc4a69e88 to 0xc4a6a000)
> [ 1446.303052] 9e80: c4a69f70 0000a1c0 c4a69f13 00000002 e5f44320
> cd228000
> [ 1446.303059] 9ea0: 000218cc c0571604 c0a60bcc 00000000 00000000
> 00000000 c4a69f20 c4a69f15
> [ 1446.303065] 9ec0: 00003133 00000002 c4a69f13 00000000 0000001f
> c4a69f70 c35de800 0000007c
> [ 1446.303072] 9ee0: ce2b1c00 cd228000 00000001 c05747b8 c05745cc
> c35de800 0000001f 00000000
> [ 1446.303078] 9f00: 00000004 cd228008 00020000 c05745cc 33000004
> c0400031 c4a68000 00000400
> [ 1446.303086] 9f20: beb78c2c cd228000 c4a69f70 00000000 cd228008
> c0ffca90 c4a68000 00000400
> [ 1446.303103] 9f40: beb78c2c c052cd0c bf08a774 00000400 01480080
> 00008000 cd228000 cd228000
> [ 1446.303114] 9f60: c040f7c8 c4a68000 00000400 c052d22c c052cd8c
> 00000000 00000021 00000000
> [ 1446.303127] 9f80: 01480290 01480280 00007df0 ffffffea 01480060
> 01480060 01480064 b6e424c0
> [ 1446.303143] 9fa0: 0000008d c040f794 01480060 01480064 00000004
> 01480080 00008000 00000000
> [ 1446.303150] 9fc0: 01480060 01480064 b6e424c0 0000008d 01480080
> 01480060 00035440 beb78c2c
> [ 1446.303156] 9fe0: 01480080 beb78160 b6ede59c b6edea3c 60070010
> 00000004 00000000 00000000
> [ 1446.303167] [] (pid_delete_dentry) from [] (dput+0x1a8/0x2b4)
> [ 1446.303176] [] (dput) from [] (proc_fill_cache+0x54/0x10c)
> [ 1446.303189] [] (proc_fill_cache) from []
> (proc_readfd_common+0xd8/0x238)
> [ 1446.303203] [] (proc_readfd_common) from [] (iterate_dir+0x98/0x118)
> [ 1446.303217] [] (iterate_dir) from [] (SyS_getdents+0x7c/0xf0)
> [ 1446.303233] [] (SyS_getdents) from [] (__sys_trace_return+0x0/0x2c)
> [ 1446.303243] Code: e8bd0030 e12fff1e e5903028 e5133020 (e5930008) 

Eric

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADCF4F5FE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiDFNKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiDFNKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:10:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E523009C;
        Tue,  5 Apr 2022 19:28:41 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KY7cr2lkyzBrX0;
        Wed,  6 Apr 2022 10:24:28 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 10:28:37 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <liaochang1@huawei.com>, <tglx@linutronix.de>, <nitesh@redhat.com>,
        <edumazet@google.com>, <clg@kaod.org>, <tannerlove@google.com>,
        <peterz@infradead.org>, <joshdon@google.com>,
        <masahiroy@kernel.org>, <nathan@kernel.org>, <vbabka@suse.cz>,
        <akpm@linux-foundation.org>, <gustavoars@kernel.org>,
        <arnd@arndb.de>, <chris@chrisdown.name>,
        <dmitry.torokhov@gmail.com>, <linux@rasmusvillemoes.dk>,
        <daniel@iogearbox.net>, <john.ogness@linutronix.de>,
        <will@kernel.org>, <dave@stgolabs.net>, <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <heying24@huawei.com>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [RFC 0/3] softirq: Introduce softirq throttling
Date:   Wed, 6 Apr 2022 10:27:46 +0800
Message-ID: <20220406022749.184807-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel check for pending softirqs periodically, they are performed in a
few points of kernel code, such as irq_exit() and __local_bh_enable_ip(),
softirqs that have been activated by a given CPU must be executed on the
same CPU, this characteristic of softirq is always a potentially
"dangerous" operation, because one CPU might be end up very busy while
the other are most idle.

Above concern is proven in a networking user case: recenlty, we
engineer find out the time used for connection re-establishment on
kernel v5.10 is 300 times larger than v4.19, meanwhile, softirq
monopolize almost 99% of CPU. This problem stem from that the connection
between Sender and Receiver node get lost, the NIC driver on Sender node
will keep raising NET_TX softirq before connection recovery. The system
log show that most of softirq is performed from __local_bh_enable_ip(),
since __local_bh_enable_ip is used widley in kernel code, it is very
easy to run out most of CPU, and the user-mode application can't obtain
enough CPU cycles to establish connection as soon as possible.

Although kernel limit the running time of __do_softirq(), it does not
control the running time of entire softirqs on given CPU, so this
patchset introduce a safeguard mechanism that allows the system
administrator to allocate bandwidth for used by softirqs, this safeguard
mechanism is known as Sofitrq Throttling and is controlled by two
parameters in the /proc file system:

/proc/sys/kernel/sofitrq_period_ms
  Defines the period in ms(millisecond) to be considered as 100% of CPU
  bandwidth, the default value is 1,000 ms(1second). Changes to the
  value of the period must be very well thought out, as too long or too
  short are beyond one's expectation.

/proc/sys/kernel/softirq_runtime_ms
  Define the bandwidth available to softirqs on each CPU, the default
  values is 950 ms(0.95 second) or, in other words, 95% of the CPU
  bandwidth. Setting negative integer to this value means that softirqs
  my use up to 100% CPU times.

The default values for softirq throttling mechanism define that 95% of
the CPU time can be used by softirqs. The remaing 5% will be devoted to
other kinds of tasks, such as syscall, interrupt, exception, real-time
processes and normal processes when the softirqs workload in system are
very heavy. System administrator can tune above two parameters to
satifies the need of system performance and stability.

Liao Chang (3):
  softirq: Add two parameters to control CPU bandwidth for use by
    softirq
  softirq: Do throttling when softirqs use up its bandwidth
  softirq: Introduce statistics about softirq throttling

 fs/proc/softirqs.c          |  18 +++++
 include/linux/interrupt.h   |   7 ++
 include/linux/kernel_stat.h |  27 +++++++
 init/Kconfig                |  10 +++
 kernel/softirq.c            | 155 ++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c             |  16 ++++
 6 files changed, 233 insertions(+)

-- 
2.17.1


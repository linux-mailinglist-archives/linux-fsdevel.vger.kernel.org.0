Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DD1D8E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 05:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgESDb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 23:31:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4861 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbgESDbY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 23:31:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D25ACEF918C424D665AA;
        Tue, 19 May 2020 11:31:19 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 11:31:13 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>, <nixiaoming@huawei.com>,
        <gpiccoli@canonical.com>, <rdna@fb.com>, <patrick.bellasi@arm.com>,
        <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <penguin-kernel@i-love.sakura.ne.jp>,
        <vbabka@suse.cz>, <tglx@linutronix.de>, <peterz@infradead.org>,
        <Jisheng.Zhang@synaptics.com>, <khlebnikov@yandex-team.ru>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>
Subject: [PATCH v4 0/4] cleaning up the sysctls table (hung_task watchdog)
Date:   Tue, 19 May 2020 11:31:07 +0800
Message-ID: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel/sysctl.c contains more than 190 interface files, and there are a 
large number of config macro controls. When modifying the sysctl 
interface directly in kernel/sysctl.c, conflicts are very easy to occur.
E.g: https://lore.kernel.org/lkml/99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com/

Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the same time.

So consider cleaning up the sysctls table, details are in:
   https://kernelnewbies.org/KernelProjects/proc
   https://lore.kernel.org/lkml/20200513141421.GP11244@42.do-not-panic.com/#t

The current patch set extracts register_sysctl_init and some sysctl_vals
variables, and clears the interface of hung_task and watchdog in sysctl.c.

The current patch set is based on linux-next, commit 72bc15d0018ebfbc9
("Add linux-next specific files for 20200518").

changes in v4:
  Handle the conflict with the commit d4ee116819ed714f ("kernel/hung_task.c:
  introduce sysctl to print all traces when a hung task is detected"),
  move the sysctl interface hung_task_all_cpu_backtrace to hung_task.c.

V3: https://lore.kernel.org/lkml/1589774397-42485-1-git-send-email-nixiaoming@huawei.com/
  base on commit b9bbe6ed63b2b9 ("Linux 5.7-rc6")
changes in v3:
  1. make hung_task_timeout_max to be const
  2. fix build warning:
     kernel/watchdog.c:779:14: warning: initialization discards 'const'
         qualifier from pointer target type [-Wdiscarded-qualifiers]
         .extra2  = &sixty,
                    ^

V2: https://lore.kernel.org/lkml/1589619315-65827-1-git-send-email-nixiaoming@huawei.com/
changes in v2:
  1. Adjusted the order of patches, first do public function
     extraction, then do feature code movement
  2. Move hung_task sysctl to hung_task.c instead of adding new file
  3. Extract multiple common variables instead of only neg_one, and keep
     the order of member values in sysctl_vals
  4. Add const modification to the variable sixty in watchdog sysctl

V1: https://lore.kernel.org/lkml/1589517224-123928-1-git-send-email-nixiaoming@huawei.com/

Xiaoming Ni (4):
  sysctl: Add register_sysctl_init() interface
  sysctl: Move some boundary constants form sysctl.c to sysctl_vals
  hung_task: Move hung_task sysctl interface to hung_task.c
  watchdog: move watchdog sysctl interface to watchdog.c

 fs/proc/proc_sysctl.c        |   2 +-
 include/linux/sched/sysctl.h |  14 +--
 include/linux/sysctl.h       |  13 ++-
 kernel/hung_task.c           |  77 +++++++++++++++-
 kernel/sysctl.c              | 214 +++++++------------------------------------
 kernel/watchdog.c            | 101 ++++++++++++++++++++
 6 files changed, 224 insertions(+), 197 deletions(-)

-- 
1.8.5.6

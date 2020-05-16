Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE91D5FCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEPIz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 04:55:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgEPIz3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 04:55:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7865712EED413F44AA3F;
        Sat, 16 May 2020 16:55:25 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 16:55:17 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <peterz@infradead.org>, <mingo@kernel.org>,
        <patrick.bellasi@arm.com>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH v2 0/4] cleaning up the sysctls table (hung_task watchdog)
Date:   Sat, 16 May 2020 16:55:11 +0800
Message-ID: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
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
E.g: https://lkml.org/lkml/2020/5/10/413.

Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the same time.

So consider cleaning up the sysctls table, details are in:
	https://kernelnewbies.org/KernelProjects/proc
	https://lkml.org/lkml/2020/5/13/990

The current patch set extracts register_sysctl_init and some sysctl_vals
variables, and clears the interface of hung_task and watchdog in sysctl.c.

changes in v2:
  1. Adjusted the order of patches, first do public function
     extraction, then do feature code movement
  2. Move hung_task sysctl to hung_task.c instead of adding new file
  3. Extract multiple common variables instead of only neg_one, and keep
     the order of member values in sysctl_vals
  4. Add const modification to the variable sixty in watchdog sysctl

V1: https://lkml.org/lkml/2020/5/15/17

Xiaoming Ni (4):
  sysctl: Add register_sysctl_init() interface
  sysctl: Move some boundary constants form sysctl.c to sysctl_vals
  hung_task: Move hung_task sysctl interface to hung_task.c
  watchdog: move watchdog sysctl interface to watchdog.c

 fs/proc/proc_sysctl.c        |   2 +-
 include/linux/sched/sysctl.h |   8 +-
 include/linux/sysctl.h       |  13 ++-
 kernel/hung_task.c           |  63 +++++++++++++-
 kernel/sysctl.c              | 202 ++++++++-----------------------------------
 kernel/watchdog.c            | 101 ++++++++++++++++++++++
 6 files changed, 210 insertions(+), 179 deletions(-)

-- 
1.8.5.6


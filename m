Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0777C1D44A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 06:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgEOEd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 00:33:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4845 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbgEOEd4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 00:33:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 212CB54EA7F1D3547B1B;
        Fri, 15 May 2020 12:33:53 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 12:33:47 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH 0/4] Move the sysctl interface to the corresponding feature code file
Date:   Fri, 15 May 2020 12:33:40 +0800
Message-ID: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the same time.

Here, the sysctl interfaces of hung task and watchdog are moved to the
corresponding feature code files

https://lkml.org/lkml/2020/5/11/1419

Xiaoming Ni (4):
  hung_task: Move hung_task syscl interface to hung_task_sysctl.c
  proc/sysctl: add shared variables -1
  watchdog: move watchdog sysctl to watchdog.c
  sysctl: Add register_sysctl_init() interface

 fs/proc/proc_sysctl.c        |   2 +-
 include/linux/sched/sysctl.h |   8 +--
 include/linux/sysctl.h       |   3 +
 kernel/Makefile              |   4 +-
 kernel/hung_task.c           |   6 +-
 kernel/hung_task.h           |  21 ++++++
 kernel/hung_task_sysctl.c    |  66 +++++++++++++++++
 kernel/sysctl.c              | 168 ++++++-------------------------------------
 kernel/watchdog.c            | 101 ++++++++++++++++++++++++++
 9 files changed, 219 insertions(+), 160 deletions(-)
 create mode 100644 kernel/hung_task.h
 create mode 100644 kernel/hung_task_sysctl.c

-- 
1.8.5.6


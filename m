Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D247E347
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348309AbhLWMad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:30:33 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:31347 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348299AbhLWMab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:30:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V.XmPDo_1640262604;
Received: from AliYun.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0V.XmPDo_1640262604)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 20:30:18 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     adobriyan@gmail.com, CruzZhao@linux.alibaba.com,
        joshdon@google.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Forced idle time accounting per cpu
Date:   Thu, 23 Dec 2021 20:30:01 +0800
Message-Id: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Josh Don's patch 4feee7d12603 ("sched/core: Forced idle accounting")
provides one means to measure the cost of enabling core scheduling
from the perspective of the task, and this patchset provides another
means to do that from the perspective of the cpu.

Forced idle can be divided into two types, forced idle with cookie'd task
running on it SMT sibling, and forced idle with uncookie'd task running
on it SMT sibling, which should be accounting to measure the cost of
enabling core scheduling too. This patchset accounts both and the sum
of both, which are displayed via /proc/stat.

Cruz Zhao (2):
  sched/core: Cookied forceidle accounting per cpu
  sched/core: Uncookied force idle accounting per cpu

 fs/proc/stat.c              | 26 ++++++++++++++++++++++++++
 include/linux/kernel_stat.h |  4 ++++
 kernel/sched/core.c         |  7 +++----
 kernel/sched/core_sched.c   | 21 +++++++++++++++++++--
 kernel/sched/sched.h        | 10 ++--------
 5 files changed, 54 insertions(+), 14 deletions(-)

base commit: 2850c2311ef4bf30ae8dd8927f0f66b026ff08fb
-- 
1.8.3.1


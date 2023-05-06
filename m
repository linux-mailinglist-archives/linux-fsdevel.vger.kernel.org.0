Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABE06F91B8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 13:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjEFLwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 07:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjEFLwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 07:52:12 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 May 2023 04:52:09 PDT
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 241AF559E;
        Sat,  6 May 2023 04:52:08 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.71.35])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 4FDF311004C019;
        Sat,  6 May 2023 19:50:03 +0800 (CST)
Received: from localhost.localdomain (10.79.64.102) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 6 May 2023 19:50:02 +0800
X-MD-Sfrom: chengkaitao@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From:   chengkaitao <chengkaitao@didiglobal.com>
To:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <corbet@lwn.net>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <akpm@linux-foundation.org>,
        <brauner@kernel.org>, <muchun.song@linux.dev>
CC:     <viro@zeniv.linux.org.uk>, <zhengqi.arch@bytedance.com>,
        <ebiederm@xmission.com>, <Liam.Howlett@Oracle.com>,
        <chengzhihao1@huawei.com>, <pilgrimtao@gmail.com>,
        <haolee.swjtu@gmail.com>, <yuzhao@google.com>,
        <willy@infradead.org>, <vasily.averin@linux.dev>, <vbabka@suse.cz>,
        <surenb@google.com>, <sfr@canb.auug.org.au>, <mcgrof@kernel.org>,
        <sujiaxun@uniontech.com>, <feng.tang@intel.com>,
        <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, chengkaitao <chengkaitao@didiglobal.com>
Subject: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Date:   Sat, 6 May 2023 19:49:46 +0800
Message-ID: <20230506114948.6862-1-chengkaitao@didiglobal.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.79.64.102]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Establish a new OOM score algorithm, supports the cgroup level OOM
protection mechanism. When an global/memcg oom event occurs, we treat
all processes in the cgroup as a whole, and OOM killers need to select
the process to kill based on the protection quota of the cgroup

Changelog:
v3:
  * Add "auto" option for memory.oom.protect. (patch 1)
  * Fix division errors. (patch 1)
  * Add observation indicator oom_kill_inherit. (patch 2)
v2:
  * Modify the formula of the process request memcg protection quota.
  https://lore.kernel.org/linux-mm/20221208034644.3077-1-chengkaitao@didiglobal.com/
v1:
  https://lore.kernel.org/linux-mm/20221130070158.44221-1-chengkaitao@didiglobal.com/

chengkaitao (2):
  mm: memcontrol: protect the memory in cgroup from being oom killed
  memcg: add oom_kill_inherit event indicator

 Documentation/admin-guide/cgroup-v2.rst |  29 ++++-
 fs/proc/base.c                          |  17 ++-
 include/linux/memcontrol.h              |  46 +++++++-
 include/linux/oom.h                     |   3 +-
 include/linux/page_counter.h            |   6 +
 mm/memcontrol.c                         | 199 ++++++++++++++++++++++++++++++++
 mm/oom_kill.c                           |  25 ++--
 mm/page_counter.c                       |  30 +++++
 8 files changed, 334 insertions(+), 21 deletions(-)

-- 
2.14.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1E45AD42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbhKWU1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhKWU1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:27:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A56C061714;
        Tue, 23 Nov 2021 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LsdQh4HqQoMJXPGLYj8yYlIsoChkuC5wVNntCTfBftk=; b=h8BC2u6vRKXSRxvyWOJ/CuPBMl
        pIMmzsBkBq+U5A3CprBtG9sifq8YX0dAenDw0pbjY1ctdze5VWgkkHsfNbWYneVVDGmpOd45Rwlm0
        QBtIgy+s1+2I5vKipG9kho3v13a0MhxNC6sSf7gDtemA5qkGvPwMWNXGmoB03GlGWi/oAvOG3MbeU
        vkyS15Vc4xlPRGosQ5oBSa5BSVFy0Bem3TS7FBl+10HU9uAmHPufRVFgXMp+KDlwxcOMaZ6qB/SNY
        jQ+6zKtLAiXG26jL0W2dcc5uQWzYB9PnX/l/QHzzwAbbmM6d0ExuR9JLpAwwre7yKn1UY1yuxSb2z
        odIvZJHA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpcKS-003Qqq-2g; Tue, 23 Nov 2021 20:23:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/9] sysctl: first set of kernel/sysctl cleanups
Date:   Tue, 23 Nov 2021 12:23:38 -0800
Message-Id: <20211123202347.818157-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Finally had time to respin the series of the work we had started
last year on cleaning up the kernel/sysct.c kitchen sink. People keeps
stuffing their sysctls in that file and this creates a maintenance
burden. So this effort is aimed at placing sysctls where they actually
belong.

I'm going to split patches up into series as there is quite a bit
of work.

This first set adds register_sysctl_init() for uses of registerting a
sysctl on the init path, adds const where missing to a few places, generalizes
common values so to be more easy to share, and starts the move of a
few kernel/sysctl.c out where they belong.

The majority of rework on v2 in this first patch set is 0-day fixes.
Eric W. Biederman's feedback is later addressed in subsequent patch
sets.

I'll only post the first two patch sets for now. We can address the
rest once the first two patch sets get completely reviewed / Acked.
Since the sysctls are all over the place I can either put up a tree
to keep track of these changes and later send a pull request to Linus
or we can have them trickle into Andrew's tree. Let me know what folks
prefer.

Changes in v2:

  * 0-day compile issues
  * added reviewed-by tags
  * enhanced commit logs
  * Added patch by Stephen Kitt

Stephen Kitt (1):
  sysctl: make ngroups_max const

Xiaoming Ni (8):
  sysctl: add a new register_sysctl_init() interface
  sysctl: Move some boundary constants from sysctl.c to sysctl_vals
  hung_task: Move hung_task sysctl interface to hung_task.c
  watchdog: move watchdog sysctl interface to watchdog.c
  sysctl: use const for typically used max/min proc sysctls
  sysctl: use SYSCTL_ZERO to replace some static int zero uses
  aio: move aio sysctl to aio.c
  dnotify: move dnotify sysctl to dnotify.c

 fs/aio.c                     |  31 +++-
 fs/notify/dnotify/dnotify.c  |  21 ++-
 fs/proc/proc_sysctl.c        |  35 ++++-
 include/linux/aio.h          |   4 -
 include/linux/dnotify.h      |   1 -
 include/linux/sched/sysctl.h |  14 +-
 include/linux/sysctl.h       |  15 +-
 kernel/hung_task.c           |  81 +++++++++-
 kernel/sysctl.c              | 285 ++++++-----------------------------
 kernel/watchdog.c            | 101 +++++++++++++
 10 files changed, 322 insertions(+), 266 deletions(-)

-- 
2.33.0


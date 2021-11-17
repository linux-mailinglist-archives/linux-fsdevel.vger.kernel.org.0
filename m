Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FD04545DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 12:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhKQLqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 06:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbhKQLqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:46:43 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E05C061746
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 03:43:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 28so1994598pgq.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 03:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSiNYAfrwC6aXcWj4FsC+gepRV/DukgxF28JUpxZyAc=;
        b=AmtVK3x4VL/s1O1CkkVDVVmGkBx+Yg2THamoc9AkDd9NdvHLuGFcvCPueMhDGaRlBT
         RVc7tg8eFQlAUGx8pG2B7CrHEpjdx8yZ5UKf0VBFGFwFG4eNOwB+tXgt/8weHbulTzD0
         wKJElBf+qDCq5fVrbuJ/ItzoI4W9w6hdkyG1p9I2Y79JENB3BW9B425KLRB9mxXNT/tP
         Qx+ORnd5e5L+3yf5+u6KYusFCWlD3Bj/uvFJZlKmySHHUscPu76KVz+KAVl08AgJkIsh
         mbiwhyLGz4DfHGuOrk9DJ6yZB1bze6xYXHUwfeNx4mQlKOe0W+pEYbbPPVXh0qOWxh+d
         xG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tSiNYAfrwC6aXcWj4FsC+gepRV/DukgxF28JUpxZyAc=;
        b=R+0F9oKTSqRVqY6pm27iAGFqSckeqAiuhda+9HwCwnuwcjjcRClDZrsxioyKLQAl7S
         9aTL2JhCC9kwsANjwgHU7TQlUVpFPzfu9pOP1ddhypo6x7oKNAYh4RZh6oOBHKGuJEFd
         xb4zU0FEw7BGfR3HIFYRTr7u2uCXTpPe8qsSEZuKqGXaEs3hmVIdVpvPUXn0sb81ry5D
         rExt00+/fvwL7GS0Htm0/qWR4+/d6VyPujQeJIswjPnT9GDOoGI2kp8bnQpVtaiomnsX
         Qt7LFPFB8hoxtgoqSmIQ5QLjTpvMr8EqwJA1WzPfGbhW4OXQlBLBqGndyJojTT8lmuw9
         HMnA==
X-Gm-Message-State: AOAM5318Roh3BMKe4+0R8RpzoMa/fUzWOwO+uiyf3rxkTqq5YW01OXGb
        DNmCxGQ4FpggniB+sij385ZDwW9uGPoT7Q==
X-Google-Smtp-Source: ABdhPJytnBk6HAadXIg91k2YAuS50If7tkag3Qx1x7euh5JYXUj7vg/7E8pqI+FFHPoyIBooRtnkVQ==
X-Received: by 2002:a05:6a00:234a:b0:49f:c0f7:f474 with SMTP id j10-20020a056a00234a00b0049fc0f7f474mr6546890pfj.64.1637149425131;
        Wed, 17 Nov 2021 03:43:45 -0800 (PST)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id hg4sm5110582pjb.1.2021.11.17.03.43.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Nov 2021 03:43:44 -0800 (PST)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH]  fuse: disable some features for readonly mount
Date:   Wed, 17 Nov 2021 19:43:12 +0800
Message-Id: <20211117114312.36445-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

auto_inval_data and parallel_dirops features are not necessary
for read-only mount.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 36cd03114b6d..de9e15091715 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1109,7 +1109,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if (arg->flags & FUSE_DONT_MASK)
 				fc->dont_mask = 1;
 			if (arg->flags & FUSE_AUTO_INVAL_DATA)
-				fc->auto_inval_data = 1;
+				fc->auto_inval_data = sb_rdonly(fm->sb) ? 0 : 1;
 			else if (arg->flags & FUSE_EXPLICIT_INVAL_DATA)
 				fc->explicit_inval_data = 1;
 			if (arg->flags & FUSE_DO_READDIRPLUS) {
@@ -1122,7 +1122,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if (arg->flags & FUSE_WRITEBACK_CACHE)
 				fc->writeback_cache = 1;
 			if (arg->flags & FUSE_PARALLEL_DIROPS)
-				fc->parallel_dirops = 1;
+				fc->parallel_dirops = sb_rdonly(fm->sb) ? 0 : 1;
 			if (arg->flags & FUSE_HANDLE_KILLPRIV)
 				fc->handle_killpriv = 1;
 			if (arg->time_gran && arg->time_gran <= 1000000000)
-- 
2.27.0


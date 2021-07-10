Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4739D3C34DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jul 2021 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhGJOm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jul 2021 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhGJOm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jul 2021 10:42:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278AC0613DD;
        Sat, 10 Jul 2021 07:40:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d12so11627482pfj.2;
        Sat, 10 Jul 2021 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yimJR30/m003w+X6EtV4f+C8eFTWX5UIfbOmwRmtQs=;
        b=PxAEsun23B3n5dHrbV5KgjU5Fhef1rxdLf16NZHBKGQmPot9TNxOWeR/nL79VFkgbt
         ZtddKv54iqib5p+KkB/l11LbmrwwDmR+Hxm3V32BlpnS+V85gcPib8M/yxYGBwE6sFR0
         wmgcos1NZjbIM+yagFzoE+SZ3BLBtVLGmyEeJGpdOC6T4AELNpnETF9kWeE/A/VB9k5D
         C1lEQg3p1kuAWLZ36UfOdjM/+7iQZzhAvmCguDbUOTLoafUeaITb865if/bVBCjtaFHe
         /0SS31+pyk+w94eda9BTwkap4w0GkIJjXp6IUAM8L0dbdP/5QKCxNq9iBec5S3KLy8T8
         Zhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yimJR30/m003w+X6EtV4f+C8eFTWX5UIfbOmwRmtQs=;
        b=qpgtyz78nHY61rySV2+b1o7NiLQrDxEIhbrn4ipWasnV1qHhcu6i3EQpaKPlWhjIIn
         PDPxZNesWOYUOLR+7Jc0vg8uFovOygMDMsTElqxf3RRAmBCBGjz01izZIJR1X43kXZKM
         Y+xIrBnI+PPEDKbFQaXd8zmuOgpSZ/CXAZvjtKxxCzXBAl2C+M9v/xHviCeBBoWeuqcb
         UtUu1W4oHI4rDp1M65odOU8xA1enFJAzl+61cv+a30gvj3znz+LTPKCg1PgbEwaUr1Vv
         tjwRQbJdb3Q8Om8FHmhDx8CcA/zqIQBBysSt753F0OULNZTSSE5E4ycY1U5qIAkprZSR
         NiKg==
X-Gm-Message-State: AOAM530eImyH1udTgMK64eQQHqWG6VgTbO7/XkpVYmMQ/v4HUGp1/czY
        dGvy2aFw+L7IS6ZglGcwtttYAVzif2vcwn8v
X-Google-Smtp-Source: ABdhPJwWoLk6xMEbLIO8DZJApSRhwgvnHfI8HTsI8CKg34R4XD36Y42oIQFO7/h6kQjmLV2d6lq9Pg==
X-Received: by 2002:a05:6a00:a8a:b029:30c:a10b:3e3f with SMTP id b10-20020a056a000a8ab029030ca10b3e3fmr43492003pfl.40.1625928011764;
        Sat, 10 Jul 2021 07:40:11 -0700 (PDT)
Received: from localhost.localdomain ([114.99.217.112])
        by smtp.gmail.com with ESMTPSA id v25sm10860513pga.35.2021.07.10.07.40.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jul 2021 07:40:11 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Wang Shilong <wshilong@ddn.com>
Subject: [PATCH v4] fs: forbid invalid project ID
Date:   Sat, 10 Jul 2021 22:39:59 +0800
Message-Id: <20210710143959.58077-1-wangshilong1991@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

fileattr_set_prepare() should check if project ID
is valid, otherwise dqget() will return NULL for
such project ID quota.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v3->v3:
only check project Id if caller is allowed
to change and being changed.

v2->v3: move check before @fsx_projid is accessed
and use make_kprojid() helper.

v1->v2: try to fix in the VFS
 fs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..d4fabb5421cd 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -817,6 +817,14 @@ static int fileattr_set_prepare(struct inode *inode,
 		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
 				FS_XFLAG_PROJINHERIT)
 			return -EINVAL;
+	} else {
+		/*
+		 * Caller is allowed to change the project ID. If it is being
+		 * changed, make sure that the new value is valid.
+		 */
+		if (old_ma->fsx_projid != fa->fsx_projid &&
+		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
+			return -EINVAL;
 	}
 
 	/* Check extent size hints. */
-- 
2.27.0


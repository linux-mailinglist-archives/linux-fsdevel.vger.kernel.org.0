Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13F63BA1E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhGBOFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 10:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhGBOFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 10:05:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C441C061762;
        Fri,  2 Jul 2021 07:02:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d12so9040154pfj.2;
        Fri, 02 Jul 2021 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpNCCXMrKGyrqYi31MT+GevEnuDdqsiRqNjPGny1C78=;
        b=pfjQMUJqoWM4kGrC6B/jmlpPPFpiCl59qw3Zdobsq+Ysg8679Tjas1UIR1IxYx6SpO
         hx9HxH3s7Jp/kTqTwTRop5PkWg+ER3+ayMi5uKXHytCNQ8rZfoQVqLY1vTuIyROLQFEl
         NR8pcxuTvBgRbx++JdZx/VB9AjmLgwind36k49RT42bzYAxKJZpYqe29enKRgK4tkyRr
         mnH1XNod4sX6YRCb2n0VSZFVgqHlkl2EHuzLR3uC8wJ4wrbO5KrQGOHYvjaCkYQDdG9x
         ZPQQ2gPo+/SoRKYQ3RNzqqMDej83ajJCr5erpfSHX4dN18k7bupUpWFJAZWiMkhXXAqP
         3dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpNCCXMrKGyrqYi31MT+GevEnuDdqsiRqNjPGny1C78=;
        b=Fk+g2QrKndw9JnGFHVElxid8rDFsx/rO1RcDP3Cl9YS7NMtMBUo8R5yaJW+TS7XGQI
         0zKuNg9UWFqx2Egj66QyqercZniL2A1FWHoGVHPg5kekoZvJI8jJLlPJEDBfMMSFZjiC
         EALYA+Ere5AnsYBckJ2ZUm9Urt9Rc0lKuHLznZKal64vHftsrlZ7hi4Ii/ukq4E/XpI2
         14QxM51XbqyMZ5Yii455XdhWGUfy+5VBExCqJSZaiYKhJsSE1vOiG2PS5NGl9XXyI5s7
         eIZ6P83T/jZEoeKy5QRWLTZISmLWWZPwhgb+S+2bWfhO2RdU5rOPP67rwyIIoaYbIfQK
         9xTw==
X-Gm-Message-State: AOAM531cAk+W+0cIuOLDmOYgVqTNs0O4jnInZnsRAf533DPXsl86roWQ
        jY/kxvCL35rlrrE6qUFky0Yea7IKD4JfpZMfat66cYo5
X-Google-Smtp-Source: ABdhPJyKUCADoXCbqFx3cl7qRl/BxbhntTWF1mY+I9dkZf8hzu6/r8r54P+dFV/roUXYEviVXlW/SQ==
X-Received: by 2002:a63:4e4c:: with SMTP id o12mr174831pgl.95.1625234569568;
        Fri, 02 Jul 2021 07:02:49 -0700 (PDT)
Received: from localhost.localdomain ([183.165.208.218])
        by smtp.gmail.com with ESMTPSA id u21sm3563898pfh.163.2021.07.02.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 07:02:49 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v3] fs: forbid invalid project ID
Date:   Fri,  2 Jul 2021 10:02:43 -0400
Message-Id: <20210702140243.3615-1-wangshilong1991@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fileattr_set_prepare() should check if project ID
is valid, otherwise dqget() will return NULL for
such project ID quota.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v2->v3: move check before @fsx_projid is accessed
and use make_kprojid() helper.

v1->v2: try to fix in the VFS
---
 fs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1e2204fa9963..d7edc92df473 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -806,6 +806,8 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (err)
 		return err;
 
+	if (!projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
+		return -EINVAL;
 	/*
 	 * Project Quota ID state is only allowed to change from within the init
 	 * namespace. Enforce that restriction only if we are trying to change
-- 
2.27.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7365A2B84C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgKRTTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgKRTTa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:30 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BDC061A4D
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so2058979pfc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlZlv11RxklRSJqWlFnwra0sdX85prYJ/jAmSAt0T7w=;
        b=XS7pdPT+/PSzyYEKRQkL6sC1Ujnc2RsKA/Bc8a5wng1Ofh5bFe3vfMzquf9OsTYxh4
         R2BsjUX698ORk+wXLNQwCdl5MSvz7YK2xGF4+jrfyy07kErVMaHyhhwZBXCmnzlCpTKg
         U1J/jY0BL7S+6RRDe3XWgREr8brptvhZo0cVnFFRDx1nCejXVzzHdyWMbPQT33YHF4eI
         yyA1Vu3K4ydiZxwNR2WaVSi1ECCuFV6F23LHH6hS+6ET9z8LUaDaUoqAmyoam6RhvCCg
         rbvfQR5j7w+acWofcEz7E2Xvyje5mSV4dBpXr63WVtJNgvIKT0dvXEFEXb5e8HNh+kgz
         ELTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlZlv11RxklRSJqWlFnwra0sdX85prYJ/jAmSAt0T7w=;
        b=O5pctkB9y8LKAQ9gQYxo3ttwsFm3IsU/+BXY7bM1UZV/PX24prWB5tZDQXkeIpkd54
         S+CuqAgjJO7cwIfu0ir4H1znJB9G1NuUqXLZNvZkRA9gKvf5NiWm/lfU+dnav3rB4IlE
         CtRHi2zf7sa1vf0nWvSBRYj7x/Gs5nercJHvZIndeeHeGaMNFBQRhR+Rc7uYEnLj3Aev
         /DZhLSxaZP1DDnaZQxio3KcGGH/RgXjV1ZwIPUVifPaDHyWxDhEhjal1SMALmZj2dsKA
         uN9c4xjk+e8Y/Tc5bjA1lFrrj5GcJbF/LhrG4kJQ0ln592HmXZ/6IFgB6alcRMatI1R4
         mEeQ==
X-Gm-Message-State: AOAM531Di4XoHUSkaBcgv6UH1VseqGuUt9NfDG4XP/+QZdY7zhrC7ODF
        bOCwF6BfG14uisKYlQc3nUryGw==
X-Google-Smtp-Source: ABdhPJzvRG4XF5j1xk4Nqrsni3oqzZ3ncomfE9kYtmbBgT+DGsI/BSV1m/HtrVoALYlDRBR/XGbI0Q==
X-Received: by 2002:a63:7a51:: with SMTP id j17mr9271233pgn.186.1605727168499;
        Wed, 18 Nov 2020 11:19:28 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:27 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 5/5] btrfs: send: enable support for stream v2 and compressed writes
Date:   Wed, 18 Nov 2020 11:18:52 -0800
Message-Id: <836f1fbe6112ab89c6f592faaaea0dddb24fb8fe.1605723600.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that the new support is implemented, allow the ioctl to accept the
flags and update the version in sysfs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            | 10 +++++++++-
 fs/btrfs/send.h            |  2 +-
 include/uapi/linux/btrfs.h |  4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4d5cd90f4ef3..4b62bdbfbee0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -670,7 +670,10 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2)
+		hdr.version = cpu_to_le32(2);
+	else
+		hdr.version = cpu_to_le32(1);
 
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
@@ -7434,6 +7437,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		ret = -EINVAL;
 		goto out;
 	}
+	if ((arg->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
+	    !(arg->flags & BTRFS_SEND_FLAG_STREAM_V2)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	sctx = kzalloc(sizeof(struct send_ctx), GFP_KERNEL);
 	if (!sctx) {
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 9f4f7b96b1eb..9c83e14a43b2 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -10,7 +10,7 @@
 #include "ctree.h"
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
-#define BTRFS_SEND_STREAM_VERSION 1
+#define BTRFS_SEND_STREAM_VERSION 2
 
 /*
  * In send stream v1, no command is larger than 64k. In send stream v2, no limit
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 51e69f28d22d..6f29c456e4d7 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -785,7 +785,9 @@ struct btrfs_ioctl_received_subvol_args {
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-	 BTRFS_SEND_FLAG_OMIT_END_CMD)
+	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
+	 BTRFS_SEND_FLAG_STREAM_V2 | \
+	 BTRFS_SEND_FLAG_COMPRESSED)
 
 struct btrfs_ioctl_send_args {
 	__s64 send_fd;			/* in */
-- 
2.29.2


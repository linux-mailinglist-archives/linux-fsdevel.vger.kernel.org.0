Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFDC300E97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbhAVVKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbhAVUxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:53:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8FDC0698D3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my11so6899782pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHS144DxLbBMpm965BQLT7zCwBiEuqsfigSMglTrs0I=;
        b=VfGysgsvrue0+3LQNRCUg+NcyLTA13X5zLrIvchmLAMCkBiPfUgnFSEvCoYc2xTsUD
         hK6Wfo1YDgwp7fRN+5davLhgmNJ7CZ4771kF/bWvDL9Rn0R+icDso+Jeqh2zw+MZJP+s
         CvOdP1Wat8pHJ5IcZlICIZkpViatpKV2Pz4RtNSGTBtBvEVnWRTrNViXE94PcZ1YEbem
         y/+dCaWWsXOlq29NJho6EJr6qH9PbEDtJKP8SFgCkp6/m1Ud3kL7Rz6Pjx3+GM+SX4jf
         YY+s266bOqAvu4jKPhiXlC5qMiRCSAcDd9AW771izjfoS6CZWIIC7R75smQQG9gt3yjs
         jyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHS144DxLbBMpm965BQLT7zCwBiEuqsfigSMglTrs0I=;
        b=WzvsN/hmtfp/4fI6EyvW39ok6uLMQIbIteavp5rtM/XBOCswmluwB1I+dBVHvAqGvd
         PCpPE64LVufKWyFUj1L+ygKQi5YjrhA1l/FrqiQN31uY7gxDDxG0JpuCABaD2gagmBfi
         jnjoQBurQde/tuEnoEyEn+YqtCukIjAdGnV8DUOOa7qmrfBsnia8aW0TS0j2KmqJlzTN
         Pqwx3eC5zI+fgM8cvOfKYoqcxvsfzhGfim/GYydmbA+9LGpiRt3WfyasyixG3EUKQrZ9
         7rvmPYVryEhHc3BoO6537+Yol7voW7ILF8zjvLv4Yv2UHGXWKwUOpTOsRLC+JtvuzGrg
         XOnQ==
X-Gm-Message-State: AOAM530xwHrBCOwVjlTTFmvmZqxE332xKuPWgbih5Lvh/WzUXqc4gQyr
        LQdeJvH30/YS277q6j3Godf5Thhur6hqOQ==
X-Google-Smtp-Source: ABdhPJzFXbgDRARyE4owNTTt/BocEaIJ9gaa9aJT7xlJClUZzGX1KC6ZGd9vG0G4mhUGanlObS+bCA==
X-Received: by 2002:a17:902:7481:b029:df:e6bf:7e53 with SMTP id h1-20020a1709027481b02900dfe6bf7e53mr2559651pll.80.1611348519376;
        Fri, 22 Jan 2021 12:48:39 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:37 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 5/5] btrfs: send: enable support for stream v2 and compressed writes
Date:   Fri, 22 Jan 2021 12:47:52 -0800
Message-Id: <d8e787b3ee721d404ac56ed2af65a6bbe06b14c4.1611347187.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
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
index 7516eba701af..cb824d1271fa 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -671,7 +671,10 @@ static int send_header(struct send_ctx *sctx)
 	struct btrfs_stream_header hdr;
 
 	strcpy(hdr.magic, BTRFS_SEND_STREAM_MAGIC);
-	hdr.version = cpu_to_le32(BTRFS_SEND_STREAM_VERSION);
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2)
+		hdr.version = cpu_to_le32(2);
+	else
+		hdr.version = cpu_to_le32(1);
 
 	return write_buf(sctx->send_filp, &hdr, sizeof(hdr),
 					&sctx->send_off);
@@ -7446,6 +7449,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
index 93aa0932234e..b12a9a1a106c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -786,7 +786,9 @@ struct btrfs_ioctl_received_subvol_args {
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
2.30.0


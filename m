Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A67300E7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbhAVUxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbhAVUwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:52:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C6C0698C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g3so3988872plp.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHS144DxLbBMpm965BQLT7zCwBiEuqsfigSMglTrs0I=;
        b=eEe3KzBJ5cBvVQTFc/Fat4nX2EbBqXLkGs10fIv31CgraFSVLOvQ4nDPq7BCySkz87
         +pp73OUQ0pHOxptR0zCs1Ef541bOtFyuwSZ6uzkySCys3RldTYa1HYZf7Rop363g3Q7T
         dIzGL0Xz0ok4Eq5uMjVoXJRvDyFPe5aanvR9G5n/yOGVcK8Pm4pheyn/1q0O462g/nRn
         kRUzvAgZMD0GclNO8FZHNBKn5tWfonGJr0qTKbH6vxjx0bDQzqVHvDCRyjmlM3uLX2nA
         yTsM14xJB+21a6R8QmR9UJXiDMJw7hHZN4lbzkHhggT63+nXNOKu7e0sDE5B/9dM4fU7
         jHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHS144DxLbBMpm965BQLT7zCwBiEuqsfigSMglTrs0I=;
        b=Nm+dNQpJ0XfzcGw21I3Wot7S3jmHs+ZSRiMBfDKJizW0qT8ydpO7b65rL0BhZT9lEy
         7W9IvBOJyeY9Ss9ivuwD4BlkWUlNfAHvkAKCpIWbyDGPU/P4Rr91Q1IJiCkI1lwTRRAI
         UGdflgwvpDntamw5AHjSbh5s8qHB77rBCr+od8tACbAT4RJsFHyd3VgKUEnrHL+2m7j2
         KlTSMqWcp5Lvwcw557ergBvqRrxidXrCW7DlUu+i5RvzKGN/J6J3ARY534V3KFCDLG4B
         Bm0pxVfNkpIPHr30FjwHreWOmfVa8Ua0f78C9GZ/Wk6ezZ0MwL+M9bdd7FgPx4Hib8m+
         ZB7A==
X-Gm-Message-State: AOAM531NX+FWJUoa+xW41oLf5YdAsc8sKstp9NHbqSln++Sdl/BSAWmO
        B9DafS5p31E9RPQe3EPECp7IugLirXKP2g==
X-Google-Smtp-Source: ABdhPJw0CDTLukWVGH2ygrhTfT70j0x9Uu65xoNtFS+yDtbeNYP2KeSbSmofvhiz+rOQCKfzxeNKBA==
X-Received: by 2002:a17:902:c284:b029:df:c0d8:6b7 with SMTP id i4-20020a170902c284b02900dfc0d806b7mr6420291pld.34.1611348476863;
        Fri, 22 Jan 2021 12:47:56 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:55 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 15/15] btrfs: send: enable support for stream v2 and compressed writes
Date:   Fri, 22 Jan 2021 12:47:02 -0800
Message-Id: <faf1a40be59c6ffccdfdfc795b25829baa2a12fe.1611346574.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346574.git.osandov@fb.com>
References: <cover.1611346574.git.osandov@fb.com>
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


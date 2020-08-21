Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF39724CFA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgHUHk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgHUHkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D2C061387
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so466966pjb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHIY7+yv9iDvme5i3eTWSs94I5h2qd9+JUn/jl34owY=;
        b=FfIoIiJ2nK41QK2HVGnMsZpckArAX6hK2ETKBNhWm5hoyst/Q7RMTNJHh2WfQ63bcd
         S+6+0MxY+QR62LAO4H71HSNbmdNU8xJQeTBkhfMtO0sjB4859KDP4ydCpXytu9tEX+uR
         KlHutbcts1KwOzZ9Akiw/tCnxx0dN6DRNNrHXA+VHMKMGPph8T4mq54XeTGqM3Au8Hyj
         T44tD0X4TUpDiYJq1XlKWPFwqKNIqtxrhAc7mUCGcF6hQa1RTpRYxeZoJ5aJcRHN2dod
         heL2bKJq/0QcYONzF46wke951RPk9Y4NqjxvXVeHWoAkScrVXRHJjtgRTxNahr1x0pf0
         0GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHIY7+yv9iDvme5i3eTWSs94I5h2qd9+JUn/jl34owY=;
        b=aVw+gQxEzpTlMTQQMc2HmAnKl/sRr45HAmes4ZBmwEBQQL13fAMt2gb26Kf/4XWNM6
         FqQ4t91iRunoql1waLoso516O0wLFYO0oFyRAeXmH2+4/cyw0puM3KOecZkG1WS38r4x
         zo0y73Jro+1B5v3gC6midwMvvlgFQnkDQdSsl7g4lpIXtVJtkndwuVvfDm4t7wuUV9fg
         CGTBlsLmpTaCGIMeisMwZsuJO7qxUleS6YoA/0a/uSv48oIF3DtcKlizveYyAC+1KInu
         3t0cdwxDpvSZUqt4KluuFxWaChz9EyvL+m0VQHzFzGCL2NWAhm5/zTX/ZExyN/Tr1fWS
         Qe4g==
X-Gm-Message-State: AOAM531p7IMUBd9vPVwdrOfTXY+hlhOKpU6hkp7JKlnv15jC8foFrwKL
        lHVJLS23Amb7CBuOGAqu7Dt84w==
X-Google-Smtp-Source: ABdhPJztre1VZSD47fIOEgc25Ha4Tb12UKVQQ6BZY0AZui9Q3RIoZ2N+y9OZyrxJj4d/4T5SBB64PQ==
X-Received: by 2002:a17:902:c286:: with SMTP id i6mr1373034pld.63.1597995635098;
        Fri, 21 Aug 2020 00:40:35 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:32 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] btrfs: send: enable support for stream v2 and compressed writes
Date:   Fri, 21 Aug 2020 00:39:59 -0700
Message-Id: <b34b944803961595435a34f3c09912830f194e00.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index df6882b3ab2b..e87dea7bd915 100644
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
@@ -7315,6 +7318,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.28.0


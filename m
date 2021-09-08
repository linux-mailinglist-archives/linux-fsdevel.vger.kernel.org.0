Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B091403646
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348212AbhIHIqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 04:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348047AbhIHIqN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:46:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086B9C061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Sep 2021 01:45:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g14so1453980pfm.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wwe+rjNdaZ9BrgbHSNDPxrPsh19tvvXo2SApu0pr7E=;
        b=mwTJvGY+coCvenWkuYpMGsP7SgjeXYgJK4qjX8+N91daMLwDRa//emjb6zoqh5ng5G
         4atpQI/5IYaE+Vieoq2VamzNlM/wzNJu5hmd+z2QMdy8+8ocUviHmXM174tMK+R0ZHCw
         aaFQSlyf621LSZECaayl5cm7P/AsLGxw5j1WXoRN9e8XNuYwqUPO1zr2LLuaNBL0Z5ZN
         84xRg3nqJXU7L6X2t6Gsl5zJuDiV29FqquqVvuCt3c3c1DKS4TmJfg5NBzAxLBzXrVAu
         4BijWizwqdrvsC0Mnwl7L/jrmt7a9asNhNriD3IyRtPtagb2PwE6abSOdw1+n1GWMtYM
         SDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wwe+rjNdaZ9BrgbHSNDPxrPsh19tvvXo2SApu0pr7E=;
        b=ato6RAdFN61uOuTX0YYMcaLaXAfq9+wWHt0HmZehh+KytbJROUFanHbdlRLyNFenY4
         y1Z3SUt1cRl1rgG2b7FGW3dDvwaIYrBl5PvTsvIfc40qp4Sf8hf8lZtQuAqoejGZYm54
         j/HA684IPayOp5cvF23wdOZyB3tc/90h2B04ufu9ML+8UwbtigVT9KhJvQbw/i2EmHMC
         t4/3ffeFdU6o/coEXdw2t1RoSAHMiad63QFFf+Hfusj0fPBYZFnL1n31mvGfgIKOpV5d
         qIFp03J/Bg/GH2KinCq7nophZS27PQUTHPRQIXN2KUWfXj2Fr1L7AECj0h5ASldBp9Cq
         +DPA==
X-Gm-Message-State: AOAM53335t2qgSA932IUmX51WocDzUb7m//OBJAyaWx6e4QXYE/1BNnF
        7zJnQI9Ucufn7pm9M7j0/qbyw6AsnlCrXizW
X-Google-Smtp-Source: ABdhPJxRxCl6pOHfNK2nNCJpzFhDTI3o78ktzUG1JLD64O/mNvkiQ31MyHY5hMtk6HlqEP0zJ9uMNg==
X-Received: by 2002:a65:404d:: with SMTP id h13mr2700630pgp.130.1631090705557;
        Wed, 08 Sep 2021 01:45:05 -0700 (PDT)
Received: from FLYINGPENG-MB0.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id w192sm1528064pfc.82.2021.09.08.01.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 01:45:05 -0700 (PDT)
From:   Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fuse: add a dev ioctl for recovery
Date:   Wed,  8 Sep 2021 16:44:41 +0800
Message-Id: <20210908084441.48476-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a simple read-only file system, as long as the connection
is not broken, the recovery of the user-mode read-only file
system process can be realized by putting the request of the
processing list back into the pending list.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/dev.c             | 31 ++++++++++++++++++++++++++++++-
 include/uapi/linux/fuse.h |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 491c092d427b..9b0f34468494 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2239,7 +2239,7 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	int res;
+	int res = 0;
 	int oldfd;
 	struct fuse_dev *fud = NULL;
 
@@ -2268,6 +2268,35 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			}
 		}
 		break;
+
+	case FUSE_DEV_IOC_RECOVERY:
+	{
+		struct fuse_iqueue *fiq;
+		struct fuse_pqueue *fpq;
+		struct fuse_req *req, *next;
+		LIST_HEAD(recovery);
+		unsigned int i;
+
+		fud = fuse_get_dev(file);
+		fiq = &fud->fc->iq;
+		fpq = &fud->pq;
+
+		spin_lock(&fpq->lock);
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+			list_splice_tail_init(&fpq->processing[i],
+					      &recovery);
+		spin_unlock(&fpq->lock);
+
+		list_for_each_entry_safe(req, next, &recovery, list) {
+			clear_bit(FR_SENT, &req->flags);
+			set_bit(FR_PENDING, &req->flags);
+		}
+
+		spin_lock(&fiq->lock);
+		list_splice(&recovery, &fiq->pending);
+		spin_unlock(&fiq->lock);
+		break;
+	}
 	default:
 		res = -ENOTTY;
 		break;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 36ed092227fa..fc07324efa9d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -923,6 +923,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_RECOVERY		_IOR(FUSE_DEV_IOC_MAGIC+1, 0, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.27.0


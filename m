Return-Path: <linux-fsdevel+bounces-10475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B2584B7BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE028B0D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C87132486;
	Tue,  6 Feb 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDJbeJQ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8273195
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229503; cv=none; b=XGJTnnsDoPnwWjAvbpPlZjPYdKvr90qd7DXjnayciXpFH/YpOJTXsFrmV6Sd5Yt7Ie6d70yXfoOzEuWJZn6FkPbez4Nms++Wb0tFGCgndY7nI7LjnId/I4/oj/Q5k5LQRcpCxEHqbIogdNSDFut+bA5qiBiKLsEEQ8AXoJkj6gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229503; c=relaxed/simple;
	bh=opejIIRYiFOTagPW0g2xr08qna2N3HX9goXTiiuoZWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ff0KMCW1t880GksshgYcsicVhckD0Xm2LsR1/xI8In7RD3zoSXkko1RL+za4k5x0BR9o6fgM+wL8SoM+h+IAy5so07CSoWE632n+QMAdpMQVzjQI5X02GNwXhPd2ogL8ppp0d63bxgB8ARUBkmmaa63mQrEu6yrPhzYs5CWV2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDJbeJQ1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3394b892691so411902f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229500; x=1707834300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1N1OrLMa6t8qMkOD0BLoblqhbOaLOnVx09FMW3MOGg=;
        b=FDJbeJQ1J46Mtd+p22O5DkX0O8ggreSq4fQ+W9swwjbGHTJRdYPXrKStCni60OeMDL
         jO/mPpbG/XOIYWZem82OBKikWPGlBT+APeCJZ3DW9vo27zZkBC+9vgJsGEIrrpSru27o
         YaZUjozoJHrZmGS6h57AHq0qF4k5RBvhh9ez5sVUQ1LRO0OZomcu31E0/HqYej30j2ch
         GL7aTCJFpdLuQabIKhhemXa1NUmDUtSF8sIl4eqGCVNEqQ3OwEhuLz69UJsA8lY2Fbw3
         YY6Nmoo+nd69/x21HKYHiofb/3bwT2kxZKFLWp/buPTCYvwnmxzgvHFswJAy+wz1FyTI
         hBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229500; x=1707834300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1N1OrLMa6t8qMkOD0BLoblqhbOaLOnVx09FMW3MOGg=;
        b=nUKiKnzn3XRFPkf0x8WYiczXY3iH4fSBy70oWlLJYvt8XLfmuDbuZPUeYcmPcs5gIq
         XpCsgmDhQ4kaz3oLcIWf/PwkUnTU43x7kRCB3foCLHRHQwp0hUWwqHpc2ysEea9MDm4m
         Gk82UfCUzTCfPr8Tgbva1FdoL+sGscBnHtkm2HQFBcKGXbn+mpuNfps7GklDKucaG4QP
         8+UvSmPnm6Ol4k7gCZfdRvDVbwRhwUmzEBLZaT++ybTtjIKkG55WgPtWMaw3Xx2tonGS
         AZfswtEKSmZspkjk3bATFAHibbnBrlNTNyNZEvUxYjsiGAD5qmb5WQJMDB3R/AK+ve9u
         AH+A==
X-Gm-Message-State: AOJu0YyMp8IOMzqwPqZZgyrqNqR/GUVt6Mx3TRhcxGlYvGKKSkZpH0o1
	yfqPxQk1Q/3FfV2YN61Tn3yHh6oFyABgDfxHnzbj1TfcQrzmMnjv
X-Google-Smtp-Source: AGHT+IG5XbQiUG2x3bUg/AwmbC3B2SWAlnPh4G1yObQ2zvVMe1rNgPpV56tAgREbgzHfv3SU0h6jTA==
X-Received: by 2002:adf:f585:0:b0:33b:4709:ebf with SMTP id f5-20020adff585000000b0033b47090ebfmr1285062wro.21.1707229500392;
        Tue, 06 Feb 2024 06:25:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU6iHtHrNOLBoh2oVnEdzSfyrPYHgsudOHt1XKC8kOcErbyzCg5KzrJtGIMrSKeG23s8/dFwHiBAjwMnoH7H2106y/w3abfhTpkC9roYA==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:24:59 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 1/9] fuse: factor out helper for FUSE_DEV_IOC_CLONE
Date: Tue,  6 Feb 2024 16:24:45 +0200
Message-Id: <20240206142453.1906268-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142453.1906268-1-amir73il@gmail.com>
References: <20240206142453.1906268-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to adding more fuse dev ioctls.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dev.c | 59 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..eba68b57bd7c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2251,43 +2251,50 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	return 0;
 }
 
-static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
-			   unsigned long arg)
+static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
 	int res;
 	int oldfd;
 	struct fuse_dev *fud = NULL;
 	struct fd f;
 
+	if (get_user(oldfd, argp))
+		return -EFAULT;
+
+	f = fdget(oldfd);
+	if (!f.file)
+		return -EINVAL;
+
+	/*
+	 * Check against file->f_op because CUSE
+	 * uses the same ioctl handler.
+	 */
+	if (f.file->f_op == file->f_op)
+		fud = fuse_get_dev(f.file);
+
+	res = -EINVAL;
+	if (fud) {
+		mutex_lock(&fuse_mutex);
+		res = fuse_device_clone(fud->fc, file);
+		mutex_unlock(&fuse_mutex);
+	}
+
+	fdput(f);
+	return res;
+}
+
+static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
 	switch (cmd) {
 	case FUSE_DEV_IOC_CLONE:
-		if (get_user(oldfd, (__u32 __user *)arg))
-			return -EFAULT;
+		return fuse_dev_ioctl_clone(file, argp);
 
-		f = fdget(oldfd);
-		if (!f.file)
-			return -EINVAL;
-
-		/*
-		 * Check against file->f_op because CUSE
-		 * uses the same ioctl handler.
-		 */
-		if (f.file->f_op == file->f_op)
-			fud = fuse_get_dev(f.file);
-
-		res = -EINVAL;
-		if (fud) {
-			mutex_lock(&fuse_mutex);
-			res = fuse_device_clone(fud->fc, file);
-			mutex_unlock(&fuse_mutex);
-		}
-		fdput(f);
-		break;
 	default:
-		res = -ENOTTY;
-		break;
+		return -ENOTTY;
 	}
-	return res;
 }
 
 const struct file_operations fuse_dev_operations = {
-- 
2.34.1



Return-Path: <linux-fsdevel+bounces-24178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634393AD04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B9B22AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833C7173C;
	Wed, 24 Jul 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ+2zZ3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DAD29E
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805133; cv=none; b=sBKDbBjHbHjbAgGUce20mMYfZMhI1zSvo/1q/ocyIUO0xTY7tpxLjHm37zwenK401soGqZTDsD2qE957bPiukpLFUmh08T9iBK0e023EO7a/j7IQHwkOKE9qHz1lZ+wVjXNwfE9uNUsm+Q/C2NYjHodVxFMhT+Vj+xi3PmSeLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805133; c=relaxed/simple;
	bh=7lKq5GKeCiAb86MZvhON7q/aQQ/Lt6mJp4CwAsbFps4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QImt6QFlBdWEN15d9yaA7AhKIx0SY/bYPszPd3EV8n6kvtT4gA9L14VIJYduZg7IRSYZ7uCYd1o+lDHeQKbUW9He+0DRqq19gfCCtCPmgNYZOxIt7xU9sXqga8qUlcOXEyw+qXlydDBVVfZpVEFQgI/a80x/eJp3L0YpeMewplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ+2zZ3O; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso2039662b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721805131; x=1722409931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr/pmDtspgk05V3DznP5o69OQ8+jdC4T9yBHzGzK7S4=;
        b=KQ+2zZ3O2jtdNHh8DuWqz2Lm5L5+On6e+AGpazi0yj/lMIMzwRprQXZ22ey5Oa5byy
         fCiyHRfIz8eb7AGdh7CozLu32VbABAHcgO29N9dVYC8oAC4SgdXoGLwVI+e8OLLSUFcm
         r8epvdHGZXx/i4qajYfnOejavIVfVpLWQmh4k+yIhbfnW97/Fy329pxJHTXgdu/j4l6F
         ZXX/uCRzsEoqqBjgyccxoRwCwSjvgg7mwCVQwQIzRwEMBhhIyXwfSUYoHWFtnkMhtTWJ
         tRRhlJpKEbTXJ7oPUmoXQrvs/aUQQCAMVB8C6Qk2Tpb9LMGAqWVNKb2ZfyEegose/Ksz
         s4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721805131; x=1722409931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fr/pmDtspgk05V3DznP5o69OQ8+jdC4T9yBHzGzK7S4=;
        b=EWkcC9wDeakF6oK9aXgA7thHoXdaM+k1VUrcf8MEYEcc0CXgjx6xEJ/DVP9t4IFsFu
         tGvxmi5bMALNCNfcLG11DF1sDxB688PE0jRC8i8b/UvffvqBUi/lQhzsPNTXM1A6PHC4
         z86H+FL1qWw9e7m0GOvqpN9Lem5K67ZupY1/MW2BeFmnRwVL3Tk2CYhFCqNtvJBwjr4L
         gk7C773iHJfZ+TXdo1l89G5unTo4spfF2iUaQC+j2tXkfxL5wx/x+fIn+iPMXkA3rQjD
         b7Q47e6+ADzyhGxx/q3lxxkTRxjJWwqTKgbZ6A+Y/oLeVV2pQPcoVA+DvOVMSNFYzbSj
         3WrA==
X-Gm-Message-State: AOJu0YxOm6R26ia3bPvRwD8tnbJx3yO1LCkKk/MCb5IMwPtPtA4u230m
	JeGCLCaENcrO9Xh7ZK3coNQ70YPqmS9fp8UzyTRqqTO69j/JZVGdwN/ROapfF3w=
X-Google-Smtp-Source: AGHT+IHUpsDbIZseD47umSPALrSWJE4Ica37wHhFexbrDeyAnw0SFI4kH9oAcH57CWliXN0EbWHjZA==
X-Received: by 2002:a05:6a20:2583:b0:1c2:8f07:579e with SMTP id adf61e73a8af0-1c461a06f68mr1518550637.52.1721805131150;
        Wed, 24 Jul 2024 00:12:11 -0700 (PDT)
Received: from localhost.localdomain ([117.136.120.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a2163d7d3csm4096841a12.13.2024.07.24.00.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:12:10 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 1/2] fuse: Add "timeout" sysfs attribute for each fuse connection
Date: Wed, 24 Jul 2024 15:11:55 +0800
Message-Id: <20240724071156.97188-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240724071156.97188-1-laoar.shao@gmail.com>
References: <20240724071156.97188-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A dedicated "timeout" sysfs attribute has been introduced for each fuse
connection, empowering users to manage and control the timeout duration for
individual connections.

This is a preparation for the followup patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/fuse/control.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h  |  5 ++++-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 97ac994ff78f..247fbec72cda 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -180,6 +180,44 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	return ret;
 }
 
+static ssize_t fuse_conn_timeout_read(struct file *file,
+				      char __user *buf, size_t len,
+				      loff_t *ppos)
+{
+	struct fuse_conn *fc;
+	u32 val;
+
+	fc = fuse_ctl_file_conn_get(file);
+	if (!fc)
+		return 0;
+
+	val = READ_ONCE(fc->timeout);
+	fuse_conn_put(fc);
+	return fuse_conn_limit_read(file, buf, len, ppos, val);
+}
+
+static ssize_t fuse_conn_timeout_write(struct file *file,
+				       const char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	struct fuse_conn *fc;
+	ssize_t ret;
+	u32 val;
+
+	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
+				    3600);
+	if (ret <= 0)
+		goto out;
+	fc = fuse_ctl_file_conn_get(file);
+	if (!fc)
+		goto out;
+
+	WRITE_ONCE(fc->timeout, val);
+	fuse_conn_put(fc);
+out:
+	return ret;
+}
+
 static const struct file_operations fuse_ctl_abort_ops = {
 	.open = nonseekable_open,
 	.write = fuse_conn_abort_write,
@@ -206,6 +244,13 @@ static const struct file_operations fuse_conn_congestion_threshold_ops = {
 	.llseek = no_llseek,
 };
 
+static const struct file_operations fuse_conn_timeout_ops = {
+	.open = nonseekable_open,
+	.read = fuse_conn_timeout_read,
+	.write = fuse_conn_timeout_write,
+	.llseek = no_llseek,
+};
+
 static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 					  struct fuse_conn *fc,
 					  const char *name,
@@ -274,7 +319,10 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
 				 1, NULL, &fuse_conn_max_background_ops) ||
 	    !fuse_ctl_add_dentry(parent, fc, "congestion_threshold",
 				 S_IFREG | 0600, 1, NULL,
-				 &fuse_conn_congestion_threshold_ops))
+				 &fuse_conn_congestion_threshold_ops) ||
+	    !fuse_ctl_add_dentry(parent, fc, "timeout",
+				 S_IFREG | 0600, 1, NULL,
+				 &fuse_conn_timeout_ops))
 		goto err;
 
 	return 0;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..367601bf7285 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -45,7 +45,7 @@
 #define FUSE_NAME_MAX 1024
 
 /** Number of dentries for each connection in the control filesystem */
-#define FUSE_CTL_NUM_DENTRIES 5
+#define FUSE_CTL_NUM_DENTRIES 6
 
 /** List of active connections */
 extern struct list_head fuse_conn_list;
@@ -917,6 +917,9 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
+
+	/* fuse request timeout */
+	u32 timeout;
 };
 
 /*
-- 
2.43.5



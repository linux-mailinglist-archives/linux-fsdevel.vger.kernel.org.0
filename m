Return-Path: <linux-fsdevel+bounces-34289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB339C469D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B55D288CEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CD31C6F56;
	Mon, 11 Nov 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ecMCd6g6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED21C3F02
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356370; cv=none; b=iXRRDbKUiLq/0y8C3eMHPFbF3RujKUwCyqOTgMKDl/bZ2F4SKFgtatZ7GUzHeFrmYAikFvDyL8L8fraP+EZeCC46Hj0XP+0rxA8DcW6XDDcCO6Gi3TjWXnVaXn/Psx0Ut1w0i0xDYXbTtxB6aRWoIhgn1Stj+c9DHlGAzJR0bFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356370; c=relaxed/simple;
	bh=+GaW79ihYPcVt/7H2tBMApB0qt54+8GxTgU7k9z6Kks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odnR59rAbXapwmeW9+QG71+6niRTlGLM9WyzABH+4FlAt/CT2Nn/ru1Y9GRvuPIfAG7UjHsnY8AShw2m+jS68AROTb5flNw9M+d+Z0/PksjE/wxRjHuWlDeja3r9jwU5E4SekLONTpW9bTpSbUNfnKprLW82OhFcMWLkfdNM4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ecMCd6g6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608e389407so64506301cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356367; x=1731961167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxzNxKWQS223qRTjvLG5E3r4Xe02F6POoSVqC+sjeek=;
        b=ecMCd6g6+CRWRMGZZap3eaMKIsWFTbfBXssJ5U7Crenx5zgp48uEmJdG9Ja9rMO2+O
         oQIaN18EVkYDNccBvdMmukip4cUC+psREXW/PUUdNTQ3JGA+LiDQqDBZj3MftvIQ6c4K
         4mqDI2ZR7VsyWqgRwvLPlL9JdOkrVRa1nFXIStZ+6J6PlKxpx+cF7W/DaxeYzV2bFReT
         YFBLkY+Ll1EDiVkwYCx4T/QbSSqyhvBJX2oK2/1d31yz2YAwd021jrpeboYql7Vib3X6
         4bhP2pxDEo2h1E04a3+inH3JUpEnROauL1dD43s24AefpxsDhkSnJK2dw4OOvViTvRHK
         xUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356367; x=1731961167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxzNxKWQS223qRTjvLG5E3r4Xe02F6POoSVqC+sjeek=;
        b=pgtgIuO98zxZTAZDyB730lZMJKxscMtAxEVikASye7dYnWfGjP1jgFeDdeRkyHN74P
         yrwMWFXsDfHPBI7dt1JWHv85XlyCcqbGkmQ2n5ESF73VpsXsYf2pOO9QkRMZBPwQyz7B
         v9scAo3sscHku0Xw9dM+CVYrod2jsgZfcX9n+MZCzPknlgIaxc1QX/SyuQ1V6lPq/Mu3
         pyKIoH7LJRbYKCCpNBVhTzfHaFtXiR0Z78qFHYvRJK5564JDKN9I+5eKHFNgs1+k8gQS
         m6MxtEQuTGTY0lCg+dthoghVZUUahDvmx8wZ32EKWUuMsRVkUBNISAhCQ9kObwwFgOh+
         1N6w==
X-Forwarded-Encrypted: i=1; AJvYcCVVHXiylMrVbzTxihPvOdy94GJggBFnpki/MfhekhOaBhXp2eYzoQR7MgmwwGi0TOS3Rr3qbOMyhhWDYo1E@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf74xti7Wz2C4USQTTfkkVzIrE8RfRy3oskn41NWO47TUSa42w
	Serc/ZWFUV5Rs23YbHdVENxVlgPITKcV/rrm/uadEkzNop2ABv/75EQ34E9g5mI=
X-Google-Smtp-Source: AGHT+IErujsxQUzTbV6poIIfui4YaoHywzZ9+iKLxxl+cBzfLZ4qZlTFt050wM/IYDovGmekQNr9vg==
X-Received: by 2002:a05:622a:8d:b0:460:8d16:e8cc with SMTP id d75a77b69052e-46309331aa3mr187305441cf.16.1731356367498;
        Mon, 11 Nov 2024 12:19:27 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff580e2asm66683971cf.67.2024.11.11.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:26 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v6 11/17] fanotify: add a helper to check for pre content events
Date: Mon, 11 Nov 2024 15:18:00 -0500
Message-ID: <0b76f68806fefceae2618e5f135765e429b23025.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to emit events during page fault, and calling into fanotify
could be expensive, so add a helper to allow us to skip calling into
fanotify from page fault.  This will also be used to disable readahead
for content watched files which will be handled in a subsequent patch.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c             | 16 ++++++++++++++++
 include/linux/fsnotify_backend.h | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0696c1771b2a..a49c42c6ce01 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -203,6 +203,22 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	__u32 mnt_mask = real_mount(file->f_path.mnt)->mnt_fsnotify_mask;
+
+	if (!(inode->i_sb->s_iflags & SB_I_ALLOW_HSM))
+		return false;
+
+	return fsnotify_object_watched(inode, mnt_mask,
+				       FSNOTIFY_PRE_CONTENT_EVENTS);
+}
+EXPORT_SYMBOL_GPL(fsnotify_file_has_pre_content_watches);
+#endif
+
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index abd292edb48c..e3a4a8e06fa0 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -896,6 +896,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file);
+#else
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
+
 #else
 
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
@@ -934,6 +943,11 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	return false;
+}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
-- 
2.43.0



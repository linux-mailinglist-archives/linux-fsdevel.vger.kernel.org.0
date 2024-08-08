Return-Path: <linux-fsdevel+bounces-25463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0770F94C541
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74823B24717
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8907015ECC3;
	Thu,  8 Aug 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YuIjDizw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68815EFA1
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145312; cv=none; b=Cwajc2OTI7HJ3IMo9p9YImA5NlFZKRSxZLw/FhC2yM+vDPL0dubNfA6m10QldILppbwpawCBXGrkgsPYprlfVfg7rI5FC7gPwdowYAkPqWRdKQFIzoSk0l+wHCN3Qu6GRRGSpeJBGBOHuwiglbHgbnkVa+e1HbDdP6qD4kxVHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145312; c=relaxed/simple;
	bh=GuL24mTj9mXM70tRp2J+zNN/WSRlPMuaehdquMxMOMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1kcX3wtkbvfFqCL0qc0mE7zMPYBRYynIsSHynE4P3mtHbRf6dObpKXee67MLqgcEsMPncxY5a+SnHzjKfkkLPI/zmMsHUAS5S6ZJP6TM+iPvdPjlKvUlKPBSfo3KGsaNlgxIeKx0TmJhsBeVrv1oTLPB5PEj/YoQ4lW0RjFdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YuIjDizw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fea2d40adso7503731cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145309; x=1723750109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2MplehQscA1+uvrWS0C9V1o5GwHxjl+BfkNu3cTe0I=;
        b=YuIjDizwBSBPP6YTB4We5JJP1CXSwKk6cmjWPtWgUS+SqPJl5OEigR8GifxH3HYjhu
         qCFp+vzbu7LlIRp+y6BZPhUJVyM/IEJnvke1iXb3nPXL/EuPVyIbsn4eBepUiIAMMl/g
         mEnNVdGANOSxCTRL6Deiq3DoHDieAaH9igHfZ12bUp/N8HMF5SUOjHxsqExHsNjs3DIz
         Boux0Ad41RNNSknEfzuVwlEy/We9lQg7VfTRWrgXmbHXyPoPtIqo4/HhyOq/5f5eDTR+
         ZzpyEVQLxPM49a6wWMm/mGaHP2i8HCiUoEYmlvO0cuiULtxHFq9ixHJLV6qzsQY2Z+NJ
         FdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145309; x=1723750109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2MplehQscA1+uvrWS0C9V1o5GwHxjl+BfkNu3cTe0I=;
        b=vP9SAQe7SPxxv//+Jyu1bSb0y2fmad5s9Snqi2a3HMaNbD4GCvOH00eswAaTq+Wvl2
         khHxEm5UQyv42bLKiywIyRLmnNE9AE033aRI8K1CzGRFgSw4ofQS35X7tXkzJMlRZppl
         HOL0FDipuYtRx33k+IqfK6s4mG7IcHNwzuPbEdZfb2J6Pg10R4tTvouBJlyQtxjLzZD3
         mn3isem75XumOpnOfdeg3x2GB8iNbZq5IRW+3Upejoz6wDSHLmNHcfalWxoWtUoj/cQQ
         8LfbAxMIg9uKlspL3AWm46+rvatApfYwywmq+geFA3Oeow2c/Xp3odtHPF4yBU3jD1HX
         YKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9SugWEGgj8GupDDjqs88eS0FRCS2K4VVNgryGDdBZlt/JYTMETAFVf4ZR4r1UwH0zOOIIaSA8BDxaKhd6jnkURVFHxRiN503KM1X5JA==
X-Gm-Message-State: AOJu0YxEtzxefyRNH6d19kPy0XCUnArwz2nX5cZ0DmkqMJdhjsjZO2Vx
	uRcIsgzen37XoNsGc7+KaPubej+HcqC/UHaioKpY09lpX54Ie1zUO3FeC27D4Mw=
X-Google-Smtp-Source: AGHT+IFDsbaV/n8kDCGttZbX/69iKd/pkdvlPw0dlBa5DAGrReE31B6U9TrZPgrw5N0QpefXodV8nA==
X-Received: by 2002:ac8:6f0a:0:b0:440:6345:257f with SMTP id d75a77b69052e-451d42ff7c2mr40818221cf.60.1723145309461;
        Thu, 08 Aug 2024 12:28:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87db202sm15626721cf.72.2024.08.08.12.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 10/16] fanotify: add a helper to check for pre content events
Date: Thu,  8 Aug 2024 15:27:12 -0400
Message-ID: <531d057087b9430839ddd6082022e29a9066ef1f.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>
References: <cover.1723144881.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c             | 12 ++++++++++++
 include/linux/fsnotify_backend.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 1ca4a8da7f29..cbfaa000f815 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -201,6 +201,18 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_pre_content_watches(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	__u32 mnt_mask = real_mount(file->f_path.mnt)->mnt_fsnotify_mask;
+
+	return fsnotify_object_watched(inode, mnt_mask,
+				       FSNOTIFY_PRE_CONTENT_EVENTS);
+}
+#endif
+
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 276320846bfd..b495a0676dd3 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
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
@@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
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



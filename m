Return-Path: <linux-fsdevel+bounces-26002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14B99524BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 23:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1F81F24392
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15D1D1742;
	Wed, 14 Aug 2024 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="egfBT2So"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D01CB317
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670780; cv=none; b=qH/6hjXNmRT5SFd95PaM080x00ePw1ez4B/rKm97622EoooUY0olhCEj5qLpwIqjCJyTLn7Qk4Hb2hgyRRX3csMDSfBrJ9GMp0UUl96TwVdcbtSDPAtQDkPTloL2aYsMCeX0Gq7ufPkD2t9vxaRzWqEQw8TPaBK62DSviS+jb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670780; c=relaxed/simple;
	bh=oIFEloV+HJRwW7KKzTETqcSZwuMF6cvmESmc2+RUi2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZUCLVpoqWK6/WqaToNfJ+dMkb75+IzRJq1iG/0C1igoMvWztrtC02PCWYSaRQFNUAQFpMrcGyBmGxRO+qGB3aWz72hcx+A9VgKKg1fFGROajPY3HP0u2ZF8XmcYaLVZshJtfYO2v2XwwdLhs5geWae7y4DrtcLY+AiibBn+LNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=egfBT2So; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44fea44f725so2517551cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723670775; x=1724275575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=egfBT2SohJocthjXgqBRlCM24YB5SjKy3kaaHIq3PNauChakpxk0meEX4hTK7dnT48
         NNtwjPwseLA2GV0D1mgWNHR9qpW/+bcvWHgdoIH4aFtn9CmogjEYdycwzW0P21NeOc1O
         CMZzPJLYPRqfNPnkwMBrYN4w6Nc/eui1PiwZ/MEjTaBu4nrQFgxUf6I9/DfYL4ILWMq9
         F4wgdMXDeEROGYbzC9nOMQZqy/RhNOYN4zt7HDyP+CtY2ClW2ziw0h/BNyE/AUEKamW6
         cw+DNLQBVQUwvKP7NVw0dW8ygUCvPCA6uQvqP9YpDdRO/Xiku2zsCnkorF/SdH5FedNC
         OvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670775; x=1724275575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqckBRUWRZ8lY2PUqxw8YY3RQIFbRSWL2L9gDiXv76o=;
        b=NKMDYYxN5zEyyzRMafCBidD55/+iUS34ALFtbYUCTVpH9Z/wMhbrv2jW1ORYJeuCp4
         eDyGYuqRik0jkn8Bqj7kowXVlAUfOblwidWYGE/9W9qBxX9Q5fUuaFJkazpK/Ap5lJKF
         NboF3uHxvKSEjlfOQbXsQa96tDfOaErU4PaWxDqPBJD6/QwD2DOP020Yo1jOh9caZ5yr
         i20nTtVGzm93T71u+LjQbcYlAH04yBKjlx3HF+Fb4N3yfnA4IV9byXw3HZesZPICRXV8
         prKQlubJSCj59Hq4cteqXhqFeTJUvOosHjVT/o2V+qTTEK1nijAw2LgjcxfGhU9yDNYN
         enOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpyKVdoW6Y/T7apwzmbakF2EtVU+uMCxCUNVTZ7A1E45eRIrYnndltNu1W4IhlBuyNrceTX3eg29RC9iyLgOQIpu7GWpLMcYXh1Xit+g==
X-Gm-Message-State: AOJu0YzLy/yhNFb53Tnt8L95R2rziS2P+qB2gQR6DoXud1kYkESPM7iW
	YDNcDZFxQ4jrLJ8+Ckwb62x0FCu1T8dIbOc5gazM8aRctVeSXxzI0okaxqdCRQA=
X-Google-Smtp-Source: AGHT+IEd/MmUwaA1JVX+VfdhiUmDxdoXxYs9e30nr4Gux5C2du2HbwieZEhvSa2zBuHRp84nZOLlBA==
X-Received: by 2002:a05:622a:4c8e:b0:453:57b0:8814 with SMTP id d75a77b69052e-453678456ebmr18969301cf.6.1723670775058;
        Wed, 14 Aug 2024 14:26:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e22esm502161cf.74.2024.08.14.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:26:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v4 10/16] fanotify: add a helper to check for pre content events
Date: Wed, 14 Aug 2024 17:25:28 -0400
Message-ID: <b02993d0e384326194023c76e437c0ea838a5c06.1723670362.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723670362.git.josef@toxicpanda.com>
References: <cover.1723670362.git.josef@toxicpanda.com>
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



Return-Path: <linux-fsdevel+bounces-24272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE293C843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941BA1C213DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C308E49654;
	Thu, 25 Jul 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KySHjUhV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716E3CF4F
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931613; cv=none; b=Dq/re1+yGdIoMyEjRiuUjybMJJtyxCcRyXZVcAv/ry+xQEFVWNsHxfjVIR4gA3YpEWhgRTnZBuxgb4zUDdFlnt0LVmnoldeOm/9m2ZEOjaFqkS916tCng8u3mvoWUroox0TFfdDZWetA55wPjLqSh4P+E73TQ4YyguR6k70BLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931613; c=relaxed/simple;
	bh=5hCtfwwGaSoo88/6uirww/Vl/AinbUzAT+AAAqH51Y0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX+9clVxN6doVesUD1KmDBv9oPJL9gcrz61pnFNdTf2S8sNSrdnp6LwD89dQZ834r7yjUi01vLiK1lvyLk70OOTxZ1DzDOtvpsI8eiEzrj0MSowdlVtc3/IA2QqiVCHDVRhW6KVFZCj1Xd5o4o+pUaLQf2v5rXCq6lcigFBrStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KySHjUhV; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b796667348so11240776d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931611; x=1722536411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G97TFAwqloOhjsDe+3X1WdwF/WXcuX5oC+tX+23Kxis=;
        b=KySHjUhVE6RXemX8wo3O0lH6aoCNAYPrAID8UW8UfJrv2MxhKZ02qnNiETxe8vxcff
         Np/+bn2o8Q0e5+YCRlB9/MHcXqfuSmmvbo8MUxw1/bB2NdwcAZ3sfrq5xHM9Numfi9eF
         gpBpeQNAGHswMWoihc0kGkAKUlAk79NWTfPYO+qDLKzTdMEK5zNNYzkcJXO/ccT8Q+HD
         BnV/vnvlOCZcVFcviMnfjbp9Ch/k1HxmO9Gspkfowq//fhrPAqqsK3VW78jzwUkvuYcF
         MpMIFJRp7ay4kZOmnCalTR9s98VI5Hpb8RFDGhPc+cKGTajJq2BQVMGy+G1BHeTBhoMk
         k6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931611; x=1722536411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G97TFAwqloOhjsDe+3X1WdwF/WXcuX5oC+tX+23Kxis=;
        b=AKy+RXdkJ0WuwwNn+wyA4WFDKZWJXbl2ajv9DNo6WAUJWtuaeAcRiL0jWSwN8J6d8M
         ODz81QCklJlouxJDKfkGxd/zAOyF9kpdZ8Dd7PaP8+Nwumg4R4s2YrKhuZSWdoq2dbNa
         nna9xyJK+gTo4MP6I05je4g57mf1UDZVDgKnvyFawBBZM5bW/jN3hlgq8Or+qt8/ulod
         RxylgQ8f1+K4ePzJ/68XcmNLVAZ1rbP78cTSW0kfTDBoTdmxn2PFfNgkdKgl2Vp4ikrh
         thnI2gfKU9DAaQvAbJH0I4+Jd1yDAY6240TmJdHzxzAZd/vESt+1yXesUdl7WCbtABsI
         mqeA==
X-Forwarded-Encrypted: i=1; AJvYcCW9E/Qs5mNgv0S4XWZmmBuoOMjGVkw07Hf1JPX+hqttqu2b1Ngn+FjHb3y2WRGF6bH4H6qU7FU8BY9DAIRmAM5mDhOxOT9BPwG3sxVHrg==
X-Gm-Message-State: AOJu0Yx6BGt7JVdxJyBmbow1ElunJzuMp3724uDt2y702H76A3ocwpba
	EvEdl1rKk8PPD4Rr3ctGYdJ0sPFmejTb8WSXLN72PqLY4RjTlZKHoSMvkM/l4YUXShAhVzJAylc
	z
X-Google-Smtp-Source: AGHT+IH2VK7Y8cUkh8TyBhm/VkNN+ntYBvXHX+8xnpNRFdN6GuhSJ0NP2zK6+UogEATDzHSdlDd29A==
X-Received: by 2002:ad4:41c4:0:b0:6ad:84aa:2956 with SMTP id 6a1803df08f44-6b9914b0d01mr98431336d6.13.1721931610706;
        Thu, 25 Jul 2024 11:20:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d8269sm9525256d6.20.2024.07.25.11.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 05/10] fanotify: introduce FAN_PRE_MODIFY permission event
Date: Thu, 25 Jul 2024 14:19:42 -0400
Message-ID: <e58775009d8df15b5513fab5ac112f0dac53e427.1721931241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721931241.git.josef@toxicpanda.com>
References: <cover.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Generate FAN_PRE_MODIFY permission event from fsnotify_file_perm()
pre-write hook to notify fanotify listeners on an intent to make
modification to a file.

Like FAN_PRE_ACCESS, it is only allowed with FAN_CLASS_PRE_CONTENT
and unlike FAN_MODIFY, it is only allowed on regular files.

Like FAN_PRE_ACCESS, it is generated without sb_start_write() held,
so it is safe for to perform filesystem modifications in the the
context of event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first write access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 3 ++-
 fs/notify/fanotify/fanotify_user.c | 2 ++
 include/linux/fanotify.h           | 3 ++-
 include/uapi/linux/fanotify.h      | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 7dac8e4486df..b163594843f5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -911,8 +911,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
+	BUILD_BUG_ON(FAN_PRE_MODIFY != FS_PRE_MODIFY);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 23);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index c294849e474f..3a7101544f30 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1673,6 +1673,8 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
 		if (!is_dir && !d_is_reg(path->dentry))
 			return -EINVAL;
+		if (is_dir && mask & FAN_PRE_MODIFY)
+			return -EISDIR;
 	}
 
 	return 0;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 5c811baf44d2..ae6cb2688d52 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -92,7 +92,8 @@
 #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
 				      FAN_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
+#define FANOTIFY_PRE_MODIFY_EVENTS   (FAN_PRE_MODIFY)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 3ae43867d318..c8dacedf73b9 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,7 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 
 #define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+#define FAN_PRE_MODIFY		0x00200000	/* Pre-content modify hook */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.43.0



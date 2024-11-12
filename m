Return-Path: <linux-fsdevel+bounces-34505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE769C61D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765BABC656C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540F218D99;
	Tue, 12 Nov 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LHI4AzXL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD46218332
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434206; cv=none; b=stDxy8bq0rHU3rnZXu2ewBGPoAVbm9Y3pzPuRtWraa4X/35oFwE+oKcg52m+4hfxkkpfCNY8affjbcatEh8TeewVp3eDTwy8JWYv27Wx9rMxZbXp4xEwQlYtBRQyCKjJSiY6jVdI1LZDAeq5VVnzJJJyc3ISxN66mZBfC+m8ieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434206; c=relaxed/simple;
	bh=UbPGh6xYP6XDSfvXkgSxx6BR17MpSS86fi5l/Up8DqU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCs6G/Xn7pqMw2WdviICBx/wJ+rBamCAiCrKuO+A4WkvrZVgI2GEbUxXHc2wGUPun6qOB7/GVXX7+FSVvrEUySnIFYgZzBPAGZxl/273LLzZmAwq05CkKfa+m69YvngIXsL5qrLAKsFNM7PFFJ89o5JvB9uzXDZ7AscMOfq4yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LHI4AzXL; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e30d1d97d20so5291384276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434204; x=1732039004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmpMu+cyUA93dTz87+bG4l2t/L8RTFnzlJy59zXnVRk=;
        b=LHI4AzXLnq0kzxfjQPdHO/80GN11ruWzuZu8PuJIOMR7miXJbB5Xe7VQud880C4+28
         NSS7g2WyUM7ykR33Mdz70m36NCQ5xe46kdu9eazV2A3RvAAHeRmP4yF8npAQELlE2Xio
         aFygCxostVT+gT98q8durzRkKC9tc+AuxpjjYM6lEY+MUZEauWNzO2Ci/cT/ikjmTvnS
         zB7EEhP+GrW2BdXscOpxTej3gXvfUlh/2LEHhSPhfKKUmP5m/bgc+8xH4Uq6ApEBjFkB
         IthRRqLrWqylOIUzP9aXM6SX6ONWt7+M6no1zlE/XCFnUjt4y10pGkZbVu3gcFGUn8S9
         sqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434204; x=1732039004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmpMu+cyUA93dTz87+bG4l2t/L8RTFnzlJy59zXnVRk=;
        b=CyWom/4ucS3f8Zf1ZJZFDkjbiw3ov6ptfourDqsa7lEx/6ZtMH4YuxHRy2mQ/5rKDO
         h4eB1DVznsiuJM92U71cnmRNKnvT2Cl2Ukn431RNKRpYwkLNR10kQQ0aFYeCY2fP5Q5t
         LD+K2zKOn5wNARsej5loygVWQBHuVjh+gAUvnhGL6/azrpgNGL+B+1zUxgHBS/lwXvhL
         avDAr/DmDQTL+28kYzt6EeOBC2Pbi2msFUS6RrzgFeLRkIrY2dt1aY0tNif4IrLeOpI8
         wowwwK5w0037uz4L6TTMj1mp/kihi4sRAEAjamzml1c+s+ANp6IcGnysheCI0sUTBJh8
         Anwg==
X-Forwarded-Encrypted: i=1; AJvYcCVr8dahEXtqg7RvQcf3SYSbdipTTqWZjoSJgSkZSphk7STwioRX1XAyRQHLTeFAAl+5/Drnbtx2Hw9LpKMk@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5xBknZ3ZQyrjCDZKI7jXaML8DyRfZ8PPRjngMJIrwZickT8j
	p+amIeFSfEfQtqoRxVVbth72uyvBAl1ekc+TXJrZJdJ+eBNj7H1QBQw+8Gp8rjQ=
X-Google-Smtp-Source: AGHT+IFoYbCAjCHUFKm3DZPieLWA6AhlwnAEoVWWiOeBhhtsUN5DL1tJA6JbxgolnU89lhaXg5Pm5g==
X-Received: by 2002:a05:690c:6f8d:b0:6d3:f283:8550 with SMTP id 00721157ae682-6eaddf977a8mr188770267b3.28.1731434203995;
        Tue, 12 Nov 2024 09:56:43 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8d5216sm26312647b3.26.2024.11.12.09.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:43 -0800 (PST)
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
Subject: [PATCH v7 10/18] fanotify: report file range info with pre-content events
Date: Tue, 12 Nov 2024 12:55:25 -0500
Message-ID: <e0070cd4fe75ce2556b9caaee5019a498c00deab.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

With group class FAN_CLASS_PRE_CONTENT, report offset and length info
along with FAN_PRE_ACCESS pre-content events.

This information is meant to be used by hierarchical storage managers
that want to fill partial content of files on first access to range.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      |  8 +++++++
 fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      |  8 +++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 93598b7d5952..7f06355afa1f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 mask)
 		mask & FANOTIFY_PERM_EVENTS;
 }
 
+static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
+{
+	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
+		return false;
+
+	return FANOTIFY_PERM(event)->ppos;
+}
+
 static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 {
 	return container_of(fse, struct fanotify_event, fse);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2ec0cc9c85cf..5ab9ad69915a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -122,6 +122,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
+#define FANOTIFY_RANGE_INFO_LEN \
+	(sizeof(struct fanotify_event_info_range))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -181,6 +183,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_LEN;
 
+	if (fanotify_event_has_access_range(event))
+		event_len += FANOTIFY_RANGE_INFO_LEN;
+
 	return event_len;
 }
 
@@ -518,6 +523,30 @@ static int copy_pidfd_info_to_user(int pidfd,
 	return info_len;
 }
 
+static size_t copy_range_info_to_user(struct fanotify_event *event,
+				      char __user *buf, int count)
+{
+	struct fanotify_perm_event *pevent = FANOTIFY_PERM(event);
+	struct fanotify_event_info_range info = { };
+	size_t info_len = FANOTIFY_RANGE_INFO_LEN;
+
+	if (WARN_ON_ONCE(info_len > count))
+		return -EFAULT;
+
+	if (WARN_ON_ONCE(!pevent->ppos))
+		return -EINVAL;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_RANGE;
+	info.hdr.len = info_len;
+	info.offset = *(pevent->ppos);
+	info.count = pevent->count;
+
+	if (copy_to_user(buf, &info, info_len))
+		return -EFAULT;
+
+	return info_len;
+}
+
 static int copy_info_records_to_user(struct fanotify_event *event,
 				     struct fanotify_info *info,
 				     unsigned int info_mode, int pidfd,
@@ -639,6 +668,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_event_has_access_range(event)) {
+		ret = copy_range_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 7596168c80eb..0636a9c85dd0 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -146,6 +146,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_RANGE	6
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -192,6 +193,13 @@ struct fanotify_event_info_error {
 	__u32 error_count;
 };
 
+struct fanotify_event_info_range {
+	struct fanotify_event_info_header hdr;
+	__u32 pad;
+	__u64 offset;
+	__u64 count;
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
-- 
2.43.0



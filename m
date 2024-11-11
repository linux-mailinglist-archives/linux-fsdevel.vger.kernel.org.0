Return-Path: <linux-fsdevel+bounces-34287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5DF9C46CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4738B292F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23401C3051;
	Mon, 11 Nov 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RB/8HFdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FA1C2304
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356367; cv=none; b=RfWfpONE+Pvrr154JuBQLg4ruiDzc/9nLo8uZR8gv3HGfehx+/zv+w3nMsPCL2De1T2KuC1AZzJAwQLksqfbaQPvIpz4PooSl9YJzyw5oHW8rIY9clu0UBYVvfU9Kunqxo+5DSTs6s7GEvnM/d8Sp4hg8Rg0P+4vDk7DnaLoc5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356367; c=relaxed/simple;
	bh=QBEIEok2zEjZt3JCIFogxoADuLr4VlZ3jLJ5rAkDDL0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBABd3f+G2PpZScdtdfzsy3Ed3MuaUizUTAntbpoCU5Rou9nPN+PiSdgS7H7djJBKov6/t4ixJp6tEDc1U1E1HQyWsw+LleOUprbdYjW7w3TYfVpXcwnMLBCJh/88Q86lJhZcyhK0Zr1KAqszeX7b8var7CWdZmZZwj4molJmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RB/8HFdr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b15eadee87so342022885a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356364; x=1731961164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGryhZjhYAebksFaS9pdbr55rRjOBk5banX6k6b7VeY=;
        b=RB/8HFdrpaUKISo5/c+mHum5Up7uW0cVspSBHaW6+YPgOq+33HMHUKmeWWyt/TvKLT
         duyxHa8VkTVuJcvH5xuawsuoFf+wi2CnOODSHrVuxaDfCj8vl1jbVG9y16vORs1VPp32
         ccVstK1dgrzwm23LpUlSZ0O/s0OPcee8SrN2kJVZcFAOc23eqMiuczsRlD4fD2FZst9p
         +SfaiXeB52+vV+QfVEvC5dwF07A1s7ypt7cG9gZv5X+auOvFldiX6OyvyjB2AgXQa5mu
         dRvr8W7fJmk717t2iJp/A4BcGcuTprOUePivQfAyg1FJl9oZ0+t95eeaflKZKiW9ugeK
         ClDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356364; x=1731961164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGryhZjhYAebksFaS9pdbr55rRjOBk5banX6k6b7VeY=;
        b=iyB2O19w1jAH7HzlbiGPB8GToWe5ZBJmiMyMZ10OYWb4d3iOGwRE6fr23jRoHb1WaE
         28gnGSzV8dW/BCCFqHypLjnYsOiqYI9uAUUSF+fvhjPO8zmcoCxp2CXP1+V4vL8kV/As
         scel8MNCoQfpT21ARKyKIh/oNK1/XnQrMLUyXSsEPSM8un1QRSq06HY+F9oPo2fahIRl
         Wt8PKh5eIZjRXi8ZEMrUH/yIZL0J6USnQ194JvXJXYWrCi1VpfmiJGWaEIRiJn/sDpGF
         /go0k1Zq6eB/vgm5ZhLwNyHPo2qekwCCh1lGkg70YJSb+8nhlTZGai6CWfE5hxxAQt3u
         VysA==
X-Forwarded-Encrypted: i=1; AJvYcCWDKwQSMOMO9vDtlKe1q4knOBvm4KWmYX/eabsYD/nk3afNv2ldQUdTw7CP8THZInEvhEMeHjZeB10laRwD@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmqF4sF8A3Bz9JmbKBIr4s1dwvZsUQ7ggWqM08+gZ1ZKbBZLM
	tKeY7hYu37j4RMojCRaUMLJc79kWK7xdYC3hb5uAtcXpyNuVDT9y64EnWsDsW80=
X-Google-Smtp-Source: AGHT+IF22B/D1c9DuKVBsfxqpgJ2vY2z65TspT6Q0Pw0A6vpDeL8FShi0pjnRxFhWA3rscCdafTgdQ==
X-Received: by 2002:a05:620a:1a94:b0:7b1:48ff:6b3c with SMTP id af79cd13be357-7b331d8b905mr1736558085a.16.1731356364156;
        Mon, 11 Nov 2024 12:19:24 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac57002sm525823885a.43.2024.11.11.12.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:23 -0800 (PST)
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
Subject: [PATCH v6 09/17] fanotify: report file range info with pre-content events
Date: Mon, 11 Nov 2024 15:17:58 -0500
Message-ID: <2146833d30122ef9a031e231d8ced7d8a085196d.1731355931.git.josef@toxicpanda.com>
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
index da9cf09565ce..17402f9e8609 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -123,6 +123,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
+#define FANOTIFY_RANGE_INFO_LEN \
+	(sizeof(struct fanotify_event_info_range))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -182,6 +184,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_LEN;
 
+	if (fanotify_event_has_access_range(event))
+		event_len += FANOTIFY_RANGE_INFO_LEN;
+
 	return event_len;
 }
 
@@ -519,6 +524,30 @@ static int copy_pidfd_info_to_user(int pidfd,
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
@@ -640,6 +669,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
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



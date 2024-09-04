Return-Path: <linux-fsdevel+bounces-28641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663596C875
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACE11F27448
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2246176242;
	Wed,  4 Sep 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mdhpT0tG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA741714C1
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481770; cv=none; b=dFpSJvwPWv1mmre2nRH7eA3rnsxulM/XeD9qyK2oWce/dQCjQ831deeh82hLyxKOAxxTRW5uDMGmGm2z4Aoe91Rs9oyRXneESinGB8Lwe6qxZFNAeo16QTK3X8Fw/4l7lvP7iEtOZbhzczu2tU1eY3NzK7zVOKH50twpbP63GWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481770; c=relaxed/simple;
	bh=UkBoQACwZWNS66VUS7nQ/E+uy/3pz3xN2YqDEBSBDyw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3vlJokbaIttDeFnQqlLZ9phAnPXSAqt1N24knSLIpf/jaTWwKkoNRVV5bhnYc4K85EWC0+w8m3WX0cqsW2SHk/soAoagc78ifrT+3YPXRnzzdKBbcErZXXi2TyQsTDk6o0c/XiJsHdf5TM6mrSINvq7vo6lTM8qpVLdpxy+kVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mdhpT0tG; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a8049d4a4cso2839285a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481768; x=1726086568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdFADlNMi9J5+Jo97YgtLX17z0QeGZLAaqk7oAQuL90=;
        b=mdhpT0tGPDmH7J6XLzDodwE6DGwnaSrY0JW+v7D6TVPxyccLmEFXz/cxq37IdLQLEA
         AyvZO0deX815OA++zxzdqC3KDTmSV4gsUjiWE/K86wYLFRMbr01w5UeH0t5SNp4Vg2/4
         meaw6/HNo724mJzJJU8iEPvnRNHHCzcaCkRq5/Embp/YyByUk9iAWru1YDscrfby7MvS
         2+ycnd7/xJX5nlQfWsFq+yaErpj15Z6lqpQVU5kS/kJ6/xleoqmr9hHnI5UAh/wK7Ykp
         04xmVLXCqSmr+phqe+tAsVECuQi/eiWgZLcIqEPdmgPRXqy7gA1wiA6sFQHggyU+SxII
         3iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481768; x=1726086568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdFADlNMi9J5+Jo97YgtLX17z0QeGZLAaqk7oAQuL90=;
        b=Fa05nRKa1266I1LuF+IbKMCBnKeqwxNHfDWBoV9keiSi5BxVgov/sHSxG/HB2h+oDD
         mjUwv4lMKElcJ7VC002MpEqHBdBT03wzU8MXcRgqySgGwLBTI+S/rxT6jpsvN1zYR8mI
         KH7l3ejPymkN8jZFs+zO/93hv+XsEjwlTJ+tzmXmcH+DRKjz/KBle95CLDIsH9Ec/OGB
         IbkYMANe9DBM0E7n2rEPoXLBvhqg4tFpO6PkgEwmr2wicMmqyyRG//3UgjWWJhan51nF
         QQagbMv0KBtqiCASQuH+ayjV7D60ytapKvKkKLfWefZOuvcxkkuDtijGsLZ4DTM0ODTw
         ZPeg==
X-Forwarded-Encrypted: i=1; AJvYcCVUo6UlEZJe0avBOml7DzU1Xam1lRUudZ2kGNOQqOOm2QILlXH/woREewQHAGkTTdVD2pFpje8FVD6NuePs@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3l38UQr+P3T5sPjhs6q/H1jX7l+1jMVkuJdpZ0FmuN9FMKsI
	dSL0h8H/mxgSHqYza+ljstjZoGo7pORT8MRPzXobYod5sbPSw4D+knVwM7fXiaE=
X-Google-Smtp-Source: AGHT+IGx6um9uXhEhda5h73KKWCoNW2FF/dwyP15+JSEZ33BwCH3HCg2dZ3AYVIuYxLr9QIEDkXCMg==
X-Received: by 2002:a05:620a:1724:b0:79e:fc9c:4bcb with SMTP id af79cd13be357-7a8931ddae4mr1887788985a.11.1725481767911;
        Wed, 04 Sep 2024 13:29:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef4a2ebsm15638785a.67.2024.09.04.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 08/18] fanotify: report file range info with pre-content events
Date: Wed,  4 Sep 2024 16:27:58 -0400
Message-ID: <0833eaada39f0a33e655b47f2d15a5a37cf39a78.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

With group class FAN_CLASS_PRE_CONTENT, report offset and length info
along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.

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
index 5ece186d5c50..ed56fe6f5ec7 100644
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
 
@@ -526,6 +531,30 @@ static int copy_pidfd_info_to_user(int pidfd,
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
@@ -647,6 +676,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
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
index ac00fad66416..6136e8a9f9f3 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -145,6 +145,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_RANGE	6
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -191,6 +192,13 @@ struct fanotify_event_info_error {
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



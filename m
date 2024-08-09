Return-Path: <linux-fsdevel+bounces-25564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D4094D695
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646B61F22F57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD916132F;
	Fri,  9 Aug 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aaaKE4WE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47016132B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229104; cv=none; b=s0yDP4IZnDg5FIfiU79qtQJz1rL5BNoKQrVtKepwa+xNWshZA0/orPKUg5jsm1XFrXTXKZVt8fx8Za6dfyKA2JrYQdlw8JZCLsEFbXVJbU8d88KWqnwSb/LFDFymTfpZq/wOFz90+z4eMBSPUdkfn55v1Nvo2AGEpXuY3krVNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229104; c=relaxed/simple;
	bh=qausY9NaTn1Dmt/1fWvpjV6gSoo0TkpL7RjFx1j8ing=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StcBZuwr1x+8B/ee56KlTm4G/C25bFPSE+KfsC34asdlEASyO/D1kWdOj/NOHcM1NthWsNgMHuNfDVquNlEJEsSq4a4k30CzRs9r1i7tDO3rIiNxShGvbugwDY+krXgzVURsAZHXIGOkkoiENGkgvrQ/KJWH1t3kgpXwqSzBctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aaaKE4WE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d984ed52so143372785a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229102; x=1723833902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=aaaKE4WED7xO071vLAu6HxI+uzHP2qelp9+HDhwhWubshkNTfS/uL2er+MiRdA2kY0
         y/TLAzR1XhTZk8bDNXydCcHWBIYsAFgWP0d3tFoy0aEz2cKJDrM6ofJbzb4dOLIY/TMb
         q/itx8qCwGsVW8iKWFmmvVZwTAY80yiB2O2WnBCwPanGS5HrRujBbRBbvtYlDarthDu1
         X+UXleFniy5urnRGDFTgW++i1TpQ+8l8OMkm3ftPSCyrgedvbsjcq1k4PHIm5hybXSOs
         xuRnEjaqGJxoewRjAMTy8fCHgBV26lmH9U3YMXJAwKYfK21j9wxeFNphv5Tw/tR0hHh5
         ilww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229102; x=1723833902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmFE9zypkxWwtjgDkL/vbyJWxHrdDWRoGs2W5KUFOnA=;
        b=RCDAY+a6i12FHqw+6wfVL1fbbcJwTn++BAjn3togbgY4rbGoTS8veRGZjnR2N41OzW
         B8o7WNookyydNQEsxCS3WR4uCtCrANrctrEB/GQp9EBehYrlL0IcgOtyPP2A8dxQOrCX
         kRA1BzVbl+RZ2w5+IJS9Hx0z+aGaYvEofnTzvhclnuIEXoy69WPDy9x27x4JaPUc/xIc
         ZQYKOmgWUnm6QBBc8HQZonKCz/I225RRdRgKJ1OQwdtHtE7Szp4FzQilMVXfbfK9SrFF
         GifyDwEMeQ2bPEX9OQOadX/V0p8lQOBJZBuTrOfz3ydTm7lFxhFVSxTuhrDe2DMYlGGM
         dCmA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ON51woUfnD4zot2eCDUHSLpTjr/6JCqPVhUHhfHKJxz3QH2FTxAMM4lVNMkTEt3zx5YLrguUy7cqARweDQwy7awkUFvYZkxQXSGpkA==
X-Gm-Message-State: AOJu0YzoA8ya+x1wy9OXbWaCxaEmmyWEICsVldiKPs32LVmn0xoVByHI
	DQYqLqsxUvT7eZVIEMSDIPa9YNHRAiXbd6M2Z+1mIxJmBPmUgHQ6lT0oV+q124I=
X-Google-Smtp-Source: AGHT+IEkhpIMThqLGfjbj+pLIWeCnA5xHzdhnlhYpQZelrB1iG6KHPgcncoqW+ZwWfT8YtGLgnfUUw==
X-Received: by 2002:a05:620a:718c:b0:7a3:785a:dc1c with SMTP id af79cd13be357-7a4c182c833mr251102085a.50.1723229101933;
        Fri, 09 Aug 2024 11:45:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d829d1sm4225385a.68.2024.08.09.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 07/16] fanotify: rename a misnamed constant
Date: Fri,  9 Aug 2024 14:44:15 -0400
Message-ID: <13c1df955c0e8af0aee2afce78b1ea1f2e3f8f66.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723228772.git.josef@toxicpanda.com>
References: <cover.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3a7101544f30..5ece186d5c50 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -119,7 +119,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -174,14 +174,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
-	if (info_mode & FAN_REPORT_PIDFD)
-		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
-
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		event_len += FANOTIFY_PIDFD_INFO_LEN;
+
 	return event_len;
 }
 
@@ -511,7 +511,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0



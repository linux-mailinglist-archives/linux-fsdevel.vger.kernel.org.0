Return-Path: <linux-fsdevel+bounces-34933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC09CF017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357731F262BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F951E2304;
	Fri, 15 Nov 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ltJm4dKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE51E2604
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684692; cv=none; b=WHOMMrY8RazAdTDNQ7o7hz/Cu3wdoNP9F9LvXIbeA55+su6YVcY9STG2HGf/gKUnvCcxe35Ufqe91nxLE3AsGs5tG57PK74aRQ4k/Dj+Hp+iaFOL4udUqlQIUh+rXZnJS9RmBRHVH77MJEZXR3rzuP5eaGsT3W3QTLYZuaMoc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684692; c=relaxed/simple;
	bh=wJBpuZKjarBs8HwRCSHfMpMBiZ+HVYWNz5ARDhZnhyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLCX3aG7YH8fuUAbwJapoxAYKAfHEZZg476a94yNM+kC7plTpqpMInOvBl6DdHhqHX8UCwLYmfjbv3+OhmT0JRPGjdIlbF31Hlth8jZlbHHi3cQUurRweJyzbecLQAI8JFJUpTnmYUSeLPqQoDqjulUcyx2O1p3dzA22ypjJk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ltJm4dKN; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3873c7c9b4so429009276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684690; x=1732289490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSuoTi14zhdgmEJ2e8nj/BNpHIFoytvzNxhl/LStwJg=;
        b=ltJm4dKN44k/k08PR0/CGybK2VVIX2kgtAvtGVdKxXOof0zdjAHzaz4D5TomciJi+a
         NQi3E6Zco0D2BGe7U2dsZYDEEKhijFYBd4tDcGekI+lKEMDd0OEAe+PtXs/4U8TjF7/h
         rFqKYEfBr/YpxdtjFPWlc2V1tH8UQzF9YmFoaW4YU531apdjKdTZWUwWuSkUVgNPr3t+
         mGDGeJE3RByQiBqPc6aijx2deqAqQXMBkiAGMgfrQf+0lnlm3EITbvHrH05lWvp6nNgL
         OZNqg7B6+VK3fqgIJZZlg6noXXHlvb08j3XNkqbTHbYIIWTTZI/K/3aTlwjePjCXU78o
         uc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684690; x=1732289490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSuoTi14zhdgmEJ2e8nj/BNpHIFoytvzNxhl/LStwJg=;
        b=eGI5rmGmnnlbRICsysBUmXw+ocEoi8Yn6D3ld7BqfWX+eUPClwXDgpZkflDPbhGz11
         oITccppyw65nok1Mo4I9I6czn5o6hLVTjcG/UnfGp1eUHJOXy9m/uCmF7nZBPuT1Ryoj
         AQPqPoHRH6b1Rb4aZ3o321DAVLhPoJYa9/gCkRdiCq2idzRA1Rgsc6Uj4t2YYk3RPZjY
         GxDEp+kF6gOJZRQlX0Vp9CZ7lj917ewwOizMch8IvV+d7iddEqif4yPb6AH5Wrcuuzkk
         tBVKB4lnAfxXbA71p34iMVIWTQdItSc1UQMnOYh3fwZOZibRnXwW8jFzyExfEsujxjSr
         ilbw==
X-Forwarded-Encrypted: i=1; AJvYcCVox3DbKGsSLaMLgu+wqdJbZcDH2YD+gBqFDUazYb01zv0z+c50vSOEGPpwdcrXbu1MCthbiUBNluIAvQf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3Wk/zbSJTECY03ZSK/DXtPM1Er6te5maWjAHEfHkO6jBA0B1
	wEsulcH4e2PgFDuMeSeNYuZmEn8tIOS+ielT2VkbzVy7Z8FhXOW+nrWlrRpruuEEaubQjlD9lWi
	e
X-Google-Smtp-Source: AGHT+IHJEyVOG62NvWa9d1qggTtMCjzt+EKNCXFckK971VFGqKmUTAI/9H3Oo1mgh59gFKizdUDdeA==
X-Received: by 2002:a05:6902:1242:b0:e35:e173:3341 with SMTP id 3f1490d57ef6-e3825bdd813mr3265588276.0.1731684690002;
        Fri, 15 Nov 2024 07:31:30 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152c61d4sm989132276.5.2024.11.15.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:29 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 05/19] fanotify: rename a misnamed constant
Date: Fri, 15 Nov 2024 10:30:18 -0500
Message-ID: <8776ab90fe538225aeb561c560296bafd16b97c4.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
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
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8fca5ec442e4..456cc3e92c88 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -117,7 +117,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -172,14 +172,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
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
 
@@ -501,7 +501,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0



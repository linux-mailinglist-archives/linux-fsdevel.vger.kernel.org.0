Return-Path: <linux-fsdevel+bounces-50629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF1ACE1F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6EC3A8AF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC01DB92E;
	Wed,  4 Jun 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgQfxP7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6842065
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053367; cv=none; b=bWNVhKwrumht65aH1HBMjlGEUXyrG4XUj7kb1FKGzWfT262lh52uYSsk7CBs1xnrFt5q1gy/p68bDhiA9H1YQClNb3sub45Iahde/z9w8cxRH3wHyXZTFeveqdaOJF+x04eHTNyA8RKPRY+XMYNfRwvXiBTeuT6DghI64MiFBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053367; c=relaxed/simple;
	bh=HFDHTSkTC960HCY5afFPJtlKNekMsP5VZQCE9+LVLrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZZ7zlJziN3ysAnljjXOOrs9c2TmXIXZzZVfnFOfdDMo2vp/41J/IKMLK1TC4zkGVKklLsoA6Xm4r4JkTceikMIdo6d4Xp9+dB10myX2edOZmUofWOgH/6/PMEm/+E2gaGW+C7AHp+fQR6VXqBFbO3Jc+MSUIjIby+7lXhXv19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgQfxP7S; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so78690215e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749053364; x=1749658164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz/484adBJRE4R4ZsQ9EipBvLnjZ/r+8TuCDGk3KO7s=;
        b=jgQfxP7SFONvqxr4jk/kFYoYUPm2y+hApDH4yymvS+9mxEpdB8tyY7Dl8sG5vqe9AH
         d0dM6jz/F/WEXA8c5Nm4sZ1U8Hs6f+aLbbNbW0uCaxDKsOByWanWemfhzaIRfLtqFTE1
         ya/uyoUbXgUCpehk5FCHEzajknBmjraDLMAur5/Qz37Xn7J9nZwhZDYc/TqBz7QjsnsJ
         nZ6hSPsSdhRHo26Lsde2tx26/92XtW1U7GlC7DUSQM6vfYVbikCHqG39kg1lQbBgUz1K
         WGVaSSsoqgTzhRfRpNgcW91TxsyoZugtgdf5EWqE4fxi55LNAInGqolodzY8FBDwQ9Nl
         Jx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749053364; x=1749658164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz/484adBJRE4R4ZsQ9EipBvLnjZ/r+8TuCDGk3KO7s=;
        b=mgzp+dJXNVX2jcBp4UspkIWZIWzDNWFj3APdGcQmP2mOf7XeOjqvg5hmqWLgFwnFDs
         uupfKD8KYk0Q0vDYw7YmsoWeGtfLMs3VIQ+PEvtsnmJD/WnCWMjAoZ5SQjtSrGV1K5zu
         ajrP6YaIVwOlqOHgw/oo4HIyhhDKmKZntci4aamRAv7bfdz1H+Wn45JXluI311vKs32D
         ff6j7q4ftnyZZDmmg7bQbfGCuqN2HrpUtAy1Zd1PAQwQKYle4vW5lyN7o1g142lJWfQa
         HLdYvoho516WRoCLKMHJXZRPiBQDo7A+5yaS/gBQTBOtFVWCfZ1cfDC8QdcwzlqOd5cR
         BQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCW55zmYgD9MCIVE7lxtO7q/3JISZEee8DtPy9w6IH6M0DLOs9GyWzxYzRsfZl+M0wLAxm9rrvXFV31UDCb9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Dk64zNlrsQdFjzI8Lc1rzdVGWmwEB3TYgVQnHAWwypjd6g3l
	/lolYp1WGt1UZVXDdUvJkSfnQBCDfILn2RTGL2/MTu2oJI2lEvGxx0aV
X-Gm-Gg: ASbGncvZWkDxCyu50mfnEoxLO+JSvxJWCdSMgEbUppzu9YrCPIKvb1Gfqk9Ua+VP52v
	bNkh/nfxc13+YxiAO+lMbaUGvWohfDbGtQ6z0Nrg6h6VQVcNGJPuzghwaMjJz7a218gLV62xDYk
	PRIEBsQ49y/xo47PT4sSNuEmAmWEJGiaKcjQ1kbzSQK/PEUCa5k4nLWpwkd1exzu2cHZbn93TeL
	xshB2GYfrGB8z6/0Kcjxm2VugAzLKZL3MPMY5ZWX+I6O7EFbnDX+UTkMqzeY8l/t66SNy4PmhJn
	iywJzNLhcnuK21OGf4WrGTZpar0bq0txxP5ejcPXumrXWvfNufIc4gmE7EnpCuzNZojuLAvg5iW
	4hs2y59K8e46vk/YHSDnSzTqfz6CECqKAGzXO6UGy8RPwTTYi
X-Google-Smtp-Source: AGHT+IHvu1RfU9vN+XmGNbXjimd4bPhSb1LJ0ZWe23L4owYYJBemcHRv6N0bO7mO3z31EifmRAwV5w==
X-Received: by 2002:a05:600c:6298:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-451f0ac62ddmr32219215e9.15.1749053362979;
        Wed, 04 Jun 2025 09:09:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a1678sm22304306f8f.99.2025.06.04.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:09:22 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] fanotify: allow creating FAN_PRE_ACCESS events on directories
Date: Wed,  4 Jun 2025 18:09:16 +0200
Message-Id: <20250604160918.2170961-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604160918.2170961-1-amir73il@gmail.com>
References: <20250604160918.2170961-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

Like files, a FAN_PRE_ACCESS event will be generated before every
read access to directory, that is on readdir(3).

Unlike files, there will be no range info record following a
FAN_PRE_ACCESS event, because the range of access on a directory
is not well defined.

FAN_PRE_ACCESS events on readdir are only generated when user opts-in
with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events on
readdir report the FAN_ONDIR flag, so user can differentiate them from
event on read.

An HSM service is expected to use those events to populate directories
from slower tier on first readdir access. Having to range info means
that the entire directory will need to be populated on the first
readdir() call.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250402062707.1637811-1-amir73il@gmail.com
---
 fs/notify/fanotify/fanotify.c      | 8 +++++---
 fs/notify/fanotify/fanotify_user.c | 9 ---------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3083643b864b..7c9a2614e715 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -303,8 +303,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     struct inode *dir)
 {
 	__u32 marks_mask = 0, marks_ignore_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
-				     FANOTIFY_EVENT_FLAGS;
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
@@ -356,6 +355,9 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * the child entry name information, we report FAN_ONDIR for mkdir/rmdir
 	 * so user can differentiate them from creat/unlink.
 	 *
+	 * For pre-content events we report FAN_ONDIR for readdir, so user can
+	 * differentiate them from read.
+	 *
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
 	 * to user in fid mode for all event types.
@@ -364,7 +366,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 * fanotify_alloc_event() when group is reporting fid as indication
 	 * that event happened on child.
 	 */
-	if (fid_mode) {
+	if (fid_mode || test_mask & FANOTIFY_PRE_CONTENT_EVENTS) {
 		/* Do not report event flags without any event */
 		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b192ee068a7a..9d7b3a610b4a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1411,11 +1411,6 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 	    fsn_mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
 		return -EEXIST;
 
-	/* For now pre-content events are not generated for directories */
-	mask |= fsn_mark->mask;
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
-		return -EEXIST;
-
 	return 0;
 }
 
@@ -1951,10 +1946,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
 		return -EINVAL;
 
-	/* Pre-content events are not currently generated for directories. */
-	if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
-		return -EINVAL;
-
 	if (mark_cmd == FAN_MARK_FLUSH) {
 		fsnotify_clear_marks_by_group(group, obj_type);
 		return 0;
-- 
2.34.1



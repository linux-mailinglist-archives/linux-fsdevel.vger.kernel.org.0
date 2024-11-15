Return-Path: <linux-fsdevel+bounces-34932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26259CF014
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EDC288431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984A01E2610;
	Fri, 15 Nov 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WgCxMT83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D121D7E21
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684691; cv=none; b=huuOph2MueiM0Z++IHgWO4y6lMCd4oP9jCMqQJuTeRB1Bf9QRViRhGrvbkOJmkaAzULgdri4SCYeC2WO/XNT9s1NMr+JkKhctsSoSDuiq69roKHYFNt3U7ksr6ILIZ5mElL512NUbF/Fvtri+pmPaEfHk7GhzAWJNnOsYF7j9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684691; c=relaxed/simple;
	bh=lJOFXxVHcZLI+SjVd+0f1jV7QzcPV4Ai9MyZQsFymWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMzGb+y43jGFv9ftNz179CuFeeCgq49zZEPmR2LydNTAy7X9ucYnIf6KPyoue9vmUU1OJ6gU5mAiFSdO+kXGj6uWt7M63MisWIxrDeUvZip3y3yB1AJRj33H4Np+CP8j7WEwiJ/CnRveUTN0VG3S2m4eJN2Fn1ipMh2czIC9ARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WgCxMT83; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e381cbdd03cso1493185276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684688; x=1732289488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jVczlJ/TW6EECuU4gj9yYFP++VZ/oJUqPiY9P+PdPU=;
        b=WgCxMT83OJndjUPd1bpnut4k1njFzRSZT+45Xv3MOuEfIXNhQ8xGLPxT0GqdDQHzNP
         3FAWKaE95mHY8cUM+/Z5QrkWB0K2NYjSpt+ynKmwctxgJinxlfalSnXxa8fOhVKxfb/r
         tf9/isOH+Yy4aOI396zxw1OlUitAZJj1uMr/FmQMmtcFWRgeXhdZF1/+5AnF88+K0ilc
         MC9tIpVfjIx/NdV9UCRqJaDktOuFLyAn5ypGjSbY6Kzd8xez0CWvSR9ZXhOdtDojIykm
         hIY+HUEro6Ry3Z00n1ne4KcwAg4GG0CxfnafkIR/PjPfO5G+FTo/yMRJ4Yjgj1LodC5Q
         NxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684688; x=1732289488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jVczlJ/TW6EECuU4gj9yYFP++VZ/oJUqPiY9P+PdPU=;
        b=leMCS48bVgBW5VxMa7k8E4Ibho8T56ycTk4PteItU5MJuvd5DCosU7IiC0NCi/oCnk
         3oPl8NwYeZvtDCVRYqRHce3LEsJX6VX4FjUoWoUtC+Au7bk+90f3VG+T1w1akD9dLYZh
         OKq9+zAabew16lHYaGgVODUl3YkXZv/oUN1Pq7RLDJWwqxaFFsRJr0Fnps1AYkjhP7g8
         OffaeEz6R+Z0s2YwkQoHXPt2Qw1EztyA2TkIK0VHkdPGDEjPpI//dhsAudxo2lL8v308
         2u0U6HLCRsACz47H/9vdigb3FnD6ORfG49XjbQlZjNEsglaTFs9LQgS+nDacfM4JgD4p
         0r+g==
X-Forwarded-Encrypted: i=1; AJvYcCVmvOPzpXeXmdu0tkDKwsr2tpQ/jQmTdG1t8qCQqqMZdp6sOgJy2tMXhc/MqP/AE9ijKE1ot4bTnoLps+Od@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5sE6MxqZgQVMK8frtLgMLHVI9c8FHFK25XlK+dMQ2SFstkHUG
	U+oKzDhu97PsZ0FKd1RKFOVLd3rawXqnJl+lmDeW+XVdL8bLbxgTy2O0O4+IW4A=
X-Google-Smtp-Source: AGHT+IEWEdrPnRli1gv+jVnLYsORdUcuZyTi/FsZKRBYcdcM64Io8ydfsi1gmscyy1vF3dAQcsDh6w==
X-Received: by 2002:a05:690c:4c02:b0:6ea:2ac4:9df6 with SMTP id 00721157ae682-6ee55bbade0mr37073597b3.3.1731684688405;
        Fri, 15 Nov 2024 07:31:28 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4449516asm7602087b3.124.2024.11.15.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:27 -0800 (PST)
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
Subject: [PATCH v8 04/19] fanotify: don't skip extra event info if no info_mode is set
Date: Fri, 15 Nov 2024 10:30:17 -0500
Message-ID: <afcbc4e4139dee076ef1757918b037d3b48c3edb.1731684329.git.josef@toxicpanda.com>
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

Previously we would only include optional information if you requested
it via an FAN_ flag at fanotify_init time (FAN_REPORT_FID for example).
However this isn't necessary as the event length is encoded in the
metadata, and if the user doesn't want to consume the information they
don't have to.  With the PRE_ACCESS events we will always generate range
information, so drop this check in order to allow this extra
information to be exported without needing to have another flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 919ff59cb802..8fca5ec442e4 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -158,9 +158,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (!info_mode)
-		return event_len;
-
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
@@ -754,12 +751,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	buf += FAN_EVENT_METADATA_LEN;
 	count -= FAN_EVENT_METADATA_LEN;
 
-	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
-						buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-	}
+	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+					buf, count);
+	if (ret < 0)
+		goto out_close_fd;
 
 	if (f)
 		fd_install(fd, f);
-- 
2.43.0



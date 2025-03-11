Return-Path: <linux-fsdevel+bounces-43699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E626A5BF71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648393B3395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9BF254879;
	Tue, 11 Mar 2025 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUo6/5uW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3D2561B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693325; cv=none; b=kd+wq8aOK3rl0O5s9XTT8wRDBahNV7l3yLyrgvLwptMFsPS+CEfcgi4Q4dBUbooMfvqs9GvmQmBO6Z8JpNcHrXU828PJbXDWceoAPIyj1YO0BBGhG7LqLXPfrdGa7L92NYgrFTfzbJPhPL/cm0pj43K7nKSjVH4lngQMcrIS3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693325; c=relaxed/simple;
	bh=Bq1sJYsyY7SmmtyVoHLTJ7RwhSzjxyvvaNHE2BoP5o4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHXnKjpctL2n7F8yYMtm7sjcZJumeOR8zlf+XPJ9rhO/mlYsoqqKqIWeGNzCppsKUiiZYAS4pL1aXH/Fe4W6d5RQOTQ9JKVdXLMjX/sYPHURinajw277Gw4p4FTmiyObItT5JclqenLWmyoqFySWT+8JeXk5kmn8ww7IpsKv3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUo6/5uW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso9935005e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741693322; x=1742298122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CJk22BJz8Xn8B3iCqwMnyA5UrA707UUiR3U0dZkau0=;
        b=JUo6/5uWA7YurD40tlehlyJ+9UqwyNnuxe3PyyuqP5o9qSGQXed7KvhsSpLuEQo185
         tpF5SZxMRWUO3ID7SjcBeE7V11o/vRZpBscz1x7X4cHeWGdiHfecc7TL3e4HRpmgzHxs
         gfVW8b/Uzy5e44tlijGg7z6g8R7XBgwgCoq0azBQc7dhIXpGfy/cCW71cCxPmSPVAv0T
         y74k2DZGwJc+bEuBDo3Erundg76jwa0TIZEYA2QQXnUGagYMcX5fx9Z/imTvYQMO0UA6
         DDQmoxkv1XIXjp/ph4fEtaW0VPbox1YeAlR2cIw+85Y9KQ8haN9LCpKTk38iBCXNlIGy
         RIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693322; x=1742298122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CJk22BJz8Xn8B3iCqwMnyA5UrA707UUiR3U0dZkau0=;
        b=gSZKAkM/eMQoB0hrS1m/SPkcBzQ7EOFdLQPKKCvGGJVTX8SeZn/XvVkji0cf14QbPm
         cB8zuIbSs9e1Nvgn28UxxIFewx/YuWnWI7Sft5rbATuFrvyFvguL31SqwhBVrw4bn6Gl
         ma4QqemuzuOUXUMMZ4PMcSb70bde8y2H+/+/xRyQpgqbCDQ3gzL+NcaBp1+WSN6UlpTs
         l+vLDrKW/tl/7dMcjX331m0srOiUrfZkZbLG2qfdt3L8z9PRXrhG9YOwm2LcyKu9TeHV
         oSIer82SbRzUH0OEVNNmUK9ujJ48R2sN3Fa66VEByTgUUIaj2Wh9cfVOd/eaDM6ygeIh
         +VBw==
X-Forwarded-Encrypted: i=1; AJvYcCXbXchuC+Wd94X2LhR3loeOZz98vTD1yQAFXvgsqGCJ43VK18mA7Twmra0b7h7uRlwA1naKX5rvw8BLNkgC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7eSzp56B6vg2MAMRIVgxo9iXiWFCskgdpGFRibwAELwbMQLX/
	FDgLGKPZwpI8D9U4vZG6ZZy6MSSBGG5fqoGA/uZIpfDU2iHORsvK
X-Gm-Gg: ASbGncviGLzK/aHUgCRACy+YzB4BtBYM2semSZFsP0xrnFvdug9g5S7K5pRidLgu3OJ
	Kf5+cJCBRrtZ+XZTI9PqDzDFNCHv4Y2xs/p1sqKpkh8xh9HMa9AWxDdQGLOXyZleMWHDcOVWxse
	o/SEmFTNJx++hTP3Nlra3hkbpb5Wrb+8hSMwMDBhk+sEqENgdP6MvcGzdJ4E63KRnjiRBZle3mR
	FNS4fU72GtN+x3M+ESBzsvj5qlRGPLVDuwjAtvBT5b4eqTWNDGZB0SD6FPG8b97Byz+DrvdBdcW
	NAJG1yexKPep6WMOb+g6VeHGALdBigowy/oCismueQeypNfo1bg4xHgXvKIIcFnRbwQA/boMEDF
	DIvVbDt1PKHYE5iDmxDR4P+0jXXxBggx0T1TjHiBjrg==
X-Google-Smtp-Source: AGHT+IEVHzwQ04qtMKlf95A6L6Vuza+31cxNZYdOvBdcl+2F0s0ZZFvghbzwVS7/hg7im2AE9ODgrg==
X-Received: by 2002:a05:600c:4708:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43d01c1e109mr40936175e9.20.1741693321342;
        Tue, 11 Mar 2025 04:42:01 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea8076fcsm111297525e9.15.2025.03.11.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:42:00 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fsnotify: avoid pre-content events when faulting in user pages
Date: Tue, 11 Mar 2025 12:41:53 +0100
Message-Id: <20250311114153.1763176-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311114153.1763176-1-amir73il@gmail.com>
References: <20250311114153.1763176-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the use case of buffered write whose input buffer is mmapped file on a
filesystem with a pre-content mark, the prefaulting of the buffer can
happen under the filesystem freeze protection (obtained in vfs_write())
which breaks assumptions of pre-content hook and introduces potential
deadlock of HSM handler in userspace with filesystem freezing.

Now that we have pre-content hooks at file mmap() time, disable the
pre-content event hooks on page fault to avoid the potential deadlock.

Leave the code of pre-content hooks in page fault because we may want
to re-enable them on executables or user mapped files under certain
conditions after resolving the potential deadlocks.

Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
Fixes: 8392bc2ff8c8b ("fsnotify: generate pre-content permission event on page fault")
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 6a33288bd6a1f..796dacceec488 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -137,6 +137,14 @@ void file_set_fsnotify_mode_from_watchers(struct file *file);
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
 {
+	/*
+	 * Temporarily disable pre-content hooks from page faults (MAY_ACCESS).
+	 * We may bring them back later either only to executables or to user
+	 * mapped files under some conditions.
+	 */
+	if (!(perm_mask & (MAY_READ | MAY_WRITE)))
+		return 0;
+
 	/*
 	 * filesystem may be modified in the context of permission events
 	 * (e.g. by HSM filling a file on access), so sb freeze protection
@@ -144,9 +152,6 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
-	if (!(perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)))
-		return 0;
-
 	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
 		return 0;
 
-- 
2.34.1



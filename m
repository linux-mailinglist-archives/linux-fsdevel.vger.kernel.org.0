Return-Path: <linux-fsdevel+bounces-72044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE9CDC291
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E8A301C944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E92E88B6;
	Wed, 24 Dec 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1SOw21c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2581E2834
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766577200; cv=none; b=bIicYGJWVox9Hyx/kSBK5coyyoW938TZ8N9Ybtakoz4F9NjXgRXe2h6dE9KcNhaAeLNr1m0e8FIN+CbN1LSunPrNyAZYrQMCeCCN2uZVlbryI1VCwbHTLdBqxADJi7S5lQYcV9f4SLgBDnY89FCaUVSu1hojSz4Kz43fOoz11pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766577200; c=relaxed/simple;
	bh=VghBC1b2o+YSQemYhQvg+LW6HMuJevii9eNd832oz1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVDJZneEnckMcHWYC2oUmqX4p8GxzGyQxEAJH7ydXdd0rTUndARvv2CEzmY9VevwHHjiyosp8o5TmhiHxj7/VUqDH1/4cnoFUKK6iM5lcKZWlL0cfgTeURz2HqUvqKP8e9biqea7ENCkM9bKjgWNu42ZWozrZyXrqMIvwATy/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1SOw21c; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5959105629bso5831408e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 03:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766577197; x=1767181997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V8YUcaf/+H/QKaxsmZyXiuyc2oeBQf4LAuC8T+FhL/0=;
        b=D1SOw21cHBDLHtpE4FEUXE+cqGeqpmgLiWll8IF3xju42Z2W7L3RXBL3Rh4eji8YU8
         FdABoo2KvGDv6axDCgacV7Z4bf0MsOZsmz0MupbjaoHhpnXDPFMFcPWhGvRIT8BXuDRV
         8RyZMBFSm8p2LHVD5CyMrOsES1PnxVMMyh6hiV4rpGFb7in5n3ZE40+Z3aHW5p8ZsOqk
         rouTY+robbL60OhHZ93IAC4MBDJ4BY02EgJ0fGvF7iQx1qmWfBEGItGlzkfcSCmhiRiO
         GyuEJlB/+2jJaQ8pKprP+791oNucI0ctjfV/T9S7C3jYGTHJJq49Te33RkXsD+diBSkm
         gMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766577197; x=1767181997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8YUcaf/+H/QKaxsmZyXiuyc2oeBQf4LAuC8T+FhL/0=;
        b=X0l7EBLsq7pF2Sr1H3w6n3Xvj2FzH3UkNtO1qyitJ0oQZkMIIyrjpAAoPKIr623GX9
         qUpV3mhoYtBZecDV3vYuU3MFEYn4dLx15ZItvyzefRj1FLpt3sagAe5fhJerWsfUeNz8
         nFpjt+HVtGojFdLS/nkDzurPNxtX5bg+6axG6PCOv2n2aB0lM8Tx7LeBuAeXTS/SJCPS
         n6x3Rog0YpDJ+Ok+gsYVoUf0f3j1RgZ2aqc9FlqTteQcqfXtkALC/t5H3j3/l+Ze3R0N
         PtzRkwxGOt9qFiUbLqSmPmXTwU8hawwJuV3SFgbHDfEBwH0Zsa3zQfSg4QE4bynqBMZS
         o9xg==
X-Forwarded-Encrypted: i=1; AJvYcCW4qqdraBqM4MVoqqVuyMhDbUidCgYWGWawv5m/FOf+MOMn3QIlxyyHCaCJMJOZ6DmSMlYoZv6pjnkPB/1q@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLhFQQw0sGFw8acx9+1NRVOybQ3BDfnRZSS2lhJOjZq92J639
	eb4W2xO9t8E/3YVtrtnou5TN1qKdMeh7H/zROw8uqL34uly19dBFbUFW
X-Gm-Gg: AY/fxX7ezvPSXL3GAQ0N5JIZgurU/3rPdo+u33uYpc1wKrQ+AF0oybnJ+/3LTA8Tp8b
	FR/h5fh/gKy6H8QL5eQNs5fyv7jqSIgmCQJzpTnQ3J+GfkFC0arFnDcHtc68S1s6BEaowaioawc
	R6pD1pdD0elVya0wViY4q3JtE8y7IVtDo30dPnyOVaRsE74pDSZvH2uQWvITMzDIbMN0sMKOOzO
	ZM4aqCZ/OxrK3MewqEOkGY9MnanXMvUCWxX3RI8vmO58G8sJangMuUzpX34/jYOnvJfB+m7nQ9N
	XPzItv5vEERYh3vrycp8sjyZNvVpZlgQFU3JHDqMiAd37sYlZfMCzBeZsnGsfLEXCFQkkuuVQz+
	bIUaa613M+Za6hSxWQ7HSu3lWXtfidLXkX81Ofdro4z8ONORr91VS+7TNRv7EYjl85jpfyeneAw
	zdRPl0WiEClqjxaJ/x+NvelQHwClmVXmK4eQZJubqQHyBHWlrCrIu5hyI=
X-Google-Smtp-Source: AGHT+IHl8Eo9AGUWnMOS6OLlY8nnfRyvT8wSGm+8a+ZcGoLGwGz2KeB3ggknYBIzCKI0HX26v2IIwQ==
X-Received: by 2002:a05:6512:39ce:b0:597:d765:19f9 with SMTP id 2adb3069b0e04-59a17d057c9mr5575656e87.4.1766577196486;
        Wed, 24 Dec 2025 03:53:16 -0800 (PST)
Received: from mismas (filipovv.starlink.ru. [77.50.205.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185d5d7csm4847935e87.20.2025.12.24.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 03:53:16 -0800 (PST)
From: Vitaliy Filippov <vitalifster@gmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: Vitaliy Filippov <vitalifster@gmail.com>
Subject: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
Date: Wed, 24 Dec 2025 14:53:12 +0300
Message-ID: <20251224115312.27036-1-vitalifster@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_atomic_write_valid() returns EINVAL for non-power-of-2 and for
non-length-aligned writes. This check is used for block devices, ext4
and xfs, but neither ext4 nor xfs rely on power of 2 restrictions.

For block devices, neither NVMe nor SCSI specification doesn't require
length alignment and 2^N length. Both specifications only require to
respect the atomic write boundary if it's set (NABSPF/NABO for NVMe and
ATOMIC BOUNDARY for SCSI). NVMe subsystem already checks writes against
this boundary; SCSI uses an explicit atomic write command so the write
is checked by the drive itself.

Signed-off-by: Vitaliy Filippov <vitalifster@gmail.com>
---
 fs/read_write.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770..5467d710108d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1802,17 +1802,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 {
-	size_t len = iov_iter_count(iter);
-
 	if (!iter_is_ubuf(iter))
 		return -EINVAL;
 
-	if (!is_power_of_2(len))
-		return -EINVAL;
-
-	if (!IS_ALIGNED(iocb->ki_pos, len))
-		return -EINVAL;
-
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return -EOPNOTSUPP;
 
-- 
2.51.0



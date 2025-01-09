Return-Path: <linux-fsdevel+bounces-38697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B25A06CB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 05:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DA21889B27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 04:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020301632D7;
	Thu,  9 Jan 2025 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzPmzwt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2F748D;
	Thu,  9 Jan 2025 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736395986; cv=none; b=UAyt1ipV70eKsmJNvlK4aHvqFb9sSmiSy/NYz0tXvCSfK8y3fZxWSnqN1gidECvFhqVniShoZ52A5JENO05Qb9WvMSDfPskTQrCLd5iM38hgX4M4ErAtuoKIbwZzFQHIg7TDDPYY1FxLxu5vP1F7NvrLE+KxoxTa0D8xeWTuX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736395986; c=relaxed/simple;
	bh=IosNVrMyOys2/sHP0x62sUU7TuKKilvAezVmHFxMC8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lB/Ra1jdKlg/DXTIvV3pZJ97xCTBuSHlNEmdN1uNFtCs+x0eBUCcX1lRWOWZDzGqIhHZzu4+JzImhC6lraGXtrbTdEI3rNzQIPsewGp86E6yU0GbE5kQEOtvycjmFSt39mlXb/t3Q3BOks0RUdO7X/bjuETu0XGQ0jOsTtrXwYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzPmzwt+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef748105deso657854a91.1;
        Wed, 08 Jan 2025 20:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736395984; x=1737000784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIVH3Scel17p+d/8kKiy/AmNvkOtagV4u8jTjsivW9U=;
        b=hzPmzwt+bTM2TQSmwOfxTeM76njRLvfu4IOn6u2pNiTjVn6TDtetfa5H+wckRtISNc
         u2+lrxEB6bKEBen0i316H0fqxsPtaY/D+S9vxqabPP0nHBqDRhnw2J3IyBSaHFB3wmbX
         pcMmGDNcO1spCRbh2F8O1WpRKUNI4gM3+/dJ59fVyvWhJFOD0KFlrwPn9kcofcLvXFWB
         cYEdBKuCtJLYo5Xd27gnhNq+BZTSCn77bHznqa2ob9niyW2sJZSSer4tgyU5Qf7RrnCt
         iUkrMvbMmoSXmu48/c4bih/x3TsdC6SVTpu3NvC1WMGggzTC5olHjDBTLzz/SP7mNypV
         LwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736395984; x=1737000784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIVH3Scel17p+d/8kKiy/AmNvkOtagV4u8jTjsivW9U=;
        b=ex+dzu7ZKfVRT2mwa/LABMXGHFii4KhNtaDY5HQ2uemO454rUcPJG16XAhi95y0/aU
         FEei9JN/HrzB8B4h/HJGegLlDjWoCPgHYDIZF+zkE8s/T0gtiGQEN9AKFmMNCxpQswtv
         adWr5ltwLXmZ693i5N6YHr0H+k48iMSXruEiLs/i4Yqv5cj+3FaOeIGV6K6eIKjMb0JN
         l3kcLSQdAsmNqU6Ysi38P5IfF7dc3cnWzC/U54XfissmCaUglXqdkienGLtm4VmafFwX
         d/lQaAZU7xmgnCBp07xUaP91Tg7+9rO9kg090eQ8bnzCrOMpSEsRpZhsmh2LUS3NRKVB
         ml8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb+heDLMntpI76nwJnYC+hxv+TZV+E67Zj5iLu4gtg7yU5OK5HXxbbL/Ryekn3IxWBVhQb6CT5RVB/8ZwS@vger.kernel.org, AJvYcCWEM3ns8fBnFIyTSeYDqTXDSkmzqLcFxvWAzMXOfJ1fbOppqpB+cF14scml3kY4OTLTGII7yNBXNulL@vger.kernel.org, AJvYcCXKT3LHQRVyfI5611vEeJ4orsu07V/Q0C5uVxM0geXdSubkp4FJ22qdtimKI4ppjP3SKifNpaX6d5UQqv+p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37ee763OhJcskUYcB5DUnM98kEJvWcktAX2IEAVrqHU3zxmUB
	EgUxHmTyQ5ipHNk4vDKvN28xWBGdUs2MU+sJ+e5RFGahzoFd5c3/
X-Gm-Gg: ASbGncslKPOAKSW4l9vub3Qd3kawiGk7YTp0zswa74hirgcPMHmB1zPtYJ4tM8jNdvD
	Zwec2AzPZg2Jy7SyLzewzBhWHCH5hBzu8spESPnomOZfbSIInK41/vYGmkTBRelvAoJNJsgEwhI
	gy/9jS2wewuiHHBGRtdZKpgaImZZZ+BCNfd4I6AzFNDdveOtA6G1HCXSJWuFV0ufJwiGz9MjLs4
	fN7k6cUuWrLdHROKYeRETemb+mbcD/Zl/+XmGTs1BOKxPVgeJV/v3PWZrae5BFIOXXMUJS9elub
	NC/NT0tT+N1ObB/QYvISSqw=
X-Google-Smtp-Source: AGHT+IFMNGIpZy6GGLZ0r+vc/nreif7ggLUH6m4cdxfpIiDdPlELtuJyM7ssVoD67R3Ja5EfN/nxsA==
X-Received: by 2002:a17:90b:3a08:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f548eabdc8mr9944588a91.12.1736395984173;
        Wed, 08 Jan 2025 20:13:04 -0800 (PST)
Received: from perforce2 (75-4-202-173.lightspeed.sntcca.sbcglobal.net. [75.4.202.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad279sm2462014a91.25.2025.01.08.20.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 20:13:03 -0800 (PST)
Received: by perforce2 (sSMTP sendmail emulation); Wed, 08 Jan 2025 20:13:01 -0800
From: Marco Nelissen <marco.nelissen@gmail.com>
To: brauner@kernel.org,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marco Nelissen <marco.nelissen@gmail.com>
Subject: [PATCH] iomap: avoid avoid truncating 64-bit offset to 32 bits
Date: Wed,  8 Jan 2025 20:11:50 -0800
Message-ID: <20250109041253.2494374-1-marco.nelissen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using a
32-bit position due to folio_next_index() returning an unsigned long.
This could lead to an infinite loop when writing to an xfs filesystem.

Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 54dc27d92781..d303e6c8900c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1138,7 +1138,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
 				start_byte, end_byte, iomap, punch);
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		start_byte = folio_pos(folio) + folio_size(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.39.5



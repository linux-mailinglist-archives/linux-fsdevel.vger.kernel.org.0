Return-Path: <linux-fsdevel+bounces-55030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F40B067B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18567B2FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3C277CBD;
	Tue, 15 Jul 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEKErnbo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874727280F
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610973; cv=none; b=JcDVaOHKUahrXipSgOCZRnc99EkPf6PF+2xA1ynPAA2O58LVd/wagw8zQgLuE+HZy74CsmqzksM8F+zYXcTA+KdsGpP6n+iaVLkOLImJaayZ++kGUhwiH1fkHyx3MCU1PmVGUOC5H8baDBEwtY+J7JDg7BRRS++AyAJxINs00us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610973; c=relaxed/simple;
	bh=MDf2njSG+bXKrqQCpF2Ie94r7nXASDCq3cz3gr1z+T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5PYLQ29hcO65f8rVhBdwSmQYTvdQ4Rtbi5bS1A3ozkeTYbsLOzwOON3pSEHcO3OCwiF1GVS8slqAZpHU9Q9JdDW4eTqm7l3D7YNvhLudu6mRtjm6F71/ro3H4N48fnD3apKZE3wg+FCWLwsmGmz8BWKqbAvX9bd24rz4uVWMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEKErnbo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748feca4a61so3376615b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752610971; x=1753215771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJ92AFV/99R1rXC4DsaoEmqJwnnG3rO20M4oHDs+YTQ=;
        b=HEKErnboltDrz/UjW+BaZmZm47eTadedE+pKHwSkxxy7Ps4e0BI4Dgw2MJVQK8l24L
         VrlSwJ+3EF+UDsHQKz5M573BGkHS2BSeSxqt4RyZ6MNzEszBg9tcYbUIGrh2hSt8LDA5
         JIh0wbS62bshX5m7XKsoo3xwmxJr1IfndGm05jn1PO8NYyar0fg9qzvXQmYxhHPaJQQy
         U4H/q/dbJbDtGAUusmjrcRkuUgfmPF1WgQG83tmih5IN8JlBqgSef7Fn7k+Mv2u8ohoY
         9WMZm0Kp8MwuWryP8aJC/qrj07x5odLI1aMAnWIE9A7IbuQ9sLxRIiW2STpV6r0KqdXH
         VZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610971; x=1753215771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJ92AFV/99R1rXC4DsaoEmqJwnnG3rO20M4oHDs+YTQ=;
        b=TLuPWytuogcRFUmYiut39X+RkXyVC7xqpMMm1uXIeCoO68bFk2+c0c4ejlrhGhySoR
         Y9WYApi9c6zeRSFLMCEQbJ7csG9SwiZcjHoBjmi+FUNuz/ZrN6LoNi8RtzmjmMgY3rI6
         +h3ex6Edywu3Bo3QTh2U6nFjmLnZ0ip5mYd+XAI/lMkVAEYLifxzkHcTE3OMdNvWUxl9
         hZHKtQvQiFSr+6V0JrYc9T2yqc4ZhN8qp8NPfFOsGjzy4N9f65FC0K52+T5NS8VI9JTx
         dCzDHDUEXE9DkHajzXm2uY7P/N0qrL5JS4IiMJy0+u86uRRkUwJv1ytPQx/NxqznSUho
         4l3w==
X-Gm-Message-State: AOJu0Ywkzos0nfGHkVlWyQ7hnNvP/PzjIIu8YyyfL1dndmpbh4OP7awP
	9EzvnJMoe9po29ZkopPmmfI+JyrVsrhsYJs3OCGmU9mMm8gP+jlmbRYe1/JUTQ==
X-Gm-Gg: ASbGnctY42Dk0pNpjItoS+q/GeZZLob106ci9in/NdjHEuEBQoK4ORJX1ZHrTyJL/6T
	AtiyhuJIydqT3NUEqTofSSDzb6CHW9UM62nvZL6werJRhq+R6E4f4A3R3T8Go/dH82ZagL5eNSW
	0oJ5/s5WczuYON5Xr5S86wnieOjwu8Z0AETiHt8BC6q68yGouyPH4dW57g3LOAUA/S5FnVX4R9e
	L/aZVzkD2R7uN4mRzx5vSQLSxd/fEDZJcBJfegBy1fy5F3k7qvavn1HWwFLnz60P9N0vOgHt+d0
	DKcM3WexG0MTkBaLefE0oKJMZ/5g6wTjfOlE1t7fRvgxgqwUjGU1NuQUrhvX6WfEb5gfX/+d3xe
	jRg2Z1k/4g1yXMX9+og==
X-Google-Smtp-Source: AGHT+IGp5sTGjASUgfKwH5cpu1Xf3g7pez/ZBDIwetLr8T/tZtW1pA30eGvXVg+Ahfx5fyT5NOIPeA==
X-Received: by 2002:a05:6a20:6a27:b0:204:4573:d855 with SMTP id adf61e73a8af0-237d5602029mr985616637.9.1752610971139;
        Tue, 15 Jul 2025 13:22:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f97e31sm12145852b3a.176.2025.07.15.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:22:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	kernel-team@meta.com
Subject: [PATCH v5 4/5] fuse: hook into iomap for invalidating and checking partial uptodateness
Date: Tue, 15 Jul 2025 13:21:21 -0700
Message-ID: <20250715202122.2282532-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715202122.2282532-1-joannelkoong@gmail.com>
References: <20250715202122.2282532-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook into iomap_invalidate_folio() so that if the entire folio is being
invalidated during truncation, the dirty state is cleared and the folio
doesn't get written back. As well the folio's corresponding ifs struct
will get freed.

Hook into iomap_is_partially_uptodate() since iomap tracks uptodateness
granularly when it does buffered writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0b57a7b0cd8e..096c5ffc6a57 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3109,6 +3109,8 @@ static const struct address_space_operations fuse_file_aops  = {
 	.launder_folio	= fuse_launder_folio,
 	.dirty_folio	= iomap_dirty_folio,
 	.release_folio	= iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
+	.is_partially_uptodate = iomap_is_partially_uptodate,
 	.migrate_folio	= filemap_migrate_folio,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-- 
2.47.1



Return-Path: <linux-fsdevel+bounces-59691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C61CCB3C5E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB24B1C8833F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD5313E2D;
	Fri, 29 Aug 2025 23:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg8OTDUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79335CEDB;
	Fri, 29 Aug 2025 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511912; cv=none; b=XVRzdszkE5acu73Lyr+sAUQqUHKTO8fVb0TAkeaF9LvqH+azLSXNcG1JCOxxNwjz1M0HxGu4oZpmVZ/lMCAOyEJUJJMGV3+xcnIB+zRiOndmeU83sTGgy7corSdtQCcsESAx2ODEvzQC5ePe+gYgEpbIm5Tw2JvDIi9rNhvDda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511912; c=relaxed/simple;
	bh=tULi19VuK6W2Dsx8rDO+AVgBWxfSFw+rkERwnHq0h6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6c6+opRj+fUkDd2sX4ykCGqMN1sRvAYuo9a0P3jytx2fB6EBvRK5YebGYccCzi96BrVht0HimSVA0HSRnoCfu8kKSlQRRkNKtz28BvcsHkL2wYqnB83oCujFaaJQE7JHYoyulEGT50bba7ljZni8zlLVFfms+OUCq1galqIfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg8OTDUH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b482fd89b0eso2265110a12.2;
        Fri, 29 Aug 2025 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511911; x=1757116711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euTaLWMvn+Jbnp1yX2oDNTK21ZlqMYAjAJ39ZJmlIdw=;
        b=Bg8OTDUHXZZZrPXAr2U18KTY4YX3RlWa3YC2ZS6dgW0P4qFdJXoaiBxwP5R2U4k63I
         rNhmxLsJLIoRa1FYF5ERO9bTrAxy3t7nf/mbmnNUoGbJaf3DWMQg9oa5jLmFHWG2WEFt
         zA3sY8NDFmDC3StPf31hMy5McIT8fYwdKKIk5MB2c3IgwrZmibkh8/JUuRoojlldHcvo
         jIPdzWnBc5NlzyUeZ6V7N2T8AgCisXwmO5SiKJ/gWzGPV+3/z+1BIPhsRVyQoH3jYW0X
         JdUNRFlBW/iDop/9l+IFfQMzYc6yD6krjFfd7mjx0MoNHcy+sE4KrvHOJWqqJDQ0IJ7c
         Ch2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511911; x=1757116711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euTaLWMvn+Jbnp1yX2oDNTK21ZlqMYAjAJ39ZJmlIdw=;
        b=FgkLQJGHQtWfaT172vc4sE2kJNIyv2wX2ey40gJdKMTK0+uBfldVJHgBMIGMlA9Ixn
         vxcQB4Q12JxGB4EaXRWB+OHE5lxDCG7Yy1WUxY9aDNGNNbMA9X/Vn39CMCMMsSGaR367
         8T6E1F42LwIoQ2Oaujbr/pqJW6NqfswoGgQ5ZXh6whZxVFIDFK7UgETJijxpOmW9vI4n
         4Xnah+LZ6feFeXozzP+cmct/l7DtfIB/hFX4cQxSng7MamOXJv1bvyQhYqFzYpVL6Wfu
         JTCTqWHGO54dqHSpNNz9iF4kT3bKCmsCjCsV9dFo3REU06yWEbPVNnmBBm+N9uSxhoyW
         PHpg==
X-Forwarded-Encrypted: i=1; AJvYcCU+iAM+4pk9lTsckH1Cdn+pLMjaY1VwZ5t1+tUfkGeShJ2CzP755YEKbyUfIFN888CO9TXGo3Broega@vger.kernel.org, AJvYcCUPIq8MnNxdbGID7x5pcrhzlP+EEO0RvaQ9FuXh5mxsV21Vmdf2osFxiUpp95UEMbCFk1zfwBLFHYY=@vger.kernel.org, AJvYcCVhwinEKpP1Nvbf6PyF+mLfb7Idp3/zPzHs8HyQLFoCgBuMeAuHqfwaCU0FOjJlc7kruVWhAcprzAfU7ktPFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUPGB8InnS4JlfcJoQUasymTrw+2mKiiXApPihXMiAFa5jqJ5
	rmBui7XO41llPJAWA2BHZBmL9KlFsp2TkL2cLsdJvOHiCM7jSI7Z8nqi
X-Gm-Gg: ASbGncuqNLXXBUvULa+qAzFhJrkIrFytqGu7+xd+J+69Lv17FIpHVNMyj3FKyhe67bg
	bES+U4Lxmt3tJ29dmi5EbupLB/hvhvr52erHlZe7F9lIKFIxfO7h5JuyV0kyiUsYcGi2PlTHYZl
	zKWLtG+MBWXp7AjxmQIDrCvK/JvXXoX7g5czX6aYqPwIayL7oeu0qREQ6LWE6VPvk33G3uKyjq0
	TNtooCFdyo22/MQz8WEccCBoOCbRK8k0IOlsmmoPFrwrRWkqHERt2xjT93wSv8tk0+y6XoVRm33
	/kUBsGnKucUQlzD5rR8SJelv+C8bQ0FZhpg7Cotyb4TXANin7Sz3y9cZ7J2bU2XDZlQsmPaaJYh
	jzivC6Ncss8tW9g1UNo3WHkoeORX3
X-Google-Smtp-Source: AGHT+IEIHHNg+y4Irr5o3jK2Vb+vwMhku/HrobmYUvXmZBs+n9Y17aYvTor0muerGLCWHqAcb82fUg==
X-Received: by 2002:a05:6a20:728b:b0:243:15b9:765f with SMTP id adf61e73a8af0-243d6f87742mr569043637.57.1756511910699;
        Fri, 29 Aug 2025 16:58:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e24e3sm3447174b3a.78.2025.08.29.16.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:30 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 10/16] iomap: add iomap_start_folio_read() helper
Date: Fri, 29 Aug 2025 16:56:21 -0700
Message-ID: <20250829235627.4053234-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ifs read_bytes_pending addition logic into a separate helper,
iomap_start_folio_read(), which will be needed later on by user-provided
read callbacks (not yet added) for read/readahead.This is the
counterpart to the already currently-existing iomap_finish_folio_read().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a3a9b6146c2f..6a9f9a9e591f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -324,6 +324,17 @@ struct iomap_readfolio_ctx {
 };
 
 #ifdef CONFIG_BLOCK
+static void iomap_start_folio_read(struct folio *folio, size_t len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (ifs) {
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending += len;
+		spin_unlock_irq(&ifs->state_lock);
+	}
+}
+
 static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		size_t len, int error)
 {
@@ -361,18 +372,13 @@ static void iomap_read_folio_range_async(struct iomap_iter *iter,
 {
 	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
 	struct bio *bio = iter->private;
 	sector_t sector;
 
 	ctx->folio_unlocked = true;
-	if (ifs) {
-		spin_lock_irq(&ifs->state_lock);
-		ifs->read_bytes_pending += plen;
-		spin_unlock_irq(&ifs->state_lock);
-	}
+	iomap_start_folio_read(folio, plen);
 
 	sector = iomap_sector(iomap, pos);
 	if (!bio || bio_end_sector(bio) != sector ||
-- 
2.47.3



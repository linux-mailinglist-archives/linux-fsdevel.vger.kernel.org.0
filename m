Return-Path: <linux-fsdevel+bounces-73254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDA6D13831
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79942308FEB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32822D8DD4;
	Mon, 12 Jan 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FR505Vq/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rAx8cLJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B835A1E4AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229492; cv=none; b=MfV03HJK1nVM0jFx7COcDRplv+rtOK6WDpvWM65GaFRjqP4kfWvvEp83eBNtVrvGQreMgaNyAqHwrvsay7+Q2MUSeLdUFic20NXFn+MaNaR/sDGuHvKuv0pGKNqF7OeOQu7U44158Zi1ra5j9G4NeSL80I94qfR3LB1aP9Tw7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229492; c=relaxed/simple;
	bh=G0tanH7Ti+k9Untiwo28pq9nTnDMDuydjlfNBKCMaYI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKYM9x65NWHQbCu8r3SPyZfBDvvCpAXQJnvR06vWP718pZgruAbyL+u7EKTs4vFzs0RaijlR8lGdxCHDbMqjX/38yEZAY1J0OZf7t/rYT/cRjXRMjqGXuCxQQ/QQnXdO8BoBfa4tMR0WiiwTF7NVaN8liQizL8kZvbR65waEpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FR505Vq/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rAx8cLJa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq6aVc2SBP1ULPYVZkGBkgSZtTVfOp/X5bD2Y/FWtBU=;
	b=FR505Vq/KsCV8KfOieukvqAVXU1j8WfC9NtcUgmBFc8dShrnKVht9PsiJrv53nZ8ceU1Nf
	yv1J8FL4qK7R7QLQ/ubBczdphPrFikBxra82KhQy87PEPf/joRhBh+qhXBZBYbqnCnUu0m
	EuX/OUeM4t0KVCzuqf2K2zAqQvlLumA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-VNNknuWMMnudoe6Zjm4UZA-1; Mon, 12 Jan 2026 09:51:28 -0500
X-MC-Unique: VNNknuWMMnudoe6Zjm4UZA-1
X-Mimecast-MFC-AGG-ID: VNNknuWMMnudoe6Zjm4UZA_1768229487
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64b8a632dc7so8657827a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229487; x=1768834287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dq6aVc2SBP1ULPYVZkGBkgSZtTVfOp/X5bD2Y/FWtBU=;
        b=rAx8cLJavccIY1kk9PRM9Lb6TuVaQ6b+Tgqe5vFOEO2U3jmA5WV3mSnrZFQnmudnaC
         DrLnlH7lTLVRMn797BBtcDdIcUOe7jjQmhAYKEd1sDF1Gue5rkshxAMUGacTL3Xbv7Xu
         biZUExEatzFJl4Yno+uiY6hl6OBuKOW4V/RnJkfw+NcZsFKrhNX6G0LBeZTbs3fWwSxt
         BTjf827KfkH3/Oi9JmFzLtpqEX0ovlLCDc4yD2ooHfhZkJo51g0RhMAmJERTF6ePioLc
         rJfnrTiFY6YVQ6mh1CqsOXmDYhvShAMnbZI26uvOSas6ZOrZnWa9ZL2aVGr6j3//Rj5c
         Bt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229487; x=1768834287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq6aVc2SBP1ULPYVZkGBkgSZtTVfOp/X5bD2Y/FWtBU=;
        b=AzF3s6DqTJx17SFWyLcvqQClTQHm3tQIDBkZGQORUtTSg6kbCogwD1iSfV/Dp/rhc+
         KWThdHUYqk2/gEM8+lAi7KFo6gxLTn9QeDW6+Vjpiq5R+avN0EE43OCr7Y5g6r2ZDBJi
         lIUOjW/oCxPzRpn08rVTR8f4qfCVanu6YnRTmffFkzLRbfoHx6iNmK2KVAiOKEHoXQ8J
         QNoLIotwTJECkQS4PxzSUJ/C5izlOfrIA4A8FNPJOKHr+JrynWO/17xg2gomfYkMxMCo
         NvvCHyNz0lFiSWTdZmuGrGKku8+NMyzX+vv8znR16bZ46IIKCFR1BSYc4qyyu8sCGsqb
         iTgA==
X-Forwarded-Encrypted: i=1; AJvYcCVebpX4N+eS0yrjvG7Nj6akASDpstUh0m/oP0ahRUIJoXCdytpE7+iKq8W5g9Eh5vHmFwnMX1bUdSLTqAdt@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkVKm0PzL5JlnfBpDYP8yk4EjeMrHrZRE6qb5jmsTdyS/fWFn
	hwcPHj4u8fLdG4s7CZAdvaYDYfq0cDxh82tnKAgVdaLN7BxN2MWCJbMKtQ0chxWGE44p1GQH8BT
	XJI+nFtb3w1Ss9wBzOoFkXHRniUdjIP0S8Fg+2yTuFDXyeqdkg8ClKHsMiV0PDHoWFw==
X-Gm-Gg: AY/fxX62qWjOuo/Ik8BwI3jvkc/i36tiGzRgonmXaIaQkZ4xNTQB8TlRCCu3eOcvp6O
	0He4jRxzLd3Mbeoi7VtyE936VahHY5KQ0DUXxXWBYP1YL0Lt1roKa9UpXf+nmvP9urhUTqZrhwS
	9+XRSHzaRBdD/Erts1awd7YHooZunc05r+QVC3KguWHsuJXFxonSkM+2ecsgC8I1op5nHqcGHoO
	F5uUAqXJl8sjKofGP04RdQuOL8LeFPeGgyUq4Q7ykXJgHytq3V1HhUo8fh2AmCVzUFM594rzsTv
	xb/NVT2uG2cEVTjRYqVo6VO8kK3Ojd4aOFScyPFxvd0BFBM8SnBbuo1upBWvFIj3AnXSrQB7Q4w
	=
X-Received: by 2002:a05:6402:358f:b0:651:1107:d3cb with SMTP id 4fb4d7f45d1cf-6511107d7acmr3282594a12.24.1768229487185;
        Mon, 12 Jan 2026 06:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfxvOxfxzdEBvJzPLysHOh9QzRSHooaY9jamBd0ngvYg8b3UMPNPIM3r/hBbc0eI3X4Vj7fQ==
X-Received: by 2002:a05:6402:358f:b0:651:1107:d3cb with SMTP id 4fb4d7f45d1cf-6511107d7acmr3282573a12.24.1768229486750;
        Mon, 12 Jan 2026 06:51:26 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c0asm17933810a12.9.2026.01.12.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:51:26 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:51:25 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 13/22] xfs: introduce XFS_FSVERITY_REGION_START constant
Message-ID: <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1768229271.patch-series@thinky>

This constant defines location of fsverity metadata in page cache of
an inode.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 12463ba766..b73458a7c2 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1106,4 +1106,26 @@
 #define BBTOB(bbs)	((bbs) << BBSHIFT)
 #endif
 
+/* Merkle tree location in page cache. We take memory region from the inode's
+ * address space for Merkle tree.
+ *
+ * At maximum of 8 levels with 128 hashes per block (32 bytes SHA-256) maximum
+ * tree size is ((128^8 − 1)/(128 − 1)) = 567*10^12 blocks. This should fit in 53
+ * bits address space.
+ *
+ * At this Merkle tree size we can cover 295EB large file. This is much larger
+ * than the currently supported file size.
+ *
+ * For sha512 the largest file we can cover ends at 1 << 50 offset, this is also
+ * good.
+ *
+ * The metadata is stored on disk as follows:
+ *
+ *	[merkle tree...][descriptor.............desc_size]
+ *	^ (1 << 53)     ^ (block border)                 ^ (end of the block)
+ *	                ^--------------------------------^
+ *	                Can be FS_VERITY_MAX_DESCRIPTOR_SIZE
+ */
+#define XFS_FSVERITY_REGION_START (1ULL << 53)
+
 #endif	/* __XFS_FS_H__ */

-- 
- Andrey



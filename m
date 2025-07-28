Return-Path: <linux-fsdevel+bounces-56183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C00B1433B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C5F1652BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9C2853F1;
	Mon, 28 Jul 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6pUlHPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDD27FD44
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734712; cv=none; b=uYNriQwyAk+K09Uzpi9XKRFtBlD2kRRIqAGH0TwqmFdQomK4hJI1q/t6jtyw01eLFFJKsaLu2LV2uZqAz0v7fvYBUhGEYYh7va8IUC8rVWY1U3su3zdcObW4DPG6peldZOafDm8/LspvavCJOEoCW+oP3iEimoFOfwZwzBSAprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734712; c=relaxed/simple;
	bh=Gxk0sEzaoSe6VlllYrbpg0OQx06bmUypx376lLazOAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSgkpgN0QxjvpHtIsILPMZKiCEjv1z1tk2bl5JixUtq5ztRA4cMsl4pIRv62JLbvfXdgmfuCmf7dwz9zB+8VBwhkTOVMGkmpiPl0cJW2PHjWX0g8CMdDDrBQHVvJRHY5j3JeqAxa8qQkMnbSUdGKbzAtNgTtCkHqWUld67jFR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6pUlHPK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kadtEc6XcQ4iDH67DyLSEX0+QliysQnNpS7dMO0XPTo=;
	b=F6pUlHPK80qE6gWJTbMB+eO57ccm+5Cj0zgv8yhqICTBqp7cAS9AnSeQGXKchZDf9WenUd
	vqoIIBeBOtMlj24W/SlyBwo4SGP/zVBgMATUQsjYNzCjBvtsDY1YxMOVLBmetIk4i0Ag49
	FEgYNavGm1qkxvyyl+jZ7d/gG1ZySm0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-LNv46PJFMXmadt0vn1gh8w-1; Mon, 28 Jul 2025 16:31:47 -0400
X-MC-Unique: LNv46PJFMXmadt0vn1gh8w-1
X-Mimecast-MFC-AGG-ID: LNv46PJFMXmadt0vn1gh8w_1753734706
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae9cd38721aso476422166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734706; x=1754339506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kadtEc6XcQ4iDH67DyLSEX0+QliysQnNpS7dMO0XPTo=;
        b=QdVLkKdJyvUYjoGETzeS8eLHTLyLqbFYEQCvBZXAVosuPwru+kRHHgwjzld/UegB55
         mTPEKPza8hRikuY/iAZVhwyopUZK6l/uDvHlIylPDIOsRms7NccHr/OB71Z18kc6Zj9u
         fTfujwV97AI/XkPBqU93g4PrXHFCD7oLaVpfSDuEUZw4RXxJCjq56mwTRC1IVvVIBDQn
         u0LATJ66SV7G4CrWc39VKnmCWNezqhin/XvjUrEvUDcV8doDKei/6xjV9fdY5Bqvvyx3
         hvmzzrqMRpJcL0G/rHFfheKI+svLNPzVqVYHKso0sUq6fyd24+HgEiczTKb73zMZ8SNP
         Z/5A==
X-Forwarded-Encrypted: i=1; AJvYcCXNjlOrLb5ZEJI2Jtbj8WudrWp2y4LJy1htQQmeQ3v3o0LQbTBpi/6ZZFkWAuiyI1lXXicI2DH1iEmqg8zy@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyk+kEF9jTOYzQw52wa5OWhoP34B0tOeVcvbfJcBnbo5VDGyh
	Zx9VlBTSDHMwKU4z9UN/r/8JYs9P7/ZgSWUzSYvS0K43OOlPYWfhD4J/8FtbFVQngpuK3gfVh9Z
	QXWsq+v+R6Yb870Yj7FEDVMCDqUTqzUZaGwcvgeC1x9EvPSksxOEgboghka5xlOklBw==
X-Gm-Gg: ASbGncvtpyPvB+DwCnSH5YpbUb1Dxt7RLcAREe9LoScNw8dh0gEMEJQikC7iiKVAmkn
	0g+RKbhCBbk28hIVew3kqhAr8PlEij4dVDCVdemrvf01hyYK3eeiskzOz5CuWSa9eY9Qa9xeI5x
	mAe490hrs0HmHuR4eM6VJR8POe52ZMYH0/wKdJX+cXoJ6UfRyltZAgCnAsfHHTXF8+kYTdRRo+O
	Cdaxt+nZ5jA3LsYIfxnZ3IKKbsuAuFhSnVRxEdP/Yu6ABkvlNCSAnNqIzZqEVOl0R2nHz/DeEhc
	USV5x47td5x9MsUaWrrMQHbfeb9shFs73qdaa11oEaScHw==
X-Received: by 2002:a05:6402:5192:b0:615:5353:5e2c with SMTP id 4fb4d7f45d1cf-61553535e94mr3299444a12.19.1753734705932;
        Mon, 28 Jul 2025 13:31:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3EwyequldE0yYkC1LWl4McATzdbfZq53i6FBVks/dB/ZeKteI7CUgbwJVMwJBiBKyVNXP/g==
X-Received: by 2002:a05:6402:5192:b0:615:5353:5e2c with SMTP id 4fb4d7f45d1cf-61553535e94mr3299415a12.19.1753734705480;
        Mon, 28 Jul 2025 13:31:45 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:45 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:28 +0200
Subject: [PATCH RFC 24/29] xfs: advertise fs-verity being available on
 filesystem
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-24-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=be/wykvZj9niA0ffxchNInZGSfvYSVY4KIFdLfTfwME=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSYRrfQqvnTzJc5kOT/JrS84vL0XmhAgsfH5pq
 8F5meCH/Zs7SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATGRrCiPDLTc2e0bHNdE+
 ZTv3y03+6GC6vfw5Y0DUwsuTXHYarsj5wciwmf3qDcFU7373qwYy2uUMDF1nvy9wPP6tYMf9+lU
 917awAwDOlUbj
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

Advertise that this filesystem supports fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_fs.h | 1 +
 fs/xfs/libxfs/xfs_sb.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 12463ba766da..9d07c7872e94 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -250,6 +250,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_PARENT	(1 << 25) /* linux parent pointers */
 #define XFS_FSOP_GEOM_FLAGS_METADIR	(1 << 26) /* metadata directories */
 #define XFS_FSOP_GEOM_FLAGS_ZONED	(1 << 27) /* zoned rt device */
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1 << 28) /* fs-verity */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index e32cd2874bcd..7507518a1c72 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1575,6 +1575,8 @@ xfs_fs_geometry(
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_METADIR;
 	if (xfs_has_zoned(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_ZONED;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 

-- 
2.50.0



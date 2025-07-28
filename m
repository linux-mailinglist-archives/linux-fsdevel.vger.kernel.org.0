Return-Path: <linux-fsdevel+bounces-56185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EAFB1433F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2416C2C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDD279DB0;
	Mon, 28 Jul 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSN9k4pT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC6285053
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734714; cv=none; b=b3OR1/dwjqC/WZ9wRXznGo3FTentcWIerrCtRxkYkkRcaLdW1fnakMztn9t/Nhau5QYJmYWwZxHFLUs/QYLpFZoAW9ttGAAsmLRzu8IFiCC4KUwWbjI+rSC49O66xQe4utZwSAlKy/hZ6PPCC63IxeQMoSTKfTNph2/jf+H8qOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734714; c=relaxed/simple;
	bh=ZoQQOuWpUinU7pFJdbnUgWRTEgO2Zq5/dHaw2LVYG6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnqf9HY9MJ9nCqMBcAdOmOhdTPD7iuLAJwPU/1bgCLEiem0pPnJxYAM8BKxXJPBm3V+c8Atz51FL/FVusC0l80BKIH5fIfUQFN3s7rvlwPTOPWzYbblmAa9TXkKSC3IyQkM52suyZqmjqP1MfseTbxi1n0HvvSRR16DI/PTgacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSN9k4pT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kyEV+/w4sIA+/CyhwgIY0Ty4kfdQwpDIEQVJL9PjRC4=;
	b=YSN9k4pT04YH5Civ9TcdZUqmSKb1RC6ePuq95yiso+y/MQYkwd3vU8h214+T5pkXYS3lfK
	EpZ1N9a2SP+UxYjSI7M43Ma5nGIQhzXHG5ijKOhvWWVm3GGmwiK9QFYb0weLoZ7Zfa8lrk
	5uA+iwMYQrdmgxwOujd3ET95Yf5BgVc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-EBcijdMSNXeUmcFdrm9nOg-1; Mon, 28 Jul 2025 16:31:50 -0400
X-MC-Unique: EBcijdMSNXeUmcFdrm9nOg-1
X-Mimecast-MFC-AGG-ID: EBcijdMSNXeUmcFdrm9nOg_1753734709
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-606f507ede7so6087091a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734709; x=1754339509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyEV+/w4sIA+/CyhwgIY0Ty4kfdQwpDIEQVJL9PjRC4=;
        b=nZYy79iZzeD/IyJJ0jzy2Qcf4D4TktpwOkkq1S33uLPbUM0+LNfNZ79izy7MKxsp1X
         WwmN2SWSkKwLO50wttE1IVHYBAj1z0IjzRfhJRkSGOlwGl9mWKiH/m1FtMrOrihPYYDF
         DIDuNVaWWDCFFQBxc8SYdy2MRhADEL/Nrqruc9JikAEZif8qvGQZElT93Xah/jA6vQmR
         X4yk50RRoBEpuiwwx6LoiLGCMTOvEc/r3KxDzMrqAplBau8sPvgxinuxmfoteQ8vr9qD
         Q1Afty32YUuGjzjBr+D0yQxnwwHk71RNNCSmIXxG2tlVor5UvYCB1RN4nw8y3iSeHlnf
         G0gg==
X-Forwarded-Encrypted: i=1; AJvYcCWxBUKS5zq9nQPCgupd4rAx9E0QTZdY+8SqqB2/QDHUmOOv2G19bmeqbZiyw0xJrGADnVjNoVnTpAoZv+lr@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuhw36IEWhVIrJDoBLdZI6jQSOr9FyzvzzRCafEayM8198BQy
	BGyQh7ckR5SDvfwILaMowXB9yuLs11gVFvh1Ej+S3OVIQvT/Bc4jJ/TCnFzOjam8jkLNfIF+EBR
	Qo4zX+XazgxQVdekHTCwXY1HSWvTAAa+WS2kA9xAR7ACKDOFOohEr8iOd5XvHwXBG4A==
X-Gm-Gg: ASbGncvax1lKjolzP40laMF5JzzkNI3YrkhqYQjisJ+FaIvm+1n6SOdcr8HKlDWwzv1
	kajeGgZEna+lJKn7ySQ2zTrbxaHsWVHQ8nKN2f3NQobbEqr5w9pPYHRVP6mQPj8RZ5Qkxmo/qm5
	Y7TMLFmzUR/UBE5SINB6b2hCeE25dUipon10iH2I74/f0VYm/mJur2ubxjkMCy8oQ4zA/DSCNma
	FURLDJbZtzdA4Yn3Lp2rJxwBbUP0c9p4dZan++bjscsNpMry+uh+3iLPSKqSvnBiX/1Y0krPOWk
	uMuh/gHhSOZXQXsF1MhzbKwvGFKK33JDxlzHy3k1HCBK/w==
X-Received: by 2002:a05:6402:13d0:b0:615:5bec:1df with SMTP id 4fb4d7f45d1cf-6155bec54aemr2083996a12.25.1753734709183;
        Mon, 28 Jul 2025 13:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQnyEM1jHy1RMGZTH+4WPcmPCTAED7ChgzLu1he+9bs9Yj3BpmMpGYXCZaT3RwMJUnrzSsSg==
X-Received: by 2002:a05:6402:13d0:b0:615:5bec:1df with SMTP id 4fb4d7f45d1cf-6155bec54aemr2083972a12.25.1753734708781;
        Mon, 28 Jul 2025 13:31:48 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:47 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:31 +0200
Subject: [PATCH RFC 27/29] xfs: report verity failures through the health
 system
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-27-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3309; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=cLsMIEE7baasRw1QmHFBJ/VCsW3/PqP8RkNUuoTyM3I=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSZyOYxC+ICbhsPA165GJMYzeFQ17qstnGG324
 VA56/N688uOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE9nAz8gwjelSd/f2Y4f+
 Ge9yaF8ql2v1MKPcbf87rw/MFhwGpYf+MzIcd05/duPQEVOZyK8Lbgv4vXvqzpV9/umCdYdnn+I
 TmirMDACMD0dB
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: "Darrick J. Wong" <djwong@kernel.org>

Record verity failures and report them through the health system.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/libxfs/xfs_fs.h     |  1 +
 fs/xfs/libxfs/xfs_health.h |  4 +++-
 fs/xfs/xfs_fsverity.c      | 11 +++++++++++
 fs/xfs/xfs_health.c        |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 9d07c7872e94..501e4e59c6c9 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -422,6 +422,7 @@ struct xfs_bulkstat {
 #define XFS_BS_SICK_SYMLINK	(1 << 6)  /* symbolic link remote target */
 #define XFS_BS_SICK_PARENT	(1 << 7)  /* parent pointers */
 #define XFS_BS_SICK_DIRTREE	(1 << 8)  /* directory tree structure */
+#define XFS_BS_SICK_DATA	(1 << 9)  /* file data */
 
 /*
  * Project quota id helpers (previously projid was 16bit only
diff --git a/fs/xfs/libxfs/xfs_health.h b/fs/xfs/libxfs/xfs_health.h
index b31000f7190c..fa91916ad072 100644
--- a/fs/xfs/libxfs/xfs_health.h
+++ b/fs/xfs/libxfs/xfs_health.h
@@ -104,6 +104,7 @@ struct xfs_rtgroup;
 /* Don't propagate sick status to ag health summary during inactivation */
 #define XFS_SICK_INO_FORGET	(1 << 12)
 #define XFS_SICK_INO_DIRTREE	(1 << 13)  /* directory tree structure */
+#define XFS_SICK_INO_DATA	(1 << 14)  /* file data */
 
 /* Primary evidence of health problems in a given group. */
 #define XFS_SICK_FS_PRIMARY	(XFS_SICK_FS_COUNTERS | \
@@ -140,7 +141,8 @@ struct xfs_rtgroup;
 				 XFS_SICK_INO_XATTR | \
 				 XFS_SICK_INO_SYMLINK | \
 				 XFS_SICK_INO_PARENT | \
-				 XFS_SICK_INO_DIRTREE)
+				 XFS_SICK_INO_DIRTREE | \
+				 XFS_SICK_INO_DATA)
 
 #define XFS_SICK_INO_ZAPPED	(XFS_SICK_INO_BMBTD_ZAPPED | \
 				 XFS_SICK_INO_BMBTA_ZAPPED | \
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index ec7dea4289d5..dfe7b0bcd97e 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -21,6 +21,7 @@
 #include "xfs_ag.h"
 #include "xfs_fsverity.h"
 #include "xfs_iomap.h"
+#include "xfs_health.h"
 #include <linux/fsverity.h>
 #include <linux/pagemap.h>
 
@@ -302,10 +303,20 @@ xfs_fsverity_write_merkle(
 	return iomap_write_region(&region);
 }
 
+static void
+xfs_fsverity_file_corrupt(
+	struct inode		*inode,
+	loff_t			pos,
+	size_t			len)
+{
+	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
+}
+
 const struct fsverity_operations xfs_fsverity_ops = {
 	.begin_enable_verity		= xfs_fsverity_begin_enable,
 	.end_enable_verity		= xfs_fsverity_end_enable,
 	.get_verity_descriptor		= xfs_fsverity_get_descriptor,
 	.read_merkle_tree_page		= xfs_fsverity_read_merkle,
 	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
+	.file_corrupt			= xfs_fsverity_file_corrupt,
 };
diff --git a/fs/xfs/xfs_health.c b/fs/xfs/xfs_health.c
index 7c541fb373d5..4202b8441735 100644
--- a/fs/xfs/xfs_health.c
+++ b/fs/xfs/xfs_health.c
@@ -487,6 +487,7 @@ static const struct ioctl_sick_map ino_map[] = {
 	{ XFS_SICK_INO_DIR_ZAPPED,	XFS_BS_SICK_DIR },
 	{ XFS_SICK_INO_SYMLINK_ZAPPED,	XFS_BS_SICK_SYMLINK },
 	{ XFS_SICK_INO_DIRTREE,	XFS_BS_SICK_DIRTREE },
+	{ XFS_SICK_INO_DATA,	XFS_BS_SICK_DATA },
 };
 
 /* Fill out bulkstat health info. */

-- 
2.50.0



Return-Path: <linux-fsdevel+bounces-46312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0004A86AF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 06:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD7217990B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 04:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103518A6A6;
	Sat, 12 Apr 2025 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTOJgBIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E91891A9;
	Sat, 12 Apr 2025 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744432611; cv=none; b=m1t70T3wc3aVkkefAxZYlzHLFvYJacu9JKuKtODAnpVtiDukT752jzIwy8zSHvweKW9LbRpvWXRI1zexoo06BQWbxICvs5cs+csM8dchcFMIrrt7KNdn5tHwE2f8plp+1ZpeTUTpUhBqzR0D2frLvg9kdSSTbcgJZ7f8JdJ4pBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744432611; c=relaxed/simple;
	bh=QY1wKDOkQEl1CFDWXIAC6g+nrvMtAmRCujAFfyijgoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Yv0Ou6qJOpCe94FqvnnM7qEEmVb1PMFp3N+1AsWaESQrNrYV43xO8ryLQ5e8oU4Vk2Sb4pYVt284saEZ9VXlhrjRa1Y0/JenH4rmhePuaAyQ/i2KMkOz+6G6S166uJOxCf0Pk+ggVqimQTkEkNNdQDEj59eACTckfWIwTRo2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTOJgBIK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so3272786b3a.0;
        Fri, 11 Apr 2025 21:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744432608; x=1745037408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kMrbL7tcvDz5lUAbPFrHkOsQ+u9gKHcRszVAuDybPY=;
        b=bTOJgBIKfAVRj2bfOBGnn9M/x0Q4aG1Vm/+7NtR4e1TyfdUalgV92wa/YBBeZ47yNR
         lf1VSyLbaeUWayRNz/dPW3Qn8fJl9wdc4n3eTNPtXBeByOtaZzqAb29fD/e1f0cU6hX7
         S/iB5xHMsaDml6BslrzO39qSOtz5XpbhBIAuDudDfYkR61dr05/GoutYkANobQmh/44H
         wDK9hzfGFSlD5NaQ00YKkvmv21gsqydmm4XJsjv/G5hrntg1SBnsAjIFLfmw2ZrS2FVa
         ebka/lBc3gYldqWkYL4LBCWrnN3FEN520JJKNw/6CME1xgz1oyPaX86A5cI4SsIpJzCU
         7GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744432608; x=1745037408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kMrbL7tcvDz5lUAbPFrHkOsQ+u9gKHcRszVAuDybPY=;
        b=Tx0oulUP3ERHW/niOriwj4J7qdfmYVDZhI0SR+JFhuWO14OQ/TlXYtNc9Jeh0aHSxW
         aIyAAgHOHXN8Sdv7tLXr9iRO3kIKFrptcX/gPRkByIiT8TyckZti+ENnc9/6LgCaBzs2
         irshGk/Mtiz1n/fzcxnW9f2DX+qkimMzxLiLXnxftLkd5NFhDaX8TPriY4f2jvCY2Tvu
         gdABAZyTg/iQLGo6/jQM4jFaKEfa9MYHW3+n/CrnvEclryiVqpkPrFoethph00g2yUWX
         snxNfAL/ECrQ92E7SEOgY2zBbuRC5PhhSAiT+b1NUa4gi1sc4Y4yK/2EnUaWpoRUTSdO
         /r+w==
X-Forwarded-Encrypted: i=1; AJvYcCXjBfiCHFX/tqF8bmfIlEmOYHEGGybtyBEXmZsezSWn+mtPDga8TzttAUkpwC+1q7zEdmK5Fx9BDlpFo6Rn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4HaLjLySQfnASDT4BTHMyx3VNTPoByc86sUOwIvVmqcd1boHX
	ODT8R6Iwv2FfF/mqjO0H5m1pjc1x42jpo5vO315O9VWkFSoHNNmZGkDCBQ==
X-Gm-Gg: ASbGncsBqppo2iUeaAuDrplxmV6QtlfQvbfrGkbwrDvpqDhnEahoX72TaH9HTtOymm3
	mwWGkkmapG6M21LGWqII+3OnkJz+mP01Y+ErvOio9MDgYBtGpW0NV2Pux2Niapuecu/S/Sv2V73
	8KFj12wqis1Vth0xId5Sbny4uKP5pllvu3/L8FPeUS9W6OZ7YezjPN7Or9Z+ngk1apeIda0zJ57
	R409Nw5feILG8cHhHdzi50v6wjoU9GD7tiUiUzKYcEUUSNnYd6OdS7jhVuils4DQu5su8Hl+s5I
	fGfiSNplziRWycidJSsaaD5WnXeAMFX9Awq+Zh6oXC0tQJDZOXntWG2RCw==
X-Google-Smtp-Source: AGHT+IEirL+fbFsivnxUVPQjJ/lWWd7BF9FTt+vFvXtvuJ6WLMEj7i9MdTqBq9lXrro98T6722jtFQ==
X-Received: by 2002:a05:6a21:1507:b0:1f3:34a4:bf01 with SMTP id adf61e73a8af0-2016a283f28mr13103993637.17.1744432607571;
        Fri, 11 Apr 2025 21:36:47 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0de8926sm4827993a12.30.2025.04.11.21.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 21:36:47 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 2/2] iomap: trace: Add missing flags to [IOMAP_|IOMAP_F_]FLAGS_STRINGS
Date: Sat, 12 Apr 2025 10:06:35 +0530
Message-ID: <dcaff476004805544b6ad6d54d0c4adee1f7184f.1744432270.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>
References: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds missing iomap flags to IOMAP_FLAGS_STRINGS &
IOMAP_F_FLAGS_STRINGS for tracing. While we are at it, let's also print
values of iomap->type & iomap->flags.

e.g. trace for ATOMIC_BIO flag set
xfs_io-1203    [000] .....   183.001559: iomap_iter_dstmap: dev 8:32 ino 0xc bdev 8:32 addr 0x84200000 offset 0x0 length 0x10000 type MAPPED (0x2) flags DIRTY|ATOMIC_BIO (0x102)

e.g. trace with DONTCACHE flag set
xfs_io-1110    [007] .....   238.780532: iomap_iter: dev 8:16 ino 0x83 pos 0x1000 length 0x1000 status 0 flags WRITE|DONTCACHE (0x401) ops xfs_buffered_write_iomap_ops caller iomap_file_buffered_write+0xab/0x0

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/trace.h | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 9eab2c8ac3c5..455cc6f90be0 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -99,7 +99,11 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
 	{ IOMAP_NOWAIT,		"NOWAIT" }, \
-	{ IOMAP_ATOMIC,		"ATOMIC" }
+	{ IOMAP_OVERWRITE_ONLY,	"OVERWRITE_ONLY" }, \
+	{ IOMAP_UNSHARE,	"UNSHARE" }, \
+	{ IOMAP_DAX,		"DAX" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }, \
+	{ IOMAP_DONTCACHE,	"DONTCACHE" }

 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
@@ -107,7 +111,14 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_F_SHARED,	"SHARED" }, \
 	{ IOMAP_F_MERGED,	"MERGED" }, \
 	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
-	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
+	{ IOMAP_F_XATTR,	"XATTR" }, \
+	{ IOMAP_F_BOUNDARY,	"BOUNDARY" }, \
+	{ IOMAP_F_ANON_WRITE,	"ANON_WRITE" }, \
+	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
+	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
+	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
+	{ IOMAP_F_STALE,	"STALE" }
+

 #define IOMAP_DIO_STRINGS \
 	{IOMAP_DIO_FORCE_WAIT,	"DIO_FORCE_WAIT" }, \
@@ -138,7 +149,7 @@ DECLARE_EVENT_CLASS(iomap_class,
 		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
 	),
 	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr 0x%llx offset 0x%llx "
-		  "length 0x%llx type %s flags %s",
+		  "length 0x%llx type %s (0x%x) flags %s (0x%x)",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
@@ -146,7 +157,9 @@ DECLARE_EVENT_CLASS(iomap_class,
 		  __entry->offset,
 		  __entry->length,
 		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
-		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
+		  __entry->type,
+		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS),
+		  __entry->flags)
 )

 #define DEFINE_IOMAP_EVENT(name)		\
@@ -185,7 +198,7 @@ TRACE_EVENT(iomap_writepage_map,
 		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
 	),
 	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d pos 0x%llx dirty len 0x%llx "
-		  "addr 0x%llx offset 0x%llx length 0x%llx type %s flags %s",
+		  "addr 0x%llx offset 0x%llx length 0x%llx type %s (0x%x) flags %s (0x%x)",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
@@ -195,7 +208,9 @@ TRACE_EVENT(iomap_writepage_map,
 		  __entry->offset,
 		  __entry->length,
 		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
-		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
+		  __entry->type,
+		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS),
+		  __entry->flags)
 );

 TRACE_EVENT(iomap_iter,
--
2.48.1



Return-Path: <linux-fsdevel+bounces-45674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A75A7A944
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1634D3A714A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F8253321;
	Thu,  3 Apr 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcA1QyxJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8F2505B4;
	Thu,  3 Apr 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704571; cv=none; b=rOOa/K0jqqLVIkCwsm99use4SIM3vs69ONtUf67SVM6NMT6u2Ny1G/1FlgP45Rb3BAdwshGzQowIEHs5hgLFySu8kcdqGkzIrjIsU+tgPTj2+C5fMLc94aoQJTmXh2fpWRKPjALkhi65D9ZGLUBN2IswNivhezEdUPX4CZkHfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704571; c=relaxed/simple;
	bh=I+qlaTkXhUlE4q9qdEv6vUSsTsZJ11SRFo6Y4qVOpWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIljmU/rMJ3XnXL6Ttq+KOyhBvQHhynq1G+sdsB9FL7Q7CWz/RtY47pTwSZcJAMYDguSw+YwhZPltb+7rKZdfS+zcEioPpQD1ImVr9ZL9rEHULmUPmkL8llmAC/GHaT9FBhQurL4L181FB8yTLFIPP35PK8xJowCsyJUruaffyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcA1QyxJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso1183408a91.3;
        Thu, 03 Apr 2025 11:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743704568; x=1744309368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMY2JO69QVx2Wu0X2qKl4ytMfG7YtUpaV5pegBwQdA4=;
        b=jcA1QyxJCJew8oZvsGNK7N2R/tJialLSnjY5mrXb+MZPv6f06au/5hfhAakJNVHsuO
         hMSoGCHxfkgNXB8w0qEJY6/wFz2F5wzvNvEmH4FDF3r+glC/0rgBnESW6stRQCmh6/WZ
         /wlKzR1YJkjudfHMgtiUX8jHZmHjZyv1+YvPtiTbCKVwev1frHnuVwUR9S73MrfRDh4K
         pckb0g49w1n0s7OKHtU1PVin/s0nCzxdkVhnMNSGWGESfH00bsWULY/uW2wtf5RNrO4u
         FEipMjH6h4Nm0ouLL1Zew4lo2X6pbFL6UNntAWz1zYEL7YpF0FetchKNpvCM6121Flah
         cfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704568; x=1744309368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMY2JO69QVx2Wu0X2qKl4ytMfG7YtUpaV5pegBwQdA4=;
        b=NVh+m9hPYC8xz1jzaadY1a9edvl0YAXlBSG3KbuLEUCwYaMhuUq6GG2x37AVTdbzby
         TcwjKM26ztz5pbImk6azjaIDN0ETnwmPmRuXe9G8vfWCaBdcEVFDVym/X2HF/cU5OM24
         O+aw+uRw90CHUUAvHE15w3EUGQEsDEyJB/j8lanSIFw/JFN+pDbRZA95uOC1gfsd2pUU
         wQKAwF8e1zDwAhpXfLuGDU1PzwUSzlFmYXYS/Y7pGnrTERtInBRyuhguFYvkf59eCcqZ
         yxP3UH9VwDK5N7u9zIpFttWnO0dSQ/8oe2fPYQpKm4/vwccz/U3K8TY2vQZhmG/rCl95
         ZjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQlEH6WPYZX69Tsn3PyEg027SSZBqGNBGTV+1Wp84PNfeUVoTtg/Ot4FVY3/FzdLmpT+G/8VWwoiantekQ@vger.kernel.org
X-Gm-Message-State: AOJu0YykMFfanUlY4CdwgxLfxZYnoMaA8ZLc9UYDcRnknYKQXaxpyhU4
	P3sB154ENajYUYKnjdiV4QoZs+Ny3RHNA6K5Vh0jJud0gOrodHIWXQPpXlUG
X-Gm-Gg: ASbGncvNl1FcoVV6rXP3EGH6csP6Sj0/Ou6bB8iJheEgjbrgSSCiFSLljlNWLn9nJ1R
	80EFA16lRVuvsBQmwAhOZSiv5KtJkfEtwwOKKnwojcf5ehnmBwIc0I9BFA0Gxi1rSnDmKiTpqFs
	cw4viJCH/rhakrG+AKclhs/gyGP+M42YtHpwNAqKZ2VOcqgjrbdt2UPW6eXsnQL80CATtc44wsO
	wrrslNlKE7X0yAdhXu/q9TL0Tx83LVMP8pEu6zlq/zBDXWibuvecguUWaX2yxyakNV8Sotu/Qzh
	dV4f873/gNXjyafOS7wcaF2NaqOYtpc6RIoaJC9SvDYOV7Jpsg==
X-Google-Smtp-Source: AGHT+IEefrjyj11kimR4NhNpwR5DlQi7GDYEqOaX306yLeq+7dHdfyJDADPT9LIlVwKE+YvrKPZW1A==
X-Received: by 2002:a17:90b:224d:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-306a48b308cmr566823a91.34.1743704567892;
        Thu, 03 Apr 2025 11:22:47 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30561cac698sm3944261a91.0.2025.04.03.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:22:47 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 2/2] iomap: trace: Add missing flags to [IOMAP_|IOMAP_F_]FLAGS_STRINGS
Date: Thu,  3 Apr 2025 23:52:28 +0530
Message-ID: <bf67e3e6af1cdc3c6cba83e204f440db1cbfda24.1743691371.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
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



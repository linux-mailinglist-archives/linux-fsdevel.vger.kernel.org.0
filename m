Return-Path: <linux-fsdevel+bounces-56188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC89B14341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB7C17BFED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB25285C86;
	Mon, 28 Jul 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8ctw6G6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B72857E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734717; cv=none; b=O28l8hIgR+z5d+/fxuzn/FG5jIOzMgtb3kmXHqXxnWYDTQJ9eOtIJTp0mDpUhZPxUaMuinqeXWvxvlZSFUWnC3os8Lx697xn/G74O5PUzmdjgnGEpGSXi4XIy59DWiF2ror0xxht2uCBHiuaaPGau34t22GdsNHQkDYLrAw+ShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734717; c=relaxed/simple;
	bh=zC5E6t95NKV87LeykIKXUMiD57k/Zr4doqPRYj1WOUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qshCfnTCTbmv5L72eNbiBTNiG+T6PIcXjCwX9CInCoGVQtY6rxuThXbnZoQPysTEUp5uNkU8zIHBQBbolYk3QioaqA+Fp1RdbaZ+ZLP3Tmq23zb7dAOwSwi73zTB/pLlJoe0vynvkwujvX0T69zNOrxONh6RNeMrTZYN7i/pjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8ctw6G6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ay9CP0eRiEH4X8+UtxY4a/Tvb9542kVaQrAsuecmxfU=;
	b=S8ctw6G6OLepsIg/XvuawxCbFWA+/DD5gnCxpI9XapmFkt0iOuRR3SULW5waRT9UHMNdb/
	FOqZ81xqJBFTCMctlIRc46s0vMFh5rpXRtfg1SSRX6wQp2apJwVyu+YkSyinODKZSGOIdN
	pkiDl1J/Tj7gsTxXxydw/9VDyN1E1Rk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-RViAcu5pOdus89RC5yXDbQ-1; Mon, 28 Jul 2025 16:31:51 -0400
X-MC-Unique: RViAcu5pOdus89RC5yXDbQ-1
X-Mimecast-MFC-AGG-ID: RViAcu5pOdus89RC5yXDbQ_1753734710
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-613559d197dso4142924a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734710; x=1754339510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay9CP0eRiEH4X8+UtxY4a/Tvb9542kVaQrAsuecmxfU=;
        b=b12Ye8H+ruvmvkdQ2AvBLSl3X0yFcjIOH0SQT7I2EIvB+g9/xLI0SNWUbkm+6XCJyA
         u6QeQuItwBxpPdNvrDf+HntweVp7jfiNqWRUJlyWcNLFsYWCVih6qmBgjY6COwhF8umx
         /2tcJ1I5r3PYIbekaR2fIcPpNop02Y/oWX9i2VOmDOmnX3KzEYOk+u7+kniQA5FeGK+G
         3RpgUwIxq1a+cqaHlbGPg4zegkrCqfR6IT/oTAMqMYS+fBlGMMwywk4RrmxwuSW4HBzE
         0foWajbSUVCx2mydW5ZZ+SC9kadrbW23dcAwDkpS1lPOVNHJ1OX+zMwA74zoYQnoO+T4
         0OHA==
X-Forwarded-Encrypted: i=1; AJvYcCUQsP3JD1MLhd5sEoRRUcUc4/KD2eiRBGWFNsHFbf3xUInqd18tytvMoDIwhx1/vCRg+T5Sq7fxmijtVF9L@vger.kernel.org
X-Gm-Message-State: AOJu0YwnaW/TSj0q+d8/AxOmfjgnEol9zJsKBokQJ3+6R/icTJsMgH0+
	Cb/RDFcql50NDGDUwBy/bBlU2gG6leY09m93K5hQF4FvQx+B4/vj6YoIFShUpJf9bbZhbFeqR+n
	Kmjjx4Wo41tM0Z8ajw6Bfl6aW8ClSRgIou40mZo+QrC1DXD37KErcpYG7T1K+6766/A==
X-Gm-Gg: ASbGncslE+wcJA2NycqZ+BiSLqLDY/pFgdIB/DXiH0uRCGWwyqG0l3BnUu7DFDYEz57
	Tfxsoz3olb32JYadMecuqAO914e1/+/R2d5dbzIfsbupcs11ykd33PdfwcZzFYFI0HSqpqGJsXr
	N5CPUSya0HGf9e0Iz2ColuIMnMMa7dX3yTX8plcYlYggWlPF866+UMy0tzRN7K7IcmAC0I02sHI
	DdE4xCDwSxosseIFCjWy8k/GcT4btDQWilO5TmZGZjkCGoCMJ6KnmFav+5cp8+op4SKzKTck3Ni
	3nqpmrRBc2+QbiLZDVwfNVsyrpyslUFY32Tfu/eFC5h+wg==
X-Received: by 2002:a05:6402:42cf:b0:612:cdb2:d4d7 with SMTP id 4fb4d7f45d1cf-614f1d3568emr11519134a12.15.1753734709848;
        Mon, 28 Jul 2025 13:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWVuXfhSdv4DcTIieq2CDA0gSu5AdlwV/ayJ9zVp7zCRLwOwcFOnGZNpS+aNUh2oAGLJrmSg==
X-Received: by 2002:a05:6402:42cf:b0:612:cdb2:d4d7 with SMTP id 4fb4d7f45d1cf-614f1d3568emr11519113a12.15.1753734709413;
        Mon, 28 Jul 2025 13:31:49 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:49 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:32 +0200
Subject: [PATCH RFC 28/29] xfs: add fsverity traces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-28-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=zC5E6t95NKV87LeykIKXUMiD57k/Zr4doqPRYj1WOUY=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSX7Ttr43pVubVcn7UNkRz++GEfckXyldvqHz4
 YPm+4ZPmlkdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJtI1m5FhrWemVnxkIl+R
 eH5Ru7LXMqFfa/8t0bz/kHXefiX2jTuLGBn6NLbW8a7m5rHnEs+708a5aUXPJx7+R0bNi61f9fx
 hb+cCAAbtRJg=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Even though fsverity has traces, debugging issues with varying block
sizes could a bit less transparent without read/write traces.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c |  8 ++++++++
 fs/xfs/xfs_trace.h    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index dfe7b0bcd97e..4d3fd00237b1 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -70,6 +70,8 @@ xfs_fsverity_get_descriptor(
 	};
 	int			error = 0;
 
+	trace_xfs_fsverity_get_descriptor(ip);
+
 	/*
 	 * The fact that (returned attribute size) == (provided buf_size) is
 	 * checked by xfs_attr_copy_value() (returns -ERANGE).  No descriptor
@@ -267,6 +269,8 @@ xfs_fsverity_read_merkle(
 	 */
 	xfs_fsverity_adjust_read(&region);
 
+	trace_xfs_fsverity_read_merkle(XFS_I(inode), region.pos, region.length);
+
 	folio = iomap_read_region(&region);
 	if (IS_ERR(folio))
 		return ERR_PTR(-EIO);
@@ -297,6 +301,8 @@ xfs_fsverity_write_merkle(
 		.ops				= &xfs_buffered_write_iomap_ops,
 	};
 
+	trace_xfs_fsverity_write_merkle(XFS_I(inode), region.pos, region.length);
+
 	if (region.pos + region.length > inode->i_sb->s_maxbytes)
 		return -EFBIG;
 
@@ -309,6 +315,8 @@ xfs_fsverity_file_corrupt(
 	loff_t			pos,
 	size_t			len)
 {
+	trace_xfs_fsverity_file_corrupt(XFS_I(inode), pos, len);
+
 	xfs_inode_mark_sick(XFS_I(inode), XFS_SICK_INO_DATA);
 }
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 50034c059e8c..4477d5412e53 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -5979,6 +5979,52 @@ DEFINE_EVENT(xfs_freeblocks_resv_class, name, \
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_reserved);
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_enospc);
 
+TRACE_EVENT(xfs_fsverity_get_descriptor,
+	TP_PROTO(struct xfs_inode *ip),
+	TP_ARGS(ip),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+	),
+	TP_printk("dev %d:%d ino 0x%llx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino)
+);
+
+DECLARE_EVENT_CLASS(xfs_fsverity_class,
+	TP_PROTO(struct xfs_inode *ip, u64 pos, unsigned int length),
+	TP_ARGS(ip, pos, length),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(u64, pos)
+		__field(unsigned int, length)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->pos = pos;
+		__entry->length = length;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos %llx length %x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->length)
+)
+
+#define DEFINE_FSVERITY_EVENT(name) \
+DEFINE_EVENT(xfs_fsverity_class, name, \
+	TP_PROTO(struct xfs_inode *ip, u64 pos, unsigned int length), \
+	TP_ARGS(ip, pos, length))
+DEFINE_FSVERITY_EVENT(xfs_fsverity_read_merkle);
+DEFINE_FSVERITY_EVENT(xfs_fsverity_write_merkle);
+DEFINE_FSVERITY_EVENT(xfs_fsverity_file_corrupt);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.50.0



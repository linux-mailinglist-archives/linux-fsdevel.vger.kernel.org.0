Return-Path: <linux-fsdevel+bounces-38644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FEA05601
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CD1637E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26501EF0A5;
	Wed,  8 Jan 2025 08:59:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AAB1A0BDB;
	Wed,  8 Jan 2025 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326753; cv=none; b=WW2pk35DL9g1O3P+NoxlsyJ+P7bytMeKAUPxiNzPZFLj+y+yn80jJ+rcJTfWmwK/3W1fgS5fhHAHYy4iBQURrCuNFUbBZtM9+86+sABHkO7u5xMpniOJO2CdjZCtW91So7tUs4Xbvonv9TRu3R35BbrXpX91i+QFa2nafcV9alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326753; c=relaxed/simple;
	bh=tqCZjNp1M3ncCyp9HLwH0Yh6Y5LbiRXqgbhj71syNlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDmnXHabNBF6qSk7sPk+ZBN/PL4o0g1oPyMEtXPWHyDZTUVITl4Ix8aoDJwPqN8tPlDF0GtIVQwVyZ44Ug2H+OFiwcMxzghotU6ZFrjANK6KT7dN7taxv5ky+n/ziYkeK6hFpk/mCnAO+YG5hKJbZd0WhU1QBZE9PrVJdcaVVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B43C68BEB; Wed,  8 Jan 2025 09:59:01 +0100 (CET)
Date: Wed, 8 Jan 2025 09:59:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-man@vger.kernel.org
Subject: [PATCH] statx.2: document STATX_DIO_READ_ALIGN
Message-ID: <20250108085900.GA27227@lst.de>
References: <20250108085549.1296733-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108085549.1296733-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Document the new STATX_DIO_READ_ALIGN flag and the new
stx_dio_read_offset_align field guarded by it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 man/man2/statx.2 | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index c5b5a28ec2f1..8ef6a1cfb1c0 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -76,6 +76,9 @@ struct statx {
     __u32 stx_atomic_write_unit_min;
     __u32 stx_atomic_write_unit_max;
     __u32 stx_atomic_write_segments_max;
+
+    /* File offset alignment for direct I/O reads */
+    __u32   stx_dio_read_offset_align;
 };
 .EE
 .in
@@ -261,7 +264,7 @@ STATX_BTIME	Want stx_btime
 STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
 	It is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
-STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
+STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align.
 	(since Linux 6.1; support varies by filesystem)
 STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
 STATX_SUBVOL	Want stx_subvol
@@ -270,6 +273,8 @@ STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
 	stx_atomic_write_unit_max,
 	and stx_atomic_write_segments_max.
 	(since Linux 6.11; support varies by filesystem)
+STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
+	(since Linux 6.14; support varies by filesystem)
 .TE
 .in
 .P
@@ -467,6 +472,25 @@ This will only be nonzero if
 .I stx_dio_mem_align
 is nonzero, and vice versa.
 .TP
+.I stx_dio_read_offset_align
+The alignment (in bytes) required for file offsets and I/O segment lengths for
+direct I/O reads
+.RB ( O_DIRECT )
+on this file.
+If zero the limit in
+.I stx_dio_offset_align
+applies for reads as well.
+If non-zero this value must be smaller than
+.I stx_dio_offset_align
+which must be provided by the file system.
+The memory alignment in
+.I stx_dio_mem_align
+is not affected by this value.
+.IP
+.B STATX_DIO_READ_ALIGN
+.RI ( stx_dio_offset_align )
+is supported by xfs on regular files since Linux 6.14.
+.TP
 .I stx_subvol
 Subvolume number of the current file.
 .IP
-- 
2.45.2



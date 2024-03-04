Return-Path: <linux-fsdevel+bounces-13530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE480870A4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53EC280EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB57B3E3;
	Mon,  4 Mar 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apXf7aSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845D7AE6E
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579547; cv=none; b=WmE3on9rK6+ewMKmuEvAd2HPsmmnzGfWEyiL8FqKsvflg5vemBzSxYk3IjYsYXg2laNYDme2xqhV9ve0SxVmfp1qDknPAXskiyaTX9s7LaMP/M/vbbCTAwMeMoEsnVQP2/Ra+j6k/99QJJREpeUYacaao6rXTTN7BIGfLngYizg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579547; c=relaxed/simple;
	bh=HHQ81S2hPxColFzvYzIn9dIw5ty7YjE1Xuf7rj1qYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+3AHcWP6nJmhF8TihTkUszB0xLvxnSz0Pzp9FtBGBjeH7rSiAlQ9b5CDvfr3vy7pajr0M9xUxOjlEZby1CDZOEy+bDixgxEvrUwwd/jDLrY5nbaWt1qi5q7soR5+uejMHXI0JjWVmzyE0Mx6i+FVx4E1hBUiF/tI3DQ962buLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apXf7aSF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=far6zlrIyHC61tMfvysiCXbI0A2uQYiTQAm6dVAsqUo=;
	b=apXf7aSFxUbjvNQ2yUFxs9aVuyZ7VB9lKC5LsMQx38r8XOD1JHaWj0b+h5F+i9Eh5ntWVh
	QhInVC6Ef5UFAztlS0fivJnRb68HPH/8LsaytAP51BE9LirquR+/mwf8Pf2KgHTz7WmEbL
	9KSfvTEchNDTVOsmXfDTchIYuKlFwrI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-rHUpvzDpPX69_IewmbGClQ-1; Mon, 04 Mar 2024 14:12:22 -0500
X-MC-Unique: rHUpvzDpPX69_IewmbGClQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a444b9dd222so301739966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579541; x=1710184341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=far6zlrIyHC61tMfvysiCXbI0A2uQYiTQAm6dVAsqUo=;
        b=lWCcMhzId7LjyWWrHQ4vytEFr+dKTMzTg639YbCurqKeGWs6mWQc+OCuFI6VSSJkIi
         OO1Qz8M5qz8xlyZf1NmOO7FjhUsxRlLdcfCxcL7wyecnAyCM2tTf76GQWNuvTLpoJezU
         A5KtcpIJh14Dc1oU431gvozz5WGjsZuGbO7fNo4jqCLNn+7s0ekxHzJNztVLiJmbUBc0
         uB37BX+v/R84DfZOBk8xWYDT0pt1y2yH1heWb8cWua1siq/lr07iaKSMwqaFI/spXAG4
         jICu5ZE8N8n98wS7ZOh1w6U0lGCi4GFWmVs6jVdCEUa+B6xKwH0qtPA9gcMSRNgoy2zH
         luFw==
X-Forwarded-Encrypted: i=1; AJvYcCVfyVhCoeyMKRYaD5HBWY2m3KGZKUVDxtOB9ez+qUFnlYx5GSTkHIZ5ojvmocEIIWqnhbFHe5DxEW/BpoldeoRruWRdaeN34IZGkFm11g==
X-Gm-Message-State: AOJu0YyHwZLqAEE1HJvVDKOp2Ccg7FvF+AzsYYCbz7JasPnbLACwFhl1
	yPPrNkT2QUM5xyZdyjDDd59gKCrwye25Xu+X9Bj28avas5MFcwp+s7B8YgU6Wx8cocAJTGbjbzI
	qNVbBDwf0rW2i4SmH96E9pOqNLZBt4Q5D58+AjuDvfYbMpIqmmoRoV8vnbJTKeg==
X-Received: by 2002:a17:906:3508:b0:a44:d042:887b with SMTP id r8-20020a170906350800b00a44d042887bmr4066256eja.8.1709579541047;
        Mon, 04 Mar 2024 11:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk7B3tup0Er2HlIPaQGDDhxylodjsavVO98JJAa6+X9m5TWmampICNTZgEFh4QY5BNyEOlZw==
X-Received: by 2002:a17:906:3508:b0:a44:d042:887b with SMTP id r8-20020a170906350800b00a44d042887bmr4066253eja.8.1709579540844;
        Mon, 04 Mar 2024 11:12:20 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:20 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Date: Mon,  4 Mar 2024 20:10:34 +0100
Message-ID: <20240304191046.157464-13-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of essential ideas of fs-verity is that pages which are already
verified won't need to be re-verified if they still in page cache.

XFS will store Merkle tree blocks in extended file attributes. When
read extended attribute data is put into xfs_buf.

fs-verity uses PG_checked flag to track status of the blocks in the
page. This flag can has two meanings - page was re-instantiated and
the only block in the page is verified.

However, in XFS, the data in the buffer is not aligned with xfs_buf
pages and we don't have a reference to these pages. Moreover, these
pages are released when value is copied out in xfs_attr code. In
other words, we can not directly mark underlying xfs_buf's pages as
verified as it's done by fs-verity for other filesystems.

One way to track that these pages were processed by fs-verity is to
mark buffer as verified instead. If buffer is evicted the incore
XBF_VERITY_SEEN flag is lost. When the xattr is read again
xfs_attr_get() returns new buffer without the flag. The xfs_buf's
flag is then used to tell fs-verity this buffer was cached or not.

The second state indicated by PG_checked is if the only block in the
PAGE is verified. This is not the case for XFS as there could be
multiple blocks in single buffer (page size 64k block size 4k). This
is handled by fs-verity bitmap. fs-verity is always uses bitmap for
XFS despite of Merkle tree block size.

The meaning of the flag is that value of the extended attribute in
the buffer is processed by fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_buf.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 73249abca968..2a73918193ba 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -24,14 +24,15 @@ struct xfs_buf;
 
 #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
 
-#define XBF_READ	 (1u << 0) /* buffer intended for reading from device */
-#define XBF_WRITE	 (1u << 1) /* buffer intended for writing to device */
-#define XBF_READ_AHEAD	 (1u << 2) /* asynchronous read-ahead */
-#define XBF_NO_IOACCT	 (1u << 3) /* bypass I/O accounting (non-LRU bufs) */
-#define XBF_ASYNC	 (1u << 4) /* initiator will not wait for completion */
-#define XBF_DONE	 (1u << 5) /* all pages in the buffer uptodate */
-#define XBF_STALE	 (1u << 6) /* buffer has been staled, do not find it */
-#define XBF_WRITE_FAIL	 (1u << 7) /* async writes have failed on this buffer */
+#define XBF_READ		(1u << 0) /* buffer intended for reading from device */
+#define XBF_WRITE		(1u << 1) /* buffer intended for writing to device */
+#define XBF_READ_AHEAD		(1u << 2) /* asynchronous read-ahead */
+#define XBF_NO_IOACCT		(1u << 3) /* bypass I/O accounting (non-LRU bufs) */
+#define XBF_ASYNC		(1u << 4) /* initiator will not wait for completion */
+#define XBF_DONE		(1u << 5) /* all pages in the buffer uptodate */
+#define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
+#define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
+#define XBF_VERITY_SEEN		(1u << 8) /* buffer was processed by fs-verity */
 
 /* buffer type flags for write callbacks */
 #define _XBF_INODES	 (1u << 16)/* inode buffer */
@@ -65,6 +66,7 @@ typedef unsigned int xfs_buf_flags_t;
 	{ XBF_DONE,		"DONE" }, \
 	{ XBF_STALE,		"STALE" }, \
 	{ XBF_WRITE_FAIL,	"WRITE_FAIL" }, \
+	{ XBF_VERITY_SEEN,	"VERITY_SEEN" }, \
 	{ _XBF_INODES,		"INODES" }, \
 	{ _XBF_DQUOTS,		"DQUOTS" }, \
 	{ _XBF_LOGRECOVERY,	"LOG_RECOVERY" }, \
-- 
2.42.0



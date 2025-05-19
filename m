Return-Path: <linux-fsdevel+bounces-49416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F49ABBFD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DBE1620DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E801D28468B;
	Mon, 19 May 2025 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYeSu+I+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BB284680
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662546; cv=none; b=FI8ivoH1+rfT6HSoTHdGurLRWTrPdAziLFmfsGtGGSkoe3VUPCxgZ+WmUPtwj1ZvAaGemldJ1HPsfTOM0CvJkctdzjDYBBKcv/uvPA8nze6rb1snqQA68ETfIUEd5HZ9qYgs/A0IBMRZJMW7PgrTK1PZns3uJ67u6jGO4ii66o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662546; c=relaxed/simple;
	bh=d5KgJtKj1G1Ix614pd9iXcZTU2+asPLsKZcS/BvEcGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Epr2cUpca1kn71X8dgEpBSXRseo4FlQQfiqMvRVjNJCXYgAnrF8kdmCfb+yX+fQcicqIx61VL8uJv8AhZRsdnY4Yam6ZDKr/7MlrbWToaUY1ycmBwC1abC1pcm7UqvZlVmVD6Z20276zCApWt0Dk+oJ0+3u5DxU+Kkr0mvEYGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYeSu+I+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zmTO5Dw/6cMLiZQHpM0NETGxNewmzUuOIYw+uFFprs=;
	b=BYeSu+I+l82Y9aAh4UG4jSPCrB8YRYgzuelrzyVcxtKEmWpmoNWq3BcrhJNRB/qFWAEXp3
	+Xn//P8Z9uOdOZ6su2vT1EWwJXeRCx9XVgxh2P84ksETzRq37NAui1zpOnREBpuMXL6rO2
	hvOkF4sfwTkpO2CwVdVyDUtS6IOAW14=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-2rUaU-jNNKG9tI2ycuf2Yw-1; Mon,
 19 May 2025 09:49:00 -0400
X-MC-Unique: 2rUaU-jNNKG9tI2ycuf2Yw-1
X-Mimecast-MFC-AGG-ID: 2rUaU-jNNKG9tI2ycuf2Yw_1747662538
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5F44195608C;
	Mon, 19 May 2025 13:48:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BD1819560AA;
	Mon, 19 May 2025 13:48:54 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] fs/netfs: reorder struct fields to eliminate holes
Date: Mon, 19 May 2025 14:48:02 +0100
Message-ID: <20250519134813.2975312-7-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Max Kellermann <max.kellermann@ionos.com>

This shrinks `struct netfs_io_stream` from 104 to 96 bytes and `struct
netfs_io_request` from 600 to 576 bytes.

[DH: Modified as the patch to turn netfs_io_request::error into a short
was removed from the set]

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/netfs.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 73537dafa224..33f145f7f2c2 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -144,8 +144,8 @@ struct netfs_io_stream {
 	struct netfs_io_subrequest *front;	/* Op being collected */
 	unsigned long long	collected_to;	/* Position we've collected results to */
 	size_t			transferred;	/* The amount transferred from this stream */
-	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned short		error;		/* Aggregate error for the stream */
+	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* Index of stream in parent table */
 	bool			avail;		/* T if stream is available */
 	bool			active;		/* T if stream is active */
@@ -240,19 +240,10 @@ struct netfs_io_request {
 	void			*netfs_priv;	/* Private data for the netfs */
 	void			*netfs_priv2;	/* Private data for the netfs */
 	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-iter) */
-	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
-	unsigned int		debug_id;
-	unsigned int		rsize;		/* Maximum read size (0 for none) */
-	unsigned int		wsize;		/* Maximum write size (0 for none) */
-	atomic_t		subreq_counter;	/* Next subreq->debug_index */
-	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
-	spinlock_t		lock;		/* Lock for queuing subreqs */
 	unsigned long long	submitted;	/* Amount submitted for I/O so far */
 	unsigned long long	len;		/* Length of the request */
 	size_t			transferred;	/* Amount to be indicated as transferred */
 	long			error;		/* 0 or error that occurred */
-	enum netfs_io_origin	origin;		/* Origin of the request */
-	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	unsigned long long	i_size;		/* Size of the file */
 	unsigned long long	start;		/* Start position */
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
@@ -260,7 +251,16 @@ struct netfs_io_request {
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
 	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
+	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
+	unsigned int		debug_id;
+	unsigned int		rsize;		/* Maximum read size (0 for none) */
+	unsigned int		wsize;		/* Maximum write size (0 for none) */
+	atomic_t		subreq_counter;	/* Next subreq->debug_index */
+	unsigned int		nr_group_rel;	/* Number of refs to release on ->group */
+	spinlock_t		lock;		/* Lock for queuing subreqs */
 	unsigned char		front_folio_order; /* Order (size) of front folio */
+	enum netfs_io_origin	origin;		/* Origin of the request */
+	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
 	refcount_t		ref;
 	unsigned long		flags;
 #define NETFS_RREQ_OFFLOAD_COLLECTION	0	/* Offload collection to workqueue */



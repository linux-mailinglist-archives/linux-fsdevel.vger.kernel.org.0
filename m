Return-Path: <linux-fsdevel+bounces-79386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J12Imc9qGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:10:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36345201072
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D10EC305DD7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9573B3BE6;
	Wed,  4 Mar 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuT6s5rz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CF3AE70B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633090; cv=none; b=ES6VotMwCEuyMajkkIRunlarIVLhiR67x3jqLxAuC0wC9ytlHyE+/s1XzTIdYzImCSLy1VTy8eHkWfk7XfnpX3f3iuOMsLUOySXVwXSQfu/M1B/sTWVgKwb3x7lMSepJ4otUrUi/9HqkpvHOt2B4SqRoWOFd2xi/2cqhb5kGXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633090; c=relaxed/simple;
	bh=VcOZjsJ4CdphSKdTgenpkdwStJn6CCz7omsomjQqS3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrpZ60CFhbUlgmsUOK1eupC9yxq8eHeGw+f9DalwCz6k1S3PfZecXn+m/UTN1wwEoc//czBjbgP1EKc9V3PlBRCWmeGtjwGBzpNtJAyJpLgDvzPS6Ezwus2/yNtfnSmeZuWKCIyWifYHa21USgn8WAXc4wuYeQlo7oOavhZwcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuT6s5rz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmalM6e/KranB4NTwyzjDkasLFtiotle3DJG5ULgat8=;
	b=cuT6s5rzRAobu3ZTTDtU4sjT2lauhN6wRCQPIERy342Coabm7RtfNS+MU3lQQanPikxBsB
	JRGC9n1bU8W5JKQJBBqNIGPY4mJqOimBEf41ZfTcT34l8orC8yFQiQNTqejlUr+TQvWEcx
	T7acVR4Bc2Pi4+FNn8x3vrwJwTraWxo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-JTv7Sk2YOCuKy6jgSHs42Q-1; Wed,
 04 Mar 2026 09:04:45 -0500
X-MC-Unique: JTv7Sk2YOCuKy6jgSHs42Q-1
X-Mimecast-MFC-AGG-ID: JTv7Sk2YOCuKy6jgSHs42Q_1772633082
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BF9418002F0;
	Wed,  4 Mar 2026 14:04:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE60B1958DC5;
	Wed,  4 Mar 2026 14:04:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>
Subject: [RFC PATCH 09/17] cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma()
Date: Wed,  4 Mar 2026 14:03:16 +0000
Message-ID: <20260304140328.112636-10-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 36345201072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79386-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,samba.org:email,linux.dev:email,infradead.org:email,manguebit.org:email]
X-Rspamd-Action: no action

Add support for ITER_BVECQ to smb_extract_iter_to_rdma().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smbdirect.c | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index c79304012b08..0c6262010cd2 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -3298,6 +3298,63 @@ static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Extract memory fragments from a BVECQ-class iterator and add them to an RDMA
+ * list.  The folios are not pinned.
+ */
+static ssize_t smb_extract_bvecq_to_rdma(struct iov_iter *iter,
+					 struct smb_extract_to_rdma *rdma,
+					 ssize_t maxsize)
+{
+	const struct bvecq *bq = iter->bvecq;
+	unsigned int slot = iter->bvecq_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	if (slot >= bq->nr_segs) {
+		bq = bq->next;
+		if (WARN_ON_ONCE(!bq))
+			return -EIO;
+		slot = 0;
+	}
+
+	do {
+		struct bio_vec *bv = &bq->bv[slot];
+		struct page *page = bv->bv_page;
+		size_t bsize = bv->bv_len;
+
+		if (offset < bsize) {
+			size_t part = umin(maxsize, bsize - offset);
+
+			if (!smb_set_sge(rdma, page, bv->bv_offset + offset, part))
+				return -EIO;
+
+			offset += part;
+			ret += part;
+			maxsize -= part;
+		}
+
+		if (offset >= bsize) {
+			offset = 0;
+			slot++;
+			if (slot >= bq->nr_segs) {
+				if (!bq->next) {
+					WARN_ON_ONCE(ret < iter->count);
+					break;
+				}
+				bq = bq->next;
+				slot = 0;
+			}
+		}
+	} while (rdma->nr_sge < rdma->max_sge && maxsize > 0);
+
+	iter->bvecq = bq;
+	iter->bvecq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= ret;
+	return ret;
+}
+
 /*
  * Extract page fragments from up to the given amount of the source iterator
  * and build up an RDMA list that refers to all of those bits.  The RDMA list
@@ -3325,6 +3382,9 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 	case ITER_FOLIOQ:
 		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
 		break;
+	case ITER_BVECQ:
+		ret = smb_extract_bvecq_to_rdma(iter, rdma, len);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;



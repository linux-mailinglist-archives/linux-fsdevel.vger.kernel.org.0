Return-Path: <linux-fsdevel+bounces-24478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3663093FAE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590821C22113
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFA618EFDC;
	Mon, 29 Jul 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKe3WVGp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01387186E25
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270125; cv=none; b=KSzZo3fFllwAzL06LQQ4Ox1B5stVQq9+KvnlmHzz4Ft57Brac4RZM4KOiO/pxE1iOO7rthyy0XIKskfjgepELhirLOEJ69BrP2a2b0r/PND/oVTJ1Ci+JOCGun6YrZKCjtYG3IzVNilFCvJPMMSLJXK3O+i0gbKNzhrdZe47NuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270125; c=relaxed/simple;
	bh=N+ypu3jajSUyBIo4NVSFuoKGkkplCMyzOIZ87FbnL1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk+A6LG7A7C79tLM0Q71faWtBJ+D9WhjqpzvfjH9yxT3lJDINZonoPRCqaY5QvIf/V7K9ZjCbqn+CVawAk7CECC0oBEDSoTUsukoSJqqjNEGLqKQJ7PIYvjstBZtiSR0rzGvTTM6dT1ZCcAumBzDaCZLUPCY2QWqcrm0l4VsOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKe3WVGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v61GO21S8pTlp0s2AWk5G5oSQ+p84Fns5OqZB2t4B40=;
	b=dKe3WVGpuVgKDvTcF8DMDWyhQLwxBOHeysuLKie6X9v0eoYon0No5lfSwUsZczqbC/srCc
	7MShM0vNAm2MrFrDvHarhhxeEpxqv9mGs/Sj7lEh/FFa8RnO43rVhEv6qrdplK7xVrqInF
	DawkDNc80S+X+bcK11S87d9AGEVZYEE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-eZ-S57SQPJGwXvgPZFdtag-1; Mon,
 29 Jul 2024 12:21:58 -0400
X-MC-Unique: eZ-S57SQPJGwXvgPZFdtag-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF40C1955F3F;
	Mon, 29 Jul 2024 16:21:51 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE8611955F68;
	Mon, 29 Jul 2024 16:21:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH 13/24] cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SGEs
Date: Mon, 29 Jul 2024 17:19:42 +0100
Message-ID: <20240729162002.3436763-14-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Make smb_extract_iter_to_rdma() extract page fragments from an ITER_FOLIOQ
iterator into RDMA SGEs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Tom Talpey <tom@talpey.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/smbdirect.c | 71 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index d74e829de51c..52acead63d9d 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -6,6 +6,7 @@
  */
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/folio_queue.h>
 #include "smbdirect.h"
 #include "cifs_debug.h"
 #include "cifsproto.h"
@@ -2463,6 +2464,8 @@ static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
 		start = 0;
 	}
 
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
 	return ret;
 }
 
@@ -2519,6 +2522,65 @@ static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
 		start = 0;
 	}
 
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
+	return ret;
+}
+
+/*
+ * Extract folio fragments from a FOLIOQ-class iterator and add them to an RDMA
+ * list.  The folios are not pinned.
+ */
+static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
+					  struct smb_extract_to_rdma *rdma,
+					  ssize_t maxsize)
+{
+	const struct folio_queue *folioq = iter->folioq;
+	unsigned int slot = iter->folioq_slot;
+	ssize_t ret = 0;
+	size_t offset = iter->iov_offset;
+
+	BUG_ON(!folioq);
+
+	if (slot >= folioq_nr_slots(folioq)) {
+		folioq = folioq->next;
+		if (WARN_ON_ONCE(!folioq))
+			return -EIO;
+		slot = 0;
+	}
+
+	do {
+		struct folio *folio = folioq_folio(folioq, slot);
+		size_t fsize = folioq_folio_size(folioq, slot);
+
+		if (offset < fsize) {
+			size_t part = umin(maxsize - ret, fsize - offset);
+
+			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
+				return -EIO;
+
+			offset += part;
+			ret += part;
+		}
+
+		if (offset >= fsize) {
+			offset = 0;
+			slot++;
+			if (slot >= folioq_nr_slots(folioq)) {
+				if (!folioq->next) {
+					WARN_ON_ONCE(ret < iter->count);
+					break;
+				}
+				folioq = folioq->next;
+				slot = 0;
+			}
+		}
+	} while (rdma->nr_sge < rdma->max_sge || maxsize > 0);
+
+	iter->folioq = folioq;
+	iter->folioq_slot = slot;
+	iter->iov_offset = offset;
+	iter->count -= ret;
 	return ret;
 }
 
@@ -2563,6 +2625,8 @@ static ssize_t smb_extract_xarray_to_rdma(struct iov_iter *iter,
 	}
 
 	rcu_read_unlock();
+	if (ret > 0)
+		iov_iter_advance(iter, ret);
 	return ret;
 }
 
@@ -2590,6 +2654,9 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 	case ITER_KVEC:
 		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
 		break;
+	case ITER_FOLIOQ:
+		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
+		break;
 	case ITER_XARRAY:
 		ret = smb_extract_xarray_to_rdma(iter, rdma, len);
 		break;
@@ -2598,9 +2665,7 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 		return -EIO;
 	}
 
-	if (ret > 0) {
-		iov_iter_advance(iter, ret);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		while (rdma->nr_sge > before) {
 			struct ib_sge *sge = &rdma->sge[rdma->nr_sge--];
 



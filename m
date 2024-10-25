Return-Path: <linux-fsdevel+bounces-32898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECB9B07AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E21F27EE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7321745F;
	Fri, 25 Oct 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESc6emvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63656216216
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869163; cv=none; b=kb7ck9owSZhwB5y90BhtKc52VwiTxh2vz/FshCwh1O/b6uM3RGexbaVi1Xg3Do2529vsu/9PPvmcOZQvlauM4bAgiP7Ydq/RDIpGnhUP0AWoN0fzPi/giCwE3oKZ3LThDIo0Vzt2bZe0pG1rl7ET2TKGg9QTZWPvufbR55rexS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869163; c=relaxed/simple;
	bh=XgE5h5JSsM45B+HHXH3XDv6/wR/fgvzuwnpVaJQjZ6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr+WY0czvKrK49oAoN59fMiiaCiSyiFZfG0CJ3cXPn3AExBcnUdXavCRBoPv11IyhxS4bHnv1FCjfjrex0NWqYcXTZMGr26DuT81LEmeUjNA0NbLn+ym1BQLWLHGmq070txw+e6YRl9zD+vhpIm0N4NwPpECEz/DMLWc7aThdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESc6emvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIFNVFgavkgVE76rylQBcYDoA1k/9BPXcVZSMfOlsww=;
	b=ESc6emvNv5zBO8RLWcCPLBrWVXy/H4Lt25GJvuBxtON8DuO7b5oul9HHQEcSvdmhwSGo4f
	urpoMFKQh8smWpxuQNVUrRI6gXoAfhPvu9j/n/saSQrLSiazS/E6zxk53psW123+FALGfa
	FAmhSjOO5XW3WYYsA2Snbi4tN2P73kk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-KbkSjjO5MweDNtywRObLgg-1; Fri,
 25 Oct 2024 11:12:38 -0400
X-MC-Unique: KbkSjjO5MweDNtywRObLgg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1FBE1955F25;
	Fri, 25 Oct 2024 15:12:36 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F05A300018D;
	Fri, 25 Oct 2024 15:12:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 06/11] fs/proc/vmcore: factor out freeing a list of vmcore ranges
Date: Fri, 25 Oct 2024 17:11:28 +0200
Message-ID: <20241025151134.1275575-7-david@redhat.com>
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
References: <20241025151134.1275575-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           |  9 +--------
 include/linux/crash_dump.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 76fdc3fb8c0e..3e90416ee54e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1568,14 +1568,7 @@ void vmcore_cleanup(void)
 		proc_vmcore = NULL;
 	}
 
-	/* clear the vmcore list. */
-	while (!list_empty(&vmcore_list)) {
-		struct vmcore_mem_node *m;
-
-		m = list_first_entry(&vmcore_list, struct vmcore_mem_node, list);
-		list_del(&m->list);
-		kfree(m);
-	}
+	vmcore_free_mem_nodes(&vmcore_list);
 	free_elfcorebuf();
 
 	/* clear vmcore device dump list */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index ae77049fc023..722dbcff7371 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -135,6 +135,17 @@ static inline int vmcore_alloc_add_mem_node(struct list_head *list,
 	return 0;
 }
 
+/* Free a list of vmcore memory nodes. */
+static inline void vmcore_free_mem_nodes(struct list_head *list)
+{
+	struct vmcore_mem_node *m, *tmp;
+
+	list_for_each_entry_safe(m, tmp, list, list) {
+		list_del(&m->list);
+		kfree(m);
+	}
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.46.1



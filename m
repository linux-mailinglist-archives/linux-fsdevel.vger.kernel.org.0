Return-Path: <linux-fsdevel+bounces-32897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6B9B07A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4ECB1F27E5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFF21744D;
	Fri, 25 Oct 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCYGFgfC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A05216212
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869157; cv=none; b=J6vJjXeecUHYXPIKVyGA3E3cS9deS6hnnnEvG6VBXfkSsmb+tf8em6Rrp3nAblftQckOjWg44wRiS/c0brRk1/elo2gHJnVl1imXE6lRudLACxsCDAXrowvX7A45oO9D593JuFYMOWBu/dajpCCwBonu1CJNjSbHK4hFwmlalP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869157; c=relaxed/simple;
	bh=wzqFyeRzIbZYPQzh5xeryisiS+GCyWq3rwgwt2g7Hdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX37LHy3FvFlf6d3+GCFxObAZNFkcqbAE4CoJ1ujflL9d8QRgvCZpIKvZy19Qs0O+BIrspOU1+Bqvz2ofkeeaHsNyBLLUzZNfhGqF5IjRjAFN1zx/TSwbgFfgpK+aISJu8BMxxL87Nj7+oB2edLV++sSZMKG59XS9HrS0JcqCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCYGFgfC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UerumhmGRgSm1AsU/ieQ+gWT/mqI7oI1n5V7Kl7Bfao=;
	b=HCYGFgfCMHNSarehRCaSP7uVM+vkNMk5LydC2a67LZ8gNqc6Tn6IhzixzzeReS9SITamTS
	Pz2K9BWn/utDdQgZGRHekthwHuXu9GSfNFq4S1nHdYlpa0RJBQ1t1m1ZP5hkYkzoCXr/tZ
	QG7PXvXAwI1rQGLpaAdvwdc7xQ8s1a4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-8XrGVJi3OyGjKDZHuJgcSw-1; Fri,
 25 Oct 2024 11:12:30 -0400
X-MC-Unique: 8XrGVJi3OyGjKDZHuJgcSw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98ACF1955E70;
	Fri, 25 Oct 2024 15:12:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 006CD30001A9;
	Fri, 25 Oct 2024 15:12:19 +0000 (UTC)
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
Subject: [PATCH v1 05/11] fs/proc/vmcore: factor out allocating a vmcore memory node
Date: Fri, 25 Oct 2024 17:11:27 +0200
Message-ID: <20241025151134.1275575-6-david@redhat.com>
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
 fs/proc/vmcore.c           | 21 ++-------------------
 include/linux/crash_dump.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 47652df95202..76fdc3fb8c0e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -683,11 +683,6 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_mmap	= mmap_vmcore,
 };
 
-static struct vmcore_mem_node * __init get_new_element(void)
-{
-	return kzalloc(sizeof(struct vmcore_mem_node), GFP_KERNEL);
-}
-
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
 			   struct list_head *vc_list)
 {
@@ -1090,7 +1085,6 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_mem_node *new;
 	int i;
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
@@ -1113,13 +1107,8 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_mem_node(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset. */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
@@ -1133,7 +1122,6 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
-	struct vmcore_mem_node *new;
 	int i;
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
@@ -1156,13 +1144,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 		end = roundup(paddr + phdr_ptr->p_memsz, PAGE_SIZE);
 		size = end - start;
 
-		/* Add this contiguous chunk of memory to vmcore list.*/
-		new = get_new_element();
-		if (!new)
+		if (vmcore_alloc_add_mem_node(vc_list, start, size))
 			return -ENOMEM;
-		new->paddr = start;
-		new->size = size;
-		list_add_tail(&new->list, vc_list);
 
 		/* Update the program header offset */
 		phdr_ptr->p_offset = vmcore_off + (paddr - start);
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 5e48ab12c12b..ae77049fc023 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -121,6 +121,20 @@ struct vmcore_mem_node {
 	loff_t offset;
 };
 
+/* Allocate a vmcore memory node and add it to the list. */
+static inline int vmcore_alloc_add_mem_node(struct list_head *list,
+		unsigned long long paddr, unsigned long long size)
+{
+	struct vmcore_mem_node *m = kzalloc(sizeof(*m), GFP_KERNEL);
+
+	if (!m)
+		return -ENOMEM;
+	m->paddr = paddr;
+	m->size = size;
+	list_add_tail(&m->list, list);
+	return 0;
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.46.1



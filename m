Return-Path: <linux-fsdevel+bounces-32896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B500F9B079F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0C31F27E38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B4617085A;
	Fri, 25 Oct 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4f6VDPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC31741C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869150; cv=none; b=Ip42R5sntUb3aCFfk9M3cyderVoVEvhl3HJwsKuKW96WDVJNWSWLw6zgI4h9QmkXcZSVUHQ/95Vwd5W87LLo6sHL5CJBxbGBp2jnrshSz/MBeHgiU4A2ya0opwmk+L6Ch52lwB2xdQRgs8ffBG8ao5AkZj9xfyg+c2gRU5YnZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869150; c=relaxed/simple;
	bh=OKuCXCkQYhPRRPyz3j97T+8ZrBgA9TgHLuBXidwiR8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t98A9fI4k+A5UpPgV7xmm/uYy1W+LzS0e2GrmeGNP8Wlujx9dA0hvVY341dXyTAuYUTg03TK5YziYjNEauVP/Ts48ehlrsBm9rllmx1H+lkDISPGB7pltJ2z7qEnMQrzHh6bZXahRn09iq9R5fQ+aPOP4+1q0W92Q5tqtptscL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4f6VDPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729869146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6QGok1SHO7tWBONbTK+qNFzpgcjUP8FVLCibVkMqhw=;
	b=F4f6VDPowolVgA+uXd3Bdfk804HllggMYQN1XDYRdzlPfMrlvctSDCbIOU5nYL8YeCL1ZW
	Srd8KL/ZNC+UBeNXVgXXdEJQn1zU3Ly91pPlLBqTYoFGd+owCNO+OmcZ7l/W7EXMY4PG/y
	4JsUglSrbN4B2vO3d6IPQVEgSCkKrjw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-m7d72Gv7PTyqbx3Zkb-x3g-1; Fri,
 25 Oct 2024 11:12:21 -0400
X-MC-Unique: m7d72Gv7PTyqbx3Zkb-x3g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65E1F1956077;
	Fri, 25 Oct 2024 15:12:19 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E93DA300018D;
	Fri, 25 Oct 2024 15:12:10 +0000 (UTC)
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
Subject: [PATCH v1 04/11] fs/proc/vmcore: move vmcore definitions from kcore.h to crash_dump.h
Date: Fri, 25 Oct 2024 17:11:26 +0200
Message-ID: <20241025151134.1275575-5-david@redhat.com>
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

These defines are not related to /proc/kcore, move them to crash_dump.h
instead. While at it, rename "struct vmcore" to "struct
vmcore_mem_node", which is a more fitting name.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           | 20 ++++++++++----------
 include/linux/crash_dump.h | 13 +++++++++++++
 include/linux/kcore.h      | 13 -------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 6371dbaa21be..47652df95202 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -304,10 +304,10 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
  */
 static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 {
+	struct vmcore_mem_node *m = NULL;
 	ssize_t acc = 0, tmp;
 	size_t tsz;
 	u64 start;
-	struct vmcore *m = NULL;
 
 	if (!iov_iter_count(iter) || *fpos >= vmcore_size)
 		return 0;
@@ -560,8 +560,8 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
+	struct vmcore_mem_node *m;
 	u64 start, end, len, tsz;
-	struct vmcore *m;
 
 	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
 	end = start + size;
@@ -683,16 +683,16 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_mmap	= mmap_vmcore,
 };
 
-static struct vmcore* __init get_new_element(void)
+static struct vmcore_mem_node * __init get_new_element(void)
 {
-	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
+	return kzalloc(sizeof(struct vmcore_mem_node), GFP_KERNEL);
 }
 
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
 			   struct list_head *vc_list)
 {
+	struct vmcore_mem_node *m;
 	u64 size;
-	struct vmcore *m;
 
 	size = elfsz + elfnotesegsz;
 	list_for_each_entry(m, vc_list, list) {
@@ -1090,11 +1090,11 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
+	struct vmcore_mem_node *new;
 	int i;
 	Elf64_Ehdr *ehdr_ptr;
 	Elf64_Phdr *phdr_ptr;
 	loff_t vmcore_off;
-	struct vmcore *new;
 
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr)); /* PT_NOTE hdr */
@@ -1133,11 +1133,11 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 						size_t elfnotes_sz,
 						struct list_head *vc_list)
 {
+	struct vmcore_mem_node *new;
 	int i;
 	Elf32_Ehdr *ehdr_ptr;
 	Elf32_Phdr *phdr_ptr;
 	loff_t vmcore_off;
-	struct vmcore *new;
 
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */
@@ -1175,8 +1175,8 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 static void set_vmcore_list_offsets(size_t elfsz, size_t elfnotes_sz,
 				    struct list_head *vc_list)
 {
+	struct vmcore_mem_node *m;
 	loff_t vmcore_off;
-	struct vmcore *m;
 
 	/* Skip ELF header, program headers and ELF note segment. */
 	vmcore_off = elfsz + elfnotes_sz;
@@ -1587,9 +1587,9 @@ void vmcore_cleanup(void)
 
 	/* clear the vmcore list. */
 	while (!list_empty(&vmcore_list)) {
-		struct vmcore *m;
+		struct vmcore_mem_node *m;
 
-		m = list_first_entry(&vmcore_list, struct vmcore, list);
+		m = list_first_entry(&vmcore_list, struct vmcore_mem_node, list);
 		list_del(&m->list);
 		kfree(m);
 	}
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index acc55626afdc..5e48ab12c12b 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -114,10 +114,23 @@ struct vmcore_cb {
 extern void register_vmcore_cb(struct vmcore_cb *cb);
 extern void unregister_vmcore_cb(struct vmcore_cb *cb);
 
+struct vmcore_mem_node {
+	struct list_head list;
+	unsigned long long paddr;
+	unsigned long long size;
+	loff_t offset;
+};
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
 
+struct vmcoredd_node {
+	struct list_head list;	/* List of dumps */
+	void *buf;		/* Buffer containing device's dump */
+	unsigned int size;	/* Size of the buffer */
+};
+
 /* Device Dump information to be filled by drivers */
 struct vmcoredd_data {
 	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index 86c0f1d18998..9a2fa013c91d 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -20,19 +20,6 @@ struct kcore_list {
 	int type;
 };
 
-struct vmcore {
-	struct list_head list;
-	unsigned long long paddr;
-	unsigned long long size;
-	loff_t offset;
-};
-
-struct vmcoredd_node {
-	struct list_head list;	/* List of dumps */
-	void *buf;		/* Buffer containing device's dump */
-	unsigned int size;	/* Size of the buffer */
-};
-
 #ifdef CONFIG_PROC_KCORE
 void __init kclist_add(struct kcore_list *, void *, size_t, int type);
 
-- 
2.46.1



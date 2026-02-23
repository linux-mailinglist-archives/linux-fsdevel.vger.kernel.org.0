Return-Path: <linux-fsdevel+bounces-77911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBXvC3L9m2kC+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:10:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DA4172923
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686D43038515
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64D334E777;
	Mon, 23 Feb 2026 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuY13OLN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648434DB4F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830305; cv=none; b=G5YvkShx9ZbqFwcCw7bubmluelUfvQHQt5nh0Qd21owv1S6YeSC9eyGVsZXzhNn7TFKwi7kdqpI77Yysf3tLd9FAXlugDJUCaj2AsMInTU6oN4U0OWPOwhLQYJdu//QOB4F+VdOu1eGUDxemV4NGb900Nl1BWoi1T/G+s/ICoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830305; c=relaxed/simple;
	bh=iDix/n4pVAIJPUoquOFXsOCCYgQvpl1U4uPwq5uCVtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YpzDwOnXrLyUrNPw3xljw4kuiHtIAviC+K4mxE+I7nw418TKMLPRDZhD0mnK+hvTH/1jgxg8F9rQS9sobBxUsQY2UD7imMQDR9o3X+1JmgInIn47xb3EnZhXjOPyWiwOSMZYW6IxkfcK7uO3GjPYFAOKS8VQOzwhUeraiXi57Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuY13OLN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-824b6a68bc5so1493721b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771830302; x=1772435102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hvlyYma5WxiXq2U7NpPf+2thlXYSRdGBqdcHHPoogA=;
        b=MuY13OLNP8i5l78fsXs6uYWDz0YwwH6JTFHPH7y0JSZPd6P9d7idRTM/wp90Gwmk5f
         2YYigrVMmTYlBN3H761EN4c7G89J3Q3vbQJ6D4eT0YN650mt/6isjpAE/62+OnAnyX57
         vIOA4r1OJXA/pnYhpcWprLgBqV+D8EfE0qHAvFdriu5oJYYAnR6YyfQRS5Ec0DXzUSsI
         fvkWPm8DVF9Tl2FdvmLdxGm1HcoAy0Hf8ADk1B1QdjZJPfV0yWYFu0D8tXkujyL8U4H2
         R8nCA+C5zHevjZOLMm5tOt6cOphSRbz9ky3/hdEaykjXzLD1Z6j7DaVxWGCN33aVxylD
         XxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771830302; x=1772435102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hvlyYma5WxiXq2U7NpPf+2thlXYSRdGBqdcHHPoogA=;
        b=WdKpoTSLfNWxA0opN5KdbZ2L8seVHsOO+7UGFV0ATNFRNH9iGLdD0B1LpghykdusQK
         nbvbz1MJ4TE7lRllcPdM3N5r/zkh64FheqYFFLiOge2yOu9uPtM1WqQAzmWEvlJngdXh
         nM3N66CuxcbO/LfOQ+d2sDW7BNkAgDEzj/VGOdfw8027FEKm9IVZklUSMwNAoSvKFxZY
         Rk0S2Ia8SwrD+l9/ZtCzI41INOu/tTolWSugOuNlvV/WBy+N8U+wdmCdW3FSC1pnNFc2
         RFj7Z7MyMhogDvZaqsYfcA/709pEQqIvuy6d0S9aJwXzQnhzjvUe5rudgbrwgMtVYLzq
         kF/A==
X-Forwarded-Encrypted: i=1; AJvYcCWBI3wzjy6d46RR4wHsR9bcS6uVwc4K9pnVjInro61C24/wRpkWQofdTF0JD4pZ7B2i0tlin66QvcTqLVrD@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUYydWrB4GEf4RXkJGBU/juSp8lzrdmEcwhrPIWc8L04XsvZ9
	WJ8H0k0JGqwZ1Huzort3yid6P9sI2bq8j1TXCax6/Wj68mxJjAJKnxL+YS641B4bLPyP0lftHDc
	KhFi8sbHHEC3Iuq/R8AmUCnhX8Q==
X-Received: from pfbgi1.prod.google.com ([2002:a05:6a00:63c1:b0:824:ad09:9204])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1489:b0:81f:4e60:1c6f with SMTP id d2e1a72fcca58-826daab9ee2mr5973915b3a.64.1771830302254;
 Sun, 22 Feb 2026 23:05:02 -0800 (PST)
Date: Mon, 23 Feb 2026 07:04:41 +0000
In-Reply-To: <cover.1771826352.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771826352.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <0f1f7f4643157eb9612e368961fd05fbcc474935.1771826352.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 08/10] KVM: guest_memfd: Track amount of memory
 allocated on inode
From: Ackerley Tng <ackerleytng@google.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, willy@infradead.org, pbonzini@redhat.com, shuah@kernel.org, 
	ackerleytng@google.com, seanjc@google.com, shivankg@amd.com, 
	rick.p.edgecombe@intel.com, yan.y.zhao@intel.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, vannapurve@google.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77911-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88DA4172923
X-Rspamd-Action: no action

The guest memfd currently does not update the inode's i_blocks and i_bytes
count when memory is allocated or freed. Hence, st_blocks returned from
fstat() is always 0.

Introduce byte accounting for guest memfd inodes.  When a new folio is
added to the filemap, add the folio's size using inode_add_bytes().
Conversely, when folios are truncated and removed from the mapping, sum
their sizes and subtract the total from the inode's byte count via
inode_sub_bytes().

With this change, stat.st_blocks for a guest_memfd will correctly report
the number of 512-byte blocks allocated to the file, consistent with other
memory-based filesystems like tmpfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e6c66ab7062b3..ef7f049dadace 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -137,6 +137,8 @@ static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 		return ERR_PTR(ret);
 	}
 
+	inode_add_bytes(inode, folio_size(folio));
+
 	return folio;
 }
 
@@ -247,10 +249,14 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 		__kvm_gmem_invalidate_end(f, start, end);
 }
 
-static void kvm_gmem_truncate_folio(struct folio *folio)
+static size_t kvm_gmem_truncate_folio(struct folio *folio)
 {
+	size_t nr_bytes;
+
 	folio_lock(folio);
 
+	nr_bytes = folio_size(folio);
+
 	if (folio_mapped(folio))
 		unmap_mapping_folio(folio);
 
@@ -262,6 +268,8 @@ static void kvm_gmem_truncate_folio(struct folio *folio)
 	filemap_remove_folio(folio);
 
 	folio_unlock(folio);
+
+	return nr_bytes;
 }
 
 static void kvm_gmem_truncate_range(struct inode *inode, pgoff_t start,
@@ -269,6 +277,7 @@ static void kvm_gmem_truncate_range(struct inode *inode, pgoff_t start,
 
 {
 	struct folio_batch fbatch;
+	size_t nr_bytes = 0;
 	pgoff_t next;
 	pgoff_t last;
 	int i;
@@ -279,11 +288,13 @@ static void kvm_gmem_truncate_range(struct inode *inode, pgoff_t start,
 	next = start;
 	while (filemap_get_folios(inode->i_mapping, &next, last, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i)
-			kvm_gmem_truncate_folio(fbatch.folios[i]);
+			nr_bytes += kvm_gmem_truncate_folio(fbatch.folios[i]);
 
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
+
+	inode_sub_bytes(inode, nr_bytes);
 }
 
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
-- 
2.53.0.345.g96ddfc5eaa-goog



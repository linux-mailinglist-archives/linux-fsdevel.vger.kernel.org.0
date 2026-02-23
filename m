Return-Path: <linux-fsdevel+bounces-77910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGpEC078m2kC+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:05:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90C817283F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB70C3021405
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1D34B186;
	Mon, 23 Feb 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdYFkPBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81434DB61
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830304; cv=none; b=Dp4IN9giL3t+CrMfdSOOrmQRDgyuUdAyPtVpK6BsNCPXEuF5b3GDH0Y1dgcsFiGN67ULLZpA2wzwzfjQ84QQFs5DiLngPYycN4XwAfzLKfQdbWHjT0j2h9GIyCdYwCLkERNP8dEzoUwwNY4wsxoaOalwG5awwPELvX7eJk+pY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830304; c=relaxed/simple;
	bh=4AzPo53RW7z1u/HbYb3WJwZj9BjSBVUkolJYB1GMnjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jRjeWota8rLs2Ps6RDiXcEmZIGFAOsAI/xw2MUUfSxeQV1Cw8kKOu61cg645URaeVxIPACejCjHU0h5C3xLZLLN7zPQ3u8c6+Bdd+S6KX9Ut8dqXyGdknjMpd9P7OqL7N8+jO2Jz+LlvgLpeq+/ua6lVeUZ7SyQfgVea7hKbk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdYFkPBf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6187bdadcdso2432857a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771830301; x=1772435101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LofWqILwJgF/mJhvsOWfJxePDPZCogY694ZgccXLsPg=;
        b=OdYFkPBfQH4Od8qHGMA/2NYywEzCZPCaiMbzPeT2P1O4bPQO6lgX37BBuYJgY+uVdl
         uZFSi6I89L0ezxGImCQizgqr/u/jSdeaNky8s1uFmNRwaEEkk6Ghfex10g+KS5SigmMu
         VF/w1xhRRhxa5hEf6Zf7vhTkJa/1xMNFy7II99r8u99fnZXh0nwgHbwz5b3Bc4DOqfwP
         4EIPp+IFB3T8ePLrruXguj1Z0+zMU7iUrie/K2wI5LllZLxzrx5AwuZnQxb6BxTKTBMZ
         BCe+uXR5qX25sl0+edj5NbA6pgXnSA4hjDlcA1hvzp/pUkbAEC+tTmY4gyoswRqnUETK
         Nehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771830301; x=1772435101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LofWqILwJgF/mJhvsOWfJxePDPZCogY694ZgccXLsPg=;
        b=iNyHcYN9uOKxSisq6C6KBz5cUvVA2BSxWE/UzIkbujJw6JN/hBCMOzOM1wlURep4Pe
         mEr7GM4fHGnxjoRMnFGblSRdvGqgRetpzV6XSmcG+Av+o8lT0GICKHHqWkr7coumfRSr
         VN+ChFQvoU42PYIIoL4UMR/g1lR+q4gInM4xYjs5oOkId6HhgYaW1713XXi648S6yC/R
         Rb/NQzVQq1YO1/M2s1LAS6bnq3CumjgGL0qcKFvfgLG6vQ8+ySNl29vZt7afL+ALW4hx
         hCfDTgjs3+SXgHFxuLpGbK5do5k3tx9xXjmdRxHikm5TQkIQ7xiO5hMhla2tX9gs0E9c
         r8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUWSNSsAie3CL6yJ12Pi1dA6sK7kB2Ae3VJ7uZnTrtuVG+FS+v+dVmKvoRpG9SLWaiKox+vVedpm7AwyKHD@vger.kernel.org
X-Gm-Message-State: AOJu0YzHWjF7UHkhGdPmCO8sPfOvft/UMmaxMmI6vqm2gae+8MAgei8x
	8Sx2e9rUWdnB+mIBCY/8D6t4Qt/PmyFXAZphN7uMLS/LsaEoc98yXsuA2saSCPKzwMgOxcUeKmG
	SXk3qfPg1jR0dHsoAN2aF9igckA==
X-Received: from pfwz14.prod.google.com ([2002:a05:6a00:1d8e:b0:7cf:2dad:ff87])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:438e:b0:823:3056:78c6 with SMTP id d2e1a72fcca58-826da9f10bfmr6260281b3a.41.1771830300774;
 Sun, 22 Feb 2026 23:05:00 -0800 (PST)
Date: Mon, 23 Feb 2026 07:04:40 +0000
In-Reply-To: <cover.1771826352.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771826352.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <976ac2117ed9be6339e898cd80daed8f32b5044e.1771826352.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 07/10] KVM: guest_memfd: Implement custom truncation function
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77910-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C90C817283F
X-Rspamd-Action: no action

Implement custom truncation function for guest_memfd, and replace calls to
truncate_inode_pages_range() with calls to this custom truncation function.

The custom truncation function removes a lot of the generality supported by
truncate_inode_pages_range() not required by guest_memfd, such as

+ sub-PAGE_SIZE truncations
+ Support for writeback

In a later patch, guest_memfd use this custom truncation function to handle
updating of i_blocks and i_bytes in the inode during truncation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 43 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 57dec458bfa77..e6c66ab7062b3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -247,6 +247,45 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 		__kvm_gmem_invalidate_end(f, start, end);
 }
 
+static void kvm_gmem_truncate_folio(struct folio *folio)
+{
+	folio_lock(folio);
+
+	if (folio_mapped(folio))
+		unmap_mapping_folio(folio);
+
+	/*
+	 * guest_memfd doesn't need writeback, skip anything to do with
+	 * writeback and just clear the dirty flag.
+	 */
+	folio_clear_dirty(folio);
+	filemap_remove_folio(folio);
+
+	folio_unlock(folio);
+}
+
+static void kvm_gmem_truncate_range(struct inode *inode, pgoff_t start,
+				    size_t nr_pages)
+
+{
+	struct folio_batch fbatch;
+	pgoff_t next;
+	pgoff_t last;
+	int i;
+
+	last = start + nr_pages - 1;
+
+	folio_batch_init(&fbatch);
+	next = start;
+	while (filemap_get_folios(inode->i_mapping, &next, last, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); ++i)
+			kvm_gmem_truncate_folio(fbatch.folios[i]);
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+}
+
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	pgoff_t start = offset >> PAGE_SHIFT;
@@ -260,7 +299,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 
 	kvm_gmem_invalidate_begin(inode, start, end);
 
-	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+	kvm_gmem_truncate_range(inode, offset, len >> PAGE_SHIFT);
 
 	kvm_gmem_invalidate_end(inode, start, end);
 
@@ -984,7 +1023,7 @@ static void kvm_gmem_evict_inode(struct inode *inode)
 
 	truncate_inode_pages_final_prepare(mapping);
 
-	truncate_inode_pages_range(mapping, 0, inode->i_size);
+	kvm_gmem_truncate_range(inode, 0, inode->i_size >> PAGE_SHIFT);
 
 	clear_inode(inode);
 }
-- 
2.53.0.345.g96ddfc5eaa-goog



Return-Path: <linux-fsdevel+bounces-77906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGNKN5f8m2kC+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:07:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0D17288F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D329304D96F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1434BA2E;
	Mon, 23 Feb 2026 07:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="os+Qowy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882934B662
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830296; cv=none; b=f+6rIHj6gRVcbzjPIm92gJIe23bjCO2HQF0Bdr5fbOXX+Q8m1Elybtf8zWiSTPuKt2xbPnCLfMFrUwVU2Yfr4oxRUBkfx+ifNHdcvCKq6AJ//cKPjSOOJyPITr5s+Ghurnvyn2WDzZT8OATBiIAoWooaU3ryYgpDIKVKmLLhbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830296; c=relaxed/simple;
	bh=A7tFVwaDg2WHLYtVEoEto9tIear/R+w5LOCLvvXMBnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHp2RwigfqUiOn/GRmWjYjRCgKTFWnIP0cTQQS+Suur1FUZvx420nFLg1upWAE1fOcZgQYgn4RKD7Q+kqIniH5sInXFSRik+hbWi9r3a1JyebF8OF3A64aE6ttaG0KVC8PipUXvQBn15QxZsKI/O1F1QhGhK0bKW/3Itu83pV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=os+Qowy6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3562bdba6f7so28769923a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771830295; x=1772435095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pw3wTOQIfqz4K2I03v4IFEHinUKdB/xRwD0FbZ6/43I=;
        b=os+Qowy6NbZZucya5MsR5k364hse9R1HS6gyBMgK466FMpru5jbmPhlbuLxTHAju5F
         D5v1vWrh86guromec4WsEvL0rHBNLiYWzvwixAUAZsDnfiaQYN/c6Zuwyu671j/G8tTu
         MonJlhWac3Y3RElDpOvCL6mM+Z9zDA4FsH1axKVULMqtbpEidyrcdb5kVYLjXJ/Um4nj
         b5uyygwzZvpCDFgj3cuZnq7bUnEy+7OgNMKPtVb9ecNVi5kMUEBmvj6ws11q9RfSMpgT
         aLUxHrkbhZ3M4mpfba8cL80sZF3A6b7g7byUt8uNSk8uvai0sK6nJDqAtahItgfdDbha
         87+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771830295; x=1772435095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pw3wTOQIfqz4K2I03v4IFEHinUKdB/xRwD0FbZ6/43I=;
        b=JvxRFOh0++Ch1HVgdgvYEnRhTFYznQGtUCe9ek3gRy6GPTvGvf3AR5E5Xb/WSQofpm
         Lu+4zkCwMZgLx65s9/ukhju+RFMEXdkK5FC9oMpjkRMyjk76oKUgXasFJCnfYDb2KHoe
         uwDgKQ+6LEgDON5akqZd855pIDs9b5z1bUkyafWFLMVgEe4Rw0OhQqSMSN2bHJquvV3Z
         er8Z4/m2II8OQ2QyCZsl1xBjqj59opQ+7iK75UxukX1NBzF9vqbGBmW343u0G8dnRna+
         Yw0Tk0XZXA2LyvG0Ip2F7rrFPnL+wJ7vFIxHQLRJOXUtDt9N82Myba4spCTBgtSEqrjt
         PzNg==
X-Forwarded-Encrypted: i=1; AJvYcCWrtBSt/H35W7vJ5OyeJqWRnJr283Xcl3gV1yYPYA/zZM9JQ/RX3bl/VPDeCyQ2hIx54mXLMaiwTccjgv0E@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3BO0zdCpwrufHxwny71htbIMfNrnlXeUa1qaZn2YfJItGfq9
	wceVlWUynYx24haICn78Tw5SA8P/dSgjTtsJ/3UeJlP57LZyj8z5A3BunuPrtTdBUqNrzEKwoXL
	g/Nz/xUCMKqBJP/m9bIfWX9tBVQ==
X-Received: from pjbjs23.prod.google.com ([2002:a17:90b:1497:b0:34a:c430:bd91])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2550:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-358ae8d5d3amr5969350a91.26.1771830294754;
 Sun, 22 Feb 2026 23:04:54 -0800 (PST)
Date: Mon, 23 Feb 2026 07:04:36 +0000
In-Reply-To: <cover.1771826352.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771826352.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <14fcfc2a032b85c7de09e9dd39668c8061742661.1771826352.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 03/10] mm: truncate: Expose preparation steps for truncate_inode_pages_final()
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
	TAGGED_FROM(0.00)[bounces-77906-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 46B0D17288F
X-Rspamd-Action: no action

Expose preparation steps for truncate_inode_pages_final() to allow
preparation steps to be shared by filesystems that want to implement
truncation differently.

This preparation function will be used by guest_memfd in a later patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mm.h |  1 +
 mm/truncate.c      | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0d5be9dc7368..7f04f1eaab15a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3732,6 +3732,7 @@ extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
 void truncate_inode_pages(struct address_space *mapping, loff_t lstart);
 void truncate_inode_pages_range(struct address_space *mapping, loff_t lstart,
 		uoff_t lend);
+void truncate_inode_pages_final_prepare(struct address_space *mapping);
 void truncate_inode_pages_final(struct address_space *mapping);
 
 /* generic vm_area_ops exported for stackable file systems */
diff --git a/mm/truncate.c b/mm/truncate.c
index 12467c1bd711e..0e85d5451adbe 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -487,7 +487,9 @@ void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
 EXPORT_SYMBOL(truncate_inode_pages);
 
 /**
- * truncate_inode_pages_final - truncate *all* pages before inode dies
+ * truncate_inode_pages_final_prepare - Prepare the mapping for final
+ * truncation but not actually truncate the inode pages. This could be
+ * used by filesystems which want to add custom truncation of folios.
  * @mapping: mapping to truncate
  *
  * Called under (and serialized by) inode->i_rwsem.
@@ -495,7 +497,7 @@ EXPORT_SYMBOL(truncate_inode_pages);
  * Filesystems have to use this in the .evict_inode path to inform the
  * VM that this is the final truncate and the inode is going away.
  */
-void truncate_inode_pages_final(struct address_space *mapping)
+void truncate_inode_pages_final_prepare(struct address_space *mapping)
 {
 	/*
 	 * Page reclaim can not participate in regular inode lifetime
@@ -516,6 +518,21 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		xa_lock_irq(&mapping->i_pages);
 		xa_unlock_irq(&mapping->i_pages);
 	}
+}
+EXPORT_SYMBOL(truncate_inode_pages_final_prepare);
+
+/**
+ * truncate_inode_pages_final - truncate *all* pages before inode dies
+ * @mapping: mapping to truncate
+ *
+ * Called under (and serialized by) inode->i_rwsem.
+ *
+ * Filesystems have to use this in the .evict_inode path to inform the
+ * VM that this is the final truncate and the inode is going away.
+ */
+void truncate_inode_pages_final(struct address_space *mapping)
+{
+	truncate_inode_pages_final_prepare(mapping);
 
 	truncate_inode_pages(mapping, 0);
 }
-- 
2.53.0.345.g96ddfc5eaa-goog



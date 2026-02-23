Return-Path: <linux-fsdevel+bounces-77909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCS5JzT8m2kC+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:05:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEAA172813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C586E301BA9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854934D929;
	Mon, 23 Feb 2026 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6J0k94Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5234D4E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830301; cv=none; b=Y60dw0tzTRETAzcvaWKgSdOwWJMJKS9jSh7azZ4HUWd0XpsWYYYPycYpUTpKQAm+JOk2JEdRb4tM6tV3M9y8etMUPdN0WhbPKw/jmatNHyaa5jtupZiRnFMLHRqoDu4SKR63ir5tgEL4LME8cbvZgQDlszVErWxUWViHul399I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830301; c=relaxed/simple;
	bh=d3UwQnzpg88aX6gn7ACJy409YivRzc8RbQqNjcTrFfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fk8v5G+wfxdm/NNaulo0MjqZcUpwyh4uQeDL2R1q3qC6enIqS22XC7SKYv4QeyBP0LDW6jhwhZ/qYMcWP+tvz6M0CX7x2v2ocF++U+0TxyX9PqI29on4p6O2Y6AqVy6skAYU/ADXjMXn/x/G9DC8jdMK5DnlIqUhPYWm/7Fq6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6J0k94Y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad6045810so41922475ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771830299; x=1772435099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8EPkBYTIogg/WcIy2FNnZriREPEXUqsGjhG96y07ko=;
        b=B6J0k94YQxKXI/ATg+nnFkMegMK0+AC3JXFPYcwdbPpJQI6PB8F1FKAxK5PeGupwMD
         dQJiUUDatgLKphe4YPs2kJyg4BVq8njg69WHA9tn1ejUCn40awFihwD4+fcLibNP/Uj6
         tb9oa8JlrGzeqcUhc/n+1Q3oxnmEdSCiQvj+lYLuqUem6hLo0pechZbbnDqqhMnh/QBZ
         ivocdVkfelgivR5MVabH5RikvqZO4Zlsw38O4Bv6QXxI7oLDATsARVJEK+lA1eIME57O
         /OiaeQf5FaexRoN2Dx+l9fekkDYwz7TjsM7SK0rThrs8nviZtP4Vliz75osEJNYEittI
         l9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771830299; x=1772435099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8EPkBYTIogg/WcIy2FNnZriREPEXUqsGjhG96y07ko=;
        b=fz97vdqLL+aJAHSh4KNH5cDEbD+eCOI6EhpF764eEMOHfrgvxTjmj/KnIYCmGdRg/F
         4PG8tFuMIOsTckiUHSjma5g1KkimIlYybbzjcZqmGaN/mQh68M95+5iTyTKqk+lKFvY8
         llM6ZwJmBv3DJqb/oFPSTaey3Dr3sdDfL3AXfA7PDmXcfqD5m1ZxQ+Nrp/eHdccHgvs1
         nzDGKdQvAx2iOPqeY6C9fOOAlfKUmggi7tSVlIcbs4X+nx+A/i/Ygm/OUiGUze8mVQqt
         FeTJvvcidMPOBpyq9rHdxNju5chLae7pQbX8UsWHIguOCTcxuYdQ7AII8ib/rVaLMMkK
         /u8g==
X-Forwarded-Encrypted: i=1; AJvYcCW4SmNvEPMwlV5oWqlOaNLq+kbUuCzPOQRBEqnvAloZsxaRN7goWz6oBJ6QVi92marVPZ7GCQ4WJfiwTtp4@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqpjhcGajTDdta3tigXehz4mW2jJFLELEucD/qSprf8x5If5k
	lxmkxwi46ilBttfj0sMzeJTqPAE6OWOsTkrE3Ke5TRlyL9vG6/FnNdcABttVTkLoNs1Pg7PBdo1
	rOr6VXHmc4SJFuJjpeCYKqUTOAA==
X-Received: from pjbx30.prod.google.com ([2002:a17:90a:38a1:b0:356:3562:569c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:248:b0:2a0:a33f:3049 with SMTP id d9443c01a7336-2ad743fe006mr64180505ad.4.1771830299282;
 Sun, 22 Feb 2026 23:04:59 -0800 (PST)
Date: Mon, 23 Feb 2026 07:04:39 +0000
In-Reply-To: <cover.1771826352.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771826352.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <e08ed6869b9f555169476d220d7e8112e7163cee.1771826352.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 06/10] mm: filemap: Export filemap_remove_folio()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77909-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[30];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AEAA172813
X-Rspamd-Action: no action

Export filemap_remove_folio() for use by KVM.

KVM requires this function to remove folios from guest_memfd's filemap.

guest_memfd used to rely on higher-level, exported truncation functions. To
track memory that is actually allocated (i.e. i_blocks, st_blocks),
guest_memfd will need a custom truncation function to do accounting cleanup
and will be using filemap_remove_folio() for truncation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a7..379d62239fc5f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
 #include <linux/pgalloc.h>
+#include <linux/kvm_types.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -262,6 +263,7 @@ void filemap_remove_folio(struct folio *folio)
 
 	filemap_free_folio(mapping, folio);
 }
+EXPORT_SYMBOL_FOR_KVM(filemap_remove_folio);
 
 /*
  * page_cache_delete_batch - delete several folios from page cache
-- 
2.53.0.345.g96ddfc5eaa-goog



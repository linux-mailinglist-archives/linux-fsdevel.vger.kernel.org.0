Return-Path: <linux-fsdevel+bounces-41595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E515A327BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D671884733
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB020E6FE;
	Wed, 12 Feb 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pf4mY5s6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960F20F084
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368503; cv=none; b=su68UQ3lAvC0A18HPd9hBMQDqKLZTxXCKMjBNntCHvn59RcWt0YYH94KZGX9IgAnEjU8NKkE6osOwEvh1miXlRtcihjcziLC/Rg46kZXZIub43GYJihLa24U2IqVJwZZgjOUSQ72LtWiYULaBdk01P8sqOAwqUx1gGhQQ8ayX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368503; c=relaxed/simple;
	bh=BZ0EXFVtx0bypwGFoiIDPf3VnOCDey5nDk2uYFXKRE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKLM7YaFQDaKhIpXARC9jqKjDdkV6GuqAZ9917Hjk3BU45biwXZ1OLmZm0LiTSRAFnLmzgj3Z3NsSLTQZK40crlE69iFupylWVdjmjruvY3b0zAyuIYCCY2dg8rWgd3pP8GMvafReXSlX+TtEUIdMKMv4+dMo6Jx2WaEZYDYnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pf4mY5s6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739368500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iP2KfwV21yDB6zRXNXD8gha5Sw+1taL4/Qnp0xAyLq0=;
	b=Pf4mY5s6Wt0DUTm6xan3UJbNHoqh/O5WuKPGFprp/QpVVQ1Oigdnj/mnCDqmDuMP5kgnkR
	fQkFoxGHkTtYO3aQSG+ScRJ4rYZnxivAuYeJ9BYdBPlzg3Qhl4GH0U/RTUlrqcH+CuXO27
	GGJG6mTfPmQeNOHthZDiDdXnXvcRJhs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-1hv2-2gINiGFL3REmRZ07A-1; Wed,
 12 Feb 2025 08:54:57 -0500
X-MC-Unique: 1hv2-2gINiGFL3REmRZ07A-1
X-Mimecast-MFC-AGG-ID: 1hv2-2gINiGFL3REmRZ07A_1739368496
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6443B1956096;
	Wed, 12 Feb 2025 13:54:56 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D52D3001D10;
	Wed, 12 Feb 2025 13:54:55 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 08/10] dax: advance the iomap_iter on pte and pmd faults
Date: Wed, 12 Feb 2025 08:57:10 -0500
Message-ID: <20250212135712.506987-9-bfoster@redhat.com>
In-Reply-To: <20250212135712.506987-1-bfoster@redhat.com>
References: <20250212135712.506987-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Advance the iomap_iter on PTE and PMD faults. Each of these
operations assign a hardcoded size to iter.processed. Replace those
with an advance and status return.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/dax.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 3de9120edf32..85dc5c5b8332 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1776,8 +1776,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			ret |= VM_FAULT_MAJOR;
 		}
 
-		if (!(ret & VM_FAULT_ERROR))
-			iter.processed = PAGE_SIZE;
+		if (!(ret & VM_FAULT_ERROR)) {
+			u64 length = PAGE_SIZE;
+			iter.processed = iomap_iter_advance(&iter, &length);
+		}
 	}
 
 	if (iomap_errp)
@@ -1890,8 +1892,10 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			continue; /* actually breaks out of the loop */
 
 		ret = dax_fault_iter(vmf, &iter, pfnp, &xas, &entry, true);
-		if (ret != VM_FAULT_FALLBACK)
-			iter.processed = PMD_SIZE;
+		if (ret != VM_FAULT_FALLBACK) {
+			u64 length = PMD_SIZE;
+			iter.processed = iomap_iter_advance(&iter, &length);
+		}
 	}
 
 unlock_entry:
-- 
2.48.1



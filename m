Return-Path: <linux-fsdevel+bounces-42429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1073A4246F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504CC16F549
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9B02505C9;
	Mon, 24 Feb 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/ce8x4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382924EF62
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408338; cv=none; b=aGCEize/YNcIIHQyc3Z64qxidBPWiR8e2viIq94vagDJcwyhy4C6npo8hqo/hrlPGidI+zUklgqZiGkKj11HceuaNxJ4Di3YtOYGcPd/Zss7dU07PS4n6EGe6i0hiX5iU7LJT/JM78C9qNIuEZb2s8ei/wl6MC/HLitEDWMuw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408338; c=relaxed/simple;
	bh=6Ix+uh5GLmGmAzN8U9dxefEEimMSpK3Wl9EHl+TkT3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPIFHu095QE2cQ14uFUO8J4ZBCWOt++/r70g+vliUvSN7vPLtAnGPoUzsDBfyVS+wgUmMRkI71Sn4C+kwvNwDAJr5/dv5RDWoBK+jpi2qdx/8jprnmMpAi2d0/DN5wsWBcgkjRl3jIoGC6Bnbv0P6uR+Mt9KvYnPD3EE9ln8Ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/ce8x4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFwQnSbZhKkikIiLmdwfbT4ChloTe3eFBzYH7N468Pk=;
	b=a/ce8x4cmjHOGF8Uxf1d6R+UBhKcUnXv5rWdVc+zievDafKK34+5phAZZ3V+uz1ElLm+hy
	MuN08swti5QZCCF1qFyZO+LVQdYefrr8lwEOpMH5h5yJCEgtlY/oaQikvd5MgezG+fCsON
	xX3L9IdZ+w0sGbH44ySooHrpGHlS4EY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-emkk_0gqNp-TOAk-rV28Ng-1; Mon,
 24 Feb 2025 09:45:32 -0500
X-MC-Unique: emkk_0gqNp-TOAk-rV28Ng-1
X-Mimecast-MFC-AGG-ID: emkk_0gqNp-TOAk-rV28Ng_1740408331
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ED47190F9C9;
	Mon, 24 Feb 2025 14:45:31 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C2E919560AA;
	Mon, 24 Feb 2025 14:45:30 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 09/12] dax: advance the iomap_iter on pte and pmd faults
Date: Mon, 24 Feb 2025 09:47:54 -0500
Message-ID: <20250224144757.237706-10-bfoster@redhat.com>
In-Reply-To: <20250224144757.237706-1-bfoster@redhat.com>
References: <20250224144757.237706-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Advance the iomap_iter on PTE and PMD faults. Each of these
operations assign a hardcoded size to iter.processed. Replace those
with an advance and status return.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/dax.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index c8c0d81122ab..44701865ca94 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1771,8 +1771,10 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
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
@@ -1885,8 +1887,10 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
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



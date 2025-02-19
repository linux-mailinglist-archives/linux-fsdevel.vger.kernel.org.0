Return-Path: <linux-fsdevel+bounces-42106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A714FA3C698
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0103B8AB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D7192580;
	Wed, 19 Feb 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9vVy6/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387662144D4
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987311; cv=none; b=pnWv7mKqx+GWUCdplVPWVI4zagga6A8hD97cWPI44R/HLHDjS2ARzBK43QQA8djXtjtFiK+E1EA4D2hakgB4Kf4DdgtI5uUTPn3273FoYlKZF3hWXBzKi2ZBls4XEmyyeb/H+pGVxHdCsKdojaTRsFUunv0KiVcgzbMR0lIZu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987311; c=relaxed/simple;
	bh=M5HeM/bcsB+jeJ4VoNq04Pn88Kt2tiIlLDcBuNOeI9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBRKHf9A1NbkSqHh157AUC1iXr562cRyBVRdYhcG5GF9br8MeZ/v/SdVmEGhf2BToT8OQnx4gqLYhgVQitCWkRpgVBcLUEhyUmQfvVqT1l5psh6WQNqMgXs4zSJb8WK5eWVd6oysPlkaVkZ8kTHlJOvgi9lccqdY8Dxqgi2FZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9vVy6/W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBXZmx5iOmhcRhN45TDsT5IOxthhY2gP5ZbZsmfqz/4=;
	b=b9vVy6/WJDtVoIna6/FJ76Oo/HK9YyrMvY+2iLtDh7ynfpSlBPVoTIitJOwuHoJXii0rvt
	M9z9cwlNb3fpnKXWk6k1V0PPwEc2P6cwNQJkhb5woeEhuVaLUj8ULYOlfOJeXawNd3sWJw
	c4/xD8/g3RwWoOE2S3+VhCYHbiJMr4w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-ru7BYeiAMtuqkjbQCpaMVA-1; Wed,
 19 Feb 2025 12:48:25 -0500
X-MC-Unique: ru7BYeiAMtuqkjbQCpaMVA-1
X-Mimecast-MFC-AGG-ID: ru7BYeiAMtuqkjbQCpaMVA_1739987304
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CECFA190F9E4;
	Wed, 19 Feb 2025 17:48:24 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6AE71800359;
	Wed, 19 Feb 2025 17:48:23 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 09/12] dax: advance the iomap_iter on pte and pmd faults
Date: Wed, 19 Feb 2025 12:50:47 -0500
Message-ID: <20250219175050.83986-10-bfoster@redhat.com>
In-Reply-To: <20250219175050.83986-1-bfoster@redhat.com>
References: <20250219175050.83986-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Advance the iomap_iter on PTE and PMD faults. Each of these
operations assign a hardcoded size to iter.processed. Replace those
with an advance and status return.

Signed-off-by: Brian Foster <bfoster@redhat.com>
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



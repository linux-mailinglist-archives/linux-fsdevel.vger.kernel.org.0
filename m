Return-Path: <linux-fsdevel+bounces-41592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0886A327B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7749518899E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1911D20E6E4;
	Wed, 12 Feb 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjLQVHsV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9320F06A
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368501; cv=none; b=crTa5KyTpO0THTTa3Du+KnayOx26n0pNx3liTDFV82epHgfSG3vfxvHvCYLXyr7sQ/PVlJJr9UG8jBchq98VRCMj9crOZ576I22otlXrmrUruuWMWVqV6Q4ZRlAMuFeKOyaHIiWOHCykHSdPGp3MqUXpzTQhP09bo9QCjHr6XYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368501; c=relaxed/simple;
	bh=f8DFHn++FSNxdRrma0vBnULi1guvmZSKAjNa80vkjxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gl4G0KKYD1ufSYgyqw4ouXYocfYH5p+ssey/RjBjy1KcPZvm+MueaTLp6HzkzGJKIMX3J3qR31cq289HJxcigvA7R9TikGdXG4K6Nz3s1vdP2pXWTp3HcQW7cLGdZ3UpmJZ4EsHjlttgmN7AsnUqD5TzYonk9Lj5pynl4aRsEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjLQVHsV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739368498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcjroBFg2EKxMPG6+JoHYOI4juN+AENf3+yfTE6F4sk=;
	b=OjLQVHsVZsiOFSLM7wJccl/TbDAEyVwlrOGlZJ6bID+Q39XbJqg+C8Sl9VDZxp0x4SFnCy
	RYfz8Yf+yvTflpTKhHVMQ6Qdf5hHsQvhG3sK8CnmMCstS7glPIQ2Xjkx9Mzeb7kgEAYatU
	jqX6at/38JxCDlSRhIJRCXGNy58ny0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-LaR-nrDSOgCNpSbs-yfHNQ-1; Wed,
 12 Feb 2025 08:54:52 -0500
X-MC-Unique: LaR-nrDSOgCNpSbs-yfHNQ-1
X-Mimecast-MFC-AGG-ID: LaR-nrDSOgCNpSbs-yfHNQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 511A219560B9;
	Wed, 12 Feb 2025 13:54:51 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58B023001D17;
	Wed, 12 Feb 2025 13:54:50 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 04/10] dax: advance the iomap_iter in the read/write path
Date: Wed, 12 Feb 2025 08:57:06 -0500
Message-ID: <20250212135712.506987-5-bfoster@redhat.com>
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

DAX reads and writes flow through dax_iomap_iter(), which has one or
more subtleties in terms of how it processes a range vs. what is
specified in the iomap_iter. To keep things simple and remove the
dependency on iomap_iter() advances, convert a positive return from
dax_iomap_iter() to the new advance and status return semantics. The
advance can be pushed further down in future patches.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/dax.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 21b47402b3dc..296f5aa18640 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1585,8 +1585,12 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	while ((ret = iomap_iter(&iomi, ops)) > 0)
+	while ((ret = iomap_iter(&iomi, ops)) > 0) {
 		iomi.processed = dax_iomap_iter(&iomi, iter);
+		if (iomi.processed > 0)
+			iomi.processed = iomap_iter_advance(&iomi,
+							    &iomi.processed);
+	}
 
 	done = iomi.pos - iocb->ki_pos;
 	iocb->ki_pos = iomi.pos;
-- 
2.48.1



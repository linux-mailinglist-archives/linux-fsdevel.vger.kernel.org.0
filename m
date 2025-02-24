Return-Path: <linux-fsdevel+bounces-42425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0664A4242D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD9E19C4E14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A924888F;
	Mon, 24 Feb 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgfomhVj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0614D28C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408333; cv=none; b=r78p4FDIWFQJh6xh7nqY7ebTNFLE8E0mvPTgp1MNgQdcmJeyq4/c09JvurxUMenohv/0aMeC+zD32SAknPIg29AlSB2GQ2bCd8Hw9rHS0PIrnsxe2yxW3Kd1yrYSip2yHsjgfSnF1AQUL4jKFLVFmRPCCZR1+fX3vgjI+dSslew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408333; c=relaxed/simple;
	bh=TjLIkrzGgl/0/62RN6hWTWdS7vW/fwO9j9xfxyBwmB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/srs4gjomxO9Dt7dRF9e7221ZfCnigxSQ10nAN/vXliPnmk7K1O9+RKR/9WmBgCXN+8USeIFsAeFqKxaJ3X2QFpIkF93Z5SQaIJ+TKvlvhgOUpmowrxzxmCuGPHSh2lrnGfcwaTTgm4EqqLxfjK82ZgBQRafP1macang6HC9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgfomhVj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2bReV6/ZeCYB/MaQPmUx4sc1Uo2LiXqFAQf9hbKffM=;
	b=DgfomhVjvHva04mjoqEA99OvQ+mGj8jbNj3j9veYAxWv1DFHkdJ6pTeDFaYFdBu1LM8vAn
	/vlus/0fm1xyFxiFA1/GN4hGZEBlh6N511rpaM9Kj7cL5UxSB8atXrwW347VGhkPMn+yzu
	Jp8IZBBRsYzewKh3Q3JjKcB6dHfs9n0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-qq-YPSYLPXO6X8Rqb6UzGw-1; Mon,
 24 Feb 2025 09:45:27 -0500
X-MC-Unique: qq-YPSYLPXO6X8Rqb6UzGw-1
X-Mimecast-MFC-AGG-ID: qq-YPSYLPXO6X8Rqb6UzGw_1740408325
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DE98190F9FC;
	Mon, 24 Feb 2025 14:45:25 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2917F19560AB;
	Mon, 24 Feb 2025 14:45:24 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 04/12] dax: advance the iomap_iter in the read/write path
Date: Mon, 24 Feb 2025 09:47:49 -0500
Message-ID: <20250224144757.237706-5-bfoster@redhat.com>
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

DAX reads and writes flow through dax_iomap_iter(), which has one or
more subtleties in terms of how it processes a range vs. what is
specified in the iomap_iter. To keep things simple and remove the
dependency on iomap_iter() advances, convert a positive return from
dax_iomap_iter() to the new advance and status return semantics. The
advance can be pushed further down in future patches.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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



Return-Path: <linux-fsdevel+bounces-42102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8225A3C691
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3FE17A1AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB42147E0;
	Wed, 19 Feb 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPukwsMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99910214809
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987306; cv=none; b=nzq1wOjeIW9Sh+qlj5ICQNnNMUJHLEPAbxpqDvjq2L6y0wRdECDLl2v/eZm30oITFutqakL8CWSwvvE4+9Js2NG1FKdO8Pxf6tzrWaaSjNxpLlVxqOELSALo/AuHSw+k34djsVWJ0pJr5nhz1hGOhR/cj8C9YgVpyb0oWsJZXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987306; c=relaxed/simple;
	bh=haxkW4O5T1tJxjmvheOMWACsxEEkPzqqsEfH61e185E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIEWtM+NZocXIhIg7CsXhroMtONqgpNQtU1oQndCuc2OLLZzC+sjr+tHRCcboW7ciyo5xUYKsCEpvoyJVIw7Nthva9arWjPvu7jqTTfifl0hPjB3A1DqS9P/YbTJbhlPUiNHv7eoAI45bF9baQPubC8BgevRDJg+nRruPhsSyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPukwsMR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739987303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sT8vCYOXeFABE1redu+hNWAyqAvlUkaC5+RF9MwY+c4=;
	b=EPukwsMRqPKYw156Hk48wW72ZZESJoc6lVioMsnFvkCJVS6TT6LHLiBZ8Qr61yMVECswUF
	MFJ8iMHeOhnvDI/I0RRZ9NX08IKTNXaODuZghHioX5S8wlgKM3dOdV/3u12bHdR87wGnON
	6nzQf/83X6nry2u3Yk+/1V7el+9WWjQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-bSfVZ7koMQKPE3wg7AfSDQ-1; Wed,
 19 Feb 2025 12:48:19 -0500
X-MC-Unique: bSfVZ7koMQKPE3wg7AfSDQ-1
X-Mimecast-MFC-AGG-ID: bSfVZ7koMQKPE3wg7AfSDQ_1739987298
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87A7219560B9;
	Wed, 19 Feb 2025 17:48:18 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DC341800359;
	Wed, 19 Feb 2025 17:48:17 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 04/12] dax: advance the iomap_iter in the read/write path
Date: Wed, 19 Feb 2025 12:50:42 -0500
Message-ID: <20250219175050.83986-5-bfoster@redhat.com>
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

DAX reads and writes flow through dax_iomap_iter(), which has one or
more subtleties in terms of how it processes a range vs. what is
specified in the iomap_iter. To keep things simple and remove the
dependency on iomap_iter() advances, convert a positive return from
dax_iomap_iter() to the new advance and status return semantics. The
advance can be pushed further down in future patches.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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



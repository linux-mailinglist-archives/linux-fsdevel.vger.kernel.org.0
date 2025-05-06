Return-Path: <linux-fsdevel+bounces-48252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB129AAC69D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13DC3A5EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768982820CB;
	Tue,  6 May 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGMyN92u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6652820AB
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538699; cv=none; b=O4qtjJhXpBwDzl+F511qEwus0vke0q6mcX/vrlW0upVWzgwJ9VhC7xaiJZZC6mPMGClvMjorq1mMz5kZbghOOJm+V4frPSHnOraJ1xBUR9IjiNXvTRSWipOE9F8tI0mNbhvcFn4XzICPCe9xc5arQKdak1J8kTt/rG0GbTOkgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538699; c=relaxed/simple;
	bh=bxsokHBwmQvsItyL3+7D8FnFkBa89+xNStZbRDpYlp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEXMKdv1lrw9dC2z3ZlMooz0pJJamUq4htVghIacjphuz2sz3GgJNCv09RaWasR86xD5fFitsCH/c5/84Fucp2Y012VJpOEMZF8YGVETYJ/KDFYae7jMkcbcD+VGC0JUE4VUKSHBYU/BMBOGe9wEqw/mRY2NOZ+wx31UD0oZtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGMyN92u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746538697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpLGvvKJcGCeYWyzXZJZeALF1vwxaZtpiyv7gdGUMTY=;
	b=cGMyN92u256K1A+h+k9rgePaK3OUOGvyYEaUBWJFx152MQ6OeJmwjQcyaTu08EhwAnJoBB
	AYnDKdDQCCFCQbLV+luXcUIcGZE+RX8ZQHx5bBCayoSJ4O9HadxzbASUvOXp4EHeEZ7krv
	uYXvIxbe7d7s/J4NRR2G/ZPSYRumb8c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-txFs4Q0HNn2Bm9bZPw4yUg-1; Tue,
 06 May 2025 09:38:13 -0400
X-MC-Unique: txFs4Q0HNn2Bm9bZPw4yUg-1
X-Mimecast-MFC-AGG-ID: txFs4Q0HNn2Bm9bZPw4yUg_1746538693
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8A6B18009AC;
	Tue,  6 May 2025 13:38:12 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAB4919560A3;
	Tue,  6 May 2025 13:38:11 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org
Subject: [PATCH v2 5/6] iomap: push non-large folio check into get folio path
Date: Tue,  6 May 2025 09:41:17 -0400
Message-ID: <20250506134118.911396-6-bfoster@redhat.com>
In-Reply-To: <20250506134118.911396-1-bfoster@redhat.com>
References: <20250506134118.911396-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The len param to __iomap_get_folio() is primarily a folio allocation
hint. iomap_write_begin() already trims its local len variable based
on the provided folio, so move the large folio support check closer
to folio lookup.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 11046a3c60fe..92d7b659db33 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -746,6 +746,9 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	loff_t pos = iter->pos;
 
+	if (!mapping_large_folio_support(iter->inode->i_mapping))
+		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
+
 	if (folio_ops && folio_ops->get_folio)
 		return folio_ops->get_folio(iter, pos, len);
 	else
@@ -807,9 +810,6 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	if (!mapping_large_folio_support(iter->inode->i_mapping))
-		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
-
 	folio = __iomap_get_folio(iter, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
-- 
2.49.0



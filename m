Return-Path: <linux-fsdevel+bounces-54840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF4B03F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D53C1A627BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD5F25487A;
	Mon, 14 Jul 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPHh3Ehy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51E253F39
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499048; cv=none; b=Q27cRqNbiYWgyz2uxeZ9Wtow20UrSUKfIP0AMRw3SfaO1BFj6idcSirh0NH44fD4zJdDSl8vhizLnHCxg8I0n9W8BsPjmz9xUlGW5SW97cifm3uoAvUlB2rYwLphWpIBC9DezaLet3Lk+2piynuVAQfz6hT3s/RiJBD2vjyHXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499048; c=relaxed/simple;
	bh=vW22s/PoPojZugGSb375DX0cbe1kSJqFR28Fk9xR3TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otOtWdw+nXykb3xhtC3Fh6ntwhAXZFUZ9xNvlzof9x2LJ46qbnKRQH9s64Y6xjPNrtI02q6mye/9NDb31sXFKD+NxtQmtK3D8uOgo3i/lqI4LjykHVw9rO9AUq6NQylQ6K4HKzKivBJ6oor1Kcr5cnN5UCgTgsnYz+f4kY30Y/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPHh3Ehy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCOjwj+34/t9ifmYam4dh/DH4qIGBIaB0drRCZdZ628=;
	b=QPHh3EhyB4FsrHgLZp+TwxsAE7n0cZ8OdU3iuiW6VubKdxBB/MfyVQiaMeLr6kPmepvFOn
	x59DtLvunmLkG1QoI3GRwAwnMBq4/Bz+cS3Ru7x2lU4b4d5ROkDdXsHE0jku0fh2Wo8Ykc
	XP5YPlrZRXn73utwILGomvyuqlCHahs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-emcqoeHGNbKehwyK1ZeI2A-1; Mon,
 14 Jul 2025 09:17:22 -0400
X-MC-Unique: emcqoeHGNbKehwyK1ZeI2A-1
X-Mimecast-MFC-AGG-ID: emcqoeHGNbKehwyK1ZeI2A_1752499040
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4A40195608F;
	Mon, 14 Jul 2025 13:17:20 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87C621800285;
	Mon, 14 Jul 2025 13:17:19 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: [PATCH v2 2/7] iomap: move pos+len BUG_ON() to after folio lookup
Date: Mon, 14 Jul 2025 09:20:54 -0400
Message-ID: <20250714132059.288129-3-bfoster@redhat.com>
In-Reply-To: <20250714132059.288129-1-bfoster@redhat.com>
References: <20250714132059.288129-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The bug checks at the top of iomap_write_begin() assume the pos/len
reflect exactly the next range to process. This may no longer be the
case once the get folio path is able to process a folio batch from
the filesystem. Move the check a bit further down after the folio
lookup and range trim to verify everything lines up with the current
iomap.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..38da2fa6e6b0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -805,15 +805,12 @@ static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t pos = iter->pos;
+	loff_t pos;
 	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
 	struct folio *folio;
 	int status = 0;
 
 	len = min_not_zero(len, *plen);
-	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
-	if (srcmap != &iter->iomap)
-		BUG_ON(pos + len > srcmap->offset + srcmap->length);
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
-- 
2.50.0



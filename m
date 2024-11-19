Return-Path: <linux-fsdevel+bounces-35222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3500D9D2A12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79751F21ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFC61D1F40;
	Tue, 19 Nov 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDBKlvJV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978D1D173E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031133; cv=none; b=tqF0OnCUEQX3vD3KAe+SmzKrbG5bBWyzI9wiQ13t45ybl/VwwofvVUpAOqIHDPuP6rDnwUzvmYhnDKegPccdeT3n2W8v/ijgdNnV6WCrlC4jHQ5mjF8WyoXZHpbfD8xbk1LfSf+KyhmxhzlmK2gSt0yocCVhzjIwuGfcuvci6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031133; c=relaxed/simple;
	bh=DUqTZuX3ibPNvI0oVsl5z3VIK6xmqdlnQ95TwMVcteo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgzHl8/ewoN5cgL46bTlI1L80aQF64fX4CCIwUK5PIkylv4/c3BWkA9KJBdnVmDDNffRtSN1nej1Q1Fo6sbGmkf1zX9ienUFc1ZW7I4RiVzVLOxAXIWEcBiockd6kNe7CeEp+rJKCVswPCpz73mVvmddpr5cdDArsdEf9Td30PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDBKlvJV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732031127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjZU7g2vo6uZ/HXSxZz5fNHUtmju3LrZ0LlIZ9RX0h4=;
	b=aDBKlvJVKuJ3ez6Lf4oIStYrUXlDRnXce9YMASU06GScsXJmGYV363mUfCS2oagDR/BaTx
	0vI45cIyJtpkg4Nr1gTrAAWcvR8jbF9dO+gW337kFQK0RR5BCkspwkznQzHzgEa09rz7cb
	lq1IAbgs3yZmaBwbkY315TWM06EQHUc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-4m05kcxjMXy3WLJZNo6vmg-1; Tue,
 19 Nov 2024 10:45:24 -0500
X-MC-Unique: 4m05kcxjMXy3WLJZNo6vmg-1
X-Mimecast-MFC-AGG-ID: 4m05kcxjMXy3WLJZNo6vmg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54107195608D;
	Tue, 19 Nov 2024 15:45:23 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.120])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFFDE1956054;
	Tue, 19 Nov 2024 15:45:22 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Subject: [PATCH RFC 1/4] iomap: allow passing a folio into write begin path
Date: Tue, 19 Nov 2024 10:46:53 -0500
Message-ID: <20241119154656.774395-2-bfoster@redhat.com>
In-Reply-To: <20241119154656.774395-1-bfoster@redhat.com>
References: <20241119154656.774395-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

To facilitate batch processing of dirty folios for zero range, tweak
the write begin path to allow the caller to optionally pass in its
own folio/pos combination.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/buffered-io.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ce73d2a48c1e..d1a86aea1a7a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -781,7 +781,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 {
 	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	struct folio *folio;
+	struct folio *folio = *foliop;
 	int status = 0;
 
 	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
@@ -794,9 +794,15 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	folio = __iomap_get_folio(iter, pos, len);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	/*
+	 * XXX: Might want to plumb batch handling down through here. For now
+	 * let the caller do it.
+	 */
+	if (!folio) {
+		folio = __iomap_get_folio(iter, pos, len);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
+	}
 
 	/*
 	 * Now we have a locked folio, before we do anything with it we need to
@@ -918,7 +924,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
 
 	do {
-		struct folio *folio;
+		struct folio *folio = NULL;
 		loff_t old_size;
 		size_t offset;		/* Offset into folio */
 		size_t bytes;		/* Bytes to write to folio */
@@ -1281,7 +1287,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		return length;
 
 	do {
-		struct folio *folio;
+		struct folio *folio = NULL;
 		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
@@ -1385,7 +1391,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
 	}
 
 	do {
-		struct folio *folio;
+		struct folio *folio = NULL;
 		int status;
 		size_t offset;
 		size_t bytes = min_t(u64, SIZE_MAX, length);
-- 
2.47.0



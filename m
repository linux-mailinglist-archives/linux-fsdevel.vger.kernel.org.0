Return-Path: <linux-fsdevel+bounces-56160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF9B14309
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C689E162DA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF227978D;
	Mon, 28 Jul 2025 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/Y5wtUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86A1E8329
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734688; cv=none; b=dZCDUZjScZyglironxOdIYvwWwSXTMlTTf4te56lQa4oKEFakI/2JDfiyY0mrm/6LoyPB+en9hyHIeleMh0hK3hdPYHzS8WbL44/romm0Y9zsEFEh/fhXTqeeSFxS10hwJOHtUkgThDKI5wK/I5TN/mogBzflI6Yz4fywJ+tF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734688; c=relaxed/simple;
	bh=VtYwCsYFXmwKFqSisiEpZ1WiddXgYvi2ZL1c1U3QwOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBWTivskj+gpjJ5ORDJHCwxu7k4DfmnpmcSMYV5XPLTd6j4pt3xOP7DDQefgVIrN1mwSfDFTb2gxQc+b4WiVw4QczOEUSpOxVtYPBHP2G99i5bpwfuzmJQ3z7MSNGxvInTi/dL/agPtvUO9i5q8pqT0YU9s5X+07pgGS4i1nNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/Y5wtUq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrPk2sjX8mGGWKQ8DNv1YTNF7pzc9fqd1IKi+H9eIyc=;
	b=d/Y5wtUqZDjOUKlxrulTo6HdyAWSLhXUTnWumzqg/nOgnHIWpYsnSdv2PG8r7zWX0CTaMa
	3Vpamo1WpEy+Mbi32t/pGnGZaG6r+glc0H3/XcyHn4fOKdGfTmur5nveEJWxPrWhELAPAB
	PHoT5JUHDsOekiHI0bwx1G51cq2LIxY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-2XCo50QvPW-3PKYVVdwCMA-1; Mon, 28 Jul 2025 16:31:24 -0400
X-MC-Unique: 2XCo50QvPW-3PKYVVdwCMA-1
X-Mimecast-MFC-AGG-ID: 2XCo50QvPW-3PKYVVdwCMA_1753734683
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-af658355147so167832566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734683; x=1754339483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrPk2sjX8mGGWKQ8DNv1YTNF7pzc9fqd1IKi+H9eIyc=;
        b=i0QjZvsAm0h5R4MiKGqlijquvdDs4N11VJYijRDnhVhETcqGmTKiulc6HnIpMWpDD3
         x0LOWR24eP2bOm/borfV96yLBuxCppOdOGhOzpAxqoud7ld+d1qBWTQq1pVb6ZNKjDXT
         BTpvIjw9Uhs4yZbJ4GTNxv4NHRPavGsZ41AljINHIYJDocQ91T6HwI1LReVEQlj7dcYr
         mUiRB3MsfPUH+jko/YGlfFjPfQ0a++FglwM8pW8UVmG7aSz9ryHwHAENGX5KkYU3E+w3
         nKvEG6nmnRJj+tIk01YP2wMIf8XIRWkYgtOTqVu9IvCaxadtcr6HsNsvmh8irMWJbD4N
         3sAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW22nJFSy/IGuWj7sTxpMsxV2clQsnyorsfjtY/rTEClvYa7DVpEZRG6g531WFrTPfB3/FAAgG3p7WCXd0@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfmZHbrnxkUSKgfLwiAQzzppQ4FPLd1Ufqkyf1xcANInf30Uz
	AC05TI+tVhuGuXGB0d7wdZqDKZMqaXqAN/IlPqYbk1PGlO6clLNo5uunUHLgNm3lqu3QJ9JAuFh
	W8tEO3bTGwWp4KAaLltwCFbGLNP78hmMf4jdc506fWnNDNQfHvwspSjbfXwcLTmboMErm2fq01A
	==
X-Gm-Gg: ASbGncshByLaK96hUWfVaIVBbWbj1IHgywOrioP9Ts2BoXRMs26wrIQ+SElEomq9wzu
	xy7idfgsbgacBtl6HigE2mC1Rd1awIxXoAmVZOIWUZf5rRmd0QcZi/cydqFrVPYUw59LEC6Jj2U
	XI9x6JmccOqhidQXIhxgI+A4p6od6V2uKBCrvvtPRQ33uaoLJ9+dRT3SU1+XErslJZc9eCiCeSR
	U5sixhCE5G/rjksZmmGRJMikzA5qzSJwG1q1Bwx75quZI1i8nxRveb2AuVAZ3LyEObgeyOPN1fw
	8MZDFF4DbHy7nuxld5Vy/Kb6CiJ2dljKMHyYyfBhsscDJw==
X-Received: by 2002:a17:907:3f16:b0:ae6:abe9:8cbc with SMTP id a640c23a62f3a-af61c4b1b33mr1529808766b.12.1753734682802;
        Mon, 28 Jul 2025 13:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjzaXG6dlANtTMHpawQqb/YKviL4IINJii4EK7mPdu5nM4elwa0LnJxEQkmRLmU8yvj62GcA==
X-Received: by 2002:a17:907:3f16:b0:ae6:abe9:8cbc with SMTP id a640c23a62f3a-af61c4b1b33mr1529805366b.12.1753734682423;
        Mon, 28 Jul 2025 13:31:22 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:22 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:05 +0200
Subject: [PATCH RFC 01/29] iomap: add iomap_writepages_unbound() to write
 beyond EOF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-1-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3505; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=hg7XZ6Ib6H6dW2N76cefwEA06f5dZUZhN/YvcDCBY0o=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrviV+c1KSVO9mzRHj25Kw+k7benQaH5V+/lg7PF
 k1SK9Z8m9lRysIgxsUgK6bIsk5aa2pSkVT+EYMaeZg5rEwgQxi4OAVgIp22jAzbDx87GJ0qzs6V
 OqWaUyvz3PSwb/8fnL9y+4hyecyfI4bLGf6X5//aqdlXOO/n7TB3rxKzqRq5R0sOxT7h4Pzz/8/
 eCX78ANZBSW0=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Add iomap_writepages_unbound() without limit in form of EOF. XFS
will use this to write metadata (fs-verity Merkle tree) in range far
beyond EOF.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 51 +++++++++++++++++++++++++++++++++++++++-----------
 include/linux/iomap.h  |  3 +++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3729391a18f3..7bef232254a3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1881,18 +1881,10 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0;
 	u32 rlen;
 
-	WARN_ON_ONCE(!folio_test_locked(folio));
-	WARN_ON_ONCE(folio_test_dirty(folio));
-	WARN_ON_ONCE(folio_test_writeback(folio));
-
-	trace_iomap_writepage(inode, pos, folio_size(folio));
-
-	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
-		return 0;
-	}
 	WARN_ON_ONCE(end_pos <= pos);
 
+	trace_iomap_writepage(inode, pos, folio_size(folio));
+
 	if (i_blocks_per_folio(inode, folio) > 1) {
 		if (!ifs) {
 			ifs = ifs_alloc(inode, folio, 0);
@@ -1956,6 +1948,23 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	return error;
 }
 
+/* Map pages bound by EOF */
+static int iomap_writepage_map_eof(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct folio *folio)
+{
+	int error;
+	struct inode *inode = folio->mapping->host;
+	u64 end_pos = folio_pos(folio) + folio_size(folio);
+
+	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
+		folio_unlock(folio);
+		return 0;
+	}
+
+	error = iomap_writepage_map(wpc, wbc, folio);
+	return error;
+}
+
 int
 iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 		struct iomap_writepage_ctx *wpc,
@@ -1972,9 +1981,29 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 			PF_MEMALLOC))
 		return -EIO;
 
+	wpc->ops = ops;
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		WARN_ON_ONCE(!folio_test_locked(folio));
+		WARN_ON_ONCE(folio_test_dirty(folio));
+		WARN_ON_ONCE(folio_test_writeback(folio));
+
+		error = iomap_writepage_map_eof(wpc, wbc, folio);
+	}
+	return iomap_submit_ioend(wpc, error);
+}
+EXPORT_SYMBOL_GPL(iomap_writepages);
+
+int
+iomap_writepages_unbound(struct address_space *mapping, struct writeback_control *wbc,
+		struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops)
+{
+	struct folio *folio = NULL;
+	int error;
+
 	wpc->ops = ops;
 	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
 		error = iomap_writepage_map(wpc, wbc, folio);
 	return iomap_submit_ioend(wpc, error);
 }
-EXPORT_SYMBOL_GPL(iomap_writepages);
+EXPORT_SYMBOL_GPL(iomap_writepages_unbound);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 522644d62f30..4a0b5ebb79e9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -464,6 +464,9 @@ void iomap_sort_ioends(struct list_head *ioend_list);
 int iomap_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
 		const struct iomap_writeback_ops *ops);
+int iomap_writepages_unbound(struct address_space *mapping,
+		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops);
 
 /*
  * Flags for direct I/O ->end_io:

-- 
2.50.0



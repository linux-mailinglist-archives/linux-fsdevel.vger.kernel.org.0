Return-Path: <linux-fsdevel+bounces-23671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8AC931194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CE0B22907
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BBF18756F;
	Mon, 15 Jul 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="DziKE2LF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F0187543;
	Mon, 15 Jul 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036738; cv=none; b=EcZLk3UFKoQxqG9iOJp51FC11KTsx8XrGabsslryuAwJMqQQ6rvjqcsqBWkgDF7RKBXzlPDFI5Ki7hu2gCmeMVfLZhk0/oIS2EbBolIUp8u0tN7EKDNXytXEDgU4kJQs2ycY7sNq8QuyGpIQH8AcBbZNUOIW20H2j6t59h6vSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036738; c=relaxed/simple;
	bh=Y6wnkr9YicCwKOn6q4dbs0j5MDwg7izxrtZViWy+w08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWMF3bmDAUrkZBOSck4w+drjBdIJqVwTzQC/IOxyEdl+O+TkhJo9ViW7JOrIfSc+liNNQloP4kJ1ywFKINaMxzYknghWsIzCgqj23gDYQ2AUk+h3PLKpSeih1HtmkfHvW6mpwh0DwlN+shg0ZE+7gqA1e6L8YJWeO8of8+PEzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=DziKE2LF; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WMy4D6rpSz9slc;
	Mon, 15 Jul 2024 11:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721036733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbld/pizLMEJfrPYBqwQ81gjcSKIsZj5n7TDu8kDUY0=;
	b=DziKE2LFE+foxOGJVWPx7ePlNX35aSAPc4JT7wXBeonEpWgqtmj1s/uCtAHsolEfoAlwQY
	SFHmwH8TKmqeUWfMSvGVo1Z0aXhDPf8+DmViEFIO2v1b9HHxDDPPY3c8/PwyYU2RUGwKAH
	mkom7J2oa+9jxrEdMn5SXSewYicuV2NroLCHc+Pa2V3xv8RSElNGN2MOEZDnAJ4oIqYlRI
	mgWoCRcbeSUvnl3qbdNHoBCr/Ddebi04C9Qw4g/wOP3gXzvHsoP1IDR/qwFlJBa1/S71IX
	TJHSleYyo8MxFnpbaphpSvEblAhElowOxU8DcvzyXza3tjwqH9XWxmnUJioUwQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 05/10] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Mon, 15 Jul 2024 11:44:52 +0200
Message-ID: <20240715094457.452836-6-kernel@pankajraghav.com>
In-Reply-To: <20240715094457.452836-1-kernel@pankajraghav.com>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WMy4D6rpSz9slc

From: Pankaj Raghav <p.raghav@samsung.com>

Usually the page cache does not extend beyond the size of the inode,
therefore, no PTEs are created for folios that extend beyond the size.

But with LBS support, we might extend page cache beyond the size of the
inode as we need to guarantee folios of minimum order. While doing a
read, do_fault_around() can create PTEs for pages that lie beyond the
EOF leading to incorrect error return when accessing a page beyond the
mapped file.

Cap the PTE range to be created for the page cache up to the end of
file(EOF) in filemap_map_pages() so that return error codes are consistent
with POSIX[1] for LBS configurations.

generic/749(currently in xfstest-dev patches-in-queue branch [0]) has
been created to trigger this edge case. This also fixes generic/749 for
tmpfs with huge=always on systems with 4k base page size.

[0] https://lore.kernel.org/all/20240615002935.1033031-3-mcgrof@kernel.org/
[1](from mmap(2))  SIGBUS
    Attempted access to a page of the buffer that lies beyond the end
    of the mapped file.  For an explanation of the treatment  of  the
    bytes  in  the  page that corresponds to the end of a mapped file
    that is not a multiple of the page size, see NOTES.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d27e9ac54309d..d322109274532 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3608,7 +3608,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3634,6 +3634,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	if (end_pgoff > file_end)
+		end_pgoff = file_end;
+
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
-- 
2.44.1



Return-Path: <linux-fsdevel+bounces-20441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F78D383F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A868228B7E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6974F446D2;
	Wed, 29 May 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="TqtfP3YU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D61BDDB;
	Wed, 29 May 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990348; cv=none; b=Nj/ANMJMdC2RUwYoqAciB37OTgXPl4xB0NSCaHB3P779h3BrFUCVK4ZIvWPHaozKcmlxoIeKm6cmk7ovGy5J6XsyIpch+/eLHyF2J4c6ykxA0TF2wQRHSkExvBXapk1a+IaC8nC1dJhx7ZlEdyvozQ4p2dDHZxpbFKT3FSK5SAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990348; c=relaxed/simple;
	bh=PikEFdPsSj7PpNKfl3VotL5mNxNQN3UX8dWKhVBFbfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcuMpHX00OgCvP4n7CkTt1OxrRnEYZURtDXCywRl6r3CQXzneMYQFxG8jZnfZNmnrDNEl4JwE0tDsf1C+Zq3luJVU+UdXqUzDuZDNELXl8poWul5EdVwx1SJ/3Or8jLAbuDCqNo8TJyXnTANX9rnrF0PEuy0i1F8nqy9i2JngGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=TqtfP3YU; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vq9d35L8bz9sSV;
	Wed, 29 May 2024 15:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMIZWzID8Oa4XZs06SFDXCAlixk5rrqjrLjasnPiZuM=;
	b=TqtfP3YUwosVu7v0T47uciWkMe74vRAl8UvhaEbvYSJvKjyU80QI/rlEdo79J3hwSsOL+x
	XAzNTXip1JSRvFThNu6Ij0FFS31H5OKr3oEJjrdHGPRKRjrm7oADrjwiTliDERUr8dSzFr
	397nhNEFSnybU26IOcKwVIlESyW3YXW3YHAGH8Xd5nDsexhkoksr/o9c6fRoDoDoluWCQQ
	dwmCJitjxvFOnbeJObIQDmb4xY7dATIx7ePqyMFspsBtIjcLi7pq4LGt4Onfz+1kklSG/M
	bZkjJPooW+suPUUkKtzq00x8pQ7Oo0j5Yh2i5xT/Tb9Y5zNSh0CxI/KsvapQNQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 06/11] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Wed, 29 May 2024 15:45:04 +0200
Message-Id: <20240529134509.120826-7-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9d35L8bz9sSV

From: Pankaj Raghav <p.raghav@samsung.com>

Usually the page cache does not extend beyond the size of the inode,
therefore, no PTEs are created for folios that extend beyond the size.

But with LBS support, we might extend page cache beyond the size of the
inode as we need to guarantee folios of minimum order. Cap the PTE range
to be created for the page cache up to the max allowed zero-fill file
end, which is aligned to the PAGE_SIZE.

An fstests test has been created to trigger this edge case [0].

[0] https://lore.kernel.org/fstests/20240415081054.1782715-1-mcgrof@kernel.org/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0914ef2e8256..e398fa7b2ef6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3610,7 +3610,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3636,6 +3636,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
2.34.1



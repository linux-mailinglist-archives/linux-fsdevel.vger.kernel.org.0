Return-Path: <linux-fsdevel+bounces-17353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5738AB906
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9191F2186A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75141D524;
	Sat, 20 Apr 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S43ZRVEm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88129417
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581468; cv=none; b=aBdUL8PUC7mOTxAAN84OetGmHFcuX2rj1ZqBM3aafOtXL8moGRMEQxvjSPSXYTye9yBl4VDFPuh32OgsMSTUNjt20mQ3eX1myPa96RocBGumD+b/RItHu90D2p8PipF9F6vq/ZDjHR0tm1IKekPD0AonPd5RykbklSPuKT3D56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581468; c=relaxed/simple;
	bh=G5OBVcxK4D0JMoz115O1cPyfxqSq7kONY+dLeVFp+T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWhlrdQlrKw4rTd2AxArLuVvlGw3JQ4e/ZAUOLQVhfJ/cUUAo3z4LYPhn6dIxFhM7KXpXS9fdr0AEPhMmGhZHLLwDr9tlobAqDxuqwtR81P/1GqTv3IIuKCvXfbz3xpRg8kj3UVD1T7vKuxH3cyzwAV6np3AR1A/UeYi2MRfFt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S43ZRVEm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=G9CKTeM4M0IHsldWj9g7eJFdQO2VrtDywwK1bhHPzcg=; b=S43ZRVEmGLWt4Guyp/aV3ynNaJ
	87HAlPxLT1zNvUw7hIhMKqTx7XFHR/bXPsiC1U1c7xC0mZmn/zUgSJpxp3tmKTzXP4TPoN6rcb+dA
	uv/NIAZVntm178wuEPpBLzJR7VwjpKavHEWqHNQx31pge/F+NhPZAM+kFJ1qAWukmRmVOOBAKvdPO
	ypXn3zI8QAjduy3dk+CaW7ngz6a+YY3juvGNqjFsLOyeQa+j4fOVy7XoZqMq7f/miszODuSX00V2N
	s7l1YmoioNVLn8U/97oPi1+Kyh7HvE8XAoUNk9f+nyA/b0Y+blLLgTh+f76u1CHJSFJjkqA4ekU9V
	jyMU5gpw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0of-000000095gw-3jgL;
	Sat, 20 Apr 2024 02:51:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 29/30] fs: Remove calls to set and clear the folio error flag
Date: Sat, 20 Apr 2024 03:50:24 +0100
Message-ID: <20240420025029.2166544-30-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the folio error flag any more, so we can stop setting
and clearing it.  Also remove the documentation suggesting to not
bother setting the error bit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/vfs.rst | 3 +--
 mm/filemap.c                      | 8 --------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6e903a903f8f..a6022ec59a2d 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -913,8 +913,7 @@ cache in your filesystem.  The following members are defined:
 	stop attempting I/O, it can simply return.  The caller will
 	remove the remaining pages from the address space, unlock them
 	and decrement the page refcount.  Set PageUptodate if the I/O
-	completes successfully.  Setting PageError on any page will be
-	ignored; simply unlock the page if an I/O error occurs.
+	completes successfully.
 
 ``write_begin``
 	Called by the generic buffered write code to ask the filesystem
diff --git a/mm/filemap.c b/mm/filemap.c
index fc784259f278..f8d0cc980044 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -530,7 +530,6 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 			struct folio *folio = fbatch.folios[i];
 
 			folio_wait_writeback(folio);
-			folio_clear_error(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
@@ -2342,13 +2341,6 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 	unsigned long pflags;
 	int error;
 
-	/*
-	 * A previous I/O error may have been due to temporary failures,
-	 * eg. multipath errors.  PG_error will be set again if read_folio
-	 * fails.
-	 */
-	folio_clear_error(folio);
-
 	/* Start the actual read. The read will unlock the page. */
 	if (unlikely(workingset))
 		psi_memstall_enter(&pflags);
-- 
2.43.0



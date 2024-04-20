Return-Path: <linux-fsdevel+bounces-17336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321608AB8F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF101F2136B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7C15E86;
	Sat, 20 Apr 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YKC4lDY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087ADF6C
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581457; cv=none; b=pjJxmz+kefQJxSyIinmq6PN2PDRLHId8IQAoSRTc0LabGi/8VseuZWdomhrwvuyintazX+3co2ogz+7m6zX1q7mmZMEVGFInCLMTaadJgBPldVMVQHKqD0rivsa4rfwFe8NPOAMXa6nc2v/BsOrbRF/X9gRKJETnoFGNUbyGBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581457; c=relaxed/simple;
	bh=9Wl7Or5G3IkXqEPcsD85gLYq/lgOOE3G7+fWToxy6xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMYOYFPP5gk/wKYS63gEV2N+zwTsnKZsaGVnDaU8DwSPC4vkdmqC5LRjR5eMhQjTLCNbtyczYw9lkV3mdBtqOAjg4Z9XrM1yF7b6uUmbSkANZsl7vr/5eQIVugdl8sLmsio5QugOhPMGaljf8L8QHTYcB2/E0tBcrupVtATmyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YKC4lDY3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lfQiTKH6qz2CerAT9IefP0Uh9+x805gtJN1XTCu7aP0=; b=YKC4lDY3fCCGK1nxYq+3kOvjvA
	Yi9muG8VsEYA3lVXRBD5uCCfwSV8PwMfjsrdxMKOq345k5UsUn1F4KkTpCr6+zxuC7Ca5kc6uUpsT
	Xu8G/tYBxcjzfPJJL7jd4N3SGal5GDI5CvTCd35pst8DQYNeMc4lQKXeZ4NyD18j2brKw6ol8GKVx
	pofwl66XzQvJ8ugN+4oIjpmwWZ0PpPn3ioLQlAa/FPOJfbEqWTMMk1Op8Hu9efdD6IEPDWeQVmJD0
	fXQIp6B4ZxUGr23MTtuwEYKlJXRq0sPmJcKlu5SPxFRoDnAKfARDcE9eQ3R8iLDKeLtFwuR0zlR51
	cCaaRQDw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oT-000000095eY-01nX;
	Sat, 20 Apr 2024 02:50:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu
Subject: [PATCH 08/30] coda: Convert coda_symlink_filler() to use folio_end_read()
Date: Sat, 20 Apr 2024 03:50:03 +0100
Message-ID: <20240420025029.2166544-9-willy@infradead.org>
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

This is slightly more efficient than separate calls to
folio_mark_uptodate() and folio_unlock(), and it's easier to read.
Get rid of the call to folio_set_error() as nobody will check this flag.

Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: coda@cs.cmu.edu
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/coda/symlink.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index ccdbec388091..40f84d014524 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -31,15 +31,7 @@ static int coda_symlink_filler(struct file *file, struct folio *folio)
 	cii = ITOC(inode);
 
 	error = venus_readlink(inode->i_sb, &cii->c_fid, p, &len);
-	if (error)
-		goto fail;
-	folio_mark_uptodate(folio);
-	folio_unlock(folio);
-	return 0;
-
-fail:
-	folio_set_error(folio);
-	folio_unlock(folio);
+	folio_end_read(folio, error == 0);
 	return error;
 }
 
-- 
2.43.0



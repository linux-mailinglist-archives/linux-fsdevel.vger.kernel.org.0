Return-Path: <linux-fsdevel+bounces-45524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31312A791B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 17:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A4D3B23EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC6F23C8D8;
	Wed,  2 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DFlhRkJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFD23C8AD;
	Wed,  2 Apr 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606016; cv=none; b=ShimyzcyVvpHKvgz4XitjPyDkt5tP/1oi1kG+nm7D5ogUvNw6HI4vpSEkaZmGG3NK3e18KWM96BI2OubxYGxhjG7omewI4rRiGpHBPVQpJuHQyYdYItIPOtcKrq2JsQ4vFRtwWys1IO6imt8TpFU/YYW1Jb68Hl3elbCvpFlN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606016; c=relaxed/simple;
	bh=isEtce1XzbwTB4+VX7772Pt07KMqxmVCirBGrNO7B/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNKZi/By3ydh56pcU0JYCU9KH/w747zmnNfqwf+h7OoctyDNbJnvCYCzkLH2coCRUiicH5XLdsyiSzkgN5DAYtr43xGqrquMzp0Ra8VkJZPEIf1XdElp59KfJ+WDdBC2uR52DADfTeyNhCfSGQwfvNE6w8h64P37opEsPYFWc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DFlhRkJZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=H/LzOSBZMJnPa9n+hJhMKcetVnuAU/qb1xOh1kNA3po=; b=DFlhRkJZvk0FxUhTFpLMVcqGW6
	xG1V3XXL/3wXAn/c2FOYw2EQMYqW/olCsErvNjPUKfLGXt+KADdT2YskzUX3BUzbnyAagDDYzB/fm
	ZR4Q9IpNbzkJL3GnwtfzS0XcEfD/32j2Dfmitv5ap5a8XrmQ8JcS7Kf2QXPDc3sqfLLqaVqVAynw3
	SVXXASaClM2+3ASDNUleyBPQi3HXCWxVaxx8xZiTEgWj5/FavNMrcjK/FGXAxKgWhUbSiBa86JP8X
	ULsI58AmQLxczl1eK++kle8TpZzr4ssoKT0HwbiRLd+lve1N9BIfdY9N8jDECSQ2yYLh8qLlIA9Mb
	nT2UhlgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzzZX-00000009gs7-0PTo;
	Wed, 02 Apr 2025 15:00:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	v9fs@lists.linux.dev
Subject: [PATCH v2 1/9] 9p: Add a migrate_folio method
Date: Wed,  2 Apr 2025 15:59:55 +0100
Message-ID: <20250402150005.2309458-2-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402150005.2309458-1-willy@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The migration code used to be able to migrate dirty 9p folios by writing
them back using writepage.  When the writepage method was removed,
we neglected to add a migrate_folio method, which means that dirty 9p
folios have been unmovable ever since.  This reduced our success at
defragmenting memory on machines which use 9p heavily.

Fixes: 80105ed2fd27 (9p: Use netfslib read/write_iter)
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/9p/vfs_addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 32619d146cbc..1286d96a29bc 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -164,4 +164,5 @@ const struct address_space_operations v9fs_addr_operations = {
 	.invalidate_folio	= netfs_invalidate_folio,
 	.direct_IO		= noop_direct_IO,
 	.writepages		= netfs_writepages,
+	.migrate_folio		= filemap_migrate_folio,
 };
-- 
2.47.2



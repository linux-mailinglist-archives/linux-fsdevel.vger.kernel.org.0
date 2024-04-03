Return-Path: <linux-fsdevel+bounces-16058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D789773C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D681C27EC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90144156679;
	Wed,  3 Apr 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NBN8xLFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD6156659;
	Wed,  3 Apr 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165050; cv=none; b=CGtgOACFI1ivI0p8BFjiN1mF7iXZiCHOHT15egBhHqcWHIskdQSfLU1EhChw6M6wBoTvcHIGEHRVZOfLgm0XlUdK1kpzD+UjT1qzek56vY6WaK1APlAju2OcrrY6E0afuopfcxlOTWqvTpNEsRcOBHrS1sRDSiczCcEZorOwQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165050; c=relaxed/simple;
	bh=ORpRWJMY1qzBxPxGWZN2Mj5S+iHrWxXhiWRdGO/X5mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/FaqdiNWcneQSGBoDqotGASQ2I7MQyv6Bg6wAmTJO1z55HjZ0UVjkjJXfrDm8nzXvikfCAtrq9oSS553QK3q73p1cvdR23wh5qJI3pK3zv8xJCWYGJqsA9HXG4R36+lpGo5ClsZcU5d66dFP4Pjuzbc9iqGoa9vzV4hVaZgBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NBN8xLFX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=fxH0mxaT3cyNp7jz1I5izgnb/QBaokhnLw7wUCAoDwg=; b=NBN8xLFXDRznLv/Z/1cvh0Rcvf
	+vigdCd5QcIqSPhG+/PCZ0RNwKJ0+cuOohvkm2yyGp3ZYvF8LDFo4Faa4goTEfUpRw5L8m9kmXg2f
	yXzvwBUkM+FHiQ9L8Xz/rUUmMHzVAiMhkXgyXT2X64DyJgL7652bP0p6/T5E+HVMSCUv4lyYcvJ2r
	Tb1yQDWR3BztWR2HzkHNbDmAMcmfPcY3EBmYoWLswkz52OaMCeitSPntjcpkGfXhOFWiFg8Bgztoq
	yMEr3ATxJUjfHN+HUVsTKiVJJOZfeoI8+M5IurVgHr3s9fbVoEm5QMXehNXq4DFBHq9Yz52b3R4an
	B2fsuDpw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4LE-0000000651Z-1Q78;
	Wed, 03 Apr 2024 17:24:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev
Subject: [PATCH 0/4] More GFS2 folio conversions
Date: Wed,  3 Apr 2024 18:23:47 +0100
Message-ID: <20240403172400.1449213-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet more gfs2 folio conversions.  As usual, compile tested only.
The third patch is a bit more "interesting" than most.

Matthew Wilcox (Oracle) (4):
  gfs2: Convert gfs2_page_mkwrite() to use a folio
  gfs2: Add a migrate_folio operation for journalled files
  gfs2: Simplify gfs2_read_super
  gfs2: Convert gfs2_aspace_writepage() to use a folio

 fs/gfs2/aops.c       | 34 ++-----------------------
 fs/gfs2/file.c       | 59 ++++++++++++++++++++++----------------------
 fs/gfs2/meta_io.c    | 16 ++++++------
 fs/gfs2/ops_fstype.c | 46 ++++++++++------------------------
 4 files changed, 53 insertions(+), 102 deletions(-)

-- 
2.43.0



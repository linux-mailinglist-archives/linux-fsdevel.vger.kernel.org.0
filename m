Return-Path: <linux-fsdevel+bounces-17330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B48AB8E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DF31F219CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5711702;
	Sat, 20 Apr 2024 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccfV/Pxn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BAD28D;
	Sat, 20 Apr 2024 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581453; cv=none; b=YuDlGXwzA82cn8d3yEvWorPw86yZDbGizUN7ufPHDHazHv98ICevZ2CxXLfZrYp65sQyj8/P/pWUQDt4TcISfdziw/e6/DAxN5OIbKPG+Om6V8/Ip/xvRyszL/Iz5b7blteNqnDICvgrshHCoVD8zwCAkZ0UsGsAd/ds6VSo9YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581453; c=relaxed/simple;
	bh=461oIRJVkOSJt+6eGbytBOWDsr7XKn7IVFk3W2GUS8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH0jAzVhUNt+LGw+BVvgAQ44oUg4l8dYz/abu/38v+8wqcWKCa2MjTd3ZWErHcw19hI4n9WBZkLpODxSikxRn55h10SxVqLrofNserO3jamYBFTiPFTurtSeAvpgjptk1lwc7QlDZ6Ep76hlChP/foAk6GjqEcjiTEM1mYHCetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ccfV/Pxn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=71ZafleQD+R3DGGFGHBFk5j/wGDiTmNRlBu2wjMI1mw=; b=ccfV/Pxnm9UqJ4evTg3LvRIA+B
	PLEOjwWamnsBFf2AZHiBSf/TXvtZZqqSgz1CYud/Jfb24NekQMjVzm/8qCM1ttfVccfdGjL6VpCP+
	39stLm3mrEC9JO1vxMvtJBymymfr477C4JUNgPojMFVZIuNff6aYHpwBzMFn+5vaNkNtuwCvtcihc
	Ko8ushlskuGT2ubOTllxaMvH9pxOB4LbClo/DuHdDiZZvLoZotLjb5YWS14LZK4up1FXdkh1YJmRm
	K0R9OIIOfwWlDH5EnSSUHlZGblY272b5P8s9gt6os+fHAYh2DYeedb+8KPkI7X7j6gLEtJQx/YZJ7
	p8T2IMWg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oT-000000095em-24z3;
	Sat, 20 Apr 2024 02:50:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 09/30] ext2: Remove call to folio_set_error()
Date: Sat, 20 Apr 2024 03:50:04 +0100
Message-ID: <20240420025029.2166544-10-willy@infradead.org>
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

Nobody checks this flag on ext2 folios, stop setting it.

Cc: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 4fb155b5a958..087457061c6e 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -175,7 +175,6 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
 			(unsigned long) le32_to_cpu(p->inode));
 	}
 fail:
-	folio_set_error(folio);
 	return false;
 }
 
-- 
2.43.0



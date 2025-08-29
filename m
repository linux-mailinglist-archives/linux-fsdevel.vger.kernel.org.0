Return-Path: <linux-fsdevel+bounces-59605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF9B3B10E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 04:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DD8582089
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 02:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F0221F1A;
	Fri, 29 Aug 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JTXNhEdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804B220F38;
	Fri, 29 Aug 2025 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435103; cv=none; b=rE+pQoC+4bXUxQQ3+UA04O6bS17EMz1t3aWWoifAnf5ePBSv7OBHkaSFZPYtnncATuXG3VQhiMHKuryFWdzRRLl0V0LOVBMxWTKcQX/+PjODB0IzVEdnoA+YWS9zFxXGo9LMHOHB1ua6eHwBpZYFoloMvIXdrL1cmWTOd2GpPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435103; c=relaxed/simple;
	bh=SjN+6EcV2aKbkzcRqM59YUnshXIavyNlU44EHZMZ3rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQqqPvyrcfa9MKp7/f+E428zUnOmucbl/Lw+EYU7b8ghf2mYKMngJYw+lr7xj1N+HHq7IqMtK4rroxIe0TyHRHkQDBkBR/nnYiXwVDRD9LRz9vfHe4SoHdazS77uRrbt2Jon2MALuzouGej/vFeA84ZiLYukuL7Zc3SNnFGY9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JTXNhEdj; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tx
	WJmcs6EY6YwMtBXrwL5dy322i8KuP+65w54IWqMZA=; b=JTXNhEdjq/K2VGcsWv
	sOXscMJS9RKKlK6ey0u8KR+h1sJl4Z47Hp0J9+/Z/vPtHKcjFvrWJYsGsj9pDwdL
	CESHWyNfo8OA5u/xB0gtAmlOQYkPGlM4/AUqRkc5qZXDchRpfg9cIhpaTKr+GqQI
	NIr1Gr5BCQEaWfwCnoSwQVG54=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAHFm5vErFoPaFJFA--.713S3;
	Fri, 29 Aug 2025 10:37:38 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 2/2] mpage: convert do_mpage_readpage() to return void type
Date: Fri, 29 Aug 2025 10:36:59 +0800
Message-ID: <20250829023659.688649-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829023659.688649-1-chizhiling@163.com>
References: <20250829023659.688649-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHFm5vErFoPaFJFA--.713S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF17ArykWr43Cr1fWFyrtFb_yoW8Aw15pF
	y8CF95uFsxJ3yagFyxJrs5Zr1fu3yfKFWUAFWrJ34av3W3XrsYkasrJas8Zr47tryrCa1k
	XrsFqry7Ja1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzYLkUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgBy4nWixCnPXNAAAs6

From: Chi Zhiling <chizhiling@kylinos.cn>

The return value of do_mpage_readpage() is arg->bio, which is already set
in the arg structure. Returning it again is redundant.

This patch changes the return type to void since the caller doesn't care
about the return value.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/mpage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index e4c11831f234..7dae5afc2b9e 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -148,7 +148,7 @@ struct mpage_readpage_args {
  * represent the validity of its disk mapping and to decide when to do the next
  * get_block() call.
  */
-static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
+static void do_mpage_readpage(struct mpage_readpage_args *args)
 {
 	struct folio *folio = args->folio;
 	struct inode *inode = folio->mapping->host;
@@ -305,7 +305,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	else
 		args->last_block_in_bio = first_block + blocks_per_folio - 1;
 out:
-	return args->bio;
+	return;
 
 confused:
 	if (args->bio)
@@ -368,7 +368,7 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 		prefetchw(&folio->flags);
 		args.folio = folio;
 		args.nr_pages = readahead_count(rac);
-		args.bio = do_mpage_readpage(&args);
+		do_mpage_readpage(&args);
 		/*
 		 * If read ahead failed synchronously, it may cause by removed
 		 * device, or some filesystem metadata error.
@@ -392,7 +392,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
 		.get_block = get_block,
 	};
 
-	args.bio = do_mpage_readpage(&args);
+	do_mpage_readpage(&args);
 	if (args.bio)
 		mpage_bio_submit_read(args.bio);
 	return 0;
-- 
2.43.0



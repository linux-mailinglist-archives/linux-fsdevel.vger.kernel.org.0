Return-Path: <linux-fsdevel+bounces-57464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B8B21F5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EC24260CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681062DC32F;
	Tue, 12 Aug 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HLScVlfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C411EA6F;
	Tue, 12 Aug 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983414; cv=none; b=AQyvjnlzf0ie3YU8y1T+jQ8iF6qEgBGqyRntYTy051GZe07GHGlm4bkVYkZH8s7hUZ6xch4Z/oeWnWRlIP9JoidCwSucg9QCXJE6WubDfgMyk1NojHrVfujmn1q5dhtArf76JSGmEr5GxT6nww7QfPu3Yp/gYkXVvO3YwlaTtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983414; c=relaxed/simple;
	bh=FFE6Ne18Gbj+9SQCya+6LnGwC3jVEx/5s2eYX1s0mJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtaoClxWPNuhPMIhxnR17uIstb3r7PwgaYmpeGdmuWX7+advB5Sh19fT1C1EZCmx/gqe9t1l7kcb6an1aKoBwV12FHRCC4bcBzupSNerX6vTi8unBJOuv2Bc3fGvJt7hDKsMAZqrmTJM9GykCnoR05s7pEzG8UCqhpzaIMTyiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HLScVlfq; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3W
	U889qCdNQb92vh6TByBQLFAnLxusGdo1gurJ2fGSg=; b=HLScVlfqHDX6yGgsZo
	wkJeK4EeYiH8pVlG2vviLmwzL+9vOxp0QnQcwufcI9oJhZubfjCHA6G47HpH/crv
	juy2XRZmtUKkBvYvGbT/uOdfoK4fr49LbcN7cTbBOVAAJxXDwgf8Y8fn3bRAx/wW
	6M4EosojQo6dsOju7ntgx0+Bc=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3RSPN65pon26ABQ--.34118S4;
	Tue, 12 Aug 2025 15:22:55 +0800 (CST)
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
Subject: [PATCH 3/3] mpage: convert do_mpage_readpage() to return int type
Date: Tue, 12 Aug 2025 15:22:25 +0800
Message-ID: <20250812072225.181798-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812072225.181798-1-chizhiling@163.com>
References: <20250812072225.181798-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3RSPN65pon26ABQ--.34118S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF17ArykWr43Ww1DuFy3urg_yoW8AFW8pF
	W8Ca4kuF43J3yagFyxJrs5Zr1S93ySgFWUAFW8J343Z3ZxJrsYkasrXas8ZF4xtr1rCa1k
	Xr4Iqry7Za1DWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwF4iUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBawKnnWia6QNKpwACsk

From: Chi Zhiling <chizhiling@kylinos.cn>

The return value of do_mpage_readpage() is arg->bio, which is already set
in the arg structure. Returning it again is redundant.

This patch changes the return type to int and always returns 0 since
the caller does not care about the return value.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/mpage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index a81a71de8f59..718c2c448947 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -148,7 +148,7 @@ struct mpage_readpage_args {
  * represent the validity of its disk mapping and to decide when to do the next
  * get_block() call.
  */
-static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
+static int do_mpage_readpage(struct mpage_readpage_args *args)
 {
 	struct folio *folio = args->folio;
 	struct inode *inode = folio->mapping->host;
@@ -297,7 +297,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	else
 		args->last_block_in_bio = first_block + blocks_per_folio - 1;
 out:
-	return args->bio;
+	return 0;
 
 confused:
 	if (args->bio)
@@ -360,7 +360,7 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 		prefetchw(&folio->flags);
 		args.folio = folio;
 		args.nr_pages = readahead_count(rac);
-		args.bio = do_mpage_readpage(&args);
+		do_mpage_readpage(&args);
 		if (!folio_test_locked(folio) &&
 		    !folio_test_uptodate(folio))
 			break;
@@ -381,7 +381,7 @@ int mpage_read_folio(struct folio *folio, get_block_t get_block)
 		.get_block = get_block,
 	};
 
-	args.bio = do_mpage_readpage(&args);
+	do_mpage_readpage(&args);
 	if (args.bio)
 		mpage_bio_submit_read(args.bio);
 	return 0;
-- 
2.43.0



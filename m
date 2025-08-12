Return-Path: <linux-fsdevel+bounces-57466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71752B21F67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ABC5027CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F872E11A5;
	Tue, 12 Aug 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LOji5XU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C782E091E;
	Tue, 12 Aug 2025 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983422; cv=none; b=dF+UJIq7RaUzXEurvK0tPAoPrIsAD+9ciyGLMu9yd4s7Tfzm2QhOuI2rxsgYJhQiWcarRGFoFsPm324nRjM1NPyidyrJWoENnZpspQbMGXT/4Y3+kqYK7HK0lmxjFULrK/r3jF1PDMUChUaLR/Q+nqJMa3HNYocBOqdy0+wwBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983422; c=relaxed/simple;
	bh=WcNaaM8QRc4Y8mmSQQ9NeysAFICGpnhIllrm6/E9Mys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHmpBK0VAY47IuyILjO3bRcTuX74TKWQc4HNxCn/erxb1c0OoMtMqjXH4jEMGUR9udwchqFgTAK1eIDvFZf+e/mnVPsO0E7A5q4ALSqdhhKkfhbJpaMdJOkc0/dbB9HaKW3y6itpA/cV+qIzKEnETzage9J+y788ho5t/Wa5aWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LOji5XU5; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Jj
	lLxLRI6fLwtv2iE/50RkS+dk+jF7EbPdI+ydJz3ow=; b=LOji5XU5lpsMoVqWbl
	tnY5dHtpSWHADwj/Dsif2UfS217Fus03rsVeg9km1bHa+99SrNMJROmiJbKr+ctN
	WVaSd/4rEsz6ucQ2Bh9TiTFg4qRl9+VgjdItSwZR7DQXV7LHnjGTaBSrp4P+awB2
	qxjWZlLGLiFG29DKS5+ZxXkUU=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wC3RSPN65pon26ABQ--.34118S2;
	Tue, 12 Aug 2025 15:22:54 +0800 (CST)
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
Subject: [PATCH 1/3] mpage: terminate read-ahead on read error
Date: Tue, 12 Aug 2025 15:22:23 +0800
Message-ID: <20250812072225.181798-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3RSPN65pon26ABQ--.34118S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4rCFWUWry3tr18Wr4DArb_yoW8Gr1fpF
	y0kFyvkFsrJrWfXayxJFsrAryfK39Fga15JF95J347Arn8JrsIkr9xKa4UZay2yrZ5X3ZY
	vw10vFy2qa1UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUnYwUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBawKnnWia6QNKpwAAsm

From: Chi Zhiling <chizhiling@kylinos.cn>

For exFAT filesystems with 4MB read_ahead_size, removing the storage device
during read operations can delay EIO error reporting by several minutes.
This occurs because the read-ahead implementation in mpage doesn't handle
errors.

Another reason for the delay is that the filesystem requires metadata to
issue file read request. When the storage device is removed, the metadata
buffers are invalidated, causing mpage to repeatedly attempt to fetch
metadata during each get_block call.

The original purpose of this patch is terminate read ahead when we fail
to get metadata, to make the patch more generic, implement it by checking
folio status, instead of checking the return of get_block().

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/mpage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/mpage.c b/fs/mpage.c
index c5fd821fd30e..b6510b8dfa2b 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -369,6 +369,9 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 		args.folio = folio;
 		args.nr_pages = readahead_count(rac);
 		args.bio = do_mpage_readpage(&args);
+		if (!folio_test_locked(folio) &&
+		    !folio_test_uptodate(folio))
+			break;
 	}
 	if (args.bio)
 		mpage_bio_submit_read(args.bio);
-- 
2.43.0



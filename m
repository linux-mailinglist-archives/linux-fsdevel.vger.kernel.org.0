Return-Path: <linux-fsdevel+bounces-55796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E1BB0EF9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00556562672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F828C033;
	Wed, 23 Jul 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I3IAC7VJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2D28AB11;
	Wed, 23 Jul 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265984; cv=none; b=SKV2MRajUl05FYkLH8ZEEhgQPTvehEMK2E3Lgd9DU5J+i06y1UVsBstuLZRqu4Ky/VSGuyU4W/KuDEq6/BAW9fCgMD6kJYB9+iOq4/sOGFdjA4p3ZAqT0Lp6hWMyTuupmolzpMYNgrkgzsbOjisbZMsILmM4D2iKvVqLhWCYEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265984; c=relaxed/simple;
	bh=mVk6YAJNCEdJ6dCLMELI7wVK0LYKojOzCIfcxOpsa5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvZmptMYsi0w8Ruoeuzs+vZe3TQRwd2faUtkLQxZ2RRer0KtnZasOYa8Ttj4w2rR8f951oVjKthVWV3z8N8cXMSfLeax+MJwzNIStDIHkHkAQVrZxv2CEpv9qA59CHy+ssWwoq4rTD27ewYDYFRFWgwbMwt+rPm+CW9NIy2B4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I3IAC7VJ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gx
	RTtoCdCaL68C/uZpXKvMr8wgXODWBtugFbqWI2Ch4=; b=I3IAC7VJteG4IFIgIK
	BbY2o2VburamF74x7I3g/AUUKauYeZRSgA1ITpIJKT/1jkDJwa7u6b76QjzPe808
	pgWZeBgeNKHLEH9W+8MPhKxSbN8iB4tItvW4DUuOCqGhXqP27j+1JUikTAf/nxUf
	bxW1lmxCaXuOpbk74m3hKLYg4=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXpNEAt4BoaJF8HA--.11729S5;
	Wed, 23 Jul 2025 18:18:41 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 3/3] mm/filemap: Skip non-uptodate folio when folios are available
Date: Wed, 23 Jul 2025 18:18:25 +0800
Message-ID: <20250723101825.607184-4-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723101825.607184-1-chizhiling@163.com>
References: <20250723101825.607184-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXpNEAt4BoaJF8HA--.11729S5
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF4xtrWUXF15CryUZFyxZrb_yoW8Jr4Upr
	WrKa4kKFZ7XFy5JFs7J3Z7XF1fWa97Aay5CF9xKa4UZFn8XF9IgF1ftFyUGa18JFWrKF4I
	qw1vyFyUXFWUXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdUUUUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgAWTnWiAsAucXwAAsb

From: Chi Zhiling <chizhiling@kylinos.cn>

This optimization primarily targets read operations that trigger multiple
IOs, aiming to complete the copy from cache to user buffer as quickly as
possible after the final IO completes.

This patch achieves the goal by minimizing the number of folios left for
the final copy loop.

In filemap_get_pages(), when encountering a non-uptodate folio while the
fbatch already contains folios, we skip waiting for the non-uptodate folio
and proceed to copy the available folios.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 350080f579ef..894584a5bff5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2625,13 +2625,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 	if (!folio_test_uptodate(folio)) {
-		bool no_wait = false;
-
-		if ((iocb->ki_flags & IOCB_WAITQ) &&
-		    folio_batch_count(fbatch) > 1)
-			no_wait = true;
 		err = filemap_update_page(iocb, mapping, count, folio,
-					  need_uptodate, no_wait);
+					  need_uptodate,
+					  folio_batch_count(fbatch) > 1);
 		if (err)
 			goto err;
 	}
-- 
2.43.0



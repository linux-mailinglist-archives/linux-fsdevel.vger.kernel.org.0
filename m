Return-Path: <linux-fsdevel+bounces-56121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9044B136D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFB9175FB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 08:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA0225795;
	Mon, 28 Jul 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S8+76Hp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DE2AE68;
	Mon, 28 Jul 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692030; cv=none; b=I9U+8K3bmA7flyAuo6vAkeEqhXOWC7cOpLQ0bEA3rQT9nrddkBqSLJB4q0D/QBhA16dhxP64esfyXrQExP6TMRoBJrrvzhHzmturkHNzMFqvVzuSL9oi1EqUuKzfChj6CUDvRCM/eQ/0fq/krCxSEWAFZkFXLtnZ3fJlCk7/aHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692030; c=relaxed/simple;
	bh=8HXJmQ/04NJvw6kus97NYmIgyj/MJ6DycDjPq7oVA2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kb6mHmOViecyUxjpwZ4EjiuoHusFyA9k+5cPiwesto+ZxhQZXCdgltuK/7U7sWVJvFXSXSIP3ZbJyo2wk7+0UtTs95ikV6qyrbEJJkRSf3Vhx0qxFJEcmeNxJe2t01OfV90lm8hHmClXJwEJkhc57oBTjASFUaGd2Yl5A24Crrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S8+76Hp8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zk
	iIDNJ189UN3Gvigro6HmhFmr3/xqt0rx4GudPl97g=; b=S8+76Hp8/WS9fIVESB
	XjqzjYH3q5dvVgttmr85KXXmZkxQv/Fc7tP6X/PEQclJaJW1leuYolTz4fzc3QGh
	I9O54yDiJP9u6z0xuvBlBMMBl+L556ix+mYS6KtqPknJ2qUUuZGHKNtKc6OY80u0
	FY1gdO3Ye056LnWIzNN/offTU=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAH9a9hN4doAzUWCQ--.8415S4;
	Mon, 28 Jul 2025 16:40:03 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 2/2] mm/filemap: Skip non-uptodate folio if there are available folios
Date: Mon, 28 Jul 2025 16:39:52 +0800
Message-ID: <20250728083952.75518-3-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728083952.75518-1-chizhiling@163.com>
References: <20250728083952.75518-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAH9a9hN4doAzUWCQ--.8415S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy8WrWDCry7uw4fZry3twb_yoW8Zw1kpF
	WagwnF93srXFy8Can7AwnruF4Ig39Yyay5Gry5KF95Awn8X3sa9ryIvF15t3W7AryrZr1I
	qr1Fy340vanYv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDtxfUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBgBSYnWiHLinmMQAAsu

From: Chi Zhiling <chizhiling@kylinos.cn>

When reading data exceeding the maximum IO size, the operation is split
into multiple IO requests, but the data isn't immediately copied to
userspace after each IO completion.

For example, when reading 2560k data from a device with 1280k maximum IO
size, the following sequence occurs:

1. read 1280k
2. copy 41 pages and issue read ahead for next 1280k
3. copy 31 pages to user buffer
4. wait the next 1280k
5. copy 8 pages to user buffer
6. copy 20 folios(64k) to user buffer

The 8 pages in step 5 are copied after the second 1280k completes(step 4)
due to waiting for a non-uptodate folio in filemap_update_page.
We can copy the 8 pages before the second 1280k completes(step 4) to
reduce the latency of this read operation.

After applying the patch, these 8 pages will be copied before the next IO
completes:

1. read 1280k
2. copy 41 pages and issue read ahead for next 1280k
3. copy 31 pages to user buffer
4. copy 8 pages to user buffer
5. wait the next 1280k
6. copy 20 folios(64k) to user buffer

This patch drops a setting of IOCB_NOWAIT for AIO, which is fine because
filemap_read will set it again for AIO.

The final solution provided by Matthew Wilcox:
Link: https://lore.kernel.org/linux-fsdevel/aIDy076Sxt544qja@casper.infradead.org/

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/filemap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 00c30f7f7dc3..d2e07184b281 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2623,9 +2623,10 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 			goto err;
 	}
 	if (!folio_test_uptodate(folio)) {
-		if ((iocb->ki_flags & IOCB_WAITQ) &&
-		    folio_batch_count(fbatch) > 1)
-			iocb->ki_flags |= IOCB_NOWAIT;
+		if (folio_batch_count(fbatch) > 1) {
+			err = -EAGAIN;
+			goto err;
+		}
 		err = filemap_update_page(iocb, mapping, count, folio,
 					  need_uptodate);
 		if (err)
-- 
2.43.0



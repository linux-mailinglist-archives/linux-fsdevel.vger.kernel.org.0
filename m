Return-Path: <linux-fsdevel+bounces-55798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6772B0EFA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580FA1C841D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95F28CF56;
	Wed, 23 Jul 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JXdiRJ8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674E288CA2;
	Wed, 23 Jul 2025 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265995; cv=none; b=a8wnJfee6iVG4LtppUK9PGL4olbuVyx/BLWLAur2U10S5hElbWQ1j4hCexgLje7twEe8XUcpY4PgWcQPTC9ppEUmV0fSBtH2avNUTAqPCPX3lyE5ZKP7m095Osz0bXsTobmiTDYBkfWeh2DiuUY4WSIrp6plJuxvVR1dtKQi4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265995; c=relaxed/simple;
	bh=UXbh+JPcmcBwTEOwUyEcAiHBeT0XK+kOA7qc/I797rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oQxB9df/gAB3lnrb7bgS09IqvCgzGC1QIkm23czz7EtORhCjJ0dlnrP9zi8Qq3bR1sYPQjHacw4Ium1U2h6SC7BObwLlgIepbeHWfSgi3vBckbRVjfqo9FgCOimNFsW/VUa4QyPu2Oa0ww37TEdBGJihshTNIDHButbt7G+37XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JXdiRJ8J; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=K8
	kZ7QCjEfRrt0lfLWJjwn+cjK4ybC+tSjT9DjTb4Jw=; b=JXdiRJ8JWKBv41Ounv
	39syKmBUX6JIRdgm5Mox3ZlJeIfkpQmIgQcN3YqgqRT45bAps3qAgbbEU78JAkk6
	TwgUMkWjLISl5B9+rurjghNypLgW8jLkI0O7ek3Uf6+1ieWdN7m0ofKQWSH/2SDc
	IZFFeepb/J2T8gVBAjy5XRMIQ=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXpNEAt4BoaJF8HA--.11729S2;
	Wed, 23 Jul 2025 18:18:40 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 0/3] Tiny optimization for large read operations
Date: Wed, 23 Jul 2025 18:18:22 +0800
Message-ID: <20250723101825.607184-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXpNEAt4BoaJF8HA--.11729S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww48AFyDKFy7ur13Cr1Dtrb_yoW8GryxpF
	W3KwnIkwnrtry7CFn0ywnxCrWfWrZ3AF45G398tF1fAwn8XF92gry0vF15Kry7Gr1Uur1I
	qr48Ary8G3ZYv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8HUDUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFBWTnWiAtsIFNQAAsj

From: Chi Zhiling <chizhiling@kylinos.cn>

Fine-Tuned Optimization for Large IO Read Operations

When reading data exceeding the maximum IO size, the operation is split into multiple IO requests, but the data isn't immediately copied to user space after IO completion. 
For example, when reading 2560k data from a device with 1280k maximum IO size, the following sequence occurs:

1. read 1280k
2. copy 31 pages to user buffer
3. copy 10 pages and issue read ahead for next 1280k
4. copy 31 pages to user buffer
5. wait the next 1280k
6. copy 8 pages to user buffer
7. copy 20 folios(64k) to user buffer

The 8 pages in step 6 are copied after the second 1280k completes due to waiting for non-uptodate folio in filemap_update_page.
After applying the patch, these 8 pages will be copied before the next IO completes:

1. read 1280k
2. copy 31 pages to user buffer
3. copy 10 pages and issue read ahead for next 1280k
4. copy 31 pages to user buffer
5. copy 8 pages to user buffer
6. wait the next 1280k
7. copy 20 folios(64k) to user buffer

Chi Zhiling (3):
  mm/filemap: Do not use is_partially_uptodate for entire folio
  mm/filemap: Avoid modifying iocb->ki_flags for AIO in
    filemap_get_pages()
  mm/filemap: Skip non-uptodate folio when folios are available

 mm/filemap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.43.0



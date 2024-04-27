Return-Path: <linux-fsdevel+bounces-17982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC118B483F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4D01C214D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E017D145B37;
	Sat, 27 Apr 2024 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ro7FcQrR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD0A94A;
	Sat, 27 Apr 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252319; cv=none; b=D5mLVaf1+ZcFQVxt/l+4AEGz1HkbXjRU8sODfAFwg3tUZ4wk+zPaR0EAw+WHt4RsCU1ck3KINSnpVR7k9Sy8b85ezj4FQC+xV+If84L2G8OWYt1gjsHUKLqQuufcfldjlT+EbHO6VLCr6zqpnc67Q0xBj37XdOJC0WNAu+0z8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252319; c=relaxed/simple;
	bh=QgGwImN6jpVG+wtsSYEOgvYeCii6ig8WxuUbcd20cWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbhuVCxuKePFGmmYuKlaek/LixjIa22YByjd+uvFrnIXVelh8QIMu+5RoXH4hj4HWjdkBnvvZ/pcqcTG4UF1mkHLHETmwF1bUUmJM3vj41++zN6haPWwxgOo+oduRaLv9rMYSezWp1glk8sY8vMOBojH9q7s8ms6fVJ8YJkZ7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ro7FcQrR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2lMOQ0YycRNGTONn7yZIj4k2x5DO9aZnEg8nbgmrNB8=; b=Ro7FcQrRMFIfEuK3esHGPFOWTz
	3xywmrs95JpCnzXaAHOtHR01ffxcAPoRrV6IAdErreTcdgXiFU8cJNrZiXKv7VkXJ7bmOnP2jwMl+
	27yPhgHxWoWunqMOUkKNeOQbzfqghWYndy7n+eznD1U0kgv8w+hp9StzOGp0EdRWP/L9h8ADRxyNV
	9F1xa4lofryKjcaRFJj14vaiboq4dfUS7uh8IX42x9IkLby5takqvpblCqXFOGDvEY33zgFnIl62t
	KpLUTBiFot+t1LJFqNGCL7LBkxk+JKGlNt0rRIRn9H3qOWwRe6SeqYuDy8dx/2kwb2Lsuw/eFXcb+
	HQ5veOcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pKu-006H7i-0s;
	Sat, 27 Apr 2024 21:11:56 +0000
Date: Sat, 27 Apr 2024 22:11:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/7] swsusp: don't bother with setting block size
Message-ID: <20240427211156.GE1495312@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427210920.GR2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

same as with the swap...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/power/swap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2db1..d9abb7ab031d 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -368,11 +368,7 @@ static int swsusp_swap_check(void)
 	if (IS_ERR(hib_resume_bdev_file))
 		return PTR_ERR(hib_resume_bdev_file);
 
-	res = set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
-	if (res < 0)
-		fput(hib_resume_bdev_file);
-
-	return res;
+	return 0;
 }
 
 /**
@@ -1574,7 +1570,6 @@ int swsusp_check(bool exclusive)
 	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
 				BLK_OPEN_READ, holder, NULL);
 	if (!IS_ERR(hib_resume_bdev_file)) {
-		set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
 		clear_page(swsusp_header);
 		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
 					swsusp_header, NULL);
-- 
2.39.2



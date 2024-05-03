Return-Path: <linux-fsdevel+bounces-18572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1918BA5FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9271C21BC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4046441;
	Fri,  3 May 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BVW7uS5v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398E224D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709865; cv=none; b=E97hkkmU/4QSB1IJJeNPdWuKNruOKH7A3EZInef4CZmmaEzL+rSS0fRi/VtZTW5LIAGLo4hrI1MtnXycKeDvGaaWCStuGzWS5ynLlljeO6tdWScwzq6fNFM17Y9WOyeWUETnXS/4fh1L2Jbh6VNAn4VGovaB5AK5kPAIN0oTBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709865; c=relaxed/simple;
	bh=coQnFaUQk+YonHP9VZcg1wZRWOXon1n6rf16Uoitesw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6ObLVGpeQu94OGQwF01SDXLkGxsVcayBwmmwQfSFaF2C/7wyWmIurHwOVzhrzyyL8OxYihXdnSIb4Tko0TkJ7BGMBPsf9dWlEONh+CDfkU5LVWaZThtGiYIf6xAuoh+Qqb33xZvIZalfTNCkw8iGNm3uP7WS+I8pXpKMpxOIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BVW7uS5v; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=cwCXl7bDNgEK3wEeB1dHuYl82HeOEvaS0e413hiuNX4=; b=BVW7uS5v7QMpANiANKlUuAYqAm
	rgqcM0gwIqE+GrIBPxEYRmjM2QH0SSMngySWrb7O1jM1+fHMQX1k/jcVrS0yCmYTJ2GUnkTWw4qGe
	sdzhrws/Ac64tQVvdvh28aqPiO2gLdQUjIcxj7pESEer6goNa8KmzsG9gyCadkPvSGDXLIxpvF/EQ
	Dhiff2jClTHW/dUqkGFn6fw9lEoRdRuiv7yIZUlWocasZnJtqrYK/Ay+EbakopKXjRtFkSy8m9Hh3
	aM5Z4X4VEo98pMxbKOoY3Zo8of6ihExSLURxWjemwivtRKEsWLvQ9TaSpSt/nrApirWprM4vsywE0
	4SXcfQUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMf-00A5VQ-1A
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/9] swsusp: don't bother with setting block size
Date: Fri,  3 May 2024 05:17:37 +0100
Message-Id: <20240503041740.2404425-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

same as with the swap...

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
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



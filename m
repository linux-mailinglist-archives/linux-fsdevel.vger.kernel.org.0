Return-Path: <linux-fsdevel+bounces-40853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A782FA27F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255023A54B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDFD21D581;
	Tue,  4 Feb 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y7kbPbrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089521C182;
	Tue,  4 Feb 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710736; cv=none; b=Dw9r7lRlhzqZ4kT/8YfOGj5d1we8ddfJqB/S3EateJg0BdBlnBqAdEWWXbfD4futlvFk1GhJZvghesi1GR/7XLUTK8WOJpq9hWlKIKIa/DMfU7vKAUPWJCFZKZGgy9pQkY3oE8awuHIaFh7dHjcoQMI1sSA5z4utvi2Dnar7MGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710736; c=relaxed/simple;
	bh=HbYBj5rAZfZP5YdThJ5y7bQrat0JXHXg5QPwfqhiCLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuM4D5LgEzs7YK08a9od2he8VNfPJ10Of6AQl1Zt8ll/8Zl4KYk/CUAJuwtg8wqGF7IS8NbTHRY7ChhJHAKEMxdelLsqSswMTvb6hQxmQdkLpgePAGREMTYOUWr5AsdJxVd2vDec082ZwXkkCQnb03zPFlczFXYh4ZWDGdcX4n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y7kbPbrZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BqAmEHN/NB4fRpClNavDgsxh4n8ElEwRbJC+1e1GTe8=; b=Y7kbPbrZWUV0UxwwKcM89Dh4Cv
	4dxa4VsxyQWeZvEu4hKO19mk9Oahn1gL/beoB8rGrrXjF6u0/dChAjDktCPfvzCpmcH4tRI8pz9MG
	A3Y2ewRHNTTYqRWySxth22/RQPFoYLru4nRX05nafsuR7gb19uX8vZLDt0wZsslpTJi7N/SKPgiyL
	Os4lK9jtkE6l8Ai4GI0oZfoXiZPFY4MbnfNhlsT1hHbSp0reE/ZrsEY3yWe85OVnH9RX0IhEg9wVW
	bVkvsCsUGGXielAB07u++sxl65h/dSO9scBeUGQQn1NgEqw4rgbP0GvNTnctfEc9KpiGA85cCl8ll
	ymPxZ9Yg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfS5T-00000001nhW-1oc0;
	Tue, 04 Feb 2025 23:12:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@suse.de,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org,
	kbusch@kernel.org
Cc: john.g.garry@oracle.com,
	hch@lst.de,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH v2 6/8] block/bdev: enable large folio support for large logical block sizes
Date: Tue,  4 Feb 2025 15:12:07 -0800
Message-ID: <20250204231209.429356-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204231209.429356-1-mcgrof@kernel.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Hannes Reinecke <hare@suse.de>

Call mapping_set_folio_min_order() when modifying the logical block
size to ensure folios are allocated with the correct size.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 9d73a8fbf7f9..8aadf1f23cb4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -148,6 +148,8 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	BD_INODE(bdev)->i_blkbits = blksize_bits(bsize);
+	mapping_set_folio_min_order(BD_INODE(bdev)->i_mapping,
+				    get_order(bsize));
 }
 
 int set_blocksize(struct file *file, int size)
@@ -169,6 +171,7 @@ int set_blocksize(struct file *file, int size)
 	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		inode->i_blkbits = blksize_bits(size);
+		mapping_set_folio_min_order(inode->i_mapping, get_order(size));
 		kill_bdev(bdev);
 	}
 	return 0;
-- 
2.45.2



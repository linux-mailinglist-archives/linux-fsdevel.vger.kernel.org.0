Return-Path: <linux-fsdevel+bounces-46965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DBA96E8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9ED7A798C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1028F514;
	Tue, 22 Apr 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ThnTKNus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101828A3E1;
	Tue, 22 Apr 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332025; cv=none; b=AGNYy1aGnA+mQ4OeFG7DG0ymOXM5s77Gqwx6S76mNsw4+uphrv3mzEglExE9yZX8uyocXiFLivNq7DwuB/Zjj4MyXouCU6hS33EI8bzhgtID7yFAvqPxhEJZ74byf7aADFmQQLRVNqCFV0G8hFtYeY80TPBOgwAhU4Wki5U1mPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332025; c=relaxed/simple;
	bh=zq1qrmpYbLgKUkYgCG9zVOJVt9tX13jTqs9QBBG/nPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4mn1fJXA54GoT/ByGqkjZpYu68n0/Wsj/PTpapxDnsQk/3LmMQ1Spfz5Ro+AA6pagscMhRZUoqbYUY30R1t+HquyOc5Qf9jEtCgIoR/j0j49R9DnBM1Y1E8DRCpyzyHCcs2yXPEx9hArYgPSthqy5YHosZeAyo1PkW6cTWCYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ThnTKNus; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KOHBjBp2yFBDWD9IbZ7zQcyzhgkzqclmileo7Zy0jQs=; b=ThnTKNusnUkKoCLTRFK3A2DJSb
	TETiTT4Jkltc/7ii0w8nx6EYAIkF8uVdKG/Rxlq9CqOayPUXy7sTzG7QMApTpBe9fjM1AqnFtxvuH
	pRsTU/LduId8JLn9HPU/guMWsHPlY57UiIwyXy6dXPQPzV68eP+PcBFT4RBV5BmKRJseJtHJOgp0C
	+c2lEyZx0y6evXX7kx4s/6RvTtq4PyCz92uPp7pPOgR1KJwaLuo3aAiof60E5TzAcptqcTTymSv6V
	AsJ8WYcuH2dZU6uKSPFfcbaXbEDauaTXT3avgJpsASCd+uM4ZhCZNmNK23qHWvSNu+mQnpcLZGv2V
	YBUawAvA==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EaV-00000007UJj-228l;
	Tue, 22 Apr 2025 14:27:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 08/17] dm-bufio: use bio_add_virt_nofail
Date: Tue, 22 Apr 2025 16:26:09 +0200
Message-ID: <20250422142628.1553523-9-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250422142628.1553523-1-hch@lst.de>
References: <20250422142628.1553523-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
bio_add_virt_nofail helper implementing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-bufio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 9c8ed65cd87e..e82cd5dc83ce 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1362,7 +1362,7 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 	ptr = (char *)b->data + offset;
 	len = n_sectors << SECTOR_SHIFT;
 
-	__bio_add_page(bio, virt_to_page(ptr), len, offset_in_page(ptr));
+	bio_add_virt_nofail(bio, ptr, len);
 
 	submit_bio(bio);
 }
-- 
2.47.2



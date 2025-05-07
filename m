Return-Path: <linux-fsdevel+bounces-48361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0FAADE20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7C3A6A74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E04525EF81;
	Wed,  7 May 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jKHJgBMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2A258CD7;
	Wed,  7 May 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619507; cv=none; b=XBmzKiu3d8IFcUUxyZx6oEfXeg/ZQ+AyOQ9hdr41xGXvEWvj1+MqJ/1xzNPkRG2wzq9skKpon9MayTDTYyxP4q3zyKG3Zs6D1KGx+KvSfMSm5p/ipCS5meVdcHSXdLjO6urD+ts1AguOoubCWPF6FlEo5ahKJigQjPtTW0MrLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619507; c=relaxed/simple;
	bh=LIwVvsfhCD5A+zpTbLGLzftcnMsQEUaaqSXuanuE92g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1LcqIak8AxLMw2F36GCuy+JdnRCRKXUpYV5R+nmVGy+QixnL0gLzwd6cBKuwoZqgAfqtAo8V1Rm2IqP2sy6tB3O7FeAikYgXDP7aZ3UwbPbJn719XfEPvcxd8YpOun89eCF/VvgHdKL/tXJJi1IwgYZb39zDKnnxt12YkiQ5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jKHJgBMS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+RjHjXdFg6j13osjk85DxtL45k3o2KmsTjwsU5RWPK4=; b=jKHJgBMS7JSXNyyI9KxlGFGFNw
	CxMaeF6pez00wsCepJNJYONSbFNEXMANN6UaIXMWNnF1sZdC1RqEa9nws37zLatghC+SVax3KG5+L
	Aj31Suz62omHWREz6ht5j8TAd7sWUDGQz+Jq/9LaN9a/FqO2H4B6h506fI1Yll30QCrEsc35PfxTe
	WQ5tLKYTiZkcGcdGu6q6mWuMWqa5uRHxWDqql2RiF/Cy3XDDFSM1HkJc3tXi6fJJgKnZOXPoRALQZ
	cGHdD8iEnidT0gL8BHmlqPjZZyJXm/VdwNJYATIM5D0Lsw5JV1TE67fWQvNYcnhcO6JyxHHEvEKkX
	ihGFRshA==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWL-0000000FJ5H-0HAA;
	Wed, 07 May 2025 12:05:05 +0000
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
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/19] block: add a bio_add_max_vecs helper
Date: Wed,  7 May 2025 14:04:27 +0200
Message-ID: <20250507120451.4000627-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507120451.4000627-1-hch@lst.de>
References: <20250507120451.4000627-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to check how many bio_vecs are needed to add a kernel
virtual address range to a bio, accounting for the always contiguous
direct mapping and vmalloc mappings that usually need a bio_vec
per page sized chunk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ad54e6af20dc..128b1c6ca648 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -418,6 +418,21 @@ void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off);
 void bio_add_virt_nofail(struct bio *bio, void *vaddr, unsigned len);
 
+/**
+ * bio_add_max_vecs - number of bio_vecs needed to add data to a bio
+ * @kaddr: kernel virtual address to add
+ * @len: length in bytes to add
+ *
+ * Calculate how many bio_vecs need to be allocated to add the kernel virtual
+ * address range in [@kaddr:@len] in the worse case.
+ */
+static inline unsigned int bio_add_max_vecs(void *kaddr, unsigned int len)
+{
+	if (is_vmalloc_addr(kaddr))
+		return DIV_ROUND_UP(offset_in_page(kaddr) + len, PAGE_SIZE);
+	return 1;
+}
+
 int submit_bio_wait(struct bio *bio);
 int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
-- 
2.47.2



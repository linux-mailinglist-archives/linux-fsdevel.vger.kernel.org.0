Return-Path: <linux-fsdevel+bounces-47774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E70CAA56F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AAD504262
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3AB2D86B4;
	Wed, 30 Apr 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FdjI/W/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886B2D1116;
	Wed, 30 Apr 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048149; cv=none; b=AIhF/ymF5VgHajlVJlxbq0VS/ubKOtvBBeFP1Sk1iwfF2C0YeU2sUfBkN+BoBkjwfR+fwUvGUobp9ln9uHrC6shl8Wm8FLUc680wtcwfiFlns7knLA8oFHFOdEw3k2nUqjVokvMuk0awf+ZdU40fdZOpdt5N7r6mF7zV8q9TCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048149; c=relaxed/simple;
	bh=TJl2I95NFOuYgUamM0YBAXXsGJOnBB5UV/kxuVfusic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7mbnWxTFdy+/j3P3P0hd7XEQ9dOi17bfXi7N0cwzG3W4AX650pQ1mjc/ZwiIJomLKhhjcUpwtGzQCQEPkuvCppy7C6VewMIcKI2FW+20l4Gi7DAe5UaZ77M2nWVLrlHQ8Ux/5NrPqg8RGuvhjAcIg4YevYvQ9yKz7on7Uja/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FdjI/W/d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B/8McNCwBO1O6ZzRLryGsHc7hjRg0cD2+DZ6Cs57sr4=; b=FdjI/W/dpx18pzU15gp4Xnc2ZU
	xMkw/fOzQaVbiPwDQciGICLAeUrnM1/NwzeQdbjx/DP9slaM0CseK0oJ3fLrh3a3QmxLpRI4DogYj
	rkmQeEgXwqv2KP2NAswNUrUHQkijUpDWYMb0DjaP9ouRgEixOSZrgf09NTCv3qBAuPK3IkipuFGc5
	HsECkub2okU4BwOKO/NnT8Iri6iaXWk5+LBGN2g5/SYiQW84UHIwfyejpxNYl6wUfTkxdAWTJU5du
	AtAntI6318hzgWOm9tWr14+zjwcrF76RsBGO1LnUHKZXTEaABEWsJIs6hc78dDI3zdchY0GRcZZvb
	OnyrWjcQ==;
Received: from [206.0.71.65] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAEss-0000000E2au-3WPF;
	Wed, 30 Apr 2025 21:22:27 +0000
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
Subject: [PATCH 09/19] rnbd-srv: use bio_add_virt_nofail
Date: Wed, 30 Apr 2025 16:21:39 -0500
Message-ID: <20250430212159.2865803-10-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430212159.2865803-1-hch@lst.de>
References: <20250430212159.2865803-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use the bio_add_virt_nofail to add a single kernel virtual address
to a bio as that can't fail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/rnbd/rnbd-srv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 2ee6e9bd4e28..2df8941a6b14 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -147,12 +147,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 
 	bio = bio_alloc(file_bdev(sess_dev->bdev_file), 1,
 			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
-	if (bio_add_page(bio, virt_to_page(data), datalen,
-			offset_in_page(data)) != datalen) {
-		rnbd_srv_err_rl(sess_dev, "Failed to map data to bio\n");
-		err = -EINVAL;
-		goto bio_put;
-	}
+	bio_add_virt_nofail(bio, data, datalen);
 
 	bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
 	if (bio_has_data(bio) &&
-- 
2.47.2



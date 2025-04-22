Return-Path: <linux-fsdevel+bounces-46967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2280A96EAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5741844205B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FC328F953;
	Tue, 22 Apr 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FhjOxORn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2119284B2F;
	Tue, 22 Apr 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332034; cv=none; b=TEG6k4OF19O4EtQQEpFRdvZv2TXEncm4maADSEe7CAnfhRc91RIoUhjs2BYQoyGSIvzIESN05E/wbcehuEDLghK5c1HeonoB0ruEjgsDo4M+CZUglGdBjIvFJn9Kyd4D/tXon490H89d1BM5i38c0zfSVOmqWLg2RRun+gtjEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332034; c=relaxed/simple;
	bh=tB9+x91JjsByZO2Xg9WmTjl0vbk0ieLTJ6U2ahTMuQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd6pDB36YshODdiYQsLn7RfDbHRM0z6PfxaNlZEDztvWkW85stGjBC+beo3MhmJqWVEVZCfEO1VD2BfSticdbxd+35y1BDBYquSCo/ATTth8H2nLUtCNjTxi2mZjAkNUq+bQuOwwYwXoXAmyVO21CubnAGtgjybxp3Cvug1Z9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FhjOxORn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NplwTltyvxxLvVdYmzv3Og3jFMuEd4OfvUJNfDjxyXU=; b=FhjOxORnf6HPfD/JhjHg+DEpc+
	btH0yMaVKCeXdq9hVxcfxNVdQGYaS2nXR+2YgXqSA8sOhsJmxrK44DIha/SFMch8um0Ubmz2VCN+D
	eSH/pZ+a7IAfTMDMp1uLwDoDlavcIuJGvKYE0PjRDG9siQCx9Gf3kMBn1NshJmu0nsHTMbGcT1ZKP
	sf9oI9sftcYgdyeS+QGz0Ab1QDW2UAYa/GOLco9cnyGWvWPAg7zhlrGbP9ul0BydHI3Rt5RK8MQNc
	k75WwcWzwkNadoqnxQnXOVTDQUr5SKsalpM+mDkL5f2MY/0B/zgEsVlZAlGdmqovJtKUiNHZtBGG9
	XPQp1N0Q==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Ead-00000007UMj-2Cfv;
	Tue, 22 Apr 2025 14:27:12 +0000
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
Subject: [PATCH 10/17] rnbd-srv: use bio_add_virt_nofail
Date: Tue, 22 Apr 2025 16:26:11 +0200
Message-ID: <20250422142628.1553523-11-hch@lst.de>
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

Use the bio_add_virt_nofail to add a single kernel virtual address
to a bio as that can't fail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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



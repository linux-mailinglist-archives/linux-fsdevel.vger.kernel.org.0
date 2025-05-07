Return-Path: <linux-fsdevel+bounces-48367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A609EAADE4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B267F9A5FBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9E2641E8;
	Wed,  7 May 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/ajwSbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527D259CAE;
	Wed,  7 May 2025 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619523; cv=none; b=KYgnvCEb4HDFPms9AW6P3aUiu9B98YI/vckRfYfrt5e0E+05sOjgHyfs20lmcyC0nuKrz3sqF+L2n4P3fMFC0sSK4s8Ni2MuuJrFYdoEuPh31Sm0R6H23WmlrFdlF6cVEOle2pAJVXMdQ/fveCey8rDYEfwCPJYyMTRVsjF2Lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619523; c=relaxed/simple;
	bh=TJl2I95NFOuYgUamM0YBAXXsGJOnBB5UV/kxuVfusic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKB+PTSV5hlAxkOsYes2Vlmi2pQZUdpavvs4xoXV9XTFMlCJtjGh66eGjy5wn+FKZNpyyIoRDEzz+mhAJA4AYNhLzIjq06g1M2Ey9KF3dO3gAaI88NvdcIJeAZI8bCJP6Fg45Cj4jk/6YqIYrL6V3jORlkTliIBLqAo13lOfdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u/ajwSbZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B/8McNCwBO1O6ZzRLryGsHc7hjRg0cD2+DZ6Cs57sr4=; b=u/ajwSbZ8nBBOHpgh+zfvgVXmO
	iZIb8LdKrR0mE5H4Liz81wGdFSG6zWi6xmceXk5errke93bpP9PJjvU1pIjb/LQkG3fsdGaqaxw4/
	kuIhMYJcA+BBLahEzxwgO6LH50bq2F7BZjm5/feVFkomGiG+hmlD0SzVv0TPnFEnma6SsClVdSujC
	ariDnpYZkW+RRF7GJP2ve2wQ65QEtP9sNhRRvUoMq4Qq5YmiXfiOuw/7MBpd/yvsB93vWZIy8HJAs
	m1vYkkzIGX/Ffplo8T8LsrKaCMuVnxDAwHREl4nxZMqr9f96ffdRxRDbuhMzZf+qwrrgFpug3oQJ2
	Z6UMEiQg==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdWb-0000000FJ9o-0NCj;
	Wed, 07 May 2025 12:05:21 +0000
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
Date: Wed,  7 May 2025 14:04:33 +0200
Message-ID: <20250507120451.4000627-10-hch@lst.de>
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



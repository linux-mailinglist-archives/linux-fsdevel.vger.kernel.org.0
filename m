Return-Path: <linux-fsdevel+bounces-17331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9B8AB8E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB561C20D0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF88811CB4;
	Sat, 20 Apr 2024 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hMfQKsyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93228479;
	Sat, 20 Apr 2024 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581453; cv=none; b=O/qRKuKDQc5XQ5wwsrqQcqlR4hEkxrKsr4MqipFNeMyGAzEx7HBDNXemQXOxXzOku++HeDaWchBOXqpkArtd9arxbNgEajgB53hxdNuK7IqJhENqSsXmqVHB2cO3m5kc35ZleMp4s6+UZUtefenB3cgPFBEU5J6fwb7R0JmFenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581453; c=relaxed/simple;
	bh=SaJbg29cD4jUS8oam2mSfQ8wg7ZwQ9f4NykFWaMo2sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0AGDuHJUekEGqtDq2jzrPfAHepUOY4p3snZ5KIU/eAikB4BOv6+EjeNagmLpz/kC7Obd9ABBrMp8Ds/yuU1+iwi2HQgFnwkRp+VJALgcQcefiOPoVt32rXVyWDZYTW1eWJYzATp/V/Ri7kxoOqE5uC3YPE02DcLzm85eA9VHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hMfQKsyp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=v2Klto9l+15juQRC2IXlUpAVUx+8RwOiMD9dxj8rlPo=; b=hMfQKsypnw1fBKuFbYvazrTvrW
	HS8SVGLCiFtX4qgDoqT0/cmwY2guUO0vBz92UgPDqLQ3XbIAaHv3aIKCm2iKIlEHkXOKiY9Gne7m1
	tcokWgbaXTamlR8vB/pv8EsHcmqSJe60DayL0Gn2/+clPjJMRJ2t5i6jHpnXIhfTA0JJQDW+ERwW9
	lszJBpz3beAR/X+sIsrNqyQAcZrxaCZ4ck156Hb6XacVHgi5qO+y/z/d9rwHzIWfN3/CBWYoGb0eR
	m56UGox+BLxCLsHNvwI5xDlyAqNWJi/9TYbyUko7r8AielstLEeQj2ebFYNMoghA3/+XECtiyWb6a
	+oiPXESg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oP-000000095e5-1cgp;
	Sat, 20 Apr 2024 02:50:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 03/30] btrfs: Use the folio iterator in btrfs_end_super_write()
Date: Sat, 20 Apr 2024 03:49:58 +0100
Message-ID: <20240420025029.2166544-4-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Iterate over folios instead of bvecs.  Switch the order of unlock and put
to be the usual order; we know this folio can't be put until it's been
waited for, but that's fragile.  Remove the calls to ClearPageUptodate /
SetPageUptodate -- if PAGE_SIZE is larger than BTRFS_SUPER_INFO_SIZE,
we'd be marking the entire folio uptodate without having actually
initialised all the bytes in the page.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8fa7c526093c..18c47bf3f383 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3627,28 +3627,21 @@ ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 static void btrfs_end_super_write(struct bio *bio)
 {
 	struct btrfs_device *device = bio->bi_private;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-	struct page *page;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
+	struct folio_iter fi;
 
+	bio_for_each_folio_all(fi, bio) {
 		if (bio->bi_status) {
 			btrfs_warn_rl_in_rcu(device->fs_info,
-				"lost page write due to IO error on %s (%d)",
+				"lost sb write due to IO error on %s (%d)",
 				btrfs_dev_name(device),
 				blk_status_to_errno(bio->bi_status));
-			ClearPageUptodate(page);
-			SetPageError(page);
+			folio_set_error(fi.folio);
 			btrfs_dev_stat_inc_and_print(device,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
-		} else {
-			SetPageUptodate(page);
 		}
 
-		put_page(page);
-		unlock_page(page);
+		folio_unlock(fi.folio);
+		folio_put(fi.folio);
 	}
 
 	bio_put(bio);
-- 
2.43.0



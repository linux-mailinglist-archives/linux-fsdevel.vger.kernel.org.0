Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DD5280702
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbgJASjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24722 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733038AbgJASik (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577520; x=1633113520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75fAmRUO5nDwJooOw48asWhVJ81jKELWO2GhE82J9JA=;
  b=AegbhGo1wardOJUaZgdHecU6zYnz0UiN5Hyt5rI+uDCvsEpB/ouep3gj
   svJk4PbsMcBSQ05MFYbCACNFWk03xX1+zNBI60UGH/5QQZXFOQUjDPkkC
   itHBZ9f3i1iMgCMFZqrc7QY+b0l302ZKO9O1WNaz3JQIXy4nNZsShsfU2
   vqWogBR9q09RMJ2agmPY0VYrNyZmgowjjwOLN6Izg5qtzbrgXQ9rFkAn5
   RZhEwv2CZwNgAIawg3Qus62N7sEPlGByL+q9sAaa95TGOUdmNRwMzcodd
   nneLoKtwJeMHDsMQxzURs+IrjbRZ7Tw+lKemcueBiHsVGOBohyDeEH8kC
   A==;
IronPort-SDR: /sxDnl23UZDdJUyNU7EwUJUDZiSwluFWZTOEE2BdUeqtAtlNCNWVQ7N3XD+moYyQEFwlC/96pe
 U3Q37Vv7JYSGbbtERqAyBrmzOZAgynOAV/IGrDIqQe4c+8tt53zJoTdVNoxXMpU8fQTV74vpQN
 9JV6sfeVcWSaEHTUD5njYuvDoWhHvpKNq9er5BhTXj9jBQeY5Gnj0syR0vMVZ1ycB1pWaUd0wX
 jzPWxPJK6Wq9jY0U/2XOAbVXoQgrmOJ3SXa/oN09+YAWvgfy5Gx6zaktNiis1CWOBR2MUM/uoJ
 0KE=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036810"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:25 +0800
IronPort-SDR: xPW/v05qe/jKWyKkQDt2LhoUXK7dtagmZeNr21AUQrJCVwb+OaAl7xT12E2/tab8qj3ORhkJ1Q
 b6tn8pwcU23w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:22 -0700
IronPort-SDR: DjflxTwUD3s9OdhVRIcgebWMmVY0MHbzF9Iz3SJ6Lb+61ZK68J0Fo4PQ0MWj4rda0ojA00FzA7
 f1qTu4vdoDIw==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 20/41] btrfs: extract page adding function
Date:   Fri,  2 Oct 2020 03:36:27 +0900
Message-Id: <fac833a97b365cd480840627431eff1cb2c8c52c.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit extract page adding to bio part from submit_extent_page(). The
page is added only when bio_flags are the same, contiguous and the added
page fits in the same stripe as pages in the bio.

Condition checkings are reordered to allow early return to avoid possibly
heavy btrfs_bio_fits_in_stripe() calling.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e91c504fe973..17285048fb5a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3012,6 +3012,43 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
 	return bio;
 }
 
+/**
+ * btrfs_bio_add_page	-	attempt to add a page to bio
+ * @bio:	destination bio
+ * @page:	page to add to the bio
+ * @logical:	offset of the new bio or to check whether we are adding
+ *              a contiguous page to the previous one
+ * @pg_offset:	starting offset in the page
+ * @size:	portion of page that we want to write
+ * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
+ * @bio_flags:	flags of the current bio to see if we can merge them
+ *
+ * Attempt to add a page to bio considering stripe alignment etc. Return
+ * true if successfully page added. Otherwise, return false.
+ */
+bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
+			unsigned int size, unsigned int pg_offset,
+			unsigned long prev_bio_flags, unsigned long bio_flags)
+{
+	sector_t sector = logical >> SECTOR_SHIFT;
+	bool contig;
+
+	if (prev_bio_flags != bio_flags)
+		return false;
+
+	if (prev_bio_flags & EXTENT_BIO_COMPRESSED)
+		contig = bio->bi_iter.bi_sector == sector;
+	else
+		contig = bio_end_sector(bio) == sector;
+	if (!contig)
+		return false;
+
+	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
+		return false;
+
+	return bio_add_page(bio, page, size, pg_offset) == size;
+}
+
 /*
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
@@ -3040,27 +3077,15 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t page_size = min_t(size_t, size, PAGE_SIZE);
-	sector_t sector = offset >> 9;
 	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
 
 	ASSERT(bio_ret);
 
 	if (*bio_ret) {
-		bool contig;
-		bool can_merge = true;
-
 		bio = *bio_ret;
-		if (prev_bio_flags & EXTENT_BIO_COMPRESSED)
-			contig = bio->bi_iter.bi_sector == sector;
-		else
-			contig = bio_end_sector(bio) == sector;
-
-		if (btrfs_bio_fits_in_stripe(page, page_size, bio, bio_flags))
-			can_merge = false;
-
-		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
-		    force_bio_submit ||
-		    bio_add_page(bio, page, page_size, pg_offset) < page_size) {
+		if (force_bio_submit ||
+		    !btrfs_bio_add_page(bio, page, offset, page_size, pg_offset,
+					prev_bio_flags, bio_flags)) {
 			ret = submit_one_bio(bio, mirror_num, prev_bio_flags);
 			if (ret < 0) {
 				*bio_ret = NULL;
-- 
2.27.0


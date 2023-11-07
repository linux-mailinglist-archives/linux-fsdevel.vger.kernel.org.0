Return-Path: <linux-fsdevel+bounces-2317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878F7E4A9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51EAB20FE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE32A1D5;
	Tue,  7 Nov 2023 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N7ZxMqoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785E2A1C1
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 21:26:48 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E5AD7A;
	Tue,  7 Nov 2023 13:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=iNDYg8DRsvaObfvTpWqtERvBTstUV4Ejndj13obP+9Q=; b=N7ZxMqoKgjDdJKGIqzDX461pjq
	5Wh7Vxea9VO5l3vU4Kl0EiGsyC34H9WII34u3+a2H4RBok4fD260MYcv7joOkcq8LffDD1qC+zS7U
	dwyvka6mV8jDJ60fvK6vbFmIm+z7vP0Ek3KGHSpECTOaSiXSyil4snlVPw+mKpLnaif6UGv0SJKi2
	xnKTDWn8D+dqdHylomhQACisCLSi7iQ0xYe8B6PMfy4nrU22HdmMLVa1kRu7I+zdz2zJ1LGuInYxv
	OrmU9FeQP8nfyn242lzo3tpUN9Ct2/ecJMI9fBmo0gFPy84UMZ8wEnFUs9pN8qfVuRNE1fpzfNKkt
	0zwZzg2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0Tav-00Ee0Z-9K; Tue, 07 Nov 2023 21:26:45 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-erofs@lists.ozlabs.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/3] gfs2: Convert stuffed_readpage() to stuffed_read_folio()
Date: Tue,  7 Nov 2023 21:26:42 +0000
Message-Id: <20231107212643.3490372-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231107212643.3490372-1-willy@infradead.org>
References: <20231107212643.3490372-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use folio_fill_tail() to implement the unstuffing and folio_end_read()
to simultaneously mark the folio uptodate and unlock it.  Unifies a
couple of code paths.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 9611bfceda4b..ba8742dc91f8 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -403,18 +403,18 @@ static int gfs2_jdata_writepages(struct address_space *mapping,
 }
 
 /**
- * stuffed_readpage - Fill in a Linux folio with stuffed file data
+ * stuffed_read_folio - Fill in a Linux folio with stuffed file data
  * @ip: the inode
  * @folio: the folio
  *
  * Returns: errno
  */
-static int stuffed_readpage(struct gfs2_inode *ip, struct folio *folio)
+static int stuffed_read_folio(struct gfs2_inode *ip, struct folio *folio)
 {
-	struct buffer_head *dibh;
-	size_t i_size = i_size_read(&ip->i_inode);
-	void *data;
-	int error;
+	struct buffer_head *dibh = NULL;
+	size_t dsize = i_size_read(&ip->i_inode);
+	void *from = NULL;
+	int error = 0;
 
 	/*
 	 * Due to the order of unstuffing files and ->fault(), we can be
@@ -422,22 +422,20 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct folio *folio)
 	 * so we need to supply one here. It doesn't happen often.
 	 */
 	if (unlikely(folio->index)) {
-		folio_zero_range(folio, 0, folio_size(folio));
-		folio_mark_uptodate(folio);
-		return 0;
+		dsize = 0;
+	} else {
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			goto out;
+		from = dibh->b_data + sizeof(struct gfs2_dinode);
 	}
 
-	error = gfs2_meta_inode_buffer(ip, &dibh);
-	if (error)
-		return error;
-
-	data = dibh->b_data + sizeof(struct gfs2_dinode);
-	memcpy_to_folio(folio, 0, data, i_size);
-	folio_zero_range(folio, i_size, folio_size(folio) - i_size);
+	folio_fill_tail(folio, 0, from, dsize);
 	brelse(dibh);
-	folio_mark_uptodate(folio);
+out:
+	folio_end_read(folio, error == 0);
 
-	return 0;
+	return error;
 }
 
 /**
@@ -456,8 +454,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
 		error = iomap_read_folio(folio, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
-		error = stuffed_readpage(ip, folio);
-		folio_unlock(folio);
+		error = stuffed_read_folio(ip, folio);
 	} else {
 		error = mpage_read_folio(folio, gfs2_block_map);
 	}
-- 
2.42.0



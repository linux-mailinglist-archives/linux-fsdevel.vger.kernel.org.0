Return-Path: <linux-fsdevel+bounces-9540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DA8426FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 15:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1781F23E39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B26EB62;
	Tue, 30 Jan 2024 14:32:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83116DD03;
	Tue, 30 Jan 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625155; cv=none; b=V9YunkJ4tO+OOv/yTa1Zhuuw837XQ9paiYoIqK6f8XfupT7/HVZB/4YICbG/iSofAcEtPgq+lDS1iehvxOAWSz/Ynxrvc6rtnVYIq/D1nW1zf4mpwR8qApSoxVL1hZR7Vm8AUPLTqUu8qDUgbQrjBDXSjUpLC+rRUD1bPOUEBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625155; c=relaxed/simple;
	bh=Z7EH6XvVnLFGgUq3HBLgyE6pJaaNG87//RotfEpd5bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifoH5o1tVuASOM5QqI2waZ8QwGFV7bnRbyDR8/AE9QLOUlBVuoede/2NiCpUuylDZbueweAhAQH6sb/T+6W6hSfSppcAzG9C+HPBgq+bzLk1hg9rkLhekl9CE2H+An/pzLWvjCT3M03ZKkoMQGgpb4QxzhWZ61m/36FkaozHq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8B1B68B05; Tue, 30 Jan 2024 15:32:27 +0100 (CET)
Date: Tue, 30 Jan 2024 15:32:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240130143227.GC31330@lst.de>
References: <20240125085758.2393327-1-hch@lst.de> <20240125085758.2393327-20-hch@lst.de> <20240130104605.2i6mmdncuhwwwfin@quack3> <20240130141601.GA31330@lst.de> <20240130142205.GB31330@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130142205.GB31330@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 03:22:05PM +0100, Christoph Hellwig wrote:
> And now for real:

Another slight variant of this would be to move the nr_to_write || err
check for WB_SYNC_NONE out of the branch.  This adds extra tests for
the initial iteration, but unindents a huge comment, and moves it closer
to the other branch that it also describes.  The downside at least to
me is that the normal non-termination path is not the straight line
through function.  Thoughs?

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 973f57ad9ee548..ff6e73453aa8c4 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2461,24 +2461,6 @@ struct folio *writeback_iter(struct address_space *mapping,
 		wbc->nr_to_write -= folio_nr_pages(folio);
 		if (*error && !wbc->err)
 			wbc->err = *error;
-
-		/*
-		 * For integrity sync  we have to keep going until we have
-		 * written all the folios we tagged for writeback prior to
-		 * entering the writeback loop, even if we run past
-		 * wbc->nr_to_write or encounter errors.
-		 *
-		 * This is because the file system may still have state to clear
-		 * for each folio.  We'll eventually return the first error
-		 * encountered.
-		 *
-		 * For background writeback just push done_index past this folio
-		 * so that we can just restart where we left off and media
-		 * errors won't choke writeout for the entire file.
-		 */
-		if (wbc->sync_mode == WB_SYNC_NONE &&
-		    (wbc->err || wbc->nr_to_write <= 0))
-			goto finish;
 	} else {
 		if (wbc->range_cyclic)
 			wbc->index = mapping->writeback_index; /* prev offset */
@@ -2491,17 +2473,20 @@ struct folio *writeback_iter(struct address_space *mapping,
 		wbc->err = 0;
 	}
 
-	folio = writeback_get_folio(mapping, wbc);
-	if (!folio)
-		goto finish;
-	return folio;
-
-finish:
-	folio_batch_release(&wbc->fbatch);
-
 	/*
+	 * For integrity sync  we have to keep going until we have written all
+	 * the folios we tagged for writeback prior to entering the writeback
+	 * loop, even if we run past wbc->nr_to_write or encounter errors.
+	 *
+	 * This is because the file system may still have state to clear for
+	 * each folio.  We'll eventually return the first error encountered.
+	 *
+	 * For background writeback just push done_index past this folio so that
+	 * we can just restart where we left off and media errors won't choke
+	 * writeout for the entire file.
+	 *
 	 * For range cyclic writeback we need to remember where we stopped so
-	 * that we can continue there next time we are called.  If  we hit the
+	 * that we can continue there next time we are called.  If we hit the
 	 * last page and there is more work to be done, wrap back to the start
 	 * of the file.
 	 *
@@ -2509,14 +2494,21 @@ struct folio *writeback_iter(struct address_space *mapping,
 	 * of the file if we are called again, which can only happen due to
 	 * -ENOMEM from the file system.
 	 */
-	if (wbc->range_cyclic) {
-		WARN_ON_ONCE(wbc->sync_mode != WB_SYNC_NONE);
-		if (wbc->err || wbc->nr_to_write <= 0)
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    (wbc->err || wbc->nr_to_write <= 0)) {
+		if (wbc->range_cyclic)
 			mapping->writeback_index =
 				folio->index + folio_nr_pages(folio);
-		else
+	} else {
+		folio = writeback_get_folio(mapping, wbc);
+		if (folio)
+			return folio;
+
+		if (wbc->range_cyclic)
 			mapping->writeback_index = 0;
 	}
+
+	folio_batch_release(&wbc->fbatch);
 	*error = wbc->err;
 	return NULL;
 }


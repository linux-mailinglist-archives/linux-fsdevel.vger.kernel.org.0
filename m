Return-Path: <linux-fsdevel+bounces-6189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29F814A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B753328607F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436130328;
	Fri, 15 Dec 2023 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF8cQ/jB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206393032F
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702649768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGCo/BpL11RGikah8KaGUvZ8gRuDuiWWsX0i2uxlHCs=;
	b=aF8cQ/jBjCbGmEs9QRxr7yhVLSzWInfOMq7xMgnGVimoEI1YCx58xURb/Wjg56MqPfrM2Y
	6oEn5RSknd4mSPBPvB4gOw1hPJ0MZwlbeMHI4mB8+NgivOof/pbxoLDK//eznTpZbuD5rP
	HXYugHqhR6d406zZ8Tvh8kdK1Oln9P4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-f1soc7hsN0ywK75HVsslug-1; Fri, 15 Dec 2023 09:16:05 -0500
X-MC-Unique: f1soc7hsN0ywK75HVsslug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD4DE185A784;
	Fri, 15 Dec 2023 14:16:04 +0000 (UTC)
Received: from bfoster (unknown [10.22.8.199])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 313A81C060B1;
	Fri, 15 Dec 2023 14:16:04 +0000 (UTC)
Date: Fri, 15 Dec 2023 09:17:05 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/11] writeback: Factor writeback_iter_next() out of
 write_cache_pages()
Message-ID: <ZXxf4TB5YU8huiz1@bfoster>
References: <20231214132544.376574-1-hch@lst.de>
 <20231214132544.376574-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214132544.376574-10-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Thu, Dec 14, 2023 at 02:25:42PM +0100, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Pull the post-processing of the writepage_t callback into a
> separate function.  That means changing writeback_finish() to
> return NULL, and writeback_get_next() to call writeback_finish()
> when we naturally run out of folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/page-writeback.c | 89 +++++++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index b0accca1f4bfa7..4fae912f7a86e2 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2360,7 +2360,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
>  }
>  EXPORT_SYMBOL(tag_pages_for_writeback);
>  
> -static int writeback_finish(struct address_space *mapping,
> +static struct folio *writeback_finish(struct address_space *mapping,
>  		struct writeback_control *wbc, bool done)
>  {
>  	folio_batch_release(&wbc->fbatch);
> @@ -2375,7 +2375,7 @@ static int writeback_finish(struct address_space *mapping,
>  	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
>  		mapping->writeback_index = wbc->done_index;
>  
> -	return wbc->err;
> +	return NULL;

The series looks reasonable to me on a first pass, but this stood out to
me as really odd. I was initially wondering if it made sense to use an
ERR_PTR() here or something, but on further staring it kind of seems
like this is better off being factored out of the internal iteration
paths. Untested and Probably Broken patch (based on this one) below as a
quick reference, but just a thought...

BTW it would be nicer to just drop the ->done field entirely as Jan has
already suggested, but I just stuffed it in wbc for simplicity.

Brian

--- 8< ---

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index be960f92ad9d..0babca17a2c0 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -84,6 +84,7 @@ struct writeback_control {
 	pgoff_t index;
 	pgoff_t end;			/* inclusive */
 	pgoff_t done_index;
+	bool done;
 	int err;
 	unsigned range_whole:1;		/* entire file */
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4fae912f7a86..3ee2058a2559 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2360,8 +2360,8 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
-static struct folio *writeback_finish(struct address_space *mapping,
-		struct writeback_control *wbc, bool done)
+static int writeback_iter_finish(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
 	folio_batch_release(&wbc->fbatch);
 
@@ -2370,12 +2370,12 @@ static struct folio *writeback_finish(struct address_space *mapping,
 	 * wrap the index back to the start of the file for the next
 	 * time we are called.
 	 */
-	if (wbc->range_cyclic && !done)
+	if (wbc->range_cyclic && !wbc->done)
 		wbc->done_index = 0;
 	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = wbc->done_index;
 
-	return NULL;
+	return wbc->err;
 }
 
 static struct folio *writeback_get_next(struct address_space *mapping,
@@ -2434,19 +2434,16 @@ static struct folio *writeback_get_folio(struct address_space *mapping,
 {
 	struct folio *folio;
 
-	for (;;) {
-		folio = writeback_get_next(mapping, wbc);
-		if (!folio)
-			return writeback_finish(mapping, wbc, false);
+	while ((folio = writeback_get_next(mapping, wbc)) != NULL) {
 		wbc->done_index = folio->index;
-
 		folio_lock(folio);
 		if (likely(should_writeback_folio(mapping, wbc, folio)))
 			break;
 		folio_unlock(folio);
 	}
 
-	trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+	if (folio)
+		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
 	return folio;
 }
 
@@ -2466,6 +2463,7 @@ static struct folio *writeback_iter_init(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, wbc->index, wbc->end);
 
 	wbc->done_index = wbc->index;
+	wbc->done = false;
 	folio_batch_init(&wbc->fbatch);
 	wbc->err = 0;
 
@@ -2494,7 +2492,8 @@ static struct folio *writeback_iter_next(struct address_space *mapping,
 		} else if (wbc->sync_mode != WB_SYNC_ALL) {
 			wbc->err = error;
 			wbc->done_index = folio->index + nr;
-			return writeback_finish(mapping, wbc, true);
+			wbc->done = true;
+			return NULL;
 		}
 		if (!wbc->err)
 			wbc->err = error;
@@ -2507,8 +2506,10 @@ static struct folio *writeback_iter_next(struct address_space *mapping,
 	 * to entering this loop.
 	 */
 	wbc->nr_to_write -= nr;
-	if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE)
-		return writeback_finish(mapping, wbc, true);
+	if (wbc->nr_to_write <= 0 && wbc->sync_mode == WB_SYNC_NONE) {
+		wbc->done = true;
+		return NULL;
+	}
 
 	return writeback_get_folio(mapping, wbc);
 }
@@ -2557,7 +2558,7 @@ int write_cache_pages(struct address_space *mapping,
 		error = writepage(folio, wbc, data);
 	}
 
-	return wbc->err;
+	return writeback_iter_finish(mapping, wbc);
 }
 EXPORT_SYMBOL(write_cache_pages);
 



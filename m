Return-Path: <linux-fsdevel+bounces-7035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1B82041F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 10:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E341F21C09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE022584;
	Sat, 30 Dec 2023 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BpGcDNXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487223A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Dec 2023 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NAb3SoTBQSd7Cosu51e+bjXX2vE8sccK+WfSxnKFbwY=; b=BpGcDNXEM+P6p8yzGytGxn5XCv
	QItEdPb8cHnnhbKJs7hjI1gc+erOFJooZLXAT3Cooey8RrvWnoklC3LVI7aCecOKh1xYA4gwdMUoX
	T3bhy+h5jkWGYQOEzhAKTlbjayXhtiIFaGfef09eYmDp3khqtT9dVDP5j5BC63WSSq0GplvN+fXhQ
	rw8WJc3XOaaG+zvyXLYhdn8k58R3dEeMhLlNuPOjxNPe25GuC7IikUidcetnSIOGadGhpk8+YGDgz
	1TzPP8t1xs/lr25EAnzXwkanjE1oBC7tm5iMyj9QS6uhjtZsHyYuCe7fKYbCT4HMK0a0TkSK+LaWM
	LXkFpzRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJVYb-006vOk-9h; Sat, 30 Dec 2023 09:23:01 +0000
Date: Sat, 30 Dec 2023 09:23:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] buffer: Return bool from grow_dev_folio()
Message-ID: <ZY/hdUqeKMi0IVp6@casper.infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-2-willy@infradead.org>
 <CAKFNMo=1yLxL9RR4XBY6=SkWej7tstTEiFQjUFWjxMs+5=YPFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMo=1yLxL9RR4XBY6=SkWej7tstTEiFQjUFWjxMs+5=YPFw@mail.gmail.com>

On Fri, Nov 10, 2023 at 12:43:43PM +0900, Ryusuke Konishi wrote:
> On Fri, Nov 10, 2023 at 6:07 AM Matthew Wilcox (Oracle) wrote:
> > +               /* Caller should retry if this call fails */
> > +               end_block = ~0ULL;
> >                 if (!try_to_free_buffers(folio))
> > -                       goto failed;
> > +                       goto unlock;
> >         }
> >
> 
> > -       ret = -ENOMEM;
> >         bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
> >         if (!bh)
> > -               goto failed;
> > +               goto unlock;
> 
> Regarding this folio_alloc_buffers() error path,
> If folio_buffers() was NULL, here end_block is 0, so this function
> returns false (which means "have a permanent failure").
> 
> But, if folio_buffers() existed and they were freed with
> try_to_free_buffers() because of bh->b_size != size, here end_block
> has been set to ~0ULL, so it seems to return true ("succeeded").
> 
> Does this semantic change match your intent?
> 
> Otherwise, I think end_block should be set to 0 just before calling
> folio_alloc_buffers().

Thanks for the review, and sorry for taking so long to get back to you.
The change was unintentional (but memory allocation failure wth GFP_KERNEL
happens so rarely that our testing was never going to catch it)

I think I should just move the assignment to end_block inside the 'if'.
It's just more obvious what's going on.  Andrew prodded me to be more
explicit about why memory allocation is a "permanent" failure, but
failing to free buffers is not.

I'll turn this into a proper patch submission later.

diff --git a/fs/buffer.c b/fs/buffer.c
index d5ce6b29c893..d3bcf601d3e5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1028,8 +1028,8 @@ static sector_t folio_init_buffers(struct folio *folio,
  *
  * This is used purely for blockdev mappings.
  *
- * Returns false if we have a 'permanent' failure.  Returns true if
- * we succeeded, or the caller should retry.
+ * Returns false if we have a failure which cannot be cured by retrying
+ * without sleeping.  Returns true if we succeeded, or the caller should retry.
  */
 static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 		pgoff_t index, unsigned size, gfp_t gfp)
@@ -1051,10 +1051,17 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 			goto unlock;
 		}
 
-		/* Caller should retry if this call fails */
-		end_block = ~0ULL;
-		if (!try_to_free_buffers(folio))
+		/*
+		 * Retrying may succeed; for example the folio may finish
+		 * writeback, or buffers may be cleaned.  This should not
+		 * happen very often; maybe we have old buffers attached to
+		 * this blockdev's page cache and we're trying to change
+		 * the block size?
+		 */
+		if (!try_to_free_buffers(folio)) {
+			end_block = ~0ULL;
 			goto unlock;
+		}
 	}
 
 	bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);


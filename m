Return-Path: <linux-fsdevel+bounces-29686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A920597C3E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B17F284DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 05:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F11BDDB;
	Thu, 19 Sep 2024 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rm79t3Ig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BA2AEF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726723242; cv=none; b=A3qHJ7SHpSFWdyT2VC+LNu6b1r/axEj4cFtdP4WAkZgoYBSfvFKf/sZd/qpPLrxNsljPvTdoY51W7JlXuJGFE/Vg0i5fb+bsOZ6GjOQpHQCJV+LXQzNcviXLRRkY1aojAqV93X36LQsJsx+QaytH05WkLjywNEtpcH2kbPf1g3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726723242; c=relaxed/simple;
	bh=9EvgljSxbQCh448pMLmS2r8C54ZrhqrGmu+XF9otYgc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jCXXru21D/6EX6idCHvcuPjikqrieH+HX3FW0M82T/Un2NmrV87mlYcxBLz4tkk/b3nisoaIStcU40BsClWYb1jxtsz1togt2c/7wzEDLOwcZrTt9ARJ3Q82W7aZksv8hHIhRdr58h5+SjeIN7DaReYsCA/sji4HOeF8obWzq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Rm79t3Ig; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d13b83511so44212366b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726723237; x=1727328037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IzPONe7Hl8hATuXT+GEoDEy0vE4mDwVH0cNH7cNT9Uo=;
        b=Rm79t3Ig9RM67tzWVpul+lCn8OLWNEwjQoQ4RvmSsvVQkYs+whP6HkC+VFDBATWRbf
         Lw1c89w9Qpy7C5jkqnLV/adexuF0IO4Z0XRg8DY8s3Iug2LHgpGfc3mKoMM2VRCNpPQH
         Oxa6X/KlXGTRCI6E1/VCDJn5/MGFkK/zqIN9maj2L7YZPAZpiI1IUHVZ2wrHvY1axCGA
         7brxA3EKDl9TwW2p8m3hpEaIKsk0o5iXCdRc/EDo+fey6meImiq9qMl+rhr4U7zBRox5
         oneTGI4DOwyhReQyqQ60ZjivHmMgGOOsSNFdAj3Q/IWj1Rs+P8k8jaSM7CexK5ay8B3C
         i77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726723237; x=1727328037;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzPONe7Hl8hATuXT+GEoDEy0vE4mDwVH0cNH7cNT9Uo=;
        b=XKZ1yACQ/UGK083fXF4hCXQDix9xDlS7GETwn4aGuc4b13HZgwD1kzmvYpkuWttimB
         pOJ3RWjPtX5/8Z+BJFnm9Rof8ODTwKeSLGCKgxg7Mcr/BdZQVvd8jc1GVMnf3TZWQIsT
         OfpTWQflcJwABiFTcysUxg64japQnoB5TqGdSjN4mwOHJhhWOpAtXbNIAVlGo4EgcswH
         HH/mdr8SIsGfhZiUxTZ7F9loCgHOkU0TWDawRzkQ7iQ+CFi5cjQFjNPZ/DaB2bpHNlGd
         oOj1xAWSfNIx3V9YD/arqr2Nm6mma9pcat+OxwLlf2Zr6Er1uiiReHNwST//CzqBxSwl
         Vi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1LFY46Pg4zlA6uAmTY5B7NHt2GUnapG6sGYqEO0ddDjEWdOi7fxYkZ8CR/zddBYLI3XTp5/rczfnRTfte@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCHwBdnqsNGU890CZmTYiJSgX6s3hU8jWne7GR6LgDPEJGGRh
	eApxtMSHsBtuHXHZjHtO9yPyx3QI7ObcR3VNkcJ+mRtvC/h2TWs9NhGxCKW5L6o=
X-Google-Smtp-Source: AGHT+IHju4oboqyEQSy4+Om/ISByeho+FWCyfDVzSygtpfXVDtV4IFkyl8yrfHmySRRFv+5nrUuHiw==
X-Received: by 2002:a17:906:bc26:b0:a8d:2ec3:94f4 with SMTP id a640c23a62f3a-a902964d007mr2102225766b.54.1726723237206;
        Wed, 18 Sep 2024 22:20:37 -0700 (PDT)
Received: from [192.168.0.216] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967a5sm675990066b.21.2024.09.18.22.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 22:20:35 -0700 (PDT)
Message-ID: <6839133c-56ca-45dc-8115-2fbcc907938e@kernel.dk>
Date: Wed, 18 Sep 2024 23:20:33 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
From: Jens Axboe <axboe@kernel.dk>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>,
 Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
 regressions@leemhuis.info
References: <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
 <ZuuqPEtIliUJejvw@casper.infradead.org>
 <9e62898f-907e-439f-96f3-de2e29f57e37@kernel.dk>
Content-Language: en-US
In-Reply-To: <9e62898f-907e-439f-96f3-de2e29f57e37@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/24 10:46 PM, Jens Axboe wrote:
> On 9/18/24 10:36 PM, Matthew Wilcox wrote:
>> On Wed, Sep 18, 2024 at 09:38:41PM -0600, Jens Axboe wrote:
>>> On 9/18/24 9:12 PM, Linus Torvalds wrote:
>>>> On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
>>>> <torvalds@linux-foundation.org> wrote:
>>>>>
>>>>> I think we should just do the simple one-liner of adding a
>>>>> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
>>>>> xas_split_alloc()).
>>>>
>>>> .. and obviously that should be actually *verified* to fix the issue
>>>> not just with the test-case that Chris and Jens have been using, but
>>>> on Christian's real PostgreSQL load.
>>>>
>>>> Christian?
>>>>
>>>> Note that the xas_reset() needs to be done after the check for errors
>>>> - or like Willy suggested, xas_split_alloc() needs to be re-organized.
>>>>
>>>> So the simplest fix is probably to just add a
>>>>
>>>>                         if (xas_error(&xas))
>>>>                                 goto error;
>>>>                 }
>>>> +               xas_reset(&xas);
>>>>                 xas_lock_irq(&xas);
>>>>                 xas_for_each_conflict(&xas, entry) {
>>>>                         old = entry;
>>>>
>>>> in __filemap_add_folio() in mm/filemap.c
>>>>
>>>> (The above is obviously a whitespace-damaged pseudo-patch for the
>>>> pre-6758c1128ceb state. I don't actually carry a stable tree around on
>>>> my laptop, but I hope it's clear enough what I'm rambling about)
>>>
>>> I kicked off a quick run with this on 6.9 with my debug patch as well,
>>> and it still fails for me... I'll double check everything is sane. For
>>> reference, below is the 6.9 filemap patch.
>>>
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 30de18c4fd28..88093e2b7256 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -883,6 +883,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>>>  		if (order > folio_order(folio))
>>>  			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
>>>  					order, gfp);
>>> +		xas_reset(&xas);
>>>  		xas_lock_irq(&xas);
>>>  		xas_for_each_conflict(&xas, entry) {
>>>  			old = entry;
>>
>> My brain is still mushy, but I think there is still a problem (both with
>> the simple fix for 6.9 and indeed with 6.10).
>>
>> For splitting a folio, we have the folio locked, so we know it's not
>> going anywhere.  The tree may get rearranged around it while we don't
>> have the xa_lock, but we're somewhat protected.
>>
>> In this case we're splitting something that was, at one point, a shadow
>> entry.  There's no struct there to lock.  So I think we can have a
>> situation where we replicate 'old' (in 6.10) or xa_load() (in 6.9)
>> into the nodes we allocate in xas_split_alloc().  In 6.10, that's at
>> least guaranteed to be a shadow entry, but in 6.9, it might already be a
>> folio by this point because we've raced with something else also doing a
>> split.
>>
>> Probably xas_split_alloc() needs to just do the alloc, like the name
>> says, and drop the 'entry' argument.  ICBW, but I think it explains
>> what you're seeing?  Maybe it doesn't?
> 
> Since I can hit it pretty reliably and quickly, I'm happy to test
> whatever you want on top of 6.9. From the other email, I backported:
> 
> a4864671ca0b ("lib/xarray: introduce a new helper xas_get_order")
> 6758c1128ceb ("mm/filemap: optimize filemap folio adding")
> 
> to 6.9 and kicked off a test with that 5 min ago, and it's still going.
> I'd say with 90% confidence that it should've hit already, but let's
> leave it churning for an hour and see what pops out the other end.

45 min later, I think I can conclusively call the backport of those two
on top of 6.9 good.

Below is what I'm running, which is those two commits (modulo the test
bits, for clarify). Rather than attempt to fix this differently for 6.9,
perhaps not a bad idea to just get those two into stable? It's not a lot
of churn, and at least that keeps it consistent rather than doing
something differently for stable.

I'll try and do a patch that just ensures the order is consistent across
lock cycles as Linus suggested, just to verify that this is indeed the
main issue. Will keep the xas_reset() as well.

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..da2f5bba7944 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1548,6 +1551,7 @@ void xas_create_range(struct xa_state *);
 
 #ifdef CONFIG_XARRAY_MULTI
 int xa_get_order(struct xarray *, unsigned long index);
+int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 #else
@@ -1556,6 +1560,11 @@ static inline int xa_get_order(struct xarray *xa, unsigned long index)
 	return 0;
 }
 
+static inline int xas_get_order(struct xa_state *xas)
+{
+	return 0;
+}
+
 static inline void xas_split(struct xa_state *xas, void *entry,
 		unsigned int order)
 {
diff --git a/lib/xarray.c b/lib/xarray.c
index 5e7d6334d70d..c0514fb16d33 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1765,39 +1780,52 @@ void *xa_store_range(struct xarray *xa, unsigned long first,
 EXPORT_SYMBOL(xa_store_range);
 
 /**
- * xa_get_order() - Get the order of an entry.
- * @xa: XArray.
- * @index: Index of the entry.
+ * xas_get_order() - Get the order of an entry.
+ * @xas: XArray operation state.
+ *
+ * Called after xas_load, the xas should not be in an error state.
  *
  * Return: A number between 0 and 63 indicating the order of the entry.
  */
-int xa_get_order(struct xarray *xa, unsigned long index)
+int xas_get_order(struct xa_state *xas)
 {
-	XA_STATE(xas, xa, index);
-	void *entry;
 	int order = 0;
 
-	rcu_read_lock();
-	entry = xas_load(&xas);
-
-	if (!entry)
-		goto unlock;
-
-	if (!xas.xa_node)
-		goto unlock;
+	if (!xas->xa_node)
+		return 0;
 
 	for (;;) {
-		unsigned int slot = xas.xa_offset + (1 << order);
+		unsigned int slot = xas->xa_offset + (1 << order);
 
 		if (slot >= XA_CHUNK_SIZE)
 			break;
-		if (!xa_is_sibling(xas.xa_node->slots[slot]))
+		if (!xa_is_sibling(xa_entry(xas->xa, xas->xa_node, slot)))
 			break;
 		order++;
 	}
 
-	order += xas.xa_node->shift;
-unlock:
+	order += xas->xa_node->shift;
+	return order;
+}
+EXPORT_SYMBOL_GPL(xas_get_order);
+
+/**
+ * xa_get_order() - Get the order of an entry.
+ * @xa: XArray.
+ * @index: Index of the entry.
+ *
+ * Return: A number between 0 and 63 indicating the order of the entry.
+ */
+int xa_get_order(struct xarray *xa, unsigned long index)
+{
+	XA_STATE(xas, xa, index);
+	int order = 0;
+	void *entry;
+
+	rcu_read_lock();
+	entry = xas_load(&xas);
+	if (entry)
+		order = xas_get_order(&xas);
 	rcu_read_unlock();
 
 	return order;
diff --git a/mm/filemap.c b/mm/filemap.c
index 30de18c4fd28..b8d525825d3f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -852,7 +852,9 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	bool huge = folio_test_hugetlb(folio);
+	void *alloced_shadow = NULL;
+	int alloced_order = 0;
+	bool huge;
 	bool charged = false;
 	long nr = 1;
 
@@ -869,6 +871,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 	xas_set_order(&xas, index, folio_order(folio));
+	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
 	gfp &= GFP_RECLAIM_MASK;
@@ -876,13 +879,10 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->mapping = mapping;
 	folio->index = xas.xa_index;
 
-	do {
-		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
+	for (;;) {
+		int order = -1, split_order = 0;
 		void *entry, *old = NULL;
 
-		if (order > folio_order(folio))
-			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
-					order, gfp);
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
@@ -890,19 +890,33 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				xas_set_err(&xas, -EEXIST);
 				goto unlock;
 			}
+			/*
+			 * If a larger entry exists,
+			 * it will be the first and only entry iterated.
+			 */
+			if (order == -1)
+				order = xas_get_order(&xas);
+		}
+
+		/* entry may have changed before we re-acquire the lock */
+		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
+			xas_destroy(&xas);
+			alloced_order = 0;
 		}
 
 		if (old) {
-			if (shadowp)
-				*shadowp = old;
-			/* entry may have been split before we acquired lock */
-			order = xa_get_order(xas.xa, xas.xa_index);
-			if (order > folio_order(folio)) {
+			if (order > 0 && order > folio_order(folio)) {
 				/* How to handle large swap entries? */
 				BUG_ON(shmem_mapping(mapping));
+				if (!alloced_order) {
+					split_order = order;
+					goto unlock;
+				}
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
+			if (shadowp)
+				*shadowp = old;
 		}
 
 		xas_store(&xas, folio);
@@ -918,9 +932,24 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				__lruvec_stat_mod_folio(folio,
 						NR_FILE_THPS, nr);
 		}
+
 unlock:
 		xas_unlock_irq(&xas);
-	} while (xas_nomem(&xas, gfp));
+
+		/* split needed, alloc here and retry. */
+		if (split_order) {
+			xas_split_alloc(&xas, old, split_order, gfp);
+			if (xas_error(&xas))
+				goto error;
+			alloced_shadow = old;
+			alloced_order = split_order;
+			xas_reset(&xas);
+			continue;
+		}
+
+		if (!xas_nomem(&xas, gfp))
+			break;
+	}
 
 	if (xas_error(&xas))
 		goto error;

-- 
Jens Axboe


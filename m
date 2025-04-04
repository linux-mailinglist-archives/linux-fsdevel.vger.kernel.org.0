Return-Path: <linux-fsdevel+bounces-45708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD1A7B53E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 02:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34D51886129
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 00:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E81E485;
	Fri,  4 Apr 2025 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrbAM/zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CDDDC1;
	Fri,  4 Apr 2025 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743727838; cv=none; b=Xvwn3V39d+r9xdbWgVAS2HXATuiliqjJN/N6lXcZfaAjM9yHqGImkkYcjZQvcIlRNJ5D1Ws7ca7pkr3S3lqevstuDDO7/HM1p1E5LdyPr/4jmWDh96SkdMsmmhAhxDjZA3oTKLwyeDtkXGN7v5HxiO+6MwNUWWKp0q6RV7K0RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743727838; c=relaxed/simple;
	bh=vZ5YULQyvjC5q48q2CCUQGCyh+cCXf4h7GLErHvCGvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl3E+4B32KAGRZFy6xjAZddT8/7pq+wm8waBzvNKDg+79wV7YYK0qwULt6FKGBn41hAOpQp2kuBUYVbGy2bHa9cQnwapONYxOIEug+3u1wnrpueIHmy53otJaAWjryq88vUwCcd5asTYnr8VSV10QueH58qdNym6/hrqWHAf+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrbAM/zx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso1313145a91.0;
        Thu, 03 Apr 2025 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743727836; x=1744332636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Th78P7lLc34hMpgoaKVJWgxxETQOSCyPOGjwMuTxpqE=;
        b=JrbAM/zx8DypVGPDXixKQrrH31jZ4Cf5D8qCxGvXJA6kBFQL7skK5mYc8VUDohwHx8
         4xOaMfeNzq69YsfP4jN/gpkSiX13CDKgolvdKWIWTgS+GaqKC5g39gwuS2Vna+6e6i73
         XY13kT7bwwXNsrTEbIL2NQjy0LRYiZp5yKc8wJQPuJqU4/wD7B6FhyW5ChNDterKoTRr
         CBJHqaCsZb3D7lQhtznJdkPrwdhUD3LA2EJAenh4RM3FtNnPRhK/4YqWU8Qk4FIWBZjf
         ZLV5iFd6g3yBTHQyYB8S8RFUrBJqRMXyCCfXRJrPFey+SDweyQyGbukaA+8Ns2LFF73b
         uePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743727836; x=1744332636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Th78P7lLc34hMpgoaKVJWgxxETQOSCyPOGjwMuTxpqE=;
        b=O9DQCRx1Tp++0cCtQtBSw9y4h0H52ZRxlBlrVguwiwud9Yz0ggMMsy5pFqF45ghEp2
         nv4YcOzr6NmcaAJlPiMMD9mor3iqZcfnpNkGZoipW09YX8KAjEP7g7w/xmB5JxXaKnet
         YhwdMoT3cjMQHhYyKu2x7igjy/kO5eOj5Gjc/h/igZPxnXjPLTrp3VBVSOqDFAARaUov
         2ytJns9YPzOZ3+hUz/gUaxX23nsfjLIe13l0P8eFbNWisZXcXT+hHdTwC2z2j4wq4Saw
         dI/mAT6ts5DFkhnflGzaPOG+cWrCZgNhBdtS/1CPAgbtttoUhviUqGHCSACV2zNyw/4F
         Cwrg==
X-Forwarded-Encrypted: i=1; AJvYcCUv2NIBfYyvD5CwYtJ5LxPzAV3dL72LLWKnqneFiUbse1lN858cldYmlT5tNAD6nW3M8pd3fOlXKSBB/ZFwaQ==@vger.kernel.org, AJvYcCVcub+vFdTN5D/ogU3QPq+5GYZCirg987tMuaKxBL5ZxMfiJmMlx1/2iN537Aze9uWFLNAcpY7xxwGfvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NooH9gPLayhqgJ00IkGkgcnEpaXY2xPBZ5JjzUqmYQi1KMI1
	EA2Abjdsgm0TdoDB1XAXCBoYyD1cK45FpBHP0lcuNJrVshx9xXnO
X-Gm-Gg: ASbGncvAQcq95BM91/kxXNzos273frwQGQJSBcx9P0g4HO+hLUNJ3VIpJBVB0q86yzE
	ndmv6sSLxfSewzfNN4qL5FkZjPHveV9kzvA0cknFqUPd+vwkm+/hY2ExPo4mto5+t2Ldw3UKOzH
	5B/dGTpH0OTliUiFXXf7kBai33MQm6/WwAvJYaQh0xr/JdMfoNzNeBVBQZAYmm586QRgRSueKRA
	BlQiVXFKKoXO2w31UeuZWRwvPnxCGcJR2Fk8woEWBe3tNriSVTLwRlldIryjbdUGYyXeq/T3B/L
	ykI8EYrWwrAlBTQZNsbce8px3GpX0FpjgzFgQ4nWQZjlvbI/vk6L51NIdtYL6b92lRyMpBPmXe4
	+
X-Google-Smtp-Source: AGHT+IE0OK+ZG86CXfS8cxl7/u4OcTyr0/sVE0W60caXee3AGQFNLpQ/eKk0mGeHGmFqwPk/RLsUqQ==
X-Received: by 2002:a17:90b:5188:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-306a60e4ac0mr894543a91.4.1743727835579;
        Thu, 03 Apr 2025 17:50:35 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca8768fsm2391935a91.27.2025.04.03.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 17:50:34 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:50:31 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	vivek.kasireddy@intel.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Large folios and filemap_get_folios_contig()
Message-ID: <Z-8s1-kiIDkzgRbc@fedora>
References: <b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com>
 <Z-6ApNtjw9yvAGc4@casper.infradead.org>
 <59539c02-d353-4811-bcbe-080b408f445e@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jdO5iHBsjAZEVpV9"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59539c02-d353-4811-bcbe-080b408f445e@suse.com>


--jdO5iHBsjAZEVpV9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 04, 2025 at 07:46:59AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/4/3 23:05, Matthew Wilcox 写道:
> > On Thu, Apr 03, 2025 at 08:06:53PM +1030, Qu Wenruo wrote:
> > > Recently I hit a bug when developing the large folios support for btrfs.
> > > 
> > > That we call filemap_get_folios_contig(), then lock each returned folio.
> > > (We also have a case where we unlock each returned folio)
> > > 
> > > However since a large folio can be returned several times in the batch,
> > > this obviously makes a deadlock, as btrfs is trying to lock the same
> > > folio more than once.
> > 
> > Sorry, what?  A large folio should only be returned once.  xas_next()
> > moves to the next folio.  How is it possible that
> > filemap_get_folios_contig() returns the same folio more than once?
> 
> But that's exactly what I got from filemap_get_folios_contig():
> 
> lock_delalloc_folios: r/i=5/260 locked_folio=720896(65536) start=782336
> end=819199(36864)
> lock_delalloc_folios: r/i=5/260 found_folios=1
> lock_delalloc_folios: r/i=5/260 i=0 folio=720896(65536)
> lock_delalloc_folios: r/i=5/260 found_folios=8
> lock_delalloc_folios: r/i=5/260 i=0 folio=786432(262144)
> lock_delalloc_folios: r/i=5/260 i=1 folio=786432(262144)
> lock_delalloc_folios: r/i=5/260 i=2 folio=786432(262144)
> lock_delalloc_folios: r/i=5/260 i=3 folio=786432(262144)
> lock_delalloc_folios: r/i=5/260 i=4 folio=786432(262144)
> lock_delalloc_folios: r/i=5/260 i=5 folio=786432(262144)
> lock_delalloc_folios: r/i=5/260 i=6 folio=786432(262144)
> lock_delalloc_folios: r/i=5/260 i=7 folio=786432(262144)
> 
> r/i is the root and inode number from btrfs, and you can completely ignore
> it.
> 
> @locked_folio is the folio we're already holding a lock, the value inside
> the brackets is the folio size.
> 
> @start and @end is the range we're searching for, the value inside the
> brackets is the search range length.
> 
> The first iteration returns the current locked folio, and since the range
> inside that folio is only 4K, thus it's only returned once.
> 
> The next 8 slots are all inside the same large folio at 786432, resulting
> duplicated entries.
> 
> > 
> > > Then I looked into the caller of filemap_get_folios_contig() inside
> > > mm/gup, and it indeed does the correct skip.
> > 
> > ... that code looks wrong to me.
> 
> It looks like it's xas_find() is doing the correct skip by calling
> xas_next_offset() -> xas_move_index() to skip the next one.
> 
> But the filemap_get_folios_contig() only calls xas_next() by increasing the
> index, not really skip to the next folio.
> 
> Although I can be totally wrong as I'm not familiar with the xarray
> internals at all.

Thanks for bringing this to my attention, it looks like this is due to a
mistake during my folio conversion for this function. The xas_next()
call tries to go to the next index, but if that index is part of a
multi-index entry things get awkward if we don't manually account for the
index shift of a large folio (which I missed).

Can you please try out this attached patch and see if it gets rid of
the duplicate problem?

> However I totally agree the duplicated behavior (and the extra handling of
> duplicated entries) looks very wrong.
> 
> Thanks,
> Qu

--jdO5iHBsjAZEVpV9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-Fix-filemap_get_folios_contig-returning-batches-of-i.patch

From 91e8353cee38b1624fc13587f6db5058d764d983 Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Thu, 3 Apr 2025 16:54:17 -0700
Subject: [PATCH] Fix filemap_get_folios_contig returning batches of identical
 folios

filemap_get_folios_contig() is supposed to return distinct folios
found within [start, end]. Large folios in the Xarray become multi-index
entries. xas_next() can iterate through the sub-indexes before finding
a sibling entry and breaking out of the loop.

This can result in a returned folio_batch containing an indeterminate
number of duplicate folios, which forces the callers to skeptically
handle the returned batch. This is inefficient and incurs a large
maintenance overhead.

We can fix this by calling xas_advance() after we have successfully
adding a folio to the batch to ensure our Xarray is positioned such that
it will correctly find the next folio - similar to
filemap_get_read_batch().

Fixes: 35b471467f88 ("filemap: add filemap_get_folios_contig()")
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index cc69f174f76b..bc7b28dfba3c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2233,6 +2233,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 			*start = folio->index + nr;
 			goto out;
 		}
+		xas_advance(&xas, folio_next_index(folio) - 1);
 		continue;
 put_folio:
 		folio_put(folio);
-- 
2.48.1


--jdO5iHBsjAZEVpV9--


Return-Path: <linux-fsdevel+bounces-17216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337AC8A90E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 03:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D752B2821A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5E39AF2;
	Thu, 18 Apr 2024 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZukunNbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95BA40;
	Thu, 18 Apr 2024 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405342; cv=none; b=MLdBinX4afEN0Pv0swMMOjrjHmaxM/RGgehovI/nMjSExgKnXdVlOJW6mQFkUHLB6bYykmqb8VH4d8s3w2BHv5mkD4uDHsA59zf0L+8RiyUgxx5rWhbqsgiAab2bmKoa1HrQYddyA9qIbR2s9a1h97wco18lpuXJXFW5pYX1BU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405342; c=relaxed/simple;
	bh=q+kVwhu/g21GBaLavLAj0hyZPqmWNBa/TerrFUZtsL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUu+MFILC0Uepc00i8j1VaHTM3n9xENrZsfqjS9W8KB4bLP0s9fcVpCao3t1EdNRX5vL2T9DxCGJNNfaZB3my3Dlsq9HN4p7XkEgkvYZgx7ipveNn5Le1WsG20aiiKLhE5OSstA20oippRWwDSZt9pXBUp4BI6Hfb/sRE8QpoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZukunNbG; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4dabbd69c71so86712e0c.1;
        Wed, 17 Apr 2024 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713405340; x=1714010140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIYxpCpWndb+Pn1g+UhMaTaHQTt+klHl035PGII/Rmc=;
        b=ZukunNbGVI6x1WW95yksvP/nif5FmcwmsNMYSYu8lH5lWhvTp3kSkR+1ku1yxzised
         pXF3NE1qz6dj3Q9J7wy4QQjmQhoRfifXtEPDy7ZnDAkhRPVI853AQXYkPNGNVtkUVHMl
         Z+T3mmrlHvac2ivcSpd7kc3w8mMguoutBy4fLKZsYNhXu3B/65RpRj4LwuNyChXhMFbl
         E0r8TY/symH3w0aiJaIaF/UpT4D/K8ObK9atMBTy3WXUqTNjnaJsuNR0FoJO4KSGoKuk
         FHbXUqcjrek/1tuZYmWTas7DP7TgTASVrSXw/JvFbXELEfXrOPjixyuZaFp92xNmP6h1
         jTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405340; x=1714010140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIYxpCpWndb+Pn1g+UhMaTaHQTt+klHl035PGII/Rmc=;
        b=oYwbnEObfotXRGnFR8UR63c7zklqvGf3OWCi/co7uUiEdNRNk2/IAADUUnED222AOT
         EiE6Cslc1q8LNNHi9sliR5T1fEDJE3RamOs5X57OcUhvgbOZuAstJoSQtkNY+XCQc9Nj
         ftAVIp4MDhmyPxveeDZe9YnVsPoXUGAkuBHjkMEiZDozUsQqianw/RXmKhfaWVP/J8WR
         Wnzq/4AuV57w04bxhu7nA1l8z68XoIcfoMP7LMEpdl77Q7KS547x4QVeC4rXMntp3bgV
         KYX77Z9jVNdWYb8xN+lhcECVPiDxVM5zPL4C6B2e5O5g5BfrA1eWkuw+VzA4AnzI+T68
         QDxg==
X-Forwarded-Encrypted: i=1; AJvYcCXxjzBrrskjBlouastmp9QIDYX3iu1a6dbItwRqaQ8wHiZ8sEXSj4Xv8kPLwjfEKbEXIgBngjqYvG89obFw7YHHF8947r8tUNGvU1Xuc+TRU9YLWY2N2ydlvlQtHamS/5ZTBeb7J1aLrBsg9Q==
X-Gm-Message-State: AOJu0YyzZvULFxYgnrjjKsY6UpOQALmuowe8tOLlxR2cTr5wBwsVmnJM
	dnoADro3qRyzLdunDCD+J0NpdjiP8WEJPpIJyQDfWvnxcyg26kuba+HpFSfMWBkgY8lRd4SYxV3
	kVvsH87IswU2Y4gsBd+fi7ISP7YI=
X-Google-Smtp-Source: AGHT+IE6dnCdtVOBvrZIQgJeetrTOkmNikKKZNS/HrJ5ENx/2u35PFSzGZXfhIru9eFLL+J2uUz9TNYElyrTBjswBCg=
X-Received: by 2002:a05:6122:c9b:b0:4d3:34b1:7211 with SMTP id
 ba27-20020a0561220c9b00b004d334b17211mr1612766vkb.3.1713405339781; Wed, 17
 Apr 2024 18:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <20240417160842.76665-8-ryncsn@gmail.com>
In-Reply-To: <20240417160842.76665-8-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Apr 2024 13:55:28 +1200
Message-ID: <CAGsJ_4xv8m-Xjih0PmKD1PcUSGVRsti8EH0cbStZOFmX+YhnFA@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: drop page_index/page_file_offset and convert swap
 helpers to use folio
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:12=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> When applied on swap cache pages, page_index / page_file_offset was used
> to retrieve the swap cache index or swap file offset of a page, and they
> have their folio equivalence version: folio_index / folio_file_pos.
>
> We have eliminated all users for page_index / page_file_offset, everythin=
g
> is using folio_index / folio_file_pos now, so remove the old helpers.
>
> Then convert the implementation of folio_index / folio_file_pos to
> to use folio natively.
>
> After this commit, all users that might encounter mixed usage of swap
> cache and page cache will only use following two helpers:
>
> folio_index (calls __folio_swap_cache_index)
> folio_file_pos (calls __folio_swap_file_pos)
>
> The offset in swap file and index in swap cache is still basically the
> same thing at this moment, but will be different in following commits.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Hi Kairui, thanks !

I also find it rather odd that folio_file_page() is utilized for both
swp and file.

mm/memory.c <<do_swap_page>>
             page =3D folio_file_page(folio, swp_offset(entry));
mm/swap_state.c <<swapin_readahead>>
             return folio_file_page(folio, swp_offset(entry));
mm/swapfile.c <<unuse_pte>>
             page =3D folio_file_page(folio, swp_offset(entry));

Do you believe it's worthwhile to tidy up?

> ---
>  include/linux/mm.h      | 13 -------------
>  include/linux/pagemap.h | 19 +++++++++----------
>  mm/swapfile.c           | 13 +++++++++----
>  3 files changed, 18 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0436b919f1c7..797480e76c9c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2245,19 +2245,6 @@ static inline void *folio_address(const struct fol=
io *folio)
>         return page_address(&folio->page);
>  }
>
> -extern pgoff_t __page_file_index(struct page *page);
> -
> -/*
> - * Return the pagecache index of the passed page.  Regular pagecache pag=
es
> - * use ->index whereas swapcache pages use swp_offset(->private)
> - */
> -static inline pgoff_t page_index(struct page *page)
> -{
> -       if (unlikely(PageSwapCache(page)))
> -               return __page_file_index(page);
> -       return page->index;
> -}
> -
>  /*
>   * Return true only if the page has been allocated with
>   * ALLOC_NO_WATERMARKS and the low watermark was not
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2df35e65557d..313f3144406e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -780,7 +780,7 @@ static inline struct page *grab_cache_page_nowait(str=
uct address_space *mapping,
>                         mapping_gfp_mask(mapping));
>  }
>
> -#define swapcache_index(folio) __page_file_index(&(folio)->page)
> +extern pgoff_t __folio_swap_cache_index(struct folio *folio);
>
>  /**
>   * folio_index - File index of a folio.
> @@ -795,9 +795,9 @@ static inline struct page *grab_cache_page_nowait(str=
uct address_space *mapping,
>   */
>  static inline pgoff_t folio_index(struct folio *folio)
>  {
> -        if (unlikely(folio_test_swapcache(folio)))
> -                return swapcache_index(folio);
> -        return folio->index;
> +       if (unlikely(folio_test_swapcache(folio)))
> +               return __folio_swap_cache_index(folio);
> +       return folio->index;
>  }
>
>  /**
> @@ -920,11 +920,6 @@ static inline loff_t page_offset(struct page *page)
>         return ((loff_t)page->index) << PAGE_SHIFT;
>  }
>
> -static inline loff_t page_file_offset(struct page *page)
> -{
> -       return ((loff_t)page_index(page)) << PAGE_SHIFT;
> -}
> -
>  /**
>   * folio_pos - Returns the byte position of this folio in its file.
>   * @folio: The folio.
> @@ -934,6 +929,8 @@ static inline loff_t folio_pos(struct folio *folio)
>         return page_offset(&folio->page);
>  }
>
> +extern loff_t __folio_swap_file_pos(struct folio *folio);
> +
>  /**
>   * folio_file_pos - Returns the byte position of this folio in its file.
>   * @folio: The folio.
> @@ -943,7 +940,9 @@ static inline loff_t folio_pos(struct folio *folio)
>   */
>  static inline loff_t folio_file_pos(struct folio *folio)
>  {
> -       return page_file_offset(&folio->page);
> +       if (unlikely(folio_test_swapcache(folio)))
> +               return __folio_swap_file_pos(folio);
> +       return ((loff_t)folio->index << PAGE_SHIFT);
>  }
>
>  /*
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4919423cce76..0c36a5c2400f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3419,12 +3419,17 @@ struct address_space *swapcache_mapping(struct fo=
lio *folio)
>  }
>  EXPORT_SYMBOL_GPL(swapcache_mapping);
>
> -pgoff_t __page_file_index(struct page *page)
> +pgoff_t __folio_swap_cache_index(struct folio *folio)
>  {
> -       swp_entry_t swap =3D page_swap_entry(page);
> -       return swp_offset(swap);
> +       return swp_offset(folio->swap);
>  }
> -EXPORT_SYMBOL_GPL(__page_file_index);
> +EXPORT_SYMBOL_GPL(__folio_swap_cache_index);
> +
> +loff_t __folio_swap_file_pos(struct folio *folio)
> +{
> +       return swap_file_pos(folio->swap);
> +}
> +EXPORT_SYMBOL_GPL(__folio_swap_file_pos);
>
>  /*
>   * add_swap_count_continuation - called when a swap count is duplicated
> --
> 2.44.0
>

Thanks
Barry


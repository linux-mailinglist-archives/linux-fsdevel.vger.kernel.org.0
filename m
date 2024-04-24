Return-Path: <linux-fsdevel+bounces-17576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714D38AFEE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 04:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958561C21A11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 02:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B9139CEB;
	Wed, 24 Apr 2024 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJY8zO85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6E84FAA;
	Wed, 24 Apr 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927396; cv=none; b=sU3kE27OO7R1ctagkugqVW96w7/ryf48+0yAtxJCQcfIwv8a1greWkvjaRVEvN6CW3i81hE3wfRyWFQa4oJ9DAtrev1qDIAcgiPx3ScYEnv4OvWDf6f2/+xacbohEHasiumuygpCYM3QxNw97v4Lc5qjaIVyvOcqizQw53BDxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927396; c=relaxed/simple;
	bh=VMJ73HRTSwfxt9Qoy/Gn+rvORVRwhCqItlUMlplMMuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2V/t6LNz9p6cZk4LhclIT0lBELUATs8d66ISZkP48x/9oxyI3Fn/ZsC35b/xBqbXLakYn/8hRzWGvuti4LdulQKKDIxaRcWELLBHMMe+2MJzoPft9PyQB67HTARz6DzgtsHXbH3RiRgwiR4qfrvV2wIlQxNI2hFmyiH7vutyGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJY8zO85; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d872102372so3754501fa.0;
        Tue, 23 Apr 2024 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713927393; x=1714532193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ed5BXb+3yDcaHzMwmV//gTO7icCBen+OQNCtXVGBFI=;
        b=PJY8zO85hUarnebLgKtAnTkHnb5aOqcbfMdcCZJ3qYy0/3Kp4T923Ae+dnxl+V7dqy
         41tLJx2vClG/rUBaZ2OobgW6aMXdKY3URtr8O0qUlBFVd83DcMDOf5Gh8A1TCgbXkS0j
         KNHaVFnKKM3EPAuQZnwkAZpONJVExh+rwdB6ZXjewkuBOcBxEK2mJ9XNGK7EeLHxhJJX
         Fg6qdVQ+yH+t8D8VXBy5sOuDU4W9u0q1OTcKDRgKjlQ/LJULoGexH6/h77+TQJc5E8Q/
         YOeg2s2ivRrZy/vgdFYjV4KRI4GC3cXYKkmi/Q/xbleUxUlLuo1vapqrAxnx35jeF32c
         o69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927393; x=1714532193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ed5BXb+3yDcaHzMwmV//gTO7icCBen+OQNCtXVGBFI=;
        b=ig+rHBwJzzQWn0jFcGbmDu447RgXQVqvstAoUs/Ctxdf5ipozryuOa4q6aWMrWB8vW
         pXfdbG0pMdtuupg4ZFjgzlhttd+alSwjNLhIonIo8eMhqKof8RJr1MdB5Dcv7l58Q/gA
         tk/gx1cVD6RcJJaqH/AMJzADBY4Styt/xiIXpy27eRFrRoPETxqb5BD0rrCpSBgi3/u9
         0+PhiDLaE3gKa5bZloIMCaYnHpmxrdLcAVFSaLU/pP1SwRD88/WULdeB3XVdXAA+uL7k
         ZmctdTF3ycR3uMXFBu0EzaVJzLyUm3pJxGqhJ9MFqunpLYyo2TstceVPtRfUWwQSfZNh
         E/fg==
X-Forwarded-Encrypted: i=1; AJvYcCVOy8eUFeC8ZzcLoGx2Niq5dz+WFA9/33S6vxn4ElHNsNVkYUL46qXdzhHeVvnYRlfSyt3ptkiUO2LEy/rPjYa905JRhOCPD0M0tuud4omrJvSGAJaOgoG/YeXwkZ+mI+kEHB5BVedYljLQXroaem0k4IFiGffo2wsiq90diPN0iup/NpH7pA==
X-Gm-Message-State: AOJu0YwxOivAxiiUOD6cYqHASXfbkYcGeY+ZwYff38GNXdTLiDFT+2OI
	a3oOarfgM8kmhPawnlYBuBadhITsO55XIBnyYsfKgxEuG0H9wWoitjYDIy6W4M9PQecqknQLpjy
	1KaUxS9djDwSSYl6dr7TuNhWGkM0=
X-Google-Smtp-Source: AGHT+IFVKtxLp5hgNBcE7pLqHamYU9crgavsCYxLiK2bSQMn+2ebKbKDEkz9yDM+sacn5LQH4J36EjHpzfhSrPlgcCw=
X-Received: by 2002:a2e:854e:0:b0:2de:2f6e:6375 with SMTP id
 u14-20020a2e854e000000b002de2f6e6375mr418505ljj.4.1713927393077; Tue, 23 Apr
 2024 19:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423170339.54131-1-ryncsn@gmail.com> <20240423170339.54131-8-ryncsn@gmail.com>
 <87sezbsdwf.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sezbsdwf.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 24 Apr 2024 10:56:16 +0800
Message-ID: <CAMgjq7C1panmd2Fq0QvYMMdbj7rPh5znRCqogduNXoGYO7DLFA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] mm: drop page_index/page_file_offset and convert
 swap helpers to use folio
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	linux-afs@lists.infradead.org, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:19=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > There are four helpers for retrieving the page index within address
> > space, or offset within mapped file:
> >
> > - page_index
> > - page_file_offset
> > - folio_index (equivalence of page_index)
> > - folio_file_pos (equivalence of page_file_offset)
> >
> > And they are only needed for mixed usage of swap cache & page cache (eg=
.
> > migration, huge memory split). Else users can just use folio->index or
> > folio_pos.
> >
> > This commit drops page_index and page_file_offset as we have eliminated
> > all users, and converts folio_index and folio_file_pos (they were simpl=
y
> > wrappers of page_index and page_file_offset, and implemented in a not
> > very clean way) to use folio internally.
> >
> > After this commit, there will be only two helpers for users that may
> > encounter mixed usage of swap cache and page cache:
> >
> > - folio_index (calls __folio_swap_cache_index for swap cache folio)
> > - folio_file_pos (calls __folio_swap_dev_pos for swap cache folio)
> >
> > The index in swap cache and offset in swap device are still basically
> > the same thing, but will be different in following commits.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/mm.h      | 13 -------------
> >  include/linux/pagemap.h | 19 +++++++++----------
> >  mm/swapfile.c           | 13 +++++++++----
> >  3 files changed, 18 insertions(+), 27 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0436b919f1c7..797480e76c9c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2245,19 +2245,6 @@ static inline void *folio_address(const struct f=
olio *folio)
> >       return page_address(&folio->page);
> >  }
> >
> > -extern pgoff_t __page_file_index(struct page *page);
> > -
> > -/*
> > - * Return the pagecache index of the passed page.  Regular pagecache p=
ages
> > - * use ->index whereas swapcache pages use swp_offset(->private)
> > - */
> > -static inline pgoff_t page_index(struct page *page)
> > -{
> > -     if (unlikely(PageSwapCache(page)))
> > -             return __page_file_index(page);
> > -     return page->index;
> > -}
> > -
> >  /*
> >   * Return true only if the page has been allocated with
> >   * ALLOC_NO_WATERMARKS and the low watermark was not
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 2df35e65557d..a7d025571ee6 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -780,7 +780,7 @@ static inline struct page *grab_cache_page_nowait(s=
truct address_space *mapping,
> >                       mapping_gfp_mask(mapping));
> >  }
> >
> > -#define swapcache_index(folio)       __page_file_index(&(folio)->page)
> > +extern pgoff_t __folio_swap_cache_index(struct folio *folio);
> >
> >  /**
> >   * folio_index - File index of a folio.
> > @@ -795,9 +795,9 @@ static inline struct page *grab_cache_page_nowait(s=
truct address_space *mapping,
> >   */
> >  static inline pgoff_t folio_index(struct folio *folio)
> >  {
> > -        if (unlikely(folio_test_swapcache(folio)))
> > -                return swapcache_index(folio);
> > -        return folio->index;
> > +     if (unlikely(folio_test_swapcache(folio)))
> > +             return __folio_swap_cache_index(folio);
> > +     return folio->index;
> >  }
> >
> >  /**
> > @@ -920,11 +920,6 @@ static inline loff_t page_offset(struct page *page=
)
> >       return ((loff_t)page->index) << PAGE_SHIFT;
> >  }
> >
> > -static inline loff_t page_file_offset(struct page *page)
> > -{
> > -     return ((loff_t)page_index(page)) << PAGE_SHIFT;
> > -}
> > -
> >  /**
> >   * folio_pos - Returns the byte position of this folio in its file.
> >   * @folio: The folio.
> > @@ -934,6 +929,8 @@ static inline loff_t folio_pos(struct folio *folio)
> >       return page_offset(&folio->page);
> >  }
> >
> > +extern loff_t __folio_swap_dev_pos(struct folio *folio);
> > +
> >  /**
> >   * folio_file_pos - Returns the byte position of this folio in its fil=
e.
> >   * @folio: The folio.
> > @@ -943,7 +940,9 @@ static inline loff_t folio_pos(struct folio *folio)
> >   */
> >  static inline loff_t folio_file_pos(struct folio *folio)
> >  {
> > -     return page_file_offset(&folio->page);
> > +     if (unlikely(folio_test_swapcache(folio)))
> > +             return __folio_swap_dev_pos(folio);
> > +     return ((loff_t)folio->index << PAGE_SHIFT);
>
> This still looks confusing for me.  The function returns the byte
> position of the folio in its file.  But we returns the swap device
> position of the folio.

Thanks for the comment.

This doesn't look too confusing to me, __folio_swap_dev_pos ->
swap_dev_pos also returns the byte position of the folio in swap
device. If we agree swap device is kind of equivalent to the page
cache file here, it shouldn't be too hard to understand.

>
> Tried to search folio_file_pos() usage.  The 2 usage in page_io.c is
> swap specific, we can use swap_dev_pos() directly.

The 2 usage in page_io.c is already converted to use swap_dev_pos
directly in this series (patch 6/8).

>
> There are also other file system users (NFS and AFS) of
> folio_file_pos(), I don't know why they need to work with swap
> cache. Cced file system maintainers for help.
>

Thanks, I'm not very sure if we can just drop folio_file_pos and
convert all users to use folio_pos directly. Swap cache mapping
shouldn't be exposed to fs, but I'm not confident enough that this is
a safe move. It looks OK to do so just by examining NFS code, but
let's wait for feedback from FS people.


Return-Path: <linux-fsdevel+bounces-4728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5BE802BA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 07:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1200CB207A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F0F9DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBNd0IZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE34D95
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 21:57:51 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da077db5145so1768071276.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 21:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701669471; x=1702274271; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hljZSc6Iw8axzsRJGckoJxavG2ruOfbHtkaDlvFXcNE=;
        b=wBNd0IZVMRxheG8ELCP4vwvFdkuED+i0fdBN0b5kpC/Bp4TBoMbTBN3BdInrIcNCVL
         LqLdWVlRfvlcVxD0J2OI/ftFCQebo9uxklfzRrh1tV7X69JsEe0HIV0YmqkNF3nAeT4C
         f7lFIifwaihkwwVWuJIEZEHwtXYJrZFP8DaZAE/ofQUexbX/I4m4BAgWkxVpR23uEU4r
         SVCmCPmVlKoql4Ne/mdgtinzSm70jrZj9U08Fswlb6cIBRZOFirQNiRpri4ccguBP6ih
         5LZ2oOso2WSVxwTlDHvBl50oEL8HMmP9EGGIYaApkmT/dmIZJ/Vr3IAtW/ma30ezFzGo
         UKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701669471; x=1702274271;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hljZSc6Iw8axzsRJGckoJxavG2ruOfbHtkaDlvFXcNE=;
        b=ITzMn6G4ZdBH6/hx9qsokk7hafPJK1KsAteA/b+t2rJGmHPbcKlNQVgTJI/FM0SnVB
         e0zn7IWNXDiRYGHHqv2YXB2dfoxvh+GCu7uzjyhbYQkhT3xWyWXerD7kMGnL5q6QnjVe
         kqvl76yq/in6UkTS0g/OleYow84BorJQGnx+P+FzzxHGSSOiAOgNEoqRQ05G6Co4Cv52
         FtN4iWz93pWpLa/gdiXyeJyeD5KriH8n6kqj8msO7ewMq7pwGHYE7l39clj4qI7INBX9
         B4HQksbTge+jZEvsn2LoQAmcwyw6OD4u3FLkIZCZ2fG55KaQjN0EwFrhDa4ojzVj2ux2
         CFgw==
X-Gm-Message-State: AOJu0YzxaA8rHOsymW4ad41e3DOmWGhzqNwXfJwPsxtxovY06lpEDnkr
	TbjJtyeL+m5lHisTSYX3NF3DgA==
X-Google-Smtp-Source: AGHT+IErrC2fVEOiFNM0fm0IodRxybPjhgsnZN0Y7pi9GzEISRQTL+uaJW3arAs7Poa+LIAT0LfPnA==
X-Received: by 2002:a25:33d7:0:b0:da0:411b:ef19 with SMTP id z206-20020a2533d7000000b00da0411bef19mr25509511ybz.1.1701669470889;
        Sun, 03 Dec 2023 21:57:50 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z28-20020a25ad9c000000b00d9ca7c2c8e2sm2109381ybi.11.2023.12.03.21.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:57:49 -0800 (PST)
Date: Sun, 3 Dec 2023 21:57:38 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Matthew Wilcox <willy@infradead.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>, 
    Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, 
    Hugh Dickins <hughd@google.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: Issue with 8K folio size in __filemap_get_folio()
In-Reply-To: <ZW0LQptvuFT9R4bw@casper.infradead.org>
Message-ID: <90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com>
References: <B467D07C-00D2-47C6-A034-2D88FE88A092@dubeyko.com> <ZWzy3bLEmbaMr//d@casper.infradead.org> <ZW0LQptvuFT9R4bw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 3 Dec 2023, Matthew Wilcox wrote:
> On Sun, Dec 03, 2023 at 09:27:57PM +0000, Matthew Wilcox wrote:
> > I was talking with Darrick on Friday and he convinced me that this is
> > something we're going to need to fix sooner rather than later for the
> > benefit of devices with block size 8kB.  So it's definitely on my todo
> > list, but I haven't investigated in any detail yet.
> 
> OK, here's my initial analysis of just not putting order-1 folios
> on the deferred split list.  folio->_deferred_list is only used in
> mm/huge_memory.c, which makes this a nice simple analysis.
> 
>  - folio_prep_large_rmappable() initialises the list_head.  No problem,
>    just don't do that for order-1 folios.
>  - split_huge_page_to_list() will remove the folio from the split queue.
>    No problem, just don't do that.
>  - folio_undo_large_rmappable() removes it from the list if it's
>    on the list.  Again, no problem, don't do that for order-1 folios.
>  - deferred_split_scan() walks the list, it won't find any order-1
>    folios.
> 
>  - deferred_split_folio() will add the folio to the list.  Returning
>    here will avoid adding the folio to the list.  But what consequences
>    will that have?  Ah.  There's only one caller of
>    deferred_split_folio() and it's in page_remove_rmap() ... and it's
>    only called for anon folios anyway.

Yes, the deferred split business is quite nicely localized,
which makes it easy to avoid.

> 
> So it looks like we can support order-1 folios in the page cache without
> any change in behaviour since file-backed folios were never added to
> the deferred split list.

Yes, you just have to code in a few "don't do that"s as above.

And I think it would be reasonable to allow even anon order-1 folios,
but they'd just be prevented from participating in the deferred split
business.

Allowing a PMD to be split at any time is necessary for correctness;
then allowing the underlying folio to be split is a nice-to-have when
trying to meet competition for memory, but it's not a correctness issue,
and the smaller the folio to be split, the less the saving - a lot of
unneeded order-1s could still waste a lot of memory, but it's not so
serious as with the order-9s.

> 
> Now, is this the right direction?  Is it a bug that we never called
> deferred_split_folio() for pagecache folios?  I would defer to Hugh
> or Kirill on this.  Ccs added.

No, not a bug.

The thing with anon folios is that they only have value while mapped
(let's ignore swap and GUP for simplicity), so when page_remove_rmap()
is called in the unmapping, that's a good hint that the hugeness of
the folio is no longer worthwhile; but it's a bad moment for splitting
because of locks held, and quite possibly a stupid time for splitting
too (because just a part of unmapping a large range, when splitting
would merely slow it all down).  Hence anon's deferred split queue.

But for file pages, the file contents must retain their value whether
mapped or not.  The moment to consider splitting the folio itself is
when truncating or punching a hole; and it happens that there is not
a locking problem then, nor any overhead added to eviction.  Hence no
deferred split queue for file.

Shmem does have its per-superblock shmem_unused_huge_shrink(), for
splitting huge folios at EOF when under memory pressure (and it would
be better if it were not restricted to EOF, but could retry folios
which had been EBUSY or EAGAIN at the time of hole-punch).  Maybe
other large folio filesystems should also have such a shrinker.

Hugh


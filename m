Return-Path: <linux-fsdevel+bounces-60025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E73B40F46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 23:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6F701DA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0410C2E973D;
	Tue,  2 Sep 2025 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDyQP3XY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B28272E45;
	Tue,  2 Sep 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847978; cv=none; b=JY6iY+OPKP6cyl3VJ0nhMWXAagZWB280VAV3QSESOsH2jhRcbTobR7dImKgDf2NLtzjd+mpB6yrwRf60doe88weg82wKYtw4v7LTG5JcyuVXcToeB6ws8Dg8T8oE9+UzCAB8P7ROEFRnNHA1eFZ3UwvAgGMhPTsc0QbjWAjEBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847978; c=relaxed/simple;
	bh=wlESCBpf6fpNyQ15yaNJsCS9M1mxIm7HjEFG+LBWkt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRKGt+VRFzXYMy6ysPvOFTs7QSe5IGiIX5t+cv/7HDq7palx4L6PxTwwlY19nNpODhdtxu2aPXkL+iAb6vaefM5ZSOWj1XNzirsSQC01nFTCrCZj3TEtQyzxjrxpijZn6WDchiaj9jLjRkb6QvM7M54gnhjD18tepfgcv+pXITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDyQP3XY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b30d24f686so1644591cf.1;
        Tue, 02 Sep 2025 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756847976; x=1757452776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wvRB7Ootu5MU4cCYlO+ftFPAr4ZDRF70lEv1HlXolQ=;
        b=ZDyQP3XYKBclyzSxCtuFkXjd9cIXKSqnLZ0jv8OYQ/pbS4rC1puZ4aqGvYfjOUmilC
         s9EpJbuyxhe3e69OzqQXacLci0RXXLCSapfwA8yOA4TvnGmE00Ak6UbF14rgCBPf7ZcP
         GXBLPZTAT0J1rRdybdruHxvHH5KON03utNVDN2VBL3WE/N5j/gXl0OdLG6CYdhGCLuR4
         4/nKdFTvL6wK5jYKHCViUn5NfUXB4OQu6rKdbw/r+0YnVjwFFOI2IZK9dgKnaLbtB+53
         X+JppNawVWLWuUvTEp9NJkahwqQycImwA95CBFDV4KpDZGgx10WUX6EboSgW0MFVT0TN
         BLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756847976; x=1757452776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wvRB7Ootu5MU4cCYlO+ftFPAr4ZDRF70lEv1HlXolQ=;
        b=O1e3buqCUT/gyVFWLA8lLbHHNR1El+R/msYW7U/W5g3Rom2zx1ABe+Ns7HKf1UccAY
         FllzyKMHoZkl7eZQgPLavUpz1uBnGWlVozr4vlZI24CW//WVtohYzih16jKaIccPHDoG
         Lof9kOMSLkYcMcMWIuRPbFYGHNfZi+ZDHuLuBhMU5eWV5L+iTPTTWFtg/6xmC0sncilB
         yhWnbjHDovZu8wDtgIBjnDDz8XdbKnOllALCxNlKD3+MnSElFJ5eTP2ffnR4oYEjbweh
         ledm0qitkmMLOMFNMVsMLogWIKVmg/w6yxfkzO2s5kZhGSN4btyMFniV0/KnSjZt7Qc8
         oLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+YNXae2zbPfPv5JSKw7Z0uDFPCF2tnG/5qQu4J8xF1ZBUFKZFb4dobDz+KlBH1aUIJjeRjRArkwY=@vger.kernel.org, AJvYcCWY6l9ZfvbpBAmRzZcK+DmLn4+t7olIRf98VWV8OP2U0xUlRIeK7RAjp3EwkSwpnXjq8oAJRju4RWTmhh7KBw==@vger.kernel.org, AJvYcCWzLmStNdx+82vA9oy/nOAKRkz1iSDOzlSfzol+Tcx841LcHg9f9BEZRfa5BmI/x4QQm7ANO7ubfFqk@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4gJBVzkajvt/Xrf8lwtclPoEJxpNqGF+Ihz3SajJMtsjhbUz
	mXK1Il/WYTkTcEmC3ON4AdnNJIuzeoccKyhWozYETl9zAiyKkAXko1E+7vivjCwNZeaxAeqiaZn
	tm5vtHQEObEDWBUijPRt/FipLH3LYZIw=
X-Gm-Gg: ASbGncsFfYlX+U3ADhMHk/dS17FGbpqi1fUAUO9KbHMjgWwoL1dnGCVcoPzPx4LAW4s
	i8wzcx7oqwGMRlwwX1NTqj3F9DwYzoYEg0dLW2dQxeqApGi/tE9piodbr2bct3Qrj8DQGs8vHwu
	6lOFzyPNBvvYyDDJCQhH0k2zy54gBnEJHpCNFTQlpzH+w+uA4lzFgOKrqt7NzgcGBrZfxHf+Cqo
	ochoUPujIFYdjB2lQc=
X-Google-Smtp-Source: AGHT+IECYb8qdqFkdeFmceBuJ1+wkNNeZNoXWf9c0mMV1yEdpCAgHcUhhXG2FHXfgk9HT0mOeXO/9XVTe/daaUVrfDE=
X-Received: by 2002:ac8:5702:0:b0:4b2:dff3:7460 with SMTP id
 d75a77b69052e-4b31d7f0621mr133727081cf.12.1756847975656; Tue, 02 Sep 2025
 14:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-17-joannelkoong@gmail.com> <CAJfpegvjaNZSJcyNWxyz0gQk-_9AXqcPuX71m7yoT2s0cd53iw@mail.gmail.com>
In-Reply-To: <CAJfpegvjaNZSJcyNWxyz0gQk-_9AXqcPuX71m7yoT2s0cd53iw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 14:19:24 -0700
X-Gm-Features: Ac12FXyhUg50dwPlmhaxJj6upBwpCBcHFVHb8UYhMpXyiY42cCjLakrlObzKJnc
Message-ID: <CAJnrk1a+CV4B5Lyfaodmf7NAUYhn4phcEp0Xcqdj4VH==5jZwg@mail.gmail.com>
Subject: Re: [PATCH v1 16/16] fuse: remove fuse_readpages_end() null mapping check
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:22=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Sat, 30 Aug 2025 at 01:58, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> >
> > Remove extra logic in fuse_readpages_end() that checks against null
> > folio mappings. This was added in commit ce534fb05292 ("fuse: allow
> > splice to move pages"):
> >
> > "Since the remove_from_page_cache() + add_to_page_cache_locked()
> > are non-atomic it is possible that the page cache is repopulated in
> > between the two and add_to_page_cache_locked() will fail.  This
> > could be fixed by creating a new atomic replace_page_cache_page()
> > function.
> >
> > fuse_readpages_end() needed to be reworked so it works even if
> > page->mapping is NULL for some or all pages which can happen if the
> > add_to_page_cache_locked() failed."
> >
> > Commit ef6a3c63112e ("mm: add replace_page_cache_page() function") adde=
d
> > atomic page cache replacement, which means the check against null
> > mappings can be removed.
>
> If I understand correctly this is independent of the patchset and can
> be applied without it.

Yes, this and patch 05/16 ("iomap: propagate iomap_read_folio() error
to caller"), patch 08/16 ("iomap: rename iomap_readpage_iter() to
iomap_readfolio_iter()"), and patch 09/16 ("iomap: rename
iomap_readpage_ctx struct to iomap_readfolio_ctx") in the series are
independent from fuse iomap read/readahead functionality.

My thinking was that it would be more cohesive to have everything in
one place so that there's less patches scattered about, but I'm
realizing now it probably was just more confusing than helpful.

Thanks,
Joanne

>
> Thanks,
> Miklos


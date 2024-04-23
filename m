Return-Path: <linux-fsdevel+bounces-17546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527B8AF6E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 20:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F2AB23721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163213EFE5;
	Tue, 23 Apr 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBI1JjY2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8413D522;
	Tue, 23 Apr 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898103; cv=none; b=YV09xK25HFszIdjYX+zlN10Bdk6QWy52aChrf2P9goWnvzd1md+jYC4Ow9HMwZugX9+h7EgIZX8Vb66kv3uAC5GoHj38d/sqeZS3cK2esWKtrFKHnhvBZgPyChz23pqzkUglelOcyj+w+C+0nPiruyAF679GUdvjDampa5vfbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898103; c=relaxed/simple;
	bh=d0ytp+9edLLYzkGEesnI0RtDlRfZNkUxCjRGJ6ynGPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2lIi+BIRKogV1oADlweV828SR4+mi0kizwwZal1piw8at1Ff4K7tCkz94yVtFosMvk0df+uSh/swVTEHo/GgqeXDISVsEIKsMlZYBWgzYHKxYgEYqINVTvVVO4rHF9A0ffqP51X7F5Yxsim21Ypeyl/itMTfpDLCAmB0LI2baE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBI1JjY2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51acc258075so5261146e87.2;
        Tue, 23 Apr 2024 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713898100; x=1714502900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSq7luXdn6BPSJxjU3yQC+GkFBc6W+zPaM7tp0Vg2Uw=;
        b=aBI1JjY2QUdglP2vGes0RtU0SoOBxmuS/ZoFR5b7J6gJQF0QO9sXp0/7vPaF4vprxe
         A5Vb5f1YzdNLI12Hx6GsyazF7PVbp9YneUC8wYCFAN2MN3FnnKDLJJ+aJsCi+jzkuSDo
         PFqvIFG2RZ2Ay+09ZncIdN/iUd/TQCtJzxDazx6q5+RuCypvFA1zAX69EgJuV3Mjzztt
         YPVRTR9FW2dqyrkrpaycyuUvyV0qODr1PcrW9smb7eA9B/63Rgtwn82/6DTQK5nTj8yW
         BV+jjJizj5O87nQFNQaCBbpwSzn1yt5wgq6fr6QJPVQXHpyKCtxyh2xTAvHmmy/ebnpL
         XGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713898100; x=1714502900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSq7luXdn6BPSJxjU3yQC+GkFBc6W+zPaM7tp0Vg2Uw=;
        b=Q4ys5f10rYJfnY270S7DFBD/R2VTKE1hZXDvZoUMw0++63MWfclZqgpuvLARGHYsLY
         04hpR32BwstIXg2oifFgFpxLMMHtRN3rIpAoTauLfUYNApqAyKmYFt2nv9LE0l4d06Bb
         88se1SC5CEmoYtgygdj0y055DJbG67N2tugzEyMzlcG0LZl3KiejZgUcJR71bP11pNYT
         NENpCGL2B0cFk2YRIUvHDaefsr2UaObyBZJeB+k3ZmEkjqfIuu6VlfXW+Tt4bHwzzqxC
         Spm0GuLdVxvmMG1ngllk5AG2y+aNx9y2Ka6+nW8DNtRrPoFA1l9gjTfBoOpulRTo9/2Y
         aurg==
X-Forwarded-Encrypted: i=1; AJvYcCXJlx1w4HGvYhHCH6+HkHyHV5pBhxWouSu2KkBIZaHuNxwB4Ey9i97piFNzynxZU1QjuFAs60esFdERzHuSPzAqde1GgAma4dGO/FbYIdySYhtlnYr8tj0eFShgV4wwgGZMbnYlI5XEiYoVCz19X3jSIvuCKn+qT94H5f1LGDoGUHMk8HXLsSM2
X-Gm-Message-State: AOJu0YxhTI3OBVSLaFrNdWk5UaeagBuTnBUij3Gyn9ZUC34BqjpCN/ag
	1y+DpjcfoeNlMBIf0nezbwgKg5bMsBkHJ/pPoYUBYr6IEWN/fFIj3zurCuHjaVnhqYqyaUIqEgk
	txsdLoDh8vQpIR/lpo7LUYLo0z+A=
X-Google-Smtp-Source: AGHT+IGUoFhNSew0Yy0iLsYTAiY/DuKVzOGfBQ6jFOlqajMER/+FZyTNlMfqUMJb10jORlLj0rJaOiXlV/EB8Fx2xcc=
X-Received: by 2002:ac2:4841:0:b0:51a:cfca:ca3f with SMTP id
 1-20020ac24841000000b0051acfcaca3fmr291201lfy.36.1713898100187; Tue, 23 Apr
 2024 11:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423170339.54131-1-ryncsn@gmail.com> <20240423170339.54131-3-ryncsn@gmail.com>
In-Reply-To: <20240423170339.54131-3-ryncsn@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 24 Apr 2024 03:48:03 +0900
Message-ID: <CAKFNMomTmSJ=QTjTps=v9WkuEo112AT3DmEum-kNGv6pm6nghA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] nilfs2: drop usage of page_index
To: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:04=E2=80=AFAM Kairui Song wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> page_index is only for mixed usage of page cache and swap cache, for
> pure page cache usage, the caller can just use page->index instead.
>
> It can't be a swap cache page here (being part of buffer head),
> so just drop it, also convert it to use folio.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> ---
>  fs/nilfs2/bmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index 383f0afa2cea..9f561afe864f 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -453,8 +453,7 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap=
 *bmap,
>         struct buffer_head *pbh;
>         __u64 key;
>
> -       key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> -                                        bmap->b_inode->i_blkbits);
> +       key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkb=
its);
>         for (pbh =3D page_buffers(bh->b_page); pbh !=3D bh; pbh =3D pbh->=
b_this_page)
>                 key++;

This conversion mixes the use of page and folio within the function.
Would you like to take the opportunity to convert
"page_buffers(bh->b_page)" to "folio_buffers(bh->b_folio)" as well?

Thanks,
Ryusuke Konishi


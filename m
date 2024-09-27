Return-Path: <linux-fsdevel+bounces-30292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408A988CA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38EE1C20F0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724E41B6523;
	Fri, 27 Sep 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB0eG62K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6218C031
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727477746; cv=none; b=imyjQFxqcUZC25lf4LtK8Dc/X+5Ep2k5LfOURIacnZeigwKN819OJ/Tkiex0ikUHq8CBKoRNMsLcKKXqj8acbojbDsz3vpqNWJaz6YW954Un5SmYlm+/rilhvYZTw57sr2YY7476G+KH3R5elv4tCwVHpR/57qNfcJDB3ksUUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727477746; c=relaxed/simple;
	bh=96up2SCZDTkM0wSO8oqd3jm+16qtL7hGjtHFomduThY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo75nTfnhRo6P2JdUjx9lfIeQFSWvOZn1Vgqm2/i06l149DlQTqy92Tw/bSwqqtOR3YbixcDpJOO4pg8k0UMUeeHPeVKQPhhRz2XDRxIsBr4YwDthdFxfJ8BmypPHyPuO4IyAS1bfDn/mWzVXP54QZphGMyGumuYtv5sNESJYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB0eG62K; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-458362e898aso18190941cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727477744; x=1728082544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No1z1VeTVpx6xlJIjgojgXoJMxlMXo6aP1MAZIH8mrs=;
        b=HB0eG62KV9gUfcx2H8ULJUxOWujhrklJr2VdMbVptwfy3XKUfxCLTJQJclA6syI8sl
         zF+P29qPGi0bWeNmG1iSVtu3JhuEGG3QeIN+S1ZBoFxuwRZSmdzze1UmCbWlUmQs5bmL
         VGb3CfSA5rqBqYiDDjhG9ez0vDSbfKPAvN3hr+q9cnjBT8xMAovzGP/8k2wUBBHgnP/H
         6qU5A2sCJ/KrtKhWwhvasu2eR0HXIo8WzOcHl7tJzOFBPnOgDHcoD/O3yDz03VfJPOFz
         s5dDkVnHcFwlPKq49IIfvsW6M7ivkbJ8Epyy43a7i6g3I5lkPnXyTHbBcA6c+fuLSWFN
         uCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727477744; x=1728082544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=No1z1VeTVpx6xlJIjgojgXoJMxlMXo6aP1MAZIH8mrs=;
        b=fh0kntrvjUpkpTRmcGah0Z0EP56WppjloUOvFP7w9KHnbnNshU2pTI1fzrb79aXnTO
         tTP+2JzEDhX0jpamckuKhp5x8Xm1QNLLYwBPJspKP0mz/e4e287BQmMvN1D/9ngkDDql
         I9++zIb136gQjgE5QVsLC8IztY8gXLJmQVnwOVlfzd/+sj0+xZ5adLbVPzO3Q8bQhJ92
         rMtYsBaJ/GGYeyhf1Zktcb84IFPtONvBaWKlPKYnjKFfBcCvlXX1zYjK91i+Kot6jnTH
         l9gxqeMYkATUKgF0Rez1O8ZSAV45xPYl5VbOZI1q1hcZzhWKvQMybmHJy8Cn1qPoYMru
         PEdw==
X-Gm-Message-State: AOJu0YzTqDuSr2zb8NhLFXSHI+8dxk0E+RXZcZPWL8vEZ0Z/2YwMpYgN
	f6f1gctDbX4rV7XOXTraheJ1NM9Zj8KKHR+rqqqPo9Jb3fWpi9nP0mOZMbAHsIP/7e0yeujiEaH
	f4NwwFosRce0OZvytfCgLC08NZ34=
X-Google-Smtp-Source: AGHT+IFsigWdnQvX148hqCsk8OzoCbtgqtVXAEnMScEXNYLOvoj9wSeCrWqK3k+/sB/oRge0xXUSrOGiI+neRyrNwEI=
X-Received: by 2002:ac8:5843:0:b0:458:4311:f15 with SMTP id
 d75a77b69052e-45c9f285c1bmr74879821cf.44.1727477744221; Fri, 27 Sep 2024
 15:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <622c8c01307fdaa9e9da254b5695eb082261b4a3.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <622c8c01307fdaa9e9da254b5695eb082261b4a3.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 15:55:33 -0700
Message-ID: <CAJnrk1Y=vNg1axgpBaBCep-dELW1N2pd4mO8uFXYoO1bVo63PQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] fuse: convert fuse_writepage_need_send to take a folio
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:54=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> fuse_writepage_need_send is called by fuse_writepages_fill() which
> already has a folio.  Change fuse_writepage_need_send() to take a folio
> instead, add a helper to check if the folio range is under writeback and
> use this, as well as the appropriate folio helpers in the rest of the
> function.  Update fuse_writepage_need_send() to pass in the folio
> directly.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>


> ---
>  fs/fuse/file.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8a4621939d3b..e02093fe539a 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -483,14 +483,19 @@ static void fuse_wait_on_page_writeback(struct inod=
e *inode, pgoff_t index)
>         wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index))=
;
>  }
>
> +static inline bool fuse_folio_is_writeback(struct inode *inode,
> +                                          struct folio *folio)
> +{
> +       pgoff_t last =3D folio_next_index(folio) - 1;
> +       return fuse_range_is_writeback(inode, folio_index(folio), last);
> +}
> +
>  static void fuse_wait_on_folio_writeback(struct inode *inode,
>                                          struct folio *folio)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> -       pgoff_t last =3D folio_next_index(folio) - 1;
>
> -       wait_event(fi->page_waitq,
> -                  !fuse_range_is_writeback(inode, folio_index(folio), la=
st));
> +       wait_event(fi->page_waitq, !fuse_folio_is_writeback(inode, folio)=
);
>  }
>
>  /*
> @@ -2262,7 +2267,7 @@ static bool fuse_writepage_add(struct fuse_writepag=
e_args *new_wpa,
>         return false;
>  }
>
> -static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page *=
page,
> +static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio =
*folio,
>                                      struct fuse_args_pages *ap,
>                                      struct fuse_fill_wb_data *data)
>  {
> @@ -2274,7 +2279,7 @@ static bool fuse_writepage_need_send(struct fuse_co=
nn *fc, struct page *page,
>          * the pages are faulted with get_user_pages(), and then after th=
e read
>          * completed.
>          */
> -       if (fuse_page_is_writeback(data->inode, page->index))
> +       if (fuse_folio_is_writeback(data->inode, folio))
>                 return true;
>
>         /* Reached max pages */
> @@ -2286,7 +2291,7 @@ static bool fuse_writepage_need_send(struct fuse_co=
nn *fc, struct page *page,
>                 return true;
>
>         /* Discontinuity */
> -       if (data->orig_pages[ap->num_pages - 1]->index + 1 !=3D page->ind=
ex)
> +       if (data->orig_pages[ap->num_pages - 1]->index + 1 !=3D folio_ind=
ex(folio))
>                 return true;
>
>         /* Need to grow the pages array?  If so, did the expansion fail? =
*/
> @@ -2308,7 +2313,7 @@ static int fuse_writepages_fill(struct folio *folio=
,
>         struct folio *tmp_folio;
>         int err;
>
> -       if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) =
{
> +       if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
>                 fuse_writepages_send(data);
>                 data->wpa =3D NULL;
>         }
> --
> 2.43.0
>
>


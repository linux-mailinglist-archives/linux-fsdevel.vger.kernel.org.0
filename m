Return-Path: <linux-fsdevel+bounces-30287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E3988C60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 00:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BB81F21DB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40518732E;
	Fri, 27 Sep 2024 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh4zuQq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB41F931
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727475759; cv=none; b=QQDzc8TeK6GiG6hB6hyY34m1/A3Ibqelq6WOsJDG0jsLUpQ+8pAzJDCbH5g8wsBf0yvUUb/kABnEqMk44am4jULJvdrB4qiH/FiWY+GuQ+KJoE65+1z5JozlJsdB609RnpSzCDtAKe1gyHp5344yZ9mYt0r+fMcq+c7YniNS0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727475759; c=relaxed/simple;
	bh=DhnkrmnGzBOqt8kqpnt+7VSBHA0tlU1dWrU+DdHM6RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYbZOlRkaH1sM5tuqyrcit+BCmcBf4O6lCWqV0TFh65s/U6Q/51EP37gih/n7mEUiQ3Gm6Fm1Mt3ifyPKLoG9WS/aSd2aTSJOqG3lYH+/ldYPE3JGatHJtKZ3gBZDenhax7yQy7TZZCVsfHHc5uUEfpR0IC/NTo7ZRQc+LI0kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh4zuQq4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582face04dso24407431cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727475757; x=1728080557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6piYYRScne2+Fn2MTXhxchgKXv5F2DjgfSdHuokrUM=;
        b=Eh4zuQq4bvQ1+Ce72PCxMFzXa69mG6L1w2S3JCwnuhy4gceW8oWawcmfvFz++XwQox
         OyFMfSHmAF4R8Z/Y141S3PQxBUrZZwcZfKlbrRoU9lFwkJdq+eRbnO8fr884HuY6sCtx
         on2t0b/4IJvVQ7Y2X+7x+oL9E6DsyojeKzpMH/k9Llt68RzPYPl7XV244ZJu9nq2TzKp
         4NI19kw0SfNwfwJzvWCEVqgtDarah9Oe0AEvsF8wHXxNMSnTmI9qVefDklL0OiIbq/o1
         hftReD3eSBgvko7Dr0il9R+WVKoJqxlgxtvpBeClsi72r92srPxiXhPgMJUnnsltbVuF
         VOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727475757; x=1728080557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6piYYRScne2+Fn2MTXhxchgKXv5F2DjgfSdHuokrUM=;
        b=CNDDaOl/98XVK1wKT8Kqx/BufhP6SyNC9h71Yl4o/hQPHm39ihyIJ3AvQSECoExNUc
         xB2WzcM6Y8dG6k5a8OQ9mG9EZKQJzp+RoWDKLnONgAra+u6SFHiBbkFb1RJ4rH0EdaCt
         bb91RxSlOfSSfvqj6XJWFa0YX4F/KictQftgu5iNPl+wL93CPova+J5GYWcWVk5IVGPL
         eUdqSqSQUjBJc4TgHxoF8UXJCz995ZIg3fs/olRLtbXXWc3ral+gIz9S8oM95Gx0Z+CG
         AshUcjzkFvcImyGvpFJDOp0fmUXChIEeLPCnz9l+IAQGKz5UwXXTeZ6uv2zHPssGxNs7
         xi0w==
X-Gm-Message-State: AOJu0YwSsw7xMyv4SzSyVrSFJR3womMu32cohGJQp72wUWVAGz3njQcA
	FigkRxDQ3Q7xZ3DSBiij/Dj5Nl1DVAOO3F0b9pMmOZO1hk6/qSFP16pETpVkw84lPABgkHW8qcb
	5Md1l2lQtwjEMBMuI3LqLcBH+boc=
X-Google-Smtp-Source: AGHT+IFETtOuZly0aqTxeIaeLmEI+LkPu+XcljF+hBiU3UMFGzE9/BWbIPEPAsPm1JS/7oY0nTZylkt5fjgVOLRsCMQ=
X-Received: by 2002:ac8:57c4:0:b0:458:2e58:46d with SMTP id
 d75a77b69052e-45c94975cdemr152564151cf.12.1727475756643; Fri, 27 Sep 2024
 15:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <ffa6fe7ca63c4b2647447ddc9e5c1a67fe0fbb2d.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <ffa6fe7ca63c4b2647447ddc9e5c1a67fe0fbb2d.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 15:22:25 -0700
Message-ID: <CAJnrk1bELT0PwOQFzKYryEYQgpJiZ3fyUjERaWH4f+NgM1oirg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] fuse: convert readahead to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:45=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Currently we're using the __readahead_batch() helper which populates our
> fuse_args_pages->pages array with pages.  Convert this to use the newer
> folio based pattern which is to call readahead_folio() to get the next
> folio in the read ahead batch.  I've updated the code to use things like
> folio_size() and to take into account larger folio sizes, but this is
> purely to make that eventual work easier to do, we currently will not
> get large folios so this is more future proofing than actual support.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/file.c | 43 ++++++++++++++++++++++++++++---------------
>  1 file changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f33fbce86ae0..132528cde745 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -938,7 +938,6 @@ static void fuse_readpages_end(struct fuse_mount *fm,=
 struct fuse_args *args,
>                 struct folio *folio =3D page_folio(ap->pages[i]);
>
>                 folio_end_read(folio, !err);
> -               folio_put(folio);
>         }
>         if (ia->ff)
>                 fuse_file_put(ia->ff, false);
> @@ -985,18 +984,36 @@ static void fuse_send_readpages(struct fuse_io_args=
 *ia, struct file *file)
>  static void fuse_readahead(struct readahead_control *rac)
>  {
>         struct inode *inode =3D rac->mapping->host;
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
> -       unsigned int i, max_pages, nr_pages =3D 0;
> +       unsigned int max_pages, nr_pages;
> +       pgoff_t first =3D readahead_index(rac);
> +       pgoff_t last =3D first + readahead_count(rac) - 1;
>
>         if (fuse_is_bad(inode))
>                 return;
>
> +       wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first,=
 last));

Should this line be moved to after we check the readahead count? eg

nr_pages =3D readahead_count(rac);
if (!nr_pages)
    return;
wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first, last));

Otherwise I think in that case you mentioned where read_pages() calls
into readahead_folio() after it's consumed the last folio, we end up
calling this wait_event

> +
>         max_pages =3D min_t(unsigned int, fc->max_pages,
>                         fc->max_read / PAGE_SIZE);
>
> -       for (;;) {
> +       /*
> +        * This is only accurate the first time through, since readahead_=
folio()
> +        * doesn't update readahead_count() from the previous folio until=
 the
> +        * next call.  Grab nr_pages here so we know how many pages we're=
 going
> +        * to have to process.  This means that we will exit here with
> +        * readahead_count() =3D=3D folio_nr_pages(last_folio), but we wi=
ll have
> +        * consumed all of the folios, and read_pages() will call
> +        * readahead_folio() again which will clean up the rac.
> +        */
> +       nr_pages =3D readahead_count(rac);
> +
> +       while (nr_pages) {
>                 struct fuse_io_args *ia;
>                 struct fuse_args_pages *ap;
> +               struct folio *folio;
> +               unsigned cur_pages =3D min(max_pages, nr_pages);
>
>                 if (fc->num_background >=3D fc->congestion_threshold &&
>                     rac->ra->async_size >=3D readahead_count(rac))
> @@ -1006,23 +1023,19 @@ static void fuse_readahead(struct readahead_contr=
ol *rac)
>                          */
>                         break;
>
> -               nr_pages =3D readahead_count(rac) - nr_pages;
> -               if (nr_pages > max_pages)
> -                       nr_pages =3D max_pages;
> -               if (nr_pages =3D=3D 0)
> -                       break;
> -               ia =3D fuse_io_alloc(NULL, nr_pages);
> +               ia =3D fuse_io_alloc(NULL, cur_pages);
>                 if (!ia)
>                         return;
>                 ap =3D &ia->ap;
> -               nr_pages =3D __readahead_batch(rac, ap->pages, nr_pages);
> -               for (i =3D 0; i < nr_pages; i++) {
> -                       fuse_wait_on_page_writeback(inode,
> -                                                   readahead_index(rac) =
+ i);
> -                       ap->descs[i].length =3D PAGE_SIZE;
> +
> +               while (ap->num_pages < cur_pages &&
> +                      (folio =3D readahead_folio(rac)) !=3D NULL) {
> +                       ap->pages[ap->num_pages] =3D &folio->page;
> +                       ap->descs[ap->num_pages].length =3D folio_size(fo=
lio);
> +                       ap->num_pages++;
>                 }
> -               ap->num_pages =3D nr_pages;
>                 fuse_send_readpages(ia, rac->file);
> +               nr_pages -=3D cur_pages;
>         }
>  }
>
> --
> 2.43.0
>
>


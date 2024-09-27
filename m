Return-Path: <linux-fsdevel+bounces-30293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283DD988CB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 01:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260CE28245E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000B11B6554;
	Fri, 27 Sep 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot6qYdqy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74CF1B250A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478002; cv=none; b=I1GsUvvT8KL0rqCGCERoix6uUHKeES34TZ8sGxrw23dN5ZJe7Pkc4ShMftgo/+spFQjepvrKlJ6QK9/gAcWFdWvHphC2txIvGGergmgZvpsHGfZB/IanktbSvVhR8Qk/i06F01q69VqwIRe52va8b/JfEPAs2xM8zjsn6KdO68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478002; c=relaxed/simple;
	bh=zaFKnZn4MM0aHq0oB7oX4ncCyXXBs0S1tfj/byNN/qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzzocQo1/Cblzg8KU/WdKnLvCOGKtqKGa1yc/jfxLhWKmAbSGVNjJKfr1OE4TKU4cr2OBZV0CG1BxSTTUtP83Eb3yABrptTBP2fay7nymHpBfBYN0b0VwEvlsAFcu8ELHGG5M7AqYCk4ZZPhUKT9h6Gch4JIVAqapUqxA/yBiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot6qYdqy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45cac3368f0so4252531cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 16:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727478000; x=1728082800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M4kI2SneWzN5erKVhg5GPYapHDNudqMWDEYas2A5tc=;
        b=Ot6qYdqyN/cRv+JyIzAFz20H54A90uaL55Pgp+aYYLCU+WnKvHU+1SIJAYMI16h26U
         ZJicFEVkhxDspyRzQ3ELSUpJouP9FWfFk8Ut8MwGgkBNQ6VNEmvXEJjtdyTMqV0ZiEE9
         rTDiz82MZoAg+TcF79RhesGZkD3oA8XeKvh5pQWjhGiJKpXcMZwT1zM6+ajECbQdJ4lZ
         xV3CF1xkRs47emC6LmRCbXIz6cDP5V+u+01a89WVHrJxhsHjpyHsM117gqV5jMBtxPuG
         E4T4gfa6axCGb86Q2q28BtlQs3YtKbaBLj9P7noAppcnlvzRrBukVHn1F4N7rHkJcFJB
         AUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727478000; x=1728082800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M4kI2SneWzN5erKVhg5GPYapHDNudqMWDEYas2A5tc=;
        b=imkqbr6ZrrjVLxEAujJRiUqVNs/BYMZjOuwAmjsawFyYcztY2+52FjI1NeZ4G5D8ET
         lH7/1240Mk1/YFyinYGTszu5kS9n9kOsKFqmnb4kp+C7cNdPbWVX4hhRc1P+bPgJuWTg
         1cP52XkYJ5TZnH7XWmvzXiknhS2mNCK6W+UJ0CGlSSNKRDGc37MNcXDZUBKQSWiq2IIn
         28Urc4yE8bbWA7tkm8V2spV0qcGPjvmIeeg7CVzfNjc/Firg0OhJF0edO3QN0ebHPaon
         +kgYRA3oAY8qe40S0xx3+hDdbVmRm7NGkfTc+hLzd9uO3DV1X0tfAF6Y4XxXMkZijpwc
         EWpg==
X-Gm-Message-State: AOJu0Yz1el3RsK/YGUSS6TEMsn7AyGzWsWQN4XByVXJjatRjmMj1O/Qy
	ezugqlFsY6aNIMrNUniliLKNpubomn5OmVkO0NZs/8F9tvlRTk1pP4VNcU0k9ge5FVSGcw1+RNf
	GXv8aco29eIkz9Ofba/r+757p/k8=
X-Google-Smtp-Source: AGHT+IEHd2BSbdysTDo4mri1KPLvnNbhMUzuf+TmBIxtD+JB50clfL3z9osMmCEqRn/CCJbfiqZMfX3+EwtO2Fas1Fs=
X-Received: by 2002:a05:622a:1a8d:b0:458:392a:b021 with SMTP id
 d75a77b69052e-45c9f2a3887mr78183291cf.54.1727477999721; Fri, 27 Sep 2024
 15:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727469663.git.josef@toxicpanda.com> <5b0e4f2c48a04d66dfe70f8228b05ebc53be6a00.1727469663.git.josef@toxicpanda.com>
In-Reply-To: <5b0e4f2c48a04d66dfe70f8228b05ebc53be6a00.1727469663.git.josef@toxicpanda.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 27 Sep 2024 15:59:48 -0700
Message-ID: <CAJnrk1ZCU_eiWc_52sD0FDuWarur+S76JbR50bzuCWnYzunWOQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] fuse: convert fuse_retrieve to use folios
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:45=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> We're just looking for pages in a mapping, use a folio and the folio
> lookup function directly instead of using the page helper.
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fuse/dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 1f64ae6d7a69..4c58113eb6a1 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1756,15 +1756,15 @@ static int fuse_retrieve(struct fuse_mount *fm, s=
truct inode *inode,
>         index =3D outarg->offset >> PAGE_SHIFT;
>
>         while (num && ap->num_pages < num_pages) {
> -               struct page *page;
> +               struct folio *folio;
>                 unsigned int this_num;
>
> -               page =3D find_get_page(mapping, index);
> -               if (!page)
> +               folio =3D __filemap_get_folio(mapping, index, 0, 0);

I think you can also just use "filemap_get_folio(mapping, index);" here

> +               if (IS_ERR(folio))
>                         break;
>
>                 this_num =3D min_t(unsigned, num, PAGE_SIZE - offset);
> -               ap->pages[ap->num_pages] =3D page;
> +               ap->pages[ap->num_pages] =3D &folio->page;
>                 ap->descs[ap->num_pages].offset =3D offset;
>                 ap->descs[ap->num_pages].length =3D this_num;
>                 ap->num_pages++;
> --
> 2.43.0
>


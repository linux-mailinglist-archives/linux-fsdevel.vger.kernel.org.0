Return-Path: <linux-fsdevel+bounces-62513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A826B96A08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 17:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7126B19C053F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89CB242D90;
	Tue, 23 Sep 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XFBsSAOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE21B4248
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641981; cv=none; b=RCrEUTiajAE+fls/XEOKmeChtLx7J+3kFbjV6pVqMbmPV5hjJfJuwFpefotrfAUXOLxmEEHXYz44lwe8MRzCixwSjkTPjHIHHOptCmON3QZI4g6CEVHvVTfZE9JKGNgNvfDuepUJR6d3kjEPgDOBJUy/+qC+EgnTMZtaTdO8OIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641981; c=relaxed/simple;
	bh=leaYlnpusCp0sviLQ30QGe0J2gUEvF7RJCcVhGVbZ14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjhhlVyQgAIoDWk/voNi6RZdG3iA56mt3DkP031DpJXwXqdg2S95CiNAX6dBL3rUtlmFM3ZD92YYOCDGmzTshMkT9ybmdRMej9C1oLl/TsAJX79IYw7P36+7lkhKwDb0Y5UlNi5zH8VmPUWBilQ7OJdx/H9iRCC8LT7yLUz3NVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XFBsSAOS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b5eee40cc0so56142521cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758641979; x=1759246779; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZbdjr9165OSR3oEX8S38orQ1XZpFhmOJaG/L+oMydw=;
        b=XFBsSAOSkNNBCgIHM/jKfQNGj4uSj9EQlt0cFgJHkFOyOKC7kmCDBKNJMj2KeN6n5y
         v0HP1/T1smZv3jtMbwDhmrogOyQV4/yerCIowlzcsLDu251YPlVtiAaqBbOETPWQ8Mbt
         Ua9/zrGmL9NHQRBwrwVHf9qE05S6H3Sh2DFCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641979; x=1759246779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZbdjr9165OSR3oEX8S38orQ1XZpFhmOJaG/L+oMydw=;
        b=fogYUxHh/4KtoxM72CyV3hzNrpYgaNv4K1YE/w54y0Q1i/cY8hH9RxF01NuYE21N+d
         AJPL2LaWSyj7kzUac4k0zRqtbd2AVQ5AIkcI1Ny72JES40i30jkbFzQy2m10I3Z71FZR
         ja4cOTWewBydbVbdZVcdWjLTOUhGRzhZLo25/lg21NrFxbEgA/28VltTzElk7RFlabHL
         z93z4pJT6pfjZ4NwMrs+cN4cGWthgJar6KM8naBdYktvfvXOnNA5kw/hTEbq9f1wtUP7
         rW6ELBgdgRvZn0erftQwK71RAbek2+JuTz6mNqmjdwryBCxeul/hUQlKPNDBr0yWcnwJ
         UICA==
X-Forwarded-Encrypted: i=1; AJvYcCVjYbJuQEkC/GdRzL75uMbEB8ZRQ0Xw+w9OF/SAp1lTrY2jH6SIGZYV8egWS4JHZiJvrwDhPdFJ5ItMvZ+6@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+R2QVPDYwMTvppp5T2yGmdvkxvFwgVhLymD/kJvGaGzB2LTT
	P/8eU4tBuZ/e1MlAyOlKaPdYaEshg4azn2tRyOYk2Jp5RDesGA+wC1xBnl9aOBE1+28xaS7Fk3A
	QDlnpVqMi87VqlOsFq8Y8DjE99w+pWSzktBTqgGjGpg==
X-Gm-Gg: ASbGncvcCFeofh8AudJS1g8OiRL5WC1h4PplqZZJVZFmPUg4s/nYG7FSnWS/lCp8ehJ
	KRuvtQ5VLgXC3NHDXw7WyXP4BdhPd/EKzbXY9qJCQBjhdP0swFDmfJ4HC1vDboKk3y+wVCbJuHD
	SnKnzlsVzO9xuZjWYlx4yMoyfp5XITdb7Is5U/3CJFXAYbqus1VnWqeFUAyZ0KC5SmYeUmIsI2o
	eodLXqnwktk8ckqD9lmurLvvQEHbxYUv/Tkx0AX6CW8Q6/5G+wnN2QtfD2RCXGVpaNxE5yLMwYz
	UrIOuvU=
X-Google-Smtp-Source: AGHT+IGspaeUy0TVQz+LKc1fihw58Q7yPvQbyT2d42SL63rUJcZogQsEDyrgJGDuBFJvNYzyLCvEvUn0X00pmc3DhAA=
X-Received: by 2002:a05:622a:1b13:b0:4ba:c079:b0d8 with SMTP id
 d75a77b69052e-4d367081860mr29707731cf.17.1758641978539; Tue, 23 Sep 2025
 08:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923002353.2961514-1-joannelkoong@gmail.com> <20250923002353.2961514-14-joannelkoong@gmail.com>
In-Reply-To: <20250923002353.2961514-14-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 17:39:13 +0200
X-Gm-Features: AS18NWD8_t8WUM8mJa_Wrlt8XR1hgYkR6Ub6lG20YNejgtDUqRhxsnnPFLDpPVI
Message-ID: <CAJfpegsBRg6hozmZ1-kfYaOTjn3HYcYMJrGVE_z-gtqXWbT_=w@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] fuse: use iomap for read_folio
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-doc@vger.kernel.org, hsiangkao@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 02:34, Joanne Koong <joannelkoong@gmail.com> wrote:

>  static int fuse_read_folio(struct file *file, struct folio *folio)
>  {
>         struct inode *inode = folio->mapping->host;
> -       int err;
> +       struct fuse_fill_read_data data = {
> +               .file = file,
> +       };
> +       struct iomap_read_folio_ctx ctx = {
> +               .cur_folio = folio,
> +               .ops = &fuse_iomap_read_ops,
> +               .read_ctx = &data,
>
> -       err = -EIO;
> -       if (fuse_is_bad(inode))
> -               goto out;
> +       };
>
> -       err = fuse_do_readfolio(file, folio, 0, folio_size(folio));
> -       if (!err)
> -               folio_mark_uptodate(folio);
> +       if (fuse_is_bad(inode)) {
> +               folio_unlock(folio);
> +               return -EIO;
> +       }
>
> +       iomap_read_folio(&fuse_iomap_ops, &ctx);

Why is the return value ignored?

Thanks,
Miklos


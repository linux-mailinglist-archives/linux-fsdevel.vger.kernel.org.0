Return-Path: <linux-fsdevel+bounces-47567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E4AA0653
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 10:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634F2841449
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 08:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A629DB80;
	Tue, 29 Apr 2025 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSwAGtkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458829DB74;
	Tue, 29 Apr 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916873; cv=none; b=jZC+mYpTPPKEeIh5TOkW9EQRbcWBsWrFRwMRKPOFiZiO9EfHStCG/ZorIGwXWaYwoYLqpo75EAtOrPAOxKgwJvqCCn+PUyu7RgdVBjFzc/gI+u0OC/PuBXuJ4DuE2ZXwAf0igMzNKh6v1dPX7acD3wFiPsq6+EFw+ORBI6SmfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916873; c=relaxed/simple;
	bh=BP+oPVt+MIuzrNij2bdFfZ2dpqcPdqUEZUMGkdS0Zxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZCfVqC5gUkzxAbrbDxwkOIfFk1/z3esboSdeYjbh1yP1+muxDKII6CqWTpoku8z7VbP+HUFXhUBdKAREiwfPsQv9y7VnlPTY0RdszHflQBrhc3zxUv+rNpbAo5ylI+Dl4DgN5Q3dkm+mQDt3IMTTVv7KbP4r+EJUxlhewo2lUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSwAGtkc; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso55043751fa.3;
        Tue, 29 Apr 2025 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745916869; x=1746521669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=givnnG9/XK1tF7pF7UEo7kRnAW3Ngj27OlIC1n3nuoY=;
        b=KSwAGtkckFAFjH0ikMYF+JpCEbnMQLPAzfBRqPXZ9Aiq3gKizvQs63ZiJThX5/Tige
         uX3NQDVZ67IBVsyYBtZAnU4AJ9Y7l9d/f2mKbHRnHuotXWzrpAXU0FXYbcnkVwdE9ara
         DzZq40twK3WpMm0LbPQRsmWUQvNawxPWQsJii+TYAuXa9aL7Pd0V+ixEangjwFYlCUao
         Q6h5Ui1SRYcyD7elRorI/Ue+UgEVxJFas4cKz7zawDuLiteAlYVNK4iboFUr2Kw8kSlZ
         W6Q6I80CxW0HJmWCRyLLjoM2YONk0j/YTbQQDOGMeDnGCKS2iTFBcm/OMgGCu6+FoPKz
         +QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916869; x=1746521669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=givnnG9/XK1tF7pF7UEo7kRnAW3Ngj27OlIC1n3nuoY=;
        b=auj8AESEb2VwuGWTXGNCM97+Wjzx7iea0i2lYztUwinV3tjmMRpCwVGOQRam8WWTWA
         DGhz6o1p45+xk1wkL4wIw7gUfJxyp1KT8FMoNEilOrBxbI6zTrdcv5hqYJAmTdornH7p
         dNV8+2RxGVv7x1esQ4yQ8X8JbeVK3DIBRRgThjb5+gsRZc9kx5oNqC86tJWGMEuyR5jc
         2TxajlJbERRP21r7w3mI1ZwT0WIczZj9unx9lZjEWUicF68O/mPzPsq5xu4hSqZoqOwc
         blCEqlDn8eWeDJ6J40mq+RUvkS4+ALCEq90RbgB4vaSBejJTD2tfKx7J84SEBPnCscbB
         hdhg==
X-Forwarded-Encrypted: i=1; AJvYcCUYlk6xsG7LZk+T+vHv7ih/WujdniheoGov91DAcYCmfLi5QQR2/8b9yMuDNXS7eHNnu7Hai0664A//V9vo@vger.kernel.org, AJvYcCUimT6KIsmYuaSrv+i8nrrGWuqUWatSchorhz6AKS1MnDcnFgfPhRCrPu3ubZpi5pKjGGg1JsGMZDw3yDhr@vger.kernel.org
X-Gm-Message-State: AOJu0YyInn9htNVG4dy9GqYJLgxwGfpAMdV4RyFHKF8qlyA4cF7GhO64
	ImYKQx13gBCvm6e/SbpXgVlJLunRI929Tjtb4SzU9VRTplYcYWCRnqhbZ6V0NQEla38zblq9xX+
	UXP2HAPR+u02J+qcMthiB3/qbxHA=
X-Gm-Gg: ASbGncvcBw+H/QOiLIx2kqx0eB74Treckkp82j/DFT9HlIIJWvGe9EBPY3HxRw7Q5a9
	1l+90w6/jinfDB98PgTx2ZtfcOvHJFhx19HNiSLfQhgCq9MniurF4b4fuDsFKl85dsyVnhZHiCX
	w1GoyYsfG47jEHH01GHNURDcK1DzXVSFDc
X-Google-Smtp-Source: AGHT+IHm+fm75hv4juuaVFiSQHyV15+uewvSg8hjHCInt+PYvS2I7PqnXcopg+MtW7d7dQKaqtX6qV0zbF+jfjXa3PE=
X-Received: by 2002:a05:651c:987:b0:30c:514c:55d4 with SMTP id
 38308e7fff4ca-31d34872545mr8201611fa.16.1745916869066; Tue, 29 Apr 2025
 01:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427185908.90450-1-ryncsn@gmail.com> <20250427185908.90450-2-ryncsn@gmail.com>
 <aA7N1SHoR-tY4PJW@casper.infradead.org>
In-Reply-To: <aA7N1SHoR-tY4PJW@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 29 Apr 2025 16:54:11 +0800
X-Gm-Features: ATxdqUF6LDYN1wUvO9L0OjUIL4UUQll5MqpMC0XWhL9RW16HLnlYFIFFC3IpScw
Message-ID: <CAMgjq7BT38kCb_c=OLmt3EOSi-wFgGG7KLuSJLkm1Er9HF4wfg@mail.gmail.com>
Subject: Re: [PATCH 1/6] fuse: drop usage of folio_index
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@linux.alibaba.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 8:38=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Apr 28, 2025 at 02:59:03AM +0800, Kairui Song wrote:
> > folio_index is only needed for mixed usage of page cache and swap
> > cache, for pure page cache usage, the caller can just use
> > folio->index instead.
> >
> > It can't be a swap cache folio here.  Swap mapping may only call into f=
s
> > through `swap_rw` and that is not supported for fuse.  So just drop it
> > and use folio->index instead.
> >
> > uigned-off-by: Kairui Song <kasong@tencent.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Joanne Koong <joannelkoong@gmail.com>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks for the review.

>
> > @@ -2349,7 +2349,7 @@ static bool fuse_writepage_need_send(struct fuse_=
conn *fc, struct folio *folio,
> >               return true;
> >
> >       /* Discontinuity */
> > -     if (data->orig_folios[ap->num_folios - 1]->index + 1 !=3D folio_i=
ndex(folio))
> > +     if (data->orig_folios[ap->num_folios - 1]->index + 1 !=3D folio->=
index)
> >               return true;
>
> This looks like a pre-existing bug.
>
> -       if (data->orig_folios[ap->num_folios - 1]->index + 1 !=3D folio_i=
ndex(folio))
> +       prev_folio =3D data->orig_folios[ap->num_folios - 1];
> +       if (prev_folio->index + folio_nr_pages(prev_folio) !=3D folio->in=
dex)
>                 return true;
>

It seems FUSE does not work with high order folios yet, a lot of
allocation and operation here are assuming folio size =3D=3D PAGE_SIZE. I
think I'll just leave it here.


Return-Path: <linux-fsdevel+bounces-59429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B314B389FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92AF87B44D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69B2D73A7;
	Wed, 27 Aug 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2YRDrB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5067464;
	Wed, 27 Aug 2025 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321319; cv=none; b=cXEHHg6BNqUGXDhNc+ldc/ToKvP+6poPm/nVaok/Ba3hJU/J3igi+4dG0+6TeGfMu7a1Z+w5mIcp7jzCinwuGw34kRLZwMxUWLed6t8G7DZUpeRZVZwfk92tq/Dy5uVB9E5bjlzmwmwRJv3t8TJEk2N2ql5I5CvcRxiw41OLULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321319; c=relaxed/simple;
	bh=jq1Ktn/zCmO4HkpdW3g9pESzHEX95cFkHLeSdhAyoM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBbS245UAIGQsD7Z+ZSC9vwJMctqmHJ8Vak0v0Htj/ZA5oTmM0cB4ibAnuDJmf+vN6s3U97sYJRrx6EGTaVaVoKPloptEDKsw/Mt/S6BM0e6d4Q9zCPzfA0+uXEzFFEFR6D13x9DwL/tIBYdjbb8qfbG1Vqi9A5mb2qRoO/KLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2YRDrB/; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89019079fbeso47473241.2;
        Wed, 27 Aug 2025 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756321316; x=1756926116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx38UWXoqdVI6iyQIcZ9OO1CNYdFs0IqSGSl393RoCg=;
        b=D2YRDrB/dU6LLtlVjhOusRGW5yDLI2bMLeAU8+qjpwLZkT6tMiCpliFNekWzlB/zsg
         zu9R13fTFj/vTOBDbLJCVV5PwuWrs8MEfQlUQctY3xaj4lkc52SRp71h4IcrhK1OQvUL
         Kr1lsgh7kalOF5x79sP7HOMy11xCv/ty3pHb+Hu4Ygn7mSqSJc5QOhhP8j+JhkfQIKKN
         ZgcrGCgiOHZCAD7zlBD3JkHOjywg+ligqgYcjihEb5FinL97KXuOT/jtb/hBByKggwYy
         bQ9qNmcAy48v+kN3nlnzGFHDtxAX8vXy1t9uSWzo7DR9JERo+NbBnDGLPOkpayGDwlLy
         WryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756321316; x=1756926116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx38UWXoqdVI6iyQIcZ9OO1CNYdFs0IqSGSl393RoCg=;
        b=HELYfcmRgPuaie7VCRnOvwqam42wSAOu3uzfRFq7FOzQzlkfizL5V7yHXb65bsy6q3
         duGqa6RlSZiUlnlEOXkFQA/nFfFb++laOlY2ars+vqlM+DJsIr+1z60wugJ9IUNNpEfw
         EiRwXT3Sq3zt1AFVJ9YJmq2oVoKQ8zacZyFgvpBoVtaLDRA/iMFHYuKih4csXUz5Kmc5
         g++5lyODFiDoAo1Ldzl+Fc90cF+6ARSfOp64ZdqJ/eNQ7zGvxi9m/fAzl7TXPr9SlRkE
         vB8gzTXZHsAkCBitm6Oivh7Cbp+2Pi6eG43O6pExS4J6kH1XE/sRAaz4FnFeKoglrZtl
         YPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOuhgRSzOn5dHvWYZg/9Kf6JElqDfS728BMvXA10/MDg2d1ngtzBFhE/PouvYDTnjZt53UhXChUyydNuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9kCbGEdGkuTPigZY5M4CfqS03/MTYxKBNm03KNu8gNyLj5PR
	Z4gQbHQv746ein6mH5vQZIibOR7LBQsBVdn/KNblUBRkbyiw6mTuqzpyRibH1cvJdmjEj78kLoC
	cpQa8FLaNRu96YvSsQy+CqKCS6iuxPANoYTLNVc8=
X-Gm-Gg: ASbGnctk3yEiHyIPusKMXn2u21q4+yYT08A2h/pzCVfP3VYuUfzIBV4UuT4XsvAm9U9
	xbqgiqRDSqVmR+Wm82KBPJcAx7m+EcdDcar1Brt7KJgD3Eu2ujakf1JuGq9Cb4AlYxQw9ULyIk7
	MIpMxNVeBMAz94lHl9kDSslTGx/W26VKpjir68nZxBl7YZj3+uyO53ni79hlPK2z8zLQkOBH5yv
	rPdxtjeGLBrFbMUPNWoQeAex3QvymoG+g==
X-Google-Smtp-Source: AGHT+IGaKXoBp6diyWdwn+F/VLVCj4USDEs2VYPNP1DiZFcQBwDCkT+oUUbJ65kcAdN6+X/Hmc0O9YUxXFlqM7focFw=
X-Received: by 2002:a05:6102:50a5:b0:525:471f:de14 with SMTP id
 ada2fe7eead31-525471ff0d8mr1366211137.13.1756321316158; Wed, 27 Aug 2025
 12:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250826131210eucas1p21a27a684042f37080b7a19599f479b7a@eucas1p2.samsung.com>
 <20250826130948.1038462-1-m.szyprowski@samsung.com>
In-Reply-To: <20250826130948.1038462-1-m.szyprowski@samsung.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 27 Aug 2025 12:01:45 -0700
X-Gm-Features: Ac12FXz4JdHEq3lRdfP2RTbVkNM0wK4qpK2_HAT_D7su7wtYRZ2mk-qsAVSKcWs
Message-ID: <CAJnrk1Z3xD-rOoB8T9=AFjVXx30FRoPv_qECEEBPisz1XSRt8Q@mail.gmail.com>
Subject: Re: [PATCH] mm: fix lockdep issues in writeback handling
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:12=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Commit 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT") removed
> BDI_CAP_WRITEBACK_ACCT flag and refactored code that depend on it.
> Unfortunately it also moved some variable intialization out of guarded
> scope in writeback handling, what triggers a true lockdep warning. Fix
> this by moving initialization to the proper place.
>
> Fixes: 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This LGTM. It reverts the initialization back to the lines where it
was originally initialized.

Sorry for missing this, I had assumed inode_to_wb() was just a
straightforward inode->i_wb pointer following and hadn't bothered to
look. I'll be more careful next time.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  mm/page-writeback.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 99e80bdb3084..3887ac2e6475 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2984,7 +2984,7 @@ bool __folio_end_writeback(struct folio *folio)
>
>         if (mapping && mapping_use_writeback_tags(mapping)) {
>                 struct inode *inode =3D mapping->host;
> -               struct bdi_writeback *wb =3D inode_to_wb(inode);
> +               struct bdi_writeback *wb;
>                 unsigned long flags;
>
>                 xa_lock_irqsave(&mapping->i_pages, flags);
> @@ -2992,6 +2992,7 @@ bool __folio_end_writeback(struct folio *folio)
>                 __xa_clear_mark(&mapping->i_pages, folio_index(folio),
>                                         PAGECACHE_TAG_WRITEBACK);
>
> +               wb =3D inode_to_wb(inode);
>                 wb_stat_mod(wb, WB_WRITEBACK, -nr);
>                 __wb_writeout_add(wb, nr);
>                 if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
> @@ -3024,7 +3025,7 @@ void __folio_start_writeback(struct folio *folio, b=
ool keep_write)
>         if (mapping && mapping_use_writeback_tags(mapping)) {
>                 XA_STATE(xas, &mapping->i_pages, folio_index(folio));
>                 struct inode *inode =3D mapping->host;
> -               struct bdi_writeback *wb =3D inode_to_wb(inode);
> +               struct bdi_writeback *wb;
>                 unsigned long flags;
>                 bool on_wblist;
>
> @@ -3035,6 +3036,7 @@ void __folio_start_writeback(struct folio *folio, b=
ool keep_write)
>                 on_wblist =3D mapping_tagged(mapping, PAGECACHE_TAG_WRITE=
BACK);
>
>                 xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
> +               wb =3D inode_to_wb(inode);
>                 wb_stat_mod(wb, WB_WRITEBACK, nr);
>                 if (!on_wblist) {
>                         wb_inode_writeback_start(wb);
> --
> 2.34.1
>


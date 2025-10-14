Return-Path: <linux-fsdevel+bounces-64062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1ABD6D2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 02:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 208514F4A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 00:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E41862;
	Tue, 14 Oct 2025 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSTRFPo3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EA1D6AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400283; cv=none; b=NeFxWpdmBTfnMt6CZ3k1rAuo4EB8HG7wrzLDgNR0FKBLvKoAFr000Urp+IuaFuOCAwoQ0OB0WS9WnB6GC53/JCgmH4Q/AYtIuDQK5UwcB5mR47Q4wO1FqXXZXqfe2xPoTq0r0JhXwI566SPz0LkI1lqnthqS8U8tVs01GGrEGNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400283; c=relaxed/simple;
	bh=h0dFaXojRep4OIcjYJfNV+/dnxEEOpnMEzBUE/dBw7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4oeytwVMFALhmtO0EiHST8OnKPz1fN5ekK/5X7UWbDfqYEorXrn9Ej5Xcj/i2/YDqYGifYfedoaCAkAk8CFJhpaEzvQ8cpRZHt90tsCdp6r8YwJ2QFWSBHOIEdLIdBUx0YJ2Nkuq9huBwnFUB73ymlrDhpbTwbQ7OmY2ILkZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSTRFPo3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-78f58f4230cso53762686d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760400281; x=1761005081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TgvIh/ilvDraXbFpYVmEYjAAkYdydSciPj7xisjkL0=;
        b=ZSTRFPo3+oqq9W0iSXty2Wvwm+hdDePik/JMFQtw/ci6evk/mWP8dDIW5IG+0WIgzX
         hKAIWHcBBi4XGz6AZ24LcOnMVGmFSh+MoUiueRn/8d/IGKrv3NWCqYlpAln5SVSWIXqu
         F7Fz9mxkKRcb7tOu1QkAyNNsjgTut91zeWdA6FRk2KFZqQagrFgylc1wj3KJ2A1Wv0y+
         hOzFEWp9e7FBZyiddKXxSv9WyaOzHaajV4jQae0Eej8OvClIWjeSkUWj50LHihy5Qjh1
         vHsCcgHNXS5mxz5n1EYYBnpb978Qr+z+d1By2FHze7smdO5NaCAPx/AB31gu9Us+5lur
         QZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400281; x=1761005081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TgvIh/ilvDraXbFpYVmEYjAAkYdydSciPj7xisjkL0=;
        b=knpE/OSiCihKNvpvQAh9qAh1ajwgW5lkGe1DTausaME1qHLUUtgp+6yi30Z9zZW6P0
         b5noBLzQXk7CIHl9Z12HsOlgh7m5iPA7wplCV0SqW6KnukEYtDY97ZgK02FTHskXMx4A
         jRM90KRt4Ztzufv9m5cCsP2XA+d5w2NDJAs/kh/gPtgynWmHOtOfMW03A5S3/EV8sjAL
         MPeDsc7kPr1ZMgIjunezclzlbWj4KibHMk2d3MLcSVzFid2Qjlh5U7uy7cTA2QehZHpJ
         AVRrHRzThDtVeXM0m0b02GiAx/wi6/t65pppaTvqDRJK+rq19rYurPzNmvcZJd6loP5P
         EMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpP69Y/9RRlNj1mY/UsuehYEcF9m4pAZeWuai0ZLTLsV3r7mxlWSSBIvibPNfdcoUVmWwl6Mow70teWULi@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFGZYzL6WxO1aE50RGXL4b3gKbm+jXPraEFDa8j9CXozOVE+Y
	cHcFcTQMwSN2jOmh9QOwjn8OKvsUs9Sni7Fkg+sg+v2um3QQu5f8RcDcxEXFXlBx4gPSu0PyNKN
	Dp8NLQsEzPL19CUg+xo30Vd0m1HW8MYI=
X-Gm-Gg: ASbGncu4YDdlXKaxhCLq0mve8QzXfJcQU+rqLjS9dubAzmcfwueB8VOSqwZoA1o1yAW
	rvCrt/5WXkpYMqUMsqbnIAqpxpnUsrfcoQjR9P9eOLzOwY17yP8kc6v1/WNtZ9Ks0/EMXwpRCgg
	aetBNb+jslMSrA2BGmatdi65c4vE6xZvNFL4MihDdi5ABKe/GmuFoti1XTeaImyQ3UOrDI4rlt5
	uXCDKEJ6ZXf6X++2NUZfpK8ejEDF/DPnwRxob1cRRJYs8gXChBbkkuRQXoC8rbcLtWIyI9w1N5N
	/2Y=
X-Google-Smtp-Source: AGHT+IFhNbDWm+ygTOhlkQbImqyAGxwvHkk8e1mlZdmwD2JREQVqx1VE2lekHXGSJzsKEGQid+YP548nTKdKpUHqVdo=
X-Received: by 2002:ac8:5756:0:b0:4b7:a8a1:3f2b with SMTP id
 d75a77b69052e-4e6ead5ba53mr318157811cf.64.1760400281072; Mon, 13 Oct 2025
 17:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-7-joannelkoong@gmail.com> <aOxtJY57keADPfR1@infradead.org>
In-Reply-To: <aOxtJY57keADPfR1@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Oct 2025 17:04:30 -0700
X-Gm-Features: AS18NWARx0KXPrdYDVeorL-Y6FdhmSJZJvAIO7iAh91yWYMAQrUFQ_Tl1j-n8Uk
Message-ID: <CAJnrk1aS9ko2ZxKM0zKm6Uy1zP6RFm6JWJ9Ku2zLSK9LmC4pOg@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] iomap: optimize reads for non-block-aligned writes
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, bfoster@redhat.com, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 8:08=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 09, 2025 at 03:56:08PM -0700, Joanne Koong wrote:
> > If a write is block-aligned (i.e., write offset and length are both
> > block-aligned), no reads should be necessary.
> >
> > If the write starts or ends at a non-block-aligned offset, the write
> > should only need to read in at most two blocks, the starting block and
> > the ending block. Any intermediary blocks should be skipped since they
> > will be completely overwritten.
> >
> > Currently for non-block-aligned writes, the entire range gets read in
> > including intermediary blocks.
> >
> > Optimize the logic to read in only the necessary blocks.
>
> At least for block based file systems doing a single read in the typical
> block size range is cheaper than two smaller reads.  This is especially
> true for hard drivers with seeks, but even for SSDs I doubt the two
> reads are more efficient.
>

Ahh okay, that makes sense. I'll drop this patch then.

Thanks for reviewing the series. I'll make your suggested edits for v2.


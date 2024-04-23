Return-Path: <linux-fsdevel+bounces-17539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75038AF5EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC50DB24A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E613E051;
	Tue, 23 Apr 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmcly4Lz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933891BC23;
	Tue, 23 Apr 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895153; cv=none; b=ZFoF5sGG504JB9VyXYPTntXHxr9F2YrkxvpQVp1I9vdHkkV75chZeWYXAdMObo3lMNuyb7V3tdLPVv176DrD5uJ5FuwbDics5WwdDp9ObcopVPmmCydjgiUMBLgGx9ehKu7/8C2cBJpAwCni2+4RdFSweTw2/46DIHcgSySVJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895153; c=relaxed/simple;
	bh=EpS6tWHdGI96GK42b/5ntLzKDrdd3hcAuUmWjXnFAvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBNwIKYPZPNRIAGthL4qmcgcRC8YXtZY1DNqly7fvwJWiaKvpgxbknjCIGz4cJuml+h/z39KZMvAopm5zPFVyweYR4HmPh5kk7M9Ad08srMwykpppgAuO4nA2ccsijszHWpTih+77V511lPe7vVg8GlDaiLcWh0YJ7yjeG9B0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hmcly4Lz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51bafbe7509so1296012e87.1;
        Tue, 23 Apr 2024 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895150; x=1714499950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nJNypcp+Z1f3qtn6A4ykepjlOqA85W4DKjmqfdVNUM=;
        b=Hmcly4LzI+BB0qn6NZrF0hQNFAQrXZ749ixcV9ImVj3IbQNGpLALgsaujeGy86Wnrt
         a40zLWSJAeLcVG9S1vTC1FBpxUfQW4Kx693bkUOcDwMq9hdEhAdLFK5ZZHXJtGXnBvsG
         WEY6+6jDFAphdG9Nj3DKd+qIMLAdY+nFf3LkCxWUo0DHckCszxJ7w7eDmBMUeAjbm4/H
         6n+ogrnMurP0AsB2OECDDvm50vllJjjgQox/S2W7OB1C7bekHyY6iIdHu6emk6I9ffnt
         AGC+7W8HXzkjkRCoVDuUftA7hCcZfRIf7Eg/TbseOQ9TiUQGP7DgEODrS0TU+1bmYb1m
         0hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895150; x=1714499950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nJNypcp+Z1f3qtn6A4ykepjlOqA85W4DKjmqfdVNUM=;
        b=DDM8j9ccZvTOBDrB0/buL+qwZSdvDCjhJouH0cjUqMswS3/r81CT7fi4vv0mehXHLx
         pvMRbZykVdyeV3NUoogygh2IwuqLAVYdyOWdO5tYZo+kjLoW6eK/lfSCKL7NyG3dxGcU
         18xm/1VvNCsjP5gcy2LnzPjvSRrlPPmIOruBLGCCpLNdEbNcLI0JOEsOm3nNZoXv1nrv
         biBrvkVhHmvv8+12wGflnyVffsnvRPgHdFY3ll9xAjcessFgsCX5t9Ehy8B7BAiUWktg
         ae8a2hjdKIirPZsTjbJeN6TBJcEqTtsggcAKj+eYfadcMNFkSrBn2r63lU/+Dek4dExL
         f+rw==
X-Forwarded-Encrypted: i=1; AJvYcCWpN7WYiVonZY6YG1D4KSkxdw9WAdVYUt68ZXanx6Jqb3xBFcBAQY1nF2/YiKd9jsfs/RKxZrDnuQdTQ4IrLNhI/FQNvGWD383llPc=
X-Gm-Message-State: AOJu0YyPRYIlF6c5sFRgly8+QQQas6tnWHL+61b8MY2f9DLMpMbefmYq
	eVFL7+GHD8ZBA5iOEWNtWvenqTNycj5na0UbwBjg5MNp5yAFiOfh07krSt6BXjEFnWq38VU6Bkk
	FmWE2GsNWABzl/nlSCi1GpIqYRFrJbmpg
X-Google-Smtp-Source: AGHT+IFdF167d785mVan4fF9hobGVyccfhbAN/zWByiREfCfC4JqTsEdeVIGgU+8gv9DageXYLjY6O/zl/mWkXrb75M=
X-Received: by 2002:a19:915b:0:b0:51a:f31f:fc6e with SMTP id
 y27-20020a19915b000000b0051af31ffc6emr251364lfj.14.1713895149365; Tue, 23 Apr
 2024 10:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420025029.2166544-1-willy@infradead.org> <20240420025029.2166544-17-willy@infradead.org>
 <CAKFNMonpNymFnG=YkmsStHdJXdrQOaEgPdkr8231DunXDiOyvQ@mail.gmail.com> <Zif1FpA6oLBxavIV@casper.infradead.org>
In-Reply-To: <Zif1FpA6oLBxavIV@casper.infradead.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 24 Apr 2024 02:58:52 +0900
Message-ID: <CAKFNMomO3TiePuzSsOaZV-vg22QrUK=sZMX96LHkWpPiBq67uw@mail.gmail.com>
Subject: Re: [PATCH 16/30] nilfs2: Remove calls to folio_set_error() and folio_clear_error()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:51=E2=80=AFAM Matthew Wilcox wrote:
>
> On Wed, Apr 24, 2024 at 01:36:52AM +0900, Ryusuke Konishi wrote:
> > On Sat, Apr 20, 2024 at 11:50=E2=80=AFAM Matthew Wilcox (Oracle) wrote:
> > >
> > > Nobody checks this flag on nilfs2 folios, stop setting and clearing i=
t.
> > > That lets us simplify nilfs_end_folio_io() slightly.
> > >
> > > Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> > > Cc: linux-nilfs@vger.kernel.org
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >
> > Looks good to me.  Feel free to send this for merging along with other
> > PG_error removal patches:
> >
> > Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> >
> > Or if you would like me to pick it up independently (e.g. to gradually
> > reduce the changes required for removal), I will do so.
>
> Please take it through your tree; I'll prepare a pull request for the
> remainder, but having more patches go through fs maintainers means
> better testing.

I got it, thanks.

Ryusuke Konishi


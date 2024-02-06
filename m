Return-Path: <linux-fsdevel+bounces-10402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C799284AB24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC0F1C2394D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 00:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFB1866;
	Tue,  6 Feb 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILDeD9bl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D11362;
	Tue,  6 Feb 2024 00:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180264; cv=none; b=OVmTDbTE584WxTdcpjOCbucsGmmgBvU1SAtNrS2aFUdJUBjyTV9GushPc9mhz/qgUO6sdM4H9wlUfh2jF6Z4zNhtPY30sy7RwEh0eYGaVxb6ULKOuctTmc4DLgFT9lKDjpjVVmb+g9BBB5Ml06i8bLTYTeosDzmtVg+1v7Dfx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180264; c=relaxed/simple;
	bh=/yyAqzHQD4b67rx9jlayctNJKLPz13q9fnIllnfVOC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tn7Qlb0x1g/sJYYv2yiSMgr8vEly8xFB1OzlZcuTgPRGCiJ8vtX00m9SkJByseOnXuaGBF8eLfchRXtdnce2SSGQLTd2jkr/exh48eeBEBPx9Esy4iUAYz/nzmsBkLtzCiwq/8bFnDRkRvmfH+s6FUJU8eYY1gZ4e0RTvadNHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILDeD9bl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d09faadba5so27947441fa.1;
        Mon, 05 Feb 2024 16:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707180261; x=1707785061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OFn31jen0blVfvFsWJzTrRwpe7OQng5QeVgbQtEl5o=;
        b=ILDeD9bl1rcHHwEgAvs8ELVaduxaTW8pHSi8ansRG4k5aAOKhUmw9nbLOzyrVScZEC
         KglZ0D/sHP1B8ujRgpzDWmPCPRRKZw/Ge1z6Q7g2RalmCHRT3rQ3ZSRD2tOmtVcM7N++
         SuhoEUstEkGwYhtpG4QdvCyY9Gc3kAKdt0cwJUJ7Lv9EETnkHGINXZzQkwXnxSaOgLME
         eYDbsZSYYEfNMIo80NrQd0rtiDR23Z96brXc20stISggIPl82Fsvag3lNHNLfBCcyUIG
         7fiqhAiuRePxsai2G/oxIjWnrfj2WOzj2cgcDELMAHps4kNzWfXtHtVC4WaIRMZfuLVc
         d2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707180261; x=1707785061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OFn31jen0blVfvFsWJzTrRwpe7OQng5QeVgbQtEl5o=;
        b=ZNdB9eDM7rck0NvMuTILwSomlGMt99/5PTutmH8PtkywYFioeDKHOBedqyUVvtCAs0
         1YTJk+MQZDlpPzhX3CkdENZxf5oG+olS7EpaeryJf4YR+bIgPXz6AAV6MeHHYSbUbAIn
         6h9F82DM8htQY6xbrZDxNtcTcpbVMAgYC+9M2OXp8hqYj36+sTLbWsYoc1o3jtYEBW0f
         2CvpUtqCG1B2NEKiI7E09qnXwmMvHJAqxdxrzjuEMzJUM1NgthDysDX1kxeRQKG9dT4S
         ndhZjhQIGU2UPjnvuGBNllrBBYkH4PL3kMU7ct7KiouNckjjhVrMnuH4eboMl+E7sitD
         q3BA==
X-Gm-Message-State: AOJu0Yx2CTuCObeeAkGG36pyMVd31vw/ZmDYCz8X5akMOVe1fnk6/o+a
	znZBULp1VSfCsaw+jgxFUYuYdPHJh+6fvvfKYb+L9MffDLyoNJlrfbPfg+zmWXlLA/b7DQLby/L
	STkQRCoskWq7qaocE25Hy0XSyeSU=
X-Google-Smtp-Source: AGHT+IEVdSuNJJf4BhE+PzKe7H+47Ni2/ANUXOeqBOiT89cpWJWmEd3e6PND6g24dphWUU51GE8YqFTE8DlfLcxRYlc=
X-Received: by 2002:a2e:700e:0:b0:2d0:a2bd:2a3c with SMTP id
 l14-20020a2e700e000000b002d0a2bd2a3cmr776621ljc.26.1707180260465; Mon, 05 Feb
 2024 16:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205090552.40567-1-zhaoyang.huang@unisoc.com> <ZcFbl0zP2pK6vEmh@casper.infradead.org>
In-Reply-To: <ZcFbl0zP2pK6vEmh@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 6 Feb 2024 08:44:09 +0800
Message-ID: <CAGWkznGzWW6yORWvKt5p=2O4S1FtkNe4W42SwYduE70hVkiuBg@mail.gmail.com>
Subject: Re: [PATCHv8 1/1] block: introduce content activity based ioprio
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	Yu Zhao <yuzhao@google.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:05=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, Feb 05, 2024 at 05:05:52PM +0800, zhaoyang.huang wrote:
> > +void bio_set_active_ioprio(struct bio *bio)
>
> why does this still exist?  i said no.
I supplied two sets of APIs in v8, this one is for iterating the bio.
The reason is bio_add_page/folio could return success without adding a
page which can not be dealt with bio_set_active_ioprio_folio
>
> > +void bio_set_active_ioprio_page(struct bio *bio, struct page *page)
>
> this function should not exist.
>
> > +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)
>
> this is the only one which should.  did you even look at the
> implementation of PageWorkingset?
>
> > +extern void bio_set_active_ioprio(struct bio *bio);
> > +extern void bio_set_active_ioprio_folio(struct bio *bio, struct folio =
*folio);
> > +extern void bio_set_active_ioprio_page(struct bio *bio, struct page *p=
age);
>
> do not mark function prototypes with extern.
>
> > +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> > +     /*
> > +      * bi_cont_act record total activities of bi_io_vec->pages
> > +      */
> > +     u64                     bi_cont_act;
> > +#endif
>
> what?
>
> look, you just don't understand.  i've spent too much time replying to
> you trying to help you.  i give up.  everything to do with this idea is
> NAKed.  go away.
Sorry for the confusion, but I have to find a place to record the
historic bio's activities for bio_set_active_ioprio_folio. There could
be many bio_add_folios before submit_bio


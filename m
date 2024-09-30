Return-Path: <linux-fsdevel+bounces-30364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247998A587
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463361C21363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313519049B;
	Mon, 30 Sep 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rUTjW81W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82F18FDD8
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703569; cv=none; b=U0lv8+6S2cM7F5rXF75ZXX7SMAw5DkNQ06UjDcRXLQ1Cu9kr6NIwUCvjFwix66xoMYu8yY2xww1/YFzm/v9QkcSLkdi/DHChYhD65lU0JdMWlTvhQ3ZOXEFwWhfh45Pqoll02xhN3yp/T76Mul7eMH2vMitKWylQB+vpChBaFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703569; c=relaxed/simple;
	bh=NjRZQMOGukAiphqL2FoOwm1LD+S0bXmqngqXHJFxNRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi8NupwFScJb0brZkKb8vMPyiWxSRokw8Z0G3948azrNcQoyz9Pg64QR7Buhss+Az7db07s4afUJWpuGfWbgG6JIXvo1Jxppk+X9zO2KVT6+ekyGDX3OX2ldBkdBkkqW/nV5QcnXKPuu+Otkpf2/GUHwVMF/SBx3FR6bGjvFqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rUTjW81W; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99fdf2e1aso589981785a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703567; x=1728308367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hS5BNdBpy9WHz4JRPzmzHgv03dmNuxBD3XH4LtSdX1I=;
        b=rUTjW81Wxym5wPTerhrTcfmDlYM5gCmh9o1xFZ+FsQbt835juSkqNVAKGGW4fWwNkH
         eV2SD1zynF3LNBLZE4NpSLJRShtoANeEggLPMRXBXSjlxnwIQT+QhDGYo+n2WCONbjSp
         niGmQEuDon3hWSA2jlyUKnegEinIxDseb/kPiTr9xndP6ukuDknGEhFOKOVcAeqpuBvU
         0X909DeaHyk/cwCMKmM5dLbrJIJKOjoBaeZ0cnEf63bkxNiPE0g8qX5CS4cSy0IHjBA1
         AFNou1q61L8eYYWz9hLRmPBGjrcL/hegLmISg7PD+l+g0LfG/vNQ51OFV1ojBTcSjeKH
         tbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703567; x=1728308367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS5BNdBpy9WHz4JRPzmzHgv03dmNuxBD3XH4LtSdX1I=;
        b=uFM7wBX+IHSiKJX7+f8WnAzeCNtTWLfs1PceptxpTSDeCEJov04+q04UCMECpNEOBg
         bboyiqChe4LFt0Msl2IthLSQanTX23f0AvnTfoOcVIVdjorFsX9CZjhPIMG2zgYwcAM6
         jUp6CsQYphqHVv5Evj9Q9suGIxHnxpi30jsqyaWmaHw8nWxurwH6SrEvOQEJ4f9UNlOg
         htNrhztSB+kc7fpm9ugMGIgaoAP45TUfEMhm4vvD+L1ToHjiB1N8B5Ktx6OFGkGV8iVJ
         KdBJSvLaXQVUPZlKGDZbI9zdn/Pd5zeainlA16kv4ekrMD7D9dakgUavlf83hflS42JI
         whKw==
X-Gm-Message-State: AOJu0Yz1EDROuw0OyiAZcGgZJbUmcnc4snIGGKX8IUgPVwaSoxYjE3Vp
	vh0QriAzNryT9XfhnrrD4l00w9BrqOiC+Hoh7Dda+hjXW+hPwTaXv/YYvT51T5lMQhpN8ZEVUBb
	b
X-Google-Smtp-Source: AGHT+IEZTLd6+BtRAjaF5MsdMe5u/+OIgWXN55NJGWEzrg10SQGnzT4QD6b6F3ytlI9LnkxKWRkNcw==
X-Received: by 2002:a05:620a:19a3:b0:7ac:b04e:34c6 with SMTP id af79cd13be357-7ae378c2d79mr2167717685a.50.1727703567145;
        Mon, 30 Sep 2024 06:39:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae4af32e58sm162399885a.42.2024.09.30.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:39:26 -0700 (PDT)
Date: Mon, 30 Sep 2024 09:39:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	kernel-team@fb.com
Subject: Re: [PATCH v3 06/10] fuse: convert fuse_do_readpage to use folios
Message-ID: <20240930133925.GB652530@perftesting>
References: <cover.1727469663.git.josef@toxicpanda.com>
 <0fe4cfc0e7d290e539abc215501ebebf658fd2b2.1727469663.git.josef@toxicpanda.com>
 <CAJnrk1bGJWHOLZr3iFkY8Xkccg-0jEvvEKJ7Rb+om+YN06Trsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bGJWHOLZr3iFkY8Xkccg-0jEvvEKJ7Rb+om+YN06Trsg@mail.gmail.com>

On Fri, Sep 27, 2024 at 03:51:17PM -0700, Joanne Koong wrote:
> On Fri, Sep 27, 2024 at 1:54 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Now that the buffered write path is using folios, convert
> > fuse_do_readpage() to take a folio instead of a page, update it to use
> > the appropriate folio helpers, and update the callers to pass in the
> > folio directly instead of a page.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/fuse/file.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 2af9ec67a8e7..8a4621939d3b 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -858,12 +858,13 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
> >         }
> >  }
> >
> > -static int fuse_do_readpage(struct file *file, struct page *page)
> > +static int fuse_do_readpage(struct file *file, struct folio *folio)
> 
> Should we also rename this to fuse_do_readfolio instead of fuse_do_readpage?
> 
> >  {
> > -       struct inode *inode = page->mapping->host;
> > +       struct inode *inode = folio->mapping->host;
> >         struct fuse_mount *fm = get_fuse_mount(inode);
> > -       loff_t pos = page_offset(page);
> > +       loff_t pos = folio_pos(folio);
> >         struct fuse_page_desc desc = { .length = PAGE_SIZE };
> > +       struct page *page = &folio->page;
> >         struct fuse_io_args ia = {
> >                 .ap.args.page_zeroing = true,
> >                 .ap.args.out_pages = true,
> > @@ -875,11 +876,10 @@ static int fuse_do_readpage(struct file *file, struct page *page)
> >         u64 attr_ver;
> >
> >         /*
> > -        * Page writeback can extend beyond the lifetime of the
> > -        * page-cache page, so make sure we read a properly synced
> > -        * page.
> > +        * Folio writeback can extend beyond the lifetime of the
> > +        * folio, so make sure we read a properly synced folio.
> 
> Is this comment true that folio writeback can extend beyond the
> lifetime of the folio? Or is it that folio writeback can extend beyond
> the lifetime of the folio in the page cache?

This is true today because of the temporary pages.  We can have writebackout for
the range of the folio outstanding because the temporary pages can still be in
flight and we might have reclaimed the folio that existed for that given range.
Once you delete the temporary pages thing the comment will no longer be correct.
I'll update the comment to be more clear, thanks,

Josef


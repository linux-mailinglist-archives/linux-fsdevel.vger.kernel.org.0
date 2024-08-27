Return-Path: <linux-fsdevel+bounces-27467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF0961A03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C862852A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8281D3629;
	Tue, 27 Aug 2024 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rf9n55u1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD184D34
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797537; cv=none; b=oW4SW748axLrPpSKeFhdxMqkVKfXKCxF9W1+i1LOPJH2HwwT2Mj9NBUFpxvMTZ8G8IHtgvaPgpKHjwNiM7/1/LPnKOyaXcTZGvnVfuDbeFKj94pI8vUQ5mD/lo60eQl5rR4rZ048rFu20SrDC2WDSOyrbVwUwrigS/wnq6cs6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797537; c=relaxed/simple;
	bh=8voWOoebk8WNYQFzTsVgjofY9MilDMZXEBiXFTyu3aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDQyJvJZfwPRArqkO2y7JWr3cAK8pgnMWYUQokhPZgtsU352XLV2lDZUgDB/Lfjh34xauumum8yFMN4kcqafXupk8nKQUYA+pty/W67I2x1t4LyJ/7cyvGb67K2UbVBbTxwudoDF+3sX1r5Us6Hutpk0N+wsmECQEJ9rHeD0/jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rf9n55u1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c159150ff4so32908026d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724797535; x=1725402335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g/K/BshCyBkAe+vKButsAKZOF5DmN0QxMCOIa3D0td8=;
        b=rf9n55u1bd0N/hc5/tjDmuremEIdSnLwFdvtzvN77ZevVEBfBp7MutKD7r6iCuEO/1
         EY0VADXfuOwuaFfjN0KHT863cP5jlfb+CUwkjl76PPiiGDSX4qt734/c8gnFowNWsDjJ
         g6pBxZQOoAGA7rC4kPCdrpfi9hdrs35VnKjcgHj7jGTMjrD/6cVusR4Olu73yyZ+U0Sq
         qcvitMPLOnOWTXPMdnln+EhUUY6cwNMH01oRT9uCQqE6/Pf8E38c+WEca85T/AfSWjz9
         X1sRLgHtlvGVKQs8oxoVFwW3wlLVibM31yHAfAFYMeiJ0i9IiuscdGQXS9BO4UWXvaOm
         4XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724797535; x=1725402335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/K/BshCyBkAe+vKButsAKZOF5DmN0QxMCOIa3D0td8=;
        b=gIJVWOujA9sRVgntHGd6Dq0tPqoAl3W4icuHalRkSgQTstA15xgyO5V6UWwILVoMBi
         SwiQFa4WRaadbpFP6gWvEvdQhbUGY6LeeSnh+UGs4TabFALw6sLlCXq9lOMMSX3KXA/r
         /ckGb+jkHUbT2x4B9cbinJv4guJM39Pw1TWIVF9aZHeMTsDCW7XVfW+tvVdVXjfDVm5k
         sxvmkSSMw3AbrdI1J6V+FTK4km1b94LRNxf5K2uEGqnOZduiKA2TrSK7f7dhC3EQvUFF
         iOw+cc1ZFQG0Xnulq73mA4hBDuv2tleLJksigXVdQrec7CbvDqiG/ZdRrhSUwVAgLmN9
         jr7w==
X-Gm-Message-State: AOJu0YyR6cHng8/Bd07C2Wn3qfBZY2f19yUqoreiyk92CuHnjeWCHMbJ
	z467fDDQ7F7JEMnYEd1QaZd2ZVjR+tDTwL2N4rpVNe4vRJzA73XRb3RKl2Ks0qA=
X-Google-Smtp-Source: AGHT+IG8QUnb0+nR0Jz+95gePPVB7YLdfxY0HWnjKwj7u4xtb4dy/5NJ7M7ZDdYNGDxWvis2J+5Bug==
X-Received: by 2002:a05:6214:2d4a:b0:6bf:a9c0:e589 with SMTP id 6a1803df08f44-6c16dcbf3edmr178272436d6.42.1724797535222;
        Tue, 27 Aug 2024 15:25:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d0e6sm60216796d6.15.2024.08.27.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:25:34 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:25:33 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	bschubert@ddn.com
Subject: Re: [PATCH 03/11] fuse: convert fuse_fill_write_pages to use folios
Message-ID: <20240827222533.GD2597336@perftesting>
References: <cover.1724791233.git.josef@toxicpanda.com>
 <fb8b6509ff4f2f282048de6884f764f2eeefee12.1724791233.git.josef@toxicpanda.com>
 <CAJnrk1ZKo70gkgQn0uLuy6QFYPJwhujxcZBS+GFj_X2_-kpS0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZKo70gkgQn0uLuy6QFYPJwhujxcZBS+GFj_X2_-kpS0g@mail.gmail.com>

On Tue, Aug 27, 2024 at 02:30:49PM -0700, Joanne Koong wrote:
> On Tue, Aug 27, 2024 at 1:46 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Convert this to grab the folio directly, and update all the helpers to
> > use the folio related functions.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/fuse/file.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 3621dbc17167..8cd3911446b6 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1215,7 +1215,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
> >
> >         do {
> >                 size_t tmp;
> > -               struct page *page;
> > +               struct folio *folio;
> >                 pgoff_t index = pos >> PAGE_SHIFT;
> >                 size_t bytes = min_t(size_t, PAGE_SIZE - offset,
> >                                      iov_iter_count(ii));
> > @@ -1227,25 +1227,27 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
> >                 if (fault_in_iov_iter_readable(ii, bytes))
> >                         break;
> >
> > -               err = -ENOMEM;
> > -               page = grab_cache_page_write_begin(mapping, index);
> > -               if (!page)
> > +               folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> > +                                           mapping_gfp_mask(mapping));
> > +               if (!IS_ERR(folio)) {
> 
> I think you meant to put IS_ERR here instead of !IS_ERR?

I definitely did, so now I have to go look at my fstests setup and figure out
why this didn't fall over.  Nice catch, thanks,

Josef


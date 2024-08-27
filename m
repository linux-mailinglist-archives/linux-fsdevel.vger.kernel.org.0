Return-Path: <linux-fsdevel+bounces-27464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014379619FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344341C22B50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3561D2F6E;
	Tue, 27 Aug 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wudn2HU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7DB19D093
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797428; cv=none; b=fZ+NYpFY7TT+3BnBS6LrInmEIr64iRWtz+ePBuhp8mtpp6q2RBQDgtblRZIxJo9z6GDfkL/6ZkTh+ChcYF0BvtqEmLcN7F+40bgOcexcECVUXZTxceTfmEJEJuaV1TKtiTcsxGRB472caXifGSRg5rveX9v0svmh/apqZMYG57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797428; c=relaxed/simple;
	bh=b9SDGmNt6656M9W5DL7OyNVJ8S2CtWSOZfxjs3nfiKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKWGKyPVyTwR/Pv/TxxF2dr0rWi+rqyDSdWz1ot5Sycxx06cRMpOHIaCpEnrO1NSYaE/z4nJJWesj2R2fNrgBSVzIhQ2JWjMUH84M9eeMS0S8JSR3+oy9QH2BLiWk3jXDYD8ARoCZL/h1GLSA/aNZm50pEGAqM0CARV5gLGA3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wudn2HU4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6cf6d1a2148so18703707b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724797426; x=1725402226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zI4fpOLoArup83gBqntFnOYw0p5F4fPLZG1CCAHaic=;
        b=wudn2HU44LM1qcVqfdrajzd29XOFAXjFWASLl+24xvlOfCRBmDlBJTHaogM9t4VSqG
         RIGxs68O06VVzVHEHDmkymHQdQlMHTgkjT1P7HjTccgclZhO55icpnkGPleuThIycuso
         ILNZ4hLENV261OfiJzXlYmK3eyIssuDQUwlCLEdU7oFiO6NH1Bx9BIglCIflp+aZZ09B
         B4UbtSTttpSQTCzqDL52HhLXjaR1LAeGXaaKRQwv0CnEqtOC1C6raIH/m5CInfKFNvG0
         ABtF7ikD8qYMoDSWITPkyE2Wq9sc4JiN9WbSCn9nUjNJdkjOQ1NFEnmuNoZc+gF0OgXa
         bKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724797426; x=1725402226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zI4fpOLoArup83gBqntFnOYw0p5F4fPLZG1CCAHaic=;
        b=mEYLzddv8+x6e4rqIHtC5VubeXcYnR9O2rkMJZzghzvhwaW9sefaHcyW+8Y/huCJ48
         3KjzBEA+TSz/iqMB6kwMWjNPURYPiJQs2S3/sMO4E2Es16ZQNHCmbYC9RnYSK6IUzrPE
         IOM7cV27V2Rt58/mhkyQJEl59Y9fEyGg9KfgBRg1JJseIwidCUZlCvg9K7Z7IS4lBevn
         hO5ONw5DFN5yWSZO7um2/5vs0Css6WoJKjhUDx7e0hbza3yUr9Ha064aVo9BBFdAv7eR
         362dQqVMfP6iKxgU2+oouBDw4YPRGlU3IpSgI9XJNrpHN+6Ft20OTc5Ieav+zvX7Vh5u
         4k/Q==
X-Gm-Message-State: AOJu0YwsREBLlrlMqZDgBjVVKmwJtLJSrw8lY3ngici+DITO/EcdMfLE
	9As5Pg/GG5jposjjLt6EG/88aI+0Tpb7uTVAJIAUDQyv1s77s37t8/wbLEWf2qQ=
X-Google-Smtp-Source: AGHT+IF2mRxXdEHWCwuMR1DJr5NZv1QXpkhsOdveXeQ3J04+DMFTJEAVuP+7E/ci9G5MHnWdjA7MWw==
X-Received: by 2002:a05:690c:6985:b0:643:93dc:731c with SMTP id 00721157ae682-6cfba392bf5mr51675067b3.17.1724797426261;
        Tue, 27 Aug 2024 15:23:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f318e5bsm590269085a.20.2024.08.27.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:23:45 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:23:44 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, bschubert@ddn.com
Subject: Re: [PATCH 01/11] fuse: convert readahead to use folios
Message-ID: <20240827222344.GB2597336@perftesting>
References: <cover.1724791233.git.josef@toxicpanda.com>
 <aa88eb029f768dddef5c7ef94bb1fde007b4bee0.1724791233.git.josef@toxicpanda.com>
 <Zs5JUcQlI13LG8i4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs5JUcQlI13LG8i4@casper.infradead.org>

On Tue, Aug 27, 2024 at 10:46:57PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 27, 2024 at 04:45:14PM -0400, Josef Bacik wrote:
> >  
> > +/*
> > + * Wait for page writeback in the range to be completed.  This will work for
> > + * folio_size() > PAGE_SIZE, even tho we don't currently allow that.
> > + */
> > +static void fuse_wait_on_folio_writeback(struct inode *inode,
> > +					 struct folio *folio)
> > +{
> > +	for (pgoff_t index = folio_index(folio);
> > +	     index < folio_next_index(folio); index++)
> > +		fuse_wait_on_page_writeback(inode, index);
> > +}
> 
> Would it be better to write this as:
> 
> 	struct fuse_inode *fi = get_fuse_inode(inode);
> 	pgoff_t last = folio_next_index(folio) - 1;
> 
> 	wait_event(fi->page_waitq, !fuse_range_is_writeback(inode,
> 				folio->index, last));
> 
> > @@ -1015,13 +1036,14 @@ static void fuse_readahead(struct readahead_control *rac)
> >  		if (!ia)
> >  			return;
> >  		ap = &ia->ap;
> > -		nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
> > -		for (i = 0; i < nr_pages; i++) {
> > -			fuse_wait_on_page_writeback(inode,
> > -						    readahead_index(rac) + i);
> > -			ap->descs[i].length = PAGE_SIZE;
> > +
> > +		while (nr_folios < nr_pages &&
> > +		       (folio = readahead_folio(rac)) != NULL) {
> > +			fuse_wait_on_folio_writeback(inode, folio);
> 
> Oh.  Even easier, we should hoist the whole thing to here.  Before
> this loop,
> 
> 		pgoff_t first = readahead_index(rac);
> 		pgoff_t last = first + readahead_count(rac) - 1;
> 		wait_event(fi->page_waitq, !fuse_range_is_writeback(inode,
> 				first, last);
> 
> (I'm not quite sure how we might have pending writeback still when we're
> doing readahead, but fuse is a funny creature and if somebody explains
> why to me, I'll probably forget again)
> 

Ah good suggestion, I like this better.  I didn't read carefully enough and
thought the waitqueue was on the writeback struct.  I'll rework it in the
morning and re-send once the tests run again.

> > +			ap->pages[i] = &folio->page;
> > +			ap->descs[i].length = folio_size(folio);
> > +			ap->num_pages++;
> 
> I do want to turn __readahead_batch into working on folios, but that
> involves working on fuse & squashfs at the same time ... I see you
> got rid of the readahead_page_batch() in btrfs recently; that'll help.

Do you want me to tackle that since I'm messing around in this area anyway?  My
only hesitation is we're limited to the 32 folios or whatever the pagevec count
is nowadays, and we may want to cycle through more.  But I've just finished
eating dinner and haven't actually looked at anything yet.  Thanks,

Josef


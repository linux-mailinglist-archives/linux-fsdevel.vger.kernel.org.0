Return-Path: <linux-fsdevel+bounces-27465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216879619FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34C3284771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7FC1D2F6E;
	Tue, 27 Aug 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gRzLFNTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F819D093
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724797483; cv=none; b=jfnb/flOFcriPokBbCAQmUoJWszZcftH+BZF3lHzjXiFJP9nyusP0LbOrZk59WUATGV+IFaE/rJJzCmhd/mHOetHvEKpOgMRyvF0Ilp5ltOuDD+R8485V3nhMAM79+PZJhRjq/8QCo1tux+aHw2XjQBsRF/IJW4Mff8s5sbZudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724797483; c=relaxed/simple;
	bh=QSv9sfNQ9nPqKQcMyb6Aw/47oEuQCp13uVD9uwRCdbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/pfbvQyOtgYBs/ol7PDoBd7gvt4atDKNkTWJThRqgZ+JzJs6mxA0pOIrXWr6gghhPcMVU3taytZoP1h6x7XbsaUP61YefI/cCvUXmJX8W5xg9F+43kFcXif+epiN/LklTdxRLBNXpWSMnFfoDxuZWzxUFCAofNzRZxcm2SiVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gRzLFNTE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6c130ffa0adso60869397b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724797481; x=1725402281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAiGkpbHBNvbEXUC3Gy2JORT85kIk4KOIIfoi/1wreo=;
        b=gRzLFNTE1ApYPhSYM6gwdIsdIAg+ngyUnbP4+lMPe5oXwkK4Qk5eVHrstHgDTISZni
         n7S6nmJ1VYwxVnPdxkjd3oFqJHn9TPmSZqXq4e3NmguElTJJ9WrIGUglcit28rIpy1gI
         BlY6tFCQwEkI/d5edYFCxTwc4GP0YJbr0XIsfGC1gcyoLvtMeRocJV1xz/algY5BjBxl
         PEVnrP2skJrgyJ7VFsoDGN3ITVa1HCmnY1U3smZO63l2bs4lX+SJfd5/JIO3MSGlDyeC
         hBbrxll9akktY4wf7zk1Bcvu/uWSMxnlhMITAPxpm8AL/3DoEEzr3PW+kosBCE5s8aKk
         F3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724797481; x=1725402281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAiGkpbHBNvbEXUC3Gy2JORT85kIk4KOIIfoi/1wreo=;
        b=E4V7s/8dD2gR/6+/heV+FvAk+12/pnsLfRc/ddY9yE4yjHS+N/P6J505laB7sIRuRu
         SS7ZYsFJ+mITPEQwkMv+dyVh5PMzN3z1SXpG8kaicGBqpy3DI6bY9I1k2uNgjFroCcKO
         ++OPsr/xJQXMko/CbitGwX8BcIlpwxXmd3n2REdvq7KZUGelD8cLdQDD+MCDnfj2sEE2
         d/uO5VWKUbfqROwr5aysEPREx6TaHsTBDqxzMQh1+8xDv89wevssUIODZNO6JngYtIPy
         oSVDvWwZ/IjTFYRlLSz5XL1NZZPXvOw+aoCVfzuAzvf3+Rinf+wTqCr5fcUcfUJrV7XQ
         gLiA==
X-Gm-Message-State: AOJu0YxwKYhnEn4sZOzHEF5GEcIchvc9QBastItqEv0J4hnBGAheTk/f
	uDgKHJVsIKNnWLeiXCKG779mu7z7U4ibJAEHxzVHOaZI6bqBFeN4IQjQJHr1gsE=
X-Google-Smtp-Source: AGHT+IHHvBOj0B9po4NoXUv2FfXZkCt2wi7v9cgQxI0bc26gXpV6ewoRVJNYhtAhLc2Ltm2TxaA4lQ==
X-Received: by 2002:a05:690c:113:b0:6af:8662:ff43 with SMTP id 00721157ae682-6cfbbccc1acmr43461897b3.37.1724797481019;
        Tue, 27 Aug 2024 15:24:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3473a7sm590776585a.32.2024.08.27.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:24:40 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:24:39 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, bschubert@ddn.com
Subject: Re: [PATCH 02/11] fuse: convert fuse_send_write_pages to use folios
Message-ID: <20240827222439.GC2597336@perftesting>
References: <cover.1724791233.git.josef@toxicpanda.com>
 <ce4dd66436ee3a19cbe4fba10daa47c1f2a0421c.1724791233.git.josef@toxicpanda.com>
 <Zs5K9qOgAQVKYD2U@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs5K9qOgAQVKYD2U@casper.infradead.org>

On Tue, Aug 27, 2024 at 10:53:58PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 27, 2024 at 04:45:15PM -0400, Josef Bacik wrote:
> >  	for (i = 0; i < ap->num_pages; i++) {
> > -		struct page *page = ap->pages[i];
> > +		struct folio *folio = page_folio(ap->pages[i]);
> >  
> >  		if (err) {
> > -			ClearPageUptodate(page);
> > +			folio_clear_uptodate(folio);
> >  		} else {
> >  			if (count >= PAGE_SIZE - offset)
> >  				count -= PAGE_SIZE - offset;
> 
> I'd tend to adjust these to folio_size() while doing this function,
> just so that I don't have to come back to it later.
> 
> Either way,
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Same, I just glossed over this one because we weren't touching the folio
directly, I'll fix it up since I have to respin the series anyway.  Thanks,

Josef


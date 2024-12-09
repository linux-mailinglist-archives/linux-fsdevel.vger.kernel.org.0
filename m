Return-Path: <linux-fsdevel+bounces-36811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2F9E9973
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47997167B7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C21B424F;
	Mon,  9 Dec 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OoSJJJOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2B35962
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755799; cv=none; b=lJ+PRF3In5k4gFxQnos1Kt84rekvYWsJr1nzjnDQhlaXKJ6YklGQlVveM0d5Co7qV7lmCJ0Ugr853jlbVl7b/NkAU3sD6t/L/T0OJMyWIxTGOKsbIBb0DlJihbXXKH9gZOISOI5YO/2r0lh9tSccRU9CkWfwtlO0j0s7JTQmaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755799; c=relaxed/simple;
	bh=1DD/VPS3YedT9wXVboebKxspdQ2Cly2cWtlepqqpCW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKwQ4gjvZtChuO8guW45xQt6kZWsdkhLbL7EIwM/hKJMgVcLU0Ozs56CbBYRyopSey/XfGNXKjHE4u2Pnf0RHYxXLPjD7JjaO796K43xkI8MqJ+0XzmptAhSVXzrgPOXo9ySOLnji9+93DE6ptUYWBmcZHG3CL3UwmVwFAcYdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OoSJJJOE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6c375b4f0so141114885a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733755791; x=1734360591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qbBQTxluzab7W0cWRxjXbWPKnKnd8xWDnNL0CWJ9Vls=;
        b=OoSJJJOEmEBCKnAoDbXA4ycZwm3Jtzk6Tqns9DOjBfQgff1Xy72mOjmtqD6CNVoHXK
         /umcqfZZFHwFNQiEPRxl3KGxnSvFgQAPsPz1U2IHleutV2IAh9lR2ZyINFow76q/DSw9
         vKJzF/A0Na41RYwCnamrlIMbQ8Mujv1JzJmbWoGIgALZfkh4/mLO2EeD9FXc5jG89VU/
         tii2picVBcZk7l1wY4fsZIbDczNhprD/WvETaNzLLv0afqUDf6UuCU+WgCPZGjxvkDb/
         FRmvc51IwTMKLexfgagrxI7193fqG/qypDXH51gzQ5MHpXiPcGX6nEUkoVUD7eEYKZCy
         jpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755791; x=1734360591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbBQTxluzab7W0cWRxjXbWPKnKnd8xWDnNL0CWJ9Vls=;
        b=jARZ8s/a0COgTs/mh/ZnvIfuwx0mOSieMTs/2a6jQy+bXiN4eeggKxZtrJYSAqZoKi
         QFe5KZnRk5sAGXrAF8S6Ky5ph8JdZROXhR2greluwiqJxH4TBeNfRuA9piiT0FEQAF3P
         x1HlQf63avdjCZ/8I7zJfDK9rQDIS4AcKEBz1lTkAFtc9zbflANH6qQHce+2BQew5P0H
         7WQR1Nd+67m/LGZRNEKk50qetvWTlI55F6/3/XrLPuqE0efGF1GKqy251g+bUPpmhdrC
         4/o760p+AAVpOxL4rt0jZyq1YgeWDsjFX5SyY7ixvc+VkeoLvC97Pli5of261LDxjRKb
         NaGA==
X-Forwarded-Encrypted: i=1; AJvYcCXxbe1K9gKzaqSv1g9nSDcaZACpGO9/NBxBJSkJ9MdzSwk1+zFviyXKkzBDGAfxz3KZvWICkoNc4bU9mYRO@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMdL5pc5vj1CGGBgDX0MAN3BgvCsQxF4YRkFqb30oFwFg7Sla
	GvwjLJIxMXJdjcXv8bd6VpwdLu5YLUhw0oxmZ284+DH/0ViCyxQU7Zxk55koADc=
X-Gm-Gg: ASbGncsRO4MDt6fBJWh6NczC7osd3ATx2f+Y/ssWiwv67aj8s5Lzaz5PmR9tNRKtjne
	SXEdz3zMUI0TcOmgEmfHtmGQyjVduAh49pDpQR8avkGl6f0dDWLJ7Rfqw3rcnkHScOqdi0jJaqU
	7UgLjl+uBQgHn39FulLzGq94Unx08ROyKlyL5b2ZNn5aJBnN0CpkYl4b4lGBKJ7ee+c9RAet8HV
	GbFKYALbQBem1FyYvg2IAO2tn0hmgx/cBjI5TmxgXCyk0dtmP9l02N13tOZDS8WIAwyrmMyGMkH
	5aX5wk2rfwE=
X-Google-Smtp-Source: AGHT+IGY/LUBEPwYTnWytZrcN8aK4xcmbyphOlMfZwdxdihARYqzRenfKzrn+S7M8PfSrrYob6aW3g==
X-Received: by 2002:a05:620a:294b:b0:7b1:168f:52f5 with SMTP id af79cd13be357-7b6bcbb2e1bmr1959046885a.57.1733755790872;
        Mon, 09 Dec 2024 06:49:50 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a9e5ffsm446382985a.111.2024.12.09.06.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:49:50 -0800 (PST)
Date: Mon, 9 Dec 2024 09:49:48 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <20241209144948.GE2840216@perftesting>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>

On Sun, Dec 08, 2024 at 11:32:16PM +0100, Malte Schröder wrote:
> On 08/12/2024 21:02, Malte Schröder wrote:
> > On 08/12/2024 02:23, Matthew Wilcox wrote:
> >> On Sun, Dec 08, 2024 at 12:01:11AM +0100, Malte Schröder wrote:
> >>> Reverting fb527fc1f36e252cd1f62a26be4906949e7708ff fixes the issue for
> >>> me.     
> >> That's a merge commit ... does the problem reproduce if you run
> >> d1dfb5f52ffc?  And if it does, can you bisect the problem any further
> >> back?  I'd recommend also testing v6.12-rc1; if that's good, bisect
> >> between those two.
> >>
> >> If the problem doesn't show up with d1dfb5f52ffc? then we have a dilly
> >> of an interaction to debug ;-(
> > I spent half a day compiling kernels, but bisect was non-conclusive.
> > There are some steps where the failure mode changes slightly, so this is
> > hard. It ended up at 445d9f05fa149556422f7fdd52dacf487cc8e7be which is
> > the nfsd-6.13 merge ...
> >
> > d1dfb5f52ffc also shows the issue. I will try to narrow down from there.
> >
> > /Malte
> >
> Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
> with 3b97c3652d91 as the culprit.
> 

Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
got a hugepage in, we'd get each individual struct page back for the whole range
of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
->offset for each "middle" struct page as 0, since obviously we're consuming
PAGE_SIZE chunks at a time.

But now we're doing this

	for (i = 0; i < nfolios; i++)
		ap->folios[i + ap->num_folios] = page_folio(pages[i]);

So if userspace handed us a 2M hugepage, page_folio() on each of the
intermediary struct page's would return the same folio, correct?  So we'd end up
with the wrong offsets for our fuse request, because they should be based from
the start of the folio, correct?

I'm coming off of vacation so my brain isn't fully engaged yet, feel free to
point and laugh at me if I'm wrong.  Thanks,

Josef


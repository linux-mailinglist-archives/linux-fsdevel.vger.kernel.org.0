Return-Path: <linux-fsdevel+bounces-20378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FED8D27FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 00:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1A21C20BBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52D13F447;
	Tue, 28 May 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m6DeYh3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661B13DDC7;
	Tue, 28 May 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935037; cv=none; b=R/0ufSndIOuH7O10ToBLiw/0lYDHehdxViof3I0fqWV4G6KScMNrwTa3o/I8XWc4Zyf/8J98S9rtLyzp1F0DynOnZq3pG3pnaFeMJle6ZBx6tVp6k3RFR16AUolWKbtarUGF6Ie5ckv/0n5ANCc5M99AtQqyyL8mekHfJH7GAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935037; c=relaxed/simple;
	bh=G3YierNArA4BFLLcWX+JHQ7e9EYFI0xTNkmufDNDMug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMOXLOq3Rt+3wEIvgZ7CxWD5LM+ztPtYEZGYU76sXG1liV9YPqP2/zi0KbhlArN9CqIJRgnLiBBc0lGhsLNfR/+pXdPMKf3Yx70A45z4yfmcxqbKxWFYC542kTc620PAPqZfGQVkb4fqnkZ6I//SmdHs0GEnmqGUjR4Osfbd4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m6DeYh3K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sOt3kmCrcl0gPb1/Ru/FCAYrnK6kWas/sJfOYmKK23Q=; b=m6DeYh3KLu18Fl4IPvC4OVLaOx
	CfP/wQPOg8HhGZyGGqTCCKii7vC3gWhWLwaD20m6nrDWd8b8Sv3aaPuaF/N+Yc0lPysT6Vm94T/Dm
	wkEfOMigPKpenFE+ZBpFeCorM3pVEZnuQUZhkJ+mAOUKQdQhEBZPF3NzKyrbvSfOpx7Ym8WsCqa5C
	MjpKk+LAlM8RWXSVty4+SEgsKAY2BbW37aWAu1WtoLGEL6JA0unyuvXa7cjVz95gfs5O8stA2o1l+
	6DKBjqN5rQ9mgY4PMrQr8qVDfnN251LhbNStR5C6N5O+I23smWixeIoW2d2YewQ0PMNG9/fe6uNHr
	apii4wYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sC5EY-00000002CII-2jKi;
	Tue, 28 May 2024 22:23:54 +0000
Date: Tue, 28 May 2024 15:23:54 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com,
	hare@suse.de, john.g.garry@oracle.com, linux-xfs@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC] fstests: add mmap page boundary tests
Message-ID: <ZlZZeksxGmXuTGpU@bombadil.infradead.org>
References: <20240415081054.1782715-1-mcgrof@kernel.org>
 <20240415200542.bww7gupflrq3mqoo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415200542.bww7gupflrq3mqoo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Apr 16, 2024 at 04:05:42AM +0800, Zorro Lang wrote:
> On Mon, Apr 15, 2024 at 01:10:54AM -0700, Luis Chamberlain wrote:
> > diff --git a/common/filter b/common/filter
> > index 36d51bd957dd..d7add06f3be7 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -194,6 +194,12 @@ _filter_xfs_io_unique()
> >      common_line_filter | _filter_xfs_io
> >  }
> >  
> > +_filter_xfs_io_data_unique()
> > +{
> > +    _filter_xfs_io_offset | sed -e 's| |\n|g' | egrep -v "\.|XX|\*" | \
> 
> The egrep is deprecated, please use 'grep -E'.
> 
> > +	sort | uniq | tr -d '\n'
> 
> Isn't "sort | uniq" equal to "sort -u" ?

I'll try both suggestions.

> Do we need this filter to be a common helper? Will it be used widely? If not,
> this can be a local function of below single test case.

I suspect it will be but its OK I can stuff it alone, same as for
_mwrite() too then.

  Luis


Return-Path: <linux-fsdevel+bounces-50409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7749ACBEDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 05:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB257A3240
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 03:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237C718A93C;
	Tue,  3 Jun 2025 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZtEQGpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8033211;
	Tue,  3 Jun 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748921198; cv=none; b=XdvKLw4HsU934wlxoIFPO5shEKYC1foeetsBTEukC9dJ3cFCDphyHnqmd0DIs8B+0AIF9gWXCX6QICSPjTUVRF5G6kN/tvzd4ebte2R9vnG6aw2BYQRyeuUnFLvF9PTCb0NoEehp9YoGGGHeEk9XhtCebJREnkTZNWCFeHUu13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748921198; c=relaxed/simple;
	bh=BCMZ1eYujkh1y8Q/9kDANkAENipHaCde4ieX/4dotDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la1SDwKlwnsuqxZi8vR7qJK7b/bBFEgrikx+Bwx448W3v4VPTXAGEJYJGwJx51dBEGIxX3OK5FJoIk//zQpz/7naSaeE/g1AiJhMZwYae8xXaxm+lp1XF6HDoJ0LThdRtHB5T9MVDz96RsvusRradNA7cAjdIfFaiWs5+ImHGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LZtEQGpP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=uQfXz04lJdl+n/PeQbWCeYTqhNEeDzdmvllLxqUF27Y=; b=LZtEQGpPO5UDiyvvncRs4lyvgT
	JUfnTcQsdx4ECw7rOZhKHHy2mb4tqVYOB+Sy5XqRdxXtPt70boDGNcFv0r5tLMZN6w3GFWnmwpw+D
	pZzhjXn2qjVpmmgNh8SV3ee2RVsBBMYMPRxfojxSbcCohCPhc4/GjV5ZgzpAunMMxiKjcCW6i9j3W
	IUlLLnfmgke0xnuqnioXTwWxsEUNu3mh5WcfY1JEc0UcEhaZZ0qI6sgfZGax5BWplXvx9RlpPmYXl
	Xc4B4sJIfg8Kp5GbEiH+PJXb6nIAEmlPMNX8ifTbTTg88gClDifz/Gpdbg8MgSgD+nmDZpCyFVWhR
	tXzq33gw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMIIM-00000001b8F-3ZIG;
	Tue, 03 Jun 2025 03:26:34 +0000
Date: Tue, 3 Jun 2025 04:26:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD5ratf3NF_DUnL-@casper.infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org>
 <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org>
 <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>

On Tue, Jun 03, 2025 at 11:21:46AM +0800, Yafang Shao wrote:
> On Tue, Jun 3, 2025 at 11:13 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jun 03, 2025 at 11:03:40AM +0800, Yafang Shao wrote:
> > > We want to preserve disk functionality despite a few bad sectors. The
> > > option A  fails by declaring the entire disk unusable upon
> > > encountering bad blocks—an overly restrictive policy that wastes
> > > healthy storage capacity.
> >
> > What kind of awful 1980s quality storage are you using that doesn't
> > remap bad sectors on write?
> 
> Could you please explain why a writeback error still occurred if the
> bad sector remapping function is working properly?

It wouldn't.  Unless you're using something ancient or really really
cheap, getting a writeback error means that the bad block remapping
area is full.  You should be able to use SMART (or similar) to retire
hardware before it gets to that state.



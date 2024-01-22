Return-Path: <linux-fsdevel+bounces-8463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89ED836FF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 19:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA59B23C1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E309D59B56;
	Mon, 22 Jan 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IbAKtfIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435959B48
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945036; cv=none; b=n09Nl1OLA0U+qoeibPnvPWw2kBKj6PBvhEvxwMK7JE0xqDFFdaeb6ulEa5u3ytu03uIuSJlk2yWay38y+H7pbZNJKX+MJ+tq2cjHk5JnAAp8YjQPgn2+0bmnLKxIfCv9j5ip/en5AUTeiAnnmpYlKECLd7lZN5Y8diflymxXS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945036; c=relaxed/simple;
	bh=7oW2ygf/R4NOOuR1/3OVCn1os0kXAPaygVIe1RCRxRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoCHLix1NSu2H1zfGgbWNqNPqcOSfym0a18IUayLJH04oPl2xAZQt8vuIp8yypRDcE5LRfY53DUYUbztCxZk7VgV/DIJF6qnIJM76hXHWc5EO8c9v7Ehv4XiS5VXEtipy+Zk9DXX38xDdfwajHHD5OdbB9E93BMpJxC1xbPtAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IbAKtfIN; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Jan 2024 12:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705945033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ko1en39Mz81OxmDtbi4HILjfWQbEJahzz6e5je84bnE=;
	b=IbAKtfING47TOR4vk7sAEptdcDFCBdIxxiZzILzl2Goj2FIkhiNBGQMrp/0B2beOHPIu+J
	P/zLpJ041SVSWyANlExp7Vx84SsSQgz0Jr5qC8ttmEEfUb/mH9X1u7bRxhgMEPeW6Mj/1P
	qqn0hjkb/fBV8lYfIHuzBlEkAfhez38=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <3cs7zhkf3gz7fmytpxqjvstr6oegvhy3ehwu3mzomfllvjqlmc@yaq6ophbgbfr>
References: <20240111073655.2095423-1-hch@lst.de>
 <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7>
 <20240122063007.GA23991@lst.de>
 <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4>
 <20240122065038.GA24601@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122065038.GA24601@lst.de>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 22, 2024 at 07:50:38AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 01:37:45AM -0500, Kent Overstreet wrote:
> > > Without this patch as in current mainline you will get -EOPNOTSUPP
> > > because sending REQ_OP_FLUSH and finally check for that to catch bugs
> > > like the one fixed with this patch.
> > 
> > Then why did the user report -EOPNOTSUPP with the patch, which went away
> > when reverted?
> 
> I have no idea, as we never return -EOPNOTSUPP for
> REQ_OP_WRITE | REQ_PREFLUSH this would be odd.  According to your
> report the users runs a Fedora kernel and this commit never went
> upstream or even into linux-next, which doesn't quite add a up to me
> either.

Ahh - I misread the bug report (fedora puts out kernels before rc1!?).
Thanks, your patch is back in :)


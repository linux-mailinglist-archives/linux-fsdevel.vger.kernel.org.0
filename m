Return-Path: <linux-fsdevel+bounces-35830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02A9D87CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5685E1639B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AD1AF0A4;
	Mon, 25 Nov 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcQ8HskA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C772184520
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544589; cv=none; b=sDv5a+I4TAZzEkqzZC1NoBFTJcLlgRSNhe6pmmBveqHYmIKD2KKeD12iuTppwzXky0z2TDxtbGwKjXLERsXYzDpn4q51Ndoud0uRQpjrQ3Xaq54Fk8ZE9x+T/tUdnjZkP49X2u/+zMGp66wZnV3Ob4yOqsJk6R4HZLdjnwCiR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544589; c=relaxed/simple;
	bh=mzFtFi8tS5ParM7f2yAdocYFReuH1+YTGrldb7G7fvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb4+I35T2Xuv43D1KG5ACQh0QZpMbb2tYmkG7x4Qt/qzmuGPnQGAYb5PKEGFxc2ri3f3StzVy3VkFurT8kxLVTNCAzRmsfyw/MT3l3jfZVo8M7l+/5AOhbb8gQoe8xCDg6Rwil0T8NIcr2g3o8/8zvVomUoXuhTAJynLXezOCig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcQ8HskA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02824C4CECE;
	Mon, 25 Nov 2024 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544588;
	bh=mzFtFi8tS5ParM7f2yAdocYFReuH1+YTGrldb7G7fvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcQ8HskASIOtyrXRQIGis/4lLFYBgfvVb7lOlKfS4H2N32tBV2WheSF7Dk8eDG+vm
	 pAj41ekqX5W9gZBf8q2884tY/9TLltMGjwQAY3VtNNlrAMQXIb9PoUa5lr7+wRZxZE
	 3mho9YFhYewxwjIbGE1cPohYgU+RnWdRjJm1ZQUfJR9Zhr2okm1rsMRPE5NebUOqsZ
	 MxgIUJSMpC2Qzwo0Qp9w3iA0dj/nmFjcLkorSn2m2wo83nkatdZB/QyO/2b7MHC/nV
	 ZT4boVW+romiqGDKJCRrSuZUpCRrIR7vTrn5Du8Eck9FFvzyv1lF0/g1J6SOXwtS0j
	 buRMdlN4C/qFw==
Date: Mon, 25 Nov 2024 15:23:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: require FMODE_WRITE for F_SET_RW_HINT
Message-ID: <20241125-panda-kratzen-5b00ff0bd8f7@brauner>
References: <20241122122931.90408-1-hch@lst.de>
 <20241122122931.90408-3-hch@lst.de>
 <20241122125342.vmmjokiilvnuifuf@quack3>
 <20241122161547.GA7787@lst.de>
 <Z0Cz_xG2Dy9g0nvj@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0Cz_xG2Dy9g0nvj@casper.infradead.org>

On Fri, Nov 22, 2024 at 04:40:31PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 22, 2024 at 05:15:47PM +0100, Christoph Hellwig wrote:
> > On Fri, Nov 22, 2024 at 01:53:42PM +0100, Jan Kara wrote:
> > > Here I'm not so sure. Firstly, since you are an owner this doesn't add any
> > > additional practical restriction. Secondly, you are not changing anything
> > > on disk, just IO hints in memory... Thirdly, we generally don't require
> > > writeable fd even to do file attribute changes (like with fchmod, fchown,
> > > etc.).  So although the check makes some sense, it seems to be mostly
> > > inconsistent with how we treat similar stuff.
> > 
> > As I said I'm not quite convince either, so just doing the first one
> > is probably fine.
> 
> We do require FMODE_WRITE to do a dedupe, which isn't exactly the same
> but is similar in concept (we're not changing the content of the file;
> we're changing how it's laid out on storage).  So I think it's reasonable
> to require FMODE_WRITE to set the write hints.

I tend to agree with Jan. I think the dedupe case is different because
you actually use the file to perform a write(-like) operation whereas
toggling write hints is just setting an option.


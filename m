Return-Path: <linux-fsdevel+bounces-32253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A30E9A2BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 20:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4711F222CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024ED1DFE3F;
	Thu, 17 Oct 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZfJy1ssr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01A1DED44;
	Thu, 17 Oct 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188842; cv=none; b=TS0NiWLc5xqZ98TASvFTkjyAd1HrUbstuJBb7z/JWVMbeDmh6+lpUwfnkMWP97WX6Bi8mAIhN+ozvwqgdaJPh7IuHxUOlAkjY2D3/9PcBKuO3NSYtQg4hwfS2qwa5C3EJur+YtmQkXiEPnd0i3JCn8mhaFSk4D7ZekrIH0NOYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188842; c=relaxed/simple;
	bh=kUkNNVP6+jjnPwqhQegp7uCnP9DNVeCB4trUjQYckNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3O8QY0CaBkhzEc4rruAqfH32xrpgoRliSP5gTDwXTNEazhaIF/+WbWhksn6Wgpk37Wjhzi7+hggbl6pQqbu20GuqS9uTO6RU6SgRukjkr3lxfd+QQMkpszHIp38rLEdobf39koLGwiGHmZVJgJ6GzO2llJ2wkO3h0uIp1d640Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZfJy1ssr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qRp1fcAl7OrSQdyRT+c5HyENKgVLqxnX2sjNJABwNV0=; b=ZfJy1ssr8J46B7mhbGX8z9EDGq
	9hFvTbSkTZgU0alAiuPrjYrx5aEe+3OK8OCWcaWIp8SeVxO1GbyK8MrJDs25V8deJBDaRHfMmZZ47
	ImK1M0mRlRKtW8Hp9apupXOvpsRmDObZmG/mxeInC9rfXsSqXI6bUUhhVVQlOwhMdNDjzymPcrAn7
	MVmbOFNjZjeM88F4Er+aqypy7GXockguxEAsFg2qjMNdEdrCk9M6wDDxkA4X4Rm6b1FdPNyRTmOWO
	dSFOa8I7VPdQM2pBCBCIpdc+rVzTNStgyzgO/P2VM0+Hj6GWi3rApV+4Jk3TmOG8bIbh/lmg1dcQV
	U2SYCprQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1V0Y-00000004mG2-0e5z;
	Thu, 17 Oct 2024 18:13:58 +0000
Date: Thu, 17 Oct 2024 19:13:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Store overlay real upper file in ovl_file
Message-ID: <20241017181358.GL4017910@ZenIV>
References: <20241007141925.327055-1-amir73il@gmail.com>
 <20241017045231.GJ4017910@ZenIV>
 <CAOQ4uxh-P91UN4=jM-CgdGfD929PskvTVbuY0hFAU9N61cUuRA@mail.gmail.com>
 <CAJfpegtLp0cZp1COp64LFjx0QgBmfWo2C20_kzuNZj5RXBCN3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtLp0cZp1COp64LFjx0QgBmfWo2C20_kzuNZj5RXBCN3w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Oct 17, 2024 at 03:52:10PM +0200, Miklos Szeredi wrote:
> On Thu, 17 Oct 2024 at 10:18, Amir Goldstein <amir73il@gmail.com> wrote:
> 
> > It has been like that since the first upstream version.
> > My guess is that it is an attempt to avoid turning wdentry
> > into a negative dentry, which is not expected to be useful in
> > ovl_clear_empty() situations, but this is just a guess.
> 
> Yes.  This was discussed in a private thread before merging overlayfs upstream.

10 years ago ;-/  Sorry, memories swapped out...

|> BTW, why on the Earth are you pinning that ->__upperdentry twice?  The
|> comment about d_delete() makes no sense whatsoever - anything other than
|> overlayfs itself would have to grab a reference to call that d_delete(),

[snip]

Out of curiosity, which callers pass anyone's upperdentry to ovl_cleanup()?
Note that if we get dentry reference not from ovl_dentry_upper() et.al.,
we'll get that protection for free.  From quick look it seems that the only
such callchain is from ovl_clear_empty()...

Oh, well...  Shifting it over there would be asking for trouble later on.
Might be worth a comment in ovl_cleanup() - it is subtle enough to be
confusing for readers.


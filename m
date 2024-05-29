Return-Path: <linux-fsdevel+bounces-20475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709338D3EBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10C51C223C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35469181D09;
	Wed, 29 May 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="io8Jw4Ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F384335C7;
	Wed, 29 May 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009413; cv=none; b=gIoni7sKnOeJNxGTkwxC8EZtzGSjL0pn8x+CpQQXGF0xRj2FYw5IRIgN2QHe1i8V+4Z8AQhNRpZoG7A20N2+j5uOpb+KL+HhaYMxl/zpWufT8x777WzmEipu4gpj4OG9LkS+80D3zSiMpoSRTOdbgVkX0KZO2/b5iFYxZ4KU7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009413; c=relaxed/simple;
	bh=Otfy8rES7rvdq+wnb3Wa8AaNEaYXerb7/pwMg3id6Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d44xLp0sJMKYwHiSbjLPwIvn8Ze1O/eCe71r56bJDouelTPVnegYBNWa0hgPSqO/+TXQVahHYQV3+7SBxHrwaylizV++VK+c9h/JX1h5GGJ08RZOK5WeF61QJ2QSznxxZQYFBDiHPZN+Ok1oxlsS2t3LpGL3tqJNFQf5iFiyuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=io8Jw4Ny; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cBJ2yfNPFC6AgKPZbvS91mCh/8Bwho3Soao0QI/qyeM=; b=io8Jw4NyaEFkMQ4OAOUWJg0ZyE
	owa5pwXGFBnAdpTvTFEDDAab75ZSYKih19BbfS7OLZmvJKG8BYb32nBZnWCuPddTKEeE5OVZp1Yc3
	Acai6StyYj0VIsd/fU6hTwKaC2SfoWV0tWLe5g3HZ1Y4ORQCRIoxMAd+0FBRrTp5cDWSoVbUMGMI9
	N7UmU8ZZ6i7c75pt8A3TXmfBwDe2d4NkelwNsktROTgthw/LFu8ZssMSjsEDMsjsZAIAGux6tyLBp
	TnupI9bMmaPf9Zcnu1its8cxpmlNWA2jr/Wf6hoL76XnRQKYUgtco5bF8FPEPoFdJWvdImSIhFdnb
	T4I87nsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sCOa8-003Yze-0S;
	Wed, 29 May 2024 19:03:28 +0000
Date: Wed, 29 May 2024 20:03:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/file: fix the check in find_next_fd()
Message-ID: <20240529190328.GP2118490@ZenIV>
References: <20240529160656.209352-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529160656.209352-1-yuntao.wang@linux.dev>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 30, 2024 at 12:06:56AM +0800, Yuntao Wang wrote:
> The maximum possible return value of find_next_zero_bit(fdt->full_fds_bits,
> maxbit, bitbit) is maxbit. This return value, multiplied by BITS_PER_LONG,
> gives the value of bitbit, which can never be greater than maxfd, it can
> only be equal to maxfd at most, so the following check 'if (bitbit > maxfd)'
> will never be true.
> 
> Moreover, when bitbit equals maxfd, it indicates that there are no unused
> fds, and the function can directly return.
> 
> Fix this check.

Hmm...  The patch is correct, AFAICS.  I _think_ what happened is that
Linus decided to play it safe around the last word.  In the reality
->max_fds is always a multiple of BITS_PER_LONG, so there's no boundary
effects - a word can not cross the ->max_fds boundary, so "no zero
bits in full_fds_bits under max_fds/BITS_PER_LONG" does mean there's
no point checking in range starting at round_down(max_fds, BITS_PER_LONG).

Perhaps a comment along the lines of

        unsigned int maxfd = fdt->max_fds; // always a multiple of BITS_PER_LONG

would be useful in there...


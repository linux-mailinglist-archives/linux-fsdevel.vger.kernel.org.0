Return-Path: <linux-fsdevel+bounces-10905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7585E84F32E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A38D1F23648
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D1A6994E;
	Fri,  9 Feb 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdVkSWTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DA69940;
	Fri,  9 Feb 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473923; cv=none; b=pVBRimPbuHp6Zco12m1IPf9K4dAjm7fVc7Dx6mZMySEssaSlQlVsWEGU2EUoqnqfllTQsflPRPFxNaYlrN0BWnxp5MCPXMwCpuy5CD1r6lia2l4jZlHjzX9R18rdwm0ckvQjZojztHyKvskZ3CxFLKTbZgrD0z20bD1Z8sn9uVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473923; c=relaxed/simple;
	bh=9/lwSuAm2fFdzrC5XkKYo4LL/EvpSjXS9OJF5310rJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvPPVvKZmWUCzWt9kODGgMdrtkTebBRDw7tUF3vpwlReTvyA5y589GCMfrjPIozID8AkxjIY1JBEL8N1K0Vz53/n1ygE3IR07fsQi8a8hn6y2+zeHGnLivGJrNSourHvipH6ChGkC1N8yo9qElaSS1IT4sxOBE5kRc6mIvX5084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdVkSWTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0F0C433F1;
	Fri,  9 Feb 2024 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473922;
	bh=9/lwSuAm2fFdzrC5XkKYo4LL/EvpSjXS9OJF5310rJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdVkSWTTJr0e84YjnFyaFyP0EiUoLupLdiM2h+FIQHrIut7HwHklAoSLqLEh7ecUO
	 cAeHyqVkya4kgs+4CITgaCwnDzGRoU9dvs24d2wq3pt6qXK+QQNueII14KqDQ0LM4k
	 o2xxWzapK19fS1GhUrshESzn7O2jF7gJjXmwPSAUhomep4bPZBf/jBZZelzLwAPi1h
	 OoTLScLGrTOHF4S9TotNLMSmS26O27dlylvlezRtURavuVrGaTDqbP1F6UoCxy64Cy
	 /28e5QsmuJpkGhi72WctNkve43hdBlWKDROfWi0jhRzi8F8lH81zkF8c218kFV3l7N
	 0fmrZlE6JSCyg==
Date: Fri, 9 Feb 2024 11:18:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: wenyang.linux@foxmail.com, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, David Woodhouse <dwmw@amazon.co.uk>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: strictly check the count parameter of
 eventfd_write to avoid inputting illegal strings
Message-ID: <20240209-milchglas-aufzuarbeiten-f34f1491be02@brauner>
References: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>
 <20240208043354.GA85799@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208043354.GA85799@sol.localdomain>

On Wed, Feb 07, 2024 at 08:33:54PM -0800, Eric Biggers wrote:
> On Wed, Feb 07, 2024 at 12:35:18AM +0800, wenyang.linux@foxmail.com wrote:
> > By checking whether count is equal to sizeof(ucnt), such errors
> > could be detected. It also follows the requirements of the manual.
> 
> Does it?  This is what the eventfd manual page says:
> 
>      A write(2) fails with the error EINVAL if the size of the supplied buffer
>      is less than 8 bytes, or if an attempt is made to write the value
>      0xffffffffffffffff.
> 
> So, *technically* it doesn't mention the behavior if the size is greater than 8
> bytes.  But one might assume that such writes are accepted, since otherwise it
> would have been mentioned that they're rejected, just like writes < 8 bytes.
> 
> If the validation is indeed going to be made more strict, the manual page will
> need to be fixed alongside it.

Do you prefer we drop this patch?


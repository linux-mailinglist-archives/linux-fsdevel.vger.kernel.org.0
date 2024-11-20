Return-Path: <linux-fsdevel+bounces-35300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D49D384B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73CCB24403
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED319C554;
	Wed, 20 Nov 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8/c1591"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F5156669;
	Wed, 20 Nov 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098371; cv=none; b=BZz80P5zT0OqH9FmqB6fQHVieh/PsmrJ0Y68oEd3kL2SbNMD5V7hWCi/zLtdJzcg9/T0NugcKIaXr2SCqWGIkVDK1L7DINtkNLFp6um0s9mPUMVI1DlG0A+dqTsTjYJ/krNxIEOEluGwnD/G958oI//eOz4fpmVn3Ni6p2uy8zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098371; c=relaxed/simple;
	bh=SfqMrzJd3Xvy1fALjmr1wuzHzJstYU6OALJn4TwxQkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Fx9gy0/M0dg/3CVHrAuBmEtdbZDixUTgZBDwlX6PaVkN9/N+Ff2HOB6S2RvpEjgkPjAPcfQIglXmGXZPqbzf/jHtWnLe5Qj50RMec0YuiFRLl4aXGYgHytsKbbYKUcxYkFgMKM3OpNEyJWdtrlwXHYmzqvHKIAeSwOPLuyJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8/c1591; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E064FC4CED6;
	Wed, 20 Nov 2024 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732098370;
	bh=SfqMrzJd3Xvy1fALjmr1wuzHzJstYU6OALJn4TwxQkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8/c1591CJz8QoI8QyrOALAZusV7o0ALRWyg73eQlfR9QRMs99AQuDPvwlcvkz9tA
	 bji8DYG2t5zKFKiMzlnDFC5YT0nNZ+RHOmG8S0WKHWTaqliSHKtb3MEgNNYwMBsZZZ
	 5w3hFb5TI50cNd8U8wWfffGuRv2proHdiAuX/thuyAxwoSVWKekP2DMpYVP1DqZ+Vu
	 erxiZrYjJ2RilBYq6sCLsYNZemNmLjfQmJBx1I8u5DKU7Psdv542GzBAJueGio5S54
	 9M8jO03Ld7N2GscyFgV9OO/SNoRKxn0fB9lJAtxzqKGR2apGirl3JQbEoJWWK3vleT
	 sJ6isYqfHL3Dw==
Date: Wed, 20 Nov 2024 11:26:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: ZhengYuan Huang <gality369@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju@buaa.edu.cn
Subject: Re: [BUG] fs/eventfd: Possible undefined behavior about read and
 eventfd interaction
Message-ID: <20241120-bunker-kleiden-a0b5bb79a1e8@brauner>
References: <0c04e4ea-b900-4476-abc9-6b57e5c26e43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c04e4ea-b900-4476-abc9-6b57e5c26e43@gmail.com>

On Wed, Nov 20, 2024 at 01:40:32PM +0800, ZhengYuan Huang wrote:
> Hello,
> 
> Our dynamic analysis tool has encountered a potential issue with the
> interaction between read and eventfd. Below is a minimal code snippet
> to reproduce the behavior:
> 
> int main() {
>   int fd = syscall(__NR_eventfd, 1);
>   int ret = syscall(__NR_read, fd, 0x000fffffffffffff, 8);
>   assert(ret == -1); // invalid address
>   long value;
>   int ret2 = syscall(__NR_read, fd, &value, 8);
>   assert(0); // never reached here
>   return 0;
> }
> 
> When read is called with an eventfd file descriptor and an invalid 
> address as the second argument, it fails and correctly returns an 
> "invalid address" error. However, the second read syscall does not 
> proceed; instead, it blocks indefinitely. This suggests that the 
> counter in the eventfd object is consumed by the first read syscall, 
> despite its failure.
> 
> I could not find any explanation for this behavior in the man pages 
> or the source code. Could you clarify if this behavior is expected, 
> or might it be a bug?
> 
> Thank you for your time and assistance. Please let me know if 
> further details or additional reproducer information are needed.

Yes, that is expected as the copy_to_user() is the last step in
eventfd_read() and userspace clearly messed up by providing an invalid
address.


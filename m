Return-Path: <linux-fsdevel+bounces-10590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B959884C829
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760A1284C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C024208;
	Wed,  7 Feb 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2MgBBB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15EC23775;
	Wed,  7 Feb 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299927; cv=none; b=k7g+WedqBivL3DfQ7nbCdNHVvDerIbeRzHgxoK6SQtdW1JV1cv+fHsjyrMPjVa/Y9tuiUuGFaNH//HbiJLW0Bul8sZOVnKmHO6d40U0ug0DojOd0LUq3fzJe/uLYQq/iIEC0UuR3NxRYs45LHhqj9ThdtgOBvZlzOv5sWdpOcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299927; c=relaxed/simple;
	bh=mhF0TN1HXB7tfV4/QPwCrW1HhS6tDIF7W7UL/ee/wug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz6B/l/XSnnc9AfBak0OX9PZsQHk9xuPN0seUzn/FJpi1qr5/q+shvkxyVeC0CFQDTN8qthrtTpmsIHYYCMPVpC6fo2O3A/WPDSE/xik7eCLqcD9/huAUiH48Z/9WuwGaolHFr3QJYzVNzcaAni1BP4nXUi/qA+qaUukNVYYWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2MgBBB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0698C433C7;
	Wed,  7 Feb 2024 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299927;
	bh=mhF0TN1HXB7tfV4/QPwCrW1HhS6tDIF7W7UL/ee/wug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2MgBBB/KWNsEKOdmS2YH4MvwV3afe7+6p2jNoBbTWMoqI0vaEfA2GNnU8x2DIJha
	 POBBVd60eLs3Or3hF4t2E/aIUZ0fFyPeyROf85vtWwXjNeGFuaMOWRlXXYSsEMzwic
	 q/hKR7NQp5GkSAwcurtsghAP/CxmaEKGcFnCJl05NeiJAspg/bzPCXnxlaswI/OiVd
	 lsQQOySrPsI48odWNkZppXnXQ2GD9Xp7A/GJ47r1j/LfPflx69XHAyhw3lepx16gfP
	 sO5vb+XY/DTXf46D8bhZlZS2UyEHmNBudWGRVqTNxOoBBTf3dJaZPWaBuB+6XRnsVP
	 rIUaU++Qpv4Ag==
Date: Wed, 7 Feb 2024 10:58:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: wenyang.linux@foxmail.com
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, David Woodhouse <dwmw@amazon.co.uk>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: strictly check the count parameter of
 eventfd_write to avoid inputting illegal strings
Message-ID: <20240207-hinkriegen-trugen-8f219d8840a8@brauner>
References: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>

On Wed, Feb 07, 2024 at 12:35:18AM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> Since eventfd's document has clearly stated: A write(2) call adds
> the 8-byte integer value supplied in its buffer to the counter.
> 
> However, in the current implementation, the following code snippet
> did not cause an error:
> 
> 	char str[16] = "hello world";
> 	uint64_t value;
> 	ssize_t size;
> 	int fd;
> 
> 	fd = eventfd(0, 0);
> 	size = write(fd, &str, strlen(str));
> 	printf("eventfd: test writing a string, size=%ld\n", size);
> 	size = read(fd, &value, sizeof(value));
> 	printf("eventfd: test reading as uint64, size=%ld, valus=0x%lX\n",
> 	       size, value);
> 
> 	close(fd);
> 
> And its output is:
> eventfd: test writing a string, size=8
> eventfd: test reading as uint64, size=8, valus=0x6F77206F6C6C6568
> 
> By checking whether count is equal to sizeof(ucnt), such errors
> could be detected. It also follows the requirements of the manual.
> 
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---

Seems sensible but has the potential to break users that rely on this
but then again glibc already enforces a 64bit value via eventfd_write()
and eventfd_read().


Return-Path: <linux-fsdevel+bounces-69594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DFAC7E92F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BFA3A99AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D9727A12B;
	Sun, 23 Nov 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTclnZcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF25238C36
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938420; cv=none; b=XwxDdmrgLlMGnzyDK9SFUxpLvaRQRQGMVhGMMu5UeIQJONZtdphi3wW6JfooIZaJhG9NBbDw2pcn5i+HMgy1EMwzIrVNv4ZCNGSjEio1qxyFbmYD0DoLlKjRJg0rte0fQTcw3dWPzZkYp+upA+yvA/34F0R2S99n5TunIvBlsH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938420; c=relaxed/simple;
	bh=gNDwyobGUGpNKmbABEaVmoCLJqXLaBtcjUrL8dRxtPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3SXrQu0tGmHbBxM2hVaRniy74xfVcyr1ArED2u8hIqytvGdxHajrKC6w556YX677a/Gjlk5gNf5FS+Ptw5Vj5rsPF09bxIFR1mSy7jKpYRT/lZKHCr8EyJHnhnkap1mgKZKk4eAotrRaC60FPUNR6Nr0twV9/sQw+CFtPQNJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTclnZcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBE8C113D0;
	Sun, 23 Nov 2025 22:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763938419;
	bh=gNDwyobGUGpNKmbABEaVmoCLJqXLaBtcjUrL8dRxtPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTclnZcpgiJl+1az1JfOO10vwLINUDLAqUZPXhzrHZEBY7yZaus8RFOnAlJolqm8E
	 SMD6s6w+7DuzgJ6eVN46Gc8QFo8EFYk57MO5r6XpPQElccZOp4maePAuOtA5EaoP+y
	 5xKec8JF3h0ZEr3ZCBmcCWCsUpoLU0FzQ3o9Ohau30mW/nsK9ZD36gLMbYuqA7WHL9
	 VioudAQ9wEAgrLWxAIbUjd4bYf34AGzyCha5PHF9vP00zeQuCvRdc08C40WESVot82
	 Oh5SFsl2QVLahHd20eeAcxoA4fW2ztiSTsv7v4haRckQrKwETUKF2FLY9V4aIBXNEa
	 Kjpt0fIjDvC7w==
Date: Sun, 23 Nov 2025 23:53:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 00/47] file: FD_{ADD,PREPARE}()
Message-ID: <20251123-hochgearbeitet-kindheit-7099f6566c12@brauner>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <CAHk-=wgLeBAXe+gOmv0zf+ZaD9a_gtL81349iLvfesXkUxYyWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLeBAXe+gOmv0zf+ZaD9a_gtL81349iLvfesXkUxYyWA@mail.gmail.com>

On Sun, Nov 23, 2025 at 08:43:18AM -0800, Linus Torvalds wrote:
> On Sun, 23 Nov 2025 at 08:33, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This now removes roughly double the code that it adds.
> 
> .. and I think more importantly, I think the end result now is not
> just smaller, but looks nice and straightforward too.
> 
> I particularly like your FD_ADD() macro. Good call.
> 
> So yeah, no more complaints about this from my side.

Cool! This already exceeds all of the remaining direct uses to
get_unused_fd_flags() + file + install. And there's a good chunk more
that can easily be converted. I've got most of dma ported. Only
special-sauce cases should be left afterwards.


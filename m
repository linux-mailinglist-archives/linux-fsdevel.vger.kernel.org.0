Return-Path: <linux-fsdevel+bounces-16936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32BB8A52D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524D8282BFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154474C1B;
	Mon, 15 Apr 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm40G7FT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0E745ED;
	Mon, 15 Apr 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190563; cv=none; b=YQMC+da2NZY4vypvgxl7ErIqAR3z7iY5ONVBHL1XWv+IdCk5F60r/C7X4V6EmaF7vDj/YCqEWDhtwMUThTSZdprbHmnQ7308xqOttAveqT+uWbRSsAJ4QUKl3BRtodhY1615Jwg3v0dDY3ex8qEUsrmD5xdJ6we0A4b1DUAw+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190563; c=relaxed/simple;
	bh=POUu+BmJw+CBnJ9Kwm3jygYbdus3ecGREVH9HKmuLxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS3U+zcQNMX6ppKqKekTGCYChYTq2nKI+yntcvALaEbbxuPKMg7FYiYMDMBX59w3pDRuvcD4jPPUGT2mB60g8vOUOvoBKZBKSw7o+0nKkuKR7pjGYLwxAZjWpYLF4ISipd0MROSy+Agap7gJMvMpjKP400acVwCooZASE9KPvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm40G7FT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A60C113CC;
	Mon, 15 Apr 2024 14:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713190563;
	bh=POUu+BmJw+CBnJ9Kwm3jygYbdus3ecGREVH9HKmuLxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zm40G7FTBAqwnrlws7v2v3nVZyYf8vrOrlQZMS2vQf/vbjKVwSgydwRZHyhzWB0XU
	 MUGX8jzJftacjemMk/R+Otnoqr2D1wKvyeK3BLvY6nlNAY2lr/34WXy0oh8uVd7V67
	 w7A03WXDFQtpkDbIdKDyyxzXP+01DTO37kHjVX3Wgsa3xNUVW6amoS23evshg0+nFm
	 EiYiG/CIPfzYj/mdVoBMJEkiSzJUZRWEdgv0nMPL3lVNDVS4N7xIGz8BkgQKfaMZKc
	 fgDEhwLmQRRbSIF1Ibz0YHj1bd9BLs7UdnzNtjgmKOxhFomMsEDWb2TVSxgjHHr2VR
	 YywY5Tg7KByUw==
Date: Mon, 15 Apr 2024 16:15:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anton Altaparmakov <anton@tuxera.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Linux regressions mailing list <regressions@lists.linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, 
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <20240415-warzen-rundgang-ce78bedb5f19@brauner>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
 <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>
 <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zh0SicjFHCkMaOc0@hovoldconsulting.com>

On Mon, Apr 15, 2024 at 01:42:01PM +0200, Johan Hovold wrote:
> On Mon, Apr 15, 2024 at 11:32:50AM +0000, Anton Altaparmakov wrote:
> 
> > Had a look at ntfs3 code and it is corrupting your volume.  Every such
> > message you are seeing is damaging a file or directory on your volume.
> 
> That's what I feared, thanks for confirming.
>  
> > I would personally suggest you modify your /etc/fstab to mount
> > read-only.  If it is getting simple things like this wrong who knows
> > what else it is doing incorrect...
> 
> I fully agree and that's partly also why I asked Christian to make sure
> that the alias fs type is always mounted RO.
> 
> But it seems we have a bigger problem here and should just restore the
> old ntfs driver for now.

Hey Linus,

A brief summary:

The removal of the legacy ntfs driver has caused a regression for some
users that rely on the legacy ntfs driver to be available during boot.
The affected user here is Johan (Cc'ed). In addition he's seeing dmesg
warnings that he didn't see before with the legacy ntfs driver.

I see the following options to resolve this:

(1) Since the ntfs3 driver is supposed to serve as a drop-in replacement
    for the legacy ntfs driver we should to it the same way we did it
    for ext3 and ext4 where ext4 registers itself also for the ext3
    driver. In other words, we would register ntfs3 as ntfs3 filesystem
    type and as legacy ntfs filesystem type. To make it fully compatible
    we also need to make sure it's persistently mounted read-only.

(2) We revert the ntfs driver (for now) as we are in the middle of the
    cycle.

If you decide (2) is the right way to go then I would suggest we try the
removal once more next cycle with the proposed change in (1) in place if
you're up for that.

Christian


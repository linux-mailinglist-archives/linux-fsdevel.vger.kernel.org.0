Return-Path: <linux-fsdevel+bounces-61400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B84B57D79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F702A1045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63263191DA;
	Mon, 15 Sep 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJGZ1vBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4792313291;
	Mon, 15 Sep 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943281; cv=none; b=kCNzxLouwtx8lvaGWcXqci7Kn71XRx8w2dQ1fLwM/DXh9iDxqXvsXYeJzPj1jHfIAOL1phX7A68L3FGvGSWP/IUQitJJj9IHvy0j4zvMk3lcnQ7/HaWG6iSgFATOW47d7fA+U7rAqv4BkNgwQjonsa6i6PW1cD8xwOtR+R2krKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943281; c=relaxed/simple;
	bh=G1pxbFOuDJsJnBF0m+5CY6Xwwfubv5cFdvznrZJvWPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkfHiPj1UpfBq8XCfhhzzHPDGr9xBeZaX7wPEA1SOYykFR7UBSgp0wkVo2BBFYed+ECtfAmcx/kTpNpTTEqv2oNAs8tIPopgbduz/YzdO6pwjGTIbD7wplQT9aK9SN6DdzWj0CGvL9zj8ggJjuwp+n3TVsqYQZHImRxsTB3LVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJGZ1vBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06662C4CEF5;
	Mon, 15 Sep 2025 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757943280;
	bh=G1pxbFOuDJsJnBF0m+5CY6Xwwfubv5cFdvznrZJvWPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJGZ1vBQTvO1OLFpsKgtQvIkjtAVvJey56ZqhZxYzVB3EDoeucwA9j3Ikra0r96a5
	 jQw9/XHjAdC85R6jORBqXH6OkpLRRmI0UaRxSBMlJTyGu8sObrPf6EYsRHYnpzWABK
	 4guOhpliPb5aYSSJ1cikDCiA9fl38O9CJLfhWdf/1FUDPbaUHhsgjd/BUigP/DwSAR
	 ZgzXa5kZ1LN2Vwu2d8y8wxYWU6XMdt47ld5N4t1CFweo+0HtUX4GHSNgmsq7QjI/jF
	 wghZzlNvaq7LpEjMzkOqler37Pf0I1gD2UiJKUJFEipxphTk6d9TTXloxjbYPhi7oP
	 Dxi908vsrFrMg==
Date: Mon, 15 Sep 2025 15:34:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, 
	initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>, 
	linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, devicetree@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Message-ID: <20250915-modebranche-marken-fc832a25e05d@brauner>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>

On Sat, Sep 13, 2025 at 12:37:39AM +0000, Askar Safin wrote:
> Intro
> ====
> This patchset removes classic initrd (initial RAM disk) support,
> which was deprecated in 2020.

This is a good idea but the patchset does a bit too much and it's pretty
convoluted and mixes cleanups with the removal of initrd support and so
it's not that great to review let alone merge especially considering
that a revert might be needed.

Split it up into multiple patch series. Send a first series that
focusses only on removing the generic infrastructure keeping it as
contained as possible. Only do non-generic cleanups that are absolutely
essential for the removal. Then the cleanups can go in separate series
later.

As usual I'm happy to try to shed old code but I wouldn't be too
optimistic that we'll get away with this and if so it needs to be
surgical.


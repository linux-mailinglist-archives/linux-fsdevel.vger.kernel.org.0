Return-Path: <linux-fsdevel+bounces-69750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C2BC84455
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0F24E88B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11002ED870;
	Tue, 25 Nov 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HILqpMqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE41D435F;
	Tue, 25 Nov 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063706; cv=none; b=kZnvY4SZgV8C/M3GqDxNboUlL2RgAtkZIO0JzIHdBje4h+HXw0lqSxsQ3DAi8tTi3kEUqqAa2atvJ3oCWsr2Gnjn9KE/A95f0NV0FWOS2jClMdOso5b6gzrOFbgIuh/fk/jRPEwl6/nJWDTyJLQGkbJohB7qW73c0Jsv6B8nF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063706; c=relaxed/simple;
	bh=G+5PXvJgDMcU5RkJ0dQ+el9YilmaepYiiuRYJDFh8uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXzLZJ22qM4Pq7VbmVXMPFXz5hEOSIltfPusUT338uqKmtjfAp9SUq/vaXhmC0gSutDLaM5UZ17QB8vTA0KVswOcg/agKsI/mBCQRDnWjIl+fwz4GHho889TJpYdnii0MZF1pBA6XSKl1R/v9JGA/ccfElp32yJuXqB3ACUBHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HILqpMqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C0AC116D0;
	Tue, 25 Nov 2025 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764063705;
	bh=G+5PXvJgDMcU5RkJ0dQ+el9YilmaepYiiuRYJDFh8uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HILqpMqRrwNAl9Kx+fVwsphMdRl0qK6SmGLYrItk/XuKiloPu7RzUfDPmEOvkga66
	 +XzQU5K5naD2nIkaCcDnmMpQaDrjrl+5j4/s4+vvuULYWvHY/c3FGrkTqUf1/arKCR
	 O1Tyq1Q7+iqYJj8i0M+3oPEmw6zY4oZIjJjAB/NmXilK11buQZHjlm3u61k7BIOT+E
	 4dgeFte/QoxehEyVRnt34ZPhbLC2FajlD+F8wotC2ynJYCDMwsr/Uw09/VkFax3okF
	 lTBth41t2/OcbfEGV5qQ+mRZhbbmE+ly3XA9viIdbaeUdFYo7qEONLcZ/7wfB3BDB6
	 CMA15WD6lIvsg==
Date: Tue, 25 Nov 2025 10:41:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, linux-block@vger.kernel.org, 
	initramfs@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Subject: Re: [PATCH v4 3/3] init: remove /proc/sys/kernel/real-root-dev
Message-ID: <20251125-gearbeitet-fielen-e228943f67b5@brauner>
References: <20251119222407.3333257-1-safinaskar@gmail.com>
 <20251119222407.3333257-4-safinaskar@gmail.com>
 <20251124142804.GC16938@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124142804.GC16938@lst.de>

On Mon, Nov 24, 2025 at 03:28:04PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 10:24:07PM +0000, Askar Safin wrote:
> > It is not used anymore.
> 
> Let's hope whacky userspace agrees with that :)
> 
> But we'll have to try this to find out, so:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Ok, let's try for v6.20. Putting this into vfs-6.20.initrd.


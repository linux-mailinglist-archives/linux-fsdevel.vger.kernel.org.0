Return-Path: <linux-fsdevel+bounces-12145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD6285B843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637F2B214EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1262806;
	Tue, 20 Feb 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdGmA/T8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF66168D;
	Tue, 20 Feb 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422693; cv=none; b=QUqvfM8XEmLxNGErxZCGJhs2pSPgJtRjqf2g1wKSrrMUjdWPH4MNmYIPjmOxy+m0rg/6oPcfR6cOZTVwQWdHOIYG4L19x81ark7KS/NRSLOd1zBx6Jeckt6UocBzP6m6xdA/YBGMvJDerIJkcK3DOcTAPF6JaXR7rcaISdOePCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422693; c=relaxed/simple;
	bh=TPGKN24CaFtGRIE0VeP5mwAzn+ZOxDeAL3aTzRUirss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FErqkJetXFh+M/h1XCdH+ftOQKwZ47nKLsA1TszeJ3lrI55+/ZybXEZIum3repOOiyiIR7XMJ8beCe6Tf/IO5nbU6Zl0137JULHwtTz8+qlRrFtPDvVYQ1Ao//HAYWXTHi9pXLeXm7VFPeOZbSpfUSniDolafooP7qotdAkkzIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdGmA/T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F3C433F1;
	Tue, 20 Feb 2024 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422692;
	bh=TPGKN24CaFtGRIE0VeP5mwAzn+ZOxDeAL3aTzRUirss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdGmA/T8Yh36xJUAh9kQ4QRKg7xEAQSuwUEa0iQfBV+TmOCP9i2ysDi55lCEigAVt
	 iMT8PDu6Rsb3s5qii2+KygzOb/oCQ9TYhW7beSNZoJsCyQepfzdtxrVNl6qdJpDfM9
	 ENot3D+ATZi+xZnx9fTxI67SE5FeCahLHb/4spD+As4ZJA9cprBz+57uYMwVLGHLxo
	 dUoQEOj3B16cNb7kuh8ze8i6nhjOtYUO6nOlEpyjUfRbKUX24e7uigjhU/IF3uPzzV
	 3e6/jprnSqfIlqBk7V1r9K0s6hbEbuvieS7jIy8VvBS7T/S/8Pa9u5ZtLGfGibQ3us
	 f9XfJxph4bz1g==
Date: Tue, 20 Feb 2024 10:51:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: David Howells <dhowells@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH 2/2] netfs: Fix missing zero-length check in unbuffered
 write
Message-ID: <20240220-autoteile-enthoben-a9a16739b2b9@brauner>
References: <20240129094924.1221977-1-dhowells@redhat.com>
 <20240129094924.1221977-3-dhowells@redhat.com>
 <960e015a-ec2e-42c2-bd9e-4aa47ab4ef2a@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <960e015a-ec2e-42c2-bd9e-4aa47ab4ef2a@leemhuis.info>

On Mon, Feb 19, 2024 at 09:38:33AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 29.01.24 10:49, David Howells wrote:
> > Fix netfs_unbuffered_write_iter() to return immediately if
> > generic_write_checks() returns 0, indicating there's nothing to write.
> > Note that netfs_file_write_iter() already does this.
> > 
> > Also, whilst we're at it, put in checks for the size being zero before we
> > even take the locks.  Note that generic_write_checks() can still reduce the
> > size to zero, so we still need that check.
> > 
> > Without this, a warning similar to the following is logged to dmesg:
> > 
> > 	netfs: Zero-sized write [R=1b6da]
> > 
> > and the syscall fails with EIO, e.g.:
> > 
> > 	/sbin/ldconfig.real: Writing of cache extension data failed: Input/output error
> > 
> > This can be reproduced on 9p by:
> > 
> > 	xfs_io -f -c 'pwrite 0 0' /xfstest.test/foo
> > 
> > Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> > Reported-by: Eric Van Hensbergen <ericvh@kernel.org>
> > Link: https://lore.kernel.org/r/ZbQUU6QKmIftKsmo@FV7GG9FTHL/
> 
> David, thx for fixing Eric's regression, which I'm tracking.
> 
> Christian, just wondering: that patch afaics is sitting in vfs.netfs for
> about three weeks now -- is that intentional or did it maybe fell
> through the cracks somehow?

I've moved it to vfs.fixes now and will send later this week. Thanks for
the reminder!


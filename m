Return-Path: <linux-fsdevel+bounces-9420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3D840DE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1561C21793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8AA15D5CD;
	Mon, 29 Jan 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFF6V7Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D615D5C2;
	Mon, 29 Jan 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548184; cv=none; b=En6Y5RuMUyUnriQVSGq7H9aMBK0tXihYMVwfBpdGJdePSgNvQK7T55PsbK+gYKvIXjZQgygPqEH0XC6dJoQ9Vm6qdlLLF1vdhLGhO8m0cqWP4zpisK0cfXhHG0bZZnXX25v8ru2w3ql43eS2BM5ah+7epTL2mIZlvuvtiWmphtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548184; c=relaxed/simple;
	bh=+3EnK90WELOt03Sn6PJmOZM1AOelmCukV8l9NsD92Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLoNYoYZgpirPAWHbHdqZo7yZttTIwy9iWtcFMCjd0Mul6H8KeFsWBVfpdiTjDGGRgTuIe0v37e3AfiudsQVq3p5oGm3UX9bIMQkaZw0z1rQm5zj32Y02X4FnDULnRYgo4k5JT8JeI767s8U59wZANAFHYSAF2mOR3W2nqMxv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFF6V7Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141D2C43390;
	Mon, 29 Jan 2024 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706548184;
	bh=+3EnK90WELOt03Sn6PJmOZM1AOelmCukV8l9NsD92Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFF6V7SwU/YWlMmgRjZm8IZ9/ANIveQzfI1OtJVptOnEt2F4zy6K7pU+c//laRM0B
	 cXgLklPwDSO7NLcHcBVyNKk7Ndt+29e89KOBMl38EGWxZmt5b6YVQV58W4ucqkYz23
	 CJcLdYANABhlqBFQeJBj0d2xlmNv+HQJO4ZFQqbHuXNm8JLO6qVL38V73UJ4kumepf
	 Mz/1XMuiqzMcvVy4WQnUm5AAitgZdXH6VlDjfrSubJCMO1p2LOR4gvLEqQ38RaoYar
	 eR8n9hEzmY8ZfJEejIMj4H0JhFUVR0OrZOSPG38C+ymHqskUvlv1G6JYElxgh4Vz2a
	 fV1hn8Ed6QDdg==
Date: Mon, 29 Jan 2024 18:09:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240129-gastmahl-besoldung-33a6261b10d9@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
 <20240129164934.GA4587@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129164934.GA4587@lst.de>

On Mon, Jan 29, 2024 at 05:49:34PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 23, 2024 at 02:26:48PM +0100, Christian Brauner wrote:
> > Make it possible to detected a block device that was opened with
> > restricted write access solely based on its file operations that it was
> > opened with. This avoids wasting an FMODE_* flag.
> > 
> > def_blk_fops isn't needed to check whether something is a block device
> > checking the inode type is enough for that. And def_blk_fops_restricted
> > can be kept private to the block layer.
> 
> I agree with not wasting a FMODE_* flag, but I also really hate
> duplicating the file operations.

I don't think it's that bad and is temporary until we can
unconditionally disable writing to mounted block devices. Until then we
can place all of this under #if IS_ENABLED(CONFIG_BLK_DEV_WRITE_MOUNTED)
in a single location in block/fops.c so its nicely encapsulated and
confined.

> I went to search for a good place to stash this information and ended up
> at the f_version field in struct file.  That one is never touched by the 
> VFS proper but just the file system and a few lseek helpers.  The
> latter currently happen to be used by block devices unfortunately,
> but it seem like moving the f_version clearing into the few filesystem
> actualy using it would be good code hygiene anyway.

Kinda like choosing between pest and cholera. I think that the f_op
solution is nicer. Overloading f_version is not something I feel I have
the stomach for. The cleanup itself might still be worth it ofc.


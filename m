Return-Path: <linux-fsdevel+bounces-32992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35EE9B1289
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 00:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B0E1C21B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0420F3CA;
	Fri, 25 Oct 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5jnk/10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DC7E792;
	Fri, 25 Oct 2024 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895084; cv=none; b=DP7LATzUwQmFaUSQbGPRwnP3cKcl3QHVrv1rtTDWm6DnFI5Fwv0HbhQ5HVvYjyVg0ax0awEWgYchaBQ7VbeJgv6MpqcRaGlhD9xe/eu+bqUwWiWRq7vMcSgGYM8XyX6mrwAy+3joLlVR8uzVQ8gjyqFRCdCDMPapewHq3jctNuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895084; c=relaxed/simple;
	bh=iKgBeF1jN0ULNnc1g8z3UyPMKDiuVzjZMxs5gOzbG7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIAbLCxdodFy6oaMGZUXii1DhTot72Z+V+6mt84G+QYreDo0hfx0GheLG7AbqhIqD/csQSHsvSppvqeRJeUm3ujHk0uI0vVrg1H6MzV8VSKTO8j1lR1qaiZZQsjOAUI/eI0AT18tSbEjWQzHqzRRMC7gMJc0vvTLy+tibvFuLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5jnk/10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FF0C4CEC3;
	Fri, 25 Oct 2024 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729895084;
	bh=iKgBeF1jN0ULNnc1g8z3UyPMKDiuVzjZMxs5gOzbG7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5jnk/10xzzcwBOegkb9M7JjtCArf7E8cvKkqE5kNKuF+bZrvN2LKP+qXrRXo4G3B
	 /OlA8wkr5hTaQDkBl2CutApPFVL7uGy8Xy78G9n3hQZ+YUCNn9q4Z6uKTR4cWwEUX9
	 pQ75guvHQKTVcp+NCy2swQ+J3djyAYwntnsPqJBK1wqiZS1OmZfZNL8lli6+aYjxoz
	 Gy0gX3gCtifCOhU0oz1UE+Co+8kiSMVjBp9xHC0yVWqBBg6Wehr0YM4xeMaykIZjkF
	 H+IqYlzoYSvRvqkR0jPtpLnGSfxjpsfHau8fw9pjG7W5A0V7+CcyAnB0ZZhEa+pvZT
	 gy9WTnXsWakOA==
Date: Fri, 25 Oct 2024 15:24:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	linux-xfs@vger.kernel.org, willy@infradead.org, cem@kernel.org
Subject: Re: [PATCHSET] fsdax/xfs: unshare range fixes for 6.12
Message-ID: <20241025222444.GM21836@frogsfrogsfrogs>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
 <20241007-ortstarif-zeugnis-bfffcb7177aa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-ortstarif-zeugnis-bfffcb7177aa@brauner>

On Mon, Oct 07, 2024 at 01:52:18PM +0200, Christian Brauner wrote:
> On Thu, 03 Oct 2024 08:08:55 -0700, Darrick J. Wong wrote:
> > This patchset fixes multiple data corruption bugs in the fallocate unshare
> > range implementation for fsdax.
> > 
> > With a bit of luck, this should all go splendidly.
> > Comments and questions are, as always, welcome.
> > 
> > --D
> > 
> > [...]
> 
> Applied to the vfs.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs.iomap branch should appear in linux-next soon.

Er, this has been soaking for 18 days, is it going in soon?
(Apologies, I just saw that you've been under the weather.)

--D

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.iomap
> 
> [1/4] xfs: don't allocate COW extents when unsharing a hole
>       https://git.kernel.org/vfs/vfs/c/b8c4076db5fd
> [2/4] iomap: share iomap_unshare_iter predicate code with fsdax
>       https://git.kernel.org/vfs/vfs/c/6ef6a0e821d3
> [3/4] fsdax: remove zeroing code from dax_unshare_iter
>       https://git.kernel.org/vfs/vfs/c/95472274b6fe
> [4/4] fsdax: dax_unshare_iter needs to copy entire blocks
>       https://git.kernel.org/vfs/vfs/c/50793801fc7f
> 


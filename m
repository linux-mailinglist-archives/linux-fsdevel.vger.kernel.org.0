Return-Path: <linux-fsdevel+bounces-13448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D20187011E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2311C219AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743DB3BB4C;
	Mon,  4 Mar 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUI2hZ4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53F224DF;
	Mon,  4 Mar 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554747; cv=none; b=K8mHw0/FufPHHSbg78UdXjGzYtRWcnxAW287/WOaRtDrDHGK/P6fqxwVwWZf3OfHjYNyDgbeN39kVWHGG7WfYpQKnKz8pdYNQhv3N5dL9TDZAUcFZxKXWaWqJ6UPb3R0gSO9qmqCHjW2m2H2wNayrOTcPlQaHEtzmebGNnUOw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554747; c=relaxed/simple;
	bh=+Xw4yL/juL36M9CS5u3iiQJvhPaohn+valC9SCU0ybc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCZjtbWkOfc08ddXx1otLXlvXvfeICVX4DZHCEcNETCWzUzG9iunftGbZ4oFmS8vq/KxosoIB948OcuN/4zStKcsSR0jiOzyzKz5pSE8MymXzqGKISiB7FyUnMzggvnol3n2TGwElX0X/8E1UmNoqtJ/g+FClHFwzV03tKYdTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUI2hZ4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36F2C433F1;
	Mon,  4 Mar 2024 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709554747;
	bh=+Xw4yL/juL36M9CS5u3iiQJvhPaohn+valC9SCU0ybc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUI2hZ4OWyfYui0MJR/fJWyPYofxYOcvEJ5DI5z16+KtH7rdtSfHUvftD8pxYv3OS
	 Jc7qJDmbS15d8t3ugJKe1V7YtWvL/oFLbb4Eqzu9vrZUmiuKwoJRwMdYkzT+pqv8xO
	 h3lrVQ8b6Jm+hEQAHgS2R5Kgvody6lBsg1TewvwUIZ+HgyTSeOc6gyJkfLVwKfDxWF
	 oW3YBP15Z1GMWhXHEecrhhiPIasG6UweQmh7JdpKv2x0EAdvAMLY5S4wy25I+nSG9+
	 QOkTl8utddU4tV378UMm9IVrEcP9A7KhccuWtuPVxeUxs3WaRTAMwmLU14vshiHLGS
	 +4IV2oFFV3X8A==
Date: Mon, 4 Mar 2024 13:19:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-kernel@vger.kernel.org, 
	samsun1006219@gmail.com, linux-fsdevel@vger.kernel.org, syzkaller@googlegroups.com, 
	jack@suse.cz, viro@zeniv.linux.org.uk, Eric Van Hensbergen <ericvh@kernel.org>, 
	v9fs@lists.linux.dev
Subject: Re: WARNING in vfs_getxattr_alloc
Message-ID: <20240304-essverhalten-wortlaut-d4cc40939a3c@brauner>
References: <CABOYnLwY5Y499j=JgWtk9ksRneOzLoH_G9dYZTwXi=UvLbUsSg@mail.gmail.com>
 <20240304-stuhl-appetit-656a443d78a5@brauner>
 <ZeW6a1OK-lhCbAf0@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeW6a1OK-lhCbAf0@codewreck.org>

On Mon, Mar 04, 2024 at 09:11:23PM +0900, Dominique Martinet wrote:
> Christian Brauner wrote on Mon, Mar 04, 2024 at 12:50:12PM +0100:
> > > kernel: lastest linux 6.7.rc8 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> > > kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=4a65fa9f077ead01
> > > with KASAN enabled
> > > compiler: gcc (GCC) 12.2.0
> > > 
> > > TITLE: WARNING in vfs_getxattr_alloc------------[ cut here ]------------
> > 
> > Very likely a bug in 9p. Report it on that mailing list. It seems that
> > p9_client_xattrwalk() returns questionable values for attr_size:
> > 748310584784038656
> > That's obviously a rather problematic allocation request.
> 
> That's whatever the server requested -- in 9p we don't have the data at
> allocation time (xattrwalk returns the size, then we "read" it out in a
> subsequent request), so we cannot double-check that the size makes sense
> based on a payload at this point.
> 
> We could obviously add a max (the current max of SSIZE_MAX is "a bit"
> too generous), but I honestly have no idea what'd make sense for this
> without breaking some weird usecase somewhere (given the content is
> "read" we're not limited by the size of a single message; I've seen
> someone return large content as synthetic xattrs so it's hard to put an
> actual number for me).
> If the linux VFS has a max hard-wired somewhere plase tell me and I'll
> be glad to change the max.

Surprisingly we have a max limit that exists in a way because the whole
xattr uapi is somewhat broken. So best to limit it at XATTR_SIZE_MAX.
See fs/xattr.c for how it's used.


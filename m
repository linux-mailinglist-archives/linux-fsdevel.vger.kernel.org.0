Return-Path: <linux-fsdevel+bounces-24456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828D93F923
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C2C1F22A0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0815624D;
	Mon, 29 Jul 2024 15:09:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71C156227
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265798; cv=none; b=ka3LkQrz2lr3xuF0q6WwYVC3FjkC0E1lJ7dq4rS5TvwBnnryMpE1mImZowO5wLOlZziXkos/8Wkwq3U9q+z4iarZbXvjt4t7E+/zPgdARgZ3mAvA5X99z9/QJcB2SW8y1b9lk8stG0A25QsF3+Jn+5gB5ICme+JKcjsCSerBl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265798; c=relaxed/simple;
	bh=9WxsBJ5g9ld9qPDtJjRrI/d1wXv6xcbxehc73REPjxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja2JZ4VxCc2P8F2aGw5S+BocR9uQwEaXQapPqHAVLAETKcNXmhXKr1EMZKoZMWCQIEoqOrklMRpWs85BWRfkyeBT29F7KH3Zd2fDBIcXAxoWFgqWa9rStUWOSbY0Uea6xyQtYdpNdD4qc1eToMblicc84DL4XMEuR6LxJT8OGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B693F68D05; Mon, 29 Jul 2024 17:09:52 +0200 (CEST)
Date: Mon, 29 Jul 2024 17:09:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: libc-hacker@sourceware.org, linux-fsdevel@vger.kernel.org
Cc: Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240729150952.GA29194@lst.de>
References: <20240626060134.GA22955@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626060134.GA22955@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi dear glibc maintainer,

any comments and ideas how to get glibc out of the behavior of
making file systems non-conformant by adding a broken wrapper?

On Wed, Jun 26, 2024 at 08:01:34AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Trond brought the glibc posix_fallocate behavior to my attention.
> 
> As a refresher, this is how Open Group defines posix_fallocate:
> 
>    The posix_fallocate() function shall ensure that any required storage
>    for regular file data starting at offset and continuing for len bytes
>    is allocated on the file system storage media. If posix_fallocate()
>    returns successfully, subsequent writes to the specified file data
>    shall not fail due to the lack of free space on the file system
>    storage media.
> 
> The glibc implementation in sysdeps/posix/posix_fallocate.c, which is
> also by sysdeps/unix/sysv/linux/posix_fallocate.c as a fallback if the
> fallocate syscall returns EOPNOTSUPP is implemented by doing single
> byte writes at intervals of min(f.f_bsize, 4096).
> 
> This assumes the writes to a file guarantee allocating space for future
> writes.  Such an assumption is false for write out place file systems
> which have been around since at least they early 1990s, but are becoming
> at lot more common in the last decode.  Native Linux examples are
> all file systems sitting on zoned devices where this is required
> behavior, but also the nilfs2 file system or the LFS mode in f2fs.
> On top of that it is fairly common for storage systems exposing
> network file system access.
> 
> How can we get rid of this glibc fallback that turns the implementations
> non-conformant and increases write amplication for no good reason?
---end quoted text---


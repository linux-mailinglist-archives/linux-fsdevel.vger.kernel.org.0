Return-Path: <linux-fsdevel+bounces-22477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8B91786B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 08:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD26B284DB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4853813D8A8;
	Wed, 26 Jun 2024 06:01:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003D38D
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381702; cv=none; b=CUS2XdPkcBVZowVOiXcPTkuiQJJgUCo1RfsOUVnWscibmM3Kx+CPFGdDqemSFNlMO+YVCxEVxfLcAAPjsoSuTh91VH7IifDo8trZPVqFmO4iyyNQZNb+gJpJfH+Bxofq6OwLvPQ5TIcNdn+pRrwVKQ227g34n0JtE6rMGifc9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381702; c=relaxed/simple;
	bh=a0BGXDUgzkZAnwTen1txxlJUS+OucJ0DuFJ2blug9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SO0633mLQ7Sr4CMuRVBmzPhl9stUwejymTkGQRUdAmhWMSZgYDSKTr2ZLP+xS+KBN28C7yg8YH72/TqmjrdhdrxlDtiULxOnq6hhVDde9oQ7g5oX8OBmSmFp+aFaGnWSPVQsNr77dM6V7PA2nciq9byhl+OswUkZrn4Z0TBaxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27A41227A8E; Wed, 26 Jun 2024 08:01:35 +0200 (CEST)
Date: Wed, 26 Jun 2024 08:01:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: libc-hacker@sourceware.org, linux-fsdevel@vger.kernel.org
Cc: Trond Myklebust <trondmy@hammerspace.com>
Subject: posix_fallocate behavior in glibc
Message-ID: <20240626060134.GA22955@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi all,

Trond brought the glibc posix_fallocate behavior to my attention.

As a refresher, this is how Open Group defines posix_fallocate:

   The posix_fallocate() function shall ensure that any required storage
   for regular file data starting at offset and continuing for len bytes
   is allocated on the file system storage media. If posix_fallocate()
   returns successfully, subsequent writes to the specified file data
   shall not fail due to the lack of free space on the file system
   storage media.

The glibc implementation in sysdeps/posix/posix_fallocate.c, which is
also by sysdeps/unix/sysv/linux/posix_fallocate.c as a fallback if the
fallocate syscall returns EOPNOTSUPP is implemented by doing single
byte writes at intervals of min(f.f_bsize, 4096).

This assumes the writes to a file guarantee allocating space for future
writes.  Such an assumption is false for write out place file systems
which have been around since at least they early 1990s, but are becoming
at lot more common in the last decode.  Native Linux examples are
all file systems sitting on zoned devices where this is required
behavior, but also the nilfs2 file system or the LFS mode in f2fs.
On top of that it is fairly common for storage systems exposing
network file system access.

How can we get rid of this glibc fallback that turns the implementations
non-conformant and increases write amplication for no good reason?


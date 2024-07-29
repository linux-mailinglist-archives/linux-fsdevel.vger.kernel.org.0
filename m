Return-Path: <linux-fsdevel+bounces-24464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1993FA4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57C01C223AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92E9158A26;
	Mon, 29 Jul 2024 16:09:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B21548E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269397; cv=none; b=aCCgOlxjIuASn+KttH6axd5H5HwocWzg3PzeeNW2bKzxSGeWKL88aZTqvoDBuVbFkC9qmVz6PJHP1FM3Fmc/FW6Mhc6CohzWDHHpM2iMbbi5ErbflMR+kXIlGUHvdozSjxzwrbo+Gc/4GvZj9cMJR1n5U15NklMbW2LunysUeFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269397; c=relaxed/simple;
	bh=Mrd61GjTJtEHqxdxw0U008gj5UGlJYVNZs9k8x2dQpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y2uA5vRU1bN7+zl9Q2btOPe8AnvR4gYQrZ7rtP1Pz/ogMdHT8rPawvSgzLKVZ0VY8avmV9chMJArgAyj+/f1PhCsLP8zFBpkVeobnhbRin2fSaJTlBo5Qdyb2kIANFPhKvb3rdf0zSSybbDYiVRedw3KkFZ6XX1rorDpps6AObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 602C468B05; Mon, 29 Jul 2024 18:09:51 +0200 (CEST)
Date: Mon, 29 Jul 2024 18:09:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org
Cc: Trond Myklebust <trondmy@hammerspace.com>
Subject: posix_fallocate behavior in glibc
Message-ID: <20240729160951.GA30183@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi glibc hackers,

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


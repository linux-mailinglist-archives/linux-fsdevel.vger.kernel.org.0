Return-Path: <linux-fsdevel+bounces-67532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5BC42CF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 13:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E90188DBF3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D2257AD1;
	Sat,  8 Nov 2025 12:37:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cygnus.enyo.de (cygnus.enyo.de [79.140.189.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84601B81D3;
	Sat,  8 Nov 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.140.189.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605454; cv=none; b=maNFrF+U8tRdcDRtNv6O/gKFQAKa148pLzbufhIDFFw7fC3deboDL5hBLAcgAJfUGakaO447pz2+CmP628hHrvNa5JCCu8+JmwRr2AEhUQnDzvKjgSipAhnbjb/eNnm2fM+Xy6MAtgtgIsKRk618sSGsfO1+I2pZQfLP/EXqnW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605454; c=relaxed/simple;
	bh=NiZXhsu8l9stZGCY12NJjHjUXDrbcQ4AP91b+KknZEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KqktVLJII6r7982be6j8VL0UAynWN//64sXiT+20s2KJS+2AlV6NEbmtFglS4eEz1XUGWM+LfFWvJu9LA2KwK7CRtCqjQjdtI2tjuraCLNgK/S8PywU9UWrRg9ZiJEkcdpfZ1EEuA2eVIkfF7uZrIPKF7tuL/pWqUO4cCfVXhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de; spf=pass smtp.mailfrom=deneb.enyo.de; arc=none smtp.client-ip=79.140.189.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deneb.enyo.de
Received: from [172.17.203.2] (port=55061 helo=deneb.enyo.de)
	by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vHi5C-00000005xuU-2FLj;
	Sat, 08 Nov 2025 12:30:18 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.98.2)
	(envelope-from <fw@deneb.enyo.de>)
	id 1vHi5C-00000000B4X-1Zfa;
	Sat, 08 Nov 2025 13:30:18 +0100
From: Florian Weimer <fw@deneb.enyo.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Florian Weimer <fweimer@redhat.com>,  Matthew Wilcox
 <willy@infradead.org>,  Hans Holmberg <hans.holmberg@wdc.com>,
  linux-xfs@vger.kernel.org,  Carlos Maiolino <cem@kernel.org>,  Dave
 Chinner <david@fromorbit.com>,  "Darrick J . Wong" <djwong@kernel.org>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <20251106170501.GA25601@lst.de> (Christoph Hellwig's message of
	"Thu, 6 Nov 2025 18:05:01 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de>
Date: Sat, 08 Nov 2025 13:30:18 +0100
Message-ID: <878qgg4sh1.fsf@mid.deneb.enyo.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

* Christoph Hellwig:

> On Thu, Nov 06, 2025 at 05:31:28PM +0100, Florian Weimer wrote:
>> It's been a few years, I think, and maybe we should drop the allocation
>> logic from posix_fallocate in glibc?  Assuming that it's implemented
>> everywhere it makes sense?
>
> I really think it should go away.  If it turns out we find cases where
> it was useful we can try to implement a zeroing fallocate in the kernel
> for the file system where people want it.  gfs2 for example currently
> has such an implementation, and we could have somewhat generic library
> version of it.

Sorry, I remember now where this got stuck the last time.

This program:

#include <fcntl.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

int
main(void)
{
  FILE *fp = tmpfile();
  if (fp == NULL)
    abort();
  int fd = fileno(fp);
  posix_fallocate(fd, 0, 1);
  char *p = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
  *p = 1;
}

should not crash even if the file system does not support fallocate.
I hope we can agree on that.  I expect avoiding SIGBUS errors because
of insufficient file size is a common use case for posix_fallocate.
This use is not really an optimization, it's required to get mmap
working properly.

If we can get an fallocate mode that we can use as a fallback to
increase the file size with a zero flag argument, we can definitely
use that in posix_fallocate (replacing the fallback path on kernels
that support it).  All local file systems should be able to implement
that (but perhaps not efficiently).  Basically, what we need here is a
non-destructive ftruncate.

Maybe add two flags, one for the ftruncate replacement, and one that
instructs the file system that the range will be used with mmap soon?
I expect this could be useful information to the file system.  We
wouldn't use it in posix_fallocate, but applications calling fallocate
directly might.

Christoph, is this something you could help with?


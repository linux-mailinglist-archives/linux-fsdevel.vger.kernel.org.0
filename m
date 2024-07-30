Return-Path: <linux-fsdevel+bounces-24630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A72A941F23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967841C23598
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805618A6A8;
	Tue, 30 Jul 2024 17:59:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80E1898F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.234.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362391; cv=none; b=dVY/428tko1DFlU/Ck9niz2Opd0VIqcb+/O6hUiXFWz0Z7uN3hZlBGtShmLhnsF2NTNCOsb2UKw1Gq6wXMtD+e4uyWjDQUbU9pLVc35ryl+mdvXwSVI9tY66oQsO0zyJ9kcqIceQH2mLmUwVpIOTdnGG66Y1NXWduG9rkCEDmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362391; c=relaxed/simple;
	bh=B0cOhxpfe46bR2kOB4eXJJl2KZmcUtK05biHegV7iWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuTLOz6kZNH4DmRBMQQOQfPU5Z5uQCRnKE0+uDgeeqTOYuJadKTuHEReXEJ1mUnesSkqNsWC/eC6PXYcXc/+OWFnVvV3iDGpnQ+sx580HED4Pf8OcyHuLg7FOc4xLKKeD+rreRVka420KNZre0f7ITmx7MoeYyxC1LIZyiBkQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org; spf=pass smtp.mailfrom=klomp.org; arc=none smtp.client-ip=45.83.234.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id 3EA8C306A5C4; Tue, 30 Jul 2024 19:52:35 +0200 (CEST)
Date: Tue, 30 Jul 2024 19:52:35 +0200
From: Mark Wielaard <mark@klomp.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Paul Eggert <eggert@cs.ucla.edu>,
	libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240730175235.GC24765@gnu.wildebeest.org>
References: <20240729160951.GA30183@lst.de>
 <87a5i0krml.fsf@oldenburg.str.redhat.com>
 <20240729184430.GA1010@lst.de>
 <877cd4jajz.fsf@oldenburg.str.redhat.com>
 <20240729190100.GA1664@lst.de>
 <8734nsj93p.fsf@oldenburg.str.redhat.com>
 <20240730154730.GA30157@lst.de>
 <e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu>
 <20240730162042.GA31109@lst.de>
 <87o76ezua1.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o76ezua1.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi,

On Tue, Jul 30, 2024 at 07:03:50PM +0200, Florian Weimer wrote:
> At the very least, we should have a variant of ftruncate that never
> truncates, likely under the fallocate umbrella.  It seems that that's
> how posix_fallocate is used sometimes, for avoiding SIGBUS with mmap.
> To these use cases, whether extents are allocated or not does not
> matter.

This is how/why elfutils libelf uses posix_fallocate when using
ELF_C_RDWR_MMAP. The comment for it says:

      /* When using mmap we want to make sure the file content is
         really there. Only using ftruncate might mean the file is
         extended, but space isn't allocated yet.  This might cause a
         SIGBUS once we write into the mmapped space and the disk is
         full.  In glibc posix_fallocate is required to extend the
         file and allocate enough space even if the underlying
         filesystem would normally return EOPNOTSUPP.  But other
         implementations might not work as expected.  And the glibc
         fallback case might fail (with unexpected errnos) in some cases.
         So we only report an error when the call fails and errno is
         ENOSPC. Otherwise we ignore the error and treat it as just hint.  */

Cheers,

Mark


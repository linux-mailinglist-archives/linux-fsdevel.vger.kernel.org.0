Return-Path: <linux-fsdevel+bounces-44043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7839A61CF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97F44222BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7E2054FF;
	Fri, 14 Mar 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="tFIgDYdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9331632D3;
	Fri, 14 Mar 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985072; cv=none; b=TPERX7cxCGnvKdDDdeRpgl+fTabCqgffCfOEPA/G5CnVdojH/T4bseTrYjSX5Ud9X0qZ9dtCidkSqStgs2+rWYtGzJmVbl1RQcjIorwKi5GGRc0+3fYkrWjCdo5QQx1lWbSP4sAE8PwcGRRpdctVJlICULZGaHMle8R1MWZpBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985072; c=relaxed/simple;
	bh=JyG22rQanR20rroHpv7WbHnkxDMN0Sl/fGM84V0PFu8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=sQzDN4wsSlWyaPYCEt8NceUmt8KNtUpfs6p16PAQqfdDKb5mF57/fq2Ew8105wod6JJLjHIdq6NQt70NuWWOyZC4wzvvnb+03faY6y+uvPAOY4CQ2DIzpe02i8GqKqN2gzR8454t/YwmVMI6ffMY9J3LG+FLOZVBWGpuV8J5Urw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=tFIgDYdA; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <9a3639ed95490e40b62d364c09c24e3b@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1741985062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lOZkNdUaYMusY2QeOlezuCxMiABAc9kVpuc6FXYat0=;
	b=tFIgDYdAsoNcnjS3dkr1KhlaZYrnBfwnB7kuLEFjpk6j5sw9hEBSMUs9U4HXMXoAnVO2Pc
	THVyUetr1klfBZwTEld/u6PkRVmXHG2uA1ta6CejWl2n4dv/7hguOB2Prjm8i1d/C5NfGo
	O0VfMw0v9AiBr4ZfcdlLjtmYFNEdV4u6HWnxH7l+02PcbXGkl4TExaRB1lvDSbENQbm4Lx
	wWyj2hTvFuP/5tl4s/jeDPkckHkp7CJgaN3gC5Za/vCg/22KRPBhOpW0IKr0TBmxI4KmjR
	UhYLmFRhZ9oZYSMIng6M0dfvUp+IRfLOISjgOjApm/JWdprEJ+h+rTL/JT/2SA==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>, Max Kellermann
 <max.kellermann@ionos.com>, Jeff Layton <jlayton@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] netfs: Miscellaneous fixes
In-Reply-To: <20250314164201.1993231-1-dhowells@redhat.com>
References: <20250314164201.1993231-1-dhowells@redhat.com>
Date: Fri, 14 Mar 2025 17:44:17 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Hi Christian,
>
> Here are some miscellaneous fixes and changes for netfslib, if you could
> pull them:
>
>  (1) Fix the collection of results during a pause in transmission.
>
>  (2) Call ->invalidate_cache() only if provided.
>
>  (3) Fix the rolling buffer to not hammer atomic bit clears when loading
>      from readahead.
>
>  (4) Fix netfs_unbuffered_read() to return ssize_t.
>
> The patches can also be found here:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes
>
> Thanks,
> David
>
> David Howells (3):
>   netfs: Fix collection of results during pause when collection
>     offloaded
>   netfs: Fix rolling_buffer_load_from_ra() to not clear mark bits
>   netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
>
> Max Kellermann (1):
>   netfs: Call `invalidate_cache` only if implemented
>
>  fs/netfs/direct_read.c    |  6 +++---
>  fs/netfs/read_collect.c   | 18 ++++++++++--------
>  fs/netfs/rolling_buffer.c |  4 ----
>  fs/netfs/write_collect.c  |  3 ++-
>  4 files changed, 15 insertions(+), 16 deletions(-)

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>


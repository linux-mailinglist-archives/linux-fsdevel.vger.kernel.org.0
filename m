Return-Path: <linux-fsdevel+bounces-24621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4276794185D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AEB2817E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3D183CBF;
	Tue, 30 Jul 2024 16:20:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BE1078F
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356448; cv=none; b=Lce2/Jo04UQJv3lqV0Sc3Riz3aXXgKj3Xq9y9Z6i5oVopuaH2+wJj0lSZXYoNq98+4cdl49kuNbekx7/STfLMAV9um/gMyK0FrZ5rZ1iI4uXbaAonX5WFbZUXGALVxupQJ1UwRq2YaQktkGLqfI9pf5Xr6B1pS7Zgx1PFOeR5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356448; c=relaxed/simple;
	bh=PHxkPaAJsVWfhrZqePxH6qLiTq34jWCbI0LyQh/4kDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUy+wwCpJW2ERVDWvE3Q9abqOh+P18kkpwFz3ewyjX00UbnScBts7t9mEdmATtj/ZerEyzeuUbuVCOIEAx1WfZ9F9cIFg6t2kQXTbG/pCup/qLn9/V2NLdsiQc7wj12j9B+/8sGO1tWSd3QJOEfOMgy2cFoOZGOn/2/ZGIHEFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 84B0D68AA6; Tue, 30 Jul 2024 18:20:42 +0200 (CEST)
Date: Tue, 30 Jul 2024 18:20:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240730162042.GA31109@lst.de>
References: <20240729160951.GA30183@lst.de> <87a5i0krml.fsf@oldenburg.str.redhat.com> <20240729184430.GA1010@lst.de> <877cd4jajz.fsf@oldenburg.str.redhat.com> <20240729190100.GA1664@lst.de> <8734nsj93p.fsf@oldenburg.str.redhat.com> <20240730154730.GA30157@lst.de> <e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 30, 2024 at 09:11:17AM -0700, Paul Eggert wrote:
> It would help glibc distinguish the following cases:
>
> A. file systems whose internal structure supports the semantics of 
> posix_fallocate, and where user-mode code can approximate those semantics 
> by writing zeros, but where that feature has not been implemented in the 
> kernel's file system code so the system call currently fails with 
> EOPNOTSUPP.
>
> B. file systems whose internal structure cannot support the semantics of 
> posix_fallocate and you cannot approximate them, and where the system call 
> currently fails with EOPNOTSUPP.

As mentioned earlier in the thread case a) are basically legacy / foreign
OS compatibility file systems (minix, sysfs, hfs/hfsplus).  They are
probably not something that people actually use posix_fallocate on.
The only relevant exception is probably ext4 in ext2/ext3 mode, where
the latter might still have users left running real workloads on it
and not using it for usb disks or VM images.

> Florian is proposing that different error numbers be returned for (A) vs 
> (B) so that glibc posix_fallocate can treat the cases differently.

The problem with a new error code is that it will leak out to the
application when using a new kernel and an old glibc.  If we want to skin
the cat that way a better way might be to expose this kind of information
through a statx flag or a similar interface.



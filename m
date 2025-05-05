Return-Path: <linux-fsdevel+bounces-48082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04D6AA94AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ED8175ADB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D744253921;
	Mon,  5 May 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTC/a18v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9C4C62;
	Mon,  5 May 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452265; cv=none; b=KO0qJWjP41zuYwlra8ecxS9Yzsq4WxnV6yIaDFCBm0shtAD99jws52BVoQSBYOCfJVjP4ECASkPhIvg7yBO/k2Dc13+hbFd3CmYq2y+fs+2//t7+d8H+DPN9ha58gR8CeaX4Gxh2OPt/Ic0FmtY2eJXhWNQ6qwzd9T9TY+6tP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452265; c=relaxed/simple;
	bh=IZHg9odk9bDIZMztFTJjQU96GEYqgDiVHKES6Znv4V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJpUo43sr7k609JTBsO9W6dsfDjLyk3vLHQ/uiO+TeS5WMVjSJDRPTtgrcu3qpvbKdWbpcqMEshMf4GZIIB0NBHUWEgIZqQbToRHFnN/XsIE//XgekPez6s3Q2dwrXv99InnGN3Lvp+xnUh37X6c3VSdNmmj6k7oC0sNVICw4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTC/a18v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B2CC4CEE4;
	Mon,  5 May 2025 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746452264;
	bh=IZHg9odk9bDIZMztFTJjQU96GEYqgDiVHKES6Znv4V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTC/a18vN15zzDRcH6W2HE4hiOXv6dG+FfkKUWIpOc9XgzPMWRLVg8DaK8r9mtI8h
	 MDTCgUVV8uNAdmZvRh0kQGTImWlzCwIto+6hdjuaXYqMrJcP7aAYTnKWaY3yGmHgGK
	 glTj3npkVpgtVZHNSFdorACh8GtoduHxWTY9sg7pdZLGcp4vaKRiUH5vocu6489mc5
	 R8oPGS4RJo4BhkG/zCB6vrxDxqEXfuyiM7wVcaJ4s56wwtLPdv6m/rlDihtj5F7rtu
	 ZIivXEjuenPfkWTz92vnczGkpyCqqhQA2qn/RDvx0bLmURWL5botH/txI9iruxQuKD
	 zAWqyEYF9S7iA==
Date: Mon, 5 May 2025 15:37:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 0/3] eliminate mmap() retry merge, add
 .mmap_prepare hook
Message-ID: <20250505-frisur-stempeln-9b66d6115726@brauner>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
 <uevybgodhkny6dihezto4gkfup6n7znaei6q4ehlkksptlptwr@vgm2tzhpidli>
 <0776ce6e-ed62-4eaa-a71a-a082dafbdb99@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0776ce6e-ed62-4eaa-a71a-a082dafbdb99@lucifer.local>

On Fri, May 02, 2025 at 01:59:49PM +0100, Lorenzo Stoakes wrote:
> On Fri, May 02, 2025 at 02:20:38PM +0200, Jan Kara wrote:
> > On Thu 01-05-25 18:25:26, Lorenzo Stoakes wrote:
> > > During the mmap() of a file-backed mapping, we invoke the underlying driver
> > > file's mmap() callback in order to perform driver/file system
> > > initialisation of the underlying VMA.
> > >
> > > This has been a source of issues in the past, including a significant
> > > security concern relating to unwinding of error state discovered by Jann
> > > Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > > error path behaviour") which performed the recent, significant, rework of
> > > mmap() as a whole.
> > >
> > > However, we have had a fly in the ointment remain - drivers have a great
> > > deal of freedom in the .mmap() hook to manipulate VMA state (as well as
> > > page table state).
> > >
> > > This can be problematic, as we can no longer reason sensibly about VMA
> > > state once the call is complete (the ability to do - anything - here does
> > > rather interfere with that).
> > >
> > > In addition, callers may choose to do odd or unusual things which might
> > > interfere with subsequent steps in the mmap() process, and it may do so and
> > > then raise an error, requiring very careful unwinding of state about which
> > > we can make no assumptions.
> > >
> > > Rather than providing such an open-ended interface, this series provides an
> > > alternative, far more restrictive one - we expose a whitelist of fields
> > > which can be adjusted by the driver, along with immutable state upon which
> > > the driver can make such decisions:
> > >
> > > struct vm_area_desc {
> > > 	/* Immutable state. */
> > > 	struct mm_struct *mm;
> > > 	unsigned long start;
> > > 	unsigned long end;
> > >
> > > 	/* Mutable fields. Populated with initial state. */
> > > 	pgoff_t pgoff;
> > > 	struct file *file;
> > > 	vm_flags_t vm_flags;
> > > 	pgprot_t page_prot;
> > >
> > > 	/* Write-only fields. */
> > > 	const struct vm_operations_struct *vm_ops;
> > > 	void *private_data;
> > > };
> > >
> > > The mmap logic then updates the state used to either merge with a VMA or
> > > establish a new VMA based upon this logic.
> > >
> > > This is achieved via new file hook .mmap_prepare(), which is, importantly,
> > > invoked very early on in the mmap() process.
> > >
> > > If an error arises, we can very simply abort the operation with very little
> > > unwinding of state required.
> >
> > Looks sensible. So is there a plan to transform existing .mmap hooks to
> > .mmap_prepare hooks? I agree that for most filesystems this should be just
> > easy 1:1 replacement and AFAIU this would be prefered?
> 
> Thanks!
> 
> Yeah the intent is to convert _all_ callers away from .mmap() so we can
> lock down what drivers are doing and be able to (relatively) safely make
> assumptions about what's going on in mmap logic.
> 
> As David points out, we may need to add new callbacks to account for other

The plural is a little worrying, let's please aim minimize the number of
new methods we need for this.


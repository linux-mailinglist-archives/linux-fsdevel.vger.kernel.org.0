Return-Path: <linux-fsdevel+bounces-44326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A8A67669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCF8188905B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F86D20E01F;
	Tue, 18 Mar 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM8GGehu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6C20DD5C;
	Tue, 18 Mar 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307934; cv=none; b=HLhfF+RhML0gO6V07//D5R2r/96zSdBYP5AYyEP5ogBqQxg9iMcskWZthzJVqhEf0kxMMHGduxeasyja1a5tXZhL+T6zJjb5HbVARyrGV/t59PFyOBuXOFIO81I03kPYfwQQAyjtAEAIsi8ZIJHOBSFEkwEmlhmeisScb2qLoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307934; c=relaxed/simple;
	bh=nZIVy8rDifxs0gFezfDSsyY7SSuvanD4bNKBzieVH6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdvXG1ecr5KRiGBwXJrr7A1kT+AjCFqNS4hNBmB+aMELWG4ouTCS3JVZGSZI3RBu540PdPEVCx9kTuOSLYGn+WuhcsTn7n/v+/R9g9sIMlu2nZ8oA1lhd4IFtkckVT8cSBUgZ7ASujRqzpgPAjei/the5bCGpwTNtHEFPalEz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM8GGehu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDB4C4CEE3;
	Tue, 18 Mar 2025 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307933;
	bh=nZIVy8rDifxs0gFezfDSsyY7SSuvanD4bNKBzieVH6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eM8GGehuJpGvKpivoD4QSR+KNpQOrsTrQe+Eub+aqiMOwfDX+Sd0MybIJqruOhLex
	 biGvEmTGReQmgJ0IFMiGSlsFCq55zmnjRdh9Dlq8a6caIHoCMo3/rPvEJL08UzkuDN
	 toN9B7pWXLt+twkHsRTlar9Rfb66Cl4bQcgCIOS8cFxXk2uIFCHgdYG8XQb4ijRSm1
	 w0PNZNXJFIdg+wPtVYcf+3mmQxVsJ26tSr9ThAZwKrW6wApcHfaFvTr2sYnUovdUby
	 vejqSYllChZiA15Jx6PSxONI+qOkHqf4Bvr4azaaeG/UCSBsE68OPkVC5lNPRzkyLS
	 65BarMYc5GzlQ==
Date: Tue, 18 Mar 2025 15:25:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Eric Biederman <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Alexander Graf <graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	David Woodhouse <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250318-toppen-elfmal-968565e93e69@brauner>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <mafs0ikokidqz.fsf@amazon.de>
 <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
 <20250317165905.GN9311@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317165905.GN9311@nvidia.com>

On Mon, Mar 17, 2025 at 01:59:05PM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 09, 2025 at 01:03:31PM +0100, Christian Brauner wrote:
> 
> > So either that work is done right from the start or that stashing files
> > goes out the window and instead that KHO part is implemented in a way
> > where during a KHO dump relevant userspace is notified that they must
> > now serialize their state into the serialization stash. And no files are
> > actually kept in there at all.
> 
> Let's ignore memfd/shmem for a moment..
> 
> It is not userspace state that is being serialized, it is *kernel*
> state inside device drivers like VFIO/iommufd/kvm/etc that is being
> serialized to the KHO.
> 
> The file descriptor is simply the handle to the kernel state. It is
> not a "file" in any normal filesystem sense, it is just an uAPI handle
> for a char dev that is used with IOCTL.
> 
> When KHO is triggered triggered whatever is contained inside the FD is
> serialized into the KHO.
> 
> So we need:
>  1) A way to register FDs to be serialized. For instance, not every
>     VFIO FD should be retained.
>  2) A way for the kexecing kernel to make callbacks to the char dev
>     owner (probably via struct file operations) to perform the
>     serialization
>  3) A way for the new kernel to ask the char dev owner to create a new
>     struct file out of the serialized data. Probably allowed to happen
>     only once, ie you can't clone these things. This is not the same
>     as just opening an empty char device, it would also fill the char
>     device with whatever data was serialized.
>  4) A way to get the struct file into a process fd number so userspace
>     can route it to the right place.
> 
> It is not really a stash, it is not keeping files, it is hardwired to

Right now as written it is keeping references to files in these fdboxes
and thus functioning both as a crippled high-privileged fdstore and a
serialization mechanism. Please get rid of the fdstore bits and
implement it in a way that it serializes files without stashing
references to live files that can at arbitrary points in time before the
fdbox is "sealed" be pulled out and installed into the caller's fdtable
again.

> KHO to drive it's serialize/deserialize mechanism around char devs in
> a very limited way.
> 
> If you have that then feeding an anonymous memfd/guestmemfd through
> the same machinery is a fairly small and logical step.
> 
> Jason


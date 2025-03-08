Return-Path: <linux-fsdevel+bounces-43513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F5A579F3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E447B3B6BDA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018D21B4159;
	Sat,  8 Mar 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI558XKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7019CCF5;
	Sat,  8 Mar 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741432203; cv=none; b=HnP8VgVT02Ol9EbKxdqYOmiR6ci+zgiBqTB8S4sw+8rJxiB5ldd4cv+5SyT/cPCpifxv3UgZl81rz/KwFzdrHbwcrzEdmbqYO1NhDDM5MHm54BPvuunYHvRbfaWkjQCQbxAdr5j//AyTMoInUMVdOlPWNkRF+KXVUv4gNRUk+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741432203; c=relaxed/simple;
	bh=wjd4lKQpkpaeMS8a8WAbOFRqGjEHqDFGgmCn5GH9lJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgV6ZL1OlRfKc+XYtSNOWNBeKpgSNhKg6fx7WQtcpQ2jg5yGkYc6fzDKSh34QgW3xEGFsTKgnIe8nEwwh/OyJt2txRgsCQHbW5M6buoqR8flqJsL//OVtqEakxynVyqBkjoRYu4aPJtjnnz9Kiua5VCBpKs4KtykcjKh7TT7Ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI558XKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1039C4CEE0;
	Sat,  8 Mar 2025 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741432202;
	bh=wjd4lKQpkpaeMS8a8WAbOFRqGjEHqDFGgmCn5GH9lJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jI558XKLWX4PB6OS6TWHt63q8OOLntXovXrL6g7R2IoQRHOlRc/x7GiCAlKt0cPFy
	 UJ0m3En3iOcOcnQcbaVNuygjBEHCamf6ZkdzcnkQIRvMuUudvdzJWQWRp7TahzpnMt
	 po0NZYAOhJI6nMu6namwhF1JZ8c6L4Uwwsy+Qf0MIpylpTrKc5oTGhRkKIHp9gZqjx
	 vUxCFDU4Ipw5VzgvYnbEX12w67Cv5lQXFJ9DU8slKx5BVC73IiYGs+zAZrXqdfkRlH
	 pt5tWcD9gqJHqEDOAFRx9ppRpRmQMDbjsaWfFTMiOSAlIuSw7Ly4btwIUFTyVT8+VV
	 waKmgfyh1ZNxQ==
Date: Sat, 8 Mar 2025 12:09:53 +0100
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
Message-ID: <20250308-wutanfall-ersetzbar-2aedc820d80d@brauner>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <20250307151417.GQ354511@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307151417.GQ354511@nvidia.com>

On Fri, Mar 07, 2025 at 11:14:17AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 10:31:39AM +0100, Christian Brauner wrote:
> > On Fri, Mar 07, 2025 at 12:57:35AM +0000, Pratyush Yadav wrote:
> > > The File Descriptor Box (FDBox) is a mechanism for userspace to name
> > > file descriptors and give them over to the kernel to hold. They can
> > > later be retrieved by passing in the same name.
> > > 
> > > The primary purpose of FDBox is to be used with Kexec Handover (KHO).
> > > There are many kinds anonymous file descriptors in the kernel like
> > > memfd, guest_memfd, iommufd, etc. that would be useful to be preserved
> > > using KHO. To be able to do that, there needs to be a mechanism to label
> > > FDs that allows userspace to set the label before doing KHO and to use
> > > the label to map them back after KHO. FDBox achieves that purpose by
> > > exposing a miscdevice which exposes ioctls to label and transfer FDs
> > > between the kernel and userspace. FDBox is not intended to work with any
> > > generic file descriptor. Support for each kind of FDs must be explicitly
> > > enabled.
> > 
> > This makes no sense as a generic concept. If you want to restore shmem
> > and possibly anonymous inodes files via KHO then tailor the solution to
> > shmem and anon inodes but don't make this generic infrastructure. This
> > has zero chances to cover generic files.
> 
> We need it to cover a range of FD types in the kernel like iommufd and

anonymous inode

> vfio.

anonymous inode

> 
> It is not "generic" in the sense every FD in the kernel magicaly works
> with fdbox, but that any driver/subsystem providing a FD could be
> enlightened to support it.
> 
> Very much do not want the infrastructure tied to just shmem and memfd.

Anything you can reasonably want will either be an internal shmem mount,
devtmpfs, or anonymous inodes. Anything else isn't going to work.

> 
> > As soon as you're dealing with non-kernel internal mounts that are not
> > guaranteed to always be there or something that depends on superblock or
> > mount specific information that can change you're already screwed.
> 
> This is really targetting at anonymous or character device file
> descriptors that don't have issues with mounts.
> 
> Same remark about inode permissions and what not. The successor
> kernel would be responsible to secure the FDBOX and when it takes
> anything out it has to relabel it if required.
> 
> inode #s and things can change because this is not something like CRIU
> that would have state linked to inode numbers. The applications in the
> sucessor kernels are already very special, they will need to cope with
> inode number changes along with all the other special stuff they do.
> 
> > And struct file should have zero to do with this KHO stuff. It doesn't
> > need to carry new operations and it doesn't need to waste precious space
> > for any of this.
> 
> Yeah, it should go through file_operations in some way.

I'm fine with a new method. There's not going to be three new methods
just for the sake of this special-purpose thing. And want this to be
part of fs/ and co-maintained by fs people.

I'm not yet sold that this needs to be a character device. Because
that's fundamentally limiting in how useful this can be.

It might be way more useful if this ended up being a separate tiny
filesystem where such preserved files are simply shown as named entries
that you can open instead of ioctl()ing your way through character
devices. But I need to think about that.


Return-Path: <linux-fsdevel+bounces-40536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82587A24989
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62047A31BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4218B1C07C4;
	Sat,  1 Feb 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHVcnBTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B81EF01;
	Sat,  1 Feb 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738420711; cv=none; b=SAxZW/9TROlCUVQPc9m2Gh5AJBnneGy38kg+xtKqwkczy/H6NNz0g41XQ7OHPHKJNdkVw9z+YUCQFS9f/XMrMAOP1fA1ZvxqJ5i0239f3dJwl5htFEjniIFNwBwWzHkTUk/ccAWk+lR7HJVQT2mcMgnvO0UJUQS4xRmDwkOZULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738420711; c=relaxed/simple;
	bh=QiSjG7TvkKqWoaD2aBFrVJnxmPFyXLRgqp8pz0gLUzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sir0E/nrq4GSzZD1K/Hr6zwMS/KFWTY1dUzg66F2NSymciBIC/Dk2lrojlTz7m7+gl1d94Tn5Hbqy7kGuWhFy8Y6RXdR8gjaIuPHamkSz81OufFhZUR0YnhKe57Ji6VagnGsAMGEXGCUG1I1b9+bD2pycFFwZnfOWvMgSxf3uFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHVcnBTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81966C4CED3;
	Sat,  1 Feb 2025 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738420710;
	bh=QiSjG7TvkKqWoaD2aBFrVJnxmPFyXLRgqp8pz0gLUzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHVcnBTqerPHgxQCTpImKkHSbu00uWLYWvzmwAtGSlEM5YJZsz+IONl1JAUXaAYeS
	 UJ9kApP54ppYFtkOEdEpcq3q/cMh6HuYR1mHH/xKj/oPfQVrOmFtSrd8PKELMi9ZKd
	 aMt49gIWUhJubrKpeqIdvzW/w1uO2UpMYnZh0EB8fqF0FzQhG/nkrRTh0n3uupqhJX
	 GL6/bojxTFS3yFivQGFxojQ/70DT1M5BSJIYxKerpN3FTZplWkma3sNKC0V8QcHgvv
	 06dPyDUVaBQCjxiqI0K2TaqPFoWFtdm50CRElJU5ocUYzDcQzY+iGG0rhGd7AyrKNH
	 jwF5lZf/kuiTQ==
Date: Sat, 1 Feb 2025 15:38:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults
 for files with pre content watches
Message-ID: <20250201-legehennen-klopfen-2ab140dc0422@brauner>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com>
 <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z512mt1hmX5Jg7iH@x1.local>

On Fri, Jan 31, 2025 at 08:19:22PM -0500, Peter Xu wrote:
> On Fri, Jan 31, 2025 at 11:59:56AM -0800, Linus Torvalds wrote:
> > On Fri, 31 Jan 2025 at 11:17, Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
> > >
> > > This breaks huge_fault support for PFNMAPs that was recently added in
> > > v6.12 and is used by vfio-pci to fault device memory using PMD and PUD
> > > order mappings.
> > 
> > Surely only for content watches?
> > 
> > Which shouldn't be a valid situation *anyway*.
> > 
> > IOW, there must be some unrelated bug somewhere: either somebody is
> > allowed to set a pre-content match on a special device.
> > 
> > That should be disabled by the whole
> > 
> >         /*
> >          * If there are permission event watchers but no pre-content event
> >          * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
> >          */
> > 
> > thing in file_set_fsnotify_mode() which only allows regular files and
> > directories to be notified on.
> > 
> > Or, alternatively, that check for huge-fault disabling is just
> > checking the wrong bits.
> > 
> > Or - quite possibly - I am missing something obvious?
> 
> Is it possible that we have some paths got overlooked in setting up the
> fsnotify bits in f_mode? Meanwhile since the default is "no bit set" on
> those bits, I think it means FMODE_FSNOTIFY_HSM() can always return true on
> those if overlooked..
> 
> One thing to mention is, /dev/vfio/* are chardevs, however the PCI bars are
> not mmap()ed from these fds - whatever under /dev/vfio/* represents IOMMU
> groups rather than the device fd itself.
> 
> The app normally needs to first open the IOMMU group fd under /dev/vfio/*,
> then using VFIO ioctl(VFIO_GROUP_GET_DEVICE_FD) to get the device fd, which
> will be the mmap() target, instead of the ones under /dev.

Ok, but those "device fds" aren't really device fds in the sense that
they are character fds. They are regular files afaict from:

vfio_device_open_file(struct vfio_device *device)

(Well, it's actually worse as anon_inode_getfile() files don't have any
mode at all but that's beside the point.)?

In any case, I think you're right that such files would (accidently?)
qualify for content watches afaict. So at least that should probably get
FMODE_NONOTIFY.

> 
> I checked, those device fds were allocated from vfio_device_open_file()
> within the ioctl, which internally uses anon_inode_getfile().  I don't see
> anywhere in that path that will set the fanotify bits..
> 
> Further, I'm not sure whether some callers of alloc_file() can also suffer

Sidenote, mm/memfd.c should pretty please rename alloc_file() to
memfd_alloc_file() or something. That would be great because
alloc_file() is a local fs/file_table.c helper and grepping for it is
confusing as I first thought someone made alloc_file() available outside
of fs/file_table.c

> from similar issue, because at least memfd_create() syscall also uses the
> API, which (hopefully?) would used to allow THPs for shmem backed memfds on
> aligned mmap()s, but not sure whether it'll also wrongly trigger the
> FALLBACK path similarly in create_huge_pmd() just like vfio's VMAs.  I
> didn't verify it though, nor did I yet check more users.
> 
> So I wonder whether we should setup the fanotify bits in at least
> alloc_file() too (to FMODE_NONOTIFY?).
> 
> I'm totally not familiar with fanotify, and it's a bit late to try verify
> anything (I cannot quickly find my previous huge pfnmap setup, so setup
> those will also take time..). but maybe above can provide some clues for
> others..
> 
> Thanks,
> 
> -- 
> Peter Xu
> 


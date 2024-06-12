Return-Path: <linux-fsdevel+bounces-21495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A19048C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 04:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF6A1F2306F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B9B847C;
	Wed, 12 Jun 2024 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rrxrbi1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9ED259C;
	Wed, 12 Jun 2024 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158622; cv=none; b=SG5aRJacxpjkwwVgp/MMN7Nu3rM/9EYxN0r3cWD2VEPJy06gxKcXn8a+zQ0wvQRhc39j6Zp9tWQoQhrFVjbILRE5qoFKAWHvIRO2ksipv5Q8bzf/sg1gAw4PBMF1zgA/eGB4W7jEFkprsvsWAF3PmrjDnaPEbwFvnOy7e6iIwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158622; c=relaxed/simple;
	bh=zV2+YrpIHq+T73Gx+XWvVGmavEA8sSEqdBjbryxzcyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZlNeFkRVCH4nb46nH0b+WLAQSSCbeY5B7d3uf2dq6Y7Sei2sk1CUMz+7JlAMdpo0jEAZdFEUbaNTHXIJDPrnGtHNiZFJQCKmhIHby+aM5M20VTIgyfUdp8vRP1o/SCBz9Z8vHnD/kluf/I+6z8DP2p8YztqfVh0cmKyq/a1bio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rrxrbi1c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1DJa2xF766tLiYmKXQ7Bn6TpsHcJILzbg0BC6Te5wmo=; b=rrxrbi1cYud6fspahNybuZwIwa
	Kp584wZGyxZWzeYFU2/sOS4KkG2DXPwTWomD+AginDfGBs2WUcuKHn+r8h7X5YLIBBODiu0nTd4AG
	IGsuIyL1FRVeTOXqEAodT4Rjv3X8VDjRg7+xPw7TknTt6fAGEQlvt2kKxAgJCaOH+qChYPit5R+E6
	5iv8+cfw4DbMPL36J4qhAImul70dPiMT55S1SYgdTqlojHF9K587ZVNn8QMHdj2MBNSJQKAXFMvXf
	dRSgram/OuQYhE1F2IBAwbWWLpsDabP+u7GDALvbNTr3MXfLOsnAVNHCzLtmWGFG8fE9yEA6L17UZ
	UnufaaKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sHDXh-00Eb3P-28;
	Wed, 12 Jun 2024 02:16:53 +0000
Date: Wed, 12 Jun 2024 03:16:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Fei Li <fei1.li@intel.com>, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] UAF in acrn_irqfd_assign() and vfio_virqfd_enable()
Message-ID: <20240612021653.GF1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV>
 <20240607210814.GC1629371@ZenIV>
 <20240610051206.GD1629371@ZenIV>
 <20240610140906.2876b6f6.alex.williamson@redhat.com>
 <20240610205305.GE1629371@ZenIV>
 <20240611170438.508a2612.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611170438.508a2612.alex.williamson@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 11, 2024 at 05:04:38PM -0600, Alex Williamson wrote:

> > OK, so the memory safety in there depends upon
> > 	* external exclusion wrt vfio_virqfd_disable() on caller-specific
> > locks (vfio_pci_core_device::ioeventfds_lock for vfio_pci_rdwr.c,
> > vfio_pci_core_device::igate for the rest?  What about the path via
> > vfio_pci_core_disable()?)
> 
> This is only called when the device is closed, therefore there's no
> userspace access to generate a race.

Umm...  Let's see if I got confused in RTFS:

	1.  Calls of vfio_pci_core_disable() come from assorted ->close_device()
instances and failure exits in ->open_device() ones.
	2.  ->open_device() is called by vfio_df_device_first_open() from
vfio_df_open().  That's done under device->dev_set->lock.
	3.  ->close_device() is called by vfio_df_device_last_close() from
vfio_df_close(), under the same lock.
	4.  vfio_df_open() comes from vfio_df_ioctl_bind_iommufd() or from
vfio_df_group_open().  vfio_df_close() is done by the failure exits in those
two, as well as by vfio_df_unbind_iommufd() and vfio_df_group_close().
	5.  vfio_df_bind_iommufd() handles VFIO_DEVICE_BIND_IOMMUFD in
vfio_device_fops->unlocked_ioctl(); only works for !df->group and only
once, unless I'm misreading vfio_df_open().  No other ioctls are allowed
until that's done and vfio_df_unbind_iommufd() is done in ->release(),
in case of !df->group.  vfio_df_close() is done there, in case we had
a successful BIND_IOMMUFD done at some point.  Multiple files can be opened
for the same device; once one of them have done BIND_IOMMUFD, BIND_IOMMUFD
on any of them will fail until the first caller gets closed.  Once that
happens, others can get BIND_IOMMUFD; until then ioctls don't work for
them at all (IOW, BIND_IOMMUFD grants the ability to do ioctls only for
the opened file it had been done on).
	6.  vfio_df_group_open() and vfio_df_close() is about the other
way to get files with such ->f_op - VFIO_GROUP_GET_DEVICE_FD handling
in vfio_group_fops.unlocked_ioctl().  That gets an anon-inode file
with vfio_device_fops and shoves it into descriptor table.  Presumably
vfio_device_get_from_name() always returns a device with non-NULL
device->group (it would better, or the things would get really confused).
vfio_df_group_open() is done fist, with vfio_df_group_close() on failure
exit *and* in ->release() of those suckers (again, assuming we do get
non-NULL ->group).

	OK, that seems to be enough - anything done in ->ioctl() would
be completed between vfio_df_open() and vfio_df_close(), so we do have
the exclusion.	Is the above correct?

FWIW, this was a confusing bit:
        vfio_pci_core_disable(vdev);

        mutex_lock(&vdev->igate);
        if (vdev->err_trigger) {
                eventfd_ctx_put(vdev->err_trigger);
                vdev->err_trigger = NULL;
        }
        if (vdev->req_trigger) {
                eventfd_ctx_put(vdev->req_trigger);
                vdev->req_trigger = NULL;
        }
        mutex_unlock(&vdev->igate);
in vfio_pci_core_close_device().  Since we need an exclusion on ->igate
there for something, and since it's one of the locks used to serialize
vfio_virqfd_enable()...

> > 	* no EPOLLHUP on eventfd while the file is pinned.  That's what
> >         /*
> >          * Do not drop the file until the irqfd is fully initialized,
> >          * otherwise we might race against the EPOLLHUP.
> >          */
> > in there (that "irqfd" is a typo for "kirqfd", right?) refers to.
> 
> Sorry, I'm not fully grasping your comment.  "irqfd" is not a typo
> here, "kirqfd" seems to be a Xen thing.  I believe the comment is
> referring to holding a reference to the fd until everything is in place
> to cleanup correctly if the user process is killed mid-setup.  Thanks,

*blink*

s/kirqfd/virqfd/, sorry.  In the comment earlier in the same function:
         * virqfds can be released by closing the eventfd or directly
	   ^^^^^^^
         * through ioctl.  These are both done through a workqueue, so
         * we update the pointer to the virqfd under lock to avoid
				    ^^^ ^^^^^^
         * pushing multiple jobs to release the same virqfd.
					    ^^^ ^^^^ ^^^^^^
In the second comment you have
         * Do not drop the file until the irqfd is fully initialized,
				      ^^^ ^^^^^
         * otherwise we might race against the EPOLLHUP.

	If that refers to the same object, the comment makes sense - once
you've called vfs_poll(), EPOLLHUP wakeup would have your new instance of
struct virqfd freed, so accessing it (e.g. in
                        schedule_work(&virqfd->inject);
) is only safe because EPOLLHUP won't come until eventfd_release(), which
will not happen as long as you don't drop the file reference that sits in
irqfd.file.  That's the reason why struct fd instance can't be released
until you are done with setting the struct virqfd instance up.

	If that reading is what you intended, "irqfd" in the second
comment ought to be "virqfd", to be consistent with the reference to the
same thing in the earlier comment.  If that's not what you meant... what
is that comment really about?  Killing the user process mid-setup won't
actually do anything until your thread is out of whatever syscall it
had been in (ioctl(2), usually); the dangerous scenario would be having
another thread close the same descriptor after you've done fdput().

	The thing you need to avoid is having all references to
eventfd file dropped.  For that the reference in descriptor table must
be gone.  Sure, killing the process might do that - once all threads
get to exit_files() and drop their references to descriptor table.
Then put_files_struct() from the last of them will call close_files()
and drop all file references you had in the table.

	But that can happen only when all threads have gotten through
the signal delivery.  Including the one that was in the middle of
vfio_virqfd_enable().  And _that_ won't happen until return from that
function.

	So having the caller killed mid-setup is not an issue.	Another
thread sharing the same descriptor table and calling close(fd) (or
dup2(something, fd), or anything else that would close that descriptor)
would be.  _That_ is what is prevented by the fdget()/fdput() pair -
between those we are guaranteed that file reference will stay pinned.
If descriptor table is shared, fdget() will clone the reference and store
it in irqfd.file, so the file remains pinned no matter what happens
to descriptor table, until fdput() drops the reference.  If the table
is _not_ shared, the reference in it won't go away until we are done,
so we can borrow that into irqfd.file (and do nothing on fdput()).

	Anyway, I believe that what you have there is actually safe.
Analysis could be less convoluted, but then I might've missed simpler
reasons why everything works.

	It really needs comments in there - as it is, two drivers have
copied that scheme without bothering with exclusion (commit f8941e6c4c71
"xen: privcmd: Add support for irqfd" last year and commit aa3b483ff1d7
"virt: acrn: Introduce irqfd" three years ago) with, AFAICT, real UAF
in each ;-/


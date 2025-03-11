Return-Path: <linux-fsdevel+bounces-43693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C584FA5BE64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582481897A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5551253F11;
	Tue, 11 Mar 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCCm3a5z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13C24394B;
	Tue, 11 Mar 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690915; cv=none; b=tp+CeNbeS5T2qQq+omih806JQgfPac5TqpbnNSNhJ08prJ8hOZcMb7EEO/cKlk6qIxJs/ZsAoxjw25fQdsjceuIH/LGr18dA4Rrbjml7vGoZwy/PCY0zNXwuY/79B+8936NTUAyS+aQpuXE5Z5+74ZUOMTF+zWTnNe8REdFols4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690915; c=relaxed/simple;
	bh=bzG5empnqjfqOndH97Rq0Q6/H40g6JtmHmBet6dPs6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3/F80CUGhZTPtQ/TK64RkdyHitDdDW/0WPpzYd3f29dfT2nbzV8npzXQRwOv7vcGargk3RodEvbdJCx9l2LOunXEFTPxI4upcrxAFIyEblHCR9LTMe3NQPB9DB487u8UnDo6sWkyrHl9RjMfeS4xsQhEz/3FOCjYwi5t7r/Ils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCCm3a5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE14C4CEE9;
	Tue, 11 Mar 2025 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741690914;
	bh=bzG5empnqjfqOndH97Rq0Q6/H40g6JtmHmBet6dPs6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCCm3a5z6BhW/8D+wIydNCz0NaGAwnMbzp7oUZdXh3zrUDL+L+a7oWQpu/V+JQP/u
	 Uj1omE//IQ1UOU5B8E5ke4Nhrgm8rp+ldrGXkmWJyh7r7jGCQjTAkk+Nu7buniBG57
	 WXolEagNXpQeRd6hOTumioP1rTMNxoTlbVrT9OXPZZ2BtSEVygoSr5uMFNEMGPc1lL
	 f5l75Rl4qcDsyaJLnu71a6BLiDQkzZO1WSzVLEhje6+i+zUvrWFt+F4WIZcAp+BMQp
	 Qxa04/zpkdVZde4udT3D/6iXbH+05BUk3fI+Bubeh41MjDff3iiFW6U5/mKcACQ56d
	 k9e7nCope6Few==
Date: Tue, 11 Mar 2025 12:01:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>, cve@kernel.org, 
	gnoack@google.com, gregkh@linuxfoundation.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, mic@digikod.net, Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250311-desillusionieren-goldfisch-0c2ce3194e68@brauner>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8_Q4nOR5X3iZq3j@dread.disaster.area>

On Tue, Mar 11, 2025 at 04:57:54PM +1100, Dave Chinner wrote:
> On Mon, Mar 10, 2025 at 10:19:57PM -0400, Demi Marie Obenour wrote:
> > People have stuff to get done.  If you disallow unprivileged filesystem
> > mounts, they will just use sudo (or equivalent) instead.
> 
> I am not advocating that we disallow mounting of untrusted devices.
> 
> > The problem is
> > not that users are mounting untrusted filesystems.  The problem is that
> > mounting untrusted filesystems is unsafe.
> 
> > Making untrusted filesystems safe to mount is the only solution that
> > lets users do what they actually need to do. That means either actually
> > fixing the filesystem code,
> 
> Yes, and the point I keep making is that we cannot provide that
> guarantee from the kernel for existing filesystems. We cannot detect
> all possible malicous tampering situations without cryptogrpahically
> secure verification, and we can't generate full trust from nothing.
> 
> The typical desktop policy of "probe and automount any device that
> is plugged in" prevents the user from examining the device to
> determine if it contains what it is supposed to contain.  The user
> is not given any opportunity to device if trust is warranted before
> the kernel filesystem parser running in ring 0 is exposed to the
> malicious image.
> 
> That's the fundamental policy problem we need to address: the user
> and/or admin is not in control of their own security because
> application developers and/or distro maintainers have decided they
> should not have a choice.
> 
> In this situation, the choice of what to do *must* fall to the user,
> but the argument for "filesystem corruption is a CVE-worthy bug" is
> that the choice has been taken away from the user. That's what I'm
> saying needs to change - the choice needs to be returned to the
> user...
> 
> > or running it in a sufficiently tight
> > sandbox that vulnerabilities in it are of too low importance to matter.
> > libguestfs+FUSE is the most obvious way to do this, but the performance
> > might not be enough for distros to turn it on.
> 
> Yes, I have advocated for that to be used for desktop mounts in the
> past. Similarly, I have also advocated for liblinux + FUSE to be
> used so that the kernel filesystem code is used but run from a
> userspace context where the kernel cannot be compromised.
> 
> I have also advocated for user removable devices to be encrypted by
> default. The act of the user unlocking the device automatically
> marks it as trusted because undetectable malicious tampering is
> highly unlikely.
> 
> I have also advocated for a device registry that records removable
> device signatures and whether the user trusted them or not so that
> they only need to be prompted once for any given removable device
> they use.
> 
> There are *many* potential user-friendly solutions to the problem,
> but they -all- lie in the domain of userspace applications and/or
> policies. This is *not* a problem more or better code in the kernel
> can solve.

Strongly agree.

> 
> Kees and Co keep telling us we should be making changes that make it
> harder (or compeltely prevent) entire classes of vulnerabilities
> from being exploited. Yet every time we suggest that a more secure
> policy should be applied to automounting filesystems to prevent
> system compromise on device hotplug, nobody seems to be willing to
> put security first.

I agree with Dave here a lot.

The case where arbitrary devices stuck into a laptop (e.g., USB sticks)
are mounted isn't solved by making a filesystem mountable unprivileged.
The mounted device cannot show up in the global mount namespace
somewhere since the user doesn't own the initial mount+user namespace.
So it's pointless. In other words, there's filesystem level checks and
mount namespace based checks. Circumventing that restriction means that
any user can just mount the device at any location in the global mount
namespace and therefore simply overmount other stuff.

The other thing is whether or not a filesystem is allowed to be mounted
by an unprivileged user namespaces. That is not a policy decision the
kernel can make, should make, or has to make. This is a road to security
disaster.

The new mount api has built-in
delegation capabilities for exactly this reason and use-case so the
kernel doesn't have to do that. Policy like that belongs into userspace. 
The new mount api makes it possible for userspace to correctly and
safely delegate any filesystem mount to unprivileged users. It's e.g.,
heavily used by bpf to make bpffs and thus bpf usable by unprivileged
userspace and containers.

There's a generic API for this already that we presented on in [1] at
LSFMM 2023. This has proper security policies in place when and how it
is allowed even for a user not in a user namespace to mount an arbitrary
filesystem (device or no device-based).

    NAME
    systemd-mountfsd.service, systemd-mountfsd - Disk Image File System Mount Service
    
    SYNOPSIS
    systemd-mountfsd.service
    
    /usr/lib/systemd/systemd-mountfsd
    
    DESCRIPTION
    systemd-mountfsd is a system service that dissects disk images, and
    returns mount file descriptors for the file systems contained therein to
    clients, via a Varlink IPC API.
    
    The disk images provided must contain a raw file system image or must
    follow the Discoverable Partitions Specification[1]. Before mounting any
    file systems authenticity of the disk image is established in one or a
    combination of the following ways:
    
    1. If the disk image is located in a regular file in one of the
       directories /var/lib/machines/, /var/lib/portables/,
       /var/lib/extensions/, /var/lib/confexts/ or their counterparts in the
       /etc/, /run/, /usr/lib/ it is assumed to be trusted.
    
    2. If the disk image contains a Verity enabled disk image, along with a
       signature partition with a key in the kernel keyring or in
       /etc/verity.d/ (and related directories) the disk image is considered
       trusted.

    This service provides one Varlink[2] service:
    io.systemd.MountFileSystem which accepts a file descriptor to a
    regular file or block device, and returns a number of file
    descriptors referring to an fsmount() file descriptor the client may
    then attach to a path of their choice.
    
    The returned mounts are automatically allowlisted in the
    per-user-namespace allowlist maintained by
    systemd-nsresourced.service(8).

    The file systems are automatically fsck(8)'ed before mounting.

    NOTES
    1. Discoverable Partitions Specification
       https://uapi-group.org/specifications/specs/discoverable_partitions_specification/

    2. Varlink
       https://varlink.org/

This work has now also been expanded to cover plain directory trees and
will be available in the next release.

It is currently part of systemd but like with a lot of other such tools
they are available standalone for non-systemd systems and if not that
can be done.

[1]: https://youtu.be/RbMhupT3Dk4?si=pIGH5XPPUJ0m6bi0


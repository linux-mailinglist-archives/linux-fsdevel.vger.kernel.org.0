Return-Path: <linux-fsdevel+bounces-9052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE5083D8E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 12:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 802E4B3DA37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F21B81A;
	Fri, 26 Jan 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgENvXO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A951B7E4;
	Fri, 26 Jan 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263666; cv=none; b=mN07cD1UTsAbXluCkb3OcEroAzNKhN8qqk3SG3MjdYWANI6vx3YAg5V53FXC7PTDTgWJTpV8aEDsRgpHfAB4LCQ84jSsGe1KwTijyFANkh9emIo/08PGXjAxajiiLNvUZBv5s8cap2ZcoWl4eNJxuaKH1wKtwtEKEW+FVHvPFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263666; c=relaxed/simple;
	bh=cyYc4oQhxrcpBf/N4DGlh5NOYSWJmxszPTa3U/wWji8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqFcmhOqCtkCzjlJgxL7B3WMy1+R/p0wklsI4P9BIhnF3RP3B79o8rGFArJ/RVQGRkXyV92W3d4Z5k0mW/DKigcboYgjf++C3TVb88SZvFYgIGw8fGAPu2sjRz6/NTlo7M9C3CjffFv6vEcD/JcZUK4C/xaCHJgn+S2vWanUXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgENvXO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43945C433C7;
	Fri, 26 Jan 2024 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706263666;
	bh=cyYc4oQhxrcpBf/N4DGlh5NOYSWJmxszPTa3U/wWji8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgENvXO9hI7spLW3wf1MzB2Q6oM4DtwvHG6wIOFrdFl4kpUuX6k6zL0H8taBiBYQL
	 Jn3WN12lVFujvNdirTFsDuBoDDc9KrdUhKiH5ZVm2I5jEvgmTjqUE+r0wFNPyzoKG4
	 +zGiY258mpFxvAJ2YneWv5SF70ZksYPUKftNdiRL12cjyZNvf9GYGDmxKCQ81A/zMv
	 h74k2ZxqXVICdueT2n8sDC4t6+z1c2VEjvdnoCif6mlshsG8dYB+yOI+uIh3Cba9vk
	 14afPTHMAOgQp0YOYmjxnsf6nir+LQSBnNBV7CYJk2bAJCJh++4WfUK9POqEHkZtaJ
	 uCheOlKVICS6w==
Date: Fri, 26 Jan 2024 11:07:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, linux-api@vger.kernel.org, edumazet@google.com, 
	davem@davemloft.net, alexander.duyck@gmail.com, sridhar.samudrala@intel.com, 
	kuba@kernel.org, willemdebruijn.kernel@gmail.com, weiwan@google.com, 
	Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Steve French <stfrench@microsoft.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jiri Slaby <jirislaby@kernel.org>, 
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Waterman <waterman@eecs.berkeley.edu>, Thomas Huth <thuth@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240126-kribbeln-sonnabend-35dcb3d1fc48@brauner>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012551-anyone-demeaning-867b@gregkh>
 <20240126001128.GC1987@fastly.com>
 <2024012525-outdoors-district-2660@gregkh>
 <20240126023630.GA1235@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240126023630.GA1235@fastly.com>

On Thu, Jan 25, 2024 at 06:36:30PM -0800, Joe Damato wrote:
> On Thu, Jan 25, 2024 at 04:23:58PM -0800, Greg Kroah-Hartman wrote:
> > On Thu, Jan 25, 2024 at 04:11:28PM -0800, Joe Damato wrote:
> > > On Thu, Jan 25, 2024 at 03:21:46PM -0800, Greg Kroah-Hartman wrote:
> > > > On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> > > > > +struct epoll_params {
> > > > > +	u64 busy_poll_usecs;
> > > > > +	u16 busy_poll_budget;
> > > > > +
> > > > > +	/* for future fields */
> > > > > +	u8 data[118];
> > > > > +} EPOLL_PACKED;
> > > > 
> > > > variables that cross the user/kernel boundry need to be __u64, __u16,
> > > > and __u8 here.
> > > 
> > > I'll make that change for the next version, thank you.
> > > 
> > > > And why 118?
> > > 
> > > I chose this arbitrarily. I figured that a 128 byte struct would support 16
> > > u64s in the event that other fields needed to be added in the future. 118
> > > is what was left after the existing fields. There's almost certainly a
> > > better way to do this - or perhaps it is unnecessary as per your other
> > > message.
> > > 
> > > I am not sure if leaving extra space in the struct is a recommended
> > > practice for ioctls or not - I thought I noticed some code that did and
> > > some that didn't in the kernel so I err'd on the side of leaving the space
> > > and probably did it in the worst way possible.
> > 
> > It's not really a good idea unless you know exactly what you are going
> > to do with it.  Why not just have a new ioctl if you need new
> > information in the future?  That's simpler, right?
> 
> Sure, that makes sense to me. I'll remove it in the v4 alongside the other
> changes you've requested.

Fwiw, we do support extensible ioctls since they encode the size. Take a
look at kernel/seccomp.c. It's a clean extensible interface built on top
of the copy_struct_from_user() pattern we added for system calls
(openat(), clone3() etc.):

static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
                                 unsigned long arg)
{
        struct seccomp_filter *filter = file->private_data;
        void __user *buf = (void __user *)arg;

        /* Fixed-size ioctls */
        switch (cmd) {
        case SECCOMP_IOCTL_NOTIF_RECV:
                return seccomp_notify_recv(filter, buf);
        case SECCOMP_IOCTL_NOTIF_SEND:
                return seccomp_notify_send(filter, buf);
        case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
        case SECCOMP_IOCTL_NOTIF_ID_VALID:
                return seccomp_notify_id_valid(filter, buf);
        case SECCOMP_IOCTL_NOTIF_SET_FLAGS:
                return seccomp_notify_set_flags(filter, arg);
        }

        /* Extensible Argument ioctls */
#define EA_IOCTL(cmd)   ((cmd) & ~(IOC_INOUT | IOCSIZE_MASK))
        switch (EA_IOCTL(cmd)) {
        case EA_IOCTL(SECCOMP_IOCTL_NOTIF_ADDFD):
                return seccomp_notify_addfd(filter, buf, _IOC_SIZE(cmd));
        default:
                return -EINVAL;
        }
}

static long seccomp_notify_addfd(struct seccomp_filter *filter,
                                 struct seccomp_notif_addfd __user *uaddfd,
                                 unsigned int size)
{
        struct seccomp_notif_addfd addfd;
        struct seccomp_knotif *knotif;
        struct seccomp_kaddfd kaddfd;
        int ret;

        BUILD_BUG_ON(sizeof(addfd) < SECCOMP_NOTIFY_ADDFD_SIZE_VER0);
        BUILD_BUG_ON(sizeof(addfd) != SECCOMP_NOTIFY_ADDFD_SIZE_LATEST);

        if (size < SECCOMP_NOTIFY_ADDFD_SIZE_VER0 || size >= PAGE_SIZE)
                return -EINVAL;

        ret = copy_struct_from_user(&addfd, sizeof(addfd), uaddfd, size);
        if (ret)
                return ret;






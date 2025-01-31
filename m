Return-Path: <linux-fsdevel+bounces-40488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FA1A23D93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 13:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2301885341
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4C1C3BE8;
	Fri, 31 Jan 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+AS/ENT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0116D9AF;
	Fri, 31 Jan 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738325396; cv=none; b=t9YLMs75T6uc87ezmE/4nCKjv8Rmiu0f9wI/mfnGPJZ96aHJBKcUbXUdGmKxoDKG9CIrP68WpKrPM6qCR5LWDxWz7gqane7w7hZJJaIcIcu39MFFdA/1fPAzKdn2fUXAGYEMUkTMsLC4nOZKdw+azXcYhspZdg8M0pMdmxjiboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738325396; c=relaxed/simple;
	bh=NHIMuTDFaok03VlygL73Ms/kEtSGi5tobu+txIeUvQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LogonlF6KNfi6ZTE1mX/qHh/rcq7E+VTnj37NG87vdZ/3C9RlqXi6siYVwfqV9TOCB6PIUjMp2hVll5cKLKQEGux9WwakOpYwTgimQ67xnUW1DIrSu2bgJA/Xg1Nk9ahz0XOOqY3DJq/huGyMvGatZYi2Z52CExAscjNod3BWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+AS/ENT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A5C4CEE2;
	Fri, 31 Jan 2025 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738325396;
	bh=NHIMuTDFaok03VlygL73Ms/kEtSGi5tobu+txIeUvQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+AS/ENTrHNePoKN0c2zZ0Wh1uhLEvRT8OYeGbh9M3NprNBKNkUUhvvpL5sjJ1ob3
	 gMaWim/54adhB6r+oRDcs7qgu3KdNFznql6TegDAor8W3ukph9T+5uQ8Ic6XKSCYhT
	 N/DD03q2zQ7qXOQBYZllvAkVwNADAa04qmdfmbJu5i6vR5wt4lvMWtXvOniixVq2bK
	 mKD0/DJSQq6g1jAYmj4k5F1FFdW/ezGsz7/M+r9eZYFhdNjvwlte4TWG2QmTdcDw/a
	 yrhqWZkgCoidtfIY4MfNuQqxXJ3jBlpg8Rxfy0yR8/cL6G8cyXIzpGqJBGP6HjjbTB
	 r5DpYXANjd4cQ==
Date: Fri, 31 Jan 2025 13:09:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
Message-ID: <20250131-durften-weitblick-075d05e8f616@brauner>
References: <20250129165803.72138-1-mszeredi@redhat.com>
 <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>

On Thu, Jan 30, 2025 at 04:05:53PM -0500, Paul Moore wrote:
> On Wed, Jan 29, 2025 at 11:58 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > Add notifications for attaching and detaching mounts.  The following new
> > event masks are added:
> >
> >   FAN_MNT_ATTACH  - Mount was attached
> >   FAN_MNT_DETACH  - Mount was detached
> >
> > If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> > FAN_MNT_DETACH).
> >
> > These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
> > these fields identifying the affected mounts:
> >
> >   __u64 mnt_id    - the ID of the mount (see statmount(2))
> >
> > FAN_REPORT_MNT must be supplied to fanotify_init() to receive these events
> > and no other type of event can be received with this report type.
> >
> > Marks are added with FAN_MARK_MNTNS, which records the mount namespace from
> > an nsfs file (e.g. /proc/self/ns/mnt).
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/mount.h                         |  2 +
> >  fs/namespace.c                     | 14 +++--
> >  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
> >  fs/notify/fanotify/fanotify.h      | 18 +++++++
> >  fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
> >  fs/notify/fdinfo.c                 |  5 ++
> >  include/linux/fanotify.h           | 12 +++--
> >  include/uapi/linux/fanotify.h      | 10 ++++
> >  security/selinux/hooks.c           |  4 ++
> >  9 files changed, 167 insertions(+), 23 deletions(-)
> 
> ...
> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7b867dfec88b..06d073eab53c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *path, u64 mask,
> >         case FSNOTIFY_OBJ_TYPE_INODE:
> >                 perm = FILE__WATCH;
> >                 break;
> > +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> > +               /* Maybe introduce FILE__WATCH_MOUNTNS? */
> > +               perm = FILE__WATCH_MOUNT;
> > +               break;
> >         default:
> >                 return -EINVAL;
> >         }
> 
> Ignoring for a moment that this patch was merged without an explicit
> ACK for the SELinux changes, let's talk about these SELinux changes
> ...
> 
> I understand that you went with the "simpler version" because you
> didn't believe the discussion was converging, which is fair, however,
> I believe Daniel's argument is convincing enough to warrant the new
> permission.  Yes, it has taken me approximately two days to find the
> time to revisit this topic and reply with some clarity, but personally
> I feel like that is not an unreasonable period of time, especially for
> a new feature discussion occurring during the merge window.
> 
> If you need an example on how to add a new SELinux permission, you can
> look at commit ed5d44d42c95 ("selinux: Implement userns_create hook")
> for a fairly simple example.  In the watch_mountns case things are
> slightly different due to the existence of the COMMON_FILE_PERMS
> macro, but you basically want to add "watch_mountns" to the end of the
> COMMON_FILE_PERMS macro in security/selinux/include/classmap.h.  Of
> course if you aren't sure about something, let me know.  As a FYI, my
> network access will be spotty starting tonight and extending through
> the weekend, but I will have network/mail access at least once a day.
> 
> Now back to the merge into the VFS tree ... I was very surprised to
> open this patchset and see that Christian had merged v5 after less
> than 24 hours (at least according to the email timestamps that I see)
> and without an explicit ACK for the SELinux changes.  I've mentioned
> this to you before Christian, please do not merge any SELinux, LSM
> framework, or audit related patches without an explicit ACK.  I

Things go into the tree for testing when the VFS side is ready for
testing. We're at v5 and the patchset has gone through four iterations
over multiple months. It will go into linux-next and fs-next now for as
much expsure as possible.

I'm not sure what the confusion between merging things into a tree and
sending things upstream is. I have explained this to you before. The
application message is also pretty clear about that.

> recognize that sometimes there are highly critical security issues
> that need immediate attention, but that is clearly not the case here,
> and there are other procedures to help deal with those emergency
> scenarios.
> 
> -- 
> paul-moore.com


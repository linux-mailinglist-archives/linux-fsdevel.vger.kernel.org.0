Return-Path: <linux-fsdevel+bounces-40709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B40A26F32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE101629B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CE20A5CA;
	Tue,  4 Feb 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/yH3coF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D5204F63;
	Tue,  4 Feb 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664379; cv=none; b=O6x6oHyBF2vn0hbKHxcvy/wLA+Cdk52vKvf5nneHg4w7fjWN8WDYNVve6siFninNMneyOFwodNGh0ff1UpKGmFFdsz68xKwX5egfpZAxbKANwMe0Ivuqzpq1LJPLS4wTw+jhoGBPFV7kfvMPyyriYSI/rABV0bSTceKuUbGhE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664379; c=relaxed/simple;
	bh=IcLyDp+AE/73I2O8HDqueGfkOguuz+XwBxXf2C11ZC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWAITVLs29NKepOBJqB7COxSKEB+fATwWAJ/F1RkaZz/TT0ZWlvmRXAF15WWjW0zzRbw+8iwKeA6YwfMXglfMhIOzbXe3OC+rvHoKG3cwz6sYUT5aF5+PCsF8/M0Jhkv23WgtIoAAckgHX/8lM86DfdSytcKds9vzP2CZiVKfLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/yH3coF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A7BC4CEDF;
	Tue,  4 Feb 2025 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738664379;
	bh=IcLyDp+AE/73I2O8HDqueGfkOguuz+XwBxXf2C11ZC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/yH3coFHATf5cM6si0OtMcBtV3YDQaoQTTW1aATvGYhoyaZDDsw09qpEbdBuVg7N
	 KoM+XFamiB3WPViCEAl+Q2+enQGR/s4qBSK4wvakeqwQCpx+vbXub/ow+H/MtSuuLT
	 zye1mX4len1PO8DLVpIhjl030EfuqHDTTfytz8zbD6R1cgOS+jprkRML7VyvbXe/H0
	 /TnbCB3PY4ixeZOci7eckY7MOZocmK9HbsBflP5imK8q+vplCsnEUnSr87A/uC/f48
	 L0JUC8Pbr58xfuF8ZGAwcvUesov7Kb3tw4Y4n2g/q0OLRgzEDhdoct4E0kwW1Ijz5m
	 5kHYuCcIt36iA==
Date: Tue, 4 Feb 2025 11:19:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
Message-ID: <20250204-empfahl-feinmechaniker-fbfdee97f4bd@brauner>
References: <20250129165803.72138-1-mszeredi@redhat.com>
 <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
 <CAJfpegu3N9T4cTQ5z+a_nsTpK1KFNDL-NduhMp15stB3O31=+Q@mail.gmail.com>
 <CAHC9VhR+zEms9XQk1HWNWG9cF9606g5KP83pbRQa4XesyORaBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR+zEms9XQk1HWNWG9cF9606g5KP83pbRQa4XesyORaBA@mail.gmail.com>

On Fri, Jan 31, 2025 at 09:28:31AM -0500, Paul Moore wrote:
> On Fri, Jan 31, 2025 at 5:53 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > On Thu, 30 Jan 2025 at 22:06, Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Jan 29, 2025 at 11:58 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > > >
> > > > Add notifications for attaching and detaching mounts.  The following new
> > > > event masks are added:
> > > >
> > > >   FAN_MNT_ATTACH  - Mount was attached
> > > >   FAN_MNT_DETACH  - Mount was detached
> > > >
> > > > If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> > > > FAN_MNT_DETACH).
> > > >
> > > > These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
> > > > these fields identifying the affected mounts:
> > > >
> > > >   __u64 mnt_id    - the ID of the mount (see statmount(2))
> > > >
> > > > FAN_REPORT_MNT must be supplied to fanotify_init() to receive these events
> > > > and no other type of event can be received with this report type.
> > > >
> > > > Marks are added with FAN_MARK_MNTNS, which records the mount namespace from
> > > > an nsfs file (e.g. /proc/self/ns/mnt).
> > > >
> > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > ---
> > > >  fs/mount.h                         |  2 +
> > > >  fs/namespace.c                     | 14 +++--
> > > >  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
> > > >  fs/notify/fanotify/fanotify.h      | 18 +++++++
> > > >  fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
> > > >  fs/notify/fdinfo.c                 |  5 ++
> > > >  include/linux/fanotify.h           | 12 +++--
> > > >  include/uapi/linux/fanotify.h      | 10 ++++
> > > >  security/selinux/hooks.c           |  4 ++
> > > >  9 files changed, 167 insertions(+), 23 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 7b867dfec88b..06d073eab53c 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *path, u64 mask,
> > > >         case FSNOTIFY_OBJ_TYPE_INODE:
> > > >                 perm = FILE__WATCH;
> > > >                 break;
> > > > +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> > > > +               /* Maybe introduce FILE__WATCH_MOUNTNS? */
> > > > +               perm = FILE__WATCH_MOUNT;
> > > > +               break;
> > > >         default:
> > > >                 return -EINVAL;
> > > >         }
> > >
> > > Ignoring for a moment that this patch was merged without an explicit
> > > ACK for the SELinux changes, let's talk about these SELinux changes
> > > ...
> > >
> > > I understand that you went with the "simpler version" because you
> > > didn't believe the discussion was converging, which is fair, however,
> > > I believe Daniel's argument is convincing enough to warrant the new
> > > permission.
> >
> > Fine, I'll work on this.
> 
> Great, thanks.
> 
> > >  Yes, it has taken me approximately two days to find the
> > > time to revisit this topic and reply with some clarity, but personally
> > > I feel like that is not an unreasonable period of time, especially for
> > > a new feature discussion occurring during the merge window.
> >
> > Definitely not.
> >
> > Christian is definitely very responsive and quick to queue things up,
> > and that can have drawbacks.   In this he made it clear that he wants
> > to get this queued ASAP regardless of whether there's decision on the
> > SELinux side or not.
> 
> When one merges code that affects another subsystem without an
> explicit ACK from the affected subsystem when the maintainer has asked
> for others to clear the code change with an ACK, it's hard to see that
> as anything but bad behavior at its best and reckless behavior at its
> worst.  It is doubly troubling in cases like this where the code
> change is user visible.
> 
> > What I think might be a good thing if Christian could record
> > conditional NAKs such as this one from you, that need to be worked on
> > before sending a feature upstream.  That would prevent wrong code
> > being sent upstream due to lack of attention.
> 
> Christian's merge notification email already has this section:
> 
>   "Please report any outstanding bugs that were missed
>    during review in a new review to the original patch series
>    allowing us to drop it."
> 
> ... and to be fair, the vfs-6.15.mount branch mentioned in the
> notification does appear to be gone.

The branch is very much alive but it has never been public for very
obvious reasons: new patches don't appear in -next or elsewhere until
the merge window is closed. They will be pushed out today.


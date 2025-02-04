Return-Path: <linux-fsdevel+bounces-40710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621FAA26F39
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3617D1887321
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9520A5CE;
	Tue,  4 Feb 2025 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM2S9WwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3BF204F63;
	Tue,  4 Feb 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664412; cv=none; b=bRyngqKDyooRGU711IDHDftN6uOpf6kx4z9hUEA7p9RAlnl4PE47LEpgOzEBQ0EfhL5ZgVQJlB6/MQ3tteo1/XN34v/s0ztB0HfMNT0G7lBONd+WXifcfh5tG/xXhUiIQk2Llheq9hxmsYWdnpWR7kPj/0modsqPnCoibZsWYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664412; c=relaxed/simple;
	bh=VjQassB4T8LQl//yOHp4/n1ZcvdTierRxVrdKB8XR9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNMBrh5yxdotrQ06ulYhqlDs3d2qGKDwMtnr8GvYe7K1yIsZ5EOsRa8fqbpYDoQsQwDk+XM6nthF1JuQGBBXFfZPZSmWXH7Ilp1IaJBeXTig/agCL3bpeORjJleiUvWaMiWfP6MLP4tNaJO4Jd+lsPDQ7xssAia4UqZtSZh/2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM2S9WwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B888C4CEDF;
	Tue,  4 Feb 2025 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738664411;
	bh=VjQassB4T8LQl//yOHp4/n1ZcvdTierRxVrdKB8XR9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bM2S9WwX2KxRXY+LvMb71Zw0K1x7EAzbi0gs4y1j77iyfDHjmb35HcRCHiWk9RPUM
	 f1E8oRGuh80YiT0P+InUYqK5K+aHrWgu6Hr6djKED3Boc8BUBua5FcRIeRP6sK/qBD
	 CqjM828NnOCmmqKt7SYG6WPMorWwOq1VApXoTHV6sR1WD3oTG4Va3BgNlDF2BLqo5L
	 WdB07N5FEFNktWXAvFSsEVBsBAsGNnBO5JkltpdSKWNql56b8ly+8la3mQe2DQPJEK
	 q2R50AxeNswNtapIsYgg3+nVyka5Gp4H9TCo4JYqUTvZpnjwp8q9SQFqMiy4UMeVei
	 dE9BEoHWQzwuQ==
Date: Tue, 4 Feb 2025 11:20:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Paul Moore <paul@paul-moore.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Karel Zak <kzak@redhat.com>, Lennart Poettering <lennart@poettering.net>, 
	Ian Kent <raven@themaw.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux-refpolicy@vger.kernel.org
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
Message-ID: <20250204-plauschen-tanzmusik-7685bed055db@brauner>
References: <20250129165803.72138-1-mszeredi@redhat.com>
 <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
 <CAJfpegu3N9T4cTQ5z+a_nsTpK1KFNDL-NduhMp15stB3O31=+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegu3N9T4cTQ5z+a_nsTpK1KFNDL-NduhMp15stB3O31=+Q@mail.gmail.com>

On Fri, Jan 31, 2025 at 11:53:33AM +0100, Miklos Szeredi wrote:
> On Thu, 30 Jan 2025 at 22:06, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Jan 29, 2025 at 11:58 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > >
> > > Add notifications for attaching and detaching mounts.  The following new
> > > event masks are added:
> > >
> > >   FAN_MNT_ATTACH  - Mount was attached
> > >   FAN_MNT_DETACH  - Mount was detached
> > >
> > > If a mount is moved, then the event is reported with (FAN_MNT_ATTACH |
> > > FAN_MNT_DETACH).
> > >
> > > These events add an info record of type FAN_EVENT_INFO_TYPE_MNT containing
> > > these fields identifying the affected mounts:
> > >
> > >   __u64 mnt_id    - the ID of the mount (see statmount(2))
> > >
> > > FAN_REPORT_MNT must be supplied to fanotify_init() to receive these events
> > > and no other type of event can be received with this report type.
> > >
> > > Marks are added with FAN_MARK_MNTNS, which records the mount namespace from
> > > an nsfs file (e.g. /proc/self/ns/mnt).
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  fs/mount.h                         |  2 +
> > >  fs/namespace.c                     | 14 +++--
> > >  fs/notify/fanotify/fanotify.c      | 38 +++++++++++--
> > >  fs/notify/fanotify/fanotify.h      | 18 +++++++
> > >  fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++++-----
> > >  fs/notify/fdinfo.c                 |  5 ++
> > >  include/linux/fanotify.h           | 12 +++--
> > >  include/uapi/linux/fanotify.h      | 10 ++++
> > >  security/selinux/hooks.c           |  4 ++
> > >  9 files changed, 167 insertions(+), 23 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 7b867dfec88b..06d073eab53c 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3395,6 +3395,10 @@ static int selinux_path_notify(const struct path *path, u64 mask,
> > >         case FSNOTIFY_OBJ_TYPE_INODE:
> > >                 perm = FILE__WATCH;
> > >                 break;
> > > +       case FSNOTIFY_OBJ_TYPE_MNTNS:
> > > +               /* Maybe introduce FILE__WATCH_MOUNTNS? */
> > > +               perm = FILE__WATCH_MOUNT;
> > > +               break;
> > >         default:
> > >                 return -EINVAL;
> > >         }
> >
> > Ignoring for a moment that this patch was merged without an explicit
> > ACK for the SELinux changes, let's talk about these SELinux changes
> > ...
> >
> > I understand that you went with the "simpler version" because you
> > didn't believe the discussion was converging, which is fair, however,
> > I believe Daniel's argument is convincing enough to warrant the new
> > permission.
> 
> Fine, I'll work on this.

Make it separate patches please. All LSM changes have been dropped.


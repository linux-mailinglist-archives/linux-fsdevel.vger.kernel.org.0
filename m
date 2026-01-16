Return-Path: <linux-fsdevel+bounces-74086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F33D2F2E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD8830A27C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2F35EDA5;
	Fri, 16 Jan 2026 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDd9q/Jw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC635CBBB;
	Fri, 16 Jan 2026 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557614; cv=none; b=CRQ8DBL0d2+Ju3OzvmXH4yZMsX7eMboiyalVisnR/Tjj1feEf6xlUWO4TPSv9T7cFZeBrv7GzVctcylje+PVXl3OP6ZLcm2ZgGZpb6s+ToAdAxrLBksp3o6ue4zcJHdOD2NWW3xAwYAcyTS0j6dkayvc3WYGcYvNf0I1pqQH2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557614; c=relaxed/simple;
	bh=OaDtriPw9VUx3n9q2IWPWNIKUmT10tEg4crDmh7+HT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os4/UPIV3lM9UuzStP6yXPegjIO4llLoqaesq4ip/26r1h2zdG9iYWGJjPyjt+XdbKz0ecRI+ibr4XtLDX4xd2kiNASkUcQVP10mH8JDoUJItjoOlExxkE7tQ3sA2ur/PZQvPMe3qbucua7teZ6MKjUHuPf5H5Y3XRV/QNimDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDd9q/Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDDFC116C6;
	Fri, 16 Jan 2026 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768557613;
	bh=OaDtriPw9VUx3n9q2IWPWNIKUmT10tEg4crDmh7+HT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDd9q/Jw1kV+27ojfYwBuQ4wI032/Usnkhm9WHWLJ0qgCLtF0RRYM9BQbEZI7/cQ/
	 jZBprlfJmQ9ogHA696MYJa3i3EXBdldLrP6QyoA6fs5UzbdviMim6xGyOHUC0pgTTi
	 /KpYVN06sHY0eVOHNiT5AE2mE/1P2HfC9N1zkC4wXO8vH1okkXUQyYQ6wif6H7sGKO
	 /ogBkblst6rlMJI8FuP3US69Iz8nhf8wnqNPAq/3mWoL+1YqIy4ky6P+ptFNTHZUQn
	 J/x+4UGHIrX4bq5xRe860vBI6i1iwfH68ZI8M6xr+hrxrzWYI84Qq2e6NaEfFBg0eP
	 5KZzH+b6tEZ9A==
Date: Fri, 16 Jan 2026 11:00:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, DJ Delorie <dj@redhat.com>
Subject: Re: O_CLOEXEC use for OPEN_TREE_CLOEXEC
Message-ID: <20260116-alias-ausnimmt-4788c83a66d2@brauner>
References: <lhupl7dcf0o.fsf@oldenburg.str.redhat.com>
 <20260114-alias-riefen-2cb8c09d0ded@brauner>
 <lhuwm1ji7bl.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhuwm1ji7bl.fsf@oldenburg.str.redhat.com>

On Thu, Jan 15, 2026 at 09:55:10AM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > On Tue, Jan 13, 2026 at 11:40:55PM +0100, Florian Weimer wrote:
> >> In <linux/mount.h>, we have this:
> >> 
> >> #define OPEN_TREE_CLOEXEC      O_CLOEXEC       /* Close the file on execve() */
> >> 
> >> This causes a few pain points for us to on the glibc side when we mirror
> >> this into <linux/mount.h> becuse O_CLOEXEC is defined in <fcntl.h>,
> >> which is one of the headers that's completely incompatible with the UAPI
> >> headers.
> >> 
> >> The reason why this is painful is because O_CLOEXEC has at least three
> >> different values across architectures: 0x80000, 0x200000, 0x400000
> >> 
> >> Even for the UAPI this isn't ideal because it effectively burns three
> >> open_tree flags, unless the flags are made architecture-specific, too.
> >
> > I think that just got cargo-culted... A long time ago some API define as
> > O_CLOEXEC and now a lot of APIs have done the same.
> 
> Yes, it looks like inotify is in the same boat.

It's unfortunately nost just inotify...:

include/linux/net.h:#define SOCK_CLOEXEC        O_CLOEXEC
include/uapi/drm/drm.h:#define DRM_CLOEXEC O_CLOEXEC
include/uapi/linux/eventfd.h:#define EFD_CLOEXEC O_CLOEXEC
include/uapi/linux/eventpoll.h:#define EPOLL_CLOEXEC O_CLOEXEC
include/uapi/linux/inotify.h:#define IN_CLOEXEC O_CLOEXEC
include/uapi/linux/signalfd.h:#define SFD_CLOEXEC O_CLOEXEC
include/uapi/linux/timerfd.h:#define TFD_CLOEXEC O_CLOEXEC

> 
> > I'm pretty sure we can't change that now but we can document that this
> > shouldn't be ifdefed and instead be a separate per-syscall bit. But I
> > think that's the best we can do right now.
> 
> Maybe add something like this as a safety measure, to ensure that the
> flags don't overlap?
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c58674a20cad..5bbfd379ec44 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3069,6 +3069,9 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
>  	bool detached = flags & OPEN_TREE_CLONE;
>  
>  	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
> +	BUILD_BUG_IN(!(O_CLOEXEC & OPEN_TREE_CLONE));
> +	BUILD_BUG_ON(!((AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE | AT_SYMLINK_NOFOLLOW) &
> +		       (O_CLOEXEC | OPEN_TREE_CLONE)));

Yeah, we can do something like that!


Return-Path: <linux-fsdevel+bounces-43178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7D4A4EF78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 22:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE46188F9B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810222780F1;
	Tue,  4 Mar 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="psA5Kbnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4F24C06A
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124423; cv=none; b=WLB3y3wLGOery8kJNOvWNBBaMoRO6u+RyX+SxsLsR8ivU4CPZOsPwrb2fo0HDj6d1j8JlKjZo4A6ptnKwZrYT/eHgSG/wmvAD6/Ooatg1IaFNQFwANlXlqNVXFF3zwSGLhWai3t1fy1u9AM3pcEFvxRl6pK2jG3DyDdYYVs3Jn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124423; c=relaxed/simple;
	bh=e/odl25+FmO4wZ1m7JOGgQ5yB3tjL3v7z7nZqEkir+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E75tJS6KnD0g/O0O9WN6iKiCGhpBHNnzGdGBbYIgmPN52lfcYpc/OTK3qa6B/kheYxFOGm5ybQbWw755dICCX8PadGjoYL71b8akZmwxiOB9qcyIhkhEkaDU/mW8Zau4Uos/VaQ8YKhho98HBHl5jdFpp5wcwYHVxBb90+9w8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=psA5Kbnp; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Z6mWX6khqz60f;
	Tue,  4 Mar 2025 20:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741117848;
	bh=Gf0MHTMuVe1xP1cNubyAUhVNwqGpdqkMve5JpC+CLcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psA5Kbnp/Lwg8L/AkqEWigBYnZbNfkE8T26gQYNUGwzw9b3AIjjVImZBITp5zfzyl
	 neESjZQ4mrsvPHnKvnyOGJXPgkChBlPkZ/yWCSloHx/9MGtot8ctVBouX/kC2HeCY4
	 40bwiB53uyUihJ6tTdT18jswww4Smlwx2+Pif4kI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Z6mWX2VJmz67d;
	Tue,  4 Mar 2025 20:50:48 +0100 (CET)
Date: Tue, 4 Mar 2025 20:50:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC PATCH 6/9] Creating supervisor events for filesystem
 operations
Message-ID: <20250304.oowung0eiPee@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <ed5904af2bdab297f4137a43e44363721894f42f.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed5904af2bdab297f4137a43e44363721894f42f.1741047969.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Mar 04, 2025 at 01:13:02AM +0000, Tingmao Wang wrote:
> NOTE from future me: This implementation which waits for user response
> while blocking inside the current security_path_* hooks is problematic due
> to taking exclusive inode lock on the parent directory, and while I have a
> proposal for a solution, outlined below, I haven't managed to include the
> code for that in this version of the patch. Thus for this commit in
> particular I'm probably more looking for suggestions on the approach
> rather than code review.  Please see the TODO section at the end of this
> message before reviewing this patch.

This is good for an RFC.

> 
> ----
> 
> This patch implements a proof-of-concept for modifying the current
> landlock LSM hooks to send supervisor events and wait for responses, when
> a supervised layer is involved.
> 
> In this design, access requests which would end up being denied by other
> non-supervised landlock layers (or which would fail the normal inode
> permission check anyways - but this is currently TODO, I only thought of
> this afterwards) are denied straight away to avoid pointless supervisor
> notifications.

Yes, only denied access should be forwarded to the supervisor.  In
another patch series we could enable the supervisor to update its layer
with new rules as well.

The audit patch series should help to properly identify which layer
denied a request, and to only use the related supervisor.

> 
> Currently current_check_access_path only gets the path of the parent
> directory for create/remove operations, which is not enough for what we
> want to pass to the supervisor.  Therefore we extend it by passing in any
> relevant child dentry (but see TODO below - this may not be possible with
> the proper implementation).

Hmm, I'm not sure this kind of information is required (this is not
implemented for the audit support).  The supervisor should be fine
getting only which access is missing, right?

> 
> This initial implementation doesn't handle links and renames, and for now
> these operations behave as if no supervisor is present (and thus will be
> denied, unless it is allowed by the layer rules).  Also note that we can
> get spurious create requests if the program tries to O_CREAT open an
> existing file that exists but not in the dcache (from my understanding).
> 
> Event IDs (referred to as an opaque cookie in the uapi) are currently
> generated with a simple `next_event_id++`.  I considered using e.g. xarray
> but decided to not for this PoC. Suggestions welcome. (Note that we have
> to design our own event id even if we use an extension of fanotify, as
> fanotify uses a file descriptor to identify events, which is not generic
> enough for us)

That's another noticable difference with fanotify.  You can add it to
the next cover letter.

> 
> ----
> 
> TODO:
> 
> When testing this I realized that doing it this way means that for the
> create/delete case, we end up holding an exclusive inode lock on the
> parent directory while waiting for supervisor to respond (see namei.c -
> security_path_mknod is called in may_o_create <- lookup_open which has an
> exclusive lock if O_CREAT is passed), which will prevent all other tasks
> from accessing that directory (regardless of whether or not they are under
> landlock).

Could we use a landlock_object to identify this inode instead?

> 
> This is clearly unacceptable, but since landlock (and also this extension)
> doesn't actually need a dentry for the child (which is allocated after the
> inode lock), I think this is not unsolvable.  I'm experimenting with
> creating a new LSM hook, something like security_pathname_mknod
> (suggestions welcome), which will be called after we looked up the dentry
> for the parent (to prevent racing symlinks TOCTOU), but before we take the
> lock for it.  Such a hook can still take as argument the parent dentry,
> plus name of the child (instead of a struct path for it).
> 
> Suggestions for alternative approaches are definitely welcome!
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  security/landlock/fs.c        | 134 ++++++++++++++++++++++++++++++++--
>  security/landlock/supervise.c | 122 +++++++++++++++++++++++++++++++
>  security/landlock/supervise.h | 106 ++++++++++++++++++++++++++-
>  3 files changed, 354 insertions(+), 8 deletions(-)
> 

[...]


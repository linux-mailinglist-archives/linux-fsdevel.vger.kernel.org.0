Return-Path: <linux-fsdevel+bounces-43882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60EA5EE76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C35189FFA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9F8263F45;
	Thu, 13 Mar 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmO3jUKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E4262D16;
	Thu, 13 Mar 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855843; cv=none; b=fzTKEv3KsfIGOCWiV+VtRwFgfVO8I8b8gsmtpPashAyzLp28x2/9ELplkhIP9MuY4H6squzA9KpWtp7FTtTB2JeFm1Go7jfMXlRV1QqjOqupJbi85xeb2A8fq57hvViOM0PV8EJRkOLYXjZEQie4bQtGnJ4TysLBObFVV8t37hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855843; c=relaxed/simple;
	bh=AaLGvCMflk/8nmpvfygkfLg+3xhOY9lgQwRoQdX2ybU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li1OuxCkhrTdRwUfvoc4WQPxO7S7Noo/VKDiB/giMVPcBdndE5L6u2anqGYQX1YjcI3/ceYOvThdVpJZgL2Usc603UQLMzuxJgqM2u3BNWIOJvC7liJ7uaTsq2dtf8f9+fHySY/I030wQS2lszMhHvZsbxdPwsj57GqXwA9Wt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmO3jUKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB19C4CEEB;
	Thu, 13 Mar 2025 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741855843;
	bh=AaLGvCMflk/8nmpvfygkfLg+3xhOY9lgQwRoQdX2ybU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmO3jUKmBVspgoGdMHJ6GCTqbnJmH88g3j1T8G5EAl0THm9yLOFaue5sqRj5OvulL
	 JDFz0riU11zg/X78iwbTarr4TvFmfK8DLqSfW3eTe6WB8kL6Es42n6O3tlpkHbZAK/
	 MddO4H7+nAkEsGBtjkyOaEPQGzf99i47IvgYSdPnrbUs4nUDEiD7dXUj7+ljxhekex
	 WIblD0DPkQSvW7b4+4lYaNNABQnwgyKp9/zbAcNER9k3wtivj85pEii/P8wzA8SRLt
	 D19EmWaE9tfDyJ7ywnhhFy5RIha0IUNNb88eI8PbrBIswq/SKVNbBt/+G+QCiEvSIQ
	 5jMpnYmgMMg6w==
Date: Thu, 13 Mar 2025 09:50:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Ryan Lee <ryan.lee@canonical.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 1/6] fs: invoke LSM file_open hook in do_dentry_open
 for O_PATH fds as well
Message-ID: <20250313-dompteur-dachten-bb695fcbebf1@brauner>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
 <20250312212148.274205-2-ryan.lee@canonical.com>
 <20250312213714.GT2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312213714.GT2023217@ZenIV>

On Wed, Mar 12, 2025 at 09:37:14PM +0000, Al Viro wrote:
> On Wed, Mar 12, 2025 at 02:21:41PM -0700, Ryan Lee wrote:
> > Currently, opening O_PATH file descriptors completely bypasses the LSM
> > infrastructure. Invoking the LSM file_open hook for O_PATH fds will
> > be necessary for e.g. mediating the fsmount() syscall.

LSM mediation for the mount api should be done by adding appropriate
hooks to the new mount api.

> > 
> > Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
> > ---
> >  fs/open.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/open.c b/fs/open.c
> > index 30bfcddd505d..0f8542bf6cd4 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -921,8 +921,13 @@ static int do_dentry_open(struct file *f,
> >  	if (unlikely(f->f_flags & O_PATH)) {
> >  		f->f_mode = FMODE_PATH | FMODE_OPENED;
> >  		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> >  		f->f_op = &empty_fops;
> > -		return 0;
> > +		/*
> > +		 * do_o_path in fs/namei.c unconditionally invokes path_put
> > +		 * after this function returns, so don't path_put the path
> > +		 * upon LSM rejection of O_PATH opening
> > +		 */
> > +		return security_file_open(f);
> 
> Unconditional path_put() in do_o_path() has nothing to do with that -
> what gets dropped there is the reference acquired there; the reference
> acquired (and not dropped) here is the one that went into ->f_path.
> Since you are leaving FMODE_OPENED set, you will have __fput() drop
> that reference.
> 
> Basically, you are simulating behaviour on the O_DIRECT open of
> something that does not support O_DIRECT - return an error, with
> ->f_path and FMODE_OPENED left in place.
> 
> Said that, what I do not understand is the point of that exercise -
> why does LSM need to veto anything for those and why is security_file_open()

I really think this is misguided. This should be done via proper hooks
into apis that use O_PATH file descriptors for specific purposes but not
for the generic open() path.

> the right place for such checks?

It isn't.

> 
> The second part is particularly interesting...


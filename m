Return-Path: <linux-fsdevel+bounces-11850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689A857EF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 15:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A422829CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024C12C7E3;
	Fri, 16 Feb 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TfG58YHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED212D779;
	Fri, 16 Feb 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092698; cv=none; b=rHE6THDje7jLkOJPIRofg47TNeGU8J1V9r6XZ5EqC4j1TeIWEvWQQza4Uwz4Pxgc8pMjlyEn0Nq+fvfhWQuzuEa/jhot688IKtQ7D11Xa2LgWdeJ4rHLtfYlnR6ckVABaRH0u4Hnq7Bj6ONDl2ChzRI6/5MegfQrL1DlwtixBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092698; c=relaxed/simple;
	bh=345TuA1rmsuaEelyM265PlGePNbH1mKaeRJ+h2qTGUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFEZrXFtDwucvCgq4W+GmyGa1Zx3KElfBOeg10hG+aI/0p4zqf3sT21sMivV2W1O/CYpgJ/FbmS7OchCtRDP4F+l82jj1MRQ01FEZL+sf/iwHyHaXG3bpLbHBPeZ0qNQwD6lnHAlfTCUJYvXQMt6lr4YVkebI/d8m3F85spLCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TfG58YHR; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tbv4D1dsMzfkn;
	Fri, 16 Feb 2024 15:11:24 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tbv4C0bnZz3h;
	Fri, 16 Feb 2024 15:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708092684;
	bh=345TuA1rmsuaEelyM265PlGePNbH1mKaeRJ+h2qTGUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfG58YHRrxCDrFfu/lxvD5H3IRm09O9LQHym6USmmUB2r3yhZvREqjHhNma1hQmu+
	 G0rxccYciGt9rsGyyPdYN46Dx6d4rwEkNTdGMuXU64UddmUrAj5sHEzMFoTe4J5xxN
	 xlCErgTS/ZIbSkxYxUFaxT087aTieQ6OoBVRZ0uE=
Date: Fri, 16 Feb 2024 15:11:14 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240216.geeCh6keengu@digikod.net>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
 <ZcdbbkjlKFJxU_uF@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcdbbkjlKFJxU_uF@google.com>
X-Infomaniak-Routing: alpha

On Sat, Feb 10, 2024 at 12:18:06PM +0100, Günther Noack wrote:
> On Fri, Feb 09, 2024 at 06:06:05PM +0100, Günther Noack wrote:
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 73997e63734f..84efea3f7c0f 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -1333,7 +1520,9 @@ static int hook_file_open(struct file *const file)
> >  {
> >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> >  	access_mask_t open_access_request, full_access_request, allowed_access;
> > -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE |
> > +					      LANDLOCK_ACCESS_FS_IOCTL |
> > +					      IOCTL_GROUPS;
> >  	const struct landlock_ruleset *const dom = get_current_fs_domain();
> >  
> >  	if (!dom)
> > @@ -1375,6 +1564,16 @@ static int hook_file_open(struct file *const file)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Named pipes should be treated just like anonymous pipes.
> > +	 * Therefore, we permit all IOCTLs on them.
> > +	 */
> > +	if (S_ISFIFO(file_inode(file)->i_mode)) {
> > +		allowed_access |= LANDLOCK_ACCESS_FS_IOCTL |
> > +				  LANDLOCK_ACCESS_FS_IOCTL_RW |
> > +				  LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;

Why not LANDLOCK_ACCESS_FS_IOCTL | IOCTL_GROUPS instead?

> > +	}
> > +
> 
> Hello Mickaël, this "if" is a change I'd like to draw your attention
> to -- this special case was necessary so that all IOCTLs are permitted
> on named pipes. (There is also a test for it in another commit.)
> 
> Open questions here are:
> 
>  - I'm a bit on the edge whether it's worth it to have these special
>    cases here.  After all, users can very easily just permit all
>    IOCTLs through the ruleset if needed, and it might simplify the
>    mental model that we have to explain in the documentation

It might simplify the kernel implementation a bit but it would make the
Landlock security policies more complex, and could encourage people to
allow all IOCTLs on a directory because this directory might contain
(dynamically created) named pipes.

I suggest to extend this check with S_ISFIFO(mode) || S_ISSOCK(mode).
A comment should explain that LANDLOCK_ACCESS_FS_* rights are not meant
to restrict IPCs.

> 
>  - I've put the special case into the file open hook, under the
>    assumption that it would simplify the Landlock audit support to
>    have the correct rights on the struct file.  The implementation
>    could alternatively also be done in the ioctl hook. Let me know
>    which one makes more sense to you.

I like your approach, thanks!  Also, in theory this approach should be
better for performance reasons, even if it should not be visible in
practice. Anyway, keeping a consistent set of access rights is
definitely useful for observability.

I'm wondering if we should do the same mode check for
LANDLOCK_ACCESS_FS_TRUNCATE too... It would not be visible to user space
anyway because the LSM hooks are called after the file mode checks for
truncate(2) and ftruncate(2). But because we need this kind of check for
IOCTL, it might be a good idea to make it common to all optional_access
values, at least to document what is really handled. Adding dedicated
truncate and ftruncate tests (before this commit) would guarantee that
the returned error codes are unchanged.

Moving this check before the is_access_to_paths_allowed() call would
enable to avoid looking for always-allowed access rights by removing
them from the full_access_request. This could help improve performance
when opening named pipe because no optional_access would be requested.

A new helper similar to get_required_file_open_access() could help.

> 
> BTW, named UNIX domain sockets can apparently not be opened with open() and
> therefore they don't hit the LSM file_open hook.  (It is done with the BSD
> socket API instead.)

What about /proc/*/fd/* ? We can test with open_proc_fd() to make sure
our assumptions are correct.


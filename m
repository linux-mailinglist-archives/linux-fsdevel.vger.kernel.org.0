Return-Path: <linux-fsdevel+bounces-38950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F8DA0A466
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAB01644E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD11B041B;
	Sat, 11 Jan 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BcvQ0Epe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF818FDBA
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jan 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736609949; cv=none; b=XhDafO75iyjwbcmu6WGGcp/b1JorN86cPEyhWfNDDe/kGNVg63Bf9PzZIosLm0v/NR+qXqcXOgT8J90lSgNUnenTAYXMQdMj2t6rW2TP1sn2cwAP2e7Q6F7cpse/0qOp/mcvbj8TyXjfoP8+y13RBaioYJm5xNlpAPaQXHES8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736609949; c=relaxed/simple;
	bh=9IFdTwZ+yBnPyfmpwB38q8dAqIrG6OSXEQlgm+4Ayf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edGZzTf4Cf+q1NlcBmM2dEeTU1Om/ZigUZDt2zF0mrpweLEFmLlVk3Nd/6nUMx0FXaTmr3uAYAqMW8hxUI5kRdE4QxaOxJigpkoLE6zY8lQE4kBVXF2oaP56q5hBBVgwRUqRDX1f2xam0dDaz7zlgG17ZfJ47ASHWPyp6lX5GII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BcvQ0Epe; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YVjNy6bFGzpMH;
	Sat, 11 Jan 2025 16:38:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736609938;
	bh=8qOYE5fhMwTZl6ab4L7AoSR/uklgpbBSnLF+bBJGY2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcvQ0EpesgImbVFCn2idhlce4+SO6Le0b2rccONi48PiCAurGGDPzpWjq85mnJufh
	 E6dscsTOU3nPfUymrXhhzSxdoo/17T8CCCo9uWfruGKmr1OaSMK6yC8Tm8F01RDsdO
	 mq74bFHnr9eje3CopmyO+IGLt/ty4fQhHekrb98Q=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YVjNx6TnczTjj;
	Sat, 11 Jan 2025 16:38:57 +0100 (CET)
Date: Sat, 11 Jan 2025 16:38:56 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Dave Chinner <david@fromorbit.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	syzbot+34b68f850391452207df@syzkaller.appspotmail.com, syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com, 
	Ubisectech Sirius <bugreport@ubisectech.com>, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Handle weird files
Message-ID: <20250111.PhoHophoh1zi@digikod.net>
References: <20250110153918.241810-1-mic@digikod.net>
 <20250110.3421eeaaf069@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110.3421eeaaf069@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Jan 10, 2025 at 05:37:26PM +0100, Günther Noack wrote:
> On Fri, Jan 10, 2025 at 04:39:13PM +0100, Mickaël Salaün wrote:
> > A corrupted filesystem (e.g. bcachefs) might return weird files.
> > Instead of throwing a warning and allowing access to such file, treat
> > them as regular files.
> > 
> > Cc: Dave Chinner <david@fromorbit.com>
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/r/000000000000a65b35061cffca61@google.com
> > Reported-by: syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/r/67379b3f.050a0220.85a0.0001.GAE@google.com
> > Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
> > Closes: https://lore.kernel.org/r/c426821d-8380-46c4-a494-7008bbd7dd13.bugreport@ubisectech.com
> > Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/fs.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index e31b97a9f175..7adb25150488 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -937,10 +937,6 @@ static access_mask_t get_mode_access(const umode_t mode)
> >  	switch (mode & S_IFMT) {
> >  	case S_IFLNK:
> >  		return LANDLOCK_ACCESS_FS_MAKE_SYM;
> > -	case 0:
> > -		/* A zero mode translates to S_IFREG. */
> > -	case S_IFREG:
> > -		return LANDLOCK_ACCESS_FS_MAKE_REG;
> >  	case S_IFDIR:
> >  		return LANDLOCK_ACCESS_FS_MAKE_DIR;
> >  	case S_IFCHR:
> > @@ -951,9 +947,12 @@ static access_mask_t get_mode_access(const umode_t mode)
> >  		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
> >  	case S_IFSOCK:
> >  		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
> > +	case S_IFREG:
> > +	case 0:
> > +		/* A zero mode translates to S_IFREG. */
> >  	default:
> > -		WARN_ON_ONCE(1);
> > -		return 0;
> > +		/* Treats weird files as regular files. */
> > +		return LANDLOCK_ACCESS_FS_MAKE_REG;
> >  	}
> >  }
> >  
> > -- 
> > 2.47.1
> > 
> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> Makes sense to me, since this is enforcing a stronger check than before
> and can only happen in the case of corruption.
> 
> I do not have a good intuition about what happens afterwards when the
> file system is in such a state.  I imagine that this will usually give
> an error shortly afterwards, as the opening of the file continues?  Is
> that right?

I guess it depends on the filesystem implementation.  For instance, XFS
returns an error if a weird file is detected [1], whereas bcachefs
ignores it (which is considered a bug, but not fixed yet) [2].

[1] https://lore.kernel.org/all/Zpc46HEacI%2Fwd7Rg@dread.disaster.area/
[2] https://lore.kernel.org/all/4hohnthh54adx35lnxzedop3oxpntpmtygxso4iraiexfdlt4d@6m7ssepvjyar/

> 
> –Günther
> 


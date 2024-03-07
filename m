Return-Path: <linux-fsdevel+bounces-13926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502838758AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D114B1F25FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE254139585;
	Thu,  7 Mar 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z4r9Uz2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983761386B9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844058; cv=none; b=aEwuzVC2LIJ/nK7AJWd6JkokMCE+woRZquyc0rsJkC8SJpoaufyihMGVdFYEoS1Un8Y90+u6XailX7y6WjSinACuDs3LXylwa/+IVyq8/L0b19Ny8+hmRcnaaVAkl70BmP92JCQF10ByJARlglmBlKrYPk1kjQC2XdE4z3zdrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844058; c=relaxed/simple;
	bh=YD6IOu8nDfIXPN8+ylWv38YcSggQx9dtsVGoEAkBgHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyHvkjGg7fQlQCdt7XJU60LFUDQivXv1KMlW0r9CuU3HGb1DHCLamn+I7PPZmRq7cegZIwQZwhSyM/NBkGi7zinxM7vwRvQkftGMuPw1Qp/V/TEqH7MPAqmpcM7VGOQf2+KmW2kmDzw0fmkH8kDcJen5KJob5uIhsuQZPpm0GQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z4r9Uz2N; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so218064276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 12:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709844055; x=1710448855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nma+ITwvfFBde3KRAjXMtI8cs5tBZm/y1uqy7pM4mQk=;
        b=Z4r9Uz2Nn5AYkcCrrsJ+UOmhb1LnJwaJzVYzeO4pnbjbYryWHdAIEIWAl3cCLNjWNs
         6NZpuGKqMco5xAGz/EGuqSiQYZiEc6IAFs4l/N5eb1Uyigw462Gp9mbpLg4SdhFjWTRI
         +ek9yW7FaJ3v+gEqWIuJCLAZWzPhb9S1QsIM4nvWZLYCnusvKwRuThXfg8RoNalmDHzD
         EOE2U+58Ht8uuePmjPSpXKSr03I1IumJeax9ncUXeOB/jF2SpPWxQj89vmIW1OsFJhWg
         ulBw2KMGKWKaK3Kwn9sxLcoIZ0sRg5coxvZArliBHC8UuTvpmc0+q/0+W6ZlO9wYXLkI
         Xisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709844055; x=1710448855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nma+ITwvfFBde3KRAjXMtI8cs5tBZm/y1uqy7pM4mQk=;
        b=nVKbqFMgHhQVg7LeFSoiSNwsyUTMcIgHT+c35ZAE/gbpnTm/BMmo95k7oTWGSzYr1f
         5nSiD4/tU434cJiwd0hmxknFzG/ApKtydlv7+CzeTzQzXMgnoPSkOSTqF9xXIzOVrhlZ
         2uyPNLbSZExUtT4wdMSRdxYb6q6ltbCcuIJlyn5a7+scD9L1p1moxO/L6YZ7K7PKYtn7
         xowbnauXtJa7gSnpTwAgILAPwmUN2p3IrubwlbEaqC8DzdVP0kNVV6gE74anFUQaG8Wa
         uczaRYw+76z5sTtaQgvwWcn47MtKHtdgN+jrncgqg7iEMAMsc6ZkbNo58g7NVBFiCsWc
         dE6g==
X-Forwarded-Encrypted: i=1; AJvYcCXZhX8WgW89IFC1/6Ka0tqhFVbbCivpA7fpcH7CPyqpWXG2ZmDHEp2yLPj1ZZEI5rIPsnt8cPNXPiOqP+mzP3Xj6AGnB6NAPoOBY7kUoA==
X-Gm-Message-State: AOJu0YyuNKoHKin1zaBGplPNBG8LL1cAQJIgoyPza4yFa/Owhl/+kxjM
	f8My4vJ2V5+ug6MHnT3DegmcWfD4CFTcz/HEpAIMdlhKRtipP98Sd+knf153WrSg5Kw7IXejnOG
	/Yky0wpA4adqZuLBvxPdamK051if44C+kvuSP
X-Google-Smtp-Source: AGHT+IFzxd7Js/eAEXV/+jo/EkCE0PXjdYydQEhCI2Sd4NoDikw5vlrFxfqxmRjE8N+c38U3ya0l5c8YYD3sFGcWEFU=
X-Received: by 2002:a25:fe03:0:b0:dcf:c086:dd43 with SMTP id
 k3-20020a25fe03000000b00dcfc086dd43mr14711677ybe.14.1709844055470; Thu, 07
 Mar 2024 12:40:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219.chu4Yeegh3oo@digikod.net> <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com> <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com> <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com> <Zem5tnB7lL-xLjFP@google.com>
In-Reply-To: <Zem5tnB7lL-xLjFP@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Mar 2024 15:40:44 -0500
Message-ID: <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:57=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
> On Thu, Mar 07, 2024 at 01:21:48PM +0100, Arnd Bergmann wrote:
> > On Thu, Mar 7, 2024, at 13:15, Christian Brauner wrote:
> > > On Wed, Mar 06, 2024 at 04:18:53PM +0100, Arnd Bergmann wrote:
> > >> On Wed, Mar 6, 2024, at 14:47, Micka=C3=ABl Sala=C3=BCn wrote:
> > >> >
> > >> > Arnd, Christian, Paul, are you OK with this new hook proposal?
> > >>
> > >> I think this sounds better. It would fit more closely into
> > >> the overall structure of the ioctl handlers with their multiple
> > >> levels, where below vfs_ioctl() calling into f_ops->unlocked_ioctl,
> > >> you have the same structure for sockets and blockdev, and
> > >> then additional levels below that and some weirdness for
> > >> things like tty, scsi or cdrom.
> > >
> > > So an additional security hook called from tty, scsi, or cdrom?
> > > And the original hook is left where it is right now?
> >
> > For the moment, I think adding another hook in vfs_ioctl()
> > and the corresponding compat path would do what Micka=C3=ABl
> > wants. Beyond that, we could consider having hooks in
> > socket and block ioctls if needed as they are easy to
> > filter out based on inode->i_mode.
> >
> > The tty/scsi/cdrom hooks would be harder to do, let's assume
> > for now that we don't need them.
>
> Thank you all for the help!
>
> Yes, tty/scsi/cdrom are just examples.  We do not need special features f=
or
> these for Landlock right now.
>
> What I would do is to invoke the new LSM hook in the following two places=
 in
> fs/ioctl.c:
>
> 1) at the top of vfs_ioctl()
> 2) at the top of ioctl_compat()
>
> (Both of these functions are just invoking the f_op->unlocked_ioctl() and
> f_op->compat_ioctl() operations with a safeguard for that being a NULL po=
inter.)
>
> The intent is that the new hook gets called everytime before an ioctl is =
sent to
> these IOCTL operations in f_op, so that the LSM can distinguish cleanly b=
etween
> the "safe" IOCTLs that are implemented fully within fs/ioctl.c and the
> "potentially unsafe" IOCTLs which are implemented by these hooks (as it i=
s
> unrealistic for us to holistically reason about the safety of all possibl=
e
> implementations).
>
> The alternative approach where we try to do the same based on the existin=
g LSM
> IOCTL hook resulted in the patch further up in this mail thread - it invo=
lves
> maintaining a list of "safe" IOCTL commands, and it is difficult to guara=
ntee
> that these lists of IOCTL commands stay in sync.

I need some more convincing as to why we need to introduce these new
hooks, or even the vfs_masked_device_ioctl() classifier as originally
proposed at the top of this thread.  I believe I understand why
Landlock wants this, but I worry that we all might have different
definitions of a "safe" ioctl list, and encoding a definition into the
LSM hooks seems like a bad idea to me.

At this point in time, I think I'd rather see LSMs that care about
ioctls maintaining their own list of "safe" ioctls and after a while
if it looks like everyone is in agreement (VFS folks, individual LSMs,
etc.) we can look into either an ioctl classifier or multiple LSM
ioctl hooks focused on different categories of ioctls.

--=20
paul-moore.com


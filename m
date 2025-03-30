Return-Path: <linux-fsdevel+bounces-45308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C3A75BFF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 21:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BDE3A935B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 19:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EDE1DE2A4;
	Sun, 30 Mar 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If+z/APb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096520E6;
	Sun, 30 Mar 2025 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743364432; cv=none; b=HbTcaKgJj4jsp+EeH4HylkGM4VjKxFXPH0ZKG6Tu196JIFMnZXLE3Zaq7U9Bs+3mhnLDnqAP2hRowbq+8M0CMm5IMRva8bi+GckXgNDwzV9CiU/wt9+xw7aRLPDx7lK38n/JVpVE38rtefiA1hy1S2FyawRlmGZDrTiS5F/cR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743364432; c=relaxed/simple;
	bh=7HpLjDz9dUnhNLN/QwJLNG9jgC+bqhBpXxAQHMmNtA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etqB4I3D2UoUczmxGAci4I+Iz0jgNGuVubzOmG0W0xPCgmWRy0hBuf803lqMdYVG+mazsykpynVtQdrhWYHuVCdurdr3hdI5Asf69OrDBS2DE+sK7SXLBXAr33l3JZv6i1CkH4IjQ2GbhnOez8CEzBAZOL3aKXBpJZ45IumuIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If+z/APb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2963dc379so607134066b.2;
        Sun, 30 Mar 2025 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743364428; x=1743969228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GANVDERgqCuub7VKCOKeL96xzXZKAMBgd57H2S6wL50=;
        b=If+z/APb0NW3BxHDwciaKNIb4TI9keDcIc5Cql6b6No6p96o7TdqW81jBLDOCDJq70
         aY05HU68PC9LVYlac9D0UJnjCfS70eo2b2bhUhrztA2DiAugiQRrDwUzypKT0rUMKJso
         fRPGnkr42Bc+gBTNA8pWS+k3S8BxM/AJaSU13UB4th1mc14tjsVmUUz9L2pKLKBSRMsT
         JFi4PWYGQUZpcgDxwFVDqBXx9hF9aOqiFDBFY6oKTvZVY/zcOv6zXC0ay0X9IUjudr3W
         PbKe0mu01rMoKwEPCpS1e9nUjDv+iO5wwGMhSLdoLfM5ty3cnKLK5RGbmgqUzUiAgNZk
         M+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743364428; x=1743969228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GANVDERgqCuub7VKCOKeL96xzXZKAMBgd57H2S6wL50=;
        b=qH2V9ij/Ljy/xtwfvpzuUHisKpz1Flpf+FeqCLzGqDYYOBzXuMb+bOcX62mJV4EUZQ
         Enc6joyiVN4So0RWKsSlVl43OpqXmee/8ySCFtcObx+uxlK/TcDFUYxmW39l2dkw9L7D
         L2iRmLCBzTRFWQeskcoJ32GW5DQm9r4POPtrZyp+/YGBp2B2NG+U0CMTDceMOY1YayhD
         GXCHWdYtARuYJwrv7F84gJBGHZjqRySXkRL3WGxYaLVMhN3IQ1BD8irxL0txUruUt8Re
         fEwfk6NGgaTqOcN/B4iWI4hyws1qtJWRXHY5oiQlHvuOoaezFL58sYGULb6K4pxkllYd
         3vvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVffkB+vo5YoRfjrtqUQdx83tpuJHUBzrUMpDNdXhJ/TJoV2+dN7HYsALs5tNBhuYq4pEwqIjj3aow2Mgy@vger.kernel.org, AJvYcCWPNbvVjiERG6Tv7F6AdL5ThSt+hJCUUFWf9N897EV8wvO8/0SuPp8PIXA4gJj/ryJFC4xd6TtERhYk@vger.kernel.org
X-Gm-Message-State: AOJu0YwHe9NBBd1hiLBd9TmuMfRb3VcV1MGRZzprOG10+0Bsh93wrHx4
	8yMtejMslZqJeDUELupJSWRLOFc2VCyGWn+srQ5AZeLzfipX/w2aX7JCYoAB9OrjFmF9hJGHLTv
	4HG1bMB1bHb9LOhbYoeg2fVqBrgw=
X-Gm-Gg: ASbGncuKz0Hxz+W7HPsg3+0+CTU3uOctRRETXWBI62z//jWMJUYmPJmzhHoy3c+CKWF
	ol256CaqlO1uk6ngJ2RKI3pJjpe0WkQ5f8CWMHR7t8eQ0fVYlfawsOeNUdPHoG9KAm7mwLh4Pku
	rgrc9Ou0SrTcWXNj0Z0QN2Okb5Lg==
X-Google-Smtp-Source: AGHT+IEINPaNrE3VO9H9O6ZudGcHTzRBsaVLT+wZh+9gS98CCOacLC3PFA0JKa4O9h3P4dSUklFgBEzXwhAvQQWgdAA=
X-Received: by 2002:a17:907:7e82:b0:abf:5f3c:58e7 with SMTP id
 a640c23a62f3a-ac73892d4b4mr726217166b.3.1743364428098; Sun, 30 Mar 2025
 12:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330153326.1412509-1-amir73il@gmail.com> <mwttu4y4pvussz2zug6dlmgioqcfwgqsup3fqhyfa437mi2k2p@bl5orpxlsa4z>
In-Reply-To: <mwttu4y4pvussz2zug6dlmgioqcfwgqsup3fqhyfa437mi2k2p@bl5orpxlsa4z>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 30 Mar 2025 21:53:36 +0200
X-Gm-Features: AQ5f1JqGbYU1uhyHXQPDbF6qTJyEj42f3bszBcrzGFjPd1TqyV3T5mq8WQeSbVw
Message-ID: <CAOQ4uxjppaLhRnWvm_Q7EwRYA9rDTE57xY7_DO0KJKLJngM+xw@mail.gmail.com>
Subject: Re: [PATCH] fanotify.7: Document extended response to permission events
To: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx.manpages@gmail.com>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, linux-man@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 7:52=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> Hi Amir,
>
> On Sun, Mar 30, 2025 at 05:33:26PM +0200, Amir Goldstein wrote:
> > Document FAN_DENY_ERRNO(), that was added in v6.13 and the
> > FAN_RESPONSE_INFO_AUDIT_RULE extended response info record
> > that was added in v6.3.
> >
> > Cc: Richard Guy Briggs <rgb@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Alejandro,
> >
> > I was working on man page updates to fanotify features that landed
> > in v6.14 and found a few bits from v6.3 that were out of date, so
> > I added them along with this change.
> >
> > If you want me to split them out I can, but I did not see much point.
>
> I prefer them in two patches.  You can send them in the same patch set,
> though.

ok

I pushed the two patches to
https://github.com/amir73il/man-pages/commits/fan_deny_errno

Let me know if you want me to re-post them

>
> > This change to the documentation of fanotify permission event response
> > is independent of the previous patches I posted to document the new
> > FAN_PRE_ACCESS event (also v6.14) and the fanotify_init(2) flag
> > FAN_REPORT_FD_ERROR (v6.13).
> >
> > There is another fanotify feature in v6.14 (mount events).
> > I will try to catch up on documenting that one as well.
> >
> > Thanks,
> > Amir.
> >
> >  man/man7/fanotify.7 | 60 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> > index 6f3a9496e..c7b53901a 100644
> > --- a/man/man7/fanotify.7
> > +++ b/man/man7/fanotify.7
> > @@ -820,7 +820,7 @@ This is the file descriptor from the structure
> >  .TP
> >  .I response
> >  This field indicates whether or not the permission is to be granted.
> > -Its value must be either
> > +Its value must contain either the flag
>
> This seems unrelated.  Please keep it out of the patches.  If you want
> to do it, please have a third trivial patch with "wfix" in the subject.

what does wfix stand for?

this is not a typo fix, this is a semantic fix.

It is not true that the value of response is either FAN_ALLOW or FAN_DENY
those are flags in a bitset and the correct statement is that exactly
one of them needs to be set.

>
> >  .B FAN_ALLOW
> >  to allow the file operation or
> >  .B FAN_DENY
> > @@ -829,6 +829,24 @@ to deny the file operation.
> >  If access is denied, the requesting application call will receive an
> >  .B EPERM
> >  error.
> > +Since Linux 6.14,
> > +.\" commit b4b2ff4f61ded819bfa22e50fdec7693f51cbbee
> > +if a notification group is initialized with class
> > +.BR FAN_CLASS_PRE_CONTENT ,
> > +the following error values could be returned to the application
> > +by setting the
> > +.I response
> > +value using the
> > +.BR FAN_DENY_ERRNO(err)
>
> This formatting is incorrect.  BR means alternating Bold and Roman, but
> this only has one token.
>

ok I added a space

> > +macro:
> > +.BR EPERM ,
> > +.BR EIO ,
> > +.BR EBUSY ,
> > +.BR ETXTBSY ,
> > +.BR EAGAIN ,
> > +.BR ENOSPC ,
> > +.BR EDQUOT .
>
> Should we have a manual page for FAN_DENY_ERRNO()?  (I think we should.)
> I don't understand how it's supposed to work from this paragraph.
>


#define FAN_DENY_ERRNO(err) (FAN_DENY | (((err) & 0xff) << 24))

combined FAN_DENY with a specific error, but I see no
reason to expose the internals of this macro

This does not deserve a man page of its own IMO.

If you have a suggested for better formatting, please suggest it


> > +.P
> >  Additionally, if the notification group has been created with the
> >  .B FAN_ENABLE_AUDIT
> >  flag, then the
> > @@ -838,6 +856,46 @@ flag can be set in the
> >  field.
> >  In that case, the audit subsystem will log information about the acces=
s
> >  decision to the audit logs.
>
> Do we want to start a new paragraph maybe?
>

ok

> > +Since Linux 6.3,
> > +.\" commit 70529a199574c15a40f46b14256633b02ba10ca2
> > +the
> > +.B FAN_INFO
> > +flag can be set in the
> > +.I response
> > +to indicate that extra variable length response record follows struct
>
> s/variable length/variable-length/
>
> And we usually say 'XXX structure' instead of 'struct XXX'.
>

ok

> > +.IR fanotify_response .
>
> The above sentence is too long.  I'd split it into two:
>
> Since Linux 6.3, the FAN_INFO flag can be set in the response field.  It
> indicates that an extra variable-length response record follows the
> fanotify_response structure.
>

ok

> > +Extra response records start with a common header:
> > +.P
> > +.in +4n
> > +.EX
> > +struct fanotify_response_info_header {
> > +    __u8 type;
> > +    __u8 pad;
> > +    __u16 len;
> > +};
> > +.EE
> > +.in
> > +.P
> > +The value of
> > +.I type
>
> I'd say '.type' instead of 'type'.  I know there's no consistency about
> it, but I'm going to globally fix that eventually.  Let's do it good for
> new documentation.  The '.' allows one to easily know that we're talking
> about a struct or union member.
>

Sounds like a good change to me.

pushed requested fixes to github.

Thanks,
Amir.


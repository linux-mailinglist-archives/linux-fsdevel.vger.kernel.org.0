Return-Path: <linux-fsdevel+bounces-73808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A377BD21127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AAAE30158C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383934EEEF;
	Wed, 14 Jan 2026 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="tSB0Bm7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68989346AC6
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419794; cv=none; b=By9HX+UEFisGFVpPtLdgnYDmeahfA8haqGCqEcViqPl5VB5CNVVwFYAs6OzpRIFLpFA+krYNM+cWn1vZwRtA0s1gtgG0GLfaSST9cBsVpq5310GA6GrjqvuzWz+H7QlaEmPNeYVZm5arhorcGQyBOVMERfVZ2EQqgTyXpaoWx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419794; c=relaxed/simple;
	bh=ZhhTZMN0ehgf0tGkAcii42QuoZmFgk0/r2SLS2TyyQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCxTSNEVqTAlKbIg0MVwhrG6bhDKUVQdd+v/YaH7ZYj/3mtGLhXUbGgfLp9koK+vSRmYLLILmOehXedsb7L4ZRh7nnkYuUGOTiHolZ9UvWkWMFnFkm0EgN6Tz3M7wOZ/cKobkal/jVFgkl9dGNnzjOLvEygb3DmZdaefWbQ6W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=tSB0Bm7o; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6a987346so147639e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1768419790; x=1769024590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUxc3Hn0SNWrFc/C49lbgOSImV6j7xAdDMJgAmCGraw=;
        b=tSB0Bm7ocGeHqnitthCOq0jooVlGIRY5PK7ogG0EIieScJ9E8pRyHgSRahEx7yYWG/
         ZXM/c26Vx6h+BJWjbhKezPZCVxx2VOfdEOoXPFflSRQgDtW8NO+oi5JM9OQxZbKybBgU
         ucLRf1/lNsgXfbU8deE/b/0wspjYG0lRIEL2URN3lPmopot5A2NGN2vO6Vj1jk9HwvX+
         +Mxz+MQGIP0MQZZqN50+dVgIBRq92aK8KnsZiZW6fyzvPAz5CRV6ytLV3kZNpd1hJm76
         OGo6i0L4MaR6KmDjmMNkaWCxfTTjV35k2O9phD7mp0oUlQIHfCbqU1ifSEuxjyh98n6R
         ggkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768419790; x=1769024590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NUxc3Hn0SNWrFc/C49lbgOSImV6j7xAdDMJgAmCGraw=;
        b=ThCPoZpdKI8Rpn2V9xDvSjcEziei7ADDCBu1n63k1xW74Ixy8TGACu1QkZGI3CC8Jp
         kSJAs9mAsSn+gt2SJPiYdFCyl2Ts2PL6Oa0wtTmN3J5VozsrddRQa5mU669/g5S/GxWJ
         0AWqZnB/gQC1PgzIclZ6fb20ZnfnGmrzZwiRBZVgHuj8y81hosuAObI6AjKVaaRYCFDG
         t66hzd6uLvC+guLOg9WDqMEA+ffDSJ4ICMcFDFv4Ax7ChochxgeVu2SUqD2mOx4MHHj2
         CMs9RO63tUa/paxEdfcQtR1luwqv2R+f3oZAx1CY74ugX3GbTBqPIPzrc2V+Z9OaAP/s
         ms6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJi234yLQ3Q5lWc2DvPtsaqrJiIX0yCpfyh/OerTy8u+ZA1xI1QUHHGiaZDOHJVk8ftRYTYjAdhB3MDMSV@vger.kernel.org
X-Gm-Message-State: AOJu0YxzunKLe1hQNeOCphqXU4x8AB5ymWWFtp5SGKv0l1S3OwXqtbHt
	kcPtesKYWZWGhuURpizjhYPCqh7MHMJt8mcUCT0dS/8551N1/n3A4Lf6UtupzPVMqOm41s+xytd
	qNK1Q47dkalPNMYMkk3N+SG4HmaSpaGmAYxiYrb8btkBdmXb6yaQ=
X-Gm-Gg: AY/fxX6BMzAupepbNZ0K90ptKt/7YJZRkpQ4jOtPG1/oIWJC1cjHkgsMPywXI0/yeOB
	CPeCpYv6PWDWjTvNyMrLvhEL8Etg03ZxB81PFJkEnjkAgvEg2IHhUfuiC5IrJuJCT773/jl2igt
	MkNUALniElJxbSZdZI0fSvELfL65hHOmuPPiE2G2G7fJmGA5aKIFe8kM/nQFDJ53BJOSw7NXvx9
	CHAVH7cwtzNaomuEGarxyvpavB7R5wIoljQa2W3bIai5WQ3hRm0ZYYD88vJZ3OLDJuxl7bI
X-Received: by 2002:a05:6512:230a:b0:59b:7b86:44d2 with SMTP id
 2adb3069b0e04-59ba0f625d1mr1093790e87.18.1768419790401; Wed, 14 Jan 2026
 11:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lhupl7dcf0o.fsf@oldenburg.str.redhat.com> <20260114-alias-riefen-2cb8c09d0ded@brauner>
In-Reply-To: <20260114-alias-riefen-2cb8c09d0ded@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 Jan 2026 11:42:57 -0800
X-Gm-Features: AZwV_Qh4sDdnUSkIjBmXBNvr1L_5TDLS3DtrZGooiMx2ioUN8BbYOXB9OIpgvcQ
Message-ID: <CALCETrWMWs3_G5JhJb7+h+JQjpqXxqOh2vNcQaG1HuXjaeCqQw@mail.gmail.com>
Subject: Re: O_CLOEXEC use for OPEN_TREE_CLOEXEC
To: Christian Brauner <brauner@kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, 
	DJ Delorie <dj@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:09=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jan 13, 2026 at 11:40:55PM +0100, Florian Weimer wrote:
> > In <linux/mount.h>, we have this:
> >
> > #define OPEN_TREE_CLOEXEC      O_CLOEXEC       /* Close the file on exe=
cve() */
> >
> > This causes a few pain points for us to on the glibc side when we mirro=
r
> > this into <linux/mount.h> becuse O_CLOEXEC is defined in <fcntl.h>,
> > which is one of the headers that's completely incompatible with the UAP=
I
> > headers.
> >
> > The reason why this is painful is because O_CLOEXEC has at least three
> > different values across architectures: 0x80000, 0x200000, 0x400000
> >
> > Even for the UAPI this isn't ideal because it effectively burns three
> > open_tree flags, unless the flags are made architecture-specific, too.
>
> I think that just got cargo-culted... A long time ago some API define as
> O_CLOEXEC and now a lot of APIs have done the same. I'm pretty sure we
> can't change that now but we can document that this shouldn't be ifdefed
> and instead be a separate per-syscall bit. But I think that's the best
> we can do right now.
>

How about, for future syscalls, we make CLOEXEC unconditional?  If
anyone wants an ofd to get inherited across exec, they can F_SETFD it
themselves.

--Andy


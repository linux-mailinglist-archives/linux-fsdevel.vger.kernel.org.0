Return-Path: <linux-fsdevel+bounces-36579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBD9E6124
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 00:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EC9282A20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FFE1D1724;
	Thu,  5 Dec 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTlSgBco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76EB1CCEED
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733440246; cv=none; b=jMpJvMrijH7hDWKUjI8Be4sc1dktoJ/pfzY/155hz7+c0Ph3hHY/SxWhmuhNKXKnNQE1Cl7jMcaIiR8kN+6fcQxrLbn+vi+oVhTjDRs9RIqs9Ksu9B/VGeYrgbtTfMgjaunmIiBrMVMe1TodRjL/2SsuxuIIc9urBEYGDqvxbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733440246; c=relaxed/simple;
	bh=R+GQzCdAqqnFNtu4UCJurznl4yKB3zt/Yr+qjAjILGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4YEb8fjlIgVSeW5bO8cCk8/VVb3pWB5kMrtSDzUj/Ulho9mDTusBBfBNBnrgf1NEEKcBzTanCxQwsh+uXoIsGAIQPgJSdtcZ8czNVcM2JiWcbP2/wzP5eYbNzrSyuPZ4uSINgCZuyLfNU/NOvWiYSprqciziTqlfQXrKWfKOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTlSgBco; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4668983b04eso10436551cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733440244; x=1734045044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9F1z+J1oYawHbsDWluZhbMbn+9fXArVnXvNJ2pehUw=;
        b=cTlSgBcoVOjKpcbgCLjXoJph6LZmSLkdh2JD3P0FeWHAmOfFYE+szXrrqTT+JSmBUn
         WILayhlnIoW+impX390ltXAunPcxjWgdVzu5PiAxuJrK2X+YY7DnTfQYdo2pGiyU+2w9
         Are5qv9KvuJ6sKDZ7+wZfbDNRGY6dEOzBNcAS/CUsDEW9VG0q7MV/5Hal2uuvKlOAZAC
         QR0+DPNs844ZzxJmgz5N+jbO5ueRTgvUo6/PCzzWbj0e1sakNDiFSNqUgS3EywN+Zimv
         Bv4FWf9mlflmLU4TZbnPJ7LC/U5991r8j8HmnLzNh2t3gWhmy1cnSRgfpVFPsK+Xq/oA
         PvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733440244; x=1734045044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9F1z+J1oYawHbsDWluZhbMbn+9fXArVnXvNJ2pehUw=;
        b=I8wSbxt+/F/xSTiAQ5PjMU37Tf5+1Hf8JUjs3rUMYXzjzxa+UnQ7DLa10h2bglfyJK
         DTgGvPtAQciej8lbWDDepK0+ixhZF4wJWP7pC6yUDq+7JbHT6x4Z0dR34+nI9GzCAJC7
         VsXPWALOSCApjMoxbpDsXQTYr7OjQamP0qnI9EFRQ7Pbo2eUKOgtPl+aY/8aEM7C3C8Z
         tnH6/Z4fUR7zzI91M4zAJoDR2gB7ssvDGJ/QQ9t6fCha8Px1dT3RHRwInPh4hUS5FJoI
         PBh2NEZuDy4X/dO6SyXn9LFwk/BI8wnifn4R4bh8VP0OvQmeiBdFIY9Y7oB6tQgfeE1/
         8uNw==
X-Forwarded-Encrypted: i=1; AJvYcCWT5TbEGbMe/sh8phoHa00AAepgZ0BKIucnXDe9T9Eq7BFqZaMpPcaeszQmHlbbX8UYpSO5xUOmFxmTClqh@vger.kernel.org
X-Gm-Message-State: AOJu0Yywzme/mijtSzWoicR8llwsX/qB5doviiv6DTFL/C7Qig+IOXfY
	dWp2ZtEJBOdmDvnaSVWuavPLTsVHxJvfnvYdgHNrRLibfHw6G0kXVah1NBEDtuO8K1yfTcrX06k
	1lmjc0U2xKD+17SXCsiGloPI5SfA=
X-Gm-Gg: ASbGnctm46i0gn+0n+v/TuUPYgg/xTEI87DYeSpOC3EJZq9FVxIYaMw+n/IS6BPr4uT
	94utamF7qCfEabWfCJwISMuy+bM01lC8GcpB9/cweUS2Xwag=
X-Google-Smtp-Source: AGHT+IExUnGp9Zguvm0M59FRRXuT59KIapfrqk4kjxZQ3B0oGLVVLl3lqPA8zOUUikynjvM6u2t0yObClJsSPgTuj50=
X-Received: by 2002:a05:622a:124f:b0:460:e8d3:7bc6 with SMTP id
 d75a77b69052e-46734f7eb53mr15181681cf.46.1733440243743; Thu, 05 Dec 2024
 15:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <20241204131438.GA16709@google.com>
In-Reply-To: <20241204131438.GA16709@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Dec 2024 15:10:32 -0800
Message-ID: <CAJnrk1ZOpS5ntzmofuPUN3ctX1t9WixL0bqhcnBRaYcM623keg@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>, Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 5:14=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/14 11:13), Joanne Koong wrote:
> [..]
> > @@ -920,6 +935,9 @@ struct fuse_conn {
> >       /** IDR for backing files ids */
> >       struct idr backing_files_map;
> >  #endif
> > +
> > +     /** Only used if the connection enforces request timeouts */
> > +     struct fuse_timeout timeout;
> >  };
> [..]
> > @@ -749,6 +750,7 @@ static const struct fs_parameter_spec fuse_fs_param=
eters[] =3D {
> >       fsparam_u32     ("max_read",            OPT_MAX_READ),
> >       fsparam_u32     ("blksize",             OPT_BLKSIZE),
> >       fsparam_string  ("subtype",             OPT_SUBTYPE),
> > +     fsparam_u16     ("request_timeout",     OPT_REQUEST_TIMEOUT),
> >       {}
> >  };
> >
> > @@ -844,6 +846,10 @@ static int fuse_parse_param(struct fs_context *fsc=
, struct fs_parameter *param)
> >               ctx->blksize =3D result.uint_32;
> >               break;
> >
> > +     case OPT_REQUEST_TIMEOUT:
> > +             ctx->req_timeout =3D result.uint_16;
> > +             break;
> > +
>
> A quick question: so for this user-space should be updated
> to request fuse-watchdog on particular connection?  Would
> it make sense to have a way to simply enforce watchdog on
> all connections?

Hi Sergey,

The third patch
(https://lore.kernel.org/linux-fsdevel/20241114191332.669127-4-joannelkoong=
@gmail.com/)
in this patchset adds this through the sysctl interface. The sys admin
can set /proc/sys/fs/fuse/max_request_timeout and this will ensure
requests don't take longer than this value.


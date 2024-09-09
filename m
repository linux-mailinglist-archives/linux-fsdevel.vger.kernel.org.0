Return-Path: <linux-fsdevel+bounces-28954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0129B971EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8801F24904
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD113AD09;
	Mon,  9 Sep 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dLprfjyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33E13A3E8
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897807; cv=none; b=OZ2lrqp22wVEzRyC6s7z60ekYB8OL1o5l17aG+8kNS5+zZlOdwWTDym7T8kJEUVveZ2pxbtRnzP0jvYUzzaLChqHwGg7F1Nuzt6lNHLsiMwMDAVVV3N9uYJ+lTb0FG3QLBb6d+XRA/3PEmzdTNTEkJFEajSN+y5tA8PbaWTyano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897807; c=relaxed/simple;
	bh=UD2ljjMyeCTiG/VAuf2toxKpwa7RSFcC6BIY4yWZNYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcFdmlNNGzCIFyTO6N90+eIhu2eUsmGol2dX7qX5ZRCi49D5XHbuqEW5T1Zy2X7vuQSck0oZ7C8ONWsArkOghoj3b7Qy/EZKn6gNnQTsNylLM91Brvds0d/eNX+dhNbDVLS+elkQv4elCvjcQ+qDASRQAWkP2h4LwUxOJknBUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dLprfjyR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6d6891012d5so36831217b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725897804; x=1726502604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmLD+KoyfTyy43xEOB1Jl+N/7L+1hOh+6Y9O1otzjvc=;
        b=dLprfjyRK5uq/nYa80qxz7L67vNzBIztE3iaw1kXiHeXiEE5qUJdJs75Pazd4Ox3sM
         dnMBirVg9XDN4x6GhnjpCPlX7KNMnbrWkNTGUZpF7yg08v8vO2CgBMNXyQnr1b/mlTJk
         Bowjjv2X/4cBI4Dpzh+z8WKsw1c0HLlQtrHGjQ/J/Qzs8KwmyG0TF0dQAGIcW9ykro43
         lzVg3iGS4VKQ7iNL4lgDPnjQccev9SA7jijY3NH6rUhIH6W9xJ8zTYdUXe8vbhPSS1f7
         z/Xzfd5cEDmsNpjEXFHdbn6JILcL8ngh92frrPQsDWeZGfb1lEjPeMiGpSxJqV9LR7xz
         qRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725897804; x=1726502604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmLD+KoyfTyy43xEOB1Jl+N/7L+1hOh+6Y9O1otzjvc=;
        b=GjdcZyhHvNhzyx+/p4tGN0wz68VBLRCACn99hSj5bOn0K7JxqM0XZAHfNwlq0qj9DY
         xNuERH82qymCwf1Iy0uCJMtprdtHx1G7mJ+uwyrEBghRrcUURnFEXG1t+H3oeagpsS7M
         Ss+q2pNoYk9S1gqH+LmkVT1txs8sK4eYK5P1HAGUwibk6qJW+ZPqzapfEEu9iOVstUVZ
         J1uH8YCkpxOKGYoHhaGLxKVXpMCXNTNtRSsp4U+o63LPDkm9qGTkSWSJRj0BnIbPz3pD
         iXrl8OFDRhfAe+YUaXgy4golW1opMh1jYLlMknd/9Ntl6pnVxS/GbBeeuB2fKV4AmZth
         Cttw==
X-Forwarded-Encrypted: i=1; AJvYcCUMm1j4+ALRoqCW/WwQkXZ0f4WSYS3J7+9V/fbb94ZpaQCEkvra8m1rigoJ//gjwlctScfpx+VXdZjCzVxa@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLQr4JMMBTQhJ7pXxnLc0aAFKWA05+fUUerHNx7LPOPZo/V0b
	N2fVQkS6mKUP7Q02lrKVYNFe7YlAfSJxRJg21A7gyLiQ3tA/C4wkjamVMV2USrDwZ0+nYcIRtEa
	vQjjTXQlI+qwDLU66Bh7eu9HnlcfWGjMMJT37
X-Google-Smtp-Source: AGHT+IFXJbCdQgIsUYiuclOIDXjii4BA+zlkZU46pBKrIPA+T27zslxg+uUckYtLiLzOREZpnuOR1x8LngOyzQPy6Do=
X-Received: by 2002:a05:690c:350a:b0:6b2:7ff8:ca1 with SMTP id
 00721157ae682-6db4515443dmr111890657b3.22.1725897803463; Mon, 09 Sep 2024
 09:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821095609.365176-1-mic@digikod.net> <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
 <20240908.jeim4Aif3Fee@digikod.net>
In-Reply-To: <20240908.jeim4Aif3Fee@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Sep 2024 12:03:12 -0400
Message-ID: <CAHC9VhSGTOv9eiYCvbY67PJwtuBKWtv6nBgy_T=SMr-JPBO+SA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 2:11=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Wed, Aug 21, 2024 at 12:32:17PM -0400, Paul Moore wrote:
> > On Wed, Aug 21, 2024 at 5:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGUR=
G
> > > for the related file descriptor.  Before this change, the
> > > file_set_fowner LSM hook was always called, ignoring the VFS logic wh=
ich
> > > may not actually change the process that handles SIGIO (e.g. TUN, TTY=
,
> > > dnotify), nor update the related UID/EUID.
> > >
> > > Moreover, because security_file_set_fowner() was called without lock
> > > (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a r=
ace
> > > condition and inconsistent LSM states (e.g. SELinux's fown_sid) compa=
red
> > > to struct fown_struct's UID/EUID.
> > >
> > > This change makes sure the LSM states are always in sync with the VFS
> > > state by moving the security_file_set_fowner() call close to the
> > > UID/EUID updates and using the same f_owner.lock .
> > >
> > > Rename f_modown() to __f_setown() to simplify code.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: James Morris <jmorris@namei.org>
> > > Cc: Jann Horn <jannh@google.com>
> > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >
> > > Changes since v2:
> > > https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> > > - Only keep the LSM hook move.
> > >
> > > Changes since v1:
> > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > - Add back the file_set_fowner hook (but without user) as
> > >   requested by Paul, but move it for consistency.
> > > ---
> > >  fs/fcntl.c | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > This looks reasonable to me, and fixes a potential problem with
> > existing LSMs.  Unless I hear any strong objections I'll plan to merge
> > this, and patch 2/2, into the LSM tree tomorrow.
>
> I didn't see these patches in -next, did I miss something?
> Landlock will use this hook really soon and it would make it much easier
> if these patches where upstream before.

Ah!  My apologies, I'll do that right now and send another update once
it's done.  FWIW, I'm going to tag 1/2 for stable, but since we are at
-rc7 presently I'll just plan to send it during the next merge window.

--=20
paul-moore.com


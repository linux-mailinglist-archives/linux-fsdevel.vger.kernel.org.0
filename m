Return-Path: <linux-fsdevel+bounces-28957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B2971F75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 18:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DA4B21ABD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DAE16C852;
	Mon,  9 Sep 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dspXmpuu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336D166F07
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900269; cv=none; b=nZgDx2WQL8sOXMtaG1p1qL/ct3UDbrY8uJepah+Lpu2wFA5AfuEjWXSgHzzxJDMJ8ZgMUAZWMii0+1rF9wVmRbga0/UC7XI+n1PumtDm13OnowkbcFk7nKKK3kKBGw49DljLTbOzq2gJ7ldDViLKZfdhesNXpT5lGwreaiT0vd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900269; c=relaxed/simple;
	bh=V5SufoawHf+c/KapMgHuCcvMRxuPqRJLaGR2qrGPwSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+Vh70Bh4z0WX32GFNEJCvQcAX1oiUVaQwnmo9KFqQ84OMcxED2O4lvb21h8LQPJFn7GkjoD3eBjder/27MEyheawSlAgF4hWM0f9s+b1Zz8WTTyE8xsZSPi9LoKZMbjCswvVkYxBJrQVnwyw5W8lhBhnslJHMgrm8AhAwcWegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dspXmpuu; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6b47ff8a59aso44213557b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725900267; x=1726505067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxOwYLSJGdDaOpYEoZbgLMtvbt8O5f37ZwwE3/MPh0Y=;
        b=dspXmpuu4CctlS61i0tk0zQTTIlNCINnKPgMSeR1uu7BWRsWVYOv76U5KIpLlmU9Ih
         AcdQI03S0sU4hGMI9M1S7aAXFv7TQfzhvOzSW2duHWMFzDhKZKksQSUrL1WTVjPwBc6J
         HQVLegnpMEjwut/snWK5QSKKoWqaNamFF0z+p6P09xLAhGMj9sejtH4bE0BpkggLi2Bp
         W7hLpm379O2xF016SyU9YHzsFUoDMUy++fjVmfYRxB3R6xZA4ev+VlOmQbcM7yhipp2/
         U1rlvAyB/SFUua6ZjS7DUyVF4VUWKxtEpqK1jwo9PSdkceWTcgL3je0nGrebxYs9WSC2
         1CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900267; x=1726505067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxOwYLSJGdDaOpYEoZbgLMtvbt8O5f37ZwwE3/MPh0Y=;
        b=uMBf1cneKi0r+dAMKo9uWsQgWKJA00GP2LArAqO5ooTcqtlERMF4xJDI+qBrCpZO3o
         XsU+zUvrN7U6BnTf/XD29ow0SDHsbnDUX0QKhN6vRXWyTiNvqJnUfICqj6MEyZZX+TEN
         S9zUjydEZZCXD+W9WLgQUjjKjIao/36sS+Qb1CVlwms7O7PHUiv1aLF3aX9s9JeO714Q
         +UMcGelKUCU1F0RuDvNQ18KJ8n+x7ERFFRPKNQhghoEBOBAJbDQVaCw3Ub05YegHGBWU
         VcqbgAPnhC6V0aw1rAWYvHui0AvWkaY4s4WoRWsMKOiYXRYUqWZjGjf4Pu62CXsC1oEe
         6XCg==
X-Forwarded-Encrypted: i=1; AJvYcCX7e1TQKlbyzOIO2QBf0WOnnxfzIQCdUkS+kTjII0LS0ncINsFW5MpwCg/XTpl44CBxFMm0WCdyjHQoclWa@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLl+npyikG+2SnbnGIv5unrw7yX0LFyCeMqvh3SuVyY7xaSUz
	W7btdiMesf1fDcaT4dDTtV0PbwwL9t2X+WiJjsrCRkv/i4/uN681yJpzv7vbepsTkgoxxusv0sr
	Ll9DlfKDAelP0yU0WefWSQyOyZe4ydF2VayYL
X-Google-Smtp-Source: AGHT+IG7ZtUx+p0eIcFiA2aT/49RI9azAwsEGWfUBykItgqPxBanhFUfYeMZLMxZBjYL9zvoU+ThTDKRjel2opLiwVA=
X-Received: by 2002:a05:690c:338c:b0:6b3:f01c:9a57 with SMTP id
 00721157ae682-6db4516cd86mr141309817b3.35.1725900267026; Mon, 09 Sep 2024
 09:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821095609.365176-1-mic@digikod.net> <CAHC9VhQ7e50Ya4BNoF-xM2y+MDMW3i_SRPVcZkDZ2vdEMNtk7Q@mail.gmail.com>
 <20240908.jeim4Aif3Fee@digikod.net> <CAHC9VhSGTOv9eiYCvbY67PJwtuBKWtv6nBgy_T=SMr-JPBO+SA@mail.gmail.com>
In-Reply-To: <CAHC9VhSGTOv9eiYCvbY67PJwtuBKWtv6nBgy_T=SMr-JPBO+SA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Sep 2024 12:44:16 -0400
Message-ID: <CAHC9VhTck26ogxtTK-Z_gxhhdfYR4MgHystKdWttjsXcydyB9A@mail.gmail.com>
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

On Mon, Sep 9, 2024 at 12:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Sep 8, 2024 at 2:11=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> >
> > On Wed, Aug 21, 2024 at 12:32:17PM -0400, Paul Moore wrote:
> > > On Wed, Aug 21, 2024 at 5:56=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> > > >
> > > > The fcntl's F_SETOWN command sets the process that handle SIGIO/SIG=
URG
> > > > for the related file descriptor.  Before this change, the
> > > > file_set_fowner LSM hook was always called, ignoring the VFS logic =
which
> > > > may not actually change the process that handles SIGIO (e.g. TUN, T=
TY,
> > > > dnotify), nor update the related UID/EUID.
> > > >
> > > > Moreover, because security_file_set_fowner() was called without loc=
k
> > > > (e.g. f_owner.lock), concurrent F_SETOWN commands could result to a=
 race
> > > > condition and inconsistent LSM states (e.g. SELinux's fown_sid) com=
pared
> > > > to struct fown_struct's UID/EUID.
> > > >
> > > > This change makes sure the LSM states are always in sync with the V=
FS
> > > > state by moving the security_file_set_fowner() call close to the
> > > > UID/EUID updates and using the same f_owner.lock .
> > > >
> > > > Rename f_modown() to __f_setown() to simplify code.
> > > >
> > > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Cc: Jann Horn <jannh@google.com>
> > > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > ---
> > > >
> > > > Changes since v2:
> > > > https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
> > > > - Only keep the LSM hook move.
> > > >
> > > > Changes since v1:
> > > > https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
> > > > - Add back the file_set_fowner hook (but without user) as
> > > >   requested by Paul, but move it for consistency.
> > > > ---
> > > >  fs/fcntl.c | 14 ++++----------
> > > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > >
> > > This looks reasonable to me, and fixes a potential problem with
> > > existing LSMs.  Unless I hear any strong objections I'll plan to merg=
e
> > > this, and patch 2/2, into the LSM tree tomorrow.
> >
> > I didn't see these patches in -next, did I miss something?
> > Landlock will use this hook really soon and it would make it much easie=
r
> > if these patches where upstream before.
>
> Ah!  My apologies, I'll do that right now and send another update once
> it's done.  FWIW, I'm going to tag 1/2 for stable, but since we are at
> -rc7 presently I'll just plan to send it during the next merge window.

Merged into lsm/dev, thanks for the nudge :)

--=20
paul-moore.com


Return-Path: <linux-fsdevel+bounces-12412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419FF85EE1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D1EB23D8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF86D10A1A;
	Thu, 22 Feb 2024 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AWuD0seQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2EF512
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562238; cv=none; b=k703FNZviTfgyuZtMQOgAR+K3BTtw0yDo9CdDGAzK/LPjwtbApA4oXNbaueT3P3OmDt5u3ODMdF1kJymY4L7KZq1kUNHluweLB7x8F7bCzr9fuxJ24n/UjSWBiGvawPrqH62ZD/vGNuFKk0mwrYwe0oNb9qAJIKiacpi3mErI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562238; c=relaxed/simple;
	bh=7DLu0D8bl4lB3TJjeIvbjOxLuBH7rI9+0zdimRyeniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+FLJ8MdPi5NSzMVaB0WIs2f8Xol7d8RSXID0DeOIU1kS2f4zRS5rAiUrN14R4/avPjXymV+qcOWHN/NtHmB8NamswPN1Md5JEY0r0c+r5dJZ58m/dORCr92jdVr+S0KxX989XMbpRNoocXNlNA0kx+DYJYC/FY3mA62lHIop+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AWuD0seQ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1315360276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 16:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708562235; x=1709167035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwPQ5FFRE9HZKwgqe28p5vX79kU4E42ICEiVSyqmmE4=;
        b=AWuD0seQuxSM2pg0KIzolmz4hQH1C41vVmswetXZTFhY3U9URmpE2Pgb7noqrjhFS0
         VJk3Sl6DDsdf6yJRWe6gnSmX7JEYNgaVCjwPIvzOOdSCm56/FDqMunkl3DljsKWg3pcF
         I0z2wtASZJeVNgrB8l6qlNHv1CKzgv7O6GGe8c9usAFQGmJGvXuolkvHh8EtXq+6VFJp
         /1H2mU21yxv0IShaoj69664uEYmfuDXQTPysbdZeyzHmPZe+H89Zuzk/lLgGlTUBOW1R
         5PV2VZZtF11n/6oLieojmDAtTLBF2pYFzJxIXlczJcHYGaxDe1x5Yy6r/ufCQWwGqQxT
         jxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562235; x=1709167035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwPQ5FFRE9HZKwgqe28p5vX79kU4E42ICEiVSyqmmE4=;
        b=GjQTL2QhMSWYvgyn1C9v2ialrLchPiueI8Bw642AvYQqdIhwH8ZnlGHknNpICssm/f
         u8r0wAtQ3EzhNCEzsZ0FVgKeuvsrMHpKwfVmEVfHcCD9rlEc6bahQbYtr7fahe5BAHKK
         +37M8uukj3vSct618y4aHUXKxizoU6DSTIxcXjYqvLcqgMZmm48t787TfbTw+sosoTdH
         UwsnBD651pP2nBJ6n/l+DR7QqrdOh3VTQ4pjEREe1pAV+C9SnrS0kay28ZZxCh3X1823
         DnhGVbWBGUIQUYxjTOuV/8faOgXZSSY8kxnbRw+atcoffYs1lPDVQWy12TiHNsrgXZnZ
         vNug==
X-Forwarded-Encrypted: i=1; AJvYcCVOOnjxYw647yVfRD9Mv8/fT6uJ3eTE45MHu8D1pik2roVYzXoUKoLHl/h77cPpEZ/GJenaFzvpOhuOFxykGRQsfkuJz2eQLaUbwQAUMg==
X-Gm-Message-State: AOJu0YxPEhtc9o6EGrJf/VN34xu1Snr/un10a3R7IgV6kx4y5WWZ1i2z
	wweuuiqDLOGAawX3nEV+1jxe4mwpfzot5r9uTEu3NWnYqIvQw+NmRUdho0sB7rHgKG+X66m6Xvr
	1m/B6cVODwbupMUs1/oE9zEZ6+syeKZ+3k1pp
X-Google-Smtp-Source: AGHT+IGAQ7Reayqcx5n6/kxK9gU1bvXz8FuxziZlj261BGCiV7fv0a2bbFUmVeZ6atHIXCyxpJlOV4CfjUbIVyi2enc=
X-Received: by 2002:a25:cec1:0:b0:dcc:eb38:199c with SMTP id
 x184-20020a25cec1000000b00dcceb38199cmr971381ybe.56.1708562235099; Wed, 21
 Feb 2024 16:37:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-15-3039364623bd@kernel.org>
 <CAHC9VhRQ7Xa2_rAjKYA_nkpmfUd9jn2D0SNcb6SjQFg=k8rn=w@mail.gmail.com> <ZdaTPV/Ngd8ed/p5@do-x1extreme>
In-Reply-To: <ZdaTPV/Ngd8ed/p5@do-x1extreme>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Feb 2024 19:37:04 -0500
Message-ID: <CAHC9VhS8h-A61b8DzbOBSxSH6WBDZkHBQGuT=DVq1n5gHfx6jA@mail.gmail.com>
Subject: Re: [PATCH v2 15/25] security: call evm fscaps hooks from generic
 security hooks
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 7:20=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
> On Wed, Feb 21, 2024 at 06:43:43PM -0500, Paul Moore wrote:
> > On Wed, Feb 21, 2024 at 4:25=E2=80=AFPM Seth Forshee (DigitalOcean)
> > <sforshee@kernel.org> wrote:
> > >
> > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > ---
> > >  security/security.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > First off, you've got to write *something* for the commit description,
> > even if it is just a single sentence.
> >
> > > diff --git a/security/security.c b/security/security.c
> > > index 0d210da9862c..f515d8430318 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -2365,9 +2365,14 @@ int security_inode_remove_acl(struct mnt_idmap=
 *idmap,
> > >  int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry=
 *dentry,
> > >                               const struct vfs_caps *caps, int flags)
> > >  {
> > > +       int ret;
> > > +
> > >         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > >                 return 0;
> > > -       return call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps=
, flags);
> > > +       ret =3D call_int_hook(inode_set_fscaps, 0, idmap, dentry, cap=
s, flags);
> > > +       if (ret)
> > > +               return ret;
> > > +       return evm_inode_set_fscaps(idmap, dentry, caps, flags);
> > >  }
> > >
> > >  /**
> > > @@ -2387,6 +2392,7 @@ void security_inode_post_set_fscaps(struct mnt_=
idmap *idmap,
> > >         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > >                 return;
> > >         call_void_hook(inode_post_set_fscaps, idmap, dentry, caps, fl=
ags);
> > > +       evm_inode_post_set_fscaps(idmap, dentry, caps, flags);
> > >  }
> > >
> > >  /**
> > > @@ -2415,9 +2421,14 @@ int security_inode_get_fscaps(struct mnt_idmap=
 *idmap, struct dentry *dentry)
> > >   */
> > >  int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct den=
try *dentry)
> > >  {
> > > +       int ret;
> > > +
> > >         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> > >                 return 0;
> > > -       return call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
> > > +       ret =3D call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
> > > +       if (ret)
> > > +               return ret;
> > > +       return evm_inode_remove_fscaps(dentry);
> > >  }
> >
> > If you take a look at linux-next or the LSM tree's dev branch you'll
> > see that we've gotten rid of the dedicated IMA and EVM hooks,
> > promoting both IMA and EVM to "proper" LSMs that leverage the existing
> > LSM hook infrastructure.  In this patchset, and moving forward, please
> > don't add dedicated IMA/EVM hooks like this, instead register them as
> > LSM hook implementations with LSM_HOOK_INIT().
>
> Yeah, I'm aware that work was going on and got applied recently. I've
> been assuming this change will go in through the vfs tree though, and I
> wasn't sure how you and Al/Christian would want to handle that
> dependency between your trees, so I held off on updating based off the
> LSM tree. I'm happy to update this for the next round though.

Okay, good, I just wanted to make sure you were aware of the changes.
Since the merge window is only a couple of weeks away I'm guessing
this isn't something we'll need to worry about in Linus' tree as the
LSM/IMA/EVM changes are slated to go up during the next merge window
and I'm guessing this will likely go in after that, targeting the
following merge window at the earliest.

--=20
paul-moore.com


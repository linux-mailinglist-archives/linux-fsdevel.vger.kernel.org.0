Return-Path: <linux-fsdevel+bounces-12404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177585EDD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548381C22B15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4794BA56;
	Thu, 22 Feb 2024 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MHY5O+XQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69325881F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561161; cv=none; b=VTgyKM/DE+Q27J4cpUjeT2QKSM5B2cpkXUMvjvTdhhqaravd/YQ2BLObFjL+Zxp6dFb+8/VmouSDpOV/78lWhzTzgH6VRnZT4mcrUPP81GpQDZ1n7YZ5Dgnq55p7K7sKkTUEd6I7i2lsgz5ygqqcaqLDBSR3KOiN7OVb8srjng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561161; c=relaxed/simple;
	bh=YI3P7HeQYLh9u7/Ubmalb2dwpwldBv2QjTTYBegsd9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBrlCDXQIj+kxX/3TDtyIrqlKBqGp57dFMMr0oE735xjoIeA8UA2DqNy8+zSsXT2PE3dFzRxtnuOexBUIyXmLeiRHyBRYbA9FUROrwRaZwtfBvG73mCKQsBJ5U1IDgysWE58NBIIPMqK56DD17hZDEQSpE+XyLtoK56hgZditxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MHY5O+XQ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed0710c74so5242046276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 16:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708561158; x=1709165958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7oaGryxbVrUL2E+pOOS5V370VmMkOZfbF1VgDo0Va8=;
        b=MHY5O+XQpYqBFmZskum/pRe153fd0o4QAVq/T21KW9KNGfS+LP7cxNUe0hRvKZwhJj
         fN4MXtfNfczIcAFGWl686biDxSpZ/bOJYQ2u43UC7FqWgi2DXz9M7y2OSjbKZEtjjrxP
         sjiZvMg4iH5UYkqz2iMtSaJ5URne0cFb0f3NUJ2PFoVnDVDxO7e5TymJtqQwIgNwmVFl
         N+55ebpHYQwUzYmZ6bj6udOdtiUFCz5M2NSR7NyW6IYuZwdyL2oMBQHXgyyKiCmc+0FC
         5IUS2arojCcGGF64/Vtx08f1dZTEfXwiZ5GoKqSqqq0AvSG3SjW9SYumzHJL6Hr5zzsP
         o8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561158; x=1709165958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7oaGryxbVrUL2E+pOOS5V370VmMkOZfbF1VgDo0Va8=;
        b=n1TkSu8bKetDxJdE1jmo7y9rXwsrgDdriwrjicbdvFfDmkKknnq+NYdk8EAJjIF5Og
         UhnV1zZJsMqSl+z1p6vIorlvcrOmVlXKw4dsqw0Di8AICclCEjegugzWcOE7m7z8gnXn
         eMJR/1MyE8QRLfAcGpPGNAyi5kE2agZUrhtzA96/2wVvN7NS/j+JtLLj/QtWpft6SsYT
         LZelrn0MVgww+cNZ85hEVDQye/57F7pkQf0o6oHiBizLqrftQS+w7XT55P0ZsWaC5TIr
         Jc9NtCsmd47DpO0eX0ThlbYi80m6qtbDMNLEBijCjDcqRExM26Mqnk7JERxJX5DakRBv
         xZZg==
X-Forwarded-Encrypted: i=1; AJvYcCXCW8Uo/brRWugofWumVEFihSX5ZP6JsEZZ7f1cfOA4jepr32uTMvZUQ699jj+T0hNLURueQRIyIgXnl4jbbeSjYru1qPZlftq8Gf+qgw==
X-Gm-Message-State: AOJu0Yw+Z96Vhf0gM4zB1tkuycgGt5EF6242xHqPL+0t5kRkfFELJvOp
	fNI8t1mawDg6iiyp2cDjTl8kRqaYiL9UCJe+oUuyjZK8iqXsRPxg8Q7d+a6FfCuIaWOd9FpG7Mm
	vKBLBVaqstbg+uuPMhDs2475KV09tfJQnkeGn
X-Google-Smtp-Source: AGHT+IFK00AsHyxPzzCDY0kk3tyWl4bPtLiUwg7CqJFm0cmNqsbd/HN5372LsPp9wqFO4GAU+yi44PLCDuVyd+D/FRs=
X-Received: by 2002:a25:2183:0:b0:dc2:2d0a:4d55 with SMTP id
 h125-20020a252183000000b00dc22d0a4d55mr711081ybh.63.1708561158458; Wed, 21
 Feb 2024 16:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-12-3039364623bd@kernel.org>
 <CAHC9VhTgHP=3Te4=t6chGte15CA_tMoVjFuzBwh+FxQ6Ri4mQQ@mail.gmail.com> <ZdaRBBU6K3nvklPI@do-x1extreme>
In-Reply-To: <ZdaRBBU6K3nvklPI@do-x1extreme>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Feb 2024 19:19:07 -0500
Message-ID: <CAHC9VhRr-AO2qrK3ZttsVMsQcJNhZThS7P5_i9dDC7tGPHdVAA@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] selinux: add hooks for fscaps operations
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

On Wed, Feb 21, 2024 at 7:10=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
> On Wed, Feb 21, 2024 at 06:38:33PM -0500, Paul Moore wrote:
> > On Wed, Feb 21, 2024 at 4:25=E2=80=AFPM Seth Forshee (DigitalOcean)
> > <sforshee@kernel.org> wrote:
> > >
> > > Add hooks for set/get/remove fscaps operations which perform the same
> > > checks as the xattr hooks would have done for XATTR_NAME_CAPS.
> > >
> > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > ---
> > >  security/selinux/hooks.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index a6bf90ace84c..da129a387b34 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3367,6 +3367,29 @@ static int selinux_inode_removexattr(struct mn=
t_idmap *idmap,
> > >         return -EACCES;
> > >  }
> > >
> > > +static int selinux_inode_set_fscaps(struct mnt_idmap *idmap,
> > > +                                   struct dentry *dentry,
> > > +                                   const struct vfs_caps *caps, int =
flags)
> > > +{
> > > +       return dentry_has_perm(current_cred(), dentry, FILE__SETATTR)=
;
> > > +}
> >
> > The selinux_inode_setxattr() code also has a cap_inode_setxattr()
> > check which is missing here.  Unless you are handling this somewhere
> > else, I would expect the function above to look similar to
> > selinux_inode_remove_fscaps(), but obviously tweaked for setting the
> > fscaps and not removing them.
>
> Right, but cap_inode_setxattr() doesn't do anything for fscaps, so I
> omitted the call. Unless you think the call should be included in case
> cap_inode_setxattr() changes in the future, which is a reasonable
> position.

Fair enough, but I'd be a lot happier if you included the call in case
something changes in the future.  I worry that omitting the call would
make it easier for us to forget about this if/when things change and
suddenly we have a security issue.  If you are morally opposed to
that, at the very least put a comment in selinux_inode_set_fscaps()
about this so we know who to yell at in the future ;)

--=20
paul-moore.com


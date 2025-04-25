Return-Path: <linux-fsdevel+bounces-47373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04778A9CC96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABEF5A1244
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B3270575;
	Fri, 25 Apr 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU2B+BtB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C933274662;
	Fri, 25 Apr 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594100; cv=none; b=PCpQjCb/PR5ME8bh8rNRAa2USgRrTN6SlCVT4hZNCk/EXMi6sNAPK381rTwDcE4ec2PvDAVv/nDT38ZBqttjCDf3caxLNSQUnI9Xl0m+fh55wLsfRw3wH9j4cY84zHqGzjc8+eELppbzc3DX1yglzmvrH5hIwqy8jqkQSU/Iwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594100; c=relaxed/simple;
	bh=y23ZVPGVcTitl6yU4MxdmIYNLFF7uoP5dxp4sp9DaKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPU7BLmgcm84NYToAJ3r2ie9wGB9SB21Kdz9Wz67revl+DeIY7w+rH3MJ99BfSZ6/0AkE7RvRv2tdgQaoSplqan9tLOugbr91IyCwx1Cea+UvmnAdFUr/jQjbwYdZ8jv6rVhPTk2+7vZJUjbjOaIYBbpamUwoKtF8RvH8WH6aGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU2B+BtB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227914acd20so30503145ad.1;
        Fri, 25 Apr 2025 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745594098; x=1746198898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MbIsWkT2PPGddqwQtyenmGVRw/Qqkpli16lpvi3GR0=;
        b=XU2B+BtBTkayA10RMpw7vfhFmTebHAnZiZG14THxsjEl2z4u4TpHsHNiQIwPljpZ3b
         BeXo4nFs23p+oJJs8FIlMxUWTRRkz7eFxhEs2PfKUkTEqqCXrnxHclDGr8/gBEsHfHHe
         dJQmtThY4C9yTy0KrVdG97jhCv+gapsBypYEc/mRwtCZS5yThffi/GUZQ6Ls85/4ZODO
         6gqUDOS0aqnO6rDuxA5FcwazHbo7Lp54cXgcUSxLMQgPfgw60Pgk4PSbvd1evAzk2ux4
         Ri3tSK2r1VQ0tQ4gxoTwfPRUDffKPLyWyMO8LWT2yivOVSbOlpfn/XDHY5DF0OCWF3q5
         FuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745594098; x=1746198898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MbIsWkT2PPGddqwQtyenmGVRw/Qqkpli16lpvi3GR0=;
        b=EjxO4xRU0tl8bt2NsGHim0/wbbSrkDBfHZzavBHSwiljadt46GIvaHnKUln/P3boD0
         nQ1bFG24XVRzunSzP3z14p9H7tVlD9M/BTtXS65Sd7mzgppPbdqc7SjOFMuWJ2X7Gu0g
         p0HAABpmx4iiod6XhappyEtBnOY4E5S07xXb60arCcKgWAHZnZLWnKLjST151HQlebDI
         J6/eTykWzVL3f+BN2OnUc9x7IyIq8jSH6lkapuwZrCigIw2jWf2a6G7Wug1pL65G+9Ko
         roFwbK1MZBYqRqqhnvT3UiWnSW+T2YFnK87MsTFfZvjn5NEV/jCNtflZmalUz2ZBFk0O
         wjEA==
X-Forwarded-Encrypted: i=1; AJvYcCUgsAqv203nvjQkQfFXiqy5fIId1Q2F1qfyVZRaa5lLEYZ2ydtdzGduoWBLX12BE+eIk/htCj8BBiE2ZATLYvqgF5o5f3sx@vger.kernel.org, AJvYcCUsN+Qh6Vaf5dV5NM2IL6yP7lfbMDDi3qDgBKhMc0Y9g/toGX+pNxE2ElX/T8iGv8MnkvI3qakDLG0XTfMA@vger.kernel.org, AJvYcCVCaoz+mFISAsIZWwKUMGcbVVPmgv2hoeGjW9bBqx/DZG+TadlvYiwNalcoD79CmJDffwurJlpROw==@vger.kernel.org, AJvYcCXxP3PRLJC4p6y0daqvT95ZwKj9Rm6ehPIeSpTcDTd0ifxtkLm+oSx9rUqjWB30Nmyv4N9fAGh5+OyURbze@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6vu+b4b8VMCX34X6EuaCJJH01GF9grcqrxTGoHB1sNpgpnX7
	m9yDWBZ4psXPsR+8yrpPOsSxFywenWpzy6YGXW7teTrgYGrCCpW5ksfm/f/wYPpxl+W4UW3+kuj
	MlShPfHLgN9LHwILTE0CYmiSYo7k=
X-Gm-Gg: ASbGncsNK1/dg6kPBRErFMa1UKiEfYjD2/r/oa5yhg7NkyoOC3WZjPajvFbNNGA/sZZ
	w/iLEd7rVJ90h1PzY2E6Iw6cW+wvNNVwYu9QQC/pzX/06sXkH5mf/eAhNaE4aeuKHyaOGNVoN5I
	kLqw7T71gz6lA4EkmpEeKKKw==
X-Google-Smtp-Source: AGHT+IEtVX13MpKP47aS7whL3XKhn2KCCn5rHkVnZWX4At2Rfu+6bJEe3mUbY8+ozgrDXBiXZkRhZVpx0PZDZoPflLM=
X-Received: by 2002:a17:902:e5d1:b0:21f:6f33:f96 with SMTP id
 d9443c01a7336-22db47c9cefmr78622445ad.6.1745594097600; Fri, 25 Apr 2025
 08:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424152822.2719-1-stephen.smalley.work@gmail.com> <20250425-einspannen-wertarbeit-3f0c939525dc@brauner>
In-Reply-To: <20250425-einspannen-wertarbeit-3f0c939525dc@brauner>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Apr 2025 11:14:46 -0400
X-Gm-Features: ATxdqUFoaGk9OHJ0N5v_7u7M2tLmdB4Wyi7K0hWeHlvABdGu57_MpkHYXb2Skyc
Message-ID: <CAEjxPJ4vntQ5cCo_=KN0d+5FDPRwStjXUimE4iHXJkz9oeuVCw@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list to always include
 security.* xattrs
To: Christian Brauner <brauner@kernel.org>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:20=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 24, 2025 at 11:28:20AM -0400, Stephen Smalley wrote:
> > The vfs has long had a fallback to obtain the security.* xattrs from th=
e
> > LSM when the filesystem does not implement its own listxattr, but
> > shmem/tmpfs and kernfs later gained their own xattr handlers to support
> > other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
>
> This change is from 2011. So no living soul has ever cared at all for
> at least 14 years. Surprising that this is an issue now.

Prior to the coreutils change noted in [1], no one would have had
reason to notice. I might also be wrong about the point where it was
first introduced - I didn't verify via testing the old commit, just
looked for when tmpfs gained its own xattr handlers that didn't call
security_inode_listsecurity().

[1] https://lore.kernel.org/selinux/CAEjxPJ6ocwsAAdT8cHGLQ77Z=3D+HOXg2KkaKN=
P8w9CruFj2ChoA@mail.gmail.com/T/#t

>
> > filesystems like sysfs no longer return the synthetic security.* xattr
> > names via listxattr unless they are explicitly set by userspace or
> > initially set upon inode creation after policy load. coreutils has
> > recently switched from unconditionally invoking getxattr for security.*
> > for ls -Z via libselinux to only doing so if listxattr returns the xatt=
r
> > name, breaking ls -Z of such inodes.
>
> So no xattrs have been set on a given inode and we lie to userspace by
> listing them anyway. Well ok then.

SELinux has always returned a result for getxattr(...,
"security.selinux", ...) regardless of whether one has been set by
userspace or fetched from backing store because it assigns a label to
all inodes for use in permission checks, regardless.
And likewise returned "security.selinux" in listxattr() for all inodes
using either the vfs fallback or in the per-filesystem handlers prior
to the introduction of xattr handlers for tmpfs and later
sysfs/kernfs. SELinux labels were always a bit different than regular
xattrs; the original implementation didn't use xattrs but we were
directed to use them instead of our own MAC labeling scheme.

>
> > Before:
> > $ getfattr -m.* /run/initramfs
> > <no output>
> > $ getfattr -m.* /sys/kernel/fscaps
> > <no output>
> > $ setfattr -n user.foo /run/initramfs
> > $ getfattr -m.* /run/initramfs
> > user.foo
> >
> > After:
> > $ getfattr -m.* /run/initramfs
> > security.selinux
> > $ getfattr -m.* /sys/kernel/fscaps
> > security.selinux
> > $ setfattr -n user.foo /run/initramfs
> > $ getfattr -m.* /run/initramfs
> > security.selinux
> > user.foo
> >
> > Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=3DiOawX4y77=
ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> > Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.sma=
lley.work@gmail.com/
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  fs/xattr.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 02bee149ad96..2fc314b27120 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
> >       return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_=
LEN);
> >  }
> >
> > +static bool xattr_is_maclabel(const char *name)
> > +{
> > +     const char *suffix =3D name + XATTR_SECURITY_PREFIX_LEN;
> > +
> > +     return !strncmp(name, XATTR_SECURITY_PREFIX,
> > +                     XATTR_SECURITY_PREFIX_LEN) &&
> > +             security_ismaclabel(suffix);
> > +}
> > +
> >  /**
> >   * simple_xattr_list - list all xattr objects
> >   * @inode: inode from which to get the xattrs
> > @@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, s=
truct simple_xattrs *xattrs,
> >       if (err)
> >               return err;
> >
> > +     err =3D security_inode_listsecurity(inode, buffer, remaining_size=
);
>
> Is that supposed to work with multiple LSMs?
> Afaict, bpf is always active and has a hook for this.
> So the LSMs trample over each other filling the buffer?

There are a number of residual challenges to supporting full stacking
of arbitrary LSMs; this is just one instance. Why one would stack
SELinux with Smack though I can't imagine, and that's the only
combination that would break (and already doesn't work, so no change
here).

>
> > +     if (err < 0)
> > +             return err;
> > +
> > +     if (buffer) {
> > +             if (remaining_size < err)
> > +                     return -ERANGE;
> > +             buffer +=3D err;
> > +     }
> > +     remaining_size -=3D err;
>
> Really unpleasant code duplication in here. We have xattr_list_one() for
> that. security_inode_listxattr() should probably receive a pointer to
> &remaining_size?

Not sure how to avoid the duplication, but willing to take it inside
of security_inode_listsecurity() and change its hook interface if
desired.

>
> > +
> >       read_lock(&xattrs->lock);
> >       for (rbp =3D rb_first(&xattrs->rb_root); rbp; rbp =3D rb_next(rbp=
)) {
> >               xattr =3D rb_entry(rbp, struct simple_xattr, rb_node);
> > @@ -1468,6 +1488,10 @@ ssize_t simple_xattr_list(struct inode *inode, s=
truct simple_xattrs *xattrs,
> >               if (!trusted && xattr_is_trusted(xattr->name))
> >                       continue;
> >
> > +             /* skip MAC labels; these are provided by LSM above */
> > +             if (xattr_is_maclabel(xattr->name))
> > +                     continue;
> > +
> >               err =3D xattr_list_one(&buffer, &remaining_size, xattr->n=
ame);
> >               if (err)
> >                       break;
> > --
> > 2.49.0
> >


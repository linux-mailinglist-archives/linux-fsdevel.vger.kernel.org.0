Return-Path: <linux-fsdevel+bounces-65536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8764C07565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F073A7A7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7D26ED2D;
	Fri, 24 Oct 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH/qH/yG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F62264C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323609; cv=none; b=gb2mrF5qGAN22u16nvKwbU0v99pKPPEF3sJoj1bhsfpiPQXx6TncQOZfLwTGjFWMEaAPJcEZ0rMVW77FkW/yeF35H1SNIQDpSxYfXjD7TglXjuH1rj+URW2ZAMNcL6kKimV5FffbqAGDlJb7lMF5yR/chBjS9WVVXKa1fvJ7iYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323609; c=relaxed/simple;
	bh=I/rphTZwOq9V/qBdMZVXIAUVeQYsdrGVZoJgfJbCu5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNSWX3qVrK6sKkRvbnl4y16nynkLf93ANHOuhe10GGWK/9mFE/HjfOxjcLOE/nu5Ph2sIkiOdgmaR/fqhH9nJ9qAYb/VoT+k5iA2X4BPuw0A/R1dxwmbwsz9K00qZjN4vH3PnAK9oYsVHD6f+SDGMOakTDXZuzm0cjYkax0SqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH/qH/yG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so3666186a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761323606; x=1761928406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6RZa0e8kC9rcuKvg9IwDJV3wJWrztBGC4/5CmpBBH8=;
        b=mH/qH/yG+8AfzIW5hjsW2vbCcvC3ltDmZ6l5G2s9VH7FfLnPPIrQaEFCck9uzQe3ec
         Tg8EX2jA22oK4iXekTLxv7My+mcSM0vPUh0RbRnOLkyn9g5D/SBlZ07GLVSrzplSCKfv
         cJdNMaASNVIce+3y+xWBOTW0Bn3gEym8TUW6mAm7wVoXaGulTakFMGrR1H/TnQ8bD7h4
         UBN/Bw62eZePNmneXsIjmOaFFfk5zMrPeLGykl5mQP9bcav+fJFokCChnHQGOzx51E6r
         eycf9pZFd7gL2W34nmV/BVhDHekkNdj4SJIwPtiIu5juRPuNteBAValJi3XQt4L3gGB3
         8vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323606; x=1761928406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6RZa0e8kC9rcuKvg9IwDJV3wJWrztBGC4/5CmpBBH8=;
        b=gagdtR2zgoH9jmzgsqsH+lur5+BQjtp3TFveM5G5Zy7gGnPp7gYlZ/qg9L4QBe7FGU
         XUY6kGDc+wXN5NUlmkAB+87Eeb5089ESB3G4fre4QRmDoQPBah6SMIkvmzYpAmpX+kDg
         KQ+i0nYc87+vj+HItMVqpd9FJc7o3XInN3iKmn+gat8HveBLBYSZI3NOqk4TUgab1qpM
         t5pIjqhFgSXky6Alui3xdr/dsqT5cvwdIPKcUpMhK4Jc+HP2IW11xjYfsNaCvAmz8sU7
         R3UhvkCjA63GdS1huBwBmhn/WJBHObdX5xMKKVihuhSqlzQCOUavqDUUy40AB10L4GqK
         +78w==
X-Forwarded-Encrypted: i=1; AJvYcCUzuRRGu7Ri227RVNsmTMXyCH8UKs/bn2Etyn/3y7xH7mN10hjBmH0aTklevzX3vlOyzaZItgxeqC2p5bpH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ch18mzjcMl99zW0LleftD+DF41ShBYv64yDffnQO9/Aq02iJ
	tWqXs4XCGwYjFrVUP0g0C91E8r5kA/wDE++NAsj9sZXKz0m5XFJO63aoYPcxfoOrtZTKKTRmD2L
	7cIhdnXp9xiwOE6fBN53Dx/2/Y4EmRTuVihCQ
X-Gm-Gg: ASbGncs3mfXJ6JXnqc0rebSq4xYEa7fhoEYkhCDsnOslFn21gzQDG7BPs0SW/awvoB9
	nmrZnr9qtV5lhSQKK/of+Q2D3/7e1Z/5AacgjdyVsCpZ2ilmeKg265g5/IfIxh+yaZdMJ962PT9
	dYuEjw4oqTOUkd/AW7mBc+EYqV+xZ2EavUSP6ABdMtT3uoHcjlTIvF8FGnmbP/RMPz5w0O+yxjI
	FwNtJ8U6daWtw+5ZJ9e2H0H+n048p4vyIh6KT0c3Iq3TRIpYEMiyHROuouDtjNM9L4TbkDmTb3d
	R0bf42tWJ011Eqse2W0=
X-Google-Smtp-Source: AGHT+IFfeWIyHmIfMT0OewMP1kHLql9mT1xoCrSdn0COOqaLS+rNY6hSh2OoGI7Pc2dCMgVA40OBm5O3g5QnqLoC5WA=
X-Received: by 2002:a05:6402:1e8f:b0:636:9129:882f with SMTP id
 4fb4d7f45d1cf-63c1f6e1e4dmr27350682a12.30.1761323605666; Fri, 24 Oct 2025
 09:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022044545.893630-1-neilb@ownmail.net> <20251022044545.893630-10-neilb@ownmail.net>
 <CAOQ4uxhExX9SiKVRyf=GHhNy-f8O=KH-oDS3=efLinXC8E=ekA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhExX9SiKVRyf=GHhNy-f8O=KH-oDS3=efLinXC8E=ekA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Oct 2025 18:33:14 +0200
X-Gm-Features: AWmQ_bnuV5aGWbmGez8sUhyEKU7jXOnxDMYssBzRdhHU1Z24nBprXeWQw-SMU60
Message-ID: <CAOQ4uxgzceK-RJd3rN8pBSBf1Oo0u8wd6KSfdiKQSTF1RUuzXw@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Wed, Oct 22, 2025 at 6:47=E2=80=AFAM NeilBrown <neilb@ownmail.net> wro=
te:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > start_renaming() combines name lookup and locking to prepare for rename=
.
> > It is used when two names need to be looked up as in nfsd and overlayfs=
 -
> > cases where one or both dentries are already available will be handled
> > separately.
> >
> > __start_renaming() avoids the inode_permission check and hash
> > calculation and is suitable after filename_parentat() in do_renameat2()=
.
> > It subsumes quite a bit of code from that function.
> >
> > start_renaming() does calculate the hash and check X permission and is
> > suitable elsewhere:
> > - nfsd_rename()
> > - ovl_rename()
> >
> > In ovl, ovl_do_rename_rd() is factored out of ovl_do_rename(), which
> > itself will be gone by the end of the series.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > --
> > Changes since v2:
> >  - in __start_renaming() some label have been renamed, and err
> >    is always set before a "goto out_foo" rather than passing the
> >    error in a dentry*.
> >  - ovl_do_rename() changed to call the new ovl_do_rename_rd() rather
> >    than keeping duplicate code
> >  - code around ovl_cleanup() call in ovl_rename() restructured.
>
> Thanks for fixing those and for the change log.
>
> Feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
...
> > @@ -1299,18 +1285,22 @@ static int ovl_rename(struct mnt_idmap *idmap, =
struct inode *olddir,
> >                 err =3D ovl_set_redirect(new, samedir);
> >         else if (!overwrite && new_is_dir && !new_opaque &&
> >                  ovl_type_merge(old->d_parent))
> > -               err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
> > +               err =3D ovl_set_opaque_xerr(new, rd.new_dentry, -EXDEV)=
;
> >         if (err)
> >                 goto out_unlock;
> >
> > -       err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
> > -                           new_upperdir, newdentry, flags);
> > -       unlock_rename(new_upperdir, old_upperdir);
> > +       err =3D ovl_do_rename_rd(&rd);
> > +
> > +       if (!err && cleanup_whiteout)
> > +               whiteout =3D dget(rd.new_dentry);
> > +
> > +       end_renaming(&rd);
> > +
> >         if (err)
> >                 goto out_revert_creds;
> >
> > -       if (cleanup_whiteout)
> > -               ovl_cleanup(ofs, old_upperdir, newdentry);
> > +       if (whiteout)
> > +               ovl_cleanup(ofs, old_upperdir, whiteout);

missing
                       dput(whiteout);
                 }

This fixes the dentry leak I reported.

Thanks,
Amir.


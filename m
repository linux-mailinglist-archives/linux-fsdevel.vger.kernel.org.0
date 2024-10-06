Return-Path: <linux-fsdevel+bounces-31110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33456991D10
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B34F1C21469
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B121662E9;
	Sun,  6 Oct 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF0geazn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BAC4C8C;
	Sun,  6 Oct 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728201796; cv=none; b=o+NbTYqOuTj7fBu7IyF4EE7Xg2q5XUfDl7o9b8lTO08BtStRIMxDgKXJ29TQ6wPL0ehbBGyunXyk4bHJ9vrsRYocF8NMkhRSciGpjC/bznsHzf9uzt4XK5PpPMTcexwgzZn5+VC4uoycXi4obcZNMwKRxSt/5XJyIY7NAKZSr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728201796; c=relaxed/simple;
	bh=ix70sDrca7bshzBp+lnq8sHltIhOrOT26Ykc9Mbgqeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oC7EGK/gb8SVibr9CoEPjkdFAPuhjWN/oJIoBdS6U8lVL0Nqpy1LmRA4fzmYiJBpHAjZQsxb9Zg2EE747v1DT4i4/RpwPLTdV7SIyW1IeRBTrMIADSL3fvUvlpwNe5/BubSVSDYLsj+Bl7qrS6POAdnhZDRusxO7yM6lNi4ao/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF0geazn; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9aec89347so208314485a.0;
        Sun, 06 Oct 2024 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728201794; x=1728806594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbFQ2vun0udad/6oWS6Sdr38k5dXINkp2Xy5aKSJu0o=;
        b=hF0geaznWa7/5XoBwUz3TyE44ghxu4vrPmViCKUOsIcdyjLngtm9Aigikznb3ePJvB
         0Vlxus0E1AG72EogNJUQvSDoJ2TofpSJehH35j6KoAEsyN6uE5dAws4Y98e2wfRSgPZz
         EdDgl+Q7rCVam3Z9le/+qfY5COitC1quewixiCGRJllzLg0/BdbGLPsFvdN/YRwtQ1fL
         fV8dZgInmZvFsh5q0h38ZAFhpPtm9nRpgQy3ZKT22NREmSoUcyyWRKSANinpxWM7Jek8
         VtQdLeAhD2BnUKkjzL3KF+vrI3wE0l1yx8GPKU56DbibIuHABnqd+OYXeyxO3r58+OF0
         uE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728201794; x=1728806594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbFQ2vun0udad/6oWS6Sdr38k5dXINkp2Xy5aKSJu0o=;
        b=luMNiuN8mV3iRqwpe98xzO6sWH+R4D0sQKHi6RCR9oR6RaebKwEl5Uq05pPVfCFemk
         ToQT2dZ9EiP8KNH58DdOJpGUdvSkrTXbRIQv9mftCie2BgIF3xX6ZgkbetamfwXIcdsP
         Lbi9m45Rkub+7+VtOC64LJnPj8jMwb4RWbvB53DK3J1EAsSeIn8BoDAfp2nfD79ISDW0
         KkvrkX9v2gum6n9DuGQXd8LuA8gCJGdJ06gOWSPs7jjRoUin+nQiMCsDSQPCVO+fKjAW
         fUMZSc4jvxvmd2iz0Jmukej+3TBzXUlDthVy2i6bzS3iGFeK4VnGqToXO2cNOLY1kKnl
         zT2A==
X-Forwarded-Encrypted: i=1; AJvYcCVtrwaVQByHgeWI3Km2FR+9U2MHprjgVPI1j4oBPbXHsDXSL4rMQOni2u9AY+pVNgdYuVUg+KZcO8PE/55t@vger.kernel.org, AJvYcCWRllVLG0mOukGodQzdMVVrPUKeRACDRwxpRdhCUsTMCvTuh0HZuah2wlDYdd7+ol29DnkauP1IGYWTQRgl4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOi/CqujoAofxpQDtJpWsmu7f2s8+zNUSbGdyl6STbE4/+XWzq
	y+jF0TGzEW9LBJrJwbvdQZxArVJtTmdUQYiCO2TQ5X6aiHanXF5ODFMem3dOudQasi89/YKO+zQ
	bat3TS1FCqDdXG5LJ1DEIIR+42zg=
X-Google-Smtp-Source: AGHT+IEQjlw/LcL+/vynInug3EZeFKGTU1HJDxPUuLftgbExAwmvxkTThtarXh3goSw/0vONshQRV1DB1oDjSs+nlz4=
X-Received: by 2002:a05:620a:4002:b0:7a9:c406:eebd with SMTP id
 af79cd13be357-7ae6f48675emr1484773585a.42.1728201793677; Sun, 06 Oct 2024
 01:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004102342.179434-1-amir73il@gmail.com> <20241004102342.179434-2-amir73il@gmail.com>
 <20241004221625.GR4017910@ZenIV> <20241004222811.GU4017910@ZenIV>
 <20241005013521.GV4017910@ZenIV> <CAOQ4uxiqrHeBbF49C0OkoyQm=BqQjvUYEd7k8oinCMwCSOuP3w@mail.gmail.com>
 <20241005194926.GY4017910@ZenIV>
In-Reply-To: <20241005194926.GY4017910@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 6 Oct 2024 10:03:02 +0200
Message-ID: <CAOQ4uxhtZbrDcrncSm0-2ehs+LK_e7xqsAuhMRYcb2+tCpgcyg@mail.gmail.com>
Subject: Re: [PATCH 1/4] ovl: do not open non-data lower file for fsync
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 9:49=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sat, Oct 05, 2024 at 08:30:23AM +0200, Amir Goldstein wrote:
>
> > I understand your concern, but honestly, I am not sure that returning
> > struct fderr is fundamentally different from checking IS_ERR_OR_NULL.
> >
> > What I can do is refactor the helpers differently so that ovl_fsync() w=
ill
> > call ovl_file_upper() to clarify that it may return NULL, just like
>
> ovl_dentry_upper(), you mean?

No, I meant I created a new helper ovl_upper_file() that only ovl_fsync()
uses and can return NULL.
All the rest of the callers are using the helper ovl_real_file() which cann=
ot
return NULL.
I will post it.

>
> > ovl_{dentry,inode,path}_upper() and all the other callers will
> > call ovl_file_real() which cannot return NULL, because it returns
> > either lower or upper file, just like ovl_{inode,path}_real{,data}().
>
> OK...  One thing I'm not happy about is the control (and data) flow in th=
ere:
> stashed_upper:
>         if (upperfile && file_inode(upperfile) =3D=3D d_inode(realpath.de=
ntry))
>                 realfile =3D upperfile;
>
>         /*
>          * If realfile is lower and has been copied up since we'd opened =
it,
>          * open the real upper file and stash it in backing_file_private(=
).
>          */
>         if (unlikely(file_inode(realfile) !=3D d_inode(realpath.dentry)))=
 {
>                 struct file *old;
>
>                 /* Stashed upperfile has a mismatched inode */
>                 if (unlikely(upperfile))
>                         return ERR_PTR(-EIO);
>
>                 upperfile =3D ovl_open_realfile(file, &realpath);
>                 if (IS_ERR(upperfile))
>                         return upperfile;
>
>                 old =3D cmpxchg_release(backing_file_private_ptr(realfile=
), NULL,
>                                       upperfile);
>                 if (old) {
>                         fput(upperfile);
>                         upperfile =3D old;
>                 }
>
>                 goto stashed_upper;
>         }
> Unless I'm misreading that, the value of realfile seen inside the second
> if is always the original; reassignment in the first if might as well had
> been followed by goto past the second one.  What's more, if you win the
> race in the second if, you'll have upperfile !=3D NULL and its file_inode=
()
> matching realpath.dentry->d_inode (you'd better, or you have a real probl=
em
> in backing_file_open()).  So that branch to stashed_upper in case old =3D=
=3D NULL
> might as well had been "realfile =3D upperfile;".  Correct?  In case old =
!=3D NULL

Correct.

> we go there with upperfile !=3D NULL.  If it (i.e. old) has the right fil=
e_inode(),
> we are done; otherwise it's going to hit ERR_PTR(-EIO) in the second if.
>
> So it seems to be equivalent to this:
>         if (unlikely(file_inode(realfile) !=3D d_inode(realpath.dentry)))=
 {
>                 /*
>                  * If realfile is lower and has been copied up since we'd
>                  * opened it, we need the real upper file opened.  Whoeve=
r gets
>                  * there first stashes the result in backing_file_private=
().
>                  */
>                 struct file *upperfile =3D backing_file_private(realfile)=
;
>                 if (unlikely(!upperfile)) {
>                         struct file *old;
>
>                         upperfile =3D ovl_open_realfile(file, &realpath);
>                         if (IS_ERR(upperfile))
>                                 return upperfile;
>
>                         old =3D cmpxchg_release(backing_file_private_ptr(=
realfile), NULL,
>                                               upperfile);
>                         if (old) {
>                                 fput(upperfile);
>                                 upperfile =3D old;
>                         }
>                 }
>                 // upperfile reference is owned by realfile at that point
>                 if (unlikely(file_inode(upperfile) !=3D d_inode(realpath.=
dentry)))
>                         /* Stashed upperfile has a mismatched inode */
>                         return ERR_PTR(-EIO);
>                 realfile =3D upperfile;
>         }
> Or am I misreading it?  Seems to be more straightforward that way...

Yeh, that's a bit more clear without to goto, but I would not remove
the if (upperfile) assertion. Actually the first if has a bug.
It assumes that if the upperfile is stashed then it must be used, but
this is incorrect.

I have made the following change:

static bool ovl_is_real_file(const struct file *realfile,
                             const struct path *realpath)
{
        return file_inode(realfile) =3D=3D d_inode(realpath->dentry);
}
...
        /*
         * Usually, if we operated on a stashed upperfile once, all followi=
ng
         * operations will operate on the stashed upperfile, but there is o=
ne
         * exception - ovl_fsync(datasync =3D false) can populate the stash=
ed
         * upperfile to perform fsync on upper metadata inode.  In this cas=
e,
         * following read/write operations will not use the stashed upperfi=
le.
         */
        if (upperfile && likely(ovl_is_real_file(upperfile, realpath))) {
                realfile =3D upperfile;
                goto checkflags;
        }

        /*
         * If realfile is lower and has been copied up since we'd opened it=
,
         * open the real upper file and stash it in backing_file_private().
         */
        if (unlikely(!ovl_is_real_file(realfile, realpath))) {
                struct file *old;

                /* Either stashed realfile or upperfile must match realinod=
e */
                if (WARN_ON_ONCE(upperfile))
                        return ERR_PTR(-EIO);
...
                /* Stashed upperfile that won the race must match realinode=
 */
                if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
                        return ERR_PTR(-EIO);
               realfile =3D upperfile;
        }

checkflags:
...

What happens is that we have two slots for stashing real files
and there are subtle assumptions in the code that
1. We will never be requested to open a real file for more than
    two inodes (lower and upper)
2. If we are requested to open two inodes, we will always be
    requested to open the lower inode first
3. IOW if we are requested to open the upper inode first, we
    will not be requested to open a different inode

Therefore, the names realfile/upperfile are a bit misleading.
If file is opened after copyup, then the realfile in ->private_data
is the upper file and stashed upperfile is NULL.

I will post the revised version.

Thanks,
Amir.


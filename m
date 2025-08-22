Return-Path: <linux-fsdevel+bounces-58855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE297B322B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 21:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD453BD92C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE542C15B7;
	Fri, 22 Aug 2025 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiWhIYhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B84A1A;
	Fri, 22 Aug 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890268; cv=none; b=cvXz6/+lI9h380T6tzgjORC5+bInYDT/0QPyULXNUyMY8D8KiF+kBqtXPUCMNqpv00OrHyZkpRtFGdr2GuxEHKbCcqLIkHuDNMFRcgt4SNZvRHWkf3t1NPsZkp/hI+zHuNO/7szqVy96EX7dK2MnAocv1YE0O+l1n2jlncrCDpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890268; c=relaxed/simple;
	bh=wtmrm3SlogUZY0B6QIjgXv6Nxv/tDCgOKbQjkjBaS/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ptvy2IUVPO2m5tI4OBlLKRj05oWt4zf0mZU7WvrHPOcqmWwtih1scEBRdEe9PQavF2lDabQ4toI4aeG7CCmOtgZEZL/Mjg+tMbW+4NifMvIF17Ab7I75Pcp9oMdG5Ax1DnlPAW8oPqWnJggJ/rejIQRCzocwfwkBrSDbj8OBy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiWhIYhG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61c325a4da7so334634a12.0;
        Fri, 22 Aug 2025 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890265; x=1756495065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT8q3dFJx82OGrDjwv4DuH2nv0k4ZyhLsh1+5pGUjYw=;
        b=hiWhIYhG/7BXBSXGn0NWi+puQoustqJm4LzcxzUIf/RkBVSjLi5gd5N2H1UgtsLxzy
         P5ApHY+k+rhCTUNs0BOAbU8NEFguH4Xv3OTQ9jQJFxpySERvMfLpKxo0adq+H+OynGSR
         Z61ToNPUhCF9VJ1knARZ4EvTudg0VGgiLXG0Lo4uJlsgYUWqxxIXctOsKgzh3SJhx9Bf
         lRxtUJt1B3UGCQvUxJdwC7BmNM32yoTdh8HZLVKTTF9ELziERxwhWIDD5OtkObCqjWjJ
         uVdE5pXxh6tKkMNWm6P96gPLwBQ7J8uMQW3fK2C+aS0qjQ1bonhoSTb/0ICpfOeqob+R
         MbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890265; x=1756495065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT8q3dFJx82OGrDjwv4DuH2nv0k4ZyhLsh1+5pGUjYw=;
        b=blJm65/qRVhcf7qXHG1Gqc0YX/Wx37mbC2Hfr9+pXAWGExOzRpoGbxrbN2jyJRT1/x
         Jms0pRm2gKfISZbGaRHnkntKRPGJNqgge2KCASbSn9P+hA31U9tOvQFv8MbtHoZO8biN
         bcmPFmdIqIoEdAo38l10DiYglCS/gm6Pho2YZTx7Y9NgVwVnNLaCDH+vkmGrdBl4wSs3
         M7LbEeBMzBu26WVZ34UDTmidum9JoXKX00x7kIpSAO3LnE344eble19AHBbV94kwnx5m
         YtTLKrrmKwmF04CCUhKbIJpv32K3LPa3J4Ko94+N1MwJtnPScjQkic2u9bK5S9EuSy4W
         eCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVaPYHHcaPy/x+bZ7CBEi1mX7fGsVX9CuLrKbj22HXCYJkqLO3P2biWBkp/VqFwy6bAmoVjYPdlRVzTj13nQ==@vger.kernel.org, AJvYcCWxlUjamZkeWf7duj+A2WyKfYw0Jp3jh1hcnlp6BW8JEBlD0e5Q6fxvrFHWhEUBeFd5hMFhDyxqays05/wq@vger.kernel.org, AJvYcCXpAxElxSESLO9umUX319xSfpbRK6aT/PBQSl6ghDgXhqNwzLo/8KbrGBCDsnioavcSznWbOZ9SJBpWh7O9@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuEx2FTFhs7t1Yesczy8L4xhl0yLPy5XJ0HEzphTSrAZmRweq
	zDvN28n92edpCfVm1Y+AwWl4Ibhy6YVV2EAi9HVCFJfI5Q0tWmwCSVq/6vgHmjNcFIsCHa9+L0y
	61OwP6V8mD8wYDcKMSIlXUxoPQrOkQWo=
X-Gm-Gg: ASbGnct4rPoxLgkeildruv/Mu74qkAdwsP2sUPbncTMoM2EvxU5bBcwdpBjcfl1oYax
	a+1XfvI1/+PBMXFEVcjtaX1zATcVJ4JIRconnPYauxNk6XTh9jwG5nQUSAKtbFvCUXxjCKTCic7
	tRMxi3l+d0jTG9r/HQ3P9pB1/CZhBJRsxqNNf97UG0W7uMHXor8g2C8LDzWc94HK7K88Q7Aq8vG
	M0tLl4=
X-Google-Smtp-Source: AGHT+IHhmqoQvn0cd1f/XP4lUOTKGjfXbpQoBd+ct3x9NSbHCLHf6cPpl09ZK6p5eOK9Tv9ihmAOxpo1ctvyorl60YM=
X-Received: by 2002:a05:6402:358b:b0:618:6e15:d059 with SMTP id
 4fb4d7f45d1cf-61c1b6f3da7mr3070883a12.21.1755890264400; Fri, 22 Aug 2025
 12:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-9-8b6e9e604fa2@igalia.com> <CAOQ4uxhWE=5_+DBx7OJ94NVCZXztxf1d4sxyMuakDGKUmbNyTg@mail.gmail.com>
 <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com>
In-Reply-To: <62e60933-1c43-40c2-a166-91dd27b0e581@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Aug 2025 21:17:33 +0200
X-Gm-Features: Ac12FXxA4hDlRo2Zy9Q8fWppUIDFMO1wV5FDA9csi7wKgVOWLLI0oOtm44XjVCU
Message-ID: <CAOQ4uxjgp20vQuMO4GoMxva_8yR+kcW3EJxDuB=T-8KtvDr4kg@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:47=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 22/08/2025 13:34, Amir Goldstein escreveu:
> > On Fri, Aug 22, 2025 at 4:17=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid=
@igalia.com> wrote:
> >>
> >> Drop the restriction for casefold dentries lookup to enable support fo=
r
> >> case-insensitive layers in overlayfs.
> >>
> >> Support case-insensitive layers with the condition that they should be
> >> uniformly enabled across the stack and (i.e. if the root mount dir has
> >> casefold enabled, so should all the dirs bellow for every layer).
> >>
> >> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
> >> Changes from v5:
> >> - Fix mounting layers without casefold flag
> >> ---
> >>   fs/overlayfs/namei.c | 17 +++++++++--------
> >>   fs/overlayfs/util.c  | 10 ++++++----
> >>   2 files changed, 15 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> >> index 76d6248b625e7c58e09685e421aef616aadea40a..e93bcc5727bcafdc18a499=
b47a7609fd41ecaec8 100644
> >> --- a/fs/overlayfs/namei.c
> >> +++ b/fs/overlayfs/namei.c
> >> @@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base=
, struct ovl_lookup_data *d,
> >>          char val;
> >>
> >>          /*
> >> -        * We allow filesystems that are case-folding capable but deny=
 composing
> >> -        * ovl stack from case-folded directories. If someone has enab=
led case
> >> -        * folding on a directory on underlying layer, the warranty of=
 the ovl
> >> -        * stack is voided.
> >> +        * We allow filesystems that are case-folding capable as long =
as the
> >> +        * layers are consistently enabled in the stack, enabled for e=
very dir
> >> +        * or disabled in all dirs. If someone has modified case foldi=
ng on a
> >> +        * directory on underlying layer, the warranty of the ovl stac=
k is
> >> +        * voided.
> >>           */
> >> -       if (ovl_dentry_casefolded(base)) {
> >> -               warn =3D "case folded parent";
> >> +       if (ofs->casefold !=3D ovl_dentry_casefolded(base)) {
> >> +               warn =3D "parent wrong casefold";
> >>                  err =3D -ESTALE;
> >>                  goto out_warn;
> >>          }
> >> @@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, =
struct ovl_lookup_data *d,
> >>                  goto out_err;
> >>          }
> >>
> >> -       if (ovl_dentry_casefolded(this)) {
> >> -               warn =3D "case folded child";
> >> +       if (ofs->casefold !=3D ovl_dentry_casefolded(this)) {
> >> +               warn =3D "child wrong casefold";
> >>                  err =3D -EREMOTE;
> >>                  goto out_warn;
> >>          }
> >> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> >> index a33115e7384c129c543746326642813add63f060..52582b1da52598fbb14866=
f8c33eb27e36adda36 100644
> >> --- a/fs/overlayfs/util.c
> >> +++ b/fs/overlayfs/util.c
> >> @@ -203,6 +203,8 @@ void ovl_dentry_init_flags(struct dentry *dentry, =
struct dentry *upperdentry,
> >>
> >>   bool ovl_dentry_weird(struct dentry *dentry)
> >>   {
> >> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >> +

FWIW this was a bug that hits
WARN_ON_ONCE(sb->s_type !=3D &ovl_fs_type)
because dentry is NOT an ovl dentry.

> >>          if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_syml=
ink(dentry))
> >>                  return true;
> >>
> >> @@ -210,11 +212,11 @@ bool ovl_dentry_weird(struct dentry *dentry)
> >>                  return true;
> >>
> >>          /*
> >> -        * Allow filesystems that are case-folding capable but deny co=
mposing
> >> -        * ovl stack from case-folded directories.
> >> +        * Exceptionally for layers with casefold, we accept that they=
 have
> >> +        * their own hash and compare operations
> >>           */
> >> -       if (sb_has_encoding(dentry->d_sb))
> >> -               return IS_CASEFOLDED(d_inode(dentry));
> >> +       if (ofs->casefold)
> >> +               return false;
> >
> > I think this is better as:
> >          if (sb_has_encoding(dentry->d_sb))
> >                  return false;
> >

And this still fails the test "Casefold enabled" for me.

Maybe you are confused because this does not look like
a test failure. It looks like this:

generic/999 5s ...  [19:10:21][  150.667994] overlayfs: failed lookup
in lower (ovl-lower/casefold, name=3D'subdir', err=3D-116): parent wrong
casefold
[  150.669741] overlayfs: failed lookup in lower (ovl-lower/casefold,
name=3D'subdir', err=3D-116): parent wrong casefold
[  150.760644] overlayfs: failed lookup in lower (/ovl-lower,
name=3D'casefold', err=3D-66): child wrong casefold
 [19:10:24] [not run]
generic/999 -- overlayfs does not support casefold enabled layers
Ran: generic/999
Not run: generic/999
Passed all 1 tests

I'm not sure I will keep the test this way. This is not very standard nor
good practice, to run half of the test and then skip it.
I would probably split it into two tests.
The first one as it is now will run to completion on kenrels >=3D v6.17
and the Casefold enable test will run on kernels >=3D v6.18.

In any case, please make sure that the test is not skipped when testing
Casefold enabled layers

And then continue with the missing test cases.

When you have a test that passes please send the test itself or
a fstest branch for me to test.

Thanks,
Amir.


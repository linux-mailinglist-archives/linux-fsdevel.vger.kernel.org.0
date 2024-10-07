Return-Path: <linux-fsdevel+bounces-31162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CDB992A10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7941F22E76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7151D1E65;
	Mon,  7 Oct 2024 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXGTxGb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3462AD05;
	Mon,  7 Oct 2024 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299574; cv=none; b=gUif8pHDoEcmLl+u5a/vx/2pscmm8YHjqGcOWLCbclfRrOw0xCdY+ZzulmnSd7Xq3IW8Z6HZjN1Uj8xZ0FU6auWkfaRL9HaoQp96NsCrSH56coLcul7uwi+xLXM8urj3xRNu6USnrhlIprTtM/XzQO9u/FXA6Cj/73LM9YQj9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299574; c=relaxed/simple;
	bh=+0UBYzLaamVI5QhpfCQYL3WXU8nHfkUEMofM6kpbGzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r807mg6EmwrnB7W+CUWFQAsYqjPcEMgBFkomJGNzqM4/wuHYL6m2ich8skuQRf+edR+d15DG4JfXigB8AcTAX+IYxIblTg/okECMzCDJ6ycgpRrNHfQ69Yajg2yHgYQ/ygpHmdXtGUIPVV3bCjOqVhyeclxKL26MQOyE1ameiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXGTxGb6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a9ad15d11bso373423085a.0;
        Mon, 07 Oct 2024 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299571; x=1728904371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0Pu7w7Qofm8rf+EQz/VvkYu8KIa27zSMi6qN0yhbGo=;
        b=jXGTxGb6/ixz58lvV9Xp77QVQo4/z05RHcUk64Exqhx9BAhQFktaWe7HBWN4j3iVic
         +yCITAQ0p6QeUJcpVgfhvo6dyu4Spv9cvpb9cysoDK2y2nsKZvFbWqj1zYxhPVfqSsj2
         knUQ1wp6H01sAo9K0dQSCw04NmIAq112qsUjT6BWeE/78AC8/l8HFKJpZB9/2vhOvUyl
         i0iyBynaVqp9LJVHolAf7oDKLfaSpKRTlYpQ+9+npqTrYFYt/WddIt5IBWVhgHnNubGx
         C14ibDuWCc+lELxjTjwfaurZAJMZhcvE1xf+3nN0ORdHCiCmzqFn3m9svRCCOW9je3V5
         W88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299571; x=1728904371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0Pu7w7Qofm8rf+EQz/VvkYu8KIa27zSMi6qN0yhbGo=;
        b=q6OoV/e7PlpGY1XOICMR6pjrCyTi/Z/njtktyCZk//SrROacXbEWpy5h0H5t14pM5B
         LiWPReO2FXXYUW9jwc7qnn7MwQJO/MfzNgJ5KSI6tBmu7Fh2RWq0+nTXbs9Lwrd9H4yf
         QEOB6g1rE4B/1kvosc2RG+vOansu5Vz6CSMqmnelRTUTSqopgahGj5pm9nthbEyoMk6i
         DaDmfVfrJS84oN9uEGDksjEhBveVZqBLgc5RzwsBmS9pV3HGazJuol810KYexomkIJRZ
         Rk/uRZUMcT7DkhSrs4ehIBqnULU/VaOLS3iopw1JuFN5nbmO79Lea/St6NTUAs5/GNWA
         O7TA==
X-Forwarded-Encrypted: i=1; AJvYcCUNBPgNEFDfBPD6ygcmoFZdd6GNw6UkdjToPWAeYI+Qb2CvxlYyickCqot1Be/bWYvd21gwuLDJEh1B4y4E@vger.kernel.org, AJvYcCUdsbjupYcmdVMHyn5Gb7SNGclvgk7bBfIPmK+s0EnjJwACEnqbvmtfbocK1MejbZK0c/hTiaoF7oZHhFiw@vger.kernel.org, AJvYcCWCQQX8PuI/bHaoT0BDSal/WY8QIDDwYehIMmltjxYzr+X2xXn8+fxB6ueRnVykQj68MO4TUfnc/Nh5QnFjcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLx2Aoj5q4fXLfUtSgNk2tXZegXRMyNGi7rcc7xCFVCvRWOaL2
	q9Ty00HiO8f3hm06vp38jDprHe0F29RIi47+JiTBf920b3g6aN3cORVIK8r8GOLBCuhl/XXPJVB
	2C6gDhtYgnTH5xRMMylDYkt+QXV4=
X-Google-Smtp-Source: AGHT+IFNLQwu9WYwxkT9V/5IpXoKM/Gp5ODCQEgaSziss4Rh4GRcegimwTg7Sq8jcoV0sbHBvx0DcunvFCiyMFzaVI8=
X-Received: by 2002:a05:620a:394b:b0:7a1:d73f:53d2 with SMTP id
 af79cd13be357-7ae6f4451d4mr1918784085a.20.1728299571575; Mon, 07 Oct 2024
 04:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-5-vinicius.gomes@intel.com> <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
 <87wmk2lx3s.fsf@intel.com> <87h6a43gcc.fsf@intel.com> <20240925-umweht-schiffen-252e157b67f7@brauner>
 <87bk0b3jis.fsf@intel.com>
In-Reply-To: <87bk0b3jis.fsf@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 7 Oct 2024 13:12:39 +0200
Message-ID: <CAOQ4uxhuvBtSrbw2RAGKnO6O9dXH2DZ-fHJ=z8v+T+5PariZ0w@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] overlayfs: Document critical override_creds() operations
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:17=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Christian Brauner <brauner@kernel.org> writes:
>
> > On Tue, Sep 24, 2024 at 06:13:39PM GMT, Vinicius Costa Gomes wrote:
> >> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
> >>
> >> > Miklos Szeredi <miklos@szeredi.hu> writes:
> >> >
> >> >> On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
> >> >> <vinicius.gomes@intel.com> wrote:
> >> >>>
> >> >>> Add a comment to these operations that cannot use the _light versi=
on
> >> >>> of override_creds()/revert_creds(), because during the critical
> >> >>> section the struct cred .usage counter might be modified.
> >> >>
> >> >> Why is it a problem if the usage counter is modified?  Why is the
> >> >> counter modified in each of these cases?
> >> >>
> >> >
> >> > Working on getting some logs from the crash that I get when I conver=
t
> >> > the remaining cases to use the _light() functions.
> >> >
> >>
> >> See the log below.
> >>
> >> > Perhaps I was wrong on my interpretation of the crash.
> >> >
> >>
> >> What I am seeing is that ovl_setup_cred_for_create() has a "side
> >> effect", it creates another set of credentials, runs the security hook=
s
> >> with this new credentials, and the side effect is that when it returns=
,
> >> by design, 'current->cred' is this new credentials (a third set of
> >> credentials).
> >
> > Well yes, during ovl_setup_cred_for_create() the fs{g,u}id needs to be
> > overwritten. But I'm stil confused what the exact problem is as it was
> > always clear that ovl_setup_cred_for_create() wouldn't be ported to
> > light variants.
> >
> > /me looks...
> >
> >>
> >> And this implies that refcounting for this is somewhat tricky, as said
> >> in commit d0e13f5bbe4b ("ovl: fix uid/gid when creating over whiteout"=
).
> >>
> >> I see two ways forward:
> >>
> >> 1. Keep using the non _light() versions in functions that call
> >>    ovl_setup_cred_for_create().
> >> 2. Change ovl_setup_cred_for_create() so it doesn't drop the "extra"
> >>    refcount.
> >>
> >> I went with (1), and it still sounds to me like the best way, but I
> >> agree that my explanation was not good enough, will add the informatio=
n
> >> I just learned to the commit message and to the code.
> >>
> >> Do you see another way forward? Or do you think that I should go with
> >> (2)?
> >
> > ... ok, I understand. Say we have:
> >
> > ovl_create_tmpfile()
> > /* current->cred =3D=3D ovl->creator_cred without refcount bump /*
> > old_cred =3D ovl_override_creds_light()
> > -> ovl_setup_cred_for_create()
> >    /* Copy current->cred =3D=3D ovl->creator_cred */
> >    modifiable_cred =3D prepare_creds()
> >
> >    /* Override current->cred =3D=3D modifiable_cred */
> >    mounter_creds =3D override_creds(modifiable_cred)
> >
> >    /*
> >     * And here's the BUG BUG BUG where we decrement the refcount on the
> >     * constant mounter_creds.
> >     */
> >    put_cred(mounter_creds) // BUG BUG BUG
> >
> >    put_cred(modifiable_creds)
> >
> > So (1) is definitely the wrong option given that we can get rid of
> > refcount decs and incs in the creation path.
> >
> > Imo, you should do (2) and add a WARN_ON_ONC(). Something like the
> > __completely untested__:
> >
>
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index ab65e98a1def..e246e0172bb6 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -571,7 +571,12 @@ static int ovl_setup_cred_for_create(struct dentry=
 *dentry, struct inode *inode,
> >                 put_cred(override_cred);
> >                 return err;
> >         }
> > -       put_cred(override_creds(override_cred));
> > +
> > +       /*
> > +        * We must be called with creator creds already, otherwise we r=
isk
> > +        * leaking creds.
> > +        */
> > +       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentr=
y->d_sb));
> >         put_cred(override_cred);
> >
> >         return 0;
> >
>
> At first glance, looks good. Going to test it and see how it works.
> Thank you.
>
> For the next version of the series, my plan is to include this
> suggestion/change and remove the guard()/scoped_guard() conversion
> patches from the series.
>

Vinicius,

I have a request. Since the plan is to keep the _light() helpers around for=
 the
time being, please make the existing helper ovl_override_creds() use the
light version and open code the non-light versions in the few places where
they are needed and please replace all the matching call sites of
revert_creds() to
a helper ovl_revert_creds() that is a wrapper for the light version.

Also, depending on when you intend to post your work for review,
I have a feeling that the review of my patches is going to be done
before your submit your patches for review, so you may want to consider
already basing your patches on top of my development branch [2] to avoid
conflicts later.

Anyway, the parts of my patches that conflict with yours (s/real.file/realf=
ile/)
are not likely to change anymore.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20241006082359.263755-1-amir73il@=
gmail.com/
[2] https://github.com/amir73il/linux/commits/ovl_real_file/


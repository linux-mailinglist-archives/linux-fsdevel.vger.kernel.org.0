Return-Path: <linux-fsdevel+bounces-66837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF4AC2D42A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9AF460553
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2803191DA;
	Mon,  3 Nov 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iju6XUHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD43191A7
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188264; cv=none; b=q66RWdu4a82MSduSpyOIQdxT+PGFK/AVem8ac1fBT0gXeiIefTdNILV2UiF75fWewCbvX4TWLMB1J2FY+OREJdu6CojqdYfcpKBaz0fagIw4T/xsejd4d93F53BoLJTojViGudKhW4g/FP32YgCT++8+asKfaokI1sn2IvjIKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188264; c=relaxed/simple;
	bh=I59wiwFqkVLbZoOM2bUnRlIlFIr+V9VcFSQ69zg46C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RokAC3eX9hxkCPq7Iy9fLW/zOL+RyNzWI3UlOwX3d1CJMeLOk56uYrvXj7zyKJi2xvJSp9tgRTK93nL5r4wIXVGxSGV1df5d3NlmKps6bT57Ls8CUEShXDiORm0er5yibYOvfdyuFk2PkpXp1EiPTUB7B5vy2X2rowd7WcMYcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iju6XUHs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3c2db014easo968572366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188261; x=1762793061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM1Mf5XboMaTxjsxho7myGSxuJgsjYFuc/EcT5bM81M=;
        b=iju6XUHsGsTJlvALW5sKs2mOOmBDDPRrZTMNp9jeq1RW6/i8Odc5/ivyLtmKB95bMK
         KwveY7FTVgIdAKGxD4ja1HMF926eAWODxX05YmSwq81AKbZ3StSidHtPULfp+KC38X3I
         yI3VEVySWglQsLtf1f5dWP4SecUpE3yi0I4lRe34lFeJVEbjr4EmXOrfQYqsUaZ8ccSg
         lqXzRth5iRzW/E7bLKLpcbwh+3exiejNEPNzvS/qpGxIcq1jObovJtS6r1iTwoM7am9m
         8S+iJ6ByAf4rU3ZuqTg7BIGhVrnDhSCk8p+0ob0guBVsgmyadRzkR5FgEAOd5hjPMbPJ
         wAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188261; x=1762793061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM1Mf5XboMaTxjsxho7myGSxuJgsjYFuc/EcT5bM81M=;
        b=UGhnBDis/GEIukFq6h0JOBLNs67N1dQWKU1prQLdvRSAHdMBBrt7f2W4dfZ9i3lLGE
         /ThOxM58f5FeJaxkX0UmY8qQlMnHXyYjtyEHuLwqzxSoiBRk6f/2zKUQXJORm0GGZESr
         Qnhly4K8+oS4bsoLaODUeV65txtAbli+XouWQO5zbVv8vyhPZgmdHT4c/peZJoV7aTEf
         pUIb58nGANcPQ161xqza7TYAkB4MzaV/Kgs9UOywDfRsg5KKS0EfJD0GPOzWuEk7VTrt
         XBPjLkjmU3c/1Lj90oiJ6/rxz/zNd/Nwgn/M7Hn3uQFOOQE35fHV1A4SIdH46ZbxFqpE
         7QXA==
X-Forwarded-Encrypted: i=1; AJvYcCVFGGcA+ZM4BlbTPYQwx0LQguRLwSAQVdxs4GuhpkNDGi1oHrYaIYmNlHxjTyIuftLeJSVFjMRsHm8CTRsx@vger.kernel.org
X-Gm-Message-State: AOJu0YzClkNviez0S1aMLbZrGBY/wrt7+WuDh9vumQzZ/c0XtJW9UpAG
	MBjkEiuJNvyJ/jxNNJmG0gulCZiOx3IpmnDuUHvHM4DdkLPKb3QVJeN3TcHPW1Ta3CKjLhqC6aq
	8QCEX2971ho++C1tlmG1hr63+2E4TDAQ=
X-Gm-Gg: ASbGnctduv/HpIiycEsATVaPnHBRGLlPpER1mmsd8+cZRXyofWYJk+jKUWT7dHmCWkK
	qtAA9QgOGTZzl4vVNnz4AZdDXHk8NRD/vd8Et23bfQvefbtbBvp1uEOXzXRv4u22x3HpbKHlHRk
	+dmg/NGTrWyQMf57Mg6htq7Lnf0Y3RfGKR4R10mW7FfiGjQGEW8AcUNM8wrnTumYmnaBmdpUuz0
	QIQPZWT4Ygao7NemdIleEoyduLnEJcaaFTkTDI2o1P01liOCXOMD23xkhlFFSoxwYtXDtp6b1aH
	I5dYQ3KHV70i4Gg=
X-Google-Smtp-Source: AGHT+IEnNURiDoaBjLpsTWUH9VrYNjPaIOjw8lu0D4XVVYkRaZQT9oThVFEbAAXuncvvQOueIKruSMdsB9DoUHyZ0bs=
X-Received: by 2002:a17:907:7b8d:b0:b5c:753a:e022 with SMTP id
 a640c23a62f3a-b70701dc398mr1186998066b.29.1762188260475; Mon, 03 Nov 2025
 08:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029134952.658450-1-mjguzik@gmail.com> <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV> <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
 <20251102061443.GE2441659@ZenIV> <CAGudoHFDAPEYoC8RAPuPVkcsHsgpdJtQh91=8wRgMAozJyYf2w@mail.gmail.com>
 <20251103044553.GF2441659@ZenIV>
In-Reply-To: <20251103044553.GF2441659@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Nov 2025 17:44:07 +0100
X-Gm-Features: AWmQ_bnRp3G7Ykl903QbbL9ApDC5ofho-uqgihSVxa8bPNXNkVDexslsMax_YbU
Message-ID: <CAGudoHGP+x0VPpJnn=zWG6NLTkN8t+TvKDwErfWVvzZ7CEa+=Q@mail.gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in putname()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:45=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Sun, Nov 02, 2025 at 11:42:03PM +0100, Mateusz Guzik wrote:
>
> > Even ignoring the fact that there is a refcount and people may be
> > inclined to refname(name) + take_filename(name), the following already
> > breaks:
>
> Er...  refname() doesn't need to be seen for anyone other than auditsc.c
> and core part of filename handling in fs/namei.c (I'd like to move it
> to fs/filename.c someday)...
>
> > foo() {
> >     name =3D getname(...);
> >     if (!IS_ERR_OR_NULL(name))
> >         bar(name);
> >     putname(name);
> > }
> >
> > bar(struct filename *name)
> > {
> >     baz(take_filename(&name));
> > }
> >
> > While the code as proposed in the branch does not do it, it is a
> > matter of time before something which can be distilled to the above
> > shows up.
>
> Breaks in which case, exactly?  If baz() consumes its argument, we are
> fine, if it does we have a leak...
>

My point is currently the idiomatic handling of struct filename is to
getname(), pass it around and then unconditionally call putname() on
it, which already branches on IS_ERR_OR_NULL. With the previous
proposed design it would be a matter of time before someone does that
and take_filename somewhere down the callstack, resulting in a bug.

The new alien_filename struct mostly sorts it out, but I have some notes on=
 it.

> I agree that 'take_filename' is inviting wrong connotations, though.
>
> Hell knows - it might be worth thinking of that as claiming ownership.
> Or, perhaps, transformation of the original object, if we separate
> the notion of 'active filename' (absolutely tied to one thread, not
> allowed to be reachable from any data structures shared with other
> threads, etc.) from 'embryonic filename' (no refcounting whatsoever,
> no copying of references, etc., consumed on transformation into
> 'active filename').  Then getname_alien() would create an embryo,
> to be consumed before doing actual work.  That could be expressed
> in C type system...  Need to think about that.
>
> One possibility would be something like
>
> struct alien_filename {
>         struct filename *__dont_touch_that;
> };
>
> int getname_alien(struct alien_filename *v, const char __user *string)
> {
>         struct filename *res;
>         if (WARN_ON(v->__dont_touch_that))
>                 return -EINVAL;
>         res =3D getname_flags(string, GETNAME_NOAUDIT);
>         if (IS_ERR(res))
>                 return PTR_ERR(res);
>         v->__done_touch_that =3D res;
>         return 0;
> }
>
> void destroy_alien_filename(struct alient_filename *v)
> {
>         putname(no_free_ptr(v->__dont_touch_that));
> }
>
> struct filename *claim_filename(struct alien_filename *v)
> {
>         struct filename *res =3D no_free_ptr(v->__dont_touch_that);
>         if (!IS_ERR(res))
>                 audit_getname(res);
>         return res;
> }
>
> and e.g.
>
> struct io_rename {
>         struct file                     *file;
>         int                             old_dfd;
>         int                             new_dfd;
>         struct alien_filename           oldpath;
>         struct alien_filename           newpath;
>         int                             flags;
> };
>
> ...
>         err =3D getname_alien(&ren->oldpath);
>         if (unlikely(err))
>                 return err;
>         err =3D getname_alien(&ren->newpath);
>         if (unlikely(err)) {
>                 destroy_alien_filename(&ren->oldpath);
>                 return err;
>         }
>
> ...
>         /* note that do_renameat2() consumes filename references */
>         ret =3D do_renameat2(ren->old_dfd, claim_filename(&ren->oldpath),
>                            ren->new_dfd, claim_filename(&ren->newpath),
>                            ren->flags);
> ...
>
> void io_renameat_cleanup(struct io_kiocb *req)
> {
>         struct io_rename *ren =3D io_kiocb_to_cmd(req, struct io_rename);
>
>         destroy_alien_filename(&ren->oldpath);
>         destroy_alien_filename(&ren->newpath);
> }
>
> Might work...  Anyone found adding any instances of __dont_touch_that any=
where in
> the kernel would be obviously doing something fishy (and if they are play=
ing silly
> buggers with obfuscating that, s/doing something fishy/malicious/), so C =
typechecking
> + git grep once in a while should suffice for safety.

I think this still wants some error-proofing to catch bad usage. Per
the above, the new thing deviates from the idiom claiming you can
always putname().

Perhaps like this:
struct alien_filename {
        struct filename *__dont_touch_that;
        struct task_struct *__who_can_free;
        bool is_delegated;
};

It would start with __who_can_free =3D=3D NULL and would need to be
populated by a helper before destroy_alien_name is legally callable.

The consumer would denote it does not intend to free the obj by
calling delegate_alien_name(), after which some other thread needs to
take ownership.

a sketch:
/* called by the thread which allocated the name if it decides to go
through with it */
delegate_alien_name(name) {
    VFS_BUG_ON(name->delegated);
    name->delegated =3D true;
}

/* called by the thread using the name */
claim_alien_name(name) {
    VFS_BUG_ON(!name->delegated);
    VFS_BUG_ON(name->__who_can_free !=3D NULL);
    name->__who_can_free =3D current;
}

destroy_alien_name(name) {
    if (name->delegated) {
        VFS_BUG_ON(name->__who_can_free =3D=3D NULL);
        VFS_BUG_ON(name->__who_can_free !=3D current);
    }
    putname(..);
}

So a sample correct consumer looks like this:
err =3D getname_alien(&name);
....
err =3D other_prep();
if (!err)
    actual_work(delegate_alien_name(name));
else
    destroy_alien_name(name);

the *other* thread which eventually works on the name:
claim_alien_name(name);
/* hard work goes here */
destroy_alien_name(name);

Sample buggy consumer which both delegated the free *and* decided free
anyway is caught.


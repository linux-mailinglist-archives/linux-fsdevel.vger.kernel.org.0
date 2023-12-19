Return-Path: <linux-fsdevel+bounces-6478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329E818213
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 08:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AC61F24ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 07:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F9D526;
	Tue, 19 Dec 2023 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLr+aqKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE2C8DB;
	Tue, 19 Dec 2023 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f61c5f3b1so1101976d6.0;
        Mon, 18 Dec 2023 23:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702970165; x=1703574965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+5WR243kQ/RvAMHBsxM/Gl8vp7vTNRpisHvUU60+wg=;
        b=HLr+aqKvC3GHuFq2oHZ2aUBmWqa05RO5fqE8P6Aytsdao+e+DP/wgYjLuJIVZzgyaC
         4o/5+W0MxPhlcm5nyVqz51Ol6HC5HqF4ZoEXaCtZztIGi3Mkg89U8M+9tNo8hohUG8ct
         cE0ew59bTn3BjmMl1qIQkInbH4XIQyVenrDHb74wzAbZ3z3D4w+gGexheF6A84NQ9ba4
         NVfplN58Jg/XpRRyNuawLRf51JSUt4Cn1VMLzUaHrP3doABIgpiBjntqtN5zXEXoFrR6
         477C/pDfUDC6kg+Bbk8KQYKWh5K7yMtNHgSb/zPmcq+2nBSjZQ1pUBP0p6jkcakAsM4A
         0yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702970165; x=1703574965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+5WR243kQ/RvAMHBsxM/Gl8vp7vTNRpisHvUU60+wg=;
        b=Ue0XFYBfEj1EEDmxtWri8b+R7uXwBZNUmNjtuSsogqyBJXbjV3KvaYppYfGUlxqVrO
         dmbWfIntozv5iM4UJewyByOwPDBxDgjLen07elU/KQmAp7S49DhbCx7iUZ0VGKP1UsBK
         hIUwKv3GGdgCo2SZc5hxoA3rUOzCRRYBdcY5I1GMO/Bpr2Rvn51aJ3bP2n89rvK3hFqr
         hYFOBRfkKe+q5MsYMGWjgb9QxuyEiO/xelotrALniqgiXOq8WbLzM8tjv9TQNNc8WR19
         hzf4luGYPgSDsmnyQ2jvuGmidrogSCwAvDIuQNIVe/loXMKwlos29sTMb5uZwK5zL2iC
         e6/g==
X-Gm-Message-State: AOJu0Yys+UTqtzLIzq1K0748Nc9iaKk6gg0ahl2yN1FGhjcDzhLPYYD0
	TpvOrdyh+SECKmSzMjOKagwd+mMWiUQhYqZ3S2gD756JpzY=
X-Google-Smtp-Source: AGHT+IHWMseIasiaD8d3hjNptRx+YQ73MHnAO8mmgvGuj7K5xQ28WQQzCvf8ljKe4PlqWGpFZRlrnceSG6z/kerPGwc=
X-Received: by 2002:a05:6214:2409:b0:67f:1dbb:d3c2 with SMTP id
 fv9-20020a056214240900b0067f1dbbd3c2mr6274053qvb.16.1702970165370; Mon, 18
 Dec 2023 23:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com> <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
 <87v88zp76v.fsf@intel.com> <CAOQ4uxiCVv7zbfn2BPrR9kh=DvGxQtXUmRvy2pDJ=G7rxjBrgg@mail.gmail.com>
 <CAOQ4uxhxvFt3_Wb3BGcjj4pGp=OFTBHNPJ4r4eH8245t-+CW+g@mail.gmail.com>
 <20231218-intim-lehrstellen-dbe053d6c3a8@brauner> <875y0vp41g.fsf@intel.com>
In-Reply-To: <875y0vp41g.fsf@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Dec 2023 09:15:52 +0200
Message-ID: <CAOQ4uxibYMQw0iszKhE5uxBnyayHWjqp4ZnOOiugO3GxMRS1eA@mail.gmail.com>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, 
	Seth Forshee <sforshee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:57=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Christian Brauner <brauner@kernel.org> writes:
>
> >> > Yes, the important thing is that an object cannot change
> >> > its non_refcount property during its lifetime -
> >>
> >> ... which means that put_creds_ref() should assert that
> >> there is only a single refcount - the one handed out by
> >> prepare_creds_ref() before removing non_refcount or
> >> directly freeing the cred object.
> >>
> >> I must say that the semantics of making a non-refcounted copy
> >> to an object whose lifetime is managed by the caller sounds a lot
> >> less confusing to me.
> >
> > So can't we do an override_creds() variant that is effectively just:

Yes, I think that we can....

> >
> > /* caller guarantees lifetime of @new */
> > const struct cred *foo_override_cred(const struct cred *new)
> > {
> >       const struct cred *old =3D current->cred;
> >       rcu_assign_pointer(current->cred, new);
> >       return old;
> > }
> >
> > /* caller guarantees lifetime of @old */
> > void foo_revert_creds(const struct cred *old)
> > {
> >       const struct cred *override =3D current->cred;
> >       rcu_assign_pointer(current->cred, old);
> > }
> >

Even better(?), we can do this in the actual guard helpers to
discourage use without a guard:

struct override_cred {
        struct cred *cred;
};

DEFINE_GUARD(override_cred, struct override_cred *,
            override_cred_save(_T),
            override_cred_restore(_T));

...

void override_cred_save(struct override_cred *new)
{
        new->cred =3D rcu_replace_pointer(current->cred, new->cred, true);
}

void override_cred_restore(struct override_cred *old)
{
        rcu_assign_pointer(current->cred, old->cred);
}

> > Maybe I really fail to understand this problem or the proposed solution=
:
> > the single reference that overlayfs keeps in ovl->creator_cred is tied
> > to the lifetime of the overlayfs superblock, no? And anyone who needs a
> > long term cred reference e.g, file->f_cred will take it's own reference
> > anyway. So it should be safe to just keep that reference alive until
> > overlayfs is unmounted, no? I'm sure it's something quite obvious why
> > that doesn't work but I'm just not seeing it currently.
>
> My read of the code says that what you are proposing should work. (what
> I am seeing is that in the "optimized" cases, the only practical effect
> of override/revert is the rcu_assign_pointer() dance)
>
> I guess that the question becomes: Do we want this property (that the
> 'cred' associated with a subperblock/similar is long lived and the
> "inner" refcount can be omitted) to be encoded in the constructor? Or do
> we want it to be "encoded" in a call by call basis?
>

Neither.

Christian's proposal does not involve marking the cred object as
long lived, which looks a much better idea to me.

The performance issues you observed are (probably) due to get/put
of cred refcount in the helpers {override,revert}_creds().

Christian suggested lightweight variants of {override,revert}_creds()
that do not change refcount. Combining those with a guard and
I don't see what can go wrong (TM).

If you try this out and post a patch, please be sure to include the
motivation for the patch along with performance numbers in the
commit message, even if only posting an RFC patch.

Thanks,
Amir.


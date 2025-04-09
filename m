Return-Path: <linux-fsdevel+bounces-46051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C749A81FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2416A7AB130
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9B25B690;
	Wed,  9 Apr 2025 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chEIaJkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE625C6E6;
	Wed,  9 Apr 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187113; cv=none; b=VzYu5EsFp3UOj/qLWHV6SzeV9mMTOTRDMGglBOG/suh++TfP1uWvbSMQPc0ttXjhPZkHMy0yM+T1EX/q+m8U7Jx0UYiB7ksgv2nsknEQjoWHO5b/EPGK771K7gGFWWKRbM/Fxxu6SxznUttcXB9PltVTnmU1VcvIGsHrBH/uWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187113; c=relaxed/simple;
	bh=o58K4HaJQduhDF6rcZdLi70586beEiK59Cop5BlIrbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDNdPjjyumt2suucIKRe1ZiuyvM88brNLTHtPf/UxYR6IrSCltdKoFeAS+hrGx5oU+ZxtXQ55IN9jyA2rJuNKKVI88GBzCHsKB4OlJdLRjahcbRTxw1jbEAlNFpxhAsj7P2gOMAKAnumNFUb/SySssNZatUdhxUIePJtxyv+oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chEIaJkZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso10479804a12.0;
        Wed, 09 Apr 2025 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744187109; x=1744791909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I6ivCdkGxfkMSyDdzFk602sPAm37RykANRdWC5/gFC0=;
        b=chEIaJkZvUNtoiTUjXgYX42TG7jj3GDrnTM49hrFeyuIF/rDO0wqn3CRDHccQ2w+bf
         BYgxwOEzPfvtFn3zF+CnLca+lTLAP1bhyXFlpfNHfDCUC/JcApscnxyyNs/cZkHc5Qqd
         Me4tWoaYw/5dCvEMqi4Ek9z38ZeDx9cK7JNWNoQTeoWexwcW4MitRPFHp/JRbgr7ztfG
         UmJwTMOOh2e6iogxiutHRYDHc1SMPHSmksd3cSq7mYWkrCtVH+ynrEyL0NfqdZ6r0wP8
         7fykeOV95oo8xE4cx/X3U5cUxzsnnjzwWMhfrFF48MNOmma0wpTWsJ4IhjtxZrlDX23x
         lxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744187109; x=1744791909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6ivCdkGxfkMSyDdzFk602sPAm37RykANRdWC5/gFC0=;
        b=nDFw2nxhiSMzz3XEXhlfuiBCtjaT5iFlk+HUx75d6OqVe1LVfH1ZzTDu57ti0x5DQQ
         12s1bXslptsEG4AfALiYYtPukL0J+d/5l0rNq+bPfMqEAnmu/OhlijrpnPNRc2qXGAQE
         YtwGW9XpC/MaTk8AMDno1VGj5WNpdgzO4FWgAUOxNJK6ADudFr1vCOqmoULQUWB7ZJpT
         FczoVQXcIjhYR7fx9lnfl5lTR7IUawOaB/1cZFt1c0TEWcQb2ujdQ2vJMA7WckRnLnL1
         zmEl1Yx2/DozIC+PkcS0t1NVBa6mYuqaNKj7TnPZfydVlrKGdiEjZ3aaQy6YtcDBsaRR
         0oWw==
X-Forwarded-Encrypted: i=1; AJvYcCXzW2ySne/d3VmAh6sE9QddJ2Z3RHJLBTWmbZVPLbTY+E7KLguKzVPkm+PCDp0NyO1S8ZlpHraOSjXlpGW2@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyM8hNZhtNzaVujvxczLZvkUNMST+6h7xczVEfG3Yvl4LyKBq
	rAvlt9DniAQBVZYVs8LOgb2YVEbqxfsVk9zf+leSRt/xUs5bisoqrAY69IIANh7dy6q4MBiCKF0
	SkXCtbUuD/9PNVGt94IsUIF5zCCk=
X-Gm-Gg: ASbGncsoWSRhPjnrn95Mk3aFvdSGQB/PQjj4gNBGXs+7EkToneRO7MWX/Li4UW8Z3ly
	v0JnLdEF4C6y9JTvkmwexyr/cPIfkwN2nJ7U6JKXY7ZDOVbvE45Vh0p2zm+M5qKEzKXLpzVkw2/
	eMw8/K7JtL9A2FaERp1GFksA==
X-Google-Smtp-Source: AGHT+IGIEFnxcCmDjW6JMa+hCnOLmo6oANVn3Egmf3WtWbFsYRh48Ae+Q2G+AQ8om4UwQtO5c2QvvsYNDN9D8+z/dUk=
X-Received: by 2002:a05:6402:3588:b0:5ec:25d2:8631 with SMTP id
 4fb4d7f45d1cf-5f2f76b7eb0mr1462060a12.12.1744187108897; Wed, 09 Apr 2025
 01:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408154011.673891-1-mszeredi@redhat.com> <20250408154011.673891-2-mszeredi@redhat.com>
 <CAOQ4uxjOT=m7ZsdLod3KEYe+69K--fGTUegSNwQg0fU7TeVbsQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjOT=m7ZsdLod3KEYe+69K--fGTUegSNwQg0fU7TeVbsQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 10:24:56 +0200
X-Gm-Features: ATxdqUGmlNisZ428_Bdu7-ElJm1XePL27llc_FeNDqPhlBCtvwpwiXHoGIohWRw
Message-ID: <CAOQ4uxhXAxRBxRh9FT0prURdbRTGmmb4FWSs9zz2Rnk6U+0ZTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Giuseppe Scrivano <gscrivan@redhat.com>, Alexander Larsson <alexl@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000000c693d0632543502"

--0000000000000c693d0632543502
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 8:09=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Tue, Apr 8, 2025 at 5:40=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
> >
> > When overlayfs finds a file with metacopy and/or redirect attributes an=
d
> > the metacopy and/or redirect features are not enabled, then it refuses =
to
> > act on those attributes while also issuing a warning.
> >
> > There was an inconsistency in not checking metacopy found from the inde=
x.
> >
> > And also only warning on an upper metacopy if it found the next file on=
 the
> > lower layer, while always warning for metacopy found on a lower layer.
> >
> > Fix these inconsistencies and make the logic more straightforward, pavi=
ng
> > the way for following patches to change when dataredirects are allowed.
>
> missing space: dataredirects
>
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/overlayfs/namei.c | 81 +++++++++++++++++++++++++++++++-------------
> >  1 file changed, 57 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> > index be5c65d6f848..5cebdd05ab3a 100644
> > --- a/fs/overlayfs/namei.c
> > +++ b/fs/overlayfs/namei.c
> > @@ -16,6 +16,7 @@
> >
> >  struct ovl_lookup_data {
> >         struct super_block *sb;
> > +       struct dentry *dentry;
> >         const struct ovl_layer *layer;
> >         struct qstr name;
> >         bool is_dir;
> > @@ -23,6 +24,8 @@ struct ovl_lookup_data {
> >         bool xwhiteouts;
> >         bool stop;
> >         bool last;
> > +       bool nextredirect;
> > +       bool nextmetacopy;
>
> I think these are not needed
>
> >         char *redirect;
> >         int metacopy;
> >         /* Referring to last redirect xattr */
> > @@ -1024,6 +1027,31 @@ int ovl_verify_lowerdata(struct dentry *dentry)
> >         return ovl_maybe_validate_verity(dentry);
> >  }
> >
> > +/*
> > + * Following redirects/metacopy can have security consequences: it's l=
ike a
> > + * symlink into the lower layer without the permission checks.
> > + *
> > + * This is only a problem if the upper layer is untrusted (e.g comes f=
rom an USB
> > + * drive).  This can allow a non-readable file or directory to become =
readable.
> > + *
> > + * Only following redirects when redirects are enabled disables this a=
ttack
> > + * vector when not necessary.
> > + */
> > +static bool ovl_check_nextredirect(struct ovl_lookup_data *d)
>
> Looks much better with the helper.
> May I suggest ovl_check_follow_redirect()
>
> > +{
> > +       struct ovl_fs *ofs =3D OVL_FS(d->sb);
> > +
> > +       if (d->nextmetacopy && !ofs->config.metacopy) {
>
> Should be equivalent to
>        if (d->metacopy && !ofs->config.metacopy) {
>
> In current code
>
> > +               pr_warn_ratelimited("refusing to follow metacopy origin=
 for (%pd2)\n", d->dentry);
> > +               return false;
> > +       }
> > +       if (d->nextredirect && !ovl_redirect_follow(ofs)) {
>
> Should be equivalent to
>        if (d->redirect && !ovl_redirect_follow(ofs)) {
>
> With minor changes to index lookup code
>
>
> > +               pr_warn_ratelimited("refusing to follow redirect for (%=
pd2)\n", d->dentry);
> > +               return false;
> > +       }
> > +       return true;
> > +}
> > +
> >  struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
> >                           unsigned int flags)
> >  {
> > @@ -1047,6 +1075,7 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
> >         int metacopy_size =3D 0;
> >         struct ovl_lookup_data d =3D {
> >                 .sb =3D dentry->d_sb,
> > +               .dentry =3D dentry,
> >                 .name =3D dentry->d_name,
> >                 .is_dir =3D false,
> >                 .opaque =3D false,
> > @@ -1054,6 +1083,8 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
> >                 .last =3D ovl_redirect_follow(ofs) ? false : !ovl_numlo=
wer(poe),
> >                 .redirect =3D NULL,
> >                 .metacopy =3D 0,
> > +               .nextredirect =3D false,
> > +               .nextmetacopy =3D false,
> >         };
> >
> >         if (dentry->d_name.len > ofs->namelen)
> > @@ -1087,8 +1118,10 @@ struct dentry *ovl_lookup(struct inode *dir, str=
uct dentry *dentry,
> >                         if (err)
> >                                 goto out_put_upper;
> >
> > -                       if (d.metacopy)
> > +                       if (d.metacopy) {
> >                                 uppermetacopy =3D true;
> > +                               d.nextmetacopy =3D true;
>
> always set IFF (d.metacopy)
>
> > +                       }
> >                         metacopy_size =3D d.metacopy;
> >                 }
> >
> > @@ -1099,6 +1132,7 @@ struct dentry *ovl_lookup(struct inode *dir, stru=
ct dentry *dentry,
> >                                 goto out_put_upper;
> >                         if (d.redirect[0] =3D=3D '/')
> >                                 poe =3D roe;
> > +                       d.nextredirect =3D true;
>
> mostly set IFF (d.redirect)
>
> >                 }
> >                 upperopaque =3D d.opaque;
> >         }
> > @@ -1113,6 +1147,11 @@ struct dentry *ovl_lookup(struct inode *dir, str=
uct dentry *dentry,
> >         for (i =3D 0; !d.stop && i < ovl_numlower(poe); i++) {
> >                 struct ovl_path lower =3D ovl_lowerstack(poe)[i];
> >
> > +               if (!ovl_check_nextredirect(&d)) {
> > +                       err =3D -EPERM;
> > +                       goto out_put;
> > +               }
> > +
> >                 if (!ovl_redirect_follow(ofs))
> >                         d.last =3D i =3D=3D ovl_numlower(poe) - 1;
> >                 else if (d.is_dir || !ofs->numdatalayer)
> > @@ -1126,12 +1165,8 @@ struct dentry *ovl_lookup(struct inode *dir, str=
uct dentry *dentry,
> >                 if (!this)
> >                         continue;
> >
> > -               if ((uppermetacopy || d.metacopy) && !ofs->config.metac=
opy) {
> > -                       dput(this);
> > -                       err =3D -EPERM;
> > -                       pr_warn_ratelimited("refusing to follow metacop=
y origin for (%pd2)\n", dentry);
> > -                       goto out_put;
> > -               }
> > +               if (d.metacopy)
> > +                       d.nextmetacopy =3D true;
> >
> >                 /*
> >                  * If no origin fh is stored in upper of a merge dir, s=
tore fh
> > @@ -1185,22 +1220,8 @@ struct dentry *ovl_lookup(struct inode *dir, str=
uct dentry *dentry,
> >                         ctr++;
> >                 }
> >
> > -               /*
> > -                * Following redirects can have security consequences: =
it's like
> > -                * a symlink into the lower layer without the permissio=
n checks.
> > -                * This is only a problem if the upper layer is untrust=
ed (e.g
> > -                * comes from an USB drive).  This can allow a non-read=
able file
> > -                * or directory to become readable.
> > -                *
> > -                * Only following redirects when redirects are enabled =
disables
> > -                * this attack vector when not necessary.
> > -                */
> > -               err =3D -EPERM;
> > -               if (d.redirect && !ovl_redirect_follow(ofs)) {
> > -                       pr_warn_ratelimited("refusing to follow redirec=
t for (%pd2)\n",
> > -                                           dentry);
> > -                       goto out_put;
> > -               }
> > +               if (d.redirect)
> > +                       d.nextredirect =3D true;
> >
> >                 if (d.stop)
> >                         break;
> > @@ -1218,6 +1239,11 @@ struct dentry *ovl_lookup(struct inode *dir, str=
uct dentry *dentry,
> >                 ctr++;
> >         }
> >
> > +       if (!ovl_check_nextredirect(&d)) {
> > +               err =3D -EPERM;
> > +               goto out_put;
> > +       }
> > +
> >         /*
> >          * For regular non-metacopy upper dentries, there is no lower
> >          * path based lookup, hence ctr will be zero. If a dentry is fo=
und
> > @@ -1307,11 +1333,18 @@ struct dentry *ovl_lookup(struct inode *dir, st=
ruct dentry *dentry,
> >                         upperredirect =3D NULL;
> >                         goto out_free_oe;
> >                 }
> > +               d.nextredirect =3D upperredirect;
> > +
> >                 err =3D ovl_check_metacopy_xattr(ofs, &upperpath, NULL)=
;
> >                 if (err < 0)
> >                         goto out_free_oe;
> > -               uppermetacopy =3D err;
> > +               d.nextmetacopy =3D uppermetacopy =3D err;
>
> Could be changed to:
> +               d.metacopy =3D uppermetacopy =3D err;
>
>
> >                 metacopy_size =3D err;
> > +
> > +               if (!ovl_check_nextredirect(&d)) {
> > +                       err =3D -EPERM;
> > +                       goto out_free_oe;
> > +               }
> >         }
> >
>
>
> We never really follow redirect from index
> All upperredirect is ever used for is to suppress ovl_set_redirect()
> after copy up of another lower hardlink and rename,
> but also in that case, upperredirect is not going to be followed
> (or trusted for that matter) until a new lookup of the copied up
> alias and at that point  ovl_check_follow_redirect() will be
> called when upperdentry is found.
>
> I think we do not need to check follow of redirect from index
> I think it is enough to check follow of metacopy from index.
>
> Therefore, I think there d.nextmetacopy and d.nextredirect are
> completely implied from d.metacopy and d.redirect.

On second thought, if unpriv user suppresses ovl_set_redirect()
by setting some mock redirect value on index maybe that lead to some
risk. Not worth overthinking about it.

Attached patch removed next* variables without this compromise.

Tested it squashed to patch 1 and minor rebase conflicts fixes in patch 2.
It passed your tests.

Thanks,
Amir.

--0000000000000c693d0632543502
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="ovl-remove-unneeded-nextredirect-nextmetacopy.patch"
Content-Disposition: attachment; 
	filename="ovl-remove-unneeded-nextredirect-nextmetacopy.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m99nwf4x0>
X-Attachment-Id: f_m99nwf4x0

RnJvbSAyMzA1NzMwYmMxYzRlZTM1ZmNmMGI4ODMwNWU0YWRkODI4YmRmZjBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDkgQXByIDIwMjUgMDk6MDI6NDMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBvdmw6
IHJlbW92ZSB1bm5lZWRlZCBuZXh0cmVkaXJlY3QvbmV4dG1ldGFjb3B5CgotLS0KIGZzL292ZXJs
YXlmcy9uYW1laS5jIHwgNDggKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9mcy9vdmVybGF5ZnMvbmFtZWkuYyBiL2ZzL292ZXJsYXlmcy9uYW1laS5j
CmluZGV4IDVjZWJkZDA1YWIzYS4uNGZjMmM0N2ViYzU1IDEwMDY0NAotLS0gYS9mcy9vdmVybGF5
ZnMvbmFtZWkuYworKysgYi9mcy9vdmVybGF5ZnMvbmFtZWkuYwpAQCAtMjQsOSArMjQsOCBAQCBz
dHJ1Y3Qgb3ZsX2xvb2t1cF9kYXRhIHsKIAlib29sIHh3aGl0ZW91dHM7CiAJYm9vbCBzdG9wOwog
CWJvb2wgbGFzdDsKLQlib29sIG5leHRyZWRpcmVjdDsKLQlib29sIG5leHRtZXRhY29weTsKIAlj
aGFyICpyZWRpcmVjdDsKKwljaGFyICp1cHBlcnJlZGlyZWN0OwogCWludCBtZXRhY29weTsKIAkv
KiBSZWZlcnJpbmcgdG8gbGFzdCByZWRpcmVjdCB4YXR0ciAqLwogCWJvb2wgYWJzb2x1dGVfcmVk
aXJlY3Q7CkBAIC0xMDM3LDE1ICsxMDM2LDE1IEBAIGludCBvdmxfdmVyaWZ5X2xvd2VyZGF0YShz
dHJ1Y3QgZGVudHJ5ICpkZW50cnkpCiAgKiBPbmx5IGZvbGxvd2luZyByZWRpcmVjdHMgd2hlbiBy
ZWRpcmVjdHMgYXJlIGVuYWJsZWQgZGlzYWJsZXMgdGhpcyBhdHRhY2sKICAqIHZlY3RvciB3aGVu
IG5vdCBuZWNlc3NhcnkuCiAgKi8KLXN0YXRpYyBib29sIG92bF9jaGVja19uZXh0cmVkaXJlY3Qo
c3RydWN0IG92bF9sb29rdXBfZGF0YSAqZCkKK3N0YXRpYyBib29sIG92bF9jaGVja19mb2xsb3df
cmVkaXJlY3Qoc3RydWN0IG92bF9sb29rdXBfZGF0YSAqZCkKIHsKIAlzdHJ1Y3Qgb3ZsX2ZzICpv
ZnMgPSBPVkxfRlMoZC0+c2IpOwogCi0JaWYgKGQtPm5leHRtZXRhY29weSAmJiAhb2ZzLT5jb25m
aWcubWV0YWNvcHkpIHsKKwlpZiAoZC0+bWV0YWNvcHkgJiYgIW9mcy0+Y29uZmlnLm1ldGFjb3B5
KSB7CiAJCXByX3dhcm5fcmF0ZWxpbWl0ZWQoInJlZnVzaW5nIHRvIGZvbGxvdyBtZXRhY29weSBv
cmlnaW4gZm9yICglcGQyKVxuIiwgZC0+ZGVudHJ5KTsKIAkJcmV0dXJuIGZhbHNlOwogCX0KLQlp
ZiAoZC0+bmV4dHJlZGlyZWN0ICYmICFvdmxfcmVkaXJlY3RfZm9sbG93KG9mcykpIHsKKwlpZiAo
KGQtPnJlZGlyZWN0IHx8IGQtPnVwcGVycmVkaXJlY3QpICYmICFvdmxfcmVkaXJlY3RfZm9sbG93
KG9mcykpIHsKIAkJcHJfd2Fybl9yYXRlbGltaXRlZCgicmVmdXNpbmcgdG8gZm9sbG93IHJlZGly
ZWN0IGZvciAoJXBkMilcbiIsIGQtPmRlbnRyeSk7CiAJCXJldHVybiBmYWxzZTsKIAl9CkBAIC0x
MDY3LDcgKzEwNjYsNiBAQCBzdHJ1Y3QgZGVudHJ5ICpvdmxfbG9va3VwKHN0cnVjdCBpbm9kZSAq
ZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksCiAJdW5zaWduZWQgaW50IGN0ciA9IDA7CiAJc3Ry
dWN0IGlub2RlICppbm9kZSA9IE5VTEw7CiAJYm9vbCB1cHBlcm9wYXF1ZSA9IGZhbHNlOwotCWNo
YXIgKnVwcGVycmVkaXJlY3QgPSBOVUxMOwogCXN0cnVjdCBkZW50cnkgKnRoaXM7CiAJdW5zaWdu
ZWQgaW50IGk7CiAJaW50IGVycjsKQEAgLTEwODIsOSArMTA4MCw4IEBAIHN0cnVjdCBkZW50cnkg
Km92bF9sb29rdXAoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwKIAkJ
LnN0b3AgPSBmYWxzZSwKIAkJLmxhc3QgPSBvdmxfcmVkaXJlY3RfZm9sbG93KG9mcykgPyBmYWxz
ZSA6ICFvdmxfbnVtbG93ZXIocG9lKSwKIAkJLnJlZGlyZWN0ID0gTlVMTCwKKwkJLnVwcGVycmVk
aXJlY3QgPSBOVUxMLAogCQkubWV0YWNvcHkgPSAwLAotCQkubmV4dHJlZGlyZWN0ID0gZmFsc2Us
Ci0JCS5uZXh0bWV0YWNvcHkgPSBmYWxzZSwKIAl9OwogCiAJaWYgKGRlbnRyeS0+ZF9uYW1lLmxl
biA+IG9mcy0+bmFtZWxlbikKQEAgLTExMjAsMTkgKzExMTcsMTcgQEAgc3RydWN0IGRlbnRyeSAq
b3ZsX2xvb2t1cChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCiAJ
CQlpZiAoZC5tZXRhY29weSkgewogCQkJCXVwcGVybWV0YWNvcHkgPSB0cnVlOwotCQkJCWQubmV4
dG1ldGFjb3B5ID0gdHJ1ZTsKIAkJCX0KIAkJCW1ldGFjb3B5X3NpemUgPSBkLm1ldGFjb3B5Owog
CQl9CiAKIAkJaWYgKGQucmVkaXJlY3QpIHsKIAkJCWVyciA9IC1FTk9NRU07Ci0JCQl1cHBlcnJl
ZGlyZWN0ID0ga3N0cmR1cChkLnJlZGlyZWN0LCBHRlBfS0VSTkVMKTsKLQkJCWlmICghdXBwZXJy
ZWRpcmVjdCkKKwkJCWQudXBwZXJyZWRpcmVjdCA9IGtzdHJkdXAoZC5yZWRpcmVjdCwgR0ZQX0tF
Uk5FTCk7CisJCQlpZiAoIWQudXBwZXJyZWRpcmVjdCkKIAkJCQlnb3RvIG91dF9wdXRfdXBwZXI7
CiAJCQlpZiAoZC5yZWRpcmVjdFswXSA9PSAnLycpCiAJCQkJcG9lID0gcm9lOwotCQkJZC5uZXh0
cmVkaXJlY3QgPSB0cnVlOwogCQl9CiAJCXVwcGVyb3BhcXVlID0gZC5vcGFxdWU7CiAJfQpAQCAt
MTE0Nyw3ICsxMTQyLDcgQEAgc3RydWN0IGRlbnRyeSAqb3ZsX2xvb2t1cChzdHJ1Y3QgaW5vZGUg
KmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCWZvciAoaSA9IDA7ICFkLnN0b3AgJiYgaSA8
IG92bF9udW1sb3dlcihwb2UpOyBpKyspIHsKIAkJc3RydWN0IG92bF9wYXRoIGxvd2VyID0gb3Zs
X2xvd2Vyc3RhY2socG9lKVtpXTsKIAotCQlpZiAoIW92bF9jaGVja19uZXh0cmVkaXJlY3QoJmQp
KSB7CisJCWlmICghb3ZsX2NoZWNrX2ZvbGxvd19yZWRpcmVjdCgmZCkpIHsKIAkJCWVyciA9IC1F
UEVSTTsKIAkJCWdvdG8gb3V0X3B1dDsKIAkJfQpAQCAtMTE2NSw5ICsxMTYwLDYgQEAgc3RydWN0
IGRlbnRyeSAqb3ZsX2xvb2t1cChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVu
dHJ5LAogCQlpZiAoIXRoaXMpCiAJCQljb250aW51ZTsKIAotCQlpZiAoZC5tZXRhY29weSkKLQkJ
CWQubmV4dG1ldGFjb3B5ID0gdHJ1ZTsKLQogCQkvKgogCQkgKiBJZiBubyBvcmlnaW4gZmggaXMg
c3RvcmVkIGluIHVwcGVyIG9mIGEgbWVyZ2UgZGlyLCBzdG9yZSBmaAogCQkgKiBvZiBsb3dlciBk
aXIgYW5kIHNldCB1cHBlciBwYXJlbnQgImltcHVyZSIuCkBAIC0xMjIwLDkgKzEyMTIsNiBAQCBz
dHJ1Y3QgZGVudHJ5ICpvdmxfbG9va3VwKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5
ICpkZW50cnksCiAJCQljdHIrKzsKIAkJfQogCi0JCWlmIChkLnJlZGlyZWN0KQotCQkJZC5uZXh0
cmVkaXJlY3QgPSB0cnVlOwotCiAJCWlmIChkLnN0b3ApCiAJCQlicmVhazsKIApAQCAtMTIzOSw3
ICsxMjI4LDcgQEAgc3RydWN0IGRlbnRyeSAqb3ZsX2xvb2t1cChzdHJ1Y3QgaW5vZGUgKmRpciwg
c3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCQljdHIrKzsKIAl9CiAKLQlpZiAoIW92bF9jaGVja19u
ZXh0cmVkaXJlY3QoJmQpKSB7CisJaWYgKCFvdmxfY2hlY2tfZm9sbG93X3JlZGlyZWN0KCZkKSkg
ewogCQllcnIgPSAtRVBFUk07CiAJCWdvdG8gb3V0X3B1dDsKIAl9CkBAIC0xMzI0LDI0ICsxMzEz
LDIzIEBAIHN0cnVjdCBkZW50cnkgKm92bF9sb29rdXAoc3RydWN0IGlub2RlICpkaXIsIHN0cnVj
dCBkZW50cnkgKmRlbnRyeSwKIAogCQkvKgogCQkgKiBJdCdzIHNhZmUgdG8gYXNzaWduIHVwcGVy
cmVkaXJlY3QgaGVyZTogdGhlIHByZXZpb3VzCi0JCSAqIGFzc2lnbm1lbnQgb2YgaGFwcGVucyBv
bmx5IGlmIHVwcGVyZGVudHJ5IGlzIG5vbi1OVUxMLCBhbmQKKwkJICogYXNzaWdubWVudCBoYXBw
ZW5zIG9ubHkgaWYgdXBwZXJkZW50cnkgaXMgbm9uLU5VTEwsIGFuZAogCQkgKiB0aGlzIG9uZSBv
bmx5IGlmIHVwcGVyZGVudHJ5IGlzIE5VTEwuCiAJCSAqLwotCQl1cHBlcnJlZGlyZWN0ID0gb3Zs
X2dldF9yZWRpcmVjdF94YXR0cihvZnMsICZ1cHBlcnBhdGgsIDApOwotCQlpZiAoSVNfRVJSKHVw
cGVycmVkaXJlY3QpKSB7Ci0JCQllcnIgPSBQVFJfRVJSKHVwcGVycmVkaXJlY3QpOwotCQkJdXBw
ZXJyZWRpcmVjdCA9IE5VTEw7CisJCWQudXBwZXJyZWRpcmVjdCA9IG92bF9nZXRfcmVkaXJlY3Rf
eGF0dHIob2ZzLCAmdXBwZXJwYXRoLCAwKTsKKwkJaWYgKElTX0VSUihkLnVwcGVycmVkaXJlY3Qp
KSB7CisJCQllcnIgPSBQVFJfRVJSKGQudXBwZXJyZWRpcmVjdCk7CisJCQlkLnVwcGVycmVkaXJl
Y3QgPSBOVUxMOwogCQkJZ290byBvdXRfZnJlZV9vZTsKIAkJfQotCQlkLm5leHRyZWRpcmVjdCA9
IHVwcGVycmVkaXJlY3Q7CiAKIAkJZXJyID0gb3ZsX2NoZWNrX21ldGFjb3B5X3hhdHRyKG9mcywg
JnVwcGVycGF0aCwgTlVMTCk7CiAJCWlmIChlcnIgPCAwKQogCQkJZ290byBvdXRfZnJlZV9vZTsK
LQkJZC5uZXh0bWV0YWNvcHkgPSB1cHBlcm1ldGFjb3B5ID0gZXJyOworCQlkLm1ldGFjb3B5ID0g
dXBwZXJtZXRhY29weSA9IGVycjsKIAkJbWV0YWNvcHlfc2l6ZSA9IGVycjsKIAotCQlpZiAoIW92
bF9jaGVja19uZXh0cmVkaXJlY3QoJmQpKSB7CisJCWlmICghb3ZsX2NoZWNrX2ZvbGxvd19yZWRp
cmVjdCgmZCkpIHsKIAkJCWVyciA9IC1FUEVSTTsKIAkJCWdvdG8gb3V0X2ZyZWVfb2U7CiAJCX0K
QEAgLTEzNTIsNyArMTM0MCw3IEBAIHN0cnVjdCBkZW50cnkgKm92bF9sb29rdXAoc3RydWN0IGlu
b2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwKIAkJCS51cHBlcmRlbnRyeSA9IHVwcGVy
ZGVudHJ5LAogCQkJLm9lID0gb2UsCiAJCQkuaW5kZXggPSBpbmRleCwKLQkJCS5yZWRpcmVjdCA9
IHVwcGVycmVkaXJlY3QsCisJCQkucmVkaXJlY3QgPSBkLnVwcGVycmVkaXJlY3QsCiAJCX07CiAK
IAkJLyogU3RvcmUgbG93ZXJkYXRhIHJlZGlyZWN0IGZvciBsYXp5IGxvb2t1cCAqLwpAQCAtMTM5
NCw3ICsxMzgyLDcgQEAgc3RydWN0IGRlbnRyeSAqb3ZsX2xvb2t1cChzdHJ1Y3QgaW5vZGUgKmRp
ciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCQlrZnJlZShvcmlnaW5fcGF0aCk7CiAJfQogCWRw
dXQodXBwZXJkZW50cnkpOwotCWtmcmVlKHVwcGVycmVkaXJlY3QpOworCWtmcmVlKGQudXBwZXJy
ZWRpcmVjdCk7CiBvdXQ6CiAJa2ZyZWUoZC5yZWRpcmVjdCk7CiAJb3ZsX3JldmVydF9jcmVkcyhv
bGRfY3JlZCk7Ci0tIAoyLjM0LjEKCg==
--0000000000000c693d0632543502--


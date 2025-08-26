Return-Path: <linux-fsdevel+bounces-59164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90043B35559
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7AF3ADFE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D402D3A74;
	Tue, 26 Aug 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwmBvE3z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A6284678;
	Tue, 26 Aug 2025 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192789; cv=none; b=OauZ88ZVPjqj/754xju0wdc0U9ASpKHFRvfBM4DsWlvFo0qC/x3ZHn7fdUBgp/e7rPDMMxwMPWS/f1hkGmPFAOprzatdJ9aa8yQdpIJtqdtPXde3kmBz7Rzl68IZXrlOylG6nVuZgwAhmTEFNYceNXuPDpahqBa5I4gcJYbQUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192789; c=relaxed/simple;
	bh=FCYDQRaxBE619p0CdPgEqarMbgb7kYkJxWSLT0syhSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnNAmal+qXQD+hQPZ1UoXtnZCuW/gGPqiAu069W7rF21dVMbEA2zqKq4dAl1j3inO3xz0Mq+au37zt0ZSumBlONFMJ0vuTTToNQsK39KVYk4RAup0YGDa4Xnn+ds10qztt29Gzf7zK3kBfoTzZV12KbRjovmjWk0yBJu0r0pf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwmBvE3z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c5270f981so3324437a12.2;
        Tue, 26 Aug 2025 00:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192785; x=1756797585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whb5Vbqx3qHavw+KyEbt1GhcLnpNE1ZZFoOoG441dJ4=;
        b=FwmBvE3zeAbk+43x3NmH1Ur6oYjhPRZ5s8XZA3vUBD2D7tKO/TDs8EhWlFWwbGrDWR
         MJDaccauKnpWn35of6l1gpAFuyakv3gXjxpXKXcj4k4Yc2zeYAsBppWNlQ8QOcKqCRx0
         NeoQ4LX/wz5UMSaq42dgu/yxWtHoajxaE3FY64moyucsy3wJCnafK9SdD03zpCm2itik
         WWuvTGljei1xt1ORDyPaUurBGyxZwfrv9dZEhOsN/5aHvqrnf4yXrGc/mq5NAlATx+QN
         6D/ZQr+2cbwwblirrvlyYGN+b1SXFOhi4qtZ9YkdZH6xMP0R/YbOMhUVxl61U/875Rmd
         Vm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192785; x=1756797585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Whb5Vbqx3qHavw+KyEbt1GhcLnpNE1ZZFoOoG441dJ4=;
        b=tRNw2qcHPb2rFdE91DQgllBsOxHgt1LmjxcHDASXefygZmi1LjKrB/Ta+bVoST5sRO
         VO9cPjkNZkeenSb5xG71RD+b6UVy8+/jDVKXC0p0R6Jcn+kLziPPT8hcLWhiKtXxXU9L
         4Gq7k4r2CO+4/fWQMQnfSu3w2VDVflynK0SxKQe0veHVCD0SnRLJdbXa5cnQ8Be9kMci
         Q95GPyOXQkorpsWCg8niYpPp2g3p101OoLT6QRmLRvxVliHa5rveYkJg2nuH8EuJvHPm
         etx6/yFPegqstsuOxw6n/Wtd5KojNZpBznFg02I9wplgBCQdEqNLjdjW7qIn4ydN5J98
         gojw==
X-Forwarded-Encrypted: i=1; AJvYcCUGHj/oV5iod0hUEyjwc6Q/43IoXIKZJ+fL9vakjTvZhWuVdieBV8jCwPEIlyRWci6iIFRnBlHZKnuBd3fJRw==@vger.kernel.org, AJvYcCVg55NPmDYQXq5l2qqxRT8cva2P1TCqlmqxACeztDtlCJHoqnRXFjt8CBu5Vbyx4Lh/gNsgqBL6z3SxE/bW@vger.kernel.org, AJvYcCWjuNOATHma91jzrnY5pqGEJTfVhhYrFcvquvPSJ1zYm4YiVL4nzn9IXj+ZaNbKTqxcygc/JSEhGcXhq3e0@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/pCnz2P+pJ3tghAzqIngSfB7D93E9LTz0lyzNv5MUiYx0X/u
	q+s6RtNaMKP9xlQIwaakqxys/zcla8gtOXiHDwHzTcxAJehAEsA2CAUChOcK9VuvOEnyvio75nC
	jhiPmN0SG7RRy+53TkNsTfkP6l0ExCfg=
X-Gm-Gg: ASbGncvrSihBTWAl/8u1L1utjjpZofN89IevRpYUIJUXwopdtcmoRisoHUX1qS1sXyK
	sdePnHfVR71Dq7Jf5ZD5LT1heal5wTP+nVn+o3192IsCgmEe/qbEIhoB0ny2l6khFiIW1ynvx+w
	oaoG/G7IO+X9VN3u+GaoWAiP1pqjh6FJa4r9R3+Bt+cTuPTEBKn6GqwHrm45ALoWx9qRH7I++fo
	KKUvb4=
X-Google-Smtp-Source: AGHT+IGWRR3IoFb9rXkgstMZf6WaAXyfH7M1wjJeBqHyJbf+SfRkVKVf4v1e5KS26sNTWed5FJ+3HuTg37cSuEnL0GM=
X-Received: by 2002:a05:6402:34d3:b0:61c:7090:c7e4 with SMTP id
 4fb4d7f45d1cf-61c7090d6e6mr4803216a12.27.1756192785247; Tue, 26 Aug 2025
 00:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com> <875xeb64ks.fsf@mailhost.krisman.be>
 <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
 <CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
 <871poz4983.fsf@mailhost.krisman.be> <87plci3lxw.fsf@mailhost.krisman.be>
In-Reply-To: <87plci3lxw.fsf@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 Aug 2025 09:19:32 +0200
X-Gm-Features: Ac12FXyeOpeoWhepJ0_Dtq0PA8DvRY4QuYbP2ZXy-vgy5hnpkm6S3QpYkjeoEsw
Message-ID: <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:34=E2=80=AFAM Gabriel Krisman Bertazi <krisman@su=
se.de> wrote:
>
> Gabriel Krisman Bertazi <gabriel@krisman.be> writes:
>
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> >> On Mon, Aug 25, 2025 at 5:27=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com> wrote:
> >>>
> >>> On Mon, Aug 25, 2025 at 1:09=E2=80=AFPM Gabriel Krisman Bertazi
> >>> <gabriel@krisman.be> wrote:
> >>> >
> >>> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
> >>> >
> >>> > > To add overlayfs support casefold layers, create a new function
> >>> > > ovl_casefold(), to be able to do case-insensitive strncmp().
> >>> > >
> >>> > > ovl_casefold() allocates a new buffer and stores the casefolded v=
ersion
> >>> > > of the string on it. If the allocation or the casefold operation =
fails,
> >>> > > fallback to use the original string.
> >>> > >
> >>> > > The case-insentive name is then used in the rb-tree search/insert=
ion
> >>> > > operation. If the name is found in the rb-tree, the name can be
> >>> > > discarded and the buffer is freed. If the name isn't found, it's =
then
> >>> > > stored at struct ovl_cache_entry to be used later.
> >>> > >
> >>> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >>> > > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >>> > > ---
> >>> > > Changes from v6:
> >>> > >  - Last version was using `strncmp(... tmp->len)` which was causi=
ng
> >>> > >    regressions. It should be `strncmp(... len)`.
> >>> > >  - Rename cf_len to c_len
> >>> > >  - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
> >>> > >  - Remove needless kfree(cf_name)
> >>> > > ---
> >>> > >  fs/overlayfs/readdir.c | 113 +++++++++++++++++++++++++++++++++++=
+++++---------
> >>> > >  1 file changed, 94 insertions(+), 19 deletions(-)
> >>> > >
> >>> > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> >>> > > index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efb=
f14991e97cee169400d823b 100644
> >>> > > --- a/fs/overlayfs/readdir.c
> >>> > > +++ b/fs/overlayfs/readdir.c
> >>> > > @@ -27,6 +27,8 @@ struct ovl_cache_entry {
> >>> > >       bool is_upper;
> >>> > >       bool is_whiteout;
> >>> > >       bool check_xwhiteout;
> >>> > > +     const char *c_name;
> >>> > > +     int c_len;
> >>> > >       char name[];
> >>> > >  };
> >>> > >
> >>> > > @@ -45,6 +47,7 @@ struct ovl_readdir_data {
> >>> > >       struct list_head *list;
> >>> > >       struct list_head middle;
> >>> > >       struct ovl_cache_entry *first_maybe_whiteout;
> >>> > > +     struct unicode_map *map;
> >>> > >       int count;
> >>> > >       int err;
> >>> > >       bool is_upper;
> >>> > > @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry=
_from_node(struct rb_node *n)
> >>> > >       return rb_entry(n, struct ovl_cache_entry, node);
> >>> > >  }
> >>> > >
> >>> > > +static int ovl_casefold(struct unicode_map *map, const char *str=
, int len, char **dst)
> >>> > > +{
> >>> > > +     const struct qstr qstr =3D { .name =3D str, .len =3D len };
> >>> > > +     int cf_len;
> >>> > > +
> >>> > > +     if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(st=
r, len))
> >>> > > +             return 0;
> >>> > > +
> >>> > > +     *dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
> >>> > > +
> >>> > > +     if (dst) {

Andre,

Just noticed this is a bug, should have been if (*dst), but anyway followin=
g
Gabriel's comments I have made this change in my tree (pending more
strict related changes):

static int ovl_casefold(struct ovl_readdir_data *rdd, const char *str, int =
len,
                        char **dst)
{
        const struct qstr qstr =3D { .name =3D str, .len =3D len };
        char *cf_name;
        int cf_len;

        if (!IS_ENABLED(CONFIG_UNICODE) || !rdd->map || is_dot_dotdot(str, =
len))
                return 0;

        cf_name =3D kmalloc(NAME_MAX, GFP_KERNEL);
        if (!cf_name) {
                rdd->err =3D -ENOMEM;
                return -ENOMEM;
        }

        cf_len =3D utf8_casefold(rdd->map, &qstr, *dst, NAME_MAX);
        if (cf_len > 0)
                *dst =3D cf_name;
        else
                kfree(cf_name);

        return cf_len;
}

> >>> > > +             cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX=
);
> >>> > > +
> >>> > > +             if (cf_len > 0)
> >>> > > +                     return cf_len;
> >>> > > +     }
> >>> > > +
> >>> > > +     kfree(*dst);
> >>> > > +     return 0;
> >>> > > +}
> >>> >
> >>> > Hi,
> >>> >
> >>> > I should just note this does not differentiates allocation errors f=
rom
> >>> > casefolding errors (invalid encoding).  It might be just a theoreti=
cal
> >>> > error because GFP_KERNEL shouldn't fail (wink, wink) and the rest o=
f the
> >>> > operation is likely to fail too, but if you have an allocation fail=
ure, you
> >>> > can end up with an inconsistent cache, because a file is added unde=
r the
> >>> > !casefolded name and a later successful lookup will look for the
> >>> > casefolded version.
> >>>
> >>> Good point.
> >>> I will fix this in my tree.
> >>
> >> wait why should we not fail to fill the cache for both allocation
> >> and encoding errors?
> >>
> >
> > We shouldn't fail the cache for encoding errors, just for allocation er=
rors.
> >
> > Perhaps I am misreading the code, so please correct me if I'm wrong.  i=
f
> > ovl_casefold fails, the non-casefolded name is used in the cache.  That
> > makes sense if the reason utf8_casefold failed is because the string
> > cannot be casefolded (i.e. an invalid utf-8 string). For those strings,
> > everything is fine.  But on an allocation failure, the string might hav=
e
> > a real casefolded version.  If we fallback to the original string as th=
e
> > key, a cache lookup won't find the entry, since we compare with memcmp.

Just to make it clear in case the name "cache lookup" confuses anyone
on this thread - we are talking about ovl readdir cache, not about the vfs
lookup cache, the the purpose of ovl readdir cache is twofold:
1. plain in-memory readdir cache
2. (more important to this discussion) implementation of "merged dir" conte=
nt

So I agree with you that with non-strict mode, invalid encoded names
should be added to readdir cache as is and not in the case of allocation
failure.

>
> I was thinking again about this and I suspect I misunderstood your
> question.  let me try to answer it again:
>
> Ext4, f2fs and tmpfs all allow invalid utf8-encoded strings in a
> casefolded directory when running on non-strict-mode.  They are treated
> as non-encoded byte-sequences, as if they were seen on a case-Sensitive
> directory.  They can't collide with other filenames because they
> basically "fold" to themselves.
>
> Now I suspect there is another problem with this series: I don't see how
> it implements the semantics of strict mode.  What happens if upper and
> lower are in strict mode (which is valid, same encoding_flags) but there
> is an invalid name in the lower?  overlayfs should reject the dentry,
> because any attempt to create it to the upper will fail.

Ok, so IIUC, one issue is that return value from ovl_casefold() should be
conditional to the sb encoding_flags, which was inherited from the layers.

Again, *IF* I understand correctly, then strict mode ext4 will not allow
creating an invalid-encoded name, but will strict mode ext4 allow
it as a valid lookup result?

>
> Andr=C3=A9, did you consider this scenario?

In general, as I have told Andre from v1, please stick to the most common
configs that people actually need.

We do NOT need to support every possible combination of layers configuratio=
ns.

This is why we went with supporting all-or-nothing configs for casefolder d=
irs.
Because it is simpler for overlayfs semantics and good enough for what
users need.

So my question is to you both: do users actually use strict mode for
wine and such?
Because if they don't I would rather support the default mode only
(enforced on mount)
and add support for strict mode later per actual users demand.

> You can test by creating a file
> with an invalid-encoded name in a casefolded directory of a
> non-strict-mode filesystem and then flip the strict-mode flag in the
> superblock.  I can give it a try tomorrow too.

Can the sb flags be flipped in runtime? while mounted?
I suppose you are talking about an offline change that requires
re-mount of overlayfs and re-validate the same encoding flags on all layers=
?

Andre,

Please also add these and other casefold functional tests to fstest to
validate correctness of the merge dir implementation with different
casefold variants in different layers.

Thanks,
Amir.


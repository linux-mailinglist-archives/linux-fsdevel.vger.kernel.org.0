Return-Path: <linux-fsdevel+bounces-59092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE385B345DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9FA3A3715
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79E2FDC42;
	Mon, 25 Aug 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcJ2SQVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0020CCCA;
	Mon, 25 Aug 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136086; cv=none; b=r03haZrOLbRi214RURa/oRTb/edXhfxiQfPeXKdwT6aSgVzQAzS2X3efgUDWgF7eGUtE5u/Ojnxm/tC/YV9FXZRy+67IkALo1AaSVVoN5JDj4abB+DIRCSKee5f8OJvQTPMwYul46nOD34lLY2WE+KUxyZqemsFQ6WSeu4RgQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136086; c=relaxed/simple;
	bh=x7qzppbTQl1GJ5PFt5rBe3/LIJVkm/1nmmz6Bpc9ytE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu+ahj1Ur+cQHPfGu6j2eqEVSkEpS/41s1kxAQ7La0+p8778wk458kHLhIS/k/xaXRwKmbP6qUpCRz8oJUJw9p59mN2h3e2ClNKj7GOADZJUuw7F7smCZwJzGYYPEnSbPTel5K/tmigbLraCBJxyWR1T058FiNU9st0orUKdYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcJ2SQVP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61c5270f981so2123098a12.2;
        Mon, 25 Aug 2025 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756136083; x=1756740883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86RxKERaEqqSk/iiydk9JGFIq/XdY3/bhXKEjRDBX98=;
        b=jcJ2SQVPSu1uELk6IwlrZBNSMfFQmTp2PM1mQ/R7yeXQaMls72EJDygruxC+EoiZy1
         8XTlamOQoA9lKH01VFdBuH/I0lkDTb68PXQHA/ftEVEaqvV/ZJ/bZSSudEWEf5KbzoTq
         jsz4kl8O6+c8iRATLnqTkzjcvSVPh0euY02PhP6qY5ALK9xzYoXtQG0AEUHt2dbgzKb/
         ATFm4DohAhBPJDFH6QWo1wRQuF/uUZnxrd0DR3Y43nQKFlmniQuN6M3ipFLF6SsspE6f
         Lph5oXJ6sCaGfx0Rhiv+7KaoVjJ8/eXRPV3IMVBES9CADU+VBN8Qw7H3tDFsjYq42z1E
         zJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756136083; x=1756740883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86RxKERaEqqSk/iiydk9JGFIq/XdY3/bhXKEjRDBX98=;
        b=jJlxZ8fVOr1lQqbkF+C0amaRmNqZHPTvMwRZUGm4OqOmscNgsUjm/1J3eXs4HGwEOH
         5jBPOi7jWTAYSmMOhUwyWQukbZmR48m5ftBQuu4PzSVHeEciApVU43P7s8pUFZ6Q/pSe
         gSn/S83ygl6LPr4qEOg6ZhORpQuNy/YC6hUHXx/2oayb0BNx1ieVaGr+8UHyVx1+WBPw
         szIp6KpTow/zqd+ZZlivrp1tq/nhkMz9m1TT3QSPzkHkTkoplPEvk/69azH/l1bphDCH
         hOswWHyMoVpK+ZeQqlILovgowvRQRoqTjcOpROnxBPucQ5iM3gjsH4Bxs6MzROqDKnXE
         5MBA==
X-Forwarded-Encrypted: i=1; AJvYcCUFw52nUkWRVDxipMMRsc0uFRgb+Z2fwM6U7h4HhBgTHXu7Wr2Lnya/XOzTa5/L0oNe0w/crDXcoGuf2vM5@vger.kernel.org, AJvYcCXgvyARGjU40STznWYJUIiURPFM4A9hN9qRUVO3/NoqprM57NA8f0nTubJPADYZde3tH881k4rr8vA5UEkjBQ==@vger.kernel.org, AJvYcCXk5O4Fjqjz9VBhfSTF3geXkxI1Hxm9saDwvsotlZfSfyXINCFeQ3/1nolTYLxY9dZO2aB8U2e9lxSQfIeC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HBFUQfvfMxKqYdIIPs2P9PImgHruZZ5/fRqUxyU0xLQthWvm
	gTpyZbKKhB/K8nuv+Ykz6tpMyLoLsT/EET2qDDTVxGk0d2jqYLZM4N6dpJ5HoQkCSaRf3QQKlI/
	zGod32LsVlgl1Y9tNunzbpdjb9/u9w64=
X-Gm-Gg: ASbGncv+iZJzQujBiADeFJLqPS5L/NRQU75RGlgSkqV22+D2q5/IrdYBeXZgHbv056z
	ZAd0vPDbQ3oUhvRHckuzd1dAOcweIzfPvxgFk+KS5iVRVys2H5wx3HFzqYQnI2wmpcYGQrRag6S
	lHOuyRo+qeTSkp8BH4teY7Ezy4HJnaLJ6gM+qVv5snnu9+1NOrxiIYoT7hFmE2FGVCeF4hJd29P
	yLDkFM=
X-Google-Smtp-Source: AGHT+IF9xncTRs7Z2QHXsi+RbcbmLMaY6wXtnQvSS+hLN7df3eW+RT1vRSvZ03zXVaKSJndkM8yQ3rwcuecd2aa3lOs=
X-Received: by 2002:a05:6402:2710:b0:618:363a:2c86 with SMTP id
 4fb4d7f45d1cf-61c1b45bd99mr10770158a12.7.1756136082962; Mon, 25 Aug 2025
 08:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-6-8b6e9e604fa2@igalia.com> <87wm6r4pbf.fsf@mailhost.krisman.be>
In-Reply-To: <87wm6r4pbf.fsf@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Aug 2025 17:34:31 +0200
X-Gm-Features: Ac12FXwM_-mloXuAmheRNJDEbYHMTNaIGnfPikkqiWLNHr0K8CbnIYDTHb0I78E
Message-ID: <CAOQ4uxjBcwhOfbR2cCmQgQFMLDwoxfiTMMBHtGejm=m5mtz-xg@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] ovl: Set case-insensitive dentry operations for
 ovl sb
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:24=E2=80=AFPM Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>
> > For filesystems with encoding (i.e. with case-insensitive support), set
> > the dentry operations for the super block as ovl_dentry_ci_operations.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> > Changes in v6:
> > - Fix kernel bot warning: unused variable 'ofs'
> > ---
> >  fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index b1dbd3c79961094d00c7f99cc622e515d544d22f..8db4e55d5027cb975fec9b9=
2251f62fe5924af4f 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -161,6 +161,16 @@ static const struct dentry_operations ovl_dentry_o=
perations =3D {
> >       .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
> >  };
> >
> > +#if IS_ENABLED(CONFIG_UNICODE)
> > +static const struct dentry_operations ovl_dentry_ci_operations =3D {
> > +     .d_real =3D ovl_d_real,
> > +     .d_revalidate =3D ovl_dentry_revalidate,
> > +     .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
> > +     .d_hash =3D generic_ci_d_hash,
> > +     .d_compare =3D generic_ci_d_compare,
> > +};
> > +#endif
> > +
> >  static struct kmem_cache *ovl_inode_cachep;
> >
> >  static struct inode *ovl_alloc_inode(struct super_block *sb)
> > @@ -1332,6 +1342,19 @@ static struct dentry *ovl_get_root(struct super_=
block *sb,
> >       return root;
> >  }
> >
> > +static void ovl_set_d_op(struct super_block *sb)
> > +{
> > +#if IS_ENABLED(CONFIG_UNICODE)
> > +     struct ovl_fs *ofs =3D sb->s_fs_info;
> > +
> > +     if (ofs->casefold) {
> > +             set_default_d_op(sb, &ovl_dentry_ci_operations);
> > +             return;
> > +     }
> > +#endif
> > +     set_default_d_op(sb, &ovl_dentry_operations);
> > +}
> > +
> >  int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >       struct ovl_fs *ofs =3D sb->s_fs_info;
> > @@ -1443,6 +1466,8 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
> >       if (IS_ERR(oe))
> >               goto out_err;
> >
> > +     ovl_set_d_op(sb);
> > +
>
> Absolutely minor, but fill_super is now calling
> set_default_d_op(sb, &ovl_dentry_operations) twice, once here and once
> at the beginning of the function.  You can remove the original call.

Good catch!

That was not my intention at all.
I asked to replace the set_default_d_op() call with ovl_set_d_op()
but I missed that in the review.

Will fix it in my tree.

Thanks!
Amir.


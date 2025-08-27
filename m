Return-Path: <linux-fsdevel+bounces-59350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C46B37ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09C636429A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40857343D6C;
	Wed, 27 Aug 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCtW1Gp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443F1D5150;
	Wed, 27 Aug 2025 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286906; cv=none; b=sqyMFGLTaWIVr+Kk4w0UIm6VOu5Syqi5G0/byVXp0f/DZNrkJ2OlnPjyRRuX6NQ8Hjiz1mkUf44okRZFKs+ljmsFwTM+rkWU89s8Prd226egwdV3s2Tmv732Mzk2LSlIwS3O0LDfsTQn3cfqu7h4e7rFxjQZD/RldLa8dkgqHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286906; c=relaxed/simple;
	bh=PfxoAIwcb5X5b4fUYMVVmVFZvGyrGoz5/mNQu2gy8P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3LcBdzV5ilHpV8wJasQpaOlb5B9cHhRiB7TElj8UwlBl3l7jw9u5+zG01AHWq5bQ2pH9304ZPvQuHGcfxkgqBFkXDzXRhwXylyVLFKfjMS52yRFkZ3vUG7m6f0WlHIyWDN0MAX8WNmZd9D4bPRDD6uM/amml5zOh0rJLzy8DPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCtW1Gp2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf6fso9817413a12.1;
        Wed, 27 Aug 2025 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756286903; x=1756891703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afRMvMz52lErLIy3TkQ3+HE1dlvb4ERfwloctYrSfu8=;
        b=fCtW1Gp2RxkSVm4XOotHfDa8NMA11TBIpIRMPA4BdAF327F8/9ySqNSRUOxxaw7yj1
         1Wn4RvKzSxBnLlzKX4LzxHQ8SJBq9q3YmecIUpBvMbVoFmHcqOp25cmOSxrXkOVYH0r/
         7H8fcMn3dcxcdDc9MnhpOlHCg+X/q43QdtBoZ0WRmGXEkVP8N30BpnIjAxtaKNcA484v
         obAVFfVtBUxHtYIwq9fl/ZHp81+pMki6SFoEmIJ2/fAL5y65f1aB7nMY+uRzGP2/iPSX
         KhqOoNBnvbyWAYeH6N7cOfqOpPkZ8MeQEATdLkqIPeT+beqjMWjvtYg1Z48iM7zJW+Yb
         iTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756286903; x=1756891703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afRMvMz52lErLIy3TkQ3+HE1dlvb4ERfwloctYrSfu8=;
        b=TGMqAORxy3vEM+yUuCeZMuFlo1xARfUDebvezn1mN85cFbkhSzJJbkGojYyjGjz5ZV
         iNJWDi4ScXHHe44GJmflV+eoJhXLlHtcDh16KuciB24p+k0AwTMoom8zAX38kO2vWp32
         a6GfxtpZccSqTWAu7xR/G7SlkTbRkJOT0ywXugq19Y70L759NNj1834SI7XKJZ+db5Vu
         Q1UuK4Wf/rwP8hNbn7RHKZ7paP0o57HBg1fLGcQXsFyCVOa8qbF0JkZp/nQrkupqa5SV
         85JAom0PyAZECyQIl/vfC75zCH/Yk+a64I6LpUiblP3GcwuA1pq/+d+x037nac/L+QAb
         cDQw==
X-Forwarded-Encrypted: i=1; AJvYcCVJidUVUxGB5hhD5nqKCJWBT7gxQ5rHYrm9M47NnZckUKH1HxqCthJIiXxOTxy71omYIUvjyyVIY0rCAAIx@vger.kernel.org, AJvYcCVeFk6lBR+4Sn4GIV2xzlmFdWRzomiOmBSIKsRLPK+F9rn3bTzU0ElBaxpawbrAprDdtAKxLgJXMPjzTzcxUQ==@vger.kernel.org, AJvYcCVpwDzVV4MGpBwVwX/La0ka9cgGbco56dTN248liW3sK5/ph7g5E8SaOx+SSO46oFjzMwpWmNcbThIHnvFt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gHc/+K15ZpbUsMs/q2Ar/9kYNW5LGy0oWwyz3fHDDgC/wfxZ
	JKdvB7/E6P6zcaBnljDi5621HRDI/z6E0y+GDK6OPgU9zLq7dmFyJCKx/0HT+nraISG/zDF7mQR
	CVjpQdd04CekTFFhoU9yeR0ZhwOmeJLI=
X-Gm-Gg: ASbGncv1QGwdNkU1KpjycecKtdZL3BBtitA4rGgKawmlSdrSzlsFcQ9ZXiPjFZrUGQH
	8soM+v3G4Bg8ziTrvUm/XNOWPhoJ6fVFP0Y2Tmdfl/aEnLQE+nY/VNEr5vr9x7JPqC/fHr6HxeV
	7rcTbDymlfLUS7gAdOkPhDebE+1aryigW0A8FGd21DcZO+rRoEb7277dv5DPVhr1jEb7t1qfkfY
	igPZvo=
X-Google-Smtp-Source: AGHT+IGPmcUFgcc9N6VZGuWev475Iqh/3cbemwbh7T5FmHXerjzXVncjDuoQZvhgJ1TFiIWjpSflcF4M5su57L0iUWU=
X-Received: by 2002:a05:6402:13d0:b0:61c:35c0:87ee with SMTP id
 4fb4d7f45d1cf-61c35c091b0mr12625331a12.7.1756286903051; Wed, 27 Aug 2025
 02:28:23 -0700 (PDT)
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
 <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com>
 <87ldn62kjy.fsf@mailhost.krisman.be> <564e46ac-a605-4b20-bb48-444bf7141ab5@igalia.com>
In-Reply-To: <564e46ac-a605-4b20-bb48-444bf7141ab5@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Aug 2025 11:28:11 +0200
X-Gm-Features: Ac12FXwH-ZjnCeErtmUkz32-EBRGSswusBsaCuX6PmlcQ4ri1VqgMyN2js2w0J8
Message-ID: <CAOQ4uxjOZMq6RYsB5qSVkYPTjd1m4=sr9HbP1kBCD0oLWPwHAQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:58=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
>
>
> Em 26/08/2025 12:02, Gabriel Krisman Bertazi escreveu:
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> >> On Tue, Aug 26, 2025 at 3:34=E2=80=AFAM Gabriel Krisman Bertazi <krism=
an@suse.de> wrote:
> >>
> >>>
> >>> I was thinking again about this and I suspect I misunderstood your
> >>> question.  let me try to answer it again:
> >>>
> >>> Ext4, f2fs and tmpfs all allow invalid utf8-encoded strings in a
> >>> casefolded directory when running on non-strict-mode.  They are treat=
ed
> >>> as non-encoded byte-sequences, as if they were seen on a case-Sensiti=
ve
> >>> directory.  They can't collide with other filenames because they
> >>> basically "fold" to themselves.
> >>>
> >>> Now I suspect there is another problem with this series: I don't see =
how
> >>> it implements the semantics of strict mode.  What happens if upper an=
d
> >>> lower are in strict mode (which is valid, same encoding_flags) but th=
ere
> >>> is an invalid name in the lower?  overlayfs should reject the dentry,
> >>> because any attempt to create it to the upper will fail.
> >>
> >> Ok, so IIUC, one issue is that return value from ovl_casefold() should=
 be
> >> conditional to the sb encoding_flags, which was inherited from the
> >> layers.
> >
> > yes, unless you reject mounting strict_mode filesystems, which the best
> > course of action, in my opinion.
> >
> >>
> >> Again, *IF* I understand correctly, then strict mode ext4 will not all=
ow
> >> creating an invalid-encoded name, but will strict mode ext4 allow
> >> it as a valid lookup result?
> >
> > strict mode ext4 will not allow creating an invalid-encoded name. And
> > even lookups will fail.  Because the kernel can't casefold it, it will
> > assume the dirent is broken and ignore it during lookup.
> >
> > (I just noticed the dirent is ignored and the error is not propagated i=
n
> > ext4_match.  That needs improvement.).
> >
> >>>
> >>> Andr=C3=A9, did you consider this scenario?
> >>
> >> In general, as I have told Andre from v1, please stick to the most com=
mon
> >> configs that people actually need.
> >>
> >> We do NOT need to support every possible combination of layers configu=
rations.
> >>
> >> This is why we went with supporting all-or-nothing configs for casefol=
der dirs.
> >> Because it is simpler for overlayfs semantics and good enough for what
> >> users need.
> >>
> >> So my question is to you both: do users actually use strict mode for
> >> wine and such?
> >> Because if they don't I would rather support the default mode only
> >> (enforced on mount)
> >> and add support for strict mode later per actual users demand.
> >
> > I doubt we care.  strict mode is a restricted version of casefolding
> > support with minor advantages.  Basically, with it, you can trust that
> > if you update the unicode version, there won't be any behavior change i=
n
> > casefolding due to newly assigned code-points.  For Wine, that is
> > irrelevant.
> >
> > You can very well reject strict mode and be done with it.
> >
>
> Amir,
>
> I think this can be done at ovl_get_layers(), something like:
>
> if (sb_has_strict_encoding(sb)) {
>         pr_err("strict encoding not supported\n");
>         return -EINVAL;
> }
>

Yap, I've put it into ovl_set_encoding() to warn more accurately
on upper fs:

/*
 * Set the ovl sb encoding as the same one used by the first layer
 */
static int ovl_set_encoding(struct super_block *sb, struct super_block *fs_=
sb)
{
        if (!sb_has_encoding(fs_sb))
                return 0;

#if IS_ENABLED(CONFIG_UNICODE)
        if (sb_has_strict_encoding(fs_sb)) {
                pr_err("strict encoding not supported\n");
                return -EINVAL;
        }

        sb->s_encoding =3D fs_sb->s_encoding;
        sb->s_encoding_flags =3D fs_sb->s_encoding_flags;
#endif
        return 0;
}

Thanks,
Amir.


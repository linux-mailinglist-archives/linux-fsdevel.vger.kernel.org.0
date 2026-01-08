Return-Path: <linux-fsdevel+bounces-72800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AC4D03D0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6210305779E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF32394466;
	Thu,  8 Jan 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFTbOHCv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEA394491
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859378; cv=none; b=DrPL7RVqyLM448R9rUtI+mP9M9hc3TLsmUJSeCxGFZwtCi/6ew8FiSe1Vtwb1HG+abW1U1sLaOmq7OZBJ7SBFh+pbPGj++FbsavY8B2e2LdezX279Kx+bnsJodwa5BTqr3yrzHIbF703yPku+yh1cSCRMCHjVcgq3kG5245JluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859378; c=relaxed/simple;
	bh=AKbH/a0d3Gg3EIYo09XhzuZ9ISZZWY4zas6GYz8jGZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0ZM32eE5YHvAcrIQSbCCL7pPfhLvKqGy3vF9UlU5tEZbY73YdV5/Je812l/AcsbhYeWdzIakzAKSE8PC1dH6FCiBJ9qBvD1jqQszzs7QMVtgyn+0FCILThWgFaq84yNwDoqhn2hBJtil1rwKUlNaOfpXmAO5YoRc9hzoDAR5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFTbOHCv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso4434903a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 00:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767859346; x=1768464146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+SJerwHTLA8+W0cwIZXklA1oFCTKpQgbkxKozR1NC4=;
        b=FFTbOHCv/wT80vMZsBLYHSPNYnUsX78NOIziUyAb8pmXvw64fu5UTx572zWv9hAmn5
         OPn37QCUbELpB9dL77LpjadOPWg3Nzl+4bQ1CWQweH/oUWEJ6Bw/gKtuUFDgkaoWrNGq
         ad+c3GPXTzT55Le8omLO8xAwSpmIOzQnxQcsOxtpaaKKo4FatMS7oy6FTjByEcgomEkv
         GFdjrV5hB5gYYBJ1Flbhks7IeKwf5ywADJm8qUalrfq0UusT1DN5XS3e1tgffbglMFB+
         JSnqd83R0e8aikkEEqji3wR673TQ654JVRkOi5NzNoy3g+JvhKT9q+OcyXosluM0DytX
         MosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767859346; x=1768464146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+SJerwHTLA8+W0cwIZXklA1oFCTKpQgbkxKozR1NC4=;
        b=dYFuLUlBaIyWM6lFG5CXf/9n+Gzv9EXjOU40qsSDe0MIm29TXsmfdiIMqiboDc/Qbm
         U223TvfrdIRSt4gNfuI/jnngOjMOIfbTCRoUezpaheF98DwzicJlD/BRgITE+U1TwaIe
         pAU5FQ2TnEwU0LyXaX0YwVKtAGNfHzbmo/mOopEtzqKrU+8BLrqhcm0ClZvCKqxpvOXy
         FQAbXg7g++1nsf8C81WbHMOK1h2DZsbEXyL8FapghNNjf/VfkeRH1cGXgondjTKKAVHB
         ADzP5tq5sUCrNwonKVqqXhxMn2khFRLcAY+CmEnqWGdkMkBVlqQZH753GkpEMw10RAms
         rD4A==
X-Forwarded-Encrypted: i=1; AJvYcCVGSe/SErv918jbapCYo6GqzkQUTVUbhVwwyTZ+BM9qZHn/IQYrKpai4UQa9nk0zRTczGVUNMy69Z/5PhgC@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxdcb26q4LEPHwupyxXZGa6mSmkDysp7yue5X68dgHvP3Gt+X
	y9BWAhTIeWpHWljheIuJiPcPcWJH2RHG81A1aFXcaiNsNgM823MKzSgEv3ZcONKrMFgvSjjLChX
	dOZRG/9VpBPpsUz9kMQ+mqlTzqyXQYME=
X-Gm-Gg: AY/fxX6rVuGiCIBGA91gc1Kp/8VyZNVxHOBfet3pft4JWfPWdy75CusO/4cIFAVdtIo
	BpLRoWzjHU5Q+98CVMnAi1Aa9+N+Qkt5+wu/BPQdYlmNp9XdRRIwLNHW3SGOlhBU8llPkcNBEf0
	13MpBfrzBRenaL22DoIvcR7+QpnkZG0iQKCrCp3L9IurAW7njtNp9FFQYb/Hn2sw1fQsk76Haf7
	Gz3mOoUROS5vNJ59EFffqdhJ87mRNODHXJ/fi+hwTMYHiiGpITSQOixtAiQSt1jEcIELuXcsmcM
	7HnGiZiwAIHlikejKleuVO7guiBxyw==
X-Google-Smtp-Source: AGHT+IFXkdSRTClVJu8PDfr+VI0/zAKJXa2WRH+hFMcOI6dHYlkuVeMFSDVvXjk6XtiM96evO3C0I3EzP/b1zQWzUew=
X-Received: by 2002:a05:6402:1467:b0:64d:1d2b:238f with SMTP id
 4fb4d7f45d1cf-65097e50ce6mr4960585a12.19.1767859345811; Thu, 08 Jan 2026
 00:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com> <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com> <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
In-Reply-To: <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Jan 2026 09:02:14 +0100
X-Gm-Features: AQt7F2qLkHUoZVw4R3ZHu1SqBeK3wO3ETQ2HzFmRIW0uNolONu-M8FMyj9K8OmM
Message-ID: <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>, 
	=?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Alexander Larsson <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>, shengyong1@xiaomi.com, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:10=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2026/1/8 10:32, Gao Xiang wrote:
> > Hi Sheng,
> >
> > On 2026/1/8 10:26, Sheng Yong wrote:
> >> On 1/7/26 01:05, Gao Xiang wrote:
> >>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacki=
ng
> >>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kerne=
l
> >>> stack overflow when stacking an unlimited number of EROFS on top of
> >>> each other.
> >>>
> >>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> >>> (and such setups are already used in production for quite a long time=
).
> >>>
> >>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> >>> from 2 to 3, but proving that this is safe in general is a high bar.
> >>>
> >>> After a long discussion on GitHub issues [1] about possible solutions=
,
> >>> one conclusion is that there is no need to support nesting file-backe=
d
> >>> EROFS mounts on stacked filesystems, because there is always the opti=
on
> >>> to use loopback devices as a fallback.
> >>>
> >>> As a quick fix for the composefs regression for this cycle, instead o=
f
> >>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> >>> nesting file-backed EROFS over EROFS and over filesystems with
> >>> `s_stack_depth` > 0.
> >>>
> >>> This works for all known file-backed mount use cases (composefs,
> >>> containerd, and Android APEX for some Android vendors), and the fix i=
s
> >>> self-contained.
> >>>
> >>> Essentially, we are allowing one extra unaccounted fs stacking level =
of
> >>> EROFS below stacking filesystems, but EROFS can only be used in the r=
ead
> >>> path (i.e. overlayfs lower layers), which typically has much lower st=
ack
> >>> usage than the write path.
> >>>
> >>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after mo=
re
> >>> stack usage analysis or using alternative approaches, such as splitti=
ng
> >>> the `s_stack_depth` limitation according to different combinations of
> >>> stacking.
> >>>
> >>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-=
backed mounts")
> >>> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> >>> Reported-by: Timoth=C3=A9e Ravier <tim@siosm.fr>
> >>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [=
1]
> >>> Reported-by: "Aleks=C3=A9i Naid=C3=A9nov" <an@digitaltide.io>
> >>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1w=
tYN=3Dz0QXwCpec9sXtg@mail.gmail.com
> >>> Acked-by: Amir Goldstein <amir73il@gmail.com>
> >>> Cc: Alexander Larsson <alexl@redhat.com>
> >>> Cc: Christian Brauner <brauner@kernel.org>
> >>> Cc: Miklos Szeredi <mszeredi@redhat.com>
> >>> Cc: Sheng Yong <shengyong1@xiaomi.com>
> >>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> >>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >>> ---
> >>> v2:
> >>>   - Update commit message (suggested by Amir in 1-on-1 talk);
> >>>   - Add proper `Reported-by:`.
> >>>
> >>>   fs/erofs/super.c | 18 ++++++++++++------
> >>>   1 file changed, 12 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> >>> index 937a215f626c..0cf41ed7ced8 100644
> >>> --- a/fs/erofs/super.c
> >>> +++ b/fs/erofs/super.c
> >>> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_blo=
ck *sb, struct fs_context *fc)
> >>>            * fs contexts (including its own) due to self-controlled R=
O
> >>>            * accesses/contexts and no side-effect changes that need t=
o
> >>>            * context save & restore so it can reuse the current threa=
d
> >>> -         * context.  However, it still needs to bump `s_stack_depth`=
 to
> >>> -         * avoid kernel stack overflow from nested filesystems.
> >>> +         * context.
> >>> +         * However, we still need to prevent kernel stack overflow d=
ue
> >>> +         * to filesystem nesting: just ensure that s_stack_depth is =
0
> >>> +         * to disallow mounting EROFS on stacked filesystems.
> >>> +         * Note: s_stack_depth is not incremented here for now, sinc=
e
> >>> +         * EROFS is the only fs supporting file-backed mounts for no=
w.
> >>> +         * It MUST change if another fs plans to support them, which
> >>> +         * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
> >>>            */
> >>>           if (erofs_is_fileio_mode(sbi)) {
> >>> -            sb->s_stack_depth =3D
> >>> -                file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
> >>> -            if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> >>> -                erofs_err(sb, "maximum fs stacking depth exceeded");
> >>> +            inode =3D file_inode(sbi->dif0.file);
> >>> +            if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> >>
> >> Hi, Xiang
> >>
> >> In Android APEX scenario, apex images formatted as EROFS are packed in
> >> system.img which is also EROFS format. As a result, it will always fai=
l
> >> to do APEX-file-backed mount since `inode->i_sb->s_op =3D=3D &erofs_so=
ps'
> >> is true.
> >> Any thoughts to handle such scenario?
> >
> > Sorry, I forgot this popular case, I think it can be simply resolved
> > by the following diff:
> >
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 0cf41ed7ced8..e93264034b5d 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
> >                   */
> >                  if (erofs_is_fileio_mode(sbi)) {
> >                          inode =3D file_inode(sbi->dif0.file);
> > -                       if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> > +                       if ((inode->i_sb->s_op =3D=3D &erofs_sops && !s=
b->s_bdev) ||
>
> Sorry it should be `!inode->i_sb->s_bdev`, I've
> fixed it in v3 RESEND:

A RESEND implies no changes since v3, so this is bad practice.

> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.alibab=
a.com
>

Ouch! If the erofs maintainer got this condition wrong... twice...
Maybe better using the helper instead of open coding this non trivial check=
?

if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
      erofs_is_fileio_mode(EROFS_I_SB(inode)))

Thanks,
Amir.


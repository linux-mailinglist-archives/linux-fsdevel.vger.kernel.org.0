Return-Path: <linux-fsdevel+bounces-64053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E8BD6BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBE6E4E1F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD52D97B8;
	Mon, 13 Oct 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA2rzImz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE692D4B5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398168; cv=none; b=DD0vly/dfwc6IdUUwLsNplmvJ1foVgU6sJv976Cpr5wvxKeBr9eISTgNs9yhIHwf91Who7JgxB+OzKpz3F2S6zqBKS7o8G1zaJ3Ij0CowJiZfk3IQTLVZp/LwsmqVgWH+kIwMy15uhy+aY9FplGSZuxhi4r4xA4Gxi2QYg5EqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398168; c=relaxed/simple;
	bh=SQ0gWNpV8fChoEYMNhzwQKlfjtJr3sfa5X67jWtrJdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=malTdwWtEfQsPgtsGQXLFiZTDv4aVz2FbKudgobdZVISpYwhamZhVXSYwAtLMhrJIQgf0AErQMalF07AGH4ZoDVAmlOdLlmYTlT+zKs0P5Al5fdJJi6nH2lVYrbYqwmHg3ebZWCsg9ox3K8ID8vEeduzapBJv/dPaNJJcEi9bDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA2rzImz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D75CC4CEFE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760398168;
	bh=SQ0gWNpV8fChoEYMNhzwQKlfjtJr3sfa5X67jWtrJdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AA2rzImzN90s32cp8e0uwxg8bh+IjSrBFwpjEddVpnqKHWTywbZioOr0J4+B2+ryR
	 6Vj65aj4/Jbxu5yjl8Tf3filr+PibU/tnHSjELxYuuqqhhgicq0E5yOHhTRhY9GhCa
	 //C/BizcUv+ovNYskkqnpPRn7qXYGMtMin76zujrPEvJsYEE2CAu1GZUx1XkGtDm7D
	 rLlyd9sW1z+Ura6VViHuNKRkQqEf/6aU6qYqQ9loMmIZmUZpad8P+7l13LaYhnHco4
	 swGL1cA6UGnaJbyJhluocGtxILsD0r89J/6htBaI/ycF9tu1yGeolAqfbhk3WUbTxq
	 O/kaCYjnm3V3Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b50645ecfbbso937714166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:29:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqXhQ4HxTsrwn8Rmz4PVSvnMe8MsB6wIr9wa1nK5jBkR4LfSKVzR8/svu3Pv10LcdDduH4Ez1vnLNRPGY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lomhHtNS17e2VkDSXZ2vqUt8W2GLKF19OwMoBmQIg3KSPkN0
	TYPHzhkvUtPxxczpSUUk+EK0675v4/cWIOo5m+iC6PGa4SLtG6X6iyfV2Opb3a1/+J8rVBYBmTK
	gd8i/1wQ69qfwrTVB5Q5YNiW7PmR2650=
X-Google-Smtp-Source: AGHT+IGKMgfNlTuVRjrvwrgGu5wAUKAOzjA5+Qj4nhVCZNyzu4FakDZO2A4HdYX7LTuYYFd1tWuBIeotI0oHcIElStI=
X-Received: by 2002:a17:907:971e:b0:b4c:1ad1:d08c with SMTP id
 a640c23a62f3a-b50aa393b8amr2537644866b.17.1760398166753; Mon, 13 Oct 2025
 16:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013134708.1270704-1-aha310510@gmail.com> <20251013164625.nphymwx25fde5eyk@pali>
In-Reply-To: <20251013164625.nphymwx25fde5eyk@pali>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 14 Oct 2025 08:29:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8bhyHrf=fMRrv2oWeWf8gshGdHd2zb=C40vD632Lgm_g@mail.gmail.com>
X-Gm-Features: AS18NWA2a1YxuJIOARSQtQYwyd5cLkP4zCGhLc1g0fsPOO2REg4pII5pSv2KDSU
Message-ID: <CAKYAXd8bhyHrf=fMRrv2oWeWf8gshGdHd2zb=C40vD632Lgm_g@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Jeongjun Park <aha310510@gmail.com>, Ethan Ferguson <ethan.ferguson@zetier.com>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 1:46=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Monday 13 October 2025 22:47:08 Jeongjun Park wrote:
> > Since the len argument value passed to exfat_ioctl_set_volume_label()
> > from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds read
> > occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.
> >
> > And because of the NLS_NAME_OVERLEN macro, another error occurs when
> > creating a file with a period at the end using utf8 and other iocharset=
s,
> > so the NLS_NAME_OVERLEN macro should be removed and the len argument va=
lue
> > should be passed as FSLABEL_MAX - 1.
> >
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
> > Fixes: 370e812b3ec1 ("exfat: add nls operations")
>
> Fixes: line is for sure wrong as the affected
> exfat_ioctl_set_volume_label function is not available in the mentioned
> commit.
>
> I guess it should be commit d01579d590f72d2d91405b708e96f6169f24775a.
>
> Now I have looked at that commit and I think I finally understood what
> was the issue. exfat_nls_to_utf16() function is written in a way that
> it expects null-term string and its strlen as 3rd argument.
>
> This was achieved for all code paths except the new one introduced in
> that commit. "label" is declared as char label[FSLABEL_MAX]; so the
> FSLABEL_MAX argument in exfat_nls_to_utf16() is effectively
> sizeof(label). And here comes the problem, it should have been
> strlen(label) (or rather strnlen(label, sizeof(label)-1) in case
> userspace pass non-nul term string).
>
> So the change below to FSLABEL_MAX - 1 effectively fix the overflow
> problem. But not the usage of exfat_nls_to_utf16.
>
> API of FS_IOC_SETFSLABEL is defined to always take nul-term string:
> https://man7.org/linux/man-pages/man2/fs_ioc_setfslabel.2const.html
>
> And size of buffer is not the length of nul-term string. We should
> discard anything after nul-term byte.
>
> So in my opinion exfat_ioctl_set_volume_label() should be fixed in a way
> it would call exfat_nls_to_utf16() with 3rd argument passed as:
>
>   strnlen(label, sizeof(label) - 1)
>
> or
>
>   strnlen(label, FSLABEL_MAX - 1)
>
> Or personally I prefer to store this length into new variable (e.g.
> label_len) and then passing it to exfat_nls_to_utf16() function.
> For example:
>
>   ret =3D exfat_nls_to_utf16(sb, label, label_len, &uniname, &lossy);
Right, I agree.
>
> Adding Ethan to CC as author of the mentioned commit.
>
>
> And about NLS_NAME_OVERLEN, it is being used by the
> __exfat_resolve_path() function. So removal of the "setting" of
> NLS_NAME_OVERLEN bit but still checking if the NLS_NAME_OVERLEN bit is
> set is quite wrong.
Right, The use of NLS_NAME_OVERLEN in __exfat_resolve_path() and
in the header should also be removed.
>
>
> Namjae, could you re-check my analysis? Just to be sure that I have not
> misunderstood something. It is better to do proper analysis than having
> incomplete or incorrect fix.
Yes, I agree with your analysis.
Thanks!
>
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  fs/exfat/file.c | 2 +-
> >  fs/exfat/nls.c  | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> > index f246cf439588..7ce0fb6f2564 100644
> > --- a/fs/exfat/file.c
> > +++ b/fs/exfat/file.c
> > @@ -521,7 +521,7 @@ static int exfat_ioctl_set_volume_label(struct supe=
r_block *sb,
> >
> >       memset(&uniname, 0, sizeof(uniname));
> >       if (label[0]) {
> > -             ret =3D exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
> > +             ret =3D exfat_nls_to_utf16(sb, label, FSLABEL_MAX - 1,
> >                                        &uniname, &lossy);
> >               if (ret < 0)
> >                       return ret;
> > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> > index 8243d94ceaf4..57db08a5271c 100644
> > --- a/fs/exfat/nls.c
> > +++ b/fs/exfat/nls.c
> > @@ -616,9 +616,6 @@ static int exfat_nls_to_ucs2(struct super_block *sb=
,
> >               unilen++;
> >       }
> >
> > -     if (p_cstring[i] !=3D '\0')
> > -             lossy |=3D NLS_NAME_OVERLEN;
> > -
> >       *uniname =3D '\0';
> >       p_uniname->name_len =3D unilen;
> >       p_uniname->name_hash =3D exfat_calc_chksum16(upname, unilen << 1,=
 0,
> > --


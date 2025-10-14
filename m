Return-Path: <linux-fsdevel+bounces-64089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA89BD788F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 08:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9791034F782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C182BCF4C;
	Tue, 14 Oct 2025 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuLephhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6440A2C21C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422209; cv=none; b=WCeX5R5chu89f6UDMPDZnD6r+aHtTzofUI87uabSUq72nUx4mNekxcGPTMYSNYthnFux3Ry11WoD+oFXEn0gDvaOWnDFo1h2FiG7waAj6ItJ3ODE2WjqoMsjM8rkFAQNHx3Ljcd/cDrzVOiEjRHgpujzOn4Vsq1iU6myzifxtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422209; c=relaxed/simple;
	bh=79FkngLdByzitiPurcit70xJmkJLaN+TwOHbR2oTuR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERCbyZmnrQh5v2SLjQhgVC7MLmtgmwVgv+GwjGdy3+1ZX/pwRRHUwXaX1BOTailNpdRr3recpcMJn/9jxSSHPQ1IBMiJeKEJSu7qPITrpuOTR68IvMKPg+KsuMUx1hWw1u/MPqZX+gNlzBo5JGL+SyFY1snvBJxzqfKmj7LfaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuLephhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA0EC116D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 06:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760422208;
	bh=79FkngLdByzitiPurcit70xJmkJLaN+TwOHbR2oTuR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kuLephhfxD57M//oJccqMZYB5507yEEUen7UJdRSOXM/k9jQPKCpZRWaZWXWVbOgL
	 /VUtteuryP9SffBiS2zuxVeUhzum3JULU8KK28EOZLZYvpb4G6fJ8n8pNViFnn92yX
	 TaUrNemNaN9ZEroWztyfFZaD91287CU/cNETRz103CQQjgaaCiiHntMw0Xi5OLQiW2
	 W+CY8J6U4Mj3/Siw8JJ+dGS7nVgyyTGd643eavedTYApF4yJXavvFhboBZjXmKzft5
	 sZ/fPI2wc/G6hsHpaghDDeDEDqzWIICmFebul71JGtXl3PErl+Oon5fGvQP/kazsvC
	 xmmUxLXA3SRuw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3d5088259eso738318766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEY9sYnjYDtMF5b/0tPTvtXPI3mUAy16iR5hIJ2sYbLbh3UU/jtI6rabX/TcXtnP5iPaq2K6IPqtGkgr0K@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUCy4SxE8eTpyIGekhbEbaSmmarIlwBjAlf0/UB5v9CEP/s7H
	XUwvKfzj/EWM+5e8LEwyvKm3HT3YkT9GE5FEoRl/KlqVUIlAai3eUpzXBzTnIjWnf9p8PZcv2YQ
	t2NRbxRImuG+Z9lHMMS3wIZrsvmhxv8I=
X-Google-Smtp-Source: AGHT+IF1ClqteeO20q49joylEJPuOBRHUbMKMOsjSsX528jdJGEYW1mrj3fg0H1Zru6dS/zDbCS48FEXlphBYlCy4SA=
X-Received: by 2002:a17:906:6a2a:b0:b42:7c2:1f9f with SMTP id
 a640c23a62f3a-b50acc1aa50mr2523622066b.62.1760422206721; Mon, 13 Oct 2025
 23:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013134708.1270704-1-aha310510@gmail.com> <20251013164625.nphymwx25fde5eyk@pali>
 <CAKYAXd8bhyHrf=fMRrv2oWeWf8gshGdHd2zb=C40vD632Lgm_g@mail.gmail.com> <CAO9qdTHLEEDPWpZeWBq5Awn_wrcpfcYFK4Hhr=AohOhWpQDRcA@mail.gmail.com>
In-Reply-To: <CAO9qdTHLEEDPWpZeWBq5Awn_wrcpfcYFK4Hhr=AohOhWpQDRcA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 14 Oct 2025 15:09:54 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9kL9EGKk5xGuOuG1AhBarYZ8o1UZ3Fx7iLheK0uVB-Xg@mail.gmail.com>
X-Gm-Features: AS18NWAYnFO0rH9xSxpzDOVJvKVli0eC4_KuUr1J7eZ_4pNu4t3yWUOEpQv4q9U
Message-ID: <CAKYAXd9kL9EGKk5xGuOuG1AhBarYZ8o1UZ3Fx7iLheK0uVB-Xg@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Jeongjun Park <aha310510@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Ethan Ferguson <ethan.ferguson@zetier.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 3:04=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Hi Namjae,
>
> Namjae Jeon <linkinjeon@kernel.org> wrote:
> >
> > On Tue, Oct 14, 2025 at 1:46=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > On Monday 13 October 2025 22:47:08 Jeongjun Park wrote:
> > > > Since the len argument value passed to exfat_ioctl_set_volume_label=
()
> > > > from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds r=
ead
> > > > occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.
> > > >
> > > > And because of the NLS_NAME_OVERLEN macro, another error occurs whe=
n
> > > > creating a file with a period at the end using utf8 and other iocha=
rsets,
> > > > so the NLS_NAME_OVERLEN macro should be removed and the len argumen=
t value
> > > > should be passed as FSLABEL_MAX - 1.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b371=
4d4
> > > > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> > >
> > > Fixes: line is for sure wrong as the affected
> > > exfat_ioctl_set_volume_label function is not available in the mention=
ed
> > > commit.
> > >
> > > I guess it should be commit d01579d590f72d2d91405b708e96f6169f24775a.
> > >
> > > Now I have looked at that commit and I think I finally understood wha=
t
> > > was the issue. exfat_nls_to_utf16() function is written in a way that
> > > it expects null-term string and its strlen as 3rd argument.
> > >
> > > This was achieved for all code paths except the new one introduced in
> > > that commit. "label" is declared as char label[FSLABEL_MAX]; so the
> > > FSLABEL_MAX argument in exfat_nls_to_utf16() is effectively
> > > sizeof(label). And here comes the problem, it should have been
> > > strlen(label) (or rather strnlen(label, sizeof(label)-1) in case
> > > userspace pass non-nul term string).
> > >
> > > So the change below to FSLABEL_MAX - 1 effectively fix the overflow
> > > problem. But not the usage of exfat_nls_to_utf16.
> > >
> > > API of FS_IOC_SETFSLABEL is defined to always take nul-term string:
> > > https://man7.org/linux/man-pages/man2/fs_ioc_setfslabel.2const.html
> > >
> > > And size of buffer is not the length of nul-term string. We should
> > > discard anything after nul-term byte.
> > >
> > > So in my opinion exfat_ioctl_set_volume_label() should be fixed in a =
way
> > > it would call exfat_nls_to_utf16() with 3rd argument passed as:
> > >
> > >   strnlen(label, sizeof(label) - 1)
> > >
> > > or
> > >
> > >   strnlen(label, FSLABEL_MAX - 1)
> > >
> > > Or personally I prefer to store this length into new variable (e.g.
> > > label_len) and then passing it to exfat_nls_to_utf16() function.
> > > For example:
> > >
> > >   ret =3D exfat_nls_to_utf16(sb, label, label_len, &uniname, &lossy);
> > Right, I agree.
> > >
> > > Adding Ethan to CC as author of the mentioned commit.
> > >
> > >
> > > And about NLS_NAME_OVERLEN, it is being used by the
> > > __exfat_resolve_path() function. So removal of the "setting" of
> > > NLS_NAME_OVERLEN bit but still checking if the NLS_NAME_OVERLEN bit i=
s
> > > set is quite wrong.
> > Right, The use of NLS_NAME_OVERLEN in __exfat_resolve_path() and
> > in the header should also be removed.
>
> I'll write a patch that reflects this analysis and send it to you right
> away.
>
> However, if do this, NLS_NAME_OVERLEN macro is no longer used anywhere
> in exfat, so does that mean should also remove the macro define itself?
Yes, So I replied that it should be removed in the header.
Thanks.
>
> Regards,
> Jeongjun Park


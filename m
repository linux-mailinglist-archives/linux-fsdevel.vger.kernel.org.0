Return-Path: <linux-fsdevel+bounces-63201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C4BB20C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 01:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6D63C781F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584127144E;
	Wed,  1 Oct 2025 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFSmg++M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620522B594
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759360128; cv=none; b=iyWn3vZY9H+1geWKG8eAHyhXw7WAjbrDBscI1Ho6HbHIb63SAwMolr3+1DdWjrsKXy3OjWawrY60NsNPkIWUHmW2e30i7VpJMC+eGoBjB3h+mSkUNA1+Lo1gabd4i16HUEuuK/RdRddUCo1V3WaIkPrMz6AWk2FA7i62lPNVG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759360128; c=relaxed/simple;
	bh=uC7+SkQxHX79e7P59XRO3n8LOn1nPaYTpHe/mdkbnLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXHk3RbFqRP2PkLmMMu1NtA/wjO/K3ENtqz0DTTIce538nAinO91lrIxqUzc0bZLnaqFhIkcvDzHxsFQ+grEd6Rmy8BhbwCwS4XwGcy42tt/nqnQ8iXR83vz23tw10wtIMb/KeYhvwVuYHBo02RPlj1g2VVcK02/JpWqrekQGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFSmg++M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EA3C4CEFB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 23:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759360128;
	bh=uC7+SkQxHX79e7P59XRO3n8LOn1nPaYTpHe/mdkbnLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mFSmg++MvgmrfL3akCilA8OmLMtG9NDdweW8sYr4UmerF9AnmZEOqCQh0PuNHTB7k
	 Il/Psr8L0HSR85LZ59KvOPpJhMHyA+dP2qmDRGTjfYNZDi1AlG490riH+Jaixfq+sX
	 aWAXLTWXlwSstV8A/uhZXfZghCisXGi+go5oMap6yMe34join6LVcluQrRepQS3R8+
	 /zvgL7vGxLk/HeXmCaGSTLE1Gf+8FT9sJSr+apMlLu63j9pzeR8B8kLNdSSZLM0GvZ
	 ZCxcIJ/THfGI3tbbuP8DvYNYuvPJBLBoTKDID35paxRdnRKN1PeCmxP4PTCzj/+6a7
	 4PT+TsMsN0Zcw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6364eb29e74so933059a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 16:08:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNTGOZyuV1gkIZJaAwcwhpEG0TVahM/hjbnynepLKdxoptAb/+1b1EhHNO24icaHdIv6Pyu5EF6BZLBzVv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrsc1QeeHE0jTrY0Q5XWjr/vUjKm1yfhajl6V33s7H1ea//Uvn
	6N9PMfL4gdceLjYStzTQ4YuPSl7CDunKvK9pmjfrfhcBMgjaEvBlMLNHdOk239wtYdM+bKC6rZM
	I778rnavVFkWkC98g3GzFc6RDRVGS6q8=
X-Google-Smtp-Source: AGHT+IH1oHfBuJPuNT3uNmxhwKyMZbsyj6k7cL5F90DffNcKq/rLEh/FLGhMTH8FbDRTUI2oK4jclo7MtZrAij72FWg=
X-Received: by 2002:a05:6402:2713:b0:634:a546:de4c with SMTP id
 4fb4d7f45d1cf-63678ce6b05mr5532974a12.17.1759360127038; Wed, 01 Oct 2025
 16:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032619.9846-1-ethan.ferguson@zetier.com>
 <20250912032619.9846-2-ethan.ferguson@zetier.com> <PUZPR04MB6316E73EE47154A64F8733DA8118A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <408ad037-639a-4051-831b-b663c0d2d772@zetier.com>
In-Reply-To: <408ad037-639a-4051-831b-b663c0d2d772@zetier.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 2 Oct 2025 08:08:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9pMJik+1BRywYm-5-9bx9uHni6mucP6DvQufKuWM17pQ@mail.gmail.com>
X-Gm-Features: AS18NWBxPxJwDAbI-6fUmVgf4caID4PmsdMuRVdoG3BhWC6adWslpEctcYCPyNo
Message-ID: <CAKYAXd9pMJik+1BRywYm-5-9bx9uHni6mucP6DvQufKuWM17pQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpgs@samsung.com" <cpgs@samsung.com>, 
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:34=E2=80=AFAM Ethan Ferguson <ethan.ferguson@zetie=
r.com> wrote:
>
> Hi,
>
> On 9/28/25 06:28, Yuezhang.Mo@sony.com wrote:
> > On Fri, Sep 12, 2025 11:26 Ethan Ferguson <ethan.ferguson@zetier.com> w=
rote:
> >> +int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_=
name *label_out)
> >> +{
> >> +       int ret, i;
> >> +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> >> +       struct exfat_entry_set_cache es;
> >> +       struct exfat_dentry *ep;
> >> +
> >> +       mutex_lock(&sbi->s_lock);
> >> +
> >> +       memset(label_out, 0, sizeof(*label_out));
> >> +       ret =3D exfat_get_volume_label_dentry(sb, &es);
> >> +       if (ret < 0) {
> >> +               /*
> >> +                * ENOENT signifies that a volume label dentry doesn't=
 exist
> >> +                * We will treat this as an empty volume label and not=
 fail.
> >> +                */
> >> +               if (ret =3D=3D -ENOENT)
> >> +                       ret =3D 0;
> >> +
> >> +               goto unlock;
> >> +       }
> >> +
> >> +       ep =3D exfat_get_dentry_cached(&es, 0);
> >> +       label_out->name_len =3D ep->dentry.volume_label.char_count;
> >> +       if (label_out->name_len > EXFAT_VOLUME_LABEL_LEN) {
> >> +               ret =3D -EIO;
> >> +               goto unlock;
> >> +       }
> >> +
> >> +       for (i =3D 0; i < label_out->name_len; i++)
> >> +               label_out->name[i] =3D le16_to_cpu(ep->dentry.volume_l=
abel.volume_label[i]);
> >> +
> >> +unlock:
> >> +       mutex_unlock(&sbi->s_lock);
> >> +       return ret;
> >> +}
> >
> > Hi Ethan Ferguson,
> >
> > This function has a buffer leak due to a missed call to
> > exfat_put_dentry_set(). Please fix it.
> >
> > Thanks
> Apologies that I missed that, I would be more than happy to submit a fixe=
d patch for this,
> but I checked the dev branch of the exfat tree and noticed some lines wer=
e added to fix this
> problem in my commit. If true, this is fine by me, and I will sign off on=
 it, but I just
> want to make sure that's true, because if so then I don't think another p=
atch by me is needed.
I have directly updated it. So you don't need to submit the updated
patch to the list.
Thanks.
>
> Thank you!


Return-Path: <linux-fsdevel+bounces-64087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A7EBD7831
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 08:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66A894F2D42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7542030C606;
	Tue, 14 Oct 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWdPOu/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D730BBB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421876; cv=none; b=MbI8GdYTbeTR5ChC29RbCddLZKKp8/nV44rwq7K/cwjpG0TGV9YqMKXFcuYYzAOIhm2en7ZlCtMO5mOowWmIToz0oJuI9443yRh3ifG1P4xIbpcnKv7vOnmG2mB+x+g0CoIqNjN7fvOlhp2Yi12IaNpbm4lviqSOGDSKe68XAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421876; c=relaxed/simple;
	bh=tv0xd/ZLUTxahGhqv/v6XY8qJ/8QWSM/jWNbbSekNAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVlVNdZysYZ4gKXN1oMSxaE+DqjRPNtY3Ym4gpS0ybgw07H9aCAsY5BneLJnM0AUW0vA3ggAOA2exGaZr/tzF/LuZ2SNLZxcHrD+IHiLcaLT0AvKwuWFDCAdAgOY1rFDen8LCeCIJtpFWb3/vcAdbz9q3sLyGtpE+3GcQRnKFCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWdPOu/Z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso4455682a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760421874; x=1761026674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzZuo7NJ/DlD6SoTWD70pPuh+8rHqp2AyadzZH5QNao=;
        b=lWdPOu/ZNgdIRmt3s1GU8nzMUufS5orl0aFEZDpsNrFFxMZ1aktwrktG9Mm0gNqVJS
         ZsH5P2gOaZTSUASdOcgNppZQ16uvad+PgYoEl1W38BSVi+DjmW0D2VKZV3jxx+RC7hdp
         UNhz84Wp9th9+so84DBjujtRhssnAQ5E06h4LWVuVnwjttbNr8lEIhO61yMHf6zUy/q9
         DRneuFReD5qgvX1aCrrSMoWfoJ7+hXff3DPUp0LnDMSgBo0xOpKvD00Tzb0PujvsAspj
         c7+UvUSE4OB8EWvHjcfs7w/qvUdawh8cDViXP/oJypuwmcIujhlDhFQcWjcSjUl55+lG
         Np1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421874; x=1761026674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzZuo7NJ/DlD6SoTWD70pPuh+8rHqp2AyadzZH5QNao=;
        b=i4I/Fkn3uFnZ+MJHk3En2qbHQ7U98NhwOho3+07gx7NjvEGKbb1sJGRDmTiBO5Et8a
         6tUeDCHXTnLBSwLHJHwMc2cdQdwbsCpRXIctHqY1XS4pPUEbRUofBoRvOISs5xCb0HeI
         jBGK4KkMkaZReYT6BvlrOFKcoDXwdEUUzKphpKn/yC3E5rexIvWP+jrAEKW/Q924FPcS
         okaKAjGMrAUlzXSXoTgUD2VNt0Z8JXmDWPbgAk3DzIawylAvzfc0kjWjg9iu2c9Tw9Kd
         K0oc7Sq1Wq4ScCOW2/DkvWor+UVVNzpXaPXWm04eVIW7A57DqHnDnB0bNR1knn9LeW/k
         AkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw+nzjrPWMpSrbjd7FIQGeielZ+nFNvN2aK2ySOJzId2LUc3oQ1eFo9n8thV6TZoVaIIcjSstsA1i1jfB6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+bRyO/cQJ0Xu62cnMDa5Zqpn4wU6wgXS6Us6lbqormsP3R1N
	gFzeGrIjTIbJVr+vU6voexonD8TeEtKDK3UBcwMdwAenrrjCH4sh49WMWYtup1qUfK8w8JOBgJ4
	QNPRZcXuscSZBk3QvYqXcaDF6UskWjoA=
X-Gm-Gg: ASbGncu10z+uYyJpkL3i6FO6+s/Nrjk0RUbRKNLYTakScru60e4lvYy7tSTkvgqUAzq
	RAekQ7teuo9vFJ0Jw2ewAy/qGDHlIjneMFolzA7t5bYSIMmiU2C+9wwX9RjnP7QhXXEbSnu7A+k
	WXw+EqXgOOOTnQC3l03XlD05Qn4ODb1KAdidG266vTSFUAQ6b/HfV7Vs7gLpF1G77d0hQ7/XywO
	ZMiBRmcEP5q+VXsTftPedCDoa7+SOlcDfj0
X-Google-Smtp-Source: AGHT+IHgo+WYjqQU4SsdvUGTS8UzFNwqRmcAAWsiHyknSHfsOn4aG616ucEJLt9ZJx34ZiYRNEWMbDb0/kmXi44bPmU=
X-Received: by 2002:a17:90b:1d06:b0:32e:2c90:99a with SMTP id
 98e67ed59e1d1-33b513b4b51mr35056966a91.35.1760421874366; Mon, 13 Oct 2025
 23:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013134708.1270704-1-aha310510@gmail.com> <20251013164625.nphymwx25fde5eyk@pali>
 <CAKYAXd8bhyHrf=fMRrv2oWeWf8gshGdHd2zb=C40vD632Lgm_g@mail.gmail.com>
In-Reply-To: <CAKYAXd8bhyHrf=fMRrv2oWeWf8gshGdHd2zb=C40vD632Lgm_g@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Tue, 14 Oct 2025 15:04:23 +0900
X-Gm-Features: AS18NWCJ1qNnENzazf89-ZHRk0M4-ND7Pc4CWd_uJJpk98z55XLeWA5G4CpXXIk
Message-ID: <CAO9qdTHLEEDPWpZeWBq5Awn_wrcpfcYFK4Hhr=AohOhWpQDRcA@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Ethan Ferguson <ethan.ferguson@zetier.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> On Tue, Oct 14, 2025 at 1:46=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org>=
 wrote:
> >
> > On Monday 13 October 2025 22:47:08 Jeongjun Park wrote:
> > > Since the len argument value passed to exfat_ioctl_set_volume_label()
> > > from exfat_nls_to_utf16() is passed 1 too large, an out-of-bounds rea=
d
> > > occurs when dereferencing p_cstring in exfat_nls_to_ucs2() later.
> > >
> > > And because of the NLS_NAME_OVERLEN macro, another error occurs when
> > > creating a file with a period at the end using utf8 and other iochars=
ets,
> > > so the NLS_NAME_OVERLEN macro should be removed and the len argument =
value
> > > should be passed as FSLABEL_MAX - 1.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d=
4
> > > Fixes: 370e812b3ec1 ("exfat: add nls operations")
> >
> > Fixes: line is for sure wrong as the affected
> > exfat_ioctl_set_volume_label function is not available in the mentioned
> > commit.
> >
> > I guess it should be commit d01579d590f72d2d91405b708e96f6169f24775a.
> >
> > Now I have looked at that commit and I think I finally understood what
> > was the issue. exfat_nls_to_utf16() function is written in a way that
> > it expects null-term string and its strlen as 3rd argument.
> >
> > This was achieved for all code paths except the new one introduced in
> > that commit. "label" is declared as char label[FSLABEL_MAX]; so the
> > FSLABEL_MAX argument in exfat_nls_to_utf16() is effectively
> > sizeof(label). And here comes the problem, it should have been
> > strlen(label) (or rather strnlen(label, sizeof(label)-1) in case
> > userspace pass non-nul term string).
> >
> > So the change below to FSLABEL_MAX - 1 effectively fix the overflow
> > problem. But not the usage of exfat_nls_to_utf16.
> >
> > API of FS_IOC_SETFSLABEL is defined to always take nul-term string:
> > https://man7.org/linux/man-pages/man2/fs_ioc_setfslabel.2const.html
> >
> > And size of buffer is not the length of nul-term string. We should
> > discard anything after nul-term byte.
> >
> > So in my opinion exfat_ioctl_set_volume_label() should be fixed in a wa=
y
> > it would call exfat_nls_to_utf16() with 3rd argument passed as:
> >
> >   strnlen(label, sizeof(label) - 1)
> >
> > or
> >
> >   strnlen(label, FSLABEL_MAX - 1)
> >
> > Or personally I prefer to store this length into new variable (e.g.
> > label_len) and then passing it to exfat_nls_to_utf16() function.
> > For example:
> >
> >   ret =3D exfat_nls_to_utf16(sb, label, label_len, &uniname, &lossy);
> Right, I agree.
> >
> > Adding Ethan to CC as author of the mentioned commit.
> >
> >
> > And about NLS_NAME_OVERLEN, it is being used by the
> > __exfat_resolve_path() function. So removal of the "setting" of
> > NLS_NAME_OVERLEN bit but still checking if the NLS_NAME_OVERLEN bit is
> > set is quite wrong.
> Right, The use of NLS_NAME_OVERLEN in __exfat_resolve_path() and
> in the header should also be removed.

I'll write a patch that reflects this analysis and send it to you right
away.

However, if do this, NLS_NAME_OVERLEN macro is no longer used anywhere
in exfat, so does that mean should also remove the macro define itself?

Regards,
Jeongjun Park


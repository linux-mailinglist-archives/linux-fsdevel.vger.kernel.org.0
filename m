Return-Path: <linux-fsdevel+bounces-69726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC730C832B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 04:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C59C34E3B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 03:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8361DE894;
	Tue, 25 Nov 2025 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1ryOBvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46A78F51
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039664; cv=none; b=dHBmk5FLMpcz6LjLfZALeQqnnnWnS0ayFCznAOsAXcXGWG4y360CwyjT3jsKmlp0HWbIv9Shdc8BJK0AP8cfeq4KdaydRIM6ttQI9tRUMxB1zSDlGIlEWq/9aks5NP9FAZcxpCk/MJVEoSoFDK92RBHEaK4XVcqxy4KJV0Lnrs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039664; c=relaxed/simple;
	bh=rS/uz7VfZmue9terOD3ZJ9IsGKd9ZA6yPwfJXi0bn0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxkbKErpQyoG32VO+jXpekHcXdzDpjzdrted75ld3pacxrYS8Ka9Tm4O/WVHhNGPe+rWIEncgo8FzicecUojrdMWVjjsoMWDkvWEcB9/qPVC6oRHMPqfd2HQAibPgAr5aubhWe7c5Y5Y4uEJ/XieYj5WHRHhI9bSGIR7TDl20Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1ryOBvz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so8104547a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 19:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764039660; x=1764644460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MFzGPrxwnkDYme57fwtkYkMi/fCPxBfM81Ih85pJRQ=;
        b=C1ryOBvzC9uTd899FppTyrlsR0cxHaxw0kEMn2S9mpHb3k9BsnNwS1eSVWfYus83x/
         82qzhY7t/mk2Nzr4hxWp5jf1PfKUZtqFx+UIkgI55Loc0OZCXlV0kCXBSxrkQoqPw5Jf
         babuDjRoXLBtrlexFAJUI+N3fTK+m42Y9Rri6OVD6ySgUwE7jF9sKacNBEgoSjA4gQul
         6gQ0mzd+EY6T98Z+iLC2WaYdcqnsbGQwaGDufu/KZ7VZa+lNG2mT7RFGEmLdad7kijLh
         DOccMDXYYesPPrrlsN4k5kqBUG1SgJJLRD6nvovOktHEZccqaAnvADpWF2L0xZ4UUTwc
         /klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764039660; x=1764644460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MFzGPrxwnkDYme57fwtkYkMi/fCPxBfM81Ih85pJRQ=;
        b=qzCkBcR7cipyKQmcHFyIIzTi0dAgy7Ay2D3ecF9S35sUqOGU9RuoHVRPngdxJSZEI8
         AstSE2vCN5tvShAtaVnIuZQjlWG4nwH/NbCcABL7T0WLrCRox6y7y9VGF/TDl/N+d/Sw
         Ja6uherAE9wNtw/NtpJXAMlWaHJ6GSglOLZ/I+cWII92kx+g8ZmdZvDS8WuK7tTttfmc
         LJawLZNbP87GvhAzfNNcg2k64TUKdrkh1HDn/L36wLicsHJ5J2+S5sGQzPmh6hWAUz9R
         ObC5OUP8KiQfNR0PT+wNGaDf8kZLlNTY03HgJigxYI3tqZ370DU2XhhK0iggdt+DeaYL
         CknQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzUUz91ko21XzA16Sbpt/LasoT5o4Qe2sFQ7jtnLSx3H3I/vGgQ9RwusZPIZwIS1mhyzdUSsM+bQ26++Wx@vger.kernel.org
X-Gm-Message-State: AOJu0YxghAymd+VeW1KBvGKunxAMCCesF2CIEL7+fAmC3ibO3mxjsvOa
	mllAgqzzHvxIDeL7KYb6srH9pwUUL1bn4fLkyEFsQWyzEnxJNLNCzpmnv+BHq5i3rjslFboojK8
	sM5nODDgWojhTRBi/juYFb8K7oU76Y3g=
X-Gm-Gg: ASbGncvl7LHgzx7BdVYfbe0juhilp2SfaSyd8mGGbCJ0fXHSxbxkNsw7UNqEx+lpD59
	vAwnOMlrgpo1lnSkGnc/HbUbbmj+hCzyyT4fdLgFLryQ0QZPZ1l8ngk5RuebPFvc3tQIdCVNwwR
	O/OxbBnnKruLl1/G3q7zpATFqOC2dBkQuZyxwrP8/uDDSLeGGiN5KaT1od3hBFVQVYne03CgQXv
	Batw/bIjDuvqJ2whagLK1RpEqju0FndexTOImzeZpJktf5I5K4cf4KnPRuvQPMNcOkGy5cFuMh6
	wZrrKsmyyvSllpUc5o5KCphKQQ==
X-Google-Smtp-Source: AGHT+IFesKuiXfMz446AcBDVRQditePmsXXaGd1G+9aJqSIymnGh1fakkSqtAJ7Z6dXAckA3SVdpeM7eKYs2KK8Yl18=
X-Received: by 2002:a05:6402:146a:b0:640:b247:fede with SMTP id
 4fb4d7f45d1cf-645eb7856f2mr1026498a12.29.1764039660004; Mon, 24 Nov 2025
 19:01:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010221737.1403539-1-mjguzik@gmail.com> <20251124174742.2939610-1-agruenba@redhat.com>
 <CAGudoHF4PNbJpc5uUDA02d=TD8gL2J4epn-+hhKhreou1dVX5g@mail.gmail.com> <CAHc6FU5aWPsv0ZfJAjLyziGjyem9SvWY2e+ZuKDhybOWS-roYQ@mail.gmail.com>
In-Reply-To: <CAHc6FU5aWPsv0ZfJAjLyziGjyem9SvWY2e+ZuKDhybOWS-roYQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Nov 2025 04:00:47 +0100
X-Gm-Features: AWmQ_bmNNHWCBTr97VTF29nG26w-MvfxVWs16zEle6sDG68DzB8L4yhEKzB9HqI
Message-ID: <CAGudoHFSFy9KDAViEU8whypxsUN5+wXAi-Po6Tc1jw-yLE5PUg@mail.gmail.com>
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 12:04=E2=80=AFAM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> On Mon, Nov 24, 2025 at 8:25=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > On Mon, Nov 24, 2025 at 6:47=E2=80=AFPM Andreas Gruenbacher <agruenba@r=
edhat.com> wrote:
> > >
> > > On Sat, Oct 11, 2025 at 12:17=E2=80=AFAM Mateusz Guzik <mjguzik@gmail=
.com> wrote:
> > Was that always a thing? My grep for '!!' shows plenty of hits in the
> > kernel tree and I'm pretty sure this was an established pratice.
>
> It depends on the data type. The non-not "operator" converts non-0
> values into 1. For boolean values, that conversion is implicit. For
> example,
>
>   !!0x100 =3D=3D 1
>   (bool)0x100 =3D=3D 1
>
> but
>
>   (char)0x100 =3D=3D 0
>

I mean it was an established practice *specifically* for bools.

Case in point from quick grep on the kernel:
/* Internal helper functions to match cpu capability type */
static bool
cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
{
        return !!(cap->type & ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU);
}

static bool
cpucap_late_cpu_permitted(const struct arm64_cpu_capabilities *cap)
{
        return !!(cap->type & ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU);
}

static bool
cpucap_panic_on_conflict(const struct arm64_cpu_capabilities *cap)
{
        return !!(cap->type & ARM64_CPUCAP_PANIC_ON_CONFLICT);
}

I suspect the practice predates bool support in the C standard and
people afterwards never found out.


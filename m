Return-Path: <linux-fsdevel+bounces-67008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3394C33214
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADD6461D88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD812C11E9;
	Tue,  4 Nov 2025 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eVbDFcS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869D34D3AE
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293989; cv=none; b=gr+avnh25Z3BQ1GQGv9mFh1+1h17JsYbnfg47Z+O1yQV3jXL90rdEy6+wyRcqY2j6LOIQXw+pdltqLnBdxoG0uXkdU0YiQ8wPNcAMR195Uq8QpiTIa+Js4GH2kWmpPgn0FRV6hTIVsWYYfnAOgn2Fl7f1776SgjCraOUfRtCOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293989; c=relaxed/simple;
	bh=MB7A1vTXVybnoioucy3wrWv8+Jn81ohbURENXs0pUhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sj4wHB/vkymkUc9M33+uloacUCOqSrTz7PsYc215EdRdtx1cvabXdNcugOuy8fI9ptVwQDGi5KTEBSiB6xn92gwRVlrdLKXVz8sB2fhcONxBCK7id91s+DMjgp8SAYfsIlB0bVd0KrZ8FHeoNAyImZnn5fo9i5HrsEx0ReJdjsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eVbDFcS7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b472842981fso767337966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762293985; x=1762898785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OSolmfNCqKzaq21h0SNVzfu+X5TQh0oCJL/32vsBw0A=;
        b=eVbDFcS7HJgFR0ABW1ygLKA4iWVTP0sPyrhRD4upc6h+3+OZFL2VR3lB4K4VvTrDQk
         7FFrLLo9DtFZHh0fbsbfJmDoGNxjpscuCsjWQ3RKUVcVVx1xz3v6dAJbPCU4/1s2DFXH
         y1dQrXM7vsv/h/72IAqzPG4751cB466/jhol8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293985; x=1762898785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSolmfNCqKzaq21h0SNVzfu+X5TQh0oCJL/32vsBw0A=;
        b=KStVhgo2w4gRXbxdYhatetPvei8U75l9BOh6WfiTD4sgoaVZM1tmSL3Pmkcb/Y75J5
         p5CiXmUlG/5LBV5binxndtAGYB7gB5dbtSeri4SCkTdqGSER3I4V/FO9yz+/5LHh04wF
         +nPpgdH9eaO+sqdN86fhXS4o4+4Bb30qMpDfSUbhfL75d1oGHuTkcbbej9GN14dPqtcb
         iI/4+HH1oHUNZqLJw56I5Th2t50Xw64B5VZZ7S7JQNR/kTEpAtxrwnHeGnnVpRoJ9Xoe
         AVovKAtNOqH/5qy3kBIMYrHEpQXcv1I0kcq4YkYwlYCKhCo5JQWxRQ5ffZsQrw1dLN8V
         VeJw==
X-Forwarded-Encrypted: i=1; AJvYcCXfQ7i3nAL5QXi/svUAGImzamyrfnHmgoyVAjVfIdQADY3OuoXIp5xlExjY1u+ATBX4nxZoVllkpd0NRWrU@vger.kernel.org
X-Gm-Message-State: AOJu0YwFegUx2ubuzCFEGsZWi7eaSWnpnwLPJ8APvJG3UdeolsQz4qLl
	HtZ3Eqc6gIINuLKR+Q7MFpxYeVgPocdY750SUREyY86cFU/MRcbmvjeJ/nEXFhSJh+cLd5WS67d
	yicIWpTEhMw==
X-Gm-Gg: ASbGnctTgqzwTqt9l0RpIPGIYBfocYcSBFbXnj6dFGDJMhFBETD0N2VWOPT/7Xr3n9Q
	1rkkuZV0iaG/u6yruDykmd/kowSUdPV0TDvXaLF0FV3YhVeK1ixZf912kHeKRl7Tyxn8XARL06D
	Gel6i7b4sMClKAu7FZvg/lwq8bCSlcQppu+t8ydA9WNqJgtsVgscDb0UKeFFu0A8bnoyyQ4eAfH
	WktzW2Zx4Z2SCrIwr0fxNbc6nxU4kBb6OttMr3CkNm7TgL/bz0nfehjbaJFaOLoANQ57K+vvZGh
	EG3wU3ruLy0h5LVzR5Ar9fGu0l4Ey4tNEhDlObjgTwj3YcHvKAXYsaL3YU0nYabhFOxRkv3dcjs
	fzoe694JkGi2N3Y+QttptsPp0MwVVMbl/ijcfQh8hfNwM1qJ4ojDWIVz/AF+XzUGmFPqPddgzvj
	wVxYFtSRMZ/lvt/wLLRhFa1JCbAcOZMIiff3ed+5fin1h7wc+o4w==
X-Google-Smtp-Source: AGHT+IHBvy0VKvEd1pgqCxwvf3jAyd1RhC4dL/7aeY6T4YTsG5/nhLe2a9L0EDscXscmrfvB9Tpd9A==
X-Received: by 2002:a17:907:97d4:b0:b70:edaf:4ee5 with SMTP id a640c23a62f3a-b7265297d83mr71375266b.16.1762293985040;
        Tue, 04 Nov 2025 14:06:25 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm326012866b.46.2025.11.04.14.06.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:06:23 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so5229520a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 14:06:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRbHGySgVDNOyy4svy95nc4USPHmUyWFxPejCWPAKUXfnaTibSz+LPliWZ8XEvo9bPJWKlc3wout8qXfn3@vger.kernel.org
X-Received: by 2002:a05:6402:1e92:b0:640:96b8:2c36 with SMTP id
 4fb4d7f45d1cf-641058b31fdmr653807a12.11.1762293983503; Tue, 04 Nov 2025
 14:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <aQozS2ZHX4x1APvb@google.com> <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
 <20251104201752.GEaQpfcJtiI_IxeLVq@fat_crate.local>
In-Reply-To: <20251104201752.GEaQpfcJtiI_IxeLVq@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 07:06:05 +0900
X-Gmail-Original-Message-ID: <CAHk-=wgoajqRhtYi=uS0UpmH61qE=tBCwb8x3GG6ywZUqWY6zg@mail.gmail.com>
X-Gm-Features: AWmQ_bnsCqWH_iYKP_EdZA2WzLcUhVAfQWPyoyRVWTol-RWkziiQu5qj5FOPxAo
Message-ID: <CAHk-=wgoajqRhtYi=uS0UpmH61qE=tBCwb8x3GG6ywZUqWY6zg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 05:18, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 05, 2025 at 04:07:44AM +0900, Linus Torvalds wrote:
> > In fact, Josh Poimboeuf tried to do that __get_user() fix fairly
> > recently, but he hit at least the "coco" code mis-using this thing.
> >
> > See vc_read_mem() in arch/x86/coco/sev/vc-handle.c.
>
> So Tom and I did pre-fault this whole deal just now: so we need an atomic way
> to figure out whether we'll fault on the address and then handle that result
> properly. Which we do. So we only need to know whether it'll fault or not,
> without sleeping.
>
> So the question is, what would be an alternative to do that? Should we do
> something homegrown?

So I think that since it's x86-specific code, maybe something
homegrown is the way to go. I mean, that cdoe already effectively is.

With a *BIG* comment about what is going on, something like

        pagefault_disable();
        stac();
        unsafe_get_user(val, ptr, fault_label);
        clac();
        pagefault_enable();
        return 0;

  fault_label:
        clac();
        return 1;

but any other users of __get_user() that aren't in x86-specific code
can't do that, so I do think it's probably better to just migrate the
*good* cases - the ones known to actually be about user space - away
from __get_user() and just leave these turds alone.

              Linus


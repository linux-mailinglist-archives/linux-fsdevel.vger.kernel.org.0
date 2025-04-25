Return-Path: <linux-fsdevel+bounces-47414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD9A9D315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07F43B113A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10E8221FA6;
	Fri, 25 Apr 2025 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AcqdYf7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2821FF28
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613360; cv=none; b=FmUCeC1mK4fDvRnQpjPj4iB4VS796n+a9ewEGiUIlVB/ucRzSQCPAr6OO2SeCzDx2jruBODmVNHLrWUDqYYm3hPuNnXHacaT9BCa8L6It3WQYAJGRYxDXY5grXV3ET4EE8SydIGCJrrMzgIvRlUukpJht6BM9hzFrVXl8jREXfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613360; c=relaxed/simple;
	bh=SQExu4w4hPgGkdy5kCAct+RvK8+FjV4snNR+nLyJBNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyDRYm3Oh3bL34Prgnv5LaWzvP+bdVc9/Ev/ChzwKAzAy1Ztk8idgMPukV1DHkH4IizQuW0Dcq0UdyF24/vIZuizT5IgY7ZGhlAnL9tUDro3sdqrCiEemHcFeVuS8Lc2i4zLftIhctQSE/ktCGFot+iajCk+0LpKV1nu/h9lxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AcqdYf7s; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ace333d5f7bso439420566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745613355; x=1746218155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qHF1zPVwXD8IdJu/yf1YIr/T0XDnrM1CQwq7Bj5CPDw=;
        b=AcqdYf7sEb5O+p7PVg+SZBBLgQsUwDcGRQTQc2JJgrlVDWdBnJNhSSZvwB9Y/uq95v
         SFZOHoWJVu8NVIHqXNYAkdH/DMLXOVm+keHTgYF5b4Ka8r3hg0WEDUVNB49RjBh7Z12x
         Jj5oHdUODbq4ly6ayEpYN6M10Qjlnt3VJEsL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745613355; x=1746218155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHF1zPVwXD8IdJu/yf1YIr/T0XDnrM1CQwq7Bj5CPDw=;
        b=jrl/3GmEUPXWmwhmVvhqfQxjRwmIJ+OExAYI7mjbS3IUb/WvHDMyl4eK/qPR6uW+z6
         EuFQC55sIhfvuWbPX2pdvXGmB0j6O8R3lV8talpPWsDxbLNYtxFoch1qK5N5c28yXUbS
         gwy9SK2JH9uWGcXCFERpwQ7YgRoTkBxobmbpqWMXMk2gvGWm8ywtesR0PGhGhdBtpMuu
         1ZrLb8iL8zhtGVDpRLKxBKXvEH7G++b6Vd9CVylB7sZyiYjjeepfAChv5UkLYhupT+Cp
         UiSEGq/GW5C/QySqQbKCPTno+xr7XnAlVQSegTfpokjwMdXUOvFxCsYqTYQbR8GOcfn4
         iwTA==
X-Forwarded-Encrypted: i=1; AJvYcCXyZgstPKvgabloVsu/xhWjYjJCFOm3LNMbepvhiiPYuMENHz4ix0hrZaEs3kPvHlHHc+poVQwSrHcL8Bq4@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfnf3pV8Ud38v9lUSmoDsaE54dJ5WhHnyOK1+tBc8WT80AD7W
	fMCCBuvRxM5xXRti1OzcDWSlp0uKAq4VwjWBB2DAtmjY38Ro60GpKBVaQXfTELCF4jMbyMBk9wu
	0/FU=
X-Gm-Gg: ASbGncv6tPGS8mWWcUS12J+LBSM18FXLBN5tIdK0heBqSQQDxswyc/COFzH8lgwM2/e
	+HintxCLIqpQ/eqTSRgwa/07SmOrWp/FFoGeNLc076rJoQVnKZiPX/b2y+5egLpIA9MNvMBDsic
	35LLI0VkbmlBT3BnGx9B8pDGNQxNSPfM7fgEoytO970fVRHcvfpDsjtvSnsqQhWgM5st34OmBNR
	MD2pWBBrS8Xq2e73nImHLAHuyBmxI/SLEyRMrOPn9NH3Pu+dsR8o4NceGXWoGce8fvLOfFjSKfj
	jqyNL4wzZI6y7zV2GqjvHSQIzxjRydsj2y3QCnqWCQcT4hFkqPWTI3zvORexAaVrXA82yn2D5sb
	KKSiIcEC3kqV1VZE=
X-Google-Smtp-Source: AGHT+IFDOcGjCWk2OA6B6lFduIkQLcoFN3mp6m230QBIyCTCRRx93l5uTezczady7Uhnv6Lb8ZTN4Q==
X-Received: by 2002:a17:907:72ca:b0:ac8:197f:3ff6 with SMTP id a640c23a62f3a-ace8493ad90mr62584266b.28.1745613354683;
        Fri, 25 Apr 2025 13:35:54 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecfa354sm183393766b.120.2025.04.25.13.35.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 13:35:54 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ace333d5f7bso439415466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 13:35:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuiQggsoBqW+YsUG1D3qfVkdATnT2Mgnw0x1Qj2PlekdeNFeXieodGLGJrO4YsKLN82LKVkZH+V2SHWcAU@vger.kernel.org
X-Received: by 2002:a17:907:7f24:b0:acb:107e:95af with SMTP id
 a640c23a62f3a-ace84ad7774mr62978366b.39.1745613353476; Fri, 25 Apr 2025
 13:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com> <aAvlM1G1k94kvCs9@casper.infradead.org>
In-Reply-To: <aAvlM1G1k94kvCs9@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Apr 2025 13:35:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiX-CVhm0S2Ba4+pLO2U=3dY0x56jcunMyOz2TEHAgnYg@mail.gmail.com>
X-Gm-Features: ATxdqUGwKlTpu4bheZKrvcER-qlO-D6uY_4AgFPDdEUKnYAjfRZ_s0Tk9V5ZhUc
Message-ID: <CAHk-=wiX-CVhm0S2Ba4+pLO2U=3dY0x56jcunMyOz2TEHAgnYg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 12:40, Matthew Wilcox <willy@infradead.org> wrote:
>
> I think this is something that NTFS actually got right.  Each filesystem
> carries with it a 128KiB table that maps each codepoint to its
> case-insensitive equivalent.

I agree that that is indeed a technically correct way to deal with
case sensitivity at least from a filesystem standpoint.

It does have some usability issues - exactly because of that "fixed at
filesystem creation time" - but since in *practice* nobody actually
cares about the odd cases, that isn't really much of a real issue.

And the fixed translation table means that it at least gets versioning
right, and you hopefully filled the table up sanely and don't end up
with the crazy cases (ie the nonprinting characters etc) so hopefully
it contains only the completely unambiguous stuff.

That said, I really suspect that in practice, folding even just the
7-bit ASCII subset would have been ok and would have obviated even
that table. And I say that as somebody who grew up in an environment
that used a bigger character set than that.

Of course, the NTFS stuff came about because FAT had code pages for
just the 8-bit cases - and people used them, and that then caused odd
issues when moving data around.

Again - 8-bit tables were entirely sufficient in practice but actually
caused more problems than not doing it at all would have. And then
people go "we switched to 16-bit wide characters, so we need to expand
on the code table too".

Which is obviously exactly how you end up with that 128kB table.

But you have to ask yourself: do you think that the people who made
the incredibly bad choice to use a fixed 16-bit wide character set -
which caused literally decades of trouble in Windows, and still shows
up today - then made the perfect choice when dealing with case
folding? Yeah, no.

Still, I very much agree it was a better choice than "let's call
random unicode routines we don't really appreciate the complexity of".

            Linus


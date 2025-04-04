Return-Path: <linux-fsdevel+bounces-45712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE31A7B6CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5F7A78E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 04:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8214EB38;
	Fri,  4 Apr 2025 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dvHUUjcD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936241C68F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743740044; cv=none; b=dSJHqa0klpCi0GXXjbjnV4hwxhLU6UtFWrNgrW3mYjQSziBaz06So4E6Vs5Dy1HWTgWRRkoT9sBJNMyVNJXDpcSSesxiMnf8uCOfxKN9Y6+Kw+mDdI/iresCV/dFjNXcdS/X6SxMGywBDtg5hAknL+okPIo7lZNCHa3jkhiRqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743740044; c=relaxed/simple;
	bh=PujQ6hMBwn5idAKPvzLMQLo88mZho2ZGGxP7eNt884Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMRbeY+xkxKRMX8xzbSCMO7E4Xls7vXXl76hugnGvNhDjlxKBgn7ZASyiAGq9yewUoQ8FRvcHgKlJhbNPEK9f0tPZna7Tp3MSsAc81ceTDOLeBCYh0vb5Eaa6moozU43fl412gjAnH6FiRdUxyYHJH/FqMUPbqggrTv5/PvY70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dvHUUjcD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3b12e8518so300487066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743740041; x=1744344841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BYtYdDVynheItBtfiKKOxM1KmD+C5mWgUcIfjnewaLE=;
        b=dvHUUjcDoOjhkfcTfvM74Oq0a6IP7+t5PQtsnGPUOrneHhiJdjIlpHVmCqhfPZ3sRq
         86zCPacmt+tpqTBlbpJsKwOXfkMBOUN5enDKCgbFQRflyNP82S9OqACGfmUre2h9vLGz
         4IpAbCI1XnBLhDUcgmaTHvVYvax0L5dMb0o4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743740041; x=1744344841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYtYdDVynheItBtfiKKOxM1KmD+C5mWgUcIfjnewaLE=;
        b=Bz7m3O75HZLzlfxbQ0qaDdUlo7LoPZynyMOdfOFo46/h31JqSNSJc+JDyeUe1+bIbl
         DPto3DJYA+pKA0z5Dy3DV9Z1oUeBIhyV/IPqJFFEvXgefsRQRxc7KxCPlpDAXLmm2tJR
         DI873TK2G+NVDwtntgoKerChCP+HvkMWf2lIVKb80oUjm2KqWd2PeNbzM/LvCrSifRJs
         POt3y1B66RpgvYALZCS7rEOu3qZzObz5DzVTjz5gVAVTHiC+H1OLFdzvFHIkuXjyGLHO
         TfRNuwSKylx7+smlU1YLjo5OdaNca64cknwTl9jCsg1NV4i/hEgBTKrO4rKIsVOkG3ov
         V1AA==
X-Gm-Message-State: AOJu0YwM1h19WsLDk6VzornlfzBG/Ag/gXpLT+9AOCRTYwkqrD92Rpj+
	41W6pYghV23hnQiQZviR+W+2j8ZcWZUY6DBXkR5Lc2B6wDmWhfclUVPjUzL4TsV8LMKgSFPOKMg
	1fgg=
X-Gm-Gg: ASbGnctMaHL//cdowPRjgDTP+9eG7sZ541We2pz7zf1PBdMwtEV3slIzR7Ea50NhfZH
	b8YRYA3Fi1+9cNQvUAXlzw8Viu2ExzD8M9/zM1sTJ/zgvTpAm3cTHhaRvGHQpDOmT3WZXHpGvZD
	a3Kd8+6ICUGnQQrkElq2T+et8v526bEJQr0AHt0FImqg3JGO/ECAx7jLyKxtUzCXxjVffWVaYcO
	hXzrQrfAJClmwfWODPXmNNA1s766MaEM+sxd0kC4Oo/xmegx2jQY0UiDlFN32Sgi/l1l9rYpnar
	jK0zkjnGKZkitJwrF6Kto8woB5AyslH97IMGWCUnTuj7+s2qb9S4CvQl+fuY4b9vAbd3NLlL4H/
	dZlV9VrTEj3B66XVEJLc=
X-Google-Smtp-Source: AGHT+IHFNOwMGCLWYP3Gch7Lwo4T3jlCtuJYsFNuUmVorKZbYPp6yhnYa6yHyg3K1BBu8wrttK8ogg==
X-Received: by 2002:a17:907:988:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-ac7d194a064mr169518366b.34.1743740040730;
        Thu, 03 Apr 2025 21:14:00 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c45asm184981866b.1.2025.04.03.21.14.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 21:14:00 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbd96bef64so290841766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 21:14:00 -0700 (PDT)
X-Received: by 2002:a17:907:988:b0:ac3:c020:25e9 with SMTP id
 a640c23a62f3a-ac7d194a064mr169514066b.34.1743740039779; Thu, 03 Apr 2025
 21:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404030627.GN2023217@ZenIV> <CAHk-=wjEsEnLC-PXfTHXtKQMjxZGi8VoJa3H0s39CoCTMmpz3g@mail.gmail.com>
In-Reply-To: <CAHk-=wjEsEnLC-PXfTHXtKQMjxZGi8VoJa3H0s39CoCTMmpz3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 21:13:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYm1VZgB4v=_cjQ3wBeB9SYck0iGuK8GzSMjxi4isJ9Q@mail.gmail.com>
X-Gm-Features: ATxdqUHcMdQurZZ8rfP6TZBU29rvXu0sp7krdDk3_Wr9j6last4A6rPTpS-Vbvk
Message-ID: <CAHk-=wgYm1VZgB4v=_cjQ3wBeB9SYck0iGuK8GzSMjxi4isJ9Q@mail.gmail.com>
Subject: Re: [GIT PULL] fixes for bugs caught as part of tree-in-dcache work
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 21:12, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 3 Apr 2025 at 20:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
>
> Uhhuh - can you humor me and make it a signed tag?

Oh, never mind. I see the tag.

It's just called "pull-fixes" rather than just "fixes".

              Linus


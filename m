Return-Path: <linux-fsdevel+bounces-65374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E31C02C60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFD414EE325
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B534AB11;
	Thu, 23 Oct 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1rXeHjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038434A3DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241373; cv=none; b=U//ok95XxR1Ccv66oSHtI4Zpe8dQkUs5vBezm1OBdc0gxkJgqYvMMWBtKt5Q57Wk/bgVQj/SRh5P+OtFbTmwj4AHCxE8LQKuMMVWRqgUM0jQH8FxlZbTC35DIhGPV2tngrAQdPnT1CZwU9qcLGjuQjEVWY1ULz83V35Hced8g8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241373; c=relaxed/simple;
	bh=SOi8RTAvsP5fHphida3kvNb3CyaDYKqZqhJ0YfbI+/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJulTngSOyehBIog18BwfjlTxn/JKE5BVlUmrSUaB0MvA1hRyNYlSFf1mhoaImIFa6dXUbcjC9iEfDYO8RkXHuYR1Uh6UCylDiVWQW9UaZQzf0uiGeYVkuscNn4Bok9yJQeLP9xdNrngHpI+u2wG+bdDbOH0mC5fVcdtrKKcgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1rXeHjW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so2010218a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241370; x=1761846170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgjwodffJXCXV9bFCxRQxHHnhjnX/ahOR9pMrTqBvoc=;
        b=O1rXeHjWSl+Nw52FXcYJ61T6RoKZowNj42LSaJKMKlfLNKrgp5ByBffGK2eo17Tijg
         q153QGRNeN7LYb5LnEKgSW1kdLvRbfo6HkIG3nnlEpCn4qigkHLzJNtrNqw++LRwDpaf
         sJi+eh9ebDwna/h8UVtfj/U/2g5ACM2Ky9uQpZ8d687LCgFxX75G6JP3jiQOB4LHoR/w
         QXLT9gS8lS1nNq8oMp/ix19CjbuRL/wdBYrhrWPVESIxGwsKftRuflxic9ndFf4SwFDy
         E05iWClNuEs32ev6/C5pLYTdl3FF9XdjkA1sOC53gbQtmEV+TQNogTy95LPXET7LUR94
         TNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241370; x=1761846170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgjwodffJXCXV9bFCxRQxHHnhjnX/ahOR9pMrTqBvoc=;
        b=H/wKez3uAZhw5zHNpJWNxhhHeAlrLjWTIbdolTWsvbhyNmnS/pC3hTNIzS/OANZajm
         XdBbE9bAPNYtCW081oduSSuPAflHRVMzc3Pl973h0BcsQLosFJhb+olvn/MrTHKF9U6v
         iwy23QvEK3wEfMMSRRh5+h9p5Np0aQsMzN0XZhD7+4qgP5/LO/IP1WYkZFPNVDKl/sAB
         /lw6avMJA5UfSnI4pcT1AdzpeAq+Rl/FUVLKxygReY9tejgs5kt1JFapj8nk1OcVXbYk
         xR5ytG+ddiGik4aWCDHFv+AYVGYCWptp1+EFC4fMTML0saoxBxg+Pq7G8reEQiRMLzPx
         7Z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYQWMtCAuueE/sv0Dn7VpZ5Djjh0u9t0rv7SVZGR0m+d5PtBo3HK1MFx0GtNQh56T/TgsmOtw6j8ndmZ0u@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkrlUt6yARXl33GafG58FkG+QIxXkwluK20oEDFBKmBi8OVWi
	1JYy9EAnaBY3CbgqbApgioEMya73/OBS4MRaxM1e6/onYYitbmFnySHqd5Nj0IZMBYdTrlPNuMl
	/uC8aXGI0l96e5qVui8JXtkpok+UNtRA=
X-Gm-Gg: ASbGnctp2osPu23eaC6mY2O6iAMcHg47um303aSa110X8kEaSYHVsXx+Q362EQOzeGI
	789XS55baTVjnAIRwRfNQfgRN7d5xqqE4774PvU6q2D8IzWpI33Glac/RkMxXPjoFPtoiLnIT/4
	75hyGqCDJWm8CTl6y/CyeUctJcEFtl0SH6QnAITAGApmjhKbZlIE+vFT3xaNgOfiRuMijTfSWCK
	slR0OsByTaW68q4s9GrgIQS1s/DHQiVAOBk7Wtx2gdDYe+HYmUuIQyiFoztaVk2l4kvddOZKw==
X-Google-Smtp-Source: AGHT+IEKQYSOEcrZQfp4cJ7IkzzOuPov5OvT9VKtkMyLr8PjhSdzUuJ0K2NylS1MWdT9Z9LwTFR1Qn2IXWVMA8nvEAc=
X-Received: by 2002:a17:907:2dab:b0:b44:f9fe:913a with SMTP id
 a640c23a62f3a-b6475d04cb3mr2843914766b.65.1761241370295; Thu, 23 Oct 2025
 10:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
In-Reply-To: <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 23 Oct 2025 10:42:37 -0700
X-Gm-Features: AWmQ_bl7HHHe3F5m7s8SKqaEwkR90lx0Ku2nfc1LYSRH2AGyQ13C81borZW52B8
Message-ID: <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:34=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
> On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
> > "garbage" as in pointing at something without a direct map, something t=
hat's
> > protected differently (MTE? weird CoCo protection?) or even worse MMIO =
with
> > undesired read-effects.
>
> Pedro already points to the problem with missing direct mapping.
> _nofault() copy should help with this.
>
> Can direct mapping ever be converted to MMIO? It can be converted to DMA
> buffer (which is fine), but MMIO? I have not seen it even in virtualized
> environments.
>
> I cannot say for all CoCo protections, but TDX guest shared<->private
> should be fine.
>
> I am not sure about MTE. Is there a way to bypass MTE check for a load?
> And how does it deal with stray reads from load_unaligned_zeropad()?

If I remember correctly, _nofault() copy should skip tag check too.

Thanks,
Yang

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>


Return-Path: <linux-fsdevel+bounces-53984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453BAF9B63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AE21893026
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F121638A;
	Fri,  4 Jul 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B/pENZnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEF20ED
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751659081; cv=none; b=P5yuEtdQXN7yE4asHECxfwggIUykGmxrPL0Tdkn7JPR3RC8QLCKxFAR9ReiBJ8zyefxOXlxn2qukx0n3yr29/OWe8U1ME3vp5LUqO1OoQZMtXB0Kqbl/ENQ15jLwcc5dqdBn+AnacpqaxazsGPya933wMzoKB8Bmyb6yyMwe8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751659081; c=relaxed/simple;
	bh=vDmNgYH27jQ46GuPcGp/vbql8MFmUX33WjOkMO4B3NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8x4GxLaCydRUwS4yYzc7hCCUAfefH0tCnuXDyEoGGz3ywFuhg16TWZC3ebcqXASU7QNXYsf+nDlHPySIyYUd4HiteRoKH5ONyWrQXVHTEohbo5oM7Xmg8zcNJxmZWcR/OGjeVYzphp2M7SHYKHrJwYQyYcpem+kKlGjjVwi484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B/pENZnE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae223591067so190532266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751659077; x=1752263877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1BKOcMAgoIl3CyEeLpsaKuCswUQ3lICiZPOc1QxTAbQ=;
        b=B/pENZnEV8ZXLOe5BFIoiAkhkB4UIhxmtS6Irc17nqNhrk0U+fEN5JW7xxQjkvEjhS
         5oZoREshI/ZrC5TS7EMdLjQLMA6KfXimwjsg32opPpkNGindsDRcndyQMd+P4uMNK19l
         KjZfPgBCwU/HSOUXcUqJXWIdHDWLLs9ZP29hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751659077; x=1752263877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BKOcMAgoIl3CyEeLpsaKuCswUQ3lICiZPOc1QxTAbQ=;
        b=hc0afMZVCZmtKqG93y8Ed3XUB7xxhiRwsIrmI7w6VUp21fouuF42ov7AOk4FR5y3J4
         3RQcG7IKB8u2DtIMkD4mNdBUzMpS5z7om+0rNlc4QKJOuj8wNCIiXm5EGIJ6kguM9Ovx
         mNli2zM3JFfJUPGaCmsnEtA67xRSTt99GRsSudPtMLD0KYRPqGIH3UdA5FgkK6SjcwF7
         jrAIosN+ygy/Ks58cKEIv4+kzSGAMiQJT0da1RwXWWhm6nnP3lIIzqjPbACqWHa0TpmZ
         gxhSk2l+UWTSPUWbF+5lmmWYT85r8ty6ObXIZKVTgCk4WDReEKY3Z6Yo01izadqt12dd
         AT4g==
X-Gm-Message-State: AOJu0YyUQnBhBfET+sQmmAbdVZahq/TzoqKwbZVnvl2Bpe0A/l2pV/+4
	8ni4RK4VW80US7qchV4hZWnMGG/BL9SyulcU9re62tp4gy9E3es5pjPGl0Mkr4NSpJ0EFTL/kWM
	gUYPv1os=
X-Gm-Gg: ASbGnctGkOXBxjCmKi7+lwJezQG0N1QxT1QXc2rzObGagBgxyeW3Kmzu0RhxlwrNdHR
	NBbKhJtQcrE821HRNXagDzhOuvSjL4pPhLuj7eVjIGthubX8TJC/gc8P1wqUSawbj7g49JcYlK0
	Q7XUZhqbQ8vLxsyS3KRwLvdeI7q8YD00kO6/LTZqBrl3YwVwEDGagB3dyPCVrg06sBghiVOVImV
	h4RaDZYYrMthp6VNFb8qP/9BwT66ez6w00XMPINeWmO1x3NUatwUtxkLdgkf2+YudIe9XPPy67D
	DZJ5/2OJTqY1MECeFHwQA14n94XZgpSvcWJylUCuZKtpY/gHvxK1en7DWv8Z9PorcIghOiRHqlq
	555DiTlwcHmT+ij3fMkvjHCKlwjG0KdE/YXo8
X-Google-Smtp-Source: AGHT+IFJqD8Djmc8MyP7LrLBu2/Ly3BnjCCoIy4iYgjOgitaNcbAdVm9j4M05DiEvQBk7nxhfhGdlg==
X-Received: by 2002:a17:906:584f:b0:ae3:f296:84cf with SMTP id a640c23a62f3a-ae3fbd8b224mr295346466b.30.1751659077068;
        Fri, 04 Jul 2025 12:57:57 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02a23sm224185666b.112.2025.07.04.12.57.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 12:57:56 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso2394007a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 12:57:56 -0700 (PDT)
X-Received: by 2002:a05:6402:2683:b0:604:e85d:8bb4 with SMTP id
 4fb4d7f45d1cf-60fd338632dmr3478983a12.21.1751659075849; Fri, 04 Jul 2025
 12:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704194414.GR1880847@ZenIV>
In-Reply-To: <20250704194414.GR1880847@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 4 Jul 2025 12:57:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
X-Gm-Features: Ac12FXxygtdRLn7SMmYV2fo9XTnfHt5ss5Vt2k9qjOp1GE39Tvhk8iV_Q8Ucafs
Message-ID: <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 12:44, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         What if we steal LSB of ->mnt_instance.prev for what MNT_WRITE_HOLD
> is currently used for?

Ugh. I don't hate the concept, but if we do this, I think it needs to
be better abstracted out.

And you may be right that things like list_for_each_entry() won't
care, but I would not be surprised there is list debugging code that
could care deeply. Or if anybody uses things like "list_is_first()",
it will work 99+_% of the time, but then break horribly if the low bit
of the prev pointer is set.

So we obviously use the low bits of pointers in many other situations,
but I do think that it needs to have some kind of clear abstraction
and type safety to make sure that people don't use the "normal" list
handling helpers silently by mistake when they won't actually work.

Yes, that tends to involve a fair amount of duplication - exactly like
<linux/list_bl.h>, which is obviously the exact same thing except it
uses the low bit of the list head rather than the list entry. But if
the uses are limited enough - and they obviously need to be limited to
things that never look at 'prev' - maybe that duplication can also be
fairly limited.

I suspect we should also have another level of abstraction - we do
those "low bits of pointer" things often enough now that we probably
should have actual helpers for it, rather than have people do the
whole "cast to unsigned long and extract/insert bits by hand".

But that's a separate issue and largely independent (except that you'd
introduce a new use-case).

            Linus


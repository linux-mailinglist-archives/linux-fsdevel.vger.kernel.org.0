Return-Path: <linux-fsdevel+bounces-31097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCD991B81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 02:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BC1F2214F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EF54690;
	Sun,  6 Oct 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fvAgVPg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35533EA
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728173692; cv=none; b=riw0r4BjFu3boKEPSr9IyacfzvU0LjUvR2FvgQk75GlRxckJ/Pk9uR7Gu7w6/5zXEZtUWKLwnKJixTKnsr7Fmsz84FXY7tmsdLIKZhTUo/sNZUhStDCh8fUjKp6lhVIGepzLcE8Sw3XCBn/LtckCMPKxoDFJY1WGm1DGxlN/bcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728173692; c=relaxed/simple;
	bh=HgtCN7iIuMmkaNV3I4PdNrx0uSYLvra8kQ82Jy6qi+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAfrrAmt4tOE7zURl9ir3zesQ/LZFOoSTa88I/cveSTj7bWGSpYxbVDuyKK0qUOnyLogZkgcRqX8E4SOkyKDnhFFcs5AIkNb5vMFnePDpE/+fiI/4fPG1VDOEXdUl0j8XGoKwRF0LsBQX9YVzBRiVPgRK2AHkNiLK3xio0OPoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fvAgVPg/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so63275766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728173688; x=1728778488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nzL6PAghOW3KzpclFbijO5KDwmQqxWPsUEDBX6EEH4c=;
        b=fvAgVPg/oE6klaHrBv9vZ7EyKbAgfoU4pmzqjFKQb231i3/7opuOLl+ka4jp/PfpcP
         n6xIVhw131t9RbekdLQTNiaFFKIbyvMmFehfjq4fKnC2xYSfVBY12uLU82hkUaLd77KH
         MuH4kkb4RZGyUhixx6kCk6osQLD6fNtGr7QMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728173688; x=1728778488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzL6PAghOW3KzpclFbijO5KDwmQqxWPsUEDBX6EEH4c=;
        b=jrKGb/FhlBUeHxChrLLt+K9157oqPA2eb88aJ97H47KlD1i6SO+Xm9L1joB664xWoo
         ZwOxE9F7g4Isb2NxyYz4xrFHykBRfHWct/wmU3Eqdl4JZnsbEPiAHLjc+rPuFG0r/HRN
         u2PIqNQ0pIle2D3oejN6auOHmb2CBlGrC+wpH3iR7PZcwOUTlqq3QqTscPMVt5aUsHUp
         sL8CgsbB+ljMivGJxvBgISUjpUC32WrMgShOpc6lg1lnD7Hm2+Sanra1N7W9Y0kxY89v
         yZYLmhtxnKILYSnE5zFOnMDm+iOom8/VBMBQRGtLpIaald/UYyQ6knV5VuhTLxMUZ9yl
         +Z6A==
X-Forwarded-Encrypted: i=1; AJvYcCUfz38cV24jYLqiyvQnPWFdYl70z8oWC5jK9d+aByDeHTlor1Z0YDy7ElPH2JkfssV/SCThGLPwiQzviS7W@vger.kernel.org
X-Gm-Message-State: AOJu0YybNXIxHvtDCO6zI1VWZ1W1uBLgo30LGdwMx441IHgT4BOGGFaz
	oYx/1WrHom4TsCveNQRbXBncdzFY/Gx0vGzhR/9kJL/3QsFZ/Jus5jYfHFIyS6AoHhN8hXNx9jB
	XMTegJA==
X-Google-Smtp-Source: AGHT+IGv0d5qyuBtA/oHE8zozRaNjNRHSWYUy1PNS9Ly/8Arti+Be7tgo7Ansb++oFV9sm52Ma4+qQ==
X-Received: by 2002:a17:907:96a4:b0:a8a:af0c:dba9 with SMTP id a640c23a62f3a-a991bd3f93bmr660757666b.16.1728173688332;
        Sat, 05 Oct 2024 17:14:48 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993fa1b94csm117990266b.53.2024.10.05.17.14.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 17:14:47 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so63274766b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 17:14:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzBiPJ1LyVmTLQnn+iKsr9ojQWUhDxs2WGnQQNBKW9VZAQav1dqwonlr8gH3jn2HpAm8/RFtvTBOBTErk5@vger.kernel.org
X-Received: by 2002:a17:907:c7cf:b0:a8d:286f:7b5c with SMTP id
 a640c23a62f3a-a991bd71ec5mr611797066b.27.1728173687316; Sat, 05 Oct 2024
 17:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com> <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
In-Reply-To: <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 17:14:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
Message-ID: <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 16:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> If what you want is patches appearing on the list, I'm not unwilling to
> make that change.

I want you to WORK WITH OTHERS. Including me - which means working
with the rules and processes we have in place.

Making the argument that we didn't have those rules twenty years ago
is just stupid.  We have them NOW, because we learnt better. You don't
get to say "look, you didn't have rules 20 years ago, so why should I
have them now?"

Patches appearing on the list is not some kind of sufficient thing.
It's the absolute minimal requirement. The fact that absolutely *NONE*
of the patches in your pull request showed up when I searched just
means that you clearly didn't even attempt to have others involved
(ok, I probably only searched for half of them and then I gave up in
disgust).

We literally had a bcachefs build failure last week. It showed up
pretty much immediately after I pulled your tree. And because you sent
in the bcachefs "fixes" with the bug the day before I cut rc1, we
ended up with a broken rc1.

And hey, mistakes happen. But when the *SAME* absolute disregard for
testing happens the very next weekend, do you really expect me to be
happy about it?

It's this complete disregard for anybody else that I find problematic.
You don't even try to get other developers involved, or follow
upstream rules.

And then you don't seem to even understand why I then complain.

In fact, you in the next email say:

> If you're so convinced you know best, I invite you to start writing your
> own filesystem. Go for it.

Not at all. I'm not interested in creating another bcachefs.

I'm contemplating just removing bcachefs entirely from the mainline
tree. Because you show again and again that you have no interest in
trying to make mainline work.

You can do it out of mainline. You did it for a decade, and that
didn't cause problems. I thought it would be better if it finally got
mainlined, but by all your actions you seem to really want to just
play in your own sandbox and not involve anybody else.

So if this is just your project and nobody else is expected to
participate, and you don't care about the fact that you break the
mainline build, why the hell did you want to be in the mainline tree
in the first place?

                   Linus


Return-Path: <linux-fsdevel+bounces-7847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DC82BA09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 04:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C10E1C24960
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 03:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B65A1B27F;
	Fri, 12 Jan 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QS/AHa6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337F1A733
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28fb463a28so632183966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 19:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705030850; x=1705635650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1uV8nauYydYh4R8L5vh4G6BKRZADuM0xKtlvDNSU8=;
        b=QS/AHa6iRB5GR5jnufYFCQ82uuhW0VBAlOLo+GJOlAYUz9eb4YB6FBK2h7Pa2MfTwP
         /v1frWP6omxkSlsJ8/TYApcNcPfO0qYFO2t62zk8uC+PN0QE6oIk9asuy/hDQxUeomD8
         KwYfZlXuUrXo3J4+1D7/Wy0EwtuWpK6p7gA+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705030850; x=1705635650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1uV8nauYydYh4R8L5vh4G6BKRZADuM0xKtlvDNSU8=;
        b=rWQnt5GQ8+AOvT56bOvbtpcmzHzXVI+yQ+aoYM4DBCmPt/ng8RVP6kvUDS4WjSMv+r
         Aw0RJhYKPrRY12w3/r7RjW8yLghQ8DVVPL/xZkq5hXk2gEfrq0auOUcMwl1zbdrOKpuE
         m0/admadnev1xTbACz4MGJAkQVuv8wQuP2trYTXbLuZiliMi7eDpIvgUu+BAEk9w8uS4
         NHoOxRUz81jp5LW9vr85NzLEk7UpQNDDxdTx1RDKrJlL74G50y7AKs7kdtS6GW1VCRSo
         esjkie5YP7M3KiE10mTqW3PkXWwme2bKAnvbbkggiSqumfa4VnZgnfWMXijANUoXA//w
         FXOg==
X-Gm-Message-State: AOJu0YyR+EgDlXBDyBLBD8x/15e8usHSObeYuDreRaMwr/t80lsmDQRd
	jixlB5DFCwCxLy35yAzqEAVsHrIqyMQTbgQbvH+KvFyqXcTsA03p
X-Google-Smtp-Source: AGHT+IHlJSqXJx1ov7Uun3a1shyjNFb3gJ0b0IGPdF3Clvv0RZ70dWkgZq1Pbaz9zqj0AUE61RfA2g==
X-Received: by 2002:a17:907:c9a9:b0:a28:e3b6:a199 with SMTP id uj41-20020a170907c9a900b00a28e3b6a199mr252110ejc.38.1705030850373;
        Thu, 11 Jan 2024 19:40:50 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id ot8-20020a170906ccc800b00a28a8a7de10sm1276088ejb.159.2024.01.11.19.40.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 19:40:49 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so665960466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 19:40:49 -0800 (PST)
X-Received: by 2002:a17:907:a02:b0:a28:df9e:b2e1 with SMTP id
 bb2-20020a1709070a0200b00a28df9eb2e1mr358646ejc.54.1705030849339; Thu, 11 Jan
 2024 19:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net> <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
 <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net> <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
 <77b38aa7-a8b1-4450-8c50-379f130dda16@roeck-us.net>
In-Reply-To: <77b38aa7-a8b1-4450-8c50-379f130dda16@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 19:40:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>
Message-ID: <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 15:57, Guenter Roeck <linux@roeck-us.net> wrote:
>
> I wonder if something may be wrong with the definition and use of __m
> for u64 accesses. The code below also fixes the build problem.

Ok, that looks like the right workaround.

> But then I really don't know what
>
> struct __large_struct { unsigned long buf[100]; };
> #define __m(x) (*(struct __large_struct __user *)(x))

This is a historical pattern we've used because the gcc docs weren't
100% clear on what "m" does, and whether it might for example end up
loading the value from memory into a register, spilling it to the
stack, and then using the stack address...

Using the whole "tell the compiler it accesses a big structure" turns
the memory access into "BLKmode" (in gcc terms) and makes sure that
never happens.

NOTE! I'm not sure it ever did happen with gcc, but we have literally
seen clang do that "load from memory, spill to stack, and then use the
stack address for the asm". Crazy, I know. See

  https://lore.kernel.org/all/CAHk-=wgobnShg4c2yyMbk2p=U-wmnOmX_0=b3ZY_479Jjey2xw@mail.gmail.com/

where I point to clang doing basically exactly that with the "rm"
constraint for another case entirely. I consider it a clang bug, but
happily I've never seen the "load only to spill" in a case where the
"stupid code generation" turned into "actively buggy code generation".

If it ever does, we may need to turn the "m" into a "p" and a memory
clobber, which will generate horrendous code. Or we may just need to
tell clang developers that enough is enough, and that they actually
need to take the asm constraints more seriously.

                Linus


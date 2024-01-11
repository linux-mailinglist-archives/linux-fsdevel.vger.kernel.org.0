Return-Path: <linux-fsdevel+bounces-7838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A782B85D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 00:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CAF1C23979
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834675A0E8;
	Thu, 11 Jan 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DYyV9AVQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C659B6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so7886131e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705017522; x=1705622322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsr6PFlZr2msZU50SITFyVGPFm+oEax+N/q9E6uP/As=;
        b=DYyV9AVQydERZeSEYr2aUBf0HOdug7/MGPUMX0nhGBEq9vWPVkwEV8BfrQpI1hoRRB
         vQA2tKUmrFEaUD06Wr8Pn/bgqRZmRQACgeClukpS7VRNpBVlMKWU4hWNT9lXGfyanV6z
         FV5N+3AfJJLXoSSKkgZmoKUX7NoQU4CfyWGQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705017522; x=1705622322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nsr6PFlZr2msZU50SITFyVGPFm+oEax+N/q9E6uP/As=;
        b=weWUMnTO7f2PyPZjfxyIEAucyt6zE+ZmWI8V4RGsv2LrER4W73oJZyldGpGIzsBfiD
         Rqhp91SeXiGF4kL/kCZvG6giRyCe/O4kkYkQmPcUutMqweh5pQ1/WhYpSxA+JcSSr/1/
         Q5Yc+MtZc7HORPG+8kiPEBiGfBSy7gdQVaTna3T4XwlegCTfqUuGe9wkG1X4Alt7DJX+
         lWUT1VOSIb7MK82REpslEQUN79yJeHyYLedqgK5CcudxY14o5GFgwW7dBfsCu1D1mLVf
         pBbS72YHJutIt6IqVkPT0CfFdYh+9EIfxoujSDf5/6obXbpQE5pz8UYFIKQH/5EBRyOv
         FTog==
X-Gm-Message-State: AOJu0YwB5nHcPRWIimdIDCaI8nWdoyKrXrsfA5cdMyB6iFRfSWvlVVG+
	gOdJY+U2XPsyesnKZ9rpPVwxOvG8lZfeFNXJpwqFg0n50Pf9JKhN
X-Google-Smtp-Source: AGHT+IFIZZ9swLnKOJ5SDheP0xcjEXFhzODAlSsDJm+5n4s7fgCS4UKcc4TqBDQ2KQLeGNHlUTv5SQ==
X-Received: by 2002:a05:6512:6d0:b0:50c:327:9932 with SMTP id u16-20020a05651206d000b0050c03279932mr269356lff.107.1705017522165;
        Thu, 11 Jan 2024 15:58:42 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906271300b00a2ae0aa9002sm1127471ejc.40.2024.01.11.15.58.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 15:58:41 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2821884a09so504323066b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 15:58:41 -0800 (PST)
X-Received: by 2002:a17:907:a609:b0:a2b:d242:8d35 with SMTP id
 vt9-20020a170907a60900b00a2bd2428d35mr295990ejc.40.1705017520730; Thu, 11 Jan
 2024 15:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook> <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook> <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
 <ZaByTq3uy0NfYuQs@casper.infradead.org> <202401111534.859084884C@keescook>
In-Reply-To: <202401111534.859084884C@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 15:58:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWHj83=NnpT5mo9M7r=s7GmCdNczRfmN87thLFxA+pqQ@mail.gmail.com>
Message-ID: <CAHk-=wiWHj83=NnpT5mo9M7r=s7GmCdNczRfmN87thLFxA+pqQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 15:42, Kees Cook <keescook@chromium.org> wrote:
>
> Another ugly idea would be to do a treewide replacement of "func" to
> "func_deprecated", and make "func" just a wrapper for it that is marked
> with __deprecated.

That's probably not a horrible idea, at least when we're talking a
reasonable number of users (ie when we're talking "tens of users" like
strlcpy is now).

We should probably generally rename functions much more aggressively
any time the "signature" changes.

We've had situations where the semantics changed but not enough to
necessarily trigger type warnings, and then renaming things is just a
good thing just to avoid mistakes. Even if it's temporary and you plan
on renaming things back.

And with a coccinelle script (that should be documented in the patch)
it's not necessarily all that painful to do.

                Linus


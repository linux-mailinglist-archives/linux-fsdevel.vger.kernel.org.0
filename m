Return-Path: <linux-fsdevel+bounces-41300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF0A2D94A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 23:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318023A6C85
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 22:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28891F2BA1;
	Sat,  8 Feb 2025 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YgMO+78L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED11F2B86
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739053861; cv=none; b=eq6uLmRO2zjFB25V2W/2qCMAcHOHwFdJNjLxUoVR67q7lspSpwQnN61lGPH3mZSOx5u8F/pvQnVEIxVUh/Y7HI2VnpXjIgedIW+G14mK5DdhHzNpZJB6+13ZniCTrOc9yv5CylSJiNlLz6Cv6o27D0a+OwHva82u9PyTWvr4TJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739053861; c=relaxed/simple;
	bh=TBDJ997VKmPJ1tZPOuA66AYxLKB/sngWskbkaskv+Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQpeHUp6yLGmdMVz6U3Gli0KMosg8M2OKImJ/aBJQFXzRX2VGAbnDnXp0xjJgdty41lvhSDH1j/5DVAmn0xkdcQgVwyq14pkqO6XE1pBt7Sw+DSzhzBNiL3NuBNRWRUAJZEJ8kUnWNvcIHIv2lqyDrnDd6nm6SeBT5Tb5WYvLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YgMO+78L; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de4a8b4f86so2769716a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 14:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739053857; x=1739658657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dzv2sei+8fQDzyEn7+PpLoRqxzbc/n84CuipDMqSkog=;
        b=YgMO+78LkmU48Ja893gQsE/Lm2c9jcVvJcoTx/xSdzZLBAH7YFqZ7K0332uOD2g2hz
         VPli9b9Cv8dQW1mk7yrgA86MtnmiYkks1bHkzF2gDQ43cRXDuqaM0/4jA9vjRFOtQ6py
         sTqe2sktnlVdu73DmgDz94Ym6ZF823aOJNCbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739053857; x=1739658657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzv2sei+8fQDzyEn7+PpLoRqxzbc/n84CuipDMqSkog=;
        b=R2sPDPAc2062N8l3AueEsukJJSsN9JcTwE7/GFMJWudVlMnzIoA8e2aaZrTGrY83sJ
         XJ7uTp2AeySh0GIUySSlXzKrjyANUWeBN/sINIR96BrUvbCrSXO/xboJcnul0Xbb9V3g
         HXDSv200Y+UaYQ7hGX5PiPryc1kpDRxBmQMM1l4Tjacmdvu2BemincL7PG3GHt9t3Msh
         Y8MXynY6QQF5F59pIq9BopRy2rE4iOIYJPG1a0KRhkdZunNWnPp+FW2K0XYWf2EkOWG0
         ST05AiMSIqwqcnjz8c4hvSLrhBr2MbZKiZN3g6HyqNG09iFylt/J4NCTZRk8MQjlr0hd
         y5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQdVCL5tSsPq37mFTs+hmL3xgenfmc+dCbnteFiZS7lc4+fdtxsvmGchccMN52UBcvzwYnJATPmsHydjYf@vger.kernel.org
X-Gm-Message-State: AOJu0YxSbVcMqpc9ZL7ggypitPCtcG/zP68tzGs+7uQCqc74l16Mbhwr
	Fmd1Gu5WOx75uZWQVLw4QbowPD0ll1xIZXPrzzPO2banA8VR73n/iFJlJnjHFnnUMDFLqx3Rdxf
	WS2Ry6A==
X-Gm-Gg: ASbGncs9n7zG4PL+vLSmcKeG7qVaYpyoY15zToAQOrAdODYEb5Ked8g7LPXyi8KAPDr
	HPLt48yav369+RQw/hEMLoaXH3H7yl78BNmY8ICaEZhXOwFG8omManvlRn2/+z2SFu5C/ih1B/D
	VYF9Z2iXERu1TwQ8hxrXx1Zs4+cisl7iQBobo7KQQQxSL0tFUGGnPtIt/JLJJ1ZCNrx6XRWreoc
	TtdSDTksjMEg5HsnMTMABtDOJd+g6ozL1QrUyDWA9Y373Oi6i6R/lXV/UZcPb0OID0GrYTYLRvf
	moNErAx7RIn43L7f0v97c+naHTn9D7TA/3A4WJeHxV/mtrrrZFX28I/4lLAwYazYoQ==
X-Google-Smtp-Source: AGHT+IFXPZF6tqkoBqT0NLLm+y768CuEhP8XHXgVmVCDoHXzDrszKFB5UtBgD7anGIqes88w3y3LXA==
X-Received: by 2002:a17:907:3f90:b0:ab6:53fb:a290 with SMTP id a640c23a62f3a-ab789aeace2mr1022107966b.27.1739053857262;
        Sat, 08 Feb 2025 14:30:57 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b32a8953sm37850466b.97.2025.02.08.14.30.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 14:30:56 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso2730228a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 14:30:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUG9Gs2hor4/3+hhIclvFSY69lJVduOFx7VC4Bt5wrb+6Oc/EiCc/t1PqsvyuI6xvJh4o/MkmFIMY0N3G1N@vger.kernel.org
X-Received: by 2002:a05:6402:e8a:b0:5dc:d34f:a315 with SMTP id
 4fb4d7f45d1cf-5de450236a2mr10109677a12.15.1739053856195; Sat, 08 Feb 2025
 14:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206054504.2950516-1-neilb@suse.de> <20250206054504.2950516-15-neilb@suse.de>
 <20250207210658.GK1977892@ZenIV> <20250208220653.GQ1977892@ZenIV>
In-Reply-To: <20250208220653.GQ1977892@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Feb 2025 14:30:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEbj9p33Cn_P4PawBqkav8zQq5+WjtzqYCK0o621p1kw@mail.gmail.com>
X-Gm-Features: AWEUYZkVdsbtACu21LpSl3eoLNK0ZCYNVhLM9NFFO3RNNCTRnheKiuYyzhwaC8s
Message-ID: <CAHk-=whEbj9p33Cn_P4PawBqkav8zQq5+WjtzqYCK0o621p1kw@mail.gmail.com>
Subject: Re: [PATCH 14/19] VFS: Ensure no async updates happening in directory
 being removed.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 14:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > OK, I realize that it compiles, but it should've raised all
> > kinds of red flags for anyone reading that.

Well, it's literally just missing a ';' so, the "red flag" is "oops,
nobody noticed the typo".

> > return + <newline> is
> > already fishy, but having the next line indented *less* than that
> > return is firmly in the "somebody's trying to hide something nasty
> > here" territory, even without parsing the damn thing.

Sadly, there are probably no sane way to do semi-automated indentation checks.

> Incidentally, that's where lockdep warnings you've mentioned are
> coming from...

Yeah, so because of the missing ';', and because gcc allows a 'return
<voidfn>()" in a void function (which is actually a useful syntax
extension, so I'm not really complaining), it compiles cleanly but the
lock_acquire_exclusive() is done in *exactly* the wrong situation.

Do we have any useful indentation checkers that might have caught
things like this?

gcc does have a "-Wmisleading-indentation" option, but afaik it only
warns about a few very specific things because anything more
aggressive results in way too many false positives.

I've never used clang-format, but I do know it supports those kinds of
extensions, since I see them in the kernel config file.

                  Linus


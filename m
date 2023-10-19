Return-Path: <linux-fsdevel+bounces-781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F467D007A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9259D1C20E35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68532C9E;
	Thu, 19 Oct 2023 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KUpVFCOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE25225DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 17:26:49 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E2116
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:26:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9becde9ea7bso230621066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697736406; x=1698341206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmTGqTn965x8Iqb+7zVicGdJQKijTkj69SBYkbhW+y4=;
        b=KUpVFCOjr+oWHEdOZjhesNgbajk6TmAZd1jP2/ObpbisALPwfMTT/NRB1XjrJQ0i/3
         CdVjF1Iqeq3IrpbZBFpDl2v+pmDycByBplN3zfL/qc/TrVUAe/fJTOWpvV2ewYm0BYH4
         4oUrGEO/3RRZp5qRgqrh6P0dHpGyqM/lce3hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736406; x=1698341206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmTGqTn965x8Iqb+7zVicGdJQKijTkj69SBYkbhW+y4=;
        b=XiTd3hfSs4yWsKV0wDAvN45LUejn1ZWVMJ9LzszUaWEXqJqiZiz9MznCRAIBeOX1QH
         bW3ZoAvWB7t7MxqDAfMtHSR4xnM8iU4l1jK0rFfSD9phacjR3qdojgAsWQ/61E2vOARC
         ovKkvkAG+Ftf3Z7GA+N0v0W2wyT5IUwwW2wzil7y+jw4gAqFYsu32e4CbdTitKS+PLgB
         zQCqmpYkI3Oe5HEAmx9qtAh/VKyouO8xG1XfVp9EoyYNRicoCHN17KYtTVw0cJUIz0/u
         Nt+YEZ2KLU72rzWFSCUqfTAlRSumaoe2jT++MryEliA6LVsofxj6ELXYFD9NijhYKiAj
         7Ybw==
X-Gm-Message-State: AOJu0Yx9QViD/zGdxCfHZ9xqaJtWXLo6xQXl2DoZdgUXu0k9t7ZDWSRj
	TdeasXuZPlxU9EmXTm1UB/VxOcs36aLntYB6CpV3StZ1
X-Google-Smtp-Source: AGHT+IFm074vmmK11CLC7KmNjhLt/IZP8sWpnzNiSOT47entK1CPvoVUQiDn5RnXFgu1/h1kjnd1DA==
X-Received: by 2002:a17:907:7295:b0:9a9:f0e6:904e with SMTP id dt21-20020a170907729500b009a9f0e6904emr2228705ejc.16.1697736406350;
        Thu, 19 Oct 2023 10:26:46 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906039800b009bf7a4d591bsm3820787eja.45.2023.10.19.10.26.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 10:26:45 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9c603e2354fso228023766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:26:45 -0700 (PDT)
X-Received: by 2002:a17:907:7f86:b0:9bd:a029:1a10 with SMTP id
 qk6-20020a1709077f8600b009bda0291a10mr2213396ejc.32.1697736405493; Thu, 19
 Oct 2023 10:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZS6fIkTVtIs-UhFI@smile.fi.intel.com> <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com> <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3> <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3> <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
In-Reply-To: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Oct 2023 10:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
Message-ID: <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 10:05, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Hmm... Then what's the difference between clang and GCC on the very same source
> code? One of them has a bug in my opinion.

Compiler bugs do happen, but they are quite rare (happily).

It's almost certainly just ambiguous code that happens to work with
one code generation, and not another.

It might be as simple as just hitting a timing bug, but considering
how consistent it is for you (with a particular config), it's more
likely to be something like an optimization that just happens to
trigger some subtle ordering requirement or other.

So then the "different compiler" is really just largely equivalent to
"different optimization options", and sometimes that causes problems.

That said, the quota dependency is quite odd, since normally I
wouldn't expect the quota code to really even trigger much during
boot. When it triggers that consistently, and that early during boot,
I would expect others to have reported more of this.

Strange.

                Linus


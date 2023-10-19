Return-Path: <linux-fsdevel+bounces-787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414ED7D01FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 20:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC1EB2140B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68439853;
	Thu, 19 Oct 2023 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KZA0xFi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A139845
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 18:44:09 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB4124
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 11:44:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98377c5d53eso6406266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697741046; x=1698345846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C2XVpy+BS1K4w7gayf3/1HjO0gNsFZkxXqHhB++XT2g=;
        b=KZA0xFi8n22uIkwv4S5EA2cN2KsfIlrTz4BfkjjFrkyAiekcqqu4jfYYmCxRWfyF/2
         y7zbfhRjNH/yet3T94VYBJa7HHwGv//bzk1oIgd6LFn9fZCL55jhGs3rtm0ItWLrwxMr
         g9ELMpJD3KeMi3v6FMsfadcYERZUidjX/uytM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741046; x=1698345846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2XVpy+BS1K4w7gayf3/1HjO0gNsFZkxXqHhB++XT2g=;
        b=RvjAUYudGOavVeIhBA790Ro8dOa3lafyLC+zVkbC4p43BYs6+S2kfAryDz+ZpC8Eyj
         08Ud0XBmbPweq+Hqb0toEf0xY2ULDnSgYqiixBsRd3+ezU7/kl1N9Ix1Ti5YoZwfMJdP
         BE35IizOiegBbjnqP37uCw3d1QXV7PeSARjUt3JLPqLJK2CDxv2mWuMJPTmtqMdqeURb
         4Ji9zsNY498484XIwIbjckPzt6ZJ9VGaoCLIIzIH1jhjMQaW2Q0NZqECfEPNbM+QrVzJ
         u9orAat+AJp6stDzPIdyzRVfRqDCvCOiJx/tkl8yRNGQsU4tNfZdRu+R9PMmY/7/1/35
         k4hw==
X-Gm-Message-State: AOJu0YxGyTjFMix9UQ4lpL9jGVxK2G5OWwDELH2lSX3QtyH+F6Cd/Hcx
	KJnh+cNsGt02i/HqDvoUY6kWqzq13hyXzTQc1cVp30Y8
X-Google-Smtp-Source: AGHT+IHgdTsGkFcZASWnEnKjHlklaFfeo0ICjTIdaquBbNSTFlJ+e5nztpoKDFknaXwWA1yiy044ew==
X-Received: by 2002:a17:907:9306:b0:9ba:3af4:333e with SMTP id bu6-20020a170907930600b009ba3af4333emr2363189ejc.14.1697741045835;
        Thu, 19 Oct 2023 11:44:05 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id qh12-20020a170906ecac00b009b9af27d98csm23578ejb.132.2023.10.19.11.44.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:44:05 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9c75ceea588so2885366b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 11:44:05 -0700 (PDT)
X-Received: by 2002:a17:907:72c9:b0:9a5:9f3c:9615 with SMTP id
 du9-20020a17090772c900b009a59f3c9615mr2626024ejc.63.1697741044936; Thu, 19
 Oct 2023 11:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018184613.tphd3grenbxwgy2v@quack3> <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3> <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
In-Reply-To: <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Oct 2023 11:43:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
Message-ID: <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 11:16, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> Meanwhile a wild idea, can it be some git (automatic) conflict resolution that
> makes that merge affect another (not related to the main contents of the merge)
> files? Like upstream has one base, the merge has another which is older/newer
> in the history?

I already looked at any obvious case of that.

The only quota-related issue on the other side is an obvious
one-liner: commit 86be6b8bd834 ("quota: Check presence of quota
operation structures instead of ->quota_read and ->quota_write
callbacks").

It didn't affect the merge, because it was not related to  any of the
changes that came in from the quota branch (it was physically close to
the change that used lockdep_assert_held_write() instead of a
WARN_ON_ONCE(down_read_trylock()) sequence, but it is unrelated to
it).

I guess you could try reverting that one-liner after the merge, but I
_really_ don't think it is at all relevant.

What *would* probably be interesting is to start at the pre-merge
state, and rebase the code that got merged in. And then bisect *that*
series.

IOW, with the merge that triggers your bisection being commit
1500e7e0726e, do perhaps something like this:

  # Name the states before the merge
  git branch pre-merge 1500e7e0726e^
  git branch jan-state 1500e7e0726e^2

  # Now double-check that this works for you, of course.
  # Just to be safe...
  git checkout pre-merge
  .. test-build and test-boot this with the bad config ..

  # Then, let's create a new branch that is
  # the rebased version of Jan's state:
  git checkout -b jan-rebased jan-state
  git rebase pre-merge

  # Verify that the tree is the same as the merge
  git diff 1500e7e0726e

  # Ok, that was empty, so do a bisect on this
  # rebased history
  git bisect start
  git bisect bad
  git bisect good pre-merge

.. and see what commit it *now* claims is the bad commit.

Would you be willing to do this? It should be only a few bisects,
since Jan's branch only brought in 17 commits that the above rebases
into this test branch. So four or five bisections should pinpoint the
exact point where it goes bad.

Of course, since this is apparently about some "random code generation
issue", that exact point still may not be very interesting.

                Linus


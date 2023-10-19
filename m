Return-Path: <linux-fsdevel+bounces-783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205807D00F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515221C20ED5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01436B17;
	Thu, 19 Oct 2023 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QsZMDPwa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652832C6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 17:51:40 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CB2119
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:51:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1c66876aso1343821366b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697737897; x=1698342697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxyRz0yQqVJRY3zmZ6nwicjRS4ksR0Rz7BgzZVO3P6w=;
        b=QsZMDPwaK9757OCMA6CxKXTGBXJ0OpZ++/Eawo173gLhGaLZKF2GFLvh2OZfkzX/nd
         RkgNjIEo5BTaFVETMjVcvZZhOjbmTiGshre5AC/cyvGrtm5Dtuo0nK/5NoJPVfGVLI6D
         Qo/fC085fMKpBO4zSVWVcXYOvvHLMnVK88coA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737897; x=1698342697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxyRz0yQqVJRY3zmZ6nwicjRS4ksR0Rz7BgzZVO3P6w=;
        b=YDcCaPtzWuUqVu9cVYdhhhcGpAu5aJpSvd1KTU1D2DBjwNMKh7GgB7aX8kW5MR0d7v
         KX4EEAA1Wb3w/HYEYSyrAA2BJ15N84ibd6APiuOrK7fAhQnllskSEL6g3gnukYn+Mz7r
         ICu/LxrzFkzcrTddWlmvly20ibYw3YZBuei8wb+7w6bWHB1yTj87FoPB9DQed+ncnBwB
         pomx0zN2NhzFzrQ7F9zrn60G7hBskxgKqtNdWtA3AADQ6AzYPYTzvPm5MyiWWO7+B8QD
         Q/U9keW+UzERM+O1mbOTDjvW4EmBDzuvD15IJxur7lvpVAi9rRYpe49TphWxO7QtvhYS
         xJ8Q==
X-Gm-Message-State: AOJu0YzKCUFadaCVoqgV/oFcR8ay8QwPi2eRH1kwxeQWEe5rmmXXjIpL
	digy+yqVUgelxvFZ/pb5ZXLGcl5YLF93jmdyFojBVSqJ
X-Google-Smtp-Source: AGHT+IFMv2/+t9aYR9zHOhjq59CUrGdQBqp1ciIuzR7Sq9wd95t1+t1xvdDRBmYGNT48PsmQZu6sDQ==
X-Received: by 2002:a17:906:eec5:b0:9b2:8df4:c692 with SMTP id wu5-20020a170906eec500b009b28df4c692mr2453830ejb.27.1697737897378;
        Thu, 19 Oct 2023 10:51:37 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906145400b009c387ff67bdsm3966407ejc.22.2023.10.19.10.51.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 10:51:36 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9ad8a822508so1351011866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 10:51:36 -0700 (PDT)
X-Received: by 2002:a17:907:31c5:b0:9be:ef46:6b9c with SMTP id
 xf5-20020a17090731c500b009beef466b9cmr2784575ejb.70.1697737896286; Thu, 19
 Oct 2023 10:51:36 -0700 (PDT)
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
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
In-Reply-To: <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Oct 2023 10:51:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
Message-ID: <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 10:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, the quota dependency is quite odd, since normally I
> wouldn't expect the quota code to really even trigger much during
> boot. When it triggers that consistently, and that early during boot,
> I would expect others to have reported more of this.
>
> Strange.

Hmm. I do think the quota list handling has some odd things going on.
And it did change with the whole ->dq_free thing.

Some of it is just bad:

  #ifdef CONFIG_QUOTA_DEBUG
          /* sanity check */
          BUG_ON(!list_empty(&dquot->dq_free));
  #endif

is done under a spinlock, and if it ever triggers, the machine is
dead. Dammit, I *hate* how people use BUG_ON() for assertions. It's a
disgrace. That should be a WARN_ON_ONCE().

And it does have quite a bit of list-related changes, with the whole
series from Baokun Li changing how the ->dq_free list works.

The fact that it consistently bisects to the merge is still odd.

                 Linus


Return-Path: <linux-fsdevel+bounces-937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2287D3BC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C946B20E70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64D1CF9C;
	Mon, 23 Oct 2023 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aIf9HNPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CD1CF86
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 16:08:12 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979E3FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 09:08:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso3300561b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698077291; x=1698682091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAbl8i1ES+tk6GtRRVwZ8wcHY6NkPkAZ2h814rYoW9A=;
        b=aIf9HNPRgec5twUekA6iJ4ObM6vDiC2RLnbzcdy5Nm0Uphu1sSQtakaNFuo6znz2Dd
         DeGdmzsPzLhRJV9NV5LyfKHSTqahnL2qdzJCITFiiKElj1Cq+SjnzKIfbRtWzw9uxX3N
         6SPsYt/Gd6iuAISja3oZ5q/5WR5RXq80rTU+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077291; x=1698682091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAbl8i1ES+tk6GtRRVwZ8wcHY6NkPkAZ2h814rYoW9A=;
        b=ppzSW3n0HAxujzdGjH2NUlGKqkBF9Crq8qX4zAzFxW67+NKwa2oW1Gz+AYWq25fCFA
         9Rb7r0B5hJe5TTahtFNwSBzXB7oZVR4ziACE58rHF3/T8JQDHEGWUF2/Fp3f0oKIFAsd
         h9WuQzrmc0iDdoUiQwT05A52lBKNuaq93r/EtZC4ueqSSl+79/klZQtxgCaRZ9lcv4/O
         QAY/ggrfgmNew7CdHNSHHMpQdaz6yfjrPrear1EyoqMKfhdqAxlxUO8vDweRW8TAA6ZV
         cG56pGNkAHNCmKBpHf55WcmbmyXPG++4dHQcabX5YiRYVXZOr9eqfm7Xf6PXH2K5Z7ZZ
         cMTw==
X-Gm-Message-State: AOJu0YxMVaQxnRMq0L6Rkur3Yu4/kUQyrNRiHO9TWjTsABFnxwS3VBzi
	voNpDdFHZpuT8d+t3Pe1StWk1A==
X-Google-Smtp-Source: AGHT+IHA0SajMcDhInlLmsNPImlbrLWcp8cWuplN3JvairlTJUnXetTt6OkASli1hf2X2pbcuEUbRQ==
X-Received: by 2002:a05:6a00:10c4:b0:68a:3ba3:e249 with SMTP id d4-20020a056a0010c400b0068a3ba3e249mr12049257pfu.16.1698077291028;
        Mon, 23 Oct 2023 09:08:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h12-20020aa79f4c000000b00696895ed44dsm6209131pfr.164.2023.10.23.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:08:10 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:08:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Jan Kara <jack@suse.cz>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Kees Cook <kees@kernel.org>, Baokun Li <libaokun1@huawei.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Ferry Toth <ftoth@exalondelft.nl>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <202310230907.C39FED1BC@keescook>
References: <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
 <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
 <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
 <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
 <BF6761C0-B813-4C98-9563-8323C208F67D@kernel.org>
 <ZTZcwU+nCB0RUI+y@smile.fi.intel.com>
 <20231023121501.ae3ig3hzxqycglyt@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023121501.ae3ig3hzxqycglyt@quack3>

On Mon, Oct 23, 2023 at 02:15:01PM +0200, Jan Kara wrote:
> On Mon 23-10-23 14:45:05, Andy Shevchenko wrote:
> > On Sat, Oct 21, 2023 at 04:36:19PM -0700, Kees Cook wrote:
> > > On October 20, 2023 1:36:36 PM PDT, andy.shevchenko@gmail.com wrote:
> > > >That said, if you or anyone has ideas how to debug futher, I'm all ears!
> > > 
> > > I don't think this has been tried yet:
> > > 
> > > When I've had these kind of hard-to-find glitches I've used manual
> > > built-binary bisection. Assuming you have a source tree that works when built
> > > with Clang and not with GCC:
> > > - build the tree with Clang with, say, O=build-clang
> > > - build the tree with GCC, O=build-gcc
> > > - make a new tree for testing: cp -a build-clang build-test
> > > - pick a suspect .o file (or files) to copy from build-gcc into build-test
> > > - perform a relink: "make O=build-test" should DTRT since the copied-in .o
> > > files should be newer than the .a and other targets
> > > - test for failure, repeat
> > > 
> > > Once you've isolated it to (hopefully) a single .o file, then comes the
> > > byte-by-byte analysis or something similar...
> > > 
> > > I hope that helps! These kinds of bugs are super frustrating.
> > 
> > I'm sorry, but I can't see how this is not an error prone approach.
> > If it's a timing issue then the arbitrary object change may help and it doesn't
> > prove anything. As earlier I tried to comment out the error message, and it
> > worked with GCC as well. The difference is so little (according to Linus) that
> > it may not be suspectible. Maybe I am missing the point...
> 
> Given how reliably you can hit the problem with some kernels while you
> cannot hit them with others (only slightly different in a code that doesn't
> even get executed on your system) I suspect this is really more a code
> placement issue than a timing issue. Like if during the linking phase of
> vmlinux some code ends up at some position, the kernel fails, otherwise it
> boots fine. Not sure how to debug such thing though. Maybe some playing
> with the linker and the order of object files linked could reveal something
> but I'm just guessing.

Right -- in theory there will be some minimum subset of "from GCC"
objects that when used together in the otherwise "known good" build will
trip the failure.

-- 
Kees Cook


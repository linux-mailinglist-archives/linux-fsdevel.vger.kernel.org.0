Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF14273D7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 00:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhJHWqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHWqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 18:46:17 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D456C061755
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 15:44:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m21so4414044pgu.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=umB4uHDtxas96hN3BYGazDncxiBbCFqWtzPGIWT7LNc=;
        b=c1dhZkFOhudh2wXNpMdEc1RhSuvtxZ61MbgjOfWirI1dGCwop+oMrikrazWSKtARVC
         En1rtRySSqXcNiYt5ShEmep6JLQBztsQI2fOfwoUK2FMSMB0/TCaYAhtCuHAYoxM3HyE
         tmEzHJmoyWeedVttNjcYA9jyYFHoIa3v03c68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=umB4uHDtxas96hN3BYGazDncxiBbCFqWtzPGIWT7LNc=;
        b=2Gw4XtW/BmBlCBdLiUDiTHFPtHIfQZg4j7aWHegdxQg4e0ZchZ7OR0Uv+N7Ly3PJPj
         J25D7yHqVv4Yw6JUbQM2q7L5b7otNujGayBRA8F5Ua1QRJQ0Qgw0A0Z7FHcQcMd8lmcj
         dFNEkHVNeCtm9wAEvpXFFpvKMdc8lHNXj2zKPoORfzjxj0GSH33R001NNCpRPFUw58hd
         bVnddkSrM+qmsCoUpDkfYnf0oZsqidQ55kr8xxEvctqs4vOv5ZmRohvLfdD82MAHDqBf
         jFC3ZpxC6zuJeHMwTgs+/sVHJdRrhO1eiw+EpKKyAvXxdZI6mK7g8EetLEZzSBmPeOZ4
         Z71g==
X-Gm-Message-State: AOAM533KspPi50KgsDG+kaCMs5UgSYMHEhtAtZEprkPaS37RG2oc62gK
        j4bM3+Fpfyedb3wuWDe895awgA==
X-Google-Smtp-Source: ABdhPJzCE+sLyU3dUaPPb1F+N9g3sYRtHexnhsIzGXBB0pFPvAIgLQ1uow9VWdB0524+rTctfRRdQA==
X-Received: by 2002:a62:ed0a:0:b0:44b:3f50:c4d4 with SMTP id u10-20020a62ed0a000000b0044b3f50c4d4mr12467574pfh.33.1633733061403;
        Fri, 08 Oct 2021 15:44:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm304469pfq.130.2021.10.08.15.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:44:21 -0700 (PDT)
Date:   Fri, 8 Oct 2021 15:44:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v13 3/3] selftest/interpreter: Add tests for
 trusted_for(2) policies
Message-ID: <202110081543.1B6BF22@keescook>
References: <20211007182321.872075-1-mic@digikod.net>
 <20211007182321.872075-4-mic@digikod.net>
 <202110071227.669B5A91C@keescook>
 <b1599775-a061-6c91-03a4-c82734c7f58c@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1599775-a061-6c91-03a4-c82734c7f58c@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:21:12PM +0200, Mickaël Salaün wrote:
> 
> On 07/10/2021 21:48, Kees Cook wrote:
> > On Thu, Oct 07, 2021 at 08:23:20PM +0200, Mickaël Salaün wrote:
> 
> [...]
> 
> >> diff --git a/tools/testing/selftests/interpreter/Makefile b/tools/testing/selftests/interpreter/Makefile
> >> new file mode 100644
> >> index 000000000000..1f71a161d40b
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/interpreter/Makefile
> >> @@ -0,0 +1,21 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +CFLAGS += -Wall -O2
> >> +LDLIBS += -lcap
> >> +
> >> +src_test := $(wildcard *_test.c)
> >> +TEST_GEN_PROGS := $(src_test:.c=)
> >> +
> >> +KSFT_KHDR_INSTALL := 1
> >> +include ../lib.mk
> >> +
> >> +khdr_dir = $(top_srcdir)/usr/include
> >> +
> >> +$(khdr_dir)/asm-generic/unistd.h: khdr
> >> +	@:
> >> +
> >> +$(khdr_dir)/linux/trusted-for.h: khdr
> >> +	@:
> >> +
> >> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/asm-generic/unistd.h $(khdr_dir)/linux/trusted-for.h ../kselftest_harness.h
> >> +	$(LINK.c) $< $(LDLIBS) -o $@ -I$(khdr_dir)
> > 
> > Is all this really needed?
> 
> Yes, all this is needed to be sure that the tests will be rebuild when a
> dependency change (either one of the header files or a source file).
> 
> > 
> > - CFLAGS and LDLIBS will be used by the default rules
> 
> Yes, but it will only run the build command when a source file change,
> not a header file.
> 
> > - khdr is already a pre-dependency when KSFT_KHDR_INSTALL is set
> 
> Yes, but it is not enough to rebuild the tests (and check the installed
> files) when a header file change.
> 
> > - kselftest_harness.h is already a build-dep (see LOCAL_HDRS)
> 
> Yes, but without an explicit requirement, changing kselftest_harness.h
> doesn't force a rebuild.
> 
> > - TEST_GEN_PROGS's .c files are already build-deps
> 
> It is not enough to trigger test rebuilds.
> 
> > 
> > kselftest does, oddly, lack a common -I when KSFT_KHDR_INSTALL is set
> > (which likely should get fixed, though separately from here).
> > 
> > I think you just want:
> > 
> > 
> > src_test := $(wildcard *_test.c)
> > TEST_GEN_PROGS := $(src_test:.c=)
> > 
> > KSFT_KHDR_INSTALL := 1
> > include ../lib.mk
> > 
> > CFLAGS += -Wall -O2 -I$(BUILD)/usr/include
> > LDLIBS += -lcap
> > 
> > $(OUTPUT)/%_test: $(BUILD)/usr/include/linux/trusted-for.h
> > 
> > 
> > (untested)
> > 
> Yep, I re-checked and my Makefile is correct. I didn't find a way to
> make it lighter while correctly handling dependencies.
> I'll just move the -I to CFLAGS.

Okay, thanks for double-checking these. I'll try to fix up kselftests to
DTRT here.

-- 
Kees Cook

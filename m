Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0E7AF884
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 05:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjI0DQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 23:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjI0DOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:14:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D74ED2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 19:34:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso8023137b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 19:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695782092; x=1696386892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MEoyNhEirsDID+iSINOkm/zSxakfDUSa2NzmIBoMrtU=;
        b=GMGLItkY20tnShqsQSE1ZhhboeJoA4hi90EFgQw+P5N6+y00MJxEgvvxs8L44DXShX
         336Qt0yAie1pjEVaU79cnyRBt7skxYSzpxnG/nisuELTEKMCPBJWk5pdOsfs+4/AB0xq
         5zSFPiqdDv2RHeTYJvUYWap4ai0J42PbGvQno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695782092; x=1696386892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEoyNhEirsDID+iSINOkm/zSxakfDUSa2NzmIBoMrtU=;
        b=Zn3/1/QStsGjKJi68wkbD8LL+YJJzbvV3aIwC88fiQdqnkaCaxyZbxqci5hzYOQug9
         zh4aGRRKDWi/eFpgENxeLVuYltqiCDxvTKPT7yoJBn1h5JzFRMUzY3VSUsgQLQqnYYdQ
         +sjY6GuCS8KLKcf/UjGbW8RepNDdW+xxrTLeKq6NNsYoIvCju8FWENt8hGA8eG90Yr3A
         sK23yQdJVGBryfOrJ+ReDnGmNAVGILSXqVF0WuITf0qkpnkOwENyhba2g7da6we/gqFf
         FvEUHYpOsC3ja/1GsKgLgJj2C7ifWqhqwyY2KXfYKzzGNqB0p6azWgEltnWdUv8rNn2a
         lpRA==
X-Gm-Message-State: AOJu0YwM+CosASZ5xCzcoOO/L6nFEyFSFBgKcuc+Wgr77YkIMF+O4CUL
        0EWBQUvFz9Za1VP5w2n22ajXGg==
X-Google-Smtp-Source: AGHT+IH3mtSkhCwY4l5NpnakMGAz2fqDSfIVRDAs1r22pVm2l9sPYt/EIE/sGjn2HyWVPFLAH2dqvA==
X-Received: by 2002:a05:6a00:139d:b0:692:780a:de89 with SMTP id t29-20020a056a00139d00b00692780ade89mr882056pfg.33.1695782092187;
        Tue, 26 Sep 2023 19:34:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z26-20020aa785da000000b006883561b421sm10697260pfn.162.2023.09.26.19.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 19:34:51 -0700 (PDT)
Date:   Tue, 26 Sep 2023 19:34:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sebastian Ott <sebott@redhat.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        sam@gentoo.org, Rich Felker <dalias@libc.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
Message-ID: <202309261929.BE87B8B7@keescook>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
 <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com>
 <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
 <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com>
 <87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>
 <84e974d3-ae0d-9eb5-49b2-3348b7dcd336@redhat.com>
 <202309251001.C050864@keescook>
 <87v8bxiph5.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v8bxiph5.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:27:02PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, Sep 25, 2023 at 05:27:12PM +0200, Sebastian Ott wrote:
> >> On Mon, 25 Sep 2023, Eric W. Biederman wrote:
> >> > 
> >> > Implement a helper elf_load that wraps elf_map and performs all
> >> > of the necessary work to ensure that when "memsz > filesz"
> >> > the bytes described by "memsz > filesz" are zeroed.
> >> > 
> >> > Link: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
> >> > Reported-by: Sebastian Ott <sebott@redhat.com>
> >> > Reported-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> >> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> > ---
> >> > fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
> >> > 1 file changed, 48 insertions(+), 63 deletions(-)
> >> > 
> >> > Can you please test this one?
> >
> > Eric thanks for doing this refactoring! This does look similar to the
> > earlier attempt:
> > https://lore.kernel.org/lkml/20221106021657.1145519-1-pedro.falcato@gmail.com/
> > and it's a bit easier to review.
> 
> I need to context switch away for a while so Kees if you will
> I will let you handle the rest of this one.
> 
> 
> A couple of thoughts running through my head for anyone whose ambitious
> might include cleaning up binfmt_elf.c
> 
> The elf_bss variable in load_elf_binary can be removed.
> 
> Work for a follow on patch is using my new elf_load in load_elf_interp
> and possibly in load_elf_library.  (More code size reduction).
> 
> An outstanding issue is if the first segment has filesz 0, and has a
> randomized locations.  But that is the same as today.
> 
> There is a whole question does it make sense for the elf loader
> to have it's own helper vm_brk_flags in mm/mmap.c or would it
> make more sense for binfmt_elf to do what binfmt_elf_fdpic does and
> have everything to go through vm_mmap.
> 
> I think replacing vm_brk_flags with vm_mmap would allow fixing the
> theoretical issue of filesz 0 and randomizing locations.
> 
> 
> 
> In this change I replaced an open coded padzero that did not clear
> all of the way to the end of the page, with padzero that does.

Yeah, the resulting code is way more readable now.

> I also stopped checking the return of padzero as there is at least
> one known case where testing for failure is the wrong thing to do.
> It looks like binfmt_elf_fdpic may have the proper set of tests
> for when error handling can be safely completed.
> 
> I found a couple of commits in the old history
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
> that look very interesting in understanding this code.
> 
> commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
> commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c")
> commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")
> 
> Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail"):
> >  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
> >  Author: Pavel Machek <pavel@ucw.cz>
> >  Date:   Wed Feb 9 22:40:30 2005 -0800
> > 
> >     [PATCH] binfmt_elf: clearing bss may fail
> >     
> >     So we discover that Borland's Kylix application builder emits weird elf
> >     files which describe a non-writeable bss segment.
> >     
> >     So remove the clear_user() check at the place where we zero out the bss.  I
> >     don't _think_ there are any security implications here (plus we've never
> >     checked that clear_user() return value, so whoops if it is a problem).
> >     
> >     Signed-off-by: Pavel Machek <pavel@suse.cz>
> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> It seems pretty clear that binfmt_elf_fdpic with skipping clear_user
> for non-writable segments and otherwise calling clear_user (aka padzero)
> and checking it's return code is the right thing to do.
> 
> I just skipped the error checking as that avoids breaking things.
> 
> It looks like Borland's Kylix died in 2005 so it might be safe to
> just consider read-only segments with memsz > filesz an error.

I really feel like having a read-only BSS is a pathological state that
should be detected early?

> Looking at commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2") the
> binfmt_elf.c bits confirm my guess that the weird structure is because
> before that point binfmt_elf.c assumed there would be only a single
> segment with memsz > filesz.  Which is why the code was structured so
> weirdly.

Agreed.

> Looking a little farther it looks like the binfmt_elf.c was introduced
> in Linux v1.0, with essentially the same structure in load_elf_binary as
> it has now.  Prior to that Linux hard coded support for a.out binaries
> in execve.  So if someone wants to add a Fixes tag it should be
> "Fixes: v1.0"
> 
> Which finally explains to me why the code is so odd.  For the most part
> the code has only received maintenance for the last 30 years or so.
> Strictly 29 years, but 30 has a better ring to it.
> 
> Anyway those are my rambling thoughts that might help someone.
> For now I will be happy if we can get my elf_load helper tested
> to everyone's satisfaction and merged.

I'm probably going to pull most of this email into the commit log for
the v2 patch -- there's good history here worth capturing.

-- 
Kees Cook

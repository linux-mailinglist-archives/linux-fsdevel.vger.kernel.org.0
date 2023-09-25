Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40167ADD93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 19:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjIYRGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjIYRGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:06:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BDD111
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 10:06:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c465d59719so46061195ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695661563; x=1696266363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d5xMja9yFkheQHqE/iXRfDYgX6Arhzs6tk3qD/XhCzk=;
        b=lmbPPhmzMhFZBmbhpZJM7/G3wWI2zHz4tWe06inVvBywhiINdVthCsbUCMVLMEM0y9
         KTwwfucFgIlW+09Mfrv8iqdCPrD5Ksk+M+OF3Mi/PcTEeIdn06v8RoEAQchPHslLD/Xx
         VURoXtTCmhjGe07NtZRrmeYLbM9ZRunrqG7zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695661563; x=1696266363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5xMja9yFkheQHqE/iXRfDYgX6Arhzs6tk3qD/XhCzk=;
        b=aHH82uCirNatJ3n0iePS8O982tf7ItsTmsX0m1lLv3L6Hkc4A3P/gs9LvZqJ6rKP09
         WuHJOpSrWXMhxCbY0mrBhL2t2rV9vhYT5cH/+qP0sdajqrSk9tR5IpvMop0Boovdufi+
         vlR0YvjGAThkrHwWipqKOgfUoEYEA7q17ebwmE5A1H3BE9bpMa+ESnIrFWNGijgnipK1
         QPjFwP+HWQSQbBXRJUI538r4OjIrMDBnqiW69dHqXjfGMFStvQg+847glsWnu64ehvlD
         CsGxPPI9/K+y5R7rlPAqGPId8ZO/EKBP67QIYoJSPR8fWRkdNVdYerIJtdV8izedmcei
         QAtA==
X-Gm-Message-State: AOJu0Yyld75FaM8wQK0am0/UJXQC7GkQWwzM2z02Z/8E5BrEEoF52uVR
        /6+q4JdJ1LmR0PahEJNSjN/SvA==
X-Google-Smtp-Source: AGHT+IHpX/s355Isj57+S+omPh8sCxTjLdauW2heADkSvyIbh1n4SyJZJ9E+Cl2v/svT8YApVibwpg==
X-Received: by 2002:a17:902:934a:b0:1bc:10cf:50d8 with SMTP id g10-20020a170902934a00b001bc10cf50d8mr4663367plp.23.1695661562783;
        Mon, 25 Sep 2023 10:06:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b001c5fc11c085sm5222785plg.264.2023.09.25.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:06:02 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:06:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sebastian Ott <sebott@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        sam@gentoo.org, Rich Felker <dalias@libc.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
Message-ID: <202309251001.C050864@keescook>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
 <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com>
 <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
 <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com>
 <87jzsemmsd.fsf_-_@email.froward.int.ebiederm.org>
 <84e974d3-ae0d-9eb5-49b2-3348b7dcd336@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84e974d3-ae0d-9eb5-49b2-3348b7dcd336@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:27:12PM +0200, Sebastian Ott wrote:
> On Mon, 25 Sep 2023, Eric W. Biederman wrote:
> > 
> > Implement a helper elf_load that wraps elf_map and performs all
> > of the necessary work to ensure that when "memsz > filesz"
> > the bytes described by "memsz > filesz" are zeroed.
> > 
> > Link: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
> > Reported-by: Sebastian Ott <sebott@redhat.com>
> > Reported-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > ---
> > fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
> > 1 file changed, 48 insertions(+), 63 deletions(-)
> > 
> > Can you please test this one?

Eric thanks for doing this refactoring! This does look similar to the
earlier attempt:
https://lore.kernel.org/lkml/20221106021657.1145519-1-pedro.falcato@gmail.com/
and it's a bit easier to review.

> That one did the trick! The arm box booted successful, ran the binaries
> that were used for the repo of this issue, and ran the nolibc compiled
> binaries from kselftests that initially triggered the loader issues.

Thanks for testing! I need to dig out the other "weird" binaries (like
the mentioned ppc32 case) and see if I can get those tested too.

Pedro, are you able to test ppc64le musl libc with this patch too?

-Kees

-- 
Kees Cook

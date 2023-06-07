Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF3C727325
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 01:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjFGXi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 19:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjFGXiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:38:21 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A70270B
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 16:37:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-65292f79456so3762494b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181076; x=1688773076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q85ALpObps5sc/UCVblmdlmcE0aIZmHRuMxmvi7ZvV4=;
        b=lV8syWtj43Ff/kNItqdKE8y9KFBRtz3T741CER394a4RMHngbFtuX1OVIX0rOLruXT
         XkH5dqkCV3iSkoPeFmEZh8PwJCU/4Cdt3mBMneFJ3QGZyUUe1hEbZi9eVOiiXIZz4LRQ
         ymAYcwB9baokNEZhdcnTBgqOSyGwxz97Y5k6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181076; x=1688773076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q85ALpObps5sc/UCVblmdlmcE0aIZmHRuMxmvi7ZvV4=;
        b=Z0nuMK1t2WuLc8kp1JJrzKvN65JtgOmIKr7YRadDdol3GS0HiQwO7HQUhGVzA990sN
         xKLn7AwcgaQTOBcg7pYraiVubRagN/rHTH0d4wEiSfg4z9wc6DCdPvQ1GtG34DqBKf/i
         2+LSqYpfywMUC3EJY7amK/XLGYP0kmYWOBsGCAqhMk/BVrOcmAnCjajONezQrNCZY0yC
         kVXlHhqb6dg2QSDWg+HjPNfQM8rcUKgX7lkl/W2Nsr0/GAkpnCMvCgYG1HiaOyegviZK
         sqr+fUcB7W4f/L/LeIscvfZrMIReHkafFEjraJyuYPdQClooyaMaU8ALnsimXmZPxJ48
         2ctg==
X-Gm-Message-State: AC+VfDzhmTYpgoselS0GTTcE3kTzkAewzYZ10KL1FOxBKICxI4ENXHLi
        KfcJN56r1pRBwl3aqE0479oAuQ==
X-Google-Smtp-Source: ACHHUZ6ZXC7p4DKrsltkZH4GRsEhK/UFVuZ7UJv1bOQaR6JO3aYQPtnsPqCAKXnWT3JJJ9X0TBo+zA==
X-Received: by 2002:a05:6a20:394a:b0:117:51fe:9b4c with SMTP id r10-20020a056a20394a00b0011751fe9b4cmr2792096pzg.7.1686181076046;
        Wed, 07 Jun 2023 16:37:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p19-20020aa78613000000b006414b2c9efasm8859392pfn.123.2023.06.07.16.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:37:55 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:37:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: dynamically allocate note.data in
 parse_elf_properties
Message-ID: <202306071636.1C35171CC@keescook>
References: <20230607144227.8956-1-ansuelsmth@gmail.com>
 <202306071417.79F70AC@keescook>
 <6480f938.1c0a0220.17a3a.0e1e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6480f938.1c0a0220.17a3a.0e1e@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:31:58PM +0200, Christian Marangi wrote:
> On Wed, Jun 07, 2023 at 02:19:51PM -0700, Kees Cook wrote:
> > On Wed, Jun 07, 2023 at 04:42:27PM +0200, Christian Marangi wrote:
> > > Dynamically allocate note.data in parse_elf_properties to fix
> > > compilation warning on some arch.
> > 
> > I'd rather avoid dynamic allocation as much as possible in the exec
> > path, but we can balance it against how much it may happen.
> >
> 
> I guess there isn't a good way to handle this other than static global
> variables and kmalloc. But check the arch question for additional info
> on the case.
> 
> > > On some arch note.data exceed the stack limit for a single function and
> > > this cause the following compilation warning:
> > > fs/binfmt_elf.c: In function 'parse_elf_properties.isra':
> > > fs/binfmt_elf.c:821:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> > >   821 | }
> > >       | ^
> > > cc1: all warnings being treated as errors
> > 
> > Which architectures see this warning?
> > 
> 
> This is funny. On OpenWRT we are enforcing WERROR and we had FRAME_WARN
> hardcoded to 1024. (the option is set to 2048 on 64bit arch)

Ah-ha. Okay, I was wondering how you got that. :)

> ARCH_USE_GNU_PROPERTY is set only on arm64 that have a FRAME_WARN set to
> 2048.
> 
> So this was triggered by building arm64 with FRAME_WARN set to 1024.
> 
> Now with the configuration of 2048 the stack warn is not triggered, but
> I wonder if it may happen to have a 32bit system with
> ARCH_USE_GNU_PROPERTY. That would effectively trigger the warning.
> 
> So this is effectively a patch that fix a currently not possible
> configuration, since:
> 
> !IS_ENABLED(CONFIG_ARCH_USE_GNU_PROPERTY) will result in node.data
> effectively never allocated by the compiler are the function will return
> 0 on everything that doesn't have CONFIG_ARCH_USE_GNU_PROPERTY.
> 
> > > Fix this by dynamically allocating the array.
> > > Update the sizeof of the union to the biggest element allocated.
> > 
> > How common are these notes? I assume they're very common; I see them
> > even in /bin/true:
> > 
> > $ readelf -lW /bin/true | grep PROP
> >   GNU_PROPERTY   0x000338 0x0000000000000338 0x0000000000000338 0x000030 0x000030 R   0x8
> > 
> > -- 
> 
> Is there a way to check if this kmalloc actually cause perf regression?

I don't have a good benchmark besides just an exec loop. But since this
isn't reachable in a regular config, I'd rather keep things how there
already are.

-Kees

-- 
Kees Cook

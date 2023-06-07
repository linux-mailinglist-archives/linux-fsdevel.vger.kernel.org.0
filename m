Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD21727072
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjFGVUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 17:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjFGVTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:19:54 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9C219B6
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 14:19:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b038064d97so8451605ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686172793; x=1688764793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OwwAPTsX0YV3vUdxtjfpz4TiWLtJRU1D8tBxvGSgvM=;
        b=Dn0wciA0nzHX/RcBPG9bXLiBsfDH0C8i9UN4h19QGoCN+lXz6j0TtaghmiYxiYlatz
         dUC48YyfCOPEd3NaExvAy2oGXwf0DLKnjOsfdvOMBv9O3c7mgsdTf0l/eZf2dhkvtXNs
         Tkx8GQi4UFiuncFvzm6eLIaGIDZtFMT/meXs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686172793; x=1688764793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OwwAPTsX0YV3vUdxtjfpz4TiWLtJRU1D8tBxvGSgvM=;
        b=NbGLwn9Cg9h6I54eftQfW3v1JCa5hANr84k+Nq07PjK128OwtV0LDk0LONRPGiEBfk
         MNvwKbsbWVbNFBGFOeOOzuNNAA1G9g2gXK9OnKYn8Imw9o4Kf08FOt+X1IWpG2iieo2K
         jq1g6HdvLGiXCQHfXxFtCvbPr8Hfkh7V/8WDrAdQyb+EWTwQLLVd0IyhxN7hiWT+ppKg
         wkqc/5/lSdGC8JbNJDb+MarjUl/SQFFG5R99pZv0e49S19onn+5leNbM1paVJULajt40
         7Rjnmq1Ir1ttcOMEBpjqXBGVt2y61NzQHmr6vRO8Kl+8HMj65QsNkEgy/VKkvmCTAd8B
         gxZA==
X-Gm-Message-State: AC+VfDyaAcezAOj4bqp3sv2RUV1jHqjBvOW9fsdt2r9LtG0XBErdG2sI
        zAFH4fyaiZbI+Z3e/gq9wGSV4aghkV6ytjBArcM=
X-Google-Smtp-Source: ACHHUZ5V9nGQDkdGfxISQMBDH8TRICjsCW5LhXfjuFShBXzhX7gSXaKHOiWW4nMsxpBocxsJSkfahg==
X-Received: by 2002:a17:903:2350:b0:1af:ac49:e048 with SMTP id c16-20020a170903235000b001afac49e048mr186444plh.25.1686172792827;
        Wed, 07 Jun 2023 14:19:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001a922d43779sm10846050plr.27.2023.06.07.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:19:52 -0700 (PDT)
Date:   Wed, 7 Jun 2023 14:19:51 -0700
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
Message-ID: <202306071417.79F70AC@keescook>
References: <20230607144227.8956-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607144227.8956-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 04:42:27PM +0200, Christian Marangi wrote:
> Dynamically allocate note.data in parse_elf_properties to fix
> compilation warning on some arch.

I'd rather avoid dynamic allocation as much as possible in the exec
path, but we can balance it against how much it may happen.

> On some arch note.data exceed the stack limit for a single function and
> this cause the following compilation warning:
> fs/binfmt_elf.c: In function 'parse_elf_properties.isra':
> fs/binfmt_elf.c:821:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>   821 | }
>       | ^
> cc1: all warnings being treated as errors

Which architectures see this warning?

> Fix this by dynamically allocating the array.
> Update the sizeof of the union to the biggest element allocated.

How common are these notes? I assume they're very common; I see them
even in /bin/true:

$ readelf -lW /bin/true | grep PROP
  GNU_PROPERTY   0x000338 0x0000000000000338 0x0000000000000338 0x000030 0x000030 R   0x8

-- 
Kees Cook

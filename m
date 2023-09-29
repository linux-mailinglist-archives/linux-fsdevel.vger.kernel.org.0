Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12137B3D14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 01:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjI2X5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 19:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjI2X5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:57:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF92139
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 16:57:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2627626a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696031868; x=1696636668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6arnneMpUAz4OILpzifu1P4tUCrP8Vk4FTrbxGUOVI=;
        b=cWkblA4hgsbrGfxjhWGgeDyWlrS/T0c6Yfn0uf8ITG2GVx9uryE2k4DMpUgVLEUfjb
         ZdF5iri8eDgK+OnNh1or4m6YZym769+B7Ro/IJ20hVJgTXodJZHMF59QYvtdKcLEQhL9
         BClbsYbvDZkAyISUmuOLtP5NLVnygiY5vDpT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696031868; x=1696636668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6arnneMpUAz4OILpzifu1P4tUCrP8Vk4FTrbxGUOVI=;
        b=WwlyofVB8ZNhB19kB8iNtcDr96rSjZWaqqzAOLXDOXonboROCOSWO0rvKQ7VBk8Yux
         7yrvSa2iYiOB6NrHcVK0htJ7L88Cn9dgVyyzyXEfswzL5izKvAVibV6kkZLDiT+UL6jU
         Ii2ff/HenNqZG9pzoqneSskGYpd88LzvUVVaoT39qa2VRPSST5OC2ijblkZcGK7yeNMD
         Fvf0uyuQmcMrJVZDeRozE739fJeHtfBv8JCcH9VNXKKkXVTnlTUMkZSEcmGZ0bEAWMza
         n9KitITTzrYWTuwN6LLM2uS7U+54lTSaqE/8UrQWNkGn+2mkA1dBOAui56q3IxYL7ned
         AJAQ==
X-Gm-Message-State: AOJu0YxoDvDf7x4m/gcqsjVG6vUJBGhycpG3m3jIpX7dpDqZfIs8u0Mk
        XieMSIZsBz5Z90rTQIeUCY7Z8NBD3WHBuiMu7UhsPDwgkmM=
X-Google-Smtp-Source: AGHT+IGvj5LcQtcFWZCF2Ef4k7Szb7A+95Kx9Of0X7y6jG6rm4fDmttZ8l/k+rEEyKfWhU6Vc6lN8Q==
X-Received: by 2002:a05:6402:26c2:b0:533:5d3d:7efe with SMTP id x2-20020a05640226c200b005335d3d7efemr5674070edd.6.1696031868103;
        Fri, 29 Sep 2023 16:57:48 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id s16-20020a05640217d000b0053420e55616sm7419239edy.75.2023.09.29.16.57.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 16:57:47 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso271544866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 16:57:47 -0700 (PDT)
X-Received: by 2002:a17:907:6092:b0:9a5:c38d:6b75 with SMTP id
 ht18-20020a170907609200b009a5c38d6b75mr5518234ejc.15.1696031866848; Fri, 29
 Sep 2023 16:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com>
 <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner> <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner> <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner> <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
 <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
In-Reply-To: <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Sep 2023 16:57:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
Message-ID: <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 29 Sept 2023 at 14:39, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> So to be clear, obtaining the initial count would require a dedicated
> accessor.

Please, no.

Sequence numbers here are fundamentally broken, since getting that
initial sequence number would involve either (a) making it something
outside of 'struct file' itself or (b) require the same re-validation
of the file pointer that the non-sequence number code needed in the
first place.

We already have the right model in the only place that really matters
(ie fd lookup). Using that same "validate file pointer after you got
the ref to it" for the two or three other cases that didn't do it (and
are simpler: the exec pointer in particular doesn't need the fdt
re-validation at all).

The fact that we had some fd lookup that didn't do the full thing that
a *real* fd lookup did is just bad. Let's fix it, not introduce a
sequence counter that only adds more complexity.

          Linus

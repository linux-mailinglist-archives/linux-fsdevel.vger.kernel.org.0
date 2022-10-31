Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B3613C3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJaRhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 13:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJaRhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:37:23 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268B410B6B
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:20 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id x13so8774418qvn.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVoym53aP4ff+z3FOoG5jl2g45mYf6RnCpQn2di8eJo=;
        b=T56lY+eFVQT6wo4ittAe0G4dhERg4tyWGyylnPI0H0GxAg+OlwxMOlCbWh5QFV4ubU
         PvA4puiCG3uFaIM9XbM8VMI1Ao/hPNCPIlMChrSiJH9o3YuFKN6q9oIE2b9adfkNYqNz
         BN3E4lesGWlRKxqyFYzhnZcv9MHu01QlYr6J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVoym53aP4ff+z3FOoG5jl2g45mYf6RnCpQn2di8eJo=;
        b=U5Vr6UFfklwWkcwwcG6Nl4a8hCsJCGMPx9GSMhXtVRDqAkeCnyGr1gHyQfQRy+3jNc
         4Wgd0shIZ3H5/QeE8fy33is33dV8bl/3GsH+g2NXnLB+s5E/hUHES046l/dtb+/vWxpP
         4DPngUg4F9UHJjO/jd6de9E/ICXcqv8j5BKGiwIM9Vi4rEWyPd1fdBhuy4CpAYYGukws
         47nzet3rRM6co+BFqoZmGRrfSY067WQWCPxcsRV5Y8T0z06WGGwXrnqc4Vm/Tgis/iOK
         wN2LaU8L4+p+ZIo80qGf7AowHK7HJa1o2ZiAsCvedg7YjHsoHcVH6N9qlliu5dQhnwN7
         0JOA==
X-Gm-Message-State: ACrzQf1sLTtuc2TGP6MAtO/DSVHY0h2uKbMZtqPuYn/GlWhPHwO0wDlR
        LgAto8kOvw8jtOsIwJVRCmm2vHASQ7s2aQ==
X-Google-Smtp-Source: AMsMyM5qj5pUtiFY+AcIcsQigiZ0RG+sdeEhWlL2Mfkelg/Qgfa7n/dX++csjQIhrF8mxswBymlkIA==
X-Received: by 2002:ad4:574c:0:b0:4bb:7477:f13d with SMTP id q12-20020ad4574c000000b004bb7477f13dmr11835312qvx.39.1667237838935;
        Mon, 31 Oct 2022 10:37:18 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id y15-20020ac8524f000000b003a50c9993e1sm3914987qtn.16.2022.10.31.10.37.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:37:18 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 185so14554887ybc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 10:37:18 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr2660948ybg.362.1667237837692; Mon, 31
 Oct 2022 10:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221031171307.2784981-1-jannh@google.com>
In-Reply-To: <20221031171307.2784981-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 10:37:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgwb5oysYi_sTgzQjDPdg+DGH=VmfQk0o1EBrWOk+JRw@mail.gmail.com>
Message-ID: <CAHk-=whgwb5oysYi_sTgzQjDPdg+DGH=VmfQk0o1EBrWOk+JRw@mail.gmail.com>
Subject: Re: [PATCH] fs: add memory barrier in __fget_light()
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:13 AM Jann Horn <jannh@google.com> wrote:
>
> If this is too expensive on platforms like arm64, I guess the more
> performant alternative would be to add another flags field that tracks
> whether the fs_struct was ever shared and check that instead of the
> reference count in __fget_light().

No, the problem is that you should never use the "smp_*mb()" horrors
for any new code.

All the "smp_*mb()" things really are broken. Please consider them
legacy garbage. It was how people though about SMP memory ordering in
the bad old days.

So get with the 21st century, and instead replace the "atomic_read()"
with a "smp_load_acquire()".

Much better on sane architectures.

                           Linus

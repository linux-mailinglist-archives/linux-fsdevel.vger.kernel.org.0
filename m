Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87E2668ACC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 05:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjAMEVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 23:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjAMEU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:20:28 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B46698E
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 20:15:41 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fa5so12863900qtb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 20:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wt3jnzhUF3EcxhYr3T4hnm8uRCL7X//ykE1nGacQiX8=;
        b=QW41cnynBWFCcbN2np1bR6tedxbtO3eX5SbrPn1/lU9d4aaXmlahkT2WbS3tM/if0A
         VzpLPqX9WvAnwx7NbuqRmOaO9xqYz/nx1EGX61d8Bj2VG4zI+F4YccXnLtgT3U3a9uMK
         ML5XR8tAKhK45vk0ghApza55rwDgnktIGJWc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt3jnzhUF3EcxhYr3T4hnm8uRCL7X//ykE1nGacQiX8=;
        b=5ZixmFJylU1j1MAkWvrfC5Y1MLC4PSQHdd0NRashB4iIVCF+DVUhfyMksqOK9wmBSv
         QFYEpvnTFQqvVfksEkHPKrarBpcZC1AylQ6uwl3+HZoSEY3qyex4m3RLbGnwI645yJ+P
         TDJTZ6Hm8seYidTFmC6Zd88HCaA/sLQW7QfCLc1UPD/bS5rtPNzvxjhrj9FvdYm4+suu
         bipLS4ShGx0QDmCEI6496SpDVJh/WFlHaTnwWfBngjzumD24ok2lgQ373h4aq9/YA3fc
         5ZdzFjFnQbyMCGHyF6tRGHPm2wXiGl6HYY7uP6auj7ee4r5OaRksfuC21eBYdWMJgIw3
         rKLg==
X-Gm-Message-State: AFqh2kp4dFR8xqVKoDlYGVRMr1js6ajT2QopcAuG8lSrnmnByeMNVI8A
        iE/hl+R9GPy5Wx3q0V0wTsi9iBMvlNcuNXdJygA=
X-Google-Smtp-Source: AMrXdXtT2Stt45aQFcuNc41QWUTYmd602q5V73MzeYo8qkEkV7Fmb2mNFA253X0NSNXKDRLntZj8gA==
X-Received: by 2002:ac8:534c:0:b0:3a9:9170:793c with SMTP id d12-20020ac8534c000000b003a99170793cmr112239352qto.5.1673583340758;
        Thu, 12 Jan 2023 20:15:40 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b006e99290e83fsm11950272qkb.107.2023.01.12.20.15.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 20:15:39 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id d13so1613391qkk.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 20:15:38 -0800 (PST)
X-Received: by 2002:a05:620a:674:b0:6ff:a7de:ce22 with SMTP id
 a20-20020a05620a067400b006ffa7dece22mr4281758qkh.72.1673583338361; Thu, 12
 Jan 2023 20:15:38 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo>
In-Reply-To: <CPQQLU1ISBIJ.2SHU1BOMNO7TY@bobo>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jan 2023 22:15:22 -0600
X-Gmail-Original-Message-ID: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
Message-ID: <CAHk-=wiRm+Z613bHt2d=N1yWJAiDiQVXkh0dN8z02yA_JS-rew@mail.gmail.com>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, tony.luck@intel.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Jan Glauber <jan.glauber@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, Jan 12, 2023 at 9:20 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Actually what we'd really want is an arch specific implementation of
> lockref.

The problem is mainly that then you need to generate the asm versions
of all those different CMPXCHG_LOOP()  variants.

They are all fairly simple, though, and it woudln't be hard to make
the current lib/lockref.c just be the generic fallback if you don't
have an arch-specific one.

And even if you do have the arch-specific LL/SC version, you'd still
want the generic fallback for the case where a spinlock isn't a single
word any more (which happens when the spinlock debugging options are
on).

            Linus

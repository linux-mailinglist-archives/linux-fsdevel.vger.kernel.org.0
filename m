Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E481611835
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 18:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJ1Qx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJ1QxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:53:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05E1989BE
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 09:53:22 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i9so1021807qki.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pS2bJeXXT06AFFeuqTEmblG396E9ENt2zIPLMqMrcVc=;
        b=WTUQKY9BYXSR5sxjZPQsTMF4y1c0ZYOJzqUdsGaqYe+p/B6Nt7IoyzxULeM/759P1o
         UZXutu2q/e0zcjNH1gOm8AXgE6AATzgXfntHGezYDEn8UhP90n7Qb0p7ll+ZutI+8KTz
         +Z3deCUTm+jK5myD3ZMteKw2KDAVusImHYaJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS2bJeXXT06AFFeuqTEmblG396E9ENt2zIPLMqMrcVc=;
        b=o9n7IQoReTWYLnPPqfUkv1TeVtj3aLfTgbVpNkZuTMQtDLIEn7JatkSO0XuJCvJA0C
         +UcCOwITcRuQhrZoenKgOPs6czkm+SNXzkCWlqVdg0VfizBbwfNb4f+Hp+v4iwT0ui2O
         DfcBcnz15R08vtkT3OpsuNGGlwkR5Ev7bZCfV2ubtHpkrE7+wxW6PvMRUFSZ7A94A2+c
         wKRucnbJkP/UjvrCMjFj5IdoyV0F/p8q5sQThF3TaxDXAogzFazGY5dKecAbqwlRUdr1
         QDSbSoA69ogXrxklWUYQP555VEbTZfU0mxPZyD1/k5Er8rTFxDW69xCAX9e2TPV4qpyd
         8ySg==
X-Gm-Message-State: ACrzQf1E/IMhUO39Pxm6MANRwtZsg85EQcmGtPgdVAibWsJysnWLtw3o
        ta9ClwqeIPfmo3Ie/t1OjWgoAe9pKvjo7Q==
X-Google-Smtp-Source: AMsMyM7G3MN+lHTwI3EDeNUf+vS3qATT321iyz70hkaVBkYL1wsxcTeVIKNwJCdqCS/M9z6Nc08GcQ==
X-Received: by 2002:a37:3d5:0:b0:6fa:da4:bb32 with SMTP id 204-20020a3703d5000000b006fa0da4bb32mr131181qkd.636.1666976001050;
        Fri, 28 Oct 2022 09:53:21 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id r12-20020ae9d60c000000b006f9f3c0c63csm3057784qkk.32.2022.10.28.09.53.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:53:19 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id o70so6769585yba.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 09:53:19 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr143622ybu.101.1666975999213; Fri, 28
 Oct 2022 09:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <Y1oPDy2mpOd91+Ii@sol.localdomain> <CAHk-=wjDQiJn6YUJ18Nb=L82qsgx3LBLtQu0xANeVoc6OAzFtQ@mail.gmail.com>
 <Y1tI1ek80kCrsi2R@sol.localdomain>
In-Reply-To: <Y1tI1ek80kCrsi2R@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 09:53:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgud4Bc_um+htgfagYpZAnOoCb3NUoW67hc9LhOKsMtJg@mail.gmail.com>
Message-ID: <CAHk-=wgud4Bc_um+htgfagYpZAnOoCb3NUoW67hc9LhOKsMtJg@mail.gmail.com>
Subject: Re: [GIT PULL] fscrypt fix for 6.1-rc3
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
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

On Thu, Oct 27, 2022 at 8:13 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Thanks Linus.  That makes sense in general, but in this case ->s_master_keys
> gets used in the middle of the function, in fscrypt_put_master_key_activeref().

Ouch. I tried to look for things like that, but it's clearly indirect
through 'mk' so I missed it.

All the callers except for put_crypt_info() do seem to have the 'sb'
pointer, and I _think_ sb is inode->i_sb in that case. And this seems
to *literally* be the only use of 'mk->mk_sb' in the whole data
structure, so I think it's all wrong, and that field just shouldn't
exist at all, but be passed into the (only) user as an argument.

Oh well. Whatever. I think the code is ugly, but it is what it is. It
may not be worth the churn of fixing.

              Linus

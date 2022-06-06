Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0FF53DF0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 02:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbiFFAPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 20:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343957AbiFFAPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:15:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA7218E
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jun 2022 17:15:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so25996426ejk.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jun 2022 17:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a86dFrA2K8KFLQGTOqTrUMlYEox+AOFVEanULuwTYkA=;
        b=H92tXX1FUoCLFBrmhsASqAgtqal0q1BaHokM3sJhfBHKRTtIA6zm7vNvUXqJYIYszz
         QYCmMnnWVY/A/Mw5Cadr2i1+wyEGoXqNUkwTYx9MSqx5+kqqOEBDy90ozhzh61WPWz1+
         xcGKG9JO77zeS3ExHkqTeW7PDE31kM2sA01qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a86dFrA2K8KFLQGTOqTrUMlYEox+AOFVEanULuwTYkA=;
        b=bNEY4/GF0SCtAllZSKeXs6JU+a5yD1LGkEtC9I6L4jvChbSOYEka16C/2uV5QKcW2m
         FZBz/jJyLAlD3FVjFXtSIoAMml6BVwBDtC2PFCBDT4SdUyBN/2OxEvCxOfdbn8IYFtpx
         f4I3xn6XDWOPkcwjZnAOhZUvUyJidPW0IR1iJMWgclLSfyiKX09Uc7K7MvV3oDR93Esi
         1fSGJgtVcnWQkcWwTPilUKuXAOEkvuVKbKjAddp2Fy8Q4nWQFCj7vNMN3fE2xxNH2jHL
         29i4+iqEPiOX0B/IcPE8zxcX04nnJqV3vpt7X5ZRk7pLg+8TlfXINMMdWUQhneKpsB6s
         TUeA==
X-Gm-Message-State: AOAM53220NonnBKIOSUlITcissfcH1MlhBqy51CkxB21dB2VxNgrGI+x
        SBCtOcr0aqTsyQgJpvujYUpw5yOLsc+gDUorvus=
X-Google-Smtp-Source: ABdhPJwXfCvqG+0yDkLya1E/vMykNjmD2cXEizRvX1m9Tyw8oRm8NRFW0ha1x3K10XuIUyY1TYxtvQ==
X-Received: by 2002:a17:906:b053:b0:6fd:d8d5:5cac with SMTP id bj19-20020a170906b05300b006fdd8d55cacmr18915594ejb.370.1654474530389;
        Sun, 05 Jun 2022 17:15:30 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id s23-20020aa7d797000000b0042bc54296a1sm7538813edq.91.2022.06.05.17.15.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 17:15:30 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id d14so8756171wra.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jun 2022 17:15:29 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr13202054wrq.97.1654474529482; Sun, 05
 Jun 2022 17:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
In-Reply-To: <Yp0AamPDLOK6mTIn@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 17:15:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj8Lg30YpGPK4D45VndfdU4a=8f3uf0EiXtHDSb5o0bw@mail.gmail.com>
Message-ID: <CAHk-=wgj8Lg30YpGPK4D45VndfdU4a=8f3uf0EiXtHDSb5o0bw@mail.gmail.com>
Subject: Re: [git pull] work.fd fix
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 5, 2022 at 12:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> [BTW, what conventions are generally used for pull tag names?]

I don't think we have conventions.

There's a few common patterns, where the tag-name might be the
subsystem name, followed by the version number, followed by a possible
sequential tag number. So "acpi-5.17-rc1-3" or "powerpc-5.16-1" or
"net-5.15-rc8" or "mtd/fixes-for-5.14-rc7".

But another common pattern is to just re-use the same tag-name over
and over again, just updating the tag: "arm64-fixes" or
"clk-fixes-for-linus" or whatever.

In fact, the most common tag-name is just some variation of
"for-linus" (variations: "fixes-for-linus", "for_linus",
"hwmon-for-linus" etc etc)

It really doesn't matter, and your "pull-work.fd-fixes" name is fine.

                  Linus

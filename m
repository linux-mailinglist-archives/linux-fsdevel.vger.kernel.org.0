Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9F50C189
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 00:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiDVV7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiDVV7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:59:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8E2FC248
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 13:42:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g19so16295823lfv.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUIRwjAdRkEnvc7qu/4QggxdGOExn65onlukWBeFsUI=;
        b=drjmZFpO/eg/aqGWeRXDxMCuiAMKW8i3ror9N/4lB8yyadnzfP6lQwSgAMyFconsgF
         gtxeRu1lzm5b8ZvABGsb/Gg6xXWFCEfiAv57raWOKsjF3F86wC9KYCYdqkg5OlLl266C
         AY7IdQrNB2qHZU4X9tcv18FCJYEOYNS5JELfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUIRwjAdRkEnvc7qu/4QggxdGOExn65onlukWBeFsUI=;
        b=VxwNczdY8UbtRWqadt0Kheejoq2RrjyJ+6XuD7CmXueU74YyzIr/rZNwC8rnBWtTLf
         guZq4aK6xcGSAAuZCPHedzkheHhLF6N/kK7J+zNuCNbGhpquo4wFOZn/kZ7++YZWEa76
         SWOHdreBVfrsuuejxcviiMRNntJ/KIUPXXCrodRJ8w+me+nOMkfAAX+/VPlvkPfTrLzk
         jm76l8bej6eLjhAzMvfbZbapNrUYrDmw5G7BnTYhyR9gZ2tXOfAr0pZ27dAcujf423y+
         K5546u9IPqAp/Re3zn96UIvYxSiCeFGav1JXVc5Df9HCDlgpm/h2OGqdEjvwpk/Miw0/
         gF2g==
X-Gm-Message-State: AOAM532O3J4PY5HDiLXzl/JTIetA8u50saL9CWw8whxl13N5WrrekMnv
        1l7umgd/QcY7lBUZkZEYPrs+LeggOIefsBIft80=
X-Google-Smtp-Source: ABdhPJzUZDa7Z0dI2s1ubmSvz2XGnkPJ55ckECo2mp1pYLbEuhiK+jfjuiDrI2tI8ZS8Z6kSe9OKRw==
X-Received: by 2002:a05:6512:3743:b0:448:5782:8db9 with SMTP id a3-20020a056512374300b0044857828db9mr4407863lfs.263.1650659720735;
        Fri, 22 Apr 2022 13:35:20 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t15-20020a19910f000000b004719bd1c66csm343716lfd.109.2022.04.22.13.35.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 13:35:19 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id bn33so10987009ljb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 13:35:19 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr3953312ljg.291.1650659719109; Fri, 22
 Apr 2022 13:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <YmMF32RlCn2asAhc@casper.infradead.org>
In-Reply-To: <YmMF32RlCn2asAhc@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 13:35:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn-V-b=w=4GS_nJQ1nsVcJm0FPTv2Ene_xP_AWPBBFsg@mail.gmail.com>
Message-ID: <CAHk-=wjn-V-b=w=4GS_nJQ1nsVcJm0FPTv2Ene_xP_AWPBBFsg@mail.gmail.com>
Subject: Re: [GIT PULL] Rare page cache data corruption fix
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Fri, Apr 22, 2022 at 12:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Syzbot found a nasty race between large page splitting and page lookup.
> Details in the commit log, but fortunately it has a reliable reproducer.

The commit message does mention it ("I have not added a new test for
this bug."), but I'll echo it anyway, since you say it can be reliably
reproduced - getting that repro into the testsuite would be lovely.

               Linus

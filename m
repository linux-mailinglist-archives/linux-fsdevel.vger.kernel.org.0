Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BAF63D4B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiK3Ler (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 06:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiK3Ldq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:33:46 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6A4B9BC;
        Wed, 30 Nov 2022 03:33:15 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x6so6363079lji.10;
        Wed, 30 Nov 2022 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbgF/8QJth7Q6iZLlIiOpcOOnk+o4nClIAC+d8Lf9z0=;
        b=cgrBYVcGGaOmhs4NUM2DMBzEteSqsnNo+s1OWAu0xrFfR8SfGHhoYWl6cON5bJQf5H
         kBXo+HTMLYJlc0NNqyXTeNHVsKFqrN9RnSJvYMAt9wsTzoHjoBDz54HyrId55uPzhcey
         WrkHDI90HmJoIfjTMzlxSFuMRM+ZEK+h+tp2CXCTYTjqjx+4Ho1p2q1qT5Xh0Pe1NIpw
         kh3Ph4481EH6HJsaTRzldrzwYx9ab3Q4uT9o4p32qRaA2tLn+Hf0w3FMTq1prgn3d5jp
         NtxVXq9wW/MEdgV2FWkhhU7TsMvsvlWqvebJsqA+xk8HaXGX4H+zuKYU5RX6czhqRUDe
         TW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbgF/8QJth7Q6iZLlIiOpcOOnk+o4nClIAC+d8Lf9z0=;
        b=NbDaJ4bhCdEyY92Rmg+X9V7pKl7RshHcGab+wiKVGu4QAM6+8t5Ejncj2PcQUpV6KY
         gFU0yhV+uHOa/LQX1pW0KAXocC6+tvlvT2VCcdBjpHmcZrC0e4qho97BEG5UDGObbfj4
         rinfUQSX6E7C8Sj8Me4T6C9PtIfpIAYbYpTij27qtaykZC+qqN5jQphgJgZ7MHYlhvEa
         Y95m25M0T5qgstUdiXaVKX+mhg6+26VezlBXkryXaWn+KJ9fqgY8b+pGJ628o38ENu0c
         M21vERilU3VlmEqEGrGtFCRfMmwdNoqwA9bZstG5EOcrlgXKs+T5KUrqe4CuBazffj7w
         jeAg==
X-Gm-Message-State: ANoB5pnyPrsN30UH5B9l3CRgAsLD+RGXmMmIh7QtXReycuchoadhUUx2
        CCI7dpjJL3yVp1rHKHupyx+3qdNOumkIyflToXc=
X-Google-Smtp-Source: AA0mqf4DNgrzSTa3qDkcM1vR3wsA4xbwLoMawo/HYfBGJ5539OEYNPmp+YyAmqJIJYo2LXuFpOGWdNGqzEgPvVjR9QQ=
X-Received: by 2002:a2e:3815:0:b0:279:8c75:b1a8 with SMTP id
 f21-20020a2e3815000000b002798c75b1a8mr8432976lja.140.1669807993775; Wed, 30
 Nov 2022 03:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20221130070158.44221-1-chengkaitao@didiglobal.com> <fd28321c-5f00-ba94-daed-2b8da2292c1f@gmail.com>
In-Reply-To: <fd28321c-5f00-ba94-daed-2b8da2292c1f@gmail.com>
From:   Tao pilgrim <pilgrimtao@gmail.com>
Date:   Wed, 30 Nov 2022 19:33:01 +0800
Message-ID: <CAAWJmAYPUK+1GBS0R460pDvDKrLr9zs_X2LT2yQTP_85kND5Ew@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, cgel.zte@gmail.com,
        ran.xiaokai@zte.com.cn, viro@zeniv.linux.org.uk,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        Liam.Howlett@oracle.com, chengzhihao1@huawei.com,
        haolee.swjtu@gmail.com, yuzhao@google.com, willy@infradead.org,
        vasily.averin@linux.dev, vbabka@suse.cz, surenb@google.com,
        sfr@canb.auug.org.au, mcgrof@kernel.org, sujiaxun@uniontech.com,
        feng.tang@intel.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chengkaitao@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 4:41 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 11/30/22 14:01, chengkaitao wrote:
> > From: chengkaitao <pilgrimtao@gmail.com>
> >
>
> Yikes! Another patch from ZTE guys.
>
> I'm suspicious to patches sent from them due to bad reputation with
> kernel development community. First, they sent all patches via
> cgel.zte@gmail.com (listed in Cc) but Greg can't sure these are really
> sent from them ([1] & [2]). Then they tried to workaround by sending
> from their personal Gmail accounts, again with same response from him
> [3]. And finally they sent spoofed emails (as he pointed out in [4]) -
> they pretend to send from ZTE domain but actually sent from their
> different domain (see raw message and look for X-Google-Original-From:
> header.

Hi Bagas Sanjaya,

I'm not an employee of ZTE, just an ordinary developer. I really don't know
all the details about community and ZTE, The reason why I cc cgel.zte@gmail.com
is because the output of the script <get_maintainer.pl> has the
address <cgel.zte@gmail.com>.

If there is any error in the format of the email, I will try my best
to correct it.

>
> I was about to review documentation part of this patch, but due to
> concerns above, I have to write this reply instead. So I'm not going
> to review, sorry for inconvenience.
>
> PS: Adding Greg to Cc: list.
>
> [1]: https://lore.kernel.org/lkml/Yw94xsOp6gvdS0UF@kroah.com/
> [2]: https://lore.kernel.org/lkml/Yylv5hbSBejJ58nt@kroah.com/
> [3]: https://lore.kernel.org/lkml/Y1EVnZS9BalesrC1@kroah.com/
> [4]: https://lore.kernel.org/lkml/Y3NrBvIV7lH2GrWz@kroah.com/
>
> --
> An old man doll... just what I always wanted! - Clara
>


-- 
Yours,
Kaitao Cheng

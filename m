Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1885A0609
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 03:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiHYBiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 21:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiHYBhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:37:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7AC9C202
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 18:36:46 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x10so18041668ljq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 18:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n2DaDKODf/0Jx/YgCGda5jXAYQNmP/PaBJ06ai4Azhs=;
        b=LqSPFJCkwTE1pG70mxEVKOpyv2MERlcRFqR9fTkF8bYwinhYI1yihVD22XO9qN1JM2
         ckZ0QS8cNzg6ZphvBjqbheWmfu8icSjL602tKoRXfx4sNyhawcbIV6AKYg3HOPzfzngB
         lX2NULYEY78Vqy5eBDMD0f7bn2ErDnO+48EOyzUn8id/KeLareHlsFrX627SSDeydDKu
         R4fl0Sv6WmuIlYSxOjRNwxvh7h/TcJbmlpvG0ulKWdnF5NSaoA/W62wZxciZ0ySRfYz0
         gE6a2YO579xTVwMZAJ3yJVax3ibg9gxbyl3lqgXFco3F5bUSeTefY6sRveX5gGnFrymN
         ONJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n2DaDKODf/0Jx/YgCGda5jXAYQNmP/PaBJ06ai4Azhs=;
        b=FPSqsCY27AvD6l5XiJ+JLFjRjP9gCowUc8dx725DUUGDSWr7O09A5tJQCWYo+hdygw
         BvbJCzp+FGUm5OQf7Mxpzem6p64Dpatl4joUnHNQ+bdLCLX1G0wXWU+LzCSyoiF8lv+e
         V+aumY7lI+jUYICuo/B3Bo5u8eORDv0MHGFbdydEeVQ1cr2/ERv3Te6Ep7Gz12XynDYG
         0DtN+MCTKAXyCeJY6ROohxZlkCNly2pp2TsOa9l7DZOZF/uINswiR3FFRok20kEhWRW2
         JbDfM7ZlMm8Tt2t75CWgU+JeCcSR4NRcYqDwUCn8oyRHzwOAOjIGUZ/V4MRHz90pLtyI
         rCUA==
X-Gm-Message-State: ACgBeo0nk2Glf09A4M23P+qS/JoU4Uu8+/sK7G68kJ5oVGGi1fyDWRcZ
        MKf3OIYTt8lfxAoR9UsiyR7GglfHeuTYds08yKSHknSsMmE=
X-Google-Smtp-Source: AA6agR7QA7EhgOcssxsQdsQa443mxRIjyyCiOjL/vJjzUCEcF3h2wC9KL5c4/DQdh+KQC6CIK1SUXfnweApa+RUFvx8=
X-Received: by 2002:a2e:8053:0:b0:261:cf61:c333 with SMTP id
 p19-20020a2e8053000000b00261cf61c333mr468162ljg.297.1661391394774; Wed, 24
 Aug 2022 18:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220817065200.11543-1-yinxin.x@bytedance.com> <3713582.1661336736@warthog.procyon.org.uk>
In-Reply-To: <3713582.1661336736@warthog.procyon.org.uk>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Thu, 25 Aug 2022 09:36:18 +0800
Message-ID: <CAK896s4uuU=K5Gau9J79GK_pWQuihyfXUoZCq0iFbWt9fHLudQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cachefiles: make on-demand request
 distribution fairer
To:     David Howells <dhowells@redhat.com>
Cc:     xiang@kernel.org, jefflexu@linux.alibaba.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, Yongqing Li <liyongqing@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 6:25 PM David Howells <dhowells@redhat.com> wrote:
>
> Xin Yin <yinxin.x@bytedance.com> wrote:
>
> > Reported-by: Yongqing Li <liyongqing@bytedance.com>
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
>
> Can you give me a Fixes: line please?
>
Sure , I will send a V2 patch and add the Fixes line.

Thanks
Xin Yin

> David
>

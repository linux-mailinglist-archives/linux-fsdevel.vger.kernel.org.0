Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED28533598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 05:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbiEYDG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 23:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiEYDGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 23:06:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8172DAA0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 20:06:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n10so39007223ejk.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 20:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGmbJ9cE6oIUUPdop5yVhbY6e/fRjVkPPpoNpOlvd/4=;
        b=Zlgg7kmLf+pBY8CXQmH8HjY5q4isDao4TOz7cmEdYjOJ9wvIx1PvNZ1jJIrXTji2jD
         pZ9FBptuWsX3AoZYaWSkhkksuaxxLxPEbuIr3Vmcpqgk4MHQpQcnB1X9z75q+j8nbgqp
         oCAZg5Jqq+XSadOg6H55iivAliL6xDvuXPvxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGmbJ9cE6oIUUPdop5yVhbY6e/fRjVkPPpoNpOlvd/4=;
        b=DhanVl7UMaPEj8SL4ZrUwYoVymtoBWK+qhA/wNENbJq/360CXfuAIjtudtLs8Ng6HK
         P8S88OolItROMuW4e18jWy1tZ4jEPe2Sp7AcYDznpb66dykD7xNjZE+GqxQ/2B90TgrF
         U9ASax9nEPOps2REiC1/fhFIRrRMymrnIJBpDv2kVVbWkepWgw3WHu1Uivc0m2/X0stB
         Aylc7+KK378cksUueW+4M5HLEJfcLe7FTsljRiODOI8Cnv8MA4Zg0UhwvSRyP2WtjXLJ
         QWxno7j/1mkArcWmZj22aQjs7om9r2sLcdi19w/JYNXFRhrL9PKTdXmqRXzvsNUXJBJm
         PNIA==
X-Gm-Message-State: AOAM530j6MjXYjnwZu7VIC4zSEniI2lgpCXrAX9DIBV5fXlUoNZWWBmR
        NGnYiHB1ss+amp6Ue6Ijd/P3PVVYDmt61HHW
X-Google-Smtp-Source: ABdhPJzqeJj+p2ahORh+ul72trmxDufAddrJnRCnr38ybx+IdR/HhmAqCb4W0Kl6cAHi7k4iMgUWWg==
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr27627646ejo.647.1653448010466;
        Tue, 24 May 2022 20:06:50 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b006fee11af404sm2871787ejp.147.2022.05.24.20.06.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 20:06:49 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id r4-20020a1c4404000000b003975cedb52bso32046wma.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 May 2022 20:06:49 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr2405731wmc.8.1653448008746; Tue, 24 May
 2022 20:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
In-Reply-To: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 May 2022 20:06:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2kKMnxUu65zbJ28t0azRv3-EHpKaaecYTcLiNtw_eMQ@mail.gmail.com>
Message-ID: <CAHk-=wj2kKMnxUu65zbJ28t0azRv3-EHpKaaecYTcLiNtw_eMQ@mail.gmail.com>
Subject: Re: [GIT PULL] Page cache changes for 5.19
To:     Matthew Wilcox <willy@infradead.org>, "Ted Ts'o" <tytso@mit.edu>,
        Gao Xiang <xiang@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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

On Tue, May 24, 2022 at 12:34 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> These are the page cache changes for 5.19.  There are a few conflicts
> with other peoples work:

Hmm. Also the ext4 symlink change (which made your changes there go
away) and the erofs fscache code.

I think I sorted it all out correctly and it looked very
straightforward, but it would probably be a good idea for people to
double-check despite that.

                Linus

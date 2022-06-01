Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70EC53ACDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiFASeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 14:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiFASem (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:34:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E7AF1CE
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 11:34:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v25so3363406eda.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njosF9y/4mY7h7cHbBRt7eN+aSzBOOky31pVud25XUc=;
        b=NPllnz8RYVxm2SnTV64EXzDNNfLuN5S4zdx4+p5tMDUvBFc2HBR70PHsb0+FhzIYOe
         5QBBj11OZ9MvXzN4JDhTfmL34kBXkF5cWwnTwj9QJCpAIQjmWFGOR+tY8hUC7FXp3TPu
         gpZSXodqw0bfpX1vHBHuU/zTaxExUhW5Sii8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njosF9y/4mY7h7cHbBRt7eN+aSzBOOky31pVud25XUc=;
        b=QvxOivjB91IjWH01BVto/iKV28ouFqCpfNLCFUxhi5NCgEDsMBt8KRYG3/ot7ZXZW9
         HakpfO/hEMUFSLtDxq9WbOXzTx/KE0mqWUHHhy8lfwFesK5pci4hw/6FqfeAML0XNoDV
         uCKOu33vR5mvwXmySUEg0ugBiLFV1YFEGh2a+/70D2JpjXU8bnCRUup8e6XCbmBbWsWR
         nFaGkL2z8mJbzFMwCctwdrxLCRwp6fAyF/IasFplp0HFa/FALgxXMhEqtYHmhkKO/nwV
         TRYPQPWcK5z4PdqSO8wnx4MCRuIsvmRnSdHMjMc82Us4znH+j4qvGOMAw0Ly8vel06JW
         rl2g==
X-Gm-Message-State: AOAM533Ta5Xf5IK5u5i3MTsYSvG17HVEb2GRuKKPR4ilsr10WyzS+i3J
        QKe1/gG2o/aRnrkZ3YlZNtGJJzgzBQ7kEG+S
X-Google-Smtp-Source: ABdhPJygSDi/5dXSrlp/A2UupKVmnsJn8AXI65/C5XZ176Q8EaL3deKSqmNWGaLt2FnuCwytOUJZuw==
X-Received: by 2002:a05:6402:11ca:b0:42b:d282:4932 with SMTP id j10-20020a05640211ca00b0042bd2824932mr1145773edw.421.1654108478750;
        Wed, 01 Jun 2022 11:34:38 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id c24-20020a056402159800b0042617ba63c2sm1356845edv.76.2022.06.01.11.34.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 11:34:36 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso2873571wms.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 11:34:36 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr692055wmc.8.1654108476150; Wed, 01 Jun
 2022 11:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org> <857cb160a981b5719d8ed6a3e5e7c456915c64fa.1654086665.git.legion@kernel.org>
 <CAHk-=wjJ2CP0ugbOnwAd-=Cw0i-q_xC1PbJ-_1jrvR-aisiAAA@mail.gmail.com> <Ypeu97GDg6mNiKQ8@example.org>
In-Reply-To: <Ypeu97GDg6mNiKQ8@example.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 11:34:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBeQafNgw6DNUwM4vvw4snb83Tb65m_QH9XSic2JSJaQ@mail.gmail.com>
Message-ID: <CAHk-=wgBeQafNgw6DNUwM4vvw4snb83Tb65m_QH9XSic2JSJaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] sysctl: ipc: Do not use dynamic memory
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>
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

On Wed, Jun 1, 2022 at 11:25 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> I'm not sure how to get rid of ctl_table since net sysctls are heavily
> dependent on it.

I don't actually think it's worth getting rid of entirely, because
there's just a lot of simple cases where it "JustWorks(tm)" and having
just that table entry describe all the semantics is not wrong at all.

The name may suck, but hey, it's not a big deal. Changing it now would
be more pain than it's worth.

No, I was more thinking that things that already need more
infrastructure than that simple static ctl_table entry might be better
off trying to migrate to your new "proper read op" model, and having
more of that dynamic behavior in the read op.

The whole "create dynamic ctl_table entries on the fly" model works,
but it's kind of ugly.

Anyway, I think all of this is "I think there is more room for cleanup
in this area", and maybe we'll never have enough motivation to
actually do that.

Your patches seem to fix the extant issue with the ipc namespace, and
the truly disgusting parts (although maybe there are other truly
disgusting things hiding - I didn't go look for them).

                      Linus

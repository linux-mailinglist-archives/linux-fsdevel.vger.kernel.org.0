Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022EA4D521F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiCJTXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 14:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiCJTXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:23:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A82F406E
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:22:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r7so11213219lfc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHGuzVLaCZTJR5Z/FIfYDsWY8nrsVyf9XB/r18bCkXI=;
        b=ep7XFBy0Q99M5ouVxkQy/Xu+D2RZ7bpJRAdEIb9jXanfP8Lx6Lp5YBbGfSecYfO6B+
         2GOiehczcxMm6X1BX+TQuCcgQF28n9vabec+jv5ZwC9I+//4EvcchXvD9GydAvFCw2ua
         Uw2lQ/BCnimAOmwaI85VX66awfuh3v1U2bb5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHGuzVLaCZTJR5Z/FIfYDsWY8nrsVyf9XB/r18bCkXI=;
        b=BdbajS96Io2Hcwpc+bygPeCUthRvxmIcrhPLH4TLB279EfEatXzmmDlaBqboc5AzgA
         r+lzL9KnO7DfgS+pGsm79CjMDXb/M1oMcDUnh2uQLOrwA6hwxkVFjKpDoNZVU4EFECmT
         FjPGjPLOSUEQtDYC3kHQSiADRNqC51E+V3bwtVlAPvgiJBNQa0HpNmuSLRgksVmF9Qw/
         jt1ff1xlXpdUtlys31s2uQ9PmROOgJbrvEQ4VKEDbh/Hy+K2Btvq9uO6UvbxvMf8CY4/
         CADJiviZCbg0CV3J5FpV7LTGwkgarukl3XyYswllbbejsn8iofD/3fz8J6sDq3uHuCi4
         4ciQ==
X-Gm-Message-State: AOAM533zx7pwMUKP0w3W2kigzmNnZJQKiGFoF98nEgip5O76J5Py93qE
        uLbxsDcXTC34nAvQhey0U4CcdYuvmmj967P3+po=
X-Google-Smtp-Source: ABdhPJzqA9udA+Z8cXIrG21rw6yC7xCtGFKy6oXXuVJxxTXNjOP8kioshQLZuGTXO0/1Q7AF7MjzUg==
X-Received: by 2002:a05:6512:2315:b0:439:731f:a11e with SMTP id o21-20020a056512231500b00439731fa11emr3975265lfu.545.1646940140214;
        Thu, 10 Mar 2022 11:22:20 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id l9-20020a2ea309000000b00246299de080sm1245388lje.48.2022.03.10.11.22.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:22:19 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id u7so9127675ljk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:22:17 -0800 (PST)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr4029456ljg.176.1646940137523; Thu, 10
 Mar 2022 11:22:17 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
 <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
In-Reply-To: <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 11:22:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
Message-ID: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
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

On Thu, Mar 10, 2022 at 10:48 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Works for me. This should probably still be tagged as:
>
> Fixes: cdd591fc86e3 ("iov_iter: Introduce fault_in_iov_iter_writeable")
> Cc: stable@vger.kernel.org # v5.16+

Yeah, I had already added the "Fixes" line there (and it makes the
stable one unnecessary).

            Linus

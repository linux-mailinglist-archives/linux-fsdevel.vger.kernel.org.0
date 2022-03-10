Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514414D52AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiCJT53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 14:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244226AbiCJT52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:57:28 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783213FACD
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:56:27 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r22so9291104ljd.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2Wz219nvat7o4Hv5So6QIXYKsJ4ceesV+enxd1hA8M=;
        b=Z32HTViBy9oMzZHj1RUGbdP8X1j5ggnctR1fE2AX//T4bqyz5C4qMQRw7jXJXt/3+O
         YsLMvkPUjdgSoAQ1O0J2kqVSv2TByYCw1aWHMwibpYpk+kWAzkfpxm5tr+PGYp4DByTw
         9Z5NMp67VygZeUC+jkmx6ezO880rKnd5Dhjjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2Wz219nvat7o4Hv5So6QIXYKsJ4ceesV+enxd1hA8M=;
        b=0G5c9GJZBqh+rSBJIfprYRrXURxn+1GflLrtNxOhN7HjaUd2MvBgBM/17k2KlFaTh4
         E1TDKKWvxjFWxDPuhN5gr+k1MzLE/tVEzUZDWKWdoq7iet9QpifgobgMLTpR9Vg2nFiz
         1XmwjWNRx/KcVhDxIoEEkMhO8zZAN/H6WGTNMpjqVVJlgL1lcjJ7SVKfhm+u9TMbNQjk
         RuPvR0zijNSB7AK5GiExCcVm5UfY4lQLNgyN6Is6Sd3ICBNtQSXSAQLrNoKFwXSJ6+85
         LsFA1BYABcfNslMdR2dXqUZowKUleH/w2Bvm34huRM2SnXdkau+FwPyKfzac18QWjEV/
         SnHA==
X-Gm-Message-State: AOAM5320x6NfzH1Y3C5EiZKlfLe+ZoBc2o71EGyff/Td4wFc1FKwk9xD
        u1IYU5R+Mg5mKGLWKCP2yEgT6ezcwztEP7dZK2w=
X-Google-Smtp-Source: ABdhPJyTqRBIJLwxZprhUjpChzQi/unn1gECZ30k8g1RaxCa+8/640DhkF1nHa+sNTmK/37NWKscsw==
X-Received: by 2002:a2e:a550:0:b0:247:e2b2:a726 with SMTP id e16-20020a2ea550000000b00247e2b2a726mr4099203ljn.111.1646942185255;
        Thu, 10 Mar 2022 11:56:25 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 8-20020a2e1548000000b002463639d0f2sm1208503ljv.68.2022.03.10.11.56.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:56:22 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id g17so11376257lfh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 11:56:21 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr3900843lfb.687.1646942181633; Thu, 10
 Mar 2022 11:56:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com> <CAHk-=wiX1PspWAJ-4Jqk7GHig4B4pJFzPXU7eH2AYtN+iNVAeQ@mail.gmail.com>
 <CAHc6FU6+y2ZGg3QnW9NLsj43vvDpAFu-pVBK-xTPfsDcKa39Mg@mail.gmail.com> <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiXEQ9+NedP6LRbAXGTHrT4MZSPRvbJAFmgrDh75GpE2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 11:56:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
Message-ID: <CAHk-=wi0hBrR3QqYejZ-aJmfAaPWYUEFVaET6UgfCJOky9qOgg@mail.gmail.com>
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

It's out as commit fe673d3f5bf1 ("mm: gup: make
fault_in_safe_writeable() use fixup_user_fault()") now.

                 Linus

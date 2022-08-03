Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14335894F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 01:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiHCXnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 19:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbiHCXnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:43:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC65D0E7
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Aug 2022 16:43:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id uj29so20930933ejc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lgOA02+HwCaP4zKHggG8OC7Keut/1grVFRI+0RIkn4Q=;
        b=LufboehCuxeEuDV9oa12YE8xVcg0hXsGKqXDPs1LhGh8BIdrrINPAuvSCTpU10TMD/
         VGEosdbgCowe20oYYLhzJMNjPqi2Y/StpYT90cJmAAqZlBC3BnyypkO8MOPzyDcJp3K7
         vtDSS2o+GQ3BVHP5foN9lbi7evncrZccgyM0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lgOA02+HwCaP4zKHggG8OC7Keut/1grVFRI+0RIkn4Q=;
        b=Wv9Q++7N5sPVrOte8HQd0mmcCSiJhiav0qIU044rvhJRcvmsG9/ulXjjTyMODxj/JV
         cRbDUVrow1HA6Oo2/iZ0i3IhU/mMlnwbQW7KDVCwN35JFfC1yOs0giwOD2upkWKKj4fg
         rY/dkxK0ktpHBd53s6fqwgcn4bAtLs3mOrra7gSjmP65Oear+WLpWC5mhkBLbkAx40FQ
         UxU2QLV89sM1fn61uMu+5t0OQ93qrfhA4zi+sbhFnXjIojs4eZcwpuPtLdKB2/PRyoU9
         pgBRZ+2aUu06vNbrs4zpkTagUp7D+APKHtd1V6XvjoSt9u2/xuMVRykAsQx7VyuyWw7c
         RrAg==
X-Gm-Message-State: AJIora+5CE8RxWNmfevt8bEahy8gnwO0bi7Mt/nxcWb4HNMOVgPSEKPR
        eASFVUS+HwU89PLmrw0QVoiK/9gV0Y/ShvcB
X-Google-Smtp-Source: AGRyM1tR7OYXd5FXBPRay2pSjXNPhzDuLHdFzdloo/RW8JDlFZ/KB+txdxYYvKkmWXwtLEvqInOVMA==
X-Received: by 2002:a17:907:2855:b0:72b:700e:21eb with SMTP id el21-20020a170907285500b0072b700e21ebmr22295611ejc.270.1659570180468;
        Wed, 03 Aug 2022 16:43:00 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id x3-20020aa7cd83000000b0043e67f9028esm640180edv.20.2022.08.03.16.42.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 16:42:59 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id p8-20020a05600c05c800b003a50311d75cso1184697wmd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Aug 2022 16:42:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1d94:b0:3a4:ffd9:bb4a with SMTP id
 p20-20020a05600c1d9400b003a4ffd9bb4amr3011922wms.8.1659570179354; Wed, 03 Aug
 2022 16:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV> <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org> <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home> <YusDmF39ykDmfSkF@casper.infradead.org>
In-Reply-To: <YusDmF39ykDmfSkF@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 16:42:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
Message-ID: <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, Aug 3, 2022 at 4:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Aug 03, 2022 at 06:59:36PM -0400, Steven Rostedt wrote:
> >
> >       preempt_disable_inlock() ?
>
> preempt_disable_locked()?

Heh. Shed painting in full glory.

Let's try just "preempt_enable_under_spinlock()" and see.

It's a bit long, but it's still shorter than the existing usage pattern.

And we don't have "inlock" anywhere else, and while "locked" is a real
pattern we have, it tends to be about other things (ie "I hold the
lock that you need, so don't take it").

And this is _explicitly_ only about spinning locks, because sleeping
locks don't do the preemption disable even without RT.

So let's make it verbose and clear and unambiguous. It's not like I
expect to see a _lot_ of those. Knock wood.

We had a handful of those things before (in mm/vmstat, and now added
another case to the dentry code. So it has become a pattern, but I
really really hope it's not exactly a common pattern.

And so because it's not common, typing a bit more is a good idea - and
making it really clear is probably also a good idea.

                Linus

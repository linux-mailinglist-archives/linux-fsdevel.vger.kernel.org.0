Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2053EED9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiFFTsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 15:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiFFTsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:48:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C75A090
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 12:48:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o10so20197731edi.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jun 2022 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DT6839JbDy2yIdEYMFoTCSnqwzHXVdWj4aG9+gbEJ94=;
        b=TD3VNjXXe98Co3b86I6MMAPvAqs7GFH9zK5G2EFMl80w/4jTsLDTJTlvJaPlCJ165s
         hN2+7BnMlwCh8SH5aG2nXEF9n5Jn6LQtN4zAVq5mmshHyYzYyDJZcnSBlQSMRFduucv2
         UlPhDYoxVlqwIbAP7DMLZrAx/ovYm8t7HBN8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DT6839JbDy2yIdEYMFoTCSnqwzHXVdWj4aG9+gbEJ94=;
        b=DnFC8Cns3ObAZBxEbhryMszTC+4KOUe9Vb1r8JDInRhEPhQ6Xruhsfv/sLG0j7UWst
         8BqUi8Oi7y7XqH4i5Y/FXcVgh58Ndtw1pFi8i85Jn2G4/71m0UNDOFs0lf2wbofyd4Eo
         FJ3MhYuDWjYyesiniF7Vx6pYbReHDqnBJJJDATEg8nY6DnQDGM//O9frS4RjqJcYxmtk
         Qi8kxD1pOKzFe24kL2EeBOZ2Hd7RLTFpcZZEvKUOivOpPfaTWGCvMGt2ToRMQ5wA8hE0
         1vwvPy7v20ccKprOlQ58zGjr5FCRWxSpk5uAZgZg2KdLw8DXoWHQTEOZEjysQZOC74+E
         iAqw==
X-Gm-Message-State: AOAM531M9SXWl3ToRjghjgTaK0DthVzUP1j/autAEZGNjj+VsWpMuE2V
        w0DWxjfyLGdnc6krJ5E/0BUuSBrMUtuC/OJ7DP4=
X-Google-Smtp-Source: ABdhPJwtQ0ZDdCErizZdjZHj3SyUUwPqbmGW/qffC0T3jgMDP1lTfyphN6ff5n0AnT58ai5ZgsFCEw==
X-Received: by 2002:aa7:c34d:0:b0:42d:ce57:5df2 with SMTP id j13-20020aa7c34d000000b0042dce575df2mr28801635edr.315.1654544892883;
        Mon, 06 Jun 2022 12:48:12 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id c10-20020a056402120a00b0042dd1d3d571sm9026248edw.26.2022.06.06.12.48.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 12:48:11 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id p10so21200928wrg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jun 2022 12:48:11 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr23878066wrf.193.1654544891292; Mon, 06
 Jun 2022 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <226cee6a-6ca1-b603-db08-8500cd8f77b7@gnuweeb.org> <CAHk-=whayT+o58FrPCXVVJ3Bn-3SeoDkMA77TOd9jg4yMGNExw@mail.gmail.com>
 <87r1414y5v.fsf@email.froward.int.ebiederm.org> <CAHk-=wijAnOcC2qQEAvFtRD_xpPbG+aSUXkfM-nFTHuMmPbZGA@mail.gmail.com>
 <266e648a-c537-66bc-455b-37105567c942@canonical.com>
In-Reply-To: <266e648a-c537-66bc-455b-37105567c942@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Jun 2022 12:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+C9XYbu59vuBv1Z9KHd7_tQN_Skd6xzrM512hFJq5aw@mail.gmail.com>
Message-ID: <CAHk-=wi+C9XYbu59vuBv1Z9KHd7_tQN_Skd6xzrM512hFJq5aw@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     John Johansen <john.johansen@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, gwml@vger.gnuweeb.org
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

On Mon, Jun 6, 2022 at 12:19 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> > I suspect that part is that both Apparmor and IPC use the idr local lock.
>
> bingo,
>
> apparmor moved its secids allocation from a custom radix tree to idr in
>
>   99cc45e48678 apparmor: Use an IDR to allocate apparmor secids
>
> and ipc is using the idr for its id allocation as well

The thing is, I'm not entirely convinced you can deadlock on a local lock.

A local lock is per-cpu, so one CPU holding that lock won't actually
block another CPU holding it. Even on RT, I think.

I *think* local locks are useful for lockdep not because of any lock
chains they introduce, but because of how lockdep catches irq mis-use
(where they *can* deadlock).

But I may be entirely wrong, and maybe that lock chain through the
local lock actually does matter.

Let's bring in people who actually know what they are doing, rather
than my wild speculation. Thomas?

                    Linus

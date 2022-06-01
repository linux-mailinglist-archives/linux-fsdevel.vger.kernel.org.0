Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8138E53AD79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiFATcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFATcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 15:32:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A923B140
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 12:30:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t13so3075468ljd.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQjh59P+YL657/ugkQgJkelCDXFl1T1Vs2NaT8wJJmg=;
        b=ZZSpwU9hNx1vIgT23ZqORpMaSlb67mK71XYRdg7+sMMlwAstjUOjkA0TEXRoOiSjBx
         1jZ+YVX1Q02lET6yIsH0PSBUu0oWXEAM0SWXWzAqwObT9JFumL5b5q+9KN6/0sp3uyvB
         Pok3GJX3EYSYz40c743Gtv1qk9/v1YKTSe4Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQjh59P+YL657/ugkQgJkelCDXFl1T1Vs2NaT8wJJmg=;
        b=tTSUce7x8eEkP4vC/foi5hFIUgfIqG0xakAoUxW6jXGBC5FFdPNbQAUB5wHuoHViUZ
         YMRhA0/fuEd7546gOBFskvxtlcdwtgkk57dc4F0HZiiiKHSK3lWBPUUj1IyL42TMsEKe
         K8xkxTEAFsXWdqwiUm6b6/JdEgKwXqcgfjaXg9Jypggnmw2sGFq3Cz4cckrbRRRTll7e
         /zBNt15byvMA4EyoE4LZIAtu6qxutuSGgs5JaCXd3iLaoQv3Zw2MKHlnximRMSRDLX2h
         CFC1WSkcZ1HH75TickzSE5v7I4cKCgTV7z6yPlhTsz3duoFOwmUFzSh74VO8RSPZmUfd
         dDiQ==
X-Gm-Message-State: AOAM530mQf9Q9KJUnRmXhAALYUeGC6Y2gMdp9jQPtsaBm0jH/bjVYto7
        +bp9NIEyPwgdpPz4dlVE5Iuwl6IkeQg813P1
X-Google-Smtp-Source: ABdhPJwTjcFEBUyADWUx3W1o96Ydu8hmrGk50bgnld8f0rdyn0QWtIl9qLRNZD5iQH3QUjCXSBKFng==
X-Received: by 2002:a05:6402:2713:b0:42b:7127:8614 with SMTP id y19-20020a056402271300b0042b71278614mr1390363edd.317.1654111405031;
        Wed, 01 Jun 2022 12:23:25 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id fw9-20020a170907500900b006f3ef214e22sm94680ejc.136.2022.06.01.12.23.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 12:23:23 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id q7so3656623wrg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 12:23:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1605:b0:210:307a:a94a with SMTP id
 u5-20020a056000160500b00210307aa94amr744700wrb.97.1654111402828; Wed, 01 Jun
 2022 12:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
 <cover.1654086665.git.legion@kernel.org> <5ec6759ab3b617f9c12449a9606b6f0b5a7582d0.1654086665.git.legion@kernel.org>
 <Ype7skNJzEQ1W96v@casper.infradead.org>
In-Reply-To: <Ype7skNJzEQ1W96v@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 12:23:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTtYMia0FR4h7_nV2RZ5pq=wR-7oMMK3o8o=EgAxMsmg@mail.gmail.com>
Message-ID: <CAHk-=wiTtYMia0FR4h7_nV2RZ5pq=wR-7oMMK3o8o=EgAxMsmg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] sysctl: API extension for handling sysctl
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Jun 1, 2022 at 12:19 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Why not pass the iocb in ->read and ->write?  We're still regretting not
> doing that with file_operations.

No, all the actual "io" is done by the caller.

There is no way in hell I want the sysctl callbacks to actually
possibly do user space accesses etc.

They get a kernel buffer that has already been set up. There is no
iocb or iovec left for them.

(That also means that they can take whatever locks they need,
including spinlocks, because there's not going to be any random user
accesses or complex pipe buffer lookups or whatever).

                Linus

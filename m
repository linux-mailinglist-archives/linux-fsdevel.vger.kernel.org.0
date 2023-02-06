Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F043168C5B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 19:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBFSZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 13:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFSZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:25:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14BA18B1A
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 10:25:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mf7so36761700ejc.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pIKYXVcSIwS8veSCH80q2Ai3VYS1M33E7BXdYcwbEw=;
        b=aNdDScUudD4zj5QHuuNGc76Q/NxYF5rPIqFKxGjjefRpEASyOQ9GoxDr10JcSZD1/z
         WkODS3TC7fMNPJ5fv0YMZTorOd9tFNAhD/cDDuI2VzFMLMLI+WUPum75HzxuG0rSrKpI
         uO/6XRPsv4bDxUoH22PMbHJiSswxdvg7Xuov0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pIKYXVcSIwS8veSCH80q2Ai3VYS1M33E7BXdYcwbEw=;
        b=hIwLOClOZzRlHgDHYjLlE5LkqVHtMcAD6YnBQB7I1rn9UidEvsCB0oAk3PMNHRoWrm
         pkWMEsqZWLFbpUiIk/pvxJaI6bSKoD0ono/CodNx+2m/MPEAmZ3AtQYpqJSgaw8K5RfS
         O2yyD6JpOFvr7X54RG9Qpd6MTxQ+OyQXK2FNOz1fON00gQhxQFRin7bwddJJfo8vBkY9
         sW56Yu6jyqkFRxl9Ph9T2rybSfjPtVtIWhPwBudY8pQT+IJnkXehkSFWshLmG/LUasVZ
         w+dNoh16Ub/e8WWQUjyejuxUEQcd9aSSwU4txuzPmT6L+tfRf5dAKfThEZAvd/nIw7kO
         B/Vg==
X-Gm-Message-State: AO0yUKWGsTY8PDi+IurT1SDa4viDldSka71mJcgyQDZf8J9oZ8mYx3mL
        QDLQyhlPlTMn7Qfcl/nbnw+7ruZ4B2rn4Pzc17qvtw==
X-Google-Smtp-Source: AK7set9/3LfmNACIghu1X4Hkg/Iuy46wHnCxm0J68RV2N0bhP1nBbdPvMpKfZuEVu26HMk1WYtMVlA==
X-Received: by 2002:a17:907:6d8a:b0:88f:8a5:b4cd with SMTP id sb10-20020a1709076d8a00b0088f08a5b4cdmr474621ejc.1.1675707921163;
        Mon, 06 Feb 2023 10:25:21 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709067e0600b0088eb55ed9cbsm5771760ejr.187.2023.02.06.10.25.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:25:20 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id dr8so36693269ejc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 10:25:20 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr79649ejw.78.1675707920180; Mon, 06 Feb
 2023 10:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+EupX1jX1c5BAHv@kadam>
In-Reply-To: <Y+EupX1jX1c5BAHv@kadam>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Feb 2023 10:25:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiibPvFEGy_Y=VDRNkBZyBxNB5oo0_4p_g3i2MduRZGig@mail.gmail.com>
Message-ID: <CAHk-=wiibPvFEGy_Y=VDRNkBZyBxNB5oo0_4p_g3i2MduRZGig@mail.gmail.com>
Subject: Re: [PATCH v4] pipe: use __pipe_{lock,unlock} instead of spinlock
To:     Dan Carpenter <error27@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
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

On Mon, Feb 6, 2023 at 8:45 AM Dan Carpenter <error27@gmail.com> wrote:
>
> You need the cross function database to review these warnings.  [...]
>
> hl_device_set_debug_mode() take a mutex.  Then you do
> `smdb.py preempt hl_ctx_fini` and it prints out the call tree which
> disables preemption.
>
> cs_ioctl_unreserve_signals() <- disables preempt
> -> hl_ctx_put()
>    -> hl_ctx_do_release()
>       -> hl_ctx_fini()
>
> And so on.

Hmm. Do you have automation to do that at least for the non-driver (ie
"core kernel code") ones?

They are *hopefully* false positives, but if not they are obviously
the most interesting.

And they are presumably not quite as overwhelming as all the driver
ones, so even if they *are* false positives, maybe they would then be
the point to start looking at why the tool gives the wrong answer?

                Linus

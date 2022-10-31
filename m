Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890F8613E04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 20:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJaTH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJaTH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:07:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34555E02B
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 12:07:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id e15so4113642qts.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIRCeB57mif3WLLjzHJdENrFUL9U/TfVQ593vGFl6q4=;
        b=PzRtrjqO02eaWa33Zq3luOuXf6b8F5IN//bl0BoITVBRXmcMh7nbJhnqTYWRRryu5y
         8iDxEI/HfGaS1+1tz8lnXx3Ny5EVlFEYhPErbdEJhiUGODUQeS5CyUWmCheYQW971isr
         K+Mc3Us7oEuRSM2JN/G6i+LXwzXpZEIcmSr+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIRCeB57mif3WLLjzHJdENrFUL9U/TfVQ593vGFl6q4=;
        b=Ay5k75qbqzoRu3Wltb8EUCPj5/6eKUYpfhWdGWdl/BzM5tSyXHwy7l3u7ezm02CGXM
         WkW1LEWZ4h2FyuxC0x+q1uQn68UoQ+ermlZEDDosxZh+Wq5wqHjTEmnnq8aii6RcMDk5
         8lwOcQhzsNeacFuLRZM17VvwwT5pyi7+SZ3b/bj6T+tcOrtJ5BA+nEIeFUzRw8Di7+9a
         pL1SRyYJgjYmE6x6fcnY6PScb9UvJ21nNGtolE4GS6epmOJ5V1VtBJiQK0sjhT9sDSDr
         lFvviFa7JWpkyFEewlk2nCZ9d2dLZbFEpeN3mAwSO/IIslOwqHEv52OobdS1UF89for/
         lW0g==
X-Gm-Message-State: ACrzQf2HdyWpbgfOVBYjMpicnfbneoOeAaC8BBlnrzOq424uebdYQr87
        6e2QRhYD6oVxXNkY8+k925mVkT1DEG+H+w==
X-Google-Smtp-Source: AMsMyM4bOAEdb3dvSGOmI8aAjwyO2B81Ch6fIuvYJJtHpTb2imyLoU41GczxIxTTDNHc5spFmZ0NXQ==
X-Received: by 2002:a05:622a:209:b0:39c:d88f:20ed with SMTP id b9-20020a05622a020900b0039cd88f20edmr11987779qtx.131.1667243273995;
        Mon, 31 Oct 2022 12:07:53 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a448a00b006af0ce13499sm5286809qkp.115.2022.10.31.12.07.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 12:07:53 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id n130so14766304yba.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 12:07:53 -0700 (PDT)
X-Received: by 2002:a25:bb02:0:b0:6ca:9345:b2ee with SMTP id
 z2-20020a25bb02000000b006ca9345b2eemr2992665ybg.362.1667243272872; Mon, 31
 Oct 2022 12:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221031175256.2813280-1-jannh@google.com> <Y2APCmYNjYOYLf8G@ZenIV>
 <CAG48ez094n05c3QJMy7vZ5U=z87MzqYeKU97Na_R9O36_LJSXw@mail.gmail.com> <Y2AYecOnLTkhmZB1@ZenIV>
In-Reply-To: <Y2AYecOnLTkhmZB1@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 12:07:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whynVDmGUG0qNLhGboUKXbTCnKudEr4R=GN5mH-Bz9gLg@mail.gmail.com>
Message-ID: <CAHk-=whynVDmGUG0qNLhGboUKXbTCnKudEr4R=GN5mH-Bz9gLg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: use acquire ordering in __fget_light()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
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

On Mon, Oct 31, 2022 at 11:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Anyway, it's unrelated to the patch itself.  I'm fine with it in the current
> form.  Will apply for the next merge window, unless Linus wants it in right
> now.

It doesn't strike me as hugely critical, so I'm fine with it being put
in any random pile of "fixes to be applied" as long as it doesn't get
lost entirely. But if y ou have a "fixes" branch that may end up
coming to me before this release is over, that's not the wrong place
either.

I would tend to agree with Jann that the re-ordering doesn't look very
likely because it's the same cacheline, so even an aggressively
out-of-order core really doesn't seem to be very likely to trigger any
issues. So you have a really unlikely situation to begin with, and
even less reason for it then triggering the re-ordering.

The "original situation is unlikely" can probably be made quite likely
with an active attack, but that active attacker would then also also
have to rely on "that re-ordering looks sketchy", and actively hunt
for hardware where it can happen.

And said hardware may simply not exist, even if the race is certainly
theoretically possible on any weakly ordered CPU.

             Linus

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7C547040
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 01:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbiFJX1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 19:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbiFJX1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:27:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011FC289712
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 16:27:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m20so733787ejj.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZoJzsRoNjoiccDOrK94bxpJ3hfAz32yrlvd2dEbdCc=;
        b=aLZKbkpPIDUtm14Pxye+efBZEkBYhaccf/7S7anQyCDaVOTMTbCHrjAXLEyx0JZ9oa
         rimx2FbptEmJpu4UBqIupfULzJT0n+9BDzC6Tpis2hVCNTS/XYH8TK8ADU4za2z3OWUs
         ybuPc8IqO7x9sgmL1xCFOSnxFrXkQ6mQGZ9jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZoJzsRoNjoiccDOrK94bxpJ3hfAz32yrlvd2dEbdCc=;
        b=mUsig0t/9VFa5B5W9Bu1b6X9mEEyJNqyWeZnhFLfx705FZrsvXXxE441+U/gyufFGt
         pIgexWNPiLEnatiCX4Dt7Qg4eLo+9DKiAknMeNVSUvAkjadcqIS53HRXPC0s7AMklWMQ
         jXwHraripjN0Z7IkQzMYdKOiros7hKib1q8oSivMLlx59l4uBnvYskf8jTFEQnGIfpAm
         439OaigMm1kR92KtyHZ3mlRuaiJHQVeQr9B17VMNlpeNjBWrbfFpliE5ErpTfAyNvVhO
         yC2y8oteyayVp7OMmNT1Seym8RIZguZNKiM73HOIgsyia+YEZ0qsA66K4J7VgR1pN/LG
         CzbA==
X-Gm-Message-State: AOAM531KDW/ZzK6fLxmKFVfM86NtSNgSUXB/lcP83FNZTF0V/xTjzBkd
        mOnk9GHJhR5dRlcRiNQNgkZD/0ATycvQoZbD
X-Google-Smtp-Source: ABdhPJyyvstLYsBEToCkoR0NmWQO1JDRgIXwOT4ab2ORMRs6xKfZfnFPL+FhOV1HJG4xaZnomSzQQw==
X-Received: by 2002:a17:907:8a08:b0:711:d26d:71d with SMTP id sc8-20020a1709078a0800b00711d26d071dmr24741495ejc.622.1654903661819;
        Fri, 10 Jun 2022 16:27:41 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id d11-20020a50c88b000000b0042bd6630a14sm314469edh.87.2022.06.10.16.27.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 16:27:41 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id m24so370962wrb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 16:27:40 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr39200261wrq.97.1654903660246; Fri, 10
 Jun 2022 16:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <YqOZ3v68HrM9LI//@casper.infradead.org> <CAHk-=wiyexxiFw5N+TtE5kUk4iF4LaNoY3Pzj7aZcj6Msp+tOg@mail.gmail.com>
 <YqO6FaO0/I9Ateze@casper.infradead.org>
In-Reply-To: <YqO6FaO0/I9Ateze@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jun 2022 16:27:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzenicjKjXJnbmh7Nf-Y2aX=Kc46OsskSrKcpuozjFsg@mail.gmail.com>
Message-ID: <CAHk-=wgzenicjKjXJnbmh7Nf-Y2aX=Kc46OsskSrKcpuozjFsg@mail.gmail.com>
Subject: Re: [GIT PULL] Folio fixes for 5.19
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 10, 2022 at 2:40 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> But I don't want to change the refcounting rules on a method without
> changing something else about the method, because trying to find a
> missing refcount change is misery.  Anyway, my cunning thought was
> that if I bundle the change to the refcount rule with the change
> from readahead_page() to readahead_folio(), once all filesystems
> are converted to readahead_folio(), I can pull the refcount game out
> of readahead_folio() and do it in the caller where it belongs, all
> transparent to the filesystems.

Hmm. Any reason why that can't be done right now? Aren't we basically
converted already?

Yeah, yeah, there's a couple of users of readahead_page() left, but if
cleaning up the folio case requires some fixup to those, then that
sounds better than the current "folio interface is very messy".

> (I don't think the erofs code has a bug because it doesn't remove
> the folio from the pagecache while holding the lock -- the folio lock
> prevents anyone _else_ from removing the folio from the pagecache,
> so there must be a reference on the folio up until erofs calls
> folio_unlock()).

Ahh. Ugh. And I guess the whole "clearing the lock bit is the last
time we touch the page flags" and "folio_wake_bit() is very careful to
only touch the external waitqueue" so that there can be no nasty races
with somebody coming in *exactly* as the folio is unlocked.

This has been subtle before, but I think we did allow it exactly for
this kind of reason. I've swapped out the details.

            Linus

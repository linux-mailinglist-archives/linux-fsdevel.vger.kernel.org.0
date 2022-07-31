Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936E8585EBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiGaMAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 08:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGaMAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AFCB1EC;
        Sun, 31 Jul 2022 05:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8301F60C8A;
        Sun, 31 Jul 2022 12:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD9C433D7;
        Sun, 31 Jul 2022 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659268827;
        bh=vjRGLx6dx+Emc3ytg5f776+VjuO33eUdDhjJQx2PtVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e+tqWkAFJjj60N962+xAMnIENwH3HSOnIaMlqKZgvVH0+zsLfRk4+FImOVUgiqBIa
         ld/amFw0WbV6LU1xTTyt7isX7dp8o0qSxMjRdvi30axlzFCh31CbindFyYqCtOYy/u
         YGz2qMlJR7GM/oigbboutzmHEvzNYSYnlWCI2LiNp/bF8PQFdnROo7mP6MkVvCFVgs
         M+xUSA360abk4300VK1WWhokzHMWoPf/833gNMBCS4mnhpQ3NDegGo2KRko6T03d4W
         GeQ0f7968J8lFXxPZzOz1LiyuCfcLaaSOpjMR/nAzt2QwMJq1P0jK5uu88NfUnQ+UB
         ScdhElVnvI2Bg==
Received: by mail-ot1-f41.google.com with SMTP id z12-20020a056830128c00b0061c8168d3faso6328733otp.7;
        Sun, 31 Jul 2022 05:00:27 -0700 (PDT)
X-Gm-Message-State: AJIora/nHZyMfZQZja7C05J7MQkx+vEWWHDt2ObExxPfg+WangC7Di5w
        nxqZEca0jw6XgvTPNQiur2PIdqwnfJufjoiPFLs=
X-Google-Smtp-Source: AGRyM1v9talJvUNeDpPcViwVWdxKdNP71ivGoXcWw3DZGiMhcrMyGoIr9fvEJoVqwnrSEMCGrM4zocaoXVfFHTFgCPc=
X-Received: by 2002:a05:6830:441f:b0:61c:a5bb:9c6a with SMTP id
 q31-20020a056830441f00b0061ca5bb9c6amr4210686otv.265.1659268827066; Sun, 31
 Jul 2022 05:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 31 Jul 2022 14:00:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
Message-ID: <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
Subject: Re: [PATCH] Add a read memory barrier to wait_on_buffer
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mikulas,

On Sun, 31 Jul 2022 at 13:43, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Let's have a look at this piece of code in __bread_slow:
>         get_bh(bh);
>         bh->b_end_io = end_buffer_read_sync;
>         submit_bh(REQ_OP_READ, 0, bh);
>         wait_on_buffer(bh);
>         if (buffer_uptodate(bh))
>                 return bh;
> Neither wait_on_buffer nor buffer_uptodate contain a memory barrier.
> Consequently, if someone calls sb_bread and then reads the buffer data,
> the read of buffer data may be speculatively executed before
> wait_on_buffer(bh) and it may return invalid data.
>

This has little to do with speculation, so better to drop this S bomb
from your commit message. This is about concurrency and weak memory
ordering.

> Also, there is this pattern present several times:
>         wait_on_buffer(bh);
>         if (!buffer_uptodate(bh))
>                 err = -EIO;
> It may be possible that buffer_uptodate is executed before wait_on_buffer
> and it may return spurious error.
>
> Fix these bugs by adding a read memory barrier to wait_on_buffer().
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>
> Index: linux-2.6/include/linux/buffer_head.h
> ===================================================================
> --- linux-2.6.orig/include/linux/buffer_head.h
> +++ linux-2.6/include/linux/buffer_head.h
> @@ -353,6 +353,11 @@ static inline void wait_on_buffer(struct
>         might_sleep();
>         if (buffer_locked(bh))
>                 __wait_on_buffer(bh);
> +       /*
> +        * Make sure that the following accesses to buffer state or buffer data
> +        * are not reordered with buffer_locked(bh).
> +        */
> +       smp_rmb();
>  }
>
>  static inline int trylock_buffer(struct buffer_head *bh)
>

This doesn't seem like a very robust fix to me, tbh - I suppose this
makes the symptom you encountered go away, but the underlying issue
remains afaict.

Given that the lock and uptodate fields etc are just bits in a
bitfield, wouldn't it be better to use cmpxchg() with acquire/release
semantics (as appropriate) to manage these bits?

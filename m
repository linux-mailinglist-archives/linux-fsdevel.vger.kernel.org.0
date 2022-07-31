Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3545861AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 00:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiGaWb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaWbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:31:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E398DBE2F;
        Sun, 31 Jul 2022 15:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C527B80E15;
        Sun, 31 Jul 2022 22:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C71C433D6;
        Sun, 31 Jul 2022 22:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659306712;
        bh=WuaY6aiROPqd6N4Vzb1DSESIWCf+1m2vEs30SnLxXCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+l1owlPCmSfokSC1EarW7HaBaUFfp+fb3hqXxEBGxx4mfDjQ7Rj3byOCkhbZ7ZLM
         mzBaK250tvPNETCg+LsUblhh0pmW1iSBXdUp4qOUoBInY7wjAdHhFmz2qvNlDCZiX1
         /tJq7azzpL5Px1A7N+9i+xhiv2LlFN37L/k+BalL1aAuJ2Wvn2Vws8ZSZhpdlWA4Wu
         UHUCidhCsx08jWhO+vOdTrdVjGFRRmdSKvmmCdWN2k2pr5wL9wO2AJEh0AqMK+msDz
         lOzNsNUsICYUx+su54lMfNiuQMiefptqRbhK9pVxpGbEf4DWjK7D7HPbift1ogjsx5
         MRXrZ551h8BQw==
Received: by mail-oi1-f182.google.com with SMTP id h188so10952163oia.13;
        Sun, 31 Jul 2022 15:31:52 -0700 (PDT)
X-Gm-Message-State: AJIora8cn9NmR3xtkMrY1RMQsc6tvBCbsRRQp0iV15Um9+NpQQGXcbSv
        ahg3TwuhWUq0ctDSg//yGAptkm1u2N6ShNLsdEE=
X-Google-Smtp-Source: AGRyM1sT6mWCwhi5cMK9ZBUkLWuCaaYbXcF29d6XiZ3m6PKo2ujOXyAErhp2f/yXKo2F31zt7al3WFPOcS+0oFq8gEo=
X-Received: by 2002:a05:6808:1489:b0:33a:861c:838e with SMTP id
 e9-20020a056808148900b0033a861c838emr5336590oiw.228.1659306711425; Sun, 31
 Jul 2022 15:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2207310703170.14394@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMj1kXFYRNrP2k8yppgfdKg+CxWeYfHTbzLBuyBqJ9UVAR_vaQ@mail.gmail.com>
 <alpine.LRH.2.02.2207310920390.6506@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311104020.16444@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wiC_oidYZeMD7p0E-=TAuLgrNQ86-sB99=hRqFM8fVLDQ@mail.gmail.com>
 <alpine.LRH.2.02.2207311542280.21273@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2207311641060.21350@file01.intranet.prod.int.rdu2.redhat.com>
 <Yub+vPb53zt6dDpn@casper.infradead.org>
In-Reply-To: <Yub+vPb53zt6dDpn@casper.infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Aug 2022 00:31:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE-TpUGgFxBOaZbsF7k3rdHdjBoqoxZ1bvDz5AoTGADxQ@mail.gmail.com>
Message-ID: <CAMj1kXE-TpUGgFxBOaZbsF7k3rdHdjBoqoxZ1bvDz5AoTGADxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] make buffer_locked provide an acquire semantics
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
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

On Mon, 1 Aug 2022 at 00:14, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jul 31, 2022 at 04:43:08PM -0400, Mikulas Patocka wrote:
> > Let's have a look at this piece of code in __bread_slow:
> >       get_bh(bh);
> >       bh->b_end_io = end_buffer_read_sync;
> >       submit_bh(REQ_OP_READ, 0, bh);
> >       wait_on_buffer(bh);
> >       if (buffer_uptodate(bh))
> >               return bh;
> > Neither wait_on_buffer nor buffer_uptodate contain a memory barrier.
> > Consequently, if someone calls sb_bread and then reads the buffer data,
> > the read of buffer data may be executed before wait_on_buffer(bh) on
> > architectures with weak memory ordering and it may return invalid data.
>
> I think we should be consistent between PageUptodate() and
> buffer_uptodate().  Here's how it's done for pages currently:
>
> static inline bool folio_test_uptodate(struct folio *folio)
>         bool ret = test_bit(PG_uptodate, folio_flags(folio, 0));
>         /*
>          * Must ensure that the data we read out of the folio is loaded
>          * _after_ we've loaded folio->flags to check the uptodate bit.
>          * We can skip the barrier if the folio is not uptodate, because
>          * we wouldn't be reading anything from it.
>          *
>          * See folio_mark_uptodate() for the other side of the story.
>          */
>         if (ret)
>                 smp_rmb();
>
>         return ret;
>
> ...
>
> static __always_inline void folio_mark_uptodate(struct folio *folio)
>         /*
>          * Memory barrier must be issued before setting the PG_uptodate bit,
>          * so that all previous stores issued in order to bring the folio
>          * uptodate are actually visible before folio_test_uptodate becomes true.
>          */
>         smp_wmb();
>         set_bit(PG_uptodate, folio_flags(folio, 0));
>
> I'm happy for these to also be changed to use acquire/release; no
> attachment to the current code.  But bufferheads & pages should have the
> same semantics, or we'll be awfully confused.

I suspect that adding acquire/release annotations at the bitops level
is not going to get us anywhere, given that for the uptodate flag, it
is the set operation that has release semantics, whereas for a lock
flag, it will be the clear operation. Reverting to the legacy barrier
instructions to try and avoid this ambiguity will likely only make
things worse.

I was cc'ed only on patch #1 of your v3, so I'm not sure where this is
headed, but I strongly +1 Matthew's point above that this should be
done at the level that defines how the bit fields should be
interpreted wrt to the contents of the data structure that they
describe/guard.

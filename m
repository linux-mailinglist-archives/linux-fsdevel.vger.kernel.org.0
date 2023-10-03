Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF77B7252
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbjJCUIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjJCUIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:08:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1FA9;
        Tue,  3 Oct 2023 13:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MCXIlJTeaIOaXTM2ypgst+WsqgexEVfRTwhtx2/9uAE=; b=G9emQtGJWrw5S+lxWLRQ2bsag6
        VrjotrRUTj0/WHjtYof/nLmqx9hl4LFgskD6B8OUgWW7PXHgrJiZnmZcKkdKpR7y0kFLLsGMaNmZp
        REX08Eo4/PA+fusNd8UFNcTm8HjLCodpFOvqTgU25BDzAtTfynbFzene611C6gYgHVsWwY+6SfEfh
        R8mP8P2JytQihLF90fUUtsnngBvy9hP/LU6aqSmf5QVrY/wIbyjcilVk9urStDxBRaT6wpD1lGmiu
        M/85IdH4f94whrKADyjeTQOZGkgRuQHcSvXNHystJCFIAibx1y0kyKBxBYv2aaLbVd2hwwkx+uouJ
        Zhoom+7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnlgK-00Gu1C-NV; Tue, 03 Oct 2023 20:07:48 +0000
Date:   Tue, 3 Oct 2023 21:07:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Message-ID: <ZRx0lIo5i2EuIsZ/@casper.infradead.org>
References: <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
 <ZQm67lGOBBdC2Dl9@casper.infradead.org>
 <35a33582-9206-94bb-eca2-a1d9c585f6c1@westnet.com.au>
 <ZRsi7smLotWDwoNP@casper.infradead.org>
 <9d73b9e2-502e-4ef5-bb49-bc89d478329a@westnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d73b9e2-502e-4ef5-bb49-bc89d478329a@westnet.com.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:14:10AM +1000, Greg Ungerer wrote:
> On 3/10/23 06:07, Matthew Wilcox wrote:
> > 00000918 <folio_unlock>:
> >       918:       206f 0004       moveal %sp@(4),%a0
> >       91c:       7001            moveq #1,%d0
> >       91e:       b190            eorl %d0,%a0@
> >       920:       2010            movel %a0@,%d0
> >       922:       4a00            tstb %d0
> >       924:       6a0a            bpls 930 <folio_unlock+0x18>
> >       926:       42a7            clrl %sp@-
> >       928:       2f08            movel %a0,%sp@-
> >       92a:       4eba fafa       jsr %pc@(426 <folio_wake_bit>)
> >       92e:       508f            addql #8,%sp
> >       930:       4e75            rts

fwiw, here's what folio_unlock looks like today without any of my
patches:

00000746 <folio_unlock>:
     746:       206f 0004       moveal %sp@(4),%a0
     74a:       43e8 0003       lea %a0@(3),%a1
     74e:       0891 0000       bclr #0,%a1@
     752:       2010            movel %a0@,%d0
     754:       4a00            tstb %d0
     756:       6a0a            bpls 762 <folio_unlock+0x1c>
     758:       42a7            clrl %sp@-
     75a:       2f08            movel %a0,%sp@-
     75c:       4eba fcc8       jsr %pc@(426 <folio_wake_bit>)
     760:       508f            addql #8,%sp
     762:       4e75            rts

Same number of instructions, but today's code has slightly longer insns,
so I'm tempted to take the win?

> > We could use eori instead of eorl, at least according to table 3-9 on
> > page 3-8:
> > 
> > EOR Dy,<ea>x L Source ^ Destination → Destination ISA_A
> > EORI #<data>,Dx L Immediate Data ^ Destination → Destination ISA_A

Oh.  I misread.  It only does EORI to a data register; it can't do EORI
to an address.

> 400413e6 <folio_unlock>:
> 400413e6:       206f 0004       moveal %sp@(4),%a0
> 400413ea:       2010            movel %a0@,%d0
> 400413ec:       0a80 0000 0001  eoril #1,%d0
> 400413f2:       2080            movel %d0,%a0@
> 400413f4:       2010            movel %a0@,%d0
> 400413f6:       4a00            tstb %d0
> 400413f8:       6c0a            bges 40041404 <folio_unlock+0x1e>
> 400413fa:       42a7            clrl %sp@-
> 400413fc:       2f08            movel %a0,%sp@-
> 400413fe:       4eba ff30       jsr %pc@(40041330 <folio_wake_bit>)
> 40041402:       508f            addql #8,%sp
> 40041404:       4e75            rts
> 
> But that is still worse anyway.

Yup.  Looks like the version I posted actually does the best!  I'll
munge that into the patch series and repost.  Thanks for your help!

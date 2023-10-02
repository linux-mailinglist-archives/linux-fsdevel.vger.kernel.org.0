Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E057B5BC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjJBUHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjJBUHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:07:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0FD3;
        Mon,  2 Oct 2023 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VaRXBAX+SL8oR5DAJJ33YWK0kg9y3S/tFMs5ErCwV4M=; b=tyTvddQZwjPU4NCyNbqmtBxwTI
        Kq6g9Qapzu1V2T/1LVfoTymMZ1bb2QONrTl41ltGkcWgO8C3OxMrZO0vUUbterkaPjXQqj5zl5UWY
        Od/q+nFr5sp3hmR7Q+02+fFUHyfa/unLm/Waq6/NDA+nKY6gA77n1Y4CV6C8E7B9yjTT2MSAhqsX/
        mE0L1qEHeU9Z8HDcrn4+IgWdTLUacxy76ZOg8LoMQ6Fu1YDKq8FKQmrhzovQYa4Y7jTfB5MNGW7kU
        vcWu8FBBE/rEktzzt2TIToDZle387TUfE+hHWx0duFsDle3jHlyRiQtp+i2PYtGwvYw5Fx/EDytKW
        owGUyJog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnPCA-00AvU4-SH; Mon, 02 Oct 2023 20:07:10 +0000
Date:   Mon, 2 Oct 2023 21:07:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Message-ID: <ZRsi7smLotWDwoNP@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
 <ZQm67lGOBBdC2Dl9@casper.infradead.org>
 <35a33582-9206-94bb-eca2-a1d9c585f6c1@westnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35a33582-9206-94bb-eca2-a1d9c585f6c1@westnet.com.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 05:22:33PM +1000, Greg Ungerer wrote:
> On 20/9/23 01:14, Matthew Wilcox wrote:
> > I have a 68020 book; what I don't have is a Coldfire manual.
> 
> You can find it here: https://www.nxp.com/docs/en/reference-manual/CFPRM.pdf

Thanks, Greg.  This is almost good:

static inline bool xor_unlock_is_negative_byte(unsigned long mask,
                volatile unsigned long *p)
{
#ifdef CONFIG_COLDFIRE
        __asm__ __volatile__ ("eorl %1, %0"
                : "+m" (*p)
                : "d" (mask)
                : "memory");
        return *p & (1 << 7);
#else
        char result;
        char *cp = (char *)p + 3;       /* m68k is big-endian */

        __asm__ __volatile__ ("eor.b %1, %2; smi %0"
                : "=d" (result)
                : "di" (mask), "o" (*cp)
                : "memory");
        return result;
#endif
}

folio_end_read() does about as well as can be expected:

00000708 <folio_end_read>:
     708:       206f 0004       moveal %sp@(4),%a0
     70c:       7009            moveq #9,%d0
     70e:       4a2f 000b       tstb %sp@(11)
     712:       6602            bnes 716 <folio_end_read+0xe>
     714:       7001            moveq #1,%d0
     716:       b190            eorl %d0,%a0@
     718:       2010            movel %a0@,%d0
     71a:       4a00            tstb %d0
     71c:       6a0c            bpls 72a <folio_end_read+0x22>
     71e:       42af 0008       clrl %sp@(8)
     722:       2f48 0004       movel %a0,%sp@(4)
     726:       6000 fcfe       braw 426 <folio_wake_bit>
     72a:       4e75            rts

However, it seems that folio_unlock() could shave off an instruction:

00000918 <folio_unlock>:
     918:       206f 0004       moveal %sp@(4),%a0
     91c:       7001            moveq #1,%d0
     91e:       b190            eorl %d0,%a0@
     920:       2010            movel %a0@,%d0
     922:       4a00            tstb %d0
     924:       6a0a            bpls 930 <folio_unlock+0x18>
     926:       42a7            clrl %sp@-
     928:       2f08            movel %a0,%sp@-
     92a:       4eba fafa       jsr %pc@(426 <folio_wake_bit>)
     92e:       508f            addql #8,%sp
     930:       4e75            rts

We could use eori instead of eorl, at least according to table 3-9 on
page 3-8:

EOR Dy,<ea>x L Source ^ Destination → Destination ISA_A
EORI #<data>,Dx L Immediate Data ^ Destination → Destination ISA_A

but gas is unhappy with everything I've tried to use eori.  I'm building
with stmark2_defconfig, which I assume should work.

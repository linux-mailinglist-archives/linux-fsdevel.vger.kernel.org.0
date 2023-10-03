Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5FB7B6B22
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 16:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjJCOOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjJCOO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:14:29 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au (icp-osb-irony-out9.external.iinet.net.au [203.59.1.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDAA195;
        Tue,  3 Oct 2023 07:14:20 -0700 (PDT)
Received: from gateway.pc5.atmailcloud.com (HELO mqr.i-0a234e95c20fc4c8e) ([13.54.26.16])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 03 Oct 2023 22:14:16 +0800
Received: from CMR-KAKADU04.i-07d08b64cb3fd2a62 by MQR.i-0a234e95c20fc4c8e with esmtps
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qngAB-0000ig-0I;
        Tue, 03 Oct 2023 14:14:15 +0000
Received: from [203.220.76.238] (helo=[192.168.0.22])
         by CMR-KAKADU04.i-07d08b64cb3fd2a62 with esmtpsa
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qngAA-0005cb-24;
        Tue, 03 Oct 2023 14:14:14 +0000
Message-ID: <9d73b9e2-502e-4ef5-bb49-bc89d478329a@westnet.com.au>
Date:   Wed, 4 Oct 2023 00:14:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
 <ZQW849TfSCK6u2f8@casper.infradead.org>
 <e1fb697714ac408e85c4e3dc573cd7d5@AcuMS.aculab.com>
 <ZQmvhC+pGWNs9R23@casper.infradead.org>
 <cffc2a427ae74f62b07345ec9348e43e@AcuMS.aculab.com>
 <ZQm67lGOBBdC2Dl9@casper.infradead.org>
 <35a33582-9206-94bb-eca2-a1d9c585f6c1@westnet.com.au>
 <ZRsi7smLotWDwoNP@casper.infradead.org>
From:   Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <ZRsi7smLotWDwoNP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-atmailcloud-spam-report: Action: no action
X-Cm-Envelope: MS4xfIBMT51AiiNz2dlGlRP1BjcNFfsmNerdQ9uhalFXb8JZLgl5GZ6cboSon/f8+hS04zgKn58MdhBWKK7VJY1WoVixGuLcjJZXjl05wI08khOgN6Vn4Y9u t0bdjEbwJxBiYwdftZ0MRuCCZF+wfK5vfRwhthWETiDgJFd5jnp7nJXPs1XE/mjs4xpwJqQv8KOuWg==
X-Cm-Analysis: v=2.4 cv=af+n3zkt c=1 sm=1 tr=0 ts=651c21b6 a=1qi1FL2F0EdFFg+SXJ3Exg==:117 a=1qi1FL2F0EdFFg+SXJ3Exg==:17 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=8AirrxEcAAAA:8 a=dndB6WL-r_NQjhKt7_AA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 3/10/23 06:07, Matthew Wilcox wrote:
> On Wed, Sep 20, 2023 at 05:22:33PM +1000, Greg Ungerer wrote:
>> On 20/9/23 01:14, Matthew Wilcox wrote:
>>> I have a 68020 book; what I don't have is a Coldfire manual.
>>
>> You can find it here: https://www.nxp.com/docs/en/reference-manual/CFPRM.pdf
> 
> Thanks, Greg.  This is almost good:
> 
> static inline bool xor_unlock_is_negative_byte(unsigned long mask,
>                  volatile unsigned long *p)
> {
> #ifdef CONFIG_COLDFIRE
>          __asm__ __volatile__ ("eorl %1, %0"
>                  : "+m" (*p)
>                  : "d" (mask)
>                  : "memory");
>          return *p & (1 << 7);
> #else
>          char result;
>          char *cp = (char *)p + 3;       /* m68k is big-endian */
> 
>          __asm__ __volatile__ ("eor.b %1, %2; smi %0"
>                  : "=d" (result)
>                  : "di" (mask), "o" (*cp)
>                  : "memory");
>          return result;
> #endif
> }
> 
> folio_end_read() does about as well as can be expected:
> 
> 00000708 <folio_end_read>:
>       708:       206f 0004       moveal %sp@(4),%a0
>       70c:       7009            moveq #9,%d0
>       70e:       4a2f 000b       tstb %sp@(11)
>       712:       6602            bnes 716 <folio_end_read+0xe>
>       714:       7001            moveq #1,%d0
>       716:       b190            eorl %d0,%a0@
>       718:       2010            movel %a0@,%d0
>       71a:       4a00            tstb %d0
>       71c:       6a0c            bpls 72a <folio_end_read+0x22>
>       71e:       42af 0008       clrl %sp@(8)
>       722:       2f48 0004       movel %a0,%sp@(4)
>       726:       6000 fcfe       braw 426 <folio_wake_bit>
>       72a:       4e75            rts
> 
> However, it seems that folio_unlock() could shave off an instruction:
> 
> 00000918 <folio_unlock>:
>       918:       206f 0004       moveal %sp@(4),%a0
>       91c:       7001            moveq #1,%d0
>       91e:       b190            eorl %d0,%a0@
>       920:       2010            movel %a0@,%d0
>       922:       4a00            tstb %d0
>       924:       6a0a            bpls 930 <folio_unlock+0x18>
>       926:       42a7            clrl %sp@-
>       928:       2f08            movel %a0,%sp@-
>       92a:       4eba fafa       jsr %pc@(426 <folio_wake_bit>)
>       92e:       508f            addql #8,%sp
>       930:       4e75            rts
> 
> We could use eori instead of eorl, at least according to table 3-9 on
> page 3-8:
> 
> EOR Dy,<ea>x L Source ^ Destination → Destination ISA_A
> EORI #<data>,Dx L Immediate Data ^ Destination → Destination ISA_A
> 
> but gas is unhappy with everything I've tried to use eori.  I'm building

I can't seem to get it to always use it either. This comes close:

         __asm__ __volatile__ ("eorl %1, %0"
                 : "+d" (*p)
                 : "di" (mask)
                 : "memory");
         return *p & (1 << 7);

Using eoril for folio_unlock, but not for folio_end_read:

400413e6 <folio_unlock>:
400413e6:       206f 0004       moveal %sp@(4),%a0
400413ea:       2010            movel %a0@,%d0
400413ec:       0a80 0000 0001  eoril #1,%d0
400413f2:       2080            movel %d0,%a0@
400413f4:       2010            movel %a0@,%d0
400413f6:       4a00            tstb %d0
400413f8:       6c0a            bges 40041404 <folio_unlock+0x1e>
400413fa:       42a7            clrl %sp@-
400413fc:       2f08            movel %a0,%sp@-
400413fe:       4eba ff30       jsr %pc@(40041330 <folio_wake_bit>)
40041402:       508f            addql #8,%sp
40041404:       4e75            rts

But that is still worse anyway.

> with stmark2_defconfig, which I assume should work.

Yes, or any of amcore, m5208evb, m5249evb, m5272c3, m5275evb, m5307c3, m5407c3.

Regards
Greg


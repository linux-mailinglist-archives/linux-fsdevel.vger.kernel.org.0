Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA65E7A30EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbjIPOeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbjIPOeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 10:34:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99390CE8;
        Sat, 16 Sep 2023 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uWg+CjZp6pxnNhsobBoEIP17WYA0CfxidefvFWg7MJo=; b=PR69pf8rgy43jUBW1riqJEYCOk
        4xweYKKMSdTGyzPBNHWkB0Dpxag5wSUlLQ1cthhL9JNBAEd1rtjY4yyF4r3C8iFDaNwbB+6Cu1vJR
        VEa9ICsGyHuxU0x5CiykcBi8Y3dLHleMsGi4xdsmt3OjSeF53OJ0UrBROeKkgC6IOiksWgyUMt8Yf
        wmrg6OkDUjMRRTXxtMcFJPJ24ER05cck/OTMe1MK/yeU40SIgJFmDcDoDsDc6u/vC4C0qBs2fh5WH
        nqffeRog131qazSdbvo9E+SGOwTVMCIKVx01L7JIh0cTlJWx6QAf9HDAdXAI5nMd6dtui63/Lhwck
        PC+Az47A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhWN9-00Gf2K-7B; Sat, 16 Sep 2023 14:34:11 +0000
Date:   Sat, 16 Sep 2023 15:34:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Ungerer <gregungerer@westnet.com.au>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/17] m68k: Implement xor_unlock_is_negative_byte
Message-ID: <ZQW849TfSCK6u2f8@casper.infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
 <20230915183707.2707298-10-willy@infradead.org>
 <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e409d5f-a419-07b7-c82c-4e80fe19c6ba@westnet.com.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 16, 2023 at 11:11:32PM +1000, Greg Ungerer wrote:
> On 16/9/23 04:36, Matthew Wilcox (Oracle) wrote:
> > Using EOR to clear the guaranteed-to-be-set lock bit will test the
> > negative flag just like the x86 implementation.  This should be
> > more efficient than the generic implementation in filemap.c.  It
> > would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >   arch/m68k/include/asm/bitops.h | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> > index e984af71df6b..909ebe7cab5d 100644
> > --- a/arch/m68k/include/asm/bitops.h
> > +++ b/arch/m68k/include/asm/bitops.h
> > @@ -319,6 +319,20 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
> >   	return test_and_change_bit(nr, addr);
> >   }
> > +static inline bool xor_unlock_is_negative_byte(unsigned long mask,
> > +		volatile unsigned long *p)
> > +{
> > +	char result;
> > +	char *cp = (char *)p + 3;	/* m68k is big-endian */
> > +
> > +	__asm__ __volatile__ ("eor.b %1, %2; smi %0"
> 
> The ColdFire members of the 68k family do not support byte size eor:
> 
>   CC      mm/filemap.o
> {standard input}: Assembler messages:
> {standard input}:824: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `eor.b #1,3(%a0)' ignored

Well, that sucks.  What do you suggest for Coldfire?

(Shame you didn't join in on the original discussion:
https://lore.kernel.org/linux-m68k/ZLmKq2VLjYGBVhMI@casper.infradead.org/ )

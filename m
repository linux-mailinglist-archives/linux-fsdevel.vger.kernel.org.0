Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2167B98E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbjJDXt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 19:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbjJDXtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:49:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518ECDD;
        Wed,  4 Oct 2023 16:49:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE1AC433C7;
        Wed,  4 Oct 2023 23:49:18 +0000 (UTC)
Message-ID: <89a5a892-8b34-416d-8b37-a10be3080d54@linux-m68k.org>
Date:   Thu, 5 Oct 2023 09:49:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] m68k: Implement xor_unlock_is_negative_byte
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
References: <20231004165317.1061855-1-willy@infradead.org>
 <20231004165317.1061855-10-willy@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20231004165317.1061855-10-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/10/23 02:53, Matthew Wilcox (Oracle) wrote:
> Using EOR to clear the guaranteed-to-be-set lock bit will test the
> negative flag just like the x86 implementation.  This should be
> more efficient than the generic implementation in filemap.c.  It
> would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.
> 
> Coldfire doesn't have a byte-sized EOR, so we test bit 7 after the
> EOR, which is a second memory access, but it's slightly better than
> the current C code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>


> ---
>   arch/m68k/include/asm/bitops.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
> index e984af71df6b..80ee36095905 100644
> --- a/arch/m68k/include/asm/bitops.h
> +++ b/arch/m68k/include/asm/bitops.h
> @@ -319,6 +319,28 @@ arch___test_and_change_bit(unsigned long nr, volatile unsigned long *addr)
>   	return test_and_change_bit(nr, addr);
>   }
>   
> +static inline bool xor_unlock_is_negative_byte(unsigned long mask,
> +		volatile unsigned long *p)
> +{
> +#ifdef CONFIG_COLDFIRE
> +	__asm__ __volatile__ ("eorl %1, %0"
> +		: "+m" (*p)
> +		: "d" (mask)
> +		: "memory");
> +	return *p & (1 << 7);
> +#else
> +	char result;
> +	char *cp = (char *)p + 3;	/* m68k is big-endian */
> +
> +	__asm__ __volatile__ ("eor.b %1, %2; smi %0"
> +		: "=d" (result)
> +		: "di" (mask), "o" (*cp)
> +		: "memory");
> +	return result;
> +#endif
> +}
> +#define xor_unlock_is_negative_byte xor_unlock_is_negative_byte
> +
>   /*
>    *	The true 68020 and more advanced processors support the "bfffo"
>    *	instruction for finding bits. ColdFire and simple 68000 parts

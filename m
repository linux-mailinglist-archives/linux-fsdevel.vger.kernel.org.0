Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F27A4CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjIRPhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjIRPhk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:37:40 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7476E7C;
        Mon, 18 Sep 2023 08:35:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BEAFE60187;
        Mon, 18 Sep 2023 17:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695051195; bh=A3WfnsfLKB4VtcRcQCaq2eliYXc65wiKBHGm8p0EGtc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pI7Du1o+GRfU4t0jynsD0HQL9wLlySZsoVZ5LD5hJ5LJwYWXy3YWlmGAfGKBvPCk+
         gyDZ0FatE4cArPL/NbWo4YdVL7PmXGBUe1iF3WIztiA52Hlz1cHtBcPpfoy+4kMJz8
         uHAwwDoxXASnpIEEv8cx4G4U0yUJShYoY1Thlf78PNvs762XR6OEtzdP97ftrYxV7L
         BWciltZWTrXN7TrMY+f5ZnN9nLlVMYVaK6rnizZopucbcfPkA88c+jqt7i8M2OiJi4
         4QZuvqHRxCsSmm5K5um3NqMHv6cN7b12vrGhBc9eYRlCMOtZt4PJt/TtLpP4pMNG9s
         gq6a6bQv+Th6A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 53QGMgYFpOhJ; Mon, 18 Sep 2023 17:33:13 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-14.adsl.net.t-com.hr [78.1.184.14])
        by domac.alu.hr (Postfix) with ESMTPSA id EE7DC60186;
        Mon, 18 Sep 2023 17:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695051193; bh=A3WfnsfLKB4VtcRcQCaq2eliYXc65wiKBHGm8p0EGtc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NwJqq4rZHLOUm6Gt/r/mQU71SI2Iahzv9D5++k4VkAzIixMJPO1oswVddCVuvydus
         UBMJbZaqLBzpnDaEns4yl7EGXICzx/3G2PJ3dm3B03DdqclXZfPia4hPZbzt2087RO
         pDcmqSqd+6cPkbv8gVt6cBQKSVqt11LAPmmu4nUzqmUMesBWetjhbleZ+G+OxrjA0s
         /bXJu84Dk6LUmMk3Cm1/Pi/MI3zqY3KwF3UD1bEHutu4H6OCxxAZrf6tCkcLGiLF7n
         Io+NoVVOEOJnfH7HJiYC4TZAifXpHEWYrJYeFbp9wcMCMZh/lo4nzPta9VqWHBCvyA
         Hlwcvt4edcwtg==
Message-ID: <45a59f35-1e86-67a3-26fc-51fd4a4798e0@alu.unizg.hr>
Date:   Mon, 18 Sep 2023 17:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/18/23 16:59, Yury Norov wrote:
> On Mon, Sep 18, 2023 at 02:46:02PM +0200, Mirsad Todorovac wrote:
> 
> ...
> 
>> Ah, I see. This is definitely not good. But I managed to fix and test the find_next_bit()
>> family, but this seems that simply
>>
>> -------------------------------------------
>>   include/linux/xarray.h | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>> index 1715fd322d62..89918b65b00d 100644
>> --- a/include/linux/xarray.h
>> +++ b/include/linux/xarray.h
>> @@ -1718,14 +1718,6 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>>          if (advance)
>>                  offset++;
>> -       if (XA_CHUNK_SIZE == BITS_PER_LONG) {
>> -               if (offset < XA_CHUNK_SIZE) {
>> -                       unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
>> -                       if (data)
>> -                               return __ffs(data);
>> -               }
>> -               return XA_CHUNK_SIZE;
>> -       }
>>          return find_next_bit(addr, XA_CHUNK_SIZE, offset);
>>   }
> 
> This looks correct. As per my understanding, the removed part is the
> 1-word bitmap optimization for find_next_bit. If so, it's not needed
> because find_next_bit() bears this optimization itself.
> 
> ...
> 
>> --------------------------------------------------------
>>   lib/find_bit.c | 33 +++++++++++++++++----------------
>>   1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/lib/find_bit.c b/lib/find_bit.c
>> index 32f99e9a670e..56244e4f744e 100644
>> --- a/lib/find_bit.c
>> +++ b/lib/find_bit.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/math.h>
>>   #include <linux/minmax.h>
>>   #include <linux/swab.h>
>> +#include <asm/rwonce.h>
>>   /*
>>    * Common helper for find_bit() function family
>> @@ -98,7 +99,7 @@ out:                                                                          \
>>    */
>>   unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>>   {
>> -       return FIND_FIRST_BIT(addr[idx], /* nop */, size);
>> +       return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
>>   }
>>   EXPORT_SYMBOL(_find_first_bit);
>>   #endif
> 
> ...
> 
> That doesn't look correct. READ_ONCE() implies that there's another
> thread modifying the bitmap concurrently. This is not the true for
> vast majority of bitmap API users, and I expect that forcing
> READ_ONCE() would affect performance for them.
> 
> Bitmap functions, with a few rare exceptions like set_bit(), are not
> thread-safe and require users to perform locking/synchronization where
> needed.
> 
> If you really need READ_ONCE, I think it's better to implement a new
> flavor of the function(s) separately, like:
>          find_first_bit_read_once()
> 
> Thanks,
> Yury

Hi,

I see the quirk. AFAICS, correct locking would be more expensive than READ_ONCE()
flavour of functions.

Only one has to inspect every line where they are used and see if there is the need
for the *_read_once() version.

I suppose people will not be happy because of the duplication of code. :-(

It is not a lot of work, I will do a PoC code and see if KCSAN still complains.
(Which was the basic reason in the first place for all this, because something changed
data from underneath our fingers ...).

Best regards,
Mirsad



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F47A373E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbjIQTJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 15:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjIQTJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:09:27 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD010A;
        Sun, 17 Sep 2023 12:09:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1D88260157;
        Sun, 17 Sep 2023 21:09:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694977758; bh=J2GzxI4nKONyIeyCnRvL4IDtSLiLqiX3VYZ/pESlvbQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s2xc7/yLlQO2ZxByvSifmy9yaLhlJ8SwoB9jisWE0fKUpdVFjwIHwmhkah+9oi0Wa
         gPZPMCiXMP2ztNWyELrplUSj8sQoBTyfqpFXsFcaPnI5Dz6zkiVflTEkNwJr1BiNjd
         +AALeFSpSmxYai0U42HHADWHfCe5ohb5Cfpb94X1VMtragTN8vs36fmjVVN444HVzf
         zDQDFCUx6OhompZW3kq8Y9zd2EHagKyU+UvoDi67uLY/pbg37+M7XGpR1qRxrpzHNK
         doA9fr/u+SxArIn57IgEamqbnROkeipugMfa4l9fi0zdtc6D6qiPkHkWQLnwPRnssG
         W6nZb2F0qClGQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IwPoN2A_Z6Mm; Sun, 17 Sep 2023 21:09:15 +0200 (CEST)
Received: from [192.168.1.6] (78-2-88-58.adsl.net.t-com.hr [78.2.88.58])
        by domac.alu.hr (Postfix) with ESMTPSA id ED53D60155;
        Sun, 17 Sep 2023 21:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1694977755; bh=J2GzxI4nKONyIeyCnRvL4IDtSLiLqiX3VYZ/pESlvbQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xfiFVRW8iwNRMZrcXU8lHie0TaHNu0mMI2+3PSwseHYoyIqEs/045aDmzesmk08X8
         +kU1E1J09Kw//yEYUeOEIPBEzTmRMy37GaxUSby/VYsDhhMGzlIYQolUNYtRycj/Xg
         jtk24u58a/0QyD7cm4f5uh6c4LFxu/xQkflKUKiS1ddpcj5CuTsXQ9lrb2cj22+Dg8
         XF/nrwYTLyplaVdCz2vPvcKNH2vVgpvf+rsyjMH61rSyUVDZ9EbqIUzawuNtFbYQGP
         Js/OxDZmvxhxG3Rvn0nl+eobwgkQVsCfs3zDyMWktCjqPFA+ehBhcCpGz4KSEmPD4O
         rcSfkuqvbbyKQ==
Message-ID: <3cfe5345-66a0-bb3b-a1d4-02ff2b3b098b@alu.unizg.hr>
Date:   Sun, 17 Sep 2023 21:09:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [BUG] KCSAN: data-race in xas_clear_mark / xas_find_marked
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
 <ZN9iPYTmV5nSK2jo@casper.infradead.org>
 <20230914080811.465zw662sus4uznq@quack3>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230914080811.465zw662sus4uznq@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/14/23 10:08, Jan Kara wrote:
> On Fri 18-08-23 13:21:17, Matthew Wilcox wrote:
>> On Fri, Aug 18, 2023 at 10:01:32AM +0200, Mirsad Todorovac wrote:
>>> [  206.510010] ==================================================================
>>> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
>>>
>>> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
>>> [  206.510081]  xas_clear_mark+0xd5/0x180
>>> [  206.510097]  __xa_clear_mark+0xd1/0x100
>>> [  206.510114]  __folio_end_writeback+0x293/0x5a0
>>> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
>>> [  206.520735]  xas_find_marked+0xe5/0x600
>>> [  206.520750]  filemap_get_folios_tag+0xf9/0x3d0
>> Also, before submitting this kind of report, you should run the
>> trace through scripts/decode_stacktrace.sh to give us line numbers
>> instead of hex offsets, which are useless to anyone who doesn't have
>> your exact kernel build.
>>
>>> [  206.510010] ==================================================================
>>> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
>>>
>>> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
>>> [  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
>>> [  206.510097] __xa_clear_mark (lib/xarray.c:1923)
>>> [  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)
>>
>> This path is properly using xa_lock_irqsave() before calling
>> __xa_clear_mark().
>>
>>> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
>>> [  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
>>> [  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)
>>
>> This takes the RCU read lock before calling xas_find_marked() as it's
>> supposed to.
>>
>> What garbage do I have to write to tell KCSAN it's wrong?  The line
>> that's probably triggering it is currently:
>>
>>                          unsigned long data = *addr & (~0UL << offset);
> 
> I don't think it is actually wrong in this case. You're accessing xarray
> only with RCU protection so it can be changing under your hands. For
> example the code in xas_find_chunk():
> 
>                          unsigned long data = *addr & (~0UL << offset);
>                          if (data)
>                                  return __ffs(data);
> 
> is prone to the compiler refetching 'data' from *addr after checking for
> data != 0 and getting 0 the second time which would trigger undefined
> behavior of __ffs(). So that code should definitely use READ_ONCE() to make
> things safe.
> 
> BTW, find_next_bit() seems to need a similar treatment and in fact I'm not
> sure why xas_find_chunk() has a special case for XA_CHUNK_SIZE ==
> BITS_PER_LONG because find_next_bit() checks for that and handles that in a
> fast path in the same way.
> 
> 								Honza

Hi,

Thank you for your insight on the matter.

I guess you meant something like implementing this:

  include/linux/xarray.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..1715fd322d62 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1720,7 +1720,7 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
                 offset++;
         if (XA_CHUNK_SIZE == BITS_PER_LONG) {
                 if (offset < XA_CHUNK_SIZE) {
-                       unsigned long data = *addr & (~0UL << offset);
+                       unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
                         if (data)
                                 return __ffs(data);
                 }


This apparently clears the KCSAN xas_find_marked() warning, so this might have been a data race after all.

Do you think we should escalate this to a formal patch?

Best regards,
Mirsad Todorovac

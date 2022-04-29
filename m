Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111C951543E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 21:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356206AbiD2TT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 15:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiD2TT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:19:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD883BBD0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=g3Ji1WDNCJPHmU5U+7jqgryKGBHLdhE1s5AQwWZBaq8=; b=QhhgPaFoshy67K2dPAZ2fFeQQS
        eCMoNRESxMIaAMfPXs2QVpJdANxuFHNuOiCY5d82pfBr33/0jLZhb0lwgQgfUNwNZIFk536ctF8gG
        8lNhSyzyV2dPivxKkG2JsAVUJs3sB0CRFDcDkAROBMCJqERtpdDCjngNKV/VXbSpmwV5/tlJv0T0b
        HguGaXGGghTrJhGIeFErsOqw1HX/v68zpGUxEtTYlsF4fvEbCUfwRhYq2lCg7kMR2AXnbbZqMbiuC
        S66lVayFfmZ1OW+Jy7b5CLWsxlqzzg1px+zxc92f0R2jZOpLH2b9LCcjrZs0bh4US2vMICIiQj/5D
        j4H/Ka9w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkW68-009gE2-Hf; Fri, 29 Apr 2022 19:16:33 +0000
Message-ID: <3ddc8a83-bebf-fe00-351e-f0a311b6c5c8@infradead.org>
Date:   Fri, 29 Apr 2022 12:16:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] fs/ntfs3: validate BOOT sectors_per_clusters
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kari Argillander <kari.argillander@stargateuniverse.net>,
        Namjae Jeon <linkinjeon@kernel.org>
References: <20220429172711.31894-1-rdunlap@infradead.org>
 <YmwixlgHg8n4NsOd@casper.infradead.org>
 <8a29f83c-7fbd-8044-406f-248595cd2ee6@infradead.org>
 <Ymw4T1CF4PxMe5Ym@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Ymw4T1CF4PxMe5Ym@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/29/22 12:11, Matthew Wilcox wrote:
> On Fri, Apr 29, 2022 at 11:52:47AM -0700, Randy Dunlap wrote:
>> Hi--
>>
>> On 4/29/22 10:39, Matthew Wilcox wrote:
>>> On Fri, Apr 29, 2022 at 10:27:11AM -0700, Randy Dunlap wrote:
>>>> When the NTFS BOOT sectors_per_clusters field is > 0x80,
>>>> it represents a shift value. First change its sign to positive
>>>> and then make sure that the shift count is not too large.
>>>> This prevents negative shift values and shift values that are
>>>> larger than the field size.
>>>>
>>>> Prevents this UBSAN error:
>>>>
>>>>   UBSAN: shift-out-of-bounds in ../fs/ntfs3/super.c:673:16
>>>>   shift exponent -192 is negative
>>>>
>>>> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
>>>> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
>>>> Reported-by:syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com
>>>> Cc: Konstantin Komarov<almaz.alexandrovich@paragon-software.com>
>>>> Cc:ntfs3@lists.linux.dev
>>>> Cc: Alexander Viro<viro@zeniv.linux.org.uk>
>>>> Cc: Andrew Morton<akpm@linux-foundation.org>
>>>> Cc: Kari Argillander<kari.argillander@stargateuniverse.net>
>>>> Cc: Namjae Jeon<linkinjeon@kernel.org>
>>>> ---
>>>>   fs/ntfs3/super.c |    5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> --- linux-next-20220428.orig/fs/ntfs3/super.c
>>>> +++ linux-next-20220428/fs/ntfs3/super.c
>>>> @@ -670,7 +670,8 @@ static u32 true_sectors_per_clst(const s
>>>>   {
>>>>   	return boot->sectors_per_clusters <= 0x80
>>>>   		       ? boot->sectors_per_clusters
>>>> -		       : (1u << (0 - boot->sectors_per_clusters));
>>>> +		       : -(s8)boot->sectors_per_clusters > 31 ? -1
>>>> +		       : (1u << -(s8)boot->sectors_per_clusters);
>>>>   }
>>> This hurts my brain.  Can we do instead:
>>
>> It's just C.  Lot clearer than some of our macro magic.
> 
> Well, yeah, but I don't have to understand our macro magic; I can just
> assume it does what it says on the tin.
> 
>>>
>>> 	if (boot->sectors_per_clusters <= 0x80)
>>> 		return boot->sectors_per_clusters;
>>> 	if (boot->sectors_per_clusters < 0xA0)
>>
>> The 0xA0 does not take into account the '-' negating of sectors_per_clusters
>> in the shift.
>> Looks like it should be
>>
>> 	if (boot->sectors_per_clusters >= 0xe1)
>> 		return 1U << -boot->sectors_per_clusters;
> 
> Oh!  I misunderstood how the ranges are used.  But I think a unary minus
> will leave the type as unsigned (am I wrong?  C integer promotions
> always confuse me), so how about:
> 
> 	if (boot->sectors_per_clusters > 0xe0)
> 		return 1U << (0 - boot->sectors_per_clusters);

OK, I'll test that.
Thanks.

> https://en.cppreference.com/w/c/language/conversion
> 
>>> 		return 1U << (boot->sectors_per_clusters - 0x80);
>>> 	return 0xffffffff;
>>>
>>
>> Sorry about your head.

-- 
~Randy

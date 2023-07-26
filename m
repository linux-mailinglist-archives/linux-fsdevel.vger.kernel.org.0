Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15F763AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjGZP00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjGZP0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:26:24 -0400
Received: from bagheera.iewc.co.za (bagheera.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C094;
        Wed, 26 Jul 2023 08:26:22 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qOgP0-0000q2-1c; Wed, 26 Jul 2023 17:26:14 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qOgOz-0005NM-ER; Wed, 26 Jul 2023 17:26:13 +0200
Message-ID: <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
Date:   Wed, 26 Jul 2023 17:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Content-Language: en-GB
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
 <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2023/07/26 15:53, Bernd Schubert wrote:
>
>
> On 7/26/23 12:59, Jaco Kroon wrote:
>> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
>> ---
>>   fs/fuse/Kconfig   | 16 ++++++++++++++++
>>   fs/fuse/readdir.c | 42 ++++++++++++++++++++++++------------------
>>   2 files changed, 40 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>> index 038ed0b9aaa5..0783f9ee5cd3 100644
>> --- a/fs/fuse/Kconfig
>> +++ b/fs/fuse/Kconfig
>> @@ -18,6 +18,22 @@ config FUSE_FS
>>         If you want to develop a userspace FS, or if you want to use
>>         a filesystem based on FUSE, answer Y or M.
>>   +config FUSE_READDIR_ORDER
>> +    int
>> +    range 0 5
>> +    default 5
>> +    help
>> +        readdir performance varies greatly depending on the size of 
>> the read.
>> +        Larger buffers results in larger reads, thus fewer reads and 
>> higher
>> +        performance in return.
>> +
>> +        You may want to reduce this value on seriously constrained 
>> memory
>> +        systems where 128KiB (assuming 4KiB pages) cache pages is 
>> not ideal.
>> +
>> +        This value reprents the order of the number of pages to 
>> allocate (ie,
>> +        the shift value).  A value of 0 is thus 1 page (4KiB) where 
>> 5 is 32
>> +        pages (128KiB).
>> +
>
> I like the idea of a larger readdir size, but shouldn't that be a 
> server/daemon/library decision which size to use, instead of kernel 
> compile time? So should be part of FUSE_INIT negotiation?

Yes sure, but there still needs to be a default.  And one page at a time 
doesn't cut it.

-- snip --

>>   -    page = alloc_page(GFP_KERNEL);
>> +    page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);
>
> I guess that should become folio alloc(), one way or the other. Now I 
> think order 0 was chosen before to avoid risk of allocation failure. I 
> guess it might work to try a large size and to fall back to 0 when 
> that failed. Or fail back to the slower vmalloc.

If this varies then a bunch of other code will become somewhat more 
complex, especially if one alloc succeeds, and then a follow-up succeeds.

I'm not familiar with the differences between the different mechanisms 
available for allocation.

-- snip --

> Thanks,
My pleasure,
Jaco

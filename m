Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941EE763EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 20:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGZSkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGZSkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:40:22 -0400
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD8019BD;
        Wed, 26 Jul 2023 11:40:19 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qOjCo-0001Sj-MK; Wed, 26 Jul 2023 20:25:50 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qOjCn-0005Ug-L2; Wed, 26 Jul 2023 20:25:49 +0200
Message-ID: <27875beb-bd1c-0087-ac4c-420a9d92a5a9@uls.co.za>
Date:   Wed, 26 Jul 2023 20:25:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Content-Language: en-GB
To:     Antonio SJ Musumeci <trapexit@spawn.link>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
 <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
 <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
 <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
 <831e5a03-7126-3d45-2137-49c1a25769df@spawn.link>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <831e5a03-7126-3d45-2137-49c1a25769df@spawn.link>
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

On 2023/07/26 19:23, Antonio SJ Musumeci wrote:
> On 7/26/23 10:45, Bernd Schubert wrote:
>> On 7/26/23 17:26, Jaco Kroon wrote:
>>> Hi,
>>>
>>> On 2023/07/26 15:53, Bernd Schubert wrote:
>>>> On 7/26/23 12:59, Jaco Kroon wrote:
>>>>> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
>>>>> ---
>>>>>     fs/fuse/Kconfig   | 16 ++++++++++++++++
>>>>>     fs/fuse/readdir.c | 42 ++++++++++++++++++++++++------------------
>>>>>     2 files changed, 40 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
>>>>> index 038ed0b9aaa5..0783f9ee5cd3 100644
>>>>> --- a/fs/fuse/Kconfig
>>>>> +++ b/fs/fuse/Kconfig
>>>>> @@ -18,6 +18,22 @@ config FUSE_FS
>>>>>           If you want to develop a userspace FS, or if you want to use
>>>>>           a filesystem based on FUSE, answer Y or M.
>>>>>     +config FUSE_READDIR_ORDER
>>>>> +    int
>>>>> +    range 0 5
>>>>> +    default 5
>>>>> +    help
>>>>> +        readdir performance varies greatly depending on the size of
>>>>> the read.
>>>>> +        Larger buffers results in larger reads, thus fewer reads and
>>>>> higher
>>>>> +        performance in return.
>>>>> +
>>>>> +        You may want to reduce this value on seriously constrained
>>>>> memory
>>>>> +        systems where 128KiB (assuming 4KiB pages) cache pages is
>>>>> not ideal.
>>>>> +
>>>>> +        This value reprents the order of the number of pages to
>>>>> allocate (ie,
>>>>> +        the shift value).  A value of 0 is thus 1 page (4KiB) where
>>>>> 5 is 32
>>>>> +        pages (128KiB).
>>>>> +
>>>> I like the idea of a larger readdir size, but shouldn't that be a
>>>> server/daemon/library decision which size to use, instead of kernel
>>>> compile time? So should be part of FUSE_INIT negotiation?
>>> Yes sure, but there still needs to be a default.  And one page at a time
>>> doesn't cut it.
>> With FUSE_INIT userspace would make that decision, based on what kernel
>> fuse suggests? process_init_reply() already handles other limits - I
>> don't see why readdir max has to be compile time option. Maybe a module
>> option to set the limit?
>>
>> Thanks,
>> Bernd
> I had similar question / comment. This seems to me to be more
> appropriately handed by the server via FUSE_INIT.
>
> And wouldn't "max" more easily be FUSE_MAX_MAX_PAGES? Is there a reason
> not to allow upwards of 256 pages sized readdir buffer?

Will look into FUSE_INIT.  The FUSE_INIT as I understand from what I've 
read has some expansion constraints or the structure is somehow 
negotiated.  Older clients in other words that's not aware of the option 
will follow some default.  For backwards compatibility that default 
should probably be 1 page.  For performance reasons it makes sense that 
this limit be larger.

glibc uses a 128KiB buffer for getdents64, so I'm not sure >128KiB here 
makes sense.  Or if these two buffers are even directly related.

Default to fc->max_pages (which defaults to 32 or 128KiB) if the 
user-space side doesn't understand the max_readdir_pages limit aspect of 
things?  Assuming these limits should be set separately.  I'm thinking 
piggy backing on fc->max_pages is just fine to be honest.

For the sake of avoiding division and modulo operations in the cache, 
I'm thinking round-down max_pages to the closest power of two for the 
sake of sticking to binary operators rather than divisions and mods?

Current patch introduces a definite memory leak either way.  Tore 
through about 12GB of RAM in a matter of 20 minutes or so.  Just going 
to patch it that way first, and then based on responses above will look 
into an alternative patch that does not depend on a compile-time 
option.  Guessing __free_page should be a multi-page variant now.

Thanks for all the feedback so far.

Kind regards,
Jaco


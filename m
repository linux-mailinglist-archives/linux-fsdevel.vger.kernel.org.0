Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA727B11C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 06:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjI1ExT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 00:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1ExS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:53:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F5EF9;
        Wed, 27 Sep 2023 21:53:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC98C433C8;
        Thu, 28 Sep 2023 04:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695876793;
        bh=DyqeGBOHGNaWTSNuZKS3eruzn0IVxu339Um+OpsmcQc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oJQRurvFgSyAFtD69d8AsZCHW3JzWkQ9SWCp82zAqU5iyGAyNnoaJIGuAAUH/9RR3
         Mx0tPQQ4YPtw2NQ8Wf8ig+pnebTl3HmwhbclJEEi7O/PNFacLZ+Fv8sFBFT2WiBTMt
         DkQaOiPSDx8adBuJ7S2W69TTNg3y4sUc8HPQ8oWdizW/xz7CF3z/qaY6vleqVJ9cC3
         Yz716Egi/FoPoyjWRH3BHhMjSwdbndjk1YDCN5d54AxjJYhQtB3gJzQJvn9YISD6Kq
         OsO6U0dEVCHAwdYTSRC7GN2lGyQKqhRqe+RJYec8A7O6IyDjXM/5MJNxqPFFTbwNXD
         b7n42/AsKS2fA==
Message-ID: <9e4cf2c9-a1a9-43a8-3f72-2824301bbc98@kernel.org>
Date:   Thu, 28 Sep 2023 14:53:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] binfmt_elf_fdpic: clean up debug warnings
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        ebiederm@xmission.com, brauner@kernel.org, viro@zeniv.linux.org.uk
References: <20230927132933.3290734-1-gerg@kernel.org>
 <202309270858.680FCD9A85@keescook>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <202309270858.680FCD9A85@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

On 28/9/23 01:59, Kees Cook wrote:
> On Wed, Sep 27, 2023 at 11:29:33PM +1000, Greg Ungerer wrote:
>> The binfmt_elf_fdpic loader has some debug trace that can be enabled at
>> build time. The recent 64-bit additions cause some warnings if that
>> debug is enabled, such as:
>>
>>      fs/binfmt_elf_fdpic.c: In function ‘elf_fdpic_map_file’:
>>      fs/binfmt_elf_fdpic.c:46:33: warning: format ‘%x’ expects argument of type ‘unsigned int’, but argument 3 has type ‘Elf64_Addr’ {aka ‘long long unsigned int’} [-Wformat=]
>>         46 | #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
>>            |                                 ^~~~~~~~
>>      ./include/linux/printk.h:427:25: note: in definition of macro ‘printk_index_wrap’
>>        427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>>            |                         ^~~~
>>
>> Cast values to the largest possible type (which is equivilent to unsigned
>> long long in this case) and use appropriate format specifiers to match.
> 
> It seems like these should all just be "unsigned long", yes?

Some of them yes, but not all.
For example trying to use unsigned long in the last chunk of this patch:

fs/binfmt_elf_fdpic.c: In function ‘elf_fdpic_map_file_by_direct_mmap’:
fs/binfmt_elf_fdpic.c:46:33: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘long long unsigned int’ [-Wformat=]
    46 | #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
       |                                 ^~~~~~~~
./include/linux/printk.h:427:25: note: in definition of macro ‘printk_index_wrap’
   427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
       |                         ^~~~
fs/binfmt_elf_fdpic.c:46:26: note: in expansion of macro ‘printk’
    46 | #define kdebug(fmt, ...) printk("FDPIC "fmt"\n" ,##__VA_ARGS__ )
       |                          ^~~~~~
fs/binfmt_elf_fdpic.c:1152:25: note: in expansion of macro ‘kdebug’
  1152 |                         kdebug("clear[%d] ad=%lx sz=%lx", loop,
       |                         ^~~~~~

Regards
Greg


> -Kees
> 
>>
>> Fixes: b922bf04d2c1 ("binfmt_elf_fdpic: support 64-bit systems")
>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>> ---
>>   fs/binfmt_elf_fdpic.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>> index 43b2a2851ba3..97c3e8551aac 100644
>> --- a/fs/binfmt_elf_fdpic.c
>> +++ b/fs/binfmt_elf_fdpic.c
>> @@ -900,10 +900,12 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>>   	kdebug("- DYNAMIC[]: %lx", params->dynamic_addr);
>>   	seg = loadmap->segs;
>>   	for (loop = 0; loop < loadmap->nsegs; loop++, seg++)
>> -		kdebug("- LOAD[%d] : %08x-%08x [va=%x ms=%x]",
>> +		kdebug("- LOAD[%d] : %08llx-%08llx [va=%llx ms=%llx]",
>>   		       loop,
>> -		       seg->addr, seg->addr + seg->p_memsz - 1,
>> -		       seg->p_vaddr, seg->p_memsz);
>> +		       (unsigned long long) seg->addr,
>> +		       (unsigned long long) seg->addr + seg->p_memsz - 1,
>> +		       (unsigned long long) seg->p_vaddr,
>> +		       (unsigned long long) seg->p_memsz);
>>   
>>   	return 0;
>>   
>> @@ -1082,9 +1084,10 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>>   		maddr = vm_mmap(file, maddr, phdr->p_memsz + disp, prot, flags,
>>   				phdr->p_offset - disp);
>>   
>> -		kdebug("mmap[%d] <file> sz=%lx pr=%x fl=%x of=%lx --> %08lx",
>> -		       loop, phdr->p_memsz + disp, prot, flags,
>> -		       phdr->p_offset - disp, maddr);
>> +		kdebug("mmap[%d] <file> sz=%llx pr=%x fl=%x of=%llx --> %08lx",
>> +		       loop, (unsigned long long) phdr->p_memsz + disp,
>> +		       prot, flags, (unsigned long long) phdr->p_offset - disp,
>> +		       maddr);
>>   
>>   		if (IS_ERR_VALUE(maddr))
>>   			return (int) maddr;
>> @@ -1146,8 +1149,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
>>   
>>   #else
>>   		if (excess > 0) {
>> -			kdebug("clear[%d] ad=%lx sz=%lx",
>> -			       loop, maddr + phdr->p_filesz, excess);
>> +			kdebug("clear[%d] ad=%llx sz=%lx", loop,
>> +			       (unsigned long long) maddr + phdr->p_filesz,
>> +			       excess);
>>   			if (clear_user((void *) maddr + phdr->p_filesz, excess))
>>   				return -EFAULT;
>>   		}
>> -- 
>> 2.25.1
>>
> 

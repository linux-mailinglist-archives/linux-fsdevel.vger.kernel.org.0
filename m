Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8945F821B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 03:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJHBqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 21:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJHBqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 21:46:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000936292E;
        Fri,  7 Oct 2022 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665193610; x=1696729610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oQxjNLOcMJZGWcwR/V6EOum5AghG2IhHdI8FHMASetQ=;
  b=aOUd2Xdtt+WypifyPR7E7aQjzFpAa/ckBXpEJ04HxdRh/irT9cHvg327
   q+DQW+ic1MSFNFLeQGvK2XAvRxiXM3UikskWj5+ladF3Qqeq7nbwwoSWA
   6MrrSfnu3kpYlEWhw+Ez7mpmkxjR1BDTgohDiCaWgF2ZVkNdWrBAH/9fr
   +V0mne6+O3yi6cYsms0nM3mgzvRoOHNute8PvrkTXFktCSyZasqgGgTnt
   oH0tzWOpE8+W6BvHiOlOAa8Pcdk0VPmSUeKJDGsxTF0zyYGiTwzHNGGjs
   S3KJ1sXQsdKnHWY5oT8+RwR+s7SlRVqxgGIvLmwum74rK5Izw+0P/4yni
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="365826650"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="365826650"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 18:46:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="625358200"
X-IronPort-AV: E=Sophos;i="5.95,168,1661842800"; 
   d="scan'208";a="625358200"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.234.20]) ([10.212.234.20])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 18:46:49 -0700
Message-ID: <f0dbc406-11b4-90f7-52fd-ce79f842c356@linux.intel.com>
Date:   Fri, 7 Oct 2022 18:46:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20190307090146.1874906-1-arnd@arndb.de>
 <20221006222124.aabaemy7ofop7ccz@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20221006222124.aabaemy7ofop7ccz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/6/2022 3:21 PM, Nick Desaulniers wrote:
> On Thu, Mar 07, 2019 at 10:01:36AM +0100, Arnd Bergmann wrote:
>> The select() implementation is carefully tuned to put a sensible amount
>> of data on the stack for holding a copy of the user space fd_set,
>> but not too large to risk overflowing the kernel stack.
>>
>> When building a 32-bit kernel with clang, we need a little more space
>> than with gcc, which often triggers a warning:
>>
>> fs/select.c:619:5: error: stack frame size of 1048 bytes in function 'core_sys_select' [-Werror,-Wframe-larger-than=]
>> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>>
>> I experimentally found that for 32-bit ARM, reducing the maximum
>> stack usage by 64 bytes keeps us reliably under the warning limit
>> again.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   include/linux/poll.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/poll.h b/include/linux/poll.h
>> index 7e0fdcf905d2..1cdc32b1f1b0 100644
>> --- a/include/linux/poll.h
>> +++ b/include/linux/poll.h
>> @@ -16,7 +16,11 @@
>>   extern struct ctl_table epoll_table[]; /* for sysctl */
>>   /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
>>      additional memory. */
>> +#ifdef __clang__
>> +#define MAX_STACK_ALLOC 768
> Hi Arnd,
> Upon a toolchain upgrade for Android, our 32b x86 image used for
> first-party developer VMs started tripping -Wframe-larger-than= again
> (thanks -Werror) which is blocking our ability to upgrade our toolchain.


I wonder if there is a way to disable the warning or increase the 
threshold just for this function. I don't think attribute optimize would 
work, but perhaps some pragma?


-Andi



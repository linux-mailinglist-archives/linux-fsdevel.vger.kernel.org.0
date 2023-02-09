Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E09D690CF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 16:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjBIP2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 10:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBIP2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:28:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF9F38B55;
        Thu,  9 Feb 2023 07:28:10 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.179.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6F2766020B9;
        Thu,  9 Feb 2023 15:28:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675956488;
        bh=cVo2hwJA6ba+zxud5YmocaB8dvaCAIfmsd2BzN8RA7Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=SklvgmPzoikYluoyKD+usYENzjjeV8cXVAMyegngQGFdo8vYGHMhGAtc9g0sPwFVm
         qdwkUAyCCJZlimtbYIKmGcc9y+g7Hdfdhay3/K+sjkynf9SZ15Usn5upd6ScJgwbVF
         bdwKNx8K+4NUKkmv/ULlRig1TAMZKubdwBkf/rPkVM3HXq46LSV+Kl88Oa3MHsK4mP
         WfEJnyD9NWdJJucrIeOw2ZTxlYbBxJAd5EYg9Ad7+bW6pY2W/wMvXedjWU6oNyh5JU
         D0a+4G2OvcIihBvTMIqNXDsGtAM+IXztwbrpsd8XAPW6f7gGjrATBBlquvpI5Lcr9S
         oWXwXk5kSmPbw==
Message-ID: <eea000a2-b237-76f0-186c-6181762e34f1@collabora.com>
Date:   Thu, 9 Feb 2023 20:27:58 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 1/6] userfaultfd: Add UFFD WP Async support
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-2-usama.anjum@collabora.com> <Y+QQLNrhyiVwXI50@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+QQLNrhyiVwXI50@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

Thank you so much for reviewing!

On 2/9/23 2:12 AM, Peter Xu wrote:
> On Thu, Feb 02, 2023 at 04:29:10PM +0500, Muhammad Usama Anjum wrote:
>> Add new WP Async mode (UFFD_FEATURE_WP_ASYNC) which resolves the page
>> faults on its own. It can be used to track that which pages have been
>> written-to from the time the pages were write-protected. It is very
>> efficient way to track the changes as uffd is by nature pte/pmd based.
>>
>> UFFD synchronous WP sends the page faults to the userspace where the
>> pages which have been written-to can be tracked. But it is not efficient.
>> This is why this asynchronous version is being added. After setting the
>> WP Async, the pages which have been written to can be found in the pagemap
>> file or information can be obtained from the PAGEMAP_IOCTL.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v10:
>> - Build fix
>> - Update comments and add error condition to return error from uffd
>>   register if hugetlb pages are present when wp async flag is set
>>
>> Changes in v9:
>> - Correct the fault resolution with code contributed by Peter
>>
>> Changes in v7:
>> - Remove UFFDIO_WRITEPROTECT_MODE_ASYNC_WP and add UFFD_FEATURE_WP_ASYNC
>> - Handle automatic page fault resolution in better way (thanks to Peter)
>>
>> update to wp async
>>
>> uffd wp async
>> ---
>>  fs/userfaultfd.c                 | 20 ++++++++++++++++++--
>>  include/linux/userfaultfd_k.h    | 11 +++++++++++
>>  include/uapi/linux/userfaultfd.h | 10 +++++++++-
>>  mm/memory.c                      | 23 ++++++++++++++++++++---
>>  4 files changed, 58 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index 15a5bf765d43..422f2530c63e 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -1422,10 +1422,15 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>>  			goto out_unlock;
>>  
>>  		/*
>> -		 * Note vmas containing huge pages
>> +		 * Note vmas containing huge pages. Hugetlb isn't supported
>> +		 * with UFFD_FEATURE_WP_ASYNC.
>>  		 */
> 
> Need to set "ret = -EINVAL;" here.  Or..
Will fix in next version.

> 
>> -		if (is_vm_hugetlb_page(cur))
>> +		if (is_vm_hugetlb_page(cur)) {
>> +			if (ctx->features & UFFD_FEATURE_WP_ASYNC)
>> +				goto out_unlock;
> 
> .. it'll return -EBUSY, which does not sound like the right errcode here.
> 
>> +
> 
> Drop this empty line?
> 
>>  			basic_ioctls = true;
>> +		}
>>  
>>  		found = true;
>>  	}
> 
> Other than that looks good, thanks.
Thank you so much! This wouldn't have been possible without your help.

> 

-- 
BR,
Muhammad Usama Anjum

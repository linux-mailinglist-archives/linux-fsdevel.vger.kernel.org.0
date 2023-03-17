Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6788B6BEA92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 15:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCQOBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCQOBb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:01:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F7D298EB;
        Fri, 17 Mar 2023 07:01:27 -0700 (PDT)
Received: from [192.168.82.158] (unknown [118.107.141.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F9D666030B0;
        Fri, 17 Mar 2023 14:01:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679061685;
        bh=X77REsS88D3ZxxFw2rKOswH7CLpZ3lC6XKxvKqJ1z0k=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=DFrv3lbCSKDHa6chTaYRxZDbV/9UXlXZF0yPRbjhkIn2+w/Bz2wrbNQ6u87uCwB1R
         dN6FBz4N9Qkvd+q3MKX9U9lSscGedU5giIl3IHwUtf/4MZ/+0ATFHeYwpAvzZNrvx2
         ii1Kd6vpaPtoSyzMO9rWhe3PgvBYFtIFkHJZCNjfN7tLjbuyu1x5z5lu9DelDa6CQI
         U5DAvKI+RfdgwYZcomChUkZpONLSAuDZwmn9XxRBt/bI9TyefUQJz5fMe8RXftm1Qw
         sBiCTE8n8/pn7bpoI5N5A/rYwVjdjODMX6kmuditkWhaBwLY1LiqRxias1x281/ZM3
         0eqaZFsefWvWA==
Message-ID: <dd90f7ba-8887-29fe-882f-6783c7fb3cf2@collabora.com>
Date:   Fri, 17 Mar 2023 19:00:53 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 1/7] userfaultfd: Add UFFD WP Async support
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-2-usama.anjum@collabora.com> <ZBNr4nohj/Tw4Zhw@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZBNr4nohj/Tw4Zhw@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks you for sending. I'll perform testing and share results next.

On 3/17/23 12:20 AM, Peter Xu wrote:
> Hello, Muhammad,
> 
> On Thu, Mar 09, 2023 at 06:57:12PM +0500, Muhammad Usama Anjum wrote:
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
> 
> Here's the patch that can enable WP_ASYNC for all kinds of memories (as I
> promised..).  Currently I only tested btrfs (besides the common three)
> which is the major fs I use locally, but I guess it'll also enable the rest
> no matter what's underneath, just like soft-dirty.
> 
> As I mentioned, I just feel it very unfortunate to have a lot of suffixes
> for the UFFD_FEATURE_* on types of memory, and I hope we get rid of it for
> this WP_ASYNC from the start because the workflow should really be similar
> to anon/shmem handling for most of the rest, just a few tweaks here and
> there.
> 
> I had a feeling that some type of special VMA will work weirdly, but let's
> see.. so far I don't come up with any.
> 
> If the patch looks fine to you, please consider replace this patch with
> patch 1 of mine where I attached.  Then patch 1 can be reviewed alongside
> with your series.
> 
> Logically patch 1 can be reviewed separately too, because it works
> perfectly afaiu without the atomic version of pagemap already.  But on my
> side I don't think it justifies anything really matters, so unless someone
> thinks it a good idea to post / review / merge it separately, you can keep
> that with your new pagemap ioctl.
> 
> Patch 2 is only for your reference.  It's not for merging quality so please
> don't put it into your series.  I do plan to cleanup the userfaultfd
> selftests in the near future first (when I wrote this I am more eager to do
> so..).  I also think your final pagemap test cases can cover quite a bit.
> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum

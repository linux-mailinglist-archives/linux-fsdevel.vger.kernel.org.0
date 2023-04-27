Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4806E6F086A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbjD0PcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjD0Pb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:31:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099A44A5;
        Thu, 27 Apr 2023 08:31:56 -0700 (PDT)
Received: from [192.168.10.39] (unknown [39.37.187.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 10DEC66032AF;
        Thu, 27 Apr 2023 16:31:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682609514;
        bh=KoGFNi6Ux69ouLblk9JDPK/y+Lhn3C/lc39znm8aab4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=H6cVRF1lvmwSwmk7zlIoJjYhmY1v+mYohV9Y854Q2jQL8NUb27m1q8K5acNVKPuy4
         AIvo0YPKiRlsvUyT5EX9vnmX5HAdWy2iGnrm4amCKF+PWTc+YIfEq3WZhYw6hg2+gW
         klotyXDcR49jf1bJVqBx1ECqHh8I8ElPdxvGwIbD2axDO2LK+wXhNwcborn0xz8McU
         8UQp2eEqEt6jF2O4uApndjUxmOVJxm14mclEibkBXr+sRbOTFL8FNEzDapWVxI2Jo0
         JgIMUL8n5/nxS8S5rvohe5JZhU7smKMef4TXFs/lAGtsmb2cLjRlIndsEkf+ZX4ZhZ
         JyFsBgW2EOs0w==
Message-ID: <abb83033-c4b7-e417-5398-a32428d25956@collabora.com>
Date:   Thu, 27 Apr 2023 20:31:43 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH RESEND v15 2/5] fs/proc/task_mmu: Implement IOCTL to get
 and optionally clear info about PTEs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230420060156.895881-1-usama.anjum@collabora.com>
 <20230420060156.895881-3-usama.anjum@collabora.com>
 <fd9ddd43-6737-88bd-4054-3d5b94534271@collabora.com> <ZEkxh6dbnAOuYuJj@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZEkxh6dbnAOuYuJj@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Peter,

Thank you for your reply.

On 4/26/23 7:13 PM, Peter Xu wrote:
> Hi, Muhammad,
> 
> On Wed, Apr 26, 2023 at 12:06:23PM +0500, Muhammad Usama Anjum wrote:
>> On 4/20/23 11:01 AM, Muhammad Usama Anjum wrote:
>>> +/* Supported flags */
>>> +#define PM_SCAN_OP_GET	(1 << 0)
>>> +#define PM_SCAN_OP_WP	(1 << 1)
>> We have only these flag options available in PAGEMAP_SCAN IOCTL.
>> PM_SCAN_OP_GET must always be specified for this IOCTL. PM_SCAN_OP_WP can
>> be specified as need. But PM_SCAN_OP_WP cannot be specified without
>> PM_SCAN_OP_GET. (This was removed after you had asked me to not duplicate
>> functionality which can be achieved by UFFDIO_WRITEPROTECT.)
>>
>> 1) PM_SCAN_OP_GET | PM_SCAN_OP_WP
>> vs
>> 2) UFFDIO_WRITEPROTECT
>>
>> After removing the usage of uffd_wp_range() from PAGEMAP_SCAN IOCTL, we are
>> getting really good performance which is comparable just like we are
>> depending on SOFT_DIRTY flags in the PTE. But when we want to perform wp,
>> PM_SCAN_OP_GET | PM_SCAN_OP_WP is more desirable than UFFDIO_WRITEPROTECT
>> performance and behavior wise.
>>
>> I've got the results from someone else that UFFDIO_WRITEPROTECT block
>> pagefaults somehow which PAGEMAP_IOCTL doesn't. I still need to verify this
>> as I don't have tests comparing them one-to-one.
>>
>> What are your thoughts about it? Have you thought about making
>> UFFDIO_WRITEPROTECT perform better?
>>
>> I'm sorry to mention the word "performance" here. Actually we want better
>> performance to emulate Windows syscall. That is why we are adding this
>> functionality. So either we need to see what can be improved in
>> UFFDIO_WRITEPROTECT or can I please add only PM_SCAN_OP_WP back in
>> pagemap_ioctl?
> 
> I'm fine if you want to add it back if it works for you.  Though before
> that, could you remind me why there can be a difference on performance?
The only difference can be that UFFDIO_WRITEPROTECT acquires read mm lock
once for entire duration. But for PAGEMAP_SCAN IOCTL, we acquire and
release for each PMD to keep intermediate buffer short.

This must be hard to convince you. So I'll write some test to see what is
the exact difference and show you the numbers.

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum

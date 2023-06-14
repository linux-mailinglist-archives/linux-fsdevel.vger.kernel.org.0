Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727272FCA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbjFNLhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbjFNLgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:36:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831472130;
        Wed, 14 Jun 2023 04:36:44 -0700 (PDT)
Received: from [192.168.10.55] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B57E6606F13;
        Wed, 14 Jun 2023 12:36:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686742603;
        bh=ddEWiutTf5joaQDtbE1zvdeXJT8abQOVdmfhIERBMqU=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=oZMTqtmKEycWY8eSGCy8a1JQ9ZSyl+CEMkboLQegfOkJHqo4Y/XOvr3E1CUiNYZvc
         FBfUbyTWsZNK7+3q4tGbae2ibwAg52ED0Umao5LSbFW51MSSrewZvyuUFQBJ7s3o/Q
         9LqazNLBNndgAEwbpuFroO0BZerTYSn5uQSRMd0cvkukk1uvepe07sqwBUYgeg//Am
         Fq8eDR73Vi9K2Vw1baOAI3ECSTGwfNBYcG8bx5e+K1+buctKI6kkNPqQ2eNl36P5RQ
         XCm3NE6oxIEA3V3v9ZEwW8WCKjoPJxX2dNxe3zKTECP30NLrkuZ6oo+6i+lVo5PBy1
         MgAXIrnlrN2Bw==
Message-ID: <28c141df-16d7-80d7-b1f4-2dcd432b1cd7@collabora.com>
Date:   Wed, 14 Jun 2023 16:36:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
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
Subject: Re: [PATCH v18 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
References: <20230613102905.2808371-1-usama.anjum@collabora.com>
 <20230613102905.2808371-3-usama.anjum@collabora.com>
 <dacfde0b-bc72-dae7-e823-7905f27ff296@infradead.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <dacfde0b-bc72-dae7-e823-7905f27ff296@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/23 9:09 AM, Randy Dunlap wrote:
> 
> 
> On 6/13/23 03:29, Muhammad Usama Anjum wrote:
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index b7b56871029c..47879c38ce2f 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -305,4 +305,57 @@ typedef int __bitwise __kernel_rwf_t;
>>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>>  			 RWF_APPEND)
>>  
>> +/* Pagemap ioctl */
>> +#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
> 
> Please update Documentation/userspace-api/ioctl/ioctl-number.rst also.
I've just checked this file and found out that the range is already
correctly mentioned:

'f'   00-0F  linux/fs.h                                        conflict!


> 
> thanks.

-- 
BR,
Muhammad Usama Anjum

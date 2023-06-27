Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC27403F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjF0TUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 15:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjF0TUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:20:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590AE6C;
        Tue, 27 Jun 2023 12:20:29 -0700 (PDT)
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C722C6602B7B;
        Tue, 27 Jun 2023 20:20:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687893628;
        bh=F15IKQFG8u9IA2svUTjlj+/hsiBSNLiVRfc6Ea4qK5Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=LOFsHOBX4U4Uy7UEUZWZ9MD/sgEEQnXUPJ+PgInwntLBz8NCYLV2NWdKQC6xJSN9t
         5PMAm0JXmkf5t+AuNrzjesiNU0aV8cXovWxXYwIo9CdyBjX2SF+SsDzHt7FQD6pdnq
         AyB4LtU3+GIGkwCpiWzVppiq+uUONypRnev2BLiFqwftfArFrV0c+va3i+VamrQceM
         5PDZmAJUNG5ULcVU52WtGNB4O/sW9hbubxcey/dBnPc0TB2COuFDtfrnh0AoDm1wWF
         Z0Z/OPHd41D5S6/n7POqDERCDuvHs4R9ym079MJE6BQZglz28kGtEBN70vs2HGRj7s
         wyzaL6AVZZnLg==
Message-ID: <6ac9c60e-0a6b-110a-cace-97afbd9708a0@collabora.com>
Date:   Wed, 28 Jun 2023 00:20:16 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v21 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>
References: <20230626113156.1274521-1-usama.anjum@collabora.com>
 <20230626113156.1274521-3-usama.anjum@collabora.com>
 <ZJo/gOnTmwEQPLF8@gmail.com>
 <13ea54c0-25a3-285c-f47e-d6da11c91795@collabora.com>
 <CABb0KFGn=3oAYa+wsf=iWr1Ss=en9+m11JOijEibXJLFDAkvjQ@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGn=3oAYa+wsf=iWr1Ss=en9+m11JOijEibXJLFDAkvjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Michał for replying.

On 6/27/23 11:52 PM, Michał Mirosław wrote:
> On Tue, 27 Jun 2023 at 11:00, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hi Andrei and Michal,
>>
>> Lets resolve last two points. Please reply below.
>>
>> On 6/27/23 6:46 AM, Andrei Vagin wrote:
> [...]
>>> And we need to report an address where it stopped scanning.
>>> We can do that by adding zero length vector.
>> I don't want to do multiplexing the ending address in vec. Can we add
>> end_addr variable in struct pm_scan_arg to always return the ending address?
>>
>> struct pm_scan_arg {
>>         ...
>>         _u64 end_addr;
>> };
> 
> The idea to emit a zero-length entry for the end looks nice. This has
> the disadvantage that we'd need to either reserve one entry for the
> ending marker or stop the walk after the last entry is no longer
> matching.
This is ambiguous.

> 
> Another solution would be to rewrite 'start' and 'len'. The caller
> would be forced to use non-const `pm_scan_arg`, but I expect the `vec`
> pointer would normally be written anyway (unless using only a
> statically-allocated buffer).
> Also, if the 'len' is replaced with 'end' that would make the ioctl
> easily restartable (just call again if start != end).
Nice idea. But returning ending address in len seems a bit strange.

pm_scan_arg already has 11 members. Wouldn't it be okay to add one more? It
would be straight forward as well.

If nobody replies until tomorrow, I'll start returning ending address in len.


> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum

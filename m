Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD1763029
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjGZIpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjGZIob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:44:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1F6EA0;
        Wed, 26 Jul 2023 01:34:36 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A24F6606FCD;
        Wed, 26 Jul 2023 09:34:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690360474;
        bh=kbyHAewU6qDnSTSEyCglZNTxAWdvBGgIOe5Sk6F5sTk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=h9vI4xVfSTcEGbDHFnNp1CkGPb9ffa35OppZjK5mAmcVidyByB2rlTvL5Zkh7i8oO
         rNof11swMdDQ6XoZmgXX9hkBQELBwhGG98hwt9vvJnulV1RvhlgTcqn1btp9/t5u6O
         T7cHg9go9dgQa+c7vZTN3miRAntkp2ZZYsnIkGMMMIaRy+kdpvj+aBCiOfFidy3kB+
         yVnR/o1QbDrw05pt0FqkJ/LRMk3KT8T1mauAs1bdfW/Nl8beRFvqFMbe9LV0ghm3Qb
         RxLsslpnJtnsWF2tWh7eU+vg4oVbzPSvp6OfMZRRcEYNpeNh9cJNWPwzQWntK2bjvF
         v4VrM6r9ucckQ==
Message-ID: <f949f74f-bb65-e3f2-e70d-7198446a9981@collabora.com>
Date:   Wed, 26 Jul 2023 13:34:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
 <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com>
 <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
 <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com>
 <CABb0KFHJVeEkh4f6WWK6FThCbA+NE8iYUZE68nV1YAxaHwiwog@mail.gmail.com>
 <e1ead2e8-046a-31d9-8df9-27cdd7b7ff83@collabora.com>
 <1afedab8-5929-61e5-b0da-9c70dc01c254@collabora.com>
 <eac29a4d-aa3f-4df5-97e6-4aa3a358f2b1@collabora.com>
 <CABb0KFHuNpG+NJQ4sQdp1n_Kf4sO8aC5DBEppFc1zz=zAeDfQw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFHuNpG+NJQ4sQdp1n_Kf4sO8aC5DBEppFc1zz=zAeDfQw@mail.gmail.com>
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

On 7/25/23 11:05 PM, Michał Mirosław wrote:
> On Tue, 25 Jul 2023 at 11:11, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> ----
>> Michal please post your thoughts before I post this as v26.
>> ----
> [...]
> 
> Looks ok - minor things below.
> 
> 1. I'd change the _WPASYNC things to something better, if this can
> also work with "normal" UFFD WP.
Yeah, but we don't have any use case where UFFD WP is required. It can be
easily added later when user case arrives. Also UFFD WP sends messages to
userspace. User can easily do the bookkeeping in userspace as performance
isn't a concern there.

> 
> 2. For the address tagging part I'd prefer someone who knows how this
> is used take a look. We're ignoring the tag (but clear it on return in
> ->start) - so it doesn't matter for the ioctl() itself.
I've added Kirill if he can give his thoughts about tagged memory.

Right now we are removing the tags from all 3 pointers (start, end, vec)
before using the pointers on kernel side. But we are overwriting and
writing the walk ending address in start which user can read/use.

I think we shouldn't over-write the start (and its tag) and instead return
the ending walk address in new variable, walk_end.

> 
> 3. BTW, One of the uses is the GetWriteWatch and I wonder how it
> behaves on HugeTLB (MEM_LARGE_PAGES allocation)? Shouldn't it return a
> list of huge pages and write *lpdwGranularity = HPAGE_SIZE?
Wine/Proton doesn't used hugetlb by default. Hugetlb isn't enabled by
default on Debian as well. For GetWriteWatch() we don't care about the
hugetlb at all. We have added hugetlb's implementation to complete the
feature and leave out something.

Also GetWriteWatch() implementation wouldn't require THP support as well
because you start to get 2MB of memory dirty even when only 4kB of memory
shouldn't have been dirty.

> 
> 4. The docs and commit messages need some rewording due to the changes
> in the API.
Yeah, I've updated the doc. I'll update the commit message as well.

> 
> Other than that:
> 
> Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

-- 
BR,
Muhammad Usama Anjum

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57A7659CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 19:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjG0RPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjG0RPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:15:35 -0400
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392453A89;
        Thu, 27 Jul 2023 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=s1; h=From:Cc:To:Subject:Date:Message-ID:Sender;
        bh=qDGyNuZm1SlXvpHYjVnont8zJnpqBv3isL90u1ngU/Q=; b=eBXhTsEZvHyz459/k9nNsc+Ulj
        zsL16vMgaqJ18maqGw1TS+RsXBgyXVShSA335XoxyuV6e5Kw5UfGaAuN1Cl3PSi+bi+AqIqm8ziNd
        akly2EihEuPQ8MqrgTYkkpiPr5i2sx6WMFQj3d/elQR7eBafo0SZnIFPSFr+blNBZBR40gwfVOrWQ
        jkHCfYjX+cML0EEgKWVa7pFYDApTKP8hGiqnL6hWXM+02xPEp+6WjmxOzqsuHxHWhDa8131odgChs
        Dkhjdn7bZgqldhIznacSS/1YJcDd4f2yRZVkWThhNlPoGpmcNN3+djoaepg+lkJU/2XRd+ZGFYqq6
        MjGxkbGg==;
Received: from cw141ip123.vpn.codeweavers.com ([10.69.141.123])
        by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pgofman@codeweavers.com>)
        id 1qP4aA-006l8N-1D; Thu, 27 Jul 2023 12:15:22 -0500
Message-ID: <a1e43d96-ad15-961c-7005-43d1f714408f@codeweavers.com>
Date:   Thu, 27 Jul 2023 11:15:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
References: <20230713101415.108875-6-usama.anjum@collabora.com>
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
 <f949f74f-bb65-e3f2-e70d-7198446a9981@collabora.com>
 <CABb0KFGQ_HbD+MNwKCcE+6D50XhJxpx0M0dRiC-EVwEXPv+4XA@mail.gmail.com>
 <94c6b665-bbc2-5030-f9b1-d933791008b8@codeweavers.com>
 <CABb0KFEr_CDZyvZ27q2b7DbXwW3h+hNLjjzBw1GzzkZW=j-Dow@mail.gmail.com>
Content-Language: en-GB
From:   Paul Gofman <pgofman@codeweavers.com>
In-Reply-To: <CABb0KFEr_CDZyvZ27q2b7DbXwW3h+hNLjjzBw1GzzkZW=j-Dow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Windows GetWriteWatch won't work if the range is not withing a single 
memory view regardless of MEM_LARGE_PAGES (that is, single VirtualAlloc 
result, somewhat analogous to VMA but not quite), such a call will 
result in an error.

For the context, Windows never auto splits or joins memory views, and 
basically nothing can be done across views boundary (merging placeholder 
views is an exception, while unrelated). VirtualProtect (which stands 
for mprotect) can be done for individual pages withing the view of 
course, but it is purely per page and doesn't affect view protection 
flags or result in any splitting of those. VirtualProtect across views 
adjacent in memory will also fail.

On 7/27/23 05:18, Michał Mirosław wrote:
>
> Is it possible (on Windows) to have MEM_LARGE_PAGES allocation near a
> normal one and run GetWriteWatch() on both in one call? If so, how
> does it behave / what is expected?
>
> Best Regards
> Michał Mirosław



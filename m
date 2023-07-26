Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B276427E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 01:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGZXX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 19:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGZXX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:23:27 -0400
X-Greylist: delayed 1023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 16:23:25 PDT
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49F19BA;
        Wed, 26 Jul 2023 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=s1; h=From:Cc:To:Subject:Date:Message-ID:Sender;
        bh=TzAjea2nGNOKcL40wex2xg6v2cKZ58dDAwDQ7iciIm4=; b=f0zt7pMLMdwTX2ta0nfexztCNV
        HHSlhUIacV52g6Gm/BaxdE3SMrwORdOn5s+8WObEEgzbC5Yag7Rt5w51QdFXF5BQ2xQ+kE8pzPJHB
        uyQDsCgOGOl3r278g3GDzjHAqe8AiV95iGzS6tgoB3mrXdg5CM+GgyjdqteS04HxHAnxMTTiX5kKP
        SBg2HaSWD/1ufvrzD23UAqTfw4OAVyFh5EvqH+OguUd0YQ6qxaTTnn4VDuMXN1xyxToxZK61kVwPM
        YQ21CzfWqTRP/lL9yJp3jtuxRCI7cBUOfCLhf2L3xMxqYH1Q0i4lczsT/GPf068f+FrxpXbFVX+Bq
        /Nk4kViA==;
Received: from cw141ip123.vpn.codeweavers.com ([10.69.141.123])
        by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pgofman@codeweavers.com>)
        id 1qOna7-005Zuy-A7; Wed, 26 Jul 2023 18:06:11 -0500
Message-ID: <94c6b665-bbc2-5030-f9b1-d933791008b8@codeweavers.com>
Date:   Wed, 26 Jul 2023 17:06:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
 <f949f74f-bb65-e3f2-e70d-7198446a9981@collabora.com>
 <CABb0KFGQ_HbD+MNwKCcE+6D50XhJxpx0M0dRiC-EVwEXPv+4XA@mail.gmail.com>
Content-Language: en-GB
From:   Paul Gofman <pgofman@codeweavers.com>
In-Reply-To: <CABb0KFGQ_HbD+MNwKCcE+6D50XhJxpx0M0dRiC-EVwEXPv+4XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Michał,

     I was looking into that from the Wine point of view and did a bit 
of testing, so will try to answer the question cited below.

     Without Windows large pages I guess the only way to make this work 
correctly is to disable THP with madvise(MADV_NOHUGEPAGE) on the memory 
ranges allocated with MEM_WRITE_WATCH, as the memory changes should not 
only be reported but also tracked with 4k page granularity as Windows 
applications expect.

     Currently we don't implement MEM_LARGE_PAGES flag support in Wine 
(while of course might want to do that in the future). On Windows using 
this flag requires special permissions and implies more than just using 
huge pages under the hood but also, in particular, locking pages in 
memory. I'd expect that support to be extended in Windows though in the 
future in some way. WRT write watches, the range is watched with large 
page granularity. GetWriteWatch lpdwGranularity output parameter returns 
the value of "large page minimum" (returned by GetLargePageMinimum) and 
the returned addresses correspond to those large pages. I suppose to 
implement that on top of Linux huge pages we'd need a way to control 
huge pages allocation at the first place, i. e., a way to enforce the 
specified size for the huge pages for the memory ranged being mapped. 
Without that I am afraid the only way to correctly implement that is to 
still disable THP on the range and only adjust our API output so that 
matches expected.

     Not related to the question, but without any relation to Wine and 
Windows API current way of dealing with THP in the API design looks a 
bit not straightforward to me. In a sense that transparent huge pages 
will appear not so transparent when it comes to dirty pages tracking. If 
I understand correctly, the application which allocated a reasonably big 
memory area and didn't use madvise(MADV_NOHUGEPAGE) might end up with a 
whole range being a single page and getting dirtified as a whole, which 
may likely void app's optimization based on changed memory tracking. Not 
that I know an ideal way out of this, maybe it is a matter of having THP 
disabled by default on watched ranges or clearly warning about this 
caveat in documentation?

Regards,
     Paul.


On 7/26/23 15:10, Michał Mirosław wrote:
>
>>> 3. BTW, One of the uses is the GetWriteWatch and I wonder how it
>>> behaves on HugeTLB (MEM_LARGE_PAGES allocation)? Shouldn't it return a
>>> list of huge pages and write *lpdwGranularity = HPAGE_SIZE?
>> Wine/Proton doesn't used hugetlb by default. Hugetlb isn't enabled by
>> default on Debian as well. For GetWriteWatch() we don't care about the
>> hugetlb at all. We have added hugetlb's implementation to complete the
>> feature and leave out something.
> How is GetWriteWatch() working when passed a VirtualAlloc(...,
> MEM_LARGE_PAGES|MEM_WRITE_WATCH...)-allocated range? Does it still
> report 4K pages?
> This is only a problem when using max_pages: a hugetlb range might
> need counting and reporting huge pages and not 4K parts.
>
> Best Regards
> Michał Mirosław



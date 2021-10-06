Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5642386E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhJFG7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 02:59:36 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:37153
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237213AbhJFG7f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:59:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7r6wQSySwYCW8gyGYiKlySx3qk3bH5p5re5XHKT+y8eyXHhlzEVlZ3dlQQcdueErgx7O2szGZkEXq/QZ/+MkVrp/9ePvUXRtQgFFn9F3Bs9lKxMcLeFLNBNU16yD1TQHhubJidR9VzaXuare23chtLVkmLs4cutkqjwNp1q0D9SI9kdTP+ZE1R8P2DGBq8ZGI6WShauC+mWS3MZeu70r0fW3cR3h28eaUKWriaxGz+LdfuLP9K1bXU6nZq+tW8vqKcNTFmxU/g6X2CqqH1oGQN2X9DwJ211zz007WfuvjO12GLOY6xSMRfpsDfgCwIjiBLkrU5E21EYe5NVbrMNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tZP5Yy+bc1C0LdPnCi1kwsMyjPBwX7RnaE/mghBbyA=;
 b=LTC6nZS0RNtbu+0kxn5cni9cFKOY0DUVHHHUjaC33QZE+r3CywmKe5dWt0m28cfvmpONVsUUAXmnM0/GVe+BsvJS05Hco/tcRcHWQdwCm8rVaRNMZ5q1vmcMrXRhFkZkMziBEOfdCToJm3MF1IMDLGjgat2oDQS04muMvug3VvypNKXnhCngJCdqNhFvdLe1SX5ls5C5I9Y++7CClt+YhXu77U9wIA3w4hsJdMtidmJgbuP3oS4yLtKU5qbpDYlxD7bF0RyOPVRoHv5JVxbnQjXzBmQRrp2j8vLg8EDuZWRa6YL8SNlemQtpYMyFkF/dYjmyNHyPRtZOnVQJbgNLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tZP5Yy+bc1C0LdPnCi1kwsMyjPBwX7RnaE/mghBbyA=;
 b=b/Y3a+O8+W8n/ujBfpihX5NliXmTSA8GNxxxJN+2Pck7K1k7yZrD7tLNyopAyvJkhGyaLRIvuEdrYkj2sa562wIXguT2S8wdieaKMm7YGJxp11Ks7PlQc8PAhRPP9TDGp0aOBCjpixatvyOWaJ1MJuuB2/YALYtzoDlP37CptTUUufpyA1XXZeZxp9qwmi0z7TyaM5YSzbl1sKATuA6a3E4cmzp3lpBeG/dYBXpLl6hwy8GMaMed96AqRY5qwDYLb709qMsNucdvFD2ZDeANhAuJp47PDRAtph2tqZmEHM5XdDcc+Kh31tfbg25j9OKYfftLwimWvZo1j4+c9xMG8w==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3892.namprd12.prod.outlook.com (2603:10b6:a03:1a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Wed, 6 Oct
 2021 06:57:38 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 06:57:38 +0000
Message-ID: <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
Date:   Tue, 5 Oct 2021 23:57:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20211001205657.815551-1-surenb@google.com>
 <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz>
 <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz>
 <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.28] (216.228.112.21) by SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 06:57:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db3033f1-2932-4aec-3942-08d988969539
X-MS-TrafficTypeDiagnostic: BY5PR12MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3892C8D54AFF91D94254FD30A8B09@BY5PR12MB3892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkXlt9oOHCmQ8o1RZJNMYjPrKwqI+6tdnNKuSpT4/mVGYDtoYROUJ6JfpLmwH/jTFNEFgLv05Gv4Xu6tgAfTAlweMD7p4MSxB1xLy4nMvsfEm0uEHNe+ylR+at1cbAOT2gxB3YqYmIpspfWPFw+1Mcv0kruJn8gl8VOFfnuMSq/Q4RgXqaMiUKA9ebmqE7T0K8kWaeFXvjY7HQ7oOwTSHC1XOZE5p5UWZ4pCCMOhzKIGNcTFBRWn3yTFEcMOZ49egQbpUngsjKfOWvGjLgwhZjdH+x0sMYnizsBGNDK0Jc/7MtQ1ILSxO2wsom7PBFCEjNXw1ethBPmlOVx/1WR9/ERkHlA7yvVRmoLx1SJiQqMjKQ3Xi6PzxqxRls75Tfph1ajlEGUjgriqgi/p2N/juUQRh0Lat2odBmJ6bBPsTdj5nSwOnCzTtmmt4Wdb6oI5q600mJ68uenaE8RwMxmWRAvZOtbR+9zUgOqLRo5gyBqDcqfDLIINUS56QX5pm8HFyBONE2fq3ow3R3RHZuXLnSz2o33xTsRfoSXnUCDaj9qRnATal0uRc64H7EbpZb1viH1S7Ta4awWOz3AYeV5jDkQ8qlBQaUl5TVZ+tc6SuP57CqY/WXfRYQuIkJONDvteKUL2c+YkuZB55hoGP9Kr9gAds9dMoumgxxKEcLoN9Cbwcwimii73B2BPigbpPyFQxgB5xSAPkLJZQgoJ1PYAiSjBRfzhPTXghZBZu2BM7PgJOHwevzRGJSI1kccNAW7Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2616005)(186003)(5660300002)(26005)(31696002)(956004)(4326008)(8676002)(16576012)(83380400001)(316002)(66556008)(66476007)(66946007)(8936002)(31686004)(6486002)(7406005)(7366002)(7416002)(38100700002)(54906003)(110136005)(36756003)(2906002)(53546011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US8xbFVqbFJXZW9tMjNMK1M4TkM0MHdvUmxLenpOUUZRYmRYc1U2ekZNaGY0?=
 =?utf-8?B?NWo5bmdyT1hoZ1B4Z3AraTYvWmhTVTU5bmJ3QW1yNzJST3M0dU9xaFlaWjMv?=
 =?utf-8?B?dHNGaGFGN3A1QnE1L2I3TTZRUHB4RDB5YXJHVXZUVGxiTmtQTUpjNC9jS1B2?=
 =?utf-8?B?MTh0SHJYR2FjemRyWkJBQXJtV2ZoMjlOa3Y3Q0w4dFhvMWVYSXlGNGs1alJy?=
 =?utf-8?B?TU1uVTcydWVzTHJVWEd4SjBRdmRnSG50bFRjeHgzeE5BRmFNdTQvRXRYTm9O?=
 =?utf-8?B?cEtCTjczSklyd0JLS0JCcm5ub2NUdGxDdk14V3kzVlJ1Wk9sZVE5ZkVzc1Nn?=
 =?utf-8?B?UVIvUFhvQUNndkcxbmxwZ3c3U1NHTGFyYUFjMFZELzFZRkRtWTM2eTVzOXEw?=
 =?utf-8?B?OHNrOGJHZ0Fib1FkQ3BoZTc5R1NWRzhpOWhwd2czUUs0dkk2YVZiMGFpNmd6?=
 =?utf-8?B?WGxJbHQwUmdvUnQwZFhjb0FRUUNLQ09HdlYrR1JuWjJyTHd2NVhMOTB4VmRp?=
 =?utf-8?B?YjZKdE8yR1VuMW1Sa2VLZVNEY005djNNWDBydGVmVU1rNnNMSkZheG1JOERp?=
 =?utf-8?B?SURBYlZDRE1WOHMvM3VkOTU0OEozdThPZXJBcmRRWHdPS1pkM29FK0lIamtx?=
 =?utf-8?B?dFMyTDhGRkFHZ2hZQ1cvS1JTRlhORkU4R2ZYSDhaellVcWZNQnpHL0xsT2Yx?=
 =?utf-8?B?OFpOVUFob0hKYksxZDgxdEFpZGJPT1lZMUpmMVpveStzbW9sWFdWVXIycVpE?=
 =?utf-8?B?R09wOWZkaVlKTk9RZjlPUVl4TU9FRUEzOWRKd1F6VWV4MEgvS3FIWWh4WGdY?=
 =?utf-8?B?Z1VlQmEvV09wK0MyZG1Uc3pLZlBwYzUwbkhaRkloaUFMZzNDZEs2MllLYnpB?=
 =?utf-8?B?WHFQdnlmTzVFVEwxSE9Wa0RteERmT3NRTi9hSEdDa3Yxc1ZKRXRCbUk1aWN1?=
 =?utf-8?B?bzFqcCtlTVVUUWpjN1Y4UFVBSVlad3hrblBmdEZzQXRwSHJGOGExZFl2ZWlR?=
 =?utf-8?B?aDl5WXVrRzF6UkROZVdyNnJNVkEvam5wS2dPOTNHTVFJOHZZQ0xYSExnc2Uz?=
 =?utf-8?B?NGhGM0MyQ1pnTkhHK1A2bzdWZEt4R3RBcTlGOXUrS2s2M1o1MkUrd1M1UkM2?=
 =?utf-8?B?eU4ydTdUeU8rVnA2cU9zSzNMa282aEFRNncxbmF2VDhIejdLUmZPVTZqWUlE?=
 =?utf-8?B?cldWUGJKMEVZMXl0WmVjRU1ua2wvb0FmOGtJcUhTM3dFM3ErZWpadExCSElU?=
 =?utf-8?B?Y252WnkwY1ZjVzloTnRqOXRTV2hiYlNLajdTcDZSZFdyWXloQ0M1TmNWUWQy?=
 =?utf-8?B?VXdqZk0xWG12T3RyOHVDY0JwRHp0aVRBajJuWUw5b2ZtTFBMNWFUdlZGY0Qy?=
 =?utf-8?B?MENQeXB2Y2JNSGRhNDFxbVo5RTAzTllxZEt1Z3dsMGlzQXlQMXpRcGlhQmhH?=
 =?utf-8?B?MDdsY3M5S094NlFVQjVVQVBNY1IyQlNRb0VUclZiZFZoK0pVMDZqUjU5ZVl0?=
 =?utf-8?B?ajVKQUQyNVNFZU9TQU1saHNkTHp5d20wcGw2S0ZNcEVqenp5TjhiVktoVUx5?=
 =?utf-8?B?UUY1azU4Rk55djg0aitQajNXNmR5aW1PWFo4ZjcySEpvbE5zaWlkRUZwb2pZ?=
 =?utf-8?B?S2xHZjFNZU93akM1QUJoK2NnN0ZkdzRGMHR0MGY2TFZDZjFaQXdOcDFRZ2Z5?=
 =?utf-8?B?cjRTaGlNcHE1NzZQdzNOZURpZkF2SU1nYzNRUjRPdTdKMHhXTytqeXlSMFE5?=
 =?utf-8?Q?6ha06RKiMEopbMh/D9kDDcPO1i0xqW22rGFu7vQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3033f1-2932-4aec-3942-08d988969539
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 06:57:38.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VI1xVoW1Z1h7k9WiXdDRTt8OhSk5fIz5ynHqHijzQssadlQgwz/+EDdJkFBZj4FOnT6yTtr8hyrZKcYaGHVJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3892
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/5/21 13:43, Suren Baghdasaryan wrote:
> On Tue, Oct 5, 2021 at 1:04 PM Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Hi!
>>
>>>> On Fri 2021-10-01 13:56:57, Suren Baghdasaryan wrote:
>>>>> While forking a process with high number (64K) of named anonymous vmas the
>>>>> overhead caused by strdup() is noticeable. Experiments with ARM64
>>>> Android
>>>>
>>>> I still believe you should simply use numbers and do the
>>>> numbers->strings mapping in userspace. We should not need to optimize
>>>> strdups in kernel...
>>>
>>> Here are complications with mapping numbers to strings in the userspace:
>>> Approach 1: hardcode number->string in some header file and let all
>>> tools use that mapping. The issue is that whenever that mapping
>>> changes all the tools that are using it (including 3rd party ones)
>>> have to be rebuilt. This is not really maintainable since we don't
>>> control 3rd party tools and even for the ones we control, it will be a
>>> maintenance issue figuring out which version of the tool used which
>>> header file.
>>
>> 1a) Just put it into a file in /etc... Similar to header file but
>> easier...
>>
>>> Approach 2: have a centralized facility (a process or a DB)
>>> maintaining number->string mapping. This would require an additional
>>> request to this facility whenever we want to make a number->string
>>> conversion. Moreover, when we want to name a VMA, we would have to
>>
>> I see it complicates userspace. But that's better than complicating
>> kernel, and I don't know what limits on strings you plan, but
>> considering you'll be outputing the strings in /proc... someone is
>> going to get confused with parsing.
> 
> I'm not a fan of complicating kernel but the proposed approach seems
> simple enough to me. Again this is subjective, so I can't really have
> a good argument here. Maybe, as Andrew suggested, I should keep it
> under a separate config so that whoever does not care about this
> feature pays no price for it?


For what it's worth, I've been watching this feature proposal evolve,
and a couple of things are starting to become clear. These are of
course judgment calls, though, so even though I'm writing them as
"facts", please read them as merely "one developer's opinion and
preference":

1) Yes, just leave the strings in the kernel, that's simple and
it works, and the alternatives don't really help your case nearly
enough. The kernel changes at a different rate than distros and
user space, and keeping number->string mappings updated and correct
is just basically hopeless.

And you've beaten down the perf problems with kref, so it's fine.

2) At the same time, this feature is Just Not Needed! ...usually.
So the config option seems absolutely appropriate.


Even Pavel here will probably be content with the above mix, I
expect. :)


thanks,
-- 
John Hubbard
NVIDIA

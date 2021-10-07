Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E7425B44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 21:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbhJGTE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 15:04:59 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:56673
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233903AbhJGTE6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 15:04:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvagy62so3znFnr8+MTSL+zO0KdcYvT6F6gXoZ+x5Xxa4OxjHjaRPf5VGU+XX0wEbgLWkoXgJOJh5KHNCM2yfOjMaUllm56XRGErcEtF8Dtn+VbU7BPmUpzDR1PTVBuUMo7ktnAYT95ZbHtwgMybsPhDx6jFIeEjmJ0GYUbf75X5KD0Aarc5drhpNzDgqfaaMyiPmD+00AhxU/K8q1RhSaG+tWIIbCjLMhawGqPjYu8QwwJnnJkLjxNhCaYCFVCHZydNqvgztAk3qQ3yO+N5cG5LwMk33TbnrrNzpKBX1elI6MSkf24FbuNjghDzw1Hn0P9UGoYlMHzmcz/IpRXGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxjWqgtDDlrGe7w4H/RNo4If3Jf+Bcry3GECUMQWoLY=;
 b=B8yShhOZIG+Ns0rX4pNW7JuQjlS5tsBw67eWCbUaEtepH+iJV7gRSTahYooYel2wgT575/WVsgq4fDQ7wsPFZ5gvIm7yy8RIc0plAEUtfsHgZveX1IcLBoxXSqgh+eZjbLUiXJANSCLJ1Xhv0qJF2G1jGlcxgWypAiVVvP9Flf1rLTixrSsNB8ygIR9qzoT90ztq21DDAZiVtwFXmfPMBfk5ug6s0M/0BNp6gnChRVa+M+H+V85qknojA9LLXLHT2Lksd4A4VpgtGQzseZwzqQ1rKb5Ku5sJCflT16UgbI+FmrgbygmHMm5FURyjVZzshjew2rsyX4WehWKhJIOHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxjWqgtDDlrGe7w4H/RNo4If3Jf+Bcry3GECUMQWoLY=;
 b=EBfYhijV4bA29kYoeCF4cOsw3Yo1ZbXj3BoJRvU8MMWLYmZ1RRVUFwLEYKXHS6rLb6f7yYWYAIxbHDaj1tZZXHrQzr2FbOzcSUxIo+y1ZTObXRIT1Zn1s/O5HD+gROqPJAThvXZWXKEqVNPOlQ4qsAk3fORSuWk7CrREqXOqqliA70SoLqFTxq1+hbnNpmga3jNLGHbyJ/7HNysrC7+V+bo4swc6/1bpYxxRj9Ism7NKSdbrYNF0ksPj9w9VKvivapi8Tn1OK0VRdutKNAAy+rM1hnk19DQ5gjX1VgmKY4gwxVk2p2SaAx06IoCDhhmb1t6HW9Xlf6M+LcQDqF5XUw==
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB2789.namprd12.prod.outlook.com (2603:10b6:a03:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 19:03:00 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 19:03:00 +0000
Message-ID: <caa830de-ea66-267d-bafa-369a6175251e@nvidia.com>
Date:   Thu, 7 Oct 2021 12:02:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
References: <20211006175821.GA1941@duo.ucw.cz>
 <CAJuCfpGuuXOpdYbt3AsNn+WNbavwuEsDfRMYunh+gajp6hOMAg@mail.gmail.com>
 <YV6rksRHr2iSWR3S@dhcp22.suse.cz>
 <92cbfe3b-f3d1-a8e1-7eb9-bab735e782f6@rasmusvillemoes.dk>
 <20211007101527.GA26288@duo.ucw.cz>
 <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
 <CAJuCfpFT7qcLM0ygjbzgCj1ScPDkZvv0hcvHkc40s9wgoTov7A@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJuCfpFT7qcLM0ygjbzgCj1ScPDkZvv0hcvHkc40s9wgoTov7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.57.28] (216.228.112.21) by SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.5 via Frontend Transport; Thu, 7 Oct 2021 19:02:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d2aa4a-8d08-46bb-91e0-08d989c514b5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27893796371EA86B18C48F8CA8B19@BYAPR12MB2789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcbiA0CAZgJ4kPtzkNha3R57iRxup0FvXsUCUZcxvvhP8W4LvnZXXZS+yx5LOvhMfM9TwBV6voXyyYCSDdym9gXZ3BkNsRDZRhDthB5DaIXnMarJnm4IZfdXbT2ciyaDxeGrmi0w1xgEGxppF9xA9oNoEix9xB6S/tcDDntc8tAu/eFPVESxAug7NyuEFheNl44tJxOecMHNM8LsMDfQphllzPWtrKWwBsqBVNMyLcwh/wsYhhd1i6bhKrL+PhCT2jOf2twHg11ucPhy3jRmlxDfa+epTQQSCxZ0Us3EOOkaXfdWslMvylZ4IdCLJl2xnb8ecCPWbY/3kdBY6BpP3/lGDppLcPY3uxtyNoelV7qNPY3GdjQ52rBfwcDpO+SD0eD1eVCXWqpfWbSqCZfVjw58Yb8Lfk5dGBdkG47wQyQulZ97/f7OLU0CHhUMEXkEFN3Vj15vTVYj7+KjaSd0ryqD0pSG12P5e/+G/MXhDzTlR/RHTD3JQ75uUcyBRz7BPdpeaLZC87jCScv+pVSh1uepa7tRsUG4yPJ6zKGujggsTwpBx9SUqPfiGWszfUcs/z/xFMqpMPrmP5PZ2gKW0dUp8VBWrxlwKPfvHWGoB5ejtesuhpfDjTMny8oMYh9blAyJU0ADMAIB443A3MWdlbaMGJTy60CgscpCb/egq7SZsqGhI4jYFzeHaaA0/rG3hMSlQAZDlqBdagcbw1OZqtDlf3ra4crG6B3M3+gosgBQtU6VFw26FILI3pfHsG54
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(4326008)(316002)(31696002)(54906003)(86362001)(6486002)(2906002)(36756003)(110136005)(8936002)(508600001)(7416002)(7406005)(7366002)(16576012)(53546011)(5660300002)(66946007)(2616005)(66476007)(31686004)(8676002)(38100700002)(26005)(66556008)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUd4bHU0Z1lDTmRzSVdmT1BEaXZkMlQyaWJKRVU1eDJtY3c3V2VpS2JwS0lP?=
 =?utf-8?B?N3U2cnFEeHBoeUgyOGJoaGNiQkVZdEcyOFE5WDhGL0hHNWRPTGFEQXVQcWFl?=
 =?utf-8?B?MC9DVERiOHY1d1BXMVY3N0VSYkpiQWNreHA1dlRBcGRVU3VKNEpQV3k0TWZG?=
 =?utf-8?B?bnhMNjlweTF4SmVUM1R3ZHd5RU5PeTVmM3pJRWVLRVNRbXliZ0Ntdk9CVHNm?=
 =?utf-8?B?T2F6SkVXaFozNTN0eThra1h2aTY0UDMvdi9QSFBiYUtFVi9PYjdCejh3UThG?=
 =?utf-8?B?Q1pDM2F1TGhRVGJlOGp4UEtpV0FZaGVoL0JTNEhUOXd5S0tuc3E3QjROa0NV?=
 =?utf-8?B?Wm1Qb0R5THlzenFkSGJrUnFYRjNIWDBJTGhYQ2NYRVdUVnZFNkhyLzlRUGlt?=
 =?utf-8?B?NzJlTEk5RllmbmtBSnFsNWpkTFZIMThoNk41NnR5N0NPcFZsM1JRcDJwUWN6?=
 =?utf-8?B?MGhieFBmWFlQUjlHczhNWDZzMFR1SVRmT2N3VWN4OEFBckJJRVhYMlpHdy9U?=
 =?utf-8?B?SGxGK3ZtT2R5d2J5enV5czNlUStXczhxVDZGMjhGaXlpOENFK1drL2tHZ3Fk?=
 =?utf-8?B?NTRBS2xIcUQ2Kzd3RExib3lvbG9jNUEweHkzMVFhNnlYRm92VGZrVlpSU09n?=
 =?utf-8?B?THM2aWt0OTJra0h6ck9aYzVXMG5DMDRIZGNwWC9EdFVCQ3hpZXpydklnb2Ru?=
 =?utf-8?B?aGdua3JreEQ1RkZLbnQycUQ1Q01PZURuSklQNjA2Snp2MzlEL045aXRGR0Yx?=
 =?utf-8?B?VDFURU9iWUtMNHNYeUhSM1dFYWVWd2krQitqYm5xWFFkV0x5VTRZcU5Ocmhw?=
 =?utf-8?B?czdQdVdtNjZLMDBidFZsdE5Wc3U2YjBhRCt1Y1FuNHA0M3hpK0pBVnMzVUZk?=
 =?utf-8?B?Y3pQRTVWbE92NGtFUCtGa3JYWXl3MzY4YnZGNUsySERIY1kwQnNDc2hVcU83?=
 =?utf-8?B?UWc2Mm53NG9KSi9iVjJEbG81SmV3Y1pUcXRObUZaMld2VUJacDBiU0pnTHhs?=
 =?utf-8?B?QUdFQTRBdHJuZ29nTUxpQitGNngwWmpWSjZsTXhVWlE4cXhaTHZkWmpIMVBW?=
 =?utf-8?B?S1QwYmttQWxuOFpjcmtOSk5yRGxPb1pIMTJSbkpLSWhhTVNwT2ZpY1daZ0Na?=
 =?utf-8?B?SWJFWUx6bUxXenM5L3dMUWRYUjlReVEwYVNvU1c3QmIvTnZXN2x5ZzRwbEYw?=
 =?utf-8?B?Q3hqMm03MEtGUEVoMm4vMEdWKy9jMkZOR0hEd1NtbWFwejJMcml0bklaYmVx?=
 =?utf-8?B?UFpSbHpmY3hZYURLSlI2R2ltY2hKUzlZazA0djJOdlBFTnVTWjBJZXphUURG?=
 =?utf-8?B?cXBjQlAwU0RUU091eVh2VmI1cTJvd2R0MzFxRkZRWWVhRUhkQlROYWxHUGdj?=
 =?utf-8?B?TFM4UllYZmxTZ2tCdzJ1SnNwNjVzWkRWbXE5Z3ErbjZybllRR25pNnVCR29J?=
 =?utf-8?B?NHUrMExwZmt2WTkzWlJsdHhMUG5acU9uZnZzeTdOK0s1N0ZkVXFtT1JLOE84?=
 =?utf-8?B?dFFXVEx6SGhIK1V5OGFSeTBCK0MvNC9UVXk4c2lJZXM3RWtIMmtteXN4eFNS?=
 =?utf-8?B?QjV0aFlydkxsaUcyTEkzTjc4eVdQQlNRdGNBbXhrcmIzRWM4UzFkdXpiaXYv?=
 =?utf-8?B?dzViWlFLc2NuV0I1NmhrSjFSOWU5d1U4S2lRbm52TDBLWXY5ZVp1dWJtcXJn?=
 =?utf-8?B?Q01zNDMvSk4reVhFR0VUNEtnQXVITW41eGhoN09IWGxmM1BPMDFOdnkweGJX?=
 =?utf-8?Q?5FbkI6/nW7IzSKLWtNos9wSHblqV8J9bQs/iLD3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d2aa4a-8d08-46bb-91e0-08d989c514b5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 19:03:00.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCZlXTJRNJy5myyayzIL3KsF0bdIIAI1YBHRo4OboSbi5iVk69kners7pjEyUbv8S5f/lqOMctEJCSYKTWx9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2789
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/7/21 11:50, Suren Baghdasaryan wrote:
...
>>>>>>>>>> I believe Pavel meant something as simple as
>>>>>>>>>> $ YOUR_FILE=$YOUR_IDS_DIR/my_string_name
>>>>>>>>>> $ touch $YOUR_FILE
>>>>>>>>>> $ stat -c %i $YOUR_FILE
>>>>>>>
>>>>>>> Ah, ok, now I understand the proposal. Thanks for the clarification!
>>>>>>> So, this would use filesystem as a directory for inode->name mappings.
>>>>>>> One rough edge for me is that the consumer would still need to parse
>>>>>>> /proc/$pid/maps and convert [anon:inode] into [anon:name] instead of
>>>>>>> just dumping the content for the user. Would it be acceptable if we
>>>>>>> require the ID provided by prctl() to always be a valid inode and
>>>>>>> show_map_vma() would do the inode-to-filename conversion when
>>>>>>> generating maps/smaps files? I know that inode->dentry is not
>>>>>>> one-to-one mapping but we can simply output the first dentry name.
>>>>>>> WDYT?
>>>>>>
>>>>>> No. You do not want to dictate any particular way of the mapping. The
>>>>>> above is just one way to do that without developing any actual mapping
>>>>>> yourself. You just use a filesystem for that. Kernel doesn't and
>>>>>> shouldn't understand the meaning of those numbers. It has no business in
>>>>>> that.
>>>>>>
>>>>>> In a way this would be pushing policy into the kernel.
>>>>>
>>>>> I can see your point. Any other ideas on how to prevent tools from
>>>>> doing this id-to-name conversion themselves?
>>>>
>>>> I really fail to understand why you really want to prevent them from that.
>>>> Really, the whole thing is just a cookie that kernel maintains for memory
>>>> mappings so that two parties can understand what the meaning of that
>>>> mapping is from a higher level. They both have to agree on the naming
>>>> but the kernel shouldn't dictate any specific convention because the
>>>> kernel _doesn't_ _care_. These things are not really anything actionable
>>>> for the kernel. It is just a metadata.
>>>
>>> The desire is for one of these two parties to be a human who can get
>>> the data and use it as is without additional conversions.
>>> /proc/$pid/maps could report FD numbers instead of pathnames, which
>>> could be converted to pathnames in userspace. However we do not do
>>> that because pathnames are more convenient for humans to identify a
>>> specific resource. Same logic applies here IMHO.
>>
>> Yes, please. It really seems like the folks that are interested in this
>> feature want strings. (I certainly do.) For those not interested in the
>> feature, it sounds like a CONFIG to keep it away would be sufficient.
>> Can we just move forward with that?
> 
> Would love to if others are ok with this.
> 

If this doesn't get accepted, then another way forward would to continue
the ideas above to their logical conclusion, and create a new file system:
vma-fs.  Like debug-fs and other special file systems, similar policy and
motivation. Also protected by a CONFIG option.

Actually this seems at least as natural as the procfs approach, especially
given the nature of these strings, which feel more like dir+file names, than
simple strings.

thanks,
-- 
John Hubbard
NVIDIA

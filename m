Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2845733AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiGMKBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 06:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiGMKBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:01:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F7F5108;
        Wed, 13 Jul 2022 03:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZnh1uxqY7HOwk2h45UhYc246JlrucnzuYiSzxH8Vh/xzvy+lW4forapn355Z75SRz2YSNG3O6sIskGOqWxxakDEeaOkOpaTRJRe0YQkHgGcuE9c/VXyp5gCT/7uXfK6zHsgJ9kXxZgX1rLUSbgJLSfSLCAKqoJBJGkHp+K4xelXktPR7I/iNimhtDwiD9b6PWvXAVOplr4NMCHR+JeMU1jE+uMjbF0way7t+FY5eFMxjm7nivU9uYAD/pnuH9FkmVFRd/T7/lF3PGRRfxoaeyyZN2J7885FcN3jY0Qono9TMYHmViFnXOf2bALjISKSk9vHVOLg5ESo1WuZeR4DUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKkNn4yCn6jWjDZ2AaAoCNnexKJ0ZZixIDCorZhMGYE=;
 b=GQwr5+VFB2oerK1M5RwkDjMwb68OenPMk2d/tlkI/AdXbzpb6Fu/nc0u0bXJtqRDyiNOoEs3xBGqdFY4rBfVOjYH84nqc88inBFKGVA2Qz3O3alUJteF0MhM0FdDIgWzvVit7Ahu//491bGyG3puLkqK/WpmujM1xFt5c09cqzH3lpcFKIlM9YpN/pChwjp44ohG/zOLQD81lp03b7PeJmEO9JLrgtpQH1jWEy+ROOx2hlqMhET+tkOICTpDZY+ZXC/FbhtXnBckAHO94WOcCJgAB2cgjkIFfxArPAJ3kv+RW6ZxWiO/YLbL9ZAk4LfPB5D7Lkk/yNkibK4bJ/EIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKkNn4yCn6jWjDZ2AaAoCNnexKJ0ZZixIDCorZhMGYE=;
 b=ltDZWXhClq1GLwcEgwluN1mPsArFn21a+j6bVwB/nVswdji3gQOXyXD8mnLwEmjNtkADou/Xa2J+/XS2JyGtXpOStJ3Twa4u0rs/+NxgLWkzrEkIvLR3xBr9e8AEHawn2pX1QIJhrm5TjgnvujEcYaUWFNFuJ++rvWYIq1/f/4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by BN7PR12MB2609.namprd12.prod.outlook.com
 (2603:10b6:408:28::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 10:01:31 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Wed, 13 Jul
 2022 10:01:30 +0000
Message-ID: <74097857-1908-2ff2-1e54-bf7e658ea6c6@amd.com>
Date:   Wed, 13 Jul 2022 12:01:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 04/14] mm/shmem: Support memfile_notifier
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-5-chao.p.peng@linux.intel.com>
 <c4112b84-9359-d4c8-1852-0057c074607c@amd.com>
 <20220713074458.GB2831541@chaop.bj.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220713074458.GB2831541@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::15) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 530bae94-740a-49ed-af99-08da64b6a87d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2609:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3XxLXJdQVnd3va2xwDUYYu9RsJUZxL9bKZtVe5xx6wJ7c80kncyBrkqRWrCPz3fDZObZYRG3FsJNR58H61t41RGjqUKd2ZAZiBN0qnhVPHYsBpe3pK8xqA9AjLlrj5cy/XmpEcpQbj6/oZU14ZA0VVf6VK9D/tdBRHI3AXXSICfyd2CPy2p5AgR+YqP7s6qPKYPoqAuFq0J9npHZdSUsygU6zzl2P+n3BQhMHxUPj7ocHj3Va/syFoM7uLwhQJIgIOOhzrcQdJ6suIRjD6AoP+vClYBLSCQmctkHDvkzQh22KcTMS0MDRSpiqwYEC7CDixps20t30560qBYVuNwApyKzT/DRu6fvFn98dpqsSC3t8+KcbbNdR9tk2HbXKgB6zkSHJz9+aQgtFu9pKZoXQz3Bdb9WMxWHwsBN425EeaO+TPU/H1qth99CZRgf6LLRdwukrdL6Q7UxCx/CblS4LElud1uz37xuS9gzEVIdnX+hHHsxPN8BGkc2WXBz7X693zn6NAZ2/jUjGOBGyem0q7goUqtZLx47T2zV0mcQoj9TrAcpY+uU05K4EQcwtS63jcgW0XOwIOPo1V9C0auLeDZGapphuuKvwqK03PKXWkHGewA56gG7c2ypRiFC0VBJB2fXUvNKI0wZff53o/E94VYkeaGrUzWTnO5u319ARG1UEzZFHV1kBUMUaBv3bv52iCcrVBQ4uAlhrIagBqaU8U/4EI4HGQZid4fNUcrOJ2EfEInrmrcVGshyjysSoLg16Z+Kt+Xr2U7g6ipwzgpgsaMxEAQAEHHXBI6hA+RamxoS6uoIdiM2TGmzjXAhCGFIpqUZBOIzKttFemoVIhT6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(478600001)(6486002)(36756003)(38100700002)(66946007)(6506007)(31686004)(26005)(41300700001)(6512007)(6916009)(4326008)(54906003)(316002)(8676002)(66476007)(2616005)(66556008)(186003)(2906002)(8936002)(6666004)(31696002)(5660300002)(7416002)(7406005)(83380400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RvUWpqa2JKZ1E0NmduZlVVVFhQa05ITHY4T2EralFtMHo3a3ozOXdpMm1D?=
 =?utf-8?B?VUZMMmRNYVpOTXRUd01RK3FlakxPaVFCUUd5azhHejNEMDlRZUpvSnI5Z1ZG?=
 =?utf-8?B?citPK25pMTh1andxaDJuSkZqUkltYkN4d21nZ3J3azUzaUhvZmQvRitaT1g5?=
 =?utf-8?B?QkIwYjJEWnhBRDJLNGhTTXIzRmhTL0dBVXhKR1cyVXBIMUk2eVFVNWk1WXBR?=
 =?utf-8?B?MW1JazEwUUZWUFc5VmlCdGF0bFJoOEJramhSeHp6Nkw3TGV1SFVuZzQxdFFC?=
 =?utf-8?B?NCtJVFNCSURZZFFlaFFxRHVJMTJqa3hMeC9jVGZnc253V0ozUm92QXdkSklV?=
 =?utf-8?B?V0psanFCOVY0YUhwTHVJMlpQMmVheFl4bDI0TzQ1UGNwODNFeUxHTVkwTFRx?=
 =?utf-8?B?czNIN1k0a01udHE0SE9RelhQb1FOK3dUbk0vcTVwUUJGRkRQU0x4Um9YVWxX?=
 =?utf-8?B?TmdxUW9tejZrdnl4ak9YZHdEZ01hVFJka01Bd3RSeThNaHc0a3V6MmQyRVQ5?=
 =?utf-8?B?T2txY2xFUG1MWVNmanU2SXB6aml5VFQ4clo5ekl0MGZCM2FMMVA5aG1SdTZr?=
 =?utf-8?B?c2ZJekdPK3lRUHdBN1dlakY0ZlJHcUlPaFZGVXV0TCtIOG9iQkV0clA3S3lG?=
 =?utf-8?B?QnE3amFnTDJuZHFOL3BjNVVrb3lidHpuN2pKbG9wRkZ5eEJEdm5SR3lUZmE5?=
 =?utf-8?B?OEt1anJvdG5zS3d1cnRjM05jZTc0cFdGaUZBeE5MYmFPU29jOTEzT1duQk52?=
 =?utf-8?B?QitJd3pjT1VmZzlZam9BRzNaT2tKVnF3WGVyN0FjOTY2M000aE5ha3U0OTRX?=
 =?utf-8?B?dDZZUmNVSWovS1M5aTJGWkd2a05xdjBGY01CZWhhZEtlV0o1YStIc25wUjh6?=
 =?utf-8?B?K1Njcm05RDY3TzM4bXdqOEI3YXQvUHhzVnNOc1dUVFFKenFadjJHMWptdmIw?=
 =?utf-8?B?RmhIRTdUTW9ZVkFYTE1vbnl6SmJMaWtMSXE4MElCYTA5eEpTMS9qcFMxYlJX?=
 =?utf-8?B?aWR5Rkt4VzJSY1Y5aUt3K2YwRUVIVndpMlBudHN2OVkvUXdDTm1zMFhDazdU?=
 =?utf-8?B?MTZqUVJPd0FYOEQwY243N2IwbjVya2lHaStoRjROSGwzeEdJTmhpZVN6UjBG?=
 =?utf-8?B?cHp1N0o1SEdyVkFlWGxlWmhEVExOUVNuZ011OVhreWhMckQ2VzIrNTk5M01k?=
 =?utf-8?B?MnZoejNid05UcWovaTRRTmJoQnNUSmZPOEg0dld4ZHNpZXl4dzg5c0dNVEhx?=
 =?utf-8?B?Zys3MjBqL2ovRk1oQ29KM2hGK0haRlFZRGFadnpoUU0xU2tQOTV0cnFhRUFy?=
 =?utf-8?B?TnlOclNIMnNVSzhLYzFMekZ3ZEFiMlNxOFBnS1RCUUt3dTgzUWZzWHdHMzRY?=
 =?utf-8?B?dlgrYU0vdlJWdU04aXY2akl2NkwwM3E1TTl2NmVwQnRCc2RLRUUrbm5KVWIr?=
 =?utf-8?B?WFZzVFpRWGZWQ3IzVGdDV1pZbzlwMDNMN2d5Qi9KV2JPRG9kSEtrajhEQUFq?=
 =?utf-8?B?MG9uaW84c0ZrUXhpNFN1V0dNK2o2MUhOMXh2SmhYYyswTzVUaXZRYVRMSytG?=
 =?utf-8?B?VXdKbHVKc1NjZ1AxVEVFdm5GVksyT1BmVTVhd2ZDUE9LQUY1Qk82MEV5WUVK?=
 =?utf-8?B?clc2TUduSSt2ODdMZVptSU9CNTQ5bzZDam1ybHlxKzl2YlJCTWZ1YUxuYnBK?=
 =?utf-8?B?bjZNS01oNzM1U3krcUdjYXZWNlBWVHNzMUZCRmdicEQvUFJwbnVSbU1GazFS?=
 =?utf-8?B?cmhDNkVXZ0xBVW5MWFdSM2FvUUVBWWE0V3p3eGZkNERlZkFTVVcvdlVNellW?=
 =?utf-8?B?OUFycEtkaWhRblloMm5vdUpBeWpNY09RZTRLdWh2Z0Uwbk5nbVplYlZMZjhj?=
 =?utf-8?B?c1ovUjBpTllteEpoUmpLSUtPeXF2QWloL2hRVTQvenJJY3h5d25lU2dUcEZ6?=
 =?utf-8?B?R1hyaTdERElZc3M0R253WlZzMHhIMVVFelRlcnQyTUpGNm81WElISTBiQnFP?=
 =?utf-8?B?d1oxSUtoRFhZT01IZkUxV0lRbGVqT2ZCZ0FlTFdPWko5TEt6WmJabnJmcXBW?=
 =?utf-8?B?MlM3NzExc3B2NnRxN3h1STJMMmJWMUpIVTNRN1BEVGhWdWRSR09tQU40a01h?=
 =?utf-8?Q?LzjU4LsyKXVcuqLQadn5GqonK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530bae94-740a-49ed-af99-08da64b6a87d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 10:01:30.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDRfPbd2TRvp62qw61pMdhwCXijA/oQKIucxq6sliafHQr5kYlryFFSrdmQrYydPN06IqJogN0D5LFXM5C7yiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> +#ifdef CONFIG_MIGRATION
>>> +static int shmem_migrate_page(struct address_space *mapping,
>>> +			      struct page *newpage, struct page *page,
>>> +			      enum migrate_mode mode)
>>> +{
>>> +	struct inode *inode = mapping->host;
>>> +	struct shmem_inode_info *info = SHMEM_I(inode);
>>> +
>>> +	if (info->memfile_node.flags & MEMFILE_F_UNMOVABLE)
>>> +		return -EOPNOTSUPP;
>>> +	return migrate_page(mapping, newpage, page, mode);
>>
>> Wondering how well page migrate would work for private pages
>> on shmem memfd based backend?
> 
>  From high level:
>    - KVM unset MEMFILE_F_UNMOVABLE bit to indicate it capable of
>      migrating a page.
>    - Introduce new 'migrate' callback(s) to memfile_notifier_ops for KVM
>      to register.
>    - The callback is hooked to migrate_page() here.
>    - Once page migration requested, shmem calls into the 'migrate'
>      callback(s) to perform additional steps for encrypted memory (For
>      TDX we will call TDH.MEM.PAGE.RELOCATE).

Yes, that would require additional (protocol specific) handling for 
private pages. Was trying to find where "MEMFILE_F_UNMOVABLE" flag is 
set currently?

Thanks,
Pankaj

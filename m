Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE906574226
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 06:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiGNEPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 00:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiGNEPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:15:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E162275F6;
        Wed, 13 Jul 2022 21:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEJjSPV8NY4nyEIfjNgcQO6/ZCZc08dmQGyeDokvrF7V0MfnJfa2M9tDUWOcba+zDwk4U0+bi348H2As5IwnuO1XSuNOtWi4gWODqHZ0/2LRxvWpq7eC4OAf/zDbaoCFRoRc8l300YhUXWmOqxeiWHc6OIKtNqSK4L2gnXgmCKBSG39ebPfNhzoqqSaaTQLAsT+mGiRwwaDC7wCWUPMQCo/ub90Vix5rQldWpJ3q0RTExAGhGxsUQoJAn16Cl5hQmrXGbLIes8u0otKyYBS+MSZfz2tcoBdCEUg0F6M4DviRboLNzmNGAyIj3LczvvNSS3Eyp5akBJt/JPLT/K30QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTGiMXdwYkBrnbm5BTYNyYMlVJSQtsIzkNi5opfCOog=;
 b=QhhMmwwXdxGDZNFZCWz6nmXGqHJj15g37SG2vUhrShTO21kiMi1AvPTUn+VXJmhtMtoZnH5Jlu+dO/iPPSCL6phrvCDpz/jQMJkm3fzJ37d+XCcacjiDO6CrQWhaV6QSlk8eWndTC367ezIJWMS0gXCaLwb9yZ54qnr+D+fzFmTA2RhgY+9zrct5DJcnpmUr8V4wV5XlxzB8uzd9aj9xNgqScivziAhTVg7ntQ3dklcYz4sTIq+Qn7fGnK5jDTOmGIs8YBfdHhfLMxKf0zssoLakZH058+3IhMj/LC1ZXIT/ylEIKWpoN3yOr6rf9TNnEEdRNow2E3Ss2exIdegUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTGiMXdwYkBrnbm5BTYNyYMlVJSQtsIzkNi5opfCOog=;
 b=eiiZR5G1dhwQS6+C7C8CosYkNfr79DPJMFfpZDcl7woy2CjnctiUazb0srqlYl3dGsb7oGxS333awDKR9MM6lDHGtHEWq338Kjf9YTN22N1eVzeX2f4uRjky12h+z5jXoHa7p3vgbya3oYB3Hg0SO10X+l9th5gbEqY7stRwipI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by DM5PR1201MB0220.namprd12.prod.outlook.com
 (2603:10b6:4:4e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 04:15:41 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::1001:3c79:9504:8d6a%10]) with mapi id 15.20.5417.026; Thu, 14 Jul
 2022 04:15:38 +0000
Message-ID: <5a1434a7-1820-b76d-d0c2-3f7463f0e8be@amd.com>
Date:   Thu, 14 Jul 2022 06:15:26 +0200
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
 <74097857-1908-2ff2-1e54-bf7e658ea6c6@amd.com>
 <20220713234903.GA2881285@chaop.bj.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20220713234903.GA2881285@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::19) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b7e9975-1e2b-4172-a6e8-08da654f81b1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNYYFyPY++6AOipkh4E+MpGRSkMqCI9suUGViz3+WzwxTVqBqYYYT7fdY6Se57cygutsSzZmffej/w7hJDlbWagsinPpbocstC5aN0/9EadosVC/l811jNn89wq+MQ+5IkB2i+Aoc84h/C1Bghy+iTq2sONPq2sg+FN3Awq/e3Z9Jwq4z87fyRyOvewfAPB5zHQXD4f9N2w8DgfV0OmJUo653SkfbGIwfTZnUKtB4k2Qu5O2ewK0BjSA9ypXSRk/RfWNSNxcyMAOLrX8pNkm6nKJSK8ynWfMwJId0OXHQ+Xr2su2W0P1ypeDTec3hDjCvQXp56r7TKQ+vjyJGVcatEK0hkckbHFADVtlGuSW7YSuW48WlFPDZ7TxmmLg+8ZUBBQ+DJ9ZUEIcz1Hjv+z3YBtnFo7wGHQLz0tuU4jIsE4+2jlFV+o9uU00373aU3IFPe4ck16EciUfTVRRtQOy6juRy8Rk1PaMg83FlHP9GXvWjcZynm7gi8Tddiy9+vjsDOYk4BCET+FWcDXfB59wVBAQ57rpVmXLuhczhalSIICBN90wLXiiCqMY2S2Dz8sbDuyY91RLdmMjxvDfuK6vSnTmwCtYoCI971h3FHjQbkF305gTkWFNCj5ejT3vZDFtEK6fBRcrWWLrantZMXLOrsPfWTRdhT53URo95QFL0piSO5GzwEVVuVZbH/Ui2rRVY8Go3leOTk8hSVr8/SxULMfHqPoEFh5A3REmI9zVAE3JqoMHKUu0YWbysW7xg88ll0r89bSelU+xumnMXKNlYg+7pNTmaW9PRYPOGRhk20HkXnBb4fv/VuUdiCkLusvHtKQKMJHUBr1KE6BKUmy+Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(66556008)(6506007)(8676002)(86362001)(6512007)(54906003)(66476007)(4326008)(316002)(66946007)(6666004)(478600001)(6916009)(5660300002)(31696002)(31686004)(2616005)(41300700001)(26005)(36756003)(6486002)(38100700002)(186003)(83380400001)(7416002)(8936002)(7406005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGNFanF2NG5rMzJEaGNRMTgrb1ZoZ2ZoM1hSQ0tJVlhnNk9yNU9kOTE2MUY2?=
 =?utf-8?B?eGJKQ3JhR3N2SVlRSmx3dU5zV2lkRElYSWtTOW5XeVRCNSs3bXlHUHlBSWtx?=
 =?utf-8?B?T0laK1hRbm1uSXF5aWpudkRJc1BOaG50QjhCQjMzSVRSdHZudjNNQ09DQmJp?=
 =?utf-8?B?WWtTdXFNYzlRSDVPL0RPTk1BNjBGUzlXYStySTJ1Nkhybi9KTnN6bXBVUmd0?=
 =?utf-8?B?c1hiZGs4U2NCUnVLTmhaLzczR01kTlJkdnhpamUwdklLV1IvMERYclVjd1ZZ?=
 =?utf-8?B?OCtxZFlCUjU0VFNPUUJid0I5bWJkMTVVcDZ3dFEvdVFYN0FWYk8rbm9hcGpj?=
 =?utf-8?B?cDlwT3ROcytKU2ZDUk9MclRxcGtMOHVNbVBnOVIrT2hYMFRQYStpS3ZYZENr?=
 =?utf-8?B?TFlHVjdSQmNtZmhJUGRzTUthRFhuSlE3eVl5TTlvMW9zTit3Y2NuU1l5T3RJ?=
 =?utf-8?B?Z2RCK0hWVWgyakxNa0pTYXh4TlZqTlIxY1VPRXZNQUhOTGxSK3hGZnQ3MEJZ?=
 =?utf-8?B?WWpObjFBMUhVL2NtcWdhVks1S3ZHRFFjYzJoWEJaZUVTZldhSHg3b2RnTmNl?=
 =?utf-8?B?QnVzaTRWYUV5TDAyU1VmMHNkTWtXR1JpSE1yN0psRnBSTHB1ajd2YXVzZDBx?=
 =?utf-8?B?dmxsVzB6ay9ucmw2bWpNQk9zbzIwODduM2NSRHZVOEpzOTN3cmxTdElySmxB?=
 =?utf-8?B?dHRoejNET09MQmlWckpZckJ1UUxwVFpBbzRCNFNWcnM0V1R0em5TdWRQYi9l?=
 =?utf-8?B?djk3cHFvQko0dVBhdkF6NkpoMWovNTNhTDVWdi9vdGMxdjIySTgwSjNXWmhu?=
 =?utf-8?B?NDU3Yi9DQ2xWU05ZV2FwZFd5WU1TMmttNUt3M1pCckZEcFI3QTBJdkh6Tytu?=
 =?utf-8?B?U3FEVGlPWEdvMXlhdzNxOGtRL3BFTFg2OWJYTXJOUHlVazFoYTBkOGFCeER0?=
 =?utf-8?B?RU9JWmxJRE01cWtTanhORXhHK05DN09BV3NhVy85R0hkM2I5QlFOSitWeCtD?=
 =?utf-8?B?dGNxazJ6SGNEOXlUQ1VvdTFMbVpDVTlkNFVPcnBKTXdoM1dGTFNRNzNNNkor?=
 =?utf-8?B?bWovaVFpa0owS29SRmI1T0FPeWNSc3RkUEdEKyt2WEl0UWhuK2d3cm9FWGQr?=
 =?utf-8?B?eDl6cnN1dE4raXhWaS9YNDhHK0dEZWZ1ZGRZYnpDZzFzdkM4bytCUkJSblhx?=
 =?utf-8?B?TGRHWFdWYXp5akR4NTZvU0E3TmQrRzJRL2F6a1owZnJMYjkwZ1JrL2U4TERR?=
 =?utf-8?B?STBHbGphenJOM1lHa3NUM3lDcU9ISXdSSEFBcDhpZzRBNHk4ellTS2p2TTV0?=
 =?utf-8?B?RVZ3K1Nua1pHeXZRdHorbk1QRnU2YnpPK3N4VVlzTjJkN08vd1pydUMwZmNv?=
 =?utf-8?B?OExDbktkMDl3VWpNUVBsQXNyaFE3VWJVblZuRmNsNzUyOWMycUlBalc4SFVX?=
 =?utf-8?B?dTVmTGM2UWRTcktEcGV5OGFiWmZHZVowcjJkempzem1kVjdRM2o2S3VPdHM3?=
 =?utf-8?B?Wk45NlViankrenZFaUhxOFdYVTVjNEx1d1FMVHJKalE3WmQ4RXhPd2poWVJP?=
 =?utf-8?B?UzBVMDd3dndHc202REZMTytwMlpGU3ROQVM2Y0x6WkxIbjdSV1hRMGZaZTJt?=
 =?utf-8?B?dEpVWE9rdFkydVEzdEwycyszMkVMN2kvNCtKSkJJL0NtZHluNEtmYnFoYmh1?=
 =?utf-8?B?elJERzBCeG1wc1NhOHEvOEZQYW9TMC92ejRPU3N5NlJ3TlpuOUtQZzVFQkcv?=
 =?utf-8?B?enRPMEtmUnhBVlJXSW1TOXlFampmWlR4Q2tBdWpKOS9UdVhqVjdQNFI3anl1?=
 =?utf-8?B?aWxJL2Q4anNaU2t6U21vQnRBcyszMlNISlFCUUtOd1pUaC9WTlV6NTg2TEl6?=
 =?utf-8?B?a050QWpLSit1aWUvdkxLcTZCeVluMG1NbG1VYjdkK01nejNMSkZaWmNMc25M?=
 =?utf-8?B?L2FEeEFkNEdQSnF5RTJFNWU0TkljMDhQV3cyWUkrMlBIYXZNT0xlOTMydEVV?=
 =?utf-8?B?VWlqZmF1R01wSGk2cVlYTHczYnJhZGtheGNXb3BBZnFxYWc3ellMQkJjaGMw?=
 =?utf-8?B?eTBDREFPWFpoeVVIZGM1UFQzWHMrSkxvN2QrQ2g5eTY2RU1LZUlQNHI3OURp?=
 =?utf-8?Q?ekf5+bGeksvuTNWpY6OD2Lttf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7e9975-1e2b-4172-a6e8-08da654f81b1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 04:15:38.3290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+b06IpsjgEOYfxHj1gTD2cqskHhbrKfxjVtgISLfTYZPLQyrzxj6idV3vorXjJfj01n3iqYSo1gvqQxY+lAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>> +#ifdef CONFIG_MIGRATION
>>>>> +static int shmem_migrate_page(struct address_space *mapping,
>>>>> +			      struct page *newpage, struct page *page,
>>>>> +			      enum migrate_mode mode)
>>>>> +{
>>>>> +	struct inode *inode = mapping->host;
>>>>> +	struct shmem_inode_info *info = SHMEM_I(inode);
>>>>> +
>>>>> +	if (info->memfile_node.flags & MEMFILE_F_UNMOVABLE)
>>>>> +		return -EOPNOTSUPP;
>>>>> +	return migrate_page(mapping, newpage, page, mode);
>>>>
>>>> Wondering how well page migrate would work for private pages
>>>> on shmem memfd based backend?
>>>
>>>   From high level:
>>>     - KVM unset MEMFILE_F_UNMOVABLE bit to indicate it capable of
>>>       migrating a page.
>>>     - Introduce new 'migrate' callback(s) to memfile_notifier_ops for KVM
>>>       to register.
>>>     - The callback is hooked to migrate_page() here.
>>>     - Once page migration requested, shmem calls into the 'migrate'
>>>       callback(s) to perform additional steps for encrypted memory (For
>>>       TDX we will call TDH.MEM.PAGE.RELOCATE).
>>
>> Yes, that would require additional (protocol specific) handling for private
>> pages. Was trying to find where "MEMFILE_F_UNMOVABLE" flag is set currently?
> 
> It's set with memfile_register_notifier() in patch 13.

o.k.

Thanks,

Pankaj


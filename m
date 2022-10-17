Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3486013A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 18:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJQQjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 12:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJQQj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:39:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B12C2BE7;
        Mon, 17 Oct 2022 09:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j21gajNu05Gwuyh6oYVbagKXPLvUh9aIih8Vmvp+0+0Ty0f7Oi4novAJgYCbbnjiEGDBcsDwFh1XcS/weWu89kkuX7MjiojacGluE5fuYV6Eojb0e66a1lWppowujkQj4M3AZqiqrI7xxGvtOrkenqs8/zsW8Fm8OsUlUW5x/CWs+pd8GBU3n4t8u/yslP+QMMutPqkaFSoBQwn86YY4QB1z8dljciAMgIaaB7/9Fr3kKGYNjDQppxYbV5Elk/fppE4cnr1Of746buhzquKNHPEnyI6foBmsqhFqPL7HBQlspCq7YUEfWXQyjLACts2pj3fK3NRSGm7zZsRaTN6jZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdN2VdIhR/0IyZG8xacGQtZ6HW9P1J72V5x77XNYR38=;
 b=XEpRJyVKKE3ruViLyFrBJmPOTw7KVRB+bPdujk+eWtzSVrvoJmAGN6DsYV1whys69NH6qcMbYRddF8GwBNoZ2QiVSgKJPewpTQxSEJUXhW0OkDO1zFMYQf3ayU4go8/s5RO99QmmN00OsjGdtpi7NGThglorTn6AuLPA/UgJ0Cqqurdx9hlfC9Oj6wRoGjPpLEQHq9tdLAoPHb7MCugrmXwdEbXn9nb8El6dR9M096gElvMp6FjYwVSQNYj9SJ3RG8r73CWNhXZsoJ+DxkUWHz2MsnhsFSvC07/YxkXwEa5S3SOGshVuDhnA4Ij7CuQUrWrftM6ES1PqiICB2L/0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdN2VdIhR/0IyZG8xacGQtZ6HW9P1J72V5x77XNYR38=;
 b=0m3DsEftpyvuZtBsvJnUExZ0WatqBXlMfVkHeevm/0HQhjf1YHfB9JDkhpp5BBori7x9ZigCOreGuBUUjjV++OPo+Mk7tB/C7ke4HR4rQCWPVxYcXC9kiwv42Kt4W9oVUMsoeyiUfVaQT+EapVQJmjZN9eMkyM9exrwRbTHkTzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11) by MW4PR12MB6828.namprd12.prod.outlook.com
 (2603:10b6:303:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 16:39:24 +0000
Received: from CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::dd6a:ad02:bcf4:6758]) by CY4PR1201MB0181.namprd12.prod.outlook.com
 ([fe80::dd6a:ad02:bcf4:6758%11]) with mapi id 15.20.5723.033; Mon, 17 Oct
 2022 16:39:22 +0000
Message-ID: <c63ad0cd-d517-0f1e-59e9-927d8ae15a1a@amd.com>
Date:   Mon, 17 Oct 2022 18:39:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
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
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
 <de680280-f6b1-9337-2ae4-4b2faf2b823b@suse.cz>
 <20221017161955.t4gditaztbwijgcn@box.shutemov.name>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20221017161955.t4gditaztbwijgcn@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::25) To CY4PR1201MB0181.namprd12.prod.outlook.com
 (2603:10b6:910:1f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0181:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 06df2695-d081-4b44-cf18-08dab05e2502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtRhIY1I9LKPfMqkf1JPYaGvqrK2y01056nh0nN9c5iqIKlcjHVMNjii4oE9VPb/aHr6B0v+IevXW86o7CtZ1Rp2kHukEcLJbLnE4Dtm5aBrSMYZ0wwRGrteHoSKkTnKMaPxzUgUhdwhaobPB0o2a9ztEUB8RH4SwuEMvLFRD6AlkUjltofnHQQc3pGfnanHWADxTwKdCiHbY3i2IgyAlLc2pb1EE50gt3K1NUC0cQpAiAbNm4+he3xrGOskmjkR348Cygzc04i10bNys9suPq6OFXFXelAkq+f4GyeBPRiqnV+p7FxI3+x/s1U2zpeUzCJz2UJ/9TucaLCWlbMvT0s0CclHasE0fm3l08mekzj3B5IWIcrI/G80zcJInPBWi2H3nX1t2e88VCW81iZ0vrbkW3Erd3aOKwQhPyATN51wu2s2MlEWw4E9lHlmBTmwDlh5J/7iHWih4Y3PPla2CWzn9JuwUhKBUeajQPVFbXBvYy+pDtcTiisRkBIW5Bs5B/xHilemr6Or1wHzJqnM10dI2E5+1MDBi/jmAnztbqT4W3ujblO4mvX58YPgHkOjzncO9uypt+2XOfghTZwakO/cgxvMn0WVmNfWMnrZTQKYaTCZzGCYrMTrPG/SCXHqzZKPElTKvvh4P+fKIYBtPCniAq96gALSkv8E2WSkgKd/STWyGvKAjlddS6GEXPXQxWzAwdnmEW0x6uY3f1zCeQ3ImTzU4dj+Ikrgem+8AZGv1HIhlD3vXQR0dFuy0sjFWslbAjZBOQ0p/bT7lFq5srPHzUWJzA7OChazbA8fwDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199015)(316002)(2906002)(186003)(83380400001)(86362001)(31696002)(36756003)(38100700002)(31686004)(6486002)(478600001)(54906003)(110136005)(5660300002)(41300700001)(53546011)(6506007)(2616005)(7406005)(8936002)(26005)(6512007)(7416002)(66946007)(66556008)(8676002)(4326008)(6666004)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRHZTJ1c0syN2lqcUpBNWVaWi9vcG9oMjZOSk5MQ0Zjb0RYZDBiT2xacG9v?=
 =?utf-8?B?aHBiSEVycVc4b2dsWW54eTcrN2JLS0VVS0FaNHJsUm1wczJ3SHRJVEtSS0tF?=
 =?utf-8?B?My9mdm5FdmVPSFlkSllYZ3p1K1NzUENDRCtoQXBRY21VOXZGQkkyV2ZvYnFL?=
 =?utf-8?B?RkdmaEptSTZGQU1MUVcxMVd2V0dya0ZDSy9OZDY3dmpxQ1EwaUo2NVRhdWNv?=
 =?utf-8?B?dDRKUTZxSk4xdGtUdVMxYVVhV2dNL1NTNENyRHlDaDZ4Z1NWWjRZb2JrMnRE?=
 =?utf-8?B?WTRCRUpEQy91Tm9hSGRzdGlJQklaUWd0MUs0cDJMQUQzVk9JV2oxZUhMVGtv?=
 =?utf-8?B?NGlsbnJaOG1ybVBZbzZLTFJDdERYd0dkbTRvRUExL2hseXV5aTRFUjMzeCtG?=
 =?utf-8?B?b1VjRW16bHVKZnJqci8rK1NyNW1MUmg3M3FCdlprQ2I2bFhNS09wRW9Qczkx?=
 =?utf-8?B?d3FSS29YR0FkMWlBYTg5RWNQWlZkcFN3TE5qdWJ1WGtxSnZ5dVRqcUh0UDU3?=
 =?utf-8?B?MlhSa1lqQVRyYXkxSTU0Z1JtWXIrcGdMUmhpZ1Y4WWZZdWRMY090ektnWWZa?=
 =?utf-8?B?eDVPb24yNGFFSmZMYzhKRVh0Zy9Pb1FMcVlIdUErajlwU1dLaG1NZHp2dnNR?=
 =?utf-8?B?RmtzWTdqKzBMeWNvSXdMVUNydFJleDJmY0hEcXc4S1MwT2tqbjhkdnhHeFRx?=
 =?utf-8?B?andEWm5YL2llRkZBVnZPOHc0OGdoeFZ2R1A1ZW81UTZCa1ZoWlRvbUdLK3Ix?=
 =?utf-8?B?U0lZdHphT3lZYWJCS1lzaTNhV1MwOWxWWGgvb0JkNVhscm1QWEg4OU42TWFB?=
 =?utf-8?B?d0ZBU21uMjZXSW00ZXJLSDk4NVZuUEFEaEY1STZuRUl0YXZ3K1E1aXNIUkU3?=
 =?utf-8?B?eW5zelVZaFJPV0MzOVdrQmRyZ2pUb1N4bzk2R3diNFhLKzNsSnV0cTRseFRz?=
 =?utf-8?B?dmQxaFZ6cnZnTTl6OWpsdDdHeGJQUFBSajZZVjdaeGlkWEQwbkUzVzlzRHN4?=
 =?utf-8?B?cnJlWXRKZjFjSUtFcEZGaU5WYytkMGVmM0JOSitoZmJ2RUVWcjRVbkJNaUph?=
 =?utf-8?B?WG8yZVJXT3gwVTNUU0p4d3k1ZHdvMXdicTFBbjFlSW9KcmFja21sMG9TY1ll?=
 =?utf-8?B?Tit2dHoxSXF6SXpITDVrZGVDMWdiMzQ4cUt2dDFxdVk4SGszMFZxL1VneDc0?=
 =?utf-8?B?OUVjM211V1o0cHpXTjlEdlhkelFWU1B1NGN6YVJQTEFnWEtkVzhIOGl3Ym5t?=
 =?utf-8?B?UHdUTDFEL0U2NnpKalY3b00rRUgzYUV5Y0FZaGJYZlRCTWF6SzRCRm5TLzcw?=
 =?utf-8?B?anNQNlpFWkk5YU5VdXVtbTN6TjV4ejAzVlNSRGp5WElsVEFKMmx2TWk2VmMv?=
 =?utf-8?B?cmYyRGh3V2tWVldKTThLZ081RDFtYk5LUktubzNZVkFjMlNZekxpMTNMNnds?=
 =?utf-8?B?WURIUThRM1dxVVB0dDU2ak1GT09SbncyOUNobm1ZQ29OUGFNMDhNdWc3SWdR?=
 =?utf-8?B?bGNnaWdsVE5odTJRdW1BY3FLbUgvb2JHdXpnTGFpaU5nUnZ0dnVCK1lhNFlL?=
 =?utf-8?B?a0p2MVE2UFhLZnNtQ01GK3RRYmd2VDhLNEVwcDNINUNVejYydEZkWmlSVVRH?=
 =?utf-8?B?UzZBTmh5T01oME00UVVhcyt0VGttVnhJd3B1T2Q1Z1VUdzFyOXdGMUxvQ1BL?=
 =?utf-8?B?aFFubmJONS9NZENjejhuQzl1WG1JS2FoWU8wSVdMRllIVWYxSzlhY0FFRlRF?=
 =?utf-8?B?cXl2enY0V0xFajVwYkRLYSs2VDVJeVhzZkFQcC9GVElXaW5OSDZVQnNQcnFj?=
 =?utf-8?B?Rzd2Ny92NENkM05UYmQwY3RxTDNQNDJXZEt5TVl2VVpsZVA3UkNMVFpkbHVj?=
 =?utf-8?B?Tzh5eTJwN3k1TXN0QU5DNlh0c3VCTjBGUytPY04yUnFwVzdqVVJiT3hIb1lM?=
 =?utf-8?B?eXJtRklLTW5qaU5pdXZCbndJNjFyc3RkRTR1VGVsbmxYcFV5cENNbmk5Z2RP?=
 =?utf-8?B?cWFmbWhyZlhYVzEzUXZrQ2Q1VUtuUVFTRXFxbDRGZVA5UUM3dlYwSHRrYmdH?=
 =?utf-8?B?UWhmODRmb0hEU2F1ZERhQ2VNMi90bVpXeHVKdElmSjRiUDZ4MDg3bjR0d24r?=
 =?utf-8?Q?REi460e6t3cVyht6+rzaSyQr7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06df2695-d081-4b44-cf18-08dab05e2502
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 16:39:22.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41dhMx0IR/+IPVAoO+iNDiVrpG0LA2kkZwlU8h1H6xSt2T0TcR55Mpy+nA/ISADesHNnhilEbg3wPq70BGla1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/17/2022 6:19 PM, Kirill A . Shutemov wrote:
> On Mon, Oct 17, 2022 at 03:00:21PM +0200, Vlastimil Babka wrote:
>> On 9/15/22 16:29, Chao Peng wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> KVM can use memfd-provided memory for guest memory. For normal userspace
>>> accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
>>> virtual address space and then tells KVM to use the virtual address to
>>> setup the mapping in the secondary page table (e.g. EPT).
>>>
>>> With confidential computing technologies like Intel TDX, the
>>> memfd-provided memory may be encrypted with special key for special
>>> software domain (e.g. KVM guest) and is not expected to be directly
>>> accessed by userspace. Precisely, userspace access to such encrypted
>>> memory may lead to host crash so it should be prevented.
>>>
>>> This patch introduces userspace inaccessible memfd (created with
>>> MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
>>> ordinary MMU access (e.g. read/write/mmap) but can be accessed via
>>> in-kernel interface so KVM can directly interact with core-mm without
>>> the need to map the memory into KVM userspace.
>>>
>>> It provides semantics required for KVM guest private(encrypted) memory
>>> support that a file descriptor with this flag set is going to be used as
>>> the source of guest memory in confidential computing environments such
>>> as Intel TDX/AMD SEV.
>>>
>>> KVM userspace is still in charge of the lifecycle of the memfd. It
>>> should pass the opened fd to KVM. KVM uses the kernel APIs newly added
>>> in this patch to obtain the physical memory address and then populate
>>> the secondary page table entries.
>>>
>>> The userspace inaccessible memfd can be fallocate-ed and hole-punched
>>> from userspace. When hole-punching happens, KVM can get notified through
>>> inaccessible_notifier it then gets chance to remove any mapped entries
>>> of the range in the secondary page tables.
>>>
>>> The userspace inaccessible memfd itself is implemented as a shim layer
>>> on top of real memory file systems like tmpfs/hugetlbfs but this patch
>>> only implemented tmpfs. The allocated memory is currently marked as
>>> unmovable and unevictable, this is required for current confidential
>>> usage. But in future this might be changed.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>>> ---
>>
>> ...
>>
>>> +static long inaccessible_fallocate(struct file *file, int mode,
>>> +				   loff_t offset, loff_t len)
>>> +{
>>> +	struct inaccessible_data *data = file->f_mapping->private_data;
>>> +	struct file *memfd = data->memfd;
>>> +	int ret;
>>> +
>>> +	if (mode & FALLOC_FL_PUNCH_HOLE) {
>>> +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
>>> +			return -EINVAL;
>>> +	}
>>> +
>>> +	ret = memfd->f_op->fallocate(memfd, mode, offset, len);
>>> +	inaccessible_notifier_invalidate(data, offset, offset + len);
>>
>> Wonder if invalidate should precede the actual hole punch, otherwise we open
>> a window where the page tables point to memory no longer valid?
> 
> Yes, you are right. Thanks for catching this.

I also noticed this. But then thought the memory would be anyways zeroed 
(hole punched) before this call?

> 
>>> +	return ret;
>>> +}
>>> +
>>
>> ...
>>
>>> +
>>> +static struct file_system_type inaccessible_fs = {
>>> +	.owner		= THIS_MODULE,
>>> +	.name		= "[inaccessible]",
>>
>> Dunno where exactly is this name visible, but shouldn't it better be
>> "[memfd:inaccessible]"?
> 
> Maybe. And skip brackets.
> 
>>
>>> +	.init_fs_context = inaccessible_init_fs_context,
>>> +	.kill_sb	= kill_anon_super,
>>> +};
>>> +
>>
> 


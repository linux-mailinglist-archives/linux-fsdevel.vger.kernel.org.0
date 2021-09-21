Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE14F413CD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhIUVpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:45:34 -0400
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:40672
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232432AbhIUVpd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8Ry2A0Xbt9y09XOtdXfSnXeZngjTYoOdr2tOxu+cphZsrZsUFpClUiXQrE+ltvrcqNtM7AEKdRWcvvGEaiINOu578Qa9/MA5eAXk4pqeqzma5Vzw6NyuXfv4TARHoUavtZsCtK9r6BsXrhCTaNCgSgXEgWu7Zdk5vjA2ZMCNHbVRU7QUFs1YA1u2HyK7KgHZ0jqTw1pI57+ooqJ880Xt37WDzRapA+MkE/8R9CNdUGURm7EhkoE4SLx0Bi8Ew8JeE7Rw534mx9R5xEopRxGAvE7lu5h0CwSIUx1fdbcQ0xzynl6uBHH78Un+0JHcDOTD8zpm5si5GY0KNRamM3ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fQYhxtWS3XapED/SUZYhPZ7Wrv178Ijbv0gyN/UGxJw=;
 b=VyETEN2gXm0AnB670oU1q3nbVxRjiANAmJL2i7rxuV/pa+6tKMAoNkKiCRmf72zoGF7CpoDsG3BFgKTjrph65wgOJvOckJOAjt1jCLb/QAliiY2ChDV7aHgJY6ty5BNCDWECKrz+oKePo4xiBGDbcq30yUiwbpQdLFAwxPtt16V6MHDpvvWsI39gCpv6NaBkIKPNKnlqHP6J2JpQR4nR5gbHtvXXYCq76S1tqol03/5unO4DVgERCoer/gSv70u+o1s3rg0FEv8k3GLxS1AjRdRiXox/gloPHB/i+VmNGJ2CVdq6p8BPQzQivY7GTpWSxaD4I1J4qwLvkIMV6HRA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQYhxtWS3XapED/SUZYhPZ7Wrv178Ijbv0gyN/UGxJw=;
 b=AFgSSDEerfzpcgng+OrkI7sto/JvTeMV/EXGkusjDCcsj//P7OOTDtlvEuxlSn7MCBgcG6GoxKgwiwft//30J8yqxeX1vwu8dv9uNcOweazTeC94F+ZWSfjcRT1gRQJOf38KppdiU0r+NZB6+2jGRDUSXfL4h2Pi4b3kfWO8gPI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 21:44:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%8]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:44:02 +0000
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com> <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
Date:   Tue, 21 Sep 2021 16:43:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0182.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0182.namprd11.prod.outlook.com (2603:10b6:806:1bc::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:44:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd576e0c-98cc-4962-8996-08d97d48ed2c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53435AA7AFE37A6877E3579DECA19@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wecxMBEfdY+h/31tPLgPz2VrPi2w3W6J5Khwm5Z4Aoz0lErVES/4fi1Z9SKXSgqMnHurkjp1aOicZLqyufKctKPeiLxCKgFT3nc86QteH4HphParWq96HdmAr65+q9xXxtnelNXGJ4iI4w52RaK+QRc7NUHRSYrKS6aSu5MQ6XruqyKYYufENkDmpb8xXWlyewXXNwxa5qY3h7Lrf4a0vhX6I82imbx3jiv1fdx5B/IzJR854rrgy8QruLLxf0XtaFFq7mteZHWm6sQbf2s0/6CpSeqNntOwsGUYx0c3dUaY8NrGaRM2hrKwAfL7Xhv/q4XJQ95GbGL2W4xZkKuMCeY60/OndGx9u9afCi8CQEWY3770yZiDnoJUzNzGH4TxU2ShJDPL2h3CMZtq05/BjPSw/0mV+UFWddKb1wLkZYlSN5pT/sncXBvmCxwQbr3FcDHFqDqt8VkdNgWhaPtKzS99t6fyq4VVml64Aolz0jP0D4WPskhVZ3tuIIsivu593k0ms106jIF3K9JWMv6kaMiwcIVD5tQOud18r5qHwKdjfie+IR411DstjdvXElkUrNWH15lj6jFZtsyrG+EiGUTWKgb5QkyR4EHwMLdIST1wnXH5cY7VeakDYgO5Wb7qPYZBdMDSttSs346ud5zSHadT5BaSLqJnOSOXkhH6m5q0XQTMNoOdX8bnKEH88RR/1QEAfxxOT+bFNJv/v1LnN201OKtdas3kGUiauWrsjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(53546011)(4326008)(7416002)(186003)(26005)(2906002)(2616005)(508600001)(956004)(31696002)(4744005)(110136005)(86362001)(5660300002)(66946007)(83380400001)(36756003)(54906003)(66476007)(8936002)(16576012)(66556008)(8676002)(316002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWdxUWEzWjIwU1FORjZIdm9zOU9ud1A5NUVmZjN3RjBUQ2MxSlRYR0IzMWN1?=
 =?utf-8?B?U2Q5NVJDZWRtU2IxTkk0Ym4xTHk1elo5Y205bnFhZ2M5WnVrZE01SFB4eTZF?=
 =?utf-8?B?di8vaGp6Qlc2OVlGS1dGS3k3RmV3SzFZaExERTdpZkFjR0M2NHR4VFdLVlhp?=
 =?utf-8?B?Tmw1RGZzTDRRLzM5ZWFHWlphMjhjK1F5SmZQVDR4dVprc01zZXlscFI1VTdo?=
 =?utf-8?B?NXVwaGtvdDNCUTdNSThaME9Kb2xiNGpXM2dPMG1OSjVxRTR2T1JPSVIxQ2lV?=
 =?utf-8?B?cG9hSUNvWGh6YmEyMHQrUXR1dUxiN3ZON0tJUWlXZlNHUnp2QkJFRE9janZM?=
 =?utf-8?B?dE5VWXRheUJYQkloL0ZiUHU1WVFYb3ZhcGMrNWFqa0JwT3l2N1ZKbDQwd3hs?=
 =?utf-8?B?MGN3Zk9XV1FBYlhUL1lPcmdKTXdkNVFxVjFPMEV1UllCc2t5cldBT1hMUFNk?=
 =?utf-8?B?alkxclNpTDc2eVNFMlNaUUtUTllxVzRnb2Y0S0V4SmxUZ0NmSStKU25vanJ3?=
 =?utf-8?B?amIxRzNNY0I2SVRDc0N3c3NpNEZDWlR5VVBPbGx0V3hVaHZjbGpFM2NVWXVI?=
 =?utf-8?B?ckwwUU5Wa2dZZ05zWVhYQ21IUnQ4S1RUZFVuYW1NVlZSb2VyVmhnUUYvSnMz?=
 =?utf-8?B?YTFXWDFYeE0rS2JjbVBGOGpEbnFlclRRK1h2cmVrbEROaUt6NDJ0dllEOGlW?=
 =?utf-8?B?KzRYTmw0YWd6bVB3YUJCRWw4dWRmNnpZdCtoOVhISUNZbjBKNlVCMTduRHJj?=
 =?utf-8?B?MnpNUW53MUlLVDhEbG9yMC9US2dCazlWS2lwV25zankwdk90N3RCbEgrOHFS?=
 =?utf-8?B?R2JjQzJBd1BhY3VTZ0ZYSS83TnRsNElLS2VWOUhoZlNlNXlhNHVsSGZ3UDJj?=
 =?utf-8?B?RWQyc1pLSUtIUlE0WFhDMDF6SDJtR3U2M3lqTW10Yi9keUtsT2xadk5CQ1Z2?=
 =?utf-8?B?eDh1OFpnbG11a1pvcG02Zk13TnFWMEFQR0k0MStKOXc2dUZqemEzMDZyQzAy?=
 =?utf-8?B?bk9MdVZqQWhQZ2U0MUNpcVlhaU0yQUZKVDgxWkZsSzMyQzZwWDErVGF0TS9B?=
 =?utf-8?B?Nml1UmYyQndyajVTdEhYaHBZYmFWR3I4clJSYjVGdGwrckFKdVVGaGlJQ1Ro?=
 =?utf-8?B?cjBGUTBQZTVTV1hkTWJqZTAwd1J2b2lHSzJqNzZZOXIxZ0s4R0VyaTNvSmx1?=
 =?utf-8?B?bE5TWk5PU0pZdGpSdlZjZ2g2KzR3My9rMTIzK1FYT2lTTG5vd0xLN1lWd0pa?=
 =?utf-8?B?bzEvNnUySnZnVHJJVDd6YWZNdnhmRnpvcnc0MFdHOE9Ec2ZsR2oyc0RKdTBI?=
 =?utf-8?B?TmRsWDEvZzUxeDVPN1RLWnFsaWo1RXRCL3Y2RmJST1Jzd1paQkJkWkszWFlP?=
 =?utf-8?B?Y09oWUZKWWZTZ0Nyc2pBWUMzN2xCdVE1bTUzOWZ0dzZpOXE5NFE5dHlRMlJT?=
 =?utf-8?B?TTNWengyZ1lmRHpqd2NNMW5BbmYrTFgvek5QOHB4VEdYSk9xMHA0aVRxT2l0?=
 =?utf-8?B?UGZrYmVZWG4rSjAwSjgyR1BsNXRzNitCcWVVU0ZReko3UDFSY2x0NVJOVXFT?=
 =?utf-8?B?dW1KT0xKdFhHamlJSW0rODkyek8yUU5HNGdWK20vT0FBUllGYzdqMU5tV3p4?=
 =?utf-8?B?RzZEZGUxV0FoZVNhWDNUVWVqNHhHTUt5UGxiNkhFSVNtbXpSbEdRZVNHQzBz?=
 =?utf-8?B?U2RUSkxzL0dxN2RyUHRqNGdIVUpRT1FiV3hJRG9BbjkxU2FvUVc0cDdvMDJE?=
 =?utf-8?Q?/rfrtJoFD7NJgdMb35vizhwWOy438GUP72fExYr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd576e0c-98cc-4962-8996-08d97d48ed2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:44:02.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 357RE1QcrcNdtKal/87mRyt50fI3GPiLv7Zp/xV+Fv2D41sPneNctgot1NAL4OUiFyg6lrFCG+BcrHCiAutFug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/21 4:34 PM, Kirill A. Shutemov wrote:
> On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
>> On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
>>> I still believe calling cc_platform_has() from __startup_64() is totally
>>> broken as it lacks proper wrapping while accessing global variables.
>>
>> Well, one of the issues on the AMD side was using boot_cpu_data too
>> early and the Intel side uses it too. Can you replace those checks with
>> is_tdx_guest() or whatever was the helper's name which would check
>> whether the the kernel is running as a TDX guest, and see if that helps?
> 
> There's no need in Intel check this early. Only AMD need it. Maybe just
> opencode them?

Any way you can put a gzipped/bzipped copy of your vmlinux file somewhere 
I can grab it from and take a look at it?

Thanks,
Tom

> 

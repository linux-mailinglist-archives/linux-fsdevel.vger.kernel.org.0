Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7D53F1FEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhHSSdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 14:33:52 -0400
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:33671
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233792AbhHSSdv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:33:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STwLbGpSQkL22y4K7f02OkgNaBI90N3zDWvXyvqbnnDY4OLBIyg60BOPkaYbn7od66UC2w7ykPxZDHz46pe5pX7lLnHrSzplbT5KaUbG/8W7CTuRWbzkRby+f0iEin0XmouHz92B4UMyTWLqbyhgWgNddZnpoSc0FfubBynGn36Xpz1X8H8v1AU8bxxldbiHG7t7QOuBkYBDMyMvwA47FGtzv5cBBin3RoqJPEHPamqrG74NJOj4+4GQALZSMHEh1U8/BQNYcthvYkQJXjMnY+/IuxqSThO/WCCtgIDghg6Th7E7z7fybjTXMvPYR/+ZrwEPDwZr5AqFnRTPE+itAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZSbDLkzNWsalGd5dY10VnPSx1Ls+Qt0l27qHYAEsJ8=;
 b=HlY67olGn5phhxTsJNQmO5wRyAV17FAfv/0CamFjYIL3dNqmRQBfwHO+jtO/pKlq0rRIEyKkPKOgkOYNnWgBiWUdG9rn/P1oEZETuARK1Rfi7LieloUN/cCQnCDtM2RR16HDkv5L4AJOcaRMdedctqd9Lukd+UKUdX9EVT57EPB4uoHAClHqCqpeZzixZJ2DAl3Ru7trVrgfMzf2ah0k6ncNW8qib7OII2zhxOGISCMB6lfKAglx+IPNwAOOF/LWVOe+TMYD+Z9V0sNACYTjEN5pIkeeMJ11oapZnN48clWiCJBln48pSy0KztTXp413TtGaaiFDQL4TO3xCHluOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZSbDLkzNWsalGd5dY10VnPSx1Ls+Qt0l27qHYAEsJ8=;
 b=iDyMNxRAspW542jmif90ApmEltSSV8vD0oQ6RKhKKsScxwiyynuGQeuz0FpL2tFDFh56hNlGLMCDdbr6JSAGqpZjQgOHRd9ZVMJJ9liBsZoFVvao1Xa7nqGuwLsp4nLKutXGvO1nfAdRFRGA8rWA4PZtGN6hPkcPNAxwYwN5XjM=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 18:33:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 18:33:12 +0000
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YR4p9TqKTLdN1A96@infradead.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4272eaf5-b654-2669-62ac-ba768acd6b91@amd.com>
Date:   Thu, 19 Aug 2021 13:33:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YR4p9TqKTLdN1A96@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:805:f2::21) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN6PR04CA0080.namprd04.prod.outlook.com (2603:10b6:805:f2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:33:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab94110e-0fb4-4def-19a4-08d9633fcd20
X-MS-TrafficTypeDiagnostic: DM4PR12MB5120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51206EFA62CD282E36FB8227ECC09@DM4PR12MB5120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6IQE9KbkWq8ctP0zpVQosyKO7QwqqI/mMHpM1VC8ce48mHwojUQVJVl7j/OA+28xeutJgF7KbPIp5xzWox7q+zkSmMxd7ZTOdtmugd7JIZwR/vE3Se9eT4EIUQqUBiOMx6TRWHF8cK0ipRffOtR609qCmHHf4PyuI0wfFIgL8KoX3/olg8sVyYs+iqZBMrkzDX2AU/UWuYkvfoi16QIeSEmVI6IDwkg/0VWCd6yQG1e0gdrV4kE/3sB1+y0dotkhKJtTRqdLQDPaHoNQ2YTnitjPIkPtHQI7Xegvuux3HRGcBGGSaqUC9Kum22h5zc9do7ZLg2kzdlo4Rjq2WAm+FQESSAbME+0JZvpRnf8xYQ6vcRfRz0YqbEawKCX6eziHxupDOs79/04hhCh6OFUoWkOTf1rVp2DzR/M1e2mha/jG9X3EDpYFJ2IcvZfFf//UYAzieGLYNpv+WFVqEgTWBGTBenmVUebZKebQXw+wWYRtb3Rw2jRU60XRzNc0RMWW9usNQyfwZzb2QAmCIgAm8NQllaQmty5PWVxdII6qJ8ZpBY7kL2BIRkIVHcd0Gs87SlDgtEHYignP/1J5/bymEUdoAGPQvwoyNXUrN7B5EmIJcuLlWcQZFLAR6k39SC5ZnJa3ZLkPzw9K3bi0fdk0Hqrf4K5XCamEthFc6UmZozSMd8uDEyogpdFXiJJCe9Kfu6ldvR2MsXptuwStpsgM6dvAuJyj0Bc/DPNdkvKgQefUxMA//aZ7Y0jG3lEw30i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(83380400001)(2906002)(66476007)(26005)(53546011)(7416002)(16576012)(66946007)(66556008)(5660300002)(6486002)(6916009)(186003)(2616005)(36756003)(478600001)(31696002)(86362001)(956004)(8936002)(4326008)(31686004)(8676002)(54906003)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pOUU1ZSEtpVWwxbGowZHRrNjUwUDhzZXhZbXVRcjNqREhHZlY5WFJSb0hJ?=
 =?utf-8?B?aFJSWWtFbnVzVzd4VDg4S09kS2trQ2cvcjBGS3l0WjBxSytpdnBpNjRvdlBa?=
 =?utf-8?B?NDJocnBPUnNubW81S082RkpFdVNSTDkrR0NsdGg5QnhsaHBmMWJYSWhSYWN4?=
 =?utf-8?B?UFg5NzIvWWxPQ1FOeFBTWDQyN0ZvazBRQXpoZlRXNUtPVjRncTV5OVFWS0x0?=
 =?utf-8?B?NDZqN3pRODZBQWVrMXdrSWJqcXU4NFg3NlVYV05XRnlPaDdyVFU5dXFxa0FS?=
 =?utf-8?B?TC9YUTJwYWQwWnJVcGczNXdZTXFsSnh5RkJ3M3VhZ2NkV3FyRTNYUkQ2OHE0?=
 =?utf-8?B?ZTBBZld5aURnNGJWQUNDVU8vbDc0WTNHUkNheWdTS1NiVXg2cTNUMnlPaGNF?=
 =?utf-8?B?aWRvWk9GOXlsWDZVMWxWLytDNUVQdkg1TUZDVnR4N2IveXpBTjF2eW96NGhq?=
 =?utf-8?B?cGh0RmJnazh0UkRkUnA3bS9xcDIydjU0ZjN2TGxCL3JtTkJCdFhtdWVqMUY5?=
 =?utf-8?B?QnBjVEZVdGErZE1URE9SM0RsRGJFbVl5UVVlUzAxYlBlVlN2ck9zWnJRb01H?=
 =?utf-8?B?RHFVYlZLeFQycnQwQjUyVllPV2NKR2hFaDMrWnZpeUc2L0Z3NFBFa0llRDJx?=
 =?utf-8?B?MjlLVnZ0Z1h4enBKaDRGbkhrRkRuR0FQTWcxVlZBTitzZElWS3phQjEyZU1j?=
 =?utf-8?B?amlGeDE1SFJhSnEyVzd3QjBwc2pMOEtLZ3JQNWg2c21hc2E2aTBwOXU0T09h?=
 =?utf-8?B?Tms2Njh6TVBWQlAzdG93cXFHTGRJcUpHSFJJc2RVTUVXc3lOOFRBN21VLzl4?=
 =?utf-8?B?dmo2QmRFZGM0SkRXWWFNMXNjcnZncDd1dVYrcVVDcEhxQ3o2anRmV045b0Ns?=
 =?utf-8?B?dytJcU1VYUZQRmpCK3A0RytxN0hDRnhoOVVwLzJaTzlRK1RySW0xdWptaTFa?=
 =?utf-8?B?TkpheG9iYjJNUlNXZjVaMTU3K1JiUmpReHhwKzNBYnFwbHB0cTU4ejlrNmNl?=
 =?utf-8?B?OUY5dFRuclY1SUIrYjFuN0JXUE8vVG5VSThGd2srK2tLWm85WStybWRBdlRB?=
 =?utf-8?B?SmpvNEpNZE9ZZjZDcnN6NUYxaml1a203NXdCbDlUbk5lRDMwNGFJZklzOFhB?=
 =?utf-8?B?N1Y0Y3h4N3l2ajcwWk1yNEhCN2VtblBKL0tsODFVbHdoOCtGWWFVSjloWXBL?=
 =?utf-8?B?OW5sMmdTV09NRzFKQlVOL3h6eUZFdmV6TnhFQWs2bDlFbVBFY1k2ZUNyamEy?=
 =?utf-8?B?M0FsSnVFc1ZBK2FkNS9PK2lUNVQydkNVK1c2ZDBlWnltbjVpQnBnV3pmbHdS?=
 =?utf-8?B?eVpIaDVPZ2VLcTdRNkVZRzROUVdLMFRrdmlIdDVUUWxndndGRVVndlE0NFlP?=
 =?utf-8?B?Z2kycTdTYlJvVXdvWFNSWjVoaHlRbks1MFFZNHloZW9jM0p0bElReGJuSlhJ?=
 =?utf-8?B?UStFZDR0K2NRcVlnOVJYeHdtbjB3NitaZllVN09HZWxxamJQY0VOYXdlYVhC?=
 =?utf-8?B?SEtMQzJpbm1DT1VkdkpCTi8ybmUvUmd2S0oyT05CZDRHQnh4V0NPcjQxT0J5?=
 =?utf-8?B?dVhuek9ISC9QODVDMWpmL0d6RWw2SnFBODgvLzA2d2NUZW5zK2IwZ0c0SmNG?=
 =?utf-8?B?RHpjK2pwL1lyRWVsQnU4N0swSGowWUF5a0UyaGpNa1RmZ1pVNU5RRUdIU0c3?=
 =?utf-8?B?TmhTTTc5UjA0RmRJZm43dlZ6VTFodEVadnI3OHEwVnQwK2tDMC9uclpkRnE1?=
 =?utf-8?Q?PDgTPExTXOMVVygygYPkPtF3LrokcEDh7NJUAzt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab94110e-0fb4-4def-19a4-08d9633fcd20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:33:12.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBy2xDQApYsRKH0htVZtHiZk6/sVUWLG3Mz6LSaYwmW7WEbfsQOUYn0A2vOKwNNM6RZUhalPekNsOHHnVQCw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/21 4:52 AM, Christoph Hellwig wrote:
> On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
>> While the name suggests this is intended mainly for guests, it will
>> also be used for host memory encryption checks in place of sme_active().
> 
> Which suggest that the name is not good to start with.  Maybe protected
> hardware, system or platform might be a better choice?
> 
>> +static inline bool prot_guest_has(unsigned int attr)
>> +{
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +	if (sme_me_mask)
>> +		return amd_prot_guest_has(attr);
>> +#endif
>> +
>> +	return false;
>> +}
> 
> Shouldn't this be entirely out of line?

I did it as inline originally because the presence of the function will be
decided based on the ARCH_HAS_PROTECTED_GUEST config. For now, that is
only selected by the AMD memory encryption support, so if I went out of
line I could put in mem_encrypt.c. But with TDX wanting to also use it, it
would have to be in an always built file with some #ifdefs or in its own
file that is conditionally built based on the ARCH_HAS_PROTECTED_GUEST
setting (they've already tried building with ARCH_HAS_PROTECTED_GUEST=y
and AMD_MEM_ENCRYPT not set).

To take it out of line, I'm leaning towards the latter, creating a new
file that is built based on the ARCH_HAS_PROTECTED_GUEST setting.

> 
>> +/* 0x800 - 0x8ff reserved for AMD */
>> +#define PATTR_SME			0x800
>> +#define PATTR_SEV			0x801
>> +#define PATTR_SEV_ES			0x802
> 
> Why do we need reservations for a purely in-kernel namespace?
> 
> And why are you overoading a brand new generic API with weird details
> of a specific implementation like this?

There was some talk about this on the mailing list where TDX and SEV may
need to be differentiated, so we wanted to reserve a range of values per
technology. I guess I can remove them until they are actually needed.

Thanks,
Tom

> 

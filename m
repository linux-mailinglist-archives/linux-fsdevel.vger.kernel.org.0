Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259E93EC492
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 20:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhHNSt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 14:49:58 -0400
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:17792
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233256AbhHNSt6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 14:49:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdkGwytLwN3cAhLEDcnpf64Be2KWxZ0qWnAqDxE+jL7NlINqhuR5gNcWiSCqBj1zjzI1NWuLWUs2RNwl1zLMlQaE9fKK1XedD2jt5tjs4GKF/G+G6Mosib20foxqIxipkp0Ai1SxkVhCapWwQsw9LVbissVU9v3N6rqHYp3yLpsc3uE9jBqrV+aRDNikcHZBy/79SgdhFYsisk9xuo7q+0LNoFKqiB5GhlDCtvZeBLEaRfZ+CkJrKitHC1oa9rldNrjIyh9yURLCSCQobhmVLA7UdStZs4aZO7QlYhqnymyYTktxGwa3AU8o6mwnhGqgNRvFft2E2W7SAtSHbetHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgskADnp/JlKbzn/ZXphTbBHXqx9vosHmjhDimPp5Vc=;
 b=T/rwZgyVNKgKUu/O9KV9MmtpDxX2VVs991lXWwA5x35fCWKv21/McNu8ypSUPFXcjQhAHUmrxwGq0toHeXk1DiQ+jAazx2m0xdbI++gGM0Z8KdJzky5lxUdxIG3tMvUNwo0eiz44QN3XXNQUhEci7By43qCTqgnIc1D/UoYB7cbT/Zp/4VJrG772PgezKoQ+hiWaB/IQG1eqTB8va/9JGVuzzP9g+Y4KbCIMddMxQcRgq7f+Bgn3d+v9pBUo36FagPLBv0Ery1fHlDesWt5WLxLRVuQnh+LRCH3UEChaJAPIhoKjkNYk8VBztJUIoTtWU8BurCdowPAE7Zg2jeQDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgskADnp/JlKbzn/ZXphTbBHXqx9vosHmjhDimPp5Vc=;
 b=bqpaEsdIvd1A0QaI47PgcG0OkBy/zfLg2oalA/CxYw1nQKClrFO0BehZjQ3njzQXgEho5MyyMpAIOFDs5BtpIpba54V8KwWYxkcWWnZSys5qScCrw6JbNG6xWKKWXGGdoZrJH5O8upde8EtpMxBEIffX4Wam4z8h7351mBZ2iaI=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Sat, 14 Aug
 2021 18:49:24 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.022; Sat, 14 Aug 2021
 18:49:23 +0000
Subject: Re: [PATCH v2 02/12] mm: Introduce a function to check for
 virtualization protection features
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
 <YRgMUHqdH60jDB06@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9279dcd1-ccd9-c187-1b95-8934d1bf298c@amd.com>
Date:   Sat, 14 Aug 2021 13:49:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRgMUHqdH60jDB06@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0202.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA0PR11CA0202.namprd11.prod.outlook.com (2603:10b6:806:1bc::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Sat, 14 Aug 2021 18:49:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3836133-80ec-4656-720a-08d95f543bc7
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5341139F5DC8386A15241D86ECFB9@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4y+HzWp+Gz2Rsm2daSWF2dKwvAwhG7l9BpPgSoW4ghfw/K+IKyEU4niY2FM1c8P5/a3CFRUOyNg6BnnmPgExZy52+CX4ZoyJwnvA/+YAapBLaz0PHUGAe3Jg+0R5Ko71WXzQ12SnxWiwIUEJUQPKYmfgqqzcSdtOE3KfGMQsTKh5qIH6q/q3wC3UTqlyl9vhlcqoYWr3dAlEH5eFmfMuzdEmnVx8px9e70xkRhmma6nUE4BE6skeFU2aXqdKSAZLSCimr0Oqj7RmP+j9BKjfTpL0brlUoq9ibBgrD+vNLBbIXAHnrfhZJ8hl5NA4ceDM0/K1WEejDuzBVybmBJWbfBYtW/u3mjdGQmHCqc06TBwXTzZ58Co4ZU5yqRHZVxn2L/rBzkpQpbRP8Ak/aowsOIMHUpkjSRRsAOPau/JGeclrEXLf9xgd091H4uPdzDlug8eoz4GPG2bTIfi8Q3JgEr25//woFm4UN/NvXDnF8/gredfliHkalPgH0mlPOVp6/8VTC91eqMR9fZqbQknYLbuzY6PJQYjJRrozlab+G3SG9OCGmprMXPPWrWgNYHoAQ4zG0R3HuwrHFvgKPqZJdz4pvcWassDoS4w49XUlUwkJRirCm4RXg8ssiY/IPCduItotmBnr0X73P5qvUbXNd+NtT6PqfWNzKPEW1jhyYa5zEj/hbfG6ZUkRxt7U+N8bnLb934cPMtiYq/S1QWjU/kA/5HJp0ez/PRJPGKkOEW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(31696002)(54906003)(4326008)(186003)(53546011)(2906002)(6506007)(31686004)(86362001)(6486002)(478600001)(8936002)(8676002)(5660300002)(26005)(66556008)(7416002)(316002)(38100700002)(6512007)(6916009)(36756003)(66946007)(66476007)(956004)(2616005)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rll5ZmhJUlRCblFWRHV3bmYyQnhSTTQ1U1FEMUJDa3IvYUJSMWpCMUp3NG5B?=
 =?utf-8?B?aENGdjJhMzgyNExxaFR3WlRLMkpZczd4ZXdRcTJyZHd2ajViazVRYTJWZmtw?=
 =?utf-8?B?K24rc1pTbzgxQm0wT3hLdlFrNE9UUmRqTGwzdER4ZXk4bWduRDhGMG03eUdn?=
 =?utf-8?B?Vk55U1RKTklMRzVManFzdkdCQ0hrSE1FaUhHZG1NV1F6V2JXUmJaVWUrZnJp?=
 =?utf-8?B?ZjQ3RkVDNFE4T3YvTUltOHBod01GNWRkSW93Ym5meGlscFZkM1FBOHN5TnZs?=
 =?utf-8?B?NTh2UlZ4SUxrN0wyYVRuUmYrbUs1SXVPM0NPMWplMUhyMVdJTnpRR3E2aDFm?=
 =?utf-8?B?RGxTanlYbFNWTkxKSDUvaW04VzdPNW1QTUVmejM2VmplY2pBbjJ5WmhFeFpk?=
 =?utf-8?B?NGlmOGpiTXZneW91K0Q1Y3pBTERhRU5sSzRCckdxblA1SGs4UE5tVWpxNnBS?=
 =?utf-8?B?OFg3SnJMcUh6NHgxdjg0Q1RuMnN4TVB1MktQZjBkZ0lrc09oZC9scUdSUSs3?=
 =?utf-8?B?NHhreFpsYWh3VldOYlVMS2UwVUZmOTFxRGJTVFBKd3g4Tlk1NUh4UFhlelVl?=
 =?utf-8?B?aGc4dndXdlhucVl6aHQ3eDJSZlZBblBXdWgzZXYwMlJqL1J1TW9mWExjOTI0?=
 =?utf-8?B?ZlYvTk11b09UeGFzMDNISERGNUw3UFNXQWtmSkVIcjJpazBjS3BMTjVIRmQw?=
 =?utf-8?B?azlVNTJuSHZCN3NKVXhKSjRRUk03TFNIMVUzQTQwWEtHOTFacVd5UUo0bGYv?=
 =?utf-8?B?WHFmN2MwQTJIay9KSUp3eXpEUUd4MkYxdU0zQmY4VkNDdFdDQXdGOTdPMXA2?=
 =?utf-8?B?aFNlcEd2RWFBSzFBL2h2a1JHb1kwcFhOMnpJK3dyaFMzbzJESlM5QktHaklB?=
 =?utf-8?B?R1VxbHdPaDliOTJPdmpyNFlsZWlxaFRTejJ4QWRFQWNzaHVkd1Y0REJ4b2VN?=
 =?utf-8?B?S2tyNzhIamo4RGcraWJwZ2NFRTdEUE5zbDFPRlIwRGpMVmJxem5uTUxmUnFO?=
 =?utf-8?B?K2R5bVBHd3RiK25LMUpMcUZ0ZXkxejRhcm1ub1BINnlwVng4NC9haUZZSStJ?=
 =?utf-8?B?SitvS3JUTldlTVl1Wm9MeHlZRUV6Unk3VlE4YWJRRTVoMitqcnhMKzVpNWsr?=
 =?utf-8?B?VnRTNTFDSkhBVEloMkRKMTRXNlB1ZDRIMThXL2FJRWNnWkJ3UzYzWTdqbVpq?=
 =?utf-8?B?dGFoNGRtVUtZZjdqOU1zeCtrQ2swdGlSWTVlK2gwSURBYVRoeWx2Nm0vTkhK?=
 =?utf-8?B?SzFyTDRoNm00Q0NqZ3Y2eTJSKzdQNTZDZjQvY3pYWkU2OFB6eFc2SlRCcjFG?=
 =?utf-8?B?ZndMVVorOWRqU1Z2eTdkbXp3MS9YdlZBalZhSkY2UW84cTc2UVBtVkJrYzdZ?=
 =?utf-8?B?VzR6NHdhZjZmb2E5MVhEN3RRTSt1V0habWRuVEJodWdCMTNweW15MExldmN3?=
 =?utf-8?B?d3pGVFBmWEFNSml1eHF5c0s4M3pNUnk0aGMwZHN3SFQyZ3dKbnlJOEx2UWdj?=
 =?utf-8?B?VTBTcjJVd295VlpaUnVSYktXa2VFTjM1NjNBR0lIcXpKcEJ4YmhPM2xJc1ND?=
 =?utf-8?B?Tm9nOGd4Tzg2ek4rZGtZaEd6Q1pqVm9kcnQvdnhNdmNzR1BRYjNGTWJ5enVh?=
 =?utf-8?B?LzJyMHhYSllHUHg3K3FXdUJIdWwwWks4a25uc2hxemh6R1hUa2VuK1haNFB2?=
 =?utf-8?B?aFpQRml4U2RvdS9wNmx0azF4NHgvYjJKZ0l3SjFBOE1pa09UODViZ1VONFM0?=
 =?utf-8?Q?VDQ3NBldIRAaVphVU3iNoZMUi+NgKtN9V3karmx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3836133-80ec-4656-720a-08d95f543bc7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2021 18:49:23.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3KxbEwNYZvFBg8WDMyZfkMRzJWgpOX28PP/qqAT4rSzD+BzTZPnUl7DcHAKu2KoLjTOsqh+WZiTE631wkpfcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/14/21 1:32 PM, Borislav Petkov wrote:
> On Fri, Aug 13, 2021 at 11:59:21AM -0500, Tom Lendacky wrote:
>> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
>> new file mode 100644
>> index 000000000000..43d4dde94793
>> --- /dev/null
>> +++ b/include/linux/protected_guest.h
>> @@ -0,0 +1,35 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Protected Guest (and Host) Capability checks
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
>> + */
>> +
>> +#ifndef _PROTECTED_GUEST_H
>> +#define _PROTECTED_GUEST_H
>> +
>> +#ifndef __ASSEMBLY__
> 	   ^^^^^^^^^^^^^
> 
> Do you really need that guard? It builds fine without it too. Or
> something coming later does need it...?

No, I probably did it out of habit. I can remove it in the next version.

Thanks,
Tom

> 

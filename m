Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E463EEE36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbhHQOMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 10:12:37 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:49300
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234446AbhHQOMg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:12:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk+YiVt19MCvUAVXgfk+LEih8nCIgACOeLb8VKEMJALdmRhucJJhMwX2QxwVqybJomkki/C2ToDtQdzw/GG82igxOhTNO2VP6s1jmS0ljzNEJL5GM68qSDz/ddS6e+m/Rl6Y5It2WrGNI/4mzLDdVxAqfKG5WSZwh+/FtPEcGPB+taMISr6WyUwf2euKsC1xz/pNSd/a7pLKEiDC5B16N1vg04eOQf0s0q8Quon8ic/9h29SPZSiedeqPofCJ0gJmGqpUtmq0ipCVR3uywjTECU8PdLqi2R8thleIcae4AAsqMLUhzJBXWE8qmVeezzUnNtOxs89cZG8oiSfm3fHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lqvgc3MxYbKsVgklPeW3fUTtOlNjtFWBUt/iYNTeZs=;
 b=E3c2cxByPFxbYJrkXzxkYrVgak61ZuGjtV2CcwC5RDyzjICSLcscIlqQGz6zgm3Z1SzJkeovMYst99oOh2dqxRFZFBhsR6y+9VUPulmv/BJfW1x8UXkxddWN29uT9lC4UjBzw4zSU4JoeOWjF9/V6tRotV7fIRyyRL6Cxnu7z1qXkItQ3aArhDG8nroi+/4ZGsvbvrbXfdTtLT7h5DN9SI/qYKd4G129b8V+ZS0r0saQyzWFzs2rZZ+GdrNDNxvLewIHPBV3I8u2Q3FnzWcq2Qxv2O4jthbAt8cMN3dd16ZBqjOKuyehc04XfdEYykL1LZAjBx1Gn9RzRHoGS7A+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lqvgc3MxYbKsVgklPeW3fUTtOlNjtFWBUt/iYNTeZs=;
 b=tJdl7wZFPiKTu9TlRhgC2Tdewc7IGJNWF30PDKfIVqkLR+PcyrU8pRITXcjd8RE3C2RaELqSaI1DmqWiDHJwlnaVQqxF1Q0fO7R68r+K0cOaBE/5n0y/hfsaOPhCSQxAs9hASEJlqolSLmeB5Zj5KLPfvtJ2UekWUSb4XyH7ROg=
Authentication-Results: samba.org; dkim=none (message not signed)
 header.d=none;samba.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5533.namprd12.prod.outlook.com (2603:10b6:5:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 14:12:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 14:12:01 +0000
Subject: Re: [PATCH v2 04/12] powerpc/pseries/svm: Add a powerpc version of
 prot_guest_has()
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
 <YRt01F6Mw6sB+hF8@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <66b3b6f1-2ffc-9eca-f7a4-6db7532a2983@amd.com>
Date:   Tue, 17 Aug 2021 09:11:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRt01F6Mw6sB+hF8@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA9PR13CA0149.namprd13.prod.outlook.com (2603:10b6:806:27::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Tue, 17 Aug 2021 14:12:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50b3f8a-2121-4dfe-4d6e-08d96188fb94
X-MS-TrafficTypeDiagnostic: DM6PR12MB5533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5533EABFFF3A869022838DB7ECFE9@DM6PR12MB5533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdP1pPBBx/GUlSL3nrSNLZmoKlbeElJ3GHxsgSowo9ZL71e403aUX1OQKQM1GDj5G9mCMpKu17MoxUy1u12cM2v88yzHIjoWDnBhN6jRovgSbF+vJYTkOLbhY5b3vI3TA0PJd07ka/rkZxTIF5jDmk6g4hhFR/j4Z9LXUT0zdC3NEUIGoQ19yfqBTGRwReFMjS2vzjeSXZFe3IluFJ3yZRrbDfAoyOENwpnyk22hyK9lKp1dgkyPJw1lCavSDmjZvTBmRTXcBIC3uJY60G/57sDjWR3ns2Asev2Z7s3BnhifhMtSkSS/UwiaB8aXMrmoVo/iK85UyitoVpDj6rv67cRLVGllNYeYRMLDeJYD4zMs19/8O5n0+yKvvBe8qlu835PHVhk7lJepIvORp62Dobzqnt/MrbzpKkYEGmZglpKmN67mO70d6F6LbjIwwq5RxFOOyP22J7Yg+DJZ6sfiFsTJdukLF6JD1evnsukcT7VKGdFAQB223olOOfEIsMNqaPUeaV/7HYS9AYtCtrjBx5YGo4H6cnawwcorxJCjqJ0C7Rbs9FpbN7c1ut5vUofrqFwGZLot7e1iJInijdbdyx2lEERORfQ2iKTg6Dz5Rtssln7C+bGcgr2jE65OEqg0dx15BuqsFrdbnGf7RirOiVFwY90byogAdJHpGyUMdrzgIgD+NPtOse2Wr8ZyaWMtp8DatPEzpB317olfrStrbRnIaKRLe55k62aSNLtgRHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(4326008)(5660300002)(53546011)(316002)(6486002)(186003)(38100700002)(956004)(8676002)(16576012)(31686004)(66946007)(31696002)(36756003)(6916009)(8936002)(2906002)(54906003)(26005)(66556008)(66476007)(86362001)(2616005)(7416002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1ArdE5TVFZyUllyUHRhNG02REVQbjk0VzlGd0lJc1NyZk1nNTF0NE8zM2dB?=
 =?utf-8?B?QmQrenI3c1NhMFIwR09iNFFEaHhLd1ZEL2ZmMDRMeFRQZWljeWMxVS82a0I3?=
 =?utf-8?B?SlljMkFsUTBncUNEWXJhdkhuVExiWG5xL1luSmlHTjc0ZlE5NGorS1dVMUdS?=
 =?utf-8?B?Y29kUVozYW1BTXNZNXp3WnZXYWh3dlVqcVJnUU42UW9UbVRFOGE5L21FcjFy?=
 =?utf-8?B?MWJhTE1mdGw1RzNNME5wNC83SHlXMTVPQ1I0c3BPRVowRE5mVUNJTU13MG4r?=
 =?utf-8?B?bEk5Nm9LUWlWdXlUZytCM3V6dHBacDNuN2RqVUYrYXZlemVTRnpuRnlkK3lZ?=
 =?utf-8?B?eHg5bXBBNkVFdzBFdXNLUkZRSVNacks1MDI1bzNKeWZCQ05jUXNZQlVEbTI4?=
 =?utf-8?B?cEloNzhYY3NHLzFISXlOVXAwVld4eU0xMnV3SUtoVEMzVUtCdjAxbkxWdktr?=
 =?utf-8?B?TVZQc2RFY05RTDRQZDlOYWcxOHZKOHdacTVxd1pMUDFZLzlHVjd2cVRNdU8r?=
 =?utf-8?B?MnNGM2VxcTVyYUtkWmJweGxGeitxUWlqT1VkRXk2eE5Sd3N4ZGxQQkNJQTFs?=
 =?utf-8?B?a3ZuUTNGMnVBb09GNmc4N0Q1K01nVmhKaitDY1JMN1l0SGM0NG1oMWEvajBK?=
 =?utf-8?B?TC9lNFYyeEhNeVlwR0d5T1NadFZIUzRkZVNjQUtJdVdRdUxRZWZNamRqWml2?=
 =?utf-8?B?aXFsdWJQREpOYnRTQzZXd1NxcFpHbTBtOUtlSVRiNEswaXVxc1RBMVAyR0JX?=
 =?utf-8?B?UEpFekNMSnppbnNVUEdab21MMzVkeGljVEtNZzM5NGdpbFF3cDNFRktJYTdO?=
 =?utf-8?B?YXphU1dKR0N5MnhsNUF5OGNzbjNzYlhTNG5FZU52eDJRUE0wQW0yZHBJZFVn?=
 =?utf-8?B?ZHgxeUxlVTNnVVJFaE93MWh5R0tGY2k3VXlGREVpaFc0VzNRVGN5ZXlpdEJQ?=
 =?utf-8?B?Wlp2N3llTFJpdGNvd05pb2d5UXpSbUhFZWFvdHV3Q2ZCVCsyQUljeWVicEZz?=
 =?utf-8?B?SFR5cktNOVM2dzZ0NGQ2WkJIdU50OHRpdWMzZUluZGdaV25ad3cwMVBleno4?=
 =?utf-8?B?cGlXT3ZHQWdvcHlsdk5RSi95OEtXeEh4ekx6dWZONGhJNkdiWkU5QVlpbThS?=
 =?utf-8?B?bFRhc2FZVTRTZXp5ZjFFSUQ3bnd3TmNPS2FBQ01VcllHZ3p6ajN1cDQxaWtj?=
 =?utf-8?B?Zm5oZGdZTTIrNFhKazNEeTBGZHNmalRkRWxuMWtDcTlBODRzWktEeUNPRVN4?=
 =?utf-8?B?TUZJQXhtQlE2bDQvK3NDMnVvVEhSSk5DcDZKR3RJQkV0dit2c2x6NzA3aCtt?=
 =?utf-8?B?M0dYSlRTVHdlOTA5RWdEMU0rb1lJZk9KdXgxZllNVG5nQTUxNjNlR3k0dkZv?=
 =?utf-8?B?b1pGbVV1ZkpUZkxiNG16dlh5RGpvcWdRV0lyRCtyKyt4RkZ4NUFqTGNLMjR2?=
 =?utf-8?B?YzZSYUtBaXQ1NVpKUUdjWERhRGhtZ3VpRUxQRnNCYWllY1hya3hJamlGUlhC?=
 =?utf-8?B?RE1aeFR3NTRHQlJyNVZEZkVyTkpBVjgwZmdpQm5nREE1bmhVeWczQTVBSXRL?=
 =?utf-8?B?emhTMHdUR1BuMlhuRDB6Tm9yY3Fub0hnTm10ZC9Hc3hmZWJVeW9XU1luNXQ4?=
 =?utf-8?B?Y04vNEltUUdaZ0JFc2piSXNTa015SGlMS3BsRS9UR250cUh6RGkxbE5sSVhq?=
 =?utf-8?B?Z1B1T0ZtY2l2M3Rsb1R5NGZ1bWdFWGxDNGN3QS9uNXQvUkU2K1BYUzNnZXI5?=
 =?utf-8?Q?wl6XMcPSZgNp+5Nu1IfXwDZ5sm/3rjd1QCvbLdQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50b3f8a-2121-4dfe-4d6e-08d96188fb94
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 14:12:01.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2CFQkDa7LnYaT8s9+R3zdkwp2Am9q+i+mGYHP+N7ZDllAaICN9I3Aie0LiX9vFIxI4RMBMeg7Ckkleqp5Qtrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5533
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/21 3:35 AM, Borislav Petkov wrote:
> On Fri, Aug 13, 2021 at 11:59:23AM -0500, Tom Lendacky wrote:
>> Introduce a powerpc version of the prot_guest_has() function. This will
>> be used to replace the powerpc mem_encrypt_active() implementation, so
>> the implementation will initially only support the PATTR_MEM_ENCRYPT
>> attribute.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/powerpc/include/asm/protected_guest.h | 30 ++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/Kconfig     |  1 +
>>  2 files changed, 31 insertions(+)
>>  create mode 100644 arch/powerpc/include/asm/protected_guest.h
>>
>> diff --git a/arch/powerpc/include/asm/protected_guest.h b/arch/powerpc/include/asm/protected_guest.h
>> new file mode 100644
>> index 000000000000..ce55c2c7e534
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/protected_guest.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Protected Guest (and Host) Capability checks
>> + *
>> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
>> + *
>> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
>> + */
>> +
>> +#ifndef _POWERPC_PROTECTED_GUEST_H
>> +#define _POWERPC_PROTECTED_GUEST_H
>> +
>> +#include <asm/svm.h>
>> +
>> +#ifndef __ASSEMBLY__
> 
> Same thing here. Pls audit the whole set whether those __ASSEMBLY__
> guards are really needed and remove them if not.

Will do.

Thanks,
Tom

> 
> Thx.
> 

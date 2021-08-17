Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C943EEF0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhHQPXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 11:23:31 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:20961
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232675AbhHQPXb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnkOkTz8ayobEncKGXhZfgKgGeiq1GaUNsNeBpn9iWrn93SG8oj0fbcMDNIMCRQne3064V+m34rO0ZmWjobFXvF293eicGRhfk0VH/l6nkmRHnKstx0DqQXcWHYUXrn0TSO2fWlWhp8JbhVJ0YvughB4r0BB+4Wy5lGM7yccWQupgfQ6buQAW2GYZfkQE0CcuB+yCr2MWdGAoozPNU9W7tASoT56K9aDnMzDT8dolsmg7UJjg9SIsNnw75xk064fC02/u4RARwA+uj/M3gatQBJ/m5CkjDxEn97/mF4f06tG1bgrlonZnKsSWOeQji2Mvl9jdIKTKPyWyPsu4e0Dgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gRk5fLuQVgRRV7BI0Z3z40DCFo5r8tfRt3Cc+PWrNw=;
 b=lrRt6nG0FUU+imPcmOQcUeoStCdVAWJYVUBP5w1Z3elYhRXpJOYl3QxvsNmTOw37wWMmmhFaVCxvhs1maxh/PhlqXzNQcH7dTFUDJ248UkVgk9ZmCQUzDyzbdmTcEiI6h/A/krhrY9y4deYyVY+3jrPZunxAR/fvRwQcgHMERWq+EeRaqyhqNrqQ4662Dm4QaNRGFp1tS8zuZ9UGUGtFT28aE4kj0B210gCTC+LjgrsA1kvXMF5IDznE8nks0CJQhuRfvW+tIvZuCNk6ALargdfPEezAkct3pgWD0o+ScGHSZ0GfnFSB32OwTnCNSUYZMxzOgwMiRBVwnPcfc2UcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gRk5fLuQVgRRV7BI0Z3z40DCFo5r8tfRt3Cc+PWrNw=;
 b=cGQwdgTmtZ8bYv8K/9p5UY/iQ4rAB2eDTd7gY0rYtGNZe2rgoPnnTyHjCKWciCgx2xxA8BnBo3sf5+JN9Ho/ccAMXEN3keeaJ2joTyc/n5PTl8L//54vdSkdV2OiP0msGjjiAQhFXNINh8j/to9r0w7/P9gPgQV4v/lLHMajjKw=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 15:22:56 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:22:56 +0000
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
 <YRgUxyhoqVJ0Kxvt@zn.tnic> <4710eb91-d054-7b31-5106-09e3e54bba9e@amd.com>
 <YRknDQGUJJ/j9pth@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f4b8bc3c-5158-cd04-6e12-77f08036ea19@amd.com>
Date:   Tue, 17 Aug 2021 10:22:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRknDQGUJJ/j9pth@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0156.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0156.namprd11.prod.outlook.com (2603:10b6:806:1bb::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 15:22:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f788a7a-eb3c-4dbc-4f38-08d96192e326
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5071802504CA9625B52A467CECFE9@DM4PR12MB5071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7HcRnazornw/9YJIVKaWLmGuygkc5dzxaV4yeQMkCAFASNhEeYv8gb3Po+CLeBALingutIOvDzzUn2YzaWNbfwO39QuVWyCRJRMW7t6gS/jlGf92ufyk92mzmnB4cNtstDkxv/79/uNIZP+fXVLP2qStsG67+4HnY6dthtGzId2SaJpWD/N+Bl+rO1e7ajBY3fuvitBVn+lyPSpxAQrOYgspJsIZdYWbPHg4A0miDBl+/hwgHKcp6JIsr5enBCTQUV9nkGKuOISZHnI5DcsS41HvnxpsWAyi6XTCv/BqvAOfv5wSCRdazWnAOzgOVm4MbA8SKf2rYwOssUHd1ErcbQb++a0IRMGm9JSZ7e2jmzHaNsGRHjhd41ATvdpt9LVhXGvobkKFGEdvg2YnOulRJihuOUNE4J0FOAsbM5LpjZiM3qLylv9QZVhdT7KVH1QGrGTgcIefkBP9gB+oElD8viIxjqInmMv+lEj1enOtjZmtCI/SiRDgRDCKqJ3ZfsfIbzWVMXNrZW8WtrSeEEHjAr58QNpOtxSfbcqA9UCtzo97WpRvsirQkpHVK6kankFT+Zyrtttc0RpxYawf0BtdtTVymJ0EKp3KitNkeRwmwUN1j/NvIsGI7pymLgymyNrW0nA0MmRHcdE83Wm+7t5Bwz4KuIumkwMpwqXLkjkzc314O0pedq/XOVr6PthamJAr5xzU867ipi5rdRc8AFNw8uFAUUurQLXZOR+CaCIYttX6sWwvPU7i3/7SIdHoH9p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(38100700002)(53546011)(16576012)(4326008)(36756003)(478600001)(7416002)(54906003)(186003)(31686004)(26005)(4744005)(83380400001)(31696002)(2616005)(6486002)(6916009)(66946007)(66476007)(66556008)(86362001)(8936002)(5660300002)(316002)(2906002)(8676002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRrN0pYZ2J3OVZacHpkS2dPTWpBcVB2RkE3SFY2QkRGdS9XcHNZUzYrTXFk?=
 =?utf-8?B?K1lYR05HZEFLR0Jqa1dlNDFnZ0dhZGJJVllEVUdvc1I0akpYOVFvU1BON3VR?=
 =?utf-8?B?TVI0b3FZYm1Ecm9QTGYvRWlwbXhCb1FxV2NmWEdmeEo3VTlVbVZ0MTFFRk9B?=
 =?utf-8?B?NHJKVXI1Z0psbzREa3pOSWNwSGFjWkxrTlVWdmdlUUhDaUZSY2dFU1hXb1pu?=
 =?utf-8?B?SlI4cWxXa0xuZnhOLzE5WU8rT0RpNmE1aHkzdk4wOGl4RmZpVFBpaWkwTVNW?=
 =?utf-8?B?QTFURHJGVExVRFJEVXRUVEJEdGNJN0Q2MklYQ0taV1p4QkFhY1V1d1dXVk90?=
 =?utf-8?B?ZEZiaGNjRHdhd3ZxWUY1QkhGY21iYXBwa3NadXEwcUhNcVVNci9FdE9KK003?=
 =?utf-8?B?Qi9UbEtmNTA1THlEU2hsN2lyWU0rRklhbTg0TGV2VjkyQUJSNWUrQzl4bHFt?=
 =?utf-8?B?Y1l5UnRTTFNFb09ONUdNWmk0dW5wZlhaalZhdmlScGNqdE16bW5lRjRoeXIx?=
 =?utf-8?B?dUU3dm1TdnZWZ2RIVnZ3ZUJDNjFoYWZYd2RMNll0T2VGYTRubkRVZzJ3V2wv?=
 =?utf-8?B?dUdIaUhKMG85cHBlSGY5bVQ4TXpRWU9ZQkM5VENjK2ZQMk1hMGFaMFlOVVAw?=
 =?utf-8?B?dXZXR1h1YkZiVkIrbUo2cGJCRDdpaXlaZUJpZXdOUCtsbmNITTZLU2hWeGs5?=
 =?utf-8?B?ZWhQVlUxNk5GYXVWQkVrK0Vrek80d2hSNzFkOEdPNWNCNDhBOFJrYVRsb1k3?=
 =?utf-8?B?MFpZbmRVOW9wMVhCeVpsd1FxRVQrT3Fick1pektrTGVXMU5SeDg4RnhJSVo1?=
 =?utf-8?B?SzhyNG5JUGJqT3pkM1VTNktBNzJFUHMxdDZTSDJINzVOS1MrY0ZKMXdUUXdw?=
 =?utf-8?B?bFNwSXV2MFpHZjRPWTJOb3ZTZmJZUHovRTBKQzNnelpxT3E5N1VnK1dtYzN5?=
 =?utf-8?B?RVFCby9nSk56QmZXcVBFWEhmbTVJdGJ2V1ZoZFhIV3J2VElPUms3RmJmTXA2?=
 =?utf-8?B?b0pPb2U3Z0ovS2RwWU9Gd21CdUdsSWlGZnVXUVZ1OVBSOHphY0ZvcHVnN3NU?=
 =?utf-8?B?MjZLUFhYMmFrUFZUUmNnb0VCOWlIYzN1elgweWc3L2Y2OVBKV0twTmhPdm0x?=
 =?utf-8?B?WFgzRUsrTlZNZWRxdUd6Qlo5bW4zVUIwdURqcm5tSTVSTFpmR213OU5pRzI1?=
 =?utf-8?B?a2dNVlpucXZDbDl0NkIyMndFSEMwZzRBQmVaSHBsOTJPWi9HbWJoNEoraUE4?=
 =?utf-8?B?YVV4MmZrcWdkYzZ5VU52dzVvWHBNZVh5YW1yTVg5RzJNY1hGQzJuWmhqb0g3?=
 =?utf-8?B?S3pHWjhqTWM0QTVoaDZ2eTA3Q3NUOG9QbUtpTStlYWJUVWFlZWpqRHRtbGZO?=
 =?utf-8?B?SGYyblkybFM4SHlqUkJWc3M5dHJiZUZQbHJHMDV5Wk1FUGc2L05neVdqZ2ZI?=
 =?utf-8?B?M09jNXhxWHM2US9jbVRaK1JFTTlEZ29mQXdFd3o0b0VxTTdSOHZCK0gzYjA5?=
 =?utf-8?B?N0RPQ2Zzek56OEZrT1IwYmEvV0FXd01tTVRScVZlcHFQTm9oSHVWS0duV3Nu?=
 =?utf-8?B?YVVXTjV0ZStSZkkvb3FLMnZ6QktmNkYyYW0rYWZmd1IyS3YrUytlbzlvNGpi?=
 =?utf-8?B?eUJ0Q1dsOEJxUUszeHlLM3JraVJiUTRNYURFZ0N2OWdEdENhNVk4RnRwUk4z?=
 =?utf-8?B?clVseGx3ZHZMOGVRRWkrZDh2QVZXV2VMY2ZMcmJWMG9ONXlSSGk0bDJ3NFUv?=
 =?utf-8?Q?scb2k7FtYKn12zt/GgAKPecYE7RGmQUFeCp7Nue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f788a7a-eb3c-4dbc-4f38-08d96192e326
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 15:22:55.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMj7l5WH2pnjn36DZm8tsJZ+5II/JgjGo4WG1L0a/I1D6IaBbEbZWd215TxUcWfes5Rp11YWbP5vY8WPTgsx/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/21 9:39 AM, Borislav Petkov wrote:
> On Sun, Aug 15, 2021 at 08:53:31AM -0500, Tom Lendacky wrote:
>> It's not a cross-vendor thing as opposed to a KVM or other hypervisor
>> thing where the family doesn't have to be reported as AMD or HYGON.
> 
> What would be the use case? A HV starts a guest which is supposed to be
> encrypted using the AMD's confidential guest technology but the HV tells
> the guest that it is not running on an AMD SVM HV but something else?
> 
> Is that even an actual use case?
> 
> Or am I way off?
> 
> I know we have talked about this in the past but this still sounds
> insane.

Maybe the KVM folks have a better understanding of it...

I can change it to be an AMD/HYGON check...  although, I'll have to check
to see if any (very) early use of the function will work with that.

At a minimum, the check in arch/x86/kernel/head64.c will have to be
changed or removed. I'll take a closer look.

Thanks,
Tom

> 

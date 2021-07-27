Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AC3D831F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhG0Whv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:37:51 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:27762
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231730AbhG0Whu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:37:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ycpg/pKWrPv75pddpgxZTS+Su9qeIRlWwtfl58MXS/sijpbufH0TW/H0nEeQdzZqheCw0bQvKjI7WJio2km16V2PxXCSsDWMCUz5m2h+ZhkoWpr9A0hlR9iyyqscnF1YGVM+ofM6njkwDMjNKOCTahERrTuQIRq4TdgxX2aWlG6Javsy3Qw1CNoiIKciJZ8XMrDGbkvStr1XAw6zAc4wgQ/ei9vuH/o+qsWmvYsr+MY2fQCC8N8uO76dsBuuhSCpLfinJIOeyKDKw2RfiPAu4VvSIRdHLcNQhIpO4XQQxrOxnvR8bViD1yUMSs/X0Q7ad2nt7MRWM3qp/avlB0+l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOZTM9MHPyCbEBwOnCqNBcNa1zgGHPvbcxpz8sdqVG0=;
 b=OMhXwA7jCF5V220WtyKGuN3enEZ3OEZZVSHM4ClFApklkQCYlkIfETDSF/TSTcXP6s0U+p2J3F1q6TOG4K6PSPFo/hUgwFIyszqLhtMkwUunSY74CW5018lnBZuOFuSgqzBTUAzLhfYW+f3KucSiWSppMdWlGsPN/o0ZK5GuMTRHH9gUWmGfYSk4RPxEaMIDD2DmB3g5sGzLPsZq7afEmNe5Fz/MAj/b4xMfcvwNQQsoeG+b0bry3UYiCxNLJSLZMWGOrnmasYJpbKDESODEn3ER8olGhx2llq1EenRA/+PXMUHG+QHhu7z6xqtXQmtIRSNhDmmEkTf8JzmC/NRYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOZTM9MHPyCbEBwOnCqNBcNa1zgGHPvbcxpz8sdqVG0=;
 b=Har5QyPeoJkndwx6SWpIUSIliAqopdWKbq+o+FnNHcEDQskUJQ7azZD+N1vH9tgnpoYgEiuf644hHXAZ8WT2eoSOV42lVy41WyH3/wKVz+T6a/i2jEHRK9ptI8CMcy4kYwsDDs9B5++PwjqrekJcR4xHaZgWPGMJJl1zbggm20k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 22:37:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::73:2581:970b:3208%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 22:37:47 +0000
Subject: Re: [PATCH 00/11] Implement generic prot_guest_has() helper function
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
Message-ID: <fc88728a-76e0-2493-1d82-9b228a67de63@amd.com>
Date:   Tue, 27 Jul 2021 17:37:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <cover.1627424773.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:805:ca::22) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:805:ca::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 27 Jul 2021 22:37:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec27482b-844d-455e-b431-08d9514f289c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5326487FF3D4BE061B4B099BECE99@DM4PR12MB5326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zd5IRcCRbNaVyibIHJCh4Z+HudUSwrQ01bE/kkT1SNz7h4egsiDNgikYy5bRpYofGZF3vLnGS/gVvKynMmQ24v5cU4UoeXHqei193m0Xus8VHcFMNKXhRXprstn43Ndx5VLlFUGFHSKxmJvI2UJYQSLSWSCzXltwb+XtSvz5Nstp2RVd55Jy6SmbqrNvvHGzhu8CYORdjfj4vVNGDEBavghbixhJfonKqsOXSYYmR/2e0pnSa73f2n0fRJaf4Jc4XKFfEIBN2KaneuGB6T9KZOf1pMp3KDORSGzJ3Yh0Pd0aQv8BwXKiwtwd3dFxhlSuvV3jdnGlW5zNqhyP74BdJjbl9V6yolptpnOtcRyYLJ8DiVYNviVMTxTdKPvyP6CobNT27fmwHVRxQcEZm4MK+K4PQFTWnLtF0fk69ar0m6Sh7XeJt0KQ3Z8VxM6UsuX944LHa+/IwGjWrTQB/9CkdUqy2LiS+iv1v76Vg811wd2BJjAkktUynuzOsfAFPAj1uRe5uM+i5ZBck1ZQUTb3FcJ9gjcD4qg3GkWIZKFqCvtmp9u71gs2AbaDTOW4pD+zwfq1tqrEFCbMtvYIdDlspjdsHCrnb1go37M35FEfVqEKaqXeLIdu4CVA7hHOMU0QKyO/Ye4O44uj4eV18vZF/+ipkLgF63V2WFDMWdf/SpjEeQhrKvX1xzvkF1+iNMDqg6Z8QcsRGMwCQRffEj/Sl6ev7GkQS9Vn3Sdk0SBOBdmSZ8ut3Ov/8kOYeVPCq6G9qWrKZ2m95zxtYXMlEjkyl2xOVuOsOMRLyg/JumCVq1EU2fW53kEgsVH4dozgkrRT6id+TK6g5QgmLgS6Me6BjWisiXQEzsaW2C/322xdpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(478600001)(186003)(5660300002)(38100700002)(921005)(956004)(6486002)(8676002)(54906003)(7406005)(4326008)(7416002)(2616005)(966005)(66946007)(6512007)(53546011)(8936002)(316002)(31696002)(6506007)(86362001)(66556008)(31686004)(66476007)(36756003)(2906002)(83380400001)(26005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWIrSUNGSkg4d25MV1c0U0t3aDFCMmM2ZnhOaEJQbGo3Vmc4K0pFNnNjUmxj?=
 =?utf-8?B?RFE1VlZUVzdCdlk0c0k1NXNxakxZaWhHNXJMWE5VTHRQdW1vcUZwYU5nV2s4?=
 =?utf-8?B?NXphbkt4S3ZXVXFKSklYU3pwVVMvYlJUN2RDMXdnZHJySllidXVJMkU3cmsw?=
 =?utf-8?B?VURBNm9hQm53MWJ3Slp3ei90eHlyYmdRY2ZaOFY0WjliaDUwalloZTZZNjIv?=
 =?utf-8?B?Uis0eWE1bVpQSitZZGxuOGFLVU52UEJjS2R2SzZEaHErb1RWODhuK0tMeXNM?=
 =?utf-8?B?UmVqem9oM2FyL3oxMG1rdlRnU1FIdlpySTZuc28xdk5mTVY4S25LYk9lekJj?=
 =?utf-8?B?Q095ZWc3SVdIU25jRmQxRFg4VG1iSVI3YUt0ZG5JbnUycE5mK3hLclRmK3NC?=
 =?utf-8?B?Q1hEUVovVzliOTFtaUJYL05YbHZiN2tXa0pjMzdiSFkzeTlXWnR3NEJGTWNx?=
 =?utf-8?B?cU05UWx1U1RwVEU4Mkc1VmFGYndrMEZVRkZEc1dSQTNZRTROU2RmdkgveExx?=
 =?utf-8?B?QW5acEphSUdYN3pqUnpjSEc1QWZBeTAyL25yMTNOV3E0Nzg2SUh3Y0RpaDl6?=
 =?utf-8?B?enF5RWpzVEJ2UlB5U2M3dEEyNVphdUM0NUZiaENZRUJyN084TDdhTWgzRDFx?=
 =?utf-8?B?SVNwdzFaTnhOL1dpa3hobkFQTEQ3TE9IUk1NbTRpRUF1S0JrQWttQ090eDEz?=
 =?utf-8?B?Tk51UG4xV3FFK1lNeFh6eEMyTThzT29xU0F0dzBIT3UwUnU2ZTEvNnRaSGl3?=
 =?utf-8?B?aXJKSlBYdWViTGJ0aWQ4cXhoakpxTHZBOHdCcXdON3RmRksyRGRpTmNxVVJq?=
 =?utf-8?B?WDErR0VzczZKVUdLZldjdktsQ1FLNWtaQWh0c2NnTEtvRjZyTWdCNmRwRENP?=
 =?utf-8?B?TU0xVk5HaGxQSTBIQ1pYUlZWa1p6RUJYTFk5dWY3RFpFN1dubk5nUzc4R21O?=
 =?utf-8?B?Z0dqY0pUWndnNWlYVnpOb2dMaUhCQkVHSzN3SFBjNDMzYjl4bFpQVjBWbWYz?=
 =?utf-8?B?MnJzNUprYWZoQmdBd2orUnlUanVuRHVrUWpScnBOVnk5d1Jsa01Od2lFdy9W?=
 =?utf-8?B?eEJ5VkZ5L2JFV1hCWFdZZmZRUXNLNlE5U0lXbERWZy9LdmpMdUkvcTR5dmZ2?=
 =?utf-8?B?RHc4ZEpsUnBQYnBITDFhSHhMTW4vVmFta0V1eWJ4UjNWd05JajlKZ1Ixa0xy?=
 =?utf-8?B?NDZnUkZwd0p3WiswTVVKZjRJU1pPOE1ZVlVod01ja3NwVEpCd0xzMWIzNDFJ?=
 =?utf-8?B?TGpySFhsV09mS29Zc3V4NnhjaUxkKzh3aVcwdUQ2QUFQN1RPWlJWRVZvMzFV?=
 =?utf-8?B?MUFST0RuK2RYeDJuVTVrWDFzWmU2d3pVaGVvMjgxVWtZcmhKUXU0d1JncXRu?=
 =?utf-8?B?VDVrVXl5WktHTC90YXR4akxEK0xmYmR3dnFJa3lLT0RXMmhJMzhidGlqdmda?=
 =?utf-8?B?Q3ZBbUNMUU1HUW5zQTNoMU83QjFnOE9kN0x1UlhGejdrREZMTkxaTGhTbS9W?=
 =?utf-8?B?NkxSVzRTNFJGclY0cXlNbEJiNFlML01iMldtbFZhdVN3djQxclVDbE5MOWFV?=
 =?utf-8?B?emVmSUhsVFM2amYyeFg5RUdxVm5iNWxCb29PZi83RUtUY05mRUNHckgrOG40?=
 =?utf-8?B?eHd4ZWxaMEQ1enp6VEh3bGNvL3RKS0pHU3F0TjB4cnBNZFVFbEU0dWw4SUhj?=
 =?utf-8?B?Mmk2RUJHTEpSOTkrTkN1ZGExTlUwdEJXQnE2TStBS2NtNU1YNThHRnNISVNL?=
 =?utf-8?Q?+A8OR2jDtC8xQ5fYnmD9dceryVv5Dc+5+4tVSOn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec27482b-844d-455e-b431-08d9514f289c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:37:47.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OHG8EC0Dqz8v+NOfbFgQKHMFon0CnGYaC88gIPuvJp4Of1ppYnHA5ErRbwixuqJsdNVdi1cvwJ/ZW8qfw9P0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/27/21 5:26 PM, Tom Lendacky wrote:
> This patch series provides a generic helper function, prot_guest_has(),
> to replace the sme_active(), sev_active(), sev_es_active() and
> mem_encrypt_active() functions.
> 
> It is expected that as new protected virtualization technologies are
> added to the kernel, they can all be covered by a single function call
> instead of a collection of specific function calls all called from the
> same locations.
> 
> The powerpc and s390 patches have been compile tested only. Can the
> folks copied on this series verify that nothing breaks for them.

I wanted to get this out before I head out on vacation at the end of the
week. I'll only be out for a week, but I won't be able to respond to any
feedback until I get back.

I'm still not a fan of the name prot_guest_has() because it is used for
some baremetal checks, but really haven't been able to come up with
anything better. So take it with a grain of salt where the sme_active()
calls are replaced by prot_guest_has().

Also, let me know if the treewide changes in patch #7 need to be further
split out by tree.

Thanks,
Tom

> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
> Cc: Will Deacon <will@kernel.org>
> 
> ---
> 
> Patches based on:
>   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
>   commit 79e920060fa7 ("Merge branch 'WIP/fixes'")
> 
> Tom Lendacky (11):
>   mm: Introduce a function to check for virtualization protection
>     features
>   x86/sev: Add an x86 version of prot_guest_has()
>   powerpc/pseries/svm: Add a powerpc version of prot_guest_has()
>   x86/sme: Replace occurrences of sme_active() with prot_guest_has()
>   x86/sev: Replace occurrences of sev_active() with prot_guest_has()
>   x86/sev: Replace occurrences of sev_es_active() with prot_guest_has()
>   treewide: Replace the use of mem_encrypt_active() with
>     prot_guest_has()
>   mm: Remove the now unused mem_encrypt_active() function
>   x86/sev: Remove the now unused mem_encrypt_active() function
>   powerpc/pseries/svm: Remove the now unused mem_encrypt_active()
>     function
>   s390/mm: Remove the now unused mem_encrypt_active() function
> 
>  arch/Kconfig                               |  3 ++
>  arch/powerpc/include/asm/mem_encrypt.h     |  5 --
>  arch/powerpc/include/asm/protected_guest.h | 30 +++++++++++
>  arch/powerpc/platforms/pseries/Kconfig     |  1 +
>  arch/s390/include/asm/mem_encrypt.h        |  2 -
>  arch/x86/Kconfig                           |  1 +
>  arch/x86/include/asm/kexec.h               |  2 +-
>  arch/x86/include/asm/mem_encrypt.h         | 13 +----
>  arch/x86/include/asm/protected_guest.h     | 27 ++++++++++
>  arch/x86/kernel/crash_dump_64.c            |  4 +-
>  arch/x86/kernel/head64.c                   |  4 +-
>  arch/x86/kernel/kvm.c                      |  3 +-
>  arch/x86/kernel/kvmclock.c                 |  4 +-
>  arch/x86/kernel/machine_kexec_64.c         | 19 +++----
>  arch/x86/kernel/pci-swiotlb.c              |  9 ++--
>  arch/x86/kernel/relocate_kernel_64.S       |  2 +-
>  arch/x86/kernel/sev.c                      |  6 +--
>  arch/x86/kvm/svm/svm.c                     |  3 +-
>  arch/x86/mm/ioremap.c                      | 16 +++---
>  arch/x86/mm/mem_encrypt.c                  | 60 +++++++++++++++-------
>  arch/x86/mm/mem_encrypt_identity.c         |  3 +-
>  arch/x86/mm/pat/set_memory.c               |  3 +-
>  arch/x86/platform/efi/efi_64.c             |  9 ++--
>  arch/x86/realmode/init.c                   |  8 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>  drivers/gpu/drm/drm_cache.c                |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c        |  6 +--
>  drivers/iommu/amd/init.c                   |  7 +--
>  drivers/iommu/amd/iommu.c                  |  3 +-
>  drivers/iommu/amd/iommu_v2.c               |  3 +-
>  drivers/iommu/iommu.c                      |  3 +-
>  fs/proc/vmcore.c                           |  6 +--
>  include/linux/mem_encrypt.h                |  4 --
>  include/linux/protected_guest.h            | 37 +++++++++++++
>  kernel/dma/swiotlb.c                       |  4 +-
>  36 files changed, 218 insertions(+), 104 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/protected_guest.h
>  create mode 100644 arch/x86/include/asm/protected_guest.h
>  create mode 100644 include/linux/protected_guest.h
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EDF3EBD30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhHMURr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 16:17:47 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:62944
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233890AbhHMURq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:17:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGw0U9FkgKp4hxsvcFdS+Z7DUF2Um0cW04RoIpgi//zy5IZ39Kz1fCX2rVhK9AfVPCzIZx/VN+/c0vKLjcELXtCeqlZEkPZhhS2XiAfPgWhgMPuEdvIhHN7rBVvbCQams9QlvgTp5FsR8jCKuu39Gtbgm0OZ+Qn86bPCokiEi4UDBO+eeCQ7XyeWjdlfMm4hv3airl6E+yaPDId+2s512TtyQbjafNM0Gx3IYB4zzGH0ejWseKFeD1hF5InIjfRLO3d/akqNGHR0KClTwfFZljax2IYs8nKrhO2BbTW5mosq8j6ZERwGi2ni9faElRKE+XquZXbgcBbdvP+h87A36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpwOvDM3GnwNTNcL815T+RSOydEG+h+3oDIg9dnFcc8=;
 b=EMLZ5P4NMpgY2QIUrBxnmxGsz5hDMG67hy4Mog8GvtOJgYyqUItuz59aeYyBFPlRSns5aRKJYaYuB3r4WULP65T9OWtOv0RdVSGJu0Icg+VGxcNNUCgbMZFTV5Uairek2h2CXjpfoW01HVKZlpw3q+v1wM6g42M2n7dbFRJFxyWX+84zq9k25c7lFC0po7sv/rVgzcUxwaLNRYDAgcB61bcpPj46NVIOv6g5OLvE+va68vyZ8p1ex93HYhmoQhFd2O3SSzsJQZf/jjzLOe85x3iisIzBrCByNHjGXWr4CYrcpUHLMJmnaVZvTfqUucinEUcYywOo3H00deM7niXn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpwOvDM3GnwNTNcL815T+RSOydEG+h+3oDIg9dnFcc8=;
 b=MyTmwlzgKeBu9Kr9AdaSE1zoak8QxWlRT/g45sd8A3BxVuycfnUWDTtSlbv7kbm+wPD+NOE8KuxfMaVbm1BHq28hmB5OTiCq1m8BAT98u8NbbFWus7koWMgW2ellOLwPUjgB57RbR3+znK3BrbrvmdTSLWxPBzjHKCg3KahE5E4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 20:17:17 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 20:17:17 +0000
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
 <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
 <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
 <20210812100724.t4cdh7xbkuqgnsc3@box.shutemov.name>
 <943223d5-5949-6aba-8a49-0b07078d68e1@amd.com>
Message-ID: <f6399958-d161-fd58-fac7-9b849bc4f05e@amd.com>
Date:   Fri, 13 Aug 2021 15:17:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <943223d5-5949-6aba-8a49-0b07078d68e1@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:806:21::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:21::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Fri, 13 Aug 2021 20:17:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb04504a-2bc8-4b11-096f-08d95e97582d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5056CC972FC97575617C9C45ECFA9@DM4PR12MB5056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeKYrRV7+y6fb+GcsgwZgLn6m+17BeFDzSYIRsWs+5gk/EvKWEu2gSmv8RvTO/nfbvLfTRsKb1Rmu/IiexH4OmM5yzL1S1M0b1KCFnlSqI8q07PgcARl23shuBOwuXMPNwYrnU2x5cFzlC5kpomANRa9DYwDAdniG9jn0sUdyUssSht9Fj45WNk5kKyCNOwzQkl4Uwfx4ThxvNPm/2ZDWUUaD9h4KXaJfbXl7FOnHluKIb2zyecyHHGHT9LymYEJz5S7RJOMqqWviTNVR18VwG2DXy3EdmYfOUSweCmgr1F5+YNeYL0xuLozBRA3iCSoJ8z186DXgEqoQzPLgGIGWaJStbn3sjliQijGiQArX8StUtsSdv7beBuRfFRJgjp+PMjE74m12pIzia7y7ArUN+9FQfFGXdeMHBWOuZEkY7sXKBpAYhVZL+IzHjCsiTDaKb1dI/aEvOT+HEP3+0pFhWM+gj7aw1TS6rvljuEKICCuVKQxw/iZMHPFqMACRshww9+CkZF74+BBgpYEEwnfE4ZD2OYbNPPAX6HfzpgGABkpn12jKR5rTpzx/1EipOB3U2sOxGm7Mj13MUhqX7AkZsVTyrgswRhjfQpHB54uounI8FMHqOtfgpkX9CKnV73XHRj3NzUtA9k4wwtBs2k808QhRQvjOOhAoq+3kMA1KWhfE7oPISSKTsZBbqCFcKnt8I9jsZEFVs34Lo4rTbbD3u/3KCSJ0GktcSNcge0JTXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8936002)(7416002)(86362001)(31696002)(6506007)(83380400001)(36756003)(6486002)(7406005)(66476007)(66556008)(53546011)(6512007)(31686004)(478600001)(316002)(2616005)(38100700002)(956004)(8676002)(66946007)(26005)(6916009)(2906002)(5660300002)(4326008)(186003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZOV216SVRjR2pvTmN0RGhmT3VtRnJiQzVwZ1JSSTNSZXpET1RESUUzYVNY?=
 =?utf-8?B?L1lpY2EreHNqWE1JTUpwRDhRckxnWmJSNHlqdmxva21GRXFTM2o4Q2tPeVlK?=
 =?utf-8?B?N3UrZkNkcGhLc210WFlYTmtVL3FYcWVqamloTC9PWDVVSE5ySjQ0R2RyMHc4?=
 =?utf-8?B?dFE4SmZDSFJUWnl4VldYNlFIbld2RTBCUVF2dVhuYm5UVnUwOVBRWHEyUGQ4?=
 =?utf-8?B?amdPNGxtNkxBNkRsSXJhK0lPT2lIMUdNVlBaV1FwTWNNeE95c0hYZjQ0RlpZ?=
 =?utf-8?B?YTJ5aEVHeE9VeXB0bWs0MVY4cVdqRzAyYUZLK21ScE9rbXdDNWh5a0lnZFlT?=
 =?utf-8?B?aFVTaWlGUXBrYnNhcVExR1N6V1h2K01IU0JramhHeWZvV3M0RkZERkQ1M3NK?=
 =?utf-8?B?TW5iaU1EcGEzS2hYUklXUkdLR3FmYTg0NmFPWTdmKzI4RzBUcGNnTzcxeElw?=
 =?utf-8?B?NTVTeUJwcUVvWWFMWHp2ZjYvTEtuc09wQWF1MVErdHBodGlFQVZxRWVQMVNZ?=
 =?utf-8?B?N01IbmEyQjRkUFZxcDFCOVc3SG9ERVJETnViSFBCQW1obzdUQS9ENmZ0aG9n?=
 =?utf-8?B?OHhVamdFRXRWRnJNYWlJRTVIenVoK0Y2NE42V3FBS3R6Z0dEeFpRWVRSZXps?=
 =?utf-8?B?WTNmZUNtYm5sRG8yL3RZa2FkNjQvVklLT2owWmNzUHd0K3NIQ1NZYXdIdjUr?=
 =?utf-8?B?Wi92VG9pMG5NamNVeDF5YUpkaW9rUkRGM05EdXZUcTlDQk10ZjRpMVQrb3hr?=
 =?utf-8?B?NDdjZzVZKy9XYUp1VmZSa3Rveng3RG9SOFhGWmtHVlBRVEdoV3orajVsRVlt?=
 =?utf-8?B?bFJSNnJNMWV5WmRCbkFDYm5JQXF4cEtJZ2VRR1VPZ0NiOWdyUENHUUdqTERn?=
 =?utf-8?B?NmxKM2tja0tDc2JPYUxsVFdMNXZQai96Z1c0VlgzTWxsdGFNaHFTRmI2cDNZ?=
 =?utf-8?B?VTVMV0VBaUZBVjZlZVJ0aFhKWVBvZjZCZVhzb1NneG1wMlZtK0dTRTAveWsw?=
 =?utf-8?B?V0lVYmxuNzBENlhibkV2bVVTdEZZSVhXK3B0TEozZGpZYzd4c2ZRNjE5cVhw?=
 =?utf-8?B?RjB1Tk1DbkFDUXJycElqK0t5NGVaM3B6cTcvNVlReUxiR29jVnpVK0VOcFQy?=
 =?utf-8?B?Q2xYR1JoYlJFYXlvZlJxUCtQeERlTCt5ZEl1WEsxQ3R1eVhuSUNpVEVaaE9o?=
 =?utf-8?B?VHFwNnVzU0FPOHRQaUhFUWtLU1lBNlBtZ3RsNDBIMW5EMVhQYXVSZVpKREVN?=
 =?utf-8?B?c21HQjV2RHVTK3hsazFzVEJPSzhVM1BWeEgyajZRcjk3Y0FWbG9NTWV2OXNQ?=
 =?utf-8?B?WGQweHhuMURwc00xK0UvTVB1ek9VL2ZPcVNCdFNncWRzWm9ybFlvU2V2VnNB?=
 =?utf-8?B?MlhiaThjc2FYbTdGNENXM3dRby83cTUvYWtJTmpMdjdUVlliL251QVh3QVNH?=
 =?utf-8?B?MjBoTVpQOTMraUpGcnUvY1Z1aFJDQm5pQk9vY3JmaDJqYXY1QUtqQ1BIamo4?=
 =?utf-8?B?MzRCVjJqYmdUbXRJUEN5cWJWdi8yNUZBejlPdkZVdjFwQjJoWDJtVFdGS0Q0?=
 =?utf-8?B?d0MvU1JpZm4xKzNoejhlRlhaMUVEaUN3anJHdFJhdjcxUFh5OXlRd011R3RC?=
 =?utf-8?B?NFFlVzhUcmFJcm1rL2xCY1hwK0YvVVdua0ZNSi9TaTg0cjl5YTFjbjJ4UTJ1?=
 =?utf-8?B?TnQvbnVIS2Vvb2dsMWtQTFBPRFRmNFNDc0Q4dU1oLzNPYUZXTTJ0L0Z4aTdV?=
 =?utf-8?Q?X4j/QZYAY5VhEB8ISJ7ENzxDr6z08b94zP1ag1f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb04504a-2bc8-4b11-096f-08d95e97582d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 20:17:17.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rYKyb1eg9llUGfYKNWymW6AFqmswxWINdi5GxJCtmBK1fz+zhjdQgfi1wjlNeI3FFBkBzHHXR4HqtkxkzDSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/21 12:08 PM, Tom Lendacky wrote:
> On 8/12/21 5:07 AM, Kirill A. Shutemov wrote:
>> On Wed, Aug 11, 2021 at 10:52:55AM -0500, Tom Lendacky wrote:
>>> On 8/11/21 7:19 AM, Kirill A. Shutemov wrote:
>>>> On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
>>>>> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
> ...
>>>> Looking at code agains, now I *think* the reason is accessing a global
>>>> variable from __startup_64() inside TDX version of prot_guest_has().
>>>>
>>>> __startup_64() is special. If you access any global variable you need to
>>>> use fixup_pointer(). See comment before __startup_64().
>>>>
>>>> I'm not sure how you get away with accessing sme_me_mask directly from
>>>> there. Any clues? Maybe just a luck and complier generates code just 
>>>> right
>>>> for your case, I donno.
>>>
>>> Hmm... yeah, could be that the compiler is using rip-relative addressing
>>> for it because it lives in the .data section?
>>
>> I guess. It has to be fixed. It may break with complier upgrade or any
>> random change around the code.
> 
> I'll look at doing that separate from this series.
> 
>>
>> BTW, does it work with clang for you?
> 
> I haven't tried with clang, I'll check on that.

Just as an fyi, clang also uses rip relative addressing for those 
variables. No issues booting SME and SEV guests built with clang.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>

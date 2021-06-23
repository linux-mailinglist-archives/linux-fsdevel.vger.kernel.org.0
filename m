Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC63B1922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhFWLn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:43:26 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:61889
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230130AbhFWLnZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:43:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0itow/8r8Eba0ujPJENTT44EQFcTxbP7G9cXBlIMRKPBO/pTLhQlt5yPjgaHj6kCXHYg0TeCnvbHF/Ci9PIgZmrBTkShuqzA0ba8WdfHLiKojDNg3uHafxcdhNNy9MYMKlG38P/8Mgm3DXBzbSi+DXZDNIn5BATvfYu1ZLzdWY0cBYy9JzqN4t0NSMCClzw4x/DE77hfUtq7N4FhKscLxyrFeNty+coVJta2M9wSin8d5UIBfYlV92R31CTAdfxnmz0hQh9o10MtiXP577r0EDcdLoGTmqBau2jTSNIMQ8Ijcsi5cELWZP0LHX24471zkRwwF7cJv8pKq00FTXaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1pZ2YuA+Ta53NVvfdXz+XFAXJSIZLJz/4IeerGkP/Y=;
 b=m6qwY3awabyOEqCtKAxV3K/xneS1WGrhR8ryUzXdBiqskE8QqTaN1S9ivVR+gXN4ANdWElberctklWk1FkevuPXwGEEL4oH+EdRX2P+9U0EBJa2yPhUU/fpzqpKVOmHEeFmDeEmfkS0tGfPaPtj1wyAEqWj8zHqzKj/JFE7jzTUZRgUL/halkDsDf4Y5nSiT+pBllXRdQns2ZCQff3zVC2LVbTg5z2aAQ5+bF0AG7LENZLbGgu5/a9YWVbNrU4iKZ0rkF+Ef0+6toSolXyDJCFqqYCj7uaOlL8OlhDvyYqr/lqBLJGl121k1YV/179b0FG/iJ1McpASt0RkjOeOL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1pZ2YuA+Ta53NVvfdXz+XFAXJSIZLJz/4IeerGkP/Y=;
 b=PwIkvBYQOGyfU5e/kaESbtNw7RoMqclsWbbDP1hwNtZlxbN9oXQENfJ0mqq8GMaxXnavavIddYDREXvkRMTSmcCqnL3nDy2RMQHrAEy6/WUvahznTY0P0G4JDjZeG2TUdCpU76qidnuO5p4RGKsaS5w/bnyVBj3avrPXb/Haw1k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 23 Jun
 2021 11:41:06 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 11:41:06 +0000
Subject: Re: [PATCH] ovl: fix mmap denywrite
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com>
 <d73a5789-d233-940a-dc19-558b890f9b21@amd.com>
 <CAJfpegvTa9wnvCBP-vHumnDQ6f3XWb5vD6Fnpjbrj1V5N8QRig@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8d9ac67c-8e97-3f53-95b8-548a8bec6358@amd.com>
Date:   Wed, 23 Jun 2021 13:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAJfpegvTa9wnvCBP-vHumnDQ6f3XWb5vD6Fnpjbrj1V5N8QRig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:69e4:a619:aa86:4e9c]
X-ClientProxiedBy: PR3P191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:69e4:a619:aa86:4e9c] (2a02:908:1252:fb60:69e4:a619:aa86:4e9c) by PR3P191CA0056.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Wed, 23 Jun 2021 11:41:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd2aae41-1914-43b2-33a3-08d9363bc9ba
X-MS-TrafficTypeDiagnostic: MN2PR12MB4520:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45202AC01B5A17CA7C3FDD1783089@MN2PR12MB4520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQnynUSDlTIRWWYpMeDvWBmBl0MjD6jrqujcbAGUEOQZEg3UyAH9Q/cD/ZhZXFmFEHst49Qq+M+Oq0/DujplqfeTboDgyMeOhGiv/0LuxXYu4KmHglnCvtu+bIRVwOhEwMCiz/fUeoo6v/czj892v3FrHVrSAMyjzQIBvOtswCah42XsLW78AGlUgz2Fj1mhXweJ3/xSKPMWOqfNbhLcd17fy7f7csNSsnUcPEmsC+qKhvWkBdJFS/RmypyJ8V6uHMlbv9b0zvVNrdBbtlvzOu8fqCcrjBE84/uERFmNtazpGtHTF5p4xGM02va+lduBNwQSjMnGPXIzK1NMrBuPJMImlr1siYSHeL0f/yLz+NazYwNL2gGC5YIX/G16YXnZbuLyZEXMWtdRD7p3sMbva0fDlIR10ZvmNV0BDBDUHUh/7E939weLIXApT1LGUgWITVdaQ9NyW07e5jT7mdV7p7bHPvQO8S1aY5I2P0mAtqbSVvZITssDkkBIPs/kJIUAEs1LtAePR0P1Xs40aG5BvwUnbEsbRZzMsbgwnZSLyYoJdePV4E7Mza6y+uwR0aXbJmQzPNWcwG0ZPZJfDxKiFMywHTDT3krEzDPXwzAQM+g76d86miDmczQZ3e1ZhbQ0mIVl3EXpl8VW2Pzi+EcEQse+uPeVdC7iv6a+/sy2DMyoU9Uy3Yoj2E54gV5nhq5y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16526019)(66574015)(31686004)(186003)(86362001)(8676002)(38100700002)(6486002)(36756003)(8936002)(4326008)(5660300002)(66946007)(66556008)(66476007)(6666004)(54906003)(498600001)(31696002)(2906002)(2616005)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9aV3Vxc25zbDMzYjlVM0FyRDY1VDQyRldCVEplTWVucFVPYVdmK3NyNFp5?=
 =?utf-8?B?cFRuVUcxVHoxSEdZSzMxbWI1aVluenp5WklnY2t5blZoNHNVbXRQRzZxRlBZ?=
 =?utf-8?B?YUNTc1p1L0Nsa0dzZHJ6VDFVN1o5eWw5N0pNc2pHWXhQV2xVTDc2akt1ZWN5?=
 =?utf-8?B?dU1Wd29JaTQ3d2V6REpDZzlZbk41VkxIcUg0eVRoWHdZY1UxM0ZPSUd2Kzcx?=
 =?utf-8?B?MU85ckMwN2daWUdEcTRqWVphVm1HcGhlTXRnTEJKS28waGpuZnF5cFBnS1hV?=
 =?utf-8?B?ZXEzYS9YbkFBaUhKdWxYb3VOTzkrZVJLZmlXQW8yRHlmc3oyNTJOTmYxY3Qv?=
 =?utf-8?B?SkMyRllHYWlmOVN4UjZkeGVzNHlCVXVUcnRkVlFkL0ErSkRKQkxZeEJSTUpv?=
 =?utf-8?B?enlzcGREZWpBd0RjR1FoTE41Mml5S2dESmZ5MVpTOGxmVG42aEp1SzBKazlY?=
 =?utf-8?B?ejdHWnRWT1MwcHIxWjdEbTZGaExEckllK0FiQXVSZzNvNnlSRlRFeHBnNzlV?=
 =?utf-8?B?Z2VBNlJXS3NLTktyMytMbTRNVGRiczNmSEtIMnpkMlk1TlUzY1B6d1VaVWt3?=
 =?utf-8?B?YmdxUHEzdzNIYTJ1SjR5a0NoMkNDdm41ZndFUS9teWovejd2MkNYQ2taeldY?=
 =?utf-8?B?bXRGWWFocGkzdTV4RFI0VkVZWTltalN6QTRGN1k4c1QrWnpnNC8rVTVKVXFl?=
 =?utf-8?B?VUttNE1PcGxGaW1XSGFDY0d0TnlidndHU0VTaUp0Ui9sbDN1ckJKT0dNTTRs?=
 =?utf-8?B?UXVPYjZjSTRMcncvMTJtdVVHMTBqVW1ycjNhbzFjQ3lHSitlaFVqUE81MUwy?=
 =?utf-8?B?ekJRNVdmLzdydUFLdUpQcUlDRlYxUHcxQjVZYmxyMVpsY0g5SmJNN2pkMlZh?=
 =?utf-8?B?WmZrdkZUMzAyeUlFNTQvRFcyeWlCNlRCajdGczFtVGhlVXpPUFQvSTlFL3A5?=
 =?utf-8?B?SXA0Skw3amMzd2dHMUFuMGpiaXR5YWw2Mm9Bd2ZxNS9XR1QvOGdOMUhkWlN4?=
 =?utf-8?B?MnRxbWsyWG9PWjJxOUJ3b1dZUFY5RFd6RzNhTjB1OERpcVFLTzdJd1IrWWVn?=
 =?utf-8?B?NmZFWTEyKzQzWUZDNVl2L0kvWCtuRDhyYTVCZ2FzMFY2TW9qcEw2Qnh5Nm5R?=
 =?utf-8?B?SDRFOWZwbGgzaTh2V1dmdkhIQUMyWlIxVFRNbkhtZDRyc09wK0dOMGtsRzdj?=
 =?utf-8?B?cWhPckZJUkIya0JBVkNHVDlaV3o4WjMvelhrN0Nad281c29ONHlZUnNIM2FL?=
 =?utf-8?B?VjFYWEJ5QTlFMDd1Y0ZlNWR5aEk0WkNqR0hyeHQxU0c5RnpybENYK0NzRHB2?=
 =?utf-8?B?RDY0aEgxM2pONGlGRFpPR0xhcDRVNU9zV0g5YmRKbUR2UlJyaWw3bzBjWFMv?=
 =?utf-8?B?UXh3VEp4Y1hKa0ZEaEtuNU00Z0JpWktOTHl2ZG5yZGhEZEdPdG1JUWJFa09o?=
 =?utf-8?B?dlVTOG8rT3NlbGNSTjEvTzVnaUppQXNQQ2RCUWdObkRKOE1vaXE5S2NsOFhH?=
 =?utf-8?B?R0xDVnQxelNscVFzc0pPMUpOcWRSVjZzRmR2K0U2ZTdNM0lOYW9GdENuVWNL?=
 =?utf-8?B?WHVNQnJ2Vk1oRjE3My92bHhZV0NzQmh6ZGQ4a0tJaG5WazNua3E4OTVmM2ZP?=
 =?utf-8?B?ODJIZS9BTmttNGNNbDVtTHBFaDVRVUNmRGd2aTNhSlA3aUxod1d2cXIrY3Nt?=
 =?utf-8?B?bXk1Rm5mTVpGQ0VCc0xNOFd1T0xCaEVkQ1h3THJ1QlZZRlFrNnFVQjRpSlha?=
 =?utf-8?B?ek91S0o2K2wzdEhkYlppQ1NQNUZWV0ttcGMxcGJVaXh2aXRra2hxRUI2blFL?=
 =?utf-8?B?ZTJ5SHUzZnZiRDRoQWJ4b1cycEl3QUJSeHVmQ2tLdnM5MElQQkdvQXEzOEg5?=
 =?utf-8?Q?heTIzN/yJRrg+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2aae41-1914-43b2-33a3-08d9363bc9ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 11:41:06.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgXta29uSQ7NOKx4ngFoaM4pjnx1WvDHDXTEEXgL+PblL3tPY/faDTShacHNDUID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 22.06.21 um 17:10 schrieb Miklos Szeredi:
> On Tue, 22 Jun 2021 at 14:43, Christian König <christian.koenig@amd.com> wrote:
>> Am 22.06.21 um 14:30 schrieb Miklos Szeredi:
>>> Overlayfs did not honor positive i_writecount on realfile for VM_DENYWRITE
>>> mappings.  Similarly negative i_mmap_writable counts were ignored for
>>> VM_SHARED mappings.
>>>
>>> Fix by making vma_set_file() switch the temporary counts obtained and
>>> released by mmap_region().
>> Mhm, I don't fully understand the background but that looks like
>> something specific to overlayfs to me.
>>
>> So why are you changing the common helper?
> Need to hold the temporary counts until the final ones are obtained in
> vma_link(), which is out of overlayfs' scope.

Ah! So basically we need to move the denial counts which mmap_region() 
added to the original file to the new one as well. That's indeed a 
rather good point.

Can you rather change the vma_set_file() function to return the error 
and add a __must_check?

I can take care fixing the users in DMA-buf and DRM subsystem.

Thanks,
Christian.

>
> Thanks,
> Miklos


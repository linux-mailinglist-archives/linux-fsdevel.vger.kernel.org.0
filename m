Return-Path: <linux-fsdevel+bounces-10556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDD84C370
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 05:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BFC1C21780
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 04:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EC1B94B;
	Wed,  7 Feb 2024 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ugPk4nRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033A15E86;
	Wed,  7 Feb 2024 04:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279397; cv=fail; b=c/WK056tr3g7P3LZ1EJ6Ik8tZdH90+7UbcuX+fTJ6orzE+1vlW/BGGS5ulYXnG6eOjCXz6fMFJ6LuX4JqR0bUUK05c+3GT9v74DqXblmAtJtLImcUf2zj0jK2oVttprbxV+P5nprOEIXUqZFF0XlnwhDPH51htaDMAE1O+6pB14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279397; c=relaxed/simple;
	bh=NGSa73qydgIjYNCXLgTioKQr8evRLBkt084oBUHHad8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NsUB83gS/2gnIhotbUhU08CVo1ARIA+WFd+f1ImeZROT2elrK4xwsBo+FJXPO5PjHExpYuuRvR/o7/JoXj0EzdZ0H3oqrARPO/HshLvpRuQVmQHhiCycC76CZUFxK0VXQn8q9hxrxiJemKt/YM0fgCnOIACROgzF04usfeaBLR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ugPk4nRg; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRoQyqLfzdqClMAbLxbnKo7NipuWEsQtmNu+oUYz+i0aWPnXKUr+QBdG47/oIqWalfXQeS5KBDgdlVNRWj1CHhbB9uA1UJyTsFO2ddc3Eve+kJEu2/icUNJiMQhawrjSRkC9hr2pLQj4j/OmSLrQBWqjFy3bZyBDC1i1ooQQGGGXrnItN5WqPyXkCGZulj36VNrhPFW7Ymri8UAnPUuQkqb2qKDx7IM6zRekVSc4+0TnbrzZII1uhna6WKGXuSgrLqAmGPyNUtitohWz5ua+QQ9XuqLwS6BuqmfYfRtKZT/sb/GsB0/4WtEeeqBoMyEC+ChJ96I2ZjR3Piwn/9uV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdUIJh9kkwkoAk3UeDI6yb+HYq5ZysTUNrgOmMwUIuU=;
 b=bm2WM7i771/V/vOo3rQCNpMW3FsZh4RNR3QFTxTpEsyH8P9ULicHV0nKU3ItWjdhU+PonlmRMHx0Nk7+7NBSk7WtJY3T68tyQTUKkYnez7e8ZVGul5MPXrxmFuSp7yni1I6n+T7Cyr+WdLauJUAX7Sjr/63qDBUdJ+XsPeVk6oFjOvBYW0LPBGZaOz6axfc42XGif+0GO+22m2oJ46DSLUq3LALXRenKaUpEcc32ul762zjBaxaeDfvmI6Izef/KrJ4GHKShQ30lRU31ErXczol7QFXdYVpDXDEHzQ+dDLMnY3oxOxMifVmd4XpHkDw/OdKJv+PezUtmzq5zgrAeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdUIJh9kkwkoAk3UeDI6yb+HYq5ZysTUNrgOmMwUIuU=;
 b=ugPk4nRgWX4D1pdJOGeb+iHb/eNhbab7zfO89NKDDQhHPhAAZ1MAkQ8DoPBMcSzU+ez+LF8tuS5APXZcwXeKUjrSgYrA7aJ1YNvxCEfF4hKzXw1T+01/xIgI5EGgiOfWmBn59Lo8D/5ZZg3y2qiVvG97g1uyXYKUF2WjgsmSwzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 04:16:33 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856%7]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 04:16:33 +0000
Message-ID: <ef44e0d9-a4a5-4fbd-9db9-7644ede2e30d@amd.com>
Date: Wed, 7 Feb 2024 09:46:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: next: /dev/root: Can't open blockdev
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Christian Brauner <brauner@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
 <20240206101529.orwe3ofwwcaghqvz@quack3>
 <CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
 <20240206122857.svm2ptz2hsvk4sco@quack3>
 <CA+G9fYvKfeRHfY3d_Df+9V+4tE_ZcvMGVJ-acewmgfjxb1qtpg@mail.gmail.com>
 <20240206-ahnen-abnahmen-73999e173927@brauner>
 <20240206-haarpracht-teehaus-8c3d56b411ea@brauner>
 <CGME20240206230505eucas1p1b952da8c57de5dea32339b22e3c98b94@eucas1p1.samsung.com>
 <65bedd1f-2dd4-49e3-8865-0e6082129e78@samsung.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <65bedd1f-2dd4-49e3-8865-0e6082129e78@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 87652176-ebeb-4084-f148-08dc27939148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DPp20EE4ErEO98d6mNcvMvEhhektG/IS/tARhrd7lBtUjI1jGjk5e13Kc2ClFW8UPRy9C5kkm6IWXoTGEDgxaYaQpHJf0nJFlxsF1FjWW53m7k17lq7n/cMYKGIUQ616TV/IjgjcVv9EKYZpuRXVbRRQ7W3ZbPv/3fKZSddsR1M85JQ1LFhPi5w9mW4A/BwlZnop7K+ti4CxJqS95apWlo0JEoCzEIhoJE2/eTjJ0h+y+uRvcqiZAmXEDZqWH5Y2YVAP5xwnVsd9Eg66YOhLEm0oiB8De7OMgeKVyaiL6G5p+dj+1jWPOiG+KxizVvLn9TipC04VeWiUYhXuWc1TqhDMF6km3tKZsT1fM3u548z/2AEZSEribfZI4EAbBjMqfxp+3FCeBVAa1w/ScDJiNr1/D+QlUTKEvynT3SWpYcTio/+JN9xcDPIQ6EchMbv6JMj+dhi9L2JdO5J9DQ3eQe4SzI4hb1ebl5Hg0ix5aABjWIJOI68R0tf/iaBRvIGkOwBfhY0WhduHS4z3N49lpkB7cm5ILGvfQQ0FaYEmqY0eZEMweDBK0oM8GVwyyMImiKw4m6Lr9jgYevVVMe+9XYk8d8bzhMm1uVgigmSdgnZLfRgy8SOmwmU5fGXVVqzQvPrExT4AChCtKE4ZTC/IWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(41300700001)(38100700002)(2906002)(5660300002)(8936002)(7416002)(4326008)(31696002)(8676002)(66556008)(66476007)(316002)(54906003)(478600001)(36756003)(66946007)(6486002)(53546011)(6666004)(6506007)(110136005)(83380400001)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enZ1OUdBb25CcGM5VnlaeDdGckR3UFk2OXUyc1pHQ0RqdkZ4dUVVcFNNeEUr?=
 =?utf-8?B?UmhoeFJuUFBnL0NCeWhLNlZRRExHRllYYVlvKzNVUktPNGxxK3pVMUZveHlt?=
 =?utf-8?B?aFkwYzRzQXVlRGUzQVN3WGFiM1ZmVjFPajR5TEJWYWFOVml4cGs3MXJPaDV2?=
 =?utf-8?B?dDhWcU9lNHZKQy8yOGtFTTFiS3dJMGVhd2VGY1kzZElaN3pnWWNXT09zNDZE?=
 =?utf-8?B?Mnptdlp5aEd0R0NhRFdWcVk1VGZSN09aV0RJWk92ZGNxV3pUQ09UM3VrbTVs?=
 =?utf-8?B?VHRUSFNmVG5kL01lejNKNlZuN3Y3TW45WWN3S2ZQY3ZIT3hMbUt6NzBvYnBZ?=
 =?utf-8?B?RzgvQ1RPM0hQcURvUmFzTHhpQ2t2cWh2akV3QVRlNkRjRkI0Yzh4aVk3LzZx?=
 =?utf-8?B?a1VuK3ZKbEhxN0tTczY5OXZLcDJjNFZmZW5XeXNJTTU3Sm5pRUMyK1VDR29W?=
 =?utf-8?B?NlJCeVVyOEhuWlJOcmNlbjlnWTB5a0Fad3VaV3JrVFEzTFBzTlBzVTEzWkZz?=
 =?utf-8?B?RmYyT1RXdFhtUHEvYVU1RlpuZ3VMdW9RWXJBSFpOd1VoTlJHMGRRMEpZZmxl?=
 =?utf-8?B?VVFGOUJpTTA1bisrQlJNU1NKdFU5cXVya24rS2VlRnd2a3I5N2gxbE1ob3NZ?=
 =?utf-8?B?TVVtVmR4TWd3UWVUcnp6VEwxUitxeWtOM0FoT1ZvYVU2c0RGTjlTT2NGUGxT?=
 =?utf-8?B?L3NKVWxDZXZPaTVlRFRNbGRmMlhSeG9HdERVMWN2MVR2WUNxTW05eUd6Vytq?=
 =?utf-8?B?MXZpWlI0UDkxSDhqVFF4aEZXS1Z6TkJoTnE2ZUJZbTJ5aXVXTm5tdFJ5Uk1P?=
 =?utf-8?B?eENxamlVeUpsRGVscEU1QjNwWjhzWmJvcUVBVk5NN0ZQWExBaXB4QmpBTGY3?=
 =?utf-8?B?YmtEb1NtREkxN1ljb1JSYmlhQUZWelh0RGZGQU1IalQyaThwcFcyYjAvZWRJ?=
 =?utf-8?B?RkFjUnVxQU1GWjV2MzNxQlhuWXZTdWJJR0RUU0xzSk0zL0tzajhaZlVjbG8v?=
 =?utf-8?B?UWlablhHNzBGamNRd1NDMU5jblRUZnpMZTF1Rk16NE05MmdxYm5DSlh6VGVn?=
 =?utf-8?B?MHNKaGlPN3h0bTltTWFJaGcyV3lYY004RUJUQVNBekswclkwRTNkbGMvT056?=
 =?utf-8?B?NkhpOWhKT29vL1gxV1ZQeUlQQmNURDhlVWlCNEo5NW9MamtIMzNNLytYbkNj?=
 =?utf-8?B?MUdya1V0MUtRR1hEc2dWTi9JSmlWcHJSaWxZa3pNWlZHTTVCSExydWRsU1lC?=
 =?utf-8?B?aDlrbkxKSGlVS2Q0bUNhbGU1QWFHYXJQRzVPL2RlSUtnVG9ocCs2NDN4M2NZ?=
 =?utf-8?B?bHRZNERJOHFsQ2VvUTV2U1lHK3RGdEtYUUdjYWFOMVJzZGVyMWlRakFXTm8w?=
 =?utf-8?B?Zzd4Q3VYbDJQM3FUUmNNRkVrNC91MVhwbjVUb3hYR2pjWVh3NzFpb2cxWkt3?=
 =?utf-8?B?OGpEMWtYU2I0c2dUeUlKZ3RvVjN0LzlvdTBnU1RhYytCNWV1bERTaU5SWHIx?=
 =?utf-8?B?ODZueWRjWWo5cGR6M0gwaE90ZW1LNHVPendYejJCVlY1RWNaaElmVklic2kv?=
 =?utf-8?B?UnJzZjFwNVlBRTg5NjFjUTVLbnJzRXVaQ3ovU1Z1TTlneHA4aGNibENCa3Rk?=
 =?utf-8?B?dnVuYmlpYVdCTXZoajh4blprTVQyL3NESUFpbFhHU256ejF3ZVdNVmppK3BC?=
 =?utf-8?B?cjZMaFphdmpJYWg0NlZib2xjeHRISm14NFd5d1d5dTloVnNsSzhuZitYL2hY?=
 =?utf-8?B?SXplOEw2OXJGV1gwendnVjJKQ0FGcVllUHBXbENOY3YvNUxmNFJ0cUlJMzl2?=
 =?utf-8?B?djkwK25DTXNscWJJWHVKREJUL3cwQndlWllKUmJoTk9ZQnhUelcrNStmcHZB?=
 =?utf-8?B?czRiVmZwUHpUb2xQcmRUV3NmdzdKWkQvcUdKMjIzcm1OeVc5QkRKVHFLeXBP?=
 =?utf-8?B?R3c0SkxFY2puQ3dWQ0RUbG0zdDNkZFR0K2dNMDBJb2M0eFZrY2Y2aTR3Q1Q5?=
 =?utf-8?B?RkJ3VmtCcE5GU1g3NnJvbmxMcTFIc3M0RW96ZFhJbDArNUpRUkRkOU1GdEtv?=
 =?utf-8?B?bkFqOW1ORjBOTXlnSWxPRjBmbW5tTEFBM0ZteG5PRUdxVEJudXRJWVI2SEJv?=
 =?utf-8?Q?Po/ZSm6MLckP1pSZjahYcZoiV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87652176-ebeb-4084-f148-08dc27939148
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 04:16:33.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQPn8XkW3c1q4Imipgeg4P/5QzCtv8NmqD+g5Zu91IqumwQdOCaow+P0R6DSMGCcT2A0QNShrsq0DUnThKCf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

On 2/7/2024 4:35 AM, Marek Szyprowski wrote:
> Hi Christian,
> 
> On 06.02.2024 16:53, Christian Brauner wrote:
>>> On it.
>> Ok, can you try:
>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super.debug
>> please?
> 
> 
> I've also encountered this issue during my linux-next daily tests and I
> confirm that the above branch works fine.
> 
> 
> I've applied the diff between e3bfad989976^2 and the above branch
> (bc7cb6c829e2), which looks following:
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 279ad28bf4fb..d8ea839463a5 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -19,6 +19,7 @@
>    #include <linux/ramfs.h>
>    #include <linux/shmem_fs.h>
>    #include <linux/ktime.h>
> +#include <linux/task_work.h>
> 
>    #include <linux/nfs_fs.h>
>    #include <linux/nfs_fs_sb.h>
> @@ -208,6 +209,10 @@ void __init mount_root_generic(char *name, char
> *pretty_name, int flags)
>                                   goto out;
>                           case -EACCES:
>                           case -EINVAL:
> +#ifdef CONFIG_BLOCK
> +                               flush_delayed_fput();
> +                               task_work_run();
> +#endif
>                                   continue;
>                   }
>                   /*
> 
> 
> onto next-20240206 and it fixed all boot problems I've observed on my
> test farm. :)
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Best regards

We as well encountered this issue during our CI run. The given branch 
fixes the issues seen in our run.

Tested-by: Srikanth Aithal <sraithal@amd.com>


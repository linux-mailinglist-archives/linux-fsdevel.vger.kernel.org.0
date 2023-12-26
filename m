Return-Path: <linux-fsdevel+bounces-6913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765881E56C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 07:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDF51C215BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 06:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110E4C3C1;
	Tue, 26 Dec 2023 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOkQSOjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62094BA90;
	Tue, 26 Dec 2023 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703571010; x=1735107010;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2lKbUdAbSm5osvNJ8Bp5ISAXxNNC0OReoDWQ8yp4XHs=;
  b=UOkQSOjWyEfOpdjWvsJSBSOHbwugMjcBK6ePhCc97ZdB92opRa2JZSSQ
   3H3X0/NEyDwNO3BNGn+Ydw81MfeOjzLuv1BKeGi/+/dtQV9yjhAq8zmVq
   uiSqlZ0rUZNHtffDaY2ngx1+ySGphiD4d3tIbCTZklvgU1+iuK/GNE7rU
   SlQf2jW1vmoUKkdDkWsWKH2WDBh7DufU/UzvWCXhQi2VKXO6z9fwwXPiq
   w3FjJbW8CSPmGO4zsd4UpYu9kV/KT2Z940Kj8M0gTmHjEYfd4pI7NU5vQ
   pbBP3oWHORkhwnTax1qdeXtvOXBK9vflc+Fj1hqt6wPkK5VysHvFLjmKl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482502715"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="482502715"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 22:10:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="777869547"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="777869547"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 22:10:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 22:10:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 22:10:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 22:10:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1C+0BkZEFrmuYETHAzQKuqqsgQKfr7/i3b2q2stc6IpeoIdVvDr1gHM+uEWINDZv6TZhEFHRJET6giKS/du8IZLX0wARk8UJgr9KTBOR2/z/PW/edsu8bnqc6i500mFyEf4OZYFKpLIFQmG1uP+BV//i8TjcLWVY1+hAE4voSKc/W0AmNqxJzn2KqNPKDlG5n47f2w/YZ2ZLeCebwXLxvuYWWfKQBb9uBO8xeX5L28t5VkIM0XBfTYTV+NdpsS/GYj7UUE3rJXvV9Ymh+gl9y/5vlMCRmBTrlaUG4ka0gwNIySZQ09RKxqHeGWAVWNDsSim+hj6bM6E+pqW08HiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/CoNFLgp8NOG6gG628As4E8YwhC7rKK6yPBvIEXyZU=;
 b=f/Z/C+Xx5Z62CZ2oq6oPOkVcjp5D9Y0lurClQOGMGJ4zOnejYgDlN5dgr35OeDvfahHzNI8J6wH9IjTNHPqz+U2rSGMWEz0lBonXdiWg+zThphFfJ1fxzpX6/GqwV8T0OU+DVfAt7/2jTSj/bU7fVvcp6YJcUQtBhzdvytPhcMK3P2jpz/RjFF7bnyKatqYbvp2uLKZF8xvL2wScGk7tJ4Zxp3kKO5gm5LOi7smKYPhzr1q/ZTqdT0Lq3D0qV6O+yO4sqKcK79Fp3qs2KrpdPZ6CqKGLeMm2FSVKfz9wv/Q0sjEDLYvU5oV2OUK/6NTJq7qjqErrMX2twMPEKK0vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by BN9PR11MB5451.namprd11.prod.outlook.com (2603:10b6:408:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 06:10:06 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::ab4c:76d3:b700:26fb]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::ab4c:76d3:b700:26fb%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 06:10:05 +0000
Message-ID: <0ba8e579-2b6f-4e9f-a38c-097694f14d3c@intel.com>
Date: Tue, 26 Dec 2023 14:09:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page
 allocations
Content-Language: en-US
To: Pasha Tatashin <pasha.tatashin@soleen.com>, David Rientjes
	<rientjes@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <alim.akhtar@samsung.com>,
	<alyssa@rosenzweig.io>, <asahi@lists.linux.dev>, <baolu.lu@linux.intel.com>,
	<bhelgaas@google.com>, <cgroups@vger.kernel.org>, <corbet@lwn.net>,
	<david@redhat.com>, <dwmw2@infradead.org>, <hannes@cmpxchg.org>,
	<heiko@sntech.de>, <iommu@lists.linux.dev>, <jernej.skrabec@gmail.com>,
	<jonathanh@nvidia.com>, <joro@8bytes.org>, <krzysztof.kozlowski@linaro.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-rockchip@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-tegra@vger.kernel.org>,
	<lizefan.x@bytedance.com>, <marcan@marcan.st>, <mhiramat@kernel.org>,
	<m.szyprowski@samsung.com>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<robin.murphy@arm.com>, <samuel@sholland.org>,
	<suravee.suthikulpanit@amd.com>, <sven@svenpeter.dev>,
	<thierry.reding@gmail.com>, <tj@kernel.org>, <tomas.mudrunka@gmail.com>,
	<vdumpa@nvidia.com>, <wens@csie.org>, <will@kernel.org>,
	<yu-cheng.yu@intel.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-2-pasha.tatashin@soleen.com>
 <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
 <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|BN9PR11MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: ce551948-3a19-45fd-81e9-08dc05d94db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3Bj7lyRwi1Wd/4Kk0pOSrSG8+VpPZm3mmb14U0PRJgCr3aCUMFtRCkM3iSPIADy5UIdEhRElev2topzuCdLGAgpZo2mAXq49YwzYTDLgmqHLbCRm81FHd2zgEw/x8t503I9NQzEmpWAKDHnaD7cIZQjzD1/3jZ/sME/jh+utoHx8sqqxiSioYh1/heqK7uVWBVdFeUyqcvLKe3eAhesgxQLoX+q/upiwLEEetedhDSI0Mkdm+6uggPDCuq/O6mn0h07MFD1yu7nM4FlMP4mlz9fyatrX/+6oiy83/fnAGmKRqteCqKDKNJ0kXEpm4J/lpKVBrk6wQ1wCTYKCdZBZ0AeqFDXQuna2OkDJg+QvG8JVzRcsobDoTvHCpvckMr1JQm9XtFIHr6hQRxjLE3hGOY0Ye6Jq1RVyETFohaH8b0nItjoGVfSZCDu9wZJQxtCt+b+O6ewUTa6YFRYsggA1oQF02zsknWkie1Xpepk4Nbt1bqFBd2L6lZFAkG5B/CicMZNKa9hx5uMGQ2KZrPA3uqNFvU4NANJ9wydVTyaFs6qxyJe+qMp8OJVusw7PGkOjokAxupTwiqfGNg23zhnk8rFw7mxt/ihcNLrDVikaztCz4JZBRheJsbnIgmQDPCD8rgHDgSZKNjG8qjtWBZ2tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(82960400001)(36756003)(31696002)(86362001)(41300700001)(38100700002)(5660300002)(7406005)(7416002)(8936002)(66556008)(66476007)(316002)(66946007)(4326008)(8676002)(53546011)(110136005)(2616005)(6512007)(6506007)(26005)(478600001)(6486002)(2906002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBrQm9tK3JYNEh6Zkd2d2p6aVpWWDBMTWdxNHBQN0JGV3VqOE9HZlBldkVV?=
 =?utf-8?B?NnFGNUpBdENRVGFNZ1hqZjlhcVByMDdEektqb3U0SHgzV1RhWUNQYUIwY0xF?=
 =?utf-8?B?cFZZMFplbW90d241eno1WTZRWlo2SHFiQmpYdW94TktOSUNXVWRjYm9tNW8v?=
 =?utf-8?B?Z0V1aTQxUjRpbklkNTBUeEhsMnF2QlhDbmNVdmRBRTBlWVlJRmNsY0Exb2Iz?=
 =?utf-8?B?SGx6TG9YTGw1UTF4Q3hCOGtjVExwT3Zhc3Q3V0ViRFNVeFJkQ2lORUZ2RVZi?=
 =?utf-8?B?SUVTV3Q2MzJ0azZBWWpMWGRqa2hQY0FnTWRYV2gvdk8xaFB4TlVLdklDVm1P?=
 =?utf-8?B?NmVxbjVNeEtzbWVsbFdvRWRZbHFDbWdva2p6aWVXMVp4WE9rcngvUGxTbDJO?=
 =?utf-8?B?UlNHMTlYWE9WYjVCQm5nendzcXhFb1QyREtySmZ0eXptNG9XTWlDamh2TFdq?=
 =?utf-8?B?MW1iajVjSUtaWWdLVllFcXN5Z3NscDh5WDQ3NktyaGFPakpsb0lUY2hBNFNT?=
 =?utf-8?B?SzhacmFsTytiS2JQL25JanA5cExNQVhaVzVMWGs5VGpVNmRHS2pzNXZkQVZs?=
 =?utf-8?B?OElLMDJzWmJiUG85eTlnZXpLdWxBSjNoRkVBSXlJQlZUMVlwOWFpVGJIamJI?=
 =?utf-8?B?UDdvSkNWUWVWTnNXM1RjdEJ5WlNFRFF5KzgxcEwxb2dUcWtRSkVsMDV5SFd2?=
 =?utf-8?B?RXNJZHowSzBMOHVvWWFBcmtiMnRZVEtLTXdyOExGTWFuSVZITEI5NCtkRVhS?=
 =?utf-8?B?OEFQNHNCSitKTG5sN3hlWWF0TjdiQjJ4VzYxVzRwdjZqcGRvT0Y1eG5wS1Vy?=
 =?utf-8?B?OTU5ZVZFN3RVbWJ1a1h2Ymo3TXZBM0xzS1E5VDJFMXFtb2t1YVFadHE1aFZI?=
 =?utf-8?B?b3h4RHJxSjFwYVFXeU9ZTXczdlk3QklqQmlCY3lCcndMVDFCcURtMUpFTTdM?=
 =?utf-8?B?ZWtCWWNETEs5YTE2YWpTajBYNW5xOGpxZXhoQjhsSmVUckx5NzNObGtUeith?=
 =?utf-8?B?c0dyUVlJTXJacVl0NDJtREh4VklrNVQ3R1d6a1VCcmFZKzNWQ05EZE5yaGRn?=
 =?utf-8?B?OVE5MDdEdlRVMzJVQk5JK1dHZi90R0M1cjNWVEt6WmtYcEdGcmgya28wUTdU?=
 =?utf-8?B?eVRGc2lUWktSWHl5MC9kQXlSWldJZlo2eXlNS0o1NXhPbDhTeWd1a2ZDeC8z?=
 =?utf-8?B?dDkyK2NqSFlaVVVSR1FXQW8zRlRsTVlRS1UzWkVUQ2hxUGFXbE5YS0ViWHlC?=
 =?utf-8?B?VitqNnRnbC92dHg5dWpLQWU1SDErL2FzM1BQbHF3LzN6V205VmR4WGNqbjEy?=
 =?utf-8?B?VXZJaytoaElDYXBST0k3cndMT045dElldkJHYnBJaGgwbUFLMWJFNnlDSG1z?=
 =?utf-8?B?RjZjbEh0RjhSL096MEozcUhKYlhYTFJ6NFJsak9lTGpGTm1Od0RidDlYS2I2?=
 =?utf-8?B?RVh3SEpEL0lQRGJ6R21aVmVPVXB3WmxsOE91NTFndG9Ic1JBNjF1b0wyU2Rw?=
 =?utf-8?B?Uy93MGViOGFCVFQvcVMwL3J2cDIvR3E3K00ydWZnQisrdU5uUUNEa1U5NEtD?=
 =?utf-8?B?Z2NxOXlkeHFIamdQOGRENmtwbzRWb0xxZk5kZUFGVEI5L28yVUJ0MVZQbERV?=
 =?utf-8?B?M2ViWjRNQThIYWk3NmJXNnB0V3NwQjF5Rm43ZG1MRkFsVVFGNkJGQ2pYUGJL?=
 =?utf-8?B?S0dhMWdIUFhiNjNOc1FVRUpSMldOZkpUQWZ2ZUNkdE5OQzJEb2lPV29oQ2VK?=
 =?utf-8?B?blovcnI1NXhTL0ZQZ2QvM2VXMkFlR2lIYTgvYWdNa2U5RDl5UmVTSXhXM1hU?=
 =?utf-8?B?SHlvUDFXdG5URUpaUnNPaHlQbE1EbGIyQVJUVUpxT3hYTkd1b3ptVk45eWkw?=
 =?utf-8?B?ZVl5WjBQZ2lkNWI3WHpXL1RadDdsVm9vMmtIaDVFci9VRjdsaWF1MnVtOTRU?=
 =?utf-8?B?cGZhak9zbXlGdytCK0piNmlhenZ1Nk9JNmpSalJhVmVORkxEaXN2TTJqMkE2?=
 =?utf-8?B?UkV6MUxHREloNG9RMzZZU0xRaCt3VnhmQU5pUjJqeVB5TDF1elFGcGYrQ2ZZ?=
 =?utf-8?B?RzkxY0FtMDBXK0twRXdUbk81TlRrbm96Tmd3OHdNdVJiYzhFN0h0ZGFXU0Er?=
 =?utf-8?Q?3y9OqVlNLA5Ur3SmszelvsZuF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce551948-3a19-45fd-81e9-08dc05d94db8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 06:10:05.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qy7TaEZXs462FSdSWGMKIBTyc88uxEEGAC2WAd+kvyqlkPZ2boaR78CyO+ZFoxEk8WItl0kK7BWkW5fm1d6lTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5451
X-OriginatorOrg: intel.com



On 12/15/2023 3:16 AM, Pasha Tatashin wrote:
> On Thu, Dec 14, 2023 at 12:58 PM David Rientjes <rientjes@google.com> wrote:
>>
>> On Thu, 30 Nov 2023, Pasha Tatashin wrote:
>>
>>> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
>>> new file mode 100644
>>> index 000000000000..2332f807d514
>>> --- /dev/null
>>> +++ b/drivers/iommu/iommu-pages.h
>>> @@ -0,0 +1,199 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (c) 2023, Google LLC.
>>> + * Pasha Tatashin <pasha.tatashin@soleen.com>
>>> + */
>>> +
>>> +#ifndef __IOMMU_PAGES_H
>>> +#define __IOMMU_PAGES_H
>>> +
>>> +#include <linux/vmstat.h>
>>> +#include <linux/gfp.h>
>>> +#include <linux/mm.h>
>>> +
>>> +/*
>>> + * All page allocation that are performed in the IOMMU subsystem must use one of
>>> + * the functions below.  This is necessary for the proper accounting as IOMMU
>>> + * state can be rather large, i.e. multiple gigabytes in size.
>>> + */
>>> +
>>> +/**
>>> + * __iommu_alloc_pages_node - allocate a zeroed page of a given order from
>>> + * specific NUMA node.
>>> + * @nid: memory NUMA node id
>>
>> NUMA_NO_NODE if no locality requirements?
> 
> If no locality is required, there is a better interface:
> __iommu_alloc_pages(). That one will also take a look at the calling
> process policies to determine the proper NUMA node when nothing is
> specified. However, when policies should be ignored, and no locality
> required, NUMA_NO_NODE can be passed.
> 
>>
>>> + * @gfp: buddy allocator flags
>>> + * @order: page order
>>> + *
>>> + * returns the head struct page of the allocated page.
>>> + */
>>> +static inline struct page *__iommu_alloc_pages_node(int nid, gfp_t gfp,
>>> +                                                 int order)
>>> +{
>>> +     struct page *pages;
>>
>> s/pages/page/ here and later in this file.
> 
> In this file, where there a page with an "order", I reference it with
> "pages", when no order (i.e. order = 0), I reference it with "page"
> 
> I.e.: __iommu_alloc_page vs. __iommu_alloc_pages
> 
>>
>>> +
>>> +     pages = alloc_pages_node(nid, gfp | __GFP_ZERO, order);
>>> +     if (!pages)
>>
>> unlikely()?
> 
> Will add it.
> 
>>
>>> +             return NULL;
>>> +
>>> +     return pages;
>>> +}
>>> +
>>> +/**
>>> + * __iommu_alloc_pages - allocate a zeroed page of a given order.
>>> + * @gfp: buddy allocator flags
>>> + * @order: page order
>>> + *
>>> + * returns the head struct page of the allocated page.
>>> + */
>>> +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
>>> +{
>>> +     struct page *pages;
>>> +
>>> +     pages = alloc_pages(gfp | __GFP_ZERO, order);
>>> +     if (!pages)
>>> +             return NULL;
>>> +
>>> +     return pages;
>>> +}
>>> +
>>> +/**
>>> + * __iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
>>> + * @nid: memory NUMA node id
>>> + * @gfp: buddy allocator flags
>>> + *
>>> + * returns the struct page of the allocated page.
>>> + */
>>> +static inline struct page *__iommu_alloc_page_node(int nid, gfp_t gfp)
>>> +{
>>> +     return __iommu_alloc_pages_node(nid, gfp, 0);
>>> +}
>>> +
>>> +/**
>>> + * __iommu_alloc_page - allocate a zeroed page
>>> + * @gfp: buddy allocator flags
>>> + *
>>> + * returns the struct page of the allocated page.
>>> + */
>>> +static inline struct page *__iommu_alloc_page(gfp_t gfp)
>>> +{
>>> +     return __iommu_alloc_pages(gfp, 0);
>>> +}
>>> +
>>> +/**
>>> + * __iommu_free_pages - free page of a given order
>>> + * @pages: head struct page of the page
>>
>> I think "pages" implies more than one page, this is just a (potentially
>> compound) page?
> 
> Yes, more than one page, basically, when order may be > 0.
> 
>>> +/**
>>> + * iommu_free_page - free page
>>> + * @virt: virtual address of the page to be freed.
>>> + */
>>> +static inline void iommu_free_page(void *virt)
>>> +{
>>> +     iommu_free_pages(virt, 0);
>>> +}
>>> +
>>> +/**
>>> + * iommu_free_pages_list - free a list of pages.
>>> + * @pages: the head of the lru list to be freed.
>>
>> Document the locking requirements for this?
> 
> Thank you for the review. I will add info about locking requirements,
> in fact they are very relaxed.
> 
> These pages are added to the list by unmaps or remaps operation in
> Intel IOMMU implementation. These calls assume that whoever is doing
> those operations has exclusive access to the VA range in the page
> table of that operation. The pages in this freelist only belong to the
> former page-tables from the IOVA range for those operations.

These pages maybe be accessed concurrently by thread contexts other than 
the IOMMU driver (such as debugfs).

Thanks,
Jingqi
> 
>>> + */
>>> +static inline void iommu_free_pages_list(struct list_head *pages)
>>> +{
>>> +     while (!list_empty(pages)) {
>>> +             struct page *p = list_entry(pages->prev, struct page, lru);
>>> +
>>> +             list_del(&p->lru);
>>> +             put_page(p);
>>> +     }
>>> +}
> 


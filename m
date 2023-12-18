Return-Path: <linux-fsdevel+bounces-6392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9A817855
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 18:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26E0284168
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC65A875;
	Mon, 18 Dec 2023 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="mESTrHxh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E24FF6D;
	Mon, 18 Dec 2023 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNe804WgmyAz1FZXI1qA2GnKRa1UV8biHULEp3ihMAT7jLGkCQPPizP7LSSgjvvt8bA/8l64uBQ8kZDtTkpsC3bFF0SLdl/cVOm+7dVv3gmN4l0haLTzqgc1Ex6n8JREezNir8zYaXF6v8ncEps07NhDUHc87wFRbd9w3Az9GQnZYt24ilmZ3depzDdm2k2i67dDmF2DZqmqF3McrSyu2szi0kuZpySQl8npFnAXFlo+XiEBqaApCV9Gl3y8W27qjoXJ9JvHgvHUat0FIMVFKbh4O46eFd7aUdiy+TkiQwpnmbTedr1wHS+A3vO5MVc4lIhBwoFZIdxVEYoo93eq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1TRYh7MR0qUpmZzuM6ORdWu0V5dMqURCLSIF6TJlrk=;
 b=XkUjn/pvppfpgmBnZ3XJPWrcz1ezPTGQJNe1UQvLU7ohvDZVestwsBR86LfJ47HaPyOC9J+kgd+RBaJUkmSCSJ2mD7YEtO8UB/CyFSXQCBSux6DEdZXjMNC8d587lO7taKRt83F90aSE1ak6YGuAsbSgQ4ZLqMrQR0VHTuYP3wC+1KV3xlP3psq/Xi4YeMmARiinZ9J7CK4XjODLDZtPSwllaGWjb8B2RWLc32B2J8DFCwOuPleUWOz/8vEkg1KH5bO/+UiBTlipgGazAYH6LlMjKqIZFSM4CoAX+FXgdEUDLiVdJh2UJu0z2jyutxesp0GzmxWEy0JxJh9jpCLZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1TRYh7MR0qUpmZzuM6ORdWu0V5dMqURCLSIF6TJlrk=;
 b=mESTrHxha/v4uiYklfgSpyRkCzEXjNzNKhmTqtj8aXoPaY1i/u+a3NLasDy+9XHvFUaf/j+6Q2A8gPqPJ1lENsKY5ARvquZlXuGkZ/OfoUl3a2cjJpDsNcLCdiDQ5drU4y7U54WqFBkLMaORRzBvQj/o/m5m1I9KdGrH4e7Yw+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH8PR17MB6887.namprd17.prod.outlook.com (2603:10b6:510:256::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 17:15:10 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:15:10 +0000
Date: Mon, 18 Dec 2023 12:15:04 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Hyeongtak Ji <hyeongtak.ji@sk.com>
Cc: gourry.memverge@gmail.com, Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com, akpm@linux-foundation.org,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	dan.j.williams@intel.com, dave.hansen@linux.intel.com,
	emirakhur@micron.com, fvdl@google.com, hannes@cmpxchg.org,
	haowang3@fb.com, hasanalmaruf@fb.com, hezhongkun.hzk@bytedance.com,
	honggyu.kim@sk.com, hpa@zytor.com, jgroves@micron.com,
	john@jagalactic.com, linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
	mhocko@kernel.org, mhocko@suse.com, mingo@redhat.com,
	peterz@infradead.org, rakie.kim@sk.com, ravis.opensrc@micron.com,
	seungjun.ha@samsung.com, sthanneeru@micron.com, tglx@linutronix.de,
	tj@kernel.org, vtavarespetr@micron.com, x86@kernel.org,
	ying.huang@intel.com, kernel_team@skhynix.com
Subject: Re: [PATCH v3 00/11] mempolicy2, mbind2, and weighted interleave
Message-ID: <ZYB+GNPvzwNJUGxU@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
 <20231218070750.2123-1-hyeongtak.ji@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231218070750.2123-1-hyeongtak.ji@sk.com>
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH8PR17MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8dc143-ee1c-4bbf-8cd7-08dbffece3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3GpKGFLuzwERJF+yQzIHxhbFAEYcZ5jSywOLIeH8V3GfvdmMC6Vtxc3e6CWrEGvt5Q/3iiRda4Yt1aWWym/2JDsSdydB+SySdbi//srVbp8n1Q1kDoWzI8nwUN9041Lv2dx4HNBDrVFTmqlfByLln8HbTdyNnWLxI12zwXdHeUz0Y2DOfk+SbcZ0Ok/D9Z6fS5xxSDV/wvz26V3UydjUJl1QwkvYv5Xb81A17HapWM8WzAJNmpDUcskA+3ZtH7Hr9Z/0C3Mmci2q5zkeJL4TjU3n0e5jT//tGYVkwHOHtapgxR1YNiyUaJzA/ynQzw7my5q+/J/YHuPfMP7COch0e1riLW+S3Ev/MLtvASblh5ykHpXaiLIXC4DK24r0vcexkYy6VtwKa2PxmEbjaR6T10795rNXaUfJwunKpgOKYKd+RsMUHizc6GUyqllfoOci7HfolU63/G2XrWSZU4EI5Y5ww4NVQyUo48E6DeyZNU7AuvT2+p7aiRYPI9ArA1TILQzLSCgJtvtSl43I/uS3QkpvnaS7pgo/JNBBGo2gJHF1NcV1IACdAOw9kWIMddwZxv6LisTlHeWscPIugktNVzrXPWXZWokjNmq0V9UPmIaF3fIlm+QhNQP23EpUyH2nj+yD49JKqsxvW6gdTAx3oQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39840400004)(366004)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(8936002)(4326008)(4744005)(36756003)(38100700002)(86362001)(41300700001)(2906002)(44832011)(7406005)(7416002)(5660300002)(478600001)(6486002)(6506007)(26005)(2616005)(66556008)(66476007)(316002)(66946007)(6916009)(6666004)(6512007)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmJocytZdUtrL3lqUzFVcTlLbU8rTHYvTzVpMElQTVlpN2lCMTBpNG81d05X?=
 =?utf-8?B?SGNHOSs2WkVpNSs4NUFaaUJGYVhsZVQyVVYvd1c4aXorMWcvZzVTMVJiMnI4?=
 =?utf-8?B?WllTUDZhaklaeHQ5Wm9Wazd1WEZvWFB3MGpFQkVQVG9OQzlLVldFNVNoMEZn?=
 =?utf-8?B?R003WU03WUEyZFNZbTNDVEE3anJpYjNHa0gvRFN3WlVQdzBCQmU5b2JPVUcr?=
 =?utf-8?B?OVh1bGxXOGFyTGFXT3VvZ1NUV3lERlJieGkxMXkzcEkySE5kWHFuSU5nR2Nw?=
 =?utf-8?B?R2JSZnExeHJKYXB3MlNaQjhnVCsrWUxSdEhMdGlKaEVjbWVxSHNHaUNydWlo?=
 =?utf-8?B?NFljVW4rcVBaeW52VHdIRWVhM1hIbDk3bVlFdlhaelNzQmN3VFRjTkFUbms1?=
 =?utf-8?B?N3QzR1VkdU9iMjBJOVN1OTl3Vk9rN3FmYldFcVZ5WlNPOHY3T0Q0bFE2U2hE?=
 =?utf-8?B?ZG8yR1pHRWdYVmd6bmpYVzlHLzZjTmtrOS9lY2JRL0VuM2xHV1FRZTZYbnh1?=
 =?utf-8?B?NkVXUE1QY3l1ZFNpZjhRT21UUVJyM0Z0K2JNSk5oNk5pTVU0QzlWV1VyQjY0?=
 =?utf-8?B?Tzl5UFNWakxlMlFGVG0rSDkyKzFWRCtRN0tCTWFHVlN6QkY5NzFIVEJpZlJS?=
 =?utf-8?B?c1VydzBsTnVlV0xJY284UGpaZVBOZVpDVHp2OVltSnBCYVo2VFFUeWRBUSt0?=
 =?utf-8?B?RXJqWmhXTkRSNkxITUdQclRORXZpSUgrSk43TmtSYmJWbXZsOGRBYjNCOWZ3?=
 =?utf-8?B?c2k2M1ljckFRNDRJWW9jWW8rbTh0bWcvNmtoSTlqcTBUUWg4ZEVCT2NzeHlU?=
 =?utf-8?B?KzFhcXN6dEIyQmUxUWdyRERRRjlUVXdwQTZQUHdWTnc2QmhrY0svRmpkWU5w?=
 =?utf-8?B?THJEOXI5WjNFTkphcFdQamRUSW9LNW0yVk9PeVhCTUQvaUltZWEzakUvdSt0?=
 =?utf-8?B?R29jZlVZeGZyMHJ1aXZ5bXJsMk0wYklQeXRPVTAzZHY4cXE1emw4Szd6Mjl1?=
 =?utf-8?B?b3VpWEI3bTJSRW8yb0dlS0NuejA3SklPMDNsalFRRnppdkFtaWFhYnFOVlJh?=
 =?utf-8?B?QmVvQ0M0RlRFSk9zNDhiVFEzeER5ejdoM05XZUMrZ25kYXNLYzNHbVovbUFJ?=
 =?utf-8?B?S2dlVndlUkV5blVnajUwdmlHb0swMWd3UG1RQ0h6dFN0L3ZUdDVqMktWZ2xM?=
 =?utf-8?B?cEVBSjBCVnc2RHFMbkdybStCYXFyR2NyV2hoQWNyWUlGOGZpSG11aWZIS3lG?=
 =?utf-8?B?eHovVGJKN3dTMUp4QWdxMlNJQVpJSDRacU1UL3NBSHpxWGJvdDVzUzQyK2tX?=
 =?utf-8?B?SHYxcFJweW1iQk5UMFlCYmg2akM1K2VnSHhjNmd0c2l4SVlja0tJclY1ZzdR?=
 =?utf-8?B?RlBrVGVTcmFLQlMvYk1xaG9vZzEwMkUzb0lRSnJUUkFXWVFoWXNrcXFmNXhG?=
 =?utf-8?B?RWx5aVU0Rk9hMXBoVnFIVXFiUytDRnNZR2s0OUNKTXlxWE01R2lTTWk1cHpu?=
 =?utf-8?B?YmtOdVJzSG1RRWZsd0hNRk85QWRlc0ZVMy9uOXVBR2lEZ0l3RHY5WDA0T0xi?=
 =?utf-8?B?QThmaVZ3QmVGS3JmRkdzajZEQmdqMURKRWJjQnQxeUdGVDh4UXZTOFVIVDJS?=
 =?utf-8?B?Rll3YTFWd2I5NG9qQ203UTJzK0h2SzdKQ3EzK0svU04rT0FjSnRZTzdvcGdE?=
 =?utf-8?B?ZytDSzlqaTBuWEZLN3ZDMFVHd0w3d01zemo0UGpvbUExdVdqRkhrc0RQOFVh?=
 =?utf-8?B?U3NuNHlzWi9mL0xJRXNVWmNsWjJaclZpbDU3U2tQRjhFaUZTanhmdWRoYTYr?=
 =?utf-8?B?aVNzR2czelRFczhlZXpKbmpXRVVYaWV0VEVBNzIxWDJxcUNqWnEwZ01QT3Ry?=
 =?utf-8?B?cjB3NzlOUndkTjZhdUpCUnExNlhvOEI1bk1Ca0ErdWVEVGhTL3RoaFkxcGM2?=
 =?utf-8?B?MThweVM3dGpUczdpa3I2QU9pQm1HMmdYa3dFSnZPN0R0VFk1WG91dG5KZjNj?=
 =?utf-8?B?MXdoZ3ZXMnZYVzJINTNVaEw5dGpySjZHVjJPa0E0RFNhNklRa0ZxQmNOdWp0?=
 =?utf-8?B?d0pNNFkvaTR5RU55R05uZTlwTkFVZGdvaTlDdDdESTN6cUJGQTk3ZzJ1UVV6?=
 =?utf-8?B?b1dKSmdwWDhyZFBiNWp2VFdPQWJ0QTBBcU13VG9pcTMzU2hYUWpmVVJIQVZZ?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8dc143-ee1c-4bbf-8cd7-08dbffece3c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:15:10.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeiqZfOtfsTYbq+xohuaOGWcxkW486+77C/EurkDhkyYZnUWMEnKtrGYn5PD6KQPHH02lh2kwSmbbhCsojOtLEoz3u8DJzDo3P+npmH1rrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR17MB6887

On Mon, Dec 18, 2023 at 04:07:48PM +0900, Hyeongtak Ji wrote:
> Hi Gregory,
> 
> Thank you for the v3 patch.
> 
> Gregory Price <gourry.memverge@gmail.com> write:
> 
> [snip]
> 

Hi Hyeongtak!

Thanks for the tests! Added test notes to the v4 cover.

> Performance tests – XSBench
> NUMA node 0: 56 logical cores, 128 GB memory
> NUMA node 2: 96 GB CXL memory
> 
>   1. dram only
>   $ numactl -membind 0 ./XSBench -s XL –p 5000000
>   Threads:     56
>   Runtime:     36.235 seconds
>   Lookups:     170,000,000
>   Lookups/s:   4,691,618
>  
>   2. default interleave
>   $ numactl –-interleave 0,2 ./XSBench –s XL –p 5000000
>   Threads:     56
>   Runtime:     55.243 seconds
>   Lookups:     170,000,000
>   Lookups/s:   3,077,293
> 
>   3. weighted interleave
>   $ numactl --weighted --interleave 0,2 ./XSBench –s XL –p 5000000
>   Threads:     56
>   Runtime:     29.262 seconds
>   Lookups:     170,000,000
>   Lookups/s:   5,809,513
> 


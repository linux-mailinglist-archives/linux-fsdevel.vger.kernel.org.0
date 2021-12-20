Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAD47A6F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 10:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhLTJ1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 04:27:13 -0500
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:42657
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229474AbhLTJ1M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:27:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8I73P4jWuzO7dqf3jKsWH1OiFTVsiD5sqF9fzrJrhEHbFEk8RmRCl1GXOmwdOd2L+gLpFNyQ/ov5eVDu/teEWp5khQN1jIbnXIG3uy5ThSQNMleLI+QESZUmsHXDEJmaJdCN48Te952jJpipXKJqdQcrHZaWCA2jP2UAIzpo9WHmU3o+fhuLlhpxtHDkMNUPX71bVziFA1GcHjIFZYjE4u+TCi5hz1Rz/M2WX7j+G1o4xGZ5SLFMSbFmXkPR5Guh9z8vw04M6D7YsXXI6btj45OkjF1N2kXaBoqw6wYHtQmAYZPHOaB3ItQsnDB4wvtMRvnVrVBcQ1mVDdlSC7c7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBD5bFdPuWaxv+0qZyOoDHYlDZ+/rwys41hvakPfeZ4=;
 b=Kt/9Ai2wOFzfPkCMEWKuQLwxNgtqD8iztSabi6a8YF2bxN8E3c5fQv/Hp2TKHYlUApsL0u1Q4G/MFiQD6pWGO3WewjvW79w4DcMKiNXTt/snEhvhSDWsc0vWSFyRgF3tr8wvbcCURpOfyyjdVNz1XjR41pt/l8Ltc+0UMXChUO00NeCWs6Z0fDtjv535oeyKnJcPyIQh9ROBMZu/1igCLGnHndzaeJE614pXy7Cyrt/WM6YqxQPc24UEgM+uh5rMykAt+4R26iFHhAYxtB0nTA6RcqM+mgtDWUnmLJE1t3HczrWiXU2s8Tl7cuQrRGY61wSZOBzZ5ACGVWkXMqs/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBD5bFdPuWaxv+0qZyOoDHYlDZ+/rwys41hvakPfeZ4=;
 b=j2cJXXsN8/T72A7PjElch9K1GfZcCg7iHWybYRS/iNwDN1Z13WLfKKM6gTkhK4NZHUdaFabTOrCwb/XxsAnmKgrMXViI1PnZ9m7kQe60OrAmDWuwB7oGCBNBqEzmwnjl4eTAqC0qsomGjwTf0mz2634MMM+mgLlGtbry89wXuw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB8PR03MB6282.eurprd03.prod.outlook.com (2603:10a6:10:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Mon, 20 Dec
 2021 09:27:10 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::2943:cb80:c352:33cd]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::2943:cb80:c352:33cd%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 09:27:09 +0000
Subject: Re: [PATCH v5 13/16] mm: memcontrol: reuse memory cgroup ID for kmem
 ID
To:     Muchun Song <songmuchun@bytedance.com>, willy@infradead.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, guro@fb.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        david@fromorbit.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, jaegeuk@kernel.org, chao@kernel.org,
        kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-14-songmuchun@bytedance.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <12b23c89-c7b1-56b3-5cff-1e1b07e24de6@nextfour.com>
Date:   Mon, 20 Dec 2021 11:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211220085649.8196-14-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0210.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::34) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13e76b04-3587-4219-a179-08d9c39ae5ab
X-MS-TrafficTypeDiagnostic: DB8PR03MB6282:EE_
X-Microsoft-Antispam-PRVS: <DB8PR03MB6282383962444EF142509578837B9@DB8PR03MB6282.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOD13tcu4wNATi369AKeykHia2mRgkte63TGz88vAc1vW12Vz9X+X3Xz0A4NJLG5H8yMW7y2KtkmkwY7xJ6V/HlH5GdBspUUXeFJR/1NuPSNHf9obNCfossFH9fWoGNiIkhKKHikLsFbf23ks/XNQdgLfmRyFP5bzJYykJkb6v1F1ztjjfn5RxqEIUed3V6Ppazc79UUnCLzOV76V42gjYq/WHv1Jam0i1gRGqKuGWZz44f36fSo4SlIimi5b1dGwsSZIOZARc7f4NQrDXi7/Fympu0+/bgBs2l+iMk2qLQz+hi7U7290D8ehim9sS8o7jPmF7vFMfoUGZOD2DEm1FlWLYOMsBDB6ixcvfoPfHRSOMwx/O1HOxoocF/d0x7TWTbp7+KRWfG2KC7WUZ9OwNO6+g0KefnVkpdb+vHwJhfKb16KnDp+k4qLJdCJjmvo5MmBMaUlbVVXOAXHD+Ppv0tSK9V9sfB8NMnLxe7YD3Ptx6GkmTD7xA6hGG8pgTU0KUxziqr+p53hPzJkmKkVLYbXvMV11V3s0UXkqXO61KcJMjhuZJM1MrgCGdgYsPP1wSy+XZXEHHr3L5Njd8JQ8kJ00qzUWfk7UnO2OstB/C8yy3/MJ/S5FoyLvkGwjIyNT6h4DQeN4KXDD8X2iUVxXSY68l8sWAiW3yliIVskVS8qn6uGrKk8W0OakfO5Vx8MeQTcOQlU6TNgAN3egoYqkev2p2FRZn9xKO1+IP6y+PH3W7DJ39A2Acwx8YLJQBIerMGTaJUl0f8vTabK0jHX+sq+gtzbcqXawq4n+x7+kng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39830400003)(366004)(376002)(52116002)(31686004)(66946007)(66556008)(66476007)(2906002)(31696002)(6486002)(38350700002)(38100700002)(921005)(36756003)(6506007)(6666004)(6512007)(8676002)(83380400001)(26005)(8936002)(5660300002)(4326008)(186003)(7416002)(86362001)(508600001)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BFRHlzWVFDUzFyRlFvQmxiOXdhazFQZ21DU0FNYUZXNFkyMUJKdm9FSEYv?=
 =?utf-8?B?WTJMbkNKaW8wV2xmUzk5OXphMjE0em1SK0p4NzFNbU94aW9UWjJvT254Mm5m?=
 =?utf-8?B?bkpVOGhEMVFlaytuQjc0YzQxenhPenh1b1BNVWNJN0lidUJJTDhZdDMrTk40?=
 =?utf-8?B?VzNncnJ0TGpiRVhTUmlaQ0NXNTlacXhxdHF3WEdoOUZrU0tHVXVuc2hKY01h?=
 =?utf-8?B?WlZFc0EzQlp3Yk13VXJMbldReUFiNXZGZlVHdllTTjNpS0RVc0NCMlF3YUVZ?=
 =?utf-8?B?QVlKWFFGVVlnVHEwUkZTN3hBT3pOQXZGR2VSYVp0RnREMTFHQndpTHpCZk9h?=
 =?utf-8?B?NTU2RzBERDdabUZzc1NzcDVNZ3VnQ0tFSUlpdi9oaUJMOHZaME5PdjlEUmo0?=
 =?utf-8?B?dzdXckJmTG8zQ2VhTm5YZnIrdFMycG1hU1laSjIwdWd1bHFhWGgzd3grdW1Z?=
 =?utf-8?B?eTNGaktmMUl0RWdWcEtmdmgrZkxONTdzR3Jra3RWTWkrdDIxc1UvRnZPVEhK?=
 =?utf-8?B?VnJXekJUT09Nc1Exci9GaS93V1Z6UDhQOGVXMDJpakRnWmkybGdsSnhsaTdE?=
 =?utf-8?B?aVJQY3RBUXRFVlRjdzZWUmJQTm8wdFI1RitoaGhCYU1iSkdVdGU0SXQzNlZr?=
 =?utf-8?B?eEJJbXN2OVcwcTNsc3JNVDdCbGF5VnBiVCtzMXhQYzVsVkxaSS9GMzYrYktx?=
 =?utf-8?B?ZUV3Tk5CemVMcWVFRWV4c1pRUnFWeFlrNEJLbmp4VWc2aU5JbnhhYzRJYjVz?=
 =?utf-8?B?blRydDcwZFEvQllHRU13eXpHSmZwMTFkUDlxdmhYbXZuK2szdHArSFFieE5V?=
 =?utf-8?B?WkxSQlAzaG9kRHc5NnBZWEZlVzl0SmQycUZOT0NDazg2Rk83SDc4dXgwajY3?=
 =?utf-8?B?Rlp6amN5R1dIR3BQWUZhbEloWnhRc25ZQUtWY3RHVkV3S1dHTkdxTG4vUkt3?=
 =?utf-8?B?VGFZcS81TGJtK29BeEFpL3hjS3BiaXgyOGdIc3RxVW01SXV3eHFqdm95MDYr?=
 =?utf-8?B?L0d1N3dWdVF0R1JzT0ErcXlJY3VlRVErdkFVektwZVQvS0pKbnk1VDM0UWUz?=
 =?utf-8?B?UkRwZGh2YlZwN1V3VkU5aEhuZXhveUFYTzRBV3Z4V0hTTkpYTUVsZnlKejBy?=
 =?utf-8?B?Yk5sRFVmQmI5R0Rlb2t1bjlUNTd6eXZRaWJ0OFhhc29vUGFIR1dtcjlBVjdp?=
 =?utf-8?B?UklIZHF3amtDa0dDTC90Qk1CdTJ2TlUzNXc3alRsazA5dXlhRlVobVkwSnpw?=
 =?utf-8?B?SXo0ejNyV3dGR3hneEt0bEpyMXI2NHdraXJCWXFUbVBUU01TaTJpN0RDQzl0?=
 =?utf-8?B?dmwvVVBXSU9weEg5Y0hvVjNjMTduWmlBbWxQa0VNZzUxN1J1OXArWFl3Tmhk?=
 =?utf-8?B?VGdMcFYyOFRsdVpFdXIzT01KWm5HUXpMS1NBS2hsdU0yOG1qYWNmOWFlK25a?=
 =?utf-8?B?aGtORkhxLzBrZ2pXVlgxTUV3OFZiemhwVmRvbFNadFl0UHpYQXl6Yy9RSVJp?=
 =?utf-8?B?Y0lnUHNtaHpJR2MwUVVBMTZlcFZaeDZCK0JMKytoWDRmcGhSaUgycEhIek1n?=
 =?utf-8?B?d3QxeDJYTkYrQmFuYTB5cEcvc1JNYWlJNFd5ZWtzVzQxaTFJa3REdjJRSjRy?=
 =?utf-8?B?dm9mZEZsVDNBUW1CdU5IVWRPRU9SMjZpWmZYdWVBZW1CWThXV2RkbVlZdFpN?=
 =?utf-8?B?QzE4ZEtWbC94S1lTNGtTUGRFY09lSzl3RXkyQWlKWmJOSXdtUWxGN0ZiSnJC?=
 =?utf-8?B?KzNDd1oxdDlRTWJyY3htVjdlMnFzOWJ6Ny9BM1NpdHV5Q2x5MDlubjM3VTdK?=
 =?utf-8?B?VG5KNEtrYkNwQlB6WUFIeGgxbEM5emNDQVNYOFk5WFQ2YjNjMC9KUVF3MHJW?=
 =?utf-8?B?WXZPM2dtUUwwMjl5Y29JekxkNm4vZk10YW13YUx1VmxRdjJTMFUrSnlmWDNx?=
 =?utf-8?B?U1hrRmc1MUxQbzliZXg4YnZSb3hoSW9uM21xZC9QN3ErYVV1WlI5TG9ETGpq?=
 =?utf-8?B?Yks4ak9OR2hTdXhkd0RocllpU1p1WXdGQmpsaHRyVVJkcSswSTUrb3IzVytv?=
 =?utf-8?B?c3hmcVc0M1lodE8xdncyN0dzWGNQWit2WVZmY2ZrdWxEYndRdWJ6Y1dxU2gw?=
 =?utf-8?B?aDRpTzBIZXdRZExJNHgvbHVKY3FQcXgvWlVZWjM1QnFpcW4wMlJwZW54MkpM?=
 =?utf-8?B?Tnc4T0M0U1ZSUmZyNE1yM1pGbmdxT28zSkVyU05qbE5Ya3hxdDBjYXc1Q1B1?=
 =?utf-8?B?cUJxcXdXeXdZdTY2SFFZNHh6U01nPT0=?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e76b04-3587-4219-a179-08d9c39ae5ab
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 09:27:09.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbeZrZ0t5VLDO2lsMiCl0voRJk/RjDJhCZicb5qJ4JoipKZwMEd8kz71npIz1AbjSJ1w0Y2uloB4rwyuTdV2wb+R6lhfVNq6pY9G1oZ7DJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6282
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,


On 20.12.2021 10.56, Muchun Song wrote:
> There are two idrs being used by memory cgroup, one is for kmem ID,
> another is for memory cgroup ID. The maximum ID of both is 64Ki.
> Both of them can limit the total number of memory cgroups. Actually,
> we can reuse memory cgroup ID for kmem ID to simplify the code.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   include/linux/memcontrol.h |  1 +
>   mm/memcontrol.c            | 46 ++++++++--------------------------------------
>   2 files changed, 9 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3fc437162add..7b472f805d77 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -56,6 +56,7 @@ struct mem_cgroup_reclaim_cookie {
>   #ifdef CONFIG_MEMCG
>   
>   #define MEM_CGROUP_ID_SHIFT	16
> +#define MEM_CGROUP_ID_MIN	1
>   #define MEM_CGROUP_ID_MAX	USHRT_MAX
>   
>   struct mem_cgroup_id {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 28d6d2564f9d..04f75055f518 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -348,23 +348,6 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
>   }
>   
>   /*
> - * This will be used as a shrinker list's index.
> - * The main reason for not using cgroup id for this:
> - *  this works better in sparse environments, where we have a lot of memcgs,
> - *  but only a few kmem-limited.
> - */
> -static DEFINE_IDA(memcg_cache_ida);
> -
> -/*
> - * MAX_SIZE should be as large as the number of cgrp_ids. Ideally, we could get
> - * this constant directly from cgroup, but it is understandable that this is
> - * better kept as an internal representation in cgroup.c. In any case, the
> - * cgrp_id space is not getting any smaller, and we don't have to necessarily
> - * increase ours as well if it increases.
> - */
> -#define MEMCG_CACHES_MAX_SIZE MEM_CGROUP_ID_MAX
> -
> -/*
>    * A lot of the calls to the cache allocation functions are expected to be
>    * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook() are
>    * conditional to this static branch, we'll have to allow modules that does
> @@ -3528,10 +3511,12 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>   }
>   
>   #ifdef CONFIG_MEMCG_KMEM
> +#define MEM_CGROUP_KMEM_ID_MIN	-1

Maybe

#define MEM_CGROUP_KMEM_ID_MIN 0

to be the first allocated id, so MEM_CGROUP_ID_DIFF is 1, not 2


> +#define MEM_CGROUP_ID_DIFF	(MEM_CGROUP_ID_MIN - MEM_CGROUP_KMEM_ID_MIN)
> +
>   static int memcg_online_kmem(struct mem_cgroup *memcg)
>   {
>   	struct obj_cgroup *objcg;
> -	int memcg_id;
>   
>   	if (cgroup_memory_nokmem)
>   		return 0;
> @@ -3539,22 +3524,16 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>   	if (unlikely(mem_cgroup_is_root(memcg)))
>   		return 0;
>   
> -	memcg_id = ida_alloc_max(&memcg_cache_ida, MEMCG_CACHES_MAX_SIZE - 1,
> -				 GFP_KERNEL);
> -	if (memcg_id < 0)
> -		return memcg_id;
> -
>   	objcg = obj_cgroup_alloc();
> -	if (!objcg) {
> -		ida_free(&memcg_cache_ida, memcg_id);
> +	if (!objcg)
>   		return -ENOMEM;
> -	}
> +
>   	objcg->memcg = memcg;
>   	rcu_assign_pointer(memcg->objcg, objcg);
>   
>   	static_branch_enable(&memcg_kmem_enabled_key);
>   
> -	memcg->kmemcg_id = memcg_id;
> +	memcg->kmemcg_id = memcg->id.id - MEM_CGROUP_ID_DIFF;
>   
>   	return 0;
>   }
> @@ -3562,7 +3541,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>   static void memcg_offline_kmem(struct mem_cgroup *memcg)
>   {
>   	struct mem_cgroup *parent;
> -	int kmemcg_id;
>   
>   	if (cgroup_memory_nokmem)
>   		return;
> @@ -3577,20 +3555,12 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>   	memcg_reparent_objcgs(memcg, parent);
>   
>   	/*
> -	 * memcg_reparent_list_lrus() can change memcg->kmemcg_id.
> -	 * Cache it to local @kmemcg_id.
> -	 */
> -	kmemcg_id = memcg->kmemcg_id;
> -
> -	/*
>   	 * After we have finished memcg_reparent_objcgs(), all list_lrus
>   	 * corresponding to this cgroup are guaranteed to remain empty.
>   	 * The ordering is imposed by list_lru_node->lock taken by
>   	 * memcg_reparent_list_lrus().
>   	 */
>   	memcg_reparent_list_lrus(memcg, parent);
> -
> -	ida_free(&memcg_cache_ida, kmemcg_id);
>   }
>   #else
>   static int memcg_online_kmem(struct mem_cgroup *memcg)
> @@ -5043,7 +5013,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>   		return ERR_PTR(error);
>   
>   	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
> -				 1, MEM_CGROUP_ID_MAX,
> +				 MEM_CGROUP_ID_MIN, MEM_CGROUP_ID_MAX,
>   				 GFP_KERNEL);
>   	if (memcg->id.id < 0) {
>   		error = memcg->id.id;
> @@ -5071,7 +5041,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>   	spin_lock_init(&memcg->event_list_lock);
>   	memcg->socket_pressure = jiffies;
>   #ifdef CONFIG_MEMCG_KMEM
> -	memcg->kmemcg_id = -1;
> +	memcg->kmemcg_id = MEM_CGROUP_KMEM_ID_MIN;
>   	INIT_LIST_HEAD(&memcg->objcg_list);
>   #endif
>   #ifdef CONFIG_CGROUP_WRITEBACK


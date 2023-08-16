Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898177DD11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbjHPJO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243232AbjHPJOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:14:41 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A6D173F;
        Wed, 16 Aug 2023 02:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB5HqslsCsuCJ6xbMIcw419VWI9QNGRuBSk+61bOk37PxpKErakuB5Wr9AgOKGYAVoi9mtljJFZ9mIs75eellYnBR/3KIIHk+AKZVSaawbg+nUClRMI7kNC0ZSpD0tNLXjuks8wLbqHa03TyZLBpBA4a5iR/p6RGmCMp0VY9xONfBFG5+3grDdzNWhWufRZ05xY6xdet0j4YcSbie1iPYRxt8u/WRKlrN74MNlxE2VpZ9lmpQdEjAr/qsO21KIEEIKsYaAavJGq5vm+GWuVKH2n87ZKvuUXYCX9rf9LyyV2YkEn+dhpsDsvkzv/AcWfMnozh7cnFAcO+AhX0ABW8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHGxfsxBPml018a602/Nx78dr3zFNR5FRrH6ywx44ng=;
 b=b0/qB8RHAXcdSU8qJ9DwlavFUnsFdhWcIfuDaqqDwNVTymGBdnn+89SYpQIOl+N3QQoW3cRpQHcGcauNPqNvzKvk6NVYejoDdR7c4jLazBWrmFSnKO4r2i0oBOoOGyW9+CPOyleJtNAYEXjD9XUO6DlbRqZ4a6BDxhZaWHUmmYEiawPdJeqVri1lKMNjalefJogc1BoOOn1g6oN/ndl6JsLqZgqaYLfaadZxlvNi37va4Hsk5HuCyU8E2M0l4qd/az+nn79WN47ZZxNQxzcACjJ9DMTkAqi+lgoeyiiA2WI7SLBBpxB/01rKaNR4wZzi40N3Mc8U4QhP6lX2DwInwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHGxfsxBPml018a602/Nx78dr3zFNR5FRrH6ywx44ng=;
 b=ZvBN2c3edodf5fP9/WsOyZz/8a9jqIG5J6KH0YXfI/4xjnsOj54UX2y2X3VnA3AVMrjYPKZDaxbLNoQqLGSqxNcF9wAMEize6BJAaHUga2ZF05DWIHbXyhWNq/ogZUKNjkm/khMD/CNXCQjPpV7JtrLOyrBw+I220Um/kwIjRrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 09:14:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 09:14:36 +0000
Message-ID: <01213258-6e27-f304-b420-f3d915e54ed1@amd.com>
Date:   Wed, 16 Aug 2023 11:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] drm/ttm: introduce pool_shrink_rwsem
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
        cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
        gregkh@linuxfoundation.org, muchun.song@linux.dev,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20230816083419.41088-1-zhengqi.arch@bytedance.com>
 <20230816083419.41088-5-zhengqi.arch@bytedance.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230816083419.41088-5-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b8ec7b-716f-419c-599c-08db9e393654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RG/Oh311H358yjS834lC5mbU6MluBYnILKSHmFagES4v1zDlfj6TFd2Lvhnc6l0fh/0xf7HXwDPnIrlruaTbEGZcax9HXgkYOjVKolE7g2NqWXaNWXrADwRNFlADyf/w0ywMYDetRns4x0GwhAQuXcjItDY17Oosn4DmVA1kYubHMy4UL4R76YBHS73MTniLSAAOB3FXe82q7pR/DFAMKTKnFeY43WnV5vjqxm7d2Le8tQPaz417bv/smI2zD4w8PtywJC8zCo5dDrxEGqgeF6IVBv5AbkuUfCgrIIzjfszaLbuYVJoH+XT1NSs+lmkDnGYRoi3tG2wci0DTUtouX3aYBc0cMHqD5O3NqmpWqIGCaga2pmGsqIRPSBZ4jq8pIVgxG9OjiONO1JEBdh214UTzAT9WIyEoc26FPPWh4v2VVtebCLU6s+c4Z/eeOS7xaQUUxyqo6mdnttCwDenG0iYoKZkoVE8Qy8k+va+H4CfTx10VcnsPuJiG8roD5MVv8WTzyqj04frF4LQtXSYegBNl2RBbzw+HS9HMdRtQ8tCcKkGOhYqpuVejzK6CS2yEs0ha/YyAeV5bx1f/3iDu6A9T92pUTDyaJopcabW6QSkIJhZ/3kYUNtJM4Gw8bpvhVmGmJtP5xECOKXOZCyOrG5fAQsFF0T+F3EluHiFNJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(31696002)(36756003)(2616005)(6486002)(6506007)(6666004)(6512007)(5660300002)(41300700001)(316002)(921005)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(31686004)(66574015)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHEwU3cwWnN3QjQ1ZEEwR0lOSEgxblpOL1RiM3NQRDcxUEpCWjVoVWZzMFhn?=
 =?utf-8?B?eDVMOFlqRW8vSW1VdThaL3FqTXRLOG1kS3Rhb05pT1pqTEMzNjVObHNPMUFj?=
 =?utf-8?B?MWJlRU03WWdxNDRKM1duYTgySEJSY3REUys2SnlRUVRJcWgreTNnWUdzRGpR?=
 =?utf-8?B?bmtSZzRGUDZLS0V4YWYzMWtwQndrZGhuU1hQNzlBSEdWblgxanQ1Ukp6QVdL?=
 =?utf-8?B?WHNtODUrOHhnRjFpQkR6b2h0NkVGNDFJeXZVMDE0NkZkMXoxMHhQMjBDOEk3?=
 =?utf-8?B?ZExhVm1xRWlrMEl3QUFjL0tQSzhXeXRHZUFjK1hkc1NDSXpIK3ZpRll5U1ZL?=
 =?utf-8?B?cUtFNFZMOHpZY0lMM2VVTDlUN2Mzd1RDM3FrZXVRNEg1U2lYMUVwU0pwYUor?=
 =?utf-8?B?a2tHOFRYRnY0ZFdJRFZyc0RzN3NyY2JLMzZNNDRoa1BqenRKeEVUbmNGaVg5?=
 =?utf-8?B?SXRBcjFhUS9tMU1PRk5SOWRYd3ozcDkwWUdoK2kxNEVmSDlwQUxaZGhCcXBB?=
 =?utf-8?B?Z1VYaGljMkRSMllTbWpkTDl0N0pLS01aSFdPaTJoRkdsbjg1S1VkeFo0dWts?=
 =?utf-8?B?NUE1SXJBeEVGUGxtV0VPUXRZdXVqR2IrQjJQb3c3MHVLVzFhNDM0clBRWmZz?=
 =?utf-8?B?OG1rK1NuL1orRTQ2eTZmWXB4Q3oxYWwwNDZiSnpxcXhkNkxMYll3Z2ZhTjdm?=
 =?utf-8?B?aEo1Qmtab2Zyc2FtQ0hrU3VmY2tXQjhhWTJpRGorS3NYU2ZMdGJsaG96WGgr?=
 =?utf-8?B?dlVKeU1ySHlQTjVtNDUwSTF4enpSQzM1NXpQUWp1UVFBMzBRQ28yS2JsZ2hL?=
 =?utf-8?B?dEZZRXNTNFpXcHhBRHNQTXlZVk12ei9uVlpxRTlvcEF5dGpiWnIrS1JiRGlR?=
 =?utf-8?B?bGd1Z3YwZENCMEEwN1p1bFVFZ2JoYmhMREJERUJzRk1kYkQvS1prVVBwOER2?=
 =?utf-8?B?S3F5Z1pKV0FQQkkzMEQ0ajB3c3ZyMDJwT05CeUk5bUh0NVBvelMySkJQZ3E4?=
 =?utf-8?B?M0dqRVU5dUZmUCs2QjFUek9PVWpVL1JXQVBuNVE1c1VmYzlGR2pFSndaQk4z?=
 =?utf-8?B?WGlnRjdLRHI5c3JKSXgvSEJzbXppK3lhcU9Lb0ZqajQ3WTQ5b2ttUzkyQS9z?=
 =?utf-8?B?TXBFTmJtVlREa3ZwWEJ2ZDdkSEhXcEJLR2ZpKzV6b0c3dFF6SFRzMUpLb0Rv?=
 =?utf-8?B?clp3YVB4RkcvaDdpVDFwbFNxbkpGYW8xVXErRm5zSmdIYUxXeUZTRHU2UnZS?=
 =?utf-8?B?MnloNHlMYnB4ZEQrMmtESWR0VEFsWXBycFI5T3VjVHcweG9Mdml2NFpmbENp?=
 =?utf-8?B?TC8zcTNIMGxxLzc2Z3hQaDJZYkJ4c2FvdVpzZ00rcXdCT3dRVDZmNktCcm1u?=
 =?utf-8?B?d0RzT1hnRUJqY1pkOXpsVFVnREZTYXVqOXptaUlmTll0NTU0M0l2TkcvMXo3?=
 =?utf-8?B?cE9HVTNMMDNSTHFRVTRiaE9YWHlUdFFid1ByQ3pkT0haVjJ5QjVCOG9CQ0xw?=
 =?utf-8?B?ekg5akhDQ3NUM2hYVzFDelhwYVBBcGt3R3U1QVZZYVZ3TTNWRHNMNEpVdXVC?=
 =?utf-8?B?UjNnRjY4N0tjM2ZtdGU0eGF2RmtHOXRrMjZsRXRoZVlVWGp6VTJtSFpERzND?=
 =?utf-8?B?UEE1VWRRQ1JtZTlDWm9yZktQSHJoTHlENTlsd2RaVnRJSUNac3V0NHNaRkVw?=
 =?utf-8?B?dVJNR2RyT3lxd0I4a21MM2ZpMFUrMGQ1WjErK3B4anl0OCt4NGc5YzQxSjRR?=
 =?utf-8?B?c3EzOFFXMVZuUGI5V2hHMzN4WGxKZC9jNVdHTXpURmtuekxJYzlEaUVUN2xo?=
 =?utf-8?B?R3ZUbU1JUmxQeXoxRGp3VDhtR1o3K1NEVXFkSng1d25uVTVqRDRHVjVFSjNU?=
 =?utf-8?B?UFd3SU1vcWVTRjE1TjZyZlB1aVF3bU54Mk5GSmpGWklOcmg1Rlh5WEpkVEZX?=
 =?utf-8?B?VE5rSDhmWThJYTlibW9mR3VIcVo4RU5FcUF1bGlkT1J5TU5hTDZkdGhjelJt?=
 =?utf-8?B?WHlGWUN1bFVOUnpLck9CZ2xNZjJSUllzY1Rid2hNYzV0R3FkMDUzeWNzbi9R?=
 =?utf-8?B?UytIZEgvVjNBUkJObndXcVdpUmZmd3p4TlBsWjQ1bjBBQmFGVlc1ODUxaG5l?=
 =?utf-8?B?Y3hvbGdya3FDSTdHVGE4a0VybkpXY1YzVTBQZ1B5aTJtR0RycVlMVTlIZ29C?=
 =?utf-8?Q?M78peWrBCWuHlZH1ilQ3QXttuOpYPDe3Xo3fydrrhC0X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b8ec7b-716f-419c-599c-08db9e393654
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:14:36.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlU23JzQC8sE0DWoxo0X3yotTjIgqeaYOxOlSSRgcycCFjfEdst0O8yRtNVk2KC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 16.08.23 um 10:34 schrieb Qi Zheng:
> Currently, the synchronize_shrinkers() is only used by TTM pool. It only
> requires that no shrinkers run in parallel.
>
> After we use RCU+refcount method to implement the lockless slab shrink,
> we can not use shrinker_rwsem or synchronize_rcu() to guarantee that all
> shrinker invocations have seen an update before freeing memory.
>
> So we introduce a new pool_shrink_rwsem to implement a private
> synchronize_shrinkers(), so as to achieve the same purpose.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 15 +++++++++++++++
>   include/linux/shrinker.h       |  1 -
>   mm/shrinker.c                  | 15 ---------------
>   3 files changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index cddb9151d20f..713b1c0a70e1 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -74,6 +74,7 @@ static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
>   static spinlock_t shrinker_lock;
>   static struct list_head shrinker_list;
>   static struct shrinker mm_shrinker;
> +static DECLARE_RWSEM(pool_shrink_rwsem);
>   
>   /* Allocate pages of size 1 << order with the given gfp_flags */
>   static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> @@ -317,6 +318,7 @@ static unsigned int ttm_pool_shrink(void)
>   	unsigned int num_pages;
>   	struct page *p;
>   
> +	down_read(&pool_shrink_rwsem);
>   	spin_lock(&shrinker_lock);
>   	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
>   	list_move_tail(&pt->shrinker_list, &shrinker_list);
> @@ -329,6 +331,7 @@ static unsigned int ttm_pool_shrink(void)
>   	} else {
>   		num_pages = 0;
>   	}
> +	up_read(&pool_shrink_rwsem);
>   
>   	return num_pages;
>   }
> @@ -572,6 +575,18 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
>   }
>   EXPORT_SYMBOL(ttm_pool_init);
>   
> +/**
> + * synchronize_shrinkers - Wait for all running shrinkers to complete.
> + *
> + * This is useful to guarantee that all shrinker invocations have seen an
> + * update, before freeing memory, similar to rcu.
> + */
> +static void synchronize_shrinkers(void)

Please rename that function to ttm_pool_synchronize_shrinkers().

With that done feel free to add Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> +{
> +	down_write(&pool_shrink_rwsem);
> +	up_write(&pool_shrink_rwsem);
> +}
> +
>   /**
>    * ttm_pool_fini - Cleanup a pool
>    *
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 8dc15aa37410..6b5843c3b827 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -103,7 +103,6 @@ extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
>   					    const char *fmt, ...);
>   extern void unregister_shrinker(struct shrinker *shrinker);
>   extern void free_prealloced_shrinker(struct shrinker *shrinker);
> -extern void synchronize_shrinkers(void);
>   
>   #ifdef CONFIG_SHRINKER_DEBUG
>   extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index 043c87ccfab4..a16cd448b924 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -692,18 +692,3 @@ void unregister_shrinker(struct shrinker *shrinker)
>   	shrinker->nr_deferred = NULL;
>   }
>   EXPORT_SYMBOL(unregister_shrinker);
> -
> -/**
> - * synchronize_shrinkers - Wait for all running shrinkers to complete.
> - *
> - * This is equivalent to calling unregister_shrink() and register_shrinker(),
> - * but atomically and with less overhead. This is useful to guarantee that all
> - * shrinker invocations have seen an update, before freeing memory, similar to
> - * rcu.
> - */
> -void synchronize_shrinkers(void)
> -{
> -	down_write(&shrinker_rwsem);
> -	up_write(&shrinker_rwsem);
> -}
> -EXPORT_SYMBOL(synchronize_shrinkers);


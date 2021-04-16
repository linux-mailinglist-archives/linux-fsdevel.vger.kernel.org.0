Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2744362017
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 14:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243031AbhDPMrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 08:47:19 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:31245
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242810AbhDPMrS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 08:47:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNJm020XyLWnVTMDjt7Fy1Heucw6bON4CKgEDGofGow3AMIeresJaEnq3CxsquHTscUzSm5Okp55AR5WHlREDH//dkmsIATHfIp9RqaQgmaRV+ZsOSCBHqcIoCf7Khs4WvyMrOgKmb9pMjWbLGXBY/ZMJb7FOP2vEBCQb3d322eujzg2SBR5QT49AC56oNFpuXHAbB7nSoWNcuJTXIl0UB2X031N5hz4xwN0F/fO0VsOUPsQ3ZyRdQut02/3KTFBTvomvtI8iQvK+awLZkfArrj9H3uoY+zuWBnOTvRoYb2F5GMgBLHdpyNzrMjJ39I9LDWT654t7b8QdexJMKc/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLQJj3VoS0pNsqZK3ojcV1ixz8x2vryDgtLmuArRshE=;
 b=XPMzam9DYvu/DQzvboZ/Kqa2piKuN6WPEc4+ztTzem5MfixiRzWLgqRiGiFaLwW/fG/IQFQvfTubVjHcg6aSPQXJKtMfxW3I8kIybgWGBNJY3m0Sizgib3tGjwZNfUEHRUrF3yNkQW8hDBUoPlUoVmnQZOtd6DnhNYrsGqUZRTMXBpmzuwvqGYjQtNY8aR4OurjNZRwn7fin1sRTEMaaaHlXJbx4lY1ZBrxcOwWkBMpS9I6qGZ4GOIZpTCHlZqvLlZrIsrTtacPxAM0mx8ymU/8fpi+sfcebH9aeTC0W77A5jj8gQTq7wbWG0ME1K2WmW2i0NtA8TuGqatOx7+EwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLQJj3VoS0pNsqZK3ojcV1ixz8x2vryDgtLmuArRshE=;
 b=Q12fcjG3UVmROo37cJNJtm+NyGYPrp1TO2Gt2ipsbxlH/itgMdmmZxhyQ4H8b4KSqNiC0IgQcJqHLfYpQOaC3nnJIZXaQrIu6sMIDS+w35+Fq+9r8yURPtP+tR/Uv/iH2KnQSx+zTLoD7s9axZsfMU/k3xgcrh/xnk3/AFbCCN0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 12:46:50 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 12:46:50 +0000
Subject: Re: [PATCH v2] dma-buf: Add DmaBufTotal counter in meminfo
To:     Peter Enderborg <peter.enderborg@sony.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Matthew Wilcox <willy@infradead.org>
References: <20210416123352.10747-1-peter.enderborg@sony.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6979dc43-a7a3-e1de-6794-365bc1e2c904@amd.com>
Date:   Fri, 16 Apr 2021 14:46:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210416123352.10747-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:6a8a:26d6:7403:5ada]
X-ClientProxiedBy: PR3P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::23) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6a8a:26d6:7403:5ada] (2a02:908:1252:fb60:6a8a:26d6:7403:5ada) by PR3P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 12:46:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00e151b7-eb29-4e53-09bc-08d900d5b461
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41096E855A275299FC6CE55C834C9@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYcn3FWW3zPIYnzpEeruroPzsuXxd/eOE52xJMLURY4XxVvkAtkIe86YTp0xHEckySWnWKRvEZsr3zpJcB8K+7bjxvhNf7Xy192uXwjetOE/c5LesctKuZMzsy49maNRw55+IHJeML4/AaKzBVyvVmFhZcvidcRCMl13w2nTR5lmOwuKqXqulliLJsEyxl2zWIOrYUcIJZEJhQjcT8AZwlssOPYgRgeRziLTCmK1thOHwN/g5nZ3ncaaTxvKe2x0R6jZVlEhtkbTgCR6evOMQ7OB2c+BP0w23oUTYzgo0s807ykxgtSQMHYlhlNoC6Xrpw/XBsnr2MZsHBiQ0Ag+Nl19kQ8Vo9Z27SPE/e51i72zrGSTOH0TEp+NwtYm2VJoBOcrKSDEfTV1er23lrEn1+l6QJzNdjcS4OL4icUrgR5h32C9X/vQW3vlJNl/sl3bKTjx4K8wk7lwk45nOh4NPMKqxXjrKjl81UhHfVltJnYZ0l4EvPQAgZHY4sjYCNWRil60s2qb3xby1rhNI3RX/jnnfh+Qv23sDy07wxWJ+x/KGXOBCFYDYmhjshgWmeyCPeM2H8PprFq6BmWOJUmJz3kW1QWeOhVYdXY+O5kj7XqwrSWjiS1PgMWD8+nssRz6AMMKnKlHRFl73F923cI3mVnzkNRorpFSowVpItDI+xMQv9Ts676OQvgv8fPHyq2cGQ/DZhRX5nE/AVHhE+fuJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(38100700002)(6666004)(66476007)(66556008)(66946007)(52116002)(6486002)(36756003)(2906002)(31696002)(110136005)(316002)(16526019)(31686004)(2616005)(186003)(8936002)(7416002)(86362001)(478600001)(8676002)(5660300002)(83380400001)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NXMwZDNjTjNvSURyVnJFd2ozUVdxWmFIWld2bGU5cDJGUG1mNmFxOEVKYzVU?=
 =?utf-8?B?YkJ6VklkM2dRYUpzNmUrb1Vtb251eEh6WmJlZDAxd1RmZ2l0bjBIZ3BURXYr?=
 =?utf-8?B?YXNtNkl1Q1hLVlY2TlNaZ1E2aXhtWklOVXBqYmh3dzJpejd2V1JHeG1ZVngw?=
 =?utf-8?B?cVdpem0xbUxNQU1ZcjRDdXRLMUM3Mi9uOGl2MnkzYlZjL2xQZitoNnZpVkR1?=
 =?utf-8?B?dVJXNzFrWHl2aXlKTmNLMmlpWEsydUpWcldTL2E5eGNDT3NaQmExSkQ0Y1R1?=
 =?utf-8?B?bll1ZXVUVXozWExJUDEyVzRVOURndDNQZzN6eFZtTldqREFVWmh5dVRqc3pO?=
 =?utf-8?B?cndBV2ZSSWVIVEgxN211QmFtOTNteFlpSFl6QkZQL0lGNW01RnVoc2xZQ1Vp?=
 =?utf-8?B?SkUrb296WS9NUWNFZWFwRnR0UEVVR1JCMW1EbDF3SWVMd1hiaUVsa1Q4b1Zp?=
 =?utf-8?B?VHh3YkRwKy9JejRUVSt3dFRzQTNwWVl3U1NjdDBjME1FRE5FWmdGVk9jOVMy?=
 =?utf-8?B?cHhjclBWek9CcGIzalZaTTU1OTdydFpBcUt2OHh0QXNMOXZtL3R6YTArVCs3?=
 =?utf-8?B?Y2RMZ2w4NjZPQ0FNeTltbmJSZE9GK2hJazYyN3dVcVdlVmxXVk5XRmZ6MTlm?=
 =?utf-8?B?NlFORVluK05ySUFEdnJFbmpyUlNlcDFGbXhibDl1dFA4ZTZ5a1dnVThRREM5?=
 =?utf-8?B?SitzUWhBQUxxdjV5ZzhJTjFLNUJ4UHdnSDc4YkhNVWdKQnVsWlVRZmRUU0JM?=
 =?utf-8?B?dHVaYVZsZjM2UU0xQWFXbExBUk0yVTQrbGx6ZVU4NWtWYmNuSGQ3ZlFJcTdV?=
 =?utf-8?B?aExybUluWFc0UE9DT2k3enlLMXRFUjJsVEFqMjNzZGVHUTEwT3NvUEx4bnNi?=
 =?utf-8?B?R3cwZXdWSW53OTMwM2ZzVzNlaEFBNC9pMW4vTUhob0J1Q29pdUE5UVFsMTky?=
 =?utf-8?B?UDVDeVJlVERpNzB0aVpVQUsrSkFpRzRBR2lTaFR2TzdmY0J2N2JGVUVOTC9M?=
 =?utf-8?B?U2krbW1PaDFWVjFTVXBNS1NaU3pZdlFiYlJqSTNpZmtaTDRwZWwwS2diQmtS?=
 =?utf-8?B?TzNVU2RCbncrRGdkTE5oc2YvVVIvWDk1MUl5Z2EwZWh4NGt4NUZiTmxlTncx?=
 =?utf-8?B?SFhsU1BzUWFOdVFPSjQvemNoTHVJb2JPeEUwazFKazRyVkdTMjZMMFBObFhE?=
 =?utf-8?B?eDZ0YThwd2Nzem03MWk1RDhMUlg0T3pMSWdBaWlUait3VmRqUXgzaFZDdWVy?=
 =?utf-8?B?YytScTZSZXByZ1R2QWhYYUVRSWZMcXI2aHpGOVBMWitTbFNVUUg2QWJSbEQ5?=
 =?utf-8?B?cGZFSnBQSFRtYllnUG5tdnlLbEIyUzJDZDNCb0sxVCtQbks3K3ZlVmo4bHE5?=
 =?utf-8?B?ckk2UTlyWmVWakxrc2M2Z3pSWnF1Ty93eFpiRVpVNHFackhhbmZJRi9mdS8v?=
 =?utf-8?B?aHAxREt4Q0VabDJGdjFERXoxeUY2U0F0bDJYeHBJL2RUUEg1anlUdjM1VEtO?=
 =?utf-8?B?a1RRUjNrdGVOQnAwS3hOVFlpVlhuUnoyWWVTOTBaUEdmcSsxWGFVU3dTL0Mv?=
 =?utf-8?B?RlhQUXN2OHFIdWFtMUNSR1JHcWw4QmVKcWliaUVkamQwQUtBR1FxNitOTFU0?=
 =?utf-8?B?RVZHVCtPY0ZRUnJ2bmdWMksvZjBjTXpNZWcyc1BVeHV6MVdSbW1MZFdXc21L?=
 =?utf-8?B?ekk0ckRLZEoyL3dIRG9waUdDRU9PQ0tSTlhiSFErVkgydHh3VXk5NnEwMGlY?=
 =?utf-8?B?Y0duaVp3cEcrNVg5b2JBUCtoQ21WN1Fndm5WbUluU2t1b2ZiYStRTGFlY2JO?=
 =?utf-8?B?cXpnMVhTaUFWMFlFY2dWOExHaHk4UUVPSlMyc1RPUkdIZTZUbmltMFlPeWg0?=
 =?utf-8?Q?BXBX8HsFwfoM2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e151b7-eb29-4e53-09bc-08d900d5b461
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 12:46:50.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZkRQmCHLLYMZQZsfLLVq7nkYxb1/7uMeTmz7zcT+iiy+uUt2JbSQHVpq/tk1ayO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 16.04.21 um 14:33 schrieb Peter Enderborg:
> This adds a total used dma-buf memory. Details
> can be found in debugfs, however it is not for everyone
> and not always available. dma-buf are indirect allocated by
> userspace. So with this value we can monitor and detect
> userspace applications that have problems.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>   drivers/dma-buf/dma-buf.c | 12 ++++++++++++
>   fs/proc/meminfo.c         |  5 ++++-
>   include/linux/dma-buf.h   |  1 +
>   3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f264b70c383e..9f88171b394c 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -37,6 +37,7 @@ struct dma_buf_list {
>   };
>   
>   static struct dma_buf_list db_list;
> +static atomic_long_t dma_buf_size;

Probably better to call this and the get function something like 
global_allocated.

Christian.

>   
>   static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>   {
> @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
>   	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
>   		dma_resv_fini(dmabuf->resv);
>   
> +	atomic_long_sub(dmabuf->size, &dma_buf_size);
>   	module_put(dmabuf->owner);
>   	kfree(dmabuf->name);
>   	kfree(dmabuf);
> @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>   	mutex_lock(&db_list.lock);
>   	list_add(&dmabuf->list_node, &db_list.head);
>   	mutex_unlock(&db_list.lock);
> +	atomic_long_add(dmabuf->size, &dma_buf_size);
>   
>   	return dmabuf;
>   
> @@ -1346,6 +1349,15 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
>   }
>   EXPORT_SYMBOL_GPL(dma_buf_vunmap);
>   
> +/**
> + * dma_buf_get_size - Return the used nr pages by dma-buf
> + */
> +long dma_buf_get_size(void)
> +{
> +	return atomic_long_read(&dma_buf_size) >> PAGE_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_get_size);
> +
>   #ifdef CONFIG_DEBUG_FS
>   static int dma_buf_debug_show(struct seq_file *s, void *unused)
>   {
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..178f6ffb1618 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -16,6 +16,7 @@
>   #ifdef CONFIG_CMA
>   #include <linux/cma.h>
>   #endif
> +#include <linux/dma-buf.h>
>   #include <asm/page.h>
>   #include "internal.h"
>   
> @@ -145,7 +146,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	show_val_kb(m, "CmaFree:        ",
>   		    global_zone_page_state(NR_FREE_CMA_PAGES));
>   #endif
> -
> +#ifdef CONFIG_DMA_SHARED_BUFFER
> +	show_val_kb(m, "DmaBufTotal:    ", dma_buf_get_size());
> +#endif
>   	hugetlb_report_meminfo(m);
>   
>   	arch_report_meminfo(m);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index efdc56b9d95f..f6481315a377 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
>   		 unsigned long);
>   int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>   void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +long dma_buf_get_size(void);
>   #endif /* __DMA_BUF_H__ */


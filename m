Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3287362F68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhDQLAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 07:00:16 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:58187
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230510AbhDQLAK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:00:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFuTTQ5dGrbvyB2jo0YALLCsJDmNp6wnHyazaBQ4LKFq5MX7XdMDBp3HxL84UL0EvDshsect8bzamjA7hWXRQg7W077LKOYNi4X1lyrMzd1f8gGgMhZSrVZNdmaU5GfKOvCNVbPnpxtfI62eLwjBWB0SnGvqfqlcHGyxyDxVehZpNoW7PRDpbaMQrDL54bKJGizB4AorJjr+x4sOiA/a85L4cf9r/zycNyANQoBA4I/vMU6cMK+KXZcyZlVsNbzoPjElBnX86NWMT7x0r2CDmZw4YBydD0DgfL6Bp0E/Pk3/rqrhoPgJ5OrUY2hBCYD65wZiCYj+3EADxJGKWaStOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWiRsND0vKe/WAo3EALBXIxlfUpd3DaCFSoD4xiZ1N4=;
 b=Jo+OWQzNeq+vZWD0/9deLobCIu6LTSB2N0cywRyl4uVVicKjt6Gakp6ge7DZY98i/Dcw/95st9/5DB0ptPNVDGYKJxeaELM2JxT5mmZ9asQqR8/WHSVwZKyLilst3Dh+2dniNglF4CnDZe2yLk6QeLzIxZgh1dhs1fb1QYdjPu/WlptrrwdSS/tT5m4ozBjn/Hjg0gCiJjQ/1xhXvHC3+tBU50H4sL0slAC/PYkpmbv4Rx90byHuJkXQPZALKXYpVeKI6D7K8vKNCEQ6hkZ6d1lmQg17DCvpF0/lNTu0rPeK1HNf37g5lwey2btKnPZleUI/W26fwffkx9uf62Bv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWiRsND0vKe/WAo3EALBXIxlfUpd3DaCFSoD4xiZ1N4=;
 b=PmmQZ34aXiR5SQ4VdFDtvFIGQ/7XHnu3guzZJYCGFkjgFffjOeH3mZ71UekezUDSGRMUkODzHi8Uc9HJQMI6xWXjzVAq71GW5+h/EMsHcvmNhdUQ20t+wcqvdca41rFRedJxliNzHgdwhO3rUy3P4+62YJC5qDleOIiqcj7rqVU=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Sat, 17 Apr
 2021 10:59:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.020; Sat, 17 Apr 2021
 10:59:41 +0000
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
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
References: <20210417104032.5521-1-peter.enderborg@sony.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d983aef9-3dde-54cc-59a0-d9d42130b513@amd.com>
Date:   Sat, 17 Apr 2021 12:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210417104032.5521-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ab38:d4e:d9c0:1b68]
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ab38:d4e:d9c0:1b68] (2a02:908:1252:fb60:ab38:d4e:d9c0:1b68) by AM0PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:208:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Sat, 17 Apr 2021 10:59:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 627eeb0b-4122-4c81-9df0-08d9018fe6af
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4223FEB9E3E609A84B025E4B834B9@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHL6mzCZvtb6A5pVl773rfJpc1iqGUe44v1Vp/HIdbcwEZZaXsx3PXgGiSD/3/bi+HkTdPuzrD97InCySFydoNJ83hej331z0fi8ARg192ma3WEkVWJMLFG5GKnBAzI35qCPyyGGZyl7MamLJyX+EtRCZQwW4RO83/cvRQeeAZV43APhQVVAjiHGfbzhZ6ALogOYZHni/yBj4nB9iRUEm8AjdBl/fpuFX0tQre1RGtVEZCSp7BZ3QY3ITXztxM191dr+wluwUq/CRrXoHxe9gcwc5jx2zybtHEaLFrdA+EK6iWSEsQWiSUMcf9J5+B6QN8wco8tskP4wAnj5zpKaD0sU9RdhiZlDy9/rX8VMqqLYrDIcxiOZs5Jkj3DmqPcLDEN47ZvpUza0KWywCevmgfB8sfGzBlamh9UKhQIaCfwiLe6fhxsM5vvpHVOEL61hSr8tRjzvDeMfuzTFZqiJ4voLsJV2naCFEdJF3Xa7Lr5nlYtrDA630lYrTyvQtkp/NneJyBUy6kuFPpobA0NLJOzCeQyulRY+x9jRaYfpEhoHnpQFVWNLEo/+E0NYtCjRTi+3dWh6Oc399v1AeCmGL64E25wxTOUv4FEMn2sUtZSaz2hfEQ/qzzDvp2hslsWhIikP/CIbEiVVcN0+j/k1vKf5UnYYqATEnyX0lNy3E8z4u61kSBaImfXjxw5UJ6OKmtjtGMfgdPcvGz8aqs/y9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(2906002)(8676002)(478600001)(66946007)(66476007)(2616005)(36756003)(16526019)(186003)(66556008)(7416002)(6666004)(110136005)(5660300002)(83380400001)(8936002)(66574015)(316002)(86362001)(52116002)(38100700002)(921005)(31686004)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?blpCUFN3RStQSXB5ZVppTERQWkpNSHVYeFV5b0dkV1FGS2NPRjFlb0w0dTlS?=
 =?utf-8?B?bGd2WHg2SEpKOTFnMUZhMjFBdkxwV3pFZ1I5WDZJZnVMbllqN21XS0ZsMzhn?=
 =?utf-8?B?YTN6eWYzRkhrMUh0eHgxRmRkL1Y2UVFhbkl4N2tFQXhmcUt1cFZkaXc0Y2tO?=
 =?utf-8?B?MUpDbkRMampxQnB5T2hLS0szYjgweTQyWlYwbm90ODBwb3Nsem1VTjRQcTBJ?=
 =?utf-8?B?eFU4bzNkYlk3QlRUZkg3eDNoOTREeXVZNnhYYUkyNHp5enZ4T3NQNjhCTXdr?=
 =?utf-8?B?VFZCc2k5b3pjRnFSVFF5NEU2Ykx4UlJ5Qzc5bWNYdWVTVUs2M1A3ak5CNHVI?=
 =?utf-8?B?QmJOTnpwbk15VjNjL3ZJeUZxbnM5SDc3UEF4Ty9nSlNCdEF0b3J1MC91VFdJ?=
 =?utf-8?B?cUo1RDRBSG5yRGJXZ0dCcGxRNCtYSDFoUFovQlRKVGd4T2h3UjM1bENFNGhi?=
 =?utf-8?B?Nk5aeE1nYVFROFJYWmR3dE10LzljeHdmZFFPdFJuTTZVcjNVTm1BYkt3RjNK?=
 =?utf-8?B?T0RMeUZIUW14eHFFMk5sZlBTTmNLSlBrRExjTG40SjE0aFdyYzlaVjZiYzAy?=
 =?utf-8?B?b1p2UWgxM0cySCt1QXVKVSt1ZXVHeEpPd3FyK29Yd01Ma2wxeFRWVHl1bUJW?=
 =?utf-8?B?cXBjVURDZ1dtRDdKR2JmbkM5RkdUN0tETytzaUFjeGhhYy8zUys1d3dBRGhH?=
 =?utf-8?B?U3JHdkw0TDVwRnFBK1RUQTV5c2lHYkt0TDVwUEd0eng1Vjl6VUNLNGJmV2Ns?=
 =?utf-8?B?RTNqTUt4c0FKM3FJQjNvT2dXMDE4SVVEb2dYUWNBbC9qVXREemFUR0ZHMGtC?=
 =?utf-8?B?eVlNVXlDZlpzdWZCbGt5RDl3NUtFUmJFQkNNYW13bC9TYVhKdnEydDFKREFF?=
 =?utf-8?B?WkxhK3U1UWtBekRkcDE4bkgyUjk1TUV6TmFZL3dvdE5HTEdTN1poMXc5cHlC?=
 =?utf-8?B?c0dKSnZZWU1hOEFyakpmV1ArVzdNdERoNFdNSTRyTW5KM25EZFZiSGJQTzVI?=
 =?utf-8?B?QlRheCthZ1ZScjROSS9GQlZ3NmVUa0MrUk5rays3UHkxaDJtQ2RsM1BmOFJm?=
 =?utf-8?B?cy9raG1xZ25zTjRJais4MCsrejN3TXhFWWlQbHBBTU5nSWU5ZDNsWXNWNmdP?=
 =?utf-8?B?WjhQRUlxdGJOV2RBTlFNZTdjT3JzYWQ1eTg3WU5FaE1MMGJXeGFvcXFIRU9q?=
 =?utf-8?B?dmlTZ3RGM25RVnJBZFBHU2JUc3IrRmJQQ2NRbXY0Ylo1TjQranRSdW1sNG41?=
 =?utf-8?B?cFJhMHhMcEcrcHZETWZYVTVsQll5SXBLSVlQRlZnSWJsV1JCcVZuNlpRaEJT?=
 =?utf-8?B?elV4dnJDUWJlZkprbCs3RkFyOHQxcUFwOXdsZEliUFBpdE5BSERmRFk5RjBh?=
 =?utf-8?B?bm5VNitabTloc0J3R1BnbndWcEc5RVYrR2ZIZHc3Q2tPTXBxTGtiNnE5SDYx?=
 =?utf-8?B?ZVUrYzlPVG8xWjhxL2FTczl0UmlJZmVJV25ES2pWWjZqNzZNdlZ3aDc2bDhF?=
 =?utf-8?B?VDBRbHRsL0QvRHNkQWZsbGU5VzI1U3htRHRJdlJLMHgrMEExN3hrMEh3cTFS?=
 =?utf-8?B?K2U3S2J3TFpHTTNodC9vN0lZQVJNeHRseWdTdXY5cDdPOFRWSHM5ZmM4dnBR?=
 =?utf-8?B?ZHFFVVFYWEkrbENRRDNORDd6a2hyRFVFSVkrY3JzOVkzZlpYZVNzTjYxVi9I?=
 =?utf-8?B?dXlmQ3ZMdmNyOG5ZZTdyaHB6Y1l5dkdNWk1kSXhsUnBKQUxpNTJoTEErWTMr?=
 =?utf-8?B?UXBScTlmUU92RDV2VGlRbXFJUklkZ3FvMmFsdkVCNDhjL2ZTaUQ3dC9nRG83?=
 =?utf-8?B?SkJsV3ZPMDFtWTNQdGEyNmhRdUFOYUl0cFZnM1VoaTlnNktzUnpkU0l3dHQ3?=
 =?utf-8?Q?uhQN+x98lBO40?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627eeb0b-4122-4c81-9df0-08d9018fe6af
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2021 10:59:41.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL/SHxQZk9j7ARcHzajSMabRLKKRtas2FLc0H6Yp2121BH5h1cRqV7zYSLorBx8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 17.04.21 um 12:40 schrieb Peter Enderborg:
> This adds a total used dma-buf memory. Details
> can be found in debugfs, however it is not for everyone
> and not always available. dma-buf are indirect allocated by
> userspace. So with this value we can monitor and detect
> userspace applications that have problems.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

How do you want to upstream this?

> ---
>   drivers/dma-buf/dma-buf.c | 13 +++++++++++++
>   fs/proc/meminfo.c         |  5 ++++-
>   include/linux/dma-buf.h   |  1 +
>   3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f264b70c383e..197e5c45dd26 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -37,6 +37,7 @@ struct dma_buf_list {
>   };
>   
>   static struct dma_buf_list db_list;
> +static atomic_long_t dma_buf_global_allocated;
>   
>   static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
>   {
> @@ -79,6 +80,7 @@ static void dma_buf_release(struct dentry *dentry)
>   	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
>   		dma_resv_fini(dmabuf->resv);
>   
> +	atomic_long_sub(dmabuf->size, &dma_buf_global_allocated);
>   	module_put(dmabuf->owner);
>   	kfree(dmabuf->name);
>   	kfree(dmabuf);
> @@ -586,6 +588,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>   	mutex_lock(&db_list.lock);
>   	list_add(&dmabuf->list_node, &db_list.head);
>   	mutex_unlock(&db_list.lock);
> +	atomic_long_add(dmabuf->size, &dma_buf_global_allocated);
>   
>   	return dmabuf;
>   
> @@ -1346,6 +1349,16 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
>   }
>   EXPORT_SYMBOL_GPL(dma_buf_vunmap);
>   
> +/**
> + * dma_buf_allocated_pages - Return the used nr of pages
> + * allocated for dma-buf
> + */
> +long dma_buf_allocated_pages(void)
> +{
> +	return atomic_long_read(&dma_buf_global_allocated) >> PAGE_SHIFT;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_allocated_pages);
> +
>   #ifdef CONFIG_DEBUG_FS
>   static int dma_buf_debug_show(struct seq_file *s, void *unused)
>   {
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..ccc7c40c8db7 100644
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
> +	show_val_kb(m, "DmaBufTotal:    ", dma_buf_allocated_pages());
> +#endif
>   	hugetlb_report_meminfo(m);
>   
>   	arch_report_meminfo(m);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index efdc56b9d95f..5b05816bd2cd 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -507,4 +507,5 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
>   		 unsigned long);
>   int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>   void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +long dma_buf_allocated_pages(void);
>   #endif /* __DMA_BUF_H__ */


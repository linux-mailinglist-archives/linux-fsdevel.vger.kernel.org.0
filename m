Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE1361E81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhDPLVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 07:21:02 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:26464
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235011AbhDPLU7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:20:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuB05X1p8GnmUN3AKixbetRjCfMjTXpyF2nK4Zny2PW9Cdqwvml39FkXNhqQ1Z6OvjMFDe+/pJYrBb22k9USKkhkFkHZ0OChDPhZ1IoDfyfWI6tkOIcIL6PQhKGjReWZEPa+fAbtpg3RH5G3jk4UD7wQQ2zEB96CKeUyzOVlzKM/gwzWFkWRy6Ziqdzzx7fu7XTo22P4wOdhVTESodLpRfXKMe5/QLnkWzbIPVVXBbSe+iLd7SibTKqIJTws1pZz3NGDXbB36X7USxVySWljCVias9K8AM6i+RlMGiI4xGmmHhYOEalb3yWl66LgKkX0XWUV1D+145oNtfh69ZzdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mzaq5SeSQBT5kv4GH+0TEnHBYy73Gx2xYZhGu5Kixk=;
 b=M/ww9RywIo61AkU9ns51AkXr3VN1/U51sPynDknyn/An1ttDzHHosf6KXIrBz3oskjoUSfQ5c5Mm26QibfyjTkGGguto6TMx4Gjt4h3UE+pa5NZGtXYq3CsV93As/c59GcXS1esAjWplcEHV7JV+ksxFaZnxIpJATEGCgn5svrpVspjb0/+i3Jwztcx8YCS+KTaL72sJN8AkN4A5c355xk8+Bcg8KMkk79t6aD6zWYGQ9Y7QKMglJv79CwjaxWZld0fNj6ZXkihi7L7sb7jh6IRUv2vKCmr+KYAGz+Zx0cQIrGT37mn08NjmG46wb8t5r//M3f2MLDXZGbD89aO9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mzaq5SeSQBT5kv4GH+0TEnHBYy73Gx2xYZhGu5Kixk=;
 b=EmpHoaYATTMOKyKTPgS5P3haHuNBtk1w0G7Sys8CZXvBg7NqDQGZxSkyernOBouVr79f0PGRmHr/zIzRutrCImu8EPHYckq9QTQEfrb1OSv9kMuDQdfizUdnwl47oFj8E4ZwyHOd+HQ3Atewp6ytni+vh9gBrelHJZfggMOdOyg=
Authentication-Results: lists.linaro.org; dkim=none (message not signed)
 header.d=none;lists.linaro.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 11:20:33 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 11:20:33 +0000
Subject: Re: [PATCH] dma-buf: Add DmaBufTotal counter in meminfo
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
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20210416093719.6197-1-peter.enderborg@sony.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8287166c-6899-e723-ac2c-fa49f5a69a5a@amd.com>
Date:   Fri, 16 Apr 2021 13:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210416093719.6197-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7856:2ddb:903a:d51a]
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7856:2ddb:903a:d51a] (2a02:908:1252:fb60:7856:2ddb:903a:d51a) by FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Fri, 16 Apr 2021 11:20:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ae867c-150d-47cf-ceeb-08d900c9a668
X-MS-TrafficTypeDiagnostic: MN2PR12MB4061:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4061970851174207E4BB0BCB834C9@MN2PR12MB4061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5khstJqHPlAvdbbkdLR9XBzvi4CGwwqsDHJ5lbDnxLQJZFsc0KLgCK7mS/H4TK4eSyh76olwWf8FKU4NzhBXQer6jimsy3MRT9oqXPPtPsyPy+OFtFVmmnUE6iPLwL2DkacSmKWmblKZ5QkJZiIE4IAFv6KY8KZ0kdCnFiS7ngvtHhCh3tFZ7sIREwbbb/hfX3M80Y4EaliuCOe3hYwY2cW4KS4lmdz7XXezSDysS/sJXW8tgTNNOiOgu1VjSPIKmOYcLF9caLY6JCDusIFzRCWoJ+BB8TcWb0PxOMx0/50F89d1bYJne+CJ76HEqMkiOy7Zs6HDqPl6hA7e4oLMRmJuLmgK3RREy76G16mRsiAv6rDWpZyMtSe2G/lMb9+TXOinBZJYzapxOLYQrnII3gj72aHmoIGmBJO2C+Iv1ODx5WKSnp54jUz2hw6cV7vbeLug1eiLjswLGC/I69ud7Fzaj+FJvSyFiUQiFgPhEFZOeO6Nk4YoajvnSwCVwvfC9iyoGjBFV3xX5mrxUOQ2IdUj2qpvazraYij7o5w1DmE0BnLM19+I3x+/Rby2qTRvg0/RHdLssn5I9tGQOJnH753vFFFM4WvxhPxZHqyArxIGTlNG0nN4issiXKw9ETMgslgDoVDl1uVh6nULTKko4ISiEnUp4q35GYVw12SzEnJwy5SL02MAhdfppqZEKZ4T1+hlTucY3d5htV4NwvYKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(6486002)(2616005)(8936002)(66556008)(16526019)(31686004)(2906002)(110136005)(478600001)(66946007)(8676002)(66476007)(6666004)(83380400001)(31696002)(5660300002)(36756003)(7416002)(52116002)(38100700002)(86362001)(921005)(186003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWFjL0tIZnZibk1GNXNnOEQ5R3Y0bkY0KzJkeFdIbDdkamdDZFpidyt2L0lr?=
 =?utf-8?B?eitzVlhlaEdSakp6SWdsN1NzYUhocW8vN2JDU1RLK0JaTU1wbENxaTJYQkQy?=
 =?utf-8?B?dkNoaGwxMmpCRzIwL0RoVVZ4dHZDbGQ1c09iajFGc1JtVHd4MXFSaDllZHAz?=
 =?utf-8?B?cFpxZjc2d3ZOVjN0VW9mYUt5SFZNUVZxSXVsUU8wU0FaRGhTbkIvN2ptL1c1?=
 =?utf-8?B?Mmo4cjJVcVVOQmx5RklSblBFUDRtVDY5RXRrOTYyejQ0RU8zdXpoSnpjeWRK?=
 =?utf-8?B?cGNFSFJZS21uV2hTZFhzYUN0ZHFWRE9sTzBOcCtPYWFYUDhqdlFuUG5VQ3NT?=
 =?utf-8?B?MUdmSHpubEcrK014WTYrS2RUcmlLdUR5MUVkRW5Fc2RlT3d2djBYZ1dmTTRw?=
 =?utf-8?B?czFoQU90ckpEQjF6YkRJOUpjbDcxYjE1TTV3UFZzWXpiRVBFU29QNTlTMDBQ?=
 =?utf-8?B?QVFFazlvbzZQNjFmcU1JUGNWZ0I4WldkcDcyZDBzcGdLVlY4dXZmd2YzRXIx?=
 =?utf-8?B?cXlEbTJyeDJjOVlnK3Rva2xhYUFWSkhYOFREd1lWVFBJZjRvNVVQZllTZ0JL?=
 =?utf-8?B?NWZiUGZyMHNhQU9JRG9YNEt6L2REbzIxTlFINDdVQWdYZUhIOVdTNWhWRTI1?=
 =?utf-8?B?NzJZaXJxV2VGOXExcnQ0a2ZhbnhlTGtjTE81bElvVUtVMDM2QTZIMHBRNmZU?=
 =?utf-8?B?eFZJS1ZlTURyUG13RlFQMjVIMkdlQmZOWGlHem11TE1HbEczakRuOHB3QzBF?=
 =?utf-8?B?MHA3TVNXci9CTjdLQmoxWStaeFRjYWRXTUphTlg4OThWZmtkRUVCSlpTYzZP?=
 =?utf-8?B?a0N0anlDRGpDQXdCRFJuOXhqelpyZVhuOE5sWlZCQ2t3eU5IVWFXL0xTclBm?=
 =?utf-8?B?c21OQ0JjaTJvYnd3UmRKKzVuZmdoSEtwazAzQTE0d05EWjE3MEpoQThEN2lL?=
 =?utf-8?B?d0JVTjRBZHNOOVZ3TkJla083cytIb1ZQUHB6bXRTRkd5dmd0c3Q0aEhCSUNR?=
 =?utf-8?B?bEZIMUZhM0lvTWdzV0FkWnJLN2VKbjRFWEt1UlBnbVFRYWViTWdKVk9PU1hu?=
 =?utf-8?B?S2hmbkk1Y2dmeW1Uclo5VTRVc0k1ZkRlU1ZXSFdza2V2WExTTkFXNWZHQ3F6?=
 =?utf-8?B?TWhGMlQ3bkdOYlNRYlB6ZC83UXpiZ3JlcDRTTHMyc2d6MkRYUXBTK0UyeG1v?=
 =?utf-8?B?S1U1a0hkdjVVYUhvQytmSDhmUjBLTDJNQ0JKYkRXR0ptQ3VhbWlrbGs5UWZW?=
 =?utf-8?B?RDQzNUZNSDB5VXB3U0dCWWFVUnd2TGQ4UGlPT3YyNXl6T1lmVFNSQ3pQaHFB?=
 =?utf-8?B?dzFzNDdiVHpSK09uVDF6QWQ4M0hpcFB2ZmlQRFFWOVpuRzVWYlRVU2tId3VL?=
 =?utf-8?B?WG4xSkRrYlArRzVvUWwyTS9IYVJWYmlIWllEZEszZy9XRStHOXErdjBGT0xQ?=
 =?utf-8?B?UzUwN3diQVJQRmJtK2xZaTFNZ0NjUTFJQ3ltM2RQdEUzMGlmMk9PM29oOWc3?=
 =?utf-8?B?UHdta0xjM0ZHT2VidkEyN3I5UkZ1VWpPNXlBeTNnRW5wakttUzY1ekZGVWxQ?=
 =?utf-8?B?T3B5a0ptK0VjRk1jc1RTZEZlUXdUVWFjQTB0VXIwMXlvbTBuY3VzV3I4eWpB?=
 =?utf-8?B?bHByUkhkRCs3aGJBUGZRWTVMRHBwbytTTDFpb2RCelZmZHVrSllVaGdNNUFk?=
 =?utf-8?B?amNMVkF6ZUR5cnhuS0FYNjNDcGpkcHFFSUtLUFY0ZWtVZmIxeWhYbkNiNXNO?=
 =?utf-8?B?TzAvUTVEMVRETkhuQWJUZU1sQkxhaUdCNjZFSU04MCt4YytNNG9QY0ZSQm5F?=
 =?utf-8?B?YWQxcTBmUHVsSXVrWllMNzY5N1ZuWC81ekNXL0hxZFExRXg4UUNNZGRkWWxj?=
 =?utf-8?Q?2cZAxZZCl+uFp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ae867c-150d-47cf-ceeb-08d900c9a668
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 11:20:33.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51kcxp732LwamsuH57SFigPXxKyYiAm2fAalxVgXuj0FFVlyp7zyiJMDBG/K2oAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 16.04.21 um 11:37 schrieb Peter Enderborg:
> This adds a total used dma-buf memory. Details
> can be found in debugfs, however it is not for everyone
> and not always available.

Well you are kind of missing the intention here.

I mean knowing this is certainly useful in some case, but you need to 
describe which cases that are.

Christian.

>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>   drivers/dma-buf/dma-buf.c | 12 ++++++++++++
>   fs/proc/meminfo.c         |  2 ++
>   include/linux/dma-buf.h   |  1 +
>   3 files changed, 15 insertions(+)
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
> index 6fa761c9cc78..3c1a82b51a6f 100644
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
> @@ -145,6 +146,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>   	show_val_kb(m, "CmaFree:        ",
>   		    global_zone_page_state(NR_FREE_CMA_PAGES));
>   #endif
> +	show_val_kb(m, "DmaBufTotal:    ", dma_buf_get_size());
>   
>   	hugetlb_report_meminfo(m);
>   
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083C13B0505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhFVMqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:46:06 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:32773
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231790AbhFVMqG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:46:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLKABmqQiBMgxqezF5I6LQTL7SpiNILESPCSpDjpXfjkyeutKL8T9/L6djjTBrGLjQDGoK1KQS4dMohLetkypG6kobcYYK6WWonrfG0F6WiKpNFfVydvrv2IBcXhoTm5hxnfJtUWrpUc0Hnk+MJEPGaaIebB9W3VQgF3lweDpr2snwjo4bpuVo3f0HGDe/2d4LLVtCZPrevLqZCLA6AM26ghGCbmNLcO8tW1CMblFJftySo3ARtcO9rOcgwWBuqgqF78aykvx75V0XaN9fRonEbXlMVwYSrxt5Pfi6FOVQFHX7Qg9UsIIDAaPZ+d7SmPoeoR0Z9i9mFPqtWeDiaY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otAmT5Tl2cPWMAifC3uksFpNLOH/LrTmU0inABmZT/4=;
 b=Vkyq8UU7C5YKH9ufqprgAIhtFIsHJWgNfwBNXN/0zYMfCfLRpuQ7ONWepKtRooa8fJCMt6ve0dJgQD+7uq9JglCTZv8cpWfvHc5r8jocq97EuCm9xM8QwyVBjB57DVAdY6f42H4RNrvDjtEVnKD/Sm990cUXrmi+SHiSzpCbmNd+7DRUjzk04GYoSk2CW0B6Y8TszhKVvFh+mj4d47GERtlhp4vSXNiVm+9mjxtA+g1NyKh3iRoc++2qInwqTXuX8OLXLqsuZ5DI8Kd+OxVpAP3xu3qO74eH3YXLKfyDPjKm+Ds9mCm2CH6iGVf3PJsDl2foPz4E5IvMQ84/wBUY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otAmT5Tl2cPWMAifC3uksFpNLOH/LrTmU0inABmZT/4=;
 b=VeGzCFTcy4qWABdsDePXNDl6COZ0Y/GLeHVlwxjytWPd4B2uwXw7FIFn0frkKc1rq6JXIMmNAEtzY593DaA4uezG0tOIQo5Dc4D3YNrLJX80kJy10Z9KFlvDZ4RHqt52Qby3Oxt9vJ+ZCy7B8CHYazB1jyjdJ3hAvS0Z98ORFIQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 12:43:46 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4242.024; Tue, 22 Jun 2021
 12:43:46 +0000
Subject: Re: [PATCH] ovl: fix mmap denywrite
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org
References: <YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d73a5789-d233-940a-dc19-558b890f9b21@amd.com>
Date:   Tue, 22 Jun 2021 14:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4]
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4] (2a02:908:1252:fb60:9dfd:8ca7:7f8d:67e4) by FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 12:43:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472f2baa-0d71-4d93-7b23-08d9357b6014
X-MS-TrafficTypeDiagnostic: BL0PR12MB4867:
X-Microsoft-Antispam-PRVS: <BL0PR12MB48675D1C42970A8CD833A7DF83099@BL0PR12MB4867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNZRfajmg8XOVlBBWE53P5GBy87afhrdwAauAUigm3qYg4iojrbF9uTvZAK9jQZQDavkQ/t7mHKYii/3TRdQrgQeOneZXv244SdfxbdiYjUsOMgS6aj1wh5dJfhn3VewTqNPQVtvL5FejssQzerLzPY9NtgVplKIHRmylenwUrI/8RoQl3JmJiMp4thf17jvZRrg1jIP+Zfk1RYmyQmsvOL7nt29qjzZ/jrRUrVub7E966/Hd/JpY0BtvAAuLAHJfOMiNqOKjVwDYLJLAx4bJCXTr01kD6lu2z5AYFJG/wGPNy/U30ts5MMXwRdP2IDQ1Iw85OB72R0xjKoQSaWgw56FHpm4VJYnSSI/Vf8GL+xFlIPjHVONzjwyqGDOkDgmIpAZkzSm1kLWrWc05ExER4muZxyFGd4hrpzwwdEcf0oHLIyONDXHFnC0W4nnepRuWXY2p54BUlzHNz71MkG8ojN1CDzhHu+mXL6F7taBWc5eUfD1JZfow9fQPSmfw6yeMUrWOOjZq58BYUq75O8CGK8z2GSJ6bqQ/h4hpt5vUShPzcztkEzxDChfziM3fkXWEqSvMYm8n0YytXHdtVwuiDqV7wW9yXXzYCCBMglJhENZO4/siyXJAzgaEtiIbTRm8n6e2OW3MGEiljVIhls7y/A9eHlnwXd3ch7ExM0No999FeTm7DgW2PQlc/YxQrli
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(66476007)(66556008)(66946007)(31686004)(2906002)(5660300002)(86362001)(31696002)(6486002)(4326008)(16526019)(2616005)(316002)(6666004)(186003)(83380400001)(478600001)(8676002)(8936002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHI2SlNBTjh5RnpESXlmSzA2T09RblA0SnFUc3dab3d5ZVdrSXhnUThQTmY5?=
 =?utf-8?B?Y1dnZGdZWjdHWUwvVzVEV0pLemVSdTFkd1NNRkdoWVhmdWRveTIvMGpJYWNp?=
 =?utf-8?B?VkJXdVF4THFpOUJuQWJrZy9PTEw1TnRPUEVBYlZGbmYzWFlNcEdWUEJjYUlu?=
 =?utf-8?B?TTROTk9sc0R5S1AyRmxwemVOUXlOb0VDY1RZVTZrdzBGd3FUY0w1YjVCWHJj?=
 =?utf-8?B?NkFyK3BpY2FBODJYWk9ROTFoWS90MlVwK3g0ZlVxb0dqSE1RRllGcFl6ak1z?=
 =?utf-8?B?SFJ1b0k2OGxNMlEzZTNvQTdvTnRBSE9lNTNlTzZpaFBSK3VnSUJtWm1LV1U3?=
 =?utf-8?B?eEdCeFUvNnk5QkVDNjNoUWhXMjZ3QmYyYjNSMjMwTFN0eHdOcklUOTEvUzln?=
 =?utf-8?B?bzhhelFqSTVzYWpyaStFZzUvaFg1MVJLT0VlbnU1dUZOWkJYL2NJWDdrYnNu?=
 =?utf-8?B?Y2NvT0ZIbkxjOXp1TklWbkk2OVgvQlkxQU1BZXJOb3dzVEhDK21zR3JUWkxY?=
 =?utf-8?B?RlBYb3BkWGpnUGJKR04wcnVBZ1Q3WmJ0bGpYT3ZXL1IxZzZRZk9zTkxwb3FI?=
 =?utf-8?B?ejZWaFdPdWxMOVNLTGJPVUNXbkRxcDRZTDFrbnZKdnVrR2ZqYmVxV0crOStv?=
 =?utf-8?B?S1pTM1Axc1hIVDIrNG5LS0VpZ3lNeHdIcStmbGozS0hBL2JPTVczdDM1SVZl?=
 =?utf-8?B?SGlJRUdmeUkzbUJSakFiMEpOT1l4cEhrd013VU0wZUZRd2VDWUk5WThjS2Za?=
 =?utf-8?B?SStaV2VBMk5NVGRKaFNtVUx1TTR3eVVaNVhmSGxhU3NVb1dhcnJGd0VmWVF1?=
 =?utf-8?B?N0VCd3pKYnNJZWpSTmxHL2djK25pNzdaU21NdjB0M2tqcE91UXFlSTdXaStU?=
 =?utf-8?B?YjBYU3hVMi83d1Fua2ZRamR5WWpTK3MrK1VoMlJIZi9UOUxqVVA3d0ZiY1dH?=
 =?utf-8?B?QXdXVUNrMCtyc2dPSHE0SmJncld1UkZOTk1DMnlTaFVYVDJQOWw5c1lkWVgr?=
 =?utf-8?B?SHBva2g4cEtVSXlyMnFlNklQMlE0NkhCYVBPNGFYbVlkMHBzbW9jRkJmSlR2?=
 =?utf-8?B?RVdCZTNvUTM1SWdRNmNTd0taWkRIczdTK1RtOTVJZ1VNNWVVMWNwMElmY2c2?=
 =?utf-8?B?N01nREppMTEvSkNKd1o1NzhTQkc2Ym9qNVh0RnFadE9RMWFWZTRCZXNPelNp?=
 =?utf-8?B?ano3MSswdHRxRXIzK0ZJYldKSWhuMWZqWGRtR2U2R2svSE12U08waWdvT3Iy?=
 =?utf-8?B?OWRQOGkrR1RUQ0g5Z0xsdmFoOTI1NG9MaHg5ZXhPK3pZV1NHcWRqdUt6SkRD?=
 =?utf-8?B?YjV3dDNJOUFjY0RNcWZ0K2ZQQmtreWhlTWk2ME9SUEtKNHR3NHNDM0p6TFBV?=
 =?utf-8?B?U3VNSFVrUW1FSTJIcmhqK3FkUFhObDdweW5xL2EwNnltRExFYjVkUlVzRVdW?=
 =?utf-8?B?S2duVzFwN29QSm1ub0Z2VEZ5NU8rWmM1aW9CRENkWUhJRGdGdXNIN1VrNzFO?=
 =?utf-8?B?YVNDam4zMlBOeW1zMmxhR2l3ekZqVzZBZ1BxMk5YSEdmS3RSNW9taU02TlZm?=
 =?utf-8?B?UDd4cURKeFZIRUtjVW9iak82WnJXMzc4TFRBNWtXc2RPTFlnNHpvemI4dDc5?=
 =?utf-8?B?WnoyQVNwRi95dHAxV0NJSDRKdUpwVkxHbVdTS2NvZ2VteDVNb1hkYTFJL0VI?=
 =?utf-8?B?ejIvbmNIaU94c3Q4TGpzbE9MVFNjL2daQkxFMXJsMTRITzJHdnpKbHpyT3RN?=
 =?utf-8?B?Nmk3WTR2RGZYZi9NUnZOVFFnZXdiZFNNaU9oclkvNUVuSzlzMUFjVm9xQ1V1?=
 =?utf-8?B?VldueDlTUVB6bGR2Qzc2ek9BeldWYmxEUXd2eE1WdXdoVFNQbWNjVTh5WFY5?=
 =?utf-8?Q?xfVj/+oAPzuP/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472f2baa-0d71-4d93-7b23-08d9357b6014
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 12:43:46.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9BNhhZ7Q0XSTM/GGPvweeUzPMREh1AvYQTo4vWWIkbIdnrTD3dMDHOnV8uSpGVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 22.06.21 um 14:30 schrieb Miklos Szeredi:
> Overlayfs did not honor positive i_writecount on realfile for VM_DENYWRITE
> mappings.  Similarly negative i_mmap_writable counts were ignored for
> VM_SHARED mappings.
>
> Fix by making vma_set_file() switch the temporary counts obtained and
> released by mmap_region().

Mhm, I don't fully understand the background but that looks like 
something specific to overlayfs to me.

So why are you changing the common helper?

Thanks,
Christian.

>
> Reported-by: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/overlayfs/file.c |    4 +++-
>   include/linux/mm.h  |    1 +
>   mm/mmap.c           |    2 +-
>   mm/util.c           |   38 +++++++++++++++++++++++++++++++++++++-
>   4 files changed, 42 insertions(+), 3 deletions(-)
>
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -430,7 +430,9 @@ static int ovl_mmap(struct file *file, s
>   	if (WARN_ON(file != vma->vm_file))
>   		return -EIO;
>   
> -	vma_set_file(vma, realfile);
> +	ret = vma_set_file_checkwrite(vma, realfile);
> +	if (ret)
> +		return ret;
>   
>   	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>   	ret = call_mmap(vma->vm_file, vma);
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2751,6 +2751,7 @@ static inline void vma_set_page_prot(str
>   #endif
>   
>   void vma_set_file(struct vm_area_struct *vma, struct file *file);
> +int vma_set_file_checkwrite(struct vm_area_struct *vma, struct file *file);
>   
>   #ifdef CONFIG_NUMA_BALANCING
>   unsigned long change_prot_numa(struct vm_area_struct *vma,
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1809,6 +1809,7 @@ unsigned long mmap_region(struct file *f
>   		 */
>   		vma->vm_file = get_file(file);
>   		error = call_mmap(file, vma);
> +		file = vma->vm_file;


>   		if (error)
>   			goto unmap_and_free_vma;
>   
> @@ -1870,7 +1871,6 @@ unsigned long mmap_region(struct file *f
>   		if (vm_flags & VM_DENYWRITE)
>   			allow_write_access(file);
>   	}
> -	file = vma->vm_file;
>   out:
>   	perf_event_mmap(vma);
>   
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -314,12 +314,48 @@ int vma_is_stack_for_current(struct vm_a
>   /*
>    * Change backing file, only valid to use during initial VMA setup.
>    */
> -void vma_set_file(struct vm_area_struct *vma, struct file *file)
> +int vma_set_file_checkwrite(struct vm_area_struct *vma, struct file *file)
>   {
> +	vm_flags_t vm_flags = vma->vm_flags;
> +	int err = 0;
> +
>   	/* Changing an anonymous vma with this is illegal */
>   	get_file(file);
> +
> +	/* Get temporary denial counts on replacement */
> +	if (vm_flags & VM_DENYWRITE) {
> +		err = deny_write_access(file);
> +		if (err)
> +			goto out_put;
> +	}
> +	if (vm_flags & VM_SHARED) {
> +		err = mapping_map_writable(file->f_mapping);
> +		if (err)
> +			goto out_allow;
> +	}
> +
>   	swap(vma->vm_file, file);
> +
> +	/* Undo temporary denial counts on replaced */
> +	if (vm_flags & VM_SHARED)
> +		mapping_unmap_writable(file->f_mapping);
> +out_allow:
> +	if (vm_flags & VM_DENYWRITE)
> +		allow_write_access(file);
> +out_put:
>   	fput(file);
> +	return err;
> +}
> +EXPORT_SYMBOL(vma_set_file_checkwrite);
> +
> +/*
> + * Change backing file, only valid to use during initial VMA setup.
> + */
> +void vma_set_file(struct vm_area_struct *vma, struct file *file)
> +{
> +	int err = vma_set_file_checkwrite(vma, file);
> +
> +	WARN_ON_ONCE(err);
>   }
>   EXPORT_SYMBOL(vma_set_file);
>   
>
>


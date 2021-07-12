Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE83C5B5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbhGLLVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 07:21:06 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:15082
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236421AbhGLLSd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUFpu8GMqsDnjJQLam3M5DUeHilVdTdeT5E68oOyOooHhOhyTMlH93sgXig3zjFA7HSohdxiLfUaAiPW4vlrsbmUm8NNaSgX5AYwBChYat1t5S7HKcDE/a8xGVm1u40HcNZPI9tjo8+THFB4Xluou2GjqgiVZAuWpfVwLzw0jXXjco9jXYbDXi3/IEil3ehwoZ8TlsqpKmMmz/PcwjwqgTdkWw9Rh8BDowi2XrnYTniaurmikVWvrgkOekiAbL+BMmPfx1k95m5gH2wQBMplS6UWUu5HMwOKD+e3YBhn1ieKSCO7jlwJ+xzaVxnL0vYghvne50izImaCy/pxwzuB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLJ7WURooKycp3/+ZYeDtmfcgHpT4xAzaAQLjFivtm8=;
 b=MfujZf58ulyfffp7xsGvEUzPF3CNUmxQhaGak34Xl27gm18AlOlg+26/bwmxgFjJXGL+RBeXyXIu62xut8AFBwtLnZpYyDXN/cojpJyJaXBCcjGDftAoMFdwwgV3plfWNQ30bmNBHPBpyefOkVnhvQxLVd2MO4ahbbqwVzJUgzu1kz6YTJlitpsRgINzhL9LVgPWHRTVJX0NrsgWkySyLSO2TBSifqlAP6G62ZVD7Ywd4nZBwJ+d/R2SCgX0VSevArNH4zD8+Ov63iV/e0UGZlY1vtpFyGqOjKZWN2DPSamMuDkNpuPNEzxF3Wahif/vZs7HF6orAtLFT27rjWeXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLJ7WURooKycp3/+ZYeDtmfcgHpT4xAzaAQLjFivtm8=;
 b=qCRseXHyIFCWy1BLrBsI9sGpvqofuyyACOQMTxH6kPeh2XVsf82HXg+BWuQAVfgZA/BHT4UehR+uXA7I0e+euZ6JpSDXvtvNSP5cl2UzW1kzsamXwTrSxXJKgZwtO9u0aiPMvv6WRqQohzXgpGQWLf1w3AlA0lNvj04lrPsxe5I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Mon, 12 Jul
 2021 11:15:43 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 11:15:43 +0000
Subject: Re: [PATCH] ovl: fix mmap denywrite
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>
References: <YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com>
 <d73a5789-d233-940a-dc19-558b890f9b21@amd.com>
 <CAJfpegvTa9wnvCBP-vHumnDQ6f3XWb5vD6Fnpjbrj1V5N8QRig@mail.gmail.com>
 <8d9ac67c-8e97-3f53-95b8-548a8bec6358@amd.com>
 <YOhTrVWYi1aFY3o0@miu.piliscsaba.redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <973a75b0-b3ba-9b5c-28a9-7854ec6d6db1@amd.com>
Date:   Mon, 12 Jul 2021 13:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YOhTrVWYi1aFY3o0@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e521:a414:2ae6:6045] (2a02:908:1252:fb60:e521:a414:2ae6:6045) by FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.11 via Frontend Transport; Mon, 12 Jul 2021 11:15:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a17601-2bfb-40d9-c130-08d94526634a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4551:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4551B3318BAB30A23492103B83159@MN2PR12MB4551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aenouY0Yk+/21+fyHCRowScc0ZM6orj85O9+feSCIerjDtNAEcj/L5iC6ydXDEyJyHJ/ie96K12bJJVrGaUX4CDHWbNYy/gErWK1Oo3C0TnsVKOYufHC8MI35vQ4hY3Q7NTcahbisAbEXFIXNUpzLsvm5f1PU9dAvR0ePWeZrDJgc12ngIhZmgigge3Rjmth6RKu+lEnWv0W5KuUdCS58veBC+oPhcwFbAqQxqXx6eGfqsNGj0vXQiHohEIfcM6xuH7L+IfBiXh39wr6IfYnF4561geAlLIkrgOcYOr8ofnsjXavpS6Oa+zRunx+z65GS1bUORcwTub10mHd1nL57491/eEtMU6JSfkIuGVmG5A38mnjQOc647/ZJ2Cowzzcgd1shIba8gRT5zzH3i6ORCvP+9lnl7QXzBH6NP+fksuu+uBEFv6q0hb0xFi5S80tHQKPyQJVWem5Bg/PIW4NY6VjtFe7kyk7eFGll4JkFuyWz5d3FAqxxKJMhUssPunLWD/dkm57hJBI9n2WxvpYAil0v1Nf3PFJfzZsO6EtGftpIP0Hh4QNzlZLUuDheJJhmgPq1h3mSzCdVCADewcKreSbbNgc1rKEmqMxQJ7q/zfF8f04MXAjHcgIn7gfWxR+74qNetUbcXRzpKDVSzwerGyUJtmof5Uso6MPuwmd//Kg6oS+S/FfM5wkgCazQvPabsjVrldgEBhoJpYE7wkjdaL+McO3QyPqG9/IeLHwburwtY5tKgDc0dKZ1HKuSBBv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(83380400001)(316002)(38100700002)(6916009)(6486002)(2616005)(66946007)(31686004)(66476007)(66556008)(4326008)(6666004)(2906002)(54906003)(86362001)(5660300002)(66574015)(186003)(31696002)(478600001)(36756003)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVgrTHpVODFEVW9ud0MxMWhsNy9rTVp5MWxPeUlPbDUyV2xRNUoxSEJVU0pX?=
 =?utf-8?B?YStVMERUSVh0Ym85UGZWWnlBdTFZbG5BdWRsMW9VMDVXMnd1ZVZSODVKZDhh?=
 =?utf-8?B?TjY5a2FBbmlpcHkzSDY3dHZzanpmRGFRUUVhVmdhd0pHVGRUdVBKTzNiZ2Er?=
 =?utf-8?B?dTEwSXQzZ1ZiMEFqeUZGVkNCVW83U2JHVkNybGFBL3VsTmd3WGlTMW00akpZ?=
 =?utf-8?B?V2NiKzhDelh2eWZLQjlqVVowWi9nY25nU0J2d2xTS2pqWHQyaS94TnZpSlFs?=
 =?utf-8?B?K1JWS3VLT2V6MUhCang1ekZOeXp3VEJoeTJueDVSKy9WUlJoTDltbSt5Ykl2?=
 =?utf-8?B?ZFhHNVNFeXdvaGQyRHltU0lrR0dEUEFnYUZHbEYrcm5Ld3NrZ3pEQUxpWHBF?=
 =?utf-8?B?cWlZNWMycGFtb0FzRitWQkFUQTZTM1BZMTEyemZkWStxVHg5N0ZEaG9mb2Nx?=
 =?utf-8?B?UnN1c1p5TnBYQW1FRzBTWmVqRGpac3dJNzVUNmIrNEd0TzJRZVpJbTIzRjNW?=
 =?utf-8?B?R3EwRFR1YzN0UGFiTVdFNGkwR0VwNXozWlErNHo1b3FqK1Z6aWNTL09zelRY?=
 =?utf-8?B?cll6ZVIwTkN4UGFGcjRWMnJnS0NrRVZ4YlNFdndUMkJrWXZrajBwNjU5OGVo?=
 =?utf-8?B?VnhxbGwxOGtuWStaRWdIaDhyY013S2ZpWXBqS1JWMFpYSVdFVE9rRXdLWEND?=
 =?utf-8?B?amVqK0d5U1l2MEgrak1XcWRrWThxeHAwemRmM3NLaGUzaDFXQnU2V3JSWnFK?=
 =?utf-8?B?Z2hiQzdTYUthQmR2aXlNTE1BV1NqYTdvTlRUaUh4VG9XR21haXU4bzN4QVpp?=
 =?utf-8?B?OGtQQ3RYS1M1VHc3c21HMEdQN1FWbTYwMTc3R2dwUmpzTk5KMGtrRTQxZ1Bx?=
 =?utf-8?B?elFwQUk3bFREWHdpL0V2SFV0VTlQckMvVVUvekxSYzQxWW40MU96UmFnY3lH?=
 =?utf-8?B?OUdZQlZwN3c0R2wwNGpSQzJubHRkNGpYR3R1eHEyR3U4OW4vZGhXU0tEQ1Ru?=
 =?utf-8?B?dyt4ZURPNDBId2hreWowYjB6QzRmWXBxNHRsVHAyc2FRS2JhU1IwTWw0Q2tr?=
 =?utf-8?B?aGlqaUFrME81bXQ2Y2ZFUDBpNVVSNCs5T3E5TWtXYlg1dVFjWlJxNXJMOEtO?=
 =?utf-8?B?ZW1TamdlQnZZMU44bE5sdkYrQ2V4dVIrdVdiZGVzbHRtUjUwenU2SE12Z2xh?=
 =?utf-8?B?S2tvb3hMQitCMitsZWovWlEzMExOZ016OHlKTEZndWNXSE1vMnZWY2E3bHJv?=
 =?utf-8?B?YmV1ZDdhN0NXaGhpMG9CZXhPYlVDK2gyK290NDQycUwvaVZGR0pTUEJ2RzJF?=
 =?utf-8?B?TW5DM2JnWFRkUklCRDdQNTEyUXh5SjBiQVRhQlcwV0hJdzR6TXZUak1VRDNv?=
 =?utf-8?B?dmFmWldmcExoWVZ4NnRYeVZhZlpralZ1UDZyZlVVaFFOak13WTZrWGFIU3ZQ?=
 =?utf-8?B?cUpqM1BjV0lYdlZ2dW5meVVrcEdMYUJjL1A3MjI3czBhd2VJb29vNkhzTDli?=
 =?utf-8?B?MGFHcVJQOWJhN3BBL3dqcUxnYXJtYmhReXFZZndyVlh1OUZWNU1VKzlLZlFp?=
 =?utf-8?B?ZG5mWXYwK2ZvOVkySk5vYkdYcnluTUlRNVR2SjJlR3N1T2pqOUZvR2Q4Qk5I?=
 =?utf-8?B?UG5aMlR0MVJENFNDWjVtdDhsejNISDhGeVhvTmx3MXlVVjFDay9rSld5NWRh?=
 =?utf-8?B?MzdWb0dhQ1JTUWtuWktTM2hLQmpvWlFXL0kyQ3F5SHNKSUY3SWhhRkxRNjdZ?=
 =?utf-8?B?ajNSaEp1YkNqU2hRWk1NNExBdEhWaGpORDYyWVhZUHpFc2ZQcDF5dFFoMENz?=
 =?utf-8?B?dHE2REh6V21nZHpCVG5NaGg3QnZHQ2grejNRV3lyeDBadGM2NnRHeTB3UXF0?=
 =?utf-8?Q?kEok8/wxsFDKQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a17601-2bfb-40d9-c130-08d94526634a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 11:15:42.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOD/IPo1nYJDqeBXZMIhOIBrMiX+waE+KH8BaYsDocrjFv5db6Kc11NKUpscpXiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 09.07.21 um 15:48 schrieb Miklos Szeredi:
> On Wed, Jun 23, 2021 at 01:41:02PM +0200, Christian König wrote:
>>
>> Am 22.06.21 um 17:10 schrieb Miklos Szeredi:
>>> On Tue, 22 Jun 2021 at 14:43, Christian König <christian.koenig@amd.com> wrote:
>>>> Am 22.06.21 um 14:30 schrieb Miklos Szeredi:
>>>>> Overlayfs did not honor positive i_writecount on realfile for VM_DENYWRITE
>>>>> mappings.  Similarly negative i_mmap_writable counts were ignored for
>>>>> VM_SHARED mappings.
>>>>>
>>>>> Fix by making vma_set_file() switch the temporary counts obtained and
>>>>> released by mmap_region().
>>>> Mhm, I don't fully understand the background but that looks like
>>>> something specific to overlayfs to me.
>>>>
>>>> So why are you changing the common helper?
>>> Need to hold the temporary counts until the final ones are obtained in
>>> vma_link(), which is out of overlayfs' scope.
>> Ah! So basically we need to move the denial counts which mmap_region() added
>> to the original file to the new one as well. That's indeed a rather good
>> point.
>>
>> Can you rather change the vma_set_file() function to return the error and
>> add a __must_check?
>>
>> I can take care fixing the users in DMA-buf and DRM subsystem.
> Okay, but changing to __must_check has to be the last step to avoid compile
> errors.  This v2 is with __must_check commented out.

Good point. Please ping me whenever that is upstream and I will take 
care of fixing all the callers in the DRM subsystem and DMA-buf

>
> Thanks,
> Miklos
> ---
>
> From: Miklos Szeredi <mszeredi@redhat.com>
> Subject: [PATCH v2] ovl: fix mmap denywrite
>
> Overlayfs did not honor positive i_writecount on realfile for VM_DENYWRITE
> mappings.  Similarly negative i_mmap_writable counts were ignored for
> VM_SHARED mappings.
>
> Fix by making vma_set_file() switch the temporary counts obtained and
> released by mmap_region().
>
> Reported-by: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   fs/overlayfs/file.c |    4 +++-
>   include/linux/mm.h  |    2 +-
>   mm/mmap.c           |    2 +-
>   mm/util.c           |   27 ++++++++++++++++++++++++++-
>   4 files changed, 31 insertions(+), 4 deletions(-)
>
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -430,7 +430,9 @@ static int ovl_mmap(struct file *file, s
>   	if (WARN_ON(file != vma->vm_file))
>   		return -EIO;
>   
> -	vma_set_file(vma, realfile);
> +	ret = vma_set_file(vma, realfile);
> +	if (ret)
> +		return ret;
>   
>   	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>   	ret = call_mmap(vma->vm_file, vma);
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2776,7 +2776,7 @@ static inline void vma_set_page_prot(str
>   }
>   #endif
>   
> -void vma_set_file(struct vm_area_struct *vma, struct file *file);
> +int /* __must_check */ vma_set_file(struct vm_area_struct *vma, struct file *file);
>   
>   #ifdef CONFIG_NUMA_BALANCING
>   unsigned long change_prot_numa(struct vm_area_struct *vma,
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1807,6 +1807,7 @@ unsigned long mmap_region(struct file *f
>   		 */
>   		vma->vm_file = get_file(file);
>   		error = call_mmap(file, vma);
> +		file = vma->vm_file;
>   		if (error)
>   			goto unmap_and_free_vma;
>   
> @@ -1868,7 +1869,6 @@ unsigned long mmap_region(struct file *f
>   		if (vm_flags & VM_DENYWRITE)
>   			allow_write_access(file);
>   	}
> -	file = vma->vm_file;
>   out:
>   	perf_event_mmap(vma);
>   
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -314,12 +314,37 @@ int vma_is_stack_for_current(struct vm_a
>   /*
>    * Change backing file, only valid to use during initial VMA setup.
>    */
> -void vma_set_file(struct vm_area_struct *vma, struct file *file)
> +int vma_set_file(struct vm_area_struct *vma, struct file *file)
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
>   }
>   EXPORT_SYMBOL(vma_set_file);
>   


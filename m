Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277A75982E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 16:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjGSOZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 10:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGSOZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:25:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBB926BF;
        Wed, 19 Jul 2023 07:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI6sOzi+gtQNdbN9C9GztwX037PSU2qhwGRIMd/ULjCFzbtl6G3vaGFx69Ru1dK2qxwYfscPcjX7u6az40Zuas8P2TIXBwRmBXSngKlE0q82RopW/vblRncDIe+/Y3xZzl3DeaCACmPW7kHidfJPFdQD2ycLHD5f4gesGlnSTv6YFpEINOYs2eIHDe/1ya/cDnqio0tJ1GlKWq5c4/eHIPGOeIQsgK4Y0HHwuIrY0itAVrwwYE/woVCFvByXlBC1cC4EWZoHxjmCvfclmNGCm4rQybJjlhQLheVJbjyFLNkaVATnLk39tlnQgrl8RZl6V+7u2T9yyBc7AVHnY0h86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiTW8fCjX/4q7DDyRSjV238D/QVT/rwNhUJ0BOiO6vE=;
 b=HY35YnX8iZAJYNOVeC4Aj1Dc5oo6aDFeOITJq49ORmFY01L2PElKQiKuNFCv9H4HgW+RZGDp/drbb6vJlR2897IW7zfIp0nlEGw3s99nhuKO6GCJiWKCTUO2MhY4TbhfyooCG8ErX+6Ml8jAo2b/rUaUtZikyj1WV5kqedoaneUwjonYfhz5WkfXrppi8MRsZs4PkFimUwJcJItmBcDkoEaCRdlR/5mcIF3CVY6P/AeVP8j0sgPCBGwhBYrqiaXJl2uK8018am8YHGZrZC49bIMUz0iQQdP6fAmsufU2xb/Ji+nWhSFdFAJUJlVoVvxFEgxceRJzcPbgaYxIWOifAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiTW8fCjX/4q7DDyRSjV238D/QVT/rwNhUJ0BOiO6vE=;
 b=RI8ipCUVyRQQgyvzjHqzmMZkkYuMs7UfgrnLQD6lfqMKKp0P96fgQmoQ2/5h+kXQ2V7x0P+4j8G+zET0DUt+GNYsHIw8qBKxAJBaoRHl993HvswGMTQANS3/yvXtKNe2U1Ad+EpZCFy/oTVJckWowftSS4mmIpNfjItNWbqDhkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 14:24:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 14:24:37 +0000
Message-ID: <8b547ba9-45bb-312c-293f-356b5bea01c7@amd.com>
Date:   Wed, 19 Jul 2023 10:24:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] drm/amdkfd: use vma_is_initial_stack() and
 vma_is_initial_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-3-wangkefeng.wang@huawei.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230719075127.47736-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 4144b76c-73e1-4298-7dc1-08db8863e16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8/s9c9gpEtTTD5iV+55HocmMU3c/dddZ6HOlFsLY90f1RZ9fx51+cmnVGOCC86xxqNjZQ44pIYb6Lo44qjrOvcvdzlrEivSSuEHRxa9+PiSW8VbVDApzVWbFUoSVydb8lYP7aVA+dQQqgo9uc4Y7DlftYJGNhcSoD5wfS4NsmT1FY0pqJljqBrYBwiIYpI4l1BrRiiiWncDgznn7ZyivLTaCAl/dLVQh+yncEXt/LMheF5R1QxG7VfK0pu4SjebkeOJ9/D6F1Axx2cemAmMR1ePcQNSCj8UfcXsldTfLiXyp6TCZ6xjWEHr++7I5Hn2KzZGVlAjdeE3djJxxYjy1WoV+73ZVmbBbtR9Mg/hxtMa56CbXpMjaiwLkKHiqrYGh5cDTl8K+kMQqdwIyg12fIJCNQaz3A2HkydnQXSpGEVGIhSf8nSKe78ZQzNSDoqmiuOI9BLcA4K0yQvtkv5anrX94LxnDO7LZMLk8I2T9SMBi65M6FwTa0hKOaLc5bACjtzpaqYqpdhDsR/6G/bA/60wDzYXGmtgfMS9SJotkkEqesY28vnro90o2jKpCoIQuog4PM/CWXRVrMu2lZr0TRmbnKM9aQIyClJ+lXjmM5eX3G5LBcIG5eRPEkJCm8ZvhjrPwtfARg9Iz6pWacGrTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(66946007)(54906003)(6486002)(110136005)(41300700001)(478600001)(8676002)(8936002)(5660300002)(6666004)(66476007)(66556008)(6512007)(4326008)(2616005)(316002)(66574015)(83380400001)(186003)(26005)(6506007)(38100700002)(31696002)(86362001)(36756003)(7416002)(44832011)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3FZVW1jVFRjVW1UcmdKcTQyTW83bGpLSHJiTVRMK3dVWFNxbHJQVDdCZHFO?=
 =?utf-8?B?bktiYkpVYy9Vd0RGSzNNc2YrcmFSaXg1QzNkdFp2NnhlN3Vyc0pPS056cFJD?=
 =?utf-8?B?c2RpQy9TKzdSWlFCZDkzQ3llNGVFbGFybUpGZElsQmp1RVZmR1BTUitsL1pO?=
 =?utf-8?B?YytPRHlET3dYZHRxNVJXMG03NDc4ZVJGWHY3UHREMTRWNDBkQXMvTWlQYTlQ?=
 =?utf-8?B?YmFLUVFwRkdDM1JvL1RyLzNuMS9uK3dYRDNWYlA3MWVSeUV3RjF4eVluL3Fk?=
 =?utf-8?B?b0RNZGFrdVVIajdaL2IxSHNXVW5OMnNkSC9iaWhoRFBJL0kyRHU2TGUxM21P?=
 =?utf-8?B?SDBlRXVFSjJYczdXSldZdHhKZmx2NjRRaUdOYkxmQzZxK29ZSmQvOTlxWDZV?=
 =?utf-8?B?WWUyNjJtL3BjNHZuRVR2aVkrSEdON1czTjZQOVBFY3MwN3VJa08yTzVvcUlB?=
 =?utf-8?B?ZGdITk9kZzRJSm5OWE5zUlJqMW1tekRsZGh6aEdhU1E2cG5aVkZIcTc2TXVE?=
 =?utf-8?B?enV5TXFiQ0pGRmhqb1JGc2gyWEV5NXdCaXRxM0czMVA2ci9NZGV4bFpRUGhY?=
 =?utf-8?B?SVArbmpGWVBxQ0FRTzB0NUpScncwSG8zKzZETzJKaXc0cWsrK3ZhL0VrNk5C?=
 =?utf-8?B?ckpJdzl1cHR2dHovMlVYMVhZRGZWY1d4QVh4eFFxeHlqaHBOa2czWmMra3Zh?=
 =?utf-8?B?T1k3MklUeVQySDZVY1B0bUZyN0VhVEZPcWo1ZExqRXROQWdBRm9KSnFhK0Vi?=
 =?utf-8?B?OW1oWTEzemsxVlJheVcwcHZKRDNIMDdjWGNqc1dGdzBiTGppY1hzeG5RZjQx?=
 =?utf-8?B?ZmVid0ZEanoyWndsYTlldWcxbU9hTVEzalZKZEFRRTBBOEFqUGpjeklEK1ps?=
 =?utf-8?B?U2pkYUkrbCtvOFh4TGVOckVZUGtjTEd0ak9rL29wTXBRN2h3SktFRU1LM2lL?=
 =?utf-8?B?WjZ6UFFmR2IzSUF1NGdTK09FVGV0N3llcSt2UEhuRjF0MVF4cGxJajZRWjVG?=
 =?utf-8?B?RnhUTXJLVnRLaGw5ck15NnlBRmFPanBPc0Fhbmo0UWFaNDdrenV2WVNSZEk4?=
 =?utf-8?B?akhWRWh0cW82SkI3UG9LMXVaV0RQYVJrdS82dEFWWGR2eTdJekxuSnBjczJC?=
 =?utf-8?B?V1czTjEyU1ZCMGtwUEFUc09PaTVsb0tyQXFtZkx3QXltZFBFOWYrRDZSQkFo?=
 =?utf-8?B?SEV6UHIzRi9CNk1Ga0JoaUs2QlBTMGF5TW9pRk9HclNDN280RlN0UWRLWGVC?=
 =?utf-8?B?VDNFelBYN0o4cTZJL0IwLzZyaTlyOTJicDVRRkxGeFZadGF4MDdzYm9oYXR4?=
 =?utf-8?B?VEhJVEFRa3BJMEZwRXJMZUJWZTgybEpKS0g5SVVmZERNY2Rzemk0VVc1QzY5?=
 =?utf-8?B?a3BXYTJXaFA4S0Q5Qm1VSHZEdE5xVy9CWGZqSmVsQWFEcmFmWndHL25jelF3?=
 =?utf-8?B?S2hMSS9PbDN4SjZvTEUzRXh1UXpxUjJZQy9QNGp1bmEyRHc5QXVrV204WHB1?=
 =?utf-8?B?dzZ1Z0pwU0RTYjVZTkUwcFIrRldDcS9nY00rb1ZxVHFtRjlhU0J6Ly9sT25u?=
 =?utf-8?B?ZVVSSHcwb3Z1RHNHcmRRZlIzeThXZ05JNmJFcThLQXoyaWs5QkV0TmRwdS8z?=
 =?utf-8?B?dGdQQThPYXpGTUxEcUo3TGRBSU5LYlY3blNVN3lKZUdLV0lhb2hvOG1NcVlV?=
 =?utf-8?B?R2swM1lPUTRVVXhUTzUyRXMyQy9meE9qYTdWbjh2YklFVHBTTjJGL1NIcEda?=
 =?utf-8?B?UWE0azJXV1haMnFoanBKREdNUk9BRHZtT0VqeGFxRzFnbTcyd0hFNytsSVM4?=
 =?utf-8?B?aFQ3YXJIc1UrSWNreTJmTG9YTUlrU1ZIRHh5RzJwTlhteHBWSjdRYkJ4ajBq?=
 =?utf-8?B?dXlkdXlIUTg1eTJGSmVmZU5HK0xURzZLbGxURkZ6N1U3VnRKcGNTK3p6NElU?=
 =?utf-8?B?SlVwRmJNL3YxdEtrZHI4RnZsRm9GS3dyVkhoUjV1Njh6ZDZIeDMzMkRUZkNW?=
 =?utf-8?B?N2F1S1hmcFJGRTgxSldoMm9wNlEzWVNGWnFzcXR5RjhUVncwbFpLM0t2WTR6?=
 =?utf-8?B?cmluY1BvWnJJVEViclJrRE95QktIY2RoYzNUdVlMQkJTUTR5emphak41Mmxh?=
 =?utf-8?Q?xXPXac7sO71yvO0K2k7wf4JtO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4144b76c-73e1-4298-7dc1-08db8863e16c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:24:36.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMONTdcPTmTQCYzKTQBdirY9O5MRcWMIMiyW9FCa5ox8nCg8KayC4GgW0qNCTbAxEhI+7UehTqpytCcLBLk5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 2023-07-19 um 03:51 schrieb Kefeng Wang:
> Use the helpers to simplify code.
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5ff1a5a89d96..0b7bfbd0cb66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2621,10 +2621,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>   		return -EFAULT;
>   	}
>   
> -	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
> -			  vma->vm_end >= vma->vm_mm->start_brk) ||
> -			 (vma->vm_start <= vma->vm_mm->start_stack &&
> -			  vma->vm_end >= vma->vm_mm->start_stack);
> +	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
>   
>   	start_limit = max(vma->vm_start >> PAGE_SHIFT,
>   		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));

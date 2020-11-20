Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4B2BA6FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 11:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKTKEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 05:04:38 -0500
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:58849
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKTKEh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:04:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ/9QJ2RHqSOEXRGsGqSrdwiSyQps6OJo5QtqenwwxvpnZ5c6bKKxKGQ9pnbs3SYzz9xSIQBn4DnmMmzFMHckWua3mJf39NlonQ514wDQT0fh6uRitoHos9SnP2bVwX3QH5vZGbBjXmvqqP2v7QLavufL/m3ZmBRWkcZf7s+98xjVQO4QhK05ZBYBY0sdn0xLxZ+zxG9ONm56RKW/wLSVJjQt1YtNQLSDpHq5CtE/nIhy/8eqqbWKEcEK0WqJKNZGEOsbMnONbwTXrMJ1wfdC41nawVyuzWdE5iTBOjPqfGLW6gk2tU13XbO1i8RYpJnmX595Ar8pNHmRVZgmhtCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye5/l4TVoMn3SpqnHeLUQDNzjKXvddV+CZVjWO2uiL8=;
 b=eQ4m5hmZuYrMatnnHFQSzuPCoRN2Ho9y5lO/ZpGA8UUhvMfbYN7T0raHPkZaGpDbeSzJJf4V32JD8FxImgAZd1exJA01qiZTFy2X4cFrGkwK3IcvM/AhX8dlbtfdvyx+WmZaLKI+OXfSgLec+ZEUUjxGSwd+qLMJOamU9HIqR/4lstxu4SGJkv6iz6uIkY1GZhwnIrmmNlSNGKCMTrQsed9aDZGwxh1kWX6wN6ilz1ODiMiDhjTnJxQ2aC7FOxjuLxAQ8w6IMq0MACMieb6YVJE3CMvUhZdGdPc4eqds1VPHm/DCX3X+P19bEo/xxB3nEsRclWhID9on7iqQ/dA3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye5/l4TVoMn3SpqnHeLUQDNzjKXvddV+CZVjWO2uiL8=;
 b=4iCvcxomNpWsV0L36sczExOFa6K9SCGAg3PdA588mql2bxrhwFna0msz5Qj+5xS+uatikageLlh58xvSx5F4n5zOk+bb5F4KyQDIrZdwL6Ahwp2FtC6s/WgWOXTpZuq4yigWAljvuUBWjOFXNt3STnIAUZ8XI6mkm7WGD4H90fM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 10:04:33 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 10:04:33 +0000
Subject: Re: [PATCH] drm/ttm: don't set page->mapping
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Huang Rui <ray.huang@amd.com>
References: <20201120095445.1195585-1-daniel.vetter@ffwll.ch>
 <20201120095445.1195585-5-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <26a62dfb-02e4-1707-c833-a3c8d5cbe828@amd.com>
Date:   Fri, 20 Nov 2020 11:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201120095445.1195585-5-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:208:1::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:208:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Fri, 20 Nov 2020 10:04:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24c86c8d-4f55-4b2b-86fd-08d88d3badb8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110A5A5BC5374DBDD4ABC4983FF0@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pvIGuJo9sNkFkSH7NHc1PR8hJ41iU6X3BHzu5c1hiBIBAJsQLtOL6xXi0nhNlCGR+4e2SPsl+2XYOUgDq7wNA2wAs4h7WlhGENDDYVQT79yFFmjjGHGyiZJO9pWliLHdl2UjPXE9evnTxUrpTFcf1VMqutDGf9U5Ght+LvJUs82Oa0+agilxaLlInBDaAQGwFNOVTB/9KbCVahltbfS6dr7W4WUKGwPhpSzZXuZ3VfwipKj9aCvE09TXg9SdWz9ewrYQLFrR113jKl15hC7HyEH/GRpUBIT+NnX13Q8lBxpk4Ch3TQL5KCJLVmPIa3vYNcrNcmGXnw/8Dm1tIRFX0MgGmEonzvl2zpvIlK2/tYZ1817V91+rIpHr1e/L+Gm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(8676002)(8936002)(478600001)(5660300002)(6486002)(66946007)(66476007)(66556008)(83380400001)(86362001)(6666004)(2906002)(52116002)(4326008)(2616005)(7416002)(316002)(31696002)(186003)(16526019)(31686004)(36756003)(54906003)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cERiRzJ0UTAwdWlSZ3VZRStZbVhwWVRyb2FvL1BuUURjSWl4RU1nSUtyNjEy?=
 =?utf-8?B?QTB3dkY0SElnSnpGZ2Fva3FQSHl2U3Y0dHA3cEdOdHJVY1pvRFZ4dnZuRGU5?=
 =?utf-8?B?VHhmQUhqVURaaE5DMHdOVnJMK0MwQ2RMRG5OLzRyK1RrOURiL0JKK1JLY3hs?=
 =?utf-8?B?dWNQVGxkY2k1Y1RVdUc1bVQwSW5ZcFAwdVY2RUZpajFNUzk3YVIvbEJiWFYy?=
 =?utf-8?B?ZUNjSFBtRlpVUnRrakNXeVJGM3VYR2t5WXU0bXdFS3I3aEFsTXc1Mnc4aEFX?=
 =?utf-8?B?L1lUL0V1WW9sMFJ2WFJOd0JScVFEZFllSzB0QWhHcHFRWW1LSDFlQ20xd1I4?=
 =?utf-8?B?a0FtbFBidGY3YWVXeWtVYWh0UERpdlgrNUtld244bEc4UXBIcWFqNSs2Z0lI?=
 =?utf-8?B?K0ttMUg2aTE2dmlHNUxsNVFuV01uamhSZm9zd0JvYXRRd2loZmh1OTdvTUlm?=
 =?utf-8?B?djU5SDJiZytFTFhuQS9SOWs3OWhTM0NEa1pKcWwxVi90amErUXJNQkZWNm9p?=
 =?utf-8?B?MzVCdzBhcWRmZVZTZlNkaHBWM1EyRlZXY2syRWs0K1hSVU1Ma2JReXdLcFFC?=
 =?utf-8?B?dEorcVEzYTNBaFpJUlZkTmlrdEFkNVNzSVZZeWI0TlRKME1yVEl3cnMyaXlV?=
 =?utf-8?B?NHNTaEppL3lxQURIQzVpbENYaWM5OWlTeUFKVzNXUE1rV2N5N3Q1UmRpMUtH?=
 =?utf-8?B?Uk56cGl1MlprT2xQZ1pZWklSdkdlSmJLVERURmRJU0IvaTQ5WDFRM0pJN0w5?=
 =?utf-8?B?a0pmbktVdzJCNWI0S21LR2hHbVgwVFlXYVIyalk2emw1UmJETUhXNmU1WGlw?=
 =?utf-8?B?NU54cFprMDRxT0RvZTh1c0hsVTNXRnFoYm53YTJEd2tRbTFWRjd4U1ZsRG90?=
 =?utf-8?B?V2xsM2N1NDJBL2FWcUgrckczMkJlQmQ2K0NNV215WUIxdFhNc3JMMGM2Yi9J?=
 =?utf-8?B?QWNkRE5HRGtjUFJVSDlsdjFXdkVweFBvZHlQcHNWa0NyeGpIWTU5eTIzZ3E1?=
 =?utf-8?B?Z2hhZmQ4NEVEakFOWTJaT05qSWxBa3pwUWpya2FQV3ozcGMwKzhmd2ZoYlRS?=
 =?utf-8?B?YStDdVpVVHJBMUN4SXNxejdwaThnaEl2ZzB3THhva2N6QjZBekgwdjBXSzY0?=
 =?utf-8?B?UkYycVc0cVpadksweWk5RWJ1NkJLcU1rcEEycTc2OXBCdzdpSmlsZCtudjFW?=
 =?utf-8?B?bGFqRGY2WCtIbUdJcWE2ckZmcmVPUkZrUGhZeW5PV1dBN0xFTGpWajFVYkll?=
 =?utf-8?B?TGwzT0ozL2lGL3pKb3pYeWg4WGFXMURCR295aXpLS1ZKcHZkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c86c8d-4f55-4b2b-86fd-08d88d3badb8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:04:33.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAN4sP/5dWv7QIjLqB5L7Vgxdp0HsEqZGHhYKnAsUTBQR5IviscF6z2AqcmUrT2V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 20.11.20 um 10:54 schrieb Daniel Vetter:
> Random observation while trying to review Christian's patch series to
> stop looking at struct page for dma-buf imports.
>
> This was originally added in
>
> commit 58aa6622d32af7d2c08d45085f44c54554a16ed7
> Author: Thomas Hellstrom <thellstrom@vmware.com>
> Date:   Fri Jan 3 11:47:23 2014 +0100
>
>      drm/ttm: Correctly set page mapping and -index members
>
>      Needed for some vm operations; most notably unmap_mapping_range() with
>      even_cows = 0.
>
>      Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>      Reviewed-by: Brian Paul <brianp@vmware.com>
>
> but we do not have a single caller of unmap_mapping_range with
> even_cows == 0. And all the gem drivers don't do this, so another
> small thing we could standardize between drm and ttm drivers.
>
> Plus I don't really see a need for unamp_mapping_range where we don't
> want to indiscriminately shoot down all ptes.
>
> Cc: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: Brian Paul <brianp@vmware.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>

This is still a NAK as long as we can't come up with a better way to 
track TTMs page allocations.

Additional to that page_mapping() is used quite extensively in the mm 
code and I'm not sure if that isn't needed for other stuff as well.

Regards,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_tt.c | 12 ------------
>   1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index da9eeffe0c6d..5b2eb6d58bb7 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -284,17 +284,6 @@ int ttm_tt_swapout(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
>   	return ret;
>   }
>   
> -static void ttm_tt_add_mapping(struct ttm_bo_device *bdev, struct ttm_tt *ttm)
> -{
> -	pgoff_t i;
> -
> -	if (ttm->page_flags & TTM_PAGE_FLAG_SG)
> -		return;
> -
> -	for (i = 0; i < ttm->num_pages; ++i)
> -		ttm->pages[i]->mapping = bdev->dev_mapping;
> -}
> -
>   int ttm_tt_populate(struct ttm_bo_device *bdev,
>   		    struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
>   {
> @@ -313,7 +302,6 @@ int ttm_tt_populate(struct ttm_bo_device *bdev,
>   	if (ret)
>   		return ret;
>   
> -	ttm_tt_add_mapping(bdev, ttm);
>   	ttm->page_flags |= TTM_PAGE_FLAG_PRIV_POPULATED;
>   	if (unlikely(ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
>   		ret = ttm_tt_swapin(ttm);


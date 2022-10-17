Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6C96017FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJQTsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJQTsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:48:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F566864
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 12:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5QG0e9KxKTddTM+poLucIrig2xgcqLT2giq3EsLy8XF4O6x6KGJ6/sZdhvDdkbALO2z90xDWLslKG1LxPUai2QPgNXzY5fkok/ViKsxqQMRiSrqStA0G5MppifTY1ykOU6TjIVtL7p6f05ct8VbVYPxdxwULKyAQQmvhwEVCCfB4LKPiueihYjjCx0xDAL0wMZToT/0t9hip+71aa3n1taWs+lYTWIz3PZYU3siuySr4Cbu8irA68pfjsj3PxVgfcP+fvTFmDxBqD1GGn+qg0LZpmYHB02gY2gxRAtPLbJnZ/Cxq22jeegkkmS7ExkTbg6mCbitotqU3WajroUS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYmzwbPwnML17hRGvCGnD8hK6vlDX2PWPdTY7hsADf0=;
 b=g+FDYMhD65zJLF/+eWC18VE2tWlig2AE5kbyZOwc5Pe9AS0M0RIQro90K7o5pQ1YjMDNv4zjwag+Wov0ULqnNLLRukF0VzBKpyerf8ktgFiY9qmIC5PnMGqW+ORaRgmiK7NGvTAG7sy3E+ZzHoykLywyP+Hqb/8rlfFCKJVJ6MZDL+Fbva/j55sxUIXWkBFAz09snfoiN/Ay0EI7znQzqtNQmYQOOa2KMZ/6YLYgbuTHUzyMmwhHuxevpdFXCUuiDv/vLBF9QQx4Yu+ae85YVzVmBmN2/hRn24ob/ObkK/kXN19lgNc6qTq0sJpp2wgFNwuujQjpxaX9XCIS1W+r1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYmzwbPwnML17hRGvCGnD8hK6vlDX2PWPdTY7hsADf0=;
 b=I3oXeCnG/MSo6UZlUvNdFirSGpo1NAVSBW6RDe/rHQZNJUT6PcG5vYS42UFtYuP215tqLYLxt7QyqEWUfZhBr5yL3VCIxZ5IoSMXN9drJTQkQMKtjaoP6SZzv5ZtGxczf3S2Pw7AVK9Ch+uMmAsyAmxuJUIy5UCY5uUnkUthu1loFqTzjQbOBz/vZxchcXbU2TeX/w0/9/wBP4s+YsrsY63oVIZfPRctAQ1TB48vKws0Qr51h9//14pSievX8VxrQSzGjAJtybdLJkOCeZ8+RC9Dondr3Y3xo0c8WghQ3+VftLw1FjX7warBig2IOYs4BtIjMFBHfjQq8nYoikLIUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 19:48:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 19:48:02 +0000
Date:   Mon, 17 Oct 2022 16:48:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 23/25] mm/memremap_pages: Initialize all ZONE_DEVICE
 pages to start at refcount 0
Message-ID: <Y02xceDlo8hfrPm/@nvidia.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
 <166579195218.2236710.8731183545033177929.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166579195218.2236710.8731183545033177929.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MN2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:208:23e::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: a534686c-18fb-4884-7364-08dab0788086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JifwTa5kyzJBq9q/G9/SlezWfq94M0ka+RTVZ3NERMQITleqxJTR/uXarw6V7QccclBYWT9EsKsKBzcsCm5MAdRnhf+jDkLw35TFwNZfrMpdbtFzvZsKG3bXNs7npbqmMd9cpsOdIcey6utrv2D6mcyotgZLxsa10iW+DXUXxtJDP3apxBfJiIJY95nSPGSreuuOpyvTHNYJJL9tJ7hIIPnL/R4TWnqw2xOVGPLgssewPa8c72wVsasmjXm7ZCPJw5p5i/G/lBMM0AVWVtaKNo1ZrWMwhQBi/QYOCrgu82jqVxx+EZP5GoX3Mm93W1oSmUwFiBOcqSXOzxAhhJiMfIQUeOrnqUFBIy91pAgaCS3Es+hLPWMA+YuKApl2vQJxdgXJtIdClhJLYMdet/mRn6F/cGD6gh5ukfDPp5x84CvtMvhJY4vK4/xultzYzH86+pg6tbDkhZov3q4bnzt2fWb28G5EDLFS47DGw9HBk3gsyvHfXXv15gyns+/dOvYYbcbpgM/gBXMwgu8dvLIU3JVmlrxepX+Su1YGya7OXCS7w635K/iGABDMrveDpiLGOBoyJcv1PE6c/5nNsW//TfqQTFJaB4cCs2eSs+7KwwrW8tWKs5PdEpzvau3l3FLCGTgkUFc5P72UGmDcfW2FA03D6fVwKqrlHBJNCgZC+2+sgrYA7BLkM4sfEb9JwYMtVBBP1l3ge49qhCG2LBUfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(36756003)(86362001)(41300700001)(6512007)(4326008)(26005)(6506007)(8676002)(6916009)(5660300002)(7416002)(66556008)(478600001)(6486002)(66946007)(66476007)(8936002)(316002)(54906003)(38100700002)(186003)(83380400001)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpTIRD/t/POb0mzKOzLyjiWvI1P7LaZMo0aLV+XQgQFoPXD/qnus+ybYgfTA?=
 =?us-ascii?Q?Fs5Lnh6Q95aTIyr6XNPWHswrb7y8m9gSYJuAO/338nhsKoU0g2qiZTwN2iOS?=
 =?us-ascii?Q?PC5b5zQCGAv+DEoXs72yD2PsdBxSOFILQ2yMjDkSBbvUIjDG+RtItzpB37Oj?=
 =?us-ascii?Q?WcV1EH07EGM/m1eik4aR6HVbH/JroYt8iUgUUO2EQYkmCncigMV7UE/exycO?=
 =?us-ascii?Q?E5zLuzTkkp2CM+aBJugMF8sk0m/HGf/1t7JP6W92ek+MHeg74gbzAIFmHMD7?=
 =?us-ascii?Q?/JLfak9gTpdPM2YEdxVtfX6WwwpLBi0qAJEGtOztcH592P7/trZV09UkEI9i?=
 =?us-ascii?Q?jz+J7C3KhQi15S43tqs4HX27JmYUuGj7xtfZni0thqcErfmRetnX5h926qCS?=
 =?us-ascii?Q?UwlKgXjmJfJ+zN1jbrVNHw0fFcH5laJxg633vq2PClac91vF9CH24xHvDJ2o?=
 =?us-ascii?Q?er6JRNsbEdVNlAXNTxT2h2PacZboiAXlIkoBLowUxg86kN8RNuym2TNjOvqh?=
 =?us-ascii?Q?S6LxMUhv4bDwqRMi6xNMc2bp6bB7Ez+Psr6C2qUFX5YuWCE9ovzMjrFdU2ab?=
 =?us-ascii?Q?h3vi6X9GY6seWg+FSkBrZ5Z2DzhE1pWY5w5Xvlxxr0s0SiQF00shg05rWF5J?=
 =?us-ascii?Q?2AQrGBxIJ0yWYdN981mhP8XBHHuAd/sk3Xg27CNQZKgV86TVEx9BCI4v9/C9?=
 =?us-ascii?Q?18i9/B1UKZHZJB+sUTpnjbJBA3HMiKZDD9m9Zysrz88DWC0P7gU9kI97yEsH?=
 =?us-ascii?Q?u7G8KXt3s8HNkED5MIAljIxYt8bOMSUN4tRQKt8i7bObzB+c6RYnZP6qGjcO?=
 =?us-ascii?Q?ZICALIt81urg3Epj3bLSunSsAH9nJuunlqEEUmr8Dug7SzxgIgCgVZCYD4Fy?=
 =?us-ascii?Q?ec4JTCY2BZpcJFULnBedegBWZpi6SWIHY3+j+TOvByCiHXcBk8wHS5aslx9Y?=
 =?us-ascii?Q?8QcidS+xhLG2HBnsK7q/fRKB+hzapy8bkSEcOWQtO2LAEog7kC5bKBczuzdR?=
 =?us-ascii?Q?qbwbAyNvRiaPBqi03uqxKKzLoK9SQTEB2TK0HrXwJaCqNU9GwNhNXTKf1Yg4?=
 =?us-ascii?Q?cWIBgkv5D/w21trxbIbFp5zmz3ndAAUruUiS0dGwhqzjWHsxQFdIKfRTH4+O?=
 =?us-ascii?Q?0JuRPaqucO9GOdV47EcmWYeS8qSRWDB3fmAkLnkVs+QE14BIhHN+lIeUNkzm?=
 =?us-ascii?Q?bVhKnvyxZleE1Brl3Yjh+BXaDkKzp4PkRFxkudbaXUWKH123HPJkH+UNTXgt?=
 =?us-ascii?Q?NkpZ/HVIQEgzFFyqqaOwIk48Yy0YlPWzLe16RBSBR+daroSY7SHxltxZSVMB?=
 =?us-ascii?Q?i1E0kl5JUza5kfkg/XABS0pjcSZgkpG3CPQ3PVbyGI4uxHpMSKWaU73WXBXZ?=
 =?us-ascii?Q?9gyZ6NUB6LEmir1n/SptoWCSMQgspzQOLjXvur7J6Z/yOaUuNIqbpk7TxdFr?=
 =?us-ascii?Q?RUXA/UXJEmTzI6ut6LYYEr0hGqFKBEEYVXaNcQ/6N6LRP8uoDtMNdwS6kG0Q?=
 =?us-ascii?Q?GOvmJnZvuFBdDM13x04+tCygmgpq/49QoQWVQXb0LeYpa+fKGoFelHXmLMK+?=
 =?us-ascii?Q?xc3dH7L8qou2Slo/tKY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a534686c-18fb-4884-7364-08dab0788086
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 19:48:02.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/VsUm6cnAaLX76W1eVgN84ocVetDSvnTcVMoI0pduiCQgZlDJouV0aT3juw30W/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:59:12PM -0700, Dan Williams wrote:
> diff --git a/mm/memremap.c b/mm/memremap.c
> index c46e700f5245..368ff41c560b 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -469,8 +469,10 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
>  
>  void free_zone_device_page(struct page *page)
>  {
> -	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
> -		return;
> +	struct dev_pagemap *pgmap = page->pgmap;
> +
> +	/* wake filesystem 'break dax layouts' waiters */
> +	wake_up_var(page);

Shouldn't this be in the DAX page_free() op?

> +/*
> + * A symmetric helper to undo the page references acquired by
> + * pgmap_request_folios(), but the caller can also just arrange
> + * folio_put() on all the folios it acquired previously for the same
> + * effect.
> + */
> +void pgmap_release_folios(struct folio *folio, int nr_folios)
>  {
>  	struct folio *iter;
>  	int i;
>  
> -	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(iter), i++) {
> -		if (!put_devmap_managed_page(&iter->page))
> -			folio_put(iter);
> -		if (!folio_ref_count(iter))
> -			put_dev_pagemap(pgmap);
> -	}
> +	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(folio), i++)
> +		folio_put(iter);
>  }

Oh, so now this half makes more sense as an API, but It seems like it
is not named right, if folio-multiput is useful shouldn't it be a
folio_put_many() or something?

Jason

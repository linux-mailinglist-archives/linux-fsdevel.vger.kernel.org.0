Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7426F35AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjEASMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEASMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 14:12:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB810CC
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 11:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF+VA9YcH4cyREfRr63x6A4LJzihyN6Q0Q9iXrhF5FwsZvpahkfBcxrQ9Nn+uPSWiW/AUyPvjmriF1dR27vpg2z0+YGz0PfpJ2OZ+M7Y46Rfkncj1X+1/Dgh8pNOMlw8dHdJslnwowwlHpPYw2oDufmhJpPipYZ3KGbuYgH9i4HKrylNU8GYOrF3UgMtqgywu6Lw/yoGWv7gtyICmEaJuwXBtYZsioi5OkzVnYgTfpTFCyknP8RS+Kwpiu95lmu46e/cYu63NP0RgXo4DaHNiZDr/jxRJNoi1F1DCF2Fp8sozDLof5s3KmmBBUcMzlQJU7590YM6lO5UFq57ggvNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aPHmOdHhYCD/g/QxOAbKeDelnsln4x5SMmiINj+T4A=;
 b=UurYzDdiRqfXzJLFTNpcomqXL+pQx7XjoV/iMLWhVPijXM7hv8TaOCd+T8lDmiRt5MSLdYSOimZe/aWKbhW5IZL3cxE8YQ2v/UaMlyXpmGpzqH4mzwIysF031T6/sG6q2eAsJU3VaB8/E0D5K63Bw6B6N5hFyxW9QjelbH9G4cTYMxbpF3BplrSD+j3c3FxKHDsUjyMesrsfjDlMZazGEDGq8tgMng+THQCcKI6vHEzAzFbwmLUrXjhAhpM82mfFB5DTpaVFbzJivvJYnrHFWGrW4Va6Pz24RqzbPFPXSdNOn93DRkktVOAjCYcxAG8NYokXKEVLdAM/WQeZOE1AEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aPHmOdHhYCD/g/QxOAbKeDelnsln4x5SMmiINj+T4A=;
 b=Y9SWEmpvIaOV7Gc+CKKp03IlYrL60Pic45kl5yaal6Gg5xDexaSiiEhocWovZHpSFuBTkgKplPEaYc/EtTxQ2xegR5U6jBT1pBEXq29ZpLLs10lTUCzJO6jxYmaA7Pn5vlNa3eCWm2j88+BcvW/kVFvyQ8qpUNyFWTIda2ht10EJSHPZTzvFz97zjt2JdstS+UneDGiFIGzpS9o8guHWYoVtA0NSLaMSsXcwdbDA47eA/9nqRG5P9RHIPnT9dLxi0LCticRjRFdrUxDw5MNNxmrx0aDpqiDhYPAbxfx5JZjpDWOJIVWF1A0IwDZ0rn8WZnL4u1zlYGatBYAn+GuNyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.29; Mon, 1 May
 2023 18:12:33 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::4514:cdc2:537b:889f]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::4514:cdc2:537b:889f%3]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 18:12:33 +0000
Message-ID: <b8ace783-a102-f6fe-3744-91deb3993184@nvidia.com>
Date:   Mon, 1 May 2023 11:12:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20230428124140.30166-1-jack@suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230428124140.30166-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0183.namprd05.prod.outlook.com
 (2603:10b6:a03:330::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 586433ec-d92f-4102-8422-08db4a6fa24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OL92G3Bkg4QP6DYixCI+Ym52gCDvf9I+JIK9Z1gvqDxmtb/GKf8CDDzNIv0BlopUtECF22cufQqg1kWVzP166N9ATJfE5pURUxMHrYYuQ1ErNXfsqC1H3+5aVr7DeHIGdcNfh0iftR0vugkf2ayeK03gXXgn0EMICtyGDlATGLyf3VyKhctYiqPYkWSczP2bhxKf5/147Q0ajCxUNhEskyFQ64Z0J2WnY5zAcKZLoVDoTVXN3VJuCEILxATURmjAPft29H+V8dktnxRZDLDKBfATJcn5Qb7VZ9gliSGUI++1DsHy/sVTL0JC/5zC2px4I2IIu+fTZxAHRE5WyR4q3jX3Lk+46l5a7jYXM4D9SvnwU5WeKAwZsrvzPxjVxnfwpzNvby4x3MGZqCHEQO1MJ1yoBILEedYgOnN4qDgbrLW0RL2BzwavDaJaO+b+NsdwRg+O3tpy7Ggq20PGF4/wrPmFH9K1eHxwMSyTYOQP0xazon6gyCzoQKrmadWxETdXUYUOhV2wyFNnj7tCqTsD34XAQMOaQ+nekNdKv4NsKBso7ahNRxg3Vde2wzhpffDW+Sa6BwkSFZ/I09KgSCwhr8/PK03m8dQLcB0r17VuZYG+iATi14r9xgswdovIC8facEgD3gLrSCwimrSZ99GRwwHodSLMXLFSoh+MliJRGCZOcJ1djVI+cpJa1kwY4DdvMrhaZkJbwlW+dp9gJf93O8pj2wr29GR5u6DxanSSnK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(2616005)(478600001)(83380400001)(31686004)(186003)(54906003)(4326008)(66476007)(66556008)(66946007)(26005)(53546011)(6486002)(966005)(6506007)(6512007)(66899021)(316002)(8676002)(8936002)(5660300002)(41300700001)(2906002)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDdzME9oSUlDRXB2SzNmYjFpQ1VoallZV1VBajVwSjM4S2ttQVhKS3Z3R3FC?=
 =?utf-8?B?b1RrNTU0bTBlRU1RSU10bCswcm03RFRSblIyWGpXQXVFd2dHWWYvekNBQkQ3?=
 =?utf-8?B?K0IwNVBLOFhhQ0VGVElBM0wrQ0JoaVhxWTBSMkpyU0NtV3V0R2xBZzdnQ293?=
 =?utf-8?B?NFNXUFVJbnNPWW1PT2MvRG0wV0xRdUVZaFFKRUZaWVlTY2U0eUN2KzFZaTBs?=
 =?utf-8?B?R0RSeEswanRUVkhsZWs3WUJvWjErNVZPK29rQWRXNXNYb2ZFNEY0NG5BWEI2?=
 =?utf-8?B?SVpRU0dHSmJmV2E4MFR2WkFQcVZLOGFMVlRGRTh3R1FMUGRxRUxjcnZ1bHE1?=
 =?utf-8?B?R0pjMURzSTlxVWErOUJjOTNFWU9HenhpcTZxajIwcDZqaTFMTFFpb0hjeU1r?=
 =?utf-8?B?R1Q0UmE5U0o3NkpzQ0RrZmpva1BkbDdWMkxSRE5Gcko1NnJQZ3pnNGxxSjk4?=
 =?utf-8?B?UFE3Zkd0VzNlK1loaDk2dnNpWWpjbk1XWUNWUE5zWFR5YjNDdWxnalVhYy93?=
 =?utf-8?B?MzMyK000c3RyYnMwNkxaV0Vnb3lpS0VRaEZ1VEp3ZWhwYlM4Z0g0Mm42N0FH?=
 =?utf-8?B?U2ZLYU9HUjFzT0RNeklEb3FqVm9GQ2xaTlF6YTVnVU9YQkpadkFnSCtudnZy?=
 =?utf-8?B?UlV6dFpZRHZmUGdjZ2RBd0FCcm96Tm41elIzMXRpL1Jqc21qcFlMZlBkMjYy?=
 =?utf-8?B?UVVOdEhwRUhTc25VNkFSRFZOYUhjYzFBRFlxNE1FS2Evdkx5akJFYUZZdlZx?=
 =?utf-8?B?S2Qya0pEYm05cnJ5aWlTQzhqRFpzMzVOODNoTGtsYmpSdVQxYk9qS0x3U3pE?=
 =?utf-8?B?ajlScjdOSXBjVlhvQUp3Y3lKdjhQdm1YNnZJWUdQSWMzNjJsbXZQcDkvMVNu?=
 =?utf-8?B?aVhUUTlSek4zMi9RQjlLL2xUNG1OVkx5L24ydzdUSXVJektqS053SVdNV09j?=
 =?utf-8?B?U0Q0SHNHUVFyZGVoZUlEZUNnYWhUcVVIdVpGdE1hQjJCVHArbXB3N2FSd0pY?=
 =?utf-8?B?SzUySGx3Q21sSCtqV2JDTm8zbFFNVnNwTEZ5K3JyRVNENTgxNjFKTDRkMDVC?=
 =?utf-8?B?YU5McXdoUHllcTlSbkJEbXM0TEN0aDZ5WTZHaHRERVRLN0RmdWhjSlY0OWN3?=
 =?utf-8?B?M0M1dUVrck5KMTdjL3VrMStDSytjRjY0NUlIOWg2dy91dE5BM1dDZW81YU1D?=
 =?utf-8?B?UDFrSnBMZkF1eUt5cGtCNGkyY09KeTVvR20rc0xHRGVXYVNzNmg2ZmVZeHdF?=
 =?utf-8?B?bWxrdjg0ZTZ2M3dzcEVOSlpHUkZIajB5d3VSbmFOdnhQTkZPcEs4SE9Sa2t4?=
 =?utf-8?B?c3IvMHdhWE0xemJwN01uelFIYldJeWpPUUs3a2tVSmtHQlU5blRHWkR2NjBN?=
 =?utf-8?B?TDZzMVowdllXT3lpV0MvYU1tWllwN3AweGRKUENaTjJGdzk1eUFkc2VING5Z?=
 =?utf-8?B?Z3hTNUlVak0yNUM2K3dBa1Jkc0hCZGdZL0drL2J1NXlWWFRXdnF0TEVqeXU3?=
 =?utf-8?B?L0NnR3hPYVlMQ0JoL2NrV0t0UU44VDlWY1ZhM2p5WG03RVJrNDUraHM4Q0hy?=
 =?utf-8?B?Q1p5KzNiNzROL2ZRay9USm1WY3N0NFBqM3I1eFJkYWJSUUd4RUZZdzYwLzJF?=
 =?utf-8?B?NWFIaVdlN2FTSGZ0NmdraHI2cnRmRE9zODNwKzFWMFZQTHhzWGxHc0daQ0Q4?=
 =?utf-8?B?ZS93YTZOSGJoOTRGZ0pHYzhOZDFPb1ZSbE1KRG40ZU1IZWxCaHVuSEw5WGdl?=
 =?utf-8?B?SGlXWnY4WktaNlNtM1hBTDFqUDRQRlJRc2l4SW9WOGIrNVlJVU1yRkdYNnpO?=
 =?utf-8?B?NTdLVGNnMkxscmJSRkFrQlRUY0NYd2V2dFFTd0grdW81b0trLzlzVU5aL1cv?=
 =?utf-8?B?NEhrZWRENWJ6MktFZXYrcStDOFR2cGZEYmMvQUVkVjlWbmhYSkpGb1RNNTVT?=
 =?utf-8?B?bC9vaGhxS3VzQzZVN3U0K1dTVFd0MXpiZ1RjOFIyclBZNVZ6Q3g3dzZqdUM4?=
 =?utf-8?B?RFVLNFI4eHErVHp5VUI5L0F6SzJuNndvTkpZaWRnWVFtRkRQQ1lFN0htVG1x?=
 =?utf-8?B?dGVRaWc5V1pDa1JBRUMrL3VXWUVucWdQeCtqUWRQOXNOU0pUeHRzMmZQMkYz?=
 =?utf-8?Q?PZ3ZI70kJKhFTrI49mnoCF01+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586433ec-d92f-4102-8422-08db4a6fa24c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:12:33.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ovs0MhruFJ3eXAWpr/HjAU4qIIKyBz8pe3T4ChwkVGMx3vIcMrTVaqBuLrfdC/0RStiMEGKDyipDSbnViTW6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/23 05:41, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).
> 
> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  mm/vmscan.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> This was the non-controversial part of my series [1] dealing with pinned pages
> in filesystems. It is already a win as it avoids crashes in the filesystem and
> we can drop workarounds for this in ext4. Can we merge it please?
> 
> [1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bf3eedf0209c..401a379ea99a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  			}
>  		}
>  
> +		/*
> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> +		 * No point in trying to reclaim folio if it is pinned.
> +		 * Furthermore we don't want to reclaim underlying fs metadata
> +		 * if the folio is pinned and thus potentially modified by the
> +		 * pinning process as that may upset the filesystem.
> +		 */
> +		if (folio_maybe_dma_pinned(folio))
> +			goto activate_locked;
> +

This is huge! At long last. In fact, with this in the queue, I'm going to close
out our internal bug report from 2018 that launched this whole maybe-dma-pinned 
odyssey. :)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>  		mapping = folio_mapping(folio);
>  		if (folio_test_dirty(folio)) {
>  			/*



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE637B42A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 04:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELC2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 22:28:32 -0400
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:55462
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229934AbhELC2b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 22:28:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haUsEzEKpt5mLpqh+D8xkiNMm1LYOL1BVRdM7YOqQv3KrTjn0DOQwsp+c9slJ7VG3kkC25RaHF+wn7xfRDDXQrsL6pI3IQxhCme2jKvHSUA/Bk0EEVGxQejg4QHo20PxCC1wP2t9mXa68JHArVPUGgRalrb3173pGWCLVeBF9+TPprRvJ71O9upaaO8IXRkKw1HvEpJmNLN8wjdDrDhNsVkTjfykCehNC79YMHY70Zso/3I/NikdnyZi0FZUMTprQfs4zHGg6JkxMOAXMjn+/2SCT71GWQyRIqgD9Q1T8/0L6UoLGlRoafbN/ov7ty64tBDaeLYqmvcDv0AHKFGG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OzmI8MxDjk/bAHTUFLeoyiJ3yTBuTlJmmUjVNz2PMI=;
 b=AnwIOygJYs/dLwMwso7gDkJEknadzy5jeCcf7Y/wa6doBEZoTkb0zIFCVCMvZSL29V8BMRoRRw0w2lljiH8rjM3Y9Nul6CQA2eKhgnXZF2faOPWS5B/0wR6QdU1uprb7QhWBOXgv53k7YJ/6fhhYh3ZQwrRKBAVHJVKlObl/bm9SIi9TGh0+m82Se/zQaPCukG9f2PdjWvKXXsHdcptTX8S7NijDSV4kQ5BVu7W9p6kzOU5eFm8t2IAUV+V1VnFkWTH/LZc2LfSvcd+S1rxvkpYeFnDKhppDBy3QdM8QXH0pMzStnUwZQPufnOCXjubpm1KEwYEYR7iDfTjNEHxlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OzmI8MxDjk/bAHTUFLeoyiJ3yTBuTlJmmUjVNz2PMI=;
 b=Q1mBDcqDy6JZbDJT9IK0JG1+CQ4eyFM/zEqILyUzPy0YGYPogVOGZaWENG+cbGOn/NFGpxoRYDc0BH6PhMVNqbusrz6tY8pzRYyb0aeRjQg7oXrzUBfxFJfgkb9phzei9h6/qAY6PMpUHSZ68cU5fB0mP9jToEz34+MeV3DyudM=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB8PR03MB5932.eurprd03.prod.outlook.com (2603:10a6:10:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 12 May
 2021 02:27:20 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239%5]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 02:27:20 +0000
Subject: Re: [PATCH v5 3/7] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
Cc:     darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <4c944ccc-7708-5dbd-18c3-9ecb5c3a539f@nextfour.com>
Date:   Wed, 12 May 2021 05:27:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210511030933.3080921-4-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [91.145.109.188]
X-ClientProxiedBy: HE1PR0102CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::26) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR0102CA0049.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Wed, 12 May 2021 02:27:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 804c182b-944d-4028-bbf2-08d914ed77a6
X-MS-TrafficTypeDiagnostic: DB8PR03MB5932:
X-Microsoft-Antispam-PRVS: <DB8PR03MB59329E13B8FB4EC438CEA46D83529@DB8PR03MB5932.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+iHHkv4srWSfzOvETdgtPC/UrhAIZtWQ09vj50OBTOEXfZp7ZTzeJ7vZ5sFFL/brD8rkNr0G7Bi3+jV/9L2mjoItc1nY5Sno5whnp5heLB3g7kEuABSyEUPP06NRi2jkfJ+YvRmHTS/NmLplDw7JraK3sbkSc81e7Z/wjkSb8wZ7kVL9/OsMccRha2R21yxlKHH+IJul3DZiBxR9mPNZueOxfXlXdOID1GrHlyb7ssnXFrztRl55BslsqgCb8HYWMSv9SExbZEivGWA9y3KhsOjM0LDaAqmOhaiOJemQUgHE2buOllJhDQ8uefBthqmZn06zyn9f+y64ZF/R7Ei2zB5J+oa1faT2sTZox0kB9Mds+ggJ+jj/0Vg3u63bSqtEEvhVjULamWZCdyH9aj9Q1vh0QOnhabSB1KWcgKnMKt3xus4xeqI6H3ErjK9nHJaLkvS8jtDBHK2Q6BODfOoaQisVrH1J02/j9s+FRBfIinGJY1+FZbL2DY89dEhcqvngZfJtZBpQSiNPO0uAWdfia7JTrXiaUbwcXBHf2A+Pkp/B2VOzKw6kNqHJO3DXAwyyOWqAmbQZsfl/vA9EaGBRk3BdD9orutLDdqwsRPOfskGMZFmZC9eLTyHHp00Crh3Kevw2w3oaQItscSWvyaJvZygt3NlOg7kL+nQQ+MHy7tcXGsWx5l5L14U9W+U8X8x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(366004)(346002)(136003)(396003)(16576012)(316002)(16526019)(186003)(26005)(66946007)(31686004)(2906002)(956004)(66476007)(6486002)(2616005)(31696002)(8936002)(66556008)(86362001)(38350700002)(38100700002)(7416002)(52116002)(83380400001)(5660300002)(8676002)(478600001)(4326008)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlVzY05oOTQ1eWp1OWtSZkpyNXRGV2xQY1plWkNxN1l3SVJTU1pnUUxHTlpW?=
 =?utf-8?B?UXljK3F1WEZQZFdHNFBYSUdSTzVpRmo0Q0ZLUDdzOGMvZFVnR1J6dTNRaHFN?=
 =?utf-8?B?TThvcHphUEZIUmh1Qm9pcFBqTE4wT1hud21qY3V4R0hXRDhocUJiVlB0R1Aw?=
 =?utf-8?B?WkR6UXBGSndOZGVMWXVpaUlRZUFBNWlmb3UyUjc4Z05nVUYwaHR4NElGYWtm?=
 =?utf-8?B?L0d0dDY1R3pvRHNRTjZiYVp4Y3k5UDRPQTJpMi8yTkpSVVRzYTNQRWtyY2xQ?=
 =?utf-8?B?YXFSby9NNHZ4aWdCSjlURXM4MGdqVFRtajFEUGt0MHpjUE1DbzJOczM3cm1I?=
 =?utf-8?B?b2RjTmh4WC9rTEpJSzhQb0NEVmxEenl2a2NTa3BnRE14eUJnZjRjRzNOeUdH?=
 =?utf-8?B?dlBMMDBNbmJvclQ5WkRHU2RBV0crTnJPeDZVTE15eWdPMXVHSWxncXhpcnhK?=
 =?utf-8?B?MnNHZlNIbUVaRUozMkJiWEhISkJXNWZBUVlpODJzMS9DUXBRZ29KTml2K2hK?=
 =?utf-8?B?b00vd0JWK29KNGhmT3pIZnlsM3BpU2hHQzVJdFFMNk9CMkR1NkVlN0t2L0dW?=
 =?utf-8?B?RGtOY3pibk1pd0pwNStjOXk4NHhpUmtnN003dncxL3QxLy9TQ3JLU291Z3kz?=
 =?utf-8?B?dlVReTE2SlNkSFdQajRXcTFhQzgveWNGN254TG9TaVQ0aWtLT2IwTWw4amxt?=
 =?utf-8?B?bFl3QU9Wd3B3c29GNU1vVW5UcU5oQkZYL3M3UXdxMGE2YmJoMzEyUHV1TW0y?=
 =?utf-8?B?eTRZS0VHaDk0V0dVWmpNTm1RR2NRcWFGcnkvWk50bXo3V21GMklkNGNDUzFN?=
 =?utf-8?B?N3ZMSXhZUkJLMUh1eHlWKzZBM0pjNndPZTIwbUk0cnFpMndRQkdpUHV0bGRM?=
 =?utf-8?B?V2c4NUI5OGJSeDFKL2Z5cVlCVzBKMTZkUjM4ckFKUWxsWTE5dFY5Y0FIZzRH?=
 =?utf-8?B?d3Z6dlNQL1lkd2h0clI2K21SdjcvMUNCR0Q5T2RxMU9jUThuTVJ0NWVBYlE1?=
 =?utf-8?B?UWNVdm5aK3FPc21EWmFQUUptOW5UdkQrMCtYSVU4bzY0NGdEeUZNUW8ybUgz?=
 =?utf-8?B?ZkdEcXNDaUVtU0lzVlNJQ2YxK3VrdVdGc2xpR0U2ZG5pOVdjS0VNRXFiMVhW?=
 =?utf-8?B?b01CRUVGTCt3S3EzaTVib2dVNEd0SzFWZGhIUWE2WXY0MXUxSFNEZXZSRExM?=
 =?utf-8?B?OFM1cFU0SlBzbDR5eWJiQjR3NEJ3VHExbnNFaFZWdFdtcmlib1R1STFNWko3?=
 =?utf-8?B?bzB1NXM3N2VWK2VpWUNyejFKSHgxTWJnWHFJTjMxUWNlM0pJYVByTWRmL216?=
 =?utf-8?B?N3laVTY0TFFOMndzUVc0TzBMb1pySVVrTjlEQkR0ZHhnVWh3MVhUNkJMMnBT?=
 =?utf-8?B?MkFoT3l6Y21MS1Rma0pOZjBWVzh0UGJoZlArRXBRbnpseHhkUW92cTRSc0tP?=
 =?utf-8?B?andMYWlldExpaWphRVQyN0Q2RjEybTF2T1R5Mm1lNnZuNGtjUFNEUGtJWUVI?=
 =?utf-8?B?MXRFb2xXSWxBZEpMOVdQVExxcHcwNFA3YVNQN1FYNlA1WHZOcUtuTElpNlNJ?=
 =?utf-8?B?amdNalhGRkw4d0pTYlpvczhpczV5c1RMcThudi9URU9sYVpkTXJBZFVuVVEx?=
 =?utf-8?B?VnZEbVhwVktmcHhlbGtmZmlWZTVLajc1Y2VGU2NqME44cEdwdXlvb3l0cmt5?=
 =?utf-8?B?YmRURFdSNFFOeVFVTzQrTmFNb1lqSWNaK0Ntc242OTVNYmpwWmVVdFRKbUR4?=
 =?utf-8?Q?zYGkjOAZlLwjBcl9F2g0AKlDi3QAjKoGxtYA87F?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804c182b-944d-4028-bbf2-08d914ed77a6
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 02:27:19.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4QZRqRQ19cqMw2ODSVFn/UVILfmte1mwmxDgSHyWnczjH3NjlBiMDRjeCx9nxkdJX6akVAAmkVtg0Rxvpnmw4V9XeGylyyxHky4+eSP8Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5932
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 11.5.2021 6.09, Shiyang Ruan wrote:
> Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
> data in not aligned area will be not correct.  So, add the srcmap to
> dax_iomap_zero() and replace memset() as dax_copy_edge().
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>   fs/dax.c               | 25 +++++++++++++++----------
>   fs/iomap/buffered-io.c |  2 +-
>   include/linux/dax.h    |  3 ++-
>   3 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index ef0e564e7904..ee9d28a79bfb 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1186,7 +1186,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>   }
>   #endif /* CONFIG_FS_DAX_PMD */
>   
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap)
>   {
>   	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>   	pgoff_t pgoff;
> @@ -1208,19 +1209,23 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>   
>   	if (page_aligned)
>   		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
> -	else
> +	else {
>   		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> -	if (rc < 0) {
> -		dax_read_unlock(id);
> -		return rc;
> -	}
> -
> -	if (!page_aligned) {
> -		memset(kaddr + offset, 0, size);
> +		if (rc < 0)
> +			goto out;
> +		if (iomap->addr != srcmap->addr) {
> +			rc = dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
> +						kaddr);

offset above is offset in page, think dax_iomap_cow_copy() expects 
absolute pos

> +			if (rc < 0)
> +				goto out;
> +		} else
> +			memset(kaddr + offset, 0, size);
>   		dax_flush(iomap->dax_dev, kaddr + offset, size);
>   	}
> +
> +out:
>   	dax_read_unlock(id);
> -	return size;
> +	return rc < 0 ? rc : size;
>   }
>   
>   static loff_t
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f2cd2034a87b..2734955ea67f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -933,7 +933,7 @@ static loff_t iomap_zero_range_actor(struct inode *inode, loff_t pos,
>   		s64 bytes;
>   
>   		if (IS_DAX(inode))
> -			bytes = dax_iomap_zero(pos, length, iomap);
> +			bytes = dax_iomap_zero(pos, length, iomap, srcmap);
>   		else
>   			bytes = iomap_zero(inode, pos, length, iomap, srcmap);
>   		if (bytes < 0)
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..3275e01ed33d 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -237,7 +237,8 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
>   int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
>   int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
>   				      pgoff_t index);
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap);
>   static inline bool dax_mapping(struct address_space *mapping)
>   {
>   	return mapping->host && IS_DAX(mapping->host);


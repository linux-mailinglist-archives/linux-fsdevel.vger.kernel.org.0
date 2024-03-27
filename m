Return-Path: <linux-fsdevel+bounces-15439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB688E75D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386741F318E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829215D5DA;
	Wed, 27 Mar 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZL3uFO7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1463130A41;
	Wed, 27 Mar 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547583; cv=fail; b=rz1C2rfTD+XaDiX98OWrxay9Uz8tVOAfkYUSRxHgbjYui6ZwPiMeVGuhk8tJ0FqQ36pYtyKHLTkplRlOrydvzV0ZyqO2eHoBl4oaUDxvIO9OZNDGfadhWXi0Q0a/6Wh05eKpu1NH8a4cvvViVcjfSxdWxENGrKmXhAdLqZJs+5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547583; c=relaxed/simple;
	bh=yDHhkJIQEiq4h4tGsi/nrNbOjWgdr5PxYFwX0asJwrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WB1cJCQsUVPM+aHQtDBsbccrPLaQloZ/xE4VbSxPFu3ZFw1MYgbmkkG5qThqg+IJDGqJLcsB7+BorNR+m5VTnOIi99MQNaur/Epj9j8NwOearGOKbeqsW+e1p6VclIu28HrGv/xgHJ6qBJu7+e3Nl8lIESfZW1EKtnocD0xLY60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZL3uFO7S; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAks4C1dXGUKoJHl69RY0z/V++IfV4Md1FPdybrOt6N5XVCjbUcxc25r+2sGBYR0Q8fdyV3+NzY0FyEVGP6UDulDXk6P+PnbZn8YKNFF9ZY9ppWI9IjesWGAh5JWQ/L/x3WupT0iNI6EMpT+7L6kHW3N0IUeHBWmP7owDMZ0BgR+l4NQ9tpSrmpVlf92Bs7pEBoCWlb25iZcarNhZ7x3SDvK7obm/WOiMwdJGZSW9s8ZW504O29VwjWRomUonxjzOUFz4nXQDyxYU9287B6ISNcxBaOvsPHP4FvldrNJ/266lIMwXxnZlpCD85GZNcWF6BwQhMtAkiMlmxlcUHy02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ2rQuHOc7DiX3XJ8A5mf+IVhyyY13SQcZzCvdnBfWg=;
 b=BvpeGxyBa0SVnzmF/nT/q1kfTTjh4pj/jj4vaKuR3eFMyZy2F7k23dM/Bq+ofQuMH30PCGUWV9isVRR07buoK4td78pYb7ib1Y8dyi58HYllCvG0Vk+TZm3+3NKQnXikE9fp3J9SUSS7L3/fNti+eKdhQpQ1snkTel5bf6GbGytxPF64vseDuSSA0VOeqQXS6qKotOe86L1vzugHXdBsJzlGZhuWGS6T9tel0fHCNRBhSSePvzbguIBXAZGjnSmY1QIaX3aVwjz4GxsFYXuvD4uoS4IVCOBLVMcxew0N7u/KrETRsHaOd33JuWkllAk6D6C/jiwIB4AMYxJODepttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ2rQuHOc7DiX3XJ8A5mf+IVhyyY13SQcZzCvdnBfWg=;
 b=ZL3uFO7SDcYM/3uVKaBB8k+zC1edhFnqGZhKNnzrUDUMwDeafJBv3/89h2imC4jc6EO4XNL7YYjLD/RBvKYL8zO83nzVAozYUp1jobQfkT01sRdTAjblXv8CaFA/du4gZDA0TtoRgZsr4wD+kZg5IXh6V+2/T3h7gi1QjFvKWfVyIRWGd0O66b2uioYOnb6doBF5QEwBs93f5gjl/CjBgKeziq3bgVIqfyF6HklyIBULzlpwIvfJZhWYVhWdp7jxt6b9MFelnN3hOEnbG/gZ3S0P692nYDuB1VwM37+iWNTR+yXZqUGXH4nRqOCp5r5OZ1nV9293VYGOLoVyo1dSVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 13:52:58 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 13:52:58 +0000
Date: Wed, 27 Mar 2024 10:52:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH RFC 1/3] mm/gup: consistently name GUP-fast functions
Message-ID: <20240327135256.GG946323@nvidia.com>
References: <20240327130538.680256-1-david@redhat.com>
 <20240327130538.680256-2-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327130538.680256-2-david@redhat.com>
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf8446e-4483-4aef-ad6a-08dc4e6535e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tbA0esurhiO+3PfEmHRopmGYoyz1MPbRyEW8gqqTfsxXRUJRehYJbhrw2sNEfeyKKpTPD47cioHUnrbXLtvH3VkuhvIj7mWqSLVm+txE79TYMkTjWuwLu2g7safC9B/2lu/9IOfefrHjGb2akXW/2vODzDEvh/fPZMF2r2w/n7RUAqm63+nBpQSYBB6foVKDQhl2bIuNH0UmiAXLWGmJSaa7UPkcfxw/VRvQ37t8RtkWONR1S+KGl8PKW0Z7zNFJCLMP5BKdFBuacepmI+IoPCzdw5CDjyXv/OtJMolUbrqXA+feeyDYNXVSlbA/fRmbzjSkJJTU3eAqbREZPUkSm6J/7KESiJUrbJmLVESP46aRZYByA72dBapzynt5loi2Qi0ITMjP0Y2UsXlnQyDVjCzP1HFVPN+x3k9rBKO4v289fVyzH2VtAXtARVWw1w9gKji31tTkrlX28hSIjr6N+iu9Fau7UF0JaDMN2VtY1FkYN6OIndB5BSpdcXVx1lV6zlJvU7w95Y1146akF3Ekf/FHMHqkwnfjPfQtraajQPAybSa0HVCKn6aKqyH7PfoaZkUPjtrUqOvZ4IRcDwuPTit1kMb5Tdt/NWIi3st9th6V9MjnS2lkclu9s3fUYSpNCYErmd2CsWaeX3tYJDAw9+/ibu38MuNb9PxC5CQLV54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?itf+dpo3GTzSl55VfIjsjt1srx8KuTR6OxZ5DSzQgq9f9ayJLsqD8iU9cW31?=
 =?us-ascii?Q?Up1J9bTXRk/h6ziQRjfAvIpV3qo66CdbEQOXk4t7UKlL+7x5Ibq6YSL4Qzpv?=
 =?us-ascii?Q?cBnFNhRzX8JeSLZpVrSEtq/N7w5MZt8QVSfe4A2MCla4c1q95rt9faidTBOj?=
 =?us-ascii?Q?IWHvzaLwipQyipk2CavvWwXkO+PDFEobgpJKfaEVZmdzxg098OahjxB1aVov?=
 =?us-ascii?Q?GbO7QzUO38km8ZzcmA7tOXODtmZVA5j2NNfXH6pyFZwLnJ8oWuU5GIUqLPNp?=
 =?us-ascii?Q?DTU1SZUbLqXMl8Ca4sTCZprooweLoZnlC//ITsuCA99gu4EyO8HUIddDOen0?=
 =?us-ascii?Q?p8P/9CrycaEDcXEM/7JIPY3FgZ4xD2iZJSJGAjuI5H0B+9Nhymok48Exw9NW?=
 =?us-ascii?Q?rM5nc/uaMzV2F7BBinFBg/JGxqnD3JZleei65YN+LI5McCQw9V2qw9Eqhp3o?=
 =?us-ascii?Q?HQ1LnfYjQFVuEzKms5OW5cUU3wOtmojS3tVZTKEiDc7bvrd7ISpGZbR2wphs?=
 =?us-ascii?Q?qyEurTFInOUItLQDYsnY5AT5Aph8fqvlz572gFFBX1ugC+y8UGspWLlFKeOm?=
 =?us-ascii?Q?MJkHVMJPWWFuDkvzPfBiSIQNibZbz06OQVu5kt1rWSmrYLZ+UzozrhtOedBF?=
 =?us-ascii?Q?Xz0rlA34CTE4fkRoGjcr3rMMPxIZsY8zMSB80eenkmQlxFvbxuaOASfG483l?=
 =?us-ascii?Q?Xa3TSb4yzpVGKJN71bxDB2X4STn952BmjctA0KldZJ+zyIR+QPt3WzpyUpQE?=
 =?us-ascii?Q?ISRktj15OTt2Um/OIVW4n78gcTYQg0iG0QLXWoB8hVy4Dxsnnj0KovnbsVww?=
 =?us-ascii?Q?d5Qelk+r6ZYgD55CCeBrzi8HwvBSF7gc4Thk3dtzv9EpKld6rMUQ1b9ImuK8?=
 =?us-ascii?Q?RDRxp9kxKQCaw2hsM6XBeKRz5JVT6pgDEEjQoWZmZSdoP1ISd+eKqgn1+hy1?=
 =?us-ascii?Q?XoZjijCW469TvVXED2ZzbAj8/HJwEr3ZiqsnHCI1RYpTVnjH+Lc1BmGzBkE1?=
 =?us-ascii?Q?F2IiMaaCoqOn+zmlujey8DlmDqw/2WqETVi7w38sxlhFP0q5g7dRAVe+ZWPy?=
 =?us-ascii?Q?Nef9UGfXVgybBey3EgQiNJCeLKdly7VR18n+6kz1OCx/vOKbRuvh++0P5Ln5?=
 =?us-ascii?Q?T7ioUSaUGExfesZfA2MbFMMBlyaJbhwsfb+2jTT/3x8Hgpan8AiQT1R0h/PK?=
 =?us-ascii?Q?5TbtlURy8DDRHyRgXDKgfdP9iReHMVf2TYVUPd/wlgKz1DhLDH/T+toNbmxz?=
 =?us-ascii?Q?JJ9hW0iFpI/lvCEh+90Ot7eqovCnKPCmSJNQrsDydp+PM0QGXSImsVrBmQB+?=
 =?us-ascii?Q?AzUh1iuMGsp+IIkkbCCcHRY+WMvEU1wMXU+0p/uwrtRD7R/bBSmV6TrBh8rH?=
 =?us-ascii?Q?VhQ9yio6XH/wmPWYJkWeGSUBO1FeF1umPFxW/g111H4CojOglwD1Dn71nv4i?=
 =?us-ascii?Q?6x2geb2AdNcdyKosPr4UNq4wHorGbbXf+lP2MHosWacPSZalRF4tymuw/6nb?=
 =?us-ascii?Q?sNoV/Pw+ztzyS5ytbj03i26FzJkBDXcL+GIbacNBfcmJG2qu1R+yL/h3dCET?=
 =?us-ascii?Q?LDfL9PZHkgamvOhsDiRvnERKfSOgx3Z0elCh3RRm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf8446e-4483-4aef-ad6a-08dc4e6535e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:52:58.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9NbpnUV2D+qEEPq7X0g7K4FHmO8DKt1OZluear73anXy7NNypFF6Z0Kf3f1qPwt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608

On Wed, Mar 27, 2024 at 02:05:36PM +0100, David Hildenbrand wrote:
> Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
> all relevant internal functions to start with "gup_fast", to make it
> clearer that this is not ordinary GUP. The current mixture of
> "lockless", "gup" and "gup_fast" is confusing.
> 
> Further, avoid the term "huge" when talking about a "leaf" -- for
> example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
> "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
> says.
> 
> What remains is the "external" interface:
> * get_user_pages_fast_only()
> * get_user_pages_fast()
> * pin_user_pages_fast()
> 
> And the "internal" interface that handles GUP-fast + fallback:
> * internal_get_user_pages_fast()

This would like a better name too. How about gup_fast_fallback() ?

> The high-level internal function for GUP-fast is now:
> * gup_fast()
> 
> The basic GUP-fast walker functions:
> * gup_pgd_range() -> gup_fast_pgd_range()
> * gup_p4d_range() -> gup_fast_p4d_range()
> * gup_pud_range() -> gup_fast_pud_range()
> * gup_pmd_range() -> gup_fast_pmd_range()
> * gup_pte_range() -> gup_fast_pte_range()
> * gup_huge_pgd()  -> gup_fast_pgd_leaf()
> * gup_huge_pud()  -> gup_fast_pud_leaf()
> * gup_huge_pmd()  -> gup_fast_pmd_leaf()
> 
> The weird hugepd stuff:
> * gup_huge_pd() -> gup_fast_hugepd()
> * gup_hugepte() -> gup_fast_hugepte()
> 
> The weird devmap stuff:
> * __gup_device_huge_pud() -> gup_fast_devmap_pud_leaf()
> * __gup_device_huge_pmd   -> gup_fast_devmap_pmd_leaf()
> * __gup_device_huge()     -> gup_fast_devmap_leaf()
>
> Helper functions:
> * unpin_user_pages_lockless() -> gup_fast_unpin_user_pages()
> * gup_fast_folio_allowed() is already properly named
> * gup_fast_permitted() is already properly named
> 
> With "gup_fast()", we now even have a function that is referred to in
> comment in mm/mmu_gather.c.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 164 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 84 insertions(+), 80 deletions(-)

I think it is a great idea, it always takes a moment to figure out if
a function is part of the fast callchain or not..

(even better would be to shift the fast stuff into its own file, but I
expect that is too much)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason


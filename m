Return-Path: <linux-fsdevel+bounces-13101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3DE86B3C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5AF1C21F04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917CC15D5A8;
	Wed, 28 Feb 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyFwtB47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BB1534F4;
	Wed, 28 Feb 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135551; cv=fail; b=fexFiVVc1beEv7w16IL305LkMljlxdf35rcqQG+rXT5CEFrYaakDXKqzVGAoXpUKz4UomT1RLdbilJw3602IsE3CT6f+7bl5sE1gurutZgQP5emhTaB9tNrR6sYSKjLIZUAPepsaJOu58bZ9WCg5XdRKVDqk2635TkGANLwbewk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135551; c=relaxed/simple;
	bh=QMcyef4uzRymrn9HY5VhLOXlOujKIOKTmueAxlxGqLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JJ4tcx9swLY6J9B+ZolbnM9nTInZOTDrb5VPxPuC81Y68fN1YPlpeFb71RS0nmrdr1Q0beUhzHHLAUZqYR0qkWnFRduzxUZYVmn68NhjzZ94lV6PUZz43i4m3Uce8XKdKOZXVGYPANAVHBKOHHzz58NQCPLC8Yv9mXs3HCXffek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyFwtB47; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G25XPciq7KaNBsUSemzv7yLV7gkL7DM5FVum9JVoRMrJKlhBzxSJKm9ihKMU6y+b8Pfp5h7M7bbpYOjqEZ05+P5ZhKKIaKWtv0IfqrkCDbgJ73is7ZQ6+ljLEHlO7SJV3FH6/UiOk2WBYM2s8tfP3wIX2keG04Ev52eCkAFFFAAJ94vcedz0Q3O26CUU97xwK6o0QzjqujTlB++aNm4oZbZoK0UaSyGd/JIqtS4FUnsay6N0o+ZW4yKai/V3SyDhLivX/+I4xnASO36mWqnki0iPgO+enNnW9kRe32HC76rbKDH4yUKKSQQ61XiTuDRq5/0RsM3hXHleQlJswg5lhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSJsoVBNUaInQsBXeCa4FKT4UO1vF9eti3guIgy6Eek=;
 b=kRSnEkEh2jsfA9bOeu9Afg3vNQU4XY8u3WxY85VcPn6zHPR2Go3BXxZgDeaXXfAjf1VOmIF0H96NQ3Eq26yRLm2wO4rtkcyxDy//kcqXv1gwoa/6YRDxBHAMmol/LNVsRV2TEJAVyRaIfU4N+CyenY7sy+d9atQO76XiZazrPGhynhnY2x/RgO+1SU1Kgymr6TB2t3srZUPHTM+p+ll7qOSWw/CqBBZ/AJrQLFSUNHyBrnrCYYWdVmFvRY/+ttZ6+VQ8QXyT9iKDB3RwzawxQCsCShbJ7QTdZGGXkEACG2fDmXclVnJpDEVVUPwhUO8QQMS+LqVRP/MvY+DfCCwXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSJsoVBNUaInQsBXeCa4FKT4UO1vF9eti3guIgy6Eek=;
 b=fyFwtB47RnXHQ1TTBf9cvK6VsvqxCeA/QdJN3kTP42BDB2fqF55pWqhOqszq7Hr2PNiUXCJEhOeVn2WLzb3PhTOk11p/ftVhtWyDFJurwqdA7wZhh1flE4PnZpxjz8cP9nPyDx/1JwuYzJGfQMeGo0S7A/K3LHj9zJL+K8k24Lw36W/duNKZKGkieqX/hZJDlQrabb2kgdAQHjFrKvWhP+/DL0Oa0w/HvMH4p4VQn8CD8vf7gtqQfpuL+kgdALwhtjdKezoWvsXSPp6mzAuesvaGEmkpB/h1KJP1nZqiss3VptqM1zAK6gMQgmb4ZIJJU80ziRAs9eK+v4WOIhcGcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Wed, 28 Feb 2024 15:52:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 15:52:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 Zi Yan <ziy@nvidia.com>, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 7/8] mm: thp: split huge page to any lower order pages
Date: Wed, 28 Feb 2024 10:52:23 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <494F48CD-1F0F-4CAD-884E-6D48F40AF990@nvidia.com>
In-Reply-To: <20240226205534.1603748-8-zi.yan@sent.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-8-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1C869A39-717A-4300-8A5B-C326B287ECEA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:208:e8::32) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: d4803cf3-9d8c-463a-3806-08dc387542a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gJN/w3MDSz+evcn8SMpmF1BcGl+0tJIqQTx05HPVrte1nrM4BT2AS31smN+eWeHhDam8hQm40HJOS33B3sQwhknKcj3ybfYuvulzv696CQml56Rxv7zo7DR6ypwiuJt960Fp4ejYmGFtkBnEkJcWZSKGzM4St82DT+mMbN39RpUgE7kNJCGvf1cz1rSrkshgirkWVaDrrmTwhemq4c1+c8FsyNHFBRuPowoU48mZyaMvfyQ4Df2ouoDj4ewqVRY59RQrIPkGGd4iJ8SuAaMCdZUjVT8Y59vzj8Wc+0zyE1lhwkD0T+1adMTAuZb5v5qw5iTcKHGQ6zThdGvrErXMQ8ylM/xjZyrxfDxXcfUCHvhEHfQa/AtU2S5rdAuVwg62iY4SEt1nQI4JathGiHZXiIUB56KHuMz46FiWNr0uUGU2LbIjdyZ+ONhKb6ozTobNcx3S/sqhAw7V+TwSCVTf67eFVVp4IkL7jZ1vDy7AiHLr0EApFz9+kh0NK0xwe124jEI1P+sXHZ2Zwc1/PJBaBzDoKz+UzQhdrA83gIfGq9QiAvqVKHPZX0yHepL878lI/5ESSsBuShZq/FR11NWfMVk/SpVp7sprhAIfcOc6UEgT7sOB4aoZxAdSiunoA26K8RGkdZSNGEc7+pPkCj8y/N5mOW8Mn+8rNyOUFNFUKu8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9i1SrKHIHYDldB0mK0xoocDUFl9GiekH2xIx4yrnvhx/Vf/P5u0DIBj8Z9p?=
 =?us-ascii?Q?qTsLDwSuTyNTnioKQ85SyQ+oWQTEoLjY1AIUNQXeDauy4mjZCBqtAjAYRvBX?=
 =?us-ascii?Q?jP4hhGnRyl1cWTLstlNtkzuYoYtCvWEABSwutwfEuw6hyCiHYO1WvloWHxP5?=
 =?us-ascii?Q?aoVdzmLL9YHgKny+jMgCiXqJWD04/6slCoUN0BBt+rrKjkXZRqyOjWBQPm/B?=
 =?us-ascii?Q?CaJGLJzPQWN17Ss9e/Il+uPoBOjXjRMAupnhFDAvaR2i/A5RJoN6H/gYJow3?=
 =?us-ascii?Q?gZAlH8Uq6utggCPk54mxXl8wV74YlGJdhFd9UeOeZiNLmZghoQg1ko+/D1Q6?=
 =?us-ascii?Q?eKKTkLUFq66P1VXuG33qEC4YP5zLmriu51RBK/PK8Ymz43ptcBm0YVauMBdc?=
 =?us-ascii?Q?wqHneG5VopCJVW4FtngSbj965ZKjgi32lPHUojyNM/GoqN3ZypCflThhVEwe?=
 =?us-ascii?Q?xx1dIDfbSKLLtTu/Htzx8qAY0jBEEDFfLOInQzOr7xjT8wHRZO/Icg7IgO0d?=
 =?us-ascii?Q?5Iu66WgBG2OXPXdTlYwTlOM/pS6twwd0m1IWuqlPFinPhDRDsfXw+cifx/mi?=
 =?us-ascii?Q?n6ezQbv0t0qqmkmJwjbjh0W35N/Ur+6CDobRC7dJAjaCKxgLRoLo5RS/0qqf?=
 =?us-ascii?Q?o9dCmQraOikAfd9KeyV4Pn0EOcFYT2w20COR5+9u88+EuB/+qCl/gfXLKn9f?=
 =?us-ascii?Q?QNz2cTQon1wXxFB04Qpcd+OrMaEh+v44WPssKDb4BfcSDp3TYPjjHDJ8tqXi?=
 =?us-ascii?Q?YTncmHl6BwLd8GN2B/+IbpeUNC0InYKjpHc/6hXWPpiVz2nM0yF2dHVCIEaL?=
 =?us-ascii?Q?2iW3aXaOjavkrtUYDVcDMCvUdbgx+WGh2hxoihwNmwCsR30oERB53hqBqnC8?=
 =?us-ascii?Q?XnGkh6KiiIT1NOSLVSZECuT1crgCLC7hC9Osw48zzL3I0WgCqO9ugTfmQorv?=
 =?us-ascii?Q?CJUX3dUVr7Var9KF79ezMABLi6OiZ1rGr07rhP0fH6y8vueluaK7vqzWubcW?=
 =?us-ascii?Q?AJGi5pWOgJPsVxKgcf+Ry3b+PkVlc/ndjSAUVAd92S2yzTA2bmlV0hVQUM0F?=
 =?us-ascii?Q?DJA/I/optE074MHMGBUjHy149HlfZ3/wOxIDbx+fq6GW6FcAkW0MOmBCA9VZ?=
 =?us-ascii?Q?r760qQov2BQIz+nXq9nEfznEfA53HlyiHF2OTMvF+a2FzOmVlDsudjT7Rca1?=
 =?us-ascii?Q?Xx+C39GO8x1SOuSGKnuDtHxyiE1aueDr0VHDgEe4CXTcu07oQBFXvUicCbBj?=
 =?us-ascii?Q?/q3gLWqVSfd0VMCYkg8PI+odpNDwzhQN8pfyenlW09ZDR5W4FkjJv8PCn4wC?=
 =?us-ascii?Q?ODL7J5tkUztxACl3KO+k0fNzZeNM90yNU+FSzghcN/MqwfLJrlG4fY2QV9Mh?=
 =?us-ascii?Q?UIm4jGhOwVwwcRa538gCT6rbwgL6X9Fw2hfKm+tXRaOMActLXseEqHRWeK1P?=
 =?us-ascii?Q?XIn+zFJXCHw5CZbTbf/wqVypx0vKMJoBWRGYH5xRtADKHeYoU8ybtZXFcm+s?=
 =?us-ascii?Q?r+S5AZs8mGY7jy5pU/7AxfF6GGIWTD5nTIQXBJgjtlV5TWC6rPg/tloFXux/?=
 =?us-ascii?Q?fK1HUvWyjjGtQKPDS6rfkNN+A8P1qIv/1p9hd+AM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4803cf3-9d8c-463a-3806-08dc387542a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 15:52:26.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUkPz9FVJv+kdUJh9RNF+IgfM1Ec5gYzHVwEz5PwfsI0O6DcoNvzAYO4v2e7SlO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

--=_MailMate_1C869A39-717A-4300-8A5B-C326B287ECEA_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 26 Feb 2024, at 15:55, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> To split a THP to any lower order pages, we need to reform THPs on
> subpages at given order and add page refcount based on the new page
> order. Also we need to reinitialize page_deferred_list after removing
> the page from the split_queue, otherwise a subsequent split will
> see list corruption when checking the page_deferred_list again.
>
> Note: Anonymous order-1 folio is not supported because _deferred_list,
> which is used by partially mapped folios, is stored in subpage 2 and an=

> order-1 folio only has subpage 0 and 1. File-backed order-1 folios are
> fine, since they do not use _deferred_list.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/huge_mm.h |  21 +++++---
>  mm/huge_memory.c        | 110 +++++++++++++++++++++++++++++++---------=

>  2 files changed, 99 insertions(+), 32 deletions(-)
>

Can you fold the fixup below into this patch (per discussion with Ryan at=
 [1])? Thanks.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 50d146eb248f..fd745bcc97ff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3059,11 +3059,8 @@ int split_huge_page_to_list_to_order(struct page *=
page, struct list_head *list,

        if (new_order) {
                /* Only swapping a whole PMD-mapped folio is supported */=

-               if (folio_test_swapcache(folio)) {
-                       VM_WARN_ONCE(1,
-                               "Cannot split swap-cached folio to non-0 =
order");
+               if (folio_test_swapcache(folio))
                        return -EINVAL;
-               }
                /* Split shmem folio to non-zero order not supported */
                if (shmem_mapping(folio->mapping)) {
                        VM_WARN_ONCE(1,


[1] https://lore.kernel.org/linux-mm/408df79a-130e-43cd-a21a-9b3a2ddef617=
@arm.com/

--
Best Regards,
Yan, Zi

--=_MailMate_1C869A39-717A-4300-8A5B-C326B287ECEA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXfVrcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU2ZIP/3L/ivLb/gcscAIQhykmqcYazMK4321Wn2e/
F4CcvHflMGGdGpIFGkIFdgPEfYT8Z+9ieLjyn9d+2qEmTK6Tc9YvUsgiDktoUbrE
X3hlYCGVgMpZwIByrfpYzsnCioVREm1PkSuLKBAD+B7bz/C9sw+1YTCN0Ky8JxuA
eLEFOgpSUYbnb7+M1pvanE1v+CDXcCm/ct4Bj0AjAvxOXJxDN8v01cFVRz2HcR1C
EodKz7pOqGHSBK0qDdJeM1f7Qiq6fCiX8GI2t8y9W5neoFWKBBApng3sWOLqWCSQ
duH15WotDrt6vR7JoV+lcqfaUhzVs7AzrI5gGH4ERCo3WDcFWBSebgvZPUAaQGX9
dWzb+VP91Wgg4IQCON/5Pm8/IDulMSN9yhzJhgMqL924H4BwTxAY5GMkQS2Yso7a
JAYqqFhKqeAmzY0WqTZPx1fMG0zrUVEEcL0Y7KqsbegxaUu6zWlitPejcCwc1c6C
OS+92Fxeg8pthLWqqp5CXN4rklMMCXruxvH1BQLNDFf4pL82HH0S8FCXZDH/wip2
uE+1B5MFQHiAsxMAetNdPSE2WfX2vB/zzl7hHszfuJGPB1PfBkkvDoHLcTqystqn
b/YqMn1iC1QPqgNSI4OjRFXq9r3naPJspv5Z6Wh/isu4d8zPQL/O7y+psweZGGV8
WBmN5XO3
=Rcu8
-----END PGP SIGNATURE-----

--=_MailMate_1C869A39-717A-4300-8A5B-C326B287ECEA_=--


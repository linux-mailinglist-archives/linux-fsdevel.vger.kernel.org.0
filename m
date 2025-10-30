Return-Path: <linux-fsdevel+bounces-66407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C963CC1E0B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 02:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7408189A638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 01:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DE2BEFF1;
	Thu, 30 Oct 2025 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j8EdKBUI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03432BDC0E;
	Thu, 30 Oct 2025 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761788435; cv=fail; b=lMc94SvaUYmbzuZ4yW6GImNVjTzdEYFbZakGyudIk+Is5KGEQ0MvCHKZ2c0rqzMeaYNWquTLJ+on44b9m+JY0iDVZDu+6+A9Xx3BTVPx9zynjdQneapCtiYlBN7EJQtHKNb306JdTkVeLpai/uCP+RVs9KQz0gE/8ChEMImt85U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761788435; c=relaxed/simple;
	bh=t5Gz40Gju2g0l8gsQ9fnnE/WF+SUdrwyQJZJNfLGW+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7Q0L7YZYsZ7r3h9QuswzMX2KZsOLvaK/jYeTpynjaL6LBL21C2QvRSRiVfTFOHkGYH84AG5iqU+GtLgMdf8AjhUMG1QR9NDva9W6zBUshDTL2pHzbExPKFt6Ijfpn12TR+3Pj4F5tJ5zjrF4xPJf/ceZhWDX7lZZ/L/GhMvAmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j8EdKBUI; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR+IWbRsA1S8yO/U/SxWzM6qU0Sh5BzVROvYPsUprmr4eQ0MEKO8+1emhdgPKpjZvSaEGcO56zpjuQLkFEYYkNqh7f5aFchOsEsycdGt9SfnUulHwHES6rYBK//0wCjVGN/Lj6gepj8gIck90XrbloKaJzRjaCyb2g1+HhZj6BTGRATMSIEFP+K4GOQ8D1BfHGjCzP7EQOvftVtVzkTFH58RntET84c/Q0SMqHmQ+cY/T+hLVgWj49hm6eOF8LhiXo7sFFDO5BaEFCxNDLKnFTyxwNQUVhJuWyaFjsTbyha5OVbmVHi9p2TTBe73ZI91/VmNWsO22SWIcb/z7O16ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFNT2nIR/caRtHy5PLJ8UtaD0NtQqMOW+luoaYdeCDA=;
 b=OzfwSZF2LMH2Spx5tBFqUWca0zhHBDeBXsYcl5LsFvH3otMuSGz3h25BALBDOXnZyKZbJk+hJaHSytShd4mQPdAwVidhSEc/MOh5V7CIU+IfOXWAXT8LcMB0S1KNcxp4Lh4t4zrrKGu9PsBQ7i4SC4lEmZ/IuQHXNgQ+2NLTyxrrYeN77AdcXPu+oEe8DPaT6ikTrnbdVFBqlzkJco4fcjHgxEmTiYej9qcp3jGBu6h2hKdc8qNMZsaHkH9RsdUQ2h39Hen1JDj6bVtuvxru/zLnPIaAUPIpo+eU993gYVJcruPop7p+jkDib6AUHHT22gDvxdfNXLlq15cquMWupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFNT2nIR/caRtHy5PLJ8UtaD0NtQqMOW+luoaYdeCDA=;
 b=j8EdKBUIdGAf8dhw1r0YzvaF111x1H9jCrQTuHAk0vWw6rCxnRVD6CmfE8RL+jB0cjRfWErPoWFpBdLuyIlrWmmK3Mk1HA7A9AScdwdzPybTu0ge2OFVB4uIxRTEYouCJAjZNvMnSmrjm4DXWrD48OD+x191E093hieQ7zgZTBsacXUME0tqdG2cQQ5ol/A766ZK3iJTxcjW6XoshXtdaeMM+SzquKkXp6lWbc5xpaDy+KqzUE5qyRoNBKaKwPBN/g7n8FQHmD5bNnBZHgg4ok7CUqWOJekiHpAPE7Dx9dmlaiC41tBpFnMtFLZI/wkEUdLO1nfQAnIgzsteUbGM6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Thu, 30 Oct 2025 01:40:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 01:40:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com
Cc: kernel@pankajraghav.com,
	ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 3/3] mm/huge_memory: fix kernel-doc comments for folio_split() and related.
Date: Wed, 29 Oct 2025 21:40:20 -0400
Message-ID: <20251030014020.475659-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030014020.475659-1-ziy@nvidia.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 5131c6ce-1a57-40d5-ed56-08de17554d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EQ4x5mUvBaFXWAUqQcTT7Zil4DFNKqe3HUedokGBv0UdCna+t6J0kn8CJm3x?=
 =?us-ascii?Q?7TCogOsLAPN/b4dQZr7cg0gmcIFKg8wMR/X7oD7AddZfOEH0lUVFQg5pthm3?=
 =?us-ascii?Q?a+eg/P1wthIcC/sG71eYROa7Mww9q0iseqCXDbl23zI9HPB1pHP1vYZmChyC?=
 =?us-ascii?Q?+DOXzrV/0m5NnXXSQp0FoshFDfrkC7oIPIECQNRrTSgFumB6xpal6/IYje8R?=
 =?us-ascii?Q?ZC+65RLxco11fADW3QT/AemlSd6eQQezJ0MEpuvl93RUroK9JtwWzp697bTa?=
 =?us-ascii?Q?dHEiAawUcmr2+26llY+w3GhTr5RUtymo6frGW+/2yxVY2sfdm9bh5IVmHdLE?=
 =?us-ascii?Q?H87RkjXpCD3ugavc9NIqDgK/SpI7RmrmRaC2eOpJN9AMfRbsaHscEiSvHXe8?=
 =?us-ascii?Q?2X4b+6i78djlQlTvImYZihKQ5fz17OtvAqmXOzt0QB7DMLLZAsEMPv/E5wN6?=
 =?us-ascii?Q?SU01H0VXIw6j2OppsvJ4HWK3UVFdV+23mqB8k1ZkmAgXvDBlXMvk5eGSu1sk?=
 =?us-ascii?Q?DRW6NWjM7z9WUMhWeWPY7VLOqEgZcwFGI8j/a4HvyqgNSgjJeTeBTNDGRbHz?=
 =?us-ascii?Q?ZViL4D0VMX344f1NyByj9lCTWC9oZvCuiTBW8+jPGZrdHPeXZe1qLO92CiDi?=
 =?us-ascii?Q?pDY44yZdb61SInTYgKz1kMfZmEHuEwYCyt89WekwOY2H8Ltx5KaO27FChx9i?=
 =?us-ascii?Q?Ndy2KKoAXMedCUHiZ5iwLfOfP1j9jdYiE9uvhJZY8oIIdn+HNRxK5KfpB6y5?=
 =?us-ascii?Q?kSn0kdDMqtvjyiAkxi+Xfxt5ts5lmKFSx4fexvjETWItonrW4QvAS1pVgIr2?=
 =?us-ascii?Q?OxQH0J20t7a5UrZGyj3YE7hwl2RIyBHySmFttGJB02DpTW1+w6dgRckxYFlw?=
 =?us-ascii?Q?3FHC58zGN4stbvo0yuc7NMmtwnbX8wQClmo+c3kYLznTdM5Y0KsqO9402M6m?=
 =?us-ascii?Q?h4sx7xI1pqo4lOvQjHau54VKecpGUM783NFNp6h/XPV8viA7n5A7cahLNHva?=
 =?us-ascii?Q?OxNrQ/PU2nBm1pcWMvCE8vh8kxQ+qoAXrdvnJgcZ0Tj+KBTDddp1zovDvG42?=
 =?us-ascii?Q?u4dwZ7hzUx9EwMzy6MFs9VF79Hr8TB975NpOdbYpfkp5LPFOR6ecGFEq9d+s?=
 =?us-ascii?Q?3FttIzd8av2/O1LUF9tMtIr/BNTAEveKKBNoE+S66QGjApMgbCjuOje1cUUu?=
 =?us-ascii?Q?R/ZEghcN/1TSagSrYPWpkBJpiUo4PIxqULo7SQDwhMpvejcywipdt3ooL4rh?=
 =?us-ascii?Q?0nQBYr2NE10VUGUZ1FdbTr5nNsm+S72tHZmAMe8h3GCIzg2ciUL+1eRNkaYD?=
 =?us-ascii?Q?aG1KsgtCissVKLxIGSlJwLy40KV1P6D+raKnvOjcwVO9lWMAlxCy5QbUIclv?=
 =?us-ascii?Q?Gg4pYXTDmiPxJCNS5wmeQ4oOQbe0SQwxtS5GTwRfDhQDNvg/DglMz5zgZTG+?=
 =?us-ascii?Q?WkyelemZX0h0MUJ/dvLYhkHO3GnYUYv4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lr0evs7OQ6vrkjyHW5kTX1cmJWUtrzP2u16Klp37smWbjMWy8HXjD5JwuD42?=
 =?us-ascii?Q?ww81yFud4kEvrl88mOqhSDgEuHywV020FGw0eneBM8wfCP4LiDU/r2x2zgHa?=
 =?us-ascii?Q?S1TkwIFnJlNMUp6/9VF7g9an2r8iT3wDx63hhFgbotbZiuR6w9xKPDcupCH3?=
 =?us-ascii?Q?fTt3bwZwOhOrUtyhLd6JA9ejaf77TVdhAwckOcpnK+Icbg1+OHWZUhI6eCyH?=
 =?us-ascii?Q?VJ+XAN6YHTbuP5YCqSGTelJFDpP+Qci3pdWKoqlDCZWPtKDfL7FpYR/nrgE7?=
 =?us-ascii?Q?dH7DU7GMT5pDwGhdbRXd0I73St4jHlNh1RiRHbJgIxGaOuHtimxCcLydn6M0?=
 =?us-ascii?Q?eyLpnMuF7epPXJWultIGxWUEtFODGdFXPxEFIk7MfgUSR/0iMmT0ilEU34po?=
 =?us-ascii?Q?WW4i9s3O08CkdhnMyxXqVeeLRIv2gVNI82GcpdJzuoy/Mv8K2ET4xndELJ12?=
 =?us-ascii?Q?2AkJ/Ll7N8G0IZ4w0bleGcxz+3PkIKbD36KWge2yvE/KwpGpUua7cAVFKBMo?=
 =?us-ascii?Q?r+byri+n8NnBgVFPEVqPDX18dfvwJZQMyVCo172ULScAPttvnTGNTSyAiCAP?=
 =?us-ascii?Q?5LGs1lYc9ZJfxB4Wvppb+qB3Frilhhfc/f08R7OXSmUWQ5GEZrJY+TUZr6Sa?=
 =?us-ascii?Q?gId9N+0RqIAU8VQXZddU+M4RRrx5P72YkkpTjjhh0Dls+XwRFLZDziNfvJYt?=
 =?us-ascii?Q?Zqfk2H8JRlFTbCRQf7+6jgW8VTxpCbMRe+++ZNj5G2T9xELPBlMjM6QP3mQu?=
 =?us-ascii?Q?lOhqZBGLGeOFnctSlWEQSG639Q292caMQj7VCrSvuWxiu+Y9OCXEY8AIN1P7?=
 =?us-ascii?Q?l48qUMyeSUqqF2NXN85mya8uFWsAuCU9MMkdhf/VDsquVVK3lHk81bMhXhDl?=
 =?us-ascii?Q?1JBeu+Nye582rEelJKLVx8jNGEZRK+pxYSGydqWRxi/hhVB2E27l1VrWrcdU?=
 =?us-ascii?Q?IbYngo7ggvX4+QpZbxvLSI3le7oT4XWUwUU/u2hTE8KCxkbvJk7Q43EqXD8y?=
 =?us-ascii?Q?M/od28s5ZXzCtrZIwdP1/Y8n9EgL0Hn4iSf4wFot8vqQGHNtPZVn2YQRUyw2?=
 =?us-ascii?Q?3GeX+osUMO8W8mpX4TYnPCUCItM2CTxEzT29RLwdKfX3YZp+Ca6PMBETW2eY?=
 =?us-ascii?Q?gmJKEjZwoTeRtDQQI7Eq4pcCEiVHBACNwJyzOuIPzTdv+mhX13qZoLvHaftm?=
 =?us-ascii?Q?bmer+GS5IXmalg1ANZ46hmEJW8S0DLXTioWorcu8H7+/JbgR8n1CKlxq8UWj?=
 =?us-ascii?Q?qD6YIOf2u9whrP5FOwh7KYRFHhaarZupXrBL2dH9FXC4wuqZcUjW7HagpaTl?=
 =?us-ascii?Q?uY8ksvwrG3NgS/v3Yiw3XFfkKNMP/N8CVWs3ImHdlGrHM+yaMRB2urIWH7CK?=
 =?us-ascii?Q?mG9924Wd2B5/xpQFqrPDXxhckWVc0EULOK5RkSBbGh6zHngFAzX/iC6C622e?=
 =?us-ascii?Q?XNVJbV9+NQaD1eOjpPx9FMznYWCmSrYyt4IYaf5fQGAdcBHOmztAMMRXkQ64?=
 =?us-ascii?Q?LmL70iYYZtC9C9L4ziQQ9Qff920p76HG2iHDKQIk8seVaUKGd4P4LaOALfsL?=
 =?us-ascii?Q?P1LpG9KbGyb+FLyaX1KTtHFfIPlvTJRKv8d3e6AN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5131c6ce-1a57-40d5-ed56-08de17554d85
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:40:27.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJExiVkXOK1+DNkHHyglt5zDgVmKC0eSKqbn1RK8mJvss8qtnvondFKfcYsoM5rq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261

try_folio_split_to_order(), folio_split, __folio_split(), and
__split_unmapped_folio() do not have correct kernel-doc comment format.
Fix them.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/huge_mm.h | 10 ++++++----
 mm/huge_memory.c        | 27 +++++++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 34f8d8453bf3..cbb2243f8e56 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -386,9 +386,9 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
 	return split_huge_page_to_list_to_order(page, NULL, new_order);
 }
 
-/*
- * try_folio_split_to_order - try to split a @folio at @page to @new_order using
- * non uniform split.
+/**
+ * try_folio_split_to_order() - try to split a @folio at @page to @new_order
+ * using non uniform split.
  * @folio: folio to be split
  * @page: split to @new_order at the given page
  * @new_order: the target split order
@@ -398,7 +398,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
  * folios are put back to LRU list. Use min_order_for_split() to get the lower
  * bound of @new_order.
  *
- * Return: 0: split is successful, otherwise split failed.
+ * Return: 0 - split is successful, otherwise split failed.
  */
 static inline int try_folio_split_to_order(struct folio *folio,
 		struct page *page, unsigned int new_order)
@@ -486,6 +486,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 /**
  * folio_test_pmd_mappable - Can we map this folio with a PMD?
  * @folio: The folio to test
+ *
+ * Return: true - @folio can be mapped, false - @folio cannot be mapped.
  */
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0e24bb7e90d0..381a49c5ac3f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
 		ClearPageCompound(&folio->page);
 }
 
-/*
- * It splits an unmapped @folio to lower order smaller folios in two ways.
+/**
+ * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
+ * two ways: uniform split or non-uniform split.
  * @folio: the to-be-split folio
  * @new_order: the smallest order of the after split folios (since buddy
  *             allocator like split generates folios with orders from @folio's
@@ -3603,8 +3604,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
  * folio containing @page. The caller needs to unlock and/or free after-split
  * folios if necessary.
  *
- * For !uniform_split, when -ENOMEM is returned, the original folio might be
- * split. The caller needs to check the input folio.
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
  */
 static int __split_unmapped_folio(struct folio *folio, int new_order,
 		struct page *split_at, struct xa_state *xas,
@@ -3722,8 +3723,8 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 	return true;
 }
 
-/*
- * __folio_split: split a folio at @split_at to a @new_order folio
+/**
+ * __folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
  * @new_order: the order of the new folio
  * @split_at: a page within the new folio
@@ -3741,7 +3742,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
  * 1. for uniform split, @lock_at points to one of @folio's subpages;
  * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
  *
- * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
  * split but not to @new_order, the caller needs to check)
  */
 static int __folio_split(struct folio *folio, unsigned int new_order,
@@ -4130,14 +4131,13 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
 				unmapped);
 }
 
-/*
- * folio_split: split a folio at @split_at to a @new_order folio
+/**
+ * folio_split() - split a folio at @split_at to a @new_order folio
  * @folio: folio to split
  * @new_order: the order of the new folio
  * @split_at: a page within the new folio
- *
- * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
- * split but not to @new_order, the caller needs to check)
+ * @list: after-split folios are added to @list if not null, otherwise to LRU
+ *        list
  *
  * It has the same prerequisites and returns as
  * split_huge_page_to_list_to_order().
@@ -4151,6 +4151,9 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
  * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
  *
  * After split, folio is left locked for caller.
+ *
+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
  */
 int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct list_head *list)
-- 
2.43.0



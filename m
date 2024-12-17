Return-Path: <linux-fsdevel+bounces-37586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D49E9F424E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A263618828B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A181DF27F;
	Tue, 17 Dec 2024 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D4EOWxl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28215E5D4;
	Tue, 17 Dec 2024 05:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412482; cv=fail; b=QDvz23iWyNuA3+9EjZgm3f91wmwVsA4J/fnj6grIod4E8U9WRpXoENXsQR5YOSj+Z52H4/USARmp6ZnHJD0+vFfAyTEJHA2ElgZwzddmJd4d2MqMzsWlvTeIxIIEgxOTWJHdIGAAJnOP0nudVCNlyUSbHy2xtQbrWn4nGLlMDMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412482; c=relaxed/simple;
	bh=D4Zv3VmQpxUpexeJ89ttOHDmke2YfnclyWypDj0mgN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ku3PcAg/ohrCsQtLbiHypOBAMIUpRWmP8CCa/cSl0WlT+Y4JnlmqDyZAyOViuAYtYrwDqH3sJPaDbtkuSkr8z4La6zegop8Ev3ywke6CY5A71TCTPJvNpW9pEaZEWhFNmd4769oORPHwWW+NtZ9aQzTQMW120yCPZupzLYxfpJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D4EOWxl3; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7dpfaz0T9xnUv7u9Q8rVgZ9msDJK8bIHSCEIVstvjO9LppVIq1LOPWmDWCjtqj4QcdISlkrd3H7za1GpOdYNkJGGwCljjZuR678RIwBfSfYjrgSLaqQBOH6IF/s7+WkqHpq2sWFMF1Fw2gl7TgpyrmlFtOzzqdHzNTKm4fRjNPfk5Ss3kVbUc9x9ra1u6WCjoq+Hz5hqXuFx0j4TDzdsEGczWRTmR+Ljvn/5+288bqnH2zdM/RBb06phiGe1wCdPhu6gatylQ6Ml5v/XegBdA/sBzIMzC2ABa4rJC+kjHYxPFJegioIaTU4seyLubCbavjo4AkG+r5ZVPke6sIrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phX5+jgH4DJSeo2DO6XHedVCAbe3FoODmdET0VDzdzs=;
 b=MvstHDtUryzw8EqSb+EmjoHorj+8kKU2UEEHY0InLSHx7WHpBGVzvi1CsvGAG+ZOae/Bn/7SS5qOYjlj8z+vl2Gf8iBCcR+TKj4YDZx4dOJ0oYFfHvafGNF/QsCfJncvS16qSybGNEgdl4Rcm6OsW5FzugCbSY3p/FirRv3Oo93u5vbuoAOrHjPkdlGXeIpXpi1oUHJj5g45gNSeZFoR2uMr+qylxcxAw2LHQc2dW7+GNVTomt1o7cUqix98CKnffwCueVrYbhyI38uc7y4f+O4OF28sNDWiilmGHJLB9bqsqhUiw6uKfWFhaUol5QuTX+U7tr2ZMBl5t0QUP/5y1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phX5+jgH4DJSeo2DO6XHedVCAbe3FoODmdET0VDzdzs=;
 b=D4EOWxl3mmV5l0kxoPK8tcGzMWUFnf+pShUxBuWMarzboXsr3u6j9bQD8Cd99xkHdIXS0TdARkE3jKUa6uZGE6ik2NIR/1/Bi++9WT819x+rH4/4U/10xPEd2f/h61kD4n7mqbqqLWD+Kj83RNcFI3K6KgT8LrlBecr4VnWhKnYVaM1Sjs3riG5BPF6oCjIUirgBdW/Cp8r5mEJwuFDC4pzB2vmomJZtnMruIDnP62AulXJtyX80b5x+kBGw68n7V2UwBQtBTlzF/YrNWz89acWKx4jjrV3FcFWNNNBQXwCH83c+1wz/kWU2gG+gjojmjnJQZTq9O0P4KdlCkaCIDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:14:38 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:14:38 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com
Subject: [PATCH v4 12/25] mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
Date: Tue, 17 Dec 2024 16:12:55 +1100
Message-ID: <25a23433cb70f0fe6af92042eb71e962fcbf092b.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
References: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0031.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b76e87b-8a52-4a15-3859-08dd1e59b43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOyQlTznOUVfJrWfu7QHhvTTN+KojXqt8n0tIu2nTcd5A1gja4Yf76UgAhm3?=
 =?us-ascii?Q?Nmj5/thzy46Ex3gMKyDGmkYACY7OSTIHRW8LutzPtez390hn2AA1uYkuvAVf?=
 =?us-ascii?Q?xfsWlFpwu5kFdxuJApjlAZccLJpRDGILg4Vg85jJFf7vCZcNZgrdJ2HCKbdR?=
 =?us-ascii?Q?vjEaaVjjGGbG0tlBASjz6AupQjxTcgariNY2NH5KS0VnsyLzr7aShUADF0jO?=
 =?us-ascii?Q?S2O1jzloebBBL422ZVMfyLkKKumi6s94qManrDCDd8FpKiBPvidLH1cFrhcb?=
 =?us-ascii?Q?Jtsx2yVBhYGdxcm4hFZIiHadnZFLPsKEGLRANEK4sfC6mCJh3eLGwovJCb26?=
 =?us-ascii?Q?jYypKwDZ+HzWEThvnjhITtk621cH5QjFGfQPbcHqDZxvuRZlV4xMXWFxgqp2?=
 =?us-ascii?Q?JbHFOg5HYQeFE+ySa6GlrCKFNac1txK//cxG+HXw7nF2pztSUGxMS58R4gYS?=
 =?us-ascii?Q?jSdvx2McdtxE1lNTI/+K63gawNf5/4yxFqdGrqBXJa0Wuu8IhGElMiU1FTp0?=
 =?us-ascii?Q?zcw/lyjEm0Hoj47jiXzcrQYHB65OrkDOLkqJUOMzgqovXCUxDgt3Xt8vc6vD?=
 =?us-ascii?Q?h+YfVaAjlv6lZGtnLVv2Wel6krpSRU9pycpnJ4X65j5mP3Bo5esK+zOs/geC?=
 =?us-ascii?Q?99C2fgQmxvRYsF6DK/JAER3BHflzjNJSNhbMv9AC9x6HC9tX55rxzQcOrmaf?=
 =?us-ascii?Q?zVkkj9rN51kj0F5iaLkVlacRDSiVmKjZ06Pvc8rsKjeyQ7uuGvzDGj9OKYq/?=
 =?us-ascii?Q?AptQ2omvkYFVlWPKV1e8S6qc4So+XKLC4rq6keWOngTN+JZwBPNWKvZN6cbt?=
 =?us-ascii?Q?agctN3bCHaHibSZrJqI473PYpxrGfkA3licyf99lXYYtfwfKiTonfwl3f7HN?=
 =?us-ascii?Q?xrMawLrDT30nzGkhrOfkEbJy+0pGY2yf7Dje2OCwE+vQpVaD/UsgbaRSM6u8?=
 =?us-ascii?Q?S+6zOYXtucNhhRcKP7KwreiA2dI2OWh37HHFLgEtRxNyfEcJ/vtD34mymoel?=
 =?us-ascii?Q?/Hn3Jc2Khb6grGCV59hq+0d4zn0gWRrKKwEvBQG2ULPAwS2qgYazWNQVGbD8?=
 =?us-ascii?Q?CihomzHdxf+aylz50LtucM/GMrGvotgjyAGzVhagNKBekRlqKFF9e5IInbAS?=
 =?us-ascii?Q?WCJUA8ZUtW8H9XXIEepjKabaBG4Fhwqu1a/GWII+0GHUQYFog8GQiVK0B9yJ?=
 =?us-ascii?Q?uNgxYk4UtyMktASTAVClsprCfQOZ/0k7yFG0S10sxxVK87WaLE5MhQOKcSvm?=
 =?us-ascii?Q?rfrQSneGX4pjx0iH46vCkj32yHSiweqXGjTzWcWdqQhhDabq0XL9z3Vljade?=
 =?us-ascii?Q?6YUFP1BTuGn8eIP833EVm+DofAOgsz3sQSSYpe5vrNptntPaL3SI38aSD1y/?=
 =?us-ascii?Q?aHsxRYc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TIfhq5g1/RlWWaUhTyVft3vXF4CsFooIGcSOfDJdN7H6sZvZDTs7iKBaOHEF?=
 =?us-ascii?Q?NKzMCuvZyw98IFkFzc1A3MoHECedCmsiPpE/+2OriSOSx1t/PtNTD19PNqXx?=
 =?us-ascii?Q?tqpSSc81Mu2pncNJwDlC7Xq9WLdycCuP7jMCX9PI8/MmZVK0MEpFi2XzkTwl?=
 =?us-ascii?Q?BqhRooi72Yi1Oj5u3Jwc2Lltcem8Von6w3MbDTRPwULtWARWUxQ+PNMRttRe?=
 =?us-ascii?Q?A/Y/ISNeNN3YmCpfma5AJv6OI58GpCUwOcjT+Wkx21IZR14BPMkNa2TPpWLr?=
 =?us-ascii?Q?+3ftiul/cei4JkXarm6cIS1+My2ls1twiwAV01Skd4O3i3JqTsRkTfG6TYz6?=
 =?us-ascii?Q?8OdxUnWmhKkOhuVvx05yh4TaSNtd4+ZGdu8vbCGIfiNKo9owUxfSJDVbkpGQ?=
 =?us-ascii?Q?fv90x7Hn6e8VJ0i3Lu4U+1iBK7WQVkLydE1VCRtH/cob3G2JF8FBOcNaapq/?=
 =?us-ascii?Q?y6lqH8hc0pLqWFCDL+/m8sadgkCft1Kfu35jPdMWpR1NfpERxkNyW38rv0ts?=
 =?us-ascii?Q?Y5MM0XMTLvSnXpbi/2bSd1PfavdjsLfgqzW6ZQ2cV+ThoCreOPNierxjsTu+?=
 =?us-ascii?Q?2Vl27/7nwfM1hV78B+pwWeIgZgEAZ/2NgltZnkVnMSp0Vd+PNtbEX6DsX+tj?=
 =?us-ascii?Q?1ApbQJ+gT3A60eVdOyBHDJRXYapdj4d1gwXZR4cwhxjl1HH5DYwG6UuKQmYd?=
 =?us-ascii?Q?leEDNewkfLpsf4XeB8hudKOW+YbKEg/Ks9cN/GAsxK5PUdffi5SEaStuTkC3?=
 =?us-ascii?Q?DqUSq7FrBu9R42Fyg1ZuGXedFjT1IxNBGCkzxvFcJ3UH9MPMZv9NyWyxEbP+?=
 =?us-ascii?Q?/PDhUHvY+Vpg0pglquoFpCGeCULekGCkzZWlzZq4njyXhgtufB7MFwVKJY9N?=
 =?us-ascii?Q?nWg+Po79bIvZf7PFnMQG4/RZpiZ7ObcGlcxx1MLuIPtq2UCqlYEmI7unpl89?=
 =?us-ascii?Q?+DpizoUTfgp7Uv5w1vXwu9NS2laLQo7uBfJOvH0k4rfAWJI3d6M+pNGY3Qwc?=
 =?us-ascii?Q?iRKbweLM/pmPSZtG658DtgPy5u6Gh9C4DKQo/fwLEQtBh31+vkhjbYnH+uDT?=
 =?us-ascii?Q?NdX+aENG88ebjyPSi1qDQrg+YsaAk2KD8bJz3CXjcD1/OkitLt4Mdgbf2G5r?=
 =?us-ascii?Q?tRC0qRafQga8ZYYXwjDhMiDmPtd8o4KPh3u/zvv7NhsRO+cLzNWfDW+D961K?=
 =?us-ascii?Q?pmnxcuQkTPiozNLK0EpRW5ZTG0VK7FJrAb0zX3TpGAXUdtamZmVb4HiFaOT1?=
 =?us-ascii?Q?LFryRZrQjvyfX/fDSaq67ZAOxmRsBzYZ+Oe6uaAwEUgK+2PqUGlqr7tS7uTc?=
 =?us-ascii?Q?SeoVJMe2Bb20zsZi+SyUGNtsVbNedX8ESwr7nq8fThNic0h0wbouxQEejz5C?=
 =?us-ascii?Q?p5lmmiud3WNtSQrwlC3OTC7QVSLEDbyiVxySbjxdRT+H3r+6PgNatQA/htmp?=
 =?us-ascii?Q?i+KQga17VzQYeHvcKCY6cqSfMovcm3QpVu/8b3h48pChSEOxGVLasbXwOQDO?=
 =?us-ascii?Q?HhfYhY/zOLYFYAo9R+7vP+HVkE5DXgnsSucos5tgAC/kw3RtnuPgFWFYIL7c?=
 =?us-ascii?Q?xzVNHeB/981osU7RtpaehWQlJGeNHTJTIqGx2tz3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b76e87b-8a52-4a15-3859-08dd1e59b43c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:14:38.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntCRLKedxPkSw/gd5tP4zUzSioGNat0KWxcBHYYwqBZrOyf3V+epCYyPLaZ/aJuHYX7Hp8h7QjKzHyg+Wuc3Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

In preparation for using insert_page() for DAX, enhance
insert_page_into_pte_locked() to handle establishing writable
mappings.  Recall that DAX returns VM_FAULT_NOPAGE after installing a
PTE which bypasses the typical set_pte_range() in finish_fault.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v2:

 - New patch split out from "mm/memory: Add dax_insert_pfn"
---
 mm/memory.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 06bb29e..cd82952 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2126,19 +2126,47 @@ static int validate_page_before_insert(struct vm_area_struct *vma,
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+				unsigned long addr, struct page *page,
+				pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
+	pte_t entry = ptep_get(pte);
 	pte_t pteval;
 
-	if (!pte_none(ptep_get(pte)))
-		return -EBUSY;
+	if (!pte_none(entry)) {
+		if (!mkwrite)
+			return -EBUSY;
+
+		/*
+		 * For read faults on private mappings the PFN passed in may not
+		 * match the PFN we have mapped if the mapped PFN is a writeable
+		 * COW page.  In the mkwrite case we are creating a writable PTE
+		 * for a shared mapping and we expect the PFNs to match. If they
+		 * don't match, we are likely racing with block allocation and
+		 * mapping invalidation so just skip the update.
+		 */
+		if (pte_pfn(entry) != page_to_pfn(page)) {
+			WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
+			return -EFAULT;
+		}
+		entry = maybe_mkwrite(entry, vma);
+		entry = pte_mkyoung(entry);
+		if (ptep_set_access_flags(vma, addr, pte, entry, 1))
+			update_mmu_cache(vma, addr, pte);
+		return 0;
+	}
+
 	/* Ok, finally just insert the thing.. */
 	pteval = mk_pte(page, prot);
 	if (unlikely(is_zero_folio(folio))) {
 		pteval = pte_mkspecial(pteval);
 	} else {
 		folio_get(folio);
+		entry = mk_pte(page, prot);
+		if (mkwrite) {
+			entry = pte_mkyoung(entry);
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		}
 		inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 		folio_add_file_rmap_pte(folio, page, vma);
 	}
@@ -2147,7 +2175,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 }
 
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2160,7 +2188,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot,
+					mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -2174,7 +2203,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(vma, page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2310,7 +2339,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2590,7 +2619,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
-- 
git-series 0.9.1


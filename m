Return-Path: <linux-fsdevel+bounces-35511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B99D572A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898F0B22D53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A031632C2;
	Fri, 22 Nov 2024 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ru/dcUVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894F15CD58;
	Fri, 22 Nov 2024 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239683; cv=fail; b=dNwzRoc0mTvKSZba7ucgigyQ3Ea87pVaiwN/dpz7ouFs2mHbv2MJ+PSofJPw9IGTQ1QC1SNZha8IgTOys4Cr2sKen5cSGelua11xskuETlotM6e+sdmMCEjnTwcLPPvlWEJn0hjkiHXke4KnjG9ti2gazjQTKqC6/fu1X9l6T6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239683; c=relaxed/simple;
	bh=OMskb6tiJXN/oVWhmqvQ06ZN7nbmfyJDrXPM0IWvd4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KT7TcFDrC3jFTEOxfqychkGMnk74/I12bhk4+MjrwEIf22X4wA3GOQbLn9cwFL10RGf+JutzAtaBfK6b6FvsITLsnqeSuSjbtaVonZRHN6aHB4mB8kCwQlEp06WrkotvIjblKonkTPj+HrSfwquMgDQD3/0P4zogb6cK6P/B2d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ru/dcUVL; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHYG9WNQ2IqBx6KlQPGT05KkTMahrGbQmdjjUlGR+2iX+xM18ap9D71jEgQRgGm0R5udJftd6jlXZZfQT/Pk8PRTLCu41i89fJC8J069UjRpyzYGJIvda3GBSfYouU0dcrEkwipAFa+hR/W1QsEYrs211gximydRC7AefGCid9PYKerSc9VQW0k95se9+hYgFst/zbxaNIsQ/zAj5gLf276sE2hqN42el5tp7sRcN+rk/tVHkljRnPvDSoLl6hQKGR47YiRiL5HkE3tEOXjYzZOynqiwuHXyBVy1AhJxYnMcxGCDjG9cJj8HgwgGYiYFdVd/QpRxvWCrDzNPFb4fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRQQVpyhJF5f1obr6Ie6XHXs8vyPo99NnnyCrsA9+Pc=;
 b=KbJYiWSsoYmRC+y6JNvfPgyoQ5u5Tv+JqlAHrcjE3QvVkBINnnUXNBwDz+jyYdykkyMyYGo5AS7inwGNWHVbbgtF6EKXYEz9JXpJU84w0tiMtbwFSiGNKZMnFRxujfX6wty2QaNClKw86Iit5u3vtpt6HQD+rWqTYlzBmO9ScWuUyTzZceXoAX3RrFD7pjJaC15TcqtDU8aP0RKmPO+7YOO2Y1+bcCkIHF6m2q1UJI7EnQWtVHVmB/ySGwmlIgOqquJXnJafY9TnNiXzY8U/cH7kT2fQ5wpqTR6Oul00EOa+KkPX1hWb3IiHQ2/eaoGkC3YekgcS9ZZj27wZnGVNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRQQVpyhJF5f1obr6Ie6XHXs8vyPo99NnnyCrsA9+Pc=;
 b=ru/dcUVLPZH/Ey5zbEfpLtfyBcKkXi0D3gHBAHbW9lqCvD6qaYoTzHspETvR1XZUuivurIfhPtYvz+DQF29/RbW7gOQy2FywKt+Bd0h4WbCOtBIJBgplbxndzpyNQ4bkEahmmX7Uw1fUZ2Mn2BXoFSwl1AiaU3KCaNN8SdmkLhwwaXmWFLblLWkEP+HPrLiVGUX0uuabqiLanleiI6QtTPvndZqOB2f+pB+BeG9h/If0hXV7XLJra6zL0SWreqb05tsC421w4nMWbwZraIqnPKFiqVZMXHWLyN8K596MK+r4VCzVJffCfAH2fkPdBpbW24X5rIWzFyFGU1cp+0pwXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:18 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:18 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
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
Subject: [PATCH v3 02/25] fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
Date: Fri, 22 Nov 2024 12:40:23 +1100
Message-ID: <0884b6a6e0f9ee4bb982a043da94fd910ee800f1.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0041.ausprd01.prod.outlook.com
 (2603:10c6:10:e::29) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 458cb362-5519-42b3-6989-08dd0a96c264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lotqsT2+U5sQkuyJsAawpUl1P/RhNn3d//wZFNzkD3wbRKhpJuhIsilKfgbp?=
 =?us-ascii?Q?Ptx+VJ3pDIhSqwo0qd0IL3Xpr9JCskM8W98iBiqUJzmI6fuTQQ70A3mhoZC/?=
 =?us-ascii?Q?uZ9drGq18rdzvEulORwJjz4IjtIOMHRcGl9gou2a5Ow8wIK8wILf/jbQVpaY?=
 =?us-ascii?Q?MPCqvDHN4AmVD13KLa/9BQD4TnZy6PYFmnDZb0biSvNMM39tDrzBBtwUZY3T?=
 =?us-ascii?Q?dPtnW4tyR6SPYi2e30qiAdXym2V4673aBpi7/LOyalc3Qvzv0wadeFeU6wsF?=
 =?us-ascii?Q?DEVqO7MuUSXIQdCd1bc8fYfAyosp6eIATzKFriYHJFrhATs+K874jBF5HnnF?=
 =?us-ascii?Q?To2VFUOxHPgpSiJWyBVz7qZj9mMC7Q2zPy/zvMZvzt+MAlK3EvFYTb4QZfRn?=
 =?us-ascii?Q?r/cfsIw5R+btV7vQOG6n3gf0kR3vPcc1U7OzzC+7mMO83x3STEaw3rO/K0cb?=
 =?us-ascii?Q?cfchqqzvxLXlAZPOPZw7eYWZjI8PsKLvxQydBIpfGmMOkTE8vzlYMQ3G/BlM?=
 =?us-ascii?Q?2s2XwKSwYg4gPws3dT3EVsWjhN+fTnRgbyj5K+s2D7BPELYNReyShXbtpH6U?=
 =?us-ascii?Q?Z11CQyREOaXuyCQJM5P0iDrq7pqlZCfBQkcODlfj+iOT5HFDFSTKqlopCiLi?=
 =?us-ascii?Q?qpgMhEHpp6eQogY1GoC5JkH3fIu1Mt3+WsIfuOkziky/llY9o4o3ydKBxdHO?=
 =?us-ascii?Q?hVyz3tRt7bPMTjLPt0oAtuKBerqa1N1lu79CtW76IHMlV+pAGej1uAwN9fBo?=
 =?us-ascii?Q?6oWxV9kHCfSTPLVfyz44GEPaTLn6663oKJfjqbvn0c3A0z/6fvZTukGzgOlS?=
 =?us-ascii?Q?pi/+88CuUIeUY6Y92WQJf0ZOuWxNCPU9Yvb1Kng2iJeiwoGDHrigfgIVYxn9?=
 =?us-ascii?Q?QwH66PAMmXqk+AWXgubK34Gluq0oRwUZ8saAFe18QbvTHzfYVTNDpihKcq6M?=
 =?us-ascii?Q?h8S/tU1pjvQ2I9wewdSy0aKb4OH26ZPENTouIroo8f6eEuw6Crqg+mkcW7lY?=
 =?us-ascii?Q?j/SgQESWJyp9RQ5Qsode6c7gPcK2qlMky7hXoonXd5WUgbvgQbGGKJNOlXAL?=
 =?us-ascii?Q?MFMlPH5BOlN2IjMSGf/Ob5tvafXSdB6n7CAajEHQksFe7f2N2+O0PKbhays0?=
 =?us-ascii?Q?oqCwa4/db1whZQEQETkwZRg/i16USpCm/IXIf06PFXO1jleE6ikpyi0uF9On?=
 =?us-ascii?Q?OZNBGBzZeXgQ7Jg27BX18K6UAIBr3CfHy3DNG1gIhl1FgAwPhhz23/4l8lAw?=
 =?us-ascii?Q?+/0zaJf75BC8PHw9a9Lycccg09V2w0OLvcIUCEqusgYJfQta1OqUZQxISpH7?=
 =?us-ascii?Q?/t6iqFl2Hd1xckqv05kK9vOq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qo5EiwIy0duwWJXhdBvjXurhaIUgop9Ug1ppvroOJfAjPND9hA4byrulT1vF?=
 =?us-ascii?Q?Dwy6/bXjJNicwwZGBivvM7xAB9omOIhJuVBDHL5wXSQjAqct43V6YLa5O83c?=
 =?us-ascii?Q?sa7p7WMl2Q6C2DdE/Y/alhufe9FDhZMY4aEdFQ2OxaAY/NnTcjFrXafdIk2g?=
 =?us-ascii?Q?+pH1THOr6t0/jk2MaJ6X4w58ETaVvL82HSpxcVSnjc3ITOTXg9Xx/FrDRBCp?=
 =?us-ascii?Q?ChU8Jp9yofqG4obt6nrO+/GBvmCVF6Jtxa7iHqAEVPUjmz+s5iHd0RU+XWnI?=
 =?us-ascii?Q?72P7syL+B9NHZR7Qhndv0R86M8eFHNR1WniIN3T/lY66bkljOvZoq6rjSTzj?=
 =?us-ascii?Q?+cGsel6aNgbYo59TC9DIhuUuDQzNfGZCnjEx1LJ7LcXS8oLGssVNu6YWJY7M?=
 =?us-ascii?Q?P/YkPSREX5IwgWLy0ZKGn6DIkUTVp8DREUTqfN+sATJg//oJjqzP3M7KB2nF?=
 =?us-ascii?Q?YL01XHUAPgUxK2EHq5JEBKk/CqLRPHsVX7UuNG4gWQPJGCj1qiYR7eP7LCdy?=
 =?us-ascii?Q?Du3fma2zPvNFoJaiCNkp2gWKtgG6AU7DgDU3HtoicLaGZTgsENBgtKB3LHJP?=
 =?us-ascii?Q?z7L3yPv+uQYtdnQIP9/LfgBSeCbcJXiSIdlmKDSqvOBLJ52/mghxMU1EX2fq?=
 =?us-ascii?Q?Y542+bt8670DKAaBmyQtKTmruoX3PNTu31/rn4PG1GTxIUev/F7cEXQxV1t7?=
 =?us-ascii?Q?CBqekKxRQJAP/r5U0Q/g7zcqv80ZtbItxOl3Gk6NJ804ox1kgBrq7ZAmLuUA?=
 =?us-ascii?Q?cVCQreozKYNfPhVHTPAeCGxd+QqqZseqZk/oxg+uFzCnWam4k+uT++3ahjMQ?=
 =?us-ascii?Q?KygCd9DGcqRVI2jozUSxnFKuVbXNElXd+lR9Ff5Cv/x8hBY1eClS6sZmIFLU?=
 =?us-ascii?Q?6YJ3dozJrPHusaqKhaSGTQJ7J8QMdgdmimASB42FOiDAjocydG0Ur/iSfjme?=
 =?us-ascii?Q?PXxW0eNUPBpikQjDMjlOD3o7Ma5JhEJBtXY6PwzhAohM5I2EaNh5SZ0+cA/I?=
 =?us-ascii?Q?KGZzAQEgq9RPVx5VRPthT1exL2otM1Jxi5GH6TgVrWBtB3Tmwl5B8/79fm3J?=
 =?us-ascii?Q?2+Wc2rHttVV7LFT51ZzgzXArCXCj6stbwBEtnV071OELdEPglpJMNELBsvRs?=
 =?us-ascii?Q?TA43h0CILCsFG1MfuHYt21Cy3imluQOkuwidaaJwN8UsfZW97I3ixi6j+CuR?=
 =?us-ascii?Q?ezM/5vv+wuIaXjJblnp/j3oWVgANVxXt4n9zSVYkGnwe5WSo26hsosWVg3/O?=
 =?us-ascii?Q?QsI0hIrAPZa2Ceo4NhHEdfQJQeHm/Ybeshzlyy/hPlXw292wTtNZVXYnvzfM?=
 =?us-ascii?Q?NIm7ydUfLHoRPtQqM7Q0F2KHjHA23HzbhCqTpZ9YdqasrP0OMiXa35pHLSTW?=
 =?us-ascii?Q?irF/Q6afw9pTQHLT5x4f//6TGEc3QF/IKDRTSwVx0Zz6Hq84MWbW0CpxvEW6?=
 =?us-ascii?Q?CwOkh6d8if3jNt+ySqiGd0V8kR62l5NWiWs57rMU8G0nXznJn8c7hzXbD4w8?=
 =?us-ascii?Q?in1z8yokD32Z6zR0iTVsc5zgVleLXYCtgLHXRH4Mi+OMs3W4HUeV1p2kVRRH?=
 =?us-ascii?Q?MgsTaJo8H7EQcj8q+XnEkDRKTc4R2D07gw8MTVYh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458cb362-5519-42b3-6989-08dd0a96c264
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:18.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKerGv082UjkAIE8S2+bAoi9U3PeEL1YGlo+2SSuWtVgBJ24Ok1liWEjhe40UXyOcoxk/vlhCYlxiypfY5wHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

dax_layout_busy_page_range() is used by file systems to scan the DAX
page-cache to unmap mapping pages from user-space and to determine if
any pages in the given range are busy, either due to ongoing DMA or
other get_user_pages() usage.

Currently it checks to see the file mapping is mapped into user-space
with mapping_mapped() and returns early if not, skipping the check for
DMA busy pages. This is wrong as pages may still be undergoing DMA
access even if they have subsequently been unmapped from
user-space. Fix this by dropping the check for mapping_mapped().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index c62acd2..a675eb2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -690,7 +690,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return NULL;
 
-	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
+	if (!dax_mapping(mapping))
 		return NULL;
 
 	/* If end == LLONG_MAX, all pages from start to till end of file */
-- 
git-series 0.9.1


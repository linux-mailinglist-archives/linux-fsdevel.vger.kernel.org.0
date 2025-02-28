Return-Path: <linux-fsdevel+bounces-42805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B4A48F38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D051892923
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A5187553;
	Fri, 28 Feb 2025 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdZCsdT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAE13213E;
	Fri, 28 Feb 2025 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713496; cv=fail; b=e2gHgJaWxH9uqJa3zm9gncUk5QPSvhuwScory+TgJ0zts0Y5c0RkizVcimkGZECv56megdUnDF6HWvZu7GnaxP55Kn1QMSP0CEknS8hYZq8/2jTGm5vwyB9DBW0vkVJIjKnXUX7eNtiYQEL3AMhV1/BJwKGk/KH+fRYEZRxJltU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713496; c=relaxed/simple;
	bh=ZYIms6S2C4O6hU49b/BIZ6D/RvqTOmpsqbzgfZzGbwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kpy7a4+0dg55725pGBreBBAg5e8snKhkgce1EBs/tkyBwEWgdTgosZJjj4lU/aX1bmLrCYfpsy7RHAQObTuA8L/4ra1y1maqNcFFMybi9yRw/a0t8In5xWejnVrWKH0MQ0ctdTA94i5NMRi8C/RJO5Gb1ZNWxe9JZ05+BojlJVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdZCsdT0; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG4s7VmANFJLBlSqoRgu9ZsawpIGtnbt0AY4IfujbmcoB27kwPiVB7Lidm05m0+2bfhRejizIelIg6sLg77rAAZcSsAYMUI6wP7OQSGG+VXCmXDMAbarR7dorB0p4Gv6F0LpguNrx8WmmR006GxOon5uTCT/xx14MlhhfrQTuW96rHuBe0wPY5grx4umlbL8XLaTv0NGH5sGx7lrbNZ6E/ejZICq9JWN1o+LyVcDh82iCemmF4YIk1AiG0zhR9SIBoXmHB0X3CRE4Z2C8ueAKKoXV+rg+n70MqIcZOGwp1KWErTGbvMklK0pTGYOL0XHMmRgbo/pPcRLAEtg+dxf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+P+HGRiqDCmj10CrZO8lY35WcAxWTj70gicDvDjINU=;
 b=AxixWnNcPZj28LPFljghMk+iFNinEBFTobh+VCBWtroti6sLzSM3wgAXG2+dgW/yTj5EfXboK9arLnEqaehQinWCVvbR6BxIn/gpP+NICFoxJu4W1MLDRWKJWICQP6IYgCB3x561lOwQloreyMMz+FKV+6RuV4qd49undYvg69TqtEaTstFDxNzOAfpMkAYfNEQuYOiJvMeVxq0ifcAH9xo8J0bPhR0zOXJAuqkgnl8qikpW7obpfOjd0JKez1q+uq7ld5iNAKyH0/BQ/fEGOaCso++KReATTVsnzeimn0uYXUfoc3MsQplWFMv8pwUaH+p9lzHRDGMEQifzH9/bEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+P+HGRiqDCmj10CrZO8lY35WcAxWTj70gicDvDjINU=;
 b=cdZCsdT0P2PlCAjPedZsDgXhgTlE7nz4PrJw2QpYY2zoXqNJq89E3X3arDp41JvxHQw8+nYaQuVP5sZtb1DuKNrWYxAmSG/mVotZqIv1Y6HQrxWQ95Y56+yuea5FS76YAD8mhM6W22KNL1suONUB5cO95xkEghPlozh1sgS1mE4xP7WbJ8yhw0T/J8+8TLL3pNiDADhaupNFd5dTxeit7MMw0spwVXEg4sjL/ltUcZ75tnB0EHTR2Pyy/7zKincJG5Ua8QI4XgSg+Uwh888QN00Hlf+xcWQsEs1/WlFO7yZx+ppfZIV62tzCUh92ou1+ftsNuFs9sDAwcCvTS1SOag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:31:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:31:32 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
	david@fromorbit.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev,
	Balbir Singh <balbirs@nvidia.com>
Subject: [PATCH v9 02/20] fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
Date: Fri, 28 Feb 2025 14:30:57 +1100
Message-ID: <d85ce6c2d1400ff111ed7302d9eef223d0243c57.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P300CA0020.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 8801b662-b1f5-4b0c-987b-08dd57a86518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OnvgJFBRUSNrk+CBJHuQoT8NVAHkoVi9OS/BjpsH1JzkSouymwduqXKnzMnV?=
 =?us-ascii?Q?dUj7BgBHV0+GEe/mYKRmzUk5djSLFetqJI0/lnxkm3pbnDLw2l186rYqU7EV?=
 =?us-ascii?Q?9PodPkGQqScytyNopv+My4hSSt9/e/KQDX3sQvUirPTPr/+Lkml8PVXQ7Cua?=
 =?us-ascii?Q?rhkmWm+xlWqflccIasdGl9uqoqS6VWc9Co6Wnl0ni+KIalfs1L29T7z0LlXf?=
 =?us-ascii?Q?cNsfc+KS/9k80F17883otU6hNOI4kmHa8LddpZnDi6fQzOaJeLLP+3cqdK5I?=
 =?us-ascii?Q?VzN9ZJLXz44bOZvP9cSxWfaJyHlCq5JLK8Z1idEGbhCeMZVqEfoH0BFQckiN?=
 =?us-ascii?Q?iQMRLHkYQiA6Mi31xVjj9JYhdyaNlCNIe/KPapP/ylGt37PAaVIu72ghqrnw?=
 =?us-ascii?Q?SK49aOt2VgUjkYe7Q5DzLdI/SqMO2PyB3uBpBM5seZODHGg6NZY1mGp6uZa3?=
 =?us-ascii?Q?AWaIzg8K2u79dQ927SEqwSoJHQpSMZuRHLxX39qnel06YwLfYfdXAwIS7S03?=
 =?us-ascii?Q?STgOK9bE3+B5WjPf183H9BBsxVGk/rbxgszUZLc7OxHHbsaMj7GzGSK/m0hc?=
 =?us-ascii?Q?2iee00fQ2HGfIdSMF2DDzLLsGJbsQ1nlsjL5d3FCYTDcXOjCzullNx0DtwTh?=
 =?us-ascii?Q?iNfb0NGcpJotbS5o7KjulnxGn+JABl6F9fwaIHXLXdwmJ5XAOw44qkQgKIeq?=
 =?us-ascii?Q?R1bfmnGU4+rWX2uwFaPdnUaxzQZrcMhLjVhSAZ1RnyIyK5iFV+/zbTo/44Xb?=
 =?us-ascii?Q?9uF4m+DV9uAaiVGPE+Tb/0Y2YyfTKGzlSkvDiYvNCIGGPmEJToyO0axQgZZF?=
 =?us-ascii?Q?QwF1BsCq0bF26FQenWxnbe+oUww/Oa7/xblgOwrtwrWfmPUbs07dpWIR5XV+?=
 =?us-ascii?Q?E52QjUmfuwJLdjM9FMJXlGnuQjlkD5YrogZs/FBIGhYMR7xeYYBv+J4/aGtE?=
 =?us-ascii?Q?HglveoGUl259iQxaL2s6p2P/0jbaCO5ejVLj0HBPvKJCMQXMgkJ9TmXd9sWj?=
 =?us-ascii?Q?K/lIspJxYzv1gCDmRx6raeV++wreEehgbkQ6kKeks2YZvMt/0dS/GFNPlsYU?=
 =?us-ascii?Q?54fJ2MIfbtrGMdxMZmfsZ9cMj82B6KszhIxqRYD8Up+Fo3+NaHC0HJFyyFZK?=
 =?us-ascii?Q?n5nxz+zitehx5ahm1PYlUdAILVHtqY2edHGInUGwJMcWO8DLgi3f42KRoIno?=
 =?us-ascii?Q?iNl/EgyC3uDxwwUORLgGB9hnfN/UOI37ZW7ymaWXJYiEd/wfO7JB2IAC8/9p?=
 =?us-ascii?Q?BWzn8KRYb4LLBY0DuXYcxfAtl7ALpVEedy+H2FdZxGbu2gwLei8q7cebiwMR?=
 =?us-ascii?Q?CwsXd4wEE5JBMVJNbGBhG/1854GQGm3Ub8bt21g1iAzlF88MuWHXmwNjOnBE?=
 =?us-ascii?Q?+4DCts4MscLlvPzOR6z3qOtjUHv8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BzhKb1yh3yhGY3YTI0N0ICOqBFKM2XTWPWXSfYrwxu53r8ZauhQRgB06mMn?=
 =?us-ascii?Q?OL754x+pIY68/nv+6QeyBrzja3SCd+ZmNjVtA1Gnk2hw5rKra1ZqcnhWHGaN?=
 =?us-ascii?Q?5I7Qk+xQjfA2xA63AwM5q3rR/KaRdBAuoROYhCHQxanT7Z55WAbQkV6X6v1Z?=
 =?us-ascii?Q?CZkkA6F+7QG1lrkqrwy/wDQeVpr+BQczdXq91+LXrCE6XFcpaJIf9S5b6hcr?=
 =?us-ascii?Q?/1+dhaHmZAxfQGGrZ2oHk8DQfOWYLNtquKEkHlUaaM1CaW4bIQGzpqGYSVTY?=
 =?us-ascii?Q?Hw4dEDUklA+pf94KUm5NINbMBpqzNl0eJRUgCtYgrfyV/C9tI6NqepzSUGXo?=
 =?us-ascii?Q?+9rAUxVCbJ7OxLOiXaKtmBu+A+7OFtPnkskoma7SOC4egUQAqCGeuWHCeo4Z?=
 =?us-ascii?Q?0LjLyluVM0Iw971ov7K3bYEoDo4/M1Y53QZjG0lDj1TEUIGdA96NbKybw/s5?=
 =?us-ascii?Q?/M2yssjU5tg5OWQ6MmLkUTiE5irkN7BCy99ph6OAv1TBubnwXEPV74vu71RL?=
 =?us-ascii?Q?hDv2YtnM/RuBWOuNABLTUdYXngEshcwvcEXwPmK7F9wDisFNZ48SqjtJfCsz?=
 =?us-ascii?Q?woN+X4yO1rGbtZTtClabJSaXfyw0ENGxkPeDpREQov6yV50IbkJqZPN5oXFT?=
 =?us-ascii?Q?ie0OYz5wGwSmu2rHsq0bvLnYyVHfeoavcnLbDIii4Uh49PzBtyDC14nzHg6P?=
 =?us-ascii?Q?uBgf+NjECtFdQrTCBcUCQPAi4Aowpz+RfcnLm4PCT5SMgT2dSWdoG5WKr3/U?=
 =?us-ascii?Q?+JvB5F/ZOdtwRJ3yzO36L2t8rJo3AJPVd1D9u+iueNWkb2h218WfY+scnZ+I?=
 =?us-ascii?Q?j7c1CXtgIXeRUJ7rIqDLXb61YSp5ZpQbSMBLhwEUUZX87I6a4D/dfYvbQ47U?=
 =?us-ascii?Q?dOOuytvG5X3Kzbn1q8sZHTcLAsHt+pxCGHQm6TDHUw4ZOs7x9RMKTmHrAvTy?=
 =?us-ascii?Q?M4nrS7VcJN4c1OVaNQE8ycveU/tw3ovjGKSYeJN3XNUl2H/NDw8lOCDE6jyo?=
 =?us-ascii?Q?n19taNZ4CCp6vfO86rHo0UB0Zr/FdwbZQ+M+N/69p/lYxZ2ATpldNhT+IBwF?=
 =?us-ascii?Q?vRTFv7zpxWQSYD0pMrf4nW7lD9ep1jVLij4dfSAmFtfFSkJZF56SGcOUaLga?=
 =?us-ascii?Q?zEOgDxLdFGaWA5PHMNTjOnRTjExfucNhoxBTP+v76A8g8rx9viDJl64XDYTk?=
 =?us-ascii?Q?1+VLCNFDshCIJRR9d99MWtEkwYcW9utZJJgkFDxQKxyXq4QZZ7vRS9qTEba2?=
 =?us-ascii?Q?53hCTbgs58oeE1gTt8Y1pNuEF6qgGmC8N+PFsnqtE/qWkzeVXmsM01Rl26Fu?=
 =?us-ascii?Q?UrtpQhArjUjO51nnQtwCJHCyTNyJz9Ovek/fDdxt1BWBujBLeHyVZmdGSEgy?=
 =?us-ascii?Q?jQu2PlhXKwq2gyFo45Xtq1AmuPf8BND3sOb4pYDcDZwmmb1HrptQRaIUR9SK?=
 =?us-ascii?Q?ZHMJTLFCKA1ciVs99T8BrajSalBRSytGqZkBCMeugBEF81D7MJVPMGVBtxG2?=
 =?us-ascii?Q?EOHOVPcl6m64/JSXLa0WXD54d9f73YDaK0flVCGhQ6Y7yY4YJE0/FqNwMKBb?=
 =?us-ascii?Q?H+a1u353czIrpGa8K/OyDV081lXV9r9Cp/IyGZ0K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801b662-b1f5-4b0c-987b-08dd57a86518
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:31:32.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJ29k96Fo8a1F26QUQZrW6KIS9VqCNXptbJPD7KmfKxJZGg2sYX97UIevZCLhLU/9m5w4/EjVgcEwCgQ+XFHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 972febc..b35f538 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -691,7 +691,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return NULL;
 
-	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
+	if (!dax_mapping(mapping))
 		return NULL;
 
 	/* If end == LLONG_MAX, all pages from start to till end of file */
-- 
git-series 0.9.1


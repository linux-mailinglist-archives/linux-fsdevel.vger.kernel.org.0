Return-Path: <linux-fsdevel+bounces-38531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E6A03659
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820DE3A44C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8441EBFE2;
	Tue,  7 Jan 2025 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lEf0PGGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA931E9B38;
	Tue,  7 Jan 2025 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221451; cv=fail; b=E0M39epEb+Etelz30Eb0xH20Rhox82ykcsD5MXEDrHwQ5SZPoRbNMpxe7nSmsO7kBL9R6QcC1WRK7LLL3Sb7znhi8DDj2jLuiG0uFCHfZAWe8OLmalq87PMeHcZmY7AiijRxQKEMXcf2EzxioJfUymhVBR0pXNjMDPqJ/RazWNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221451; c=relaxed/simple;
	bh=Yl5qhQ+0i/Mb9Z3NsjzpQhLk0MtpboKhGirTbENLQuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KY08ZA3/SCB2hgy+JftYhlu8I1kyiEcIhRkqmKmB62rd3uaTB4u6wT0B+na1SU24L16DH9WIGPypKFi104VeWtbityaNrk8NdvDItzEBsUQGBMf0QZOEWO74q7k9asNLYGZyK6X3pvKAVbsJwItF75kShcwTnv2RiDeE0nLYlJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lEf0PGGh; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMyPLKBoE59LIt4G99CZLWJtUoLcwz8sZRsC7lRfIqA1GbIzZitekJUIfdc8QimVspPkUK3tTCZ4GEjc2kPZyWyT4SofOZpjZ6Lufil8Ctgvi8TmUQ9tpwa2j5mcblUz4zls+Wl3iFUNDhEwaBCRjug0xf8KPu+zo+8DQc8wcdy2Tmwxw7xQYGlN97ZF8oJSm9xeAg7Vcitbx980dY9Y3xKReLP+0R4BWjV2GSz2/0iQs3y5NNe6Y+bCFSU+7aaZypobRO/PmUjFGMjzU4j1IK2Sn+BSiT+Wh8nwSYESyYjukNLIdi2zWNy3YT7UDI69QTunNPxxPKWd69qjWsCx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHF9yIYFSBkDrWWm5Q2w+o+FZwVZ6F3GbxhCIiJOiz4=;
 b=kaR0IJbWAfP8b7v+65Aublafrz1nmYZfTZSiZYE2Pa7ZyBgGwsDEf5xOZH1/AtS1XNk9ibGhXkAaLkRAO+LFqgaTPybkAyZTLY6LKCttVam52bt1DbfmGYlh+Wj464zQOYF11Cm/8Dre3tNeqv41gYE1P439YXvxUKvC/0W3Q6q8azQpGy2bPgqrM1MM81kLXajIhqx5u9BkjUQ+6hOxLRHvUU+gU/XG/zK9me2vub1tXciyYdEUJ4Fo/xmC7RkJSmtsVCPPGp07fK9Qx53GHLRoQtccER7asCV4CIuTaK7nWj6CKcIDTrnUOTB8Mp4aZzZO/IEsx8V6Wxths4yGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHF9yIYFSBkDrWWm5Q2w+o+FZwVZ6F3GbxhCIiJOiz4=;
 b=lEf0PGGhdWJbpVwPuBdIJBTTEqJuCdZ3bHLLeqjYTOlo7jBQh2jUXt0hpFWt49FAH7MteuLKLRfYrhx8ECu7Q6cxV5tosoC3eC0UCkHFNaUXLYfq5cCqWUBSkO19N81gtwS6MgfZrGELd7ieVANkkJjCV3w+5BNHJgpOdZH7CwlPLY683QnRQCi/ik0QZzuT+6iS1IT2Vd8NCmU8RSP3q0EjI+lkBxgJJ6GdJiPnals45yz0G7PQLDsbBHUCryhIVRhIGqD03pD5J8QCJPrh6dRqKAwfj4TFBZ6J7dYwuF+MP2I1FOeTvz6W6Bhfwo5jNaObCtn/5LHgikxqAWlaxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:57 +0000
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
Subject: [PATCH v5 13/25] mm/memory: Add vmf_insert_page_mkwrite()
Date: Tue,  7 Jan 2025 14:42:29 +1100
Message-ID: <0b56d4b4da706ef6e7194b1776fda54ed4c21599.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0175.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::26) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 45555fc8-2d57-4e6f-b271-08dd2ecd83ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgg21V79Uamq8I6JtrQ0BkO88rPpNdUvjrEYPnCLa6nuLPWaw5mvlUYmb+Ur?=
 =?us-ascii?Q?zE1OeWZpTepUrqjZI/ANWyAjew/g+3dysu5rUoeB2g7APfTFu1EA6XwxB5Cw?=
 =?us-ascii?Q?4rO+XIFJ2yzd9K+25Cvug0Kzb5KIdwzwDYBxuYqShCfvoTj7q3xISuqXgp28?=
 =?us-ascii?Q?zQbFA7QX401r/4rCMLgGrZAo6vEMwo4/iGRAR95uBMtxWhQBtM5R0AfGDkJ8?=
 =?us-ascii?Q?Lv3+ytNF3AHWrlC5mmFAPBMrUtu23DrHGIB8QTVPT97Y2w5k0YWjeicUSgLc?=
 =?us-ascii?Q?SxCUblsIW7/3E3xLWm+9ATBggkKhIT1Gx1V2lIEJpZUOEeqmxVOzXud3T3IO?=
 =?us-ascii?Q?J3Eew6jFVTjT2nsI/J2z60n0niDkyTcl+nn4VdBZdmXSgKiiHwTO84OAujCj?=
 =?us-ascii?Q?BPB5UtymA2KIPb/GtePfxsckZ8hK/+ONeWxPQjJmmAjOGXWiQUYmD62dNgLq?=
 =?us-ascii?Q?l/aw33KrQvkjRbdVA7cwwokjUCupvqu86zTQE5VQOBULDCFZkw6Qht4njo5d?=
 =?us-ascii?Q?JNbvHDGyJbOwe239yhnfn3dnrjE4vxa0Ky8s+EmkfI1l+IY6eBWKCStSV8Bf?=
 =?us-ascii?Q?q5UxASCl0aMrNck64ImWUwCpHoJirSioNcthDWFAohjQSUDValTePmyp5D5+?=
 =?us-ascii?Q?o/hTGhnpVCYiuJoFihV5kKegRVOek2Jwj6ZsAIgk98RonKvPul44gvqOjmes?=
 =?us-ascii?Q?Hzakf5vcj9xCE8iAOLuoEFaTp6MI/UdbEI/rD+H5RLh+bAbS7gIMVntKgIXE?=
 =?us-ascii?Q?DN68ZjxSFD7We1spBU6f3AfTFeNaT1oA2xJ/aTu4qUKeRwTgjKCMWy6sPDag?=
 =?us-ascii?Q?lG2c1MA8Ag3CgaZxKEfxiSlTWlLPkPkKxpx0SD56ahN2LNWM/6BXroU49hMd?=
 =?us-ascii?Q?c2ufn3yOeATIMrM7KNDhd+3rz/kST4Ym+2EspC4Hp0E05ja8Zitg10pryK+L?=
 =?us-ascii?Q?tRk48eUE/wVQXFT3V7LLwEI37RwmDLcx0+EfjOZOH1oWA8GFik+V5A/qgHkv?=
 =?us-ascii?Q?4qGAYRLzcqRRelHN41pWufotfs7dQd9EGD3m3eGDqTmZoy1SPGWraU2P/iS0?=
 =?us-ascii?Q?nHX2xT3V4SsP3p9lQEPPYvgOwPh/WTnboVdnePKeoKnfRRBxx87io1z/a4ns?=
 =?us-ascii?Q?+J+RBh3ra1KgDrUOlcK8pCVqibuteIaoMgn5RyrxAs5j0VAcZzbpZzbXkWKb?=
 =?us-ascii?Q?q8jN4YioolxKwYhkIwjt5OEx4lBISGznzS1BPU07SLfNp5CRzdqANi49AvST?=
 =?us-ascii?Q?NXmpk6Ly4j0VtfuehmotR07Avvj1WhRv2A6pA4Z7hwyLcyBWivIXQAveewiD?=
 =?us-ascii?Q?SQdmOAFz7xlT3KQE7QIVCoctzx2r0UB6bxIujLnuT/C/GfMG0TdkvVKgNiLo?=
 =?us-ascii?Q?nfmc5gl8ET4o9ev3vi+3GwRoMUVW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6+N71Hi6maW9GWlTnZPw2KDaZ4TvS6wYocCN+fz/ssBPyCFTiIlQ2ihJ/VHl?=
 =?us-ascii?Q?XmpMxXBZ9SKnhSWNsz/lPlZjJ6Qcz152z6bOj58Oas7K9ApKn61aQncjn6ik?=
 =?us-ascii?Q?xaOVoo+W84BFiSk1CYTi4ktZ+koNqaYumPxpeWBeICwMEXsCbtpx+fPtgPXv?=
 =?us-ascii?Q?hls7uTqssllKZOHnbbJ/8RK8Q5p6J6pkC68QQQCgA0PERzwFjMB+DkeLzW06?=
 =?us-ascii?Q?2E9GFygT6jFIhUhVEiX+j3oKJ7o4Iczs/8IbN3Ycr4xfjRWz0qh0G0avHbgm?=
 =?us-ascii?Q?5eyBEvo6dQzfislqf1Xyah8N7Mo/5PGKdVaghITvqSjxqYa594zv97N4XnL7?=
 =?us-ascii?Q?mJ514a6y8zljVIhhNIvuoH9TLFSux4H0oQ5RGKcBbLIrL33zrYXEycveykTI?=
 =?us-ascii?Q?RvwG/vMXZM2pyr33IoBn0/SHnBKhgovbmlwcMLx0LCfK8UFX1/iZ2Uiplcad?=
 =?us-ascii?Q?h5SoJZEJu4ccMfNNhWNqkv5QXQV3rr3b9KP2FiYkYVrOjlglHa9IiMct/nAK?=
 =?us-ascii?Q?mTAmDSh19NYx9AVrnO6jRoYuFSOR6+OGecmn60UMCByyImmTGkWwx1bECwLV?=
 =?us-ascii?Q?dp8KKgOhR3Dm2AfDXfo4w28aq6+SOmvIplDvxlTgMrNnppzbiO0sujFeWiu4?=
 =?us-ascii?Q?fWb/ChyQe6JzvJftbfT26DNjTSx9zIPtJy6Kh7uzlbsrvFB1J3btKeyEeudK?=
 =?us-ascii?Q?ZXsUm83mCgD5B/jTIh79vxs+SNWU+PlQ54ARjRSDccKF1H/y8RQQaQk8rMCn?=
 =?us-ascii?Q?2as36mzMbtZJNTNlzjpxKM6tj/wmWkYQTGtLFXzE202/UaJLLIC4hpI1tHrA?=
 =?us-ascii?Q?wU8cn8bA6Sq1jZqRn7kM9nZpSu6aDaKcOE6ZbNf5kClLRyLIcWwsQDiXIhYe?=
 =?us-ascii?Q?rRrbhIUiUA4zbFl/1Rj8QvARQVVfYXHnUpXjNTs12AjcJ/sM25+9RpcT/LqT?=
 =?us-ascii?Q?BUZHVQ3xjxFWrJHUGEinarMyQ49ry5b9AEWzesn+edosnf8+oYev1jOkig5p?=
 =?us-ascii?Q?MOjIadPq4G/Nm9CxGhvuJS4u+mfEx7K9hVeNSd6nT49Q3LSU74D0InIKe4t8?=
 =?us-ascii?Q?9rS77HrszXcomfrAziV5CN8/OXPkYpYUSVkyjjRfEiFEVKXuxJ0BtH54JIez?=
 =?us-ascii?Q?PIPEXv5B0YX3ZC9s/MdfomJhReGSb1A4RWW5dAOIgsN2mIMRn+FADKuMFG8+?=
 =?us-ascii?Q?1rXiylblV1vfcSitevABpy8apb36uzkO4kq3/TLzDmbcfjxcXUSEnJ9/uuR8?=
 =?us-ascii?Q?nhoWWimhJmLjvocfB8wdpos3kCk9a5z/EF3l6WIv4tV6eK48gBGvNRnhKPyF?=
 =?us-ascii?Q?itqvoJwpoWpumWQDgC+jhTqsb/mrJw2+aBg5Vv7YHQiKbfzDfe/vUOkREw53?=
 =?us-ascii?Q?+QNIEv1GzBvHm3cuaEnDgAimZePuLKvDxS9I+hFrOZA5+b3Y0Am6jrcUl5Nn?=
 =?us-ascii?Q?uKrgBIwD2gSGK8wxkL5ZyhI/nAbuP/NJ/Bx8NOv21Gho+zMceq42+SNNuy5V?=
 =?us-ascii?Q?6PMyuVvZ6sL70iFBMK39rxrN6RA+C++HtIofjK/DqJ36bx4JtimpYPQGNICi?=
 =?us-ascii?Q?nF/m4GppLRWJnDAr9uXGDtXTLU0fuM9yEmZf87nR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45555fc8-2d57-4e6f-b271-08dd2ecd83ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:57.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkOhFE12aQ6VRjI9DQWXrGWvmyf5gntcxUPAzhQFXDMgXinYOB5POqGXcz4De8Nvg6ro2Ep6k+HuFJvmt3R3vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
creates a special devmap PTE entry for the pfn but does not take a
reference on the underlying struct page for the mapping. This is
because DAX page refcounts are treated specially, as indicated by the
presence of a devmap entry.

To allow DAX page refcounts to be managed the same as normal page
refcounts introduce vmf_insert_page_mkwrite(). This will take a
reference on the underlying page much the same as vmf_insert_page,
except it also permits upgrading an existing mapping to be writable if
requested/possible.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Updates from v2:

 - Rename function to make not DAX specific

 - Split the insert_page_into_pte_locked() change into a separate
   patch.

Updates from v1:

 - Re-arrange code in insert_page_into_pte_locked() based on comments
   from Jan Kara.

 - Call mkdrity/mkyoung for the mkwrite case, also suggested by Jan.
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e790298..f267b06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3620,6 +3620,8 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
+vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
+			bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 8531acb..c60b819 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2624,6 +2624,42 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
+			bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t pgprot = vma->vm_page_prot;
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long addr = vmf->address;
+	int err;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	track_pfn_insert(vma, &pgprot, pfn_to_pfn_t(pfn));
+
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * We refcount the page normally so make sure pfn_valid is true.
+	 */
+	if (!pfn_valid(pfn))
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON(is_zero_pfn(pfn) && write))
+		return VM_FAULT_SIGBUS;
+
+	err = insert_page(vma, addr, page, pgprot, write);
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-- 
git-series 0.9.1


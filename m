Return-Path: <linux-fsdevel+bounces-38523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D589A03616
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D7818815AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCE1E22E6;
	Tue,  7 Jan 2025 03:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZm5cM4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB31E0DDC;
	Tue,  7 Jan 2025 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221411; cv=fail; b=QsPCWErKntgm/g31cU5s+3iCeCIkiPRvVvBblnw4mHKw9f619u0NJlNO58GI5U5CEFT90coOrbvELmPUqlWT9cFEpCT+/xi/MafyUHbfl/dXN+aEEIMFZiPEMDUN7SnjPyXe+dAsGH8Yx0VT3c1h+FQ5XwHcCK6OvfQMMfHPFmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221411; c=relaxed/simple;
	bh=/5n3yCWJV9TmMlzf7vpreB2RFaYjdpgdl6mtLea8VD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgXkeHAFJTJDkDRWGNdnEJNt0kbwVL7clbDuUCK4TaOZh5SZ2f4JGLrkoQKWcWupf47r5zNU9s2QTHILVnwOBME7HT8N8ey4OpWvIBFxraRcL/eFLHF5ee/2dxGkNi6GnaeKpaW27OHbknThNJKrZPtXhupIN5RwNz8jLKgJQKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZm5cM4n; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRiVJr9/ofooDOpNj3c/oIVuNUjD0v4r9hgoSx4PkDypvpDZR7mRbClTln06oCLc73TJvUDBUXFs2WtXyZ5lJNk+9BDSW+Jr2NlaRis2JzL6RIV25JpYwlsUB2cr+ovZIPgNhmAoCt5M6RDEo2Lq0tF4QdLgZwqUcrhFd7RqTyv+7wyhLEj7tMVzA66BmMlYaCIZTOXqHBS6OQYkHDSfu7h46pyamOyd8ovTmtMmC/XE1T5hrajpNAuPqWNLfHIlnFe5YxcDQ0w0xPSHjxDNlUBqNISaG9xfgXmwXLZscgGNIJzgstTk0hPOiTYUK8SFoIz7WHDTOEoZ7Tk3xFRTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMWf9orpbxO+KkIb52/zmRQdn4FoNY2zHuC6iRpBOXU=;
 b=XA/XfsTXXifR3/Qo55Wax3ayAcBuwEO+OTwg4qBkLhL0Qy4xavbAA2FMB/LAa1PYRTNhfN1dYRx8mBZE0qVxLtYsH+mgZ/iX9MImrit3pW8CrnOJCnE7/EIhewhqL9BJyYr7RfgfDgX58udhB4seEV6Ta3lqW5yqPO2KWrRLps3AwAfa0Hn0hHWHi0ANFRwayDHX2pzBKGNHuAujgodzyQjhbz4owv6cCqgfy5FDFsh6dGT/qan7I/cabEo/xaLLFvW2O9MbRBEaxFj66qxiwljja2F2m/M0h+4C0i1mHyd4vXPSDK8079G7N4NLi9Z7cMhzVsWvC7ESmO0V+JQkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMWf9orpbxO+KkIb52/zmRQdn4FoNY2zHuC6iRpBOXU=;
 b=jZm5cM4nUEQxkkqPHzvpHqSQenjZ9HGB8+IN6eejakhIIpdIbiBmvqLPZXDB68vUBt+DxGkU56TGWlmltzvisPf6eQcSp4VQrXO765Wpal8iFR/nJpmEvTZmLlkCUOL+6Kk3EcFuHQzEpr9c0SVFtvVehn8KB/a8K35Am+El/Q8yfvMGYBBjlYZj2eY35oDsNcnAfCB2L0ntGGu9Wzh1HU9YLK7/qbQkoQq8Uan19BlbhVUOSvonExx19cBFE7iX6mHawZEeO42DwIYCe2m4Hbpw9xZnXlS25+F6BVnQ0sd4pdOR4e7YsdZ0lxSvCofBmgvv6rLs7E21vr4GjQdcog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:21 +0000
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
Subject: [PATCH v5 05/25] fs/dax: Create a common implementation to break DAX layouts
Date: Tue,  7 Jan 2025 14:42:21 +1100
Message-ID: <e8f1302aa676169ef5a10e2e06397e78794d5bb4.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0115.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: e231ec8a-bf97-4091-c63c-08dd2ecd6e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5mwPYksS46q2zwq24Sry+RaZAqKsd3hX6p/1Mt10Aozef0wzMa+0EtNpKqqT?=
 =?us-ascii?Q?dCybXDDm83YFe+0l9TEYmC9gRumzjNCTs3FuKU3sOjCAeeV8W5VG/aHuGek3?=
 =?us-ascii?Q?FbwiFHvZ8JfqVsdhHX8jq0S19/9xAudmF/FJbFrAo6o19H+hnkQcCRXkklq9?=
 =?us-ascii?Q?MkgCze41PHYJlyhjtncJkWWR98TlfYjuiO9mYqbbGu9zAFFfdF73nID6qWro?=
 =?us-ascii?Q?W1M8nPfoJ0bK0EtTAjNltq9UI+Vln6DJb3Z4tD2WIEAm8r7uWpYRgXU0tJTL?=
 =?us-ascii?Q?gGKhuPQHeYZmkyIa3NtTgQMvZV6hk4xAu8sL1+6RTTQEGIYwHgo4F1DZesjM?=
 =?us-ascii?Q?n6uaidB1FvAh3VUjUqn/ztlcsQ6JGrpKZ0z4cHjl3pBPsufqVURZE8r6ki1n?=
 =?us-ascii?Q?821zqI9eDeWE2GZuH9VGTnNQ7fFv5YpuPSH4v9lqxI9qpqoZrLX6fIkX4R1y?=
 =?us-ascii?Q?l+x2qU7wUl6JeWU45NPgRKKjHyzd8TJryjpsewkFQ2NjYiM4hSOC4FivFoY4?=
 =?us-ascii?Q?acotDck++2HS05T1KDm0Gtb5nWFzUZ3qOB8r46KBKqyBScFwKk0QBsZgEG2G?=
 =?us-ascii?Q?uAmxRTw+y6EZRWYvr0gvLA8Rvc1Jlz5eGhoNAPv/gU876pa6yma8ypplI7pM?=
 =?us-ascii?Q?J5Bo31ReXvUb/8CPrTdqrzCCKCBinG4CQBWxUGr9tuZ/kK9ECEipJS32l0p8?=
 =?us-ascii?Q?8O+dG8DTL7yYQ1tQeS8eBsH4g33d1wB3972TLjpUXllSs8aIp7i/UsAASav8?=
 =?us-ascii?Q?M18ssPx6CsFLvo0bvDRJ2y5ZN8SPGr0jbqa2i+yFkb7oZENRJYHwP0U7bswo?=
 =?us-ascii?Q?r5rmLAgIz9QG+CAC69WZHL4Gippf+etbJBgH82su99GeoxesrkpnnriMsU1s?=
 =?us-ascii?Q?SfI/7R/mftdFQO3MGWfHKCam+Pnr2o6Qrofcc1ah6P1jMpqQlSCmo1fEW9DY?=
 =?us-ascii?Q?l+Q5Sod+Owfwhmg9FFfuZpMEYatVJheWRTXpZ+tRmzwVoJ4GWgnyK7V0nSJA?=
 =?us-ascii?Q?bPYROOiO2fEYBir8yBStz4+YTLNv9ShNNRKGrbDqgLDUXQ4ZO+pjHrpWXE8G?=
 =?us-ascii?Q?psGm9y3amHn7aoMmWbo6qf4UJHMnzx+/a6WmGYiarb6DbwxvWUaxG1bLmZXb?=
 =?us-ascii?Q?2T/hUua2jRUBHfdzkeCJYQWKVdvtNXOW3u+oANgFL83s+VBFy/h517fsUT/u?=
 =?us-ascii?Q?e+724cTF1HFp9wlw/ZINmP7t4LIQllK6KeUUim81/PoE5ETI/WkDoxm3pBB1?=
 =?us-ascii?Q?+QYTyDh9CtRAMgj9YcDNC9tGeIHurjveXnHrUQNvuN96bxR3rRN1VKL+IT/y?=
 =?us-ascii?Q?uSp2JzLOKJtU446kr+mTF6udLzaQlBGX/89rgQML7w8vYA9E35e5ys2sfI94?=
 =?us-ascii?Q?z6CpTCLVHFglzs+/w4VWerrZYNiD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cF2uoZf116UZ2n+qPKh8GVpQrmDPaMA/JqENHwnFxBBtxuvlh1aJAVq/MjS7?=
 =?us-ascii?Q?1g8gSLncRfR3bQWgexbkTIZeGoCONfhDhR0UQs8IMogl/R4dESvDz8TAlfQr?=
 =?us-ascii?Q?lilByj2Mych9S+TJwu1buZFG5gnfQdN1OtMUwgrcY+rZMTOEdETMc1DYrS2u?=
 =?us-ascii?Q?yE46QeATVy8zrEPadYYaeHYqbTlDtIqCW/9cl2RguJzdZgxZG6v88ncv9zD4?=
 =?us-ascii?Q?BDXlSn3/PLJKASnwpLzF5qSmY7Xk610GipPESQNiBPIFdmlj33Q6hu3nsTQJ?=
 =?us-ascii?Q?35nikR9JSAbu196CJW8s2ndfa49TB1AyCjfRTABtVV955BYURhIHis8MutBi?=
 =?us-ascii?Q?yb4iQbJ9SDrgqTVlG0z98aH0n3sRvFHTHUmdNKCXjdVHZY8fCAsKQ5PvE4VJ?=
 =?us-ascii?Q?lW0HCAYE9MKWPVo4Eqdc51Hk+9T8RMiPiMk0XRN2tTsMYXZhNI8xZFwLLyG+?=
 =?us-ascii?Q?ipdpRzmppi+lUuIY/RrqL7wIdQXKTGJKoDj4fAsaTAnC8sJTadfLMg0JjLOg?=
 =?us-ascii?Q?A3q7mRZgz66ewhVhYSWatUJbrzUt73lj1zz0UxWWIZfGI4iWWGo9uWO87RdZ?=
 =?us-ascii?Q?7+foR8ww8FdTZooUHK9NnFnvzoPz1ETRvQAtuBuBhBE/Vk8k+VGupdqp4jJd?=
 =?us-ascii?Q?9N6vJkjiw4Loo55JQGW+0xiFA3xf9eYEiT5x7qtJ/AFmEczHKAVIceBCgUxe?=
 =?us-ascii?Q?DhTbVAS4Azqz9oBZ3l2IvRMvmRMVg0MBoUbaBFxemkNcLmtcehaawCvtLlqF?=
 =?us-ascii?Q?d9P4Fp/SoEZJTb9MkWsYVpm98EHKqkK3A+Og7EWMnSB20eb9FryTafx7hqAv?=
 =?us-ascii?Q?/AQ6ECdnRjU6n7YWyfvxeIcFIJlIGb1ZmCzIDrA//c0nuskppMVGHvsvIe0N?=
 =?us-ascii?Q?jZyzIgAxHeDo8EyXAGCjxA8CJYbqQt/0VRapNVL6SWvgbPEW202vcKlMZZ86?=
 =?us-ascii?Q?MssTilLtwyKs3o7/fEFkZ/9rIL73exjM8rtLlGFSuoGFYt2rM4WYbIZYYEpf?=
 =?us-ascii?Q?6a3u0jIacmnfHbz16Qx3Gzpd5YCYpaC1NBPkP1m+mdxI7roiTDR6ycCNiv12?=
 =?us-ascii?Q?bskfnY344Wyy10EMHoVch0BXrC0S0teZAm4u+SvxXnQ0mxCBHvpy18MDf6pZ?=
 =?us-ascii?Q?BiJzvsgwJEGh+RNsu8AzJc6s0f1Jzuia3xr61fzqAhhk9jzgIDBlPXJM4y+O?=
 =?us-ascii?Q?8Rh+jDxTGYTfVaLbT3W8xNadSbVsRHbmXZUNgcR8a0tUcTyoI7qQ1mqcPvhB?=
 =?us-ascii?Q?HQBMFGeswJzv5i2cj5d4sQKJMHmBijwOxyQ3PeL8fgtBfBuJP2uZmMKnOULe?=
 =?us-ascii?Q?fQiyKQFJ/RE/KwXwtA5ME/zhaWX/5JV55+TG7vSBhsYRbyPYBxqgeXtSW1iY?=
 =?us-ascii?Q?zEs9vTjWsrN06B5TUGDe176sxcybW41SKDiGySxiJim5KBwlOcy4RbrbFm7z?=
 =?us-ascii?Q?te7aVUw03O9zTaV1y3oDunyEpNd9EOg3Xo2EGWIahCXXQWaidyLAujj64QjX?=
 =?us-ascii?Q?ix/NXQymKQG3+nJIUpP6Gv6CuN6ZLH7RE/AuM55S7tnRdVECuqqCTjj91kR/?=
 =?us-ascii?Q?VZVmtrpcMR4P2dt4sfHVz3FehXrCXtg9GK47Ex7f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e231ec8a-bf97-4091-c63c-08dd2ecd6e3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:21.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwXuBWyeanaDoSPuq2Xi/IzpJ7ktBh+vVE9kMOnMFkwZLFS1daSnRkCt/R7Fh9MMhclAFvIzukz9xJrRcfrOIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Prior to freeing a block file systems supporting FS DAX must check
that the associated pages are both unmapped from user-space and not
undergoing DMA or other access from eg. get_user_pages(). This is
achieved by unmapping the file range and scanning the FS DAX
page-cache to see if any pages within the mapping have an elevated
refcount.

This is done using two functions - dax_layout_busy_page_range() which
returns a page to wait for the refcount to become idle on. Rather than
open-code this introduce a common implementation to both unmap and
wait for the page to become idle.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:

 - Don't wait for idle pages on non-DAX mappings

Changes for v4:

 - Fixed some build breakage due to missing symbol exports reported by
   John Hubbard (thanks!).
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/inode.c     | 10 +---------
 fs/fuse/dax.c       | 29 +++++------------------------
 fs/xfs/xfs_inode.c  | 23 +++++------------------
 fs/xfs/xfs_inode.h  |  2 +-
 include/linux/dax.h | 21 +++++++++++++++++++++
 mm/madvise.c        |  8 ++++----
 7 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d010c10..9c3bd07 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+static int wait_page_idle(struct page *page,
+			void (cb)(struct inode *),
+			struct inode *inode)
+{
+	return ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+}
+
+/*
+ * Unmaps the inode and waits for any DMA to complete prior to deleting the
+ * DAX mapping entries for the range.
+ */
+int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
+		void (cb)(struct inode *))
+{
+	struct page *page;
+	int error;
+
+	if (!dax_mapping(inode->i_mapping))
+		return 0;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
+		if (!page)
+			break;
+
+		error = wait_page_idle(page, cb, inode);
+	} while (error == 0);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(dax_break_mapping);
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cc1acb1..ee8e83f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3917,15 +3917,7 @@ int ext4_break_layouts(struct inode *inode)
 	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
 		return -EINVAL;
 
-	do {
-		page = dax_layout_busy_page(inode->i_mapping);
-		if (!page)
-			return 0;
-
-		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
-	} while (error == 0);
-
-	return error;
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
 }
 
 /*
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index d156c55..48d0652 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -665,38 +665,19 @@ static void fuse_wait_dax_page(struct inode *inode)
 	filemap_invalidate_lock(inode->i_mapping);
 }
 
-/* Should be called with mapping->invalidate_lock held exclusively */
-static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
-				    loff_t start, loff_t end)
-{
-	struct page *page;
-
-	page = dax_layout_busy_page_range(inode->i_mapping, start, end);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
-}
-
-/* dmap_end == 0 leads to unmapping of whole file */
+/* Should be called with mapping->invalidate_lock held exclusively.
+ * dmap_end == 0 leads to unmapping of whole file.
+ */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
-	bool	retry;
-	int	ret;
-
-	do {
-		retry = false;
-		ret = __fuse_dax_break_layouts(inode, &retry, dmap_start,
-					       dmap_end);
-	} while (ret == 0 && retry);
 	if (!dmap_end) {
 		dmap_start = 0;
 		dmap_end = LLONG_MAX;
 	}
 
-	return ret;
+	return dax_break_mapping(inode, dmap_start, dmap_end,
+				fuse_wait_dax_page);
 }
 
 ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 42ea203..295730a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2715,21 +2715,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 	struct xfs_inode	*ip2)
 {
 	int			error;
-	bool			retry;
 	struct page		*page;
 
 	if (ip1->i_ino > ip2->i_ino)
 		swap(ip1, ip2);
 
 again:
-	retry = false;
 	/* Lock the first inode */
 	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
-	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
-	if (error || retry) {
+	error = xfs_break_dax_layouts(VFS_I(ip1));
+	if (error) {
 		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
-		if (error == 0 && retry)
-			goto again;
 		return error;
 	}
 
@@ -2988,19 +2984,11 @@ xfs_wait_dax_page(
 
 int
 xfs_break_dax_layouts(
-	struct inode		*inode,
-	bool			*retry)
+	struct inode		*inode)
 {
-	struct page		*page;
-
 	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
-	page = dax_layout_busy_page(inode->i_mapping);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
+	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
 int
@@ -3018,8 +3006,7 @@ xfs_break_layouts(
 		retry = false;
 		switch (reason) {
 		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
+			if (xfs_break_dax_layouts(inode))
 				break;
 			fallthrough;
 		case BREAK_WRITE:
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1648dc5..c4f03f6 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -593,7 +593,7 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
+int	xfs_break_dax_layouts(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9b1ce98..f6583d3 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -228,6 +228,20 @@ static inline void dax_read_unlock(int id)
 {
 }
 #endif /* CONFIG_DAX */
+
+#if !IS_ENABLED(CONFIG_FS_DAX)
+static inline int __must_check dax_break_mapping(struct inode *inode,
+			    loff_t start, loff_t end, void (cb)(struct inode *))
+{
+	return 0;
+}
+
+static inline void dax_break_mapping_uninterruptible(struct inode *inode,
+						void (cb)(struct inode *))
+{
+}
+#endif
+
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
@@ -251,6 +265,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+int __must_check dax_break_mapping(struct inode *inode, loff_t start,
+				loff_t end, void (cb)(struct inode *));
+static inline int __must_check dax_break_mapping_inode(struct inode *inode,
+						void (cb)(struct inode *))
+{
+	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
+}
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
diff --git a/mm/madvise.c b/mm/madvise.c
index 49f3a75..1f4c99e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1063,7 +1063,7 @@ static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pud_trans_huge(pudval) || pud_devmap(pudval);
+	return pud_trans_huge(pudval);
 }
 
 static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -1072,7 +1072,7 @@ static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge return >0 so we abort the operation + zap. */
-	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
+	return pmd_trans_huge(pmdval);
 }
 
 static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
@@ -1183,7 +1183,7 @@ static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
 	pud_t pudval = pudp_get(pud);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_trans_huge(pudval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
@@ -1195,7 +1195,7 @@ static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pmd_t pmdval = pmdp_get(pmd);
 
 	/* If huge, cannot have guard pages present, so no-op - skip. */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+	if (pmd_trans_huge(pmdval))
 		walk->action = ACTION_CONTINUE;
 
 	return 0;
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-35516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357339D575D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12190282F1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71317BEC7;
	Fri, 22 Nov 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DEG3dCUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E9176231;
	Fri, 22 Nov 2024 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239706; cv=fail; b=P1WahW3nCIQaZ4LttYUKyfTVcPLJ4x04YARSDVpV7nZFf3k0kYyAr1vpauWyVImTsTFzSSvUZmXBfROdzI8+5haI5HNYUqAlfujEvACiGWtIEivWdgs4aQDlVu4FUa22JvbtIVBQxYHypu8Ga9VAA1IO5tMv/LkWx3Qs0h3h4I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239706; c=relaxed/simple;
	bh=lN6BUUiCigqpWLj4Lr/n33B5+9jfrL4ukep5ombzTF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usltY+b4i122rporNePAMcLAyyBC/4i37k5HL2d9JoOcPKuK79GpxW5dOLPrKVytaxLy5biJaSvrqLqzsqQsekenjNSXcyLeWslbikdE4hh3qKfv+dJm8xqnvOLOqVtdSN9IfUzTlyguIjNRBn8s+sfM8h40psJv+4W7RrSQ1Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DEG3dCUc; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlh+hyDPb8784anoufSXlmZAsth0OECIlz/r4o165KyGLPnfaO9VY5zFCxuf+7ABeOG959nzudbVZum9cwBq29ZDZ4O09BgGzz8f57yAVw+2qNp36VAQ2rGZayxmjnE+MzEsHtyScF3HDKf6jBkV3nHNJFtkXHBe1pPKKa/SADV4vo3X+MFzUqXe+5SHVdIGv2OW2Ab+yLuGXFEOJHwoBQej+dJeVoMZwgjw760I5OPFSxBRCgrmhOlTwaZl1oeY5Nh1Qj8svqNL2W+hzjD2FcbJAQlUbYv1is/Mmi/z3OtW6T+zfXUQ1nVHXR1b6ycO/bYN8zNxhI/zLf69t9LShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy91m0zgEkIdTV0vxkx864/RgDyaRUi24jYEQ6+6du0=;
 b=LGc0oIoAfJn85RdgUpMyN0Mn+G7NZUEQX989t9lvzHAUBGWkyiMYmBSBmoSAW0Mv3efU07MtNMDgAUvGL+MGkU976v64rP7G/26vdwv1AE/0kaer9rgYQ+GnGCwburB36NuUiMVDhNFZpMwjS/oOJ67v0dWArDrvv7yfAO+PMnzCdm+XL5Bc/DQuNqzBI61mFlV6d9EG6NesLO/5C8gc0z/vqllEuoxelyX0rmUQy8PLFr1RQr8lYm8dp+EvEMy31IdOi1kRE3AFidm3A2X3Wzgfre6R9RCwPuZeuxjj/6lG2wpxL35JkoPy439wGKq8cWf5OqO0p5BIkvhnUEpRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy91m0zgEkIdTV0vxkx864/RgDyaRUi24jYEQ6+6du0=;
 b=DEG3dCUcHKPSMmVhGG2v6vup6t70gcszvVUGuaozMNYdRGDC0wbjFwXQGxaJ3WvBSfwOtL/8zImRWcPYlwAG7BEOOETo7Q35xRZZ6K8wyJ0Y5Qbnc5WebgK853pRb+0ZptLRgtdnS4CTD3i/SsnV+pkdOWgvmW2q+O2JMpT48UeC9b1xCjUMaoolqJRaPJXW9VyFBg8mzc1ewzLkcLA5QzHG1DM2ChibuSMFuEgTBUjS1hEcuCYgT5Y3hqItnQ8PO7DQvABzb2eZeDATFB53/YN9Y37Mbt9vIJCNujD3Ik68mQbIavOeKfCYlp26R9NysKAJbsGDxK1LUBaJVnM2RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:41 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:41 +0000
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
Subject: [PATCH v3 07/25] fs/dax: Ensure all pages are idle prior to filesystem unmount
Date: Fri, 22 Nov 2024 12:40:28 +1100
Message-ID: <f2a44be651f09e338d63e1f5545c59c3b32658c9.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::22) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: ad24861f-40f0-4684-6098-08dd0a96d013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCSPVX8VqOStD88Qo+Kue6nKdGxIh3U4X6ZgLmEeJ6ATjnQt9CKe3fWQNIzk?=
 =?us-ascii?Q?xLvzyUYQlRKsKbokQCA/LM+VkGka8lGIdt3mZ5F6bH0n/rVX7DQKTqCMMqlk?=
 =?us-ascii?Q?p04Ua6EmfMSfdy1ocNk0K/XwfawBcW219AyFPNRebKG3I0b/dugDiRtqvajs?=
 =?us-ascii?Q?aetAnJaUgxQVePde8tc2tTQ0fFm0wIqRLWexxXNGehcYe6tbTTXSgPbcJpUz?=
 =?us-ascii?Q?yw+PKPwFpJpt+R4Nlt87tSRAv1T060ii4m1Z43aYl3zdGoG/UaWgTVt7Xusd?=
 =?us-ascii?Q?vCWUhgxuIBoOhZVMSJFa+z3yi6HrwIBvJ3BUjzQuhIGvP3Rpxs7B2Li/QLej?=
 =?us-ascii?Q?NoxCNK1kDiyCWbG41kO45obe7S7+cCvf9bsGvCtYg5i4E3uQIQY36iTJEn8x?=
 =?us-ascii?Q?J2M/zn1KzIYTsVq7HmED5bnyGlGEjgU9YxYhdhI6fzIlT7+ENriXvWGKsOuL?=
 =?us-ascii?Q?aDR19/KQdLKi6iVRZNaqOMFHFfbtcBqsdL8dGcggIYj8Oalhom6oSrzlzzp1?=
 =?us-ascii?Q?s3r4zacc1HUg2i2K0mxXkbv81ZyxqgN9lGMszgEi5Xi9ufCJEiaAZtNeDN1g?=
 =?us-ascii?Q?5TxWXh8PT8XK+GnuR6LxkVBwc1QCiJQnBXmymR3zxKKlQfocQGSoAajhgDMf?=
 =?us-ascii?Q?WwXpCpUJ8X1vww+t6iun45jTKZj5cIakKreltVh38T5R4Zwq64Ea3eRS+vff?=
 =?us-ascii?Q?kBEj3fw7IxzwKgfKjOgchvx7IJLnBiKeWF7Rpx25kcWJEFUBS5cLMGitKHpz?=
 =?us-ascii?Q?Pzo2rBSjDe9iQ1qkQ/iUyYqweS6mLbBvYij0ItfmnESSfA4qYDxngOz0Ir94?=
 =?us-ascii?Q?wGtM2C1uZRsV4ror+tGp7fXlruiYcHZGvaY6y4NWFgeW3nv3i6BgYSksJQgj?=
 =?us-ascii?Q?qZzc9ziqQSFCgz7X+kvnA26Osb38JN5cxG9EeBtWME8F8DFqD4GA/qlAaDZ+?=
 =?us-ascii?Q?//VwbQvnMNO5Rlx+C00k+RTfTvqQztsZC2VN67uHgcf6ZozIew0jR95JnqZ0?=
 =?us-ascii?Q?x9tkmJEUIJgoCalrMlSfyg+3Y7w++EQPAhiLd3mz+hZMjkFj6x2KKspHcIwP?=
 =?us-ascii?Q?4YDK2TpcmUq7szNXglBnnJvxawEtHRZrKQ11nbi5DybWpUzCKCWjv07EBjtL?=
 =?us-ascii?Q?nbUbNPJ/fFQD1yUdrOQL17Sw3+b32y9JsigjcPKk9qe09peaegu6VTw0B/u3?=
 =?us-ascii?Q?hr9DL8iQ8p2nF8TM7JB2Y/z9d5M63nEipW2HPoYnr93XH44cjtwhm00kUitV?=
 =?us-ascii?Q?8wgXC+bHLbaiHJKsd80kih2rKx7mn/+gRHykfdXIxPGUJBIqt697DXjnsppQ?=
 =?us-ascii?Q?BtyTZG7SjZ9smgnvl0X3WlBg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RiwU5ecWg3oCiyyI/RHAWrjLErqMpTxFq8ywqlE/I/FwAqqa9njHmy2b+W6p?=
 =?us-ascii?Q?EVPAwpcAyYQY8H2ZE5s2raWzAs9T2tqttC7YyGiCPoYUW67n0iEE5hnVjo50?=
 =?us-ascii?Q?fCFcUHImYPjqQUXJeIizpfuWBpQ7SWkQZtsELePzDuAWv4gqCISbptsVsi/J?=
 =?us-ascii?Q?GUMn9a9ApWoH9fCAokIf81bs1Mic9OUUaNfFl5L2rSnnjjyB/xaHBlHDmXxa?=
 =?us-ascii?Q?fBIoS8w7F6d50278CLikAKehzo6GttRTWj0HJWDzgH9bIJ8ITQo9tSmQAa0U?=
 =?us-ascii?Q?3XDfVEF6l8Smh0ZZMTj1lhAO/x1cAhGd+C0UZX7XVxrNo7n5rCNr8z4tSjWe?=
 =?us-ascii?Q?M5374i320wMaFdSZlHoXz7AGIEpl/6mJz1ycK+MASo7jGz3i8ahNvxdSML7E?=
 =?us-ascii?Q?Pgg666X4nWjsbeb/lrsc4veowaY+KWTBk+hAVN6uROExku3jnTMnIle+7GLa?=
 =?us-ascii?Q?7FKypy+6ugwQylS3ps68Q3ljLYeM4HmUKalswPoPTRYsmmnrMxI6AUF/lVB0?=
 =?us-ascii?Q?BgN8x2AWCAXAMeGXwDow21raadOWM76K4IznXI+JqbNEtkmY/1ruZHTA+oAy?=
 =?us-ascii?Q?GaOPdFoTsOBMHOiN9y9BS8SpDRYHVF20IvrY9CKAVUrj4RuRTLk7BYOZqIs/?=
 =?us-ascii?Q?/NOYAif3l7U2icis4czx6DqN1x01fljea37T6tqJiotaZtwYeAr8VyCpvbGT?=
 =?us-ascii?Q?tBHnyUQ+7lbeIhWNIFZsVBsy/OXUULorJ8CBmP9rx6JEOas8q/fpjR3F5giY?=
 =?us-ascii?Q?TzhZbnxrxV4hUA972aH1K5Yp64FJSGob986tdrVLSfJfWpZ5arzJYE3+3KXz?=
 =?us-ascii?Q?qK9DO9YGVgc6ppqWjJLzfeCKfzbGgcLiouEhkExspCcISbxlTFYdmy6UzW1j?=
 =?us-ascii?Q?nvfcdmeCOlxWjNeq0gxJh/IYeS2Ll5zTbPpTm0oN44Ota2WMTTtZEA6HgT4i?=
 =?us-ascii?Q?ZV8+4FXITmVak/Y9kJGCrYd4wqD9JjEBxtIhoM4oX8D+GcVnHO5vnIGZD0/G?=
 =?us-ascii?Q?u1GKvkT5vkmqQ7BJLw4wXcnqnc1p/VGSI+T57IH8cNojsJkbYifsHyto35rZ?=
 =?us-ascii?Q?uOWxt+DRstDC31yIk5AUFmjmC8lGN9ValB7AdIhEZgGvaGWDlRwQbRiGMGtP?=
 =?us-ascii?Q?xa7f7zGYNUL9Z3KBOzBCpiRrJNG6KN3RtXvK097uH6YCnidBzFu2/1Jdaubz?=
 =?us-ascii?Q?NLLcG6OdEqNiz+AeQVx18sRiJcNEEqWKGOTo5Pe4fKKicvZnp46NyuNVWn7Q?=
 =?us-ascii?Q?DGUaYD216QvSZqrNCBzJ+mDQKkbduVar50xLBdO3lWCTO62Xpo09smWSOxCU?=
 =?us-ascii?Q?qKZBQe/ak70sZfZ/30EZYm+KXNwz31vmo8gz4KutT1ep2mcQA2SyE2xDBrXS?=
 =?us-ascii?Q?7lz8CkDuilYTRmWNPmZ//OGi1KBRkDMbLFt+yz8VF3YJ6S8K/lm9cM/payVS?=
 =?us-ascii?Q?Yq8CLkZO97UW3KvSkDQi5aOREd8v/KsNlouyX5eHhd1odg4fyHPn7V4WX59+?=
 =?us-ascii?Q?qzPrJejU2u7bwPNjbSZsSwnAaMrQZZmBjRwxhsXzxz4OjqnT3suUkD0uku72?=
 =?us-ascii?Q?2pM5saCJaq90kxBBjp4SY9C8OEeYmnYjSODVn2sU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad24861f-40f0-4684-6098-08dd0a96d013
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:41.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jcpsiwTd+9kgsQzzoYxDiBs4kyq8tmzsfHVeqhrFjlxYl/oHbGakWwMGV+DPS9FRW6y9lNTbEeVR8Xwewy8QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

File systems call dax_break_mapping() prior to reallocating file
system blocks to ensure the page is not undergoing any DMA or other
accesses. Generally this is needed when a file is truncated to ensure
that if a block is reallocated nothing is writing to it. However
filesystems currently don't call this when an FS DAX inode is evicted.

This can cause problems when the file system is unmounted as a page
can continue to be under going DMA or other remote access after
unmount. This means if the file system is remounted any truncate or
other operation which requires the underlying file system block to be
freed will not wait for the remote access to complete. Therefore a
busy block may be reallocated to a new file leading to corruption.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c            | 25 +++++++++++++++++++++++++
 fs/ext4/inode.c     | 32 ++++++++++++++------------------
 fs/xfs/xfs_inode.c  |  9 +++++++++
 fs/xfs/xfs_inode.h  |  1 +
 fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
 include/linux/dax.h |  2 ++
 6 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 78c7040..0267feb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -882,6 +882,14 @@ static int wait_page_idle(struct page *page,
 				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
 }
 
+static void wait_page_idle_uninterruptible(struct page *page,
+					void (cb)(struct inode *),
+					struct inode *inode)
+{
+	___wait_var_event(page, page_ref_count(page) == 1,
+			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
+}
+
 /*
  * Unmaps the inode and waits for any DMA to complete prior to deleting the
  * DAX mapping entries for the range.
@@ -906,6 +914,23 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 	return error;
 }
 
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *))
+{
+	struct page *page;
+
+	do {
+		page = dax_layout_busy_page_range(inode->i_mapping, 0,
+						LLONG_MAX);
+		if (!page)
+			break;
+
+		wait_page_idle_uninterruptible(page, cb, inode);
+	} while (true);
+
+	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+}
+
 /*
  * Invalidate DAX entry if it is clean.
  */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d42c011..9c8bcd8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
 	       (inode->i_size < EXT4_N_BLOCKS * 4);
 }
 
+static void ext4_wait_dax_page(struct inode *inode)
+{
+	filemap_invalidate_unlock(inode->i_mapping);
+	schedule();
+	filemap_invalidate_lock(inode->i_mapping);
+}
+
+int ext4_break_layouts(struct inode *inode)
+{
+	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
+}
+
 /*
  * Called at the last iput() if i_nlink is zero.
  */
@@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
 
 	trace_ext4_evict_inode(inode);
 
+	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
+
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
@@ -3870,24 +3884,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
-static void ext4_wait_dax_page(struct inode *inode)
-{
-	filemap_invalidate_unlock(inode->i_mapping);
-	schedule();
-	filemap_invalidate_lock(inode->i_mapping);
-}
-
-int ext4_break_layouts(struct inode *inode)
-{
-	struct page *page;
-	int error;
-
-	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
-		return -EINVAL;
-
-	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
-}
-
 /*
  * ext4_punch_hole: punches a hole in a file by releasing the blocks
  * associated with the given offset and length
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 25f82ab..bdb335c 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2986,6 +2986,15 @@ xfs_break_dax_layouts(
 	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
 }
 
+void
+xfs_break_dax_layouts_uninterruptible(
+	struct inode		*inode)
+{
+	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
+
+	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
+}
+
 int
 xfs_break_layouts(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 0db27ba..aea3d3a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -565,6 +565,7 @@ xfs_itruncate_extents(
 }
 
 int	xfs_break_dax_layouts(struct inode *inode);
+void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fbb3a15..e25a880 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -747,6 +747,23 @@ xfs_fs_drop_inode(
 	return generic_drop_inode(inode);
 }
 
+STATIC void
+xfs_fs_evict_inode(
+	struct inode		*inode)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
+
+	if (IS_DAX(inode)) {
+		xfs_ilock(ip, iolock);
+		xfs_break_dax_layouts_uninterruptible(inode);
+		xfs_iunlock(ip, iolock);
+	}
+
+	truncate_inode_pages_final(&inode->i_data);
+	clear_inode(inode);
+}
+
 static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
@@ -1184,6 +1201,7 @@ static const struct super_operations xfs_super_operations = {
 	.destroy_inode		= xfs_fs_destroy_inode,
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
+	.evict_inode		= xfs_fs_evict_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index e8d584c..53a7482 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -266,6 +266,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
 {
 	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
 }
+void dax_break_mapping_uninterruptible(struct inode *inode,
+				void (cb)(struct inode *));
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,
-- 
git-series 0.9.1


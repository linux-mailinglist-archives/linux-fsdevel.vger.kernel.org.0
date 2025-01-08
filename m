Return-Path: <linux-fsdevel+bounces-38617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12FA04EB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855777A25E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABCE17D366;
	Wed,  8 Jan 2025 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gIsBKjYq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3A1632D9;
	Wed,  8 Jan 2025 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299148; cv=fail; b=ZoLL7q8w2PeilOw2zLY3QS5//UoYxWT43uI88xkcIIIvvguA7mp9CNXzdApLOTdzD5pdmpgm+83GWVnVLEWXiVlkALgNoeJ8rCKApShJ9gYqVvFU9YECv44e/9g0wepE2L78HLEAVXPE4+c1pw0YqyRI3XBVFTlPTFG06BWxQhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299148; c=relaxed/simple;
	bh=75Ce30FGfNJrM0eiz1RHVabriSb0VSXPdz0dgwAb5nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inZfOVKof0qrhKd0I6V0fllWpJlLn3SGAeXwaGSSIjPf9IkCDj7jhpq77EYLImz+HWYYpXG9aH8Lk+yVAjNUWILgBMC1w8228Lc6mOgfZwwn396LR/PMHW64V4EdvbzqyadQY7cJ2cNjqiXR0ZYn57uNdxKp4oIysliZE3LhyUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gIsBKjYq; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNEZPhsHsQ3ALz4Afw2q3CUqUPPU4qdQTcgPOysgJiYIoCa4Omz//Pbd6/TDuMvusAWkTuSnGI8g+KlBZ6O1luiIiV98nEUgOQCYDJ+2pvErzJJxEnio2cTQaJWc+8Vputq7iaySl7ia934e8MU5Qa3WSD6Uk5nkcBsQmPEA6bA8jaOcLio5imNFj5ISBpIr2Srm3Qxlc/IP7MeVQOsDuxSDlGJLXHMJHst3Oz94pMpLDZIfNcKxsYTXFw6DcnMl0nQb++BviDYY0dPP8DHrZhJ6im4FFJRstpQWf8rgIg7xrfU/X/QJrt2mTsGYgJSyFc7UK8R1rNT53Owv95b66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRqSdjQXKAmEy86FYwkJXmEjCcJmPiE6SGAqo2GzlFU=;
 b=lerrEDDrRO0VXMDIonjz306DigLI7CusDolXbwlhBYreEJdN2ws1qggCdaxt0frhxtL2aFxsn/f1fnj+ctM0zPVDbjAAjHRk8UZYu77LY+6KJo0V0qKTHexNQPVWWpFsRzfE7/96pqjX1FMW32e6PoRYweBpGqGjEvQMuvr4Zt6y+mVr+hVP+2H50tzUUGi8MT3e6cmJdWkz6I0YDBuzccE9jVbPuFsh/m4Oc1/Iq4Q1Hps+UERLtYHSm4sOFaGKVVH0s/GUJJqhmC1QuNxhfd+8VwOQm0EUZKSxE9zmijM50YIDNpXHsxfCbkyhKgURQeNhMiI+TvlRhb76K2F7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRqSdjQXKAmEy86FYwkJXmEjCcJmPiE6SGAqo2GzlFU=;
 b=gIsBKjYqfJve1HzLIhuGVgQ7m1E2RE0EWgpeGYCQldCT/UMUuw+OetFAXm58bS+z1D2cvUMqdFtctaG2cwOh6cGxLZn5vcpAilnWq0T2g8FmBAYXayaG6u/htXiX3nb9aKiYKl7j4JcRmazruaiHjMpUYPppvy/MjEa1NslR1x4Tz8fojpQhKE7nKQgdHglTzMH+h0YtpJ2rGGx62Fsm2ue9wx69yY2cMwZMe6ns9wrvVAlSbTJpye8iOFp5gb1ZyBwZn65GgKgGPuGK7mwspHme+rYeh+hxIjD8Nehoz9WAksl6YJntk9+Ve7jwUrQrcj3R7d/Rq+pR3RL4HwAZbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Wed, 8 Jan 2025 01:19:03 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:19:03 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com,
	jgg@ziepe.ca,
	willy@infradead.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de
Subject: [RFC 2/4] mm: Remove uses of PFN_DEV
Date: Wed,  8 Jan 2025 12:18:46 +1100
Message-ID: <efb9ce1355b90b876466999d3f20142199d4143a.1736299058.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
References: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:10:e::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2d3d9c-6c5f-4c5f-719f-08dd2f827038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSlSZpw7NBsHuPp26qOPAsJ85rxwkoTIwfK9zIoz/hR+mm4v/V9LyLuiqwps?=
 =?us-ascii?Q?waSU36FZSXaM5XIUaREiK0vS/DlUoLxgzVQjBJoROGKA+fgPk9aIquQUxf3Z?=
 =?us-ascii?Q?NakkRiSXUA/RBmi8pk74jVv6m+E/lcUBq+YKN4ixPEkO5B2643OuTxnHaGgX?=
 =?us-ascii?Q?qAhtyYI8qPbvqmQDqtjDZeMEk9Jub7vwhBYPdWexSmntCievQU/nms3ih9s7?=
 =?us-ascii?Q?nZ1ARdqr/xE9k7SMfgk/yHh/uqs08kcdJmlMbDXwbPLxpKrkM+QUtkhgHBgn?=
 =?us-ascii?Q?lX4HCqpPFGCyuFHskPm/GqeaANHOzx4q1gQmZcF02bGlJ/cwMekqHFVqgH88?=
 =?us-ascii?Q?yilBvvTu0JG/9kQqwea+fzK65PXie3qdl8T2expJdCGRVSq99v8NuGDcW1Ho?=
 =?us-ascii?Q?XMvq6UGMmN6rzbRu7FhULv3BtJexJcw9uaBxbA/t9p4RjFUQVCdVv0+ldTe+?=
 =?us-ascii?Q?+zMaYBFbUrLOBob7SMClDqa5gH87vTi6fz8oJKL4X8cMTR/8wmZ305i8c0xw?=
 =?us-ascii?Q?ZQpvBEn00Tre0OCjRQHRiL0EkGBLO4Vv0II3h3iqidSxe9yJuwcTMp4l5UVK?=
 =?us-ascii?Q?+WQUIhUgWvQ40bDYeFQZ9NJBYys8RP7eB0P6E3+4Gni2vWLmyTAYwew5gbiF?=
 =?us-ascii?Q?j5uR9viwuG7jUQ0DdP9T8dWzcMfr6lgErnloXNvTNtxOTYer3m60QcC6gaB+?=
 =?us-ascii?Q?1N/5wMZNbj5snsUlN8BrwBvAGLRkHpfKUnNXqnxuDQSY4HnVF/Il6HA1Mylp?=
 =?us-ascii?Q?Y5wzz0BrLjzHw7nHbNn26iWjJG6X0qoX4yS55vx5amrYCp62TMcK0mG93GYH?=
 =?us-ascii?Q?guh0Dnk2ZoFyQtMaj9gEuSU+d6AXoFucAPBmu3NBZQbNIQj/nYGYjuOJiCn5?=
 =?us-ascii?Q?wEJLhL5NINjrvh1GPwoc9/1AKdyZf+EcPS1X9XDgNLiF/gxwHCbUGWwRy50X?=
 =?us-ascii?Q?Qukyy7tjr/2ud0M+9q9lOm1s8cmbTtsxhRv9AwVKdyOkCpVvPyLtZXmxHXEV?=
 =?us-ascii?Q?pxsO+VpgXCUpURKD6P7YkwALv1YonYP63OQxWqim05P/b6peumxAp0auMK5k?=
 =?us-ascii?Q?jGqWkz6azRwN9GCbgJZNMpj3/5+WXkivq2MkggE62YfdZZaVrrrf4c7Is5GQ?=
 =?us-ascii?Q?UAxWVgw7nLodywhxIN7hf8m0J4jaB24bhZM0SN4VIV0o0CtgkATm3b2LiEOy?=
 =?us-ascii?Q?xu5E8KTwSt10XniRwt6k4ah3cihk35EHPjtxHg4Zp0JUkHGMnwyRwpzHpmUI?=
 =?us-ascii?Q?uJ++9OAnfMNPIZ2ewjaq+eDxFTmt94WjsP65seCK7N5N+iCDUeKgOXdCJeYf?=
 =?us-ascii?Q?b7PpE10I2c3ZUWzQfyylw6clL/q+y5KCa8Mm2GJVaPeoLc2p9t7/ReRb6s7+?=
 =?us-ascii?Q?bobNYiw/16CczaLxbcsKzJIqY+Qz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hixDBosmGcX7THMod8B9tK+eZvfOzRs0oLff00ATGOV1D8iC/HA9fMOQes/H?=
 =?us-ascii?Q?gQgVtoDA3gcKRofLOj0nIS+V/BP5JjqzgOLASrYT6cv8ST4XrLY+PfxbpgUz?=
 =?us-ascii?Q?qaM/ZQ6/q9ZaBxaf4b3Vtd+zcdqpl4ZhKtJd4rzSSlVBlFjIY7FrAhkXeyvl?=
 =?us-ascii?Q?LighW8Sa4+cJ2G32XCF+oBu2kn82qB5eB8XtMozGB0rgCiq2nX+QADHQGfQv?=
 =?us-ascii?Q?gKKfsU4oX+krVhYPyWceivN6uGKwlnruB4tSw2VT2c/mR4DFHajHqxmwsBBx?=
 =?us-ascii?Q?3zO5T+OzFuBYANhrmvY0naRe2fUZq4dzsUYY1FkMV2RLmgzC0jXYSP1/fEjA?=
 =?us-ascii?Q?6GIil9R7repmyOCnLn9ugm8n5pPnbTwhO9iZd/0sOPQVVv1j39jKxoIWTLzn?=
 =?us-ascii?Q?TLuyiY/2FdfA8GHJvD30I7WfSOXz9YWshuySzen4xuhHiljxaI1lztBhlvRo?=
 =?us-ascii?Q?JM8T4n8RCC4RV3khf9i0OUrqfeQEv0lhwiqc2bmq3hWMD5tYD0LeaJGEUONl?=
 =?us-ascii?Q?b1YwcaL40cw+hTR+pkRfFD2QObzPBYsLB2s4uz7W40botvV8PE1eojluVPai?=
 =?us-ascii?Q?vnoEjeaV4FMke9/KHvfBH9APezf6q8Hd/jL4GZat1zwsCr5kd9lQLVO8xTto?=
 =?us-ascii?Q?mgtU8XU7hUn1A2cFkeFVJ8WTbgTbKe9V0MQ4fAvIDVRHvPJhrm+fJOL0nzOA?=
 =?us-ascii?Q?rPBnZG7mNgHiDj06Hg4bMEQaPLqn7mcAj/O64ImqyuZZ115D9+mq4F7qvGXz?=
 =?us-ascii?Q?00g0q49OZia7/dguNdvIVEOqudf+lsh3ubgj6aMvJjUCcuih/3rWgDU0f00K?=
 =?us-ascii?Q?OX2edsebykzAIjYe42IKZ0YjeAh0GkczAlM7lawDKj2M1jb8xMzljvLBAqcO?=
 =?us-ascii?Q?r/v/MZB+6YN3iTbB7bQbmN9QytH/8Y4hjkxWVfIgJA6CGzG1W7NYiSjQUhEM?=
 =?us-ascii?Q?cacymF4M/GE3AIfLFcgsV+D0cWPE+SFpSngMlUr7C5kJMI9mW+1Fj1w4GWSA?=
 =?us-ascii?Q?nHxvekjXs7d41eSGgL+LxMQBw+pVzu0HFScGfKPfe7FMguYRFFoBQ7i0K3Aj?=
 =?us-ascii?Q?oj6Kh8YPBmAuv/tgJnvTQkWsPhOuSbEAFnPu2TFHuABZXtTyDP+0G4dJNdz6?=
 =?us-ascii?Q?RBTr8jDGLypyvdjngfnwlGIuFwoZogfeNY7M9LMwhG0U5wEOk8J1N/wK07cE?=
 =?us-ascii?Q?rYqRPXB6HK5aYZh7l7TUUaHxSvz1ay9xzn/pTVSp3xlsIP6R0YxZA5pC+7Wg?=
 =?us-ascii?Q?iz3b8DLL1hyWnHS0uGw5pc89MiQuvz2aI2/hSk7cud74RhEB3GZlNUZ0w61i?=
 =?us-ascii?Q?uW2tbxUlUbmj4wI2R/4SQYErfUPVy5t+kPAYb1gS3eIvTNETjeKvS0uvRz0t?=
 =?us-ascii?Q?zf+cc2HtSvGvgGhurliC2rU9pJ4QCSshoDAYZDDYRkxO0v5XAF6r9lTyawYC?=
 =?us-ascii?Q?S6CjJ+tbn1hbgdCiAiu93pVh6xBGFuVQvaxFnoIl6AI27h/jRuf5L5VzntIS?=
 =?us-ascii?Q?TveGgphks/t48keMah5+GA27dvUAp/wZrb2eef5KC2PO18ZFztq9Zc2OC+wZ?=
 =?us-ascii?Q?W8KZG5Co4Y3qwQwkJ5nSjH5fwIASczpW665CTHUQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2d3d9c-6c5f-4c5f-719f-08dd2f827038
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:19:03.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV/7+YD7wHy7iQEtRxK5X4XmrQf7o0+mQxrpg5AXOZKcwsFvbJmTObBSKazPkIjLJkcADDDcfhPyRKoF+cKBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

PFN_DEV is used by callers of dax_direct_access() to figure out if the
returned PFN is associated with a page or not. However all DAX PFNs
now require an assoicated ZONE_DEVICE page so can assume a page
exists.

Other users of PFN_DEV were setting it before calling
vmf_insert_mixed(). This is unnecessary as it is no longer checked,
instead relying on pfn_valid() to determine if there is an associated
page or not.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/drm/gma500/fbdev.c     | 2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c | 5 ++---
 drivers/s390/block/dcssblk.c       | 3 +--
 drivers/vfio/pci/vfio_pci_core.c   | 6 ++----
 fs/cramfs/inode.c                  | 2 +-
 include/linux/pfn_t.h              | 4 +---
 mm/memory.c                        | 4 ++--
 7 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 8edefea..109efdc 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -33,7 +33,7 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, PFN_DEV));
+		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, 0));
 		if (unlikely(err & VM_FAULT_ERROR))
 			break;
 		address += PAGE_SIZE;
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index b9c67e4..9df05b2 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -371,8 +371,7 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vmf_insert_mixed(vma, vmf->address,
-			__pfn_to_pfn_t(pfn, PFN_DEV));
+	return vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, 0));
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
@@ -468,7 +467,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 
 	for (i = n; i > 0; i--) {
 		ret = vmf_insert_mixed(vma,
-			vaddr, __pfn_to_pfn_t(pfn, PFN_DEV));
+			vaddr, __pfn_to_pfn_t(pfn, 0));
 		if (ret & VM_FAULT_ERROR)
 			break;
 		pfn += priv->usergart[fmt].stride_pfn;
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 1ffc86e..8a0d590 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -924,8 +924,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				      PFN_DEV);
+		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset), 0);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 90240c8..e6b6c01 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1680,14 +1680,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff,
-							     PFN_DEV), false);
+		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff, 0), false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff,
-							     PFN_DEV), false);
+		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff, 0), false);
 		break;
 #endif
 	default:
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b84d174..820a664 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -412,7 +412,7 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		for (i = 0; i < pages && !ret; i++) {
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
-			pfn_t pfn = phys_to_pfn_t(address + off, PFN_DEV);
+			pfn_t pfn = phys_to_pfn_t(address + off, 0);
 			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 75bb77c..034b5b0 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -11,10 +11,8 @@
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-#define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
 
-#define PFN_FLAGS_TRACE \
-	{ PFN_DEV,	"DEV" }
+#define PFN_FLAGS_TRACE { }
 
 static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
 {
diff --git a/mm/memory.c b/mm/memory.c
index e1d647c..5f7a441 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2510,9 +2510,9 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
+	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, 0));
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
+	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
 			false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
-- 
git-series 0.9.1


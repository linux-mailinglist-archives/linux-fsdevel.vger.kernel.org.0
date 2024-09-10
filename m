Return-Path: <linux-fsdevel+bounces-28974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F89727ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A4D1C237BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F407181D00;
	Tue, 10 Sep 2024 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ku25m3X1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302511CF8B;
	Tue, 10 Sep 2024 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941707; cv=fail; b=PTj/3XTErePlaSCQCxH20vREfEHZj01YHEZhHvnkjpRcNKH0l11RSYa+wQEXvYDin7hY2JvyGw7VUPUoOhkO0lMrhnC8gclN8cqdNCTGi0rRMn6Ug3kUEKsPgKojlszMjnGb7Yew3yUbyHg3aPaf9aIMGnsyZhDvgE4InjpFZ0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941707; c=relaxed/simple;
	bh=1L188h5KNYXplwSFYcPgGWpL+VSrYrlpu4RDCuSQ8Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TalZWc8RDAvKkE20YbP4dxbi5T9PjkkEtwthi8q8rc+mAz1E6TqseXA6HhA/dglfOeFAvpmpJvqkwjQHXBmoDkwIplZ0ntwjSOvC0/z7oqby40ljqWMNehH93c76jQh7ELBYY0rD+9sDy2MVjWT1n1/m17A7Hsc9TsN3Dc/wfkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ku25m3X1; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArSmaWpHAulgDCZjUdNPuelA/ds21d9j4hfrtzjVXK+O2KN319rltk1qCiysCSIzkJdXv1XxhYXY0AxT6VlGqssmhw173wnUs/3hq3Ojk7WLft8Thqyc4oJSVqV4JPrmphcXUQ1hduslvedMw6zt8snxlhaXweTivCTF9DNm+1T9FqlRtX0ZjSyC77nAMKtCmNwDS/OKkg4awe3LgJROC0CE+PxW1jcjL+6fj64qdlfD6vwYupGO6Cg27WbskzmWJit9kzgRq5LNjXJeGqbvDZjKtVAUlwc5TTO4wiFM4K3YNoTzrea8P8ff4H+kplAQevs+RZtUlCcOH1Ixz2C9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7bMoyH61WQOj/0djBXDddV4SIhrpx8WF80k0zij8WY=;
 b=fBuALuApHA8JN6fbNLpT23LLv0C7P6HfnDHVh+zLajtsZb1BafYgcW/DxqUjifSzviLIvRKoINAQ+oChk3UgufjBAieGRsIdlZ4ll64uPmua2xvf5lE4XmU7nzQ4HPC7iqdRe6tYSaWzzfBRMubHMwc55BWu+cTImCoGfoGFsITvg5awYZ/7a07NZ2Aypwdau0Re8DxijPUSJN2jzh7/Lkg3ycTbXEBHO9pcqy8YM57NWGZ1TEoULnkvG4qLx9NvCaj5YoEgaXJH1JFPBY3+j7hxr9mu79Uqou9dju2CepL8y+HXLqMREX4CnpC8Und67S+flgvz2TxBTsxsLNerXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7bMoyH61WQOj/0djBXDddV4SIhrpx8WF80k0zij8WY=;
 b=Ku25m3X1x8jKR7c7d+vvrZw4VQX5zTwItTSW3kl54eFZilW8v2UQCxttZOwy76HExDW0PWu+zPoQXw/6VTWuYOvv+zpnP3PBNOU8NdR9UcqsQQPwUh7JXW2wHFD4kI08XyJ20yctA3loR5w1SekHUTc+PMKmz47nPo9gJvBYJXb7EY49HTK4NBopb8oeIC9UmjN0leBMYPbzd/PnOK2QCXsz0SvKKo2yCuDV1hGfO7CO8W7wQN5xzZTStFbtOUtkGcXAUBtLyxLgFJkLXJvDrAw2bbFp9ojMHpjjzLDd7VfRqi79XsqYOk7R4m3cpmzBHRcQcIesGKkLjo42TkbayQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Tue, 10 Sep
 2024 04:15:03 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:15:03 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH 02/12] pci/p2pdma: Don't initialise page refcount to one
Date: Tue, 10 Sep 2024 14:14:27 +1000
Message-ID: <4f8326d9d9e81f1cb893c2bd6f17878b138cf93d.1725941415.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0191.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 17208fe1-2f79-4791-0afc-08dcd14f24d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZ5J+werEmfKSvNgJ6LyyRiVC5fbAc/dNJFT9HAaxLR2TZTeJktuJgd/FRCD?=
 =?us-ascii?Q?jg0jLD+Km/UdvcgQoYEZV7+3aLDKVDS2RC0DAYMVhaqj1Qwog/bqcodFZLUY?=
 =?us-ascii?Q?hEauw/Bfi/nTTMDvcHWVmtw8QhIkki4vx2PvQp7OKRdWv0PY5N92tHZqv0fz?=
 =?us-ascii?Q?cosYdVq85tj4hC14ZRO8fTVXrwPJRAz6sMMXtJpTbAs72dOFjwWGZn2I9yLr?=
 =?us-ascii?Q?UyHNh6kzkf7/OJS/uF7im/N0xcC0y6oILO/sN3cfXg5C5brJLXmA6b/M9p7D?=
 =?us-ascii?Q?0N2MEjQx03lWneh1XaOuBRI+NKxmF52ukbgysFxPqwLZoSJZ+hrDFUokP+CO?=
 =?us-ascii?Q?xKnVcGcceJO9MsDuDsuqMmA2EIWhXm7UbAYNsC3GisF1HEAl+TO8x6Xru1VI?=
 =?us-ascii?Q?fF9Lwgo0+J6NGd5OHF4XEAk7F8GMWBLVUePI+UwqADwqeZ+GCSBMuotQP6H+?=
 =?us-ascii?Q?1xSM+3XjG89BXGFadw9m2QhlugRT8CrbGAd1Fcro2CbqKBq5nzxpAEGmMivV?=
 =?us-ascii?Q?4dBq8TWWCboL0/DW2JWk+mM+UinHdjA/G3HKqyCtLC0M+KSi9d6ktHpWSlww?=
 =?us-ascii?Q?J06UEAk6fsAjUA8gsRUUEO4MVV7R/A0R/l79bu/JPRxwW9NBat8uW80qnhTX?=
 =?us-ascii?Q?h5eCb3NdXNqq64ZBbEwddex/U9u3N7rlDCe8hASydjT5zjcjvmHfl5a1ljA3?=
 =?us-ascii?Q?P50T+TfPjsIa33lW1rIB2M3RRhnAFo6+4FepkAapejeNpmRPOU1fHG1/laSZ?=
 =?us-ascii?Q?TONh2hCMb3AwHuyAEF6WoXRK+OedjOmYDjqfCFW/aa506Bp1uVjK7SlqwQHg?=
 =?us-ascii?Q?ZftGsRbo/TvdawljtM+sh6Do8Hksb1IDQLwKbtJfG8Ml0f8prgRcwQ+PIeC+?=
 =?us-ascii?Q?HecldqLcLQNK5br0AJEx5BbkjKj1xviqgcFN9ZiXlmGF5Jj0aDDi/kgeSybd?=
 =?us-ascii?Q?gCFWF9q/ABXMgCqMmp6/EiKIclK2n0FcKb4DngH7Elu9ZsKtiuBH+rLC2czc?=
 =?us-ascii?Q?IosPcleTlq7S24zayD3V/Jib70TzD4D+bTQSDxfrtcs6VdVpwVSXNlVstUHm?=
 =?us-ascii?Q?Fi68qZzGxWheT0599MDUrmqM2xcvqPk90i22uDMFV8LWnscobxsPrrK4/Ccf?=
 =?us-ascii?Q?HLAMblERL893d0/C8zzHYqV0meRxo0upFk88dZ/N7NJwuVHFTjEu1LTMilkT?=
 =?us-ascii?Q?QsT5w2OK86ACxOCC/8HgGKQ94n4r+tl2co+IrScaNkAnTC0xkMPNAyEYE4aS?=
 =?us-ascii?Q?JrW29k3Qyvml4B6UVmLyyS8PqjJ4Q5iM2jOt21f15vaut8mJJXvThVzhV+A7?=
 =?us-ascii?Q?0rc1ICyS/6JZR0vIS1drrFeIRiPPIG2wMKU+uOimx2G9/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VdBz8HHLtOxcBhLhCMFL7nMgDg1l0ig+7XmVXiX1CoQqesWh6hvrOo+OKF4?=
 =?us-ascii?Q?9KMkxhpp5M7RVvmwoEEvHHe6vWcXvR20u9YrO6Rno9Y+6dbWi3MMS03a8ux2?=
 =?us-ascii?Q?8VSjce8GmJAdVnSRbes8cE9n8G7hyrVjUHsro4GvDzZhxX9ntUJnXB53QmTn?=
 =?us-ascii?Q?QPWL8zpxfAXhN08D8Ehc4rF7+8furD6TZTSkhn3oESgct6tXK91qqr0JlI0v?=
 =?us-ascii?Q?PLqa4ZucAm1oCwzxHB37PLtS0lGgTVj/lMeOExX/R/J8s2C4FBGQMx+CQuHJ?=
 =?us-ascii?Q?ksrydkNi3ku8bqObwnNeD1DmvvIP/73XSasfEzyz27m61wmYoSW2AfNefN7r?=
 =?us-ascii?Q?Ml6xgA5Ny5Y+coxWtHuBxLAfLAQVuertr2e6zLV97Zk6Dp8vM3hYKsbCgSd3?=
 =?us-ascii?Q?ot3wvAI6Cw/2RW3hhgT+/GiXfEYI/5U+Dvgqp0cvz2q9xngUsE0CJfhi+X6S?=
 =?us-ascii?Q?6i57dXihqT+HaclKzki1usmlP4rbnAHa6a5zoB+AC1lgTjks80Q8XGeWIKy6?=
 =?us-ascii?Q?Y/HYPORkFTkFlZLVtKhZAQYgx1D5nMC0XkfZGFZRjULFAgd069p5e8i/dzlM?=
 =?us-ascii?Q?+T+URvDUL0FnbrgHPjYFQD63F0/LXy/xIOe/ZTRkTJWWQ9MnSNJ/LVr0xsAy?=
 =?us-ascii?Q?E5cD4nuvWwu8PPRe811wkKnCYnzv5SBo7m91l7MkVaMmxkpVEl6/17fX7sem?=
 =?us-ascii?Q?lmqYvfhc9AYbise9aZC86+Q/SCpzNSbh5Y5MpA1+m1w3+16kzkeIju4vgiwH?=
 =?us-ascii?Q?KutM/IzuONQzxxsZd+mvGRoTiBiE3ji8XPjKFeLuC4oRZzmEPWQszTQveBFh?=
 =?us-ascii?Q?z8k4S/jfSJEL6hniFpuemF6cUVIPHbup4gBmd69tZoeLM94dTM36R8fG1Okw?=
 =?us-ascii?Q?3GRRFYoBgtZJDE/yqW0ln+o1F5qEF5ioY2LH+mVES0fhqkM1FF1y+gY1nSig?=
 =?us-ascii?Q?oKcoy1OySP2cTgZJT9+FB1OJiTWCHmWC+dmy0b+8qFvISNUMCILXyjO2a4lj?=
 =?us-ascii?Q?iyqY0/iRnu7LLejNtc5Ej0F4Crfus+VZz7L89oUeAeeQKREg+mbqpNxJY+qD?=
 =?us-ascii?Q?5PWzw2R48LVzYmReFw00X+3R+OHSAUxibr0DbJm7kl9IG7TReJckS9vTRwSR?=
 =?us-ascii?Q?Je9YwfBRJybuAy/Dz5WKUCHr2yTLj1f78x5fSpM5uuxOaYKXBOYF6ObqbvPD?=
 =?us-ascii?Q?ObYTw4KfqZdR9KvHT9U97PuwaO7/QWZk0uWjZ9iGxhAt3Msi23bPwLpN7euT?=
 =?us-ascii?Q?ous82iZ+ThW2a1dH5wHPOIHUUOZUmNiR8EKEULejkbhsa7SPi2jRDk74N6k3?=
 =?us-ascii?Q?/Tfi7xWZIIY2LdvIdPxbAebXmc8HZC6m5A7ohcOPDATpRC+Zo3VbT0QhNmdU?=
 =?us-ascii?Q?2s6ohfpw0oPytkhU3GI9H2MZ/HPKEadkbbUVHWk5t8tlOMDimnE7VPZW3G/v?=
 =?us-ascii?Q?D6eZgPQiEkE6gHly0t3hpQ70MmJhJRktof2U6Yu5SRuhvx1EAT8Rs8fS0xCn?=
 =?us-ascii?Q?L68Ku7l8sg8PFejh4U1Nw+mAKvvP1OhI6oSFwhwhPwKuR9yxK2402vxrAKDn?=
 =?us-ascii?Q?wPnMlNq/sl6DOVIDvQ8+4FvbcXmg5aqEtRYLy3xo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17208fe1-2f79-4791-0afc-08dcd14f24d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:15:03.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WL4uVIxk5MMr8lGNbXOSY/6us43cqffRpqpEHjyyGsILF1fV93oCnnD8kPim7Jy2NxuC0tgmjoVI+tqYDrQd3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

The reference counts for ZONE_DEVICE private pages should be
initialised by the driver when the page is actually allocated by the
driver allocator, not when they are first created. This is currently
the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/pci/p2pdma.c |  6 ++++++
 mm/memremap.c        | 17 +++++++++++++----
 mm/mm_init.c         | 22 ++++++++++++++++++----
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13..210b9f4 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -129,6 +129,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	}
 
 	/*
+	 * Initialise the refcount for the freshly allocated page. As we have
+	 * just allocated the page no one else should be using it.
+	 */
+	set_page_count(virt_to_page(kaddr), 1);
+
+	/*
 	 * vm_insert_page() can sleep, so a reference is taken to mapping
 	 * such that rcu_read_unlock() can be done before inserting the
 	 * pages
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547..07bbe0e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -488,15 +488,24 @@ void free_zone_device_folio(struct folio *folio)
 	folio->mapping = NULL;
 	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
 
-	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
+	switch (folio->page.pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
 		folio_set_count(folio, 1);
-	else
-		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		break;
+	}
 }
 
 void zone_device_page_init(struct page *page)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ba5607..0489820 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1015,12 +1015,26 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
+	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
+	 * allocator which will set the page count to 1 when allocating the
+	 * page.
+	 *
+	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
+	 * their refcount reset to one whenever they are freed (ie. after
+	 * their refcount drops to 0).
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
+		break;
+	}
 }
 
 /*
-- 
git-series 0.9.1


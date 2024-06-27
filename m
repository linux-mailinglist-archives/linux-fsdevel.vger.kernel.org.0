Return-Path: <linux-fsdevel+bounces-22562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161EF919C1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D212832F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667A5C99;
	Thu, 27 Jun 2024 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hUqerUax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF817F3;
	Thu, 27 Jun 2024 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449681; cv=fail; b=CUnzp+dldl1jN6bU7bFddHeKyQ49yBcXAGu648PS8x/hnIev/K4X//ZCg4hus9ZUA67m1OMNFEOUENUBHgMfw0uPfk0vG3pG5F6rAsrcrFBq6cfnZ6+hweJu/l0mYwlZec1JnspE2kNv66RQgZB+dX85ZyhOlQp5yhEUh2Blih4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449681; c=relaxed/simple;
	bh=sMcpOMk0TO9Ez4iSh/swIciymea4AcJSoLWoehxBZFM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hI+3ir7CRDeDZjfMTWrAScfpPagqMlP90unhTKFN/K9Hj6kD/42AB0P4KDujFS+eLoo6pEj7yEevVxUo4vyvG0PUwS7tigzLN05n+s5yAhQ8sFM0E1beEwnRTzimKiPGOT9Sl82CP6aIzR/8GtayAopHyd2XT0v25UoNvrggLAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hUqerUax; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2wkBygywzYfYegHAeeHzVaf+UrSsjPaSz2mhW9RFNdQNE3mwevycZ1tsBSHqNYgsdFZmTf+vIQflqIQeb0oTxktftOtQiTEykm+izvxGc8kZ89wFD3HReV8azCCpcJBrPifNDi4hHa+bCIGkyJF9rGzWUshyEYvVhpvNHCtoTes1pOilQnkFlHzyRECokjDsOGpK4oKR4dMbvLiDP+qVr/f3LswrfvloYWuUlp8RlLI6vXBBl52kZshaL+xOGEmAZXPHyiyvtTyqZ9Kh/Ql7ur04doos3syVhwnc7sOfwLeHVXhLQ7voIdQCU1PJoxPLsVc6UXpln7PZlQZTZ2v8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rf2PZanTBx44cI2D5MZlIPtE+H6xP1K3YVbhjJ4DOQ=;
 b=RWNvXrsVR1aElfT56+CtVLXwi2RgqHa2UFIfZceJ0czjSyIs07ATzz3l77QIM6dyTTW2W2VUm3LyILpJm0vxIcbcYmOFlwFZlfgWWADJM6QYeuLkK4aKCDRU4Xbgw1GxEX6KOddVQaOPJAAJT+5cCqZWP16RSeQhs4+mEflS4E6Aalsvxt5nw5yQkdUfXZ3K3g/2CKLCk3pe7WTeknZCJIlBmgbEfLhiWjKf8tupexu1z5WiAUxOuKad+ALC93BGQAaeu8dkHqwcfrxAqB7L3woKGreqypulTsfC3ddcbSqzVLIvb3+J9S3ATbfCtp54lVBoRFnqc4yx5LzaqEyfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rf2PZanTBx44cI2D5MZlIPtE+H6xP1K3YVbhjJ4DOQ=;
 b=hUqerUaxb4S2LOlLLGWzrCwt/cgOVEnCUDh0vPo7E/OcFm1IKfarUsLI1aa1CxNscdglN/m0k/OTqxtEDxKuKvakGHjpkspU/dut/0sh905tGcQ0SOjP/EQFFN5RqTCvG504+AfVzS9h9Z+L7Y6BmvaS31RC7kWsPqePHC8rHiQz6gbPwc5xa6fwbdUGDy0lg8L+n1gUb2QufZKhptLvOfM+CfNBSKdy8I2qKdUjj0bG+yaijZSn9PcZOh6TvMo7fxe7dQlgvVZZxhrR+T1dVfwWGzJFodsTWqgOkitEiVTU5XTFdmk+/RjnFbFIyXEHDKLKfF6LPCtEFSsGg9904w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:54:35 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:54:35 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
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
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Date: Thu, 27 Jun 2024 10:54:15 +1000
Message-ID: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0173.ausprd01.prod.outlook.com
 (2603:10c6:10:52::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efb801c-5fef-4b79-977b-08dc9643b679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HcCsiw7fou7/iYLx2Y1PwLSdh1RhR/Qw60R6qRw1IWuiVr9wtI2U5MgdlJ1s?=
 =?us-ascii?Q?0p0SU5jtcnE+qlS1ieUQzNyLJu2ea/ITYV2/rlKnwpQ/XbaQgJgKPU8s4vE5?=
 =?us-ascii?Q?DVFDeZjLD9AKEIK6w0KIZNs3oacjn1RxdQfSuIpgTrRi19TXR5BYgJmi5W7S?=
 =?us-ascii?Q?EAPccqN3LLZ2rvewdW26u9Gwagu1Y1nfrE+uu2WY8Hw5kr65fu76w+BnTu6P?=
 =?us-ascii?Q?frEcxiTbwqaUX+RU1LVGpPRdB7o/YMZ5FTLioSdm7/+qoBlMf9gXobTwkq5+?=
 =?us-ascii?Q?rGBDWMM1keGS16kEibs6uAwJK7a4NBY0z3CCSqDL/0WyhFcI5UDLTT/JIZmU?=
 =?us-ascii?Q?ueCXxAhnn/3YbyU6Jshl38S5ghg/3HDXtP2WvcWDHxYnrQ6N5UsSZbp/Tx97?=
 =?us-ascii?Q?lOJSuxUeaOWe6Hj/4KUfkEvdl/Qe899g0htO6+XJBIs70A41NlIuSo2Sa4Hv?=
 =?us-ascii?Q?ZgQvIBIEAiCTxZOXzYIATsWTZ92Z4sZ2aSlM2c35A1dFMuCK29IutVIuJE/z?=
 =?us-ascii?Q?rRqq7EkjlttMRqhYYAvuEZ2DwuTdsz8ENJci3ASmBGsyIHn+3hTdfE7MWJIG?=
 =?us-ascii?Q?XZL+hvamLvYfGkhnEzMs7zRGnvObooWAtapvRFP9sabHxWM4r9U5ea0bAUC4?=
 =?us-ascii?Q?JZbjvV6+iBoJZNEIRkQhX6FokRvM0oq5oZ9aOP31irLea/VSboa/cKREZT6K?=
 =?us-ascii?Q?+boxk7ZIfQkPGqwoco/rnUa04FUEc82nGqd9kMXGUAT7gUdPcDZ+QDdC4wfT?=
 =?us-ascii?Q?80CuA8IRcX9tAsO/hDFC59rHLga2rVkqz+lc3WO39vnJCGV2oKZIYFXKoy93?=
 =?us-ascii?Q?qS6iAfOVj4e5O3g5ugEINXASY1YuXcwW3fIvS6NWYwl6L8RuY8xehTy/VVY6?=
 =?us-ascii?Q?mzQe8gU2667fYeSd1MiAHhVZrrRkJ6UJT1c3WROyjCtXhcNcE//omZxHUKWD?=
 =?us-ascii?Q?yN/GKRLdTPLaXVQ7o+ZZZfoLuLqTzAvljMQGVhiXEFbxXnwwUR2ACymVfqJc?=
 =?us-ascii?Q?48RCgovgQj7Kv8gJI8Koo0LDBCmnQekG2w8IyA4hXYIT2Pl6ehJ/1gxGGY9q?=
 =?us-ascii?Q?VN0wfmfqu1qI0frPljGcqo+a8ccE59kz1sRGatek9okD76lhAY2J2VZwuL3d?=
 =?us-ascii?Q?1Xw4Rpby3ieGDeHXweYWEEXlwLf6jyHQWyQ6rziGu00DZvqNTeDbJgH6GHnY?=
 =?us-ascii?Q?TPDNpwmf3nMMc5XZR2hZwneE05QuEcdfmD8RI7u1Zx+joabqQVs6aRj8/3ik?=
 =?us-ascii?Q?sNISsEJPYj1HsamGnf6K8Knsfzyxi0jTaFalnlNIryxebIfG3m45mty2MNv8?=
 =?us-ascii?Q?6TzyQ9q3UzJk5xUMX8/u9IJab9/hjRIOEdeHvuDMqb1VJpaey2QnBEFXPsy6?=
 =?us-ascii?Q?sbufp8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wfnBwgDI1xVGz07qI+AIeXifWjeFX1S2aaMpuLKATbcIVklQnNHL/YoTzOlJ?=
 =?us-ascii?Q?MJ7cgeJjphsqelnWDZgkNFeD1U1Xssp6GPH0tfHD+DTRIi0PvVPOAj7LskkQ?=
 =?us-ascii?Q?pxIaCK7+YlDmatWrRQilGVSh6ELHzBRKTC9U1dqXZuF0x8JOTZ4h1LuG5gjX?=
 =?us-ascii?Q?ISOYO8jlmNGVy8F6e0aLvJuNYwEv40PnHl0Y65sO96ShHDnmw2mewgQTefUU?=
 =?us-ascii?Q?c9Hd0Gjp1ekfOROGS5GWFBrquKIoecUcMiPv3q48lKKOmruoGa6+IEleGVee?=
 =?us-ascii?Q?rwk0Waa3cF4+aX9PphjuyOpRKBPod7JjhXA/za96yPQRJtZ3vR5K7/20SiJj?=
 =?us-ascii?Q?OTAVNmDd3ydpFxge20u72uoMwQinhhThCJ3Pf+LpE8Qe0142Dq0Stnyap7+l?=
 =?us-ascii?Q?uG9ymbsUQWOhHsZcS7emlA2KkfWueIOQP+pvm+z9Amy/UONgOpZSSPdRWnhA?=
 =?us-ascii?Q?c+TlzCM5/1CeT7C5HOdj6K+k5KEGY95Bn9bWmxTjXedM6z7tj/4U/6q7jQ8I?=
 =?us-ascii?Q?+Ss0EzQ3QUSrNhWOjAqqxYN6MuNiMzzSSZf8zG7PYYbOsmuKBVnDFNvZFbat?=
 =?us-ascii?Q?RofUCasAlpUJZLQZ8x7xVSuWCJ2zn1IS48acsrORhZW8tzvOILaRNqrkcWrL?=
 =?us-ascii?Q?Fczw39boTHFgfgtqWpAbHOfJJvYS+7FMihX5iNNVjBi6UPresYMmUmT5vsK0?=
 =?us-ascii?Q?myMXjEui4Ubt9eLC9okbqLFwqdpqS+t57fl93vQTdWhBUUDeaOGZtN6VSQ/Z?=
 =?us-ascii?Q?wjACAT0SKU0Kf17DHQJhk+8giv1TArWqt7agRiqAE0T+mYRhUhhRp8ERNB5B?=
 =?us-ascii?Q?NVgShslvqmu7chkKun27U1k7exxetX4vAc25mTLkOv6iny3S+93r5rY4FjMV?=
 =?us-ascii?Q?L+E7o+DZ/WPEwDMlC2oTJlJHH2z0OKflhMc+aJAU1UEtmT93BGgUQQPLwpI1?=
 =?us-ascii?Q?n6e8WMEeRQX3U/iRVhKGudNq5DSMroxMebqbO3bv+UaVQpFS9GMplKJAhE9S?=
 =?us-ascii?Q?yujkWLtYeLx1bI3X5Q2wFQiZ3S04J9xcM7NpIlOXfj+FxtYP4ngQYeNHmG40?=
 =?us-ascii?Q?Kp6iNHQPoD6ALqXUMzuo4ExPRgZOgQhzxNz4DQxr9NRpsl/6VUkFtGl3xtjm?=
 =?us-ascii?Q?9QznlGzJBRzjHrYAzL6fPYDv2pYIRZHjgLimT+A+ZukKh+lsl0pZzlnR8NMr?=
 =?us-ascii?Q?7safbpPHEThi2loM9BJ7WkXZpGa8+CShqpdZMsEEzASRZprffOgM97o55poE?=
 =?us-ascii?Q?YR04KRWS5VXpauuKxvMkDwGVCKRGD4W/6+LJm6MwOus1P8GxCywvgVAtm9sk?=
 =?us-ascii?Q?orfDDri9TwOIKj+kk6n12HqGUkpPiY07fIoc473OEymgJ9zC1nNN1mvlMyco?=
 =?us-ascii?Q?NaCyhim8Ygv7R5KRylE83QACtGK806n6WmguJt39UR/IN/iXotU56D9BzUFt?=
 =?us-ascii?Q?MKFKEDS1/hfP5IuT8IuiNf8ZPA6vmoPyXfq/KsbS4wrbR+QhU4vWGJ9v3uzg?=
 =?us-ascii?Q?oYA9wWnMKvANsyjj7Gz6essDDsL9XJwYWP7oArrnJhjZpBV6p0BHcezJUOpX?=
 =?us-ascii?Q?vNSdpp9/KkrJF9ufodxBI7EdK505DXCFvfRqC5zq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efb801c-5fef-4b79-977b-08dc9643b679
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:54:35.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDicBmJR/cEzIP01fYYQ9y4EEDrQ4SqaBrInj+/ZsKrktjNqFYXJdJVCBTx0lqQn+tW2IsbN+blFBQLWj8ay8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

FS DAX pages have always maintained their own page reference counts
without following the normal rules for page reference counting. In
particular pages are considered free when the refcount hits one rather
than zero and refcounts are not added when mapping the page.

Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
mechanism for allowing GUP to hold references on the page (see
get_dev_pagemap). However there doesn't seem to be any reason why FS
DAX pages need their own reference counting scheme.

By treating the refcounts on these pages the same way as normal pages
we can remove a lot of special checks. In particular pXd_trans_huge()
becomes the same as pXd_leaf(), although I haven't made that change
here. It also frees up a valuable SW define PTE bit on architectures
that have devmap PTE bits defined.

It also almost certainly allows further clean-up of the devmap managed
functions, but I have left that as a future improvment.

This is an update to the original RFC rebased onto v6.10-rc5. Unlike
the original RFC it passes the same number of ndctl test suite
(https://github.com/pmem/ndctl) tests as my current development
environment does without these patches.

I am not intimately familiar with the FS DAX code so would appreciate
some careful review there. In particular I have not given any thought
at all to CONFIG_FS_DAX_LIMITED.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

Alistair Popple (13):
  mm/gup.c: Remove redundant check for PCI P2PDMA page
  pci/p2pdma: Don't initialise page refcount to one
  fs/dax: Refactor wait for dax idle page
  fs/dax: Add dax_page_free callback
  mm: Allow compound zone device pages
  mm/memory: Add dax_insert_pfn
  huge_memory: Allow mappings of PUD sized pages
  huge_memory: Allow mappings of PMD sized pages
  gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  fs/dax: Properly refcount fs dax pages
  huge_memory: Remove dead vmf_insert_pXd code
  mm: Remove pXX_devmap callers
  mm: Remove devmap related functions and page table bits

 Documentation/mm/arch_pgtable_helpers.rst     |   6 +-
 arch/arm64/Kconfig                            |   1 +-
 arch/arm64/include/asm/pgtable-prot.h         |   1 +-
 arch/arm64/include/asm/pgtable.h              |  24 +--
 arch/powerpc/Kconfig                          |   1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  52 +----
 arch/powerpc/include/asm/book3s/64/radix.h    |  14 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |   3 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   5 +-
 arch/powerpc/mm/pgtable.c                     |   2 +-
 arch/x86/Kconfig                              |   1 +-
 arch/x86/include/asm/pgtable.h                |  50 +----
 arch/x86/include/asm/pgtable_types.h          |   5 +-
 drivers/dax/device.c                          |  12 +-
 drivers/dax/super.c                           |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |   2 +-
 drivers/nvdimm/pmem.c                         |   9 +-
 drivers/pci/p2pdma.c                          |   4 +-
 fs/dax.c                                      | 204 +++++++---------
 fs/ext4/inode.c                               |   5 +-
 fs/fuse/dax.c                                 |   4 +-
 fs/fuse/virtio_fs.c                           |   8 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_inode.c                            |   4 +-
 include/linux/dax.h                           |  11 +-
 include/linux/huge_mm.h                       |  17 +-
 include/linux/memremap.h                      |  23 +-
 include/linux/migrate.h                       |   2 +-
 include/linux/mm.h                            |  40 +---
 include/linux/page-flags.h                    |   6 +-
 include/linux/pfn_t.h                         |  20 +--
 include/linux/pgtable.h                       |  21 +--
 include/linux/rmap.h                          |  14 +-
 lib/test_hmm.c                                |   2 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  59 +-----
 mm/gup.c                                      | 178 +--------------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              | 248 +++++++------------
 mm/internal.h                                 |   2 +-
 mm/khugepaged.c                               |   2 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory-failure.c                           |   6 +-
 mm/memory.c                                   | 114 ++++++---
 mm/memremap.c                                 |  38 +---
 mm/migrate_device.c                           |   6 +-
 mm/mlock.c                                    |   2 +-
 mm/mm_init.c                                  |   5 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   5 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/rmap.c                                     |  48 ++++-
 mm/swap.c                                     |   2 +-
 mm/userfaultfd.c                              |   2 +-
 mm/vmscan.c                                   |   5 +-
 59 files changed, 485 insertions(+), 869 deletions(-)

base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
-- 
git-series 0.9.1


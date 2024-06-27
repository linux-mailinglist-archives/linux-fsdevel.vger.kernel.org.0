Return-Path: <linux-fsdevel+bounces-22567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB546919C40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2346284328
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22081F945;
	Thu, 27 Jun 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOUHuXR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9921CA93;
	Thu, 27 Jun 2024 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449703; cv=fail; b=QHBhVc8xsqSzkXVEhbZ1NtyR4ZKwxQqjqsk/QKJROIsK8EPQt8LHrHbERxgai13AngOtmbpIgCMoAddTIoABhBvLyse54AO9fiI1A6eEdGzMmVZfSrF2yIRClCcYfkcCfVW/wLDnVZfezemhaiy1h946ZrfS6CXEpHUAXJHqzSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449703; c=relaxed/simple;
	bh=lDuSfWUlhgjSc0DqR3/BqME9u3aJfNYh5FNr5DoKrC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d1DmlEXN9vH4sSBmMjBMt8vhRAOFuuv4xtOorTZWjCJUZqw+qbE7DZxKfUX32XeGu1T2rl1u449MjzRvRp8yzXyC+D1mNBYlgUl1Hq8k3dLLWz9whyeMz/e0jnvufNHFlKFYMUpUzz8bVBi4bBiYMlETjPHxkx6vuRxjEbBHc8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOUHuXR2; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/+1im9Wg+1Hj8R5eBNK8Ghn4Zm1iAhxp9RbURrEcsMP4+RBF1l40BlsOmF395e4rz9r30Dun4Ng1PJTr3NQZkUxIoyVojbDuheWHDYiisBuJbfsXwEA6sp3cgSvH4wPzCnU0XGg7a02TY2uWFJIFkTk2pEiXA0/14br45vP98u23N4b49VTOnVR94/vH7au0kpmrvxX1I6uacq0lyDXwiHU59sRbSttJihZiXYcLwEUfd8GlOfxtQVrotxNEvHewG/pTxf9npSgXBEFEoYvrMWk3e0PQCLbDiajnkG94ESUvo5n4vtfRDpdg0mNfq81gtgnWau9Zs0JiAFVYzMiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl2/HlMeBklMNcqOSvoLzCBY1HST5wM2+mfyJFbUiaU=;
 b=VYupiNs2b3HFY7Emjyqi51Bus0msopOJQT4/7fLXaaLQoghV4A3FDqV/7NRg8IpVt6LdvuKDuFSlNcT41hamZX13MW2eVDPbLEa3PlTU2hQpQSxENF4Ic5TOeQbX9s7Z6hYU0ldzY2Q2/7JosGIJzq37+yqEnB5tQP60quzCCoJeobOjDsNorkqtYJaj2kj0WvpDwDzBoBKWsPJHI4xrBbxsUykKxY8xUUBWVWg6201yNsNNjwXh7T2ypJaxmGaU0rvxcobcCurborophAR5vx9XskHt6J7L9fFQND0GV8nGUpQZV2EPEd3C7KFS6Gx8dntFJRaltVBnWkzmLdZgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl2/HlMeBklMNcqOSvoLzCBY1HST5wM2+mfyJFbUiaU=;
 b=kOUHuXR21vB7ce/V7GuZoaUnCR6Ly3cOMrMN5O+55V5E2ePUCoeYQZHtU9al7B39p8nBcnKZYejwz8vIXQVjpxUfLS6gS/WJFx6Vz4s0XNX0WTuRdPQw1ugoiRCDFV2UChqWe1PbFd4b7I+jcGfr++XMLnbpCb5o5t2EqTbWagIF5dC1FmZM56zTkIryIASqfF73MlVClejuyWK6PLPv6Z/5ge5YSjlAyI8R7wQsvXmofaWax0noBOWKeNfM3OhfNCzs/5y1gCMbXECrABa77E/hrrt+LQGfsAY2rvsOYmSOQYieMikdjEOcwzLw2JNeeonfL6tqPlLuUn8C5rpBYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:54:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:54:58 +0000
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
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 05/13] mm: Allow compound zone device pages
Date: Thu, 27 Jun 2024 10:54:20 +1000
Message-ID: <e5caa5ac3592dfd360ca44604a5b7c8b499976e8.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: f711c151-0360-4be8-10a1-08dc9643c443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+Ji6DziS2gkSBQKiQfxM5SJwLCreKhG+0QwMpZvAC2RABGzBiRnU7q4c8Bv?=
 =?us-ascii?Q?Hw/Ksx4GXTqSvm99bfrxKMNCYaBq1D3WGBQMJ61FHarpVDilQKFMZ0ilzGV+?=
 =?us-ascii?Q?+PwujpBoS2Fvkp0eWMkaITtHavAC9/87++syCxczWfG2IzX7RRbPKu3riLUy?=
 =?us-ascii?Q?18QOO6FnUhAepKuZrHyvavlx7cDd84v6NTzy1ryPUnCiU9Ern/yEbt4jppIb?=
 =?us-ascii?Q?QhiWYE9dH6yt7+o8dPXHC6i7z5s0XpWRFrT5+9l/d4cGJ6GPid0owrxMaqbC?=
 =?us-ascii?Q?ufTQ1Cp7hbZCSxkvlBvrLPEMVXsfd9iuIghdFE+eo9n3B+NMqca8q8eH3Z2i?=
 =?us-ascii?Q?WgEaG8/sGIFIj52ttpvn4hVXdTDJMPQktthkd1C07jLD2otWReGHB/xemh7i?=
 =?us-ascii?Q?fiTfjoACXyTuLPeau2YceaCgwXwPWBw9FODDxGEsZ+3rt+79ZbJYpadGBtFz?=
 =?us-ascii?Q?qNY4T8NwpmPQ78Sivor21NkmphqGp1G97jJqgzbGYbh2wEZSt3lGp/Y8zE5E?=
 =?us-ascii?Q?0IS5cqk9eg6isHJp1caalP/te6uskAa/g0At2Z1ryoOKwv0YNkWqqA8QqYkT?=
 =?us-ascii?Q?yfE6P9tSYfb+jf/gGFnqj/7wviS0Wui3YOLxDlDXuSJaHJe4sEnAq1vUW190?=
 =?us-ascii?Q?8kVoc9u27Tqy4wCVGfhMGD3dHGq+BD5BRFXIZB9jtf3J29Gfc2jDeA9ouRvs?=
 =?us-ascii?Q?Zvck5dUdmRpCwfAq8MGZ04/2Beu4DbltfkxInksKgzrcHvoV+pkBfLqSR1iS?=
 =?us-ascii?Q?Hv3WW6hp8py3ZJpWOOtF6YFNWipLhRoY4c+laS6NE4ZH7lM4JXo2VxcWWXQZ?=
 =?us-ascii?Q?ggd0DjQxlqI1/TxP/WFj+x1pJD7kKX84H6nkXGTmlJLDBr4iHRwhzeaqpCud?=
 =?us-ascii?Q?2wx3nyKwzYd+LbIqgjBAReMwr6SmGNuqQOr77nJD2YQftm6Pa+uZU/vJ7SOZ?=
 =?us-ascii?Q?1MUa30SSmCdYzKksB7iEGmuGD7vUWUed0j3nC2kGiTRqcOJ8o5jgmBsffr/j?=
 =?us-ascii?Q?3hzX3kOP8pdq7rJNBXVRKVX2sndFQ0BZb3tCT68gyYT9J/xXMP81gYdP75ZE?=
 =?us-ascii?Q?Fr+OREijch5jxLgzVWXYQI1n1r2n4veyde8jH2JvlXl69zsP7lVeVZCDnoH3?=
 =?us-ascii?Q?0FRX1UU/cUvRYwHCu0fWNq9bwBLVvIQDqCeV2Snim/AlIebjsQuR2Edsyp81?=
 =?us-ascii?Q?U2ZMRvGkVh6cnKwr7BIyUlBCdm3a48zkagJmwKdNmbqv9qrouqV4dzsCqFNy?=
 =?us-ascii?Q?y92ECKr0s4wIOHik4fpH19k/Nc9Jks6l9LUDTeg2tipSPyMt4Wor2D73wJxP?=
 =?us-ascii?Q?mzX2vmY4VdvvJ6SWO4jZULPGqZRv7FQX3KCuTUJSIKtjCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eg8znclncNP70gE2sr1mpDccRz5CdT4JR/6cDRuJxQfgnqNkDBCyE/HCzZgw?=
 =?us-ascii?Q?/D8xQEEBxmQkrwnGWiSGbcHGkP49lPpLn4zw7+U4hn7aGs8RINWsie1kd468?=
 =?us-ascii?Q?qNBXmt4IulTYb176mDV8vbYayQJ6OSULS6wEBYqDCrOHSr+rrsnh0uKFk2JA?=
 =?us-ascii?Q?TIVOBJwbNsIRrXReLfb0hyZ/UMSUGXAAKYnr/4EOTApxnzmLsPpxhYBuNtBi?=
 =?us-ascii?Q?KUj9oHCzMzHY6CK8Iq1wXmGV5GrZUzw1sRQSrTWuD8xo57FOFKfVJzvqqRuI?=
 =?us-ascii?Q?KjFKppP5htNPbAQ61q0fudAWdqTxFVjOlO/Znfc9ucHNmjEg4clzGl4Ecr9G?=
 =?us-ascii?Q?gXYB0Q7wZqtiHWkURhnl92M/GTm6Wie9HLg7zQmgzVijUKfjw9s//oJzL/DS?=
 =?us-ascii?Q?9q00GGbmHZpvjOwNcx+K7OedcuyDBiqg/zlxRC89rG/+kRRy2ZXYQLuGT3Xl?=
 =?us-ascii?Q?TxmqDBQKX7N/M6I1DmOyqdS7rU9WZFODjxfezqQsPa+ODATdIdSvxHm73z3J?=
 =?us-ascii?Q?a5Ctc49Zz8MpqphLKIhtACoFZK4kDpaoj0kOvjFObWVZEB7BYkP5huWrInZ1?=
 =?us-ascii?Q?kaiMTjKhhjA+Yvk+V/gOXjr1T9Nt48gh8bOrl6Bn5kEguB3IDMIVn2i3FYbS?=
 =?us-ascii?Q?gt7ebSV87VEEMsPs4ZhbY4GTarxWRVCUSeje7ZoBuhcWhK2Sngha0D+s5M7O?=
 =?us-ascii?Q?pvfsHwuoPJZX2Z7JUqnd+hlZ6wc+rlJye+lOdMAHwix8W1AjWWeA01fkijw+?=
 =?us-ascii?Q?XaPgHLrXmsI2cPyExA1Kt2z8BO0kIiDC5lQlA7zy98bjw/HbwjCWCMvAToKx?=
 =?us-ascii?Q?xpYXEntzf0GaiMGpMz3tsLSEnGZuRmcVvMNA4RpGervMh7EjhJsF5JpwcINN?=
 =?us-ascii?Q?wkp2cRoHSLJRFLqyFqhltaoLG8NE9Mfvi2AmOxBwkjX/kGkJgu7GN5QGeBaS?=
 =?us-ascii?Q?xVOfQTIH1SYNdXf08p2w3kwcxQdss9cOMMZSpbty5wtSWfZUGPSLpJ4Vp1sn?=
 =?us-ascii?Q?o0H7exCI4D8GpILYrbemqdY+ByLRgUPj2X7sr/NYFsti86/eZzHSr22tre+H?=
 =?us-ascii?Q?tJsACJSMpqxet/+DHa/O4x4HS+ZRweY3U4nwYhSZSq9JVTqmisMmqmQc/2vx?=
 =?us-ascii?Q?yIptj9OfEaOccG9FCgkK3wgucqbIP4nTHcRu7lNwytH1fSNnZkSZrXA8sdrh?=
 =?us-ascii?Q?/etJT5/yiyAHb/INvjcTckpJqnCS1pszbZUdazWaZLFB9nd8C2GbY99ibH5K?=
 =?us-ascii?Q?bFnIuAK5h6UV6RoD3uPHFiqz/TSRlOfkmuUMkJHS8d9pmOCxLPFgikFYBT0j?=
 =?us-ascii?Q?rshK6KHxvbx/mSeADY6qphgrI7lYDvAZR/UbnKfVQay4Sz2uFJVRXSgD30OT?=
 =?us-ascii?Q?QnoP+zd1alTBQRIS+0oPXba7Cd/yQdi59e+w5kIUlvc1U4RVW+r4iMJFcEi7?=
 =?us-ascii?Q?khu/c+F0QuAeWzuz7t8CZ4HVa31fiJCwMdK/DuIEBzesKcPv5qY9hClXlQWH?=
 =?us-ascii?Q?ulo4UjYw6kTS14syFEJO/XFQbFQYJj1HJD59o/fAZacTGthbxKKyiHYL45P0?=
 =?us-ascii?Q?2JDtOVt9/N5fIgNSV8g7xOeVG6Mck64Ye7V3lJbV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f711c151-0360-4be8-10a1-08dc9643c443
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:54:58.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbwm5sX7q/04XauDJ1H5ddMRfz6qo7yI/87yFCY3o44qcGCzXLX2dDCYOwcdXdzP4mFGU1u0mvsUFn6L9nbGQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

Zone device pages are used to represent various type of device memory
managed by device drivers. Currently compound zone device pages are
not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
user of higher order zone device pages and have their own page
reference counting.

A future change will unify FS DAX reference counting with normal page
reference counting rules and remove the special FS DAX reference
counting. Supporting that requires compound zone device pages.

Supporting compound zone device pages requires compound_head() to
distinguish between head and tail pages whilst still preserving the
special struct page fields that are specific to zone device pages.

A tail page is distinguished by having bit zero being set in
page->compound_head, with the remaining bits pointing to the head
page. For zone device pages page->compound_head is shared with
page->pgmap.

The page->pgmap field is common to all pages within a memory section.
Therefore pgmap is the same for both head and tail pages and we can
use the same scheme to distinguish tail pages. To obtain the pgmap for
a tail page a new accessor is introduced to fetch it from
compound_head.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

---

In response to the RFC Matthew Wilcox pointed out that we could move
the pgmap field to the folio. Morally I think that's where pgmap
belongs, so I it's a good idea that I just haven't had a change to
implement yet. I suspect there will be at least a v2 of this series
though so will probably do it then.
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
 drivers/pci/p2pdma.c                   |  2 +-
 include/linux/memremap.h               | 12 +++++++++---
 include/linux/migrate.h                |  2 +-
 lib/test_hmm.c                         |  2 +-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  2 +-
 mm/memremap.c                          |  8 ++++----
 mm/migrate_device.c                    |  4 ++--
 9 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 6fb65b0..18d74a7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,7 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_dev_pagemap(page), struct nouveau_dmem_chunk, pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1e9ea32..d9b422a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -195,7 +195,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_dev_pagemap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..6505713 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -140,6 +140,12 @@ struct dev_pagemap {
 	};
 };
 
+static inline struct dev_pagemap *page_dev_pagemap(const struct page *page)
+{
+	WARN_ON(!is_zone_device_page(page));
+	return compound_head(page)->pgmap;
+}
+
 static inline bool pgmap_has_memory_failure(struct dev_pagemap *pgmap)
 {
 	return pgmap->ops && pgmap->ops->memory_failure;
@@ -161,7 +167,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +179,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_dev_pagemap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 2ce13e8..e31acc0 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -200,7 +200,7 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
+	 * Set to the owner value also stored in page_dev_pagemap(page)->owner for
 	 * migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index b823ba7..a02d709 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,7 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_dev_pagemap(page), struct dmirror_chunk, pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 93aebd9..26e1905 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_dev_pagemap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index 25a77c4..ce48a05 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3994,7 +3994,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			ret = page_dev_pagemap(vmf->page)->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index caccbd8..13c1d5b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!page_dev_pagemap(&folio->page)->ops ||
+			!page_dev_pagemap(&folio->page)->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,7 +486,7 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	page_dev_pagemap(&folio->page)->ops->page_free(folio_page(folio, 0));
 
 	if (folio->page.pgmap->type == MEMORY_DEVICE_PRIVATE ||
 	    folio->page.pgmap->type == MEMORY_DEVICE_COHERENT)
@@ -505,7 +505,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_dev_pagemap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index aecc719..4fdd8fa 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -135,7 +135,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			page = pfn_swap_entry_to_page(entry);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    page_dev_pagemap(page)->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -156,7 +156,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     page_dev_pagemap(page)->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
-- 
git-series 0.9.1


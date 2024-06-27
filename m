Return-Path: <linux-fsdevel+bounces-22568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618B919C47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF60284295
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4328DCC;
	Thu, 27 Jun 2024 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lUrLIacI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1F8836;
	Thu, 27 Jun 2024 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449709; cv=fail; b=pEsC/ffPRvWT5gn0Mo5yzREPaihNdk/NW1kP76ClnykRm5iMxsyx9EWgbVbeovpIYnmg9w3OmN34vbvrCkOxYUUcg1Mw7ZaHDKjy5sofCfDPMaNb+krN3ssdeQQShx6XD18xMGs0bhsVnm2cfWcnFMhU0jufrOMyJl1ko8seNCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449709; c=relaxed/simple;
	bh=yiYk4ZVhdGpw6I2jrZ29ITRgyICdMhOWkgra/OxKjYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6szShBMBpQVxImgThpWfNSaEgFjFESz4CQCcWVT8vsugYRA1dHWf9Cv67VWuauPHoKsgltAKlFtjzWdOh3p8abVuTVD7/oDIku1ghHH6XjPxWji1LdREG6PC84rWX1qlt4IgLHqITebX3wPRRVi/t+IExoGjXZ3OUMaXVl/ScE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lUrLIacI; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRQ9UMZVvQJlGA1JyILEsfYbqGIwEwcdKAXQOgmUNiWA7P5AQt9oPzwXy5HujfzfKUarlk6coiYV6cLGmxLazadSEJvpmn+pqf4QJEt/8/pXTfg68uCcISI/yL5E1YsF3vaybffvplTJy8EkA4JJ+CO8fkS7AsToXc9Omzyh3N2qRvY0Yi6wZZH/Lsc2rjUHuDL/9Nkaj5doFnP1AG1wWP9RxejgaG3vhkkVgKt1NmJHAQvTOozBRD3IJusfadKlHe3PtjQ6pniG+jKVOgXOMhWzAZlRFUCqUT+UuLFqf0R2Tincz34zt5iKMKaoBF0FogEiG3tZnWuA7fYlDse6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwTuajmqH/Dz9iq8vwzSLICD/nvk7k2MSnhgTVOPjdk=;
 b=SotSGtBw5bAhGNtC1Jzioabd3HF5PsxXFPJbKEL9RoX+3N0+VsGo7IL8Qe7r2aWxAp3ObpOBxcxIL0iPbCLTDP4CDRR2k5jSmAgX8xjxFb4uzAUp9ntweB/7NhtLO/ozD5oGBBZfY7OiX51JXc0tI624Kx1jVgpWxd4S9mYPG+ep2QS1FdGSQ65tHdRlPFLhiDSKH9ajsxxBku29Kjr4H16fJQjX14676H6p68anhXCpufLQyI/tMmZ1sfijJa43BfAF98kwqCLJTDNskUs5oNOioroeBFIpAMGZ6CjDdS73R4N/0ZqMC+9n0FxJW88TNDgGHipvP8uvyVHMtdi0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwTuajmqH/Dz9iq8vwzSLICD/nvk7k2MSnhgTVOPjdk=;
 b=lUrLIacIPI/ywe/gFyfRXydzEzVgb5vC+zFqv2bWT+0XpKyMlLqNiNEv8jyYDHVVFpF4V/N/MtcjeNh9Q/J17rsPMvSZCXsYMYLr0MwSv+XAk1xHRiU5WYC9vk8oYm9j1717bX6nCSKxYYKchAHIGzNGMljvpVEnnHTf9TZFQj88jGCTTOapOle7GsFWHTg32kyjJMdx3j7Fji3QfePoiU5dxwU9JPS4oEwgB4Ja2uy+pUUDae1moUe70tvba9NR/QGZ90Klvv/TIeWw05lYZkOVR2zR6dw99KPgl4ZjNmZAFzMY6IMzhfPHOiJ3Di2h4JCOjhxun4qKotOwseAp3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:55:04 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:55:04 +0000
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
Subject: [PATCH 06/13] mm/memory: Add dax_insert_pfn
Date: Thu, 27 Jun 2024 10:54:21 +1000
Message-ID: <50013c1ee52b5bb1213571bff66780568455f54c.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0090.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: f829664a-b39b-46d3-4f65-08dc9643c831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYXynZNeE0+XENjHJM0WN4qEdMZjjd6nLh0DgkAMDNpJSxN8LmPNHzTyQ0qY?=
 =?us-ascii?Q?PIm9wx2aC06AlJYDXpYQ4qX4Ry0J+4AkQovojUMHpvdWESfdk48hRdEHNks6?=
 =?us-ascii?Q?iI95PGkEHYkI4+/Q3nhyuao5pv1NwqOAUfHZSY+Q0XI2r1iDzRtS7CviPVwg?=
 =?us-ascii?Q?juWQVT0Syb05lkpi4jOhoUJkuauY4xmeRqeNpojheVzruW3NLmBo34szDisf?=
 =?us-ascii?Q?F25nzo+s5j9o+H3g/NC8gb0coC/txPJ0x3MlbAx8xtvqLUQQP/J4q4NIy7AY?=
 =?us-ascii?Q?UrXUiDZ1AL5M5kxRApYMvFVTbyz+c4O/SLF2U3FeU8K2CurPPMqJi5PU9mvf?=
 =?us-ascii?Q?kluoBLzVrCSJrPJCwOEzT7yr/e5P9kp48EfKYe9cxsWZomvZZXmAwgvgkTHZ?=
 =?us-ascii?Q?NShcLgF9MPeaqR4L4qpRnS+nkYD9OaJrwjv7PWH+1E9V5RxjKYrOdFa4xwKA?=
 =?us-ascii?Q?Jscu4t0xyQQdNVSYynvm+2TKum24alwQewLK8xACj29y1ublCfTYBZ3Nabho?=
 =?us-ascii?Q?fNPs8021qR3+Lc4qFD6uVpDuzO+pMWvaytkSlJ64PutcyQhxP/Yiqz6JmbLb?=
 =?us-ascii?Q?YKGAXpFTTjIano+35mundFPP/M9AMgNJaotCYWgJJQa3rLv0EgzL+ip7OEz3?=
 =?us-ascii?Q?+KVBCHFOK+6TMkcwcEUYi5BQSNS9XslcXGTeVShovqfZ64bXogVe48bJUFd1?=
 =?us-ascii?Q?Za/sKldN+QrcmtX3HjfoKZivSqZ0CeW3FRBImdy4c+z6NjGV/CXBqkn8DzMi?=
 =?us-ascii?Q?wyVd/z3KKFG4K9dCFJv8uWt6/NXvECp3YZG5n8rzOTfT4zxrSzlFViiAcAnG?=
 =?us-ascii?Q?FZ56QeuKrnK/bm4f1LURHPFbmlR9v2+wMMNT51gRmGw2JG/R53rUwMQdCuhw?=
 =?us-ascii?Q?HofJx6pgsu+w07CznWWz4uG2+11TIDhIeAAx462U9cvXFcO8PErK3R+Medmh?=
 =?us-ascii?Q?Dxqw8ZUfMkVXCO8HGU1Q4IDFUeO7OolWYx5asTi0eIyvuHEbUwp2tQ4XMfxn?=
 =?us-ascii?Q?F/mAn3B3mBs3y+GGVV3ba+RWR3Pe1lcxibb34ibnkphVNp/x2Drvu0nhFszz?=
 =?us-ascii?Q?7Ksx4EFA7N6+4ksSsuN/edZwu0WfJaoGVibWUyWwEMUNeItsSShjKOzf1szj?=
 =?us-ascii?Q?yrvgFFh71fBgN/kFCbFUNYVr3Aknfo/XQdfrxUX9bosPaXLY78ltdVm/Yeoe?=
 =?us-ascii?Q?OeZ6Jj2CheB7ci4lwVqRul42B5kyhBAQgQXulOccVUWqm0b1rXjNG2Pc4HqQ?=
 =?us-ascii?Q?AbtF0JScDW7Rl/6xCIZpJxHHxuAkfiw6mbuvwqd9+sjr3ywY6sy5116nb8W7?=
 =?us-ascii?Q?1evlxZo8qa3vNS3br4WTpvEX8gmYzdf97+ZvOYxAHwfZGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c49ryrsnGaEKkZ0paxxpf8ffnzOPK3NhW6sv9Z9P/3NjUpF8jPcWaewk2EMC?=
 =?us-ascii?Q?bJKkmI4Lo9aTM5kPWJllBB0yaYEVZ7eXRHq7CfBSqfdYqoKk8EjAAurW0fpr?=
 =?us-ascii?Q?3mzs48tY+Do7b4td9ae5z24KRN2EE6L9Z5sUwGG0keGYsCEXk3rdx5FP25lB?=
 =?us-ascii?Q?PSAmJNqs5foW+atTN8PuQeSfYjZAXoaIGZLjWEmNWjkjSG7NTmNd4249hvPZ?=
 =?us-ascii?Q?Km4P1IuxG/3ENWj29PAY7gYqVX/jaM/EIZJz59f2K1ECnbHhluuCc6XkBTOe?=
 =?us-ascii?Q?XbTYqo3L9GKH6iJIWMNxiqU3boQKigjJxQ3Tt/Ln84k3g550uhSwcYV7YQ0o?=
 =?us-ascii?Q?4arjqnT+s1xiErJPM9ub71r176CPAy1mzfpH1I9UVzQCAM6TcWdV2scrw3Gr?=
 =?us-ascii?Q?pvWYGX2yNzk3zjA3Ofc6DF5E5vmpoz5FlTIvS5bhawMW9vOUkLm8i2bJoia6?=
 =?us-ascii?Q?I20UPKcYRLRDsBXemmIkHvYXiJD1HmjVEfgiNAc5SWmR4ZxhXNIvBfTmvzky?=
 =?us-ascii?Q?AkOVLoGXclj1g6iu6KF17YtbhuSB0Zb4Q+87O1jSMTwrOs8Yk0Q3qW/EdaqP?=
 =?us-ascii?Q?K9XjymTlxNIHc6HK5L+X6ouPfdCR1jJpykJ+r7q0XWvYE5E9hV4dqncixJMw?=
 =?us-ascii?Q?Diz8HwJ9BLhsnR54vBHfaNgGAxElfQuI/+7MxvuJMnp4BntCGq0yBvC2h6pg?=
 =?us-ascii?Q?y3jWpI9I0GWVnTbTE2Z/7PylfP70TLu5NfpyvL0gFRLeFiCxeRBQEPmDEOHg?=
 =?us-ascii?Q?CgGBq9Zf2p90YHiwvpPi4HZeiu2w/y3tGbM5ew40WyoJsiDnavdb9VBlPaVX?=
 =?us-ascii?Q?4P1ZE5cMhAgSfQcq5wd7q2pvKMrI3cGLvIhCmI0pkPrXEdZySeHV5eEEM72G?=
 =?us-ascii?Q?K+J/bozOrj7dXJYvZqLHlxU7NYW646DFfviZ7I4RM8UBaBuRagksg7SDOwNy?=
 =?us-ascii?Q?+RgfBDpp7esWbsSDu7y1W7aKiW1nVKSgDay9S820p6FORmaF9WEUnauRZilV?=
 =?us-ascii?Q?Oyl/iVkiK3nIxohSPGlMD2IM5a4d7yWl10sLQ2yXkGKUid7HySJXAidXf9Er?=
 =?us-ascii?Q?QsuyryMPZWXRgdEm6ObzOudLTTvz93A8R2DnPFFY4nSLz6gTTIQ7WvlUZniq?=
 =?us-ascii?Q?ngsrbouQNZNvBM1ALPFj9Piv1DP/n5yelLFqd7o5+hx2zCDBBIDnCNPI7yPf?=
 =?us-ascii?Q?PC8lZDuVfZkQE5Dfk1yOkSbw+lJwf96BDu9VuQjeP6cRL42Wx8TvESanzzVt?=
 =?us-ascii?Q?j1W0YwAHDHnMm5tP1XS5raDJyYSY9zw6VuANTsYI9bcg7Xbbsuig8PKMDi90?=
 =?us-ascii?Q?F6vSCz9pszOqX+u1rdirc8feRelHbHn6bQ1poL/RpZ1qizRoom0xo9Pwlt7N?=
 =?us-ascii?Q?poMX+DopxM35juBU38KNIcSvkeblPpwsjVakYztjLrR2Vg7bmmU10qG6xsWg?=
 =?us-ascii?Q?Tln6xnr/sSaj0rdNiBjn3X5Ej/AqDlowSfHzv65BOkIC5p58du503QpbkUH4?=
 =?us-ascii?Q?UJH7EikznB9Iw1qSQTAxVVcwnrrMOsh98Orp7f0remHuNP30BOEz56U776vf?=
 =?us-ascii?Q?8quyUGzvdO7tTDnoyLxIni5Nsv8IPTrS9z5GOWPm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f829664a-b39b-46d3-4f65-08dc9643c831
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:55:04.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VP+IB+RrKOqGr43kzXBieunOvUrssGRIP9nq84UcCbyyH4uUIkcIvvcuTsr07JP1Uuf/DAVI/7xcJTTj2DABTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

Currently to map a DAX page the DAX driver calls vmf_insert_pfn. This
creates a special devmap PTE entry for the pfn but does not take a
reference on the underlying struct page for the mapping. This is
because DAX page refcounts are treated specially, as indicated by the
presence of a devmap entry.

To allow DAX page refcounts to be managed the same as normal page
refcounts introduce dax_insert_pfn. This will take a reference on the
underlying page much the same as vmf_insert_page, except it also
permits upgrading an existing mapping to be writable if
requested/possible.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/mm.h |  4 ++-
 mm/memory.c        | 79 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9a5652c..b84368b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1080,6 +1080,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -3624,6 +3626,8 @@ int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
+vm_fault_t dax_insert_pfn(struct vm_area_struct *vma,
+		unsigned long addr, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index ce48a05..4f26a1f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1989,14 +1989,42 @@ static int validate_page_before_insert(struct page *page)
 }
 
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
-			unsigned long addr, struct page *page, pgprot_t prot)
+			unsigned long addr, struct page *page, pgprot_t prot, bool mkwrite)
 {
 	struct folio *folio = page_folio(page);
+	pte_t entry = ptep_get(pte);
 
-	if (!pte_none(ptep_get(pte)))
+	if (!pte_none(entry)) {
+		if (mkwrite) {
+			/*
+			 * For read faults on private mappings the PFN passed
+			 * in may not match the PFN we have mapped if the
+			 * mapped PFN is a writeable COW page.  In the mkwrite
+			 * case we are creating a writable PTE for a shared
+			 * mapping and we expect the PFNs to match. If they
+			 * don't match, we are likely racing with block
+			 * allocation and mapping invalidation so just skip the
+			 * update.
+			 */
+			if (pte_pfn(entry) != page_to_pfn(page)) {
+				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
+				return -EFAULT;
+			}
+			entry = maybe_mkwrite(entry, vma);
+			entry = pte_mkyoung(entry);
+			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
+				update_mmu_cache(vma, addr, pte);
+			return 0;
+		}
 		return -EBUSY;
+	}
+
 	/* Ok, finally just insert the thing.. */
 	folio_get(folio);
+	if (mkwrite)
+		entry = maybe_mkwrite(mk_pte(page, prot), vma);
+	else
+		entry = mk_pte(page, prot);
 	inc_mm_counter(vma->vm_mm, mm_counter_file(folio));
 	folio_add_file_rmap_pte(folio, page, vma);
 	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
@@ -2011,7 +2039,7 @@ static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
  * pages reserved for the old functions anyway.
  */
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
-			struct page *page, pgprot_t prot)
+			struct page *page, pgprot_t prot, bool mkwrite)
 {
 	int retval;
 	pte_t *pte;
@@ -2024,7 +2052,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot, mkwrite);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
@@ -2040,7 +2068,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 	err = validate_page_before_insert(page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot, false);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -2177,7 +2205,7 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vm_flags_set(vma, VM_MIXEDMAP);
 	}
-	return insert_page(vma, addr, page, vma->vm_page_prot);
+	return insert_page(vma, addr, page, vma->vm_page_prot, false);
 }
 EXPORT_SYMBOL(vm_insert_page);
 
@@ -2451,7 +2479,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		err = insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
@@ -2464,6 +2492,43 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t dax_insert_pfn(struct vm_area_struct *vma,
+		unsigned long addr, pfn_t pfn_t, bool write)
+{
+	pgprot_t pgprot = vma->vm_page_prot;
+	unsigned long pfn = pfn_t_to_pfn(pfn_t);
+	struct page *page = pfn_to_page(pfn);
+	int err;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	track_pfn_insert(vma, &pgprot, pfn_t);
+
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * We refcount the page normally so make sure pfn_valid is true.
+	 */
+	if (!pfn_t_valid(pfn_t))
+		return VM_FAULT_SIGBUS;
+
+	WARN_ON_ONCE(pfn_t_devmap(pfn_t));
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
+EXPORT_SYMBOL_GPL(dax_insert_pfn);
+
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		pfn_t pfn)
 {
-- 
git-series 0.9.1


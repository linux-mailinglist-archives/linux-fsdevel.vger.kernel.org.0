Return-Path: <linux-fsdevel+bounces-35520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CED9D5774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB667B238EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C918B468;
	Fri, 22 Nov 2024 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OYJW1dvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C20189F43;
	Fri, 22 Nov 2024 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239725; cv=fail; b=ef1nnaMKFExvScylO2VbgTsG11cAm7SKa0MDCOQtuYnBVZBoZu5ywcAcmodcHy48/0Fh3GmCuSYFnbVjWAFy/cH/kSCEtF+fgjX1eWCaTTjmlQOpRuWRXNDNwF9+RlNvJaIz1pjEe3FKaIlZN40zho/B+SoNgskw8ttslKGRDVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239725; c=relaxed/simple;
	bh=sJ5Vy/ETsMV56ox6ODm2ei1GasZtCj/OhuxBEbsezbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dy7svHtZSVNfWH8+kfijnPRkr7Z1/EnE+zl7nK9UadwqOwqtZOs+VDuku2YnqRIoc3BoGjiC3yTBxrePGqLEELSMQ7RmAHNJ/3vu/EBHvvzCerAeKWq5qIHzQMMmp4MVMUr2ZVW0L9NfaGBjN4a7eDeIOfZy64q+FPuD6rHuHbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OYJW1dvI; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWBmTTYYzU1NCk0+cmFiijQTTh+mKxErkBZdblt5WylATjaq2qhmSl9dVXS70nZ64xK5tAwMN0E038hnXw0Aaf6bv75jZVglj+BGQ5kCamC2IRtWdS4vQSuu9W2/KF6F6aZW78ruqEHyJCAmePr75KnKxcM4H2wwKPSnOpem+sBY7UhhEjqMVjshTsH5oECyUC825YQPSP9aR2nAWrh9Wx82f9MGIomltllLMglC1itioi8lf1t4QM2yifDUbnIHcYn9eaJofxvj6kimeTrVra0iDHMZJoFb+/HAXbDZxIifD4PQNdlZtr9phTkF0OV56CTiNktWm2g3iGN/V0+FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygxL5uP66prRhNdyxIEj8y/1Y+Joj/a0lQHhMsNm4r8=;
 b=QWi5TdmOtO/dSb3nbtlQmS4CZL9iJNaIsT0rUHqImMEd+VzTRsZDkxokP+3K9gW8hEn5YYMUXMSKfBWPVRl06793nSVXB5huYTxVBpxjs3PHx5jbixei2Bd3oaLDrqPYofLc9H5MxYOhYwnoxspcljE7N/MpgHNgxrn6S4xrkGX16hwbSygweGPc9aXI8SHNVEUkZBBN62IKB/vtBql9vRkVXcGOK/M6seTmmZn8VB9162g6OUI2TplGPyxTKCMyDPYRrTpjQoX7PaHAWK8VSr/BSfTJryUgXwpPLL6DxL8ZnPjMFFRPWyJtsxi3K09GSo0WQt6CUPxQIBJIXWg5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygxL5uP66prRhNdyxIEj8y/1Y+Joj/a0lQHhMsNm4r8=;
 b=OYJW1dvINY0KOgyRu1VNi8SFTzdXjmEzXVfN4dF2wvVOmAraGqNtWJmEJwqJ3OU2XvUR1bdEGpwV9dZ2f5WKWaBdkx9TIqeTfYZ3Rf/e0+yjGI5LZJVFeWVguPv6C6ApO08tCwkx5ReJhGSCJhLpJFPx+3sY8pWMWNoylluXlZPh/ECY1Z8L5NV8GjhA0OfvL5haHxQnIpEDE48/SXRpjxIw84kwZ5hy2GHRilwJJEBC+odGTTxJaKQ+1orNbTw8C9YScf+8ZXpDz+v1UZPNSNGqsMh0/4ZqF8RvW4m6WeEyOcmMq+cEsg37dsWP3bM/dTuOEpc2xlgAvGuv8RIgLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:42:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:00 +0000
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
	david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 11/25] mm: Allow compound zone device pages
Date: Fri, 22 Nov 2024 12:40:32 +1100
Message-ID: <f1a93b8a38e14e2ab279ece310175334e973b970.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0004.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cf4d45-6b32-43fe-e00f-08dd0a96db92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZlUH+gGQBsO1Wi1tfiV11DS83nI58lYa6aYE/FUOeFANsD2570R0zJgPNeQ+?=
 =?us-ascii?Q?TrJhL2MTaCTBpjNbqa4D6iX8iWdNxhatiScemU0D4EQPDppCG2NDiS0R+LG9?=
 =?us-ascii?Q?ZYqQC2NR6W5L+9DNla48uj1ywRcxlYGEG0v3JoL81FejhRdQe9q/TeZB5wTo?=
 =?us-ascii?Q?evdSBSn/ThZBV6of69dAG7Y8vSrIK/3LGF0MaYdWskruKkwgPcTb/zUXLWzF?=
 =?us-ascii?Q?nKxI5mEHu/eIoN4Xug5RlzIzuR6+i6XWGv3iFzgcBCftp3rr1iw2CTVWpbyO?=
 =?us-ascii?Q?km11VAW3hypUhKUyC84G03vgklMy6Xb2Acu/6S3d6cAXHsDB3S85p3vozfw4?=
 =?us-ascii?Q?opyB5oDBKOdSWc5UYsamFGGqiKCyqv1uS7We5J/QdCFfgWuC+cd3HRsMnxRI?=
 =?us-ascii?Q?T9SpXJ5/L2m9C+5Vq7sSLxa7TKqJ4gw7QIlJOnDew3hhCu0V3C3+XBdUtJg5?=
 =?us-ascii?Q?xodYTLOr8Bea2goQpnk32T3+ou5W8z8yOBrmuR4cX3n6MGhz8QW8bTZM93gm?=
 =?us-ascii?Q?DeL8HPlkSTC7pHxy7W/uXZtm08y2vNPBlwKAL8wlYbX0Ae4HuJUyIXS9W3Ix?=
 =?us-ascii?Q?UWCdNqOIG7QF61VoWcbI/HAe6A0ILV+m2wVjy44Nk4mbZkf3TyFf/6FtOQO5?=
 =?us-ascii?Q?pRDUy5xcdKJHpZLu0p/TYaPGje54N4Wg7nchlE5oYO+U8Egf/++X5t4gHi51?=
 =?us-ascii?Q?asCUCSD2OIf1sPpCbboZ/gA4bYv83HvcS0DNordSUPYRkeQSMSPRKQzK1ROW?=
 =?us-ascii?Q?212227WCdFVGFHoc1YYAMepCEtjEkn4v18WFQbAY5GzRhxskTLADmtzLA5ov?=
 =?us-ascii?Q?XWhQB5MVOema0wTfuOUsjvtUy/DbX56PCqspYzVUYF0h7eDNo7+938kQWnL4?=
 =?us-ascii?Q?ejIPVaM66q+xnlWEwwrcFHPqTBw65rC7sGo3stmpyK8KYSHAVAYWLa6Q142k?=
 =?us-ascii?Q?UnHOAGyygXTx1++LzxKetV4O+H27N2hnLwcr0mWUDCNiKZhA/PQiCETYYwDO?=
 =?us-ascii?Q?rE7jF4/uVk8fXb+aL3t/jPCAgpdVNkJa4R/OMd9azVWhfr9Uc8hy4S4MTZAR?=
 =?us-ascii?Q?8EWOSjn2an8Z4tN55qLGZw6qAOQleFGi9LXyDbi/G+bipC9v2POfqF+x3RYI?=
 =?us-ascii?Q?UwvIpcCwjHr1Qb9rOe+TSY3EmTxUNZB7rte1n+EyADr+smJb7FYAPZOmjydI?=
 =?us-ascii?Q?YFE+B5g334DVabLs8LA6RTpH9GG4Vjy1M/ythim2uZjcUQKOVeD3ymsgNSTU?=
 =?us-ascii?Q?0d/EDzNBdkC+45ZyZaRTzSKkel4R5x0Z/wVtyfR312R4rZ3Go8OiBjbGkYIf?=
 =?us-ascii?Q?942HG31tu6X5lgAv8l6+m31F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWeLFSHzFCuqHi7ZO3jkWk7AIoV7Cs/1K6Xd4y8OjzehFWIfFTZgHK19vP/X?=
 =?us-ascii?Q?NBqZ8CQe01XA7FA5HU7MSDtXKKBWzL7D+cYQsf0PZLE/LQuR9bWBohR4e2F0?=
 =?us-ascii?Q?Ij5GrVOfOfd+c2voZ7rORjR/0CD0TXanew4+O471mLQ96V78lxkzMoh2BQYa?=
 =?us-ascii?Q?C+svyTfN94xbeu1REvGPTDShD9zJKw3E6uHGuAeNx9AbFBrDTpOh2k4vPhL2?=
 =?us-ascii?Q?O2NQfQONpLUmw+OYuOPtj6eOsv93dYAFAtURyAUY7qmmes3O5qABqb/mMZZ+?=
 =?us-ascii?Q?DZMYf42YoOSppzEwt/QsbgJ/cz8+Yy8R7ARztCljr7L0x27JfGLMdXoa3Wxq?=
 =?us-ascii?Q?2svuhozgS6qjleR3JznTQKDRo9Umt+E4JuByEOx/d7DLuyztRlksZXy89rgp?=
 =?us-ascii?Q?vqFi4SXWUtJwcJsABovz/ZSPCXg9J7uNOl5YVqpYJIWPC+nX70YtjjkVuvfV?=
 =?us-ascii?Q?T9mHSwXA3kmbWwrPZoQWvBGN/ThIMnqzhByhc9h+xk3H7CihMeawGfszjwsR?=
 =?us-ascii?Q?pRuCLI4OicKrbtPMMNX9rVIFMJ6PONtBvO8hbZoLuoP5UWpzUjhoLQ6uxMum?=
 =?us-ascii?Q?XtnAPGqqvu/81y4eUWxquegfXvfRvy7opNLnZF40NcVDNv526hoi02YFDFl5?=
 =?us-ascii?Q?1edenWQ/pX48sAlFEMNvbR9sWzLrHh/yiSOQ5jU/bIbQr+pIzYG8XpfG9v6s?=
 =?us-ascii?Q?1BfAdrQIc1y5UtwltKAg9xRSc7kENJYYOzFanqXixSnr3xqAkfw2VmZ6C2OO?=
 =?us-ascii?Q?Vz6RLqAox8GRcrGC+NEvLGRHb54rTDeaAcVy5Bi7i3+nk0K641W1dI1FHpQR?=
 =?us-ascii?Q?E6C3WdpHijKDyAYTe+T7pQxKyMdZyNuH5IkR7ouXKQdCKKZ+6CMxBGqiTEOL?=
 =?us-ascii?Q?NWVLC87N5zELm8qa1ie6hhGlGq95qH9m+YERKnDQ4iehZCsb/bf96RvIWvhu?=
 =?us-ascii?Q?5dVMjMwah1lzl5zLEjNEzE/JoMKkf1+FqZFN7AHb9nDH+TDN94p5r2d04n9U?=
 =?us-ascii?Q?n5rXYczkIs9+OxdIaZzJl1esGqSmP5fJfgs66i0xF3bUiyNDam712R5hHxyT?=
 =?us-ascii?Q?8rXshmlD5G4Zim9QWG8+4itdji0NXOb8gpz//k2TajH+2oK0Mts7OyFlD5Z9?=
 =?us-ascii?Q?ThdNF9/qqhX5ak70yope97QbMafKbFnIgIZ/GMdDdyExDsjq6AAXJggZHDVo?=
 =?us-ascii?Q?mmvr3ezBeJ+fia/I3OZ4zhmfaBw1YbCdnv5U5TR/UoHFcb/YNwijLFSSwI6R?=
 =?us-ascii?Q?0qu1BBpvvABbbl0FNAUPBxdzE0pAVCrumWTEZaTCZ3t8P3eKqrGZbiCdw6+L?=
 =?us-ascii?Q?eq82kJEWTJuEY1D/ND+TkhVT0yINgBtCUA94wwLg1twRVja6zKBoyU/IkXKh?=
 =?us-ascii?Q?eYpEQ2rSGAGYXzpu9ZTIeHnVlXDrO4lFFFYF765xwPtYScmaaId/QXWSj1zx?=
 =?us-ascii?Q?jsJbhPRzNA+uPJdtR6uhyLmNIY6PKoKLcsUyFnizFyfRwTX5HxJ3zsjpvijP?=
 =?us-ascii?Q?OJlHY+EYms3N4ZUxZI48DQw6GSgehNeptGk9Rh4kdgRJU3EgSL60uD/ePK9i?=
 =?us-ascii?Q?mnqQLAyu0BONKXSlphb6TkQGA/NFG8kp4Zmy9smZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cf4d45-6b32-43fe-e00f-08dd0a96db92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:00.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psq+0sA9C3dJdP6qg8HdjNnKaxPxwBaJH3Ai8I8Kppyccqs+oIKLVXHsrM2Bsp5qMJOKj2geVSvXrtgIRye3zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

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
Therefore pgmap is the same for both head and tail pages and can be
moved into the folio and we can use the standard scheme to find
compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v2:

 - Indentation fix
 - Rename page_dev_pagemap() to page_pgmap()
 - Rename folio _unused field to _unused_pgmap_compound_head
 - s/WARN_ON/VM_WARN_ON_ONCE_PAGE/

Changes since v1:

 - Move pgmap to the folio as suggested by Matthew Wilcox
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
 drivers/pci/p2pdma.c                   |  6 +++---
 include/linux/memremap.h               |  6 +++---
 include/linux/migrate.h                |  4 ++--
 include/linux/mm_types.h               |  9 +++++++--
 include/linux/mmzone.h                 |  8 +++++++-
 lib/test_hmm.c                         |  3 ++-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  4 +++-
 mm/memremap.c                          | 14 +++++++-------
 mm/migrate_device.c                    |  7 +++++--
 mm/mm_init.c                           |  2 +-
 12 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1a07256..61d0f41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,8 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_pgmap(page), struct nouveau_dmem_chunk,
+			    pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2c5ac4a..e4e9969 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -202,7 +202,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
@@ -1025,8 +1025,8 @@ enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg)
 {
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
+	if (state->pgmap != page_pgmap(sg_page(sg))) {
+		state->pgmap = page_pgmap(sg_page(sg));
 		state->map = pci_p2pdma_map_type(state->pgmap, dev);
 		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 	}
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..0256a42 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_pgmap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_pgmap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_pgmap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 002e49b..291e62e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -207,8 +207,8 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory. The flags also need to
+	 * Set to the owner value also stored in page_pgmap(page)->owner
+	 * for migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
 	 * callbacks to avoid device MMU invalidations for device private
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8..209e00a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -129,8 +129,11 @@ struct page {
 			unsigned long compound_head;	/* Bit zero is set */
 		};
 		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
+			/*
+			 * The first word is used for compound_head or folio
+			 * pgmap
+			 */
+			void *_unused_pgmap_compound_head;
 			void *zone_device_data;
 			/*
 			 * ZONE_DEVICE private pages are counted as being
@@ -299,6 +302,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -337,6 +341,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 17506e4..2c9f864 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1134,6 +1134,12 @@ static inline bool is_zone_device_page(const struct page *page)
 	return page_zonenum(page) == ZONE_DEVICE;
 }
 
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
+	return page_folio(page)->pgmap;
+}
+
 /*
  * Consecutive zone device pages should not be merged into the same sgl
  * or bvec segment with other types of pages or if they belong to different
@@ -1149,7 +1155,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_pgmap(a) == page_pgmap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 056f2e4..ffd0c6f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,8 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_pgmap(page), struct dmirror_chunk,
+			    pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229a..082f7b7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index 3ccee51..24a34a4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4225,6 +4225,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			struct dev_pagemap *pgmap;
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4249,7 +4250,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			pgmap = page_pgmap(vmf->page);
+			ret = pgmap->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 07bbe0e..68099af 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!folio->pgmap->ops ||
+			!folio->pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,12 +486,12 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->page.pgmap->type) {
+	switch (folio->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->page.pgmap);
+		put_dev_pagemap(folio->pgmap);
 		break;
 
 	case MEMORY_DEVICE_FS_DAX:
@@ -514,7 +514,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(zone_device_page_init);
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 {
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9cf2659..2209070 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct dev_pagemap *pgmap;
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
@@ -133,9 +134,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = pfn_swap_entry_to_page(entry);
+			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    pgmap->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -151,12 +153,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
+			pgmap = page_pgmap(page);
 			if (page && !is_zone_device_page(page) &&
 			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     pgmap->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0489820..3d0611e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -996,7 +996,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
 	 * ever freed or placed on a driver-private list.
 	 */
-	page->pgmap = pgmap;
+	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
 	/*
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-38615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E1A04EA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E45161FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9982F136341;
	Wed,  8 Jan 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HboGI1X8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02D27453;
	Wed,  8 Jan 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299139; cv=fail; b=HD6e1fWBRbGJpd5nZRF1Cdp3L43F07D2SAwiULEKVYrpEgFikdJXuTnvOuNc3ZotjkbRMOFARzjRQjKhBWy2N93pbnIgV5i/6WG2thHk+drgvN0geFJ37n5d/fKyuQUWEOSFjphALlIYja6lgOSZIzL2PHzteEJrt125KetLSVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299139; c=relaxed/simple;
	bh=SuMJozJzB6qkBWawYe/IXpTQX8b3jXaQlhSr6YObecI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iM+yCbu0KX4LKu4viIuv4R7jNNdkRNOF22jXuhyyOLbpt9a55VIXcAOw7mgulSBOi8GMal+yFpccMD+UJuutnOs54Hb+GSKxx5rhc+l9xmC1h77Gsf3EMANbbxjrKWH9Do0JlfMf/znSjvx7y2ckOdLcgv2ykT27u1QzaZFKhlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HboGI1X8; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrE/0G+v9skD7XX2TyaKvLyeMYCn7n+gdRyK8aTl2CPs5x0jIVd4yjhTQx5IcUjAkSmMMokKuJPUaXsfWyW8glu7KMVe73OJqXcpGHCj+onNLZVvUe2e/vaglLIlyeWvqFLEQ1RANcqZWjH9/Vqd8Ha15bt98noryNIbL0dLcRCZ2A0Q4qXecBml8IyQkLEimurfqMIUygte3KSXxV9SyIW1APKGoSAR7arqXTvx4z7DScrG2/aF3tHrkihvIzowWLeJZVuheDNFlKTcQYNBV/RXekdKts0b8dh3OZ2JcevNlCs+5ZBHcoSWBHDBx04yHRTlPFGEe5C/2OXzcnw54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbhO788gleqDRlrTYQtcF/4Ic6hEuBd4/oqOqIpCeM0=;
 b=qzEBctG/6eubK3GNBTUzCmd/GcEGCM9AThaJLOIItC0oIW9eR43XhDk0g0MDcrNyGDY2eaXileYJmt+y1Nwj4dWAOgS1Kt8EgyJJ/WAshdU7hHV08Ak2G5bRR7AQNkZgAkqY4Fy8Bvu6KqMGQNzaM05bbSqtiitf/fQv6Puge/R2Mr2fc7s3b82MC3WbzvTBY2AHNw8mStqv6BK0LCDAo4Uyv0GKoTlh0++QlXtF3P+aVYywJ5xYRUqxCARZ3Khizy15/L7VXjL9g9p+XiOxea60dww5+EX9GWtkoUBCDg53eYMPVfvZtsL3jVn0X4lRJ/XOQb8nwBYo/kSuhweGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbhO788gleqDRlrTYQtcF/4Ic6hEuBd4/oqOqIpCeM0=;
 b=HboGI1X8bDF/3SUFs/nZE+2tEUYIW32uL1Ao1kYM/gqxqTjwuzKjoWnwnq2oB2S69G9HBVDP+iCwtR5GU0jRkUMOyCp0A47fYsV1Nr0woMH2JiWB6d9fVzCi8WGH0ohVCz/x876Gt5fvMbZmSrGNeO+qsAcPXdp1q9rzwVmGP5Wr2z45sTj0t41DVzTZHQ7jBPlQ+5F8z+rWqGrSQdAVcCkKA82MCh4vcQ/QZjHZocAuBjPn08AiuZR7kUyOf64jG8cFjegYKh2z7D6e9cOgaoS+NDT9KI8DgnhvuHjskZSCfZb2fUa34N/jDFBBMdki+aDAE+kk4B4KkgHL2Eb7bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Wed, 8 Jan 2025 01:18:54 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:18:54 +0000
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
Subject: [RFC 0/4] mm: Remove pfn_t type
Date: Wed,  8 Jan 2025 12:18:44 +1100
Message-ID: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:10:31::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d176e25-9f68-4208-170b-08dd2f826aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AyeZhXAa++zJgdY1KP1QMRg2a8JRa5Pu/QzpaYkmcij831qLeKijQUiv/UYD?=
 =?us-ascii?Q?Qs8Aq1rh5V6+Ff/XpRJmBfBr/BHZnOaLlrPsRVdUs+vQlUZf7BM1LiQ258Ly?=
 =?us-ascii?Q?/Uf00v6d5YRIq0UCIMujOs6zXwlMjtF9BKetgyFcSOP9c81+d1k1x0RaAmdo?=
 =?us-ascii?Q?13otxA8rST2/63apHRAYm/I3e/++Ynydb27gEmgf8Tw+1y/d1p/wZXXfBxu5?=
 =?us-ascii?Q?DrlS6ZdbYYRn1fLkKSZeUGI4G9P2PiyOkLjdrI7oYDmBou8g9qSLEIF/wWIY?=
 =?us-ascii?Q?zcS5QcbxA43ivNOjqRhuNQKDSrdreuOHtMp5KyXSWmyWoQ80VCqfbAAv1mfa?=
 =?us-ascii?Q?NvaoWvQ1VXutq+ru4+sMQLn1mij6rdYGJRUV2kz+LPph11s5CzU+/Xp3z3ZN?=
 =?us-ascii?Q?7wcZOjcEe0CygjakbHsH1fPcoc/gIixKdhx7PFUGkbHm/dcP+nrzptsOs53a?=
 =?us-ascii?Q?OCLjY0pMglvgGAwHT06ttdh1sMuyMxNL4eAtIKnSp+qASiHGcTEPiGsg9jsz?=
 =?us-ascii?Q?xT6FBzAZcA5561S8XtQ4t1dXktupBXzL+Nzj336RcpPNq96S4iXS1Hpqi4ET?=
 =?us-ascii?Q?cA4wyAxZbtGw5JZtFeasj4d815rRer8hVKK7K7D1r+POykvZ1AQr6kaP9NVb?=
 =?us-ascii?Q?kTsQLJ3hp7KxDfBVwIWyL+A4cx5i1jNbJ/s4okjwGr18+RG5RLuwDaWuZDj4?=
 =?us-ascii?Q?lCvRIsH7N8xmnyySHmcsI5DtAa6NSRMn4XEUJ64cmpel7RA/orlv6MtX85dj?=
 =?us-ascii?Q?A/iv4BsMv8bCDnx2SXCZ/ZXBWBXxRQeFpwPGSQTz3j0AvGJWS+skLELsUHvs?=
 =?us-ascii?Q?E6WIdO/qrfaznM3v611yFU4cqo1KzUkLNvLaWqZdenAdbehxhm3DbnTF0aXV?=
 =?us-ascii?Q?QyUouNrgGMy+2vTTvM1YULqjAYLSDiBck+fiQTiwVPyXZhswUzY4+miCfLWQ?=
 =?us-ascii?Q?ozTQxYQi77/7ZZt0kzupWGDH+xW2E8qDuPxjCrn/NQd9a+NNV166q0ffI5ul?=
 =?us-ascii?Q?IUlh71xFhz+N/P2tH+Tj9hAs4zXc8lsm7QVneaUB3jaKW+DKhvAGBpQ+PaFL?=
 =?us-ascii?Q?SGojGiOzyktK00JZMqo6ClHAW7uMaNv9hJzqm/MlDO7FFjDsPIwfYZyI2SPW?=
 =?us-ascii?Q?MaKZJHVky9LtyItvCnB8+tr3i8Q5NpUuNZR/IibbQbQR8Du6ni1bZdt8V7rx?=
 =?us-ascii?Q?UM0PpTqpBTUxvYC1fln1bfwXqvvtxO2Km1kmZv4mNkykkQvG/vcQjOdE1T+5?=
 =?us-ascii?Q?isv3uJOV7FAmttd2xlUT1YrpV7ad4GhDFzaii4bnSNEKifv6CidQ4vyWrU7I?=
 =?us-ascii?Q?H2xfMQajZSDUl1fIVev+t/1YQ9G0mcvjNHgp+dPDclIvchQAs/Ce67GylR5s?=
 =?us-ascii?Q?agyQkw/7j+GB5LXWj/Ngt6cy7wI2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2x2P3XlCnU9FVguPtmeRC+UIitqTujL2BZYgj2xjrM2hycJGShRze92HG3In?=
 =?us-ascii?Q?F6oOQZRF5KZbCS9wZXuOpGa05zeu4ZHXe/0LnCnJCuZy3a/0KNiSCYhCjkgu?=
 =?us-ascii?Q?V6B9SQq1Vxu3tkFaLD2M/hpJCrMSvMUNOwjbHcPmUI1g2kplykBSpiG0Nfhm?=
 =?us-ascii?Q?Z+us/gTrizRrE3TsfboI8rpByGaRzTPv3U7LeUiO4Ca8biaezs/TgBnLFegF?=
 =?us-ascii?Q?wQUZsc6Ep/EXe9uXeQwbwZcfefoh9GSlRUeZ+vC8zrVr5SSnYpE9OMoJ8Gcl?=
 =?us-ascii?Q?aOCm/W+JST/OVlTi7cf7wm3pihrDh1GAbjMfkWfF4IxITk/Vh9Xp7HTVbeqV?=
 =?us-ascii?Q?dgnF4PGIohDNOsZB5fo/1w+ZyFwKsBcoI0Gg3YWnSDEzyHbOmkCDUh8O9AWY?=
 =?us-ascii?Q?8t0VOXtQaA3BFKo4LQGrJaVde+b/cSZLzRoIieAM6Zbuv1pBoH/X+yqA85Vg?=
 =?us-ascii?Q?t8h4OaCsRsGAJKefcrywfTM/EpAqfrt7z3chCM7gSrErjwRggm6TLGgmsEMb?=
 =?us-ascii?Q?nTjFzM1lgjxDNOA9m/PtwOSpaFFwN97bayG+4TnJ2YcWHGngI1nTMpU2d0QD?=
 =?us-ascii?Q?LmmjAzaQJ5lnFA5wbqvh8PlYYaO1EF22nMUzFq6Rnu3octVnq4P454LabxE8?=
 =?us-ascii?Q?HB5l3JP78tDwU7ciRUTfq5aPVGWYgJZ9zjkpIvCyZnqMKRMizWuBZFvO15V8?=
 =?us-ascii?Q?oiEIfc0P0GgLa0aTTWWUu+zqNcKNj8P+IsK+RxRTXOpzD5BGbjdoZ/rubtTV?=
 =?us-ascii?Q?VF7tsqeUGDSfnUuBW4P8Slo7t979wwCSxDorkC0TCsZH1Y1H7KOi/9A5Ye3m?=
 =?us-ascii?Q?bVC6l9XJ+w32uJPynySHGB66k8AcNelm9W/sX7UXqv8/p47AIJ5FsfRou3v2?=
 =?us-ascii?Q?MweQnIjNltD4vKtxsRqh7TpnN4BtysQnCyZYG7lcoeRFkp3o05+I98/Vqu2+?=
 =?us-ascii?Q?TYnN/Hkum+eQ+iyWURP7OTMFJwP+ou3J+p7P5j2v8VZK/ilYZkYQMn4mTqe2?=
 =?us-ascii?Q?9FJ1r1J7VlTpLL+cLJbhjkqHj6MEwHLFRjWBw/qFYiyTG2p5qUNp1hyZywGB?=
 =?us-ascii?Q?7RFoUTi0m51+ecWnN5okqLjQJgujUl9kb+3t+8h/dHujC09VDRv0Zlwppmyi?=
 =?us-ascii?Q?NvteU2lctULXUDfj2QprBhEfORZKZO3i8tsGDNmM5nD+IAASx9MEUrNKBfEw?=
 =?us-ascii?Q?8MauNg9RO2R+5temRTyA8zqkjf10yNNR6O9DyxCAeM1oS9Fk0Jt2KlNe948P?=
 =?us-ascii?Q?a5427HO2jUv9tEkjFj8nQy6/YnRpPtVZbgRxxV4nsVIiJosrOYbEgUZ0XuJU?=
 =?us-ascii?Q?rVDJmA7I0dhwtzfNBMM2/Cw2qCe2xS+od/YBVpV3vDeshFiZb0gfvYPdi3Xf?=
 =?us-ascii?Q?Wzj4ETktNNKQH3zuXuFTIITh7JI65431nb8NqYbv97Ma9IwZ3jkM/kPNYgSJ?=
 =?us-ascii?Q?dAXIUqIu0W3Ub8a5NpVozh8pRVe6vH0FIsufckLtxkyNon8GL5uR47VrUDls?=
 =?us-ascii?Q?RbJJ7l/nnrlAV9SOyQfj7f8gex497Ij7snO7fEwbvfOriTaVd2p9yd6VxLuh?=
 =?us-ascii?Q?NCGfhBAsyIB5+F5A+5IYIcqZlfBl6Etn8oVVSBSZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d176e25-9f68-4208-170b-08dd2f826aaa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:18:54.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GId+qdj6g8U4U7WutOz+WKD3/x8VZ7I/yfb9AqN5lJKTiCUYa2ZknUH/33afrh3SCIz3E4kP7OMp68eVrfGyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

Once my series[1] and Dan's cleanup[2] is merged all users of DAX will
require a ZONE_DEVICE page which is properly refcounted.  This means there
is no longer any need for the PFN_DEV and PFN_MAP flags. Furthermore the
PFN_SG_CHAIN and PFN_SG_LAST flags never appear to have been used. It is
therefore possible to remove the pfn_t type and replace any usage with raw
pfns.

The remaining users of PFN_DEV have simply passed this to
vmf_insert_mixed(), however once my series is merged vmf_insert_mixed()
doesn't need these flags anyway so those users can be trivially converted
to using raw pfns.

Note that this RFC has only been lightly build tested. Also the third patch
probably needs further splitting up. I have pushed a tree with this, along
with the prerequisite series, to
https://github.com/apopple/linux/tree/pfn_t_cleanup

[1] - https://lore.kernel.org/linux-mm/cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com/
[2] - https://lore.kernel.org/linux-mm/172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com/

---

Cc: gerald.schaefer@linux.ibm.com
Cc: dan.j.williams@intel.com
Cc: jgg@ziepe.ca
Cc: willy@infradead.org
Cc: david@redhat.com
Cc: linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: jhubbard@nvidia.com
Cc: hch@lst.de

Alistair Popple (4):
  mm: Remove PFN_MAP, PFN_SG_CHAIN and PFN_SG_LAST
  mm: Remove uses of PFN_DEV
  mm: Remove callers of pfn_t functionality
  mm: Remove include/linux/pfn_t.h

 arch/x86/mm/pat/memtype.c                |  6 +-
 drivers/dax/device.c                     | 23 ++----
 drivers/dax/hmem/hmem.c                  |  1 +-
 drivers/dax/kmem.c                       |  1 +-
 drivers/dax/pmem.c                       |  1 +-
 drivers/dax/super.c                      |  3 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c  |  1 +-
 drivers/gpu/drm/gma500/fbdev.c           |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |  1 +-
 drivers/gpu/drm/msm/msm_gem.c            |  1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c       |  7 +--
 drivers/gpu/drm/v3d/v3d_bo.c             |  1 +-
 drivers/md/dm-linear.c                   |  2 +-
 drivers/md/dm-log-writes.c               |  2 +-
 drivers/md/dm-stripe.c                   |  2 +-
 drivers/md/dm-target.c                   |  2 +-
 drivers/md/dm-writecache.c               |  9 +--
 drivers/md/dm.c                          |  2 +-
 drivers/nvdimm/pmem.c                    |  8 +--
 drivers/nvdimm/pmem.h                    |  4 +-
 drivers/s390/block/dcssblk.c             | 10 +--
 drivers/vfio/pci/vfio_pci_core.c         |  7 +--
 fs/cramfs/inode.c                        |  4 +-
 fs/dax.c                                 | 45 +++++-------
 fs/ext4/file.c                           |  2 +-
 fs/fuse/dax.c                            |  3 +-
 fs/fuse/virtio_fs.c                      |  5 +-
 fs/xfs/xfs_file.c                        |  2 +-
 include/linux/dax.h                      |  8 +-
 include/linux/device-mapper.h            |  2 +-
 include/linux/huge_mm.h                  |  4 +-
 include/linux/mm.h                       |  4 +-
 include/linux/pfn.h                      | 10 +---
 include/linux/pfn_t.h                    | 96 +-------------------------
 include/linux/pgtable.h                  |  4 +-
 include/trace/events/fs_dax.h            |  6 +--
 mm/debug_vm_pgtable.c                    |  1 +-
 mm/huge_memory.c                         | 23 +++---
 mm/memory.c                              | 32 +++-----
 mm/memremap.c                            |  1 +-
 mm/migrate.c                             |  1 +-
 tools/testing/nvdimm/pmem-dax.c          |  6 +-
 tools/testing/nvdimm/test/iomap.c        | 11 +---
 43 files changed, 108 insertions(+), 259 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

base-commit: 47dc3422e9f51a38e4d5490937f798f080015756
-- 
git-series 0.9.1


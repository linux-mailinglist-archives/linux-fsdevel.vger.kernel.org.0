Return-Path: <linux-fsdevel+bounces-52176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E8AE00D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0566B4A0DAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FE27FD53;
	Thu, 19 Jun 2025 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bq5k+qec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CD27F73A;
	Thu, 19 Jun 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323530; cv=fail; b=W+Lvuo0kFDdpzNbXX9n9WdvXhNDHKfPCAoQrGvRSSnN+/ce/0qmtkm6JzV8u/Ec93DftI6hMTWD+aD6YJYSB/bw+uxHSk+iihyrVBhf0y+xSqDElsA6muu+H65QBjRul7FX2iiJtgEkH3+nRmXymo5nCERnYCDU3XF1iFRr6Bfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323530; c=relaxed/simple;
	bh=O2sVvJFeeG1iLOU1y1mchy78NkIAqYEJIQuYKqgo5Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2tauNEW7H5TN2QCee8/MJDXh9apt8Lfviv2+in3NeP5aX8vTUNODuufIXuxMkkfB2oB/lHAFCuUgFNx20ql55EdMS306GcF4Qu0wTHL8oBiRhg23OmGo4h5ARISsuZ6TY3YypCh9pY9J0YYGU3wy8p/fAbTxEF392q3dgHHcCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bq5k+qec; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhzXzHz6iw41+vd9Fxps7ETatit3E2h0ABTzvuHpMHdRSG1ux6NfM2FLDtFEVxDCeu0WxHdWCaIknn1Kg+wb1Iw2rx+lovPSJvE0JkTVWKNJBrLuLmcPOA6N+zhGZ0oNUsiYnCKYzGnCBRqhFj27dqGf1yfh1IKULiR99cwuowJU7KkV9huu3F5e5bZprRBt3lBg4PDpUm7K4RcRmU6F2VeipzwRBQOAXHnk4BFXBTZ5oZOSHRHs6dAqkgj92ub/3Iq5wP0H1elOxaMrVs6433BsrlTGImBC6FcPy75jxGwh3xTcznY+HD6+/y0Yi8ow6u+sbOSEpypp0Rpu9CuI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnZeq3cuLMjNKLSgReQcyWEK5ZP6Wk//oJbJZEIiw1Y=;
 b=l1twqDKdPQpz0n0MhErOTIWNYiJLUSmhKbHEeQ6VuPc0sHT0u1r4uJflrAV7RUSplmrvVC75ENqQDVcPD8fE1ZCq5q5OB5dAn8+qUhWDKEhSeVRX0k0bbAt4Cvu25MHuIuCKS9eFvUbhgSCR9H8LB4SAgtyPIQ1Zw+6iOXGuptVezOSwsW3jLv7+bzWqQ5imvt7+ZmuIQAXhvavuFIC3Pz3sPllrmOymSQpyYrGJJXhsd7r7amF3TRquXxqcvtaOUBP1KimApFKItZeB1ee7wWok+Zf/MIFbYmABLoTWSfhRxQH0h5f47HVn3orInwvGLIV/NbJfHgjZdII7nyM1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnZeq3cuLMjNKLSgReQcyWEK5ZP6Wk//oJbJZEIiw1Y=;
 b=Bq5k+qeckJ0AcFVDHuqwMpFpjykAYmHcFVwWRc1pU1FEY+qMbfjCTIMhf1Y4xGoy+9p6vv4YW3/HsPzC3lw+0wxnsQ6mVB67KT0fQQRFIN55gA3jhhkJKVw5Pm03eL+wFXCIYKfKtUlX+AutWGi5oAKJhXhsnb4Tz4OmTGRt9gIezKIy1SsoxHp/MJrNybvFQHOBJaauRF0CEI3uqbS5UZ5UyIUPAqIAOuC951s7wPLJx+SdtXVU6mRywHXY3oSsW/PD3F98gEUP3XNJo3ygdFZ4e3O16nh8E/zPSDYypqYfyDXpZK+esy0u3rCoEo8btWy6Y5QUCfLKRJ0OFtLs3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:44 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:44 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
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
	hch@lst.de,
	zhang.lyra@gmail.com,
	debug@rivosinc.com,
	bjorn@kernel.org,
	balbirs@nvidia.com,
	lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	John@Groves.net,
	m.szyprowski@samsung.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 05/14] mm/gup: Remove pXX_devmap usage from get_user_pages()
Date: Thu, 19 Jun 2025 18:57:57 +1000
Message-ID: <708b2be76876659ec5261fe5d059b07268b98b36.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0172.ausprd01.prod.outlook.com
 (2603:10c6:10:52::16) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdd32f5-f960-4794-f534-08ddaf0f7ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtORbEOmbdsOtf7gAvcqIVTKOjjn6EyupIXtEg9j1ncW3hO9Rqfq3p2q6MZr?=
 =?us-ascii?Q?s01P1KmEoxjpBMly7NnGG8NWX8QvX9MbFheFoguoFOy2K+uWOh7+DG01T9K7?=
 =?us-ascii?Q?N7IU4t//Jwk3apf9xWCCJklEjF/Bj5rY4psslEmcz3ZL9Is9w3owJw9QI2RW?=
 =?us-ascii?Q?wShDwXz+4Ha8eXJEAPZtd+2FDmPhs66OBvY0UGWndD7uGARjtFCOJkw5xXu4?=
 =?us-ascii?Q?ARmSBcuoNanz1iUhFyDp3mZzzJ7E5+elWEtEwTC9xSHlpg1r1qDI+hBPa77Q?=
 =?us-ascii?Q?0lRxEG/g66IeSi91PJy56qU7l2/O1q3xyWyn5nGZQhUqmhamWDNKlkE6g+i/?=
 =?us-ascii?Q?s4nnuXpr4dKfwvAFu8E0GeWHytqXfQ63jHx5ByguoVghCCsfcusJxNVphHtz?=
 =?us-ascii?Q?FIBE7ogIiL9rgNNnxFUmbAUTwrBNiiKeZis81HZNvfotGbtnZWtBKaCTX0JZ?=
 =?us-ascii?Q?gL9IGkSSmVmbqYSQDw2Q2hMdHTbZ/vdq4vsPx7SsWa1eUJAyq2KOyjm+RiPa?=
 =?us-ascii?Q?jcILiOu1EQ+iOzOepM43+0g1Sw8vPgHXKiExjXaJn+XXBIqf4saRTycG7evN?=
 =?us-ascii?Q?4udAlq1bHQVfV9tECZ/XPRSMCF2X4sq6/ziEi71ku+AKOK9T8aJaSJvHc4E7?=
 =?us-ascii?Q?ZmBM6Me+4lP1ZvHWgak3AsZIrUlyAwC22M7eU+lIfTkNW7NIlUZCMqicxdGA?=
 =?us-ascii?Q?HFfF5hfYFtq/ZyCsQoUHcSInzc8ljtPhSfWAPxzirFNo2TTpJUewOSgfvKpi?=
 =?us-ascii?Q?RM+eIW58F5fQaOQA23PNJsDvsDVNtIBToK+EMHsvnVpscpEpCTmHYU7VBpdH?=
 =?us-ascii?Q?JtEdOErXz+MfcJkYxWIYBESz4aCgTnjWxZGl3wiiJItx0skWhkP+hVRmmSHC?=
 =?us-ascii?Q?J9T0kO9OisMHP3iUbMO+T/CxRFGHccdwgizBtUx150RA8OuuLhu/ljj9NpHN?=
 =?us-ascii?Q?Es4vNGtSOqen6zePg3KN/knkIiVnoMjrdMdyfao1Nz9engAhnlbolq9B/8me?=
 =?us-ascii?Q?MaKEc5xKYM6g6lULbEVm9mEqXLeItqrHsEVwXyB9T7X/U1NSAlvfpoADNS3M?=
 =?us-ascii?Q?b2a+9d/LSiim27LHqNj7+VIz3QRNm3b3O6fTnHn3QK+jzCveqlukv0GJh3FD?=
 =?us-ascii?Q?vEuCLfLzaTBjybpdhhISd0TdLtDDwOXFKbnkSDZI2rsVXXt8zlkdkM0ZZ+YS?=
 =?us-ascii?Q?wl/9A4uxkKrlcWH1vfKZPJ63XQbLjlqrE0Q9fj7iZyCg0m3/RggOiZiifow6?=
 =?us-ascii?Q?+H+EkRwaOO2o/iTo5d7pnW41QFiltGJ85IUaMzrMn4l/Gr3akhsCQV7Oo3f/?=
 =?us-ascii?Q?M/bOVxqmaFgLJmPKdHiP0TMITa4JvXMTlE8GmGxRMXpePlp9+rj1IibjPvRL?=
 =?us-ascii?Q?2wdLhR3zCZtJknPbCz2miPtUvn5VljpCjbwgWtczzfVYVFk8ADr4e+VCT60C?=
 =?us-ascii?Q?lcpxic3tf3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIzWjCz7r5OUyEqTz/rgYWjPYF6evkhIhK+VLA14o+sx0pH2FPp7vmg3cNgs?=
 =?us-ascii?Q?bbR2E876qJg/Qh2ELgsEyjBRRxO/DkBZAUevn49cRxJjR/8zb3Eh8I62hWi1?=
 =?us-ascii?Q?Tb5wme15ANe8TRRKElNrXY8YjXlxcu0Q6jyQ4+8DtDtdF0EZZ3RUQtzwTufu?=
 =?us-ascii?Q?ukcgzOLSY0MOKACMKF/Ys0zWxIfjDXR1O39hGu6+M1yMLX/zg+5Jk4DfJM/Q?=
 =?us-ascii?Q?YAQ6PlFy551NtqYbIB5ttfX05UmmyZ95g3mZd1Dfw+FhhwktwkGzu9T24Sln?=
 =?us-ascii?Q?DB5OFy9is921YrJZP3/fE7lpcTDT3HxQysfZTLsim8/LCUvHMSQDOw/EoVrD?=
 =?us-ascii?Q?StuHupBcj0bm5h8FfDn+Q8oXcMZGBAbUgtwN9oV5O3Tj9M9L8eWwclM3McUj?=
 =?us-ascii?Q?tHG9fPFOoxhEFgLmrJnVIVomeXzVjJ+FYjlwJ4EaQnQgkaQW97gZHpeT8W9R?=
 =?us-ascii?Q?uwGM1enLQRRZNelRA9GhF2mBM75dfseSDhkn9zuRwXi3FngAlU07860bu9Rf?=
 =?us-ascii?Q?h2y8yFzRykA4dQeF5mXoa9Mor2Xl7fa/aiSqNoD71cz4NmMvE1GyeRzG7FVG?=
 =?us-ascii?Q?zWfnYScyWwqt+aNjkRFxBhScj20g1KfEYVSNm/0gnj7h4dieDm0PHxGJhVei?=
 =?us-ascii?Q?6lR4TVIl5Unogz7JjpHjc0lK7Ah1qKljN0xkJPEqyWU0l7KcnJzYJxitYHPg?=
 =?us-ascii?Q?0ha0pw7znzMAteNnpAWmyOtcyVszrj//R+eqb0L/F7aV/Rjbvb7mnkwgKGFP?=
 =?us-ascii?Q?DbWjd52WoMl54lRgabiCzfmWva6GSylRjaIONa7/KjnM11Fc++QGLrSikSnL?=
 =?us-ascii?Q?qv6hU4duOPfBx66ELy4RbngzRZD6NmigSmklLl8yuUdKwCQWjTMA/H2PGs3d?=
 =?us-ascii?Q?B4k8LWz/7hp1qe2/kK7dWLP2WETGpr50yNA3C6FmKMgP8DzbT6A/NIvbPG6P?=
 =?us-ascii?Q?cHiYOrEPP+T65F3GAH/0SooBjONQINkHwMx3SP4Rs+puYoRjoBfOgnOMdQ9d?=
 =?us-ascii?Q?eYuGPx8+lAPx1K3mOOb/o6RLU9XPqCSuwkmFzADGRjJDWPvMHROUNNV1CkTg?=
 =?us-ascii?Q?IqxlRPME0TyKCHzHP0PPdvxIs381sO4pjDSK8C8Dux34ZixiZcv/q8AiR7lU?=
 =?us-ascii?Q?A3yYq4RrB9ci2WNtI8oooKKrqgH1j67bIlMLMQsMFuvdMAgyDqWHZL9JlYJd?=
 =?us-ascii?Q?Ka23Nc3kU9KQpJ4mXx/NmUpOitAFnZIpnxOXKP+oP632/SxM+vpkNV3DXt8i?=
 =?us-ascii?Q?8dqkRBaPqFw7AfLQZYTaRWS/gMcZc1NKp9kn7ncvyWI8rbYWqdgEnRnBBLkt?=
 =?us-ascii?Q?thagfVr1FizmaBAiTEoV8xdgdpoLmo3Kf86nrcyV5vXV/yMyi06bsaqZp8mD?=
 =?us-ascii?Q?fUo8ULZU5D+0wZVg1bP4CpeGmMTBe3qJLssnZ6COSG/hZp3RMQPYE8FQr51r?=
 =?us-ascii?Q?M8wMDHx5Imj8B1m3M/Mh81d2c7+CHMiXcWI6O/FydTSGz5R4+UR26uOPgudl?=
 =?us-ascii?Q?4hdjPtSxuHiTbURqZeyBYz0PVUVzikr3glTEMSGzkA6bp933ClDsmEusrX4f?=
 =?us-ascii?Q?Uvj/V+2lGeOrDNjowYQqqmwdn6HqWWyUzPwucY6u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdd32f5-f960-4794-f534-08ddaf0f7ec9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:44.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thw5/xSmHeuSe8OfNtN10KCFjF/vqg3yLDSSXgDgd2tZHVydG6kC/1cP3kzlgNI5LPzf/yadqWmaD6OTj339oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

GUP uses pXX_devmap() calls to see if it needs to a get a reference on
the associated pgmap data structure to ensure the pages won't go
away. However it's a driver responsibility to ensure that if pages are
mapped (ie. discoverable by GUP) that they are not offlined or removed
from the memmap so there is no need to hold a reference on the pgmap
data structure to ensure this.

Furthermore mappings with PFN_DEV are no longer created, hence this
effectively dead code anyway so can be removed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/huge_mm.h |   3 +-
 mm/gup.c                | 160 +----------------------------------------
 mm/huge_memory.c        |  40 +----------
 3 files changed, 5 insertions(+), 198 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c9..519c3f0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -473,9 +473,6 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return folio_order(folio) >= HPAGE_PMD_ORDER;
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
-
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
diff --git a/mm/gup.c b/mm/gup.c
index cbe8e4b..6888e87 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -679,31 +679,9 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 		return NULL;
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
-	    pud_devmap(pud)) {
-		/*
-		 * device mapped pages can only be returned if the caller
-		 * will manage the page reference count.
-		 *
-		 * At least one of FOLL_GET | FOLL_PIN must be set, so
-		 * assert that here:
-		 */
-		if (!(flags & (FOLL_GET | FOLL_PIN)))
-			return ERR_PTR(-EEXIST);
-
-		if (flags & FOLL_TOUCH)
-			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
-
-		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
-		if (!ctx->pgmap)
-			return ERR_PTR(-EFAULT);
-	}
-
 	page = pfn_to_page(pfn);
 
-	if (!pud_devmap(pud) && !pud_write(pud) &&
-	    gup_must_unshare(vma, flags, page))
+	if (!pud_write(pud) && gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
 	ret = try_grab_folio(page_folio(page), 1, flags);
@@ -857,8 +835,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	page = vm_normal_page(vma, address, pte);
 
 	/*
-	 * We only care about anon pages in can_follow_write_pte() and don't
-	 * have to worry about pte_devmap() because they are never anon.
+	 * We only care about anon pages in can_follow_write_pte().
 	 */
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pte(pte, page, vma, flags)) {
@@ -866,18 +843,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
-		/*
-		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
-		 * case since they are only valid while holding the pgmap
-		 * reference.
-		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
-			page = pte_page(pte);
-		else
-			goto no_page;
-	} else if (unlikely(!page)) {
+	if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
 			page = ERR_PTR(-EFAULT);
@@ -959,14 +925,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
-	if (pmd_devmap(pmdval)) {
-		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-		return no_page_table(vma, flags, address);
-	}
 	if (likely(!pmd_leaf(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
@@ -2896,7 +2854,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
+	int ret = 0;
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
@@ -2920,16 +2878,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		/* If it's not marked as special it must have a valid memmap. */
@@ -3001,91 +2950,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
-	unsigned long end, unsigned int flags, struct page **pages, int *nr)
-{
-	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
-
-	do {
-		struct folio *folio;
-		struct page *page = pfn_to_page(pfn);
-
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
-		folio = try_grab_folio_fast(page, 1, flags);
-		if (!folio) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-		folio_set_referenced(folio);
-		pages[*nr] = page;
-		(*nr)++;
-		pfn++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	put_dev_pagemap(pgmap);
-	return addr == end;
-}
-
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-#else
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t pud, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif
-
 static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
@@ -3100,13 +2964,6 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_special(orig))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pmd_leaf(orig, pmdp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
@@ -3147,13 +3004,6 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_special(orig))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pud_leaf(orig, pudp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bbc1dab..b096240 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1672,46 +1672,6 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	if (flags & FOLL_WRITE && !pmd_write(*pmd))
-		return NULL;
-
-	if (pmd_present(*pmd) && pmd_devmap(*pmd))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-	ret = try_grab_folio(page_folio(page), 1, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
-- 
git-series 0.9.1


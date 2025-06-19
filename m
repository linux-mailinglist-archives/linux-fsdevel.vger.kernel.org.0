Return-Path: <linux-fsdevel+bounces-52185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C487AE0121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB0619E42D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F928A417;
	Thu, 19 Jun 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QOjrC4O4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C1288C03;
	Thu, 19 Jun 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323574; cv=fail; b=G+R8aJSUV8bGRIJcDrJZI4xCpYMCz8t45rNrhrNJI7T7OD0q7XZ0q+i/rWqw32G8p6Yp1OTRf+P1CNdG9AeJMwzyfdLLJUgnC/2PGYF8urgUastA7bItgQPbPMPzqFM5rpiiDrMfRHPidCWmpTMnpFLrjx/CZQFsrRgW/fTQqdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323574; c=relaxed/simple;
	bh=1L0WOL6ZI4tSbffQO0sLSvE2+hUhCoL7H5WVaCoF7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fIYPhirPdfjPfOjsRxkmTFqDTHuTKEJDA9LQHbf19YeERnbBkTSb6TnjcjS6mhSTY3KKysdNRvJQBIDWL+nToJxFszLjPQogCrAPoGR5r86L9IQSHGUKCNVt/0NG9PBJlTxwRmWom9vXsXRNdf67hGsmeVSIJbPFH9ne9Y2ML6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QOjrC4O4; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUaHPdbDFs/m8eKUKjfMCqUtkNAQ+lFcOkEbf48SG5+pHnjCpoHywj2wqHILlp6/s9yNsok6GUirj+yCBPlftSmoq26+P0x8Vb1YJ1MQucQrPMcZsvXhrecf/mwxDs1ooLSrIEY7GoXOItyr/YpSQEsqcmfC/tqWPlEaKmYiosZ2GHNyqM8S82Bqhuj8rrqWVQYtxFPXS64ufz+DS9PrtK5JWPS15nAKqFChpQEVfqFuoHW02CR1bm3803Om0Nif2qUcb1IkAIg+HDbcICsjBGSmIaSQ/h7UXa++JEnIApbOIrLEq3PSe2vOmwhGgCYU+WUVMUSQGL8fC4fKS/gg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWn2qfq+cw2yVOi6bjD03z7CJZ4VEnx/KB1ny51i0ew=;
 b=vWnbbkbfbsZrMLZ9/qB+Q9nDDVj2j1nYdmRbRVR/x/l6R4Fd0Kq6oT5mDrUpc1eBgTb5LZUQHkrfCt/rxzYYGdqpbt2WWVaDmeXBM/7PnLmoEIGHbGHue28/Y5a8CJKA3v0CcbbbLPzbY122G8TFj6eiYLZryfK93mZ/8U2/2PQE3zFyW5Yj8y2aKh5KkmPMsX/NcXPYrdUQMJJMP1i25Osd+Jz/AWmOrvWUNBxOyyPmpF5MUltwIiyG0+pJYBNpueJO7uLIaofvoogYogZjSVGgFAZLEzDFPpwM5pd2eTlthU7lhcpXaM72+Eg3polGhjNVNiUz6nCsQEFfBHunrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWn2qfq+cw2yVOi6bjD03z7CJZ4VEnx/KB1ny51i0ew=;
 b=QOjrC4O4JDCKKV/VAywtkdIxPItPORP5N93ti7G0Dp8Djh6L8rD/mb6SQTrJIooqhlxgijVSG97u8InUg5TN3Kl+2MoEN0T/IrsBxZfOV1busiXHllocCnW0NGqYejcnZcjP7QCzn8G8rWV93VqGlH+hpozPEVamPlenT52BmrfLlk0pkHUknzz87OvTJ3sxakqoED4j0q/yBtItOExDJtvNx0Cp3wNX17rki1tynSMYh31w85zxCM3G9YPQa6dBdYDG1cvVZA6n8av4gV0JMGQ8pwl+Z96yne5MFI2W3zs8fFZRrHlAa/tei+JOF/By0CEaY9yZ3S5q8Xyx5+6btQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 08:59:21 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:59:21 +0000
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
Subject: [PATCH v3 13/14] mm: Remove callers of pfn_t functionality
Date: Thu, 19 Jun 2025 18:58:05 +1000
Message-ID: <bbedfa576c9822f8032494efbe43544628698b1f.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0007.ausprd01.prod.outlook.com
 (2603:10c6:1:14::19) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: a6785e9b-29de-444a-b016-08ddaf0f949e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zwwu4S7zq1pmokCKWSSXFLzlT8ZJqrY5rRt/YTtbFEkyANRFsbZRpXQKm7CF?=
 =?us-ascii?Q?kazgSLvHLFqGSWaKCw1FUXFFGFkqPU3HTVEwlc75pPyK7OUI/Y0Q51Bj2wO8?=
 =?us-ascii?Q?o6av+PhlNUDqKK7w07Lh3TKMPnQ9fGon6p2FGcucOzEMJEF4PMVTmUR67hsV?=
 =?us-ascii?Q?q/5tmMVTbPMdhf8JWy7QRYE6h0je5HrFtuJWbjRL8BiPdKPPvap7jx0uECYV?=
 =?us-ascii?Q?bCYR6+mE7og29LzJv11VF2FbclRnlW3TDoKMyCqS9hkl4U8xuveFTSpQOx5C?=
 =?us-ascii?Q?EyyRrOCfIlIT8DYY9LeLLOdVvE7hnbyfvWY9iyinjQflAgkrLKwNAkdJi4xN?=
 =?us-ascii?Q?k4xl4CB318V76XtuSZnYvWRVdds7xIOuTf8pi1oRdph8lpfMCsuQoP3RBMqk?=
 =?us-ascii?Q?bFajKBxYlHYHUM81XtT8v4KSQlK+YOxquPMxl8MGladYIokg1HLQqdYeFxog?=
 =?us-ascii?Q?x1HrAUDp17+s/hXNkx0/uNfyHL3SGO0bhgduhZKyVozYOo19N/IQgnIRq7/l?=
 =?us-ascii?Q?d196YptNQbj+ukiMkyL/Vn5rUIxUa7nPu1F+qlVsdwl9ZGfFoaHk/2Ua7gF6?=
 =?us-ascii?Q?ifW3JAJgo06U7Iu5sngkqkjz/YSY8rgn3cLn3+3XerfKA8AFMo2WMHaTYUXb?=
 =?us-ascii?Q?JWHyKGVEPfMuR4jzd5zbwlMt3CBfldCqNw9M1XEJZGxp7g55J7/YLM7pRV58?=
 =?us-ascii?Q?Mvkt/Y1F1S6KZSjDpSwuZJpUmWauJb8ki6mpscipinpEjLnOHtY9SZkHKlek?=
 =?us-ascii?Q?PHW2vXJQPWqNBXQsRiMEvdM1WHrDfjak5WYorOqsrRm69yKXZV+lD45ORjci?=
 =?us-ascii?Q?Bom1w+/+99C8Bb/cIpwkKtkQ4AaSmZgWvLuYTSVVHvCxlQWM6+lEXgOfJW+s?=
 =?us-ascii?Q?lCZ/eXToJ2H4K+RkhRHRC1JfCo8LWL91/pmglMX+BRhS4H2Z8C10X50ZHj5i?=
 =?us-ascii?Q?otOwn1Yg5Erx6Ga4xgYXaphWv2cluUBLDvRfXl7nF9c+sTOpewrAxTsROfai?=
 =?us-ascii?Q?uk9ul942srCXnFXXBH7mnwWaXaOjP6ybN7e9X1Rqx1S8PDZbIYnMbx7pl4g7?=
 =?us-ascii?Q?nNI5dsIFUvyMM1YxqFpGbcJb4MNZz2qubgxS0eoArHWBZ+A54mRO9TT52H0n?=
 =?us-ascii?Q?gDHcU9W8V7kx903R7MGwPpzUgDscp0sub7eLyzmNosM96YwvtE9s4rwf3vmc?=
 =?us-ascii?Q?dkT5IYlZQUAq0Yb9YobMy5WnSVruYgopBnE9len4ZodJTvAdX9+hsNT9f8TQ?=
 =?us-ascii?Q?s/XNG5adcHakmrGd8TkZfcRuWL38x/QZ2ehLnls3z7kMnacKtivQVNGy8SW8?=
 =?us-ascii?Q?FvhnYl8YFPQz026YVIKde+xo6r48V2bzhwBti/v++znjZqnseFWX5mRfFUMw?=
 =?us-ascii?Q?7l8+eluaLWKz/VYRLirlay96lI+IQuiyz3eG6PFIlLKts5DcD+a/J/Dg+TB3?=
 =?us-ascii?Q?y+WhLhtfzos=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KEH2IQBIi282MB5gLen+AC80BXkeVDF7vMh9svFf69J41zBd1Ay8VTdvWWa?=
 =?us-ascii?Q?FdQTx8pVi9UVC9PcW7y/RdwTLNI6SXKBMF5pOt5Ju4nsxBH/IXL0zVdeIcFx?=
 =?us-ascii?Q?W9TzWr7yV/6ZGtAgB2cqI2bcDYUPOCIZB7mt8ZuB5qAMvu7zIjlIJr0igyUC?=
 =?us-ascii?Q?rzWADhZX++BZuHGSXGuSncCmxpi9V4vzCYxdx/LdljvgBTMuI8skNPuCWkYS?=
 =?us-ascii?Q?d4Oq/csGRVTWdEBTZdAhnfQVPyYklnnCeTXbX2rX8wCIJCFN22A73X0IAO+m?=
 =?us-ascii?Q?2nNYkJiynnUIGdeoUagJYwXzklr/lin3/0a7pw2yQT7F79rQgTCailBthFIp?=
 =?us-ascii?Q?PtL5pKVq0nhBySyOXIoB2T8QiBmSXzYASo0MvVJ2v1l2qTf5s/T0rjmkAFmx?=
 =?us-ascii?Q?/L40fa0D7G4Q2EcoK1zPer3g4I1K+eOVkyUsyqOAnScY/HGBl8k76y6l5KjZ?=
 =?us-ascii?Q?TV9WCl9x0d342fVE6aU2g1J/v2JwmP83sqdpqky2i+LZv9DRtFEaqMGaoWbO?=
 =?us-ascii?Q?gxjdqYdkgeCcM0AvDszg13AwYseniJt/RMO35BFmc2sZXTBtNqJGyWC94Dbm?=
 =?us-ascii?Q?u3maDeOlxnVFEFhIeM0P5XAuocPOyOEz13rdCGP6LgwBZ57uyLGyzoUvQZZ0?=
 =?us-ascii?Q?HLmFgfBkaliyDN9qqusVdZrhjBlZz1K7FpmKJX5YE8I1GipnC+ahUQ7PGOL/?=
 =?us-ascii?Q?0L1yu/WehT4Hg+Us729Obop3G4JdM9RKLFLJEAE1x5V+iOpe4vVsFzm7fFzd?=
 =?us-ascii?Q?kFIK3uN7FyoEsBjEe0ZHKuhcf6XrDodr/MQt2nzUsb1orL6OUz6vg41cTQhp?=
 =?us-ascii?Q?OUmwlwwFU94jJJ/m8mxOCraz4vDXZKOk/ZauNGAvgRuKbINP36NXMkn81HUg?=
 =?us-ascii?Q?CY3bNUcLpxKtX+jflcOGA1XTkDWXkb8rc7ldhTk/TBTUvH6KV8x6bVXs08ae?=
 =?us-ascii?Q?vsYcA1UD10+o3AUvqoSjgjZbbiwaE6OEZnZXqwa1s4kyouij6STlzqvkC6NH?=
 =?us-ascii?Q?zjPXsHYndVw/Sd8RZa6BjY448kk0PgiprZ9mDRV1NJcDkoptam2c7PoLQu/9?=
 =?us-ascii?Q?tvVvcxDm5/wJp5WDwkLRgSQoNYjH3oUnYd+8qpG4i11pXGvfnnsN68cKVqFg?=
 =?us-ascii?Q?iTP7GEc99/9aVCHsyCUrfw68z552fe43A4i/ZOmSzI3FP9F+TflJR9NVJeQW?=
 =?us-ascii?Q?r58EzxjBLxVIxJRFv8JjYQAsB5nNsJtMfEqwv89qOaD2wHBjUMaLwI6FqQtw?=
 =?us-ascii?Q?9jCiJ27gsMw+fkQaoeZt7IrXAHX9pSrjUdg72eDuUr8pC51Mem7v7eQNBQ+u?=
 =?us-ascii?Q?tI5+p647zVcLF0HD/HOrBkCSONWdYq2VO/hk9YlTmQGjVnN+eGosw3I3mLSS?=
 =?us-ascii?Q?gUqBdVSM/ImhsUp9LuOBiOWe2dS2/dRKcLKAYNVTp9ymeckzpq5hSCpRB4pq?=
 =?us-ascii?Q?A4LjyVXUxo2JF41Iu/nYk+5ibo/2NPgbIgp+vIr1wQnqtpAtmDHwP4U5MflZ?=
 =?us-ascii?Q?K509dopztIHP/FEDUx2InZooMgTrnfODwYpggS9G11PW0iqOvZMJ0ijZMo6t?=
 =?us-ascii?Q?UD9Q85tolgdMisyVPRKWoG8vI8v8FOVaRY6khueU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6785e9b-29de-444a-b016-08ddaf0f949e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:59:21.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhUPHq2XtYgD3VVLdFtqQoCoQEUHKJ2uhCCK6GCib9W5ElNLy0dKG4h4Qvl60cUueKg0Texg4aMvmuyeyZpRjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

All PFN_* pfn_t flags have been removed. Therefore there is no longer
a need for the pfn_t type and all uses can be replaced with normal
pfns.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>

---

Changes since v1:

 - Rebased on David's cleanup[1]

[1] https://lore.kernel.org/linux-mm/20250611120654.545963-1-david@redhat.com/
---
 arch/x86/mm/pat/memtype.c                |  1 +-
 drivers/dax/device.c                     | 23 +++----
 drivers/dax/hmem/hmem.c                  |  1 +-
 drivers/dax/kmem.c                       |  1 +-
 drivers/dax/pmem.c                       |  1 +-
 drivers/dax/super.c                      |  3 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c  |  1 +-
 drivers/gpu/drm/gma500/fbdev.c           |  3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |  1 +-
 drivers/gpu/drm/msm/msm_gem.c            |  1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c       |  6 +--
 drivers/gpu/drm/v3d/v3d_bo.c             |  1 +-
 drivers/hwtracing/intel_th/msu.c         |  3 +-
 drivers/md/dm-linear.c                   |  2 +-
 drivers/md/dm-log-writes.c               |  2 +-
 drivers/md/dm-stripe.c                   |  2 +-
 drivers/md/dm-target.c                   |  2 +-
 drivers/md/dm-writecache.c               | 11 +--
 drivers/md/dm.c                          |  2 +-
 drivers/nvdimm/pmem.c                    |  8 +--
 drivers/nvdimm/pmem.h                    |  4 +-
 drivers/s390/block/dcssblk.c             |  9 +--
 drivers/vfio/pci/vfio_pci_core.c         |  5 +-
 fs/cramfs/inode.c                        |  5 +-
 fs/dax.c                                 | 50 +++++++--------
 fs/ext4/file.c                           |  2 +-
 fs/fuse/dax.c                            |  3 +-
 fs/fuse/virtio_fs.c                      |  5 +-
 fs/xfs/xfs_file.c                        |  2 +-
 include/linux/dax.h                      |  9 +--
 include/linux/device-mapper.h            |  2 +-
 include/linux/huge_mm.h                  |  6 +-
 include/linux/mm.h                       |  4 +-
 include/linux/pfn.h                      |  9 +---
 include/linux/pfn_t.h                    | 85 +-------------------------
 mm/debug_vm_pgtable.c                    |  1 +-
 mm/huge_memory.c                         | 21 +++---
 mm/memory.c                              | 31 ++++-----
 mm/memremap.c                            |  1 +-
 mm/migrate.c                             |  1 +-
 tools/testing/nvdimm/pmem-dax.c          |  6 +-
 tools/testing/nvdimm/test/iomap.c        |  7 +--
 tools/testing/nvdimm/test/nfit_test.h    |  1 +-
 43 files changed, 109 insertions(+), 235 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 2e79238..c092843 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -36,7 +36,6 @@
 #include <linux/debugfs.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/mm.h>
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 328231c..2bb40a6 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -4,7 +4,6 @@
 #include <linux/pagemap.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
@@ -73,7 +72,7 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 	return -1;
 }
 
-static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
+static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 			      unsigned long fault_size)
 {
 	unsigned long i, nr_pages = fault_size / PAGE_SIZE;
@@ -89,7 +88,7 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
 			ALIGN_DOWN(vmf->address, fault_size));
 
 	for (i = 0; i < nr_pages; i++) {
-		struct folio *folio = pfn_folio(pfn_t_to_pfn(pfn) + i);
+		struct folio *folio = pfn_folio(pfn + i);
 
 		if (folio->mapping)
 			continue;
@@ -104,7 +103,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 {
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -125,11 +124,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+	return vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn),
 					vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -140,7 +139,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PMD_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -169,11 +168,11 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -185,7 +184,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PUD_SIZE;
 
 
@@ -215,11 +214,11 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5e7c53f..c18451a 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -2,7 +2,6 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/dax.h>
 #include "../bus.h"
 
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 584c70a..c036e4d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -5,7 +5,6 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index c8ebf4e..bee9306 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -2,7 +2,6 @@
 /* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
 #include <linux/memremap.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include "../nvdimm/pfn.h"
 #include "../nvdimm/nd.h"
 #include "bus.h"
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e16d1d4..54c480e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -7,7 +7,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/magic.h>
-#include <linux/pfn_t.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
@@ -148,7 +147,7 @@ enum dax_device_flags {
  * pages accessible at the device relative @pgoff.
  */
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn)
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn)
 {
 	long avail;
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 4787fee..84b2172 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -7,7 +7,6 @@
 
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/shmem_fs.h>
 #include <linux/module.h>
 
diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index 109efdc..68b825f 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -6,7 +6,6 @@
  **************************************************************************/
 
 #include <linux/fb.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
@@ -33,7 +32,7 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-		err = vmf_insert_mixed(vma, address, __pfn_to_pfn_t(pfn, 0));
+		err = vmf_insert_mixed(vma, address, pfn);
 		if (unlikely(err & VM_FAULT_ERROR))
 			break;
 		address += PAGE_SIZE;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index f6d37df..75f5b0e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -5,7 +5,6 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/mman.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 
 #include <drm/drm_cache.h>
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 2995e80..20bf31f 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -9,7 +9,6 @@
 #include <linux/spinlock.h>
 #include <linux/shmem_fs.h>
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 
 #include <drm/drm_prime.h>
 #include <drm/drm_file.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 9df05b2..381552b 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -8,7 +8,6 @@
 #include <linux/seq_file.h>
 #include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include <drm/drm_prime.h>
@@ -371,7 +370,7 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, 0));
+	return vmf_insert_mixed(vma, vmf->address, pfn);
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
@@ -466,8 +465,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 			pfn, pfn << PAGE_SHIFT);
 
 	for (i = n; i > 0; i--) {
-		ret = vmf_insert_mixed(vma,
-			vaddr, __pfn_to_pfn_t(pfn, 0));
+		ret = vmf_insert_mixed(vma, vaddr, pfn);
 		if (ret & VM_FAULT_ERROR)
 			break;
 		pfn += priv->usergart[fmt].stride_pfn;
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index bb78155..c41476d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -16,7 +16,6 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/pfn_t.h>
 #include <linux/vmalloc.h>
 
 #include "v3d_drv.h"
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 7163950..f3a13b3 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
-#include <linux/pfn_t.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -1618,7 +1617,7 @@ static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	get_page(page);
-	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn_t(page));
+	return vmf_insert_mixed(vmf->vma, vmf->address, page_to_pfn(page));
 }
 
 static const struct vm_operations_struct msc_mmap_ops = {
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 15538ec..73bf290 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -170,7 +170,7 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index d484e8e..679b07d 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -893,7 +893,7 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index a7dc04b..366f461 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -316,7 +316,7 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index 652627a..2af5a95 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -255,7 +255,7 @@ static void io_err_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	return -EIO;
 }
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index a428e1c..d8de4a3 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -13,7 +13,6 @@
 #include <linux/dm-io.h>
 #include <linux/dm-kcopyd.h>
 #include <linux/dax.h>
-#include <linux/pfn_t.h>
 #include <linux/libnvdimm.h>
 #include <linux/delay.h>
 #include "dm-io-tracker.h"
@@ -256,7 +255,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 	int r;
 	loff_t s;
 	long p, da;
-	pfn_t pfn;
+	unsigned long pfn;
 	int id;
 	struct page **pages;
 	sector_t offset;
@@ -290,7 +289,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		r = da;
 		goto err2;
 	}
-	if (!pfn_t_has_page(pfn)) {
+	if (!pfn_valid(pfn)) {
 		wc->memory_map = NULL;
 		r = -EOPNOTSUPP;
 		goto err2;
@@ -314,13 +313,13 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 				r = daa ? daa : -EINVAL;
 				goto err3;
 			}
-			if (!pfn_t_has_page(pfn)) {
+			if (!pfn_valid(pfn)) {
 				r = -EOPNOTSUPP;
 				goto err3;
 			}
 			while (daa-- && i < p) {
-				pages[i++] = pfn_t_to_page(pfn);
-				pfn.val++;
+				pages[i++] = pfn_to_page(pfn);
+				pfn++;
 				if (!(i & 15))
 					cond_resched();
 			}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1726f0f..4b9415f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1218,7 +1218,7 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index aa50006..05785ff 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -20,7 +20,6 @@
 #include <linux/kstrtox.h>
 #include <linux/vmalloc.h>
 #include <linux/blk-mq.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
@@ -242,7 +241,7 @@ static void pmem_submit_bio(struct bio *bio)
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 	sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
@@ -254,7 +253,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	if (bb->count &&
 	    badblocks_check(bb, sector, num, &first_bad, &num_bad)) {
@@ -303,7 +302,7 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
-		void **kaddr, pfn_t *pfn)
+		void **kaddr, unsigned long *pfn)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
 
@@ -513,7 +512,6 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
diff --git a/drivers/nvdimm/pmem.h b/drivers/nvdimm/pmem.h
index 392b0b3..a48509f 100644
--- a/drivers/nvdimm/pmem.h
+++ b/drivers/nvdimm/pmem.h
@@ -5,7 +5,6 @@
 #include <linux/badblocks.h>
 #include <linux/memremap.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/fs.h>
 
 enum dax_access_mode;
@@ -16,7 +15,6 @@ struct pmem_device {
 	phys_addr_t		phys_addr;
 	/* when non-zero this device is hosting a 'pfn' instance */
 	phys_addr_t		data_offset;
-	u64			pfn_flags;
 	void			*virt_addr;
 	/* immutable base size of the namespace */
 	size_t			size;
@@ -31,7 +29,7 @@ struct pmem_device {
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 
 #ifdef CONFIG_MEMORY_FAILURE
 static inline bool test_and_clear_pmem_poison(struct page *page)
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 249ae40..94fa5ed 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -17,7 +17,6 @@
 #include <linux/blkdev.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
-#include <linux/pfn_t.h>
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/io.h>
@@ -33,7 +32,7 @@ static void dcssblk_release(struct gendisk *disk);
 static void dcssblk_submit_bio(struct bio *bio);
 static long dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
@@ -914,7 +913,7 @@ dcssblk_submit_bio(struct bio *bio)
 
 static long
 __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, void **kaddr, unsigned long *pfn)
 {
 	resource_size_t offset = pgoff * PAGE_SIZE;
 	unsigned long dev_sz;
@@ -923,7 +922,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset), 0);
+		*pfn = PFN_DOWN(dev_info->start + offset);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
@@ -931,7 +930,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f2ad5f..31bdb91 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -20,7 +20,6 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
-#include <linux/pfn_t.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1669,12 +1668,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn, 0), false);
+		ret = vmf_insert_pfn_pmd(vmf, pfn, false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn, 0), false);
+		ret = vmf_insert_pfn_pud(vmf, pfn, false);
 		break;
 #endif
 	default:
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 820a664..b002e9b 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -17,7 +17,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/ramfs.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -412,8 +411,8 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		for (i = 0; i < pages && !ret; i++) {
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
-			pfn_t pfn = phys_to_pfn_t(address + off, 0);
-			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
+			vmf = vmf_insert_mixed(vma, vma->vm_start + off,
+					address + off);
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
 		}
diff --git a/fs/dax.c b/fs/dax.c
index f4ffb69..4229513 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -20,7 +20,6 @@
 #include <linux/sched/signal.h>
 #include <linux/uio.h>
 #include <linux/vmstat.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
@@ -76,9 +75,9 @@ static struct folio *dax_to_folio(void *entry)
 	return page_folio(pfn_to_page(dax_to_pfn(entry)));
 }
 
-static void *dax_make_entry(pfn_t pfn, unsigned long flags)
+static void *dax_make_entry(unsigned long pfn, unsigned long flags)
 {
-	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
+	return xa_mk_value(flags | (pfn << DAX_SHIFT));
 }
 
 static bool dax_is_locked(void *entry)
@@ -713,7 +712,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 		if (order > 0)
 			flags |= DAX_PMD;
-		entry = dax_make_entry(pfn_to_pfn_t(0), flags);
+		entry = dax_make_entry(0, flags);
 		dax_lock_entry(xas, entry);
 		if (xas_error(xas))
 			goto out_unlock;
@@ -1041,7 +1040,7 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
  * appropriate.
  */
 static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap_iter *iter, void *entry, pfn_t pfn,
+		const struct iomap_iter *iter, void *entry, unsigned long pfn,
 		unsigned long flags)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1239,7 +1238,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
-		size_t size, void **kaddr, pfn_t *pfnp)
+		size_t size, void **kaddr, unsigned long *pfnp)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	int id, rc = 0;
@@ -1257,7 +1256,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
-	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
+	if (*pfnp & (PHYS_PFN(size)-1))
 		goto out;
 
 	rc = 0;
@@ -1361,12 +1360,12 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 {
 	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
-	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
+	unsigned long pfn = my_zero_pfn(vaddr);
 	vm_fault_t ret;
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1383,14 +1382,14 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	struct folio *zero_folio;
 	spinlock_t *ptl;
 	pmd_t pmd_entry;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
 
 	if (unlikely(!zero_folio))
 		goto fallback;
 
-	pfn = page_to_pfn_t(&zero_folio->page);
+	pfn = page_to_pfn(&zero_folio->page);
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
 				  DAX_PMD | DAX_ZERO_PAGE);
 
@@ -1779,7 +1778,8 @@ static vm_fault_t dax_fault_return(int error)
  * insertion for now and return the pfn so that caller can insert it after the
  * fsync is done.
  */
-static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
+static vm_fault_t dax_fault_synchronous_pfnp(unsigned long *pfnp,
+					unsigned long pfn)
 {
 	if (WARN_ON_ONCE(!pfnp))
 		return VM_FAULT_SIGBUS;
@@ -1827,7 +1827,7 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
  * @pmd:	distinguish whether it is a pmd fault
  */
 static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
-		const struct iomap_iter *iter, pfn_t *pfnp,
+		const struct iomap_iter *iter, unsigned long *pfnp,
 		struct xa_state *xas, void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -1838,7 +1838,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	struct folio *folio;
 	int ret, err = 0;
-	pfn_t pfn;
+	unsigned long pfn;
 	void *kaddr;
 
 	if (!pmd && vmf->cow_page)
@@ -1875,16 +1875,15 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
 	folio_ref_inc(folio);
 	if (pmd)
-		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)),
-					write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn), write);
 	else
-		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
+		ret = vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn), write);
 	folio_put(folio);
 
 	return ret;
 }
 
-static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       int *iomap_errp, const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1996,7 +1995,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 	return false;
 }
 
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -2077,7 +2076,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	return ret;
 }
 #else
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	return VM_FAULT_FALLBACK;
@@ -2098,7 +2097,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * successfully.
  */
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
+			unsigned long *pfnp, int *iomap_errp,
+			const struct iomap_ops *ops)
 {
 	if (order == 0)
 		return dax_iomap_pte_fault(vmf, pfnp, iomap_errp, ops);
@@ -2118,8 +2118,8 @@ EXPORT_SYMBOL_GPL(dax_iomap_fault);
  * This function inserts a writeable PTE or PMD entry into the page tables
  * for an mmaped DAX file.  It also marks the page cache entry as dirty.
  */
-static vm_fault_t
-dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
+static vm_fault_t dax_insert_pfn_mkwrite(struct vm_fault *vmf,
+					unsigned long pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
@@ -2141,7 +2141,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
-	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio = pfn_folio(pfn);
 	folio_ref_inc(folio);
 	if (order == 0)
 		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
@@ -2168,7 +2168,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
  * table entry.
  */
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	int err;
 	loff_t start = ((loff_t)vmf->pgoff) << PAGE_SHIFT;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 21df813..e6e9629 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -747,7 +747,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 0502bf3..ac6d4c1 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -10,7 +10,6 @@
 #include <linux/dax.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/iomap.h>
 #include <linux/interval_tree.h>
 
@@ -757,7 +756,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,
 	vm_fault_t ret;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
-	pfn_t pfn;
+	unsigned long pfn;
 	int error = 0;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_conn_dax *fcd = fc->dax;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 53c2626..aac914b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -9,7 +9,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/group_cpus.h>
-#include <linux/pfn_t.h>
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
@@ -1008,7 +1007,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 				    long nr_pages, enum dax_access_mode mode,
-				    void **kaddr, pfn_t *pfn)
+				    void **kaddr, unsigned long *pfn)
 {
 	struct virtio_fs *fs = dax_get_private(dax_dev);
 	phys_addr_t offset = PFN_PHYS(pgoff);
@@ -1017,7 +1016,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
+		*pfn = fs->window_phys_addr + offset;
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 48254a7..0b2db25 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1729,7 +1729,7 @@ xfs_dax_fault_locked(
 	bool			write_fault)
 {
 	vm_fault_t		ret;
-	pfn_t			pfn;
+	unsigned long		pfn;
 
 	if (!IS_ENABLED(CONFIG_FS_DAX)) {
 		ASSERT(0);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index dcc9fcd..29eec75 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -26,7 +26,7 @@ struct dax_operations {
 	 * number of pages available for DAX at that pfn.
 	 */
 	long (*direct_access)(struct dax_device *, pgoff_t, long,
-			enum dax_access_mode, void **, pfn_t *);
+			enum dax_access_mode, void **, unsigned long *);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 	/*
@@ -241,7 +241,7 @@ static inline void dax_break_layout_final(struct inode *inode)
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn);
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
@@ -255,9 +255,10 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
+			unsigned long *pfnp, int *errp,
+			const struct iomap_ops *ops);
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
-		unsigned int order, pfn_t pfn);
+		unsigned int order, unsigned long pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 void dax_delete_mapping_range(struct address_space *mapping,
 				loff_t start, loff_t end);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index cb95951..84fdc3a 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -156,7 +156,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode node, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 21b3f0b..35e34e6 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -37,8 +37,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
 
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
+			      bool write);
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
+			      bool write);
 vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 				bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c2f760..98a6069 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3527,9 +3527,9 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn);
+			unsigned long pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn);
+		unsigned long addr, unsigned long pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
diff --git a/include/linux/pfn.h b/include/linux/pfn.h
index 14bc053..b90ca0b 100644
--- a/include/linux/pfn.h
+++ b/include/linux/pfn.h
@@ -4,15 +4,6 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-
-/*
- * pfn_t: encapsulates a page-frame number that is optionally backed
- * by memmap (struct page).  Whether a pfn_t has a 'struct page'
- * backing is indicated by flags in the high bits of the value.
- */
-typedef struct {
-	u64 val;
-} pfn_t;
 #endif
 
 #define PFN_ALIGN(x)	(((unsigned long)(x) + (PAGE_SIZE - 1)) & PAGE_MASK)
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
deleted file mode 100644
index 2c00293..0000000
--- a/include/linux/pfn_t.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_PFN_T_H_
-#define _LINUX_PFN_T_H_
-#include <linux/mm.h>
-
-/*
- * PFN_FLAGS_MASK - mask of all the possible valid pfn_t flags
- */
-#define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
-
-#define PFN_FLAGS_TRACE \
-	{ }
-
-static inline pfn_t __pfn_to_pfn_t(unsigned long pfn, u64 flags)
-{
-	pfn_t pfn_t = { .val = pfn | (flags & PFN_FLAGS_MASK), };
-
-	return pfn_t;
-}
-
-/* a default pfn to pfn_t conversion assumes that @pfn is pfn_valid() */
-static inline pfn_t pfn_to_pfn_t(unsigned long pfn)
-{
-	return __pfn_to_pfn_t(pfn, 0);
-}
-
-static inline pfn_t phys_to_pfn_t(phys_addr_t addr, u64 flags)
-{
-	return __pfn_to_pfn_t(addr >> PAGE_SHIFT, flags);
-}
-
-static inline bool pfn_t_has_page(pfn_t pfn)
-{
-	return true;
-}
-
-static inline unsigned long pfn_t_to_pfn(pfn_t pfn)
-{
-	return pfn.val & ~PFN_FLAGS_MASK;
-}
-
-static inline struct page *pfn_t_to_page(pfn_t pfn)
-{
-	if (pfn_t_has_page(pfn))
-		return pfn_to_page(pfn_t_to_pfn(pfn));
-	return NULL;
-}
-
-static inline phys_addr_t pfn_t_to_phys(pfn_t pfn)
-{
-	return PFN_PHYS(pfn_t_to_pfn(pfn));
-}
-
-static inline pfn_t page_to_pfn_t(struct page *page)
-{
-	return pfn_to_pfn_t(page_to_pfn(page));
-}
-
-static inline int pfn_t_valid(pfn_t pfn)
-{
-	return pfn_valid(pfn_t_to_pfn(pfn));
-}
-
-#ifdef CONFIG_MMU
-static inline pte_t pfn_t_pte(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pte(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline pmd_t pfn_t_pmd(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pmd(pfn_t_to_pfn(pfn), pgprot);
-}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-static inline pud_t pfn_t_pud(pfn_t pfn, pgprot_t pgprot)
-{
-	return pfn_pud(pfn_t_to_pfn(pfn), pgprot);
-}
-#endif
-#endif
-
-#endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index d84d0c4..bd8f931 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -20,7 +20,6 @@
 #include <linux/mman.h>
 #include <linux/mm_types.h>
 #include <linux/module.h>
-#include <linux/pfn_t.h>
 #include <linux/printk.h>
 #include <linux/pgtable.h>
 #include <linux/random.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 642fd83..d9a76e7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -22,7 +22,6 @@
 #include <linux/mm_types.h>
 #include <linux/khugepaged.h>
 #include <linux/freezer.h>
-#include <linux/pfn_t.h>
 #include <linux/mman.h>
 #include <linux/memremap.h>
 #include <linux/pagemap.h>
@@ -1375,7 +1374,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 struct folio_or_pfn {
 	union {
 		struct folio *folio;
-		pfn_t pfn;
+		unsigned long pfn;
 	};
 	bool is_folio;
 };
@@ -1391,7 +1390,7 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pmd_none(*pmd)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
-					  pfn_t_to_pfn(fop.pfn);
+					  fop.pfn;
 
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
@@ -1414,7 +1413,7 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
 	} else {
-		entry = pmd_mkhuge(pfn_t_pmd(fop.pfn, prot));
+		entry = pmd_mkhuge(pfn_pmd(fop.pfn, prot));
 		entry = pmd_mkspecial(entry);
 	}
 	if (write) {
@@ -1442,7 +1441,8 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1473,7 +1473,7 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 			return VM_FAULT_OOM;
 	}
 
-	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
 	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	error = insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write,
@@ -1539,7 +1539,7 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pud_none(*pud)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
-					  pfn_t_to_pfn(fop.pfn);
+					  fop.pfn;
 
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
@@ -1559,7 +1559,7 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		folio_add_file_rmap_pud(fop.folio, &fop.folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PUD_NR);
 	} else {
-		entry = pud_mkhuge(pfn_t_pud(fop.pfn, prot));
+		entry = pud_mkhuge(pfn_pud(fop.pfn, prot));
 		entry = pud_mkspecial(entry);
 	}
 	if (write) {
@@ -1580,7 +1580,8 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1603,7 +1604,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
 	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
diff --git a/mm/memory.c b/mm/memory.c
index f1d81ad..0163d12 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -57,7 +57,6 @@
 #include <linux/export.h>
 #include <linux/delayacct.h>
 #include <linux/init.h>
-#include <linux/pfn_t.h>
 #include <linux/writeback.h>
 #include <linux/memcontrol.h>
 #include <linux/mmu_notifier.h>
@@ -2435,7 +2434,7 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 EXPORT_SYMBOL(vm_map_pages_zero);
 
 static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn, pgprot_t prot, bool mkwrite)
+			unsigned long pfn, pgprot_t prot, bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
@@ -2457,7 +2456,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			 * allocation and mapping invalidation so just skip the
 			 * update.
 			 */
-			if (pte_pfn(entry) != pfn_t_to_pfn(pfn)) {
+			if (pte_pfn(entry) != pfn) {
 				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
 				goto out_unlock;
 			}
@@ -2470,7 +2469,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2541,8 +2540,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
-			false);
+	return insert_pfn(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2573,21 +2571,22 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
-static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
+static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
+			bool mkwrite)
 {
-	if (unlikely(is_zero_pfn(pfn_t_to_pfn(pfn))) &&
+	if (unlikely(is_zero_pfn(pfn)) &&
 	    (mkwrite || !vm_mixed_zeropage_allowed(vma)))
 		return false;
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
+	if (is_zero_pfn(pfn))
 		return true;
 	return false;
 }
 
 static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn, bool mkwrite)
+		unsigned long addr, unsigned long pfn, bool mkwrite)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
 	int err;
@@ -2598,9 +2597,9 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
+	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
 	/*
@@ -2610,7 +2609,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_valid(pfn)) {
 		struct page *page;
 
 		/*
@@ -2618,7 +2617,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * regardless of whether the caller specified flags that
 		 * result in pfn_t_has_page() == false.
 		 */
-		page = pfn_to_page(pfn_t_to_pfn(pfn));
+		page = pfn_to_page(pfn);
 		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
@@ -2653,7 +2652,7 @@ vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, false);
 }
@@ -2665,7 +2664,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
  *  the same entry was actually inserted.
  */
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn)
+		unsigned long addr, unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
diff --git a/mm/memremap.c b/mm/memremap.c
index c17e0a6..044a455 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -5,7 +5,6 @@
 #include <linux/kasan.h>
 #include <linux/memory_hotplug.h>
 #include <linux/memremap.h>
-#include <linux/pfn_t.h>
 #include <linux/swap.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
diff --git a/mm/migrate.c b/mm/migrate.c
index 8cf0f9c..ea8c74d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -35,7 +35,6 @@
 #include <linux/compat.h>
 #include <linux/hugetlb.h>
 #include <linux/gfp.h>
-#include <linux/pfn_t.h>
 #include <linux/page_idle.h>
 #include <linux/page_owner.h>
 #include <linux/sched/mm.h>
diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index c1ec099..05e763a 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -10,7 +10,7 @@
 
 long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
 
@@ -29,7 +29,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 			*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
 		if (pfn)
-			*pfn = page_to_pfn_t(page);
+			*pfn = page_to_pfn(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
 
@@ -39,7 +39,7 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = pmem->virt_addr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+		*pfn = PHYS_PFN(pmem->phys_addr + offset);
 
 	/*
 	 * If badblocks are present, limit known good range to the
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index ddceb04..f7e7bfe 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -8,7 +8,6 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/pfn_t.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -135,12 +134,6 @@ void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
 
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
-{
-        return phys_to_pfn_t(addr, flags);
-}
-EXPORT_SYMBOL(__wrap_phys_to_pfn_t);
-
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags)
 {
diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index b00583d..b9047fb 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -212,7 +212,6 @@ void __iomem *__wrap_devm_ioremap(struct device *dev,
 void *__wrap_devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
-pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags);
 void *__wrap_memremap(resource_size_t offset, size_t size,
 		unsigned long flags);
 void __wrap_devm_memunmap(struct device *dev, void *addr);
-- 
git-series 0.9.1


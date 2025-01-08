Return-Path: <linux-fsdevel+bounces-38618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C54A04EBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601AD163728
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54078189F3F;
	Wed,  8 Jan 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dsdTE+UC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1516DC3C;
	Wed,  8 Jan 2025 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736299155; cv=fail; b=liYBkwUoCv9odt/8hkZE+45fko5zMGgwG827SFZEnm7Xk9FrXPvbAdGNGf8YyjFanXF6vMTdTyLX71Rp0V89f4Bq8ecp39xkq8p+Aj/BEI86JuKFffTSDCu38fSJ8JlQqpcLCfiyDYE9ZLiXzQU6y5e5vkBI1dhB8LNZk7ZHX3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736299155; c=relaxed/simple;
	bh=imEXYo6PWRqWt0YG56xUfgOPkM1B/wjcCocENvTCP78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s++dfQf7BobK38tivhW3UIx2Gu+THK5IbUaBQ79+5PwihpuDfLrIbXfZaizGboxupKHz60k7Kkw1mYstUsNrfHOocY5RWDPw/BCZsXCCthD0luOPMzeCwR/vfYvb9/EZ3E+uynPnAfjrzHtqf4atF6f1bALKj1Aw1K1dA2aKu/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dsdTE+UC; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5gbEK9MYXULwWb00s6PsQFGKEuMcawpjFevKpVe6lHK7VH927OE+naTYUQD97hcB2PEi7CjIKYl0yJdcC4SFp04c1G8SFEWPN+dZ2Zr8xh6NBiNfrlTeSs6tEGH2ldbL8yaD1WFMunXuNPZwGLSFkXAAGhd1UywqkhWKfE64gzlDGJET3tsqOLeYPlWFEW1xtRK/3g4JPdbf7ywFt8dWLSUoSZDD/oQQx7CJmOUP52QM/9V6Zcy5W47Sst4UT8jTNfv7wYygjurFiA22Pnq4/fHFfTDdgOBGucGdib/yiY1EW4M2tawCI6zVbmTzPGbxWcdGR13vLaDev7cd1UQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+01YGYbvYAUwfwnW+mka5lXzZERWKQeBE7YO9Hkv9Xo=;
 b=BHG/srZSRQYFNrk6yh2Yzx7yzj6JnTnj0WvAwKsMdMkO8YU60JRvxBjzftOsICLZxLxEcbTA3cHJAfQitJM6s1RmsaOXLNDBeL74vXyINm1RWYfvEMuttPiP4tdoLRDysGz3lQUebUIi000zdp5K29siEypuuzNKTJt/seWXOGeevC6VT9+S9no8aIVdy0nTXKBUSPmiIIVnT16V0HU/omBe8+UR7Y+jkocPE/U0eWcTrn1+HP8lq9DpY8T21ZtBr6Kvcb8T7qrIRfkZYwmQUlCnACBTGT/sRZASokTAh7IOA6rgySQrJ6cWyUbXJYfq5EHOkSEHsEA9O+CPNG76Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+01YGYbvYAUwfwnW+mka5lXzZERWKQeBE7YO9Hkv9Xo=;
 b=dsdTE+UCvgBClkKWDoTov7OgFjbv2zKsbrBkn4Lu8tUO7/pp7knuXkK5KT9gbfi3KFCN+XgxDDklU1pezOxP+L4HXYKO2kpkVUEoNiceJfcfC7w91ouBqrwRKaKhwo7XSv4twJmUHp6eB++/+TwjEplub/FQ38EXv5+WyXGH157LgsVnTmlbdmHOu7OYCAU9+RxeKJ92s0KxiZlA+rzCsQ4qSVpvXz66mq6qCuvq/MDp9zfURs5uNUeF7v3r0FSpxWmcxcWT0IQe8OX2DPy5qwzNcvCMU6RClYY+9mkVlfM+eQ/lcGn3h9jnuPPOoDyds81XvYUlmF23pqJfiBwu0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Wed, 8 Jan 2025 01:19:08 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:19:08 +0000
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
Subject: [RFC 3/4] mm: Remove callers of pfn_t functionality
Date: Wed,  8 Jan 2025 12:18:47 +1100
Message-ID: <b5b3b567ce2d1df7186ad79bcda7cec6e82f2a1f.1736299058.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
References: <cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0054.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: f816cf25-bc39-4e5e-ad65-08dd2f827303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lyaNY0gDcgLitbeTg8D2pBOaLj1xng53Qtssswr7WO+WMc4AfKxmfXdtpHJ?=
 =?us-ascii?Q?yh9rj9DXky8n6mRks6uL+nnByZiW05RBvQVQJe3zMOe8XIdXpONzfPdUXL4V?=
 =?us-ascii?Q?u/IvUPsIedqxPg2Po4JwNPVMuPxnwUr+1eI/3QqYCzqC8nZHdFqga5sdTtyJ?=
 =?us-ascii?Q?/Xy702XYmpg9yqceYvaPBNWvHU3YGPy1aEqpp51MsiV02XdhTMgkWcz5vJM8?=
 =?us-ascii?Q?Wd4Y93zZ4S/vQnAKjML4fhhF9L/WtUAtG01mv4PyrRYh8ZP8EpCivcfPy37q?=
 =?us-ascii?Q?l24qVwsYrBif1rwgQtxZu6sCoEqQxk6aFsU2eqLXuRNot3Z2x6HfDvDz/Hnr?=
 =?us-ascii?Q?5Lfb4ECj3fJG+qnNmw5A0dmfTX7KfCf/HfF2mvAnQ1XLMoIUkK6HuXna7dfS?=
 =?us-ascii?Q?rLscvmfdaJw9pdAUlpZIBqL6v5ahwy+a8Go8iKWqx+1KYYMFHgMieRE+Zawg?=
 =?us-ascii?Q?e07oAbcJhHdCVQphYAvbX8ODasOnZK8JPTFqMY/C4qtyoPalnXraS3nuTHkO?=
 =?us-ascii?Q?wmYg1+FUHRP6d6oh/xEK/TVW5T55dsXWUxqrywngv6/RO8FIzYYOdlfM62ox?=
 =?us-ascii?Q?X0c8kSz+fd3Lz6io+O9j3OzWwajGgLjh5Hzs4lEg8YI4WDPwio1dZLeU5xUl?=
 =?us-ascii?Q?dRcNzvOMSdOzH3dRnm0i74fAvofZWWBp3UU+Fwn2ZgK3x2wpmd+u3VS4KUY+?=
 =?us-ascii?Q?Edzbye1SZ6fgMAsWqh6Az7g+NPbqsf3C33NEFP0NgN0EqiTiojWbzfVfwPvZ?=
 =?us-ascii?Q?U8Hf46qtjsTF44mNLjbRzq9Rf1yXsvufX+FkQ3XEBG3+XYBX8keu5wklO3eo?=
 =?us-ascii?Q?3pSDol5M/c7hgOCbhzbAoS1UHnjLeNCybGPtroU3/BnTqvAiT/jzbW3NmL+X?=
 =?us-ascii?Q?jzz9My5qjqJ6lCmgzuqU4wgZCeIriowxtw1VzPX4xfT2ZW5WfOyxfJBkuLH1?=
 =?us-ascii?Q?wtlqW1kuHCOt7mWViLw8Nl6asuMp5hpUcIPikjvNtJu5sWuVW+Cf+CdH9mKu?=
 =?us-ascii?Q?/bUQi0XHJuCZAj5p6uUaYksY8RxsKboa7dX5C/OLuur69FiapSCTJZrYhoyn?=
 =?us-ascii?Q?PsqLupQ0VXaJPaoipNgQ5RUanc6rHswMj1I3Bq0+ieNW6D+4F/1sdPMvtY9f?=
 =?us-ascii?Q?xUZ8Q763aiRDOSef7dvc9wHsKI0EqK8WbOvpmQgESWTPMLG2NjFQMlS0rYdC?=
 =?us-ascii?Q?TmeRSVbD3zx9w/tyHaDr+6wqEr7JeAijvEzEAsWL+/sVHjejNJX7NCrc71Ho?=
 =?us-ascii?Q?So2heTTwKpRD62nfo47bqazIEIl30eehogrvt83nSnJYw0A4cGPlYe6b1a2L?=
 =?us-ascii?Q?zmkYo8v3xm/k/cysSRcqnhC5U28eNjYtv1YfJvoR08xDxDgsAhATcBUTmL7R?=
 =?us-ascii?Q?C2wswmnjtlZVUjwtz1vgcRF5zw6N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LU1riJOOrqfUdktp1u5lXDp5JFJq7UId/18BAhmWWHU9YxNRA6fVZwPabMv?=
 =?us-ascii?Q?xxcPw+fDlUbtfF2qGzTDii+hXjtXUiKF5bq8BBTR2Ic6e0dt8XzuMDVQvgfx?=
 =?us-ascii?Q?LeQA+LTxvh/O2ji0KyHQKK0qy3sy5t60NzskDUYGbVgg4W8hkHBtfP/oRfUG?=
 =?us-ascii?Q?o+rCHqzEWmwL10GYmauN027G+oUBvKdUKuFgXnvz3U19otxYNNcyjSUX9Hzz?=
 =?us-ascii?Q?xaqdSL+OMoo9qBX/AdbhTRRO0xmSxltmIlBPKYcm8x+PZ4R55jXMmrf9CY/k?=
 =?us-ascii?Q?AeS7aA36znm1n3WoknlcjEGWTDiRU22h7nHiuo4KbzhZwxSTsR0A0CGTNUx7?=
 =?us-ascii?Q?fVQYRO31bn+qRChQEeYlSD5fM0UG0JNhfwX1uS6w9cqlbhxtkVvno798wNex?=
 =?us-ascii?Q?OyaWsC4bAQOTkXmFBnXIe6Rl4KvI1mu2asrb4Z/EnT84a3AGDBUYq4BOmGJn?=
 =?us-ascii?Q?wjZmmL7flOBGfavfGddnWFhQ/A2mYGHv8zkCg9cqxXx5LRJHt3Q22LwSCi6s?=
 =?us-ascii?Q?18dyrsq8y58pvREg8XuqOrlQyMVMH0xf9nb0oxg4rq6sHJHoHdqg0rwKKz0X?=
 =?us-ascii?Q?zlkJ429J2zAb1X5bitLT2waBEDUw7E+SSXVFiL9mLbzHOfSUIKPCn09B/bPu?=
 =?us-ascii?Q?QveJneZfiVF1RluUPLyJsn/c1i5Jq7XO73DQsm2Zv4T3Cqp13oyPlZUEEZuX?=
 =?us-ascii?Q?qheCagIkA1sYMODpnsPpwA8xZYCS1pk/+Xb6KMxCONEvSerRYlz4bkF/V5ke?=
 =?us-ascii?Q?VIIKwho0lt0/+VycTxLqfu9dkjrIQEWWEQGmCuhd4JOMgaEknWLa4QsYVeUG?=
 =?us-ascii?Q?9ZPBNASS9JIQeJrD8DOGA9DIsSR7RLZZZHxTijhHG7SIS1RRKUJNdue4iPl1?=
 =?us-ascii?Q?ii4Pl+95gHCs9gPaALYxIwcTtXbmqulXfgtdgp//UTA7Lu+h1xNmPqui3H4b?=
 =?us-ascii?Q?pXCY7bsosc4EsfrtYjTxzl8FU3n5+r2cL6uREBOmoFZm3InLe0slLszuxYXR?=
 =?us-ascii?Q?TX/eqR/DOvt27fnZx2Vwjwn3lGnGj0gdrT0Avannfuf0NDZCu4yN2lYM7Eig?=
 =?us-ascii?Q?0Zx6bKk5BvU22OlJwzkISBzMl4dqUBUS+v+NawsPmqX6HAGNEX4yf2Np5nBy?=
 =?us-ascii?Q?r8bY0UGfAC/dL5y7uBpRqFavERGYs11gwlnLXQexNKO6CxWrW9Shkb+C4SkW?=
 =?us-ascii?Q?tj58BZZVNLMn4j5+IYVMoeTYfG5wYPtXGBZcgDfFFQhKUexUDt3Xath3BhfJ?=
 =?us-ascii?Q?0BZybzuqfWFfMxOoEGWfyrvOIjHLGBbGIw9ZWBoI/bBvqc5qIpLgqvHUDgkV?=
 =?us-ascii?Q?MH7Y3aMUSJz5ZABEA1UTO62SNBz15HjQERQTJU0h91G4VG2SoFNik25k1dbO?=
 =?us-ascii?Q?9E9qHAG4K9JTPYrTSf+Eo0NfiRjRuEt5jQSlGmBx59NG8Y3nDvSHJv+Cpsib?=
 =?us-ascii?Q?Fgj/GjXUo03wDglkQocR2PkOISxZ7d0B75UwTS5gZrFTIWd4OrdG5x05AUgn?=
 =?us-ascii?Q?tEj2Lm07gAJMeIILpuPmb2UabqGKSL5n94/9ed5hjYSzOxbNh29ghTOvXZbO?=
 =?us-ascii?Q?qr5egIRxMnCzjSVLQjdhiUEm6vLQWnl3AJppYB9y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f816cf25-bc39-4e5e-ad65-08dd2f827303
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 01:19:08.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBoH0MyYkI3+SzWKmaFje8Nf0UlcCZGnLgXfpr0NNPrNE8X9PvXCZYVIaUQA+V4cTBjDPsg5ddcy2TuzyXYgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

All PFN_* pfn_t flags have been removed. Therefore there is no longer
a need for the pfn_t type and all uses can be replaced with normal
pfns.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

I'm guessing people will want this split up into several patches for
merging/review. If so I will do that once the pre-requisite series
have landed in Linus tree and we've decided if this RFC is worthwhile.
---
 arch/x86/mm/pat/memtype.c                |  6 +--
 drivers/dax/device.c                     | 23 ++++++-------
 drivers/dax/hmem/hmem.c                  |  1 +-
 drivers/dax/kmem.c                       |  1 +-
 drivers/dax/pmem.c                       |  1 +-
 drivers/dax/super.c                      |  3 +--
 drivers/gpu/drm/exynos/exynos_drm_gem.c  |  1 +-
 drivers/gpu/drm/gma500/fbdev.c           |  3 +--
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |  1 +-
 drivers/gpu/drm/msm/msm_gem.c            |  1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c       |  6 +--
 drivers/gpu/drm/v3d/v3d_bo.c             |  1 +-
 drivers/md/dm-linear.c                   |  2 +-
 drivers/md/dm-log-writes.c               |  2 +-
 drivers/md/dm-stripe.c                   |  2 +-
 drivers/md/dm-target.c                   |  2 +-
 drivers/md/dm-writecache.c               |  9 ++---
 drivers/md/dm.c                          |  2 +-
 drivers/nvdimm/pmem.c                    |  8 +---
 drivers/nvdimm/pmem.h                    |  4 +--
 drivers/s390/block/dcssblk.c             |  9 ++---
 drivers/vfio/pci/vfio_pci_core.c         |  5 +--
 fs/cramfs/inode.c                        |  4 +--
 fs/dax.c                                 | 45 ++++++++++++-------------
 fs/ext4/file.c                           |  2 +-
 fs/fuse/dax.c                            |  3 +--
 fs/fuse/virtio_fs.c                      |  5 +--
 fs/xfs/xfs_file.c                        |  2 +-
 include/linux/dax.h                      |  8 ++--
 include/linux/device-mapper.h            |  2 +-
 include/linux/huge_mm.h                  |  4 +-
 include/linux/mm.h                       |  4 +-
 include/linux/pgtable.h                  |  4 +-
 include/trace/events/fs_dax.h            |  6 +--
 mm/debug_vm_pgtable.c                    |  1 +-
 mm/huge_memory.c                         | 23 ++++++-------
 mm/memory.c                              | 32 ++++++++----------
 mm/memremap.c                            |  1 +-
 mm/migrate.c                             |  1 +-
 tools/testing/nvdimm/pmem-dax.c          |  6 +--
 tools/testing/nvdimm/test/iomap.c        |  7 +----
 41 files changed, 108 insertions(+), 145 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6..508f807 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -36,7 +36,6 @@
 #include <linux/debugfs.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
@@ -1053,7 +1052,8 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 	return 0;
 }
 
-void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
+void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
+		      unsigned long pfn)
 {
 	enum page_cache_mode pcm;
 
@@ -1061,7 +1061,7 @@ void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
 		return;
 
 	/* Set prot based on lookup */
-	pcm = lookup_memtype(pfn_t_to_phys(pfn));
+	pcm = lookup_memtype(PFN_PHYS(pfn));
 	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
 			 cachemode2protval(pcm));
 }
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index fd22dbf..37ffb2f 100644
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
-		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
+		struct page *page = pfn_to_page(pfn + i);
 
 		page = compound_head(page);
 		if (page->mapping)
@@ -105,7 +104,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 {
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PAGE_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -126,11 +125,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+	return vmf_insert_page_mkwrite(vmf, pfn_to_page(pfn),
 					vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -141,7 +140,7 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PMD_SIZE;
 
 	if (check_vma(dev_dax, vmf->vma, __func__))
@@ -170,11 +169,11 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, 0);
+	pfn = PHYS_PFN(phys);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_to_page(pfn)),
 				vmf->flags & FAULT_FLAG_WRITE);
 }
 
@@ -186,7 +185,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
-	pfn_t pfn;
+	unsigned long pfn;
 	unsigned int fault_size = PUD_SIZE;
 
 
@@ -216,11 +215,11 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
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
index e97d47f..87b5321 100644
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
index 21274aa..d6ac557 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -6,7 +6,6 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/mman.h>
-#include <linux/pfn_t.h>
 #include <linux/sizes.h>
 
 #include <drm/drm_cache.h>
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index ebc9ba6..1c27500 100644
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
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 49fb0f6..ba676e3 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -168,7 +168,7 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 8d7df83..4c6aed7 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -891,7 +891,7 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
 
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 4112071..5804bf2 100644
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
index 7ce8847..27d240d 100644
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
@@ -314,12 +313,12 @@ static int persistent_memory_claim(struct dm_writecache *wc)
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
+				pages[i++] = pfn_to_page(pfn);
 				pfn.val++;
 				if (!(i & 15))
 					cond_resched();
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 12ecf07..eb68926 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1232,7 +1232,7 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
 
 static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct mapped_device *md = dax_get_private(dax_dev);
 	sector_t sector = pgoff * PAGE_SECTORS;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 785b2d2..ae4f5a4 100644
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
index 8a0d590..3e01c10 100644
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
 
@@ -915,7 +914,7 @@ dcssblk_submit_bio(struct bio *bio)
 
 static long
 __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+		long nr_pages, void **kaddr, unsigned long *pfn)
 {
 	resource_size_t offset = pgoff * PAGE_SIZE;
 	unsigned long dev_sz;
@@ -924,7 +923,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset), 0);
+		*pfn = PFN_DOWN(dev_info->start + offset);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
@@ -932,7 +931,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 static long
 dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
-		pfn_t *pfn)
+		unsigned long *pfn)
 {
 	struct dcssblk_dev_info *dev_info = dax_get_private(dax_dev);
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index e6b6c01..2dfc3fe 100644
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
@@ -1680,12 +1679,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff, 0), false);
+		ret = vmf_insert_pfn_pmd(vmf, pfn + pgoff, false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff, 0), false);
+		ret = vmf_insert_pfn_pud(vmf, pfn + pgoff, false);
 		break;
 #endif
 	default:
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 820a664..3358bc6 100644
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
@@ -412,8 +411,7 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		for (i = 0; i < pages && !ret; i++) {
 			vm_fault_t vmf;
 			unsigned long off = i * PAGE_SIZE;
-			pfn_t pfn = phys_to_pfn_t(address + off, 0);
-			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
+			vmf = vmf_insert_mixed(vma, vma->vm_start + off, address + off);
 			if (vmf & VM_FAULT_ERROR)
 				ret = vm_fault_to_errno(vmf, 0);
 		}
diff --git a/fs/dax.c b/fs/dax.c
index 3cc5b73..d13aa95 100644
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
@@ -708,7 +707,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 		if (order > 0)
 			flags |= DAX_PMD;
-		entry = dax_make_entry(pfn_to_pfn_t(0), flags);
+		entry = dax_make_entry(0, flags);
 		dax_lock_entry(xas, entry);
 		if (xas_error(xas))
 			goto out_unlock;
@@ -1031,7 +1030,7 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
  * appropriate.
  */
 static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap_iter *iter, void *entry, pfn_t pfn,
+		const struct iomap_iter *iter, void *entry, unsigned long pfn,
 		unsigned long flags)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -1230,7 +1229,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
-		size_t size, void **kaddr, pfn_t *pfnp)
+		size_t size, void **kaddr, unsigned long *pfnp)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	int id, rc = 0;
@@ -1248,7 +1247,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
-	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
+	if (*pfnp & (PHYS_PFN(size)-1))
 		goto out;
 
 	rc = 0;
@@ -1352,12 +1351,12 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
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
@@ -1374,14 +1373,14 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
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
 
@@ -1771,7 +1770,7 @@ static vm_fault_t dax_fault_return(int error)
  * insertion for now and return the pfn so that caller can insert it after the
  * fsync is done.
  */
-static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
+static vm_fault_t dax_fault_synchronous_pfnp(unsigned long *pfnp, unsigned long pfn)
 {
 	if (WARN_ON_ONCE(!pfnp))
 		return VM_FAULT_SIGBUS;
@@ -1819,7 +1818,7 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
  * @pmd:	distinguish whether it is a pmd fault
  */
 static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
-		const struct iomap_iter *iter, pfn_t *pfnp,
+		const struct iomap_iter *iter, unsigned long *pfnp,
 		struct xa_state *xas, void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -1830,7 +1829,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	struct folio *folio;
 	int ret, err = 0;
-	pfn_t pfn;
+	unsigned long pfn;
 	void *kaddr;
 
 	if (!pmd && vmf->cow_page)
@@ -1867,15 +1866,15 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
 	folio_ref_inc(folio);
 	if (pmd)
-		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)), write);
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
@@ -1985,7 +1984,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 	return false;
 }
 
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -2064,7 +2063,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	return ret;
 }
 #else
-static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
+static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, unsigned long *pfnp,
 			       const struct iomap_ops *ops)
 {
 	return VM_FAULT_FALLBACK;
@@ -2085,7 +2084,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * successfully.
  */
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
+		    unsigned long *pfnp, int *iomap_errp, const struct iomap_ops *ops)
 {
 	if (order == 0)
 		return dax_iomap_pte_fault(vmf, pfnp, iomap_errp, ops);
@@ -2106,7 +2105,7 @@ EXPORT_SYMBOL_GPL(dax_iomap_fault);
  * for an mmaped DAX file.  It also marks the page cache entry as dirty.
  */
 static vm_fault_t
-dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
+dax_insert_pfn_mkwrite(struct vm_fault *vmf, unsigned long pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
@@ -2128,7 +2127,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
-	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio = pfn_folio(pfn);
 	folio_ref_inc(folio);
 	if (order == 0)
 		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
@@ -2155,7 +2154,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
  * table entry.
  */
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	int err;
 	loff_t start = ((loff_t)vmf->pgoff) << PAGE_SHIFT;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index a520514..608dcbb 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -741,7 +741,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
 		(vmf->vma->vm_flags & VM_SHARED);
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	pfn_t pfn;
+	unsigned long pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 48d0652..8fb4843 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -10,7 +10,6 @@
 #include <linux/dax.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
-#include <linux/pfn_t.h>
 #include <linux/iomap.h>
 #include <linux/interval_tree.h>
 
@@ -763,7 +762,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,
 	vm_fault_t ret;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct super_block *sb = inode->i_sb;
-	pfn_t pfn;
+	unsigned long pfn;
 	int error = 0;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_conn_dax *fcd = fc->dax;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2c7b24c..d0b6612 100644
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
index f7a7d89..e80b817 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1426,7 +1426,7 @@ xfs_dax_fault_locked(
 	bool			write_fault)
 {
 	vm_fault_t		ret;
-	pfn_t			pfn;
+	unsigned long		pfn;
 
 	if (!IS_ENABLED(CONFIG_FS_DAX)) {
 		ASSERT(0);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index dbefea1..95e53ed 100644
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
@@ -249,7 +249,7 @@ static inline void dax_break_mapping_uninterruptible(struct inode *inode,
 bool dax_alive(struct dax_device *dax_dev);
 void *dax_get_private(struct dax_device *dax_dev);
 long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
-		enum dax_access_mode mode, void **kaddr, pfn_t *pfn);
+		enum dax_access_mode mode, void **kaddr, unsigned long *pfn);
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
@@ -263,9 +263,9 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
-		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
+		    unsigned long *pfnp, int *errp, const struct iomap_ops *ops);
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
-		unsigned int order, pfn_t pfn);
+		unsigned int order, unsigned long pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 void dax_delete_mapping_range(struct address_space *mapping,
 				loff_t start, loff_t end);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 8321f65..d2ed4e9 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -149,7 +149,7 @@ typedef int (*dm_busy_fn) (struct dm_target *ti);
  */
 typedef long (*dm_dax_direct_access_fn) (struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode node, void **kaddr,
-		pfn_t *pfn);
+		unsigned long *pfn);
 typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
 		size_t nr_pages);
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9cb5227..65a5f00 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -37,8 +37,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
 		    unsigned long cp_flags);
 
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn, bool write);
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn, bool write);
 vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool write);
 vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 23c4e9b..08c40da 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3601,9 +3601,9 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
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
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1c377de..e57bfb6 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1503,7 +1503,7 @@ static inline int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
  * by vmf_insert_pfn().
  */
 static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-				    pfn_t pfn)
+				    unsigned long pfn)
 {
 }
 
@@ -1539,7 +1539,7 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			   unsigned long pfn, unsigned long addr,
 			   unsigned long size);
 extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
-			     pfn_t pfn);
+			     unsigned long pfn);
 extern int track_pfn_copy(struct vm_area_struct *vma);
 extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 			unsigned long size, bool mm_wr_locked);
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 86fe6ae..e188c71 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -127,7 +127,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->radix_entry = radix_entry;
 	),
 	TP_printk("dev %d:%d ino %#lx %s %s address %#lx length %#lx "
-			"pfn %#llx %s radix_entry %#lx",
+			"pfn %#llx radix_entry %#lx",
 		MAJOR(__entry->dev),
 		MINOR(__entry->dev),
 		__entry->ino,
@@ -135,9 +135,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__entry->write ? "write" : "read",
 		__entry->address,
 		__entry->length,
-		__entry->pfn_val & ~PFN_FLAGS_MASK,
-		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
-			PFN_FLAGS_TRACE),
+		__entry->pfn_val,
 		(unsigned long)__entry->radix_entry
 	)
 )
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index cf5ff92..a0e5d01 100644
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
index 5e42a60..3626bf3 100644
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
@@ -1376,7 +1375,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 }
 
 static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, pfn_t pfn, pgprot_t prot, bool write,
+		pmd_t *pmd, unsigned long pfn, pgprot_t prot, bool write,
 		pgtable_t pgtable)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -1384,7 +1383,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pmd_none(*pmd)) {
 		if (write) {
-			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
 				return;
 			}
@@ -1397,7 +1396,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		return;
 	}
 
-	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
+	entry = pmd_mkhuge(pfn_pmd(pfn, prot));
 	entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
@@ -1424,7 +1423,8 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PMD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1487,7 +1487,7 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio, bool 
 		folio_add_file_rmap_pmd(folio, &folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
 	}
-	insert_pfn_pmd(vma, addr, vmf->pmd, pfn_to_pfn_t(folio_pfn(folio)),
+	insert_pfn_pmd(vma, addr, vmf->pmd, folio_pfn(folio),
 		       vma->vm_page_prot, write, pgtable);
 	spin_unlock(ptl);
 	if (pgtable)
@@ -1506,7 +1506,7 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 }
 
 static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, bool write)
+		pud_t *pud, unsigned long pfn, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgprot_t prot = vma->vm_page_prot;
@@ -1514,7 +1514,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 
 	if (!pud_none(*pud)) {
 		if (write) {
-			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn_t_to_pfn(pfn)))
+			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
 				return;
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
@@ -1524,7 +1524,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 		return;
 	}
 
-	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
+	entry = pud_mkhuge(pfn_pud(pfn, prot));
 	entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
@@ -1544,7 +1544,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
  *
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
+vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
+			      bool write)
 {
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
@@ -1601,7 +1602,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool 
 		folio_add_file_rmap_pud(folio, &folio->page, vma);
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
 	}
-	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)), write);
+	insert_pfn_pud(vma, addr, vmf->pud, folio_pfn(folio), write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
diff --git a/mm/memory.c b/mm/memory.c
index 5f7a441..fef28de 100644
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
@@ -2406,7 +2405,7 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 EXPORT_SYMBOL(vm_map_pages_zero);
 
 static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn, pgprot_t prot, bool mkwrite)
+			unsigned long pfn, pgprot_t prot, bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
@@ -2428,7 +2427,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			 * allocation and mapping invalidation so just skip the
 			 * update.
 			 */
-			if (pte_pfn(entry) != pfn_t_to_pfn(pfn)) {
+			if (pte_pfn(entry) != pfn) {
 				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
 				goto out_unlock;
 			}
@@ -2441,7 +2440,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2510,10 +2509,9 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, 0));
+	track_pfn_insert(vma, &pgprot, pfn);
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
-			false);
+	return insert_pfn(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2544,21 +2542,21 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
-static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
+static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn, bool mkwrite)
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
@@ -2571,7 +2569,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
-	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
+	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
 
 	/*
@@ -2581,7 +2579,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_valid(pfn)) {
 		struct page *page;
 
 		/*
@@ -2589,7 +2587,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		 * regardless of whether the caller specified flags that
 		 * result in pfn_t_has_page() == false.
 		 */
-		page = pfn_to_page(pfn_t_to_pfn(pfn));
+		page = pfn_to_page(pfn);
 		err = insert_page(vma, addr, page, pgprot, mkwrite);
 	} else {
 		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
@@ -2615,7 +2613,7 @@ vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	track_pfn_insert(vma, &pgprot, pfn_to_pfn_t(pfn));
+	track_pfn_insert(vma, &pgprot, pfn);
 
 	if (!pfn_modify_allowed(pfn, pgprot))
 		return VM_FAULT_SIGBUS;
@@ -2640,7 +2638,7 @@ vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 EXPORT_SYMBOL_GPL(vmf_insert_page_mkwrite);
 
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-		pfn_t pfn)
+		unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, false);
 }
@@ -2652,7 +2650,7 @@ EXPORT_SYMBOL(vmf_insert_mixed);
  *  the same entry was actually inserted.
  */
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
-		unsigned long addr, pfn_t pfn)
+		unsigned long addr, unsigned long pfn)
 {
 	return __vm_insert_mixed(vma, addr, pfn, true);
 }
diff --git a/mm/memremap.c b/mm/memremap.c
index 6c13e72..0f007f4 100644
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
index caadbe3..532591c 100644
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
-- 
git-series 0.9.1


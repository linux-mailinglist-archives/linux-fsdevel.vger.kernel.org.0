Return-Path: <linux-fsdevel+bounces-52174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36805AE00C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CED74A0AF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57626E705;
	Thu, 19 Jun 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBeXx6t+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1D27A44A;
	Thu, 19 Jun 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323518; cv=fail; b=HUD7JXR3mySGMVrQlsDHzYdYD5chWaVt3OKiVeUcH4LoDd/WXlCP0HA1TaZytL9Gc5viwRSrIlMuxdIVLDc2Upkt5kPv4ZfiRIETSUZ2ZIc6AGM23In7I1wH/YaMeYO/eFpYpOb4xL1TIBTNBaU2gZJcHe33yv5HdgENEJymFG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323518; c=relaxed/simple;
	bh=AbiQ47G9dvqza2qP70rG58uzFRrPhrd9SisBteXtzVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XITPWjjaAjemUXs5Fp9XKjOoQXLe2C8ysIgKx9YqzN/xpX3H2fLsJEGPwHAGycn36wJauv7uJd59aWclnseyigzi3V8PEUu9N/01wMzJnlBZGyvnRIDSq1TNivFaaiDSu9hVeafUBL4BRFzoXphQ1YjVMJCrbB4MxyxkRkeIGyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBeXx6t+; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhtyyTPBNo4CzR1YbePz0WhXtb50OnerXYRztYSeew5jWn3n7t0COVsQerDNkVZS3K60yz/ZYy9cdKvgsrQezWzgB3D3M11l6p9GAsKj9C2IYkV8c2zIidsqQDfzr26zC2yUPN8fkDaCZN9OeLyyDZgTOhU58uGqc8K5WylikfCB2GJhB0KcjFh5NqRWXopPlc+7y0JMFv/YyE0dMJjUNCaA7QCspLwmnmNFlF51zmnX462xwd/aAWq3McBZLftd1khAU+3BXGuS8N7/F/1OZeDyl7jsWImaqIa41ELv1xtxlLX/NXItk515EfpRdybnhbToL7h+HZiAuz7UCJX19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T435w9sykA7dzJR/yV0ODjo3RxwRixD4+YBinkEOdrw=;
 b=Dm9Oq6VtiwyuXRF6mMevsDDQAu7igyJH9kdMSAKRcO9OPNu8PVnEOMgc09B8ggdMPn6y+ONFLjTy4ktRFD8xzROd+d4+dA0mqbfTProkN2NEhDumjdS3mSzCU9lGRFxzEG51zsmtLF+LCnxbBaiqhcgbKeFhqffT557m10zgLQq2IadEwNp4xpZO3a7E0zq3zvt0QYKAYKOKr1Fj2MeYZB5QhBaJ0+dKYoEhKnPatzEH0uQy3XYUSabsmstsuptsSsptofyIAacG7TrLypd0oDKVwgAK/uLXZ7bcJD69M98AtmvkX8Li8DN0ADH9tROURHbtFQlAu13S76tbcGf44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T435w9sykA7dzJR/yV0ODjo3RxwRixD4+YBinkEOdrw=;
 b=hBeXx6t+cn6neagcSLvEQC1wLl2GTy7e1vULEv7wULGVyj1nKEcGDQGk5BPbd7p2dOiUbrL3O6R5AWHLN3RbWYrlAouvvndE7sZhLT530MLVajyaaTxZkSkAEJcYbwm5Ubau7DWNSSJjLAcrhRAYTCEBTr5i+1ieiasBcxGoWPXVeOeksPtb2Gym1p6n7yjd7WhIjhvYQcyvtqWZ7wlP4zxicL2JE06rBdFkg37KkFgjb97ukjd0akaNcaUcOde+dhgc3ezF/7wzBflDQwjT0U6K6Y49LClX9qjDTwjHNhvWwHLrlvQCWyw0+NOML/a78Ibr0q11NdsBQIk3UFwQjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 19 Jun
 2025 08:58:34 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Thu, 19 Jun 2025
 08:58:33 +0000
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
Subject: [PATCH v3 03/14] mm: Remove remaining uses of PFN_DEV
Date: Thu, 19 Jun 2025 18:57:55 +1000
Message-ID: <74b293aebc21b941090bc3e7aeafa91b57c821a5.1750323463.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
References: <cover.176965585864cb8d2cf41464b44dcc0471e643a0.1750323463.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0126.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::16) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fef0ad-6998-48cc-ecf5-08ddaf0f7860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efKeLwDc/zXXhfvtQcmJ0ZYURoUACKeA8ngkVCC9qIdg7+nni8LneMDvk8a5?=
 =?us-ascii?Q?uxMA9p5vdsJC2TbOHAC5TDPr0fJjFWZ9WtQ88sury3FjPW5WEhxWm0snf5i9?=
 =?us-ascii?Q?ZZaw+uNk0TiJ9tudA42l+6J8gBnrSRpMfYNR0Btd+REK47vvvc+ijqr7PyxK?=
 =?us-ascii?Q?DiNqR9iyLOD1mySE0VPKDpCzc6T2n+1lmk7YWUl70ZjcgOsw5Nl7OSLZ80eY?=
 =?us-ascii?Q?k0vkm7OXvrGurXDMc02Veka/zqo5HnAchfFevGx/ow4eeA60SCMPKvaIoW78?=
 =?us-ascii?Q?Inja4wG/1G9zdSpkeSGC6uBurgeyA+owsb/ZMEVN8Vv/PqLqKvWnIikGYFfm?=
 =?us-ascii?Q?rDix/xF+xWruX49GU29Phn42UNIyUQcqaZjAaNq+AFFnNBP/ZPVz+SNMnXTY?=
 =?us-ascii?Q?yFLuMu/bI4QhStYpxeF+f8arjTcJevpyQj8j9+aNIMfV+lkmrHQvn2HxO5De?=
 =?us-ascii?Q?Y/4rWYv5VggX6OJ0AYf24nAXKxxJxbFAaujb1sI/ZOY4zjS9Ym/fPF+ZiZ0h?=
 =?us-ascii?Q?fjZVNOV7DrJEOIPJhSyS7rN8CViZe27VHlmhwz5N0iOgeepECoZfVFPN+4+w?=
 =?us-ascii?Q?yuo+dg4rh0Pqtm1KeMvB5euYJeuizckGQKBdz+9MsswHqYZi91WgkFVg0Jtf?=
 =?us-ascii?Q?I7MnP52hECpfAh17wdbjEaYKqBdgvH0qqb/Qk42AMGybXsNAW550JNS/3+W6?=
 =?us-ascii?Q?nZygHTyhluVfDCo53rkqj50PrBaANWMxaaY9MINrxTLOsdwbLnqM/Gpnao9u?=
 =?us-ascii?Q?2Y44KVCDtO+XbNrrg05KLF0/HnSzlNPJt8ruNPMcTRtpOPzBpyoFp3qZB4mi?=
 =?us-ascii?Q?A4nzmbjaSwmbteMCtKTnJvSe2sTKsdJsc0aNhJVZ4ntCrGAnl8yLPgoaRnme?=
 =?us-ascii?Q?Ki1MxT7Asf/NJb1+R1DcOAmDHOcVNG5ANPJttvg5eflgWG8x2cQ+HekJOGHq?=
 =?us-ascii?Q?+SnriVKYRRqho//U/nAbE7SgCwlJmp4MuJrWzzJXKwnv2xWDisWdV6y0idJ6?=
 =?us-ascii?Q?cBwyO97xcfFvZ48ymle0lC3Cmj04UJQgBcreA1GXqa0b5nf86H4/oPhTMUFq?=
 =?us-ascii?Q?WYOFXHgtCGDCvt79JQYu6bWCxnZm2/tt+wcci88mz9u8SYr42uaRfl2TnMDC?=
 =?us-ascii?Q?lPjK/JN+5bxB+kzFzHAuvkNX0NxxzZSe3RHterw/XBsDtNNJ2hPA6alXloJ6?=
 =?us-ascii?Q?KuzYI5tJ0A3BSYBaBHdwh3dAm80Ra09DvMpqGGLt21IToFcd5pQDEYoBoDu2?=
 =?us-ascii?Q?e2VNIvU7wbsy+Mo3iy9LheaDajuVvmkzk3VfJxeaJ/VetwQzlVJ8oMsenPN/?=
 =?us-ascii?Q?3a/A9wITsVPMiCUIzCixf2TZ2JJlEtmEzjyobkrb7qieVIyOammE4gooM51x?=
 =?us-ascii?Q?EjguuqGJayn1Ja/avzKEguG8lSzphQ4FZ44WecLtbzgXbwHKVRhoxzwJKz+5?=
 =?us-ascii?Q?FKuCQJp+xlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iu3cpBD6p0q0Zfms8ag3Z93wLP63IuCrVIgntIHfWQquY9EGg8s+qwKOpg7l?=
 =?us-ascii?Q?87AHCMZjj3NQdYXMF9v5QtgECkn1frCmV2nFoxb3c4mjjDjoi3WMQIWStDpO?=
 =?us-ascii?Q?A48GMhEBVS2aq8AStV1yOOKkd6IkMid13yLxJe2MD4MoGogvoAPNTihMG/bc?=
 =?us-ascii?Q?hMDMB0df0kxfsjk1QEbusZNh4pwU+BNupqML1UaLsxjB5DD52S2wwttyQPah?=
 =?us-ascii?Q?hw6RYLkBaKaPnUWCfaE7B9Im7IvfDeRz6a1kJGfkT8E8kqnFt6qsAHAHEN8w?=
 =?us-ascii?Q?+bhKhhbmD5bOZ6hXFb4y0TPIkESgdMwl55iDKF8xXuZY3wKAsnmvfcX+4Ivv?=
 =?us-ascii?Q?VLf97v+yb/jcLFaNzmHFCIZhwAl3LdVzD/g3DY0PxdfDhax1aNPWeSo02gcb?=
 =?us-ascii?Q?MQkAu6lTEhVa3eERJL2QZmH/M3kcFHWP04Hgoksi4hdA1fYsCpVo0CgPkTQF?=
 =?us-ascii?Q?B/17ULAjyOxvlpwMtXJnQcykUa/RYTN+bUxRpfTsSUmDZKCicnNCMMPUOC6v?=
 =?us-ascii?Q?8zS/vZKnAJTXLKRhjhUtGht3MjujsTqsPdNNpTaA62EDAiI9UNGQzy0/f5mD?=
 =?us-ascii?Q?xLNE0L5/lAtHtQVwkzwVBG0Z/yDxxKOrb4Z6sEIW2ife5BLPpTwNDHGLLIh3?=
 =?us-ascii?Q?tzdKDz5TU+uoDWznGp1+KFYtRsae+5b/b0zAPPPkpyp/iMBojNOa0LXsGRqa?=
 =?us-ascii?Q?Eabj9Ri6OE4/azV4Ozt9TZ/0a+wUYSz976eQtVmbhCnD9SQnd7BYAEje+e2+?=
 =?us-ascii?Q?ZRaiZGCgk4ymGT0WBXE/Opz116CsPXzjUxhZ2Ar924l4jE9YIx2NO+/aRjE8?=
 =?us-ascii?Q?+3B1sk4ZmrnUn2ov88U398+rD9nH4Q9VIX4Uc3BSmAcQ+sVzhFjWW61s5c+Z?=
 =?us-ascii?Q?p+Ujve1tqqZTh9iIoeA/KV4bPkvMUoYiaqfPIUN37yPZW9D42U7Env1Pkswo?=
 =?us-ascii?Q?sJ9CZUJvnWZ5OKRaqxocF2KjX3O5Qgqem0rYyMzmL3SDNW9haYNU4Zt8ytkP?=
 =?us-ascii?Q?xKMsn2YXTX3lkDq9TfNa4asenbllOIk/bee9OtuJ/mXI+uruxI2xvyIdMyYa?=
 =?us-ascii?Q?FPWRiZlrfNFqVVa8o6GtHCvnbtXptMgfjfHEIhgoqz3mVsgtDbzIg1d1bEhv?=
 =?us-ascii?Q?rXGp6Rw+vA97Ufdt4sFi+m+e8eL+gEdDD+xFEKQ7+JAEDF2Eu7iefBCVeblM?=
 =?us-ascii?Q?2K99aB9A+pVYFhBVQrNXP54+m3cPFg/SnMZUCuVED4rxyAYoKsqChyibacKL?=
 =?us-ascii?Q?yw41TT7Yp9xDXzc99sPGpclARW4fsi2NHBCdxaV1SQoTYj4IC72DdWirhDvE?=
 =?us-ascii?Q?aElknASwsnE2/w/ebtxXS0Q5xhGgc5uJ/PqbhDyMj9EHQlNO3C0KlTwRox2S?=
 =?us-ascii?Q?MEG5+cVWFVghJDGfgqIo/wM+00EjHpgotX/ku9RoVmgwH1EEp65dNSCXpmvl?=
 =?us-ascii?Q?7mfQSooccRdnx4BmJmhhL7SiGZSTJE9C1/VbcKTP2i0ErFIngFLHrvrvCe6d?=
 =?us-ascii?Q?4j7rrKKonszWbQY4g86/1+axgA2y43jL1SmUCLe0h2LX7hMZhA4Pezzb8zqj?=
 =?us-ascii?Q?F4Cai8ynpSNoXsqTxea5kESZvYYJJDr2Cqx9MI/X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fef0ad-6998-48cc-ecf5-08ddaf0f7860
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:58:33.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcgo1gv7+XgrJQm2Weo1/pHIRe95XutnAkZSJaxrLK6Fv+3h/5PQz1y1iUuwcDI9V7aT2xQ5ywgKBOK1+nQ8Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956

PFN_DEV was used by callers of dax_direct_access() to figure out if the
returned PFN is associated with a page using pfn_t_has_page() or
not. However all DAX PFNs now require an assoicated ZONE_DEVICE page so can
assume a page exists.

Other users of PFN_DEV were setting it before calling
vmf_insert_mixed(). This is unnecessary as it is no longer checked, instead
relying on pfn_valid() to determine if there is an associated page or not.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v1:

 - Removed usage of pfn_t_devmap() that was removed later in the series
   to maintain bisectability as pointed out by Jonathan Cameron.

 - Rebased on David's cleanup[1]

[1] https://lore.kernel.org/linux-mm/20250611120654.545963-1-david@redhat.com/
---
 drivers/gpu/drm/gma500/fbdev.c     | 2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c | 5 ++---
 drivers/s390/block/dcssblk.c       | 3 +--
 drivers/vfio/pci/vfio_pci_core.c   | 6 ++----
 fs/cramfs/inode.c                  | 2 +-
 mm/memory.c                        | 2 +-
 6 files changed, 8 insertions(+), 12 deletions(-)

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
index cdc7b2f..249ae40 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -923,8 +923,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
-		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				      PFN_DEV);
+		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset), 0);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6328c3a..3f2ad5f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1669,14 +1669,12 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 		break;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	case PMD_ORDER:
-		ret = vmf_insert_pfn_pmd(vmf,
-					 __pfn_to_pfn_t(pfn, PFN_DEV), false);
+		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn, 0), false);
 		break;
 #endif
 #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
 	case PUD_ORDER:
-		ret = vmf_insert_pfn_pud(vmf,
-					 __pfn_to_pfn_t(pfn, PFN_DEV), false);
+		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn, 0), false);
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
diff --git a/mm/memory.c b/mm/memory.c
index b0cda5a..e9aa15c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2557,7 +2557,7 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
+	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, 0), pgprot,
 			false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
-- 
git-series 0.9.1


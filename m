Return-Path: <linux-fsdevel+bounces-50035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A972AC78F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A901C085F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 06:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD0225D547;
	Thu, 29 May 2025 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fVxOyXSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC9256C7F;
	Thu, 29 May 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500382; cv=fail; b=Y568ariAbaPrIUm1oW6yAzP/kBFQRFC7/zdv30V7TJ1iWhY2H/AjHwU3GTEgo0uMqMXF4SFAdNPoKagVXcl/hzO9OnG9dmA+OhFqja45vBzn28WrIADPkSo4JnvEIR6fkywHSadCLpCTbEABSytlFaezalQvhgBfV1uOx5zBnzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500382; c=relaxed/simple;
	bh=9i96aKKlwS6jwaFjdOCtvswxK2AR/TpTcjbwoq6denQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOuB4L/IE4j0xevuQ6PPSlZQ0/9mKD0u5mJVKTo78evqJ37G7ypE/VI0OSQj2PDUJLI1YMOyXmY0kdlJ8hZf3Vp2R4DhdF97kqD0kq4LSKMg9/047FysXwXOzGiV/sOWoog8qdSz6CA7NsRMEuGG6527HC5YRdYxMudm6LuLKYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVxOyXSj; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM3OSXIEkSzvH7OgkBz0sGgsKUiWgLBLZV9P368y409VwbSiUKZ9SyUUH3HhyVfOofD9XGi+04d7/wTzWyxcvYGCcOaaXeKoh6LFfrxrcwiievw2KF6JrkC//9CnDf3SiTG8KQmSLZ8BhiPHTBP1ZXXLna459BGAjeG7h4qqLWHXsY2R48Ybu6vaZ4laf9h3OJrFsV3yV4lMOts0yCaN36OXD4L2LlkbGq8ChFWpIDqDaiRxjUhu9lYi8O2kbusLdmkmUU/iKz6EVKzf+ONiGhO51iLOBiKJYRUo9Xuvfi9/qeGJFp/rSSFI1Bmm5PAqa4uNra5AYfVahp2tpKFMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4hQmsNZ8BoqOkE6zp7PQXfqewvGT70s9ilgPxeUH5g=;
 b=fiD48j6NTY66yFEjGidB9bTQIcgmZDm1kNt1I9pz7AUEqeL0t7HaBDeci0p66Uzh7bzh/SDFdjgnD83zLL7jr/erldowSVAfmWmqiQiHFGJkaRLmLd0K2t0r/VeYGqQ1BMrxRRJxjHTGQi4bnHfsVdywVM7+sF5kX0eDQvsVOiL/l1PNRwkIjTWccgs7FHkC563KZ52JH0yGSiwW6BoT/aDXev0cRJeD7ExPwEr5O6R7JQMNznB8K8yQZ9sHA/7sxAa4iOXjdITFa7rxnDlCJziQcKgTH4VRt6bGHPr+RF9EmoE6RzqVBF3FRxzBmTnCr6FgI7ocWNb9X7bnocX1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4hQmsNZ8BoqOkE6zp7PQXfqewvGT70s9ilgPxeUH5g=;
 b=fVxOyXSjt54KsFCCmKhU5Ppd0I8K/1wpToPlgDkP/f6kmlRRcoLgtFu4eGGZyp906bakHTwDhJdkpKI9NfI09+v8Ij0XW8e0dPRuYpFCT4tsHJ/lGtMX7KslfcBWcgrRLBtzvEnIp1M4FlxbGna2k/CZmmII906MaSokzW/TBUoo9SAJorfznJGmhy7uLVqjR+4JMtkQxSWBj9XYMZN/eZzn/wGe+eHy4I/M8MWLG7cmU86x1pyYyV+oFm7Y+kkk+qc58KYMB+VzA4smF0Nx+z0Uk6dVuin9Z3U+cXNLm/UKsO6Yr4FPcQ5ktj3XCn2hrxfbUEFvXEJJ8MFvLPJ6+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 06:32:54 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:32:54 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
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
	John@Groves.net
Subject: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
Date: Thu, 29 May 2025 16:32:08 +1000
Message-ID: <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::19) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 61dd7696-adde-4caf-e25d-08dd9e7aa4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9T+k06I0XpxVgoccM5M63lq/dVVhg87xb0jI3YmFj1/mp+dzVwL2/DT3Qmq?=
 =?us-ascii?Q?YioysYiwsBp0V905rLO92no5a190UrUKyBzeIu3C0FE5K08GgIBuaDVqHp1B?=
 =?us-ascii?Q?wQb2nSJ1ZM88FX+Alw43m48cWnDxDOcM9VXhC3gEWF6ZQlNEPl9YIiV8D3+b?=
 =?us-ascii?Q?CD5h4gBYBIDkacBtWS6zdewsfcvcFPVZD5zi/Tb7wLdNJGr7eYWcuxBF49Im?=
 =?us-ascii?Q?GcCWdDc548uzVyl8gsivCkBosKG3txDUJnlAdBjmT2RklRREDXHeTJfMy9N1?=
 =?us-ascii?Q?8jQoi5gqGyy5YeSKpzWAcIZxpgpDtzuPM2w4mFx4Ih+G7cIXM8EG1prBtdZE?=
 =?us-ascii?Q?HD36Q0DSf6p6GArp5iqfudo0nxR1yL86Q+lDWVaMVhEXUJjFOy+ERDdHsoKv?=
 =?us-ascii?Q?0R8LoxUAjsLYfCbs34svsUrXhnxZk7M2Ra/1X3aLSSyBXPeMORt3iOQEbj1i?=
 =?us-ascii?Q?kjTJkjgTZNZMNkaJ9BXkjuBvLIeD0WH9XcjI4UHjMWvXn2tfMP+rfS5ZHh0f?=
 =?us-ascii?Q?96AaxbyLXvFvWZfrZKPQxyUfZc8Pr5Nv3vHamSOmGLWBnyvVhtynu33SDz+c?=
 =?us-ascii?Q?bM2pT2zbj+46ze4vJ3Bblb6otVig6t0Gvo7JAEwBGzopESoTOwA/O+1d1+4Y?=
 =?us-ascii?Q?KbDg3nZt2BsI4Ghu4u32nVQzY39UPAi+M2lWbyO4ksyzlFah8TrakT8PsTPx?=
 =?us-ascii?Q?R4iXN5T2G1Z8sFGbn+l9OS5qXzW75VWDUtwO82lsZAnrv2AndFZ1XUEjHyGb?=
 =?us-ascii?Q?fqwOkpRBdO2mHb0ef0aoNirRuTpMEPp80CC1wm1f4V9+r/TdYJhzXS0oAFos?=
 =?us-ascii?Q?pHLtZ5H+/+aJ1LKQqmtF86EVcT3dDCl59Ooj6L50zeUd68RbganE7m/IDv/L?=
 =?us-ascii?Q?5m1jIpCW452jKlD/iaWEgXvk+FQ50xZHP6zPp7/o6usfSOZ467+c8mlCTwbj?=
 =?us-ascii?Q?tD4A+mY0KC3zcFTQnMnW3uK8XufIPwVf2I0wB/svChgkkvXMVDHkztg8A7oa?=
 =?us-ascii?Q?8RfKBVQlRfjzBePRYvXVwmHqvxNgnSwpzL/91vGpsW0Txb+GLSh8es1jvqhs?=
 =?us-ascii?Q?ZErV2zkR2qyswe1rYey5xrSO0vskObfnNxYfGE3uGMvlSF6gYXNtapuaZK6n?=
 =?us-ascii?Q?i5bO2mvvWQ/tjCyJ7H/nqgQkszTS9PVrFbykQnCdY68a5nIg9aK+l0h83rQz?=
 =?us-ascii?Q?/rxI+930eyVxxvJi4RJ4q+3JpuLp+JlCZPHxFn/GHnnFa0WPKqLWHF/9DdB4?=
 =?us-ascii?Q?KdsuB9PZyPSG538R5vp3EoyrcXwOXt624NOoCzzq71LZqUiye5kQzMPa0Wuu?=
 =?us-ascii?Q?ozAEwiFWHOB/+E2eYS3C/RbkMY0iCWW42yxW3bHtHqTvIR76jPq31DXBzLnV?=
 =?us-ascii?Q?a/Aoi+NqEQHqRtQeUXafwJVyc3p0E6wrAcMUS2NSTqTeRNn46DUP4DYssGQ2?=
 =?us-ascii?Q?osyVo/cgF2s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALW9uN/cZUSoTo09kLudA3kX/ee8YFWDfKR0MDTqFTTs+9zdaLW4yEIdSpTm?=
 =?us-ascii?Q?nYdhmDRP4Ru1v8RKuDSLq1VLywTgC6iFeS9pez2mJUaeXEyiWWjZUp40EgUC?=
 =?us-ascii?Q?hGDqCJ5jysu8LVj5KwLLmWm0Y5rW2/dPT6I58aAIpYoQM+rJNHeH7iyvWDqF?=
 =?us-ascii?Q?4oe8TVmzBJ5TF1et0o3pjd9qZUzxjuVuwGuWJrGgemPDxsKoQzwT8Bl6C20u?=
 =?us-ascii?Q?ySfI7efaMnfWQZMKoCQLCBzLW/Lc+cBJrkJpA5Epzxs5PaZn3QmL9iXbrib2?=
 =?us-ascii?Q?2SlHox8yDQtejiIZJ8Mop+a/lcmAOTeJMSQGmee8q7hkdgrkgc1IkcKTXYRb?=
 =?us-ascii?Q?YJCsHUJa+216ZILGwjfJJyiMrmXb0hm1f7m88q19rnLI9OROLMJHiZj2ve8g?=
 =?us-ascii?Q?6fotvbGgGaADEkTK3+jJOZshoBqUKGpBKi6IMo9Pdtr/9mFEwrnzErG4LvZb?=
 =?us-ascii?Q?QLdZ/IvNo7I7oSdrP2l4r1oY/tHhb6lAwn/iABRdZ73g5vjEog1LrAdO8605?=
 =?us-ascii?Q?2co+4dc0L1Ks1AyGCy7UXrW4rjR0YOom+ldsYg81MIQrbT4WphaoeK4GVQg2?=
 =?us-ascii?Q?JzEWw4l2YSV2YqdPgc27xKrUgIfYDdwL6CGqbPF6QKGlsDsQwXxJFBKps/om?=
 =?us-ascii?Q?KkBWdftFu2DQrAwZSMdw4QVbXBsqfRbvy305DTQ+mpWe5PWUZHVgy4YdZwn2?=
 =?us-ascii?Q?jdh+UC+6dkwD3KT3G4NwZnA/vqe9h1GgxU2kXwlSoZY9H14EQty13FpkdQSM?=
 =?us-ascii?Q?ODdvoPxQnD5+tC7AKo+rfw6lM3gnC/MWS8M5hIf6f0DKt65zSFqYmT3pJAuL?=
 =?us-ascii?Q?G3KzyPBFEhCd9oyOZnKURDO0KCwRW/O0d1xuQftN06gPXUCWH7oQF/z/Hwdc?=
 =?us-ascii?Q?IjQ0l6o9WIlSNJev5rFUlC+hCsBKw8PfVf1FVEav5gKk1874biahQUx/rPjA?=
 =?us-ascii?Q?Noo86E/GrHYYI9eMhwy7/HIfGtNbIqFqGAW+qiSK37Xw7ivBjLrotQ1ZNEWU?=
 =?us-ascii?Q?zIbNgr1CmFqH572ScCob0WYyN+kvMSU0H8fTAa1PWeJlAaUG8pf5fLcYJDHz?=
 =?us-ascii?Q?6wNZbxIkRbBvKl8SoFysA3q51NR75XiUxPaQMLDS7QWQzneGseJNvZZqVOh2?=
 =?us-ascii?Q?hRYQT3VRxy7TbCZyyzbJnXDFJYy5QrguTXE2uQdo8sXHIkDVaWHzOtwhTF19?=
 =?us-ascii?Q?YC1byEf1iiJtl6a6bC7fZRddt31Cd4o30wU2td8EZ2XtkD/Z0LGOBJoPdm4X?=
 =?us-ascii?Q?cC+oRKAZWiAJrVr7lsiWaV5sKGlMT2oqAy5dFyrCMKZ962As0pt0OGJBeR0L?=
 =?us-ascii?Q?fcD6B+XjtQgd0RxZSqod3RraStZvM9Ihy5C4myZAeZfaKMWMdFYN4XSG90SW?=
 =?us-ascii?Q?DHBahlIw2bJ51hrsa+hkyqIWNi/nMyWpVTwAUZJWx04r35TkmwE9Jbm0OD5W?=
 =?us-ascii?Q?8zwQFAbal59V6fmDoGq4Io9q0xT/eRpRS2D3EJCDHGubuumo6FGECdmoJ3Jm?=
 =?us-ascii?Q?y08nd/tNHv/flEfKzRUPKsWPewlh3MLxRyxAntWVNHGl76eHIPwehsVf0L5D?=
 =?us-ascii?Q?PuMlB7db0YsogW2G96gP8XS4bV+IyNi/FKQyMyDJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dd7696-adde-4caf-e25d-08dd9e7aa4bd
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:32:54.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVWUcMfx4C3vJbB/DvEMSHcgSThUCtl6h5CobybIZjgMwEJNjetBkpmPB9XR0ps3Jp//gRGQyiq9AXTvbuekPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

DAX was the only thing that created pmd_devmap and pud_devmap entries
however it no longer does as DAX pages are now refcounted normally and
pXd_trans_huge() returns true for those. Therefore checking both pXd_devmap
and pXd_trans_huge() is redundant and the former can be removed without
changing behaviour as it will always be false.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/dax.c                   |  5 ++---
 include/linux/huge_mm.h    | 10 ++++------
 include/linux/pgtable.h    |  2 +-
 mm/hmm.c                   |  4 ++--
 mm/huge_memory.c           | 30 +++++++++---------------------
 mm/mapping_dirty_helpers.c |  4 ++--
 mm/memory.c                | 15 ++++++---------
 mm/migrate_device.c        |  2 +-
 mm/mprotect.c              |  2 +-
 mm/mremap.c                |  5 ++---
 mm/page_vma_mapped.c       |  5 ++---
 mm/pagewalk.c              |  8 +++-----
 mm/pgtable-generic.c       |  7 +++----
 mm/userfaultfd.c           |  4 ++--
 mm/vmscan.c                |  3 ---
 15 files changed, 40 insertions(+), 66 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6763034..206dbd0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1938,7 +1938,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PTE we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		ret = VM_FAULT_NOPAGE;
 		goto unlock_entry;
 	}
@@ -2061,8 +2061,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PMD we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
-			!pmd_devmap(*vmf->pmd)) {
+	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd)) {
 		ret = 0;
 		goto unlock_entry;
 	}
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c0b01d1..374daa8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -400,8 +400,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 						false, NULL);		\
 	}  while (0)
@@ -427,8 +426,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
-		if (pud_trans_huge(*____pud)				\
-					|| pud_devmap(*____pud))	\
+		if (pud_trans_huge(*____pud))				\
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
@@ -451,7 +449,7 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
@@ -459,7 +457,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index b50447e..a6f9573 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1656,7 +1656,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_none(pudval) || pud_trans_huge(pudval))
 		return 1;
 	if (unlikely(pud_bad(pudval))) {
 		pud_clear_bad(pud);
diff --git a/mm/hmm.c b/mm/hmm.c
index 9e43008..5037f98 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -348,7 +348,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
@@ -359,7 +359,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
+		if (!pmd_trans_huge(pmd))
 			goto again;
 
 		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8d9d706..31b4110 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1398,10 +1398,7 @@ static int insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pmd_mkdevmap(entry);
-	else
-		entry = pmd_mkspecial(entry);
+	entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1441,8 +1438,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1535,10 +1530,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pud_mkdevmap(entry);
-	else
-		entry = pud_mkspecial(entry);
+	entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -1569,8 +1561,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1797,7 +1787,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
 	/*
@@ -2651,8 +2641,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2669,7 +2658,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2721,7 +2710,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2754,7 +2743,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	if (unlikely(!pud_trans_huge(*pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
@@ -2827,8 +2816,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
-	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
-				&& !pmd_devmap(*pmd));
+	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3047,7 +3035,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
+	if (pmd_trans_huge(*pmd) || pmd_migration) {
 		/*
 		 * Do not apply pmd_folio() to a migration entry; and folio lock
 		 * guarantees that it must be of the wrong folio anyway.
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b..208b428 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -129,7 +129,7 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* Do not split a huge pmd, present or migrated */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
+	if (pmd_trans_huge(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 		walk->action = ACTION_CONTINUE;
 	}
@@ -152,7 +152,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 	pud_t pudval = READ_ONCE(*pud);
 
 	/* Do not split a huge pud */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
+	if (pud_trans_huge(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 		walk->action = ACTION_CONTINUE;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 7a9aaae..6b03771 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -663,8 +663,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (pmd_devmap(pmd))
-		return NULL;
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
@@ -1228,8 +1226,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1265,7 +1262,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1787,7 +1784,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
@@ -1829,7 +1826,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -6062,7 +6059,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		pud_t orig_pud = *vmf.pud;
 
 		barrier();
-		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
+		if (pud_trans_huge(orig_pud)) {
 
 			/*
 			 * TODO once we support anonymous PUDs: NUMA case and
@@ -6103,7 +6100,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_trans_huge(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 3158afe..e05e14d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -615,7 +615,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+	if (pmd_trans_huge(*pmdp))
 		goto abort;
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 62c1f79..dbf49c8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -376,7 +376,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
diff --git a/mm/mremap.c b/mm/mremap.c
index 7db9da6..bcebfda 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -792,7 +792,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		new_pud = alloc_new_pud(mm, pmc->new_addr);
 		if (!new_pud)
 			break;
-		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
+		if (pud_trans_huge(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
 				/* We ignore and continue on error? */
@@ -811,8 +811,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
-		    pmd_devmap(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e463c3b..e981a1a 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -246,8 +246,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
-		    (pmd_present(pmde) && pmd_devmap(pmde))) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
@@ -262,7 +261,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 0dfb9c2..cca170f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -143,8 +143,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pmd_present(*pmd) &&
-			    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
+			if (pmd_present(*pmd) && pmd_trans_huge(*pmd))
 				continue;
 		}
 
@@ -210,8 +209,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			 * We are ONLY installing, so avoid unnecessarily
 			 * splitting a present huge page.
 			 */
-			if (pud_present(*pud) &&
-			    (pud_trans_huge(*pud) || pud_devmap(*pud)))
+			if (pud_present(*pud) && pud_trans_huge(*pud))
 				continue;
 		}
 
@@ -872,7 +870,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * TODO: FW_MIGRATION support for PUD migration entries
 		 * once there are relevant users.
 		 */
-		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
+		if (!pud_present(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pud_leaf(pud)) {
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 5a882f2..567e2d0 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -139,8 +139,7 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-			   !pmd_devmap(*pmdp));
+	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
@@ -153,7 +152,7 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pud_t pud;
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	VM_BUG_ON(!pud_trans_huge(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return pud;
@@ -293,7 +292,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
 		goto nomap;
-	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+	if (unlikely(pmd_trans_huge(pmdval)))
 		goto nomap;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 133f750..7669f4b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -795,8 +795,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		 * (This includes the case where the PMD used to be THP and
 		 * changed back to none after __pte_alloc().)
 		 */
-		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
-			     pmd_devmap(dst_pmdval))) {
+		if (unlikely(!pmd_present(dst_pmdval) ||
+				pmd_trans_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 61e6c44..8bf62b1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3426,9 +3426,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
 		return -1;
 
-	if (WARN_ON_ONCE(pmd_devmap(pmd)))
-		return -1;
-
 	if (!pmd_young(pmd) && !mm_has_notifiers(vma->vm_mm))
 		return -1;
 
-- 
git-series 0.9.1


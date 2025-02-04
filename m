Return-Path: <linux-fsdevel+bounces-40850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA46A27F07
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE0F3A25A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95922069F;
	Tue,  4 Feb 2025 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvMTO5G/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C32206BF;
	Tue,  4 Feb 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709428; cv=fail; b=DeeuARqpjgzIOsWwqV/FFATlpvV2FIH2dAVd+I6SjuuNqJx1VEtpdmSKJWlIhr2AX81dlIethfsyCG9LanRdINRXtqUzl6B19mE3XdfRF3k4oCBVmfBS2w1BsTNVo3qfIojwA7rs0OP1+uPU5WtoKHyKr1YmVvG0eA7+Q+E8Iz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709428; c=relaxed/simple;
	bh=bVzgWyQa4w+3Tu64z6XFGDevakKWyWcLsWA7cirN12I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBELR+g097BWj4tLhESLtCHqoA619OVk5QFsSh4nrN2sF3czmmETpZECvPdvgGUAgW+ybUlErojYZL30H2FpG3h7gPtA81ppqoL1aiALkG+yc+kld2V/NYHBLggT4I5QHPSt27M3mDisIrEIqRuExh/TWgpKU42uHphIlaTVKfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LvMTO5G/; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWThh/AYziDVFX6FIPwZIDhCooJlt7qmuXaGQUYqeOCt8sKs+n/adKVcjXbYqB54LdRxX6WYr+0Di8d44qZAOoNdJdbVlrNr3WdEtjEOwfhXVPKU3SsIOz6KfChAno+9NlWrDkNO/V9pxoZH9YKOXPl6V5peNE94BfCY4CXiHowLidI/fFWTZ1DxDuJ1aOoII045vc5nZrjlpti2bvi233Twedbj/pvqM3nnL1lhf8tKT7zJsSIzmMIK0P/ceGHnAYc3YM3uvlGOzfPZhY0td6LhkbvDXvBYwTR//sHYl+8k615uh7xbKF6vj0paD2n8APruxGdg6pLyNzejaN/vNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=cOtdm7AVIEAWwOgO4gb+K2i4B9td78Q0xBN6yIVqyplKZFXgS0SzhL2m0nMPo4L9wA3kSrQblMxKWhsvEJkLLrAYotshODg49g5HgcSXhaiANGdKubwYOqX6xRBaRpgwcUcpOcnzUGPU1yUjiUUMPpGnadY7T/2VfX1INOEFNa3Dk1Ts3BHHjdpKpKdXfak2PumVyUf9SWEeU6GBVSAmcTjtNyrPHhAB/wXEBKjd8gp/nBwsqoJ4LJqHaajiedsJ70TGELH95Hj73z/4nWKeg12+B7eRS2B7KFPPxvsPAhXHVCj68LS05fQ3DZvvsoMjLEYEsSSqq0a5UH/efNIl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RK8HcctKWrWGjHAxyN8k6xlAbP24zFsv0TFbZlW19A=;
 b=LvMTO5G/vq+G84KunIOt9dhCWlvhCf3GUs0jcFx7uCgP3sf4F6oTFl5y+jtQBtCXcgNT8XoYLkMt0eoj0+TscIUxYgevX6TnJ7wj18E8h+SAIXntI41wO3LEkny6Dx84XYBzhUxoVyvYzlvdPN9hgLJg5ouOlmy5ZrNfi+eqsAbTOVsPOylwGRJ4njs99ZtCC3Dk6lhgmhG9rkor4j31vcR69WsfTd/tSB9fMslQggts6GAXwUHxSN4BKPV/SLApKs9FlPgtWBn7odo7NXN7GktX9Ib48YOgQSx4jKiIdLdP3llSABBQuY2ZBflczDzc0yvso+oNyiPlho0Y03AJ3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 22:50:19 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:50:18 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alison Schofield <alison.schofield@intel.com>,
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
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH v7 20/20] device/dax: Properly refcount device dax pages when mapping
Date: Wed,  5 Feb 2025 09:48:17 +1100
Message-ID: <7d65e855fcdc5cee12b4500a557b2ad961bdc8f2.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0170.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e5be72-8531-4596-0876-08dd456e4c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lStfnsiSb+G8Iw91EnBGAJ0j2af9WK1uA3v+7TtIJTVBcQZ/D2NVAcMbCv++?=
 =?us-ascii?Q?ugeJX9KsrS7c5EhW2xHw26vrO3TVthtXSratgnjzkanfCNqVUK025wzgiQz3?=
 =?us-ascii?Q?A3V84KAoMHk+xNfj/LqvaDKS2r4mAAhu//ob16TlHHg60k0eEaUt1a9gxIrr?=
 =?us-ascii?Q?osNqqkT4qG3GVTBrXCFB5c7K/eJqYuJImcHhmXVa8cNYZxkKWoBpvJ72y7sh?=
 =?us-ascii?Q?HbcNuHwgJ0fObSyEDqwae++HpHQA4TGAlr9hiOPkDwH+mEqJfOYuhV9YSxky?=
 =?us-ascii?Q?2r0iw00w458ACvLnFDagvcrMUpmD3UbPxRVpGQXbSQcHScKyd3CY/e1XkuIP?=
 =?us-ascii?Q?eCDHxecCtQ/ks9I6tQtvswvEV3s2elVV9qHwNMex4zo9QuOeUuz7IKKFsm6w?=
 =?us-ascii?Q?4GJ6F7/5zpy8UzBgDxtNNWT1bkDIhCZzmsZ4FyaQCfLKpZR7mUWs0Ue6RxSZ?=
 =?us-ascii?Q?74SwSaY9VTrRvS3hgcmAr/1uUmKkXwfzvt2wf2rxq+t1pl0OjpIRxHqWU9bZ?=
 =?us-ascii?Q?TpSbU86nnm/jJnEl5GmuN1/9MA+j5EUaJMwVm3VhH8tooo4LcqKmb+ey6C9n?=
 =?us-ascii?Q?e3BHLTREkxw2Qgu9uWV30E/xva7btJpTk2sfTWswUqGEsbrXtsbNoxBrVdCA?=
 =?us-ascii?Q?3BSglWCkupdZjiC9X7NDJz6Yf4yKIErO1VkPeITEaZAHBQChjvh9yEX3mb1L?=
 =?us-ascii?Q?QuSfd9SLe41Fwp7aU4A54Wm62CNY9WJET1EtrVG71tmK7wH7JvR4HvQ8dOVW?=
 =?us-ascii?Q?SXLhdBdEn9FzsqWSGLL9ONLhlLQ7YT+nfZdKF9ABeZdfQAFu2IzLCBuDZiuo?=
 =?us-ascii?Q?FJq8C/r0n2JNlaDU+KZQGK6RRiZDY1tZDTG+2ZTWkcvsE03uRbOhQvnY7u+W?=
 =?us-ascii?Q?dbF4Abme7kbk99iurukxlV08Rc7qBBBXcASSiaWQ6D7JVpefkGFQvfuQ+013?=
 =?us-ascii?Q?p9iz4zxyo9zL2wmYObwPIujOD49Ivlr1ol94hc9bIRr0trxXJeiIP/PvN7bL?=
 =?us-ascii?Q?p0FvmxGZuMl9RBVF/cCvTnQOKXJptu/jIhLBqbyyxVgonuQk/DA97aELxGGI?=
 =?us-ascii?Q?HqkWNy6ic5OH9vhlxemWGumAdNtRX8jLg3TTJkqexhdfvmLa6L2qmKoxqxEn?=
 =?us-ascii?Q?Yar+uXRoynC6dn2s23oqxf30eA2ir4yhlRU2n80L9iaSsMufH43XEOdy53RP?=
 =?us-ascii?Q?Le8v3VPfsCAST1CmT+Od/XbPZjbfIg2NuCaTNdUG9JoyhrPdlO7XJB91U3uk?=
 =?us-ascii?Q?3Aqls7NPjyEU/ymtWT6peR41vd6ElLAKdlnbgh4EmsXpnUu7DnwHBhVJkuda?=
 =?us-ascii?Q?18QQkaq3R3Nas4Nf6B5ohAerWCM07SybHsPB0C4p3XMoel8ZSBju0GewOMkn?=
 =?us-ascii?Q?t/j0MRBDeal0qdqeKbouPVIDXkHV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dqlNYgNXTk57smO1jyS5MHtYJGZx4MWUa+uIY098ykSR6WSxpGrbM/QEBT6W?=
 =?us-ascii?Q?zAcMoOmE1msxN7b5YV5FDSDW6fipOjyeXQsuxCXB/197UBv+SZHXrBabfe7G?=
 =?us-ascii?Q?gbSAJ2uu02Vp54FX5j2AD5ckOWBRYCBJMhfGtoqyqJ8zM7HwwZf3TfCf4N8V?=
 =?us-ascii?Q?+CH8dOw2Mqeo1OAforoKisS5PD9lOF+duGRvVpfnb7aV+Q5RriNG2W1wwh2G?=
 =?us-ascii?Q?aba3mjL100GvAFQF+moAfWQBM8x8IH9gKAmU/h5qG/Da8XZA4eENKV2t3/X/?=
 =?us-ascii?Q?muYfvbHcC9lpVeQIjk8Ba52Oawg6o50Cp0CTYMdQdhw9JWWMOSvVjn6EXUUq?=
 =?us-ascii?Q?pSX4O6jLVOBrzIgk4ve+YUq1R2DwxmLYooS8gUnpOUbLHjn60UgxYOB80wJm?=
 =?us-ascii?Q?gxWqge1PEce6GCQnzjcpFPgPZ5xtGuBh4uaaHJ4NusvmJIPTd2fWAfbNnPVP?=
 =?us-ascii?Q?dGpjeyqYUdOB9SVU+zzXDu4XPBgBaPXYMOIBAM/gMza+buEZ7lxyXd/tsgnJ?=
 =?us-ascii?Q?fg/YtemhjiyFiLI6GJAkdi83pAFX5mHuGmpmxM5Aofb8PXDrGmcBMTuhwsm3?=
 =?us-ascii?Q?I1/DWcQ/WCbVV41WjehADyxa+vbQFD+iOse0tCYZ2Dz87dMXbg67vlueMjJZ?=
 =?us-ascii?Q?4mplP17Ku6BA48Q5Pec9fh+lR7WSemDwMsYNeOzb9ycjjPZzwcHHUWJBjbwW?=
 =?us-ascii?Q?t+b03BYPahqJobWJgOoBjF0EtCeTrnsguq4mJBjO7ZMX/y23qCxdN7D9Mzmb?=
 =?us-ascii?Q?D0YiNOonh9myo7Fu3//FqNMCfF4D4PPwAF7Gj6f8ap/pcNfovtAVaf+p4Cpp?=
 =?us-ascii?Q?6P+8wpJxlpokxWPJOR1u691yAtiEUWZJk3NsP/2XF/lOPn/hyADvcOja7miO?=
 =?us-ascii?Q?5cExyphdIIPqRB07n1dkMkA4ImvEv1KWYV752ncRXIQBSwckpLpcSejXmC+7?=
 =?us-ascii?Q?/tAO2yAwZcgEHBAQWNBQL8Djiyv/0/RUsXC4Abh48wmvJlmDufVmjTFuctsk?=
 =?us-ascii?Q?61sXaeEKsZ5NkkGd+4o5B6naMVOJovffi6SGfagA58Bb4bHpINSgsEWhg/fn?=
 =?us-ascii?Q?vERpyJEDiYSQUjvGe/YduUUDDi7g9X+jsS1vdWNJSJZ/lDpQGMA16/Fqcdhv?=
 =?us-ascii?Q?L9X+qCmByCMzxgp4snyXv6ob15RChy8QeJvfMmR9g8z5tosDAgKqFNHUdVcO?=
 =?us-ascii?Q?19BFO2Fyh0GlfO7qFcmAccGWHPbDYWtCzS/IrBxQGOXI3GxVgZc54YaL8VgR?=
 =?us-ascii?Q?FR3Yc1fEylRquqnvOiH7HDBo2f43ZeR8cYPj4YIYpyzmfUBLKxrtorvS5anA?=
 =?us-ascii?Q?cRAa3nwUFPtJron59PR5xe0ysxireBcN5nlUXWNHTrsCH2CW/oOho/WXbOpB?=
 =?us-ascii?Q?yvvi5ojZUlAUEBuxwCfx8bvNThviWbDkkSQ7tbWM/vvSWPy5Rwlxm1NTXaRY?=
 =?us-ascii?Q?QxI4kwu+DoogCX0GQj0Tn6OAWEL3gZTMEGmw7gHxUIHVOTSb3E+UMTJipaeK?=
 =?us-ascii?Q?iD9ZOH1kKU+KROYCMZNhapfSTgN3+Yv6FQj2TkpJjYITEPcdEdgDmA1/P1SN?=
 =?us-ascii?Q?H1XAE7QqLRglOWPBCoH/J50efrKNIydiMTLoJRpE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e5be72-8531-4596-0876-08dd456e4c34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:50:18.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSYMUkxbdq+ITdx/qthVTTj0IyujhXGyQAhbbbOtPDbjrjJZccO92ORw58EUaiF+1yq6tGysIw4gp/XEzM3MAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

Device DAX pages are currently not reference counted when mapped,
instead relying on the devmap PTE bit to ensure mapping code will not
get/put references. This requires special handling in various page
table walkers, particularly GUP, to manage references on the
underlying pgmap to ensure the pages remain valid.

However there is no reason these pages can't be refcounted properly at
map time. Doning so eliminates the need for the devmap PTE bit,
freeing up a precious PTE bit. It also simplifies GUP as it no longer
needs to manage the special pgmap references and can instead just
treat the pages normally as defined by vm_normal_page().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/dax/device.c | 15 +++++++++------
 mm/memremap.c        | 13 ++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 6d74e62..fd22dbf 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -126,11 +126,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
+					vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
@@ -169,11 +170,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -214,11 +216,12 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_SIGBUS;
 	}
 
-	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
+	pfn = phys_to_pfn_t(phys, 0);
 
 	dax_set_mapping(vmf, pfn, fault_size);
 
-	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
+	return vmf_insert_folio_pud(vmf, page_folio(pfn_t_to_page(pfn)),
+				vmf->flags & FAULT_FLAG_WRITE);
 }
 #else
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
diff --git a/mm/memremap.c b/mm/memremap.c
index 9a8879b..532a52a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
 {
 	struct dev_pagemap *pgmap = folio->pgmap;
 
-	if (WARN_ON_ONCE(!pgmap->ops))
-		return;
-
-	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
-			 !pgmap->ops->page_free))
+	if (WARN_ON_ONCE((!pgmap->ops &&
+			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
+			 (pgmap->ops && !pgmap->ops->page_free &&
+			  pgmap->type != MEMORY_DEVICE_FS_DAX)))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
 	 * zero which indicating the page has been removed from the file
 	 * system mapping.
 	 */
-	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
+	    pgmap->type != MEMORY_DEVICE_GENERIC)
 		folio->mapping = NULL;
 
 	switch (pgmap->type) {
@@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
-		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
-- 
git-series 0.9.1


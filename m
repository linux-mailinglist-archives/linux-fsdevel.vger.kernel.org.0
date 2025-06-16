Return-Path: <linux-fsdevel+bounces-51730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2BADAF59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5D7164636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890352EB5D2;
	Mon, 16 Jun 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgycRbdk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E532E889E;
	Mon, 16 Jun 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075122; cv=fail; b=mMbcuI0Sn13CXA0UpBfTI1jQyfl3ciUqMBCMqb1rS2/llvXusfkGFAxDPSsUb1/4EcTVzL6b6DJ2aTrZlPaJLjJ393qThEJ81iDUEmyewkrGLduTKudplSF2qw99CBtYCnxWwsVoGkBsma/c7HYLIC0vqH0FloERkxdt158DyRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075122; c=relaxed/simple;
	bh=OLaBRtPsH/ifUTlybZkQcb45j00990nWKqt56YUoDbo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Iof/vlM2qAXLl2W/4nveN3U4PbfKRGMF/NOGwhK0HM7UQmiMrWsmRQeCRpY8gFjYLSL4rzPSdZ4SO//mrd4h0GaxdD19u1cxKUr4vZT9GHthqpWLDmLcAyS4aParauQH02N4b0IO+EDPaYxvOKTX0FFuI03XD9yK7T3f+gt1WUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgycRbdk; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7SXn7IJpfnrVzSgMjLVWv9QOTOhTXdqCx6Q81zcdTLuSPSio9dBEez32QS6NjT7erqDu9yCxZlbRwnT8ZFvDlab9inojFI5Wqr3ZVh8GAeyySIyf8FMnu5l7bt3dgEwgHYdnWigGR7sn6QwqIq6XxvWPtV2BAdVQavkf6G2wDc0+z4CEblwdWd7F9wPjJjtqoajd+6c4j16o3b99bkIkSBZYfrl81YKkoUTHA/pPrVZol/AA87k5E+WAfutfbRk/sJvIR+ygjpbU5hraYpVJA6eFmTAZv/ZQ47ZfJ6XYj+E48TrqFZwJt8I/TRCr2tKZPzRm51plFlEt7bYnpUHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqbnzGSPBqnBdBqRFmWvpsOX003YggjUXUdTI0QVQb8=;
 b=dOZutVGS7NjJco1I9ke4zIOV+C2pKGdx7zGNGKMgfboo88IWC+M3G/zE12cWfMDPlQ6BEcsZHJ/yDwdlJmCMycIr5KzyKBk+ldVb6/Mb+4hEtaVb1jGQ1Y7CNRgIcukuP2BMZtBbnYUgIK28IaeQqP0PtU8UexwEAVCQYmyGQLUVKolB1OP2tc/JoPTuODzsNYP49HUVD1rZl2NBLUBhkt/hCq4xjsVmZaAJAQYBSDswMHG+wbrbb7KrUlaXTUvFft94bDq8CllPA6ayPW47nrWuerT+HQbIMJ9BV376EhXxbk24+6hg0IiTm7YxCFlCTSrOPtacpbQcOyDdCr5k0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqbnzGSPBqnBdBqRFmWvpsOX003YggjUXUdTI0QVQb8=;
 b=AgycRbdkLhrZ59/vzHjIBwNlXquiC2ufgTvFIwmyHFgf7FddcHtEfyJUAm5Xz0c4J+/JC/myDnl2mT0eX6E7TktJsLy59b+BFtYQRB7xDuBo4YPDk4Xd3L8goi7kGaGoAEvY2k9cJ4o6f1FaU3tdzuiqrasBrVHF9rUQAN49o//Nf9eeNZ9TUJQ+co9wZhzIVBXiUE9zlzwcePRjCb2R284HwmIywbPAptoPsCeRobabiUan/XicVBecaVoLeU8PZ34GTa1sxucHYQhEqygfrTBKFbmvp3o08ZqOffVVWlfWm729mesH3U52AbxLim8A4s3k97SqChTqVhg4cgldmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:58:35 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%5]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 11:58:35 +0000
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
	m.szyprowski@samsung.com
Subject: [PATCH v2 00/14] mm: Remove pXX_devmap page table bit and pfn_t type
Date: Mon, 16 Jun 2025 21:58:02 +1000
Message-ID: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0114.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::14) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 138796da-d67b-40be-07b1-08ddaccd1ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbszUMfVh2zUjdkNO1f5OEuHP5XbO9zM7wMxGW6tGoKbWdsznDxGXpx89L1J?=
 =?us-ascii?Q?5vYBU9w1NX88EDjg6PEl8jNpEqiKrkYnRgOZWvuKkV6AC+q0VE3i+2rYWfiC?=
 =?us-ascii?Q?b7Dfdqala5dFmBJYE9acEPtHtG/hgdSwUegNqPNEYDKfGqbmeKWsQ+DAODdy?=
 =?us-ascii?Q?3D3KRsH1De0RNKasY91BNjPLFTbscmEDi36pIeaXTn2aBzp9sPUf3632oE2D?=
 =?us-ascii?Q?L5YB/WSTzRuLu3RymfIx3l7vRJ1hasJGKg1a0Xqwr+lz9qV504z6CrqeqnGj?=
 =?us-ascii?Q?8lq/M2EiME8Q2W8ihwcUAJo4NSllEGYYvNWJLK3ZrufbHloIeW69TrTWqYpL?=
 =?us-ascii?Q?pFYnhhbr9zooLJSrP0xqdcjeLsd48OGnEAqF7o4/Ibl6jsKjF1hWlgU9qEwF?=
 =?us-ascii?Q?mGYT3rdLlfDWG9lrB7s4ogtCDB/ECJV2c4oVr4xsBVccpP6LXGqTu/ZmGPg8?=
 =?us-ascii?Q?2pUpsmUj7dC+M2+H7G0e0RKOyQjnRmkf1vZCcFmVo1SIs2E3qmq3LdoVmbz+?=
 =?us-ascii?Q?uGPkehL2z64CnNSm2vxLZ47s4lOjrPa63cPKOiubEs/w+8C8xqSTgrHsyLuP?=
 =?us-ascii?Q?ij4dyfjr0ZJYpcbfrC0rk2X8iY2XoHDy3D1fOdeAG8dRSCTfNf3MzDzcruVD?=
 =?us-ascii?Q?/Jek2/FMlHJhQN5sNDsizmoJRP1BeGNbkwmqtfttZJ001iGaHLTUs2am0k8+?=
 =?us-ascii?Q?CyzZg4MSXfFUNlfiM+7cCYsUfDfaGqcYkl5sXht/zp5WHyshbzB1E9cEb5tG?=
 =?us-ascii?Q?dHDTOqmokPtKq6Ym/NTV6m6RhAaEpau1UnUww0U6LzKGTEIzWASuBI3t9y0d?=
 =?us-ascii?Q?aAcL1GCFGlIuAriJZv1wQd0MGpxnQK/CejJkZ+SXeRYHkX0j68A4A/logag5?=
 =?us-ascii?Q?hKfbRbEbPLKhNUTZyREK2lS5/2mZOt7jM1+z2DcPO+Jq6mtssBDs0h6UD1AN?=
 =?us-ascii?Q?QCXBs/M2IzBVVlDtuDH2RPwbe7i7ji8Zu7L6q5OXo+ovxzCLENmQwnPJkaaO?=
 =?us-ascii?Q?2nRiNbYWK8kVlX+qk8u2Cw/Dr5vGeFGA3rdKCpnIMArdx/je+tlcTRzTHTVd?=
 =?us-ascii?Q?DNf8oZkZiriO1p7XN3Us/Nb2VfCOrTTAu7EWvpKKaxk1EYKEIEvfnC3krppU?=
 =?us-ascii?Q?UBIiD4vYiTpwWfvb4gNt96OLate6YbRPXEeHe9cyjcoHQvUQOyFwK+nKaEDa?=
 =?us-ascii?Q?PmhodyUS5lfF1WmUHQG7Vf/DvFaBPVB/dvIDzgas9NrL2qkMYZfUXidlLCuS?=
 =?us-ascii?Q?dmZC7QEbmSHMlAFSRUvoUW0f70CnzB5wcVZPMq37Flj1WReyw8H00Y7osIWk?=
 =?us-ascii?Q?4iuJbFvaiZh174ErHDAyOgIHmpEqO1K1a0p4TTRgvpfudFiVytCtUqj2spqh?=
 =?us-ascii?Q?FLZYmgqaXO5LfaWflEuAetxut5g4Ov1auo1/ZbjhptgyT/czjHd89mmUmeJX?=
 =?us-ascii?Q?cJQWasMqOqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NR5rcX8HTdelTKAlBEZdRQwameb0h4EJIdDMNWPl4iMzhF2127ycDMDHv2jt?=
 =?us-ascii?Q?usiUPev8BaMRXBhb7Xx13lhNy8U7j6W/rNf3VmdVZHVsnDn/hHoTIXmyWX0O?=
 =?us-ascii?Q?xn6HAugpj5uo6M6iYYtUPuriy7YPlRdnHlOJ5kS8eJHwtb6E0LupLPo5DTLW?=
 =?us-ascii?Q?HkJHm7q9L2lUHqLryUlT3ru59xujBu3YbNrZFtsWNGdGq39Y/ROrle387cTH?=
 =?us-ascii?Q?Gq8aEMerjYnLcjHNlPEdXzqZ7YjT/59o2ZcZ0p8qGcY1ohidJWni4Q/tOr5k?=
 =?us-ascii?Q?6dU8heiVw5BB2IA4ais8eRP63bbxpyTOdxO0lce6WDGIZXn0IHvVEmOrL5FK?=
 =?us-ascii?Q?rJWljOWg3Gc5c2xHk1fnY32otmJtXLISDYX7eDpdhijQPSxQvSj4v+Dh6+Dp?=
 =?us-ascii?Q?9EeGQTktdPMiwAXlUNMc2OtQe6T/D22W46/W8gp7+Fh8M8s/gs3AnweALgt3?=
 =?us-ascii?Q?g9ytayAN5LIS53f6MPkQVmBCeIa64JHqasSMioFdwTKh2TeidLkx+O1UFwJs?=
 =?us-ascii?Q?RxyMls20QH6y6CrUQ63QwjKek8woYqqw2fnRQC6Q6B4o+xbHKBjTyiAs+F/N?=
 =?us-ascii?Q?RbKJA13KLSjOh6+5O6GVCP3rpLdMgSc+xh33uqVMYDcTo/oQFXfQiz+Nr0RU?=
 =?us-ascii?Q?6YXpYYCTnFWDmn2iQqtJmTmwXTmqdeCEoFcs3nCDbIlrGhqAOYHDfQnVZIWH?=
 =?us-ascii?Q?n3TXD+mGPKbdbsj4UK+27XbrqY+krnP2E1jKqMobqLc4/dc9yPSkPi0q6YDl?=
 =?us-ascii?Q?qLF+1Y2hcD9vbZJiPH14K0gj+Is1KXD+TFBy22cIplrSV7mlXbJCDr1Qiya4?=
 =?us-ascii?Q?gVnn1YxaFnUs6rigz3i6dCDR70zCtaZm27boR1KEXtdpUJd00dNjEcr9JJk7?=
 =?us-ascii?Q?03LgwVZzBwVK+otfDPNVrARJwek7Z3sDTwwRIpFTuSmy2Wy+wE822ff3upfX?=
 =?us-ascii?Q?xn7cI4s9+WCm4xkKZVYo+iAAlnR90slkYTNmRftDjW1P6dzW3rN0qXjVuhvp?=
 =?us-ascii?Q?GDlRLpoGcRUKWcgWcOkyLmTwjeTQr9cKQw9PMSoFPkSC6viwE7Nhkx/1U4FY?=
 =?us-ascii?Q?ZTVZckRSU4xf4/Y0k3JzakEVD580M9NnG3hyUjRK31FBAdLOYa4t7KthzI/n?=
 =?us-ascii?Q?HrEevULRjgRMPFizSiVnFolinULvUUcqlfxtZs1mWYgBLhZIN/oTbsW4rEn4?=
 =?us-ascii?Q?UTFRAOwn8fucYAoEWZll3vHxFnPBs/BBveeSD39bdepSue3tDhEH+YIBrB8j?=
 =?us-ascii?Q?3LQW2ZCPqy966Qi5E/uYa6XxsM0T3BwDxNSTsO6OKLOAsNYnt1MKSAc/zJHb?=
 =?us-ascii?Q?nPPY5a4N52wBmkiA1elZ7Wv38SNLaX1waz5hzyPSOs8hprvI2b1JpLjlEcwe?=
 =?us-ascii?Q?7fjfS8hHYKVboSj/M6mSXHXUBlZWdSdruCIlvuI8J5xfQp+ljkdGo1nHW6HD?=
 =?us-ascii?Q?srF1lXXzf13tjHDdB6oyC2Ne/jRedY1VZENN4kU4VqsOPos+6BucZGvK0msM?=
 =?us-ascii?Q?wRZohxdZldkHCkyZc3IT9163c/ooxNWQMytTxZ1wm7UDX3g7NN5V7EPTOpSQ?=
 =?us-ascii?Q?smYpWrEq+Q9dQoAAi6lzZoEnNrYZrvpQU4SQ78ol?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138796da-d67b-40be-07b1-08ddaccd1ee6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:58:34.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXhyk12b7/j4saQibhIZZW8nDnzB3e5Q7fnG8UcjjK4Iu1pvvuq5oNwy2HGinJOPgnXJzjSdi4aQknoU2wtxiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517

Changes from v1:

 - Moved "mm: Remove PFN_MAP, PFN_SPECIAL, PFN_SG_CHAIN and PFN_SG_LAST" later
   in the series to avoid creating a temporary boot issue on RISC-V as reported
   by Marek[1].

 - Rebased on mm-unstable which includes David's insert_pXd() fixes

 - Stop skipping DAX folios in folio_walk_start(). Instead callers not expecting
   ZONE_DEVICE pages should filter these out, as most already do.

Changes from v2 of the RFC[2]:

 - My ZONE_DEVICE refcount series has been merged as commit 7851bf649d42 (Patch series
   "fs/dax: Fix ZONE_DEVICE page reference counts", v9.) which is included in
   v6.15 so have rebased on top of that.

 - No major changes required for the rebase other than fixing up a new user of
   the pfn_t type (intel_th).

 - As a reminder the main benefit of this series is it frees up a PTE bit
   (pte_devmap).

 - This may be a bit late to consider for inclusion in v6.16 unless it can get
   some more reviews before the merge window closes. I don't think missing v6.16
   is a huge issue though.

 - This passed xfstests for a XFS filesystem with DAX enabled on my system and
   as many of the ndctl tests that pass on my system without it.

Changes for v2:

 - This is an update to my previous RFC[3] removing just pfn_t rebased
   on today's mm-unstable which includes my ZONE_DEVICE refcounting
   clean-up.

 - The removal of the devmap PTE bit and associated infrastructure was
   dropped from that series so I have rolled it into this series.

 - Logically this series makes sense to me, but the dropping of devmap
   is wide ranging and touches some areas I'm less familiar with so
   would definitely appreciate any review comments there.

[1] - https://lore.kernel.org/linux-mm/957c0d9d-2c37-4d5f-a8b8-8bf90cd0aedb@samsung.com/
[2] - https://lore.kernel.org/linux-mm/cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com/
[3] - https://lore.kernel.org/linux-mm/cover.a7cdeffaaa366a10c65e2e7544285059cc5d55a4.1736299058.git-series.apopple@nvidia.com/

All users of dax now require a ZONE_DEVICE page which is properly
refcounted. This means there is no longer any need for the PFN_DEV, PFN_MAP
and PFN_SPECIAL flags. Furthermore the PFN_SG_CHAIN and PFN_SG_LAST flags
never appear to have been used. It is therefore possible to remove the
pfn_t type and replace any usage with raw pfns.

The remaining users of PFN_DEV have simply passed this to
vmf_insert_mixed() to create pte_devmap() mappings. It is unclear why this
was the case but presumably to ensure vm_normal_page() does not return
these pages. These users can be trivially converted to raw pfns and
creating a pXX_special() mapping to ensure vm_normal_page() still doesn't
return these pages.

Now that there are no users of PFN_DEV we can remove the devmap page table
bit and all associated functions and macros, freeing up a software page
table bit.

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
Cc: zhang.lyra@gmail.com
Cc: debug@rivosinc.com
Cc: bjorn@kernel.org
Cc: balbirs@nvidia.com
Cc: lorenzo.stoakes@oracle.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: loongarch@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: John@Groves.net
Cc: m.szyprowski@samsung.com

Alistair Popple (14):
  mm: Convert pXd_devmap checks to vma_is_dax
  mm: Filter zone device pages returned from folio_walk_start()
  mm: Convert vmf_insert_mixed() from using pte_devmap to pte_special
  mm: Remove remaining uses of PFN_DEV
  mm/gup: Remove pXX_devmap usage from get_user_pages()
  mm/huge_memory: Remove pXd_devmap usage from insert_pXd_pfn()
  mm: Remove redundant pXd_devmap calls
  mm/khugepaged: Remove redundant pmd_devmap() check
  powerpc: Remove checks for devmap pages and PMDs/PUDs
  fs/dax: Remove FS_DAX_LIMITED config option
  mm: Remove devmap related functions and page table bits
  mm: Remove PFN_MAP, PFN_SPECIAL, PFN_SG_CHAIN and PFN_SG_LAST
  mm: Remove callers of pfn_t functionality
  mm/memremap: Remove unused devmap_managed_key

 Documentation/mm/arch_pgtable_helpers.rst     |   6 +-
 arch/arm64/Kconfig                            |   1 +-
 arch/arm64/include/asm/pgtable-prot.h         |   1 +-
 arch/arm64/include/asm/pgtable.h              |  24 +---
 arch/loongarch/Kconfig                        |   1 +-
 arch/loongarch/include/asm/pgtable-bits.h     |   6 +-
 arch/loongarch/include/asm/pgtable.h          |  19 +--
 arch/powerpc/Kconfig                          |   1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  53 +------
 arch/powerpc/include/asm/book3s/64/radix.h    |  14 +--
 arch/powerpc/mm/book3s64/hash_hugepage.c      |   2 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |   3 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c        |   2 +-
 arch/powerpc/mm/book3s64/pgtable.c            |  10 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   5 +-
 arch/powerpc/mm/pgtable.c                     |   2 +-
 arch/riscv/Kconfig                            |   1 +-
 arch/riscv/include/asm/pgtable-64.h           |  16 +--
 arch/riscv/include/asm/pgtable-bits.h         |   1 +-
 arch/riscv/include/asm/pgtable.h              |  17 +--
 arch/s390/kernel/uv.c                         |   2 +-
 arch/s390/mm/fault.c                          |   2 +-
 arch/x86/Kconfig                              |   1 +-
 arch/x86/include/asm/pgtable.h                |  51 +------
 arch/x86/include/asm/pgtable_types.h          |   5 +-
 arch/x86/mm/pat/memtype.c                     |   1 +-
 drivers/dax/device.c                          |  23 +--
 drivers/dax/hmem/hmem.c                       |   1 +-
 drivers/dax/kmem.c                            |   1 +-
 drivers/dax/pmem.c                            |   1 +-
 drivers/dax/super.c                           |   3 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c       |   1 +-
 drivers/gpu/drm/gma500/fbdev.c                |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c      |   1 +-
 drivers/gpu/drm/msm/msm_gem.c                 |   1 +-
 drivers/gpu/drm/omapdrm/omap_gem.c            |   7 +-
 drivers/gpu/drm/v3d/v3d_bo.c                  |   1 +-
 drivers/hwtracing/intel_th/msu.c              |   3 +-
 drivers/md/dm-linear.c                        |   2 +-
 drivers/md/dm-log-writes.c                    |   2 +-
 drivers/md/dm-stripe.c                        |   2 +-
 drivers/md/dm-target.c                        |   2 +-
 drivers/md/dm-writecache.c                    |  11 +-
 drivers/md/dm.c                               |   2 +-
 drivers/nvdimm/pmem.c                         |   8 +-
 drivers/nvdimm/pmem.h                         |   4 +-
 drivers/s390/block/dcssblk.c                  |  10 +-
 drivers/vfio/pci/vfio_pci_core.c              |   7 +-
 fs/Kconfig                                    |   9 +-
 fs/cramfs/inode.c                             |   5 +-
 fs/dax.c                                      |  67 +++-----
 fs/ext4/file.c                                |   2 +-
 fs/fuse/dax.c                                 |   3 +-
 fs/fuse/virtio_fs.c                           |   5 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_file.c                             |   2 +-
 include/linux/dax.h                           |   9 +-
 include/linux/device-mapper.h                 |   2 +-
 include/linux/huge_mm.h                       |  19 +--
 include/linux/mm.h                            |  11 +-
 include/linux/pfn.h                           |   9 +-
 include/linux/pfn_t.h                         | 131 +----------------
 include/linux/pgtable.h                       |  21 +--
 kernel/events/uprobes.c                       |   2 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  60 +-------
 mm/gup.c                                      | 160 +-------------------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              |  96 ++---------
 mm/khugepaged.c                               |   2 +-
 mm/madvise.c                                  |   8 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory.c                                   |  64 ++------
 mm/memremap.c                                 |  32 +----
 mm/migrate.c                                  |   1 +-
 mm/migrate_device.c                           |   2 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   9 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pagewalk.c                                 |   8 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/userfaultfd.c                              |  10 +-
 mm/vmscan.c                                   |   5 +-
 tools/testing/nvdimm/pmem-dax.c               |   6 +-
 tools/testing/nvdimm/test/iomap.c             |  11 +-
 tools/testing/nvdimm/test/nfit_test.h         |   1 +-
 88 files changed, 191 insertions(+), 973 deletions(-)
 delete mode 100644 include/linux/pfn_t.h

base-commit: f97971f859dd7d22e63982a493aec85d9e75a69e
-- 
git-series 0.9.1


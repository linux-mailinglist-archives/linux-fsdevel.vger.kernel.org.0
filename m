Return-Path: <linux-fsdevel+bounces-38533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A58A03662
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BB2164557
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418AA1EE7A7;
	Tue,  7 Jan 2025 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dXbdJphK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725F1DE3C3;
	Tue,  7 Jan 2025 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221456; cv=fail; b=JaTMclcGUjVzDtYiimAP5Si52OFIUPv5vdMM/EriT0WwUzq41PuR+G80gPMCpRbQdux5XlKD1H8H4m6gtZSJi14pNnHJ8WxQqMygGVgCqk7gMg5QY0fSaqQ2CRC1w1qupX6KtFc1wVWkGlvQgTysXMC8NEhqk5pPZWbjKQF9fZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221456; c=relaxed/simple;
	bh=Eb4++dzVGBX++x7UI5B4YO63IMX+GDOv1mzqTzz9SFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECkcsQ4g3cmQXYqr6AWdMhoAEhbmoBJLvJ49N+9ZsZIO33hA83j7lBHoOlE8rc+88O/cSyduwX1m7kYtlJTU6MFIUD5gSXNGhZB3QIGLJK3U0v70WlJONyCNdNIH5dfHuikYmEnwXAmk6dQalWRo4MM4PB5/vqeNi/O3opI5+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dXbdJphK; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR9SFR1/u9cXwufZFpeCAkC/Mh2nEsdyGYjp81MNeXjafDf1yilye6/n5pAr1ocUOIeV/STFNDYYaUoVOi1b/brGVyNjZjWb86CRjAnfVt2O7bgl4Oz/4E6HhGUdp731fjwHqt2jOpDl++PzRCBCu1ukjwiyhSZEfw/Lio2nYV9/YBDvEDdz3Ylkzw+/VO6XBW00lT9mSw20EuyAITSj94Z9AeN/QIsM/cdCrATzKWtw0IOGvdj5aCpTCng9PmBRBgFDyxYa/Kb9REA7URCf/JVI1Tw6vjLvuF8uVgRQWfsHc6D9NiGxmcPwFm8QkaQRWYASTgjMMHbTd/xGrzPAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miyeTk6w4XfK5EXlqkgC8EsgLiWGGXnJqzdHvLWNlD4=;
 b=DfjpCbR4guW4Rxxtok935HbMekDrNU0IqYUL/uYD+lWZV4k/DDvs5SUyRZ9nKk8Bp/yHC7fv/CmZz8Fy5Vu7v22apNyE7ERjrsTzcXby6QfuLVVv2VgK08shr8xS92OtWgFDcwcBmmaoKYhDNn3kwT0Xx4zPvqG47VDw9i/LFZWLAOzkGl1QZqSyllMElWh92Y+QTNdwCNrtCm1m+JhCp6Pr+LnuBNZXz968vdPCK+aGIoDQcHhPiLjkcG0pY9vUJg6evPNMxBY887cZozAQYG1Y2Gx5FxbTKPMcMwOzef6u6PPiT1mtBtrlqXjVqSodTVhWntT8ILGmAHY7oqmQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miyeTk6w4XfK5EXlqkgC8EsgLiWGGXnJqzdHvLWNlD4=;
 b=dXbdJphKeEbggYgD/bB2F2ObVo41TJctGUbRwoqZogahv/+XD8YukqkPt7hp/P6qSd6HBrvDpaOGxEoZIYCT3f04XJltSxpMJV6+oeZRbvQehK5TBNw+tbrwUJoWx0D5GbGMX7Vlzh01NsI8/QqCCTw7Uy+ynrnK/aLmbJYe/0TYE6P8xno6ha6pNTa17czCj/+VgC9DwlFpX7dLLVFh5uli0yzSMiax4ABL7zYGPTkSkZgrABPOl7pe52qyQN36MwNScrsWxSIfEpqOUD/Q0aSSZ/7LDWyqHpaM4z2sp6gDomFsI99MQOK+sSdwXMC56vK+/+GfUb2yzg9S93xzMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:44:06 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:44:06 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
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
	david@fromorbit.com
Subject: [PATCH v5 15/25] huge_memory: Add vmf_insert_folio_pud()
Date: Tue,  7 Jan 2025 14:42:31 +1100
Message-ID: <5729b98a4f8edfec80edffddc36cac6dbaa8f4b9.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0095.ausprd01.prod.outlook.com
 (2603:10c6:10:207::20) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0938f560-14e0-4a11-0b3a-08dd2ecd88e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2thv0cHSoxs05yguxA9pjghf04j9Rb+KmctOAiXEVcls/NmDr3cieLYbBZLh?=
 =?us-ascii?Q?GvDyL8u7CaxLfwssqKHOwyCUxH0TH/vvxKcn7wgY8nHkSBTIAg3IbVfXL97x?=
 =?us-ascii?Q?HBFarLZka2ZeAL5ubUjmM51XzbsxaqGU39C7pP/lJLkqrMMTqsgOlzmpPutI?=
 =?us-ascii?Q?u6TKMDwwOjLhCKP+Q9Mgx3ignAy+ZDeu/efMzVpxmp2fPskJWorQi/UrqT3f?=
 =?us-ascii?Q?KBCBN+/ruqbcmQg+1hL1UNsBqzS0vxXmsqnG4G36lynGkKtd0hwZER9Xwmw7?=
 =?us-ascii?Q?yqXGSMZj5T5JpBXiHjog4fGgw4xETeaTFEjPu7CuvsS2fjfqfiEWzPNxc5BE?=
 =?us-ascii?Q?BCW42Sajyyhvo2h6sD0L/x+yG+utrLl2CPfcpRaIStMENRYzOYxuUImZZEzM?=
 =?us-ascii?Q?3wtOdw9a+i0Fw38vZgi6Og/qsya8LKQ9caiPXxT09Sgje8c3w0G3cmH5EDET?=
 =?us-ascii?Q?xvzAXRZVa1iRvH0RxTqp+s2wuhOEnlopFH7wPShr7s8Fy5nasNGvUhAVpq/6?=
 =?us-ascii?Q?Hj4m2DIcl79d78+mNDS6owNdWclZ2z+04NOfyPZitlJVn3q6ACVPrY3kQ7nd?=
 =?us-ascii?Q?A/Cm/ErUyZjPiBSh3cX3gCZI3wcNTnxomL8Dkpuw/J8zEgFcbdhETYPROOm4?=
 =?us-ascii?Q?8SgSxphwQObr4PQuMPbhlJpVVtidNvTAucVEva5K/fGdWjuqX7OIh+Ul9gNv?=
 =?us-ascii?Q?AM9Aj/VB54DbiaiUQjn5WKzqAUMMReDqAHCtI13sqLYnkFmxarEls7XqRoAl?=
 =?us-ascii?Q?L/PKrzbFK7nToTMjBEXoQU8I8jL+w2IdFcEuYstrpf0wjydwGgoElFYSBvMr?=
 =?us-ascii?Q?+aR1tFLkIzxN5B82m3PwVgD1hdBJ63V6NchX5VT2vWqm50fbuBMLdqA3AMmU?=
 =?us-ascii?Q?DOzTEfqhhNrv0psZvdX5x2gN2TJcXNMOnRUUwo9tH3x3p8i8aSdAAvTiM3Ee?=
 =?us-ascii?Q?bt7CtDDidFt4O33USLPvwlroiCpvPR5Ow8InLmrhC9qZU6txGOpPDyG5UKLi?=
 =?us-ascii?Q?/lLaHta7qqpXeE8boTXPoZC/mjAkI7sda0cWFko2PZ8hTCMnybSO+urW6ZoE?=
 =?us-ascii?Q?fkIMeUaNFqwC3Wk/3dNnU/COlCOzFxoGkvyQdU7HTKR+9y5vIwRlYe4kTfI/?=
 =?us-ascii?Q?MOyRUA2nS2HiC8G6XUaNZ/J9A/2XIG7VwAjn4EDrJnAYna3+hJL+O22cYacR?=
 =?us-ascii?Q?a6j3Ny4LoYvp6sNj0RRBAB9/7aC36f5+vofmpe0usoO22OTiXKwGQiRXln+x?=
 =?us-ascii?Q?ARjiObXf32SmUfXuG0tXPfLP/gf/tEqRPQjRcYjcALU4Xq2huJAwH65gAt3t?=
 =?us-ascii?Q?2RPZsbBeK3ge1ZuDO4CxCvm/kKs8UUNnTrPdXBJJnA0TKQRpIbfJGEjgsjUi?=
 =?us-ascii?Q?4mo5/12Av5BC/j8iNnjjdB6MSudb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1h3nWdGRGb3XRDsGq4j2l1moW4gtCJrow8MFlHx2/RVeGkU5SeTmIJi9Q5e?=
 =?us-ascii?Q?rCnRVtt4kjpDKld3s6eAN758wouz+rff98zSAca0oNjoHvlqeyx/tZi3ixq2?=
 =?us-ascii?Q?sBgeiCCeZfrrlWlSmBZK+dE0xeOH6PKTw5mEis/QSJaB0WDvWaqOPJHF08KK?=
 =?us-ascii?Q?QLTVA/lT0n/yaI8vn5eqKk0hI9/CH3q9y69KxhJF93MZht4jADZjycjbuG2h?=
 =?us-ascii?Q?c3b0WHGlDiZcfQwl0yUM1mF33x4Z9IPYRQmWI+pv8SDVJosR/k+EwZh0DLKM?=
 =?us-ascii?Q?G03SrsJXyaHtpT+hzE7FW7Mq0dmkNx/r/zKz0yRg3VesNVKmb16rJL28eJkp?=
 =?us-ascii?Q?aHRnpHRZzsMFqTZX+j0zHd9sxg3/CYfFgYvBuk69SGNrvEgCNXnKtizUotsC?=
 =?us-ascii?Q?Nf31EixxJPEb5XY/kXeIPUBVPXfuhWcQPa78xbdeUE/638PJgbuyb7KH9eMk?=
 =?us-ascii?Q?/eTpKZNb00CIAqZ0Dc7w1dru0RdrQl3t2H4xgGhJb59V00D3CeP3b6atPBlm?=
 =?us-ascii?Q?fLQyfumtmt2S7nNDu9OsytBUqImgEckKHHh46fQo/HWvKtWIV4BvaxMu7xFz?=
 =?us-ascii?Q?Ymo2PlTDbIdwPe0T1jiLvrFQhConMRODWlZksWaflPRuTpVj+dyM4lU7wQ0H?=
 =?us-ascii?Q?a6peThUd/RteK+iCCBy/pqv3hJjpnu0LCQR+EjaDumBJdXbhLBpAS3cIumUd?=
 =?us-ascii?Q?uZd7MBWaT/BIGjbc10Oc/zgDmr4bKCYQ7S+cMdYGnXAFYvmECNUqLHgKUqiE?=
 =?us-ascii?Q?UeZ7ocDmHS7DDefMjBK1oWHHJ0GutMmqWMNi9873lMK/hjZt25ttrGwcwk0o?=
 =?us-ascii?Q?eWdZ7ciTP/l2PhlCrMj5CFchDnnAXjw0znOgfm0zzScGZ5yim9RCcz957SoX?=
 =?us-ascii?Q?Kx3kxrWIeSCA3LSOqm1qf9lmphG9DuxvEqOaDQrtyz86xLto3NADZvFqg966?=
 =?us-ascii?Q?ay63M7Bv5lX1Yv49koh9C5cfc26q47VJ0q6M1CiylWBTbBYXuwQMQJlOJR42?=
 =?us-ascii?Q?nuz3IOrItiSRQ2yaqKUBx562VSMS0FkgWVPy8WDRk3M+4SHqp8Ny6ICCdLN/?=
 =?us-ascii?Q?fvBLal/TpxTozXJtCDMaMRgxSBSqQ5aUVlRsX56TVFa43B0Fr4pBj65nfnZI?=
 =?us-ascii?Q?79qdIQbHWFaKFflKN0vh02ODhsJ/z3Mi72Fvey/v3HwXj8H42NVEVHuladxB?=
 =?us-ascii?Q?K3cRREubTtyTnPQbAcTEe7ysRqTKeF70lfz26+2gTUmJEdKtyujrzgqcmBkw?=
 =?us-ascii?Q?XAVZHZVtwZxoCY1x5na34AyJP834oTuybiHeVdMNAcQNg87BZ4KGHqKOd6qG?=
 =?us-ascii?Q?0QJIRZGiBRRvgUDzVQ3CJ06vG/h2BC4/GAmGXDiPXwRFCTTKZep6CQ2zxvj1?=
 =?us-ascii?Q?138A7U159khm7kxcR2uaLIUSO4nakqwy2dV6ZhN9vEzTeMJfNVsZrGGS4Bao?=
 =?us-ascii?Q?VBvcQ3EfbqjIqcm/K+x+/jR3iaW4wnaIabh0nwGd7O9caAOTkxMIiu69V4sq?=
 =?us-ascii?Q?xMh/wjSCbMGT2SxNRrVGHgdfEOSbtHkKfdPc1ZSbyFZfrjZYIXb7+HDva4VD?=
 =?us-ascii?Q?zjnJAo1pEoBdaJ2kB3x2Le3jmshrcmGr8Md1rhMm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0938f560-14e0-4a11-0b3a-08dd2ecd88e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:44:05.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OblXRraCQrfREJHx0yqy4fM+Crj6TuYv/Brjvcldq9yZEHbFXqxCT2hbceG+8zhKHIURh6HXQynSvqRk24fCSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Currently DAX folio/page reference counts are managed differently to
normal pages. To allow these to be managed the same as normal pages
introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
and take references as it would for a normally mapped page.

This is distinct from the current mechanism, vmf_insert_pfn_pud, which
simply inserts a special devmap PUD entry into the page table without
holding a reference to the page for the mapping.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:
 - Removed is_huge_zero_pud() as it's unlikely to ever be implemented.
 - Minor code clean-up suggested by David.
---
 include/linux/huge_mm.h |  1 +-
 mm/huge_memory.c        | 89 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 93e509b..5bd1ff7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write);
 
 enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 120cd2c..60aa65a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1482,19 +1482,17 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	struct mm_struct *mm = vma->vm_mm;
 	pgprot_t prot = vma->vm_page_prot;
 	pud_t entry;
-	spinlock_t *ptl;
 
-	ptl = pud_lock(mm, pud);
 	if (!pud_none(*pud)) {
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn_t_to_pfn(pfn)))
-				goto out_unlock;
+				return;
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
 			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
 				update_mmu_cache_pud(vma, addr, pud);
 		}
-		goto out_unlock;
+		return;
 	}
 
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
@@ -1508,9 +1506,6 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
-
-out_unlock:
-	spin_unlock(ptl);
 }
 
 /**
@@ -1528,6 +1523,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	unsigned long addr = vmf->address & PUD_MASK;
 	struct vm_area_struct *vma = vmf->vma;
 	pgprot_t pgprot = vma->vm_page_prot;
+	spinlock_t *ptl;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1545,10 +1541,48 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
+	ptl = pud_lock(vma->vm_mm, vmf->pud);
 	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
+	spin_unlock(ptl);
+
 	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
+
+/**
+ * vmf_insert_folio_pud - insert a pud size folio mapped by a pud entry
+ * @vmf: Structure describing the fault
+ * @pfn: pfn of the page to insert
+ * @write: whether it's a write fault
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address & PUD_MASK;
+	pud_t *pud = vmf->pud;
+	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
+		return VM_FAULT_SIGBUS;
+
+	ptl = pud_lock(mm, pud);
+	if (pud_none(*vmf->pud)) {
+		folio_get(folio);
+		folio_add_file_rmap_pud(folio, &folio->page, vma);
+		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
+	}
+	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)), write);
+	spin_unlock(ptl);
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -2146,7 +2180,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
-		zap_deposited_table(tlb->mm, pmd);
+		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
+			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
 	} else {
 		struct folio *folio = NULL;
@@ -2634,12 +2669,23 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
 	arch_check_zapped_pud(vma, orig_pud);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
-		/* No support for anonymous PUD pages yet */
-		BUG();
+		struct page *page = NULL;
+		struct folio *folio;
+
+		/* No support for anonymous PUD pages or migration yet */
+		VM_WARN_ON_ONCE(vma_is_anonymous(vma) || !pud_present(orig_pud));
+
+		page = pud_page(orig_pud);
+		folio = page_folio(page);
+		folio_remove_rmap_pud(folio, page, vma);
+		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
+
+		spin_unlock(ptl);
+		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
 	}
 	return 1;
 }
@@ -2647,6 +2693,10 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long haddr)
 {
+	struct folio *folio;
+	struct page *page;
+	pud_t old_pud;
+
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
@@ -2654,7 +2704,22 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 
 	count_vm_event(THP_SPLIT_PUD);
 
-	pudp_huge_clear_flush(vma, haddr, pud);
+	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
+
+	if (!vma_is_dax(vma))
+		return;
+
+	page = pud_page(old_pud);
+	folio = page_folio(page);
+
+	if (!folio_test_dirty(folio) && pud_dirty(old_pud))
+		folio_mark_dirty(folio);
+	if (!folio_test_referenced(folio) && pud_young(old_pud))
+		folio_set_referenced(folio);
+	folio_remove_rmap_pud(folio, page, vma);
+	folio_put(folio);
+	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
+		-HPAGE_PUD_NR);
 }
 
 void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-40849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D970A27EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE92C16787F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A6E2206B1;
	Tue,  4 Feb 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fX89E0Ih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08352227579;
	Tue,  4 Feb 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709420; cv=fail; b=igM00gaAFOEoSBuzKw9V3rahhyo3nKB6hnFFD16dluPCOgZcDFW10qgSXwvcFUTl2Ar33aECVnnnAuo9GM+b+YV2sY4hGarA53rQExOb3CYMY6zWgm6gXfh2OrcNZX7yT1yhCBKLqfxeH+C/bxIC+i4Lkb1Zp3wBEATs/wIZ8eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709420; c=relaxed/simple;
	bh=Z2A0SA/S4kTGDuhrlMbjSZeZhhGLk3+j65k9vFEORqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrrixN9m/SiYaSLFlBn/Qtr3QyOc+VQRfHGtskqUsNP87pKhavNlatnivCHgm+PYfQmP4eGrLdSUS3KK3O2AeR1em8hZWCYLMQPi9QtTV4Eb9xjmAFkz3KcMJhGo8i2J8C/vOcQi4yVba/jw8brE/wHto4zQYkzaB+Ox+GCVEr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fX89E0Ih; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpsqgdv4rFfKNR+IJXMJccBsqZJvc/0N0gBUSYymczDIATxf5vyM5LaME83WcT9FVcIuwya3GHqgD7SYY3xsD8vQs2sOhCHWVfUDoPtSJseePuJu1dyeP8BTWvi1KDfEI5EQRlJsuwyTdEwO3HH8MDt/H789b2K3tvNOHadB8UI2hD35vDx2VSVkkZx8P3kyCku1F6ATlG6GqgnkiUBCKb2URM17tT6+s1L9qw7DTx6KOAKRL8DnchfjHKacAxpU59klASPx2P72+59TcuQT3cI9mNuVaGqupwO10itqH9HpswuNaVBjRfDXnn9YFUf5e49JqMmOmGOvKzin+FLmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjxNZyoCS6wM4tRnS9oD1pOzf9Wm0aTgkwxj3M/8q5s=;
 b=q+UJTJl9vumjwwgpw0oL7FZYzdSqeNWyHLN/DX9c4zCOOiX3loOJZIUrcwX1oq+yTOfuexfLMNFVqQYapl5T8I98L9Aklj4X97lBWssdhKwG59PbOdFFll5lLmP7r7MWE/W+7MDacQRn3zILNL8BmGXfwxIzluQbUVIj1HJZRpBiNClfGm3Y32jrPkSh0CHUj+K7jwvgbpC8qdq7dWPOWa2Z2UgcBmq1Uz+eDRi8VHXv7/CJUyGJQSbYx9mszAyk0QxgDLSAnujcjl6txybXS+JuW34agh8Ap714TWr9QluMmiLaraIAd87y5C/qUlcBwVj/cuKxBuJd3Aa6bYSryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjxNZyoCS6wM4tRnS9oD1pOzf9Wm0aTgkwxj3M/8q5s=;
 b=fX89E0Ih6yfvqVdszDTvJulZzPg2WnVAollc/vKdQGaG7wOAl1xWLi7zEjJjy7bDPQmPdI1AXIhi7rhsBj0HTNLBE9BXD7bpq1g3TfWyEhnVKPSn7rpFRQNmCJ0EqOe6C9W1SLQNI71BXnV5o3a8MbLqjfmiooHMSFUV6D9zc/PefSu4E3K9srU0md7+TJ4nzEVUWY+G4vwN8EYFP/q9Jl2Yae+Ks45BnlRYyJtLPfiFgma4DdFhis9mk795jN2+F726QM4+pSQR6sP4HRYM2nfH+wBDYZzIFnuYzE2ZblBphf9Ngb4tq4R5zYyloc2Orny6ycbOnRsRIfEN7R4iXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 22:50:14 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:50:14 +0000
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
Subject: [PATCH v7 19/20] fs/dax: Properly refcount fs dax pages
Date: Wed,  5 Feb 2025 09:48:16 +1100
Message-ID: <b5c33b201b9dc0131d8bb33b31661645c68bf398.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0048.ausprd01.prod.outlook.com
 (2603:10c6:1:15::36) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 18592cb4-b899-4a52-28e7-08dd456e4966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?orFh/WQuc0yZKXt7MhAf++hGAnw/oxhnKhSLKpNIazSx7BVudIXoBScnBXWi?=
 =?us-ascii?Q?1NuKCl3sauCv6jTQDcwQPTgNX7vA/CoMJA6+G/P2XWEp6VJSglPQoJmPZYle?=
 =?us-ascii?Q?inbPH9SDfgt/QngiCKKFJgm2IfKW+cFNoekUvbx3Ymi+WJU7Wm0edbxsO4NI?=
 =?us-ascii?Q?GwDg42dsy761jLfEZL3v/8/mYrxsqGm2QS1Ekd9F6D37DuisNZhFzLFHoCW0?=
 =?us-ascii?Q?f/VASA0s/T9NkRhMLbSJcwCCYJlvGFkEAIQbjASxOF94bTFbWAKzQxWdNnRt?=
 =?us-ascii?Q?gq1aLLYlvmuTguaOPXmOCBFwcqE1Xmgy4xI9ZGZMv+0Nv4p5ZcMPgFGs064Y?=
 =?us-ascii?Q?fgpFElFssFiVDmTgP92wTvT9jJio1eIBCD28rO/vmM2GqfeAjHppnYNWH4Ny?=
 =?us-ascii?Q?CZ5j72ho73OTADo7Pwh6pt9U+65ZV7EA61sxPdffIqNzv2JWXBVQuS/jT3iI?=
 =?us-ascii?Q?7ugEJnuMXcb7h6VyVq/XR4VeOEM1MQzbqt42s3zIu7q04UYzi8Hfkru9PSfH?=
 =?us-ascii?Q?UCzX69/8TSA9+AEmO78ehVKK4objKsCRLJUCSO/waBoHXn7yVqjBZI74O1MO?=
 =?us-ascii?Q?Yy77ZcMk2okMQoUhSvOQv7Rh7hsqD74rbQWIXn/CmmtZz1yIHCY5N2rZTtSP?=
 =?us-ascii?Q?+WeEIFLBEMQR+FicjsbaWUJZU8ao5t4QyKy5SShmSdXkuGvopgp551PwpF6D?=
 =?us-ascii?Q?fKWy3Lk5esz5oEARI8Lx4IiGtvcL776gyWeYvGlQmpYOEkvFPc6h11abEyjE?=
 =?us-ascii?Q?G6XdiPyv8iSPebBwbkYSJG6Jw0HtdrJn14ZoTlA6FJEB/KGDEksok/xbcvXY?=
 =?us-ascii?Q?79bw3hvRi5uxSqLmP02eOglpRDwxpz6xFd2yeysZufq33bOG+bPSfnA7cIm3?=
 =?us-ascii?Q?nZANBr+euCC04J2jX1phjz5LYXpMLBh/OIZdnKIs3F+r9SbJwqfWw4TE4LI7?=
 =?us-ascii?Q?1TnbxzuqJh+td3ca7G2EqP4CRn8bnTN39tcIQ4HURmoIVzRyOVHiV02v8DYc?=
 =?us-ascii?Q?6SAQ3CFj/DfZN/4/VWwjTzzD25CQjzVAcoapo0IrDlikUB7GFLS2jUUCEfH3?=
 =?us-ascii?Q?iW0dTa41Djeyqr87bJbGbuCPDodjtUe1YsqvqQOPaWmPcPMKt5Mx6zkjtpVL?=
 =?us-ascii?Q?avWuvg06zaV6Ix+hoFrV4Cj8Ha9cRH5HdrQMO2UHIHDdE/6nRe+7h4E6x4eH?=
 =?us-ascii?Q?YmMR7iW7JrkRtMu3PWOMrxbdibPOqtEkg3oQiJJZs6aqvnTU4FXtrVE6PB5v?=
 =?us-ascii?Q?4tBvwJymmZ0gZLutr8VHB0fKZSD+dRdp9DrJsmJbEa4hPFbOocrI65JrRwmH?=
 =?us-ascii?Q?IIWJAOzmlmezY7F33vNO+p45w/jykGahaf4fNnEl606YuLvqlnp69Dx3VfxS?=
 =?us-ascii?Q?P0lClsnN8lmMjigCkMv7YE7A4Bss?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?daaRKvABRgiDpreghow6CI/pC9sNZ6AvFSDV2aMtpUpPkM3enJ2u9dDUCsiF?=
 =?us-ascii?Q?6C9xCvZhvw2nTEFHqFV9PgWFYfn36z9cjF0WD3O+YUcjVMSyiiIgyqEQiRaG?=
 =?us-ascii?Q?TQr0WV4L1ltVNs8188CH8vOnfE9L3l1Cw6W9XrzAps5KRylEKA7w0Pc4MF6m?=
 =?us-ascii?Q?2ErkYI/nGiq9SGyxWfG2vGyK9upUyc/TF/Bff/ni35dSW7mwy0d6nsuutlhs?=
 =?us-ascii?Q?jBhdayW4zvYcN/rkLgEMbUpTPGhx3Al3cMyi4fwMRl2n4FaHi6GbJckd0oJu?=
 =?us-ascii?Q?oigO9KMJEXuXL7poimq3XEUZFZ/mnF1dOk2nIQFOuCGknemdgHgHmbogyTFM?=
 =?us-ascii?Q?H3lLN1rbPgBOeS5K1dJiK+QrAe3pX8YBlUkjReT2BdfyREf5Hu2AJ3kIl6Ur?=
 =?us-ascii?Q?yoppgOiS8nPV2fhdkXOWDqOFxAySbiRnbPa7igtTy+sKtvJX7cdg6ZHoFbvx?=
 =?us-ascii?Q?qmvNnU0Gej2RW65oEMCq2I1UavUxOiHU2W/NBzBQtAE0R6umKbbTsFK/U18g?=
 =?us-ascii?Q?0NzSG2TtlCMl8f7DIqbcAmkPbV92HvxOfdV5FsQYxrbSucEgb+FJulwSmDjv?=
 =?us-ascii?Q?QQ/gyJqsq+2WDSX911jvqtCNQ5mCJk5OksNhz9O6t9jlviijSS4IqYCsb3/d?=
 =?us-ascii?Q?Bfp24HAQ9Nib3vb66zOuRRCyKmHkPZou7Iv03BUu/PVLab5Ue/lev+Un8y3C?=
 =?us-ascii?Q?2cEpE4JqMFw0D3oc2LQtcoQALw3LF4B5/z/9GuAiAh/rqBt7BwqozuPPWMeQ?=
 =?us-ascii?Q?puUEzY25rmcTM++blBhlG/sIJqwpWPHHv+XPFNagEEvWaMAyl3IUzGqgQBoT?=
 =?us-ascii?Q?OwwSUlwTuleUBoWy7iW2T5TyD1EEBqWswIS1U9Aaf1ndNQlz2fukU403vK09?=
 =?us-ascii?Q?fZBP8Sh+CKjnM/JQyeYJa1g+mVQi5WhTZdicYaPSBDMZ0SavclQG0Li8Vhcf?=
 =?us-ascii?Q?Psz1Z3g3bv28L2JX96LSZ9b4xNz3ELjqejcRfbuzREF/6soaYoZoYyKTcjsr?=
 =?us-ascii?Q?jknvFaD01Ugnr1mBGMYuSNnTrFKJLwH5fmC//cxFTGHSH2QooRu1bRTGW1LT?=
 =?us-ascii?Q?fdd0rCDhds6Bro+ixeOh8unrTsPXA1VU0WBOUu8pIqgzzA7+YKJK1mh8rtYq?=
 =?us-ascii?Q?P33+06Nl7+l/6dyquBKaljqJyYyrBH37YdZ0ZZTwohPmi7DsgddOr4qPoQFT?=
 =?us-ascii?Q?yFllptViWPvu0KHEy8OIbn0ybCgxAogVf3TGhrDzSRHnAOKteVY4LFS9Gfsq?=
 =?us-ascii?Q?XIdcl+mSnpt5TdoyYah47X/0gEp7WkC3O+xKPu2TWmIqTqd7kePeL6/bCal4?=
 =?us-ascii?Q?hPQseHNH49O3/cvAp2suaxi+3jVgXX+1A+QZRLk7dxTLWyozvEhmTAWsP+NM?=
 =?us-ascii?Q?bLxPjOHR5OyvM3T6lHJDdoP80kk9BOgXd/dPGhFXosnTHWvwRetBLBe9l22k?=
 =?us-ascii?Q?32YZtpGMT7gOV/namdHuV9i6/uAiy42GRcZLM3bOoW4bCMYh/agAfYwxnCmY?=
 =?us-ascii?Q?DDVCS80LzQt8c35yyxCt3gbbIJu0vPCG+wm92dqv4xoFdUHn0XtZIaQ97P1h?=
 =?us-ascii?Q?KGtFFEAqppqsx51H6YnfuvO2Msx2WSK0y0xVIzGA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18592cb4-b899-4a52-28e7-08dd456e4966
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:50:14.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSaNZ+iT5aie6258EBxFWmZ0cVfbW/2Dqs5ALm1mJYyaCrAlu0Lbd5salI9gGsGpJKSsme2Gm2tdOHJ8ZqP5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

Currently fs dax pages are considered free when the refcount drops to
one and their refcounts are not increased when mapped via PTEs or
decreased when unmapped. This requires special logic in mm paths to
detect that these pages should not be properly refcounted, and to
detect when the refcount drops to one instead of zero.

On the other hand get_user_pages(), etc. will properly refcount fs dax
pages by taking a reference and dropping it when the page is
unpinned.

Tracking this special behaviour requires extra PTE bits
(eg. pte_devmap) and introduces rules that are potentially confusing
and specific to FS DAX pages. To fix this, and to possibly allow
removal of the special PTE bits in future, convert the fs dax page
refcounts to be zero based and instead take a reference on the page
each time it is mapped as is currently the case for normal pages.

This may also allow a future clean-up to remove the pgmap refcounting
that is currently done in mm/gup.c.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v7:
 - s/dax_device_folio_init/dax_folio_init/ as suggested by Dan
 - s/dax_folio_share_put/dax_folio_put/

Changes since v2:

Based on some questions from Dan I attempted to have the FS DAX page
cache (ie. address space) hold a reference to the folio whilst it was
mapped. However I came to the strong conclusion that this was not the
right thing to do.

If the page refcount == 0 it means the page is:

1. not mapped into user-space
2. not subject to other access via DMA/GUP/etc.

Ie. From the core MM perspective the page is not in use.

The fact a page may or may not be present in one or more address space
mappings is irrelevant for core MM. It just means the page is still in
use or valid from the file system perspective, and it's a
responsiblity of the file system to remove these mappings if the pfn
mapping becomes invalid (along with first making sure the MM state,
ie. page->refcount, is idle). So we shouldn't be trying to track that
lifetime with MM refcounts.

Doing so just makes DMA-idle tracking more complex because there is
now another thing (one or more address spaces) which can hold
references on a page. And FS DAX can't even keep track of all the
address spaces which might contain a reference to the page in the
XFS/reflink case anyway.

We could do this if we made file systems invalidate all address space
mappings prior to calling dax_break_layouts(), but that isn't
currently neccessary and would lead to increased faults just so we
could do some superfluous refcounting which the file system already
does.

I have however put the page sharing checks and WARN_ON's back which
also turned out to be useful for figuring out when to re-initialising
a folio.
---
 drivers/nvdimm/pmem.c    |   4 +-
 fs/dax.c                 | 198 ++++++++++++++++++++++++----------------
 fs/fuse/virtio_fs.c      |   3 +-
 include/linux/dax.h      |   2 +-
 include/linux/mm.h       |  27 +-----
 include/linux/mm_types.h |   7 +-
 mm/gup.c                 |   9 +--
 mm/huge_memory.c         |   6 +-
 mm/internal.h            |   2 +-
 mm/memory-failure.c      |   6 +-
 mm/memory.c              |   6 +-
 mm/memremap.c            |  47 ++++-----
 mm/mm_init.c             |   9 +--
 mm/swap.c                |   2 +-
 14 files changed, 170 insertions(+), 158 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index d81faa9..785b2d2 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -513,7 +513,7 @@ static int pmem_attach_disk(struct device *dev,
 
 	pmem->disk = disk;
 	pmem->pgmap.owner = pmem;
-	pmem->pfn_flags = PFN_DEV;
+	pmem->pfn_flags = 0;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
@@ -522,7 +522,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
 		pmem->pfn_pad = resource_size(res) -
 			range_len(&pmem->pgmap.range);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 		bb_range.start += pmem->data_offset;
 	} else if (pmem_should_map_pages(dev)) {
@@ -532,7 +531,6 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
-		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
 	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
diff --git a/fs/dax.c b/fs/dax.c
index 1128a0d..9e4940a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -71,6 +71,11 @@ static unsigned long dax_to_pfn(void *entry)
 	return xa_to_value(entry) >> DAX_SHIFT;
 }
 
+static struct folio *dax_to_folio(void *entry)
+{
+	return page_folio(pfn_to_page(dax_to_pfn(entry)));
+}
+
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
 	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
@@ -338,28 +343,15 @@ static unsigned long dax_entry_size(void *entry)
 		return PAGE_SIZE;
 }
 
-static unsigned long dax_end_pfn(void *entry)
-{
-	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
-}
-
-/*
- * Iterate through all mapped pfns represented by an entry, i.e. skip
- * 'empty' and 'zero' entries.
- */
-#define for_each_mapped_pfn(entry, pfn) \
-	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
-
 /*
  * A DAX page is considered shared if it has no mapping set and ->share (which
  * shares the ->index field) is non-zero. Note this may return false even if the
  * page is shared between multiple files but has not yet actually been mapped
  * into multiple address spaces.
  */
-static inline bool dax_page_is_shared(struct page *page)
+static inline bool dax_folio_is_shared(struct folio *folio)
 {
-	return !page->mapping && page->share;
+	return !folio->mapping && folio->share;
 }
 
 /*
@@ -372,88 +364,129 @@ static inline bool dax_page_is_shared(struct page *page)
  * recover ->mapping and ->index information. For example by implementing
  * dax_holder_operations.
  */
-static void dax_page_make_shared(struct page *page)
+static void dax_folio_make_shared(struct folio *folio)
 {
 	/*
-	 * page is not currently shared so mark it as shared by clearing
-	 * page->mapping.
+	 * folio is not currently shared so mark it as shared by clearing
+	 * folio->mapping.
 	 */
-	page->mapping = NULL;
+	folio->mapping = NULL;
 
 	/*
-	 * page has previously been mapped into one address space so set the
+	 * folio has previously been mapped into one address space so set the
 	 * share count.
 	 */
-	page->share = 1;
+	folio->share = 1;
 }
 
-static inline unsigned long dax_page_share_put(struct page *page)
+static inline unsigned long dax_folio_put(struct folio *folio)
 {
-	WARN_ON_ONCE(!page->share);
-	return --page->share;
+	unsigned long ref;
+
+	if (!dax_folio_is_shared(folio))
+		ref = 0;
+	else
+		ref = --folio->share;
+
+	WARN_ON_ONCE(ref < 0);
+	if (!ref) {
+		folio->mapping = NULL;
+		if (folio_order(folio)) {
+			struct dev_pagemap *pgmap = page_pgmap(&folio->page);
+			unsigned int order = folio_order(folio);
+			unsigned int i;
+
+			for (i = 0; i < (1UL << order); i++) {
+				struct page *page = folio_page(folio, i);
+
+				ClearPageHead(page);
+				clear_compound_head(page);
+
+				/*
+				 * Reset pgmap which was over-written by
+				 * prep_compound_page().
+				 */
+				page_folio(page)->pgmap = pgmap;
+
+				/* Make sure this isn't set to TAIL_MAPPING */
+				page->mapping = NULL;
+				page->share = 0;
+				WARN_ON_ONCE(page_ref_count(page));
+			}
+		}
+	}
+
+	return ref;
+}
+
+static void dax_folio_init(void *entry)
+{
+	struct folio *folio = dax_to_folio(entry);
+	int order = dax_entry_order(entry);
+
+	/*
+	 * Folio should have been split back to order-0 pages in
+	 * dax_folio_put() when they were removed from their
+	 * final mapping.
+	 */
+	WARN_ON_ONCE(folio_order(folio));
+
+	if (order > 0) {
+		prep_compound_page(&folio->page, order);
+		if (order > 1)
+			INIT_LIST_HEAD(&folio->_deferred_list);
+		WARN_ON_ONCE(folio_ref_count(folio));
+	}
 }
 
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool shared)
+				struct vm_area_struct *vma, unsigned long address, bool shared)
 {
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+	unsigned long size = dax_entry_size(entry), index;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
 	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (shared && (page->mapping || page->share)) {
-			if (page->mapping)
-				dax_page_make_shared(page);
+	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
+		if (folio->mapping)
+			dax_folio_make_shared(folio);
 
-			WARN_ON_ONCE(!page->share);
-			page->share++;
-		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
-		}
+		WARN_ON_ONCE(!folio->share);
+		WARN_ON_ONCE(dax_entry_order(entry) != folio_order(folio));
+		folio->share++;
+	} else {
+		WARN_ON_ONCE(folio->mapping);
+		dax_folio_init(entry);
+		folio = dax_to_folio(entry);
+		folio->mapping = mapping;
+		folio->index = index;
 	}
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+				bool trunc)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		if (dax_page_is_shared(page)) {
-			/* keep the shared flag if this page is still shared */
-			if (dax_page_share_put(page) > 0)
-				continue;
-		} else
-			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
-	}
+	dax_folio_put(folio);
 }
 
 static struct page *dax_busy_page(void *entry)
 {
-	unsigned long pfn;
+	struct folio *folio = dax_to_folio(entry);
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry))
+		return NULL;
 
-		if (page_ref_count(page) > 1)
-			return page;
-	}
-	return NULL;
+	if (folio_ref_count(folio) - folio_mapcount(folio))
+		return &folio->page;
+	else
+		return NULL;
 }
 
 /**
@@ -786,7 +819,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -954,7 +987,8 @@ void dax_break_layout_final(struct inode *inode)
 		wait_page_idle_uninterruptible(page, inode);
 	} while (true);
 
-	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL_GPL(dax_break_layout_final);
 
@@ -1040,8 +1074,10 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
+		if (!(flags & DAX_ZERO_PAGE))
+			dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+						shared);
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1229,9 +1265,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1338,7 +1372,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1809,7 +1843,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	struct folio *folio;
+	int ret, err = 0;
 	pfn_t pfn;
 	void *kaddr;
 
@@ -1841,17 +1876,18 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
+	folio = dax_to_folio(*entry);
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	/* insert PMD pfn */
+	folio_ref_inc(folio);
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)), write);
+	else
+		ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), write);
+	folio_put(folio);
 
-	/* insert PTE pfn */
-	if (write)
-		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
-	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+	return ret;
 }
 
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
@@ -2090,6 +2126,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
+	struct folio *folio;
 	void *entry;
 	vm_fault_t ret;
 
@@ -2107,14 +2144,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
+	folio = pfn_folio(pfn_t_to_pfn(pfn));
+	folio_ref_inc(folio);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_page_mkwrite(vmf, &folio->page, true);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
-		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
+		ret = vmf_insert_folio_pmd(vmf, folio, FAULT_FLAG_WRITE);
 #endif
 	else
 		ret = VM_FAULT_FALLBACK;
+	folio_put(folio);
 	dax_unlock_entry(&xas, entry);
 	trace_dax_insert_pfn_mkwrite(mapping->host, vmf, ret);
 	return ret;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 82afe78..2c7b24c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1017,8 +1017,7 @@ static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 	if (kaddr)
 		*kaddr = fs->window_kaddr + offset;
 	if (pfn)
-		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
-					PFN_DEV | PFN_MAP);
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset, 0);
 	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2333c30..dcc9fcd 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -209,7 +209,7 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 
 static inline bool dax_page_is_idle(struct page *page)
 {
-	return page && page_ref_count(page) == 1;
+	return page && page_ref_count(page) == 0;
 }
 
 #if IS_ENABLED(CONFIG_DAX)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 05a44ae..8380975 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1098,6 +1098,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1419,25 +1421,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!folio_is_zone_device(folio))
-		return false;
-	return __put_devmap_managed_folio_refs(folio, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
@@ -1552,12 +1535,6 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_folio_refs(folio, 1))
-		return;
 	folio_put(folio);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e14da6..8efafef 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -295,6 +295,8 @@ typedef struct {
  *    anonymous memory.
  * @index: Offset within the file, in units of pages.  For anonymous memory,
  *    this is the index from the beginning of the mmap.
+ * @share: number of DAX mappings that reference this folio. See
+ *    dax_associate_entry.
  * @private: Filesystem per-folio data (see folio_attach_private()).
  * @swap: Used for swp_entry_t if folio_test_swapcache().
  * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
@@ -344,7 +346,10 @@ struct folio {
 				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
-			pgoff_t index;
+			union {
+				pgoff_t index;
+				unsigned long share;
+			};
 			union {
 				void *private;
 				swp_entry_t swap;
diff --git a/mm/gup.c b/mm/gup.c
index 10f1ddd..acd6154 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -96,8 +96,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -116,8 +115,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_folio_refs(folio, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
@@ -565,8 +563,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 */
 	if (unlikely((flags & FOLL_LONGTERM) &&
 		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_folio_refs(folio, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		return NULL;
 	}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c27048d..a830715 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2221,7 +2221,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2877,13 +2877,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_special_huge(vma))
+		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
 		if (unlikely(is_pmd_migration_entry(old_pmd))) {
 			swp_entry_t entry;
 
 			entry = pmd_to_swp_entry(old_pmd);
 			folio = pfn_swap_entry_folio(entry);
+		} else if (is_huge_zero_pmd(old_pmd)) {
+			return;
 		} else {
 			page = pmd_page(old_pmd);
 			folio = page_folio(page);
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30..db5974b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -735,8 +735,6 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-extern void prep_compound_page(struct page *page, unsigned int order);
-
 void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 995a15e..8ba3d1d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -419,18 +419,18 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
 		return 0;
-	if (pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return PUD_SHIFT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return 0;
-	if (pmd_devmap(*pmd))
+	if (pmd_trans_huge(*pmd))
 		return PMD_SHIFT;
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return 0;
 	ptent = ptep_get(pte);
-	if (pte_present(ptent) && pte_devmap(ptent))
+	if (pte_present(ptent))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index b88b488..e6520c4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3826,13 +3826,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
-		 * VM_PFNMAP VMA.
+		 * VM_PFNMAP VMA. FS DAX also wants ops->pfn_mkwrite called.
 		 *
 		 * We should not cow pages in a shared writeable mapping.
 		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
 		 */
-		if (!vmf->page)
+		if (!vmf->page || is_fsdax_page(vmf->page)) {
+			vmf->page = NULL;
 			return wp_pfn_shared(vmf);
+		}
 		return wp_page_shared(vmf, folio);
 	}
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 68099af..9a8879b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,13 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->pgmap->ops ||
-			!folio->pgmap->ops->page_free))
+	struct dev_pagemap *pgmap = folio->pgmap;
+
+	if (WARN_ON_ONCE(!pgmap->ops))
+		return;
+
+	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
+			 !pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -484,26 +489,36 @@ void free_zone_device_folio(struct folio *folio)
 	 * For other types of ZONE_DEVICE pages, migration is either
 	 * handled differently or not done at all, so there is no need
 	 * to clear folio->mapping.
+	 *
+	 * FS DAX pages clear the mapping when the folio->share count hits
+	 * zero which indicating the page has been removed from the file
+	 * system mapping.
 	 */
-	folio->mapping = NULL;
-	folio->pgmap->ops->page_free(folio_page(folio, 0));
+	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
+		folio->mapping = NULL;
 
-	switch (folio->pgmap->type) {
+	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->pgmap);
+		pgmap->ops->page_free(folio_page(folio, 0));
+		put_dev_pagemap(pgmap);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
+		pgmap->ops->page_free(folio_page(folio, 0));
 		folio_set_count(folio, 1);
 		break;
 
+	case MEMORY_DEVICE_FS_DAX:
+		wake_up_var(&folio->page);
+		break;
+
 	case MEMORY_DEVICE_PCI_P2PDMA:
+		pgmap->ops->page_free(folio_page(folio, 0));
 		break;
 	}
 }
@@ -519,21 +534,3 @@ void zone_device_page_init(struct page *page)
 	lock_page(page);
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
-		return false;
-
-	/*
-	 * fsdax page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (folio_ref_sub_return(folio, refs) == 1)
-		wake_up_var(&folio->_refcount);
-	return true;
-}
-EXPORT_SYMBOL(__put_devmap_managed_folio_refs);
-#endif /* CONFIG_FS_DAX */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 8719e84..f4caa70 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1017,23 +1017,22 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
-	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
-	 * allocator which will set the page count to 1 when allocating the
-	 * page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
+	 * directly to the driver page allocator which will set the page count
+	 * to 1 when allocating the page.
 	 *
 	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
 	 * their refcount reset to one whenever they are freed (ie. after
 	 * their refcount drops to 0).
 	 */
 	switch (pgmap->type) {
+	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
 	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
 		break;
 
-	case MEMORY_DEVICE_FS_DAX:
 	case MEMORY_DEVICE_GENERIC:
 		break;
 	}
diff --git a/mm/swap.c b/mm/swap.c
index fc8281e..7523b65 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -956,8 +956,6 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_folio_refs(folio, nr_refs))
-				continue;
 			if (folio_ref_sub_and_test(folio, nr_refs))
 				free_zone_device_folio(folio);
 			continue;
-- 
git-series 0.9.1


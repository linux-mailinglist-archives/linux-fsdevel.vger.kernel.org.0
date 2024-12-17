Return-Path: <linux-fsdevel+bounces-37574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 898FE9F41EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD871888C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D815533F;
	Tue, 17 Dec 2024 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h0JYA8Vf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638470827;
	Tue, 17 Dec 2024 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734412412; cv=fail; b=PRXrcKt+vS8TMxpf2VHNK74pwunRmXuGVPMfT1tR9pZWCA9XYpiXMA4XOYs5F2OooYhE0BFu9Z5RapylN5eeHXJmi63S9OI2blMIFzLNPTDh2q+FFfEmJu0V1VEZzL17q1PCBl52Zmmmw6vNmGCyUzkcz+P/eT9JzUYYuFiB4n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734412412; c=relaxed/simple;
	bh=IGMh93gSP/sMSjAc/LqQ8F6NPvWkFmiNgzxQmkuNv68=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZTB3E29MRtg7naBUo/BpnY/yQgHDVA+5inbFFrAb6TWq9ne9exGutKoLjh0QyNd9pwddEwTVV70Uo5O0lr1GoLglsny8tt59RsSrFGnRzoiPFDK3Ovb1UcHV6XObdr+AO6mgIPe6lfO3DoPqN+Kn9ThZwBHCku44hu7YfNqBs+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h0JYA8Vf; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CArsXbOti08qmUdHoY0OUL4Q6v1KVTHTfAbytnrTtwo9xPSoXz28AcLctTDUee5mPM8Z4bXcnkX8BKUoREozzX8jW4c/rPQHry5rpvcOhJR8Aa0shIwghlNoX07L1IIgtBqMuVUQie7+UiClS0kIK/eEo/gEGYkM3bPM0dGCZtKQByLoWT6CUbbSbAnt3ZMHYrNyI6TGfnYYvcR2z0AJiKFg+HZoepuevZKfTY15AghQ7kK5W4ZvZQaIc+Z3mzU5H6idweLUIiv2abYW+lXF9DhcELo+MBR/+ndhts5w+emz6bK79dVPBkovUr3EwLjqEXQluJpMu1tZ5cUcKc3Fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3ctEhFLYPJl0ejLmEqc8V83PAPjatQzcHAuasxJTOs=;
 b=GnntueXJykTuCndgQ4hvSceNfg8FnSEcvxJ4EksR/+5H5GSjR3rPglFWt4b3vqGgGOYZjcLD7dU3i97ZMvIkBPbe1wINm21/W1frWj37zrBWd4J/2dOsWdQQ/uS7pOyfL2aWxQ9D0WzLUO1Eki4c1FmLNSM+WnNGrRCr0nCPuptoMpKj1BQ8pkGIbQn6UbmHNJFX/pWr22eGgxrYUwFOC78lbRY1zS8qgZYxECYNW2belm0uCR5z+51MofaJVLJGFXGrWjGjMxwDSI+IFUmsM1r+S06ZFC/icTk9gJ+7Q/7K3CYf0AOBaurvWnUELUS9X05ZK1yYCnAX/D7zYml0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3ctEhFLYPJl0ejLmEqc8V83PAPjatQzcHAuasxJTOs=;
 b=h0JYA8VfymDmeDxaOPAj+rkxzQxjkw98IN58buwihm8ccL+LY/zj7D/cUkO+MFT2mKh5a7zwbVwoEqLSIcevK4JoiDQ8oaOCDyCyZ8OHWwP7iDW+qfXdoMm9LEHZTv+Nmwy7k5DGScGRoXSpHidSq5NTmBPYZEyFdfZZduEn0IrgBtvUJ94UPOcZDV2YplmBA1LD/82h4zfmQXp6JTQTk+3tKnwifsNLAlMwlcCE+GP0NxZ2kACLUz0hswznrz1gBRsc2LJtjKZVxX4K3qFEnQyHc10wDADZMexZKzvOVLn68FMAGIm+ACGQanAQ9wN1Bn18ZdptFH7ykQLNDm3Bpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 05:13:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 05:13:25 +0000
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
Subject: [PATCH v4 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Date: Tue, 17 Dec 2024 16:12:43 +1100
Message-ID: <cover.18cbcff3638c6aacc051c44533ebc6c002bf2bd9.1734407924.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0117.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a973c43-7f54-4223-3bf1-08dd1e598879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wpy5ZQ00jGuT5FToRPQvE5o3wjj0PFkPL4iNIwf/NVP432SkpdBgP37HNE9m?=
 =?us-ascii?Q?kbo+Ae7AZIuPV3qIsfd5Z/GNhEYHsrAz5Qmzf9CYE38KT/Nn6aliiZCp/9HJ?=
 =?us-ascii?Q?jjBRlA+mjhSMGUf2Vw6CVBrt7b6ggQ63KItbgfNep3A7ChTkmIdGnYQGFR+U?=
 =?us-ascii?Q?DPWRbf5IGnNB+s7LPLZW5QLpN3r+cp7A4uQd2m7PwGLtyki9PsI6vNdgXnNI?=
 =?us-ascii?Q?/edY0wInG5VVsORQpk3emhTXfLCBfhzeCGpRv/r+AZXDAY+ewBc3tvAg1T8E?=
 =?us-ascii?Q?BSeqVw6jDZGz/datoeAkLytOY2IkUHw4LX0NarvFrsEhOXofZgQdK6WNBclZ?=
 =?us-ascii?Q?mBtIcomGQoFvwLG9luiNINb1PXfodBkAQ2KylKNeM7UJ30YfXap3ctkjbFP+?=
 =?us-ascii?Q?D3CuB2LdgG39rrT8dP0MyIJsAftUww3KZqzXqTyZ8GMWSzQlYmOJjjCcFZ+M?=
 =?us-ascii?Q?6rNAzz0Hcvsg3G0XCAdV5KE+7nK39hqWQ4YC2uE62XClNxKKgHSyYEsE+pxv?=
 =?us-ascii?Q?sEVja/FECv7LKehprXAbT0uU8TDGGvPm8Tc6Klk4f9MJexljj633sYswVrAL?=
 =?us-ascii?Q?Fj2ez3LfG6jDamUiN7VxAS5r2VbXtVqatXf+0QcCewYTD9rXh9d1fcVG5eIW?=
 =?us-ascii?Q?9jEmj2+81QbrmpKPfkJnwcE4a09LPSvr3oniFVu4rq+QA0YyKWTf/000RVUD?=
 =?us-ascii?Q?7BoE8DYxtLI4jQyboMHyXDjtibk6I9i8TMreYcAkfF+07bllfT8eRS8AN3Hf?=
 =?us-ascii?Q?P77ddLKgNBSNsa2R2cwcHmGWPy8+D8k0xpcx6ypc+YbcjP4XA/hZxEjmdZDW?=
 =?us-ascii?Q?b8sKiPj5vFOYDUIEvpww7lLSDpPjzHs1WJmmwTEfCRRoMYQih3DnLXXyv3S8?=
 =?us-ascii?Q?LYJQ7zu342+04psHr4npteS2So2Cqfc8BgnSUD9lN78fZMQIrrVnmqsOuP++?=
 =?us-ascii?Q?t9x5+j8sZndd8QMaGj2e7AcJRcbVr+6mUrwbkHMuGCYHS1i5Xbjv1h7fHz8f?=
 =?us-ascii?Q?npg6ITL+ypMT2rbxqseRbNKpeUFpUqPDUZ+5jT2BwsLUFZeDmn06ZzyYiYsL?=
 =?us-ascii?Q?+v25Qp6Xe+YGcX6KJlNxPops0whNeL+lmFe0pL/ShO6LR1P4fh0XbIBXl6KU?=
 =?us-ascii?Q?TqTjVccH2D2W+ln3ZIvABNmA3qHUOM2JnxX2+glBu3oX+IWO4uLiJmnZjBbO?=
 =?us-ascii?Q?v9hbuMmO37LRF1AS7LYq/xh+sW2tJSOFUCjdVC9W8jtIqKFuOmdMOyBNS6JW?=
 =?us-ascii?Q?eldxRJ82bAXdwYd2yUb1jKIw/uSrh7GgKPBbbZ5yGmn+nVdfxMjcOC0CJew+?=
 =?us-ascii?Q?dr2parancdP3ALzy6NqleE4t/sdgbTxuB8Am6jMWnYayqYz2N94MSwg4eNq6?=
 =?us-ascii?Q?f+pw+wW/00Q5NbTNyfhjFCUiA9Ac?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2l3I5o0dnrWYU7XfDzameO7P1AM/F7qWrlVlJW5uhEJ0ZWf0rztmC9X7QxV?=
 =?us-ascii?Q?G0kiZ09+NeHRIvxJWAnkiD6xb2ZHO+0PxW/sWDmS2oHrK6KEOiB4YKcVJNDC?=
 =?us-ascii?Q?ElS031aeTS9Y/b34+Xo62LXdOley1/qnMId05DVBakahIxb7xpqdSv0d4iPp?=
 =?us-ascii?Q?vkLh5VL9dcoozgFdfdd6mDRxlaEGfSSTrBI5SJ+XwSV0sxHhV2rjjHiGOZpw?=
 =?us-ascii?Q?44geCDYpjl8pySJLncoJ6GpEGSduP38uuzNuW8HB/HlU2bTiKdDCc8MoAkfF?=
 =?us-ascii?Q?qPoGChstBPBGKaFm6TOMtG/6FXgXfGAwXUyXhMC8oXBgFfcHYDcAekiHK6BO?=
 =?us-ascii?Q?+VgM+xEkPorjll3dIlNDYST/X/w/5kiIltFcXSJm++jZs5mWCXUgqI+dvkdb?=
 =?us-ascii?Q?zou7sTnIBskaW8cgdXJ39/61XlcIHa45L3eeAL33ZxlL/LlLDFOVrqax/urt?=
 =?us-ascii?Q?4a9JXaZvyI0f6OweJG36CYsT8X6vqNicH6YeHF76qopHcNCxG8gg9iEtSvPM?=
 =?us-ascii?Q?TfXqfx4pKjZhU0M6tN+Kn17Z5Xh7r0fd2myovtG7FcZOqcfHZ34dsE4Nosr/?=
 =?us-ascii?Q?cvQmHgm8vw6xassUNlF2Hq+KRNDRzSqZWu7nCRB35kugZTKYkS3Tfj27yVHU?=
 =?us-ascii?Q?+FblWxxd1neYc4EfGg+Q5PGqoI92E3Yxs6BXfHQZbGB+HyxwJvyoH1RfZla4?=
 =?us-ascii?Q?q4wDviJNfkqNNaSEWfziePSOAzwPzdCYCn2OMOlmhglMNSvzhzpEifcqppqJ?=
 =?us-ascii?Q?145re5ByupiD/U+Kf4KHLZuj0DNu5B93PIvNzk6cHQqE0KHIkfA626IbuC1B?=
 =?us-ascii?Q?UYWZdAAPm30wVR4S4b2e+BuYbeLKxRa6994JVmlWnAvd9ywTU3O38tLBQBnw?=
 =?us-ascii?Q?VYLda2BWAz6kHIG1MBpUk/kiNvctvkaOJXZeHAphOfu9nZs1ZWSBnaja6EoU?=
 =?us-ascii?Q?Lmr/pxt60zAOeYFBHzR9ES3WdYT8q/9YdYJI5dMZAeCkgFGXEgVgvs7/zPDO?=
 =?us-ascii?Q?eMUx8fIrzdnnwRB76lR6vr1nPqqtA6qe2r/JziB29vmPK5szXkP6Zgoa9Swf?=
 =?us-ascii?Q?UolaVSz7jKkVF3r5SHtp4KuS5DBMhtuFgRiRu55pac9uUqFy8RpZH9s4Ciw9?=
 =?us-ascii?Q?WMFFUJPLQCiFnBCD1xjebRHOvGCNbZ9IW1IUERCJMa4sH/nx4wNvoiE3K/o+?=
 =?us-ascii?Q?ssIs7GKVoSf/t0PyzuN8/5R29XAVg527HSyswD+dQyMqG5Ph1B5RfGxVzpbV?=
 =?us-ascii?Q?mzTTV8CydJPh4LEPM9qRHFvMXCDm64LRhPXPLRWRt9uncFBXT86Ymwb6hBoh?=
 =?us-ascii?Q?//QnGmpVna85P5Xu7l2rCSBcB1IIiJNuQbRAyEBPBmCu6F/dUQgjZGtJFtOu?=
 =?us-ascii?Q?9QmJgNeptVGXySnPPoEpNWH/t8UIHdJ7q89TI+whmpZxti3ex/+PQqYrcP/b?=
 =?us-ascii?Q?HCTz2eNFJm+bPlcac1vHPLjIt/F9wqR7lDoysryjNRIAeaO8EjswOdaT05Cw?=
 =?us-ascii?Q?hzlxrEMpEiTm2jkHp7gMcSe/F0iBhae2EHlAJUXtwSAo8vw1H7W4AjYae5tA?=
 =?us-ascii?Q?f+BDB5ujDOKFJEsxGGkgBVSx6FjetRVFOoBqGA2t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a973c43-7f54-4223-3bf1-08dd1e598879
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 05:13:25.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGM3K2EakZl+6YtbryBHOVs8U0HvO+PYNw2bFb86RDEYwV7qotyHbvtGWNR6TP1UEKMM6QwlMgWdC/YQPyVHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Main updates since v3:
 - Rebased onto next-20241216

 - Fixed a bunch of build breakages reported by John Hubbard and the
   kernel test robot due to various combinations of CONFIG options.

 - Split the rmap changes into a separate patch as suggested by David H.

 - Reworded the description for the P2PDMA change.

Main updates since v2:

 - Rename the DAX specific dax_insert_XXX functions to vmf_insert_XXX
   and have them pass the vmf struct.

 - Seperate out the device DAX changes.

 - Restore the page share mapping counting and associated warnings.

 - Rework truncate to require file-systems to have previously called
   dax_break_layout() to remove the address space mapping for a
   page. This found several bugs which are fixed by the first half of
   the series. The motivation for this was initially to allow the FS
   DAX page-cache mappings to hold a reference on the page.

   However that turned out to be a dead-end (see the comments on patch
   21), but it found several bugs and I think overall it is an
   improvement so I have left it here.

Device and FS DAX pages have always maintained their own page
reference counts without following the normal rules for page reference
counting. In particular pages are considered free when the refcount
hits one rather than zero and refcounts are not added when mapping the
page.

Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
mechanism for allowing GUP to hold references on the page (see
get_dev_pagemap). However there doesn't seem to be any reason why FS
DAX pages need their own reference counting scheme.

By treating the refcounts on these pages the same way as normal pages
we can remove a lot of special checks. In particular pXd_trans_huge()
becomes the same as pXd_leaf(), although I haven't made that change
here. It also frees up a valuable SW define PTE bit on architectures
that have devmap PTE bits defined.

It also almost certainly allows further clean-up of the devmap managed
functions, but I have left that as a future improvment. It also
enables support for compound ZONE_DEVICE pages which is one of my
primary motivators for doing this work.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Cc: lina@asahilina.net
Cc: zhang.lyra@gmail.com
Cc: gerald.schaefer@linux.ibm.com
Cc: dan.j.williams@intel.com
Cc: vishal.l.verma@intel.com
Cc: dave.jiang@intel.com
Cc: logang@deltatee.com
Cc: bhelgaas@google.com
Cc: jack@suse.cz
Cc: jgg@ziepe.ca
Cc: catalin.marinas@arm.com
Cc: will@kernel.org
Cc: mpe@ellerman.id.au
Cc: npiggin@gmail.com
Cc: dave.hansen@linux.intel.com
Cc: ira.weiny@intel.com
Cc: willy@infradead.org
Cc: djwong@kernel.org
Cc: tytso@mit.edu
Cc: linmiaohe@huawei.com
Cc: david@redhat.com
Cc: peterx@redhat.com
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: jhubbard@nvidia.com
Cc: hch@lst.de
Cc: david@fromorbit.com

Alistair Popple (25):
  fuse: Fix dax truncate/punch_hole fault path
  fs/dax: Return unmapped busy pages from dax_layout_busy_page_range()
  fs/dax: Don't skip locked entries when scanning entries
  fs/dax: Refactor wait for dax idle page
  fs/dax: Create a common implementation to break DAX layouts
  fs/dax: Always remove DAX page-cache entries when breaking layouts
  fs/dax: Ensure all pages are idle prior to filesystem unmount
  fs/dax: Remove PAGE_MAPPING_DAX_SHARED mapping flag
  mm/gup.c: Remove redundant check for PCI P2PDMA page
  mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
  mm: Allow compound zone device pages
  mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
  mm/memory: Add vmf_insert_page_mkwrite()
  rmap: Add support for PUD sized mappings to rmap
  huge_memory: Add vmf_insert_folio_pud()
  huge_memory: Add vmf_insert_folio_pmd()
  memremap: Add is_device_dax_page() and is_fsdax_page() helpers
  gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  proc/task_mmu: Ignore ZONE_DEVICE pages
  mm/mlock: Skip ZONE_DEVICE PMDs during mlock
  fs/dax: Properly refcount fs dax pages
  device/dax: Properly refcount device dax pages when mapping
  mm: Remove pXX_devmap callers
  mm: Remove devmap related functions and page table bits
  Revert "riscv: mm: Add support for ZONE_DEVICE"

 Documentation/mm/arch_pgtable_helpers.rst     |   6 +-
 arch/arm64/Kconfig                            |   1 +-
 arch/arm64/include/asm/pgtable-prot.h         |   1 +-
 arch/arm64/include/asm/pgtable.h              |  24 +-
 arch/powerpc/Kconfig                          |   1 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  52 +---
 arch/powerpc/include/asm/book3s/64/radix.h    |  14 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |   3 +-
 arch/powerpc/mm/book3s64/pgtable.c            |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   5 +-
 arch/powerpc/mm/pgtable.c                     |   2 +-
 arch/riscv/Kconfig                            |   1 +-
 arch/riscv/include/asm/pgtable-64.h           |  20 +-
 arch/riscv/include/asm/pgtable-bits.h         |   1 +-
 arch/riscv/include/asm/pgtable.h              |  17 +-
 arch/x86/Kconfig                              |   1 +-
 arch/x86/include/asm/pgtable.h                |  51 +---
 arch/x86/include/asm/pgtable_types.h          |   5 +-
 drivers/dax/device.c                          |  15 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |   3 +-
 drivers/nvdimm/pmem.c                         |   4 +-
 drivers/pci/p2pdma.c                          |  19 +-
 fs/dax.c                                      | 357 ++++++++++++++-----
 fs/ext4/inode.c                               |  43 +--
 fs/fuse/dax.c                                 |  35 +--
 fs/fuse/virtio_fs.c                           |   3 +-
 fs/proc/task_mmu.c                            |  18 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_inode.c                            |  40 +-
 fs/xfs/xfs_inode.h                            |   3 +-
 fs/xfs/xfs_super.c                            |  18 +-
 include/linux/dax.h                           |  37 ++-
 include/linux/huge_mm.h                       |  22 +-
 include/linux/memremap.h                      |  28 +-
 include/linux/migrate.h                       |   4 +-
 include/linux/mm.h                            |  40 +--
 include/linux/mm_types.h                      |  14 +-
 include/linux/mmzone.h                        |  12 +-
 include/linux/page-flags.h                    |   6 +-
 include/linux/pfn_t.h                         |  20 +-
 include/linux/pgtable.h                       |  21 +-
 include/linux/rmap.h                          |  15 +-
 lib/test_hmm.c                                |   3 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  59 +---
 mm/gup.c                                      | 176 +---------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              | 233 +++++++-----
 mm/internal.h                                 |   2 +-
 mm/khugepaged.c                               |   2 +-
 mm/madvise.c                                  |   8 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memory-failure.c                           |   6 +-
 mm/memory.c                                   | 126 ++++---
 mm/memremap.c                                 |  59 +--
 mm/migrate_device.c                           |   9 +-
 mm/mlock.c                                    |   2 +-
 mm/mm_init.c                                  |  23 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   5 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pagewalk.c                                 |  14 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/rmap.c                                     |  56 +++-
 mm/swap.c                                     |   2 +-
 mm/truncate.c                                 |  16 +-
 mm/userfaultfd.c                              |   5 +-
 mm/vmscan.c                                   |   5 +-
 70 files changed, 922 insertions(+), 928 deletions(-)

base-commit: e25c8d66f6786300b680866c0e0139981273feba
-- 
git-series 0.9.1


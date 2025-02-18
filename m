Return-Path: <linux-fsdevel+bounces-41929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23942A391EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2A418958AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C441DE8A7;
	Tue, 18 Feb 2025 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuaUsuO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165F1DE4CC;
	Tue, 18 Feb 2025 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851057; cv=fail; b=inShP/YMvYYaJWlUQyYodvCWGb84ddVFCwE8RlJt/bWqjiWkobhcWzkOQJLxQZ9aBQcvEwd+9v+gZtVnrIohhZUGykm2PtAcJY9nQg1kbcfQ4oV2mwhaTHbJ5tGPU3d9aIHY5Ng2TKahQxFsAUcWZrzbXDBrr1KEScXx/Xr1GBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851057; c=relaxed/simple;
	bh=SAC+0joFmvpdVWZ4j3kQvyHFPadGuPMFSoljdwoqLfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lK/5QV03aLwitg7FwOqDysRKsZpx2e8xVMWJrykjRcMWES66tJsRgeFh57sbeskgWk/okMI0NHG9rxZNWy/N7ApqgwERQC0GZw99H3DqEpz48dcZmIDQ7ttaXWxunx2Iu9cTb0xxsyoBwojKK5h2q9JN5Rq31QTtZaxZ1pT26FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuaUsuO7; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKWGL2jyYAOvhQdWTp+SNKz8m2Id59kJYpZVtix2KMC7yzzztM9VwFtjEV1FCDBE6X6Sy5aJ6NExQXbkXpVpMCQdUsdUEDfzjpIu2uBloAtUaHsGKcr9+dz/iH13l8zTuY7v0wK2QB07LtD5iiWknas9uA/8b9naPFj1Pb/L9HHWRa3AnOk20b2pF9HtSNVoMvrJrL5RX//+diYonQk26t3jbRWWloVAKKIlj+MW2/KNhsSvvXTYvP4bbuooqQQhMO7KmkJVK+5kcu/Nrjfsqyio0y6RVyTJlVc1TIS7GX6+Fzmoq0CXM+kSN0/L9Y3POEQqPlnuPt9WjdJc4bgSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/1fPSud41Om/5E3Ev1OVsqEH9uR8RyQzS/KEtTOXIM=;
 b=RWrl6M9mMZbLzxUzk1p9nN3l9FELjiZNmrTCigNcR0hXgfzcdl0e4BXc8cz8NSy6BxBreprDHEO5suD5R0yIVgq60vtc2eFJOsSRfaxnnD9NwbErK7ZLHMOkN6NOHilHAUouKpS1gaVItlyZmM7fZqEyQW/qRT3TOI69URtvDwc7a6Ri86WKs29lH+sn5H5rf3UptRr6oHCOQdLQrGb0ezgDWPHpQ3ENaMRp50clroAwMy6h2Pp0CNyIMqOul3QNfzrt5sMSN54TRXuyj8zkGEStBVP4CKFML0Wvb8WBCTn4QyE+wLvW2ugndQ03nAt3ex/oga+9fSEDBNu4GrG1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/1fPSud41Om/5E3Ev1OVsqEH9uR8RyQzS/KEtTOXIM=;
 b=fuaUsuO7lAtk22zxw0wvKIeqaslMz9sBYH8b23qEyTKdd56lcyiW/WRglAmiOjWu5Bbnytr05+SYPyKqOc7VCvsfdXsVBTgjl3BgP0cKarJWTZO0Wsmti18CZFlmCD1z7WW9h7IEOaZoCD6Hk7IlWpYllLwtzbbNndHKO8e+545yEmHG20n+GrvMgigKwhZ9ewOEJ2pucSEVDj6JcttWTy2eY6TayRTqERLi/0FDR31GsDpbHDSslZk4z32jpjTN828jIv5yWXu4B/vMW9rCIfHHBeY44RZ/x5lOokFhq7uZcesBDEJaDIchs9dtREBQdtnTTa3d1poqfbyveV82sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:57:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 03:57:31 +0000
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
Subject: [PATCH v8 19/20] fs/dax: Properly refcount fs dax pages
Date: Tue, 18 Feb 2025 14:55:35 +1100
Message-ID: <b33a5b2e03ffb6dbcfade84788acdd91d10fbc51.1739850794.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0129.ausprd01.prod.outlook.com
 (2603:10c6:10:5::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ec670a-cb32-4a73-f08f-08dd4fd05e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lT2nX7dyGeKkn8SZgw0rPths4y2Q6uVtlq0DZw4eYtZ1Gx9J7DUJjcfRkOXy?=
 =?us-ascii?Q?kKedVf4/InSQ8gENT9TQIaIEdLOmoTUZmIs8BT2wiCLIijovxocpkngI3Ux4?=
 =?us-ascii?Q?25Um829W7vZY5XU5mUaN4BNiJnpu6/7iG8mvUghLA07oHoJCrLnljRr5IIGP?=
 =?us-ascii?Q?N4VuexjtA/FbAUvwCBdXJlfwilQltnIglRyAkkKEZJci13r8VzosC7D8lfRl?=
 =?us-ascii?Q?LGBDGxv57MUez63pl5iU3v5yaS1fJNDalz/rrwRsTEXglvnSbn4/RGPq388D?=
 =?us-ascii?Q?Tpzvp/8IkY9ukfkjiL6UUFVhpuREU4ox1kRlrbiQRSMcbxCNylYhaVJ4lQXk?=
 =?us-ascii?Q?i+R019kFUcP5SQw/JoekZraeMznUH8vrBskcti70vo/rc2buGtoSYRO7XKrv?=
 =?us-ascii?Q?lW6rkkdC370UOOZanmoUPclyO/5wF/YjUw24keccHpnmF8r060QtFwLKQ/FS?=
 =?us-ascii?Q?BPdBsglRtvdFklP5cSq2rZmEK5moePronVlFiF75mcLWEJfusdmdgqNqP/6Q?=
 =?us-ascii?Q?1MIxU2WuNZslwCbztcoQ/e7tjMiaseKW5insYs2HdQ/v9HYOByZIEXxMj5K5?=
 =?us-ascii?Q?MIsQRdJ/f/K1B5CoMEu213CwS0dos+EkhkoPyypVcZzmdEKUpmzs5YvC1iKp?=
 =?us-ascii?Q?TnRhpm99jqnUnb49qSn6O4BGGPGxbZsndTJ9vPVfVeD0cvRiKzGNGBBWoc04?=
 =?us-ascii?Q?tzvHSDTxd2zzxVRFR0lMD94iaQ5CwZsdxCQI+TNVQU0glnHGfjOJ2lgBCdUA?=
 =?us-ascii?Q?39pb4sLs3Si6m5eo+ofMXRRaZUMMd6GHkxRi/kGFvSxUfBcL3cGSZKBG8Vk+?=
 =?us-ascii?Q?OdxKdvMtrvhKxOeJQ9b8VshfpYLfpPhO7nErV+rLWKq/Tp6XasbltgTerIEd?=
 =?us-ascii?Q?T9rdkub7gA+/gZgVT+ByDKWeLcDph7x1YhVgbpbTZjF7FD6lQU4KZp5NDEY6?=
 =?us-ascii?Q?iX5c6Y3hLFGjNRO5KWK32oTHhrY9pexsEAoQ3fzLKhDQFN/MJZS4YT2ZG6Nl?=
 =?us-ascii?Q?L1jK1VuhFkG+1f1hTTGeZkQhyF87MzkuM4rdDWBBPpT6pL1xU6NdDLRaeyZu?=
 =?us-ascii?Q?C3cDWNLFoQK0MSK5DSYWmf9WURz/0XVYI7fSF062DUkTuK2ZKgHO6lx9ybh0?=
 =?us-ascii?Q?sAvNU7AWP79kdcKCcv/mJJolf3wwFb6FUtgxtao2zjXWNmqlC8PHYn2zqN6x?=
 =?us-ascii?Q?rAxVvmkgFxIb0XsnyKhKUT72DyeS22DK1ljfpopVBFwTQtCL7MeUk2XFtVDV?=
 =?us-ascii?Q?cSvYl5nbDdrFQKVxL1wj2RNOuR5V/9TVRvFOFctMOSHKv/veef42PG04wm9H?=
 =?us-ascii?Q?iQ4y5IWCFI8gk1GINRmw50gOWxD7YyBn3ndjP2KTFkp8k6Ay3BnTf7UyCFLn?=
 =?us-ascii?Q?fa4GDYn7VqLReJQA7qfxku+4Og5Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t37JW9IUz4YVBNSCtYtCqZ0MKMdGFQVaNczASiXE5zKNsBtsCmbz4wj4AzMA?=
 =?us-ascii?Q?qNJXDVf8hoKem5epG1h0WKTYzsh9GkAohxMCJbNctWS3imHG4WjJqgQa6wxC?=
 =?us-ascii?Q?BgjtZGriewi4S0dXGrJQixP3KIFt8iu9hl4+4ypjX7zIRugscfXYzUJzLrK3?=
 =?us-ascii?Q?cstF3dJTaDRh+sn5icJGWQBgzZ7k7d38Z4SW1+8BO3oSmlFguLrSf65oZzLQ?=
 =?us-ascii?Q?Jk1W2bppK+YqRL2nk+cEQESxjqJ/yxKxjkeOrvMeDTenLBG4sPcCem7WKJan?=
 =?us-ascii?Q?LXEpJY+OYoAL2TkItGQtQ9YkfmqfiGZkEkp8lw9qJaj/E76adxWBBL1AQQuA?=
 =?us-ascii?Q?nn21kINM9UX01OzRruBnvItKDkUyhyapdIpDKw6PoDtkdbsZVuqHNZCbKgzY?=
 =?us-ascii?Q?vSeWg822ll2ifounFiohAzOP5MKJ2+NXFFNMDf6hVaRED3msr1asTS8vepa3?=
 =?us-ascii?Q?0Vi577LF0Mq/fjwtWytqxZHGqqiim1XgOErF1upVTwMC/qEqEro/lifERxnQ?=
 =?us-ascii?Q?HcM/xH+lqjbB9QwNON7QJN6pPIfyt4PY/ztOcTOIIAfJu/MofcCbyyTBOGMG?=
 =?us-ascii?Q?m+HwgdEDVRAgRY50xrgyJXLAPWjJRW5g6n8ENrguXa08w9MNVobgGY1k+Rtl?=
 =?us-ascii?Q?EhifPnwoA/eXwgv6fvMSl/T1aqo8DaaA349Q6kJR3naVT51z3GKoQW+xY7bi?=
 =?us-ascii?Q?lHOWDhj9mjO99QcpGieZH+KEvbu9UKfrcNFLKpI69lvh7haFGFySuQK4EiZ0?=
 =?us-ascii?Q?UH6K1f4FB2/P3H4Qym+9/cUjBRq42D5ih0y6Ko55o9MP0shUkU5E/gdy5gB0?=
 =?us-ascii?Q?Yisur7+rWKbbWo/iy9cTG//AUT07S5ZKLICAw82N96nXet0eIMWcOAB6w5OZ?=
 =?us-ascii?Q?fRbchLEVRh6ny3pvj5HFfkNpPVmY26zGhm6LQE/Bbef31u8ONM0TjWvQiuiO?=
 =?us-ascii?Q?YxoAm93FGrBXnyqcxoRnRkqXlDnybY5i3uFBwp79rjvfHbUZTlca2Q/KnyVg?=
 =?us-ascii?Q?2XTvUFKSoc94osfn00ogGbJ7qXePKl3an22M3TkJqNmt5pk7LjnjEvR2844M?=
 =?us-ascii?Q?dJFpN72IUOALKQnBUtAc0j4+2YFcbY1Qsg0XKhI1Ie2tTXm2KTVWK0u7LTAD?=
 =?us-ascii?Q?kwvDHKYCM5y2QGGMtFThkCkYB7/662kLdquOk8E80LYA1u7A9sr2MLRkUIQO?=
 =?us-ascii?Q?MgmA/SXRvrlYnEfrsgCqI7IiMYH9aBRDabKA2NOF+gyV3tK+hn7vUp+gdt3x?=
 =?us-ascii?Q?44JXFuZmMNkGUfJeH04GoKsQPxm/Owi7F9xC8Nwc+DIQr62FqdoO6nZV9fwM?=
 =?us-ascii?Q?JE0440LIVf2dyzUXar0vbdRd/p1gNKHU+gouJP5p5s2xAYKONylinkPj5pn8?=
 =?us-ascii?Q?AN0Mx6DiEq9bFaPeiVzdzX/PBRH0tTJ6gw3Ww6lkK2VsawfYadzIJlsrOsoq?=
 =?us-ascii?Q?Uo+94gJdGhjAM7fe9mXqCKwWG35DgeIxz4vY8tUncSvJ78UXLECm9dFSVbqG?=
 =?us-ascii?Q?/UAqdkeubpEqBQHZztVtyYafPwM58MESYZysCV+aSjRFB0vs/TQXcQJNzWwF?=
 =?us-ascii?Q?miOSmPX106KNiMYlGrBTweHLRhlt2vLjPsjNpjxW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ec670a-cb32-4a73-f08f-08dd4fd05e90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 03:57:31.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYNFmMTyH4bHQuIrsxDDO7scI+IED6nwsR74WB3rN0Wy7zrLnVjrR5qCliAw2JrF+z1Kf+S59q5Y+daL9LEYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

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

Changes for v8:

 - Rebased on mm-unstable - conflicts with Matthew's earlier changes.
 - Made dax_folio_put() easier to read thanks to David's suggestions.
 - Removed a useless WARN_ON_ONCE()

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
 fs/dax.c                 | 186 ++++++++++++++++++++++++----------------
 fs/fuse/virtio_fs.c      |   3 +-
 include/linux/dax.h      |   2 +-
 include/linux/mm.h       |  27 +------
 include/linux/mm_types.h |   7 +-
 mm/gup.c                 |   9 +--
 mm/huge_memory.c         |   6 +-
 mm/internal.h            |   2 +-
 mm/memory-failure.c      |   6 +-
 mm/memory.c              |   6 +-
 mm/memremap.c            |  47 ++++------
 mm/mm_init.c             |   9 +--
 mm/swap.c                |   2 +-
 14 files changed, 165 insertions(+), 151 deletions(-)

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
index 6674540..cf96f3d 100644
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
@@ -338,19 +343,6 @@ static unsigned long dax_entry_size(void *entry)
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
  * A DAX folio is considered shared if it has no mapping set and ->share (which
  * shares the ->index field) is non-zero. Note this may return false even if the
@@ -359,7 +351,7 @@ static unsigned long dax_end_pfn(void *entry)
  */
 static inline bool dax_folio_is_shared(struct folio *folio)
 {
-	return !folio->mapping && folio->page.share;
+	return !folio->mapping && folio->share;
 }
 
 /*
@@ -384,75 +376,117 @@ static void dax_folio_make_shared(struct folio *folio)
 	 * folio has previously been mapped into one address space so set the
 	 * share count.
 	 */
-	folio->page.share = 1;
+	folio->share = 1;
 }
 
-static inline unsigned long dax_folio_share_put(struct folio *folio)
+static inline unsigned long dax_folio_put(struct folio *folio)
 {
-	return --folio->page.share;
+	unsigned long ref;
+	int order, i;
+
+	if (!dax_folio_is_shared(folio))
+		ref = 0;
+	else
+		ref = --folio->share;
+
+	if (ref)
+		return ref;
+
+	folio->mapping = NULL;
+	order = folio_order(folio);
+	if (!order)
+		return 0;
+
+	for (i = 0; i < (1UL << order); i++) {
+		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
+		struct page *page = folio_page(folio, i);
+		struct folio *new_folio = (struct folio *)page;
+
+		ClearPageHead(page);
+		clear_compound_head(page);
+
+		new_folio->mapping = NULL;
+		/*
+		 * Reset pgmap which was over-written by
+		 * prep_compound_page().
+		 */
+		new_folio->pgmap = pgmap;
+		new_folio->share = 0;
+		WARN_ON_ONCE(folio_ref_count(new_folio));
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
+				struct vm_area_struct *vma,
+				unsigned long address, bool shared)
 {
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+	unsigned long size = dax_entry_size(entry), index;
+	struct folio *folio = dax_to_folio(entry);
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
 	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct folio *folio = pfn_folio(pfn);
-
-		if (shared && (folio->mapping || folio->page.share)) {
-			if (folio->mapping)
-				dax_folio_make_shared(folio);
+	if (shared && (folio->mapping || dax_folio_is_shared(folio))) {
+		if (folio->mapping)
+			dax_folio_make_shared(folio);
 
-			WARN_ON_ONCE(!folio->page.share);
-			folio->page.share++;
-		} else {
-			WARN_ON_ONCE(folio->mapping);
-			folio->mapping = mapping;
-			folio->index = index + i++;
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
-		struct folio *folio = pfn_folio(pfn);
-
-		WARN_ON_ONCE(trunc && folio_ref_count(folio) > 1);
-		if (dax_folio_is_shared(folio)) {
-			/* keep the shared flag if this page is still shared */
-			if (dax_folio_share_put(folio) > 0)
-				continue;
-		} else
-			WARN_ON_ONCE(folio->mapping && folio->mapping != mapping);
-		folio->mapping = NULL;
-		folio->index = 0;
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
@@ -785,7 +819,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
-					  pgoff_t index, bool trunc)
+				  pgoff_t index, bool trunc)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	int ret = 0;
@@ -953,7 +987,8 @@ void dax_break_layout_final(struct inode *inode)
 		wait_page_idle_uninterruptible(page, inode);
 	} while (true);
 
-	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL_GPL(dax_break_layout_final);
 
@@ -1039,8 +1074,10 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				shared);
+		if (!(flags & DAX_ZERO_PAGE))
+			dax_associate_entry(new_entry, mapping, vmf->vma,
+					vmf->address, shared);
+
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1228,9 +1265,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		goto out;
 	if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
 		goto out;
-	/* For larger pages we need devmap */
-	if (length > 1 && !pfn_t_devmap(*pfnp))
-		goto out;
+
 	rc = 0;
 
 out_check_addr:
@@ -1337,7 +1372,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn), false);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1808,7 +1843,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	struct folio *folio;
+	int ret, err = 0;
 	pfn_t pfn;
 	void *kaddr;
 
@@ -1840,17 +1876,19 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
+	folio = dax_to_folio(*entry);
 	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-	/* insert PMD pfn */
+	folio_ref_inc(folio);
 	if (pmd)
-		return vmf_insert_pfn_pmd(vmf, pfn, write);
+		ret = vmf_insert_folio_pmd(vmf, pfn_folio(pfn_t_to_pfn(pfn)),
+					write);
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
@@ -2089,6 +2127,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
+	struct folio *folio;
 	void *entry;
 	vm_fault_t ret;
 
@@ -2106,14 +2145,17 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
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
index 066aebd..7b21b48 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1192,6 +1192,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+extern void prep_compound_page(struct page *page, unsigned int order);
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1513,25 +1515,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
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
@@ -1646,12 +1629,6 @@ static inline void put_page(struct page *page)
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
index 6f2d6bb..689b2a7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -296,6 +296,8 @@ typedef struct {
  *    anonymous memory.
  * @index: Offset within the file, in units of pages.  For anonymous memory,
  *    this is the index from the beginning of the mmap.
+ * @share: number of DAX mappings that reference this folio. See
+ *    dax_associate_entry.
  * @private: Filesystem per-folio data (see folio_attach_private()).
  * @swap: Used for swp_entry_t if folio_test_swapcache().
  * @_mapcount: Do not access this member directly.  Use folio_mapcount() to
@@ -345,7 +347,10 @@ struct folio {
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
index e5d6454..e504065 100644
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
index d189826..1a0d6a8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2225,7 +2225,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 						tlb->fullmm);
 	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_special_huge(vma)) {
+	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2882,13 +2882,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
index a978b77..1e4424a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3827,13 +3827,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
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
index d0b5bef..5793368 100644
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


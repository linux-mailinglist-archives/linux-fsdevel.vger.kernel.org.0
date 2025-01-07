Return-Path: <linux-fsdevel+bounces-38529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BF7A0364B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0BB3A55DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F31E9B20;
	Tue,  7 Jan 2025 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AiFsST9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B091E8837;
	Tue,  7 Jan 2025 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221439; cv=fail; b=fB2+mOBpU/BhjAicHAA1BxIYxw5QWR1XzReC2NHqKeYFau3LnNpy/7Vs/S6I48lpMwA+FR+qqC3OhOS5Ldf3X1Wp5lJSS3W85MVNHYuiGCq48b9/zRwmEti8DTXxJi69+y4RlKE8TnwJTmd2+4b01tObSM15k/5c64qDn87BPio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221439; c=relaxed/simple;
	bh=ZWO5wkQ4gT6pArSvWzIa9XFRDsmGAuf7RKvqTO/MErE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpQaNFTmqrsSiPPly+ipoBL//3rcrbP0X/bLak+jOiGRs7xOR5pzUSQhr0RkeCrqYONGadnQzHPMipAus+2oaX4j2etkJpit7VckK1OvPoth4Swvkw4mp7XO9nla1AFKpC5zltCN5vjeL9pPUtLaqXW+RrDykgzzR5bM91lG7eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AiFsST9Y; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEpo9b+whAeQmZVRDMzSNPMQpBRPUOV2lzptBr8Eoh2/K1jtWPLF4MPO3t3zdEvieLxr46k34YIDlQAtiTJwf6ywijFgW8S8gzBOI2gXiDUnqEgzUqB7IVSZVP2fzN+iRGp3qvI2NlFNVgJxgBUTun8OSrjCNO6Pa8km50l7inkBitzCSKZnQg5411nZVTUUg5UAnsz3eNVKy7QlSt4yMuAhNJnnbmtggzJMspUPdbBWnUmW2niCx4dlBEQgGm74szNBxo4ITLSK+piBh0tkZ9XOqB43RS81F/ngtb2l022LuUAgQRaXvCY+F0xPH5pHmvioFEv1uR+BWnB3fqsNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbvWzssPrT9FZMJZBSAKYh1TA5jh1lsqkg7Zp8OnHfg=;
 b=IQSK64mX8OAeY1W774uDMgjdFzJno4Fas5zqbNmnNhdE8+LCMpyANI8MvIvN5A44Y8R6h10LAvtJL0Oe38CiwhANTj02p74lNTI387IzLnbScSbvL68y5N2p3pR70+T2GCMtJBBYBZC2MEbwMbSICQnbcrfXE8zhQ1rE5m4/dYeAxemdy59OqaSu0wvJ3MiD/uagT+RJaeQX4IlGmloaZg1Tb0wuatKILgCOoKnLr96L4ZScLWj2eZ5FZBeRS3OssR9Ty4pXi9h705Flwo2JabbpFlIpKFNRdVx1SoizBE7nbde/CwRW0YVf52UENbpzLYMwHl4crLbied2il39Pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbvWzssPrT9FZMJZBSAKYh1TA5jh1lsqkg7Zp8OnHfg=;
 b=AiFsST9YxIMGd7AbntELXekb8HVdy4+GStbfAU+Q2pBJ3krq0gOF6PgitJSasOO8pTFVE9tao7ACodun+RjyF81onKV9N/sORP/3k1CItkArZlc3fFqzOfi/vaD1vd9C0GggWDK3426b1Os2iVaCAGxzNtMNgKKU4QZNWYcru8G9GDaa6mUhpocmDkCGWC/LWq4adBz9DCMqBuM6hGo999AvGWv+BLN1KlrRDjomyVqKLAGQAWl3BnRtStqjj9nJwGAcwRPyvnYZn98RlBxAF8vUyJXREX+m0uiB5KzRiV5fyH9tHv+39hbkeWw/I/O2oc2HzUzNg7Lt3dWbtAhmlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:48 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:48 +0000
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
	david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 11/25] mm: Allow compound zone device pages
Date: Tue,  7 Jan 2025 14:42:27 +1100
Message-ID: <44b7d349c99525f411157df7f76897032b11ebaa.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0003.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a2beb0-c50e-45ce-c714-08dd2ecd7e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rkWG+9Q6kxbuscT0YJqy5yivEaq5aSXF6EuPSjk/kYE6b+baWg0Zb6YnkOjH?=
 =?us-ascii?Q?FyNyvqcv/T+CilQLWDVkZN+T06P/RTAqgF/rPHRNXdGxqZrHQQ1VFWufd0LH?=
 =?us-ascii?Q?X4poEXJgmsQKXaVeExDNPtEQMah80ptPx28iHU8F8Gvp5lwHZn9ee0N+bxQ0?=
 =?us-ascii?Q?cfMy6oZ70UHeMt6pDyFjuxImOTkko9w2umidGxOybsyuGjzhhgFR1x6TqT7K?=
 =?us-ascii?Q?e0qBXFpAp9pUcO/a34lwjkcLfDMSLbgkPVwz72BYnukJw2DKWW88LupZzLM6?=
 =?us-ascii?Q?ylXEkb4Bq7D7eUXa0w7e828RhsaJDq4jF3Az2kvOSZHsrFevwae9SuZrianl?=
 =?us-ascii?Q?crYR97X7QYQC3t5DPs4K+F+UKF/jR2nvucg5s25fQFOQVAlGqRzJ0yBCtKVP?=
 =?us-ascii?Q?jDh60R2aD5aaJ9JoXY6mPB6FZG0kF1xSmBB0dOREjztvft6aSM2zdTxkz1Qd?=
 =?us-ascii?Q?mritrq2iQLa919CmmJFCH4oCgET1JrPRTor2R2AZJwnO4UYDTWT0EIDWkQho?=
 =?us-ascii?Q?bU4uWYta5neiy4VJYn2C9SAxSCMtHlVfIWDYEVdxGk8v4jqcZhFckvTyClky?=
 =?us-ascii?Q?IBLzQkUBKjj8BX8QmrTwfAU1isOP7nFNvooXMnwdd5fyWCxLstvqXrCQqkOW?=
 =?us-ascii?Q?TP02Saz2qEvKbys1++b+Gy0Uu8lINqZvS8TeAP53K6FaRS+k0LUH1v6Ju24m?=
 =?us-ascii?Q?DcQ3V2XxVsIqvHDAg2gxydaMOgmqzkaYYCg++4ug83CaVHf54LcFkswofEj4?=
 =?us-ascii?Q?kYQ9QBYFSWHog14BB1zk23EWfeb4m1KrerLoggfEVrWPeXO3dVASPz0FCLG9?=
 =?us-ascii?Q?RYgm7aarFC3z8PV7pxZEanp7DhVpOaoNEiRoF91v9u04VtjdmZKp1W5ycJzx?=
 =?us-ascii?Q?RttFnxnulEX2jdFMmTJxuo0wKzAoRbk3a+cv89GrOSAwthC5cho5Fx8qzv+H?=
 =?us-ascii?Q?pc+QPhYwmPzqRfkWPsKDdLIHBcORmw6r2Vd49ulmDm71VS6qjqMLO6LJ6NgZ?=
 =?us-ascii?Q?vNzK7A70yRICk7Jn5fFt2ISRxuvpYnxFH0zm55fQkKiO9vz6MJ6YcnPI78Zg?=
 =?us-ascii?Q?tRzfBRn+LOI5dmxp0060KV5op6azYjrJTRbo9hUfAihdHH3M4nvI/uVqKc2z?=
 =?us-ascii?Q?cKvC908nfdrgcz18n87HNqA/AsiQC6lKRhykYsgFYWt/jYDmHaw4birdpPNL?=
 =?us-ascii?Q?RdCw8iI+oTWCDonz0XdHp3x1LTaD70rK1v1FLswp0m6eRUcoKOIYU3XMMs7+?=
 =?us-ascii?Q?H/d7rgk2coZBojKpP/Fl8lzvSwh5uJwdVL1ILH0SYG/0bK98FX5jrtrVIUJt?=
 =?us-ascii?Q?cw/HaM44xVa4hGIZHB44ad7o22+GymnKmcx53DcY6goOfZGWAg4hEdx5vrtp?=
 =?us-ascii?Q?Gxde0o/nPY6nuMo+IZNTBJNlGiis?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7IdayU1Z+NrRW9EVPOsFtluREPp+N0I66E4Rsv8zsewbnCtd1frOtQqn8PP?=
 =?us-ascii?Q?vvJiqc92LONYOEC5oOjukiVrC1IrShbv5aNdCDyheVWqij8pX6F3Q7jwnGA9?=
 =?us-ascii?Q?8xBNmulSkh4RN61NSv8jJz1goJaKW1MQ/qpaUvLQYNjMIYzOGeZMby1CJFL0?=
 =?us-ascii?Q?UZeZviVJhKBRF6UjU95j5Csgnj//xvNuKrYVvWJwHDdf9Q2oPUWA87ceBJHW?=
 =?us-ascii?Q?j2xwZatMNn/9fchkjyVK7qx9713jEwgvyEiWPANgk14A0P33BwW54cKjXAJT?=
 =?us-ascii?Q?O9u2X41/Ryo6XYa3JVmEfzXT6iQeCNz71yeI/gHP3IF3hlpn35ZiKOeMy84w?=
 =?us-ascii?Q?D755O2uRxzMH67N5ts8xuAnxf+xZdMR2xdl4z53HpOGBDB9ywBT45J/l+cc2?=
 =?us-ascii?Q?s1cSryE6NoB0x7OAPURnKgEkcnzPJokMlgjuDDnnOAZgxDzYX0MGP+VsmRM7?=
 =?us-ascii?Q?Us1EkxXQ6vbthV7NAa/pw21HGLAMUv6QcnYySu3tCQ1BGFkP0lTEXymx2Eeu?=
 =?us-ascii?Q?s07RpgMvxP5Ba5X7h8c2j8lfe3b4XQimlkNywCtcVM0MRZ5FIoIuau4CkIX+?=
 =?us-ascii?Q?RnL5P0roz1u6/z5xnS3Dyrx9PisO+JPeMwN15V7mDLhtbDHghaWjNSW9dYqW?=
 =?us-ascii?Q?Vc1aylN7ohRiUrhvbSfLBvxJdDtMU5E2n8RyKDsvt3n1Ji1Unj9FP4T3syZi?=
 =?us-ascii?Q?o+NkzmnD8yPPvizzL+GJZ0PwrAGIk5Bjhu1l4Wp/V4L5z8AgO9h66hjm/TSg?=
 =?us-ascii?Q?Wr12wqIxvpf5mGAUy3kkPqEQ9fMhT6/q02jxddmfOWKiWHipHrKhYjlKZjSM?=
 =?us-ascii?Q?iVlhpa5GlKl+FyH/EZsEwPpVYzsj3EhY+VNNLF4styKOQdoV86SZpm2k54hI?=
 =?us-ascii?Q?OZ2KpkKy1qocNjb+MtpLhW7twy4p9zzfWCwfe0xqY5RDs8zyuZ7cgn5/zpld?=
 =?us-ascii?Q?b74WeBZed7fX7dXgTBFkyglfKO/+fxwk8zV2VK3IgMN0UYw+yd3LKssCmMpU?=
 =?us-ascii?Q?OzRbglpnbBHkkdGFwW/emNXzdTwCPWK0qqAMahO+w1o94eXP1kh7bEhs+vSC?=
 =?us-ascii?Q?IvGPUgkDr5LlEgXcOOmaRtcKWAZVDuKRYS+GYh5Z8tHi8TIPrEDxLBh+PScl?=
 =?us-ascii?Q?v3vhXe6J0zRyob4L7Yg5ORRMnH3mlvt1DYYxuB6P5lCrpqgoKmlcZMZHEbAg?=
 =?us-ascii?Q?YSPmboWNflIcDKCrvoBMkogfsZUWlMTQngVQCErKlspp5SgMY/SCwC5EPc/S?=
 =?us-ascii?Q?SD5x3/9Ij3PUIxX5UCtREh+UcOzJPAdtvqq+1wg21EEav+fYfIPgbBFb2wkL?=
 =?us-ascii?Q?rzYJdWKQLK9OGVfPiAVQy/QiR4weWXYccyh66bC2c535PoDMK3a90HfpIQlr?=
 =?us-ascii?Q?HA7dmAFL8vMICLJiDD/iFf4mueMFRhCfiBYvSbMwTbO6qOYhsLI3/qpTZ+nV?=
 =?us-ascii?Q?eOaZ3fI3rSGBCy4/JQnMGRlqzxNGrWcrX0Sb4AuvLlj/+HswyqcUFr3Tz3xq?=
 =?us-ascii?Q?RqOpcMjyUntXsYwGOeDrGQlJByJ/PSxrYtS3ss6b2TjWideRSxflPHHXzGV9?=
 =?us-ascii?Q?PXAF/xKRGnu+a7yDa5cDZPc08WnadZ4k2IYZQxn5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a2beb0-c50e-45ce-c714-08dd2ecd7e9f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:48.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+/6ueXCHteVl2Ae4dumoC8BO5DLHfSTAxgpWt81JsADTbygzMmyZBhfWynz+YFWlAxqGbGtRKY82YIOgAq2Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Zone device pages are used to represent various type of device memory
managed by device drivers. Currently compound zone device pages are
not supported. This is because MEMORY_DEVICE_FS_DAX pages are the only
user of higher order zone device pages and have their own page
reference counting.

A future change will unify FS DAX reference counting with normal page
reference counting rules and remove the special FS DAX reference
counting. Supporting that requires compound zone device pages.

Supporting compound zone device pages requires compound_head() to
distinguish between head and tail pages whilst still preserving the
special struct page fields that are specific to zone device pages.

A tail page is distinguished by having bit zero being set in
page->compound_head, with the remaining bits pointing to the head
page. For zone device pages page->compound_head is shared with
page->pgmap.

The page->pgmap field is common to all pages within a memory section.
Therefore pgmap is the same for both head and tail pages and can be
moved into the folio and we can use the standard scheme to find
compound_head from a tail page.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes for v4:
 - Fix build breakages reported by kernel test robot

Changes since v2:

 - Indentation fix
 - Rename page_dev_pagemap() to page_pgmap()
 - Rename folio _unused field to _unused_pgmap_compound_head
 - s/WARN_ON/VM_WARN_ON_ONCE_PAGE/

Changes since v1:

 - Move pgmap to the folio as suggested by Matthew Wilcox
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  3 ++-
 drivers/pci/p2pdma.c                   |  6 +++---
 include/linux/memremap.h               |  6 +++---
 include/linux/migrate.h                |  4 ++--
 include/linux/mm_types.h               |  9 +++++++--
 include/linux/mmzone.h                 | 12 +++++++++++-
 lib/test_hmm.c                         |  3 ++-
 mm/hmm.c                               |  2 +-
 mm/memory.c                            |  4 +++-
 mm/memremap.c                          | 14 +++++++-------
 mm/migrate_device.c                    |  7 +++++--
 mm/mm_init.c                           |  2 +-
 12 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 1a07256..61d0f41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -88,7 +88,8 @@ struct nouveau_dmem {
 
 static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+	return container_of(page_pgmap(page), struct nouveau_dmem_chunk,
+			    pagemap);
 }
 
 static struct nouveau_drm *page_to_drm(struct page *page)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 04773a8..19214ec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -202,7 +202,7 @@ static const struct attribute_group p2pmem_group = {
 
 static void p2pdma_page_free(struct page *page)
 {
-	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page->pgmap);
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
 	/* safe to dereference while a reference is held to the percpu ref */
 	struct pci_p2pdma *p2pdma =
 		rcu_dereference_protected(pgmap->provider->p2pdma, 1);
@@ -1025,8 +1025,8 @@ enum pci_p2pdma_map_type
 pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
 		       struct scatterlist *sg)
 {
-	if (state->pgmap != sg_page(sg)->pgmap) {
-		state->pgmap = sg_page(sg)->pgmap;
+	if (state->pgmap != page_pgmap(sg_page(sg))) {
+		state->pgmap = page_pgmap(sg_page(sg));
 		state->map = pci_p2pdma_map_type(state->pgmap, dev);
 		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
 	}
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3f7143a..0256a42 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -161,7 +161,7 @@ static inline bool is_device_private_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
+		page_pgmap(page)->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool folio_is_device_private(const struct folio *folio)
@@ -173,13 +173,13 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 {
 	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
+		page_pgmap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
 static inline bool is_device_coherent_page(const struct page *page)
 {
 	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_COHERENT;
+		page_pgmap(page)->type == MEMORY_DEVICE_COHERENT;
 }
 
 static inline bool folio_is_device_coherent(const struct folio *folio)
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 29919fa..61899ec 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -205,8 +205,8 @@ struct migrate_vma {
 	unsigned long		end;
 
 	/*
-	 * Set to the owner value also stored in page->pgmap->owner for
-	 * migrating out of device private memory. The flags also need to
+	 * Set to the owner value also stored in page_pgmap(page)->owner
+	 * for migrating out of device private memory. The flags also need to
 	 * be set to MIGRATE_VMA_SELECT_DEVICE_PRIVATE.
 	 * The caller should always set this field when using mmu notifier
 	 * callbacks to avoid device MMU invalidations for device private
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index df8f515..54b59b8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -129,8 +129,11 @@ struct page {
 			unsigned long compound_head;	/* Bit zero is set */
 		};
 		struct {	/* ZONE_DEVICE pages */
-			/** @pgmap: Points to the hosting device page map. */
-			struct dev_pagemap *pgmap;
+			/*
+			 * The first word is used for compound_head or folio
+			 * pgmap
+			 */
+			void *_unused_pgmap_compound_head;
 			void *zone_device_data;
 			/*
 			 * ZONE_DEVICE private pages are counted as being
@@ -299,6 +302,7 @@ typedef struct {
  * @_refcount: Do not access this member directly.  Use folio_ref_count()
  *    to find how many references there are to this folio.
  * @memcg_data: Memory Control Group data.
+ * @pgmap: Metadata for ZONE_DEVICE mappings
  * @virtual: Virtual address in the kernel direct map.
  * @_last_cpupid: IDs of last CPU and last process that accessed the folio.
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
@@ -337,6 +341,7 @@ struct folio {
 	/* private: */
 				};
 	/* public: */
+				struct dev_pagemap *pgmap;
 			};
 			struct address_space *mapping;
 			pgoff_t index;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c7ad4d6..fd492c3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1159,6 +1159,12 @@ static inline bool is_zone_device_page(const struct page *page)
 	return page_zonenum(page) == ZONE_DEVICE;
 }
 
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
+	return page_folio(page)->pgmap;
+}
+
 /*
  * Consecutive zone device pages should not be merged into the same sgl
  * or bvec segment with other types of pages or if they belong to different
@@ -1174,7 +1180,7 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 		return false;
 	if (!is_zone_device_page(a))
 		return true;
-	return a->pgmap == b->pgmap;
+	return page_pgmap(a) == page_pgmap(b);
 }
 
 extern void memmap_init_zone_device(struct zone *, unsigned long,
@@ -1189,6 +1195,10 @@ static inline bool zone_device_pages_have_same_pgmap(const struct page *a,
 {
 	return true;
 }
+static inline struct dev_pagemap *page_pgmap(const struct page *page)
+{
+	return NULL;
+}
 #endif
 
 static inline bool folio_is_zone_device(const struct folio *folio)
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 056f2e4..ffd0c6f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -195,7 +195,8 @@ static int dmirror_fops_release(struct inode *inode, struct file *filp)
 
 static struct dmirror_chunk *dmirror_page_to_chunk(struct page *page)
 {
-	return container_of(page->pgmap, struct dmirror_chunk, pagemap);
+	return container_of(page_pgmap(page), struct dmirror_chunk,
+			    pagemap);
 }
 
 static struct dmirror_device *dmirror_page_to_device(struct page *page)
diff --git a/mm/hmm.c b/mm/hmm.c
index 7e0229a..082f7b7 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -248,7 +248,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		 * just report the PFN.
 		 */
 		if (is_device_private_entry(entry) &&
-		    pfn_swap_entry_to_page(entry)->pgmap->owner ==
+		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
 			if (is_writable_device_private_entry(entry))
diff --git a/mm/memory.c b/mm/memory.c
index f09f20c..06bb29e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4316,6 +4316,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			struct dev_pagemap *pgmap;
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4340,7 +4341,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			get_page(vmf->page);
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
+			pgmap = page_pgmap(vmf->page);
+			ret = pgmap->ops->migrate_to_ram(vmf);
 			put_page(vmf->page);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
diff --git a/mm/memremap.c b/mm/memremap.c
index 07bbe0e..68099af 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -458,8 +458,8 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_folio(struct folio *folio)
 {
-	if (WARN_ON_ONCE(!folio->page.pgmap->ops ||
-			!folio->page.pgmap->ops->page_free))
+	if (WARN_ON_ONCE(!folio->pgmap->ops ||
+			!folio->pgmap->ops->page_free))
 		return;
 
 	mem_cgroup_uncharge(folio);
@@ -486,12 +486,12 @@ void free_zone_device_folio(struct folio *folio)
 	 * to clear folio->mapping.
 	 */
 	folio->mapping = NULL;
-	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
+	folio->pgmap->ops->page_free(folio_page(folio, 0));
 
-	switch (folio->page.pgmap->type) {
+	switch (folio->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_COHERENT:
-		put_dev_pagemap(folio->page.pgmap);
+		put_dev_pagemap(folio->pgmap);
 		break;
 
 	case MEMORY_DEVICE_FS_DAX:
@@ -514,7 +514,7 @@ void zone_device_page_init(struct page *page)
 	 * Drivers shouldn't be allocating pages after calling
 	 * memunmap_pages().
 	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
+	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
 	set_page_count(page, 1);
 	lock_page(page);
 }
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(zone_device_page_init);
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_folio_refs(struct folio *folio, int refs)
 {
-	if (folio->page.pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (folio->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9cf2659..2209070 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 	arch_enter_lazy_mmu_mode();
 
 	for (; addr < end; addr += PAGE_SIZE, ptep++) {
+		struct dev_pagemap *pgmap;
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
@@ -133,9 +134,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 
 			page = pfn_swap_entry_to_page(entry);
+			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
-			    page->pgmap->owner != migrate->pgmap_owner)
+			    pgmap->owner != migrate->pgmap_owner)
 				goto next;
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
@@ -151,12 +153,13 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
+			pgmap = page_pgmap(page);
 			if (page && !is_zone_device_page(page) &&
 			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
 				goto next;
 			else if (page && is_device_coherent_page(page) &&
 			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
-			     page->pgmap->owner != migrate->pgmap_owner))
+			     pgmap->owner != migrate->pgmap_owner))
 				goto next;
 			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f021e63..cb73402 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -998,7 +998,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * and zone_device_data.  It is a bug if a ZONE_DEVICE page is
 	 * ever freed or placed on a driver-private list.
 	 */
-	page->pgmap = pgmap;
+	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
 	/*
-- 
git-series 0.9.1


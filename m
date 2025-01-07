Return-Path: <linux-fsdevel+bounces-38528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F228A03644
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 04:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8758161188
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631A1D95A3;
	Tue,  7 Jan 2025 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TKHD+g0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891631428E7;
	Tue,  7 Jan 2025 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736221435; cv=fail; b=qnZkvGls19Ca70wya1D6T3E4K0y6lSR4Zs+2BrVjZPqPQWHTrMEQ/suqa9ugPlGttthhPZCb1NlxnQRC7wktTKC4ySdbcVP3f5KOJleg5PVj4eoXV5PKcmyc1/aXXPW4ZHrQ9BltEEuG+9Jznr78vHTnwPkwKOM/vPJQgu02v4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736221435; c=relaxed/simple;
	bh=/9nCN1XQPfgyA5VlyoRarJnrFqQw20cJtW1L8P7Lq0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvX8WGOqTmXFuB9CYkbbbYjgGEPeVNvEFfQfH5+IZv+oIZgeVo7AE6ymZb5PlTWqLmrfxbJZYxkoeKqbNggnCj4A1GJsKgWJ6188RdOd1ynGYQyezGKA4aSULMJZB9qt6m10namgJDQniRv7NgdbuX5/hkRXSNSAD5jYXpw1yHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TKHD+g0S; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq+vuqMli1AZaBCWF/yN2ySit7658aLIwUNVi12cvDCUVZsDVphQemAD2WOFyv94Pjad+/FMnGJ6AoJsolFZVSufer2US2sZOZNrRBSIlX8sPjXvksSUbK71MgAkiz8OoUf4PIAo1llWfkZJ4u4gedHNYS5Y1HgRYWNbSHriMgWS2dL5u0ea50SS9EcQUSnElrwFeZ1YuGGdinyeTcC9tJTpfxGWVv4M0WGOjSByXZO6zErw3g5nE3mWH2q+YrXmH9lkSpcUskl9IDjD6jpNdzyC1R7GtIvW5wNzvmcIcRlyoVV4+mSjsBA37bpuBPc9xpSJAGKKPO4FSQHmubcQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaSh+cBcmD4fAyVgZBd8ptmSZOPC9ILTc9cpqUKZh8s=;
 b=IOAWR26o0OfT1l0BzN4ybi7SEQVwXB5lqstE6NyVTtj2FTOUxNVg9RtWayy2uQHSCq03TmIZFADVzRTKf+wRmgobaATffdu/JRRh77m01fxCO4/cyjdBBD8fuirgNM3r6UtfE1nrOob+5LX079l7AJbR8ElvkUnZ5hzJjgs1rcEvb4DrHAMhvmQX4gVEftGKUDE6pNsiwx7mJ9RBvsPvTkr6DmCPXkuPoNhMW/PaDUKY7I0P43MnSx3K4oOhnHYR4uQrZxrkYkHoxd2S33diaFGlruRsRUsEYYn4qVFrZ0XsQg/iclX1QXTSLmzNswcPl6EPQeNVzECgRNUzKG8BZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaSh+cBcmD4fAyVgZBd8ptmSZOPC9ILTc9cpqUKZh8s=;
 b=TKHD+g0SNdYbvoO2gq6nM6vG4nfpOv8y0b+DqEUQp9TIc18C+e69MDSHXBOstwj7Ks3LTJdnlowwEYWikZ+8kl43JbU6d5eohmFsUk8/dyT8XbrrYfreT1xPPQPORR8BGKexEIRvqcciOZcWsxunZMxGb+Cy49QrvkzPn//weiLCBiDER9bsHHzBysbiabYlbrYq6oEFDTzW6cM/yiSlDnPOyEVv1LDE/y38a1dAc+HZehE8e+tyRSBtIJhqvGS1W9sU2JpnTXDOCuL+/uqSZlfWC5UXGSIyrvh05ozdl2XzfrZFsCVgYsAPr8ju2p80G/1svn1EbtQhALLDGyjxUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.15; Tue, 7 Jan 2025 03:43:44 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 03:43:44 +0000
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
Subject: [PATCH v5 10/25] mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
Date: Tue,  7 Jan 2025 14:42:26 +1100
Message-ID: <09143f567302ccfe293972b7f20fc709fafdd8db.1736221254.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0006.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: c4deb8a4-01c4-4012-c6c3-08dd2ecd7bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4iESq1Z4rhX3Ql3n+LvizPFYGlXRZUMc2ty44Litcex14duFKoD8fGdTqQ1P?=
 =?us-ascii?Q?GFGiZcvQ8/APizVqfBT4qtfNtFABVuIh0eewE4p2S2mG8bFAI/bbecybt3CH?=
 =?us-ascii?Q?XtPMxbjLK6va3f5GS3wtpZKLauFQnnigelfxb14wmQgtzb0H8r9cswfffGZc?=
 =?us-ascii?Q?Ip/cQmWwTHZEsh/A+yDDsFTt1muen4vGdJPK7x8LK8agRPvkiCdKXPWW1LcV?=
 =?us-ascii?Q?a24nHdZju3zkncpFXs7gJVm97SPDHb3onYDy7VquuK1pfblPw3WdJnPOvdJY?=
 =?us-ascii?Q?vDdItVv0xHWuJdau0OP7v3Uku/uC7bMfHkRbr+bpY+Nh7v2vNTKx+vlqLHro?=
 =?us-ascii?Q?pzNsv4bP9JmN1s2vVxAoyvFtzwuFaMvnWCE0lNRqCOO2P6xQsyCHflShjPib?=
 =?us-ascii?Q?VsJgi8A5jopGXgdsuYyGSs4nvDMhiiuJy9E0/SuxNnXvUKlOfs+FoPul70k0?=
 =?us-ascii?Q?mqibj0ITb96HjnsEKt2Ao43uVh9KGDJuwUW1iYErYrbftQXbv/kpX8Md3/Al?=
 =?us-ascii?Q?v17x8++ARbeaHjQWIhnEAn6/FFFtbXGWbhsG2TAolHG7f64m4EpnUkxrOYr6?=
 =?us-ascii?Q?Q68Zazn/KYm9g4ePfze10Z0nQHVBWxJPijf82MluRT5ou+8auuii/42rppTk?=
 =?us-ascii?Q?SjDX/evJltKl923elEGLfcmFt6YRF+vKrPs0El5O34GzhXrt1FrUhFlg0+hG?=
 =?us-ascii?Q?9RjAUxXFXju4jWMgJNFULsTGW/keDUPHJY0z/GJyVRSpXOTM5nArw8OrfUId?=
 =?us-ascii?Q?w8bx2taO8HmwcrRtUgGCCyin++MgSVRSWOJKZQzZYKkWU9XRuq6fe3Zd4oYj?=
 =?us-ascii?Q?Tl7ta//HL9i2wHVr2JjQ7Y7sgq4Oz019EmibKX90LTp56q8EntD3Mq/ue9dB?=
 =?us-ascii?Q?TCgAwWueqxjfBnwwTQYdEjoEc+k6cKUZ4hdq1jvJGYMtbw37dqYa4/liLagk?=
 =?us-ascii?Q?HrqyYLbSNxocUXrHzJs+2uoVx8S7rJ3A6HqosAbmyDFJ3nmbMDo7HQxacMSc?=
 =?us-ascii?Q?wuCCQJOnG2vD3LS91pR9UEvtUvRBzD3CalP1cKCBTT3KNWMV9km7NdZN6ldw?=
 =?us-ascii?Q?KLUCNWHLxKC/Ua2itrNDXwh+3fTjYNKdEVbopybWzGhe+kw0b9LbmJrH1Bar?=
 =?us-ascii?Q?zOOb4S+d/WemHLwglLMW5bUAaGP+D1ZI8HQMWqt7H7WRZaqvTfBwCfYm0/E9?=
 =?us-ascii?Q?V3BtxIAkjpyfsGuuEpLGEr3BQK9X5zh70iN4l87zrip/AIEm9g1EzkFCZ/cn?=
 =?us-ascii?Q?3N+WDmBCaMpdvOWgsas9V2Hv/Z+Yf6lht33ptyoSlxdg7LR5oDjT22GWHJKI?=
 =?us-ascii?Q?V2gUdny1yYjc58zcXA6WJPk52SUpnKEkYXJOVZVJiPG1uDt5Zz8v/ZpRjC6o?=
 =?us-ascii?Q?5yn3ux9qFsXJgnB/r8lKVp7DrPyp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ro3cOpEq1xrKKIBERdDrSOlh8IhDR0sj2wAxf39XFnYd/1g4LVqU8Z108fDp?=
 =?us-ascii?Q?VrJgPZ0VjAj7M/mJkjdivC2nn3CPpR2t65Mgg5Avb6btZuQhLAX4qKnBmQO9?=
 =?us-ascii?Q?wlQcAbJt/dt5nlY1iqSWSWCBVLxUR2KqGB9J1z1nhM5ZPmhhdvlJt9yRkXr5?=
 =?us-ascii?Q?MMZB3SmXoTFU2buqj3rQABVCxaLEOoJeXOCtahNFPjxUbIVJF0rrMeSrLG1e?=
 =?us-ascii?Q?IpPNftLiZiE09dUMlxSLr48wX4yv/TyuoFCwyD3dHNQZNMkam2oCuXLo5ESo?=
 =?us-ascii?Q?CP9j7SsdL8ASdfOn+Qrx4PTknQPg+ekvgKMseAIx6F4uTnFcHaxxNEjEkEo9?=
 =?us-ascii?Q?gz+TYCUWVrICfm1ItjLykrTwuk3KTHWZ/br6HxNuOGGF3GeCJ66pIca96dLy?=
 =?us-ascii?Q?d5qbrGDoBaem4z1Ykp8timM5t9JOxiOW+XwJGHxm3+xfsIq1P2RmdsmrcYvC?=
 =?us-ascii?Q?bXLbUFLAj1raM/bvBQHeH8R2eWOCStkh1e8crwGix1r+4//DRamS5kySzME8?=
 =?us-ascii?Q?XGOPa6vaE1y0Q76re51Um7LxY2RhCwfAglukkyM8ju5oC9kgs3kau7BcJCP9?=
 =?us-ascii?Q?4WAdGaPTH35YtHVxK+GT7B8qSBU1QwRZQgMp+1K49yig2BvdGGV6HFM6b122?=
 =?us-ascii?Q?Ow+PWpU9DtKrQI5rPI64/Obv4yknabkefkDEn2F9D2WBFj+FYilCXNnY2JnH?=
 =?us-ascii?Q?wfDysWv03QjEit0FJnzEoZthQ63xQ/0MHyJfubcgwLG4vlKBCUPZeV97TjhW?=
 =?us-ascii?Q?OuORL3IUT5Z/4KT5HMGjuSkPUkf2sox3VKQNaF0rdlerl0DF2VbEw/sPIfj0?=
 =?us-ascii?Q?8UtUu7BmoyqmJQE6Z51vhKTMXv753KnDPhGk3H1lfhr67+0UmTDAG1jMedtW?=
 =?us-ascii?Q?Akz/clGpvluDTESHHOmDuqHUzArAfCPY/U2DFNXX6P/j9hGkmfbG0KQ/zi5/?=
 =?us-ascii?Q?KU1PbnUXctKw/w+o8hKbLCy03WTAjZy3qPAqAs/gsr0zPenW28Ezd5xHqu09?=
 =?us-ascii?Q?CPjzBTZqAr8MlizQpyXruXpk0FFLvzWGmr4TAkxzGnJcr9WAPmgII4D/slWB?=
 =?us-ascii?Q?iCMQd6LAh2m/nV1S+yjBebizp5Afsw0gKWga+AHgoNQHrYHUq0F7Ll1gTI8A?=
 =?us-ascii?Q?zzn2l57t5mAawvT442knMgRLvPejOrNI/0knNDrFT1/9th16H5dJ7fcSI2Jy?=
 =?us-ascii?Q?b7CvT+anOMFT4/dlgcZWWXfyHzCqnvacTz7MF00tUVHpciawtQPe6aMrBPja?=
 =?us-ascii?Q?AK3sYSqNB0VzkAmKC03esCYNzh8PttKhqSKCWq+wGVvfekbPtRElQvdc4vHP?=
 =?us-ascii?Q?J4kpw8/oR/rQiFNhiGV5+fEf4qB+PFosdmdvP6v3e2IUkB4imOOUeMS9b6Ku?=
 =?us-ascii?Q?wlevViiIWqyU8lYdnHdPw8HI1Oc2x0ayducBr8k1dgSG/yGIYXw30b1kfSbZ?=
 =?us-ascii?Q?S1vK2PTFAeunfqD3Gsil9RO3R0M618kV3oljNrjGeQd9XtC5r6rSusNT4DTm?=
 =?us-ascii?Q?8T139mCYHNmpReOfbx3wUvBASW80IzF0P4s29t4EdCM1AsJeDxnAOI8hTwYm?=
 =?us-ascii?Q?1YdQEWvLBoJEtkIg1CU+pNotJSc/KrpdFZjrjVLf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4deb8a4-01c4-4012-c6c3-08dd2ecd7bf1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 03:43:44.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGrMwJXxElKs9B6Dc023w6K770zYK8x1Ih0tJNT0B16ktVRNTj8XckNfbwEJnXWBjVnjZMb70dEWPewKmUmL2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

Currently ZONE_DEVICE page reference counts are initialised by core
memory management code in __init_zone_device_page() as part of the
memremap() call which driver modules make to obtain ZONE_DEVICE
pages. This initialises page refcounts to 1 before returning them to
the driver.

This was presumably done because it drivers had a reference of sorts
on the page. It also ensured the page could always be mapped with
vm_insert_page() for example and would never get freed (ie. have a
zero refcount), freeing drivers of manipulating page reference counts.

However it complicates figuring out whether or not a page is free from
the mm perspective because it is no longer possible to just look at
the refcount. Instead the page type must be known and if GUP is used a
secondary pgmap reference is also sometimes needed.

To simplify this it is desirable to remove the page reference count
for the driver, so core mm can just use the refcount without having to
account for page type or do other types of tracking. This is possible
because drivers can always assume the page is valid as core kernel
will never offline or remove the struct page.

This means it is now up to drivers to initialise the page refcount as
required. P2PDMA uses vm_insert_page() to map the page, and that
requires a non-zero reference count when initialising the page so set
that when the page is first mapped.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>

---

Changes since v2:

 - Initialise the page refcount for all pages covered by the kaddr
---
 drivers/pci/p2pdma.c | 13 +++++++++++--
 mm/memremap.c        | 17 +++++++++++++----
 mm/mm_init.c         | 22 ++++++++++++++++++----
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0cb7e0a..04773a8 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -140,13 +140,22 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	rcu_read_unlock();
 
 	for (vaddr = vma->vm_start; vaddr < vma->vm_end; vaddr += PAGE_SIZE) {
-		ret = vm_insert_page(vma, vaddr, virt_to_page(kaddr));
+		struct page *page = virt_to_page(kaddr);
+
+		/*
+		 * Initialise the refcount for the freshly allocated page. As
+		 * we have just allocated the page no one else should be
+		 * using it.
+		 */
+		VM_WARN_ON_ONCE_PAGE(!page_ref_count(page), page);
+		set_page_count(page, 1);
+		ret = vm_insert_page(vma, vaddr, page);
 		if (ret) {
 			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
 			return ret;
 		}
 		percpu_ref_get(ref);
-		put_page(virt_to_page(kaddr));
+		put_page(page);
 		kaddr += PAGE_SIZE;
 		len -= PAGE_SIZE;
 	}
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547..07bbe0e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -488,15 +488,24 @@ void free_zone_device_folio(struct folio *folio)
 	folio->mapping = NULL;
 	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
 
-	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
+	switch (folio->page.pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
 		/*
 		 * Reset the refcount to 1 to prepare for handing out the page
 		 * again.
 		 */
 		folio_set_count(folio, 1);
-	else
-		put_dev_pagemap(folio->page.pgmap);
+		break;
+
+	case MEMORY_DEVICE_PCI_P2PDMA:
+		break;
+	}
 }
 
 void zone_device_page_init(struct page *page)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 24b68b4..f021e63 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1017,12 +1017,26 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	}
 
 	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
+	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC and
+	 * MEMORY_TYPE_FS_DAX pages are released directly to the driver page
+	 * allocator which will set the page count to 1 when allocating the
+	 * page.
+	 *
+	 * MEMORY_TYPE_GENERIC and MEMORY_TYPE_FS_DAX pages automatically have
+	 * their refcount reset to one whenever they are freed (ie. after
+	 * their refcount drops to 0).
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_COHERENT:
+	case MEMORY_DEVICE_PCI_P2PDMA:
 		set_page_count(page, 0);
+		break;
+
+	case MEMORY_DEVICE_FS_DAX:
+	case MEMORY_DEVICE_GENERIC:
+		break;
+	}
 }
 
 /*
-- 
git-series 0.9.1


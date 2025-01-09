Return-Path: <linux-fsdevel+bounces-38704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E6EA06E16
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C24516736C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 06:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D574214818;
	Thu,  9 Jan 2025 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKCxxXUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3B207E1B;
	Thu,  9 Jan 2025 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736403317; cv=fail; b=PM0NTtO8UZjlc1gXcQOEqUbLq25SR1EqLr4jPNf0A8TR6ngguT7nwxBE/rXyu8VIZ2l9KZ1b/RQAgdxUznHxhreO6Bx+rRis1l8G8h8YAwOolIrG0yJ6+I6Ny6smt9Lwyuav9SZRFruo88NxjnvSX9z35WyNfyZdVmoRQtt4R4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736403317; c=relaxed/simple;
	bh=MUJKm5aiZMXeAHVvtp1E1QY1/5AaaMa42JlsCJux6PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KqrxWs517vCWCf8aEMovTorvXQaNkklqNpTKi5jsnx1td2DDLFe5LDF7aIV2nkQiX0m2pwDJSrL6MxjPtJkyRRMMUekkzCFj3Hi2prYBZnKV+paFe2OsKJlaS5yIY6D4En3LZ0yPTBPBlpUc+1DeVenOWs6Sbm5WXqIaureUScY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKCxxXUi; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtlAkoMnz0M8d69iVObmMtZf/1bmsbhClolILjPnFPXnFYTglDEIvIsjIvuIE1cLz4+jvaR3LoJBjPsoRzuBdDHJzIgV845QFdrbza/mkpqIwWMUGGKX24iy70JMIweCIsnzKsl6F05IhL+Rqn/JziABcbT5DSp9alZNILeNIMG1VRFPYZxE/dhHGiNNhwhgldXbJKi/qVPU9Xo3p/Wlibp4Vo+mbrGThn0awFaRF0J3897gzbHIQ8DlmRunDAQ/LdovFWZ2oDSOgvFPK0bB36tT+zh+h9vZabgbvIBde0rEzx95JB8V9Er/SS6038WAR7s9W4DrPe/Aim5CVlc77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERIxmGM9a+p/h/6+jHoi5HeAIot2ezYABWhQE2jq8Y4=;
 b=DGrsmTtIc4Mn5mE6ttdMxTRjR1SP6eVNKS25R4udgIuFpxID2bkk137IfpXe5PJJ/8DJ8ORIvAzgHURheMqCgcJIDrYKUU7y335jKtvXNCfMMRtsoUhP8uUPM0EOteWuTZi24MrL+ecRUZUeILVBwJpZCtXHNdlidfCL6vEDTkK92FGlp3Zt07CnJAl6Qh/CcpSmgBmTyHk+Hr0rwYnpAnKc0qrGkNY14MkgmDfjIbfaH/q+8uxLeCfJU3xYgAmJVEUBR8TQaHNnHKm1/L+TsC/o0lfjynzZLM0LsGoXVxtCnpLB1jYcKhU3R6S7npakzH+YLNB1h+dgM5K67+Q2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERIxmGM9a+p/h/6+jHoi5HeAIot2ezYABWhQE2jq8Y4=;
 b=aKCxxXUio2XEowEb1x0ZppG7nNS9GCySXrI/zouM3HHBLT2yZGigtMlDsqEIx+xeLr/VAV7Ddc054e2JgpjDoe2kQorGms4jZL6lfk3w2yfFob/zJxg59O2wBo7wFBnBOF0p59sXZ7TvO8khXBbp5YEy4i/qqE0/BVMCelPyNFjYIxSS2o73bAuPu/QEe92XtIcVUv8b9Q+OTkaR1+7IyjKXgrWWuVa5xTcsWtDwFs5iip94pBbs0Qg2PCQ47mT6Rn/iEtK2eL6eVVF/H8rrMv6RSLLOA70AMGvD7byUqVuqTss30WCTfh44SsC+/r1ESQGlTL90gevHG0OnJs0fNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 06:15:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 06:15:12 +0000
Date: Thu, 9 Jan 2025 17:15:06 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH v5 05/25] fs/dax: Create a common implementation to break
 DAX layouts
Message-ID: <lxz2pq2m4gqlovfwsmunwzfjq3taosedbrkaf63jbrxwwg6dek@7vbwtibeyh4m>
References: <cover.425da7c4e76c2749d0ad1734f972b06114e02d52.1736221254.git-series.apopple@nvidia.com>
 <e8f1302aa676169ef5a10e2e06397e78794d5bb4.1736221254.git-series.apopple@nvidia.com>
 <677f14dc3e96c_f58f294f6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <677f14dc3e96c_f58f294f6@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY5PR01CA0055.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f35ae2-a3e3-47dd-26c3-08dd3074f96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZhOQw1BrJtuI9iPMUrlpKDYuuEAsNx9Q/f4shPUtOBjjVbc8zSgb757Sp5ya?=
 =?us-ascii?Q?pUnUF3V/ik8U7YLHIRlnb6cK9KlmNNngSeDj2uCdvyHZ5/p3Jvxw4kPTE0n1?=
 =?us-ascii?Q?ZORaNqAgSMODdMOKrHMdN/S9nO6/mSHNQV0Gvu8bW/gozpekoQRJrX9Bq4tg?=
 =?us-ascii?Q?yGOUfMBkq1k4+XbIuI7FP/LfdKTLZo64sEZ3C9T32ulfVLRo0MdS2ORaXqtb?=
 =?us-ascii?Q?dqoziFRg6gIbNUHqlxDwogdvbomNE3gZnFFOkz7vaA02jPjCKo3ZAwmSwYCf?=
 =?us-ascii?Q?7Y8qZe+fqnj4k96+rdshcBezIXAy9a6bSUOj8l0n3dxajPXV+7azJl4yeNjs?=
 =?us-ascii?Q?qx1cDHgxV4qpjFRiWMwHdqv6mVRaNXc82G73ju7oFJsS988ChyBFJMmFoEHU?=
 =?us-ascii?Q?zhVMDrnP82AAStTfWHnOgE2WCotwPFER1G2t/vmsO06opThRS2w89jul5Sek?=
 =?us-ascii?Q?2jZuvKxtCergYeAH7iWTDhl09YZ/gzA7C/GKBw67lp5JIbB9FyGdtgZoIIo1?=
 =?us-ascii?Q?NCNkNShuowmCEdc/gtojlLM9VUiHMw1DoQYwHP9Y0+keA+fUtvm1SKKIsqiO?=
 =?us-ascii?Q?hZb2lZEXmlFG4+JZSxX0s77LmTK8GwkQXfz4NhrEd2nJJz9G2vSRf4Gk3V+m?=
 =?us-ascii?Q?WKo/01gZu1JzBLT/xvVVX7/3X/3vc/pTp/+JflZzoI0XjWxx7RnAlSwI+SP5?=
 =?us-ascii?Q?RbAIkVaG5OnUEn4Kl2P32JzGhh8NyGQ1A08aoXG7NxscqmKY6fgEKncirvVh?=
 =?us-ascii?Q?trZgwG/OI2LicDpLZNjiVaX3LGWrFZCTtGbGv5KFC4sZL4sWjxiUKBYHpdby?=
 =?us-ascii?Q?MYH2cDV9qjzFZL6ACpHPCy18WDRaT4zucvkcfbZ3q8RY8lpb5dHDsd9i4kk5?=
 =?us-ascii?Q?PKgynAg5Jq94Ke2qn/kTE/5e0WAzaN0XNoWaEXPw49EGLKtdaAw215ftilGI?=
 =?us-ascii?Q?AptWWukJhbOerpNBT230EelLCS54zxj/TMEQGOEFJOhktNCN8h5AGDdgf45R?=
 =?us-ascii?Q?+nFP3dvp4RVBu/Er0ThVTLes1mqFkA1r45Te1K/RiHoYd+6shbc+1mPR2sa9?=
 =?us-ascii?Q?MAzCB1QEA7lu0EoBek3GrUG0j2+7/BisEnih8ot816HpmHdlYeOJ7JWmRXUZ?=
 =?us-ascii?Q?aiNgjyPCFJ2c/D0css3bCLIYpS7rUIONdCiuELko+S0XlfFEBRU1yQVrVSJS?=
 =?us-ascii?Q?MBLe8qmcwMBZavaLF1yyHC7Cs3XeiA4HpbvVwwXJUq5+K2fR+9qywUCaXA5b?=
 =?us-ascii?Q?mlXjQ0Gw76IfjOYii6pcpCFsc7QP1a/JSvyxiOfzITKLC4NCs18Q0H44bbqx?=
 =?us-ascii?Q?VtgQ//7YqgPn7gXNE5q29wVPDyjlYJudPxAAeEZRw40ZLup565MLQTDTQSxB?=
 =?us-ascii?Q?R3mwFNxJmOdJmkm4w6VSjv0CfEzs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57S/eKU5obbamj9xYRvhucfkaQgocqLO0BRMkOeULPu4RzcQM1hIgjVYdiH+?=
 =?us-ascii?Q?tVqqZKHcelvs5aY39MkXyXbaGRLpPza0ccz1+roLMjhN5wPKm3MBKCcICqIo?=
 =?us-ascii?Q?hslCe26LrB4fs1hmi2NGe6lBw2y0GwNaHAPesmmUN/glqWHWdY4C2H2Iqc9a?=
 =?us-ascii?Q?FEm+Y+mKnY4S6+i4f8KtwOqelI60ESBxHrlCiORocqee9ojHIbXgt2obgU3D?=
 =?us-ascii?Q?uw/xkRjpPMHS7SagFeGa/Q+N3xR3UbD7jaoEG0QEDsc/is1QDDfn3vm2wFGm?=
 =?us-ascii?Q?syaUJDkF1dvmP6s02V/4COY0Ga0vxFYKvj1Q/xT3wTlg2wcv5Cr127GiFmiD?=
 =?us-ascii?Q?eVY0PVbpKdcTQPnvTNE4rq71i68TcWzNI+zyU74dlvyCMSJ/T2veAfGDG9FQ?=
 =?us-ascii?Q?ZuAgzO0XlXo/e6An74JQv6q7BdRufp14wFGiK5ypzXIcfYUWJOpJljJBCs2A?=
 =?us-ascii?Q?Dd6lmAXA1LCNKPVXjqXgl5iqI6q0rDISZ1SR/4Sj7SgS/lqgxpgf2hZ3DDtg?=
 =?us-ascii?Q?OH+tuDtvv5nAStA/CrDFIxrEnV7Ut6LylYLDZ8gdpu4Shsz+EOlm0St/0W72?=
 =?us-ascii?Q?AhG96WlHsJ6KHiNzo0mB9NjRmCG9DuYqlEtE40PLD7VkNMsk/whoj8WjDv9u?=
 =?us-ascii?Q?WgghQKoG+xeK730CouHU7NUHA7CnsrjoBCNFwQMLir5p2Ya2A6n0H+nxlMuz?=
 =?us-ascii?Q?SWy8lprt7hMQrWRhQ44uMVnXrnicEhi4ootGNQ1mw+Vv0KYE4FLiLegQ379T?=
 =?us-ascii?Q?6NGBvd0VWIjvkYF77LT5BPvg8qeJKn6DeWQlYa6B6kOqNVU4fMVDUH0z7VfD?=
 =?us-ascii?Q?5vsjNxclv2hcy9f7rTEMWsiEkb5OlQ45/ZTU04PvRozipmciDKtlURjjw4lJ?=
 =?us-ascii?Q?huXubosE3emX+u6PyWzfHazFC4TNTURNxWz9+58cxQad+iTgbuLfxfA6jIJS?=
 =?us-ascii?Q?Ei6ObXxEZqlVYoZ97cfb2lPNOpCxXsfiEwztmlIK1GKXRE/kMq1/9rAzE+NP?=
 =?us-ascii?Q?ILBBdFOOLOM5wff45lyGf4t7DXDahbvuiNqydiAiO2IuAk8kSFkAPJDx3dzk?=
 =?us-ascii?Q?kCuNKOCwe6vpsX72djhYO9PNIaWUgabCzBN5B8wiQS7ccJJ2siYI3Mm12Kre?=
 =?us-ascii?Q?V9euL/rHWG/Rzb29ahRhNBTvOn/1mdeGv23eK7oRNdI8vbNsFMVNDAiWH2Np?=
 =?us-ascii?Q?QGyjU8cZJ5jf8lSMcWLqI4WpEjBBBYhMtwqFLSJLMNBGSMhG/V62ewGQ6n6M?=
 =?us-ascii?Q?uAaHQ3n+6lpVcZKk+Mk0nzPID7x8e1U9vkQKv2YrctH7LFkNpXvi9ZEr+22R?=
 =?us-ascii?Q?yXQSlBnTvJIt1tsutrdAcCqM9ePScGncd7fB8yJkRgq3vetMAlEVkZ5rZU7R?=
 =?us-ascii?Q?GCrAdL7A1YZBE9Ppc80n201IgS6e45vfdUc5Lg+bAT7ej4ORQzYcK6eIXVVk?=
 =?us-ascii?Q?UkiUcREUPnJCrvgh0pgXPvIQ3qPV0CcMBFaS9jlzjmkaWzvQGcMFTUz6vw/x?=
 =?us-ascii?Q?ZlM7oWe+0/I4+v+mXKS+K1+gc3Yr4YkYbMT0qO8yF0N+BqF8r2xjF0tJe40x?=
 =?us-ascii?Q?R8yXMZewmSroTi+S9WAXe4KVsyYGq8vG7q6gEcxl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f35ae2-a3e3-47dd-26c3-08dd3074f96d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:15:11.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxX7NffdNGqX7nBkqn1oZnAt8NWQe4yUcoMr+7MyZK0K2FYrvlMJfvhjyXhhKsBMVoq0H75P27ZgvvpPaAQ0SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054

On Wed, Jan 08, 2025 at 04:14:20PM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > Prior to freeing a block file systems supporting FS DAX must check
> > that the associated pages are both unmapped from user-space and not
> > undergoing DMA or other access from eg. get_user_pages(). This is
> > achieved by unmapping the file range and scanning the FS DAX
> > page-cache to see if any pages within the mapping have an elevated
> > refcount.
> > 
> > This is done using two functions - dax_layout_busy_page_range() which
> > returns a page to wait for the refcount to become idle on. Rather than
> > open-code this introduce a common implementation to both unmap and
> > wait for the page to become idle.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > 
> > ---
> > 
> > Changes for v5:
> > 
> >  - Don't wait for idle pages on non-DAX mappings
> > 
> > Changes for v4:
> > 
> >  - Fixed some build breakage due to missing symbol exports reported by
> >    John Hubbard (thanks!).
> > ---
> >  fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
> >  fs/ext4/inode.c     | 10 +---------
> >  fs/fuse/dax.c       | 29 +++++------------------------
> >  fs/xfs/xfs_inode.c  | 23 +++++------------------
> >  fs/xfs/xfs_inode.h  |  2 +-
> >  include/linux/dax.h | 21 +++++++++++++++++++++
> >  mm/madvise.c        |  8 ++++----
> >  7 files changed, 70 insertions(+), 56 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index d010c10..9c3bd07 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -845,6 +845,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
> >  	return ret;
> >  }
> >  
> > +static int wait_page_idle(struct page *page,
> > +			void (cb)(struct inode *),
> > +			struct inode *inode)
> > +{
> > +	return ___wait_var_event(page, page_ref_count(page) == 1,
> > +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> > +}
> > +
> > +/*
> > + * Unmaps the inode and waits for any DMA to complete prior to deleting the
> > + * DAX mapping entries for the range.
> > + */
> > +int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
> > +		void (cb)(struct inode *))
> > +{
> > +	struct page *page;
> > +	int error;
> > +
> > +	if (!dax_mapping(inode->i_mapping))
> > +		return 0;
> > +
> > +	do {
> > +		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
> > +		if (!page)
> > +			break;
> > +
> > +		error = wait_page_idle(page, cb, inode);
> 
> This implementations removes logic around @retry found in the XFS and
> FUSE implementations, I think that is a mistake, and EXT4 has
> apparently been broken in this regard.

I think both implementations are equivalent though, just that the XFS/FUSE ones are
spread across two functions with the retry happening in the outer function
whilst the EXT4 implementation is implemented in a single function with a do/
while loop.

Both exit early if dax_layout_busy_page() doesn't find a DMA-busy page, and
both call dax_layout_busy_page() a second time after waiting on a page to become
idle. So I don't think anything is broken here, unless I've missed something.

> wait_page_idle() returns after @page is idle, but that does not mean
> @inode is DMA idle. After one found page from
> dax_layout_busy_page_range() is waited upon a new call to
> dax_break_mapping() needs to made to check if another DMA started, or if
> there were originally more pages active.
> 
> > +	} while (error == 0);
> > +
> > +	return error;
> 
> Surprised that the compiler does not warn about an uninitialized
> variable here?

So am I. Turns out this is built with -Wno-maybe-uninitialized and it's not
certain error is used uninitialized because we may bail early if this is not a
dax_mapping. So it's only maybe used uninitialized which isn't warned about.


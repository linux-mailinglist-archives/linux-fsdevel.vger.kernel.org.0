Return-Path: <linux-fsdevel+bounces-41156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD32A2BAAD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 06:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C7316685D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 05:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8FF233D89;
	Fri,  7 Feb 2025 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVlp0LWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036413CFA6;
	Fri,  7 Feb 2025 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738906320; cv=fail; b=LLK2rDyuKNWD7XVSWMRAtg4mzMvpLiJV9GQKxoFEX1MoFcJvMSUJo1h6JxVdIGNKBN7BKTW5xI+y9ro3BRISsAsg5GW6CYtZoR2z16+4ZFE653C9eneS6gvKWyLwb13XHOBxu+tTuQjv80HJ6GNLTSOiq2HX4cCwXqZK1PGWxVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738906320; c=relaxed/simple;
	bh=Njdw6eHfDnU9LHOIsJF4tnacO8lkoG8reYZFcIepzwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nJsiWYn/USfVHHCM+nHGtT1DIyKJUSqDa5UKPS6j5qAmTwZZMuC4Iiev0ie45He0ECYARR/6PlJpj3Rf8XBYGkL7iKEJ40cdbOujzhHh9wa3ZxWdpQSpACR/wk9k24LC+8m/kdC2CgQnGpABEgnfUUjlnGLnL3eYfTmC96Ip4Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVlp0LWj; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/q6DRS++cfptbo0Up5D3RDUN0fd0oH7hUOQuBL/9b22PD7rI04rvAKaZ2NQKhIdq1LdwGC5SYcrJ7MYYOLEMyNY4RqyzQ5pFSRvBX0t1VMacl7nXNqyM+JgPg8P3jv75fr54Ij7lOvuRD+riJLwfJZMVzDeac2ASknGGFTS6kHeZYhxnpCSS7a9lFpB9COS6pO/7Aks2qKoUeOpFz/mwuo4FRoJ1OwEYBmbR2FyRa+zwaq3f0U/EeKNj+CniB3EiWIXJDyBBnbdNVBqvdiP6IbyDqZURazPSCTySTKNNWwxRQ/N7ixsC6E10DY9lgIUgPe/SmaF7HyKlLuDjZUdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqF22QesjmaWNNL2lCizwHjDaZPgj5fUbIIj2ZtHu9E=;
 b=KrMgWMI9wDa+bqIT2SuXfSSv8mGpLh1H9bl+SLe/ffZIzRmFqxY1VnZE0cYucJiY3YF/W7A2clz+JStfcpAcEiqWzIQR+frrdO3KrTfaWmjWy9efdq3UekB6KsU3oFTGdkN3OOIWc3+VYVZu9iRo3hj7c/fS34T2gz7o839bnvyESJC6mthfBhj5hl4r91gwxUfRjCqHQRHHvEMAXBmMHbQZ59JYM8R3NAJ7+jL5b1IE7jySLBCmW0bw3Ndz87FBGl06kLO4uUJJBU8jR5dYZmyCwt8Kizs1g0D6BlhUHxP+G1sSE2odvOMyUw/fIkbqnTEXvSvIxg1UiGswXyfOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqF22QesjmaWNNL2lCizwHjDaZPgj5fUbIIj2ZtHu9E=;
 b=RVlp0LWj+upgQStA14uppmu8YSPV8X6D+DlrZebhYvSsjdfSkRj9jDyD8I8DtHHjOWYF+wfMV9OThTTZJB5NPvuuQx7Bzqk4G0tm79jXh3DXhTPVIfPXLqmHP91+aPdGEHxD1fl/D+1qI6NwzSQlgLBJ/LimA4WKqUKU4lTLcWRhqCCOlKNA5C5MDxKQlEVUiPYrs0g7fY4es/rOonBOXtYX2e12KR5Flki9GZt/7rdRkzap7XGaW2EKpJYFoEeUXWg9EdzdSHx2EdKKWYK/ZgUvcu8dXGUuQqLOxXaGVSkT0d+bFW//R8/JMzd5/d/s04yS+o8fCYdpwr9Zuq+xWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 05:31:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 05:31:53 +0000
Date: Fri, 7 Feb 2025 16:31:47 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 21/26] fs/dax: Properly refcount fs dax pages
Message-ID: <zbvq7pr2v7zkaghxda2d3bnyt64kicyxuwart6jt5cbtm7a2tr@nkursuyanyoe>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <b2175bb80d5be44032da2e2944403d97b48e2985.1736488799.git-series.apopple@nvidia.com>
 <6785db6bdd17d_20fa294fc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6785db6bdd17d_20fa294fc@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY5P300CA0005.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fbbc63-da99-430d-0a82-08dd4738ba9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?htvwvL65kwN5MqtWNodsFNTEuRU9dw6xE+5SVX8ybv9LZpc1GCZKf9u2hyN1?=
 =?us-ascii?Q?vPVp15RaRotKkKt8LiZg9zmYXDZiK8i7FDglyv0wXP2+V+fJgceDyF69FeM4?=
 =?us-ascii?Q?x1DVdfQGTJArz80PJpsR6VZXo/LrEjfNLccf9KFgkM2zgFof4PIyX9C6uST0?=
 =?us-ascii?Q?iVFA+OJ4EnKKhODbtt+766Z+wOhaDuqz4qcoYhEwYS56leVamStKbIXNdM+6?=
 =?us-ascii?Q?y2r/iCscGFrT1KEGytjA/A6GT166kAEfDwA3oFJlBMGmFpFKFUr94q4d5SgU?=
 =?us-ascii?Q?RX/ItQV98G6ztHAt12GPnG4Z3k1J1YXY/Y9z2o7wmUqCPivwZ6IjkirnwTNi?=
 =?us-ascii?Q?ZDDWbFlGE0PUQ7W5RZ2J2yOo8y9VjmGjLAp8CfAk8uo0DWIYwiwke4ydHfuS?=
 =?us-ascii?Q?PlDkA1TY57MmA/m5LZjmIffcQ6gaxiVmCTc8rQuo/Bn9ykgYbIeNy+rQMoJl?=
 =?us-ascii?Q?9nUxQaF5CtpgCNkRpNFP3pXTCUMQppTftBNCMCGETx6/EYnTQ8ACjUGHN3jX?=
 =?us-ascii?Q?FlzjTAa9OJ/mpXJSae9dmKFiNiseO2+vbvxff1Uf4stHpszOQLzBsOeEHrm5?=
 =?us-ascii?Q?R+k2zxuuigRUxZtXdZkMUn6X7tdxS9c/eDI/GaJGgYr8Qqj8us7yzUxyXlr7?=
 =?us-ascii?Q?nlYogQ07+LDD8ktwqxrq95l0NkILZZ+QV0QG1b4cXisL+JUbr3oAPPQQstuN?=
 =?us-ascii?Q?tOH5lx4+YYX4ewUO2qwwbr8R0gSFuC7QH9JpLuJFOwcosBTdSjk1NgZLvRCu?=
 =?us-ascii?Q?BXuKciLvGUfgdTd5XvqEVlFBQBnsdUu+fZqd0uFYV8IptSWBw6Nd59PMGQQf?=
 =?us-ascii?Q?eU/BuX3HDotjqBvoYxghMvDp1BsJ2onGa9L9SNBGVV9EbrNux4FmFWPxnDWA?=
 =?us-ascii?Q?Q3KymMwZQVH91Z7bMZW9YMNaq6V3zkGMzAhGR6tzh6qPojolQl7OURu0MFET?=
 =?us-ascii?Q?xjGtJR1+Dtk/ybyM7CcGuyP5hz+kGjcsrAcCt5bYHUgfFCRsvKVj23FMz996?=
 =?us-ascii?Q?jqUhq7qRSJfdYiASKfh5J0VN2BpVZWkTv+wmyTYgUNVQTV+dC+uZm8UE2BsX?=
 =?us-ascii?Q?UQPEFQKnG4CSVN3pVF8vvn/5myvCb98HF47SSwdmvwvf842W+/AAXiq+yolX?=
 =?us-ascii?Q?WTFK3l5VpFHeGXRogLvAmqtQN3aF+ih3p/dJeHaLkzk16CV1AXKs5nCvKijo?=
 =?us-ascii?Q?YbdUw+hoou/fpTbJDeRSph9oiQFTgFjdPgpdwsT1t9K6j41HZlHgzednlsew?=
 =?us-ascii?Q?YPO1OX2HKnwvhoIG+lqdObxKwGYcRmQnNEB+jZ8V+0iOLInyF1XMSPPlc2Kk?=
 =?us-ascii?Q?7ri7DrxdyhofbYD2uBCjwZgi7qhh2Sv/OPpXb2IOwC6HrrYzwR5J0P/sBSVC?=
 =?us-ascii?Q?VvbSDma0MMkIo3wrLHbQ1Prof9/5KEOx67a6pZzDooAaF7AZamxDedw7e9t2?=
 =?us-ascii?Q?EkgyrGBgNe9ro1bi+/UYsRrvfiA92HUk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O+hYuJfjQWWEvhzezAUNjoSqUjMsobZcnhiav7jqVpT37Rrn4k/9l9W/7T3w?=
 =?us-ascii?Q?2VB5l5VWJk359TFOxY0LLR+oYlOsltD1vYvEs4kE5aahx8qh344LdFPrwU3E?=
 =?us-ascii?Q?F28wkt+ruiXCgdrPYBjG2v3Q3I0X0UYE0aoKkJ5WIraB9mt8hB4nlLs19vEZ?=
 =?us-ascii?Q?68Q6BsxSOU3tgbaS811+cFrsJiiSgu44Aawiao5WvUNbWsdrQxNPoejwWWBX?=
 =?us-ascii?Q?StXElzFCj/t2uz+fyPjFTRfQU45ygyS2we0P7Hs8F1EI+y4VjGwekMviK7b+?=
 =?us-ascii?Q?KeWqn+Pd1kTaUaMdIl6iwIlii+DMmDyK/A5EOW5j+BjIq5NtDBsV6LR8K6B/?=
 =?us-ascii?Q?6mmbun/JVQ8AOL+89oQsNqulTq75IdQoopFTph9heQ5EZdZiTh0E4OH/uCSe?=
 =?us-ascii?Q?Yyrx9EwvP+YWTq8dliwmzJMdx33hPAvxZRFoNTD13JvJd2U1Mbw3BpsGx4EG?=
 =?us-ascii?Q?QiJn4ymz3gGwATd7w+QpLbLmX2fV2iOIS4xEB/nBIpExi3LQ4Ew7augxfmru?=
 =?us-ascii?Q?w3vOcimO28gPh5vGUxpguyX8hfwbqKyArNMLZ+/hyeplEitXzVOHOs+sSJko?=
 =?us-ascii?Q?okIcswHhdlP2HSf/gvLfxNYRMSPJXlqFrubLGKMywKMTx1Ue5AYOHFoL9eZ7?=
 =?us-ascii?Q?CtexmWh/CRgZRJRB0KZ7ZYoHfeJrdFsXWz3MXxThlhbnCuQA86TM+d1PRd9M?=
 =?us-ascii?Q?FXgHzk7J56QerKt0g5SrbasGHXYRk1vAJl/YEBtfeSU7KHkiUkcp5RnDb/eI?=
 =?us-ascii?Q?f0IfeGcmzqdl+qie+ta846eQnhdRFTWzn+sroR1OjbAQUkboFrzCUJ0uSQ61?=
 =?us-ascii?Q?vdQeHNtnZzX/K9Mv5rGuLhxyxvJsVguzz2LugHsT8UR11Dy1KRMi+dgBXp+h?=
 =?us-ascii?Q?EC+th5UuuD4ZoHOuenZY+sJ6rOPj45dQSHx/X3Q830JkWoQ/dWko8bHhBSbM?=
 =?us-ascii?Q?odDNKsvlnSC4jzeGDNJqlAjMol15yXJ4aMLxH3z53u3aiDMJnyzLTdIJ9uQu?=
 =?us-ascii?Q?5h8MVVCIXWmXzQG6GY+GjSgJmZvrRWal22laN1cYJDA7H7H2oXwRhxCFCgU7?=
 =?us-ascii?Q?zqud5g6vbj5+cpUpMMY6Hnsudh9EoEY3fpFFgjlzPd+2ZDi1mteJEIT/E2Dg?=
 =?us-ascii?Q?mibs3EF9jke1P6fVLHfXDSNuiRTx26b29NukTvvieqQvXKw+Apyx11Xgaeg4?=
 =?us-ascii?Q?2oRjH4AwvWHTg8DxryNNTXP99xfrgktieMHxl7QfKSCmSqTLHoDZv8VZ716V?=
 =?us-ascii?Q?nE3+RsAgF32hQTi1l64c9w3BVluy/TtpBgYowHABumkoJ+NTipfbJoqKtayB?=
 =?us-ascii?Q?SMTbbJk2KNmBB6OjfR9k38B+B9Wn+SIfncUIcI7ZOB58azVggE9QFh2wJWlY?=
 =?us-ascii?Q?qqdzkjYU03c4CBaDuxJICUMz8E+i5pQr95cwcgKZH62f6eN46hGMe/ptfwgM?=
 =?us-ascii?Q?P/1vRyojwPHvXHEfpY7gY1JalLrtgOTKSJxGFd0bBOMn/od1oB8SUKmTwuVM?=
 =?us-ascii?Q?SyBjR+2gk9junG/ZRaQRaqp0L4RbXIITyJUKs8HhJOhEA4xnsFaQpK5nGxRI?=
 =?us-ascii?Q?gCFgfsqwujh1JF3Bfk2yPFKJrcjXRoOHDdyABVtk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fbbc63-da99-430d-0a82-08dd4738ba9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 05:31:53.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsYjS72KYeHRF9X5LmbCvpWxIwUxC45i/PwZFlDmSU3WSd1XYxZlByB/LQci4VvQax6qv+KvwiXeZFEbmCXerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

On Mon, Jan 13, 2025 at 07:35:07PM -0800, Dan Williams wrote:
> Alistair Popple wrote:

[...]

> ...and here is that aformentioned patch:

This patch is different from what you originally posted here:
https://yhbt.net/lore/linux-s390/172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com/

> -- 8< --
> Subject: dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> The dcssblk driver has long needed special case supoprt to enable
> limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
> works around the incomplete support for ZONE_DEVICE on s390 by forgoing
> the ability of dax-mapped pages to support GUP.
> 
> Now, pending cleanups to fsdax that fix its reference counting [1] depend on
> the ability of all dax drivers to supply ZONE_DEVICE pages.
> 
> To allow that work to move forward, dax support needs to be paused for
> dcssblk until ZONE_DEVICE support arrives. That work has been known for
> a few years [2], and the removal of "pte_devmap" requirements [3] makes the
> conversion easier.
> 
> For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
> (dcssblk was the only user).

Specifically it no longer removes PFN_SPECIAL. Was this intentional? Or should I
really have picked up the original patch from the mailing list?

 - Alistair

> Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
> Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
> Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/filesystems/dax.rst |    1 -
>  drivers/s390/block/Kconfig        |   12 ++++++++++--
>  drivers/s390/block/dcssblk.c      |   27 +++++++++++++++++----------
>  3 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
> index 719e90f1988e..08dd5e254cc5 100644
> --- a/Documentation/filesystems/dax.rst
> +++ b/Documentation/filesystems/dax.rst
> @@ -207,7 +207,6 @@ implement direct_access.
>  
>  These block devices may be used for inspiration:
>  - brd: RAM backed block device driver
> -- dcssblk: s390 dcss block device driver
>  - pmem: NVDIMM persistent memory driver
>  
>  
> diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
> index e3710a762aba..4bfe469c04aa 100644
> --- a/drivers/s390/block/Kconfig
> +++ b/drivers/s390/block/Kconfig
> @@ -4,13 +4,21 @@ comment "S/390 block device drivers"
>  
>  config DCSSBLK
>  	def_tristate m
> -	select FS_DAX_LIMITED
> -	select DAX
>  	prompt "DCSSBLK support"
>  	depends on S390 && BLOCK
>  	help
>  	  Support for dcss block device
>  
> +config DCSSBLK_DAX
> +	def_bool y
> +	depends on DCSSBLK
> +	# requires S390 ZONE_DEVICE support
> +	depends on BROKEN
> +	select DAX
> +	prompt "DCSSBLK DAX support"
> +	help
> +	  Enable DAX operation for the dcss block device
> +
>  config DASD
>  	def_tristate y
>  	prompt "Support for DASD devices"
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 0f14d279d30b..7248e547fefb 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -534,6 +534,21 @@ static const struct attribute_group *dcssblk_dev_attr_groups[] = {
>  	NULL,
>  };
>  
> +static int dcssblk_setup_dax(struct dcssblk_dev_info *dev_info)
> +{
> +	struct dax_device *dax_dev;
> +
> +	if (!IS_ENABLED(CONFIG_DCSSBLK_DAX))
> +		return 0;
> +
> +	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
> +	if (IS_ERR(dax_dev))
> +		return PTR_ERR(dax_dev);
> +	set_dax_synchronous(dax_dev);
> +	dev_info->dax_dev = dax_dev;
> +	return dax_add_host(dev_info->dax_dev, dev_info->gd);
> +}
> +
>  /*
>   * device attribute for adding devices
>   */
> @@ -547,7 +562,6 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>  	int rc, i, j, num_of_segments;
>  	struct dcssblk_dev_info *dev_info;
>  	struct segment_info *seg_info, *temp;
> -	struct dax_device *dax_dev;
>  	char *local_buf;
>  	unsigned long seg_byte_size;
>  
> @@ -674,14 +688,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>  	if (rc)
>  		goto put_dev;
>  
> -	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
> -	if (IS_ERR(dax_dev)) {
> -		rc = PTR_ERR(dax_dev);
> -		goto put_dev;
> -	}
> -	set_dax_synchronous(dax_dev);
> -	dev_info->dax_dev = dax_dev;
> -	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
> +	rc = dcssblk_setup_dax(dev_info);
>  	if (rc)
>  		goto out_dax;
>  
> @@ -917,7 +924,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
>  		*kaddr = __va(dev_info->start + offset);
>  	if (pfn)
>  		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
> -				PFN_DEV|PFN_SPECIAL);
> +				      PFN_DEV);
>  
>  	return (dev_sz - offset) / PAGE_SIZE;
>  }


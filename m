Return-Path: <linux-fsdevel+bounces-35509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FB19D5715
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBA81F22761
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B42B1531C8;
	Fri, 22 Nov 2024 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlhkFlvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2017580;
	Fri, 22 Nov 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239673; cv=fail; b=djswPlQX7NG/RmjzVt3f/G8sw73cjVCZfBizwnyghtkWp/mHuA7Qcw42CzbsV/f4hAgSMA6jXxpaubOx+c4Sz8Ct49p40PsvNx2N+2xge40R7UizqU/vOkgDG4UlcpBSJWkTe99ZUNts428y3B51SStg0C02F+lPq/dvg4R0Cl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239673; c=relaxed/simple;
	bh=24yBQLuoFf4v1Kp3tozUuLAjex1Z8RHgTWatMfkjv/k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BcSLMixg1fyL6qFhAGM4tcL0pVgJZ6GVHtUaKa13TD7DvKhAQn85YB5MoX34ngDNSak0cmw2GrhGav/vR3B6cjhvY8em7KCah3CVQzBg5U0B4s+mlla6dqvqsmNeE1z/RWeJ75Raqn65ERnPvMOxfximM8a5m2P7Zq3JfsaxnMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rlhkFlvo; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6uQxg7uycdxE1U8holbM2RlRnnvmisxJnBdZPZL4yzBxDosX8xDPARt4yO9WXHZsxLPcW2dh/orVscYrWqKlEkFVxubz3qj4+T/9V1S/IX0rMhgyE8GfKONeaBXOt4EKf7pCsLF+u99cG8VfMqkdQ88BNF2gkGWUNrcOIsMXuZxTqFyBYTjKakE8e0DLjZRB3FE5QZ8pGtmDNcRQjDiPvFz+KXTzgS9adHREuBWrR6oTFpHxiYrl02CEVY21OAsna325+KGjmA9QIGu4tj7AR/9lwS7yg7Ou+uwz84QkL650m6+TSEfmbvHbMQN6fhXGtepof72UBXI03xFsJILpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGyh0Mw+93+6MNfKJ7ksLUyrIRLTr9DxHq0U0ocX6Z8=;
 b=o7QXDEZkmpi/41icED1wGO3S9ThQZo+qzTtdtmemoVfDw45n2EmENcsQjWq9w6xAUhS9njuXYV8fFj6snjz3oDNX+EzPxXAaCPNPwlDNcfVQNkq1wKqeCArMOO3T4YKhUDBpHEoOCA66miSs3dWbDzLpZltVe1eyTojF0p7JHlabSuYKfM3m3p+Hvd2U+Z6vx690VW5m85Re/sAywRWovg8KF4G/LIIJlJqVCktDoQV/YNUwFzaD9qDOWKAA9FkYFzR6rvPvQQsS8vD6jzm3ZlOcQ4xmPRMmutm6SQ5naBtEcMso7afnXUJeeSv/ZlSx9xWRiWW136bAO8wFBM15/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGyh0Mw+93+6MNfKJ7ksLUyrIRLTr9DxHq0U0ocX6Z8=;
 b=rlhkFlvoa5mDlbq4xiRI1k7uE4OppAiYKwDNasR6yB+sDfJAjsrpv/NlckDci9pKIHEnj9GgCIBhqbY9jQ+gzpqqWmiHHCHHMUbtN8SrUgviqOF/h0nUAYOkRoIvEcQEpc4wXH32Ewp5gbRYQQW0B549jsXyzX/YbzvrbpQUA/62ca+TcYtnzES6TZBNim3v+FMeeUUNGmX7prTpgWmEuRYT6r959zdavjfFSIIOjJXaiV1lYtfbnFyUthWbQpSvAzNdD+p4HoGRsjxyWq1sK6Z/rQiYWUuvCrdvDVDIYbVlJB/VBK6InzxL2S3d0OwyBa83GIynryrBlgD2fSfVbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:08 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:06 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
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
Subject: [PATCH v3 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Date: Fri, 22 Nov 2024 12:40:21 +1100
Message-ID: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0059.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::19) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e38bec2-b049-4ca3-a5f9-08dd0a96bb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ms9xSKHhDcUIi0VHQpC0nt3BpZVvFWC33OLYNo9wFua6r09bV/GAH3Mw51Yh?=
 =?us-ascii?Q?ZLdioLoDYOJJpB1EKQqOvbX0qp+H1Kvv2YObpA6lmcUyfkOV2WlyJHJI72AR?=
 =?us-ascii?Q?/KfCTZWTBBKXsCoJTHIT4bumK5jIIpzHqfpo11oFT3eAf9BueHBpiRuFbob9?=
 =?us-ascii?Q?IHv3bPojm5rxb+/e/1gVJnZMrgl8lwur3/qtHtlCpGlzcOqzeHpYPCVGa5n4?=
 =?us-ascii?Q?8Pu6Bx5YpWpL9xGHZPEv1Cfc7iIrQaCLPNJhgPsYw22lxQMRUVnBW5QZOY+B?=
 =?us-ascii?Q?sCHj+qeBjvObPJc+blRJJ3Ff4BnOW1/b7jMAiWeIj/YeU+YzbDCh1e2L4hUy?=
 =?us-ascii?Q?/dsExfa17/rhCEHGyHC+PWXtLa0x/nNMDD/0A179Wm94Xq4jAk90eWcyzvbh?=
 =?us-ascii?Q?RNbOBEA++lm4XHMVYaegO4XFqrEIyWnVh9vZpfEL2mj5k13GQc9CFi0+gXUD?=
 =?us-ascii?Q?c0eTdYKn+/8AsUiXfMzYXE2ZkUFuLple7PvHqrTTy6oBoCjOl5zLbijLnb8R?=
 =?us-ascii?Q?mTLpY+0+n6ad81YZLma3nUxFj1Ckk6CO3PKcZtuHhQTCGqEEDWnELXmINdiF?=
 =?us-ascii?Q?Qh3gLX2H1Rmy2D6AI7cFJHCJlU3FoJlrkVprPiu6p/bw6koZnp3ZHARtl8Ra?=
 =?us-ascii?Q?13sH+XWuvXJBQA0m3dUwAhtPNTmApnduruJ2/yNJ9zs4iwvypfkF2fZQ2jVl?=
 =?us-ascii?Q?uqclU4tzfjzc7B/do8rIMTMtWS1CbXEjtgKjJyEB5PIM26dN1MHMxXALqTyt?=
 =?us-ascii?Q?6XHq0PuXupxB5IGcO74guXtaA5hT8Dr8KZPvyIYQWOkSEenPKhEwyX5Vg+D6?=
 =?us-ascii?Q?+IFy0dbRN2tqGKYbNFCglQTVSimqvCzirhL7jORx/x9XN55OFaoiYXD0JN6G?=
 =?us-ascii?Q?nMG+vhue/nQCto9XnHmSC4h4nfn7Rl6xO48+mBT5JZmz/+D1Ab/jFLn19+Fq?=
 =?us-ascii?Q?0oUklZT2I7Y6l+0KJwKa243ePKmgKBBBnmOpB9SfyZUTOi9GH5/TZLVfIIwM?=
 =?us-ascii?Q?1p/yl4HNMYNe8nay7A1UR+OJuMHlmg2eX6xbj+Hq5kAwIqHxpfXmgKqpa74L?=
 =?us-ascii?Q?WcpK2wboqeDQSywB9D3LVuk+jC2/6rTy9WsJ3QIw+E75pV1GiasI3IBIrNiJ?=
 =?us-ascii?Q?PWgbMNvywFnoQfEaXPc0bC6WKha5ka5vWx8plO4/1yuKni/jPxR5bS8jyt3B?=
 =?us-ascii?Q?B9RrjkDuN0c28BiB2lO4pnWq4wC5QwjtCU9Sb2yuJCN1Vf3og1+KAe4YViXv?=
 =?us-ascii?Q?3Epy+vbvtkqmqsdoY3yxbBp235+gMgFlmlHW3HQWbbuHTRg7jz71JbJCrEwI?=
 =?us-ascii?Q?4zg44MFGb/G+7d7lOpaF6GkX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S2blqFmKDSdwQbaALuPCHjcwe0IAqDAuxcq0gqCCSUJVhmqTuKbJgV/qfIbI?=
 =?us-ascii?Q?BHlA4ng98IbOJ1zmq84bfdS1wGIocbT+fACeNYHTQa6Yd82yioUYEqZbzO0a?=
 =?us-ascii?Q?qsKD8z7KSVsUF3wE56lQqtwPeShxX35169on4Kffh1HqNEpSIHyYM2uaqA02?=
 =?us-ascii?Q?Lqp3WL4mixYeLF1bw/5M+zXAqyT651yqMtTTJVXXeveNKj4dqV6xYNnNZyq/?=
 =?us-ascii?Q?lQJbIvulc1cyryclZ9FaGcwnTtnIYDR0qkOwJ3yYLXpNX6+6SCAkJArVEO1e?=
 =?us-ascii?Q?i8+Kc+DQ439O/38T3k/aczjFcIc3qMa05O++xhL5Mxr11qv789jvkv88nXCo?=
 =?us-ascii?Q?SbTC3adOvMif9W5I51deU/k0OA1eG/aMsuKrVkutnXgtOoT3VTwPAMZ024vC?=
 =?us-ascii?Q?/wGCRYC59xuFCFLdD0tvMKlff3fVyEUruGge2pD9brm6tvtaEjKRrW3KcO7L?=
 =?us-ascii?Q?gvkVMfqhPh3CDr3DEPnSYCffN3jZUpxBJ3bWG8/O3yicA3Saiz6ciyAYsrfc?=
 =?us-ascii?Q?76+UsVbo1IXKz8old8XFRsJmoAmfV9+7fqFJjhf9JbCG/9thl6DdkseTSbHH?=
 =?us-ascii?Q?KyVNDYrlIAdSujTNrVp0iHlp4aEvzH5Jor9gfGg0jTYeanOh8RiL4vvLeRzU?=
 =?us-ascii?Q?P6vwWsK6ozuM11LImMABZhgGfoFqW2G/jZVi1QTUdOORrsTWJfDWt1L4JtJw?=
 =?us-ascii?Q?ljmcxImre7RF5EooRgFue9W8emfm9brs8mlJz2phXstw0BWp6PdPrFohXK+1?=
 =?us-ascii?Q?wY7gA3sbRsNiP7TZh2ee26xyHHoB/Be5qlLp4AHNJfFK80jYRpS7RDh6nj5l?=
 =?us-ascii?Q?ixeyRI6OSgQy9zVA2/cbHXgXsdQ+1dSnmMe8p3poKm9OSzbDYscLJEsZI8zz?=
 =?us-ascii?Q?L1fNupzPMtcpqtlnVWvC6TSK5GCNanx/d/beXH/cU37KLwBqDjd9KP5Fj2ns?=
 =?us-ascii?Q?zLfY3mYg1AeVa4sstpM9U2pEPqLXwp0/huZ6b0f46NcHPtmwVNmqrLLIp74v?=
 =?us-ascii?Q?+iDtwT+0+jGpQiS+Nq03iXOyQNVH3YYmVOfJ8pMx8HH+r272D5xtyJWtLZth?=
 =?us-ascii?Q?hC0o1Ktb1aBlOUdG/5CqgEgkCUa9AWF29MLrqjLIUocO6JfFlzSo+1I/Uy0o?=
 =?us-ascii?Q?/EpG25eb9Ce7nJ1Qgvn7BKw01KFKApUYfycxa/8pbEw8QvdnR8h9HLEVWigu?=
 =?us-ascii?Q?rpfzvf0PPwSI/yshAAX44YY4nK4v/VsYammTf5HwAJLVHfsGwiuzrp64a4Z2?=
 =?us-ascii?Q?04pQkzVQxGXpgwEoSyx2zIt8hXRSx0VoHgJYvFkCNG+BdIjd1QCgOcTkKVsE?=
 =?us-ascii?Q?yBhynu65C+rhGFDo9AVpWdy1T4RCghoTxeJFUxk3EhDgssV5l/isxmNIPVGx?=
 =?us-ascii?Q?CWUBaK5CCKb6Ot5ZAPMRYVbbKppAlCD68FPlf0z9He2OQwNCaS5qA+H3uutY?=
 =?us-ascii?Q?dtJtRHtRZq5sXvt3OZ9zloe6TeNIbvcUelR8pXDlrj6EFY4DnMeW2fvWpPLH?=
 =?us-ascii?Q?Vu7RBJ5g548gC+DC6CtKbk08aYwK10gcD0uhPxhmZ9r3YWmEUK64LJWO6yj2?=
 =?us-ascii?Q?0iWhimc+bvgQHfuxx7O8LuFcpYsOBZouJeYOoKpe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e38bec2-b049-4ca3-a5f9-08dd0a96bb86
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:06.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saQ4sDPFbjlq6d9ct0mZYgV7KCZsAi5ukzL1eqxH/EH7DwE+ejFckg92c6iZz2QkLvhybTfo2OqCq/eY//wuSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

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
  pci/p2pdma: Don't initialise page refcount to one
  mm: Allow compound zone device pages
  mm/memory: Enhance insert_page_into_pte_locked() to create writable mappings
  mm/memory: Add vmf_insert_page_mkwrite()
  huge_memory: Allow mappings of PUD sized pages
  huge_memory: Allow mappings of PMD sized pages
  memremap: Add is_device_dax_page() and is_fsdax_page() helpers
  gup: Don't allow FOLL_LONGTERM pinning of FS DAX pages
  proc/task_mmu: Ignore ZONE_DEVICE pages
  memcontrol-v1: Ignore ZONE_DEVICE pages
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
 fs/dax.c                                      | 354 ++++++++++++++-----
 fs/ext4/inode.c                               |  43 +--
 fs/fuse/dax.c                                 |  35 +--
 fs/fuse/virtio_fs.c                           |   3 +-
 fs/proc/task_mmu.c                            |  18 +-
 fs/userfaultfd.c                              |   2 +-
 fs/xfs/xfs_inode.c                            |  40 +-
 fs/xfs/xfs_inode.h                            |   3 +-
 fs/xfs/xfs_super.c                            |  18 +-
 include/linux/dax.h                           |  23 +-
 include/linux/huge_mm.h                       |  22 +-
 include/linux/memremap.h                      |  28 +-
 include/linux/migrate.h                       |   4 +-
 include/linux/mm.h                            |  40 +--
 include/linux/mm_types.h                      |  14 +-
 include/linux/mmzone.h                        |   8 +-
 include/linux/page-flags.h                    |   6 +-
 include/linux/pfn_t.h                         |  20 +-
 include/linux/pgtable.h                       |  21 +-
 include/linux/rmap.h                          |  15 +-
 lib/test_hmm.c                                |   3 +-
 mm/Kconfig                                    |   4 +-
 mm/debug_vm_pgtable.c                         |  59 +---
 mm/gup.c                                      | 176 +---------
 mm/hmm.c                                      |  12 +-
 mm/huge_memory.c                              | 233 ++++++++-----
 mm/internal.h                                 |   2 +-
 mm/khugepaged.c                               |   2 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memcontrol-v1.c                            |   2 +-
 mm/memory-failure.c                           |   6 +-
 mm/memory.c                                   | 126 ++++---
 mm/memremap.c                                 |  59 +--
 mm/migrate_device.c                           |   9 +-
 mm/mlock.c                                    |   2 +-
 mm/mm_init.c                                  |  23 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   5 +-
 mm/page_vma_mapped.c                          |   5 +-
 mm/pagewalk.c                                 |   8 +-
 mm/pgtable-generic.c                          |   7 +-
 mm/rmap.c                                     |  49 +++-
 mm/swap.c                                     |   2 +-
 mm/truncate.c                                 |  12 +-
 mm/userfaultfd.c                              |   5 +-
 mm/vmscan.c                                   |   5 +-
 70 files changed, 886 insertions(+), 920 deletions(-)

base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-42813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96785A48F7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 04:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FA23B8ADC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118751AB52D;
	Fri, 28 Feb 2025 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fedegiGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24391C54AF;
	Fri, 28 Feb 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713535; cv=fail; b=Xu8Kd/cSPY490MdobOFg0OsiBnoF85JJICJHSRg0eErmF7Af3aHG6HGpLJ4bZjY6UJrcnq+XFMGLwdTNaSqNsweISdVmfguoWCM4lQA7d5ovYwHJ+NfEGYvRzuTJwJFJYCeCEDySiGnGcLF+duM6dG1Z0agziB6OJJT9TcnxGBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713535; c=relaxed/simple;
	bh=9TEromW9vRZnFHDpv9LHTGNUInQH+fMiZA6oXda1IrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pecpwyXDpabRiwnG5CIL3+RK731fNpbJbjuHwtCI+NDVpusIjYS4FL0CDeXfMFVSbsU6q2u0q/HdNVEff6eVXVqupTeQItKnvhxW7YnPABJ3uN6gFcfu5RjSJGF5bwsp+i4oQpNv8GmeBft9ogo3hes78XqU+NP527Y5jPx2HJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fedegiGZ; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nqn48H1nwZbYSj71N+VJ32l2Mx6/s10QC7xP4aCvNTs1O5DeYLUKFRYNxBVyH2HxpHvIm96ohpxFBjD3xT4DGnRuMDkakDsh8Q3IEfrAdT8mwrl3Wg9aVimFvdVBc9oIv+zmfEaHL/lUTv+gsyLBS+gpLuzzP64xzxnaTGEMDsjgxM6TaWtZF3WuUq31dGj+ImfU/WOJ4euLLOeDB9rBxZZgqI6rgj74PXMnrFQ4bw+kG6RXbtQuGAdt38rVIllQbffCDUL9R53AfhRAbF4qm/zbdE5Iu/x0HAUA6D6SR36eWnlKn6bHlpb1yWjxDT4QvZcm+HRV0yChjqQtD6LsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz0xPUgxEv2VmYCP8Dm5xz29OCp4yeM8XyN0+NmpTis=;
 b=MoN2ygR74C7rZqggF8BNZIxfRyQs9wsW6dSsvX1ggDSD9i3+CiH2fJ9CljFEyS+/zZR8DkQd6/zbzzNvi9taiun1TSY1KC4QPZGFtRqxNwSSWypYLm0gDk7lxHhmLnEqXVfEcUoe3t3u3KJjzD913y4wzr6X1BkmiO+CbSLiPZBeOhLx6leRnrqAkYqlSGRc8/FlK7daETVUEfxSA+QPH9bF+D+mB/ySlsuIScNHXqf9krigFt+MTTckihzscj8CtXIAt3f+Wczf88a90O1McWYF4ISZGxhHtY0Ki4tYXR+Zn2aaw2+sGmvjZGqzakBxjPj8M8YK6u8LPKDxCaRejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz0xPUgxEv2VmYCP8Dm5xz29OCp4yeM8XyN0+NmpTis=;
 b=fedegiGZOad+UK6hWLjarIM3lk4RZ+HkEqTu73JZrdHDtKdNEvablalJGVHdJLxShz33QJXrCKLhgCJq91k5RshHXRY8iw+j6eUF9KfsMNDTTGqqPb+csIu9302/huQnpBaI8l20VB9Le5rAalPD1EsMLNbv27FPq01NrGi+o6gOd7EC1V/LHij8LXW0xzi0LQlou06XCjJQaBiM3FQC/e2sscAF43DWbHRd0fWIamJSlGMm3SvoKoCZT9l3wJPF0jUVd/CSVzvQKQg6pYB98IwTTSEEbLvj8SetX5mXD22lYTdniqsDYT4pQ1+MZhkaCe10CLMue14HJsTgpdF6yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:32:11 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 03:32:11 +0000
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
Subject: [PATCH v9 10/20] mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
Date: Fri, 28 Feb 2025 14:31:05 +1100
Message-ID: <6aedb0ac2886dcc4503cb705273db5b3863a0b66.1740713401.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0020.ausprd01.prod.outlook.com
 (2603:10c6:10:1f9::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: aa179763-44e5-48df-9aa4-08dd57a87c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2PaHrVU7ZGUgVnpFO0LXflvelPa931IPI0PzT44sNY9abZy5WyOQxHld9KzO?=
 =?us-ascii?Q?RoAQJIb2LB6HV1Yh2tpG3drqBwu+2s9El9qvqUP0pXi0ayiG+FixMXWz5Rx6?=
 =?us-ascii?Q?V5EodJsT0F9gpMSgVC8Y8hZVGbeUDdCqzw6HUBqWv/cd/842mEMgyOacZAjB?=
 =?us-ascii?Q?Y0ItlT+RXB8x+SVJ+LDBBcbv/nU/4eVMfLfRpkLpBrVdwn6SPLNLskgG9XVO?=
 =?us-ascii?Q?x0N+RYBx1raY00xTemKJv6iEMtIFEunjEbGc7z0xnm8Gon1oeJqsVQ7hUTbw?=
 =?us-ascii?Q?Sy7y5emoaXttEpVyarJTxPc6PekjXJNxxptiIgAWRSzq8xgqUXV2RhNx+QkZ?=
 =?us-ascii?Q?Z/iT30pLKJsJRLP7LAl4ebvv7UqQkyboCQPW8LM6xZapZ5n7TFy3TJglCgjo?=
 =?us-ascii?Q?CEV1kWXlUlSckDVQfg8WYpI2nuA10iLF6kxuntA3YSk8EFbMXI+TBDwU4hze?=
 =?us-ascii?Q?woIN0QzP8TW/7ObopuG2qNXV9zdgSwGR70Ns8wU2blxJdgWo+djxH/LVZXai?=
 =?us-ascii?Q?G1mDqBwdHJ65tAbAqXeFF2YHnS6e8oSWf0zxEASzpvFIMm2TRjbpkspQarYX?=
 =?us-ascii?Q?Ut0Dg3DemlDCXgiBAm+suIzRpdy2MEj8a4T32XOzVJVzDE+4VY2M4WHyw+4g?=
 =?us-ascii?Q?UFFjyc7d/BaX4Rg1RLhSwvQ54gOQKmPBNKmsEXo5w38Iw7soulVf+j8go1Os?=
 =?us-ascii?Q?hOhxc1Qsr/tehfrHi7PTuuPFQ3vDWI4WIecCG/NbVre3wvbMOAB1oZxhoie9?=
 =?us-ascii?Q?C9iLhyBbHImWabo9lpN87F1qMAl/A3XyxQYsmY+hx5a0oK8JuY/NDTwkEIH8?=
 =?us-ascii?Q?2rS59qrhT7zl149ntJ2EWAokBHP0DEK/rIy6rLoBSFX8Cnm1u66jB6K3G2Jd?=
 =?us-ascii?Q?bkNRJdj3qKjb5ksmG4AVDPOa22psi42O/9LVsCzc9jVV3P/btZVOgZZftmC6?=
 =?us-ascii?Q?TO2P1Om0TDmo4sYA5GZwtJJCgBUPc0Yi8USapYzTzOjKaSXg46/Ld2DjOaS0?=
 =?us-ascii?Q?2z9D4pgnPeDRCNsBwR4o8LeBGFEASQ0SYxx7DpXl9Or9XfjBeesz0oVNsluD?=
 =?us-ascii?Q?8kBzFIBwwIEpJfVt5cxfkULE3RRSDmbei5GDpjuQKpbWhUMtLZK16VKhU6PQ?=
 =?us-ascii?Q?2STMB7dEZ8bX7Bx1dKd8u+2kpgP5oc5NqBAQp4o77EQngYcMso/LNyqkEqju?=
 =?us-ascii?Q?wBbBYmmw+88J1ooAHmNhoAR69EW2noTF6x0DKavwn1+f9IRKNbnwAaZTO9hg?=
 =?us-ascii?Q?EIKI+WwdMK7/fpWkWO0RGOK35SrS8SKLxIz3LKdrx/xqs9y7hMD4DdDN0z5o?=
 =?us-ascii?Q?Ql8GFXPqUdoxa9fQQ6nzvargfmzCg5S8QgPsE+bs8UE7EZFuhIUghZnZsXYt?=
 =?us-ascii?Q?Pfeq2LioF+KQGbUZHxApHWQtbqzz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3P2qb5aEmhhe1WiXfXHFIx6LN+vFHZElkP2MWZefb9STEtABcxNKeeTf0RUc?=
 =?us-ascii?Q?kW+E6xIsGOyjtjzKES5a48HdeROFlrWrqoCxpwEPPUIc5DjV+7NJ9VKFDl+z?=
 =?us-ascii?Q?j4tXPEx/UetW4UXfi3ggVTeZdmp2eIWJ2+tpRFzTJzTh2OEs6aaAuSi1gLS4?=
 =?us-ascii?Q?uMsTr+SZ2GWizQML66wdqeIxSIUDiaObicOj2pcqWBrQottIUmqWJ2Ds7Edl?=
 =?us-ascii?Q?sO+ctHpYxFoH36LTqrY3VJ3IQj/ag+ef2Yi/QqMEkHSWoIn6IhCAa8VZ40V5?=
 =?us-ascii?Q?16NbgX3PVe9yKg7L7NKeQDCAR0Wqj+gxoPrKi5ypjMsT/TfTvCMm8eUUrdyT?=
 =?us-ascii?Q?H0GFPvPMB2clr+ucAXBBsJ7oZuTvILzMp29TQnCGkNRXixEt/yhIxkVyEpE8?=
 =?us-ascii?Q?sEOUWdL8efiSmC/LmZogSiQIn1MAKDEEs9SCtKo7pzOo6TnHWBTtVmIWo7D5?=
 =?us-ascii?Q?q7pxt0DPAoEb0S6nE4r9ogerhiLJR9GNzr3cC7tjRJglCRPPIQ6bsGuc4nEx?=
 =?us-ascii?Q?0xz6gBWHhCvtM1CeCbdc/neTHZoij/ZXut1FuUZ0F8rZJd8aV4uhL7ZEqzLB?=
 =?us-ascii?Q?zE0hFWE3vHeWERUHWG4YQ+21JzGcLjql7S6P87xalmYlf6Ci15pMO/p45F5N?=
 =?us-ascii?Q?PNMBCb4MGtCaTbQVXG1TSGLAggyi65woYEZMysuSCsC28SsXLZmwf9f50UJ+?=
 =?us-ascii?Q?hDLQ8K0gSoEstwqsCyqFPyuyc+i7tVcPRz9jobROKhyEegHKfuGGTsQp1wT1?=
 =?us-ascii?Q?yx/ueegz8YfocdY6eMux9Izbk+PDwqdNPqkNU0fI6pblFnC9zN1JG+CF3u/P?=
 =?us-ascii?Q?dOPburEGzSmt3JpqDnvVjZQjggOlrfUOdd0XIZAxHQ0kXmmgnfkrxnwcRHFe?=
 =?us-ascii?Q?I0OxvoNuBN3OCJ6t2HAIgPM7c1197Yj/S6ne9VFsZL7k9yQBFiJLA/m5CFOp?=
 =?us-ascii?Q?6a5ED0ZoVizfYXfLPMQDMUdPjdCg/0ignGg2GG7AjFTDQKuzkzYsY0zr77T/?=
 =?us-ascii?Q?6gUS6nakVKCKOQ22TZGxDryQCkkxmfKhcAK8loroDDNpWmhqokHgG9Z39IPr?=
 =?us-ascii?Q?IKAdQihzfKVAMGcTryhO+JReDLsO5QT6+Ect3mKEOJ+BgQtg7pOXCkN8Cw+s?=
 =?us-ascii?Q?A1cfbEqZmFRONZ4H/J+AezjSbT5pSXw62HsBZrIp/2YnQsn1FCk9pibRfl6q?=
 =?us-ascii?Q?4FgMRZAIrZvZKh5ZGCmC2zpHyy97QC2qFiOPE7L7HFLFFrZp+3rZRRD4TkQi?=
 =?us-ascii?Q?yS4HU7AA4zIu2pdC5qBpL7qS+TZSd6V3VHzxwUZIuHLTiMY/OrG9ioMUeM8O?=
 =?us-ascii?Q?/WTGpu/A1jsply8fAr9gcfIwZ8HxeqoGJLl6av6qiKjWPcQphUzNYymJsgjP?=
 =?us-ascii?Q?2kf3TLLfLe7qyNnRHU2BWdoYToqmM4/+ae9R8jGIgBOxN/Q/a+i/aSDRgDPl?=
 =?us-ascii?Q?93EhMvUeiC8BXyUaSNDTW9Nh40CDPQUivPd3S+kZZ+p5jRw53OVx4SEI3NA4?=
 =?us-ascii?Q?xaDK8iJ0r3Nchxk/XaDHeQ/h7v9Kp6tAap6VNeJf9Zdtsucvqd2OG8gdX8Qq?=
 =?us-ascii?Q?wVINvirD9A/bxm2dhn4sGA1voEOi0sKE0+6bpujM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa179763-44e5-48df-9aa4-08dd57a87c22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:32:11.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rBgEosXjI87aHKmpk9XebnF/BLjdYPf3y3kC1v7vQJY228rwd2lo6fY0sc9/e/Vnfw6+bJbUbYTp2JspuV/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

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
Acked-by: David Hildenbrand <david@redhat.com>

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
index c767946..6be9796 100644
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


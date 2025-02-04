Return-Path: <linux-fsdevel+bounces-40840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893AA27EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02693A3AD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1A21CFEA;
	Tue,  4 Feb 2025 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SxUjUeXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB2224885;
	Tue,  4 Feb 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709369; cv=fail; b=t9Iym6KIjovM1uOOGNJ+hBadmmipYwDV+sS/uosYolgUhjemyESQLQ7JdMP47Y8UATrqddIqv0vYF2Yd5ahge1DwXj3zh4WD8KFpHRWwanAp9hRjExuJZmU415dC6YDy59bEht0DMgQQCiJrO8sXPtr4Zbv/YvFvVpUyhNaFQQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709369; c=relaxed/simple;
	bh=vbts0Gaz4Rfs6GRg9bVgbCB31sN+OKbEwATXOJLumLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JeegS+yGmf6pxcUvDMXZSm4NgiojKLq4TWZSJbNsocIZfCysOcJwK8iFc+YKprl1Ipy9ByzCMyzUokhaeuR8oeNZT2qowwUujJX2hAQHsLOQ9fMG0982qnC4idPukwZJrDxPi8JNzKEV8u13ZBB4hSqXfHQgD78FiVDUbZ635ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SxUjUeXC; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA6pstqnBz8KPcq4bHrfj4OQqpMq5SyvP+KuEWvM00c0uqxrXPbepG9YEvCCjS125ndEUIG5GPZXvJ++Yu0NlrirtNekgDhogcM+VnAsYPbLqFNagIq0OXmin0um0b4rvUSHlKY8mW1dDc1guTd3qHU1kb932WTztbU4mErCjiZIoAg6Q42UN9AJeRtw3ia24vpH3mJwqgNH+zBcXgii9mrcmJBCMjYB/8RvIk8kS7oyszdzQPI7/KEm9axaailgVYq263Xn+jegUkdYUzrAHHxduvpwu3fc2ZB3EKrbMLDf6yhqOS7H9fjUQQk6fSFarqSH0c0fEjU3ZX8qxbJkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejMa9kY4FLEzt1kGiLvnybwU63wJh3IrICfAQW+A2/A=;
 b=ocjtj7FG6EwOArYQ6rRPkBr5eB1MxmxLc/PqyYLil+2pHkdWoMcgs3cs9gVQZ/1RJ1EGQB+Vuc5LfrrKK1isxIFbGLJFOtlUmucWnvrMiIy58bkTniPsQHcpcTDFcI1g1HsQexPDebj1zNQIBZniUTuQMzXFjp2Q4Er4iSirw+4u39nrRyQnFsE2CR4gdN9SkHr1osuVw5Zn/nVHV5xno/6QYamcYlsmOZ9fCy2o+U+gMPMPQJaLCDSuWV144uBYcjHQPkdIfI8sRKh8T/dX58Smb34rvhsECxsE6GEeRk70degPgBG3MOEMTHI26VJpf7zOq8C8PAY3Wpts/YVO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejMa9kY4FLEzt1kGiLvnybwU63wJh3IrICfAQW+A2/A=;
 b=SxUjUeXCJpbbEKTS/gK720xO9723y3ye6czfLwXIdQ9IShtUdvPsFpj3HoufKk71GwtVixWjK6IAU0WleDWFQBnq9ucc7VpzY+LZsE2KudmgbdmLKc8jAMtFUzJJaHjeI4+0fX1zWfr0vS6nApFjLBHzeU7SUy7tUSYkhuJnPkgEgNSeRoGQG8LH6KjXTf/xIwai3qTwvr+aJh+8PMlnxWD+PmR6uU4nHX+tYOnGOmnsW4auuKstd0nfHcUidge8EhdP3gO75cTM6VhtJRM2t9X++wvxJn8XuH8CsD3XAZM7llxfP9opWTvDJ4uekglQrvRM18qRaYkt6KojGBd//Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:49:24 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:49:24 +0000
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
Subject: [PATCH v7 10/20] mm/mm_init: Move p2pdma page refcount initialisation to p2pdma
Date: Wed,  5 Feb 2025 09:48:07 +1100
Message-ID: <10388bef4c6e71dea2536ae44ba304c7416456b7.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0074.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 692cdeab-83ed-4757-5376-08dd456e2b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WsXk8tYqzJY3wKJaTLGTLb0NMVWIhoZUOZLbQdE0aHTEZxOMjBHdau9uKx4Z?=
 =?us-ascii?Q?Fb5ov0p01CNx1qe1xM8F0AAajtYqs4efVJZWP5ZBmIBEvXfXeaYP1cvd5HNz?=
 =?us-ascii?Q?2PSp8aRAqD5l5JCgMp3Nm0Z/fGO6P+od0EJom5fyIwbdFeZcrvc1IN77RUAj?=
 =?us-ascii?Q?KCqEo8kUnX1+y4T2GVcevLnKdClenEwY3cgm0hGQsbhrNkJortq1nzXN60Ay?=
 =?us-ascii?Q?FFiNg63vREzxi4MhLjjRWDsmEKeTZq6zCNyHWezNxvBPsiK/5hzINNqZUfBv?=
 =?us-ascii?Q?OUTTfnnbBDMgSyUmWMRskwAvfKOilY7A0NffdkgZo2HDm4ngEOpKRLQcpOvo?=
 =?us-ascii?Q?5n3I8/YCsJ+q0QQ+OOEKZ+4GI1VhAvP+n9KuZu18iWbawxv8gsm7M5y1cBSn?=
 =?us-ascii?Q?4vl0CU2HeoY/JvnNWBe2A5Qitj3KXGokSBeL+x6ygsSX4bOhgwJfIGUTEtXr?=
 =?us-ascii?Q?Ts+UVj2Dow888k6jQQfJ7je3sAhOk9Qe790n9iV8XIwRd+XGHaXmxByh+L4I?=
 =?us-ascii?Q?Pa3AbMz2OHYpfFwspPQ0K/4NCzo7F8ZyNqXn21eQtzj1+r+TlZ7C3V6oFvWc?=
 =?us-ascii?Q?RgrrAwM0l/irzEikKWgvEA6nB6YBRb8VNFzPy4qXPxv46rdk3+bwezQ9S72H?=
 =?us-ascii?Q?6MGfWarur+gmKXY61nHyxA1+4lOh+Ne33lkqUpSszSf9NucrxR46uios2iH/?=
 =?us-ascii?Q?f7LXOEL5QJgKyNWeJ8414ATUl4Ysk6A8BBteX71ILWe5WNLVKvnqMSdkXP78?=
 =?us-ascii?Q?znoLng2Ioj6lFSQ70QqWP8lt4qCIlpWVbH/YUro0Xe9I32jAIFhjlxdjMak4?=
 =?us-ascii?Q?cHTqbtlBLanbYVMdMJ54n/9RwGk+dtnCS4e0uEAYZ9z2fTSnNpaxaJo2NtLY?=
 =?us-ascii?Q?2g55eJ9bS37VkixFZ2lp283u8JkKw0MOMen+b9xNHG5Ft4oBCyj7rah+clS5?=
 =?us-ascii?Q?y0AnFlrpR/If9gT25rzf4hzFVllNAsXBUW/ryAuOXIMlTP43XkUNwc2HpUPr?=
 =?us-ascii?Q?NF8KsQCzl4WaKI3EswL8Rh3KbSjy3CeCEERQuIy+5JNfa3XSUeXKPPNK6wAb?=
 =?us-ascii?Q?oNBF/nz+TfO5IXMAEKsmxMnzU46vD6q1K6JhnYXa/1hqhb5nQBxoEsvibFtS?=
 =?us-ascii?Q?0LIy0dpL5vRBMm+IdhCjgywp5WVrBRi+5Be41Ja5PFhGupdwGi2nfmUf61s4?=
 =?us-ascii?Q?J0s5WmRd5//0IVAwOx5BcsoXEJ0YoTfOdD3otWjR8YE/rkYBK2Y9/Yhk5qpG?=
 =?us-ascii?Q?yWc/keb3JfZZVbc1YdYLYG7r5ynE3wMYnz3ltzzfry0DEotv//JqV4d1WtH3?=
 =?us-ascii?Q?6PUeN8TcY0S0QtEmWNw+imBuXgwidovqAU5dDfLpywE63qQW8Zt9qdFY1AjZ?=
 =?us-ascii?Q?wsf44E/lUc86Z8RVJBs/J6FO0F8o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sX7jaKz+x7NjB2WVoAldLA85q/jdMWUIugXvBvgR4B+adnMlkA1silPBjq6a?=
 =?us-ascii?Q?slypQc8XQ3My9NLlqhmH20h+RVMGMFVCnILpWQXxdqMuy3DC5JXXT4Aaef5i?=
 =?us-ascii?Q?3hvyF/XJks1lEA0kL5nAaGhmwEZEj7x2/Fe4sdDv7w4+GYsiZt9vZweJzIdl?=
 =?us-ascii?Q?4nZlpIusG/n50xrfdHYbF0e0gUYnRq3vZwHKRIAA6h0QFhyMo7BjW7sWlgum?=
 =?us-ascii?Q?qRdvdR1Ki2x9nry7QrVhzYgdapY/pcudegva0dj50NK2OYo4+4zlD4CCQ3F+?=
 =?us-ascii?Q?3MVp6h611rANYGsoQg3yNggNcjVgSofBZrfUKEZKeS7tHpVQ4ppA6lRsii8k?=
 =?us-ascii?Q?U8KuUd1gPDwL12TwuMuP5JR+gAu4kaodxK3itk8OEl6+sdpU12OzV9LnygQK?=
 =?us-ascii?Q?k62EVtMzNGlxDO8EU1cGhQvRokv50eC3qe69T0ZPPK4Q22WC1lqatOcAfJH5?=
 =?us-ascii?Q?CgDum+5zyAL5X77F0gpCk97nGsR+Blf8XnK8AN0SNiTVvSQvZkJ3aKpSBVUP?=
 =?us-ascii?Q?Ke6thrC9p4YAGpDqQc2e5W/zNqaCe9ygIQpDcffKilGlMkzGgdBXfLNPlz7V?=
 =?us-ascii?Q?TK/HVm2TaIkjyh1/c8jCAJizZLlEys+3VeszHPAiRhufOcu7y1ShIY2bUWPK?=
 =?us-ascii?Q?rYirGf2GEbafrKFcWkzE0YVMmZkacQowgTCC/2H8IVXA05RRcSQgGTLCHXFx?=
 =?us-ascii?Q?1xhqMR/T/+TPM1GqOFCMu525AjsewolcHJA2sUnZUz8ndayERW4U4xV3Hq/r?=
 =?us-ascii?Q?KUW0eIWFGzF3KjNRu5IwU7fda38oi9cXTP4pGa3QONVb2J2kPe6oNbUiRQJH?=
 =?us-ascii?Q?u52N3NXEPbb0eB3j3a9HVyu8ErfyfwiTnVFgjXUqPSIQlfkkBTX+SGovNw+k?=
 =?us-ascii?Q?VzTzpZBSfNPSap9uMw1cdyuFlq80CDlroyUSvV72yVpZXt4BOeWj2/ix4Wwc?=
 =?us-ascii?Q?17s58apZ+Fpaib/9Q0yMAN4ha3E9LS4eCYJ7hs+dH5Hj1QXRYyWxSzd0fvHq?=
 =?us-ascii?Q?s9K2PFYR3CB/5W7HYyoxrwQyroBaOfNPkBviIwi5hQ0pbl0o+x36i567UyP9?=
 =?us-ascii?Q?iNSRx5lNW4HsLzfesbeHG5aAN9UEKRCEN8rYOt/xpSXjXC7aCsSKBKTeaV8t?=
 =?us-ascii?Q?5aUzUFky8kGtaCN+VtHvDQoZnfsP23Sk3oSSBHm8HvO6l/Sl29Sp0M4FKzIy?=
 =?us-ascii?Q?IAI8BiSFjxgSFg1iFsZUyNyshCRW/F7YUGYe98Pa9+XtTU4ZIC1Jh/QJVlRt?=
 =?us-ascii?Q?o27xQFLJOL4qNI7VSIqBT/qQfTjX9i6//EMqPoZ5Wnm8ZfpoBAkBxSI3iaRt?=
 =?us-ascii?Q?E7tWO2+IDRzHC6NG510YmBNkPmxwglcOGj6qItK/W3pgc6V1DbJ9vyWHLqOl?=
 =?us-ascii?Q?1d+yu+8AxdDpxy0NHYrnJKuB2z4822NHa9Z3OJvpVLIspgPNloNw9LygsPWO?=
 =?us-ascii?Q?ethKbqgy7oAdGTxmCbZ91d6h3ms4uPTVY6zIiJPM2FE3s4i7Iqyp9NhRHOiV?=
 =?us-ascii?Q?EHg/5ccekjjMnEexyQBqRTgjfGkbRPd3ycacoMqc0tD/MXdSi4ckvxrvgtn4?=
 =?us-ascii?Q?XXlTb9l7O8F4bJfjHf+bkS371wV1RYwXvf8EjrKx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692cdeab-83ed-4757-5376-08dd456e2b62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:49:23.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FgAy6aTzl/DqxmywZ05fYJjMvjZa9WZ6Ib6y63mKfSeR1jiTitp689qyJdsByg0oEwnVJgD3lCg6TIj4wNuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

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
index 2630cc3..359734b 100644
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


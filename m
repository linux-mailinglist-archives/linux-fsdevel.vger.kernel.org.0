Return-Path: <linux-fsdevel+bounces-40848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB34A27EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B5E167824
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548602206A7;
	Tue,  4 Feb 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZbNZ4E7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673A2206A1;
	Tue,  4 Feb 2025 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709413; cv=fail; b=GRveYbyQcutQyx0DmQWgO3aMdcdEamqnknxS9QiDSWXOgj0yj+vZhi0kIVql0EuUjCEKz6TRV5rGgDn1xQdxq4yahAnJ1g5VFh/lkXCc4LjT5IkyZDto+Vlk4Z3sVmRFv+A3DjHw0C9D+Zg69YMJhU6FWhrJtlt+NavMjr01t0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709413; c=relaxed/simple;
	bh=X623mmXDr/V8tui02oZFzBQpW5DYhwmPCmwhu2QfHlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mykyv1JKgn8uGdLJ3OWE3YFZUPiU/hqlR5E+PNDncm+bOefb7e7NjlgAJEZfOTMv7GzRkZdelN6frtc0glEXvHpSYnLGwC/iCYxR/m1p/hnh2a1BW5WxCkBuwIATy2z4/lC6b0RseqwJWllw455n4tQkj1BPES4kIg6+08N2u+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZbNZ4E7; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acdbjI+JlmyZHeF02C4EgbEEWvQzHeSFnFsI/UgF36voQprAum6tyqfaFqzCx3mze+XVQ9JcZYQk14NIFKTSwuOLXpMwCPbi9llZCgZyl16JcKEVRUQ4odpfe7KmPLGpXbh5hB9hPaW8met24muPQJgXmxTuRbolwKijcE3INXcMt56rG1V4ySWtoRylvs/JKoyVzsw6sqrR7jH+K19NztXnGdcA3Bn9vugDtv3MOaXBkCahnpIUVYS/v0RyD3aSpDr9Sa5KyjBTXxqTu0f5OZ4dyJi6hKAyn+VO2j18WK2NLZjdTaOJdYEslor+566SdelSNd5HwfV7jFKo85RJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtBaqYvfVYWwhkk0mbirzaJ8NN/nkFZeQ7cueszAH5c=;
 b=E6/cmO1JniINZsmkCTgY9PSGvXMj/40PnY2HYP5M4g6LeTBDrMDopfkF1yc9w07csWd6vXHK3t4KQHHrFtAZUk9GQLuOb5kKZww05aTEbt8yPRO3fjXZ1ZmQChNoMjnZ84/aRdgbbEFHrX/QltvSDlQjNDYLN+Gn/L7nfhQS+ll+E0mONcDlXDQphZ7OIRDzv1FjV39p6quRecV/YsHk+DA4YSiTeYLARoQbj/YmDJD9MBMWTYQXxelx1r8CHwRk1yC5mhXNMX/gE2it9PDHCEYR9kztslvzsm6DQH+15nHoF7JZQZIDkMq/+E2la+MKNOUk71veRB17NZhMDkD8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtBaqYvfVYWwhkk0mbirzaJ8NN/nkFZeQ7cueszAH5c=;
 b=UZbNZ4E7KqfTxOmJlWnjvwU9jcNFD+MIHg5Fz1xQfwW7Pntoc+GbX+RFUw5vg4sZaKaz6VzxU8HcEXDAbhKgs3fU2DeSoDhWVS1feVWS7MI8qDATK3ycEaj7xE7FvPbTKCHrOCn1FSZqYU6jR5xjPSekvVmw5darkDZCgDbxhPMhm22ssp4Qc97XL6UloGUsTf+QFmvJTWYgagRneNTB24Bm6Ae0GQVYS74TsdNtFOaVCU4AAaJQc5C1X+FHz4o+c1JF7kxZvsNfnsz9hnMABUkVPY7YhN/vpIY14Cpwp0EDAA+8PJuEzaHU4diBpbi/QZtb8FWaGpmUSI/gruZleg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 22:50:09 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:50:09 +0000
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
	loongarch@lists.linux.dev,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v7 18/20] dcssblk: Mark DAX broken, remove FS_DAX_LIMITED support
Date: Wed,  5 Feb 2025 09:48:15 +1100
Message-ID: <229397bf27e565ed8dfc3832c4e57551fac86c90.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0014.ausprd01.prod.outlook.com (2603:10c6:10::26)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: feca1f5b-63c2-4bb0-0e55-08dd456e468d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gMOCCAj4fuTvXAmjSw8M3ggfwP/ubVnvhux/CvpKyojBBc3mNEMzgEyapyNe?=
 =?us-ascii?Q?X/zrA++YUR6TweXr5YYFuuGkM1u7kpw1Z+v9YiZ18KWMbcJSsON7Qy0+L+DX?=
 =?us-ascii?Q?2GRDfbrGz+salkk1wRRw4outIeccLkDV3X5H4/XOakiv2vb9l0U1K/JDC8TN?=
 =?us-ascii?Q?tjmy8wgO4MFVTncEe97AgBOlfnQWW9lNqH9qdnqD4YzaEFnIv1+W6ZcJQ+JV?=
 =?us-ascii?Q?0kV0zbYm7S8+VNwcUql1NNbNMweCJeIKtv1MHSQjL5ArCRCY/iRbfe4jFAmQ?=
 =?us-ascii?Q?1qErUo8mw7/uoMjmPcwzbyMnqA9GVHyI6NDAIHUVbaIPr+Nk0NtgCm1ZhkXj?=
 =?us-ascii?Q?xpvYWQjxkk9w29MJKLm91c/CZZ+J4SRW+0OCig3MyVfjxohCGKLBjPJ9OGO0?=
 =?us-ascii?Q?hNP5cQiY8vowEVDvxNxD6pXsBUA81VcQJrforCKQZMtScJxGAMNYMwbOa2sL?=
 =?us-ascii?Q?i6tKNYvTnJInUPxR2qy+Vr03s/Jg8zIjXOGInY6bqN8aKz7qGd5rw1y8D5up?=
 =?us-ascii?Q?S5bykQSUMZcvxs99oq7Q5tKRzivkpLZF0z3y2a0VvP6glgZPXHrwCsnHgniM?=
 =?us-ascii?Q?lJ8j9RIilA0ZdLF9CYffePabuFOsw72BD+QsuNIVfsgA0GpXmcPHVIQq/EE6?=
 =?us-ascii?Q?lQ4vZvjAZt5422pFxw9EN0wBw66Cn3MMFm+Snln3Ujk6VAmBFoPMOuFhVk7K?=
 =?us-ascii?Q?iryof2Q63QgPfR2VDlWnfTf+zpTVS7VudEygNiFM7EnTP2GrMy20rAcTwYMe?=
 =?us-ascii?Q?Cv0aJAEXPbFYbItaof5cwzs+chJSVNxWExPG+gCfnfLhOKbjTV2EFAjnVTdv?=
 =?us-ascii?Q?WWEQkdennR4r3XJpErnu3sanCJdqzOo1ATcZ+/tTYrTN413BpBIgex4I+AUc?=
 =?us-ascii?Q?jvrGqSS8ly+zxtqQTPzBgYwEsEufn//8alFjnqn1bHFbJahrX4vYX2CaGxZD?=
 =?us-ascii?Q?WE/ECCF+FErw1OHssVXYt8KCGyGtsUmK0uwXUtwFTFLX6+eUovwnXOcJv4tH?=
 =?us-ascii?Q?8TmlqneEkrO/o/nfFvPb4HUyJksm7qTo8Q2ySiAg6j2SgKcQzRmDWXy79xfh?=
 =?us-ascii?Q?6bVQviprCyWTJzzGHi8SYr5B6BL0gWvRVws9IGqUYkp0rKoy4mNrNM1Ry/IX?=
 =?us-ascii?Q?qJwlnIAWFcoXKnRrG5EoEOFBwlQLmGgn2JLQIr/gVOEVITfHRn8xMOyDBYHH?=
 =?us-ascii?Q?BCn/Rs2eWDFwZozXzesepyCMlz67Sy2pS25IlEOvAvpSPU+zBAwszghPaLuL?=
 =?us-ascii?Q?K+3e75Q32i8EONhcTrTqM8t6moIp2Dg1Ki19Vsod9quQwt5oRW+5u3VXg2Pr?=
 =?us-ascii?Q?GScvIM7fYcpWD4DqWPHC1GNdjjuCv44pyDKPFOGUNiE70doeFG+uTenlWnAY?=
 =?us-ascii?Q?Av3RZxXSMOyJH6FHwi2lIpOe2qMS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMEnuwCrmGiliI4hsbYJHDwe92wbcNkdxuCOUD6gDQDd79wfdRACqHZat+zF?=
 =?us-ascii?Q?4wgocSg0ozhDGdcNDZq/nFRIjya8hlZwCK/VAuv5RVDtRzX+ib0gUJK0w+1v?=
 =?us-ascii?Q?KXS0yVeaCEs/9e2QF+CxNhqouKxUts0QIM5qLsRXFoX+QHqgg7tye1ox6E7Q?=
 =?us-ascii?Q?dLWHj7R39HL/FbgoIzpLqJ5t+Ule8MR6dewqNYHlnJYXF2fSHT6K+OflIG2V?=
 =?us-ascii?Q?dDW/ShOcowIO+Gxji3hTXevh1AV90QAjH6JnSTDU6NTGDEKhMU9l7LCZrQLR?=
 =?us-ascii?Q?y/WLnL0Ts3mJzNLd8votHzseF0XK3zIjTkzfdLCKW1/J6W3dNfeJWGrnxxod?=
 =?us-ascii?Q?E+Fi7+0N8rFNDnDAsjImko3wzJuA6FFBXUBrzZq2hUJ8cipcSSuYhjUL5h9d?=
 =?us-ascii?Q?hm9vb/HOcLeXhow5iurVmWYHOj0QV6672XVYpIgDcdLUwQvZeYS528ceAmSv?=
 =?us-ascii?Q?aecqwZBeW/8ltD1v7WW1UgPYSqgOIue+4N0wgl6HbapeKHaEiWiCFoa20xG6?=
 =?us-ascii?Q?qkDE1a2eGPM2SoBk23bahd1OU8SX6HXU/VioJ1jEYbRE8IT+RFssMCw95WUp?=
 =?us-ascii?Q?LN5tGnib8XFc8ftOdYSAr1QgKsPuhkmAx2z0PTINf3V1avWThu1B+zqq3XY0?=
 =?us-ascii?Q?RcvnuYGtjlpb13KlwqIbVWhXyHuHvkVq/6ZR8PM6ORspfWEmTNemJHSO9k7H?=
 =?us-ascii?Q?Us36AhVGhhAoFPrCfwIJ5x71g42xckt3rGRYt3TPvLUg9lIIIXejVkz8dIlI?=
 =?us-ascii?Q?Qf8sHhYRnnI7/leApfotaD2wgI6PvLhlI2PgVXzAOvGugQZUFfVuWFHbgW0G?=
 =?us-ascii?Q?gw2j75rqNHF7MrGhV7xtZhj9GKxK2FDLHykkNpkHhjnu/PZm3kszhu8nDKL4?=
 =?us-ascii?Q?MGCIhXXK6/yuZJBVbRpKGss60M93pSnPVixJoD7ow54Wz27eqf83yFtHIhEX?=
 =?us-ascii?Q?cqdLJ4/AbUxm0EGEBLX5+MsqEeeR2C46twVWkvJgF2ZNSD33n0LLxjqRGDmk?=
 =?us-ascii?Q?AC8oUEyvzGmU/z8gnal/wjNcyME6GoNoXxeNYmlO7WNyWN7NIJnqJh99FZVI?=
 =?us-ascii?Q?pKqbZ0m6CNTfYyaKeEp+w04TJug9aXiNsAdBhhmqTv7cdEGdNtsUhTcNG/0/?=
 =?us-ascii?Q?0q9tfVflKxyIvFwMnm6vG796G4SZdfWFN3XhSc1nKyRNLkbpXm5nyHiPhR/c?=
 =?us-ascii?Q?o0zP9FJmUq2XQ5rN5NkxzS4n0SIfRJ3ziNze4+PSWKOYK7+07lLA4jk5ClBM?=
 =?us-ascii?Q?MSNjifPzyJnKgDv/OHWzrmS6gUE9p07Krz3goyxBsUerCemQFM71QN5APoV7?=
 =?us-ascii?Q?NluiT6llYd2rY2Fag5kv6r3q1//eIhqrdEuJsNL+FYoXeV+7KZjf26P9buA6?=
 =?us-ascii?Q?0QjkhKQAUM41GjhRme9LBsQy7quxSBEzdNgoNHphJ9Ctl7nQ/kU1cis7n1Zm?=
 =?us-ascii?Q?I1LYIOjWcpLHO7VqSMNqIRY+kwM+qv1GGwOzlcrDWYu2VBEkxynU87ay9nzT?=
 =?us-ascii?Q?MJ8LGCpjEF794HQ6iLrxUyZHnaTh5KFkDPsp/+HaefAcc48nFDu8Gdd0cflr?=
 =?us-ascii?Q?/2JP65BwpzV3u70yMByi0fplFe/WCs1pmfdCAuOE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feca1f5b-63c2-4bb0-0e55-08dd456e468d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:50:09.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9L9wyMf0dUYlAXPWr5LM0Gh//MwCpX2TA4rV4lxjmh+d+j0VOMFgVh/YhsipKLNZza+KEpcx5g5cRxn9ctXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

From: Dan Williams <dan.j.williams@intel.com>

The dcssblk driver has long needed special case supoprt to enable
limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
works around the incomplete support for ZONE_DEVICE on s390 by forgoing
the ability of dax-mapped pages to support GUP.

Now, pending cleanups to fsdax that fix its reference counting [1] depend on
the ability of all dax drivers to supply ZONE_DEVICE pages.

To allow that work to move forward, dax support needs to be paused for
dcssblk until ZONE_DEVICE support arrives. That work has been known for
a few years [2], and the removal of "pte_devmap" requirements [3] makes the
conversion easier.

For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
(dcssblk was the only user).

Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/filesystems/dax.rst |  1 -
 drivers/s390/block/Kconfig        | 12 ++++++++++--
 drivers/s390/block/dcssblk.c      | 27 +++++++++++++++++----------
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index 719e90f..08dd5e2 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -207,7 +207,6 @@ implement direct_access.
 
 These block devices may be used for inspiration:
 - brd: RAM backed block device driver
-- dcssblk: s390 dcss block device driver
 - pmem: NVDIMM persistent memory driver
 
 
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index e3710a7..4bfe469 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -4,13 +4,21 @@ comment "S/390 block device drivers"
 
 config DCSSBLK
 	def_tristate m
-	select FS_DAX_LIMITED
-	select DAX
 	prompt "DCSSBLK support"
 	depends on S390 && BLOCK
 	help
 	  Support for dcss block device
 
+config DCSSBLK_DAX
+	def_bool y
+	depends on DCSSBLK
+	# requires S390 ZONE_DEVICE support
+	depends on BROKEN
+	select DAX
+	prompt "DCSSBLK DAX support"
+	help
+	  Enable DAX operation for the dcss block device
+
 config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 0f14d27..7248e54 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -534,6 +534,21 @@ static const struct attribute_group *dcssblk_dev_attr_groups[] = {
 	NULL,
 };
 
+static int dcssblk_setup_dax(struct dcssblk_dev_info *dev_info)
+{
+	struct dax_device *dax_dev;
+
+	if (!IS_ENABLED(CONFIG_DCSSBLK_DAX))
+		return 0;
+
+	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
+	if (IS_ERR(dax_dev))
+		return PTR_ERR(dax_dev);
+	set_dax_synchronous(dax_dev);
+	dev_info->dax_dev = dax_dev;
+	return dax_add_host(dev_info->dax_dev, dev_info->gd);
+}
+
 /*
  * device attribute for adding devices
  */
@@ -547,7 +562,6 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char 
 	int rc, i, j, num_of_segments;
 	struct dcssblk_dev_info *dev_info;
 	struct segment_info *seg_info, *temp;
-	struct dax_device *dax_dev;
 	char *local_buf;
 	unsigned long seg_byte_size;
 
@@ -674,14 +688,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char 
 	if (rc)
 		goto put_dev;
 
-	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
-	if (IS_ERR(dax_dev)) {
-		rc = PTR_ERR(dax_dev);
-		goto put_dev;
-	}
-	set_dax_synchronous(dax_dev);
-	dev_info->dax_dev = dax_dev;
-	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
+	rc = dcssblk_setup_dax(dev_info);
 	if (rc)
 		goto out_dax;
 
@@ -917,7 +924,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
 		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				PFN_DEV|PFN_SPECIAL);
+				      PFN_DEV);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
-- 
git-series 0.9.1


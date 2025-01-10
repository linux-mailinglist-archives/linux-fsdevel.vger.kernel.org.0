Return-Path: <linux-fsdevel+bounces-38812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6457A08761
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E2D97A365F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576B3208976;
	Fri, 10 Jan 2025 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ki2exUkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F4208973;
	Fri, 10 Jan 2025 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488917; cv=fail; b=W5+dP74KTGCSDCebtk65rP9dGzA0a7sKaFWKi3ItAyfxYST96R9HPZbEAFYvqSfPgyeV23GHGspklD0zxr0z5kQiQmJSmP7ucoPlXOubARG71RWmr7BLj2E6KnR+JvfZ6IF2VASWow6G+fO8KBOZzeJ3ZkLdzRXqVsxOUwNO1ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488917; c=relaxed/simple;
	bh=FDleqUDEtdB1YSQa50VaPvs5gN/6lVm60NeLESWAhys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XF1q0APc0wPZ4hAkHdafQTPm3St1aukDX4nu28s47aHpNfOzloKGSb0k29JlyOrjHB/NU+ye1ATK/M7h185e/MmC5BAOJ+qsoz43Ou9T4A7LvscrMSmVacTGG1x+r3j8rDqOUky7aIFQIWeJ+g0k5XSJtsERVwDXRYwnCzKSmfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ki2exUkX; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i61thtl+sa3BxgzzLz937/Nxu0bfaKEwi5T2sXoCHJg0lHYnINtSl0gIc5gV8FsCC7rQ5MZBf9WjpDC1+aHP1QJR+PCEf1nvmMK6mA40wzHkfrt/7C9WHjMytSsf57keL7dg9BUiDOjmfCHOFHbL40KYsDc382B0wps9siLLwR5C9ilJu9WrsGW8ohxXHDu6/OtPNk//pK1ISuJtCwZ4D87vMS/Xo2LPlQGkHXeVRUB3c9t/QCS162e295onQ7hOXAmheR84/2FhhMzkp90Xzj2lQ+OTK4j9cmdTrdqTOfqL2YgDAybdM9GwEVy7Xo6V0JTN94+K/uu2OUBRFwhAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+5E4H/DuQ0pAoXXKbxaYAoc2WqaY+EzxUHO8qCAqb8=;
 b=UxvF7QSspfZcjWcJQb3us4Pvrc/0dThIPo5LNr24XoUW9PNBMvC6brqssudi0BbhNyeCIVmkulQf6IYt4GDEWW/u1qpXZXGdZU8e5coKYrkwCk61KavbvOukpvjJUUuRYCMEeQv+GeVrE3EdezfzmzKdt0sVlsH+J99N1jhVSN1+jpA3t5fF5bgJWxp7ENwLPbYPaJMKsp/vdYnAe+F6UmmiEtXu5Vfpfb/j/pZzdD5eKPhBHh4RsyXQWcyGyW53tUMbf6iEeuGlsY5oKjEcUR59dNCoPpyEhypog7fPUkNIwnP8h1s8EN+qJeraQHv4HsiMluzXgBgP3vQ8BjIZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+5E4H/DuQ0pAoXXKbxaYAoc2WqaY+EzxUHO8qCAqb8=;
 b=Ki2exUkXCnQcWQYv/ijoWWndA44Shn2xqspHqYTqKR2jwPUsjqQYjPuLff4dnmOjb9amKUWmLSBTpo+CQQbZTDGwzd3FPl8TU3ZS62/SIq5b9zfA30XUIyjsQv0A43/g0lgc3TK3N5mgSiCKAFInpARWx6JJ2E18ZWD17NO43mNpASvhDpM6TSG6TghK9UF7Xq46UG6SBotAlHUoc+kk5MwAsSIfxPSHfJufGS1sqfCAzen4bnJwmDF00kf5b3TwENRmrPo9D6XIKll5+dvCH7rnF4uimm3BUM8qxi/O2YgHgq8LJ2Fp+3HHz4NL2xpDrFK1P9BtxinJHcMdsPApyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 06:01:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 06:01:53 +0000
From: Alistair Popple <apopple@nvidia.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: alison.schofield@intel.com,
	Alistair Popple <apopple@nvidia.com>,
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
Subject: [PATCH v6 06/26] fs/dax: Always remove DAX page-cache entries when breaking layouts
Date: Fri, 10 Jan 2025 17:00:34 +1100
Message-ID: <47bef43b54474a8ba7f266b9b5fc68ed91b1d7b8.1736488799.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0021.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ac2924-3e27-432c-c614-08dd313c47cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sh2VSoZUpO6jStPWLaekWTDgE/jLZBXVBpJeckqen9QoTvRdTaHthUDjt/w9?=
 =?us-ascii?Q?5jgakRHaMxvUs5T68+Y0oTjXs4vLswl7RaigPdLPxMxSxQeFUVVBGmj7SLVV?=
 =?us-ascii?Q?1nv25OhOJUGhSfMW5EjTogKrsJzz24RZ55t041VT17UGunw6Gsg71HAuBCPZ?=
 =?us-ascii?Q?N8S+tthP6M6JWwKG1hUAFJ2LkfAthd9hxYKGAmgparUaXoZi0vODf49sWsCX?=
 =?us-ascii?Q?kItiQgfDjvFlC0ELd+dGFSWHwJ5LfNDPaqaeGDqdQSvwykS7AnP9185Qg08y?=
 =?us-ascii?Q?QbDI1A0UShApVuBTg6Q9QgzfRwlzQeWecjsiNn3ovKE6M9oP0ukD2TucoJFL?=
 =?us-ascii?Q?lkfItFIuiZlJ/Y2qp8dTwqKASGOe2oVAhviL/IefeIPce0znJ6BjGBXgP/dd?=
 =?us-ascii?Q?q168wfZxo1Meqh2xZ7i6FMXnoPfJQrFOWr7S4UttJfUt6XbWJmIoznhZ1H98?=
 =?us-ascii?Q?xPdq2KRBtKortvcGGjuroo4s9ZQgO1+PQaNyF5AVp4zMQahnU0/A1Ol3hHuu?=
 =?us-ascii?Q?QDT8mz8wYltEJd7HW+un479mPYhjHJmqGCkoltf8s5tm+OmmnVP3zrUiaHK0?=
 =?us-ascii?Q?3ydOvbXUZRI5pVGIgGxa2N/kfVKgjXwPMZjTo/VuWbG/o9IALKAgNwbENKIS?=
 =?us-ascii?Q?uhSzSw8d5YKcCzyIVihB7ysFDzEXnaU1o6OY8N548nrzuOx89PfC8DrGsqCg?=
 =?us-ascii?Q?LxPP/wBMlVo+JK/SlZCYyAw2Un2vICud1YcGd4QMrTOhPTNBbAqSlaF/SxsU?=
 =?us-ascii?Q?tnbeYpNhWdHOfpwiFEOOF054P/XCbag+CuGQqI3Eg1oKh5AyGV5t2605M7bI?=
 =?us-ascii?Q?cXKQ1Ufz7LH3eoap5fQ0ATZoWJugLNE6xqaQIfzgulrEmpjVdPFnalgv82oI?=
 =?us-ascii?Q?GWVPc750bLZarzTg9ic924Mb6cXrW9U7oddB7npUofdy/vDPipKW/BmsPADh?=
 =?us-ascii?Q?9iT+AxUSdKUOheCkHNFF/ifWIgpGA0Mq3EAKPxUgFereSR1lhcGdY/6TLDzW?=
 =?us-ascii?Q?0mfIlMYwIVilUv7Uk81ucemwsD1E9jHHxnxVK2srsEAOjOwYST5bFSXtqPXn?=
 =?us-ascii?Q?sAAM2HJUPtcNc4FaXnHPhKMVqjBGdS+E58bgCxZ2rh0ARcd0fS5b9UCt9TuN?=
 =?us-ascii?Q?ZRkGEPKl2vuKkYZOwmG2RaIqevNRG6Z9MQY4fzL4usVMm/4jy9A0+AbQ6YFs?=
 =?us-ascii?Q?rgiLXHKTpDEGKJiGtD3vlfOfUGWFvaJDMfkJqQ1KR9Rm4VjJ5XELPVC8IIWl?=
 =?us-ascii?Q?I1+cESHBDAQPHAO+vB9DT2Ya+j1K6hs40WERCcZzY8sT1VIzm6tjSYpoKVqq?=
 =?us-ascii?Q?96DRUMbevLIZWlAOtRHLX19+7XCg1zV41hMRruY+nV4OKyI/Apu21JUEQuPJ?=
 =?us-ascii?Q?dsmjZ4yiVXjLo5UorcXRHKBqbfdh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j7fqjqB6IxZJIp97dNNsS25ezS7VjNyb7X+jnbHq2PRNJJ0/rZPYAhhtUAX9?=
 =?us-ascii?Q?f8KCua3Xo/okqW0Q+De1cVIrMIRAglEFbyJ2sG5owuOBDFdZl3Jv6N78+Yuc?=
 =?us-ascii?Q?cS+zH2ySRcDJPYs/dnWj7Cc4D3vP9Ptk31qrvbhE57rVbnI7x6EkyoYyaVq5?=
 =?us-ascii?Q?LgULKEawBQj1TLLdyj4AmMjR9GGQM/0zu309bxe7li3skrhETHfyRMjJzpfp?=
 =?us-ascii?Q?uK/tvD2vFMBM/vTeTzN7gSeBMgRHnFTY1d9cuUKWErYPhaNvWKvXTgsw15Q5?=
 =?us-ascii?Q?x8oye1LYjH9NMD+KIRirN74pw2g8nohkrwsdHEC82IRdF2/M3W+zBjkFbvGv?=
 =?us-ascii?Q?X35FgY5B17dA8CeV0R3OujIjfJch08zM5tCOQIkMNLvXUp2Pmf7iArfBsqtN?=
 =?us-ascii?Q?ND7esRg6Qmi+f15LFe4y9hABmIeuTmpM2cxf4JCX94wsTA7xEtzNczdFctr5?=
 =?us-ascii?Q?UgpxudWqTCQzdfntmhSlDyi0QWSxCbj0rGtQ/dRAakrRBB4uQjtASuuU0/Ez?=
 =?us-ascii?Q?qak4BLDxHDQlz6xkubVkY3WAIA7JbjRDsBWWXlOHxE9kBnQzo3O3/OdrYdox?=
 =?us-ascii?Q?pC8gz3lBRCt5LIJqLExWdMRWuyoAp+TEX6VGqJ1VyPLbojBvczmgCvi+c6SG?=
 =?us-ascii?Q?lXIizf2o8+lgcHsBlB0jKe4GM5MkTOUQcuI6SJiKvVJfHwXHY8RKQjre4HFC?=
 =?us-ascii?Q?DT7skHZnEiderrcJInfaVBMz/7AoAbnT0LQ4Q8Ltrshncm44g2Xk9cmuEB11?=
 =?us-ascii?Q?Hyqed/vxF1Lj+HQtnkqWOYzAqTZXHprtnIxzAV8Acn2pZJOCVNng2wwHqDGx?=
 =?us-ascii?Q?z/ISAOzjwlXtRNdZg5wlMmz8Pv23/7YPzCEPPqZw5IYxLaLS98+w2T2kUhUB?=
 =?us-ascii?Q?W7uTCIgb72mZ/1rZmVt3TqZlOzEP2ytZyoWrtRxaHgOnPkMN1Hu/Fk0H0sBn?=
 =?us-ascii?Q?rIiJf/EM93REByaVCLVlIGMZG80pIDEb0P/b0lRvF6aks9tXFUfjDFWLfXJm?=
 =?us-ascii?Q?MOk7wByZO66yEMbN974i4M+UvBV9ml36NWiTrhqBOEixjINWHSxx1g0gAbp1?=
 =?us-ascii?Q?9D6rwRAI8y4q2x/j2BdVtY7k1WYfwXdr+GZq6anpJ3IEsnNPZjatzV9Q/o4A?=
 =?us-ascii?Q?IyELfUwpNCrJuWvnAZIxNPQB1rXIofHnQGEQZnG6OzRn1eXPXo0bB9QH9Ge/?=
 =?us-ascii?Q?38mMF3U4YIxbo8UjCLx5YkbJSKJZMSbWFVfu2FFjKT+vWgQkF+ll3uNPVFEM?=
 =?us-ascii?Q?zfoXd2o+dc+g6KSmSDtEieLYViTirl1kQSnBFoj1sdE9Pk1vFIfZ6IFnNqDy?=
 =?us-ascii?Q?EntGlhc/cyLtl84lF1ERgLfIHDmvizHi3KWgtAbRTlzef7tVEGGXVrMeyTbj?=
 =?us-ascii?Q?U6Xc2AnbgHs6fQ0incR9FgqJVaqtZYJK/C6fgef6g+md4Yr3sCs+hyNUbyev?=
 =?us-ascii?Q?vwOXDD5vdxSNQt96/O1GTFrDiXXlBfj77Ep2aHwpYZTuh/NUHEC0+bm78gnG?=
 =?us-ascii?Q?rpBfjtPi5kxAq/riSkuToBCL2uHxYplbLtOJUZfgVPq3izJm9xqt3HkVBbMR?=
 =?us-ascii?Q?Rgn6T30JUoipXs6B5P3H1A1cdXzCB2OadhFgxRDL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ac2924-3e27-432c-c614-08dd313c47cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:01:53.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28x45XP53E/wqjGddiWRG8HHGf8+mfhFHUe4dhTmreN+VhavB+ZRxlMSeflyyonmYAVx3amfX0w9w3DhV3phBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Prior to any truncation operations file systems call
dax_break_mapping() to ensure pages in the range are not under going
DMA. Later DAX page-cache entries will be removed by
truncate_folio_batch_exceptionals() in the generic page-cache code.

However this makes it possible for folios to be removed from the
page-cache even though they are still DMA busy if the file-system
hasn't called dax_break_mapping(). It also means they can never be
waited on in future because FS DAX will lose track of them once the
page-cache entry has been deleted.

Instead it is better to delete the FS DAX entry when the file-system
calls dax_break_mapping() as part of it's truncate operation. This
ensures only idle pages can be removed from the FS DAX page-cache and
makes it easy to detect if a file-system hasn't called
dax_break_mapping() prior to a truncate operation.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Ideally I think we would move the whole wait-for-idle logic directly
into the truncate paths. However this is difficult for a few
reasons. Each filesystem needs it's own wait callback, although a new
address space operation could address that. More problematic is that
the wait-for-idle can fail as the wait is TASK_INTERRUPTIBLE, but none
of the generic truncate paths allow for failure.

So it ends up being easier to continue to let file systems call this
and check that they behave as expected.
---
 fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.c  |  6 ++++++
 include/linux/dax.h |  2 ++
 mm/truncate.c       | 16 +++++++++++++++-
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9c3bd07..7008a73 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,36 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end)
+{
+	void *entry;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+
+	/* If end == LLONG_MAX, all pages from start to till end of file */
+	if (end == LLONG_MAX)
+		end_idx = ULONG_MAX;
+	else
+		end_idx = end >> PAGE_SHIFT;
+
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, end_idx) {
+		if (!xa_is_value(entry))
+			continue;
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
+		dax_disassociate_entry(entry, mapping, true);
+		xas_store(&xas, NULL);
+		mapping->nrpages -= 1UL << dax_entry_order(entry);
+		put_unlocked_entry(&xas, entry, WAKE_ALL);
+	}
+	xas_unlock_irq(&xas);
+}
+EXPORT_SYMBOL_GPL(dax_delete_mapping_range);
+
 static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
@@ -874,6 +904,9 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
 
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, start, end);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(dax_break_mapping);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 295730a..4410b42 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2746,6 +2746,12 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 		goto again;
 	}
 
+	/*
+	 * Normally xfs_break_dax_layouts() would delete the mapping entries as well so
+	 * do that here.
+	 */
+	dax_delete_mapping_range(VFS_I(ip2)->i_mapping, 0, LLONG_MAX);
+
 	return 0;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index f6583d3..ef9e02c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -263,6 +263,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int __must_check dax_break_mapping(struct inode *inode, loff_t start,
diff --git a/mm/truncate.c b/mm/truncate.c
index 7c304d2..b7f51a6 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -78,8 +78,22 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 
 	if (dax_mapping(mapping)) {
 		for (i = j; i < nr; i++) {
-			if (xa_is_value(fbatch->folios[i]))
+			if (xa_is_value(fbatch->folios[i])) {
+				/*
+				 * File systems should already have called
+				 * dax_break_mapping_entry() to remove all DAX
+				 * entries while holding a lock to prevent
+				 * establishing new entries. Therefore we
+				 * shouldn't find any here.
+				 */
+				WARN_ON_ONCE(1);
+
+				/*
+				 * Delete the mapping so truncate_pagecache()
+				 * doesn't loop forever.
+				 */
 				dax_delete_mapping_entry(mapping, indices[i]);
+			}
 		}
 		goto out;
 	}
-- 
git-series 0.9.1


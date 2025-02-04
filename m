Return-Path: <linux-fsdevel+bounces-40831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A87A27E78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445DC1671E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E221C161;
	Tue,  4 Feb 2025 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I4C2yu11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D721C9E1;
	Tue,  4 Feb 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709329; cv=fail; b=ajtfhx8vU/z+ucPafy2nPFREgNOpEhLO3cVvjB4IUszswDnBb5FrgBGbucg5d3vZa0GEV0lTW1pw/iBUSig4/F56DJkjINoZuQ893I+5eG9SWRMgUscJnuKXOGpXEUE99iS1wFK3DsQ8u/8qqUsU55hCFlp3nCB44XqqYUVlTtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709329; c=relaxed/simple;
	bh=lafzv01xO0ETZ35xQwjFHQG29wIqJdjkCjAV6oySm4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MM8lgBUL6MClW7G04k5fAmlIZXQvQulYsNUlIt6H7FT2GI2H9X3ggfEfDseSkE3RmPY1RmFCZxSl9z6ax8KIQtUDdtjnl0cg9qdTL07JVor+EFIAU2aSlCKfzXEWhlYf0afp6i8BuU/irFOwUlryO3h32j3e8T255xEMVkWNpfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I4C2yu11; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEeXGCxQoDhqAZWH6ZO3LFFWKOGKXfG47pHXke2JvIVxuLzRSMwpRznRh9q0ELcJ0w1/hQDfgJEPbhemBiHrTX2EPRYxXzsZLeQlDng5WZmA+Da5vC190w9woxAwKe1jnMv0HLdWj+MH54AEC2TpyB2SvqI5dx+YNgnEvnXtBSZjGykLp7pS1dx4gu+ZqTB63w+tZXaOooNBpG+iCbqgTGJfUH62d4CzRlVyUWbcrqbfOh6JxT0wIm0Sx8lRsD/S1bZyR4xBcEF5Jz86EDOvvbEVN2tVnBPGkgh3QxBEdzrcfaKNE2mznx5nUS251TkqVQ3HaO6tQLpknDsmGZQ9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nROz+ZU1a5sA3Z/7oGyOeNO8z4rOU+FFR+QfAhYlhE=;
 b=urHyK8dAl9HviYCpnj9DUuoSpZQ9c+dI4MVVwVZceOI6KZTaS0EfRoLAk2hitM17iQdurGTRAdEfA/GBtby3k/sUGsVbY2ydZnE8TtueWMeVDlBX0/q+v1Z7C4VP0ntXEnn+B0lvpjPVfdA3+hr1OtbMv72YFBFlBPdZGrSr8FsDwG4SM6ctOr1vjaJbhHpyy9lLAqIGDKxGzo58a1C6bvQLWMK9Q6a+60F0xlEsFrQ7TxF/18S5w1mEJmYlw7nsZVCaf3QKBaGFzjHgAvjAizXIjStKe67OFgPwm2QyrRmITFLQ1Tf834KPiEpa3DUr+HYUeacaw5h8ULdzdIOpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nROz+ZU1a5sA3Z/7oGyOeNO8z4rOU+FFR+QfAhYlhE=;
 b=I4C2yu11QKuxQWX2BOJnZ2dHaUNoCNOWqkG3xLYQ8YkVJHDbgp+7ehOKsbVlbBzfiZp98eph931HS3lOD/VHjynI+7UQKc/IXd2VZvqO7koUNlQjPYJTGwD/f0TmcZH8tPyL4uSmjzQFl/5mpuZBLIeYvWbvn38xwXMJy33zxeVz09tENqB5KQnwJ9GDTbwGv3IJcvTV3Exv+ZK/bKy0sHaaxLFmMOHW7ZaTZh7rfGHjuVoIHQxkK291NXeaPJhpR/HCQ8yHRIikKTnqyG+R5PaLRJEEIIL3QqSUrBOAlGL9FlCazjre5ibdeqDUwjCKgapeuHtRv1B5hMCPfaxxww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 22:48:41 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 22:48:41 +0000
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
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v7 01/20] fuse: Fix dax truncate/punch_hole fault path
Date: Wed,  5 Feb 2025 09:47:58 +1100
Message-ID: <8aa3a20b072f60344e1d7e9b77a95aaa4b6dfceb.1738709036.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0149.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 521e4fc6-0596-4f8b-b002-08dd456e1246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d7hsMRvoa3b9JPINSyKfeYMoDTgLnZEmlCFSiH/2LslWTEwNh8c14lrcmORV?=
 =?us-ascii?Q?DqdMVDm1Nkp/vAGoJ4bteNP1vkRqvQTxM9VGqNAJCcrgvn5M3QfzhevWl6uR?=
 =?us-ascii?Q?FtraS5zMdUAC5pTac3O4Xlvd/PCLUbjB/7X6V4OaJnI9LOVQ+3QWUn4yR5fn?=
 =?us-ascii?Q?3p+S/COdKueCI/1K+7zdj4LA/TbE4tuj7wjA3aj5wxoe6BCsM1B0OguiLKru?=
 =?us-ascii?Q?6UM/co05yyjKFTUlzehuFv2tWU+6/Obfjkn07CMfKzKLnTV5kBBsefQ9l1zE?=
 =?us-ascii?Q?Bg/2xvm9tZUL8T7uVbbtLsezm5BRrOBtRnqUwOPURy9elAXaEVKAEMp+vb4R?=
 =?us-ascii?Q?DAwfUQ98fcSuaCNuUVYhqrMkkqR3azS4ZiJZJfLrV5898264rKJo4xUBLLLW?=
 =?us-ascii?Q?XgbyWeI//rzxBiJnUNz8Xpjw3lGaG0l4pC5cF5EHkqF95Jv6BUZSRFcYXccV?=
 =?us-ascii?Q?o34u2deoN3dQ1DCcxFKdQH7cr+uWnUbT9utHCCMlHndD7Z5i8ffetD4SB7Lj?=
 =?us-ascii?Q?ECnh13yvUVQnm0NbbyEGplXrzSWvEMOVCxQe1oI5YP9RsHqBYyrGIBvQ+UUV?=
 =?us-ascii?Q?f+tifbev8SwCUX4gDrN0Jt3SpcDY5+HIPA8XP90uKPeOAHNYo0UWTDmF7yw3?=
 =?us-ascii?Q?MuIlVBS7neIBKa51eLJZzgvUx5MaMXM3ZG2fAaEUH1CBkmxkOSkJXPsnCTNR?=
 =?us-ascii?Q?scbfsw4gshhIgsEMgagjgPg2mB9iKv9q9IooIuRB3TRejNLVWUFwJ4fVxY/s?=
 =?us-ascii?Q?tBJaBaEOiTr+AHIoxHiJqGzGgfFpJu/uRkUWaH5gnbjtsr4JoUJjOmm0tY7N?=
 =?us-ascii?Q?W1QFcDMoR3EBxUPY6xdGhuyfwxV1Wz5VXEhXLKG2vHYXVsY4SmcMQt1s8d7+?=
 =?us-ascii?Q?n0KF13miZcNKzekShF8gCaBErmtmeC5R6EbgDyK335FNibSaCvbDF8MrBh2x?=
 =?us-ascii?Q?mvs55RiTnDbrobKjswhOOZdooN6vXilAtB6nFGJ28W0Knfzv1jJ565LSXdtc?=
 =?us-ascii?Q?lwzrjaNLz2f0grWRg2gGssAvKyur/i03CpSh2raW3hr8XJzuIO4nl6lFgER/?=
 =?us-ascii?Q?OoCID3tQ68U4qWyqI9BFc3AV/waDy2GA8tsXorbkcum79op96kuiNT3r6EJ6?=
 =?us-ascii?Q?Jxk8tOYhW8JDZeQslzZv61Cgb4lNT5uRIEeyUAo50+FEXoyVSd1g68XujSDz?=
 =?us-ascii?Q?ngAJayhn833M9C0FEIRaildfsCaM9BsuewwbW4fx1heO+XqxSFwlEZTijYUL?=
 =?us-ascii?Q?U7uT8UTGjv9yXwZNnqXZSACzEppP+ea59ozXHTfL7Q/7556QrFASr4T7CMxr?=
 =?us-ascii?Q?mMqA2/zgU2t6zUzMv0iQPyI2RqOPUfggeMgT+E4RO3+TD4z4LdSUkPjCB1lN?=
 =?us-ascii?Q?cTQHVE0nS6ZH9UkNtPDiTeF06rOG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYK5LzGbZtHy34PzYKIgpSdhz1eaWHoqd8fP21lBt2TvGC+gk6rPfArvYymC?=
 =?us-ascii?Q?M/Nn76tAs8X1JgpdidkCG3hWF/SfvGMgzA7fivs1Vin5OruJ05zoi1jQxh5B?=
 =?us-ascii?Q?bKdPxq3u0bE1c4+KQezW72VP88LZqYTblZn/T27xm+kZlVKOfTWRaQxS0WGk?=
 =?us-ascii?Q?IGGzF/aqGY2OidIMCcLuB0X2yaC1+D1f/Y4dGIu38R0WguGTR2PF+vrJZNMV?=
 =?us-ascii?Q?UzQZScwYU6Dy8NxP6BjmdYj2ACx4dg6qWJ/49l2BrHY95GeHpwMze7rI9cNt?=
 =?us-ascii?Q?SVCrTc1723hPgKp61dBZ5mXYabCKW0kSpehsPTzurD6rG/U3GJBLEYfVpyOP?=
 =?us-ascii?Q?3z55j8cZB0d6TDo5nwekc5S2KlfO1qVlU3NFqxPJzFPBOgP8TbMYizcxysqR?=
 =?us-ascii?Q?/VzCRXTiwqqJ66F/6FNX/f+4NNHPr+A9XQwLNLY0ZJMJCX3R0MVw14S+miCG?=
 =?us-ascii?Q?LJNdRFwrhGLLkwep8J9U59mwqfOzuH4RxTZyQn3qA+qeyz0MTXOnNOmZLsBe?=
 =?us-ascii?Q?pOvAzXBgb3UFdeIz1jc2+uHEV/qIKmLfCsOqLn2X/GSxsp3iaBdQWj2T4IEw?=
 =?us-ascii?Q?0Xs9fkPu/bgBjKlRzV6Aa0YBZFfdFh4yFDB55YPkr8lzIn9tiWpPkWIPhaJ+?=
 =?us-ascii?Q?4OyIPDI7UsOve0tUAcq2tTZZ8E1lNOxGYdukGEe+OUhpLRGbzmpF7J8ZJkEV?=
 =?us-ascii?Q?7sXYxdO3nEMxlExNu6DTl3ye/EpR923Vvri7QEJ6zY8NFcXHuiqepAOUkM9z?=
 =?us-ascii?Q?AVdlym2Ad3AThqm+zNJQbLOpUGfqr5LLM7mF6+3nXtECtn9lVr9BsmMnWbY0?=
 =?us-ascii?Q?b8NpXapBssq7yvv/tlTlTcPP9Cqhlh4HCq3ll4cKt7Pw30GtCv5//hH48csW?=
 =?us-ascii?Q?mC0xkF+GpY13HnvTQtCp62kX0V7KRH9Tb2Wwgt765pD8fmJiEMGbafSIV/Wu?=
 =?us-ascii?Q?goIJ40Yf9/60SD5cAwlz10+Q7TivpNjh9IoXOWtrV2fxoPSNm46fEvRT1iKb?=
 =?us-ascii?Q?m4CXlR4rDZMbsI+A+eR3wtnQWEO84ufKoCDfg0TR99VkCkTNqAqPfWMpMpyw?=
 =?us-ascii?Q?szPIuRLkWo46FkS9K5ctoYFpWG/MOfvO1FR4NMulHpmqLd6hpTH5I+FV9zAR?=
 =?us-ascii?Q?2z3AyTicX/bvqYftqLyfpFPCi26asT5DT5v2E1W/nXq3bxbMhKNq/0PCaQVC?=
 =?us-ascii?Q?Od4eETR/0TbRHPhSGx0cNZRPup+b8Qbd+mN8lA28vEB89gIlcvm2tK1MmgBe?=
 =?us-ascii?Q?tmnnYmMsRUpkA1lDeyba99CgX7vnxoYxgsQ2qUK453s61qu1rFLHLxINVF/W?=
 =?us-ascii?Q?Ess8Hvm9fXI2ebOylrkM94JEtsJkDYehX7jk69AYDqriacrw1K8IgcJOUFMO?=
 =?us-ascii?Q?JX9MWaYjYXXQcgo7UgVUX8W++S3EWnTwTclEsLHkMGCBRWA4i/YgPsjuNWn0?=
 =?us-ascii?Q?4uOj53B4oX1zeGB4Q7THmYJwTysQy09YqMMP5IGexsbT9DgvqDEJ2ZnFuP8u?=
 =?us-ascii?Q?ZVWylbaYiZOj2V7CJTEzFu/ul1BZJKABnmQ1K66hbzloBMcujB3BgbJ0+QGz?=
 =?us-ascii?Q?lngoTlnYiuuVbrn6jvt2vbyMGmtKpOmEQFyak+Ss?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521e4fc6-0596-4f8b-b002-08dd456e1246
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 22:48:41.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbczPBwemThEbdhuCaAl0YMMwEjsjPWe0zUs6B0x/O3Ze/2HjdO9ujtKYDT7ef2WQaNfFsBKu1TmnQkz8guAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

FS DAX requires file systems to call into the DAX layout prior to unlinking
inodes to ensure there is no ongoing DMA or other remote access to the
direct mapped page. The fuse file system implements
fuse_dax_break_layouts() to do this which includes a comment indicating
that passing dmap_end == 0 leads to unmapping of the whole file.

However this is not true - passing dmap_end == 0 will not unmap anything
before dmap_start, and further more dax_layout_busy_page_range() will not
scan any of the range to see if there maybe ongoing DMA access to the
range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
which will invalidate the entire file range to
dax_layout_busy_page_range().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
Cc: Vivek Goyal <vgoyal@redhat.com>

---

Changes for v6:

 - Original patch had a misplaced hunk due to a bad rebase.
 - Reworked fix based on Dan's comments.
---
 fs/fuse/dax.c  | 1 -
 fs/fuse/dir.c  | 2 +-
 fs/fuse/file.c | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 0b6ee6d..b7f805d 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -682,7 +682,6 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 			0, 0, fuse_wait_dax_page(inode));
 }
 
-/* dmap_end == 0 leads to unmapping of whole file */
 int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start,
 				  u64 dmap_end)
 {
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b..6c5d441 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1940,7 +1940,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (FUSE_IS_DAX(inode) && is_truncate) {
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err) {
 			filemap_invalidate_unlock(mapping);
 			return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d92a54..dc90613 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -253,7 +253,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 
 	if (dax_truncate) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out_inode_unlock;
 	}
@@ -3196,7 +3196,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	inode_lock(inode);
 	if (block_faults) {
 		filemap_invalidate_lock(inode->i_mapping);
-		err = fuse_dax_break_layouts(inode, 0, 0);
+		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
 			goto out;
 	}
-- 
git-series 0.9.1


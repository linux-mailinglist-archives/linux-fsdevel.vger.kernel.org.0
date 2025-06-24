Return-Path: <linux-fsdevel+bounces-52654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F4AE5840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B952F447771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D165529A2;
	Tue, 24 Jun 2025 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LGqyChzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB6366;
	Tue, 24 Jun 2025 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723441; cv=fail; b=Tu+82A9qdKA3fgUFV9N3w6ee3Ts2Ke5oq+5kx6RoB8MCLld0jnKYWAVjfyMcTlnKX4OMaccT6wUlBVZ9FEoWVOT6KQ4zg0XEnVpZlBYt4ChIpnl4oAEHbpE8Sh887NKx4JdXbxlNr3TkNQFQm+oW6T04toAnGkztI0erUQ3Ppng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723441; c=relaxed/simple;
	bh=kxQ8lBtstwLMbqxmxjzdVBtp1SeguxsPXsae5p6sH+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mPfOGqhWDCok/QSTB1GsK+Yt1kFiWdAZwruEc1hiaNJM02APu2qU/g3Gytxhl1nKwW7mXA82JB7zfBzMtR+SVbwJ3FYG/CIbnhGuIup6xKnwqHXZiTMRFR7mfv7CLc5A2ZOFKZDCbhepW0w25pGb7vBfyb/qxH8fs4zQIUUkYio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LGqyChzs; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsrVs4qNiQIEg3oV9p71UMZR+QTkkHrFWc7w18C3VbohBHuqjCfa6xiKns59DMzaOdYygN8imLcTwqR4+un03Oc+vxNLlwFg9wo7K4PtA+ekU7Glo72smCPPCVjiQQhhHJs+pK1+Tlo4R+5qFmwNSQQfNUPl1gXdLRrVX6vtIRnaGTEhEBARNcz9FBJg4eQ6XD7KSnd+Jn+IEerBY1FueUniHGl7vg0/FqZblXeorIH199KXODgDHnvJsXjEeozmK/cT4DL7ttFQlLwhs4soQYY9YuPzdnPdbLLIaDGyEv8YbLT9+kAAhEaDm9AnSl1MPrhuyF/y9mFQZ6hebkZeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5lWRX9wVay2WcPpIptHERe1rSCGRuVZtkFM1yfDw1Q=;
 b=O2oEdWE7mswVS8AvSyiAP00pPIhsmqw1BISnMo77xJSvuq0gUaWykcrxdjz/yh86EtYreeY1+K2O4dr6SybbTGLxJ6B2YJ1rmrLJKgzVxiPe+516UBak8yzaWTwTkL9GCUvI2smNFZgJsY+83O0wLT5j4+SY5ZmuG7f0AfFVGVciP6nf6eY5Ap7gCbREDU+b6smts+v7SStIwILB10aVcqEknfHX1eJ4MasDn6Uc1r8urJfAaM9HmecDKlSPbZjZKxDTy8PwtRwXNYb3ne4dr/U2KAzEuRM+K9DV/AKwX1CX5YlbLNO9Jn1n2u+jK4liOCReULB+RD7FNqKnzgyf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5lWRX9wVay2WcPpIptHERe1rSCGRuVZtkFM1yfDw1Q=;
 b=LGqyChzs/yxoZFAcuMSDRC/Y1Z17APZosAAd9KbqeOiGAlaJ9lSSFGMap6isDMNzUzzRyqPieUdRYmN372y7IkEQtoPxZVnKrlMOGbDC2we1JtzxfPx/+jEItx+cR6DpTVmFQ8y1r8tE4E8dKhmdH8hQijqaKc+baqHp0u74hmiUJTEoebrsYyuXoahDdllosP/VtcNilLLtCFffYDEsL+vubanDDhQjv68lzVvg7u4bchVpL0p3lBg1BZlqV8DwmIKEO322g6AxUaiXwzLw+E0mwJl17p2a1LAJrVP8XSfO9S5L0Q+xbquoBHp27MOEkmOynEDPux2oD96Nn4ERfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 24 Jun
 2025 00:03:56 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf%7]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 00:03:56 +0000
Date: Tue, 24 Jun 2025 10:03:51 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Haiyue Wang <haiyuewa@163.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] fuse: Fix runtime warning on
 truncate_folio_batch_exceptionals()
Message-ID: <lfc5sqvxmxho5q7hyjflrcvx7jb4gjtzb4zf6fsrsafpmgplyn@e2gr4hmamaqo>
References: <20250621171507.3770-1-haiyuewa@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621171507.3770-1-haiyuewa@163.com>
X-ClientProxiedBy: SY5P300CA0029.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::16) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|IA0PPF0A63E7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a17ad76-c624-4356-89e4-08ddb2b29caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iu9puH08iIyqhGER9tnRdnZmqYCYp+LSS2lAAdXCGPRJZxKhAWRSLq129LfE?=
 =?us-ascii?Q?hSozpaWbosC9RCD/c9UPRLIpzuy1D+wvbR/URVd4uHpdqNE/FyaS0ojvJtbQ?=
 =?us-ascii?Q?agb1lrcOh3qUNih8tqSxmXwtXPmXUmNQOi1YJCrKTdddHDpzhvjdgxcuC5ex?=
 =?us-ascii?Q?KCqBtQv4JyZJjz+nMQxAlzPaSQgGHfjHwC7dipOaWWNvikzlCLYjsV/LqUQG?=
 =?us-ascii?Q?Fm2+EWum5ZZYU3iSOuVpNIPvYdwTyTM6UITakd6hLctHHI+NnmmAShHqCDlV?=
 =?us-ascii?Q?v5ong6jbj4mW1EmpJTOdY8+izHmBcaC+l2zZBDEYBXRRJeBy7w/Fuo9RDY7Z?=
 =?us-ascii?Q?Rst/GugUjxU0bqrMCedTKL/LpJEXABdGtD7x4nCuV42F+HSkuSLuRSxs1LUj?=
 =?us-ascii?Q?WxQjHbYl3RiPlj03idjZ0fiHg8PP39sk1nlxesmFpmy/aFGxd0Jue6tq/T4e?=
 =?us-ascii?Q?QFNg/6Hn4dXnh7oV5rqX59c1uJvgdsc6IhD5LgJHYigrByzoMGAtefAzdvF2?=
 =?us-ascii?Q?i98ueDJdx2AdbU0CbrAwPdBzRtlgstTC9z7W1DpKYuCsMMuziUBp8qI3mFDZ?=
 =?us-ascii?Q?r/9hJj8iPKs6KqPWKyIgHubJRq91Pr2cjisov6/nz2PTGrfgVCirs5NdP8a8?=
 =?us-ascii?Q?UAIhUnTttU75aYwwX7lSTDblFGEbtdEoJ6Hucwo8yP/9URBuXTWvx4nyukUx?=
 =?us-ascii?Q?5wUrhwKo4mxfBNfimf0/8+W0u5w/jxudjAbOuJM9f1FOx35WmuzNQf5eug7Q?=
 =?us-ascii?Q?N52EbdtlUSu6JTV6gZTyzYk+5XFeZU8cm+/N+vp5goGx6V6Pfw2+AEcJ9CKw?=
 =?us-ascii?Q?5fuFXHKi8X5NRx0bT0Om+yLfuKlmDEt1bGGLsbPh0csvp0ZBCQ06yeGtcGw7?=
 =?us-ascii?Q?RZ1sLTs7McpyK73uojTeE0u0NHRZtN5Ly7KAZQvjW+F0ItoVXzFzGkkO+Zzu?=
 =?us-ascii?Q?/9njXlKjadG5jd56u5UkvuF+x+kAGbK0VAaozC7u6v9FKd7XjeFq6awrjkaa?=
 =?us-ascii?Q?P+tG7U4IIv7NRBw5cjhLaYrMFsmyfh7+ugl9hFpDbS+YAj+nHIuIeyMIfO2A?=
 =?us-ascii?Q?P/MvBmFl83Y7ZbAZVFuN7KPPnjLmPxdjHh/W1swF1nvhgp6q0DYfNdJvM3iy?=
 =?us-ascii?Q?yf9EeJ+DtH/YVe9vV1HFvO9bFKRT8rKCV4XVJ9ombSXhha2pfGjYljr4geJh?=
 =?us-ascii?Q?VGjAuDmay6nMqlWIwpG16rcwenOn4XlKHK5+A3m91u+WWWGxkUYfWM2bwN26?=
 =?us-ascii?Q?lVNej/mQvXdooQuvhIEKGWcU4WMY3k5np0ro3Tm2mMa/O4alA/Hd/4hFTxON?=
 =?us-ascii?Q?O34yMjvTwpriLnNFga487A219ONC0rpWX00SS9s+ISHBD6BsoK2PZKC3sEx7?=
 =?us-ascii?Q?LED+BwA5d3GSv4+sVFtbVg6bX/oQz+446HTqmCa+nClMVKuPmKSRLVMP/KIQ?=
 =?us-ascii?Q?3fJbisYb094=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dXYe13rXiz5SvsLUpPeb/zGgx3DDYSO9S/gx9plU4wbq7BzCWzYaZom0BE+c?=
 =?us-ascii?Q?G8ZzP/3sFy4Fvw7ha7RHwo7OaokXtNNWn8/QxNU/2vRSf763OyEMJvbCjqaT?=
 =?us-ascii?Q?yTB4HoVvtw3uyF7J6RokaM02aaqGh1qV0u2+3i19ypShulcKpAisSVVNq2i9?=
 =?us-ascii?Q?SVcYnNG9Q/o2J8wfkEgcF1O1NSPuimm+SwUnKmt1nV35R+uEgZKw0jE/UwYD?=
 =?us-ascii?Q?C9at31jevXguIi90g/UWDZaH6MLnoCFxj4VoygLf5K66cp6Zt1E42o7zNLRM?=
 =?us-ascii?Q?WnRaWEL5XGUzntWz5G3H7ph5twZpj1vpF2SFypM4dJkYPYZjFuG/xEMYIqZQ?=
 =?us-ascii?Q?3w0kcjhqqzalPSvJdMXjW57h4/M9tGvwJTi5IxhM+qJ+Q5A9XTM0TZYdmP26?=
 =?us-ascii?Q?vl3QJmBKTEX6J8SQaV2sjdJOoKg+xuPBHzR0en2jcDIeHkT3ZhZ1UqP3P03o?=
 =?us-ascii?Q?8xHgtS4TKYPnEcWxDqfV8llCys3fkOcq2RtwjTgElixLTzI0iPikobzWpsa0?=
 =?us-ascii?Q?NT4/Kv1ivHHYvfFDrHfTFsQfp8kjivFnWvHqIw5siOvgoVhCdrYIk4wiL03L?=
 =?us-ascii?Q?UI+c+Kw58mdDu7JHEzWCpq5F/Y4RETGM7sbBGG0+EPuNIXIXtT8iB2ThlleP?=
 =?us-ascii?Q?05ZVmQYq18ycBG3b/x52L/paRx1xY63BluHom8VHKkXvcRpxeuaHjKMLZRlo?=
 =?us-ascii?Q?7CCobyayGcCaEm5XMNLO8ONyphB6psFjGlAp+qWluy8rSqNNncTIlmq/p7oO?=
 =?us-ascii?Q?rR16+kwUjNWu/N3JyNmaQvp3nTHgwrF45fmXkskYgVLA77wm0dXS3PauhpIW?=
 =?us-ascii?Q?3IeATvo54ND2ZbFKt5GjitTAUDyC2p6FJDvUP2op6drAgY/gMWwEePx0/xhG?=
 =?us-ascii?Q?tA1ZF4HqXMvvbF5QJt6E/6xlLxDmzqkVPP1AewwgpCmU3JCNcztse/O69BeR?=
 =?us-ascii?Q?j9hAAN7cRw2xZx/8WOLuGcePaV1d+nXy6McR3csWB3j6HZMk+4lBEOhS+oh6?=
 =?us-ascii?Q?vs6orVSOTU80JmRjflS2jslcfbRTApuQzImRA7MrWZthA5u05XC3PdIXiPUP?=
 =?us-ascii?Q?rrKQTLLCQz2PJxShM735qSFxLqkpdhhAk8C8STw5ZoPgw+C1TOgzB8onqV/4?=
 =?us-ascii?Q?S8MBx4/BssT6n5jeJJE/0PxD0yEw9MwDTR1T8w5COD7i56xwITTjlFednDTj?=
 =?us-ascii?Q?/p6c+2wBnQhVY24EKkUFxj8Mm7YnwZl47jvRVfc96SY1yCn4NBxnmGiDFS/a?=
 =?us-ascii?Q?iqyNG6vnSaorwLmP4Ang78ipK6iqz3maTMlU/hz3fNynA8G0tZvNhbxgzQab?=
 =?us-ascii?Q?kg5lavV9NDfmZ2rNKo5ZB96VlsmO5Q/Zei1l3DBfUwAGDkKKkm7arPZ1ozEm?=
 =?us-ascii?Q?x/fwxk8D+o6WdsI+lfbCqKWPxNjGSs36hQrtbe9Bv8xzxTSEynVf8fHCDall?=
 =?us-ascii?Q?3nPbLCsyRDuilcQbnUHDskMRTYIdPo7lGWAgpH21D7TIh1bwDHeSAU898LUy?=
 =?us-ascii?Q?otWJXng9GGb9Ji1geuCaMismTzjMQdnLbJBK2cgx5o0GzynMS0C40w85iUsp?=
 =?us-ascii?Q?AsNJRyPlPWO8zOVjt1PTpkjYc3f/9LdYtPX69+Gu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a17ad76-c624-4356-89e4-08ddb2b29caf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 00:03:56.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UToGSUdJ6NAEq9TZL0CBxWoAfvEao2qLzpCJUsryBomNJ9ymOFXy+HNy6L7202kjl+ID2t4Xj8Jz4IQtkF4mpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557

On Sun, Jun 22, 2025 at 01:13:51AM +0800, Haiyue Wang wrote:
> The WARN_ON_ONCE is introduced on truncate_folio_batch_exceptionals() to
> capture whether the filesystem has removed all DAX entries or not.
> 
> And the fix has been applied on the filesystem xfs and ext4 by the
> commit 0e2f80afcfa6 ("fs/dax: ensure all pages are idle prior to filesystem unmount").
> 
> Apply the missed fix on filesystem fuse to fix the runtime warning:
> 
> [    2.011450] ------------[ cut here ]------------
> [    2.011873] WARNING: CPU: 0 PID: 145 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0x272/0x2b0
> [    2.012468] Modules linked in:
> [    2.012718] CPU: 0 UID: 1000 PID: 145 Comm: weston Not tainted 6.16.0-rc2-WSL2-STABLE #2 PREEMPT(undef)
> [    2.013292] RIP: 0010:truncate_folio_batch_exceptionals+0x272/0x2b0
> [    2.013704] Code: 48 63 d0 41 29 c5 48 8d 1c d5 00 00 00 00 4e 8d 6c 2a 01 49 c1 e5 03 eb 09 48 83 c3 08 49 39 dd 74 83 41 f6 44 1c 08 01 74 ef <0f> 0b 49 8b 34 1e 48 89 ef e8 10 a2 17 00 eb df 48 8b 7d 00 e8 35
> [    2.014845] RSP: 0018:ffffa47ec33f3b10 EFLAGS: 00010202
> [    2.015279] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    2.015884] RDX: 0000000000000000 RSI: ffffa47ec33f3ca0 RDI: ffff98aa44f3fa80
> [    2.016377] RBP: ffff98aa44f3fbf0 R08: ffffa47ec33f3ba8 R09: 0000000000000000
> [    2.016942] R10: 0000000000000001 R11: 0000000000000000 R12: ffffa47ec33f3ca0
> [    2.017437] R13: 0000000000000008 R14: ffffa47ec33f3ba8 R15: 0000000000000000
> [    2.017972] FS:  000079ce006afa40(0000) GS:ffff98aade441000(0000) knlGS:0000000000000000
> [    2.018510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.018987] CR2: 000079ce03e74000 CR3: 000000010784f006 CR4: 0000000000372eb0
> [    2.019518] Call Trace:
> [    2.019729]  <TASK>
> [    2.019901]  truncate_inode_pages_range+0xd8/0x400
> [    2.020280]  ? timerqueue_add+0x66/0xb0
> [    2.020574]  ? get_nohz_timer_target+0x2a/0x140
> [    2.020904]  ? timerqueue_add+0x66/0xb0
> [    2.021231]  ? timerqueue_del+0x2e/0x50
> [    2.021646]  ? __remove_hrtimer+0x39/0x90
> [    2.022017]  ? srso_alias_untrain_ret+0x1/0x10
> [    2.022497]  ? psi_group_change+0x136/0x350
> [    2.023046]  ? _raw_spin_unlock+0xe/0x30
> [    2.023514]  ? finish_task_switch.isra.0+0x8d/0x280
> [    2.024068]  ? __schedule+0x532/0xbd0
> [    2.024551]  fuse_evict_inode+0x29/0x190
> [    2.025131]  evict+0x100/0x270
> [    2.025641]  ? _atomic_dec_and_lock+0x39/0x50
> [    2.026316]  ? __pfx_generic_delete_inode+0x10/0x10
> [    2.026843]  __dentry_kill+0x71/0x180
> [    2.027335]  dput+0xeb/0x1b0
> [    2.027725]  __fput+0x136/0x2b0
> [    2.028054]  __x64_sys_close+0x3d/0x80
> [    2.028469]  do_syscall_64+0x6d/0x1b0
> [    2.028832]  ? clear_bhb_loop+0x30/0x80
> [    2.029182]  ? clear_bhb_loop+0x30/0x80
> [    2.029533]  ? clear_bhb_loop+0x30/0x80
> [    2.029902]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    2.030423] RIP: 0033:0x79ce03d0d067
> [    2.030820] Code: b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 a7 f8 ff
> [    2.032354] RSP: 002b:00007ffef0498948 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [    2.032939] RAX: ffffffffffffffda RBX: 00007ffef0498960 RCX: 000079ce03d0d067
> [    2.033612] RDX: 0000000000000003 RSI: 0000000000001000 RDI: 000000000000000d
> [    2.034289] RBP: 00007ffef0498a30 R08: 000000000000000d R09: 0000000000000000
> [    2.034944] R10: 00007ffef0498978 R11: 0000000000000246 R12: 0000000000000001
> [    2.035610] R13: 00007ffef0498960 R14: 000079ce03e09ce0 R15: 0000000000000003
> [    2.036301]  </TASK>
> [    2.036532] ---[ end trace 0000000000000000 ]---
> 
> Fixes: bde708f1a65d ("fs/dax: always remove DAX page-cache entries when breaking layouts")

Thanks Haiyue, and sorry for not noticing this in my inbox sooner. Fix looks good though, so please add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
> v3:
>   - Rewrite the commit message to make things clean
> v2: https://lore.kernel.org/linux-fsdevel/20250608042418.358-1-haiyuewa@163.com/
>   - Use 'FUSE_IS_DAX()' to control DAX checking
> v1: https://lore.kernel.org/linux-fsdevel/20250604142251.2426-1-haiyuewa@163.com/
> ---
>  fs/fuse/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index bfe8d8af46f3..9572bdef49ee 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -9,6 +9,7 @@
>  #include "fuse_i.h"
>  #include "dev_uring_i.h"
>  
> +#include <linux/dax.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/file.h>
> @@ -162,6 +163,9 @@ static void fuse_evict_inode(struct inode *inode)
>  	/* Will write inode on close/munmap and in all other dirtiers */
>  	WARN_ON(inode->i_state & I_DIRTY_INODE);
>  
> +	if (FUSE_IS_DAX(inode))
> +		dax_break_layout_final(inode);
> +
>  	truncate_inode_pages_final(&inode->i_data);
>  	clear_inode(inode);
>  	if (inode->i_sb->s_flags & SB_ACTIVE) {
> -- 
> 2.49.0
> 


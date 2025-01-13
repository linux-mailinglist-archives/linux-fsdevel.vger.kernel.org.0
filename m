Return-Path: <linux-fsdevel+bounces-38992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADBA0ACE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 01:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736FF1886945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7217BA3;
	Mon, 13 Jan 2025 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olk8baZh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8396442C;
	Mon, 13 Jan 2025 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736729274; cv=fail; b=h4KgfyYe/E8dilgWJCYK9ivrEHiBihv+dbKXR8nzIjG38XPTN/Ciwp0VLzNXNVGQCm+MvIRH3ai9ACkSVGfu4h1RhXukdKo8Ivul5ql58ZrcXqmDBxjFqicGaSQdTCn4iEusVCXKcsrJKKorPW7arrOv+ONIvGz9Ckblee+2L+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736729274; c=relaxed/simple;
	bh=wSDbGw/HKZLstRAgOLOXzdqfsSeb1c3tJBG305nbxHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cq51t1yhZO19XNbNtY08Y2bKXQDlHRHbCD3qo+dA09Ag2/Knzsyl2Mmglts8FQbbL01lOIV4SF5g+5FwSyuZU6BLEysG56iZt3Tz+mL9YTqp3d/XLLBvSwS8igLhVXmrIUXMmN4jo3eSWoAKBo5fRobmB6wHmFejMYjnlwptHqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olk8baZh; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFmkpW38E8lyCCI7bN6o+0AsRSnQekQF0da9oohHNlYrvZYOdJEf3Jv/KrnWO7Bycwz7df07I1V9PCCfLvm487iFYLMfz4SHmS1Q6n9lsmnFLw7SZWqhL/amYcdFQxtWDoBcLcxL0IhBG0dcEXioO9iEdgmv2toJvXtC2QG32xf3iVDU/SFsb9sCmyb8oOAQLR92x+x9Gjm15pE2Kqi9IPAZw8dnjqQAWr9VQrePoMIpAVls23jJlZVopBQLdlh+DaUa0kAqqLpOUiLhk6xwK3tZA3p0CNgx97uAmuh+6RMoZiulKjsBVn74MKozT9i/KMMarQex/DXOacRHJxx5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jppa53z7I/U4ia4WW1YGd2ijQSHdGH410ZcQQgipM2I=;
 b=uVHBLHaihCP29SOO6Z+BbdwID18/2dv60V5dFxDoSupYhI6SP/gTV7fA5AcVyGKUxUqlCD+ceqp9wQdBsp3kgjzNKI5/Rh4RFOQkHsRgBR57dcmgzeq6vGq2/0SQ5aDUv5FCDYh+vaPCej4GtYJTFyym56mk3rPVGFAOFNWRi7BnQZD4NiKfue+xpdUmmlnQ/PVqGcUoOXwz5oAbQc3GycVVfivwMt1YfjuMpLG10ZfeHtOkzJN2P5XQyVPaBzyZQQrHcTWAN8w48t1o/O6lxHtURaBlPybMQ1ifLrhvHDM8GI9ZeDwmkYCJZpzYeiLdwY30bHZabixNvp+Gq3FU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jppa53z7I/U4ia4WW1YGd2ijQSHdGH410ZcQQgipM2I=;
 b=olk8baZh3CWAlUJbRottD+7f1Q4e+vZoB8txuh1yY2jUqA5RTcXsDBfkyrobr0B3HOa/Lt4rlb3Lncltn4CGINl15AjZ2LztM4vBaNVrfgWqK+wr3r/YTytFp+6gd3VVTHFOvK85l3EjxJpdRXKvLHWOy7YYVixB6PVM01jQVvXfu608f/uD+XsX7HzSIt5V8SSZX7LL5zb+9SSrm2TOKb54dgDwjW2BfEqTV/Y5XTmMQ+OE3Rf5e+Spds8cxaP4AKqGtSDOZEG8RwXvyWvCuuBt0490g0hWijZtx9XU2BKqGWRznGWS/NZ4jSqGqNEWgN69zyZluV1r3UXddykc/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.13; Mon, 13 Jan 2025 00:47:50 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 00:47:50 +0000
Date: Mon, 13 Jan 2025 11:47:41 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, 
	peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 05/26] fs/dax: Create a common implementation to break
 DAX layouts
Message-ID: <lui7hffmc35dfzwxu3xyybf5pion74fbfxszfopsp6tgyt2ajq@bmpeieroavro>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <79936ac15c917f4004397027f648d4fc9c092424.1736488799.git-series.apopple@nvidia.com>
 <20250110164438.GJ6156@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110164438.GJ6156@frogsfrogsfrogs>
X-ClientProxiedBy: SYCPR01CA0029.ausprd01.prod.outlook.com
 (2603:10c6:10:e::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5a2efa-4bf9-47d1-b243-08dd336be79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PokqyeOtu9qpM6AZywo/fulF/hAGwOE0s7idVwDYplNxefq7PruMYEWDFshG?=
 =?us-ascii?Q?aR00C3DEkExvDLnwmy8k1eOQGi1ROIN009fV32moWP2jM8swBp6xS1Z0nYZY?=
 =?us-ascii?Q?Kf72OFZvoq49KW1KOuS0tO25UrF2bwrnGsi2KPG9Jj7LguCTuz5yGCO7SZ5r?=
 =?us-ascii?Q?4XoIkk2TrYVqbkdy84vEWxSBIibGnOGwV43vRY7MhwtLoDFI+hK8j3ajLyAY?=
 =?us-ascii?Q?Y6GadjFQ7wIWq6vqTj04kx9DXtt7DxNHEKFUVhhW8+xI58YorxGXDEDcG5aK?=
 =?us-ascii?Q?8GIjfUDu4LxOsGAUZQtV8ieuaEwvsSUzkFFfBHeqN8OCGFRNywDJFmeBQ3JQ?=
 =?us-ascii?Q?TPPQ1mNhyEYF6+zB3rRT9azj2GNxfJd3mxQbuNzpqjC0oBuR+hAFG5VKbYc5?=
 =?us-ascii?Q?E0fwPVWw7AS2zk1idHozODhTwp6Crdsk37FFnSqPjGhNVx5g7s9UeCyzlzZZ?=
 =?us-ascii?Q?ccLfu03jY4HJJhkEr0u+NL3Qbr0xWXekfwosxSyYjiwT/N8yS+wajRIwMAak?=
 =?us-ascii?Q?vp27lLzMS1QQVgLrPAdnzu030Yb7KChsIHtqIIsvNi2t2ZMiCjC6AGbAfQ4k?=
 =?us-ascii?Q?88Jj1I3Ao239BYkjeDNPNcvVivKR27rWjFtB7bxKi0qLsGa2AwfqH5q9RR68?=
 =?us-ascii?Q?mgZMvvw8obBm3dUU+oR7cLhSGkUyboVMxIReN2gWC3EY8bXtfXPZEiClOKoe?=
 =?us-ascii?Q?LScYX3iSu0AB7fNMdo4Fck74Ay5Ym/i+aCG17/ULKjK435toXmUgFESJS4lw?=
 =?us-ascii?Q?KIC0MPK1+pkpw6B+jcdvaOntsYtAJB5bGlEQcule7+gjrIDAwbd4ZTqQdvys?=
 =?us-ascii?Q?5p7KxqPMEc+qYSCtXaFuU/NC4ivegIz/dpSyi4zV8cyaiMu+bSBYhkE8Rv3L?=
 =?us-ascii?Q?Gn2QoZu7ck2ghtyNI0pXF/uLeeMogwQdlb6YwB/XrL/V05pBg6h4i3MCxhm5?=
 =?us-ascii?Q?5pMSmGbqz39TWWD+biHqjwjxRvflM+BCf0G9Mj6BJmMv0k5oXlBzmeF6k+wA?=
 =?us-ascii?Q?+ZpVgPmwGcmGUFpmUA/YHga29Jkjt5rdn/yL7euiWJXijVhIrjCN0qy07XPl?=
 =?us-ascii?Q?FV59UpFEJ80G07LBEzOvMs+B19TwBC0GkkfH6zzXYAHUV4Jad1gQTJjNZQFq?=
 =?us-ascii?Q?TgR+ZLE6Xx+lb9wrWovRhFmO87VnvFih/DhYaewIRy04xNlutSaGSaTCHJ14?=
 =?us-ascii?Q?AC6+0kusmNEByCHuEgi0J8r2bgn7tQJY5g5nB0nmkamCL16ycWSiE5b4tStq?=
 =?us-ascii?Q?dfr+xyU1G7M900CxMw/P03pF/658ztfsqNUZ7AVZBeaT5LPXRZyoPtV2tgll?=
 =?us-ascii?Q?l4ziukiSvDAuCSkZpydPqaGb07uyCTWP7TeRdw7QUqlXTaf3ftjgKGzNvZbl?=
 =?us-ascii?Q?VcwgdsbrCArl38pWAqrALhB1GLn/6cOUkqQcmtN1seqe/ylWme4oWm9tffiH?=
 =?us-ascii?Q?1pTdu/E54Anf33lml9pSj+nfTNN+kzRt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vu/wzkINOv3i3tPbtf+nPahlRr0FuHZMFWpB9PuMeeI1t4vAS+UXv8VXHoy3?=
 =?us-ascii?Q?v6/5UX6sv6p1vrZ23gcWFSA1XDjh4dBfkq6j0Y+24NjnVv4UElJBdrv3Ktye?=
 =?us-ascii?Q?4iAsahRvArgMJVinqrMpZaLAWp/iA7wimrDRyKu7odArfLupOOt53ohtMAnQ?=
 =?us-ascii?Q?Y3zOX0CwNkc8SBIDm0wdGt/XL6t7IJ1jPrMK8kA4sXXw07Dqy2NyzdnCnhjI?=
 =?us-ascii?Q?SVBMdyqnIuv/0ObexLdQJ8VbHwjOZwEnH7ZM4ss/45FGuNioidLxtpQ+UYL2?=
 =?us-ascii?Q?e30jO2QytL6PFLoav7Bck0cPlYfVaIGecj5K8xnB/QKS+qRJDBOEl7/IU7Zj?=
 =?us-ascii?Q?U1LR9n+9WLFt2yET5PmPpjyUeCDILArzj93TWasHL2h7LfdP9fbPW6rJLMF9?=
 =?us-ascii?Q?ipT17sPUvnS+meI6sCWrRj1NR2He8KnBSnfdTNCIF072Lx5yEdC8aPkcuGLK?=
 =?us-ascii?Q?5gC7VOl/R9v1bIIN26gCYIC7awPs/5Nt9NtTVa52kdfpNdG4+iX+16oS2gky?=
 =?us-ascii?Q?IUkEJtx1iPK1t4rCn0zNdeNOxbQZnRvqVC7tmm+zfSlaVv7ZOc6FbjjEtXCO?=
 =?us-ascii?Q?QN/1eLGokmkEI3pEziSN6z1mt3/iQiH2dGYkVPSYveg+xq44zAoPHfUXM31j?=
 =?us-ascii?Q?tCzHdtGiGdaoUxnGcfVKGK3wzSOtXa2+CneMG/0JTx4snAXUYstGiUFlMBTc?=
 =?us-ascii?Q?KITEcvQC4T8TumjL6fNsXcwZkdyIf+awzTxZaYz0X36p3Biz6r7NSbEMeMM5?=
 =?us-ascii?Q?igxoVPtxmjYWd6RDshlQaJeHWxvXo/p6FCNs10/xy/T8uwhvohXlRnKznyRC?=
 =?us-ascii?Q?q6vaiqThCNyENGGSumJflTth2sc7MB19Lsx5RA7Ap4p2ygp8ocBFgk2nNKCg?=
 =?us-ascii?Q?ChtGZ+HpB+T6o5VYw6FI78lH8munRZesBYVPCXFs8jisAb0WO7WXhjrLdGEi?=
 =?us-ascii?Q?F5nOhRAjrdVCzyTeQbM1+fUG3shFaa1VAnj+6b0uNIJZg6KdXrq1thTG7GL/?=
 =?us-ascii?Q?dg3+4teUaJGsBxddBIa3UiKRTkxN1EuOekzCPX5JPem+2ffpageLZ2RD5di6?=
 =?us-ascii?Q?H4n1r3ITqG0MKRo7nsI5YFWFSQIaNsOeRkbqRg5u4Dg4jgPee9qy5qvR9txc?=
 =?us-ascii?Q?9KYFnTm9T4cAZfVCvjnl/v7vl0Iu6+RJy/ZCyPfeCXZW3svR77zddp21gW3M?=
 =?us-ascii?Q?4rK/pfqYA87XDUzTwxT6yHPUASHYm/jx/aBuB4cCpzwKOP6NFcBGLch3I+28?=
 =?us-ascii?Q?nmOFvqX8wR9ep8PkdEP8OWme7xiav8Hqs0HyUcuAnvMBE0Z7vqPn59Ney+zq?=
 =?us-ascii?Q?wvcJ+8YcZbQ6WWUTZrKRDymIYMXhbb//AK5fgTsLNjMKSG5USV68SPMn0EQd?=
 =?us-ascii?Q?Ra6FKwrETg6qClCWiCV7QFQDcRLpaRleTQ844YwnXuaZcMPoypdUUyGQso/e?=
 =?us-ascii?Q?lPB988MNIhFti3ndE43AB6Eo+UdERN09+gJqZngnBKCXaPtfZk6/EF3J1kTU?=
 =?us-ascii?Q?xr/LT3D3mwYJMSR2xSUiMGn74OYzNwlIfNfoj8wZEKbJVRZrDufudYSLuhsI?=
 =?us-ascii?Q?Os/lU4LyyCSZxd2nAJsnjKt0223AgJZnFLa6/eAF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5a2efa-4bf9-47d1-b243-08dd336be79d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 00:47:50.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldWV7UJQQLOlMWfJbtWUXG2215XayJocOjutmD5WOoSSVlg/AVNAG91FkQ4wLhp9QkXAUf9F2iz0TKmZCFgKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463

On Fri, Jan 10, 2025 at 08:44:38AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 10, 2025 at 05:00:33PM +1100, Alistair Popple wrote:
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
> 
> So now that Dan Carpenter has complained, I guess I should look at
> this...
> 
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
> >  fs/fuse/dax.c       | 27 +++------------------------
> >  fs/xfs/xfs_inode.c  | 23 +++++------------------
> >  fs/xfs/xfs_inode.h  |  2 +-
> >  include/linux/dax.h | 21 +++++++++++++++++++++
> >  mm/madvise.c        |  8 ++++----
> >  7 files changed, 68 insertions(+), 56 deletions(-)
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
> > +	} while (error == 0);
> 
> You didn't initialize error to 0, so it could be any value.  What if
> dax_layout_busy_page_range returns null the first time through the loop?

Yes. I went down the rabbit hole of figuring out why this didn't produce a
compiler warning and forgot to go back and fix it. Thanks.
 
> > +
> > +	return error;
> > +}
> > +EXPORT_SYMBOL_GPL(dax_break_mapping);
> > +
> >  /*
> >   * Invalidate DAX entry if it is clean.
> >   */
> 
> <I'm no expert, skipping to xfs>
> 
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 42ea203..295730a 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -2715,21 +2715,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
> >  	struct xfs_inode	*ip2)
> >  {
> >  	int			error;
> > -	bool			retry;
> >  	struct page		*page;
> >  
> >  	if (ip1->i_ino > ip2->i_ino)
> >  		swap(ip1, ip2);
> >  
> >  again:
> > -	retry = false;
> >  	/* Lock the first inode */
> >  	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> > -	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
> > -	if (error || retry) {
> > +	error = xfs_break_dax_layouts(VFS_I(ip1));
> > +	if (error) {
> >  		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> > -		if (error == 0 && retry)
> > -			goto again;
> 
> Hmm, so the retry loop has moved into xfs_break_dax_layouts, which means
> that we no longer cycle the MMAPLOCK.  Why was the lock cycling
> unnecessary?

Because the lock cycling is already happening in the xfs_wait_dax_page()
callback which is called as part of the retry loop in dax_break_mapping().

> >  		return error;
> >  	}
> >  
> > @@ -2988,19 +2984,11 @@ xfs_wait_dax_page(
> >  
> >  int
> >  xfs_break_dax_layouts(
> > -	struct inode		*inode,
> > -	bool			*retry)
> > +	struct inode		*inode)
> >  {
> > -	struct page		*page;
> > -
> >  	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
> >  
> > -	page = dax_layout_busy_page(inode->i_mapping);
> > -	if (!page)
> > -		return 0;
> > -
> > -	*retry = true;
> > -	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
> > +	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
> >  }
> >  
> >  int
> > @@ -3018,8 +3006,7 @@ xfs_break_layouts(
> >  		retry = false;
> >  		switch (reason) {
> >  		case BREAK_UNMAP:
> > -			error = xfs_break_dax_layouts(inode, &retry);
> > -			if (error || retry)
> > +			if (xfs_break_dax_layouts(inode))
> 
> dax_break_mapping can return -ERESTARTSYS, right?  So doesn't this need
> to be:
> 			error = xfs_break_dax_layouts(inode);
> 			if (error)
> 				break;
> 
> Hm?

Right. Thanks for the review, have fixed for the next respin.

 - Alistair

> --D
> 
> >  				break;
> >  			fallthrough;
> >  		case BREAK_WRITE:
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index 1648dc5..c4f03f6 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -593,7 +593,7 @@ xfs_itruncate_extents(
> >  	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
> >  }
> >  
> > -int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
> > +int	xfs_break_dax_layouts(struct inode *inode);
> >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> >  		enum layout_break_reason reason);
> >  
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 9b1ce98..f6583d3 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -228,6 +228,20 @@ static inline void dax_read_unlock(int id)
> >  {
> >  }
> >  #endif /* CONFIG_DAX */
> > +
> > +#if !IS_ENABLED(CONFIG_FS_DAX)
> > +static inline int __must_check dax_break_mapping(struct inode *inode,
> > +			    loff_t start, loff_t end, void (cb)(struct inode *))
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void dax_break_mapping_uninterruptible(struct inode *inode,
> > +						void (cb)(struct inode *))
> > +{
> > +}
> > +#endif
> > +
> >  bool dax_alive(struct dax_device *dax_dev);
> >  void *dax_get_private(struct dax_device *dax_dev);
> >  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> > @@ -251,6 +265,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
> >  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
> >  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
> >  				      pgoff_t index);
> > +int __must_check dax_break_mapping(struct inode *inode, loff_t start,
> > +				loff_t end, void (cb)(struct inode *));
> > +static inline int __must_check dax_break_mapping_inode(struct inode *inode,
> > +						void (cb)(struct inode *))
> > +{
> > +	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
> > +}
> >  int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> >  				  struct inode *dest, loff_t destoff,
> >  				  loff_t len, bool *is_same,
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 49f3a75..1f4c99e 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1063,7 +1063,7 @@ static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
> >  	pud_t pudval = pudp_get(pud);
> >  
> >  	/* If huge return >0 so we abort the operation + zap. */
> > -	return pud_trans_huge(pudval) || pud_devmap(pudval);
> > +	return pud_trans_huge(pudval);
> >  }
> >  
> >  static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
> > @@ -1072,7 +1072,7 @@ static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  	pmd_t pmdval = pmdp_get(pmd);
> >  
> >  	/* If huge return >0 so we abort the operation + zap. */
> > -	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
> > +	return pmd_trans_huge(pmdval);
> >  }
> >  
> >  static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
> > @@ -1183,7 +1183,7 @@ static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
> >  	pud_t pudval = pudp_get(pud);
> >  
> >  	/* If huge, cannot have guard pages present, so no-op - skip. */
> > -	if (pud_trans_huge(pudval) || pud_devmap(pudval))
> > +	if (pud_trans_huge(pudval))
> >  		walk->action = ACTION_CONTINUE;
> >  
> >  	return 0;
> > @@ -1195,7 +1195,7 @@ static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
> >  	pmd_t pmdval = pmdp_get(pmd);
> >  
> >  	/* If huge, cannot have guard pages present, so no-op - skip. */
> > -	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
> > +	if (pmd_trans_huge(pmdval))
> >  		walk->action = ACTION_CONTINUE;
> >  
> >  	return 0;
> > -- 
> > git-series 0.9.1
> > 


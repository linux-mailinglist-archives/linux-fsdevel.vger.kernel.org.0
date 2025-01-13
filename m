Return-Path: <linux-fsdevel+bounces-38993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC1EA0AD07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 01:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CFB3A6BCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFA518E25;
	Mon, 13 Jan 2025 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fI0MsrAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37EBC8F0;
	Mon, 13 Jan 2025 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736729851; cv=fail; b=oFszc0UJAEjDnTVmjrKvQ/hxzri78/IKUCbEFjJXCHsHQvcSVF+tFShPLWml2r8PidfqCIDYmOm3xe4kJVECygS5ufY5QlNu7wdR2AuBeEGBs2Xp6MLEsweLZgus9DNRKLCt+YrIi6Lw1RooIb6AWnw4ubWORJBPER+e+QFZnA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736729851; c=relaxed/simple;
	bh=JvMCzuI2f0dFfGBwLoVwPP+hLJ12chTOT6cp+IUi1hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XKdMg7qyL2seQvzmovQ63c420zr91dxPdhHtdB/I9man+TrGCJ58rpGaZ+koDDU+r6fk1uMVcNP+HjBQZAM77xzkd4/S8Sy73QJsweGuIGswaKUSEjM7Rsr6bb49cPS1+HQFFfmc/TsA+Yy8MLfPR5zn0izTAxHh6y3KSBV+m+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fI0MsrAy; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJTuHwSHYkgvBXD4SwiPg6oMFq4wA7GI1OJiGeQ2ziQ8z3BJYTRPD/ayz+S8EXH/dI5EnWFIv69uMGDyGJdbDAB3FzhoQp+mCJYjULeIBYzp3yMH2cSx9IErhyGh2H6j3E8Nxt4nxwZrlMkQ0VE47bBandiRIl13YaY2yIlzEq0SIuiG80aFGedbHMqcL9ZhDJBPq2oLXhTk9HK8jlRKFOm+iQVlETiGDGdmOXCsTnoOaATPoHq1lUNLR2y2yG1pO1wyj2Nev93721vTR0vsQpC2XbAvT3nmqilbtKBwZW7074Yar8ojC7kF/yo6d5dzHyLOCj9Rjehg4D6P9QpdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qy4PSPVa1D2q3bbBKc7pDN8WY6y579fk/3JorpoSu4=;
 b=L+dRgqsqlNJ46JLmlcFbiISm2pZIw7mxotqLTNXKv2wpKY33mrl8Xg53zqsFujS88yGGGkYe7ZzE80IsVVDCYjvNB6V1AtCZh67FVL/RI+31/eSj3h7FtFbT5Oeu6T4PPU8VS37wnoXmeqNWcnucnqa98yV0J70rXAMMeBvgsi5hDZAZ5VOkAsyqsVb0dhrNFNGR7/sb4RkiiKdE3vYT3eM84Egec2eI68TykmGX7qjnvKs+HMGHKQNTCMwvoi9vXqYc4pshzgElk7lVg3AR4Qlv66aqWfaYkMJGSnLHagg+Fbv4FWJYCxucy+rPX586UHfn3icAP4lsu8IUsp6EOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qy4PSPVa1D2q3bbBKc7pDN8WY6y579fk/3JorpoSu4=;
 b=fI0MsrAyIRTMkldodxLFqQtX2E9RnL1NFlj+r9DjEqKoCdBCa8f66nysgbSC0Gtlr1yr0CRdFoZYtgnWpyyGaDTSQ8IBbWput3G0T3U2yt8BMH6ZYj7DA1pxmUiwoOh1+I1hyN4HgPCFOmkXKFv7l0cbTgYiPOXlgA13n/eN2WUoKEAo/0fBwwN3lNv2iee2vVvU4Nac3kXA5zTqSe1LaW+XPU8YvoQU2ubEBjSGB2Uil5BR/bb81ellQIomr+9yXksS0SPKHE6dJDFELIOm+eKZ3gDn+IM44Lpo1z2RudLDwvZeGFH8m+MSF1zqYefp2tsPm9yqXdQ86ez8YHG2fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.17; Mon, 13 Jan 2025 00:57:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 00:57:27 +0000
Date: Mon, 13 Jan 2025 11:57:18 +1100
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
Subject: Re: [PATCH v6 07/26] fs/dax: Ensure all pages are idle prior to
 filesystem unmount
Message-ID: <p5vmaqlzge3dkkpnwceewi4io5ngqaczfa7ysujwa45kkevnam@sqc5usu7vgde>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <704662ae360abeb777ed00efc6f8f232a79ae4ff.1736488799.git-series.apopple@nvidia.com>
 <20250110165019.GK6156@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110165019.GK6156@frogsfrogsfrogs>
X-ClientProxiedBy: SY5PR01CA0113.ausprd01.prod.outlook.com
 (2603:10c6:10:246::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: f58cdcfb-f389-4fc6-f8dd-08dd336d3f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LcaP8DNMdlUliLpCo2Bs+3Fne+8LGHIvWyxI1csXqy6TcrAs2e18c9frjl4a?=
 =?us-ascii?Q?mi0G6379x3HYeM0gbVSmfp95G5OrLWsgDQeWz9UHm5OkaXkIgatBro1Rg/sH?=
 =?us-ascii?Q?u1hPxgGvDOJjq+c/KUp5r0Bl34UGj2a8hMzwfF3cvbawwzqjQwq9x5Xj+azx?=
 =?us-ascii?Q?LsgHOUhHtKZ9zS+WHFb2PFl72fmlNirUxkjM1IVVSMqV4Z0nrgHXGLVCO2uK?=
 =?us-ascii?Q?AD3FMma24xQLhMPmONqLyjc1CAaY04QSzvg7JxAGgvW0zCFHbVWA4boggGCJ?=
 =?us-ascii?Q?L1ZzqfE88f7CvVOn6MMytsJZU6AVKK4mpgX5hfaGDE5NMac3Kxtec46yd/VV?=
 =?us-ascii?Q?OwQsROlwLUJTV8SmtNHsLKOR40EYylxBGxkP1W/ymSyFtMDOJ3Xp/93O2qC6?=
 =?us-ascii?Q?wPYknjlqEadRW2eTRt4Gzl2j1hkePzA5e9YuEA8921GRwW3WjaZk/qvbJ7hm?=
 =?us-ascii?Q?SlI1dStzobWRwLUYUs1+cJfsNZnxEVnTaa4w10lBkhaMtgft9915f6VsLbjc?=
 =?us-ascii?Q?KSOYf/lAwWBe3RjdslSLKFiAeHuhC94Ix5BEsMhtDfC9IY/aoZCPwp8Dyctr?=
 =?us-ascii?Q?A/28VqHk7FBzuzgt8s2tbD7JrDZiSJoVQqA9rzaOQjFI6EXutW1w97yhgYW2?=
 =?us-ascii?Q?qAm3OM0tp1v7xDQTQ8qnZQeXhrCdj/OJXGlM5VcucHYBhGuZlx4f4XQc/u9w?=
 =?us-ascii?Q?uBkYSRXt31Et4tLToFL0yEtoVuwyYqF32htjT1KR9R0MnhYQ0vIhS3v6QwyH?=
 =?us-ascii?Q?GxQtoAQ0VbFFfFh1K4UEs/l/OvDeW3ipcREux1QUAOgXw5U+pCdhEi5rsSLM?=
 =?us-ascii?Q?scEZdUtXLY2NFu20dT2QiNHbgUy+wzASilUtlCk/2N1waGGX6xqQhrP3MV3A?=
 =?us-ascii?Q?RiQLgiMQPl2AVQtTlZUyivrLrkc5Fo8ZMuHmsGNW6DAv9QzYpUMM6czazGrQ?=
 =?us-ascii?Q?3K49NL6clWNtuK5Vx3SGx+9V8MVRe4st8kee7BgKvTATqBGesr1d3L4c3mfX?=
 =?us-ascii?Q?dUNBlUBo7vhGU9Hxr5BS18LkycGPp/HP7UgJcJaZVXdBzEDIb5AC3Vbwc6nN?=
 =?us-ascii?Q?mfDTjNXLcHPaqKEzz/8UVk5EFkooKwKA48XKPemMDC7wJ504LE48XjZoJqaA?=
 =?us-ascii?Q?lRVrBHs/YDED5QlEpvOUm53Sr5HPMPfAVJpybGlB9cXrpBQF5vGVle+9dBZO?=
 =?us-ascii?Q?rGGT9LUfpr7UN1zQfUzljCEdAYGl+tYPaoC6ACgH/fPm9oT8KvfQaP6wJ41G?=
 =?us-ascii?Q?LWktRDnxWZ1NpwbhiFtDswwexmGx5BdhtT+v1mm8vq8cDcz4BF0aiRsCD56a?=
 =?us-ascii?Q?11G5pyPGp6gg7HrENmLZBopUtfte/vTcjXtk3twJikTupEy9NOhhatzcEFqc?=
 =?us-ascii?Q?+OZ9Sd5sTWUB1L+pzj+GwwNGF0i+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kum9efgDlWgKHuixYo5eo5AWS5Hb6ZJYTD1tRGA8JFalCdKIQqVju76DlJVu?=
 =?us-ascii?Q?qW8wLUIFqCmFypGDG/ZDtSFFd83jlzPhKGK2BBYy60pGW3MTM4/YNDj6KHdk?=
 =?us-ascii?Q?buy0atYmmI5SNtxSTbXHnv8Ehz90vknkgpYEaxPjg9S4XsT2VyNjoPRZ0swl?=
 =?us-ascii?Q?mSLsHYoRswsgTZDwZL/gUNWOAp3SIL7frqqWJM1ZBVy8mhFS4KitUULqssxY?=
 =?us-ascii?Q?zb0YhEeo3CQgMkYXq15s7IETQS8EYg6P3YJRSi3TgxJlEK21xxHfKekq6ZfV?=
 =?us-ascii?Q?sqT12NsbEPlvEePC6b9GEKAP8XiS+jL6+/k21UrZGchCN2hFO06xTSLf2L5x?=
 =?us-ascii?Q?Zfnbp4hac/+mRrhXg4+mdaIyno5hNYSjVjgKonV1AlpqbdrsDCd1OcIfgVX2?=
 =?us-ascii?Q?+f9QSz3lw/RYTD2pO2o9vDSBe0EpFJpqPjPKD+gfk9QwmMWLa35HcK+TVbFi?=
 =?us-ascii?Q?I/4miw5cYU9UCJ81IU1rA/l2x5ys6ljPjncG5hao7MD+xazsEORWECZkd18b?=
 =?us-ascii?Q?3uGKO2Mc0D+xMVDT2B3Ip0no3UxfnWOGdeg+hL9Txb2p2cf3/vfforH6ZZS5?=
 =?us-ascii?Q?nLFLQtdh3BgB44/qKvCQrgCEopXnj22PL6AsvWvCToB1ub1N4Ukbw5zgNylu?=
 =?us-ascii?Q?BUjzf2QYq+nvTXENtuX+GzkEj4yKiSFVGPe2qwgzbTP/fJXEvfYfqvKsWkTP?=
 =?us-ascii?Q?vRCfYoPuF5xNcENAg2GXS2o6aJjMx1M0G9CIs8G64QUbdjbXNueGtBDGduZq?=
 =?us-ascii?Q?kXKt9+SYyNGYdm0gHoXukim674I+oSkCxzZf9j1fql4QxG6KzsVJgRSMcs6E?=
 =?us-ascii?Q?rkPgluTDUgd5QjvW/i6m8tkkmGdUKqYUmRuevpatALo+7bIvRVlTuPwvykuC?=
 =?us-ascii?Q?eMGvNZHQZA1X+dzDhTNKyWWNhaae3o+FEcOBweNRXLnmU6oXOC0LUU4/L4Zs?=
 =?us-ascii?Q?UWxuPaW9nI0ftP4GfHOWmxdsoKUaLrXdV5Dzy+Q2srKELl3Pa1b7zRWvI4if?=
 =?us-ascii?Q?x68LYADoSbbrLrACufuGdrT0wZHQgjZIu6VgI6Y5laUnuC/P+DDvoS/1tg0l?=
 =?us-ascii?Q?KzlXJYAQ2qawEDQ/stXFLXuvYlm/Dcsl/dEZhOLZwvEpoIaWQC7/BF7Cuj4y?=
 =?us-ascii?Q?CyL5gLycmiL0eaYjAw9cNaewsQQsR0taChuptcmoYt99OkehQGtQUOgAprcw?=
 =?us-ascii?Q?05Otr+d9IyMBzcBYavfEBMT2WAtSy55ZH+VGmwCXrD9QCamwSHHRrHox6Obh?=
 =?us-ascii?Q?7vttxUFdQmQn5gZenGeXRJxfZaK9OYyD7AVOJqsPErgB9g1xxnuNuJtHuZlT?=
 =?us-ascii?Q?47rWQaC7xiAw5dpyzlPFoEJAUdnm5WiTzseh0OxID9DDVZFES9D/JUcwRgtD?=
 =?us-ascii?Q?pmpn0puCEWyEJMT5GSgMQSiCeNBhsjljUB/FyCxY+Ut9bKbdqm7dBIImYmgX?=
 =?us-ascii?Q?E8MOpGylE4H6RRb6zJKLIXVJ5khoV9yb0Zm5D9+hyrBfgdqoADhaJiBA2m3O?=
 =?us-ascii?Q?sseoYgLqiYHBrCrUgMGlqnFjUpUxZpYWrncFr901z9xQTw8N12X31ssExcv9?=
 =?us-ascii?Q?m0Nui9Nmi3g9jjOGutTgO1gcpsVbiE4pMl7FXeYL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58cdcfb-f389-4fc6-f8dd-08dd336d3f4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 00:57:26.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOR08BOaEjTQWq63vqbIDUn6bU33W+YSeABJjWysltFT1e/mYpx//iM2QR2SFgyOS0b9LoxRc9BJThj5Fy7ucQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104

On Fri, Jan 10, 2025 at 08:50:19AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 10, 2025 at 05:00:35PM +1100, Alistair Popple wrote:
> > File systems call dax_break_mapping() prior to reallocating file
> > system blocks to ensure the page is not undergoing any DMA or other
> > accesses. Generally this is needed when a file is truncated to ensure
> > that if a block is reallocated nothing is writing to it. However
> > filesystems currently don't call this when an FS DAX inode is evicted.
> > 
> > This can cause problems when the file system is unmounted as a page
> > can continue to be under going DMA or other remote access after
> > unmount. This means if the file system is remounted any truncate or
> > other operation which requires the underlying file system block to be
> > freed will not wait for the remote access to complete. Therefore a
> > busy block may be reallocated to a new file leading to corruption.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > 
> > ---
> > 
> > Changes for v5:
> > 
> >  - Don't wait for pages to be idle in non-DAX mappings
> > ---
> >  fs/dax.c            | 29 +++++++++++++++++++++++++++++
> >  fs/ext4/inode.c     | 32 ++++++++++++++------------------
> >  fs/xfs/xfs_inode.c  |  9 +++++++++
> >  fs/xfs/xfs_inode.h  |  1 +
> >  fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
> >  include/linux/dax.h |  2 ++
> >  6 files changed, 73 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 7008a73..4e49cc4 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -883,6 +883,14 @@ static int wait_page_idle(struct page *page,
> >  				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> >  }
> >  
> > +static void wait_page_idle_uninterruptible(struct page *page,
> > +					void (cb)(struct inode *),
> > +					struct inode *inode)
> > +{
> > +	___wait_var_event(page, page_ref_count(page) == 1,
> > +			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
> > +}
> > +
> >  /*
> >   * Unmaps the inode and waits for any DMA to complete prior to deleting the
> >   * DAX mapping entries for the range.
> > @@ -911,6 +919,27 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
> >  }
> >  EXPORT_SYMBOL_GPL(dax_break_mapping);
> >  
> > +void dax_break_mapping_uninterruptible(struct inode *inode,
> > +				void (cb)(struct inode *))
> > +{
> > +	struct page *page;
> > +
> > +	if (!dax_mapping(inode->i_mapping))
> > +		return;
> > +
> > +	do {
> > +		page = dax_layout_busy_page_range(inode->i_mapping, 0,
> > +						LLONG_MAX);
> > +		if (!page)
> > +			break;
> > +
> > +		wait_page_idle_uninterruptible(page, cb, inode);
> > +	} while (true);
> > +
> > +	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
> > +}
> > +EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
> > +
> >  /*
> >   * Invalidate DAX entry if it is clean.
> >   */
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index ee8e83f..fa35161 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
> >  	       (inode->i_size < EXT4_N_BLOCKS * 4);
> >  }
> >  
> > +static void ext4_wait_dax_page(struct inode *inode)
> > +{
> > +	filemap_invalidate_unlock(inode->i_mapping);
> > +	schedule();
> > +	filemap_invalidate_lock(inode->i_mapping);
> > +}
> > +
> > +int ext4_break_layouts(struct inode *inode)
> > +{
> > +	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> > +}
> > +
> >  /*
> >   * Called at the last iput() if i_nlink is zero.
> >   */
> > @@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
> >  
> >  	trace_ext4_evict_inode(inode);
> >  
> > +	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
> > +
> >  	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
> >  		ext4_evict_ea_inode(inode);
> >  	if (inode->i_nlink) {
> > @@ -3902,24 +3916,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
> >  	return ret;
> >  }
> >  
> > -static void ext4_wait_dax_page(struct inode *inode)
> > -{
> > -	filemap_invalidate_unlock(inode->i_mapping);
> > -	schedule();
> > -	filemap_invalidate_lock(inode->i_mapping);
> > -}
> > -
> > -int ext4_break_layouts(struct inode *inode)
> > -{
> > -	struct page *page;
> > -	int error;
> > -
> > -	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
> > -		return -EINVAL;
> > -
> > -	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> > -}
> > -
> >  /*
> >   * ext4_punch_hole: punches a hole in a file by releasing the blocks
> >   * associated with the given offset and length
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 4410b42..c7ec5ab 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -2997,6 +2997,15 @@ xfs_break_dax_layouts(
> >  	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
> >  }
> >  
> > +void
> > +xfs_break_dax_layouts_uninterruptible(
> > +	struct inode		*inode)
> > +{
> > +	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
> > +
> > +	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
> > +}
> > +
> >  int
> >  xfs_break_layouts(
> >  	struct inode		*inode,
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index c4f03f6..613797a 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -594,6 +594,7 @@ xfs_itruncate_extents(
> >  }
> >  
> >  int	xfs_break_dax_layouts(struct inode *inode);
> > +void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
> >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> >  		enum layout_break_reason reason);
> >  
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 8524b9d..73ec060 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -751,6 +751,23 @@ xfs_fs_drop_inode(
> >  	return generic_drop_inode(inode);
> >  }
> >  
> > +STATIC void
> > +xfs_fs_evict_inode(
> > +	struct inode		*inode)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> > +
> > +	if (IS_DAX(inode)) {
> > +		xfs_ilock(ip, iolock);
> > +		xfs_break_dax_layouts_uninterruptible(inode);
> > +		xfs_iunlock(ip, iolock);
> 
> If we're evicting the inode, why is it necessary to take i_rwsem and the
> mmap invalidation lock?  Shouldn't the evicting thread be the only one
> with access to this inode?

Hmm, good point. I think you're right. I can easily stop taking
XFS_IOLOCK_EXCL. Not taking XFS_MMAPLOCK_EXCL is slightly more difficult because
xfs_wait_dax_page() expects it to be taken. Do you think it is worth creating a
separate callback (xfs_wait_dax_page_unlocked()?) specifically for this path or
would you be happy with a comment explaining why we take the XFS_MMAPLOCK_EXCL
lock here?

 - Alistair

> --D
> 
> > +	}
> > +
> > +	truncate_inode_pages_final(&inode->i_data);
> > +	clear_inode(inode);
> > +}
> > +
> >  static void
> >  xfs_mount_free(
> >  	struct xfs_mount	*mp)
> > @@ -1189,6 +1206,7 @@ static const struct super_operations xfs_super_operations = {
> >  	.destroy_inode		= xfs_fs_destroy_inode,
> >  	.dirty_inode		= xfs_fs_dirty_inode,
> >  	.drop_inode		= xfs_fs_drop_inode,
> > +	.evict_inode		= xfs_fs_evict_inode,
> >  	.put_super		= xfs_fs_put_super,
> >  	.sync_fs		= xfs_fs_sync_fs,
> >  	.freeze_fs		= xfs_fs_freeze,
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index ef9e02c..7c3773f 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -274,6 +274,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
> >  {
> >  	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
> >  }
> > +void dax_break_mapping_uninterruptible(struct inode *inode,
> > +				void (cb)(struct inode *));
> >  int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> >  				  struct inode *dest, loff_t destoff,
> >  				  loff_t len, bool *is_same,
> > -- 
> > git-series 0.9.1
> > 


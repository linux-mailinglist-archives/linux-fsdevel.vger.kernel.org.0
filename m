Return-Path: <linux-fsdevel+bounces-39235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F7A119CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 07:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6807A2AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 06:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D026B22FDE8;
	Wed, 15 Jan 2025 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lenOI+IW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9131E04BE;
	Wed, 15 Jan 2025 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923095; cv=fail; b=IaHXH6ceMDWSpvgMnb6CNIUG5FNDeNAXAg/wT8Iwc/0rOmanmSeUVrWfSmmytEElHcHM94yNidGfs4URZ7oy8Nhi+uGpg3wosZ0cfX6fx0fpjXvx8QQPXZ4g58Vlh4xAA0XBHDSTNai+jWDr6IAC49InCht0iFYBMvljRWBa0N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923095; c=relaxed/simple;
	bh=xfwx8szzA79GeMwa8YiuAiiuZ1nqyifzyyhX+crJD38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tUzNKmIaZ5o2DUW0ts7+KoR8ua6okWDnuDLiKwrv399HW7kkurmd3LaAX2HaB0h2tr2tcHFdGyzoe7sg9YkdYlnBXDS+LvVG4DOctUAfIQ4PECHuzhZCmh16bPBG+0kRtOaL2qiWHjbOow7qIGWnysn0gY3gRfU54vG0o/tun0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lenOI+IW; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=App8UN1S3JouPiXuWxcy4mOcMHj+qn66FUEaLqqs5cUSY4Gc41FsU8GehsLkw0uVDl6lz3AruGZ61V5YGNdzgl6jQG2M+D3w9X6J8koc1wNKmNr76hq7qQJgRk085t+Cqx2Lx2drhdQFEoo+DIIdm+5kXrKFvTaNn/xECQXQjqt+G69errM3GeA7L61iRQJPSynVzPlK6l9ufuk8mRt8BkGrymBpsylTymurDvbT7W2MjmSIqdN9A/YD2FUB9BXm2mYNy4RRHymuZpAniCy9PSCwHL4QFVcLGZXFwFvXlXB9PGhCg6lODWedGP2/O4BnUgmQ7dwCbC3e2PpbMZ/w1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy0hdU9kmhJfOaHknI9Qw+omeb8Gz6hFekYnxTQBmmY=;
 b=CdGMbiiR7gCidenCwt6T3oTugdVDJfZmqpBi6y999nVLzf3pmVX0dEShWZW0cxxEm+NoMgAm/CRI2gpdyT8qOqQbn6qNo/DQbupM/zinT+a8eZD8js/lk2se5h2IGIRRPuBEuxPCPTVCGqpmac1Ln5VuvqRuOo0OySYilWX93A9w+ABydCH8ohEB9OdNRinHKd2r8WR7XLwfGmPvXso8NDw3VaNsloGwckKjtJgvvCJKOoqtdSFbebdyMg5Se9Myt6MhhzwqvIgE8rzuS2wNfVFRJEKtaf05aoXFWru7QeTumsGNAkrbD7oBIvhYOHueM0rBapqBPbYvJO4urzh6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy0hdU9kmhJfOaHknI9Qw+omeb8Gz6hFekYnxTQBmmY=;
 b=lenOI+IWTQQXlB89D9FW/Jacu9OtATjD+1CCarUhWKPk1MuyrCWGHoRRleQDw+lRstkUbaf5u3mi+Q3X4cSbaWCbbzh62/k19qPz3B+qgGGBmFnlY7PDUq2mxRxfe747TfoKRdXPQfTOur2eo/fMOcHzdMnURTU7HHp+KFwNrwjvBNoeZXAznCmPLCOHvqIuI7ynwqJBLTAOQ0/Egly3O1qMxkyYE4uHUxBG11H+E6TpRHPij7isMAjvnMyzTVV42mfDq/7u4LncoAGLPaAvy/J8AYjHyY4IG1HoCFyVt4b4l2Kam23ooBWgzv8OPdUGzh8nyO+6X6rwCUz3VC4TVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Wed, 15 Jan 2025 06:38:10 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 06:38:10 +0000
Date: Wed, 15 Jan 2025 17:38:06 +1100
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, alison.schofield@intel.com, lina@asahilina.net, 
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 15/26] huge_memory: Add vmf_insert_folio_pud()
Message-ID: <ubf5hakohi4hhmoqdxk255rwarwv3vwt7j3l5aqtznorfcxx6r@37jhsud4gjtw>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <60fcfaa3df47885b1df9b064ecb3d4e366fc07e7.1736488799.git-series.apopple@nvidia.com>
 <fb1b7d1d-33da-4de1-b863-61ea8421c7fa@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1b7d1d-33da-4de1-b863-61ea8421c7fa@redhat.com>
X-ClientProxiedBy: SY5PR01CA0119.ausprd01.prod.outlook.com
 (2603:10c6:10:246::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b46ec6-3147-4b7b-147c-08dd352f2d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CWI99AWTjKNAN+yv/UKEJl6cnddjQJ8PZa0siiKvDK73GO7hWP/726bVJYIs?=
 =?us-ascii?Q?gOXmS97+IBHsScf8VXHkBJ2xoYxVHbJEmw2uixn2zkDqT54ZDDd9itVltAKt?=
 =?us-ascii?Q?IY+T6pmXjII5FkaZ1PWnd7eJH6v43jpsHL8dY+v9TEy1zCnLzdjazP3U9cAr?=
 =?us-ascii?Q?ZTfNQk9Ua+wk6WrJypFHqlP8r/lXjCX59GttZ66P+ckXqme/k2DPLFtW9XpJ?=
 =?us-ascii?Q?yowgMBfqy6QJcW0Nw8deizyAeDRpThhKBYxpVbRmXqYt0Mw5zlR9QQtwk9sj?=
 =?us-ascii?Q?fh0t5oZEQv1pw5jaBYOqaVqBtYdqN1ZRC2gfxy+vOBLZ3NFcJ5uMUQqPUBCd?=
 =?us-ascii?Q?FddohIVAYqoUbD1W5IGtRRgLhj23ae+nhV5kYRLrxfS/Jyf2vfiilhFjl7Tf?=
 =?us-ascii?Q?h4VDRPkXSDg2ObxgXs8GUuhhAhTRfunC6ZGVGF1IjSi0iTGGKlIWVpVJLaZg?=
 =?us-ascii?Q?QVT/OQr78gsKUywBGf00tMskBR7uE3acosU3khd8cp6N0o6WOEkGluirbOU5?=
 =?us-ascii?Q?vgY2z0tqJIyqTCvKOMMVTYGhfU6Q6ISOXSPLj/rlIvD955HkBFDAM+DWBeJE?=
 =?us-ascii?Q?yjwg1MalomR0iKMRoIgQCIl08MCS6NVnJRyfHEEZX7Z3keibUltj6lh1adV5?=
 =?us-ascii?Q?ch1ThHeZ4NcC+SyMvXlY1x7OcNkaXnnWqSz8KaXWfRswndWrU2jz3ho/i05o?=
 =?us-ascii?Q?xdu6dGttWmx/YQJa2D550sTeKfFVYR2s5YNwNCq7HJ7Uwv/0oV6Vn1oECeo0?=
 =?us-ascii?Q?lUpCyAG1Qi6S3h5Rjoqsg17KuQlQFFteYwkJATIbI668FkAvtBG20YxY0XE9?=
 =?us-ascii?Q?9b2dq2RhsNsF3V0/euW3HUQY7/DgtpNgtET5u0/fhbpU00D8kdnlgAG/mQmX?=
 =?us-ascii?Q?LCqz6TrgHLM7SU7tRgxR3i+jmV5ZUJgCZUifNNOd3JpTJxd3anpMdXBZt8MR?=
 =?us-ascii?Q?1K+HyNPNFXD7oJbMSDrFAliL0UdkWarfdMGuXCZZA59T6nn+/evigCSD9oBY?=
 =?us-ascii?Q?6tmI5bKgJdF2siytsPLlTeKTd2xv4fqN7jwWHeHXR6ONyarb39xbu/IarxUc?=
 =?us-ascii?Q?RxNB2l122l1gprVTXZbrv69OgPvmdErRtc4WdKhoVI+yptg6QSev+0EhWyAT?=
 =?us-ascii?Q?2qeFt6g0ASzQzKqZ2VysgHDkRR2fGJmcTGqotOXwCBiYwyPos509VwMQvAY0?=
 =?us-ascii?Q?tNR651jveB6sPeOxf7DfyfQqapaklyFEAYlac3cbJZqIiyRjWpPCIEE6QyS1?=
 =?us-ascii?Q?7mUq9ETsZZtvZeb6BUa46j7buVcoKpdONypThVQ06UQBDKd3csECgOEZdOwL?=
 =?us-ascii?Q?mBQKoavxohUgnwMK9lqDVONUwPibzxhJ47dR5kuKh4WpUC9z1INO9Yq67sly?=
 =?us-ascii?Q?PQgIftQU3G/r12jAOHe8eCUqfDmG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSSMzF3LlVhhkNcHBYfRms5eqCCZ83R/Iv4t4ZlKPGncblUy4vTNx+O8diCT?=
 =?us-ascii?Q?GPVjHZ8DgGyhTRjfYHbW/pf5I7uNlj071Zjm3W3jcFKP/dy3dyhB/rPCz7AZ?=
 =?us-ascii?Q?Vq31nl/ST30qxQAscGrLGuu4KUSFtOZkj9ThqBmCcksS0fQeN1Edhp3emlVS?=
 =?us-ascii?Q?EguUiidQ9Dv/I/w4K2yFqrSmM9uF17NrcvXsdZVxaEwLYm2ju0dPXOBLx150?=
 =?us-ascii?Q?7bUYUUtli5YHmluJjMOYc8/i5Ns3zXvI5DQy3eeqU+k9wLwoy5AaxHTYhxHf?=
 =?us-ascii?Q?r0uNHmlXB3BYNFBWLuSMSb7Rmeogocima07AkWnLD80fRERg8qcLPhz2t5BP?=
 =?us-ascii?Q?nSuFml34O4hD8Iu0Ba6WLKJHLf4BZ9ZQasWECltylHqcMeJvmfYABuhHQSXD?=
 =?us-ascii?Q?M5Vkn5qtxJkliRO08LmmUulnfZhOMvRDYCD/1bdy2uqu4ltJPIXlJmVZOmDK?=
 =?us-ascii?Q?HOQkewJRT3LMODupu8VmmAWNX8TElC1oucrwL6Oieapun4ay4msLULHFswFE?=
 =?us-ascii?Q?B7Lunk+RNLX/bAmJpUBqVB5WWqWj4vpKdhyF1uFnAm2C7eTKk/BecMD5Uo3D?=
 =?us-ascii?Q?6nC3qfBOUYUOQZ6zq9XOJjQTVpa8dC5NoRJ+XLgSuVEzm7By678Q+X3/qMak?=
 =?us-ascii?Q?FIgq95x8IqAuI8JzA00bW7CUGjvI4q3fkR6Yc/YX4mYTnuEVRACY/OwFV0FE?=
 =?us-ascii?Q?qZCbtAI2oOGeYPYYubqB3HEJt7XJn3kuu8RMgmsU5U9hBTnmiW7yqt89pY6L?=
 =?us-ascii?Q?WTr5CEuN8hrmJgpyRYixgBqlbjQbxldvZWqlP6nEdD8nl44enX6G1njfirw8?=
 =?us-ascii?Q?8PkWVC78a/bULti9+0C6tAkpBrjD8WlbaaRrU2L1sA+s1PN870nV2pq5L+Pr?=
 =?us-ascii?Q?FWoWvc21T4TdifytOwBvWImg5A8XbYrmnril6kDUsTm4KyVQBMVxk8wcyRHb?=
 =?us-ascii?Q?TbOuEQl+hby8Qnt1Fmo/UlLdF1rFGz9pt8pxNbBuE9N761xpYSRrDoi1TKZD?=
 =?us-ascii?Q?Y8P9Maecf019urModJ+Nj1Ro+w4Iak9AduZO3dzO1CPgbqomaA9nKclghVrj?=
 =?us-ascii?Q?hpyx5GUTzz6GtZDFE6xDyk0+ZqcNEgze5EdaHIfp8s5pTgMYxTlpLwSUYUv2?=
 =?us-ascii?Q?ZpL9JzmsXRSkacCKmVl38NfMEeq/0VrAg4Zfqtgyu7yIXgCvuX3JvvYPFSP8?=
 =?us-ascii?Q?VL2j4hEAeVUCEc8qQXsaN6btieifAj2rd6Gk2q+WcG0dP6eg9MsAmJWlhgCK?=
 =?us-ascii?Q?Izmt1I7McvcDarGvGqayFDO/6I+zYNxjWZIgbIPD6+JhPQdpCMhC31rQbnhz?=
 =?us-ascii?Q?iTiIeIVn1BOzQ6EcF2HpfXBP4sCud7E6Ltpke0+R4bUUWUxXBTUgQAFwWydS?=
 =?us-ascii?Q?Jp/SUPTW4mPmRf00CYCD5/Zbn5MGpMGo3ExiD081nZve0hzDAHQnAYoRh2YT?=
 =?us-ascii?Q?ScIOpGPGnN9i8FSEsLI83h0v6x/xkCZkOUMASGXEr1FDday8s8npF/7YAnx2?=
 =?us-ascii?Q?2mOp5Y0UuvoviAu9xCHgN7Q4zE3/jim3wl3KMqLWD2oEcowEuehOcAEU/Re+?=
 =?us-ascii?Q?aoQf0KjVbsK+iqanE+tKgK1woRXZgTEDIs/hNUPj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b46ec6-3147-4b7b-147c-08dd352f2d6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 06:38:10.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Vd/94gXzHOg8Mzdci3ULWYAXa5hLJz9+g/JLLMOzPoPQ95axF93n/ruyU3wQGXuI6B5ea1H1y51irJhvn36Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

On Tue, Jan 14, 2025 at 05:22:15PM +0100, David Hildenbrand wrote:
> On 10.01.25 07:00, Alistair Popple wrote:
> > Currently DAX folio/page reference counts are managed differently to
> > normal pages. To allow these to be managed the same as normal pages
> > introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
> > and take references as it would for a normally mapped page.
> > 
> > This is distinct from the current mechanism, vmf_insert_pfn_pud, which
> > simply inserts a special devmap PUD entry into the page table without
> > holding a reference to the page for the mapping.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> [...]
> 
> > +/**
> > + * vmf_insert_folio_pud - insert a pud size folio mapped by a pud entry
> > + * @vmf: Structure describing the fault
> > + * @folio: folio to insert
> > + * @write: whether it's a write fault
> > + *
> > + * Return: vm_fault_t value.
> > + */
> > +vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write)
> > +{
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	unsigned long addr = vmf->address & PUD_MASK;
> > +	pud_t *pud = vmf->pud;
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	spinlock_t *ptl;
> > +
> > +	if (addr < vma->vm_start || addr >= vma->vm_end)
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	ptl = pud_lock(mm, pud);
> > +	if (pud_none(*vmf->pud)) {
> > +		folio_get(folio);
> > +		folio_add_file_rmap_pud(folio, &folio->page, vma);
> > +		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
> > +	}
> > +	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)), write);
> 
> This looks scary at first (inserting something when not taking a reference),
> but insert_pfn_pud() seems to handle that. A comment here would have been
> nice.

Indeed, I will add one.
 
> It's weird, though, that if there is already something else, that we only
> WARN but don't actually return an error. So ...

Note we only WARN when there is already a mapping there and we're trying to
upgrade it to writeable. This just mimics the logic which currently exists in
insert_pfn() and insert_pfn_pmd().

The comment in insert_pfn() sheds more light:

                        /*
                         * For read faults on private mappings the PFN passed
                         * in may not match the PFN we have mapped if the
                         * mapped PFN is a writeable COW page.  In the mkwrite
                         * case we are creating a writable PTE for a shared
                         * mapping and we expect the PFNs to match. If they
                         * don't match, we are likely racing with block
                         * allocation and mapping invalidation so just skip the
                         * update.
                         */

> > +	spin_unlock(ptl);
> > +
> > +	return VM_FAULT_NOPAGE;
> 
> I assume always returning VM_FAULT_NOPAGE, even when something went wrong,
> is the right thing to do?

Yes, I think so. I guess in the WARN case we could return something like
VM_FAULT_SIGBUS to kill the application, but the existing vmf_insert_*()
functions don't currently do that so I think that would be a separate clean-up.

> Apart from that LGTM.
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


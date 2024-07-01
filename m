Return-Path: <linux-fsdevel+bounces-22849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259591DA0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C2728286A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DE83A09;
	Mon,  1 Jul 2024 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lu1ZoyDB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE654F87;
	Mon,  1 Jul 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822878; cv=fail; b=Hb820ioNbNAB282BbX0hyFGYS06pub+FwJVV9CBPMWpwIfKIjNL1ykBPgpPKmkoalU8vc8Y0aPA6vN8FkXEoJh1YrMdav1OsgTzrVyBm8qR4F09X+DDHVqHvhabYIdmqg3AEz0GwI2ocK/I8TainkkofZDQGfIgC/gr026hBVJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822878; c=relaxed/simple;
	bh=Z+eZqxll3oRjGhDzRgOcZCV2QjGU0/IJG2a4qNc44As=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=ZpeCuPvanC04He1Qru8xKOVqKaS9VsTvrRo/ivIItC3vssj8oI2TqtEXmhOJGBMDQZqDYaYF2NQMOhTuNoGsT8EbXughGoHADmJv5+sm+J9cFrfGbXoYTkoaMbDlINtij6bwYeSgRTrXq5z9q3qDcMBgMiPARjW6D8IvTKN44V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lu1ZoyDB; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOtaD0mKyNYxfRgwRv6CaAM+t3Qx3G3Iq7eu1N0SYeAD48y4avhoqNpLWw+dRXmo4KNuBfAXFpeDZVHByYxgq3GU3B1yvQ0hP+Iegcke0hvOlbKdzy5httEsc/4UUksR/owwEsuD7kjFcjRl+2/NqXzcxWmwJXGp5lTT5js1S0GOig4/cJyiXT7xc5eQ2SS9VZdlNkWRi+0UbbHqfg4BRIkgl1tB2tSdAPPBirYZze3o2xaSfkKnFVpAWkaYlWI+0zaJR76RRAKm57dh3KqBBPEBekWeG0uY8WCUBhk6Vy6yi5PB/X5SobBK29XtblkNhrYD+nIMDE/SeDaQD0imhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFNw5m7TevX7O32FT2B4WhapzTHm6yB0PYh9fZOVVe0=;
 b=fb1izYFoHe+9UwvN0OQgTc9CY4eCpD2uuLhDXw9y+ChiymaFVDB+2rVlXlHRk8uoW4BfwNvmOJiY97riyVf72tk0Ob8XSLCBVjSO+lwwnga6ZOcgsGUSQjVIz0M4I9QVXR8d9exoGRjWdHVL3IRAGEowF7my62WFW+AFL1FFWsgQZ0I/y0HptBptUlFjJ8yHFb2YcKRmXvs7f6SoMQP3afTyXE5mJf29t3bem8ZyHeQFuThcLAUUrcIDeFUyEd6DdFoMwbwY3xDqPV/lzENPHFL1JwKW/DKZ/irtkcllPhGsuz06knAFFxFaO6CQ1PPLdNmhbASPKRp9yMTlJePfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFNw5m7TevX7O32FT2B4WhapzTHm6yB0PYh9fZOVVe0=;
 b=Lu1ZoyDBnGLn1frb6qiyltBSFMlR5Iwin46tZX2tghr8stvR2GBq6yw50/hQcQmsYYOU6lumh5Ns/SxGSWbTobzmmA7bzpM4hnN1HCDNCtQ1u7isogDu3I3Zv1dfEtABY4jEmDj5HpsopECWJS9o3QKnZx6Oldvq+TimPxkgEIMoHrnZSiO0qA/ehBygY/U6RUETVlPXOftp7b31rYOCPW0qlTOCOfsPHzrFjjzAjp14HUzbunDSI9V3QtNgSNaf8o3TmFE0wuMQ3ETK+GikFcbPYrqit2keyUVGs2yOEfuvupGjd9BlXT1j75b/On2HX94rZOITgFO0XWjkhniKDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Mon, 1 Jul 2024 08:34:31 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 08:34:31 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <ZoIvhDvzMCw28VBI@dread.disaster.area>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dave Chinner <david@fromorbit.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de
Subject: Re: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Date: Mon, 01 Jul 2024 18:33:34 +1000
In-reply-to: <ZoIvhDvzMCw28VBI@dread.disaster.area>
Message-ID: <87plrxo6i5.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0054.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 29db7317-e6ac-45d7-d4ae-08dc99a8a116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLlxJb1lVvo85rezcGTpc3hCUtIhEW+5GVosS3jRLn3OyQiKcj0IB0KBeL8P?=
 =?us-ascii?Q?HBbiLmoJpBL2LjBsuMFC7ZwlSVPdNUjngHkCc/DuEKnsF93aEufM6ViwNjiQ?=
 =?us-ascii?Q?gxPkOTQ11h9e9i1HEoPSMXleTt4IeNO/VrxZ1PIN5mfnx2lGNNOjN6sc3aLJ?=
 =?us-ascii?Q?cZxEOW4OpbcK20TaBLMoi0KKdCtMYSUwG9Nye6NE+hANzL+kGdHOmjATmCto?=
 =?us-ascii?Q?Y6NIEKiYhrlOETALl5xvI/leurEe9T9PxkYnVSkzFp5gZe/PnXO+mYjTXupI?=
 =?us-ascii?Q?cRcDZuxQosInHDLiUR5GLK6Ihhj7usG0UQR6PAXwFmdT1IYGhUm+YC+bvhNc?=
 =?us-ascii?Q?gHmLRB9oj2sRgAy0mupZwTU1mKIQ8YsYDHb8sJ64LDn5FjR+xJ9xp9oj5HPg?=
 =?us-ascii?Q?7y2NU977dXameYCFf5ckK89qUdaIXnDwYyfpI5xw0g4Y0dQgCd5pduIda2qh?=
 =?us-ascii?Q?87KKbYiFb5tbZ3F1UCdUH2J19hMVMjBw7k1uxsaFe3K4MBLiMgC0gBTsvQEe?=
 =?us-ascii?Q?F86a0IyRrBDAqgm80TxVxlx10NZX2wgdIxn+bQ4VHptvjnRb4P67H1FaVZyH?=
 =?us-ascii?Q?xnn+fKA3ECj+Hw2YXQlBdNacLsxAkivvSOBdBG6F7gB1JsPajZsqkN8kEejW?=
 =?us-ascii?Q?OSWj/kZMQ6DAl3/onhS0e+D6B3kJdPwbCKS3DGAufg4gqHYxuDysRfSMWsTr?=
 =?us-ascii?Q?to9hpnzLjv7gQABniPQzFjwR94COSMzDyhGLas2Iuqa9ytdlsmXtxGMh+yxG?=
 =?us-ascii?Q?fTGGL5G7gqW/vcJTMG986oIk9THVT/vr2E/g7SE1uT/XSbozdNwFsu7oWe+e?=
 =?us-ascii?Q?Ubcf5gBi04G4+Hmg8BBfsD0w67Ln5gA+lWUvhT+2UsJoweYctVuD83gq7Xlh?=
 =?us-ascii?Q?pV4vioT4DYH7K7r2IpWxGIBcvHrIaJXh1KsVHNeIktP+gBLWrpCiYYQqDXPv?=
 =?us-ascii?Q?Ou+lziSiNUP24xkZkwv8zLliAHBTkLrwU4gzkee7+cj2+RTcaDuuNAWQzRvd?=
 =?us-ascii?Q?gmtkOq00+QIqnvn7Jnc1iQpZm1vn0AouCvZr85l6wYrHjYyoa8nkpAsd21m3?=
 =?us-ascii?Q?VFnlOeoXktWr99FWu2F/4tfCauwmDgaGeoLB35t52j9PhwdeXiKKDoKDiKlK?=
 =?us-ascii?Q?SNQEnqI75DbHOdm0OpLO0VyyZdUtHLpP5gE3XD19+Bxad6NnPbMllYMm6yhx?=
 =?us-ascii?Q?orwhD+mic7wj4RHM8DINSdqOUG0fbzOI0iFl012VwJDV7QBrdh5siC0WttXo?=
 =?us-ascii?Q?R8gM0cojS1C2K7oDnQskZTjohHhKR1ZEiHUoSBPbMRs89wai54hg8bGrRmZT?=
 =?us-ascii?Q?rlCe2gDBasWQHi8lpgbb+uO/puXDmW4G4nWOO4IB+eJZkMz4qEt9QTKZKlLh?=
 =?us-ascii?Q?XX9O7Tk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tFQ1gux8lhIoMOxgG12dVbV3IjEixEbFCya2zDeqA7Orl+5w8POA3N6+XYp5?=
 =?us-ascii?Q?EBnm3HmGXIxDuxrXll+y4oArT5SVdky9Kd2zGnw3uBmDbpJKozGCE9y26FW7?=
 =?us-ascii?Q?ZspaICZcg6l+jpXUMtG/gYeHwPrlrvgmfa4A3MCk651rf4a1BIQl0Qckzl7Z?=
 =?us-ascii?Q?nSInxSfUo6o64b5w5sxpTpyh+mHjroZlPZW58X7PKat2Kp5ctckQoxxQldDZ?=
 =?us-ascii?Q?jXWb1R8JOn6ZFrCSUJHZhdMSM9bgwZLCIQGw7YA27qOpK9ZvAb8RSpVsZxuC?=
 =?us-ascii?Q?5vPdZkqwM3Tyt4XXOX1NvcIRmypLg0pu7dJnsgm4CqhUsMq8REIsvGzoGcDZ?=
 =?us-ascii?Q?Arz3aruv+SOI7Zw9VZFueiZVKte7QCT11JJJW9hoK5hlvg04dneQO+2IFlTQ?=
 =?us-ascii?Q?M+Jk/LO0ZsnSD2AuD/AjT4V//cPYr0RGt2cDu3vlMB3NjAu0xxN9sfH/QOdO?=
 =?us-ascii?Q?One1KqFR+yUs9Hx4airaQOI1xiEaJMTdexj9QTX/Z7ZMD7edsLFPolCWsvbh?=
 =?us-ascii?Q?orB+a/gOy9zXbFEFxh5FTmZiUhz6CK9lax9W205ZsAMP8ZYG3bCYcDMAyZdn?=
 =?us-ascii?Q?8EJ11DJVweFI9mUn8FO9iPNZWwpxwt0yQzzAvJ/ebMLXfwDwCgTQ6leJrm1M?=
 =?us-ascii?Q?a/xt5uchTAkQj9aQgKo1yIo199/ktYUJE6aY+HVkTEHHX4Jf0Lq+yZam/wZj?=
 =?us-ascii?Q?4sVeIy+KAvzpQr1oDT59ilgT42ghDINQAhB/2aSpd6dCHT2WJk4oc7fQI6Ke?=
 =?us-ascii?Q?Kc6iyj6if7RqB+Twxm+J9R3lbZdsDiGX9lQSE34X90zee+KIcUwM+oZLtyc+?=
 =?us-ascii?Q?YHXl3XqGsoClGTAKb4GYCMLt2t8mSmkHW4FOpwPMpCg8BPFAmhP06ClcrFrW?=
 =?us-ascii?Q?YboMkd0QM0oGPDNuquXnxxfyGKmeI1ma77yPI6Vg+KCYMU+D1mF8yWq3TQ+J?=
 =?us-ascii?Q?TqB6njFNO6axruAyge0UWXX6j0WIxloq+P1xlX1qj6PKW7R+fwvA1GCpOtbG?=
 =?us-ascii?Q?WLcao/idEaCQggecL7Qn1916/xUAK68a28MuET7lRLIDfOr/dlfYjzYcwgN1?=
 =?us-ascii?Q?NYm62zYMQGoGCTpE0L+Pp+b7jRNVtTDlgNTjV/dIFlfEe4KfZw/wN8rCJwW+?=
 =?us-ascii?Q?ZxeHQ2jO7uz9ZbjNL+KSxKSFNVxm9fOb9+7jVAzp+I3OAxErqULN9nnF+SYH?=
 =?us-ascii?Q?yl/RGUAM6xqvZsWDXpCg9SC4ZiE+q/qU1kws7Z6YONqgSdZhU4h7acUNd7cH?=
 =?us-ascii?Q?iYDnfKL7XlBwSKhVhsABAgtPwEfIXrLvFTHibmp19XdIEPJ+RopZ+5ltZzUn?=
 =?us-ascii?Q?lZYUfZfrBQLtzVrfRjd2+c6dj72SKWRZfiDrCfLSyeeJW9mQ8MwrOcTEsfvC?=
 =?us-ascii?Q?nhVhEFpMCHTG1Is3dPrzYGTrIzRNjDuYbiKnxOYw0eJdkFFm9QvDCg6jj3Ji?=
 =?us-ascii?Q?EcceJ2gc9EsweHEM0/WEbR48iP/s0cJV9BYRnh+CV9jhRWGRchApxQL+LhVD?=
 =?us-ascii?Q?jlhWnELEbKsB0UB4/P27LAcZie692+WLWTOc6DGb3YuO9a5OmulzjLOrA6NC?=
 =?us-ascii?Q?4bqComHfNsKOyhbEx6R64vfYMofF8FFC5tq85w0y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29db7317-e6ac-45d7-d4ae-08dc99a8a116
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:34:31.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNHem0PUDLSPzeTvb/VE3gWOqSKXF3DLTDKZ/Gzpie8bR+30UlTlRjb/XsQ8R+oyKrPvSnnD2HeTGWdx5zkKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526


Dave Chinner <david@fromorbit.com> writes:

> On Thu, Jun 27, 2024 at 10:54:15AM +1000, Alistair Popple wrote:
>> FS DAX pages have always maintained their own page reference counts
>> without following the normal rules for page reference counting. In
>> particular pages are considered free when the refcount hits one rather
>> than zero and refcounts are not added when mapping the page.
>> 
>> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
>> mechanism for allowing GUP to hold references on the page (see
>> get_dev_pagemap). However there doesn't seem to be any reason why FS
>> DAX pages need their own reference counting scheme.
>> 
>> By treating the refcounts on these pages the same way as normal pages
>> we can remove a lot of special checks. In particular pXd_trans_huge()
>> becomes the same as pXd_leaf(), although I haven't made that change
>> here. It also frees up a valuable SW define PTE bit on architectures
>> that have devmap PTE bits defined.
>> 
>> It also almost certainly allows further clean-up of the devmap managed
>> functions, but I have left that as a future improvment.
>> 
>> This is an update to the original RFC rebased onto v6.10-rc5. Unlike
>> the original RFC it passes the same number of ndctl test suite
>> (https://github.com/pmem/ndctl) tests as my current development
>> environment does without these patches.
>
> I strongly suggest running fstests on pmem devices with '-o
> dax=always' mount options to get much more comprehensive fsdax test
> coverage. That exercises a lot of the weird mmap corner cases that
> cause problems so it would be good to actually test that nothing new
> got broken in FSDAX by this patchset.

Thanks Dave, I will do that and report back. I suspect it will turn up
something, given Dan was seeing a crash with these patches.

 - Alistair

> -Dave.



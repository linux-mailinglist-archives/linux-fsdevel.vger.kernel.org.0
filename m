Return-Path: <linux-fsdevel+bounces-22701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386791B34C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CB11F22F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E24A2F;
	Fri, 28 Jun 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FK/21Njq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61F17F6;
	Fri, 28 Jun 2024 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534063; cv=fail; b=ZS56ofWpsG9UwKsbgBI1UJjzDfh3cJ7PG0LOjlf41Z3GXm9YtbkbxeRn82NzX385U6RmS9mwNhHzKpg3b6w/+8KuhlAbYu1WYvSLY/MwcZZNQ9V4y00GDrrLq098m4gAjOVmH1SlrAeaj4niCYVz0UeRzVJ5lXoAV8RW+Y9FslQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534063; c=relaxed/simple;
	bh=JKhVgXuZnGGTZfqf9V6eGsRzwsPCXaYLts89QehUpQY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=YFgshZHN0CgAwNoVTwmSzpXCES7791GrdMRn1wA5ya4CFK2E06wO9TU0L2Ea2w4SDc22tpvTJiCYUdMXIRNz4tUmDbTHVtX8IwoYEg2/ZrBbekBqghZFh8na2ef6rB/xmJH+jPqlS2op+IF3uyIK7NLqu0iYiRVO7BX0H2LCIoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FK/21Njq; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5k7E0ZYJnMun/7DvdP5HHb8pQfEGOvSAzKN5T9GGNmh3veKvT9VobvTIMl4YZSfdsPGRISxuEzwhWiiIt+mADjTM0BqkIF7jkRsrJTIxdG4wTyn6p7ehF/zIO7gHEeDIoCRJMs/HYkl+pKXm3yD4aRPiUVwKA+ZoZEhSlot1QTolxX1ei0sVuh3H0NwA5hWTbLUkD/6WpK8i/C3X1gQEot7L5FYGkNUCFPeV7vgw6PJbP7iIeUkDzpin3zNgHq+sVxMDAvlFNNRZpp12CPId7qrdXw8XMdHPhioA0TmsmEVqfonsYURcP1/UdQ1BP98ihAMGHHdTBhgi5a1nX6JCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D8pN258ZLVxKASTLXddLCuitWvqg6KDBo7AcedGpes=;
 b=R9X8E3my3l9avSTDSNdzathKSweqvQHpqF7tfYz+oMTtwjPK0Uqcc53ilvcvIdlWVjEyIbwyI3N4V1rt5Xgce4oLgtQh/xgTG3MM5zN9d0EKYZfb2Oa2eXT16UjaOQxu0fJHDEwdwI3x3emdM8viGmooFEW1gun6iGM+2AODDPCjdWmC8reIo2nvTj+Qr6oBx08kswZsV0ACrbgilsl+WT2p9oXngQ0+ipUZAvhhVD9CsA+tQYS35hyZCt86ecqX+Gs+qNtrx/YTHH9BGilBvDkzGf8HtFoqjgJ7pgz6fBHWBswfd+NWZk03vHkGEdFyX5suef+1CAUvucVR5jrCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D8pN258ZLVxKASTLXddLCuitWvqg6KDBo7AcedGpes=;
 b=FK/21Njq0wpB+s5vHF3MkPpvGKcAULPoY4DBsAw/OJ4JxsT8QdAWOlIQhNFCmKRoafiDW7HCf1zanPHXNSCkQKW4fZ3vROteP7ZpwAqRAowBP6sRNr8Im2A4GBNgJEeDZBIglAV63YOAT5amrqN10KuQdbhqFeaT1p6Dxm49JAakyA0X7iM5k8BbtpWqUE7/d9Djh0Jrb7zVITUBs72yZbvFGYyq2ElAKod0d+PyuLYCWTeG7QR/feObHRwakfGb9SoIs+cC3cGMpxvvv37u2Uu1JX5+7MHGWEsg32dueTPKO/u7ggZJ3M+HWUVJuVqlMeT7YFNIfgRZMqKFmv8CsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Fri, 28 Jun 2024 00:20:58 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:20:58 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <667d0da3572c_5be92947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <87a5j67szs.fsf@nvdebian.thelocal>
 <667dca6259bc8_57ac2946e@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 00/13] fs/dax: Fix FS DAX page reference counts
Date: Fri, 28 Jun 2024 10:06:42 +1000
In-reply-to: <667dca6259bc8_57ac2946e@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87a5j56hp6.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0017.ausprd01.prod.outlook.com (2603:10c6:10::29)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a55ce1-2d6c-4f94-ebd8-08dc97082ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQb3YROYeca27SMruaogKEscX4iC7ri3shD2JM6X3VlE7PvaDYEGCddyEDGq?=
 =?us-ascii?Q?iJ/UixCAK2GSbYE9wI7SNeQghf1DdtqjadmEJzu6qnUD3yVNomfFXoeT3yMm?=
 =?us-ascii?Q?LhkRD+9gQn3VD7dA0RRFLyaCKst2QzA2SJ2Dxcd3U0jblZo7K2HxJvuQlbDQ?=
 =?us-ascii?Q?56mIAOR/HugDJMHUEjkFxLzdhJQxPOZYQ+YjGHiPNsFpAVm7Zv4y07bss+d7?=
 =?us-ascii?Q?GsgPyjIDQy/i8EI5QZMGaBVKVlXCsO//6B5u/MbDKEeYNPvcWWPc3ijfxxw/?=
 =?us-ascii?Q?fexelLCjHh5hX9jyC4X7CQS5xzq2ma/L46E5TTjpcDTVHAVi5YYiXjpH+grF?=
 =?us-ascii?Q?sXsWHpObpYoT90shF/HXuJE0qZGkYSAjzF8s6JwD7dpez/Ec4T7Fga1mEVOq?=
 =?us-ascii?Q?H6rh2IExnnU5lLTcGowxFIT9E8YWsYZdXV1L9zczrX/Rywyr7EojNU0+ILPP?=
 =?us-ascii?Q?WagVgI6bY7uk/M+j+z/XHXOZYu33uFNqXf+BqPYAZJOwuwPBD7wzVU19XVpM?=
 =?us-ascii?Q?TLvcVYCaHnBYb2IAiH9ZP7mUx7+SCB94eTmoeW1NL5LY+GjAWl+OI31eYkEo?=
 =?us-ascii?Q?1e3KhZtSNHTvEM5yoLi9m6qQsGHfhPKEpZWTUe+ogUO7+YcopRjy2xVThPof?=
 =?us-ascii?Q?QIbxm7cjJlda9HgxoDitMF4BGNyLNmezs6jDud64zvgpovSeVRkTHv/GbOG0?=
 =?us-ascii?Q?0YaWdIDVw+PxEkLhEoRaRjVc4rAaCxInKHFu+Dvafv7CAe6uCZLcn07F2MeF?=
 =?us-ascii?Q?Q+dwL/z62C8DSZO7nviQnu7P+G8OduUJbOOigGc5FMbl6Z/xOUn1JY1UYjkX?=
 =?us-ascii?Q?0ortLZXHaOQTEtCE4vQUJVw0fF22GKHTIuEspZoQa0KSzuGe/i0pmBaXiqNt?=
 =?us-ascii?Q?fHAPjptPKfPP5593N1y/8cmB58kVrXq0F/qa33LnVt9ZiNygxRzs+ZNcAu2J?=
 =?us-ascii?Q?xkjPagjBnZvFxsDZcdi5BNUrVUPHSUxT4FuXNNvA21ZK0ySuLeAk9F1qUk4q?=
 =?us-ascii?Q?Y88RG1MyjTN2FY5eIZlAg7XiA33fFhW1yQp/eqyCwrmuO8Oozkif9Mhb0+pR?=
 =?us-ascii?Q?Jm/MOwsYew1iWynSCtn+K4PaRZb5+wVPOO/SuPB0AqpB1EohspBUgZEPz/HF?=
 =?us-ascii?Q?Ab4IGOTBf298Emxb43hqUdwc+qZZF+ulpfpueHLJX0CuGFahPlLrAS73TYqD?=
 =?us-ascii?Q?JK9XcOLBUl0tkHaKOqYFuQN09V58Db7ZN9/vmY578v5qIdlU6Il8SwuqBpbV?=
 =?us-ascii?Q?pC7xbbIu91Us1BnU9ngEWSgEbTeXRHaSYvuvT5fV3M+ligVsSTvyiw+oHmP+?=
 =?us-ascii?Q?bV6gGlrilDKfR1pBzmDsTqr60zLAyH46LkN29jwSAowM4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlUDzpDl6zXbBYLIwSzA+MaPgcq3TGVBiVyK1S40YqpgrjyrirOa/8ffV1i7?=
 =?us-ascii?Q?RlXvR+5VP7iGPoI6m9i0FkNlEToJvlhIghlHroA2U+eWZt8gPI49VuxdZrFn?=
 =?us-ascii?Q?OjWsL8+IKv70qLPXxjZrG12Hn3qtHKMyZXL+Ra5UQPrEMufXwMs4gsZOLAUT?=
 =?us-ascii?Q?KTWwtzwry5vVGfU2vkcNETfQePmm+tofl6jkICbnc+mWqbOhXIFH+uwGePRt?=
 =?us-ascii?Q?cctGDdjjOT+n6kuhlI3nlCW/RP8+YtPOjTmu08L3FuL0wiSogCT01ljYsBU6?=
 =?us-ascii?Q?4KihXay08VkfwcXlFAOQCQvTJ3eS0n4mDOIKfqC7DFlEobt5yabK9zmJ89W0?=
 =?us-ascii?Q?Mv5xsgY+iiPv/wj+oOCoRKy4QL57wt9zSpTDU4cfP4MavPgpmIW8O/Jp+mSA?=
 =?us-ascii?Q?56VXhsfz1xbhJXD8fwimw7DqAkZw5PHWw5eBpX5XbM18tzJ3y1yn8TwRCMR5?=
 =?us-ascii?Q?kcGbNYD/rgY8LOohMewgdTJ/VilcXWB8MFb2/3nP5tCNAEjp9BiNh9Ab1MAf?=
 =?us-ascii?Q?aaY97YCWsXF6kuT+dv3Qn+QymLo6lcik4nXayl4l4d1/4zY9ouGP61IiWjm9?=
 =?us-ascii?Q?y8980IE+hLAJAOM5FVUqH3a8icN884zKDCwwVcO8LKmuLPbxwpHS85IqlUZK?=
 =?us-ascii?Q?8V8KIb+8ei/1ZkVFXWJzpYh1X7NMm+UjuJsazJfMp2b1Og3JhLci7oPKueLO?=
 =?us-ascii?Q?szu+p/8mD9Stg86zbS/bLX33QDolNXUvs6P2IIgIyywGz1IGh1zngzFcUMng?=
 =?us-ascii?Q?vYtzIbg4pRzMIsggexF+k5NVC7k32x+x+ypYEFEReZGbboU5vjDwdygFzMKR?=
 =?us-ascii?Q?kHESvrE7JuBib8Z34hv8f6dFNmrp591/T1vsBVgGjUxxCq2CCS0Gnkvd75K2?=
 =?us-ascii?Q?ZZmUj+QnHJiloMp6niyGJo44z4XchGpb5xbtdEvrQLUqtDwgySgDZonLg/e3?=
 =?us-ascii?Q?h45a7nC4mcntxayNIX9F1111RY0571GWqM+ethp+aS0WitnLIWj2/Jd6s38d?=
 =?us-ascii?Q?A0U2aYUexTZc//0W/gwE/q15PX0LE8eAw41JxmDBJHyrsWg8xZeuyW6/HsEW?=
 =?us-ascii?Q?wJKXH775dMBHRO/klax5KY63pGhtoQJUL/IzXAk+GXdqTe3odc0Tigv0GZxl?=
 =?us-ascii?Q?6iHrxRe+KzDyvpaIgn5seIGgUGPj/qemnz3XTHI5Xndi7ZBwZbd0ge0MkpSr?=
 =?us-ascii?Q?oqt1rIDHFdFubj4rYid3gmi9NSoVXRbySyNA0MVcDza36dOHwuAaVJFmKRfd?=
 =?us-ascii?Q?Ai9lrN+wm8Sk+vsBuxozdLknzmJCMVTQbdF1fjqFGk1C5kv/jg1jvEIhfo0b?=
 =?us-ascii?Q?iBHSFd+tFrouNAH76kDgIR5BNtT8487nMdBnd3rvRI7xF58gLnLbu3+CtjUq?=
 =?us-ascii?Q?ZO0VMfOcFkiLmguaGHo5GM5gomhrmbYEwC1NQ0dLi4FDDz5UBWWc+JyHm9k/?=
 =?us-ascii?Q?mvyT0ovXNshBlHjGhPTwppRxAtsqkzUQrnXtui5bBHyYaAGoy/Hmlzblq8Nl?=
 =?us-ascii?Q?sQZx1MFqJQFqIpShPjpYa/TSt2JbGqR+CHRc2roZDpGMG7+FYK2IBOl5xsy8?=
 =?us-ascii?Q?2/rEpocDiYOKLd/zMBAZp2lbIDZpjKuKYa4EX1Ns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a55ce1-2d6c-4f94-ebd8-08dc97082ee0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 00:20:58.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0C/XCDJ4lCGoNMOS9y+QOYQnDdkW7EscDx1XdqOMWurdCQJh3CsyuYTm9K6IYA7G7J3ZxS4RhNpAHRgYuiRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
>> 
>> Dan Williams <dan.j.williams@intel.com> writes:
>> 
>> > Alistair Popple wrote:
>> >> FS DAX pages have always maintained their own page reference counts
>> >> without following the normal rules for page reference counting. In
>> >> particular pages are considered free when the refcount hits one rather
>> >> than zero and refcounts are not added when mapping the page.
>> >> 
>> >> Tracking this requires special PTE bits (PTE_DEVMAP) and a secondary
>> >> mechanism for allowing GUP to hold references on the page (see
>> >> get_dev_pagemap). However there doesn't seem to be any reason why FS
>> >> DAX pages need their own reference counting scheme.
>> >> 
>> >> By treating the refcounts on these pages the same way as normal pages
>> >> we can remove a lot of special checks. In particular pXd_trans_huge()
>> >> becomes the same as pXd_leaf(), although I haven't made that change
>> >> here. It also frees up a valuable SW define PTE bit on architectures
>> >> that have devmap PTE bits defined.
>> >> 
>> >> It also almost certainly allows further clean-up of the devmap managed
>> >> functions, but I have left that as a future improvment.
>> >> 
>> >> This is an update to the original RFC rebased onto v6.10-rc5. Unlike
>> >> the original RFC it passes the same number of ndctl test suite
>> >> (https://github.com/pmem/ndctl) tests as my current development
>> >> environment does without these patches.
>> >
>> > Are you seeing the 'mmap.sh' test fail even without these patches?
>> 
>> No. But I also don't see it failing with these patches :)
>> 
>> For reference this is what I see on my test machine with or without:
>> 
>> [1/70] Generating version.h with a custom command
>>  1/13 ndctl:dax / daxdev-errors.sh          SKIP             0.06s   exit status 77
>>  2/13 ndctl:dax / multi-dax.sh              SKIP             0.05s   exit status 77
>>  3/13 ndctl:dax / sub-section.sh            SKIP             0.14s   exit status 77
>
> I really need to get this test built as a service as this shows a
> pre-req is missing, and it's not quite fair to expect submitters to put
> it all together.

Ok. I didn't dig into why this was being skipped but I might if I find
some time. The rest of the tests seemed more relevant anyway and turned
up enough bugs with my initial implementation to keep me busy which gave
me some confidence.

If I'm being honest though I found the whole test setup a bit of a
pain. In particular remembering you have to manually (re)build the
special test versions of the modules tripped me up a few times until I
updated my build scripts. But I got there in the end.

>>  4/13 ndctl:dax / dax-dev                   OK               0.02s
>>  5/13 ndctl:dax / dax-ext4.sh               OK              12.97s
>>  6/13 ndctl:dax / dax-xfs.sh                OK              12.44s
>>  7/13 ndctl:dax / device-dax                OK              13.40s
>>  8/13 ndctl:dax / revoke-devmem             FAIL             0.31s   (exit status 250 or signal 122 SIGinvalid)
>> >>> TEST_PATH=/home/apopple/ndctl/build/test LD_LIBRARY_PATH=/home/apopple/ndctl/build/cxl/lib:/home/apopple/ndctl/build/daxctl/lib:/home/apopple/ndctl/build/ndctl/lib NDCTL=/home/apopple/ndctl/build/ndctl/ndctl MALLOC_PERTURB_=227 DATA_PATH=/home/apopple/ndctl/test DAXCTL=/home/apopple/ndctl/build/daxctl/daxctl /home/apopple/ndctl/build/test/revoke_devmem
>> 
>>  9/13 ndctl:dax / device-dax-fio.sh         OK              32.43s
>> 10/13 ndctl:dax / daxctl-devices.sh         SKIP             0.07s   exit status 77
>> 11/13 ndctl:dax / daxctl-create.sh          SKIP             0.04s   exit status 77
>> 12/13 ndctl:dax / dm.sh                     FAIL             0.08s   exit status 1
>> >>> MALLOC_PERTURB_=209 TEST_PATH=/home/apopple/ndctl/build/test LD_LIBRARY_PATH=/home/apopple/ndctl/build/cxl/lib:/home/apopple/ndctl/build/daxctl/lib:/home/apopple/ndctl/build/ndctl/lib NDCTL=/home/apopple/ndctl/build/ndctl/ndctl DATA_PATH=/home/apopple/ndctl/test DAXCTL=/home/apopple/ndctl/build/daxctl/daxctl /home/apopple/ndctl/test/dm.sh
>> 
>> 13/13 ndctl:dax / mmap.sh                   OK             107.57s
>
> I need to think through why this one might false succeed, but that can
> wait until we get this series reviewed. For now my failure is stable
> which allows it to be bisected.
>
>> 
>> Ok:                 6   
>> Expected Fail:      0   
>> Fail:               2   
>> Unexpected Pass:    0   
>> Skipped:            5   
>> Timeout:            0   
>> 
>> I have been using QEMU for my testing. Maybe I missed some condition in
>> the unmap path though so will take another look.
>
> I was able to bisect to:

I could have guessed that one, as it's pretty much the crux of this
series given it's the one that switches everything away from
pXX_devmap. That means pXX_leaf/_trans_huge will start returning true
for DAX pages.

Based on your dump I'm guessing I missed some case in the
zap_pXX_range() path. It could be helpful to narrow down which of the
pXX paths is crashing but I will take another look there.

> [PATCH 10/13] fs/dax: Properly refcount fs dax pages
>
> ...I will prioritize that one in my review queue.

Thanks!


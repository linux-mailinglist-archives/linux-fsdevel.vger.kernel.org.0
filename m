Return-Path: <linux-fsdevel+bounces-22924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D6923BBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631561C23F8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F721591E3;
	Tue,  2 Jul 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ktG4s4Cv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED051004;
	Tue,  2 Jul 2024 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719917230; cv=fail; b=VAXEcViXhHR8lvuIEz1ytVIiMW5JG/cYa5yIHwEWovoqRAs4004dbL9PKGg7v03xhHQ2SVP25XuwFMr8NdWCfO6Hdrk1PScgX10Zeym5l534fR89QT7xHGv1+gIj6jzkGaTdjkLYt4TcMDuHD0nZkUllh5hk9DNjM1wkW/EarwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719917230; c=relaxed/simple;
	bh=1toHsHugJov8E7PSsKofP9xBwP6IO+NqvI72wtTXdnk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=YWixZcHnL35IM/hK3CCSlEFBQdUNjDgbtTP4sYenTiqdd11geOrYRcQTIwlpuTYPimG+QZcpq+jnC2wWwm3eIoGMBjD3TZsKqcw7ZfSlVo2u+AiR6YHm5d7u+r5ZIujj8uL0z4L9I3VTzOvVqmTKv+3x/A9amNED1ca5j48IuGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ktG4s4Cv; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U78v6NMSsVdUqla+4JgIOz31RNBRGbMKhFV2/TdE8Yo7k+/bFusBA4Sqp6n8Rx9bgLUuSVtmi1FXuTo2bEzqxX8DsDx1K/Q9HbRK+xcqW8tR+LFlbRJUzEOVelu4qwfboetQ43nYn6Zs0k3y1daHk0imQtirMxSC3nx4d6ECTCJSvS6oJIIKYLd+Dv0sNDULnOBamxJ5BVTdZ8vT+9z3gBs6TETs488iubuSvXZZiwG4YJWGhqQsIV0it5dNX0swNWZzYqj2VhC4/3CkN9YeTuHhCRcFp3WmM2iHdflhcW2M3Hie/qv7nBR+NCZutZ+ixgXpTJ8vVBQGU78DbORBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r78TL6rhPDv1kHZSsCB4MXkiLg86bLdtlQW/a8+nHGM=;
 b=jWCOOoM/EnXK8u+l1QTcqElEx2JeNTOo0P5S0ZtfTIiItN8rqK9coxit6RqOoYsQMS4jGnwrqjPMu3Q5HhesRwuRq4yu/lpr8ojJSJ40+KOlxfQf+JeIjphx70V/7eT4aR+GvfzktjgtN7HUOFLaMZIZpCx6kC0J1ipogsN/mYZTwZES+OPZmNK9FMd2TBGxsCLfnOabCxTn0RDM9ThXySFcv5Mv/Au/efbc+OQv58V/9zmOlR4p2+4DOKjhXBkMZ1BhUfIiCITrpwt8rF31V7belzYJk1tmxA/ZinLmKo9w6kVxWj6P3EKCBRlQfU9lgezSfb/iSxT5gq7fHYhJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r78TL6rhPDv1kHZSsCB4MXkiLg86bLdtlQW/a8+nHGM=;
 b=ktG4s4Cv+Xa6T1a7LxUuCa4di9tyfSU9DGa0XRVgNdpsKbiiJ53RKrgIiB8ktMjTLkJ+NzPezjPvFl978WlSTxdvt06nRNALgUHE/12yw6ILajjsPscZcTSGjuZ+sser6EVXMqoBRZtcJzJKMzuwHH35JLXkPDypqp3ohi/TTIulCOhodCivs7wulw1JMrz4xY+GlPosywQ7v7iSsy1m8SkPC6dh+vBhqpmkBSyAOmcH1uGQ9rDhmRzT9wDlR/+82EUUEst8vo1ijP0PkOCtv2n4MOz0X+5W7uf9IksqO7q+qjxHGbVMip7Nz7VzwBAUPR+c/8pUZ5+q6dkkVg1JOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Tue, 2 Jul 2024 10:47:04 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 10:47:04 +0000
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <bd332b0d3971b03152b3541f97470817c5147b51.1719386613.git-series.apopple@nvidia.com>
 <cf572c69-a754-4d41-b9c4-7a079b25b3c3@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
 tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 07/13] huge_memory: Allow mappings of PUD sized pages
Date: Tue, 02 Jul 2024 20:19:01 +1000
In-reply-to: <cf572c69-a754-4d41-b9c4-7a079b25b3c3@redhat.com>
Message-ID: <874j98gjfg.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0035.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fd::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: d50a1815-aa95-4682-e14c-08dc9a844fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BqyA+dYtXuPt9ha+JGFWtkiPuAxJnp9zRE1F+eWuHwJH5nKzYWIpsB1eGVjH?=
 =?us-ascii?Q?g10t27hRd9vlPfP+hsekhoLVameAyn8ID1XA8Q08CQbsr+O4d6Z6N1iVkDuW?=
 =?us-ascii?Q?PHOVooqRJUYIQk34ESfviTWHad2wb/Ty0Ap/p0GV73ykmE8Tr13aN0+hgE2H?=
 =?us-ascii?Q?eDBlhOtbCCdq7vgzikiuuJQ2vJIrF39S/3xBm7xK/y6QCVarV0p8608D5C80?=
 =?us-ascii?Q?6ueuXhKBZ4x4Z2uOmdIIgwYLTN1QzeOsGTn8E4TEQSRqTPUhmc20PDIk56hG?=
 =?us-ascii?Q?iqJHddLJvjRVTt738Fixa2F2w6I8CHLMuZ+28kkWgLgpC79uE+MpP9SlaGSg?=
 =?us-ascii?Q?3M+DONSoPOUP1o9Kl4+xSB/1lo8RMLZp+ONFvYis3a5Mz8G7SR2rukvJTlK4?=
 =?us-ascii?Q?jNMop9TMPRmUhQTS3MZ+0vs0vKCA/ksh5LGSwcW/jD0S0slJsOt4QkP1mxEY?=
 =?us-ascii?Q?vkWz3yAv/dmfmoGslqICBAfdQ96UD1Ab3UqP3SNGYMjWSFMe9w80HLq9P9UZ?=
 =?us-ascii?Q?SIDDC3pUSoOBPmLoOAoEnvSDN+N012TjXx5rsH/A1FWWMY9lkH+sR6AAPx+T?=
 =?us-ascii?Q?nUyhO3c9g2+rl9X2MX/mjfB8kQv61NEMVbqNm65nFtjcwUkue3W7pKRXqXy9?=
 =?us-ascii?Q?teT7IKsnpzWW88Ill1cdBqeood0fGMnRu4S5LGFssqeiyMjQj+17tjM6C6iM?=
 =?us-ascii?Q?mOuDtkW60TQYnLClxW5VQz5oDwS2AKL6VDavMHX6uHdBX0NGb+R5WWmZXuuP?=
 =?us-ascii?Q?RBeqDgdvDb3WeIz8cwXOjhjYvS+k2WBuepKNLY3r93FIjELzSHzB8+icXiV0?=
 =?us-ascii?Q?ZGFYhzDl1OF1zb7Dg9ChSHDb251fuem8nnLJsYxybcQ66MSUjyKKoa92EhLF?=
 =?us-ascii?Q?mH7PUFhKeA9nL3bs6AmOa0rrS8KWBt9KHEoNc2GuryFoz88k14zHT6IXWErg?=
 =?us-ascii?Q?/nA/cfPKkjumBUT1ijyaixWTSUUNjO6Doey5QIMoT6efKHRMCqZ5T4SUnv2L?=
 =?us-ascii?Q?d3xQJfZ9MW+9x/f37yfy870ejeqlFR+Ngl8ijlg9PYT8QQvpe0Dsyy7CITVc?=
 =?us-ascii?Q?05GS228przl+WpDj6tohfdQRJ46U35z2Ea463OHW98wFwYl5u9t8NN9P8uxz?=
 =?us-ascii?Q?BqDUeI8u7nldlBvEB+X5PqUG7EHh6XSy3x9JXQgS1tzEn/nZwJRJjNK4/Npt?=
 =?us-ascii?Q?lR9J99zUCsfHc8AMCLdTTi7kUL2t9wfnTaFtwTqoS3m8G+JC1FGUYR50ynpo?=
 =?us-ascii?Q?vnCSwfDOmCpUNjxEbTjjQukrmRvCA9nD44+Malr6hwer1aYoVufmTaQR1zGc?=
 =?us-ascii?Q?LmG7B79WIGFnJKJoAcWuUPQ5NxveQehRyXIbw0csEY1Wlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F247Tt8D5i3UmXdVaqozi7Zd5TxB4yKxis4rZFCBxP+c5HZGFeikvSKyLjcJ?=
 =?us-ascii?Q?uChBLpmi7PYxX+c9Raau02/yrL7htIdv4jjwFMZDm5FYWpRtpbNspNqLG+10?=
 =?us-ascii?Q?ANI4JJA83/tXLYX1bU2F1gKdCI1ABdzzb05PPuSSjCba2pEAJsbjA7Y+GFa3?=
 =?us-ascii?Q?Vv6YtpL+lD/U/1oTJZzf/XIGa2E+EEiaJ5pQyPyQ153+8t9/JBRpChDoUGju?=
 =?us-ascii?Q?x7uoNl2j6xil7DgZsTvgJG6u/Acku3X2uRppwz5UXhGP9iMLa5Nh995eIvZo?=
 =?us-ascii?Q?Nvnbs6R3qU7YKPPnqgrMCMavRyJ8XqGpFBe/XhR7IdyhOztas1pJ2LbuWgS4?=
 =?us-ascii?Q?AgdN6Jy32XdGR7mMigMppc7CKo+oVEWdRAjyL94PkaTxpunzwhM0JJpI6CE9?=
 =?us-ascii?Q?GUJ5Ue3E6+bba4BE+5LfvxYVMnLcAu3kw4NYFwLIzyXPaPJfS242YKZklD+b?=
 =?us-ascii?Q?EzarXpeqBJNQGMiVPqqtWiJfyJ7QPeXIxlZKUcfcfLA9sM65goez0R0NQLAe?=
 =?us-ascii?Q?8jYc7xnbIJPS+1kh8P23MvbtXLsa6tyMViPKE2AriY8QxLF0K7FsgKrYI5Xo?=
 =?us-ascii?Q?fHyppbFxd2qtREx16dnThocEZKQwi3fuvgi44HlIyCIuoLQvjVqYmklgqB4f?=
 =?us-ascii?Q?9KUZlBZpLI8M5AzEgwOXvXDomUB1aalHHaIVhRhNcoey7oAhYiWpj4/TsCwZ?=
 =?us-ascii?Q?xGACq69eKeodyPmTCAQQU/25d7HLzZ82sU7nGswK/NgPIxtx5u0tYshM2CCP?=
 =?us-ascii?Q?gwunoTEB4oQ6iJkaV5nT1NLW9DyTCT/Mjx7dIS9TiUf/blNKJ0f1wtpuYGIM?=
 =?us-ascii?Q?yxmICzhOfofBmq+guGB8ayEw8KA+7DKqPt+aghYlKhSrUujBLkPryTLYEKmS?=
 =?us-ascii?Q?me7l+D9P5nLjXht9VeuqzQFwCDHfCTeNcyUYpWg1i8kqWa2XAg8jncWYOFPh?=
 =?us-ascii?Q?0dQsoKCR+Lm88cADrlhEPjPeN5STkg0m1384GHUIg2RTvuzGmyYsBku9PbJe?=
 =?us-ascii?Q?vkdf+TJv9PYb7k4VmNdgmXSZyZAyxtJ76UnHjulsCSPCX4DvFT0an8claco7?=
 =?us-ascii?Q?qHCwyU3Wj6E6PA3g1Duz5bEQE0dGBX0cDRRf45P6OEYF+fOphFlxaj52LzjI?=
 =?us-ascii?Q?Pvj7S/KziO/htFV0hlG1p+0XGGsPr0REFB8zqlOohNtgo+57cNKc+7HVIRba?=
 =?us-ascii?Q?ZGijRNTpfoMgrdHM7Od3VO07jQxAmwlFh9r8poKWiGOEkt/Tbp1cJCbXW0f2?=
 =?us-ascii?Q?BPrgdNRiCfY7SRA1k2gWFBWYwW1mDFTAIU86BFqbLx8wph/sh0LDQBJp0G4l?=
 =?us-ascii?Q?e5CaDsA0EgWnQXW7JV+6VqZM2LQUW66VlN42EiNCYjBvbrjb3N1vZyZoELCK?=
 =?us-ascii?Q?pjwGydt+KDsTxcmXNyhMHci7w+BA5sJVhqpHhIFkZdQVvsekyELkognE0WUN?=
 =?us-ascii?Q?7lNj40xjTYrYc3wbQmimlSl35Ixpg48tkyPSdbkF2k/sFwLxmpFiY2U583AV?=
 =?us-ascii?Q?X9HEsGej9QxBWhNurcWwSzHXnHtqCiT6IQeb+eKIREqBfOX5jcmtn8BTDrw2?=
 =?us-ascii?Q?KTeW+dl1atQ1Pcb/lJ936Sa+1zKpFVrjjWw4Qy/x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50a1815-aa95-4682-e14c-08dc9a844fc1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 10:47:04.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSYLxBQ6gjU+uLqrx4kUn0uIGofKT38Wezv9SBop6vLDf3uTgYDE3TTG2n/ERIS/q4GnDEfYl6MWHR9Fsq3cDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063


David Hildenbrand <david@redhat.com> writes:

> On 27.06.24 02:54, Alistair Popple wrote:
>> Currently DAX folio/page reference counts are managed differently to
>> normal pages. To allow these to be managed the same as normal pages
>> introduce dax_insert_pfn_pud. This will map the entire PUD-sized folio
>> and take references as it would for a normally mapped page.
>> This is distinct from the current mechanism, vmf_insert_pfn_pud,
>> which
>> simply inserts a special devmap PUD entry into the page table without
>> holding a reference to the page for the mapping.
>
> Do we really have to involve mapcounts/rmap for daxfs pages at this
> point? Or is this only "to make it look more like other pages" ?

The aim of the series is make FS DAX and other ZONE_DEVICE pages look
like other pages, at least with regards to the way they are refcounted.

At the moment they are not refcounted - instead their refcounts are
basically statically initialised to one and there are all these special
cases and functions requiring magic PTE bits (pXX_devmap) to do the
special DAX reference counting. This then adds some cruft to manage
pgmap references and to catch the 2->1 page refcount transition. All
this just goes away if we manage the page references the same as other
pages (and indeed we already manage DEVICE_PRIVATE and COHERENT pages
the same as normal pages).

So I think to make this work we at least need the mapcounts.

> I'm asking this because:
>
> (A) We don't support mixing PUD+PMD mappings yet. I have plans to change
>     that in the future, but for now you can only map using a single PUD
>     or by PTEs. I suspect that's good enoug for now for dax fs?

Yep, that's all we support.

> (B) As long as we have subpage mapcounts, this prevents vmemmap
>     optimizations [1]. Is that only used for device-dax for now and are
>     there no plans to make use of that for fs-dax?

I don't have any plans to. This is purely focussed on refcounting pages
"like normal" so we can get rid of all the DAX special casing.

> (C) We managed without so far :)

Indeed, although Christoph has asked repeatedly ([1], [2] and likely
others) that this gets fixed and I finally got sick of it coming up
everytime I need to touch something with ZONE_DEVICE pages :)

Also it removes the need for people to understand the special DAX page
recounting scheme and ends up removing a bunch of cruft as a bonus:

 59 files changed, 485 insertions(+), 869 deletions(-)

And that's before I clean up all the pgmap reference handling. It also
removes the pXX_trans_huge and pXX_leaf distinction. So we managed, but
things could be better IMHO.

> Having that said, with folio->_large_mapcount things like
> folio_mapcount() are no longer terribly slow once we weould PTE-map a
> PUD-sized folio.
>
> Also, all ZONE_DEVICE pages should currently be marked PG_reserved,
> translating to "don't touch the memmap". I think we might want to
> tackle that first.

Ok. I'm keen to get this series finished and I don't quite get the
connection here, what needs to change there?

[1] - https://lore.kernel.org/linux-mm/20201106080322.GE31341@lst.de/
[2] - https://lore.kernel.org/linux-mm/20220209135351.GA20631@lst.de/

>
> [1] https://lwn.net/Articles/860218/
> [2]
> https://lkml.kernel.org/r/b0adbb0c-ad59-4bc5-ba0b-0af464b94557@redhat.com
>
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>>   include/linux/huge_mm.h |   4 ++-
>>   include/linux/rmap.h    |  14 +++++-
>>   mm/huge_memory.c        | 108 ++++++++++++++++++++++++++++++++++++++---
>>   mm/rmap.c               |  48 ++++++++++++++++++-
>>   4 files changed, 168 insertions(+), 6 deletions(-)
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 2aa986a..b98a3cc 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -39,6 +39,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>     vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn,
>> bool write);
>>   vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>> +vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
>>     enum transparent_hugepage_flag {
>>   	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
>> @@ -106,6 +107,9 @@ extern struct kobj_attribute shmem_enabled_attr;
>>   #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
>>   #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>>   +#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
>> +#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
>> +
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>     extern unsigned long transparent_hugepage_flags;
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 7229b9b..c5a0205 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -192,6 +192,7 @@ typedef int __bitwise rmap_t;
>>   enum rmap_level {
>>   	RMAP_LEVEL_PTE = 0,
>>   	RMAP_LEVEL_PMD,
>> +	RMAP_LEVEL_PUD,
>>   };
>>     static inline void __folio_rmap_sanity_checks(struct folio
>> *folio,
>> @@ -225,6 +226,13 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
>>   		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PMD_NR, folio);
>>   		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PMD_NR, folio);
>>   		break;
>> +	case RMAP_LEVEL_PUD:
>> +		/*
>> +		 * Asume that we are creating * a single "entire" mapping of the folio.
>> +		 */
>> +		VM_WARN_ON_FOLIO(folio_nr_pages(folio) != HPAGE_PUD_NR, folio);
>> +		VM_WARN_ON_FOLIO(nr_pages != HPAGE_PUD_NR, folio);
>> +		break;
>>   	default:
>>   		VM_WARN_ON_ONCE(true);
>>   	}
>> @@ -248,12 +256,16 @@ void folio_add_file_rmap_ptes(struct folio *, struct page *, int nr_pages,
>>   	folio_add_file_rmap_ptes(folio, page, 1, vma)
>>   void folio_add_file_rmap_pmd(struct folio *, struct page *,
>>   		struct vm_area_struct *);
>> +void folio_add_file_rmap_pud(struct folio *, struct page *,
>> +		struct vm_area_struct *);
>>   void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>>   		struct vm_area_struct *);
>>   #define folio_remove_rmap_pte(folio, page, vma) \
>>   	folio_remove_rmap_ptes(folio, page, 1, vma)
>>   void folio_remove_rmap_pmd(struct folio *, struct page *,
>>   		struct vm_area_struct *);
>> +void folio_remove_rmap_pud(struct folio *, struct page *,
>> +		struct vm_area_struct *);
>>     void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct
>> *,
>>   		unsigned long address, rmap_t flags);
>> @@ -338,6 +350,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
>>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>>   		break;
>>   	case RMAP_LEVEL_PMD:
>> +	case RMAP_LEVEL_PUD:
>>   		atomic_inc(&folio->_entire_mapcount);
>>   		atomic_inc(&folio->_large_mapcount);
>>   		break;
>> @@ -434,6 +447,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
>>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>>   		break;
>>   	case RMAP_LEVEL_PMD:
>> +	case RMAP_LEVEL_PUD:
>>   		if (PageAnonExclusive(page)) {
>>   			if (unlikely(maybe_pinned))
>>   				return -EBUSY;
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index db7946a..e1f053e 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1283,6 +1283,70 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
>>   	return VM_FAULT_NOPAGE;
>>   }
>>   EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
>> +
>> +/**
>> + * dax_insert_pfn_pud - insert a pud size pfn backed by a normal page
>> + * @vmf: Structure describing the fault
>> + * @pfn: pfn of the page to insert
>> + * @write: whether it's a write fault
>> + *
>> + * Return: vm_fault_t value.
>> + */
>> +vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	unsigned long addr = vmf->address & PUD_MASK;
>> +	pud_t *pud = vmf->pud;
>> +	pgprot_t prot = vma->vm_page_prot;
>> +	struct mm_struct *mm = vma->vm_mm;
>> +	pud_t entry;
>> +	spinlock_t *ptl;
>> +	struct folio *folio;
>> +	struct page *page;
>> +
>> +	if (addr < vma->vm_start || addr >= vma->vm_end)
>> +		return VM_FAULT_SIGBUS;
>> +
>> +	track_pfn_insert(vma, &prot, pfn);
>> +
>> +	ptl = pud_lock(mm, pud);
>> +	if (!pud_none(*pud)) {
>> +		if (write) {
>> +			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
>> +				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
>> +				goto out_unlock;
>> +			}
>> +			entry = pud_mkyoung(*pud);
>> +			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
>> +			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
>> +				update_mmu_cache_pud(vma, addr, pud);
>> +		}
>> +		goto out_unlock;
>> +	}
>> +
>> +	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
>> +	if (pfn_t_devmap(pfn))
>> +		entry = pud_mkdevmap(entry);
>> +	if (write) {
>> +		entry = pud_mkyoung(pud_mkdirty(entry));
>> +		entry = maybe_pud_mkwrite(entry, vma);
>> +	}
>> +
>> +	page = pfn_t_to_page(pfn);
>> +	folio = page_folio(page);
>> +	folio_get(folio);
>> +	folio_add_file_rmap_pud(folio, page, vma);
>> +	add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
>> +
>> +	set_pud_at(mm, addr, pud, entry);
>> +	update_mmu_cache_pud(vma, addr, pud);
>> +
>> +out_unlock:
>> +	spin_unlock(ptl);
>> +
>> +	return VM_FAULT_NOPAGE;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_insert_pfn_pud);
>>   #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>     void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>> @@ -1836,7 +1900,8 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>   			zap_deposited_table(tlb->mm, pmd);
>>   		spin_unlock(ptl);
>>   	} else if (is_huge_zero_pmd(orig_pmd)) {
>> -		zap_deposited_table(tlb->mm, pmd);
>> +		if (!vma_is_dax(vma) || arch_needs_pgtable_deposit())
>> +			zap_deposited_table(tlb->mm, pmd);
>>   		spin_unlock(ptl);
>>   	} else {
>>   		struct folio *folio = NULL;
>> @@ -2268,20 +2333,34 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
>>   int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>   		 pud_t *pud, unsigned long addr)
>>   {
>> +	pud_t orig_pud;
>>   	spinlock_t *ptl;
>>     	ptl = __pud_trans_huge_lock(pud, vma);
>>   	if (!ptl)
>>   		return 0;
>>   -	pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
>> +	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
>>   	tlb_remove_pud_tlb_entry(tlb, pud, addr);
>> -	if (vma_is_special_huge(vma)) {
>> +	if (!vma_is_dax(vma) && vma_is_special_huge(vma)) {
>>   		spin_unlock(ptl);
>>   		/* No zero page support yet */
>>   	} else {
>> -		/* No support for anonymous PUD pages yet */
>> -		BUG();
>> +		struct page *page = NULL;
>> +		struct folio *folio;
>> +
>> +		/* No support for anonymous PUD pages or migration yet */
>> +		BUG_ON(vma_is_anonymous(vma) || !pud_present(orig_pud));
>> +
>> +		page = pud_page(orig_pud);
>> +		folio = page_folio(page);
>> +		folio_remove_rmap_pud(folio, page, vma);
>> +		VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
>> +		VM_BUG_ON_PAGE(!PageHead(page), page);
>> +		add_mm_counter(tlb->mm, mm_counter_file(folio), -HPAGE_PUD_NR);
>> +
>> +		spin_unlock(ptl);
>> +		tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE);
>>   	}
>>   	return 1;
>>   }
>> @@ -2289,6 +2368,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>   static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>>   		unsigned long haddr)
>>   {
>> +	pud_t old_pud;
>> +
>>   	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
>>   	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>>   	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
>> @@ -2296,7 +2377,22 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>>     	count_vm_event(THP_SPLIT_PUD);
>>   -	pudp_huge_clear_flush(vma, haddr, pud);
>> +	old_pud = pudp_huge_clear_flush(vma, haddr, pud);
>> +	if (is_huge_zero_pud(old_pud))
>> +		return;
>> +
>> +	if (vma_is_dax(vma)) {
>> +		struct page *page = pud_page(old_pud);
>> +		struct folio *folio = page_folio(page);
>> +
>> +		if (!folio_test_dirty(folio) && pud_dirty(old_pud))
>> +			folio_mark_dirty(folio);
>> +		if (!folio_test_referenced(folio) && pud_young(old_pud))
>> +			folio_set_referenced(folio);
>> +		folio_remove_rmap_pud(folio, page, vma);
>> +		folio_put(folio);
>> +		add_mm_counter(vma->vm_mm, mm_counter_file(folio), -HPAGE_PUD_NR);
>> +	}
>>   }
>>     void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index e8fc5ec..e949e4f 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1165,6 +1165,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
>>   		atomic_add(orig_nr_pages, &folio->_large_mapcount);
>>   		break;
>>   	case RMAP_LEVEL_PMD:
>> +	case RMAP_LEVEL_PUD:
>>   		first = atomic_inc_and_test(&folio->_entire_mapcount);
>>   		if (first) {
>>   			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
>> @@ -1306,6 +1307,12 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>>   		case RMAP_LEVEL_PMD:
>>   			SetPageAnonExclusive(page);
>>   			break;
>> +		case RMAP_LEVEL_PUD:
>> +			/*
>> +			 * Keep the compiler happy, we don't support anonymous PUD mappings.
>> +			 */
>> +			WARN_ON_ONCE(1);
>> +			break;
>>   		}
>>   	}
>>   	for (i = 0; i < nr_pages; i++) {
>> @@ -1489,6 +1496,26 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>>   #endif
>>   }
>>   +/**
>> + * folio_add_file_rmap_pud - add a PUD mapping to a page range of a folio
>> + * @folio:	The folio to add the mapping to
>> + * @page:	The first page to add
>> + * @vma:	The vm area in which the mapping is added
>> + *
>> + * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
>> + *
>> + * The caller needs to hold the page table lock.
>> + */
>> +void folio_add_file_rmap_pud(struct folio *folio, struct page *page,
>> +		struct vm_area_struct *vma)
>> +{
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> +	__folio_add_file_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
>> +#else
>> +	WARN_ON_ONCE(true);
>> +#endif
>> +}
>> +
>>   static __always_inline void __folio_remove_rmap(struct folio *folio,
>>   		struct page *page, int nr_pages, struct vm_area_struct *vma,
>>   		enum rmap_level level)
>> @@ -1521,6 +1548,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>   		partially_mapped = nr && atomic_read(mapped);
>>   		break;
>>   	case RMAP_LEVEL_PMD:
>> +	case RMAP_LEVEL_PUD:
>>   		atomic_dec(&folio->_large_mapcount);
>>   		last = atomic_add_negative(-1, &folio->_entire_mapcount);
>>   		if (last) {
>> @@ -1615,6 +1643,26 @@ void folio_remove_rmap_pmd(struct folio *folio, struct page *page,
>>   #endif
>>   }
>>   +/**
>> + * folio_remove_rmap_pud - remove a PUD mapping from a page range of a folio
>> + * @folio:	The folio to remove the mapping from
>> + * @page:	The first page to remove
>> + * @vma:	The vm area from which the mapping is removed
>> + *
>> + * The page range of the folio is defined by [page, page + HPAGE_PUD_NR)
>> + *
>> + * The caller needs to hold the page table lock.
>> + */
>> +void folio_remove_rmap_pud(struct folio *folio, struct page *page,
>> +		struct vm_area_struct *vma)
>> +{
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> +	__folio_remove_rmap(folio, page, HPAGE_PUD_NR, vma, RMAP_LEVEL_PUD);
>> +#else
>> +	WARN_ON_ONCE(true);
>> +#endif
>> +}
>> +
>>   /*
>>    * @arg: enum ttu_flags will be passed to this argument
>>    */



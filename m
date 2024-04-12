Return-Path: <linux-fsdevel+bounces-16757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EFB8A234B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1328B222EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00515C96;
	Fri, 12 Apr 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+28cKG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8B33E1;
	Fri, 12 Apr 2024 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885789; cv=fail; b=ua9bcGXmZkJq4+0waI4geEk04hoNgr4vxdEuBK1G7znO4u9yjW+zZUWHf3rig7KrEfNErga3aAD1rWHvw9cxT54H2KBM8MifMqmVPcEHWWvitIo37c3KuqLU27q+XNW7wmGHwdntVp7g1Yo7C/qvhFzdkQFgf85MfZie7X/4NwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885789; c=relaxed/simple;
	bh=7L1gEjY33BMy1U80OmaWIID7Jiaud48obFFkVz7G0Ms=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=YyijVk0wQ1PsN0VKL+BDsmS+MgsQAryKqTKVdTtap8QN33bFvUmOyhy2jGHySdv0p2qnMQj6QOr+JFEBcLU6RepF9xZ0VX2icxvdEcTGCom0oU83QQ49GyK7p/AVXjmvpGyHaNkfEVKnsmSduTwwsbfk9HuBY1mGVegmqfqlDtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+28cKG6; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPecBQQG2/AySmILIj5L7KCcgYITEZGakxgHPq2omdcK+YyMHWI3no2/9PLbBVeU6F9CrhYuiYjxs+HbbXwyVEBnEWgaKGpE97Y9sNoSu5utB5Alpum8ExbP0F+2cUD6laWSBvMxFMd628gwJbom4W9KY95/8LNcm9AtsUNSaRnxfl6GjDTJqb4WIYkED92jroxAeqTZoDaafSdXIaQr9ILLrnfBk9vsG57SuP971YkxTHoft3oixWT/SapR7lEkfeHNeRHaB+k7zq5JUxSvp9i3Iq3vl92l7vmdPRmaHCvniAUz9sVhcvvgJagmQGesTKZ2UFe4cD99zA4fLInLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L1gEjY33BMy1U80OmaWIID7Jiaud48obFFkVz7G0Ms=;
 b=DfY8XvP0SgNF6WEr+13qDEBs6M41cD8O6CmXaIowrKr32pId9g+QrssIvCTWVcWNcciSVyj2w9W0sbJugmqJy6WbMAnDIieqNWzvNl9KVIktmNCJ5kFRUIP7hEieLsOTBTuZF5YZn8qdJs7HugmDxf0JtQ9oBlNP6nx12D2Sff0Hw54lefcW3H52viNtjC3uHpkFHq9Rj846/w+zeJhW0xz4OfoKA7HQKzc9q/JHh8cwyEJR7DrJS3ILG2C1Z2HZxvI6yNvzRKMa4TD69YgcmSd20ruJO0nfmoaMjbkMDQKYf7xhAqO4sui+AVXI8bDEfC+Bqluv5uD0bZMqZNwfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L1gEjY33BMy1U80OmaWIID7Jiaud48obFFkVz7G0Ms=;
 b=I+28cKG6h8AdLGayY7Z+5RmhZF9M7APU8Vk7/mYs4JxbDTDsJZNlL6Dw2BHShTpA7Jtxz3Dlod/DekEY4NeoQNbQz2vHfq1WzS8NNVFrv39KWzK1x6VeVMEXn9EzMHA4J1CdWSgCNeaWDzp1fQiNiF3kJNyn11HBHwohngTF5Vd7SyxkHizVhpjV34jgK8qUGSJCxAul/bFZnr+6Tn1axv4liHqMq7jvFy089O4tjQV74nzkPyz5RcI+CDq44yd3GsBzgzCVeE5fzyChNQjuol4/mwWu7XUOb7gOsR/2u26ijvhH7tJ9cZAV/JuHoyP0UJFj+wDAyJrhF7XLWGKBmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Fri, 12 Apr
 2024 01:36:25 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::e71d:1645:cee5:4d61%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:36:25 +0000
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <68427031c58645ba4b751022bf032ffd6b247427.1712796818.git-series.apopple@nvidia.com>
 <ce3ea542-9b68-4630-b437-c9daddad2e83@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
 jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
 jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 djwong@kernel.org, hch@lst.de, ruansy.fnst@fujitsu.com,
 nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 09/10] mm/khugepage.c: Warn if trying to scan devmap pmd
Date: Fri, 12 Apr 2024 11:34:11 +1000
In-reply-to: <ce3ea542-9b68-4630-b437-c9daddad2e83@redhat.com>
Message-ID: <87sezr5pm3.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0060.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::15) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8630557b-a176-4b74-034e-08dc5a90f741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lQCKsggHJmQJN7mFKGY3oWKo3RDscLZZfnF8CYqtVlQUWONdd7/Ht3acirrD32Ejn2SamBQdAFb46iFV0ifruuFKlI4+5I2Aqq8SzilH5nRxdyytfvaLgKnYEdO7m0YsXuFeU6Lztp0nLQledytg1VsvjMp3o/vxZZ9E7pED169S42RY1rfcmZQeXZK4rVqQnZUoeYUXNLd97LoGNpsgMEm7Ei66/l4vJdDRWc91iFgzwmHSepigc0GJ2k+kLNAyqPaQzK0RS3Z2lf7xJk01dhvs/gFd6v31haaUGQImH1Q28l33jaeo1USCWZ2fWsINC6JqQ736+oXIwuU5U5EJ9kE+xImSkQloMIL7+fQAwAT3/cyYb3dXvVto0OtZdbVq//b1imsBDCK5PMn7ggvK0ZRjBpNl8Z3wJo0/FgimpGe1lMdLis5VfDhNuTX2ZU+Cf5TLz/mjYt1QdX1k3WiWBifeGTs2RQMFlY8cGgPoItkRJQQ6ZDJqd4jYC6p/vX1IC9b/KGGFzEJ+vQXG+S4J+AK+2MJ3aKf3MynGDu3G6lEJ6xK18s25ILEFce7e5cuTRdHzcMCYyX+p7SyoRbrrU4LKojcMJED1NHDptwrWI6slKvCvarG2kO6LFV6beg+vXtmB++2G/mWrack8M0tDXgWbduAOglkKLUQctPotPjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?btcZdRBcRAIiSR6KDm0qqTdTqc5g66Rv6iVm0hrRvzwXo5Wfxi6cV7/vdUnC?=
 =?us-ascii?Q?AmdnH0ljHN0ipmS9uNz3Iv6LhMYLUQWKqM5+ty0GIRYjXjkWT06LVnDmQhe3?=
 =?us-ascii?Q?eSSsfjBsGuckSZysx/+ywrCrYTZzr2bXJHEjZnWE6zAB2LJr8EmXTlo9CPHK?=
 =?us-ascii?Q?pDfjBaqfv2mNf6LW46whwT1oO8nVe/y44mkHPQnWIDUCzC1NbHGYd5aTfrf9?=
 =?us-ascii?Q?5DibneJGy0YKFIkNf8HCstDGnKs/IkTz77Ks4rGKdw0rAOaW95qlhSkLSSwb?=
 =?us-ascii?Q?6zYzfWTUbV2IosB1iduZsOxFWk2/xwq8Gnf/+dX8Kc5U265gnVcpCs/lVWHf?=
 =?us-ascii?Q?sP4ns2u2iO0JhQqpgRiO+W5cMOkPQ4/3/Yru+KYLD+JQy5bReAJpkn923Prg?=
 =?us-ascii?Q?0+41rgZ7K+FVzFQYugmOZJpqcbn63oavY3IFdr1uqVIit7WhudZULSfTdbIG?=
 =?us-ascii?Q?vRhCzUlq6g4She3MmzNGdzOPMnfHHHa/lVw/OugzR3XPpvgCUZuG7gl13n+U?=
 =?us-ascii?Q?iKzsz8KXmNNXWiD80qrBW9UA3WN+YIlzoEICNRDsBVquAo48/VLjwHNi0x/Y?=
 =?us-ascii?Q?M1ORBE1jzv4co/5b1eHfKkyKduqL4A65BF4r7j0xFXoWwkJ0IShbhPu2jxGj?=
 =?us-ascii?Q?cGvX8swti9eqtPL2otVsPUxG+TwDewJ8yWYV/8Xzqvzohn+RfKn1no2y1ZUl?=
 =?us-ascii?Q?SvCLhvoIshDUiogKk8rZVcOLP1E1xH3yG4RzKEjdBO2SZtYO4UE3og/0E2rq?=
 =?us-ascii?Q?5HcnXJanp82zeSZvGa9mtdTiArIoZ2hAA+046hizxqKFs1W1sKGRLowi3NIc?=
 =?us-ascii?Q?vsE8kKaErtsxwluFBkQ+Ckn++9+dSqe2Jv56hrqX69Y2wJnoVGdt12H2aCpb?=
 =?us-ascii?Q?jNFmhMbKakN73P+O+RS9RfarMQ/GvKN0QZ2MvSlBZxLqgh9gg30CGPO7rSOG?=
 =?us-ascii?Q?+QwxCL/FwYFyspzJw2F4iRdKRvw+u7qStIaTSavuJShKGIz4jFRBO+VfJwxX?=
 =?us-ascii?Q?rvSBO+dnqzJFGr+sjxSSTFddnx5B0y2bl28FhvtouscqQJsVtx8koaMrhAFQ?=
 =?us-ascii?Q?Z2mlPklAOO4zCX3gJuTq+RFcRDNwQJM80B7g1TK5+UGXkw2f5Cb/RrWzlpK1?=
 =?us-ascii?Q?pateu7s5pjREq6AmMeSRqFK4yTS2PDfqK6VL7KK4bOQBq0ffo91/lNiRc93k?=
 =?us-ascii?Q?odVlgMCTOEelQVGaDW16ExGZdFbMVEUKkM50FVY22ZDcQnOgjqrs3QX01XBh?=
 =?us-ascii?Q?aInegVPFJWdhYANfuU3vNIDamptA93DLv53bI6Vjvcj5NZDfZLyLASYsR4dX?=
 =?us-ascii?Q?83K3f7c7tRtNbq+x/hv9l31HS0ubYOsJf2OEBUBn1UzUAJoOkDtEiDJT9c80?=
 =?us-ascii?Q?FGlleGCyCEN1MPKrPUka3U9zQDlBV++q3NC0/UU8cLdJvIQ8YKFqgTa4iWIj?=
 =?us-ascii?Q?DdtGEBGogW/NFTCiyKwuGrfrMoSLb77tZWhUeAvjedYB2J+y45g7Nd8M7yra?=
 =?us-ascii?Q?pImsBqd5I6/bMmePgGB9OjrU7QovSmA870Rne9/dPkk7dJ/z/Fd+dkAdba6T?=
 =?us-ascii?Q?hdAaEYi7UM9x0gCaVlSWBmVaqYp9Ryl24vudyMKJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8630557b-a176-4b74-034e-08dc5a90f741
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 01:36:25.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxC2j/PJgv4OOlfmR8fn3n+0PT9Y/fYiboYc6QKZhB/HfCosxSLm5+tAaYSNEd0wPTp7etzPZCzFwioq9OhEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440


David Hildenbrand <david@redhat.com> writes:

> On 11.04.24 02:57, Alistair Popple wrote:
>> The only user of devmap PTEs is FS DAX, and khugepaged should not be
>> scanning these VMAs. This is checked by calling
>> hugepage_vma_check. Therefore khugepaged should never encounter a
>> devmap PTE. Warn if this occurs.
>> Signed-off-by: Alistair Popple <apopple@nvidia.com>
>> ---
>> Note this is a transitory patch to test the above assumption both at
>> runtime and during review. I will likely remove it as the whole thing
>> gets deleted when pXX_devmap is removed.
>
> Yes, doesn't make sense for this patch to exist if it would go
> upstream along with the next patch that removes that completely.

Yep. I'd had it to sanity check my own understanding and figured I'd
leave it in the RFC series to see if it provoked a reaction from anyone.

Will drop it in the next version.


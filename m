Return-Path: <linux-fsdevel+bounces-54090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D35AFB29B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B00E1AA15DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF329A9E9;
	Mon,  7 Jul 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AaQpRX4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C11291C23;
	Mon,  7 Jul 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889057; cv=fail; b=tp9ObugahlmR2rfUDM7g9qT4nPmRbp1liCrfiEzFE8jGTurkbagYVa7ymkQ0SiCAK4OA89ca1PllkbhDnLotowIkD48UjB+5UsvD9RKRJVhFxjqcYFVmLiQ+KvauNS23wV5T2moXqy9+P43fYHX2FzG9BC26u+CAMKG0XHWD3pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889057; c=relaxed/simple;
	bh=I+vMqrjD7BDEk9NSL3pM2aB9BH46hIvRo6bA4PnSAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bnG2H5WJv8pevK0JHBwRzK2nmykzBKBiklsCc6WBoX8W1J6HaEXR9YeWPWilx+hK/q9tv2LzRSDBAwvn/ChiALbjM0xfr/KvXJHUPa1d3okrvf/q4NdIZftmv6BJxhCneXpw37o6w24kKI5JeAhpRU4qrJI7De276X4eLDtEuFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AaQpRX4J; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZO+TXhCDU8a67Vy+UXQRljrwF6PY5BPZsFJu1BMgpyFvuy4/GLNQkhr+untl0TKAmWtXeQZHN3HYSxqsONfoe063zI/oRzZ2VGCCU2szDyh+F6c701DulpB7KDAGeNV+ZIjIn9OHfkAmx9aH3GHsProY5SvfHxPrlC6eXR2jRWTBBYiV7JDDyliJYCNdUygiOQCwXDCHt4x0Z15RSfciCLjy1l7Eh0YwAhKQ4LQvc3HQsQ9nzCrdyRuTU/GATRcbkC7CDelYXIG+63MpK0L1alBPkd5oAuPAL9T0j9ORP0nJ5EoZPR8VBwaA6IK4g3g0JCrlaPmCSjBbKXsf1fVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY8j+HBOP9fJ0oSF4AJIvN/y44oOF82sXo1hC7Z/bs8=;
 b=HXUS43vH2vqhAv3kicOwKeN/kubG7CW6PpxBIk5yiRMsmpBYfRQLmb26hwVW9W51ip0IcSKtB3VUzIHQzkHiFvb36lKyco3jom67fJt3eIBjYpQmpOw7Xia+eOWJw5ef/sRaJKQMJ8Ff1imfHpA78kzTQ7xnrVyJzX/vdtt2UMIN1VHgrq/KmKoMH8u3yEEbFU10Y6h/8wZrXs+ZFYyordUQdDVn49rch2LF+5QMrmp+l8hhzCndexTURI86iSzAiL9wd3kJCN3lIvuuHCQkKblpAOKEv9AvvRW/AvutF5aDPEC0cEupxKRQ0WjWCBLkchpBRKQEOJ7Ru4xVgaFe3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY8j+HBOP9fJ0oSF4AJIvN/y44oOF82sXo1hC7Z/bs8=;
 b=AaQpRX4JDYlgwMMNKM8lt6TKxOJCm5czJAwPcIXvKtCZANM+PMeUjcM+E81nHs4tDeKsPc+UcjmoYbuIY9IX8it1mzKyBN0xzAB1p8sx6xYqK1TxflcVWPsUqLTZl30sgkK/6oRzyee43/AuvWYWhbMTrGbN+nAiVnNfsVFX6DAsuNCqRhmFylwl3clnGlwX4PPSyIwpPSebVdQwO7l2zKMGdl1+JikN5+aHAThneUC+2jk0EIGB8A981/QFPfNY4p6JeUsQ+34w4LAN77j/AvXTrZWHsEJIIAsq/OuLAfhIWpSITfLdKducTVHlR/xkxaRPvRT6GZP70l2MMvfrJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 7 Jul
 2025 11:50:52 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 11:50:52 +0000
Date: Mon, 7 Jul 2025 21:50:47 +1000
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH RFC 07/14] fs/dax: use vmf_insert_folio_pmd() to insert
 the huge zero folio
Message-ID: <orevbupi4lg2qficqzcb6qorctdxw6exexa4xqxcmf5g44ybnc@wzgw7reerin4>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-8-david@redhat.com>
 <cneygxe547b73gcfyjqfgdv2scxjeluwj5cpcsws4gyhx7ejgr@nxkrhie7o2th>
 <74acb38f-da34-448d-9b73-37433a5e342c@redhat.com>
 <36a8f286-1b09-43bd-9efa-5831ef3f315b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a8f286-1b09-43bd-9efa-5831ef3f315b@redhat.com>
X-ClientProxiedBy: CH5PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::27) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: b7823c01-e52b-4ef6-f634-08ddbd4c8602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7G79Azr0MA9CYfSB2ILi/QdA2ufBVN6PIuDl53AYNE7fSV/TtgRLFVOntVb?=
 =?us-ascii?Q?ViZ2puiiNj3Z22WFepDcIEmY5mNOr8z377H9sCJJaJDciRfpgBPUiW5wdVlk?=
 =?us-ascii?Q?9ya7ofFORwPUldKfOp+6CDxL+OSu6k4x6a49UjG9K0daknvRUMJ7uwy6BgIL?=
 =?us-ascii?Q?oBg7mcq8lCg4yNKpG263DJPHBjh7Z2oAq6vPv1mOxYYXh4c+9E8bSSb2rLGd?=
 =?us-ascii?Q?DjZzvRX/SCNp+JqkyvOdx+X4cADxtfFUMcPQMEihvRb/1lSKwoLMXjvXupsE?=
 =?us-ascii?Q?/EDTdtgUR3jlX9Dqk+NMKqwk4+jnxo6IENuHD0moKZvXA49BSPrDUH0P6Kvk?=
 =?us-ascii?Q?ZavOmRNgye11JjjsNbBEIff/NfuvI/mw8YoL+YtsYv8qncFeN7ZIc9NaaNzP?=
 =?us-ascii?Q?SJRSujQbDwvc6gafMXQlOBUMopIFh2+/aYtxyJNPxpM8G4LlxEJjguNplpyQ?=
 =?us-ascii?Q?HM4hZ3ZCv8lHdjiloE/ILpg1aQYOt8CLQ4mipCtUAlprmdyZcnO/M9Xz2euj?=
 =?us-ascii?Q?d5968Z9zYkkthuRqgc1nZYl/M7p0ij2ii+CT9qQ+/0rrS6ZE9EI47LhzHTZK?=
 =?us-ascii?Q?V+XWyk1ur6V9nZBjli+qdgxEdqeS2CyRvOGkv/Vh1LiuXHhWYWlYeD/fyTNB?=
 =?us-ascii?Q?OlVLcSfrUoBeHLcXj1nsQWb7v1pcJ6hesb+6ESRuyQqzbiHWMCrk/vWub0zo?=
 =?us-ascii?Q?A2+GuIEJu0weKiwhw8Zqpgpl9oXVe2DzlQU6djH0SmptmjPJ737sGIYYRmVy?=
 =?us-ascii?Q?dl3lZatDP3vdLlePPcHVmE1rWOkEMGo05dfnACs5HNGBjSwQuNZvD8j5Y71V?=
 =?us-ascii?Q?gUjYJMHKEXhWWki6gpA4p3GOY8wyPqPLYQn+A5o9PtbkEKwYXn/mhuxBk/5R?=
 =?us-ascii?Q?8j6NkX4/DCFxwSlTqJYZ57yaduyd7WkF/yTLPRMa1olTvdB8Oq0RptiFKHFo?=
 =?us-ascii?Q?X8Y14IFCRKAIqXZ7tXWD1qDL8jDl72N1HAqOkClyUdLCvBf4sUmQ2q2ttuc2?=
 =?us-ascii?Q?c1CKC7uS5QAnpUjbfZ8b4BFdU96+wNEt3HBOrYT8sWg8D8DEQreqvXWoYNDk?=
 =?us-ascii?Q?UZKDmMpfGiR3qUyNf/ZQEWOW3AUgPxP+bB6la2XyQtcXwtV4qYPj/zEOR/du?=
 =?us-ascii?Q?8g9F58IYFYBmdsbIgYscMBWRILCubksXOPx4+aF/NHKdDYNXm6V1R6tHSbC2?=
 =?us-ascii?Q?M6GMP7KL6PztMZkponrHoUuGBfl35co/5Kl809owyPv4YLq2CpMQJP5RKC5v?=
 =?us-ascii?Q?JCs28Wg5fPs0QAZv+mzktQPVWBeYTKKn7131v36t8yDQmcaulgFRsy1aQ9Gj?=
 =?us-ascii?Q?xenCoUmYfonA1NUHJOqVi6pvs61Pp9udbcV5ceLU1kz6e6E5zeiSHEgbuPqD?=
 =?us-ascii?Q?wQ0QpKIHp6INPd6iPI1nF/gAli/8rPNIJh7qDuyOgn/bF/2VaTYgxWL0xOyZ?=
 =?us-ascii?Q?EJ8Z4X1BYRU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iMbmt7egNmcncp5nq1ZD0fCDomSVbOmBt9gbgAwp5Wgq43d3shyDdOvacVr6?=
 =?us-ascii?Q?Zx2RJ1itbp9qfnMkb2sUzSYUft9qg/R8WTurUEgUY72Lporpv9By2P7Vr6bo?=
 =?us-ascii?Q?2eN6MBTS5ssGsDduky+8xmE9B2QMyAUDGJYsvuGkWYnf07RsXJlKJKlx0ljE?=
 =?us-ascii?Q?6YsZsSFc9uXcvnAO0lfVwPxUkGlUgATE8Xv+RCZUlQrqtw1s4POxMvzhcFGH?=
 =?us-ascii?Q?uQ/vOEJOuWmUK0A6u4n9t03EsGKbfZcp9wNPP+XKPcjqe6PqhBbvfpg6zXIL?=
 =?us-ascii?Q?E0aaCV6HSovuH64ngQfgjR+mBuheIddA2GCZEbOT+7TqJi6ipEg99sOMpvT9?=
 =?us-ascii?Q?69C0uWrG5WjQ66K7sQ5SHthwlwS32bO2b8Qd+y91tyOAXvYyqHz9y6bYjeKc?=
 =?us-ascii?Q?QE3GU0OPnjTg47bV1EHlrQtVhhuFU+bC46uVFDu3EsS01GzIcLZ71rRDH/eA?=
 =?us-ascii?Q?wSx9M7VTIvujPieYdZULrKhE5P9Ryo3OshNCvn5ixzVxGI765mRqEHRhjgdy?=
 =?us-ascii?Q?lWZ9b8qrQPi8yFNIendYdCvegxXZ7VMqMCYxS+kEE6gKVPcUpmyRqlqYquoj?=
 =?us-ascii?Q?cpEUx5VLHxT3dwekypIqorbQW7wl4jnJVxdPb1+QhAAn1CaU22w/0fJZMrnn?=
 =?us-ascii?Q?JAA43madD8WLa3LCHtIhnK5lPKT244/6PwHCHlhg3sR9qjlhmEdxIQVgu6CL?=
 =?us-ascii?Q?exXwGX/j7pnF6n3lIYXWcvKTu+nW50HVM83vS9fireR9q7HA3FdJdX9NRbvK?=
 =?us-ascii?Q?34S96hMVZiuRLbKZQDdDEwNwpV2tO7aCi0bUfnWh+vXASYsW7GtS07DMOtwf?=
 =?us-ascii?Q?VtCT3VWFWeqiz4ZwBJY2cH1Iksy1hdMQnZgigjk7pUmAcHm8/0Hyxgv66Nb5?=
 =?us-ascii?Q?QE4v6y5inNw2EEWP7dHjorGG0Jx+26lRsM8C+1EHfZNe87fanu8Qa9v4jVr8?=
 =?us-ascii?Q?d6Z9ZrkhqDDVA1MUzVaFHcvYB03d9sd9ngBMBYmFZsUus+HVaA+zDXaxJV6M?=
 =?us-ascii?Q?2xcqbTtyz5eBQ206vg1CggpNKxRqDi23tsLk1urdNNGBNc/Ud4LtBjKy8yuS?=
 =?us-ascii?Q?OS1PgSA2YOCCg04+WfNblJKbDkQ0nnulh0n9tpq0opuN6AQy9abUm0ecG8gT?=
 =?us-ascii?Q?NL1CIv8rYr3ufiumziQDsUTIo+JiuiPiUH7yZDBhKs0q0RxPbw3WMmKElOFZ?=
 =?us-ascii?Q?1PReCZm2ReQowk0uTz+lxT8p2+ljCfL0TGrR0Z1TRwgIcyjP1s9Bbp+srqCf?=
 =?us-ascii?Q?pWX9mt8ICHYZEP9CajnjDFWUPUnaGx6yEhtsY6j7cF0g1PBvuNqOggnTvCQG?=
 =?us-ascii?Q?WsnqFKhSu0NfNJjSd4gHi6NXvna2UyBLCEyogEeP2ZzkUtcsjyZ6Qf1tvW2y?=
 =?us-ascii?Q?rifv5Tmuph+AE5mabzU01ft9Z5ZzuzI6BBz1dFwsttnFGrBPJaOH6PBX+Rgo?=
 =?us-ascii?Q?XHMkwOs0oe+EScrjzQItmXi3SR8/31pVIVwmikIDcesyQYxWgFiRcnNa2/zl?=
 =?us-ascii?Q?Y4cJkO1+7sSkeIloGGEsj/qI3JpVb9Zqfa2+z8pq6swqG92xwUtzKYHwTTOD?=
 =?us-ascii?Q?23TTKsQ+dm6kZ7BU2BzyU5po+HrtpbOTjqN+Lutl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7823c01-e52b-4ef6-f634-08ddbd4c8602
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 11:50:52.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ef9FWW5zjYEFbXqKBNio8c8xbK0jcf+3GKU3Cu/txmHzzEFH9cHeYygVH/fN6c2jBfqF/atMPpNreb1iT7dpBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556

On Fri, Jul 04, 2025 at 03:22:28PM +0200, David Hildenbrand wrote:
> On 25.06.25 11:03, David Hildenbrand wrote:
> > On 24.06.25 03:16, Alistair Popple wrote:
> > > On Tue, Jun 17, 2025 at 05:43:38PM +0200, David Hildenbrand wrote:
> > > > Let's convert to vmf_insert_folio_pmd().
> > > > 
> > > > In the unlikely case there is already something mapped, we'll now still
> > > > call trace_dax_pmd_load_hole() and return VM_FAULT_NOPAGE.
> > > > 
> > > > That should probably be fine, no need to add special cases for that.
> > > 
> > > I'm not sure about that. Consider dax_iomap_pmd_fault() -> dax_fault_iter() ->
> > > dax_pmd_load_hole(). It calls split_huge_pmd() in response to VM_FAULT_FALLBACK
> > > which will no longer happen, what makes that ok?
> > 
> > My reasoning was that this is the exact same behavior other
> > vmf_insert_folio_pmd() users here would result in.
> > 
> > But let me dig into the details.
> 
> Okay, trying to figure out what to do here.
> 
> Assume dax_pmd_load_hole() is called and there is already something. We
> would have returned VM_FAULT_FALLBACK, now we would return VM_FAULT_NO_PAGE.
> 
> That obviously only happens when we have not a write fault (otherwise, the
> shared zeropage does not apply).
> 
> In dax_iomap_pmd_fault(), we would indeed split_huge_pmd(). In the DAX case
> (!anon vma), that would simply zap whatever is already mapped there.
> 
> I guess we would then return VM_FAULT_FALLBACK from huge_fault-> ... ->
> dax_iomap_fault() and core MM code would fallback to handle_pte_fault() etc.
> and ... load a single PTE mapping the shared zeropage.
> 
> BUT
> 
> why is this case handled differently than everything else?

Hmm. Good question, I will have a bit more of a think about it, but your
conclusion below is probably correct.

> E.g.,
> 
> (1) when we try inserting the shared zeropage through
> dax_load_hole()->vmf_insert_page_mkwrite() and there is already something
> ... we return VM_FAULT_NOPAGE.
> 
> (2) when we try inserting a PTE mapping an ordinary folio through
> dax_fault_iter()->vmf_insert_page_mkwrite() and there is already something
> ... we return VM_FAULT_NOPAGE.
> 
> (3) when we try inserting a PMD mapping an ordinary folio through
> dax_fault_iter()->vmf_insert_folio_pmd() and there is already something ...
> we return VM_FAULT_NOPAGE.
> 
> 
> So that makes me think ... the VM_FAULT_FALLBACK right now is probably ...
> wrong? And probably cannot be triggered?

I suspect that's true. At least I just did a full run of xfstest on a XFS DAX
filesystem and was unable to trigger this path, so it's certainly not easy to
trigger.

> If there is already the huge zerofolio mapped, all good.
> 
> Anything else is really not expected I would assume?
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


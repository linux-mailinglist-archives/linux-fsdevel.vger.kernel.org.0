Return-Path: <linux-fsdevel+bounces-52653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B3AE581E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 01:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F2707A8B6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94AB22D9ED;
	Mon, 23 Jun 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="innGECWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6ED227EB9;
	Mon, 23 Jun 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721952; cv=fail; b=K4jjGgz+BkT4TP7lmpm8K1GWSRO71MSNv+Jt9T65Swt9aBb/8aB+cXUJth+Dl+ivZ1W38ZG9tw632d3QZQvuFC8JWvO8mw1gu83iaqiinBOPjLuc7A0UlCE0RVGmFN1ufnDL3DhpkzV8dlywJSphiwyIE6vAHUHvfR64JwGvnms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721952; c=relaxed/simple;
	bh=QyBQQCwnKkXkm+5895Cvi8kUxuFkysDgKdOXNB3o4UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MIGHDeGoRfUZulW0HctYYGVpjT71kZsb7m5lHP7S76n9mbQlD3mpFH+0JyksCMHG5RMQAoIdR5q+qigkcE2NQVx+smotrS7bZJ5r9OMoVkw4xFgqQLYskDPckTflb+lgY1o9sE4hOsYuTCCpJ2vRTkdbIxDQ+zsP2MXjyxmtP9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=innGECWH; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEebbBiMIuSsbsHJ/ZkGYD43Rb9PF6y5qAaItxkKqaT0goNWStbHjFJDESkCt6a3AYgGcaP2mlrAsdrupInps6LP1SrC/Nmdx9sta6vaer7o1FsuP6Sbr5qqqLSprZHN3XW46JBuFT3yVOaglSofBQWURiAoYv4WLB+c6bgmfxQl646g2yt0FRgxaendRlujCzFkRcGpKFsz87jQc5WNZHP8lzoQix44bZi2SbEC96KsNkGZA2M3N0esj+YgjsjrlgFYhmvabDnZ3Spvx8e9aPeTohLfknLaoOhfxJicwD1eaPbhVb0F6PhORuV+Tw+cRv0W5vYJ5ClbI540OgZeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaOr63kovdEPujisOVHHa/rTKawcss9C+4o3yrvYXuY=;
 b=rZ/sGGLnx8jwC4YtgCIUUP1g/DcFjnIIMaQgKpOmQylTO2lxs7YD8MroTI7fQgIJqLNqi9nbHLNCL2YOz3cs+AgSWW6Rhubs0eIKX1TXr3kLdAMFNT/c7vJnC9SEl/Z8fDhd7InY9yGFu0FGoVdVnY1gLqJldMZMUdwDv4xcGLwrlI0ThhtGA2mn+CdFQgnknCkLgXWW+WhC2JhDLAFtswooe5eUAp5YRcs7yqimF0hYK7HU7ZElPQ7aN6xGRlGHh0o8/3x5C/MenQPF//T7A7Bzf3yW8LZt3HH50O8DKIVJwgo5RxpO9kvhKSDDJcg8UeUhJ/PPkAAzfUaNzsaSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaOr63kovdEPujisOVHHa/rTKawcss9C+4o3yrvYXuY=;
 b=innGECWHC9KMauN2j9k4DWG/U46EmUtzhlvQvQ0dMx3V+90JktcVObY3T0r/TtKzXOMDcMC01SY2hzF8LYFBbYZ9601TpGUshF0xZJx2UUjBgrkgAtjNDCMlG32RpwqI8bCvqpWfQQEfP7bfOjsCGNlKn1jY7pmgGeDOUsHb8Q4pna1qOM1RlLSoMG1SyfqizE56Pdj4LLIbuRqd7eBbY4nxmdBaiqL9UMJPwZ9WboT0x0XxXJlVwsKTgIXDHBALDNQiGogjnQBRnXPvIx5AdIF8L37UgQxU1MSiMKXM8B3nfqBLaRc4+oD8JRqiVoUnLQJmZAsdnsMKuMkAVPlpXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 23:39:04 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4457:c7f7:6ed2:3dcf%7]) with mapi id 15.20.8857.022; Mon, 23 Jun 2025
 23:39:03 +0000
Date: Tue, 24 Jun 2025 09:38:59 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>, Mina Almasry <almasrymina@google.com>, willy@infradead.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: How to handle P2P DMA with only {physaddr,len} in bio_vec?
Message-ID: <kggfpco3cxipbptndg3ghc5p6yz66gitgghjsk3vd23ov53eyb@tdt7k4kzwjps>
References: <2135907.1747061490@warthog.procyon.org.uk>
 <1069540.1746202908@warthog.procyon.org.uk>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <1098395.1750675858@warthog.procyon.org.uk>
 <aFlaxwpKChYXFf8A@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlaxwpKChYXFf8A@infradead.org>
X-ClientProxiedBy: SY5P282CA0026.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::19) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 64df8c78-7d5d-471d-9d27-08ddb2af230e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h71uerI8e+l+q1c9jM1FJMUCoIQKO5R11HNRpE0e3HhDab2Mj+qIPc3H20aa?=
 =?us-ascii?Q?3DqmPFQK3BKeVhaMfDVW/YzUZ++OV1OeA3sYupOARhUL+8U17akF5xbdU9M6?=
 =?us-ascii?Q?/fbN+32EkFNcg8eEZwzVv7sLGfVo3YkEILaq6miBWZxRKrvXfBncQNpbxDKt?=
 =?us-ascii?Q?kWg8sZrSR6SeYfJJzxL8VuTUPmJSSGOcdBZvnHZxrywZ9NPIBvYIef+JF0oj?=
 =?us-ascii?Q?soxrNo90mE7D1hjJcO7C9v/ZuG1Pemav6R9hiUzoE2X0eizMnseYkBx55han?=
 =?us-ascii?Q?f/I+rX3tKR4dnw5G2Kn/iWvaFysnvnaLLiE2ipT2tNgKxTjdBZFU2GFvvJoU?=
 =?us-ascii?Q?DHKyb+sANeX/ratOnOnB0WNxgK25UBFSL0C5J8QZXD5WF/mDzJQpAN5kQ+vA?=
 =?us-ascii?Q?NfNmIeL+rekNmnZnK3D1WaoDfXzWYxf18aZyv5igOOK/E/mj7cYSTRVxyCjy?=
 =?us-ascii?Q?cXZxokprlJcv4j3HGSV5cTudAI28I2+xso6n1BGZBDYv9bvazBtI1oSjUWjw?=
 =?us-ascii?Q?lfPjluV8predDybvLtUZnQcucu1haDQTlzI8uu2NPkwue0UOmANNVJDHlBo4?=
 =?us-ascii?Q?fyUQF0koMga/eQBD7r4Ia+UOGAXKE+sgOHwssQeve95gm+G/7RBoiAyWQwUv?=
 =?us-ascii?Q?7+XQtl10KHGew/p5mF1JvyJmL+kd62Bf9QJGuSrxrGb8WP5/tJS3/o5nsamC?=
 =?us-ascii?Q?iYhfHtWWWc41hHkpmWqkQaDJzwpYPJKmukKb9J0zm2Yak7mamPWcx1SI9YnV?=
 =?us-ascii?Q?fUH9ZKRgrtm0LCQv1k3nE+1k55eIDBY7D5E2XB6rdBUmq0+vetzMyve8vOBa?=
 =?us-ascii?Q?ikMpEfve0YXj5YeigUu7x/Fxb2SPOkZy5dxBLwcJnUC3Vsl0liwG9X5ydUPt?=
 =?us-ascii?Q?pA9TcwiGPTs/QwgRQzCHHKHzk6eCeyPZ+A8BBIj6kU8/HSaWshwnV5dstGPT?=
 =?us-ascii?Q?b27Hky6uayUNRNws+drlQIZf5ldUVstyGJcgfMeRiTdmLZ2AWP/7Mw6X/sRx?=
 =?us-ascii?Q?EdtKlkHSwxid8ub3JUNRwOkPe7Hhbo0H+s+sL1D9g7X4jh8uG4gHGbGSdlK7?=
 =?us-ascii?Q?AQRRYjtBOPgA+fFTOtXWXbaVDbzHusFuuaVrEGu80RYUzTpdim5Hmf8BrMle?=
 =?us-ascii?Q?UeLwF5i/8b2sgaZMY2+8XYU2EkN0M6SpuJiAeYJ13HnUh5vs5AhnnyvZRzYa?=
 =?us-ascii?Q?qFElkqqsg1ogvhtJeak0FS22nHoCPn6GELXNpb8C7eV4pxIRTKlCh1p8Xr8u?=
 =?us-ascii?Q?xwFDj/lNUdQC5K+bD/us0HTepAbaUEwxGRgIFK1hWI4mCKnUeVVsrYwXYm/j?=
 =?us-ascii?Q?GDPPPIwEsRMFNtzqtWSjvA5DXNMzi4i+c5R8UTYosgcNMqgtfjwVPJQcZnT+?=
 =?us-ascii?Q?LnagihGb9aHD8kH5IUFv6+fgR0WzNgAKiJbm8bDzJHeOc3vKy7283gZops6o?=
 =?us-ascii?Q?yMYPR5Sw7Vo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L4j65xjXfHkTC7/zq+2lCewwdZ7+SuzMls5pqIiK7xx2QipUOWCSmjNbrotJ?=
 =?us-ascii?Q?E056RfXvNfGCenLth31CLtEv8xJQXnFIXtdtGTs51KHqaIBEnnZHN+cphHFh?=
 =?us-ascii?Q?n93vSnf8w/qJ3EzuY6Oxdr6/ePvAZJ/WaAYQDde/0afqWkWZFQgwEYmwBxlT?=
 =?us-ascii?Q?YIflFujCPntqvafEL4XC54AfAvMHYnh166/wkh0d/LgNiKv/qlZ4ZP8IhM98?=
 =?us-ascii?Q?0kJrG4GuLpmhxOmIAryX/IJ+EBe6TQUv7+1gjLL69VRRUTCmn9hv/3EIMdZ9?=
 =?us-ascii?Q?6r3Opgpbnn1Z2JFfc84QpbP5VCVR6Wja1n7xLgD4ruEKnIOfeJ8uqXGtItpd?=
 =?us-ascii?Q?FCJGPWrqa5bcghTxL6HYNnh8ACopByR4xByALAvJ9oyIm+amPxR2lOQFPzVh?=
 =?us-ascii?Q?Wq+Tt5fkeksyAUMkz60x3eT7olD1hgsd1bb7Cynd8be+QGx8lGeQouM9oA2+?=
 =?us-ascii?Q?Zhhnij24Ut6sRhWJLQFWHmLzJ0Mm4jc1eLg2aovO5yBqH4nEKhOw4oPx5K4f?=
 =?us-ascii?Q?eR54rW9eBBpcIvw3XiDhjxt5SPD+PC6b5vtBE1RuB2h6m93jWVP/by+NUpCr?=
 =?us-ascii?Q?RdRqtrVCAcT5BB9DA+aHA14OlWns9tO6O+3UMxbox0x6NSUp466ze7bO4YBq?=
 =?us-ascii?Q?6YsGAwkhJEFPd+XNLOfDW9iN6f4QQUGt1PzOfn75m7CQ29fi+NjyJOQwU5CC?=
 =?us-ascii?Q?hbfGrsIm3BKGsnBx6aIzKN4yIdM8aSRDoSfx/zbP0L2d+Ot1yPpNCPeGI897?=
 =?us-ascii?Q?8Equ3Xz3WxdiG6b771n27M0Ach2Ju5k5VA9rEiM/T+JouHhWxULZMl5fGrlR?=
 =?us-ascii?Q?kz69O6/QYgpF2orUukwIWB4GNOsnFNzLIKpLar6TmvOCNuWmgFKQZ16Q9n4k?=
 =?us-ascii?Q?Db9OLJCgWUgbUEo4Ytx/8Hgr5d2LK9Bx81M6qq+nGfMTexeDiqFpSor0Cnyd?=
 =?us-ascii?Q?y8gXB3wt3UYKuoVLlQR2kAXVP+6DNXoccOzEJQmzjCGRFX0g3KOBwP1tLDhl?=
 =?us-ascii?Q?cfumCuXe3iyguz/WoldodfKVRUsx9fgcTT0M/Eg3iDB/QynSwKnOOIII27l/?=
 =?us-ascii?Q?Eq61QFKGY7C2Eay8booZ/ebyqGXOtSqhb01pU3MwEL5r4ve9JdyJ/YEF2Hfn?=
 =?us-ascii?Q?njWd7YVy0x9RmXUk2Zb5YlspvzcojIFNFsZ0THx6s8TQxmJ2p1GzCVUfs4fG?=
 =?us-ascii?Q?ZK5k2cjjFpN4zBYcHF5cuxbAFSTSIxbnosJ+GfKy2/cM04yv1wnZr4BXgL/6?=
 =?us-ascii?Q?KK88YXjCUsNTX+h6TgIotw4ImBzUy/6a8lgsUiB5mGKs+KBh+MMRRVKgrZen?=
 =?us-ascii?Q?JX9RDRW/dtTdfNBogtVYePPw8aHmPOE4heUIPLbPhHyUgkfbtd7ApUFlYC96?=
 =?us-ascii?Q?x+q60wvF9GysyY8Weo8sxTMRY2z357A7+5DH76Y/+1s9pw9U19GU/jX8nGsk?=
 =?us-ascii?Q?QC3SYeyrecVM8qCukY0RGrTHb8+h4pbEWRHr59Qw+8yuNIFxm0KhZydErDwO?=
 =?us-ascii?Q?0Yp8JgHF5btl/IEFjOhzTWyTqcfkNrKwBaTPJzhXlFrDCtM7RuOCa2ph2F3k?=
 =?us-ascii?Q?yo246UkQwRGa1NFYXZsbwptTj/lDZ2q/gW0gtxhR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64df8c78-7d5d-471d-9d27-08ddb2af230e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 23:39:03.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfUMA03ite7l26HCZFYOQbC/kL4BWELXIr37lMV6PRvmXE1la19meU14SrKVBZflEfXpMsX4JNRoR7iGXfy4og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033

On Mon, Jun 23, 2025 at 06:46:47AM -0700, Christoph Hellwig wrote:
> Hi David,
> 
> On Mon, Jun 23, 2025 at 11:50:58AM +0100, David Howells wrote:
> > What's the best way to manage this without having to go back to the page
> > struct for every DMA mapping we want to make?
> 
> There isn't a very easy way.  Also because if you actually need to do
> peer to peer transfers, you right now absolutely need the page to find
> the pgmap that has the information on how to perform the peer to peer
> transfer.
> 
> > Do we need to have
> > iov_extract_user_pages() note this in the bio_vec?
> > 
> > 	struct bio_vec {
> > 		physaddr_t	bv_base_addr;	/* 64-bits */
> > 		size_t		bv_len:56;	/* Maybe just u32 */
> > 		bool		p2pdma:1;	/* Region is involved in P2P */
> > 		unsigned int	spare:7;
> > 	};
> 
> Having a flag in the bio_vec might be a way to shortcut the P2P or not
> decision a bit.  The downside is that without the flag, the bio_vec
> in the brave new page-less world would actually just be:
> 
> 	struct bio_vec {
> 		phys_addr_t	bv_phys;
> 		u32		bv_len;
> 	} __packed;
> 
> i.e. adding any more information would actually increase the size from
> 12 bytes to 16 bytes for the usualy 64-bit phys_addr_t setups, and thus
> undo all the memory savings that this move would provide.
> 
> Note that at least for the block layer the DMA mapping changes I'm about
> to send out again require each bio to be either non P2P or P2P to a
> specific device.  It might be worth to also extend this higher level
> limitation to other users if feasible.
> 
> > I'm guessing that only folio-type pages can be involved in this:
> > 
> > 	static inline struct dev_pagemap *page_pgmap(const struct page *page)
> > 	{
> > 		VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
> > 		return page_folio(page)->pgmap;
> > 	}
> > 
> > as only struct folio has a pointer to dev_pagemap?  And I assume this is going
> > to get removed from struct page itself at some point soonish.
> 
> I guess so.

It already has been as the struct page field was renamed due to higher order
folios needing the struct page dev_pgmap for compound_head. Obviously for
order-0 folios the folio/page pgmap fields are in practice the same but I
suppose that will change once struct page is shrunk.


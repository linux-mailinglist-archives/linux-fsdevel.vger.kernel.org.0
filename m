Return-Path: <linux-fsdevel+bounces-52759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7DFAE64C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F2A1BC0060
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ACB29B200;
	Tue, 24 Jun 2025 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0U/Rwrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F740291C12;
	Tue, 24 Jun 2025 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767532; cv=fail; b=KBfANmCYYjKAAyijFpsWoD6SgjwFhNaftWmKsDUikgV7xqQR7oxtqs16WUOWK+K7kls7hGCF0VG8PN2NH/QXzry46A0n0ny3TlWTN46cVbVvSk/cdqlaXz1/z6TKEtuVJso87RqurTixWVyZV/Y7KuYGPCDIi63+TxnwVP5WiOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767532; c=relaxed/simple;
	bh=1Qo67fdqmZDVErn/XWSuVe62ffGcImmuZcac1ygst+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lHQ8vwVRRtATjrKpRiAseZvTn+hQ2OvWUNcD3gBwAQQyHdmEfeLetdYEcOb9Q5ruJlExMJrB7S7qGzm9pIUO76ZPA0VYeVxPFmTI8UuNfIBAf/m7PVRvLwNg37dA16ahsMyqFmq1lMkhxwCNPrbPlxJFKcIh5qQqo53M9HgRv1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0U/Rwrx; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MK0T7K9ikcJsj+rcAwwUzdJbWSi6a3DJTVu77wONjkf10ZRLfM5Meel7LMM3AvS9IpElvlnMvQNZ33Jp3gI7xClpjt016vy/qCP7xUE/xbu4eyDXHXUcqIG3xtrqMsuk46+Ml7JwZHvD1KhbgU/1JLAFHORxGCooib2xREWmAimnbS1a/XAhps77jzZZtpunyf1j84z+n5gbLJeM7MZaRQ2pvPHUN2B8a3rY531OlwmNm1rJETLJJyG4nb/cZkgCSqUhCHtsF9jgUi8uexD6VEbON5400yffv1CPPp5KTdLBLKktXzmOira0Rs0F1AuPPoWL8X6n4nRP3isRkOgVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLha9285DVj7/grm5DMhOghm33y+WqnhAjlZVpKBwaE=;
 b=XMtwuT84LIk6n1zPJt1QKzWoQPk9Le1yUWVv0pCkkKwmTqJ9oPDn3WDJ7LF5x/xwSB3lvoODv10+1Y63w/oRW9x2pquSH7vf45yMbPiBJgubkq5HWWS9u5MULtUn+uKfLr1xuerMODR4gWHCwtj4bJJvkkEIZ50zQ6jKWuNxpUJfu7Kw6R24EObvQQgeGYD5Xx20uvUUktUkGWvdsJRWFcDjBhl8USf9Us7C7tBUJDt5CUo3yr1QriAWMFBGS7tbX0+VjOxkLSmXyFodEGWsyB5m1l1ieiXaXyD+thlJGtDpZZyC2onasIVm515eol27MBnGQoOGIKO1jDdxhBF9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLha9285DVj7/grm5DMhOghm33y+WqnhAjlZVpKBwaE=;
 b=n0U/RwrxGhHyOnOhVhdImoo6yJ1wuoEarn7N6dQFru63kMO8OCpv67IOX79pwh1/JllS3xRAkILyFvYNX6U+w+hbvTcnt3XMgY4cfCm1BMBwPe86D2h/KiCXg7nN4zsCkGVg0VqW3vkZbRcfUwOCSYg/dDyu5Sjt36fk9I4NwJD0PFiGI8B64EAwfizrz9PBnSN7vE9Jy3VrbCGWYaQ5gI2YJFrjcQxRuiJr1/kmGnlWmVSBid5fPIW+s/BpzJ0KZ8WQv7sA+sP8SaqSPoE+SiztodhOIT81Z8AyEik2zrRmPUaCAm8JN0icONtn1NoeJE1gPRu7SSHoObKVExYX3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 12:18:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Tue, 24 Jun 2025
 12:18:48 +0000
Date: Tue, 24 Jun 2025 09:18:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Mina Almasry <almasrymina@google.com>, willy@infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Subject: Re: How to handle P2P DMA with only {physaddr,len} in bio_vec?
Message-ID: <20250624121846.GE17127@nvidia.com>
References: <aFlaxwpKChYXFf8A@infradead.org>
 <2135907.1747061490@warthog.procyon.org.uk>
 <1069540.1746202908@warthog.procyon.org.uk>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <1098395.1750675858@warthog.procyon.org.uk>
 <1143687.1750755725@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143687.1750755725@warthog.procyon.org.uk>
X-ClientProxiedBy: YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e0fdf2-809e-4873-d7a0-08ddb319457e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6AgfjJusFXxPQoqD+WyHjkifvm3L12grtITrjA3I4n4rTpe5Z0Htpm67G181?=
 =?us-ascii?Q?oaYwYj17D5X6Tl0/dtQ5KyrJNafOZJ4wIjS7rgFvGVQoh3Aw4FewRimLJqNR?=
 =?us-ascii?Q?DZRvLzkUEdCB5RDED/qjpCx8mXiudru7QKf2jtOZWOmqihbRBqeZjs+TrSJD?=
 =?us-ascii?Q?RgNGIAKp74g9t9+OA2habq/o0rp4pz85NsMn/uzBHNUUoNmRvcBWFDgJ+DJT?=
 =?us-ascii?Q?BDA+OMP/ZHkABL8xMm1v7+aGd1iQO4EY+3ejzNXGK8xADK6uFCO+LTwvdymc?=
 =?us-ascii?Q?bnRzQzA4sAF3TwFQitkfSsidpCSZUirOi15a5xUMAF5uTryVS9KtqvM0bl8u?=
 =?us-ascii?Q?qeKVo8OCumM4W6zldNo0VXyJ0o3oT5Z7Zj02XXYS3QnvOyHQHB5G/Fh2BByM?=
 =?us-ascii?Q?1sQr0iLCeljplLYZ5GPDelt1p9Td53Fwr2qRrENNZ0krX94zfqUtyvwHV3L2?=
 =?us-ascii?Q?LW0DWbxiKi+St4HGaFopToIEbXv74oJECnPs+fazH/n49MAkbNWlebr03fuc?=
 =?us-ascii?Q?Umy13/y8NaIJOnl+4cTpCWAX83CTIT6C5kwY1WLUCZ3+svdpRgtw+gHOagt0?=
 =?us-ascii?Q?FxZg55/JbEoG2o1ZEBBhwed/ELXkHGKvgw1MSvOQM303okgt29vQr01cr958?=
 =?us-ascii?Q?yym9+ibRVK+pOKAH7fODA3qOq/9jHPqBZ6RGLTNFBfcnkSn5xdupbIkGuCcM?=
 =?us-ascii?Q?svCd6nbaILWpaUwAxTerlxA+itvXpvHe8Q4ox2rTGpqa1zOoBFOsFQ23XaWU?=
 =?us-ascii?Q?hPUJa8tMourcNBv+sfjMclvYod71gcq8QNIFFYnhO0l4h4pU2PwNkMl3bsZg?=
 =?us-ascii?Q?VyF/N9ql7vBdIfJ22CRJp3Ox+22EWFlJm4CzFQpBgTk5ZSP+OBnKlxUFH6hC?=
 =?us-ascii?Q?1BckV62Ehakz6XUYBpggIDVFACIL0VcuLS8eBNmJa292MvBuDi9sbbafyYT7?=
 =?us-ascii?Q?UuEaXVA36YGO4Jo+du7mz3ecD6kZgUh9JwpAWBqj+aU5wl4PRTXtAW0ZS79W?=
 =?us-ascii?Q?RAspEeRkWvLt+1/KrDsZR8y+GKWP3iJ+Otq7Qc/2NDsCHnAvS3yTzT3XIouQ?=
 =?us-ascii?Q?mNNKes+ljkO4naCE3C0lriuPG9TNSX5DBXwzSFC14B1+/kqEpc8orH62KNYH?=
 =?us-ascii?Q?vmlailsp6GlrUTHKfrRJIiYa0ZTUVB/psxwmdoJcqVRYKpqQpVWPB4zuETSL?=
 =?us-ascii?Q?6daeeMm/nJVGty5VfpEFPJPz3CKRQfqkp6sa5iLoB9pNZxKVN0pN1PB2MpMZ?=
 =?us-ascii?Q?5erjlLFowVn14xmZrS39p/3nyCcXU1fDv+8PNQLBaa2s1rN5Go5A/8yrFRc/?=
 =?us-ascii?Q?TmPpqwGcN8z27pzXWl91F9m7iEhdvnLsSYqfmk8o9JGIUsTIspgAXFeljl4H?=
 =?us-ascii?Q?ga8amcwNEaWA7hytEkSnGQdzZ18lX3xkrIM5X3CRCprSy5Fx+LkDOh+u3j+X?=
 =?us-ascii?Q?u3Lt8HStgIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrauL5sTMNfAZKnBxcMSyHdCftAi4mDZ1EyUVKDIKsjO6UANIj8bOl009csP?=
 =?us-ascii?Q?6ftKvehLzF9zoTB5r3GeojhSfm/unsIVPctdHJ28MYd6VXTSfSVNxrXIgvSP?=
 =?us-ascii?Q?swyyWKWBocEY5be99RQmbFmhDTLJHBlazXp04CO0zb+Hc7fHuTQG3/Dth1i4?=
 =?us-ascii?Q?GEsVNG0YVo0Slh8OmmTVvgcjbil0NvnCsqgwS5z6FlEVRHoOUg09Y2yOQ5dV?=
 =?us-ascii?Q?e4zAAj8/VS1tWAJkseSo8LxolDoBuA+F/1CrimIlvjJ+/+Qoss+5BEJUEI5a?=
 =?us-ascii?Q?oinu3Y681b0DSjHiYhHyrM8ezfPbC8KdCYgtHtOXLxWjNP6F2PuzPeia1HJZ?=
 =?us-ascii?Q?2AEYjBrHKEBOPnhHaB/XQHoMR8hn7NNBZgfk2iVQfw4hqpgrjGqJtBYDllUC?=
 =?us-ascii?Q?+yye1pAycfqaC0KW/TyRr2Mjw2jftw1qjoFHfCZG6GVzVpX5opl7PSB8oL2W?=
 =?us-ascii?Q?7H7HL/t0yvdxK+EFakzpFEqepObzyxEWIHkjtO8+GpDbkT2v1XvEB4e/Wi8l?=
 =?us-ascii?Q?alDD5v3HJFJ4U8ZSbjXVRzHXh9IKa3kJtMcpOeWuPtHH6hdaAZxwR+WrH2Vo?=
 =?us-ascii?Q?vwhQ8tvo3dA7plUAeNei3CyRxVjrGLM55YMjhsGMsiwnfGRxRp4BOArslaDj?=
 =?us-ascii?Q?ngoLPhXbcBepm8FSVxilKnqkH0i7+T331bwW5Ej0tkI+2J9FM2ikyPr6insE?=
 =?us-ascii?Q?E9NJCu0Qm0ebBkCNbwr6G8hfnGsvMcqHxOcT4HGQVxWrWI/We7Ge+eM6hZhC?=
 =?us-ascii?Q?aafjZpjE3e0b60jbsBMaX/weHFTOcycDhMQoZiln4xUumfuidrwuehQLUvox?=
 =?us-ascii?Q?3yi6AIYGTtcMFqfmJoDGytuyhuB2LcM72R3LtT90WopSv0NdPDBx6gKxPsfU?=
 =?us-ascii?Q?cK6lHCsJ2Y55rooJITtw+I7Y70xblAGmmoiH990F50ccsgw8EZsZcdtofY61?=
 =?us-ascii?Q?19mZcDHctAAsiCR2WWCjqFczTUF7u9FjRiDlm7ERUFIZZEg8tVzCtfvXVICj?=
 =?us-ascii?Q?mR3s9N2J6OAPKA7DHbHWQX5vGeanznClNw8ImcXpZ/OymDS3fK5GZ9tpXYwx?=
 =?us-ascii?Q?WZndIVso+QOhSUk3l3iEzeeAQVg3AHiLCLzHjT4IQN0iJMAjUF3vmCg6z4Fu?=
 =?us-ascii?Q?zY83SXKASPytawboaHwK5qYwFHu0Y/W1FGQOvU1dkn3YvdMzzAwvAGBVA+U6?=
 =?us-ascii?Q?I+1EKCn0jkmkzHp3EBp3KwwrPQ5/2oosl1+bqqGTid+1W7qPj83FpX6IjipB?=
 =?us-ascii?Q?BJeSSXc65neYq3LhC6t0x+TvdesFw1XkRUJoiRXU/SY66htltJhW2Gq1F2Iq?=
 =?us-ascii?Q?mAmHOa4F+825EDDksK80cwqcy4APCKk+krFTMa/EcvSltadGg3BQ7/lU/kvy?=
 =?us-ascii?Q?baExxJtg5BtGUk94qK+f4vxs5ai3jZhyVeHi69LsHy0bsmyn6y5YzeBctAAL?=
 =?us-ascii?Q?BvM0l155jIhNkvdQMHLfyui/ZeANDehGCZqh9zNi7fs2UQMYo4PPxTOJbU1Q?=
 =?us-ascii?Q?6L0c2RkjfQzuUi/KfSnCheLONvcemWc+jcttfzFFbpb5SVzqZUA7kXxv/JKF?=
 =?us-ascii?Q?dRpugoxbNctZMk68CcY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e0fdf2-809e-4873-d7a0-08ddb319457e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:18:48.2290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhlDdHmuo5FZmOtXQ8+vWWKgyJRWFRWpG3oKNrlM3v6AlqhvDJ2KsqecejrqZd28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594

On Tue, Jun 24, 2025 at 10:02:05AM +0100, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Mon, Jun 23, 2025 at 11:50:58AM +0100, David Howells wrote:
> > > What's the best way to manage this without having to go back to the page
> > > struct for every DMA mapping we want to make?
> > 
> > There isn't a very easy way.  Also because if you actually need to do
> > peer to peer transfers, you right now absolutely need the page to find
> > the pgmap that has the information on how to perform the peer to peer
> > transfer.
> 
> Are you expecting P2P to become particularly common?  

It is becoming common place in certain kinds of server system
types. If half the system's memory is behind PCI on a GPU or something
then you need P2P.

> Do we actually need 32 bits for bv_len, especially given that MAX_RW_COUNT is
> capped at a bit less than 2GiB?  Could we, say, do:
> 
>  	struct bio_vec {
>  		phys_addr_t	bv_phys;
>  		u32		bv_len:31;
> 		u32		bv_use_p2p:1;
>  	} __packed;
> 
> And rather than storing the how-to-do-P2P info in the page struct, does it
> make sense to hold it separately, keyed on bv_phys?

I though we had agreed these sorts of 'mixed transfers' were not
desirable and we want things to be uniform at this lowest level.

So, I suggest the bio_vec should be entirely uniform, either it is all
CPU memory or it is all P2P from the same source. This is what the
block stack is doing by holding the P2P flag in the bio and splitting
the bios when they are constructed.

My intention to make a more general, less performant, API was to copy
what bio is doing and have a list of bio_vecs, each bio_vec having the
same properties.

The struct enclosing the bio_vec (the bio, etc) would have the the
flag if it is p2p and some way to get the needed p2p source metadata.

The bio_vec itself would just store physical addresses and lengths. No
need for complicated bit slicing.

I think this is important because the new DMA API really doesn't want
to be changing modes on a per-item basis..

Jason


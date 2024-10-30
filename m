Return-Path: <linux-fsdevel+bounces-33271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE0B9B6AEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9261F22A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2CA21892B;
	Wed, 30 Oct 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBqI5Vhs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DE218927
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308919; cv=fail; b=HAeEqQT0zHQC0Tfi/vmsuexzA3a5/TtzbD4mFUsDKI7CUYvBej80+GMVu/CCY8aw5ccxvo1tglVsIPSmroinb2lFThL5QLeaSNxp37FEA3pQLG7809BQyGEM5G3fsSod5KXBRhprkF4aIwWZYPvwwJThcbNXCMZR02EbnjUULx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308919; c=relaxed/simple;
	bh=VekeDEx9Zu5ldhJjOAaxZXhdgE3MadwV26iDaH4KGEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SKqa829wVLTKxRBMvw6Ty/h8qQqVzqNJvVCTkg+gWgq8EG5RE4nKqcqKWCUfvnPtACb6oTO954Boeng7KvUWae7LYiGAkC21xZPKFLr3zKbeA46qcM/cq1oStBxCGcGc/eP74FdIlpvHlZle/7Fm/L1nYnkhKRp9hdpfzFvHSEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBqI5Vhs; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyqOcAtsI3lpNXhc3UqbBdL/Kr4Um8dZVP5s3hyZpdArmE01ATux6H8xtc2c7tTD1+tQBadyXHbXMxeW6EsN69ZmsBiL62JxWRc9+8efUym0QQYh2aG+VaatjNtI8oNCKMtw0QObyhIlYgKBul8587nn0qG0wLxhDzICPXL5pCTMK4V/SJFJSuets/e6RwhVnVNEHIe5vief/3k5FHn+r1iK68rwkf3URK8g76La54Tf0s+He13wjRsGxssexO9TnQUfd9Dou+wr7zepH0z72yUWa/rNsNWA9o8Lz0Qy8N3Izlb18ZWmle6UcOXhv6OzL9LrdcXNSyCfb/qVIrnTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt9zF9rgwJyibVasIaU75jAOJchavSj4UGoIHNQgV+s=;
 b=bog01PjOgMO5o0NTYAfTeK0W33F0eVu/NQC+l0iO+BgcfWT0LNOM2ZOxlr6MKnSut37ylGNCQar6gJqGWNrXkfIAmRjM2fSc3hemhYO0AEe52VsI/CkNyaXHkSts5wWhpmoUJK6PPvw/rsWVYFWvo38Hx1DsfHeIfTAxUwUcnvt8MrDoqT/ilBV5R9wtn0lFdHQmTqrvlk3qfpttqgRIyw5GZY2wsT9IjITe5etuQr9mtPQAfFN6g+VPPyUalbXhcS+u1ubloXTH4dGRqefDXdtd9BdByNTQ/y4IawQjP1DNSZp5GIpDJrtrqwevwMsb1/8qoMp9IK5X87S/C5YUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt9zF9rgwJyibVasIaU75jAOJchavSj4UGoIHNQgV+s=;
 b=hBqI5VhsrtQYeuE6IZjjYEK0TWd5sLW602qrN7yboCrvbtZtlkCOpORa8AsrNqO43ltzfHrnA3awD6dwE6UVySuv8vnKa0lHv19Q0VHRYlsU54XU9JxW9GszeFMn1d3lgF3Ec1kB+I8pLVRSQZ51UyN0etSBa12GnwkFs6IZJFA/JZbEkXwsmRJSJld9Ui5T7Wy3E+Drjf9CrQYlWDLM+HPEtIsYaINXDp016xUpXIhLZdQ8QLCaFhvloT98f6IRb0y6T2j2RRZcApApPnDAjMxITY8g3YsXNbWN4TdeUrDJz5u9DZU0GTFJfdVCs4Gij9J0tYHNH71bCToHcLFUJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 17:21:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Wed, 30 Oct 2024
 17:21:50 +0000
Date: Wed, 30 Oct 2024 14:21:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: xa_cmpxchg and XA_ZERO_ENTRY?
Message-ID: <20241030172148.GH6956@nvidia.com>
References: <20241030131513.GF6956@nvidia.com>
 <ZyJkHHUSyVgO419i@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJkHHUSyVgO419i@casper.infradead.org>
X-ClientProxiedBy: LV3P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 663d0042-595c-4eed-a42e-08dcf907570b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eSSMWm2sNzuG9eQ2+HdF6l4l4LtHZwk/Jk2tdwjCWa/c+DOj1UZSFsQ7J75?=
 =?us-ascii?Q?QMHpNfo/SqWKr/jgGfVQ9xozOkenhrN2tc+xwohWiJh6f9yfrcEh/ElrE3zL?=
 =?us-ascii?Q?8OI+rrNDlrH19tCtx0TrpCFdGDXWm3umNJV/XIAaj3SmwYZf3++u4xsgwB8V?=
 =?us-ascii?Q?g4vqZZjQrqcVAYmFNBkA8HJqg88U/EYZMUPamP/jl+97U4egTs6f7W+DD+0m?=
 =?us-ascii?Q?qZyzPHxbDo5OExINJPOORehi1fRTnDTRkfOeOUKlR8LgGI+egx5aPwVqXZbC?=
 =?us-ascii?Q?iRoZzT5x3uJnwWFWQ6ji/flQdIO/IcM5asEbaPF5+3H9rbZzVUMuHvXMqm7y?=
 =?us-ascii?Q?CD0VCzgGlt5X2cWqdVL9fNoZOBw7SOfbcT9zgwGcqXJcAVLun8VaVFgLQC90?=
 =?us-ascii?Q?G+Wer1S1UOLsGhifBktQp3x7UHcriTDby+Idrn+q6cruHfC2Fivdj1dujMmE?=
 =?us-ascii?Q?jh5W+sAM3VgmYq1XmtglCUuLp3hIBqwmLWrXVyrhFpHZszGQsHpFxbC0AJ6c?=
 =?us-ascii?Q?wzS7MB3zsTNdksV2rW0KTTWTqywWpm+BmgodI++Gg8iNMgEpR0yrlRfkLNl4?=
 =?us-ascii?Q?oqjbuwbo4Z79Ugx9crmeJ5s1Kwkhsv39Q4oEo/JUvgb65fg8wahk9uz8Sy1b?=
 =?us-ascii?Q?C6rYqYmNIAVbGdY5Ht9mhekaccXtnfwXN+78Rj1l/46JrX6JaXvQ+Iy7ENcR?=
 =?us-ascii?Q?lEZLefBMpes6vKoiW66XGK8jfzR8TJVcuI2BrdsCFtrVjpcwxiowyHVbw/Ek?=
 =?us-ascii?Q?VD0+UhQC8r86NJ/A/rtImQ318hlibdnnWBj6M+D9WyZ/0hVrUlbkL6GH5KdO?=
 =?us-ascii?Q?9Doti6Vz+5kHkJDn9ATXijvKc7Nyya4rfNYDNQXHccbar+Yw7YJ57uQ3X++r?=
 =?us-ascii?Q?w3iqcz2wQJRFEjxrOeAeULXr6xrUNCRd9gWJnqeODTvHnh5WlSm7soRHMnmw?=
 =?us-ascii?Q?zLEiMvvVBUR3/moRZAlXOlaL4eAtlW/ongbsPQT6FVa7wc281uru/bDWVL6B?=
 =?us-ascii?Q?jd1nCPKjRlUgY/RJST7zfZvQp6rn2RxlzFijCW667MHjmfjfm/R7t1hzBg4O?=
 =?us-ascii?Q?j0SrHgjaVDiTnFg8q3eQSoo7LGglhsfmXNtJvMMBvvIMf1fo7WGVh+30WOup?=
 =?us-ascii?Q?I45NZ8hCAYTNggPYVuT+0NxizoM7sTgl7ti/nvcVSiwEd5D7k64XeCM+S/Qi?=
 =?us-ascii?Q?OqKMEJlKfzk66AN0L/5iJIfnphO7rUH7gK0dXUoIfyx6LxBNtUoYuJhgFK8p?=
 =?us-ascii?Q?4Nr4ejoFsGZGxEFcdC/kInsei/lpQgkwLx4ZFW10HGk91bvx42gOL1ru2vba?=
 =?us-ascii?Q?1jrVwnHpyZEbBOL4P1SpUcOi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?deTSdpmYUwlmXLB5GUTzUGCpTpTY7sLa24+Qezx8MGQRiH7MA+VvWkhI4xqj?=
 =?us-ascii?Q?Pa5wl59HypM1HWFmIXn+GjYCexeaaPvVRFW1J8+9wHso0uW/8ifc+c3A9Oxw?=
 =?us-ascii?Q?C29VtCWkGpnvg2611e1d8TiaxH0mqDvzRRAcjGI5ZRiiKwOxbiEHkP04bZ+G?=
 =?us-ascii?Q?ncHhCNb02pwVvEgCX8HMDJpUe5rw7pWIjyI5pTjW6ObebRuXL7udMCW1iqCP?=
 =?us-ascii?Q?uD5FagQt5Uqdte35sb/QUH4w827qDODGK/+9vkNH6i9q/O9Zonm9JW2pOfPf?=
 =?us-ascii?Q?G/fMOepkRuIeiWQMiwPPQ8mFlfD4vBuOfVe1PWe3EauZULZWbChvWtvXygST?=
 =?us-ascii?Q?OPjvN3e3DTnhD5hDpGX4k9DN1QOT5wsXyXm80lXKWqkorpNyegRpQqqy38g6?=
 =?us-ascii?Q?8pzXWTP6OMX5gccczU9X1Fpy1kpUzIJMGmb2HWcC4B0Ez3Q+gro/+Lkd9R/s?=
 =?us-ascii?Q?XxYoqUms2ZSC3JsHL4YwZMQu7BGc1O4X7vZCd2vU/PJ8n0xnBmKWiWvodBhY?=
 =?us-ascii?Q?nZTpRDvdoyp665eCCXXdXHmlIT2SZDUhlt1FCtf0BEk31RJLBbdgp5lIIMQ3?=
 =?us-ascii?Q?QBzX1P6X2sxkQZRAGSCEJZ9luXK/4ARMU0Op4rOCIH/vB5fPP39+YwcYQKeT?=
 =?us-ascii?Q?BEQ1J5lwGaV9ou7gzAaoiKWUJojy/Tc6gpLN0q9DhIINXVNwG2Q56xdbML//?=
 =?us-ascii?Q?y6BURj+QGLA2HRBqdMDCJry/1E+7hhx2UcNy8E8i1VFiA0G2z7W8hTpQWu8u?=
 =?us-ascii?Q?uKVGrB6uTOVN5phl5AkuZVuVGbi1CcsVx9ScF54Hdhr8Ig15b3u8/H5XxaFc?=
 =?us-ascii?Q?34tPFrOB1KjHjtBbws/Nfht6KeePl/6XYnbDBXCZSgVNuHCW6zP4ESTCTZGL?=
 =?us-ascii?Q?sbOnefHggTLr4L7dkUogj3D89mv18GF0DWWQYLNU57vSvJ88uC3prGMqah0H?=
 =?us-ascii?Q?Kol0NskIbMhm/NzcAS3QOYU4lClcxnSzXmiyLqY4i7vNMeBeW201Ou4Izlu4?=
 =?us-ascii?Q?i2GKcan3xzSgeAm8nbnXhjSrU1MQM3LS00hUj1LCDXQbT9N918TjqLJs0FTx?=
 =?us-ascii?Q?lHRYWolTtDrjEH0TSZRjkIggiLP3509l/9qrbjTp6rLps7ez6vrqQceJJIv8?=
 =?us-ascii?Q?bv/PNM7qQRMgLEUQP9mOzHid5h1H9sZLR6mnFgtVMTPmSwA6pE9rMwr8i0tt?=
 =?us-ascii?Q?jzvbuM/OLlqxQFMFZrjdX8zM/yL7xK90yWDoLQPHRqe4DX4L3HMNn/6NrCGB?=
 =?us-ascii?Q?8AiOQ7pWVEke3muI55EY2Wu+jVXda4A9VvMIWLMWrixIWUdb/h0l22GwZ/tS?=
 =?us-ascii?Q?Ox6KIsoEqGGZHHRq38El8geb4jI9VZQGkzL9aooELzl8appvwDIBkd1SRdLO?=
 =?us-ascii?Q?o67FFs58ze5qSqB01zeq+I3Vha52w9anvv6kKnXJjY8ogxb9wLFVyk2Z+CPt?=
 =?us-ascii?Q?tAP4mJWbYUdErCYpXIHc/HWCHiQnXOd2Ry7oQ1NBmeJlmtz2Ur/5B3U2uJWw?=
 =?us-ascii?Q?F/NKyGWqBfyKEwUNNXHJbis+aLlQii1x9PHOLBEEldpmk+ToEC5Obpn+x31M?=
 =?us-ascii?Q?5B+1T0vvCNsKjRZe9aM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663d0042-595c-4eed-a42e-08dcf907570b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 17:21:50.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0ckEijpO6kcAtdKJsNyRkXEo+iPwOGn7Z3xofbcxNwf6alVjSb/Bkz6jRJh6CsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

On Wed, Oct 30, 2024 at 04:51:40PM +0000, Matthew Wilcox wrote:
> On Wed, Oct 30, 2024 at 10:15:13AM -0300, Jason Gunthorpe wrote:
> > Hi Matthew,
> > 
> > Nicolin pointed this out and I was wondering what is the right thing.
> > 
> > For instance this:
> > 
> > 	xa_init(&xa);
> > 	ret = xa_reserve(&xa, 1, GFP_KERNEL);
> > 	printk("xa_reserve() = %d\n", ret);
> > 	old = xa_cmpxchg(&xa, 1, NULL, &xa, GFP_KERNEL);
> 
> You're really not supposed to be doing xa_cmpxchg() here.  Just use
> xa_store().  That's the intended way to use these APIs.

xa_store() also looses the XA_ZERO_ENTRY, it doesn't help to write an
assertion that the index was reserved.

> > The general purpose of code like the above is to just validate that
> > the xa has not been corrupted, that the index we are storing to has
> > been reserved. Maybe we can't sleep or something.
> 
> Thr intent is to provide you with an array abstraction.  You don't
> cmpxchg() pointers into an array, do you?  Almost everybody just does
> array[i] = p.

Sort of, what is desired here is test and store, not cmpxchg. You
would do that in normal arrays:

 if (WARN_ON(array[i] == NULL)
     return;
 array[i] = foo;

In xarray it would be nice to do both those under a single walk and
lock.

Jason


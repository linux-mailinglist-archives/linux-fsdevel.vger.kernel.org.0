Return-Path: <linux-fsdevel+bounces-18987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E08BF43D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 03:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811651F2444F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3AAD5B;
	Wed,  8 May 2024 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCIV4nQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD91A2C2C;
	Wed,  8 May 2024 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132827; cv=fail; b=itGWH//4roK53+JwkJcUEr/ybVbcsJLRGjpxhWT/h6wEoG880U80X25RGa1PrQcTqbkAbizyfMPnUi44t81SuF43JDIYd0raIuMJlaqu8pdE5r68uIB89H/XfxyyCwZmC+S/o1cmCqlc47+GdmVojiUGW3QzOouok+Xr3kGD3HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132827; c=relaxed/simple;
	bh=AoFemJVhgvr7RCKtRZ+HhqaDfagS6t4vhvRfs8405Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K6MPnVJxFp0mFKQ7zDDfWszp3VSIjGbninWvAOq5lL4C+zPVJ972nurwsY4F7+tse8p/+nMAhc6TFHwo5wwFUgz3Psvz9v3qZGn2KNce7Rb0iVP3kKbYCPwUn9l3Ny6Xvzh0wVtHtzy5OVL4c0HrhzcE5bSq8VCdCvMZRV+2m6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cCIV4nQV; arc=fail smtp.client-ip=40.107.15.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dInLO78QOtu3gKyZnfhfVCmnORCmvfPUi/d9ons5Fioh6+IqdO4VSkv5pLaOdLhduDmGlO0Kk+RhZ0fP0Es6feP2PVeMitZAOhurjzsvTqX6XMiq7FM0oubA1YTBNFcR2OJTgS8LFvvl0u6ZHQ2gC+1ODzhseiIUimqY9o75YQhjDrg2TosBcCHwjkC6Qu7NzGLWrjV/XHBbHkzzreM8aQbW/YlfIjiPb+m8JYN1DBQpY6zjvDErUI+AOaUHNOsd4E5naxNmGeQ9A0/x8To63Sgk1qFUxu7P3C5/EE3+PHjQgofvHsNGOanWUWrI+PCkVIszRt5FkAx5NSlyE4vnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBYU46RcLvS1f32cxESVSbvTMTukTRSwZfe8RXp6P0Q=;
 b=n3m1H+4d7mbm69BNv3KAfEcDZjSW/Q6Zd63K5KHZeYNXCjbT+GtWgmXHPXuZ431CtCPEhAT2D3jojYmUqTHnckw4YsQyXUV/1P+tz3oStblb+WrkQbRVZleOCwHUNmydvWzpdML8/Sxzs1RrseK5xsa1mbPj67E7X0y4VZp5Pkxx9Q6GnkIbQuD5OCExNMie0Ja42hmoi05lIocN9EnuaC+QietwTAXslL4dUUKHMKb4JUuYuNVxbP9FAZLyA+DQ9Rsk5/qgxt47yRYaGEOqaTDTnTETB7s4fZVhiY2hDrK5gee7lW+HWCofcbtaDBRtcdc5o0STuYBT1LJ7aeAvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBYU46RcLvS1f32cxESVSbvTMTukTRSwZfe8RXp6P0Q=;
 b=cCIV4nQVT8fi9cqSJ8zZCR7McgRuVTJfqz/nGigXfdKq6g4jzP3vc7xTA9T6KEUf64zt5MhPrlvl+IzhuzmPKfK9UDPmiebuY8Zx82Vv8DW6vbA8LDVSraQfRClcAj/Al/wVPvMiq+fIQfaPuZSAek40qPKA18C58DSdof2JGuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 01:47:00 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 01:47:00 +0000
Date: Wed, 8 May 2024 09:45:45 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <christian@brauner.io>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>, jun.li@nxp.com, haibo.chen@nxp.com
Subject: Re: [PATCH 5/6] block: use iomap for writes to block devices
Message-ID: <20240508014545.mf7pexpctfl44pq3@hippo>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-6-hch@lst.de>
 <20240426103727.hzzv4hv54an5jzab@hippo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426103727.hzzv4hv54an5jzab@hippo>
X-ClientProxiedBy: AS4P195CA0031.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::10) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a3f267-91ed-43f8-0694-08dc6f00c09f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRey5c0hNpyVqTq3xdKG/eDHAXHp1JZxovYU545vQWTPxtvXFJ1Gx7gK6WkI?=
 =?us-ascii?Q?DGdYYhR6NrNIeCfQqdB/aGg2yO14/5TFCHmPIQZZATzsydMsmwS7UxH84Qf6?=
 =?us-ascii?Q?/OGawvongnyOrAhqNDUZAiIESoZWSETLNjmM3q5PNFhOSROvlpqzLRu9euyI?=
 =?us-ascii?Q?r5U6L42l2Boh5vjlQwUOKSQyAURavOdGS650RVoG4RxeORY7uKDunkVnEUM0?=
 =?us-ascii?Q?M/O3o7/pBxikSsfT4q2gbZ4gh8rz8QhPteDU0h78ypgWmgPsWHQn9rQFB38Z?=
 =?us-ascii?Q?DC0JivJ3wy1xv7WbZE8OiM/8Naix8CKAhyb4bJQcIA5u3P0pW0t6oPH0sugd?=
 =?us-ascii?Q?QQOryk4/Q/B71ZEw+jpWSqHUQu9mxDPdRjsjmu4a4OCaRf48UNpxMwqZWeAH?=
 =?us-ascii?Q?QgmE/Wus2jvyPlRARkuTGepMGTraoWFlbdg+iNb+2Rg/aJt/FZO14UR57jCS?=
 =?us-ascii?Q?1pMB9E5uRe9GOmA5gciMlnzje3lAwG+Lr8AgJ17zm1maPJBPT8esGyxMnm/m?=
 =?us-ascii?Q?S/Bf/P/QxO2ywqQfH+oDbosyTAgsxVpsg0DMGHZ/RhE2CEDKKarHaAfvFi3h?=
 =?us-ascii?Q?eFiSKsj4LvrFfxSSommjYvdaOlv8HSTjRxx/DYdGESpmoFFrrtQhhuRcphJB?=
 =?us-ascii?Q?3AAnyxFsvFdyrQQ7Jw3HKGxTuSf+ormxJqktkYN4B7wBrXETGT+lmKTD1tDl?=
 =?us-ascii?Q?Yasf5GHpSR85i1SvM0MX9Mk7F89CXyBXcX5G4P9tJugxvIRGnGOd6ZBsIxEF?=
 =?us-ascii?Q?NWAxYmT/TFFuEzG/Grr1OAWN2QDfuMqWVxAE4Z8G78CqITNcTEd0Ooi/bqt5?=
 =?us-ascii?Q?AhRRhjSgNHQ2lLjaGjp9giEyPCIuuQol1gwFhltMoJSZux/Zw2CkO7wnX7yp?=
 =?us-ascii?Q?8Aev6eaSpWsHLTw4lJZLdM0TQY1XtjLKgtKCKWEYHsbu3kkDTJCZYf1y6nXo?=
 =?us-ascii?Q?WzJsrBdK/wM7GgMl59eRd0kLFrCK5pTbcKHWZ6xoXDab2y5J2AK92sxKsm7Q?=
 =?us-ascii?Q?3rmcc+bQR2ojHEiOMbi7bQhe90eebzeAdhRSoqwLXsCozSWFhiN7n0UEIFt4?=
 =?us-ascii?Q?1wXaf6wwUS791roZtOXeXa0LAGGPsOAI/NFM6YL8T+YyAJiGSjpMnzrmjDEc?=
 =?us-ascii?Q?MMLNIspRjhQZqFgAm5hj2mPUznrtoBWSCHCCRDPzpmC7LxJfvSPp7mxMDaMK?=
 =?us-ascii?Q?17U11G35qFoIsDoJ0F3FchH7S5ub3TIPP/1qaZRDaaqo8iYLEYAbDtwBcGTI?=
 =?us-ascii?Q?DG3PLjf2+0A2rWIiVcuSf6TeHa41IHo4J1CbQ5Qrm8x5emD9KmONWQ2Mzs8w?=
 =?us-ascii?Q?22OYtKUJSpVAwsA3j03VqhEU4JHX9hyO0ocrMPFzCR5VOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rt3/TkLxLa52IOv9QkdHBOsryyYIgrH+Z0myHQ74gCs6G/07UvNp90isDCrX?=
 =?us-ascii?Q?D12a7z7Wwd8/UC0UynmStUpg74Ca7o3m++JHvIegOg+RpktPLqoP1z+0lFlm?=
 =?us-ascii?Q?v6opp2O9C5upsKCo1m/Y+fOke5cowwAo8p9zhCKBdR+vZQv/PRk/c5MzRJfg?=
 =?us-ascii?Q?H3NaphdUD4kfEoHVJrupm91dx0smYnMe8sSo5xQVTPA9rqATD9yYRGOu9W8Q?=
 =?us-ascii?Q?sdNkqC77zezdROmPhBg0VPam4Q6iR4TskdMdL4P1rhjQcnmQJ/9fMMXWaDHs?=
 =?us-ascii?Q?c+w+0qIJSR0k/vflAVnIZOFAfsD3ZJyuKoKdUJY9xfAfbtlo5WpZnLEjTgq9?=
 =?us-ascii?Q?Jyk6YTJZerNeISsBtH27ym6t3pF7Po+we1LQAyxfPD4q+CJu12z9tryMXG00?=
 =?us-ascii?Q?dLclk/lioHxSQb4ZGSRxfypq0oCxMp5PUH71D9LolJQDTUL/PB4CVuDQKiEy?=
 =?us-ascii?Q?aMucQM2XLeUt8CgD8/d9TrKCgylBneLneeDu04nkX2xlcVXu+GnMuZFToyvO?=
 =?us-ascii?Q?j64cv9cDB8UH7/NvXEVaFhlE/7oeAI0lZ2RMklWWIxHvQCwP+d8EJVcWdsR3?=
 =?us-ascii?Q?r9JgZ6VgUI4j8jIiahTqwaJIDrbMCa9H56VpiO5ZTv5LswLLGYiKvG+sZaVB?=
 =?us-ascii?Q?Coh+gQbbvDt4BNSih9Ybbp1fpgjie3JnhEjajnGiL6Af3uT7Yqi5HE/lYuOE?=
 =?us-ascii?Q?NkebrqVwI8nWecOB6TSGrzzyUVS/uPoK/xJNbOXoUxcj7I3vlp8un7kLJGGz?=
 =?us-ascii?Q?EA2ChG94hbEnfdsAPoAA/FbSv0TSyVbPnQuNZ74xC2cgoat1VyIjOZ/w8yAv?=
 =?us-ascii?Q?K04xBifHv0D0QIiYDmsY1NBBi26mzJdjv0ijEOR7UUvLqR18LlLIQ6T+Ievn?=
 =?us-ascii?Q?5k/Oc1XrCshgkTrXz4AqwYNjgTpI1vVt3ZihRDGDy5otCiTTP2vatquzR1b1?=
 =?us-ascii?Q?vDQ6YPzdRSARykmm+H5ITNKMBvkwUDXRyaJjCSsJ3c4VPx8GlLkmYAnBPqZP?=
 =?us-ascii?Q?i9HgD8K4cGHOTkdSlPez935E092YRmAT2rQa7YTRc/xOYausvkiovzlygeb1?=
 =?us-ascii?Q?4N4jK7zaFHo7XRtdtTyuoh5Q0xDQpExGlMhNPkgWRJNsbDI+UdET5LR3GQLa?=
 =?us-ascii?Q?rcfE1dP9KlAMIYUqsjyCXBMT2GL8w3M2f0GmcWPeLCooULJDW6kTDEGX5tLK?=
 =?us-ascii?Q?Swy9+HJZy8uUyTuxPocmJWtbVNY2sigZ9i1887FhM3We1/BjU15L4B/EN2jB?=
 =?us-ascii?Q?6JlqtKbcpkqG/ySGmXHCMvsgApAYlRwS7MrArIcB4gCPnkrHtIyxn2E1AuK6?=
 =?us-ascii?Q?NfUNjjVwagUaNWYnmI9mAZ0FhJbU7oAAfGytf0DGDYaGl5KbUK73fCWDlsYR?=
 =?us-ascii?Q?mLAPH7t7Z/X+CHVZY4bT70ET6GILlkL8m7nwwjrSOmzt2DFWACKCHjRFvdXj?=
 =?us-ascii?Q?DIBmqPh4vGUNf80UpZcH0DlRFMU5clAMs7/oDKIwvqiJVxSmayNofX7u4bFR?=
 =?us-ascii?Q?Utu6OKfDlCHOk6UjeRDqRTxfMddZS2hnhI3xGZcsUnbTYNkqnq+KDyvrhXAS?=
 =?us-ascii?Q?RqFgc2GVXQsbuurVKtuFzSUhsMIIWbgIcPAIL/6q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a3f267-91ed-43f8-0694-08dc6f00c09f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 01:47:00.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJoujG8j3qKulQ3GjKDQDpi3qske2C5f64DMklRNX+XddggvLBUNYku980GkpG57SHJeMZHrrsjEh0jy6RqsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

On Fri, Apr 26, 2024 at 06:37:27PM +0800, Xu Yang wrote:
> Hi Christoph,
> 
> On Tue, Aug 01, 2023 at 07:22:00PM +0200, Christoph Hellwig wrote:
> > Use iomap in buffer_head compat mode to write to block devices.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  block/Kconfig |  1 +
> >  block/fops.c  | 31 +++++++++++++++++++++++++++++--
> >  2 files changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 86122e459fe046..1a13ef0b1ca10c 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -5,6 +5,7 @@
> >  menuconfig BLOCK
> >         bool "Enable the block layer" if EXPERT
> >         default y
> > +       select FS_IOMAP
> >         select SBITMAP
> >         help
> >  	 Provide block layer support for the kernel.
> > diff --git a/block/fops.c b/block/fops.c
> > index f0b822c28ddfe2..063ece37d44e44 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/falloc.h>
> >  #include <linux/suspend.h>
> >  #include <linux/fs.h>
> > +#include <linux/iomap.h>
> >  #include <linux/module.h>
> >  #include "blk.h"
> >  
> > @@ -386,6 +387,27 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
> >  }
> >  
> > +static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +	struct block_device *bdev = I_BDEV(inode);
> > +	loff_t isize = i_size_read(inode);
> > +
> > +	iomap->bdev = bdev;
> > +	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
> > +	if (iomap->offset >= isize)
> > +		return -EIO;
> > +	iomap->type = IOMAP_MAPPED;
> > +	iomap->addr = iomap->offset;
> > +	iomap->length = isize - iomap->offset;
> > +	iomap->flags |= IOMAP_F_BUFFER_HEAD;
> > +	return 0;
> > +}
> > +
> > +static const struct iomap_ops blkdev_iomap_ops = {
> > +	.iomap_begin		= blkdev_iomap_begin,
> > +};
> > +
> >  static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
> >  {
> >  	return block_write_full_page(page, blkdev_get_block, wbc);
> > @@ -556,6 +578,11 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
> >  	return written;
> >  }
> >  
> > +static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops);
> > +}
> > +
> >  /*
> >   * Write data to the block device.  Only intended for the block device itself
> >   * and the raw driver which basically is a fake block device.
> > @@ -605,9 +632,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  		ret = blkdev_direct_write(iocb, from);
> >  		if (ret >= 0 && iov_iter_count(from))
> >  			ret = direct_write_fallback(iocb, from, ret,
> > -					generic_perform_write(iocb, from));
> > +					blkdev_buffered_write(iocb, from));
> >  	} else {
> > -		ret = generic_perform_write(iocb, from);
> > +		ret = blkdev_buffered_write(iocb, from);
> >  	}
> >  
> >  	if (ret > 0)
> 
> I'm testing SSD block device write performance recently. I found the write
> speed descrased greatly on my board (330MB/s -> 130MB/s). Then I spent some
> time to find cause, finally find that it's caused by this patch and if I
> revert this patch, write speed can recover to 330MB/s.
> 
> I'm using below command to test write performance:
> dd if=/dev/zero of=/dev/sda bs=4M count=1024
> 
> And I also do more tests to get more findings. In short, I found write
> speed changes with the "bs=" parameter.
> 
> I totally write 4GB data to sda for each test, the results as below:
> 
>  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)
> 
> When this patch reverted, I got below results:
> 
>  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)
> 
> I just want to know if this results is expected when uses iomap, or it's
> a real issue?
> 
> Many thanks in advance!

A gentle ping.

> 
> Best Regards,
> Xu Yang
> 
> > -- 
> > 2.39.2
> > 


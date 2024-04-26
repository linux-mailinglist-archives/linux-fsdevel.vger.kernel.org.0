Return-Path: <linux-fsdevel+bounces-17883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A558B3568
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B8B1F217D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBA71422C6;
	Fri, 26 Apr 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L25S+PJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2221E877;
	Fri, 26 Apr 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127923; cv=fail; b=mhiEXrvMRaKHS64PdBnNK5xRxKQlAgobcKdjusDhyFoRadrhdcdidCiHHfJm288w0HMGXNOGAxUEybmL54uZOJEf2tXa0lnTUB5LUJix6eNCuFoyjSqybR7FTRN4ttjTCByvuReDbBXgrKCT4sB3aZQ34wPPIWg9ISH34y7H/6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127923; c=relaxed/simple;
	bh=wmIbirnRBrt7VY59K55N9jSEqNzRALmqP2FXX9eicPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDUPUVJ8Z6vUx9nn7oth9amDeBEXFTYC4XLhNQK6YzV0xmCVByimURg4n9QqF1z5Dra5EUN0mM6s18d4GsywfzLQbVMp4lbEU0pyFxAextbIKoqdnvcwf8AGdrM+9mPDVF8mxvotcYok2hlOf3fteb37qrEuLPI8FNj0XVTkBFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L25S+PJp; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qihwog+zDQipEtGEoXEms5GQGGun4TD1fGFHU+JWHs+aNAhhh81/B1foWZNVf49IwzjLMnm9owhQL27J/eyW7MQA3DyduB4DbCsLI6CRxNfGZ+exHHdu3NBAqPnoFuzgdH+rsKNi73qzCrqfVArv6BzZ7DA2c7h2voaa4P8HcqRHqbkKhLZWdYDbxD+T5HbqdDZaz8ail/8TU+OOihR2esprc9HwupNMy6AIHEjL/sulmV/7GIvj0C87c5KFs/LmqmTZBZ5q/vsDHIkMtrEmhXTKEjsxMm4J1HeW9LTlIkMvb8IFYSwW5HKHT9vauzA6feEjseuQftaOXZPWsjRM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhuaUSY0UZyULuTPqx0nqwxM1nGUQV6W9C/w1Xlg9gI=;
 b=dIBcaM8n/tyfpFmH76TbXOR2wri/7awkQ59kwMwAJZ0cnNkEH/StqTHwe0cJJlG216EqXT7H+xI4w60XJdlbcxSp5uH4jZ58IghYoT0sMk36GhBNCprJaZSO/VmrkIOwPbeV8tS/cWfuniTbkd/Z0wzUmZAPd3VcRsu0ZW2ENJirO5m2uwqR/PBl/VJgAQ+rYzBf6DltUqkprRFZ9l7fNQ9LxUVd6Xfhst/kTsyah19x2cvkJ70Mfo5VqWkcqSEWdXEablHy6ixQM5dppP9Hju6jGpxOuoTLNZKm8hOlEYaZTKgFB0haYCrzwiYPGbXLXNP2NzHMa+tUynjr8v8uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhuaUSY0UZyULuTPqx0nqwxM1nGUQV6W9C/w1Xlg9gI=;
 b=L25S+PJppWK/u4dQKqTMi+C2iVKNARnkPVbDDNf0IMhIhyME4QhKkoVTa3ACp+llU9+S+WUbATk/anmcD+7DJVbN7yudS/eKqzd0R1ch8IEZcC/j5ZdKY3m6OOtJkK9N9w1k9Wm6LkskoYQZzc7I1un5QlEmk9267ew6/I8GZzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10225.eurprd04.prod.outlook.com (2603:10a6:102:467::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 10:38:38 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 10:38:38 +0000
Date: Fri, 26 Apr 2024 18:37:27 +0800
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
	Hannes Reinecke <hare@suse.de>, jun.li@nxp.com, haibo.chen@nxp.com,
	xu.yang_2@nxp.com
Subject: Re: [PATCH 5/6] block: use iomap for writes to block devices
Message-ID: <20240426103727.hzzv4hv54an5jzab@hippo>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-6-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801172201.1923299-6-hch@lst.de>
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA1PR04MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: a93843b7-c9dd-4eec-8575-08dc65dd0815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NlMoacFOfNiXYpxeMyPCw2/8LxU7CZcGoua5WHKoNYMBOp8aAT2WpZJBPaNu?=
 =?us-ascii?Q?xthdB15W2LSx3e1vyeqvMAPB+zb1cz5YX6SFVT5OwNJ7ZOwTRDT9UtBOgbnR?=
 =?us-ascii?Q?8Tm911Zq2HAdmhfPsPlqTTaxl31iEm3mly5ydgiRHxIy0yU8NuUGjbjXWlrg?=
 =?us-ascii?Q?AVtQkRwFyNNxDn9o6hkxPLsnLIxARz3IKz+uMGY4J3odCbwK85gBgktHyN8X?=
 =?us-ascii?Q?iRA6DFMkR00l1ow4J6fe5C4Dlp9Qh4ElaxNgeyoIOGF8xMNIHQ547+4a+cf+?=
 =?us-ascii?Q?cN1SJ7i5qYqivv8F/ChObuvW+NvDPDlETFGXX1Yi9PZTFufLh4BnWpwZglFW?=
 =?us-ascii?Q?WtVuvm4OT/30yXU5y3lziaiWx+1ixHZoxyjcg5iumLiVg7KLfDmAI62YqOMM?=
 =?us-ascii?Q?Bq+WIajGqcBim0jEnGiFLafH3T/Qs5fVKnN6Sq4QvOjucsr+eDKGJafCyLf8?=
 =?us-ascii?Q?VjhVB2WpfFRRWe5QrWBeActwzYh8nIKovSqpzhpFhF9xQy4LR1UUg7rTNRUo?=
 =?us-ascii?Q?LCTqYFClqo5/6Z0Xf0YRASkk4Hj02Ly62aVHcN1v5mp170mjIcsBZgvxILaa?=
 =?us-ascii?Q?auAgqJmCoL4jVVb0wt1oraSgCGoz1JK68lBl50+VLtAYNw7KCuEQoqurpI0D?=
 =?us-ascii?Q?aZrVL9JPuWnx3hNGVn2VlqpDq9QpREeV67zX9E02Q1O4v7j8zQ72Ek/PTKf8?=
 =?us-ascii?Q?4M00wLCZQbHany+O8mE7e57rWfwggnJFgCP5r3UJGfvWfBwm2dM43bMrKdTZ?=
 =?us-ascii?Q?fstlRAm2mJQeRLffygyB60H0KYDb/JjlkVO1EPihhhFtCsa57J1vxJNkjz0N?=
 =?us-ascii?Q?LMY82mfRpnBinuJ0lGjGYPjVJjCIzfq5kQCymjkujH66Di650sXfZRwwsANZ?=
 =?us-ascii?Q?kDPck2wLtmFi/cYqSVZvlMGLF36ssJn2C4U9/EnoDF4JKFeaaIzuAPwDbhU9?=
 =?us-ascii?Q?6VEZJPjRTUIP2NHQ6wLA2MNqQBASA+EvRYNOOuTYS2OfKFfZkSCO9rLUYDa+?=
 =?us-ascii?Q?P8YVqQLoHPGR9oWZ0xVuCicS4JQbqzElN1BYNt9+M2Z8OjmFEfXew2j1puNE?=
 =?us-ascii?Q?mgsFYKBv5EZlL61lKQ4idizbmDlbJtwQINAiJ9wt1FNTIEM9BsqU4DufVLVH?=
 =?us-ascii?Q?pCKAVS29KgDml5rC8CsNFNr8lRcOsGvr+LDhYHWpm3FnNyJpTO+9xRJ3+bsi?=
 =?us-ascii?Q?9fyOjVEjiq4zVhHUeXcKYnrXdLfd1hJLSUlXh6ftiT2yb2V5v50MrU5rF17r?=
 =?us-ascii?Q?IuZsGtLzhfuFkPJMWCW3VwAXDeuB25hIKvrTGM7peaUtjdCHHy9eZ1ZH7CQg?=
 =?us-ascii?Q?Lj3KdwRmjxyzV03Sow9n/7lJoCGrJMjYF/g3NHEGVHiByw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+s5R28qC/b1d/A/K+m8jq+1usTl0XXrdrkP+soBw1aOSaKSj71yt+lX76Ix2?=
 =?us-ascii?Q?9JgVD826bJx9fnWAo3Nt1DS1iDH8GpCpHVYGS3GLiL+nI1NJzTp3o6NkYCjX?=
 =?us-ascii?Q?AebsRtj3dIReUJXT/ZsGZOST/WbVIJgH7mMEENkdknQ0Q8vb8Go7ahwiAlmj?=
 =?us-ascii?Q?lrs6Z8LVXpW5d9zXstRu7+wjIc9qGoj53wRJprJkq43A+65iWJ4kWJFu4Jy+?=
 =?us-ascii?Q?JhXjgKhSJ4Y236UZXTXRSgEdTEV3ml44RgiJQUABfRqeqn+jk2vV3i4gVf39?=
 =?us-ascii?Q?n0rDSaAe+hW7ewUFOlpJT8nP6cqx50FlUPLnd1POFs6VMx/5s9u8tG13utmc?=
 =?us-ascii?Q?zNhwTuepCKJRm4FO1ansfiVgfCfKV/FIp/+DCKteOTMASZBQPqPlbXJLE0YL?=
 =?us-ascii?Q?87Y0sNAuXj9LGtcbykMlyG52+OOCK4tzS5W3mwSLcXvnupDtDVgFJ2OlvMKO?=
 =?us-ascii?Q?wB8/ZqojgofvJlOPvjV37x5+GtR3fWNy5AAOw2qfgU15uzcVACShGcpPhLLc?=
 =?us-ascii?Q?cotTLaZV8yBwdJGHj10FrEX8cst18JESMjAvYzMUGP/yD8JhOuDCRF4mJNtf?=
 =?us-ascii?Q?SAJAT4h94MfddBmd8kKzz1WPCzdqYjL5ESNu2siw417jiApqeIHzgsj02OdA?=
 =?us-ascii?Q?iiquNbPLm0fM4Kg7SZ8cBr5y7c9MUo5BtKtKou4ibvkPrmW4LXy+aqkd38Po?=
 =?us-ascii?Q?TKZ1jotkaqZEK3FEatq4e14oGERk+uzvYTInHXYfNZvsaLvz2QlBzjipLr7P?=
 =?us-ascii?Q?FMrTh1hlSZvDyEHJQPozntRRFo3asPbkh1VFlXSmwnbSyvuQJaxL8sIUp7gn?=
 =?us-ascii?Q?NsIOExdtL//HTEv+v2XAy04Jp7rg5q4iz/fuDYvA3nnGanHaYJJPFheAyrt3?=
 =?us-ascii?Q?XiMh2oBS0qKbXkAv3Xcyb6L+UAyUZk4XTwCfsGe7sAKEJfH+qobwLf7Kggr8?=
 =?us-ascii?Q?UO4zYKAc0XSa58vBHnq7GDngTAbPebxsYK7T8CCRztZok4W5j6c/89jvd7V1?=
 =?us-ascii?Q?Tko1R1fPQyrSBgi41XkoFjpCxYI91+PZRno8E5H5kWqvSKfe/5ZTFqEtAQKU?=
 =?us-ascii?Q?1OrjbufanoU5L7U1i9hxhNxyK/HVINxnzNelQ16u6r5dQoS6RS96c+lgBgQH?=
 =?us-ascii?Q?ai83fdHo2tl3wLnztVT9GqWrFgexMEXvu/Z779mzM5HzDr7s1Wfg3KeOQUlx?=
 =?us-ascii?Q?KmrAkVu45bKzj2tPxoToYsCbkHLVgagXaJvKLg6XgZ/C+763VwqZ+P7aC1gP?=
 =?us-ascii?Q?3099oxsa4okq23LRqKuAoZMTu/QtNxLcUUoLL7kbL0lYW13o7P2bL06gSJ8L?=
 =?us-ascii?Q?UC52N5H02uPlyeBIimRpXiM6BhfxaZc1MuDY3FOdBdXzdxFTMcenHF4r9xEg?=
 =?us-ascii?Q?/weV7Cgnx4iwenjZQ6sZo2jCWvHY9gaNT+LHNYt1vttN9h0U1neXbbl59NWI?=
 =?us-ascii?Q?03RehLdCwu7msiKFGYLJA81jsQ9r7+EISBPJ/S8Bl8ru+W6UigE/2QTNhmza?=
 =?us-ascii?Q?WmXi78/8CgJrKbKKfE8amTKGdFXOGi6EVdt1btcPEAmr4mIDICKZ04Up2Od9?=
 =?us-ascii?Q?UsnujzoRpf03b1TQ5AyRJZSQ/s2RuWUC6RcQw3wp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93843b7-c9dd-4eec-8575-08dc65dd0815
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 10:38:38.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z97VJEY756hBMEmO7EwYtHN5XZnVXSsfhhnrxQjrNVnXI1RXULwNuhAgW4UsT8i3Zfyyk4FKOxGDrlwePPSmnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10225

Hi Christoph,

On Tue, Aug 01, 2023 at 07:22:00PM +0200, Christoph Hellwig wrote:
> Use iomap in buffer_head compat mode to write to block devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  block/Kconfig |  1 +
>  block/fops.c  | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index 86122e459fe046..1a13ef0b1ca10c 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -5,6 +5,7 @@
>  menuconfig BLOCK
>         bool "Enable the block layer" if EXPERT
>         default y
> +       select FS_IOMAP
>         select SBITMAP
>         help
>  	 Provide block layer support for the kernel.
> diff --git a/block/fops.c b/block/fops.c
> index f0b822c28ddfe2..063ece37d44e44 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -15,6 +15,7 @@
>  #include <linux/falloc.h>
>  #include <linux/suspend.h>
>  #include <linux/fs.h>
> +#include <linux/iomap.h>
>  #include <linux/module.h>
>  #include "blk.h"
>  
> @@ -386,6 +387,27 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>  }
>  
> +static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct block_device *bdev = I_BDEV(inode);
> +	loff_t isize = i_size_read(inode);
> +
> +	iomap->bdev = bdev;
> +	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
> +	if (iomap->offset >= isize)
> +		return -EIO;
> +	iomap->type = IOMAP_MAPPED;
> +	iomap->addr = iomap->offset;
> +	iomap->length = isize - iomap->offset;
> +	iomap->flags |= IOMAP_F_BUFFER_HEAD;
> +	return 0;
> +}
> +
> +static const struct iomap_ops blkdev_iomap_ops = {
> +	.iomap_begin		= blkdev_iomap_begin,
> +};
> +
>  static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
>  {
>  	return block_write_full_page(page, blkdev_get_block, wbc);
> @@ -556,6 +578,11 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	return written;
>  }
>  
> +static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops);
> +}
> +
>  /*
>   * Write data to the block device.  Only intended for the block device itself
>   * and the raw driver which basically is a fake block device.
> @@ -605,9 +632,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ret = blkdev_direct_write(iocb, from);
>  		if (ret >= 0 && iov_iter_count(from))
>  			ret = direct_write_fallback(iocb, from, ret,
> -					generic_perform_write(iocb, from));
> +					blkdev_buffered_write(iocb, from));
>  	} else {
> -		ret = generic_perform_write(iocb, from);
> +		ret = blkdev_buffered_write(iocb, from);
>  	}
>  
>  	if (ret > 0)

I'm testing SSD block device write performance recently. I found the write
speed descrased greatly on my board (330MB/s -> 130MB/s). Then I spent some
time to find cause, finally find that it's caused by this patch and if I
revert this patch, write speed can recover to 330MB/s.

I'm using below command to test write performance:
dd if=/dev/zero of=/dev/sda bs=4M count=1024

And I also do more tests to get more findings. In short, I found write
speed changes with the "bs=" parameter.

I totally write 4GB data to sda for each test, the results as below:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)

When this patch reverted, I got below results:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)

I just want to know if this results is expected when uses iomap, or it's
a real issue?

Many thanks in advance!

Best Regards,
Xu Yang

> -- 
> 2.39.2
> 


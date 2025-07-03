Return-Path: <linux-fsdevel+bounces-53770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2B8AF6B27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 09:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9392520A26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 07:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E723B295DB2;
	Thu,  3 Jul 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="eLvzhxr/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2108.outbound.protection.outlook.com [40.107.95.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51406295DA6
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751526679; cv=fail; b=kJ0T23XfUoXyd7QeFwO0j77o9Tf1NJAljA4yLSQX7NJzTmmXNdTME3Z0I+1vgKQvevKbqyvbFuE86BRLw8chylNcEU+hQxnoQE0U9dWdM/4UO8I2xQ2nTDpMBW116HkLK7GQ+PhIKRnKGOS6leEwDkjwqyHep2m1brIjxZyJlF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751526679; c=relaxed/simple;
	bh=4YEMhD/IDN+u+xA7TOMBG4DbCVN3MpQ2jcbner+38UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sY6Imx5BkfgEWdFGBnUxOvZiZfJWhYu2lDVlLNnhqb6HEi0jv34jyMAH7MFAA5UsWmtRt+RVoC/XzqBq+0XisEpA2aeP8TtWYpJrtyPKho3si4KfTTg/PNogalIcPOrr2ibt08LG5ppbGWv9hTVVnj4Wo8jCTnXEBnGKAHjauhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=eLvzhxr/; arc=fail smtp.client-ip=40.107.95.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE7i1SGmF2m48WsX6oFeKQS8c8HZ60kOd8LojCXXG3wLsSxh114OjPA6Nl0P8XDHuU/RmZYfTWgh2i9ChPST5gx6YAkaJwQ9ZaDnSQjDFv8Aihu6UiFKLzcfx7nZfXgCEGBMuyY2sL8k8G9wNfzvkES1oPmJ8P+tsGHW+4QRytis8sk+wZo7m+f2cYJQryMvD2Q+trX5G884C958oAgd0MTZooYRaxDGNHwqFOrdvaAx5q4kcU9oYB8bjp1/MaJGDPhxg6+WDZM43RxyaagrSXcY9gwCtCmpZ/g4smGrtbRemEECrTfDAanSKvoKbtmIckFlF86xKl76H8192Bt4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH+uvmooGwDXEcTcYUkIpkA44Ws6me6OFAvl28C1qVo=;
 b=by5QTAWcEjRKVtzhPtsdOoMbBbXSgXlbc+T1a4y4D6EGQtkCn3XBaPFnyaardEplTjRivDn6Xz599DUMFu0dLKW1bKLRurofzHeY3KHMjiUnEtSKBPF2y5eQ94A5X9LP7EKAxT+YmNpEcNuKItQJB3ol8a8jmQLZZ00aHqY99qwNCTkhVjwzK54PVpLRNfQx19tgFt37SeYwQuuoB7fDIGaqejIxzU5KFWRRUfxHtsfSbbLAIJv/nMilrMYhoNUkKsfer+ydcejlb0YXb0PphUIuyWJsc/6E587zfK0YvgcJy6c/NVIXodP+tr4/Ak+IaZcJBcIaRiV4BHNmBihXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH+uvmooGwDXEcTcYUkIpkA44Ws6me6OFAvl28C1qVo=;
 b=eLvzhxr/++944how7HDCIQKeRbrM4qE7vKETGyH7KTWOKJsopAH1J9Vnu3J9XG2xhKFPPTp4V5MGEFmMU5MnQYtfxWsWq7cPzAw/RvJlHUqnXvlhP6emtgM2icwgP6Kp+/6o4JFwY2c4muxAhpoxyddPUAhCVrd+KheeaBb8/XA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH0PR13MB4698.namprd13.prod.outlook.com (2603:10b6:610:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 07:11:13 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 07:11:13 +0000
Date: Thu, 3 Jul 2025 09:11:04 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/11] netronome: don't bother with debugfs_real_fops()
Message-ID: <aGYtCH88UZcKwzjh@LouisNoVo>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <20250702212205.GF3406663@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702212205.GF3406663@ZenIV>
X-ClientProxiedBy: JNAP275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::14)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH0PR13MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4a2e6e-bbf9-4c6f-f578-08ddba00cb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4Zp3nbJgdguvRGNAKtd5IL3To1dcMqqCQJBvv9vqwRuAPi+ja6DxwGEVNpW?=
 =?us-ascii?Q?ZdLk8g5qVgo6QIBd4PJdAW8/mZ1mLcdvopozBW2sUvFGwMpsGHQ5V/1qzmNn?=
 =?us-ascii?Q?YN2tkvwaAzQ5jxN7Fz7i0xkrFsUAX4/9lNVKIf+D6R57Lj50y+V1lafbL25j?=
 =?us-ascii?Q?3VfcO6mb+LBvQdS1pBJPs5a8P8OkNlc6iBYEm7Ki3UyloEC3VQ4DXxcJgFBv?=
 =?us-ascii?Q?UGBlAe4+1HoaaynBCAlAiA6aE0e43HYuTWebSqdQCnmTZN25usuCL6JBvFUj?=
 =?us-ascii?Q?dFhFWkVS81QlqDF1t8t797dp7uil5akBa6hzUoLewA5tAPPODT1SzHBv7byd?=
 =?us-ascii?Q?2A7d5bqH1o2LQ2MPvVYMfozhbUwXXkt/AyK+LMBr1aiQlO3x5nBGeyGx/ZmC?=
 =?us-ascii?Q?rHYupPXJbRzwlqBjtYMpkFYOzTJSbFRLZSCFc02/SNu6iiRfWTFf7NpGmc8L?=
 =?us-ascii?Q?a0LqomzXPyeenQTD26NvnE9PolDLXw7Oy+iKAb9mRo7+Ri1MXIwlO0FslFeS?=
 =?us-ascii?Q?qC51rnNEeFLi4m/oLxlQfKeXtxqDcUk9Fi8LcMECzGspwB3+ICg8zpJWCbGh?=
 =?us-ascii?Q?g/Lkzd54Pu0jj84NozKTrav7rFZKMewiSUbfUPInEQiL9A5wKkzvG86Rp4cr?=
 =?us-ascii?Q?PabV6Nh2gieUFKUmjzkFrCaIxZef/qrE3PpkCjhcJr4eVpL3fQOlvVJqCsSG?=
 =?us-ascii?Q?o1483UI+bhEdahl5y2qP/F3UvEUs8TfqlKpSTBs1LUgpBN4hTtAkBlmuWNc6?=
 =?us-ascii?Q?X1/Jh8CONQL09hybN4stAH0UmRWTprN/CokSGwiDHkDV3wVVyPVhz2Wi1Plo?=
 =?us-ascii?Q?EPuUDkXI4PqeX4OYNyn/1E/4ZLGyrZu7Wm2YCPBKxcP2RiAM3LG3UtqfNTBw?=
 =?us-ascii?Q?KiX4Ux5aS0nUFwZmyTYy5n7qMR4Q/1ng/0ky3CAOgvgin/E9oVPE0vQTyjqS?=
 =?us-ascii?Q?jHTuVartWuZB4FYP/SpV9q+7wdcQJAgpQtuL6/+ihj5TrBssMbmtsjIyYHOy?=
 =?us-ascii?Q?iNmrUv2eptpS4aTLOcfghZ1Roz82wtQnz3SCFq5H0uKqbLusk3ulXbkBtnsT?=
 =?us-ascii?Q?lsldOAKp9ZUyR8kXIxucSsyU6GMWIMAOqJ9/fU7kt5KDgFjq01zBeobdzyQy?=
 =?us-ascii?Q?oTaVDIAGcmFSn51NcKg3NU1wBRbT+IWRe0t8sUdzuQrzAIrrGNqbFGGJIApi?=
 =?us-ascii?Q?kBUgt0hJj20Zj3CAcSRpo3kEpVpyY8kbIkQkBS9mmm2ZtJLzXvIY1VJpzQkf?=
 =?us-ascii?Q?WuocAK/PexFjcVKuD+y/GQkZCnDfiQ+5EMpLAWN85H6RIUDHSdLdZXFuCYn6?=
 =?us-ascii?Q?AQJw6Tv5hIBJNQFuKJFo06n3s410fWhNL1BvRjPinsT0IiYKuW9mVC2dQgJ6?=
 =?us-ascii?Q?v9EGwIst96nsAg663qzOZKWqe3D8STQuONvdN2wSfOBtxypwTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eArkKI87sDx/UJwVeODNVhqwib4G11VHH49sTbTXJZkNxc1Vb9CLsd1C0339?=
 =?us-ascii?Q?hKaP0kPX2HLuJ0WcehBeboAFGQ7FKhn4QcK0ZeSpqLZux3VaMOU0T+kyiHMu?=
 =?us-ascii?Q?YP3KT6fi+j0QA8Bd3Qo+yIQ7UD4Yz6VkmNXS0EcLGnZSLDVqdhbqx7AZt77l?=
 =?us-ascii?Q?4iuiArgB0E/2mbPHIA2o9bFYVq+KOkP167pIg4yU64T9Y3a0Yby6x6O4pGIQ?=
 =?us-ascii?Q?HL0WSc1vOV14cCK2o1AZfjA/wOHVNTNJpTyflyk576AXhhgZ3jQ1OiLbKdR5?=
 =?us-ascii?Q?58Wv+xEFvXX+crs4wT5vDAIkMY/BHM+1ZnzLlGhZwG+tMXy25Xuu6Pp9GabR?=
 =?us-ascii?Q?TklZtQJOGC+6DOGG13TYXKokE45P9eLBtlqmqdNBt6SkCSbmAgj9lZ9NgApW?=
 =?us-ascii?Q?2cVdR0MVTDL7SeLdFyWVveAsnY8UIQCa3pHaI8Z8tAbrydkSlyg5T9DROZxC?=
 =?us-ascii?Q?96AK+q6nam67vnVwvEeIGHMPpj1xdeyqPo0kwduXpXF2z7nMd70rgyUDzRin?=
 =?us-ascii?Q?B0eDzQI8ZuYODI1S/yogLozPd5PBuu0oI6VHERVKWGlFE2tNiOgvBfRTHdSY?=
 =?us-ascii?Q?1VAaNeSvchd/PQnaDyPAvNQhhJCqPMMTWLq4hQ0lVgYhZZu3aXDPrSw8GuVl?=
 =?us-ascii?Q?OiH2aFdxdZO4prBdmAP6SjjMlwvRM7bMWYTZqnR3glLs8HMn7jdyG0hL5mG/?=
 =?us-ascii?Q?YYTevOOzfgLNAbp5wZRxzZIquiiH1BoA8Tk8drhJlSTIlYPCw2m8pESTM9rL?=
 =?us-ascii?Q?U1h2ZRSSZZ2L+1lZGqa4CHYRaIiyJpErqfwwvRGMqAnWkHlKSXAut5W/MY/G?=
 =?us-ascii?Q?fU7i66TSeFi+ojnzQqOBzoSlO6JuVF62zgrCOlk3m4KMjLFvAWEnmsOPVlqM?=
 =?us-ascii?Q?wPDsLiiXhME9oJmW+yzUEpTmmwmv+vCPX+P6RaGscQbrUx0DOHF75GoTXFZx?=
 =?us-ascii?Q?ESd3SJ7ME5o8AVu3C14B3Arxr1tcoNW/lv4XYKFRXRA2Ya8zb3mCu+V+Hbu/?=
 =?us-ascii?Q?oLq4TN+hgp9be9ihnI6ln7VI7HbKBcN48knpKNbQkMNgthJPm5+W5Tn4T081?=
 =?us-ascii?Q?jHc1UUSlbP8q/5zrihQTm0hGXQ39IxGF/tC75MxoPtr0PWSKCe0sMO6O4qAr?=
 =?us-ascii?Q?K2EYfA2uycMj95+yQ0C46k/jXm6DM6W6Mj2JVmQbKvedalveO1wWMjAFd40J?=
 =?us-ascii?Q?3sKNcWSWCl2YVjwemjL/HpZR71d/QHvZgVHEtmXzVLjo4M7ve2n0or8atFx1?=
 =?us-ascii?Q?IBz9aU31csurk08EnDlMWXdeec2P/AdChG3kQSwK1w32jhm9P9RuvOP/WxEm?=
 =?us-ascii?Q?jJ6QEHUnAKj+hJuUyE1K0Ri/Nx0qxJSZJiSnNEhjqgQN2G3WHX/4g8Iqb1F3?=
 =?us-ascii?Q?3iXbn2iH95BL0gHkT5lXpcAu6pDCOs1Bnf8aTU4dxQJwE7V3hNTlOICY7tTA?=
 =?us-ascii?Q?5Qo8CUjj0NNIrx1eRi7KYN1EhuFpQfC1b9J9RrPCsIIzmmF8PCAdasVtu41k?=
 =?us-ascii?Q?2ZLdkj6EYza7TSwRlIV+p4poCheQibC05vJCP2ax1MLc5F4csn6qSaNyCn5j?=
 =?us-ascii?Q?cG7kg/2+/EN+ih6CtRSW9rFAHt2z+TWR6RRKPr21osYf78SKmKz/92NX9oRj?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4a2e6e-bbf9-4c6f-f578-08ddba00cb10
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 07:11:13.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DFKMnvZUoLGRv2McfPUwuHjIs47TnQlqeGKYon0giwesTiSZvlVCPHmuPMEEhadNf9g7VITMy3NqN7XiE2nBbdD5ihpe68J3os9jAeBEf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4698

On Wed, Jul 02, 2025 at 10:22:05PM +0100, Al Viro wrote:
> Just turn nfp_tx_q_show() into a wrapper for helper that gets
> told whether it's tx or xdp via an explicit argument and have
> nfp_xdp_q_show() call the underlying helper instead.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  .../net/ethernet/netronome/nfp/nfp_net_debugfs.c  | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
> index d8b735ccf899..d843d1e19715 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
> @@ -77,7 +77,7 @@ DEFINE_SHOW_ATTRIBUTE(nfp_rx_q);
>  static int nfp_tx_q_show(struct seq_file *file, void *data);
>  DEFINE_SHOW_ATTRIBUTE(nfp_tx_q);
I could be missing something, but I think this update now allows this
DEFINE_SHOW_ATTRIBUTE(nfp_tx_q) to move down to below the function
wrapper, and the 'nfp_tx_q_show' declaration here is not needed
anymore?

This is just a tiny nit though, I'm also fine if you want to leave it as is.
This looks like a nice cleanup to me, thanks!

Reviewed-by: Louis Peens <louis.peens@corigine.com>

>  
> -static int nfp_tx_q_show(struct seq_file *file, void *data)
> +static int __nfp_tx_q_show(struct seq_file *file, void *data, bool is_xdp)
>  {
>  	struct nfp_net_r_vector *r_vec = file->private;
>  	struct nfp_net_tx_ring *tx_ring;
> @@ -86,10 +86,10 @@ static int nfp_tx_q_show(struct seq_file *file, void *data)
>  
>  	rtnl_lock();
>  
> -	if (debugfs_real_fops(file->file) == &nfp_tx_q_fops)
> -		tx_ring = r_vec->tx_ring;
> -	else
> +	if (is_xdp)
>  		tx_ring = r_vec->xdp_ring;
> +	else
> +		tx_ring = r_vec->tx_ring;
>  	if (!r_vec->nfp_net || !tx_ring)
>  		goto out;
>  	nn = r_vec->nfp_net;
> @@ -115,9 +115,14 @@ static int nfp_tx_q_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> +static int nfp_tx_q_show(struct seq_file *file, void *data)
> +{
> +	return __nfp_tx_q_show(file, data, false);
> +}
> +
>  static int nfp_xdp_q_show(struct seq_file *file, void *data)
>  {
> -	return nfp_tx_q_show(file, data);
> +	return __nfp_tx_q_show(file, data, true);
>  }
>  DEFINE_SHOW_ATTRIBUTE(nfp_xdp_q);
>  
> -- 
> 2.39.5
> 


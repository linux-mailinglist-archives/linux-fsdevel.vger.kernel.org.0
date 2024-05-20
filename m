Return-Path: <linux-fsdevel+bounces-19737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620538C97F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E8528117A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C850BA40;
	Mon, 20 May 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XEvSkBYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3902F2A;
	Mon, 20 May 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172227; cv=fail; b=G/FoFdPuk5rrB/zGRGgeuWujEWoD1VMFNjK1fe/YI40f0QZV8Jc1WjjsjEY346Pmf+E/UQXpFdSqjFR1EuvGFZRgtCronqI/iCtwly6psx/KOR8Xe7vKbCLJ63qefE3pMgkr/pyL8+d1tI7c3GKu33eGNQ3eInrpMmkJ1ln2MiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172227; c=relaxed/simple;
	bh=bhAvd8pP8rzuOQZSh4Fr/2AYy9446heQbrVMWLI2uPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C272uOXs3ZRbwcg/wbx6+5p0Jay7m5FF2opF6k+w390X83zShl8gwEHWL9HFu2DrIO0v9c/+QVzfLiptqdKiFVp0O9bGLtDZDeis4+HzIvwXepJNTsn9YWlcOkHFfDCTLLAXmyE1pFAS43yTbLSliGYCwp3Kxrhqc1+QHXjDhXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XEvSkBYI; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0ahQ5lj0EAKcWjdZPUHY8OxtuOXG9QmEN0wK12UA/Dw0BEvL4aNlNWSzSVPzKaOBWk4KlVd0rfUgXvdbxdrmecZ9MKfxt95OO6dYFlWTWV6lK+bwjEbrPDz2epaHt5khCQyosyQZiJYBmB3WgWG064/1r4MKynmMGJ8chHz98OQ1Igjrba14lF0eJUugFO81pnz29EtUOZ4N1yi7p82iS1TF7VIrsMfkAOsPx9Y0Iktoil1QnE/MqkJgiBJCaslhdY8KELWS2AWgsjAzzln7B+R6xSH09374W63U94NJWToB6mdOXi0VoAvGos/FNCEjiIbdmBOEFKMYRfwD3UtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJUxKpXeJCZyJRzMh8JEcbU2zxJ6ihu3J4wc0Lozz1o=;
 b=Nv1NBvHaQZkeAAmeLQTmhriDJ9oEBhqgyHtGb2xPrRzfnssgqHU/TxdxJtYtWtpvQ6UJFH/cV1k3VrbjxQF10juJ6HW5dQIpp13LnTZcOVl64J4n17OiJJ5Hux/lJKC4VkIVUO2SWsbPI+kOIPb0Y5N7icz+xe5Gfn8fECJLrGD4R4qYXZ9UKTz39LUsMI05hB9pQGs2xIDnlAQhsd4dancityKzbXAOJoJg4IQE+1CI9tlnA38I7dxgVFm/G940y0uEk3aR9eh+zCGIOMNd9nt68IjwP90I22rF+lvjDMoNeo+A8CwPNvdGu7AuTE3CpUKFRHe/KPjgSD7OlAg95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJUxKpXeJCZyJRzMh8JEcbU2zxJ6ihu3J4wc0Lozz1o=;
 b=XEvSkBYIfZJEdrEO1BV8Rq/dqKguwnRhq+BnoGF0T1OgLwcDC0GNh9BcwISA9Fu4mY00LwJnJiGwcxIqDgCI5sCZzkwlsrUgeflDy31nnVeS5iv4L3uMfiTCEmKGFcJb4NJTJ7Tu8LGNr5MqkMag1/RD8u5mVKAPEJdgxqMZpD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 02:30:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 02:30:21 +0000
Date: Mon, 20 May 2024 10:28:52 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: Re: [PATCH v2] iomap: avoid redundant fault_in_iov_iter_readable()
 judgement when use larger chunks
Message-ID: <20240520022852.4dwtehpyf6plkeeo@hippo>
References: <20240517201407.2144528-1-xu.yang_2@nxp.com>
 <ZkdrzlM8d_GowdSO@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkdrzlM8d_GowdSO@casper.infradead.org>
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f197da2-46b6-4785-9b6f-08dc7874cba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LXHgUe1pPCDzfIdFTxs210aDRTMRoPQUUJaHxEg6iKeBm2+8iuC9i0SDqAcG?=
 =?us-ascii?Q?zfTkWhKG1jiAkIZQ5YqcJ6oEvTJqJFxqNR0lkb1TKuxRD3gyQZvYbLVx+MdS?=
 =?us-ascii?Q?eN7ILRuZW3Pzejm1yZ7FxybTBJM2NqPBOEFpaPVP8ReDEV3s2Jnafo5IWA4P?=
 =?us-ascii?Q?Gu2cdj1bEMb54oWxL4dqWMbC8/yKTntChT4zMacIlnivpKDYaB04VhF7Eu1u?=
 =?us-ascii?Q?XC2s7x4uIxvfbP2j4qQWXxQLdgF1usV3SaXcbMAG8T3W4hj368MxxhTQgruc?=
 =?us-ascii?Q?aAZUJFDFkspnHlRLxKPA4iGpYPHxjV5TSpQ+T0eTa3wHLTjD235wowsvYF+A?=
 =?us-ascii?Q?AtOUtxx/4yLrQhreRoT34XP3z78HP1+yjXTkpdZiA49do2httwsvo9yCUgCC?=
 =?us-ascii?Q?cpfMjIRDKPiate/i3o1YDE1/s56gbHZhEW84yPHvkwIbiCNtWxQBUez1KbSl?=
 =?us-ascii?Q?/l1wBH25hDbe9rNE3JpNd7Qu/eWeYLZB3Vz9wzGd8CImFDW1z8v9t08VaXA5?=
 =?us-ascii?Q?eU8DTS2CnziAzzm7flTv4Pg65prrIfdIAUCxEbEFgLKV/W9yyekxxruFTrLm?=
 =?us-ascii?Q?wtHZ5JrCK5fzkocAgFQFBvRS3Fy+6TI7NFbNvt7edAkCg8LYwc+7E2haGLzu?=
 =?us-ascii?Q?nfaUw2mfhLsRqnUFML0z8tZniTENn6zYXQG1qzbLxA8Uf5y1wTY7ELyfu69B?=
 =?us-ascii?Q?ZBMu2Ptblo4FDLI7y3UzF70pzy2mEQ3d5zDObCmxW1K7ljDbr544hhem7W0m?=
 =?us-ascii?Q?gd3zt7BO4GA+5tjnAmhQFLbK5w2qSFxIhOI31SLUJSZLhSc1a4IZ5G60/prt?=
 =?us-ascii?Q?Vm9HN3Jo8Du0/CaHsNUh51LGH96JFW9fIZSSrmz67P4KM/C9fq9DPEM+K+CJ?=
 =?us-ascii?Q?FdCz2F/fvKPYwARNYe6lf07i3Dp9hgAvvYsvIv1R8j/ZH63YR1nsAydLM/5H?=
 =?us-ascii?Q?fTl0VNuOggYjzEaZ58JxEX52TdN+Fh8SEBSoRzE+399yWXz8sSp/AacFABcU?=
 =?us-ascii?Q?9hxTi8ED1wtPbjWsUplrLJGzNejqHRuivuCOGU8fknmd1MyaBhKuEQ2+n2Qd?=
 =?us-ascii?Q?Byny25ZBt6MHar8F7HrH4/AadW5yjPvo28vO+EWP4bxEfnSTfrvYZNpnFBg3?=
 =?us-ascii?Q?rPeGupNwBOg3M6v/gy2CsrnQkPOXbt023fNuqEpToWIQ2Fe+5XZ2FwG5L8iv?=
 =?us-ascii?Q?Q9APRWCDv5m0wLQm4qRV5pKJDjibesK6bRlQFsSv5bfEty5uT/nmrFMvaoXq?=
 =?us-ascii?Q?OJYlF8M9MLxGG8rY3ejyu8CjkNPUt9M6VVepBxS66GCgy8m4HUNmemjeSD5p?=
 =?us-ascii?Q?oS46aBqk5te33S5dGScHTA9oDwVExLduFZZaM0w6Vb8nNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y3SSo4ndABjwbDbEmAwQaWtWSua+OydlcqCSMVvtjmfreKDw2xk8QEzxu5oo?=
 =?us-ascii?Q?5EwoHeVNfyAZTJ0AXBt7ymikZi/kpNcGdFpfWv7LVnSW9VKz2MY+WHaeraj1?=
 =?us-ascii?Q?+KKRB3MCEA4JwluZbxWEGfQxGPSl809xKrRSammfvDAMvCbWNA6jwBUZjgDU?=
 =?us-ascii?Q?KrdA7ph0ah7/yph9ubFNDvw1f0HeYhvi6Jz9iFD8QL7EPP3UIxl3075gZV0U?=
 =?us-ascii?Q?6ieBp2Wg8FdIM4KxwGmtmHmgyV8y9MlMOBJYBcE1G3eh2DVSbCCUVML/xeQI?=
 =?us-ascii?Q?udMTv7QcT1NY0f5rYc9V0j2EACZ1YPTmUcylfulMzzNWQoUq14nnYI2X1y8k?=
 =?us-ascii?Q?vTfDSc8l0cx1rJq0GtDx0zf97qH3s3rnULmRRy4qeohN+Oh5Tx4nsnMkDcJJ?=
 =?us-ascii?Q?hpy3AKCZxoVkdO6kk6BMnhykEwxwDtQIuVLp/uh7jn6EhYyTF5G5THnGVTNY?=
 =?us-ascii?Q?3Wtc3Hj2nOswpbTZWV4T7yg/avKHwhfArkaGu47HwmjeKNxrrsfwZLeaqykv?=
 =?us-ascii?Q?vTSqBEtiUN1w5n6omVOH71Zdja3UlVWJFXI21qB3eLeP33cnxO/vS5394SrG?=
 =?us-ascii?Q?mLSwHepkrUNjCCqhREiGcOHgFULPgF2aarx7r/snPNImUCHV9DPV1ibpMfNZ?=
 =?us-ascii?Q?XIYv02bNSqJqtDCFD96CoUXv/45ryEtE/usWCZgE9fN2xCptAoAyZTKG40yv?=
 =?us-ascii?Q?JXcoEq+59GlAjSYHjadS8KLYP3F4fsbkn22cwMvmXFzkklC7Wo+Su1NMbSly?=
 =?us-ascii?Q?zLYV60KgDHmLK0+kx/oNLBscgzfk4c1uEoBmw8xIDD4ZzvLHosMKIr7sncXU?=
 =?us-ascii?Q?L6TZWh7mpw6zeP3QslEeuioUdqf8hIOkHnTB7BiHmW7lqDYx6tusTJ3rKFaj?=
 =?us-ascii?Q?7NFJdPjFhxUY0RSbqj/gMkFi6mGlWFRUOepvRJp5y2wY/8lPhyhozw3GXZwd?=
 =?us-ascii?Q?rrW5QAC8B1y744PyDpIsctJGadMaUmI7GR9D9+hXXj8UK2nC5D1/5ps/cv00?=
 =?us-ascii?Q?JXn9iSTSG73jv6GCJMauN4ThIMc2LAR5V6MckBiEe73h8teHvYnxUg9LuScB?=
 =?us-ascii?Q?Y4s1XLReqiDqW3PSD4iW6O3HXG5jqVbpSMPG/H0/6Hhd1t+mX2MDNycZDnMN?=
 =?us-ascii?Q?vRWrwOYdwwogdZIkZ7iAeUu0scG8f8a9C1YzwMknNoVHvvbHHamqH6MjZa9t?=
 =?us-ascii?Q?jxa8mA+xwUMqfexRN6e2QujRYL6cHrMJFLCXuGNfNqwLB604h5xxQkSStLBg?=
 =?us-ascii?Q?3Um0RU+uV6G3e4E3quyzb/94eNdcmBdwqJHBlNwfUq/GEqy7gBFGQZtSETAK?=
 =?us-ascii?Q?WqAeb4471Cge6c777tbLJHFR8q0m0kULbqt36L1VcU5yuLejEzjUN5duz/sD?=
 =?us-ascii?Q?6prmiWT62YpL8xx84A7d+FzCuRcoOwgKfAlSo0VqfXLiTRLqdN3Qpy+PO4Zr?=
 =?us-ascii?Q?ED/C7CBiozk8Rrr/0nO0oNCetf65E36OZ70PJHrvO3hU0WJF6Asyt78SXVKE?=
 =?us-ascii?Q?sCy+eauxT6HmkbrI9Gw+aVWbw+1zKxOHdpLe1Hqfrzf9POZTV8ai0hi+L8Wm?=
 =?us-ascii?Q?8cqkEhzBRbvImTf9z4+BStde0Lqe+KI5dHpW9qWl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f197da2-46b6-4785-9b6f-08dc7874cba8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 02:30:20.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHxvgD+4MlAVGqQ26Cq92k3dZgjQmE3eZJPQkWuNZ+JmowveFJUt1wZGMo03Nx1PxrDmfycVyN9BjBxWS8s60Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185

On Fri, May 17, 2024 at 03:38:06PM +0100, Matthew Wilcox wrote:
> On Sat, May 18, 2024 at 04:14:07AM +0800, Xu Yang wrote:
> > Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
> > iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
> > mapping doesn't support large folio, only one page of maximum 4KB will
> > be created and 4KB data will be writen to pagecache each time. Then,
> > next 4KB will be handled in next iteration.
> > 
> > If chunk is 2MB, total 512 pages need to be handled finally. During this
> > period, fault_in_iov_iter_readable() is called to check iov_iter readable
> > validity. Since only 4KB will be handled each time, below address space
> > will be checked over and over again:
> > 
> > start         	end
> > -
> > buf,    	buf+2MB
> > buf+4KB, 	buf+2MB
> > buf+8KB, 	buf+2MB
> > ...
> > buf+2044KB 	buf+2MB
> > 
> > Obviously the checking size is wrong since only 4KB will be handled each
> > time. So this will get a correct bytes before fault_in_iov_iter_readable()
> > to let iomap work well in non-large folio case.
> 
> You haven't talked at all about why this is important.  Is it a
> performance problem?  If so, numbers please.  Particularly if you want
> this backported to stable.

Yes, it's indeed a performance problem. I meet the issue on all my ARM64
devices. Simply running the 'dd' command with varying block sizes will
result in different write speeds.

I totally write 4GB data to sda for each test, the results as below:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)

> 
> I alos think this is the wrong way to solve the problem.  We should
> instead adjust 'chunk'.  Given everything else going on, I think we
> want:
> 
> (in filemap.h):
> 
> static inline size_t mapping_max_folio_size(struct address_space *mapping)
> {
> 	if (mapping_large_folio_support(mapping))
> 		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
> 	return PAGE_SIZE;
> }
> 
> and then in iomap,
> 
> -	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
> +	size_t chunk = mapping_max_folio_size(mapping);
> 
> (and move the initialisation of 'mapping' to before this)
> 

Thanks for your suggestions. This should be a better way to improve the
logic. With above changes, I can see stable and high write speed now:

 - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
 - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)

I will send v3 later.

Thanks,
Xu Yang


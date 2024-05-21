Return-Path: <linux-fsdevel+bounces-19854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286DC8CA5FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F534B220FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AEDDD7;
	Tue, 21 May 2024 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WvjOdymi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F40848A;
	Tue, 21 May 2024 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256387; cv=fail; b=g5yL8rfnfd4BbkXFVt+XFb1g+g3ux9b8e4SDFsqn9hQArRZftqfoZ0PfZgsXONKj96zJjVnjdL+vlzQLuaiEefhQj9fVL+MkHF5AYg+2kT+D3optfCo36vWZL5VkmkMD7v39pFqSvw5fr1/iBODm+f9kiV3wMp9bYVTz+B0yn+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256387; c=relaxed/simple;
	bh=NzqtU5EpURpYW5KfDmLuiQJ3kLjHIQ0EwRwZKKO6M0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dt+I6qkJIMThT8JPyXlfO6wwNULkiRUszjUvNyHpCMFt37ThLdChI5smZQtifDRL7QwxzbqLKtke0DkDtp3PixAim95kJ3fpcQOomxrit4Jn29G3bpwzCXDO7hQ+icRfQmL8UuIO9i14i6DP2mXKxVmQVWT9DvC5Smho/tWB66E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WvjOdymi; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB/iUZlE5kG5zQBodAaX4RxgRjyXA6vLYDXuN8iKymWrTokXYGRwb9+rDdtzeeCs9ZMnuBPodKlQ/B3y9Xm31C3tXpVn7dhwHTnGWTcISZD4+dPXopSReplG5Vg5Ua8xbZmd7SFmo6rlUZ9YXwZnRoL+MmsGfdie6Mxj46QOzQrUTYbwmlZ+P2C+4VsLjUeX1Z21Nx6t9KFx7UP0qQWsq7LJIOM9fxa4cB5hdYGbf8difTj/XdF47gvcO9ZuuHW/l9Fxyn7Q+qGywWtrSw7heix2r2hToSu/Lz6xNqzJEqghkGeV+YWqh1Mekw2Td+XsQ4xS3pSCsNJsVJvsfLPTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqPCOrOnbqEupSpYtt2hxc/1X6Xc93L8Rgzo52nOuGo=;
 b=J4CEa+wcDgWpNAx6eM0cCN7EXSvFYw2zw5JRsCGbL8kTwJn7ih5DfzHvF+e8w7xtKNfM41nERw7ssZ9/OzGATJ6osKqHNHPqwxuY35y6ji1dwo1SdfqEqR5XXw6rYYcEDTvA3OJYUv7gUWISOBQynT+XyVImGTEjrw/Dtew67bQqHhvvHhy3gcOANgt6E6lk79i4KISf8r3+CaCNzKCcXJu9c1v+IF117DBwW96P+q0iGc+Icgo02dxO6AdaFhmomB0L5PT12XPwZhbgHBqnQr+5Ziw3qsQ1BJxItLLJzINw/aNoTYsW0z9XyruwwLE3JI4QCPnQHTzoIklvCh8gGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqPCOrOnbqEupSpYtt2hxc/1X6Xc93L8Rgzo52nOuGo=;
 b=WvjOdymitHRi/0m6metLAUXml/wioA28i8s1zPqiX1+9ZWwIhlIfyASlMz+LerXr6Oz1jsV7Cd4q1qaSNiboH4TbhT5vdMhfdMq2DcOKazbOL+/z0wbSOVne2mviH5vKydtmflNJmbzUi14k8stsI+pzLo2AZ/IsnbYXgq2y7QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU0PR04MB9322.eurprd04.prod.outlook.com (2603:10a6:10:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 01:53:02 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 01:53:02 +0000
Date: Tue, 21 May 2024 09:51:35 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, willy@infradead.org, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jun.li@nxp.com
Subject: Re: [PATCH v3] iomap: avoid redundant fault_in_iov_iter_readable()
 judgement when use larger chunks
Message-ID: <20240521015135.lelvv6yk4s6ufkv5@hippo>
References: <20240520105525.2176322-1-xu.yang_2@nxp.com>
 <20240520150823.GA25518@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520150823.GA25518@frogsfrogsfrogs>
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU0PR04MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5850ca-b45b-4aaa-4eae-08dc7938bfc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ACCZUZRhKQkOnk/8hHMY/gio01rQv26wnAQvX0g3/cRo2ROoLOSR5PFdaYKu?=
 =?us-ascii?Q?SmKN70Acc72S5Zr17iTIHMJBnerkOcxi82tFCN5d4OpM/APOdaR762VVlFNE?=
 =?us-ascii?Q?BzUQHEUVRBp88nrpSQ1hmSh7pevv1MjIoVaE8odI5+19AXD+0KTN3MlSCRs0?=
 =?us-ascii?Q?DX0qta48eDbqP6q0KcQHtjOGKR23Yg/FyKzAzYtBrY1H9YJF3HlXDuCQfnMf?=
 =?us-ascii?Q?zi6DdmGYrVPb96VOU4qDnDK5K4Gt0J2Qw987+2TSlCnAvIZ5A5zQvRj1tCXs?=
 =?us-ascii?Q?Fk1a9x0vQmwqLHCfX/o+84zEPSZzsy1znQupon+wldQCe0b3J34vnxis6eW4?=
 =?us-ascii?Q?0Kqt5XKJX/qvRUURkSVTznngOemh3++a+s499/0c93cxgQsEAVoQGiSZaacV?=
 =?us-ascii?Q?vCkY/pILiQpSKmOQq+sjmmQqV7DZtpb1OJu87Q3gpgYU4tEux4q/qLuUCuKb?=
 =?us-ascii?Q?lyeh31KMzRHt5xGNM+CAY9BmDk0XqgYgrbj1o3eKae/S4pYlJU/SB60unn5K?=
 =?us-ascii?Q?CmUhD4fQkVF7yzh02ikP2GqY+eqxA87Tl1/7BWDX+FZ0vsK865xRffN//ZhR?=
 =?us-ascii?Q?SE4aQKe7GOVrsaCY7jm3G/OYMInORcsDNPtfYDULli/eB3iJw2AbZAcm9GbM?=
 =?us-ascii?Q?D4hGMe1Q80FaA7e3b389hDiNpPLdtJHoB+kowRIwV6HA7stX3ffrTgPzXiX8?=
 =?us-ascii?Q?MomAyWKm/s9mYQyDERxfPkpLcfmKX/GHedKKRLrSwYDgEpper235Boki7Ebe?=
 =?us-ascii?Q?zt2cA9o0lwMldLL1C7HxtsSZODhA0gHHkbkT3wHjEDZLMy5ln/bFcRPqFfXp?=
 =?us-ascii?Q?GOrIvhM/rrheVXk/ONbfimnVV1DtdH6A6aahwdAedIMbUdD236yrj926skpH?=
 =?us-ascii?Q?AGWD+bWo9cnI6u8IBdhtuTfD6SMHccHMc7tkk31sgkKdtxwOH5jlcvp+4tCq?=
 =?us-ascii?Q?BDfBQZloFkdEimOzr3iVU6N90H8PLXfPqvyozF7lS8vqPC/BmSSW821iaSRi?=
 =?us-ascii?Q?cSpxozfKXQkMYkHTfKASaIiJPlR+ELTTq+XHelX0bR5TGVpSA7ynlSne9C4V?=
 =?us-ascii?Q?jVzdz6ZgNpmI4hDNtRBf1E5XzMDyledGulot4+PljzsR+ASl/rqrN/OzCOqu?=
 =?us-ascii?Q?4q+v31A0kNS2qpPq5d8nPRv7Rac/hyqDgsZj+Rc0ubw8b5zSRY+HrOYcGYIT?=
 =?us-ascii?Q?4VNjZpGlN5x0JtuusN4/jsm6EXIKaKwtnH/xicTGm4cEILdKJPHFZthOm+3Z?=
 =?us-ascii?Q?5rhVNw2I4lLHNEuuDWv5FYysfwfQE+2HW5miRYlfy34aUBCZYyW69uBkRF7g?=
 =?us-ascii?Q?qlBl58bj2RwK2lCdzG2oAwkMT2C5f2RnYRcsAZAjSsMyww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EwJu9Olp5pjmBr0Dnt9FtPzFfUkG7Xe6M3iEvWgPSFbKyW7wRDnoLwv1lO0?=
 =?us-ascii?Q?nOO8nTRzV4ovMqb0hOleFPbnqdQS7aSyMFTNaV+OUEnooDz8Z6cs/Xbb+4Zp?=
 =?us-ascii?Q?lpiI153JUcduhMuCKTaHdO7LWGRlboZacWWDKu1II2UPH4U8x6MhAdOxgL3w?=
 =?us-ascii?Q?8yhCCi6b89l8qDfsDvDuHbNf+Ver3ZexsmBJH8EkD5yYEeU+Eyy0UvgupWql?=
 =?us-ascii?Q?9Q/N/hfL6icP8ZEAq2xZVtaCtww+fx2REtg+ooyWJHqIOukARDNnw0qneofg?=
 =?us-ascii?Q?eDFAF73zN3RqmEOpkEHxd2582uzNK9bApQIXL+ftYc9+ufOs0ciSsAVhQsb2?=
 =?us-ascii?Q?NohkgkOtt3FdzUoZyO2tTHJdMPjAly8gio7jFFN84cCunDmokhtezHQ9k8+e?=
 =?us-ascii?Q?GApa0xyIoWpp/8AoBeQ78LJ7tjjcxU0QQPUrf0PFnGpDiBZoMzMsth6uOwt/?=
 =?us-ascii?Q?yAMMgmLW/4u1+s6I3hx5h5dLs0xbRGVuVI3kPqZG2XYq95ZX6IdyuQajXmuW?=
 =?us-ascii?Q?qclkXWeqW5XqF6G6i2otc/TjI8kZi7EZp8/XmjDGqkVJdjOd4zpfhblx4xkP?=
 =?us-ascii?Q?D3GktgMyqlzdh79ix69VUTdl7jJ1fpnzo+nix805L2kn7LsJzK7LKMz04SRT?=
 =?us-ascii?Q?Pis0HUNrDXcrGD0i34hMNRuyJsKoSbl64ppmYXz+h1GY1gIq46QMQlAslEEp?=
 =?us-ascii?Q?ULExhHS4QCcszJyZMmmATkZce9JeU7dCUdnnw5MJWMYevqnIczCQu2i1FLCP?=
 =?us-ascii?Q?jMAl+Lrie2ovpOqFR+88vShLpnxQvStOIQuXIp1FwghC2SskvMu/5TYfNknm?=
 =?us-ascii?Q?fKyG1umytdeyCYotPb/pWDSmUlaTosXMemRknARXhVgNyaCJjlFif1aSLm1W?=
 =?us-ascii?Q?luxuYO0/wBlwmcKjcQKaGAaEikoOUVSsyKmgaXH94zcdVfn51id8KGADrUcl?=
 =?us-ascii?Q?Oqg8CmO+h/ZEemIaMkBF4YBfSfc077GewlceDvo7OLBIRZyFfJnCvjHDnZrJ?=
 =?us-ascii?Q?1py8IClTJNO+4upCN8R1ocjQzaVjLkP5PI3e4MCdY17zpSSmjK+kmadZiaVk?=
 =?us-ascii?Q?T0q29DB1Xu56hOSUzMR84ycv+PGf2Zxoozq5qwCL4g2SiREB3+OsxVnjeAob?=
 =?us-ascii?Q?2GKtMC1iA8wiTHJyAXcc1mQS5qjAECRMl3wrrupeQFzofgpPuPRc/FaTJeNm?=
 =?us-ascii?Q?y4rb2AVI8i8N2Fqms31fXD4uR+MHt2xj63XuwNTwwPUiDWfBxmQRUwGyWsGo?=
 =?us-ascii?Q?cPsBsypBr7/HeVCWR/MoU4zPq4cBPML6seRYpWEevETRg3k3iqbrQbj9/9gA?=
 =?us-ascii?Q?QWAlNh0tE/Qr9VlJ2Pguc9K7TQbN4JvDD0vhPaz6ulogMpjxQ7kVDmaYRasF?=
 =?us-ascii?Q?vJy0ho2Yq2N9k72hrYRJbBn/D0TmcVKdWUQLW/t39pnYy/GdTXZ4TvRWrFgC?=
 =?us-ascii?Q?gor2lH/bXVplnEcas4mYuIw3jD0QeYmjOXc2kkgN2lBxTgWAtSsR0BGJ18yM?=
 =?us-ascii?Q?VZkeww3JEUtBRUDXdVePTL1DMDoIasin5yHAmNeV7QtEP620qzVz++jNYtKP?=
 =?us-ascii?Q?FcNuubN3Oh16s7hsEVcO4FLePj9FAb37K7D8rsEY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5850ca-b45b-4aaa-4eae-08dc7938bfc6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 01:53:02.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ubo9/9KbKS6x35K1QFgpR3ZlAwEKx6Zo4amBCTF9GfYgdqX9bqzbBqyx83qtEutPNJNvv1noR9OBqtkM576Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9322

On Mon, May 20, 2024 at 08:08:23AM -0700, Darrick J. Wong wrote:
> On Mon, May 20, 2024 at 06:55:25PM +0800, Xu Yang wrote:
> > Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
> > iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
> > mapping doesn't support large folio, only one page of maximum 4KB will
> > be created and 4KB data will be writen to pagecache each time. Then,
> > next 4KB will be handled in next iteration. This will cause potential
> > write performance problem.
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
> > time. So this will get a correct chunk to let iomap work well in non-large
> > folio case.
> > 
> > With this change, the write speed will be stable. Tested on ARM64 device.
> > 
> > Before:
> > 
> >  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)
> > 
> > After:
> > 
> >  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
> >  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)
> > 
> > Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > 
> > ---
> > Changes in v2:
> >  - fix address space description in message
> > Changes in v3:
> >  - adjust 'chunk' and add mapping_max_folio_size() in header file
> >    as suggested by Matthew
> >  - add write performance results in commit message
> > ---
> >  fs/iomap/buffered-io.c  |  2 +-
> >  include/linux/pagemap.h | 37 ++++++++++++++++++++++++-------------
> >  2 files changed, 25 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 41c8f0c68ef5..c5802a459334 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -898,11 +898,11 @@ static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> >  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >  {
> >  	loff_t length = iomap_length(iter);
> > -	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
> >  	loff_t pos = iter->pos;
> >  	ssize_t total_written = 0;
> >  	long status = 0;
> >  	struct address_space *mapping = iter->inode->i_mapping;
> > +	size_t chunk = mapping_max_folio_size(mapping);
> >  	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
> >  
> >  	do {
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index c5e33e2ca48a..6be8e22360f1 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -346,6 +346,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
> >  	m->gfp_mask = mask;
> >  }
> >  
> > +/*
> > + * There are some parts of the kernel which assume that PMD entries
> > + * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> > + * limit the maximum allocation order to PMD size.  I'm not aware of any
> > + * assumptions about maximum order if THP are disabled, but 8 seems like
> > + * a good order (that's 1MB if you're using 4kB pages)
> > + */
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> > +#else
> > +#define MAX_PAGECACHE_ORDER	8
> > +#endif
> > +
> >  /**
> >   * mapping_set_large_folios() - Indicate the file supports large folios.
> >   * @mapping: The file.
> > @@ -372,6 +385,17 @@ static inline bool mapping_large_folio_support(struct address_space *mapping)
> >  		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> >  }
> >  
> > +/*
> > + * Get max folio size in case of supporting large folio, otherwise return
> > + * PAGE_SIZE.
> 
> Minor quibble -- the comment doesn't need to restate what the function
> does because we can see that in the code below.
> 
> /* Return the maximum folio size for this pagecache mapping, in bytes. */
> 
> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 

Okay, will change the comment in v4.

Thanks,
Xu Yang

> --D
> 
> 
> > + */
> > +static inline size_t mapping_max_folio_size(struct address_space *mapping)
> > +{
> > +	if (mapping_large_folio_support(mapping))
> > +		return PAGE_SIZE << MAX_PAGECACHE_ORDER;
> > +	return PAGE_SIZE;
> > +}
> > +
> >  static inline int filemap_nr_thps(struct address_space *mapping)
> >  {
> >  #ifdef CONFIG_READ_ONLY_THP_FOR_FS
> > @@ -530,19 +554,6 @@ static inline void *detach_page_private(struct page *page)
> >  	return folio_detach_private(page_folio(page));
> >  }
> >  
> > -/*
> > - * There are some parts of the kernel which assume that PMD entries
> > - * are exactly HPAGE_PMD_ORDER.  Those should be fixed, but until then,
> > - * limit the maximum allocation order to PMD size.  I'm not aware of any
> > - * assumptions about maximum order if THP are disabled, but 8 seems like
> > - * a good order (that's 1MB if you're using 4kB pages)
> > - */
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -#define MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> > -#else
> > -#define MAX_PAGECACHE_ORDER	8
> > -#endif
> > -
> >  #ifdef CONFIG_NUMA
> >  struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order);
> >  #else
> > -- 
> > 2.34.1
> > 
> > 


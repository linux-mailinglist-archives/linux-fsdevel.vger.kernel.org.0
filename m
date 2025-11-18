Return-Path: <linux-fsdevel+bounces-69011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D73C6B607
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2DA45291AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71020366DB6;
	Tue, 18 Nov 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCmbAAtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663B2580FB;
	Tue, 18 Nov 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492950; cv=fail; b=qWr9Kls1RQYKMMLKWCd0pytThCaydegGWii/32j5DSBIZuwdk5C9/3pKymmNsjD55BG9bIbd15TxxEKfOcaIlYeNxZeFGP9lUudnC1reOkn7PfoFj4chu6NHVxrKCSEbaTfOpgyfhJyW5A1oNupv/6KEzoAPuDhpJKa0a5pkKDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492950; c=relaxed/simple;
	bh=mVZlSX7bLJC56I6uEv5PLlrPJlx/frEOeaIhGcE34fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jngjChmWEqjjtZqRU4ck1c+pvz4m8lrH9cUNLqUYy/B3vTCHKHzPl4SfbQLRgZIxDneh/qGoWn8lhoz1XmWTbW5t4dN17vUT8hc5wvjRKKsERGMkCWv+blte808w+UMIuIgXz/z4ioGpW5Yapnu0Nwq9jZneXvRu8iGOfRt2gIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCmbAAtl; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7a4wd/KOMzOxQYbucUBdOxIA07JJaHChElW0YMFeHkG2YWJ5LKYcQVokEYwf9lM4lq1fHFhHLJD01cQuV5QRg7Yu2q0C4iyyAfKnaYV8xJT5yTOZiMHL8lgwRJ0bsFSfMeJsK2Mt+vEi48t1A4yEnAJeHEtpBP9BmfjUDbSqtJYQj6MSu85sS8eNeDLLz8Rd77HrXtdTYx2KwODvTxhRI1t9bDgGbGX4AcN44CnJZB6X5fs6WAOqkfnqii+7oxpinNyoRMCSnc4OKSP7UduiTZF6YnmWqis1nR5IJfBLaSZ7fTJ+5/ZaAFtzJQEapq/RxG03rpVeNrgp3lGwokpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVZlSX7bLJC56I6uEv5PLlrPJlx/frEOeaIhGcE34fg=;
 b=wTfD1yTZPk2OCKNpyuAJW6P2BXsJ7asQgnAferq0RYHVBwrPdkAdYnCUSPNWnGbIuoSuqAaVOPReEUQEZ4ELtwqCr6cr48UhOkeE8iEwYIff2tyqAhyLPhD5NB1Lxt622b61xhVvjWV+zUKxCCWompoiLCRMVDZDTVJ7N9HNiNw+2TnKzFHnYu4TIfUeGfaZxfSuzUQueDcoPSpZJcWiOhytlr4DjUmxaRtjrQGx6X2mDKM00n5NCuEZ7V7bA/Kz3HREtYhAAuxW60/bapVjcvgOVK80YENlWQ8nma4Yt4QyhAj20pyomwuMH7BBIarDQKYNHSqzqKmZk1wZDCReCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVZlSX7bLJC56I6uEv5PLlrPJlx/frEOeaIhGcE34fg=;
 b=VCmbAAtlRzeMBO1qeFgriZu5XbsOGxlBzhzEOvrTfgQia663xz80m2A/4HanAFTesENDhEy8ErGj9Vh9O5G6eIDVWbbaMKLQtxvjfeLiqBFDP5aufNT8f3cvXgte1VMqckAAOhNuH1kM9CgnyjSo8UZ+9rTSzzp0F3TkBdqjJylxIH+tVzgzclsmH3FOAeNPUePAfPwfsANo7pgiLpMWzeXV+HHwrbeTprWziGcVWKhgJtTgU6WcSm34d10md4NuRrjjNn/ZOvEBAjwWvztEBj06xsm+maQ4nTR5Hv8OXWkDaPb62RUUaPsIvV9FsdSlNqMNMckPUfAW7gbaAV9XRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 18 Nov
 2025 19:09:02 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:09:02 +0000
Date: Tue, 18 Nov 2025 15:09:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>, jasonmiu@google.com,
	graf@amazon.com, rppt@kernel.org, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com, hughd@google.com, skhawaja@google.com,
	chrisl@kernel.org
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems
 callbacks
Message-ID: <20251118190901.GS10864@nvidia.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-7-pasha.tatashin@soleen.com>
 <aRyvG308oNRVzuN7@google.com>
 <mafs05xb744pb.fsf@kernel.org>
 <CA+CK2bAqisSdZ7gSBd7=hGd1VbLHX5WXfBazR=rO8BOVCRx3pg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAqisSdZ7gSBd7=hGd1VbLHX5WXfBazR=rO8BOVCRx3pg@mail.gmail.com>
X-ClientProxiedBy: MN2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:208:15e::42) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf038a4-85ee-44ee-87cd-08de26d5efb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?53A+jsKG+6jFpLUOSg/MaczEkhACMsxlzR84T4+ioXw/52JPsjgNj8BLWtPE?=
 =?us-ascii?Q?Dh2ltSc5GXc5C6zZdNsU8lutjC0bIeqc4ZpNqESOf6vUiSVahn11QOFyqIsJ?=
 =?us-ascii?Q?g6HLyUgoxGNUbVogdKD5yqKCBD4ByHhdASLIT41jFmCkVbv4ot/OHcAbwLfJ?=
 =?us-ascii?Q?RLeZk0a9FHp79IG16fesQzvsUq+mvR4FiKP7LdBz5AWpxo3PoZekDMbd6wL5?=
 =?us-ascii?Q?4EXWfPnqmv99M7497q0Gefgb9MjHbMOvCUa5157s3sIFjSm5rvZ/v1t87MDL?=
 =?us-ascii?Q?8YXR9DWcOWIZqijeptj4uK4jWtdmlrxghGNEdw3wgH4u9tyYnijdsyNIkgfC?=
 =?us-ascii?Q?UwTy+uh9jwUtn8hGFtOtc5ZOt0s43GHPEmosKkUnCN+rP0xENU+6Yv6jjO2P?=
 =?us-ascii?Q?8HokrVIBdmT3c8bWxSDGbwlPl1rVAkQ4UAgHbJQp4WZ4Vha/Cu9JTY62dHko?=
 =?us-ascii?Q?b9ztpffipHZc0q/zNbqL5O/tPfg6ccKIzvxfpDmd5+stm3k/qSjTiOgrg1HN?=
 =?us-ascii?Q?qYmpIpOiT6t+2qxtYPJEsvgS658MSpiQZIv07v6uqZ6TZCWULDRSHUzxCce8?=
 =?us-ascii?Q?ykjSynWwYq1qaDtuY+sla1gR32kiTR4dAzN+5aQAtzRBKOwMnOJEF1K+9obs?=
 =?us-ascii?Q?twDRDI2MdXlfuJflvRpMb/9ZXtMxTvgxadKZYIyk9gjWzXnzsCvdAtxSa9bL?=
 =?us-ascii?Q?lvHk3eCiLAzoj3ZdSLUvgt8CC4MuicG2sUJHmfI+yaypSlRIgz5eQneu4jIP?=
 =?us-ascii?Q?x13JapWKKHsmXTpgBsmslBmar8vR0sR48ZXnIeGInfJUELINcrqRVJNcUjB0?=
 =?us-ascii?Q?iPa8RxeXiYGG+mJki75XMRz+I03wapugIkj/oR5BRdMiafvOnW1xa+9UD0Xf?=
 =?us-ascii?Q?oRZmvfhBT5T/IcaklJkAL562utK8JUowfYLd6S/FnLo29j6glCVClXlPD5MU?=
 =?us-ascii?Q?/3G+4JLQ35pHkaZpFjviUqlDpkkihhalVANBK6qiMRCC3sE/nUNTfNrqrKAh?=
 =?us-ascii?Q?k4I6IGgJmXqfDHpYtdXqAakMEkRbJMfrbcTkHs/tncCzDGW5tsrA3xX644wi?=
 =?us-ascii?Q?NqNDtR2ZsYHY8boShrCnxgGlrWWNWOTSMR14ggRIEWBE2JJ4lksjREkSBgml?=
 =?us-ascii?Q?gaa8wsee2cksBUPMt4Tccm4TpQdcaBb9GWPSVkmYo4eOT496Tg1VCmBDeIDu?=
 =?us-ascii?Q?sGgmPB7uXrTFuUhu0+qBeqa2WWcuivrunYM7jvx7Kiu4IdjCyk4GQk+qiFBW?=
 =?us-ascii?Q?YGChd2C8ZncX7DvYlRrxrrZUQ4RgX0Xojl8I2osGnqOg4MXF/nXvakV6vOPf?=
 =?us-ascii?Q?sHTvcS5+T5qhVlHk7hNdofyjdoLawPrYvuO/1tLilB6pmxs7zhCP80fr9odI?=
 =?us-ascii?Q?lvICA2QOknFbdGCM5XkqAwq7fLPGYX6NTz17IyFE36LizAfP1vD5tL7si/ka?=
 =?us-ascii?Q?acUUo2JTjN2htYkOdqnlLDIokv7xWhFp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJDqb71ZbNyi4Ifl6xSIcKpHizU/ewdFSMbBAD4OImJ5sSS7ck5trTvcMlXo?=
 =?us-ascii?Q?hCvl3HBSnrl8T6mdaVbLXRH8EUDsjmA1CgcuBk2yZwLLQ84WZ69+4d+Z3ROd?=
 =?us-ascii?Q?hT/a39fGPZSuLXJQfAfEz8NqBavdlX3/JiknSsp1be7gP5g4P7Z//ShImfpG?=
 =?us-ascii?Q?2FaP+i/rl9d37vDhiGPcdwPFUwKuPLglH1H7+0AbyMI07AnJMYVxo3yiPlQZ?=
 =?us-ascii?Q?Pi2zbBe8BX2NluOU6vIEFMWmNKHHZKrcShV0FZ6Lud9LYBuC7nQShSNE67wq?=
 =?us-ascii?Q?NLcS5LiKCI+JtK4aJmAJ9l/5wlRoM37cymdhaJRzo/Sg6HI2Slt7r5cZrS0N?=
 =?us-ascii?Q?/mtI5dULOADaR8Y43YoG2UlJhaWp6F1x11azbnZKjl/P4jVheKh5w86fxvhD?=
 =?us-ascii?Q?lxmHnyepzHMpsH4cd2psX9Lnvx2HdPEvOR/wBIMdZPZ8N/XH3lG1eAGiG5WL?=
 =?us-ascii?Q?hlrMcJilYxxBcTMllfd6ktjqs6Ai1w5NY0gbZonsiEH9ud+v+Ba5deZ2Sr55?=
 =?us-ascii?Q?aqs6iqqr6nwG/o7jnE8XBAIQ1PDxnBy32rMjDILQpUBx5Dn1+9mnK9D+g16m?=
 =?us-ascii?Q?+SJ1ISl3JLhYi/ku8YI6I4Lmsn2a/k9kL8c56bRPzA7oQb8Gkst2vBTU2glR?=
 =?us-ascii?Q?fG8Zivq4Yn4ALSttS8gIlFqvpOCyI044p9dbuHHBp+GOb5LE5xsbSBqDP+Am?=
 =?us-ascii?Q?hGmpN3OLWz42dmWOzAjhttSfD1ou7OUqHJ186YFOR4TmIMdYLokK7L5+WGDy?=
 =?us-ascii?Q?ZxBep1Q5j4Ip+MqEPiWitN5sYs2kgjeZ6ugcWYN52S3teBFLbyqhfBPkPQIc?=
 =?us-ascii?Q?LWo4P1xP+L8gCPBDC0QcJXnQ5sr2ms3wAmYimuj359ojQNJjsZO2NixmjejN?=
 =?us-ascii?Q?uUlA8QHEJDb8knysylbS9MbQkc40qKAYwY68qUqiWkrEJeOCgilk9bRmLFHZ?=
 =?us-ascii?Q?EsomH+31KahmKfTeGMmXlbged1L6O9alJ0N6cMEBzofs81t1MywVJm78La6m?=
 =?us-ascii?Q?VjmhZ7gddCMjx7WV+sqUbDvMSlJPag+hn9ouN8mEgOjZMGJHTWFFqsRZtbUe?=
 =?us-ascii?Q?FkebKapSb2CZIK+TvglCrHzQS4EeTsHFEZgovpavS6UKM57+cRrpFo0jn2wb?=
 =?us-ascii?Q?ZhR6D/X2hG+JHYpqhw2t+COVuMtaNSjWa/pp7YNPu5nog6xE8TfP04ybTtPu?=
 =?us-ascii?Q?NPiyK2DWjO5LOhcw50qmyqYToV/To7sX7W/EEwidY1HehYlnBnLRLKycGaTW?=
 =?us-ascii?Q?K3ifqC0v/G/fkG7zJRltgume0iguXTk3TRENgmivEsyq+kR3ASsR9ug9azCM?=
 =?us-ascii?Q?vYJHK9/Qe6t/pk7FyMdQUqAPM9cRyqSbZHHOEoK+/vMvp0AMk05RfxjM9hMk?=
 =?us-ascii?Q?irGlqzy4Lsc10kU8zFJksl/M2LB3wjE4aNFm9ie7iDAmXRJfLCmkwy5G4xX0?=
 =?us-ascii?Q?+s7wNUQ/59CfpM8fGOML/AoG938PtzVto2H57wtsY5bGp+0F7BUtvUHh8Afe?=
 =?us-ascii?Q?KgJQn/ae3pA6zgDlUGT3bCrp2/Z55djW4Zj984MiGieOS3S/wsgZOrhK+XzR?=
 =?us-ascii?Q?aw3vtV1Kf7LKo2vg6BM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf038a4-85ee-44ee-87cd-08de26d5efb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:09:02.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70N1Aw4PAclUvKoqA/5G+SIjan8xtGoRmFuOVgrDtK8EGBkZvHJjHm3S3Q2+um/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

On Tue, Nov 18, 2025 at 12:58:20PM -0500, Pasha Tatashin wrote:
> I actually had full unregister functionality in v4 and earlier, but I
> dropped it from this series to minimize the footprint and get the core
> infrastructure landed first.

I don't think this will make sense, there are enough error paths we
can't have registers without unregisters to unwind them.

Jason


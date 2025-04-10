Return-Path: <linux-fsdevel+bounces-46165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD92A83A1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 09:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68871B65548
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B8204C1D;
	Thu, 10 Apr 2025 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="njsDqwKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E31149C64;
	Thu, 10 Apr 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268498; cv=fail; b=n5zmaJ3EuER7At50Y49aIagzHSqcvDp5kYvcP1UULjvperXxkk3iVpwOwGKG6G3AADfX09IWEyY76g9JkAF+YqKiveE91Q9MZ5zgVy8CWy/Xeta6KRj+dqhSOT4YM0zNyk/lMFjhcV1A9mRAQXsIOJ+EhW88xJKcUr/fa5ZnQsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268498; c=relaxed/simple;
	bh=ALjRheLSp5rNARy0omKDpUizg4KhIJW9nO4+/QnexGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QqFlWxV9E4U9682/FDaYvp2al+NwDx+i1nus5ErC+t0O7rVgUJY3RUXDBoTyKtengIWNw4SKn6RZHyz0+TOPQMtCY6pWENSSlHRU7bnzPcsKaGJTY0lxD8AwWAHAklqOcRA1MzwK1M/CdgLChi+Qa5m8/j7uzHbtKWPaEPOLisc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=njsDqwKI; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx0ekJ8NLOJcMs7jrlrNFmE9Mb4YT+n+5GLlzD7b0uDS3HYYaOae/y7ZCZ/WLt9tjQ+/QJmGTT+irCXVlUzv3iWqaH4LweWW1pE5POsWGd1X0JbrPn1SbsPvEKwxrFaUdk/YiOOqJu4TZ7nTTYNEKqp0xmkdyjukTpgxj8rvuTJlYJUrT7bcgxSVrA365sOr99stf/7X6KakKwVEMvjieukzNN7DWfDvA917IgkwB1S/HiZbAeimUshlN6XwxUegJ8v/knMimKL9jsYbBRPadTDdz9bnQVRDeML8tgES2EC4I7nMt9HE2dsJly8j7obRtdddqYa1uiQp91qAjUu3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzmr4+VBAx2kw3XjRBEZQeDRKDDtZ2upD5Bp8zddiWQ=;
 b=DIPJwXgiXXO9MINe28zErPE+suTYTX/QuAvdm6pEPk2lB8hve6q08sStv1UDFJcnDLy0LQCAGh5xwaaJEmXN4rh2SxTvgIlQpm/m4jYNtXA3+Qq0Ha5DZq2r/YYkLH8QisHBBEAvWlSqOJ3ldl90rJGXM+wLnd5CkAQUfJtiLQ7h3nzxPShDsZPe3r68Sn//8Mgo/+pxX6zfKfRSip2hAtmivO0tiuDo6o9/awPXyQ7bDA2J1njp+7Qq+KIn8sn+EwM+PwjouAva2oMwgt89RiLfi3akk1k5mcO54ojZcCvJNkmgk9xJchPezor4P4T3yWH2k96oPtNiK4KWYBhZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzmr4+VBAx2kw3XjRBEZQeDRKDDtZ2upD5Bp8zddiWQ=;
 b=njsDqwKIrRg+MlAPThJkaXPW6ZhTtfb4dhmh9j1+2t7LsmejjQ5+HbEepd36m59G80sfQpyKwRn4uO4mkW5BmILe3eQyxokE6WzzR+41DAoshUzRu/MPgX+DvpugQM78KpXq+MCfzcugIVMLyNxjTdMLnpnLNHy2lIWu9OcjPQ1id+CNi3+lGLmiQgEWS5JQkEOJk4KNLuU3vsfNAJyDnyTeVzGqRbWN4Dz8WaZLcDqRBnheePI7QfTH2iWKSpZ58rf6/UsQ3Y3tGVviA/MIy5omKn53N2PP/ja9y6WIRO3Bw4ACpaYcH60aGCq4a3N6Kq2eMGCK/1+d7Xy7sO9ipA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.22; Thu, 10 Apr 2025 07:01:32 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8606.035; Thu, 10 Apr 2025
 07:01:32 +0000
Date: Thu, 10 Apr 2025 17:01:26 +1000
From: Alistair Popple <apopple@nvidia.com>
To: kernel test robot <oliver.sang@intel.com>, Jan Kara <jack@suse.cz>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Asahi Lina <lina@asahilina.net>, Balbir Singh <balbirs@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@redhat.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, linmiaohe <linmiaohe@huawei.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Matthew Wilcow <willy@infradead.org>, 
	Michael Camp Drill Sergeant Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Xu <peterx@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, Ted Ts'o <tytso@mit.edu>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Vivek Goyal <vgoyal@redhat.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [fs/dax]  bde708f1a6:
 WARNING:at_mm/truncate.c:#truncate_folio_batch_exceptionals
Message-ID: <v66t3szdfsfwyl4lw6ns2ykmxrfqecba2nb5wa64l5qqq2kfpb@x7zxzuijty7d>
References: <202504101036.390f29a5-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202504101036.390f29a5-lkp@intel.com>
X-ClientProxiedBy: SY5P300CA0028.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: db685919-9a44-4dbf-92f6-08dd77fd8659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rlJ9uToR+78RJW4n+p/QF9JvZCOTBrA/fIX2rX0ZgntuQ2gbelzHwI/BHRGy?=
 =?us-ascii?Q?Zto0fYfubCZSr5j8dvaxm6dv1EXnKxDU/3wp8/1eXMKhVjmUq3X0HelJ27kg?=
 =?us-ascii?Q?K5X+uXceoexVxpDFwGwadtBUqQwGEkjyOoqYmvRAbnVzixVK7Dab+fr28tfP?=
 =?us-ascii?Q?kQUdf0s7xW2JLVsG4BA8dxAHxnJ7PGSj3rnGk9teWVD0nvC1sqWp8KSrrFg3?=
 =?us-ascii?Q?gqVeGkR1IMnObRnbN1JS7JnIKgQeznPV2tc78awfQ33AFsolnRGT5ka8CeZC?=
 =?us-ascii?Q?1Og8ufLf0j1/iKjyXUa4fBw9KYqpuFmQTFEuntOFWaSGGCLA4B5g7O0D610/?=
 =?us-ascii?Q?PDMk/8ovt6dJn+JrsXeGlxIWwuRDfoWwGNVVyRbRzS+MxgNbDZhajKC4dBwA?=
 =?us-ascii?Q?lgCMV9fvp6CLyOHtSU52wxpdefoKG+b6oJo4r/eQeGAgGl2RZEtqrMD2Bk7N?=
 =?us-ascii?Q?S0y2c1jfgddXC7z2fPlqtqHkUrOTwyEgZluNk4EfUQE6O/w22GmlW98MveWy?=
 =?us-ascii?Q?O3vHzjJBN5wnAAk4/x6dhkBmaoExG1Up+vxXR2rMDeXLAj5Xss/SJeFht6o1?=
 =?us-ascii?Q?dnCWtApSHgtYHOJRjPJ2wO3CHzkHIu35ABRQhEYe9yJceBi1f5aBu8EXlKbB?=
 =?us-ascii?Q?xEQwJf9X1XbpKdvgzE0VR4MsSjGsV/K+lqI8muNvHhIEId0Y7rekL8OYq+Op?=
 =?us-ascii?Q?oaOV+Qgtmy8XIuQX8xqKJEot62db/FA6ypCIhbS/tLBQwk97IzK9NvQvdtyS?=
 =?us-ascii?Q?uX0V4WM8ORgmbOFab52aXL9x+FOxnVt949bFyIpDgVBn2sGP9NNNmOQU+XUu?=
 =?us-ascii?Q?0QgjZ7n7260EqwZCmAqi9MGImcb0gc8FAluitZULVaPWwUuXP4WVhMhcS5WV?=
 =?us-ascii?Q?xCo262snoPvyRJhwNYvJvOsp43F7clI1aLo3cdCj+MvibQ1dxUqz73ADJVFw?=
 =?us-ascii?Q?qadA7S7ExEnELYLy77YmvAKlCcRwCntzWjCcGqb+YKgnDWNhOdnNHbcNmalS?=
 =?us-ascii?Q?9Ht8J3tfMUR3yuCCAfLi3iBFv/0XMfkST2f4WbaLvO2yXbirCdYOC86PgP4M?=
 =?us-ascii?Q?3JhUOOiJQUkpc5RLlsomPB7sHACKzBkIlMfIH+02bKNL21Q56OkEZe3r4Qco?=
 =?us-ascii?Q?fInelyIwZ19kpA95ebKEaY+XbhZMCx400D0xCiVTp+3cbEBN0RuwZfjPHg0g?=
 =?us-ascii?Q?5oA2n3511iOuGbl/RgZQEKrj8f/KQTqtiZDrYveNQ0w2VX+EdlNY81kkjWWj?=
 =?us-ascii?Q?fC5YUJPHTsw3nNDaJ/snoaXT7P6xTsNQvcqCc5UKmGbAOKYmvI3bP2Aimcda?=
 =?us-ascii?Q?d/zOjF33QymRfH57jIkR6U8dMPclUTK2eAJH1AG3+HZLtM1+6sPMC0ErnzL9?=
 =?us-ascii?Q?r5tSyH4+096tgYEu6ZwMkSKzxxirKzDzVWCBreBJb/ymKB+qA1XWLyLoNfJJ?=
 =?us-ascii?Q?rjmN/dw0mvk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sKsrmXahJ8Na4WZqM2BU65WLoI8Z9HkQOWrYmqepWaFfnIOJNQn/aImyCoSX?=
 =?us-ascii?Q?FMFM6ZtfNFgm8dBz1D9Uz7kA+WRgtCv3gu8M0ddcaqQik7gjVd0dCEJXWrv7?=
 =?us-ascii?Q?qer5s6dWu9lBOI1BevXjqu/fypQjhV08a4j3EZnN3UA+IKugc505CZwmlwmg?=
 =?us-ascii?Q?2a2DTItaucaEMIYyFdeAdB+dyQFMOUa3LVqRkTMhK6bcTihcCIx4KM2SfJ72?=
 =?us-ascii?Q?nCbFuAhurjsklfo6qYw074Vq5ItA/9TgpWreVd/4PnRfqnerP088LvR2cqU5?=
 =?us-ascii?Q?dRMPrxEjUBKqc+sLG/gpmLz/ezzpk8v/6SBaABAu2KZ3d0uhR+pUrzK0LAjE?=
 =?us-ascii?Q?MHhcn2xW+5+K/HTpBFhErUMqwXc1Os3z8XGocxr+aFYSrvU9JqS4qBUGlgZw?=
 =?us-ascii?Q?H3KGHl3Oy67/VW+sdD3iKbozh3lnxHuuB4fKKO2OB+XwQ8nmpGr1/rwb8DE1?=
 =?us-ascii?Q?+wzPY2kk7tKnP88ZX5GPwDz4jz6sK9J6EbKNM07Oe0VnD/JqssTCcA9DcneO?=
 =?us-ascii?Q?YywKg4takUUqNFj1S8YG4/lYeZ/QmEngy1LkObxrFgJr9sL7A+mkxY0EMLN5?=
 =?us-ascii?Q?YcBSNhR38ZZz1MhRVGRZcvjXSenBIfrEpXcmSpwHI9pfd3k8ThHMExJqisuJ?=
 =?us-ascii?Q?FrHQhfYTpwaIptJaa7MXL0mMCZS9AL1/UYtP3SX3Wyp1JSpL+lXo0x4aAgkL?=
 =?us-ascii?Q?1ODy875jn4BddzYKEgHFbqEJcFt4+LQdGbZ1crO5v1zg+VGVnoL1OUrv3rpu?=
 =?us-ascii?Q?U6AfsC3ajL1irmosNS7RXXg2RHeQ/ykMl6F3dxEyU74kPNcuPFOh7GW0bByZ?=
 =?us-ascii?Q?WX6HhrJVF5BHhLZWuoo1xLqh0DUIt6o1dHtBlEUbE3VEI0nyz9jx1drG2cl1?=
 =?us-ascii?Q?J4ghCa60wrMN8gmeujHev4w8gqnI8QSNlOUWdXDSb4wczvDR8HcPuQUqrr8C?=
 =?us-ascii?Q?PyMiOrjrXWVJMMZtVSxRNDV3/zAMi2xBr203ukMVwaCSYA+KX3ZeLBnMjj3M?=
 =?us-ascii?Q?9ajg4wTCjm3Wx0SP5nQ7W4+Ha4NMHg41BYkVujlQIvlBBJiZIUUOUpbf/+5p?=
 =?us-ascii?Q?rcFaIoErFsZBtukWUfbYlqEgPdr97PVgk0+fvGzpPCPUnz8QkFucwpQ1Zbij?=
 =?us-ascii?Q?N+w2J/xcCQearaJKzfd0vTkQFCvtXq4GS9LWBpa2a2pxiwQD1GHwAYVXLOzM?=
 =?us-ascii?Q?abjYzfMZDzdsP6Ke9J0PDCpwfZks85HSzFdqBfeyiNFaN1/cPJfhR5Z/m7h+?=
 =?us-ascii?Q?U2ikXdp5OpkxD5JL9+As9L+Sa/CAvr6FasZ7yY2BLhxYUIx664vhwZ8Ijfvm?=
 =?us-ascii?Q?oA6tSUNw5hNDHxbLk1rpbYcTlYwKyvMSve4/W2jOEcRCgq57qARImurFbAP2?=
 =?us-ascii?Q?/XBSyu8TE0Kt9RoAawol+Ww2Z99BA8BD7dZttVD8b8ipYmeBNmnGR5gFdjVL?=
 =?us-ascii?Q?GT3qz9lQ3GV6K6TFoMncbqoBStsFzs/mzVaPgti6KKtula/Hvy5siKwKXs0y?=
 =?us-ascii?Q?q2slqCnWaBz0T6rAj6u8Z7VLslu0YMTmapCQaEwVyzmf+FRhyLMfAzfASwV3?=
 =?us-ascii?Q?YviKcFU71GOQ+wTO67r9PU6YeZx1//J3CqiogczQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db685919-9a44-4dbf-92f6-08dd77fd8659
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:01:32.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PckCVQgzqHz4pocjEX91x4gZ3gfzzrG8exQqc7MsTATB1yXh3mL5IfP5yf1i9I8euaHC0famWQfl2c2za37TKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

On Thu, Apr 10, 2025 at 01:14:42PM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "WARNING:at_mm/truncate.c:#truncate_folio_batch=
_exceptionals" on:
>=20
> commit: bde708f1a65d025c45575bfe1e7bf7bdf7e71e87 ("fs/dax: always remove =
DAX page-cache entries when breaking layouts")

This is warning about hitting the bug that commit 0e2f80afcfa6 ("fs/dax: en=
sure
all pages are idle prior to filesystem unmount") fixes. I couldn't reorder =
that
patch before this one because it relies on the DAX page-cache entries alway=
s
being removed when breaking layouts.

However I note that this is ext2. Commit 0e2f80afcfa6 doesn't actually upda=
te
ext2 so the warning will persist. The fix should basically be the same as f=
or
ext4:

--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -74,6 +74,8 @@ void ext2_evict_inode(struct inode * inode)
        struct ext2_block_alloc_info *rsv;
        int want_delete =3D 0;
=20
+        dax_break_layout_final(inode);
+
        if (!inode->i_nlink && !is_bad_inode(inode)) {
                want_delete =3D 1;
                dquot_initialize(inode);

What's more troubling though is unlike ext4 there is no ext2_dax_break_layo=
uts()
defined, which is how I missed updating it. That means truncate with FS DAX
is already pretty broken for ext2, and will need more than just the above f=
ix
to ensure DAX pages are idle before truncate. So I think FS DAX on ext2 sho=
uld
probably just be removed or marked broken unless someone with more knowledg=
e of
ext2 wants to fix it up?

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> in testcase: xfstests
> version: xfstests-x86_64-8467552f-1_20241215
> with following parameters:
>=20
> 	bp1_memmap: 4G!8G
> 	bp2_memmap: 4G!10G
> 	bp3_memmap: 4G!16G
> 	bp4_memmap: 4G!22G
> 	nr_pmem: 4
> 	fs: ext2
> 	test: generic-dax
>=20
>=20
>=20
> config: x86_64-rhel-9.4-func
> compiler: gcc-12
> test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake)=
 with 28G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202504101036.390f29a5-lkp@intel.=
com
>=20
>=20
> [   46.394237][ T4025] ------------[ cut here ]------------
> [ 46.399593][ T4025] WARNING: CPU: 7 PID: 4025 at mm/truncate.c:89 trunca=
te_folio_batch_exceptionals (mm/truncate.c:89 (discriminator 1))=20
> [   46.409748][ T4025] Modules linked in: ext2 snd_hda_codec_hdmi snd_ctl=
_led snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component i=
ntel_rapl_msr btrfs intel_rapl_common blake2b_generic xor ipmi_devintf zstd=
_compress ipmi_msghandler x86_pkg_temp_thermal snd_soc_avs intel_powerclamp=
 raid6_pq snd_soc_hda_codec snd_hda_ext_core coretemp snd_soc_core snd_comp=
ress kvm_intel i915 sd_mod snd_hda_intel kvm snd_intel_dspcfg sg snd_intel_=
sdw_acpi intel_gtt snd_hda_codec cec dell_pc platform_profile drm_buddy gha=
sh_clmulni_intel snd_hda_core sha512_ssse3 dell_wmi ttm sha256_ssse3 snd_hw=
dep nd_pmem sha1_ssse3 dell_smbios drm_display_helper nd_btt snd_pcm dax_pm=
em mei_wdt rapl drm_kms_helper ahci mei_me snd_timer libahci rfkill nd_e820=
 intel_cstate sparse_keymap video wmi_bmof dcdbas dell_wmi_descriptor libnv=
dimm libata pcspkr intel_uncore i2c_i801 snd mei i2c_smbus soundcore intel_=
pch_thermal intel_pmc_core intel_vsec wmi pmt_telemetry acpi_pad pmt_class =
binfmt_misc fuse loop drm dm_mod ip_tables
> [   46.498759][ T4025] CPU: 7 UID: 0 PID: 4025 Comm: umount Not tainted 6=
.14.0-rc6-00297-gbde708f1a65d #1
> [   46.508156][ T4025] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIO=
S 1.2.8 01/26/2016
> [ 46.516324][ T4025] RIP: 0010:truncate_folio_batch_exceptionals (mm/trun=
cate.c:89 (discriminator 1))=20
> [ 46.523347][ T4025] Code: 84 70 ff ff ff 4d 63 fd 49 83 ff 1e 0f 87 d4 0=
1 00 00 4c 89 f0 48 c1 e8 03 42 80 3c 00 00 0f 85 9b 01 00 00 41 f6 06 01 7=
4 c6 <0f> 0b 48 89 c8 48 c1 e8 03 42 80 3c 00 00 0f 85 d6 01 00 00 48 8b
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	84 70 ff             	test   %dh,-0x1(%rax)
>    3:	ff                   	(bad)
>    4:	ff 4d 63             	decl   0x63(%rbp)
>    7:	fd                   	std
>    8:	49 83 ff 1e          	cmp    $0x1e,%r15
>    c:	0f 87 d4 01 00 00    	ja     0x1e6
>   12:	4c 89 f0             	mov    %r14,%rax
>   15:	48 c1 e8 03          	shr    $0x3,%rax
>   19:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1)
>   1e:	0f 85 9b 01 00 00    	jne    0x1bf
>   24:	41 f6 06 01          	testb  $0x1,(%r14)
>   28:	74 c6                	je     0xfffffffffffffff0
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	48 89 c8             	mov    %rcx,%rax
>   2f:	48 c1 e8 03          	shr    $0x3,%rax
>   33:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1)
>   38:	0f 85 d6 01 00 00    	jne    0x214
>   3e:	48                   	rex.W
>   3f:	8b                   	.byte 0x8b
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	0f 0b                	ud2
>    2:	48 89 c8             	mov    %rcx,%rax
>    5:	48 c1 e8 03          	shr    $0x3,%rax
>    9:	42 80 3c 00 00       	cmpb   $0x0,(%rax,%r8,1)
>    e:	0f 85 d6 01 00 00    	jne    0x1ea
>   14:	48                   	rex.W
>   15:	8b                   	.byte 0x8b
> [   46.542938][ T4025] RSP: 0018:ffffc9000d74f370 EFLAGS: 00010202
> [   46.548900][ T4025] RAX: 1ffff92001ae9ec8 RBX: ffff8881e2d959d8 RCX: f=
fffc9000d74f4f8
> [   46.556787][ T4025] RDX: 0000000000000001 RSI: ffffc9000d74f638 RDI: f=
fff8881e2d95874
> [   46.564676][ T4025] RBP: 1ffff92001ae9e74 R08: dffffc0000000000 R09: f=
ffff52001ae9eec
> [   46.572557][ T4025] R10: 0000000000000003 R11: 1ffff110d4bf8d9c R12: f=
fffc9000d74f638
> [   46.580439][ T4025] R13: 0000000000000000 R14: ffffc9000d74f640 R15: 0=
000000000000000
> [   46.588319][ T4025] FS:  00007fe696f3a840(0000) GS:ffff8886a5f80000(00=
00) knlGS:0000000000000000
> [   46.597163][ T4025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.603691][ T4025] CR2: 00007fff266c5ec0 CR3: 00000001ead7e002 CR4: 0=
0000000003726f0
> [   46.611586][ T4025] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [   46.619468][ T4025] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [   46.627353][ T4025] Call Trace:
> [   46.630520][ T4025]  <TASK>
> [ 46.633337][ T4025] ? __warn (kernel/panic.c:748)=20
> [ 46.637296][ T4025] ? truncate_folio_batch_exceptionals (mm/truncate.c:8=
9 (discriminator 1))=20
> [ 46.643697][ T4025] ? report_bug (lib/bug.c:180 lib/bug.c:219)=20
> [ 46.648091][ T4025] ? handle_bug (arch/x86/kernel/traps.c:285)=20
> [ 46.652322][ T4025] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discr=
iminator 1))=20
> [ 46.656905][ T4025] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.=
h:574)=20
> [ 46.661838][ T4025] ? truncate_folio_batch_exceptionals (mm/truncate.c:8=
9 (discriminator 1))=20
> [ 46.668239][ T4025] ? __kernel_text_address (kernel/extable.c:79)=20
> [ 46.673356][ T4025] ? __pfx_truncate_folio_batch_exceptionals (mm/trunca=
te.c:62)=20
> [ 46.680123][ T4025] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)=
=20
> [ 46.684782][ T4025] truncate_inode_pages_range (mm/truncate.c:339)=20
> [ 46.690407][ T4025] ? __pfx_truncate_inode_pages_range (mm/truncate.c:30=
4)=20
> [ 46.696546][ T4025] ? __pfx_i_callback (fs/inode.c:322)=20
> [ 46.701292][ T4025] ? kasan_save_stack (mm/kasan/common.c:49)=20
> [ 46.706032][ T4025] ? kasan_record_aux_stack (mm/kasan/generic.c:548)=20
> [ 46.711298][ T4025] ? __call_rcu_common+0xc3/0x9e0=20
> [ 46.717279][ T4025] ? evict (fs/inode.c:772 (discriminator 2))=20
> [ 46.721236][ T4025] ? dispose_list (fs/inode.c:846)=20
> [ 46.725751][ T4025] ? evict_inodes (fs/inode.c:860)=20
> [ 46.730339][ T4025] ? generic_shutdown_super (fs/super.c:633)=20
> [ 46.735699][ T4025] ? kill_block_super (fs/super.c:1711)=20
> [ 46.740447][ T4025] ? deactivate_locked_super (fs/super.c:473)=20
> [ 46.745905][ T4025] ? cleanup_mnt (fs/namespace.c:281 fs/namespace.c:141=
4)=20
> [ 46.750400][ T4025] ? task_work_run (kernel/task_work.c:227 (discriminat=
or 1))=20
> [ 46.755076][ T4025] ? syscall_exit_to_user_mode (include/linux/resume_us=
er_mode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 ker=
nel/entry/common.c:207 kernel/entry/common.c:218)=20
> [ 46.760796][ T4025] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [ 46.765381][ T4025] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/ent=
ry_64.S:130)=20
> [ 46.771363][ T4025] ? blk_finish_plug (block/blk-core.c:1241 block/blk-c=
ore.c:1237)=20
> [ 46.776026][ T4025] ? blkdev_writepages (block/fops.c:453)=20
> [ 46.780864][ T4025] ? __pfx_blkdev_writepages (block/fops.c:453)=20
> [ 46.786241][ T4025] ? __blk_flush_plug (include/linux/blk-mq.h:234 block=
/blk-core.c:1220)=20
> [ 46.791152][ T4025] ? xas_find_marked (lib/xarray.c:1382)=20
> [ 46.795990][ T4025] ? __pfx_inode_free_by_rcu (security/security.c:1708)=
=20
> [ 46.801351][ T4025] ? rcu_segcblist_enqueue (arch/x86/include/asm/atomic=
64_64.h:25 include/linux/atomic/atomic-arch-fallback.h:2672 include/linux/a=
tomic/atomic-long.h:121 include/linux/atomic/atomic-instrumented.h:3261 ker=
nel/rcu/rcu_segcblist.c:214 kernel/rcu/rcu_segcblist.c:231 kernel/rcu/rcu_s=
egcblist.c:332)=20
> [ 46.806537][ T4025] ? fsnotify_grab_connector (fs/notify/mark.c:702)=20
> [ 46.811898][ T4025] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 =
include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomi=
c-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spi=
nlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:=
154)=20
> [ 46.816473][ T4025] ? inode_wait_for_writeback (arch/x86/include/asm/ato=
mic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atom=
ic/atomic-instrumented.h:33 include/asm-generic/qspinlock.h:57 fs/fs-writeb=
ack.c:1541)=20
> [ 46.822012][ T4025] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:=
107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/a=
tomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux=
/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinloc=
k.c:170)=20
> [   46.824528][  T331] LKP: stdout: 302: HOSTNAME lkp-skl-d01, MAC f4:8e:=
38:7c:5b:de, kernel 6.14.0-rc6-00297-gbde708f1a65d 1
> [ 46.826917][ T4025] ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.=
c:169)=20
> [   46.826949][  T331]
> [ 46.838033][ T4025] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 =
include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomi=
c-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spi=
nlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:=
154)=20
> [ 46.838054][ T4025] ext2_evict_inode (fs/ext2/inode.c:99) ext2=20
> [   46.847318][  T333] 262144 bytes (262 kB, 256 KiB) copied, 0.0043872 s=
, 59.8 MB/s
> [ 46.850251][ T4025] evict (fs/inode.c:796)=20
> [   46.855527][  T333]
> [ 46.863038][ T4025] ? __pfx_evict (fs/inode.c:772)=20
> [ 46.863056][ T4025] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 =
include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomi=
c-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spi=
nlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:=
154)=20
> [   46.867191][  T333] 512+0 records in
> [ 46.869033][ T4025] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:15=
3)=20
> [   46.873347][  T333]
> [ 46.877892][ T4025] dispose_list (fs/inode.c:846)=20
> [   46.881842][  T333] 512+0 records out
> [ 46.886610][ T4025] evict_inodes (fs/inode.c:860)=20
> [   46.888832][  T333]
> [ 46.893113][ T4025] ? __pfx_evict_inodes (fs/inode.c:860)=20
> [ 46.893135][ T4025] ? filemap_check_errors (arch/x86/include/asm/bitops.=
h:206 (discriminator 6) arch/x86/include/asm/bitops.h:238 (discriminator 6)=
 include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 6)=
 mm/filemap.c:349 (discriminator 6))=20
> [ 46.913439][ T4025] generic_shutdown_super (fs/super.c:633)=20
> [ 46.918627][ T4025] kill_block_super (fs/super.c:1711)=20
> [ 46.923204][ T4025] deactivate_locked_super (fs/super.c:473)=20
> [ 46.928477][ T4025] cleanup_mnt (fs/namespace.c:281 fs/namespace.c:1414)=
=20
> [ 46.932792][ T4025] task_work_run (kernel/task_work.c:227 (discriminator=
 1))=20
> [ 46.937282][ T4025] ? __pfx_task_work_run (kernel/task_work.c:195)=20
> [ 46.942292][ T4025] ? __x64_sys_umount (fs/namespace.c:2074 fs/namespace=
.c:2079 fs/namespace.c:2077 fs/namespace.c:2077)=20
> [ 46.947218][ T4025] ? __pfx___x64_sys_umount (fs/namespace.c:2077)=20
> [ 46.952480][ T4025] ? vfs_fstatat (fs/stat.c:372)=20
> [ 46.956809][ T4025] syscall_exit_to_user_mode (include/linux/resume_user=
_mode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 kerne=
l/entry/common.c:207 kernel/entry/common.c:218)=20
> [ 46.962348][ T4025] do_syscall_64 (arch/x86/entry/common.c:102)=20
> [ 46.966749][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/ir=
qflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h=
:232 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
> [ 46.972284][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/ir=
qflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h=
:232 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
> [ 46.977832][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/ir=
qflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h=
:232 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
> [ 46.983369][ T4025] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [ 46.987953][ T4025] ? check_heap_object (mm/usercopy.c:189)=20
> [ 46.992887][ T4025] ? kasan_save_track (arch/x86/include/asm/current.h:4=
9 mm/kasan/common.c:60 mm/kasan/common.c:69)=20
> [ 46.997649][ T4025] ? kmem_cache_free (mm/slub.c:4622 mm/slub.c:4724)=20
> [   47.000912][  T333] 262144 bytes (262 kB, 256 KiB) copied, 0.00767215 =
s, 34.2 MB/s
> [ 47.002474][ T4025] ? vfs_fstatat (fs/stat.c:372)=20
> [   47.002504][  T333]
> [ 47.010137][ T4025] ? vfs_fstatat (fs/stat.c:372)=20
> [   47.014750][  T333] 512+0 records in
> [ 47.016647][ T4025] ? __do_sys_newfstatat (fs/stat.c:533)=20
> [ 47.016665][ T4025] ? __pfx___do_sys_newfstatat (fs/stat.c:528)=20
> [   47.020981][  T333]
> [ 47.024567][ T4025] ? __count_memcg_events (mm/memcontrol.c:583 mm/memco=
ntrol.c:859)=20
> [ 47.024588][ T4025] ? handle_mm_fault (mm/memory.c:6102 mm/memory.c:6255=
)=20
> [ 47.024593][ T4025] ? syscall_exit_to_user_mode (arch/x86/include/asm/ir=
qflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h=
:232 kernel/entry/common.c:206 kernel/entry/common.c:218)=20
> [   47.029926][  T333] 512+0 records out
> [ 47.035106][ T4025] ? do_syscall_64 (arch/x86/entry/common.c:102)=20
> [ 47.035129][ T4025] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37=
 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1488 arch/x86/mm/fa=
ult.c:1538)=20
> [   47.037332][  T333]
> [ 47.042576][ T4025] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry=
_64.S:130)=20
> [   47.042596][ T4025] RIP: 0033:0x7fe697166af7
> [   47.048552][  T333] 262144 bytes (262 kB, 256 KiB) copied, 0.00560232 =
s, 46.8 MB/s
> [ 47.052938][ T4025] Code: 0f 93 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1=
f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 d9 92 0c 00 f7 d8 64 89 02 b8
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	0f 93 0c 00          	setae  (%rax,%rax,1)
>    4:	f7 d8                	neg    %eax
>    6:	64 89 01             	mov    %eax,%fs:(%rcx)
>    9:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>    d:	c3                   	ret
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250410/202504101036.390f29a5-lk=
p@intel.com
>=20
>=20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20


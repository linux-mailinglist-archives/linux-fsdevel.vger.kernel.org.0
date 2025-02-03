Return-Path: <linux-fsdevel+bounces-40588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD65A25825
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 12:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E563A84B1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385C52036E3;
	Mon,  3 Feb 2025 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F98VoQFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC5202F67;
	Mon,  3 Feb 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582150; cv=fail; b=V8iHNXw+nNTzX+QvGHtSoAcRGkQIuMugc2Q8pwpu1WEZxoSi1/QulkJAK/iZUWj+KmCtJGaW+PSGiT5Wjhy3KasIQz1V/PDcVYQRkEcejrLxt1JNYuIyUfuh2imX3qhpujRL2r8nlMWdEYEv0DUy5T+vd1z2k7q3XDNEGOa2AwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582150; c=relaxed/simple;
	bh=N+YzApbixCL/a3kU6kRDfv/5iDy5HYO8Fc7IFCLlNL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+FoVxM1acrzAvZuQh9hLIjvuXrGqjL8e4FWQYfOxSO7iyaMZ1n2GuxOGzDEQ3Xr32llVt0ici97XK5/Vh5WyJIV1tLfKZVHBBkvWVhRLzku7miiGtDC2Qu1tQQOe0uYrjAkZkr8jHfCsXrbW7e4d96Ikz5eGrI9Rw3oFB3D2Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F98VoQFl; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTt+lmpi7pgmjk7qtG9brrKuXXjN3xe5t5c2eUR0y4sELbCJnWedsCDA3VbQB8oc6qXtxb44VOk0q7EvWZbSI5UF+FvS363cB1Xhi7oh8uhiN4/thMrtVOoB5vzV4KFzZd2rcXbiTMV1/g9koSlJDT3wcQhXwNZv/vuzh/5j7yobbvlWZI2zdPHMgb5+5PuxBWLQ0UK5k8o5oyy+yr0ZIZ3uqmt382eha36XqM4e9hWnSQEbUmdWrSXd1AHR6F7/hw6ynaoBhcrEeR/rmL0izpMgQhwTNwAXUYmM9zEr2hSszJbc4WvdFZjCh8WTMvm+AcBM3pwOFQGR/TiJG064FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7ywY9Ly9nqrrmjFHGQ2lU7pYUZOYLE6hIbzl0gx1L8=;
 b=punzTbsOIrOkeC5PJSou2MOE63qbrkB1Ms9J+yXIKQY2k0I9u9pux/dV81rk9CFHsCPO1p8W92O6c9kUiCs0O37+WA85vJiZic/iqpnf4GraVdzeG3JqhtY8euHLxa7TwgyVKp63c4hSh3m5ixFXmLsvleiii643HoUEU53V+3XDRWNC7P8AjWFLIFaCFmTmCUShx1MulfN9gAkXVOXj3O/rSTlSsMdfQxpntKcAT3Ud9hbgpYKXvFFeRx21raM/XMRVOYEk9g7gYOJldQab8pkzX5gkmujETMZh/gAP986OjCQnKQPmymSve3Tp2i2E5r01P4FpW5DygZ2SLY/ZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7ywY9Ly9nqrrmjFHGQ2lU7pYUZOYLE6hIbzl0gx1L8=;
 b=F98VoQFl60+CILH4tkqO0+f1oYzeftgq9hsHcojqfPcqmCgCm9kgmk+n30jU8wLf/opUzqUdFicVkKLYkfdG7yqwStBK/gdB5pV9YnQJn+A9Tz2rmNCZfZ+TTNCd7UQoZ5kkLxWiiPcZaFFekZxKtomFdb0HYrzW4TgR6aQBYu1+9sxLDZYYke2UVoOKzeWl/3Bv52b6uH7RCoYuFjxcr90RlBgVFW+4WBJadmt14tCiVkQ/EWXs+Jo/Y+kSwVIwmXdfy5oPyl23F9xbkpRXoExE9+5wbIbkebAqkHagrojY2kG9XaifYQKOhQLZzpTYQs8hTRJgwbRZyO0PCQpJlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Mon, 3 Feb 2025 11:29:06 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 11:29:06 +0000
Date: Mon, 3 Feb 2025 22:29:00 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com, 
	gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com, dave.jiang@intel.com, 
	logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, 
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, 
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 22/26] device/dax: Properly refcount device dax pages
 when mapping
Message-ID: <7tmxffcwudefbm7bva4y54bnyp2le2fvtqkmm2ofdhyjvgjqly@4tkut3oxgjvh>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <7d5416ad49341207e5f3c48d5b9c4b7af5fd9ac6.1736488799.git-series.apopple@nvidia.com>
 <67860059b200b_20fa294b5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67860059b200b_20fa294b5@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SY0PR01CA0010.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: db614fbc-9548-4540-b6a5-08dd4445f7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gylG9C5g5TWrIygzRsoCq2uCoxPmTM8js5wAcnXYOSfJHcZdUV6htOKquNxk?=
 =?us-ascii?Q?z6dlWM/62xQqgL3zbR8JHUJ9p4MHKryYcxFg81s4UklMTjqMPm+eVz3pPNHg?=
 =?us-ascii?Q?LnME6v1fwcNN8CRtX3cXrMMCdEWZy/NkiOmXc0KGqqZXVpye5c1buLG99bjC?=
 =?us-ascii?Q?V3D5ZxtaoiQolYFKO9IpP4eek+FEO4JO/TP31/40WnVP2c4UiokSJOnX92HN?=
 =?us-ascii?Q?Zff9MJ1/eF316oE1hC0RYAVM+DSmJjmn5Ahd+qLsg9BafwWiBV73yccGIKm8?=
 =?us-ascii?Q?VL2cQP/sqWTQKwZ7TXO3QSyUFbTcKIyde1DjdizN4xLdwFZ6LoJFs5YhsWad?=
 =?us-ascii?Q?TmQwf9lXsAp+m4iEfITWlZ/c1U7QuiDFwsdntpxQ0z29ItdOUtr4l67+8RC5?=
 =?us-ascii?Q?GAuCOjktQkVWRZTavl/zsotsoIaI1wv4+6p+kFnTKp9QBNzEFIatQGYwDZm3?=
 =?us-ascii?Q?mbGz+iXyhhKA/l2+9L7zPmqiksbHFTu5fxdTLxJaqTXB5PxHVfaWoDOFM4fH?=
 =?us-ascii?Q?4vdVqJFylxRyJOlTMT/zNcE7NBxkvST9KSg3WOPeqixKMfOFtZXEAeJIOGjB?=
 =?us-ascii?Q?OjlrxjCrmTxDDr/tysVJqihkc+f3Keu6v1GCXv+iLpFMZqUu16AmWQIRIvGS?=
 =?us-ascii?Q?9GpURrugyTMtUFxdWTEgIF0ULzn3XQGYrNJIDOSc48CvbuEFdgWfXXEkGnoz?=
 =?us-ascii?Q?jvM6qSinRTtn0Be8eqcIs6K8F+gRy+VM5ifeSfhRjnbMvHy9kmWDACI/k9yv?=
 =?us-ascii?Q?L02sNbWAs8hVLxuCNBaSjRx77Jm4h5/QQ49zh8gO36TO+4BHuQcr9NmSf37t?=
 =?us-ascii?Q?te25cpOvbHg7XFs/02BvDM+9BcmjLelGvIXsIu9oyLoF3TchyRV9rTOgjq6w?=
 =?us-ascii?Q?8Vqs3Sb6yaexLO15+yDyEgnFTDYc/gW/EMHGyOIAihrd1S2N6lnfj+ql/Qa0?=
 =?us-ascii?Q?jsbXnopBg44i0P19bPC+aIroIE+d5K8Kvn3QxIIBxndSwnqF1y7JBeCFFLT7?=
 =?us-ascii?Q?4RGvuiiMI9gjzCQyfiyyCARXXHd1IEZLzOsyQnzsSaIWEtYIjPoxm/XMnXYK?=
 =?us-ascii?Q?fte9N8ysZddWyh/8F6H6UzvGI4EzSzRs2wQ76XZT/GIHCTN6j2yrcu4n27Yx?=
 =?us-ascii?Q?gY0akw2p6EtGKdHaeuem4NHv5E392S34czS8P4Ts8H3Y1dzHscckCqRA/26m?=
 =?us-ascii?Q?wCB5N8e59tHIZXi60SGN1QQCKjPC/hfNV7wGPL6+nXi+rnAvqqO9DVQsMc5R?=
 =?us-ascii?Q?GeAKKQv4oQ7XptIet4kfMSTEpJ9zNJDjGFjWezseK79Qqbn2jdZd2kXwA9sB?=
 =?us-ascii?Q?kF085nhcS23+wfDYwAurMjqKg0yrUdN/XWWjxfTs1ocEIx60d9w8fHEquAPE?=
 =?us-ascii?Q?tMywPfV+X6W5YwLf6oacHHc4ia6r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ceSRbDglHWg3TpQMMTMkr6RffGSCiw5TkB5m/nXdC7wv67f0tj3w0fV08XiD?=
 =?us-ascii?Q?uggrMCX7QDb2k5NfgbPWljp3unkG4VGMYtZpm73vW2za3y71kU9ajAApptzR?=
 =?us-ascii?Q?kbbmHnCvudT0KKmLGLye9/W6DBtl5YeV3McLMCngGduGsLs6L1uaIig8W6do?=
 =?us-ascii?Q?4S5earTYpfBvLuvV5RFvvSFlhssrww84i0mjorIAz7mixk4ciSeBLLQWBue+?=
 =?us-ascii?Q?NnbciFWWMbYIKJaGOb29V9BLLXgWqbBO2hddDTC7OIn9aHY3ew4pwJA82DP3?=
 =?us-ascii?Q?N4CVyI1jmamQrxy2ULTTbhagyIaaO+shX3I2bQZublQWJA4hdQXRYjMf5ZMK?=
 =?us-ascii?Q?QEG1DbhRo/q6VrV3Ft0efj2ILv5+gdbzDguDDWzTqUooLbK8Ll6IbDqubABO?=
 =?us-ascii?Q?14DJU0dnto9HVjYrZUcwoF5DqglVT9YHF38jiFHB0GopaPdcdLWaHXJx+Tmu?=
 =?us-ascii?Q?+zc6BAK08JPPl4nbSCSeSguJYMw8i4FIS2fzcfl6kGO3H45osdyfvFtn6tDe?=
 =?us-ascii?Q?dtUTmpPQNj4faSpYiTT4Yw61T2k4y3T8gVig1atNZ6aq6cjWIbahw0xHfds9?=
 =?us-ascii?Q?HIgfbGUtK1A5Kv1GfOuk6fkMXnezJDlFCBJcl0zARKrdgKsKu5YqlBsBLjhl?=
 =?us-ascii?Q?JSsGTM8Jx7tnbxkwpC6c9KX0RXmdW0Uf+/vd4p/QDbNcKszVRJHgcEl4iUUS?=
 =?us-ascii?Q?dLaiTspnZe0hZ/NW30W/aZacewf0C+zycGXgWhTW4UU4xfkJQtkhkj0QU2yY?=
 =?us-ascii?Q?qlFeNLDZiABiUK2X+Y/FmXse2oPROPUHNBIaB/3eIIuMXCSTd7FzZAv3p+V3?=
 =?us-ascii?Q?9q6nlZ4AZ9OCDRwvBJf5RPOmj9syYXKh6lLXXaiuMgar3J05IL5N+WK6GTFJ?=
 =?us-ascii?Q?DbwDLCz+ALuv3uVTzKhbuwXiYfSQoFcAJcXiPqD4TV0Ki6uzoPmfJqWMj/wE?=
 =?us-ascii?Q?4EKQVBKpCh9+ro63dudREIvzt8gfxizos57xYgRP0HM+C4RlsUmdOF8pwfZ6?=
 =?us-ascii?Q?wDXBl9lJfMPYsjwHgkNsTydTicfjOO9yY4MAFZvMcD9W4sR3+rz3z63+Qjn8?=
 =?us-ascii?Q?bI979pCHtmd9AjtOk2YequRVjEXIWMZy79QyNCaY2vO06mpJR7Z+aHYSuWQQ?=
 =?us-ascii?Q?i7cwC7I1MsqJW5AZ24iXTEXzfCGm++V2b33AkgMV52dzhB9mhitzuxuoxOKO?=
 =?us-ascii?Q?lQNVFld9AdwAEDm81YcDVyk+9jITOArYFSrftg90WpEcymulT3uBO2V/90YZ?=
 =?us-ascii?Q?bd+t5pjOQ0aHyvuKjOZ6WJvHntusKu4+nTs7UG5rsievBUKFy/Jk1hKLFiFZ?=
 =?us-ascii?Q?BckqDc8snmq87ldIF1X/CziVI2VMuXaH15rNnRJoENVNsZT73ps0M4cPt4vu?=
 =?us-ascii?Q?77aoCav9+xcVg+DKqe+/h5C8c9YKz6uG551MJ6bHbzbglNbgArKhiFjNufEP?=
 =?us-ascii?Q?OZoPphRpmKyzcIw4NZrok04MmO4CB61m9QngqOwEG9XKYZg1EtKPTC7NYw6+?=
 =?us-ascii?Q?a2qDtbai3O0sb13Fj5uGcS4wWT421s13xOYZYVExxDODiwzCXjTEpBYKI6WV?=
 =?us-ascii?Q?DOqr7zlrRqnZwpWeDVR774iz6iEuXXPc8+KwzBXF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db614fbc-9548-4540-b6a5-08dd4445f7b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 11:29:05.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnslPjLGsBTV4PnmflD0CxMFkDRBN3Tq7RLYP/7yGjW6JToT5tbD9TMwihJqjzJvaNiZUsHfre4oA/45ehZx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

On Mon, Jan 13, 2025 at 10:12:41PM -0800, Dan Williams wrote:
> Alistair Popple wrote:
> > Device DAX pages are currently not reference counted when mapped,
> > instead relying on the devmap PTE bit to ensure mapping code will not
> > get/put references. This requires special handling in various page
> > table walkers, particularly GUP, to manage references on the
> > underlying pgmap to ensure the pages remain valid.
> > 
> > However there is no reason these pages can't be refcounted properly at
> > map time. Doning so eliminates the need for the devmap PTE bit,
> > freeing up a precious PTE bit. It also simplifies GUP as it no longer
> > needs to manage the special pgmap references and can instead just
> > treat the pages normally as defined by vm_normal_page().
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >  drivers/dax/device.c | 15 +++++++++------
> >  mm/memremap.c        | 13 ++++++-------
> >  2 files changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > index 6d74e62..fd22dbf 100644
> > --- a/drivers/dax/device.c
> > +++ b/drivers/dax/device.c
> > @@ -126,11 +126,12 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
> >  		return VM_FAULT_SIGBUS;
> >  	}
> >  
> > -	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
> > +	pfn = phys_to_pfn_t(phys, 0);
> >  
> >  	dax_set_mapping(vmf, pfn, fault_size);
> >  
> > -	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> > +	return vmf_insert_page_mkwrite(vmf, pfn_t_to_page(pfn),
> > +					vmf->flags & FAULT_FLAG_WRITE);
> >  }
> >  
> >  static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
> > @@ -169,11 +170,12 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
> >  		return VM_FAULT_SIGBUS;
> >  	}
> >  
> > -	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
> > +	pfn = phys_to_pfn_t(phys, 0);
> >  
> >  	dax_set_mapping(vmf, pfn, fault_size);
> >  
> > -	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
> > +	return vmf_insert_folio_pmd(vmf, page_folio(pfn_t_to_page(pfn)),
> > +				vmf->flags & FAULT_FLAG_WRITE);
> 
> This looks suspect without initializing the compound page metadata.

I initially wondered about this too, however I think the compound page metadata
should be initialised by memmap_init_zone_device(). That said I kind of get lost
in all the namespace/CXL/PMEM/DAX drivers in the stack so maybe I've overlooked
something.
 
> This might be getting compound pages by default with
> CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP. The device-dax unit tests are ok
> so far, but that is not super comforting until I can think about this a
> bit more... but not tonight.

From my reading of the code I don't _think_
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP would change whether or not we got
compound pages by default, just that if we did some of the (tail?) pages may
refer to the same physical struct page.

> Might as well fix up device-dax refcounts in this series too, but I
> won't ask you to do that, will send you something to include.

Eh. That should be relatively straight forward. But then I thought that about FS
DAX too :-)


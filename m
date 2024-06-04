Return-Path: <linux-fsdevel+bounces-20882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3E8FA8A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 05:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C7CB24ACA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 03:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03013D50F;
	Tue,  4 Jun 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="T5Abfcul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70C12DD91
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717470523; cv=fail; b=CuA4T41LYq2oT3XAC20cxKym9g7nKLJDaQ70DFeUcq6gaU5q28RsU6ehGhE0Fjlb9ZPoRM8mB6K+3mTrLTAEIT4tDdjrUGHsNkWxXYa6SugJj+yT7bf3c+zfvZJxbVPgpFBcnqcNXI4FrxPmTXemft9DhrfkgXt7mcc3/RRnoEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717470523; c=relaxed/simple;
	bh=l9Cbc/eQWmMOpNnuM32o2MUNS0SIXWfqcYwIq8V7YhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I7vE//PbaT12mxAkrHMcVLidV3ey7VPYvKMK4BXbqxarYkkxcpohy7YkKZymS/4zgYqAWYJODDqzaS0Ct8K100C8mtf1a4a1LX2SBPZQ51cRAghZRy1swNTCEh0Y9Tlg7KWnJee0OojoeUFWKU8EQlM9ygwbFGzyUDt0mKI8eNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=T5Abfcul; arc=fail smtp.client-ip=40.107.117.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qoq9sJe5mb5l+6kYXGVTj/U8peW+0x5iqPtz31GIDPmWOC4zi2Z32IHJ9J9a3ZlT6p8NKhC3PEbc5xfdyXiy3UQNjtZl8I7iliT1yf4F0iVEUKQ5Wa1ceFgdZQicjXfIpVJHJn0ypZlOhdo27zPdEWKm0nOEW2Oh8kHq3VRGvslxOaw3DoZhNDIGkTnErqKs8h3+KF2NmSlKEmqc9ZllcQvY0+Fykdjte1hRJO7+YK3ndVHvb1qjihPDEPKvPFbOTRQ14Cgf3dk0ySckMZXlqRjJ/Md3t2GR0mJo2KoaaeZZjWC9PfQ0aB4hARRM7t60/DHEuQY63YhA+UTbic86lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEhl6DD0HwbsZTBYRU/QV/wAQi5/Fjb4qPPxf16ZsDc=;
 b=ar3LaPWncvjIMnPWyxphAi/BHUTEc2rfckylfF0UQzZ2S5+/9BEwD6s/ztq+6kW97FsgRDiV9k7gPoj71Pm7+DOlR2VyaoDAPOGCY5vx8AJkhVv0Y09tyy93ghruGiqvxKS9fE+XNKIFu6fILYxwztxdchMIoW/NPiyZsCKkEJ1rirlcZkF6Mjg8ROZqefxs9gXnLC0M0YOabEOdxN96VRAvcUuOOT/4mYQrqHQsB6sIxSAV9olZdpKncOotwxGkh0Gx5kLHbeVij2hYXPto56wayDnd00+CzJo05ncKByHLNui4JOdg5F8rk+bGocjzq89HzZlea9c+vMIuLjeo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEhl6DD0HwbsZTBYRU/QV/wAQi5/Fjb4qPPxf16ZsDc=;
 b=T5Abfculx4Ip44M4J2cNxWPmW2Q8m/u8gz9SXwa+v0yXtj3j5avwIpAdHeLTh2nXv90SMN1oWD/NHAi6pGoxvaowP6zSlf2eN+mldsYp5GXn779zpwgvbS4m0B3145Iv6wtoFZvPgo4dDJUsJwqES1vMunyhrXepwwP3rHlIvQR6tVOM+hoL+eISQ3lywJWLvqyVff2wJq6BcADQ7lSwq2hWm2Jgovxq04eDvknBZIfZCnFXaLxeMjADjDVZXdyeE+rjY9jlt+/cbKaL3je8/0C8wLC6bj+Av/9Mf1f4B51iSKJ+Z8YKB7/F3dLRMwD+274y+GCQiHSLeKMCyXWI6A==
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by SEZPR06MB6912.apcprd06.prod.outlook.com (2603:1096:101:1ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 03:08:36 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:08:36 +0000
From: Lege Wang <lege.wang@jaguarmicro.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
CC: Peter-Jan Gootzen <pgootzen@nvidia.com>, Idan Zach <izach@nvidia.com>,
	Yoray Zack <yorayz@nvidia.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, Parav Pandit <parav@nvidia.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Bin Yang
	<bin.yang@jaguarmicro.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	"mszeredi@redhat.com" <mszeredi@redhat.com>, Eliav Bar-Ilan
	<eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, Oren Duer
	<oren@nvidia.com>, Angus Chen <angus.chen@jaguarmicro.com>
Subject: RE: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index:
 AdqybnzAiozTvtlkQFaloMBVG2WGpwDHcmEAAADKEAAAAQAmgAAAdzaAAAm2tYAAHBcsAA==
Date: Tue, 4 Jun 2024 03:08:35 +0000
Message-ID:
 <SI2PR06MB538586B4F0AEFFB20F553240FFF82@SI2PR06MB5385.apcprd06.prod.outlook.com>
References:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
 <20240603134427.GA1680150@fedora.redhat.com>
In-Reply-To: <20240603134427.GA1680150@fedora.redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5385:EE_|SEZPR06MB6912:EE_
x-ms-office365-filtering-correlation-id: 041e88fc-a852-405f-f62b-08dc84439fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?i7jvJJzyqKXrason4pX9CQLTtkXhAMeXoAlQ77kn62jyqpQX9onFZ6Ze?=
 =?Windows-1252?Q?ho2CF+XqI76C+nb1QVx2rtt0UM+Ksq3rj3XyCkKJf9ETOvwF6hsYGhuC?=
 =?Windows-1252?Q?Ejm4ewiAAEEjzU34yPckhiCBrR5ywqIWpMgV+nkNCgAYGgP/CSFdQM3Z?=
 =?Windows-1252?Q?Slm8BGFHonDiBj8PFyb6SGD1fMCuoBhQzSRO2kMJLebiYIORyQyS/P4J?=
 =?Windows-1252?Q?xRgSvP6COGh9lbjhYEBEoO5hEw1BF+epY7eN0RQnXyU4Ny7VLgF/K3pI?=
 =?Windows-1252?Q?WfWSKhtGuvrA1ZDRr6WDqfsmHQBrtPIn6J6f+q+Bph/x14dt/MFoJeqQ?=
 =?Windows-1252?Q?Av+nZqZGdtueTlZl+tko82NJoNBvhryn0ZizMF2chYX89ZDo54h4vlod?=
 =?Windows-1252?Q?aQycCZgQlsEVjStK/iY6MPrR3LgzRDYSoplZr5zfwAsCT1RaoXVPD86c?=
 =?Windows-1252?Q?3FJapFL6IH0GjCncWpU21v0ExXjzoCHKJK/8GFT7XrdWUwIuUJBOGh8R?=
 =?Windows-1252?Q?3vH3bfOP9RmDTy4EfUB136+NRu3Q6aCMR8jDWKy14w+bQ2k8ap2YZm6k?=
 =?Windows-1252?Q?kiwquK/znYEVmkFYyqDjQyP43gnyTnSAYv5xOiZcy3+DHvUlXEQS5U0E?=
 =?Windows-1252?Q?LOBOKsdZQui25j0qw5+jm/ylEtnnAtmbh93BHG37+YsZqPjoemmteUVP?=
 =?Windows-1252?Q?i5vhlxamnJR9yL3Yz6mQOk7Re4eqTsedueQ7gVEklT6BBaZ02WSsaJiU?=
 =?Windows-1252?Q?yehGMl+NKhlkoBrLbRaXMi03rnh6u6vkE5mTCf2CTJD+NRoK1VZHh6lE?=
 =?Windows-1252?Q?ZGKD4I/yS7BvdNwN3RaUOblUyFphdxRjiF6zo9Uh+FTrZHeLIbtZefW6?=
 =?Windows-1252?Q?ssrk/kD2j4u50+lmb6owVAg51htY80GtCXiukARarWPDoIt18LXDceVC?=
 =?Windows-1252?Q?tsPkea5zrI548CLqwHfNJvw2SmXqqzrGU8yFIH3LL0pcDVe9mCFmCLWH?=
 =?Windows-1252?Q?WFUv8UVQCysBusDpQEUhhXuz3FHfIS2+oBhmn3ZaqHBGkUt+vrPAD6/i?=
 =?Windows-1252?Q?9WX1o4NS2XVwmCTmSNPRuOurhPbXeBaxoue8S840IxgxktQqqmQo36RG?=
 =?Windows-1252?Q?UfIOdIoDnoCIU5n+5pdEJs3VQ2HMbSHfSeq2ovtAHOT3LxBx+L+sXWJE?=
 =?Windows-1252?Q?IIwvBDGQGi77QjvN5Uag7jRAmAwGf5w8kPnDMtfz2VAV9MOFB/LjmTUW?=
 =?Windows-1252?Q?RbLuenLAN/e6AIXVYFWhUE8E0zCT5YNr7F0rSjQVtPNPK/kc8vAFOnYV?=
 =?Windows-1252?Q?Xn1toZjpH0H2pCLTx7PQvuoH+nazSGF75dBNvXufhgidD2hPYbooFAqT?=
 =?Windows-1252?Q?avYSxR8MUE7T/VHYFCM/r+jn8KPPsOwM1YAXXLOsxB6O5ScndvkbZ6yw?=
 =?Windows-1252?Q?h0isPBGCc6adO4mlz34oGg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?/meV5fXp15JsCKOfE3Xl+319r0NIqyhAV91SZ7YX+zaPXrFrYPRfn/gW?=
 =?Windows-1252?Q?cTg1tQd0X/yp17p5N4soIeXHOYLFgJb4X635M2gjVeIekeRV6xWEpyYG?=
 =?Windows-1252?Q?PoIBmESpuwF7Fr832AggeJKednPgusA9St300UiVG4L2eUu1L0fnmONc?=
 =?Windows-1252?Q?GGe87rOrxTcGBYpg+42qLrZt2Y4NvRAo+8BqQoFvBatHbj7l97Wv67dj?=
 =?Windows-1252?Q?xLm6gToDP/Hw2QUl5UjKGUvmUV9jX9vTsqHM6EWiMcPq2eZQrt+H2tYT?=
 =?Windows-1252?Q?tcKTk93OPAjrVIsbWeXokgneu7Np6Y0F8qJvHSe4JJwXDlijrpxVIwNK?=
 =?Windows-1252?Q?HRu1aYXRACfb/7Bo64+qo4egkcP0x0F7qIgguyE4y9oF0OTddIE3QMzP?=
 =?Windows-1252?Q?4xh90aYrJowop3O1VFOEldmN09KhNHFGUL1TvaLuO131f4d5M+vxnpRJ?=
 =?Windows-1252?Q?6h8P0Yvc2O8K7g95fPgM5ng+hqHfTRQ3wGA+x4kV/Z/J2rXop/4PidHp?=
 =?Windows-1252?Q?o21mND3+qnfnRaH++JiBaNWmqk+wZ1egdFXc9gjKedllubriNyaZaZGs?=
 =?Windows-1252?Q?eUZ7gq3tFKIC+wkR6aJYQpdjcWYgvEXEAH6H8OUWJupNcE0i1FMohXZJ?=
 =?Windows-1252?Q?7CPBVJ+L1K/Y4Po41aEdjI0sLM51P7reERnWdXsxfr9gbd0sWC3NbPi1?=
 =?Windows-1252?Q?9L3s4xMV1fpuAhZknV0iODPsE+DCiIAA450ATHqMIakaKtbYhy8U1jRH?=
 =?Windows-1252?Q?azkAP2d1ZD0Rk3e9/CiDo2VPUo0G1xu3xc4qeOBR0MlOcVE19rgPNiPl?=
 =?Windows-1252?Q?EBnDjh/fGhEXUjRUNHuub90uZeOiKLDSXKEwyV5DsT2HK29Jx+ZXpnPB?=
 =?Windows-1252?Q?G26MRyGI7yGjlCRlyhZW40318mxBH9JIKEpglhDwKWYfxosTxOkrpEVt?=
 =?Windows-1252?Q?SVlLemOHNIdh6eRj6ERgpBglqFtfHErGtEGwDIx9fAQ1hbcH9EwWBN20?=
 =?Windows-1252?Q?d5OYkN+nm/btflYnVnbCdj34UCM88uFz9RezD7LLR4qt8MII4TNBa4ZH?=
 =?Windows-1252?Q?iDZsMZ1ipVhLoUhPQRyr1X1xqYU58Bujruchs89pT1NMy2RK4V3rq+wY?=
 =?Windows-1252?Q?qO/mw+rcye63IsXGD0a36i1nFc/SEHGTjJbGhac6RlDTxNLRM/wzGLeP?=
 =?Windows-1252?Q?FKe7+f+Inzywe/reKaebXrBP97P/Ypp7NM708alnjAE+yx8tdzYWmOtM?=
 =?Windows-1252?Q?ZcRxeHxoZt1DcMpMHPk6onuw1m9U/RhXSFV6ZvR/Pl+nAnNkdYGXR65k?=
 =?Windows-1252?Q?sArPAxSvOzO2lItk6PrLkzOHrGIfzRAiuVDGcVZfayNZIAWdPwMzO/Tl?=
 =?Windows-1252?Q?PNBbGM7h3ikJ6D59XqeqrZA+f1pb9eS9m+HhUddDZi6Abu9ZjUFEg1k+?=
 =?Windows-1252?Q?EFq6w3WEgsEFW8TuUopN86NN/U/O0Z7VMrHFIzarJNZi4NSsRQUmyLli?=
 =?Windows-1252?Q?VZjjCxJNyoZWyH4sJen9VhB7u1uLbbXdOY+4XF8kX2kr/dUDCUSlNZoL?=
 =?Windows-1252?Q?t+4gEh/x6d5gNbEo9DuT+o29g58rtysDBJapnr4QnobeUoTRXSOtsg/6?=
 =?Windows-1252?Q?u0F06IKdTeUiF0qCuk71JRAKFp1FXgXjbGNZgLXxzVHjW+8rjV8pRxOZ?=
 =?Windows-1252?Q?ntHzGmQfYTfidJ7psQ7Q1eYdCxL2JGvS?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041e88fc-a852-405f-f62b-08dc84439fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:08:35.9309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WB77czyNnoBzbLCQeJgRT1rKcl9FWyFZnleLHQL0+tZBxj1Z7bIJZgU5+mG1pcp8FAbXwLCrA1TA3bPsJf7bmd/wGMTqkpYPgG5b4KM5OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6912

Hello,

>=20
> On Mon, Jun 03, 2024 at 11:06:19AM +0200, Miklos Szeredi wrote:
> > On Mon, 3 Jun 2024 at 10:53, Peter-Jan Gootzen <pgootzen@nvidia.com>
> wrote:
> >
> > > We also considered this idea, it would kind of be like locking FUSE i=
nto
> > > being x86. However I think this is not backwards compatible. Currentl=
y
> > > an ARM64 client and ARM64 server work just fine. But making such a
> > > change would break if the client has the new driver version and the
> > > server is not updated to know that it should interpret x86 specifical=
ly.
> >
> > This would need to be negotiated, of course.
> >
> > But it's certainly simpler to just indicate the client arch in the
> > INIT request.   Let's go with that for now.
>=20
> In the long term it would be cleanest to choose a single canonical
> format instead of requiring drivers and devices to implement many
> arch-specific formats. I liked the single canonical format idea you
> suggested.
Agree, I also think we should use canonical format for cases that client an=
d
server have different arches.

Regards,
Xiaoguang Wang
>=20
> My only concern is whether there are more commands/fields in FUSE that
> operate in an arch-specific way (e.g. ioctl)? If there really are parts
> that need to be arch-specific, then it might be necessary to negotiate
> an architecture after all.
>=20
> Stefan
>=20
> >
> > Thanks,
> > Miklos
> >


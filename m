Return-Path: <linux-fsdevel+bounces-52026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D871BADE6EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE8D7A6F74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752B285CA4;
	Wed, 18 Jun 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W8mdruqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17A28468D;
	Wed, 18 Jun 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238873; cv=fail; b=ubhUcR/RFS06fJdPSdE/ggeE7sOB+ox/GfRqQjn2vh2gCswkRB/Q7Pj+1Y47E8znqLNuf1+hTeOJ93mumA5hsLMU7a9H2zCaS5PUkCLKnSQnO4EVi+LsTMbxoKer/YLQLm4AiHI34SntMbwgf6eRFDalhllYmAY3vLaO6S4Ij/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238873; c=relaxed/simple;
	bh=/adNQdBnExvu2hARO/wjmjMzXVm6bDqL4bH7epVXkZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j1VqDUObCLhTeKo/AdqXMyth2BvK8ocRnBXENEPscFx0MYJ16oa1fULnQQRq8VRh5+AW5kavxZNf3K3/l4U4tu13m04YlxcRSsFvctD1u5+o4ndvBCnAatULc9xTy/KJaz7g4Mla7jFlqdt6+4UXb7AxMQMJe8pMBIDs1gw/LmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W8mdruqZ; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGEABTUc6Koe+G0y7yKrFHcl9zTU32EP1kMS967yCB7EYscCnxFayfoDwvhoQo0LIP0WFTL/xEEDgd3qyEiwug5H4ZruPt87e9iufdvgAqmvqvkLTIQAqKpdvUhuSasaeu+NoHh13BmuiFIhS3xtRoq9c0NHW+/5rJPs8X0z+M9RIVYlMskLLfpq7mk62e9lXmNG5HnJiSqe0W/k6ysffJCiUgerPHwCMoPYAgiM23Pn9Fu6AQm72wX/KeK2MjIC8BgRzmwPTCaTu82YlBBWTFISg1jRLgAneUCRXU9UVi0e+3R3H97NM3Zdw5IwwsT5jYf9B5M1chyqcwW1LovGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAcbXOQ7GidEIwb6g0mYqsPLn3sqQP0jr7rGkBXQDOo=;
 b=klulHncgS1vaZpY+YqHtVaTS8m9nb0TNctTCAR4NFjc+Dghy7p56qsgTfV3jU8J3xYy5HSvNA86rh+f+yMUAmfHmaHULAvqSJCHKDYvrDOKHfBRyvbWA86TgbvaUmdf2So8Qe8AXy2uyv4weYGLU70jTuNCuMz/qKXNfj5nvt3eIo7Z9+aKIcIcxFRJdm4g9PbIUiwkiHKFeguPVDlnnj3C03vTBlgnmOjC/24Zc8AAV9DrnjDDodSg6ccG8Iytm6he25r8Q9A1+XSSUALThIH/UcyYMgD9Izn8eY1zLCio/sodaIcAIK64yI7b+kQiyHpjQPyRRcsOtk49PatUubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAcbXOQ7GidEIwb6g0mYqsPLn3sqQP0jr7rGkBXQDOo=;
 b=W8mdruqZCksY74lTeO+dxyJWhIWn75mRMVXoubraEh4mHWrwV65dCdwSLrezNkvTesCHBWgKPRJNLgL4di0BxyBqmdBUkUcLal93ftydvDrnxZz6PDVKuQ0zBiVMg7tRLjnokaPchHIwHKn2VfAPnPEi4H2so4i44pDTmSelmtwbcef2RRrMSSWY87bMIHNRf1HxAhhzXN3Qyhyjzz5kmz1ksOIvSWtpEB2/bfJV25Rx89p4gARC/dzW5XmCdg1DGlC+Tl9OHGEue3u8OgC01MEahTb+dF8AucUFYbD9N/4Q2b34QqzMBewRItwXRgK00686wjMBNhX/IpXXF9Rz5g==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 09:27:48 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8792.033; Wed, 18 Jun 2025
 09:27:48 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jan Kara <jack@suse.cz>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: warning on flushing page cache on block device removal
Thread-Topic: warning on flushing page cache on block device removal
Thread-Index:
 AdvMbvrhAHapLL5SQLSXHQ+FhiQIJwB7b58AACZikZAAAg9cAAAAQBBwAATDYIAAAA6IoAFeHfSQAunx63A=
Date: Wed, 18 Jun 2025 09:27:47 +0000
Message-ID:
 <CY8PR12MB71955E93B47608497B4504FEDC72A@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195CF4EB5642AC32A870A08DC9BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <2r4izyzcjxq4ors3u2b6tt4dv4rst4c4exfzhaejrda3jq4nrv@dffea3h4gyaq>
 <CY8PR12MB7195BB3A19DAB9584DD2BC84DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <nj4euycpechbg5lz4wo6s36di4u45anbdik4fec2ofolopknzs@imgrmwi2ofeh>
 <CY8PR12MB7195241146E429EE867BFAF5DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <pkstcm5x54ie466gce7ryaqd6lf767p6r4iin2ufby3swe46sg@3usmpixyeniq>
 <CY8PR12MB7195BADB223A5660E2D029C4DC64A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CY8PR12MB719567D0A9EAE47A41EE3AC4DC6DA@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To:
 <CY8PR12MB719567D0A9EAE47A41EE3AC4DC6DA@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM6PR12MB4172:EE_
x-ms-office365-filtering-correlation-id: 33fc8778-d857-4f40-cc32-08ddae4a63ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tKPtf1JgzO4tcE4yCRE4j6ridbnHnqxkXkpCMRHk/YL6/X50eMRRv9lPzqmY?=
 =?us-ascii?Q?hkiv2YhlNbIxlqicVkN1jrIu4MIRKTKf4nWFjCAB48DILD3ibkgc0Q5OngzC?=
 =?us-ascii?Q?iuYFO8O2YKMHaMw9PFAS9B1+lbhDrKTF51p7f6vuKIxuSSLTm/yH1nsgOaxu?=
 =?us-ascii?Q?5QMYT4JsEFx5gXn0Y5+52cO8ARlKeKSS7QwKSkDOMp4pbD7UibKofACe2VtM?=
 =?us-ascii?Q?ewLD6TrdJYPQX6NrF6QNZatWUkI5dAkKuu1bQg5bMes6m5b1HSL97Fvx3G7C?=
 =?us-ascii?Q?03Ni2Eq8madSpIXlncnDbtJVQK7Af2Efnm5HtB6ik/YCTxGqGdfHFTsfHX/M?=
 =?us-ascii?Q?FwAGMkIWXQqXXyDlk8FO0GnNT3CzbCFuAhankEKHa/y8imxyT13aFMg6POzt?=
 =?us-ascii?Q?qK+XreqXZS35unrlA8DIwQBHk+vQtW7igEW1GJjjnUsqTnU5i7CdzKkBCG09?=
 =?us-ascii?Q?CMD6DgaeNtk3yW2wxFemsupJOybJsf4W+fHHV9h1TeLcFM8ziv6Y+QL4oAVt?=
 =?us-ascii?Q?rCWqUtEg6uAYNVHhQQUXKSjH6Nl/haq9/DKwLio54b2oInWYfuAK0Mp51g/m?=
 =?us-ascii?Q?rK6Y2X/XpzfoYPII6SOAdktFvLS7PF0eVFaU5VfUzYH5jxFN4jX5ZK27Y9CT?=
 =?us-ascii?Q?bYwKEl0wkd+6f2yS1i8npMat6VMiINLGdV6ZqStMGJ54Xdv0RLHe7fnw9Oax?=
 =?us-ascii?Q?IAiJCH+YYeMrNpNcr4gmGqJjU2JSCuxdDhS8EU2yczQb767WM9E9GetNzlbL?=
 =?us-ascii?Q?6joYxjV0YmFieMwd0i3Xq738065FDDascxze0gaqAA6sjBttc3EO7gCui/QR?=
 =?us-ascii?Q?M4UXqNz30quhR8eV534hRcJ0wkqnDOyR1L51u9GceeMiIjYUjSk47utjospM?=
 =?us-ascii?Q?ZTojUJSkrxTZ+T3y//SysZrjhIlJ7+2PIeF2cNGWlhlV6EP2+EL7U9Omn3PR?=
 =?us-ascii?Q?GNzXKImbZRLbk3D6vhqDsbWTQquS2tF6j2rYHFIl1eQxqnWgzs48OP0qaOQP?=
 =?us-ascii?Q?RaPPbEsrS9Lbo6Yt3EnyBdEzMqmp4ZAZw9ngZVULllMLJ2VRSdpk9Gpx7dAS?=
 =?us-ascii?Q?sMf1o5TWNGb/PxgpUD1X11OVHps52Kk+5oXRoh2DZKOiVbsDcOm3oY8/bZ2B?=
 =?us-ascii?Q?0tE4IulgnjTd5ApBmqNXDjbgiSq+94GDnZobQM5HINADPR11iqtLJu3n2mkc?=
 =?us-ascii?Q?RXL+xfAX8bYA2pqEdUOttagusfjkohQmWrQXMqyjYpQ4sdI9Nw9VJdkWNKz1?=
 =?us-ascii?Q?xdLD1fWRkTImryipY0dz6I45QUMQjaAgW5IPeLtW8zWp3P1DEPvInccup5Bp?=
 =?us-ascii?Q?TsVnJOBxAfajS1EMSI/tWhWXFhcMoPpBnrVS2Y6LFlRHpR2IP3Q+Ddi8+Zkz?=
 =?us-ascii?Q?MPPyrOOPsL8/0PVW3xvqpBXrXCYlP+2tG7hhkRZtgZi5cT0yhrjcCA2GUnhh?=
 =?us-ascii?Q?SYWqDa9Ijt7Jk7DMrP7Zps+FciR4SrIwz6YY2Gd/Vq77h7Y3P+l+lzSkAOYE?=
 =?us-ascii?Q?dwQTD8QZYDi4gTA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DyoetNGtlwwc274mvH87SM5m8CEskhG8ZtID4YcfkXad8yB9o2b0gX4rDnuj?=
 =?us-ascii?Q?w2pF2wA1O52M/hUItpKNWMlIgj2S5DC04KyeukhueS2PAgw8coUiwvLL+8eq?=
 =?us-ascii?Q?sCkRWw2oBBRBqBI8TVpz3adamQ3BkjDMe6vcLI/RX+baOvq6VrG6eXVmEbgh?=
 =?us-ascii?Q?JihkQ6LhkmejnN9Lu1Crjpz3v78M4aBfFVUyAfAScc7zZ/YoKDC/y/V5meEZ?=
 =?us-ascii?Q?XsC5eWRLiBXUzfb6mflbvOK1/NLASZclcpEDiUP6ugn5mi9S/CoPAcehclDd?=
 =?us-ascii?Q?U0KgD1guqZyA3GpD71p8k1D5M4w9fkur3gV82gF1Ep0noIAXL44SiWSckh58?=
 =?us-ascii?Q?fLTNW3c6uktRxmgoEBXoQf/0qfvkr1dyVOL4kNQrr3DP8+EXJEODws2SXKyl?=
 =?us-ascii?Q?XHfnjYAsgJBHWFxCfiHjoFPPZEfbNKikBZsbETCi9UPr7Wq4t70nTTjMJlqy?=
 =?us-ascii?Q?C27NQil1Gg0hIoaVd4k8CvpDB+zRKoXGiWBRqkh6EaQmZlyQTtip5EUfcUxX?=
 =?us-ascii?Q?xfiLFxMyWOtktLkKNkj+Cr9hO1SA17UUYUTfqqV2YSZKtXu8xhkHxd/yE2Yw?=
 =?us-ascii?Q?AzGkJtBLpgAArLUONfkpgHF3a3lxm2JSogAvYPBOM1lncY2bZX2d/WqRgRZb?=
 =?us-ascii?Q?KqdmbXRSD7xleGKgaKgCPn/Geew6por+ZRjg7FbXyyNHYx7LUtXFqML18tWp?=
 =?us-ascii?Q?9SFKIapR+K1vTEcEsyUkajBX15G1/b0sXYMIlWLG/V61dNYklPLT3Wcevwa9?=
 =?us-ascii?Q?v2vT8Tr8hEJmeV2Xb3pPUrk1L5YUxTUN13TSbNW5eMmd40Nk/AIW3/xOLklm?=
 =?us-ascii?Q?CCsHa7CJh541rh9HQKQCzVJ/OxB/LZIkJ+3rrFgYLv8hdaYk4iye0eBLj32C?=
 =?us-ascii?Q?UEFXH7NnSZH+Asxs4IEq85B9vCES4ehu0aZuKgW6/3ZB7HkVcE11J802E5G4?=
 =?us-ascii?Q?nZJEgyPeKaCWMw8cFKKncG7ii1HF6EGUV41u/lqdqOoF+SE3uc49/+Mij5k/?=
 =?us-ascii?Q?OqgOCBRO6CEL7PEpb9Kwhmk6EidYzJfYe3u8dQmvFYiQOB4aFx4EqCdKl8mw?=
 =?us-ascii?Q?t3qr6x1gWO2FIi4u05MIA9P8OCrtBWXCH1l+r/bmsvFxvhhRU6SBEmByc3RH?=
 =?us-ascii?Q?yVvjajwMvf7wt1SoUichpatFHj/KjUz3DTllMCMp5ZoGtNWWP+UremP4IdWp?=
 =?us-ascii?Q?UQpKfz9W+9ScdRNRH/zZmJz/ZUs2MDFw4VjMxobAeTZYdrZutk3pA9rHsZIV?=
 =?us-ascii?Q?QvqF7y59v/kTJk2RroyHDXgplEzzb054ki87/NOalU0Oa8fP+ys4j/ypVSK5?=
 =?us-ascii?Q?saHjb1x2PC5cLPKO2o2liYTb8vYwjPdNqk9UyPdO2/1aR1Fhe+p/vMrkHdWd?=
 =?us-ascii?Q?E5UwbKrtcyXGz/V77eq94Mo3LauEv/voY6880R4JPhYD7/q6Xc6OSJFlBJgZ?=
 =?us-ascii?Q?bwM8Pco8ZtjSlVLH0LxohaULBm0ETNrS6i5Xzl1LadGyjbeQg5mO/ANB4Pu9?=
 =?us-ascii?Q?uPx+AMy9aqsyZVfHXNaDqsvx5Ml0wWBFIdd/Ve1U+JjW48EI9T1vbubWPx7d?=
 =?us-ascii?Q?Luoy3YVbEOGi7env5RQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fc8778-d857-4f40-cc32-08ddae4a63ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 09:27:47.9306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFwfBM5WTXeQziDG4crVfvlHvgwbuPgA2Wp7LEGPNLzDnKWKiEwZU22BKbuHCntQcdlp2L4NYj0+2DyEhJRhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

Hi Jan and others,

> From: Parav Pandit
> Sent: 03 June 2025 07:03 PM
> To: Jan Kara <jack@suse.cz>
> Cc: linux-block@vger.kernel.org; linux-fsdevel@vger.kernel.org
> Subject: RE: warning on flushing page cache on block device removal
>=20
> Hi Jan,
>=20
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Tuesday, May 27, 2025 7:55 PM
> >
> >
> > > From: Jan Kara <jack@suse.cz>
> > > Sent: Tuesday, May 27, 2025 7:51 PM
> > >
> > > On Tue 27-05-25 12:07:20, Parav Pandit wrote:
> > > > > From: Jan Kara <jack@suse.cz>
> > > > > Sent: Tuesday, May 27, 2025 5:27 PM
> > > > >
> > > > > On Tue 27-05-25 11:00:56, Parav Pandit wrote:
> > > > > > > From: Jan Kara <jack@suse.cz>
> > > > > > > Sent: Monday, May 26, 2025 10:09 PM
> > > > > > >
> > > > > > > Hello!
> > > > > > >
> > > > > > > On Sat 24-05-25 05:56:55, Parav Pandit wrote:
> > > > > > > > I am running a basic test of block device driver unbind,
> > > > > > > > bind while the fio is running random write IOs with
> > > > > > > > direct=3D0.  The test hits the WARN_ON assert on:
> > > > > > > >
> > > > > > > > void pagecache_isize_extended(struct inode *inode, loff_t
> > > > > > > > from, loff_t
> > > > > > > > to) {
> > > > > > > >         int bsize =3D i_blocksize(inode);
> > > > > > > >         loff_t rounded_from;
> > > > > > > >         struct folio *folio;
> > > > > > > >
> > > > > > > >         WARN_ON(to > inode->i_size);
> > > > > > > >
> > > > > > > > This is because when the block device is removed during
> > > > > > > > driver unbind, the driver flow is,
> > > > > > > >
> > > > > > > > del_gendisk()
> > > > > > > >     __blk_mark_disk_dead()
> > > > > > > >             set_capacity((disk, 0);
> > > > > > > >                 bdev_set_nr_sectors()
> > > > > > > >                     i_size_write() -> This will set the
> > > > > > > > inode's isize to 0, while the
> > > > > > > page cache is yet to be flushed.
> > > > > > > >
> > > > > > > > Below is the kernel call trace.
> > > > > > > >
> > > > > > > > Can someone help to identify, where should be the fix?
> > > > > > > > Should block layer to not set the capacity to 0?
> > > > > > > > Or page catch to overcome this dynamic changing of the size=
?
> > > > > > > > Or?
> > > > > > >
> > > > > > > After thinking about this the proper fix would be for
> > > > > > > i_size_write() to happen under i_rwsem because the change in
> > > > > > > the middle of the write is what's confusing the iomap code.
> > > > > > > I smell some deadlock potential here but it's perhaps worth
> > > > > > > trying :)
> > > > > > >
> > > > > > Without it, I gave a quick try with inode_lock() unlock() in
> > > > > > i_size_write() and initramfs level it was stuck.  I am yet to
> > > > > > try with LOCKDEP.
> > > > >
> > > > > You definitely cannot put inode_lock() into i_size_write().
> > > > > i_size_write() is expected to be called under inode_lock. And
> > > > > bdev_set_nr_sectors() is breaking this rule by not holding it.
> > > > > So what you can try is to do
> > > > > inode_lock() in bdev_set_nr_sectors() instead of grabbing bd_size=
_lock.
> > > > >
>=20
> I replaced the bd_size_lock with inode_lock().
> Was unable to reproduce the issue yet with the fix.
>=20
> However, it right away breaks the Atari floppy driver who invokes
> set_capacity() in queue_rq() at [1]. !!
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.15/source/drivers/block/ataflop.c#L15=
44
>=20
> With my limited knowledge I find the fix risky as bottom block layer is i=
nvoking
> upper FS layer inode lock.
> I suspect it may lead to A->B, B->A locking in some path.
>=20
> Other than Atari floppy driver, I didn't find any other offending driver,=
 but its
> hard to say, its safe from A->B, B->A deadlock.
> A =3D inode lock
> B =3D block driver level lock
>=20
> > > > Ok. will try this.
> > > > I am off for few days on travel, so earliest I can do is on Sunday.
> > > >
> > > > > > I was thinking, can the existing sequence lock be used for
> > > > > > 64-bit case as well?
> > > > >
> > > > > The sequence lock is about updating inode->i_size value itself.
> > > > > But we need much larger scale protection here - we need to make
> > > > > sure write to the block device is not happening while the device
> > > > > size changes. And that's what inode_lock is usually used for.
> > > > >
> > > > Other option to explore (with my limited knowledge) is, When the
> > > > block device is removed, not to update the size,
> > > >
> > > > Because queue dying flag and other barriers are placed to prevent
> > > > the IOs
> > > entering lower layer or to fail them.
> > > > Can that be the direction to fix?
> > >
> > > Well, that's definitely one line of defense and it's enough for
> > > reads but for writes you don't want them to accumulate in the page
> > > cache (and thus consume memory) when you know you have no way to
> > > write
> > them
> > > out. So there needs to be some way for buffered writes to recognize
> > > the backing store is gone and stop them before dirtying pages.
> > > Currently that's achieved by reducing i_size, we can think of other
> > > mechanisms but reducing i_size is kind of elegant if we can
> > > synchronize that
> > properly...
> > >
> > The block device notifies the bio layer by calling
> > blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue); Maybe we can
> come
> > up with notification method that updates some flag to page cache layer
> > to drop buffered writes to floor.
> >
> > Or other direction to explore, if the WAR_ON() is still valid, as it
> > can change anytime?
> >

Is below WARN_ON() still valid, given the disk size can change any time?

void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to) =
{
        int bsize =3D i_blocksize(inode);
        loff_t rounded_from;
        struct folio *folio;

        WARN_ON(to > inode->i_size);


> > > 								Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR


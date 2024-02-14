Return-Path: <linux-fsdevel+bounces-11589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E33D854FBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071F91F217DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AF7E0FF;
	Wed, 14 Feb 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WR0s2TlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91C6A002;
	Wed, 14 Feb 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931104; cv=fail; b=BGeVZQ35yni5f+7ZueyPJbKljHLuMcSDPoLauNalRguQXPjjrHGPnT5wdl5NclVGLwL6fFcnazTR6RaAgqkhtz3ZgamQPJlRI7XFZUOII+Zxoaclav/nPZQMZNJAYUuxXMpVugkfKjA1ypo4MI9cKvXnMM4DDXJ/WYnQJv/xCro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931104; c=relaxed/simple;
	bh=vTwWIgqX0u3Tlb+ntMcr+owtlROL0y2BruFh85U9l64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhLC07sC0EmL+hMkvDl+x4gDZSFIPdc08U/cK4e0jQjtIDgilwsSc5KDd0dlWJ/9a1bpkjnL+Iz/A9bREDSHejHuqCi1tfYZEl0e97EnO5X1rmeI4ufAbNh1XlaNj5VR4LhDJHspGO61UaW7wK0nbE79lHbQEBBy6ymAkTtofwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WR0s2TlI; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR1ZxB2ZNVCm3OU24OMo+yaRB+EhFu5UMLR87qv9+Z03//kFihQyoVwKo67ouPYj4ojHr09EB0gCdbwIeB73DFlula4e43Xy48A64CGxZkg92TyjUYG7ASBa0l/wSc24sSyvwpwXMTZVeELsoiBOI7FVpo9YpW6bmGhWXg8YJSxsDXNRLsDA/9ohvFaFeWEvFrRmSsCFqFUxwxQCjp3+Hx4lEXdu6TftuDu1T2FuK5gNwGgcjmw5oQWG8dDBKaaunLxumwy9/SyP7B3fqnWfwC9aBzEWJy6atGbSM0elMoJa4pxCEaBMrAP92wo3HgkTQ9HRkp2DSdeNd8cL/KYvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTwWIgqX0u3Tlb+ntMcr+owtlROL0y2BruFh85U9l64=;
 b=C9CiP9c/8ynSBArJPQB5NhjyX0w4wGjqR47LQ1Oo6oj92gggW3j9CKP2Y5SckUXi1c37QdWJW0BV5FVkbf01sfMxfFnd08r72l+HO8PEkJeOxK7a1LOIYVy1yw6/xaS7m0BLDznssp7BNr6QIsv9Jo6pfWhi/TP5zyWA8N55Ezl7HldRRIBW9m54D93iyqbCJKvaQaYWq7bqqVbGpDxB1nx2311gGsDPfuFoVgEUkd5B5P6l8hjFDND+FbOiBQ4l/0VTSp8r87htvARSb3XIsmXNPQG357qDpEdL5CcgEnbeLNJkobzx4pKs2Nj6Kig/sM7Cs2A8rR8kSizIzbdNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTwWIgqX0u3Tlb+ntMcr+owtlROL0y2BruFh85U9l64=;
 b=WR0s2TlIVokNDnTVBfwMNwvg8L0F52xt2ccHDLCiynokWEZ1UlCo4xvCCl146OuEB8dDzOQPQnYe3Pi77TgVjk2iwQwb1/VyG/7M48WsoWBppW5dfEjkp+yXqyQFRFXFIsYPyp9F3vLDFkZhoU9Yfd91J9P3Bg/kLkErNvpZPMVxxZNb5wHYLypUeBUNiF7KiRSXxg5610528HE/kOrDTd1pz0pxH+Co5xleYRkUl3kVnNdR35h+jIQemtk+aZCxQyriKl5toDNyN/x1lCPV4BQrqSzsqZ0a3XZnBy1RRodqA5F22ciFx+BlaVxAUoLmaViYHFdnQ6V5WULLC33mgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 17:18:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 17:18:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>
Cc: Zi Yan <ziy@nvidia.com>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Date: Wed, 14 Feb 2024 12:18:14 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <FC18B703-54B3-4BC4-B298-5057E8F26A70@nvidia.com>
In-Reply-To: <20240213215520.1048625-1-zi.yan@sent.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F95AC849-4FD2-43E5-86E9-794D21F26302_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa63287-f87f-474e-8964-08dc2d80ef7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L0DHEA0SNCx/D1Ix+CUtkIOkmHw0lEyJSusZhk6hdnycfEFZ5cGK32jNDbtOdcfg4b1WjKJcxagC/R+cVfpqYa7tt+God0xGd1y03Z4tkxbP0tgGycDv8o9CpMA+Ty2pHSKLlrnfDmpV8Z8KzdSk/esxg7e7an4fNmYRqx/U0oizhNtsOnq9c03OYRizYACX2s5hiprsA3N+y1Qjo++n/HMQS5HJ/p8hDVRMVhqfj9VPDwNRaXkA0/wFEJ+0D3p0eWBeq0Fe6q/T19iBPFlmRRw4QJWMATUjO/zPlWEIK39ekIGeYigOUYTIt7Y9Epp8Fy4K2hqk6qn0ABzjsrlwyCGO4qw6h21NMORyZcWSlljwadGCkDnPEYJgIyiqWVtmdHbH+6QwVNe4c7r0g5sU0DZDHaoHgWw1qTdti4RoKIuqooAtrXY7M+TujBOlA/+FVgkir8zm2jCMMSulgZGb3okOOTBcQmyNcsTPxAceRGzB1s1WFU7Dg1GTDdCsg406BacVh2uQeq8poBYT4iy42HSqmIkc4v58pX/h2Q5OO9ggVJAa8VpVfrDytwfZt8Te
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(4326008)(235185007)(5660300002)(7416002)(66476007)(41300700001)(66556008)(8676002)(8936002)(66946007)(2906002)(86362001)(83380400001)(36756003)(2616005)(54906003)(316002)(6506007)(6666004)(478600001)(6486002)(38100700002)(6916009)(26005)(53546011)(6512007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZC1urCTrBFJU09ZXDNUhGlnT5YkW/1EWmQQGaB8p0kSNq0oWp7UjpAszPO4f?=
 =?us-ascii?Q?BCC13b+ONfRj9lsWIBIMJ2B+zQneoscZb8Eg1KzO5GdLRJVUosnsVFsqdVok?=
 =?us-ascii?Q?wV7T+m2au29F1gHDIffQPFHsRKTBo9Ie0a8SWEzC+spndPzSaioFLjQRFFeM?=
 =?us-ascii?Q?rpKioSGHDspbmNZiJ085PYu4of23zrbc0sOpp2SV7QVD6vregy+9fGEJg770?=
 =?us-ascii?Q?0ViTfAuPHsYoPlZogSM8z7+sUQow2tMUnHRRVWsXzpG3iiHQhER3GyshZI6K?=
 =?us-ascii?Q?sZfQhlySnJELKHk9dYnlpcedNMWCctAwWzTXd+pm3Ej/CYD9PnIKiEQnNL8P?=
 =?us-ascii?Q?rzDZtWOH94xkacCXp4wgg0pCcQIzzBH9UMPwNtFxdv4aFlD+ZPEHPzyxn7Mi?=
 =?us-ascii?Q?0sw/pt1gofJZtY5H9KiUVUF3O9EF+9GNuC/4iWS9KL649gAo5XRxHtAaZDdO?=
 =?us-ascii?Q?nxMwCWb5p+RoXXdJuPYu5s07fPcxgUiAFdv23sNFw/Pt06a2C3uBj8XW5rhE?=
 =?us-ascii?Q?SzMWUVCKktNfuOBE8Ha5V/HzOSlAgSa7ObPit7ySJORpkYKN+Yi/aPppkNDc?=
 =?us-ascii?Q?YNLrCAGTL0TO3jsqYeHUWg5tqe0kFdiJQgaDlX0r2IQtMf2I2TfEXD4qIdXs?=
 =?us-ascii?Q?eTTyPi5b9DSeNH9f5/O3SakOZtfbElytYLF/BxT515snxlAuEq/UjgWgPqm+?=
 =?us-ascii?Q?ICVtLrNFDmM0CUQAM2uINJnkeDf1+E3OVxXidfGSSF/34R6nxw3aiGMIQOsO?=
 =?us-ascii?Q?kPmVCqYUtI91Y1jq0PlcZX0Aa7rbLCHJKESAoTrdT6fSiSgYwHX8YFF//Dtw?=
 =?us-ascii?Q?/v17WszNB9XJVBUtOiY+Xv7R8q/g6BHvbbBSRrvk4w10Ta5H+ezt8QBeW0oa?=
 =?us-ascii?Q?2vfwg3Id2Kq2xinj7NKhniDfommCHuv7kTpNT7uLZAOfiUK/a74TMqZrBG2P?=
 =?us-ascii?Q?n/zMvR5Q8bXg/X0MFcGjAWFEZTt0jgsMyXhGm8hkIk3nXJtMFvrCSVJEey98?=
 =?us-ascii?Q?5/8+4I7HeVs1vdq+i2hWvl7Ba3ZpZo/PYAdLiaBPlSMCSzJAydo/wjvUohTq?=
 =?us-ascii?Q?jQuSsPSz45IoT5TUfVn67+n75QW3/96MhGjHlPqcmRMhDizd4gon63IGxOW5?=
 =?us-ascii?Q?FbaWGQpcMCN7uI3z5w+fKS0ynWchbqWN6Rj0l/LQ9pDnGGcMv+zqt5uJNdcI?=
 =?us-ascii?Q?XJR6X8c8DmZXwz/NcXreOM+XJzpdZlYbXpwospW50q2IRz6cI/PnGdkYeXAn?=
 =?us-ascii?Q?DD3mNh2PV/qWSWBBvU0XbEn+v2LXW0NFN1pNqCMhWv5WBxaX35O1AtbKEw8s?=
 =?us-ascii?Q?pzsKNSUjcDvX4zunQcJEOHId98IOVuels9EHCMR1z+L25lLrTRuwXQPCBkl/?=
 =?us-ascii?Q?Qwec0ivFCiOqP9LtO8lH5JfjftYGkKsIp9laSKOmLArGR9fhCvlgzngq49MY?=
 =?us-ascii?Q?cvxQGv1PDBIurBgxDJykZ00Zuq5BSERY61PCept6eBW6IS+ZtuXfh/lHG5Ef?=
 =?us-ascii?Q?QGanVPjk15WSuwakyFIpays4Qkq3hH8q8DZrGxeH8rQ85CICSUothqux/gsc?=
 =?us-ascii?Q?XwOSqB8Ffe/0Rfn1N4AiveFr7/ZN3jiWM1vviXn5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa63287-f87f-474e-8964-08dc2d80ef7f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:18:17.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OS9DNlD2AY48z8fJZqvJ5z2/39D09IKlS9sh/sMaQtZD6Fy6B2UP+nLx8hy+jg8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357

--=_MailMate_F95AC849-4FD2-43E5-86E9-794D21F26302_=
Content-Type: text/plain

Hi Pankaj,

On 13 Feb 2024, at 16:55, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> Hi all,
>
> File folio supports any order and multi-size THP is upstreamed[1], so both
> file and anonymous folios can be >0 order. Currently, split_huge_page()
> only splits a huge page to order-0 pages, but splitting to orders higher than
> 0 is going to better utilize large folios. In addition, Large Block
> Sizes in XFS support would benefit from it[2]. This patchset adds support for

Just talked to Matthew about his order-1 pagecache folio, I am planning to
grab that into this one, so that I can remove the restriction in my patches
and you guys do not need to do that in your patchset. Let me know if it works
for you.

--
Best Regards,
Yan, Zi

--=_MailMate_F95AC849-4FD2-43E5-86E9-794D21F26302_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXM9dYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUNF0P+wep/G2wo0WtIT8T+bzvTktVREFzBlTRTWtE
8PKuzfP9jAAR+RSKt0pnrPnpm1+nK0yjmGn7fZGCUDVomvyPD1PsHPDcXNhbw1oj
4w0QWJiJMPC2X0s2FIvHQRe+9K3Ciuj1FkKGmlBiG7NuZdoqjT8s28JLvGZK8Fyp
OodtQ46Yqg/vJwAXU/ZJI8Nv7yHJH2hTl5+FKPKiVTRBpdWKF+3srqrbuT2gvaoz
w/Vu4MQklvOK+FinK8sxRc17TOj5JeB/WEGvReCBmBeYFpBln1vTIjzVMjXdCkX5
JsdC56nyqbfeY5h11gTLMFMyEz1YxtZv75j6EaVOUBANavhgN9hfomwWFXOI2tlX
itBqpi5mqkft+ZyXLHyjUWji8wXBNW7yk2eyi8pImQws4nfU4Lnn+fGV0/m9worn
XmS8+BcYmElbWI67fNXa4CLXApBGUvsOnPczSLXo+gmR0o4IRBuBFZndCsl1/HFR
0tJPAaJKwhLolunvJYcxPC2Z6BxhQsZ2WYb6rO4lBIT0ciJrwgXdPK8OmENMpP9h
11JSH+uWTfFLWO9QW1iQDc9aCsZP90ipEmJwH3LGbvMJJpk1WcIlGYqb9uqoX9bA
kDmoP+lAUOwfDS2zrtzo6jprFPs3jrq9MyboLVZH90v2jvEeMumqzJjm1ExnkTI2
aw8dT2bt
=V6JF
-----END PGP SIGNATURE-----

--=_MailMate_F95AC849-4FD2-43E5-86E9-794D21F26302_=--


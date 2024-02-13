Return-Path: <linux-fsdevel+bounces-11473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA0B853E6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E3928EAB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1816215D;
	Tue, 13 Feb 2024 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJC5X4Kg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC36168F;
	Tue, 13 Feb 2024 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862517; cv=fail; b=SZrfeUuZ51YCHn+TaZpoOM6EdJ8pdHbunwnSqiuxB7T8opNdU0otG/7ijyGcPkdFg1A87L+e17X28PIL3HOeDgZttHAnErOfrUOm53jX6T5MSE0GLRWstp054YoQfQ9Y0r6QdLGDCpekBlPrj5HWhG3U9FmgYNl74mxmXjLBGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862517; c=relaxed/simple;
	bh=tRBrUIlbn4b9mofTj1QJLY17+J81ksDXXF7GgkFs04M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nuHY0wDl4R2E31V/ODhJvlWzMgLjNJQBUxmW94lnwwAf8CsX8SC4Nv9JwVAp6aizeNpjRoV7yr7F2BrlOJXWJT8sbtvjp09pXQ7fo72Dx4ikotSFFFrUs8LKLrwVf0F6jPRfjlqMAX2X6Doxyp0NLUPCdfTQ5w6VccUCMb0LDOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJC5X4Kg; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNGAPTTVN1X4IMiNpMCnRMujCFM+I0llJV6+ieF6jAXz3euPlJs4noTSotNXE10HsojOGPlEuscHBqEeNiG4xJqiipWpIsyTTCw98n/9vPlqod4Ko7UIZ0RkAS0k4TiOW7/8RJmO6nX6p0hcXgPSsI4vXxP+3jNmQVOKp2fMSUpOOqaBw+sLgyX94skDnqlvIGB9kRcubUddlukIwNlYOE1yIfp3xDTZKCh/gh1kS5hpSNJd9MeGil1uXsibGpnUkqojmPZACuahwLC7s+Zu0IKbjz6gPf7NwbjvdAdIBZfG0PqSsvHBI65a5pe/7tdJILGXnIb2O4DlGBF5c7zFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRBrUIlbn4b9mofTj1QJLY17+J81ksDXXF7GgkFs04M=;
 b=IJYKbDLiouQL1HuOu/NEmtNWAQzy7CLAYP5PFDfTBrA4W8hRogKSNBTsvIsRIU8Dru4C5JzRYQlDAodiLoltHAyX4YKQyMlX701IzrX7L6aHczjF9I0LvrgLtHZo3LA6r5wt555rua4m4G4n8VyKUrC5IjdULbXcZ5I1yUeK6RF+qMTWHLDdnFZPexuP60EZHOGNGs06jQxnr8dqH5BbJm96JpBlLbuqiU7dBPcdhUgddNv6egC10wgvhL1ds2dUNRCTwfPVAyNcjTapla6Yz+RjyKOjBoMBeqcRlHFOrD0hZBzoVtmsYJS25pZhGS29dooI6lgLCCzKJEujsGeJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRBrUIlbn4b9mofTj1QJLY17+J81ksDXXF7GgkFs04M=;
 b=SJC5X4KgdRG+bBugbwO9KKehGNckZqnTV0FFIohl0A/FGvvZ31wvz/96nr8s4RLsCfvHBiMPtpZjVOU7xoyoRCxNk5IO/YFXWYFqwHVFj3gnq/0WgWTEUTYI0ieM8O5ZfWJBq8woXx1vYQx1ABcE4eWyAJhsXjRbFaYoj1zS5W1a0FpDEFi2Vq1vBkFzJ7aTlVQlWr0oRKCqSCBBXfbAFvmUpvCOzwwaZU5qypnw/wBpDA0YCVNMoR9N6XGBYhMHD+NGNrkMr9Dbzz/bGmp41Y1Ez1fa/N/I6FtqvaSnYy+f2UV2FxRNW+JCRiw3qz/VTmkP1bIpw2vFAkq49847Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Tue, 13 Feb
 2024 22:15:11 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Tue, 13 Feb 2024
 22:15:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages
 (except order-1).
Date: Tue, 13 Feb 2024 17:15:08 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <698B47BD-5E5E-4B8F-A998-8692A4918A5D@nvidia.com>
In-Reply-To: <Zcvns2HCB61cwvgE@bombadil.infradead.org>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
 <Zcvns2HCB61cwvgE@bombadil.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_ECFEB14F-35FB-4AAF-A451-76996BD38D54_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF00013DFE.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c927fbc-23d9-4ce1-a817-08dc2ce13ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7hE8WSZ1Yo6ZTYJpHyn5GHx3tU60eZ7f2LCXsRagYWmB19jn7YnqDxRMOFHU++/YHtfd4q2YgNaJZbIuGATK2kxlSFLLKHcA89DvlVKescFZEMGajJx1pVgYIY10KdMjHGv0Xr0MrNwwRMc/R+UGiX8SSQKbXFfEDVZ2nZVtRVveV92cWNdkf6AKeqqLs1aNHKCxOY8WJ5jmNoXZsEJJ7Nm1opypvM4yTlSxFuZtPgKuXPe++JDtMczS956pWQl4TBrs4qCXBdjEPcqfxmCehJ8rAXE/gUEzB286UdvwdO10xf2qrAsR90kEpiOpO1InvXuVvE0+sqr6mnhnBz3mkwzp+weBJUvKSd5s1SHlhtlPkfY6E6psH3sBvlWntlq7YkX5IP6n/yMU0WFbPAvMydvZWK/jfBi5jMXqThAHyZ8tN6+XVXho2Z8+uN3Jt5AnCWoIwg4/QXuYAqaswBEONOi6/7sO1BHSSex+FU+ZyhvFCawzI12JjN+KIJBPZ0c59KwiAg9oeyG+EsxiU1x7ABLSSCg2Fw+8MVnB/vk4M7ec3dc1qI5I+cGML+npzXpH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(2906002)(4326008)(235185007)(8936002)(8676002)(7416002)(5660300002)(86362001)(83380400001)(36756003)(33656002)(2616005)(6916009)(6666004)(316002)(66556008)(66476007)(38100700002)(6506007)(6486002)(66946007)(478600001)(6512007)(53546011)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izqnlw/gLakecNkoMXbmrW9jsjZGJrwLjxDAeAYrvY/oYJ8YoUDqSpPlJIzc?=
 =?us-ascii?Q?RiN+LTwTGxNPUvvpTqzAycAf/f8gaQPVoqqVz8qJsxhe3Jxb/1qX3GIwlqlU?=
 =?us-ascii?Q?KoIK3LY71zedOxuvMSEzKCeGYByzgWYJcPivDJhRxmsn71TiU17fPGEPDj3+?=
 =?us-ascii?Q?motO8Gu4TThw0Axm0LLyhzAdCbMMhYvb9IW49myu0nB1gWA6NrW8/3+cduNU?=
 =?us-ascii?Q?c3csUuZsw668uXaAFn3P4tkMbF3EzCHKwIELRKHaMLP/lnKdCOt22OH/drQ8?=
 =?us-ascii?Q?aXOdxW2akiGaVMAsHg3PQ0xSakkyq369S1xl6FcsYMERxO06Vwl6GCSfCKNW?=
 =?us-ascii?Q?GNBMtZmzzxgfDdaq2706y0vR8Z/ucNZXzQB8BvxPZ2fUqY8QHNr2Eu94nWtt?=
 =?us-ascii?Q?SXziZgn9XJA/BBfJY2lgqUDhXtmwi8W3a+ZathMpKZ6ZPaMzz2qMu+2yLPmE?=
 =?us-ascii?Q?TLGyVZiWKp8nGqfX1o2ckZzjVvXEBfB+UhSzw41EChc3C51KzQx4JxQ+GP6h?=
 =?us-ascii?Q?JUOS3uCQdWXeZ8nIc9FMYVmGybvGvnihmNtsnMHB4z1E9wioJZhSNB5NZbgs?=
 =?us-ascii?Q?fX7e+oPODo12sMMwL9lbDkNrgRVBTG+JjzgoYRxOM9ls21PQCbmTKoasCKDB?=
 =?us-ascii?Q?1aaDjkcUClez0IOZLOkOhtXE0X1/a7dGUQT3uvLT6k5VbI1l2h8oYExATzzo?=
 =?us-ascii?Q?4quYYFNsVkc9TQg4IssM+S3/7o4US0wq58GGu5W74458AP8wco2eC7Tryeph?=
 =?us-ascii?Q?70OF+Cjdz9et9VxKdp3TlBX5mAki8+Ei35JwZEpzLNyE5mHnT58+v+wtwIAi?=
 =?us-ascii?Q?YLcmCTs5uTImqgcct8FqnPy1rMxkgYBEO3Jf/52URDb91z7KqcojeiJ9QplI?=
 =?us-ascii?Q?0ofuz+qS1UEzT0u5O0c6hBLTakuH6rx5wNDtv0t9RXfX78phNXgB4MENbsx2?=
 =?us-ascii?Q?QyYXDdVSszOx6DWO4fn3Ctka+boAwFKNccRKMo2P2HIkhYPCO2m+4MF+dTfk?=
 =?us-ascii?Q?Vi4Pycbwv035BuqbOwOWmJcwOLt+LKDHwWQTULTZTVGQ7045ZeDbOiqHonoG?=
 =?us-ascii?Q?BUQpBzurBmypYTJcbKEzg0s01Yls7RxhL7bw9U7mtR0OHSmTJOyo8YwlqOlG?=
 =?us-ascii?Q?yqJ2Kd8vCDgspU2vQhtee8owfboHTTYGxBJ99xgGE2DBDezwiUtuW83bZCcn?=
 =?us-ascii?Q?VeNE+VUTC9DClfzr8kGsUiwW4BMMlgTf5vKCyC9Vc7clA54y2ufPG3YcSrp4?=
 =?us-ascii?Q?dPAgW4UnjIIWNu3876OK5ZnJFCBXNWCCWfGijl/8EUmRv5f1/bLhF4CNpOb4?=
 =?us-ascii?Q?XI42shthVzAaJUrnx0/3QbBPW+9osAtdnZP2U24hhGy9BiYALV6gbAy7HYt1?=
 =?us-ascii?Q?8d77pEZcjBwjl8fdjDyykQVad68FfpkV57UA3xtg+ldSQRz6nHG2lmpS8HgL?=
 =?us-ascii?Q?tVBY4rsZ7IWASk2JQgptRjWMX/W/HxtJhH6B3ZRcq/Zv90AxZdHuJAO8ZgRk?=
 =?us-ascii?Q?HyUNvpqI6fTgdG7B+mmLK0RjpMSpGkuhTiejgqn9JcieK7k2d8cuvBP/JnBm?=
 =?us-ascii?Q?FktUg+P/XhmJ++SgFAQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c927fbc-23d9-4ce1-a817-08dc2ce13ebe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 22:15:11.2730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIiafYXQ/CDbvcqleCKMT1WD2fUOVsQBFpvgAc60pGw+XFF/k1FM17qHZ4Kmck2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

--=_MailMate_ECFEB14F-35FB-4AAF-A451-76996BD38D54_=
Content-Type: text/plain

On 13 Feb 2024, at 17:05, Luis Chamberlain wrote:

> On Tue, Feb 13, 2024 at 04:55:18PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>> Order-1 folio is not supported because _deferred_list, which is used by
>> partially mapped folios, is stored in subpage 2 and an order-1 folio only
>> has subpage 0 and 1.
>
> The LBS patches has the patch from Matthew which enables and allowed us
> to successfully test order 1. So this restriction could be dropped if
> that gets merged.

OK. But it only applies to file-backed folios IIUC. Anonymous folios still
cannot be split to order-1.

--
Best Regards,
Yan, Zi

--=_MailMate_ECFEB14F-35FB-4AAF-A451-76996BD38D54_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXL6ewPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUfeoP/2vDKBsAA/VFjcN954Xo6f8clK7PtLrynsmC
uk8YRST14wJ/ZabPHL7IEq93i9dA9p7REie83pjUEcUfgYB+Bm55XSL9KYDNbWEy
IgEZZdXtbh3ZqPGeetBH8pZc0dxfVYga59tTL9O2a3wKOnys6YwAxlShkE7pb55D
emu0EDPIDvtmRm4XMlMlBzFOJZW5HzwUJ/j8Eu2uj0gTKrg+AXwIDNsukiM/CKOB
MHbza7XYQnx3bgs+/yp8Y9Gp0pfiCMWpQdD9wamyjvCldltWUqBt9N3DBAKG0BGp
LUQUWn2GKvyHZ+vc/JpiD9Ot9KvWhKMdpR9jZEsvB7dKWZd02HE72Efvow4u0Do7
Mr5WtBdHpoSaQ01yqBv9708lUjysm/si88gh/QhFVuIuIxnXj8kGbcn/UieLuTb7
opZm9e2aXDihI01qqAxBj5lM5gVsdmKZ/iCrvp4h/X5DyB4rQdBntwq4MQBw6kqN
3hVHw1Z4UQbkGPW0ok6mEZVX176Vg6wOkVPlWy//qY1KfcFrUaeQ76XYa5c2N3pe
Ru4S59HqR5X6k+XsC+gZSHbT8Ws3r+AnS4+t9DdYbWooW5o4+SrsXywCaNZg61pN
HDOWy1ISaDp/F1khoS91Kb3Bl79EVApXz0gUFyei9lh1Xknftw1iVdWAeJ4GTm25
qDb1xWv4
=FtyV
-----END PGP SIGNATURE-----

--=_MailMate_ECFEB14F-35FB-4AAF-A451-76996BD38D54_=--


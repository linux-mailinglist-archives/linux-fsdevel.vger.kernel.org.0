Return-Path: <linux-fsdevel+bounces-11509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7088541A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 03:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE841F23E83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A779449;
	Wed, 14 Feb 2024 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O9p6Yb/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211D6127;
	Wed, 14 Feb 2024 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879413; cv=fail; b=k6rMvW5nflHWzVc3sKOM/9ZMyOEUyv7l1HbffJb2u/Yh7ZGE7p8X8N6GYTGud32tV1NQ/A6EOJp68yfNbtpH347CYksXS6iysDO+zfcQWF1G0V9z+mIA20a891wRub6EfiXpPIiZ2Q5qUCegUvzVbGnHxHvov13D+i+LiWCmIk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879413; c=relaxed/simple;
	bh=13fEx3uSVqarsFmbGHfbRLEvzEKEI7iLWC1MViINoWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOHXGpEt/LM3wEUVuKCfIT18yv8bZzbc1QdbJgRSrIUZZKdyE/oAJSVDJ1qYGN1NVOhaUrtiJ4a40DpPOkZVpoOnJIWUI67QYF0Uii0BQ1hLxwNwjBvkhRqNHflA69fKiX4TVfeF30IYXnlIz6VEaiRIrldCfSdJ60f1LQjcvsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O9p6Yb/J; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNJFOjt2c49GNb1M54a/C6MXpDdXLya5CZSjAuyCctj/HD6RmCRPvnzCqCKJX2xGvDlo62VuFYhvpTNdgmZ6zzP41ii3Sk879k3hRbDNtEi923jpcHS37KrVgiA95vU4Xdi+IcM8/IwncsuT4Rdq72hnDWGjQ65+Zbuoa5jYf10yJhjRANgDQy12gypdMI9k2F2mQDVHn/2wud8euTrjo/N5BMX+BFo0+rjNVb+Xo/nfnUDpa8W93B+WDzbbBXFwzuZZTyE2WFatrU0YX9ztdlLUbJfuraTJkwc97SwMg8uGajbqCZ7Rgq0toWJRPFV4C8kV/jxv6gJaxC1ivS1G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEWoI5Tzn3wyg97ZVXeF7CU4aMHs06hl/7GKbHjdKxk=;
 b=Ox4OaAZaWth1Kg8mPPEm9cPzhUf150sS8KudRp5XT4XPW5agLvDWwzb5IDCkT8gE9ShGU2sE6TnqtENr+/z9WOlFZM/0xERAJHuPZbGkfPbepqcxmvyE/DniE9g68hMboj7o8F4L97M1YTmmR3tnKNuOCCabVNhHdRyX+mv/WziD8CY46YHFmPWvBLObKEfS4YmDj8xXAA4GBqzDZkxhsyPXUltXypmCj3oBxm67ImOWhkA5/0CHx0N1G+3BVumoIvXkz3JaBlF6a4rWxlDNmtB5SLVy6zKiHieXyk4xVwQG9+98/UWl7KGQgN9Ta3XVMPkNShosfVm++RURnTYx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEWoI5Tzn3wyg97ZVXeF7CU4aMHs06hl/7GKbHjdKxk=;
 b=O9p6Yb/Js2bZRl41Al7e5JTx8PFIbYD+cJGTNk7NZ/kCsshZE9nhgfHDlmW5JrAFQZmsOT2EAtncmcLFJ0hpVWxxlnJ1jj5V9kF39aITpsKYmbGxTFwZF/JfL3hnnJ+lf1zxHfMo/GHBk6y9ZVh1f20gQSCmjDuyBVL7QgaviMsTuK+VdVSj063NXuAXTv/lN64ergl+97rcHAUvqdd3lkyegRC21lTSGEK5f9nTm0+/6hY3kuly86VAu6F5I6EJi/Uqbuo+bBcz+V0740XQf1KAh/5f3dUYJOMm793XkA/8lTilmySOKFjKVM9CDfFvFOtFi24hLBDpjMoYzBGOdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.12; Wed, 14 Feb 2024 02:56:48 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Wed, 14 Feb 2024
 02:56:47 +0000
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
Date: Tue, 13 Feb 2024 21:56:45 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <5CF2076E-E56F-4E79-AD95-F58111A623C7@nvidia.com>
In-Reply-To: <0A9F291F-E6B3-48C0-A2B5-3C893F02AE1D@nvidia.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
 <Zcvns2HCB61cwvgE@bombadil.infradead.org>
 <698B47BD-5E5E-4B8F-A998-8692A4918A5D@nvidia.com>
 <0A9F291F-E6B3-48C0-A2B5-3C893F02AE1D@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_AEEA94DD-FD34-48DA-AA55-B24C5F506FC5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:2d::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 5386b68e-7915-4753-3dd1-08dc2d0895e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gxDcKvDWWOWg+2BkjCWQ5mz3366mS4lri9qtOLOMRkX95D5FPY965Dt2GsNxUCDP9BB2ZSLZWIwKHa+pFvQIM8XEPHc2xFAgJlrbnFWpEdPFmaoqAK0qKMqXhgi0NvkRSw57C0+GVVKR6/A+u1rcR7QuIeaq9TIR+ipi+RhFvCfGpNDHTe1JQY0+WhjoNxa+4iEmjy2mgxkekw3FPxGPb94Qktloj1r97tiO8mvGrqfRRZgnS4U4jLZ3umJjO01PocayQMQA1/K2QZ+SpSlfhZ6HOHAiKi41Z+qX2z3XyXTM7PlE36WuWDrzX2X52K73Gwf3CGRxvfDb4Wzkfa4dgJpQvlW0//AvEye+r+mSpCtntlqlNNislWoTneP3SraP72GZ6l3+nnTFJsothWvaDpqOeNiyk6QNCqIYA04Kud2FQ+JY7lPdll3sDjCHytFVNd04QS2NYVurUvRysO/HAQx1an3OGLR2js2ibXHHYO6AWNeeseP8Fgwgx40hysuqBDjdL1K+S2bQbVn1Vz4htQvh4jXSZ7xuzHmUrp0hyG1T+KZ7eglNccA7sSXjXYXO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(316002)(36756003)(235185007)(5660300002)(2906002)(38100700002)(33656002)(7416002)(86362001)(66946007)(6916009)(53546011)(26005)(6512007)(54906003)(4326008)(6506007)(2616005)(66476007)(8676002)(8936002)(83380400001)(66556008)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBHfPTQb3jcBYS5DRI3vY311D9/ULCxE6avPIvN5VyJgDqu/eAbPSDqF1DMY?=
 =?us-ascii?Q?PHK5TnJctyFtQh3cQe3HCaZC9lF7lvdVaKRtT7qAamUUTb7qIHfLW7dWTMR3?=
 =?us-ascii?Q?lNTJ4kOZU5PfwjcOfTyYhtf5ySdS0QgrnBXoDxIHAYEno+tNKIcrlagtyu0o?=
 =?us-ascii?Q?AmiNFF7NwuTRRjMIx6DwYMA/IJeKPKchtfBi7Hb080SSRMXQBWOCQZmhl1Z4?=
 =?us-ascii?Q?wtWmdGDFy5fX1RQPQzt5ZLCMJ3uVecV6UbNOybZV62e+4m4auXX8wXA0w/N4?=
 =?us-ascii?Q?JHl+TIWZ0hLgJ1qfpVUGUmYv4nyf6gSUwThNrC2aR+WIunL8Mvbl3CeQF5W0?=
 =?us-ascii?Q?iIyoc6G4on2tDKfb7EIkROTB3GXzGeNQh/G+P5foXha3CnxOOdjdZlpciBPX?=
 =?us-ascii?Q?xgzJDEm0cuMUF9WeOxf5CF9eZP+g4CE4oyORPLUWhUosAbNIGHoerNeo7Gvq?=
 =?us-ascii?Q?ETHACMy0dUmca+SWOy0HhAmh5+3kKpzyT7CLSFw8xSfuig4kqpKEjdyRBRC1?=
 =?us-ascii?Q?rpKdbiimmrO9T7CBMth5RbnQv6EgSExC4v5eAi8S994SWf4oB5lx3xPkc0y0?=
 =?us-ascii?Q?b5eoqRtfIRY1BRX0FoQKuVo2tq5bKLV1VnD2e7WxLuTNH3zuB2DdDNNdpCuE?=
 =?us-ascii?Q?d3fChX/7PxPp5SYLnM54GOC91uFlQeS71wApqPca+xCPYVu2yytsbqKGibTo?=
 =?us-ascii?Q?uIiwVeAuirbaM8lMKsJCVEjT73uaYXA7P4teGUEabDy7Hh4NDTvboqNFFvNa?=
 =?us-ascii?Q?OOOSUeZtUWG1V1tnxkdXabm4tCNPwKy2jksADIUXyMDUMT4lVG6+7t7cPOMg?=
 =?us-ascii?Q?zlZfYzI/R1gk88wag0BPAEJvucoNc0/G4S52kTPt5UxK00uhe8AIy+YY3TuK?=
 =?us-ascii?Q?gLaCcTzyvZyF8a9Zof/0fyPL0gxmsCtOyeiZM4KBbabYTrzQjscCGRzBAmkM?=
 =?us-ascii?Q?y6qUYekx7mez0uakMrc1iSdxQcaGW78Hg55DtSQq3B94HMuwMPyIoLEn3KqY?=
 =?us-ascii?Q?cR/lEI37xzlTRoufZG7iLWqt22MXJcPr+tChK7gT907kvg7vQaxrgdCaHcaD?=
 =?us-ascii?Q?ZB056QJVQgdpLGiDffNytzbhyRBu17f66AVY96N6k9A47l8UGlCYfcrzHBkz?=
 =?us-ascii?Q?6vgb41FN/dYwgA8u8uzoZ4oZnDGnArVX/PGmSw/QqZe2rrF4umkMepFcstEq?=
 =?us-ascii?Q?3isTjDLTrG0g7BoU9vGFbZf3qFfoxBeIrvB9XryGr8MPDa+t0Ye5JtWHxJf2?=
 =?us-ascii?Q?R+An/jCVSl5rO0/jBWudyzoA65lwHBMNlhSNt+hxQiWpBTWdRozvHli6Tuoi?=
 =?us-ascii?Q?0x1bBIavy5Vvdflx6PUmy7T4YqpzbVW0AZAtOnUPqYeRn/25bH3vtGys+isn?=
 =?us-ascii?Q?zqZ/uBn7OR9OBDbv58S4K+TBNQ4w+FjsqJcDU8oOLZoRSquVGif/pp0W96sP?=
 =?us-ascii?Q?YCMsAcKbx2oxfMTIAF5DmB/Q3xMH2jlICgYjqjnMc6Y851H6QcTVdu++7o9a?=
 =?us-ascii?Q?1NgRcrF/94Cp+26kSxt/FAptvsXQ5c6kd67TAAoBixq8p+dxYXw4Gy06PAk0?=
 =?us-ascii?Q?So/pU8g+nTinmOaOOLo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5386b68e-7915-4753-3dd1-08dc2d0895e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 02:56:47.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k3ob/sqmiyvuK8ShnwUOLOwatuoEWldxO3CrFJ+4k86O85On+qlfYXI3J4aMBLd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

--=_MailMate_AEEA94DD-FD34-48DA-AA55-B24C5F506FC5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Feb 2024, at 17:19, Zi Yan wrote:

> On 13 Feb 2024, at 17:15, Zi Yan wrote:
>
>> On 13 Feb 2024, at 17:05, Luis Chamberlain wrote:
>>
>>> On Tue, Feb 13, 2024 at 04:55:18PM -0500, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>> Order-1 folio is not supported because _deferred_list, which is used=
 by
>>>> partially mapped folios, is stored in subpage 2 and an order-1 folio=
 only
>>>> has subpage 0 and 1.
>>>
>>> The LBS patches has the patch from Matthew which enables and allowed =
us
>>> to successfully test order 1. So this restriction could be dropped if=

>>> that gets merged.
>>
>> OK. But it only applies to file-backed folios IIUC. Anonymous folios s=
till
>> cannot be split to order-1.
>
> Something like this would lift the restriction:

Actually this, since folio_prep_large_rmappable() is changed by that patc=
h:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0564b007cbd1..05eeeafaa9dc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2852,7 +2852,7 @@ static void __split_huge_page_tail(struct folio *fo=
lio, int tail,
        clear_compound_head(page_tail);
        if (new_order) {
                prep_compound_page(page_tail, new_order);
-               folio_prep_large_rmappable(page_folio(page_tail));
+               new_folio =3D folio_prep_large_rmappable(new_folio);
        }

        /* Finally unfreeze refcount. Additional reference from page cach=
e. */
@@ -3045,9 +3045,9 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
        VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

-       /* Cannot split THP to order-1 (no order-1 THPs) */
-       if (new_order =3D=3D 1) {
-               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
+       /* Cannot split anonymous folios to order-1 (no order-1 anon foli=
os) */
+       if (new_order =3D=3D 1 && folio_test_anon(folio)) {
+               VM_WARN_ONCE(1, "Cannot split to order-1 anonymous folio"=
);
                return -EINVAL;
        }

--
Best Regards,
Yan, Zi

--=_MailMate_AEEA94DD-FD34-48DA-AA55-B24C5F506FC5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXMK+0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzksP/0hfFTrmzRI3eqI/b5dhJlPMLyOfv1UKR5df
lPjmyMIOlstWocpO5C01WPBoZfdPNhnb30oujWLx49z1+ioxHMB7EFR5kJmmkHOV
N1/DDX1NmVT6b2RHYTU6siexERbImeSIf9hppWJ7jHM+nbC5nxr9yn3psbdQSd86
TAVSg9+BwIaibwc6n5f8CxjnwdjP705mus6H12zL56A+T32N49N+NbNt9BSmi0RI
lThX5zjP0/QOX8R70KjlCBajGPb0zpPbuWvQfDLG83H5GfsgPOKtFzB2p3s83BG8
mO3/gGBZNDMOkhT1kf8Q2HU3Nveeo4kHICoduPwbIqy9vqW/OJ5xzOcKYCI7WjyS
tE5w4TiSZUf8gQY5dmlktgoSgr2I2Uv9UEk2+d5G4OPRfVwSZK5spQSXmjd2OUDm
3j+wTLPIjcUcG9PbKBHyhxfJor8piSK/LhVd98HmUCGv36/oDf5I0pEZn/AkgnOO
qhIq4TpUzczhtJ5d6QiQT1GqbxAx3vWiO/jLXoRntOFmyt9zzAldsl+8wnHBrosL
RyB33xYPgVH0ETHtf/Y+dzTQ48zD3Q5tAZR789ifh8bzxASU7Bprg4stTaWk7lOw
tt4jlBJzxLW50LILpVFPK8QAL4611bykfp4GLVlEKdQ32FIynslTVwsjR8qWrVGz
6U1fUp2/
=RqS/
-----END PGP SIGNATURE-----

--=_MailMate_AEEA94DD-FD34-48DA-AA55-B24C5F506FC5_=--


Return-Path: <linux-fsdevel+bounces-18653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E309A8BAF44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720921F22FA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A248788;
	Fri,  3 May 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h4mT+eCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463516FC7;
	Fri,  3 May 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748014; cv=fail; b=gh1jKV3LghuGSUrVIt1f+JwEFPKfz35liP9uiVbbNkh2PC8+wAydgNbDe1JaT9IKW/ENXhI5X2XMFOFXS/u96U3ecgf8GJ8C6rjcV9p2m3xg0tqNAl5sreNvEs9i1sOJomwAe70iLuTfuGM1Ab/rHP4SqKKKiuj4/snRNd+0pMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748014; c=relaxed/simple;
	bh=ane7aaZZngHCi4hoQ3AtNpwP0oSP5JEBtpsoFmpWIx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VozOpLgdoKLhsfojtXu9Gh53NqMjbQF92+I07GwPn6zEWryEjOgU4m5AIyUpDmK+JVjTgE5Mnyj28t887hQAXNnjEl8lj6YySf5H+od0QSBP923m3wqlfnSI+LXR/NWmUcbcLLpDxOZQlGb4YtTNzwzxllblf+A0lbAwEB4qSLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h4mT+eCI; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ex62HpzQ6ziA3+tLAjJD2rGRJNCOosU01X2+kjE9K8IvDNZdPS1KfrYujgbxiXjRiq92eSy6hdh21aiN30dsFPkaQnibPf/+zWCxOuyMg2uhbJVNYbZXw4WKZr91uTZqi/cXCg1FHLetAnb+XWt6x4+Xp0zuYY6smm2RgRjPf/ico8Fro5a0GIeilpCsgs/IJfQJ6hYKuo1suAfHNneWizOtfVD/UDwynci65bxFJIC53UZgBjtoLHq++QBhjd63bNQipFkTHFPtsTYN7XCezvEJodh0oVhe1se+D/93G67LlWb2dYkNANy9MW4HfZr3m1gAg5SPZlJZlegyCEe09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5T1n/TKCOb7f7MrPGRkv6VUPD+Jl9L67VvtsemRaTQ=;
 b=Svxezu268i6kZTubSfcPtrAJ3rIZUjEoDbGE/foQkmS50emH4j5apQqUjfjPgoLHB2JrR+U88OoeOrrddvO8MxQxJgpue8xD4XdsH89UrdZArEYHmfxDCVuEbH0D0RY/5+Vx5GY+GpCTXELu0SY0yKlxDVqRaIVNsH66fn+ykVvU7GRp7OJAuqq9Ae4TWuIS9kNeMBd+27Wa+8ZMacp81F17naGTWwWm8uiv8DFHi3r85rxU/2rBOi5Xdoh8GovZmadvygm3YlIKH7OGyJfKodvMzZbtbKB6MI+gtV/OX0hmJMP2VH8XBrkimDRJrv03M7OK5EoYdxLfHddp5M1SYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5T1n/TKCOb7f7MrPGRkv6VUPD+Jl9L67VvtsemRaTQ=;
 b=h4mT+eCIdAw2BsKRIMm3loAxZknVn85SnBXr6+XVK7V0DLHnbYpvIKpDUwh17m3kt15cLsxGeiHLFE+ZzRmdyRePpXbbbzWFml7AP5wDY2c4tmkmgG37tksu2R45eUO13z9KsF4tcPM38Njw7jURTdPRoNL1nPU97ZHN5eOSkJJFyYkfUhBCGhLhZSX7RLbtJI4eEh4Ykk+X01/g3X6ElI4JztMbSUEtjwtwSxA48Q5itW65W+ij2In36SZbxQIAsHh1gZCVyeCCdEhZ7envy3eCl/38sG5vw+TlJa8XKhaSECxQMH1bViVwNPizvC8klVeVJtWxzVgslL+AeH1R4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.29; Fri, 3 May 2024 14:53:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 14:53:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, djwong@kernel.org,
 brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com,
 hare@suse.de, ritesh.list@gmail.com, john.g.garry@oracle.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com,
 kernel@pankajraghav.com
Subject: Re: [PATCH v5 05/11] mm: split a folio in minimum folio order chunks
Date: Fri, 03 May 2024 10:53:26 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <0AA55BD5-3068-4808-92CA-14AD6DA6E607@nvidia.com>
In-Reply-To: <20240503095353.3798063-6-mcgrof@kernel.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-6-mcgrof@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_B3D6D59D-F262-463D-B256-EA25C0831E9A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6114:EE_
X-MS-Office365-Filtering-Correlation-Id: 92072c42-eacf-4b48-1ed1-08dc6b80cb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9B/Zxp49B2MXgwXMKGLrTBy1D5b8d5X58hgCA1VWK+ntf84M8n8ilfb8Bq0?=
 =?us-ascii?Q?nTuMEb/lxj1Xx/My88HiiBt2GcfM7xJ0YDk2d1DYaR1mku5K/SBX48VoIp7I?=
 =?us-ascii?Q?ROhTPbfEh1gadfB4E+eht1lPeONCDbu5rcM4eFc2SDWaKOC+a0TJPoyOM+Oq?=
 =?us-ascii?Q?uPGnjOFMzDJp15KvdX8WUILiUpHUy8fGmMawXcxt8UPD/jnec/FsHGGmUiBS?=
 =?us-ascii?Q?DxUmeLGwYYxbMZqtnW/fhPNf3HuOOffxU8eR1Y3ejrRYJIKCKjeKOzyiGDXO?=
 =?us-ascii?Q?TAsEBOv4S4FggUrhqdAimzYAsEGMT1gR+cGdvd1xo30HaOyQSFJwOYb4c5PH?=
 =?us-ascii?Q?TAMWW37h/nmoqZax0akS3jCJC4k7d3S7eYxhA7tgEZxBX2bkFwNoya9gGIBi?=
 =?us-ascii?Q?e/uVno/oQxKUYzHL9SmGtpXzc3KfK3T1WQGmpZT1VDd5Q9Ejvx/nwAHzpjnR?=
 =?us-ascii?Q?gp9znwcxd7dhaZ4yFAJlMAT9ebMUn/1a26qlqTOLq1kJ7nINqsECSLx52Wi4?=
 =?us-ascii?Q?dEB/OJL2IZoIOe05ngw+DfUotXyLUIeOncs/2UceXWiocjeAZ1W850W+h8E7?=
 =?us-ascii?Q?pJzLOWuzd+6gNvL/5Qv5O8/VhWWXp+pTAuKNoBaDU9xDqw2Rul+qCrtnNCi9?=
 =?us-ascii?Q?96In17OPe0Bebc1tiYWwygEaaFb1uOkq6WD4oXQOmfJWP/Fb0cYwJ+veYFij?=
 =?us-ascii?Q?b6srMnTbqpcLXGgj2hROkoTxsM6wzRpYW2VAuOzRPog1kPy3Mbd7UROJwPTe?=
 =?us-ascii?Q?zdOuy+bmbLDckdlirPVE8aKQTXmLuj3hbyqoyhIDWrQpG7v2wTOW/gD+g6jB?=
 =?us-ascii?Q?V/GdoMLq23bzVxSM0kLo4KUtCJ+DjzjozzDM46rppG/K2rp+qCrTF5mE6HT6?=
 =?us-ascii?Q?meZWaK+HHngGxGywpAqymzUpeIa7RpqaLe8BDmK14DA6GSXdV5qQdh5OYRaW?=
 =?us-ascii?Q?Vae4GdaZIkl0Ko1i2LJn6JWBOq/DytyTYplOBY4phQKNyEeyfP5aPdeAojN5?=
 =?us-ascii?Q?v1jRIs1wsnLJHZHJlDz4FkjfyAp8zwMlZEnNxBse+bQgaowoEdx2ILNVs7Rg?=
 =?us-ascii?Q?fqIAdIe3Hv4N2CL2tafS2Kjb4UiPqCxTMH019QX4d91VvCBT6txNU/zEa2tW?=
 =?us-ascii?Q?Kb0S1HrAh4SSdBk2PSGpH/yDFH81nG+t1lZFDRl+FbxLt8iCeUnoUkehCQE1?=
 =?us-ascii?Q?OAgHGbNqxogjS6NWxjvw2XOP7wkGWH84CcwlWw+3cwid+o758EMwnSX4F2JB?=
 =?us-ascii?Q?XUyosBaj0Dh1qevBK1buK3+f1clop6TJZR0MPPNjMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?38g+hH8+7DaKwV4gOMwJKtYFcrD129gN3qZmNS2fqSkdsGb9QzZPIw90ifcS?=
 =?us-ascii?Q?KqFPvLFaizvkmaVdIW5BnY8l1Bn98ZocC02LI6hRH8nqI3RxQlksUOWpOtVK?=
 =?us-ascii?Q?QfdHhYYg1jlFkOPLthM3xqgQoqr9xMP3Nq0K8Ix8Z9qLcPLHOp1XLmBFs0fj?=
 =?us-ascii?Q?WDb8SONNWVfyL6Ak8hDCvq9uRfBx1e4zrSYQ4FwYpkUoKjsERin11ABVHMu5?=
 =?us-ascii?Q?1Ca88NJv2TGSTraJbByrQTsU73ZZd+cYZXGvM8ffiaK5oiNyLpHk8OEsFKTC?=
 =?us-ascii?Q?PKCJ1U6vrK0Hh7JZh42FZwzTP8h14pOAtmIY0XAvYoJHW1Tto7K8WIYZpWaP?=
 =?us-ascii?Q?WRgVW5xrconQA/fc71wAfvJ5Vel0e59i7vSm27fa5NkJ1JWMKi5WhlIj8+Jq?=
 =?us-ascii?Q?ijg/4vWM16ePth4m2rZmLrjcahW9bDSFwKDFgwc01GdRDa0ccebTPhuJPaNn?=
 =?us-ascii?Q?X1sx88PZNe8fzzTAgaUghL6w3cCwNBtFhSJHS3whRfcy9LIGWO4slC/XGce6?=
 =?us-ascii?Q?xf3GeWwTkxIXQ3JvxSmvJCUqJkRyQcL2QsEF6kVA9Ma26VrRy3fQljys0NGF?=
 =?us-ascii?Q?2dhiIsMtZOWJFbcy2xkSbkyzK9e3x/rPJwGC2UF95r5AdaQhsoWIoryyij0m?=
 =?us-ascii?Q?8sROpwG6i0yrTVCIFxfiMZMVtnYdxVrnXIs4e0g+Tg5eFlAeL2A4vOITe1oj?=
 =?us-ascii?Q?jagwUAWD57xyZMO+Sun0ZMwqi5M2UiSOSWiiSyJ7EpgyTyFxPLV7OdzqbaFn?=
 =?us-ascii?Q?9UzEfDt9XiqYgduymdWcP14dcqUHznWg9zhMAKlo53U3ssIu/LSr7+Ddnt1W?=
 =?us-ascii?Q?Zp1Ej327OpddjWfGBJb28A8q/+T/OUCx3OujqtQ+f27JqCwmBzrLDZbzvvpG?=
 =?us-ascii?Q?rBLBDHnUU6iJNr+uHcUdSxzJ8JZs3QCitFfMbJjWZVyqtK9EIROy5OnYcx78?=
 =?us-ascii?Q?74KJMiVGRr00me/2KLSGHBMp8x1pbvSbOio3IfKbfGL9+DqknvOsgXYB5hLR?=
 =?us-ascii?Q?7puCzLRsQ/Y3Tkz0qohuVG0kdQ0M0PBaz36BdsZfytLioWWca5rMC1wtBBZy?=
 =?us-ascii?Q?7Xb+HLZRCxVr/ISeKYLai401kI7TpKC5eDvSHyIuLBpo6HabImzd/Mk+Vxcw?=
 =?us-ascii?Q?fZFDE7/ZFEkt4b8oMENLxf9RNo2Up7xz4M8wLBzePBMpNIiLk5kX43BTxPaD?=
 =?us-ascii?Q?Nk9/gG63hWgFvkR2Curo13uYpOzDF84oKHusX+e2aZCVlGw+fqbk/jZIjazc?=
 =?us-ascii?Q?KeQZYnOOlXldNHAP+A+C3V3nWu2qAqoFBvIZ3c002pSInH5GIPapRVleHkLG?=
 =?us-ascii?Q?4GX2VpaR7M7gOuz0d3kEB53Maz5d6SxjBI+Id429AzmxjMaTT/0DBm+w/mWu?=
 =?us-ascii?Q?rW7j+Kf1lqRtce3IHh29AZ9kI3vezPp6LPxwGJnqBL8nBtcZfUrvn3nCmHXy?=
 =?us-ascii?Q?s6HI5u6+sy7/nYELOoATz4GenfLMzCwfbvMUsdfoW8qQBA+SM3lADa3JTMWf?=
 =?us-ascii?Q?Grl1+owp+Q4byWqjNJBZuEEKiY2kQhhIT9879QfLUK/8Pv6LwE8pfEgI4cD0?=
 =?us-ascii?Q?lNnB3oHiEkeoTUQSoC8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92072c42-eacf-4b48-1ed1-08dc6b80cb20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 14:53:28.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0IbefQllICm+k0odSXa92ffMwjUsZjaNnJgrQh0mnf/kHQdSwiX4xfQkFq3ut/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6114

--=_MailMate_B3D6D59D-F262-463D-B256-EA25C0831E9A_=
Content-Type: text/plain

On 3 May 2024, at 5:53, Luis Chamberlain wrote:

> split_folio() and split_folio_to_list() assume order 0, to support
> minorder we must expand these to check the folio mapping order and use
> that.
>
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
>
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/huge_mm.h | 12 ++++++----
>  mm/huge_memory.c        | 50 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 55 insertions(+), 7 deletions(-)
>
It makes sense to me. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_B3D6D59D-F262-463D-B256-EA25C0831E9A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY0+mYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUVUcQAJUodcLqGSLkGzRmk5IShYXLTQoF634CbZaG
VwCopQ3uGq53e2Y9WyCsxrV8M6FbNccVMgrNAcDxd3uWgntTXQb4qczeKP2bSSIm
Ti1gFlz9Rlr2ZRoJFRqAKWWWssRn3sQqRcSfDo8CJvuEdpTpbIRVsGfwE1HoYYp6
HjFM0nBpAqv4Jt7yZ5lpgsvilit7EED08b0RtBRO8Qqk9hmBXjBpkHsS2EAYbvEI
1c+1f/MiE4Kh1jCdW9KTjnuXX2Q/LBUtpjf8A16EC0q5yc0swj8CoAPxfrtRlswu
wAz7/VamIy8o4habYjYPR5ZFTYiYcdeFTlhsn4waHyXaAazICXRbkkP5UukXkzp8
jhFiFujfn/7+6ZVDxZkDREzKNvWcS3nOBIu1mjOobontYGDyylFZoNGzc4V5XG8K
9/wpmBrrtFdNnumCMQdNp7WJff9oYdo+rjXaHtES8G12g2zlWLt6IDz88ffZTLqQ
WqweHUXElBV8KQJeBRjsuYVeAHzi82NLyjM9RJTchrOgHhkctPeFFWzQDxOh7qfO
76QytOqcTNBnU/uf4nqFO7colq6666tEigymo3JyuHflai0wMbgT5zLPIpubNuLm
4N5Hc8vV2KLHZm9JN7eZTUtF0r9KUVkaoTUYUTQ2aWVBfum35bZcFu7cpLoDrGLx
rHzLLudp
=TLcB
-----END PGP SIGNATURE-----

--=_MailMate_B3D6D59D-F262-463D-B256-EA25C0831E9A_=--


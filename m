Return-Path: <linux-fsdevel+bounces-11369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8C853235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 14:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EEE1C2253A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B756746;
	Tue, 13 Feb 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rAcjbMfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57956469;
	Tue, 13 Feb 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831978; cv=fail; b=XlP3v4H7Ii3CeZBjp9r4vyXo82h3g6MJhhFbjyI6JaFSDw1HzwCj44p3Cz/p8Zerb5AUePZPPAY8BL+0YFqYFoGfXI3zqhA7DAmEUPwQbHcblkghUUoN3b2buO6hoFdlIKPN2GrH0yNuWOzZPrmgBbNOi6g/PaYPBMvuMd+apNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831978; c=relaxed/simple;
	bh=nT431LbEK8zbZ38O9mbJB9/2k/oa1UZL83rI+zHFXt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTnB/05/iUeEN4lbpttfWy6pt/yY97dArQv3/GUCIspNwE4w13TWzVR2hHMQAH3SGrW14XqLlQFBuMT0vqKQT2G+PsZG8pj8x5a1m7b7dtxWKqeQ7NdDY4b0fCNggFMZXUUDDxDUdSOPYiPSMyN62mcquT0hnn9NJsiR5RVNFaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rAcjbMfX; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azk4OuIjDfUbaoVVXq1eF6Wonx2MOUn8pWj7D9/qzcyjQVODOeSIKx54odEyBMhkQpDmmAS4RRAY5d2XIXFw0DEDS4UaDTNViF7iikZCFWZaeNUItqcGTaweKJH3Zi3q3HHEKWDI5A733IXoNkgnzRc33Kq7B5chPRJ/+eFPMhZf2tLiiWeHXSba0eOpaZBsgwFJFfLHVAWIkgSxj3Yt3NQkMkTOYdc+HVv7MeW0thUxBBEPaofxLN+GX1fEvcph0MkxtLx3Q4NJK5wV9+tTznx8g6CngB2apVIWvPnuKIu411nvxZ3fyPPv2xvab5zU0/RWUtjZiPYvz/+hgw1cYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT431LbEK8zbZ38O9mbJB9/2k/oa1UZL83rI+zHFXt0=;
 b=FyoMhk4W9B48red0pEQUysnXpehLjBI+Of0WfVHJKEWwESBovYrAai0gV3rLitRAPxAl7Ez6DlyZ8YIaaNDBR5BdkGyFZsa2RJvATZs/F3/+TokXrtmPe/TXogNMHFGPJs4ZlE1yFoEdVoGtzg5P2fDBu3YR311ORiiLmM6np9DbsmCaOxmtFKnxHIYz6c5jvaJ/cerveN+dChX9I+Hvd2QXVGSq39UbsQDpyhspXUalRs8shI+gtBywtedhzBUv3zrXST5wbwFzNm97LNCrF7bV50vEN15/mnlM3pswhwryGuEkB/vazzG4dufwFMG/V+3ycnTBdc9L1zsLhal4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT431LbEK8zbZ38O9mbJB9/2k/oa1UZL83rI+zHFXt0=;
 b=rAcjbMfX+M/7k6kVKvMtF5GNtjzhtplj3qEeFLTu+WxRYrZto5PTU/5BGZZ76Fs0JI8xNpEHO7cFOVcEwazzodjGpOL8E4llGakWI31UQOb4MY+zaSo/4Uu8r8VND0g33AA+Xt5+3cOMOA1o1Pt/GEGlU38AfH8tFPF4lSpuLb0bdtU5PftxcyPUmsxrgDjYKB3DoWmhK2sl2i1Ljlqx8+KAT9wH/9fUq1B9z4puda7Gx8v4x2NgeXghZMOejKKgbHd8dLZlUclda3OkfVU/QWKDLl+QPDeBni6Er9/y32jduR9e9cV6fmoqETozJtTrPMBqqTFi75cy7ZyUQ5qWRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 13:46:13 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Tue, 13 Feb 2024
 13:46:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>
Cc: "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 linux-mm@kvack.org,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
Date: Tue, 13 Feb 2024 08:46:10 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <FF718BD8-8A54-47AC-B75F-928ECA42BB79@nvidia.com>
In-Reply-To: <qzbcjn4gcyxla4gwuj6smlnwknz2wvo5wrjctin6eengjfqjei@lzkxv3iy6bol>
References: <20230403201839.4097845-1-zi.yan@sent.com>
 <qzbcjn4gcyxla4gwuj6smlnwknz2wvo5wrjctin6eengjfqjei@lzkxv3iy6bol>
Content-Type: multipart/signed;
 boundary="=_MailMate_89108B55-2245-48B9-B728-510EAA2F55C2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:c0::37) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 16168466-87e2-42c8-a545-08dc2c9a24b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oRDd87sHXNeqqis6jQWEQv3gt24/sids8ORraM/UoenV3B+DIzuBBRPv3mrJg8PyGuhzRSD3LhXADkw+9pStXpXQe6+2nROzVdVIgukYa6SfnfECTIIO505smHW+//VWBIpP5GBVVycTD+ZID5nKSrnpBQA/QPPMeuoYVInsXuRyrCgVEux3T2luZ+MQtV5EzR7pC/x19Xaw5HklmlT1LgwVkHwOoNcHn9Gs1FDFEDm1tX2CbRe7GBdUq4PN8nkL0PCuJjDavUP/LOFEdjoExQXtVkGDYp/wJg+7WZdPO51vCwCSgJz79dgDDzgKZGiwxPasR21XPdJQzAae8dZurTG3iTUl25GqNvT5G5iOEG05OfyMrLzH5IegSidySmeIlB/4hL1ahffNaWIQuit+0xD9rrOzwPZXWqCMv6vM6XcQOxCWavXCMXIk5Pms042Tr4ZGtJ/cFdtPGJK57k1ZRyecz/1UOV3oV2lugueXE81FN+pauy4s78eUbcF8BpevevOml3//52jYLvvnO5f6efh9zAUt5ypd/rqpOwfgHdmb+DRLyagwfVsYQAd2degdmhs5ldiHf87yX3HAS3d71B6vYjgYqOYL7bRhZSPn/cNKbm3LouuJv7wGQs6lFnaVhoxFonbEAp4ulIw/6q+BEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(235185007)(7416002)(5660300002)(54906003)(41300700001)(2906002)(83380400001)(2616005)(26005)(33656002)(38100700002)(36756003)(86362001)(6916009)(8676002)(66946007)(66556008)(66476007)(8936002)(4326008)(478600001)(6512007)(6506007)(966005)(53546011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKIml+J05up7vL3wgQdBErv37dLPcnehCgItS9cBq95HVXAhZmzdPqg7g99n?=
 =?us-ascii?Q?Gq44S53bNiGx1SWPbxsGqda2R6LN/hSctobTkrMAqThaOPnbs85rpo5lEq9B?=
 =?us-ascii?Q?fnqgTBJLJNyF10K7mvYwLgJcXanNS4wJ4H2e+n1pvMy3z61GYz2zUkO1urli?=
 =?us-ascii?Q?6JVX5Hix3Ka2A67ixL8q12SCJC2tTE+3R0WhB+Xm874u/x1QJTVKTKTH6m82?=
 =?us-ascii?Q?e5d/G01xj6wdbxoSnNtm0M26cHoK7HC8fYQ6GWcY+KQgPOGbxWJ3iEh6Wm4O?=
 =?us-ascii?Q?wLjoeL2pYywwa4SWnI/PQfQCKGZ0wy0GldiM996jPBsxRmBwpLB5CKlzrFW6?=
 =?us-ascii?Q?FvDo8QhoiDW6z4GkfbjJQDfjJJvWunK0S5etMxWPL7WzY73IE7PTCO5i47ru?=
 =?us-ascii?Q?CQN0hDD52ibcRlT6zBG0uVwF6Tmqjx6x+Cl8agvmDumQSe2hrrdZUEAkliR9?=
 =?us-ascii?Q?EMaOcxVI9npl/XCVGpfRecpuYtn5HN6fhH2utedAfN07K/roifIZIxfVg9Dx?=
 =?us-ascii?Q?NLFT0E8HB73uxHhyoIWymkxjOwQYmZyTH2BQ4kNgtZCVGdKQC4Ue/t53begu?=
 =?us-ascii?Q?fiYTMIjg/cZP6dLNg1JFCRwukGihXutfnCPqM3/+B71L3hHkYPQIOgvBPwKy?=
 =?us-ascii?Q?OUIsy4nXJj7A3eV/ZuoamgtdEHbYjszSaxlmFONEkRwb7/e0pJRzTwbx2nxm?=
 =?us-ascii?Q?fUEgWIy7y/Gvv/L+BJmcURKDJ/KWhekruyWatHolhHfMExppghad608z8uAu?=
 =?us-ascii?Q?yWyruRVsB/a4GGKcEllEo2LSc72T67rQ4MSXvhepXG2+XMFDBFHRo5AVBJBQ?=
 =?us-ascii?Q?cFKSZseNBL2SYjfhNcjlzLR/z1OcPkOIb42bQGI+iKiVpgfIDw3TpHp8lDXP?=
 =?us-ascii?Q?pqy7AMGCTYSyHpTZjkZRP8rwfkpOir+KwC4Sab+Eq1B7H0x70txihZ4e0xPB?=
 =?us-ascii?Q?q7X1WEEjwq34TiU4C25coCHFqZllz+2HzzYOw9QL3XzSLV9VZ+Wu2YxAXjN5?=
 =?us-ascii?Q?pOT2ivTOfg6/OxDBBznPXM1w81LjiehcsmSOWxYIew7Lj1C1qGfup+AJ/K0/?=
 =?us-ascii?Q?6TmH3qQac9OMm+Yz6WaRdMf5PH/S42ts/x7Q6Ehv4sBZawqWQyLR14SfPsNy?=
 =?us-ascii?Q?JwiHQC4prWw5mrIYg01t3HPT6Mv57Xqxaajn7T8P0DbI/LUIX1eSWbEQp3xM?=
 =?us-ascii?Q?RLSYytV2+MyThbOqJBA+QuI0qXSSRjdFdJRxMWk8WBx8pIuM5ZVkIp6BCVri?=
 =?us-ascii?Q?RF9eiUB3+FwOUoVcQ9HKc0hQdmUOjnAL6MopdV4vQUycku5XoCdLGtmguGXg?=
 =?us-ascii?Q?xnJZvlJiJB+ibt+1L1mtxNpmgUfyoJtG3sTeanD9f85nlQ9jFB8N53M8Mz0+?=
 =?us-ascii?Q?6XeO1FK5QJ1H1072e8cVVvBQyDlkNs8G7Bq8OgddPZ1x5D6k+1a9SM3kuBuN?=
 =?us-ascii?Q?RlmcNDoGHr3EABuOV+q3uIscSSrFYmDVVKejckWoJg4aTiIKGWeHwFzX6TCP?=
 =?us-ascii?Q?m2QnFXTlnFbSuxo3JlgZNGujzSFa3xlMPlyBZE9MJKM9W7/w/HdxGpnfqfTP?=
 =?us-ascii?Q?LHGrc6fAs14KXaUZl1o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16168466-87e2-42c8-a545-08dc2c9a24b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:46:13.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Pi2REATHYs9SPLUcoAnSnq+jPLfIdnChbNCDGh0GveJLZM+zNEV9GD7H+HQVaSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

--=_MailMate_89108B55-2245-48B9-B728-510EAA2F55C2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Feb 2024, at 7:30, Pankaj Raghav (Samsung) wrote:

> Hi Zi yan,
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> File folio supports any order and people would like to support flexibl=
e orders
>> for anonymous folio[1] too. Currently, split_huge_page() only splits a=
 huge
>> page to order-0 pages, but splitting to orders higher than 0 is also u=
seful.
>> This patchset adds support for splitting a huge page to any lower orde=
r pages
>> and uses it during file folio truncate operations.
>>
>
> I recently posted patches to enable block size > page size(Large Block
> Sizes) in XFS[1].
> The main idea of LBS is to have a notion of minimum order in the
> page cache that corresponds to the filesystem block size.
>
> Ability to split a folio based on a given order is something that would=

> definitely optimize the LBS implementation.
>
> The current implementation refuses to split a large folio if it has a
> minimum order set in the page cache [2]. What we would like to have ins=
tead
> is to split it based on the minimum order. The main use is of course be=
ing
> able to free some folios during partial truncate operation.
>
> Your patch was also suggested by willy during our LPC talk[3].
>
> I tried rebasing your patch and there were a lot of non-trivial conflic=
ts.
> Is there any plans on sending a new version?

Sure. I am going to rebase and send a new version out.

>
>
> [1] https://lore.kernel.org/linux-xfs/20240213093713.1753368-1-kernel@p=
ankajraghav.com/
> [2] https://lore.kernel.org/linux-xfs/20240213093713.1753368-9-kernel@p=
ankajraghav.com/
> [3] https://youtu.be/ar72r5Xf7x4?si=3DXDb-g7SSIgS-5TkP&t=3D1457
>
> --
> Pankaj

--
Best Regards,
Yan, Zi

--=_MailMate_89108B55-2245-48B9-B728-510EAA2F55C2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXLcqIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUxQkP/iJGDKyojTKfMi3YGIsmS/WroIS+LScZCK4C
ojRZPMY9Bsih90BB/vT+FZIXLPySfUtS7SpOVWuBJLijn8otxn/hUnYoRwXv97mI
OobjgCy2ec//LQtPzKuHCEkUNYnKd5V1d0QMghUZRK/fwLoU9ngGY7JsunqDT2Oh
lN1aSntTpv44IRNV8oXYVb7UiKZQWbZ12/r3YzSaaXwnbcfjXM07izBI/P32pxzD
x2tbrqmobd6XnwPRFWc1PpvswATQ4YcdDUK9oCuRH0XI5cqVnTXKaaef/zYcvfB5
r6+0tl+p/iTkkOnDQbp57B2jGfNiVhkDIeBBTBD9ibbchiO3lPLPBolTJ+BV6qOC
YbOhNY3L/hUQJZBg+nDUxe4bGQSeZGgJluDQJ/QdKAs2f6Uj22XFgl8DL+AtoMqa
SoldCmKUlSB22qr3BDvRxLV1fAQzSJrCsPMHBi5VXnEtZoALG910HFY6yPxSTgSo
uE81HPCu3sQXzy4ysmhSzqxLzduZ4/4VMV9jcY6WB+ShQihffbkJN9moQ1Nu5GMa
ty1YEjXzxKYo8v6XmjApYpBQ7PSM5bWLcbP2BWc3bO2qgAM6/Hn4plkN2CcNlgdt
f4Jhb20mnsRgKm05HOfddgAazPQiK3+pQ6bLGFHYlJd87n0e+uvlwualZK8zB/JC
ARFUM5rG
=PVPS
-----END PGP SIGNATURE-----

--=_MailMate_89108B55-2245-48B9-B728-510EAA2F55C2_=--


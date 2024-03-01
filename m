Return-Path: <linux-fsdevel+bounces-13331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D386E9E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 20:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AF81F2104E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 19:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6D73C068;
	Fri,  1 Mar 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZGZJYyBn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61B3BB3C;
	Fri,  1 Mar 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322102; cv=fail; b=PVpxxOZPztmVoKNxpf9XNwFdjSeHRiIRSqG7sMButMdt3g/jd2Al31DohNl5NCdxgtKg2tBdgAdGFe2ZIeyTFnUOrmAGlKcaboD61vSyNZ6m/Wd5+DFrLemqQRkxNnopJtjq6SVzzAloZhZNsmAT/Ca7F8jq5L4smeniLqUbBLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322102; c=relaxed/simple;
	bh=hddKnFza/t6gW7DMJQTqFvsSr3A1kpdl7SW1uyByM3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCCAxHSvNjj7VVM2IlSRCPNHA6aG5+hTCEpcf9glcGUXtZR/0Bjty+2BNt4bLWYU16k/nvOl+0VjOXO8/1c5Rg9W7jeukXX5hIT7CgahpNW+Krisp4PO0FfyG/h86wdKiOUOccHOnlBFcj2VBuVBvaSHAof5sfxzLHfzcnxL80Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZGZJYyBn; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkUFbAPDv3lBeX5TebZtHKXNct/aR2SueW2xacE7r4hsRnZWZO/kZmBWJ/4wq7ms89KlR3Uv5550YjFi0qEg5ald0cNDMvSILMvX8jUhu09HLuumxQLDOYiERv2QBC684DkgEUNZsO5EdbFIgEUSJxKYbKzbIh7NmUekWIYqgm1GUbuz2qo+nPDg1Kwinglzj9UNpfMMSzH9RyJDzfGb8a/kisvi0JHEwpMlHOkmy6a/wpb1VzqAyLzGJvKgn1p1xDs8ULuZ//S9HeiS9iWocoZ0ZrKAAuNFWJDGbNNJerhU5xMYjOZQ5OmAXzPykTf2KJz/qdf6lcqV5p8YkEdkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+drcDZYuJqWc+hdFCVSnmOf1/svvJj35tGBhQ9wmVZk=;
 b=VuQweWct5y+Uu6/Smr74h/M0qWrRw8sofZLQk2NNKg6gIXkvcKw0wwP7ibGKnttj5LFBCVf3Ykpj0+l0x8Zm0rwjZw5pVlevZKjPJdxp0VhH0BYdtPXri/l7Tf4D2uT3cg96F/dNFuGd00SXSYBLyyU8f3pTAcdBO9e2+7+tYvBdg0I92zYgdYBe35KBdmyKRgoFbP4TNFQuW/93jjvW7pvnXwCnDQQeIrJ+VHu/2ELswnvWAHXZbGtQVbvX3r7y7GLPXNs37wXjyvviI60IskFjlIoYviTEzuOzitmaobVa5TGCG8IlaGbbStog/B5bN0ZFqrkB3Lpk4bZqmwPpng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+drcDZYuJqWc+hdFCVSnmOf1/svvJj35tGBhQ9wmVZk=;
 b=ZGZJYyBnJQmCadPoSfWy6t+J7/QWyab+7H1dM3ZwCTYqa+qzHbKV4xCNLKOAg89qxsZXa4a0N1Tjqyt5riarR5MPar6dYp8sYqwExjvAMgAwX3XSwrj3Ij+Hiuk5JOPO8uTPtaV9/LfyjveQirmA1/+1j0RViIkJAO9fohRb3Zy2cdQQfnyHhtMEuaqrhalFfCd+AfbfL9l4mCQReteSV7iNHZj2vz0CofVJeRQiCLAhEfu3WpHLn7iVUR8w8KPMNkuxqAkfmM0fVxPJAsj1/QDTZ8cLOUpisdhMTXkLUpkmyzziQruA2a4O3nOeqpvAu9QpJSFFpileGojd2zfydg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 19:41:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 19:41:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mark Brown <broonie@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>,
 "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 =?utf-8?q?=22Michal_Koutn=C3=BD=22?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "\"Zach O'Keefe\"" <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Date: Fri, 01 Mar 2024 14:41:33 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <F3804804-160E-4333-A856-FEEF486BECDC@nvidia.com>
In-Reply-To: <dda99ee0-87a2-482d-bf28-bd5e5a97b46e@sirena.org.uk>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
 <08703C70-DD6E-446A-9ABC-BC2C8E33B8CD@nvidia.com>
 <f7a3d07d-290b-46d6-884e-fa288901c3c6@arm.com>
 <3D5A5D18-0A20-4BB3-B667-0CB5799BA665@nvidia.com>
 <6003865f-2c85-4dd4-9803-6204f9018f50@arm.com>
 <dda99ee0-87a2-482d-bf28-bd5e5a97b46e@sirena.org.uk>
Content-Type: multipart/signed;
 boundary="=_MailMate_8DC0A61B-BE87-4E39-B867-2FEC0960BDE0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: c74d5d2b-5304-4d66-d8b3-08dc3a279b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ijUdwo4EXiyMR2xZ2999ntg00xOMjwyp6ME22sYW9zDTlbxx+au5lFPRVng6feWi/V/MODmumcPD6m36mc4/GwzQ+lbSX0E8QyyMHGgQ1XQO7sXRcBKkhcPgwPr14DQS+D8xLZzpuyofxBKrg5GtRtTglCi9milXoWnbokaW4al+GEMXSr9ZbAZ9JHcqvyh7OxL2uReqqL/RG2vpRXg0Se6vgZtSi42NTiWjFbdP1etBgAQv8gFSc8QYAF7lZ3RA7PyjjrP7kCGp7aE189AjGX5e95iJGSw2Qrj/UF06H9YLNUz4/+vaSZC4goy/Oyce665CntbZ/CSdJqkG0kdbgYeZWaM1W6093Ok7Vm+SBU4JK/CbmdLRYw3MlxodeOlvHeLqwmP+yShv5Iucv8Aj1dDP9a95fEcn1Su5wDf+M2DBVH+NWZTUwj74EhkMEw2k/BQameGhPpEK9AiBKykpGpI7CwXZnCH3gw+sEOlyUPusxMRermKyO2/EnRhnnIGJVMQ2WkoJo/KxUQ3GZHKUukEMf6p5j8OVTeAW47yrW0+42QTbpvaqvWGqoCO1l/ZugSUPHyshh1X3EAMQUU8MFxBSvgYX2oL8KDbo8hr1v0F0Qwq1RwQZ4FAcm8K8B7jMIuW4Lp4xE1bwZdgqRJ1VVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dd5pw+s82kdS1pJiJ/SDJLVVUFDhmb7igfie6iQGIDxRIWajqmRDmGH0x8eZ?=
 =?us-ascii?Q?X3/bheIPSDio0eitU/06Aa27WzgmSI+VP2bOLTOvt56gi1CM/PAqEvaKWVDe?=
 =?us-ascii?Q?NRtXl+jvwOZxt5RF2pDJFbW7bda2TU2reuQGbRa3U4o6oESfxuQ7G0glvwQ6?=
 =?us-ascii?Q?oHG3dyc06VpheDtTFaW92XS9qo8jHUSEo5XIvXlRcesM3/IIv1DkqreVk2RI?=
 =?us-ascii?Q?K8YJwCy9S28e3QC1vHtEWAjhoguEv7h9tNaXOwKSJx5ClYLAStjNaURh1+ti?=
 =?us-ascii?Q?wrndFwaOgjeKhlkCidxZgQLAOtI1sGA+oiwBt99T4AF9mIQoTaKqugQyDl/R?=
 =?us-ascii?Q?tsDSnZkfYregysyqW0lPIPWUXMEybaRLvA5k3IzmecmgDUY22uTCaG/V1dzF?=
 =?us-ascii?Q?6K2tT6xMF4BmV3yZEBSXho+xWFblviZdyFiJCeqLEmQBUXTB0l7X2P2TsYii?=
 =?us-ascii?Q?IBeX14WVWZcyUZo7HY6hhbbQ37ffHv45nO2CQvu7HM8ZA+kgNcASiHVBpwcd?=
 =?us-ascii?Q?jFKLfd5GpeMOydceu3qQYB7DACtw6qKSK0KwRXNszzZTjcUjrspfFCHNw/D0?=
 =?us-ascii?Q?D4sZOmQguzc21FK9qs8DhhLofAPu4FpDOgUF0m+BJEHpK/Z8akhFkZRJG7oJ?=
 =?us-ascii?Q?HKuZzY+D5dBRRZUxGVvamT59Nc1DqnInR65RljD/hb9wMMM0KQm9oM1lrmOi?=
 =?us-ascii?Q?4FgFreRhfBndDrbgLRPY59d7NPJzSqxNO8zzXim/vuUENK79Op6VWNvELucz?=
 =?us-ascii?Q?TsSX32/EWrv4ukzqXuX26dRviauVW0TbBRkj96jbR5vpb9JC7Yn6GxywzRi9?=
 =?us-ascii?Q?6G6e253ZC6+BR+gCMVv3eqyEJtqH6mmdLx4YKD+2HejHYTTySz4ZJfmai/bz?=
 =?us-ascii?Q?MVjfqN35OmLIr1cj6fc/ttdD9B4U60l+8jiwHMMzYQ2fh1XxcLoCgT3E1Bhy?=
 =?us-ascii?Q?b5hgCpP4c0UKr6PTBjGnq72wXDP5in+3ur5KLuOza1U2AvexOorQsm48h5A/?=
 =?us-ascii?Q?+O87jngyMbgAybom+E6Y/C3fp+QJ0Q3zmudyLCNuWKh9AZTl5GL5qlvdjrhb?=
 =?us-ascii?Q?9nz9ODOVZWCAy5JKER3R0zJbFJ7H+F0u2YzyAk1JsJzcnJMjUmQAM60auodw?=
 =?us-ascii?Q?2cYTSURMSCb7y/GD0jr6Hianj2QeOREWUP7fvRYcjH6ILqUW2Yvq0lIIAsLi?=
 =?us-ascii?Q?MkpiRrtcAaZNkIY+nVBzThBPV43Co53mkuslnVz5Bd5lr1lX/MTrkT1LuROL?=
 =?us-ascii?Q?D5+je/jpNWTOsboCS9OgclX6rJkIAiEHBlofJslwKJdYbNGdQIbeOE6oV3+6?=
 =?us-ascii?Q?+m28w6fdZHf2yraJ5o9aqmuDt/T3aYLMkXLIXCjMd2WKA0KFMYQPTiskHKWs?=
 =?us-ascii?Q?2+VQ8Sawyl+sMI/fchPlqVWu3/MJ+/tbDX+zpd+3Bov/wWGvYTysqU7WSYMj?=
 =?us-ascii?Q?F9666aA2Ozlx/Scf6dx1Zb8BytJuQhe83kPoRu0OkZxuc8HsTCwQzpwE7qj2?=
 =?us-ascii?Q?doA4nGvHWl9kuoNi6niggXz4mnyW0CGiCl81W6z/TJZdoerXCTvtedFT3AdO?=
 =?us-ascii?Q?tA2YBJXIlC5Uu00Bx/NEkryZFMPXW1duC2t/ZUbb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74d5d2b-5304-4d66-d8b3-08dc3a279b59
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 19:41:36.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKOlzZokI8Qhddu2EBGrngXa7T5K7alfCRn+NPMjwA5O0oGA2aZA5g1sOKDGgVAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843

--=_MailMate_8DC0A61B-BE87-4E39-B867-2FEC0960BDE0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2024, at 9:27, Mark Brown wrote:

> On Fri, Mar 01, 2024 at 02:18:16PM +0000, Ryan Roberts wrote:
>
>> Although I agree it might be a tall order create and mount an XFS fs i=
n
>> run_vmtests.sh. Perhaps it might be good enough to add an optional par=
am to the
>> test to pass a path when running the test manually, and if that's not =
provided,
>> just try to create a temp file in the current dir and skip if its not =
the right
>> sort of fs?
>
> Yeah, if it needs to be a specific kind of on disk filesystem then that=

> needs a lot more integration with CI systems (a lot of them run entirel=
y
> from nfsroot by default!).  Being able to specify the location via an
> environment variable would also be good, it could fall back to the
> current directory if one isn't set up.
Hi Mark,

I have changed the test[1] to:
1. accept XFS dev as an input,
2. mount XFS on a temp folder,
3. skip the test instead of fail if no XFS is mounted.

Let me know if the change looks good. Thanks.

[1] https://lore.kernel.org/linux-mm/A111EB95-0AF5-4715-82A4-70B8AD900A93=
@nvidia.com/T/#u

--
Best Regards,
Yan, Zi

--=_MailMate_8DC0A61B-BE87-4E39-B867-2FEC0960BDE0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXiL20PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUu+IQAJxy3sXUUsiuly0NQICwy4zzCJRny3MlJ/ax
Wgzc5vBLrJ4qXzvuYKQnatMq8kWLN4u9FN7sOwBQq0yo7uWypT9F4iV6s1ijbn+z
CA4DVTGvWXpFSSDCG6AFMJYiKsCVIPXj7bfKv3Q8vxbrUIK+Jd5aYhAFocG44xu2
m91TnDKMMRiLgC7fFHWpVivbKCQo3zWWEcGKlU9CXQ9iB4sDf3VKVC+48QXjH2MX
JJhYlaxYjaxNELmnKekjAE5sZ46v1ZEEKH+Buk9xTNGyMVttITBl2BG949YSxk0V
tTmcQvXYB7Rm3+crW6X8tfwHi4BTZD14wqPdUqY7204ghh2wEkEfEpu2JwA0YXtv
io/2u2hCzLLEQnYAKh4Yw1Xc4orXFPWVEOwxuI6iMJzezqZn9vwgjyYvG0kMToGd
K0TYZzI+z7bJbIV8SBnjfRxmSlLsE/MXXEV/W78ac8DmfSSI6HsojHRJClBk4ojb
XPinXnXf9JL8K5ABbIjGMSQWZP6SsTLTQOH40GzKze+rKMwsDGcH7aFVQqmaLmac
2c7VhLlxsLqw7TAwaiXKMhYtnSEgbxYBTIhTVXWCxyuS7g/QsP5hKSPMtCPNboGn
AFWW3xfuxh+S+oUsvo7hJYbPHzWCuGRWTo45df+5nilzktL4mP8IVaJ8ABqrCQG1
rwwisIVf
=us7i
-----END PGP SIGNATURE-----

--=_MailMate_8DC0A61B-BE87-4E39-B867-2FEC0960BDE0_=--


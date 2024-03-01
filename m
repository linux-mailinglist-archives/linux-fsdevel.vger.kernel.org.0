Return-Path: <linux-fsdevel+bounces-13265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D286E165
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E974D283A71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D684205A;
	Fri,  1 Mar 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O84PCb5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0E40860;
	Fri,  1 Mar 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297809; cv=fail; b=a+vcYCVY0GeD6eaCfWhR226njQO4q9vzJuoBEmJ2NorzygTSdz46LjUf04MNvTSSvwtJO+wFPj++johgoU1Mz35wq+er52pLdNYsgvW1hkNIYbPRROGVW8CHDg92zWOEOKeeynlpDbr3f2Afkd4s7+fKA8jBQufiitukninnK7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297809; c=relaxed/simple;
	bh=F05yRIJ790OJIv8rNWEdkUnxOq1qB67uE09f7ZmQTDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iSSR8Mou87x82ytSgRKH5NYnFfs4cM8pndYi7DYpcTfpwb6T8pcahVZZ5jgmy0bukWEI1iW61ySpJ6aGonOw4radsYXlvug9s1AuZE9UpSloYQdknSMzDMu7N7UYic/80ZRTu6YUolaa2MDYlovbhlSAdgN/KunHxt+Zq50HQ2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O84PCb5s; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUYz9ygOzwarj6gzFVetZLmtFUZT0VYeiDkMK1f5ODS4jarIQ9NBB5o4sfKGER4Wg0jxvlMygcdHDhhq1tgxJen5woB0ksm3rFM8QAaEshRPlb8l23gaWT49sLrPTo1ZFnPB72rNoe61LYe+sUThwf9VV/o43eoJ+S2yMbs2eMiVt2XcB2ZDkOZvaBKsywEePZoXxj7VK73kcDlRakehavjPtssF5km+KLfuB7DSf0rBEtP8MbqgseDubT/FJ/E2+At9SCVHy2QmOup2udM9JA43qNdusaSZDfuxedp/9tRf4yNsOtm3zNkhMxYHztKKAJaiShRqLXwxtQr4IjeEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo9L0pZQzJNgGya3MrIfKqloZM/gXYVTlUIr7sHqNXU=;
 b=cR9cBRFLiAicvJ5Hxn8ZvBmtNEU3VwY925g2xf8uDzLG+XSoNU4cVQesEsggE3pEtFG9PwuMKcrtFPF2yB+49kkRPvcj+Ot+qoRQyHvaJNLQq45oYyfpI3dmh3LrJJcruwsczfPRoSDlFj5Tk3Mz1nLf6jnaNMO8YDPT7RF8TJ5GUff86d89m+5Ai2I/E3PGui/YCTY4fs77nZxQ/WIv2h/baKUu6hO4PL8uYuGLenojUSlE0WjVIbNlgJT8iodTlNek5qixH5qc4O0OU2SJOk9FXes5q1iq3HLGwPYZljNfQ8Qn5coqT4UvLBzv3HquCjzkiWRsMFJuMTbb/kf+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo9L0pZQzJNgGya3MrIfKqloZM/gXYVTlUIr7sHqNXU=;
 b=O84PCb5sH6b0kaxhibz7IyZ9t7j0l+xHhphC/4zpOiEKs7Nuhf8LOcGL3dhnEdtnaxO/L329E9oB0wENmp+lixM3XV+sYA0E61CBLWWv4Qurs7HufqNGL+EHUbXezscHKQ9aYNEXmFAmN6nmkEAZiKHBbKOGZHJT/JXlQ2KGkkGrS0gaKjVrve+6xAQVDzxtAHIsec2Oeo3igWxUZ6WgVnL3Mo+ZMsLG/bq6ti4/PhI7Re/f12sxaeUMuXvmolI0njPYpZqUSpTu2/e+ywu/EycRD8Hmw1CPoBZKFrBmsrmIV1WeIA68LfZhKkK5ImVUS1LIWStZmn30ptA3t/KUag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.47; Fri, 1 Mar
 2024 12:56:45 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 12:56:44 +0000
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
Date: Fri, 01 Mar 2024 07:56:41 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <86C93A15-30F6-405C-A877-909B3E12C52C@nvidia.com>
In-Reply-To: <2d5f9cd5-a2c2-453e-aa52-a84a86107d1f@sirena.org.uk>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
 <2d5f9cd5-a2c2-453e-aa52-a84a86107d1f@sirena.org.uk>
Content-Type: multipart/signed;
 boundary="=_MailMate_28CBCCCF-2620-498E-BF64-94C6A1625A3F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 56903a4b-5e96-4c83-413f-08dc39ef0c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kddhRZTHMSO0Jlxmv3YxJayziekLNg7zByOPh+G/htYnAGeYkYqC+uy8UJ81xk6rbfajIaarUrgWkhiQ/TChPyqLP80erezv1z+BfgoAmmEGJocgTWhpld2lpf0lQOcWt76sjz7OAqFeMcDXyRwI/bDm15HTdolUZVQgIaQns1E7gKqSxDzqgsN66SeQsDF0rJIjpzHspSp6zznnV3rVG5EmJxvrgtPVhcFNwxKaqEgIyiJxKJrniGzCo61CMiSic9aK8aaCIb02xjfSz/Q2eEKz/vdlZ0s/OFrREA66ASDwWhxYDibSfDH+ATp4aSDxba+yWtA2JHb2/6qjhSbW955mlpHD43T8RXsh3uKzb4T5tR+DPCCAxRb428Waae7ETGPBXxZoXvyIqbR5oU8/H8XVVhWsMMZvdBJo6HcvsD5Cx2LjM+Iz04otue1+dwvG1Z7kzRZlay+aePKEnb84YmK7Gph5Uvx8jdHXJPJ+R8kDkQJy3dDY3EfJqj0WuHbb9n8CG0yScolGgwrliVlUwGKSIWZXD3RvEjEYWaYC3GlD935LukRG9RDHIHKEgiRlR+5sVxcD2B64wlX3a3YJRY2LCtte3QBXurSuLuiDzvN1P6z7sJHrRvN+XlpVCE6w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rdPRowIOLgN2w9t48MWQtj0t/cMJAPn4KLRKz6qHPeaQ7qxQYb2MS2HMnd0r?=
 =?us-ascii?Q?okom9i6lGz77fh4UFYEb8Q5rE2wo3ztZTpxHnmSCFDjpEK3CYYgyg4ZYuMEB?=
 =?us-ascii?Q?Qo0HeArCvldHi0AsVNlNz4Zr9x7O7MbV+EaxdgVahlytTiQCWcOEI6Exhz5e?=
 =?us-ascii?Q?idJgqEeD9OuCg7+ubhCy1LcFWmuvN6cjIjRDgxGBfJitGpdBHR6B8xacc25O?=
 =?us-ascii?Q?8Br9JyDK7yopaxXycRmLzdFXf64xQZp0WSqlf4RAkQIJdK5uX/fFMnxGHdI5?=
 =?us-ascii?Q?W2pC89c5e0cDguQtdQqSSVCq4gpPOMPeVnO/AHHNzIS7Nzu3WhM8eox7CsTU?=
 =?us-ascii?Q?YnYPI84E4w0HEM9RjYz4V3Hwf3Cjpc9IwW55BkbybmtR0YILC7Rc6MpG4ZYH?=
 =?us-ascii?Q?rNh3PntSmIBCm+1EQyK2N90VevlqXnIB3PQ52Dzl1IfKgi5OqU2SEIU8DoLx?=
 =?us-ascii?Q?6PXcySb+5Dt6zExca1U3AgfSOq+cREO38srcwi6CpZynlM69aOh7N9J7SMNd?=
 =?us-ascii?Q?niCX7wyBuo+yCALJxDEnqcLSobXob8tZC7vsx98eeb8wAiWEhzcJ513EBGaS?=
 =?us-ascii?Q?+ohi57HOsSq+Z8tsAlTLyztKiJuXUegk+rkchN6F8dPrUBYoy2ejIcF1QZ5J?=
 =?us-ascii?Q?1wBxslnup25a5wHv5XORAKlc5wtPPzZQVvBxZ9wjA7eBu8+emlYTD1AHchzT?=
 =?us-ascii?Q?Nb1GSrQe3h1kzldhRPl+Upw/KbcCcP4G96uwEKnAwvsvgZ9KNuDKvi02pOBt?=
 =?us-ascii?Q?XzUwi/C8d4zSzd+64YHS/kGVXlaCzxc0ugpi5Bm6WYjUfaRP5f26ALhzWX7z?=
 =?us-ascii?Q?g8djy7S6b1uDidQ2VnGSds5E92TGedXnQ4kjmPu7kWm46U2vW9qQykSoNNSv?=
 =?us-ascii?Q?93A97uzWYtDd3alCLuVqaVm/5uxb0eDLrWilvXUyvL9ta/YM/9Y0c6asfZMS?=
 =?us-ascii?Q?cWnVCuG18UFTUDsui3NlulnZ83WncvNGV1HyyAXZ+RkIBfCcwhfYj/Uyo1FT?=
 =?us-ascii?Q?rFoU3R6dOekSf6re4po+e6nGEyGoBbqaE/065drdSTTLqORfx85wUkBkIEwO?=
 =?us-ascii?Q?Ft1PN/xcF3gQsB4l1aEr7Ri9rn7cO4MelBzIFbMQExLE+WaQ85YObf0HDrUv?=
 =?us-ascii?Q?bNQtTHk8damIJL0W16gLIAP+4rcyXJyuPMplg9jq0aBvrUbfVdZu7Q/8PEbT?=
 =?us-ascii?Q?zcoLjWqLktbBPESFvHfGGJtYLW26GBFgb9stPZvbY83Mjf6j/+EFbVI5vBAs?=
 =?us-ascii?Q?EHtX9OpQPIe1C+vmuUKTZgPs26/slVIzeWew7vDzj8+nhQic56/Jt9RHKNc6?=
 =?us-ascii?Q?pu++wZhDUZnOe0I3xrQPeUR/oJmMAj1z64G2RHIvW3xdNlbLfw6lkwukWY2c?=
 =?us-ascii?Q?oXODCNdnX8+kiS0074h7QjiqITlcL8shDIC31BK/91DUiYGA06EjRuLQDAEV?=
 =?us-ascii?Q?tw1xKtLZ/if+9nAkj9PQJfcz+6v81izycfptIESiaGDIVS1spb4AiKlaJ6UT?=
 =?us-ascii?Q?Evwdfg2qWcx1HvDSRtDRH3AWJF4gJnU7vucyau1lhU20qf+I2lLWMfEUhsrU?=
 =?us-ascii?Q?PfDxajwHIfsLGTwjgDv8p7pQuKu6Or4MMd/PD8fK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56903a4b-5e96-4c83-413f-08dc39ef0c5d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 12:56:44.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJnnn8csXDasIFIKPxsahc4BCyqEdLoAY+lkxtce3+fdKrPfG5ysapm/ZYfI+10q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973

--=_MailMate_28CBCCCF-2620-498E-BF64-94C6A1625A3F_=
Content-Type: text/plain

On 1 Mar 2024, at 7:11, Mark Brown wrote:

> On Fri, Mar 01, 2024 at 10:33:15AM +0000, Ryan Roberts wrote:
>
>>   - In create_pagecache_thp_and_fd() you do *fd = open(testfile, O_CREAT ...);
>>     where testfile is /mnt/thp_fs/testfile. So if /mnt/thp_fs doesn't exist,
>>     then the open will fail I think? I'm pretty sure that's what's happening on
>>     our CI. Suggest the test needs to setup this dir itself. Is thp_fs a mounted
>>     fs or just a dir? If the latter can you just mktemp()?
>
> Mounting on /mnt would also be a bit of an issue, that's something
> people are relatively likely to have used for something so could be
> disruptive.  If the test is going to do a new mount it's probably better
> to do something like make a temporary directory then mount on top of that.

To move it to a temp folder for mounting, the test needs to do the mount.
But it is impossible to know if the running environment has the required FS or not
and where the FS is. Should I add that as a parameter to the test binary?

--
Best Regards,
Yan, Zi

--=_MailMate_28CBCCCF-2620-498E-BF64-94C6A1625A3F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXh0IkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUsp0P/3lAT3IVPZ5+EagFzaaFnND8k+YtGWdUf4OJ
WYfNaDQYvt/X5ewduT8sq3AdTAAh1hNrPDSFjvr0ub3maWCjIz2bT+btXR1P8rFQ
mpQdtOuIY3p8I2FRdokgDjsF+x+rfyiHlscx3o3OLqhXKxg+ty05XwKFWV71ntNN
lH/YfG05gvJFftHAfJ+DxEzIzVKTSyK1cH8PI+DzrzQ+9dotGaMqg8JpwkMcemRP
mblt3IKIvLmFAjtZyM9FXiGvvffvQENtibwtQIK7aLYcmH83i+2smkNEIsWnICDc
SKg0C+2SSJbWFnL7+mVlw9c8oX7LmyuOiz6wIXtyM39JrUFUrUZNTTfWxUhmfdf2
PP/xcxDHcPHqXbRk/kXC3SpIVrgYX8qc1sZO3qqtEv3e2YClHM7kkpz0KOuplIwP
p19uzUYujjjZp/I3KVrEvju9xNj41pGfTMEo8omFpaJZW6rfSFR4aoPTi1bpnB7i
8q8npJNMJwTDx+Ui0+PIGo/sMLkYfSIfg9wy6uxM8sJSHf52dsIk47HXhJpKX37t
WX9maErqN/dQtD/BrLDUn6u7vhnHdSnq2/IxZcTgUdiQ20rEzSbxfOaHyCrx26EI
Qo22ICnStiMUSRX3l0hd+srdioJNTrObnUdAMVQyDoIcE2xO63MsIUzgWVDutVdF
DHBLR5iE
=VPHr
-----END PGP SIGNATURE-----

--=_MailMate_28CBCCCF-2620-498E-BF64-94C6A1625A3F_=--


Return-Path: <linux-fsdevel+bounces-28137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476B9673D2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BACF282BD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1BD183087;
	Sat, 31 Aug 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eoSKAodz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8317BB2A;
	Sat, 31 Aug 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143955; cv=fail; b=QBkkN0S5qZdzbpVZRqv0DnCuyEwNgT2/Vs2FO3kjFVijXatcz+/Vms2MecU40vK39xOd/h5HZUk3O7F3ZnoWFi995cNrHQIofScQSzKGeNRoEldTrPPl3uqhFbPbo7oVJHc61dGvB6Jj0nke7zw/pdchqsZPBXoqiNk5Jcra8IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143955; c=relaxed/simple;
	bh=WHWykqseJO9iSgVaZVMgIIqOaUTAOi0dxrahzhJNpCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPtJFKP0ZVbSzxmbp7Duok21XDVc4cbC9lWzwn7YyLGV57SXFxzJ2P9ax8XaDRMpqa1HMK8K82I9ZZkl2r2s0wFhlLisYrusNzm1JvL33n4wv4jnak+VWUe30u50Ks4c2TVv9SLkWHjGqTjJH9ssC+XADMIjnQgQDN7sTXs8ejs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eoSKAodz; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfzlERiXMmbpi6D3Izz4z6S2O7Jwd7iAAFVSQJIDy9Ns7G9y8wzXOy2/NqfDKO5Akfjp+1antOnCwYzxZOlRySwibDj4VMlHpVNlw+HUunF21F4OBAZHO+9JXCvG8o4SSx106P9mUoyMRQs9Tb3RO5WCFzwWSIEgmvih2UZn4une9MSbnLHztRz+fNRWx7D32Xx58Gx9vJUhGuhlgZ+ZfDPWRzS8qupUYH9xtjMiveuajQNPyrlq7x3GU/h9LIgWn/u8QEWCnEpnx91h3hMFzH5vxjJYriUS4Qnvvy3gboTqycNl5TCM+HGsx6I6NRH+9BvDAvIruBCbSjydiVJBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHWykqseJO9iSgVaZVMgIIqOaUTAOi0dxrahzhJNpCM=;
 b=CLwNggjcI5bBsxWyjA5n0eEnywle/LqrCBlwc0Aw9SymWpkNzCHZg7iEXagHRRwgrfrNUzshscC8Fq+TDIUZPKSWf7zlTFhVL9YyPacQSyRSSzBJ6qHR7w5t/AGjl38fDbg/opTsNO954P1g5GK/gxr5PdfKH8rCwcH8haosue/LMRvIueW6IptPLT6AQrpA6bCrhCseP4Kd6MrOhcbLeimSUCWaJusF4LJoTyL2Te81gJa3a1e/5uKoPEA1e9IjqFqpxXpvfuaigFOoBd+BqSDdQ410Hq8pbbanC6gV62X+RWa/qv9wt8+PDDq2e/6KxR0cSzLHcGb9fmPWKsrqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHWykqseJO9iSgVaZVMgIIqOaUTAOi0dxrahzhJNpCM=;
 b=eoSKAodzxu6o6rlyU3cKvuF7e5HTN9u1ftP4ffVZ++rCKiegziaaHKMaYyCXUpjuB1FZtiR5URumnIW3CLm09PGo7HsVHQ3myyg5m9Wuv0kBK7QKZedj+++NvBitzKcsx+jSn09BLcwp05wyIueqIBpcg/46H37h9SNL9yYm8aKEkdaPq6Lg22aA5K0Nyf7tj84O2Mlv5Ihb5levp8U+p7rYmrjQ/St1i2ArYYgUYktpkw5ukJD2T0pz5pJIHdfChd44LQ8eQuIEMojDNh0C2TA1K5i5JonhKwxmgpKwjdujWoNIIA1QSCBhWqp1dau1cpghWVADkr9ydq5WfK2YLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sat, 31 Aug
 2024 22:39:11 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%5]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 22:39:10 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <kernel@pankajraghav.com>,
 Matthew Wilcox <willy@infradead.org>, Sven Schnelle <svens@linux.ibm.com>,
 brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
 linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
 gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
 david@fromorbit.com, yang@os.amperecomputing.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, john.g.garry@oracle.com,
 cl@os.amperecomputing.com, p.raghav@samsung.com, ryan.roberts@arm.com,
 David Howells <dhowells@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v13 04/10] mm: split a folio in minimum folio order chunks
Date: Sat, 31 Aug 2024 18:38:57 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <C03CDEA0-1603-4D63-92E4-5B79820D1B45@nvidia.com>
In-Reply-To: <ZtH9dA7Xe7K5aSwg@bombadil.infradead.org>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
 <20240822135018.1931258-5-kernel@pankajraghav.com>
 <yt9dttf3r49e.fsf@linux.ibm.com> <ZtDCErRjh8bC5Y1r@bombadil.infradead.org>
 <ZtDSJuI2hYniMAzv@casper.infradead.org>
 <221FAE59-097C-4D31-A500-B09EDB07C285@nvidia.com>
 <ZtEHPAsIHKxUHBZX@bombadil.infradead.org>
 <2477a817-b482-43ed-9fd3-a7f8f948495f@pankajraghav.com>
 <ZtH9dA7Xe7K5aSwg@bombadil.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_73D40388-9FAE-4DA3-A9BE-D7A35598BCD4_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:408:e7::28) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d80965-7f89-4b7a-5995-08dcca0dbb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+MWAutNT5JptpDEuoiOVoZYsSktgJklNCYt5wVYzFPjhFyOd4LToL+Tzxuf?=
 =?us-ascii?Q?Xtfgm3DuSrTWht4Gsd87dtHOZKGsUXaCpmb5TLyY45/ifH7dd1xym10oKLlc?=
 =?us-ascii?Q?u35NTM7emXBbw/UkW0E1F0M+enrjYiSTChB2uhywGxd13ThPOBJ6hkZJIxpu?=
 =?us-ascii?Q?A/PgBUsu0+9RfUlpmqu2ncZjnNwCwgRHvjstI9B4OXjjEGG8dDczOy2Yl1hi?=
 =?us-ascii?Q?Z6QGGY8BVo8HoesPuwuS+lJFjdqHBxsuFiZkB6+nlY+1kqbxp1iLHyHTsSqw?=
 =?us-ascii?Q?WnBIJZd/2mO+XNhTBBnEnJ9pvcrBHhUsKP53hVs/gMurhPDqNbkSQePiQgtI?=
 =?us-ascii?Q?IuqeaytZ+V6oHhBswhhNv66EE8bqAlnv+cfMfOekHLOYLinHjgRd9IvZA/Ks?=
 =?us-ascii?Q?Ok1JQhg5vsqvMILRXFPtCjwauDOLqEvxYK1gNbqyE4YHgCHUteQHRSn95lhG?=
 =?us-ascii?Q?amPGbAjTlP0Ti2RO5bYcMk3SXnHdGAFm+aNeYlKSB0cjVr9IQxG5LW79nwHD?=
 =?us-ascii?Q?WhPiMoDOKKQg9cXKRcLYnGu7P41z0Q5q5xU38lTo6l38bEbZIIbrARTDtcIX?=
 =?us-ascii?Q?Npnp3lUx9q4oIF2/DO44we6Xl/WLNXQ8zfQOxhCETWXqnkYU8uU0CS6fBFrW?=
 =?us-ascii?Q?6TWh0irB7KboRIzcZzO2iRwGKQxeXLOHm9GrxVW5jE3sEtEmviT4uaWgOyuP?=
 =?us-ascii?Q?M4beD2Rh8QRqW+VFT7+1i7CJ/4yfFOEtpnu3QjsuF1HqXqETMcouVgOgLQHK?=
 =?us-ascii?Q?GSZyfh2HX7kGz8vdRy9pStweZdilnwEJ+tUkaHTZSIWwtpFzhNrz6XpJbwyB?=
 =?us-ascii?Q?8RZchN2X9aPoevaiJTi7G29vLupFB5pxWVo8mJrZBy0rxDJP/yU+BZ1Ihri5?=
 =?us-ascii?Q?OhePmxFkFBOWN4tE6L+ujFjpcv4Y8Nfstu2ztWGAD2I92TLzhrrr0R2ydxvv?=
 =?us-ascii?Q?X74fJljpMHZhKCIn9MOuElswEL4iqO52BARQGY28pdaCLJc2j/oi6Qsqn3rM?=
 =?us-ascii?Q?F9tdxyK8pdgtvQ0+NeHCKmb2rCK0mf+BB+uEcyCPyEPc9Boowrl31HBECQOr?=
 =?us-ascii?Q?7MvPf2tsHH/ArX+2z/Sc2y9IS61WQKe17h2r8D6unkhKQg2irPJpdosb7txH?=
 =?us-ascii?Q?0whkgMXozBut9Y0xRAQ2Tq122xtaIOg2ik/exkd7lVrKyiT9+HtbZHQQ+zCX?=
 =?us-ascii?Q?QgY8vgjUhD3iJkV1DecgayXa7J/dibOpM5eWNm4GyYbk+7cMX9D7mnxFJo7C?=
 =?us-ascii?Q?rHJDFa8SoaNry1sxtAmpQDddCJPLP3z+lLBh69Drz+caEf2cegVHfb/YHYUn?=
 =?us-ascii?Q?Xe1mGKmWJQznJ+SbIdfsw0AuJrMRAIQUP1rCOs3xDeSxcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GEhp/KegyyfgTqKLbILqBhvC7Zn/Ulk+B+wxQh0rnJlHAB7Cokin+WeTS294?=
 =?us-ascii?Q?A8YwnWZcO1bwskdidCZcBdH+iiVocFgdPAPaarNcp3/bQL2djkPaiq/IIBRX?=
 =?us-ascii?Q?IuqIVilwzRytpomtJsMGDRwdmO0FkqBFbNPMw4XKRV1IuF0knFYK4KhfBkV9?=
 =?us-ascii?Q?WyigZnfQ1biP7Td2fj9/QCykwUnzvENyJKRHJ/PZAJPPk6UWj0NpMYP2FRY7?=
 =?us-ascii?Q?7sfkHW9kXi0ql8MN+hv6AgVKYx7Z9ArWLE024L7/1nvSfZHqzEbfUfx1KH9W?=
 =?us-ascii?Q?okKdeo2rmaPBDs8To7BiJFaZxVdrqHC7tsNp6if+LvFsC1bTfu2fHHgPSMAP?=
 =?us-ascii?Q?c6kSz3Mb27w63OylzOn+KwR5FtA4PmmVxM1LOggWq//7giCsiRGB151g8eXw?=
 =?us-ascii?Q?h7FXIBbR3HYmkbvH8O8sjup6Jzb4A7QZVKLs2/7tLboel/uKyTgifnMzcJ9L?=
 =?us-ascii?Q?Ni4NGQYezmXW/gtEczOCyJd5j80uAP23tLcvXwmgyvBb97PtZFuiJBEE+K4Q?=
 =?us-ascii?Q?qq9V4vpEAElMGlHndLIDxlVN1vQ9lm+soAA8xqy1zQwWjc2d/z/OuMUyNGFT?=
 =?us-ascii?Q?o0r23D5ZX7+MVw3isyQzu7slOAqGbImdEsZsDu45HzWN+sCuU6fMD03a/RGG?=
 =?us-ascii?Q?8LJ7Xu7JqLazKjr8Mgpm0Tn2lcEqQ2hS2SLn+aT7Oouw60rOpLFbSleNFQ92?=
 =?us-ascii?Q?iIYbKjZi0TGmYpbiJOXQ8w94BPZfIhxOnUa3wuxK79H6BlM4T3Y5QRpba5c8?=
 =?us-ascii?Q?d6hapEsCjN+FaET7IxLUuSL0uutNcgk8954gMFLXnb+x42rTUFMN+anybhKX?=
 =?us-ascii?Q?1rX9xyJYYUOoi2rjnIwUHuoi/xD6eiYBbwKTDGuNu65ELxw2z39U6Yn3MmFI?=
 =?us-ascii?Q?0AF44lvJglmujXT8TkkT5hCgqplsRo3GwA3HhMsYYgzHPwjVSYF2xsvD2Fb/?=
 =?us-ascii?Q?pnGglNbBQhGqotRFK7e9d5K7Z1/PxXFo31+7IkcHjprcn8ZZcYHpFeooAuEK?=
 =?us-ascii?Q?u3S7vgrr48nl72+e+mTM2lMYSm3kj5XpYUQWze8y9WdexSaLfSg1OxET5LlR?=
 =?us-ascii?Q?/QgO4sGmaZr/XC+LjGRQNOii0hRzUqIZ2rIVdqY4rYSAapFcHZyJRRsitYK2?=
 =?us-ascii?Q?FjRbqVJtQSAUsCe7ZelR7vs5kGeCnpFrFn9+Rrte12nOM9Eu92SuobN0h0GR?=
 =?us-ascii?Q?LLRTq2KjlHN43HjqJJiJp9eioeensvsJ39ObngciW19yfcAz4Y3zXjZC+PO5?=
 =?us-ascii?Q?995jwUSXwunaRfO6ywq25pjlqxg/8eqaZiLLv3OEFIUeBMvPZ7VHgOyQZjWy?=
 =?us-ascii?Q?U7ZtyQClB/YYp9+SG3LD6efv2kezcZvobsWghOalnCZ5jv48icfDKBt0nYzD?=
 =?us-ascii?Q?oUgylSYYynJYRTFzNLgH3YlmvJhXJ03YGvxHNY+2ZItE2p9XUTZyr8lSG1TO?=
 =?us-ascii?Q?43fNy2a+RaEIsjfNT8D/mhLfIEheew/wcuAtl5rQtLf5QIvqDw0OjbadKnn6?=
 =?us-ascii?Q?lt+3V4+Ws7++fcZIREfN3Tl3Rm4Qu6gaKrIrPKFwvCJJZMyPdTk+3r3y/kLn?=
 =?us-ascii?Q?Oa7/kvmApZQUW0yXaGU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d80965-7f89-4b7a-5995-08dcca0dbb65
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 22:39:10.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUWisNGGx+1P74eteswdYG5m+zcs2BayW0/t+BQF3a6RvhMpIkYpgomnsA8wbH3Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095

--=_MailMate_73D40388-9FAE-4DA3-A9BE-D7A35598BCD4_=
Content-Type: text/plain

On 30 Aug 2024, at 13:12, Luis Chamberlain wrote:

> On Fri, Aug 30, 2024 at 04:59:57PM +0200, Pankaj Raghav wrote:
>> It feels a bit weird to pass both folio and the page in `split_page_folio_to_list()`.
>
> Agreed..
>
>> How about we extract the code that returns the min order so that we don't repeat.
>> Something like this:
>
> Of all solutions I like this the most, Zi, do you have any preference?

No preference, as long as Pankaj fixed the "if (ret)" issue I mentioned in the
other email.

--
Best Regards,
Yan, Zi

--=_MailMate_73D40388-9FAE-4DA3-A9BE-D7A35598BCD4_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmbTm4EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU+nEP/AmoC/amXPqf6fwTC+5jxIXzhwon/NaukB3G
ih427Yo78TD0ttF/oTleU61sHdVNaZBmlQfzDo5U6s1H+iN8/iSB+38I9VUvBr/H
hcP3mJqVwC8C3y8DlAb1wTrymNVkjVbaOFqingwiyONBYAHXHOcnagTgW8yY44m3
awqczARKvgldZwSHtSSiHtXpC+pNZb7gIOfYr7vdoqwDTsJgwJfTyFlosfchMnd/
RRaYy3mJlqGVL3JQwKZlXDPlbH9T0V3bK7i8VNNwn0e9/CCcZjS3L4DvbdUY3D2E
0/ToG0g8ObnOXVCCHHIQTQC39Hy+iLodOqBW4KUFnVClcrNQUZ5yh1C2/I1Cim/s
GZ8p/runk6ylsB92F/KRmM0eTp1Rg3i+wOGDpMGVtwmOkkUB8cENhgykKBKpvGRU
H1lgZXzoNnyyR33bmV0vqtBNQQb1uII9liA9I90FG+J+w8qFyWTHZAxy6OvstFTL
+ky1CZx//g1w7t101zE2qQSGtOyUbAzoyIY6pKCGqS1N3moNOnkyExqq3z+YwRI8
B5PK99GLMm3ZmI9p6X6p5SZY4ZvSZMmf6Z0Kty//NjGj41GkSb63RnKpSdA9aALw
QgtD8v3KNPj2WfN9/nEHVghkDewkDdN4g2nEe42uXs2RThjdDfb4cguGnmtwgV3f
5jJ5YXPA
=iGsz
-----END PGP SIGNATURE-----

--=_MailMate_73D40388-9FAE-4DA3-A9BE-D7A35598BCD4_=--


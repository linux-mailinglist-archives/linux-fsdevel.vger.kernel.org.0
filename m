Return-Path: <linux-fsdevel+bounces-21268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F4900AD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D867128B7FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97D19AD4B;
	Fri,  7 Jun 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ml/RcAqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED431474BD;
	Fri,  7 Jun 2024 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779526; cv=fail; b=OvIp4YgDnfndH6RmwCwueT8ib5Ie50b5yR1iANmFLuzxyKZNedwHpZQ03Yb4nUop9nqF6cWhQ1U34rRAkaqMJ0rsMAevAST9EDFn5NZExB3m8qTjW5FDK0gT7rzf6VHuImudWAYu+JLFLiDy/ymXnjeUzgrSN4mgo69RQqcVTn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779526; c=relaxed/simple;
	bh=Hd+FwAEO7Avxott85/PsSeCmL/Zd/piCspISRnoVv7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+Bse2NQSrZcu+8BGW4prgETFGJbO/Ck8UN7rR4mwWd9yboOy3qUetlhMYpkV+sV7L0gv0qUxfmpPPK43oxOtqBWcD1DTNbrIFir457U5LBllkqboLNigHsVv/mWnPZV/SKiUoxwwobFh7b7uOcfbnLAfTDj2YPPp8MCfNtAtgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ml/RcAqU; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPFJ/lqPg1mEHdGl3H5EmPihbuyFvr+Sc0xk6A4/iZQ/b8iNPhW4Ty7PmgwhjLgV2ONNO0LH6wtkOQn0F1pztjr2efyt0igFskjfZ+rK7eKefUOoZ6Rxv+x4k/NamPxNonQbWbhLhUHGCjs+Uv8oNWVoAq6SxfFkIkmdsMt9sOIOOSHk4XviYpqMwWuTheBydUB1J9/WYii0xpy2WGTdhhVFnwMuQlwq6smJJrn1px1zqkkIeGAxPJNRDG/hqRc5pFrmxPID2/xCetTA2Q5xI8iE9oyKt/svWBbVRMFLiue5td4MW3wTPGwU8COuQQk6cMiMiYB7mKaYT1R3Pl2zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPZyCZ9DWWLWSqYM7kvKuDOt5gM9bLwyEl9+Vmr8UNo=;
 b=CBk+QxCPfELHqlBHTmuX5p4wg4l3Fr45UqXyI23PvDCo+QUR86qyRwPlfPO/GWxbenUTYc4IUrawjEQ9by7FZwaySppztBb8CsXdQkQ/Ow5aBNZRvPh6D5AI1H4ijxDgNt/QrVd5/oN0si7IgoRUC7uKXoc4c7uC9Q/u5eCNlK9Xq+X0ZmsNFZl0qvtY/2mLeQqLM5NUvk4h69Trse+e6IrNMRnh/5bvX6UMeYggZ/fXoRZsR9D6bP3i4AS8adXuF1EzDfhhFHsQ3yaeoa6vivPtGiUa4j6UgjuUSg3RXYpNbkUGi1NlPmfoW5zExjJ7Jw41no6Cqo50U5EZQB6jfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPZyCZ9DWWLWSqYM7kvKuDOt5gM9bLwyEl9+Vmr8UNo=;
 b=ml/RcAqUVJgpMYFbac+PGP+EZlD7bZrw6J0wbzbgL44F8kk02oFNKTllxhMzlKkjgfgvWKXlI2pPGZn1uWxMmzCdBSIYIWVWGSsuUTI5BRP1NJBxUQb501DxYAkf54li5yCU6+pc1j8gAq+REu9yOf2FwqH2quEsDlqUgh7adOq9b6bniUkVeoxw/SH5ugqPSIYwZdAQkRRjTXtoLB3DdtUMFN4JPTqjfG0fE3A/nDYaqES8yMK/FV0sJT6//2iw/ELvPulcaCUA3ZBoFH3EDs//otHQ522Ae9mq/rNxPID+QURdZm4rWhnruIJImMBJORo8YJJGcffM45REQfVyAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 7 Jun
 2024 16:58:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 16:58:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
 brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
 mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
 linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
 linux-xfs@vger.kernel.org, p.raghav@samsung.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
 cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
Date: Fri, 07 Jun 2024 12:58:33 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>
In-Reply-To: <20240607145902.1137853-6-kernel@pankajraghav.com>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-6-kernel@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C26015E8-0302-49D7-9576-810448B2184E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:208:a8::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: d3102a1c-7c54-4d1c-56ed-08dc87131498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HAlO9Z52uQ77LwXptWtY5WiuKJDMOG5GJnVyOgGRICykDeUTofPaKY90M4Tt?=
 =?us-ascii?Q?YbLSNn5YtKZDkG0ALIZqaAEr2MjawskaryeG7MKul3r1AYHelaz3ckl8WxJ9?=
 =?us-ascii?Q?OT3bcvEl0Jy86CdbTEMHSi87/wFVvD+txFG30LB6rNlbf1T95I60CiZSbAWK?=
 =?us-ascii?Q?lOTm+hgJi1Qfteb5vUlSUkbV3RHd69qYa7MvgyX2gRNN1VpfZfFBlXLvDwId?=
 =?us-ascii?Q?3V3oK/ndwrZj88ikXoJWhlXDOlKqHRIYmI03sEGr1U/lRJBqhzJpi4LY5KsJ?=
 =?us-ascii?Q?v6aPGGBg/wQR7/A/a0t2H1WLYmCw9DPLtGkaE9nWurYwQ98e9a5uD2sap6jP?=
 =?us-ascii?Q?Vui7NLVdhHWZ625pFmTHRGq48DAFUCeVA9RyeLB7OXZWcik/22n/Lb1Pefa4?=
 =?us-ascii?Q?pk1lMyHXsLS4GpMQOExFd98AJzVBfC2jQ3aOWmH2cUAIlKPj1YmxuDKPJey8?=
 =?us-ascii?Q?+DqjuArOu0fIyQ3kvytt0wnXW/bIHdwtBE01kA/IPNTXcOrUIMVn1QiKvi7Z?=
 =?us-ascii?Q?nvYT4OOOCKHFDUrxY6Qdp/XJI/n7psZssO8z9oeVQW9L2LpL9R4QYNohDZmH?=
 =?us-ascii?Q?tej1PfHOwdzYR54aUhg0eEq/lDlA3g/gbfM9HhqRS447Se7xscvpFc/W7QKL?=
 =?us-ascii?Q?O2KYqgBBOAL0ijAtDemqjayXpeKS8AsRL3OrMtUkHR0H+L1m+UcbOmg1Ys3O?=
 =?us-ascii?Q?bcZbyjqFd8mSXxhdsqw0SxoAMTpF4F8M0HafdsAL3d6B+13iy44BnyFHHOvw?=
 =?us-ascii?Q?ihbkhIUIEJUEI2qv0Uviup6/MYbpJqe/TfGbPiI/qF8CYPPoX5BHk+IixI+H?=
 =?us-ascii?Q?WNBH2FGIbXhDoFuygthLx63ZWE5n6ZS2oFVxy+2LIfz+YRnuUFRS3cgIns8A?=
 =?us-ascii?Q?leL+bbRNPogE9JeZfG3WRv1hFe1gyOvDTtGIC/EJ/VIyq+A0HtFV8rxbO20M?=
 =?us-ascii?Q?AFevVj+JOVZh4BgMklX15+7WCgwUKtDKBAOAVWrFI0dAHXr0R6zAdrWGGDPH?=
 =?us-ascii?Q?LsbLdpDTAR3zoGzaJe4e4mqIL9iuWzOuaoTsKjfXmPjCThZyw2wpAAxdz8nf?=
 =?us-ascii?Q?gyreBgSgK9S/jX9duFvPS5Sg4fvQOU+Mu2ephqMZ8mKws8XC5k0s2v79aGWR?=
 =?us-ascii?Q?60XUPs5EbtejdKkA7NXsApkhKD305ct+UUp3vC98VNyPHEUTWgyn8Aqqw7S+?=
 =?us-ascii?Q?f35ZFYt7tPr8szsH8lvSSKhzsMbRLdUmErQvNeLu/IizCYjusU5BQYFhJSzZ?=
 =?us-ascii?Q?fhxK8RAjWvgEUXOLvSY/0dYKV/xPtelYBKfazjrofUhR8IOdGcOXT2ShP5O8?=
 =?us-ascii?Q?KUqrOpVBlCNuScdB9Rbmg579?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YyvBPK0wOefUV9EIMvISyLATdvjizLRi0J+yBMFtaAFRCyARmPF0jW3lAL0j?=
 =?us-ascii?Q?l/XnOcYW0oP/0AUJnL52cVwEW9utxZZIwiu/CQTEwq7/fs1fR5OUnNxK8DBs?=
 =?us-ascii?Q?JNh/BHEBdRFnkfmProXa3SPHs48RCdVKGn4+oVEA0PRZY/UW14r4YplDpe35?=
 =?us-ascii?Q?5kxcWmrBaEk2rcuQagkiQXBVcE1XTIM5UwRofImXoDH2B9o08xsTj+Yggftd?=
 =?us-ascii?Q?cM2MreZrqWdEcH9jq7R6ZOm6RFXdnvOLx4KMNT2Int0yDx/POwgNvV9IAfbA?=
 =?us-ascii?Q?re56oRquuNIpQ0ngKWH0xlbWZO0xFNFU8c+rZKKapIwPy3QmYeuzT/0A30Jl?=
 =?us-ascii?Q?Lc5ictS1dc/81e45pU4mqd6eNbbsIhTUWmkTnJpk/R8TDRy4zXE2RdESdSKb?=
 =?us-ascii?Q?UhOTNo8JXVcmfUI7yq/vMDMur0qnW2XqjM8C9hqsv+oqW5mx67yr/etdaGUv?=
 =?us-ascii?Q?VJdveHxeF919k4qZIleLD46yJ/6pCMxDeo0KRoi09nzFf72zreIucr/128lT?=
 =?us-ascii?Q?s/f2lGNC7hWpRfGGuBd95Ez1pxTK5V7YiBHjmfeIDYIjgmPBnablZVXsY7Vb?=
 =?us-ascii?Q?+1KlxvK3h0sSLqw5nXlUTV2gZ+Qs0XmoNrf8Y3nkiVKcmgivs6rJZickmp5U?=
 =?us-ascii?Q?DyC3X6abdFWWlMV2RagUBzq5oDOgqWh0IDGOO82A907NFLSI6u6Lauh+COOq?=
 =?us-ascii?Q?kPJPtw6KmJHLkgXbarH1GulY7RzDOFbasimR9QnlJD56FbV25DcUliOSFlio?=
 =?us-ascii?Q?91oM25ipgsdEPB53v7PDClql8vhfxZ5a4hG7yN3/HzCK6J1N4A7n5DLBhBoZ?=
 =?us-ascii?Q?1RVMq8PrGQQxzdEAZ3WvAqV/4v1LwyILuogkPQE/Kbt7zO3JjvLm6KwXTgT+?=
 =?us-ascii?Q?BKqZcM5H/9YG4yZwptxYmgriv8LaPsLEURiGb3bTKNB0LbeyfOPBQKVvGW21?=
 =?us-ascii?Q?8jPXX4xnqrCmBdZxli/b8ynfFwmggMdIv70sj7wR/uk8mo0Zpezz7odjGQnL?=
 =?us-ascii?Q?bcbrfseeUFDiIFRodU7pRpxNy4uR3njxhvX6qYgFsTCMBJTqCkW89hAM/pnV?=
 =?us-ascii?Q?OidJj7oiIViXR8wWoWyk2UivlJAvbPLThooMuJMlyCZnYbgttAqN6vRS1ekT?=
 =?us-ascii?Q?aWclFgD+XmYZSl0hI+1IDuKRBaAWeYdFfjWpf543ozIBRjbPIz/kWPRXTyT3?=
 =?us-ascii?Q?2LvgHXJDFqBtwa4sduDgZXWuepsH5pZ0jBS6H4oMYO3+WxKwuCNutMHdIXqD?=
 =?us-ascii?Q?U0Rc5hzoF40u3Vzrg6uiuuDQtWuCpIa9Y4RfKbUxOy9j4vkoh/G1WUSnGk3d?=
 =?us-ascii?Q?iBskCmFg/zEO4IvanP83mqoaCvtTpprSupaKlkCC4jV7F44GPNxTrXEQQBUP?=
 =?us-ascii?Q?hjjzCsDdBC7zBJj+vaVurQZyCIFMeXoMY5ViXAuMzukv7hqRz7dWn76OatRP?=
 =?us-ascii?Q?gzClV+fEp9Zb2sf2S2izVgu4TGI7ql3EIuZLRwzx3SlsL8kzYpj2sR7Glmp4?=
 =?us-ascii?Q?is9H5xD++10pJvv7ot9u5n+YAJrDQUhLUJ95R+8w7T5Mw3FhBvh9jZpswLpk?=
 =?us-ascii?Q?FI1amM3f/PJO8yauScs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3102a1c-7c54-4d1c-56ed-08dc87131498
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 16:58:40.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WrCL6KXVxSfK41ztt6ODpIQ8Bvp7/+TlVphtX7VUVkCk9/sLpBBls3AvB+f0P3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

--=_MailMate_C26015E8-0302-49D7-9576-810448B2184E_=
Content-Type: text/plain

Hi Pankaj,

Can you use ziy@nvidia.com instead of zi.yan@sent.com? Since I just use the latter
to send patches. Thanks.

On 7 Jun 2024, at 10:58, Pankaj Raghav (Samsung) wrote:

> From: Luis Chamberlain <mcgrof@kernel.org>
>
> split_folio() and split_folio_to_list() assume order 0, to support
> minorder for non-anonymous folios, we must expand these to check the
> folio mapping order and use that.
>
> Set new_order to be at least minimum folio order if it is set in
> split_huge_page_to_list() so that we can maintain minimum folio order
> requirement in the page cache.
>
> Update the debugfs write files used for testing to ensure the order
> is respected as well. We simply enforce the min order when a file
> mapping is used.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/huge_mm.h | 14 ++++++++---
>  mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 61 insertions(+), 8 deletions(-)
>

<snip>

>
> +int split_folio_to_list(struct folio *folio, struct list_head *list)
> +{
> +	unsigned int min_order = 0;
> +
> +	if (!folio_test_anon(folio)) {
> +		if (!folio->mapping) {
> +			count_vm_event(THP_SPLIT_PAGE_FAILED);

You should only increase this counter when the input folio is a THP, namely
folio_test_pmd_mappable(folio) is true. For other large folios, we will
need a separate counter. Something like MTHP_STAT_FILE_SPLIT_FAILED.
See enum mthp_stat_item in include/linux/huge_mm.h.


--
Best Regards,
Yan, Zi

--=_MailMate_C26015E8-0302-49D7-9576-810448B2184E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZjPDoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUp1QQAI0MhWeLze8p2dJqkvMW9+KlkTMHHvNZAX/g
0ESdRtBG0nzR4kkceO7QDJNIQu9BCtCN8/jUcZyocC8h6K//No/N0NBD34YmDAVH
nhYzgGHohEiUfP3o6eX7xs78Vt1zWzpcSoKO+SAWAAe+pBb8g7xWHUeaLAAfXAC1
HNMJz2f/pVFDh27HS63XFGGZ8YGEozha9jFZ/L1BEi1mbDnSAhR4XSu3XQrK3EPn
RdWj8flJq+uwnjCKljVe25CvwOQJ3ndIXS/lbf1C3lC/BNev47i6///sTRm+k87/
Fg9gZb+c10nqiKF6HjA6/FX3M3XizSpvQn8ibv17gef4XGibDhd4aML7siLrWG44
/OATWpRFcbCObSCAsAGXD/gGyhPtIYCF6nLVF2otSqn/sfDeQDBYmIKrqJHmx1eP
6HvpSTuG5fhTcLEkHAdY0b0y8FhUq4o3kGDGw8WaLLTOgM/K5qS2o/T00irHsv9g
40tKqPSC7iKbA7Sx+v5mxbMrsJ+B+isFu3Cl/VVE9OIreYLkqw8UB8YyrQN+gOx7
jqHca2lT2CbCNGUYghi6Poa/0/kzZiCeJl20cIyx2Q1w+eKEX7y8jtOzW9JxX6DI
bt4woibypB/LZnvTRTdMlyEMYvaf93BpWKxLY/Or1HGKdh/fZmGuf8o+BiSpON+l
gC60/tty
=y4Qq
-----END PGP SIGNATURE-----

--=_MailMate_C26015E8-0302-49D7-9576-810448B2184E_=--


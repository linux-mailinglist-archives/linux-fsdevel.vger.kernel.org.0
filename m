Return-Path: <linux-fsdevel+bounces-18912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F5E8BE715
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B131C23CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F9616133F;
	Tue,  7 May 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J59rH+5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028215F414;
	Tue,  7 May 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094684; cv=fail; b=OIh/BsCFUxY2S1TErqY0Jxr07t4rhkWWW6K0JECOx2TBPApOwyTMDXASW8No5pJrwRiBkm8DqQuDcd6qvCPwVVPOogLxoaLR0gdb/ZcVYsRkQgrKBqprPnZ4jtSffl3eu49oA8RL2d1Cwgh1VpsNaXF89lTWqFgjJe0k3ROaFD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094684; c=relaxed/simple;
	bh=OOSz4V2EfbencGqODjx0KA4fEKlJ3IcFk+Npgu1pDKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvvEywbuaYXEVccYIzzKQMg3NpUlHQm/LIdcKGQ2OFRlMRUCMoY7vNkbIZ3SGrWqjNEeJSpHhsavYzLfMUjpNP0+LPKduM9A4ZSMtlyp5hGdk72LSqpNcBPH5unWriUtuItYkKHBX2b7Zd6R3SsX8JVYnAa7kPaYY6iosJ8A1rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J59rH+5k; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh1ragcETndXDWJXDnjWAkW/9zTmINObgFUw3UxBRY+vtiAUrYwgI3VOFZdhjE44Rtgz2xRITptGxSlwjFJljoBN3msgCiDrom0lus0lTmQeWwRHFiC4klEPM74q6gakqfJH5+wHmhIEZW6gkT7qNv+FjrLgcLmPpPKn4ukSdoj6dSooT42HEJ4gl/9MLgBP/dC3Y1CRRwv7CfmTriJA144tPdXqgF9Bpa1gemQtaU4Nw5XHCjFvzt5FmnL4N66S7+1XHF2K8N+lGBlvTKraXxYyRhDgg1+K0B59Xeez/RWm9sUkzBXT8ZHqgUmypp7DPDk25wdJgO+ZwZsOCAsWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9aD1nEzIGLLcAnstz76Jkr7LD8ZGA4aKVkil7rca38=;
 b=mOnJ9Ny2xZlxA9HT5maKdlGJAGqIHEaqLzXEDxS81QqHCUQeAKhpryAkqsBDC9gJOnf7OOqvri/UTZNA1HciD0z5a1MUnSl64yxS/MFJsjI96H5K7vqJ8DGNZQjVRIdTADcsXTPErezWNBF/aODIVWaeOXLd4qwhBKGFa6e8ZNDAB8++nODmnCnLGFQFkX6cA+19qrydsYal1mHkqeKcPrkm0O0jucHFFXLftstwNyGUHNbwbPAcSzjhvnNnWqX9W3Ty38P9k/V9sJzg3FqI9gc2G6bska6lkA1QX9zRCt9CxaA00c9ynN/nnktV9b2LHDmgowW5fqkO21DvUTAq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9aD1nEzIGLLcAnstz76Jkr7LD8ZGA4aKVkil7rca38=;
 b=J59rH+5kHj/quUwdCmhumffy8mMaPBIVfdWjzaOQ58rD4iwmKff+1jFA3COmB5YE5Y/7AI4Z94BmbpctJvTgcTfsnyIg5ReMOINELmRQ6aD3gL+2sxAw4lFHLYzYWscJB9stKCBYkqC2wKPNIjmFUT9G/NOGVIBzRqoVIm2/ey/U6NhHzbaNV4O4Cj4BX95108NI88e4hDwZfZG6lPlZ4eVfZ7EAO7SWP6SRKH5SgP5JqTFYhd1M4LiqKZA6OQ29oKsNdAjrlU7MBQUF8hTeo+HjDQgh5/DTe0FryzUn+ZLEH+oHreOMWtshxeNSa9wP80VIhYrwZCb1OhfAnTg2tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Tue, 7 May 2024 15:11:19 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:11:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: hch@lst.de, willy@infradead.org, mcgrof@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, chandan.babu@oracle.com,
 david@fromorbit.com, djwong@kernel.org, gost.dev@samsung.com, hare@suse.de,
 john.g.garry@oracle.com, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
 p.raghav@samsung.com, ritesh.list@gmail.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Date: Tue, 07 May 2024 11:11:17 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <BFCF63BF-0A65-45D2-9D27-1C2F78F9C018@nvidia.com>
In-Reply-To: <20240507145811.52987-1-kernel@pankajraghav.com>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_EDC5670C-DDE9-437D-8F24-0DA3B9EBCB03_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 60091106-e7f1-4303-9006-08dc6ea7f308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yeRfY4QPlnLMSlEOJ2YAx1JgUpHO2xQ3hxYPHeuf8IShDLbBmyX74U01o8XD?=
 =?us-ascii?Q?7QuLIG54C40JQdumJEpp/OTZ2uEASChhSEQ9KnadQtecY0yDpBzvqBIMQ/9Y?=
 =?us-ascii?Q?uYWmpl1ad5vX+DgNbZ/cuhhy3HvzGf4XGEv4DluZuxTP0BMW6A+OYV949qjT?=
 =?us-ascii?Q?G1NzH9+4mAc/19RsHp2mNcPVbCB1a0blC1OjBlTbnaagZDEXLsQT1JsvY3Tb?=
 =?us-ascii?Q?DY6a8W0C8A0Ilu19jpEazi3NxKWP3RzKLYn/05MAHibHtYwxYTdxt7mJ7BHU?=
 =?us-ascii?Q?kJOg7VrxtwEXuU4EFGeMBbRBi15/2yWWwbJKFLjOfZ2+A5WrzH1njTmZW2zi?=
 =?us-ascii?Q?u5zM098dtgeLDMelh9hHKU738oAYqp5Vxer5MO3mpLsra9at55Jt6G4NdYNy?=
 =?us-ascii?Q?Kyk6KkYgSkFN324aayysDks+vo334VWOuTX7uz8DsHXtp+3OTRL6Ep0K7QrW?=
 =?us-ascii?Q?0ARcVRyzlTbVVr+nH/hmTFZQ3e9GZM/mw1l9Z7JkBn1sdf9TUDrY/+D+EPug?=
 =?us-ascii?Q?eDhNPoOqjak/9APi1+wFT0m8GhiJumH8CXBnNr8lT5DHo/C0AdEqX93fcmwe?=
 =?us-ascii?Q?6pbae7HxdRKpLlHh9Kz4gJSaKVuRmMwPML1aY9cEwwGwH0ALwedKDlKN3uQ4?=
 =?us-ascii?Q?Cvqe9HquhfphhoDpsZVr57sa8D8fugIwpinY5GIR8Th/28tmh+H3PtXypGCP?=
 =?us-ascii?Q?r3IRtHR6hvmf1h4iesBBvqgsCA6AiUdk3/k5mhyC4adAXiBzY1iYwO0EQWzp?=
 =?us-ascii?Q?/K2yyNicz3KSZuczCCqU7ZzKtWHzUSY8RFuqmPT9OS+TT5+Q51X8afCM/Vac?=
 =?us-ascii?Q?PeUPZBF9BvW4w/gfQbeQID0W7Capc7p0ciU2BaAuitW7PIZvReRzfIq5K+B2?=
 =?us-ascii?Q?t7gC8i2Nnn2fL+Lkp1kkE+wuLPttpLdYn4Um0juCJG2g3SBZEXN1Tq9dIGSs?=
 =?us-ascii?Q?1I8dAcvk55xt97tKUKLWpPlPGI91mDdnFg379W/OzzzZaaoZh4bKJYeBElsZ?=
 =?us-ascii?Q?Zvo4IhLMhS+WAsbeOSJG2ByMBmiM7I2iPhleBsdG0I4COCTPCF9KE/nJiBJP?=
 =?us-ascii?Q?Z809gQQTnh1Ah6dQM25jqUAcQ6RsTukQ+EewlLahO9IGwCn4jMOWF8skTRBK?=
 =?us-ascii?Q?b7B4rj8fJm6E2fKB+4am8rnAoeb5Sk4wDuYaVcOarqcBpzHzuyEJ8MVlNQHt?=
 =?us-ascii?Q?6pD2V6cPHXAi/e0wong+1ujt3tWwAzVKaZMeKZW8qVYT0ptRQssyjO0voQEL?=
 =?us-ascii?Q?VHs8ENqcRGyuMMVE2Euh3vFWBEt722kZ/sZTh/barw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dIr6ZqiCqWu4Ykr2hLrC8yCRM1cRemXZGtWX1Z72CUmZ9306FBDxYnOuvagf?=
 =?us-ascii?Q?gMQEM7lScTezH+Xb07FGO7eKlmnTqd8xRtHYwqy3tAXSIixGfcpqXsSgXOQl?=
 =?us-ascii?Q?SAj9we7hzD+0XNvEo6mHSX02Tb5RW6Syps4x9+ZlW6cIpqwuyefDsO6KfPQ6?=
 =?us-ascii?Q?8GonC7B6+8uRHnWOI6ujwIlZcaly6L3IeImPpkes5onX5kd0N8dy2HSf2l3J?=
 =?us-ascii?Q?csSuAq8M7+xeW0PgXoOce7l+8d7wif50jOzzTzXmL/PkUQTYlxfvWZPz02pV?=
 =?us-ascii?Q?GycxRTEXnTySnFlKRabkHYTMdMsoBlsK27eZWQFcloG5QybXIdVozg5PkK0D?=
 =?us-ascii?Q?W/1Et2wpP7/W1yp5RkqofSxfVo5dHsk5BxNSGnBR2hQqxpyJxAz4ruCL6uLk?=
 =?us-ascii?Q?3tXpXTI+Xu8WcfxZYO4LTYWH/FcwomGlSdX9LOkhn6c+M0E35j8jWac1rF4E?=
 =?us-ascii?Q?o1qyTjHvx0gVhSfbsxBJDUgHStKVOXOnAdLpzc6nifiQvv9egKhvAjVw3lQ9?=
 =?us-ascii?Q?WO5JYHeYNEIrb8nzoMVponurc7YiVVYf30hjrbQ/rAq5GH6jGDGOaZB1cHIG?=
 =?us-ascii?Q?YPdSVj9Q/Z621fw2pEcAnFseMI8lG2ZtIenwWTBLXJUvUP7Nm01xmKr6UvFL?=
 =?us-ascii?Q?Li/qukg/GoMDp01xgNgVi9yXDzJqvmOL2Vat9ZB9n43t5TPDF2auMl595QfQ?=
 =?us-ascii?Q?9+HwuBxMioefvRitZu9SB2M16GbDUXZRTRnDrDztcJS49gJMB0pOo8TXsyEf?=
 =?us-ascii?Q?dlOgKNOIveQXgLxF1SdOst0OCorVXR+LQOvVXls08gx1fIv1zWeKuiFHufo1?=
 =?us-ascii?Q?W4txGgrkp1LSZPfOUIN9xehfaZkg5TTUnYyraHhWsgFvvgdi/gtzJm84ux1h?=
 =?us-ascii?Q?x9/zcmNag3n0aV044mnDIJY0RtntYBWnl7J0SGlqOE25tZCwEZ7RMC+z9sAH?=
 =?us-ascii?Q?2d8Te3Qz1UvxwFRJ/XvtpD4+q9LDAqcNXc6u3ibbE7Aj6PJjOoDuKTcsiE7t?=
 =?us-ascii?Q?2LQElnv68PbN4hluxcTxd2U2HezvMb5AmpIbyfWxzjiJq7L7ZAk4hT8cGVxY?=
 =?us-ascii?Q?y6fQz6PKXp4Ety2n/uPy8BpcaMjmCuaTwUSQ9lbKPG90WE1LD2AlzCd8Gfdn?=
 =?us-ascii?Q?bWWsIf+3Xp803O5uHn6bq7BPB6dyEKiR8AywuMggI3UK3e+AGlZKkcMAdHke?=
 =?us-ascii?Q?eTgEZ6rQWJ91Iu6mUBD9dIvEPToHXoRYPlxqc8kF9sF3cdw9rHpJ+mz5rZPM?=
 =?us-ascii?Q?M/xfKbtpM/Y20ZJM8gYnCMB3UlJligN3hoDXRsvtaLC7S7yG9/W1Zi6h7w50?=
 =?us-ascii?Q?Kj7Vhp8wb9D+U3guS6waTCT/UymVy++58zAUzCzxbDdDJspm8CR6D3+N+Mgb?=
 =?us-ascii?Q?tFL2/2RjRMORXo6N2iaSj/CI3aSSXwuJSHKAz2teOOCcMgrHN1vq5yIJmNjr?=
 =?us-ascii?Q?m2xk1TohKazmEkiiMlSdNbedARDKR0AL/+CMjZMEF9FTShyetq29rSwsAosJ?=
 =?us-ascii?Q?HxDCpcZcw/tTxTg58mb0uphYnff0nOwbPqLzjGimC31XraCnYBHoABVJDfh7?=
 =?us-ascii?Q?csJy0dhal1bwFl7Hb5kEKb857QTKrRGGcGdr5FaD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60091106-e7f1-4303-9006-08dc6ea7f308
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:11:19.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Wcr4xpDJZ0/4zgQQCw6fHdVT8aI9GmT8bsB7jFhWy1mB4V0O/ClC66YKtdj8/cL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

--=_MailMate_EDC5670C-DDE9-437D-8F24-0DA3B9EBCB03_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 7 May 2024, at 10:58, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Instead of looping with ZERO_PAGE, use a huge zero folio to zero pad th=
e
> block. Fallback to ZERO_PAGE if mm_get_huge_zero_folio() fails.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> I rebased on top of mm-unstable to get mm_get_huge_zero_folio().
>
> @Christoph is this inline with what you had in mind?
>
>  fs/iomap/direct-io.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 5f481068de5b..7f584f9ff2c5 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -236,11 +236,18 @@ static void iomap_dio_zero(const struct iomap_ite=
r *iter, struct iomap_dio *dio,
>  		loff_t pos, unsigned len)
>  {
>  	struct inode *inode =3D file_inode(dio->iocb->ki_filp);
> -	struct page *page =3D ZERO_PAGE(0);
> +	struct folio *zero_page_folio =3D page_folio(ZERO_PAGE(0));
> +	struct folio *folio =3D zero_page_folio;
>  	struct bio *bio;
>
>  	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
>
> +	if (len > PAGE_SIZE) {
> +		folio =3D mm_get_huge_zero_folio(current->mm);

The huge zero folio is order-9, but it seems here you only require len to=
 be
bigger than PAGE_SIZE. I am not sure if it works when len is smaller than=

HPAGE_PMD_SIZE.

> +		if (!folio)
> +			folio =3D zero_page_folio;
> +	}
> +
>  	bio =3D iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
>  				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> @@ -251,10 +258,10 @@ static void iomap_dio_zero(const struct iomap_ite=
r *iter, struct iomap_dio *dio,
>  	bio->bi_end_io =3D iomap_dio_bio_end_io;
>
>  	while (len) {
> -		unsigned int io_len =3D min_t(unsigned int, len, PAGE_SIZE);
> +		unsigned int size =3D min(len, folio_size(folio));
>
> -		__bio_add_page(bio, page, io_len, 0);
> -		len -=3D io_len;
> +		bio_add_folio_nofail(bio, folio, size, 0);
> +		len -=3D size;

Maybe use huge zero folio when len > HPAGE_PMD_SIZE and use ZERO_PAGE(0)
for len % HPAGE_PMD_SIZE.

>  	}
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
>  }
> -- =

> 2.34.1


--
Best Regards,
Yan, Zi

--=_MailMate_EDC5670C-DDE9-437D-8F24-0DA3B9EBCB03_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY6RJUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUXAwP/2/gGmMgLae2B3i81IljldrJGKPKr+43wx3/
U6nzN9Wkpv7WIFtjTGMaNThBEqjQbzBD1PJDvLBfePCKHqMx2b5jW9JXof61WWa4
DPDYTLqBf66jdT58N8HiHWWr5dPmHZkHJuCfGbKZMzj+OKTXieKnTpI8yERO8Fox
SRMszt6sHWhkSo7BIQfVurGzZ0ZPljXx+ckNtzMyFnynIxUFRTzieV46T9Sx7t3c
rS4dBZk3pLWiBMGqs0twzdsfgh6GD0dqqMFLxwyYuEXpOy1YmyD1K84MyrWNL9EF
34VGrXN5al8pSOf9u54DIl65D+JO6YsjVsxGSgHqNdvMFUAtpeETumlB9iB3WmJp
F6HxhlgeP494hpd8b+lAOo3tvnJ51tXfQSy2n+PfLuk4mvCsE7QO8THDO4gb+PML
skqIQI4Q7F78s/roSlPzODnunsaDgtf6E4RUPCQmestdalQhEP9CSD+k1aYsFluv
x3a4AeoQAtzQiYdZqkVXn6e2sSjDZBFvf4xxDawygET2OsYrJ26YsQ/gMFA6lllJ
8GxiUtokY0eqWiC+riXVHw0IkrZM6P2t1v4OYimpW0tTKuUMeWtXRJ80hvX3mCNc
1Cdto74qYhmuIBCJ/ocs2u/bHJxrwE8ZKmtvD7++6AmHdD19zOeq89unMrt4tX8L
JeerKNDf
=19y2
-----END PGP SIGNATURE-----

--=_MailMate_EDC5670C-DDE9-437D-8F24-0DA3B9EBCB03_=--


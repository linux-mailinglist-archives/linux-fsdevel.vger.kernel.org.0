Return-Path: <linux-fsdevel+bounces-11855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE18581BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1152A2852E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5A12FF62;
	Fri, 16 Feb 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dGZtRuXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F012FB0F;
	Fri, 16 Feb 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098720; cv=fail; b=c3XZQlrFpo8qv3yArOwg+n68GenJgTj0l1hf81xgoUDajZEB1nAW5SqT6nnyihChf77ao4ZKVe2wfK2C7VlFnQcMegmqcRq7WfXT2MSaZifBBEOf0WYdKKB6Rtel7o+5M0SXAW0E1WsFpo17hZbDZVoMiaq4GLHkpZT5BZavXh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098720; c=relaxed/simple;
	bh=NGmlIfgF2DCWNjDg83xjWU2cSW5oXIHHX4XB3dJbrgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DtIYCV6Uv33/n8GQBRt9O54PljgSz0b343QHC0FCv8Ok92baD9jLOufS47GgXaGKq8/iDI7NwCal+pMDLdMwpBrax527Ysjfd1jYVFRaN8qOQvbI3FV6kkxkGsk9e193ajp0ZjIgz7WQbUt3DV2oSMjH/g+p0pSc4ege9SG/xTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dGZtRuXa; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjWS8OOtMQHT+BnFizzgzih8k2wldjIhiVBN2DrKTBuuah2FBAjOLQhcCuW8Dw/qFd2Gz7GmSi5UKxKs3pYT6SYfmLUSjSWvUPXDP/c9FLBBwYtmV5PRGeGgtjbkYH4Cxb3UhVoT+SvSwLvXvFV+M9WXGpMl+vGYwDpNwaAV6TQEvK4Dx21xosHcMdHEOlhhhvcfJVgKDDKGkKWXyxnuJHFytj82UhX/WtGQTBxyq95ht4hAmPlhTM5FnKkjfbuVxWNPa0UpBWYbgmTxeulS4NTxyNcNCL7Y9LAaJIl812vvaLZLlbsA0rT8ondMBLGbBcyq3sUHVxAhNN7Zkp9ejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XYjFfo41TE6OBSn7Y9rZi4QQ2qX5vj9iTylNRAuCgw=;
 b=FgE8plFYlt0YLhh3mikg7c0kUckTldlkzsCEtHdlvVZq5mT/b90JSZWWxPkNIpIB29YC+uJu/muwTxCGWPBvetED677vI/6E7Kyz1QNBYNZiYE0Xr+SCLb5Qoc+1EvODWh5cZFGzvyMUAMN5B4W9BTw44fQNPjAdvaztyRTA1QtIjJOCxMd0fI8/NavGIO3lbhGIUow8ivzB2F6ucOUgkbGiN+wK4VwDvvy/urFF7260ThcQLFD1eya6mMThjxYjzSwwvexblLTV68itQBt/MCOjOMYhTeukQ4NuZQfvg9J94gpcSKFYw1wWpHCjdaxPxQfxtDCLtu7Pq7UwmVWBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XYjFfo41TE6OBSn7Y9rZi4QQ2qX5vj9iTylNRAuCgw=;
 b=dGZtRuXajXlnq8EJFwt6HXnZfjs7pmzb4g8YbOyZ8v2Xddq6CEA0LXyK86J69RNCPgG6cGg+8+7/ZdJ+wYklUtxXVoS4dNSzn06rUO5ybP+GYMVNrM8KBAuB0uf2PopDz15f8e+UPYdemNqpA43/zrGlFRd/XIhZ5be/7JABwB/Q7GbcO4VMx6RvE1SkukDHKM2L7s3Z6XZWrLxVCx+dtvyZZtZv8b/ud8qZIYk8pqC/L9m+ZXkJ0LD0V4JHhLi7DzMFfNtg2v9UdZiltHT/qwx1Zkiei2h27kG/jwzrI9akG1U6SV/w91WL80/p5J+7YqAop+DVdXR3c1YCw13zUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.15; Fri, 16 Feb 2024 15:51:55 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 15:51:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>
Cc: linux-mm@kvack.org, "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
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
 linux-kselftest@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v4 0/7] Split a folio to any lower order folios
Date: Fri, 16 Feb 2024 10:51:52 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <B91FE832-74D3-4E47-81E5-7D9415CBA4BF@nvidia.com>
In-Reply-To: <dvamjmlss62p5pf4das7nu5q35ftf4jlk3viwzyyvzasv4qjns@h3omqs7ecstd>
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <dvamjmlss62p5pf4das7nu5q35ftf4jlk3viwzyyvzasv4qjns@h3omqs7ecstd>
Content-Type: multipart/signed;
 boundary="=_MailMate_61B88F8B-B1FF-481E-83FF-9A4C849C0026_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:c0::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7814e7e5-9031-4c34-07a2-08dc2f073309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tulBVKzmEoGVCK40673tMCRuxBSGVGhnJs5EpHqOkiPv7oc8FWBSKv7DKChTj5a7ns/JL2B2K7kxk8G98ftLr5QoYOwRIgCLzSmXXIJTYoSWQkyLmKkPcwk/16035+gGj7xem6qWEypcASUpTfjL1tULFEj0IksyjtA8q+ROT9JrP3x3OEZuGb2H6Gmsucf1t/YjYu7Fgm2ajwJS0TBSJYIXQZUQQN47ACB1oKAyisypCvrjmbsUFsbkeg1rscYQd5WoudSUhJOFFti0/V+OGQz1ykNpvvOktFXmuG5DFEDHsAph0OumeDIt6JhuppyQeSSwwXHWHk0g/fXE/B9NXPQtXGnTs87w2xvO5OJwXsjE/YSVLzTxpjkS6BxG4/egTZGOv5urdf3DPgzobBJ0nXJy9laCuuomMtyTvXVO5WJYh5nVbLqMgsD+6Mwxdk2+1COOcISsFHScgQ5abFd1emU7L8tEZsbYhfY8w0Tst0xeTuSkz9O6Wt+my4CdFjFPNVabWKTy3aSB5Nvl541ErU/R/JcnUq4fCFBqqu3fb+QOivJTMgnVb+m7YQGp133K6l3llsFhEvgMfWBJT4stSB8idbn+zsNCUQ27rPhG7WI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(33656002)(36756003)(53546011)(966005)(6506007)(6512007)(316002)(6666004)(41300700001)(54906003)(478600001)(83380400001)(2616005)(6486002)(26005)(38100700002)(66476007)(66556008)(4326008)(6916009)(2906002)(8676002)(8936002)(5660300002)(235185007)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YlAVJbsur972u+Nbr6cLYE8yjIN77Mhr2W/Va4a9iZ4f1J4g+F2wac/Up97k?=
 =?us-ascii?Q?CIfhwRjkGFk5Mn+U8kLg6mLYWbipa/kiRg/RSkgXVss+IiMaF5TlJjK5tSK3?=
 =?us-ascii?Q?VZUc7/zAo5U8PazKTsLo/DZ5LGLb29cPOW0FKdgXldqt8puby2aRAR0pi3hu?=
 =?us-ascii?Q?cOi9VnaxGBIBuhal96ruGYW59kfDWhJOVbttGfI/UrVjrTp0S4vzfJLnM2aQ?=
 =?us-ascii?Q?5YOFdB9DHO5bYjTq5MRCD1ZXwFbGMLMn3vGuVypuK/2C0JgScF52YsF4XdVw?=
 =?us-ascii?Q?/mT9+QIPGA1y6aGEeM5JQ3Qz8G8j/D0un+CDNJeQzEDyhiWqXvoDbtHuwlif?=
 =?us-ascii?Q?iQhFb0W7/eOKNBDamPdsYwA+6b+9/7xbgvba1xtM5/4LO0E+zDziAADzxu2W?=
 =?us-ascii?Q?8zTmrr58FavdsUK+TpSJLsvl3uU52cusuu/Yy6iibWOg1bK+SXYXH/MJIVf/?=
 =?us-ascii?Q?yRUQrVDYqK9kijbk802NZ87LMbwAFynur660nxuJgM8frhlth3BSQ1gmU73/?=
 =?us-ascii?Q?JiugDZrzVgS9EtTlmQL9talAX55olNHD8JyoWxYE/vNY4ykIQdio3DE1poT8?=
 =?us-ascii?Q?NV+wFPpx5TAVKxAqPLmbDsVqyuo1Edoa0oVyPQSvhEGhfTvOGqRT7g54j2yl?=
 =?us-ascii?Q?J+abQYvDOa3I2mK2Uavu8yaATA0rlnnr9a3qmhFCs7D0crDwN6CQCCPeDVvN?=
 =?us-ascii?Q?AsmpMl3wVOq5w+LZgLm94HMo1d2Y/dxsCNvkva2csCo88/Vk50LJknJFQgNH?=
 =?us-ascii?Q?uEtwGWUcoUmx1wLHMCvh1JBLmexmQlCTQ2lmt6Vp8h33YF8toBpH5PzvUWa0?=
 =?us-ascii?Q?gi9b4EJLn9PJAF4p0aORc7k5TF2sVIcbvBji2IHz3ctqsnl34/a6FhZYJygU?=
 =?us-ascii?Q?MgvNUu3LMio1c/GGACOuMFzqSRgBHJwv43Eee8KamPdRg67Ffeod74T7nDgC?=
 =?us-ascii?Q?A6Yy0VTKSiFUqxaTUQCa1FhRaDEhziqfz2uUlHtISO/Y4sKN/RL71VNSL2Gr?=
 =?us-ascii?Q?4gJAZnP3FWwlfY8nAUsxiGnxp+OJ9/LV52ReSyOt5QKjQtGMSDsxk/3NOuWR?=
 =?us-ascii?Q?brJnFu5d5r8NkjLeD3JzSi03noby8EUTW+J5COgmULjfZsSURoqTgwJB3NHH?=
 =?us-ascii?Q?k9/WGvtGnTRylWR4C1dBinmL2vrFr3jpc8iRWTue7XjRNTPI1PrDMUDLbwuz?=
 =?us-ascii?Q?bZEKfpb+GB3tjKvgQJhRIXpeP3XCWuSCJ+3AaVXCaVsT34VsHvT+mPsRTjVb?=
 =?us-ascii?Q?oPYbT8phFP5MxuABcPpot6Rj/lR964KSlFF3nUbfypFzFkrCcaME7ST2Vxrj?=
 =?us-ascii?Q?XujByz3dE0UfekIZywTRXgrM5/WOgjjOJCoFIosyT27q+EoLfHlS6eZVY7Wy?=
 =?us-ascii?Q?5bQ7tsn54QkhB4JvWUmAUokrpseRD4vNWCuJN8Kyzv0ST6CekgKSnfWJGQSK?=
 =?us-ascii?Q?8JmbYPAaChd5vAatE+WTz0kuosEWvs/Y15mRrgkkhi2LFMKI7pEgfQhoVNbr?=
 =?us-ascii?Q?HT3BzApwdx7cBKb5sDaW/NAw7Yv4KQYdlpSW3AjGSiWzob2au6nbzOM0iwcC?=
 =?us-ascii?Q?hlEgs6GQNWUfcAYGDvM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7814e7e5-9031-4c34-07a2-08dc2f073309
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:51:55.0875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBSKQYlNT3o4vEgKZMCI4WV+hJg5rU7s2hSTW4r9F8NBtjFDi2DD3AS9tlJQ1meL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924

--=_MailMate_61B88F8B-B1FF-481E-83FF-9A4C849C0026_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Feb 2024, at 5:06, Pankaj Raghav (Samsung) wrote:

> Hi Zi Yan,
>
> On Tue, Feb 13, 2024 at 04:55:13PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> File folio supports any order and multi-size THP is upstreamed[1], so =
both
>> file and anonymous folios can be >0 order. Currently, split_huge_page(=
)
>> only splits a huge page to order-0 pages, but splitting to orders high=
er than
>> 0 is going to better utilize large folios. In addition, Large Block
>> Sizes in XFS support would benefit from it[2]. This patchset adds supp=
ort for
>> splitting a large folio to any lower order folios and uses it during f=
ile
>> folio truncate operations.
>
> I added your patches on top of my patches, but removed patch 6 and I
> added this instead:
>
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 725b150e47ac..dd07e2e327a8 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -239,7 +239,8 @@ bool truncate_inode_partial_folio(struct folio *fol=
io, loff_t start, loff_t end)
>                 folio_invalidate(folio, offset, length);
>         if (!folio_test_large(folio))
>                 return true;
> -       if (split_folio(folio) =3D=3D 0)
> +       if (split_folio_to_order(folio,
> +                                mapping_min_folio_order(folio->mapping=
)) =3D=3D 0)
>                 return true;
>         if (folio_test_dirty(folio))
>                 return false;
>
> I ran genric/476 fstest[1] with SOAK_DURATION set to 360 seconds. This
> test uses fstress to do a lot of writes, truncate operations, etc. I ra=
n
> this on XFS with **64k block size on a 4k page size system**.
>
> I recorded the vm event for split page and this was the result I got:
>
> Before your patches:
> root@debian:~/xfstests# cat /proc/vmstat  | grep split
> thp_split_page 0
> thp_split_page_failed 5819
>
> After your patches:
> root@debian:~/xfstests# cat /proc/vmstat  | grep split
> thp_split_page 5846
> thp_split_page_failed 20
>
> Your patch series definitely helps with splitting the folios while stil=
l
> maintaining the min_folio_order that LBS requires.

Sounds great! Thanks for testing.

>
> We are still discussing how to quantify this benefit in terms of some
> metric with this support. If you have some ideas here, let me know.

=46rom my understanding, the benefit will come from that page cache folio=

size is bigger with LBS (plus this patchset) after truncate. I assume any=

benchmark testing read/write throughput after truncate operations might
be helpful.

>
> I will run the whole xfstests tonight to check for any regressions.

Can you use the update patches from: https://github.com/x-y-z/linux-1gb-t=
hp/tree/split_thp_to_any_order_v5-mm-everything-2024-02-16-01-35? It cont=
ains
changes and fixes based on the feedback from this version. I am planning
to send this new version out soon.

>
> --
> Pankaj
>
> [1] https://github.com/kdave/xfstests/blob/master/tests/generic/476


--
Best Regards,
Yan, Zi

--=_MailMate_61B88F8B-B1FF-481E-83FF-9A4C849C0026_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXPhJgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUmq8QAKb3dKOgG+uj8lhjo6HbqJgfHp8EeYYLdDQz
UBCwDNUyMsJYQzi8vXU/fSlGNSwStny4HAREd0nEnKiFL8Rkc/22I+XILurZcs1U
AO4imaN3qvjvDT7U0Sa9lkPS37MIF2e6V3IgofIybrBeg1GUZExvQsdSFAsJnfqe
qRlSc9CIG3ZtZ5cPkGxrRPKVAA7opAhKrd0L1ZfZSej+1gy/RXix5wTP9GpEU+PD
91Sq3iizVx1MK5FcTihZVS+JYqwV+tGcSm6/b3xQWkZe/cdIcr/x1t7GU3PIKgDa
al4xivQrbCkV3ahlhciHYAZqkSqew1iygED4t/cAtQFdwnIgVFIcLXKOQh/eR5Ib
ekdd9qR+Lqgg0q5k1DcYRsEsZcYdP6AI3LI6Mu5cRcsvR3l/xGlb/cnNYgLOFExo
quU4Mn0Yr8M6E30AX18FtmNA5Uv7La3mmHiFl+Km9heVFQFhd/hrATFxl0gXzmxI
1c0fJ5oYygZCAes3zbcuwaWq4LnSw/gtO9oyfSiVLGYYFIK3BOyEe1PPqfoHaOVV
a3/efcY/YjI8yUYfPIXMBSAMGfNwYOsL3xSLgZzvoKCYFq9/H2zThEjdu5bxb9rR
Ms2TkO+/ROYiiCQR2ac5iZEjwrrkoWan/T6dfyxnKCNnTPrsCMycFPQO5NI6OAPP
2Argdp27
=DS5m
-----END PGP SIGNATURE-----

--=_MailMate_61B88F8B-B1FF-481E-83FF-9A4C849C0026_=--


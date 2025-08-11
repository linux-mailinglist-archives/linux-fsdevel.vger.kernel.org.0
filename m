Return-Path: <linux-fsdevel+bounces-57417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ADCB2142A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C01B3E3A38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30C2E2825;
	Mon, 11 Aug 2025 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KjKLS/Dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94D2E0915;
	Mon, 11 Aug 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936326; cv=fail; b=kmMHbf0MPmDb2BMV/dTFg6RRjCrzzODL0+C9TVxLQV5xM0n0Z+Y64qZ3OdNtdEPU9lsOPPoaCnpv0+gPpgntl84AHlW3yvALVg8QA4QegIF9erBewxrn74ue/tfLEWYk6myBWXTONPE17VASggCbNY7qCpyxFjOuptkNqzumGlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936326; c=relaxed/simple;
	bh=pzQkZznXTA2Bd/jIWUpGlZFqGAtlla0XlaLr6dh6+08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i61GbCzwze80yQ13E1qV4qfgzq3LuShyeECPsQAJKEampTxee1ofSDExPWsgcgbxhP02xhgP818wrIFT50emCwhFxOUY3byik8zlFqPQMm8cwSqNL/F+2vAqX3R805TXLxBRLNOxw2HwDLCn32KUOsyj4S30+gCWCNR7wfA6jvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KjKLS/Dr; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyZqyrIbVgnBmuu6QHKf202xwvOoNC+8mES8fe7sruP0QN9XngQNvU6cjlY6M1k7anQ0HOr3oWmBWdeNyole58AwoLxhl4BamuG2hb8jHX4WCoEa+md6vNq4ZhbV76LfduWkAti6+X4UyuJGl1UDMBe9PNLB2+K329+6F8DnCMnOYccgFCbTJ5M0zutFvduhiSHOFrULXoYXaXBn9uWg5Ok/R2EbzEE1JcP+qBiaFTEf4fgcNdhU/0KY0sOo26Qo21pdWFIcqpL4OGCPyudpjJ3qBFfTC40HCm0ooybo7q/x8jzqUsWb0fHtMHp/l9zyy3hbiIWo84gU0wO7GPnjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbJqTzC1UIzdo+ms9ENliUvYOi6OT6zVj900iav1E+M=;
 b=nvE9nG6Q/MM+UTI7cIOiLlwPyTe2cYyTouy6aADap3NHYJYQ0rZ0+x07aUZg3430WHAQDtTJ38WdS497bvA/kWgU/2anCMCicTdSZC7UsGZhQTCNRKzTHFemlA5ocK2jhCTbL48ei7X/GYJ4H0zqL0lB9U1LRBLnHfGQUA4MN56Ay9++UJNYJQu4I0uX8+EDG/1LgfIb1NBk0Ic7MbDKf2JXpfuL20ZhHz1iu7jL67cfdCErYRPA5leo8aemEosBGJD08we9djI7SrynCHFecV0rvJZ/2sVvKy7HCMWV2wIs/R1y6IN0VB6jiQqKHMbkVp9SXgzd0yeAAMCWg+Xj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbJqTzC1UIzdo+ms9ENliUvYOi6OT6zVj900iav1E+M=;
 b=KjKLS/DrnG8VrXkMmsMinNsCC0KwOu7YeRiF6aNt0H3nZExV0gapj0ah7F7vJXITGO8mGRc7M6/s4k0/frR/MXlA4woC26jCkO7fMrV9X60qNn8pezxhnCmxXXXsxjTyHM5+WWxS1GqXFzBmiqQNm6l3VBXMaTgO6YPDJzGftRv+8HUg3Lvd4QIWt/SyjLjS7qsjObYrfeyTwL/JUeosrjCNIw7AxLyqS0diOE/xRBOYYwuiiME27W7WvXxHJsIDejql/3Z/wcP3MNea0uwcjhRn39ODjnSLMLKvrPwDP0GgSjvAlXkypCy3KEWFQFQu7fMNbKxC5MfAhcfvGoVzXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 18:18:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 18:18:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Benjamin LaHaise <bcrl@kvack.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Dave Kleikamp <shaggy@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Date: Mon, 11 Aug 2025 14:18:37 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E26CCE5E-8198-4919-A38E-DCD2F65F0BEA@nvidia.com>
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN8PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:408:60::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 153aec37-4d92-4965-22a1-08ddd903807f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hbuE9OG6yJs+Pr9CJsUHGDYSZ0ghGt0reM+xyg3nU7XX2gCS1BpP9k+cCJgd?=
 =?us-ascii?Q?f4mGEulrttudJbM5sJ9Qpl/p1nVKso9XgglB3ReuUuELodoI/S40NjRgaKOV?=
 =?us-ascii?Q?tq6X/QspHflGOzCfZT3O0Cedhs7DOfvlcIfG6iTVOExe7yoC6iPea0vgtjeG?=
 =?us-ascii?Q?FpeDmArxHvsElG3zLfzhiu7JxUMRqJPPywbBUuyylYQZFCxmUkBuav4bH4o7?=
 =?us-ascii?Q?aY9TaUKLtRf9pcfq12K733MqAT8WrACYgqnFp3i6WUSVONlP9H6n3zjgk5qK?=
 =?us-ascii?Q?LHSqbgn12tJFKMhA+mAa+VdrUfysP1wiKgkR23kQQiCmSSHGadax5KzXbpYx?=
 =?us-ascii?Q?h0/c8B12bjPVHcjRmECGTTWBXMzgiZWeVM4VDDJrZcIih2/WW+4j26UMxPi0?=
 =?us-ascii?Q?Kshtr+rrMfIkdjU1PnRVBQUe+m4U2fTznFvL6HJ+T3FfZJX1EgA+q9O+h2dd?=
 =?us-ascii?Q?vrI5dSmkzpc4nv7+59JxYavp/CfMrQmA5BBvnFbx9ZXij4HeGoWyombF1SgE?=
 =?us-ascii?Q?pVoV3Elk1WOFkDiqI/KBdcqvCaas3cnEP6QctDkUsc0LkmKOUuNE/k8NBNfJ?=
 =?us-ascii?Q?pYoabMUCfsY4AsQGqGByxTD83GQciT39C2ABbGQL9i7rXApAP85gRI4NWuer?=
 =?us-ascii?Q?jALP7cIYWBPSTi58yO5t+8OaAkQ1eIUCc7EKgs56kmrkmsZAHQXPp00qJVZb?=
 =?us-ascii?Q?CRvz6zBwNzQ1BudbUlOooy2wfrP8QHQQJn2f327QZcb+B1A+vvHx7xg8001+?=
 =?us-ascii?Q?VnbOvOpeeX/Pb2vd9n2eDOS1o+mn0WzVYwJ5LrunGyEER3MLywqEaIDKOJxc?=
 =?us-ascii?Q?Ql1sAs9UOWz2PToXcj5TExl7xVP1pPAVBsAujYjjJPoBqO24GFMU5rYKAjkS?=
 =?us-ascii?Q?HRXbFiBAnIAkHT9m71sYUuNQwY7897PROoHLUVTEi3bF2S43HnQMenxZdIPd?=
 =?us-ascii?Q?kRkhgHSixbgu8qVU9GdP1GnZqOM95SFEEzCYmN/bEiffk3eztPbV0npk1rfz?=
 =?us-ascii?Q?9ukbEcLjX7a3XfRU1I7M0l5kiE7A8famOgfU5MwXh3jHowuSWYZqd9L99gl1?=
 =?us-ascii?Q?OzmbDHXYDxtPvTbEu2ogtPNfgrEgOdz2mLU1B6ZguULEOEwfozhX22exfPSN?=
 =?us-ascii?Q?DHw4wQfVJkgySfZyzS+qs5IkFH0pTtSx1XgzhHK2kfC+QG6IXqM7OW1Mz+BP?=
 =?us-ascii?Q?xwTdozBjE96T5a95AGf78RqWQfI4rS7lMPvKVcPWBpq5TJQgLA5K7bwW91Oz?=
 =?us-ascii?Q?uTMZfKR9FVmr/C8oUAbTL9c1NSva7vlwL/ChLkz1lBY0hPd+20EOSEBJG6vG?=
 =?us-ascii?Q?M5AaufkDXsqzPdpP6sMvNBcAJJ9JA57fwqSB8defFOZovS3dP96pns9uyPfh?=
 =?us-ascii?Q?GIAWkBTkx73OtL5Pi+nA6UKHWGHRbu0mckJZsYdKb5vgVjHnY2mQJTNOS8YR?=
 =?us-ascii?Q?jpdh5u883zE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?osXqi+aisRmQzqnwY6QSeMi5yq5mYRyeAkSd634R6f6vRobE8X6D4+fu/2OQ?=
 =?us-ascii?Q?5O9OEnV5Oo+s5Ep67+O0Z6OjfC0w8kZ2ZS0dRohBPQA8gs7Cn4X2y2tbXJq/?=
 =?us-ascii?Q?9mGVKug+RV78BYR0IoZxJk9M06DY7GM4H1yh+jT+fJWaK2orb4qG1yGEGkNi?=
 =?us-ascii?Q?Ma5cQfEq8hx5zt6d19VtZojVii4H5MgjH5+A5sNIE72UZs655Fn2f0dTl2vA?=
 =?us-ascii?Q?OnLP4K2nPPZAnLivkgAdEJ2xskovSj6KwIh5XJ3wtlF/00CKydCzB4Lh58Zt?=
 =?us-ascii?Q?lKqoWJC/XT+ldsf+TT4Sle4RxJy3HIrdbaP8rRC6QjilOQcrJwrkicyAdUMg?=
 =?us-ascii?Q?dpAVYlcf9A9mlx3NI/scXEm5yCkm15AHA1hfOpfdZQN96f1rQ9bBYIWjD2A+?=
 =?us-ascii?Q?eJeV9nytcJve/KcSyhQLHdVlW3rb2P9P3JyrHwkGKoaRPCt0WAwGQe9v6rI1?=
 =?us-ascii?Q?aqc90I7qjoXg4RBmf9mi/mPTvoS74dokKYw1/mZ77WXinA+T94qMXqOSpPKs?=
 =?us-ascii?Q?HHqZdzLAv7Eqk+XLWm+OCP43z4DXDQU+RfGcflJJ5KYedl9uiGtFKvZdBj1z?=
 =?us-ascii?Q?hHslljVcLvzGClYuz8L3nytngOLR6aCZz0FVG08tGTCGPI1HykA0ll4IP/ir?=
 =?us-ascii?Q?p2Wxv9YMQ3z78JnoHNmrHEGzZ8hDD/R/upRC0+f0+whJvi5mpCeqYq1VXDnV?=
 =?us-ascii?Q?Jais0yBXe29dLB4T8oBWmr3U6G9eo8tQFb/PU6LY394oY+YsJvHS0mPqv+Kx?=
 =?us-ascii?Q?HJFUiu6Mgn+QhcLlLiQMgTw6vhq9BQsW1mGKaU79Xh3zvNlEhyURZ9SOpCiv?=
 =?us-ascii?Q?QPDard2nm1JHw/axRmWjwbyubMK8tucjTZ7mCIe4MtLEQH0b4J8aLpXtN2dB?=
 =?us-ascii?Q?vwWyVrw5t8ZPmZexHFkN3z1b9pQ/j03nQHtqKworZfSo4MBECudJABJytvgZ?=
 =?us-ascii?Q?1/Dc8ubvHV1+N/X+WFjJ+USNPlWbac1FS1qBjptxQlqXr3RXLSuy1l0Y0/NZ?=
 =?us-ascii?Q?5BsIsfY9Kuip9/AWoPRp9uNiD92OlF1Sb9waqm3bKSMqggNNd6DnM/VnI6+s?=
 =?us-ascii?Q?cker0P+H8gPwW2eS4tgg2UflWpYJYdhVAmRi44SHyjMZrLdWss96qRpaLCHy?=
 =?us-ascii?Q?ctB7FxahJIq4WaGAm3EERJEoJ1e1baSou4xzPA/8g92lhLFdqiVqy893mBT4?=
 =?us-ascii?Q?zap56gLnagD5SSNbyi5pTHX3zfHbm89k3UwHKkwXOtcvNMA0HgU6kHji17P9?=
 =?us-ascii?Q?tMwhVVgWVpU5XVynJF051A4y1mEUr/+NVC+bUY8YakJshT9eV0p5kR+HKNoD?=
 =?us-ascii?Q?RAEUS3T/MSlcCiBog7xLqR0J4Q9uL9N8NODzuKVvJD6kKF6/yRMB37e4xd+B?=
 =?us-ascii?Q?AKIlqMoXNMSOMqg/5gWdtwq4Tzwasl2z7LiJxo1qH2DMP0s+Krcwc56KX2eY?=
 =?us-ascii?Q?WbP/OrMaaA6eU2g3LMYWa0DbsStOMZFqaoAa3LZeUGiAs6u6K4G/zYvo6uyj?=
 =?us-ascii?Q?OLOT+SKZ4F+UVHoryxPmvPcyr+IQGrTbK0guEBmYljVpEaRwVJZLV2F3/Uvf?=
 =?us-ascii?Q?ee4jmtCjwGn1/eZ2hul+nA4WSY+OpN2hh9tupvhL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153aec37-4d92-4965-22a1-08ddd903807f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:18:42.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyiUSeA7RBxkch5hSEaQBtnTlQ8xSqer34TMHxD406jYXw7SqdC4GRZDfdwS97us
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On 11 Aug 2025, at 10:39, David Hildenbrand wrote:

> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
>
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c |  2 +-
>  drivers/misc/vmw_balloon.c           |  4 +--
>  drivers/virtio/virtio_balloon.c      |  2 +-
>  fs/aio.c                             |  2 +-
>  fs/btrfs/inode.c                     |  4 +--
>  fs/hugetlbfs/inode.c                 |  4 +--
>  fs/jfs/jfs_metapage.c                |  8 +++---



>  include/linux/migrate.h              | 10 +------
>  mm/migrate.c                         | 40 +++++++++++++---------------
>  mm/migrate_device.c                  |  2 +-
>  mm/zsmalloc.c                        |  4 +--
>  11 files changed, 36 insertions(+), 46 deletions(-)
>

For the mm part, LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi


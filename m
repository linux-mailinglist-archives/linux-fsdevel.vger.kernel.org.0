Return-Path: <linux-fsdevel+bounces-44092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36163A62030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD61119C62A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ECD1DED5F;
	Fri, 14 Mar 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8AW2okn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514717D2;
	Fri, 14 Mar 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990889; cv=fail; b=SXBma07ahAKD+RLeGJA+eWP7wEf8Bi/9G/AjmQP9FqSOhxL3kPKJq7DXfAU9MpDmJ/2yKF2x9ybXZUL9KktPKdbQ3JJYAgYlEURVkJZ8ylEyPc2nh78KPFAxmiFTkGuWojkwzO8sZx2t2X6PHAyQnaXtb0gtPoGFkQgEjZu6pNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990889; c=relaxed/simple;
	bh=pDxP+zGwbb669+UbYDNmDTe9K+3TR8Xo9KeeMQTCEJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D3PGev02rPZcSrsdov4xbVVt7CV0P7QpHIMeJOsP+fOOFTEfA06GFqwUd7I3OutiQfP7INDPsxzKRdz5D5D2qpmL2LYMeuvy03/8sYGuw75g6l1+Y3ab3Kszi8zCPHtr6GFH5Bs40pU2dICp0EwKhxiio9bWu/pAAxGf32dCKfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h8AW2okn; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWxdQ4qWXPclJl7ekgmY6DUdxk5hHzjCW9b8uDFyFCGC1vUbMyzdnZN/EizcJYlXD7d1mhVM5HjNfd2eKGFz7cZI67zk8oarT6OODVX4EQdBq1rJnwZTOF0jVGk5zks3sIj72mRkNTi7qluLRaDrQSuJJdIfD2/cH+4TuPOQ0yh17Jk4AkIU2maY4hi7LOv7r1YSXZU0cJCe2YQrHvjMWskLGq5rJ5CouPdtofN/4lWW1v4Rz8K2ViSKUXltT1++bM6BIyl431yNfQTXZVlcJGKoNUJaBMhJX3RhBwB+S9A6gA6pEyic2LaSJoioeS/olqK7x9SNRCr2llKFWwpMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeBzsEdDDfEt7oKTOlecD0ntFwlcikesLwp4nAkCOVM=;
 b=c0Jf/ATyXpF+iQ5BATx9pbpE812opqNhHA6v9WHQFStq7s34+sFGxEr6k8ES5sl170+HaBL0a20ItW55kR0s39VfLPtvaLtTCzPtCrrS15bmkgZAy1hak1CgtdT4GfkauTRGBGg6hHLvEA6O6jjMF9UD4cYRsUzJ/0wJ5+R5hAbch8Qb8S+OsoEX+r8Tq+3ISMnJIgWzmonIcNlcu4GvdT8YyrXzhxJBDP6NGFIXMpi1TUGiU5iwnrerveZIHt4QkRqJB63q9PNvxEIVmEAqybpkvPvY+hYm1egvmxVo7Wv4rpEt4gBTY0OUZg5cHB4bfyeP6B15sVIzJ1aaTVF43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeBzsEdDDfEt7oKTOlecD0ntFwlcikesLwp4nAkCOVM=;
 b=h8AW2oknkw/uWAtDR4rwEsKe4CS34EEKzRvzDdnElwpPulOxKQvHmEdLD6N4MJqCLcVjoPfY6bLFBXXSflt3jPt+I4rQusydukromp6eXe4muDx+hu6z3+VZw2LyoBHOHS41waAJRQsTgFyS4noR7C0JcMsj8Lb82cBuIj0OaYdeB61ArBl1DAAsITAH7AUYyxWdEJpnPoe683ehVMX0tfaFiVYn5n14zQ47tTYwBjCUcb6g38JIx9K5+DEmMLhqX3cZjkZfAszou8fesBYuSuATctDY9uKVlD6SCE3UJCkdkNVIhcLin7VP1Gha5pl/mKi87oKmsBRTdrCnHjq4kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 22:21:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 22:21:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RESEND v3 0/2] Minimize xa_node allocation during xarry split
Date: Fri, 14 Mar 2025 18:21:11 -0400
Message-ID: <20250314222113.711703-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9181ac-5522-474b-f8cd-08dd63468e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N2uSlgAEFIUQl1DNzh8n7U4MmOOgZcRyOMX2s/IHKBWsDt7KwFx0qas7rKUp?=
 =?us-ascii?Q?r8msw3qt+dcsNLWXOmQj6Y8TgRw0OwXwo0jQUZeb6z6R5W6DbKtTFgjrCqcg?=
 =?us-ascii?Q?36j5SkahrO5elZDIIej8zBeSyySTZHNNgKnBNWsAkftXv+JlXakXuw6CKJrc?=
 =?us-ascii?Q?AQEv6HIpm5QMCmSXOnEnnIkyI3N4yALdPYiVcfrwum/oeFisr0KoyB1Tx2h0?=
 =?us-ascii?Q?57KHWe9nICdr0FS0UElWB+0XgoqdhpZE8BtrcKxsQBnverKcnW0/S6FnIofH?=
 =?us-ascii?Q?z3nXWbBivaBs6BLmG2Dnyk8aEr1RwUIXo/1niBT9mV/g/SjtgbWlT4dv1mT7?=
 =?us-ascii?Q?dgTC0kofhsqPWUtz1eVqUN7KIWcCP6j7yni6XWVDaYagZx/xpiE4lyFFMl5c?=
 =?us-ascii?Q?S3bwUzPY4DOwm0rq41dSw7RsAwc5gGmX50qwCkmSXUixcBXF9JqWCJWCg7Gy?=
 =?us-ascii?Q?p6T4EZfaOItfEBbarMvI3oEWEjfobzw5wKUbcAnNkQd3KHAo+LrO4DeJGyN7?=
 =?us-ascii?Q?7MV6cwgm4P+DKJbfcRPwTBiktOdCjTGXu4E4ZXjnvB4QjN21+Y8ttvYoXfDX?=
 =?us-ascii?Q?DkMpA9kEkeSHryEbWd+vO/T2XhK17uoXLu2UMC5TgYjkG77uQalBc/X9ZF/o?=
 =?us-ascii?Q?p7s921HOK7GJDP0T1D4OxJpMTzLIVaaIJuHkXPYHEXiiOH0E/8SanGrbZL0G?=
 =?us-ascii?Q?p67Y2aeUJ98SRdeVgafvLygSKf4MVt7tjg0sHncvac12kSstXE190Rngn6Hi?=
 =?us-ascii?Q?q4hRkppKr4B3jLAZMq7yOcJwdVcm0QJZ8Ak6XI5X7QWgA+UZRt+ZzOYO5Vf9?=
 =?us-ascii?Q?yFZlY6nJjZrLBC+IxZjfIQWPXZOnZ6vCggAsqyXE4+YsGA+uzUy0aJs5eZnr?=
 =?us-ascii?Q?Qtm5uy5R58GzK0JLwQCZknB+e2dhD6fmIJWGu4TiC9cVku5WD2B+JyILJOId?=
 =?us-ascii?Q?Hp+gBOdii7r4S6tSoDQUJflp0Mw3WDFiHBe6czsC75u6R1aFwb39rLxe5A35?=
 =?us-ascii?Q?mlMbpUxi8M0ifKI6jnrGY8v32CDghUd0YkLYdT7+T3CIhDgXs9Tm3TMUr39P?=
 =?us-ascii?Q?SKhqnZWXoYr4k2P6GF8Zrd1CZCdp8ZiGHk8Sm46AmWK6pgk8KMf+ckjFOc1j?=
 =?us-ascii?Q?l3j+iX2qfWw7jJ1VAvlPdwZIie50w/JW3MR/bZFeAIBHezyHY7hNCdu1Umvz?=
 =?us-ascii?Q?Lz0IzdfIKYb2k7JDs8YOlmZpj4eshQLM9LANhVQy62BbdkRooyeUBMOJJav9?=
 =?us-ascii?Q?RTwM30iB3PoH/GZPWviY0iVp8JCiWHhP6nHXwZFYXdUe64DA9lvjyBU4nPbs?=
 =?us-ascii?Q?7CDYdPkplf0PWqCy0CgYZTZ2xyo3gGCn4RX7aOiIPWAWtzZJFTzmcMXlbSVn?=
 =?us-ascii?Q?rfnUnBbCjC2pUakjfMrPSU+NuO74?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEABGL3vWADl6TInEpPLmUblSaEw6DMopsARL305w2XTImD2awvIpQerogO7?=
 =?us-ascii?Q?DATc5WQKEPIGaaKJgp1oVimJPtEEgiG9/Egh0q498M+X0l8Hb8LcOBiX5J/e?=
 =?us-ascii?Q?hLFSaKVpk7QD2SwDAs/LH/vZXxz86nN9wquutvFNCMQsLE5ESYyAEK4c0hUb?=
 =?us-ascii?Q?AF5kOPinqQ6o9descSkUNCna31irGkRgZdsLexo7k0b1MAWbSMQHhm8QM62K?=
 =?us-ascii?Q?99K1kfN7OxXAU8iFrDI9ZwNUfmTOAOcPnpYcQavNg8YGtYK32qSwen2HGPDR?=
 =?us-ascii?Q?jEgXZ7NKaUB1iLR2wIwRGuF3plmrDSAekvDMZEDLppnkz4lKnectGVF+ZFkz?=
 =?us-ascii?Q?smsfYputBQmt9rV4x0yPKrZMRvEqhnBq5R4U6xq246imip/0yzb6NAX6T/dr?=
 =?us-ascii?Q?k9p9/Gkn+Zd1SYHeLGOlW3dh7pLmD2g9X9g1vhHndXkG6gtqkDFm6KVbT0WY?=
 =?us-ascii?Q?jvB05N72AxL2q+kUpug/2vp4pZn+ArlL5RAg7dWftyzW0bCXoTE6A/pfg/Eg?=
 =?us-ascii?Q?q1uHwZvDFktdPWrhCTDycnswJXN6dvMilRI49JMkRWe8VR3/QqMXS8fGueuf?=
 =?us-ascii?Q?gSiQn5njDMjQmPmWLuCYNee30CF/I06Lec+eplgDCXDscy3X6CHFX9jaz+7E?=
 =?us-ascii?Q?tuyQ56y44Ffi4efpl3TSY98wnfO/PPGgxroJQ9YQNvEP6c1tfxDxH37Gyppm?=
 =?us-ascii?Q?gcYK+5o+7C2t/xSZAnrrJvqWJuwpDe/5bGBTbwq/VS432ygLUVabjdGIeNea?=
 =?us-ascii?Q?v6LCMmrx8+4GY5X/vkgP70XduE77memoja9MIqesL/DQ14QNKkii7KjR3Ud6?=
 =?us-ascii?Q?xQg15rj78uJ+kK60gHJR0rDiGIPhyanImSC0Y9WYzW1sp1FercJFOwWKQ9yq?=
 =?us-ascii?Q?E/T9uMffSO6r7Z2rGf4PzpUtB4xM/cuM0EiFNh2D0Rqt+1JZlRcv1SN3U9QS?=
 =?us-ascii?Q?ay72+yfzm2xn8JCOyKnKFl2yiJAfkBOJtB4yXrRm23VjD/fveyVkIQAUrR4u?=
 =?us-ascii?Q?LJgKFSm6s5wvgRiJtRA0SwUZI3FE0ahmg/4o1pH3PXciTfMQAklvhcB/e4lw?=
 =?us-ascii?Q?W+TsK61iDbTKyq1VjVzt6eY2c8TOAhRdNIv2y9x6X98Bs3RGztO/fRdHR42B?=
 =?us-ascii?Q?LHib159EO3JWf1cuKepiuvzrJOOSPe3qkwMsxuardo8spuz4G6bmMyrJQtmf?=
 =?us-ascii?Q?6tNFpoeMmcGWL2Fx03nCw7XNj3/mAwLVnL31h9YTQBOPVMTSuVkrvpYtGl/o?=
 =?us-ascii?Q?YBaaOj9PNNWRO2iZnDzS8RuP4ukjrsVz2xWsIGEi3Wulz9CezbaGVpK+f+m/?=
 =?us-ascii?Q?9E1n6xfU5gVV/gw4IucsvUvqKNtyuDMOfwYI3dn4UZ3gVbfRVlA8b+4z61rY?=
 =?us-ascii?Q?lpWT7gFJzAPpuUKiQ0tnqWl825YazOb0FNBxdzaB3eu9+vYe8z3JiYOD0N5m?=
 =?us-ascii?Q?45BpYx/seDlBtmc+x2j8lQL+KVpVqEj5v0094iFt+/4AX5ckyKJPS+Ik2wa9?=
 =?us-ascii?Q?/m6l4DTi7pn10DsB633fE+VDQlzCNrYMWXhuTfZi8Jiv6BbzgQ9AEmYmf9AL?=
 =?us-ascii?Q?nAmD05cLgbC23FePp2Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9181ac-5522-474b-f8cd-08dd63468e2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 22:21:24.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuptffJdA/BRsM2Er8C8VVsnKTfeREC6zUD6g1WdLGvGZ9Dkz0JN3Q6I8QEd3RwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

Hi Andrew,

It is on top of mm-unstable with old V3 (plus a fixup) reverted, so that you
can replace the old one with this. Since the patch 1/2 on mm-unstable
tree is not the same as my original one, which caused a compilation issue
and would confuse people due to a comment is relocated incorrectly.

Thanks.

When splitting a multi-index entry in XArray from order-n to order-m,
existing xas_split_alloc()+xas_split() approach requires
2^(n % XA_CHUNK_SHIFT) xa_node allocations. But its callers,
__filemap_add_folio() and shmem_split_large_entry(), use at most 1 xa_node.
To minimize xa_node allocation and remove the limitation of no split from
order-12 (or above) to order-0 (or anything between 0 and 5)[1],
xas_try_split() was added[2], which allocates
(n / XA_CHUNK_SHIFT - m / XA_CHUNK_SHIFT) xa_node. It is used
for non-uniform folio split, but can be used by __filemap_add_folio()
and shmem_split_large_entry().

xas_split_alloc() and xas_split() split an order-9 to order-0:

         ---------------------------------
         |   |   |   |   |   |   |   |   |
         | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
         |   |   |   |   |   |   |   |   |
         ---------------------------------
           |   |                   |   |
     -------   ---               ---   -------
     |           |     ...       |           |
     V           V               V           V
----------- -----------     ----------- -----------
| xa_node | | xa_node | ... | xa_node | | xa_node |
----------- -----------     ----------- -----------

xas_try_split() splits an order-9 to order-0:
   ---------------------------------
   |   |   |   |   |   |   |   |   |
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
   |   |   |   |   |   |   |   |   |
   ---------------------------------
     |
     |
     V
-----------
| xa_node |
-----------

xas_try_split() is designed to be called iteratively with n = m + 1.
xas_try_split_mini_order() is added to minmize the number of calls to
xas_try_split() by telling the caller the next minimal order to split to
instead of n - 1. Splitting order-n to order-m when m= l * XA_CHUNK_SHIFT
does not require xa_node allocation and requires 1 xa_node
when n=l * XA_CHUNK_SHIFT and m = n - 1, so it is OK to use
xas_try_split() with n > m + 1 when no new xa_node is needed.

xfstests quick group test passed on xfs and tmpfs.

Changelog
===
From V2[3]:
1. Fixed shmem_split_large_entry() by setting swap offset correct.
   (Thank Baolin for the detailed review)
2. Used updated xas_try_split() to avoid a bug when xa_node is allocated
   by xas_nomem() instead of xas_try_split() itself.

Let me know your comments.


[1] https://lore.kernel.org/linux-mm/Z6YX3RznGLUD07Ao@casper.infradead.org/
[2] https://lore.kernel.org/linux-mm/20250226210032.2044041-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20250218235444.1543173-1-ziy@nvidia.com/


Zi Yan (2):
  mm/filemap: use xas_try_split() in __filemap_add_folio()
  mm/shmem: use xas_try_split() in shmem_split_large_entry()

 include/linux/xarray.h |  7 +++++
 lib/xarray.c           | 25 ++++++++++++++++++
 mm/filemap.c           | 45 +++++++++++++-------------------
 mm/shmem.c             | 59 ++++++++++++++++++++----------------------
 4 files changed, 78 insertions(+), 58 deletions(-)

-- 
2.47.2



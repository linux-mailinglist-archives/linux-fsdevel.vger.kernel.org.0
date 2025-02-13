Return-Path: <linux-fsdevel+bounces-41622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500DA33650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 04:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CC91883E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 03:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF222054E7;
	Thu, 13 Feb 2025 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNKR/mPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D42046A0;
	Thu, 13 Feb 2025 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418250; cv=fail; b=pIkMnWfJtcln/EIceoIp3B+BLfxSicGX3Cf+pfXJ74VexKGFXXpNpG0jWKZq+JZ6i0UJYiDDJOkg4HxBwoQ17TliPJ5eeagiS4uNgjgzac33CgV2lw/H0A46/tLaNLtQRBFKEWo1+7BUmmBrq6wna08qWy1QJuf9XSfYsXOugto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418250; c=relaxed/simple;
	bh=ZhXrQrsnZMhTKpSb6NwG81Dd729JZhO63Qy/8V4xTDU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XfA8hwX4s1H7F3HI2ydmzkp7ua6jkF4aI3bR68OdlkebI2rIiQPF5Tlqp57xQZ255ZZzTZweptqYyKvgFqyKpczv+LZMuMuZs+37zmtVs9rLoFVmbpOO3fEQtlCqfhpUZR0yG/CC1YnTpfY211/g6U/6/hurcPyCgYG41cM3Mb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNKR/mPT; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOfDiZafDv8S1gudP5Ky5/gU+UT/RojfjkvOLerVVuTlPh0F44N+2k+Mnww/hknRHJs0A5Xdgwm2qlfTCoufg1lWCGS2nhvI2cnIkQ4GsSz/lIBdBvlUnS3yB+FG2U9oYhjcdISjI+dCsfeBPWBJQLLYDtiavX5o6NR8eiWbg5TgWUxdFdaOAXiyextXRwbVqYU96+cKOFqreDaegrh/Bm58OqaCSGPIiGDfMPvsyfjXTLS24v+KX7+FKkpHDRyNK92WVoIOItFkFOb6dbiddNuXwEjjuo7tnB18l0H+qH9fKcHrgSddFWPOqYW0wMvGGwLFdrvqxfTUdwYCOQs1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VInofvJmKEQrkuI9e0xkzHXnPkIrtJJSW7rPPx61bN0=;
 b=QLBeDE3kIhWLbbM65zBQ0gTwoFAoT0LzNOLDxKSw/oPKelj301MwF329rpZRn/MpX83By4iGSc88lGBqh8hbd0RiO5t18hErildoq4/uL6UrEJHfH+PDwOmuYbpI5NyoxGztOOtPVLYLb3skn7Bb5rlJ8jZ5+0tpmtOE89A7CnqTtxCYqmPQrHE7QsvVguU5pGiuAedmeF57C56GpUlf0Yr3ISbaAQnerUNJB/RT/tdJVwfrcP1sfkQaSnL2lxiyGAwWKCTssA83Ho8Q7BC10kRrF8po6VlQuD2/ZkwMabVhdej4RUzZhd+SfIJ7l72pw0/nYbQtuHoFycKfZPUsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VInofvJmKEQrkuI9e0xkzHXnPkIrtJJSW7rPPx61bN0=;
 b=iNKR/mPTtJZWSxifLOrjfipdvxJ9+iv7xt9qKlKNu8jgXgUGplSyf/AsCRf4LBEDHceDEoFRHwuXopvdDbQWPKSk+CDcdqKXvI8W7Tp1nj2BWgjtqHtwiFxtpoR1mrd7XiZlpjzUhmIN2lfA7gd93CSCaky1velH2rzOXNMr7d5r9kTJSVL9RPNJ1U+B4A01JRvrTjVf4TTEh93+1Jy4S4wc81GSiLDNieIWD6gQahTtv39cSC2OjhUF3gnqbmn+DELg75vgafKoVXViwNO4oedXOCLAg3AJGr1TDi1prM+jQyjbop8wZf6KnczqpQeVoCTMgjcpWyN3WWrOkfHrUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 13 Feb 2025 03:44:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 03:44:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kairui Song <kasong@tencent.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 0/2] Minimize xa_node allocation during xarry split
Date: Wed, 12 Feb 2025 22:43:53 -0500
Message-ID: <20250213034355.516610-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:408:141::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d754a9-c501-4bf2-fb23-08dd4be0aa20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QtbocV5ztZV41GnzNQD6cZ3MWYn1v3LNy2SVLXK9w/Nwo6sJfdUSBYXpZsKg?=
 =?us-ascii?Q?aL+IQj38ZZjj4SelSjIvCZ2/hW7MsAvk6COQJBsU/bdp4fbCEiecAHq0C9Qm?=
 =?us-ascii?Q?jmyeWau3dmxoQRFTRwOaRAI27XRwLiSTOQec56xhw4CZolBpogxEcHDkFOWh?=
 =?us-ascii?Q?27NmSMOdNndJaVw5fHLXQcDTscQgR7SxU/NHE5o3pJwQrX30FsLH1ctzlcK5?=
 =?us-ascii?Q?UiWebo/PiepH8I85Ge1My6SOVx4we2mmy5TqxAXD1Yme4vejzfvSDvd/s5qz?=
 =?us-ascii?Q?PQbHzmQYbotZQKp9MUukzsNSOM2mVLGiL0XJpk8hK78J0wGQxCsdYaV3bvig?=
 =?us-ascii?Q?91jGh3oyUePJ9ZcozLgL1KxYjQpCWV6xg5uC4YW1B5ONrWbhstwXCQ0tYxrc?=
 =?us-ascii?Q?D3whRsimsr8wipBmllcyV5KPO93a/2NhjW8WMr+D20GL+0Ozvpc+8O4WGgbl?=
 =?us-ascii?Q?anFWeS5BG9JSutr1Kk1wNBFcFGwCgXsRAZ71gCGee0PkNC0fKBk3Fk75PBAV?=
 =?us-ascii?Q?JAbtB/7SQ++bq1Z7CC9w4OLc08jPIQAEamqOqSeLFAPSwmOZ6DGQNJ4GmyCE?=
 =?us-ascii?Q?V9Lr588YotVCJYvxkIpWbf4eaJQPiBxZ9x90AgTfcj29rVKxYEEnPGrzw28a?=
 =?us-ascii?Q?3ICQrLOpJtYawEZS6u5Yfs4DTKsrLgeq6oTbVsFXlTBaiC2mOo7g6d04T1en?=
 =?us-ascii?Q?z+0IgNa4z68GynB+4v8hUBdPbaeeKnTmoX8wYBQRV1L4dP/Gn1Nuo9EobF6m?=
 =?us-ascii?Q?Nq22BSodOq2JlNSXl/5fuysa4NckZ73f7wuuUTAKagQ1W8u0RNkuGNo2WoVl?=
 =?us-ascii?Q?QrcIoFbImCFbBIbjn/0tjsuMCMvUF/S7btgnzq5cPlcfrJh1IG34j3wAY/2m?=
 =?us-ascii?Q?9TjK6ppPKaUYZPOvfp3lvuWfQYQLwdw6ASOGXzNn6NKM0FcxEMMqgP2lm4ls?=
 =?us-ascii?Q?+6VLZjfJiVpf6ZCBTAsovUKmSFwzynAHey3Y9wzXgxD6+vAi8SL3YUetkfxJ?=
 =?us-ascii?Q?hsqoA7Grsnjn7YO679CurspX2Lhnth66hzNLvBQbA6NwX/j4zvwqJRcdR2q8?=
 =?us-ascii?Q?RWATQnWdbB3ImAzMcodzBHAnts3xxA7NMflxrFfSqRU1jbqJvGFtWE5PPCzb?=
 =?us-ascii?Q?QMQlbLo1iOAzixUzXyFQdXbtyrxybAyLx8RwvyybfX0pBPe+P8y54O1WFayR?=
 =?us-ascii?Q?VT2nKusAHzAWRh6tAdbDbwL0ESIFHdBePlYR7xfsQik8Cks/3SvzDn0eLej9?=
 =?us-ascii?Q?VM1EGUpsyoc/QoUssv2j1E6DAN8znpTUKtG9Obh3dHOsDpRVv0Wa4/vr7E/x?=
 =?us-ascii?Q?uMPmS5DOghAghxHetrY7A5xyBOe/5hLNu+/rfTbSXBKEf59t1awCBKlw8Ebk?=
 =?us-ascii?Q?kdudi0pAyWgk0DSFvpNnorQtEZUl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IMGVceIC+9f8AjCLDzBzbsuzNivBQONrf4a3sfQksZBw8wYRi8lAJk/ZLqRV?=
 =?us-ascii?Q?pj0PG1Pt0NhbhpEx4qRR81YsiarfMRjHgPMa3nuXbhK7BGEwhp6ZGpjq4gF+?=
 =?us-ascii?Q?bWk1Kec/CBwq8ZX7R9BpWCRaS0FKh2/NmPdrI9VEj2Nfwg57B5XEN8PWUA2w?=
 =?us-ascii?Q?8DfNI/iBQftcJhs7i24bj7txuGijP6Hl/vBPh1RF1LopWq34B3x26AAUrPXR?=
 =?us-ascii?Q?zcfa3TYi0aXYj661ljzTWu4Pi5Kw4ZMItnyijH6IXkMeM0EsPyMabJAOFb2F?=
 =?us-ascii?Q?qbiIQG5T9oWQeS5QNHO5VMELsnpaZmkmXYrO+Zo8bQRVyeeJ4xyZlTnHX9GX?=
 =?us-ascii?Q?TT27FJIpnsUfrRvWBpZYsSL6L3Ow0WvsO6VfwukYp0i+PekEsOzKVbbqr+fw?=
 =?us-ascii?Q?2Wy5gia26f0Gm8DKK7lUnyO42EQ9bUYxa0Hiu8E0RO6CS9McA2WySY7xaghB?=
 =?us-ascii?Q?HXRs3bKCZws+pAz7uJHKrRuVf9DgGKLxIl6l550eMvfWfLvV1oncUegMKMxJ?=
 =?us-ascii?Q?jDiUhmEpv3qtaR+wb/sOHMs67JjkXRv5fUylI8K7FXcFNf1xxi+Op9bb955O?=
 =?us-ascii?Q?pHGqYjtv3Dm2nAsTuA/D9ajW9ZznT/QNnH1nBEiBmXkj7fJe0NqcVjjRYhJ1?=
 =?us-ascii?Q?RmVw4KvGggEHpKm2AuU5B0G11nlqRCBVOViqn04rF3F/HOk8c57oZCO3RbFl?=
 =?us-ascii?Q?ds29Z3/K2HqljBxSrFm8fzn0vO10DZ16+aQjXZHaZ7bS7yizxi5Lox6D2Xro?=
 =?us-ascii?Q?MP2ZWmTps6Eve6r4J4rS+kj1JSPpedQHIIAW3/n9TGbv0etFNjqg3QjQ3lOx?=
 =?us-ascii?Q?uYAksSdqKwS/3kPhYnvGPEIuIfkYwEyadjFQ6cPHXOYX2XIskzyfGwuu1/Dh?=
 =?us-ascii?Q?3WCFU5udfdXzRnaH7fxwlB337fXG1ILIFA2QN7DPFFvo8e9wktY5EYMZ5Gwm?=
 =?us-ascii?Q?hAua2lBD3+1vTF0Y0vTqXH6yRyr2edGLjZfLMKL6s/WUs5kthKyfeWoJBKtm?=
 =?us-ascii?Q?W7Z7f5oNLwTv9y3EYRAls1B8pFe56Fw/ooQTAYTyDwGWVzjMTvsWygNI4baz?=
 =?us-ascii?Q?zh35YYDDxVo6R3z72Dfx5sDOuvfY/95yOSOBR0qdacCQPFEmfaM5JokQNsX2?=
 =?us-ascii?Q?gMwc1BV37gs7CIU7RaQ8ZRJTst4Hs7vFujfmbjGCAWJkXrMxxMPDFXel955z?=
 =?us-ascii?Q?3UVDoCLQeaXopAmen1txdH5lnq3slcJrbZENOqF2sRPmhA+dJW1KBFpXQq38?=
 =?us-ascii?Q?WOssOjtz4oWP6t0NrfTa3/MJIshx6W9wOkJiWxi4zJc056to/FxylhAFmJIC?=
 =?us-ascii?Q?91Aq2mhLTJSiThZLZ8xmZTHCdYFPN5ufpzpAu9NCNSGak9QGcemrvgoMUgoL?=
 =?us-ascii?Q?mi3jef0GNfsMgIKTamQcDXonTtQ9Qo7aYHbFuz1RThvcKjjooc6A3k+zUZVC?=
 =?us-ascii?Q?XjOOWJPZzCZ3+xebbpy6FSka8GyBVG230zIuIxPmz9ETCezSmSY9siWO+0wS?=
 =?us-ascii?Q?HI8q4MYG01xJVCokAAM7ceBeNnt9iWNW9nwRbCjBN56yR2sC2Gylw4r27zP0?=
 =?us-ascii?Q?NAcsJtb0lzhQ5UY9KpJtGpPgznSEV/S7NuTh1MDo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d754a9-c501-4bf2-fb23-08dd4be0aa20
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:44:05.6716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrxT9ede1Ud3buDavK67404aQBpiNxbx7fM9BlzKYRg4xgPyR6gm9OXPVCY5z6rj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

Hi all,

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

Let me know your comments.


[1] https://lore.kernel.org/linux-mm/Z6YX3RznGLUD07Ao@casper.infradead.org/
[2] https://lore.kernel.org/linux-mm/20250211155034.268962-2-ziy@nvidia.com/

Zi Yan (2):
  mm/filemap: use xas_try_split() in __filemap_add_folio().
  mm/shmem: use xas_try_split() in shmem_split_large_entry().

 include/linux/xarray.h |  7 +++++++
 lib/xarray.c           | 25 +++++++++++++++++++++++
 mm/filemap.c           | 46 +++++++++++++++++-------------------------
 mm/shmem.c             | 43 +++++++++++++++------------------------
 4 files changed, 67 insertions(+), 54 deletions(-)

-- 
2.47.2



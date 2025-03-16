Return-Path: <linux-fsdevel+bounces-44131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7F5A633D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3173C7A6A3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E641494A8;
	Sun, 16 Mar 2025 04:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9911XJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE15322A;
	Sun, 16 Mar 2025 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742099396; cv=fail; b=eS4gY/aYwN7i4fclrA9Bu1hPep1IBW7SISl3TMdDiCetjyTQlqw1kl0wZ7zuy13uIgj4gzXCqQbvqK+SxsFLx4oahOkPknPajDGJjgcKQdNdFdoSKfw5DRNDnsuFOQUB+fDq0n7cXbgRZg+4+8qHe9NAg4gH3NqKR6PCS+398+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742099396; c=relaxed/simple;
	bh=svcEMsntwOAbXvoI5Pz/Uk8WOxxSkW/LXEDlIAnFhgc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bDsJX15GXojoMEQDpQ1DiZRTtETOKJm4hAERDGfFWxDmkH17Q8lo2R4rP7HdJ8OFyTslrcILkNl5Mk9gFXws+GjmNzofsjmFQ2azGiam0PZ9CMGle6cy9o9U7YNyEbZCCM+QWJeirRM/WDhmPqxX1NjkoUsY87lO0JFeaqki4Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9911XJG; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqcR/O/eLCzZbsgCwLNqXDoBC4dXEJ6b6LNvVDqx/e7WR6WWzAyqQCEzZtTksfKZWF4Yw/Uz/FKKNZwwQ09ixzQNgsmfnmPyApNYzxJSX83ga4/zfawMDe//d32mjcNvy3sLHhU7+MctYCA3xl7ZrxrtooDEuhqDThVHPfOtgprA//35FnT0D/YO4NZ47ajbcXwtCzRZuLJSMYQ2ktcTfGeffxRHGG2bANG9RlxTyc59U/phSYCNjqO230lUsohfw3Dfpvnjg5XFFKi3XqjyzhhbPT0M2bpjbOG93BNnETR5v6ew7j4JrQvd9gS+8IlRCnBrE0MTcYMy+XyWKhhVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbI4aSkTotSjLOdayxCjWDb4vuQczyU5E5iKOWgXnzE=;
 b=IzzmzjhIZsitI0vLClzC8fTO1C73Rcns89ZLYeGK9J8Z2Dsi5bjzl02f3zlZt0Blw/ZkUKzC12QUGvSN9wYGRRr44yFxP+RqIXlFMgdaGtVO7gqRjtPlYKUZR7F8z7Wu7QAp90EAOMFCQqOwxVPZEOK8j90LDZnmGdSvsfT1E5TWES84YBLM0WP3BtyKGbq42GY89NqTFm9NLUx7VJETqmeIBUEdayFOQFHnl+gDNCAGPLq6HeOktgp1HqXeYPapSMb6kZvG9SqIymDJD307q6UQbX6LsRuKRCZrnQeMfB0Ejo96CTsqJHr+j6EuUOjqkwIuWomQz1tH+ktlCYxNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbI4aSkTotSjLOdayxCjWDb4vuQczyU5E5iKOWgXnzE=;
 b=a9911XJGETsVwHA+sHkcDf2tJeTHBM93A8qubDCgjUKGp8pdk16VpABAmZloHFnL0l4P486orKEezo42mtkVy7kk3rYP+C4XVqqgBC2gXHftj0/TcBjwKEVQVvzeTy99VcQmIU/CgmbP+QjjXe7tC1oP3aJPq1IqlgQ7iCxcrXG1je9x2AUkYCDKTT4nuuq/w+6C2yj6VTFvuz9aXUIC1Vhi4jAhHSh7RVowmsP0uSGY4sAOnwi3yPvapfkR3QaT/oWp5S636AitnkNHqOF6nAEkdzmgmjf/f5JHbIvQu3HxR9QaYsFWjftiWkyLVMTCiaDG21mvm960FrQZ2yLK5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 04:29:50 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%7]) with mapi id 15.20.8511.031; Sun, 16 Mar 2025
 04:29:49 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH RFC 0/6] Allow file-backed or shared device private pages
Date: Sun, 16 Mar 2025 15:29:23 +1100
Message-ID: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0008.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 09641212-ebec-49a2-3284-08dd64433084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lNS2rGCy6MHZypWRPwZXOCVY5FP2PEq+pCsFrgGag/vh5l/q/u5QOoTgpUy4?=
 =?us-ascii?Q?YQpV2AlKT0iv1puhQXw5ZaUfOqXAMJ0q034epHX8BlwUsdTa3qZgn8C2C20e?=
 =?us-ascii?Q?NC2KbkmhJLhCu6ccIFQdjfV6SweHczA7x/pSakt5CbsA5MGwsgYBbO/JoFmD?=
 =?us-ascii?Q?05s8BlkmQji+TqQ99rgPlOr2YDRrAkLOsuf4Jd3UridKldrL0lqKbZPVebPT?=
 =?us-ascii?Q?tipp5MFEZ7IePvNJ9oowOy8yNF22z+hF2QJ7uZHXzDA8GMbzghmFw+Cyk0A6?=
 =?us-ascii?Q?SxXdmZjFlKo02yYw3LgteMZAIZYVx3zYdvZ6ThUuJQiU2Z9adbXYvJNEF4IW?=
 =?us-ascii?Q?s1LpMdYsEsXCgEBqBREX7c2bP7AKA3A5JcLvakyxzmVx8Prfjm9lIq+QT4EF?=
 =?us-ascii?Q?vWMkoI/cX4WyoeXUUQ/b/0s+T7IURFnH/lFfSSyLe+6iLb+u7XXYXYjYwpPm?=
 =?us-ascii?Q?0vPe7LDSnoADNouulajCtltlG0l7zgdPTQbp+i7qWQOeVL+9z8PLooFqk8IE?=
 =?us-ascii?Q?dAdVZtiAv5efdrV8Giimu8uMPTyYWg1Eu3wgqTNw54Z+Ib2k0pZ17kpxv9Pj?=
 =?us-ascii?Q?hf80aKz1ivoICoJP7HCT+0kGa/T9ndcqbbsMPw1sx7/uIkuWNRISp6WQb10F?=
 =?us-ascii?Q?YYDjyLZ2xw9XOkUomvegVv/BXgwbOKleBmTvXCBwy+pDxcUG4ZsOjUop2Ste?=
 =?us-ascii?Q?+HbNqA8Gj2iTxLpVSis0e+4DsCpSZyWwKUfKHz4DlKm/Ri4qnQ4Wz1areckd?=
 =?us-ascii?Q?YZlV4Dhu5mTkyXtwwRSSyCn7I9lu+PUBO2VOP4JeJFuku78pTTgikANf+wsO?=
 =?us-ascii?Q?tDOeP8DbMSgWeuT/0mTxi9o53LsXK3dhN4jqiOJ/1aPy872BUk5n/zrWv/5v?=
 =?us-ascii?Q?lL85ywFig0ilhCUqufDCSYsOLfkB8IEwtQO6QGbh5ZfRzdKy5dCPnzVItwjt?=
 =?us-ascii?Q?/iPDBsO4kMJr0GB1Imn10NSwebteM8GMijRivulQF8SZhxFWpVE1fc93KhaR?=
 =?us-ascii?Q?Mt/LD52t2X2XQwcHk/qMRd4hYq7xwNDncUPYHWXpAx+27+x+5D5Qp1kwiAZi?=
 =?us-ascii?Q?HsD4KSKMC7ZRECuT9qLiBJsmA2vPyF+hfnE8RVroK27fuCdQJ5yKHXrMlE20?=
 =?us-ascii?Q?QIzBF0GUfBa8BZUJsU4RJNa07VlA23JckS7OhIIdpqa0+CvLuOT7OMf1OMQW?=
 =?us-ascii?Q?rFMRSt+R+zficMv1S25As/7ve2szZALOMkFjKAm5C9ZxbdhLBbsO0nGokJ5V?=
 =?us-ascii?Q?Y58oGlRmHID0H3RPMWbltF28hlNpUKY/U+eIWXvDQtCRhAHBKb0ZBZ7CtNNb?=
 =?us-ascii?Q?W/4StDPnS++GsJeFk5yuV7eOL3Y6lGUNvxOjzoXF6VjuAWZo5+EXSPykiv+O?=
 =?us-ascii?Q?0FLVmS5k5Z3lGbDCDeCI7bEqeG/M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Zh3JRfjg7X4prbXFmjdb6nzk+1gp6x7JVkZBGaaF8u2G8DfiLMgJAOWg4cy?=
 =?us-ascii?Q?5qssSmHvLPJIE90/Ahb92GUBsaHLKUvoAiZZNWPBA7Evq6XxDfLn2FduvM13?=
 =?us-ascii?Q?hiGMLJiUitNajwWgabjoGG7lXfZCSjnjF4razY7k7QfKGCFnQIXFlo3tjizK?=
 =?us-ascii?Q?K5lDEhIABYvffjaN+UcQs6LCgU2p1cxUWlHFURdqQRZlZO1n7/LOW4IOCRRZ?=
 =?us-ascii?Q?SHxy6Zyp7tqHhSg9DbQ8WulRuGDAu02ddntO2LG70tjv7BgAStMLcczo0fQy?=
 =?us-ascii?Q?AUlDOa27fpFosXtp3IgWWYkTRrdpli/FgHuDSk+lCJQr8lPXbF224PheNdxx?=
 =?us-ascii?Q?KGGIt0OGtdAxeCSXKzsNH1/hT8HiIT/QASVMjtapsHlfqwt3xRQfcvFpnWax?=
 =?us-ascii?Q?HEu88Am/65MznFxbzXlGzcZ8khtho5gWI1dZqvNqh/wb6TpjNeC78zr7xUdj?=
 =?us-ascii?Q?8V1UMc+etjpOH2S+Y0ii2Q44Ro1C0pwS8BrEkUBOeT9Mf4DuADBiVrcn40Go?=
 =?us-ascii?Q?IXqMq58MfU30anrvCF7g8bzGOJr8B56lsPmBRy1Y/lhQLc1MlkP8ecoAxE4W?=
 =?us-ascii?Q?ky7h7gLrIlx9QsD7SH5gGnyGuW2pGX8ErOGfYqVH9KhfG0GNI/6DFC9T1G7C?=
 =?us-ascii?Q?0rf6ji1gBCASYaKQFsF8/XpJcBL/RQsI0mR9l4yXCTl7Kx+YADO/eApWndj9?=
 =?us-ascii?Q?kbeYto3sXcHhMjfa/dltFeNNfx4UV4oqsxA/De3groOUMqMJFbUIXVo8w1cS?=
 =?us-ascii?Q?BCrHoCnusFcQyirxjCsLwqbpaQhtAI5ctFI3RKIRoxgWuG7Dx0pBnHceIhwE?=
 =?us-ascii?Q?M/FArL0cgl7M4zsdNCiJAootZT0P/gToq4xGJGvBdNxGoRWmM07VveUI/zaT?=
 =?us-ascii?Q?oYSpmMISfYR5aKkGk+W5PN2LNg7V/h7RWEuN9yMM5THFtoCSYqCgmHyTyZSS?=
 =?us-ascii?Q?xlsvm4SXigVB7vTGftHVfmMUWpEN30pzhZ3YMg4Wr4Rv9ilGpI717zc5caO6?=
 =?us-ascii?Q?1Io7QBZ8/XwM/fetjSyIfMR6Z5tiM9K9NUqtPjIM/ybWCeBRi9YaVH2TMVO9?=
 =?us-ascii?Q?vsOKA3CtvdXDcheTe46UQ8DaibEq51RsUwKAuIcX/SPv8FBnVMl2bVTufUoJ?=
 =?us-ascii?Q?m/RLxNrXCTF/V6jjAzwOswg392OVytGMOKYXtni7SQ5sntsACvMjjQ4yDhFo?=
 =?us-ascii?Q?hjG0lbjNE671IeUD+fC7W3ecoC8FdBStHg04fXPAk4AomdAGxTvBk1ki1aLm?=
 =?us-ascii?Q?i9exRVhSN+BjGQ/vmysY+jVGfSj/GYvkeAAoC2KXaeAa+RTJ2F5AKBlM9DuO?=
 =?us-ascii?Q?50ZRJpauw5OCnirD3rMtMkMBgHTfUQwmH2T9aMoTKRoFVUU8c9Vz2SCxF50b?=
 =?us-ascii?Q?fteoyxK5y+8LrSBK37fpoCbkKxqwL+AKHy62s+a6O9Zp8dhFvbXrtzMmT9/V?=
 =?us-ascii?Q?V7VWjvi9kuyVtmNii+k7ce7/ArmVtSsMwDZYQSv2bXZDQAdQ5F0GnKKNWbYK?=
 =?us-ascii?Q?pkxqqO9eR60E42o1WfdbEUxtO4HkeH0VHugI6tfa2QGkomzOkaVIQVLaymVo?=
 =?us-ascii?Q?BQshdunQ78fWltsM5onqU/4YkgopX9asFOjA65o8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09641212-ebec-49a2-3284-08dd64433084
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 04:29:49.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kH2pgEg8WvtZEu6xaH2nhUFrZxjrjtg6EJ/BtRVsM/ZSsTXUBd09DGJMjMi1OIT6I0+trsJKEJiA4VUjfJoQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

To simplify the initial implementation device private pages were restricted to
only being used for private anonymous. This avoided having to deal with issues
related to shared and/or file-backed pagesi early on.

This series lifts that restriction by allowing ZONE_DEVICE private pages to
exist in the pagecache. As the CPU cannot directly access these pages special
care needs to be taken when looking them up in the page-cache. This series
solves the problem by always migrating such pages back from device memory when
looking them up in the pagecache. This is similar to how device private pages
work for anonymous memory, where a CPU fault on the device memory will always
trigger a migration back to CPU system memory.

Initially this series only allows for read-only migration - this is because the
call to migrate pages back will always reload the data from backing storage.
It then introduces a callback that drivers may implement to actually copy any
modified data back as required.

Drivers are expected to call set_page_dirty() when copying data back to ensure
it hits the backing store.

This series is an early draft implementation - in particular error handling
is not dealt with and I'm not sure that the management of PTE write bits is
entirely correct. Much more testing of all the various filesystem corner cases
is also required. The aim of this series is to get early feedback on the overall
concept of putting device private pages in the pagecache before fleshing out the
implementation further.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

Alistair Popple (6):
  mm/migrate_device.c: Don't read dirty bit of non-present PTEs
  mm/migrate: Support file-backed pages with migrate_vma
  mm: Allow device private pages to exist in page cache
  mm: Implement writeback for share device private pages
  selftests/hmm: Add file-backed migration tests
  nouveau: Add SVM support for migrating file-backed pages to the GPU

 drivers/gpu/drm/nouveau/nouveau_dmem.c |  24 ++-
 include/linux/memremap.h               |   2 +-
 include/linux/migrate.h                |   6 +-
 lib/test_hmm.c                         |  27 ++-
 mm/filemap.c                           |  41 ++++-
 mm/memory.c                            |   9 +-
 mm/memremap.c                          |   1 +-
 mm/migrate.c                           |  42 ++--
 mm/migrate_device.c                    | 114 +++++++++++-
 mm/rmap.c                              |   2 +-
 tools/testing/selftests/mm/hmm-tests.c | 252 +++++++++++++++++++++++++-
 11 files changed, 489 insertions(+), 31 deletions(-)

base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
-- 
git-series 0.9.1


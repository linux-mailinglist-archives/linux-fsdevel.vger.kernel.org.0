Return-Path: <linux-fsdevel+bounces-35532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E09D57BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB799B2565D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8DF1DF731;
	Fri, 22 Nov 2024 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pcJ5hcnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E9166F26;
	Fri, 22 Nov 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239787; cv=fail; b=aQXb84+G4AG2r+Y5Z5Fi2u9UP7bFyAOmqIMDJUQ3p6zlQN6Roa0AjgUR1hlFGdE+frDL9OGEcb56byGW4pQHQWenYEuN6lBWGaZi+/DoI3RbQN39/lIXx5e2Dpvwvk2vz34pngnUFGo+QsKIF93KXBFrS8qjVS5q/V8ftRcyGL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239787; c=relaxed/simple;
	bh=XP9HpLHr+Nd8du63p13KutA8CRYDdhWKoF658wqFbw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCOfulx2Gdeio5f79b1hjnhIjVf4IRL/c2vCRBNTYCW9EagOtWdDTN+RFhPzy/1+ssDXxZ1DxvsUa6T9WzgVJ26pLq3kUWbkiqp8zFIcnCRCvFqWKqoRowxHNfVOd7xiLxv7qYufBHbVnWfYVhZ4f70nhIieKazWWVkjdH7MnMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pcJ5hcnW; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm/GXTOCuQgYfEa75vCqU+2oC+1cb0jUyyCuMKQtk6BFRawnw10UPTuHeaKKaMbDJyNowozN1XnFhvEnoBDt0SfjLpF/OmLw6VHqYnuiuR2mfNI/RYDKHEatmp53RZ0sK+4UhcWj2zn0YweRCVvQ8cYxrMrp2V/H6FM97ERqhMM7Oriyvuur+xLu3Hm1vE/oh2UiOGMEZSAsxwPJhwsxh86oBOqb/qFlfw7yiyigWGlbI1ZzRVLSP2N2xGeOPea6bd1LvsDDPlPk6rHGt5g6yexHO19NkFH1FutQNkSOuFPC/lmi2ZM6xYJZmD14EVDP/IAoPeTIAbdUhLdOgjDTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPibUqGmQzqgJ/QPEuHkh/JxRvNHxLjxZ/YeAz1/+mw=;
 b=r2S0xtwSAd2UMJP1Y/JM5hjXMyHtp+oK3qX0u4TSQATN6c4+DoyL68Te3nQmPBdugPArvajcnVcCcQmimClqK+iXKpTlSwlBxJNtteel4mAzbeoUIVafMOuvtFm6QpJapShRCHz0MAM0X0zKhjy0ZXOn9a0ri3w6zDMw0rB2JGcJE+yOv5UjvGKnke5bQHHN/lYGAQkpE/0NotwnbarWpwjewIN9KaJMFgJNjf9/PlKuIjYld62pbzmDJjyM0dNP2xuGRfJiUOWU7iNsi3fHV8Wubb+O/62zzbZwlbmeFjB84kMUUHTL1g4zzKjeymtrrgNjoI2Kw8is5ILL3HwKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPibUqGmQzqgJ/QPEuHkh/JxRvNHxLjxZ/YeAz1/+mw=;
 b=pcJ5hcnWeICDyRMzAwkcH5sCtCnGm50jnkuMMQAhE4S+OtqoxIrjvd2mvTiFYVakvUT0Wb4hOKLApnE9ZPqV5OUIweaAK0clo9pxuLdUpFZIlM82DsISgG+9yYbDoIu+hnQGZuGtM2A9DXwmKBxPKAkC5xvfle8bCQwBlNfqXF1PqzSF6UpT0UPbA775xtllugqW8mb2u6rD/H37MGida8w971zlBORjmk3T64pWg0KMnugqfWNaiFlGTPacaq64Zvg5LVY5eJIr7Y9y3V2Vaw/9iVAtdxHmlQ9Y7d0Zgiwi1DixrnbuQtI9XxMRBJzGSayNvSPk5uc1T+SjC1PM1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 01:43:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:43:00 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: Alistair Popple <apopple@nvidia.com>,
	lina@asahilina.net,
	zhang.lyra@gmail.com,
	gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	willy@infradead.org,
	djwong@kernel.org,
	tytso@mit.edu,
	linmiaohe@huawei.com,
	david@redhat.com,
	peterx@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com
Subject: [PATCH v3 23/25] mm: Remove pXX_devmap callers
Date: Fri, 22 Nov 2024 12:40:44 +1100
Message-ID: <11c205d96a5e9161c3a8e8df5a1c44b0122b2187.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0098.ausprd01.prod.outlook.com
 (2603:10c6:10:111::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c03fe6-2b1e-4524-d66f-08dd0a96ff30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qcUp7Iaaj7j5fS+5rfhD2P/8BMoc4Zagk5+6YT0tNSOdrvPETLHiRIZJkVri?=
 =?us-ascii?Q?0Dqvmmx8DaQvERkCa59O+sX83sMQ+epWn5YA4SUfAgZGGRzfwI737t+Tx0Ax?=
 =?us-ascii?Q?xVH5pbndvZy7YOLEk2fCpUMAJjmVojsbMxwxOgFblXuOUIVxRQELFIjAR/XK?=
 =?us-ascii?Q?ycx7+S+LwdK5qrEKJLrcUB8w/8TYRQ3f1Fb6dbFHblgROz246okbTp0pDZ1Q?=
 =?us-ascii?Q?v+F0hvXx7NT9pIfjj+rM20H3eBZAQnUgp7egJHaWHToesvBPpw3FO/oHk+1S?=
 =?us-ascii?Q?s9tTyYIh5YFeI+4YoBbzrqC1GruZ/0j/HZxZjiGz7uUU9NBW7MkKKw1dnIRS?=
 =?us-ascii?Q?17o8uafA6EE9sOXHjiiQ2L1zamA9ACJORaKPbGKoGK3lZPUh2HcNv7uefObI?=
 =?us-ascii?Q?3VmsNKL3YvYrNYTEfVeM7gg7Ys0ojTyt+/ol+zqH25v4tA/0lZOF2XHVvBcA?=
 =?us-ascii?Q?cml048uijK7p/LJTUgNSjeKNdQhnuYekJiksRSMY4WDOZdvAjyUcTNpWerlL?=
 =?us-ascii?Q?ed4Jf/q5OHTMAOHJSD8POWbwBsUSw+GKjG2oD6anzKHcHICZHkf8CWrnn+Jc?=
 =?us-ascii?Q?RYhMs5nheXIYR4u5s+LQJszXIjHgfJAn20d7mzLsBAEDYkgeoNdBPBVG4uoV?=
 =?us-ascii?Q?0X/J8svO1g40aPwEYJ7d/hWUo0QZek/1J5nbEGXExjCTYf+mzK5bpXJmuToe?=
 =?us-ascii?Q?C/FwV4wdrCblhtw747Z+wI4OrPaII6gN/lLVY0ykW1CGhy3b7cKQUp9Rpavr?=
 =?us-ascii?Q?aW+97t4sERNfMg8/Rku/jbIrbzB93gGx/sPLfZGcm4c6FtLhFf0UKck1kbmA?=
 =?us-ascii?Q?bQsYCb/+DJ4R+e25RoWS4uiskODr4CWdnLu+0IiE6lOLSXeD/nToD8mRdZtp?=
 =?us-ascii?Q?23ew8aUYtIU1Y7hnsEsjQSzInhGNiC+0ox7GXDJiUMmr6JY4YVA5r2x7agNG?=
 =?us-ascii?Q?5dIB63w7NJleFxqbM5wGk6hxUKfitvnaZgEwv2N/edv65LZdwXuPPu942bki?=
 =?us-ascii?Q?4+nhaSiAL928tq70iY064fsuknjwkzMHBCG3SQ8zPrjUH1s0n+NWbIuFJa4e?=
 =?us-ascii?Q?2C8axpLlz9uQS1kcWVWn8CjE8MhQMMwQrZ8GHt0q6YrPtBz04mJA24fBkzHM?=
 =?us-ascii?Q?TW1BIAuq+AENNgs2uNe13cIpUycVsMWgEgTYtZK6l7F+fwy4j0Qr8Nf+5lbN?=
 =?us-ascii?Q?xik2RovhqtW21N+vwWJg8lcWjIPDM18juoorhw9K7yBIJKGnsgYzVyWWlpPA?=
 =?us-ascii?Q?b9AMOh0tDBtydUOWU1p/4FUr2gLNoGLyrWv9yOotXGxkLaeVUhyM8D861z+O?=
 =?us-ascii?Q?7OKNye5vI4LXH6qME+hZCgg4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mX+FUmG3LzTi87Vkci/4dAvYyBaSyGzFX2xKDgExuGwsMU4tuf6VPi1Jla/F?=
 =?us-ascii?Q?03x5ORsploxsbHVo0wSe1KI2PN1blXH/lZQ0xMnUGZMFl9NliDZpR7MJgtUD?=
 =?us-ascii?Q?oL14m6Z+MiZ1eiGMSo/oDOrxyMRJnxjkgy8I36uw3o09b1sZyRugHtL1lFDS?=
 =?us-ascii?Q?H8+hBCQPMMRPdUWw8mtGfC78jKhj3ilvHPSRYeWMHuSoixFMQAnYre7L8/xS?=
 =?us-ascii?Q?A/EGW/Ky1b59X96pVI4azsotRQF69NlSkUSYKkbajspT72awmdB4F2L+of1j?=
 =?us-ascii?Q?oDgMJsnA6ZEd6+VbOpEj8uTh5HqUfxACiJ904Z+YPkKuDynzGWlXU5UY6jlG?=
 =?us-ascii?Q?3UvcA41y/jWGaFrB5uBM0fWtlF1tjSmZ4UzZ2bSIkikOKgLexTMwQnCa816g?=
 =?us-ascii?Q?ENpunDBfxn692RnsBCpEnyKUXKGb/2ru9TTXYhXQ/ZlINg4SsOCydbMngoZs?=
 =?us-ascii?Q?FaCP9P+JuTLKsRnTz3rqYH9tT4YSW0K/dem/dNLbreP+vzd6FChxOdz+YzA0?=
 =?us-ascii?Q?Msb+GsmB1GE+/zVWaVBYGZf2J1NHOpSGOJ6i9zm4S0U2kGnUAkTAMs6htUPS?=
 =?us-ascii?Q?hePivy58X0HduFk71v1Oe/O0EGNpjp1Z3Gd5R5OX/kQVbugD9/dOcUUHvH5z?=
 =?us-ascii?Q?Hw6ShAIxrbOzTJ84m3IWskZhLIMzqlwpiFl3TNyXYh98FGJ9Nuio/tQ56qHi?=
 =?us-ascii?Q?sll/bgeTukNLBn0HB4MmK1xEnizr1rNLA330fp/s4n6DhYo22MFQYNsj80Wy?=
 =?us-ascii?Q?0ZPCikFVttL8lkKm6LNOXjxbIjhcuIjOaSO5b3n8SX6mdDEYvP65D+xUGL1Z?=
 =?us-ascii?Q?lUnXyQs9TUKE+YgLELgb/zOk9sh4yJjQX6bpauQ3nc+CnRnD27+TW2NmV4uO?=
 =?us-ascii?Q?Iu8r4vIRsV0b1nAHIo2VUxHxuKcDz4rNccPF4SxzNbCNpPi4YDmZWLwrWQVc?=
 =?us-ascii?Q?BBwg9vKtYR/UWrFIh44XiYpOv8dsyvJSzwLfcs1+mrY535Ys8H+g9mAaMBID?=
 =?us-ascii?Q?x/jt9SsYpyglYDJG/xi5XNweDkq8UydMFfMGl3LJFZbsb0iyNrZ9o+s613zo?=
 =?us-ascii?Q?PTrlbebRMRjzikPw2n0BBV0ZWJUc0zWN5DFQKVxAglUPxYNciuArETDW8Bz0?=
 =?us-ascii?Q?LRmcD4hF8WSPcVGnHMTl6FkGUtxli9pAscDnJgUgegUbzMxhnTrdAnq/w6/H?=
 =?us-ascii?Q?vCVFZMEft0RYMNp1WeXUyN/v7ISbyjlU+OwTwrBgCv4c65TRBBCaBVMElaFH?=
 =?us-ascii?Q?+9EqAYSomJ39Pb0NaKSTXV86HHClJOePUeom3rQRtUqe/N2muJHVdqfCSHwH?=
 =?us-ascii?Q?wUexcqSX19QxhDjPQOYcI0wmhgKpllf3EnWRjPlmlCH4dMirbbSyrEEwhNXE?=
 =?us-ascii?Q?dp8MBuM7J3T/rTTkZsVY5X8CwGPOi6vdnwftAOTyspmepiOdkWigTesVkUjR?=
 =?us-ascii?Q?bgI02Y0sH2osJvuQ4btOClWIg6akjiOXajG/eGLNmc8p9VRI8CNy0x60mlhx?=
 =?us-ascii?Q?+YsSPHlwyj87CmGhXWz3Ttj+UEamEvxQkCNxX8FBcae8aS6OFq1DQlFDOScN?=
 =?us-ascii?Q?dKEkTmeg5MurSEO1uAg7oYNfyQlLsg9XpJiR5ISW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c03fe6-2b1e-4524-d66f-08dd0a96ff30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:43:00.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upLkhdncCW8FUj3YjwvLpmGVtg1PyuTUmzFszAnLj39q6k07BnMDTstErmpxV9chjkankS0WqJpNZMVFdcEKig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

The devmap PTE special bit was used to detect mappings of FS DAX
pages. This tracking was required to ensure the generic mm did not
manipulate the page reference counts as FS DAX implemented it's own
reference counting scheme.

Now that FS DAX pages have their references counted the same way as
normal pages this tracking is no longer needed and can be
removed.

Almost all existing uses of pmd_devmap() are paired with a check of
pmd_trans_huge(). As pmd_trans_huge() now returns true for FS DAX pages
dropping the check in these cases doesn't change anything.

However care needs to be taken because pmd_trans_huge() also checks that
a page is not an FS DAX page. This is dealt with either by checking
!vma_is_dax() or relying on the fact that the page pointer was obtained
from a page list. This is possible because zone device pages cannot
appear in any page list due to sharing page->lru with page->pgmap.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 arch/powerpc/mm/book3s64/hash_pgtable.c  |   3 +-
 arch/powerpc/mm/book3s64/pgtable.c       |   8 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c |   5 +-
 arch/powerpc/mm/pgtable.c                |   2 +-
 fs/dax.c                                 |   5 +-
 fs/userfaultfd.c                         |   2 +-
 include/linux/huge_mm.h                  |  10 +-
 include/linux/pgtable.h                  |   2 +-
 mm/gup.c                                 | 162 +------------------------
 mm/hmm.c                                 |   7 +-
 mm/huge_memory.c                         |  71 +----------
 mm/khugepaged.c                          |   2 +-
 mm/mapping_dirty_helpers.c               |   4 +-
 mm/memory.c                              |  35 +----
 mm/migrate_device.c                      |   2 +-
 mm/mprotect.c                            |   2 +-
 mm/mremap.c                              |   5 +-
 mm/page_vma_mapped.c                     |   5 +-
 mm/pagewalk.c                            |   8 +-
 mm/pgtable-generic.c                     |   7 +-
 mm/userfaultfd.c                         |   5 +-
 mm/vmscan.c                              |   5 +-
 22 files changed, 61 insertions(+), 296 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 988948d..82d3117 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -195,7 +195,7 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!hash__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!hash__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -227,7 +227,6 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 
 	pmd = *pmdp;
 	pmd_clear(pmdp);
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 5a4a753..fd1971f 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -50,7 +50,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(vma->vm_mm, pmdp));
 #endif
 	changed = !pmd_same(*(pmdp), entry);
@@ -70,7 +70,6 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 {
 	int changed;
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
 	assert_spin_locked(pud_lockptr(vma->vm_mm, pudp));
 #endif
 	changed = !pud_same(*(pudp), entry);
@@ -193,7 +192,7 @@ pmd_t pmdp_huge_get_and_clear_full(struct vm_area_struct *vma,
 	pmd_t pmd;
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-		   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
+		   !pmd_present(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, addr, pmdp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
@@ -211,8 +210,7 @@ pud_t pudp_huge_get_and_clear_full(struct vm_area_struct *vma,
 	pud_t pud;
 
 	VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
-	VM_BUG_ON((pud_present(*pudp) && !pud_devmap(*pudp)) ||
-		  !pud_present(*pudp));
+	VM_BUG_ON(!pud_present(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, addr, pudp);
 	/*
 	 * if it not a fullmm flush, then we can possibly end up converting
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index b0d9270..78907b6 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1424,7 +1424,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
+	WARN_ON(!radix__pmd_trans_huge(*pmdp));
 	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
@@ -1441,7 +1441,7 @@ unsigned long radix__pud_hugepage_update(struct mm_struct *mm, unsigned long add
 	unsigned long old;
 
 #ifdef CONFIG_DEBUG_VM
-	WARN_ON(!pud_devmap(*pudp));
+	WARN_ON(!pud_trans_huge(*pudp));
 	assert_spin_locked(pud_lockptr(mm, pudp));
 #endif
 
@@ -1459,7 +1459,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 	VM_BUG_ON(radix__pmd_trans_huge(*pmdp));
-	VM_BUG_ON(pmd_devmap(*pmdp));
 	/*
 	 * khugepaged calls this for normal pmd
 	 */
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 7316396..c8cba4d 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -509,7 +509,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		return NULL;
 #endif
 
-	if (pmd_trans_huge(pmd) || pmd_devmap(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		if (is_thp)
 			*is_thp = true;
 		ret_pte = (pte_t *)pmdp;
diff --git a/fs/dax.c b/fs/dax.c
index 45d04ca..0169b35 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1908,7 +1908,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PTE we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (pmd_trans_huge(*vmf->pmd) || pmd_devmap(*vmf->pmd)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		ret = VM_FAULT_NOPAGE;
 		goto unlock_entry;
 	}
@@ -2029,8 +2029,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * the PMD we need to set up.  If so just return and the fault will be
 	 * retried.
 	 */
-	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
-			!pmd_devmap(*vmf->pmd)) {
+	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd)) {
 		ret = 0;
 		goto unlock_entry;
 	}
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 68cdd89..1c90913 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -304,7 +304,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	if (!pmd_present(_pmd) || pmd_devmap(_pmd))
+	if (!pmd_present(_pmd) || vma_is_dax(vmf->vma))
 		goto out;
 
 	if (pmd_trans_huge(_pmd)) {
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 120d0ac..1710070 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -378,8 +378,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 						false, NULL);		\
 	}  while (0)
@@ -405,8 +404,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 #define split_huge_pud(__vma, __pud, __address)				\
 	do {								\
 		pud_t *____pud = (__pud);				\
-		if (pud_trans_huge(*____pud)				\
-					|| pud_devmap(*____pud))	\
+		if (pud_trans_huge(*____pud))				\
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
@@ -429,7 +427,7 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
@@ -437,7 +435,7 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	if (pud_trans_huge(*pud) || pud_devmap(*pud))
+	if (pud_trans_huge(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
 		return NULL;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8b2ac6..fa661b2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1645,7 +1645,7 @@ static inline int pud_trans_unstable(pud_t *pud)
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (pud_none(pudval) || pud_trans_huge(pudval) || pud_devmap(pudval))
+	if (pud_none(pudval) || pud_trans_huge(pudval))
 		return 1;
 	if (unlikely(pud_bad(pudval))) {
 		pud_clear_bad(pud);
diff --git a/mm/gup.c b/mm/gup.c
index ff5f35b..bb12871 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -629,31 +629,9 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 		return NULL;
 
 	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
-
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
-	    pud_devmap(pud)) {
-		/*
-		 * device mapped pages can only be returned if the caller
-		 * will manage the page reference count.
-		 *
-		 * At least one of FOLL_GET | FOLL_PIN must be set, so
-		 * assert that here:
-		 */
-		if (!(flags & (FOLL_GET | FOLL_PIN)))
-			return ERR_PTR(-EEXIST);
-
-		if (flags & FOLL_TOUCH)
-			touch_pud(vma, addr, pudp, flags & FOLL_WRITE);
-
-		ctx->pgmap = get_dev_pagemap(pfn, ctx->pgmap);
-		if (!ctx->pgmap)
-			return ERR_PTR(-EFAULT);
-	}
-
 	page = pfn_to_page(pfn);
 
-	if (!pud_devmap(pud) && !pud_write(pud) &&
-	    gup_must_unshare(vma, flags, page))
+	if (!pud_write(pud) && gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
 	ret = try_grab_folio(page_folio(page), 1, flags);
@@ -852,8 +830,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	page = vm_normal_page(vma, address, pte);
 
 	/*
-	 * We only care about anon pages in can_follow_write_pte() and don't
-	 * have to worry about pte_devmap() because they are never anon.
+	 * We only care about anon pages in can_follow_write_pte().
 	 */
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pte(pte, page, vma, flags)) {
@@ -861,18 +838,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		goto out;
 	}
 
-	if (!page && pte_devmap(pte) && (flags & (FOLL_GET | FOLL_PIN))) {
-		/*
-		 * Only return device mapping pages in the FOLL_GET or FOLL_PIN
-		 * case since they are only valid while holding the pgmap
-		 * reference.
-		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
-			page = pte_page(pte);
-		else
-			goto no_page;
-	} else if (unlikely(!page)) {
+	if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
 			page = ERR_PTR(-EFAULT);
@@ -954,14 +920,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
-	if (pmd_devmap(pmdval)) {
-		ptl = pmd_lock(mm, pmd);
-		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-		return no_page_table(vma, flags, address);
-	}
 	if (likely(!pmd_leaf(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 
@@ -2843,7 +2801,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		int *nr)
 {
 	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
+	int ret = 0;
 	pte_t *ptep, *ptem;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
@@ -2867,16 +2825,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
-
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
@@ -2947,91 +2896,6 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
-#if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
-static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
-	unsigned long end, unsigned int flags, struct page **pages, int *nr)
-{
-	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
-
-	do {
-		struct folio *folio;
-		struct page *page = pfn_to_page(pfn);
-
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
-		folio = try_grab_folio_fast(page, 1, flags);
-		if (!folio) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-		folio_set_referenced(folio);
-		pages[*nr] = page;
-		(*nr)++;
-		pfn++;
-	} while (addr += PAGE_SIZE, addr != end);
-
-	put_dev_pagemap(pgmap);
-	return addr == end;
-}
-
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	unsigned long fault_pfn;
-	int nr_start = *nr;
-
-	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
-		return 0;
-
-	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
-		gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-		return 0;
-	}
-	return 1;
-}
-#else
-static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-
-static int gup_fast_devmap_pud_leaf(pud_t pud, pud_t *pudp, unsigned long addr,
-		unsigned long end, unsigned int flags, struct page **pages,
-		int *nr)
-{
-	BUILD_BUG();
-	return 0;
-}
-#endif
-
 static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		unsigned long end, unsigned int flags, struct page **pages,
 		int *nr)
@@ -3046,13 +2910,6 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	if (pmd_special(orig))
 		return 0;
 
-	if (pmd_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pmd_leaf(orig, pmdp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
@@ -3093,13 +2950,6 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	if (pud_special(orig))
 		return 0;
 
-	if (pud_devmap(orig)) {
-		if (unlikely(flags & FOLL_LONGTERM))
-			return 0;
-		return gup_fast_devmap_pud_leaf(orig, pudp, addr, end, flags,
-					        pages, nr);
-	}
-
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
@@ -3138,8 +2988,6 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	if (!pgd_access_permitted(orig, flags & FOLL_WRITE))
 		return 0;
 
-	BUILD_BUG_ON(pgd_devmap(orig));
-
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 082f7b7..285578e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -298,7 +298,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	 * fall through and treat it like a normal page.
 	 */
 	if (!vm_normal_page(walk->vma, addr, pte) &&
-	    !pte_devmap(pte) &&
 	    !is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			pte_unmap(ptep);
@@ -351,7 +350,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
 
-	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
+	if (pmd_trans_huge(pmd)) {
 		/*
 		 * No need to take pmd_lock here, even if some other thread
 		 * is splitting the huge pmd we will get that event through
@@ -362,7 +361,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * values.
 		 */
 		pmd = pmdp_get_lockless(pmdp);
-		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
+		if (!pmd_trans_huge(pmd))
 			goto again;
 
 		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
@@ -429,7 +428,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 	}
 
-	if (pud_leaf(pud) && pud_devmap(pud)) {
+	if (pud_leaf(pud) && vma_is_dax(walk->vma)) {
 		unsigned long i, npages, pfn;
 		unsigned int required_fault;
 		unsigned long *hmm_pfns;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0ac0e54..900a596 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1357,10 +1357,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pmd_mkdevmap(entry);
-	else
-		entry = pmd_mkspecial(entry);
+	entry = pmd_mkspecial(entry);
 	if (write) {
 		entry = pmd_mkyoung(pmd_mkdirty(entry));
 		entry = maybe_pmd_mkwrite(entry, vma);
@@ -1399,8 +1396,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1495,10 +1490,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
-	if (pfn_t_devmap(pfn))
-		entry = pud_mkdevmap(entry);
-	else
-		entry = pud_mkspecial(entry);
+	entry = pud_mkspecial(entry);
 	if (write) {
 		entry = pud_mkyoung(pud_mkdirty(entry));
 		entry = maybe_pud_mkwrite(entry, vma);
@@ -1529,8 +1521,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) &&
-			!pfn_t_devmap(pfn));
 	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
@@ -1604,46 +1594,6 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
-struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
-		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
-{
-	unsigned long pfn = pmd_pfn(*pmd);
-	struct mm_struct *mm = vma->vm_mm;
-	struct page *page;
-	int ret;
-
-	assert_spin_locked(pmd_lockptr(mm, pmd));
-
-	if (flags & FOLL_WRITE && !pmd_write(*pmd))
-		return NULL;
-
-	if (pmd_present(*pmd) && pmd_devmap(*pmd))
-		/* pass */;
-	else
-		return NULL;
-
-	if (flags & FOLL_TOUCH)
-		touch_pmd(vma, addr, pmd, flags & FOLL_WRITE);
-
-	/*
-	 * device mapped pages can only be returned if the
-	 * caller will manage the page reference count.
-	 */
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return ERR_PTR(-EEXIST);
-
-	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
-	*pgmap = get_dev_pagemap(pfn, *pgmap);
-	if (!*pgmap)
-		return ERR_PTR(-EFAULT);
-	page = pfn_to_page(pfn);
-	ret = try_grab_folio(page_folio(page), 1, flags);
-	if (ret)
-		page = ERR_PTR(ret);
-
-	return page;
-}
-
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
@@ -1795,7 +1745,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 	ret = -EAGAIN;
 	pud = *src_pud;
-	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
+	if (unlikely(!pud_trans_huge(pud)))
 		goto out_unlock;
 
 	/*
@@ -2598,8 +2548,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2616,7 +2565,7 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 	spinlock_t *ptl;
 
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (likely(pud_trans_huge(*pud) || pud_devmap(*pud)))
+	if (likely(pud_trans_huge(*pud)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
@@ -2666,7 +2615,7 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
 	VM_BUG_ON(haddr & ~HPAGE_PUD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PUD_SIZE, vma);
-	VM_BUG_ON(!pud_trans_huge(*pud) && !pud_devmap(*pud));
+	VM_BUG_ON(!pud_trans_huge(*pud));
 
 	count_vm_event(THP_SPLIT_PUD);
 
@@ -2700,7 +2649,7 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
 				(address & HPAGE_PUD_MASK) + HPAGE_PUD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	ptl = pud_lock(vma->vm_mm, pud);
-	if (unlikely(!pud_trans_huge(*pud) && !pud_devmap(*pud)))
+	if (unlikely(!pud_trans_huge(*pud)))
 		goto out;
 	__split_huge_pud_locked(vma, pud, range.start);
 
@@ -2773,8 +2722,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
-	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
-				&& !pmd_devmap(*pmd));
+	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -2991,8 +2939,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
+	if (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)) {
 		if (folio && folio != pmd_folio(*pmd))
 			return;
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b538c3d..f832882 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -961,8 +961,6 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 		return SCAN_PMD_NULL;
 	if (pmd_trans_huge(pmde))
 		return SCAN_PMD_MAPPED;
-	if (pmd_devmap(pmde))
-		return SCAN_PMD_NULL;
 	if (pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2f8829b..208b428 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -129,7 +129,7 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* Do not split a huge pmd, present or migrated */
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
+	if (pmd_trans_huge(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 		walk->action = ACTION_CONTINUE;
 	}
@@ -152,7 +152,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 	pud_t pudval = READ_ONCE(*pud);
 
 	/* Do not split a huge pud */
-	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
+	if (pud_trans_huge(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 		walk->action = ACTION_CONTINUE;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 1c91dd4..012c82c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -604,16 +604,6 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			return NULL;
 		if (is_zero_pfn(pfn))
 			return NULL;
-		if (pte_devmap(pte))
-		/*
-		 * NOTE: New users of ZONE_DEVICE will not set pte_devmap()
-		 * and will have refcounts incremented on their struct pages
-		 * when they are inserted into PTEs, thus they are safe to
-		 * return here. Legacy ZONE_DEVICE pages that set pte_devmap()
-		 * do not have refcounts. Example of legacy ZONE_DEVICE is
-		 * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
-		 */
-			return NULL;
 
 		print_bad_pte(vma, addr, pte, NULL);
 		return NULL;
@@ -691,8 +681,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		}
 	}
 
-	if (pmd_devmap(pmd))
-		return NULL;
 	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
@@ -1238,8 +1226,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1275,7 +1262,7 @@ copy_pud_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pud = pud_offset(src_p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
+		if (pud_trans_huge(*src_pud)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PUD_SIZE, src_vma);
@@ -1713,7 +1700,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
@@ -1755,7 +1742,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 	pud = pud_offset(p4d, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
+		if (pud_trans_huge(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
@@ -2378,10 +2365,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	/* Ok, finally just insert the thing.. */
-	if (pfn_t_devmap(pfn))
-		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
-	else
-		entry = pte_mkspecial(pfn_t_pte(pfn, prot));
+	entry = pte_mkspecial(pfn_t_pte(pfn, prot));
 
 	if (mkwrite) {
 		entry = pte_mkyoung(entry);
@@ -2492,8 +2476,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 	/* these checks mirror the abort conditions in vm_normal_page */
 	if (vma->vm_flags & VM_MIXEDMAP)
 		return true;
-	if (pfn_t_devmap(pfn))
-		return true;
 	if (pfn_t_special(pfn))
 		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
@@ -2525,8 +2507,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 	 * than insert_pfn).  If a zero_pfn were inserted into a VM_MIXEDMAP
 	 * without pte special, it would there be refcounted as a normal page.
 	 */
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) &&
-	    !pfn_t_devmap(pfn) && pfn_t_valid(pfn)) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pfn_t_valid(pfn)) {
 		struct page *page;
 
 		/*
@@ -5907,7 +5888,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		pud_t orig_pud = *vmf.pud;
 
 		barrier();
-		if (pud_trans_huge(orig_pud) || pud_devmap(orig_pud)) {
+		if (pud_trans_huge(orig_pud)) {
 
 			/*
 			 * TODO once we support anonymous PUDs: NUMA case and
@@ -5948,7 +5929,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
 		}
-		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
+		if (pmd_trans_huge(vmf.orig_pmd)) {
 			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf);
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 2209070..a721e0d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -599,7 +599,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pmdp = pmd_alloc(mm, pudp, addr);
 	if (!pmdp)
 		goto abort;
-	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
+	if (pmd_trans_huge(*pmdp))
 		goto abort;
 	if (pte_alloc(mm, pmdp))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d0..e6b721d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -382,7 +382,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd) || pmd_devmap(_pmd)) {
+		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
diff --git a/mm/mremap.c b/mm/mremap.c
index dda09e9..d3c14a9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -594,7 +594,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		new_pud = alloc_new_pud(vma->vm_mm, vma, new_addr);
 		if (!new_pud)
 			break;
-		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
+		if (pud_trans_huge(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
 				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
 					       old_pud, new_pud, need_rmap_locks);
@@ -616,8 +616,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
-		    pmd_devmap(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
 					   old_pmd, new_pmd, need_rmap_locks))
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae5cc42..77da636 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -235,8 +235,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde) ||
-		    (pmd_present(pmde) && pmd_devmap(pmde))) {
+		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
@@ -251,7 +250,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 					return not_found(pvmw);
 				return true;
 			}
-			if (likely(pmd_trans_huge(pmde) || pmd_devmap(pmde))) {
+			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
 					return not_found(pvmw);
 				if (!check_pmd(pmd_pfn(pmde), pvmw))
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 461ea3b..576ff14 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -753,7 +753,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pudp = pudp;
 		fw->pud = pud;
 
-		if (!pud_present(pud) || pud_devmap(pud) || pud_special(pud)) {
+		if (!pud_present(pud) || pud_special(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
 		} else if (!pud_leaf(pud)) {
@@ -765,6 +765,12 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
 		 */
 		page = pud_page(pud);
+
+		if (is_device_dax_page(page)) {
+			spin_unlock(ptl);
+			goto not_found;
+		}
+
 		goto found;
 	}
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4ad..093c435 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -139,8 +139,7 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
-			   !pmd_devmap(*pmdp));
+	VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp));
 	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
@@ -153,7 +152,7 @@ pud_t pudp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
 	pud_t pud;
 
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
-	VM_BUG_ON(!pud_trans_huge(*pudp) && !pud_devmap(*pudp));
+	VM_BUG_ON(!pud_trans_huge(*pudp));
 	pud = pudp_huge_get_and_clear(vma->vm_mm, address, pudp);
 	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
 	return pud;
@@ -293,7 +292,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
 		goto nomap;
-	if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
+	if (unlikely(pmd_trans_huge(pmdval)))
 		goto nomap;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ce13c40..9d39f8e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -798,8 +798,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		 * (This includes the case where the PMD used to be THP and
 		 * changed back to none after __pte_alloc().)
 		 */
-		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
-			     pmd_devmap(dst_pmdval))) {
+		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}
@@ -1682,7 +1681,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 
 		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
 		if (ptl) {
-			if (pmd_devmap(*src_pmd)) {
+			if (vma_is_dax(src_vma)) {
 				spin_unlock(ptl);
 				err = -ENOENT;
 				break;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb4e844..34ff5a6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3303,7 +3303,7 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	if (!pte_present(pte) || is_zero_pfn(pfn))
 		return -1;
 
-	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+	if (WARN_ON_ONCE(pte_special(pte)))
 		return -1;
 
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
@@ -3321,9 +3321,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 	if (!pmd_present(pmd) || is_huge_zero_pmd(pmd))
 		return -1;
 
-	if (WARN_ON_ONCE(pmd_devmap(pmd)))
-		return -1;
-
 	if (WARN_ON_ONCE(!pfn_valid(pfn)))
 		return -1;
 
-- 
git-series 0.9.1


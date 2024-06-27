Return-Path: <linux-fsdevel+bounces-22563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3360919C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7475A2839F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89514DDC5;
	Thu, 27 Jun 2024 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="azdCAhwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D779F4;
	Thu, 27 Jun 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449684; cv=fail; b=FOUMBbRqTSl3ejuaRZMjzElq3V3azwbGybkUke2FvZDX6qq2Ob/15ZoVpEByPTGBDnFKhDmRl+r60m6EIL1xsZD8+mKY2lvXHWQW6Iq916W8XffjB7ob9kRz2so3zRtoQ97L/GR8TTLkHL7vp/B9l8NjlmWB+F8scU86Ny0skrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449684; c=relaxed/simple;
	bh=ezXwaLU5pUSHub61ziUXZlhgEE4Awmqgl8ZxhB/w5JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiIAjJWG/dfnB/jKrME18VtwC9VmmNJWtrchghF7h1BCpoKY8yCSfmK1O2qJxKDYqP/ho38uAvJ31P38pnyex3BTk8JM0cMiTkz9sd966dAr1JPsEALVdkEifMTv35o4YdSQCE50lUhB0x/zgoogs8BFmwK9p7p/Ofr8uDBtujA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=azdCAhwq; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0ywJKm8tCOaxBYYLhd0QwDA160ctJ+GR0y2S96seU2joAQNBWsZ4m3R1TOsiGVk+QlwF+bnjuaQO4OsD/rX26k4SpAesrw+bFW+fdLkgXrKbGVpSEvGkHBQBeXe6Q0tUAUvqEYMljcyrFax578azMIAIQO36IaX1AnleTZ7JnHh3ATyiVdi6XkoHoijX79CkOkTzNXxOE5t3eZLuBDKOImDGlq8vb/lpv9ViZnQLYB/2toQ8gN98I/DZ+sRbwEZK8HzTSfx1xuNcvFvAH7Sr4wpIl9Sp//jZhJFkGfpeaVMbfpJtm319DetFCa4itVLrTloScdLOR4H8o0Y2kzt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK3Q7dledyN8DAN2X2wWxUAB8Y4QPRw76IMsraD1iJc=;
 b=C/14CJT/AAC8R4q5ui3bTeupnvA0go0rJXuPLyCXleArk+J8XkXxMMqcgIPnpQsv35gie4yM6wYR+9n5b1G2jyC/5hqHs2R0Dcq23DUbtcAaKaQ6OzsS0fI1EJaWTmfWwy5N7zsI65tJVVpcpas5RGzkTvUwdbDUX29F8UA1DuXWgVLbKFyvCKcTdbpj7dC2c9wre1zqbzZEgJaWseKUc36tVf3xBm4evzbwVxG7idBOSHiCFgr41t2p9u9WYL8YYqwX/gNIf5pYMcJ7OMnHSi6NZrJlJzR+3mpzdkcsBr2VePZU4dlRTeMyW6ShAifvKXgQfSk+k1QZHvpp7ypamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK3Q7dledyN8DAN2X2wWxUAB8Y4QPRw76IMsraD1iJc=;
 b=azdCAhwqDDVV+99DFwCGxQB2Mo9rQLlBSrhaqYBN7hlerPTasyXvR6CbhCH86ykFFXqtx3jUwSUo7fcPfXs9XP8r3B30cCEqWeuVyS2xjeX86ZSkqSv1ynVCGBHRHqWFepYLtfa2i7f7qNLmF0xlF0D19+LEJ6al0JAqHYAHgV95KVndqshDF5EGaEonMUBquiKq/dTF/A0FDF8HmDn27mO1YB2vVYdnDivmibEKwBPPZAz63HIZtsJ+X+SiI10gP/TTF4QuMCbsaRja3BC6DK8b62Pg6ABpUxd+S8Fb9Gvjv8omAHfgaCj/2eQ9OsxNCPo5J4gaVOY93PLsq+Tlew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Thu, 27 Jun 2024 00:54:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 00:54:40 +0000
From: Alistair Popple <apopple@nvidia.com>
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	jack@suse.cz,
	jgg@ziepe.ca
Cc: catalin.marinas@arm.com,
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
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com,
	hch@lst.de,
	david@fromorbit.com,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 01/13] mm/gup.c: Remove redundant check for PCI P2PDMA page
Date: Thu, 27 Jun 2024 10:54:16 +1000
Message-ID: <e24726e36a7b8cb39b0d85ebbbbc9ba564dd3a74.1719386613.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0074.ausprd01.prod.outlook.com
 (2603:10c6:10:110::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df7d926-9ecb-4372-63bb-08dc9643b98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6nNs6ILqUaKyZAxJsQmBL66HeVKyScdfhQi9T12cqftQM4kofG82Q87PnoUl?=
 =?us-ascii?Q?dyB4G18qa/cV7Pm50/9t3DhNYrpn4knN0bOIg4KhdQfrPoR00qM4h6N7iz2G?=
 =?us-ascii?Q?VdorE8fHFv8S6jf05wSDgBfA++zUF44piHjFKcsW0Z9jor8TyYB7Trfua+io?=
 =?us-ascii?Q?ZDQkYbyKzTTyx1Cwrq+7vvI0dfS2qndKQwgjBzgtdaZ7yw1vUAIxq9xGRLni?=
 =?us-ascii?Q?lpCluRAcnpXg17dpXWfTC1p+kn2GtYfevsMRVxbT1K0UMzp4+pdO7KpFo63W?=
 =?us-ascii?Q?gbSNxctI9p7trzrRmjrgDHRBSMNHaJY1tdV3UrCjXv5SESp/y7YbthYxsgyl?=
 =?us-ascii?Q?8x8mdEJ//s5e8Glyend6IbPdmlKm9xGTNEwhuHqPMXf6qOEJIiYpDaF8QXUw?=
 =?us-ascii?Q?r8jkHtEbzujIjIEH0Jg+nUftGFiyNFj/nSpmOje3bTSzDxIIU9gFD2B4J0bE?=
 =?us-ascii?Q?Ltf/vTyhz+1/F9hm8JcjFHnyAHpKQNbLPPvGbvOlrivDIgfveVnccbfhexpb?=
 =?us-ascii?Q?wahVKNeTwKlqww7mUMw1ewUd5HvNwz4N1yQlkidQztmcYqONiATCwZsOofGU?=
 =?us-ascii?Q?tTsp46FYsV84FBjhf4avPKfczn7xHXtUXu4Ihw4A95LM8Doez2JHGEAAKDne?=
 =?us-ascii?Q?zz4wNaTbQyeahHMg3caB9dCuhW8ChlySpArjGorE8qjJywA/gQtWChZOdZHn?=
 =?us-ascii?Q?dqCGAHnSItfIMb4b7X1WA77DJcpy/MiBRNI4AVfyb6dfUFE2JsTew+t5j6wI?=
 =?us-ascii?Q?26xu+OepO0L+wEm1TAJVSAyHqjWIQFl6+CQk+jFfYd97kQWHqfdqN6JPuVfp?=
 =?us-ascii?Q?R+sdD6tVK45JWPpIP0a4KXFs15yQYCxI9kY3VmMfk/QzAVa8oPRULT8HK7ip?=
 =?us-ascii?Q?I6kolC5wcDjvf3TREYc6/xYyXSLF/1ysDf/KFiaLKpTTGe8DS3hR4ZbwH9cD?=
 =?us-ascii?Q?Gxeqrl1LCdkQnYzc+bQVBwHfHmdGKAm719TbSrd6B/cu4dpbzzbgtzqfNVLc?=
 =?us-ascii?Q?TRJey3/76z+hVDWbthl6RBdSmURW3KJriCSXeW/tcP8wawmOZ2zS5fmV1gJh?=
 =?us-ascii?Q?Eg3j533vi2r7qaOF1R9G+5awf6pjdshpjiIYdVEdbeV3d8bMz/DR4OHf8fJm?=
 =?us-ascii?Q?1B8qTyiakx7fb8+AapvNwdPHP+1UA9fB+J57dWR5ktnRagtkQA/+rzJhncEs?=
 =?us-ascii?Q?gxrFniwcGDvhzGLspC3jqCsPP1lYuVHYvGFBEnUHOArD2WRfARluCe+VTcqG?=
 =?us-ascii?Q?CXuaRVKAaHvMMmREn1Sb32g8pxqkzaFzo2zbBexcbAtAggb5sXbtUbiB5YVm?=
 =?us-ascii?Q?gYHYJIxSVeE2bCgMWxFPXcHcROJxPFeKpAd31JBr5Ge7EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UteYh4NOQXgbxGq7QLU3zclGd2B9yHd/Bp0zRVnUs/dkbCFoOMgK1uPwKtkh?=
 =?us-ascii?Q?Uz5De6d2xtBNxqawfvuCcm7dIDNRntKH2nfzn55WJKvgCjZs0WJ5Vzz1Pi5k?=
 =?us-ascii?Q?gYi8Lsx4/es6Eq6jZkymJC8m+KDd1zZ3h4rFaCsF8y8MPhy9dVXaZfQEYcIU?=
 =?us-ascii?Q?lb+sE3Jz+k9jeAYQNxm9/WLPlA0JvotXG877lMGDq9zUYx5n5ctCmHHLFzec?=
 =?us-ascii?Q?Io62mmcL2AsmCIJpMg53IkhkYjmlFmC2qSw047opdOOz6ywZKmoeI6qvLSUm?=
 =?us-ascii?Q?Xzj1OoCphQbVxI4tSHuF6KvAq1+PjmEwjdxeAVf1qR4T5/OcrLzyDwprHBqI?=
 =?us-ascii?Q?NWN0YjL3rx7TFA00UAPrt4YF23koTUHVv66mIRpXf/++LRrjBKn51pj+5FYV?=
 =?us-ascii?Q?deXcHUtTxFcBZU1Uq7Sf50qWBO1NTURkS645kmXekLRJad7M13x2inpBGcHk?=
 =?us-ascii?Q?jg6IN+G0Fkg4l8dLsrKjEhzjlI7opDAko9kTLSmpT97U8Td3Mmsg5gwEvS6O?=
 =?us-ascii?Q?ehJqTOSjY7AuilEgSF7T/VwOCE/fXDKifW5s3uBXtBw4/VY0keJ7cmvW2knA?=
 =?us-ascii?Q?g9VSCakON/X7c8p3nM98VAKujzOVGoNCkHp02oG5Fu9K2J+1hveI4lb8MD73?=
 =?us-ascii?Q?FolmAQAWAHO9SlcmOsdxQ1hly9COqxpaDzBITh0uumFLsnLWBIMEi/mD+6HI?=
 =?us-ascii?Q?vOKHCkr9UP/CBNi45Z0ipgTZaB76K26A14U4eNwt8G1BNaPySvQyLniTpPUV?=
 =?us-ascii?Q?WZg04Ewt2k1V5f9RonRVeDhLIoSMdgYlPsHgjCtKYRZNKkmXMZaneQffXiux?=
 =?us-ascii?Q?36TuORthexa0Ss6BOiHIs5IKVFVINMOoI5NqUaoQQEfgJwBrS0eJ1IyQXpdM?=
 =?us-ascii?Q?ZBVJO3TUhppbfbm8SmcVF9t9c/1kY8U4ki1KQEvqn/5SDK4r6In//zo8ExkO?=
 =?us-ascii?Q?REtbrPHRSm3POmW8TJONPep+jE2v0pBxp/+YLdYEZuiBrtrujgJ859BJIXms?=
 =?us-ascii?Q?gL+dbmtL/pPF6Oq4O1xEozOmZln7Ok6VHDWbZwnP6RXh8+Ku8LH+UHEt4jk7?=
 =?us-ascii?Q?2OK1k4E/W/O6sGf3BUoFAh+/NpQNWSJLDveE0sGzn6JrPbsZzX6oRm+tfM/T?=
 =?us-ascii?Q?5BUWFKpseoZ8xl009E35Pbh0N5BiLoT1glQ3apxV7nbpxWZ0hAraMJR41Jqc?=
 =?us-ascii?Q?stSr73dcAlzyQWw9pjjGCMmXwTtVzzSjaAnnFb6uIOtLdgtEghv/ENXSrtS1?=
 =?us-ascii?Q?10NjH8T431MDqGcL6hYTa80YFoPwkiIj2Kn4j3uaSIOjtgqWOE/s4F1X5vzi?=
 =?us-ascii?Q?/lJFWq+t0+K9jfl+GEQOYgU4jOK4QjaERLvcSzt0uUDg79UFWHHvZkGFT5SV?=
 =?us-ascii?Q?4Ycg5UAThpvMzFp7ANOrKQ0/SWfGsKjegEiFDO5YxFbIAIyTGEYq3PoFcC9J?=
 =?us-ascii?Q?IU7JMEEy0OGg2eFKWtd02YO2Q+7cRoFWBupIGUmw7yyy083EgtGFff94FM6R?=
 =?us-ascii?Q?MHrhWs+eTpQLK2FqLhJ4X1iej/9/FFC7u+EOQGOTKvNKYgW0+HKiac0fEeVW?=
 =?us-ascii?Q?Z4tNYneWP2MV+b3Q17fNvileuGIrlz1X+a59+RVO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df7d926-9ecb-4372-63bb-08dc9643b98b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 00:54:40.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aC+gBnmSsXydmQ0/aha6IR2B9KAibucjgnN+D0mr2yfnfMML9YSULxSlGPCTecII+jL/L2aHa6trh1ADAovo6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

PCI P2PDMA pages are not mapped with pXX_devmap PTEs therefore the
check in __gup_device_huge() is redundant. Remove it

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ca0f5ce..669583e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3044,11 +3044,6 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		if (!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-			break;
-		}
-
 		folio = try_grab_folio(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
-- 
git-series 0.9.1


Return-Path: <linux-fsdevel+bounces-63798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32275BCE1CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 19:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A38119A11A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF422652D;
	Fri, 10 Oct 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHUOkHj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A8221578;
	Fri, 10 Oct 2025 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117973; cv=fail; b=BFhNDCh3THe/IWRxy7Al0UoTAM6I8Grgqx4y/rsKocEMGCZ3xkx6RuIi1hWvCoU35LCts2O/wETVuEfjzAyhQPP61Y8+QBnNUcD+R1XTZzPEVCbkosNlzd/yEwlreO868/aEOOz5w6cqcLDl6iGNfcVob3deShcZRfd4U7g6ziw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117973; c=relaxed/simple;
	bh=X2EyZlK3xfelZvcHLpjhop+67nonal6AiobG6m5lTv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2k84BkHMcp8XjVrtxFeNXq1MkIvOzWDVb9pDNaZbhB0dLeRYHC1QExNKYc2KxxCrO/Yiy1yAmlaH9K3QEqM6shOfDifcKo+U6SgAAa522HDv8WhrVJoT+TmXZsNYbfotKjHqNhYApoIcbEoo4G2pIz77pQr9HrX5Vh7ziF1Hz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHUOkHj0; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1tVzqqv0fmKfDk/7QDFPH+XejL5IUSivAnHpeh1tK1d0V69m1xNHRC1d4oEBz+1UE/89qhgnwuZLsBGo7aCoQkuWGEN1gkuYJC5qe4704ru9yvOj2soK3761L7qYwhZpEswIa0xHrRxU5hGineZMxreFdett19ig9UzDq5v729U/GPxgK/oU6Z/auQTN2jSfaLvBd6qa4ne4BPeLUXQNgXeUV42LjVQQ8dFUY709LYekn7jS/Ji6h9+WXHGSWNRO2gtP0YmVLVEnS29GFYbfsxL+B74oON/ku8jdcNJ5g4YEVNZYy36dR6+1s9cSwgkh9mfCqxVBsEj0JsmwZA+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuMOnKJfatV8miB8iAdomc1r1JNtjAMVcGoydYbpwOI=;
 b=LoL6vSAhPoAQZlX2+DkyeSGK3P/PDL/9Y1abYpHMYeqf8GmNM2k+njcsK7bxcqQmEnfWO0U43IVlYbuCrxxPcxBoTe0pN6wT9jUjoeeYtp08icQLmvDFXVzDNvyljGmC5N9j7r2u9C+WYN2jDNWkuLA/z7gPekdNiuiYmhW3tJjgU96qiLLdsaho00KMsAYAsvQkh6XlCoGcwve3sBPo3hf4j5diFMejIoV2OMO/A0yT+Zsquwq0z9QpqwuaMXJqzanJR3vmwoev6Wpqc0VgWYhS8v8hQ0AejI1haZxGzB4B+lVbe+y0LCc7J9R85BIENoK2k/jJ54PQSeu36ynzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuMOnKJfatV8miB8iAdomc1r1JNtjAMVcGoydYbpwOI=;
 b=tHUOkHj0aXPd4a6XtHF+V+BGc9ASfTKSTMktpuCUg00fsXGb+UTh7m0Y0TdL1zABYTuLy0Lu1RhmnBicT56zk8Em89dXFopJFBqv4pqmP2+8F2UzBnC5ILVgE4WI94zIxtk9Ap2CtD5jdZJy7cJkHknhogL+UZeeBICbIwdHN1M26LIalhtpnOxxyvN4F0NLxvWKPO/bK20zIUYXrqq1yXSulp/HV/oDM9U9/WsaJnabHdbQjqgP/dx4hMpRGztml1a++AEWknNDSjeLvCsonRU3Uiv1w366r0nR5fjSFeJc1lA+ZzO/eOQvEfjbQMxMhd8WeUb28myoYAyvL6swRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 17:39:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 17:39:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: linmiaohe@huawei.com,
	david@redhat.com,
	jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Cc: ziy@nvidia.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*() target order silently.
Date: Fri, 10 Oct 2025 13:39:05 -0400
Message-ID: <20251010173906.3128789-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010173906.3128789-1-ziy@nvidia.com>
References: <20251010173906.3128789-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:408:143::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e403e99-b5ef-40ca-5e37-08de0823f683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K30ZexJzoPPfqz+LClBnBnfYuPMlfW9uifwq5a9xo1Rlq+ZqICcZrChQkou7?=
 =?us-ascii?Q?e6OzXK0AuZgoKt3FfDPP/AgO3s3x9vv4baN7ZqmvQHSthmlC3iN1T2Rsnb8K?=
 =?us-ascii?Q?BIZDKxFCudklvJY4W2EV4BZHYR1l+JejxiZc3dA5zsnpCKGFJZ3HiNdQiAo+?=
 =?us-ascii?Q?SJ6mnmI8VPL7z2hEeZ3/Dko3gpJxSMXvA1Yy/MX0k9XN53HcxfQGx5xQqH4g?=
 =?us-ascii?Q?jBYUwTmdBhqjes4IwL54QJRV6up5U9699bwzbBfKJR2sju05StwNK+Fz/+gK?=
 =?us-ascii?Q?b1ww6PCreDAnF6Q/VC7DSU2qKrTUSqY593D1O+cPUSmdibAbHR3txz+tTH69?=
 =?us-ascii?Q?wfnnxEIWvxDv2Qtfzx2EBba+kUfLWscD3dMW01S/2BBpoNc7pnNyJ57JGGT3?=
 =?us-ascii?Q?xhWoY72AwUcZiw63bB8jgrwB06JDLiFeGpr51JEX+q3wl2pVVyIsOaLbfWWF?=
 =?us-ascii?Q?bpw8BsChyHdOO2wQ8qa5aSS3+sonPzPRUSiX7xbkfPYbr/+irC6jrnv6yk+a?=
 =?us-ascii?Q?yo0FYcdyMzStQs6SRl9KFLW+sXZsl/8FOXhtw5bJuY/QHHVGmSvXztZH5RAp?=
 =?us-ascii?Q?WXhySUpw+fIInM+/+xqmDDO16vzXjatNOqiVAWtBJEBJLa9yvKPHc5aAOFCl?=
 =?us-ascii?Q?6rr6wjPdjpC48tYLvMziCHAWncs2CYke2zvfralBmJzuq3gaHMqJ7Aj+ugyQ?=
 =?us-ascii?Q?efQxyE9/0FPjW60wB/SDYVOw8NvAevDBscpSXe1zjO86T2arZ9hKLW30jF5q?=
 =?us-ascii?Q?5D1H4y3HsvrcMKEs1tlqhpl/ZfVJWMNggyp4OFVx8Q18ZNY3wWKsdztJBw9U?=
 =?us-ascii?Q?m3e7Gcl6IpAW5QoS/Wczefy4bvdC3wCLZJ3KDoOp/eY7g2NPH4RIz+rYojIg?=
 =?us-ascii?Q?oZyn/Ibn1la/WlOPRS7BggVPszgjOYLiUU20grYpRMjgbsMSHj/vO7AYSG3q?=
 =?us-ascii?Q?SpoEWxisaZundwlmcE4avZZ+gE+KQ0/AgSgmK6LLwsM6I6Ai+FtG5Bap8y2B?=
 =?us-ascii?Q?/RLLDj7lhf86sUDoONu65kPchHL+ixuJxaMu6x9bq1tNtRyiaP122j7EMGY2?=
 =?us-ascii?Q?MA0JodeSQgfBEmgXy+ev+5HIXVn6t9ev3F0YuHhqn8KwY/OEnH1mmtwZ+UPi?=
 =?us-ascii?Q?7mTneiAvqQrwETpFRSrAghF/U/D9X+HcbC8UfoINBg0HgnbednsF26Fad2tE?=
 =?us-ascii?Q?C2VGHpm2slz7y5yHq3a6kPJ+O0nlCgJ3DkSTX1uhNnSqlFrfIRjk3jox3oX1?=
 =?us-ascii?Q?1/eHW+f7cVRmadVMk4V5rXIkBqQS77TYNLYorCXpwJqOMEIyNEGXxdroM6o8?=
 =?us-ascii?Q?pK5C+iwZjbw30zlUklwujEnf/VR06rzl4hCQHekiBZWQxNyijUzZ5xDqd+bD?=
 =?us-ascii?Q?mEsIPF4Cfr/7slAGD4/MuoB+Qy9Gvqsb8nHFq4n1OXAl+dsiozsYHTVeW30y?=
 =?us-ascii?Q?JEQWs/BJeDfCPL35Q1/gsKVx9Rtp34Q1xTQptjI/gRACR19Njn+Psg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6rD2FM5tca5yrtqqCxx5BjPbEPKKOEcUKxCersvvZPNxW7EXdzkVrlujfuXq?=
 =?us-ascii?Q?ZCx5IIBmUBtjhKyHl229RHqo9i3soPUGUw/0ywUdE5p7AH1XS0z5XjnIXB+7?=
 =?us-ascii?Q?MoaealBMm3PtR4f85CxgW1nvYdDd7Oj11fLC44KD+u2jp37KvyDXm7EHIN3h?=
 =?us-ascii?Q?BNjGkR2bPFG4QOj+n/mBvY3GtlIUTVP5wBjiigBQ/g/TTHD2EnY5UIznCdS9?=
 =?us-ascii?Q?6ukgz5QYvCmM4kJ8HuPu6MJ2xvBMeJVyHWoQB2d4vrzMyMPCCA+wqpNYhyEF?=
 =?us-ascii?Q?PoZtpmqw7XmqVoysoioYcsc92doKoouCNBBRLUmcg3TNcRbOi2lx6s10dlhL?=
 =?us-ascii?Q?5DtUjeEGKjTDdfCzcOqc+DXY3gjAirnYEYCJCM9THCMxV4h2AHhZOMeRBxTK?=
 =?us-ascii?Q?ajswocNPTo8xqD+BvPyslLPVrOBn6M5CizJaQshsQaItoJrHlIC4ccsN++fL?=
 =?us-ascii?Q?btzLqCC39qntp0HRkpalI/T+7McIqj3CBG/5e6e+1amL50nudDVNM4toZ8bc?=
 =?us-ascii?Q?3aj+D10RWwN728iD7kS8qBl1eYuMG927jyVmuyKXRE2cCFJobodgRwNCsPAT?=
 =?us-ascii?Q?dhxRUPYARFfOQmdtseEZ2VOV16XXYBmSZawm71p//aPkgvYe5MMf6d2fE65l?=
 =?us-ascii?Q?05oOorTGarRxh0Uf5F5G6EgmrXeITPYSPOkymv6w2ZbkmFuvVvXWvVn8zdzx?=
 =?us-ascii?Q?VzyhDbDhO/65NsODUQR2mPW6tj4WrmlnfvsYsEkbdVO349SMVmTkK+dfu1k1?=
 =?us-ascii?Q?xujH5eBMwgBJmwAcXKEKLckWEXZ1IfSW23lkMWdoEkrKqQvccdLxCSu8yKwL?=
 =?us-ascii?Q?g8cJmN2O//McFI0tYN8y0g3F/guVBgjkC5uaTWrsHMpNh2E0IvSHN1P8fAl2?=
 =?us-ascii?Q?XS0NuV+fRkBFUPwD/bK7VCRLA22bUJVSXzXk6I23HLL+PbeMVoY2V4dj8T2W?=
 =?us-ascii?Q?/64es1COKe6/dc2/xQ6bFQCP7jFdghs7U7EfehS2tEgiooL14XDYM3Kujgcb?=
 =?us-ascii?Q?9K5qMttZp4kn8dp6nvczPXQOMomAw5G/IAMmPM5WGxuOJRBC0UJybKfGFXbn?=
 =?us-ascii?Q?pNJTTkTopb6pWtfPPk9EmrC1+KClN/nrAQ+nrL2xYzp1sca7uyM45PXq1fOm?=
 =?us-ascii?Q?d2tAb0mRWfcEMVq30/pc0BZd2zJbC1vPPbHQ6lgy2Df9QfXAH92VCMfhoq8R?=
 =?us-ascii?Q?G1cgw18lspALmnzmApcZMh63IXSO7tlbYILiAteUVzJuhMuoXKsFNpEK9m0C?=
 =?us-ascii?Q?I8qCzaa+nt5L+vVHGJ0jabQsN/yOnD2NtuXwiOsiWs2Mad9ZsPUaOll+t6rp?=
 =?us-ascii?Q?7wrTeThhHTGMmJhzWVRC8elHYZkbjna56DjC+5scRutpYIPeXloUcgSuvxR/?=
 =?us-ascii?Q?sGZdenD6ZrXnRxWF+Gje5u5SSNcT5y9EmUXH4FDxzUGgixDpn7TIM1kskV1D?=
 =?us-ascii?Q?bfKTEDUAF/saROqACn5hEoIb1zMa0303/Bk/MVcx7IWeyuphScBaZXFrjic0?=
 =?us-ascii?Q?ZGIqZBy/hD9Su++GbhUk2XzRBUGVOcpzJSv8WFsFI/rN9ObgvpZYigaDSDFE?=
 =?us-ascii?Q?vysy+3WTBkBZwq9/TsHopXnWQCNIo+a1BT0cs6P0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e403e99-b5ef-40ca-5e37-08de0823f683
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:39:28.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhU8GyK23yeQxZ5Pn5ieisQykbvirmbxQSeV4auxAseiwRkry5zoGz8w9h3goMiF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

Page cache folios from a file system that support large block size (LBS)
can have minimal folio order greater than 0, thus a high order folio might
not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
folio in minimum folio order chunks") bumps the target order of
split_huge_page*() to the minimum allowed order when splitting a LBS folio.
This causes confusion for some split_huge_page*() callers like memory
failure handling code, since they expect after-split folios all have
order-0 when split succeeds but in really get min_order_for_split() order
folios.

Fix it by failing a split if the folio cannot be split to the target order.

Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
[The test poisons LBS folios, which cannot be split to order-0 folios, and
also tries to poison all memory. The non split LBS folios take more memory
than the test anticipated, leading to OOM. The patch fixed the kernel
warning and the test needs some change to avoid OOM.]
Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h | 28 +++++-----------------------
 mm/huge_memory.c        |  9 +--------
 mm/truncate.c           |  6 ++++--
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 8eec7a2a977b..9950cda1526a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -394,34 +394,16 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
  * Return: 0: split is successful, otherwise split failed.
  */
 static inline int try_folio_split(struct folio *folio, struct page *page,
-		struct list_head *list)
+		struct list_head *list, unsigned int order)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	if (!non_uniform_split_supported(folio, 0, false))
+	if (!non_uniform_split_supported(folio, order, false))
 		return split_huge_page_to_list_to_order(&folio->page, list,
-				ret);
-	return folio_split(folio, ret, page, list);
+				order);
+	return folio_split(folio, order, page, list);
 }
 static inline int split_huge_page(struct page *page)
 {
-	struct folio *folio = page_folio(page);
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * split_huge_page() locks the page before splitting and
-	 * expects the same page that has been split to be locked when
-	 * returned. split_folio(page_folio(page)) cannot be used here
-	 * because it converts the page to folio and passes the head
-	 * page to be split.
-	 */
-	return split_huge_page_to_list_to_order(page, NULL, ret);
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 void deferred_split_folio(struct folio *folio, bool partially_mapped);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0fb4af604657..af06ee6d2206 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3829,8 +3829,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
-			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
-				     min_order);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -4173,12 +4171,7 @@ int min_order_for_split(struct folio *folio)
 
 int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
-	int ret = min_order_for_split(folio);
-
-	if (ret < 0)
-		return ret;
-
-	return split_huge_page_to_list_to_order(&folio->page, list, ret);
+	return split_huge_page_to_list_to_order(&folio->page, list, 0);
 }
 
 /*
diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..1c15149ae8e9 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	size_t size = folio_size(folio);
 	unsigned int offset, length;
 	struct page *split_at, *split_at2;
+	unsigned int min_order;
 
 	if (pos < start)
 		offset = start - pos;
@@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	if (!folio_test_large(folio))
 		return true;
 
+	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split(folio, split_at, NULL, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		 */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split(folio2, split_at2, NULL, min_order);
 
 		folio_unlock(folio2);
 out:
-- 
2.51.0



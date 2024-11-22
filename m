Return-Path: <linux-fsdevel+bounces-35515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0279B9D5751
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72C6282EBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5700417622F;
	Fri, 22 Nov 2024 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elmvitDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FF171671;
	Fri, 22 Nov 2024 01:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239701; cv=fail; b=B4GdAKEDp+FVF0UU0SkV3RHTpC2/vt5xyc1iqrIRJ+whT+PJIU3T3Iy2p1aP6RAmwLt9uaRqYCWVb/cIMQu8a9KtrMo/95G+SJ7wZ/dXQEhYPJc9S3STyz4isvWsn1KdC12ddW3cIu6o90lLSS4vBzk6Bc3w/aubPF1ZlrKcuh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239701; c=relaxed/simple;
	bh=v1vWy54ggy2EI1mTvBEOjq8Oc8D+/HW1Cg8DFzugicE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBbYE8B78jcrxPs4KrkWIuElzkCKxpQg9PDg8DSSJwKVWqa8lVbsu3k9pihWfJlP2MxoGMgc4gfG/0pKXE+sCmgBbqP4JXgcZRs1xs5PuwxpojCoqt3UpxnwfG9sRdpGNllGJtY63fia6MCsFjp8ZH1T9hUbuH2lBTS9rsIzosU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elmvitDI; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2pEOuUQgd9g7nAveAhiFEfugvzq2/PI1yLOGRRnHG/fepZne0UIbkVdN7JS773LJrJvzrW0BNaSesCPo+82MT9VcFkaVrH0361/gCanjgCoKoHDvZ3Bvm4KEpQe7y2CTqJIjH7WKlwEXBqerFHVIQEn63d+5xKM1XGydwTiUKfiQILomM+HltPsoPD7cK9wQsI7gnrlMWhw1qoKFfyfINk/xUGJYSkaJhw9DKThuiGSIOEFUzXx2tE8MNV3B3uT5iXaBLbjxTxQUimQZTstRZxMM5xoYbCk8Xb1yqx7DR02az2rNSpX1aYO88XsJ+VbSs3xHeI6z2VhhpAJOeDz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f593KhRS1mNvsuFcUZphZN3rMXQcZUUvYCTPQhqFF+o=;
 b=kMBhEyfQA8+UhQBBZvRkus6HJcOkBIyfMB3tf30BXZXnNO66j65nuSZCSWLHuyEI2twjr07sM1N59WzaSuQeU1sHMlqVFMrHrwN7C9YLdSjXX3BKtKAj54A9ux4yXu1odEA5ZWvilCBZQx5WCc+eZzYlAULABpmLWdN/DuwoBl64DQ2ZQ/9NDIZJF0aJa6eMrgtPjXsKyNtca4ix8r4rp4hxhdcfEou5e6knACzyYgqq98z91e0GMQYJpQszQHH5vZZ4+kM1zzYCg7rxC3MtDS8M6XrnKuAmImqyNtcVCKGJYwLFBkrs4PKbDvy3GARusFjW0wdlWU8rNsPvzAXMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f593KhRS1mNvsuFcUZphZN3rMXQcZUUvYCTPQhqFF+o=;
 b=elmvitDIuGrq68txIRIc803dcxHM/7NULS1c6UzCczxzMMj+A27iWWwl8lZyBtH1k4D4NrSIMoix8uO/0FSs3OGBNFfgSOB8oscFwmCMwNWNz2U1YOrWzqQJy8qVUqfC9nUfeTz9NbnW5XmwOnQnfwIbM0njWWJ1onsp8lkvs/V1iMz95t/SEOyeOaID2qaBG/FQhpOoQ4cbTP4anr3dm6AKZC20xgKWW6/9P/bYL13CGttssve12oVBSsrmTLkCw4pNcqKLrgIRKU7FDWlqTfxCCg5q4H0otlFELEA4UdFIf2Gq0KMv84EbhPKmXRJUzDxVzMPzEE91Aq8B32yfdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:41:37 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:41:37 +0000
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
Subject: [PATCH v3 06/25] fs/dax: Always remove DAX page-cache entries when breaking layouts
Date: Fri, 22 Nov 2024 12:40:27 +1100
Message-ID: <06c5c055f211642fe46444b7784437d08381632c.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0001.ausprd01.prod.outlook.com (2603:10c6:1::13)
 To DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 805a7d9d-3b26-4c00-8f7d-08dd0a96cd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMx/Nbr2NlZxpDMnbGOEmbrnfr+OUua8VSittoSGQ7H9zTYjS6Z45x1ikGCD?=
 =?us-ascii?Q?JE89HMu8tej3EDf73440S2zhtEUUFHz87LcEGAnXuQDj8T2OOJEjFQPb/+LX?=
 =?us-ascii?Q?2ebLfoxzFxPEYlWYt+TDooTG352fCUHSz+MzoOAUxyQxbTCeM8QcuUfZYvgA?=
 =?us-ascii?Q?7+EqqLjLHsBY7/wr3wsOPRVAyQUKTefycd2ljlbqrMmpCNqgyFLOJRp4auo+?=
 =?us-ascii?Q?42skNrKnRFbcnUnarzuq1g+ZR2X4Ggv4oFlCqh6oHP2J6nADYQ63pC/lOPlf?=
 =?us-ascii?Q?9hSCgoaocqlMf4TzEyC8Eq2Tu2aZ8R+P8RuE7V1OPaUqsrEFe6A9BMarPXgp?=
 =?us-ascii?Q?OnCHEEwnpqj9xA8LRuw/BlYHsY1X+HHjc9+Y8vlhwpKSsxAx0yLmTDDOFVth?=
 =?us-ascii?Q?7b1DtNKhNSVFO+7IzxYmxfbef3HdEfoS6VxF8FZ75QnCNA9AVAgB55F7gIps?=
 =?us-ascii?Q?ryT73/JVcnt4Sao35HCZZCyibYzoMxnjyTbnkRNzqGikgjapef64x2NooM2p?=
 =?us-ascii?Q?cyUqO2WB0bmtmfsk0AJ6fdchTakblZXOm1VjB2rFd702RQUX0dFz9slyNlEl?=
 =?us-ascii?Q?e3LP6hBJalc+SlLVPy3E60HJT/pNqkty/eZFzeZQd3gSWH4po0PkCGFfLPy1?=
 =?us-ascii?Q?ePZ8ZRs2uZVGaZX9FoPIA6jwdd6qHvdMuDwNvv5kTTs7Do4XVCt6bXugeuxU?=
 =?us-ascii?Q?JgJwL+bo25Q+xxP7+FYAAko21dKn1tX08uAdo4EDxvfPIcGauYlTtfmk26H0?=
 =?us-ascii?Q?WGqC5zjun7M6BzoreBF8cRbveV8BfydPePNv/Yd94xiMvYNyrgrfsT/FH0bF?=
 =?us-ascii?Q?mXcOwFTZPaUmYQx65VZa0tFPmpP1eibVeWjL7T5k85vUk6p7vzUuG9j1XyCQ?=
 =?us-ascii?Q?I5tZ/bEhFTqf2PQTHVJ2OVYB6396wQaGD4ysx0UNUrzWQCGinmbuV6TVO42/?=
 =?us-ascii?Q?mmruRUaePnwG0hJgXIHHinPSN8KUuwZlzjP5G9IyEj/GEOh22y8BF1YgCpj/?=
 =?us-ascii?Q?WyeNABmV8UvaFTd62cg4l2Njz9EJoX7KSONutD2a01NqnDhr7D21XSNmSljr?=
 =?us-ascii?Q?N2mXGCTb7DJW142f8ig0mftXRvgw0IKbir8DxfOizRPDzE8NpRPfH55HuW0A?=
 =?us-ascii?Q?44VlTDz8P6GHDMNnW325Or07FqWiPO4qcX8JZV7pX404TM6b76n4Kji+MYeq?=
 =?us-ascii?Q?f50DBDwocOPs52xnbAkFUwybfN4kUiuCyzeiFF9hBB/d+sqbwuGfFu86pCQF?=
 =?us-ascii?Q?yKuyGqepG/qz9JCmPbQ2rM3ZoZ42b8+x5ILbwMzGNwXsfHuh9O9NHYiiDCiZ?=
 =?us-ascii?Q?ed+OrsqQ1E+67y/Iq90oMSCl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/m466kVqvHjPoaqhdtAVnZW3fPzNhSDHnH0YonvvwNahgGl4B++61fimYeJ0?=
 =?us-ascii?Q?hsZN+RuoDm7lTSVtUzOk/n1WvJkykSvFpmcDXvXOzS3s0yq1S+SVq7mT6ig/?=
 =?us-ascii?Q?5sO4CmJFlDLaZGs4lzkW9PWjwrj9iPT23BgCTrBmtOvU0zSP88xaAz7U1+Lj?=
 =?us-ascii?Q?BRZAwBGUh54oetqEx/gjzrDxHq2HnLQ8aiY5wFw1/yxXLs7KUzGJVfk6xoGT?=
 =?us-ascii?Q?5gbfKC0+pJ9cjwcvc826JJLxLof/2TLFO3uKmmy3ecOOVxY13kgbpcX8AG8g?=
 =?us-ascii?Q?kxKLyhJxBAZ+O1/d5a8kPt1Ma+5sw0iTHw+FDtLkCLlr1QF5gWxn7ZEiibsB?=
 =?us-ascii?Q?ma8rEXyRFIdKF1+mk02tr6/IOGIB5xJqZhM1LYMZ1YAGE/Om79qy9mqCBpLq?=
 =?us-ascii?Q?ZTcr/yzUBHd5Qx72N7AE2O4+64XCZf3stzBwpZacI4N4fGaoHcm56aSuX+ek?=
 =?us-ascii?Q?cqZFIRnkHvcPVXfaql4fmn/W8wYwmATJItGJBMBlZKOXLx0e90iKB+o8rq7F?=
 =?us-ascii?Q?r41+zY7Ompp2lWs4Q0IpRQBVifU9Ds5mOHiB07tZoaWgtBZUNnYLR3DVlUq1?=
 =?us-ascii?Q?WuZnNEDBjfYQvbIjMKrB+re6o8slt6taniWJzWKO6b4FoBp6qaNV2iiZpdgB?=
 =?us-ascii?Q?xjPSFCBVfPoEt6IWu+lBwRK6N/8krRPX6uzhr4nwn7RxYmh6AQHnkgRBmw5m?=
 =?us-ascii?Q?Mh5rdopuBvhsZWzRypRmHOo/w5Dd93Ig9uw/hJ7Yq6ldtvJTAZH6Txr2s6dB?=
 =?us-ascii?Q?5iJ8HTGOCJdIWV2d3Ja6SkQ0fC5wJfA7fVs4IYt++qZ0OEVpiNmJ5rEoUmuw?=
 =?us-ascii?Q?A9mvAwLN1r84DOHdnibFkC1dMzVc72q1IOrtdv4mOcHkb58JQ+4XD+MB+GhH?=
 =?us-ascii?Q?SQWuzxWb6sWi3EnYamB9dvHSNjThRUwTBDvny+bIu8vR5YBhTWPTgmXP7nzi?=
 =?us-ascii?Q?Rd+dw83Sq2yjJYtpWT0cVJnR8fS9O5ZiNmKuKvbJ6t3AUpbjAAwKV37FQabB?=
 =?us-ascii?Q?ArIw+QWd4cNT7Y2fXtnflIpokbUVHn4iuUM7I85nNZ/QZLYNpE2fSidhy5UO?=
 =?us-ascii?Q?M/lAqVxsgkHDFXxN6s/rf7luKtjbeGh99pURksbGuwfr6FLBlBl4bpvaBkrp?=
 =?us-ascii?Q?CLre46tlxFTXo0e5Opz3lvGPD15MS+8ecm9n9hQl0LRJov9TAc73nx/KXA/L?=
 =?us-ascii?Q?hNQPRrzX7kdqCmxmMsCaiBo1rKpPCU3WPivnA93v4iqEjghxLw4lj03HLOSR?=
 =?us-ascii?Q?imeRSG95L4obWxF+5WPf1ezy+m5heERNfnU97zAhivE9pgt8EurPIa6vpd+Z?=
 =?us-ascii?Q?aiWGni4CBm8WKScSHnilFQungTcIZS6NAp7q5pNEKWpClhDiM4GVUhV2bxYw?=
 =?us-ascii?Q?AehvH4VvdPveIZ7Id8Hrzmfedfi+nVZemzDem+GJGjwP2LJS8T8zlhgsZpbe?=
 =?us-ascii?Q?dN8h2TXWa/I+FUJKDDTDlTCv2lg5n6+tHGwh6Q8pFQ9KG7g4WNvGeqhBQ4dH?=
 =?us-ascii?Q?sc+iHKKecxRI/LXY+Vuavigt0GGU9OtTepSEw5bsyeiBIQJ+pUNIf9T9BCrv?=
 =?us-ascii?Q?vRNtEY158icdY3e4PNdkmRnZF7KEX1mMbLrmVBIv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805a7d9d-3b26-4c00-8f7d-08dd0a96cd94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:41:36.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYUpJOGu2p2HQXW178gltjaARvDV5JBelaEJUOIboMa04QPuq9iBL664JWsBDxX7Y5o2UeHN8LLAOPS42dKc/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

Prior to any truncation operations file systems call
dax_break_mapping() to ensure pages in the range are not under going
DMA. Later DAX page-cache entries will be removed by
truncate_folio_batch_exceptionals() in the generic page-cache code.

However this makes it possible for folios to be removed from the
page-cache even though they are still DMA busy if the file-system
hasn't called dax_break_mapping(). It also means they can never be
waited on in future because FS DAX will lose track of them once the
page-cache entry has been deleted.

Instead it is better to delete the FS DAX entry when the file-system
calls dax_break_mapping() as part of it's truncate operation. This
ensures only idle pages can be removed from the FS DAX page-cache and
makes it easy to detect if a file-system hasn't called
dax_break_mapping() prior to a truncate operation.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Ideally I think we would move the whole wait-for-idle logic directly
into the truncate paths. However this is difficult for a few
reasons. Each filesystem needs it's own wait callback, although a new
address space operation could address that. More problematic is that
the wait-for-idle can fail as the wait is TASK_INTERRUPTIBLE, but none
of the generic truncate paths allow for failure.

So it ends up being easier to continue to let file systems call this
and check that they behave as expected.
---
 fs/dax.c            | 32 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.c  |  6 ++++++
 include/linux/dax.h |  2 ++
 mm/truncate.c       | 12 ++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index b1ad813..78c7040 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -845,6 +845,35 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	return ret;
 }
 
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end)
+{
+	void *entry;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+
+	/* If end == LLONG_MAX, all pages from start to till end of file */
+	if (end == LLONG_MAX)
+		end_idx = ULONG_MAX;
+	else
+		end_idx = end >> PAGE_SHIFT;
+
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, end_idx) {
+		if (!xa_is_value(entry))
+			continue;
+		entry = wait_entry_unlocked_exclusive(&xas, entry);
+		if (!entry)
+			continue;
+		dax_disassociate_entry(entry, mapping, true);
+		xas_store(&xas, NULL);
+		mapping->nrpages -= 1UL << dax_entry_order(entry);
+		put_unlocked_entry(&xas, entry, WAKE_ALL);
+	}
+	xas_unlock_irq(&xas);
+}
+
 static int wait_page_idle(struct page *page,
 			void (cb)(struct inode *),
 			struct inode *inode)
@@ -871,6 +900,9 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
 		error = wait_page_idle(page, cb, inode);
 	} while (error == 0);
 
+	if (!page)
+		dax_delete_mapping_range(inode->i_mapping, start, end);
+
 	return error;
 }
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 120597a..25f82ab 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2735,6 +2735,12 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
 		goto again;
 	}
 
+	/*
+	 * Normally xfs_break_dax_layouts() would delete the mapping entries as well so
+	 * do that here.
+	 */
+	dax_delete_mapping_range(VFS_I(ip2)->i_mapping, 0, LLONG_MAX);
+
 	return 0;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 7419c88..e8d584c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -255,6 +255,8 @@ vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
+void dax_delete_mapping_range(struct address_space *mapping,
+				loff_t start, loff_t end);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
 int __must_check dax_break_mapping(struct inode *inode, loff_t start,
diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd3..ee2f890 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -102,6 +102,18 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 		}
 
 		if (unlikely(dax)) {
+			/*
+			 * File systems should already have called
+			 * dax_break_mapping_entry() to remove all DAX entries
+			 * while holding a lock to prevent establishing new
+			 * entries. Therefore we shouldn't find any here.
+			 */
+			WARN_ON_ONCE(1);
+
+			/*
+			 * Delete the mapping so truncate_pagecache() doesn't
+			 * loop forever.
+			 */
 			dax_delete_mapping_entry(mapping, index);
 			continue;
 		}
-- 
git-series 0.9.1


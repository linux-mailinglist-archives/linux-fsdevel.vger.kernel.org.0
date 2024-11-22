Return-Path: <linux-fsdevel+bounces-35528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0809D57A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907031F2281A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87001DE8A9;
	Fri, 22 Nov 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3VUCeoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2101DE4DB;
	Fri, 22 Nov 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239767; cv=fail; b=ne44d8DlTdEciZGjOVXwyhbPpTYzxQpyZAW7f+sHTBUPNSWh/MQWooMnvO2Rcx0MGYxsvYXMNd/evDs5UQs+QJvZwEYkCgtn77OVjFuicyoTl83nF5N/3FTydVxDYC2EaX2sII32wdJBpRS99cINvBofT6qNlL/KPG1V/Lkd/AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239767; c=relaxed/simple;
	bh=uuDYOYtLeYImPLZGtxb1CM6J6IIMGRWkau+AJyJsks0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akoVrHOVG7ixN5rL3fISrMNWHjJ2rBMb3liI5NdOasz1XApr7uGQSuwAUEvuBRAxHlpndHgJF0DhkKtwsLfgpBC0hjG8r5UEQ4Q89IyEFwcy9B3X51KO+Hhxq8pyzzegNSGe/NvEz9sPeeE/PjyJtoGRbfu5lSRsvj2UVRWKlXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3VUCeoj; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vA4CRiuZuT9v5tT/N3Q8qIXkPC/Yx1pUAsWaoPZtzbmKfP6Jc4ZL9yNYjAQvF6fgeqXmNA5N6N9m4ywSodcEUUZ6KtW7VRWsHXQj6iaWYjOVnsSh5hjSjumgUofcIYNJFEgODJwP+SPFVNI4va5TGBmgv3bFKII+QTNzw63k6mGauhlL1sOG6MT16ugtns+tL8rz8/wsGLDJfBZcQ6LXWK//REaF2U7QK8v9FhYNfUThOJeWVj5rJNZtN1702ipqJhn2oFNWSomY0b7D/y3B3AkXA+MfjIA4V1ZaNM+TEzl5JEIX9WHwFjvyaWb/jNlD3MmtmC1OH6C7WVoxuH09NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2xU6oSD+FHRjg+/4Fy6dbYJdX7wRP3wZtGIxoMZTGc=;
 b=XanYBd/DxP2D4LruCV/z6N5pDOUdcs9coREPv37BAboIpdTRCSjeA1u0SW37509Px3Xbeq79W47q9elJSbM5lUeL30daNNixgeflrcIOl0xlute+CuXel146Su/IiUZ1VQz5vh+mCkKZ6gPcUTlrgUqKhmA/qeei5VTsdk5qWDf0w67ZjdUvWa2/eWA1yUI/vJSfl6hORrWSa/FYbUY+ZwIeDet11T3NLtE17lTi4Y4Xu6mdInn4jbKQBBIpg6Km64HiLDo5Ol6Vupivw/+0PHDt2J45RHlyvpKf2QoRfbCaB3WkujuFFYEWoSjLJGqumYnJnL68ndjMdJ9AASJbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2xU6oSD+FHRjg+/4Fy6dbYJdX7wRP3wZtGIxoMZTGc=;
 b=c3VUCeoj6yF99BOq7WkrhuCX0rlQMoq+qEnuZCC3vH6QQQyj0+10iCT4URlVl/ouiaz1TYjDRyuHMj7n+5DY79AP5ofhOSq+qmVSvSG3F6bbiMNjl4GvMoYnsQKSEGC9WX9AY79a6q9UrNG6y2NviQL/1PtwLLgtL6TChwNgLhiCCdEYGSkj6IZA+RvX9Dzu+8rIC0rJo0aLUS9GcXdEwv19tT1a9w0ICymLwn27ul+iUcRZfDboHn7CsVxufWIeB/BgRNm5d+JDujySBZvzqoIMZdRgBQ0eJzjLU81gx1isJSBOXUwHYJhz6TVJsQTwYUgzoBXTo1rHV3P90d0JdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 01:42:42 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:41 +0000
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
Subject: [PATCH v3 19/25] memcontrol-v1: Ignore ZONE_DEVICE pages
Date: Fri, 22 Nov 2024 12:40:40 +1100
Message-ID: <86b1894c81725688cc54afc8019ebb3cb3b6dae4.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: a0400356-4ae3-4c76-9b27-08dd0a96f3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgTh3UJqMWcTWWQHMqyDtb11ZYC5LrHScWl00Z5dzqzn5Te8Ye/A281z6SIf?=
 =?us-ascii?Q?tYRtJESDk5IVKroP3dZNIyhalN/Z7holHo9JCKJKdNWSOQxROudA3+xTzEXr?=
 =?us-ascii?Q?OcgxB1j147C17d5c/4bLnYerqIQJ2N/2f+yJbtG4nyXY+pkhbQWLYUyyWJJT?=
 =?us-ascii?Q?jpyPyQ3vGz6NQNXWvE/1tMNStLHirNC1zdguN8v9e2tDTiQsoouqH9i2lkCN?=
 =?us-ascii?Q?GDmCxGAtNt3nRoMIH98+yn5Mu9vh8vY0cQPbgdLFdkZj8dIfW49u236inM3V?=
 =?us-ascii?Q?2A3NTxLoBuaKE0zyYC4OX/ptfJKm+Z9guDHj2qGTUgT9mwILmtJ+HPDffzrt?=
 =?us-ascii?Q?vGFs94hKOhsU10gFL8q1zYeSFyj3ieOLa16tQkY2l1SYYNGECpi6T9unJwau?=
 =?us-ascii?Q?9MuSmL7QBo++KaARY7cRQ/biPK2vSGiyuxKNhVeMxoCCgsQYbUD0t9FlSXN8?=
 =?us-ascii?Q?xxPHj3HRHfxd4Md5wHnh+LPy/qX5iKezAHOjdP7cFGioKVoNV5Fi8TrPVVwi?=
 =?us-ascii?Q?XXMDfYN3fBQlL7nM0et9/U6Vn+HxUMEbskGThVCQWeesGx2yFcHz0x+ka4Eb?=
 =?us-ascii?Q?GQ33b1d/ckQHje0rrBH2v0kFxKXSr9SqTFqddD5wA8F7lRQs1/XttQd1OgON?=
 =?us-ascii?Q?Fvmm03rASg3ydaOWDwW3pUy89Oja75oLNG/c+CMB3lqxQVxShtVF/ibM4w7d?=
 =?us-ascii?Q?/Xg5C6cL38kmDWagD3lNqB2BB1heHxclWRfCYdUMzWNcOD2FG03ICAS8UNB2?=
 =?us-ascii?Q?U572MXcKmAKf2Drsl1oUN/xBHPNwgID6l76gbKuFlksRlpJWHzeU7FFJ/yR0?=
 =?us-ascii?Q?ArhDQgmkLeSOhDFbZygPj+t2D8Kr3dXi2TKKAaD/Mc2xg9iQMVG+fYqwqj+2?=
 =?us-ascii?Q?aTUJ2QGC6SeWORMFjNXSinnNe0LKJRkINv6hn+ACGKRdyw/8N04fbL2gtr6t?=
 =?us-ascii?Q?pdzDNpR1+N2zUdFwu3DSb/K454dIqAFmG5pOWowXUx1FeSgjhlWzuSALGYh7?=
 =?us-ascii?Q?p5GbyJVUGRMYEWCefwuHulKX5nFvE6NCHgL5RC90oaIsT4pRFY8VLNNXoJHq?=
 =?us-ascii?Q?yxy4GCe34t+DDK6OKkAzWqn+TRwMXrnl3952jRlsi/0IGzCuwA1GgihlSYPj?=
 =?us-ascii?Q?jX/AopGCSfHHcCId3n7FGEwUM9gUOkfAqizkgvEdKiHEHELKuRi8Otirp5MD?=
 =?us-ascii?Q?lJVmIXAqArAZiWNELghIYSH+WAWz8U7F6p8YKrHmBC4hncQgCyOVvPjEZN9J?=
 =?us-ascii?Q?qiEcaCTnBY/mwYDhRkdZ6uQuaRILSSqao9Zgkx85GY6SVuXe4pRlwu/TfUP2?=
 =?us-ascii?Q?BEe04+e6Iab+Aq1k+te7POM7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gG+P7NKv1NBMcLXVSZFeSqIEzlZzrtsJwVSMNPc3SgFsqNKJkYAvpm0jtdKt?=
 =?us-ascii?Q?g1gGL0SXjJuxEcqC0re+1IAijwxOtL4oLNd4I3/GgKy0hL5YejWATZDKBu2L?=
 =?us-ascii?Q?NJG8ZJsgiY4M1QEXaJrj7HFpxz/o5XVGNp/ua/AsBf3bziGYuGnmaAaDfWfR?=
 =?us-ascii?Q?JifWV3vgG2quHIJBFdrajBk+JgYMZxCUz2WFsmhok2NaLRnzbS9iQoPQ4Wqe?=
 =?us-ascii?Q?5F96OJgjEIJL+DG5MK56nCxupQkKOdiCLExj8zJp/2UQQ7RdvIiGcgmkOqbQ?=
 =?us-ascii?Q?l9RUe82V9/GFrs8H/e7j88rTT4dUj4KlkEdphwieULNcgUrDI1xIpTVleiTw?=
 =?us-ascii?Q?MlQCgqO06rwr0tzHUwLgDq86Qd7DTu8Dq7jVhqpbvgo4xFZKQHeaGW0T1rG7?=
 =?us-ascii?Q?PiKAQL6OFLC3O81zqctvy0j/Dg2vvtRB01fN359adXdv3bRMiq71BqnRs9U0?=
 =?us-ascii?Q?5GtMLqzVuuuwALVA6zfJMYa+dYJHs+P0k6B5KnU5kVbRHV7luZUvI84iOcGf?=
 =?us-ascii?Q?OOpa8mPzkArKYS0zkkoE6Wssuqgeoerr4+0ce4ov1n63o4nBDk6iPpZQ9bmx?=
 =?us-ascii?Q?gxowy6nGIRfzNyodlpOoNgUEIT9T/m55g62aVi2yU40AzFbyLZY0Z90RC9H3?=
 =?us-ascii?Q?1Jv6IHFZyGt7ZLoWQ31jpwXTUSdb6mdFMUrN4ULyXt4SpM9vv68bp+rXT7cj?=
 =?us-ascii?Q?T2ByaghsHTJH9iLw7EOJlMg+G5sRWnjkLttgXuUwDRY5cEo3NA3/JL+FuSV7?=
 =?us-ascii?Q?bAT5HJjJLGOya141SpCfacd7U2viWXaEL33icFAuJZDjvqYvruyjJEBe0+NS?=
 =?us-ascii?Q?R5Q+MYSE0Te7zh5jOVXHXuEKyDw3o3IZ9w2IQhW0WRuNh7WIkZdL87CD2KST?=
 =?us-ascii?Q?wLHHoYovi9gPyFMoWPMMpBdGmxjRWhVqhFT6z+nMXo7weZu1JwXXDCOOw0qB?=
 =?us-ascii?Q?B+0TxQEmgEGuOf27MA1cQY/hkOp2tvCTOgq+7ZZWLNg5kYOQfXmRH8BRAW6X?=
 =?us-ascii?Q?9+1242WMn0Vap7yct62zVBXZbw9JmELCO3QDYQ2RcHdwCi+t0+V+wMV81H6D?=
 =?us-ascii?Q?wfP6XSncXa7OeZEmO1r9QYwz3VaslshjdWMOXiJZnI94nbA540P72HPhHuUT?=
 =?us-ascii?Q?XjD+cIuVmFb4llPQ/Npi9fgq6q8z0055djhc4NAS6eyg4Wcad1P2CgRu7o6F?=
 =?us-ascii?Q?XfxGXt5OP9TRzwtNKq95XPVcp5O/sd+BuJuu3POXK8Ch+OLq1qaw/k12zW3H?=
 =?us-ascii?Q?fKmy9PSuZV0atWKsjZ2sytrlM5kc0LSJHXMyFEg9vVRypTmf8LGISPkSZ36l?=
 =?us-ascii?Q?/34cLZzMsegufucz7GYz28DVcQ4W7YlHS2n9TFQlML8maq0jOh6I83xScwuA?=
 =?us-ascii?Q?LPJgVWqTHvVGFAz4Oi4TCWEyyQ9WmJy1iwNy8Qm2R2gjaFrofmhYbW3/CEwN?=
 =?us-ascii?Q?rTG2u7Mp2gavofbRG02nrjCSr1fO9/xaTCb+I2V0R3nCrF5hfNHsKBSbANIv?=
 =?us-ascii?Q?8TOb0KztYJ9K+x/h0+5AoGUvnXuZAx+/2PuSPA76B07zbIs1P/fV7IPSeO+i?=
 =?us-ascii?Q?AAf0gjTPZRH8OGsmkh5Rzx7TMBpF2XrRmOSBNsiz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0400356-4ae3-4c76-9b27-08dd0a96f3ff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:41.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJnoaEdfL5nvpmzDUnjqmrC4/KNz1GaFsgxUDhSTMgcAKYYgN2R/jHcWvWEtBmQdN03aJABY4mS4f01AbBYs/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

memcontrol currently ignores device dax and fs dax pages because these
pages are considered special. To maintain existing behaviour once
these pages are treated as normal pages and returned from
vm_normal_page() add a test to explicitly skip charging them.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 mm/memcontrol-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 81d8819..b10a095 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -667,7 +667,7 @@ static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
 {
 	struct page *page = vm_normal_page(vma, addr, ptent);
 
-	if (!page)
+	if (!page || is_device_dax_page(page) || is_fsdax_page(page))
 		return NULL;
 	if (PageAnon(page)) {
 		if (!(mc.flags & MOVE_ANON))
-- 
git-series 0.9.1


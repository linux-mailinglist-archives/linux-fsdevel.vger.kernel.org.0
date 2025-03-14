Return-Path: <linux-fsdevel+bounces-44093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812CA62032
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095E719C6213
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A81F202F64;
	Fri, 14 Mar 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usCmkQ0G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEB1C8632;
	Fri, 14 Mar 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990891; cv=fail; b=PWsiMelJTrWEzjV09XnXpCZtOunqwZ26nMYHTn5bdTp2NAXEVJEB2lYqeBuWKtf8Ft5tQ/kOszV22isWFmHQQK05ZBQ30xDJgudo1Eai89XcAzPiZya4ug18b/66Lrd3nQNmdUDGgxwjRanmOX/UVErdsAyOrmvqyIFshJ17SQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990891; c=relaxed/simple;
	bh=eSrkF9WnEy9WvdbV3jHXPc5gfAFFvEJjCG3z8X/4BvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWtzRoTgM9Sxl6FWfm+ZpWV2bsYMmqCWXznipTJ0z4etO6Yo6VdeDkUDmP+q3fJ6+ZMpH4ZJ7kxa4QyT+aEYb+AumrPWknih5nRU4mqn5gQk+MOG2+ojb9QGgxhC052FIcIFrTS0qbPughM88lgRzcCZiVe/gXRC9Qzv+ieR834=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usCmkQ0G; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWOxhsGo2/O/XzwSNFl9yNKy0iLvWuui69w50b72CE8ftVvF5xg8rUYfwHdwOmATdE4DbY2pmj1dn9vAVktaSEis80x7n7SOViWI22V8U4JwSZ2GNiAN7A5b5pfS6+rMHL4v5heJliFYhMUuvxef1gD4Q7k2q238YohsnEEdSoPa+8RRIPj7K0r2AuH2EF3DLt8lbvqhjb/hsWCG+F2uG122+eruolv4NEZAtuyopS424VaYAsCtc5oSOQgtKzqwyalBz8VZewRjjTS2s1+30VY8+UBp37WSpMYsItKkk5q6BIcDOYe4McGDw5mo7ColyLjftoJqEsXVEf+X8n3a8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYriJ3ifTBG6aSAfwgreb84HuxgdP+89iJ6qwOfd5lA=;
 b=mFYof6wum1LTIV/PDcJX80ja4hYsJ2cmOSuschGcTBlDolsU1dTdZavG3mxSoYBr44GRdSBxA4fDeGohGhcXiymJwv1YId0QZP3JOg4eB+I3k/G+mtzJoMOjFYCzqLenUKSnIxljKvC4ten943t1l8/+eE/HhNV6ILtrdRuZ/gS+d3ZPssvNeLFcm6EuxUcNbpPn5y4BgSXYgPr2eiQKuPn0bI9x/StikDd5yn/VqEbshn4+kd3VP6Rh7eTudfmmU5JPtdxhikGThbd8moAUvBvBbSEts+CHvgbr2/MV9XLYKFW1tuz6Lf1QC3MJ4zOtOE4OWlWFaWdXquA6igdrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYriJ3ifTBG6aSAfwgreb84HuxgdP+89iJ6qwOfd5lA=;
 b=usCmkQ0GzZ3G5PTP8X/AZxLbd93shEYt56z2vbrz91vOV9L3zIeB00BBJ5ns1TRwxJYfZv2t0/02ab2I5o9ZRJSlV1HBPi8piu+iW4uQOcDDjAvcN2WBaACtb02wJxjvzkmNKOjwe240w2WR8cteh/Hvt+NqtdLTVK/VBMN9SJgqM2EP5Og7VklTjwAw8PWYX32TlCeSu/bME2mtbY40g0Da3FZRu+jnSxlhy5PUSyjDo2Z76BHmhJSFlACFj82O7TaMg1jbjx2f86zraJL43Ypge4f0lU07PkHrXdvsc73snjA51owOO4Sm30I7uiAfhPRMRhqxbynd1uZw9vbujQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 22:21:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 22:21:25 +0000
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
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH RESEND v3 1/2] mm/filemap: use xas_try_split() in __filemap_add_folio()
Date: Fri, 14 Mar 2025 18:21:12 -0400
Message-ID: <20250314222113.711703-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314222113.711703-1-ziy@nvidia.com>
References: <20250314222113.711703-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: d13e0440-fadb-40e2-b10a-08dd63468eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDNMxMp80IJdxrg49q84v0sNZjPDlCwzSlBHH1oOso9r//FZg/XsCmtoBcW1?=
 =?us-ascii?Q?c6w0i7w8SLBM27PhL7TG/o17Le4u3VkuV4t66RvAHN/sBDs7Nx1BmXqhKUsx?=
 =?us-ascii?Q?GHSKLJraSM1dZIsYhB0JfHEdhDczWxccBnXf4f31PY5nEelwPO1dfISiA+b8?=
 =?us-ascii?Q?9Xy4J11VZNE3/IawVS3CH5xUozXC2f17v9W8PPazg35BCnKCkbjNpMaX7Ugs?=
 =?us-ascii?Q?rPF2KXZQuy+X8aGnyu2pismFJvfLLseFZMktUqHXLnrGIxtsM4q1aNpKa5jg?=
 =?us-ascii?Q?OK+/IpTMuE9tbCzviLye0OEr6BVl7GV/gfmxrcwzTxf1KKHRhEPlH4QGHIGi?=
 =?us-ascii?Q?0QuJR4UtDFs/e+1tv0Z6B1hmshFmb6XesSdVpVum7sQUuiQp7VkwZps+q47Y?=
 =?us-ascii?Q?qW0fNrZTI38jzQsMzESC3uPqbyRMTJG+qpdqsmauZAHmrNr/+8/TGH1gIPGX?=
 =?us-ascii?Q?0fr/yRM1t43UMIGYmktY+9iT0d399jTjScQSTi8L6M+zKO+c1GKoATmU3fvD?=
 =?us-ascii?Q?3y22QykvXChvPWBJtaX8SBiHKEzlFxBNC262Y4wDP9DJo+fO67IePO9Q6OhG?=
 =?us-ascii?Q?h2MrlWzUsxbXfPhcNF7DqVZvlffWaqJsWfxnBxO2bs3lx+ynrZIc1PBVpjQc?=
 =?us-ascii?Q?6BvgHd+1ekOEg0MR8GUU2FqFgjkZbvDQ1febaI/RYWzh1B1zmx1Tzyh/bPk1?=
 =?us-ascii?Q?vVnqV/BjtzRtYuELmDhiycR0ZHmAJuAcb90fnGlPeg9TSCjeO38zsVuF6HjS?=
 =?us-ascii?Q?zj5hg8EH7EZPc5EcY3kr9/iwaYKcD/BObBMzaSaofuJGDrSSXlDSlpVPnGx5?=
 =?us-ascii?Q?79Vt1RGJuvtXrzWTdClKK2WvXh7x7NSVVq47fENNWaTTDr/9H6xezJYGHf8o?=
 =?us-ascii?Q?eJ1tMySwaSN1WsiyO5bY8oNOyZJvAtlGned7lGuZVF/RTtjgJ1tkGeOy3A3c?=
 =?us-ascii?Q?XVErUR9oaOVbjvoQvi2gG8TDGnxbeN3/amNqqFXk1TVju2vhgYjG2izrHDb1?=
 =?us-ascii?Q?My2hHrOxzMrWC8tWozG7cLxQlGceQHwU+ufEjMUyHn+/PN17ralQI4P8nAFL?=
 =?us-ascii?Q?Iy/76nrQgGmmsguEfdfpwqcTg4uTWOhREJjb6AJlDhYDNzmRwcoeIG2zEQ7c?=
 =?us-ascii?Q?tKyo5Qdla5EgNhysDhMVP7kwG1dal76b4Fty2PizsGw1+aaqgxFZIfd3/aL3?=
 =?us-ascii?Q?Bi1uxN7J5QQvFa1tAZ4fBd4IQbWNXma5yHQ9MnKYVHgxemMI98OfHlgXPj8W?=
 =?us-ascii?Q?kNW4qfwfRsRWv5dJTmqpZrPAsvj+r8sZPrc+BEFdfUS+RUCEFH8gFKXk8mwD?=
 =?us-ascii?Q?q5dEXVygTQkRPILMkOwIxsRUEhI3AZyum7RE5wpQYvxLdNFg3IvBNMftpRVi?=
 =?us-ascii?Q?y37o2Ft1GiCXcId+nitrfvQOsiXG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hU9WscXdJfCDlXjbbW55rTI7Wn7VgTLDtNTawhZtcPfQpGU9/3tuowADAw2J?=
 =?us-ascii?Q?95zwasNEOy2tIl08x5hXTJchcfdS2rMnghnILCQ0EBolJVbjzcyIuUcOoNFv?=
 =?us-ascii?Q?CVB8itwmOg3AYnTCtEKJ6mBHZfWH+3TGVmSdAOQ6wkBdK52Rj0Gwqbpl4RfJ?=
 =?us-ascii?Q?bh2Ss7rB4Dd3pa1AqMxZ9dTMnyNqKxQPfr33LyIRlZ60dV37b0qZoBJOtIIt?=
 =?us-ascii?Q?v5SDCrOFlIVnHLATAw4j+QNXT4NKHaeWqSp52VjbGX3oHLGN0XgZq0fAVXYB?=
 =?us-ascii?Q?b5QkswvqpQkT6PjJoTibW0Va2tuV+qZVk6dOoGXBAt/5LqdJOO1tvPmVDLNf?=
 =?us-ascii?Q?M7PAgHQO3K5KBPQNkbgWppXkuo8uba3fgrP0XTnzvGFlfVbkHzMZjONXyv95?=
 =?us-ascii?Q?6xMSYmhWuW/CVR3biVT1WGXtSb371R6Y+/tfUuSqw/ZTFx3DtH8iqyNLv8kq?=
 =?us-ascii?Q?gxaLdwbXAFbMgnk71if1RwpgEs1XI5+gSo/r8fdT10l1PU5f2WMIMLDv7L1S?=
 =?us-ascii?Q?E6PIHFAJHSnjUnLaStYcux6UmskVJkpEM9vr/gVwIMC/4BBIV9KTa53uZcBo?=
 =?us-ascii?Q?yCWgK/e7dQnIauYhbHxigK7qDqF4Lq3Q/fuOyKufM5tYmAChIiBRNJwsIH3X?=
 =?us-ascii?Q?tytaPem3ZEgcQ/+x3i5gujQ9j+joW6gKeibe9+htXeEq2hioDw5VNAzALtq3?=
 =?us-ascii?Q?yUp+MDzag++3derkmJmnGHHyp/+dxDuO54KmT4KcgQNmwyTOQV//j6mCCTsI?=
 =?us-ascii?Q?AzY4+oageUAku5Bh6vFTpOHWMgGTKEHzUrzQ6L3+9n1RpfDccGJUYW8T/G+n?=
 =?us-ascii?Q?5gyXwwFbSbgFjPTb/Ap7vXadli6h/oBKthgVbLXvh767nirM2NnzijyrcXTB?=
 =?us-ascii?Q?jMjjXr1iYiMRD8b6EELD/dJ15vu4LZU1Aoo0Z9SARlFMov50bhDX8B9aJSZc?=
 =?us-ascii?Q?P6RRdQ7DG4/MXpAwrdJhEdKKLyVwbDhyV1wUahvWbqcOpy3ZSAz5N1j8f0vO?=
 =?us-ascii?Q?zNca+ss0VhB3KVwde+bWckH6tleM6Xz95+M3kzxfmZvE83gZwZ+DLYt+EkP9?=
 =?us-ascii?Q?K+nl53oRTfsEnrIAHrcd3WfFJQS2INcliTOWTF8LGGfiOY0tw8mJBcPSm081?=
 =?us-ascii?Q?oQDTMdBhXTB+HZkq9ZQI/FaUW3ez5CJxGHDIcCGjm+yke2pUBJ2Crz1dh1ZP?=
 =?us-ascii?Q?mXQ0f09qDkT34OJ5rzMKuZKn1SnGGKJph2OCtlvLoTvtnnUc3iAVXrv6YmjQ?=
 =?us-ascii?Q?4i/wTu1t0h6dLvmfKKq3cVEpX8saWdI5F4jxF15dIZUzyo5+EgvJ/2UHjrYa?=
 =?us-ascii?Q?Le3ToaIh9Idyz90PhFYFrVg4G18KkHvtnbnNPUXbhkKsv1OV6bpZiAwL0Dx4?=
 =?us-ascii?Q?QvblfEeB1+GDjGqg4BeW4suAv44KVvbICKQHKCjl/orgGjIkVIU4S6kiLiDc?=
 =?us-ascii?Q?d8dc6I022HSzvdREetKUOt2c0MJKD+xkXQrbIXzUxvW8j5kSbb/vHuaPYtxH?=
 =?us-ascii?Q?YLMmS5P5k6CH0S0T6PwetNQIrGLxoXPGm0llU53ycIizC49IrMuUpsrS4YEe?=
 =?us-ascii?Q?U94uePJJ+aXzSIQyWieZswuY1VDqqv67/fS6ChRa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13e0440-fadb-40e2-b10a-08dd63468eee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 22:21:25.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxJGLKvGSsl8ZNmDVpJjd6ery1a7bHQGUoVWiyvwQ+sucwN55Nv6rSX0K5pQwceX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

During __filemap_add_folio(), a shadow entry is covering n slots and a
folio covers m slots with m < n is to be added.  Instead of splitting all
n slots, only the m slots covered by the folio need to be split and the
remaining n-m shadow entries can be retained with orders ranging from m to
n-1.  This method only requires

	(n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)

new xa_nodes instead of
	(n % XA_CHUNK_SHIFT) * ((n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT))

new xa_nodes, compared to the original xas_split_alloc() + xas_split()
one.  For example, to insert an order-0 folio when an order-9 shadow entry
is present (assuming XA_CHUNK_SHIFT is 6), 1 xa_node is needed instead of
8.

xas_try_split_min_order() is introduced to reduce the number of calls to
xas_try_split() during split.

Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Mattew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/xarray.h |  7 +++++++
 lib/xarray.c           | 25 +++++++++++++++++++++++
 mm/filemap.c           | 45 +++++++++++++++++-------------------------
 3 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 4010195201c9..78eede109b1a 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1556,6 +1556,7 @@ int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order);
+unsigned int xas_try_split_min_order(unsigned int order);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1582,6 +1583,12 @@ static inline void xas_try_split(struct xa_state *xas, void *entry,
 		unsigned int order)
 {
 }
+
+static inline unsigned int xas_try_split_min_order(unsigned int order)
+{
+	return 0;
+}
+
 #endif
 
 /**
diff --git a/lib/xarray.c b/lib/xarray.c
index 3bae48558e21..9644b18af18d 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1134,6 +1134,28 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(xas_split);
 
+/**
+ * xas_try_split_min_order() - Minimal split order xas_try_split() can accept
+ * @order: Current entry order.
+ *
+ * xas_try_split() can split a multi-index entry to smaller than @order - 1 if
+ * no new xa_node is needed. This function provides the minimal order
+ * xas_try_split() supports.
+ *
+ * Return: the minimal order xas_try_split() supports
+ *
+ * Context: Any context.
+ *
+ */
+unsigned int xas_try_split_min_order(unsigned int order)
+{
+	if (order % XA_CHUNK_SHIFT == 0)
+		return order == 0 ? 0 : order - 1;
+
+	return order - (order % XA_CHUNK_SHIFT);
+}
+EXPORT_SYMBOL_GPL(xas_try_split_min_order);
+
 /**
  * xas_try_split() - Try to split a multi-index entry.
  * @xas: XArray operation state.
@@ -1145,6 +1167,9 @@ EXPORT_SYMBOL_GPL(xas_split);
  * needed, the function will use GFP_NOWAIT to get one if xas->xa_alloc is
  * NULL. If more new xa_node are needed, the function gives EINVAL error.
  *
+ * NOTE: use xas_try_split_min_order() to get next split order instead of
+ * @order - 1 if you want to minmize xas_try_split() calls.
+ *
  * Context: Any context.  The caller should hold the xa_lock.
  */
 void xas_try_split(struct xa_state *xas, void *entry, unsigned int order)
diff --git a/mm/filemap.c b/mm/filemap.c
index 152993a86de3..cc69f174f76b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -857,11 +857,10 @@ EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, index);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0;
+	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	bool huge;
 	long nr;
+	unsigned int forder = folio_order(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
@@ -870,7 +869,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	mapping_set_update(&xas, mapping);
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
-	xas_set_order(&xas, index, folio_order(folio));
 	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
@@ -880,7 +878,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->index = xas.xa_index;
 
 	for (;;) {
-		int order = -1, split_order = 0;
+		int order = -1;
 		void *entry, *old = NULL;
 
 		xas_lock_irq(&xas);
@@ -898,21 +896,25 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				order = xas_get_order(&xas);
 		}
 
-		/* entry may have changed before we re-acquire the lock */
-		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
-			alloced_order = 0;
-		}
-
 		if (old) {
-			if (order > 0 && order > folio_order(folio)) {
+			if (order > 0 && order > forder) {
+				unsigned int split_order = max(forder,
+						xas_try_split_min_order(order));
+
 				/* How to handle large swap entries? */
 				BUG_ON(shmem_mapping(mapping));
-				if (!alloced_order) {
-					split_order = order;
-					goto unlock;
+
+				while (order > forder) {
+					xas_set_order(&xas, index, split_order);
+					xas_try_split(&xas, old, order);
+					if (xas_error(&xas))
+						goto unlock;
+					order = split_order;
+					split_order =
+						max(xas_try_split_min_order(
+							    split_order),
+						    forder);
 				}
-				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
 			if (shadowp)
@@ -936,17 +938,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 unlock:
 		xas_unlock_irq(&xas);
 
-		/* split needed, alloc here and retry. */
-		if (split_order) {
-			xas_split_alloc(&xas, old, split_order, gfp);
-			if (xas_error(&xas))
-				goto error;
-			alloced_shadow = old;
-			alloced_order = split_order;
-			xas_reset(&xas);
-			continue;
-		}
-
 		if (!xas_nomem(&xas, gfp))
 			break;
 	}
-- 
2.47.2



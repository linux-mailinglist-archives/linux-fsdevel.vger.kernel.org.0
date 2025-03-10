Return-Path: <linux-fsdevel+bounces-43640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611AFA59A86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E5E1641EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDF822F3B1;
	Mon, 10 Mar 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxNLpEhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0E22DF8E;
	Mon, 10 Mar 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741622259; cv=fail; b=e1sbUN5+cZKe7I4gcN5T5jBJ4dBOBmoanq/nyK7eGxRiK+uEwQs2CO6S/urfFWV6CLk253w7wKbnLVZWYg5SrhJaeaWy309nOB1z2yMG5R+gUO5gW25rR6bFL9YYLB3Jp6Nvpj0Cnwe+fOTUJkB0Kb+ewYcIV5rUPm/4VOoVYvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741622259; c=relaxed/simple;
	bh=nn+2oLoCNngrGEYfdAa3Sh4AxAok8z77W8bp9rNUU2g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a6zIzI10vHCdxGM+bd01nT1HtZn3TJQ8Q6rSn2YCsxah2z36fvs+p66sII0ZUj9L8cF/kJf7lSUqDZ9uFDMv48PYbuzkisnIiKQLNAql0Ion2NWbRmVXBp/1hEaUOoioiJm0/lQ1NQpNJm2ixJLugFoSlw2pbhcR2HDC9ngO3cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxNLpEhn; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHIZBEnuUdGWmHyTGCzFL6Z424RjjWia7MkJ6qA2ZpeSYxdQ2GyOmF6gaYDwef9edWNC54frWSHz3p9ynn0iwdqWxBuLvSEOpGblyCjLCOmfGFcDMwAcQfUCDHjvBBoLzPpPnuO7r0rqlDY/eZz7i2jV4B/syvxkWbTgPzEXsgzyDVSxrkL3Y9ZmJ+c8BOI1V6jumMg73JsOaqXYksxYv8miguPvevM+gfEq7cJJk9Q0BIz0ktQuJRTZnAOVVTPaunjsuOWEodJD9H3tl3JJ7Rwy5R1J67dqCBdzZpPI9rTa8qRshBBK8VU+VkFpR0zP4Ve6cp1YQ0AzFNgayo+nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccYvPW6dm8ctnBwDkHi2b+M5i+J3C6lOo76iC+lf4R4=;
 b=hsYmwrNSFiJ9nIyoEeidkPSIPeKDUdLRBlVkiPH7aQh9udiM9HJc+Dvpt7hN2QEzJ5PgM4XOYcfTVXnbtf8jgGf+GbNmaUge5WsbCM+UoijgS/wN/CLHurrQ/NN2vS5SDgbzIapiZgIKrzvGJqM6NLL2Ifs7vU62gkByc+VPU3Ian8XD9TGODVZCnaEtYVbB9zzXoB/r/7PBpIYhWGc9swrd2g/3eHpOr2Z6Yu3lIqiPd2qE7ROvYQZJ0wYgFaklKZyb9jlHFXJ2lc0CO56Gu2RPNt0tH7HrGK1dE1FwVRFSJsMNHBoMr75UHHtcZHwE/j7x87gqORji5URT0+u8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccYvPW6dm8ctnBwDkHi2b+M5i+J3C6lOo76iC+lf4R4=;
 b=jxNLpEhnKoG/dIJ37P0Mt14KDL8ClNbs01kUd1AbTjSnE9Ulpoms3VisN5PZEwQ0SFUNKLFVt3DXyPE9eOaW0BZJGpFfsdNHufLjo51fTnBTQdywdKaZaGvF40/OLvUK4m3edAt0M0mZO0T/Ch1+esivs9/RD7ax+na1t2c9iUk4ul92onH8YyNmNhHKExzF/E5JcSyfRt6V2IzlT8aWMvchMkoR3Ob1ZUEZ2UcUVxrvQJOkYYRrOXrmVh1glxwJEp0sJ9W5+54Pq0+Mv/NSd9zDd4mcx7rrOlu0Yk3PLxWzre6lNqAEJkpxsD8N1IaoT58C1UueS4o+NXkU4FwdFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 15:57:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:57:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/huge_memory: drop beyond-EOF folios with the right number of refs.
Date: Mon, 10 Mar 2025 11:57:27 -0400
Message-ID: <20250310155727.472846-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:208:23e::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c82ef4-1e5a-499f-bff3-08dd5fec45b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kT8chveS/eMHSzu8CXbHzXJrfnrhjqaalSj1lAoOyZhTjUgzPDSnt3vF6Bcb?=
 =?us-ascii?Q?u9pYZx0NMlAiUJFZscuts+blyE20Ph6ZLKOETz/FcNYSyM7XB93O7tYcRA5P?=
 =?us-ascii?Q?AOF1zw0byJ/gasggKB17DTqKiyMG1QqiquepE2xmzwLHYslZxwsoDvI70zf7?=
 =?us-ascii?Q?CDba6nm5Dbi9Vz0pgutnJZl1xCQ+JNBUTAnwQy7rI1X6De6ghWR9hKQ/wiSV?=
 =?us-ascii?Q?pyGI/AW/sPycfsHVT+egsr0A5ePKc7nmN4/AtSvIh0wr2Cd8NpVNU+5g5LaR?=
 =?us-ascii?Q?FDQjGWEEc+2gMRQbk1lHrNpQA/663tPqok5vlmFZeVFvA9lcJS9174e1BvTv?=
 =?us-ascii?Q?m5cX4D0AnNgm1SEhOHIQ9wOEHxDrh/lPj5S6jWvRToqygaSHy8ySGVipfRP3?=
 =?us-ascii?Q?UEnxkWMs5+L29EgMrte1ha/qUrgAUd+Ppzsdw+8Dozt4r5wnMt4Cd0eRnF+E?=
 =?us-ascii?Q?NFMiDqpDdJCv2J+yA5IPYhin36gd4oHrewA5Iyrn7orEwg6ulnCtQwggK5cF?=
 =?us-ascii?Q?P5v8T0qcdG2qcyW9y1SQJ1uTjtFH87YWFST8xrqrHSkHygbUkUlK0vCYuh6t?=
 =?us-ascii?Q?nGmPPigfs7qPvrlIUIeaDLZYpzgD8NFpIZK+c4JC+D3RzekqcVrwZMxU3FJw?=
 =?us-ascii?Q?DM7zldln4XbCckESAfcH2a0iWaS+aGnWWjO7Uf+RDKN4F5+fs0PTpOX+j2tZ?=
 =?us-ascii?Q?D8RoTw/w/3yFZ91mjEtrD612xB+bwvwsuh5TS7U4AeouX9v5a7fqLAkzR6WM?=
 =?us-ascii?Q?GdTgq3TofMSGHMmFQsjs/0arp1SIQfXMp18cKQKQ0ODABSl1gjiKrEdK0Z8B?=
 =?us-ascii?Q?NA00jHPWktZM5Lddsav0gRwImrewTbp+wPL5r1EknnJ/kiQcSHz8yoeSUcRJ?=
 =?us-ascii?Q?YhM5xXr+UZiI1XUmEVpkikgi5KegtyOZ7FbWFvcFXPsUIcnbxLTDSFwQQZbp?=
 =?us-ascii?Q?zFN5tVlxKNxXcBvOpE82Jh9NeC7ZjC2E6XNKwTdLcaKMNXPieonTtFhm8ZQa?=
 =?us-ascii?Q?V5sOM4hOen3qJPULnE/mAQssF3W7J6F1zk5O2xaicTWFuP13zmTW+XS2M9+Z?=
 =?us-ascii?Q?PCU1k5YKO1MH2g4XQcfSi3Bq16/MP77OmwGjpuClt3E4pCLcRgiQtuHps3mz?=
 =?us-ascii?Q?AVN4xjfVugUWgsIsz+PLwNJWSgzPlO5DvNScJZfjJTA49lxIK0YxRvkTG66E?=
 =?us-ascii?Q?0o/vn/cYIu8ECZUtDp8gS6KRVE7n/eJRy4a9B25emlVxd/y1KhVBk6GRPxgv?=
 =?us-ascii?Q?4k+W74uJPGVU3LI3xlVyEpfgkbHxMDKeb2YNIV1W/n3f37GoOB1TVTFCJ1ss?=
 =?us-ascii?Q?Oa1W1NoRWjVUvERuG8ZfXd+IKPoTWL1NhRwBfYGHbPKqNrAun3sJF3OZGF4j?=
 =?us-ascii?Q?2hvfMMJzukeV6KScVssx/RQpcv24?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?67IXBwOMfSnaretTO5rUdXrmJNZA4coQfYKKqEtKGEPOTczwcmiGJXefIHRW?=
 =?us-ascii?Q?aMcwC8yz1K8T91pF7iMp4v6hxEBVNXDw/l92MEsn0vJwhiMZjDX40DTNdTrY?=
 =?us-ascii?Q?t9lM0nvKVkq3j1y83itvHm46koy8NlS26ozHB5S8QSru7ecxiJvqUPxzaeRF?=
 =?us-ascii?Q?ke4pchmZtx86PZibAAfXekcuUADv+G5Xh4XAOV+kSbcbwSLgQwPCgFYdLhN5?=
 =?us-ascii?Q?M+82Jk25dC2OAZTNdLjRkmkTmkeBypcNzsYOZb0GJfRwpFPZ/ZHv6YL18+EW?=
 =?us-ascii?Q?C41ONsiYFvUlm1yKXJ0f5CUF8nKq5iUL6aMlvKWVpjm7OANgTr1lYlm50D/L?=
 =?us-ascii?Q?pwyjjcQBNl2ZH04E2b5cJs445GT8P1J31p2cjNiII1kYIj4bdDygoCUl+yeT?=
 =?us-ascii?Q?adybtcA883T779uictKRrtiRzWAYBAaYRZ5P82mbGi9+6YtJ0pOMgCC8iWGu?=
 =?us-ascii?Q?qDEs/nlrT4QknoSYxWcC4Gwhns5cjDfVmrofPMCrh7+BLO6XtbpZyXuP6ugg?=
 =?us-ascii?Q?Govhipzqb+LOtkSMMFKyQmCYQ3Cgw6boM6BB6vhSmlmM7gAKi5COuMDeRLaa?=
 =?us-ascii?Q?dQw2o2fRi8dwSTXuNiJ8uRjWh/aP5/lNhR3AP4euRg6V5hJOpPpzit6UeVPB?=
 =?us-ascii?Q?9+VewKOqa/Ym5usR3OvrfsOXCLQ8U2V9UNmSH4naZL8kN7SWkeR9O4XV+uGX?=
 =?us-ascii?Q?0kjXM5AxeTSxkcojxQE+rAbhOCMMklPq2M3waGPsdilwQQbR+aKXfSthhmMb?=
 =?us-ascii?Q?oksqBF2Grzij7NUa4v9+U/d71JCbzR32WdGv6irc7m2LYu+h5FIQZenMI1mK?=
 =?us-ascii?Q?5rn29EG8kE8RspWgntK1wZ7Ta43XNSn2DgJKHLt1oq8e6jYQloTPvs3ocGsK?=
 =?us-ascii?Q?Alyi+iC6Zup8obquHKgeJJOErig5QeG35AgL+ESFWiWj3aP3fAZlrnEDnTZ2?=
 =?us-ascii?Q?hPutrRHwQ83einxAST+3BsRxegqNm+EszZ3QQmzrmEHeerOddZ+85gx0iZJR?=
 =?us-ascii?Q?NFG7tNOBK0kmryPe+grcld7a80Nf3ppdAFXA+tmeAXioR8BVc1J0tZo9T8Kw?=
 =?us-ascii?Q?SoyKXeTFkyyK5RvCKy2QX0sCRp8zTe8JvCQLVxSkapZrokGHFLWVLOuzK81A?=
 =?us-ascii?Q?Ktwg0AzTflONlRubUoS+SSkybHYqdUJ3X8hOlu4pVXUFHKhrkgIR5Dqr7A6i?=
 =?us-ascii?Q?VG4UqngYGfEqE1hptgh1Sr6m2if3I5sOMuMaUxTFAW1+UY6uShYwSjlEYFmF?=
 =?us-ascii?Q?CzP5+Hqzq07apJV3t4zg7yMRjGQPy68KubJp843Gp11zno5w/bnnBTpKA8NY?=
 =?us-ascii?Q?0Q8O+0RQ2yYy18U9/FCIzIb8cn+DyZ8zlmGVBY9JkCemA6r9V0Hbf1T1hLi7?=
 =?us-ascii?Q?SfOn5Rw0xgbDgjvzsZV1MzsBaTlw8015YtWAqnytH5D480XksrGnlrYmd2Od?=
 =?us-ascii?Q?kYR8Nq9SZhowIpcdCcv9V7RE2YWwZzX9AVovlAE530lWPxm9hcKAiuW67VZm?=
 =?us-ascii?Q?Z7+EltORiNB6TIMo9DvcWyRDQy6cCMsbSUCH+j56dArrj/tTN6T++xvWIZO8?=
 =?us-ascii?Q?j5rtGV3rQnu53rBUsFBeDrBZYnFJvAI8H1pMxQRE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c82ef4-1e5a-499f-bff3-08dd5fec45b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:57:34.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNYxpBq62BuGcjfkCkRlAPQG0d0PGAwOMF7tms9rq7yh/ERAPG0xdyszKB95XeCZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691

When an after-split folio is large and needs to be dropped due to EOF,
folio_put_refs(folio, folio_nr_pages(folio)) should be used to drop
all page cache refs. Otherwise, the folio will not be freed, causing
memory leak.

This leak would happen on a filesystem with blocksize > page_size and
a truncate is performed, where the blocksize makes folios split to
>0 order ones, causing truncated folios not being freed.

Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Reported-by: Hugh Dickins <hughd@google.com>
Closes: https://lore.kernel.org/all/fcbadb7f-dd3e-21df-f9a7-2853b53183c4@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..373781b21e5c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3304,7 +3304,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
 			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
+			folio_put_refs(tail, folio_nr_pages(tail));
 		} else if (!folio_test_anon(folio)) {
 			__xa_store(&folio->mapping->i_pages, tail->index,
 					tail, 0);
-- 
2.47.2



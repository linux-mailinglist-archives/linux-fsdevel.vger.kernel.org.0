Return-Path: <linux-fsdevel+bounces-35525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD619D5793
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 02:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808392830E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 01:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4A1D7E4C;
	Fri, 22 Nov 2024 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nyeLw+Uu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34701632C0;
	Fri, 22 Nov 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239751; cv=fail; b=N7LpUBmTw/SL4kFL/+gIj4A8Ehh43SfWb8y4GnxVDpdWzmUpnlBF74iaU2hm040YCT4foUiqK3kuvmhc0DH3b5+mqkYfvZl4slAg+sl9MWUzarUSXtCwVqITngXEoLcM+ArxbzgcKfpbFfjj34mhxGFPHeHnlJelwT5OOgHj8Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239751; c=relaxed/simple;
	bh=Fswc3izhyxoJ/wP4SybgRADX7R/aT7dJ0owuGXFfC7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=laMS6hoNdCGPHyfhtZBhUtZyhFSXPUiNrR2/wfn1/DFZcpGwu10iBzHqJiwMSoQy1qzKGlsFm/Dt97yYKLqXtfcSFC/IOFnLK3R5E/IGgQonBIh0Neg0jcCTk5q6dk32KxKiSChof/Ld47nZrYgJc6UBAcEP6Yd6liJWkJNyzkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nyeLw+Uu; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEU6HQc46RQXfGb3ygsEt51gFQr4qTHHLjVGHdooVLidcXAanZc6lVZ3oTsuXliI59NEb6RBdqAfKWqQ+joUs0e7u7JtNHj7j2VTMudkV9jHlL6LVf2CCIZHNIheHJsIvEt5NV20rhnwOQCc9zEwKkwPkZo2Itx/AIidRJfhlpkOx19exMT6Tt50/jWEUBLG/j8AYns1lRK60IW8R3HH5HSjmVX1U4LPc1HASh762v7GAvKC0BXqOavw5cfjXN7pmvmJ/EJRVcS2et5TCrvOgTJ84g6iU07T8ZrT8F0q0a05iHo+PRfAFS3xm0X4hjf8FOnHbQwMa+G502opCN5atA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoOuGryreVKXelZflkuUcYowBxVEssrOVCkLycDDwBg=;
 b=qNkF7d7LK/BQa5fl/9sQbJLySbNYRPJSO4IfcJuGR5H2zfQKUueer26tZVrmjrO+mTfOaRzXZdTUQ9wyhTp4RcJv9UJWCrCeZP9Ev1fS+AlcJ9BVRZW6C+443denr6PlIyjOxlKROm9ZoqEmzzoSmk6k4ubPLzOK2uhtdeibly3d4IJkACBPL2qG1AX76grVCuRPSAbFWHLNJRQWuWy3iDmg3Sj5x2NDseoZm2B4feViRoudBi8zVjrB17k07H2f45gVHBohEPipZHprCjPC/+1uYmpkT8p9309GmTu+BgProvyFhhZpp5WLQvRb4z3JRo8fE2zh+NLLyiqytMbjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoOuGryreVKXelZflkuUcYowBxVEssrOVCkLycDDwBg=;
 b=nyeLw+UuEsrBgLZAdJtNw0u7gvZyDWICqMIdnFrVbjTgfv/OMn2Beok52/86LTmk64s5+Lai/oh3dbTu4GiJ08V3CSnIzSMEenRqKKhGqw0M67m0I1ZT2VduJDGAVkRG12mkiNGIJL5ZaeDlt16V+Q+p75zg6/5rqZ7zEmhP6LwkUYvrk/B3ljZdWNctSyljqGJcDXhZriutkN76C/eaH5HSKcK9HIaj4Wk3FyewI3uKhjncFhkW9kjTm6eU3BHBNRwWmKOjcVUzYHi2VNF/u3qU0NKEra6OQpKZK5VnFIUCzqxIisdtaTILj7U92W40M7Fo3g4g1HQJTHFNQEcGPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 01:42:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 01:42:27 +0000
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
Subject: [PATCH v3 16/25] memremap: Add is_device_dax_page() and is_fsdax_page() helpers
Date: Fri, 22 Nov 2024 12:40:37 +1100
Message-ID: <9832173195354f346f2a88244e8ef80dc52997ac.1732239628.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0083.ausprd01.prod.outlook.com
 (2603:10c6:10:3::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 839c59db-7b43-46bd-0698-08dd0a96eb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wns+OaaIx7Se79dWV+36B0Dm6HEa/shqTJI8YhjHPYjHEHdvjw0igdpLtHKU?=
 =?us-ascii?Q?UWpfUy0sR83jGpYTCw1IaZl0iAicQy2jNDcJmmM7PpO/srQRBDFzlg6ZDS5s?=
 =?us-ascii?Q?eplFxsgsIKtFPUrow9vnsM/bIUXZrqv62cxH4OMeCPNgQgfuFwXHZz49RemZ?=
 =?us-ascii?Q?WAugeXJxQH1wHgjVIypzo7JaLvLrJdaFqKp8HT9SmNB8WXElVqieDRAf8wYc?=
 =?us-ascii?Q?ZSFx4Z1AMAa2rV4CpPYtmdT0UdrBN0Iw8LdBzrTqBGqwGHp8PDKiAdDqC+bt?=
 =?us-ascii?Q?RmjFWxtuDk3mZM+uEmkp8UcoR46QswwM58xFkZnV2biBUm8AZT+U3xvj/Sbn?=
 =?us-ascii?Q?GfEav12SEV7OVWLJ4MUGlyoty5IFGKplBmsleoeeOHt8R8v6QswATERGRKTU?=
 =?us-ascii?Q?omHChXHl+11HUHMJXbUFSdXN7g2DKyAywLltRxLiVXOVr1NZrYY7eTQ1H68S?=
 =?us-ascii?Q?P00YBdkafakDKOg+LeRBwfvvLxn+lriJPR04FlxdDhylholvp0X9QzGWO7/H?=
 =?us-ascii?Q?izcM2gD5jUGu6hszXe0qakMzdYcfxYsRCkKMoDMc04knckOOeAUMfXAXVyY+?=
 =?us-ascii?Q?1xRU3S8lGQlCAKh4TUwGtHgMq43LTv9PvVsiTgbEhrMuGu5ty1NXWkt9Lx4O?=
 =?us-ascii?Q?iON9WICN3phVHMIrESnSpuXT7Avzmy5szBlTj2Xjw6evsf/BlC5W5wLG1ckV?=
 =?us-ascii?Q?7CR8h/zeiiEdXyw1LC1hKLA84+3u+SusiN0BaA9Mar7FgXeJemH6WVsmNB0p?=
 =?us-ascii?Q?QVzL+h4Rpg9zyelV/89bqAWrUrOjT4AIj58yUI4y5brHtJYmDvof0j+dTCIv?=
 =?us-ascii?Q?AaIFyZU7DFC3/ZDe4RoVDZW9CQTMcQE3PMrgqf4PAPVZtOgWcDVYS5JAbYrN?=
 =?us-ascii?Q?bY8JKYOxDrNfEt/FZrsKAJgiXIkkuskCvTT5mi9TVWlyxTuaUtuCXYARFY8H?=
 =?us-ascii?Q?iHGwdowi95ck9YxQBbUn2+cda3WrQyCrUu3yXiOntXJntapOsnwvhib6gHdq?=
 =?us-ascii?Q?l3hVEjfGYgdLM5lHsJDA+5nHi0iz7dBUZuDmciGV5n1UuDSAylJbTwQBhfz4?=
 =?us-ascii?Q?yR0eNZNybsqBEQpGtKu1l3kKfFq3q1QhuI/PiAUkee+hO9MznvJycxk7okdj?=
 =?us-ascii?Q?SvCMCoTPBagi36MqgVMp/FdqZh4OJErcefIax2NPS4wIed/sfNLAOsbRiekY?=
 =?us-ascii?Q?Z0V3TqCIiao5Lfh5TaCrLQfEzOeKyfuJVCjVz6x1H4qxnhITevUhYLSHqyPW?=
 =?us-ascii?Q?Cy8jmuEiasmK09Evzz0R3NFltWDOHlNe/ZbJN0gXP5L1Kl+A6Sa5K9j8biM6?=
 =?us-ascii?Q?ZRI5LV+yrxenD+wObs+WQT72?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6C/FDhekc6Y6ogJHR+FB5NJSJP0nswtQpShbBu77p1KTwUMzGoIm/2TDGEg?=
 =?us-ascii?Q?JVwcclUqZTVHIJiYcSzPdma1TV2dxgPMvZySgzAe0QKXHC/YYhZaIcFy//Sp?=
 =?us-ascii?Q?bYMarqKJ2nyXk/5eUFTFEAFsChrLRAr5jc6p2e2qFmFINaiTaHJYOo4SX9JN?=
 =?us-ascii?Q?loz4+S9PZiZuO4+MYfJvgCAbsCrMCGIYQqSfuzA/ysQedlZexRsskml1v5Si?=
 =?us-ascii?Q?oPMmwBLEUOxt7nNP1mVGWpzHAlSUWwfwwMPJVlWJmcxaYgZM0VxzdCuxudPm?=
 =?us-ascii?Q?eoleLdnTkjHwlrHPUuxpI8BYXcyeHMMWdca1Di6Q34wqA/SSVvCKACyFFMui?=
 =?us-ascii?Q?RLE0/Ghvhuv7N37hH+rvV1Fo1/fA/Rnjpr4iWU8mWR0/87azvHb0+ucUdr6i?=
 =?us-ascii?Q?W7Y6E4i68EWnN4aFZfdOruusRZisw10C4iRelKsPClWm0KdUbpzOD5q18Aon?=
 =?us-ascii?Q?5J6/Esa+RI/gYNewq2E/X/U/0OqSoQYfbj++OqI129rukJqVsjwMmySy29c4?=
 =?us-ascii?Q?ZH3VvyyVEM4OMe+0LEVP1McyLdYwxng1yu2zJHZGFudIl6PbruZJwtIQQ3Ym?=
 =?us-ascii?Q?iAD/xaDXQQkbvf6VgbRvPwvHMG22YkOsEkfpR28dxPY/mNDnoe4P9ar//xq8?=
 =?us-ascii?Q?ZF65OsaDZEIe69pkQSCMTVbXm/uzQUCuoKAysO0fWCJdAWokF/Ddrgp8taH6?=
 =?us-ascii?Q?LW5rsvDKu7zo7+//UNTNpGmX1UnPKq8vgMDbHcsVv6dNZW8Bn8uyvjQAOAF1?=
 =?us-ascii?Q?GbPP7M7BOikUQnHA2DdRYXN/2p6zxkfwnkMKn9AcvUZbPY+H1LxxlHv8+uwB?=
 =?us-ascii?Q?3z8JsaH+JT4pjTfzWYXHG0vE8oIiakbDsg9QNBcbC8tXqDsfKCVHvcsfaCHB?=
 =?us-ascii?Q?HcsDlQIN59xKQ96RCO8dGQ53n+tOmbgLoD7ylmmYknSSjOv+dZgbfbHEpo7x?=
 =?us-ascii?Q?8rlj9P2lM50zD5227fkXMdxtYTRBc5ByVd6/phHMBW6DHKFRGBWYY0REco2j?=
 =?us-ascii?Q?lvHPhu7vlz7xDUSeU8spIMIiv6Q+Kr8ndPHqdedj0CgOveESThBtmbGgbjec?=
 =?us-ascii?Q?HstplbBvbKxcRh4IBMsC8lVK94fvmlfrfdPCRJVLVitozH1fyGiLK/qq8KPA?=
 =?us-ascii?Q?CT839bEeBgAS0faubpFqoEmd8Kkl9GiDsmnaHWWis/xLVw3SDDxuFjwIPR9w?=
 =?us-ascii?Q?XlzXouoTBWAV9yR4qkkuMWMX82BcRkWXJOAM9JrkKRfcwfrElHFjMZsArwfk?=
 =?us-ascii?Q?Q7toe4PHa86sGBhnospswArbp23GY3c2I7E5VNyDdJGFUJDo3D/+8W8ddFEz?=
 =?us-ascii?Q?4nBXAQ1Y2Q6XXEUCzAWk5ySY0vyf70FiMK0okyLtryLLUoIgqxsxijh8Fhhl?=
 =?us-ascii?Q?4pRhkoqGPBc6l2ZA9VBRy2p+2rNp+dOrZBTOh41pSxiH4piGwJ6fKeL48OG6?=
 =?us-ascii?Q?XxkyEI0mlFK5khH0qrXp60G7Ckj2YbcpQ6i10K8a+bN1FG4cYKThIEywYutr?=
 =?us-ascii?Q?Lrv+DGxwdanECjZgLeC3BJRNHBDHa2kmzOsVVr6B4lmXxwBnIl20RQYzoUig?=
 =?us-ascii?Q?EDL/ZMbFKTTaWmckIutIMfOXJg49mbki4JfZqsj5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839c59db-7b43-46bd-0698-08dd0a96eb7b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:26.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVjIPKj6LDJY7EueB6RQVHwHdg8eEbz7/peu0sGS45eIyYtmO8No5PP/sx4TpS9K1ZxkSzMwYp60NjCAkcOTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

Add helpers to determine if a page or folio is a device dax or fs dax
page or folio.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 include/linux/memremap.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 0256a42..f2a8d13 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -187,6 +187,28 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
 	return is_device_coherent_page(&folio->page);
 }
 
+static inline bool is_fsdax_page(const struct page *page)
+{
+	return is_zone_device_page(page) &&
+		page_pgmap(page)->type == MEMORY_DEVICE_FS_DAX;
+}
+
+static inline bool folio_is_fsdax(const struct folio *folio)
+{
+	return is_fsdax_page(&folio->page);
+}
+
+static inline bool is_device_dax_page(const struct page *page)
+{
+	return is_zone_device_page(page) &&
+		page_pgmap(page)->type == MEMORY_DEVICE_GENERIC;
+}
+
+static inline bool folio_is_device_dax(const struct folio *folio)
+{
+	return is_device_dax_page(&folio->page);
+}
+
 #ifdef CONFIG_ZONE_DEVICE
 void zone_device_page_init(struct page *page);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
-- 
git-series 0.9.1


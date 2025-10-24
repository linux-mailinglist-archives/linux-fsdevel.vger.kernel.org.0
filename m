Return-Path: <linux-fsdevel+bounces-65421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 961B3C04D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C4F14EECAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7172FD69E;
	Fri, 24 Oct 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rcewT99e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xosXiQbV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD232FD1B5;
	Fri, 24 Oct 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291864; cv=fail; b=RaqeZIRe99oHYjM3C6VuTA/b7FFg7THKN2s0w7mxZTPRlnAlaRt8KEIZJaXkDdvynn7O1F1H9i0vxtJ7HVp9pRTqL7Wj0hEhGEQdqzIb9ppLvpghWsIpsKAtrH3s4a2GOA2Rkn/WDxqyBQ0NeKWqyn6Yr4EZ8JJXSah7UBmPqjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291864; c=relaxed/simple;
	bh=w9xu4UoNQn58Wzw4yQfPHTDT+0DjzY9I410qKSbqgJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqV5HYIUn5bckmEHsM7ZACr444BWFwftXjA7dp4L18kgENY1zyR+OVIpVa0Pp1UJyWyRfIMcAtCDmCa1ajOR9DIu+HC9XgaGyZjhIHdAF5KgaA1RhgWIz1OY+hYV4DOL4cPHlcozK0Rj48cH7k9VnUyw1bS7ndQpDnUWUJufcoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rcewT99e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xosXiQbV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NwH7014049;
	Fri, 24 Oct 2025 07:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Z9/HFJjqZTASuCVIxrIGG//9Ex7AwZtZrcOQCT/O/Yg=; b=
	rcewT99eZkd3KgXAbx3Wnao0HjBoW0ovFyt2s3nK7cE0feGcH8PuQFm9KBbKkcqW
	10Ack2OPUrSkcpCnaYiLD79TyWIF6qX8soTDtKCBefRF5GjldcP6ZJNhCyL5pagD
	R/MFQLmeIqgbJnxNxkspUMoqOVcnRcfgEgJ/UCk/uGePtCENUa5zKUesKrZkDM9w
	1IjX5YzQwxMFnqCIoSD7nibN2hDJikpdb2KxQKPqFBzUJsupzoBAv3HrLBCKifL3
	IhAYJ4qM6bV52OPgOm0Kkc+ZtGTLVt3Dp4uyz0LysgNXyYBBzrB8L8mOhvtIQz4P
	Rg/M9b5tUF4WVvBSesXLdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah1vem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5cSME035805;
	Fri, 24 Oct 2025 07:42:21 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm583-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLCs3aHrR4XTlUAhTIZ/ebmfiO7WdGavcu4ljUoxJIiYToXd/jZtysTPSXy5LgbOUIsGcZkjJ5nGpJkXyhbuslbZoWdMX8WV1swNIXmDO5v51lR3hePDyExvnkkSsBu0gK46IwBmUvMEtr0WcGOIcltwNp2LLiYVXgVH0aNOIUjvsizmgn2kLC3my8txkAxHNSyfiuQpeq9bDAOJ6ZfnWNzbSUAuo80h8CaqEF58t8Z//QAyFtl6lIEb7DO/wzkqHJjfZcEzk6p4FUb1ZC/utLzZdIr5kOQVRZ8ZUCmCWSDXpV5OVTCmpKIQ/GQaYtpsck2QcLaVLVzzDkEIJpXRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9/HFJjqZTASuCVIxrIGG//9Ex7AwZtZrcOQCT/O/Yg=;
 b=TVx9Ol7aVoatdJQsoJ/DKpzkf+XzW0PEgedLmMSGr86c69GU3PwDMVJGw42/OPo5M7qwxZbuuFhMYl3Q1XA053UZ7R7M/2C6wLKqFw95g/lmWFnUClr53kAmaWJKL/3ix5P8fy+AetM7j0jnuvS5jfCwPK5KKzyZO81HtPtBJFJVANcQehEYsEa3rToCvfnU93+JmsaA1K20rMN5uHTGBbKG4WlM6vPMPBoKU7BzHl4Gh/E9OEgD+Yp9vpdOc24A1h+6+OVbUAY/9KmfL6t5U91j5exYHS95xTUhiahIgFDgcxVIh5VcpAWWilrjbWjuzUt6r4b7khUWXNFaW3wfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9/HFJjqZTASuCVIxrIGG//9Ex7AwZtZrcOQCT/O/Yg=;
 b=xosXiQbV7YZptkNWTL/O5TkXjBF9f/jxNRfWS9H+WeXeOInr95da3vu+yTV5NBM4CIlnQ561TSMOPEsWzm9CrqAyTkIgfYI5ty+BGWJ2PVBhtHkNHCY80h1kFeNVrHJo2rdZN0DCtpLZRSUEA9tyFAqkOEJrv/4Bf+kmOB9UF8k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:42:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:42:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 10/12] mm: remove remaining is_swap_pmd() users and is_swap_pmd()
Date: Fri, 24 Oct 2025 08:41:26 +0100
Message-ID: <99ac314a609ad7c4cd0c1cf40db7d25d1c5ad65a.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0044.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 84eaae50-5bd8-44a1-d9b8-08de12d0d8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0C3b63kma7idbbES8b81FoI2AShlTKrRsaskLh23sF0o6/yk5+YOGKSbf7fU?=
 =?us-ascii?Q?6XcGwQ9lFy1ZJJOZroKS9otOrHj4eE5y/wB4cvvvIk7ajCCqMHK5o/hIyGcO?=
 =?us-ascii?Q?Au1DkSn2dt8IJs6CuId9yndajHZGfLuHwg/ddm3AUXDyCK+wNRJfaR8ZITaO?=
 =?us-ascii?Q?5pawuxcEvXm/KIHhypuBi5WS3Vwjz5zC41T+f2M7QxZGG6za6E+aaBXLy3ei?=
 =?us-ascii?Q?bYSlHGOQev5mw79A7ZrnMuiHc6Du0gjV3pdbnbH6QQvvbhbMJr539olpFlFY?=
 =?us-ascii?Q?gLRRDS28NslgpfWBT409mWrm6RpGGg0tYQDxlDxghwsJa/t1DnLVzuQ0bo41?=
 =?us-ascii?Q?Ft2fSVJ593Gryb91Qcpq5I3V2ERZxTFXGFBT8PN/r5b/n4hRJpznGws5TWvF?=
 =?us-ascii?Q?kW8CPKa91+IFqQ9g7+rLn/pliKXx+oOQCfyn2oQHe9B8yadfuEJKJkMzUvUY?=
 =?us-ascii?Q?+f/qq+QsjJFyk5a9kbBkbavTispvU3ztQI8AE1iTxF6WKTGOTlycpcOUe2+N?=
 =?us-ascii?Q?q4YINebHI27C/gbH7KFLO1MsYOc4+3UOiOZCpKESlH2VYJ78SyOhifvgfK+0?=
 =?us-ascii?Q?cEtmLWJYeydJh4OvdXNU/nOQ3snuWj0yeRrbqhGxHPo9PlM0Qcn2YdqUChLa?=
 =?us-ascii?Q?/QPrNkMCTbj528WhW5ACCgCsL4HPOv3QvhMhyhGO8DZi2amwbKVIxbts3O2L?=
 =?us-ascii?Q?hqrEPsxBoOncXn/tWsTn0FckPMtUMvNDNawWFxJzwCUOyKu94qvQHi43krnT?=
 =?us-ascii?Q?07YsSIS9ReknvWr+Lu0Z0xG9MoiMyKufxgDWFO6EiH2teBCwcabK1JRL9lGA?=
 =?us-ascii?Q?hZW5zeTfYH04i9Os8twnHyl1uZ98FoMUFq2z7tOfbBYLQM+1lMeZdRGemmlN?=
 =?us-ascii?Q?T3vgrIRBl8rU2/g/dvsFbrjUeZ5XUKqnB8R+5MKiU221+MmeTHZdivp2F6BQ?=
 =?us-ascii?Q?QYukya24UsM98PFFLeQJiZo/6eIOD7D2elCb+eKqFEwaYra4NS5qjpo40wlE?=
 =?us-ascii?Q?wOL1rsN60swdwRywMKccG3sr0en2nqdAxLfTN81eiet9mGBFT4o3uhN8T84K?=
 =?us-ascii?Q?Mu5PNwe3W32HXLNgMYJtG/vIZ4l67UCj/4IisKMBsKlLrYIPzEkOMinRIi4m?=
 =?us-ascii?Q?UVSyp1QDrLfpgEW/BHiwUA8kFJf+ueseTvp5xKjgfw5zy5xTWfCyobWiZa9W?=
 =?us-ascii?Q?5mAWK/1c1GoHpYiC8TaRfBgYz1697OeB37OAXoSjlw5cda5hRVHj5r06Bxa2?=
 =?us-ascii?Q?0soTp/VSH/oTYxDaf+FFrH16I2au4QrdmJct/C8vY1pNq76gOfVHVJEkLnWV?=
 =?us-ascii?Q?F5JwTeY4v7nJcClP+BY9rudAT8beDdhoXJVn4iFgeQXDY3n4IloYVXK2DYZx?=
 =?us-ascii?Q?iMY1riSyOZhTISpvEZwT3d++tsRy1lary9XkwHchfFhyvfG78iAVVOihuxft?=
 =?us-ascii?Q?b9/JUgw/7U7th3UgfZDLg7Ek4okh/Di9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDx/12cpFKk9UW/nRTENM+rp3WKpoie+D2gDpRINSMIz0+TLOl/QMfBoIr6+?=
 =?us-ascii?Q?sX1YPFF/RZ75A/sqWJbJ5jqb+ulZFnR4UMB2kt2cjGOsFKbAcbFAJpD4Huoi?=
 =?us-ascii?Q?RUOEY69OEz610lWXRO2TZsSogZWPkl6QOiOx4+cnKtTxHfBwxjyOI0CnOOyT?=
 =?us-ascii?Q?WHijJCScskMwg9JkRAlrEzghcl1/SW9zNbQXNrfWHHSfHeS9Ys2RlVUeq/bH?=
 =?us-ascii?Q?pf6Y1p9ORtyeD4v5d/2hg0PitD5J8xYn3lQwAwspu5OZ3b1mfUflftEGPcp3?=
 =?us-ascii?Q?ATaN0lJFpsitpm1I+xjc+SqFE69sFNQnxWNcQoohn8Dhz+DzW5rYn2VZm/5q?=
 =?us-ascii?Q?p6f1/ALR9K2EjdxrrAizBTpaHNSD2F/42K1iusOnzbPb2p/o1c4mLUekA6vX?=
 =?us-ascii?Q?7x3p4nVxRiLmhT0dIGQguqltj+q6vD9pYQ157l81x3FeM6/C7eH/WhFJp2In?=
 =?us-ascii?Q?1Vohv6l/ijGnElaCOY4v2mrjMYXZLzCas+vYTRpDYpb9BAVkH7YfvDyoxEj3?=
 =?us-ascii?Q?JyrYkQIavDI0zyERr2XvCMhwXF0J9gq8UwiyOLbEUvgIlERnqzkzZCaLOLf1?=
 =?us-ascii?Q?slBSTVm1t85K3yzNtVH4y6nflA5UD0EyvwABMt2sw9aMEFWsaN7uhMJH+Qm8?=
 =?us-ascii?Q?n31A4oskI+kRbS/N8okosk+H2uh1z6uoD5XwjzkFvOGjog8ZE4o4j2hBpGQE?=
 =?us-ascii?Q?q44qxWIQg4+gWLmdOoSkoKkKDcHo7TrJlrQBk1kMzp7S9B0wEChd72ED7Gh6?=
 =?us-ascii?Q?v07gcojimjZILz8mch64rByAypO0Ols9buM/ZZGWYXj42kLodfM3h6IGQzci?=
 =?us-ascii?Q?LsyvcjI1zr3FPruuWEEhnNe/Nr8wiWyn7af9uDAHCvOarbCXMu8B2dl82K5m?=
 =?us-ascii?Q?gCY8eA1M3oafSMGgQIdWoJvg2z/sBQ1YTc2m5KpUq6YciAhhlBqG2StCNNVF?=
 =?us-ascii?Q?1OIRO6nJglXRXCadWlfA9FCh4nms7lJGIr93ekC9RFjDz2tIuS8ylqt4p3mg?=
 =?us-ascii?Q?hpy84W1gwfmdrLV4rfFuM+Vnd0AwwCxt9kEssPm58z/x2WrgoeJTmMEo30MJ?=
 =?us-ascii?Q?KJsH46n84XOh8iUr2KqONFqnvTgXFKgM7yDKWMhWVJxZ1D4yxiZfAEMGpYwD?=
 =?us-ascii?Q?oxjQ23LQFb1sW77v1FjTee7PX+w699SSA0CK71hhWheRxr+zwhmGA47Pp+Qo?=
 =?us-ascii?Q?22062PVgcl6OjRdtflD8Yc8o9Q+1F6YFnxkXzuOelNpwidudrYB5b3uQNOke?=
 =?us-ascii?Q?GOgwguRbtSovitngIRenNXf05rt5w1KGlZ3dCe0MTqnu+NX+U32YY2eobdgv?=
 =?us-ascii?Q?INV34p+jyPbjB0aPXcaKTdr7woPtBfZetafl36g2JoAUr3NjfHAg3e4BuWzg?=
 =?us-ascii?Q?d3XXShTXIeLzvNvQnmYqf/a/XYfefSVx8MWTt9NgnqiZTxx9iMghYk8wnQP7?=
 =?us-ascii?Q?lI9UEpuGLWS1DGdifwzH32tuocbSzXucDa1gz64VfHTIRQfQLJ/l7eelSNsn?=
 =?us-ascii?Q?I4+jjSsIOZTyLWwObB5V3IER94M+571gbM/i2okE2wDlTpTpuMaykmsOhMDj?=
 =?us-ascii?Q?3EUr47IMilvwdjwHI7AM+3hbQsD3nkVeF4/kjGkviphtnSm9+zfRhY8vNd8i?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vcSGxTYHKyl0//sKpvzEysFrAckHOHoRDzWDEh1rbAIWHRG3Xhke2oX2KvbGvgrlic1nu8awyzhICxIVfdHshDy5lktvY/e42XcDCd3CH9oXNeID55t4zOgNmeKnqxEIw43RuWrhZku6+uMALH8cV7qFqDHUr7hvaYgewuYEz5n06/L6cfOSx0ja1d7+5tcEPXx/g6qjBRRJ55otD/7JhfQ3zVn7ieayAumuk1lHhIF8F47oq1mlIEU5hRu26Vr5pOVst1R7aALFr1bCX7etjswJSvPtxkcVa+qM8k+0qaUeBaCu6h6Bxa2g2PvWE6Nds+gpo/xthUqJyecrZke3UTE39l6Mx05hLLWxol8uNBqT8dDe2/4DVclAF3yeV+3MEYANWt1328rD7fpW0VULsLhj+3wZpBwTb/m5rMR0hAQYZI2Ea/qYHDyPUu+qcyp0xjdQq4pT/cUF2TUZwokH5aR/RVN6FDPwLK+kVDBOc/BwIer1kMZbnrjCJQXtOm4b3OTiE0Ygo0bKxIzQ61cau/X3qYttOkBGz9hlOie6H0aAfUY+LehO51LYWv86BUXsBaI4cCaWRAMsVPxMkcu1O4QEzbU6VEc6YRa1MQHnOP8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84eaae50-5bd8-44a1-d9b8-08de12d0d8cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:42:13.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/y8cHTpLE9PZjqhGLT0TnxcxNrrq3nDNERX5jg/RqvLWQQSIEBGjDjXlmplTJVd4NEX75ESSTrojd1coB4ptAOCsPQrgoUTHL7HzOKl8J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-ORIG-GUID: 4aTeWCQIpipV4c7cnXLKXJR9R0ApzoUP
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fb2ddf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=J3929my6B9elC3dWIwEA:9 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfXys+uuWOeH58v
 BJc8jmag+yVYAiKWuTGyzO5uyg3eSt3HeAN1GbzKzQlChvpsQ7VO3R2MDauo/vp4NgpdCii3vLU
 8pdsTRhqVdQrz38eeWn4smfkdYFXEWthkmd5xJ97TtydtwTrQ73iH3N065RujyMTt92F05xb1BN
 HeIloaU/dEM0jAA4FF9AfoO4A4UUBqMgtDy6j+Q8HAdvJc+tmy5L6Q0axScgrazqSllUHS0CSMf
 ACK+8MKNi4GQsDdyb3eIRF23y68AFxecFJDmhE5lG0fZBOernfrCjrX9SFqIWEWsVRu5SXOUMo2
 lYLzswf4h7nz/5mCovGbsIZAikMin9bRIPpzGv60XmuInlPJ+LAoulOK2UiIMVLdf0a71jzcoSC
 QfCTZpiN6opePGS/pmGQZVdPiCpk07+z1yAp7b0Hz/ZkCRSAw+o=
X-Proofpoint-GUID: 4aTeWCQIpipV4c7cnXLKXJR9R0ApzoUP

Update copy_huge_pmd() and change_huge_pmd() to use
is_pmd_non_present_folio_entry() - as this checks for the only valid
non-present huge PMD states.

Also update mm/debug_vm_pgtable.c to explicitly test for a valid
non-present PMD entry (which it was not before, which was incorrect), and
have it test against is_huge_pmd() and is_pmd_non_present_folio_entry()
rather than is_swap_pmd().

With these changes done there are no further users of is_swap_pmd(), so
remove it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h |  9 ---------
 mm/debug_vm_pgtable.c   | 25 +++++++++++++++----------
 mm/huge_memory.c        |  5 +++--
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 892cb825dfc7..0c3a002dc10f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -484,11 +484,6 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
 spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma);
 
-static inline int is_swap_pmd(pmd_t pmd)
-{
-	return !pmd_none(pmd) && !pmd_present(pmd);
-}
-
 /* mmap_lock must be held on entry */
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
@@ -684,10 +679,6 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 					 struct vm_area_struct *next)
 {
 }
-static inline int is_swap_pmd(pmd_t pmd)
-{
-	return 0;
-}
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index d4b2835569ce..5b8b0024a492 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -74,6 +74,7 @@ struct pgtable_debug_args {
 	unsigned long		fixed_pte_pfn;
 
 	swp_entry_t		swp_entry;
+	swp_entry_t		non_present_swp_entry;
 };
 
 static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
@@ -731,7 +732,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
 	WARN_ON(pmd_soft_dirty(pmd_clear_soft_dirty(pmd)));
 }
 
-static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
+static void __init pmd_non_present_soft_dirty_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
@@ -743,15 +744,16 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD swap soft dirty\n");
-	pmd = swp_entry_to_pmd(args->swp_entry);
-	WARN_ON(!is_swap_pmd(pmd));
+	pmd = swp_entry_to_pmd(args->non_present_swp_entry);
+	WARN_ON(!is_huge_pmd(pmd));
+	WARN_ON(!is_pmd_non_present_folio_entry(pmd));
 
 	WARN_ON(!pmd_swp_soft_dirty(pmd_swp_mksoft_dirty(pmd)));
 	WARN_ON(pmd_swp_soft_dirty(pmd_swp_clear_soft_dirty(pmd)));
 }
 #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
 static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_non_present_soft_dirty_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
@@ -796,7 +798,7 @@ static void __init pte_swap_tests(struct pgtable_debug_args *args)
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-static void __init pmd_swap_tests(struct pgtable_debug_args *args)
+static void __init pmd_non_present_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t arch_entry;
 	pmd_t pmd1, pmd2;
@@ -805,15 +807,16 @@ static void __init pmd_swap_tests(struct pgtable_debug_args *args)
 		return;
 
 	pr_debug("Validating PMD swap\n");
-	pmd1 = swp_entry_to_pmd(args->swp_entry);
-	WARN_ON(!is_swap_pmd(pmd1));
+	pmd1 = swp_entry_to_pmd(args->non_present_swp_entry);
+	WARN_ON(!is_huge_pmd(pmd1));
+	WARN_ON(!is_pmd_non_present_folio_entry(pmd1));
 
 	arch_entry = __pmd_to_swp_entry(pmd1);
 	pmd2 = __swp_entry_to_pmd(arch_entry);
 	WARN_ON(memcmp(&pmd1, &pmd2, sizeof(pmd1)));
 }
 #else  /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static void __init pmd_swap_tests(struct pgtable_debug_args *args) { }
+static void __init pmd_non_present_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
 static void __init swap_migration_tests(struct pgtable_debug_args *args)
@@ -1207,6 +1210,8 @@ static int __init init_args(struct pgtable_debug_args *args)
 	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
 	/* Create a swp entry with all possible bits set while still being swap. */
 	args->swp_entry = swp_entry(MAX_SWAPFILES - 1, max_swap_offset);
+	/* Create a non-present migration entry. */
+	args->non_present_swp_entry = make_writable_migration_entry(~0UL);
 
 	/*
 	 * Allocate (huge) pages because some of the tests need to access
@@ -1296,12 +1301,12 @@ static int __init debug_vm_pgtable(void)
 	pte_soft_dirty_tests(&args);
 	pmd_soft_dirty_tests(&args);
 	pte_swap_soft_dirty_tests(&args);
-	pmd_swap_soft_dirty_tests(&args);
+	pmd_non_present_soft_dirty_tests(&args);
 
 	pte_swap_exclusive_tests(&args);
 
 	pte_swap_tests(&args);
-	pmd_swap_tests(&args);
+	pmd_non_present_tests(&args);
 
 	swap_migration_tests(&args);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fa928ca42b6d..a16da67684b4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1874,7 +1874,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-	if (unlikely(thp_migration_supported() && is_swap_pmd(pmd))) {
+	if (unlikely(thp_migration_supported() &&
+		     is_pmd_non_present_folio_entry(pmd))) {
 		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
 					  dst_vma, src_vma, pmd, pgtable);
 		ret = 0;
@@ -2562,7 +2563,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (!ptl)
 		return 0;
 
-	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
+	if (thp_migration_supported() && is_pmd_non_present_folio_entry(*pmd)) {
 		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
 					    uffd_wp_resolve);
 		goto unlock;
-- 
2.51.0



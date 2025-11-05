Return-Path: <linux-fsdevel+bounces-67214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2FC38184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 22:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B38A4F10D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 21:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69F2D7DD9;
	Wed,  5 Nov 2025 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BB42l2VZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lk3Kze+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8F26738B;
	Wed,  5 Nov 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379318; cv=fail; b=Jmm1hyiR2J+8x2K8iP47izuOIQRqX9ozu8Yqf+4EEHIHy6pYXcWhXF0qqY3rIai/WWLiKc7Dl2jlGW9RNYZcfv2s2t2Z8GPCgTqRQqQd6u+VwgADs3xc2GWWW/dx/eOJ7qF1PO+3s/QTdX9s1ciNH4Qmj+o/GGiV54l4mzinDqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379318; c=relaxed/simple;
	bh=jPPeV97a3YwWvw3Yb5Ig9Kw24lhrijCEOmh4m/gB3WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QPmxs82gxmLAMW+wGupYZ1k1W+ratAqdUerObmo1VWoDHqlslFQEWUg451XMDLA2ib19Uq01K8K/DqlCTNpYS18cbuLEtOysrDgvBYQXQF2WoweKASL5V/185RXfNV3++zJt0d76S20CeK+csuql14iOE01wP4M3xSjbzeXDR+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BB42l2VZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lk3Kze+a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5FxpZ5011629;
	Wed, 5 Nov 2025 21:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jPPeV97a3YwWvw3Yb5
	Ig9Kw24lhrijCEOmh4m/gB3WM=; b=BB42l2VZcfJHdJR2Sgl9KU18PTdSAd18pv
	xFal3JHwaes56yI5wAgCv6VLCqf0Ll+mk9ROp7sRI41fH1RS//4jJHyvArz+dMlw
	azP2lhU8qBhvJCTAdktWjn0taZM4tQAK0QYUPSeZZLABR1BZWoRf7qt2Hne0jUtk
	EdPryKfJSfsjblzg8Qi8IjNEPRN2b7iGrGQM4PcDmBXN8wDu5QtEbPLt0w1e936C
	ObNoebf9Qp+L2rOBSPx0cXt0xjewf7Y12MhcJVpxS7yAmsGzo0iNNjuKE+sZ7BJD
	hsbw0QRobQTdH4JEAd7/UV08N1j3GGtNYLQjbmWEX9t/ZNTJ8xEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a89q40sjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 21:47:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5Jj9bk002665;
	Wed, 5 Nov 2025 21:47:35 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nf58kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 21:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ4mrmx33Rglld79bfeTOU4Smtv8b4njS4gzJgsE6uxiJncENxlHbtVqWamGIhDV5lDjX2JkOhfqCCvFfkl9nN0AYHCiLjedlEqn+L/XjvZhDfH/PLVMy6nJOrK7uOHH1qp8PiA+vjbSyYSJas0q3/4FmfSBH1zwngBEsjvbp3dEkTbaxVlwvosAKHQxHPWnyioaq2LYt+0DIax+rYBIxxewv6v6OB8Vyo5kbHyIjIqLqG7w/o8YQ7yOI9QcM8jYPO7eqCGuo8j6mFHPZi57ccHP992k6pjJlkNl0I9aGp/wFBOXLi6UrDBwpjjG3DL7qzRn/Mx+iW0P0Fnf7MJLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPPeV97a3YwWvw3Yb5Ig9Kw24lhrijCEOmh4m/gB3WM=;
 b=gtfAtwMfiTSLVoOXbHwZmu2D5+sDRN0V1o3Qhdp3YokJPGvwGi/21pOMmw7HdRHzT3LClIINyCtJSI9Y2s737LTxXnhKrgPhJFp8csSRB5EhBLTKKU7PDAwfJezZb/19XAoPHBpPlEzWmHByHTz4qFbb8govSuL45T5KDhhMbacubhddfp57F9GC2s1iGanXAgjuUSiFSev0lSrG1HZS/zZME2LYrre9xIncW4VzfkMl/UemMLdmhjtqHvVgNluIZFsLcML1b2iPJzjjnaK6OHbPhmwRvZeJ1hfRhMtai8S43cLT60IdLVh24/iEEszVe6hB6QyPnxESbcQk0NyClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPPeV97a3YwWvw3Yb5Ig9Kw24lhrijCEOmh4m/gB3WM=;
 b=Lk3Kze+aa4HcEGam5l/0WQvf+1tzyZpE+lxkbP4/BkZjUe7akhumHhwP3we61Su/NKRXhYOWD50cUpSY++dUdkJAfxBGvdy4nwb9GFYEzaXyzWhfxewGIYcG9PY77ACGbsjY1UOVJlkoT/DGfEQ9BpPvDNNwRTkad02/7BpY2JA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6724.namprd10.prod.outlook.com (2603:10b6:208:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 21:47:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 21:47:31 +0000
Date: Wed, 5 Nov 2025 21:47:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <82afff0d-8a2d-4f20-8763-85d3cabfc072@lucifer.local>
References: <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
 <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
 <fb718e69-8827-4226-8ab4-38d80ee07043@lucifer.local>
 <7f507cb7-f6aa-4f52-b0b5-8f0f27905122@gmail.com>
 <2d1f420e-c391-487d-a3cc-536eb62f3518@lucifer.local>
 <563246df-cca4-4d21-bad0-7269ab5a419c@gmail.com>
 <52dd0c85-9e06-4cb2-a9f9-71662922cba9@lucifer.local>
 <bc94d739-d66f-4cd6-a3f2-68938cfd08c1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc94d739-d66f-4cd6-a3f2-68938cfd08c1@gmail.com>
X-ClientProxiedBy: LO4P123CA0144.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 323aa460-3460-458e-fa7f-08de1cb4ec27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDcGrJ0UgU61FvvZZ4L9HzgfZIVx+UPE/whfqDY09GXTFQY1VF6fG6Fsyy+r?=
 =?us-ascii?Q?557tZr8Y+Kuudv5Gej5fH09PMTvZfyfVxlTjSLKCYKRV6qDV3HsdzVQC60kC?=
 =?us-ascii?Q?fExreIkbp40MHUY9u834fiJ74ZLazTYaeS16n4Hfaj383jkzSl3ZNaHo2Ym9?=
 =?us-ascii?Q?fbQJPpoN+BSCtrLv72jhiUXoJedvRj6+Lt7wSyHUSD78AT2ryNjahbwNqrPN?=
 =?us-ascii?Q?l+N5KUBmlxDM0ODMgZDq6fChjZbL3HHx41Y6C8y8B3QUFVgYQUpyT8MI3R9R?=
 =?us-ascii?Q?CpmoJZGbgyaBdz2B+mLdv65WWZnout+slLYtbaWksLTZlzAsRceSHlXWAd4G?=
 =?us-ascii?Q?fJ6o40/E9IU/dkcWI19YGgA8qOif5KjnQ9E+GDgt8DEAYeE2qjIl2dhcGFVS?=
 =?us-ascii?Q?/RTPncLVkllN0kSrB+eUXY2HHl4rGxo5Z5iMINQbNWnuk3dIMNgTwludcBRA?=
 =?us-ascii?Q?D5pBPTXrQkiQeIpG+LtziTz/zzyP41jtv0IOs3AABRbZmLG0ovSoj73w2ECb?=
 =?us-ascii?Q?olVpifvTU1dy+HuE99g2LcvB1KjHybSoizWjvcJU0QtQZLy6Kyz8H8hI+EeF?=
 =?us-ascii?Q?tM5PfR1fo8brE++y1cfaYF0r/S+hlcWFRIv1bjthyhpfYfUQjJOGHl3c996o?=
 =?us-ascii?Q?0XOS4tHLqgKueUfFt1RGqF+AHE8laHEocyc7of/mK4DyG1L0HC3Tks5W42zI?=
 =?us-ascii?Q?oeYH30qE2U+vqHC5gYyTQMxsBoleKr/5BvlH8VyumHVwciXoruqfFnG9Mdyt?=
 =?us-ascii?Q?Zw+kHuyPRW/fjeiyFSlJGMQa1yFDgBe9hH8bjwUr+e0KpMCcE5GKLzE1EgnI?=
 =?us-ascii?Q?2wMAvZBACuQ3LrORg950cu35L4E39D/7NO227+G5lOUziQv4wcjxxpgv0cQ6?=
 =?us-ascii?Q?eJSb9AnO3Wq/th5XaHNOg9uB94o/TUNyyUX/n7Kihm3Bjf4oED1HiZjTOLB6?=
 =?us-ascii?Q?1q6XPf+Kmae6Zzk/tHxyQnAuyI2r3fc5w/BGmA3Myh0NJ68o2IVioUsd/F/0?=
 =?us-ascii?Q?GdMneImkc+wDZy+mlSfFwDSNcBlh4BdQqT4JOPXy2MyxDvSLjnnnsoc6cysE?=
 =?us-ascii?Q?T5kACfOmkiGmokNgUkuVk8p0SPDsaiBPRhcrn7T3pveScdDEmVrzZt25may+?=
 =?us-ascii?Q?EuFOlC+efuHjAJhKyyVKcqtPY2UDLLYn+ENCa0RJOygmOUIdTJ7xfBrHIChI?=
 =?us-ascii?Q?R0dGBR9w2Otkk/5LoM0L7aZggZY/uM3maT5jHXkgjxVsexxAzdR2UT/VKwkC?=
 =?us-ascii?Q?O4SW9MXGqVsZ0f9vi+CL2JRYxR7K/GGPs6Wuy5krugNRnxxJ+UZNizzkGawK?=
 =?us-ascii?Q?zoC9xV3qE86iL3oyWUYIu/t3RDsOF4K3QH5F3rSgfv+Zv8yNdDnby4phgftp?=
 =?us-ascii?Q?Tx8oOBIf0jNJ1x2QCeTDMCdnntu6jQiuCFKAzP99zyHmS54NhjHdcDbdMSXo?=
 =?us-ascii?Q?8mAyZEjuuQ4cCbCWORzqJorEpy83kmPx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yfJjXhBmEP6uobVL4nYE9vQTZAR6/TPrwVyDjpYrJnGxPtJoQ26wDbQy3dOH?=
 =?us-ascii?Q?AJLrhs0s339bIu9HFOW1F66UTEQdTE8I7kkjxcv0fIeTxE+vpyCKThpPXRVD?=
 =?us-ascii?Q?6TU8MNE1k6UP5Xco+MCyEM9WC6NkSnlJ90pPXno36zFY5JyVID6yBjcATA0G?=
 =?us-ascii?Q?McvelVBDOK4uNSCPj4RujXi1EhJZadd9nGDF17lTBDztdK66fyR2448yrsHt?=
 =?us-ascii?Q?k3KWqihjzKfp+pr7TSchBdtbdtzcUoiLL4+GJA0amBCAWVoIv3mVOYb44WcN?=
 =?us-ascii?Q?jnSsiQCdru1PLp7YBi20+vbx55DsNXi2lSmJ9zd9/+fC/A/xy1nyK2xniz+e?=
 =?us-ascii?Q?ZGqyBUNPVLRBD7RZ3pcV7O4zyPJP/wQburJ/ieGC5IbX5+sUPuLq+iO2jEcJ?=
 =?us-ascii?Q?ejbPd13godPnDMiA9AJNzoPsSj8On8TJoMtNmABjE349etnSSoz0EDEclohs?=
 =?us-ascii?Q?2kxFBghp0pgy9JU3s94cj2Ewct/wtRiyLX5Y24FXhX9YFqlq2yw+2rpilXw7?=
 =?us-ascii?Q?g/xhcxiI2lUUnf6RPm1+GvIpENEDsLSFHRMXk4uBRPN9S8MJUe1FSzX4bbxo?=
 =?us-ascii?Q?Ovu+Ribp/M/a8AjhFCsaSmbOe9LrOIPtiH+77d8HL9RKgmJmJ01MDDZKbgJ7?=
 =?us-ascii?Q?S0IU/nkW9AQjV8EdtacuQmsPbZH+fxdnT/lEhIiy3oZhUdpJaB4iXIhnyn2M?=
 =?us-ascii?Q?zhw2XZdcG0W5HkNH0NItgtNjAORcvo2pJJlRUjgssoB/QkWO7MiDPYAXEHzM?=
 =?us-ascii?Q?4iSI8yYmalxMJHl7eZ+oxZo+/lVi280opiq4AXGMLA6oWAYTJd9bk+dXIbJj?=
 =?us-ascii?Q?1T+ZNIk7JyQHUdIcJ8EMZMzvj4I5FvBipibokRg9JJCdxXS2MT8p6wDV3fqA?=
 =?us-ascii?Q?AfKofzJfW/1GoSZTDcoWNxmamimvgT46qDxjm1A1vik3EELzt9RaO+8yyKuC?=
 =?us-ascii?Q?wMIAa1YrVPqrsQSyOr+eNrKiQpl7yUQC/omaIIa+AUS/TBKaFCQIDlgn3Lo+?=
 =?us-ascii?Q?lg1blMSa/tKpqiCM/b/KreOtATKuiyFyYPwBlGIRFKaRPrEAXCd4YHVUG6Br?=
 =?us-ascii?Q?39IZ+2T/WXruCOf9nwmif/k4fGBI0Tv7SV2XWN2bXs7RPFYtsHxAYCkue3l8?=
 =?us-ascii?Q?iFwsAY+vR4nWvkEhxYk5LRzZ+YpwEEYBYAXpKzaby2UE2J6cGTMXs83X7fw3?=
 =?us-ascii?Q?tM8OqI5NEQXNBtcDlgsIA0pciYp1SfKib/Uj8SfiitmAwyE549k43ZOZAui8?=
 =?us-ascii?Q?HB9jokUg8y2Xu63fxlv9Dj9baW7vvLUPCqTyFTb5zzP/tVuLHgWOc7TdG3Md?=
 =?us-ascii?Q?vtpQnKr77lv7QzeAdmpfLWqsEJQqLfiTYWJPbGEfNfk47ySkD+CG0OeZWoYl?=
 =?us-ascii?Q?fhEo8DCLyNlOA0NraVuaqgeDXQC+Pp1u2FAgBnA0CJ8aqoA3Umdd5vVde5Ud?=
 =?us-ascii?Q?0WcqfQf7bdVXXTk9deloaqwxNrHDqTIeDPgRsZwWAZbLrzRwsjmNjWxA4YRX?=
 =?us-ascii?Q?9kz2V6qqU3IGXla848f5PraEZ3Vb0p45/5VW3JI5+IimLNZVxOtZ8qZCU/bE?=
 =?us-ascii?Q?RF6gRKAp/u0dVjUM7rY8VLgxLTOSp8GWKFA0OEg5w1JCcDDZ9YrSGLxtMrg/?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ks8xFPK534dqJ3AKZc9rphYUsePhySxpO3bwso0ooaggveSyLszBwuNZyMFeBZ44b8qfZr9LeJMWDKSTTQWlevVQu50HRichunm5FP8Ue2KzcJZA3CU1c60h32WlINDAxym04JUGdnRaEAr0If0bHEy34As+2O7uLRNvMFLk0J/SH8gs/Dyf/VI2NY5COQgtaLC0N5juL+DhJ09jwEdRlgPDSywMtcAoqw9yP/dfNAT6e4E4JJWGYYciOqZE94eyJjLkLGH4dl7Yw1f5VMTv1ZZF85mF6bw0+Q38nBIOhAvaGEI6wetQWa5A7tfQeUvK4ZHgxxCU5kelIlr9gZCmSJUO75c/7DCABqAj+j2qY4B24nkDms3qzPe5E2QD8J29d5XA/jKm9rUY1crddJ9Jq4peuWg6Ngae5eTin5xCWSTHYizUByLJFnh0LDbn7ziaMlIheRzn9KgoYbJKrz3a9bACHoGGAtJPvsyI1shOg1VFEjTpLo3pL+cyweLzeQf0zFp/pX3I/Z+x/hShTLod5Cn5463nooeLDdeFGgpScS1CoZcwFGTAvFSEdMXepemGHJL3pl+59P/nDgjNEm82QyeWIPsSOJ88dh2fSDGLtzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323aa460-3460-458e-fa7f-08de1cb4ec27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:47:31.5748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt2qXFEndvVLa4Vf7qsybFiWUrcV5qib3dSHsZjhq+Y5HxjiyYQSo/77arakOxJsnM8zWHZ6xM2WhUKXrFj3rHNtvy3Rcm5c5EebJ7oBHK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050171
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEyMyBTYWx0ZWRfXw1BvOGhreGm5
 qN1SSTga2ZIWHEfcmH0OJjpR/iyGa89mQqWXWHPy23+gzk3EmgpHmUooUAmy2lFQHAb0RwuNAno
 9/dwC92awvaGIS4ijIuhwIdEhoqlLlt5XlcG2SKqKUOJh0ZdkA/Bi1Q2P5qGeXbaQeDP1tOhJuG
 0GOZpAb8Ka8+wnhsC3BxjelaIJOoq1iYxX/+3N0EbGqMBMw94opOtMU1Y9OAqFBKBnfVIVqHujx
 Up2FfybrIWR38f1+yC1OZ9FwGZGrQT5F4joFkIWF1o3/yww32NmXUpc5BhrzHnKYXf3P0+n9SvK
 mqfpk1Kq1/LOnQPUYR3XQ//skR181bngyLNb6w4UeammKL/ELlpnlOo1S49ZbgdXvK1LebBGHii
 b9/AjidnawSEgk2OdwvP7ol7B92W3Q/id0OjzgoU48IQuuDcdis=
X-Proofpoint-ORIG-GUID: sBm86GyC2IpWPHfxVgVBXEHY41fnQBd3
X-Proofpoint-GUID: sBm86GyC2IpWPHfxVgVBXEHY41fnQBd3
X-Authority-Analysis: v=2.4 cv=PcPyRyhd c=1 sm=1 tr=0 ts=690bc5f9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9tSI1qcOXVidSKpIp_kA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13657

On Wed, Nov 05, 2025 at 10:29:14PM +0100, David Hildenbrand (Red Hat) wrote:
> On 05.11.25 22:24, Lorenzo Stoakes wrote:
> > On Wed, Nov 05, 2025 at 10:15:51PM +0100, David Hildenbrand (Red Hat) wrote:
> > > On 05.11.25 22:08, Lorenzo Stoakes wrote:
> > > > On Wed, Nov 05, 2025 at 09:11:45PM +0100, David Hildenbrand (Red Hat) wrote:
> > > > > On 05.11.25 21:05, Lorenzo Stoakes wrote:
> > > > > > On Wed, Nov 05, 2025 at 03:01:00PM -0500, Gregory Price wrote:
> > > > > > > On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> > > > > > > > On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > > > > > > > > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> > > > > > > > I thought about doing this but it doesn't really work as the type is
> > > > > > > > _abstracted_ from the architecture-specific value, _and_ we use what is
> > > > > > > > currently the swp_type field to identify what this is.
> > > > > > > >
> > > > > > > > So we would lose the architecture-specific information that any 'hardware leaf'
> > > > > > > > entry would require and not be able to reliably identify it without losing bits.
> > > > > > > >
> > > > > > > > Trying to preserve the value _and_ correctly identify it as a present entry
> > > > > > > > would be difficult.
> > > > > > > >
> > > > > > > > And I _really_ didn't want to go on a deep dive through all the architectures to
> > > > > > > > see if we could encode it differently to allow for this.
> > > > > > > >
> > > > > > > > Rather I think it's better to differentiate between s/w + h/w leaf entries.
> > > > > > > >
> > > > > > >
> > > > > > > Reasonable - names are hard, but just about anything will be better than swp_entry.
> > > > > > >
> > > > > > > SWE / sw_entry seems perfectly reasonable.
> > > > > >
> > > > > > I'm not a lover of 'sw' in there it's just... eye-stabby. Is that a word?
> > > > > >
> > > > > > I am quite fond of my suggested soft_leaf_t, softleaf_xxx()
> > > > >
> > > > > We do have soft_dirty.
> > > > >
> > > > > It will get interesting with pte_swp_soft_dirty() :)
> > > >
> > > > Hmm but that's literally a swap entry, and is used against an actual PTE entry
> > > > not an abstracted s/w leaf entry so I doubt that'd require renaming on any
> > > > level.
> > >
> > > It's used on migration entries as well. Just like pte_swp_uffd_wp().
> > >
> > > So, it's ... tricky :)
> > >
> > > But maybe I am missing your point (my brain is exhausted from uffd code)
> >
> > We'd either not rename it or rename it to something like pte_is_uffd_wp(). So
> > it's not even so relevant.
>
> We do have pte_uffd_wp() for present ptes.

Of course we do :) fun.

I mean we can always invert it with pte_is_present_uffd_wp() or something.

>
> >
> > We'd probably call that something like pte_is_soft_dirty() in the soft dirty
> > case. The 'swp' part of that is pretty redundant.
>
> We do have pte_soft_dirty() for present ptes.
>
> So we'd need some indication that these are for softleaf entries (where the
> bit positions will differ).
>
> >
> > If people were insistent on having softleaf in there we could call it
> > pte_softleaf_is_soft_dirty() which isn't qutie so bad. But I'd not want to put
> > softleaf in there anyway.
> >
> > sw_entry or sw_leaf or sw_leaf_entry would all have the same weirdness.
> >
> > I want it to be something that is readable + not hideous to look at but still
> > clear as to what it's referring too. Softleaf covers all of that off... :)
>
> I think you misunderstood me: I have nothing against softleaf, I was rather
> saying that we already use the "soft" terminology elsewhere (soft_dirt), so
> it's not too crazy.
>

OK we can fix this mess in a number of ways, and mitigate any weird naming I
think.

For instance, we could invert and reference hardware in the non-softleaf case,
or we could have a function that detects whether present or not, or find a way
to not reference softleaf, or just live with pte_is_softleaf_soft_dirty()
(really not that bad, given softleaf is one word etc.)

Given these are niche cases I don't think it's a big issue.

Any reference to software will cause a possible slightly weird sounding name wrt
soft-dirty, but it's right to reference software as that's the key difference
between these leaf entries and present ones.

So yeah I think we're still good to go :)

Cheers, Lorenzo


Return-Path: <linux-fsdevel+bounces-67762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14468C49899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 531A94F0A47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1085F342CB4;
	Mon, 10 Nov 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oy7z0hDr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IO3AxVl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1917341AC7;
	Mon, 10 Nov 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813457; cv=fail; b=kQ950h1gSvAL5m50AkJ8TdDHHuZ14GbiqfY0Htm4L+NZnO3oj0etLyCjkw4e8PZNKZxWh7Vl34GInbFsvk2opr4NV+sKXQ2Y+xOndGmcXkVFtDoEzt/uvbzxWn7PIJjQ/PFacdQJNkXXx5OWrN0iLMlLF+KDG+Xc+xZn3Nz+AFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813457; c=relaxed/simple;
	bh=POgjLibdleyIT97aLcMp4rGu38r3SsMhgSVUA/LXdP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGPRZ+uPPbmGmomCKK2zMa9bC2Uz3JZNtLqNxsDkkqV2oAN8PhDvD8R9Acd+HDOPv79miLzIMoKPpiEl3vLJRlthlLTt947FH8QE5s1FI5lEklPnSUBAOHZnexNbkd7lSD+JzTTXh2GuWSuM5Bsx2czNMElexrY9wVwAqwpdZuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oy7z0hDr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IO3AxVl1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMIJlZ025921;
	Mon, 10 Nov 2025 22:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hnulhczD3XQkqRXiu7lNvxRJz88HMl5Uk5p8sHNK2Ms=; b=
	Oy7z0hDr3XHPzWEPjqbW+Yk92OenLk3UC1NakElwLrewB/7LkPQ4ChtYpJHKVWG8
	7cS0XMS7+6um5jXJNHzBu6xkNGYUEepQetyZrTtBo4f6OJtjTe9HaF4jO+FN6Z15
	LhvTgbZoB38+arHl+J+ay4vwVODKOVOqlkESATwQCQA9Tgqp+fZHrpUKhIvb6EgQ
	+NcaCBEd2l/IR/gsg3mJjg1RGxdUzZlWHP914ma/TghOau51QMmQeQAY5KyyKFHh
	7p8esP50MDq7EH1q7PxIdvbGt4zz2FuxwBxjwtso5RhLng9utOAnd+/mff11mH0u
	hVqSZkd9N7Bpe41dTgR7RA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abr5vr2bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAKGUhu007458;
	Mon, 10 Nov 2025 22:22:05 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va997sw-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFqyPLgx95pbSD2ctrRxvg45m/5GNnRaJTMwwyzFIHye+Jnc98tzDCmbtolQ8YmKPgjQWpXy1Yewhqrs4jVqQguYra3u8lFvN2TsdlCqMCgd6f/qdXJ28jmzPxSIbdkpskEQYDGzyNQV4rDiKVpY1iIQ99Jyg9Zj3iVSq+Wv0PkBzO/QqBy9GtpSF0JILc7Bz35tsPW4ebDcUudE/gz44ZWjhDFv6ipjZJtlCKh3XbSWfXsXfpwr1o9m+UxSg6tHWQKgHCp0eQXIFgenK+w4ShhOdG8QfWB8aIQMfFCqcZiz3/VrQ7iu7a/t+1cz1sSMg5ZkcwFePiNqxFldKJ4Z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnulhczD3XQkqRXiu7lNvxRJz88HMl5Uk5p8sHNK2Ms=;
 b=lBlIq+42vMIaXIc9DCxRNo0NEByGPGcFjh0hgN5Hh69QQ+BcCiS55AraBunkmjcDIQIYABICToT4D5/lxRxWTh2u9i6wPhVhYBcCNpi7x/lF2uJPBFXZdfIxrit182SJ3pR0l+sljQoqSzLwzDT5yq1XFj5mYRnc0C13aiS7C/Ffu5M0fFIwfPZbs/FOWDXLTrPNtlHTjFzKdBp3cWjCZICOIM+gXJWLUMyeiB9DjWhOcAUgE8yOm3VgZretDu+2Z2ntePBo2Y8rtdusReFKnJ0L4uYOJXWE8PcserVUYa4qRPYsmgpa8zNqNy7BqWELhhN9Fg6pPCQDN+Bxq2k4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnulhczD3XQkqRXiu7lNvxRJz88HMl5Uk5p8sHNK2Ms=;
 b=IO3AxVl1aEM+cFwwGNW7tJPs2aoKSAD7JbHAsCzmbtJ+O6bTrSTV+vOurYsTe3blZJ67L7LXLMly7c7vlx2e4x8R24pEKK1+4vG7dSJ0rZm6sVyYzbFkpneNI4WnIzcqvhZdFMMIFE95m1pXtqN0ueArhk3sN8Qh5FgVKCO6I/k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:22:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:22:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
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
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: [PATCH v3 11/16] mm: introduce pmd_is_huge() and use where appropriate
Date: Mon, 10 Nov 2025 22:21:29 +0000
Message-ID: <00f79db3b15293cac8f7040a48d69c52d00117e4.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0115.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcd31a3-d48f-4b0d-ecb2-08de20a791b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wZaFF6rxV07BFmPjbRMPHioNOMZzSW4k8M7YRnwi4x7PtVaI8xwWqDyNGBNV?=
 =?us-ascii?Q?j12IFX2KsFS9bGYPJdb9qN85zPhG+iPDgba4jXm26lt6bVA+dU8+3/L6pvd2?=
 =?us-ascii?Q?v8kUBP396ShYU12+J/V5sRhUNsCM7tcKBfy/5VURP2YSiAMt1uSlKYmAVd3K?=
 =?us-ascii?Q?GIEYDrfHSMGpQn/m5upvJdm7L5b+4w+rk5M9i1L1tvr6vyBAurZUoquiZE9R?=
 =?us-ascii?Q?HfZHGT5fOdiX2ulDuvTgQ2rVX8mvF9rVV5vFIwhqxvB1wdHM08RauH9AgPXg?=
 =?us-ascii?Q?o+slt+vzK5sNg9W146LmPkGET75XQGBnOCCe88WxdRk3ARaPW15/JldpXodu?=
 =?us-ascii?Q?cC4h/GmCYuBN5C4gbd5Yf8y3ecGd5vXSfu+1RkedFFP2/JE2ERAVFV9ljLLE?=
 =?us-ascii?Q?dv4yMzFNb9ljdV8xC+/BZSOwzPIy6s0Hym8OLlhWFjGIivoJylZrfg48Mw62?=
 =?us-ascii?Q?N3SVgJCqmtT8taWVzI6IlRt0PcFN2GKEIFopd08+WA6Any/1djbmq1aJvFLo?=
 =?us-ascii?Q?4ZvFoH7hD/uD4LBa+TNy2KLkv+yqKYdIRXXa+HRTDyTF5vlkCiAWfMSiLvoN?=
 =?us-ascii?Q?GE6oYJQzUKuAAZbz0N4j6u3bv6MeDUXOCsQ0YIhcF0g1zhyZ8IhzXLGS5gR4?=
 =?us-ascii?Q?OqVo5JAmMkpZMHXDxyD/ZELb2OG+HW5kNk81TuW81Sg6do2UgxeSrVnWn/LS?=
 =?us-ascii?Q?woHnkTApEk5lo4uOpzH0nudt/zJ/lhJfXrRzjcE+eSF0COcw1i10RB9ViQ3M?=
 =?us-ascii?Q?j8gKxYYfhcDM4BmoEptG7Qa1bKBM7u30wP0RECRAkzNyF/7xb2ue9aOgtL35?=
 =?us-ascii?Q?dMtgJ44NURdJsmYtg7YlKJFqDFaC1FLQx7acFqtBhi8XsdKQyZ+4jMT7zAAT?=
 =?us-ascii?Q?0NuvPCe92VCwwTBWQ1gNUG4i0lN3rdc1qsLZWbeS4Ejacf/emhvSI35vRbxo?=
 =?us-ascii?Q?Qb2NIsRLHPe9TkBBuw3Sg8oPmMiw4xi2VuObwyJFzLCdyAQGCmV7AdGq5APr?=
 =?us-ascii?Q?HuJYaXFp+lugUuCS9KEsZ55l79X21iZWT5lCOuus7QffFk4c8H1ln97wXGn6?=
 =?us-ascii?Q?DLaGZEGnAU0q3IzJGwEhvlhWnJy8CGZUxEsJ1Le3T82W1yPW+tAGponry3L3?=
 =?us-ascii?Q?+Hz99WwWIdVKIbgxnyv6m/fYnNXx6BevAtyYPSFN71RtEnnI3CYaZvtCLN1n?=
 =?us-ascii?Q?qlnQ6euLNstZPVjJ/LsHsKwrMv36oXbauS6DhyRQAHOTNFH6WWdf67XLXsLO?=
 =?us-ascii?Q?/TmrFJ595GRKVUYEopAP22CEQcA45UBk3UdIbFV2iZGMbe3iI6+YqD7ceZoi?=
 =?us-ascii?Q?5f5jJ07Mv6q3HGaY86+Sl58PqdtSsOHZgMAczBTx1zNZCBAJgXPAgYKOVVPc?=
 =?us-ascii?Q?7CL8mAnmi2OhF3Uut2PJ43qGf1rB/rosPZ8I/fs3uAEXf/EVrWoSIrmYTryA?=
 =?us-ascii?Q?kEp7YGCFnQ9h/XqNNl4xheMFN5h35dGA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/mQF1nqniR/Ay2d2OyZSCZeDqmFPqBdswkxXbsZ4OAh/tiEGAr/HOjmphJrv?=
 =?us-ascii?Q?Wf7+LB/PRTzYNhoS9n0rerj1d22aS0F/R1gpQzOXvMrCCNOkgWpoMUpI9yM1?=
 =?us-ascii?Q?kEEq8qbdMQVFKRj+yoiVhGTyP6KbLBPIbyGZ8/fwMs/BpITsOW0d2zLTbATT?=
 =?us-ascii?Q?qO6AhWaYB81i84cPxHpdPKnna6/r/l75T8GrFCr+IHphsWryWcN6XBNBKL+0?=
 =?us-ascii?Q?ZX98btx+tKF1Qb6pqNgtxGsd1G5f9tAVQy13OxiQqUF+3+hNngUEI3GbqlUf?=
 =?us-ascii?Q?d302NqbQIvuvRDiH1ltJzaRUfXwJl9Mttk46eeNExXy4dwZpBIFcMKhxuISQ?=
 =?us-ascii?Q?8F5IL8JPnxLzSxBEboGVQ58SPqeZDeiYRFNR9JiYMW98DjVXSUh0cow8zPrH?=
 =?us-ascii?Q?Le33KjkkmHtGMC9gKdpWhdQFDEl5Tcfkd3s4vIiDMrqtsuh8yAt/n0Qozppn?=
 =?us-ascii?Q?r9voehW+TnVDcPGtcEedD5hgs4uL2GzN/95Cc2jEysXPpu+E/HfILg5orGY1?=
 =?us-ascii?Q?PzbGM2hub+Vch+KH2oC9zxSwXhKPQ58CEyG/cCuFYGbVEDiNcPZ1hdU6QaWz?=
 =?us-ascii?Q?enHTeBux8AQPPSi/KmYH4/P4luAluQjCepyxcyxPg9+dwhxipfHx8oWsOUqO?=
 =?us-ascii?Q?Y/vu/bcI+vsRXNKzNm+HWzZvLw9BM5vxW4gx5iu0X1R+kcNS5cTtqlBZ9ShJ?=
 =?us-ascii?Q?zmsNwAUpKs0FJvU8N6gPei1951Co4G0umerPWd6J2JAJeuPD5AvNWRELsyBC?=
 =?us-ascii?Q?9HvBWwje0vnOmWcqiWB74ihN1fw5QP/Fjk5zqFOYQUivGBlJLXSgJ69vgSI7?=
 =?us-ascii?Q?8ZQa+7JAaoak5ytuhd5bu6hXOKiwTBJuri0Y77yBxcZ4VZ3Rey0UMURZjXYv?=
 =?us-ascii?Q?y6XMcQHblAMHQQpfPW9Vevr6fnbLzDekb4+YsfT3toqSPLVD4NecgZSAK6NI?=
 =?us-ascii?Q?v1PmxTy8F1dsKSi4KHknhnYkanjvJgdHbKpL/ER5ZN+0xLyM0NZgqbLU6Uvh?=
 =?us-ascii?Q?H3lFO1fwV60+QgQoPMGz9OtpS1i6oOsnX5tPFffhL3gxsiSofu7opQhg2uBX?=
 =?us-ascii?Q?fBFjCp2CoFX449dNRsatuTScwWHZEmYcviCQE1yHD5nuO8WuEQnUUpsNSC0B?=
 =?us-ascii?Q?egiO+eI1xdeQR/NAQk2jC6OAmrG7VCbx39uDfsXgdVu2EJPTXVJ3PZi5YgKy?=
 =?us-ascii?Q?gv0SgDDC5haajiS2KdYGdn68+PxLaGjEhV3hGGtjnCJYQ6T6UIUogl1bYRNu?=
 =?us-ascii?Q?jzyTLQEXUgHEOUN97A9dBENPTQ4ZQi5IrJKY1jql/phI8DjRYJ+h+HyV1hJn?=
 =?us-ascii?Q?EwOPo+uHs01l4rXqx9NqNheutr/AYc3hVbMO701RKGjiUatdMX3WvoqKcgIO?=
 =?us-ascii?Q?E827j16UN9O2Hr5Zobiuvyo3K70k2V8ahtEs1rps3guD/wh/Aq+fqDb+Dgq1?=
 =?us-ascii?Q?HHvq2PY6xXE5nxg1y5ZwAl+V8+tBKPAOP5aJSANMpo+Z8Liob9g7AkeUDwzJ?=
 =?us-ascii?Q?Y2Irnt6C+Yqb7x16DmBiB1D+21B2B+KpJh6+qvvXhbfePQtbaFv59jcihOqz?=
 =?us-ascii?Q?HlQ5yfAms9g40q6JWfvfilvojyd69sTKtiPaZN8vMOKObFN9PiR0cf6SLePj?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xe4QvGLoDPVLyWHqEPVjlJ6P0gu9/LbDshR+PjD3Cr/UJD0lEECav8+EFw1ZbeBpobpX1WWjz22K36kMTc7C2vLMKtdcx5PGi7BOU2oyIgoNELSqrciplv+cpwG04XkJN/Z9CJVjizSKnSBHTtGoCiznsBNHhHlwfS0WhrF4SkCA6DIWMOlYwiO6tnaS7t2GkVttEDKdJrcUu6qPl/1knEXhWq6zQT8JlHrZlNU9K/6JR7yVghA8bifhVJfs6CK7xf29uhN3CNQJzm9smFVFEvkkw6oTzaGQrG2rIbxmD+H8sJYlgIhBA+Bk/YDvrZv0IhZY9E9eT9cWLDhl85BDUwCzKlb7xRu9QtZYvA9tOc4WAsyIarpZildUpyKgn7DKoCfbClQlggOTUw0o+NuVsuxa9uFJ+o9XGdZlwrqT2QdG5EsOtEb+sgGufvVn2opHJypAvzW+M1Iopeb5d4YJlxbUq91ERMK+ufJPG+nTE37jXyXrmLApmrpWiZqFfxk3OuoCEnbixv9SlYwJCDRFv4Yt3yTSwQyuj5o7XSqUGNAY707PT19SXeOO/QAlyiUnpTopBMOjfvXDRJ7GCfjBDVDDZVrSdayII0DF2FSMsOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcd31a3-d48f-4b0d-ecb2-08de20a791b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:22:01.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9B80JOquNDtnXzLO5Ct+WIB8oPYga66SeERHfNKmgDIa3qG4My8qCsB3IitlimCD0J8IqqxSaD4qpiIddCf8I/PW8TzbjQhysQLolHWF6Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-GUID: XoHRleAVpnHArodDsuyc0euT4uEL_Xnd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4NCBTYWx0ZWRfX9Ygyk9By6Zun
 I4Vs0do95KbyJpDw6k9qF5b7Ch5qIfz69egadn/6woEATDydOQl6DirA9uHMbnPvMZ+sl32e+sG
 mVzhjqvYg0RWQamNQDUO1RkIHdcUPHxAtXFWenwIvfCWzhr9Uvz56GCmPhjTKEzWvRx2DBijrJH
 dhoV1grtUWG6fAu1KwfbKyY0HtRofMAy3VO2knoWNRgIC9Z1yWdVwrQh2/LANO4adVpq1sthDSP
 uwaDkP/JBmx699ggvL9+YeN3bOjp3aR4paBQlYZfVlVmMtxcWqFGIvu7IZV0k/OQHvxsKmb2Gfb
 Y6Dt37BRBpPY9kW+wPgptnIafrH1Bs7MaZtgvpfpwg7WKZTf19yFwFFxGTzru03uaCLLF/QLh10
 5N4SuZnwof1dMMBEeLKMGSpUE0SgDg==
X-Proofpoint-ORIG-GUID: XoHRleAVpnHArodDsuyc0euT4uEL_Xnd
X-Authority-Analysis: v=2.4 cv=YN+SCBGx c=1 sm=1 tr=0 ts=6912658e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Z_ABK6pF82JkGIUUY4QA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

The leaf entry PMD case is confusing as only migration entries and
device private entries are valid at PMD level, not true swap entries.

We repeatedly perform checks of the form is_swap_pmd() || pmd_trans_huge()
which is itself confusing - it implies that leaf entries at PMD level exist
and are different from huge entries.

Address this confusion by introduced pmd_is_huge() which checks for either
case. Sadly due to header dependency issues (huge_mm.h is included very
early on in headers and cannot really rely on much else) we cannot use
pmd_is_valid_softleaf() here.

However since these are the only valid, handled cases the function is still
achieving what it intends to do.

We then replace all instances of is_swap_pmd() || pmd_trans_huge() with
pmd_is_huge() invocations and adjust logic accordingly to accommodate
this.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/huge_mm.h | 39 +++++++++++++++++++++++++++++++++++----
 include/linux/swapops.h |  6 ++++++
 mm/huge_memory.c        |  3 ++-
 mm/memory.c             |  4 ++--
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  2 +-
 6 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cbb2243f8e56..403e13009631 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -419,10 +419,36 @@ void reparent_deferred_split_queue(struct mem_cgroup *memcg);
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze);
 
+/**
+ * pmd_is_huge() - Is this PMD either a huge PMD entry or a software leaf entry?
+ * @pmd: The PMD to check.
+ *
+ * A huge PMD entry is a non-empty entry which is present and marked huge or a
+ * software leaf entry. This check be performed without the appropriate locks
+ * held, in which case the condition should be rechecked after they are
+ * acquired.
+ *
+ * Returns: true if this PMD is huge, false otherwise.
+ */
+static inline bool pmd_is_huge(pmd_t pmd)
+{
+	if (pmd_present(pmd)) {
+		return pmd_trans_huge(pmd);
+	} else if (!pmd_none(pmd)) {
+		/*
+		 * Non-present PMDs must be valid huge non-present entries. We
+		 * cannot assert that here due to header dependency issues.
+		 */
+		return true;
+	}
+
+	return false;
+}
+
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd))	\
+		if (pmd_is_huge(*____pmd))				\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 					 false);			\
 	}  while (0)
@@ -469,10 +495,10 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd))
+	if (pmd_is_huge(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
-	else
-		return NULL;
+
+	return NULL;
 }
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
@@ -744,6 +770,11 @@ static inline struct folio *get_persistent_huge_zero_folio(void)
 {
 	return NULL;
 }
+
+static inline bool pmd_is_huge(pmd_t pmd)
+{
+	return false;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index f1277647262d..41cfc6d59054 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -471,6 +471,12 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 }
 
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
+static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+		struct page *page)
+{
+	BUILD_BUG();
+}
+
 static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 		struct page *new)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5876595b00d5..2f0bdc987596 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2810,8 +2810,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
+
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)))
+	if (likely(pmd_is_huge(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
diff --git a/mm/memory.c b/mm/memory.c
index bf2bbd0dbc97..087f31a291b4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1374,7 +1374,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
+		if (pmd_is_huge(*src_pmd)) {
 			int err;
 
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
@@ -1923,7 +1923,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd)) {
+		if (pmd_is_huge(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index a3e360a8cdec..ab014ce17f9c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -474,7 +474,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto next;
 
 		_pmd = pmdp_get_lockless(pmd);
-		if (is_swap_pmd(_pmd) || pmd_trans_huge(_pmd)) {
+		if (pmd_is_huge(_pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
 			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false);
diff --git a/mm/mremap.c b/mm/mremap.c
index 62b6827abacf..fdb0485ede74 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -850,7 +850,7 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		if (!new_pmd)
 			break;
 again:
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
+		if (pmd_is_huge(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(pmc, HPAGE_PMD, old_pmd, new_pmd))
 				continue;
-- 
2.51.0



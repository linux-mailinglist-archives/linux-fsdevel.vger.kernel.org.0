Return-Path: <linux-fsdevel+bounces-67764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885FC498B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA05F18896E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0D34403E;
	Mon, 10 Nov 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jqi6T2W3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qbgLc5LQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2E343216;
	Mon, 10 Nov 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813462; cv=fail; b=DWQJT/fRJvqhU6mapTKyrp4bYGRvZ0qPNi0iNpW4zIbCUkJdEmkXGcZLRya72PW6njr3BD0+2+SVo15fgaU5arjHmgKAb8kCSr9T1pXOtDUp33xLEQegeAkDvD3jM64JKQA/kXOysiuCjDNgwlaLfUqF648sH+uFpfjX6Sp9dRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813462; c=relaxed/simple;
	bh=MeIGKmBE/AJArO8ad0y5oWnwuP1Z4vu62nuxzrDgL3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBHFRGTWm+Dyniyhe+JRKAGDAdL8wTA+MHJvIJerLsXHhYWjsg5lO02EPIG/kyT51B6u9GLNRxGhqhbbt0DIaCyv+z/xiVLSSy6VGgcLKht6DVsq7V+/tkuU/Cdp+rZLbQSHLcJJOdeLJA+9tYpz4s7yyADljPgW9WqNzj+4BL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jqi6T2W3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qbgLc5LQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAL8d3K009183;
	Mon, 10 Nov 2025 22:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tqyjXIjTe/WH4TE0OwmTqG8WBXO7P04SnotToIeqRqA=; b=
	jqi6T2W3amwK5ypTmVVFRysSpIeihvuB8JFYV2y+rrSzIZhryR7HoldfYOAuCTNX
	yF3UAWWSEURb/5JvizLc2u6i8k4PUVP/uCW84wNAU5oelgoVSrWbDLQ+PhiiHjkh
	5gKR912tFKjtnp4nOe29laXD8AhxzwnugXY69tfpus3P/U3jcnhYjre3FMV6PYnn
	Dl+KAo2TJGFh7iciuwvkA6/heJXq6URPH3R+lu9t9JkgsvCzegMP5h671IKMebVK
	A0KehLw+zDsLsKa3Ogf1hgTtA1lB2QdwSQDOEVjkXSydCFfOU16KQtbQ3FtvFdJK
	hyWZQ+ykfXDJqA7VU/tehg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqpug5sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAKGUhs007458;
	Mon, 10 Nov 2025 22:22:03 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va997sw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBJzXQ5EDN0DY7nQDNcXKYMXpcZmh3ovONyG8kK4l5gZwbunlyTysND8cuSkzCfmO/Ac+9WkMVXu9I8US5109V8KD7j+mPCZLqpwqjDRYejGOKvwtVZLnB642y7jc/qGK7S7UMqfTOUcGBbwnReipS1W8UFXbTlUk4/KzWlO58N4ZLXp0hIgW1PHlVq6r0hUZKLkW1rD7mApx1FUwrBZ2q4gknZ90DOwX/IVZL0wFjcSX1LcSRGu0+JgXYQEfQuA82oxvp5bxyVPrmLMLKLOalGM4QVpFTnV0kmPCcF7yRuq3G00U2GeCyzNiLhACwtJ4e1P+9HExbuBRSQuwZIeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqyjXIjTe/WH4TE0OwmTqG8WBXO7P04SnotToIeqRqA=;
 b=wKPn8tZ5VvSHxK1FBG2Gg8Y7bgHnYUILbsy9TFC8FxY/wtV7LGDp4I31AlzF0ez1shINhEXI70P9rMnxTC9oKOgb7wQ6N5jUvGinggLi7FA8A1hBU3GTh01mYV7+3OuiqWc7rxbUHWua43eRkMIVsgqjQbR1NLDouWEUBzmhrDo4Sh6WSzPD8J5UrD/lnuoPL4oaFPoqMY3YskdzXMwtimZWkGONZFo8ftyGtFdkPdlz1yDGEpqZeaBrM4zV/23Q9IX3PgW0LDP+ez9mxzfq45y5TWTN1dXdW21H2HNhS3h1aciQi1cTfgQjte/3PC3pI9VOFvlZa+qsvNfliCy9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqyjXIjTe/WH4TE0OwmTqG8WBXO7P04SnotToIeqRqA=;
 b=qbgLc5LQcQHJCGlhhIjZEiu2aW7NbaPI7h9Muos/x9wspEieOXdFErfCGRfOhM60Y3p0yT/Ux5rZz0fnPV8hl2dkSaMsxdV3XBdbT6XOI9FEYOAp+xTG67HHzOymLGVBTHtad053XQSbnAffkSLxnVsYVbUdeBjp4gCyEhfSUt0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:58 +0000
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
Subject: [PATCH v3 10/16] mm: replace pmd_to_swp_entry() with softleaf_from_pmd()
Date: Mon, 10 Nov 2025 22:21:28 +0000
Message-ID: <3fb431699639ded8fdc63d2210aa77a38c8891f1.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c00907b-f3c1-4be6-bc73-08de20a79052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrDG4MwVkrX75OFrUKUuTXPczyXn0qV2WX3euYCP17T9JBItnlXM+7jvKGI7?=
 =?us-ascii?Q?fRoUkeRk4QtZTxavaN4dOJ2weSvMTA51hIUtvZys8LdIVzSqbaBFN5ec4s45?=
 =?us-ascii?Q?AzCn5rGyy0Sqvjfvz/ccjyuNGlZ2ND/PlbFqG7D/17o9UjfJvqTCDCDaYdaD?=
 =?us-ascii?Q?USRyMVW0bWzt2YLpKsiTCbboyyVuBjQlDsnnca282+xPBJJ2RXhbJdvnsYEk?=
 =?us-ascii?Q?dZlX1Vwwr3P/s3KMrnwmz2dvHMHuoMaX4zJ1usse7T/dmf0r0hauOS25QI25?=
 =?us-ascii?Q?I8f9v830rZbUmBkgq8KycohQcBUotOPUAwWOEFFHtwNOkC+wVc2Jfs8TBGe2?=
 =?us-ascii?Q?tO5Q22vOdDM0f+6ltrXFLbw+fXasF5xSqEBT8kRtTq/PrOrufTYMUDmOhiwF?=
 =?us-ascii?Q?Nf7WzgVfv6X1E+ZCWlAc7o8/np7falm5X18x6b0EyaOrCUzUdi/7g/1xYb4E?=
 =?us-ascii?Q?kucyxEPt8hko9wrvBvIguYdeFc3MDunCYJhFiDlF7iiK6hQt5ksZGzg3h+bQ?=
 =?us-ascii?Q?gFhX5gGH7ZkNhAwrKHd6m6Ommn16J6UoVkRxriGeCB7GtQ6ABrc+x/+/8/vM?=
 =?us-ascii?Q?ZkFk5SWzUwfkQCHcyxA5b1OmfLEd4+CY1URNv1LKG6H66UU7z+VRaLHaGJbr?=
 =?us-ascii?Q?whor1tymFAixwUwclne34EHd39Eig9XiS85kZttGxwMeD3+8pDlqIGMiuSbI?=
 =?us-ascii?Q?fa/iKZwRQcQABjRWoNPEDe1MLR85yF6JvjQCPPkOl3Uezn/OF5Gn8ZrhFHs7?=
 =?us-ascii?Q?p6CUsbuHGcJ1iBrMK7Yxa5IyYG1U/IbjeGoL8tEkwQhvKnctP+UH0S5DHlw+?=
 =?us-ascii?Q?PZWzrlBT6CFkVY9/IgeFrF59q/kLt9sFIo4y1daq64iSs60faHFwBadHLNho?=
 =?us-ascii?Q?vfUeAS+rJ/E0XGbY5OGQ4y942xGdP5gi8u5BhojLhRm3bhi7wjcHchi15HLq?=
 =?us-ascii?Q?SVl8TuxUEY3/w4339T1b3srj7ppTqDk+0B0hRfj71sqT+lQYl5veWwWGK77w?=
 =?us-ascii?Q?U9OGpHpXArhRuvoACBng70HC5O2zYwKgMULbUDyzn3El4Y0rdSAFkgFt234U?=
 =?us-ascii?Q?wjBg7YORcQ6Zk2/rnRUwAfXOSDx6Wcj6EUfIfEt/85Fzflslb7uxZTftU2qq?=
 =?us-ascii?Q?G67zFuzHX9BSpOaA6p4x6poPWSQo+cXvd+Zdbe63Vrbl+x6nWr66J09t7PfH?=
 =?us-ascii?Q?sZ/nrK9ahMfybJzuDG5T614SusdnE070zwYPskthA1BWUEAH5QQ9nPCA03fr?=
 =?us-ascii?Q?nWkMqHFDa8Tj7Ew7XRxTlHB8vGkaSwygAu5yDYg6OJ8VQwFVX+oeXyX6W00Z?=
 =?us-ascii?Q?Oa10unoKNQm0RS9XpRoY/H0kjCbGDa+VmALvrkkVdw7RldTvgZHXGZ3E0Ido?=
 =?us-ascii?Q?bl41v8dW58/UXoodqcsZ3/zTRQYrjMSyLp1qO/tT2uy3QEId3KLQzRnjGSDT?=
 =?us-ascii?Q?UlvqjN4B0xoYzA9gNO8eR1v5QwbCMcC0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rk3XYiMA4qRCQbIzanROfd7FmxtFLK8V0BZ/kMKDGLqKvCdqRjz1mwZp3WU/?=
 =?us-ascii?Q?U8zcGWSft0W7JNaOMmLjCy4UX7Ro+9qnuWpcnXhvR6YvMw2UpFkbjM9uaSG8?=
 =?us-ascii?Q?QbRtCGJUotnnxfqzTL9fYgCevKNMv8Njs4TQ2g/iB7yxxV4xGixkuBp0qjlD?=
 =?us-ascii?Q?RVKT/u/Q4x2YmKukjmcmcZrY5znn/7p1pEbKjAP2avysMSSNJshDJVx6QTqm?=
 =?us-ascii?Q?ZKPz5Q/XdPE8DPnRnZzYkwzhVwEGbZiAH8JiaqBh8ZDYV3cjuNN8mhmCHbej?=
 =?us-ascii?Q?40GDk2SMxhTtjJwhg4pclmYi4J4sCXxp9iLN7vR8Xetw+UXf22jvv67VBQad?=
 =?us-ascii?Q?+qnluBYhHcKyMx1SYK9ALMl2GLBf0SZexgBzmKrf8+f0hc252LQ3goPGN4/8?=
 =?us-ascii?Q?Gf3QCLlfsTWaydLBh67UXsCBvFxI1PIt6g/wTE98hcXOgBJGGqoQY+PJLjpD?=
 =?us-ascii?Q?EPwCT80x0PDbWdaTKmJ6oKYrHiLKezdBPejcBx9Kmb46smIRBiWVUa+qrAGw?=
 =?us-ascii?Q?rBM8eLP0N7HrrrJJMAoGUkhSRglcegqdfDcvasEQ21PV/1Xn/4Snp85lPHDL?=
 =?us-ascii?Q?CZAIAgnmbihNaBJ0RScBrUmks1Citb8/sNG1avlC/csxmYA+C1Uj2D26j0BB?=
 =?us-ascii?Q?Xz1hNZFFiErNJair2QkIrDnHdFeiT6OO3t8BfBTO7ol4Q+W8hspE2fw7DLaf?=
 =?us-ascii?Q?Ty+YWmzCjBz9kxWzr3uJrR1QLPQBPlKrg1unXd+yvZvlkAfmtoqzqJnN2l3F?=
 =?us-ascii?Q?U2lh4jLm85EEjwUGpl52yaxlArShJxoW2P7B3bVPxGfKQT3QqWlHNAgajAJI?=
 =?us-ascii?Q?Zcx6oUNBbQ3BIyKCtudtMsjjdJk2bR3YNbdXr0hxnMm2ZkkPeNbTMjwl3CNt?=
 =?us-ascii?Q?LPdArXjTgA2Fwh1ozEXBvVT3aNFigpjKadqtjrrDwvR8pAm5dyxlGcDXhq+e?=
 =?us-ascii?Q?k/TXHEn7qv+j3XFauLFEIsOjDz85gqxhmzHptt03BIBr5twFunTcr9djvT77?=
 =?us-ascii?Q?0cuhsEBoUzneEBkNvoAa/9TnJqSJQpi+BczvZ2i+EKazjsOI+fhSVXufrgMD?=
 =?us-ascii?Q?R/47QtCDJfQHEaQ6y5QS8A++38qGQqYEMcmYE8nM54jNnyGF0Sp+GBG3Q8ih?=
 =?us-ascii?Q?R1ieYn4In7rr9G71/+6Zj7Ak6A4FutsTNNFZg13u58VutH3r+BMFpSmNZ5O9?=
 =?us-ascii?Q?yb6rYtr+VunM0xOfHAcF7BrhaY8abEJixgo9SMTrkBulWThX+pDWAcRHLq0X?=
 =?us-ascii?Q?mxHR+gzTTI5CYh/sZY3dL8b/zd9PIecckc0ms1qPbJIXtx1fh0EUVPq1ce5y?=
 =?us-ascii?Q?OBAjn6+B2ji2koOaYbJPyf3UTShrYx9+qB5qK/Y7qLDQDyfWWOeEB4zR2mxn?=
 =?us-ascii?Q?b38xXoooiw3dYfyo4nVzn5B0IVUupEygofORlWHeKJ1EjkzbWZOxjrkDbiqx?=
 =?us-ascii?Q?8voOoihiow0WgV4ha8ZrT/7az0NbNdKXlbNTsBXV8pblSg/WbMv2yVUD+QPg?=
 =?us-ascii?Q?uZEC3LKYhZFmlPLooSNe9YvG7ySXhoEMdLCDw1mTYaanEnuF4nKNs+4xMh70?=
 =?us-ascii?Q?RO9k39JsbFjUBrf/3crqIOCAOfaEz6G0rnyBHYZrYQr4Q9qBV+ff6eBZlZ5h?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ce6JZumWx3ypSnBJI0mGNrlyIF9DiC08g4gsiNZ4XbKaTmOvByQ0oVPH82hKdxX+SvTLkUo7FJf/8uzPOsl5UYpfHcW6qhhKoI6QXK+CoV7xjnrWe77PXhB9ytAen5OPXTIflDRgz1OL0zaBKtblKcTOhMk0Pw9LswYgz3qOBp+BrbIgw2o/2kK77K5fv1PcJldZe97VwXdLFUK1OBcXRFsQF7sg6lwOOW/gLNtodSEoZj7tBnv6+YOnulz9cDD+jHr0GdK4QE6tmUS4sfnM3t/g7swGJvITksbS83SlFs20kc7pHjn4QK0CTG/o4kIyGIZrQlJSkZ3yTegojo3HC31sj7EYkGBTn9ZVaF5FkVpEaBSwLWEyADO4dm6NftU1A2V1s3fWs5V7foRmDE4/ocIzMk2VuWbKPeeNnkeBwHONF6q/S35GhRP+nml7gpKLzUxxyPMI/W8n1c8eEIs2q7jBIGygLqloWK7h60KfJ8c87cqexhOj9SgL9wXltJDWZmJHGpV73VuZZgJmWJHw1zVV5suuNAKZHe+3oFcr7kdKkke7LJdZiEf+kq/59Ii9rlr1cyGvx0aaQgrJ13tiPdEebpSYQHNmIX7RqW9jJyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c00907b-f3c1-4be6-bc73-08de20a79052
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:58.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxPF0Z77Bn13itgv4qnb4iRIacJm2Pd6Qgjfm4l3IYg756RRLX/sbUFh/MoNUR7BGtJuU1SIixzr/LohRp2/j9Yg3hXTS0i3J5s6hyAybcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfX3Syre37iH4Xg
 79ijIrJhQpP4DcHiW3y5CTwTqQ8qZthQRI1i2DfqC19Fsx+H9qtCxKNeus1Jyv4Xz41/UaaT9UX
 OgAE3zrWBnEPOEvD8VUR8bZrv8lvQkpkjB7OIsmxOcflwJRAtwp/aME6rfn7pTajjFgFkK+DSMB
 9khYFMRjvsTqe8JX1Yz76oYGrGEOOt5ltft1bcd7CXUOEX6+jrFlnoZl65vf1KRgHoE0TixQPdu
 f2MT/FjBaUK9fnSSZysqtOe0MGh4OHfLyyBUYbqxvgeXBoh0qiQys7cC/Ckn86nqEAo/K1QNxRr
 5VRA93Fb9/fwjULFY6fHvEFT4vg3z3oXJtMb0NOaJjAWjyJktA81hXR1LXaMvZbUVGq4CqQS1pQ
 KreJo5zQEaAP8IKjk4W+O36EL9n5+g==
X-Authority-Analysis: v=2.4 cv=H5rWAuYi c=1 sm=1 tr=0 ts=6912658c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=1B2o6Llj8-7n3TOjnuQA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: VvwX3RcCNMOFNSnDmD20JaddGCRjsrYG
X-Proofpoint-GUID: VvwX3RcCNMOFNSnDmD20JaddGCRjsrYG

Introduce softleaf_from_pmd() to do the equivalent operation for PMDs that
softleaf_from_pte() fulfils, and cascade changes through code base
accordingly, introducing helpers as necessary.

We are then able to eliminate pmd_to_swp_entry(), is_pmd_migration_entry(),
is_pmd_device_private_entry() and is_pmd_non_present_folio_entry().

This further establishes the use of leaf operations throughout the code
base and further establishes the foundations for eliminating is_swap_pmd().

No functional change intended.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      |  27 +++--
 include/linux/leafops.h | 218 +++++++++++++++++++++++++++++++++++++++-
 include/linux/migrate.h |   2 +-
 include/linux/swapops.h | 100 ------------------
 mm/damon/ops-common.c   |   6 +-
 mm/filemap.c            |   6 +-
 mm/hmm.c                |  16 +--
 mm/huge_memory.c        |  98 +++++++++---------
 mm/khugepaged.c         |   4 +-
 mm/madvise.c            |   2 +-
 mm/memory.c             |   4 +-
 mm/mempolicy.c          |   4 +-
 mm/migrate.c            |  20 ++--
 mm/migrate_device.c     |  14 +--
 mm/page_table_check.c   |  16 +--
 mm/page_vma_mapped.c    |  15 +--
 mm/pagewalk.c           |   8 +-
 mm/rmap.c               |   4 +-
 18 files changed, 339 insertions(+), 225 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b68eabb26f29..d982fdfcf057 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1065,10 +1065,10 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
 	} else if (unlikely(thp_migration_supported())) {
-		swp_entry_t entry = pmd_to_swp_entry(*pmd);
+		const softleaf_t entry = softleaf_from_pmd(*pmd);
 
-		if (is_pfn_swap_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
+		if (softleaf_has_pfn(entry))
+			page = softleaf_to_page(entry);
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
@@ -1654,7 +1654,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		pmd = pmd_clear_soft_dirty(pmd);
 
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+	} else if (pmd_is_migration_entry(pmd)) {
 		pmd = pmd_swp_clear_soft_dirty(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
@@ -2015,12 +2015,12 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		if (pm->show_pfn)
 			frame = pmd_pfn(pmd) + idx;
 	} else if (thp_migration_supported()) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		const softleaf_t entry = softleaf_from_pmd(pmd);
 		unsigned long offset;
 
 		if (pm->show_pfn) {
-			if (is_pfn_swap_entry(entry))
-				offset = swp_offset_pfn(entry) + idx;
+			if (softleaf_has_pfn(entry))
+				offset = softleaf_to_pfn(entry) + idx;
 			else
 				offset = swp_offset(entry) + idx;
 			frame = swp_type(entry) |
@@ -2031,7 +2031,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_SOFT_DIRTY;
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
-		VM_WARN_ON_ONCE(!is_pmd_migration_entry(pmd));
+		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
 		page = pfn_swap_entry_to_page(entry);
 	}
 
@@ -2425,8 +2425,6 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
 	} else {
-		swp_entry_t swp;
-
 		categories |= PAGE_IS_SWAPPED;
 		if (!pmd_swp_uffd_wp(pmd))
 			categories |= PAGE_IS_WRITTEN;
@@ -2434,9 +2432,10 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_SOFT_DIRTY;
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
-			swp = pmd_to_swp_entry(pmd);
-			if (is_pfn_swap_entry(swp) &&
-			    !folio_test_anon(pfn_swap_entry_folio(swp)))
+			const softleaf_t entry = softleaf_from_pmd(pmd);
+
+			if (softleaf_has_pfn(entry) &&
+			    !folio_test_anon(softleaf_to_folio(entry)))
 				categories |= PAGE_IS_FILE;
 		}
 	}
@@ -2453,7 +2452,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		old = pmdp_invalidate_ad(vma, addr, pmdp);
 		pmd = pmd_mkuffd_wp(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
+	} else if (pmd_is_migration_entry(pmd)) {
 		pmd = pmd_swp_mkuffd_wp(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index cff9d94fd5d1..f5ea9b0385ff 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -61,6 +61,57 @@ static inline softleaf_t softleaf_from_pte(pte_t pte)
 	return pte_to_swp_entry(pte);
 }
 
+/**
+ * softleaf_to_pte() - Obtain a PTE entry from a leaf entry.
+ * @entry: Leaf entry.
+ *
+ * This generates an architecture-specific PTE entry that can be utilised to
+ * encode the metadata the leaf entry encodes.
+ *
+ * Returns: Architecture-specific PTE entry encoding leaf entry.
+ */
+static inline pte_t softleaf_to_pte(softleaf_t entry)
+{
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_entry_to_pte(entry);
+}
+
+#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
+/**
+ * softleaf_from_pmd() - Obtain a leaf entry from a PMD entry.
+ * @pmd: PMD entry.
+ *
+ * If @pmd is present (therefore not a leaf entry) the function returns an empty
+ * leaf entry. Otherwise, it returns a leaf entry.
+ *
+ * Returns: Leaf entry.
+ */
+static inline softleaf_t softleaf_from_pmd(pmd_t pmd)
+{
+	softleaf_t arch_entry;
+
+	if (pmd_present(pmd) || pmd_none(pmd))
+		return softleaf_mk_none();
+
+	if (pmd_swp_soft_dirty(pmd))
+		pmd = pmd_swp_clear_soft_dirty(pmd);
+	if (pmd_swp_uffd_wp(pmd))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+	arch_entry = __pmd_to_swp_entry(pmd);
+
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
+}
+
+#else
+
+static inline softleaf_t softleaf_from_pmd(pmd_t pmd)
+{
+	return softleaf_mk_none();
+}
+
+#endif
+
 /**
  * softleaf_is_none() - Is the leaf entry empty?
  * @entry: Leaf entry.
@@ -134,6 +185,43 @@ static inline bool softleaf_is_swap(softleaf_t entry)
 	return softleaf_type(entry) == SOFTLEAF_SWAP;
 }
 
+/**
+ * softleaf_is_migration_write() - Is this leaf entry a writable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a writable migration entry, otherwise
+ * false.
+ */
+static inline bool softleaf_is_migration_write(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_MIGRATION_WRITE;
+}
+
+/**
+ * softleaf_is_migration_read() - Is this leaf entry a readable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a readable migration entry, otherwise
+ * false.
+ */
+static inline bool softleaf_is_migration_read(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_MIGRATION_READ;
+}
+
+/**
+ * softleaf_is_migration_read_exclusive() - Is this leaf entry an exclusive
+ * readable migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is an exclusive readable migration entry,
+ * otherwise false.
+ */
+static inline bool softleaf_is_migration_read_exclusive(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_MIGRATION_READ_EXCLUSIVE;
+}
+
 /**
  * softleaf_is_migration() - Is this leaf entry a migration entry?
  * @entry: Leaf entry.
@@ -152,6 +240,19 @@ static inline bool softleaf_is_migration(softleaf_t entry)
 	}
 }
 
+/**
+ * softleaf_is_device_private_write() - Is this leaf entry a device private
+ * writable entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a device private writable entry, otherwise
+ * false.
+ */
+static inline bool softleaf_is_device_private_write(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_DEVICE_PRIVATE_WRITE;
+}
+
 /**
  * softleaf_is_device_private() - Is this leaf entry a device private entry?
  * @entry: Leaf entry.
@@ -170,10 +271,10 @@ static inline bool softleaf_is_device_private(softleaf_t entry)
 }
 
 /**
- * softleaf_is_device_exclusive() - Is this leaf entry a device exclusive entry?
+ * softleaf_is_device_exclusive() - Is this leaf entry a device-exclusive entry?
  * @entry: Leaf entry.
  *
- * Returns: true if the leaf entry is a device exclusive entry, otherwise false.
+ * Returns: true if the leaf entry is a device-exclusive entry, otherwise false.
  */
 static inline bool softleaf_is_device_exclusive(softleaf_t entry)
 {
@@ -332,6 +433,61 @@ static inline bool softleaf_is_uffd_wp_marker(softleaf_t entry)
 	return softleaf_to_marker(entry) & PTE_MARKER_UFFD_WP;
 }
 
+#ifdef CONFIG_MIGRATION
+
+/**
+ * softleaf_is_migration_young() - Does this migration entry contain an accessed
+ * bit?
+ * @entry: Leaf entry.
+ *
+ * If the architecture can support storing A/D bits in migration entries, this
+ * determines whether the accessed (or 'young') bit was set on the migrated page
+ * table entry.
+ *
+ * Returns: true if the entry contains an accessed bit, otherwise false.
+ */
+static inline bool softleaf_is_migration_young(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_is_migration(entry));
+
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_YOUNG;
+	/* Keep the old behavior of aging page after migration */
+	return false;
+}
+
+/**
+ * softleaf_is_migration_dirty() - Does this migration entry contain a dirty bit?
+ * @entry: Leaf entry.
+ *
+ * If the architecture can support storing A/D bits in migration entries, this
+ * determines whether the dirty bit was set on the migrated page table entry.
+ *
+ * Returns: true if the entry contains a dirty bit, otherwise false.
+ */
+static inline bool softleaf_is_migration_dirty(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_is_migration(entry));
+
+	if (migration_entry_supports_ad())
+		return swp_offset(entry) & SWP_MIG_DIRTY;
+	/* Keep the old behavior of clean page after migration */
+	return false;
+}
+
+#else /* CONFIG_MIGRATION */
+
+static inline bool softleaf_is_migration_young(softleaf_t entry)
+{
+	return false;
+}
+
+static inline bool softleaf_is_migration_dirty(softleaf_t entry)
+{
+	return false;
+}
+#endif /* CONFIG_MIGRATION */
+
 /**
  * pte_is_marker() - Does the PTE entry encode a marker leaf entry?
  * @pte: PTE entry.
@@ -383,5 +539,63 @@ static inline bool pte_is_uffd_marker(pte_t pte)
 	return false;
 }
 
+#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+
+/**
+ * pmd_is_device_private_entry() - Check if PMD contains a device private swap
+ * entry.
+ * @pmd: The PMD to check.
+ *
+ * Returns true if the PMD contains a swap entry that represents a device private
+ * page mapping. This is used for zone device private pages that have been
+ * swapped out but still need special handling during various memory management
+ * operations.
+ *
+ * Return: true if PMD contains device private entry, false otherwise
+ */
+static inline bool pmd_is_device_private_entry(pmd_t pmd)
+{
+	return softleaf_is_device_private(softleaf_from_pmd(pmd));
+}
+
+#else  /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
+static inline bool pmd_is_device_private_entry(pmd_t pmd)
+{
+	return false;
+}
+
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
+
+/**
+ * pmd_is_migration_entry() - Does this PMD entry encode a migration entry?
+ * @pmd: PMD entry.
+ *
+ * Returns: true if the PMD encodes a migration entry, otherwise false.
+ */
+static inline bool pmd_is_migration_entry(pmd_t pmd)
+{
+	return softleaf_is_migration(softleaf_from_pmd(pmd));
+}
+
+/**
+ * pmd_is_valid_softleaf() - Is this PMD entry a valid leaf entry?
+ * @pmd: PMD entry.
+ *
+ * PMD leaf entries are valid only if they are device private or migration
+ * entries. This function asserts that a PMD leaf entry is valid in this
+ * respect.
+ *
+ * Returns: true if the PMD entry is a valid leaf entry, otherwise false.
+ */
+static inline bool pmd_is_valid_softleaf(pmd_t pmd)
+{
+	const softleaf_t entry = softleaf_from_pmd(pmd);
+
+	/* Only device private, migration entries valid for PMD. */
+	return softleaf_is_device_private(entry) ||
+		softleaf_is_migration(entry);
+}
+
 #endif  /* CONFIG_MMU */
 #endif  /* _LINUX_LEAFOPS_H */
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 41b4cc05a450..26ca00c325d9 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -65,7 +65,7 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list);
 
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 		struct folio *dst, struct folio *src);
-void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 		__releases(ptl);
 void folio_migrate_flags(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 3e8dd6ea94dd..f1277647262d 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -283,14 +283,6 @@ static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_young(swp_entry_t entry)
-{
-	if (migration_entry_supports_ad())
-		return swp_offset(entry) & SWP_MIG_YOUNG;
-	/* Keep the old behavior of aging page after migration */
-	return false;
-}
-
 static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 {
 	if (migration_entry_supports_ad())
@@ -299,14 +291,6 @@ static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_dirty(swp_entry_t entry)
-{
-	if (migration_entry_supports_ad())
-		return swp_offset(entry) & SWP_MIG_DIRTY;
-	/* Keep the old behavior of clean page after migration */
-	return false;
-}
-
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 extern void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *pte);
@@ -349,20 +333,11 @@ static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 	return entry;
 }
 
-static inline bool is_migration_entry_young(swp_entry_t entry)
-{
-	return false;
-}
-
 static inline swp_entry_t make_migration_entry_dirty(swp_entry_t entry)
 {
 	return entry;
 }
 
-static inline bool is_migration_entry_dirty(swp_entry_t entry)
-{
-	return false;
-}
 #endif	/* CONFIG_MIGRATION */
 
 #ifdef CONFIG_MEMORY_FAILURE
@@ -487,18 +462,6 @@ extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 
 extern void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd);
 
-static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
-{
-	swp_entry_t arch_entry;
-
-	if (pmd_swp_soft_dirty(pmd))
-		pmd = pmd_swp_clear_soft_dirty(pmd);
-	if (pmd_swp_uffd_wp(pmd))
-		pmd = pmd_swp_clear_uffd_wp(pmd);
-	arch_entry = __pmd_to_swp_entry(pmd);
-	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
-}
-
 static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 {
 	swp_entry_t arch_entry;
@@ -507,23 +470,7 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 	return __swp_entry_to_pmd(arch_entry);
 }
 
-static inline int is_pmd_migration_entry(pmd_t pmd)
-{
-	swp_entry_t entry;
-
-	if (pmd_present(pmd))
-		return 0;
-
-	entry = pmd_to_swp_entry(pmd);
-	return is_migration_entry(entry);
-}
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
-static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
-		struct page *page)
-{
-	BUILD_BUG();
-}
-
 static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 		struct page *new)
 {
@@ -532,64 +479,17 @@ static inline void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
 
 static inline void pmd_migration_entry_wait(struct mm_struct *m, pmd_t *p) { }
 
-static inline swp_entry_t pmd_to_swp_entry(pmd_t pmd)
-{
-	return swp_entry(0, 0);
-}
-
 static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 {
 	return __pmd(0);
 }
 
-static inline int is_pmd_migration_entry(pmd_t pmd)
-{
-	return 0;
-}
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_ARCH_ENABLE_THP_MIGRATION)
-
-/**
- * is_pmd_device_private_entry() - Check if PMD contains a device private swap entry
- * @pmd: The PMD to check
- *
- * Returns true if the PMD contains a swap entry that represents a device private
- * page mapping. This is used for zone device private pages that have been
- * swapped out but still need special handling during various memory management
- * operations.
- *
- * Return: 1 if PMD contains device private entry, 0 otherwise
- */
-static inline int is_pmd_device_private_entry(pmd_t pmd)
-{
-	swp_entry_t entry;
-
-	if (pmd_present(pmd))
-		return 0;
-
-	entry = pmd_to_swp_entry(pmd);
-	return is_device_private_entry(entry);
-}
-
-#else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
-
-static inline int is_pmd_device_private_entry(pmd_t pmd)
-{
-	return 0;
-}
-
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
-
 static inline int non_swap_entry(swp_entry_t entry)
 {
 	return swp_type(entry) >= MAX_SWAPFILES;
 }
 
-static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
-{
-	return is_pmd_migration_entry(pmd) || is_pmd_device_private_entry(pmd);
-}
-
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 971df8a16ba4..a218d9922234 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -11,7 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include "../internal.h"
 #include "ops-common.h"
@@ -51,7 +51,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
 	if (likely(pte_present(pteval)))
 		pfn = pte_pfn(pteval);
 	else
-		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+		pfn = softleaf_to_pfn(softleaf_from_pte(pteval));
 
 	folio = damon_get_folio(pfn);
 	if (!folio)
@@ -83,7 +83,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 	if (likely(pmd_present(pmdval)))
 		pfn = pmd_pfn(pmdval);
 	else
-		pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
+		pfn = softleaf_to_pfn(softleaf_from_pmd(pmdval));
 
 	folio = damon_get_folio(pfn);
 	if (!folio)
diff --git a/mm/filemap.c b/mm/filemap.c
index ff75bd89b68c..950d93885e38 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -21,7 +21,7 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -1402,7 +1402,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
  * This follows the same logic as folio_wait_bit_common() so see the comments
  * there.
  */
-void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
+void migration_entry_wait_on_locked(softleaf_t entry, spinlock_t *ptl)
 	__releases(ptl)
 {
 	struct wait_page_queue wait_page;
@@ -1411,7 +1411,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, spinlock_t *ptl)
 	unsigned long pflags;
 	bool in_thrashing;
 	wait_queue_head_t *q;
-	struct folio *folio = pfn_swap_entry_folio(entry);
+	struct folio *folio = softleaf_to_folio(entry);
 
 	q = folio_waitqueue(folio);
 	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
diff --git a/mm/hmm.c b/mm/hmm.c
index e350d0cc9d41..e9735a9b6102 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/mmzone.h>
 #include <linux/pagemap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/hugetlb.h>
 #include <linux/memremap.h>
 #include <linux/sched/mm.h>
@@ -339,19 +339,19 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long npages = (end - start) >> PAGE_SHIFT;
+	const softleaf_t entry = softleaf_from_pmd(pmd);
 	unsigned long addr = start;
-	swp_entry_t entry = pmd_to_swp_entry(pmd);
 	unsigned int required_fault;
 
-	if (is_device_private_entry(entry) &&
-	    pfn_swap_entry_folio(entry)->pgmap->owner ==
+	if (softleaf_is_device_private(entry) &&
+	    softleaf_to_folio(entry)->pgmap->owner ==
 	    range->dev_private_owner) {
 		unsigned long cpu_flags = HMM_PFN_VALID |
 			hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
-		unsigned long pfn = swp_offset_pfn(entry);
+		unsigned long pfn = softleaf_to_pfn(entry);
 		unsigned long i;
 
-		if (is_writable_device_private_entry(entry))
+		if (softleaf_is_device_private_write(entry))
 			cpu_flags |= HMM_PFN_WRITE;
 
 		/*
@@ -370,7 +370,7 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 	required_fault = hmm_range_need_fault(hmm_vma_walk, hmm_pfns,
 					      npages, 0);
 	if (required_fault) {
-		if (is_device_private_entry(entry))
+		if (softleaf_is_device_private(entry))
 			return hmm_vma_fault(addr, end, required_fault, walk);
 		else
 			return -EFAULT;
@@ -412,7 +412,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	if (pmd_none(pmd))
 		return hmm_vma_walk_hole(start, end, -1, walk);
 
-	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
+	if (thp_migration_supported() && pmd_is_migration_entry(pmd)) {
 		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0)) {
 			hmm_vma_walk->last = addr;
 			pmd_migration_entry_wait(walk->mm, pmdp);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40a8a2c1e080..5876595b00d5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1374,7 +1374,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 	spinlock_t *ptl;
-	swp_entry_t swp_entry;
+	softleaf_t entry;
 	struct page *page;
 	struct folio *folio;
 
@@ -1389,8 +1389,8 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 		return 0;
 	}
 
-	swp_entry = pmd_to_swp_entry(vmf->orig_pmd);
-	page = pfn_swap_entry_to_page(swp_entry);
+	entry = softleaf_from_pmd(vmf->orig_pmd);
+	page = softleaf_to_page(entry);
 	folio = page_folio(page);
 	vmf->page = page;
 	vmf->pte = NULL;
@@ -1780,13 +1780,13 @@ static void copy_huge_non_present_pmd(
 		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		pmd_t pmd, pgtable_t pgtable)
 {
-	swp_entry_t entry = pmd_to_swp_entry(pmd);
+	softleaf_t entry = softleaf_from_pmd(pmd);
 	struct folio *src_folio;
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
+	VM_WARN_ON_ONCE(!pmd_is_valid_softleaf(pmd));
 
-	if (is_writable_migration_entry(entry) ||
-	    is_readable_exclusive_migration_entry(entry)) {
+	if (softleaf_is_migration_write(entry) ||
+	    softleaf_is_migration_read_exclusive(entry)) {
 		entry = make_readable_migration_entry(swp_offset(entry));
 		pmd = swp_entry_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*src_pmd))
@@ -1794,12 +1794,12 @@ static void copy_huge_non_present_pmd(
 		if (pmd_swp_uffd_wp(*src_pmd))
 			pmd = pmd_swp_mkuffd_wp(pmd);
 		set_pmd_at(src_mm, addr, src_pmd, pmd);
-	} else if (is_device_private_entry(entry)) {
+	} else if (softleaf_is_device_private(entry)) {
 		/*
 		 * For device private entries, since there are no
 		 * read exclusive entries, writable = !readable
 		 */
-		if (is_writable_device_private_entry(entry)) {
+		if (softleaf_is_device_private_write(entry)) {
 			entry = make_readable_device_private_entry(swp_offset(entry));
 			pmd = swp_entry_to_pmd(entry);
 
@@ -1810,7 +1810,7 @@ static void copy_huge_non_present_pmd(
 			set_pmd_at(src_mm, addr, src_pmd, pmd);
 		}
 
-		src_folio = pfn_swap_entry_folio(entry);
+		src_folio = softleaf_to_folio(entry);
 		VM_WARN_ON(!folio_test_large(src_folio));
 
 		folio_get(src_folio);
@@ -2270,7 +2270,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 	if (unlikely(!pmd_present(orig_pmd))) {
 		VM_BUG_ON(thp_migration_supported() &&
-				  !is_pmd_migration_entry(orig_pmd));
+				  !pmd_is_migration_entry(orig_pmd));
 		goto out;
 	}
 
@@ -2368,11 +2368,10 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			folio_remove_rmap_pmd(folio, page, vma);
 			WARN_ON_ONCE(folio_mapcount(folio) < 0);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
-		} else if (is_pmd_non_present_folio_entry(orig_pmd)) {
-			swp_entry_t entry;
+		} else if (pmd_is_valid_softleaf(orig_pmd)) {
+			const softleaf_t entry = softleaf_from_pmd(orig_pmd);
 
-			entry = pmd_to_swp_entry(orig_pmd);
-			folio = pfn_swap_entry_folio(entry);
+			folio = softleaf_to_folio(entry);
 			flush_needed = 0;
 
 			if (!thp_migration_supported())
@@ -2428,7 +2427,7 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
 static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 {
 #ifdef CONFIG_MEM_SOFT_DIRTY
-	if (unlikely(is_pmd_migration_entry(pmd)))
+	if (unlikely(pmd_is_migration_entry(pmd)))
 		pmd = pmd_swp_mksoft_dirty(pmd);
 	else if (pmd_present(pmd))
 		pmd = pmd_mksoft_dirty(pmd);
@@ -2503,12 +2502,12 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
 		unsigned long addr, pmd_t *pmd, bool uffd_wp,
 		bool uffd_wp_resolve)
 {
-	swp_entry_t entry = pmd_to_swp_entry(*pmd);
-	struct folio *folio = pfn_swap_entry_folio(entry);
+	softleaf_t entry = softleaf_from_pmd(*pmd);
+	const struct folio *folio = softleaf_to_folio(entry);
 	pmd_t newpmd;
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
-	if (is_writable_migration_entry(entry)) {
+	VM_WARN_ON(!pmd_is_valid_softleaf(*pmd));
+	if (softleaf_is_migration_write(entry)) {
 		/*
 		 * A protection check is difficult so
 		 * just be safe and disable write
@@ -2520,7 +2519,7 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
 		newpmd = swp_entry_to_pmd(entry);
 		if (pmd_swp_soft_dirty(*pmd))
 			newpmd = pmd_swp_mksoft_dirty(newpmd);
-	} else if (is_writable_device_private_entry(entry)) {
+	} else if (softleaf_is_device_private_write(entry)) {
 		entry = make_readable_device_private_entry(swp_offset(entry));
 		newpmd = swp_entry_to_pmd(entry);
 	} else {
@@ -2718,7 +2717,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 
 	if (!pmd_trans_huge(src_pmdval)) {
 		spin_unlock(src_ptl);
-		if (is_pmd_migration_entry(src_pmdval)) {
+		if (pmd_is_migration_entry(src_pmdval)) {
 			pmd_migration_entry_wait(mm, &src_pmdval);
 			return -EAGAIN;
 		}
@@ -2983,13 +2982,12 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	unsigned long addr;
 	pte_t *pte;
 	int i;
-	swp_entry_t entry;
 
 	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
 	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
 	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
 
-	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd) && !pmd_trans_huge(*pmd));
+	VM_WARN_ON_ONCE(!pmd_is_valid_softleaf(*pmd) && !pmd_trans_huge(*pmd));
 
 	count_vm_event(THP_SPLIT_PMD);
 
@@ -3003,11 +3001,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			zap_deposited_table(mm, pmd);
 		if (!vma_is_dax(vma) && vma_is_special_huge(vma))
 			return;
-		if (unlikely(is_pmd_migration_entry(old_pmd))) {
-			swp_entry_t entry;
+		if (unlikely(pmd_is_migration_entry(old_pmd))) {
+			const softleaf_t old_entry = softleaf_from_pmd(old_pmd);
 
-			entry = pmd_to_swp_entry(old_pmd);
-			folio = pfn_swap_entry_folio(entry);
+			folio = softleaf_to_folio(old_entry);
 		} else if (is_huge_zero_pmd(old_pmd)) {
 			return;
 		} else {
@@ -3037,31 +3034,34 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		return __split_huge_zero_page_pmd(vma, haddr, pmd);
 	}
 
+	if (pmd_is_migration_entry(*pmd)) {
+		softleaf_t entry;
 
-	if (is_pmd_migration_entry(*pmd)) {
 		old_pmd = *pmd;
-		entry = pmd_to_swp_entry(old_pmd);
-		page = pfn_swap_entry_to_page(entry);
+		entry = softleaf_from_pmd(old_pmd);
+		page = softleaf_to_page(entry);
 		folio = page_folio(page);
 
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 
-		write = is_writable_migration_entry(entry);
+		write = softleaf_is_migration_write(entry);
 		if (PageAnon(page))
-			anon_exclusive = is_readable_exclusive_migration_entry(entry);
-		young = is_migration_entry_young(entry);
-		dirty = is_migration_entry_dirty(entry);
-	} else if (is_pmd_device_private_entry(*pmd)) {
+			anon_exclusive = softleaf_is_migration_read_exclusive(entry);
+		young = softleaf_is_migration_young(entry);
+		dirty = softleaf_is_migration_dirty(entry);
+	} else if (pmd_is_device_private_entry(*pmd)) {
+		softleaf_t entry;
+
 		old_pmd = *pmd;
-		entry = pmd_to_swp_entry(old_pmd);
-		page = pfn_swap_entry_to_page(entry);
+		entry = softleaf_from_pmd(old_pmd);
+		page = softleaf_to_page(entry);
 		folio = page_folio(page);
 
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 
-		write = is_writable_device_private_entry(entry);
+		write = softleaf_is_device_private_write(entry);
 		anon_exclusive = PageAnonExclusive(page);
 
 		/*
@@ -3165,7 +3165,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * Note that NUMA hinting access restrictions are not transferred to
 	 * avoid any possibility of altering permissions across VMAs.
 	 */
-	if (freeze || is_pmd_migration_entry(old_pmd)) {
+	if (freeze || pmd_is_migration_entry(old_pmd)) {
 		pte_t entry;
 		swp_entry_t swp_entry;
 
@@ -3191,7 +3191,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			VM_WARN_ON(!pte_none(ptep_get(pte + i)));
 			set_pte_at(mm, addr, pte + i, entry);
 		}
-	} else if (is_pmd_device_private_entry(old_pmd)) {
+	} else if (pmd_is_device_private_entry(old_pmd)) {
 		pte_t entry;
 		swp_entry_t swp_entry;
 
@@ -3241,7 +3241,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 	pte_unmap(pte);
 
-	if (!is_pmd_migration_entry(*pmd))
+	if (!pmd_is_migration_entry(*pmd))
 		folio_remove_rmap_pmd(folio, page, vma);
 	if (freeze)
 		put_page(page);
@@ -3254,7 +3254,7 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze)
 {
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
-	if (pmd_trans_huge(*pmd) || is_pmd_non_present_folio_entry(*pmd))
+	if (pmd_trans_huge(*pmd) || pmd_is_valid_softleaf(*pmd))
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 }
 
@@ -4855,12 +4855,12 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	unsigned long address = pvmw->address;
 	unsigned long haddr = address & HPAGE_PMD_MASK;
 	pmd_t pmde;
-	swp_entry_t entry;
+	softleaf_t entry;
 
 	if (!(pvmw->pmd && !pvmw->pte))
 		return;
 
-	entry = pmd_to_swp_entry(*pvmw->pmd);
+	entry = softleaf_from_pmd(*pvmw->pmd);
 	folio_get(folio);
 	pmde = folio_mk_pmd(folio, READ_ONCE(vma->vm_page_prot));
 
@@ -4876,20 +4876,20 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
-	if (is_writable_migration_entry(entry))
+	if (softleaf_is_migration_write(entry))
 		pmde = pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
-	if (!is_migration_entry_young(entry))
+	if (!softleaf_is_migration_young(entry))
 		pmde = pmd_mkold(pmde);
 	/* NOTE: this may contain setting soft-dirty on some archs */
-	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
+	if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
 		pmde = pmd_mkdirty(pmde);
 
 	if (folio_test_anon(folio)) {
 		rmap_t rmap_flags = RMAP_NONE;
 
-		if (!is_readable_migration_entry(entry))
+		if (!softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		folio_add_anon_rmap_pmd(folio, new, vma, haddr, rmap_flags);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a97ff7bcb232..1a08673b0d8b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -17,7 +17,7 @@
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
 #include <linux/rcupdate_wait.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/dax.h>
 #include <linux/ksm.h>
@@ -941,7 +941,7 @@ static inline int check_pmd_state(pmd_t *pmd)
 	 * collapse it. Migration success or failure will eventually end
 	 * up with a present PMD mapping a folio again.
 	 */
-	if (is_pmd_migration_entry(pmde))
+	if (pmd_is_migration_entry(pmde))
 		return SCAN_PMD_MAPPED;
 	if (!pmd_present(pmde))
 		return SCAN_PMD_NULL;
diff --git a/mm/madvise.c b/mm/madvise.c
index 58d82495b6c6..ffae3b566dc1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -390,7 +390,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		if (unlikely(!pmd_present(orig_pmd))) {
 			VM_BUG_ON(thp_migration_supported() &&
-					!is_pmd_migration_entry(orig_pmd));
+					!pmd_is_migration_entry(orig_pmd));
 			goto huge_unlock;
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index fea079e5fb90..bf2bbd0dbc97 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6362,10 +6362,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		goto fallback;
 
 	if (unlikely(!pmd_present(vmf.orig_pmd))) {
-		if (is_pmd_device_private_entry(vmf.orig_pmd))
+		if (pmd_is_device_private_entry(vmf.orig_pmd))
 			return do_huge_pmd_device_private(&vmf);
 
-		if (is_pmd_migration_entry(vmf.orig_pmd))
+		if (pmd_is_migration_entry(vmf.orig_pmd))
 			pmd_migration_entry_wait(mm, vmf.pmd);
 		return 0;
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7ae3f5e2dee6..01c3b98f87a6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -110,7 +110,7 @@
 #include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
@@ -647,7 +647,7 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 	struct folio *folio;
 	struct queue_pages *qp = walk->private;
 
-	if (unlikely(is_pmd_migration_entry(*pmd))) {
+	if (unlikely(pmd_is_migration_entry(*pmd))) {
 		qp->nr_failed++;
 		return;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 862b2e261cf9..3b6bd374157d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -16,7 +16,7 @@
 #include <linux/migrate.h>
 #include <linux/export.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
@@ -353,7 +353,7 @@ static bool remove_migration_pte(struct folio *folio,
 		rmap_t rmap_flags = RMAP_NONE;
 		pte_t old_pte;
 		pte_t pte;
-		swp_entry_t entry;
+		softleaf_t entry;
 		struct page *new;
 		unsigned long idx = 0;
 
@@ -379,22 +379,22 @@ static bool remove_migration_pte(struct folio *folio,
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
 
-		entry = pte_to_swp_entry(old_pte);
-		if (!is_migration_entry_young(entry))
+		entry = softleaf_from_pte(old_pte);
+		if (!softleaf_is_migration_young(entry))
 			pte = pte_mkold(pte);
-		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
+		if (folio_test_dirty(folio) && softleaf_is_migration_dirty(entry))
 			pte = pte_mkdirty(pte);
 		if (pte_swp_soft_dirty(old_pte))
 			pte = pte_mksoft_dirty(pte);
 		else
 			pte = pte_clear_soft_dirty(pte);
 
-		if (is_writable_migration_entry(entry))
+		if (softleaf_is_migration_write(entry))
 			pte = pte_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(old_pte))
 			pte = pte_mkuffd_wp(pte);
 
-		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
+		if (folio_test_anon(folio) && !softleaf_is_migration_read(entry))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		if (unlikely(is_device_private_page(new))) {
@@ -404,7 +404,7 @@ static bool remove_migration_pte(struct folio *folio,
 			else
 				entry = make_readable_device_private_entry(
 							page_to_pfn(new));
-			pte = swp_entry_to_pte(entry);
+			pte = softleaf_to_pte(entry);
 			if (pte_swp_soft_dirty(old_pte))
 				pte = pte_swp_mksoft_dirty(pte);
 			if (pte_swp_uffd_wp(old_pte))
@@ -543,9 +543,9 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 	spinlock_t *ptl;
 
 	ptl = pmd_lock(mm, pmd);
-	if (!is_pmd_migration_entry(*pmd))
+	if (!pmd_is_migration_entry(*pmd))
 		goto unlock;
-	migration_entry_wait_on_locked(pmd_to_swp_entry(*pmd), ptl);
+	migration_entry_wait_on_locked(softleaf_from_pmd(*pmd), ptl);
 	return;
 unlock:
 	spin_unlock(ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index c869b272e85a..880f26a316f8 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -13,7 +13,7 @@
 #include <linux/oom.h>
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -145,7 +145,6 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 	struct folio *folio;
 	struct migrate_vma *migrate = walk->private;
 	spinlock_t *ptl;
-	swp_entry_t entry;
 	int ret;
 	unsigned long write = 0;
 
@@ -169,23 +168,24 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 		if (pmd_write(*pmdp))
 			write = MIGRATE_PFN_WRITE;
 	} else if (!pmd_present(*pmdp)) {
-		entry = pmd_to_swp_entry(*pmdp);
-		folio = pfn_swap_entry_folio(entry);
+		const softleaf_t entry = softleaf_from_pmd(*pmdp);
 
-		if (!is_device_private_entry(entry) ||
+		folio = softleaf_to_folio(entry);
+
+		if (!softleaf_is_device_private(entry) ||
 			!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
 			(folio->pgmap->owner != migrate->pgmap_owner)) {
 			spin_unlock(ptl);
 			return migrate_vma_collect_skip(start, end, walk);
 		}
 
-		if (is_migration_entry(entry)) {
+		if (softleaf_is_migration(entry)) {
 			migration_entry_wait_on_locked(entry, ptl);
 			spin_unlock(ptl);
 			return -EAGAIN;
 		}
 
-		if (is_writable_device_private_entry(entry))
+		if (softleaf_is_device_private_write(entry))
 			write = MIGRATE_PFN_WRITE;
 	} else {
 		spin_unlock(ptl);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index f5f25e120f69..9af1ecff5221 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -8,7 +8,7 @@
 #include <linux/mm.h>
 #include <linux/page_table_check.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"page_table_check: " fmt
@@ -179,10 +179,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
 /* Whether the swap entry cached writable information */
-static inline bool swap_cached_writable(swp_entry_t entry)
+static inline bool softleaf_cached_writable(softleaf_t entry)
 {
-	return is_writable_device_private_entry(entry) ||
-	       is_writable_migration_entry(entry);
+	return softleaf_is_device_private(entry) ||
+		softleaf_is_migration_write(entry);
 }
 
 static void page_table_check_pte_flags(pte_t pte)
@@ -190,9 +190,9 @@ static void page_table_check_pte_flags(pte_t pte)
 	if (pte_present(pte)) {
 		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
 	} else if (pte_swp_uffd_wp(pte)) {
-		const swp_entry_t entry = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
-		WARN_ON_ONCE(swap_cached_writable(entry));
+		WARN_ON_ONCE(softleaf_cached_writable(entry));
 	}
 }
 
@@ -219,9 +219,9 @@ static inline void page_table_check_pmd_flags(pmd_t pmd)
 		if (pmd_uffd_wp(pmd))
 			WARN_ON_ONCE(pmd_write(pmd));
 	} else if (pmd_swp_uffd_wp(pmd)) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		const softleaf_t entry = softleaf_from_pmd(pmd);
 
-		WARN_ON_ONCE(swap_cached_writable(entry));
+		WARN_ON_ONCE(softleaf_cached_writable(entry));
 	}
 }
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4e23818f37f..8137d2366722 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -242,18 +242,19 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
 			if (!pmd_present(pmde)) {
-				swp_entry_t entry;
+				softleaf_t entry;
 
 				if (!thp_migration_supported() ||
 				    !(pvmw->flags & PVMW_MIGRATION))
 					return not_found(pvmw);
-				entry = pmd_to_swp_entry(pmde);
-				if (!is_migration_entry(entry) ||
-				    !check_pmd(swp_offset_pfn(entry), pvmw))
+				entry = softleaf_from_pmd(pmde);
+
+				if (!softleaf_is_migration(entry) ||
+				    !check_pmd(softleaf_to_pfn(entry), pvmw))
 					return not_found(pvmw);
 				return true;
 			}
@@ -273,9 +274,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			 * cannot return prematurely, while zap_huge_pmd() has
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
-			swp_entry_t entry = pmd_to_swp_entry(pmde);
+			const softleaf_t entry = softleaf_from_pmd(pmde);
 
-			if (is_device_private_entry(entry)) {
+			if (softleaf_is_device_private(entry)) {
 				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 				return true;
 			}
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9f91cf85a5be..3067feb970d1 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -5,7 +5,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mmu_context.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include <asm/tlbflush.h>
 
@@ -966,10 +966,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 				goto found;
 			}
 		} else if ((flags & FW_MIGRATION) &&
-			   is_pmd_migration_entry(pmd)) {
-			swp_entry_t entry = pmd_to_swp_entry(pmd);
+			   pmd_is_migration_entry(pmd)) {
+			const softleaf_t entry = softleaf_from_pmd(pmd);
 
-			page = pfn_swap_entry_to_page(entry);
+			page = softleaf_to_page(entry);
 			expose_page = false;
 			goto found;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 1954c538a991..775710115a41 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -57,7 +57,7 @@
 #include <linux/sched/task.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/ksm.h>
@@ -2341,7 +2341,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			if (likely(pmd_present(pmdval)))
 				pfn = pmd_pfn(pmdval);
 			else
-				pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
+				pfn = softleaf_to_pfn(softleaf_from_pmd(pmdval));
 
 			subpage = folio_page(folio, pfn - folio_pfn(folio));
 
-- 
2.51.0



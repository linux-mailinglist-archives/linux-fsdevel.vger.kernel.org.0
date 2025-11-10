Return-Path: <linux-fsdevel+bounces-67756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451BC49836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3A4B4E76C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEF2335095;
	Mon, 10 Nov 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TvbJWKj/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="upOpG8zb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D92F39B1;
	Mon, 10 Nov 2025 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813415; cv=fail; b=N5I1KD+8QSUW+8gKo8iQS9lS+bst5npBJ6sKowGXwUIwKkDY76PIDFYLt4qXCcgJkfoOfMr9Gu7d5zJJLTiBJ0uaG7MMCPkOo+hWgjhHVp+dhCsrhS3JS2DCXgVtm/UN1A0D6L777Q1Q1A35vh1o+j937dXQhf7K3CKaR3UCwts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813415; c=relaxed/simple;
	bh=EpKr6G0Rk11ui8D+6dz9SCRpM5mYLzPC+hQiqugBw3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnfbLpvOW8GI7+lDUEEfmLld1wOHgxqGeSrVhUILAMgz/pvP1GZEWHML+CDai35gC+Ryf/5TfI4nHpS/bSAI5UuK9M7FvBPKDF+IjI6QioqBILC9ki3FdSrmEZohh2WxApecxmBS7H0IPhdh8LTrpUNGEa/c5Oo/TBE065pszUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TvbJWKj/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=upOpG8zb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAM0dN1019647;
	Mon, 10 Nov 2025 22:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+OmHm5+r2RgMhhHMJNazyAU9W9VnLQDJDS1/tF1j8VM=; b=
	TvbJWKj/h79+yuoeK3imNHSpV6NX1RwxvvumQjz7nVULCH9j33U03inWQL+FHkQA
	tzcpPMhhNNQwI449ujp/B7jaFRYPEGGvTDwsRXnedv+yGHJeI3izFK1L615FYIEu
	AN/oYVk+5FDOJtYUMnSJ060/ZazOGJYNWJjdzvgJOET4dQDiSKtVWNrdIDomEqk8
	vqO0sYk2ZtfyAzKE/pNUfdeOHtGRRBKtwVZBZPmPUtL9s0h0J8+65fVxYY612Vsk
	FxpAGJwKZ9LUViN7Lif8uck5sN7Uz5En/5i1jUjZq0W7SA/O8lpviIuRbqXI0kzB
	5pb4nf3b75NWXbPfybTifQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqvfg49p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMBBYe020907;
	Mon, 10 Nov 2025 22:21:43 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8rhn4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awXxLhJrRa1RMLuYBg8y4+CNnH3tPd1hrqXWCSAr2OuW7zv/q9VhZHGOrpUFWkw73fb5RCz4xeb2+Vd9oMKyvTm6HpDJVIu10x3A/y5cCJ0sk6LiMZQWTsCD4+MmtMhMdu78ZL9zyQMGG6joGSJ2+ri3JikuyzN4J4WXp/Ex3lqCtuG3S5WRVptqb4YBkx7Lq0u9Qng0Yr82tP9XlwcbQvv0eQofkTI54FpO06dVReKJNmPPPjgXWS9+3/LXlL4dk/Rmuuh54AQ8R6H+xWO8ae42RrLMQegTwt2JtUWWkMN5cQ8lcuuqWBKsWgOVSq7hez1YWD3GLxOYAdAOKGsPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OmHm5+r2RgMhhHMJNazyAU9W9VnLQDJDS1/tF1j8VM=;
 b=FdZNvEzrZLAX+h1/0jaxT15gdVrCU2tNDOM5CW2rNzrM+O9GCumZ2hvltBenPbRzZXcBXICATUlsDGN4qSANMoQKrMYassA2cqLOvnSn/084UDAXu2lNSnksH4cpRSVjtPXXh82k76FVoiRt5idhoA3r3Df9vn9XIt5VrlL6zAsGqmuZzheaBEYeY6BIVb4hTmFECRav8LZtJiPMl5VhtgCzLAhg8Q56dqI8OQz/hu9ZwR/W1YRUsFC3fL6IFeOjlXc6koyjAfInkw3vwry39w7z70b61njoR+1oGV+lM8cMiqYfFS710pNxWekKmRvvPSMVr0vkB/TQXFqE1eCcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OmHm5+r2RgMhhHMJNazyAU9W9VnLQDJDS1/tF1j8VM=;
 b=upOpG8zbj6u1O23jmsrI2WmLlOPX69DRB4sj9PujgmlqOm2a35YuJbnxm1zSmMsaRLH1x9FBWNmPDPSUrxDXHjCJWsFurDrs/KBeyJEBapxbKBKC2NgLzEb4WYRMjrRiMyI2d7lPc11Z5uXF0B4iWpS/GxMosBuqYStF9PIYKX4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:39 +0000
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
Subject: [PATCH v3 01/16] mm: correctly handle UFFD PTE markers
Date: Mon, 10 Nov 2025 22:21:19 +0000
Message-ID: <c38625fd9a1c1f1cf64ae8a248858e45b3dcdf11.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: f22be284-8da9-41c4-b9d9-08de20a784fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ct3ZLE9Kvzyb/OuUli0zfxYfXgDosMU5XGllEVAftG7J5jTOW0aeIs1Qb+UX?=
 =?us-ascii?Q?h5QRJVTCIRTFff2oJTwe3P4oLtR0ddT/Y6eDDTyxUO2gQefKOFQbVV4awy7C?=
 =?us-ascii?Q?5SjjfxBhZMM+hhMqXoJPM7OfaMeRXh80MGAU3MMv2PcykunoawQCrcKRkIA+?=
 =?us-ascii?Q?dRi8U0DOWmq8CDLWHQV+WVRvWsRGZfHxd0CgqX73zRSAj4Yk5qofY/sxr2ok?=
 =?us-ascii?Q?9xevoZ0pWPrILNlQ1UhUaOZ9AhDfUgwZhAcEkUSnV89eLQXTmpEX8aQwGtDv?=
 =?us-ascii?Q?DMrp+kO5TVuYzVbMpJAC6Rx3M9TCC5uKVB0Ulp1k3I41R7ckfEEcbEFRbF9w?=
 =?us-ascii?Q?m1KDj2lQXOnWaCGfUp+05gecaf3/41JqCtBxi2lS5Ik8SiplSa0REfJERNPd?=
 =?us-ascii?Q?EVkq1J+YX0vI7S1l+Zkx5mzmuH1kSZscPOnhHUNasffvkzQimVv0RUW06Slf?=
 =?us-ascii?Q?RgROPjkFAimZyTJnhc2KEHY0zgq6EWbyoVu/iD4oJFToiPl5b6kdTqhfBRoP?=
 =?us-ascii?Q?mGnu8qHJClCEukaH+xpQgUtfV0C/Nc/WisC8yoZInlDoRXgZrJDLZywCP6m7?=
 =?us-ascii?Q?ncmi0h9k7DClUSNdYpmNDEon4xprHyzlMVk+MtAdReFy7zj8GS1fWuSzUcpw?=
 =?us-ascii?Q?di/b/HlE8YyWR1SvPpc9by369w5eAxCaTW66EZmNhO3QmWbLIStMx45xSmcu?=
 =?us-ascii?Q?LuQPdYvehdstb0dQC9TUUxln5FYEA2L5x3wZ0Iy4PgmwM31TwxQmDG2adpw8?=
 =?us-ascii?Q?huRXrkxhZ4QKoPaV618w6LrT0qYEy7BvjHtTraRB7j4yd3QlM2DiHanJ8gLU?=
 =?us-ascii?Q?zCCKnSC5Re3GpI0wQHt4i7xB/NBDsG/9X8J8U6F1v/FXQi5b4MvA0HOLcbvP?=
 =?us-ascii?Q?yTa3tL7+BtqzgUHxB7zcj54Nzdt+DBetxWr9v8nEZoYVTkgSsvYdRYiWNd0I?=
 =?us-ascii?Q?MI+Raz1dzOvj5d7/YHavnkUNH2lPmc3oUd4YrE7L8Wkyfbv6sWJTHmTiBABz?=
 =?us-ascii?Q?8TKrHV5iMQRyDUr3T4SoqRv5bnj8OokoonhwDf7RwIPe9vPL9Xo5bUAthLSh?=
 =?us-ascii?Q?TKmHQQkDcE7vhobR8NIH86F4Dibwiqu7iR6AHCucM/eSCsIG6k3z+IX5a9vm?=
 =?us-ascii?Q?/YYwDjm/XPMvWiMftCOKG7EH7qPnxRK8WIHbaKbOh4mMwp1DG/3WpFb+BrNE?=
 =?us-ascii?Q?nxcFxTO1TRQ/uAHfy7PAYcnuasHdHSqZ+LRD+v/Gx7bwWqJRMzMfcZLINaez?=
 =?us-ascii?Q?pVoSGYcbHNO/7TbzoJEMtIPG4ZeCVtg1qKAkSfVejW5TlLkhvOgBRqRwdCUW?=
 =?us-ascii?Q?Cy+8/Dnf00Rk7eF4fJdtxO2Hxy32hc+k/calehym1XcUNHXk1eluazEN7WQ5?=
 =?us-ascii?Q?y00tSYxie1ziDt7/N1pG1oQ+d9loI8f8J4QEJf3hbKEQdEnCqQibOPsYF/CX?=
 =?us-ascii?Q?63JaMjY/WhQKOxi07O17rLmRdPIJORih?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlYJKFRdM4M9RS9kbZB/nR7z5TWEF1gRhM9rQfHn4OhD49VtNt54IQKmAUsq?=
 =?us-ascii?Q?gJMXyg6oCQ+6rVD/6J5Zn5nUln+eWU893JPG6VkECkPqL9VRbw5bu3yiV2Du?=
 =?us-ascii?Q?PPi+/qpUgq/LWXA+GI3QF5RBwztAijD4lT1esPOwxGkmrb1ZOAxqVX13Qwh8?=
 =?us-ascii?Q?+qwqsBQ/jnv5xxRiGKnQDszL4L7SJeFg534dLr2MTadtZrEjCH5iz9PAZP7B?=
 =?us-ascii?Q?CfQuafxI15qMWGRBpmGBZ20y+P8tihKpoyM6TNhjkMs6EAtc2+EXg9bRuTYj?=
 =?us-ascii?Q?wtVYZDDGOmRht7TDbgv/wzaEsDHVLEL1XYEe4/hWXWyPhfytpaxxRgAvj4R1?=
 =?us-ascii?Q?hbvxb5C2UzPh9MExiRaAOWYz7FJfb+EPfsYnKJ2ddsAJMDY0QSEJnvPwnZWN?=
 =?us-ascii?Q?oYXwhUcgnHm+cDChRLpEf6ahBLXHta94jSLGGNiYQvJ1Sw+JeIdfV95n4nsN?=
 =?us-ascii?Q?96BMRlkf0o/PXy+zdgDf0QpwF6rPcQLtY8pSXVMv/aCr/NWCHEMzJcL+ibfV?=
 =?us-ascii?Q?5Koosf2RIVlgW1hxuKQsID2fdc4PRgdrtdVA2EnH/X+U2m9FZyh5DYEKxq0o?=
 =?us-ascii?Q?2ZbLTOurhc22l5PPn06T2o3KnZSqkfDomIMTzvYZcqEznqpfaaUYLuBcIFvq?=
 =?us-ascii?Q?f0sjBEozRxmyrLlPcgTy5zte/MNo7CssuQMwTHlgEdTdGZ4v9viKXbl5l6HN?=
 =?us-ascii?Q?jEk8YaUYDqkItNBEDyO7YO26sGQt4wZ1p5UizQjmgH3D/DbirU5h3Ye5Dgzv?=
 =?us-ascii?Q?jBUo95aTobU8qOhkr/1mjm8yoeTadNprPvyu5+ZltNHSURWVLu3ZuY/GROHc?=
 =?us-ascii?Q?raHNCcYLFoPTGnopiCPLLyTdhROXq86I4W/08icU32oIsLvBbVavOb2DY4aF?=
 =?us-ascii?Q?PoinoX5MgLE1rYfqH9WsakvAvp8NRK0WOcXlsk0rrpftRwYvah4BWHWiqrKu?=
 =?us-ascii?Q?oiEzX9Fv/iCtx+lxg0Yyi/JLb4rC+Zx+YyAFDsuGOIUrZ2kd10GJLCUThpY7?=
 =?us-ascii?Q?MCPAIUp2gUnmCMOi/RPmFw2BXKbnPjJZTjzrOwIpUHy2h6TWkKI8IcyT3M51?=
 =?us-ascii?Q?axb2YLdYUhmWZ5+5apcVCuSUXuaCExPDfwAabab9FW9l/mcRt0GInRmgIvXq?=
 =?us-ascii?Q?lvkjElyf4FktLMmnbFmR5od4K43LHowU6pHc62Vicj+JXy4IIkLI3GbtBOe9?=
 =?us-ascii?Q?+43Eg/ndtu0dC9mJqLGUA01zp6MXr5t33wYWS0z6rtlwODOx6KGHP2UoYq0m?=
 =?us-ascii?Q?HxvkKHuvyOSYAaT9olc7/QQRrGbPvm7cU1sv2lXWbdmZ8j8A/MjkVz6yOxwr?=
 =?us-ascii?Q?7C+lFzTMkgTfpxEuMYqtltGEhqsClYMRZcNVaT9xx/EF/R4wBRoffA7a6eIr?=
 =?us-ascii?Q?wKBNoqoqld7fl7X8S9+2W5lbYHeVgdkuA4gC94Bhks3hQn9RZMYGYBYxDZJu?=
 =?us-ascii?Q?q1LCEY11ad53hweYwEQG6nb1oNUtzX5kNsjtnVoUjcMycsiUKMVznh6i9MM6?=
 =?us-ascii?Q?6771dtMV58nmFizYsL5FvQKo2TK1xKFmGeMoDg/FBBZw1UslysLV8JICq2X0?=
 =?us-ascii?Q?n5N73UQXIeLyTd9qWMMEAfoAyWb8hcyUHinvLH2SDcGvdlm20g6dc0UIUY3r?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rykGXGR76JQFQncI+dM6UUO/+aO6DCcGWcKVGiamjA3uiLrFBAdKrNpK5He+TASKiko8R/SC0RvFW//W7xb20nfPknW4ZaUC/ioWcLvShl2ND5YSrReFp7MGzHGD/B+qMg9dfhUiIQzaT6HH3kZA19FyY7xF9zZCVcZMCjm0Yzudafw4kotlf11sL7NKvyI1l57Bk3VjkdAbOrapOWVICOfB3djJKz0CEqX4PywMw8w/TiaLEV5EDLMNvI3HjIJ0MJmnEsoc+aA56DKerYbTmnSNOm/GbDOz4dttEXCv5OBcSKAbwLkyTSioMe9Bk9tBeXCCToubFghfD9mj7db1M7qn0WK4W4ZeyyacQ9AihYL/adQDU6tKJpEr07DjSAH3M2W/z/z8tl9R7yIHPoPbdgehKolCwyWl+vwXNHQiDvasxAbLWwiAB7747I1U8gJVq/tCw/WopfzFZp8+Phlg2GR+sphdLux7ap+ooQ1d2VJWMZFfUc4nu86/ukHLcx1MlSqUvyIMi29SHzRuVTOLFmRX+u6JVbWBd/PNxwLhsSVzAZGhzJG9e0sjOnwu9FZlfVXaXL0RtAcbt5WMLod9A2B7SDDvEy1QyhBWFDQmQqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22be284-8da9-41c4-b9d9-08de20a784fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:39.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVAzVTIU8NrrlZPFfMppJd9nQZ8+PR0+z6luZuaMsTXLXfwTDS+ssnQVEk3jDCScHLtOCOlPLq2Nll15x3s1HLFeHSdVxcqxeVvLa6QeRSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100190
X-Proofpoint-GUID: nO88I5oKXZ4LCqrAVZJVNDjRF_dy7Lf9
X-Authority-Analysis: v=2.4 cv=FaY6BZ+6 c=1 sm=1 tr=0 ts=69126578 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=g27RGp_RAGdlA0bXL-AA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: nO88I5oKXZ4LCqrAVZJVNDjRF_dy7Lf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4MiBTYWx0ZWRfX6n+r3Lwjnh5r
 sipCq5XAXMGGpwddOhWJ6yjh9qS8w2qc7TC/6y2uD6SLoH1sOR33rmBvhywgt56oVDfjXJW84Ba
 86XQ7+Ig7Bm3/hd58RHkUYp2y3mkoRO7/9CKAK/rM/hyc4UgefLGHlbUNyh4puZTH7hFpX3d2IV
 GC4mHQ60eyRVMLQ9Wv71/AEbsF/J7vE7/23gppjnp9OZ7/VUM38QkWokeXTTWsww4kbBrSgIJfN
 fXx3zMIqpgEh/TU125ZDL/thM78KfgEJ74yk9sNuubdWUeNaXrejWP83AZKRBJdOXMV1YSWmWlX
 6RGdez9WXfRzVw/vq/gsKVkiY9Qf3bWRhu+a0VOdceaxTchVFo+7BEqmw1VOnVguFisbzsjQLad
 eF4aq4sIPYDNhGf/5TLjgIk2CGk/XQ==

PTE markers were previously only concerned with UFFD-specific logic - that
is, PTE entries with the UFFD WP marker set or those marked via
UFFDIO_POISON.

However since the introduction of guard markers in commit
 7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
 been the case.

Issues have been avoided as guard regions are not permitted in conjunction
with UFFD, but it still leaves very confusing logic in place, most notably
the misleading and poorly named pte_none_mostly() and
huge_pte_none_mostly().

This predicate returns true for PTE entries that ought to be treated as
none, but only in certain circumstances, and on the assumption we are
dealing with H/W poison markers or UFFD WP markers.

This patch removes these functions and makes each invocation of these
functions instead explicitly check what it needs to check.

As part of this effort it introduces is_uffd_pte_marker() to explicitly
determine if a marker in fact is used as part of UFFD or not.

In the HMM logic we note that the only time we would need to check for a
fault is in the case of a UFFD WP marker, otherwise we simply encounter a
fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
for a guard marker), so only check for the UFFD WP case.

While we're here we also refactor code to make it easier to understand.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 93 +++++++++++++++++++++--------------
 include/asm-generic/hugetlb.h |  8 ---
 include/linux/swapops.h       | 18 -------
 include/linux/userfaultfd_k.h | 21 ++++++++
 mm/hmm.c                      |  7 ++-
 mm/hugetlb.c                  | 47 +++++++++---------
 mm/mincore.c                  | 17 +++++--
 mm/userfaultfd.c              | 27 ++++++----
 8 files changed, 138 insertions(+), 100 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..375494309182 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -233,40 +233,48 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	pte_t *ptep, pte;
-	bool ret = true;
 
 	assert_fault_locked(vmf);
 
 	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
 	if (!ptep)
-		goto out;
+		return true;
 
-	ret = false;
 	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.  PTE markers should be handled the same as none
-	 * ptes here.
+	 * changes under us.
+	 */
+
+	/* Entry is still missing, wait for userspace to resolve the fault. */
+	if (huge_pte_none(pte))
+		return true;
+	/* UFFD PTE markers require userspace to resolve the fault. */
+	if (is_uffd_pte_marker(pte))
+		return true;
+	/*
+	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
+	 * resolve the fault.
 	 */
-	if (huge_pte_none_mostly(pte))
-		ret = true;
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
-		ret = true;
-out:
-	return ret;
+		return true;
+
+	return false;
 }
 #else
 static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					      struct vm_fault *vmf,
 					      unsigned long reason)
 {
-	return false;	/* should never get here */
+	/* Should never get here. */
+	VM_WARN_ON_ONCE(1);
+	return false;
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 /*
- * Verify the pagetables are still not ok after having reigstered into
+ * Verify the pagetables are still not ok after having registered into
  * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
  * userfault that has already been resolved, if userfaultfd_read_iter and
  * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
@@ -284,53 +292,63 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pmd_t *pmd, _pmd;
 	pte_t *pte;
 	pte_t ptent;
-	bool ret = true;
+	bool ret;
 
 	assert_fault_locked(vmf);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
-		goto out;
+		return true;
 	p4d = p4d_offset(pgd, address);
 	if (!p4d_present(*p4d))
-		goto out;
+		return true;
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
-		goto out;
+		return true;
 	pmd = pmd_offset(pud, address);
 again:
 	_pmd = pmdp_get_lockless(pmd);
 	if (pmd_none(_pmd))
-		goto out;
+		return true;
 
-	ret = false;
+	/*
+	 * A race could arise which would result in a softleaf entry such a
+	 * migration entry unexpectedly being present in the PMD, so explicitly
+	 * check for this and bail out if so.
+	 */
 	if (!pmd_present(_pmd))
-		goto out;
+		return false;
 
-	if (pmd_trans_huge(_pmd)) {
-		if (!pmd_write(_pmd) && (reason & VM_UFFD_WP))
-			ret = true;
-		goto out;
-	}
+	if (pmd_trans_huge(_pmd))
+		return !pmd_write(_pmd) && (reason & VM_UFFD_WP);
 
 	pte = pte_offset_map(pmd, address);
-	if (!pte) {
-		ret = true;
+	if (!pte)
 		goto again;
-	}
+
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.  PTE markers should be handled the same as none
-	 * ptes here.
+	 * changes under us.
 	 */
 	ptent = ptep_get(pte);
-	if (pte_none_mostly(ptent))
-		ret = true;
+
+	ret = true;
+	/* Entry is still missing, wait for userspace to resolve the fault. */
+	if (pte_none(ptent))
+		goto out;
+	/* UFFD PTE markers require userspace to resolve the fault. */
+	if (is_uffd_pte_marker(ptent))
+		goto out;
+	/*
+	 * If VMA has UFFD WP faults enabled and WP fault, wait for userspace to
+	 * resolve the fault.
+	 */
 	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
-		ret = true;
-	pte_unmap(pte);
+		goto out;
 
+	ret = false;
 out:
+	pte_unmap(pte);
 	return ret;
 }
 
@@ -490,12 +508,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	set_current_state(blocking_state);
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
-	if (!is_vm_hugetlb_page(vma))
-		must_wait = userfaultfd_must_wait(ctx, vmf, reason);
-	else
+	if (is_vm_hugetlb_page(vma)) {
 		must_wait = userfaultfd_huge_must_wait(ctx, vmf, reason);
-	if (is_vm_hugetlb_page(vma))
 		hugetlb_vma_unlock_read(vma);
+	} else {
+		must_wait = userfaultfd_must_wait(ctx, vmf, reason);
+	}
+
 	release_fault_lock(vmf);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index dcb8727f2b82..e1a2e1b7c8e7 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -97,14 +97,6 @@ static inline int huge_pte_none(pte_t pte)
 }
 #endif
 
-/* Please refer to comments above pte_none_mostly() for the usage */
-#ifndef __HAVE_ARCH_HUGE_PTE_NONE_MOSTLY
-static inline int huge_pte_none_mostly(pte_t pte)
-{
-	return huge_pte_none(pte) || is_pte_marker(pte);
-}
-#endif
-
 #ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		unsigned long addr, pte_t *ptep)
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 2687928a8146..d1f665935cfc 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -469,24 +469,6 @@ static inline int is_guard_swp_entry(swp_entry_t entry)
 		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
-/*
- * This is a special version to check pte_none() just to cover the case when
- * the pte is a pte marker.  It existed because in many cases the pte marker
- * should be seen as a none pte; it's just that we have stored some information
- * onto the none pte so it becomes not-none any more.
- *
- * It should be used when the pte is file-backed, ram-based and backing
- * userspace pages, like shmem.  It is not needed upon pgtables that do not
- * support pte markers at all.  For example, it's not needed on anonymous
- * memory, kernel-only memory (including when the system is during-boot),
- * non-ram based generic file-system.  It's fine to be used even there, but the
- * extra pte marker check will be pure overhead.
- */
-static inline int pte_none_mostly(pte_t pte)
-{
-	return pte_none(pte) || is_pte_marker(pte);
-}
-
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset_pfn(entry));
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26a..da0b4fcc566f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -479,4 +479,25 @@ static inline bool pte_swp_uffd_wp_any(pte_t pte)
 	return false;
 }
 
+
+static inline bool is_uffd_pte_marker(pte_t pte)
+{
+	swp_entry_t entry;
+
+	if (pte_present(pte))
+		return false;
+
+	entry = pte_to_swp_entry(pte);
+	if (!is_pte_marker_entry(entry))
+		return false;
+
+	/* UFFD WP, poisoned swap entries are UFFD handled. */
+	if (pte_marker_entry_uffd_wp(entry))
+		return true;
+	if (is_poisoned_swp_entry(entry))
+		return true;
+
+	return false;
+}
+
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/hmm.c b/mm/hmm.c
index a56081d67ad6..387a38bbaf6a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -244,7 +244,12 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	uint64_t pfn_req_flags = *hmm_pfn;
 	uint64_t new_pfn_flags = 0;
 
-	if (pte_none_mostly(pte)) {
+	/*
+	 * Any other marker than a UFFD WP marker will result in a fault error
+	 * that will be correctly handled, so we need only check for UFFD WP
+	 * here.
+	 */
+	if (pte_none(pte) || pte_marker_uffd_wp(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1ea459723cce..01c784547d1e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6743,29 +6743,28 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	vmf.orig_pte = huge_ptep_get(mm, vmf.address, vmf.pte);
-	if (huge_pte_none_mostly(vmf.orig_pte)) {
-		if (is_pte_marker(vmf.orig_pte)) {
-			pte_marker marker =
-				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
-
-			if (marker & PTE_MARKER_POISONED) {
-				ret = VM_FAULT_HWPOISON_LARGE |
-				      VM_FAULT_SET_HINDEX(hstate_index(h));
-				goto out_mutex;
-			} else if (WARN_ON_ONCE(marker & PTE_MARKER_GUARD)) {
-				/* This isn't supported in hugetlb. */
-				ret = VM_FAULT_SIGSEGV;
-				goto out_mutex;
-			}
-		}
-
+	if (huge_pte_none(vmf.orig_pte))
 		/*
-		 * Other PTE markers should be handled the same way as none PTE.
-		 *
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
 		return hugetlb_no_page(mapping, &vmf);
+
+	if (is_pte_marker(vmf.orig_pte)) {
+		const pte_marker marker =
+			pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
+
+		if (marker & PTE_MARKER_POISONED) {
+			ret = VM_FAULT_HWPOISON_LARGE |
+				VM_FAULT_SET_HINDEX(hstate_index(h));
+			goto out_mutex;
+		} else if (WARN_ON_ONCE(marker & PTE_MARKER_GUARD)) {
+			/* This isn't supported in hugetlb. */
+			ret = VM_FAULT_SIGSEGV;
+			goto out_mutex;
+		}
+
+		return hugetlb_no_page(mapping, &vmf);
 	}
 
 	ret = 0;
@@ -6934,6 +6933,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	int ret = -ENOMEM;
 	struct folio *folio;
 	bool folio_in_pagecache = false;
+	pte_t dst_ptep;
 
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
 		ptl = huge_pte_lock(h, dst_mm, dst_pte);
@@ -7073,13 +7073,14 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	if (folio_test_hwpoison(folio))
 		goto out_release_unlock;
 
+	ret = -EEXIST;
+
+	dst_ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
 	/*
-	 * We allow to overwrite a pte marker: consider when both MISSING|WP
-	 * registered, we firstly wr-protect a none pte which has no page cache
-	 * page backing it, then access the page.
+	 * See comment about UFFD marker overwriting in
+	 * mfill_atomic_install_pte().
 	 */
-	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte)))
+	if (!huge_pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
diff --git a/mm/mincore.c b/mm/mincore.c
index 8ec4719370e1..fb80becd6119 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -32,11 +32,22 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	spinlock_t *ptl;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
+
 	/*
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none_mostly(huge_ptep_get(walk->mm, addr, pte));
+	if (!pte) {
+		present = 0;
+	} else {
+		const pte_t ptep = huge_ptep_get(walk->mm, addr, pte);
+
+		if (huge_pte_none(ptep) || is_pte_marker(ptep))
+			present = 0;
+		else
+			present = 1;
+	}
+
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
@@ -175,8 +186,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		pte_t pte = ptep_get(ptep);
 
 		step = 1;
-		/* We need to do cache lookup too for pte markers */
-		if (pte_none_mostly(pte))
+		/* We need to do cache lookup too for markers */
+		if (pte_none(pte) || is_pte_marker(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte)) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 00122f42718c..cc4ce205bbec 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -178,6 +178,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	spinlock_t *ptl;
 	struct folio *folio = page_folio(page);
 	bool page_in_cache = folio_mapping(folio);
+	pte_t dst_ptep;
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte = pte_mkdirty(_dst_pte);
@@ -199,12 +200,15 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	}
 
 	ret = -EEXIST;
+
+	dst_ptep = ptep_get(dst_pte);
+
 	/*
-	 * We allow to overwrite a pte marker: consider when both MISSING|WP
-	 * registered, we firstly wr-protect a none pte which has no page cache
-	 * page backing it, then access the page.
+	 * We are allowed to overwrite a UFFD pte marker: consider when both
+	 * MISSING|WP registered, we firstly wr-protect a none pte which has no
+	 * page cache page backing it, then access the page.
 	 */
-	if (!pte_none_mostly(ptep_get(dst_pte)))
+	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
 		goto out_unlock;
 
 	if (page_in_cache) {
@@ -583,12 +587,15 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE) &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
-			err = -EEXIST;
-			hugetlb_vma_unlock_read(dst_vma);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			goto out_unlock;
+		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
+			const pte_t ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
+
+			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
+				err = -EEXIST;
+				hugetlb_vma_unlock_read(dst_vma);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+				goto out_unlock;
+			}
 		}
 
 		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma, dst_addr,
-- 
2.51.0



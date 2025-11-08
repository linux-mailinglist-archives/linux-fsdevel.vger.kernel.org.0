Return-Path: <linux-fsdevel+bounces-67535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D19CC43075
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A63B1AAC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA9242D7D;
	Sat,  8 Nov 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X7E3oaiu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kGsxY1Ca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1F23C4ED;
	Sat,  8 Nov 2025 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621819; cv=fail; b=n82r+dioAjLOUHVEPZTEsdmXXT/SQjpwfRtd8za+67kxUkK6QitYYVhaiYRt8waqG6htSS3z1wF9MEuXN3BKQKwKp3IpWIsYZZVcXlhs39XkA/OqC9NdUDhZG5eM4Raq8H3J7fepcs28t63UBYN501wvHoKrADKi905sAFdYE/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621819; c=relaxed/simple;
	bh=T68qemNrU9aXNg9BwcHhuUskC8JepUns48gZSOBTgIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cusVAKI2IOO1B6qtiE3GcmQZz3dLMBKfN9kmaG6QlgY8Jhaz/1RuuqB4K0FryyQGzzhL3ZOlykwbsJS66y8lCVEG4Vw70qiDl2JrrRcyGo4CIisI4JJVYDGboPbmZYJGvTGNHB+MEc9ycDG0s/9cq9PyzmUFDBVQTBcpqPaFJpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X7E3oaiu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kGsxY1Ca; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8FGYMI024142;
	Sat, 8 Nov 2025 17:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nYYuTMwRkRPS0ue5pIa/JHKJQGWQ3ZtYL9FYx6anL54=; b=
	X7E3oaiuheyZudFCWwtGtg7d3hqJo4YlBvVRmM7eMPUaJc5tSuNTAecOg4rigtV5
	+HbvBjffBIufMWRpijliobmmOJH19fs87SWkwBXmAf4wK1P6qzSYmzKh6MYh2kCV
	T2HBFq7B7MYiUEy67TldBO8LFF6d1xRYVagyYOyUGvqZTOODO3QJ0ShGDzepiidD
	wVfF7IVLpm/WlHokSmYAH+cMsUFVpOh7SV9XKJRrwe9AddGr+JlxIhGjdt6EC4Ou
	9WZqSmIW8AtYztAsnfIId+x389dLunmxJyiV7TcPNiilxXxna0k1DRarZ1f7Nt+i
	1WiQXrMCFd6fEv+R6jHdcA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa6vh84sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GoW0W007552;
	Sat, 8 Nov 2025 17:09:03 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76mus-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hi0wTXq1GMgJhgjK3qTBY4x4ZkTth2nRsCuKaAmIWsdtoka10mSXz4QjFgLec1Hl2AwKFmQ53JCnZXmLwx1JivmmYuVkLVFatln2X1y9xUk6vhq+JF6vHs/rhm4HlbRpJUyzgZRqNipvtv8GpvIu0zxsTPcTBWeJadNHfUhYCDwAYHyK6QRzlJ5ltptbgq1GXRBB8TImph+ZswXSXNI3RNVimphc+3Qwqb2bPSsJ7cyS/70iJ2vBJ//aVWWiWNfyxTWEIk7FQrWCJKHl2Jg9zAFqPUzT+pWLcRmIE7oZWwZvXhlYsTGz6S9H8Rz0DR9lcP5Eo/k31YA5qWBweZzzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYYuTMwRkRPS0ue5pIa/JHKJQGWQ3ZtYL9FYx6anL54=;
 b=NFYosp1D6GNI3ibmPZuB1/V4zOjsBbMbSmRj4mItUbnGizESmGBYAU3BHqGJ+6JZf+lUx0HHVO4CchmZRZlVDWBQuPFXKbtnJwHaD5v+dBMul+SFjH11tITr5qPwicSzUTLFxY61wUHKwbSmes+N/gssi+BlvhmdEzOwCP8NH4sq5F+39nqbzI0SMmaDDRgcddpkN0GzKu/PjyGsxhx7Kn2uW9qPcv+pU2nIux3OW3Qh5s/KlCMdN5Aal4ruILyQ97k1JlEO+6gINjy56hzBRDII51DQ8VdReQX2aaKy59Um6Ohfj5IUzoDuQn0FW9jZqeGY283ZyEzNejt3aH5miQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYYuTMwRkRPS0ue5pIa/JHKJQGWQ3ZtYL9FYx6anL54=;
 b=kGsxY1Car2I5JyZ94vuFvAFk8GV8+iBPMPcqZFNQhOnLaL0UQ4hcE2iQ6ghdbX9Gb3hJVKZxnd019m63aScO4K8CSuB/5szoyqZ/SsDjfDM3YhMNRxJQQwNmXHOcXKhACuknsGYJFL2Pu48vA+X1t083IqBzZPyy5RCFNT/T3v8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:08:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:08:58 +0000
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
Subject: [PATCH v2 03/16] mm: avoid unnecessary uses of is_swap_pte()
Date: Sat,  8 Nov 2025 17:08:17 +0000
Message-ID: <d34daeb9c6070e2a8b80599472547e35ae1865ff.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd14f20-d966-4f2e-9f4a-08de1ee98142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrzQNzkMROMG94lZ3CUBmB41DlplZGpfCSDQutx0yAkwvPywNLxVemLdOkQ+?=
 =?us-ascii?Q?vqxUMqU/3cbXnz+bzzMUveY9gAqrVhyr9YAoT6QEqDGe7XFT/1ofduLZeO9N?=
 =?us-ascii?Q?b3dezT1tL302mrDZMBlYZPYIIP3DGUCFk5h6HCA5Rq6flhX6cW0mVizLUTRu?=
 =?us-ascii?Q?wPwjf1qWeS2xKs9Cwlx1wKsJeSlJjKy1N/f7BUuPoluXWGN+19kBUF9n4vNp?=
 =?us-ascii?Q?5b28e+hEJSLsRB1LqreHneQb+4PHnalUXJEEh0qVsiaLlNAkFSYUclMTSYVM?=
 =?us-ascii?Q?ubTP+pqagUY8MEvJzRvIQ2voO+XXDoMA47UG8BvZDYEYzkOjXp/3pa9jW/jC?=
 =?us-ascii?Q?sOg8FAKSBwp8RXXh7ANxHHM81uNZOwPIYz8aiD6kSC5wTSyzv88TfoRofCoO?=
 =?us-ascii?Q?XmI/+tY1WHaatJMonBGPjQMbEf7hw0gqW52pEf0usjSnmnL4qT8gTcUn1QSH?=
 =?us-ascii?Q?zwOHYqxCWyAwnt5MnJgGaiMr4LD0m9oWmzpZqqystYY1W5qNtlQ7BX6SbF0R?=
 =?us-ascii?Q?fbfCjE2M1tCHKKQUIXX+n2Bj+EDabUey3jBtanXRL0ZDz4/+VrwkfOlOvFDn?=
 =?us-ascii?Q?2VGODfAK7MBwtNDN/Xjkr069AV7zrAw06NAfCQXflwMjsQfXvnzNTfPitbub?=
 =?us-ascii?Q?vLQ745SBxE946GFyhErEsQbxIjd6RDaPkcmmUr93bVnRo4rpqXbrRl+L+SEX?=
 =?us-ascii?Q?Pr7woAjQHzcPmIgaruKIbBuWNqkUpugLcLI2jWspYVfg20LoCHX4brflN2us?=
 =?us-ascii?Q?ie2UTgxrQCDMc5GwiL96fpYErcPHREQyI8ng0kq7Uj2XZIy+hpjib0YYLnq/?=
 =?us-ascii?Q?gmKchMnygHozivbiyss+P7/ldKwtevQXg9SFW0MOPQEDD7FLxfpW+47hA9Ux?=
 =?us-ascii?Q?UlOPPvEVU8+pQDQtCoXVvvkDCAbioBrnZCdTvKbsxCpg3/KBP59p90BPrRr1?=
 =?us-ascii?Q?0z13V7CSnrQmPc1cOV6fIqP5UEJUFhZyPJ7wS5W5NEzyAfF7Qav6XGgoY7nH?=
 =?us-ascii?Q?ziKbgrn/ngmN3Koa7KrFg+X3e3yt7wfgRRuxQpRHcC6Vzf/mlXZ5d+/OvMZ6?=
 =?us-ascii?Q?cYV7XJnDa/55ZRgeBjFHWHNOwtqjiC14rUf94iURO3C3zwBID8/boRrSvFjO?=
 =?us-ascii?Q?hFIziB6SdhPl/O+/MCvqjZxGMGMnKkLF4SKHlu2nLLXoU5phrm/HT9Ij/vQj?=
 =?us-ascii?Q?fF5DsNIvaWoIoCVNbNVLxJmI0BcluZjTBOe+juZHIq43GvM6qr1jz8R5waI0?=
 =?us-ascii?Q?42xoxB8uYf2q5QBmHpvstzYrrc/ht27HEs5TfMADh2tZq0HPCJiGXLqNmz0e?=
 =?us-ascii?Q?VKC1upGcZeIpCdpt5x1dzdNGvsGkfCrDmi5kPJfqmUe56BDbe91zeFhKD+k5?=
 =?us-ascii?Q?vGfVoMtGOlHGruT/n6LtKUgcH2T1PWRoXtEMm1qeMPCAPs1FzTXutr2tysl2?=
 =?us-ascii?Q?9q7KTdd/Wf2LIO8bkozBSglxieuoMbOb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p9LLFZdVioY1na8MfOG3MaxrDuJ8S0/h67iwRos8cO2Nannefj3PtmFN60z6?=
 =?us-ascii?Q?Ns8V/YdZNVuqL4/dVvBqkNav/bljaeqqwDC3IZogjNe/1lRQ+ySWUfbpef/l?=
 =?us-ascii?Q?wr+S9uOodsYDpELiudP4O+cYVZ+04O6OzhSLZDD+hxbqZAdWmt82AMV8yM0J?=
 =?us-ascii?Q?TC2OoG91WCXjkq8+xkbeUupgk7modgdLJxGNNE080KQSAekCT/l02tBQZ6Bs?=
 =?us-ascii?Q?46BWzuzVNS1bxDu4roHyVk3Z1Ru15lZfp+Y35regynavVhwS0ewzb0VoQXiF?=
 =?us-ascii?Q?WP5PaEn0PXqR+z0a0/2h/4E8aSS2yadyhPqOPGZbiP0niWOBJ/0Cao3XJHtk?=
 =?us-ascii?Q?LJ7fAZJjESyVAr7QhKifxS4h8llvj662OgPi123etk8bk/WHTvybXowMCdhG?=
 =?us-ascii?Q?33Qu73bAq1PhqzZIXBlj7TXA98ztjrCx1BJVb48wKUnPtPSRO8TJ6N5lnlSd?=
 =?us-ascii?Q?SlBw6ImF2eGE3d6ssd6uLwST09fX2uR+pdKNOk5884YH55Lj+5HymBhAu4K7?=
 =?us-ascii?Q?/GPAZuSDZ67eSFauU02g4ipUDqodIdFFohCvJN+7fPaIPQnMrjlb8rJDzBH/?=
 =?us-ascii?Q?P7KVJNxpCTVMFjQ8Lotbo9rFJI/Cyn4hxMJcE1vtHziBdFOjOvGGWdXYSoiY?=
 =?us-ascii?Q?Tyey6SGRaWBGlgPZrd09HI0rqFwLRwcn84xCuRGZArh9eCBAa0IFaA/TaFmD?=
 =?us-ascii?Q?7xOr4R4RkjfTmgwXJxiJ6msIOoX3XiiP6g1rTiHY5TmRYZoTFfiUn36BbIGt?=
 =?us-ascii?Q?bnOEZRKlBQ0ERZKiZnGgQo0jITQ9rJoXrRJs7tKWg8eZULqTM9LBoEtDL09N?=
 =?us-ascii?Q?3MW6TgP1a0YB/3SFXHC+F8hMDMnAKAqXt6zNwGUCmI7thfpuDP7Av3OW6Xaf?=
 =?us-ascii?Q?tzFodnCuQ7sms2PIzFGoxCQxRcEyiVjiMp7OXw7Q/D3+pdcEgHT0siqQjHuR?=
 =?us-ascii?Q?tT90g3z9HorPEBauBhn1M1ubi3IgIWfnkrRbiVAvHSEsqLnyZ7mE4CzikG+U?=
 =?us-ascii?Q?SGvMhA6LKfdWWWF0YyTu01L7nqzc5VEJAoLCPMOlcmMkrhd4KV93V9ACCbBT?=
 =?us-ascii?Q?XvfhHX3ZPQP7EEwrccseER+FasfazHl7RRGQG3i0y9tfrdUOxwgwe4rsN2VP?=
 =?us-ascii?Q?aOnSWBTmHfU6zXn70dSBQFGbZ2FvaPkU/FbbLZ6EJE1pMK3tWKEn32lmqzQw?=
 =?us-ascii?Q?1rhPnotftmvgAmwcyvnyj//demm4kYQqZxrB8pfRiAW8K+z3DBE2CyzTU7ff?=
 =?us-ascii?Q?Y+Sf0Ob4xolcW1NpYEtH9i/mc62pJe7uEOHDbCLJiaVs72O/yEOcQt9SiOII?=
 =?us-ascii?Q?VylEfLZwEGTe04fXIN78nrIE27eAz05N9syAAzs8Ndc+2iALe5EdEKOXotBq?=
 =?us-ascii?Q?D/Zp1F5D0ascpxPiOXwJYafIP+nkgqJHw3G8Y+OUpDhxuc84hYSEzCekb1R1?=
 =?us-ascii?Q?qo6rBwxHzNxMzdszC/B/qJU2rRCPJ70TUoG4L5aL70pnlfmG+hnxXnLzy36j?=
 =?us-ascii?Q?CyRcumz58VhPmzVukz97z3jvnOrq9J51qTsDdq1k3QvXD8noRvpZ22WGV/8H?=
 =?us-ascii?Q?sGHBMU1VNVLt9l5T0tC4OaQiAXJWfT5QkBhTH0ULmklQEIJfMaIkesRVSmHO?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PVXhzf+058YjoPmi7/Xr5euO1pqvhzsAjnfQlCgPpZQ39hagpwYtJtPuHFrqRkve1knEBuRE9xgIICR53ekl5mysFu0BNxgJoTOt/DvOawIO/2QyB2w85tFB+b30/0oambj/8jgWjmAuw3lhxpSyiJpjzykYz9cTL8yrB2IeOEc1eI+gSTuoFN2Fmal6Pys0Jpx6Cu/MCWpOXjl0qMKFcSYZHkDFYFo4x5i7vskk0Svu1pwb3jNcVk3LqeN7tDwKaKHcs4+mWd2fi9dUqsEAVC00ky6cdp9ZsednZjCqRf/wkHMcb6bsXkE8e+TsmJOPqseXwsRK2UznSPVIl2sHxkh4psWQWj0bP1iAZfX/JMI+PBsqORvzaJnkw2RK4yJnvCktzqSruFJrc3B2RjTWmhKg9iAk1mTU9nUqvBaijP0NYV67FHPugZyU2sPYEerh/6c65VS7c/VKQeqcBxfIaBoelYe7JRT+RUnbWmwMYGwzPXlJc1HSyFeRN+KRovPvsy1bY51CpDVtSctBU1ydjg8BZgy3bke+4RCMjGBq9hjUPbDxP+F8bUWbpADv28SX5Y+uB6fBBPBuvtwWm+fpsL0RRYdjN9YxVArZwFgrSRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd14f20-d966-4f2e-9f4a-08de1ee98142
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:08:57.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1gTtSvkccWqqg/PdDJv3oBDzKrTeqt9WvXyXUsSzo9ARk0w+6jGwYYncyvyxVMfS89fMdP7JH2RXKS5r+mqaswVNvXxIjYihp6kALojbN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEwOSBTYWx0ZWRfX20PbHo7tL2P1
 Xuvq/GdHWOC0NRc0MUHDestaT2LcYdG3cSYezvZPFVDybarRLDDbS12rrGS745JnOVGXB0dn2fF
 CKRj3EIiPqaUUD6Xr+lZBIxx+15FmGb3LTboTnk5jYxIHUJj4BXRHB4e7S/JcY0AXRTAUYavUz+
 1jZ7n5VuQeYu8k4tCdtC9Y5Yw5XEoI7zbJdVErg24cYUmzwd72124x7+kN1HOPYcCyknvkf6P2S
 J4etsM1x/z8CDjaiM4LgX1i4Jirl4Nx1ODidgsC8d002Kg+SvLWEg1iXHwdFqevEhZJ3wfTZONZ
 nsAUpnvog9qiTYPg/myhUMvgd+MefzPY5XpWzDyO8r24wSE5dTK+Zr1SSF1KrBJjbYDmWi8JFHm
 Nlh99v7tsycdKnln2b1VEMwgT6EVtg==
X-Authority-Analysis: v=2.4 cv=IKEPywvG c=1 sm=1 tr=0 ts=690f7930 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=360PBzQsUBXz8B3xgqMA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: MYXIVuPmrmzpOiMOi7TnugqitufDnkdo
X-Proofpoint-GUID: MYXIVuPmrmzpOiMOi7TnugqitufDnkdo

There's an established convention in the kernel that we treat PTEs as
containing swap entries (and the unfortunately named non-swap swap entries)
should they be neither empty (i.e. pte_none() evaluating true) nor present
(i.e. pte_present() evaluating true).

However, there is some inconsistency in how this is applied, as we also
have the is_swap_pte() helper which explicitly performs this check:

	/* check whether a pte points to a swap entry */
	static inline int is_swap_pte(pte_t pte)
	{
		return !pte_none(pte) && !pte_present(pte);
	}

As this represents a predicate, and it's logical to assume that in order to
establish that a PTE entry can correctly be manipulated as a swap/non-swap
entry, this predicate seems as if it must first be checked.

But we instead, we far more often utilise the established convention of
checking pte_none() / pte_present() before operating on entries as if they
were swap/non-swap.

This patch works towards correcting this inconsistency by removing all uses
of is_swap_pte() where we are already in a position where we perform
pte_none()/pte_present() checks anyway or otherwise it is clearly logical
to do so.

We also take advantage of the fact that pte_swp_uffd_wp() is only set on
swap entries.

Additionally, update comments referencing to is_swap_pte() and
non_swap_entry().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c            | 49 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  3 +--
 mm/hugetlb.c                  |  6 ++---
 mm/internal.h                 |  6 ++---
 mm/khugepaged.c               | 29 +++++++++++----------
 mm/migrate.c                  |  2 +-
 mm/mprotect.c                 | 43 ++++++++++++++----------------
 mm/mremap.c                   |  7 +++--
 mm/page_table_check.c         | 13 ++++++----
 mm/page_vma_mapped.c          | 31 +++++++++++-----------
 10 files changed, 104 insertions(+), 85 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 24d26b49d870..ddbf177ecc45 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1017,7 +1017,9 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
 		present = true;
-	} else if (is_swap_pte(ptent)) {
+	} else if (pte_none(ptent)) {
+		smaps_pte_hole_lookup(addr, walk);
+	} else {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (!non_swap_entry(swpent)) {
@@ -1038,9 +1040,6 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 				present = true;
 			page = pfn_swap_entry_to_page(swpent);
 		}
-	} else {
-		smaps_pte_hole_lookup(addr, walk);
-		return;
 	}
 
 	if (!page)
@@ -1611,6 +1610,9 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 	 */
 	pte_t ptent = ptep_get(pte);
 
+	if (pte_none(ptent))
+		return;
+
 	if (pte_present(ptent)) {
 		pte_t old_pte;
 
@@ -1620,7 +1622,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
+	} else {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
@@ -1923,6 +1925,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	struct page *page = NULL;
 	struct folio *folio;
 
+	if (pte_none(pte))
+		goto out;
+
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
 			frame = pte_pfn(pte);
@@ -1932,8 +1937,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		swp_entry_t entry;
+
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_swp_uffd_wp(pte))
@@ -1941,6 +1947,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		entry = pte_to_swp_entry(pte);
 		if (pm->show_pfn) {
 			pgoff_t offset;
+
 			/*
 			 * For PFN swap offsets, keeping the offset field
 			 * to be PFN only to be compatible with old smaps.
@@ -1969,6 +1976,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		    __folio_page_mapped_exclusively(folio, page))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
+
+out:
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
@@ -2310,12 +2319,16 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 					   struct vm_area_struct *vma,
 					   unsigned long addr, pte_t pte)
 {
-	unsigned long categories = 0;
+	unsigned long categories;
+
+	if (pte_none(pte))
+		return 0;
 
 	if (pte_present(pte)) {
 		struct page *page;
 
-		categories |= PAGE_IS_PRESENT;
+		categories = PAGE_IS_PRESENT;
+
 		if (!pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2329,10 +2342,11 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		softleaf_t entry;
 
-		categories |= PAGE_IS_SWAPPED;
+		categories = PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2360,12 +2374,12 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		old_pte = ptep_modify_prot_start(vma, addr, pte);
 		ptent = pte_mkuffd_wp(old_pte);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
-		ptent = pte_swp_mkuffd_wp(ptent);
-		set_pte_at(vma->vm_mm, addr, pte, ptent);
-	} else {
+	} else if (pte_none(ptent)) {
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
+	} else {
+		ptent = pte_swp_mkuffd_wp(ptent);
+		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
 
@@ -2434,6 +2448,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pte_none(pte))
+		return categories;
+
 	/*
 	 * According to pagemap_hugetlb_range(), file-backed HugeTLB
 	 * page cannot be swapped. So PAGE_IS_FILE is not checked for
@@ -2441,6 +2458,7 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 	 */
 	if (pte_present(pte)) {
 		categories |= PAGE_IS_PRESENT;
+
 		if (!huge_pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (!PageAnon(pte_page(pte)))
@@ -2449,8 +2467,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		categories |= PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (pte_swp_soft_dirty(pte))
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 983c860a00f1..96b089dff4ef 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -441,9 +441,8 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 static inline bool pte_swp_uffd_wp_any(pte_t pte)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	if (!is_swap_pte(pte))
+	if (pte_present(pte))
 		return false;
-
 	if (pte_swp_uffd_wp(pte))
 		return true;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a05edefec1ca..a74cde267c2a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5798,13 +5798,13 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
-	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
+	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte)) {
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
-	else {
+	} else {
 		if (need_clear_uffd_wp) {
 			if (pte_present(pte))
 				pte = huge_pte_clear_uffd_wp(pte);
-			else if (is_swap_pte(pte))
+			else
 				pte = pte_swp_clear_uffd_wp(pte);
 		}
 		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
diff --git a/mm/internal.h b/mm/internal.h
index 116a1ba85e66..9465129367a4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -325,8 +325,7 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry
  * @delta: The direction and the offset we are moving; forward if delta
  *	 is positive; backward if delta is negative
  *
@@ -352,8 +351,7 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 /**
  * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry.
  *
  * Increments the swap offset, while maintaining all other fields, including
  * swap type, and any swp pte bits. The resulting pte is returned.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f6ed1072ed6e..a97ff7bcb232 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1019,7 +1019,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		}
 
 		vmf.orig_pte = ptep_get_lockless(pte);
-		if (!is_swap_pte(vmf.orig_pte))
+		if (pte_none(vmf.orig_pte) ||
+		    pte_present(vmf.orig_pte))
 			continue;
 
 		vmf.pte = pte;
@@ -1276,7 +1277,19 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (is_swap_pte(pteval)) {
+		if (pte_none_or_zero(pteval)) {
+			++none_or_zero;
+			if (!userfaultfd_armed(vma) &&
+			    (!cc->is_khugepaged ||
+			     none_or_zero <= khugepaged_max_ptes_none)) {
+				continue;
+			} else {
+				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				goto out_unmap;
+			}
+		}
+		if (!pte_present(pteval)) {
 			++unmapped;
 			if (!cc->is_khugepaged ||
 			    unmapped <= khugepaged_max_ptes_swap) {
@@ -1296,18 +1309,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none_or_zero(pteval)) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out_unmap;
-			}
-		}
 		if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
diff --git a/mm/migrate.c b/mm/migrate.c
index ceee354ef215..862b2e261cf9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -492,7 +492,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	pte = ptep_get(ptep);
 	pte_unmap(ptep);
 
-	if (!is_swap_pte(pte))
+	if (pte_none(pte) || pte_present(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0bae241eb7aa..a3e360a8cdec 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -297,7 +297,26 @@ static long change_pte_range(struct mmu_gather *tlb,
 				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
 					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
 			pages += nr_ptes;
-		} else if (is_swap_pte(oldpte)) {
+		} else if (pte_none(oldpte)) {
+			/*
+			 * Nobody plays with any none ptes besides
+			 * userfaultfd when applying the protections.
+			 */
+			if (likely(!uffd_wp))
+				continue;
+
+			if (userfaultfd_wp_use_markers(vma)) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect a none pte, because even if the
+				 * pte is none, the page/swap cache could
+				 * exist.  Doing that by install a marker.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   make_pte_marker(PTE_MARKER_UFFD_WP));
+				pages++;
+			}
+		} else  {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 			pte_t newpte;
 
@@ -358,28 +377,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
-		} else {
-			/* It must be an none page, or what else?.. */
-			WARN_ON_ONCE(!pte_none(oldpte));
-
-			/*
-			 * Nobody plays with any none ptes besides
-			 * userfaultfd when applying the protections.
-			 */
-			if (likely(!uffd_wp))
-				continue;
-
-			if (userfaultfd_wp_use_markers(vma)) {
-				/*
-				 * For file-backed mem, we need to be able to
-				 * wr-protect a none pte, because even if the
-				 * pte is none, the page/swap cache could
-				 * exist.  Doing that by install a marker.
-				 */
-				set_pte_at(vma->vm_mm, addr, pte,
-					   make_pte_marker(PTE_MARKER_UFFD_WP));
-				pages++;
-			}
 		}
 	} while (pte += nr_ptes, addr += nr_ptes * PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/mremap.c b/mm/mremap.c
index 7c21b2ad13f6..62b6827abacf 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -158,6 +158,9 @@ static void drop_rmap_locks(struct vm_area_struct *vma)
 
 static pte_t move_soft_dirty_pte(pte_t pte)
 {
+	if (pte_none(pte))
+		return pte;
+
 	/*
 	 * Set soft dirty bit so we can notice
 	 * in userspace the ptes were moved.
@@ -165,7 +168,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 #ifdef CONFIG_MEM_SOFT_DIRTY
 	if (pte_present(pte))
 		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
+	else
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
@@ -294,7 +297,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 			if (need_clear_uffd_wp) {
 				if (pte_present(pte))
 					pte = pte_clear_uffd_wp(pte);
-				else if (is_swap_pte(pte))
+				else
 					pte = pte_swp_clear_uffd_wp(pte);
 			}
 			set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 4eeca782b888..43f75d2f7c36 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -185,12 +185,15 @@ static inline bool swap_cached_writable(swp_entry_t entry)
 	       is_writable_migration_entry(entry);
 }
 
-static inline void page_table_check_pte_flags(pte_t pte)
+static void page_table_check_pte_flags(pte_t pte)
 {
-	if (pte_present(pte) && pte_uffd_wp(pte))
-		WARN_ON_ONCE(pte_write(pte));
-	else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
-		WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)));
+	if (pte_present(pte)) {
+		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
+	} else if (pte_swp_uffd_wp(pte)) {
+		const swp_entry_t entry = pte_to_swp_entry(pte);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index be20468fb5a9..a4e23818f37f 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		    spinlock_t **ptlp)
 {
+	bool is_migration;
 	pte_t ptent;
 
 	if (pvmw->flags & PVMW_SYNC) {
@@ -26,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		return !!pvmw->pte;
 	}
 
+	is_migration = pvmw->flags & PVMW_MIGRATION;
 again:
 	/*
 	 * It is important to return the ptl corresponding to pte,
@@ -41,11 +43,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 
 	ptent = ptep_get(pvmw->pte);
 
-	if (pvmw->flags & PVMW_MIGRATION) {
-		if (!is_swap_pte(ptent))
+	if (pte_none(ptent)) {
+		return false;
+	} else if (pte_present(ptent)) {
+		if (is_migration)
 			return false;
-	} else if (is_swap_pte(ptent)) {
+	} else if (!is_migration) {
 		swp_entry_t entry;
+
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
 		 *
@@ -66,8 +71,6 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
-	} else if (!pte_present(ptent)) {
-		return false;
 	}
 	spin_lock(*ptlp);
 	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
@@ -113,21 +116,17 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 			return false;
 
 		pfn = softleaf_to_pfn(entry);
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t entry;
+	} else if (pte_present(ptent)) {
+		pfn = pte_pfn(ptent);
+	} else {
+		const softleaf_t entry = softleaf_from_pte(ptent);
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-		entry = pte_to_swp_entry(ptent);
-		if (!is_device_private_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
-			return false;
-
-		pfn = swp_offset_pfn(entry);
-	} else {
-		if (!pte_present(ptent))
+		if (!softleaf_is_device_private(entry) &&
+		    !softleaf_is_device_exclusive(entry))
 			return false;
 
-		pfn = pte_pfn(ptent);
+		pfn = softleaf_to_pfn(entry);
 	}
 
 	if ((pfn + pte_nr - 1) < pvmw->pfn)
-- 
2.51.0



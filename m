Return-Path: <linux-fsdevel+bounces-67541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 817C8C430D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F407C4E9A2A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6625EF81;
	Sat,  8 Nov 2025 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rjlvVkWG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F1ebrr97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC02561D1;
	Sat,  8 Nov 2025 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621874; cv=fail; b=fZ/qVC+LN+VoHTt7SkgANbEseudsUFU1D/Zrrif5AgkHtJ4wWTaCWunYmiTEMvmHghyWcOZ0nbj6S/A4SeSUobFz5dGwfPWHONy1wSkRwnULDVwK80DouV87dtlkBHov3+p4Chjh+PUvBL596NNibXX2+a3KduaMwv0uuHTxRJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621874; c=relaxed/simple;
	bh=oxEdzxGrJWd6pCTi5NwurPb3nyfqg6tRupFAuDaPM60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMVF3LiZnmbhyKb5BkTdMS/KfM9RmkFYFPxRhZSgmutzYp4/Eph+okx49YKnNLr21zaJXiQxAW0mY675QlSYRcsudtFqSxjEc5/86KG69TM8r9Q48dGFJ77iu/gm/BlavQGz9GBn/i0pxqUXuSBRJTbdGY+9TOkT8p6cVm89z9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rjlvVkWG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F1ebrr97; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GfF19008827;
	Sat, 8 Nov 2025 17:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GuY2tVtboAEPardNoS8eL6m9Qb5SaAi7gKx5ePxzR3o=; b=
	rjlvVkWGFVs/8zpQktrFd8DH7FLbGObHIz9Jl6sOUhkNQ91NxBzxLTmppJdzYpFG
	jPbphP82UlYwBQelGjlKbDYQQZ9ICMKNssUZdug1j+C4k69rirzwcKilmOJ4wDv+
	49VGm5hvD82DkfrCYxrFg7a4oKfq5kistumI5QIGnEL0ktcOcyBHSComi9Wc5345
	gOzEqoCUcKdDuW0EPsCsLLWdfHUxjjO6x3Y1KUxtBp9WBFPjSKHTzWuAieHmD86a
	QLUwaMzDz6E+1Qu61Xun+6uga8JsGKItu1gfd6bTeDfxY1iM3JjB7YsyK/kpz8C2
	jcHBRAXaWGsJlyc+qg5kwQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa9k8g0j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8H0Wj9000888;
	Sat, 8 Nov 2025 17:09:12 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaaps5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc4En3PYeMf4flhUPOpoGVabbk1fn1ticyJNTjuYn6nDDdgVvH+LH+mQTyvraidK+7uFTR2Tsv1uPJom6NVQVbZbO01YkJM418S904j8G3AnBpOn0nqvNSkO5hd7QwkpeAAZtCka1faeot6Wa9QiLOfHygZ0B41J9ZbeNtKgnLX54pu/AndDIQC5ihrYVYIZNAQASroBHjqnBjGYabJH8ORaCU2LmGq9b7aCFmhY67OhI707FZj5m375ZzzSFd2UuO71BSDNlRpGpCqz8b9uhk/tFREDDlVODvZe6VzKKIdG+Dj3Xy9W0xTHNymADEiXenQCdqWoVyFJ5bcfRMC5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuY2tVtboAEPardNoS8eL6m9Qb5SaAi7gKx5ePxzR3o=;
 b=mqTsv+/DZNgq0wpS6uLvcth44U/ayA9Hg5GSHlbF8pL8mqzkHNmJIfwL+LFxg4ruKDMvrbjhBLfR/g/WL073j68L79B1/wj/cUaEmmO/mIwRcPJbgj0+6cumdTU0XxcLzmgUYnziblKkiF9P1Pvx0GcR1qfVgfxR6pcSA2tOmsAoiVbMDXOo/7u7KJQlEMBwO/U3XGMPwocJWBirG3qBbOS/smHupBJnLGe7o3a6/8cs+C4imWMMEoqFt1P+w4sMD7WA85VqvKYD4NahZWkN4cY4pZcK8VNpnOxgDVF5Kl2sU1zgR/MoD07cdhH33+KvfBRZ4iLoHcnlMJjG6qXQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuY2tVtboAEPardNoS8eL6m9Qb5SaAi7gKx5ePxzR3o=;
 b=F1ebrr97bDf/5WUxPXLsFsA8H6Zn7nfjirVIDgdtot2G+z7aghPEQ2XU+TEf+Up2CrVB1pjN9hWNmunWpiinxbdZ2OBJthysXni0JUS0eKJbzDfmbo8sDzbQhuJmOHFE4AHwTJ0SgBXPZRwy7rjAPnWPTBz0phU8DJdjcOq27wU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:06 +0000
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
Subject: [PATCH v2 06/16] fs/proc/task_mmu: refactor pagemap_pmd_range()
Date: Sat,  8 Nov 2025 17:08:20 +0000
Message-ID: <377aceac6e129305f4903ec74178cdfeeb22f2d8.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dea8b9-cdac-4621-d0d3-08de1ee98656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5fmjPZJ9Z8JX0aBvrNp8v5oVjiQEUuwE30oVfQw7SsIYT+BgT6xOXBFafU2K?=
 =?us-ascii?Q?HAm64V3g2rPtrIoBLS7VKrEKs/kuQUgCpGYVg9N1pbbfIOZC3SGdkym4IjTU?=
 =?us-ascii?Q?VKwC3FSlqTh77XDAhC0i1kb3kZR0+4Reh5fYd9LsgYemHs8rRXm7tcyESPlz?=
 =?us-ascii?Q?HWgoortXvekOZH2l2a1lyWvqqq9uhFQHaDKBXAhllVuSZ59xTqvz9VCnyxtM?=
 =?us-ascii?Q?lBBLitN922qzjtYVkEuVxh8AWLWrfj0wLqaNW6V7h/8u1C114v2firOdx3uV?=
 =?us-ascii?Q?20va0o4hXGEiH7Amf6xnHytbruwDAf49Tr4Q6zWOPDOdAny332vWfPY3Zpv1?=
 =?us-ascii?Q?NM7rbv+DnIdO5HGJ2VsdRyR/zp5N1WxHPZBn+ZGPta1i3A1RLsFn73ny4/CJ?=
 =?us-ascii?Q?48eWfw1Ov86XG7j8wxVNS6dFrIbKm1G3BF7Xz2kr4pGlD5JGYCltrI/3EsIa?=
 =?us-ascii?Q?nZavX4kTUsVkNttvwEhtsohwYZ7UXN9ZQqcCvsls4NikRUiUlF/a0R71LvJR?=
 =?us-ascii?Q?TLGd0GRwpafio7XRGamMen7bhomfUrkVv/8gqhGnVGZboXNrzG79YgdknNLG?=
 =?us-ascii?Q?dbD4B9DVOm6PVCrqtQ0gSEkEZvn02dOvn2IoO/oJakzRO98o8bQFrXSybYtf?=
 =?us-ascii?Q?nEiLVIyPX+zOGWF361FU63UgnHMuqR+u5zgTbJTeHlYFFX2Z4slWYJUEdBwY?=
 =?us-ascii?Q?Czl59y/XICM7LNAFqt8ZzwpV/QK7AAoHbNzGraKUnnSPxXxWhdyR64t6ZGh4?=
 =?us-ascii?Q?ozBPMoWy15s2vqNhIyu7VVp1Uw7al7A3xPgJbLMjUzS3wBBNybdpuBCxpQb3?=
 =?us-ascii?Q?zpnP5V7LAD76yep7M95TlJMvBX/A582XCDQ9cn3yJSluxiu8gEWw1GIri5Ui?=
 =?us-ascii?Q?mNauP+jCRws/aKFcDRPiIg6GdHG9ATFVip1Ry+EVQ8QMs2woDk2fZFiEBuI7?=
 =?us-ascii?Q?/U0RcvcTX785YynczOOzppl0dJ4R14yGfqM8o/nDslbpVvpyw82j0tzBl5bz?=
 =?us-ascii?Q?kbkjvgc4UWd0EAB3G+hFeYbX4oDKIQLHKhAIiKLTH+fea4aW9e2GIgBJIoDg?=
 =?us-ascii?Q?+c9uD83msGJRNSEiH9R3CwbLa2Wm49NSoeCPXrXuROjQshUsnxemZCp6gMzL?=
 =?us-ascii?Q?37ks/RkUpUZ5qNHDmIj3EQVs/Iw012WebW0ZdE3Y2iJgc7t/lkN8aUewX9WH?=
 =?us-ascii?Q?ZE+xlk1SZJzm+uZt+lUFBKLHQBIQ+J6F6wDCC4rGvzdm8eBiM1K55mBH6+Tw?=
 =?us-ascii?Q?yvqor4WvheoIwt2NbGNXj7yU1ii02Eez8Z9Mx2Q9GWtbrrht5Za3ZQ1A9B1/?=
 =?us-ascii?Q?rEMiXJ/sSj15ZgJnhh077Vbp/ZemHw7znaBqdo1S3vJ678xPmPr6z5jt2mTT?=
 =?us-ascii?Q?hnXmFyg4so5pM76K2PtbACCAW1kgKP9MF5sFv101SRrzU5lKuKecBsDp4xF7?=
 =?us-ascii?Q?qlCbvtPyGv9dZ1f2wFaKkypYTvIbv3ZZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CM2K7Y/+weI7jnZlTK5vRvD55bIJ7WVk4N0Hq//3eOGL/pEEA4f581MWoqQF?=
 =?us-ascii?Q?C+p8TNCJt+PKxLoFg5Y1vRabjL2K3E7TCqiOGnWiHzMzZqcw+Aj0n40Wo7UN?=
 =?us-ascii?Q?vZEOXJsHRGYAw0yc+DSxUF1gBz19MCgOqePTenWfRp0B4RcEJ6nJaNx/7uMp?=
 =?us-ascii?Q?FY+rQ2FpGerJ6kNZmZMlqt9NzjXuSuRIuWFsDJhS3U/mWfelp2RdtB6J/u4y?=
 =?us-ascii?Q?qcrSZPd7kCMvql6rIEFyVyTH/l8KPDyL/HuRUmiR6sNtUgi2XOWPs8HTVLQO?=
 =?us-ascii?Q?Uhf7wrMIis0k18VF5iKyI1tnsPMPVUNvx+Tjzq88ejQerLNocYXFaZ85TAhq?=
 =?us-ascii?Q?RzsTZE4zVY5gIS23jHFjoPv0CvDIoRSIh4oV0Hhm4uL8oBBF6eDu30Fcm9fl?=
 =?us-ascii?Q?lQH2Vhqj8KczjCk8D6Wr3dPL1MyoOKoGdcghJVV7QJvFDcIRbBpN5wonWo8a?=
 =?us-ascii?Q?voo/ODzYRV0ICyj73NAzQC7TLu94tp6pLtafMrxYYKn1SXhpt5x6OLMHz17D?=
 =?us-ascii?Q?fBG1+Qh7e3lglyxn909EvY9SM7Gm8ZmMzl2Do1fPdGW7M+ukGDVr64XlWpCW?=
 =?us-ascii?Q?vDG+nXRplyGeXoXNAdQC8/onA82ZvaUQRgbb1fvDArGUqS72YgrdsOEfm9Rx?=
 =?us-ascii?Q?gFIX3ieNlN5UHHzoYa03F9pDbt1DV6JUrBurOBSS+DdLtDXg9d9kz1Gvf/Sm?=
 =?us-ascii?Q?+FyassHhlaopHjZdOlZwI+vx3xqQKmVUEG8xeQnp6C0QB8Pp0b0T1YZmtb7t?=
 =?us-ascii?Q?g2tGmCiNJ3ScVYO52xXw/LZzkaNM32IIAA6aghyZVwqXV0gLCehnjnwSPbtx?=
 =?us-ascii?Q?Y8eK4AKKLhcSb8gd7Pn1IK6kaOVCRtZdlrruF0OSyegJPLyZvaTwSN0HLx7/?=
 =?us-ascii?Q?zkRfna7JRt3WWK6PvIbJ5B7TuP1PlDuHyNORQmxc0k0ZWFWUoCCL+OQUzNpB?=
 =?us-ascii?Q?/58ASj+Wh3ImJwuLNPS0TB4uOb8HY1Z5y6nJMAGLiNRdzMEfKVB8XLkmampZ?=
 =?us-ascii?Q?ZG7mDbVyLViH/I0t5qCQrD8M3BPBxvrPrLRxOe91+y5QEk4aE0nOowVzg7cz?=
 =?us-ascii?Q?Qa9UB+UFwPLYKHGvR0Jbr3hCLhLTkp7TWjGFT9fZ7oTD+vUCg1tsQ0lWuteV?=
 =?us-ascii?Q?Hmf8wHQH9q6g6VlpjivnNcSaFRnierHEU5N77tQVpNt1ApaeC6lHp+E4yqg5?=
 =?us-ascii?Q?Ak51X6M/iHdy3/ydO2+kELE5+Rk285IiWqvTOKrWKF/FXdG1+UAWKSakyCf3?=
 =?us-ascii?Q?kg14iHsQ2i8c372hvVJL69EbXRaWIWS9cnaG7YuvY8D6DiqTc1/FoRFzg68H?=
 =?us-ascii?Q?ukqCT0KWcS++CeAyPMaPWGfkRnnPtVViGcFT3DCuLZy9vpSGmksTzg1GtMPP?=
 =?us-ascii?Q?xfJMwEgZDKP70mBEdXTpfkVXZS3U/KwpPqSjAFU0elVbBC6rYarLn6KVnuI+?=
 =?us-ascii?Q?sYar8D9hCYqscQfZr+gVP8FhuMc5t92cbspAOi/4DsNhLhMMgnEjSahjpJv4?=
 =?us-ascii?Q?u+0jwlzIV6lMIRTtidq1HFnHseZV6YiYES8FhwvGR6RitjmHJtQhRV3f3J7N?=
 =?us-ascii?Q?5+9+j2prpkrW4kSt1Yz5QyGyzwBXwKa6Tw+yvHz8BO6o91HJNcGoP2666/ZB?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dsxRcSv2sgYs0cCD3ln5GxUuA2iCmYnGYQIoE5wTcArzULv9KN1OPh8ZFfV6sl+9yi6z5/V0WazhtTa66ZFw+tuVjDicgoPWWPGhJNIPCjjyaLR541z7R6MPsNgu7BlAh0+BMZRTXwvS24BO56eHotj2DlrvLjsYWEj3lmA4SdSE7wV8RvSducbLKlkQ5tnwPggBq+2LgGkZ//R9TwL59NsnG8cBXj70skoT0lq63zCefBbGYQRac9cO8cOCgrS9AULOybrJzpw1YQk8hyNmfvgR7AcHjrxd6opyAOvDemhtZ/ZS1lGPBwHgs1jO0iaPzSdDev02vKbek+Pke51MDV7hsRxaWm/AYh5Zp0DwIaPJvF/ZwRrYG3aATDXywrKpf1pJJITao/XO7Zcw5wJvk9MAYPi5vr5onj4zHWxP5PUt/aTCzWPdE7lg7pooQqNGg7TxGna/ypcqiojRSy6D0DGB5T/KvoyWS/oYEpUBRRb5s9lKUxgSA+2JPDwAzx/tniM7jx+sfGbZKpVppWDu+SLe/l22IcISUXV75rt5gc7/1sOho/FJXSbcyi7z3B+OR0GY7AB3x6J7XsS2aHBO1Qk3Xn+xKoPPkBduLNr6sqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dea8b9-cdac-4621-d0d3-08de1ee98656
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:06.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aSP9+MEbBcW2JhIMKBCxry1OlJ1JF0TJdG339W5aQ7Wc1zxUsbe4pezfQTa2y8O+xrCiTS+Kq9T3EQrWUmgUrrkgm5dn3SeRchbceZ32tE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEzNCBTYWx0ZWRfXzWAu4vtIcmo4
 DNDGSVFug5aPDCUvYj5BIhUW8mUnRS8SxmXYvzh+rksLD1zq6gKA8lS4yOKNNgnBSwyk3hGdTbD
 weHRrXMW0242VgZYH9xMfjOiCEG6ZIfvl349RzUihGpii/a5q3+/iU5GYJvbPQfAeqWosw/6u5h
 NQ6Q6lMiPXzPVcB+MnJsK1hp3dSEttO1jT2zY555OzxItjOFRe/qfQn4KvYs3SK1xGQO62F2MyS
 mxT6qZC3cvsFOKq900xZ9156gv1Yg7r0GQdJojFVAK6Zqf+tdO0RBUhtaC0QU8U7a7NKH7o+0+2
 RMMg6MSvHYZsOvlBTVI5b6F3oYSJ34gAc4LqxiMUXv67OiKNQaDxLH3vYaD7h8kyrKXt4Ex8Tgl
 Mq0QhfJuv+e4Vviha26wspk7ztqZgOsi51ie8n4NGNjSTnpkn9Y=
X-Proofpoint-ORIG-GUID: kcEz9JlNB0PjmYUBq7hINNmC-rD41CHZ
X-Authority-Analysis: v=2.4 cv=U4ufzOru c=1 sm=1 tr=0 ts=690f7939 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=r4PJAH3pRi85-HfG15IA:9 cc=ntf awl=host:13629
X-Proofpoint-GUID: kcEz9JlNB0PjmYUBq7hINNmC-rD41CHZ

Separate out THP logic so we can drop an indentation level and reduce the
amount of noise in this function.

We add pagemap_pmd_range_thp() for this purpose.

While we're here, convert the VM_BUG_ON() to a VM_WARN_ON_ONCE() at the
same time.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c | 146 ++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 69 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ddbf177ecc45..5ca18bd3b2d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1984,90 +1984,98 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	return make_pme(frame, flags);
 }
 
-static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
-			     struct mm_walk *walk)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
+		unsigned long end, struct vm_area_struct *vma,
+		struct pagemapread *pm)
 {
-	struct vm_area_struct *vma = walk->vma;
-	struct pagemapread *pm = walk->private;
-	spinlock_t *ptl;
-	pte_t *pte, *orig_pte;
+	unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
+	u64 flags = 0, frame = 0;
+	pmd_t pmd = *pmdp;
+	struct page *page = NULL;
+	struct folio *folio = NULL;
 	int err = 0;
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-	ptl = pmd_trans_huge_lock(pmdp, vma);
-	if (ptl) {
-		unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
-		u64 flags = 0, frame = 0;
-		pmd_t pmd = *pmdp;
-		struct page *page = NULL;
-		struct folio *folio = NULL;
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		flags |= PM_SOFT_DIRTY;
 
-		if (vma->vm_flags & VM_SOFTDIRTY)
-			flags |= PM_SOFT_DIRTY;
+	if (pmd_present(pmd)) {
+		page = pmd_page(pmd);
 
-		if (pmd_present(pmd)) {
-			page = pmd_page(pmd);
+		flags |= PM_PRESENT;
+		if (pmd_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		if (pm->show_pfn)
+			frame = pmd_pfn(pmd) + idx;
+	} else if (thp_migration_supported() && is_swap_pmd(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		unsigned long offset;
 
-			flags |= PM_PRESENT;
-			if (pmd_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			if (pm->show_pfn)
-				frame = pmd_pfn(pmd) + idx;
-		}
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-		else if (is_swap_pmd(pmd)) {
-			swp_entry_t entry = pmd_to_swp_entry(pmd);
-			unsigned long offset;
-
-			if (pm->show_pfn) {
-				if (is_pfn_swap_entry(entry))
-					offset = swp_offset_pfn(entry) + idx;
-				else
-					offset = swp_offset(entry) + idx;
-				frame = swp_type(entry) |
-					(offset << MAX_SWAPFILES_SHIFT);
-			}
-			flags |= PM_SWAP;
-			if (pmd_swp_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_swp_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			VM_BUG_ON(!is_pmd_migration_entry(pmd));
-			page = pfn_swap_entry_to_page(entry);
+		if (pm->show_pfn) {
+			if (is_pfn_swap_entry(entry))
+				offset = swp_offset_pfn(entry) + idx;
+			else
+				offset = swp_offset(entry) + idx;
+			frame = swp_type(entry) |
+				(offset << MAX_SWAPFILES_SHIFT);
 		}
-#endif
+		flags |= PM_SWAP;
+		if (pmd_swp_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_swp_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		VM_WARN_ON_ONCE(!is_pmd_migration_entry(pmd));
+		page = pfn_swap_entry_to_page(entry);
+	}
 
-		if (page) {
-			folio = page_folio(page);
-			if (!folio_test_anon(folio))
-				flags |= PM_FILE;
-		}
+	if (page) {
+		folio = page_folio(page);
+		if (!folio_test_anon(folio))
+			flags |= PM_FILE;
+	}
 
-		for (; addr != end; addr += PAGE_SIZE, idx++) {
-			u64 cur_flags = flags;
-			pagemap_entry_t pme;
+	for (; addr != end; addr += PAGE_SIZE, idx++) {
+		u64 cur_flags = flags;
+		pagemap_entry_t pme;
 
-			if (folio && (flags & PM_PRESENT) &&
-			    __folio_page_mapped_exclusively(folio, page))
-				cur_flags |= PM_MMAP_EXCLUSIVE;
+		if (folio && (flags & PM_PRESENT) &&
+		    __folio_page_mapped_exclusively(folio, page))
+			cur_flags |= PM_MMAP_EXCLUSIVE;
 
-			pme = make_pme(frame, cur_flags);
-			err = add_to_pagemap(&pme, pm);
-			if (err)
-				break;
-			if (pm->show_pfn) {
-				if (flags & PM_PRESENT)
-					frame++;
-				else if (flags & PM_SWAP)
-					frame += (1 << MAX_SWAPFILES_SHIFT);
-			}
+		pme = make_pme(frame, cur_flags);
+		err = add_to_pagemap(&pme, pm);
+		if (err)
+			break;
+		if (pm->show_pfn) {
+			if (flags & PM_PRESENT)
+				frame++;
+			else if (flags & PM_SWAP)
+				frame += (1 << MAX_SWAPFILES_SHIFT);
 		}
+	}
+	return err;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemapread *pm = walk->private;
+	spinlock_t *ptl;
+	pte_t *pte, *orig_pte;
+	int err = 0;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmdp, vma);
+	if (ptl) {
+		err = pagemap_pmd_range_thp(pmdp, addr, end, vma, pm);
 		spin_unlock(ptl);
 		return err;
 	}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif
 
 	/*
 	 * We can assume that @vma always points to a valid one and @end never
-- 
2.51.0



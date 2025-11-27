Return-Path: <linux-fsdevel+bounces-70075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ACAC8FDCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497AD3AB6C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA802FC871;
	Thu, 27 Nov 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljVvO29N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UH50NBeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FD2FB616;
	Thu, 27 Nov 2025 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266689; cv=fail; b=bsJpxIC+boEC+rWqhreRYQw5XCXZBSgVHqep3DrAWt6VAH7kzdYQwsx1smefb2Qk3pHsBw1YirnOltgJ4ZZGE7hvAOjM8hK/UCM4aqMPEQdJy3AXunSCsINs4LDy7kbbvxHDiNyTxJA+2qRqQLSQBHr9gSI8qt5beEbGnZzmGvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266689; c=relaxed/simple;
	bh=/jIkfo+gl5ZuTiKZOO6ayZ7WDiAP7DkhSSNdbE8q4aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hlHRh9SobfWS1IKlhEVGdOSe3zRJXJooq9lxIfIhMZ1I5abhoW5kPAe/JcoCajy+47of6Ed1yQyk29rjeP3+6E6sPi0IU0j3TZBfDRYFoeZdZQ2wcMG/x983QQ515fiiWj6Um4bU+/S8s4tBl3fczWvTnoRwwzKofUq/vd6kUic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ljVvO29N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UH50NBeb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR9kUQ0723128;
	Thu, 27 Nov 2025 18:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/jIkfo+gl5ZuTiKZOO
	6ayZ7WDiAP7DkhSSNdbE8q4aI=; b=ljVvO29NwCn+ENtUtkwif68ebIVZg21gkz
	rvcWndjufTRMsJXe2pWB95UtwJJ9PC5cKoZVIC+3+YYOJ5mUAylKlcF/emAG4dCX
	vM+3zr1cXOoclqTuMKwjNRbBPckTzONehV42ZrntHZwKO6We+w9OMj7RFV0cyUp4
	K2khpBbwZJ+YQlIljwtMP8BJwzxneWn0vm/qOUn85E3yN7VQEgKZCkC+aAcQBn7C
	wZUDR/fJEeqPAiu1xlBrEl1TLIemCWDB04BN4BbReN5TuV6L8vJMepB8cgITs+4O
	wJ/LPmF2PiYuB0fWGd5Jxvl/+amXDBp6MUgjpQjw6yxKnkK5hTIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4apmab0p9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 18:03:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARGDvVf032074;
	Thu, 27 Nov 2025 18:03:46 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mchefe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 18:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKXSgOO20KPXv+dsemSkJF79Wy8TJtbxALUyHWD3uK7oQCg6JO1BZ9mmgAI+0jWHtgTtcVr2AKI2EraJHRqtHLQ1MnYx8Qb52hUkqkgXyt1CEHA767ku+Uqw+JnsrUzk01FIrQ5W/jwFkqOVQ0gWqXeNQnsBlywzRSMWwyNiNLA0sAHkEfFG4qOs1a8mY//yHkfh8LyOCCTqbt9pEoq2zUoF7KbLQmP+mcb7CKszajtMeH0SB0Q/29zsDzub2pXYJ/T7691MmzZ/YVRA3LpzwHCdcAZLMPfBX7z470AM5bbxcZr0RifHGtV0CWMvTnTy9Qsw70sIl7OyvhrMyTnabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jIkfo+gl5ZuTiKZOO6ayZ7WDiAP7DkhSSNdbE8q4aI=;
 b=DKmL6iwlTz9c1l9Y34UdMlycA7zMzoqAeWmwb1szXX/fGIyZspGmm2KDKIYv37j0EL7754nX/lXKkmlwWul2uWH1vMNXay/KjvnndWvgeWbagTxX/Kr59VJ14ci5s7DJuwuabplfnt1CSCera2fv61vdb2gX2ArDDXayHgYrc3X7H3aDWj8YdfQWUvf77ATErdD+zEnYtCI7eyU6Qy16su+tHr6LeEGgWo+r9FCX7c2x2cleCyiM1TdlpdVgRV6urgLroULI9pqToSSgO5gqOvM6NvGSVWO1adqyU6wwC5RFNvtlhjFE7tJ2053B5JYORaXMyAs1WE2h8bC/DQsqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jIkfo+gl5ZuTiKZOO6ayZ7WDiAP7DkhSSNdbE8q4aI=;
 b=UH50NBebjnGDsDKPNPL/6hEqjdfqv6CyxSZIT474UPYcjetnEEjNXuRT15xr8yTuCaGV3fulW0SdbGlz/cCSrosFlhlnbsWU1an0g1wBbkliNQHlgiwIKRSENUquow66dSqUZotSOjMhjxrGrKV4T0aIDcCLRdtTL+Mbndx0dtM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4156.namprd10.prod.outlook.com (2603:10b6:5:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 18:03:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 18:03:41 +0000
Date: Thu, 27 Nov 2025 18:03:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v3 16/16] mm: replace remaining pte_to_swp_entry() with
 softleaf_from_pte()
Message-ID: <8b792a0b-f239-4bed-ac20-b9f13d0536ff@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <d8ee5ccefe4c42d7c4fe1a2e46f285ac40421cd3.1762812360.git.lorenzo.stoakes@oracle.com>
 <f2385065-cdd4-4e87-872a-b5e83014e590@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2385065-cdd4-4e87-872a-b5e83014e590@suse.cz>
X-ClientProxiedBy: LO4P265CA0255.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba46ec9-a1e9-4f63-1ea2-08de2ddf4c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MhCSvhf//NcZcz0Xxi3zIipNwG9Cj6d9c9/IuDAN4u6kFtgIJnDgGpuhErjh?=
 =?us-ascii?Q?wSdmQ5Fvbl5H9oyzOtPMXpt5m1ruFM5S3YXQjasl/4O52dYSJiui5LjwsD76?=
 =?us-ascii?Q?0L5nzdlQJLbkvvpu0gAl5k0SLAnuHS3vdqJ4DiC//jgflBdSTz0GzRWaJ5cY?=
 =?us-ascii?Q?Ahle0ACju2irFsZZ2ulpy9KpnleUrUBm9SLuFB7j4Ke27sMUhARTELBARcNg?=
 =?us-ascii?Q?w8EJpeMPTXvbzPNa0dXepjz+yJuQY7Hzheu/Eds3WikglwPkVRwAUbgYnyvY?=
 =?us-ascii?Q?CC0w1fYhek3IB2i7j24UFbKM+/IhneYNKnNvjXRZA4CPBDCzZr4ZNo8OcLzl?=
 =?us-ascii?Q?iTok/LRjUooUG79LGwwo0JVSuKinzJi/RBAHFOfDhz/3sWXbMSDsmdIXxhRv?=
 =?us-ascii?Q?NcftAeZRCKy8/a4k6vZk3YSBaxsd2Ta65A/pHH541shFfibcs8Aqg06/Uv9I?=
 =?us-ascii?Q?3tXiYnYoDhT/cye2BOOK8c8K7vfmLjgVSHRYDSpln5KlZx3452u3UqPdgCN0?=
 =?us-ascii?Q?IPI/eHCtoHrCox/4rvfAGUA6ykbHKts9UgWcPzYBgO5kEi85CDMmHR1bwH8s?=
 =?us-ascii?Q?BugS7Yrro59drH6tYJopTrUpTC++GtXLTRghk9bHqluYZCAIHa9ayAvIXO3j?=
 =?us-ascii?Q?ZYTxDW9YrWx0JAlcsWbIjxhvN9o5owWi5/hWGe1FpgFEi+7728mSCbOU66Uj?=
 =?us-ascii?Q?+aLmii0YNij+BKuyCZc0ysIOu6eKihEJeLOGHdW3yNyFNKeLh7tDRF5K9e/E?=
 =?us-ascii?Q?T8/EpCzLmemOIwgpcQi/6mkKZM0s+zE7wS+uRTm42Lu9aKGu+focEPiUPhy9?=
 =?us-ascii?Q?rqQYo5NXCSl9UlDDkcOu75c046oQeVi3b6TZd5mCZHndDPdKGLgxn0qJLVFY?=
 =?us-ascii?Q?yiyVtrD+W+443ec3cF7PKudP5T8Q5nLGSwqrX2404joyW1snPYyUjNmc7lwO?=
 =?us-ascii?Q?ONzUdEMDKQjZ57nkYnXeWsS+RBWFsQyZgX9r64CIQsbbzWHL9a/zG33OLZ38?=
 =?us-ascii?Q?07Ya/aZNHTr5WWdWV51k8cIthwL4zHnv7NUiFhj5eT46zPTUZCsNtsNvSaOF?=
 =?us-ascii?Q?gKIsRG8n4GDPf8XN2osmeevIEDBEal01jGnF/TiZSbYpc8ZVucFtGt6SgL5C?=
 =?us-ascii?Q?xcHR5Kk/zMSzcQEMaZ40wKEsC+WOEnPymzaWSKm96u7wAOXcuN7HeQnOV6F3?=
 =?us-ascii?Q?xRh4cmP7iN3W45djbTqvaA32EfvwSgIcLsCpdP7DaAw6Aayc8RJguL/+0U6e?=
 =?us-ascii?Q?ZXlrrN4hT3pqevp1nqnDQE8EDVijOUk5+Acgubywd5gTm2e83N6x0Uzgf+vD?=
 =?us-ascii?Q?z/cjNRO0VkzCdqsot2xBCedBpVJghkOb8oEtyxYruSuOcvoMBcmTjeFT/JeZ?=
 =?us-ascii?Q?McYrf3YTerrncZ3GeZxD2bWvm/F/Pb9w+BRWyDj2pdCK3+nKgehcg8NJQQjb?=
 =?us-ascii?Q?VIbSmqbnKFAOdXbbgLkZ+8fHq8aYJL85?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHu2sV/Zd6xXYjl2wtLcoqOyqfSYxyEcA0lei3Hw1nGBl0cXrw0W7zMsNpw4?=
 =?us-ascii?Q?kR0XjteXucradVV09GFNTRAmrZMTaWxuoLEMe5XKxBDrdryqwqyVWi48iuEd?=
 =?us-ascii?Q?F1ZpYXObtBFnC4lcxJtdkz9XZ+WXDR4Fh5WOgmIgze2QtAGef57XtgfmXm97?=
 =?us-ascii?Q?CCa5WytcbyY4uY+jes2TI63JnfrKVpm56PaSyySDE32Ph1XLqk1y8xHmBvNz?=
 =?us-ascii?Q?vNgN4lnh1OZTi5cYjEcNE6cKfFKD3Dj6gqVX8H1QTW3+jNM0cEl9MvZZReg/?=
 =?us-ascii?Q?rkt9+P4KkrNySeHlAa+PvkpFJaYumYcCSzoNV0Yq5Xgb3QWA9PebLVF+Wo1y?=
 =?us-ascii?Q?LdpqjUFSlCr0ZN+NtHwKB5/kexS/JrC6qhx+E+uRa8QOIkC7K8arMLDgnYui?=
 =?us-ascii?Q?APg+Tnab4mHue1bGXIhN3dKa+ds7TwmCjielb89izhKgp7LSDnX7ymyEqYOs?=
 =?us-ascii?Q?e9A10jUFP/QiH2eKMy92R+pUIHntwCME7e8zUCgzRBDMs+C1nsghlTsJX8Y6?=
 =?us-ascii?Q?7PnkcObIy+P2YazDgd4435XKPqAeNU9gfzWuY4IDlWa/BuudWaQou5Ty9aJQ?=
 =?us-ascii?Q?X5/NfPSYLtpf1UjNetvVOCJKuvayyksO9+mQIYsZiCphluu4Nsy/o3BRDN4g?=
 =?us-ascii?Q?y/doyZcA+VQL1pp5wtTiCRvMdm8UWG/qpm55dbIBQjfqTVw9JYPSuHdMnSuS?=
 =?us-ascii?Q?ihiNjs8dSQFj42/p7jiD5HbTo8Uytix3RDI25q4p4e5L8n+e7XuhAZJJIYce?=
 =?us-ascii?Q?g8wi94UDtseL2LTkG4/np1Jiu6UOArm5dats/tf8Aj2bYO7yX3JStLhOgXSv?=
 =?us-ascii?Q?2W1Al+DJMXFmlRM4H3xts2/utkhb4ioOD8lkY51S2h/Z2UQfJU37ckDVtWe1?=
 =?us-ascii?Q?GujRhMlcZPWnxZDc92RtvLTjjicL0+Tr+n0QlWJXvGLUzdvnF8quxbA59KDG?=
 =?us-ascii?Q?XKXDuiNTvDpMOHThV6db8xHa5X4du18A1wZzYBmYhsIpp4pkSWHwT7x8yIaU?=
 =?us-ascii?Q?KFgntr3943Atu9z1Hjd7OS0GcwC5ESHqkMe+2sotGDkwAJxw3NdcpWIFVvI7?=
 =?us-ascii?Q?Q3owFLMRwjUpJk4gVNiQwphoA7e1Q7nWaYbZ7w8Kkcl0Gii+OrOj3+8VpE1n?=
 =?us-ascii?Q?DcaZl+KQx2jf3qhsWFymT0ngtxRk5SgWbs33lXxy+jgbsq80Y+nruDS2GCFX?=
 =?us-ascii?Q?DEON2rNPA+dLrxvIz1+EFYLMKX3TtY6IPGVbBPTLelKb76wJN2qEihxs8X96?=
 =?us-ascii?Q?8C1h4vu+XMj3X7CVR7UljnUoW1GKD444TODQ+jitgHLJ9AqYkugRKPFjZSJ+?=
 =?us-ascii?Q?TGHm7h6mVnUDeV0DWOCkg+Oya1UR84uatUuaCjpyYR4ijJ/bOj4khy+gYRl+?=
 =?us-ascii?Q?UexsyOxLScBqWVzIvzZcm8avFSbwv2UoVIQIZOKo43JsQiJ9kkqZLDdvIwIQ?=
 =?us-ascii?Q?1W8gNmRR/7dT8BWcXeA+9gq6fmni0utQWa/iPRlMyit9I7C0HQsEVmfHmufk?=
 =?us-ascii?Q?83tj0hhVetN7QoyP0vQI/a2HuGWk4tYAbaERy5bT1x8vC+p/l90gGCn7gVY5?=
 =?us-ascii?Q?7hUe1CrLXegg1Behsq65hrtKZF+4N8Pmue4YOcKX3djwTkgI8/obLRJbNWuY?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/ctEKdoEDaP8oiaaPWIzkwKrvzQv3/AOze0O6FbkXsJ+iywWicb9eSmZ4hgP81cGZ44p9kwk7haOd2RiLNKVxflfnuBo0Hi2FJhXG9RWgm5Y0m31UKSXBxPcI8qZijh2uN4nq+l7CQlYlqfrQMlqHJUTf6CoHIrZYvkJUnjGjrVAPKXFh12N4vWmD6+dzRGY+Thdn++Yva61boe/huRF0N+4ZE2tZgfzei2yGQ+NNSLRwZ8jdSlwjjV2wCaUtH6zfjsIJNqalc4sLu8nPeYgGnv5sslDQnjpKYhqfkQvJMTg+CdEM542FzTTWeNMnBmPyQ4ErlCqbViuLZzoVUqE0QYOSFFodO9g37vrMUNNuU+RX0wFiCQi/ANRP3OZJ3ESCQHKOQXPRygozqpOT58VyPz9bhHT4Zm5+gI/fbIs9KtKYXji4bO/DxPb0LTKw80MPa17osqiuXuO1QoaRHgJN5uZBI7z1fvhsu7LtKlT8bq/pv7jvKvS8bRwt+E/FyVqGbYYtu1spIYHVcfPB8K54CLkCnv6s075jkQuVDD79yQqyzET0w7xd3IHFQGpXu7VZrTOjBf5h0dN55vd82CiJpQ2cK4Ym3R4/p7jLoWuJTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba46ec9-a1e9-4f63-1ea2-08de2ddf4c78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 18:03:41.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOjga/1LzGhUUFaP2mFVEltqg+1hQUgH6/a913FZFNGyGvk6Wva7vePzqixh4YN/e9ZYalaf+4jLtfZZ1apRjDNzs829gYxr1z0Ln3GHB98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511270135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEzNSBTYWx0ZWRfX04BWE6LACQ3m
 MfOm/XjcoHKHI5FjrxvaDtNxq55DqVFkXzAT241tykERyRtJMAKpmMpApAck9oTO1fHpE7lIrG1
 LKDN00VSiCTxcs4Fzon/aByikp57iY9M7LGm8aLQlWoXLqwUyvJI76WvBQVBSYhsmvPhRRKyym9
 LwS4UKe0tTHm3qKFx7OFePEAKMrX3gRMm7dO2YbMBMVmEfmnUgPTvwjSpNyEZVuE2fq7/5WEXy1
 BOO2C/BD5ILzNkCkzNkVIDCzQk4Ji/imGowxr6bIsx6hgwNVEJLaVvVV07c3tP+o78h4whwgukT
 SpQ5ZBYe0yhkazfqVszAuT4pzOSLh5368zDCisngcqLruPNStyTOsRG+DXftanBqOQG4x2UwvDI
 YpIhBFcl+SEaa5zb1twg+1uRoK3ryA==
X-Proofpoint-GUID: id4dq4gXQ8USjpjzsajAr7oKCQnacu6e
X-Proofpoint-ORIG-GUID: id4dq4gXQ8USjpjzsajAr7oKCQnacu6e
X-Authority-Analysis: v=2.4 cv=GdkaXAXL c=1 sm=1 tr=0 ts=69289282 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=NQ4B-BMZADxRMPI1bmMA:9 a=CjuIK1q_8ugA:10

On Thu, Nov 27, 2025 at 06:53:21PM +0100, Vlastimil Babka wrote:
> On 11/10/25 23:21, Lorenzo Stoakes wrote:
> > There are straggler invocations of pte_to_swp_entry() lying around, replace
> > all of these with the software leaf entry equivalent - softleaf_from_pte().
> >
> > With those removed, eliminate pte_to_swp_entry() altogether.
>
> RIP.
>
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks for the review!

> Impressive work, I hope it can be promoted to mm-stable now. It would be a

Thanks.

It's already in mm-stable?

> pain not to have it merged in the 6.19 merge window. Still plenty of time to

I have no idea why it wouldn't be?

> fix up any hypothetical bugs not found until now during the rc's - overall
> it looks solid.

Right yeah. It's been sat in -next for ages. The bug you found (thanks!) must be
pretty hard to hit... even by syzbot!

Maybe there are others, this touches a lot, but obviously that's what rc's are
for. I think you can say the same about literally any other series currently in
mm-stable :)

Please can we in no way delay this. This work is very important in my view and I
intend to base further work upon it in the upcoming cycle.

>
> Thanks!
> Vlastimil

Cheers, Lorenzo


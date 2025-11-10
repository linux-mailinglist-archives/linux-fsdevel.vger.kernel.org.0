Return-Path: <linux-fsdevel+bounces-67685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EFFC46C2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D96D1347D70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D1DF759;
	Mon, 10 Nov 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S9W3yQkO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mq3mpTSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E91AF4D5;
	Mon, 10 Nov 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779905; cv=fail; b=BDcBZEgg3a+FqXThQCybn4HumrsibmWt2n/spq9g8DhFQaTVAmMUZx0PODmptDoVkpOFeQjWstl5MA4s/V27loFSJvc8akILpd/EpFgFdByKkw6KIkDOuU5oIU8oJHH2NzGnFx6O8NcI85Ea2zhx3qIbM6OSkZXT3O/sNS0NuqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779905; c=relaxed/simple;
	bh=xPFq9EMDGyFV+We9z4ewynjcWcHi5fVFIW5Do9EF7eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEYfltqKEs+rxcsvTQdTtk413thAi1gOqc/bygVZJqGzRhD/IEQIxzXsqKjLQ6UNHixceE630GJohESvzxF9+h9cywvJBg9f1K1KjFwcsLmIkIU9ZxpQp3f15f4VWPax//w0aQZBBJ6GatllIiMjAzTq+cXA9egB1HnwdDrLdI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S9W3yQkO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mq3mpTSm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD0dVD021115;
	Mon, 10 Nov 2025 13:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bb2iQtD8LpjYPFW9pR
	CvcxO9GJUATPJYF2sm9c8HY88=; b=S9W3yQkOYAgkiHurVMT4U44SHLUb3v7Zx8
	83wXmG5IZk7WJ+UIWNRZ7W+skgWY7YdNzLqACdZhC2kcgTdDGqTumRVnE53bCeT+
	oGxGSGsq1wfWXDJjVlGOHO4XTHbhVl8S4TJdgbSsfFzFLj+2EZnPgj2LrabU5hmK
	J84NSAE2ngFDA1z/z/GJd3X7qcFNCVxg6zcO/uSHjkwHvEh/5LRvNhuv3tF8FG6g
	z+1dbDvRSriV2pQUN6zyDM7Ag/4JPYXGsaCI/vt3FyQlVhlUAy1vIAteAFFo1SQo
	/BLTbu4RqlA5ZVzxmCMkSUZ5g0eOMj8e4RskFD2nhJhIgFeBiquQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abgj30023-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 13:01:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AACFg9C007564;
	Mon, 10 Nov 2025 13:01:45 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8mvht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 13:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdXDqAtbmI4GVTUOzSBMqaKDOI7jnqpXXIhBSmrIRjkVVRdFvesDxwVoIbFCouuNSyy/arXWfD264qNR1ljfh6AD08YzRSpXXQFiiHdbOyCtNTmQpo3Rjy5WYSp2yUc4yjEXpjs7UIopplqXnKrB8uzPd8w1mrMwX9VgNRk/94RX2qM+rKPQRIrBd4I+jrqX3fQSclstY4Zp+gAkMn9qZu4jMyTBY92LEG9ff7+ZuCIQvkcDumEi7TBa+GYGY9XKZPQr2Ao8bi8LnkejthVxWyMTPMSXngHy9YtgmxJ6aZU2rwEdOuXhd7lulf9r4oEliviZeX735LPqMcO7A6Oq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb2iQtD8LpjYPFW9pRCvcxO9GJUATPJYF2sm9c8HY88=;
 b=v844FufjUliLWV0eoN4Z4R6XIlnTD9iw+FWu9+2Avd+jwceE8GNRJq+zgl5jK5cd7xfpYIby0LRO5aGnjB72nDNJoBuBiY9s3fzvkZj1ol9zzVN6/LBzmhUdp8/D7nK9pKJAoNjgfyzoR+CmhKOnEMMhcE1R4ShPBFv/6n5TjLiD5Ia0LQzsVUi6vHDgwHgVzMM7a35f3TuL6AokGSSqcCJuZ5JUlV70omPYa91D8DZ319yCTq8uppJfAbcF0p90Fa0MmBAeRgaH3yUudrpRpkAIHEyditjGUzrKgUqA0avfaju8WafnTnhxBunnyaIwh2TPv348WSb+wInddVveQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb2iQtD8LpjYPFW9pRCvcxO9GJUATPJYF2sm9c8HY88=;
 b=mq3mpTSm4cSrh5A3O1vpCLmHBHSgXhUSb0ug8OAOLalSBN5JU08uI2J27kEi8XBjABxJyMukNpWVt+AuDY+1a0tDNeaS1ktyFXlfvUo0TjOKPDFwMAMsmQxqdFfYTkDYuwq+FKfSG0LKwRA2eND8ph2GMmBiN6MQPb7J3EdEEqM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8398.namprd10.prod.outlook.com (2603:10b6:208:56d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 13:01:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 13:01:38 +0000
Date: Mon, 10 Nov 2025 13:01:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
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
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
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
Subject: Re: [PATCH v2 01/16] mm: correctly handle UFFD PTE markers
Message-ID: <1a77db9b-ddb2-42bc-8e8f-f4794a5bfc6d@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <0b50fd4b1d3241d0965e6b969fb49bcc14704d9b.1762621568.git.lorenzo.stoakes@oracle.com>
 <aRHJ0RDu9fJGEBF8@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHJ0RDu9fJGEBF8@kernel.org>
X-ClientProxiedBy: LO4P123CA0423.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b15a444-2e73-45a4-6152-08de2059490e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ChA6ZFoscs3eh45uYzgNHrEhlFCTgPcXiFhOL+jNFGV6mtCVZ66IQ8pmKnCz?=
 =?us-ascii?Q?25eLQh6T3Y6EdAxAZMNVPBiWZhuVWpAGoW4EoEOdzhVJ1zqFJtXeze2M5KVn?=
 =?us-ascii?Q?dfwPVQ/D99Kk0pDntnPNeaeoYMQMPsQoNK5SyqLsZt9HJcLcXkrfCSGTIylk?=
 =?us-ascii?Q?refW/u3Ra8m8+shxSTa/rwqoYGmsanGwI7N8ti2E0RxBXIrnmk5nqWcFQzaZ?=
 =?us-ascii?Q?ijfj7bktgL5MiSAtUBpMQU3c+4yOhoocCgq2/jurU79CJTrE4MTug2YugPaN?=
 =?us-ascii?Q?K7Nzj2+eCHLAVwfdVb/7YSO6QcbFOcPhDvX0uCWMIsb+cV0SGY+azArNjQgL?=
 =?us-ascii?Q?BVqcGXa2e6oVrZK/+MskDky43VjC+R1wwzN2jTGS5WwT2xUP3AJfm+j53oNb?=
 =?us-ascii?Q?v2C5tlpEz+WcUuOCZs/fM+S4oVoXuGKpPs2qIgy7Kqwtj6pvVtshLlYsQnlY?=
 =?us-ascii?Q?SBPZqaafxbIewKwqJJza189UEmvh4vYGbVvCHdoKsjzWGm3kQlyLJMMvevDh?=
 =?us-ascii?Q?m4CBgmAQRhcclowSqVz2bhX7r4vpRfbIh06gydvZ6+bOrxA+hf/ShcYYrx9X?=
 =?us-ascii?Q?g3W4uy0MbS8V9FAOucicnISvzCiv3R7gq5dBeIufxuWnZzgqpumvFKPnv08H?=
 =?us-ascii?Q?SgWnftSTMGhBd2tglmr9u1erKEbLWaesdwpxcaArL7Xh3kdJvVDNABPScTJp?=
 =?us-ascii?Q?wjK12TIf7V9TePg/6vED1/TksNd+PDHluxRQiSXcfsehG10kb2nQ8cDL3FYK?=
 =?us-ascii?Q?jy3r62O7zqcCixGtChlRzsADlv53UHe/21upQjZASyTU+ZBbWnaMSV0rWxRV?=
 =?us-ascii?Q?Kc6cs15S6wETKUibmKli1fPoYqRE3T5aMMPbv4HgIN9/P1V2hFe/qGtCeHF9?=
 =?us-ascii?Q?q+/A2yOHvI683IEUpLFQBU4SBh/DWf6XEke2vCSpMsNzYGjkCeYcbPBrqVlY?=
 =?us-ascii?Q?mqJhJRh/ffrBmx4zBt5D0uEo/hJqP0JlNbLlq5CxjnR3f38Ip69Qf9pu2Cc8?=
 =?us-ascii?Q?30lyw4XbhsqcW7wA1c15wRDRaP30zoI70ljz6ogPzJ/Y1twI/HwcViJiBDLy?=
 =?us-ascii?Q?2JuxIBgqBLgbhrUTSvGX6Uez25kY12HE3ubO80YKJWdNr89MUUFuZ2n+8s9U?=
 =?us-ascii?Q?XxQe5+IT7zOWA/fgH63JayRU0FILTTTR2ajou2kss0MtcZsNT3vJUVC2Q0E7?=
 =?us-ascii?Q?o2dGybXXARiJnuk8bVnMq5+/A+EYVXVvuHrPHbC2oJWBbvQLBd0MwMCHNJmz?=
 =?us-ascii?Q?JY/UDi9wzKLndZtBxFttGFWrdcUQ5EV2VbACvNRELjWIV+gcQ1tZkZRgiz7D?=
 =?us-ascii?Q?GrwTWZiTm1/msBGvAw8p2+e9KI92c83+Ubib5LQ1QN7uDF/jLUjgUUtJ7ye2?=
 =?us-ascii?Q?1DeJQ+XyEeNVuqH9YpgSZHGbQlEMVIEznovvXDqBR9UHaLj3yoD3rqB0YpYC?=
 =?us-ascii?Q?wJCQCrXU0LYSvdSzsYlpZolgaU7ZEghs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gATNXeMPbfL1FuYZJgyoe8CBym8zao9PsHnIjQSlLG70t0A9WK7oiI1noRnk?=
 =?us-ascii?Q?sDOR2EWdluTbJe4Kuwzoye0KLU0j5oYhhUbpBmGon+8XKAV8Rus2jNbHRIyn?=
 =?us-ascii?Q?/6H8Hp85ViZfh9oTyqe9mHL3V2RGcT4d/XLstCfVDbJNPPskVReJJ7XkQ5hK?=
 =?us-ascii?Q?moqeO+p46dODG1fxBFXdiITa2T0Je4QjphAQqa+DvFGT1R4//ouZi57OerSm?=
 =?us-ascii?Q?PySNvLclFkna8FD/BnxLItp0oPaKsakC13gcFGZkgdvZtNTkbfX8hBR8C9Zj?=
 =?us-ascii?Q?K9x60UEE3TNc96uxnW/MuupU89aUyv5J7x05ETjz6ApVoZMLBpG4SmPwz/4G?=
 =?us-ascii?Q?8z4ccoFdsMUp3LvZxXqXpldzUJUIYStcMNtI1/aVQWWrjzeoZhc6dMMd7kUo?=
 =?us-ascii?Q?AEj5QAmROBf+ZyJ5t0KOCHmsFkssh7odcxkjfh/Q+jEgQvXhDpjLgoQ7y7zj?=
 =?us-ascii?Q?hHkleFCRYuADDDp2Xibvq46jnZ4+W63xLOIS6Ra14RCUWW3ScwutIDxb5TSb?=
 =?us-ascii?Q?FS6RH3D/l0cocjz5edBoX2X1Xp1eY2Tm0CYhLlqQEmhfq7iUakCcWn5VrbuF?=
 =?us-ascii?Q?p7IJ7ozkg0s74RxlFHn4JOUDFkOsH54Y/lm6+Ju5yIF7CUWOAX/jjdsZ1KP+?=
 =?us-ascii?Q?qa5cClNSsRaO3+ESzKIEV3yp96KRjQg9VSmeoq+IQySPMIjAfnABYUoPh/ze?=
 =?us-ascii?Q?4YB86Q7ICVk2JZTmSGJ5424AZCqdg0VJmnz4d1dwirbrHgocsnofaYIEvKhy?=
 =?us-ascii?Q?u82tpp6P4XeIEgx3Bg89mYoMvx8KmVjciVyNmbGYTrHoiRrvhZw9tuy5oVal?=
 =?us-ascii?Q?TrxuiGibnv/yAC53Gs79DOCpsfmZ5NwUPKpDNe5Yu15tmxSH53MXz3Mbrhmj?=
 =?us-ascii?Q?lIxH2G7ZzLYsFO2LSd+EPqQqlRMSrNCiT89zYDLCOnoE6Gdt4icidx7EbTg7?=
 =?us-ascii?Q?7GOiLmaGxfmTidYvA5dbckm7zA/KV1Q+7wv1IfxmZFYv80Yk4NADNEijwKJy?=
 =?us-ascii?Q?BTrNimv7x1fnafH8AMJKh2aWyBxDqyEu+JwPkD3eF8mYcB371J6dt1EH+wkO?=
 =?us-ascii?Q?7ORpT0qLq2QbEaRw1973zXrAPI06Bau3iVv52GL/N/hjZM4H6dcFnOGrtnYl?=
 =?us-ascii?Q?6xckEFHEwMsTSKZuu3UdSlP5N8HrfaJeLvuFNACW2xluc0D1xU+TQyUge/QB?=
 =?us-ascii?Q?svwHe8Za0WanX3Zgj1ZUdmOPsIdbGXgCupGMmIop4r1R4ZWrKvmIw8xvNpV9?=
 =?us-ascii?Q?SyQibP+yvP32taibJWm2eGlL7t9d7NGJAGV2rWPROBF07y9dHuoX1THNE4UZ?=
 =?us-ascii?Q?rs+0W1UP7Nyk3dMXPz+/8xMnbt+4/hP3urfB1rkqvxaSvq9/tO6eXy4EzZkD?=
 =?us-ascii?Q?Wk6qnGNPvjn0JUQ9R4rh9WN5vkzSn8M3GOZJYVjp/08jYHCuICT+lnvv37yi?=
 =?us-ascii?Q?OYSVI6wQOBey0YhjWS8OPfj1AkzQAQ7m6DgkpwwfzECKniBDAGB4w/3wQeL6?=
 =?us-ascii?Q?PPUnkZTE1o7qNKXLxndTTPP4ZCpozvq1FbuSvl2xpZ7fNTA69DUcsuLqpQqO?=
 =?us-ascii?Q?Td7ZYhMPh9rU+YmgvSUxTAMIL4zThDtrmMC5oxxTc8bC1PhGJGdH7NcF2l9A?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kZYbvugGGdca7rS+d8aBE/WgR1wYCEgTiwuGOz/JFVXfSsZax3a5vraRCtkBiRdr+D7ZkmamwjtqoQXJk88PKdRWD0abNfbSBwHLaha9UUhNep6C+YgHAfpClOv6Qt36Ap+mFRKBkSU3VWVThpWfWtnc+3hXnqcYLG0oaWUe5+XZtkSSGwvyxMbCa8JKIsGZHBDm5k09+YG+4cEdwL+GHbfZbT8QboT2SkQDWfNcKQFD3irvdFtEW+c7AeYMF17pn7+DzaalJJ5uTHJFDvkfQTYAN7SJvIL4diJxZ7MaeuQ6LncaTHuBklVmUFJ3oqkyl9WlfVERgH8lfoLgm3GL0JAIgJPI35Jaddh7rqe7qTMzx2g5pHNJnvv84Cof7pL/9FCEr+jhlhFtPx/6eUb6+7T2y0jEmy/6Q2DuEsmxJpFXnTxfsrknJb88XpQwQgXhKH1hODCgI5GS3mHH9/fHzlGctw+rEQaOyUYMV3i5i+/HnOQ+MwhmnwPkH4OS7dVEXmI1QVKa8ksCF1wG3oEozfDnH4S2PUQ4QPC9FuQDalKQZQepgWOty72SN5GOZFCtjQFlO0fHEgO+7/KZYQZiCrZ85QJWomsn9Bz3YcykHxI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b15a444-2e73-45a4-6152-08de2059490e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 13:01:38.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UgVfAW4v3POpGRsql5tkk6EVRKHtDfve8qGiZflet29ILjCB2kewUSO4QyAHhgcbLGYT90kPWyKG29KaoXC5s4ZISsLK+zv44cHQNIXAO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100113
X-Proofpoint-ORIG-GUID: SusvxHiI7UdIclRZyepLWIsAH_RDLgXh
X-Authority-Analysis: v=2.4 cv=O6E0fR9W c=1 sm=1 tr=0 ts=6911e23a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Mq8-zH9WwlAeqdUnB90A:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMyBTYWx0ZWRfX0zvOThnPLK/i
 bSl+Y7ZQdHsnZPaMmFRgu0DakZ496kfvRdUyFU0MnLLuDtSG6BH8n4P+IJ5Mudsi7mnmuTImX4A
 iJ9WQexA8H4PjANYxxRYUJNb8OSmzX3kHVuG/fnFF8SLBT8P0U8nc4Ve3z99/4NYxiGQpxorTbc
 OmpCiJWJN/kc75EzLhJa4Uot4x8oAMv6brey+hE0UlXsUJW5FACfdXEY7xEkIjUq7hbko78NxiQ
 bDY27Q2schUrNbseGVtdeQdYhZd1q/YI/JkFilTCFTWCp2bvxtx3skTU+SvEajbtsI2LY7Nm4vC
 e0fg880rprskbRLUa22mkIg394b0ylgf3ij5mE30pPNZpV+Z+CNhrJUxFEcktsNcaEkw2QGwAHV
 nm2D3HmXOnbdszGES8RmXROENYlyqQ==
X-Proofpoint-GUID: SusvxHiI7UdIclRZyepLWIsAH_RDLgXh

On Mon, Nov 10, 2025 at 01:17:37PM +0200, Mike Rapoport wrote:
> On Sat, Nov 08, 2025 at 05:08:15PM +0000, Lorenzo Stoakes wrote:
> > PTE markers were previously only concerned with UFFD-specific logic - that
> > is, PTE entries with the UFFD WP marker set or those marked via
> > UFFDIO_POISON.
> >
> > However since the introduction of guard markers in commit
> >  7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
> >  been the case.
> >
> > Issues have been avoided as guard regions are not permitted in conjunction
> > with UFFD, but it still leaves very confusing logic in place, most notably
> > the misleading and poorly named pte_none_mostly() and
> > huge_pte_none_mostly().
> >
> > This predicate returns true for PTE entries that ought to be treated as
> > none, but only in certain circumstances, and on the assumption we are
> > dealing with H/W poison markers or UFFD WP markers.
> >
> > This patch removes these functions and makes each invocation of these
> > functions instead explicitly check what it needs to check.
> >
> > As part of this effort it introduces is_uffd_pte_marker() to explicitly
> > determine if a marker in fact is used as part of UFFD or not.
> >
> > In the HMM logic we note that the only time we would need to check for a
> > fault is in the case of a UFFD WP marker, otherwise we simply encounter a
> > fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
> > for a guard marker), so only check for the UFFD WP case.
> >
> > While we're here we also refactor code to make it easier to understand.
> >
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  fs/userfaultfd.c              | 83 +++++++++++++++++++----------------
> >  include/asm-generic/hugetlb.h |  8 ----
> >  include/linux/swapops.h       | 18 --------
> >  include/linux/userfaultfd_k.h | 21 +++++++++
> >  mm/hmm.c                      |  2 +-
> >  mm/hugetlb.c                  | 47 ++++++++++----------
> >  mm/mincore.c                  | 17 +++++--
> >  mm/userfaultfd.c              | 27 +++++++-----
> >  8 files changed, 123 insertions(+), 100 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 54c6cc7fe9c6..04c66b5001d5 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -233,40 +233,46 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> >  	pte_t *ptep, pte;
> > -	bool ret = true;
> >
> >  	assert_fault_locked(vmf);
> >
> >  	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
> >  	if (!ptep)
> > -		goto out;
> > +		return true;
> >
> > -	ret = false;
> >  	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
> >
> >  	/*
> >  	 * Lockless access: we're in a wait_event so it's ok if it
> > -	 * changes under us.  PTE markers should be handled the same as none
> > -	 * ptes here.
> > +	 * changes under us.
> >  	 */
> > -	if (huge_pte_none_mostly(pte))
> > -		ret = true;
> > +
> > +	/* If missing entry, wait for handler. */
>
> It's actually #PF handler that waits ;-)

Think I meant uffd userland 'handler' as in handle_userfault(). But this is not
clear obviously.

>
> When userfaultfd_(huge_)must_wait() return true, it means that process that
> caused a fault should wait until userspace resolves the fault and return
> false means that it's ok to retry the #PF.

Yup.

>
> So the comment here should probably read as
>
> 	/* entry is still missing, wait for userspace to resolve the fault */
>

Will update to make clearer thanks.

>
> > +	if (huge_pte_none(pte))
> > +		return true;
> > +	/* UFFD PTE markers require handling. */
> > +	if (is_uffd_pte_marker(pte))
> > +		return true;
> > +	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
> >  	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
> > -		ret = true;
> > -out:
> > -	return ret;
> > +		return true;
> > +
> > +	/* Otherwise, if entry isn't present, let fault handler deal with it. */
>
> Entry is actually present here, e.g because there is a thread that called
> UFFDIO_COPY in parallel with the fault, so no need to stuck the faulting
> process.

Well it might not be? Could be a swap entry, migration entry, etc. unless I'm
missing cases? Point of comment was 'ok if non-present in a way that doesn't
require a userfaultfd userland handler the fault handler will deal'

But anyway agree this isn't clear, probably better to just say 'otherwise no
need for userland uffd handler to do anything here' or similar.

Will update.

>
> > +	return false;
> >  }
> >  #else
> >  static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> >  					      struct vm_fault *vmf,
> >  					      unsigned long reason)
> >  {
> > -	return false;	/* should never get here */
> > +	/* Should never get here. */
> > +	VM_WARN_ON_ONCE(1);
> > +	return false;
> >  }
> >  #endif /* CONFIG_HUGETLB_PAGE */
> >
> >  /*
> > - * Verify the pagetables are still not ok after having reigstered into
> > + * Verify the pagetables are still not ok after having registered into
> >   * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
> >   * userfault that has already been resolved, if userfaultfd_read_iter and
> >   * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
> > @@ -284,53 +290,55 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> >  	pmd_t *pmd, _pmd;
> >  	pte_t *pte;
> >  	pte_t ptent;
> > -	bool ret = true;
> > +	bool ret;
> >
> >  	assert_fault_locked(vmf);
> >
> >  	pgd = pgd_offset(mm, address);
> >  	if (!pgd_present(*pgd))
> > -		goto out;
> > +		return true;
> >  	p4d = p4d_offset(pgd, address);
> >  	if (!p4d_present(*p4d))
> > -		goto out;
> > +		return true;
> >  	pud = pud_offset(p4d, address);
> >  	if (!pud_present(*pud))
> > -		goto out;
> > +		return true;
> >  	pmd = pmd_offset(pud, address);
> >  again:
> >  	_pmd = pmdp_get_lockless(pmd);
> >  	if (pmd_none(_pmd))
> > -		goto out;
> > +		return true;
> >
> > -	ret = false;
> >  	if (!pmd_present(_pmd))
> > -		goto out;
> > +		return false;
>
> This one is actually tricky, maybe it's worth adding a gist of commit log
> from a365ac09d334 ("mm, userfaultfd, THP: avoid waiting when PMD under THP migration")
> as a comment.

OK.

>
> >
> > -	if (pmd_trans_huge(_pmd)) {
> > -		if (!pmd_write(_pmd) && (reason & VM_UFFD_WP))
> > -			ret = true;
> > -		goto out;
> > -	}
> > +	if (pmd_trans_huge(_pmd))
> > +		return !pmd_write(_pmd) && (reason & VM_UFFD_WP);
>
> ...
>
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index a56081d67ad6..43d4a91035ff 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -244,7 +244,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
> >  	uint64_t pfn_req_flags = *hmm_pfn;
> >  	uint64_t new_pfn_flags = 0;
> >
> > -	if (pte_none_mostly(pte)) {
> > +	if (pte_none(pte) || pte_marker_uffd_wp(pte)) {
>
> Would be nice to add the note from the changelog as a comment here.

OK will do.

>
> >  		required_fault =
> >  			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
> >  		if (required_fault)
>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo


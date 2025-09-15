Return-Path: <linux-fsdevel+bounces-61387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239DB57C0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EF63A9E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B6030C62A;
	Mon, 15 Sep 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UHjTZ/zB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lO6Ovs1V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124330C36D;
	Mon, 15 Sep 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940896; cv=fail; b=YlmlbyknkC+9VC9NoO+VPZDoDLPicnRCWtDHfrKAjktgkPk43axDdNbUHDnFTHrxemirkRPEANEZFew03Lq51hUyPk6eRE74LUDZQT4VlyxLBq+ZYhsETcMy3AJCyrnHXuHKZ13c661ry0u8JQsOIxuop87IHRnoGVmFfyTVnTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940896; c=relaxed/simple;
	bh=UD7ws1DhrMS3epoTXfqEimh6I+UrYGgYv0i81Pvc6Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tZIyJiN9BKoiAFzAwtPYXEqD60rK/7xoast+fjMB+V60GwYU3ijNQMWhejdfJ/04x+W2VDlFTUXGcFLK06ymvF29dACgWK+Ysgtp6Psu6XzM9XkpqHiXnERHTCPrGVIYorju9RFJUCTb+L3rlgZN7PIjPXd2ovnyYZISIp7WXcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UHjTZ/zB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lO6Ovs1V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAtxMZ028229;
	Mon, 15 Sep 2025 12:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7zoDu6Wrkf/iopCyjh
	c2aXPOi914cAMgs9C8XEsAN6g=; b=UHjTZ/zBEpwEFigT6AWW4QjlD/68EMT45g
	NBtgbAH78b3uMUz2J8mniB81uHtUu+sTjHqYsiUKDDh8jq39CB7tNuqVmfmnKIJZ
	huOK4EbE1Yk2XT9xB3pd5aTptUJQagF9gI5YwFQRrmZc506GWF3TPD/htZnobRAV
	UxzbC9JmqmYnRzJAvsM9UsllnIniM90jiQJAvvA8MaWpce01GHD3ld2v0cBg9m9Q
	/7ggtPzyASgivQ9q3KW99UR8ERM7Qjg5m/c9KWshVBDuysv6Je1DsTU8iNZaAu3N
	bWVSvLv3Z9r+73NjAR+P3lKyjoYbruELUY3uowricFtywIJQI61Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950gbj9mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 12:54:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCkajv019277;
	Mon, 15 Sep 2025 12:54:11 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b8dje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 12:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHGxak6q8AhrX8fpOG0Z7yxMehqzqyonAKNgavgJNJh+qlZYy1nGS1xWpMJykWthocALOSPYqHvJ57Jyu1c2WnXim7PVIjQWfdLIukgQOOxAGacSwVibQjnEKxBps524X7FzSNS3CZRI5J/VuPAV3SITpCIQ5zANTz7eoudICsySTpAnhJaq6lM4ta+iTR3m29vXGI0L0hC7dm8OIwdLzG8JqN7wAg5VXuPj4wPilCZ3/9E/5sUwPtMX/wrkQGt6vVHGnceKQIkSkrv2qoDRGMHHxrlSMm5+Fw0ad7cWHT3ai6hkeFpaI7HnCtG88dqunWj8VkWif1JDLsoHj6h4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zoDu6Wrkf/iopCyjhc2aXPOi914cAMgs9C8XEsAN6g=;
 b=xzrjsD9tDjfmrZhx0BA+CKEXlvAuKQgI61aurpwRTl//uQsGH0kqjXW8m1cBrjYLhHD59Fgb+wEJ6HAYdYOYd8e0bXwGdrM9p68Tj6v3ooexDGEGo59Rfcx9iCA2R9vcgkwPY1BDVUfvT5cLUN2Fc6RToXrr0gDKnlQK7gXcdicRVwFg/sZfm3tUSsPO4MInoDxiPEv33HdhXKcg08Y2fK6ESEU3vgBsBVv1ZacYN3fG8EQzBtaJCqLV/CeldvbDRp1V8NkfAGM8SlAvRfvdxCQBePg1W/t6yPIEZgDunNnpDjkz4Nl733B7j22dj5sBBrX3wiC8MTQ3uaN+OaET/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zoDu6Wrkf/iopCyjhc2aXPOi914cAMgs9C8XEsAN6g=;
 b=lO6Ovs1VuT6oHQh4ez6e36jpipF05N8WjSAJU/N+Bfdw1c2K9XzV2Jbsie4yA6BKQ1vgckht/Zc3d4Da/fc9hQfVPjz0aduKqnqqTXqKdH2eUEom4SYSA3nzni6VZaJGAuVZZkUUhvZWxK/0DGNCoobI7AC7UlGCbI3SRUN3qHw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5730.namprd10.prod.outlook.com (2603:10b6:510:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:54:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:54:07 +0000
Date: Mon, 15 Sep 2025 13:54:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <5be340e8-353a-4cde-8770-136a515f326a@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121112.GC1024672@nvidia.com>
 <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
 <20250915124259.GF1024672@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915124259.GF1024672@nvidia.com>
X-ClientProxiedBy: LNXP265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9141ca23-f36e-4667-b8c5-08ddf456f557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s79zYsT7Yc2bilLY+9UvxOUdgTArmX+OjQoRNr0UXVX9jtsMiJbLieuc6E0l?=
 =?us-ascii?Q?dkYpvE3mPZpTmu4Llp/KMzy4LL5Cte9+9qmiTNnpuSMUDH/aVFKPqnLFT0hj?=
 =?us-ascii?Q?RYOWC1h+tozaTu0YiUOAJ7/9VxbMfP3iECdI1Si3oMiSlvc2siMDBjGupZu6?=
 =?us-ascii?Q?eTlZw2gEFqMUCtfwuaDCBwt4KT3GlDoojF8/D3zRjz1BvXQJyLgQeV97YlsT?=
 =?us-ascii?Q?MuuB/efqcyznrPo8uRvB+LSgqQ7eorauHhYRl3mevLrKp5YnEgaiMzEanI6R?=
 =?us-ascii?Q?nHHQajFH03bc6KUVWxG7uF9S5s7PVksdGkBlFXRXXVG9F4FpEI/kTXLFTanP?=
 =?us-ascii?Q?uENhc7K/SXCXzi0xFTIOyLwQ6MFU6/QETgfSWe5WVJNjhIjebeuvT+QdGtl3?=
 =?us-ascii?Q?i5sDXcKyvlacFdOkazS4Tmw/wYrBK9XM2anBqa7wq74wGv3B3G5yrgAVOHf2?=
 =?us-ascii?Q?cNAIqMWUpPLdW1ZNmxoYVWuFBGnT4YijO8JPKe2ZfyVqmMUmemHuPhS+E8VJ?=
 =?us-ascii?Q?oe7uvipiCxQBNRZIT3LCktRBaRMDFlffYu2x9OzwlvrG1Y3pfFdxhu6OFWkc?=
 =?us-ascii?Q?OgevKA3/+vxC60V6wCTrjQOval7qW6OQE5RUqtI6K1nH5DAXxntTJDeKOQB+?=
 =?us-ascii?Q?5CIagmq5Pobr3pa/1389lsVMbfP8R9Tj4xhSfN8NbcYZzk58lDpYy+7Suv6x?=
 =?us-ascii?Q?xnAeS7JWukcjiYIQd37BJBU0UaXZfYfJ+hZwftxMgFRfG42Te7n1fM6j40bw?=
 =?us-ascii?Q?AkWNal/LkGZiGq7IB8lL2l51VV9osfXXX7WfYMHmvNyWcgM6Kn7sA05seQqq?=
 =?us-ascii?Q?obxBN0qRHt/W+nVK9ZG/ItXpaDRfrRgVqDkcUPrX2DvLJoh82GdaJrZzdVXP?=
 =?us-ascii?Q?H/baI8aN+3OwGyO8gx2Yt8M6E2DSUUXIDFfFo3RpzPVhjCZQGtPF/TbfVk+w?=
 =?us-ascii?Q?+d6Hl+On3dAz6kYHkz9PZcr9NHwKja+oSFTEYDvZGqm/ajIDWyaQdweITOLT?=
 =?us-ascii?Q?6vTiSEv/aVI5sLRe5nNKfSUL/qBiu+/5RR09oaKP+wBwWPWKRYrIVqrHe1EA?=
 =?us-ascii?Q?i8La5WEmpDgsvgxTP76rnrg5nu18W1UrhI5CR4li3u/pZj9jrQ7JrS7qhUnO?=
 =?us-ascii?Q?1P1zBOAhr/frb0UP0fY/eHmxi3z5al4oP58OfBvnUbGfxm4RQAEuoDFbYKmK?=
 =?us-ascii?Q?fIMCoWIn2DU8qKYZeFXhCU2nadXL6anj0ItI/E1NQwRJPOq+EDU5yzi7Vwcm?=
 =?us-ascii?Q?UkJI5yvF/gghg20X+Z/LInRj/5wuwtzp9wjdj9//ln0Egdko9ENdjTZTXLaf?=
 =?us-ascii?Q?hPeUABrzEroxcZk6nn0GPLrgmIJLcnnjiK6WvtjZ2QAUMson4ZJHHatU45rh?=
 =?us-ascii?Q?9I9vQBk8lC1aXSmMyK84pjp56vDxvUh7jID0KS6t6/5fLId5mXEaAQhjLXtP?=
 =?us-ascii?Q?j3liBEL0GU4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xHQIhZpjyJhZvd1W3i7pFumVaCk9wgtKQuU4ZjbZnJS3MZ7EPaDib0Rk2Bwi?=
 =?us-ascii?Q?pz1PIGNQks+NKBNUDb+6ESihKjqoNfXXGlzYFl3mCF808Q3v8ev/cm03sGLE?=
 =?us-ascii?Q?uItxzvKcVOiMtUqoUGuirNXpoaVlhB4CDTANOm8ZZPI7UJT1qX1lSynYChkG?=
 =?us-ascii?Q?3m/nDDo1uShZivfdmo7lf+RbZMNXwBY1KI50wgvYoatfGmtDk/mz4WuHh4GX?=
 =?us-ascii?Q?wZBymHYxc1+BO1UI6Dy8e2UVdhp1fCBsVFulo3PIWIJjEJGSfiJ0P6I4ro2X?=
 =?us-ascii?Q?XSYsPnrjXtvXR1+LcYGEuqt6W1mMf9U9e+YaLVBERpyDgtlELHxjaPwNYTVc?=
 =?us-ascii?Q?jQSL93tqX4xrUyGqRbTBqIWXUu3V05cT45x1sS6ct0kPOGpSIe2D2YxSDDFU?=
 =?us-ascii?Q?eWUu29QzLNaJaLLLFUj8ubq2QIRIoSwkOD5TjBnbAiN5CEsuXnqLEvwsQ0Ie?=
 =?us-ascii?Q?ChXei5ebPY8GIi7LbW2O/VXN8wY0YRNAu9fXDIRcmm37kHlc+bz6SRLTGmmc?=
 =?us-ascii?Q?pFjMwnghfjkUGxGkm8GugK0pGVHNHnMBJjY09ydaHN4FsZ4/npRRrUdBmQT6?=
 =?us-ascii?Q?vUPsEi3dqxOqgMmLHTfk88oFjnzQWksDTAPov6ge4zR5Vqsei5AtLiaaNoo9?=
 =?us-ascii?Q?MKKciY+isPMy+OHzR9x3efSPZ65z1igC3iPrabhozDVRudFn6mvu5lfWYVwS?=
 =?us-ascii?Q?alIrPjbtM2qbRedsUInTyngyeHXPZ7I/YgJmInqANUrgZvBo7lCY/fmPDp2x?=
 =?us-ascii?Q?8YqROawBPWYXjFE+pRt1h2eLa+QTRte2HRJm0E7btB9AwLFksTXB8YFQopcO?=
 =?us-ascii?Q?0WXbJvinX94GXjWWSHNZWmCIqpPzkDuV9RUxo5b6qpvgzjmwP68/4rdzVV7N?=
 =?us-ascii?Q?5dE/fzBXQBnmA+L8G1GGMrFO/DSsKWoL33hGo7r9HipSPTreqsHILFcJArE4?=
 =?us-ascii?Q?q51rsVmeywdQylD7/hscWKuRo5SuynYYW/Il4cDAdLTSPH8cIPLcW9lT5gN6?=
 =?us-ascii?Q?SL3TN46RHHJWr2CC0pRlgZ/4XIdDv8iO1qminT55Oese7HCb7xNq4U6Q1K8d?=
 =?us-ascii?Q?7+Nu26badd81WTB/yLHRZpvuNRW5xxnmi4V/yw8zq/KkAxJwo1Ki45lqj4ON?=
 =?us-ascii?Q?zP9dU0Kd1vImtuVY4OOjSo/SMAn7zvSYgjtiYUDjrcEn8yvifS8gTkkWLy0g?=
 =?us-ascii?Q?Qw2oizwDjEF0boWrW30ElM3+1yQhLXXdR0KnM1uS8E9mT20sJ9EVVRkL2jn3?=
 =?us-ascii?Q?rxjXil4+BDvlj4mJp8m7hFJdtIt7KPjLaI4Hh2LEI0RFCaXvSaljTf8B/HBy?=
 =?us-ascii?Q?7+Gy2puO3OW2wB+bKhPLHeRxZsnLnlCCNbeboRdenqGoAxaoG6kC7SoX8fBc?=
 =?us-ascii?Q?ATah7tHTc+ZSDVlVPuxRlD/ZoQsjY5AALvRqj0lzXhSQ01NYFU8St+hB9ukr?=
 =?us-ascii?Q?9wxY0dWNIH5ToGsDQ+SccuqnMiXVAj+WbFZms3rIA26tnnYfPyW3VJPoltWk?=
 =?us-ascii?Q?mY8RQa940xfEywcEj+Fx4CLIgIFQDF6U/TOBHO252jxMMUFMdWGA/3S/SrZi?=
 =?us-ascii?Q?2WS/KpEZ33n8bo2hKK+MHNfuQTHuwBbnKR7aBo5qdb4oKGicAGblFCQezu6u?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7uOX7KCF2mivNApxFeH1MaacyjwtKr683Luzr5Maty+ulVBwgzrxfTJLEBv6Y+F3+B1quV3jg35CXFJOIictJOmIZ01Ypyswmwv82wrI+wtMMo6i/TLOeM/WJ26i1kIcLbopqR5U4ptYblt9w3uIPUUckuMfkDVyQ/WCTe+Zgew3MLK3GG3p6rFuxnrjdonuWrNb4MzyIgYEB39F6AE526i9f37CfrzM73f0L/CNtA4I5R81DVjRpoiRKpAiv8Q5CXW+Y/KGnCS322PdQOZ3pViFK9BRRM/VyxSpsk2ChdHr7XLkTMyURvs/upbDHhvczYNbWEeGthxVs9rQ0SgvcU61atU7hSyTWfj/9jMBEaK3g31HnvY4aa1/P7mzfyz+yWjo46o2Hh2R2yr9+I2AksYJtIIV0m+/EZUT+klSaXZhNhO5TIxzfRX2mNMMA2vTRZVodZ86j4qIZo8Z/xGpL76z1Kz4aZwkXcEQ3qTScHF3cWxBobSsRUE8bd2Zrjsh7ShfA4gs4OM7n0OOti2cRcTDu29qWKkHgnT98cNDe7R0V0stLspRdCTdTRUyevBJJrm+OQ7reYafEojJk6V6qvjXUBKZYwWgq1WMrudfEpY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9141ca23-f36e-4667-b8c5-08ddf456f557
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:54:07.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNbzcLZDoA8e0aZVT6McvsKrB5wvOMlXATJHrifTmZcVLg1CNnkwHR6s82JOEhMWRS7PtxfKk8o3Qf1VMc2ktQQLqFxol5RlELQzrgQriNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150122
X-Proofpoint-GUID: rN1odA2-HiOM_CVh9iO2b3xI2EHrUD2l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNyBTYWx0ZWRfXxrGeBcsDQs2x
 2brVIHDCDWFFEN5gisRYYbyvLXe6KyXHeOr0Tiqakfa201PU9lTYifOr86EV7ij20LhkJIJX+qQ
 Ted+ajNbI4CmP6scFV+f0mAtcxvAgChmo0mjMdHCx7Ul3XyOz8jLBo2icjBTstUmKAXQ6m2BjdJ
 pvjSWdcduDdFxBO7Ct2wliFgHs+AWcujPecOEjwWlSIzLHvaazjJPlDF00/wyPwIvYaVS5m9zs7
 1HIqtAIoMMqyYR7dNmyM1CYaJgTAAoNGruNHWmOFQqDpubi/JmijzlNtLcREO4tU1F+wnBzRuj0
 2VKDSxo78c0afTTT1dvNJjcjF7RNMWkDnVD4W+kB95MqvfLM8N8nzSVaFKB4GC4bDbPILE2zUM3
 0u8FAqB+
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=68c80c74 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=1Sb-PNH_FbyoOkfzMvkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rN1odA2-HiOM_CVh9iO2b3xI2EHrUD2l

On Mon, Sep 15, 2025 at 09:42:59AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 01:23:30PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Sep 15, 2025 at 09:11:12AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 10, 2025 at 09:22:03PM +0100, Lorenzo Stoakes wrote:
> > > > +static inline void mmap_action_remap(struct mmap_action *action,
> > > > +		unsigned long addr, unsigned long pfn, unsigned long size,
> > > > +		pgprot_t pgprot)
> > > > +{
> > > > +	action->type = MMAP_REMAP_PFN;
> > > > +
> > > > +	action->remap.addr = addr;
> > > > +	action->remap.pfn = pfn;
> > > > +	action->remap.size = size;
> > > > +	action->remap.pgprot = pgprot;
> > > > +}
> > >
> > > These helpers drivers are supposed to call really should have kdocs.
> > >
> > > Especially since 'addr' is sort of ambigous.
> >
> > OK.
> >
> > >
> > > And I'm wondering why they don't take in the vm_area_desc? Eg shouldn't
> > > we be strongly discouraging using anything other than
> > > vma->vm_page_prot as the last argument?
> >
> > I need to abstract desc from action so custom handlers can perform
> > sub-actions. It's unfortunate but there we go.
>
> Why? I don't see this as required
>
> Just mark the functions as manipulating the action using the 'action'
> in the fuction name.

Because now sub-callers that partially map using one method and partially map
using another now need to have a desc too that they have to 'just know' which
fields to update or artificially set up.

The vmcore case does something like this.

Instead, we have actions where it's 100% clear what's going to happen.

>
> > > I'd probably also have a small helper wrapper for the very common case
> > > of whole vma:
> > >
> > > /* Fill the entire VMA with pfns starting at pfn. Caller must have
> > >  * already checked desc has an appropriate size */
> > > mmap_action_remap_full(struct vm_area_desc *desc, unsigned long pfn)
> >
> > See above re: desc vs. action.
>
> Yet, this is the API most places actually want.
>
> > It'd be hard to know how to get the context right that'd need to be supplied to
> > the callback.
> >
> > In kcov's case it'd be kcov->area + an offset.
>
> Just use pgoff
>
> > So we'd need an offset parameter, the struct file *, whatever else to be
> > passed.
>
> Yes
>
> > And then we'll find a driver where that doesn't work and we're screwed.
>
> Bah, you keep saying that but we also may never even find one.

OK let me try something like this, then. I guess I can update it later if
we discover such a dirver.

>
> Jason

Cheers, Lorenzo


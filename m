Return-Path: <linux-fsdevel+bounces-61899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F9B7E1B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E31516E94C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90681350D7B;
	Wed, 17 Sep 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zs+xoEvG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="titzfDz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865C2F3606;
	Wed, 17 Sep 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104077; cv=fail; b=Tu2DsQlzwR3IvdpWLl7q2kIlWbVgWib6249pfgK2SO5Qg+uy6VzbsZeNvZ+5JOXYa31nj+D0mu1k56FKHfrv8ltljFrYTj4P7O9x105M4vE2lJ1GOn7Gj0+kNHi+qygsJD+MuSXAnHuwkaLUVHuxAipfwBNJ5heVEuL2AyoKVzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104077; c=relaxed/simple;
	bh=ZkGfFk1z+41iqHAB0iKkadJtNnSm5oatsGyIx5ilvA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FQf8Yr3t9G5WXfkzGTehZmfuxsEO66S93EwdbLO0kuuFSqilAXGFBw7S7a0UEuOfFjssxnWxRjPzHLzpptMPzBooka7RfrK0CWT5pRJzHXA1VTDnNbXb/pT8PdQ4ZtEzR1S9lbkmLcKa14qI5MXlTcrS7u29YUJh3p9Zwy676Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zs+xoEvG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=titzfDz4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H9tx1C031993;
	Wed, 17 Sep 2025 10:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WHQl46h+sq5Uj3KXrT
	LPSluU+FQuQ2sRVSzH8pXTIVs=; b=Zs+xoEvGg7XQucL2OIznHTbl+iTmJgKfXd
	oKBz5j8Mmr5gUMjsUi3LgZQy9wsrfjqexQlmvuk/A7LOLofdglnlJRcdc1rNBurP
	5aE1qTzyg+nVtkBIRPtiG4kmFyp7a3p1JA848gmRXu6JgK4jOOtEK710+VwIdzoz
	7C4HC+/sKcikC9WKcPjZ18tDYTJl2NNLO2f0+t7iXGbw9d4/pX2YsAWBvqJhHqXD
	CxcAiT9sH1F+T0uAaveewlsjzPkVU/iXFBJDAY4/cf7flfH+vsSDTj2tcsw+lbCN
	rLe0E9AmkMPraSGg8sFWV5hF5+QSUwFSYQLs8wt5xrl2T8jfQONA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9rwvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 10:13:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58H9TrCN001635;
	Wed, 17 Sep 2025 10:13:50 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dt0q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 10:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzdqQLcXy3VMnGEg8NVvNHdHSv0vdHUDI3843YIRoLKCwWRWzL7i8bFe+1ebpp0i/eTslGpgtKmubcdJY74LHs8NB+L5/4go5F093U3sCvylxHIdap1aHPZRsYQsrOlpknnJRChxUbg8oc5COw08pqEOWcm9FZt7ATQPZ6DAk4FVv8qdWycf9TzWLz+EiklkAcXXfu7z2C0yU+V7r++soK+7v0GcnYNB4+LizU7ev58w+qoU40yJNnH1vfjWtmh4f/lhm8TEt8+peS50gyUHuLCdrezi9YjI59xWYiHVTNYue/j6mfHRxuCmH3+vO6LwcgXrcvAevThUudu8KuECOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHQl46h+sq5Uj3KXrTLPSluU+FQuQ2sRVSzH8pXTIVs=;
 b=FCcMz0ihneTwpnmMjdfRXIOtSenFfnFvJ2ecDC/Ug/NsX2DviAskuk+QLEwWWtU7P1yntlcnHRDreR0Lt4v7mwV8FYGYc1iEJ+g4UhD8huS9dLjn5C6jfAn8oKNMn4VTvhiaaLmnBjWiGxX9S4RZ18IH7PIsCQKXqh5TxPzrFoOxX+S9TuO5gijX6hx5nZ78VqzCvcxqEspVVUROTg+d01JV8ELgLho+MBYvEacKUDEuMyGKtXvUlV9gRMKbhl8fyRbksXqly4ICN7isD4XG5bVrCcrQ40Jb9ZtYMD9YUhpe1lxgbh6x565d161g8mdVsxta6BxA3H3dnqkbY86Bmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHQl46h+sq5Uj3KXrTLPSluU+FQuQ2sRVSzH8pXTIVs=;
 b=titzfDz4exrUBhM1NxpJu3zIpoXZcs+k9lvjlnyFDWhqCQFw/dwgUQIv0yo8XQrNf2wmvvekqIVkB7vttaE9yW44gFMiFcvvXYTQnzCwiRkl9p8iH185Nv3dIlBwFcHAaRF2J3C1qvEoPo7MLA2HR20njkJsQmMfVs6uYowZ7t8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB7525.namprd10.prod.outlook.com (2603:10b6:8:188::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 10:13:47 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 10:13:47 +0000
Date: Wed, 17 Sep 2025 11:13:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
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
        kasan-dev@googlegroups.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 13/13] iommufd: update to use mmap_prepare
Message-ID: <44f3cd3e-d0cc-46fb-b9d5-0ddfe678487a@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <59b8cf515e810e1f0e2a91d51fc3e82b01958644.1758031792.git.lorenzo.stoakes@oracle.com>
 <20250916154048.GG1086830@nvidia.com>
 <a2674243-86a2-435e-9add-3038c295e0c7@lucifer.local>
 <20250916183253.a966ce2ed67493b5bca85c59@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916183253.a966ce2ed67493b5bca85c59@linux-foundation.org>
X-ClientProxiedBy: LO2P265CA0514.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::21) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a66a104-5562-42d9-6dd0-08ddf5d2e3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQqTGSk8gMNIiB1hsVxd6NjjSEH2Li1VXVPWyIsU0KHpBgBfHJV0mrKOO+yM?=
 =?us-ascii?Q?U3gq8v56fPwhbeeDoFmpsWfj2QiqUg4tQui4/YkbR/bVv/1V/kx94GHuSmc0?=
 =?us-ascii?Q?a4PLoXjSlTvZRS98zvHHUssqjg+HL6XV4BiLhnrTyJWpPgw825+3hzDwCDHk?=
 =?us-ascii?Q?RIaeggmRybJS5MJ1MLaotfWO9BlKFq2Ewkm/OKv3niWtNzpNwRcZefx0s9Ul?=
 =?us-ascii?Q?wlcyy2CsV7DRMBisPEijO5Nidz/DxR1jVGXS0Gjz9SGqAM8ZZ1U/cdkuAVAC?=
 =?us-ascii?Q?sf4Ry6Ad0CnMSsVMTi5rOfl2PruywSdv51YMr1T+3GVnvTZTMgKmZLpgCd2W?=
 =?us-ascii?Q?ibX7ftH76SXf84/8jV49ZXXeBJCy+8r8zxndYK2PXpzbThwwgLdiZOIjjnoX?=
 =?us-ascii?Q?1zoW0azE7Q1OTucuxa7S+b5qFWsbNgLkqS1k2kKijuL3/d16EpCIbD5b9a4i?=
 =?us-ascii?Q?hbmeSpgfIE15AuqBzzIEf9HWHitO5Us3VxMPU726bewBBiBG4TBLsBCd+uSu?=
 =?us-ascii?Q?xhNmPRMo8x1vPVvpw72pZ5/DgPKp95fYt7/ox9DbITkKfhJ9Uh7Ob3tPj8sV?=
 =?us-ascii?Q?y2kOzEqqaZdm2S657JPFaYapZTAiYvvdOg1nrYLQ3Ti9I/SI+tjk2EwlX2EL?=
 =?us-ascii?Q?ZhPEKPCZW7fy1OcTNTR5LBANMaiYI8XJCYadlM521PYxZsY1UtHwTAScXMw1?=
 =?us-ascii?Q?NIoh/RW8GX7j2Bt2MPBlblHGfjWD4lh681K0Jr1/xdO3sHjc1+URPYRYxYOx?=
 =?us-ascii?Q?72g+I6e/8U40UeF5vGAMxMsVIHarU4hdy49/6zeDoM1ZKBoZ2uLAp+svnzAo?=
 =?us-ascii?Q?u3DaEiXhJuNWzGD8iNQuiokNGaQ2cat3Omc93WfG+DhgATG9JFqg92fdxgur?=
 =?us-ascii?Q?Y34c0T4L9re3uYr4ckovR5Ti1uOCHV11bzXe/dBobo54D5GuWWUWwQk9Dju1?=
 =?us-ascii?Q?rDP4RcBf1ndWcbSRK2dBvjutPprMIECV28p5/u+/g3WkT3SC8aUc52MF+5B/?=
 =?us-ascii?Q?amotvKcwPZt8glRjJvxAgWABZGr6TItTwZ1gDjPKENMNgnaI1txaacakXiKD?=
 =?us-ascii?Q?fVX9n8Wxt8iNueg8zPiv9Myz91yqyfXFGYN89Wv3UQjOiWb2AtPlFV+NLkap?=
 =?us-ascii?Q?j76QuVf4Q1DzRZqMOBiQYx/QhZi4XR/5aHcy0JRcXZ2RKRnpScbdesTkKU10?=
 =?us-ascii?Q?Kt8G/feyUlNN1ObSEclxoCbHqBzRZ7rh1Cn9GB/C7FTiz/oGNUbJJ1GjVLyL?=
 =?us-ascii?Q?7bSmsKdOPXtKDic4b4PoUhOYVA1t8hU4PO/jALsQq4Ivc9jPhBPCDB7P+Fd4?=
 =?us-ascii?Q?EhvtOjuM9nsDETkj3XV5i3xSwkWRIiMxdEzYeIwKKZdQKrjGiSz6eDJnXLO9?=
 =?us-ascii?Q?vokBkKwQqxoYsJf8nVfaC+X0tQ79p3mwCoodG48IPKLtKZqS6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AMPwGHPUp1wjvrsq1w7trHnkLmNGdP3yLsHziVrv85+FuBIXtfdI4Gej6YIy?=
 =?us-ascii?Q?lggspXcQbrc/d7iEPS63LZ92iUzbTNV2TKPNzyN2pwtFVHcKSqAG0JrXl8XH?=
 =?us-ascii?Q?bGMXSAxOAP7DZBXpxhnT5XeAqnkEAgoXOUjvNDDhit4wUY0/qO2K91jduTrs?=
 =?us-ascii?Q?ayOtkP2JQ7XNt6q4PbXHoJtMrU9mSj+8RenEz/87txQ19ZAGT7+kdugG+PPx?=
 =?us-ascii?Q?izU8NkaT5kXMLSkG9Hu26Mg/8JLdJy4QP522LCUzqMraYJPAmfd9grhbH8BW?=
 =?us-ascii?Q?RyB5gDsfgmxmtr4fbBCTGTytXJb6em5pIohmYGzyCZ2spriRg2qt0Tvs4gua?=
 =?us-ascii?Q?9r6+eoJAYRjv476pPOdq4aiBBmQ7d/XSxGCPk/R68Q6koIe8tDvPsJDqmhdh?=
 =?us-ascii?Q?5YxCRq5At1FUB6GZQcjZdPTWmu1zCHhwiuZzqjtyiUmm+7vdhT1qSxWW4MMm?=
 =?us-ascii?Q?otCtcExtMU4oCDveY9gFiDvu0utFd6IY9jDf+FapVbEKGHaCUWSJCMavSOZV?=
 =?us-ascii?Q?C+r09mgEBuD0EPjstXzatSwhhp/dBBaByvMEzB2ASK+hjgc1kEhNS8uLn6sp?=
 =?us-ascii?Q?EmtaRpRxrTjTy04fIzx3k/3/IkE4nYh17iN5CZA6Fuv9AzbE0E+p/nbyoSKF?=
 =?us-ascii?Q?W25KIQ3D4sCmNhoHJ5c6fPYlhmukbqOcR5mZ5L4SSb1ocmn4u1PuuM4RqfTo?=
 =?us-ascii?Q?JHQmlXgxL0bC18rCPj/lOlqEVUeeLDBiPpp1KLgHqEoJkkr+Mt0GzeIXS+7N?=
 =?us-ascii?Q?oT+uKEvZEsh7vnV0tkB/3azG8y9z75naRX6oztGUplOYyKjmSfvXIsMSbkq3?=
 =?us-ascii?Q?IOhIXAXdORoreEKuTSRnyddRT267JT3MVOYjBeivdZK1bEcuvwRGfkWyPTdK?=
 =?us-ascii?Q?YHfyMrlUOBN6/V5jvy1mbCzJHxVF8aOGUr694HLa53u3lFLQEsOB3iuan8bP?=
 =?us-ascii?Q?jMEE9UuHcBRR91UXwSzKVOfKVxTNgGMHRLv1lmhdEWbITFFziGZ5Wjto8ebc?=
 =?us-ascii?Q?a5Jj5Kw331CfbYuoBo1wBS3gStRysOQ71VxJXYtgrAWMqjfo9aA5uSd8lDx8?=
 =?us-ascii?Q?A6it/x0G570yKwbSV+pKEwxtNSgDYUMw2imzgzknVm5ANocTWj2jK5g9SfQU?=
 =?us-ascii?Q?drK5suOBxt/k/bGU93RRLWZDuTKNfnTj+ShfzRnfg6eD3pfzNYZXk8pjuPBn?=
 =?us-ascii?Q?pciv6Fl8hITLex9ivgicW96xS3Ds9/U4X6ClpInb1LEY47NTQEjuDXR8TTMX?=
 =?us-ascii?Q?fxzeu2UbhMpZ1npbQDrLOYg5v1p10fxVrI4DZ01NyEaySAyoGRvlifC5zO/5?=
 =?us-ascii?Q?B079iDo2V+wgv1SBqEGoOyce+ZNqXbnYiX5BSKwxAdRbaS95wvEoY9BXsCUZ?=
 =?us-ascii?Q?RvTn67O2UoBbLbW+VkScPP7U1GirshkoHLQXbUY28aTpegeI8tN8HolEgyLi?=
 =?us-ascii?Q?o1hL3WjhNUZqKLHFe5KV8Aspa3Ccs9RLQcZrSiTsH3FPXwZ8fFpjHVP92zNP?=
 =?us-ascii?Q?Yn2a6NWFXnpqDvlxYFAquSS2W1BPJABrg4BjfZ8W1JwWZH5kuO/4gbby+ntJ?=
 =?us-ascii?Q?rmTJ9HcuLa5yEhtpLzwVVLuM5I69fE9jc1FZRNF5+FMWNIMhBm/jADJ5KdYK?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XLeSukRZCD7D+wwn05jXehb0nU8uQ7ej9h7y2yWx+MWqxEaRcme5YpXzFm2vQms/DYNYrwGUT9Gy9dLn+VGZbt4VK3nQQYdgRv3pO1pMGuAT7szz4p0maJ98B33pldIhvcGhScKKK4kT2ekaBy5QqyZSJHoU34rQUPPhUvw2SXb9Z7M/e6hnSBv3Y+DSm66PZY/uTTy5VoFgECVLrzzcu2avVGdDtcfKyowPdEizWq6MwQQhlHT0bsu6z8UtVdsNN6jdZ0YNDnxXAg0TZRg/IdkJ2jCh9ojggqxvxyzAi3MdLDOMYB0bA5Jf39qrE9tJxZ2NmbAX573JAZsuUhgEJdNKs5Q5xu4xyiVKixosQ4uhSMC97Y7/bovjPBcdpGHZW2saoS0zyVOKFdSdgvj/8S1QSAeUQLHwmCOrJb0TeIFa/xCbbWG+tQHXnYPA2E0ZMQxeOi6Hnn9oxFnqXk2k9RUfCTdDpI1tSUTcABrHPmttM1Wr2ZNglkDu/r76JjXpd1/14oR5kdig8XBaNx/O9xwGWLZ4p+VNA4SlEYLl3JFHWMAEMScdQOYeCrvQKbPyQIQ+8LxElbkGf5VTdnrVgtgY3UapK5V6+s1SXsV2CTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a66a104-5562-42d9-6dd0-08ddf5d2e3b7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 10:13:46.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzsURELcWKaXvIBwtMXXktyJwGvqFUL0ZlyKnvcjYobyJzdvrniyM00CmgJHJSVYFYBP7q6W4u4vwwqNtKUP3oU4tqrr8ELycGWY0NdNgEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170099
X-Proofpoint-ORIG-GUID: hSqHHYD39s6lfhe3C-xgdK9xNOEttg2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwomsjDNFYKyV
 Jjrrjnrv8u2k7dAbXfZPe13HMsDYiyi8in1E1Tl3exifWxY0NIhcmjZYieIArJGJLW9tIj5pV+V
 ZtpnEljb5jaZ3hBdPF/RMO30R0QohHwaisWkSWNRNH5SaCdcnTQsyih+NtiotCNUJlPpXrLJLVF
 /moPnPQysyXkjGe9N4v/vwxEwJSaeRRGn03dCBotJpWOoy4D3xl7VVItvJ4QN112O3tv3lgF7IF
 64x6zqF+hqK6+DwcNezjUpiNklhn0OKKNuysHBprKlKbDtVzQUrl7+HO6zJSQxOE+ySl7ojoaxC
 FsY8f6r7zBDPLsjE+vsV+Ph0ZcjDzvF9i4VXv0Ppkjx4nzsXG1ThPKThG8RGXbFYqJAQVwATE4N
 NC5SUWhg
X-Proofpoint-GUID: hSqHHYD39s6lfhe3C-xgdK9xNOEttg2d
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68ca89df cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fsd4YKtpGBD9qYw4rf0A:9
 a=CjuIK1q_8ugA:10

On Tue, Sep 16, 2025 at 06:32:53PM -0700, Andrew Morton wrote:
> On Tue, 16 Sep 2025 17:23:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Andrew - Jason has sent a conflicting patch against this file so it's not
> > reasonable to include it in this series any more, please drop it.
>
> No probs.
>
> All added to mm-new, thanks.  emails suppressed due to mercy.

Thanks, should have a new respin based on Jason's feedback today (with copious
tags everywhere other than the bits I need to fixup so we should hopefully have
this finalised very soon).

Cheers, Lorenzo


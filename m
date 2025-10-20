Return-Path: <linux-fsdevel+bounces-64688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895EBF10AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A51E4F290B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791931A7ED;
	Mon, 20 Oct 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBTgfAFC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YVqSj3Nf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4EF314D27;
	Mon, 20 Oct 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962390; cv=fail; b=V5oBblhXiR6eVcNeRKb9nGZ+0Y/i+ZtqI2evEXEwMdOVQWP2QmmKjcRosLiKgC7s692NmzAGW86J3+PKzQE6d5EMkVCwjBH27t5nfkurvNLqcmJNXIJDC/JiEAfXdt0ICQUif+tbE5r9G+Sx5hcM47IvN+DDqJSbDfTfK2mqdBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962390; c=relaxed/simple;
	bh=ZmsO11HT+PEkFRZMNBIimDPhkOa/DlxeVq9OHvf4chk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dSpgjJjcdaNXWzVTo/xSoe5ZZRw14Otm3MBpmfB2AO3vjUUFE1OSd2N/3ajqQyHUFjWNn58AFPbeqpHnOw/ou0L0QOHTVmaln2zcSkmdpMa8yaUIh6LPmMHqfuX7hu9Em6Gi08jZNuL9EKAJWZlUKuLTjfW55rNJGrAxEoSFwe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBTgfAFC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YVqSj3Nf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SKUL014475;
	Mon, 20 Oct 2025 12:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jywckxg5BM931hxvl4OInXK6rw1qXlkmdTyEsV38iEo=; b=
	hBTgfAFCrBw+Ib89YwVDGPEEJQVrJMHxGodRGBSnsnVTQ8F8RoS3Wf79efnhmjNe
	cSPg9KLvUlIpCDrc3qW+tHhZlCRLwjjTJLlZ47ghfGueBjqUCUC4pHIWyafZQWbl
	QLMgz9aus+W9bb//2HQL4PVhNnDd4CFRXtAxGKgWyOFpzeCO5n+1Bn/imUqD3UMx
	3eAaIqHhcgH7vhRICUevyDZxBzSNJQ7w15IOQxT623YV3rHAXj9TML5XifHd0M4N
	gbGA7Ijmj8naVylCE5SB/GSkT6ec6gWvKO+a3kCRT3GZPogTqdCGBe0pX4EHT/PH
	CZQ5CDH7r0/X/Bkf2r+gPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdh1pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KAANOc009365;
	Mon, 20 Oct 2025 12:11:43 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbvayv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5DxL1QDzBbgj5ymw+lzSjWPvvxPT9nvtf8hnVP4nWAxwPzDPGUPnPIAkn9RYP03ur9vlFTmizBovj4mYclbtOELTaKBWcZLeCFg+h+AGWGrpsAYgpX0mIw+uAvbHdH4ESRU/trh1zryaiDLaHyAfXshzMuZrQWDSLdl9r7lGWDlbiqnjgEztOF6amds4I9hgaxpFGIB/CnQsxctn68esSBKJi0zOkkLno5htcC3983Ydr+mU+mIvn/y02LWZ1a8Q5ziyBbG6WdH3OslV/kEf+WjQyT3K6TIWTpnAhn+EIFlISKeWCT7Vp5dmKjf8pTmbH0TQFKJsT2atk7KZ0UMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jywckxg5BM931hxvl4OInXK6rw1qXlkmdTyEsV38iEo=;
 b=chqxGwUk/QrEeNswJ+/UgbT0uztyaPYQOowyqoPNfMP7H8vWUlmS4dqu8jAP2NMofp2O7zpipoWW6nS23ZAok748dWv7Uxom3Md59QuNIalg9ekIV2US++iXGCph3rOOOX/5E8dO7uVS4QHG6Uz8kE+eNbgtVT6o/Wg+rme9ZQcQ0NUedzePaF0D0zR4Gh26XnyKI03hi3N8ns7AzoP0hW8kSqVunxTlxBNYE2XPbulEMyVTS5LgOuZcAE0cptcY4adsWIerQMxtgq4CKSZNCnh90yEVzIxtd7leA0bhV4+XVcBUfUMNIIY6j5Xh6ZO0TZSlvXAKRPLEtjoSn2t5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jywckxg5BM931hxvl4OInXK6rw1qXlkmdTyEsV38iEo=;
 b=YVqSj3NfAmzd8rsIj9Nj6FXA80mSA2D3pKayKAIykJt1H1+9WfknJExMKGgoWgJlfFl0erg9ByDNcyCEG8+zSwLWHJV/FXzotuNeJk0aW5vauz0hWoeDGPBrEf+LBuWUiI5RbaMcw+a7xO/pAI+5eaYAnKZ1iN/2ibOjQG+seIM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v5 01/15] mm/shmem: update shmem to use mmap_prepare
Date: Mon, 20 Oct 2025 13:11:18 +0100
Message-ID: <7b93b1e89028e39507dac5ca01991e1374d5bbe8.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0363.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 593096a5-16ee-41de-2d29-08de0fd1d348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Li/YStVhnDrt6t5mWigTHifaTD0OJ0/wpn5TojPfmH8K2mvRj4iYljOvPIaS?=
 =?us-ascii?Q?NCkX2y8cgVrf110JtHXYq9qP9778tz/tcQTgzBcuoRHDsEEo3IEQkEeiaCvw?=
 =?us-ascii?Q?FH0ucE8QVG6TudpAsRPHnuxp4FUjit2/NgaBJGmhI/vqYEaecNtoJJ/llYtS?=
 =?us-ascii?Q?U+QBr8ZqkTJU2u6Py8zIR9Uh8N7F2aEgy5FfaNkgMo8QVBCheb4KwY9bftI5?=
 =?us-ascii?Q?rc2frPKGPQuF0fnxvkmy5dqSjag88tikyWMeXZHoSybKhk/M1MUHi4w1FhRs?=
 =?us-ascii?Q?+294H4QSAQcUxnzWBrgj+46kHVWyA2u6lydQc2WxvcOHYHlejxaZf+UsG+du?=
 =?us-ascii?Q?OBKh1zI2uTWCj3xKbj+23t0m8kevm3OR6ioYbSos2E81jnjwvs8z5wGx4k0v?=
 =?us-ascii?Q?J4C2tXan+6QXj4w38DyUVkw09ZLEcA2ffpZMGqkHPBe6Xgj0wLX2VlefA7lx?=
 =?us-ascii?Q?uEW14tTuK48pq7hX7NLaYnJXmwHfK5GJ+h7W1q9kJwHd4RX/VLQo2tSGu/T/?=
 =?us-ascii?Q?fGa52YF1/4c5w6yQJU9cm8hUMYYraegToWsdPfpZcxFmapkUDLyPUUmF36xz?=
 =?us-ascii?Q?qWEaq33nJ8d4k0c75uCkTvHbZHv46g+szjxwdK0ZOkm46YmwzznV2Y2DbA4P?=
 =?us-ascii?Q?OSwQsjENRizivqf8SwYCZmObJCysYUElz4BoSmcAjsyFEQAF6GxMyOEc3VET?=
 =?us-ascii?Q?05+AirNOuGfw9wY0up4qb2DsiMB6ZvSO+Bp4pz8NbsjPzZhNnwFCoi09Ts+9?=
 =?us-ascii?Q?1GMoP5lO/qnIZauhQs8DuQroD4JqCXv4uOzSs+Ccg6iYXej6MkNWKMVf+20D?=
 =?us-ascii?Q?GGMrLlqquwAgjcdusPkC1XYv+waebIucC8tDhpsLlelHzZ8631agE07zz2/o?=
 =?us-ascii?Q?aKytWn6t6nctmCsdU3mN6OGHze20/666nZxZtYBoBz9LTGIs55viVjRjDcDl?=
 =?us-ascii?Q?Jr2guivKmc4dGYTw8tljK+ldAoGACn1pEMob7HOb6bENROiG5esMf3M+FhNB?=
 =?us-ascii?Q?CJK1t0j2rmZJlJ5qYB3PkkLTwHpLVSI82trNGUPDgnytAXbjS85o0Yq8had4?=
 =?us-ascii?Q?ehWofWkO/CY/Xw8qs35U2R5VgKOSLzVVinMwPwB5HDFIml+96lGC3ycTzc7b?=
 =?us-ascii?Q?c9nXawEHRF9xemd+kQYgKFJm47vIYQmi7Z5Eco3Rzr7tn/FMrBmmhxRLO4h6?=
 =?us-ascii?Q?8+JrIeqBkcH9PJKA3nwnq56Ezm4wt/d3udkcZp3NAo+OkWBo7WLPUYkovHzn?=
 =?us-ascii?Q?eG17mhvrL0o5h4wpHw6Rf1suagkvo1fbdaDVR6HqioDqGZLBXfeYtVEWRnbT?=
 =?us-ascii?Q?zfvlfN5y+aMM+uSM5B79SNarE6ul1ebwQ5Oi3M93RehrLftCdA+5J2vZIcab?=
 =?us-ascii?Q?5dKUM6tXB5cplnp/TL8LBAFPY8PRzsGGgM6dZ0qrt8c8E9/w2DnM8g+Gy0sh?=
 =?us-ascii?Q?XDZUy/v/uUMCySJqm32LQAMQX3EoqUXU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XaH5wblVZnjFAtFARX+FsUmdtMv8YU5zpZjgV1YlfrRCZOh2aMxsfpSOtKtJ?=
 =?us-ascii?Q?V69Mfumwj3Bfzbl4UzTWBJ/82ejXqjpXoGT013C71GL9s4HfoovKAWJusiUp?=
 =?us-ascii?Q?io2d8VRfx+kABSxdpGzZgJw61+4zgWU1IlH5WYDidgbTtfJamoFouAiKAYXV?=
 =?us-ascii?Q?TleFwAITe9wUd94vbDzifDjg/M74trJEwwK6CNuTOO3BNcvn7ZxqZkutSlYk?=
 =?us-ascii?Q?OsX5rJb5C5dUZ5gxhQzOIf6FaQNoVj4rfQ1z+EATyPselKSs+W4RJ3vhx81Z?=
 =?us-ascii?Q?UDpIugZ8D0su43yA44sabGQ6RMoygpS5zStLf23OHTtgrhXUVdEXknw/foPV?=
 =?us-ascii?Q?GwF6c5s+uz65LfrqiTT2LcwT5vgdet6Joci2EIZ3VJQsubhOVnoVI9fKQgfF?=
 =?us-ascii?Q?9xfymg5CQ5z6hpATXTlMSxZPUPIYhMpvmWTLCv7XfUfEZiY8VlUQm686E4DJ?=
 =?us-ascii?Q?9YAiA3Mm2yRLKdfjTkty1JyWu4huZCltkKjWGQduws3yGMkukCuhkX0lz6OH?=
 =?us-ascii?Q?V0JNpHywhfTGYTI6nvL2KqvgW/iWxDTvbMFD3hDUS29oLL6WoSdnCSJXBtIY?=
 =?us-ascii?Q?myDmhSDy+C2KxVi/OxtHp0M/Z33nPgMzGoCJaUeXR+jfj0gE6RmgbsqDPktc?=
 =?us-ascii?Q?PiTCojl0moWDAqNAGOtc+2mbBOJHgncave8cTNNCJbs4+RfNuCezoOtTWL9p?=
 =?us-ascii?Q?y9Xozrs8cFML18cbdkHwc3afYUQYxFi5t3x6/gAedOviky8WkPqj/ADy1pR2?=
 =?us-ascii?Q?/4Nkaax1jkI9v2/PiUwNSM/cSHvAc5jbzxtXrEE9D5Oo/2hLML8X4ck8HxCE?=
 =?us-ascii?Q?XGxFmWiT/T/WRN+IV77+5WI6vULfoflliIHQ+VETQAvZnvj5ehM/nQqMwRBs?=
 =?us-ascii?Q?FS1Q29dquJPWAGP3J42RcTExm0Ij9d/ALqvTH2FFAISe2BdaJD3IZHRNBX/1?=
 =?us-ascii?Q?KEdUqrgYIk2evQHX70mPD7WtZJnIsHOUU1n5ePWeNYnLMjr7czM3tkZJwVo/?=
 =?us-ascii?Q?70RlFo5dgMhjsUxGsU7uAwfsYAEZgbL/hlHLBD831Zq1FXqJ0r6MkTiVT/YZ?=
 =?us-ascii?Q?VNZoTIMgPJH8rnS90i/stSUIAwdeve4cwmvZv4EIc6ESnheojuaTHadzpFOP?=
 =?us-ascii?Q?HAXoQcbl+gUIVnIhykTnKPAVgub/WJQ45qHuceb6nskHzSiO2KUnlbBLQl9F?=
 =?us-ascii?Q?3Vs8V+K7B/2T+SbNp4TXVlqYhYacV+zkU3I5Qx/ERLF7sbFNWET8YTYS70Fh?=
 =?us-ascii?Q?aj6vC9fdN0/8rgXGzXg84iNEm3UFK3lk9HKcgI4EM9T69LMSpNLquVEA9DH9?=
 =?us-ascii?Q?U+7jGXl/a5ZhSBcuNYhg0usJXDKAH2haQpLXi+sFXcq5yhFPHL830M4kkzIa?=
 =?us-ascii?Q?aGljvZRVfXXmdsElF5XXFRr8sIrnCRrczYh4rAxWvcxEPx5Zge5X91imMWsq?=
 =?us-ascii?Q?ueVAuxXzITQ1hLU04NtflphYhNWHL4QO+uxDGvnIljYkK9odT56pMpNkBAVn?=
 =?us-ascii?Q?67Vfly2O/jbkQjccBkAWuhwYYOECe2BCEbfsRdqLdxYw6bSO4VoglAX+h0Hy?=
 =?us-ascii?Q?cqRtDSRtrNH//mV83UqzxYxR8UqZ8ry8LJfw1duLhFTB4Hmnf50BRuuZEK/v?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d6QY41XTO6Nckqw9okz+jul6QSudxZJaHqkJ3VfguQS0ckT6JZ0r8pIj306IUvk2UH3iTzbvuWYg7O3KxXjGajVVH714mJa8Cox+LtthvtkrnFlW0GJ8qYERW7S4uTzEcdwNaItDyedD5R5AJJxtN+2vHO1+XeAOhAcKk0EHKR6K/SIKL6wAQvV6hqL5nzy4RiH+JryH+xoKr8JSxbtXpBKzqBJEDAp+C89sNkNVBtqhnVh0yzfqe/kaX02pBQXAgc38Kr2G2bZLSgCzFbUo5gAZT9nb5zfPkz7eJ8lkHaSj7PybH3nFUn1r4pSXCPKDpO5K2X+xZLkzxqCzQ3hbJPgXKPHcLpLJEIkGLrCkWMGgOqBfJE4PP5yefzz5wkhmJVa2hjVBdy3ZzAEt0+cRdrKxkSWVT0QIlPLTVmmI/8+TWjhkqih8ffY93Cs/1f0Mrqj6CoqgCYDWhEiF3jnfGn6h71jjFYRJjR0LcSX0RhmAzGweo1WVDJ3BRdqdHvWSWX5JcgJlqfOB5FWD6Cj9vUzGSQsgkrQjDyATF+oEhJT2AbEoeHndm91pCTsIdgAkgH7tj3vq09Ft7aYs+1b86cyF5EpYtWhlUKTAmsBqw0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593096a5-16ee-41de-2d29-08de0fd1d348
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:40.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlHpp2mXN9aWu3yF23WftrIBPPsvlaG0Ew+T1i/bD+0nGUdeALxzqXdAL2Dg5Alskm8qyYJBE6lx3ivWp6sLO8AoMBAq/AaSVd9A3aUPzaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-GUID: 6mnkppuUdKaYlf1OGhATq43Hq2gAkqAm
X-Proofpoint-ORIG-GUID: 6mnkppuUdKaYlf1OGhATq43Hq2gAkqAm
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f62701 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=SRrdq9N9AAAA:8
 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=prdUi6YERRC1zlzC8DUA:9 cc=ntf
 awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfX/Tsz7S29qCS+
 e+UoCkFBsctsnd/rGfewrFz0FYHtSuXAjN6sS1H0QcZ4BTIVCw96iEDZrmPwQapGy04T2uDgyZr
 rofCvq/RLgcDpeAXH5JhSjD8ZWZ00fBYk5tEUxgi8T1OIE1tb2X5AdN4IjT2bUkObzzDatwYic/
 Gs4vqPs3PKUX+dFIyJmaQkqKII2DdaTJgJUaYPWM6P7PwpZsIzAHtZ7YqIYysPbDUnLFKGlUbgI
 zUsKMInI7X0/zz9LEaWlBgV5sXcx+LQOBZiHynitc+BrqGVVLG5nL7ithLrsdE7VMtpOXY18RAY
 6jMS9+0xkNJzhsPf/qkD/cgoj14dEUY2qdYptuHNRJAT7ejRAjbaUS0agWSuxaSipk0DBKhcJBy
 +wS8LVnSS2I1h8vPeZlNnrecy7Fdu2ikiqNgTIHAintDSVhABLw=

This simply assigns the vm_ops so is easily updated - do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/shmem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a6a0d6652851..ec03089bd9e6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2922,16 +2922,17 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	return retval;
 }
 
-static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int shmem_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
 	if (inode->i_nlink)
-		vma->vm_ops = &shmem_vm_ops;
+		desc->vm_ops = &shmem_vm_ops;
 	else
-		vma->vm_ops = &shmem_anon_vm_ops;
+		desc->vm_ops = &shmem_anon_vm_ops;
 	return 0;
 }
 
@@ -5201,7 +5202,7 @@ static const struct address_space_operations shmem_aops = {
 };
 
 static const struct file_operations shmem_file_operations = {
-	.mmap		= shmem_mmap,
+	.mmap_prepare	= shmem_mmap_prepare,
 	.open		= shmem_file_open,
 	.get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
-- 
2.51.0



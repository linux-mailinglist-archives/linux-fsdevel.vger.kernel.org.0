Return-Path: <linux-fsdevel+bounces-61392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86115B57C41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E2818961D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058842135B8;
	Mon, 15 Sep 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BEHJXlAr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wq9zJxv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC661A316E;
	Mon, 15 Sep 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941383; cv=fail; b=PuztwPRcaWnLNbASYL8Ginac3L6AShPz1jgWd/lRLvxZUIoiEmmRLL4csGFu+8it77bK14Nm7AnRCFqZZ9AhE58f2PJH5IyN17ducJqBXMKKDrHyjSylWZgMDlWvzA2QghvAW9gwDcoMY8A8akBk/HdRRTotShJLFDsNKUKv1ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941383; c=relaxed/simple;
	bh=z935DoB7jcLfcoRxALP2ST6VJzGdD7UbjqdSc5i/7Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S34zplOAowe8Ose88lh6Dc77tnzjTrHNvcIdIFPdjUlqSE7dx8BmR4zU3kRbjKg54DciZrcdNU8I66bRlnrk5PF7DTJwwQZSIdpGcvWd05NIhZtGiYGWk8o3cyGyhONngTg2MgI0OzaFqgSOPlt+MrBZy+fyd9cM1nP7hS1a32E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BEHJXlAr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wq9zJxv7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FD1EAg011955;
	Mon, 15 Sep 2025 13:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7T3jI5545qmL1/J3D1
	0t9tmGcZ3W3KiAyOuKTOuZC+Q=; b=BEHJXlArx2x+priv4UdM5/1uyLJq15ddzq
	44inl2M11XTQn8qyiPtlpA2iggLc6jahYNd2MUegm/G3n1FyAhL2RvqWnN9DAXBf
	dBN71SuSk1tkmsIRbkZXoPVX/bXXCovhsv6sR/gWrPFHX61rUU4T7QV+LPWIAADF
	JEhW8/62SLMRga5BamJTKm4rNqaO++LeDgvg5kYCpyS5hLJP62eoe9g5FzttyUSH
	ZZNDI5gexlLiJB3DEtYPpuiWpZM5X/sNrRgHvxNq3KxyBDvvglFzgbBkDKXK7uW7
	xkVvr0P0fFrz4vXcXq1uwOXaAZ0qqFMgBDcGHMtUlcnHHuPZVrsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72tc0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:01:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FC0Ak8019324;
	Mon, 15 Sep 2025 13:01:36 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b8p47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:01:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hzo8MS2WjrOrVOCqdMjsuqm9PpKs9qdB5/4fTY6PpnVjgZ59TuHan2Bk7ezGJBHaWzUtNJC733BSWumbCQtToRkufTiBUGsI8q67SyeRXG2RbZMX94BZ9sU+YWIRgow8jAXZU7qjqFy7qnonUWVpw5gdpi+LrxKGZrBLfY+R0ueS0V9ahdF27z9PWlZSGlLhtCvD/CsBIQzsXQHchLURuL6aouANJCo4ItvHO6zuxoU4yVVYKeLJ6w/wJrTLlCQtUi7STcnDI55mxCc9zfBwy8OoD9G2uEkqVZnFfkAH2HkmlAEPc/TSwGE8XH3qFlWItQeKMieLtwlWg534qPqSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T3jI5545qmL1/J3D10t9tmGcZ3W3KiAyOuKTOuZC+Q=;
 b=WTQ9wy8m/NyHiNrf2hbdGRKDtG/PD+F/mgULO/0YThZ/t60Cdo/1v7M5MLb95NPgnj6mCbbSSdlr6vJa1lrcPHTzKzU1JRolc/bog9OyHfleMx2zDT7BjdroqvuQy7IR+2P0NJTAxiw6imNjqk6b1jnQMiDJflFeCCSZ5vD3h/RtRYg4Eg7S7VzYG4U8MKU6mIjhtgeUdW2FRhAE4pG0NEJ1jXmVOjQcOB633nF3fnm8/XVy8LXwqPLtEaVQ6x0MgVeB8Vha+wEE4LekEbSM2+nibMA1wH5RExzhD5ajhU7iIW8xtUKnEl/sLPmT3f783xwaUuFRBGAS/KFcYWdGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T3jI5545qmL1/J3D10t9tmGcZ3W3KiAyOuKTOuZC+Q=;
 b=wq9zJxv7DZmu5M//RdMoqvwUBwtItxEPhRc34Kb3K1/sPwI1n1qTMEbwSCe+rzATPpm1Gr4ogLQEyGZh00Q9s4k+OfXYCtTHOoZ4C/F/+TOi1SQW/YMiIjZOUqX7hPIE7oEkvcG/79x4hkBN66cR7Bt49F6djFNz3LG2lPPHX78=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7307.namprd10.prod.outlook.com (2603:10b6:610:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:01:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:01:31 +0000
Date: Mon, 15 Sep 2025 14:01:29 +0100
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
Subject: Re: [PATCH v2 16/16] kcov: update kcov to use mmap_prepare
Message-ID: <ed1c343b-db56-4eae-83e7-ffc12448fe31@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <5b1ab8ef7065093884fc9af15364b48c0a02599a.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121617.GD1024672@nvidia.com>
 <872a06d7-6b74-410c-a0fe-0a64ae1efd9b@lucifer.local>
 <20250915124801.GG1024672@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915124801.GG1024672@nvidia.com>
X-ClientProxiedBy: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b0a799-dbd2-49d4-506c-08ddf457fda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dovrZs1epP2/X5oB/tVwwBEwxUPnPmjzSaCCcHPlb/mg7mG0SpDSTP7fNF1h?=
 =?us-ascii?Q?TinO22KYajDrbWIkjXW2VGda4qxarJ9jfgAvrx7i7LXxkiYG5xxIkLm3BeDk?=
 =?us-ascii?Q?T2fHEnd2JaYw8w9z1uuRjlo+tUIhNkP5aMV5qMQMjh1o/1MQeV06QHjNjgRe?=
 =?us-ascii?Q?+IanC//OMqwKmlDyKFYA3MrXAZqZGyZbBSQ96p4a4y3G4+6FTdBocCjcj8ss?=
 =?us-ascii?Q?g6YZhA499R4Nz5ATGiq25jIgbHrBpi3HPOXV8c1dLyqM07TJ7JwioTgRfMtp?=
 =?us-ascii?Q?uPQby8kNZQIO/77IiJy0ZUyPuZyg7couMhHYTVkwjMfgJPEk895zibbfE/sL?=
 =?us-ascii?Q?o6sWau4GqnzR04yzABf0UZZt/eFa+BXqm/v+K876OkJ+n6sQDQfAYUTfPFuu?=
 =?us-ascii?Q?w2ZG0TFFQXW0LxlA01JlTOCu7MPCrZn3SYLo2oUZz7157JsWqlsdOc1mqARA?=
 =?us-ascii?Q?ISBOHR6jr9RtPXRupYF+47suLpDNI2QnhT+Gx0/K8CuOcusa90FX/6c8+BNB?=
 =?us-ascii?Q?TpBDC0KHQEeHba3O/HxgzKuS21ZnwDDcyh6920jjmCKjuuWRTrliMZ6IZpbI?=
 =?us-ascii?Q?rSpS8FlS53ME7qGzv1WBABL9o1UjG51kPUYX6xyNZQk3pc/9NRKI6uHBTGDJ?=
 =?us-ascii?Q?QZSlTPcUNRF/6JRB7x/37HTztDqsQxa5i95UKCOC7kjj9Uv7X4W2tUUFImIk?=
 =?us-ascii?Q?l2T3Joe1zoqgupLJqgCGmk8hzQShGek3YB91paJaO5BVbHY8PBX6lqep2ozM?=
 =?us-ascii?Q?jd08e7fLdjmE5CRDQ7VSa8AkFLJlg02xkXOwIj+LI+ahg5zyw/uH7USLOflu?=
 =?us-ascii?Q?vaygGEHNwznOK+1YYSELPOIik9Eflj8NLyxvZ1Tm00jRdsPQsRGJ4Dgp1TDn?=
 =?us-ascii?Q?/50S4vgdTBQcqqfXJC3zii0GBpZM92NUqwtnrjumQXTnRahJQQj6AflLxCAm?=
 =?us-ascii?Q?wFIGWGhxg3E4YOQyHQFksBIluuXzaj5QBx4XSB9E+lJQKCFz1mZjutsxOUU8?=
 =?us-ascii?Q?t8vWj8juyaaAE/lq5Rcv1QEukw3ftFIQmbnvdDWvhdiX4FsnmhDuryH7x/PA?=
 =?us-ascii?Q?dbOin+o36Lt4tsFSrrqDz8x6eEAtBTC1jc6qVTed95vHYamoziDM53MtnPzZ?=
 =?us-ascii?Q?mw6/CljTNe4G9FHyTzLy7JcWOqi61A3RGxfdV2sdpZlHDV9Ha/4IbufuQi+T?=
 =?us-ascii?Q?7w4Gmr1vZKqkeoy5+T40sdvYVkn7nNhMDRq4ZVdWJk08eEtofco/OabfuSWl?=
 =?us-ascii?Q?Y/bT9SR3yWi1T4M2OXuqYxlYkkT7s2OsSeA99keU9gQrx1CXsOdPOyihWfIU?=
 =?us-ascii?Q?05cJmrw7Z2gmIX7QKWeqJzEDJDlDo0X0Hn01Gk04YA/2MJ18wP7MYESGDgPz?=
 =?us-ascii?Q?SjYvEHgc2POblNRxHyj2Uu5FeWGF7f+D4ISI9k+iVRSkewV4RyrZiuIkDMRt?=
 =?us-ascii?Q?r+3kZjtn3x4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LM0Q3OY7GpaoN580nhQBBqibTyrZcBtZ92TzFXBjmvUZJP2Qz7gcL4mdAIDi?=
 =?us-ascii?Q?vSQTvczU0GaAStdxSybBpMWoGS58xTqYE6bKfpAN7k/RoxofDRyGAFWm70jM?=
 =?us-ascii?Q?I47jnNwr17Cj+TFYxwZAsYPJaqScuBkCj2fDI9GfW8fLFxFXkWJdWR22JtLr?=
 =?us-ascii?Q?/apZTkSxvDnWUnpRMjJ6O8R/svsvh8Br5oqbPIE9dwnlaVjeNwmBsR2bduRf?=
 =?us-ascii?Q?elsA/oN3mjE86Meq9PTKBhcgHpVppGBM1mCq6azQMDKwEvFLOmBkcx+wAn5b?=
 =?us-ascii?Q?D6+awlX5cT8ojAu/6GwJgzjIa7nYL5J3tboD67i28tAeeMBj2Vo1BpDBq82A?=
 =?us-ascii?Q?X49v7NEj1VlRJcS/x+/ze/TUTbAFrRbM5khInJVBdVFyYyRQ4rfc7jHuR7nK?=
 =?us-ascii?Q?Ne8iz/hrjxsqZvgas8k88kizCTPZASIGjHA5Ss4Qdcegb4Gpt/xKpq1cobzw?=
 =?us-ascii?Q?6fW4xWvGGgWQfdcCPvf0PFpKursMnZRz9TteplZ08CnkyqE/UlyJU9VFc56d?=
 =?us-ascii?Q?ehJfrct1Se5vsYa3iJe8k2ACBdaoA7O/1DpEBjLxcyeL444IQFwJcoJYzEHN?=
 =?us-ascii?Q?GHXij/NLP6PLZvJ1CiGg3bh4PIBKNDYzp6L/y0AbNbP20XSo9wJR0MjlmhxJ?=
 =?us-ascii?Q?VZZ9LnOofel7M0R3wN+yiuuBBHnd9uOUdahTaQcHYi5wqtW28p+QG0BP3V+J?=
 =?us-ascii?Q?soMBV4ig4B/+uPFKUToBOcCCHHncZBHs0le5wpX+iIeNvtI3zd4az4Nh2II4?=
 =?us-ascii?Q?emfftXyvyBgGzBXr45bKnoQWetpdo7Vwr666EVHfHPVs6GWQZdyMaolzvx3i?=
 =?us-ascii?Q?4tt3qN1zyfJ5QmAiiuUVlWnyskb3AR4QR5TFxtPOcogOO0mKumIARNqW1K0Z?=
 =?us-ascii?Q?xIdBz9Tgufcr083qTXaXQxhboc5hG9Ez77PSRiskiQ63UJBx/GLT7yudz1RO?=
 =?us-ascii?Q?2z2M/eYhb6iLqdCiYfM/RRUBfJ0ZmzxH3osmJh7JMEdAJreR20HC0ZaKRuol?=
 =?us-ascii?Q?iC+rJfWZSxL6Xpmsj43ALx4rz7bTSBsfScT3pLIABUhT1N1ZEXOHiqi1vm6J?=
 =?us-ascii?Q?an1MHq8iXo/kQP6yde5ZPCrkcaG1to6ZNpaWFnHb0byEPaqu6/HR3E3ZSfkr?=
 =?us-ascii?Q?ty3PN7gbUUhJe0wjdoiiiNSnSktU3czlYw/myxICupI949Rk5/e3l58hE5sY?=
 =?us-ascii?Q?eRv4vpowVpqpCXUnM84g163CLTzffCxG+UYj9mOba0zAcI8eY19qer7MK02W?=
 =?us-ascii?Q?GecX+3HwLCvXAOuVuOS+IGYtZiWokqkoSySN14XRu2Gus9yU5JdKgiWI3Ugh?=
 =?us-ascii?Q?TWHbvBAnzYn1P0NPr+yz9XikM+hJ5fexzeTS9D93FzTgLjyTf+jgXylfmekk?=
 =?us-ascii?Q?+iYIweewmHqHuWN1KY9fghuKxbfT1AMxqCbDpFIwXs1GDjVC4X8f2DKJfzBF?=
 =?us-ascii?Q?GAizU1YCWUsBwWBVcjKjv/92OLwuWcowST6baVXcr6FHPEONJwcNwWW5fyrJ?=
 =?us-ascii?Q?MKx0CGsrfhbkmqBdVekLRAoEa4RDqISAr1QdVOSpP/XzXo0xc0VEbs0I5mds?=
 =?us-ascii?Q?T/4D9uHFmR8eA7GKjL6e7NCrNo45lJEOy+VwZ6YaXmc8xgSeU/XD4zEJ8vpv?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IeopUG4DCCg+izhfGVvEfwusC/t52kJWTNxcT8bVBk6waOdh5OJMkwQP8fj1UcKaDTbQcWrZLYoiPnMdWmXkoHOgmfZ+mz14VF8FLvXPgf3eOmuXdIhAfv4ONkHkTmEE7RRoKlgcFy2DmBZlNK+WSs7Al4O149zU6IN/2gfKTbQeQRMWM4zlkuahCPzqYeYBrj62keLM8cdiEGlffaDrOIyPgTdseghXPBLgByit9WEpo0sRuVvLQ6/K9aiAthwaJYJJe5NOj0vbRq4dfs5t0fQv8gOmYxdcsC6JX/T/rkNwyVyannqn+AAyHxNc/DL6Ei6G07rKo6is6o1qps0GOvfCqOWIE73hOwnV0R14vDxWsFW84zL9KD6bGQ4WgHeKKuqhwpqcmRDPuG1MLuwX+8DlG4OADITTRWmcHYMvCfO2iwxltsDQ34l9YBk4e4hRxhTnL1Y34z+f8SPbrxtoSp8OY2XMLHLPD2H3bQfCcAbfbWD8wQFCjj1+QNSAlTocdhwDS1vL28SsVufevn2WTlW7BMKjW1QEEBTJF/FgnKmhbY6bDmdsXu11fVj7y5ZgmzKCEIVzlG6O9jAVotbRV37lU+8Qa1clTyM7k89qgwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b0a799-dbd2-49d4-506c-08ddf457fda7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:01:31.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++Y1bMBCZC4b5CvZ3w0Wv4HdPd9aqn2WJGxh7YU6RFG+RLELl44ATbMBEtTme0Y4nVojH2LYCE1eFc4gBouD3g2qZPlKe8Kwuu9V0uWfTDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=906 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150123
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c80e32 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=RGcR6wvab_-L8bjMU00A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 5_DFZOmI72l_ZcnSL_K_wTBxQ9UWpWcO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfX/5Yv4Rj9v+4j
 8gFJlZdPNxlKNEa5na8gNs8fgCzrVkeow9iL3AImVsJfpfnVynWxrc6K1xMYLY+mp/QC4Jn2gSN
 pD03SygxNCU87KIOax9k/cw3k24VDGcgDFYFIH87QYi4ha2gFyByD/BgCo/F7BNi2cuCIQmWT3W
 EMuaH4hfcGtGuPdor4V4Z5OdEI3LQih7srkSYQY8e29k69L4sheAZ3Qn5iWA1qCVDiSTnobG1q+
 LaiIU/adVdll9tYagF8qShQ087Dp3CAurSrKEHW0nJ32Ovhw5MutDTIwVGzqvclsBcI7kmpmADf
 pTFj0MxmnbVklynKHEeVIWUiYv8IhxsmN79HdcCI45+GaGWWhgNRSxIp2qsAK01b2ShMUNEs7t4
 clWLZoYi
X-Proofpoint-GUID: 5_DFZOmI72l_ZcnSL_K_wTBxQ9UWpWcO

On Mon, Sep 15, 2025 at 09:48:01AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 01:43:50PM +0100, Lorenzo Stoakes wrote:
> > > > +	if (kcov->area == NULL || desc->pgoff != 0 ||
> > > > +	    vma_desc_size(desc) != size) {
> > >
> > > IMHO these range checks should be cleaned up into a helper:
> > >
> > > /* Returns true if the VMA falls within starting_pgoff to
> > >      starting_pgoff + ROUND_DOWN(length_bytes, PAGE_SIZE))
> > >    Is careful to avoid any arithmetic overflow.
> > >  */
> >
> > Right, but I can't refactor every driver I touch, it's not really tractable. I'd
> > like to get this change done before I retire :)
>
> I don't think it is a big deal, and these helpers should be part of
> the new api. You are reading and touching anyhow.

x ~230 becomes a big deal.

>
> > > If anything the action should be called mmap_action_vmalloc_user() to
> > > match how the memory was allocated instead of open coding something.
> >
> > Again we're getting into the same issue - my workload doesn't really permit
> > me to refactor every user of .mmap beyond converting sensibly to the new
> > scheme.
>
> If you are adding this explicit action concept then it should be a
> sane set of actions. Using a mixed map action to insert a vmalloc_user
> is not a reasonable thing to do.

Right I'm obviously intending there to be a sane interface.

And there are users who use mixed map to insert actual mixed map pages, so
having an interface for _that_ isn't crazy. So it's not like this is
compromising that.

(I mean an aside is we need to clean up a lot there anyway, it's a mess, but
that's out of scope here.)

>
> Jason

Anwyay, for the sake of getting this series in since you seem adament, I'll
go ahead and refactor in this case. But it's really not reasonable to
expect me to do this in each instance.

I will obviously try my best to ensure the API is as good as it can be, and
adapted to what mmap users need. That bit I am trying to get as right as I
can...

But in each individual driver's case, we have to be pragmatic.

Cheers, Lorenzo


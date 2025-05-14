Return-Path: <linux-fsdevel+bounces-48953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397AAAB671C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514673BD811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE72253E9;
	Wed, 14 May 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vo6mvJO6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VE9RIL1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3F221557;
	Wed, 14 May 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214361; cv=fail; b=u5l19Px1afrAw6tJiOFrGMnjKpVLeoYII6senzCC1s3cCRAIJNtiIuxBOb8v7nHLr5T2CrdKuKhd/ypJqdDl9wB7wbR2rh7BeBtPr+iXRccOaYfsLZ2p8OQ71NbNev8Ju1TK2L/qYT6LbBp0frOoheNZmzMkLy+A+wcr/9VjbjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214361; c=relaxed/simple;
	bh=WWEyF481t8GbeaiQo1o3m1iOBEEcvw66D5LyRbC7inU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T/GkfPQ+sIYWA4Yi8YQbms1cBm0Qk8x2YcRkn/6oAKtfoMJtWV/NGW8lTysGCAPaUZdmF6aJi/Np6srhCWj9n9w1GtT4N13eO2v2yE/Pn5TQiBDAYbruevLu2TmRZ8N3G55MK/2qzOZtff9gunQu+pFDKd5U7oNR6HSuag0WiHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vo6mvJO6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VE9RIL1O; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0ftNx025323;
	Wed, 14 May 2025 09:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gTY3uZHd9zqFLCIOc7
	8veSFWxCWiLdiN7Cgw1wGaveg=; b=Vo6mvJO65Z9wS+YWY8brOvIuFTYRgXRNZo
	tHODkTg5T1pofvbXhdoYfRgOMXtP5X7VKq6HZxjktBIL0J6gBDFZJccFj10d1iWX
	ZwSWjkzJoOWe3gew0DwUJibngK01OfUQCteviy+fR+D1+Mnhvg1vExjOmpXZ/HIs
	YClS0Ycrmx5gxXgIA9gF3IW6pcfvj6zvR23ybWvbbObIVHzVGH5LRX+EEiIt7qlc
	EElmbR5CcPNBu4nTMU0nWQi9qotYCLn6kSjkNRHxrHQI9L9ybmQVeQjj/6olOsI8
	ectMi+LB/VpAr+wsGUz1QmmEo3uKOmQOOdv372RVNINanXFclGww==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchs3w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:19:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E81bip008986;
	Wed, 14 May 2025 09:19:00 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013077.outbound.protection.outlook.com [40.93.6.77])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc6wdncn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 09:19:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8+KjVIVmfJM2O6q2chNJbnOfQ4eiuQG5AJ9JF0PaPJ9EZ4tFPTGbszqvV5xwyw+bx6PQM87vJ53HXpsvBldNoJ2nIPsGfPkI/UbZMB5MN0lIyWOGyCWkdH9ZQeSTRYQW/H1GNVa7Lk3A8xOTOeUkP44jB1CctlDKXfs9Bt2iGtDTu4K4VaEo6JvzNJNR9lAwqhL9iSEygIsSM+XqiZEaEWDTxjR2xG76ESrzQT2nwf3OwA+wUAYz+BZFUOBsaHGLGB1xdEsxyuRJR4/Pw8HrlcprhqWGU5alVbMyLypTVKrdYZlaY0aByixG5lk0lQ8dCwuEP/hPtwu6tzed5df2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTY3uZHd9zqFLCIOc78veSFWxCWiLdiN7Cgw1wGaveg=;
 b=BPQfqjoavbDn70mCNvAfm6C0IVLynqu0e9UlDye/4rlvEcSjajWL5UbKrRliGyCzViSxug5yWCk3PBauTt9+jijss4myoWAVubCcBPNxPhiz/wvnUGknkcaejUbdLuzCeRXLPGXWfnprOJEbUrk8pj0cRQ8w9WADB5Ybzr/QUogFEBgIg+wZBQ+MMWJwhQ+ABxK2ATbak3KeRR2LNo+q65Re/Adl50aPP4uMRkP+KFKIqSygJZhSR7oi3PIqvvjQjsUsmQURGkNOkJ+FHsO/ZQjcVe1JsLtcmWlLMM3QnJaFoqj95toEppFIo2Z1kv2TohqRH4RCJM4nE7VjovnXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTY3uZHd9zqFLCIOc78veSFWxCWiLdiN7Cgw1wGaveg=;
 b=VE9RIL1Ol1FLouuh+q05mmmoBKWXFkc5al5GkKyBNmBecT0CYqx+k3Lut9Ix/lHu/ZfBqrLrISdfdiBDFCg/PfPaux6d7qZgxm31tEXesXPJRpEPNbb/LnatnVsYS4/KxcaSBl3pbYTk44lmwG1knDi+warsJ5NqmJJAeKbplSE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 09:18:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 09:18:57 +0000
Date: Wed, 14 May 2025 10:18:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
Message-ID: <729bc3ef-149b-45d0-aee0-d199050f0122@lucifer.local>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
 <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
 <f7dddb21-25cb-4de4-8c6e-d588dbc8a7c5@lucifer.local>
 <f3d52fe7-991f-4fd1-a326-6e8bfe54ddec@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d52fe7-991f-4fd1-a326-6e8bfe54ddec@redhat.com>
X-ClientProxiedBy: LO4P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3bba1a-9178-4230-5e51-08dd92c85b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qH0Am/Of0u3jKUtgrh+WBcSEouBmbThG2rR+QGl+ppEPWLbQbKUPgbt8tAI?=
 =?us-ascii?Q?XxnM33VZ1ci6DtXm+S4TFLbVq4FSPWl9TJtRWFkyMJhE1ui7uNpxKqR1dsQp?=
 =?us-ascii?Q?xS1Dixx8RrhmVIeAbHBzWXZIM5AQ6ZolUTw2lzGRarLhakFbhFtsfyGjtwl3?=
 =?us-ascii?Q?jULoc+VQQK+ShrxzthLI86FoMBJR+KQ221uZsvdjt6cA4oycSKUYGk0DaVUQ?=
 =?us-ascii?Q?oAwRgWsPJXl3RPoB2P8nkGDCc5RVEFgRq1SaGFmGRWYN4iewNrJO2cwjq3p7?=
 =?us-ascii?Q?+XQQtfBJKy57oawakAfyv28ClZDRF0TpBbaQrNX09zjcXlkX2xQJQ+YKPLzJ?=
 =?us-ascii?Q?z+RpkLGvRMDKzMGARw5wxWovHnZCW5cUWPH34V2jiqyXFYQH5ieCt646CiTB?=
 =?us-ascii?Q?vL/dDfs9dzo0WfnsBsHTZuU2NE7DiumjdRPr2UC690BuINUUb66dBHxrBR51?=
 =?us-ascii?Q?m2g+BtNrTQiIHSc5NnV+j6JokHsosJO75KPLW1LpTVCFE9jBaXi9rfQKtgMw?=
 =?us-ascii?Q?t55ygqy8qY7gpHpfMwku1kQSYnF7TjMYGiOEgwgeh1bsN0zSMKRW3blv9nBK?=
 =?us-ascii?Q?VdTKfeEdBEgBmbp3fP155X0qNfhkYYHgPH/rT6JT/m5LnjzVpZpCb6Uar1qo?=
 =?us-ascii?Q?e58+52VIihJOajulWuRouUEgFGiCjprXjXMIHZvJ3OuFKjOhbk3NpzYO+nEo?=
 =?us-ascii?Q?jl2Q13X9muSEUU1a6YlvphDB59YGm21Kc5cqTY0iYJLasNkYkC9DBwm2AJPT?=
 =?us-ascii?Q?9mYj4QfvL7jiJnCuij2kaUZMuhkgx4NPBp55sQ23kw4h5fGOi9elf/BBKflc?=
 =?us-ascii?Q?YuySMCKTMlzqFeJZe2pDzj2gjeGajYa7X9ZiQgQ8JDL6+3G+pZUlFmAWfvFU?=
 =?us-ascii?Q?ExPl69imjuJcOGaB0OA90WCqT+dCNthqqLtVRM7F+JiIwouXykJ5gW9qoDFN?=
 =?us-ascii?Q?QhUufkWJFfZnj1mWexCOZ70aRf7hLOYsnvKect9PhQsX5svhwLarOts1/HtJ?=
 =?us-ascii?Q?I83xmwyu7EwmaHqrqqDu5OLjxkqHmKj89/vyhyeF4sSD6cEGDgZRDmAVL5cv?=
 =?us-ascii?Q?HP6s6jT4ic/Q2dOvCUYOqzxQ9Nfu1CcUL9bP5q6pv/hqsv93orq2n3AY/9P9?=
 =?us-ascii?Q?RpkGxwE0cuTnJqriHK5CI0Bq0k13eg0ikpVxvWXS4xd0KyQv17NuT76dWALy?=
 =?us-ascii?Q?GNdEbZdzIVU6JPRuVNptX9Ml/j1Br42YfxVmMWW0myFCdDXWAFrtZzUNTHvS?=
 =?us-ascii?Q?BaLD+5WFCmz8RjPDqdqLPda7+lz5FTfKHb2BLitnSuK67FwylJ/mDxO0t3Vj?=
 =?us-ascii?Q?owuiQ3gt0609sJSuvt+wFiKX6epT5+shcFIw3+mU5gZKfnS5jMZHAIxxqCBr?=
 =?us-ascii?Q?/pnCJoNV6GANO3n8R9mSzvVbeaL+1Xg6hEfbw6imnldkFs108Fsghv/LvOso?=
 =?us-ascii?Q?hkUEaVaRe0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IP7PMfrOwQHX3MDQJBIHa1j8O9NrJOyRQ2jMQLJn/m5wmIKi64lZ2dpLINv4?=
 =?us-ascii?Q?CkGGjRn/lc58ppQjPiDD7HVGVNd2EoKM2Wx7BLaQPNdETBCzFpwjqxJ65ah2?=
 =?us-ascii?Q?fDOYNcf9soqZUoYTM8QquYMLyTmhdrMvy4qsSwWEORCN4ebA4v+8GobrwdJO?=
 =?us-ascii?Q?WpGA7/6u6juKz7DeiBn34zqKUIBb/i9RTPCS94Uq/4IpaxaqSfpTjSn9x0wo?=
 =?us-ascii?Q?QXZIZtTqmC7Xiqr2t0OKqOnPA7JfioR0xeicdZEvmOT7ukuofIBBU2iFtBU/?=
 =?us-ascii?Q?qaqdX4EqE8viDJwu0fzXWeRr7V+l14tIG0NeXYLClM8xt7Q2n6QcIJTbf2Yv?=
 =?us-ascii?Q?0aJPjXpoZk5wVxvxWPxdUwhvh2fbnHMYDKKK4f9LUTO9cdq1frnBaYn/c5Ge?=
 =?us-ascii?Q?PzpnwNrskJ6MpF+N68vuwVqUwiRfPgKsvnSrjfEFb7zFoLZOfbGHjon2Ioya?=
 =?us-ascii?Q?0qI1c75fs/g6Xx/VWfPikg7+Uw9XJqnJgprKNnrt0ZqGQr9gR1mxr9nHZA0U?=
 =?us-ascii?Q?SBW4QAt9lqjrNVDEPr/E1FftpqpGGpS9g8SixlvgDP+46sNs7Qi6+0pjZrRf?=
 =?us-ascii?Q?Sm2QriPZRBh27Gh25GpsktUJvsAjfxBhaefn1CUKRwqlP22AQBc26twcfYwl?=
 =?us-ascii?Q?C1T5quDjbHY7SPIPSVzSYcL/mtzB2nPAApPiu3F7Xu03aSCg2JuE0tjsmEnY?=
 =?us-ascii?Q?o0YXSZeGb+8UcQ+SiEElh5YEE+kk99Ubz+4uvjQegb4c3q5WnjYdCw1SRYdO?=
 =?us-ascii?Q?1FHah8VxO/+jtUlH/9w72ScH5VZv4/9H7Cfmx6LH9G9pYodhjQm9FFw60KwN?=
 =?us-ascii?Q?jLudfTgmadHx/C2CbL8a+T+ezETsJ8PvlTXS4w1oDRok2dn9k2vcO6KF4cdU?=
 =?us-ascii?Q?7Q93p8niTVk5U7R0aNg8ttseV8EpeQd9P1a9P+ZS/4TKFFBd21/rD7Ems3rd?=
 =?us-ascii?Q?/vBpuKE9WELpOMAGfkbcPvOkFJLpEhjk2slf5+n5HDcZyjhP2xMKq/VTHfCo?=
 =?us-ascii?Q?02uRmE1YOxsYJr2w79NsjC7MfKy+9bW1e1FDrHmB/W1HA51tCYhwnqKW+Ot1?=
 =?us-ascii?Q?3z98WcX/MTP2R4CmePFdzLPxBHQKCYaWzT1mjYPZjLhHR2tEH+HvHFwGYbSY?=
 =?us-ascii?Q?+Zmgk71IvO3fX7kj1p+jUUP78r12lNqMJxgOrdeSuVJrcK9dUEM4sEBOuccY?=
 =?us-ascii?Q?WxD9IVMTY8rKE0E5GTNSmOGNCY1qxY8SkS4ohWIl6GEu0IpL3ikRvT9lXqbs?=
 =?us-ascii?Q?JU5g811ZRzGaOjLTll2dacOfUYnvydyGk1btDK6SP8ERwRjsOU6lAgsUABmP?=
 =?us-ascii?Q?qSBHx5u57m/ietLB+KA/oAGAsoNpZ/ikn4xW797CL6U2oQ8GJ2oAuStuCHW4?=
 =?us-ascii?Q?cDVfmg09fJDokEAehIEFglPI+O8WmRcBYzdYbzY8CnVdFwBQaoR25C6RDL2u?=
 =?us-ascii?Q?lesmGcZ39m/U+eHAhi1nbEHGjsS2377ihCk2haycm+2dT8/yxcm/Ja8JRHCS?=
 =?us-ascii?Q?FvtVWVJlBPwIpbiDBvg+NNOUlsjpXdtN+jcYL6BFB6ZV3Lp3qSPYI1NW6gfq?=
 =?us-ascii?Q?XMlqQjEjcFY676dGzs/C/vvSlibvYjEfGkVIdCHVFqDFoYQ89Ax082wdpO9x?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KcB5JhqEwzGBS5aJ0+ofNenD+sMNDGN/ARoMASDBXm288dXqsyyx4ak294xl6nTfXjg9bu8VKIyIy6318vNerBvwJgSFRXoIeA3t1DrbuYLYswbGk7KjY42I8KjhYePiHn2DAJF9KfheB1rE9X+s0vxV65KKGdjI1jUZRh9YbBzkLTjPA95dtrxmUlvmrn1aS8L/mGQmR2oefuqr/sdp1+n2SjJLNjUgXZwI4cEohV+p6i8nLanvuwM41j+7Hgrr57ZaUF0ssDFQ6c9IPzOFjIkQRD3v/zFtYwFZO+66Pbgfun9BcJIYkRca6I5YR4agMq84gomoAaRdMsqw3epMLHBsozsdOiTJbKu+QhW8hD82ig+ysn4L8ecvI5D3QLB7q5qAFVkXolisR2frtL3Sxt+A4k0zLrRsZaqr3cRXfDbzup6cwkI0jBMWsPxMOqXWYC47ZjM0M29zmetMzIRHqnyHrE0F3uJkKOTJxikobMHmZViPSP5CIVJ0w14H2IncxVAyd2beeUbgPwqRkcBQCYmmc8/4BNxeN6LT4/3BaSo40nCj4Y9loduNsq90+f4M3d8rcqqV7nzPuDPdDFh2QufiTeLaaYmzXMTdDUnX3sA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3bba1a-9178-4230-5e51-08dd92c85b24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 09:18:57.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3V6Rp4yv4gyx21DnIZeI7WHJaS5lv8VWJVtauj+JK8m2ntzr8lMxN0eJutGvXXpAEiGsObeJaohkJgt3h6EPKwGJBRrYUJiYe5+IbgtLSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA4MSBTYWx0ZWRfXx5XEtN1HNhRE w+MW8iJsMvohP3ss7LJtOCY5K2S59/PNA4AwdDTonzx9rt76yd+mjxrjF6hJ01XhdgnVoffwUB9 Dnq4CAPzLoJ5KoiYagLrhA5oVofhynvKOYtsCDO6YTJXMhIPznpHCpTAc2LUcNX+F+4v8ThAHRR
 FcE5poIw6d3iHwsdGoBvZ1HqjOSnAi9NEav2H8P8AYZ1DLZGvGxupR9FROtwT8NBInrpLxgACMu GuzRoFkPOvoMPue+u24STQKIsYZ9jPdkivhs3R528hSexys+YVbnoOJ6jBQfYIGOVw5bfURuffH +mAAl//a1DOZJ9P99dUtLAUXaKBftGPaZ8t7urgL5gMc9LVeQcYCB6pe+Wsq4NnMwvXA4JZ5f1W
 40iW4eFbqVmHnAPYrwRroohLbuVdOZRJOgrtAbnifRq2OdIEV39qXTCnVSHmmfgokIsRs5hw
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=68246005 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=m5yy6awJMB4RzWcAyWoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: LYzln788VnzKquAZiM7ej_Q6CxI5WK3c
X-Proofpoint-GUID: LYzln788VnzKquAZiM7ej_Q6CxI5WK3c

On Wed, May 14, 2025 at 11:10:15AM +0200, David Hildenbrand wrote:
> On 14.05.25 10:56, Lorenzo Stoakes wrote:
> > On Wed, May 14, 2025 at 10:49:57AM +0200, David Hildenbrand wrote:
> > > On 14.05.25 10:40, Lorenzo Stoakes wrote:
> > > > Having encountered a trinity report in linux-next (Linked in the 'Closes'
> > > > tag) it appears that there are legitimate situations where a file-backed
> > > > mapping can be acquired but no file->f_op->mmap or file->f_op->mmap_prepare
> > > > is set, at which point do_mmap() should simply error out with -ENODEV.
> > > >
> > > > Since previously we did not warn in this scenario and it appears we rely
> > > > upon this, restore this situation, while retaining a WARN_ON_ONCE() for the
> > > > case where both are set, which is absolutely incorrect and must be
> > > > addressed and thus always requires a warning.
> > > >
> > > > If further work is required to chase down precisely what is causing this,
> > > > then we can later restore this, but it makes no sense to hold up this
> > > > series to do so, as this is existing and apparently expected behaviour.
> > > >
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >
> > > > Andrew -
> > > >
> > > > Since this series is in mm-stable we should take this fix there asap (and
> > > > certainly get it to -next to fix any further error reports). I didn't know
> > > > whether it was best for it to be a fix-patch or not, so have sent
> > > > separately so you can best determine what to do with it :)
> > >
> > > A couple more days in mm-unstable probably wouldn't have hurt here,
> > > especially given that I recall reviewing + seeing review yesterday?
> > >
> >
> > We're coming close to end of cycle, and the review commentary is essentially
> > style stuff or follow up stuff, and also the series has a ton of tags now, so I
> > - respectfully (you know I love you man :>) - disagree with this assessment :)
> >
> > This situation that arose here is just extremely weird, there's really no reason
> > anybody should rely on this scenario (yes we should probably try and chase this
> > down actually, perhaps though a driver somehow sets f_op->mmap to NULL somewhere
> > in some situation?)
> >
> > So I think this (easily fixed) situation doesn't argue _too_ much against that
> > :)
>
> Again, I am talking about a couple more days, not weeks or months ;)
>
> At least looking at the report it sounds like something the test bots would
> usually find given a bit more time on -next. I might be wrong.
>
> next-20250500 had the old version without WARN
>
> next-20250512 had the new version  with WARN
>
> So the new version has been in -next (looks at calendar) .... for a short
> time.

Right, but nobody expected such a trivial change to be a problem.

However, having spoken to Pedro off-list, it's really obvious this could
happen, by trying to mmap() literally any file that's not un-mmap()-able, I
guess we all of us brain farted on this... :)

I'm keen for this to land for the next cycle, as I have a ton of follow up
work to do, and delaying that by a couple months would be deeply painful.

But sure a couple days would have been fine... :)

As hinted at at LSF, I'm in favour of a highly formulaic approach to all
this 'do X, get Y', so an amount of time in mm-unstable etc. could be part
of that.

Not that I'm saying we should replace Andrew with a script :P (sorry
Andrew!!) but that you know if he were script-like, then everything would
be super clear.

Of course you get endless edge cases that require a non-script entity to be
involved but in any case... :)

>
> >
> > But I take your point obviously!
> >
> > > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
> >
> > Is it worth having a fixes tag for something not upstream? This is why I
> > excluded that. I feel like it's maybe more misleading when the commit hashes are
> > ephemeral in a certain branch?
>
> mm-stable is supposed to have stable commit ids (unless Andrew rebases), so
> we usually use Fixes tags.

OK wasn't aware of this, this is the information I was missing here thanks!

>
> --
> Cheers,
>
> David / dhildenb
>


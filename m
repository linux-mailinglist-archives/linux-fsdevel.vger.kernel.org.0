Return-Path: <linux-fsdevel+bounces-53436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC02AEF112
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6088D3AD75A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471C426A1DD;
	Tue,  1 Jul 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MSriR81f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gdghPsTk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6434A0C;
	Tue,  1 Jul 2025 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358548; cv=fail; b=SvLjiWLScGYaWrHmW5kn31tMq0Q44z8F06dEF832XJaAKE2fvNvuLzJNPPPalJeJ1/DeQu/R+izlJj8FoL9MeWQsHK/Bu4YOngn2yFR2yUOAWLunvESzJi3t1w3JgEMPy6NaCsi9o39irPb8QkWHtONlHy3Nm88CinyeiomNKMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358548; c=relaxed/simple;
	bh=y/QZi3VLNExGx6avMD3A56YodxdPyd7lA6vTf0SJjU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ghk4igDofKtR41F7+LZpfNLsIO6xTOsOn4hwDUhXnzSLcyHul1TGgI4DktzU9c/+VIFSOdt/hKc3tZ48wwhtdOxOFfLRHrXCUCXB4g7S9ChjjR2mmw9VMrPgCcxj4zc6eStCE5Bzq7QMnl9P0TqvfAKw6vaQIuQNvwwdz3NUJew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MSriR81f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gdghPsTk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611NMaP008674;
	Tue, 1 Jul 2025 08:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MF1AjfNQphjz+QNrMg
	mfceDJ2F67r1Vngl7oW7eGujA=; b=MSriR81f2tflUL0P+3K84mBfnYa93w2QJA
	s7ltD0uq7SjEWuAAb/kQpPXQU6Uw4BIDCsVda8jkYic2F9c3MhgivZrImkcV24IZ
	S9PS9tUgYGNQaXq95IGBRKUgggmoEKXjhkR6UWOS8EVL6LSgog4GZ7mqajYR2hyi
	8wq9gSdrUf/lDcK5jfjD2K8I2qgcXMFgyTJ93EYpN9+m42EhFhAOQAsRCoFCB+7L
	gfUhekOuBiXOGfWG8ndcPzKWXtlkKS98EXXeuxBQI1Ff7R75qrDI+/UAHrjOxEFG
	Vi8lhMuYPV6ZzQINwcoAelAAicOervEOX+WTMCb8WbCwemaVoC1g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx45p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:27:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5617KuTl025965;
	Tue, 1 Jul 2025 08:27:32 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9esum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:27:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqnu08PdkqoaXQzyHnJBYL0VKuFd85qlUDbqYKGtWftCMlbdJPVRX5M2tatUycIDvxrykmEoYxMTM8D7kFhyeTOqsJOqHlqBqLR5Jt87SxaxYQHqEK7/dGhdgeEJMBFBhs8uQJvAA5Ccpp4ObR7enupjic9VvPmlKzgLehPImAdo/viwFEo9EJ2dWMbZUpBwEJ9JDxalj3RTpRx/UBohr5k93EknGl2Tjtc7DQEKvQ6CfWjNuS1ImiKjms7yZnwUPM0eHH0FMxFTbxJeRI0dwMmA221A7xiLupclda9TtoJUJs/76WnSXupAckUy9gxG33382FFc1v1z336ak/rLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MF1AjfNQphjz+QNrMgmfceDJ2F67r1Vngl7oW7eGujA=;
 b=fjpGOzx2fedddKy+n3sauZK0BIR6gAuMUdH136RKche8qM7Kt3uUGfchCAmJOXbQ2e3ad4K4CTAHcI6sj2eeCuULQQR/LNEtnttrTytqMNWKcB8fNGPRwWVZkrpHAHpu21sD/zCd6KDfBJkEhxIj8PgVapAQ+TFwh/0+EZF5opFRz+CB2lm9LUEV7pvwkms4+x8E/+uOJnuzgMG98OP0fP6d9n2GY3sqbJdjpik7JYPMQb0PdNwZ6itSV3wK4lgSWoaGv2/HBzWCwuTSoEj22pNt8risVEU78NHnHrd98rGiQuTZBLh3mkbX5QGqo1Nn/c0vsctklFgtMUgmBigbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MF1AjfNQphjz+QNrMgmfceDJ2F67r1Vngl7oW7eGujA=;
 b=gdghPsTku4tYKFBY8Z17UZEvowogENbYPHpHdKrOy+A8FHjv4D6E8Wf7AO6pTkTXDtCKF0UX5/M2mq1l5WmMgePUsQ7ptbjZs8l/S6QBSbhYor5ByjMVyGRBJrapNI41AB6dy78DmE6JgSKZriHAWbnYsiQVK7S1Gzb+mn1hZeM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 08:27:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 08:27:28 +0000
Date: Tue, 1 Jul 2025 09:27:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 04/29] mm/page_alloc: let page freeing clear any set
 page type
Message-ID: <06e260cf-9b63-4d7c-809c-a9f2cda58939@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-5-david@redhat.com>
 <8c5392d6-372c-4d5d-8446-6af48fba4548@lucifer.local>
 <d4d8b891-008d-4cbc-950f-2e44c4445904@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d8b891-008d-4cbc-950f-2e44c4445904@redhat.com>
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff90c3c-12d5-4e91-85e7-08ddb8791db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCcxHlM+uxVlafVHgaATkU0KPJ5rgkiXRrSq6b3dG0l0n5pmdaT8q+2zPoRz?=
 =?us-ascii?Q?7RCfdBwkg/b2XYu6sFYTBiqN1EJG5xBfB5pKjOCPRYN/g9rQ4xlV04CceD1o?=
 =?us-ascii?Q?BHoTcRCwJj/zFJ9Ourl8NE7qFJfKSUALlKkXSga4dI6ZHCy+xs/6UcYHq2Oa?=
 =?us-ascii?Q?a8QsO9j7uRBzAqEpxRHU/wYyF7dmMIc37EBaGJQCzx/xyliTkfkjdu8Cwu8O?=
 =?us-ascii?Q?MhlRNGppqBhEfFwnwM6+OtKiouyZs6dWiWsta0q1Rb+vEHjN5v0wl0ybkoDO?=
 =?us-ascii?Q?CsNk9R7Y1ukiIj6RC4AwGq6wZymP35xVliWtQBh5ChteJPP3nKRD+FCMxCIT?=
 =?us-ascii?Q?ooRIXJbFxfkjZtGYKoQL6qS2v5EBP7orLMhLXK1vKj47DivhiCJl4KS83Xhh?=
 =?us-ascii?Q?i7uoK6Iv+vBPAdVjUi4TbcSAg6FjRsQXtq7mcyN3x2joIX4s0izt+dscKzIy?=
 =?us-ascii?Q?M24HEm1xh6zuUPkLtWYP7oE6d07UCAfJ6C30bBfdjR1WXW/4G92DP7nC+Dze?=
 =?us-ascii?Q?2BQ7xq/wCzwM62g65CPRUYe+09rT8dFbM7alsC7F9ruaT45hRztAD6UkuKqf?=
 =?us-ascii?Q?tiMJnbo8ug+fcfp8PtGLECfrwpIRAFbDQ0X4NpZwlDUG4BooDj0/7alIyysl?=
 =?us-ascii?Q?bOrqSc6pBlwqfzJBee4mfBDyE5vo1wPlLSXFeWWQP8HZ0nkFjkCZkdmAk6Iq?=
 =?us-ascii?Q?GAG9vPDQSalMRfz6jNZsm/RJ7Y4tUFsfDEHoAe90Ku+/MpWNdhtnHOC+phMC?=
 =?us-ascii?Q?pFyVXyhTBXRUM2hjEq9tLMcC9nh47IAvosflze8e/zbsQvnPAVShI/R8nouJ?=
 =?us-ascii?Q?ha75S8FW2O827zGMbwfuaQDhEB/Zrq9cqqan4Zn/BJNm3H8Iv7es/XJdcXe4?=
 =?us-ascii?Q?5csVnkoEwQQteL5+CtPkmcG8sz29sQ3LnIBmG3hzGw7Luby7FD87hpH23Uqo?=
 =?us-ascii?Q?ZfSSuhYJK3bW/sfDC5rG9xfVrYxO7fZCaKzaQ45ey8IjNiuxI8iH/gHr7+Pj?=
 =?us-ascii?Q?ktJubtWKE4S+ZGW3t4eby8YIBdRuu7UTtUbo9v4fP2Djcleo5gPzNyKKUz02?=
 =?us-ascii?Q?K3e5n1ROtG6m0egE9RRsMrKKH619HLnnwMnZ16XmxtNEFfypfCj9rDp6Gu3q?=
 =?us-ascii?Q?dfvLG/YWJwWyeK98usMlFUzpDP89mIIM7oSJHcoJeHvCn2zoJJABNY/JwI64?=
 =?us-ascii?Q?9Pv5z7Mgz92ILYOp1aH2MSNAGA4Gx7VcpQlANqAH9dPdEtu7PQ4xsVuI0IcX?=
 =?us-ascii?Q?L/mEPwQ9SrHpuwrXkQ6NIOJZPb927ul3r5Cg58wB5cGLJWNN5X1EjFB8M8tz?=
 =?us-ascii?Q?VVVwfm/8sXm7y5oszc+ns6JznyXgZNCL1dcy+2JAeAVBZWyRw56v+uVm+Dev?=
 =?us-ascii?Q?BKvYj1AJnsu/8TMgL1X/hel4A1uRYFXCaPvQSdSBPwOdApNBfgLmPQg7+rz7?=
 =?us-ascii?Q?yZffGS1cFmA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTeaXtbr8B78N61eHgraLXBAzllBjKFO/xoZolA4aqmyXmtyIXaMCJJnMqhB?=
 =?us-ascii?Q?eiCjpOBuQDIpZfLG0OP1+9cKYhKZiA3EBHP/pn2Tf0qddKUyR1aGirEPBn3X?=
 =?us-ascii?Q?g1lEWLaJY4FPnbHjZlp4+AOoSSA54GG1CTFAkVRxJNoZzskTZ7j+pz8Bhx41?=
 =?us-ascii?Q?QcLfEPJ0CrZXVcOAX07llpQOf/PGYTe/aNEhWG/VKWoPV7LaP+CB/av1aIaT?=
 =?us-ascii?Q?+OWkItPzfm+k5qbRlsy5ihN+uUHuXk/ACMPwTqsROoYJlqkx23aIfN1iRzue?=
 =?us-ascii?Q?scmPVSp6Yj/u8p6A/a9XMqvgKMbg4iV+lCA1OnbuGhvYDjPaffZ6Bw3svQno?=
 =?us-ascii?Q?7diKg5HXyGEp5+bijo/vqbIDy2MKGB9O8jTq2v1ELRVt5k4vRLyJ7O/8qXLb?=
 =?us-ascii?Q?4C06yK/Mwb8cpgF8LrTfw3MuXwcS/c3RZ7ZhgTesu/zq5Dvep/CCjwjZ56B+?=
 =?us-ascii?Q?PoxwrJbQg8G6aZ1P1sGOI0JLdX31irvsN7P8TNfQyZYNGU+WXxxB3XZHytM6?=
 =?us-ascii?Q?DfF1LSE0CnR9MRSsk7EAk+vTeQK0Z5ePU53bX0MNii8E+WA1+RI6Amb2wOfA?=
 =?us-ascii?Q?Q7klT3VotYXhsOFsBv41/3JvP2pdLrWltsrvlmLl+ESu5YAGFTiq71iRQA14?=
 =?us-ascii?Q?d1/ivhpzq3EjvjQtqWhIv/ChY1S8EHtWCjHC14G07uUUOASw6/4oX1kW8yZT?=
 =?us-ascii?Q?MbAtVHsx2FtqCVmaJ+HzOtMgOka4NR+PliUasSz8YKRNU9bUxIEzKFhXVX1e?=
 =?us-ascii?Q?FLAkBTzjQ4BoYMONJL5v0ZpiEk6cVyCLIlOMtRCYjtj/SttffUtqRfveZQx3?=
 =?us-ascii?Q?Xf2xLpxT/RWjatQO3SunkkYqoe1k0TPxkUWSWxKUgofzZjChEkbMuT/qsOBi?=
 =?us-ascii?Q?Ybp+oB5W3/5i1GKU4yU9rZ6Qf03N2camOE5t8UEPPQOJ33Q4QfZXIrzdpii9?=
 =?us-ascii?Q?cg8CllY3ahvWRBM8wCFYZBgRxsjMOM02VrfZv6tSVXlee2izX2wswi5X8+xg?=
 =?us-ascii?Q?s6rqH28JbC+5/yIGbePQFEPmY+DYdhcso7phjgDvJqmrTyY5TuKZ3SrynMdX?=
 =?us-ascii?Q?Xl5oAhId20160X6hpiuFiurdUCj81lfYCgBKpFpm+sAc2dJcA0HCxEsKQLLW?=
 =?us-ascii?Q?kgZvS1MAol27gDEUQncHGJnqwCSDqlwih7DVjXGUlrrLMdU94RzmYSrpXtyT?=
 =?us-ascii?Q?ayEBAylPV22fXQPGpx1YTsayekbDoxOc8ipbjYLf+CgKCzmkxnGwS7OS0rNT?=
 =?us-ascii?Q?SGGw3zbFaSrIliBYdf9yfuNB5LhlDKrLWZWNGOGjzQnyi7K6tEOZijvWaAZ3?=
 =?us-ascii?Q?n3yL5nnpoK1hgDg/UsqB9RVVuZ9P3wIM44ckPx7StS8ptFWvHmZyQDwxQjKB?=
 =?us-ascii?Q?Ej8Y4fPcpyVcu2wHe2QxYUAmtlqndgPt6MORB0DI+hiqlSaZMtAKILEXnCOR?=
 =?us-ascii?Q?hsAk5/YjftyPhUCgxb99g74AAMa34HudzCZvET1gtK9WtY0HVzfyvzkA02Zb?=
 =?us-ascii?Q?79Dh4fu1WbDMRS1eemkzHbAI8Ee5DaXMCHCjH6SdbR+pFMkKyLt4Fp1Ifdpx?=
 =?us-ascii?Q?GJz8whXYY6EhdKVxEG6LBhMsj8JuR2RCfJ7ZTVVlwQufDcWDoQqHN3A71aFF?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JCaI6UG2+T9UiKrhH9TIA73tBj8rDrntUug5b7t5QW2AhCnJKVPw6b7t6NzicpjRPow5mYYgH+ZoZ6cRQJ8B4KxM2PbveK3QakHZVSXwjk5oP/PrazooAKni/2M11V9nxKuQEloBwEiUZUisRYG4hznVqvMmtbCccI8kD2HjpzHyTgmeIl4/DKJ6fYm5R/ybCdCTshoag6woJt9+pThB2gA+Q+crBaub8CERYs7VcsFHZ/FkLNtnAkmSkFw6DBsZyJtOHX2Iv1iuwQrwVlBA1nWHpA1aaJHuIg72P0YzZm6pGoIIvudrEJXhvJdQTTSr0KTyMddmUPXmXaFPSllE4Z7J5K+0deYz4EdY8fjbcu5p5mgHy+zSTDL9kqiirJ03zzvL12L4QPasbVX+KD/2yvTvnB3BCtwIyKv3yp8NRUpO64nYMazoJyBr4ec8Bj+C8nB44ouRdNIBMCm7DNVBqm/Z8PgYpXlq2DjqgFVtkVfbiUNnfSS18+RNN0a/mTrGeWXdhOpTUkpLStjnSeXN42UhP96/oysou2GFf/Y5G7ZpwAqcGTYpUn2hHOaOIlesjJgSKnydzuK73sJ3Qj6C4B+0xcDyiIiK2qbTZKb2LPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff90c3c-12d5-4e91-85e7-08ddb8791db6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:27:28.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz51h+e/qvEaOndseVSj/pVTKCyIIr0rflTuUF7yag00x7SrOG+CLRLnHo+TvyrhIbqhA6lNTzJmJoeIgN2+QGEBSwreoPJghvUu2n939n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010048
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0OCBTYWx0ZWRfX9CoyuR5XLxLb o3WTFFK7ih2VLJeA2OEC/z5cH7K93tGV9KKX3gu0HTUH9hm54PMbStKdrW3kki6jjoh8zzQXPQL iMc/xRohdqcDxT/rIoS6M+1VHRVuPiheswaZRjPFjRKJHZzVMjf79cKJ9pi/0iz1axnEn6Wc3Ab
 GtJ6E59N7ofixxpWnzfupa74IY0HPn9kK1HuSLw0KqkEvieIjQqUH4wZx6tx3QbZC6m9//JZL7/ CZ6u4/ejIasNFA39enAZo1nh65ep3I+8Le583zoaKuLvHMIdNLNxNV/pwb2Kl4A9k/0DHIZlDze tfafTM7tWbJXnxJdb8/0zWPSmj66E1t4ELXlKHIwcOXxLszsGBYwnJcPlCjIe0W8D9u4QlxESu7
 GsckFVZGI3ifYDz8t2XZzQFwxSPUAYTd+7vcYvlXZKVb6OXhEz+ey340GinSpzqpGk8cHJir
X-Proofpoint-ORIG-GUID: 3f8vrwV6u76faD6fcXQn5RJcH2iDanza
X-Proofpoint-GUID: 3f8vrwV6u76faD6fcXQn5RJcH2iDanza
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=68639bf5 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=r2vIv0JyTkAI2gZWdSYA:9 a=CjuIK1q_8ugA:10

On Tue, Jul 01, 2025 at 10:17:13AM +0200, David Hildenbrand wrote:
> On 30.06.25 17:27, Lorenzo Stoakes wrote:
> > On Mon, Jun 30, 2025 at 02:59:45PM +0200, David Hildenbrand wrote:
> > > Currently, any user of page types must clear that type before freeing
> > > a page back to the buddy, otherwise we'll run into mapcount related
> > > sanity checks (because the page type currently overlays the page
> > > mapcount).
> > >
> > > Let's allow for not clearing the page type by page type users by letting
> > > the buddy handle it instead.
> > >
> > > We'll focus on having a page type set on the first page of a larger
> > > allocation only.
> > >
> > > With this change, we can reliably identify typed folios even though
> > > they might be in the process of getting freed, which will come in handy
> > > in migration code (at least in the transition phase).
> > >
> > > In the future we might want to warn on some page types. Instead of
> > > having an "allow list", let's rather wait until we know about once that
> > > should go on such a "disallow list".
> >
> > Is the idea here to get this to show up on folio dumps or?
>
> As part of the netmem_desc series, there was a discussion about removing the
> mystical PP checks -- page_pool_page_is_pp() in page_alloc.c and replacing
> them by a proper page type check.
>
> In that case, we would probably want to warn in case we get such a netmem
> page unexpectedly freed.
>
> But, that page type does not exist yet in code, so the sanity check must be
> added once introduced.

OK, and I realise that the UINT_MAX thing is a convention for how a reset
page_type looks anyway now.

>
> >
> > >
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Acked-by: Harry Yoo <harry.yoo@oracle.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   mm/page_alloc.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 858bc17653af9..44e56d31cfeb1 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
> > >   			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> > >   		page->mapping = NULL;
> > >   	}
> > > +	if (unlikely(page_has_type(page)))
> > > +		page->page_type = UINT_MAX;
> >
> > Feels like this could do with a comment!
>
> /* Reset the page_type -> _mapcount to -1 */

Hm this feels like saying 'the reason we set it to -1 is to set it to -1' :P

I'd be fine with something simple like

/* Set page_type to reset value */

But... Can't we just put a #define somewhere here to make life easy? Like:

 include/linux/page-flags.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4fe5ee67535b..c2abf66ebbce 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -197,6 +197,8 @@ enum pageflags {
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);

+#define PAGE_TYPE_RESET (UINT_MAX)
+
 /*
  * Return the real head page struct iff the @page is a fake head page, otherwise
  * return the @page itself. See Documentation/mm/vmemmap_dedup.rst.
@@ -986,16 +988,16 @@ static __always_inline void __folio_set_##fname(struct folio *folio)	\
 {									\
 	if (folio_test_##fname(folio))					\
 		return;							\
-	VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,	\
-			folio);						\
+	VM_WARN_ON_FOLIO(data_race(folio->page.page_type) !=		\
+			 PAGE_TYPE_RESET, folio);			\
 	folio->page.page_type = (unsigned int)PGTY_##lname << 24;	\
 }									\
 static __always_inline void __folio_clear_##fname(struct folio *folio)	\
 {									\
-	if (folio->page.page_type == UINT_MAX)				\
+	if (folio->page.page_type == PAGE_TYPE_RESET)			\
 		return;							\
 	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
-	folio->page.page_type = UINT_MAX;				\
+	folio->page.page_type = PAGE_TYPE_RESET;			\
 }

 #define PAGE_TYPE_OPS(uname, lname, fname)				\
@@ -1008,15 +1010,16 @@ static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
 	if (Page##uname(page))						\
 		return;							\
-	VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);	\
+	VM_BUG_ON_PAGE(data_race(page->page_type) !=			\
+		       PAGE_TYPE_RESET, page);				\
 	page->page_type = (unsigned int)PGTY_##lname << 24;		\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
-	if (page->page_type == UINT_MAX)				\
+	if (page->page_type == PAGE_TYPE_RESET)				\
 		return;							\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
-	page->page_type = UINT_MAX;					\
+	page->page_type = PAGE_TYPE_RESET;				\
 }

 /*
--
2.50.0


>
> --
> Cheers,
>
> David / dhildenb
>


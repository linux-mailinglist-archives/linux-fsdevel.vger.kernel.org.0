Return-Path: <linux-fsdevel+bounces-23-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF597C47A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 04:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C6C1C20E2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC553551B;
	Wed, 11 Oct 2023 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WMTm7DeK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wmQohlkV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D053819
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 02:15:13 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532138E;
	Tue, 10 Oct 2023 19:15:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiED7025695;
	Wed, 11 Oct 2023 02:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=av/Qm6fnzs/b4jA5703sz4SBcB9b3gAHRfo/8eu1omo=;
 b=WMTm7DeKvZeLIBZr+Yn3B5P5gwr9Sz/az5JPJ5xscN70EA6y+27lLuGKykORnHcWbF9d
 DDrrKd8RnUNqIgcC1aZJD1CDLuqfpo0CC18MVnGK2RNGRfyCsZLlETUFHpDhNS15Gg5u
 JuV4+/i18MiZgwncdvlZeRWLluVgfv/LOLJ6S/C9FeGtvVli92Q3gurfV/0FaarOhxI0
 YxJHFQa3jV0lfDnDf4BElQBsBJ0hw2QPW0pZC7cKlPSaF5lM7J057YtymFwnKxOJBm31
 HE4rlnjjtPONPB+WzOPBDDZFvW2chnECOEDFNBHouAaQk6zeUZMck/IoIV1BUNIQVRJx qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89v5k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 02:14:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B08cjK032138;
	Wed, 11 Oct 2023 02:14:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tmfhqy0xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 02:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcUATzxm962sTs3aTBGBFpsgzFyuqlmr87Qw2iAXEI1fMOvPXRBtkOersE9v4E5v96zHNrfSq6ZNfDF6ID+pVUBxO5hefKfb9QlSzaDTQj80H2s/+g9YbPlPA3GedBmWS8azIw1yViRz4u/wYQ1rP96ddSiteonlW3bCj8FfIe8reHz1OIJSnESvSXU2mL7TWyhRLAczav5dP3r0frVU16XuGoDSnICUvm/pOIdvE+j4nFE+RKvyaLIgh2N6KgbIhVmEXYjWNfSkSBuafMRRdaZUTK2HW//UvuH5nP2Cjr+vkYdT7BZXnhHU6KeK5N6RRVNDyDnfyANtTz/YMniAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av/Qm6fnzs/b4jA5703sz4SBcB9b3gAHRfo/8eu1omo=;
 b=mapZAnkd573nK0UD2i3kf7iZb0Hn050Tq4kBhuRgYhCCxEs++CwxFzCnuH3R6X1H+l1T3WD9cpl/J1BVlODa4aW3isVKOj5Kl8j6eftXVY4nEVE31C5KXFBKyVx4zCl+EY7urQeEVibNfKlrnXCZApoAQXOBFkyG3JNsMvLjbbMZMXfjtEK8JHDHAsAkxjl4EN55yG0lG0kaaqCbEUE3LYu8e1Uc8x2G8vR27G5A4iBAPyizu9YZoGzk8taaNaBpn5FkIVxRgGDTdpFLqPSytBhHaslQW0hA8eEBGcHPYwK3AQOQWmCK2RDxa8zg0dmJhyEQdz0ezUPoXkyd2+fXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av/Qm6fnzs/b4jA5703sz4SBcB9b3gAHRfo/8eu1omo=;
 b=wmQohlkVLQ2vuegaJj166TGPDcUtuKh+TdSxR2MiLURuwBHmVOwrsXflHzirbmCdLv1TZUS8GLKyUnle3TdcWMmrfhapYct98QtrVqAUMRMJvu5hBIikwQHpw+p0V9gkrY+ma2p7CywlpnP0Kq7QjeCP69f07m4r22M72T1l9CQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 02:14:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 02:14:55 +0000
Date: Tue, 10 Oct 2023 22:14:52 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm: abstract the vma_merge()/split_vma() pattern
 for mprotect() et al.
Message-ID: <20231011021452.57vhftchkfxebppe@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
References: <cover.1696884493.git.lstoakes@gmail.com>
 <ade506aa09184dc06d57785fe90a6076682556ca.1696884493.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade506aa09184dc06d57785fe90a6076682556ca.1696884493.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 1697e26f-c4d7-45c2-a0ba-08dbc9ffdc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	K4KLV9d+3//KX78R3uBX0tg4kFKFA9nj42eSvt2wOYj1VoidZ4MEDY+Q5Niq4aaTX3U4ykcShcb9vjF4WI7iYo97ieOO7X89CANFHCYzI7nLZtkcrEQkBqV/MmovhrPv9RTPWkD+boXAaetiuHId6zwxkeCFFwcIfvTZkAh59n2NnlQjMRJzqECPtSdBMyctbF/8G9m73uAVxP+WFRaUtubHSRH5u+OaGTLjdnn7An/fKxY2/PV/CTwksgGR2QZmSq+HfuA23yLmQ6TqLbVKpOo+wheUy6LtSkc8O7Ra3ZKTr+7HwcQ0rd46sL16jKJHWxB3xmXPY3KK2wCnTbE3/p9coDHG765SUh8VquaRC0tRWDY+kDVpjBYEZOcE6rCCsfABpT75uyJyQxl1XouaQYp/bFSZsEG03otq5jFO7H+e20trO5GfR5ScdphC+puaRhIqLfVxECzTDaucWQ1McuJDt/y4xe3gBUx44/USAYhblpyU8mpV7imGcNYb/himcdVkIAgxHHaorl193D3FYk6R/6v+23gz36I7CY+m2ocSfJKC6EikJzeqlINuGsXQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(33716001)(38100700002)(86362001)(478600001)(6486002)(30864003)(6512007)(2906002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(8936002)(6666004)(9686003)(83380400001)(66946007)(66556008)(66476007)(54906003)(6916009)(316002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CbTZnJfX4EsP+zJwKn07Ey2lFU55miaWM+grQgLDWWd19POqGUiVdSwYr9SA?=
 =?us-ascii?Q?qCaYZEAyD86F0I/xO/3+5lXXrGSqdQ4iOhnnh9ks9qyLDd5JBtf7z2se30ZX?=
 =?us-ascii?Q?UtVt7CUIYWCd+8o5a+bd5rM+nJP0RU8dM7u6ffeP1oc9ivY0s0NsUzBd00OB?=
 =?us-ascii?Q?7VQzY5zOMHYE14ZzfGWDS13rZ2XhMftocgCVlkskSVQ2LXUvSFrf3IfPqfrg?=
 =?us-ascii?Q?sKN0lWJwpvucF2JoT5T/Hm9fEVsXu99N4QbpTd4deN8F3yX6G14DlKdcjdQB?=
 =?us-ascii?Q?mps3vOaq5IOz3dRFhCZmIVIqP1rkfvjetv3+8zTHhquXMenLFD2/G25IaP3B?=
 =?us-ascii?Q?jEQK4Ebf4CsfZ/ZROCx/oS2ciyUCHDO0AbmoHfPnpZdoWdK2BSajtOdpwNkY?=
 =?us-ascii?Q?9d+Aw1t+zBVSrKHqhHbTy58MgfIFyPy5k+8U8AHt5o0Yy6Qpn+t/QXz4Su3O?=
 =?us-ascii?Q?gs0huzlV8xTtRc4kifKy2e6B2Eg3VmzW1ViJ9IgCgYzHo9Q+Q11JflTCZF6z?=
 =?us-ascii?Q?mN/acrtQ0uXgW+XU3tjl1vpRf8/pMKnYmZzaz0vzD3Q/pegni7OTOCCwXi3p?=
 =?us-ascii?Q?mSXX1HVzUhMDBMJG/bVDvbbjSCDTMIjYk8W/WhwKYmGYjf7MfsMLtrLp+UGU?=
 =?us-ascii?Q?Nb7a+4sEqwAZPDES5AmXGJRKVvaHeKneY0/PgpYLIjcHmmGnUbMk1j6fTdHM?=
 =?us-ascii?Q?j1x3Lg7Mcy040xOpUVhrwgoVS3o/FDswban3AsbIQZ4nAl/h9aIr6WLHEiSO?=
 =?us-ascii?Q?Xgk/gZejZUJpdJA4g6wuF0/6bXzEPZAtSYkzVcH9YF1VkTjWXxAU4fAV22Tf?=
 =?us-ascii?Q?QHB9si/UIv35gE1i+nKLvs9+31v8Ot46hURErHaqtGv1sr5L19Ikhnu76r33?=
 =?us-ascii?Q?uwQi6oIPawYezCtvToXFOL3HhPRY4p/9oDj5BFqIGl0c1S64EokFIUWTIIwj?=
 =?us-ascii?Q?EkPOcBu1aJvSe0Pej/TzO4MV4zIy+2ga5PuUFfx51l4QcFM0+3vdVxihT45B?=
 =?us-ascii?Q?9W3nw9d6S68nXyxalCaFK7Y0R23pZDncm16zguF2kWwQhiK0Ez7VJKzk48MW?=
 =?us-ascii?Q?hG3TlP0IXWO0rscTQaVWTQt1cqZcI0iafXUlrOxD7t6NDjveSzaEM/oH9+Uz?=
 =?us-ascii?Q?+U+Q2nT+6a/zpfqw0cgzDK06hy1oHOhF/5c/k5ZL0E4LZ9MRfeH1LaR+27sc?=
 =?us-ascii?Q?320K0raSws1w/33v1+cuIqToCz3SWiHWXwCB7kmlC1jc4JsiIbmszVaHaHvn?=
 =?us-ascii?Q?ugvch+jRN5S/8xD+iB7AdYSR8tyr1AHlE/pGNAeH79w1+5uwkNlM/I9eu8v5?=
 =?us-ascii?Q?0kyTni2ToK3C/SENHyFq05j8T+ELb3z5KQ7/BhKfPC8f5pAIDTwYU4TYiCJG?=
 =?us-ascii?Q?DJ7bMVNdWptO9WOhYt+rk9eDcQCtSNLICW/YlryrlFuLqm9OvO2i3t4rtSxL?=
 =?us-ascii?Q?y4U4fjyqVcukiEXhM1C2aGxwsqwyAb4ajVUvlaaBp3A0jXNwY+/sH88Q5tdY?=
 =?us-ascii?Q?+VtYZ/sSMw6ePkidheanlvjft8M6+RLqKxu4L/ARv66zE6UI8gJ/Kbcm+SBJ?=
 =?us-ascii?Q?15q9ouB2WDHSgi9Yzc6kEhJMUjxwTSrgmjFxImVQFZK58vl7bFF+ARNuJKfB?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?stp7cqJlcsvbNR8/lgwSTMTsi8yXsbKa3aikObf14QMN541SEWklN4XAtSLr?=
 =?us-ascii?Q?PiHq/H7b4RU1QERT3xnZoNLEuNMbmLb6kA8BlPYlB9omqfs9cLuHUU+n0Snu?=
 =?us-ascii?Q?yrFQLD0x0o7THa+6XnjNUpITHYnsuAZWo1V/3qUocXwjeir1FZ9I8LTVAMB8?=
 =?us-ascii?Q?t88oeOEIyqEg5d9rIcmZiBX96ZZEj+/yf/A+IDQzgARcX2Rq5xttqzAr1mjV?=
 =?us-ascii?Q?HeASQl2O2U2QB13olBRUF4mB2iD29u92noJ+EaBOPqSZw0DeSQ+taRjfGWtz?=
 =?us-ascii?Q?aZwZCyy6IIONCjZAzSs3tZ9X7i2dzuSZe0RINDWSCsqnS/xSybZwPsNRtJOb?=
 =?us-ascii?Q?0bYy9gW9axAaqreVPry0K4KEqocKFG542/u4jifWR3Q3YKxzllWKeBrG/6N3?=
 =?us-ascii?Q?yu1bRuTOXt7gPI9jTghDv6rvg1s3r/6wmiXniGyNCBv6sIdC1q53mzT7P803?=
 =?us-ascii?Q?lzhNjlLY0ioJ/7fOr8d9NO129bW0mNeK6M7soxaZMa6pLMTaoE3j97za/czv?=
 =?us-ascii?Q?vjgkoGEgcpuwsINzRDGO3uXtCckr8UTXlZbdinAru9dDYNsogkvn4hfkCQKP?=
 =?us-ascii?Q?FRph5p5WZH9pQxY7/WaG8WfEaVwQkpTj3TMhjIoam1VhyiOZ2ZsdsIZIC0hz?=
 =?us-ascii?Q?rXtEom5eNh2VxVj7iaqQMYsTkAxH5Bv7ypL+OXet9XiqRbS829aN8BTqmFrW?=
 =?us-ascii?Q?FKaThTNbu7abuTq0Ka9Bgn4f/dBXnzSSdfNVUGUfdJaxDqWvyQWAHd8PuVmj?=
 =?us-ascii?Q?xCbj1wBxGbCufv8ikM6/Gnfx7X3sRhOgDdXiOb0rzHD9jK12Omg4AiXWolZP?=
 =?us-ascii?Q?EhIQUYcNtFek4fNukYtyTSBbKrZnuYHxal5I56erklY3DFb3zq6Auddg5t5D?=
 =?us-ascii?Q?rWTa6xck3MaZDKE8ZooU7bMN1j62QJHIFnkt0d+Qos+rZKn8gWu8vqb3V5GQ?=
 =?us-ascii?Q?S9i8CxJ1dSpBB3nJcMuMsYGSI+vh2RpNkMMQdcMCUu0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1697e26f-c4d7-45c2-a0ba-08dbc9ffdc10
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:14:55.2044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhONiAxwFQhGECTVGVm1YrCZ/mHbhHLpCa2Q52qLqypwlfR+j4XpOwe56sC2e/Vr8+eVGyfjK8qBrTll7bh9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110019
X-Proofpoint-GUID: IvZppSCIRpQm1bL44N43nudDA_hpW2eC
X-Proofpoint-ORIG-GUID: IvZppSCIRpQm1bL44N43nudDA_hpW2eC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Lorenzo Stoakes <lstoakes@gmail.com> [231009 16:53]:
> mprotect() and other functions which change VMA parameters over a range
> each employ a pattern of:-
> 
> 1. Attempt to merge the range with adjacent VMAs.
> 2. If this fails, and the range spans a subset of the VMA, split it
>    accordingly.
> 
> This is open-coded and duplicated in each case. Also in each case most of
> the parameters passed to vma_merge() remain the same.
> 
> Create a new function, vma_modify(), which abstracts this operation,
> accepting only those parameters which can be changed.
> 
> To avoid the mess of invoking each function call with unnecessary
> parameters, create inline wrapper functions for each of the modify
> operations, parameterised only by what is required to perform the action.
> 
> Note that the userfaultfd_release() case works even though it does not
> split VMAs - since start is set to vma->vm_start and end is set to
> vma->vm_end, the split logic does not trigger.
> 
> In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> instance, this invocation will remain unchanged.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  fs/userfaultfd.c   | 69 +++++++++++++++-------------------------------
>  include/linux/mm.h | 60 ++++++++++++++++++++++++++++++++++++++++
>  mm/madvise.c       | 32 ++++++---------------
>  mm/mempolicy.c     | 22 +++------------
>  mm/mlock.c         | 27 +++++-------------
>  mm/mmap.c          | 45 ++++++++++++++++++++++++++++++
>  mm/mprotect.c      | 35 +++++++----------------
>  7 files changed, 157 insertions(+), 133 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index a7c6ef764e63..ba44a67a0a34 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -927,11 +927,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  			continue;
>  		}
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		prev = vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
> -				 new_flags, vma->anon_vma,
> -				 vma->vm_file, vma->vm_pgoff,
> -				 vma_policy(vma),
> -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> +		prev = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
> +					     vma->vm_end, new_flags,
> +					     NULL_VM_UFFD_CTX);
> +
>  		if (prev) {
>  			vma = prev;
>  		} else {
> @@ -1331,7 +1330,6 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	unsigned long start, end, vma_end;
>  	struct vma_iterator vmi;
>  	bool wp_async = userfaultfd_wp_async_ctx(ctx);
> -	pgoff_t pgoff;
>  
>  	user_uffdio_register = (struct uffdio_register __user *) arg;
>  
> @@ -1484,28 +1482,17 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		vma_end = min(end, vma->vm_end);
>  
>  		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
> -		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, pgoff,
> -				 vma_policy(vma),
> -				 ((struct vm_userfaultfd_ctx){ ctx }),
> -				 anon_vma_name(vma));
> -		if (prev) {
> -			/* vma_merge() invalidated the mas */
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +		prev = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> +					     new_flags,
> +					     (struct vm_userfaultfd_ctx){ctx});
> +		if (IS_ERR(prev)) {
> +			ret = PTR_ERR(prev);
> +			break;
>  		}
> -	next:
> +
> +		if (prev)
> +			vma = prev; /* vma_merge() invalidated the mas */

This is a stale comment.  The maple state is in the vma iterator, which
is passed through.  I missed this on the vma iterator conversion.

> +
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and
> @@ -1568,7 +1555,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  	const void __user *buf = (void __user *)arg;
>  	struct vma_iterator vmi;
>  	bool wp_async = userfaultfd_wp_async_ctx(ctx);
> -	pgoff_t pgoff;
>  
>  	ret = -EFAULT;
>  	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> @@ -1671,26 +1657,15 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  			uffd_wp_range(vma, start, vma_end - start, false);
>  
>  		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
> -		pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -		prev = vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
> -				 vma->anon_vma, vma->vm_file, pgoff,
> -				 vma_policy(vma),
> -				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
> -		if (prev) {
> -			vma = prev;
> -			goto next;
> -		}
> -		if (vma->vm_start < start) {
> -			ret = split_vma(&vmi, vma, start, 1);
> -			if (ret)
> -				break;
> -		}
> -		if (vma->vm_end > end) {
> -			ret = split_vma(&vmi, vma, end, 0);
> -			if (ret)
> -				break;
> +		prev = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
> +					     new_flags, NULL_VM_UFFD_CTX);
> +		if (IS_ERR(prev)) {
> +			ret = PTR_ERR(prev);
> +			break;
>  		}
> -	next:
> +
> +		if (prev)
> +			vma = prev;
>  		/*
>  		 * In the vma_merge() successful mprotect-like case 8:
>  		 * the next vma was merged into the current one and
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a7b667786cde..83ee1f35febe 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3253,6 +3253,66 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>  	unsigned long addr, unsigned long len, pgoff_t pgoff,
>  	bool *need_rmap_locks);
>  extern void exit_mmap(struct mm_struct *);
> +struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> +				  struct vm_area_struct *prev,
> +				  struct vm_area_struct *vma,
> +				  unsigned long start, unsigned long end,
> +				  unsigned long vm_flags,
> +				  struct mempolicy *policy,
> +				  struct vm_userfaultfd_ctx uffd_ctx,
> +				  struct anon_vma_name *anon_name);
> +
> +/* We are about to modify the VMA's flags. */
> +static inline struct vm_area_struct
> +*vma_modify_flags(struct vma_iterator *vmi,
> +		  struct vm_area_struct *prev,
> +		  struct vm_area_struct *vma,
> +		  unsigned long start, unsigned long end,
> +		  unsigned long new_flags)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> +			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> +			  anon_vma_name(vma));
> +}
> +
> +/* We are about to modify the VMA's flags and/or anon_name. */
> +static inline struct vm_area_struct
> +*vma_modify_flags_name(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start,
> +		       unsigned long end,
> +		       unsigned long new_flags,
> +		       struct anon_vma_name *new_name)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> +			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> +}
> +
> +/* We are about to modify the VMA's memory policy. */
> +static inline struct vm_area_struct
> +*vma_modify_policy(struct vma_iterator *vmi,
> +		   struct vm_area_struct *prev,
> +		   struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   struct mempolicy *new_pol)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> +			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +}
> +
> +/* We are about to modify the VMA's flags and/or uffd context. */
> +static inline struct vm_area_struct
> +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end,
> +		       unsigned long new_flags,
> +		       struct vm_userfaultfd_ctx new_ctx)
> +{
> +	return vma_modify(vmi, prev, vma, start, end, new_flags,
> +			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> +}
>  
>  static inline int check_data_rlimit(unsigned long rlim,
>  				    unsigned long new,
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a4a20de50494..801d3c1bb7b3 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -141,7 +141,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	int error;
> -	pgoff_t pgoff;
> +	struct vm_area_struct *merged;
>  	VMA_ITERATOR(vmi, mm, start);
>  
>  	if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
> @@ -149,30 +149,16 @@ static int madvise_update_vma(struct vm_area_struct *vma,
>  		return 0;
>  	}
>  
> -	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -	*prev = vma_merge(&vmi, mm, *prev, start, end, new_flags,
> -			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			  vma->vm_userfaultfd_ctx, anon_name);
> -	if (*prev) {
> -		vma = *prev;
> -		goto success;
> -	}
> -
> -	*prev = vma;
> -
> -	if (start != vma->vm_start) {
> -		error = split_vma(&vmi, vma, start, 1);
> -		if (error)
> -			return error;
> -	}
> +	merged = vma_modify_flags_name(&vmi, *prev, vma, start, end, new_flags,
> +				       anon_name);
> +	if (IS_ERR(merged))
> +		return PTR_ERR(merged);
>  
> -	if (end != vma->vm_end) {
> -		error = split_vma(&vmi, vma, end, 0);
> -		if (error)
> -			return error;
> -	}
> +	if (merged)
> +		vma = *prev = merged;
> +	else
> +		*prev = vma;
>  
> -success:
>  	/* vm_flags is protected by the mmap_lock held in write mode. */
>  	vma_start_write(vma);
>  	vm_flags_reset(vma, new_flags);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b01922e88548..6b2e99db6dd5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -786,8 +786,6 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  {
>  	struct vm_area_struct *merged;
>  	unsigned long vmstart, vmend;
> -	pgoff_t pgoff;
> -	int err;
>  
>  	vmend = min(end, vma->vm_end);
>  	if (start > vma->vm_start) {
> @@ -802,27 +800,15 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		return 0;
>  	}
>  
> -	pgoff = vma->vm_pgoff + ((vmstart - vma->vm_start) >> PAGE_SHIFT);
> -	merged = vma_merge(vmi, vma->vm_mm, *prev, vmstart, vmend, vma->vm_flags,
> -			 vma->anon_vma, vma->vm_file, pgoff, new_pol,
> -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	merged =  vma_modify_policy(vmi, *prev, vma, vmstart, vmend, new_pol);
> +	if (IS_ERR(merged))
> +		return PTR_ERR(merged);
> +
>  	if (merged) {
>  		*prev = merged;
>  		return vma_replace_policy(merged, new_pol);
>  	}
>  
> -	if (vma->vm_start != vmstart) {
> -		err = split_vma(vmi, vma, vmstart, 1);
> -		if (err)
> -			return err;
> -	}
> -
> -	if (vma->vm_end != vmend) {
> -		err = split_vma(vmi, vma, vmend, 0);
> -		if (err)
> -			return err;
> -	}
> -
>  	*prev = vma;
>  	return vma_replace_policy(vma, new_pol);
>  }
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 42b6865f8f82..ae83a33c387e 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -476,10 +476,10 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	       unsigned long end, vm_flags_t newflags)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> -	pgoff_t pgoff;
>  	int nr_pages;
>  	int ret = 0;
>  	vm_flags_t oldflags = vma->vm_flags;
> +	struct vm_area_struct *merged;
>  
>  	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
>  	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
> @@ -487,28 +487,15 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
>  		goto out;
>  
> -	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -	*prev = vma_merge(vmi, mm, *prev, start, end, newflags,
> -			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -	if (*prev) {
> -		vma = *prev;
> -		goto success;
> -	}
> -
> -	if (start != vma->vm_start) {
> -		ret = split_vma(vmi, vma, start, 1);
> -		if (ret)
> -			goto out;
> +	merged = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
> +	if (IS_ERR(merged)) {
> +		ret = PTR_ERR(merged);
> +		goto out;
>  	}
>  
> -	if (end != vma->vm_end) {
> -		ret = split_vma(vmi, vma, end, 0);
> -		if (ret)
> -			goto out;
> -	}
> +	if (merged)
> +		vma = *prev = merged;
>  
> -success:
>  	/*
>  	 * Keep track of amount of locked VM.
>  	 */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 673429ee8a9e..22d968affc07 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2437,6 +2437,51 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return __split_vma(vmi, vma, addr, new_below);
>  }
>  
> +/*
> + * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
> + * context and anonymous VMA name within the range [start, end).
> + *
> + * As a result, we might be able to merge the newly modified VMA range with an
> + * adjacent VMA with identical properties.
> + *
> + * If no merge is possible and the range does not span the entirety of the VMA,
> + * we then need to split the VMA to accommodate the change.
> + */
> +struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> +				  struct vm_area_struct *prev,
> +				  struct vm_area_struct *vma,
> +				  unsigned long start, unsigned long end,
> +				  unsigned long vm_flags,
> +				  struct mempolicy *policy,
> +				  struct vm_userfaultfd_ctx uffd_ctx,
> +				  struct anon_vma_name *anon_name)
> +{
> +	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> +	struct vm_area_struct *merged;
> +
> +	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
> +			   vma->anon_vma, vma->vm_file, pgoff, policy,
> +			   uffd_ctx, anon_name);
> +	if (merged)
> +		return merged;
> +
> +	if (vma->vm_start < start) {
> +		int err = split_vma(vmi, vma, start, 1);
> +
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	if (vma->vm_end > end) {
> +		int err = split_vma(vmi, vma, end, 0);
> +
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	return NULL;
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index b94fbb45d5c7..6f85d99682ab 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -581,7 +581,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	long nrpages = (end - start) >> PAGE_SHIFT;
>  	unsigned int mm_cp_flags = 0;
>  	unsigned long charged = 0;
> -	pgoff_t pgoff;
> +	struct vm_area_struct *merged;
>  	int error;
>  
>  	if (newflags == oldflags) {
> @@ -625,34 +625,19 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  		}
>  	}
>  
> -	/*
> -	 * First try to merge with previous and/or next vma.
> -	 */
> -	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
> -			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -	if (*pprev) {
> -		vma = *pprev;
> -		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
> -		goto success;
> +	merged = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
> +	if (IS_ERR(merged)) {
> +		error = PTR_ERR(merged);
> +		goto fail;
>  	}
>  
> -	*pprev = vma;
> -
> -	if (start != vma->vm_start) {
> -		error = split_vma(vmi, vma, start, 1);
> -		if (error)
> -			goto fail;
> -	}
> -
> -	if (end != vma->vm_end) {
> -		error = split_vma(vmi, vma, end, 0);
> -		if (error)
> -			goto fail;
> +	if (merged) {
> +		vma = *pprev = merged;
> +		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
> +	} else {
> +		*pprev = vma;
>  	}
>  
> -success:
>  	/*
>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>  	 * held in write mode.
> -- 
> 2.42.0
> 


Return-Path: <linux-fsdevel+bounces-52591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59363AE46C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CB817DDFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC86252900;
	Mon, 23 Jun 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZXTzIXEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B32512EE;
	Mon, 23 Jun 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688448; cv=fail; b=JqOW9knPHfnNnsFp6b6dHPN+Nd5ZtJyg8OpSNk1+9s0xJt9wfpyozi+7rNiMINjo00WrQNg/DrGk7MDOZVBYX3h3uAC4xugtP1BXqfOamZ525u+FnUfLKeTBw6Gzscvu8rcCFHUdQAitnN2PnGL0npMVEUZITeOMNWebtGxwbLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688448; c=relaxed/simple;
	bh=JvRenFMGkVMdWPLFlNOrqqXJM0rBbxsW1Yg2lM2AgkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWCk4Dbsw6gOkznpNYcc4k4lQt3hRnNvcoQtcc9+tGEAWyaGYGENkyvEUcQjKsTH73iR7je8guBQk9eS5vpOuYMWAvrXaDwqBOl3W8iIrD4Msi+aYP8Nopzw9Yr1iI22pH3nwNczYv7x63DjQePVPgWpyIw8t6hM9zxKLQWpWiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZXTzIXEY; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ej1URlLIXFwlJ0RBVf4N943TR73VWt8nHUTr/vfZyqMFte6qSJVMm9HoQxo3KMl1hvuOxzSUp1BN4jOxES5ceHzlWi/B6cE+aj7D4YpTTtKAu8ChOoLpec6t4pIWL7uXxZHolOHCXWbraYK5ySlsoO+d7Hewec0rb7+Aluda0hX1Pcax++TisTKeyg9auixrxBIHEQd/B7TPhESz5FBhH+vvHngYqIFeonv4bIT83vpHu/qUO+b2ymOHe6nnhp8NVH0rSuk6G8l/FJkdhT/XazoM7QyHbJWqn/GLi8cw1073ET94rfo4O5jChcbCVrk1I1fKfby81A7WunZR14OrMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOP5Wy+eK9Fry0k8tGO7ajTCVC1Scla5QqPl45yzQNE=;
 b=bmbSr202+CrZ1GpkDToKobZ5ardwmWhh73I0Arakm4XOl30hAKNSJvAxf7gcH2PqFieeo8NWdj00U4q5uG/7HzGaz/YgsPrf2s7/9K1JvCP9I1+XdnJyNhzmCcURLQ8oXI993zZmnIUmG2yc+/GatZz6m57Ox3LxRA4SN+J3Zax42ocZpfNs0E2V1aTQ76aT9CT05JLz2nSJ+xeQ7dsjPlCHHg+o95/K5ckDIfzwEbGJwLMSmHn0adGfWhaFzs5pkb/RCnlR5JQ1OYJJlVQ867Oxz004BWvRZvIjRTc+bGKxB672oyJHAj4FIXad+XQFl++GVODkEY2QcFeqsAEZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOP5Wy+eK9Fry0k8tGO7ajTCVC1Scla5QqPl45yzQNE=;
 b=ZXTzIXEYCutIF7dhmGQtR79ZVXBReIHWnvmz0UQu1B1kZTP5IwY2pKpeXT03hkTjx9M3fHV0UKuK/NVm6/2ZxjJHBb9C6PhHaGWgbaVidhD0qoUrPUv3OB6KO/eSQ+2We8Oh2oysw7H4XEJ5ZiudsCgdgSTanelpYfaSzRl6rqTqRSUwfx6HTqS2XCMWxq7hs/bF95sGilv73VOK214WauYHedaABqe1klE1tCk+7El42+zai9yL8nora63YW91G+rPQk6wbyYQEKQ5IC2O+zueUp2YO+BaBDO7VuPqM3gZLoD+//meK3DyKP2Rlo8v3Vr4lnRzl0elVl2cAPL+n2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.22; Mon, 23 Jun 2025 14:20:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:20:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 24/29] mm/page-flags: remove folio_mapping_flags()
Date: Mon, 23 Jun 2025 10:20:36 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <C836100D-A7B4-4A7E-BAA0-345AD661BB99@nvidia.com>
In-Reply-To: <20250618174014.1168640-25-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-25-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:408:fc::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a90743e-fd2d-4c8c-2a85-08ddb261215f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h16UYkXn+psrQO6gTuKuI/O2mQ7zJzb0RU0XObbxItQWOWxa/kgDvA7iv0DZ?=
 =?us-ascii?Q?zilpflSFFzt9HE6eXuuoRx3jn0g7yvIsTcpvbYJklMTyrJGthktnGBsI3T7q?=
 =?us-ascii?Q?09ay8BrhvmzMS0EHVQArKQPs0SnC7bIcLcxLFi1qmAQ8glLi839PTe7Gmxhl?=
 =?us-ascii?Q?DXZbh6O+94BcowUlCVM3Mlc10ER1gKB+6aRiSPJ/HPT39NyBMQWijZ3Ara9I?=
 =?us-ascii?Q?JDbhllPhtiHbkoKDnkM59uRx1OTS8ZYA8RlsXA/pZCkZI4Teu3+LdxhVMUoa?=
 =?us-ascii?Q?bCBGciImskhMmUfXe9w1WEnF4IL7iRjTn4o0yrKIyydOPQplEU3324PI3dTV?=
 =?us-ascii?Q?FLREBCXkEsett8e/1S4fUBhb4T2b+ZedbtWJg0SvMqwXaVktzrUz5haZV1Pc?=
 =?us-ascii?Q?4YmRJXq6Cp68e0qt4QD2mH/kRRf7yUkleFMar/5Ukitx5qJjQYn/ShrcT2EP?=
 =?us-ascii?Q?U2Vthj90O1sy5LnQ1vMNee/doJGot6uGy8QYX9CTHOnHbgkeAFiF1E6xjkR3?=
 =?us-ascii?Q?Gw6jfw1yficMktGSMPVuu0bAAVFUF8axZeRWmHolFBBXfENWQNZmWV8bDhps?=
 =?us-ascii?Q?ZeBgDLAIM+wf5nOgeL5GvmdWQ86mkb0pve7A+8223Mt/zoXqsMUzTslJcM9M?=
 =?us-ascii?Q?FjD/Kt2HsBrDzlBFswTU8yg7BAndHu84PKvAYJERYcKfFQW7OLRbpLO/b9vH?=
 =?us-ascii?Q?lWbsZYtpdn6STP7vzQMA+R24+cLSH0mF4dw7tcj7DStN5JiWTAM7qBB24LLB?=
 =?us-ascii?Q?QuHoIDqY0mOGWyibcRPIcuj4gO3iFCPtLLhAH2+QanTIZGltimnYYDL/zNvL?=
 =?us-ascii?Q?6ucyHS4zMqhpyF1luAv9Vo3t3fX+Cwg9GWdJL/9lhquS2K00YRtk0lGjR5V0?=
 =?us-ascii?Q?oEXKkfRuUM3sF0ix+H/s1bzEAT0w3fS+u6QPeMD0eaE2Zc6qNTgM0bBBZEiM?=
 =?us-ascii?Q?TFYHJNmTGmmOFqJ9p3EE2tuEIjMP+5jdPf3sLskJLi9hJIYroRwo8AD0S37m?=
 =?us-ascii?Q?Bdhb0xBaLLpzcpBwi/EJFnpul+2ypsKPBR3YGNoG92NIofDJNeqWGe4S+/bg?=
 =?us-ascii?Q?wJI7F2y4WaKdyNdyfhg9sfOq5UXCogX62SVvYLe0QaCZZ1YCrdbwk+1UxSaO?=
 =?us-ascii?Q?+lbPzPQ4ReximK1h/bBmhRh3c1THGeOvYyRlBRzRqeofHWDakA8jQQIoieqc?=
 =?us-ascii?Q?2BMvgpUea2E3bfjiE8JrMabeiaPYbDkB69wdYeil+xi0CRgiKi4XHnTbAIWe?=
 =?us-ascii?Q?wV1o8POiPr5K1TAqBV1RhqDdcVelm8RXqmIi7sEKDlVCYuRmeMqOtVEZV4Jf?=
 =?us-ascii?Q?mF8OzHuVN5NWhS8ImcQIBlDWuj98znWYRdI30K3LS+5TX6ESmA2HgDdsIC1P?=
 =?us-ascii?Q?tQ6tiEwdRJiw3pqxgz1ZWaZXhMfk/31UFksq2ivuTZhAdaSYRFuOdPd0lhkQ?=
 =?us-ascii?Q?UInQcOtTFe8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfFMVxm/nenQ88eTSJMo+UN90XixJ+lRWWr8el88dJVb8sp3KpQ2o0YHwqsm?=
 =?us-ascii?Q?j8illV9vj4K1kABwZYPs/XLyYTh0nYM+ZIlx5xh39Mzzpngno+d8Va1+J2mN?=
 =?us-ascii?Q?gL0WRyl0v+oK1PXHZBteZjR3cNNMRHyfCbmJRLVC4e+529LK1R31Dvj2sJfd?=
 =?us-ascii?Q?BsGD4WUHAN49UGU63xan2usuw4ufm4PrvFJ37TOhc8mnF+mqZ/UKDjZKWda9?=
 =?us-ascii?Q?HdfpwtshIZQ5f1Rg7Zg0/4vPY3tZVOG4o8kN82+qJ4BX9NYChqkPUQp9YxTX?=
 =?us-ascii?Q?SWeHvXheSFgYjY0iFyYXqDqKIvaDB7/su7OyypLZeQtr+ogfa27j4AeUG5I/?=
 =?us-ascii?Q?1gbzxsPy7W3UDvg/1LLp1dL14rvvzBMPYE+3LFE8fDlq1KFFLMjcoc1lpY4m?=
 =?us-ascii?Q?sE/UrvobvJaeBVAwY2VewnIcNN8tLoFUEW0/sdR2oKfNMMNkqg64pCRLStwa?=
 =?us-ascii?Q?NaIw42mBfjxcXbq3HcmXvLLzST2npx9N5anx4OtzYTTuap9tCbtoqI5+/UFY?=
 =?us-ascii?Q?pzJMBhRkXUCH0GTuxX6f0+4zOanag3tYzXLthSfMCE86CxE1ZowsweWP68Gk?=
 =?us-ascii?Q?1jBrd5I20DVDWNuyLl7L23poV6nNplPRMdhVj14TnmYbWeiwspGV1R4xANdG?=
 =?us-ascii?Q?YwCyXE3GRxa0x36ZLq5bFTPT1NbD9oqgJ7uWNEau26k1quofmoPhdt414Zik?=
 =?us-ascii?Q?+KWGFSL4ZD18ZtKV4+FIGT3R5ATm4L3I8gQ6yZa6OFN90QkyuIutBGhgQA2G?=
 =?us-ascii?Q?+3hTTIf4w9R1DOnHWigxyVBNJtaI6Zw6HmnETP2CoCahkfKU5ORNen0mUgeY?=
 =?us-ascii?Q?q5XIE6rh1aD+s2Lhf7XXUh14aDaPk4oyn338ehJT8+1XsQYyOSBc3QIY09ka?=
 =?us-ascii?Q?/J81Ti20skLrm/spDO3KL3tzAAPR1ja82CuAPK8AWmuhA0yq6eEY+3TJ+aZi?=
 =?us-ascii?Q?uOQTa2IAl6/OvThjUuiaOapYlpdozHpeIPHxH8PxKgfDam3whDSCc95ueGQX?=
 =?us-ascii?Q?xW4MXSE/Xh8di1OxBT1iaL9RpkwCD9k4tth19Ha88XxmwG1lNCbv5s3ply5S?=
 =?us-ascii?Q?HSSU7hw/8OaUYLj8uE+UJxxWHcvIYa2ce1luY8OsugEe03V3XpCJEJab0Pra?=
 =?us-ascii?Q?yyk0r7nqGMZHQWIQFIRKZs19nn8TGK7beCFly6Xn29eLkSxLKHqHRcRNq7Xj?=
 =?us-ascii?Q?HFJ8XIptfYLlBwqtN0INnROkfbD10+dBrRMjZWTiNHKMjFaVK+cRlprDPK2h?=
 =?us-ascii?Q?X4jJE+clBCHra523ucZlVgphbpvGrbaEg4TnRjkJPfyPlTax4FEeyrtDDXT7?=
 =?us-ascii?Q?ZxY0/7AA3ws7++B6ukQebxnSZJTVikeSeYwF+UBZNFdL36Fi9i5SOk9DpMPm?=
 =?us-ascii?Q?Nbwei9/My6T4Nol0lsVrl5l6Q6qysbDCgqSer7JDbm/S64jg9iRoFGJU3Wdx?=
 =?us-ascii?Q?YrcwG911blu8+plSVWVp7SldjO8EaKnDQCvpVUoUOCgZTCRoUqdOE91p1AiW?=
 =?us-ascii?Q?1fTNgeZ31nYzpkaMgXyP3zlFgr7MHcm9xr4tRtzZlUHSL/X5t+8nxLlqqwyd?=
 =?us-ascii?Q?kVaXm02P4P6kRty0reY0lrKJjzmKhkBBJ6wl1UMT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a90743e-fd2d-4c8c-2a85-08ddb261215f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:20:40.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUD5bX34KhTF3H6C7gHKKFtHUAEf6powLJ0FAS7BNIWXHdTH7ghgvT7VudmP3n0k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> It's unused and the page counterpart is gone, so let's remove it.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-flags.h | 5 -----
>  1 file changed, 5 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi


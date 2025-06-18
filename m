Return-Path: <linux-fsdevel+bounces-52095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA61ADF61D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6633B5B23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD072F547F;
	Wed, 18 Jun 2025 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oiTIveNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977833085B3;
	Wed, 18 Jun 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272218; cv=fail; b=TT0Y+VCPflCmxHu5sus+IDfiCavBcDU7qTiMbFl0TeCBRF1igCYh5yZDQwHrtVDScOwspaFHouRT2wqE4WO1AjP6uB6rfkAQDcSR6MyzZDQDz34+7aOwgZA1gtOEBgflVX7xUysoNNH6u2XwJqvb1vjhpQ4pyM4jyc5Jq0W4kXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272218; c=relaxed/simple;
	bh=zNW89WYzZKsqVZiL6c33H2LmV9KcxJ1nfupzhjyeDkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwSVDcaOSbV4k3U7j8nWP8PlCAXm3sOlUKQvCAMeDO5cIHP93FaQg9+rDb3hVxfh5pPHJPF1ZUok0XipXsDR60sFLBkfn/3DDn1tS77GP26aRT0lKPXxBZwDIg04ztW9nGDUG3tIrce2IjjYWDVW3RuDGIWePCNJTozCyqQH5nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oiTIveNR; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYRkyXTMsYFBEFu8yQlCiu5835LwpfDr0rSz10WyMQwEjqOfipjIrFjJZF7g4ixwtllOtshFwJ+dUX4OW8oeK+Jp85ltCRFYJtMMHUX+dYK5+3dbIbDVoAsP7bgtmkQiuXtgVm9Rjmgds7I0ru8pykJOdKQoAOnWTV7SkbXmlIAOpkdnJ1Rn+0q7X53RJNHZkgTO/dVyd8bUGci7gnhqC1E00zr28sgkW9Ff81EZHHVRIEItMbvGaNh1qE21lTOOx99zE4D616mm7sWp1OX+8PEbNFSE+h6GI3c/pZDdaydhzWOEGbzwioUarwC02Ee4y4gxOFvoUtEyhQAuvA6uKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RXplM8E6CaIkOYBv3T5WetiDuYPIEPBaf2T+Kxe0nw=;
 b=HeMHcqDuXmkrxU6dCNwBG1Fsi0jVc2tKtvsIMBMKMKAniwawQC4mgL00ygJC2/GXnfZk0WItSJUWp6kKcL73VyGQKh4PctMcntEmE/o0cVzmy/PI6KH9QVK/iUYurkKcnHMBOc9dZaukIchmEnH7Rtd2Hd+N9ioyzh9T/VFD5JbNYOseEwqA9+mL6LT+KDhW2ms+mBwLzc2Gmc260b4QZpH+JKdcprUcOG3iQqHuIDDr59qSJx8wlLrS5mQwUezeXQUEpvYT9ACl+c/07xIItngrXhQLY27OX/Iegy2MRUTBRUnrCRgxoouku9JPbx+f8Sjolph3HV5AWo8nCr3oBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RXplM8E6CaIkOYBv3T5WetiDuYPIEPBaf2T+Kxe0nw=;
 b=oiTIveNRoQaPmBLxSeTSZZGnIYdR2XNDdXYbi3Yi9jz1LdJyvmx80FhNprfwrtNSr9iOzPu38xforTb393BHcb7zivr37pDwGV0W1bZR3pS+7XpaEpoORvKCWRlb3vfD/Kyy3W3YU5gDEFcKHPtXELYnqxzelZW3oZNI5phnc+3mQ9qHJowPaUZ3fplOOsuEwBBEGWKQYl+m0F1MvDLBdKgoI8xSHHtcfZun1XUhcvCw8jK14qSF1o1lz1oc+xiTZrHG8k+jT2ciuqgJo2xsHxruC0xvPDkSQfMXRiMtdAUxQV3bSaILZff4KJAw+5OLeNRc4qkwwRoWVMGk1Wyiyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Wed, 18 Jun 2025 18:43:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:43:27 +0000
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
Subject: Re: [PATCH RFC 04/29] mm/page_alloc: allow for making page types
 sticky until freed
Date: Wed, 18 Jun 2025 14:43:22 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <6E57AE2C-7754-4269-B16A-A39D168C5285@nvidia.com>
In-Reply-To: <20250618174014.1168640-5-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-5-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0890.namprd03.prod.outlook.com
 (2603:10b6:408:13c::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 949b0367-c703-4086-eea2-08ddae980328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmkR0aNc2DBgsm980yRwauSKUeRWdEa++yL2+8hLWx92H90HUJ1EHsz9ip15?=
 =?us-ascii?Q?4ym/QdJjP1vu2AaEnsocyOUzgGkG93km5WY1ntDgnv8yRzB22OoZaY8q3eWm?=
 =?us-ascii?Q?UpnDEJSsjb8bBMdCmQbdveyP4YgXHdo96ZOm/frQ135y4BGTvpyo2vkF8Ik0?=
 =?us-ascii?Q?CVD+NMtILFnPQmgfnKAzdBwBW2UgdCD00QhfIadWLyqWLvjJWRhRO072veIS?=
 =?us-ascii?Q?pfAQ4y7aGzrFsuPECUH5UXR68MwXNLNNg5LaZbOWGwYbfNQDiTzb2sI4qoia?=
 =?us-ascii?Q?R1dPJybm9IRrymseF4wGYaTn1z+vRiRpVNMfXrc04Lf9gJaT50Eo4woupCvp?=
 =?us-ascii?Q?RKOF6N518nx9vQ42PaJ6Cv1R/m4P4Z4VKHKH6B5FClpdzqKA8gxJWKPXPnPm?=
 =?us-ascii?Q?QPKhLvZh6OSPcyOC6NnmeR8mHw9AwzHWQnsInPZ6aDoUQ4vxAip4qk1W5WC0?=
 =?us-ascii?Q?P2CLLSWJnd9eMUQOl9jbPdsK0ldEt5x5zRcc2P5wxoG7w2mxtS40nj+9bNQw?=
 =?us-ascii?Q?/uKE0xZ6lWq+tG3EoGNv8m9eW9LQYks9J1a9z0Yv4leKmsdPDk7Pk440Bi+p?=
 =?us-ascii?Q?v4s+IK64MMQMiILW8SRnjT8/2EAMeP6x9xhZajGCPHeuMfiWPekWlT7CKOWs?=
 =?us-ascii?Q?1+h4geLC0sc8Ecb1aF88X0l9aKn7m9tPdttOu5vdzuAAXWpj7ULUyBmAxXqs?=
 =?us-ascii?Q?NEeALdHHPObXJzJbqydSWhRARUQGAskVAeb3bJmjqJ2Zba7TS+AoHvlmC2JN?=
 =?us-ascii?Q?m94NGkuCG+e3N5S630I3bWUrWXrNAjmwOGSsHqnqM5/CNtrNmaQA+19FL204?=
 =?us-ascii?Q?pEasburxrINrO6cQQbc+4eFZeMhOmc+gYrA7WRwZKNGBPvjJ0OUVZEMhwyvE?=
 =?us-ascii?Q?/+iLpnpTPGScKYhZv74JcKP1dJKbnVaF8aZ6Xgkp9eQBLRWnCsEcEJ9OUcvD?=
 =?us-ascii?Q?e1/pln1yxylj91aBdYq5nWaaOpkwu8zBkZpi82iBeb7pUTQyd86Uu5ZY+7h3?=
 =?us-ascii?Q?LGWAlIVsRweS11sds5kSmuedTrKxJeaC4PbNjsc63gASyzGBKS6OS5hwQneK?=
 =?us-ascii?Q?5RMl17hv/5aMqsFQ01d4e/LpnwQ+B6P4e6VgvGXYatOK4ZPWUqS4BuyyRdAe?=
 =?us-ascii?Q?uN2e/nui3JrIifE65RNITBqJMPbloI4xvV1ox64chZnA05ztMOjyFVvQdWwz?=
 =?us-ascii?Q?jQG2aGXNsVPB56vxPaJhiiTu/qhnxQn0Hx5Au9IaArANmh+HycXNSF4x4dfZ?=
 =?us-ascii?Q?Gqy3f/9yx5z/9e54FDckH5Uf35mCEM5XOnMLKgxq7Y2AC2se96NPdnyasEEa?=
 =?us-ascii?Q?/7WCWp2oJGL5CGApsP0iqhJ9iKYKOnfFRWbIndm6IDynHY4SQLPExHigF6HK?=
 =?us-ascii?Q?hGFCrA3vBnLSzmwRoCZudxImrRWWy+YT37dBiBYeeZVN14QMdnbT1V+PPVjj?=
 =?us-ascii?Q?klJI1efd4/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1SM1wTklyZUaCn04T9CQLDsIi1MgDjw+m5uzzUFyH3XclRcUYBNecwZHLRJe?=
 =?us-ascii?Q?z7JtqLp6myfVkNTIVtttbaRYMvWQbzJ+Iff3q71Snl5A9r9nEjhFa39oY7iV?=
 =?us-ascii?Q?vng3sSp3KZgpBWdVBC3UmpMQqV8GQIarunaPVeRki+S6hZdr8Ld5c9Pu0ro5?=
 =?us-ascii?Q?p+dpHKKY1go4vwop9zmQUW74Or+Jmo+h1hO+ZhfS/NS45O2crgsZBkmYnaFz?=
 =?us-ascii?Q?Jln4b2J8UHWzJsRSTbxVDsd+dPVsHpvXYXCnRXGYcBYqX6OyUaGjJiAlOQWH?=
 =?us-ascii?Q?m3kl842kUECMx+JnygNvVK2MosOCCmNEtTwZTTwU8WYwJnJlLR6YVYGIxYdQ?=
 =?us-ascii?Q?EwQM7Ej6tspTQnufcLC4Dx5V6dzbtMV0NdqgAdLaoZq+2yjSvhoF8IRcrS3O?=
 =?us-ascii?Q?9l+5MZ2IPkNVoKdIoHE/cg4nXaQn0Z9PVtwsexw3aTjsnNFvr3TurOLxaq3g?=
 =?us-ascii?Q?1W65QeRMu0OGv3Kd1UO4FDLP00N8xHy+h9KPYiaiQVSZ46gh7UlRSYBWOEts?=
 =?us-ascii?Q?rP+PZ/7GFiGTeKsWGNqVvLA0xU3fyfzic/svD+6eiXZ1DRUHxdj58ZX+sLIm?=
 =?us-ascii?Q?DhneTFWJHBCuzw5hQbokEwOjX5rpz0YmnIRhQ4mamylchtW9Sm5vzf0Nod1o?=
 =?us-ascii?Q?PNz488c8ZzSj7tMIhClUfeQ/Yazqs/iYwYBiqVQsuR3grd7b9ZDfSGMRv5fg?=
 =?us-ascii?Q?Ik0j0hCCkZb/kVLs4GR/JY1zYAFdPBp7amp91Wzd+fJOzeXNWYHQeJ+5wXm5?=
 =?us-ascii?Q?twZcBRVKDePnFdsVtdD9KT9bP2vtl8lsPxxHuiPv7Ah3UONJFBeoMYxNIfLK?=
 =?us-ascii?Q?Jm9z4fULSicE+dOXAk/bXM1hkHSoQBA4Ms5LKpJU/b4/ELRtnqHH50zwXeng?=
 =?us-ascii?Q?CSgejtkQeCd/spFkocg2DjGVCIl5sBDpFqBHCKTbIQjetJBSVGw7U57S571v?=
 =?us-ascii?Q?ufdjWmCK+FTTorgEuaRjaayhZPcUED8nXERcZGwymaLPnf5PtUViswGmZmWI?=
 =?us-ascii?Q?38iERZ0qZ/xF0tzUVIZsQTEMEcAxGvtraqTtxfuv/8yPCnEdOdYTQHX+7L6B?=
 =?us-ascii?Q?kOORdw6+EQ10twFQUBhOWGuMh3mh9LMeWAL4WsNhjHo8zJ2DGWEuE/9V96RF?=
 =?us-ascii?Q?FwDhvpSn0yGST6fseH+hm+0Hf6Q/DnRKXViz+PcRS0zq4Fk9ncHVAXg4ABr9?=
 =?us-ascii?Q?ua8juBp12uVJEnKuXGna2Xs2faQTvX0cnWBWhu9QvRSOUaBHFDGp5xMyILTi?=
 =?us-ascii?Q?ynsM8qC00U2SurUsF2y9Tk87HjTDvgMHLCZXC6y3NDe1Q+Q5nJAmvgF++Vul?=
 =?us-ascii?Q?n8doidnCUC1ZPswvpKpeGdmqcD7RQYq5FkoDcuAUxUJuM0D/du6tIfV707tR?=
 =?us-ascii?Q?fICLHUHgZgPC3ipxlhPXpdmlu3FejIvlTg4vntT/NcNotUJVGKnHttqaS0yQ?=
 =?us-ascii?Q?9PNOP4ZPWFN0kqdHkD1A26pUVUQfmrb8HS2iAylyQ/pg2h46IyXqCKJhy/cx?=
 =?us-ascii?Q?NZRfTHzBzlWzuPPJ+asFlXwJZlD8qzjd3Uzq2mzozPS4Wda5VJU41jsLlLeQ?=
 =?us-ascii?Q?ahTG4IXW+hl8NcvZHn0ITj8eO74nfYBZs5Yc8u3t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949b0367-c703-4086-eea2-08ddae980328
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:43:27.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8y6ze0PH3z9Ze3nAZkkcPBR1ho2dUH1Ndvpt9t05sGhMrUGrHOrEKkIuYQZMbAf6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> Let's allow for not clearing a page type before freeing a page to the
> buddy.
>
> We'll focus on having a type set on the first page of a larger
> allocation only.
>
> With this change, we can reliably identify typed folios even though
> they might be in the process of getting freed, which will come in handy
> in migration code (at least in the transition phase).
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 858bc17653af9..44e56d31cfeb1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1380,6 +1380,9 @@ __always_inline bool free_pages_prepare(struct page *page,
>  			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>  		page->mapping = NULL;
>  	}
> +	if (unlikely(page_has_type(page)))
> +		page->page_type = UINT_MAX;
> +
>  	if (is_check_pages_enabled()) {
>  		if (free_page_is_bad(page))
>  			bad++;

Should we be pedantic to only do this for PageOffline and PageZsmalloc
and warn for the rest page types?

Something like:

if (unlikely(page_has_type(page))) {
	if (PageOffline(page) || PageZsmalloc(page))
		page->page_type = UINT_MAX;
	else
		VM_WARN_ONCE_PAGE(1, page);
}

Best Regards,
Yan, Zi


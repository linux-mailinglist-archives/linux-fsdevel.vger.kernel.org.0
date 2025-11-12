Return-Path: <linux-fsdevel+bounces-68079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4DAC5350F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFF8134E732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A32E33A036;
	Wed, 12 Nov 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUjXcxWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7B29D28F;
	Wed, 12 Nov 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963420; cv=fail; b=ZJ5F03dZShseFY0mIqw6xbsxumSnsvuaxsagL7vMtI0z1MZaklAYUevOfDZzMhzWkQh4mHEPKm+8gBDHcI3vm0M6lxlyGW8aNqGhmX2CH5VSss8XFzjjZyRbVY49ru5OMIZdMmVDms1TEL5BY95F4ZiA6q8nOfkv+EPzp0iAGKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963420; c=relaxed/simple;
	bh=AgVJiW1wsjE7zVDx0hg0haO3jXL1EpLsUJnzgqJqDNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/zi11rHDfzrlg+yB8N8l8H+dY2jlKyQpzHYJK06QRABzZCkpiGcwHb+9cuK0jw4U/dUdMg7Vj1CF0t5WMwqTSLJ5cafcFRmE43Yokjl9WI0JZizY+yMi/LjL45VuyJx2unjPQkC1R1MiHP04ioSbqOINT4mQwRbQfpY9FYFgZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RUjXcxWm; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIIDEH1OP8W3kw0PPkqIhuTrWFUNb+w8/vFrI3O6qnqy/E1ncDzwRwgSyxqVineqMKYlmPoZQ0CpPu6E1bE6RWiFD+Z2PFHPFV+q7OGpKRhV8R3WcV9S/gvZmzT7EttSSg7zFwGaxOnLoRY4xjqscxM/lomr/6u7KCdLWlyvtL3iUMdvS2RUqwSIYWrR4hZKgvaMfioSjLb03G/hms48fEdd6pK+soZ/di/Gy5ua5kgQC9r6Hwy+jYhYpOax0vdLeZNcD5IqKyJ0Kwgpc1RiMYbBXUQ11ZsY85GPDxSwlcJFZEBsUXG7bbEHYWfucIPrjBNTzIWpy2bYXqohqQ2Pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sectjm9ynUQYmA+CWCEuq6pUMJlViS7YKlXsPFLkWLY=;
 b=MDMg+xsFiCYG29odf5utnBdWZq/59GmRxP3nuqOG8vpWRUv8jN4PAput3tXqmFDCcGaiuzRIFi0Z3AP1Hbxe0B4/7mgLLGPZnI5xkpOwzqhd/4HkQ1pxXKE5v6b/jhqOWfj4aWv7qS1pom5pm9svu2JiS3k8Q8uOJ5mC2qVc/Gp/RJkNmc7+6VzFk8fat79lAtB33tPdUFexoqxbl3jCJ4g5PSQ+m3i49bcMW9lZ8jbF8R6PpfGrIcGXXYqgyZtr8BzyftvJquWR8scpN4xiqAp0BKBpOX9JgovB4gfIYjsHLUvwRfYq5baFgvsn2wDEsjQS+N0+9scoRll+YDyM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sectjm9ynUQYmA+CWCEuq6pUMJlViS7YKlXsPFLkWLY=;
 b=RUjXcxWm4OuKy+F/ONFGEA6WeF1PXhZrXcrG8C3I++SAhlXXBGIWM6prnXd1nSE69NyBUekwi3Et9TE/TWuXVCIHwInl8HGYlO57igLQKunItGdyEOzijzAgt/zE41bmU6X2ujC7rXhzlPSoanTr7M3BHSClsFXtEF+7N5PH2jZK4XFqpYux0HQ1MNYOUGjQ998Hs6i7UbqQHv0+kBtyIFQui5+PdNrsCsOCWgN1S7OMVOzZk3J+0ABl8Fs8d/M9pDJNevnMj2THabklOzwS2LJX2Qpfn9/CHah5Jc6iS6XRZ2JRbRai8xRco5EzCR6H9uSrGVZJZyKjgJ6UEmzWbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Wed, 12 Nov 2025 16:03:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:03:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
 Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
 SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 03/16] mm: avoid unnecessary uses of is_swap_pte()
Date: Wed, 12 Nov 2025 11:03:24 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <D80CF897-63BE-4C11-8363-57ABD5303DA1@nvidia.com>
In-Reply-To: <c69f57ff-c4b1-4fb9-8954-c5687dc2d904@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <17fd6d7f46a846517fd455fadd640af47fcd7c55.1762812360.git.lorenzo.stoakes@oracle.com>
 <B114F7B2-8EDA-44DC-8458-79E3FF628558@nvidia.com>
 <c69f57ff-c4b1-4fb9-8954-c5687dc2d904@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:208:530::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f682b5e-b267-4fe2-870e-08de220505fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQIRL35Pepwr4w08N5BiBpcbB6sVQJCxB6+2lJ2tYx3I8ZvM90Ur/mIxog6L?=
 =?us-ascii?Q?hCoLbC+OlI6mQZKIayaXvWoDRHtF6QrhFUp/ZvCCjTyj9MQ8a9cOYFR9OzSg?=
 =?us-ascii?Q?4wcefxmOdZcwExGYlG8p57fxm8TxkZgYknK7b5f4LGJwTmQDCMBzsomTkV2h?=
 =?us-ascii?Q?KrV7uyjOHe/vo8q7+eWKjykna6AHkvuZ/i69yICZSIWVhFz3O8atOKkje/du?=
 =?us-ascii?Q?ChlxWhvHoAQZhsZM3evkY9LTSbkI17tusP5PfalQbMNh0Nb7kJlL7VVocF2e?=
 =?us-ascii?Q?qzM/tm8UhLwhrwOZaWfj8axauA+DlR6QGG42KUOFf9e56VRpj7Rpv61Upk2p?=
 =?us-ascii?Q?BzVzMcfYdCYyvXPSPA8WkoJ5Ac+nKZJ54LTv+ct9eJhjVvAzJEZWg+7SEpVv?=
 =?us-ascii?Q?XIZcMZFWfQ+dAYD3HwDxB1v9CHi38AExEX8w2fwSE29B9+r0jjEvlwOvh4Bw?=
 =?us-ascii?Q?OcZup+ORMs6A4u89XPmZ9DnCPcPmNpvoazADkiv2RJz+DxyGb4davtZ6dJtg?=
 =?us-ascii?Q?gU7fvBfHBTG6SoWTbLusHUT/Ye1zBSmOSc7HikOlWwQhkZamBPiheMRRWu8K?=
 =?us-ascii?Q?wa0PmssoqbyW1KIW7nxqpei1t6SHD/+MR/UWzY3vM1Q5JDbU54bt1TYy/+bv?=
 =?us-ascii?Q?eTEDqLIyx3jw/3cSJY9I7PAxHkgDX7FLZjFZ8fhAwmRPiMp8AJXAsKhgMG8F?=
 =?us-ascii?Q?QM2fEg8PMoeYi21t0LSUjiIjGeEHjxqGJcgYXOcFLgIJbAQd3YKjkx30+lOZ?=
 =?us-ascii?Q?6I0CfHpVNtfJbrdbF5/UUhj8d2vA5NAkM9M3XN84Y0rnaHLJ0rmZhg8zDHfr?=
 =?us-ascii?Q?j73o5rH2Xa/lwEGPpcWjBvOdKwY3Nf4/VlzM/sP0r2MayXhFuQU6vdVplxAs?=
 =?us-ascii?Q?6lbv4mpl+AO6aE/IT/dm9pb48u6IWd5K1ohbo4FUlv4Vu2BaWRORdS7FzSZC?=
 =?us-ascii?Q?VULCvGqJD83DfX+M6JPycYBN/jGSMxAOCMakTusx72y0JCfhDlwJhL7OEJH5?=
 =?us-ascii?Q?0gC4/Y/lVDL2zTkm5oKfqn2+NEJv4P1QvGNeWynhqJ7iCL8Ksnm8BEFoaWcY?=
 =?us-ascii?Q?kLlsxqQINQ0fHXoU3zwjP/hOb3CAgOF9FzDGMur5f54r1KGxGHZoL0c6Os6W?=
 =?us-ascii?Q?bm2enr7QGm3TBd6sVbJz3mkeu0lzgjb0c34FAtxJ616ujX0dZXELQnsMfeRk?=
 =?us-ascii?Q?ct9KyaE57AtXkHp7Zfx2EIqGjOZ1pX/JgD2QasSm6J6GK6OJo2efEbYVuxxb?=
 =?us-ascii?Q?sJxbJRyFpRAm3u4EcboRRGzukm73COgZW5luEpjT450guVOYCyxDM3ucSZdF?=
 =?us-ascii?Q?xJhOsG1waFbYdw7nnGRpmIz4UJZNhezkalKeRGRjorG9ukD4N6w+8ofyVfch?=
 =?us-ascii?Q?+ho5mLd2REJFfWJNfhXNHpH87TP/o06TydgkQCiLHNd2WCNRWK6VVrMhXnhN?=
 =?us-ascii?Q?57AmrVaYYT2MbUJkZlBHfEbpGqqAD4Jh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Ar6TOuG3IS1ZY5NAiTNcsgfeSqYfi6SDohhRRf+rs+0LE/FPVOytUvuPGRv?=
 =?us-ascii?Q?Bf+6UfSLnTOr8RTg0n1K5yJ55MNAEwREz0S5X0OBVL0eYNvmEImTmaPOMXsX?=
 =?us-ascii?Q?SoSUJhnWJ7FXHASSiz7vDO3xJHW3j4dA5/DWaxtNukv+mQ3Ir4NTNshPmMH0?=
 =?us-ascii?Q?fNxY/PX1CzEXMOUllodsrtw+GhxteOOL8JHTVFodD8sHKRQHZnKCfQgjdB9b?=
 =?us-ascii?Q?gzG8erOgNEbrkYqodlXMGNO3dEZvxNuxjTLDquYXMUb7P9WlB1j+6dNZoD17?=
 =?us-ascii?Q?PsmsjzXjfN6YhyFgTr3BDP65kLd41SYGN9iRvyRY1N25ocgt39gE2VasZnoM?=
 =?us-ascii?Q?EfEAgU5a7if4Cjka7QddPHX4hJpQGwU7L2yVkTkc2iDRBmjugdx3S5G4+vcS?=
 =?us-ascii?Q?lZaFyYL0y1MyL05xuVqvhXUOd4VG9LaTxQVcKd0K1R5RLJJj0Ucw297VxPUX?=
 =?us-ascii?Q?qv2epHUsbvadWSW+vVkUmhaOgEUzLwVm2TjbvEQq3t5tmq2OKldWifcUcXQ+?=
 =?us-ascii?Q?0+Ug1XJRrE5w/UK8Qq0JsIi01V6lF2SCmgKmr7C9Q8hhW7V4UFuwKVwxz5hb?=
 =?us-ascii?Q?9UdHcrlWd5Ox0sXRDBm4G3WCNXejN27YXvuRN12U9cbkwHOeh+V/Ms5x5wOT?=
 =?us-ascii?Q?6ItE39rL50jdxjB5ZxwUSCf59aI0h7H7aR+kRHfGYxMufQpuoKzvm4/7gXDo?=
 =?us-ascii?Q?n3jaLzRzP/erfEnYTldKhFmPTNc2QnzBcMBxor42DniXpd3kHcUXocfj91tx?=
 =?us-ascii?Q?gJJpghTUMJSa894HRwOqO/PnRoatSaq7iW85koueIOsDJ/+GbTSLBjaDscuC?=
 =?us-ascii?Q?hz1Cfh75cJ7c/A+fNzbm6tfxuhapjKWvdsxYXyFO4z6bGTm6u+RHz1wJiZQ3?=
 =?us-ascii?Q?rXU7aXsUCQwDmv0z7HmEzHjQvWXOw04tnSVtePufCabbAcHsFQeZN6OIaZnN?=
 =?us-ascii?Q?mNrAr+V1bakWEw87ZcJCui8jG/mhUF42zwtTD2w9/fipv1urGQ4grw0kGeS4?=
 =?us-ascii?Q?vCaMGSMEfmpxiY4gvk0UBgu6SWS0yLGXllvmlH9MUpplSiwyNEYcBKrs+QoH?=
 =?us-ascii?Q?vqLsGwi/3Mabu8pX2EX077hvOSKrAC7qiseFot+WSPYIhMyfTT0vlORHP8D4?=
 =?us-ascii?Q?kQ+TWAmmGEIjxG++UkbITM5o7OgQBBCZUi6k8Esw34KtkrOXanFFpF8hj4CQ?=
 =?us-ascii?Q?n0ORUN8APxvmp0YHxHVygxTh12210JC3/kgYrYWa90T2ZmKJ1qioZINw8RHN?=
 =?us-ascii?Q?BNdzTHVYWhnaiR7aGJTj3G7w6A3KjqmKQ5kQS4tcD3JDZFM47ONGYH4pYXTg?=
 =?us-ascii?Q?kv79AKiAE4CCTmf2x75OgpXb5CPfKf2KRBP1SUXLupIDHFWb9TZCjQRVyrgH?=
 =?us-ascii?Q?ABx+kmFSGm7I8B2+hsKDwBrBFKQGtV89SYsHT+D663cAFxkbxwIONTMpkCoA?=
 =?us-ascii?Q?RqXGSLgRmHlZnXm7Us54VPXI9Wss09GJ8OTHYfbUunAi73W03jUZWImddLdz?=
 =?us-ascii?Q?28VDnljaenB+DRXqcUK9czzA3tGQLunSPPYcFUlOWA2SC0scmalog6Xn+HAl?=
 =?us-ascii?Q?LYO4ziu4UzjTlykl+4QWY/e04YlOAtcNrLQYEAYw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f682b5e-b267-4fe2-870e-08de220505fd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:03:30.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdWotTRfQizcDq3G+HAQkUOz4mQZqn4CfoOfum5jRikXSxrd3OW37z3iwHgMp5hW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359

On 12 Nov 2025, at 10:59, Lorenzo Stoakes wrote:

> On Tue, Nov 11, 2025 at 09:58:36PM -0500, Zi Yan wrote:
>> On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:
>>
>>> There's an established convention in the kernel that we treat PTEs as=

>>> containing swap entries (and the unfortunately named non-swap swap en=
tries)
>>> should they be neither empty (i.e. pte_none() evaluating true) nor pr=
esent
>>> (i.e. pte_present() evaluating true).
>>>
>>> However, there is some inconsistency in how this is applied, as we al=
so
>>> have the is_swap_pte() helper which explicitly performs this check:
>>>
>>> 	/* check whether a pte points to a swap entry */
>>> 	static inline int is_swap_pte(pte_t pte)
>>> 	{
>>> 		return !pte_none(pte) && !pte_present(pte);
>>> 	}
>>>
>>> As this represents a predicate, and it's logical to assume that in or=
der to
>>> establish that a PTE entry can correctly be manipulated as a swap/non=
-swap
>>> entry, this predicate seems as if it must first be checked.
>>>
>>> But we instead, we far more often utilise the established convention =
of
>>> checking pte_none() / pte_present() before operating on entries as if=
 they
>>> were swap/non-swap.
>>>
>>> This patch works towards correcting this inconsistency by removing al=
l uses
>>> of is_swap_pte() where we are already in a position where we perform
>>> pte_none()/pte_present() checks anyway or otherwise it is clearly log=
ical
>>> to do so.
>>>
>>> We also take advantage of the fact that pte_swp_uffd_wp() is only set=
 on
>>> swap entries.
>>>
>>> Additionally, update comments referencing to is_swap_pte() and
>>> non_swap_entry().
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>  fs/proc/task_mmu.c            | 49 ++++++++++++++++++++++++---------=
--
>>>  include/linux/userfaultfd_k.h |  3 +--
>>>  mm/hugetlb.c                  |  6 ++---
>>>  mm/internal.h                 |  6 ++---
>>>  mm/khugepaged.c               | 29 +++++++++++----------
>>>  mm/migrate.c                  |  2 +-
>>>  mm/mprotect.c                 | 43 ++++++++++++++----------------
>>>  mm/mremap.c                   |  7 +++--
>>>  mm/page_table_check.c         | 13 ++++++----
>>>  mm/page_vma_mapped.c          | 31 +++++++++++-----------
>>>  10 files changed, 104 insertions(+), 85 deletions(-)
>>>
>>
>> <snip>
>>
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index be20468fb5a9..a4e23818f37f 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped=
_walk *pvmw)
>>>  static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdval=
p,
>>>  		    spinlock_t **ptlp)
>>>  {
>>> +	bool is_migration;
>>>  	pte_t ptent;
>>>
>>>  	if (pvmw->flags & PVMW_SYNC) {
>>> @@ -26,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pv=
mw, pmd_t *pmdvalp,
>>>  		return !!pvmw->pte;
>>>  	}
>>>
>>> +	is_migration =3D pvmw->flags & PVMW_MIGRATION;
>>>  again:
>>>  	/*
>>>  	 * It is important to return the ptl corresponding to pte,
>>> @@ -41,11 +43,14 @@ static bool map_pte(struct page_vma_mapped_walk *=
pvmw, pmd_t *pmdvalp,
>>>
>>>  	ptent =3D ptep_get(pvmw->pte);
>>>
>>> -	if (pvmw->flags & PVMW_MIGRATION) {
>>> -		if (!is_swap_pte(ptent))
>>
>> Here, is_migration =3D true and either pte_none() or pte_present()
>> would return false, and ...
>>
>>> +	if (pte_none(ptent)) {
>>> +		return false;
>>> +	} else if (pte_present(ptent)) {
>>> +		if (is_migration)
>>>  			return false;
>>> -	} else if (is_swap_pte(ptent)) {
>>> +	} else if (!is_migration) {
>>>  		swp_entry_t entry;
>>> +
>>>  		/*
>>>  		 * Handle un-addressable ZONE_DEVICE memory.
>>>  		 *
>>> @@ -66,8 +71,6 @@ static bool map_pte(struct page_vma_mapped_walk *pv=
mw, pmd_t *pmdvalp,
>>>  		if (!is_device_private_entry(entry) &&
>>>  		    !is_device_exclusive_entry(entry))
>>>  			return false;
>>> -	} else if (!pte_present(ptent)) {
>>> -		return false;
>>
>> ... is_migration =3D false and !pte_present() is actually pte_none(),
>> because of the is_swap_pte() above the added !is_migration check.
>> So pte_none() should return false regardless of is_migration.
>
> I guess you were working this through :) well I decided to also just to=

> double-check I got it right, maybe useful for you also :P -
>
> Previously:
>
> 	if (is_migration) {
> 		if (!is_swap_pte(ptent))
> 			return false;
> 	} else if (is_swap_pte(ptent)) {
> 		... ZONE_DEVICE blah ...
> 	} else if (!pte_present(ptent)) {
> 		return false;
> 	}
>
> But is_swap_pte() is the same as !pte_none() && !pte_present(), so
> !is_swap_pte() is pte_none() || pte_present() by De Morgan's law:
>
> 	if (is_migration) {
> 		if (pte_none(ptent) || pte_present(ptent))
> 			return false;
> 	} else if (!pte_none(ptent) && !pte_present(ptent)) {
> 		... ZONE_DEVICE blah ...
> 	} else if (!pte_present(ptent)) {
> 		return false;
> 	}
>
> In the last branch, we know (again by De Morgan's law) that either
> pte_none(ptent) or pte_present(ptent).. But we explicitly check for
> !pte_present(ptent) so this becomes:
>
> 	if (is_migration) {
> 		if (pte_none(ptent) || pte_present(ptent))
> 			return false;
> 	} else if (!pte_none(ptent) && !pte_present(ptent)) {
> 		... ZONE_DEVICE blah ...
> 	} else if (pte_none(ptent)) {
> 		return false;
> 	}
>
> So we can generalise - regardless of is_migration, pte_none() returns f=
alse:
>
> 	if (pte_none(ptent)) {
> 		return false;
> 	} else if (is_migration) {
> 		if (pte_none(ptent) || pte_present(ptent))
> 			return false;
> 	} else if (!pte_none(ptent) && !pte_present(ptent)) {
> 		... ZONE_DEVICE blah ...
> 	}
>
> Since we already check for pte_none() ahead of time, we can simplify ag=
ain:
>
> 	if (pte_none(ptent)) {
> 		return false;
> 	} else if (is_migration) {
> 		if (pte_present(ptent))
> 			return false;
> 	} else if (!pte_present(ptent)) {
> 		... ZONE_DEVICE blah ...
> 	}
>
> We can then put the pte_present() check in the outer branch:
>
> 	if (pte_none(ptent)) {
> 		return false;
> 	} else if (pte_present(ptent)) {
> 		if (is_migration)
> 			return false;
> 	} else if (!is_migration) {
> 		... ZONE_DEVICE blah ...
> 	}
>
> Because previously an is_migration && !pte_present() case would result =
in no
> action here.
>
> Which is the code in this patch :)

Thanks again for spelling out the whole process.

>
>>
>> This is a nice cleanup. Thanks.
>>
>>>  	}
>>>  	spin_lock(*ptlp);
>>>  	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
>>> @@ -113,21 +116,17 @@ static bool check_pte(struct page_vma_mapped_wa=
lk *pvmw, unsigned long pte_nr)
>>>  			return false;
>>>
>>>  		pfn =3D softleaf_to_pfn(entry);
>>> -	} else if (is_swap_pte(ptent)) {
>>> -		swp_entry_t entry;
>>> +	} else if (pte_present(ptent)) {
>>> +		pfn =3D pte_pfn(ptent);
>>> +	} else {
>>> +		const softleaf_t entry =3D softleaf_from_pte(ptent);
>>>
>>>  		/* Handle un-addressable ZONE_DEVICE memory */
>>> -		entry =3D pte_to_swp_entry(ptent);
>>> -		if (!is_device_private_entry(entry) &&
>>> -		    !is_device_exclusive_entry(entry))
>>> -			return false;
>>> -
>>> -		pfn =3D swp_offset_pfn(entry);
>>> -	} else {
>>> -		if (!pte_present(ptent))
>>
>> This !pte_present() is pte_none(). It seems that there should be
>
> Well this should be fine though as:
>
> 		const softleaf_t entry =3D softleaf_from_pte(ptent);
>
> 		/* Handle un-addressable ZONE_DEVICE memory */
> 		if (!softleaf_is_device_private(entry) &&
> 		    !softleaf_is_device_exclusive(entry))
> 			return false;
>
> Still correctly handles none - as softleaf_from_pte() in case of pte_no=
ne() will
> be a none softleaf entry which will fail both of these tests.
>
> So excluding pte_none() as an explicit test here was part of the rework=
 - we no
> longer have to do that.

Got it. Now my RB is yours. :)

>
>>
>> } else if (pte_none(ptent)) {
>> 	return false;
>> }
>>
>> before the above "} else {".
>>
>>> +		if (!softleaf_is_device_private(entry) &&
>>> +		    !softleaf_is_device_exclusive(entry))
>>>  			return false;
>>>
>>> -		pfn =3D pte_pfn(ptent);
>>> +		pfn =3D softleaf_to_pfn(entry);
>>>  	}
>>>
>>>  	if ((pfn + pte_nr - 1) < pvmw->pfn)
>>> --
>>> 2.51.0
>>
>> Otherwise, LGTM. With the above issue addressed, feel free to
>> add Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Thanks!
>
>>
>> --
>> Best Regards,
>> Yan, Zi
>
> Cheers, Lorenzo


Best Regards,
Yan, Zi


Return-Path: <linux-fsdevel+bounces-52103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876FDADF6D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDFB1BC03FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90D1A2632;
	Wed, 18 Jun 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TA1fkcXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D521018A;
	Wed, 18 Jun 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274765; cv=fail; b=AgRL+9SQ4Tp0aGZbxqRG92otJGJrGlHeZAmZZ6cuP1ovOH/Uo48V1jpdwjgJR8pYvmm7WfdSG4u7T0cP/1QZrzbxfyPilaLDraCHdweY4oDxbl3C4XLcM4+wq6G95hyFNTIz69TS7XZy5aWk+3rO1YwDGrehO0lRFfSgao7z03c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274765; c=relaxed/simple;
	bh=CTZTs4CzDcNR26c2A0EdxDB8t0vvKvr5IxQLg+hLxDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdcAkxPQcRCgr1FMiHGLesjQ7XPoUhOCEfIhPnlJwID3A26jz3IUO+Pge/cLeHPRjvfvRmuURZlcLYYD+Le3nVCRaBWmhgOPXXx9OTpDpE3YVwOtY+DNeeJb8theruEGelRAirLQznRDVOZEYPHc6l7i3wJGS1lN2NLnIF1hCgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TA1fkcXO; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e95wuyhQCcCJe/TMOm1H4rhQ/8PdFpQiyclSRgrgq707TYQ45zTaNBc1+EduDLyw+OqPU+GsiTk3Hm9qzEFKI9w4yghjcv+QzTMuVBx4rHD10rzZu4x/unELUjU+foiQ+Y9uXP2E4V0m2EZIwQ8npDht7hEPsPR17UrndXZ7gszkW8ldt9cr3pIQAZ/MJpUhDzzlJMBGMHY4d9hOtvtmlMII4N7IraZGBxlqVqQ/i8q6dn5GfU7vBr+LPhiJvCqUK3cmFPd/+YBzqkmpnDgLJR5pIe3Kv4O1bT0wnxsBjZBb2vRDhkTmA2mRaQjmkoOxlqvz8knwQaJz5tP6ycU/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHpOYWtvNl5wNcpVXPemlz5PEWDe3QTB7g5UHFpdq28=;
 b=YV5TZAFAxk6UOLs/2XX+0Dg+dlqc5elIN/Bfftg7E35p0yns7W5RR5P0vrafjZQB+S1rJ8sPLBpnbmnycyZAX6o4uEZ0HIHKPvvFfVgHhDEyfV+8DeAfnTnxQu3Z96kf1XtS2COZ5XwbPlpIgoW7DA6NXvwJeRiWxlS/8huaphftZRBbeEbvTht2EAi6Qf3EZCp138YSnIDWaQS7LxVpRtKYnykkjtXPUaZ4SPGg0h/notUDJ1ghN0Gvo0jqPIhgGtJhmXVmGiBipBOavg0GGbQYkUCAi3krTl8CEZFHFe4YT9oKp/GT19WCdmTNfw+SKFAO73vCUKCz7N2hQ/qtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHpOYWtvNl5wNcpVXPemlz5PEWDe3QTB7g5UHFpdq28=;
 b=TA1fkcXO4RFY5RGexCLAHDPXdULYqIeEKsk76IFjiQ9Mz2sf+Qfsk02RExr15OoUcOIpWZ6rxHXOv2YoAKT/0LWoQB74NX7NTRBtbAg0CJUlGiwYV/Q4Z56QpvyAE1GoIosNw9psJMtxrzQ4Gw23FYHxZ3eJLAVDy3JjEVJM5TEVjTIOgEYKdilMhgq8N0nxzz7nvnojXMPhAhL3AcWhRm7y7sMXPt024wPXEaJcPRZBml8MMQiEJulQ0TnknR25LMcvjpF1V4j5bo3R7gjPW5Z/oR9/01sxNgOvXDCfRx4OD4fAiS2g9nZfY5E1FwMkmVUg+6AlGwd3H5MgS/bTGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 19:25:51 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 19:25:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
Subject: Re: [PATCH RFC 08/29] mm/migrate: rename putback_movable_folio() to
 putback_movable_ops_page()
Date: Wed, 18 Jun 2025 15:25:46 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <DABB8764-8656-44A8-B252-0240F53BC0E3@nvidia.com>
In-Reply-To: <aFMQ65hUoOoLaXms@casper.infradead.org>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-9-david@redhat.com>
 <AD158968-D369-4884-806A-18AEE2293C8B@nvidia.com>
 <aFMQ65hUoOoLaXms@casper.infradead.org>
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:52d::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c6f771-c9f0-4248-6aca-08ddae9def6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QpA+UUQzQFymJ5z0A4Q/ykjsq7dVColX2YxYhsSkH002+xoT6mCwC5/xgu/Z?=
 =?us-ascii?Q?/0DZd2PXBDX81swpzmY8OBAuoZ0OZqrCFCsdcuGfz/e4B68qMa8GroeXIS+g?=
 =?us-ascii?Q?zLYjYHpLQ3KhMXhzIcfh/RHhc1CVwtZ4KavFCADFLcWYjbXRhktMlWBHBYhs?=
 =?us-ascii?Q?jI02c5EU2xgX3QfpNft4Yo/cDPH/VkP0FiTPHaB9TaubAAS8L32vnziVgWrs?=
 =?us-ascii?Q?Lao3VrqBVF9KqdYaNz1Jf81DdnzwEeEw9Tn3K6sVRLVszboaS0AOy7us8/RQ?=
 =?us-ascii?Q?xq/4nWJ2Mgiqclp6sZA+ah0xxqe/b7SLAc6swRgdMHcyykDF6IiAR9ctjMv0?=
 =?us-ascii?Q?DIBB/T5HFVcng84/Uof82V8fL3JlCF9Rw1YMGpzQ4j13c2gF+W2K9KPRyb9K?=
 =?us-ascii?Q?HgYjCED6ELRhAORCFO5xaLYxDfjNTfCVQ/xtQrVAEliJQXtRH1LQkfzliOmn?=
 =?us-ascii?Q?QfK/d6khz3FaDsevbKvlaP5Z+pqfRwxRtqfU7AfoeTQNUKAVN+lGtQIVd9mc?=
 =?us-ascii?Q?ft8IQG18f3bRdQnOmGMP/bRoaJmUk3Mz0fFhXDFSG5KiX3uzHV+ABc65jhZi?=
 =?us-ascii?Q?CO7aEYJZ696wFFyTxu8F0Ai5WPqqY8g5lWkzA4Nlzhj4XYxAJwRsGCEVyZab?=
 =?us-ascii?Q?C11C+x82cH4cZ9+Bt8NXmLIO1GQ8/H9HnHCRtKKjt+WbFrOF4pfSYYlfoq3H?=
 =?us-ascii?Q?VhMCHqPwGQu7pU5MEio6qTDLK0JBTYIUWvky/Rz0R/75pVewIb45fAhFUX5+?=
 =?us-ascii?Q?XtaemHwEa+scU50be1/MflA46u4QXbEkRYCC4ueDF4PS0kA/F7FRT+s/sNyi?=
 =?us-ascii?Q?VMS7eP96n7Vgwh5rbSg2GBRIp25XtER6uMDYshy0iVZZiFUOyP2lK2olFv1U?=
 =?us-ascii?Q?Sw20xPnKVqzqYUmYYX7wIWy52t9jDkw8B8IEfQoLATGUowIed+4n3eKQBhwE?=
 =?us-ascii?Q?XMRFc84UjU6MTvQSVAK/ElsFZy3pgYFJg427h4gsnJSv2QBpxLDORgyTnzRk?=
 =?us-ascii?Q?SrCP9v52psRgqOXbt/4M6iORytWDgFzMSbKyphKJUJUQK+9K3aRpUThds23l?=
 =?us-ascii?Q?al6Y/9Af29VJGqfU2GNlQL91zzx0gXLLsrv39tEAE9ChHzKFvXiUNM1Dd6MA?=
 =?us-ascii?Q?mOnuLk6bstWMw7JRVvRvVzBIOM2uqAk8FHJekaA7Dr/1peiWVMPSSLnlVi1O?=
 =?us-ascii?Q?zxf4xdWiQiGJ3HPm1w3yv/siVNN0ZWMaECgNbsOO+pt1i5CGDq0i0OdDwYbX?=
 =?us-ascii?Q?CBCBpG138XmiryxxEwIHhQYPiEJO0ZOfq+Rsp+/0OdReH3WM8k27KZlKmlT8?=
 =?us-ascii?Q?OHV4eiyjno0wDoB5lpmVETC5sE9xiX+++v28W1VqSAt+aiLge11ugxRWHjrx?=
 =?us-ascii?Q?3gVKBHWntYCv8rh5cG2rKyUrj9LIneJYaQGGDFXglLqDrR7kiG/GIUc4Lm8u?=
 =?us-ascii?Q?ATJjJ664/LM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eVhQ/JYxmuxsENmlDZfp3SDWU+zISOsHXcw/nFJAe4DQZDSzUSVLDRgrLZ6M?=
 =?us-ascii?Q?N1uiEQGI6QyGD8dJ2FN6jd/dft9PXUPfVgzVo9b59vNp/fROWk1Je8ak0vKC?=
 =?us-ascii?Q?h86suQ/SGIIJu/AzI+7bTUG+gctyGlOLr2eXMzfsPEvf/+fmLO+L1I9cY5IV?=
 =?us-ascii?Q?4juSo2c6xPfgS0I0W5ge/ieTuRudFD9+v2BkRm0u/VVJjxGDBpVp+pQmqknM?=
 =?us-ascii?Q?fu49oDqVtyoSZ2mq9bXPrWcHNl4oe9WU0MGhrRe9RVIpG5Ht3VUVzXb1cFXl?=
 =?us-ascii?Q?k/qJ1z4k5sgTyOsLLDaSRPZbDWj94qA2Dw8GgvvthxUZltfH6HghdT0BEN2q?=
 =?us-ascii?Q?j33TgpHBbeVYCaSyJIMFg52owtEdtZLLmJnnJ+JtoqG3oV0N9D14zNPzIzoc?=
 =?us-ascii?Q?h/94k9vTn0+0g21yhlBFHOmJhtAE+L1dOvpeLqSlebPdRQ6EvBG9RXZam3Oj?=
 =?us-ascii?Q?onDMGw+GsdHAzpY0UBi/SEcEzeDkl3zQpoK8kMwgRmkFc2dezVb1FrJVc4tB?=
 =?us-ascii?Q?TWk+UErk7WVx+xNqDuVwbnSriOtdEDOGQnhmzMFnnXN8rno1RavQeI6T1nPa?=
 =?us-ascii?Q?1CqPo4CWWRKWQXQ28dfiV9mJlhpgQ2x2lpgPkkgtO1jif+ARYlYoAiibreBB?=
 =?us-ascii?Q?Z93skL7qEEGYyywjK2DLbDq61YeaSpRuRLBrMv9LaGSBDP0+ULs2bAobsyn9?=
 =?us-ascii?Q?ORZkMBtPEfDq8psJZGiALYoIsUaSykWpugzYWjHdUPbNx0RgNtsVoour8eX1?=
 =?us-ascii?Q?GGHovSR1ePrzHH85z+1CW0C51XZm+eZxxI6WrSv6PiqvZBcRilXxJxOjRhME?=
 =?us-ascii?Q?ZZ7kAJ6/urfZR1B34ktlImyblDuwoTRel3R/Mhb0UpJ17EBQnlTF+bmBMSVS?=
 =?us-ascii?Q?+6aIDhAKIVe+q1XyGvKaTdptTvJxyHQfInA1Oqig4EdjBbFnpetYOzLY8TdE?=
 =?us-ascii?Q?IuN7t5+RYDFwsbel2keesBrqCAE6riKWcCKs2WtFcl9S6enVxDYYuUmSu0Nq?=
 =?us-ascii?Q?lxSMSvblPtPoszTDv/S7wlBKJbfhd4IZ3Hk2DjYHjuc2f7SMtz8aO/HCCUV1?=
 =?us-ascii?Q?doAkc+3e2BV8hsZrCMKnMNf+xUzUlQznttk+H8JX16ZpFW3jiCUwdNQQjdXe?=
 =?us-ascii?Q?0CRssxAhiq+3M9nb/y4kmK86muKZzRwvchlA9ClnEXPzwH0L4fNIWoskxcp0?=
 =?us-ascii?Q?6A/Z3A5+fBT6YzinTugXfw2L7VEI18FG3bO1bXGFOKaqS+APBj4jqjj7M9Zk?=
 =?us-ascii?Q?Z2pzoJqsbSmk65FHcHpY4DtWslXqSVNVpseDwh/kDyiesskEGySwoXQeeOEE?=
 =?us-ascii?Q?ww0WWFpTpZpTh7TjmogAMeuZZf9tfMXuwJaUFA2q7IcdER5XV5jdIWGEtPLc?=
 =?us-ascii?Q?m5orhFwgCuhjqtgHtJeRxFC46POyWE6vqkkX//tpR8oktK4PEGsumAZL4u/v?=
 =?us-ascii?Q?jLAntgqURWOUvh8SSHZhlW882YijnqsAN7bLBU3xlicD0Uqm+YvhpHwNO2lv?=
 =?us-ascii?Q?lHfr5SHM5ha7fHCqjWg+L3amvr6IK4Zk0VWwDSux07BFZY2T8bQhoSiOcGXJ?=
 =?us-ascii?Q?i2G3Rxk73fOxvZ6rvhk/xilBNDW+SxGhEOfWw/4i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c6f771-c9f0-4248-6aca-08ddae9def6c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:25:50.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6bpy9/7npy1Dr3r1dvNeDHkkNH9AY6n5WdOuJjROVlp/QFzqL6XsL9f6RXmE+0o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723

On 18 Jun 2025, at 15:18, Matthew Wilcox wrote:

> On Wed, Jun 18, 2025 at 03:10:10PM -0400, Zi Yan wrote:
>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>> +	/*
>>> +	 * TODO: these pages will not be folios in the future. All
>>> +	 * folio dependencies will have to be removed.
>>> +	 */
>>> +	struct folio *folio = page_folio(page);
>>> +
>>> +	VM_WARN_ON_ONCE_PAGE(!PageIsolated(page), page);
>>> +	folio_lock(folio);
>>> +	/* If the page was released by it's owner, there is nothing to do. */
>>> +	if (PageMovable(page))
>>> +		page_movable_ops(page)->putback_page(page);
>>> +	ClearPageIsolated(page);
>>> +	folio_unlock(folio);
>>> +	folio_put(folio);
>>
>> Why not use page version of lock, unlock, and put? Especially you are
>> thinking about not using folio for these pages. Just a question,
>> I am OK with current patch.
>
> That would reintroduce unnecessary calls to compound_head().

Got it. But here page is not folio, so it cannot be a compound page.
Then, we will need page versions without compound_head() for
non compound pages. Could that happen in the future when only folio
can be compound and page is only order-0?

Best Regards,
Yan, Zi


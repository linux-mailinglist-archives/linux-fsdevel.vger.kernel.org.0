Return-Path: <linux-fsdevel+bounces-52587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E5AE466D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09A07AB3B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025CD25A2C8;
	Mon, 23 Jun 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p+jJEIKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717802580E1;
	Mon, 23 Jun 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688236; cv=fail; b=I975wpbDRKM/x3NhORa8dJwvxXAhtN1b0kwl6eIjDfjKz60RTheoCWXVQVezLPlWnTM/+IvYNO0gZLN+Ma+CTRr4TaEg46XUX3jxN/WLKxM7VaG8UqGL3OWN3dfcL+tWGwiDTgVwo++NUVkFLVYy3P0uuhybLePY0gZFbZXx1fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688236; c=relaxed/simple;
	bh=8KUdQZvbZBZWCSSBrsmdrkW/1p06RFvHWEUdK+Lsork=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dm3p9xwlUSJlShYFecNfI6hJrkVAGrFgPUIcWXWBAFAGoKa0sO0gSGoW3aeb/UTrbopNc4croHWtTiRhv8x5XM2uvemI574WzPuMXVsw6hfEfT1h8Zmr7twYatWPmS7EA94fuouB29ReaUCaDuEEDB7mC2E7Wzv2k4rMkiN0yuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p+jJEIKL; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nf91aUGjCXBFm6gbipLbxHHX99wXdRJ2hrr1nQw3o/b7xKrfl9kPi0+n2CyS1XX36fMrY0hIdb8FqhGKoidtIDmewEjz8i90jepyJlVPIn1sheHkqTH8TfXf4TNC4/EhxG62ohtPVImhL3JZIu433KSuNV2fe6KBp0H3rkZu89+jNlNUsAJFBmVSvX/FzjaZUaknwkoYi2sod2JgHmgCzah8PNZjJxdneOdEDlvSrXTlNhAzXO7fws2ZWjoCwN7pqyPnTjcaprP6jtak7MJwSHTjPduHS+8qY5d2ez6Ev48q5kN8coyRb2nW3Bkn7x2ufioVUDBI5J83TUMhA0+gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQAF5TE0Bqe2GLrhGSqrhEIpS9STaWTDbK1ZUIjjTtg=;
 b=xtSkRLIaXB+f1lLHFbLXL9raFjRbIrMFxnKENLVDMmgGN1nWTl0Nd4y47VLk46Q4OIMOsZu32PyUutGyIWQj9K52JqU1vAyRD7DxseizY5+vJknNM7bw57yNoIwqO/VAe4UVh5zKt1FZi6yavvB1FxE4juQF9KYxp9zs7jwXqKz6bhKrclYd95WrwzkuGDwKNNBb9xbcwlPv2cM5LIZPT+hLYX7OQQFd2+JLtgex8I1EZ0SizEXjWeyEkb3DzbthF7QEfTyG6HRL4O3u50RmB39vk9mDQYiMKDmwZCUCl3GDle7GNTqicH0kXMFLSsP6fs0H0TPQsUPU1g515xQB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQAF5TE0Bqe2GLrhGSqrhEIpS9STaWTDbK1ZUIjjTtg=;
 b=p+jJEIKLUPDxGXMHSN/Zwt4vK9uvTEZve0hLHGunKRBCYEAh7BFt26Dez4/bmLR1qx2qactPeKcBVk1pCfrwAIYgpyq101iDVY5Bffzr0dVSGwB06TS4Ok39j31bJBIZvpeBdE75rFd8hL4129N0UGSr/T1OuHyTnxhCh2ulAXdUXovmHCBb2YWZkLFJ+rXbRIr1NyqicXx6xWiDOITlqwPMEQZ8LGXTrTD0dMlTgpXLO2O460AI7Hdbhq24jVnqJsI+3bVR/ubGmHn+8s5l8EPRMn0vlfJMW6bAAdjM6aQ64tqZHP8YCRHTeQ6B+8IABH2AEbrlT/2MSn5xETmZPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.22; Mon, 23 Jun 2025 14:17:09 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:17:09 +0000
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
Subject: Re: [PATCH RFC 22/29] mm/page-flags: rename PAGE_MAPPING_MOVABLE to
 PAGE_MAPPING_ANON_KSM
Date: Mon, 23 Jun 2025 10:17:04 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <689EECE8-B1BA-4598-A2A6-157EB9F62209@nvidia.com>
In-Reply-To: <20250618174014.1168640-23-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-23-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:408:e7::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4bb598-41c3-47ed-b2f7-08ddb260a3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdJL4tT5hpi/RppUsCVNyQjwFZLhNc0Yd4LIqV3XaYKUkXcAqzryjRa4mvOH?=
 =?us-ascii?Q?6fMrdEE8po2O8w1byN3bFdge9vaNsLmRDFrezf/LcQ2aOzzkIsNt7JGI4fq7?=
 =?us-ascii?Q?LSGfLNgau0SBA3XoOXxew8Njxkq1BcWX4aqI7RSkl+8JW9UQvntl1dioJlYd?=
 =?us-ascii?Q?TPgK4EuxlW1olhDNUypo+b1Hr/oWKQ8zA0zi8yRB4l9S2iR45lWbC02zIiRo?=
 =?us-ascii?Q?oB0CgyUSO3/Ei56B+6BDU0Y1qApFO4HD3hhCGhnvnz1n1xGbRf/noOVT41QL?=
 =?us-ascii?Q?Ilz1GOc5lOkcK0y1Gdo1GLycfDRcsCMgmzrE97m2rcM0ZBWSNooTi93pBQc2?=
 =?us-ascii?Q?0yRNTz67MilKJgPxSNpD52jeUyrDuCPVdVSsgvuR8xNGqhOfRfXgvvqzMOQI?=
 =?us-ascii?Q?HUFx/ss+AAc6sBqfzcmL9lEhZqItvSLxrbRo4Gcw32m1/LdNtTOrfH0ftPfp?=
 =?us-ascii?Q?6VYQu1T0H50hISPBSVEgK1WOi0l50yPjMr7kqRc2jrnNzhEOjj7Wg+ViYTGh?=
 =?us-ascii?Q?+WtXDhHwX0a/GyAbvS8gJuj1tMFDPJiYS999ffs6khS/1SQnDOZ2VcqCTPlz?=
 =?us-ascii?Q?CcmdpNbSws9Qr3JLDyqlBSvWcebkPMiU0oPGOkjNo6Al4uS97HUzMzJSLMnf?=
 =?us-ascii?Q?CuvxtmmmAV7LlmjSbwzBl1oujNQLpVsg5J8SIFuhHn0/PG6XhcwDJ2fEGAJs?=
 =?us-ascii?Q?/BlTk/n63rqhn3OXEe2iQk+0aYA/aIc6xllzLJI3cNxD4VT7c7ydwC54XqC/?=
 =?us-ascii?Q?3OMrfmzAH57WytFF6t8hvJxICLjumWn7wy1n/oYXB3ZmOCdwZaAoa/KzxXZk?=
 =?us-ascii?Q?3XqGS78aYPQSTwL7jOYaP3KZMOuleOuwwMaCNoHjKXHaWVQKMMj7twKFlHg1?=
 =?us-ascii?Q?S3hpOH0sZIfFxVvwZWOLroGA5VK5iYcb8IARxXp6G56l9PvUCaqzP9OWGKYx?=
 =?us-ascii?Q?7+IqWBAld00NO+bZYNDBCMf4X64hMNbobTMgXcFpJ6U6LvSrDOYur+Ck3Wj7?=
 =?us-ascii?Q?cUFO7nmmE7jCs3zsQKAblhvikkEssbHfmsxabmgPusWnXp5RnVqnoyCFwN90?=
 =?us-ascii?Q?4vtgJRedYB4hzsB+J3H/Y1pDMLREhduO4HValZzo3xGl9JjDjIUzqNiZRzBr?=
 =?us-ascii?Q?0B3++SU+U896x2WW0UsoHWPI1P7Vv96aFwwzk4C0LTYbZE/n4J8777+loI4J?=
 =?us-ascii?Q?CJIz/HqoLusbYbCNJsbBThLhvTbx9S8FEK9nnVCrtZALP8pGYsgEtAtlPZkL?=
 =?us-ascii?Q?DP20GHYmffI1VRr86xqGvrav7EAW4ohv+TFh/jmN8dc9QJBBitRSASO0jzc0?=
 =?us-ascii?Q?LtcHJLCYyD+qpPenHQfyybtl14YBaSCDMUxK6KIHfUhrdF6Hs1xhZrGUumJV?=
 =?us-ascii?Q?CAT0cOoIpw54q5wSyH1WKy50LMU0K49cSH0QKIYILM/GarqbT94d7pnUYuHB?=
 =?us-ascii?Q?IQhVgvlNGE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGjFNC+QAsobur8m9gbzln09V4ugVTpod1jzMIpZoMqhKuWQb/uIs6g+bC2d?=
 =?us-ascii?Q?tajgx3R4QBNuIeKt+I9L791qgwtjuFGk6cqFvpF5pRFkOoaxYK69wxIjobKU?=
 =?us-ascii?Q?nIbiBzkGJolUxAfGbEj5FeZeGPErgXkoTPjXetwCInT1Vfpoe/Qec4IxEz9Y?=
 =?us-ascii?Q?M28o9CP8On1Fj9phrib0G1OCn7473e26tzpPbOK2uQ3h2IWzh5SJcHJmlD4j?=
 =?us-ascii?Q?1ByDtS4PJHIiXCYRe3dKZFqybcLLAWikW2xg7RMKezJVNIofIvjkWF/cGmzL?=
 =?us-ascii?Q?eFp3DYTjtauNAMneBbOXcB9GAOzwE8tZ3crOz9DGDNdrMCymPyMQ1fSo5xv1?=
 =?us-ascii?Q?ceSJN6XAfclsIEHIATIPEEonyZnlRmWlHcP2i5kNE3E+UlBuFGAZYpD93GaE?=
 =?us-ascii?Q?qE0Yso+JWaszd2Pkicjht8np2njwaDQXNNb5mfbvlTkGTAi+ohgLw9A4w8yf?=
 =?us-ascii?Q?GCW4Wxtat9aaKnceKvH3kRyQ3+0Jgb0XMEuHyQKBDH9nP0hC2ut1HJQM6UQD?=
 =?us-ascii?Q?4yfBLIZbhxsI4+8kNo3pmPyRSYEmfRwMnbCkVzMbh0BuxtzwTu8hjnRulZMw?=
 =?us-ascii?Q?EfdTAehMusxDcUJYBJu1qpuPbDthSEGui8+3sPDuEms7x5EDczrWm8avWzm1?=
 =?us-ascii?Q?uRcraLSlITa2JYS6FNqTkVJEfsSkvwIDvPLXGQd09wrH3pr+D8TuKkYBGuNx?=
 =?us-ascii?Q?SeT+rAoIuNTNWKKxVUQsGnPFfQ6CszTvHw3yp1iFWcnrwdshbsNeyr/jqa4z?=
 =?us-ascii?Q?+hlEWo3WFXXI/PM0HF/EvUw0qN3S2CqXiMoDkFNlseE52F8BovvGDIvkp2YF?=
 =?us-ascii?Q?vWaD8vv6+DdOVRLFVlwXOOBFomPYaVyg36awc30K40IBNUOt/QxdQTWlYjTb?=
 =?us-ascii?Q?Tmq2TlAMt7bgUZc3Kx/rNp4IugT7B1rD18kbhqC+ZmSyhj9HT0dDm0ZMLb8K?=
 =?us-ascii?Q?smKoq5FKmXJSLz7926C5yQwHkVZBttIAT2kk2drph5Jys3TWSGwf7v9MzltR?=
 =?us-ascii?Q?b2Ne1Yqauk0YsNm6sh1bublBtbz1z5kugTceQ7p1qwQBVBMlvxbV3tngLPBC?=
 =?us-ascii?Q?qf0rnXLcMA95bVcBw76X+dq0I/63uYADBDF12QKtorADoBYPqLpGEIXjQxaz?=
 =?us-ascii?Q?Z8xorLvfOimzHtuXsPwbpNf+sDbh3vk/4QvRQgbqPldPE9ALsaeK+eMRbbYW?=
 =?us-ascii?Q?FrsviZkCV/ppKD/nylsEXYLEC0dh3y6x0nUDk6JSl5bv0CA/Ciw0F5aAlkp+?=
 =?us-ascii?Q?GsozqLkhh/XgDpXq1bNgxTKD5EdbSpS6jA5ws+szXLSQEbYBc3ifkmbKnWTB?=
 =?us-ascii?Q?ZP1wfSvszSovO78K7ktdUoskmFWVMlvN/FiQxSgLQbHc1m0i26w1OLZ/AKr7?=
 =?us-ascii?Q?fy6ucRb+i1WIWyjD3G6+VO3123Ce8VktDtNu6JzPWqnUhUhAlPrla80rqCu0?=
 =?us-ascii?Q?2N9+h3Oai8IXJdQV3risTI1HyrRnuRxWqHMrSW49YcI2rxBjTOMsd2Q5vu2J?=
 =?us-ascii?Q?c88YBjJaaEdm4gigO3WOF8Q9jjEQyrAsxnzCsK/PnGuJStYFZMSPS43EDWSV?=
 =?us-ascii?Q?tfUyHb2iOpRw1cCzutHylwQHkhsXf/4i8IYuBncy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4bb598-41c3-47ed-b2f7-08ddb260a3b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:17:09.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lH0uMv1Ieq92XE+JjYu62DHOT/yW1CfmxPjb6vaVB6X9t4naT6+j5HrtpVqOpqMW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> KSM is the only remaining user, let's rename the flag. While at it,
> adjust to remaining page -> folio in the doc.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-flags.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi


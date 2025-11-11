Return-Path: <linux-fsdevel+bounces-67789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97284C4B500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 04:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6D33A45E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 03:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863234A796;
	Tue, 11 Nov 2025 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/h87OjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1031D314A8F;
	Tue, 11 Nov 2025 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831550; cv=fail; b=FOYqAxno0sTjr/Yn7uRB7cccUzT3v9w/tYzuDpXx3E8Tc3ikLAcRC+d7qmY/fymTMIPfMdc8/+b/89ievsNHMB/0T5Ouoz95HVmXPQd9v/3Oe+EvmQyo0NjYN+RwphZzjm8uw0DIbsmi1W7FPteuIhE/k+d+Sw8qn0Kqo1+zaHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831550; c=relaxed/simple;
	bh=9ueGGJVmefH++k2cerGNCc0JvDa+PywFviatQwCPl3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ErHkZWLnsjP5W8yId/itQzutYDRrdwfaSbwwx1ll84oVqhwOOR79d9gan/rIUS1N+a6UZ620BgFx15auAg5s7fcf+EZkMwmWbX/cTvoyAOjEw5hUC7QZkNWCj/jrpllbOjauccFaAVu24UpRB2eyxWZPh+7LZ115GHa4Rp9AZv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/h87OjG; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usRfm/7IGRAtDBTinuFHpXCu1rgHvKdvLQUpWZuQV3N8qLzK7Fe9Qhu/fGNLZVtuZuNhPco1W6um/o9wvO4JOvXK8Tr4x4tpVL/bjyzcrcHsjnKaNDsg7ZkRid2lrNJQ5MM4+v3kUVtMgVPUxzQhmfM+Kx7djjmezF9fKYA7qEd1ixXZ5VHtKUgSDNTw3axlHUzT1P6PdwlgO2ptsnASIv+pWHO7iag4uLwLvaIZ06s6pGHtlcDdwPR4fb66MyLtJN01krRh3gkLChw+PxHlP4DwR+i/l7IcMgr6nJJkyw5syG2pr4HQxHkRa/yBXNTM0knbPQehzuffwRmjOvJOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5INBg9jNnvIMmN0NR8lVODCaHdgNXGPLmCTUuvpExa8=;
 b=mnRDQDS99dLo0PCVn/se4wVsGogdFkx4DgCIijhR93UvUU3Ulu9eZmi0DXi5iqvu/6UduCMlMi4kImTIYdI/lXCB67ftTeI01N5i76mRGR5yj+qtCA2PZHoU7e7s5dSV1/5V+MeRqBYZVU1HWuBC7nBkCCDGzfYM/uwUa4gNyxgDHYmhniUOwuhkK+QWiplsX99sbn1sLDw/HLW/PFZ3Tezo9/qJjy/XgRs4W/+Qxhb5Ys02MicCy7lp75KRCHoX9vVsfjXo0+bmI+XUrTTULoMsFWnLjKi2il+7l8NbZV2YrJzmvzHGJZLa4RVNHweZcz0+kSBgCE0ZMK26X1KWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5INBg9jNnvIMmN0NR8lVODCaHdgNXGPLmCTUuvpExa8=;
 b=W/h87OjGyLYKzzql5iRnFjFH0RzuvCpmxZEk87SaxTvnZNMLJ96chyPw0urRkbpSNmQhvtR09bTMBd3UbrnkoymesS7Bi1DFsfbTs0l+QDxfIFkM8D3i0dsCL9vOurw8HMU4PZxkM89XHKyPCgxTWHPpbFOhBD/Vwr/G55wQVFozUTbf+rKCAG+yysaIl91X39X5VEFxdlI2UK6EbTO+YMm5ogtBJj1BLScEXOwIXNJbpeNxugdiX8s2nzTGS4S8Bi2OkQxo7f5MNe/Bk3ScR9Wg0jNOsCO0xasQmZxUDPwvgtVIrgO0KQc7T2lJIWu5bjM8D1PGjF6bn5uNpgp8vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 03:25:45 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 03:25:45 +0000
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
Subject: Re: [PATCH v3 02/16] mm: introduce leaf entry type and use to
 simplify leaf entry logic
Date: Mon, 10 Nov 2025 22:25:40 -0500
X-Mailer: MailMate (2.0r6283)
Message-ID: <CBBF1711-5881-4B5A-ADE6-1D86C0E94296@nvidia.com>
In-Reply-To: <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <c879383aac77d96a03e4d38f7daba893cd35fc76.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0439.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbb3817-367b-4c2a-26cf-08de20d2005d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gAIge3gskcRqDxzv5xi4+a8G1uPZYkJm6OO4w8+hQ+BjJh14JpOhDWPkTZia?=
 =?us-ascii?Q?g2q1hBE6JnJHZphSP7mlvcaxfQrLLTSGaMxn5OKyt9PGj/DboD6Am9mD7A/G?=
 =?us-ascii?Q?35ttTb52bpVUEXif9zxYO2X2w59XEjH11UOFRZUOdsdP+J73bWcriVw9km8h?=
 =?us-ascii?Q?avvdFDQFvxjgduuix0dpCbNAFKxSbhgzKHR8LkCK1dqmH21XL3utL22QjaMW?=
 =?us-ascii?Q?E9qlJOKvXOn8Bg75aI84ZKePBwKqbRgI0GEXfl7mjP5aNQynyqii/0S3Kz18?=
 =?us-ascii?Q?IPqHSsAeLXMqpeDT0R05yOEJ8j1wJ6pM+96AVqTtja8NmT7nJBJ45qKXYFDc?=
 =?us-ascii?Q?U3qYP/M4z6m0S2Hp4KyjyF7bllUAIpuj+WaCjqO+nDnAQDTvKE07fIIIsFH2?=
 =?us-ascii?Q?4DCPWyxvGJW6M0HtwHqZEshqViEVFcmyHSyPjj49d7hu4cy04F/zhs/HZDVY?=
 =?us-ascii?Q?bgfbi35Lndvsmd3tXakj7wyw/41Vf+DZ3KLzDbVNA98daVcvK2+IQ0xwPjzt?=
 =?us-ascii?Q?QdDFbOtSI38i6WK3pEC9Ir7LjZ/gfc8JoAIVkWGustU/AMFkk/30+jw5X1Zy?=
 =?us-ascii?Q?HJHZT2DYvwlNInWdfQ0xPXSZHKALVV7OZJ1OKR2rTAvqpB+jI+l9vPLhZLqf?=
 =?us-ascii?Q?pUGv2ANs4NkS5cDidx5jy1oSDBwM7JTy57AcWYtk6ifRsElVIs7DNyS0AuO6?=
 =?us-ascii?Q?63YzEia16/CEWmBjLw5Y+Lf3LUcX/PUFqaiVt7igZL/hbyBv1OTHr9d/2hmR?=
 =?us-ascii?Q?MErWmpjrQQ/3WoginnvfiYoxEOVfbOP1clueXE/wN7MT3RByNpJ2QRAJitbP?=
 =?us-ascii?Q?AtkoLq0i2qsVktJ8d64dEVMi8Rdu+Ststy0hnfyc1lT5wv5l8FUEn/S9CnsR?=
 =?us-ascii?Q?qm8O5yimHYrRSR6Kb2J+xTOS+nylhGAYsfKP3Ol+9QtU5/jbHEy+AQKfyA5G?=
 =?us-ascii?Q?+VvzysnxzURL1GsUAHoOnVq+39w6gyXLZuvDUbBS8CW04SdN8Nwh0/RbzMMh?=
 =?us-ascii?Q?Kl9278pq/IVHti4psf+zc4r3moZyYhnioYErF5f0oCfRSaVZjFioWazZ1dsG?=
 =?us-ascii?Q?IuGvg7CIaTBQVrzrGTscvGL6dywI0bu9VlCLJJu1pzXI0d5VHL4nD//Eu7ub?=
 =?us-ascii?Q?GCrH8F691azfKIPI+rEfrDTWaihW2kHADW+JV615olZz2AICr3kEMliXCPZ6?=
 =?us-ascii?Q?HeSPmtF3bbaonsSVr0OwD4zI12l1dSbTwhX+arFVTCOnvYcjZqeTKKF51mAQ?=
 =?us-ascii?Q?n7i++oYFAle5rqNfTIrK98rNztTmW51vfElaJqmd5lXngknk6nQUuJgIxyZh?=
 =?us-ascii?Q?rpyIkcWN0c0enohUQ4ub8og3raVU0gPCcpCN3rwrmHGyv8R/DlqWN1/5piGc?=
 =?us-ascii?Q?nkrrdP4JL2+vBF1W/8DTKalJj7yIEHlQOdtDRIkEnvg85qvOa0HT1J+usZdB?=
 =?us-ascii?Q?C2+ReZ9Vmoi/w+N/Lh7ObE7JX7WQ17F4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wXaFwKf5XzPLP1TGuWDOyNKkfs5VoR4hygRbt7PBa7jYBhlta7TKzeunihjM?=
 =?us-ascii?Q?VXgfNGPO13e62+QjGOOX/nvx4zu89vsUc3gisn2euZHEu8BRCX0GGB2Nyd8K?=
 =?us-ascii?Q?Z7TsBlbilKgMWRcxnDd6dLEYiPrdKkLw5E3HXnUeQujc110oIZu9QRCGFGfo?=
 =?us-ascii?Q?VQsh2dWfnbN92QjI71J7NOSupBnqqeIfeVDuEi3a7ArGYqcpQvySOHZOBVrk?=
 =?us-ascii?Q?kzavHnqDfsLIPbkXJtGNQ698h2H66xQo1H0RqlhxwKkoTOZvlkBgUIhwSCUJ?=
 =?us-ascii?Q?z0EY5sCplqt/jyJSXO/UsJVfeSAWjn1ZPMVCEYj9Vn9k5NDj5N3cjfrmtYno?=
 =?us-ascii?Q?diC2dW8+pMjeu5oz8PeRMbWNaHeZEGKCWcs6oxAEKsdWgJTCZNW6A6Fk7ZlR?=
 =?us-ascii?Q?8Bw4EXye59VcIPXRwzdEvb0+9J2T+SHXwGAuuaCi5YNMZK5G/egzy4FoG7a7?=
 =?us-ascii?Q?ssJekc3mY+hu6Nf+H3l5KbMUqlrPcLDAH/URIoY4DRgnBMMgtyqfrzbvEsSC?=
 =?us-ascii?Q?MW04GUrMOScZLBarBF1Qf0cBairruYoKVnPeUF0Sbomsxy2FbMjydb8eHsLs?=
 =?us-ascii?Q?+Ps6wQkZoAUfFQWErjTEFvFS9dllHtqHX35L8MVxPXcuaCRedZ5WFHtO/gb3?=
 =?us-ascii?Q?ABrNtU850PlQwRksnvxDcyfl91iDFiz7/nqcg6oyObRsE3Gj/SEZV8NbIRuC?=
 =?us-ascii?Q?vY8AW6yh9g/4fGlFhsS2nxzXzXZeRgk1RWFCgJfpRDYF/mX8/XxuWAv+cvjz?=
 =?us-ascii?Q?i5dGJC53FZzktFRFWPqpBuhQoj4/kXoMQUjSVRLgBq6pHTxPHzMRnPV0kSRo?=
 =?us-ascii?Q?OAGHzU9FBctamdGw8zwLAgN4DNnxhSFJt6xsh7Fh9NvZb+5BvRfqbo8IcNIi?=
 =?us-ascii?Q?Aj4ssxaLMn55TOy4tWbdyhXDfbYfdCrLEPEDznus3jcqCqqWFMDISZWejf47?=
 =?us-ascii?Q?XVB+FyqsHnMityUdDKaH8U5GkzDcckRfgLjF72m8aDhb8PrGaWcLX0gI3L5v?=
 =?us-ascii?Q?IYaG4V526yKUWIDrk+yodY1TFeG4xmof+nAwb2NZg1Y3+uKqg0Rj4/ITD5Sm?=
 =?us-ascii?Q?saa4pXAzzFqM0jCBGWvX/FCxRGDgQ82ufgQxo1w/hE7iuXq5IoVecgL+hfk1?=
 =?us-ascii?Q?n0zPJW2P4C5x9LBR3pq5pHr/MrHFS+QYL0N4r6A7xCSHagg0befqwtmMFLn+?=
 =?us-ascii?Q?ZD9cqU/2ZY0FsOxe3iSVx4P9XWwGm/kff+dX+MtdwxkoQUY+1rnrAUEl4PmD?=
 =?us-ascii?Q?EDCzb28IWbQVYKoVu0QOZ4WVOH+F715LRmHWoi1mzdAZ9TWu/1BtcxxvJxGP?=
 =?us-ascii?Q?4cvyLIHJE7I3LyrjKWmFjS+PouQP6c4c8ggf5XmGlJPmY9XjB/ywnitZxbaf?=
 =?us-ascii?Q?fQhwZ3laSAlleox2aqTGRTl462MiApgyNajweI4zUqEHHrUHZtunL82xIsJ8?=
 =?us-ascii?Q?0VERmbeudrEXSoacWBEAOM91+M3upMCdKm01dezvMwbDzOVTLupDzRqyDZM6?=
 =?us-ascii?Q?4IJmiIpOYgDqIELMxYI6wjV4YAvMhEY2kGXVtXcEi9MEVzuY8r6YIlOZ8r8H?=
 =?us-ascii?Q?AmZ4EUUqLX57Gznj/zgPDtaqbXnjNPgjXpJp3JRC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbb3817-367b-4c2a-26cf-08de20d2005d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 03:25:45.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAAdXOF4E5RKnARcMAg+R9tax9eeAsQA897Vpu7k4Lw/d0KqVfeGXIPmHUjZNTh2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

On 10 Nov 2025, at 17:21, Lorenzo Stoakes wrote:

> The kernel maintains leaf page table entries which contain either:
>
> - Nothing ('none' entries)
> - Present entries (that is stuff the hardware can navigate without fault)

This is not true for:

1. pXX_protnone(), where _PAGE_PROTNONE flag also means pXX_present() is
true, but hardware would still trigger a fault.
2. pmd_present() where _PAGE_PSE also means a present PMD (see the comment
in pmd_present()).

This commit log needs to be updated.

> - Everything else that will cause a fault which the kernel handles

This is not true because of the reasons above.

How should we categorize these non-present to HW but present to SW entries,
like protnone and under splitting PMDs? Strictly speaking, they are
softleaf entries, but that would require more changes to the kernel code
and pXX_present() means HW present.

To not make this series more complicated, I think updating commit log
and comments to use pXX_present() instead of HW present might be
the easiest way out. We can revisit pXX_present() vs HW present later.

OK, I will focus on code review now.

>
> In the 'everything else' group we include swap entries, but we also include
> a number of other things such as migration entries, device private entries
> and marker entries.
>
> Unfortunately this 'everything else' group expresses everything through
> a swp_entry_t type, and these entries are referred to swap entries even
> though they may well not contain a... swap entry.
>
> This is compounded by the rather mind-boggling concept of a non-swap swap
> entry (checked via non_swap_entry()) and the means by which we twist and
> turn to satisfy this.
>
> This patch lays the foundation for reducing this confusion.
>
> We refer to 'everything else' as a 'software-define leaf entry' or
> 'softleaf'. for short And in fact we scoop up the 'none' entries into this
> concept also so we are left with:
>
> - Present entries.
> - Softleaf entries (which may be empty).
>
> This allows for radical simplification across the board - one can simply
> convert any leaf page table entry to a leaf entry via softleaf_from_pte().
>
> If the entry is present, we return an empty leaf entry, so it is assumed
> the caller is aware that they must differentiate between the two categories
> of page table entries, checking for the former via pte_present().
>
> As a result, we can eliminate a number of places where we would otherwise
> need to use predicates to see if we can proceed with leaf page table entry
> conversion and instead just go ahead and do it unconditionally.
>
> We do so where we can, adjusting surrounding logic as necessary to
> integrate the new softleaf_t logic as far as seems reasonable at this
> stage.
>
> We typedef swp_entry_t to softleaf_t for the time being until the
> conversion can be complete, meaning everything remains compatible
> regardless of which type is used. We will eventually remove swp_entry_t
> when the conversion is complete.
>
> We introduce a new header file to keep things clear - leafops.h - this
> imports swapops.h so can direct replace swapops imports without issue, and
> we do so in all the files that require it.
>
> Additionally, add new leafops.h file to core mm maintainers entry.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS                   |   1 +
>  fs/proc/task_mmu.c            |  26 +--
>  fs/userfaultfd.c              |   6 +-
>  include/linux/leafops.h       | 387 ++++++++++++++++++++++++++++++++++
>  include/linux/mm_inline.h     |   6 +-
>  include/linux/mm_types.h      |  25 +++
>  include/linux/swapops.h       |  28 ---
>  include/linux/userfaultfd_k.h |  51 +----
>  mm/hmm.c                      |   2 +-
>  mm/hugetlb.c                  |  37 ++--
>  mm/madvise.c                  |  16 +-
>  mm/memory.c                   |  41 ++--
>  mm/mincore.c                  |   6 +-
>  mm/mprotect.c                 |   6 +-
>  mm/mremap.c                   |   4 +-
>  mm/page_vma_mapped.c          |  11 +-
>  mm/shmem.c                    |   7 +-
>  mm/userfaultfd.c              |   6 +-
>  18 files changed, 502 insertions(+), 164 deletions(-)
>  create mode 100644 include/linux/leafops.h
>


Best Regards,
Yan, Zi


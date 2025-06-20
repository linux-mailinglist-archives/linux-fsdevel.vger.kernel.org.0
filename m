Return-Path: <linux-fsdevel+bounces-52357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9534AE22DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 21:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83981C25335
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126CF2248AB;
	Fri, 20 Jun 2025 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WkQgbDnr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A6223DED;
	Fri, 20 Jun 2025 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750447823; cv=fail; b=XrC6kON1JWvFdjPylgEaJZVHSQZANVHnct/2lOiOrM6Fv+nRmPH7TRp2mp5sHHKxEu8U/MqrE5u6pEjS0Cl0kUD/O94oKanxJyhLRKXg2A4I21EHRPquzj2DVB3L1mXgeFpC61dCIinU1ciMQ307Zp+TtVb17q8lBxkR7x69XdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750447823; c=relaxed/simple;
	bh=+72Gexo6AkPBkhwiq7O2zs5y7NMZVk+JbJ6ShatuMPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWOADNsku2+Y/Dpk/sRJRF7GN6avdmTOpDzO8U/EzRKUJuWfNhas+5vw473Ew8oTDzL8Z4OUWCyPTiOiqABPDbHj5/6ZMYGkml9H6lIFw9EccfUhie+n614dKejrWbVtCarZ1K497pPParyj6LMqm5/fTf2P1r0YYMQyugQvB2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WkQgbDnr; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxEmsifL3NJJb80dc2Cg+xxWhyFY/6ms1jLhe84HRSihC66IguUOLAT8YTFgd1yoTYOrsrd8x+jRE05nd49lG7uFN2LFIyFfP4KnK+NynJtPeIy4t1d+Cohi7vOuU3BJHCS+s/zrPRJXeGKchFfDqHJ5AO+69D+laZRa9o4O2NtX9wn+0n4WottpSYpvfz90hanf/Pujv/zO655L2GDoW2LDgghx69fE+qSLapcz3N7RYdpcy3iO7Vp4xBoSw8tR/9tJntln2jJbcuINpginwC+UkKUxZyeysjbHYzioExPx4boc6FbYB97I1zhV60/t6ng14Qi/Oc4m2xaVG53hoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx+VE2keKkDAFV82dfpAl0OXpEyes6eM/gy40nt9vdo=;
 b=EUmhg3JVdsFdjad80RjINhEwut8yAy4sdunGEUzBK4UgiwjX4N9CqZL6d96FJfCVIrmgIcq5JIWN8NgXofMVNJiQmJ9lBAMhdiSpZL7/+YzfcXEGcT+eFe3U7T8BOIDQdGtU08v7pQ8/abYIfphXhTTS0bWVYdY5yqUXRnKBg6Kusw0LHIHM3AhuSVyaHphBm1fwcklM9wxedLo0n5j6GHVUdsRCwU5tqf3/1BgKwj8sldsrR9r/gLlEJDuRoqTVD5Dt7nEUwpINkQoepw8kMzHRykebuevUHNE7b5fpjygWXUQgrJytfHy2IEX61CqWBXoy0NfqmNG92YH+l7ByrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx+VE2keKkDAFV82dfpAl0OXpEyes6eM/gy40nt9vdo=;
 b=WkQgbDnrzhB6FzlX7csp7OCkR97B6JTanB8u6FAofz1q3rTdt8wApBYWwuwodOo7MbfYWGiWKuHzDcGtqiieLrd+7LnF906w6cu+/Ad1Z0MzqKKI7uXb0n7fk2kgPyY3LFKfNxifVMvF8EAaV+2HZsdzBfGlAz2RiNesERZWLHmegNMCeJ853WiMNnFA9uwoch9UXJ2EBh0gHJ73TpHYFGH54md3fKqAEs1g2zisi6JA+saZdQHxoaUCZO7vsF2gFMP1nLT22uZoIHGgYGhxfdQTleBrRQp5zyLC5NT4tuYmAGdABe3i8cyyi38z8x6m3rs6egTnsI6N9L0SnCbWeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 19:30:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Fri, 20 Jun 2025
 19:30:18 +0000
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
Subject: Re: [PATCH RFC 09/29] mm/migrate: factor out movable_ops page
 handling into migrate_movable_ops_page()
Date: Fri, 20 Jun 2025 15:30:14 -0400
X-Mailer: MailMate (2.0r6263)
Message-ID: <25F179F8-76C6-455E-843F-170144F7A415@nvidia.com>
In-Reply-To: <20250618174014.1168640-10-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-10-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: dadd4a5a-c162-4d05-ff73-08ddb030e385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tdcOD1P8rDCg82xrZxbYghl5VcfO5nD5Rwj7SjswpPkK8N9f4tZ+93WSQI0n?=
 =?us-ascii?Q?5h05ru4y8R7l2YQdp3NWDhRUxaQ90AQzgaTewe4DjXNe2Dxrmm6xW7hcOdz4?=
 =?us-ascii?Q?nhkjYAytYubI8KY8IIbBn8Byh39A4qSjytBK4yqMMenTmVWu0QSX+bG8truz?=
 =?us-ascii?Q?7Uagmcgk2oOdRMw9DG/Kq4yeXwMtcHKTGOpfaCDqKDHPvfDyLH26Ot/YUegQ?=
 =?us-ascii?Q?VTSy0kKLWPtfC9eh4EZiWvddPalRDmbuiQmBppEb1YHPNwBW5RqUFmpptIs9?=
 =?us-ascii?Q?BfO9Y6UPuibjMbmwepXcgEgKteMjnHZpeKMhUfxC4gHO+fkubvmhSkHXUmmf?=
 =?us-ascii?Q?uKyqI43JYybZA2H0wRJVvVs9UFvkhu3ztS8k5kGN9R37wH5RVPD34rlil8k0?=
 =?us-ascii?Q?t3jDZL21ovmlyk6HtSv7iZzd2DZFjLSARV2/ioCPsSwRPnILJ8XspvuONGhT?=
 =?us-ascii?Q?AJKH3xUbBYQ8BFI8rQVzTNRbvm1p33KA/D2AR4tyUyXZGcGnE3ECobEA3UCO?=
 =?us-ascii?Q?bhBbfoQVJ9weB2trjmbgKfhfK5E3Soh037wJ01Mkm/5the6a2hHx9bRB+Hh7?=
 =?us-ascii?Q?L3Z7pbxmanFGk3pmG0+gjludmIDrSpkpwu8Xqv3GMM95G+P2GRls0wAskKRn?=
 =?us-ascii?Q?k+KC+YuoTf7YRwPi6QWd7CmuPsBqn4ay6GMUcWxlcOVi1va45kGE8PonBaxG?=
 =?us-ascii?Q?+ccvKyv7ZCFYsSsV4qA9e54JcWglixQfb0xjXYs2zO4vhsNKtB5HGPIAwMgw?=
 =?us-ascii?Q?Nzm6vq3O/GrErLQru5QRpahE93saFr7/5ZZW2Cq7VwSISsyKWySgVYD2nesu?=
 =?us-ascii?Q?b+epECs5aHqlztHjKHYiFrhaRlK7wrl5ErVfyHTCMoBnmCf+cdlLuRqZOKye?=
 =?us-ascii?Q?4kxiCVdQ/eDDLMzIMIRZfqzvbsKWD4zcvM+Oleutid/ET5J+pQKLrc6p8DM6?=
 =?us-ascii?Q?V7vd+ozK+pVnMPxdJQz1mBLbqKoTtpvKANE+kEhCnQm8YKw1+W+NM0YdjG9F?=
 =?us-ascii?Q?whOQFRevvwq2rqbP9Dtxv4+eF2Qj0oLPSaT7zhLHvDVUIVmp96+edCwxGbdA?=
 =?us-ascii?Q?nN8wk7wKE/PMcViCQoZI0QPKhstNPrE0o3ID4bzu5Q+oewmqRUDJl0/3ENWY?=
 =?us-ascii?Q?8TBMba8hrFy5V8L/gJVdXCwDek/oVGHlBoz8bppmVdwix0WT/R9XJn0mDb9X?=
 =?us-ascii?Q?9wvDyzMNVnLZYNMadD3fwLBqsXsvklJWjrZqrVNPAlJgma5RzE8FojQ5ccip?=
 =?us-ascii?Q?vBJuXXGQYKxb5ZpPt2iafTPOKOryYia2e9fxLAj/v2TD5Sf6p6T841Tr5Wqc?=
 =?us-ascii?Q?/kK3YwRLQw93r0vXwxz+2C7TYmmG+4RAVKDoNgzLSQ5MaXQwms7jAj3G4wDj?=
 =?us-ascii?Q?Fdndd+pw+dduskvGFdiNmqAUk2mbebz8NtIE54WsNJMpnUoEQyhgaKc7PmVa?=
 =?us-ascii?Q?68ZwcjjjE1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D1la8lJ5A2l1Q9bJ+zNys1HAlj7P8d9MFlODGj66+rytdjVAHk69k8cpbme5?=
 =?us-ascii?Q?Am2J8TfjQBlvfSoFl1NpEiCpa86X0drCB+OkUhAJxl5DaBpGKOdCRp5bCrLs?=
 =?us-ascii?Q?I2KHHY4erYX8HyIwNQCacZz8C2FbhOjx6VAehB2Bkzp6GXw1dRNmEUt7o0k4?=
 =?us-ascii?Q?2HJ9Ad9VKrHQoCfZjeBa2fLIOL9N2z6u7X78wxOVUqRQoW2qyl/BJiVD5Uv2?=
 =?us-ascii?Q?phAthgYowQeIxxG+M5fOki0as+wiIv7Uk/7h84YcWzQGN2Bi0GKF/4WGcxlq?=
 =?us-ascii?Q?w09rusR9vnDGNlHgokPCFa4HI+Ciu7iqeNqw1cYajUpk0KJZ/Nzyeqq9Cwwk?=
 =?us-ascii?Q?9cepuGUN8SIT1TG9q2869VxME+eocaQrESzfgndRgGnze1vzj35i433ZPw2u?=
 =?us-ascii?Q?k5wFErExB/BiyAORe3b41LkOGgqHpG205A9viZZQFKDMZPgz1tq3A3Ur7oME?=
 =?us-ascii?Q?O0FEDr+146vJtuXIuoV3wV0xbhJ5MtC8S5xcKkvMQFtikxIeDsFOfVlBAGD6?=
 =?us-ascii?Q?iBmS00UC/VoEOoSR/RomBV5EvbLT9oY6a0dfaNYUoYI7CACRqI/+wBO7tt3H?=
 =?us-ascii?Q?Ul6H4TVNzXBwWl2yYW0HyHbrZOsAaLeWxHR/zL7EcfF+sciWh/JKNQIdtr5e?=
 =?us-ascii?Q?eLN9eBmdwQRPOZMd/Bx6c1mU/DtuR8ZDozBQtRmniTYNKW/kqGH7eR0zbT4k?=
 =?us-ascii?Q?aLkl1HRSobAihWQWrWaVuXXmFl6954RlsztYCGO540+cx7YW+m/zmsrqL/xr?=
 =?us-ascii?Q?WZ4dpCcNNYZLcskPeoyhUL0rpuAaYxieOAT1IElFIQjyJl1Rpz4dDrOuFS2f?=
 =?us-ascii?Q?92bwYUEuZe4MDtjeSvodMJP0JfPjZsyLfl9o3T+OSt69kyx/pHK1k6TC9im7?=
 =?us-ascii?Q?QGZy3Qm71ju94VfHzmrtq3stCM8ecdwuuy32/ygAS7a6SO1nKEO6O5x6UsK8?=
 =?us-ascii?Q?HLsyTbTxto8N4EDJ9tIhkjtpxIvS4nCxnizNGsccVx8x3pFAt7HYDEUmvfIO?=
 =?us-ascii?Q?5artHVTa0dEE0UTME/j6365IUW2aMKxnKaZSTuOwvvvC9Z8bkN0F680/40FD?=
 =?us-ascii?Q?QQDxVrDuEZrohX7eEwPIVfBTYUaHFRULF+tNnnM1s7juvMgxWYei8bg6LivI?=
 =?us-ascii?Q?ObfomPruJCet9LHYD1vQ57qmcga7wiyt5gSjHkZPV9wsvD1JStA99d9hkpv7?=
 =?us-ascii?Q?rXvWxN9liW+y84K6HGA2x1nuGC7WEX/HoxDGJYXwJYVuvWJ31j9AWax7vai+?=
 =?us-ascii?Q?J805a71omkZxkiSFEQzSvkIZwaxYkLF7GdmBIrXZ+d0ZOebVina/AcjxIms3?=
 =?us-ascii?Q?/Ewpx2BMaaxOVzj5PvRQSCY3hBawwN1I5tlVSymALVLD3Jx96peAhh1SGoKB?=
 =?us-ascii?Q?2iPUxEfI4IpZP37J+zm6J1Oed/1zuX5elUGOv9It9SmcaWfXUm6YA50i+Nrq?=
 =?us-ascii?Q?SxpXGQn4NFg2WsXutUjnrvLH8ZNgPCVMYZeUBCUXg9NlP7W6bhZZ7uzV5+32?=
 =?us-ascii?Q?H0ighRhrd37jPdMvgUrRB7MaRdQtzz0virZan6dp5av9CK7ehGz1r6QDzK+r?=
 =?us-ascii?Q?5pkEkRHngLIpiSiAOBgXUq64NhR7Uz70iwdyX49/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadd4a5a-c162-4d05-ff73-08ddb030e385
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 19:30:18.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzLZpOORxlwxze98y5zy2KC8hEfPDixqYrw91fy8Q//ZJcnGlwyZ0ksRQPcfYBaE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175

On 18 Jun 2025, at 13:39, David Hildenbrand wrote:

> Let's factor it out, simplifying the calling code.
>
> The assumption is that flush_dcache_page() is not required for
> movable_ops pages: as documented for flush_dcache_folio(), it really
> only applies when the kernel wrote to pagecache pages / pages in
> highmem. movable_ops callbacks should be handling flushing
> caches if ever required.
>
> Note that we can now change folio_mapping_flags() to folio_test_anon()
> to make it clearer, because movable_ops pages will never take that path.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/migrate.c | 82 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 45 insertions(+), 37 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi


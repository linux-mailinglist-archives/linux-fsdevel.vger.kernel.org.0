Return-Path: <linux-fsdevel+bounces-57413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A10B213E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDB362198B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD632D6E77;
	Mon, 11 Aug 2025 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AGmRNIvl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A829BDA6;
	Mon, 11 Aug 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936010; cv=fail; b=KfHDXbiRyb2ZOxFZNw/ktfCeMcCX3akyt5xauKJBtrdawtq532qx+458FlzD6P/nakw1dXJmw47QzuJmVi5voeJQAcNZ81E+W5F5n1gosz7klZoUVVYZnatTeddw6Bpd1tbjhtH3H03/2CdADs7Jh/gVOYuqZ29rW6mct0tzlDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936010; c=relaxed/simple;
	bh=ZXiZs1Qs7oFqXQ+sVOZAOvOTh4nRJejcfTUp35Jhlcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJI172wf/2g+Su1gYHTaC4UgbtKKpvJZU3pynKJfztFfW++aXVV74j8PAiP7lfiWtqCQVC9Y7gNUhOOveKhSJDDqADDEmS5VKDpZVUfO3yW/kxHrNt6nZ/wgX/sSOx24hxBudyA2N9M59maWydVplZcyvMXuZiRobGjCQe24sVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AGmRNIvl; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqCibHb7WfynOrKG6L3+S3QJW86vrFs4Jj3opxomgcUmpdUUl859ZQVnRQKHINNxLwosbznqrSKvMCCG2BRPvTrWUQaBhVYFhFRKOw+Xx/smhrYLedcIjfx85rgJPNMns6LpD7Ay6sGsJvmVO0/IGwcNw12WyDkXPotRkXMZgyu573BheoFzCNhXLj9KYR2D+tDLbrxrgITlYltKs5szC+ovr0Z7+G5F//O7mRseshcUC1E196JxHOQ/fh6J0gcR5z2/1Ukb9BENnW7gUnqmoPBot6l4zH+aYYe5l//My3lKe02UT80KuUX/KbxZok1dMXvTOqd6kp0naUc2GJT19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGV22iA4648kX+1SLXqRIJp9tvQz6hauCgYznHiUf3A=;
 b=mKjS7iRqf9RtZ7IN1IIw08y9jGiU9MhTc24bWHVEXjHug6s52va32X5DsKRr0bNPCTt7L7ncwltrliOXqyYW1dHR+1goFnyOD51EWbIoYSXGJqQ2h0OA8uC852s5EeBzdLB9XRosqulnL3s7NHTKcssbcUD3saDL8NB14lPyABjKLlCJvzl1UCpLP4z6PqW4hXgQLafrudWhuKKkIXpglM0nrWoHjelXxYLrG4oahMpCTisSQ+fuJ1CGWD3CbN8jfuZ6Mx/hmnwejxhIeZHJgkv47twoGtHeQ2r/V27G8i0bk7JP188uz6ZT08X1WtwsnoC799JeOIMuLwRTcT/h7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGV22iA4648kX+1SLXqRIJp9tvQz6hauCgYznHiUf3A=;
 b=AGmRNIvle1xNuzTW+OowrKLrpxVus2WO6EddvsBkKGE6ZGkNcZCWgNVPRKstgy/kKXOzoIildUPW3H346rPL/CzNywsQqEepi6n0S4lYjqd2i+5Sriho9skpFkYm1tmWmZcZjisgCro66daFSArrrkJfRiBXkdqqgHEaGbMR7l+3yl+T4czwAB6R9cMOju5jQ7OE1l+nvwJcOE3cWLEXDmMngGsYkYV2Nyet4aFV05JiqbZXp6Go3fmL03Z7EWsWx4ia0dBvhZzwaTPUY545QScGGfBvrR/jQgkJoz9FzChJqKew02EkIG3jeZqa2oTgoAMYa6QqAC6QsuPkszWCfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 18:13:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 18:13:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Benjamin LaHaise <bcrl@kvack.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Dave Kleikamp <shaggy@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 1/2] mm/migrate: remove MIGRATEPAGE_UNMAP
Date: Mon, 11 Aug 2025 14:13:21 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B4A54756-87EC-4795-855C-3F80114456FF@nvidia.com>
In-Reply-To: <20250811143949.1117439-2-david@redhat.com>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-2-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:208:d4::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 8197a7b4-0230-4ff8-9333-08ddd902c42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GlB/C9QUMNoi5RlZS4KAhVuYCrDyzlwNMMpuKf5R2+GrizrTmWwV6wmufBSv?=
 =?us-ascii?Q?eYeXizzWXFYP/6fa/pHQSyj3gxjBukLSrROUM9Daag4D/LHXcKZAy2ZJKj0l?=
 =?us-ascii?Q?Jy/IwAgy0wlzXFcH4A3hJqGiVCcMkYvN/JL40a6QFa1J1NuBNc/j4nT109v+?=
 =?us-ascii?Q?KMTBv3DI0T2ty/Uw21EbRRGi4njeCeblvR9FLhxMfn5TwJ2b/CfKQJKf5q3E?=
 =?us-ascii?Q?ofJ5XWd+W6Lke70i9QfWREvQkYViNRmqhCMYAMpu19+je7wI64JgC767IbY+?=
 =?us-ascii?Q?glNou6LoJTY8rNFvw89m91g1Ro5fmOO7dYT7kv4OARGYboWf05YDv0AmIveG?=
 =?us-ascii?Q?VGtxEEKz+8+Jpiphn4YkS6tU3WXxr87PT7AAzCtwnnkgaCwIC2um5gTHiFKZ?=
 =?us-ascii?Q?Ke2niPQQhIKmzdHU1VrJwFKZVuxNAP/JCQB0sHIMjKXoFZyo4C0a69SndSD6?=
 =?us-ascii?Q?yvcjB1wiqh5YrZR8W3xaoLKJ0Q1aMz467pU5BQoRL1NkPqS6538rxZlgyjl/?=
 =?us-ascii?Q?rFow/Ep1CrBtU/KXR53ureRVgkubq5GS+L3RP2L5eG0noZwzxufZjygKAayp?=
 =?us-ascii?Q?A0HtpGi+aZ21pa3cJvAGggO0Y2z2yHYAG3jn45BOrr0cNJND9aO3+P0Yf/T+?=
 =?us-ascii?Q?2LoeGinA42qccikW74AzScXb5YLA74zbtwmA2NyizjG0zfiS7qf7vVQqow9e?=
 =?us-ascii?Q?x2boKigGQFgAT7/mvHHispzZ/tvRbU0o+16HO3xqnCkMpWSL9UTVfMDxAe9f?=
 =?us-ascii?Q?BzfTioMDJN7RfI1NrUyYIqOU/a/JGyQkanFvtifB0K4UPkw5DG0CkzO9mQMj?=
 =?us-ascii?Q?ZnqDj8dKtOqd7icl90T5Lfk1jo4W3lKP5H2hJhEjyplcuvsuQjr99/J4MrTi?=
 =?us-ascii?Q?n9GZ2VOvZPkrWzVe/9F1yLToLA0vAy9HuFY6szg6B9uw0i0Zu0hT6qJC0zoi?=
 =?us-ascii?Q?ZxQ2sqRoyms7vBr9a2iP7y2oMnSMFUhuaBQ5GsReRyCeTLi99nGT38447DWA?=
 =?us-ascii?Q?TR8mgd3n9JV1FMXyVVKWYyQziyPsGa+bs8ganaEayXFy9p+1YOcpfk1yaWp/?=
 =?us-ascii?Q?3dPuEg/mKlt8NLbB8Upa2TGGVpMjrTEEib1EvwoEPNbVHesz8229kwWRgMT7?=
 =?us-ascii?Q?ibPcAmnjIvQiTlYDkHkfNSi57rAE9GYMczcZOEKCwv6D1ZyP4NyDaW5PqHZn?=
 =?us-ascii?Q?iaiVxuIB9oZpdrNp/RGKfXFlG/MdZZCyMczOT/3mV8J1rshYCHrFk8QGtU9M?=
 =?us-ascii?Q?POEX1iUcnkjGT2kEerseHmiW7Hk5Z4kQHfXfO/2OnW2gDS5AGcCPQCcGgHW7?=
 =?us-ascii?Q?rQwl+Hln7F9188vLLym+7Gh0fHKX8m/y9NG4WpP+drsOuGJ8wDd+iaxccKw6?=
 =?us-ascii?Q?DgpUmkg+2g2dkygaSD3FoSpKSiNC6o4Gh0iOMOK9EYsFO7hVTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIXEu2/iE51CsYDVEPUWzoXUh6wZlcKDn9UW/O5fkTqvwXJdguDCKVokARjF?=
 =?us-ascii?Q?VsxzWD3KhxNRzraZESPM3h2RoxQlzkpB3a0uR3rP1jjxl7OCt9zDLUSUsTVr?=
 =?us-ascii?Q?gTlFeaMYz5VpTa274rHhPloDcKQqThNgFDhmnhMY1vn+b+zxGYGWtKxYHpxG?=
 =?us-ascii?Q?jpGl6o0h8Xj72QvrMdTLqDwoLPgHgj9iwyl2bGlPqKe/D3EhG7omTt7fRNtI?=
 =?us-ascii?Q?RzX3LJ1z6g6twB8K48zoMLKr9ipFb04slwAgU01/1vovBbTvN7aksZVL1jkR?=
 =?us-ascii?Q?pc6kE4gsGXn+r3joU6iz7GKfLKyeuPWN6SObX4FVlw4QFx76T+bS1jX4+yph?=
 =?us-ascii?Q?12ZoZhO9OiwIoV+QbWM07JmZG3V3LSu5iJC2Rr0SfsjKeE5J3IgHb0UmP/Oz?=
 =?us-ascii?Q?WI8wycYK4kcWSm+EWzuryFLATaHPOkvYD3OnU+kCExXKHSdlArI1lq71R6Qx?=
 =?us-ascii?Q?tRNASA/7DuJpqBV23P9DaByjB0hKTjmp1DU0HHpXUWgNikN1ehlnnJEqPP/R?=
 =?us-ascii?Q?QMPUP5q5U57nkOkNPTfsLLWpaJvNeL1NGRg19ZT6EwY3xKU6VTc9WEv5nxdY?=
 =?us-ascii?Q?n1+T8zbWL02EcyO3Wa/oiOvDnlTzMARVC+l1B5sQzolCVjQdvT3pRY5hxe8s?=
 =?us-ascii?Q?KHR6CvbfMsHSn4JqB+3GOkRUTGuQY8nxP68MaHyvVB1NDCRmeaiYnTRau8O6?=
 =?us-ascii?Q?MfL888oT8SQ9fKuRIPmIatNmn7hyrwkV7Yl4+NNfCci757D6UoRo1Omp8RAa?=
 =?us-ascii?Q?cTNQBwiMLHBXM416fEY4pQ3sk5LCAgoT6KtSU19Cn6n69tALZHPEBaOT+bXE?=
 =?us-ascii?Q?Tiw9hJQpCHU2CiTey1R1VN9cgISiWlBK++AHKmKeMp4j45hPCkLqQniTiyRQ?=
 =?us-ascii?Q?td1MBEAYPdr03+rkiqkWd/MdMXearxdD4AY2Y1sIDRxOZ/feVCb0ppFZhCIN?=
 =?us-ascii?Q?N8gq0ZKuLo5kvBvrNzQp4UEUPIjEekPzfWG7z33nu2LPgNMXSyl4xypUupAu?=
 =?us-ascii?Q?bZ7GUD15kbWH94rP3vqQz/c78hwSxaSgJ3i4qlToWg5nSNvzPub51YK03Vsu?=
 =?us-ascii?Q?txe2uYEGLEklNUyVKttSKmzSqAF/WWuc54Wv0dNziUC6AM5lTxw26L2SYqxR?=
 =?us-ascii?Q?Vb/8gsudZrWLfCmZvCI9w02Slg5ZuUl5gX12kJIFtnNgtCafOoVPZWelcW1e?=
 =?us-ascii?Q?DCay5RvUT4XCCdfe1A0ExFiZQeGXIGOX1SUpleLsHsvs0+npq0MKHnR9mOR2?=
 =?us-ascii?Q?xHW74eDjiS5lZC4+xnSdg7nbT2EptxhRmyA8LHjHWGE3t1CQM7FYnzDfs5Gp?=
 =?us-ascii?Q?nj+qCkkzc458DMWn+MwYT3i2m+OCTXFtySlNLtlmPmVP3tTZOZMc67zqA4YF?=
 =?us-ascii?Q?+g9HkQEv3E0jnOuaELihkmUwhvzUCawOHJzHMkbVqAYDf0jkfxnFyIGGGnp6?=
 =?us-ascii?Q?LOpVk9W5/07uQ6BgFziCumIWCf/zv+M+wCeH0PZASRNKlc3FmVMOPNQ/64Vf?=
 =?us-ascii?Q?t+crWITAGvc0W5lEnHXdc4pNhfEZcwAVGqSctF6vrO8qPaDPfYnVH4fOu7JK?=
 =?us-ascii?Q?iVAmKGEN87VF7Xa7vE2GChZ4b3PBLXEyOXMw6TP9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8197a7b4-0230-4ff8-9333-08ddd902c42d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:13:26.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3mJLBJ94ddefQBmjiKbvY7QVlGcoxAjEbRIWBZLMSDXcDvVKrUUcq0hlpZifjCS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

On 11 Aug 2025, at 10:39, David Hildenbrand wrote:

> migrate_folio_unmap() is the only user of MIGRATEPAGE_UNMAP. We want to
> remove MIGRATEPAGE_* completely.
>
> It's rather weird to have a generic MIGRATEPAGE_UNMAP, documented to be
> returned from address-space callbacks, when it's only used for an
> internal helper.
>
> Let's start by having only a single "success" return value for
> migrate_folio_unmap() -- 0 -- by moving the "folio was already freed"
> check into the single caller.
>
> There is a remaining comment for PG_isolated, which we renamed to
> PG_movable_ops_isolated recently and forgot to update.
>
> While we might still run into that case with zsmalloc, it's something we
> want to get rid of soon. So let's just focus that optimization on real
> folios only for now by excluding movable_ops pages. Note that concurrent
> freeing can happen at any time and this "already freed" check is not
> relevant for correctness.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/migrate.h |  1 -
>  mm/migrate.c            | 40 ++++++++++++++++++++--------------------
>  2 files changed, 20 insertions(+), 21 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi


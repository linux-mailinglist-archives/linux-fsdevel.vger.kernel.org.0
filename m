Return-Path: <linux-fsdevel+bounces-59988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF2AB4054E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4341017EBC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D8733E1;
	Tue,  2 Sep 2025 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/4ammBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF032ED53;
	Tue,  2 Sep 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820532; cv=fail; b=ah0d4xqfRE7xvJnw4xbo3HofqDdeWfrCQdJGEKd6miPFuuHb8VypgwO273SAkLn6YRbf5GeZdnmBEVnsP/XCMuxC453918DHL2/GuzIY1+3myUjadunURU11tr0a7F5WaTsQM0xEdLFOWuW9shxP8vViU71Dop8T6PiYpwKJyDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820532; c=relaxed/simple;
	bh=kGJtRSGp8LgAcGjHDdSfwMBcICMsVqigOJ4lOXD+Dak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=koptoG4OZnPSP99l7BEJGGCbEdSw4TWhdilogP8eelVHc1Q0tkcnN/q9nTt0ZpLyIUKgv4LPzJbtwO13XlX/HohiAbKC+2UqFXiUmpihmjmAc1cwyZn3u36yGaw2AjsCABp2dZcb2HWp6zAozy4K6lCuLpfyJV6MXLE2zvlmmTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/4ammBC; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnW8n3rLPvPGL9BcHZcpBj6vgZ4/3OyweZYcfHE6/gmH0nGwODp9dHLKMBhIqZ61NTIc7lezIrAIJ++uetdlOA2GT+6LT1qUV0aftXlmNZqXkemVulZbwftKDQ7uovweuOPRjEMTJ0mHcgUK7RgNka5PEYkD2OgftjgSDguWHFpIo5ZfrU1c9IcCZVT0Tx/Max35H3On6NXWMVv6ZJP5pOisMoOc7yAaebJTD0gPdhfF33eNpKkoKK64UNYyV8Z7TPLJzR9SgBY2SKKkVH2A2Ux6m8p0u+meKkgemrVk1cgPc9tL/8sOJHR3LL3qSme/1WGv8mDW1jwPNe06yP5Ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEybjIT39tfAtWyDWxHX2hIEW4WjU+uiXdQ+aAhfJdQ=;
 b=niIAe8UK5GocQkAv/8UZNHIaxc5ImaMtRxlx9CY056LnYJy4RY5qGODCKRhDsMR7RnJI+W62Z0oZy8uU2ZtgigVYC5GGiiA/1puCFQ5ziiNx6bWf/FxlrdGASpgPO/RMydWdf5yYjpHiaQJ7G5TbFcS6HqIo/rjVXejza1wghmJ3MFBIj4/r9Cx6zPw2Q8hY6zOzagWufFylHJbODjgm7rVwR6UGzdeQr8Rl4jQemPaCpJfIX5J5IvcNRZyTPCOUZvQEJjrm2tgiGmjLO5hyNQeUtBJjW1PKTnITB8eOeQtNozZd1y/iTnqlUUiezP3unRekukmS/IF+iK+0IYkHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEybjIT39tfAtWyDWxHX2hIEW4WjU+uiXdQ+aAhfJdQ=;
 b=i/4ammBChnBbQXtOn0lrXvWcMtGUS1zrL7gjwANl67rCPhjkMvHUMPisFIjttKLK9eAauFH8r2Rng6glCW7f6aOb5c/hSgSCFb8i5XFeUNJs/Mlh3eUrasZ8RzgbND8IEIRW76Zf6FP4ObgqmfTAP+91RLnkxOZogxMiebDrIBmetzjyhWrYq318lTxv2lW76lVavoC+EQgT5FWEewI5KhJ7ukMkLtBA0WYQFck1ihUmeXjzf1S7j5aqnw1ZxAb+7TdcsznjTL8QkUNw4ep8S1hTCAJJH14aI7CpR1pTVs6yZgIKpDs9Fse85/X+bC4vx8MIRJVEPjjk9dDf31XTOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:41:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:41:57 +0000
Date: Tue, 2 Sep 2025 10:41:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chris Li <chrisl@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <20250902134156.GM186519@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <CAF8kJuPaSQN04M-pvpFTjjpzk3pfHNhpx+mCkvWpZOs=0TF3gg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuPaSQN04M-pvpFTjjpzk3pfHNhpx+mCkvWpZOs=0TF3gg@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f298804-37d7-4bab-18a5-08ddea267c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5JxLcpjwR6GyS0yueaHCQW0qPezbGnIap2B3D175k2kiiFXO2F1cQk2lecM4?=
 =?us-ascii?Q?chETL4PPcJWU+Et1rsOMO0WMR2u3iVjQt/2o9wzZH7tsgy81Ia4ZAGQ8Q8AS?=
 =?us-ascii?Q?/HwvVLeJhCBr2mCOHuSRJdXWekJV+2GG+aL9gXgg3jroQ/18hNu/dqQSbNLz?=
 =?us-ascii?Q?TgHwGNegSOJKHij8wJ6OTehszTLgCWg0PqbYXYxS/c/naF6UplgCubcd8vPc?=
 =?us-ascii?Q?PxSSp8NgPG9iXloSEIuqHH/6wSySxHLn2dxRRk70t5U1u3wVUre8sVLIhZTP?=
 =?us-ascii?Q?w2HfDVp5d6oC9mIbNUmbWyj0Bgn0kVPWZ7akKiBrJf/SgIL8I+F7ASzVr+La?=
 =?us-ascii?Q?tGIzCkKxwgc6m3izmOjxpZqU33MLHhvFA3ZPy6Uxq5F5Q6++/rpCaomcZXWz?=
 =?us-ascii?Q?oUmoTOvRx0R00ir0bm+gU7ai9ZN7PBcvblORGM4efPT3jmWq2bBSUG44eijo?=
 =?us-ascii?Q?fZgBAvTqsLWuoijkiNll+D/rMKpd7lu7L7BqQckvSUsnCXqY6tI0nMWDkSKN?=
 =?us-ascii?Q?ndjASN1LlE1KV5tzhxY9Qqvg6dhzV0fbbyxRDB5qsfR7bYt8UOXT/+3mqNMz?=
 =?us-ascii?Q?0A3482g6m8hPVngZbGCHulF593p1qSXOLXnYIqNhTtlq+7mI4ef5b+8eYYg4?=
 =?us-ascii?Q?xrB3yxfWYpqlZPd3DcWuGVU8h8igp0S/seKqIxR+C5c+VJev+49NG3XgeS83?=
 =?us-ascii?Q?tnyEVgW89mRY10cU3LugbOPNGIMjJpUSgNjYmkCV5SP899vFThyKNG+P+B7S?=
 =?us-ascii?Q?OfIvmqbulb34UGq2f1pqHO4SIROrHey/2RCkW82gePJzQQdt9kjrrWEVQY36?=
 =?us-ascii?Q?bB5tt5J8JWh86lcN4J20ddfq/8map3wdEFebuUVZxFPWDjEwymn30xLh/0xo?=
 =?us-ascii?Q?RnSAJYT81s6g8JRXjn+Q/LXHR0UlHzibxOce+Dzbz/rdvrXa1uIPtGQ5Y0Xq?=
 =?us-ascii?Q?G68/DSwOJtKt1aNRfA4O7Y2lyyrM79cPynkxoF2amWa52ENdoqln1AhEOZ6A?=
 =?us-ascii?Q?qXCUoY7CCnPLVU7fi/6TFhAVhLGIugBajEaY0pOymmersXdZYFGIJ/EfV+NR?=
 =?us-ascii?Q?wJnxw5M1rTp1/4i7D4BrrX/UP/nKi4/SQwmBP2bHEbz/SgiNKjpP4J5xK04p?=
 =?us-ascii?Q?cTOeD5WVHVT2S5YfqhE31Hwh5z0IcgpszB4LQVRYL1d3Q+Ast2yBxXrDfhc6?=
 =?us-ascii?Q?A1trDAofxtRe6HctLvTop6jZass9xdr3Eik50mlTeQfUQtNAwdZyoAzAlvRL?=
 =?us-ascii?Q?0rbrG3FaD2M3/80FiYmX0/+53RdJCpYfJ+5Yl7sMSQ7lcP3QSIlXj6OqKOpx?=
 =?us-ascii?Q?0frXUSYHy7aUkhwRra0BuQcA2WuB402QyPioQXThBqQC5aUU3BHlcVCFKqS9?=
 =?us-ascii?Q?x/3scpVpe5cWdMdRPxqFnK3mHQ4DLXVOcB8Tbz7i7wYi1GpVyXvorFaHhVBx?=
 =?us-ascii?Q?KeeSt1DZQ3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2jL1gIG+SvQNrr2tnbrZBk8GSdHeAcsd1gUKaeUARZ9PMUpQbmqlih4k8c2d?=
 =?us-ascii?Q?lQRbmlioWdzOugdIWYTSkfkZanUHD4MrO9XW6H4bh60n4jI3hNCWLLRizKHA?=
 =?us-ascii?Q?6AAJrdUJJ9PkBgAdIur6deOijCEVTRbhbgOZ369wdAl8Nag85wQVRc0x2Btx?=
 =?us-ascii?Q?+/tqkLeSwvTdMI2bdJu/MjxbZp3ZL6K6nIpebZkkzfZ15eDJ9DnWf/SNmejA?=
 =?us-ascii?Q?CtJDahXG/8AZTZlsQGNkfQvHSJvJXcz//4TQwL8OfhQoYjWZ0BTfX8AsO04M?=
 =?us-ascii?Q?nMjrY0HU02azXT9PkluPxWXZUieSb0Sl2NB3T7NpWNddvcRKxzpwFHvIHUqN?=
 =?us-ascii?Q?viaaMdRrq87x5Q3HQ5nWQXs4Ho0dNjereAg2Yq5zDRxokJjy6D2OBCE6+QbL?=
 =?us-ascii?Q?VlL9lknVjiOjPsyVq2UsLwZz0x0RIIBwJwqZiEbwPOeZYQ4AooVrXhm56vcz?=
 =?us-ascii?Q?2fysy+MPdIU2pt3x0axP9mAKSwVwGPptG4WOF7gaaJxgvP5lruGga7NJK5/A?=
 =?us-ascii?Q?TqP7f30tHcBffq2BkVR9wOWxPYhIClaViLST2RSOYcJYgjKMyG+uwg6zzCWf?=
 =?us-ascii?Q?pgFk+tYpzwl7maZbEFCdQIp8bbKd/oCVSFpPSA0JF9AFIpRa5DTF8d/TeUNd?=
 =?us-ascii?Q?eAgjalFRV6PK+Z7jOE7R2Be6bIxU4+H4X/4KT2moRfQ3mlkprKmugN9hZM7E?=
 =?us-ascii?Q?zwweDtAkzH61Mmg3NxXSpKJMLu3K5R2IyUL6ECoHWaVkOTVQVMUaL+MY+Ru0?=
 =?us-ascii?Q?fU7wS8fgG1IiAnJ2IrUFJ5wClV8lXEnjj1LcxBC+xK9AFLM/w/XU810dLXpE?=
 =?us-ascii?Q?4pXG4KJmamFlQnhb8HVtNsNXk+0JTfsgpGfbCFP65MEHDNGsyidNTasN9s7K?=
 =?us-ascii?Q?JawU++gJAdP7SsUkIKrj42ZpAMpEqpToPttt5BVWw7Wyagcl5W0A+cpSTmNB?=
 =?us-ascii?Q?auBQgFqq7+v8lPSd2+i8/ZEya1bFhwD4ap8SHCQwupNcnzZ2bnukOhmwx4es?=
 =?us-ascii?Q?YbrGTtpHUOyFBTbzs7+YGCYeQoTNI3Xie/T99KNqfatcxcaUrYNLLA0kPmPv?=
 =?us-ascii?Q?bwTPPgll/aISdZApdb1z/lromtAFjaGUe83JMjgnWzHTQysTxnk42lC2zuKl?=
 =?us-ascii?Q?fuPnqGdHBVZc8AmsKHBBu2OCUoXFOMy3v0ZSHntiC3tjtYjI2Lu0Ip7xcECL?=
 =?us-ascii?Q?CE9f7mQpFNgE1NffMLJn3bSluRjXoEff7ndlYLWHFZQDZq4cZj+x3D+xgCpN?=
 =?us-ascii?Q?CZW48MdJsCOUERGu1s6dJu7AbN4gndKxULQcu7g3en73Dpq61vMnUs5Onsf2?=
 =?us-ascii?Q?hAIKxVRMSOGuGYVqjIXBqcSKj/8eZ6V9wpsQG8Rwr/42kJz9cQcQvQ39ZlKg?=
 =?us-ascii?Q?VChKfCOU16dvQ9G8BTBKjuIL0ryuFoVJaPhlWSBKH/SI2dJqcOQsds8IwqtS?=
 =?us-ascii?Q?LvTvj+YeIlJ+J7oTn9W3eY/cTc6nBuUTqGqo8Ypxi0LuewCcqI4ztA1LhItQ?=
 =?us-ascii?Q?UmE+vQeBH4s9KE1ybbMflrocdZmTHcTMcvoMNc2dva+lFg1bkUo2HbpBEKqn?=
 =?us-ascii?Q?e/E14UaTejfS0KaqPv4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f298804-37d7-4bab-18a5-08ddea267c28
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:41:57.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+EziM7yE+WN5x5MIDcTALvON33cmOgQN5RzZGpzsS8mNN4G8gW+Gqc7PmrfPJYD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

On Fri, Aug 29, 2025 at 12:18:43PM -0700, Chris Li wrote:

> Another idea is that having a middle layer manages the life cycle of
> the reserved memory for you. Kind of like a slab allocator for the
> preserved memory. 

If you want a slab allocator then I think you should make slab
preservable.. Don't need more allocators :\

> Question: Do we have a matching FDT node to match the memfd C
> structure hierarchy? Otherwise all the C struct will lump into one FDT
> node. Maybe one FDT node for all C struct is fine. Then there is a
> risk of overflowing the 4K buffer limit on the FDT node.

I thought you were getting rid of FDT? My suggestion was to be taken
as a FDT replacement..

You need some kind of hierarchy of identifiers, things like memfd
should chain off some higher level luo object for a file descriptor.

PCI should be the same, but not fd based.

It may be that luo maintains some flat dictionary of
  string -> [object type, version, u64 ptr]*

And if you want to serialize that the optimal path would be to have a
vmalloc of all the strings and a vmalloc of the [] data, sort of like
the kho array idea.

> At this stage, do you see that exploring such a machine idea can be
> beneficial or harmful to the project? If such an idea is considered
> harmful, we should stop discussing such an idea at all. Go back to
> building more batches of hand crafted screws, which are waiting by the
> next critical component.

I haven't heard a compelling idea that will obviously make things
better.. Adding more layers and complexity is not better.

Your BTF proposal doesn't seem to benifit memfd at all, it was focused
on extracting data directly from an existing struct which I feel very
strongly we should never do.

The above dictionary, I also don't see how BTF helps. It is such a
special encoding. Yes you could make some elaborate serialization
infrastructure, like FDT, but we have all been saying FDT is too hard
to use and too much code. I'm not sure I'm convinced there is really a
better middle ground :\

IMHO if there is some way to improve this it still yet to be found,
and I think we don't well understand what we need to serialize just
yet.

Smaller ideas like preserve the vmalloc will make big improvement
already.

Lets not race ahead until we understand the actual problem properly.

Jason


Return-Path: <linux-fsdevel+bounces-73302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94DD149D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50297301D31C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F837F72A;
	Mon, 12 Jan 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XDmH4QZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D74324397A;
	Mon, 12 Jan 2026 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240632; cv=fail; b=i9WEw/wsbRmpgaYR9/SOXzq37O4L4P4GETs5KDrKwIz94v40uV49Z0wpFEgaYxILUMk+CrAUdbfzDwAmEP4oznFs/YwWfq8P9icV+x7+/rwKyoMU4NZVKdd7wixvyhihpqJHdeyTa96/pn/LuI+ohXL/brT9XY4x63KYgxN8q24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240632; c=relaxed/simple;
	bh=710NArMwPn/1xOy2KcSTbfWPC1VI6KnvZBM/icYIdj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mLwVjPBwVLwBgSHXWb+2Q8SYyXE2Fbd2fAAj207+nG6PWCgoHwkYhQEKpyjH7mATWs3EsoaQcxg1ym4rhD7u+8f+1HF+moGsF4fbcVyIQexrhDwgTRi9Kv0AF5AVi50UTqCiG4xJW7CEFeyfh0pyM/s4B4NI/dOcT5UzQNdePdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XDmH4QZJ; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzldfOim7SGHPBggy8ui8RDYEgqhfQLBEJndZuGkJxEb2+LgRX0tfmjglv3U1OJ4pQg8USqVbbCHhcha5ygOnxIxE5jnaPlX6sXr+hcSLqzXEn1HSvXONWkbzOT8Kk+AAo8T9Cu3RtH5axlFLL++hXa3RyvH4QCOyTkVZ5j22YHS53Oci40kiFfo9tXYBdYp4pwrc9qJkpMD6WXa2qhS8+5PLa3wGKzuLuAyvcRZxXXZsNOEWYTSuLJRo0ChmyXZX0THACNEhQNzzXvchmzoRJbGeYd5xMj0lt3FkjIzZPL5umrV4l7sMvme0cVAJ2FezjVYH4/W+XZJG/0R88fyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8e9v0V3Wok5bTbPXeKb/Xp34K6bAiX/rFy0+C00CPw=;
 b=v1TVWMZB1h1CcwUbvn2MM9KB1vGAI8g76RJ4FtLLaF2LPEjFa1F0TiOC/FdoQyLWbzJX4Ww4/BAeo1nuIeIi/R+pMXw8Z/ET+3dvLt6Gn1bdW5Nv8h3x//tYOS39OE6elrOuN8Dwm8Ca34FtCXTxJ9B5dUiiMihfP9HW0uMli2gFL+Li199UUmzuiWpbXihLMaJKM24GmB18HV0Xhvm3RXETSv7P0VzWVTP4iqFaux0hZiYIS+H8chocRDcvNisdFVUhTl0XKxxoIGM6A+n3liSNdfPO/8Nf6THA3QMRu9uKGE9vyoE8FKuVpVH8iqXD78N3BrKKqPQiGdl5ZaCxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8e9v0V3Wok5bTbPXeKb/Xp34K6bAiX/rFy0+C00CPw=;
 b=XDmH4QZJR2hCxrghrvkPoDoMH1o6+qM5JbKM6DA3+fPcvTQhC8MPtoedCIT0mS/kYlBWjaK4gamBbt1iwIiJl7tfgO2WxdviEggYbZ7ukigZ32F5PXs21YBSlFPir6RszgjhdJW5ljTj+qR0JAkaRLj4tdbTYbOcTlr+N9Hs+i0CVrDAPHhgxHxurKTIEVfUBYAVNBMSUyF2lCCmy/9Bf6307J4mRlV/ys91LoPYe8L0ChSglbM3Dh6z7og9vOHkZqo20Eg2RwG905XhKbHrF+YKU//pJxJrOYVM00WxOn/mzvUHs73nsTusuZXajESt1dqjPGyzIzPy4Gq4z17aaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 17:57:00 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::bdb6:e12f:18b6:2b77]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::bdb6:e12f:18b6:2b77%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 17:56:59 +0000
Date: Mon, 12 Jan 2026 12:56:57 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, yosry.ahmed@linux.dev, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 4/8] cpuset: introduce cpuset.mems.sysram
Message-ID: <aWU16VlMLDgLS4Gg@yury>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-5-gourry@gourry.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108203755.1163107-5-gourry@gourry.net>
X-ClientProxiedBy: BN9PR03CA0797.namprd03.prod.outlook.com
 (2603:10b6:408:13f::22) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a2b784-4e94-4099-728d-08de5203fbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zob7/vtbp+c36Xkyj3KKYaQRLPU4zm4npZ6iaLCNswf5cVh2VKibAEiY2w8H?=
 =?us-ascii?Q?Y9ZNhozJor382bbbDuwYiu5DfzyLDNvneei3+7ndGZSUNqZMIGZ7T7HCPfmp?=
 =?us-ascii?Q?z8z8W+u16zI9J3ImVvtaEacfNoMXYKHFnfORIfpsBheFS39QlfvrzY2YhsEM?=
 =?us-ascii?Q?Q6lCDzUggdFsUl6hy3htKXUeF7SQLUtcsK8X+v4ZBEZd+rNzENApZ3cLz8Rx?=
 =?us-ascii?Q?+SwaOkagFvMfiRG3h5wthYy24pNX5ygaaFXGfjSPopNv4wwQtNWRCbg/RfpT?=
 =?us-ascii?Q?H6v2izP/xGuXpxbBBZvVNhWa+84M0sCeoTMzAFLhKO2x45KrZ9xAnkiGXnaI?=
 =?us-ascii?Q?fHron7GG5D/Er6KdncbGUOxB3hfPUt8W2RcYmOJ+3w75XNYkNSFvYnHZwQfa?=
 =?us-ascii?Q?q4uCxCRDCg6wpiZOnnspTwRBCA9UBk6WUQmkRh8nwVrkBhs3xQnPsWCTtUk3?=
 =?us-ascii?Q?L7V5kp+czaUcB8DLokVS1nTimVNa0hYEhUjrG6KVFF64vNzzQazpzPVg1Kcu?=
 =?us-ascii?Q?PDoisARrf3lEB6cFEX9gx6E3MFDNwFeGVtShJbNd17YtLtKiuGmhUo2AG8Y8?=
 =?us-ascii?Q?dPEUlRgl0yZJJlVBz0CoP2BpXb3M8mk3BpCGtGNg6Ut4DEGDuhHxfRMHJI3m?=
 =?us-ascii?Q?10E+EcWhziIkqhKT9FlP3M7sZ5w0etM0zBfHWfqSJ+5MtsM/tUOMMecAjQfx?=
 =?us-ascii?Q?askJC7x1ZurwFF5kPouDKF/vy11+zm/qpRNp5oecN7w5hm+m1mNpcqdl0rQ9?=
 =?us-ascii?Q?0TeeTtLo7M0lEg5q5Os4eb0Y1qYajFfvNa7Ztfz5DGXceVRgK9woOMYXS05+?=
 =?us-ascii?Q?SnGYth1oAFonVBDe6iEL7VJ40eg7aPCTy3SrRSlU0D8EO6I3Rq/wK7gPQZX2?=
 =?us-ascii?Q?E+xxpwWco2JbWYd4vZP60rCMDGzCTZxiK3K0xVs+iujPYj/cUpJ45ipn9w6Q?=
 =?us-ascii?Q?COf0bdozsl7QbJQULywxUGVETMRbEMWGUtK8Zrp3mLf3Bt/jRy+Z2sf2ZGR4?=
 =?us-ascii?Q?P2I1m/HMkqBDc79E8iBhIawhRu0rFMjPtPdf8dnwZNIpeo1+AFO5ySFBje1l?=
 =?us-ascii?Q?EOw3/3vo9jmp+zxws5E/5kzISl7Zr98xCDUBD/3caMAkqPYYXtcmrfrrlyRd?=
 =?us-ascii?Q?T/fCnZJoO3Fq7H40zeJBweYx3H/XtrArc3Yitn0oSnF9JaOlg8VQ/YvdNtA0?=
 =?us-ascii?Q?zdqYOhlhNUs4psrTDnG5MqKrOwH2/ZB6X1HZ0BABgBj6Pxt3q+sXEpkAuvUu?=
 =?us-ascii?Q?SCt3ggqKP27oMZr1WRsFC7Sa1NwV5gyD7bh9mQJMroXOUF2WH14a07sxg8bV?=
 =?us-ascii?Q?pNNRotXMYt0XCq9SeLvn/y36uzpHqEwbKA4ilIV2nS7/FOFL6rSRThVw5zzo?=
 =?us-ascii?Q?vbiuyxJWURk6oLP5rFGMq3bP8rtMAXh39oQKKw2kcgWebpBt26fBtag3vDwE?=
 =?us-ascii?Q?npD8N5pJz9EKnsnAKD12edxZqJSDism6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w17JRtpubIpv3l48RIhNFP/HRqi7SkmnjkPdxdo0D8DEKjcNd7a72H4hskhH?=
 =?us-ascii?Q?Fb2bABZ1/StcXzuSgLFYg4H2rWKJ1xexUJ1a0dJQ/e8zj/+ruoQJEEFqY5TL?=
 =?us-ascii?Q?ZZVbs/BjXAoWlLeblBakNwK58O2OfVuycp9ccuNvcWIDtAHCBJTIpT2jim2E?=
 =?us-ascii?Q?WYyY7voijFbAyRm6T4Y9b4TIKqOTIumj33BYpsAVU0dIeRsv8BBBWibJn+J3?=
 =?us-ascii?Q?FMH0snEkW+8LalUEAbB/irOuCI1sEfxlitMkshLD1E+66kqgnlrzhNxDP7U+?=
 =?us-ascii?Q?JdlWfE7RB9qvgOtI9W4rmnMvn4ZJzVaRLOOQ/GGemroG8lnjUlrmtBYBq4UH?=
 =?us-ascii?Q?jCRN42De5v/7Qiq9s3cXnQVjk5GaF+yF0aNNY0FzYj+zgipzxUHYKTYqwzZZ?=
 =?us-ascii?Q?/0UQT+82BUcP4pliGUPzBVXpmqxcPI9rP+8dg8aqGmKQPPJ72exttBxncIVE?=
 =?us-ascii?Q?cVkhJ8W7dwtwhBXH7P9YANHLpKNgAfcCNyxlTItbXBXyvhLusfWDlkj4OMuk?=
 =?us-ascii?Q?1QXZtXmkqIQRAsZxKH5artHfyNIBQ/vjr9OOH6OuRBnuL3N3h8RqXZOCuu/x?=
 =?us-ascii?Q?PhedYss4AgTdh9g6rcAXdiRI+yCx/Zy9y9pcj9nYKtt7V2GfzFNTSSUJfeNM?=
 =?us-ascii?Q?uNR9c6VcuOxRUzovIFWdCc5R4zoZq+FQF4Rml9bChmG+8wgdvZHjsAgCBUSL?=
 =?us-ascii?Q?HmsjbAhpJW5KPtng0EcdGn/KOC8AMWjFgSeaKkQS8hD16WCVBcZH38gRFrME?=
 =?us-ascii?Q?1Og3V9llyh4776ja4PUEKZNBzo1nQUgG04wmZ36IXROkdce98yMW7atswrYZ?=
 =?us-ascii?Q?AYIEFqoTlGt+6faMQZ58K4JpcWN6U9ljBvDbm9/e8ab0nsiaEuPDDtxJDu0t?=
 =?us-ascii?Q?F+2FZVZz/i0/aDx//+ciFJYpPqLOoo7KgMeS2UdYBNj9omTApPl2w7ckSZ9b?=
 =?us-ascii?Q?x7nJUOla/NH7g16lMOwFYiBjmSOkrXT+qhly9t08eFHxZmyDRwzXRi1JJTLb?=
 =?us-ascii?Q?JoBDA9uewP0dUMvebzxRQQQQPsf/v4rsyvrVk+7zYcXLwDVEKdVsN0q85C09?=
 =?us-ascii?Q?AJ0BuLxgCdRVPR20zIe0L0MrJBaXDTonQRELi86gx7PTWN7qlDMbv+MXomsC?=
 =?us-ascii?Q?t2wdxdv7NEvA9Z3vHO8fg6OryWqUeP2RMrV9/IE2XuVaOtqS2aFU3gbceYse?=
 =?us-ascii?Q?KCIcYnndXIGAeUsgV1KfYTIbXpi/GVl3hK9+fL2xvbb7cBxaEaGJGbVCA8s6?=
 =?us-ascii?Q?HJnJ3dydsmlo2vBFW0pki4hKCQa5r5fzKsProSoYPACkgX5GkeusPlg3xx5K?=
 =?us-ascii?Q?2+1noKY1GVLiL6oM+dPePrNDA5H2HHBX/w+a2fEnOzVHvPwi6CQpSqTPvTTt?=
 =?us-ascii?Q?57QYEnOSgrFbAUgbURqDQHG+7s3CNiaR2CLOdAXULJee1PbnLy4FNBeIc6zR?=
 =?us-ascii?Q?alU15auV/Rd5Z7Yc0lNodqpxQs1LVpUtxKCGEqlQAoerFAqFqc1MIjAdEaIC?=
 =?us-ascii?Q?c82bWVF7xXC3fQmHgan8ZWZ/CuQTe0lLHtc7Yw2H/f/PKwFCk9a4k6abHpiz?=
 =?us-ascii?Q?PSEFRN5LGJuTUVouKwkNHUN4u91Ygz10exqk+sJxyuwkndU9xHpQ0bYxRxi1?=
 =?us-ascii?Q?jzTfgt990H7Giyzr6JxonHRHa7C/3OK0s6AnbWrQsZDYqK2jezGgQdWXFN1i?=
 =?us-ascii?Q?1xMufx+fvvGHFUY4Eo0TtzJshsMXkCgClSpPOAm830qPa3H2WUViSOr+eZK/?=
 =?us-ascii?Q?Nh7HpjNICh937R7sFoWlixjlTiug/qcpitZjG8BcHE4nGI8iWMP+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a2b784-4e94-4099-728d-08de5203fbd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 17:56:59.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFgOcJZWg/KdKmUL1AW/8xbNIQJNye+R8b0zNoN8SIcJTbJAKGfXvwtNis88YWxQNHCUdvp0YmSEUb618NpEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

On Thu, Jan 08, 2026 at 03:37:51PM -0500, Gregory Price wrote:
> mems_sysram contains only SystemRAM nodes (omitting Private Nodes).
> 
> The nodemask is intersect(effective_mems, node_states[N_MEMORY]).
> 
> When checking mems_allowed, check for __GFP_THISNODE to determine if
> the check should be made against sysram_nodes or mems_allowed.
> 
> This omits Private Nodes (N_PRIVATE) from default mems_allowed checks,
> making those nodes unreachable via normal allocation paths (page
> faults, mempolicies, etc).
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  include/linux/cpuset.h          | 20 +++++--
>  kernel/cgroup/cpuset-internal.h |  8 +++
>  kernel/cgroup/cpuset-v1.c       |  8 +++
>  kernel/cgroup/cpuset.c          | 96 +++++++++++++++++++++++++--------
>  mm/memcontrol.c                 |  2 +-
>  mm/mempolicy.c                  |  6 +--
>  mm/migrate.c                    |  4 +-
>  7 files changed, 112 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index fe4f29624117..1ae09ec0fcb7 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -174,7 +174,9 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
>  
> -extern void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask);
> +extern void cpuset_sysram_nodes_allowed(struct cgroup *cgroup,
> +					nodemask_t *mask);
> +extern nodemask_t cpuset_sysram_nodemask(struct task_struct *p);
>  #else /* !CONFIG_CPUSETS */
>  
>  static inline bool cpusets_enabled(void) { return false; }
> @@ -218,7 +220,13 @@ static inline bool cpuset_cpu_is_isolated(int cpu)
>  	return false;
>  }
>  
> -static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
> +static inline void cpuset_sysram_nodes_allowed(struct cgroup *cgroup,
> +					       nodemask_t *mask)
> +{
> +	nodes_copy(*mask, node_possible_map);
> +}
> +
> +static inline nodemask_t cpuset_sysram_nodemask(struct task_struct *p)
>  {
>  	return node_possible_map;
>  }
> @@ -301,10 +309,16 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>  	return false;
>  }
>  
> -static inline void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
> +static inline void cpuset_sysram_nodes_allowed(struct cgroup *cgroup,
> +					       nodemask_t *mask)
>  {
>  	nodes_copy(*mask, node_states[N_MEMORY]);
>  }
> +
> +static nodemask_t cpuset_sysram_nodemask(struct task_struct *p)
> +{
> +	return node_states[N_MEMORY];
> +}
>  #endif /* !CONFIG_CPUSETS */
>  
>  #endif /* _LINUX_CPUSET_H */
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 01976c8e7d49..4764aaef585f 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -53,6 +53,7 @@ typedef enum {
>  	FILE_MEMORY_MIGRATE,
>  	FILE_CPULIST,
>  	FILE_MEMLIST,
> +	FILE_MEMS_SYSRAM,
>  	FILE_EFFECTIVE_CPULIST,
>  	FILE_EFFECTIVE_MEMLIST,
>  	FILE_SUBPARTS_CPULIST,
> @@ -104,6 +105,13 @@ struct cpuset {
>  	cpumask_var_t effective_cpus;
>  	nodemask_t effective_mems;
>  
> +	/*
> +	 * SystemRAM Memory Nodes for tasks.
> +	 * This is the intersection of effective_mems and node_states[N_MEMORY].
> +	 * Tasks will have their sysram_nodes set to this value.
> +	 */
> +	nodemask_t mems_sysram;
> +
>  	/*
>  	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
>  	 *
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 12e76774c75b..45b74181effd 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -293,6 +293,8 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>  	cpumask_copy(cs->effective_cpus, new_cpus);
>  	cs->mems_allowed = *new_mems;
>  	cs->effective_mems = *new_mems;
> +	nodes_and(cs->mems_sysram, cs->effective_mems, node_states[N_MEMORY]);
> +	cpuset_update_tasks_nodemask(cs);
>  	cpuset_callback_unlock_irq();
>  
>  	/*
> @@ -532,6 +534,12 @@ struct cftype cpuset1_files[] = {
>  		.private = FILE_EFFECTIVE_MEMLIST,
>  	},
>  
> +	{
> +		.name = "mems_sysram",
> +		.seq_show = cpuset_common_seq_show,
> +		.private = FILE_MEMS_SYSRAM,
> +	},
> +
>  	{
>  		.name = "cpu_exclusive",
>  		.read_u64 = cpuset_read_u64,
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a3ade9d5968b..4c213a2ea7ac 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -29,6 +29,7 @@
>  #include <linux/mempolicy.h>
>  #include <linux/mm.h>
>  #include <linux/memory.h>
> +#include <linux/memory-tiers.h>
>  #include <linux/export.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
> @@ -454,11 +455,11 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>   *
>   * Call with callback_lock or cpuset_mutex held.
>   */
> -static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
> +static void guarantee_online_sysram_nodes(struct cpuset *cs, nodemask_t *pmask)
>  {
> -	while (!nodes_intersects(cs->effective_mems, node_states[N_MEMORY]))
> +	while (!nodes_intersects(cs->mems_sysram, node_states[N_MEMORY]))
>  		cs = parent_cs(cs);
> -	nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
> +	nodes_and(*pmask, cs->mems_sysram, node_states[N_MEMORY]);
>  }
>  
>  /**
> @@ -2791,7 +2792,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  
>  	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
>  
> -	guarantee_online_mems(cs, &newmems);
> +	guarantee_online_sysram_nodes(cs, &newmems);
>  
>  	/*
>  	 * The mpol_rebind_mm() call takes mmap_lock, which we couldn't
> @@ -2816,7 +2817,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  
>  		migrate = is_memory_migrate(cs);
>  
> -		mpol_rebind_mm(mm, &cs->mems_allowed);
> +		mpol_rebind_mm(mm, &cs->mems_sysram);
>  		if (migrate)
>  			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>  		else
> @@ -2876,6 +2877,8 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
>  
>  		spin_lock_irq(&callback_lock);
>  		cp->effective_mems = *new_mems;
> +		nodes_and(cp->mems_sysram, cp->effective_mems,
> +			  node_states[N_MEMORY]);
>  		spin_unlock_irq(&callback_lock);
>  
>  		WARN_ON(!is_in_v2_mode() &&
> @@ -3304,11 +3307,11 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  	 * by skipping the task iteration and update.
>  	 */
>  	if (cpuset_v2() && !cpus_updated && !mems_updated) {
> -		cpuset_attach_nodemask_to = cs->effective_mems;
> +		cpuset_attach_nodemask_to = cs->mems_sysram;
>  		goto out;
>  	}
>  
> -	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> +	guarantee_online_sysram_nodes(cs, &cpuset_attach_nodemask_to);
>  
>  	cgroup_taskset_for_each(task, css, tset)
>  		cpuset_attach_task(cs, task);
> @@ -3319,7 +3322,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>  	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
>  	 * not set.
>  	 */
> -	cpuset_attach_nodemask_to = cs->effective_mems;
> +	cpuset_attach_nodemask_to = cs->mems_sysram;
>  	if (!is_memory_migrate(cs) && !mems_updated)
>  		goto out;
>  
> @@ -3441,6 +3444,9 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
>  	case FILE_EFFECTIVE_MEMLIST:
>  		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
>  		break;
> +	case FILE_MEMS_SYSRAM:
> +		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->mems_sysram));
> +		break;
>  	case FILE_EXCLUSIVE_CPULIST:
>  		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->exclusive_cpus));
>  		break;
> @@ -3552,6 +3558,12 @@ static struct cftype dfl_files[] = {
>  		.private = FILE_EFFECTIVE_MEMLIST,
>  	},
>  
> +	{
> +		.name = "mems.sysram",
> +		.seq_show = cpuset_common_seq_show,
> +		.private = FILE_MEMS_SYSRAM,
> +	},
> +
>  	{
>  		.name = "cpus.partition",
>  		.seq_show = cpuset_partition_show,
> @@ -3654,6 +3666,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  	if (is_in_v2_mode()) {
>  		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
>  		cs->effective_mems = parent->effective_mems;
> +		nodes_and(cs->mems_sysram, cs->effective_mems,
> +			  node_states[N_MEMORY]);
>  	}
>  	spin_unlock_irq(&callback_lock);
>  
> @@ -3685,6 +3699,8 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>  	spin_lock_irq(&callback_lock);
>  	cs->mems_allowed = parent->mems_allowed;
>  	cs->effective_mems = parent->mems_allowed;
> +	nodes_and(cs->mems_sysram, cs->effective_mems,
> +		  node_states[N_MEMORY]);
>  	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
>  	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
>  	spin_unlock_irq(&callback_lock);
> @@ -3838,7 +3854,7 @@ static void cpuset_fork(struct task_struct *task)
>  
>  	/* CLONE_INTO_CGROUP */
>  	mutex_lock(&cpuset_mutex);
> -	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> +	guarantee_online_sysram_nodes(cs, &cpuset_attach_nodemask_to);
>  	cpuset_attach_task(cs, task);
>  
>  	dec_attach_in_progress_locked(cs);
> @@ -3887,7 +3903,8 @@ int __init cpuset_init(void)
>  	cpumask_setall(top_cpuset.effective_xcpus);
>  	cpumask_setall(top_cpuset.exclusive_cpus);
>  	nodes_setall(top_cpuset.effective_mems);
> -
> +	nodes_and(top_cpuset.mems_sysram, top_cpuset.effective_mems,
> +		  node_states[N_MEMORY]);

A & TRUE == A, so maybe:

        nodes_copy(top_cpuset.mems_sysram, node_states[N_MEMORY])

And maybe:

        nodes_complement(top_cpuset.mems_sysram, node_states[N_PRIVATE])

>  	fmeter_init(&top_cpuset.fmeter);
>  
>  	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
> @@ -3916,6 +3933,7 @@ hotplug_update_tasks(struct cpuset *cs,
>  	spin_lock_irq(&callback_lock);
>  	cpumask_copy(cs->effective_cpus, new_cpus);
>  	cs->effective_mems = *new_mems;
> +	nodes_and(cs->mems_sysram, cs->effective_mems, node_states[N_MEMORY]);

Same here, maybe:

	nodes_andnot(cs->mems_sysram, cs->effective_mems, node_states[N_PRIVATE]);

>  	spin_unlock_irq(&callback_lock);
>  
>  	if (cpus_updated)
> @@ -4064,7 +4082,15 @@ static void cpuset_handle_hotplug(void)
>  
>  	/* fetch the available cpus/mems and find out which changed how */
>  	cpumask_copy(&new_cpus, cpu_active_mask);
> -	new_mems = node_states[N_MEMORY];
> +
> +	/*
> +	 * Effective mems is union(N_MEMORY, N_PRIVATE), this allows
> +	 * control over N_PRIVATE node usage from cgroups while
> +	 * mems.sysram prevents N_PRIVATE nodes from being used
> +	 * without __GFP_THISNODE.
> +	 */
> +	nodes_clear(new_mems);
> +	nodes_or(new_mems, node_states[N_MEMORY], node_states[N_PRIVATE]);

No need to clear nodemask before nodes_or()

>  
>  	/*
>  	 * If subpartitions_cpus is populated, it is likely that the check
> @@ -4106,6 +4132,8 @@ static void cpuset_handle_hotplug(void)
>  		if (!on_dfl)
>  			top_cpuset.mems_allowed = new_mems;
>  		top_cpuset.effective_mems = new_mems;
> +		nodes_and(top_cpuset.mems_sysram, top_cpuset.effective_mems,
> +			  node_states[N_MEMORY]);
>  		spin_unlock_irq(&callback_lock);
>  		cpuset_update_tasks_nodemask(&top_cpuset);
>  	}
> @@ -4176,6 +4204,7 @@ void __init cpuset_init_smp(void)
>  
>  	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
>  	top_cpuset.effective_mems = node_states[N_MEMORY];
> +	top_cpuset.mems_sysram = node_states[N_MEMORY];
>  
>  	hotplug_node_notifier(cpuset_track_online_nodes, CPUSET_CALLBACK_PRI);
>  
> @@ -4293,14 +4322,18 @@ bool cpuset_cpus_allowed_fallback(struct task_struct *tsk)
>  	return changed;
>  }
>  
> +/*
> + * At this point in time, no hotplug nodes can have been added, so just set
> + * the sysram_nodes of the init task to the set of N_MEMORY nodes.
> + */
>  void __init cpuset_init_current_mems_allowed(void)
>  {
> -	nodes_setall(current->mems_allowed);
> +	current->mems_allowed = node_states[N_MEMORY];
>  }
>  
>  /**
> - * cpuset_mems_allowed - return mems_allowed mask from a tasks cpuset.
> - * @tsk: pointer to task_struct from which to obtain cpuset->mems_allowed.
> + * cpuset_sysram_nodemask - return mems_sysram mask from a tasks cpuset.
> + * @tsk: pointer to task_struct from which to obtain cpuset->mems_sysram.
>   *
>   * Description: Returns the nodemask_t mems_allowed of the cpuset
>   * attached to the specified @tsk.  Guaranteed to return some non-empty
> @@ -4308,13 +4341,13 @@ void __init cpuset_init_current_mems_allowed(void)
>   * tasks cpuset.
>   **/
>  
> -nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
> +nodemask_t cpuset_sysram_nodemask(struct task_struct *tsk)
>  {
>  	nodemask_t mask;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&callback_lock, flags);
> -	guarantee_online_mems(task_cs(tsk), &mask);
> +	guarantee_online_sysram_nodes(task_cs(tsk), &mask);
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  
>  	return mask;
> @@ -4383,17 +4416,30 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>   *	tsk_is_oom_victim   - any node ok
>   *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
>   *	GFP_USER     - only nodes in current tasks mems allowed ok.
> + *	GFP_THISNODE - allows private memory nodes in mems_allowed

It has broader scope:

 * %__GFP_THISNODE forces the allocation to be satisfied from the requested
 * node with no fallbacks or placement policy enforcements.

Or I misunderstand something? Anyways, a new dedicated flag would be
better.

>   */
>  bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>  {
>  	struct cpuset *cs;		/* current cpuset ancestors */
>  	bool allowed;			/* is allocation in zone z allowed? */
>  	unsigned long flags;
> +	bool private_nodes = gfp_mask & __GFP_THISNODE;
>  
> +	/* Only SysRAM nodes are valid in interrupt context */
>  	if (in_interrupt())
> -		return true;
> -	if (node_isset(node, current->mems_allowed))
> -		return true;
> +		return node_isset(node, node_states[N_MEMORY]);

Please: node_state(node, N_MEMORY);

Here and everywhere, it implies that every non-private node is N_MEMORY
node. In other words, the before and after are not equivalent. If you want
to make them equivalent, please:
        
        return !node_state(node, N_PRIVATE);

Thank,
Yury

> +
> +	if (private_nodes) {
> +		rcu_read_lock();
> +		cs = task_cs(current);
> +		allowed = node_isset(node, cs->effective_mems);
> +		rcu_read_unlock();
> +	} else
> +		allowed = node_isset(node, current->mems_allowed);
> +
> +	if (allowed)
> +		return allowed;
> +
>  	/*
>  	 * Allow tasks that have access to memory reserves because they have
>  	 * been OOM killed to get memory anywhere.
> @@ -4412,6 +4458,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>  	cs = nearest_hardwall_ancestor(task_cs(current));
>  	allowed = node_isset(node, cs->mems_allowed);
>  
> +	/* If not allowing private node allocation, restrict to sysram nodes */
> +	if (!private_nodes)
> +		allowed &= node_isset(node, node_states[N_MEMORY]);
> +
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  	return allowed;
>  }
> @@ -4434,7 +4484,7 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   * online due to hot plugins. Callers should check the mask for validity on
>   * return based on its subsequent use.
>   **/
> -void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
> +void cpuset_sysram_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
>  {
>  	struct cgroup_subsys_state *css;
>  	struct cpuset *cs;
> @@ -4457,16 +4507,16 @@ void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
>  
>  	/*
>  	 * The reference taken via cgroup_get_e_css is sufficient to
> -	 * protect css, but it does not imply safe accesses to effective_mems.
> +	 * protect css, but it does not imply safe accesses to mems_sysram.
>  	 *
> -	 * Normally, accessing effective_mems would require the cpuset_mutex
> +	 * Normally, accessing mems_sysram would require the cpuset_mutex
>  	 * or callback_lock - but the correctness of this information is stale
>  	 * immediately after the query anyway. We do not acquire the lock
>  	 * during this process to save lock contention in exchange for racing
>  	 * against mems_allowed rebinds.
>  	 */
>  	cs = container_of(css, struct cpuset, css);
> -	nodes_copy(*mask, cs->effective_mems);
> +	nodes_copy(*mask, cs->mems_sysram);
>  	css_put(css);
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7fbe9565cd06..2df7168edca0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5610,7 +5610,7 @@ void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
>  	 * in effective_mems and hot-unpluging of nodes, inaccurate allowed
>  	 * mask is acceptable.
>  	 */
> -	cpuset_nodes_allowed(memcg->css.cgroup, &allowed);
> +	cpuset_sysram_nodes_allowed(memcg->css.cgroup, &allowed);
>  	nodes_and(*mask, *mask, allowed);
>  }
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 76da50425712..760b5b6b4ae6 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1901,14 +1901,14 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>  	}
>  	rcu_read_unlock();
>  
> -	task_nodes = cpuset_mems_allowed(task);
> +	task_nodes = cpuset_sysram_nodemask(task);
>  	/* Is the user allowed to access the target nodes? */
>  	if (!nodes_subset(*new, task_nodes) && !capable(CAP_SYS_NICE)) {
>  		err = -EPERM;
>  		goto out_put;
>  	}
>  
> -	task_nodes = cpuset_mems_allowed(current);
> +	task_nodes = cpuset_sysram_nodemask(current);
>  	nodes_and(*new, *new, task_nodes);
>  	if (nodes_empty(*new))
>  		goto out_put;
> @@ -2833,7 +2833,7 @@ struct mempolicy *__mpol_dup(struct mempolicy *old)
>  		*new = *old;
>  
>  	if (current_cpuset_is_being_rebound()) {
> -		nodemask_t mems = cpuset_mems_allowed(current);
> +		nodemask_t mems = cpuset_sysram_nodemask(current);
>  		mpol_rebind_policy(new, &mems);
>  	}
>  	atomic_set(&new->refcnt, 1);
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5169f9717f60..0ad893bf862b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2534,7 +2534,7 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  	 */
>  	if (!pid) {
>  		mmget(current->mm);
> -		*mem_nodes = cpuset_mems_allowed(current);
> +		*mem_nodes = cpuset_sysram_nodemask(current);
>  		return current->mm;
>  	}
>  
> @@ -2555,7 +2555,7 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  	mm = ERR_PTR(security_task_movememory(task));
>  	if (IS_ERR(mm))
>  		goto out;
> -	*mem_nodes = cpuset_mems_allowed(task);
> +	*mem_nodes = cpuset_sysram_nodemask(task);
>  	mm = get_task_mm(task);
>  out:
>  	put_task_struct(task);
> -- 
> 2.52.0


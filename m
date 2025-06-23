Return-Path: <linux-fsdevel+bounces-52590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08021AE46C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FF317BA24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247BF2561D4;
	Mon, 23 Jun 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2e3nKXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649B15B971;
	Mon, 23 Jun 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688424; cv=fail; b=bw1xITtiGVkubS2dL/RWFZMVATmxJHPOz1oxvkLVOWp2yw8zA+LG1m4dKOkj166To5sblDiQ0JfplRQMmF2mEC6hsr+lDxg5fIgUXt6j4HhZz9J5nziza8n4uj2YO4tnSiqQoE7sff8hplKbrH5b42t+Ah8y5dp799PHnWEvio8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688424; c=relaxed/simple;
	bh=xxu4ecfSLb1HBwsFLh3/CAUoUKkzDAdSzBqhzgvET98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbHfuam5KhFcv7HSfNQ4GH4ZwBrNCAGK5yx6BQBBUAB9iDVWhavogXrV4FmN85AQkX9/Nh47LLqVb8ZMYFrMyU9S/+/1ZU+43s0Jnwfv4wujpUyqvcJYKc59g3AC5h4X81VscdNzNoMcSWk/xsBwX57QCV33EEcLTkj7fiqKb48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N2e3nKXi; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLDDo/H6/0hnfeLR9OFuYAJj34p/9JRZ7LnEkzpajG8F4ueniUB/lSEXLUYEOcFy/gxmYlLKWpbB/YbXoYejJvwG9mcp1VkDNwHCYBpUnNGKHZQNH/vaKqRKiIm/eDgheK4jXE5cBok0SxLxqnJTHZE/jgVOaZlA8RM5ZYwR9js1goY6IOkMdczzy37wAcMQMaYlknlBgYQoBxf/0sbNw4WLHppa2LDXmpVAPN2xrYwb406gHg3GNMuw78PTxWUk+eVVOZf2c3nxJw8BdQApJBvLIru6ZNX/CEvan5MnBbRTUMtt1But71B0RGVVfV8oOqAzb2uQbvFtexzca9LZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzHw8TNQcoND24i3VDjfQXWwKVvafITftyN2GPGYaDI=;
 b=XzSfGRY0TkTXfiK/KSaMTrA9QKHodrzuPmM/9M1Frhx1qhjfMY9RR1cU2liR3canH6CN3JtlAvh338/ew55iQsQ0dm53xRiT1xGctutDLdGnCmMELdSdU9qM8eu6t20cGiy0oDwSOu493+7xSst+Lntca/gGJUnvp6epEKwFgQ99aNFEb1wePYOwOeOhTqCMPM7qviTVqKX0cK1rLhbNw6+3BQMu6GW1CR4pwMiMH2Ad0ZC7l6ohxb3yVM081CiNFsFTmoXhG3Pku3M4lcE6dchJWvHH+baf2AL414oDW697Lk7jkCDcyN0m6Zh3FrhE2lLZY+YhXPMlcfhKPS02YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzHw8TNQcoND24i3VDjfQXWwKVvafITftyN2GPGYaDI=;
 b=N2e3nKXiGrqyPu8uqQb+J1/2UJspbiloUOkfpP1tZJF0HBRoAREg7DhWDXx7ft9rFvfc1H1vVLQv6VVy2aKQd4x0+PkITpHu0zn1MvLcm8Q60SPIN63BQZ6jSdMfoHMRbydW/y9pQC/asj16+MQdtrgqeL8DuvJ465PvIO9VuyUVxwicImH5OwF3SWyAlruzV4M9k0VoWdaGyHXSbyAsdIXPi8Xytx16JUo6b8b9y7igVOiBdIQX5fDMZ7e0twMT07ZvrTRe+hb1XTTNgqabX73ziIGRzxsK9gNVIDnq1xz+iYCJFmZS10zb77bX7DkJqSXytvjCyobEd4fqVEgAQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.22; Mon, 23 Jun 2025 14:20:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 14:20:18 +0000
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
Subject: Re: [PATCH RFC 23/29] mm/page-alloc: remove PageMappingFlags()
Date: Mon, 23 Jun 2025 10:20:15 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <54FEB3D0-0663-4A4C-BEAD-E87BE46879DA@nvidia.com>
In-Reply-To: <20250618174014.1168640-24-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-24-david@redhat.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8812df23-7f7d-401c-0a92-08ddb26114b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CgVcPiXo/yqTgjQspQmGgZPxIFLO3632qoVuOMBHaZ+q7baelDpHimxjosB3?=
 =?us-ascii?Q?pQczMPG7hVnbwOpEdQay/pXN9CjifFQqOB2++Q+QfRI71No6dMv0YK0Ix+ha?=
 =?us-ascii?Q?mjBHUC3U/b4S9N/QJ36Go1gpdD9EYrhNomQ/81H0reNLEP0XUz8daFu6rkDk?=
 =?us-ascii?Q?FJs8LegCjVE6V2vbqljFbCY/DkUTJW+BI4jVknWWN6hyq6Y8pOTye1AaW2l/?=
 =?us-ascii?Q?6aZu5NJrJwV9+rA3qrvgmvHYlj8ZHxZpOkaJVWn9qEQqbo8P1CC40nGv9tZ6?=
 =?us-ascii?Q?Cy0/01r266eGXLD/1YlKh3MRM7O6o4Saw5pW0tKx16CApfj6CxI2bn8ZLT86?=
 =?us-ascii?Q?emAR542gk14dCakNYGO3opwDEKkaisVjh9we8gUh8RBGUBtgYxR4Cm3G0/T4?=
 =?us-ascii?Q?35UD3D367lecgCv8pXwaYqpvqTr2kT+4X53NvM84aLjsW6eSPR3E/zdiRmN8?=
 =?us-ascii?Q?IXBhUIt1qxe/llmQ+5wm+wDriBYQrzwn+mKVIMcsfiU17H+CEbjfUa3BEbN3?=
 =?us-ascii?Q?RY/Yglsa9DgYoXgZNYeZnpNUM5fj22uduHPAK31uu0UAEX16Dl146N2clw9s?=
 =?us-ascii?Q?AEWyQ68u+ZX31I9xNXCTJkLTwqwz66Auzk/mtqlv3w8L+E7xU0A8HAiWsMUi?=
 =?us-ascii?Q?HHqK+AQowQb9nIih4VtA3EIhR84xiFQmAKzaduRchOvK+zaKCRTuWpF5DoAZ?=
 =?us-ascii?Q?Vt83Fb/Lv8J14UKPTLYa8FlythfDcCwMdjWpVgfnBpuOwWjyhgwULomCWmPz?=
 =?us-ascii?Q?xlbEPoAMazyXP8mhK8nuaggMhye3NjFF4T26Z9/kVercX1thGCDPpNdy/ppY?=
 =?us-ascii?Q?aXAAbZ6+4j3u0KoN28tNvo4J4E3Cv8IAEelkXLA+bfalbFbIG5ecO3DTEJXq?=
 =?us-ascii?Q?icbCbWW4Itu8uZcwIlS7hLt/uFNBHHahLuFQgvCmDF25rQeScKNcCkpFQFJ4?=
 =?us-ascii?Q?iL3s+n0W1xKf2RrzenRUawvd74wQb0vpqJOzuXDmUdBCJ6HBZxSxL0aZwf2u?=
 =?us-ascii?Q?ZbkOtduLdMk5iWw3Uh3j/0EYF2HI3y4RTnSJlhTbdKKYKHMxST6WuEL0yZcv?=
 =?us-ascii?Q?wWQzaS1nqzb8vATMoptJH37FZrZBKzeOO0nDr0YOg44XhtWdVItx5haAIQRx?=
 =?us-ascii?Q?w/Od12UqY0OtoMfsGvhnA1gdaIWwdfuqNobw+dXgkQuJ9TNdCqovzUSg35O6?=
 =?us-ascii?Q?JsLYWbN7HbvhwGI+wrbBIJTDQoXSc54yWow28IPQKEG1giFc+K6u0ginidRZ?=
 =?us-ascii?Q?hM3OsGHpc3g/dvDoqqjDJZNkNShMx2uvcHcALIhCun96YihxeeKsrTKEgZHY?=
 =?us-ascii?Q?MuoEppw7K+P+F5UffL2UCQas4VnV1QnObgyTfy2U3cKXn0beRatBTf63dzzp?=
 =?us-ascii?Q?3gIgwvaVC6NsjAVrOlRqUxGxA7r3DEEYdYpOpJ5/LDKjOs+m1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNePymXcbU+TeaDxfGHz35n9V7iv0QgvFHCfhHOkbFl6eQwix41zxt9ZjvcX?=
 =?us-ascii?Q?ZFB8o15nDHSB92SkAwGu4aYLYxrF303PF+nSngcJDHS0F4K5M4na/oCBSoZU?=
 =?us-ascii?Q?bzhsC44IXRsWDobmZGVNOLtwizhbhvnSP5dnkUQ+ub8jCAKLwZ2VvlSFieD+?=
 =?us-ascii?Q?n1EVzZQYVI6tToUhpwUykbGG0I53j9qnd4KQcIsxgZTpHaeGOwGzMu/E74CK?=
 =?us-ascii?Q?hqEf5v7R2wK4RoecHrrJ/7deKaxRpC/x6U8C3zJDMQex2mzgH0lamco1iahF?=
 =?us-ascii?Q?kOFwm2OuinuLd3f2c8XV3GsbLxMp2DFAvnH1LVla6BJiF1WrUM/9eLz42lLB?=
 =?us-ascii?Q?GWrRvXsAcZ/R9VY5isMEyWr4WE9xyk1l4MU1m2+vIh6f7cmcLnc0i27SIo+o?=
 =?us-ascii?Q?cJIyvUE8QU4USjtgJYqMGWkMwMVI9r5AHasmgzIZCKdw5t9imk7zG1oZW+Xv?=
 =?us-ascii?Q?OqiGIFt3WpWNZgIE7xa3znEVjHsVtDxsMuoCBPY2qU9L9xAjVFlXymk6J+A7?=
 =?us-ascii?Q?3FbftCzovVDiIjKqaRqLX8c6oiMWWurgiwXYPH1R8/I7dJzPYha0hzVLbBW5?=
 =?us-ascii?Q?b5Bpqfvhy33M/4MHdXw+PnhNWrte97WiC/H7ceaS1kMitLJTWe0NIIMXSsbY?=
 =?us-ascii?Q?CnTCPVrsM8dXgBWWdQkAhDqK2NDTeqpm+/8Kvaxv4UrdH4cNegoYjMoiizO3?=
 =?us-ascii?Q?+sd5lNL8oBVcLIZJdgZqd2bD/bSsfWDKCS4d5d6dbCLcyMbJwPYsygnZr1EA?=
 =?us-ascii?Q?zYAAJj+1eflHr5hrBY0zDAxtm8oqXkWqgY2Ks4CPhMFVdNkfHGOPhe/ycvev?=
 =?us-ascii?Q?WccP3FZnFUAgE8YZ38Kj2b6jfXs6e6XjeqDHYFYH/VFTIZXcCWPbuNnWfRok?=
 =?us-ascii?Q?ihbeADFjXovjhjL6CfropQ5C1Sclg5EPw7NlROwQoZAdqvVEIvCDLTTFIZBC?=
 =?us-ascii?Q?dSq4PAWVQOX8vKJuqrMNSryxzHQRWhzLnkyN/4LPrHJ1dijDWPMXzjDgVKVX?=
 =?us-ascii?Q?M2OA0dHv4w4oP6iaRkMGnm1FYOSimWaVkbN4WLMFCi/L1qKuXAzOjCGlS1mA?=
 =?us-ascii?Q?Key8BtmFvktMCyj8CV5QvpK+lPScXuL8y3Id7SqOK6DcfpWJ/w+Z8TyzZcpN?=
 =?us-ascii?Q?TmIOX6PwZOB5U23fJ4fdaEL7yU8LEw0C0BbeoPP2Mh5htvJ54eu8uKgyQ9mp?=
 =?us-ascii?Q?Dz2jrMgkyt6IXrR/FAKRdoq7+GYbYcyLFeSSJXrTCDbiTH33VE7KSGuMM7af?=
 =?us-ascii?Q?PrKcbm/BVBCl/dyMrq4YNE6MJ+nB9+xVF4WrxyCJ4OwWHSP4M/5w1oV0/Asb?=
 =?us-ascii?Q?dEtDPnEORDQS/I/2DvVgazyNtsCA35sLT5RDpZ/s78y3H9Id7rosaviSk0M+?=
 =?us-ascii?Q?b0qbwEf3sGgwMdDMHF+Rm6AJF2HVbtBKreOORUVwWKsTITBKzkcPJbJHAIyl?=
 =?us-ascii?Q?zVBv5aF3DQnqfI+/SE4cciH6c0aAiQIO+M4NzYK03WT4bvu95tgFE0kgPx0M?=
 =?us-ascii?Q?FQQNN5CBtxR7nwoF4PMRX+pNICev+qfmB2h4LFW2gluUj9aAz5WZg0VsB1MB?=
 =?us-ascii?Q?dhZmnIT4TV5/cObK9oNQYfIQ2PnJTJ8LIZHNSQdU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8812df23-7f7d-401c-0a92-08ddb26114b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:20:18.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KcQDcMft6Q0XEkfn4WolrH/hVkJVQY8a0b1B4U5M+APiJ7CM8YaPAvwz7v8VnUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> We can now simply check for PageAnon() and remove PageMappingFlags().
>
> ... and while at it, use the folio instead and operate on
> folio->mapping.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-flags.h | 5 -----
>  mm/page_alloc.c            | 7 +++----
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi


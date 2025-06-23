Return-Path: <linux-fsdevel+bounces-52621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F4FAE48A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845C417FDE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B181262FF5;
	Mon, 23 Jun 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RlDWW3sF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598328DEE3;
	Mon, 23 Jun 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692591; cv=fail; b=ix5qRKlad1OfFGzaHjJ3lziyJTUwKn4TU7Ehlq5Sy2GwgwK4C7n1AvIvjC846q1885QnnNzrAuUGI9rbu302rLEKMCp5GUjxUHj0ARpx/JfIftfiZ2kCatTUkWnrp8WeSbLI/lhD8Kef5OylgZXORJcqQlZU17czlxXiKM5Q+tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692591; c=relaxed/simple;
	bh=BP4YhttcudsyLEHZIMJMYtq73RasqewWdRf4K0DHxgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlB2sxeDLJrJi0KmyOs8sdr4/Vk2TaoWMnH60Eu+TNCBa6EeTXE+sH+aIH3YxkpZp4pxkOzRzcV62/L268d70LIHVnF/GZTvr5TK1wC0ukBo9FJBqSVENOSRIeOK7dsR3ywmHZWH6rpQw1V3OqM8PvCbIPaVlW3yVerlCGQ/b/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RlDWW3sF; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guhITH/EOl+xF/vDG1QkUAkZwpeH+2idLbVe4FR2YFnPaR1Yg/QFsCm91Fs66mSeqbTafHoTe6lQuCjFd52woj9hDbVg9wLl44KvbvGJE+KCkK7qYZWPpuIRknhNtm3iKeK2/Ofmo3txGV2ovnlhyCqkGQ3VQQ2K4d/TB7XPcPCBYfyzDjumSjhdpp8NSEls3JB1OxgSCwFI+MEruemZN39m14OrrP5mCGBI7Bx5IE4JTvvvGhjheTAiexS52fJSWIMZJb4FY93x1QQJc/RA6DInNwW1OjJB4VlAc0RkOAp8PEYnFaHPNgCTiYDG4QLNzi2hi/3hlzfeaqE4/R9g3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP4YhttcudsyLEHZIMJMYtq73RasqewWdRf4K0DHxgM=;
 b=nByqee/q8a8qMet+hoFsf3qAaKbhmbJe0TTQTXT1dzWi+95aFf20J/GYxc+zedYKNfg7ul18r5i3+YcDuKm7a9wWhMSb0E1Sbbjj/4U8FeQilT+LbrcjB0xW0VsCJn89PkZQAU3rFut93kTwKNKRqA3P62C7M+2nnMEOprncrZioqJfyNSU6NiYE2wjb4o/Arqpl2Y19lJqSYbHlhDuRNDC1lBNLAFV+dWpkcqCcwv4dHE4KPKeQRTv3viC9QwN/RP5zpxiHwZ4gnsJ5eNGslV9xDRipKa+kL+jx1DIo5uVItDKrlZEflHLYKPLRFCPqmlWOyeotGqx4orwYuh3HlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP4YhttcudsyLEHZIMJMYtq73RasqewWdRf4K0DHxgM=;
 b=RlDWW3sF0qVek75MrMya7sOJBSpVO22NSDudFZyhPf+dW2oGPQ8X1QtzU1q+brRkG4sB30TLm+CFPxYKKDzbjT9VvYB3yIDRiVVA8vdGP9SN17VXE/+dLKb6JXHXfmlCvONLPFVjekWmUzdTpafRItxTOArzzlmU8eAu3ltTugZ2weoOVvGRZV3HS5GWUpwFrBuXK+wBe4D34EoAskKp9WrGzw/dR1JHO8WpkjW03xlYaE0AxucKPF45nvjlQlkvkEuzsg6iUPyHsQGXlxUic7/CfEMxJCMA+NZpVZHZFMM0eVMInGAFIac5TzrWzc7x6EuaUlbrGUMZoyewoWwAdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 23 Jun
 2025 15:29:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 15:29:44 +0000
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
Subject: Re: [PATCH RFC 05/29] mm/balloon_compaction: make PageOffline sticky
Date: Mon, 23 Jun 2025 11:29:40 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <AEF7E290-7B51-4325-8744-7CD3559FE8A9@nvidia.com>
In-Reply-To: <b0e47950-9fcb-4fb8-8bf4-c4a3c69387af@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-6-david@redhat.com>
 <D114CF56-016B-4140-97A0-42163727EB6C@nvidia.com>
 <b0e47950-9fcb-4fb8-8bf4-c4a3c69387af@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af71732-ea05-45d6-a6e0-08ddb26ac7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xFfsIvX9tfnEmmz4ccVP34+lkFqEt6E2pAigSYkqIHnFYKyFfTr+WGMdc8jx?=
 =?us-ascii?Q?JGJ33jCL5Ae2IGwMddO/Yl6DA/jZf9yDsxNx+Zcxl8rEl/o07LtaNsofwaaZ?=
 =?us-ascii?Q?QasiCNJ/4qqSGiefv1EG0l9Oc2HBOphlDyc/mlFdF4V76POdK2gvtUBvvyJb?=
 =?us-ascii?Q?bkZMnOBIKgysrz8chQ/EiEWHrV1SRV6XQuA2WryQSk+wG25ivWkyJVtMNqeY?=
 =?us-ascii?Q?+Y9RPvXg8zNl2W/R8kWk1f01506rog371UR87K5XGXgdmuvmEMwi/VLVgdxg?=
 =?us-ascii?Q?M+yjjWQd+VKG11jhLACS0yhCJNVoxGoWFUrlsbLW/qXy5gJVyJGuk3prMb1j?=
 =?us-ascii?Q?PgVbB/00cZloZwJ6+7IeViqy+zJ7pfCSB+Muf1cUWm8R9xMFJr3Shl/VWsc2?=
 =?us-ascii?Q?8sDTMhyB8K/ljNmTjzOdb5B/4hx8rHqwmhSIKR/BJn1DI+ehTmjm0ySk+nGm?=
 =?us-ascii?Q?4vGEnNuw/zl2tbbMy0cr2hm4P35fDDbUmCL7QGJABT1El+hhQuyEkaJsVkNP?=
 =?us-ascii?Q?antDJf9y1k9OxRnAXH4YJ4LCiI8EgalPGGQHM812TllnBgL3JwABMHARM0YZ?=
 =?us-ascii?Q?rpN9JNyZld1Hf/T7vW7ehAXErroMTQg6r7CcCfWY77hrKpb7XhJ4lMHkm04q?=
 =?us-ascii?Q?1A4pYCLW2Lw0hCVSj5zqRk03mfAaeFT8Ouyt32B4qOywg3Af88/uMKBaBlnZ?=
 =?us-ascii?Q?RV6HpFFnNTLVsri3OMYpmrq2uQhtGkgsBqAHPMZVgdwEGoVscfPBNwz0Qs6U?=
 =?us-ascii?Q?abeXrKvmm1Q00GVj05/h5LY1bXuw9iRQWERGI5DkIX0dvu4dJyasKojQuRub?=
 =?us-ascii?Q?Yu+u5Dlkj6VrPomej6UBck+ipPzo7yV6Vae5xXz9mWtLnqhoUnAhyUdMntlQ?=
 =?us-ascii?Q?OgcTdIt+07BoNbovbaxyjfc2MyOjbOaMl5YQQkawPmEVyDXDBzRuBb4Ijc0v?=
 =?us-ascii?Q?Gx20zPZWve9LQH4NRyVdFrOrvLS3OjV3AMhRahOSUkgJuzX2aXmCpvuENba6?=
 =?us-ascii?Q?A4XV7b7n4DJBqe8wKjg5HJ3xi/gjejpiKGJScZV14eq3VbhvPgKXFPQhsQae?=
 =?us-ascii?Q?okxYE6jryX4wEXB+H21SxYEcc/V8pr33XdVpDSTfM5W2qbnErp6kT05/wezv?=
 =?us-ascii?Q?1zG4dv41soDAqvvS3GGr4zO/+Dpk2xyh49xRzIJB/YlJbtKE84KQswKt7NNz?=
 =?us-ascii?Q?2VtQLR3Z0njl8e1gm8M6whxAy9PnOG0iDKSMlzyAljLCi7A3pi8DhpPJOCuk?=
 =?us-ascii?Q?0jO8uAX2R/4MsIiQ9V+kPaCZyK3E/tD3a9zXPrqNH+oh2tkwmiA8pQOq31/2?=
 =?us-ascii?Q?ZMiNw7Y1Z0abHYPVL/vRU9ucatSwfH0leWw/+Z0+vMZTR48w249zP1K2+duz?=
 =?us-ascii?Q?sI3EkqS1JjLvV/hGZBcAIi3hY0xXcI0cnTdu3dxAByUvUak+pHZnDTMHXgzo?=
 =?us-ascii?Q?5BWsUZ8Qkfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ge5PjFHQcTR83hXoip0a09gDSXKwdKpDkqQytw09ldeFeOHNydRgGNR1EBKf?=
 =?us-ascii?Q?JifVPmrw4+Vj2hSAvmm4KWonM/f7UDwvopbAF/Nk0J1EcBouMkysoMChkpqi?=
 =?us-ascii?Q?5LHBD8SVFJyNjBOymUDUKjg8X2U6gjVpwzUEsoD83XMAM2JC9cc9/2pDm9Bb?=
 =?us-ascii?Q?Jyyd6HwwPbGGVuvBojQ9EYrmTGRPQRZoyGWoW1HDe4wZ/oz04aNcOj8Oav1F?=
 =?us-ascii?Q?TQua/usDHe+zBCbSXBiCFEzUemPjFgTUmcg1lxHDAjxiUAnfi37rY4YAlVum?=
 =?us-ascii?Q?v4prYo6O7jaX4AV3isIWCHOZwQnx3JFvbSbjzshRt907BbYOacvzTTUyfKWC?=
 =?us-ascii?Q?NWF+W6X25dsRVCd6Ei7uM8oQkibAKaiHZhPZCFmvftGjli9tJqFdfxGSnzCU?=
 =?us-ascii?Q?7QXlcPq2Yln1DTtT6076uei1EQRKiplUQtXY46j0omqvKLJhUtIP7Pdfk31K?=
 =?us-ascii?Q?r6o8rww6hFg5AycvZX8mpfFFp8eRaGZ+JRTyjeUOOZBeDNjDu6CkJdDi9TZb?=
 =?us-ascii?Q?76+mZWahkOn7YjkLmIP5WDMpur5l1a3+P9f9ybAS1/+pWM5orUoF696t9uXG?=
 =?us-ascii?Q?mg52aFRk1kW5xTBrNx/TodYuLXrabOhGjy2bAenQqjoTb12BjpP+ZEG3Og6E?=
 =?us-ascii?Q?fdASFVne2HHjnHahJrQycVN4+Gx//ZA9PTn/uKcQvmnh242TxGCMYmmU2smX?=
 =?us-ascii?Q?A8VIhOy9sBPxt3FGd09ZiJspIgG8BQpQyqZPribPjvheBcW2lo1zOuEMa4pz?=
 =?us-ascii?Q?QbRfL4E/DagwEb0bNtYXZCTSIhIiXovT23dxvX2YTQQt1h9jlfGfMEh0sdjk?=
 =?us-ascii?Q?UvEA7dWeaG9w+Oxsszq/xdsRxWqavwJApHHIZIdInucOfmls9VBlPMhbtgp5?=
 =?us-ascii?Q?iyOZ1Bu9SVF7zyKfWiQAB8ARDdEa+xwbQusneg3tTgHCCqeX56EjOFKQ8PY1?=
 =?us-ascii?Q?MeU2KCC7Xjpjlon5LznaPJQkbaV9vN4yd6wyCERgDIbpKdySEHkMJF1ol9Xi?=
 =?us-ascii?Q?fi/Ev2BnyqTj8+vcZOHzMAY8e+nkJrBgmXB4DjEkussQfrz6RCigUZoG6VHV?=
 =?us-ascii?Q?F8tboGHsfYKMDDdKDOhaVmo7LRRjmK0PsKMidhmvocQcimUugC0CUVHnbjsy?=
 =?us-ascii?Q?MOi4P4dUD0Udv6YGdstBLbcE6rMawfS6S9UZr1+e2WYO9vauBn99gtaiTrDC?=
 =?us-ascii?Q?5MGOy3cK36iDfG7hAVPZEZE+ka+QJ4NScHn+anO4FiV7JYjyjtRNCwWj/Ll6?=
 =?us-ascii?Q?dUMHYNOJ74I+ommKt3igp/Ul/wwbWxm5fvWeTfn80d0Wkv2tKaqZTTCDy/bp?=
 =?us-ascii?Q?+nzmEH3oLitBDtlDcvsvO9tMgnXsOGyEtdNJ6Up3UBDtp107Y5lw5ZkAPitL?=
 =?us-ascii?Q?yKKCFfpPsWWJ9T1r2tD+094g1NyRLQDICQaeBIYm4XAuHeVhzK8s5lTzKE0d?=
 =?us-ascii?Q?PDCyM5PSI2IpQ7X4ZG99xPRefkMZJodhgz4yyPh1KNJ865katht0yJbS60Up?=
 =?us-ascii?Q?gjcRJ8WYNemJx9joZJHmEMBkTfuT7/0sdUqAjWFq//sBtHDWc4XWb72aKNIB?=
 =?us-ascii?Q?d6JEHuYRfp36hRtDSRBnNEPGKVKpc/vkQFRDwZxt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af71732-ea05-45d6-a6e0-08ddb26ac7b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:29:44.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YFT1Ccq3/Jvf3ZQuSESPIL9b+giMfTfFgTF9X2n/t46bX6CRsvDUK0ZxlhMYxeD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

On 23 Jun 2025, at 11:28, David Hildenbrand wrote:

> On 18.06.25 20:50, Zi Yan wrote:
>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>
>>> Let the buddy handle clearing the type.
>>
>> The below might be more precise? Since page type is cleared
>> before the page reaches buddy code.
>>
>> Let the free page routine handle clearing the type.
>
> "Let the page freeing code handle clearing the page type."
>
> ?
>

Sounds good to me. :)

--
Best Regards,
Yan, Zi


Return-Path: <linux-fsdevel+bounces-52363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C3CAE23A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 22:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600CA4A5C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675F2E612B;
	Fri, 20 Jun 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uaaz9CV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC61D6DB4;
	Fri, 20 Jun 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451907; cv=fail; b=bmm300SrnqgIrjGXkbzkDiNlOo2Q4Y7T4m20m2KqPBsRI+5/gY4lx67gNDTPUAnqGx1hYCZ5Igr1Gu1R+RsMZGhAqCWwaQ9VOYgTlPd+xB8TmUR+a7tL4/7UwHr1LEQ4CBNdLYOM9F2FG3NP/RRv2PDvWzCuUbMtnvRNJxBvfTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451907; c=relaxed/simple;
	bh=GEUKyLihBkXJ1HRctLIOM0TJVv0YLFHllQk4et4ecjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gPzU0JLNLoz3TKSDXVXqTy5XWcizOcJjiId7qri2vXKzPllDJki0H8jpkJS0Kf4+xKc/A64tCZP8NVjyb3NOsq3BSQMV2heg+/xE1oaoX/0DNfG8ZvzkQloGX8Scs83WAwIGe81Cb7fDt26zyFscVMgTikD/MaCZEAYxZwiVi4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uaaz9CV/; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPXy7iEIwV7kiYr120rAMw/xbC7zACjz8l5JfzOkhjR6F16KevBUAlKphIfOpn3E0xxXL5Vj/LgM3j3EMNgPT5j9TzhLNPuNTk6JUA1Y/wlpf5JMlQTwpWJldxIYaYYLdu235tVjGBe2YNtan13FBD3rnd+nDcltMkC3Qoi9E73rKir4aIvYo2e/DZmgIuei+SeNcTIT98xJyOE/K+NbKpuuJx5j6CBm+Cujyezm+M/lblWbJfKVllHrXqr222Mbl0IoXtde0AU21sbC2sNRZDJveQw9RWK6PH/367RzBP9vqniQFeGAUuKHOU/WOQjAbmRn6vVyUKDRoQYJuk/SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8pvIr0tPRk2ci2+dRcLAlA0lniZfTDHSodUmHpD23s=;
 b=s8TtVMkUnZ/v4aXO7GU28fBza3cJD4t7ZCt8SS81JlHYFozd0COGD9A65iU8fUisIS0IFvqWqXmzklywCgiQz/Q1Llc3QDntbwUvzHns6erFB5ZSKty6ImxCDI27Vyvf9QN/defg3QIzlmmMXxnowLpQsjfFQYhH3OrCOU9xOUf/KsiGbbD53vgjP79wWLQ0mVVHL8NJJYkRaS3Hpas3eL8jMfaYxWjdISJ2in0DRAs/m5w3jnB4yXkEy83FNiSYP/I6n5JcYI8YXIBC+tMXzCBLfOtMY5GXEQF/xDsXm1DZD3qaLcopv1xxbMFfOTawlT6SIn9KnmAi2wsbZOLHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8pvIr0tPRk2ci2+dRcLAlA0lniZfTDHSodUmHpD23s=;
 b=uaaz9CV/7tw512anicgZBmOV2WUfTqHI9+sBWZgbLPmHHK7K/bz+/FeHgKhSLu/FEfBFVa+6d1s2zMxP97Ga4Xjlw0Kc6637714EPqW96fsjtyyK2xNb2HpqYVdqntv4feW55u6f8Bn0Bwjz3hNqh+VLo91Vf2nNvC1Fa+OJaRng45Nw6aN/3NUQ0nZaqkypSQvZpeJMibxGv1RnQ1T3Zazhf2Z6WyrXqB+gvv3VL9jeieGfb8Y99h8jjzOG/1lXZn7UeycN2k5a23g38B1g3o+qMsAIUBvb5Ua/IT/6pYFinTQ/wsapNe1FliwWIIxbFyCaTR7aQF2mlcsbsrQFUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.23; Fri, 20 Jun 2025 20:38:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Fri, 20 Jun 2025
 20:38:19 +0000
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
Subject: Re: [PATCH RFC 17/29] mm/page_isolation: drop __folio_test_movable()
 check for large folios
Date: Fri, 20 Jun 2025 16:38:15 -0400
X-Mailer: MailMate (2.0r6263)
Message-ID: <09715CFD-164F-453D-97FD-FF83FE71B2F4@nvidia.com>
In-Reply-To: <20250618174014.1168640-18-david@redhat.com>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-18-david@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:208:234::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbd9dae-3553-4592-825a-08ddb03a6433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvV97kjwsWRLukG1z9W/FrdgpnCJpuznlU0lEummxcHyJzH4CXB+NpU7mPeV?=
 =?us-ascii?Q?mykIkRzjh1EaiRxkgRfYgKA+yZRnYwYZbFwuNRCzsslDpko0OZvO8yQfpk8G?=
 =?us-ascii?Q?3Gwgp/K5r9KQo67/6VnEVbbsZpNVa6RozJsA5sO6adm+sfsu0TR/LPjcAvhK?=
 =?us-ascii?Q?4GHRSeHNEqa10zjQ3VD6BPda/v83RwGTtf8SQBOPBnFVAgrssmGznYGDsFRV?=
 =?us-ascii?Q?iscpmWdMtMUUdSqKz5RXtzd0jjJkwEUgQsDmvEw6MX6yPftXcI4FnzpPRJqC?=
 =?us-ascii?Q?5ly2YNwru+gZnEohmWapuXT4GJmw+PG41xgOI5F/heAMGe4UGP+keenlClNI?=
 =?us-ascii?Q?pORBlTimDPHIxH3IlOEwkQ4wPmfqrpcCYlWb10UOZ9Qocc67eo9o4GW9jSpE?=
 =?us-ascii?Q?nbTZ71NB2Heo/+ifGNF7Mm9+Vwb8UCmF4EPnlXl/NAMrT0mC7StVJoQVPNmU?=
 =?us-ascii?Q?h1n86XmTjGp+mEifgUds5oHia2J3gzvcgtkgeSQw5mUZF/9NBidpj50xJgiY?=
 =?us-ascii?Q?kGXaRuGuMdiD6soWYePcEUab+0iMq6ALta7tJ0w4d6fuRuY8FX2ydWGFlXoI?=
 =?us-ascii?Q?N/aeLBWLW03DHaO09CUCbJBRdxZ6G8ZSM43hATkldHRDeCMZwQmI6PaaB2h6?=
 =?us-ascii?Q?E4LWw4xC0xFQYllVE2X+QsSaUVpW5GlMC4eZNOTQtvXChnayh3ApAuvtRxwI?=
 =?us-ascii?Q?tP2Mx6J5f1oXruWcvGtlgACsfNj6YL1S6/wJnTJyW1GXayelIBy1ckinyVVT?=
 =?us-ascii?Q?ougr5K/n85Vjw36XMhZ43v2XLMWMrd+L1I9QZY1cCwi9wTVThIyGxnir7F4f?=
 =?us-ascii?Q?E4r/WLB0mWLjL0Ne94eisFMppQAp3j4/qjUdoqH+R8gMw84W9IQ8dERsYvvy?=
 =?us-ascii?Q?AduilKza2E6gxv1P01O3pI1/1I5Pd0juxoifIlVQUJ8zxz0B8xNZPy6CzBiL?=
 =?us-ascii?Q?MCrWXgstxDhbGidlRxaEU9wEpe5JdgCbPaGcarLgWeLFZPj+VzqjWrv/8nIM?=
 =?us-ascii?Q?81C308ZNVN2g7dp/ChUKr5/qHfT17djX7lxv4sX0FUkWPH/zX2cRYXW9Tzvt?=
 =?us-ascii?Q?29xwxBxNxgYIh2fLRZRjqK2EB/OEaMeGmU/n+4G+7uPNe/eFSbFCF9U5O832?=
 =?us-ascii?Q?wVyRqBG8oB2Po7NBjNOUc+8VeyicwfUkt2Dk5LZrjtcHdUmbglblWFw5uR3b?=
 =?us-ascii?Q?B17/moln4ju3KKY8WM2XFB43S3KT0gpZSficRndBYB8O6FJVCAOtwN5luLIJ?=
 =?us-ascii?Q?L3YiLw7hAm5N3oq4jCfM2xAegSy8HAIylGwmynnIPcU8qWJlpgJOsFxkvQjo?=
 =?us-ascii?Q?BZFp3jboZ4to+VvrXuwRPSemEEHo2NdV+v4zkUOSbpj8qr8lqTV6v4ikYzNx?=
 =?us-ascii?Q?rSCu0HHyZDNhjCPkv05e/1Xo+87XjicvK8g2aPfy3I71rFNigV7fP/Lj4p3j?=
 =?us-ascii?Q?aLk5rYmQjZM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5+TS4LeISbI0K3W1MVMRAgqv0J3ujdYQWWsXxK/72U6OAjc3ccGHvXRahII8?=
 =?us-ascii?Q?h68mJABKUz1uc6JbKJZW9sUqAgl3xqDQM8N4tXpZFXyqLOG4n0HgsQwQoHTa?=
 =?us-ascii?Q?tHROWRuhYEEMfyEA6m0C6MLfmoMYaf5MSVQryDsJpubV6+SWC0oMeElNi3kj?=
 =?us-ascii?Q?bXaUF/iQHizwerNAmMQ2t1HXo2EWRj7tcR6OkIfzNUinHZtjonjNv3UpVka0?=
 =?us-ascii?Q?mnj6LHglWGALQCTFLKi+p4aL9GHwWTg6uvSMcShzVBHWf8rJ2y3NaiLifr99?=
 =?us-ascii?Q?X3QDeprFJlX7VQfMlGeApW0qp6VzLOntgPs3YsoHZSfF3QFAaTN0EjknONXO?=
 =?us-ascii?Q?BsZgUOhpjzm4zXa5kPGJEHCzW/qZymJpstqWxczkdFIyJIMvtd0k8QBnlu7M?=
 =?us-ascii?Q?jvDO1Ak0V3BwaYHxXFHqaQyXXmpCT9GX5B6htsLcAh9PP73HvX2InttD39/w?=
 =?us-ascii?Q?xUTy03qzmGy3yK4qeo/QjzQR8uJWIdj9Pg+ANqGfAyTSR/Bvl3cjACzeVHq/?=
 =?us-ascii?Q?qvQzo/3rjjY6Q7JJ3UqAPec0o1QnEu8KovdWWB8rkI0kkPcZkwMt7fwHQQNT?=
 =?us-ascii?Q?KW9Fsl5De7EyTcFCDIyxv8PXyPuOkC7zMHhDckGrZXaJO4J+6yf+EuMDLIkE?=
 =?us-ascii?Q?nEYBZ/oiGTRQWGI1zPrkLaHi/bnhDtxcfcPrSe7hRS2artRkxz5/18jRIgDt?=
 =?us-ascii?Q?omjPrSajQ8WgwVVmSjKoCiE/5NxqbNq8pWDrw5SRzLmRYHr05Pce9FNliuJz?=
 =?us-ascii?Q?dWZb6k+K2uiIZ3EZthMjZUjGUlGf8tG2AJYQ36cFfPM7gWCm2ZtVp6guJqDg?=
 =?us-ascii?Q?bH3wmXYoh3X5mFKTCx6P9eOP9qBP8VQL1FE4dgPf8FQCqLgT1LRTOxsJQwx4?=
 =?us-ascii?Q?0REvPLumWLuGeXqtrcYqHKC8rq+JRa2qYz2qj8qHDgnvbtluNtvqXh0Udb2V?=
 =?us-ascii?Q?X40tZSsabc1E1/3nakVOVuqLSBOl68dzdwlnG9xUHD3VwtsxG2xWAbLwFuuT?=
 =?us-ascii?Q?FIWw1wVhsNhlGSfnvonhQToDDEkPXStMoQlvT88/G7Mu+xPPDUGUfM4Bozhp?=
 =?us-ascii?Q?PGeCl7bIaFsPhYn5ou1kddvaOaoZMME9g3o+rko1J0qX4bUJsgNvL41sMxDM?=
 =?us-ascii?Q?HACL4VDyQWufRDTQDQh3oc9bRW27m1ZNQDETZj0aoatQ40Te02rmxfM7fWfL?=
 =?us-ascii?Q?yQwlTYyMEkpw9ewvtAK9IfvSlyYvn5q/olaHgNSujn1IBMN53pPTCt2LU50q?=
 =?us-ascii?Q?F6JyMgzviDbd4bJHlGBOdH54w2BfxHef2mNWb18hMznJMI5Eds1FrpV4pcO3?=
 =?us-ascii?Q?EOhk6lo2UIKKueMZjzZD/XmbhUF4ypvM3mFnwHwkwAM/bOvZpBKPiw0saNbB?=
 =?us-ascii?Q?s97PM7hGawSS0ChIBVdWS+aPzSpUAAKSLYvGWKuqbkYJJ0aCgLbq3zIpMadO?=
 =?us-ascii?Q?UEuCnugEWFvVCWPd95JTRL6l4MzdhvrlB4ScSxkeLIpnrVq+mxi2TXb6v8N4?=
 =?us-ascii?Q?WiSbuHdBZ6Tjb1AxQl/IxnRRyUSjSpJG3pQmSfsaShzGXMSEBA2JbKIwY4YK?=
 =?us-ascii?Q?+I7DKePJuqd5NeJeKkUNtFFNsXea68EgahAcQ/aF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbd9dae-3553-4592-825a-08ddb03a6433
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 20:38:19.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdM+ExTK6tJ61vzIP9PdyNc1nFxceb2BkTd8hkqgBJh5l74Q7hC6gzYMh065EeCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

On 18 Jun 2025, at 13:40, David Hildenbrand wrote:

> Currently, we only support migration of individual non-folio pages, so
> we can not run into that.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi


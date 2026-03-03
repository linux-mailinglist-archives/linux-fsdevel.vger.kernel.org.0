Return-Path: <linux-fsdevel+bounces-79268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHTeIUMRp2k0cwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:50:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DE1F41EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A5431AA063
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDE386579;
	Tue,  3 Mar 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tqrGBlHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F69370D7C;
	Tue,  3 Mar 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556274; cv=fail; b=bnnB3eJgfI4uQs8hJcUQy9sO0f2gTVKKnnd5/QaSO3l0/unxA1CxBj86J00jHMxy+ADh5nT42G3bN+GUWGjfqDeCB5JQGhh1wTi59dQWE541o/l9Pp23EFW7tFZDENqOWdU0E7u/zcVyBleEpG3af1BARYwMUdTcrN70ZiGbVSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556274; c=relaxed/simple;
	bh=bSh8F0eUsxsfWf84T945laSFxnWdUmqynB+YmxN/JBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oNlLwQzCT6esHg7pQHYqKRsqtWuWh9TZuDUwYUMQP1HpZnBCTfEOkrXQ9YwsgTR8fV+vRBPqUy7c4w9fG+HlgHMN4KU1xjtR8a6MXwryjhv3kNefohdjwgvaO+jPO0Ua2K7GYJYAVWOSspSSnYLMKo5VFuUvAuQNbqIKI74wLLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tqrGBlHK; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhAH7zlYxc8r6vasL7p1ZRPMHZ5M2d58cORoFOeq/nqhQ4mOP/pJqTnZnY9EIeG+VXVdzN0IFRHvlW9jXT4wcXFAdNxHeSZ5IBT7FOysNiIbGiPaUSCFyFYPIPsY8uBjvjmbBfldS+WIneDdKWukruMLPapLGxoaOVusHFYsDlFittGqmdall/VCUjTSUf51d0gv83bsD2il0wSQt5YSnzoP2/FekHWVAngJgZD/sfL8iZcH3/7U62Jjfk1navHayneeLDAQaeydsuDj+lyZ6F+DJOeqGYmg0BC9SRC1y3GovF+jZk0O1i7BpKgx6ZUixzjbG+Z6KmPQEnoqSgxJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gZC4fbeP4Lg6hUeemeQZ2jGIex2AvBcS/KvUKJKfRg=;
 b=ozs/Gm9TTWQ3Fe6TNiXhCmYShH9PInfeAoBKwnfOaAn2ehfDWWiVAK2HT+AQzLsuaqkc1T7EkyVeIw8XcwF5xdCtJwOTIqwSTKxFkgF7sKqoI6PfOmocxsgRDAXhP5g9hB3vpkAB8ahwyYwZ1s7bF/ZG7dy0YK1P4Rf+jKSf9DKc7ZKl52g3P4sa5vwLnL86LDqzCc2nix2iCR9/A1ehVoPY7BHsObZaMdV2owm8x9B20kRyhmL8iXNOVCFQR1maGI3pRv+MA6rMp9M8vCqDRFRyOqnmPMhG8y8nGT9FTfd70sBbhxqpEj8R1P3htE9qns8ENXORnLHuUjCObAxgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gZC4fbeP4Lg6hUeemeQZ2jGIex2AvBcS/KvUKJKfRg=;
 b=tqrGBlHKbsD3uweg0k5Erj/6+vdv2WcEPIGi7AiYjh1me4EoqBkCcANOy5wZ9/X9BOl4tnw2QqYR9sWRyowTNDQ5rRRpOG9dPJlTyax4cx0Rfv8RGKSmbS1dD5dL8R/rFEjeQcDJJ6wcXplbPAYThdqfRyQxULvDZDx8LZyOKrLrKRar0MTJITWOVsYBa6TLxmyYYq78MxIZWGCi1BDcC9zakTdv5uZtVFo9BoS3RRRT7NwRwFBgZ5mbXD+ZLpQsAIKohivz6mMUpovP4lgln6fPx0ixHdJ3XtiTvMGOCggTjRdrB8Lf59r3wxbv1PfTLZqKFjf4ppUVwAOS0dEMdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:44:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 16:44:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Michal Hocko <mhocko@suse.com>, Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, kernel@pankajraghav.com,
 tytso@mit.edu
Subject: Re: [RFC v2 0/3] Decoupling large folios dependency on THP
Date: Tue, 03 Mar 2026 11:44:21 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <18EA5A93-5D49-483C-A90D-D023F9116F37@nvidia.com>
In-Reply-To: <6e86c417-c410-4deb-9b47-08e3d5d9be71@samsung.com>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <CGME20260227053155eucas1p2b4b92cca44cefd084ae528fea27419d3@eucas1p2.samsung.com>
 <aaEsOu0hgCUznzl3@casper.infradead.org>
 <6e86c417-c410-4deb-9b47-08e3d5d9be71@samsung.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3187d1-0dd7-47da-531f-08de79442321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	SLdvqmUw6TfAkS5K8VLIEcJ28h/oJrty0TloxELmaIGoDvw8HJ5QTmHHLP4yKdxTddSYy0nIMFXAIU1bTkxfeN+qk+HBzR0+QwYEadsF7yh9JCiWEvQ9VO1AjcMPfGts0LHu/rRsVb+W4RAaQ/2nBOPsnC8tbGzUfPbU0lFW+fJEh0V8251UNJ4B/WB6b/Mze/G9DHeS/budY9EVl0QmiBf6thbHZxQ2YLwn2x8WDDtkN7CSQt7jhrwD9wB7Ng1ObvKcaCN1dcUXC71LrjuVFu82iTpTfF3vzVGo2GEpjlIzjvNeQNJ5oppB2XeERD2Vp05K5VMhfwPY05aNyrSIvMP4BnejLs+l1+AN+BusKAxtKM0JU8/OJfdxu2LWxGwhhs3MPsQJFExPqziCBxNOfudxOIo9QMmoJeVMKfG0K9hnPIT6VawClzkKErUxg87cqQxUPD4xN/nEK4j/asVQEV7PL2HeJhqBkjfW8A36AQ5VAgETxsWKI5fY1Y/9tLgkVUggePvsKubo4aD1LJiIKigI2i/B6JTJVGKEZT1gK5mi4mBkxMJiaalSO65RhqQZMWPyYaXgESmHkhIS5/WGy74pD84jX+1a0O+v0LvvwJnMqW6gFmEKSD8TfLqW8gUwEzcjreokRYzOcaQSclQpeRJYjF2Pg0S97m1nNCdEahmNhwUps7a/dBbMaMdTecJYeM9pIUPXdY/9kU3G/cNSiTwO3sEhac+md3GIz4bFz+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ygypR9wu7qRVGA2k9LDxqCmdiXd+KYW9M/hvW/j+jQL6DkzSbvpEWOB7bfBn?=
 =?us-ascii?Q?dn5fpXI+gSpO+q1kTt4GG7fybSRjwR+NUqcSGWu7e1jqMvdFeJA/eWqV6zBK?=
 =?us-ascii?Q?8bPHQfLVv/u1A6WjjAUMwL4dOuSwxdOQj+l+CzLeRP19nfh2ihRLgytnD9UQ?=
 =?us-ascii?Q?jW+BS2+WKImQsrhLe1zx/EyOTBGOvwcjvP7g8GPNvcBKqLPZ7Y6JtF7citko?=
 =?us-ascii?Q?XF1+m784hQZws9HKp8iHmFtwugci+03QVMO6qLvSVMjFoTVOnPKjHQ7+k+v4?=
 =?us-ascii?Q?wscbksOB//Hzt0T+Sj5iewAegH9Z8EV/c2DjYgtPWCEWE1rZJfug801Xh+F7?=
 =?us-ascii?Q?l7H8eWTEeLAFiiEMk/y+9Jb2gBizsRO5KcrpMOAnf67t0fgR62QSyL8282wT?=
 =?us-ascii?Q?EpzUkwmBnSIRMp0z5p7X9VqNouUSj1JANSJFO02p+8laE/9gcg4TH5si7aHR?=
 =?us-ascii?Q?MweRQd5shHNjiLIYvzGxC3+iGo5THn2EiruQQHXjGK8SmtvfcDoHjCDPQOb9?=
 =?us-ascii?Q?xZyNqUF8zuKauOv4lH+/LxawkeyUsOI36UDrD9XY+TPyyd8nG60+pU6bQC1R?=
 =?us-ascii?Q?t2fkOJjv5LbjWCVdK8TjdM06tNAv3h/1UbFVODc3/Kp3doqF6FJcize/WWaK?=
 =?us-ascii?Q?gS3XWxenPWxxmuuRo2fqFommDn+BEnOdJ6CWWaeSCfCBKnRusBbGpEDo2Vln?=
 =?us-ascii?Q?DaRfs2Xye8pW1q+yb9mDvbr2h4hWsXZO0DIsdyGWXrIzUixxIa0i6ZtyzMN0?=
 =?us-ascii?Q?476Gtsdnx+20WUk1FoW08eToTlRQn6swfVQ+1YhXPEmkEG2lufh1cH7X7UGb?=
 =?us-ascii?Q?hR9Tl+7ut4+OeCScnHm+8c8MIU7if0pm5Wd1Fhl696MyO47/qYxvJVYgGWio?=
 =?us-ascii?Q?vh2862VVDWmrQAL9IF979/7wssNterf2m1eLgL3taV0hhvOpTa7GLoR3Sfrv?=
 =?us-ascii?Q?oMy4XUnbtMec7AEZOCRcgCNN4Ub4Y05idWU8KJbvdXBBLmEudcWbZ7AaNMQQ?=
 =?us-ascii?Q?rpG+BzJ4KSxL48yv3j9aPDqu81n4bsKeUJaGlz+qoGQJxzvqr8gHToaCdioZ?=
 =?us-ascii?Q?TpbYzr08Vkl9aGdZiPGRRNss114xEvN+bV/bZl0e2325NISxBmx3iBe+tPyC?=
 =?us-ascii?Q?cXDfOFanHAIHiCDI1Zz+8ign/b35+w9JbQycLfGiKHaQXLspRb4vQ6loh/1Y?=
 =?us-ascii?Q?H/sh1bVFlRrdTRwU/re6/Q+EYUVU/NDyWhpe4TZbzqsALXMfNhAfpjFpP5S0?=
 =?us-ascii?Q?bEWtehFIjso8rr9xttWe5MtL2lgdRZoSClWA1eGhUuflxHm6z7hMCgXxc+Rb?=
 =?us-ascii?Q?8kT54bp8iT+7bsGmUjB8rWZJfyufQgAUs7I9wcwpzRP6edJjqXTqKD2idhok?=
 =?us-ascii?Q?p6703L6DO9LVqM14B9T5oP7myo+Z9Klr6+D24VI9dqIzO8v3Jh7fD87/WnA3?=
 =?us-ascii?Q?qVDq61Re84anku+pONjCFDFswQoeD3uwyfHLovzXZg/bkLZq+PbLkaq9lZnu?=
 =?us-ascii?Q?ZxIdI1nXjKDJwWufgN3QQoosncO+vUWQb7tRQylmroWyYRzRRu4cw2hk1Q0a?=
 =?us-ascii?Q?YAIUpnA8QDYIZgTXkx/Z2FwYUJOndWle6X3PwCizq8rrxh1vzAUFzzrGEqKr?=
 =?us-ascii?Q?0hsjjAk+YPjxq6IYarxH4zx9Po5iDOWOi/TiHOSz5Tb96kjXmO6ZMdFMez+O?=
 =?us-ascii?Q?vBX6eANuCuPloOVXHo0n4uHc2dBWb7Vm8PLyxY+YlnvPTVQO9dHbdsSix1Ch?=
 =?us-ascii?Q?Y/CZnirXZw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3187d1-0dd7-47da-531f-08de79442321
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:44:28.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpTCfZzAgnR+bDynLUXiSsCwtUs0DdhLRHb+mwOWrv6xmq8JwnDDnr3l6HG8ZI7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
X-Rspamd-Queue-Id: 087DE1F41EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79268-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Action: no action

On 3 Mar 2026, at 9:17, Pankaj Raghav wrote:

> On 2/27/2026 6:31 AM, Matthew Wilcox wrote:
>> On Sat, Dec 06, 2025 at 04:08:55AM +0100, Pankaj Raghav wrote:
>>> There are multiple solutions to solve this problem and this is one of=

>>> them with minimal changes. I plan on discussing possible other soluti=
ons
>>> at the talk.
>>
>> Here's an argument.  The one remaining caller of add_to_page_cache_lru=
()
>> is ramfs_nommu_expand_for_mapping().  Attached is a patch which
>> eliminates it ... but it doesn't compile because folio_split() is
>> undefined on nommu.
>>
>> So either we need to reimplement all the good stuff that folio_split()=

>> does for us, or we need to make folio_split() available on nommu.
>>
>
> I had a question, one conclusion I came to was: folio splitting depends=
 on THP, so we either need to implement the split logic without THP depen=
dency or just make sure we don't split a large folio at all when we use l=
arge folio (what I did in this RFC but not a great long term solution).

Why? What folio split does:
1. unmap pagecache folios or freeze anon folios with migration entries
2. split the folio to small ones and handle other related meta data like
	page owner, pgalloc tags, swap, pagecache index info, or others
3. remove migration entries for anon folios, do nothing for pagecache fol=
io.

Unless the large folio is PMD mapped, splitting other large folios should=

work without THP.

>
> So even if we implement folio_split without any dependency on THP, do w=
e need to re-implement or make folio_split available for nommu? I am also=
 wondering how nommu code is related to removing large folios dependency =
on THP.
>
> --
> Pankaj


Best Regards,
Yan, Zi


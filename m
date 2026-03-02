Return-Path: <linux-fsdevel+bounces-79001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lc9NKf5pWmJIgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:57:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7924B1E133C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 21:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D743F304DE8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CB388362;
	Mon,  2 Mar 2026 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5Na3SZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A63382F19;
	Mon,  2 Mar 2026 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483651; cv=fail; b=VvEOl4bzhN3C1bhn1LLCSn8PDprt8hKKU1we8I0CqL0vYfqK/v1jjmYcjTtyKtetQg8wq/OdccfyCDTlzDo9cAFKpJRiWgOAhveWTpqy7qRmceytv0T0nuRBwsxa9LgG12mVeoByhtBsebBjcFjr2SRh/3k56OkkpKS2x8rVjBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483651; c=relaxed/simple;
	bh=r8ZzHVIRbc4vc9KsFtG9I0h38tjqfyb6Yt3xPr+sFHo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=svSRG08Q/0+Z3o+WL780IUypjCvYhlTL9ZLspymNQJvFEV3dbjYVrfE945uOtWHTPcokfsVxaLvYze9hEmSYGTWDmY3LoMsYtmVuk9btnAzIeMoiBeBM8N6PUXJQTjvIvLQCbsTmOJMi/MFIqK3OxEBEC5UUm/ZZejo5ma6fBt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5Na3SZS; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apw73pUQQJYEWAdraKoFNbL1Lc7QEnyf4DhDw9RvujAr+cQ4Cp+cS2JaogYeCNZzGVZXSsctwNWly7XNVlZzLSExxqEhGXV3to6Aew1fIdgcvPIuaznTDM9NUguAHT1pBpGiZJDK8PXZg77HHByaCW2KSXK1b7sFjVMNGumVml5cIplqwugFC9PyLa2xjwMri2XE9KBU+7X91ArXDcJNSIleyEveVZN7p0QC8/5v7OgOR86hip0iEFxs07khwm/wZ5LsYuTkSa/MYN/sPtZM4LT4UtegmhFXFZhdepzTHkujnGfYyHqk7A9IVdwU+9mHXQFDmRsTJOQu3Qj+Y4dDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIJR+S3VvBRrbI22E4eFJrKOLiW/e1x3KyERvj1h3RE=;
 b=Ma5N/cJl36Pip83xZFWktGnnWs0nKCxMb4UOrVrfJfh2FE7g1yui9xuqik6gTLn8o1405wsElyRIhkHiePUIeULQvLky0l/ap4V7Zwc6OrYxECY4RJMghw70KkT/i4/Zl28kSIjS9UWb5zjKIudxJ6EwzqGb2O4cWsBQWS07zL6+BNugKEXHEvNHSKd0dGSw/I/AuiJl5l084+1Yzm6YC1OarVNY85xgudb+3fboGyJnh7CvjvX1etJD/7ylFKk9vY3Vdn/+BwmEO8WBX29D+6NJeqQ7Do09r35xQgTGvlYSBB11GWXNmc27A5/TTmsOB5xkgfM+7ThDeEE4f8vHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIJR+S3VvBRrbI22E4eFJrKOLiW/e1x3KyERvj1h3RE=;
 b=h5Na3SZS2xuydCfTRz9mjr56SkBZIryh+0F2SmJ9u4/WLB0GyMBoo6klRxLkt20S+7wN3/BJ4CmdO0JtANmPW4ml978ozSuBhDAiIqbOBM5Gr5n2aGVlUIPyoBEmp00M0RTuofxf5L/txKa3btswePG6Ty+TJhJY9ydURLAGKb0J20veEPwh92jZvaETR/9g0MVGPUsoKUQDyWkBpok74J/7riN3bCfhP171Avip5sh9nMpiRnovZoLyJofYlFqbcZHiSgUtoRSVv7wgtf0cKNG1aZDvL+v9c8rUpn5yp/iopI4ca1xU7ULqEt3g1UJ0XhELm+WJ8Zo1HMu3snJqGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.20; Mon, 2 Mar 2026 20:33:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:33:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Bas van Dijk <bas@dfinity.org>,
	Eero Kelly <eero.kelly@dfinity.org>,
	Andrew Battat <andrew.battat@dfinity.org>,
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/huge_memory: fix a folio_split() race condition with folio_try_get()
Date: Mon,  2 Mar 2026 15:31:59 -0500
Message-ID: <20260302203159.3208341-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 0694e7dc-ded7-41dd-9410-08de789b0723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	jk0A9PT7wUxwelh7KmAM0eLvjmCNCElqUQkexeLP0mA06EywAuMQu40X0Pv2TbVRmUICMbwqhe7mOQAyoacsBrdYF0XbL62Bfza8tsoghSVXxLBI5qr7DXZkqLIfeQ9pOlMhgpGpm9Z7W6MJDotUtD0g/Hy2op7xsTewCiZv77ZttyDRR1NlL2e8v6pEPyWCM/nMskyJyiuLm2cdZW89+JWM8Dn8ywScPp00yfkV0Dh+YFpn4bggHhmbzB8LRTrEDdmgSf5kvonfRZ1wPXs/1nBqjBeAwtShrBUKRr2RAoqvSt1gcyiVgf7te9v+dnNEx4aPj723xYPTy7mf0l7OVIx0Km+sY9NUIidN/SkGdX2RDqNSBtAHJoY/iiwTn2fUQ9BXvubeFkt4jUIrulPKe+e40d+sD1rkIAv1TF/JI5oJ5YJVYWNLqcEzOoAp7zDiUA53aXAkPnm5AfjzwueDMow2REnhUOLPtywr/HX9uVSnb59WwHct6ZkuyjrNU0pXDbZHnyjBVdc2TODZ+V3lZXQP7SF2FNsPvufZtxVuvBoRr7Wdi2vlaJbyUJ45+V7gHtZRpcHOvHTCrxcyhcMAYTeIrJikFMxu5Rkm1dumpHgNAeaD8aXbslbnDTF1VHgVaaQXDUXElvTvPQR8oJlMlCh9vp22ZE6YOdpFa7An/2dKZxN455CMfygaX8lsIMpsSu2EZAErCpusSzPrPlVSh9xxM/hOY4eQsANhe+gspYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsQTy062+n6Mdku4TgnfE4W5Q+YPcElZNzjEQhjTIfzxB0xvvqhVKUZod8wh?=
 =?us-ascii?Q?EHpijodYBvs8T4awiqQydI5MBc0kf1rNuWUK7RYffXBJnYAIkMw0c8m371x2?=
 =?us-ascii?Q?qA77FcealKxkLMudlJdoj5y2a90IuYLsho8nh35i5qty0tUW6HUdhU5ogiO+?=
 =?us-ascii?Q?RevaLeZFH0kDwfwCNM8kWi4/7J4WC6M5d/vVNI5TqdxJERBYoDbt2MxNK+8z?=
 =?us-ascii?Q?FJV5AOq5tZQDBrO1J5TgTh5HtTpM2MauJ154C/DZ1NytT3OB0YnpzjKphlFr?=
 =?us-ascii?Q?eFXqzb4mtAqN1JHyFImuT/fXVdKZDU17C3Wyu3bX8BcCRS5USoYHmqOoDEP7?=
 =?us-ascii?Q?j5c7np5ifalJnJuPfpN527tRLEqC47Ng+LX7o7oUA2pexdeSgvb01fuLm/AV?=
 =?us-ascii?Q?sqaTUiFowDLc4JnuTsLtjbIjW0nI1q1Th7e8Xkk+cah61pd4k5b1Itw8sjg4?=
 =?us-ascii?Q?26AKdq/O2oq/tn4n4wy8b2875iRiyjD9DaPmM0Qf5PQJ912xfZKPs7Cc86jh?=
 =?us-ascii?Q?OubaRi2HR2GNyqOvwupu72RL90JKxZaKXjf/XZDjP6uqJX713xcaWnQqYH0O?=
 =?us-ascii?Q?MVm6lFbM1PBrq7nvmgZaPKavQZl2ReVQv9skddbE6GFWnJba6RdyiCVoCLVN?=
 =?us-ascii?Q?OR82e5UQv4qxILQCMX6EE49GRQ2fe0+ZUKWuhzL7O0A0/vknkZHHDE1x7Ij+?=
 =?us-ascii?Q?YcfBhV0Jmh9BH8yqbyBGfCCFpogGsYkyS5LjBKKb3v4kpL1CBliVQyPAv1eT?=
 =?us-ascii?Q?f5Em7ikHOooClmISeIBPxbwHJT/FT9bgJcqwrKdyIna398uCEF16WeSSh2o0?=
 =?us-ascii?Q?bEVV2PFxdMKAPWxuqJ+PTA61GRjFARdJTVJqzW2GlSylq2Rc5mBxSDEAR7Qh?=
 =?us-ascii?Q?SAiyHqgcN+CsVO/lceVekjjApeEp8atGEjrTadQ2wTPrPf/i98/hl/9XLDch?=
 =?us-ascii?Q?hwiUBc6NECCvoG7L8p7Iz7EeqgaSNVUR2RVAfyEi9ZXbqyvP4zNKmXPQ0v6v?=
 =?us-ascii?Q?li4gMgxUkmqbu7cJPnav6S1HluEw715RWDriuB4Uq6C1dn3ch2ZWqUJXK0Sp?=
 =?us-ascii?Q?/1k7WY0lBkgtso2r5bfdvpUG9HtWa52nfrEAOf3Jq3Is5eimxbhNoaZnAvOB?=
 =?us-ascii?Q?Vjo9idLgzBAIqUfrgBRFZrb8SdF1EPSXLuBcRvVDLhq/DpNL2dERkZyj5hIx?=
 =?us-ascii?Q?q6YqMAs90Ca8JeqFsoiZ6XY2/qpLHWud8lTJqJRyX4nNd1QzXngaomXUPNdp?=
 =?us-ascii?Q?N5Ga/nYhS/Je03E+3SftK2L+7jg050cD4Evi9MsAhNlnMVKA8eyQ5K3wxB11?=
 =?us-ascii?Q?FCOSiy1dIav5k0NVjcZjTuf2PCetAn6FKVVHYEsEgSpyoAkH50zHZ0nWIiPu?=
 =?us-ascii?Q?YynaL0JZQYvT2i9C3G6DIHrkmZsMsdFM9L/SmHo/MXGnIivsX9h1HxQCZefc?=
 =?us-ascii?Q?/W2qDmWeJqpLNbNvL8dWMPnUfUn9vKmelGWe3jebSh94NFji+3Zp7VKEdefA?=
 =?us-ascii?Q?TR5DB0u0xTeUvsPGjih/bGFxDD8IU0S3GUb9cQveybIXYSk8+49c9L001x2J?=
 =?us-ascii?Q?ZQeQSclD0ITFzAGjxwwwoYFB+wrdc04hqPZhgSMQee2dJ7GIA9XSj4ZRn+UN?=
 =?us-ascii?Q?LdIE0Mnoxy1F7YjoQPwctlYUW0yb7FFpMHwUSvBdDDtm1Ild5jFTCLThFd0/?=
 =?us-ascii?Q?HT/7k7ca04ySaTvJbIOo7rzlXlkikdf7fdrIV12OgevwvDrk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0694e7dc-ded7-41dd-9410-08de789b0723
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:33:57.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eajFENui4QHHZD3rfgCEV67fI2vuw5vrCNvnt90QEtx2+SLb9YLtsUQF9o275+Rp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
X-Rspamd-Queue-Id: 7924B1E133C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-79001-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

During a pagecache folio split, the values in the related xarray should not
be changed from the original folio at xarray split time until all
after-split folios are well formed and stored in the xarray. Current use
of xas_try_split() in __split_unmapped_folio() lets some after-split folios
show up at wrong indices in the xarray. When these misplaced after-split
folios are unfrozen, before correct folios are stored via __xa_store(), and
grabbed by folio_try_get(), they are returned to userspace at wrong file
indices, causing data corruption. More detailed explanation is at the
bottom.

The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
It
1. creates a memfd,
2. forks,
3. in the child process, maps the file with large folios (via shmem code
   path) and reads the mapped file continuously with 16 threads,
4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
   large folio.

Data corruption can be observed without the fix. Basically, data from a
wrong page->index is returned.

Fix it by using the original folio in xas_try_split() calls, so that
folio_try_get() can get the right after-split folios after the original
folio is unfrozen.

Uniform split, split_huge_page*(), is not affected, since it uses
xas_split_alloc() and xas_split() only once and stores the original folio
in the xarray. Change xas_split() used in uniform split branch to use
the original folio to avoid confusion.

Fixes below points to the commit introduces the code, but folio_split() is
used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
truncate operation").

More details:

For example, a folio f is split non-uniformly into f, f2, f3, f4 like
below:
+----------------+---------+----+----+
|       f        |    f2   | f3 | f4 |
+----------------+---------+----+----+
but the xarray would look like below after __split_unmapped_folio() is
done:
+----------------+---------+----+----+
|       f        |    f2   | f3 | f3 |
+----------------+---------+----+----+

After __split_unmapped_folio(), the code changes the xarray and unfreezes
after-split folios:

1. unfreezes f2, __xa_store(f2)
2. unfreezes f3, __xa_store(f3)
3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.
4. unfreezes f.

Meanwhile, a parallel filemap_get_entry() can read the second f3 from the
xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Then,
f3 is wrongly returned to user.

After the fix, the xarray looks like below after __split_unmapped_folio():
+----------------+---------+----+----+
|       f        |    f    | f  | f  |
+----------------+---------+----+----+
so that the race window no longer exists.

Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Bas van Dijk <bas@dfinity.org>
Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
Tested-by: Lance Yang <lance.yang@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/huge_memory.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 56db54fa48181..f0bdac3f270b5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	const bool is_anon = folio_test_anon(folio);
 	int old_order = folio_order(folio);
 	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
+	struct folio *old_folio = folio;
 	int split_order;
 
 	/*
@@ -3668,11 +3669,17 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 			 * irq is disabled to allocate enough memory, whereas
 			 * non-uniform split can handle ENOMEM.
 			 */
-			if (split_type == SPLIT_TYPE_UNIFORM)
-				xas_split(xas, folio, old_order);
-			else {
+			if (split_type == SPLIT_TYPE_UNIFORM) {
+				xas_split(xas, old_folio, old_order);
+			} else {
 				xas_set_order(xas, folio->index, split_order);
-				xas_try_split(xas, folio, old_order);
+				/*
+				 * use the to-be-split folio, so that a parallel
+				 * folio_try_get() waits on it until xarray is
+				 * updated with after-split folios and
+				 * the original one is unfrozen.
+				 */
+				xas_try_split(xas, old_folio, old_order);
 				if (xas_error(xas))
 					return xas_error(xas);
 			}
-- 
2.51.0



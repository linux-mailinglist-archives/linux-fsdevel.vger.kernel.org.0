Return-Path: <linux-fsdevel+bounces-79266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKQdGTcOp2k0cwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:37:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 033571F3EA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 17:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF46D309D1B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04624F796C;
	Tue,  3 Mar 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MtFBb+O1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7764DC54A;
	Tue,  3 Mar 2026 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555509; cv=fail; b=ieOSaMdq63/D6vavGYbasazOHm27w6n4NpUW8fQBkZcgf3JWD0IUptZ6xz+/a0HPxg4q9XlnGVuFT+myEp3vTMLMP/kG/lF10yvNRAV78nomw3PIbNTbrU2dSWCUf0zQafmxYIUzZF6i3TH09iqI9o+dUqhRQpv52ylXE4CGScw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555509; c=relaxed/simple;
	bh=iBfTZo+P77hmnLZMcN2MuW5+MIDVOgjmQ2moWSjniHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWPbNr8Ha+6DlazAQ+T16e8XsAEQs3cFyanSM3e6aQzh6xPL8ud8mgUsdplkvkR+codVDZY+jbl91JBOy9tajZ6uJaNLeUBzbEz/d7Hw8zG0nfkSNcn3s+QgXBLRvxB47yl98MgEcvDjZVf4oLGMzqBozI+l4noVKIrfBwWrGkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MtFBb+O1; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9sWlA5SOTtIDaNXa6weJEYwlqO8fZTbzhhVJH/z+sENKSBTy0a98yKZABQuHkvDZHuENnjbf2m/LKQAVw/4JgYYlkbuxMXjx90wkAcaMY9tzSWGT25F7lNqV3/ve6hLQhRYTJCJ7mEMpFQHC81Sy/PTYB7gMLCaXpLa/DepHkeCgI/MmU+oukL5X6ooATiQDg2VSjhwXmvcnQXoZSBAD6L3VOGv8TxD8c0NGb4IiSVo1MkpnEQ4QSkIfu8Z5BjSrDY4jEz4Sw+2d/qB1Tnrnw6nVF11MfaJDJv950TX7xB5YMewLnDoFVQjEeVQmwhOxojMeDRFbgJsEWKC+WfOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVjK5SINOhgOlrRRjppNtwlxFvqzetymBkRsuXH636Y=;
 b=KRjhtsdw6ccd1mGXXbgQmbt6nOJ1SOAsY+HLh9YQbazqOaDhJOF6hi+olY7FfKb5ZYoQ3XM/+2SGe5NMpPZLTrTSpg69LlzCL0vr8IvaWZZ7b2TtlM+EV+ekEh+PafiaDds7tjfDvEmtzAzMYwlmWpZuOox+MgGJ3YBEvFdMHotFblnj0VBtYHZj/J1g16TH0s64edwEXVvrL0g+xPZGeYKovTFXQ6iRddY02FxBULeTbTiRmHzjuJZGUFb8F/2/IdqNHz/hXvi+oGjelarFjok1QFK0WAGshhO+Qw2TWS6E3rDL818UP4+6iv9xa70k5LIns4hFJLmnmYPCZV21nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVjK5SINOhgOlrRRjppNtwlxFvqzetymBkRsuXH636Y=;
 b=MtFBb+O1CyaduX9NO30+occ3gLxWRCtpPEWisWbyuOf0I+PQjiamjH/c1WFen1h5EmuSSuCfdiVbiMT3ueHTTFQeiv4UUSuwlugoJxPhUhHw042fobaSB1OTPrU49HRB5r7MzFQCkfmonNVq1iSApKKNttfjhpcvPv/PcOm7l10I9eYHJBpIIrNMqnH+2ERfaqeq4Dm8S/76V0LHfvRWMa1mx5ldJTKk5e4i/qfqw1XgxMp8XLYTs6rLxvbbAA+8It5UrtJSJjyRVFt884QUTQu9eLGgS602Icv1YZwtogtjRu+j7bAamykBg8VgpOvxMBkdJkpHLbFtLHF6bPoYjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:31:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 16:31:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: fix a folio_split() race condition
 with folio_try_get()
Date: Tue, 03 Mar 2026 11:31:31 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <5C9FA053-A4C6-4615-BE05-74E47A6462B3@nvidia.com>
In-Reply-To: <56a23a23-cbed-4ace-acef-3ada41bc182d@kernel.org>
References: <20260302203159.3208341-1-ziy@nvidia.com>
 <56a23a23-cbed-4ace-acef-3ada41bc182d@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:335::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: aa44f576-f003-4feb-d7d8-08de79425654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	q8iqYuhY2IQlIH5Tl1qFxMz1IwvsrualH5290e6V/FuJUiNI2lk4HoowE06Q5Lb4ewhrEKSVIrtCLC88a9nDVVAUX5xYrHa0GTedmnwem+tCJNrwcVMeMNSk/Juj/f3VW2z9vqcVUa7fpcMFZy6+82vNBmwrGrfd2LyJzocYjqPsZT+ymVUybpE7YhQL8tK4Hf1p7t38226nOQlsC4pzP0KhabriFtO32N8XJpYlPp1xK3jOL2tSecmPbTRuygnBpvr2VarUI8Ci5ifQFXY66kAf6DWEyiP1BO0quy3yqwZUWijk/QJAslqFvuOyrp7d4MX+5mkM6xevcMJAG7ysEMLAmMEfjXHjh83hYmL++z3QhnUQSFTbG9FKjbB8919/7xsQVkgAVwFFAfGBoac/Em6/KTT4hncNodNnL/WC6tFetF7wzqDrRKb5/0Ku8Z/MdXwUBOAT6ENUlnRptascR1DuTSYv/3CDHtTd8v+3pkFEkBkGgH8bFtDqKOunchJyDIKzY7/FN4MrM3TCjhfXbKOHPoXEh/aavuhcrHbRShoptYoNJeqY7L8Sywwfkblict5xCF2U9IkLPwXXXU//IzIC8uJ7Q95eCBh5pmDkv1+Mg/gEvjkQat/FjbLP4TFvCQliNFjspJ9US6nb23/3V72XSU2eRxfY3sKGM962mnNTejU/cEXRzjFcAq48J4vAiEc0UJiF0zUFfpGZUImGQGGnDdiP5HpzmPuz+mA1+/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dg1JaRNcMYqac3Kz+JPPnFaeecbH1mPUH0OSPRHDqJBMBbGHaSaX03XucQba?=
 =?us-ascii?Q?cnVKRpcbVYaGweBW4wWnhpUo3PA6RBm6CreIyWIAhoHTcVuMRKjhfoUBdbvB?=
 =?us-ascii?Q?wPIqnMX9yWOIUf+i5L5tUheTGTFrQmzz5zQHwPy1II3DTbCEAS0Giqe23W/F?=
 =?us-ascii?Q?+ZmYvQmAn0Ut8seQ8ca7EMpUR1P//q2gtbY6msH34AMcGl2tOMJdF/vDWuK+?=
 =?us-ascii?Q?vMu0H2qlu+Gl/QYfR/KJp13dNj0nSzZu5MCt6CbkJAsozvsBR3oskXRxM+Il?=
 =?us-ascii?Q?ZHZt3yRjLxRTctKTFA6OJY9Z50cfJUN0Hd8Qp7dfM7lizl5fhMc3zD6CTfSm?=
 =?us-ascii?Q?jDU4Du0zkxVEUPuZC3PCFphRTfqb7nZ5tQ1z99blAPuDjsFh6OZxylIXdicS?=
 =?us-ascii?Q?GZaF41XVT3iLEKNaMHlw2dD7AicpHm+E9bzOTi2rRH3E8MLn6G+JY6EJsfmr?=
 =?us-ascii?Q?a0vHiNBYRFoPcZKWud3EraQJDxTNmAR61d/fKLb1u1nz0E/66V75DZeMDoDo?=
 =?us-ascii?Q?Rin58g4r6FQMAV5/NBxUPRum9q+Tsm4IVgWCQMLQs8rfsppoIdzhritQ8Dpv?=
 =?us-ascii?Q?d0WzXyZBxMoGtWOey9AA2k+NnB/SB1HnSlUs8kK4BSy40Nthem5/UbbaxfBv?=
 =?us-ascii?Q?IIxQbixVfz0mqd5/ePM62RsX2omMqd4P3FlvBOmMrwq6XR7GR7AvuYDi1UDD?=
 =?us-ascii?Q?WpGvn7D5u5f7n9XQxXx5C2v7rlfN5j8hX3HyTT150/gHnAEzEjD88uJdjuyz?=
 =?us-ascii?Q?W6uwiPBidJmvJgY52rpyoPSwoJ5X+FDFruyF2T/V4S9Re/U9LMzDBdnLuHPe?=
 =?us-ascii?Q?Z38ZFeCvUC8ILP8Y9yU2O0QHN0omUWOWR1ibgl4fw925MQ+4Mne37XrjvQaH?=
 =?us-ascii?Q?BRwQ+gr6mjxbDSVZTyCyeLGMULEuf4NtENE+B4OAZF+nClh+RxB+p1R+5YP2?=
 =?us-ascii?Q?uthIO+bZ5SUhZrN2F9B+/l2zLZmZM6ckvZnMlHnE982MofQCIDWUfbLhoSEe?=
 =?us-ascii?Q?Ur1+L5fZFl4ZJxdang4MqPbddCKNvrsv1nuc/yX+LkyW4EHwGSTMVehsdg34?=
 =?us-ascii?Q?CQ/LqtNANf7iksqkvAiz5SWKY8rdI55qbAgsni41QnZ6T6eDIUT1hi6OsX5z?=
 =?us-ascii?Q?x/GxGIRzIZSgFb2vRlVDGYJnvcpfEbkIJ9epn6V6/uH6I29YiBcfOWdAN7EP?=
 =?us-ascii?Q?QN9wuXOTEogfOq8dNOwA+ZQYuje4RjpnjDzxqZkI3G9zCeQfON7CUv65to3S?=
 =?us-ascii?Q?k9KYTF/IjHN/woe7KelfJ/rF6nrNl3a/bqhjiI28JWUpXon2HBkhk29KICVS?=
 =?us-ascii?Q?Utam2XCRERsnesspn229fbipW8k3aDcunG7mxwJgKCGqCFyvmAxpfOvJy6N8?=
 =?us-ascii?Q?JiFlhqmqhOlvkyCcxTwL8+bO8E1l36i576e54ro3TFSD7sc/wLwoJdByZ+Et?=
 =?us-ascii?Q?G6aS6boR09YEhynMKwRDhXJcsLdXfAkVxamwwUzyAkcKGQV14D9fcNHwtQox?=
 =?us-ascii?Q?B6m7N/fh+8P/eq5aCKVzYyiKLQG9kEpxKgaePeBRY49AnwO+tCpZGX4Xar3g?=
 =?us-ascii?Q?0rIAr/QG+r1C9mjbXXXwcTU6gaM60s5Z/WGKlG1QymQXM4CnXCdwX8i5Je+5?=
 =?us-ascii?Q?KGF/K6Oe9hFAljqKCc3Re2BePivFUQbkoXRqt2pckDy5LXuLwUWTJqQTA6dC?=
 =?us-ascii?Q?qsMtaU/YGCKgZDtuE2fR5pP3fxopR5AaJpTuxZsJoZiEtdEW955HEMJba45T?=
 =?us-ascii?Q?xUB/YkmJxlUk7XyG3zF/3AwGmcqJdvzlJ+quXDtJV5hfE99OqEgG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa44f576-f003-4feb-d7d8-08de79425654
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:31:35.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ftw2Aw7kzPOQs7uiD7p6+Qmk8sReBIRaJexNI0EAXLr6wPjaE0mV2vfDoPxFeVai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
X-Rspamd-Queue-Id: 033571F3EA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79266-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfinity.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3 Mar 2026, at 3:48, David Hildenbrand (Arm) wrote:

> On 3/2/26 21:31, Zi Yan wrote:
>> During a pagecache folio split, the values in the related xarray shoul=
d not
>> be changed from the original folio at xarray split time until all
>> after-split folios are well formed and stored in the xarray. Current u=
se
>> of xas_try_split() in __split_unmapped_folio() lets some after-split f=
olios
>> show up at wrong indices in the xarray. When these misplaced after-spl=
it
>> folios are unfrozen, before correct folios are stored via __xa_store()=
, and
>> grabbed by folio_try_get(), they are returned to userspace at wrong fi=
le
>> indices, causing data corruption. More detailed explanation is at the
>> bottom.
>>
>> The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
>> It
>> 1. creates a memfd,
>> 2. forks,
>> 3. in the child process, maps the file with large folios (via shmem co=
de
>>    path) and reads the mapped file continuously with 16 threads,
>> 4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in =
the
>>    large folio.
>>
>> Data corruption can be observed without the fix. Basically, data from =
a
>> wrong page->index is returned.
>>
>> Fix it by using the original folio in xas_try_split() calls, so that
>> folio_try_get() can get the right after-split folios after the origina=
l
>> folio is unfrozen.
>>
>> Uniform split, split_huge_page*(), is not affected, since it uses
>> xas_split_alloc() and xas_split() only once and stores the original fo=
lio
>> in the xarray. Change xas_split() used in uniform split branch to use
>> the original folio to avoid confusion.
>>
>> Fixes below points to the commit introduces the code, but folio_split(=
) is
>> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() =
in
>> truncate operation").
>>
>> More details:
>>
>> For example, a folio f is split non-uniformly into f, f2, f3, f4 like
>> below:
>> +----------------+---------+----+----+
>> |       f        |    f2   | f3 | f4 |
>> +----------------+---------+----+----+
>> but the xarray would look like below after __split_unmapped_folio() is=

>> done:
>> +----------------+---------+----+----+
>> |       f        |    f2   | f3 | f3 |
>> +----------------+---------+----+----+
>>
>> After __split_unmapped_folio(), the code changes the xarray and unfree=
zes
>> after-split folios:
>>
>> 1. unfreezes f2, __xa_store(f2)
>> 2. unfreezes f3, __xa_store(f3)
>> 3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.=

>> 4. unfreezes f.
>>
>> Meanwhile, a parallel filemap_get_entry() can read the second f3 from =
the
>> xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Th=
en,
>> f3 is wrongly returned to user.
>>
>> After the fix, the xarray looks like below after __split_unmapped_foli=
o():
>> +----------------+---------+----+----+
>> |       f        |    f    | f  | f  |
>> +----------------+---------+----+----+
>> so that the race window no longer exists.
>>
>> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) func=
tions for folio_split()")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reported-by: Bas van Dijk <bas@dfinity.org>
>> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OL=
umWJdiWXv+C9Yct0w@mail.gmail.com/
>> Tested-by: Lance Yang <lance.yang@linux.dev>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  mm/huge_memory.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 56db54fa48181..f0bdac3f270b5 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *=
folio, int new_order,
>>  	const bool is_anon =3D folio_test_anon(folio);
>>  	int old_order =3D folio_order(folio);
>>  	int start_order =3D split_type =3D=3D SPLIT_TYPE_UNIFORM ? new_order=
 : old_order - 1;
>> +	struct folio *old_folio =3D folio;
>>  	int split_order;
>>
>>  	/*
>> @@ -3668,11 +3669,17 @@ static int __split_unmapped_folio(struct folio=
 *folio, int new_order,
>>  			 * irq is disabled to allocate enough memory, whereas
>>  			 * non-uniform split can handle ENOMEM.
>>  			 */
>> -			if (split_type =3D=3D SPLIT_TYPE_UNIFORM)
>> -				xas_split(xas, folio, old_order);
>> -			else {
>
> Just wondering whether we should no move the comment over here now, so
> it just covers both cases.
>
>> +			if (split_type =3D=3D SPLIT_TYPE_UNIFORM) {
>> +				xas_split(xas, old_folio, old_order);
>> +			} else {
>>  				xas_set_order(xas, folio->index, split_order);
>> -				xas_try_split(xas, folio, old_order);
>> +				/*
>> +				 * use the to-be-split folio, so that a parallel
>> +				 * folio_try_get() waits on it until xarray is
>> +				 * updated with after-split folios and
>> +				 * the original one is unfrozen.
>> +				 */
>> +				xas_try_split(xas, old_folio, old_order);
>>  				if (xas_error(xas))
>>  					return xas_error(xas);
>>  			}
Sure.

Hi Andrew,

Do you mind applying the fixup below? Thanks.

=46rom fe94203b814a7fb11035c5b720a5e798ec2bcbb5 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 3 Mar 2026 11:26:41 -0500
Subject: [PATCH] move the comment.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f0bdac3f270b5..6d3bdde334126 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3668,17 +3668,16 @@ static int __split_unmapped_folio(struct folio *f=
olio, int new_order,
 			 * uniform split has xas_split_alloc() called before
 			 * irq is disabled to allocate enough memory, whereas
 			 * non-uniform split can handle ENOMEM.
+			 *
+			 * use the to-be-split folio in xas_split() or
+			 * xas_try_split(), so that a parallel folio_try_get()
+			 * waits on it until xarray is updated with after-split
+			 * folios and the original one is unfrozen.
 			 */
 			if (split_type =3D=3D SPLIT_TYPE_UNIFORM) {
 				xas_split(xas, old_folio, old_order);
 			} else {
 				xas_set_order(xas, folio->index, split_order);
-				/*
-				 * use the to-be-split folio, so that a parallel
-				 * folio_try_get() waits on it until xarray is
-				 * updated with after-split folios and
-				 * the original one is unfrozen.
-				 */
 				xas_try_split(xas, old_folio, old_order);
 				if (xas_error(xas))
 					return xas_error(xas);
-- =

2.51.0



--
Best Regards,
Yan, Zi


Return-Path: <linux-fsdevel+bounces-76416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cz8Ao6JhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:14:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72295F2454
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD9D03058095
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4933D1CD1;
	Thu,  5 Feb 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jknTC8Nd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DyDIOAHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72E3A9D9A;
	Thu,  5 Feb 2026 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293347; cv=fail; b=co2vYM0uVx9DaiL7EOUOVPINc849wQyNB/ruyeS1n1pronTItZh8G7dWskgkgqAZeJz7wT7QKnST/RZ+wGRsCGJ/UiXKKl5gSf0npo6acwAXcDhKu9nVdECglY1swlJgq7pfguX8kEhNmXg1AAf5ONOTnQJ/7r3uWrohjb7QnWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293347; c=relaxed/simple;
	bh=r4B52t05kmoxh/B4caIHuq1ys5GF02q81ZMIVYCy7sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxeuDNSwwUn2sJ41W+vu5rw2hhb0s7ShL3/sQ2YsD57XZSLoK89S4S35BrL3JiRBzBptVwNHovZlk4Q1AiP5wKMQ+3gNZumD+07J+xnvtEpYuWjBKJ+0qugiBa5LnMYYmrHAfmL3P0bLUPXvwwZFH/al6rqfP2FpLPzOD0LTQrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jknTC8Nd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DyDIOAHN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614NUJmC2399904;
	Thu, 5 Feb 2026 12:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=r4B52t05kmoxh/B4ca
	IHuq1ys5GF02q81ZMIVYCy7sM=; b=jknTC8NdDreYUeQWok4BLOewSvPj+4jU57
	q4h0FuexYD7zPXojqARNAsWdpttWtQ9cm44tiFUa8oMocdeHeUm8xlKvzcm6HPGR
	YxodD/UqmY7i4XhZqDMDi2cfFO7BGoYEHmUWJLtJhgOo/jk9TmON7SSoE9dSVLaw
	IWbIlyRKj2kuk7/xmLPKJFrHOm58t8+GsWtT7P290HliMnkTpuXNgqtAnIdRTwv5
	CvRuwTRrB7at7OuYIyX4MdZL9OBwy9ACz83YomzUHAbbj8tqxYE6urbA6p2VuDBi
	T1ar7+wWMK6RF7cYQtW1FuHttpPVLg0IkgOJ3X8bPPcFMJpBX1Tw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k5g3drv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:07:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615Bklrt018820;
	Thu, 5 Feb 2026 12:07:27 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186qm6hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 12:07:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ6z5bPcRhEM+tclkwaAt6iDG1+78ZmSxOYbyS7OUhbDbnRzsJwKAgGkFbQjhGrcAVA8PzJQf32L8JgeA9DybMg4oLUqYzv5wbqMLGOTDOhE9jTKqMoTaUMc1TOxQLP50Ge6U5At9of5hgI1BlwHtdJIBbLjOgwWoxjWIoYrvQzaUt08iiHutvmNj645ldGQQtU34kbjMwimcBkGhm6plxI1EtDAJYmL9/yVgUdM501MZXz2en58U64o5Y6adKcjq0i40H2BLKR7R/3ktPC8zjuWiIgXO6QUYp3HxsoFUl0/OWt3iSHpbZZtMlyRkzNmwWEFvHZLLjgZbitbjMycSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4B52t05kmoxh/B4caIHuq1ys5GF02q81ZMIVYCy7sM=;
 b=DhoWL6cdtsp1awHLCG9cg9Y03O+nf9jmth0phjjMd4cUpra9t+ByTskk+GIcs/fW//YGn29KoNhwU0wC/jRtSXEVRA7+6zHSxaNBbIYfsa3MTDr31ishmI4pmnOSTCJVSjFGDtPUnvF8HXmCn2Pjt5RXcsxhVUusg1APToD0S7BvDdaRH0GJOFlE3y/nDXrYOaY2+xRhhsB0SXzddoA6+cqx6LsuqUBmI5bS1KSB5eNbsKmdSc/Dna2MqnPFa3tR8J04VidbIFPbF3n9KQVsVn1lf8n4GE2w49lcy8uD74CU9GwEPvL4PK9EeHDrGX5MMSSr0jMQeGFNGQdorAwG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4B52t05kmoxh/B4caIHuq1ys5GF02q81ZMIVYCy7sM=;
 b=DyDIOAHNN0NzYE4ypJSW5nkpqRzOi5FsSQP2rNI5MzU9zgwf/93dfWlVebjBOjHVyN5+fJT5U3pHiIhHucwD9hJKt0fo/EwbvDPKQ/md+bdfwzK58pRdWcZlNMolTwuwYJV7fly5L3mKU6LOf55Ez6odDQv2Mu5voR+qfAx5tKs=
Received: from DS0PR10MB8223.namprd10.prod.outlook.com (2603:10b6:8:1ce::20)
 by IA1PR10MB6219.namprd10.prod.outlook.com (2603:10b6:208:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 12:07:23 +0000
Received: from DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9]) by DS0PR10MB8223.namprd10.prod.outlook.com
 ([fe80::b4a4:94e3:f0bc:f4c9%5]) with mapi id 15.20.9520.006; Thu, 5 Feb 2026
 12:07:23 +0000
Date: Thu, 5 Feb 2026 12:07:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
Message-ID: <26027467-76ee-40a0-b5e4-99c5f77bc836@lucifer.local>
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com>
 <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
 <d122f9be-48d6-40b1-9da8-cec445bd8daf@kernel.org>
 <4a36c1e7-e51a-4c06-8f7c-728b278af972@lucifer.local>
 <d309b3f6-8959-4767-b262-7fdb957669aa@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d309b3f6-8959-4767-b262-7fdb957669aa@kernel.org>
X-ClientProxiedBy: LO4P123CA0131.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::10) To DS0PR10MB8223.namprd10.prod.outlook.com
 (2603:10b6:8:1ce::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB8223:EE_|IA1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cc2c50-06fe-45d9-0b87-08de64af1ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/9xKyHyXWf0AXtDXKEWM5H2HB/gaVPdanwJR3S26DNktfOE3HYRVqUrxQzAf?=
 =?us-ascii?Q?T7bHFcNF4mx14rvs3NTZjVIoa9GRsB9UUCX799gOf5fK8wQsP7nEYTCJEPH3?=
 =?us-ascii?Q?Iis+RDjIxUFfeAmBY32qMTTnCm0T2PcZBiIdDNIVoOldi04c/kJ1FHF8plwX?=
 =?us-ascii?Q?Ji/CPwHyAwUFcB5TPIxaEgjRIfNZBxQnGtMDHVIqwg3yWF98Dn06WZ5dxKAa?=
 =?us-ascii?Q?tDI2T6ro9E1bb0XI/iMKL4KUlBspO6OVKdgZZNOBSeyTImPga9opcNIR6sDu?=
 =?us-ascii?Q?nQkGKw3VfuB4UQFrr3ktWPUIT/8G8xKQjB/SDYbozGLJ7Gc1Mjpm4fjMgiid?=
 =?us-ascii?Q?zTsoJZYrYm8rqa2jOcLXcr4zJih5klDGE6AVIqMuD3dZlVwTudY6KF+yMq6L?=
 =?us-ascii?Q?oeU/+QkZHHY4MjM8217+7xVVTUIgJ+lKhcHHx3kKGoVTKLv0A4fzNRkPrOrG?=
 =?us-ascii?Q?4693GvcYT78FRaK6IHhxkU4ZNVGUaqVQCFybcM0s49TruSr9Tf4338RVJUvw?=
 =?us-ascii?Q?CEe13cDmrZxEGYBEhJeNnkRHpIahsTGmzC2nWWv3Jl1mLaUaPQwXnC9GcYcD?=
 =?us-ascii?Q?TZPsCeqvt4bficBjRG5EgEf/UuX/6vfsrirCVzsH/7vHEn6mzp7YSiYf9Mxp?=
 =?us-ascii?Q?d19fa8ee4JIkQIrI8cAUt7t7WxOW3ns2XWD3wb0RK2iuvj11kBi+vHjirgLb?=
 =?us-ascii?Q?chHTAaTIbX4PswZwF33HWLbgi7RzTTbXttmk25Ehukfkl62/MiDHqMozHW2/?=
 =?us-ascii?Q?VZffhWD4B5/AOd3noD093O5ufg6gIuzIpSm2an9Eai7U0axdrCu6TRdzgZhi?=
 =?us-ascii?Q?UBvXoIxMC+G+jo2CviDqZjZw7wyc4BfO1upUJEUn7bWlJ2fiEJMRBUkr5+NP?=
 =?us-ascii?Q?DU9Gojw5y+6bY10kuFqav5gNFIs2voXWwt3SfQS3zQIA8sm0RgY7PiqcwC5i?=
 =?us-ascii?Q?YwNPGF820yphyBdDHTVdf+eiTcPKTq91mlmMY/fQSKy2hWImFLqqZFTR4SIp?=
 =?us-ascii?Q?jpxnx4+zBGFWqWyXDFj84wUFgN7KP5kMVyaG4PzrdPib7XSS02AKxIac1gnr?=
 =?us-ascii?Q?u/a9Wq64vuUEul1JbJcHHXk1W5PMwZfREj2EXtXQc2TGeQefutML1xroNa+I?=
 =?us-ascii?Q?bH4nGr/hQZC8jaZFRXeEeVzcO6c94uXd9ajXKz9dKCPh5PkX/BSZbmHrUf1i?=
 =?us-ascii?Q?uCdEu7upNp9+rKZMNl3EnP3j5K0L0BbENtltIjr590ED2OJLP7osZPuXEYQ3?=
 =?us-ascii?Q?lSNST+veMpWRZ25Wv3cahXM93pjv09oKkTVj3DvG5ilkaBBGylmtyN/AJfc1?=
 =?us-ascii?Q?pIiXsg1IlwYtFAih6DM3MARChwDbkwF4OvtTo+VZEGXCbnDKJtQIKmr6NPgS?=
 =?us-ascii?Q?IeDmymVDoKDx3aTGMqsGauVW8Jey7MhVEGeE1BQbwzFeV1//L92wR7AQTJfq?=
 =?us-ascii?Q?bl+Z3/zOT2cr5DG9NKbLnce8c0IT4G9irrO6RGuVHU8dJKy/mdni14ZxGOwd?=
 =?us-ascii?Q?yEmkd6OwCeLqia/nL/9HQ+W+bE2bR8vOMn5kpo+asFYzDPKHdi1CnkgnoZeY?=
 =?us-ascii?Q?WDIhnBebom62vKuoA4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB8223.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?25Ka2HGGTJvQ0TCStVvoUuknFTCrAG7zOcqDrckzuEE0O73tyzmLy7lSoTVv?=
 =?us-ascii?Q?y2YvACepHIPq5frtdEj3Ul8oGRAoNN/A6pXLxwwTM/NXVQG9JMek+iP3+T9B?=
 =?us-ascii?Q?SHP1bvi+EqCJWF4XE9el8H15r9VNtynC7xt5hE/Ah2yqe3fHCtUILBmFCXUf?=
 =?us-ascii?Q?LZp/G/oy9A0X0HQnO5hhKVUHJiYcifjOzcUuqx0f5sdMWSCOXQFnGbzHMZzl?=
 =?us-ascii?Q?ia7pNofowyudWwYsPSkl9fVw1NhmuyUGDGroP/DNQHXa1jNbFPI/7X0EY9gN?=
 =?us-ascii?Q?lRYHDXX+r4PMzOKirunsE1yQTzIzh2hHV183VTP3WrvfnyQ69WBo0BOYOV0I?=
 =?us-ascii?Q?TKgAsfCRU5UPvAD+2g+fFAjGOWrjbR7jXIHlklqjX0YVLMIQNS5IAOpHYH+F?=
 =?us-ascii?Q?mRZgBNu/HtqQWguzCYCNHgDLvxJNDb80OiJVdH0wyuyoJ3RXh887nKPl1fNB?=
 =?us-ascii?Q?rVkq3QfEu1iad9AvEZAPgTS967Ku5XSnF7Gax9t9KuD1Ggy9HO2sH7E+K6Zn?=
 =?us-ascii?Q?hPiiVzdI3D0MdqMbHYudJeyCNclFn/0DNodxfQO648CwNTXrYM5FCBxe8miN?=
 =?us-ascii?Q?QlsvL2QQjORdW+0GJSmkrITW0CzNtSYAE46HGYt47ju1m4czmIA8XgDgHJ4M?=
 =?us-ascii?Q?BGcSDTjMC/Ryo0OePCspyr1il7R3st/y2fxX637sVrpMpLieAXF0WgP39apF?=
 =?us-ascii?Q?T7LVxxCrptYPiUNHSrboiyy2B7XbsuwAO0LWxV6uoGw+ZGiFva+vIBEOIoKr?=
 =?us-ascii?Q?1NRrHjSgEDSsUOhpiGwmi8fxsLRvjW1eswAJ850mj8MEvU8RdlZc7WTavuMp?=
 =?us-ascii?Q?poIoz87PIE+o7L3cP/IixIt+u0qmdQ5Ebk2pErEZi1HOmHwRuaaOZ6VRpGfu?=
 =?us-ascii?Q?6pzkWzRlGrHD21ua4GjMnFfdINu16FIPstilQT5rtlHuQiCWTrP6bDs8J0Nu?=
 =?us-ascii?Q?rGT/6RYtAFQwAD5nO/RAqO0nJM/ZF/SotbyHfeRd/ZbVCZpcl7Pd9LkvI/YX?=
 =?us-ascii?Q?6IpWi86oDThIA5WUByTFVioTiVVQQ1jB/yGeKUOs0dS3uJlYp9UMHzWUZapf?=
 =?us-ascii?Q?XmgTXNYUd67xb4JsN0kHQK7FD9W+ljopXlnqSN/sarNLnm1LaRfQ6vagpL6R?=
 =?us-ascii?Q?Ga/GXMkGuehVTmkM9eWUNTDY2Nfw83VPyog5tM0FJpDhYNM6dp1/GHJMWnLA?=
 =?us-ascii?Q?PeCG9+RdCGm0pW1PebtyZSNvqlQCUR8k9Dsn5fKuYTJW6NyvLzv2XblD4TsR?=
 =?us-ascii?Q?Ii7ByUK/vLlo8YXyh2weVJNGaaZfeUu9+dkoXU1V8QYMGo1J6AneHxqtE4Tr?=
 =?us-ascii?Q?Ez1RObijjrk8pg2/1+TO9l7UuRqqYkQNs/ZE4QLlatYruBmZDtph/G/y8k7g?=
 =?us-ascii?Q?+/ZBQS1OWIvLDrEuYAE4XALB5zHJLpBicqplBWt/VOk+2JTNZ+GbE8aqK7PO?=
 =?us-ascii?Q?u5mctQYhAGBJ1kDYkgmixPJnU8ChiOSJV/hFc7AbX1W2YL0kwLJU9wLUvfRc?=
 =?us-ascii?Q?ChtyEuDPxQTraJnbVUjKV6qccjbJUgQwVwvKMtcFrC0EzzuPKVta06HOkpVv?=
 =?us-ascii?Q?lHHgHBREhhJHiw5BuHPRzMQ0VBn2Yf45ahFoff2PMDxRInEqj579WrsXXKyR?=
 =?us-ascii?Q?IT812lM2q/dAVDVLesGzbgxt4hPnf7kq5qGmRZO91NKVrmEv3yRt2yY9DL2v?=
 =?us-ascii?Q?s70fI0UbXCLnBMTVFNNz6a+1p8G+H/gsEGClJAeJYpRrKqVnPNfM395frkEE?=
 =?us-ascii?Q?KrR6ywjxF7oylCjcA3m17CuJ5kVGEDA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	btpqUMiVtO+5sITCXF//juXIhE4hzu98J3tro4fXdrUAuDzI4rljN5YY+6UqqCjaHr2WJmHNDBBLZRyiwTMnovx3DW6odzWZ77tuslW4cHE6JrkfbPDaVxdKGtBoXfDTmUzLQJ96Wce8YhV1gJnFv3dN4SDGmMsSyzVcWCTtIJciY7XjglWBO5mQvX7wL00oldqK8DGdN3AN9NvSLd6De4gWsmRCHKXvvaJ9rNXN/0y/VWWPnZYKUtreBmf3AVerjmw1uWxYGRBDXf9pHNFKUC2ponwx8Q3A5SY2gA03ePwEMHbhP15Wi+V9vQ5F0kF/pXjaQ6KyxAqpIBrbvi6meSW/0rM7zSil3QNGHZKFIFf+XjifnoRdxM9CsMZqVE0XVqw+YZ2vG4G2ccvEKNzB2VUJXL1bK0eK1k9u9/Ts9RMSQcnfY/E16WjNLJMRzIVaXcCGiTWaPSQsNZ4pbQUbRY+f13e5cVyJROTYo7nlZIAEUcHznooSUd/fQiToRLBEyFvdw+uHkY/RnvcCU5kalMBuZBRJI5JOMP/2Ak4UgDUgL9+TyHHXybf+fOC9AcHU/0abPEbfHJUPGczgArNxvRgfqV7GLecKNj1rM/WUdwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cc2c50-06fe-45d9-0b87-08de64af1ed5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB8223.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:07:23.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED8t4k9rerONxDXK7a6yQPEWNvdG3jOYXXqZNQ6NSTDzy4CDpcOvqc/ctvQKnveCrcFK4MP3ZeDjBjuarv1OWPtAgURv5Y/wAG/06x10eQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050089
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=69848800 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=dt6k-L5FSP6_vD0C1rIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: XmN8G6whPENdECdgudcDeji_S-oBRGJZ
X-Proofpoint-GUID: XmN8G6whPENdECdgudcDeji_S-oBRGJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5MCBTYWx0ZWRfX9ePFBn+2Lfv9
 6C11xx/d9RdT7+YM2aEt1Lj8la/imzLzlFHciN3Kd3zEEWYHsw5Bl4KNnka3pTRRxk7vJZ1Wowz
 7Ttkazty1J5jfcskSTpW6xfuzz0hPUaLNFjW53CzJQA9s+o8KK7vS+JqgwL6pyhtIJ5M7MXw9RU
 izHVP0cUe8ktrsFK4jVWjhkJMO4kSyfJFo8rxzdjSd799mOvZ04Z6zNomioIetXH7MjBiXwNiPF
 Kr7JQvN2sqohpzg6XsnBZt5XP/s6AvaMKuvmqCI2VbunfG1ZFpxPkjXln8FglHHfyd91SDdTrdO
 sHashrcyb0Enlw/0rPyiw47anv+AAskYRgZR9igiy6IvL96PgX1d5KZL4TUgRCdZxro7aixsqrP
 RsWIH9Q2g0HOj1Q4JBzCSyvtnopeA/8u4OKIPY0WQFec0wtMp2QAZchoTHTbWj1sB0lklYWnjs3
 wXACrZtLPndHv5pAbKassQZNbXozVcTmGSr+8QqU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-76416-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,lucifer.local:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 72295F2454
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:06:10PM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 13:01, Lorenzo Stoakes wrote:
> > On Thu, Feb 05, 2026 at 12:57:04PM +0100, David Hildenbrand (arm) wrote:
> >
> > Dude you have to capitalise that 'a' in Arm it's driving me crazy ;)
> >
> > Then again should it be ARM? OK this is tricky
>
> Yeah, I should likely adjust that at some point. For the time being, I enjoy
> driving you crazy :P

:D

>
> >
> > [snip]
> >
> > >
> > > The following should compile :)
> >
> > Err... yeah. OK my R-b obviously depends on the code being compiling + working
> > :P But still feel free to add when you break it out + _test_ it ;)
>
> Better to add your R-b when I send it out officially :)

Haha yeah maybe...

>
> --
> Cheers,
>
> David


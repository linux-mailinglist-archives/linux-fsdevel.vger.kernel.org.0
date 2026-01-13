Return-Path: <linux-fsdevel+bounces-73504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FCCD1B010
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8CC23060277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826C3612C6;
	Tue, 13 Jan 2026 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NgKvNsqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57335FF4D;
	Tue, 13 Jan 2026 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331719; cv=fail; b=fiDleKI1Oaz02EtPHdcsNyp4gBZUrq9cQ1jyIJJW4y3bvDa75epuibPis25q/PIhu2t9w4BW9Kvkcxqf5ein4tIHE8526bThByzk18rG/GWChmYrfW/4MJPots4s+2L0tHoOeVNnxi0zIVQkZa6YAHcu1b9VI6q0g4bQIftrA/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331719; c=relaxed/simple;
	bh=mPe/hj879nv6plv3fB8bVzgbbgwQ6NQrn+rC4v5A5Qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ijwK0R8C4oWaAuVmdY+QHrf7Bs5C8nn6RVtQo/B/X+dyiRCCD2X9gsywA7NStCAAPfeF2n5s4cPV7zQl0Wgi9CZR9xEiTAZgSI5/UulOVeFZ87etf1a6L3eTH1p87vcyqaZ+NeB1gv3EMngzopAMgjCplKr+Kg3nLSGJeUdUPyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NgKvNsqj; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DHCKgF3978514;
	Tue, 13 Jan 2026 11:14:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=AsVf30z1M4aOwgOIj+ddieqMQF6eWkPgSQLD7JZEVGs=; b=NgKvNsqjxoU7
	dC6Q3Eny1sowVr1dbnKg70q/kfFc3G+MJgWBq1mNUAPZgg307CPgYun+jRdI2sNr
	UYRgn5+qlwB4UVZXz7Po7I+c3UE/1CSMX+U+0VzkBDRSZKsaa79xCJEZoj3RNjGB
	bGYVlMp0T7zTbVRZ04T89XplF23JUKNUVRBMBV4jVO39ShaWWaTHaaPMPmoj2Rry
	NTc9CwaxFwGHjwfh+pwAR8OidEeozsrOY65uz3qLMaYcm417Nm9Lls8TTLbiALZe
	smAQoCBaHIV3+GEElJ+sLN83ubcAU9VGO9CPlDa/DthAg7mZOJRik8ZlkDiZZSE6
	U+AdoygOSQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bnmkg4cwk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 11:14:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3YNsUUVj0Wsv+I4yaXZwO2LnAu3WdH5NLeuEhDGXyBn1/Tt1gwIVdpKc8vMTjW8PMwpzzPSlVTKs3LDrJ/VRYklbrD4r6iEscJe+HzWBr27V3nX8JOcqnWtuJk7/8eOaknT+6GUFrEqM+KZJqwfxDve5UwM4p0x88ASLFlkCI/OxOTmg05ZVgj21qxB6vcfwmNyLkjK/zrE+gcye+7Ha0+xN+xX4NoaPbVVVWlc1nOMyIq7GUfkHb4SCIz+7wIploCLXYOdTxWunbKPDlBdkqHvNXnQ9wG6LRqz1LcQH7H7GUD4olpJB3K4+D8KYTPLWzYKotA1GyegWSYOApYbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsVf30z1M4aOwgOIj+ddieqMQF6eWkPgSQLD7JZEVGs=;
 b=SNn7pyIUd42xMjj1ZdvBXP0EKHJEhomrqXPTMquLj1eB6+O9geZ5CmZaj5Tl3hRcm1BQwmHnOKrP1YHk3Od/X9o4xTT+LLj5KLOotkaDmyeorjZJcSEo8f+CY2GRoK63qasKGzdgex3wJavm/N8emuMHjrNrJXZiUE1Tsdw0aedzAqNZqRiTBp1leQe8UvBaASiQWkeRKdYza5F7ZE9lwnemO4ObEk5ONUuq1oJFXRWv8CaUnAhbie98wQHw7LgiNbh+e859cWgUBFQegh8hxofeffyXl/BE2Ztb2RRWcpm8rYEfhY9ttueTro5F8Q/3vbPXlJ5elITUQkn0rL6PXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB3755.namprd15.prod.outlook.com (2603:10b6:303:4c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 19:14:37 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 19:14:37 +0000
Message-ID: <cb09ffd3-0db8-4db4-923a-f707b4537441@meta.com>
Date: Tue, 13 Jan 2026 14:14:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: declare VMA flags by bit
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin
 <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
References: <3a35e5a0bcfa00e84af24cbafc0653e74deda64a.1764064556.git.lorenzo.stoakes@oracle.com>
 <20260113185142.254821-1-clm@meta.com>
 <0cda6c54-2ab0-4349-8633-e3eea1306e7f@lucifer.local>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <0cda6c54-2ab0-4349-8633-e3eea1306e7f@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:52c::22) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB3755:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7106a0-3074-48ca-192a-08de52d7fe76
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUFuTWhleTkxZTJzOU14ZERXeitxSWg1Q2VNdmErb3FxOVFVTzVWYW5HK1N2?=
 =?utf-8?B?aVRGQ0MvSVVqT1JOdlhkcFo1dWUxOE11eVBtS3VxMTJpTWRwd3F1aUU5TlR3?=
 =?utf-8?B?NndRbDF3c1UwTUdrTXBuUEh3d2lablI4M3VKK3lvbTJWM1N5VHY1Mzl0YnF5?=
 =?utf-8?B?YXNsMkI3Vlk4Nk14c0NRVHpHVFQvQy9KcU10TDZPTitFZUN6WkpGSGFkSzJr?=
 =?utf-8?B?T1JhMzJaYjE4UUUwd3FwK25ubUJsMDhmRzB4RU14bTJuM0ozQXBjSnRSdVdN?=
 =?utf-8?B?Yk14dXFwWDRVd0J5WGVzcXBDRUZCSFMxTk9zT3NOcE8zR1JMZlhCbkVqMVA3?=
 =?utf-8?B?bmtsSUc1R3hjeEtsYkh3M3YwS0VlUWVVbEpSVzlkOTJUODdsOGlvTm9mNjIy?=
 =?utf-8?B?UUk0NEJ6c1Bkd0l1bEpDRW1qNHphd2tQOFpIbnBkK3V4dGV4a2YxS2ZzWDdK?=
 =?utf-8?B?dldiOHNYbUU0dDk5ZU1iTk10SGwwb2N6bGk3bUdGVWQvekRYdmZ2QnNCU09l?=
 =?utf-8?B?aElVY3d1RTQyak16TnJCUVlSWVpiS1FkVGVzTXJXcGRSczc5clY0MnRMRXdo?=
 =?utf-8?B?ckl6RUdwenpFM3ZzUGlITTZTcmhOZkorTGhVUzF5TXhqYm16Smo1TzdlNkEx?=
 =?utf-8?B?ejBpS2Z6bHVTemhjUXNLeWIyaDZGSDNiMWdWdERiTkdOTi82V0YrbkszSEIx?=
 =?utf-8?B?Q1dvdjR3c3NyZndvTkF3L29rYlhReWlMVEFLc0V3c0Vma0FuZWl2dzI0MXhq?=
 =?utf-8?B?eW9SYjM5VDI4bDZHV1JELzljS3dpNXRVZ1Y0VWNXTVlNWXhCZDVRM3R4Ulky?=
 =?utf-8?B?VWFBKzJWcDREZnZxeXZpVXZiMzJCQkJVSE92REMrWWcwRDZaeEZ4T051QXF2?=
 =?utf-8?B?WUJJT2xJb25lbXVDVi8yajJNMFVxQWhCZlNmek5rWkNFL1llcittT1MrTTNs?=
 =?utf-8?B?Rk5TMEJMWEhKbVkxNFZMNm45MC9UTHRoQlFQSHo4K2ZzSnR5VXZwQlBDdi82?=
 =?utf-8?B?alZhQ0J6d0Nia3BOcnhVM3FrdmRodzJEc05nMVV1TzBHVTZoR0kyd1hzaEtt?=
 =?utf-8?B?RTRJMVdVZGduNXN5RUxHdGJtS3p5OUR3T051dnc2aVNFMGN1RmNDbWpoVzhH?=
 =?utf-8?B?bzNad0g1dmMwYVVIMXZGQ1N6Z2FKRGNKZzcwSjdRMUxxMUZaNlgrZU9lSzl3?=
 =?utf-8?B?RWJmQ1V6VGxGUUxZamdvaTdFcGpxWldJMDJCVW1SOFhIdHFDRlAvZDRtNHdR?=
 =?utf-8?B?a3ZHYnVFdndCUmFEYVZrWXNNOHdheitYSDdqRStyRm1UVzZ4UjFXK0JsNnNE?=
 =?utf-8?B?VmxHcXZsZm1pTlRRNVBvOVlISkVEUHdqcW9yL2kycWxTNmpVY0F0RHgrT1Mr?=
 =?utf-8?B?T01kUUlvTncvcW11NTJaeTIzZlRmNHh1K1R5VnpLWmlGanhMRTQyY2IyNkJP?=
 =?utf-8?B?cVdOelJGZ0hiZWtyNFhYMkxNWFgyOHY2Snc5NTdSR0pFU2lXcHZvakVDUzdL?=
 =?utf-8?B?eDhXdHNVa1UwSm1oN05OZm9RNDk5d3FwWVE4N2ZtL0ZtYlkyb1lqMUhRSFdy?=
 =?utf-8?B?MExVL3RwTW5CMDhnMVgrM3BsVThjWmJhdXUyMFhvYmhmZVFDbzM2MmwvSWNY?=
 =?utf-8?B?dFNNU1BqcFE1QjNrTHNSRFZHeisyM0hDRW5jYXROV0h0Z29oY3M2WUplU0hw?=
 =?utf-8?B?dWFRc2k2eXZGVHRjdWdKNGJuWmNsS3FzZEVSVm00Wkp5YlU3LzA3NTA2KzFY?=
 =?utf-8?B?bURMcWhNQm5QSENuUmo3V3hPdkN4V2MzRERVOGZobVg1MVM3RzdJSGZad0l0?=
 =?utf-8?B?SDl2RVI0a0FCWGs3QUIwMnFEY09hSDUzaitpWDg5VXl3MEVhRTVWQ1RCYlNN?=
 =?utf-8?B?aUN1YUpUUW53bUY2bU5va2JWRGswTUo1RHVHZ0tLMWlkU1ExWnNXL2JlY1N2?=
 =?utf-8?Q?hF3jM00QKBVSYhUQAEk/MiAAGhyvcqBV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUh4a05RdzZmTFBDVE5hYXkrZU5UT084dUU2RlRaOVN0bS9DZm04eStwL3JF?=
 =?utf-8?B?NXkrZ2VieS9jUXZrSE5OSXRBa2lDOHdYSDZpQ1NsOG1GeHdkUEJWcmYvZmhK?=
 =?utf-8?B?NTZtOHFGeS9wL1dmQzIvSGxZMisvSFRLTFVDUzlWNzhLaDZTMGorZXdQa2JK?=
 =?utf-8?B?WUhaUzFhYWpReGs3Y29Ici8rVmVmNUdRWjRDOThwMnJoYXZOYnBJUFBRWkcr?=
 =?utf-8?B?UDkrcVY5eCswZ0VCcHZaUUNVdEI1UjlFMVdRYVBVeTV1a0c4TkdscXYvSTVa?=
 =?utf-8?B?cEVQcnJ2eFBJVXZJOHlrbmhVQWljdG90enlaZ0V3QThIWkhyVjJ5a1FYUXQ1?=
 =?utf-8?B?OWI4cXR4MURHSkNqTnlWSk55TERvNmVOMVhsdm5VVFZxRVVUZE14KzZTdWVi?=
 =?utf-8?B?djUyUE5zZG1VTkpQcE9ZelhRTytZTWNTMXFEbm1HbDFQaGlnZStJVDdGTmln?=
 =?utf-8?B?WWl1ZExaMkVLZlcvRGVPVnRWbWFVT280NGNybzRUVWE1bkZIeUdReEFsZllZ?=
 =?utf-8?B?bDQ3elJnQ1RwZzR2dHhPcjJwMWI4UE1JeUk0VWlEQnkwU015bWVhSnY3RWhV?=
 =?utf-8?B?NTZyNnVBN0R4VzNuREZrYlhBUElQRmhhTWw4MThXN1ZTMjA5VmpjMzV1R0JO?=
 =?utf-8?B?UUc4blVzY2V2Nk1GWUh6UXA3UzJLQzFJU2gzZ0wrUjlqSWtCV1l1Z0p2YlF6?=
 =?utf-8?B?VXk3VzMxZjFkNnlRSmI2WFVvYUpNUExqZkxFY2Ixa0xYWCtjTTQxU2xOM0w0?=
 =?utf-8?B?dW8vSjVzMFF4UitmZkVYWHFBdUFyL1JURFhZdHVjRUlhN2JVQTJHbTBGcDl6?=
 =?utf-8?B?ZlcreWg2N09wZS9yWlZYWGdjOWJ4YlNCbitaWjlQSnQyeW9vMUhHdzRndUpO?=
 =?utf-8?B?bkRtRjBBTWU4ZjJQQWZIQ0FPY3F5cHRQVzFmVy95YzVhakRySzVoVS9qL0Y2?=
 =?utf-8?B?SHV5Mk5vTVpsOVdXU29rUXY2MDFoNWFibEJTY3F2NGtwM1hNMTZQemJqc1JL?=
 =?utf-8?B?THNSelg3emVOMWZKOEpsZ1lCQitQMDB5bS9TKyt4MXlOT2lXVUNrWHEvT3A2?=
 =?utf-8?B?cVZWTldlK1FGSEZ6Rmo1NU9DTFFKUmJxWkdkMEZZTlpPVVVWRFQzMVdGTkw4?=
 =?utf-8?B?ZElmVjlVekhhL3pjVWJxSG9GM08zbktMR0luNnRJTmswSFNRMWx2QmdYQW9G?=
 =?utf-8?B?OEVTNlpuVXZ6RTljUW9WZTBHWk01TGszaCtUejU2ZTlZWHhzK1ZrQTV5ZUpu?=
 =?utf-8?B?L3hrd1QwcTl0V1BTSkJCcmZCRmw1VTRpaXJRa3g1V3dzTTBkcmxBYlpkU3Bp?=
 =?utf-8?B?OXJOTUpmWUR6QlBaNHhqNXdlTnlldFlWRlA2NHd2aU9zeHFlNmdZZDBPMnlo?=
 =?utf-8?B?YnpkOE1VenBIYkdManloSWo1VmVib1kzSTlKM0VXUHpwekJ4L1VPdkNtYlhz?=
 =?utf-8?B?Si9YUWlWTjFlWTB2dktoa1VFSlNseE5YeWFDeEs1WU9xQlo3a3lDbGk3ZzVj?=
 =?utf-8?B?RkFSdTJmdzdIM2xCSWRPSldoeDJLeHpzN3ZHTDZvWHZxVHhkVEQxQXVwRk9w?=
 =?utf-8?B?RXpEZ0ZFc01zRlV1ZHUxK3Naekk4WWlyNENrT2F1WDZESGxWanVnMlkyNVhn?=
 =?utf-8?B?a3ZNbTE0cmQ3QUJnRUR3aWhwNzAyVlpIcjhYRU5GRm1jM20zUE9DU3g3Smh5?=
 =?utf-8?B?R0NIeXhhcWFFSEx2VUMyQlYreWhZU0NIM3pieFVDdXZtVUt5KytWKzMra1JK?=
 =?utf-8?B?Z0hya21NcHA0amttdTU5ZEJVeWZxWkZoUlBpQlNPcnhXa1owb2hpZDY1clhI?=
 =?utf-8?B?SlQ4Y3NGVURUNk1nTHdESVZsQkFNSW1leGc2ejVBcEUwZnAxOEIvYXBXUCsw?=
 =?utf-8?B?K29lNk5DTC9Ka3ZjVGMvV052ckszSE5jU2QxMnBFeXFCQlRFQ2g3SmNQM1hZ?=
 =?utf-8?B?ajBldS82OVc5Y3FCcVE3SzR1bE1zUHFmb0txbGluaFNkV0UyaHRlSnp3STZ0?=
 =?utf-8?B?VHQ3QVpFL2pHbEw4bjBLTTh0U1ZXZWs5TEpEZ1NWRW1jVmkyYUtZMXQ0djFX?=
 =?utf-8?B?dmhCYWZFY29DekdIT0ZRUkFsTDdCaHJocUE0VTU1Nnc2L2Z0eDFkY1kwOEZB?=
 =?utf-8?B?THd1MWp3by9xREw3b2RJZG1QNFk5ckdZWmM1Zm9KWkViYnQ1Y3I5bCthYm5S?=
 =?utf-8?B?ak5GaU5mdXhKZ3FQZnoycEk4WXZ6WEk4S3R3R2d0Q2ZCZHd4RTRRZzVOc1pi?=
 =?utf-8?B?SkltWHFhYjZVWHFOMmh1aVNKOHM0bm50Rk9VbEZIcEwyOWQ5Kzg3QnVvY0Yy?=
 =?utf-8?Q?/lbnyhvfGdbOpWOqal?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7106a0-3074-48ca-192a-08de52d7fe76
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 19:14:37.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDJqxfNFXrgrV+RKJYWwWuPiAgvjMwirctHEdbUjizUNGV5t8yAN7zyL8Rog822M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3755
X-Proofpoint-ORIG-GUID: W9ah8FTjwuDFHTGTRhjzFl5iUrJ_tQhV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE2MCBTYWx0ZWRfX+AYaa23FUSGS
 6+HD776qYuLJ1qqElYRnmGa/dUsxsAcB+R8kCpLLxm7e6SgAVhGJQj33vRewhyr7W86HPaFMTu6
 Is68iLaqjP713vW61sbFyykHTUdUIDjGT3/pwS3kSuHNaJyERgdLD4mtcj5ExeyiuhmGhEUCyAg
 nOWoEzoImkAMuJFX22RyOAeFVJoSdNpQ62kMt0KNp0KbIbiPCzjircpxKzBACJi89BX9CLyLR07
 4BCt8NwnUaWv71RtCFzvmj4VhbbVQdC7CtOPKS9qzgFC5CYHFhWVJPvOXFCbhmWR0KYdwySYzBo
 RDD9wZXoplPQxvhuUP8zu0IcPSYURkSCXWi+kEuXXwuEMZA85f63BZAQIGSe9lJujPTTtOxbvGT
 MjipdGjZg0JbfJMHW2h1iFxlG+c21/yDWWmWCmUCbhyuj3wTJg5fOA4+PlvkqroIxES/Wc4Sz/F
 eU8IU46zXwQbEFBl5Tg==
X-Proofpoint-GUID: W9ah8FTjwuDFHTGTRhjzFl5iUrJ_tQhV
X-Authority-Analysis: v=2.4 cv=Fa86BZ+6 c=1 sm=1 tr=0 ts=696699a0 cx=c_pps
 a=n9MmWVbgKLYxIbvHr99TLw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=3gh-2k4yC8mHpjCmYiQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

On 1/13/26 2:09 PM, Lorenzo Stoakes wrote:
> On Tue, Jan 13, 2026 at 10:51:37AM -0800, Chris Mason wrote:
>> On Tue, 25 Nov 2025 10:00:59 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>>
>> [ ... ]
>>>
>>> Finally, we update the rust binding helper as now it cannot auto-detect the
>>> flags at all.
>>>
>>
>> I did a run of all the MM commits from 6.18 to today's linus, and this one
>> had a copy/paste error.   I'd normally just send a patch for this, but in
>> terms of showing the review output:
>>
>>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>>> index 2e43c66635a2c..4c327db01ca03 100644
>>> --- a/rust/bindings/bindings_helper.h
>>> +++ b/rust/bindings/bindings_helper.h
>>> @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
>>
>> [ ... ]
>>
>>> +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD = VM_MAYREAD;
>>> +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE;
>>> +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC = VM_MAYEXEC;
>>> +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYEXEC;
>>                                                    ^^^^^^^^^^
>>
>> Should this be VM_MAYSHARE instead of VM_MAYEXEC? This appears to be a
>> copy-paste error that would cause Rust code using VmFlags::MAYSHARE to
>> get bit 6 (VM_MAYEXEC) instead of bit 7 (VM_MAYSHARE).
>>
>> The pattern of the preceding lines shows each constant should reference
>> its matching flag:
>>
>>     RUST_CONST_HELPER_VM_MAYREAD  = VM_MAYREAD
>>     RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE
>>     RUST_CONST_HELPER_VM_MAYEXEC  = VM_MAYEXEC
>>     RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYSHARE  <- expected
>>
>>> +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP = VM_PFNMAP;
>>
>> [ ... ]
>>
>>
> 
> Oopsies!
> 
> I can send a patch unless you were planning to!

Please do, I'm still going through the rest of the commits.

-chris



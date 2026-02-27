Return-Path: <linux-fsdevel+bounces-78790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBhmIaD7oWl4yAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:16:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E31BD711
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 21:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A640C3038D14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30E3A1D06;
	Fri, 27 Feb 2026 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+404x1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F232D73BC;
	Fri, 27 Feb 2026 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223382; cv=fail; b=HY71ZNnts/O+vSosA2egF97R4HlHKLPKm0vzSJTE8beGm5cCpHgUpL+XQ9V80BJWP4s5BwvMgfZ/zz99nkJ8ZCI0yjkgapDVhmweGB18VPb30qu8mas82bpS5But0ypFjMpdmrjxCXXdtQT3urWVgpcDslaqNH6IznuxY3LEdfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223382; c=relaxed/simple;
	bh=PxDKtNkxS4/4PqhvZIKGdBjBPHAN7+mR0um4hfKyZac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T54sqj1E0tUHWxH4Ke6JhNV1letfjDibnh98rcwxDiib66yK7aGcABxdJ8pQnPJhzuyz0vdMTujoAxx+sm1iqpFbd6ZA8WmkpM6NJJXUZ56ssoYO3+85pRqgllfAcW1ZuVFlV2DV/UuQfXJodm8M8EahbJL3Vb/3Sp4RsXmOmPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U+404x1k; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyMshqv8Etiozi5JzoE7HPOzsUoCvI4fwDV5D7JpqdB/8Ca+jXXGhqyDOCcWZkKskHIIu3PmjvapIENku//LgsEzu1PbLEOusvEsFFGYL6Es2HQRsU1F3I7JreQCbUhBPCliiCAO5MAoJtl2uhNHlIpUdQSb8QkIEK/enyjcLfbjjUYrtjbwDGEIa43nvKfIoUjCyu2Vx1aiezGC41nWvqdrc6W3+tnPHCA37AL92/CoM6xDdlZHbH9BeF3jP8DxgphDTvblOObH5xTOJxsEWHZxRZfNs3TxsVjAJ8szxytqB5f+wInUTM1ZQTDJva8dPdVyGcl5E+3XPFlFsMc2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9JOYYjbloyBgjZl5cX4qJZzOAJeTSavASEU/JWGyfo=;
 b=becHKkcKVh0D6lKvSU7NAh5GNC68mNvPQR+F7JCsNcE6KpddKMbLkUAxNL91+IaMUgKraYmQJu2tT9AZmqLz3p47D2R2NxQ0CfVVuOBLqDdCziqkfeBuFhxn1/8AUuhna1A+qIdCNIuiF8tWBfcbbVS6HU8av12Gc2zXEsDpei1T7tMnEbTHVrmpGdwEypNg8Cn1fkFGkkXnISqsburO3uFx8L79XtlQ6ET2PjHIHKhRwZEWURobwclZbgfjYES3NopFeRc3WlFEzXcH/Vd4B6PAx89oRxdaBTjJoXLSx24ZnhFUOod73drTNng7TO0xjkyJw8iiq0RQkcfm2+g+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9JOYYjbloyBgjZl5cX4qJZzOAJeTSavASEU/JWGyfo=;
 b=U+404x1kqZhjGZMVd6Z8YLGEvAVb2OzxdFbDN6gwbD5QWWkcDkeaci7s+oDvTJ+8WyzG5MzNpAo7yQlDHoRk+sgyi9RGzLaK4xmSlRyGXn8smvIyFMYoAhBlUt4k6NfsooeLK4lQzgSLkEz8UFK3+Ry7heoMLLyuWNBONuvq+PDnqUm9vVRSMmtUOA69sjUlBncQ6ivTEujOejA8sGWUJFuShSveDak5bHIbohhCuamWsdhFsn41nWInhZnLUGPFpioUVBRcQVlF4/hzLMJoEi420KNr5NfVHEOc9PXCUQ2uA+ZUF4HZ6YDcOE15t01POcISyJJ4fiSk8SvSFUCMTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 20:16:17 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 20:16:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Pankaj Raghav <p.raghav@samsung.com>, Suren Baghdasaryan <surenb@google.com>,
 Mike Rapoport <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
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
Date: Fri, 27 Feb 2026 15:16:09 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <4A89F75A-325B-4FFC-AAB6-07C206844B02@nvidia.com>
In-Reply-To: <653e34d4-6356-4f9e-8298-40b4e237f761@kernel.org>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <aaEsOu0hgCUznzl3@casper.infradead.org>
 <8ca84535-861c-4ab0-a46b-5dfe319ac8ac@kernel.org>
 <aaG2GkICML-St3B4@casper.infradead.org>
 <653e34d4-6356-4f9e-8298-40b4e237f761@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7edebb-9194-4852-e689-08de763d1038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	X1BKQPL9ETAg2oDB3xfRICOrui22DsGCZDGo/+sFOJa9Mn8BCl+ZEDOEkoZnHK3ogErMizk0HAroWAQmztbVMgzpt1LGJjwkg56UQU8Lc8lN0DT7bPLUvqtjojrU9riYBKBkOq+uIJolT5B5befGqOoOgqlrn7g5t785d8hAyvUKFmaoWfmjdjNXEaeKNm8baFKsaQazo5ySu0xXXFWe7jAMdegXlMfBQulcztsV5yxkoJ8CFX3gMlVQ5qyI62qhE+smxZKM54Bi2d0WXCMKRH/7Vycnwy5kW1vCIDYAsZs6tlNWmBNxUAcDG1LwDhZuTXgktYQbTyS56Bo9tbIM/SVkExddWgD2dAJu9zCwvE8UxyQsHY/AILuZjM85CmtQIJ6VMtYUre1e9lRpcam6rrqW9qfFIHm8jvMsED7h+Tejo99uxogHePUK2hFEF0ENDzMGMv0R4EuXetebmFSLAkVYXNRxZmnzg4SD+rmDUWIUmNU5JLnF07Ad+V7Zf2HKoOwwMRlsbfSG+q2e4uOiAuMdIi4OazDgCHXmnheOuqw82Cv+tv2gaKsg7TM8yOC1f6b3yhCW6aJaCczBmsDo4i/6a85TFxbSo8NPqy/uFHdDYvqErSAYZBMOHhCjfeli0IYgsbJkpdxu/i/U9fwZhXo18ASeMNusc26KaGPFQ8iq8Zy7LtT91AkNbpY2K0G3HtTgKskwbJlKjzy5OeOusXMVb/SfqawavQT26rOdal8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJsDJ/Vl0HkU1NgjOQb7NNL6HxL/eCYfjwWGPlfnj8BbKoCJjAprmoeM0Edk?=
 =?us-ascii?Q?7gGGTHgTY8pLfHnqheZ7JFlxqHdp47pnHICVJ4ccZSBB4s8M+GNGSqKTh76X?=
 =?us-ascii?Q?HVNwAxiUDEUYC1GUDVIqRLRfMEsn4jdr6DqnEakqE66V+3RWIFmEyzEv25u9?=
 =?us-ascii?Q?cWE4GNmZqtvsqHAnzskzYUX0DDp5TYBfVJiAMo5tDOz63Esc5go7KPwoRI+6?=
 =?us-ascii?Q?KoALZrEKCgotReU9K5CjX4hfHpJY5mEN0kRgsd/a5zPf4YhEX0H/oRecMCjO?=
 =?us-ascii?Q?t679nFVQJ+4U41XDBIIUDua4SBosrioa25+icVEaK5+yVlVFgC4I7HlpcGDx?=
 =?us-ascii?Q?XJbrifFIMjdA+IBJdpS7/KZLTPU78sOkTwASICEGaCtWcjtYl7BOn0b0VYYJ?=
 =?us-ascii?Q?w7+S5RhDWAqznIyznDBfyjsi1iThHD126SuEZ968VJw8qdXA8keIwf1U4Vo6?=
 =?us-ascii?Q?3++fEs+Ju/FLpgxFqJH8vYwToXOyS6rD2s7Hyj4Pwm1A+L3Eg/qSfXQcFOrb?=
 =?us-ascii?Q?RK47qwhSyHblxP3HGWr7ZLqhoHQDjvsNs82f9lHIiaoZSfcja+Ds7M2Q6xk0?=
 =?us-ascii?Q?cDV1w+nMhh0VWIzNjhnNV6ifnviGX6JHiTnOGOZDmF5vLjYLzw7cSsHTGsv0?=
 =?us-ascii?Q?kX3KePFlWpo8MVA++7ZE7+Lzm1YqQuZkdYN/Uw4oR9SXF8N21AU8TgKzEOLs?=
 =?us-ascii?Q?apIBi+fcsbaT8DhXxbAWXNjRof6IunRTpCTv+oZSCpEX/bSsdBXi9mQLH4kD?=
 =?us-ascii?Q?tUBz/VbVzOSM+9mSiqyZ8cED/t59LnRIO41R//ndfBaUN57mMoL/4Yctcq+B?=
 =?us-ascii?Q?VLhPk03EBJQeBLudQZ0pRDKBR0Y+Q0NBi3K5almyNx/s/ihU0Bh7qt4WPk2V?=
 =?us-ascii?Q?IWmETEZ3I9I7ZFkEGS0Eupdc+qJAYpKMRRTYaFcOMd07mTSNVyd5/UuLV9E5?=
 =?us-ascii?Q?967G2cH5Wvia3c6pc6owf+CxVRzg9GhCuCJRFEdrHQtGlMpajT1Tx01bvl86?=
 =?us-ascii?Q?xTa7FhwzvFqM0ZKhm4UZjWhjr7xsuDGAX8yjCexc3ryXO4DiWc8pk8/O427d?=
 =?us-ascii?Q?4fGuOdh/oVhhErFTq2UKWq52WFlBCj6vp35URSBEQEhZvxaEUqIqVQQlrhsm?=
 =?us-ascii?Q?qPcnwSFAJ2EyJfwPi2Zp6zFaMCo2Wta9kaXPR6rqWbK6haBgG1cja9ULkco6?=
 =?us-ascii?Q?zdQ5/rJLM4/kBC0tgbRqHHxLG9O4oQfjF9vqNeII7axAfp3JYn0qR35zHfgH?=
 =?us-ascii?Q?c6xYc078SPMc0ihHRHCIZYJSPro4atLOXX1XMwKTLNbrAfO6MUS8NCtgBiQJ?=
 =?us-ascii?Q?cvX74KTzpXXuE5sRJMAmJ4aNqTRb+r2gceNSMQha8+KG3sfk0G1mbdONQpKI?=
 =?us-ascii?Q?XzcD7liF9jq+G3g72TSwJcHbXWuFrhdpd7+lvDY1pJ4bc8p/xr6ryeoY8mtv?=
 =?us-ascii?Q?6qlf/CE6QdD7uiVxe4B6EApoWvp3Uma0hMwOKdbuupfQn1/iWpksozBIKbQA?=
 =?us-ascii?Q?t3uTkZfAnaPulntwmdb6fur7wwudGTsfoi+/t5KXoZztbxZ2yrjFfv24ip/H?=
 =?us-ascii?Q?qonlmaTyr/6ldmWBzCRzhUe9jNuPfv//ihAYJkeQylm63R+bPfL5E/jEB0xj?=
 =?us-ascii?Q?15DHt3HCbuCPPTXSF+yTBEt+yZ7bzYcUyekgk0bZtGI2ELe3ia4wxbuviNJR?=
 =?us-ascii?Q?lh9N1IeVnpFIjvBZNumAFBsPx3BiHCVLVrVee/Ca32hEBgQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7edebb-9194-4852-e689-08de763d1038
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 20:16:17.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubXioYmg3TINbUdMgbOPLj16kyzqtpDuz0+jeG4XyL4+vLfJYqiOXK8HlK9CHxeq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78790-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 000E31BD711
X-Rspamd-Action: no action

On 27 Feb 2026, at 15:10, David Hildenbrand (Arm) wrote:

> On 2/27/26 16:19, Matthew Wilcox wrote:
>> On Fri, Feb 27, 2026 at 09:45:07AM +0100, David Hildenbrand (Arm) wrote:
>>> I guess it would be rather trivial to just replace
>>> add_to_page_cache_lru() by filemap_add_folio() in below code.
>>
>> In the Ottawa interpretation, that's true, but I'd prefer not to revisit
>> this code when transitioning to the New York interpretation.  This is
>> the NOMMU code after all, and the less time we spend on it, the better.
>>
>>>> So either we need to reimplement all the good stuff that folio_split()
>>>> does for us, or we need to make folio_split() available on nommu.
>>>
>>> folio splitting usually involves unmapping pages, which is rather
>>> cumbersome on nommu ;) So we'd have to think about that and the
>>> implications.
>>
>> Depending on your point of view, either everything is mapped on nommu,
>> or nothing is mapped ;-)  In any case, the folio is freshly-allocated
>> and locked, so there's no chance anybody has mapped it yet.
>>
>>> ramfs_nommu_expand_for_mapping() is all about allocating memory, not
>>> splitting something that might already in use somewhere.
>>>
>>> So I folio_split() on nommu is a bit weird in that context.
>>
>> Well, it is, but it's also exactly what we need to do -- frees folios
>> which are now entirely beyond i_size.  And it's code that's also used on
>> MMU systems, and the more code that's shared, the better.
>>
>>> When it comes to allocating memory, I would assume that it would be
>>> better (and faster!) to
>>>
>>> a) allocate a frozen high-order page
>>>
>>> b) Create the (large) folios directly on chunks of the frozen page, and
>>> add them through filemap_add_folio().
>>>
>>> We'd have a function that consumes a suitable page range and turns it
>>> into a folio (later allocates memdesc).
>>>
>>> c) Return all unused frozen bits to the page allocator
>>
>> Right, we could do that.  But that's more code and special code in the
>> nommu codebase.
>
> I guess I'd have to see the frankenstein folio_split() to judge if it is
> really better :)
>
> If it's really just about skipping the unmap+remap the end result would
> indeed be nice.

Without unmap+remap, that is just __folio_freeze_and_split_unmapped()? ;)

Best Regards,
Yan, Zi


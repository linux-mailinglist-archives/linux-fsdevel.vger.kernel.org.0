Return-Path: <linux-fsdevel+bounces-57627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577BFB23F7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F0C58365A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 04:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628F29E0FB;
	Wed, 13 Aug 2025 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Pq8QcDdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013006.outbound.protection.outlook.com [52.101.127.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263A8462;
	Wed, 13 Aug 2025 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059060; cv=fail; b=dizwJFCnbFux5e7w2Bf79r3EP4oy45MNkLxLrwwDJZoFgM1OnCSaAujndJ8jzizL5rf0Gk7M0vb/UbzPDM/D+eCWZ9x6sKzWb+Iya5EXozbq+xPUzHJTp6CIKxLlmLK4DrxG2Ayqrognf2SGTNU1/jaFv/jTSYo+bFgtJXK1B2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059060; c=relaxed/simple;
	bh=hF0roeH7RztSpyB4pvvQ3MrSFsv3ItpYfhhM4OAd8tY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mqfHzmzId7PJOi/CzmAusdARhoR/Msb3kGkpGklLRg7UC6eNyIV0djCI0bP+mWjx7g4PhO4sFnsy08ZlBBliLvQxd+YCOwY/64uT6McLtlboGrtPKP7SQcova9ZVWG6Alvl2/+riu7QXR3WGwmftvxUM72XTB929Zti3fNwRD7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Pq8QcDdW; arc=fail smtp.client-ip=52.101.127.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow0JwOUQrkxOkLvRcNR/n1nrB6kYVX4vLYu3TtZxRcYRO38xzPxHWLyef7+1drapXEgXGnU1/8nNRJ9mQyJQX2qMx/lyvhyf69w/lnVD6xz2b4oS5gfIA5KHN0yCkvfoQzw+CK5OZB/XMLp57QvqalcasthjcWIXzgMGGUsOgOCk5NmNbqSnH5phLwcKSK6wknuIVkS8xHVYZJo3I8VWlCcnPUsgESjqm+TVGztS2C0vP+6VJT3h0Ndgm0iQQvVE5pOvQXIdBiTv6lvsl1bgzSdU9ks8Ztd7L+RkHQ2nEBkm2ARNEDd51Gpy48OvxwCcKPTJdt3GV/hjphUQPqgBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMnuWgkxfpx5fdWr0sbNpU2hCL8M+HiwUdCoyCjWQG0=;
 b=Zhlr21CEtS4nliUw6uFgYZrZ7Qxzl3ZnkvOK1QveZEVZTGUyBEp2Ig6OrxTJXBVNoR2d8yVeB1XdzuV/Ou1FWohy/TIMHtUSy7zgvWqSBj9gMoyANakYcMaQVX4GWEKUmAM3ArpqLmnLD30kVZJuXuKhVxv/ZSoyjsVEdsDl6rs+NOx6aZntrMwxmHqwhVdSx0urkdGZDZEJ+4YJrcj5mSxy/mIQK+UdO4mPOlzEMyTe1wH7+HI2b7wSjUlHKKXTlav+cOEbsNlvQDFc7RDiWoGVXxQyvMov0qDRbnkyu5E63NtqQlRI4r1mUy/zVO21eaqX+knwWgVgbNBl6Dix0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMnuWgkxfpx5fdWr0sbNpU2hCL8M+HiwUdCoyCjWQG0=;
 b=Pq8QcDdWsH20xbjV2hoEsdrfXi9C0Knm9xyb84WH+jMQPzFlf718Due4OxEv80hQ4cNwlwWsmz+1yEAgtNck9FW1eJYka+lBvTK9+QI87QYpdecvYQUkfjKWE3UzcmNy7xxdysWct3oUjdd44DGNCSFUVyhj8dSzh169x4Ekzcecvm+s/PB3g6ZZZl9jMoCjeLlvXfZ+XIN3v5iuIFwivrKiEQp5qK7J4JlPA0EIMd/u5MIE1ZiNga85DYlv0MTPUuuCe+H3louLSq6ST6kZB4L1mMnZdqXAKga4C2hNtGMdemuf+zd2s1NgWVjtWv2CEfJzK4/3Mkdi7npTa6PK8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB5575.apcprd06.prod.outlook.com (2603:1096:101:ca::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Wed, 13 Aug 2025 04:24:11 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 04:24:11 +0000
Message-ID: <a45c7775-a6bb-413d-9cb9-e871288a8f72@vivo.com>
Date: Wed, 13 Aug 2025 12:24:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Content-Language: en-US
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
 <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>
 <aJt__zOHjGcaghNf@fedora>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aJt__zOHjGcaghNf@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB5575:EE_
X-MS-Office365-Filtering-Correlation-Id: 480304b0-3609-420e-db20-08ddda2140ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkVYS2pwQ2ZiWUp5d1I4c0paT0NkcERtdis0b0d3RDFmSGxjc3BCSlJhU0NG?=
 =?utf-8?B?NS8yZlRHTXNvNFkyWFROdEwzRnFVdzRHOG1BT1pLVk1NZHhOQ0oxTVN6MkxR?=
 =?utf-8?B?UmY0ZFpSOHJoTWhyNlltS1lIZXhERU1hdEpaZkpMSUtjeUlTYXV3S3ovRTJQ?=
 =?utf-8?B?U1BNYkdNalgvWXBZN01YTk1Lejd5NDlQQ2p1TGRiSkp2QmpzQndhTjJ3WjM3?=
 =?utf-8?B?V1lCbkpMRG85dDhPeXozVzU0REhmNEZhM0JKTEFSc1RWTHpUMGpUamxaMm9P?=
 =?utf-8?B?Qk9ZQWRCeWhTdWhGWjRnSzdvZ2VQMmZ3YXYrMVp5MkdLMk0rN05rQnpWSmFQ?=
 =?utf-8?B?WHpOYUZ4UDBDZEpXZUtTcDFtL2pwbHRSbmlhbVR2WHlWYWlWUW1wMFJ1MDhu?=
 =?utf-8?B?cnkrSDFMcTJMaGNsMzl0dk15QzZvcGJWL1FMcERlcEFLUFpienllVVdIZUwy?=
 =?utf-8?B?YllsU0NXbmt1Q3lhbnNzNzcvM1ZydGpEWXJPMkNSM1RIbFhCTHFSRE9BUXFT?=
 =?utf-8?B?WmVUQS8xN1JnQXRBYWZUYVU0VXU1ZCsyakozclNtQ094SlVWK1o0enJtWkMv?=
 =?utf-8?B?aXUvMzhZaEdZNWg0Rjh2MU5odTNCYnBxWWJybW9JSythWUo4ZUIwRTRISVBZ?=
 =?utf-8?B?cVVQcmlvWFFLcnV0RDMzVjZsL0ZqY0JOSVVuQWtiTGg0U1dreGwxbVNSOGhm?=
 =?utf-8?B?Y2xzbk93eFVpR25NejdJMHF2dm0wNFdYbzIwSVd3OHMxcWdJNEZoZFAxdHJa?=
 =?utf-8?B?bkRST3VrYXhDNHRjaTYwcTkzak16TkRzTzQwRXV2WksxS0hBNHorK2hHRzAw?=
 =?utf-8?B?dFJDd2ZLZVBHM1JTNGdFeE43dlhWcWUvR1RFZnNwUkxubWQ3TjY3dFZYSmpP?=
 =?utf-8?B?eWRaYWNWVDIwWkk2bjBlUnl0dDlvR1pHWTJLRVBNbExqSS82OUtOWEhSYksw?=
 =?utf-8?B?OHdHaDFsREtzQU8vUHNFNFZoYU5xTDdsRWlWTGZ4Qzg1c1RKdmdoeWZwR0xr?=
 =?utf-8?B?ZmRNaysvMmw1MlpVNHByaUxvUFZQZjBmUkREcW9EYy9PUXVGVnkzQStLMC9x?=
 =?utf-8?B?ZGhrM3o1ZjlFZjdVWDBSQUhKbk5sSXN0cmtlRGd2OTNVK2ZYcXQ3ck9BTUpH?=
 =?utf-8?B?WERhOXdWMUZZdVV6azM5bVdweUNHWkhGYnl6ZUpBZkIreE5vK09ReFVnOUpz?=
 =?utf-8?B?YlpCTUpjZmpySGIxL2d6SlE1Z1hxeGF4WVV1eVBTaUYwZDc2UjBmZTJCR0dx?=
 =?utf-8?B?RURQOHZESVFEYXJrUlBMdlFzUENVVUdrdFZuWThkb0QwZHFUR2t5cDVTNUR6?=
 =?utf-8?B?SnR0V3liNTlReHNFMHFFbHd0NG9WSDg2eXNoTlBLQ2htSjVxWjA0SVRkZCtv?=
 =?utf-8?B?b0w1WUhCa3gyUUVwZHdnL2ZLa2V2WHY1K25TTldNWVZXcHo0ZzNyZHI4UVow?=
 =?utf-8?B?Sm9mazA1NFhIWmM3RzQ4b0Q3YVpOdXNDUnlHb1hicDFYQ3hqZXkxNWlnYVRm?=
 =?utf-8?B?T21JQ1JGbDNDeXI0eTgzYS9sNWt0OW15Y20zN2pjVVJGdWw2ZmpNaklxcFc4?=
 =?utf-8?B?MUxZSFZZTllTUTlsemZ5elhXbDBRenlZQmVWMFJlZkdjWDVPRUJLaHJzNUo0?=
 =?utf-8?B?T2UzTWlFVEJWd1Jrc0tzcktaNjRVcHRHaGd4UzFkb3hiQXNQTmdUenRPVE43?=
 =?utf-8?B?ZXF5R25CTWU2d2RRVjcveVdNVks3dk1wbTFxQnk1R3V6ajZZQ1E3TUwvR01S?=
 =?utf-8?B?d25QdFV6VmdOc2hWQnc3Z252YzZrWHBQTm1KaGgvV2lpUzdFQjdqQ0RzVFUr?=
 =?utf-8?B?ZTdvcFdyL20zM0RjNGc3UnlpOFlCNG9OUWFXVFZONm9wY3FFQTMxTWl1Wnd4?=
 =?utf-8?B?R0RiTDArUldCeUFzVUVZMHJRUE44RCtTSmdlaE5pck1JZHBqUGZWaTgyeHR3?=
 =?utf-8?Q?qo7dxRRb6yM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU1EMVlWTU1GV0N1MGN5ZGxjMWlTUWs3L0dqWVo3MDhhNnZ0aHdHUGt4ZGtu?=
 =?utf-8?B?QzJaZXA5NXR2ZTRsNHV5TlJvYmVQZzhXa0ZMN01JSWFwR0V3MkN0UmdlalRG?=
 =?utf-8?B?VVQzeTgzTlU5V2JkVnd1VXBvWW9INDIxUlJoWG1YN3A5ZzA5dWVPUm9TSGNU?=
 =?utf-8?B?dytiMmh3Z0R4MDRQK3gvaFFVQ1BEWnF1NnBxZmZqRmR1dTBydG9HRGFsTzVa?=
 =?utf-8?B?WUZTZHd6aW1PSklBSVdHUXhKMmozb2ZVblA5TFd5cklZU3hPTGVTaU12bU4z?=
 =?utf-8?B?SjRRM2FSMU14Qzkrd0F5RXoxYmN0TkdkbEg2ZzhwekZ0dzlkTlNub0xCQjVK?=
 =?utf-8?B?Z2xvNk01WWJpSXpxZHhxL2gwVWNiOU14R2pqYjd6US9PYURmaHlIOW4zN25X?=
 =?utf-8?B?eEMvYXJIdllmWTNQZFRUTWNsV2N6cnF1QTRkSzFYRVdBU2xsVk1wNWdoRXM2?=
 =?utf-8?B?aWM3QUI4ZmF3anMreDFOTTh1Q3VKeUc5Y056RlpublAzclpHNFR4SFRRUi9Y?=
 =?utf-8?B?eVp1UDJJZmQ2cWV4aVc3ckZMSnFTMlNEampCNGdZdVJXMGVoOEZVakMxZ3FH?=
 =?utf-8?B?QmpMdDBPanNWWk1sU0puL1hhajFFcmRTZTVwUzVlMWppdG5tcTMyKzEvOEpk?=
 =?utf-8?B?R082ZFdOUTlQL0NRNHBzWjAvcTNsT0F0aFJKSlhnRGdCSFljbTVvbFRMRUpD?=
 =?utf-8?B?VmpoMkRWeE51VFpGYnVPZDZYUzlDaWFMb0ZiV0hUWWNnOXZ2SHYxTzIxRXBr?=
 =?utf-8?B?Qktqd0Ixa3NWRW0zVGtPOE9EYit3anFQZy9ObEpXNmlUV2s3UzRjcEJQRjNZ?=
 =?utf-8?B?SHNhaWpxYUYyQnJWc3BMRDMwN2JUOExhZ0FpcUFsdzVXMEtnQXBhckZka1ov?=
 =?utf-8?B?WWNvb0NMcHdSS2plWjR4RDByUFI4MkwzczdEdzEzZFI2VnpKbkxLY2M2S05v?=
 =?utf-8?B?bG5jeWFrc3FWWXFrbUJwOWRWTzhhKzI0NWx2a2dVUCtSdVd0d2JoMlIyeEF6?=
 =?utf-8?B?T2x5K2IyOHo5c24rZ0hPOW14SStZMi9FckxML3llMzFaaXdnUVlkV0kxQUw5?=
 =?utf-8?B?amdqMDNGL1RKNVlTb3FqcVY0YjR3RkNLT25BUFZRQ0xQREFVN2ozMWtzc2py?=
 =?utf-8?B?T1VtYTIzdzdLc0N6N0ttZmIzbkEwdFBqamNsZHhSbnVqaXlxUUhxdGRIQWpV?=
 =?utf-8?B?YkFudTBzYWxmTVRrVmRQcElWZTdJRXhLejc3dVNac20yNktjNnJOVXNlWU5h?=
 =?utf-8?B?TGNEM1JXOTI1TzJ3d2ZwUkxHY25qbVc1S2JRTzA5L2JMQllZeHZDUENPdzRQ?=
 =?utf-8?B?VUlWeExQR2U3bE4zZ1FnZzcrS2U4NjJ5WHBPT0FuSUNKYlV6TmtISEtkQnl4?=
 =?utf-8?B?Z0VpVEoxL2NYM1luTEdLa3Fvbk8yNXNQYkhhVzliWTdibHVJbVd4c0wzNzJ0?=
 =?utf-8?B?SGM0RFdPWCsxZGQrTGhkTk9QWWs4TmxpaW9vUWdGZWROK2NCdWcwSERBYW0r?=
 =?utf-8?B?bXljdktvUi9DKzZ4RWNaRHkzcjFrRWJlWDNrbmtXM1NQazhVSjBwYUd3Rnlp?=
 =?utf-8?B?RHZXRXF5cVFHcEsvSit2QURmM0tPNkdnV3BFYjNRbGVjM1JNc05YR245SVBj?=
 =?utf-8?B?d2h0NDhsT2dhWERMYWhDUjFmWmQxcWI2cmNvNU5LQjNSWEVLd2F4dnBYNkls?=
 =?utf-8?B?SlRKU3paeUpmc3RWV1NYQjJGT3NrckJ1bFJ3UHVIclpqSEtsS01ndThjd3I5?=
 =?utf-8?B?bksybVlBaVlPMVdWbWNkYWFyY3BzTkRFUXFocFNZcHQxZ2RXbTMxRGt5Uzli?=
 =?utf-8?B?b24rNnl1NmFtcnRQSGNTRDN6NXc5RlYweWxWK2MxWkNlRWdyQU40cGdCdm81?=
 =?utf-8?B?SGQ1Y3dpTXJTM0NuVGFtUUxaY3pna3FNa3Fxa3Z4c2R3aURkVDJ2L0xNaDh0?=
 =?utf-8?B?WVgxYzNNSEVaZTNWRUE3bHpTMG02aExydVFQRVJUeEFWYnhKekQxMGREN0sx?=
 =?utf-8?B?U3BycUVrSVVqeFA4REJESndDVXhKOTBNRUdFd1VuVFhFdHRtVmdnVnZEdlU1?=
 =?utf-8?B?MVpwSGRTZGNGeVBoQ3ZLL3p6Yis0TFFyaTA1dXUwanl4dFBqU25HeUNVT1Ra?=
 =?utf-8?Q?1na8zmbFgXReQuZwnwGQRvzSp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480304b0-3609-420e-db20-08ddda2140ad
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:24:11.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2lFYgpHvkVZPkL15n4HZ6eJ9uxMQKepoNWdD8kmrCEPgMJryEfQYsoeQmol2tjIhFtZV8j57GX0iOGb7bAzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5575


在 2025/8/13 1:55, Vishal Moola (Oracle) 写道:
> [You don't often get email from vishal.moola@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Aug 12, 2025 at 05:46:47PM +0100, Lorenzo Stoakes wrote:
>> On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
>>> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
>>> GFP_NOWAIT implicitly include __GFP_NOWARN.
>>>
>>> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
>>> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
>>> redundant flags across subsystems.
>>>
>>> No functional changes.
>>>
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> LGTM, I wonder if there are other such redundancies in the kernel?
> Looks like theres a lot left for this specific case. At least 48 show up
> that are spread out across subsystems when running 'git grep
> "GFP_NOWAIT.*GFP_NOWARN"'.
>
> I think they should be cleaned up in sets per-subsystem to minimize
> merge conflicts, as suggested in the commit mentioned above (16f5dfbc851b).

I agree. I submitted similar patches for each subsystem separately.
It may take some time to see the code merged into the next branch.

Best regards,
Qianfeng



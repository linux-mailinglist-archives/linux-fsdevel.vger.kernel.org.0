Return-Path: <linux-fsdevel+bounces-64734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6615BF3445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 21:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B967F4FD4B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB012DE71B;
	Mon, 20 Oct 2025 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gpjGNTTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81888244687;
	Mon, 20 Oct 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989579; cv=fail; b=svFt+VOkcmh0TYzt6FLEn5EURrm5CPu95hD7jHlOjWqWsvUOPtqxQYR+hhLdAjwmZNOIP27nYXMDYVxAK39nkkLhnFyMPrrz0TzQD2j1BD14gfmWYEqqvQCfAOUSbZjmHcA3GYc7MCtaYWEC5biyrZmF+WSSz93VxOffGePgICI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989579; c=relaxed/simple;
	bh=m4Bko4vIM9LzCLX3mHQk/DoXaEN1POc7dmIzDSZr6RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1O6yDc6iQyfBqs6pBoa5vCY1mlanVzac/D3zGUY/qEKzEr6lgG4dwXzF0EdoLN1wjCPfhEBUFVFJf8o8P28AL5/kARFsDN0qhOY0YZg1tNlH6CCJT3sGmSneNFJutVrfv6ojiweCuW8oGyHXtxhdhVLLlU77GTR0P5cd2Pn2jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gpjGNTTA; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFkNgpRpJVVzP+YnxhuDu1Q2UE4/eB5FV9Gg8ChjrUxrGKQ0kHC0mrM7NpM6xIV6PYTQ9wVYzSLovcsw9Z+mAYfYW7CrS7b8nJrH/gNvkX4wFlN+IldiKDgLDoORTJtBSweUqnlilhC3Mbr1W6q6FB35/alKL0/FojHRsvhS21neUnT3W3XhnuO2R6oWoZ2L8OPtezo71JjJqAilAm6dYueAeGccI0Ywyb2eZdmpVOl4LAfzGcAdd5XsnYrssgGCCJ7/6WcETkl3HpNtCDDPB/HRukMO5q9zAPokc+50XiSV5Im9X+LVm0Pp1PdSz4u/CtmhuxoFh33PuPYaMJs3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=absvRlc17wSFGW4+XS53j25qkzYl5ue5UWUDWJJSn3g=;
 b=ys51n3/lcH3uKtMDGgVCeGYc/fJ9DKu9WXh3NRGAGLoHKkcy5HA3bOilE9nOPLq5pNWTKVgq/FxKALGCg8UcAQGnOObFLWmXh6wt3zrVijPWTgDBwXIvEr8UOAikln5u1q60Ut2WwwZuID+dOBAN0slN47x0y6YofJigSJH7GeXqmBc3Cj6vqoNTcJVAkg8Fcaw6E6zVhXpQDb2O250tz5kdXPuVPG49r/me+7ZwNc1fz8REw7dO2rlFjDLK4Mbln17lVGfkUKnoaJ/3per5SG6HhlKLCGpO/wcMxUwmq2cLhnuec+jW1+bEsOY371R2Nh6b6LDBauUqEGORjND8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=absvRlc17wSFGW4+XS53j25qkzYl5ue5UWUDWJJSn3g=;
 b=gpjGNTTA5sg3Oo9hiVeoSb0CCK6Fvm8+J7h3ViNv/4f7SMbnOVNgsvUcQByiNw9YVHiGYizM/vyrnpN3wPDjKMQKoH2v862UvgzTuHkr0H1hWFmwA8zEDT/jE9nFx3cqqI77dbua5AJO26X9cB7M9MR0+5R6/nt+xC+SXv7xiQSWZaa12qOcDrrsMuoBQyuo+a+/noW5RKQoBDJFOFaCseLQhAHipzjw75FK4VIZIdHRgeg7P4OFeTXrS0uiYCuGx0QRnivuLhkleie5zEhhZTv7lvYjUlkM6tanelqE98psLcb3SW8zS7gf2TdA9AVVaZyjyOjIMbijWwakx2YGKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:46:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 19:46:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yang Shi <shy828301@gmail.com>, linmiaohe@huawei.com, jane.chu@oracle.com
Cc: david@redhat.com, kernel@pankajraghav.com,
 syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio
 handling.
Date: Mon, 20 Oct 2025 15:46:07 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
In-Reply-To: <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0059.prod.exchangelabs.com
 (2603:10b6:208:25::36) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 255d2ecf-6523-4860-9930-08de101151ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmhudkJBeWdSS0pvNkROUEh0SEV1RFNZOTNud3JuUzNrNys2S3Z6ZzJCZ2tx?=
 =?utf-8?B?M29ZNEZ1UDA2aGVJRHJXeW5NMFIwSmRxS0ZETUlRbmVzVjBkVm1VdnRXV3VM?=
 =?utf-8?B?TzU5VnBiQTkrUVhPQVo4aVZXcEZOZ1Q3OExkdlBDM1BOQkVZTFk4VHFtbjRn?=
 =?utf-8?B?WjlaNDdXYnRJOWFpSC84ZkVORHhsWDJ6WjhWdmNCSXFYSnYxVUpJbmRiRmNR?=
 =?utf-8?B?YXVORitQVXhVcjBkZ2h6QnVhd3hiVkcyZlVHY3F4SHFGYWk1V3pkY2xmMVZR?=
 =?utf-8?B?QXV0M2VPVFZvU0RXN3BLU0hLSHFidUdCSHBSaGk5Q2lSVTRzTUF6T2N6UktE?=
 =?utf-8?B?cHp1VTZKRzlWNkZRa1BWUlpYNUZIdGxuaU5aUzdGd0lWSzlsUWlic2dQWE9Y?=
 =?utf-8?B?aEFJV1ppWitsZlNUMnNJUWZCRm9HRjBaWmoxTzdTRGtud1ZNeEpvbVNhd0J3?=
 =?utf-8?B?SVplVDBkdzVuWDEra0RURFFiZ0s5emFlRU5PY3ozZ25MMFJVbGJwSERaRmZo?=
 =?utf-8?B?T3lrY0N6WlNxZzAvekgvRHltYWVjQVk5K0I1dWlreG1NL3FUbElnWmQ5L1Bu?=
 =?utf-8?B?cEVhditjeU1ISC9CRFppVCtxWlk3NnpsbXNPSEF3OXJhV2tDNlk3ZHFoODZE?=
 =?utf-8?B?RnlyaDIvWE5BZ1hoalNVSEV0aTdaWjV3Uk1obTErdGRWeVVmRmM3a28wYXFa?=
 =?utf-8?B?QzRaRlpKODcyRVhpVUtOMGppc0Z4WURrSmZiRkhweXZqVm9IaHFLKzA2d1RJ?=
 =?utf-8?B?WElRKzVpK1BVRHorRmF4NkZsdGV2b204bC9sRW5ueFhMYWc4MGJFS3QxNHNP?=
 =?utf-8?B?Q05nc2NkYXJyeTFmQ000Q2pMM2NKQnhBR29lWVhlMUtPay9WWE01ZmFpTkIv?=
 =?utf-8?B?T3Y3UnlNdStLMm1VaFl4NEJxMnVrcG5jNWNFSE9RSEV4eXRldVN5WmtIMG9I?=
 =?utf-8?B?ZzJwMjZQZWJnT2dXODJLalRINUVDc0JjKzkzY2VBQW10aDQ2eWtxckpWckhs?=
 =?utf-8?B?T1NQUno0V0RwcDdmbG1Ma3JVSVh4eDMwNnpYSjNUWlZ3TUFmendOREYwWnl6?=
 =?utf-8?B?dDIrZ2xjMzExeEIzL3pzRExqejE4c25FUjlDUllXSnpSUUJCRVNiWHFjS1VX?=
 =?utf-8?B?bStrOTQzOU9ETDRyaEZLQWtEMGl3KzdXdzRTeTdOd1hYM093YmxhYVQzMjJR?=
 =?utf-8?B?MWVGZGJOZlhRYkhLYkFQWGVZRWhiQzBNdmEySEhGMGNYMHYyaGNqamthRkgw?=
 =?utf-8?B?R2toUVlCcXVIZ3dEN056cXhrb1ZTbGFBL1FVN0VOQmRTMDZzdzRnaUtGMWFi?=
 =?utf-8?B?WlJaaWZ4d0E4Vlh4d3lqSTVacnEyemxHb3l4SEJnQ08xQndFbTRoNEdsdUtr?=
 =?utf-8?B?ZWppaXorb0ljdkp5U29KdS9XcmwyWGxSQnBsZFYzSDF2QmVPeC8xSGY2UnVm?=
 =?utf-8?B?QnpTeVlFcGordlZ4ZC9udjdDN01JUC8xWCtJVTNzY1NxaTVyanROUFUzNE5a?=
 =?utf-8?B?dWg2NkZqRkJXOGt4anFpTUtnUEVCRDZwREg1ZE9iOGdnZUxYc2ttM3pZWFJw?=
 =?utf-8?B?enE1RDNScnc4Y282ZzRkcnNybVM4bWZwY0NBQmJKdDZkZUtlM2Q0ZGFQTUpo?=
 =?utf-8?B?d0tQNDc3aDBuOTVkbnowbVNPR2JmbE5FVkVCbUh2bWtZVWs4U0tjb28zSEty?=
 =?utf-8?B?ekhpUTBuTTd3QnBtc2h4UTNFbEFLOExkejhiQ0krTWZLRnQydXAxK1VTSHhj?=
 =?utf-8?B?UlhTcmI4SnE5bnovSEw4SHdZODFYelJBdXRFN0tjNHE4bDJ3V3hpL0dldSt5?=
 =?utf-8?B?R3VubGJmYmxuUTFLbkRIZnhKYVg2T3pxYXZtUjlCVTlJaC9pQVFHQnpCbnlr?=
 =?utf-8?B?L3FiemtIcVFMbzVzOTJheWFvTk94L3p2YzhSb082WFVlcFl6Yk1qTzNyem5K?=
 =?utf-8?Q?+tswlfgT2SO+F3GaH1o9VCxtPlKSjXNd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnhYb21NRmI4R2lPTE85WFlLZGlBZW80RjNMTTdXQ2FjZXZVNlo2bGw0QnFK?=
 =?utf-8?B?ZXRBVnplSS9uZ3gwbEF5NjdtOTY0ZlJKcG9UQThTd2t0YmgzZjViaHlzdEdv?=
 =?utf-8?B?VnQrN3ZNL1ZaSURhT1RPMytmbXk4ZXRsYlJyNjVsTnp5aVdaM3dnOVFCZzJa?=
 =?utf-8?B?YSs5MUxEa2NXMG1NU3RQQlVUUXBibndLVXE3ZjhEL2c0L21tNjQ4NUFscHBL?=
 =?utf-8?B?T3FqZml2NVlRdzBxRXM4bWVqdmpPeXZwQ3Fybno2ZWJqY3hOdm5BVDcxcWcv?=
 =?utf-8?B?SjhLRktsT3JCbWhrL1ZZL05wblpwcnNTem9mZmZibUVKajNhd3J6MlVjckFO?=
 =?utf-8?B?ejcwT1pmbExEVWo2Y1dWQ2MzVjZLK21INmdQSGxBOTczcC83dzZVNENhRnZT?=
 =?utf-8?B?d3JiWXNLZXlkMGppNHVjNGdNQ3lMTDJEVkMydWxWdzZkUk01VDg0ZVdSMDNH?=
 =?utf-8?B?eWIyTWdkbWcxMTMwQ1hkRWJPZEtJcTVoNHpQdnYxMFJqRXRkQlBJSVlvVzdV?=
 =?utf-8?B?KzhOSWZpT2RzLzZ0cVNzeG9XSnJPeTE0RnRaenVPZWczeXltTThJNVJiYldn?=
 =?utf-8?B?bHl6eVlVM0NFUmlFQ0ROSjFBYkNiQWI4QmJNTVYxZUxUUjNXK3NPM2t3c2d5?=
 =?utf-8?B?RW9SMnhETG9BajFub0dHY0RDaVluU05iRkUvZ1EzVGp6ZUFvNnpOdGJ5aTRz?=
 =?utf-8?B?czhXQkU5VE16UkptTzhudXBnSkhlSnNUN0s5dUdyTlFvY0FpSk5jVmFkaitQ?=
 =?utf-8?B?U0ZYYzgxVG5lSkZjUExlRlluVFRncVdyVGFRdGNLME5VVTVLU1RTVkN4eWtO?=
 =?utf-8?B?ZUQ2QW1KaFFidjUzNVUvQmpxVVhidDBKcmgvZ2c5dklzQmlPUUdQTXpqL1FI?=
 =?utf-8?B?OWNrOEw3eGs3bk9VSWo5cWMxTFBrV3NZOXNlTlJvTDM5aG5ud3hDZHVpSnNu?=
 =?utf-8?B?L0EvNXhyL3FNUXNTbWhPNHptTk1HeTRibXlna0NjM0hZa3ZHeUVhdDNxN25P?=
 =?utf-8?B?OHpNZUFPZUM3Lyswd2hDS29rYzNzb0ltdEszSFN1QW5QRllVZlFIeHYzMWZT?=
 =?utf-8?B?My9SVjVmREdTM01XWUJoZmZKT3B3UWs2WnlWR09ZcEN4MXpZbXlIK0lzN1hh?=
 =?utf-8?B?cnBXTVJUb2FPSnhtL21xN21JYmNFNXdMbi9oMW5JcEVhWEVqRkF4Z2ZSTFhT?=
 =?utf-8?B?VHlhcDZ5K1FWbDRvRGQwaEZWVjd2QXhoZ2pRSXlubHRDdWE0ZlRLYUZ5cXhK?=
 =?utf-8?B?Y0RzRHB6OEZvaGRPVUdaVWVnMllYUjBtVW1Pem5LUHYyZjU4U1UwcjlwVFZq?=
 =?utf-8?B?S2lvSGR6YUxZSHVvUDd1UjA3UzYwZUJaKy9HMmUxUlNYWXVCZnNaQ2NNTXNm?=
 =?utf-8?B?WUxmSHlERERvYjlFK25jb0psRDlSTWF2QnJZTzZncTZYbkRPRXk2V3hzUHFa?=
 =?utf-8?B?RWthSHRUY0hCU3J0VUI0Q0VNUTZkY2JyOERVR2gwWGFZL2lHSDVjWUJkbnhq?=
 =?utf-8?B?YmRDQ0p3Q2VsQ25HSjhTZUJyTktYQVNzOVdhcmtTTWt5UGhnajNaMFdaVFR1?=
 =?utf-8?B?bWJnOXVsWi91SDBFRGVvUS9raldaWWdXZGpLeG9qOG90YmMvcHBHSUVFMkpt?=
 =?utf-8?B?ajhuMS9Vd0daUW01Z1NjeDRPWFFlRmFYTmRFaU1mOHlFSndPT0l1TFZDWGtQ?=
 =?utf-8?B?UllTcGlHdmtZNm9IOEhUaXFUWWw0Mzk4QzJhZ3lEMFVjTVgwb3V2eXNQWUZs?=
 =?utf-8?B?RVlOU2RFQUFUM3RZa3ZKREpzNzl5RVhEZHdyN0ZzOUVBRDBLWWg0Rno5Tmox?=
 =?utf-8?B?VERObHN4VENCaS9rUnk3am13TjRia0NTWlZyRkNxbFZvYm8wWUhHOUNqQWJR?=
 =?utf-8?B?ZEdncU9RVTljcnk0aStxRDI4YkVFZGJReEhsZWYwQXZodVZGVW5OcjRGKys4?=
 =?utf-8?B?TldTU25qQ0M1cDdydlBnakJRYVJOSW1nODZxa3Y0Wk5SOXFJSmUwNDlTb1Nr?=
 =?utf-8?B?RzluQU1NVUFpVXVmMjIwSkgrcGNDUDRybXRFTC9yK3hIaHBGUUh4OHM3WjJT?=
 =?utf-8?B?V3ZSRDhqU1pkU3lLYlVvRDRTbWhHb2NkbjM0VHIzUjN1emVuZDRrR29BSlli?=
 =?utf-8?Q?xtbgDAaC3O72WGi2emHe+7qFd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255d2ecf-6523-4860-9930-08de101151ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:46:10.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2b2ewwcshfzyd9aMjU4/SFoYN0+eVp3hqQKn34EQ460wUnrpjF+QNZUBncba/vl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

On 17 Oct 2025, at 15:11, Yang Shi wrote:

> On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> Large block size (LBS) folios cannot be split to order-0 folios but
>> min_order_for_folio(). Current split fails directly, but that is not
>> optimal. Split the folio to min_order_for_folio(), so that, after split,
>> only the folio containing the poisoned page becomes unusable instead.
>>
>> For soft offline, do not split the large folio if it cannot be split to
>> order-0. Since the folio is still accessible from userspace and prematur=
e
>> split might lead to potential performance loss.
>>
>> Suggested-by: Jane Chu <jane.chu@oracle.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>  mm/memory-failure.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index f698df156bf8..443df9581c24 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn=
, struct page *p,
>>   * there is still more to do, hence the page refcount we took earlier
>>   * is still needed.
>>   */
>> -static int try_to_split_thp_page(struct page *page, bool release)
>> +static int try_to_split_thp_page(struct page *page, unsigned int new_or=
der,
>> +               bool release)
>>  {
>>         int ret;
>>
>>         lock_page(page);
>> -       ret =3D split_huge_page(page);
>> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new_order);
>>         unlock_page(page);
>>
>>         if (ret && release)
>> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
>>         folio_unlock(folio);
>>
>>         if (folio_test_large(folio)) {
>> +               int new_order =3D min_order_for_split(folio);
>>                 /*
>>                  * The flag must be set after the refcount is bumped
>>                  * otherwise it may race with THP split.
>> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags)
>>                  * page is a valid handlable page.
>>                  */
>>                 folio_set_has_hwpoisoned(folio);
>> -               if (try_to_split_thp_page(p, false) < 0) {
>> +               /*
>> +                * If the folio cannot be split to order-0, kill the pro=
cess,
>> +                * but split the folio anyway to minimize the amount of =
unusable
>> +                * pages.
>> +                */
>> +               if (try_to_split_thp_page(p, new_order, false) || new_or=
der) {
>
> folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
> to order-0 folios because the PG_hwpoisoned flag is set on the
> poisoned page. But if you split the folio to some smaller order large
> folios, it seems you need to keep PG_has_hwpoisoned flag on the
> poisoned folio.

OK, this means all pages in a folio with folio_test_has_hwpoisoned() should=
 be
checked to be able to set after-split folio's flag properly. Current folio
split code does not do that. I am thinking about whether that causes any
issue. Probably not, because:

1. before Patch 1 is applied, large after-split folios are already causing
a warning in memory_failure(). That kinda masks this issue.
2. after Patch 1 is applied, no large after-split folios will appear,
since the split will fail.

@Miaohe and @Jane, please let me know if my above reasoning makes sense or =
not.

To make this patch right, folio's has_hwpoisoned flag needs to be preserved
like what Yang described above. My current plan is to move
folio_clear_has_hwpoisoned(folio) into __split_folio_to_order() and
scan every page in the folio if the folio's has_hwpoisoned is set.
There will be redundant scans in non uniform split case, since a has_hwpois=
oned
folio can be split multiple times (leading to multiple page scans), unless
the scan result is stored.

@Miaohe and @Jane, is it possible to have multiple HW poisoned pages in
a folio? Is the memory failure process like 1) page access causing MCE,
2) memory_failure() is used to handle it and split the large folio containi=
ng
it? Or multiple MCEs can be received and multiple pages in a folio are mark=
ed
then a split would happen?

>
> Yang
>
>
>> +                       /* get folio again in case the original one is s=
plit */
>> +                       folio =3D page_folio(p);
>>                         res =3D -EHWPOISON;
>>                         kill_procs_now(p, pfn, flags, folio);
>>                         put_page(p);
>> @@ -2621,7 +2630,15 @@ static int soft_offline_in_use_page(struct page *=
page)
>>         };
>>
>>         if (!huge && folio_test_large(folio)) {
>> -               if (try_to_split_thp_page(page, true)) {
>> +               int new_order =3D min_order_for_split(folio);
>> +
>> +               /*
>> +                * If the folio cannot be split to order-0, do not split=
 it at
>> +                * all to retain the still accessible large folio.
>> +                * NOTE: if getting free memory is perferred, split it l=
ike it
>> +                * is done in memory_failure().
>> +                */
>> +               if (new_order || try_to_split_thp_page(page, new_order, =
true)) {
>>                         pr_info("%#lx: thp split failed\n", pfn);
>>                         return -EBUSY;
>>                 }
>> --
>> 2.51.0
>>
>>


--
Best Regards,
Yan, Zi


Return-Path: <linux-fsdevel+bounces-43523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD68A57D39
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 19:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA18E16A255
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57221D3DE;
	Sat,  8 Mar 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="il8kTHMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712A21D3CE;
	Sat,  8 Mar 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741458985; cv=fail; b=JkcGpCmAxQCa0mkJ5FEoe+LOnjggXUcfzsCfO7AuYmcRpNsbtOsMPAPr1sfgpMOGayKgtcUQnApWtzWa3fgnzLl2iQeAPQHG0k/JjObrgJE+iEqEjbw6uIG2qRB6SXcnLwo4x6mPoCpBqp/iSDIjl3eNsrvP7mYYIHPbSWOznEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741458985; c=relaxed/simple;
	bh=amAr45/3j4TsmrIv5eL3cP0K3WGWOPwo4LbIyiy6/LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLn1dHetB0onRTXJqL4ocqFW7CGTAVLNpTU2enPZiVl4m5yEXFTAG+tYW2B3jtXX0/x5Mqk83x0zLY4TXgFawqXdjbPsPofFIbpsBXuY641sIqXQvPHMW5gxlVPDiamXnHufeaj4UROaRPZ/KnEsfy803u1GkTK8CkZe5ZgEzrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=il8kTHMo; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XToPjAaSWjOXP3y0iV9esQGQbB3w3Pq4iiVrAuxJXDTh7QSiaiJsKjOaVQSprW9nSHYVwC1D8cMfjpczKrPYV1NxkE5Tq4NoJng1kazmzdgiRdeYeSkN1gTpPSjaqZbYwMko9GODp9u7RDSlYW/gILqhG1KBAt/cpI6emFd/423mu0otmz4qrrUwy5beNfRotmpEVrvzemCPxPSeF1Q0xJXFRmZoht8vJ7yJOUVz3CI2q9fxVzvZnAwCdDOUSDbHjHiL2yLtR4JM3mhGiStN1I/JYq/p+s7p1fcW4wOPq4YfsImxMTMKL7SR4OC+1Bt+8/atPTnuB0QXdoPEFnKDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6bwOQ4fcE2Gd9TnCzJoXZuekx1doe+rKwhHpoXlT3s=;
 b=b15Xk5yfIRli5hRV11/UrcmyKB31TPRICGP5vQbgO+BQIuuHXlTBxSjdSww/gQ6E74zpjeqWb63SzvDCoRcygHelrcYPejJASVWKxKuDOzIuZN3TERgUCbe0llxAC69hA/b+SQB0EyVAp43tDFBNKHj3JbLdNJRIyOQ90NcA/567vNXwMVBlD2T54fGJGB4WIAvHxJkuFBPtkeXEz1Et6kWahEoNPd/OJBRH5g4MaQnyUy/wmxe4r77nG31Dd6qjB8mZnFrFkAQAAeuJL5MCvcc1LPAi+iVjA1M5FyNSTWsJ/K45cnsAQJ+Kc7CQryKyJh1ifao2Mg3CViAeo3uhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6bwOQ4fcE2Gd9TnCzJoXZuekx1doe+rKwhHpoXlT3s=;
 b=il8kTHMo9j8g1rc2prwFReaSn/RB7DZ+b1TxAKo7O0pbyONiwvhOwBWwZonj3/AObF8UMtAv1FINhppQKAq4cgODwFPIhtvOy1pPnrC+T3W0tpY0CVKkvh2d0LtIh6W8H7Gb3dquoiwykVyFm1/D9PYZxpiphOmtI0p3+BP9abaz5aIBKRooeZf9gXOKxo/tLX1t/22XzYX58dPJaOXJPzvyZZin5gAIZDbQJ3b3RdC/wKbQUESA8K2xE2ILYotKUGkgjpmXzp98CZtJAlGE4fV86a/yh8flfSkUjJCP1+oMS55RFoTpsP8w20iRJI/+yA48SJ7AFJxSQA/Y9FA1HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.23; Sat, 8 Mar
 2025 18:36:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Sat, 8 Mar 2025
 18:36:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, Hugh Dickins <hughd@google.com>,
 Kairui Song <kasong@tencent.com>, Miaohe Lin <linmiaohe@huawei.com>,
 <linux-kernel@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Yang Shi <yang@os.amperecomputing.com>,
 Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v3 1/2] mm/filemap: use xas_try_split() in
 __filemap_add_folio()
Date: Sat, 08 Mar 2025 13:36:17 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <AA7EF097-625B-4795-AF73-4A8509B3833A@nvidia.com>
In-Reply-To: <20A1553F-C30A-4D93-8A43-011163A22C60@nvidia.com>
References: <20250308181402.95667-1-sj@kernel.org>
 <20A1553F-C30A-4D93-8A43-011163A22C60@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:408:111::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: acdf92f2-3afd-424f-19fe-08dd5e701e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjNFQmlDUW0xdFVZODVRWS93TDAwT0FNNVFRR0dGNnpWa3FwcmFIUzR4aGc5?=
 =?utf-8?B?ak1meGhXenZQL3VxeU1UR1hyYVdIVGtaTzVvR0VVaHZaK1ZVd1BYWDlEeWhy?=
 =?utf-8?B?Q21zUVRYc2JOaE1HVUIzKzkvQ1RVSUNyRVRGb3pQUTR0RnZnOGNWZVpWRlVC?=
 =?utf-8?B?S09Tc2VWdVd5a05JOVZTUjA3YmVtV3dQRkt1alliWm41NVg3RHNmSUsxa0JC?=
 =?utf-8?B?dGVUb0xlMGJ5eHd3bXRSRTk3QmFPTk5na0xVb1luOHRKamtEaXhJWFoyMGp6?=
 =?utf-8?B?ZzJLWXQwei9KRHdtWTNnZjl2ZncvK2lxUEgxU29oM3dqYnNWd1BOUmhjZjQ1?=
 =?utf-8?B?S2xVeUp1VFJXQ2orMkoyeW40ck1venVRa2xyYnQ4UFFsQWt1amFtRW1SSG9y?=
 =?utf-8?B?bGFJK3JSWUNiUUJuT1JBbjBuN3FKbGpJVHdVNU43Ri9nd0NHMUJGU01nUFI1?=
 =?utf-8?B?QzNScjVWTDM2UW11R2IrMUxTRVgxUmtsR1BQWU5NZEhjRGtaLzlvaW10TzFX?=
 =?utf-8?B?SlZSeEhmV2ZKQWZTSHluc1pBS2xldkIwU2tYUzZhU2thOXZUYStlSXg3Q2VM?=
 =?utf-8?B?aE40dytkc25MRXEwWmRwOTdGdnJpWEF5R05LSkxFc09PTHVjQ0lOcmt2UGFG?=
 =?utf-8?B?bE5kMEJLeHZjRnN4eXdsSU1uYUx0cjlTMkRvTjhUL25yTURIaFFkTkRTbTV1?=
 =?utf-8?B?REFSVXF6cEJ0MVk2TFJCZkM1TFo3RW5SUi9kSjZzbDBmUzdwdXZENDhrTldN?=
 =?utf-8?B?QmFJTUt0cXRRWk51S2s5LzJrK1ZoV1ByamNUMCtUR2pvVFhDYlJGUUtYcjYr?=
 =?utf-8?B?TVNtMm1QbVNXMnA2VW82blBlQXYveTFYdm5zRGdOejA0WVdldFdsQUNrRWNu?=
 =?utf-8?B?TzJCc1lKaHRyVUhhVWJGRVJTR0ZXSHJWSjBRQVNrdFc3SUJ2cmdoVnNKVzNJ?=
 =?utf-8?B?QzhlcFNRZzdoUkhsM05PbzBsQllGa0VUZkp5OE5RU0QxMDRRV2VRdmllSHZ0?=
 =?utf-8?B?Z0hMNERPbmIxL1E3cE5wWUxQclROSVZYQW9JRkUyeEZaT3BWQ0VLbVlXV0tX?=
 =?utf-8?B?NUNzdS9Yd0NaaWZqeklnOWZyOGh2Ym5zSXpSakExd3ZwOUFDNFptc3ZFV0l1?=
 =?utf-8?B?TnYrRjB0ZnZNM3BOa0NEY2tFOUc1UEtDYzhOeEt4bXJvZERNU3Q2SVBudnRO?=
 =?utf-8?B?c2ovRzlXWDhOU25NQ01salUxOHZYbms1MDVoWUVzZlVqaG93UlNKR1JpNzEx?=
 =?utf-8?B?OU1Wb3dwYmtkbWpFajRPcVExWmVmak45NzZENUdmeDVXejU5ZVJWOGd3RWFS?=
 =?utf-8?B?K1NPYTdtRmpncG1oVXhmakhmaTFVVkpzNzdaWUVyYXRqQ3Q3L1kxK2Y0cnJN?=
 =?utf-8?B?UWpNVzc0SlQySjh0YkxXdHhZb3ZGbGxCb2lUWGYyWWJOZ1lGWUhUMWkzWlNx?=
 =?utf-8?B?dXlWZ0pBb1NKUHczWlQzZUZhVVlKN0p4RDFUK0V2VDhiVi9PQzFNc3Qya0RW?=
 =?utf-8?B?RTBTNWFsQW84aWZJWVpySDFmYWIxdE0wV0dnb3h4aDlQTzByOFE0WXdQbktE?=
 =?utf-8?B?YkRLaGRLQ2VJVVR0V21sSGltWmQyTGd0cUZ4VUFQM1RBUUtYczdlMkhSZ3Q2?=
 =?utf-8?B?Q1ZOZUZHckFmWEtXUnIzb29sRWJGK2t4WCthai92MDU5OUpsNWg2cjBIaG9n?=
 =?utf-8?B?ZnA0djkwTXByYzd1SHRneXc1cXpTVkhGL1J5Nkl2QzhvcHluR3FNdGJ6Vkt1?=
 =?utf-8?B?M2NzcWF4N1FqUkdCNkZQVHdvdzlFSGU5SWlDcTVsK0NPcGpmZU80dkNUQUU4?=
 =?utf-8?B?V0hMSkVSSUZtcFEvWlVWZTlTZGpaNXFzSW9FVDRDZG9MZnp3SVRhWnZrYWhE?=
 =?utf-8?Q?L5ngrWCLXP14C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ems1MDZxbEZLQ1ZYOWFoL1dnbXgyd2Yzdng1dXh2SW1KRVN4WDdsRlVvVk0z?=
 =?utf-8?B?UllGSSt5cXhLVVhnakRFQmJ5ZmNXR25WeWFRQ0NZWE5XOUNXNXRObHVHZEFU?=
 =?utf-8?B?eHF5aitpaVJzclJsQTlkOHlxZ2R3MzdxQWh2Nm9uV2o0R0RJamhDUksxbGZL?=
 =?utf-8?B?ZEc0dUo3ZXdJZ0JMa296VTdqTkllanl2RFo0RWtRV0xmalpwSWcraVNTQTlM?=
 =?utf-8?B?SHVjSjNhK285aUgvSzlPWVU2TGVVWWt4WVg5d0dwWjg3ZGpjUmFnV3gzK0Qy?=
 =?utf-8?B?U0xYbU9nNjJ3eXI3Q05Ka0QyTm5MclZuN0NLZkFIR3ZPcVQyQjMyOUFIVnVt?=
 =?utf-8?B?RU9oUkE3NHNMdWJIOWJXeThYWWJwTFRjNHRHUmFSVWFUQjVWaUpHVjdHZFJ3?=
 =?utf-8?B?RjljY01rN2FZUHBvRWJCOS8xTU1qQmlJR3N1VzVZbWdTM0k1MUpPYkVqT3Bm?=
 =?utf-8?B?eDJuTDZxS2RDRkJzUHJoTzZaSjNnS2FtRERXL2JKMlE2VWlGMXJPS3ZlcjY1?=
 =?utf-8?B?NzFhc1RaTUVhZTh6N1JKaUsyR09MV0xTQWIyT0Q3bmplazRDdFpxTnJ0cm9w?=
 =?utf-8?B?U29DUGpLNVZ3NU0yL3p4dkovU1dpV1NkM1VOaDVJemc4dUJVQittS3hlNzZR?=
 =?utf-8?B?cFk4QkVxbmpFQ2lPekd2RVR3bEVtM3hzallWbWh0djJRaHFYYWNyamRXdXRZ?=
 =?utf-8?B?enRycWRvVUw0YWRiajNTOVdDUGxSMTNlVWxybG9nZzk0eVN4aWZMSzJZdDZj?=
 =?utf-8?B?YTIrVjI5VlI2MlJQeWFKK0FzV29rYmE5VkRHQzBnU28ySXA1dWxxWVJFTFpp?=
 =?utf-8?B?Zy9TSUhJQXZvSzJLTUZoOG02Z2xGM2Y0YzJIQ0lJeERzbm13eXc2U3pYbmZF?=
 =?utf-8?B?bTFNekxIVjlPTXZtbkxRMExBVlpyYnNnVUp4WWUzMmFVZDdXaGR5ckltOHZt?=
 =?utf-8?B?VE10VEx2Z1lHbm9WZmxvTVNJVlAzd2U4Q1B3QlR3V2pIVER0RSsweW4xQTQv?=
 =?utf-8?B?a21pU2V0eDEvRGlqeUtETkJ0cXFNcS94bHBGc0huL0RGaTQ4REV6ZUVxZG1E?=
 =?utf-8?B?VVZRTGgrYWVIajVneFdXZUtQNmw5SXJZSEYrZjRVVnlDT1d3WlFnbnJRb3BO?=
 =?utf-8?B?eFdDT0xySDZJbDM4eHFmSDNJK1Z6ZzFlaEEya1VOdm1TZlhOanZ5T1ZkS0hL?=
 =?utf-8?B?dHN2V2xXQ0U5S0FnNWsrNjhaUWZwWFpORDM4dnhzTDlCNjdDZTBiZzF6d1ls?=
 =?utf-8?B?NFFHUTBUc1U5NlpENnhxeEZHQ245eS9VTXljSmthYnNTRXJrMyt5aE44VEtj?=
 =?utf-8?B?d3BYOTE2WTJLNGJYZDcvQXM4MGIxOHJWcEhHMjdGaFJIa05FUGNmak13Q3RL?=
 =?utf-8?B?VElTTEVYaDUzZHNFRUpZZWVRaG1qTXJhUUhvaHYrQi85YnV0bGIxaitDaEdS?=
 =?utf-8?B?NWhKQXdFRlc4cy83QnVnRUNkbjZ5TXlIQXgzZnVHeWZ4cDlwc2ZHOGhVbTJ5?=
 =?utf-8?B?Ti8wOG9VNUdUa21rU0wyUUZJSE82R0lCQzZXWkpqdy9SWDJ0TzU2MmZkOUR5?=
 =?utf-8?B?YnM5REZGUGdCeUpIUDk1WHVkS1FpRW9ZZnlndDRQektWVUwrdkx2bnVranA1?=
 =?utf-8?B?RXdHeHIzeXRiU3M5OExLRy9BblA0NUtpMWdWR1d0NUpnMUNteFRiSEwvYktv?=
 =?utf-8?B?U3YyMWI3WGdzNUlSQ0l0dnFWNG5XSWZneFZTRi93R3laTXF2OTZUSkZlalRl?=
 =?utf-8?B?VnFXNS9lTDVHRlMxUU9nYWhnd2RhVUQzOEdGTGRkcHZQL1JheGJzNEpOUzMx?=
 =?utf-8?B?Rmo5ZHNjQ3JESGQ5S094cXdQYit6WUZzbnRJS29MUFNWK0NINmNDOWltWitk?=
 =?utf-8?B?MVNwSDBDVDcyY3IwR2F3dnVDdzBiM0YvKzhUdU90bVp0Zk5hOGwrMHF6U1gz?=
 =?utf-8?B?QytSNW45ZSsva1l0b0lTeG9TUnRLOWJ1dGR0S2s3NUN1S0hHemZYLzkrNllS?=
 =?utf-8?B?OXkvb3V1ZDFTcUZsclpzT2lPNUhMTDBqSWk0eXg1MWJIMXV3NVNDSXBIYWFv?=
 =?utf-8?B?bldzTWRTRlBxV1ovdURMaUxOYUZsZm5YV2h0NkllUjRlZzkzTG90dGxFWjNp?=
 =?utf-8?Q?/vwM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdf92f2-3afd-424f-19fe-08dd5e701e5e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2025 18:36:19.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhZlHwe7puH+rYFR6wqP2m1KwIiGXr31SMbMhamhlSCM3C0yXLTqizLidkH+rLaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

On 8 Mar 2025, at 13:32, Zi Yan wrote:

> On 8 Mar 2025, at 13:14, SeongJae Park wrote:
>
>> Hello,
>>
>> On Wed, 26 Feb 2025 16:08:53 -0500 Zi Yan <ziy@nvidia.com> wrote:
>>
>>> During __filemap_add_folio(), a shadow entry is covering n slots and a
>>> folio covers m slots with m < n is to be added.  Instead of splitting a=
ll
>>> n slots, only the m slots covered by the folio need to be split and the
>>> remaining n-m shadow entries can be retained with orders ranging from m=
 to
>>> n-1.  This method only requires
>>>
>>> 	(n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT)
>>>
>>> new xa_nodes instead of
>>> 	(n % XA_CHUNK_SHIFT) * ((n/XA_CHUNK_SHIFT) - (m/XA_CHUNK_SHIFT))
>>>
>>> new xa_nodes, compared to the original xas_split_alloc() + xas_split()
>>> one.  For example, to insert an order-0 folio when an order-9 shadow en=
try
>>> is present (assuming XA_CHUNK_SHIFT is 6), 1 xa_node is needed instead =
of
>>> 8.
>>>
>>> xas_try_split_min_order() is introduced to reduce the number of calls t=
o
>>> xas_try_split() during split.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Kairui Song <kasong@tencent.com>
>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>> Cc: Mattew Wilcox <willy@infradead.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Yang Shi <yang@os.amperecomputing.com>
>>> Cc: Yu Zhao <yuzhao@google.com>
>>> ---
>>>  include/linux/xarray.h |  7 +++++++
>>>  lib/xarray.c           | 25 +++++++++++++++++++++++
>>>  mm/filemap.c           | 45 +++++++++++++++++-------------------------
>>>  3 files changed, 50 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>>> index 4010195201c9..78eede109b1a 100644
>>> --- a/include/linux/xarray.h
>>> +++ b/include/linux/xarray.h
>>> @@ -1556,6 +1556,7 @@ int xas_get_order(struct xa_state *xas);
>>>  void xas_split(struct xa_state *, void *entry, unsigned int order);
>>>  void xas_split_alloc(struct xa_state *, void *entry, unsigned int orde=
r, gfp_t);
>>>  void xas_try_split(struct xa_state *xas, void *entry, unsigned int ord=
er);
>>> +unsigned int xas_try_split_min_order(unsigned int order);
>>>  #else
>>>  static inline int xa_get_order(struct xarray *xa, unsigned long index)
>>>  {
>>> @@ -1582,6 +1583,12 @@ static inline void xas_try_split(struct xa_state=
 *xas, void *entry,
>>>  		unsigned int order)
>>>  {
>>>  }
>>> +
>>> +static inline unsigned int xas_try_split_min_order(unsigned int order)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>>  #endif
>>>
>>>  /**
>>> diff --git a/lib/xarray.c b/lib/xarray.c
>>> index bc197c96d171..8067182d3e43 100644
>>> --- a/lib/xarray.c
>>> +++ b/lib/xarray.c
>>> @@ -1133,6 +1133,28 @@ void xas_split(struct xa_state *xas, void *entry=
, unsigned int order)
>>>  }
>>>  EXPORT_SYMBOL_GPL(xas_split);
>>>
>>> +/**
>>> + * xas_try_split_min_order() - Minimal split order xas_try_split() can=
 accept
>>> + * @order: Current entry order.
>>> + *
>>> + * xas_try_split() can split a multi-index entry to smaller than @orde=
r - 1 if
>>> + * no new xa_node is needed. This function provides the minimal order
>>> + * xas_try_split() supports.
>>> + *
>>> + * Return: the minimal order xas_try_split() supports
>>> + *
>>> + * Context: Any context.
>>> + *
>>> + */
>>> +unsigned int xas_try_split_min_order(unsigned int order)
>>> +{
>>> +	if (order % XA_CHUNK_SHIFT =3D=3D 0)
>>> +		return order =3D=3D 0 ? 0 : order - 1;
>>> +
>>> +	return order - (order % XA_CHUNK_SHIFT);
>>> +}
>>> +EXPORT_SYMBOL_GPL(xas_try_split_min_order);
>>> +
>>
>> I found this makes build fails when CONFIG_XARRAY_MULTI is unset, like b=
elow.
>>
>>     /linux/lib/xarray.c:1251:14: error: redefinition of =E2=80=98xas_try=
_split_min_order=E2=80=99
>>      1251 | unsigned int xas_try_split_min_order(unsigned int order)
>>           |              ^~~~~~~~~~~~~~~~~~~~~~~
>>     In file included from /linux/lib/xarray.c:13:
>>     /linux/include/linux/xarray.h:1587:28: note: previous definition of =
=E2=80=98xas_try_split_min_order=E2=80=99 with type =E2=80=98unsigned int(u=
nsigned int)=E2=80=99
>>      1587 | static inline unsigned int xas_try_split_min_order(unsigned =
int order)
>>           |                            ^~~~~~~~~~~~~~~~~~~~~~~
>>
>> I think we should have the definition only when CONFIG_XARRAY_MULTI?
>
> I think it might be a merge issue, since my original patch[1] places
> xas_try_split_min_order() above xas_try_split(), both of which are
> in #ifdef CONFIG_XARRAY_MULTI #endif. But mm-everything-2025-03-08-00-43
> seems to move xas_try_split_min_order() below xas_try_split() and
> out of CONFIG_XARRAY_MULTI guard.
>
> [1] https://lore.kernel.org/linux-mm/20250226210854.2045816-2-ziy@nvidia.=
com/

In addition, the new comment for xas_try_split() is added to xas_split() co=
mment.
See https://web.git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/li=
b/xarray.c?h=3Dmm-everything-2025-03-08-00-43#n1084

Something went wrong when this patch was applied.

--
Best Regards,
Yan, Zi


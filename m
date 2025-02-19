Return-Path: <linux-fsdevel+bounces-42078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22002A3C496
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 17:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8339117CA36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8A1FDE01;
	Wed, 19 Feb 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ESyNew0q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04AB1E8331;
	Wed, 19 Feb 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981415; cv=fail; b=RTRJDiQY0vvz0N5pTTfMrrtAQ/3n+koIFVn3bmh52GkVvmOyBcCKdN7fE1Anbtja9KI3++sEkhCSlFSOPg4Lg0qmNZeBKSFTT+Ybh9AORUu0+JlHW2I5k92ZRSgHaIdIzWrz8vwPocnhh2CyVXvb0k64yDoRPCag+A/yrlPP24s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981415; c=relaxed/simple;
	bh=CC42GAd+nbLDmr+eqxsQ2p3sq8fmjen1MtHDdlk3Jwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLndGxP/GvDJ4cu95omKL5le0wb+5NyzEEFRPswjiZdgdrrjYd+rcmjBeQyGbJqA596rQQhESWC2Ue/0MGJFwnU1Yz+XwgPGzXi1vn+oUX+arUyAts5w43rpZIi1X/MF8KmGKaQCESdwUQqIDvuVOo5qXn6R9Cv3WTFoxNqHcVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ESyNew0q; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/5GDCT/0AiZhB6s3Q4+71/9WNy9e8wuNlTQUCGY/aVQhxtmJr+vsv9pnLqopLFkdZ2eihkRYuQSNP0pxl5PucV3YqJvRFHP1z4wVoHklc6TLLhkbGEgdn73js62oAwboCRya7UdY/VsFNvGu9Vcw9yjKpglG1dNZStZGN+uWFwbf/NEkEoOl1oIUu7iC27oAXvwO+1b+sBY8ZwhCBdhA5pqZfbwZM8fBpmOy3GOq+sC8CGf3GiMmyc4n0ddh+YrYv9cKrDncrvM58BoGn+cM579sVyJskDHD7bvYKIEmKTLSNefxtYHLoaOGGFc9kOPCM+UoGgqkI9d1qlZK3cRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ5tyjJJNqWe/AI04BAGvxkdflkdXm/tEqrmwBIqPOY=;
 b=x3DjVHxuRKHEcqVSas2NH9T7GnLZ9d5c0C+u1FKNduIgxyBbcsJZCC0kiN9XuPAs6Dii+NRgFBZ3LttmNvX6yMv/j+SX/FBW1lNaRfW7D5l7E3x3TG9XeAm7Ywpx2MX4+OMmeQ9QbONWjLCKC3ZmIPxKVjIW7IuYFr5xbVD54VYLjAG1+EG13kd72oLFaYwUIGNe4jFwovVFp94jInuu96/oLOcS9DvyKs9TpyQz18n4FYHf8XE3Rs7NnaCFaSr08pgQsQTdlGWfryLPljMGyiTaiOoh8XmE8t9VSH9KjopzQ+dHL1m4OJo8kTwBwsEAYjoNi0JqH8lZUg+LqB5naA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ5tyjJJNqWe/AI04BAGvxkdflkdXm/tEqrmwBIqPOY=;
 b=ESyNew0qrqcQrcp+ME4J0/1xCgyv/RS6QaIz7oph664vPBb9UOSFDEsFrVuhcOA8QRNVg95WhPEyQKSirJvA6+G7a3mOQowrOAnpLr74LN9wfqbwq7shyCpYzoh5E8awb9M2iq0bN+Q39usPeQp6gbqKnPJGbZcvKt7lIPDt6SCB+z1TBZXE6dJ+ISqxUB3khRspriplKqAD//oihb888meguzdY4sFn0udJzNnO19L79AZxiSU03ClonUex3WDFstP8WWa2YCkH0LPcQ1bKs+ZWx2CMdrp96qIzqI/FP6GpJAKLde0eNW6bC+NFD5RCEWjyYvkVKRjw5AxaL+ZGnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:10:09 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%5]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 16:10:09 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Kairui Song <kasong@tencent.com>,
 Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/shmem: use xas_try_split() in
 shmem_split_large_entry()
Date: Wed, 19 Feb 2025 11:10:04 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <AD348832-5A6A-48F1-9735-924F144330F7@nvidia.com>
In-Reply-To: <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
References: <20250218235444.1543173-1-ziy@nvidia.com>
 <20250218235444.1543173-3-ziy@nvidia.com>
 <f899d6b3-e607-480b-9acc-d64dfbc755b5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::30) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd78931-9b37-4fb1-a960-08dd50ffe1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1ZDZjBYcXBKdE5xQkovSW9vd21XVkJWZjBtb25ydVkyb1FPQStjWmI3cU53?=
 =?utf-8?B?VzZJYXJOUkhzNjRicjlWakl4VjlwNjkzS0JrZnJDd1p0STNpZTYxdE5rR1Ur?=
 =?utf-8?B?ZVpHUmpRZC92WFNLenR1NmtONlQ1aEN3RkhxaVFMNVVUengwOEtRRFg0VHdQ?=
 =?utf-8?B?Wk52UVljVDVEUE5kbWpaQXRvN0lzQ1Npc1J0cUVFMll5RG15WStpN09jd01O?=
 =?utf-8?B?ZFQvZjRKcnJ6MXhZQit4WEs5UG9sSkFGaWdERW96UlJkUHRmOCs5SHQ1ZFJs?=
 =?utf-8?B?Rmc4blVqcFpqYWx2eHZWY1lNeXZGeVM5RGpVQ1VsV0Z4RjltQ09iamVoeWxC?=
 =?utf-8?B?amtmUHZWdHZSSC9pTUFKalFTUUdWa0FpdEEyYWQ4UE9YU2Z6aUtSenhON0dV?=
 =?utf-8?B?N1k2ay9sdjdCS2JVdmFONmd3c2lqTWt4OXRXaXBOakFtTzZGWlNrR0llVGtM?=
 =?utf-8?B?L2VHMWpmbTIwdy9YYWlDd0FKMHRXcnF4UHdLTmJvbktqT2t1RGJ4RmZ5T0RP?=
 =?utf-8?B?NXh6QWJlcWVWTnBZS2Z4S2hmaUFoeUlSTUJTc25sYzFYRTFRSW13VnJLcEJE?=
 =?utf-8?B?QnhkeXFYcldvNWtMbzdSTUJiS3k5RGtBWTc4dDJBR3UxNHJVcmdTWE1BMitu?=
 =?utf-8?B?UEhzL0xFK1RVa29PMjV1bG0yZnZ1VEZORjNyQ2ZVc2NnUjF3Q0Y2RVEzWkhX?=
 =?utf-8?B?Tkt6MXg1ZGF2Q3FPakZsOHVjRTBobGFqTUQwNllSUnN6aXFBUFBwZXZsSFhp?=
 =?utf-8?B?MFpyYnIyc3plZlpnbStzU1gxTFJyZVExT1I1OUQ3eVUyYnQ0T3RxQ3Erakhs?=
 =?utf-8?B?alpFYUc5T1JSaEU0U0hpNHlHd3Y4R3BRZnltZmZ0YnNIazJ3MWIzRzIwMHZh?=
 =?utf-8?B?R1BzS3UxRnAvaGMycTM4M2tpRTVQOUpZWHoyQSt3VzBFVnVERUZZTDhSaUJ3?=
 =?utf-8?B?cStsditrVTdWaXNIVml0MUphY2dBUTlMdUV0L2N5dnB2a3c4ZUdhT1FpZWVW?=
 =?utf-8?B?Zm9RMllRazljZmFtOENxWnhrLzgyMVlyNzJNczJITFdEZGlMY0JWTVQ1cUZ2?=
 =?utf-8?B?MmNPbzhtVDhHWVRmL2h3VFltUzhHeFdjL3NIZnNpQVFZR3lNYWhManMzVWp2?=
 =?utf-8?B?ZUNTNXJmYWo0QXZLZXZGcVY3NnQ3ZC8vNlZ6VjZvcFRWbEZyRTBla24wUlJ5?=
 =?utf-8?B?M1JZQW9hckl1eU00alNXOVhxUCs2d1JGNzZCUkxHamV3cVVLSzAyWkxQTUhr?=
 =?utf-8?B?MVpKRVZlSTV3WDBLVEFaQTVEYzZRQXNLUFhTUlF1WTY1MEJTVjI5MSsySHVv?=
 =?utf-8?B?dndHT1ViNXpLcCswai9IbStGVHpwcUF0SmptY3ViMThQQm1EN0RxR0VjWjZj?=
 =?utf-8?B?dE40MmJPbFV3eFRjMitZQVVlM3I4cHpVSG40Q2cvSnYvb2hlWkUwNEdaNFk3?=
 =?utf-8?B?eEFiVVVGb1p2K2l4YndZc29oSVhCQnFZM0V2Z1ZHQlFNL0IyT3V2bGhIVWVV?=
 =?utf-8?B?a01zclVqTnFZbENXRnNqdXBXY0U5MStra0lzZlNhVWtoVVpOY1FNTHVSV0tW?=
 =?utf-8?B?L2JaYzZCS21KaStzaHZyS1grdEphT0Vma1Y0dnVPcnpNbGx4djlFWEtCVlVO?=
 =?utf-8?B?cHZac1dSN2QwZG5jRFkvTW0yQncwWEdKZVdhTmxjSUZzVjgveDBMd01kdnFj?=
 =?utf-8?B?TEUvQUpmbzJLRldGbWN5Y0VmN2RydDgwcnY3U1B1cnhoWFFzREVjYWhpVEY3?=
 =?utf-8?B?RFp3TkxIejVIZTFZL3NsTERRSkpiVjVSazNPOU0rMGlpOUlYaFNlMmt0Ritz?=
 =?utf-8?B?UDZJR201Y0NDeWlHc1hnSlZOTHg3YzRhOG5pRU5UOVZHb08vR1JhSjVUbmk4?=
 =?utf-8?Q?nn1v7yew7r6c1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V082d1NQZHJDL1RTRkgrZkoybGdlc0tLUTYreExMMHBWUlMvOUV5RTdnRjlX?=
 =?utf-8?B?VVpVRUhVQ1E1V3FCTDZxL0tqclhMR1M3NnVIRy9tdkdYUUtWbW8rYVo3VFVK?=
 =?utf-8?B?VlJPRkNVOFhrMmJONHVtTjUybnFkVEZZZ3VvbVhsMnRDQTNjYjYxYjdQUENx?=
 =?utf-8?B?dGhSa3I1VC9JcndST2kwTWFtdUlnNEttekw1TXVVazJ0UWhkSWZFZkZyODZW?=
 =?utf-8?B?V2t0VVhicVdKRWJXenFSV1BVNloxczVJR0ZnK3ZrVTVmbEZZR1FDbmpXOGUz?=
 =?utf-8?B?Q0NrUVp1WjlGWDA1Z2UzUTBsN3FlMXlKSERnUFRHV2wyejBLaXoycngxWkZE?=
 =?utf-8?B?WE5vL2NaRHIzT2hWQXJGZ1M0US9MNG1XVGFlNUJqck5tNE5VMUlTN0JVL05k?=
 =?utf-8?B?RC9ZNXlzOXpuOGxyMGQrYmQ2SFNDYy90WXM0QUYwTnNBVEtuMFFDUkJHeUJm?=
 =?utf-8?B?RjV3VXpyU3dFWTZ3OTFLOVZVVTZQN01vRHl2VWNqRnNFWGdCSFA2Rnl3VUs2?=
 =?utf-8?B?UXczcUFSNWlvblNkVHY2bHB2U3RHelEra3pSZEJQNXNZL3pTbXlRL0M1alBB?=
 =?utf-8?B?MHA0c1dXM3FtRjFZcUFUR2d6R0t3U3kwVWFtL1NPZUx4U0hyckQyd2RvRlFi?=
 =?utf-8?B?bWp1dDFkOE9Ed3FqOVZMeDNjNEdhWjJ5UGZoR0YzbGtrSzZnOTNEOUdGZ0N0?=
 =?utf-8?B?OXhpd1k3bWVEVHYyZmlxUnFMUFhKYWplb3FPaHFDbEFxWis1cjRReUQxODFQ?=
 =?utf-8?B?dE9PK2xEaGY5UEJ0UnFqcGN5K01rTG1uUU5zUHlzNGcxMXJIKytrTFlqSnB6?=
 =?utf-8?B?ODJoOXp0VllzOWdCTzNJZHNpemFwVy8xQk93dnlsUFIwVGNEeEoxdGNjUGdK?=
 =?utf-8?B?MUxoSkVkbnozTHo0Y1ZCMUVsaEhkTTVXbnJxSllHYWJGenBLWDNwaGdUUDU3?=
 =?utf-8?B?VE5maVl5Nm44aG5PYTB6VExZOURqV2xCNXJ0MVJlN0QvR25BOCs5V1JFS0Ro?=
 =?utf-8?B?cS8xRU9VQTRKekdBSWticEtyUHVaZHBsTXJpVlo0V09ocVRxa3BnbE02U2FL?=
 =?utf-8?B?MkkwZ3JjVXM3em9oTlBEV05FMHBvWEtscUxacFhlVWpuZWZwenpUUnIrK3JP?=
 =?utf-8?B?dThWOWxEczNBTFVFczZKOGY5VWNSTmdkVURwYWZpVERkQ0NaZ1BMTkJhTkRs?=
 =?utf-8?B?WjE0K2E2bWJhSlkzZzNnYUZCUDFSb1hBRmQraDVydm9TbzZUcFlVeU83NEdG?=
 =?utf-8?B?cjFiWEJZZDdwKzV5UmhpNlJON1hqQkpkaVZhak9uU3djSDZSd3cySElMVFNJ?=
 =?utf-8?B?ZlZ0b2ZWVEhCV1pRZlg1NEJ0QnVZbk1uMjRuUDljY1RFL29Yc1pKZTB1TGhW?=
 =?utf-8?B?RFljb04wb3lscGxRK0JLY08yVU1JUGJpYUJRUkhWSWVyQmpPUHBteVlFQXRC?=
 =?utf-8?B?QlBnbU5PZ3N5Q244T255UGpwMWRldE5FVEM1dDlvY0l3T1FSZksxZVBZSStv?=
 =?utf-8?B?bFhyZkpCd1UxS2hzUWlaQkpVcmVsb01uWlNHMXhDd3NQUWZuM21kclVjeXln?=
 =?utf-8?B?Qk03REpJak5ZTitSc2hGbEZ1N1c5a2VhRFUwSjNnSFdXdTdLUStSeExJa3R6?=
 =?utf-8?B?SjIrT1ZXbkcxY2JpbXlFUk1SdUxKSEtscTVTL3RHSkM2SEJ0Zjhtc3FJWDZy?=
 =?utf-8?B?UFJsQVRpaUMveUc5d3FXd2tReFFKalVYZnB5U0FxSWJIWklBWDJ4bVV6a2Jp?=
 =?utf-8?B?OXZuY1pzKzVSUnl3ci92TnVpK2prWUdUWng5dFF0SFRmVXpQSVpLaXpQUWRm?=
 =?utf-8?B?dU45dThaYitPcG5WZ0ZOclRkcnROUmRRYkY3Z0hab0FiOFdoZ0FNT3RCQ3M2?=
 =?utf-8?B?Z1RoM2tmUklieFFaSnVGOUYyNXZwZkUrK3pMdUtjVjdXNTA1QTU5WE1Ec21P?=
 =?utf-8?B?SjAvdFhuWkV4OVM1QVBmb2U5NmlOME8rd2JnSFBPL0VqYUM1YmRoenIzeVdo?=
 =?utf-8?B?Mi8zbzhUSklaUUFiNWxWQ3krcnlTU2V5c2FxSXVJWmsyOVlGRG42V2hPeERD?=
 =?utf-8?B?T2JTaTB3bEpoczFPdzVuRUFqdFpKanErUFlJYnNFV2JOWlRDZ1g0NmUwek1R?=
 =?utf-8?Q?hep3a1mi73ygibm/Mai9GuV8T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd78931-9b37-4fb1-a960-08dd50ffe1a5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:10:09.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 053b2wvZJhHDoWvG6YuvQpWNpJd8jWfj/e0JRL0sUggXk0Pv6fYsFaanlRjPU7HB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

On 19 Feb 2025, at 5:04, Baolin Wang wrote:

> Hi Zi,
>
> Sorry for the late reply due to being busy with other things:)

Thank you for taking a look at the patches. :)

>
> On 2025/2/19 07:54, Zi Yan wrote:
>> During shmem_split_large_entry(), large swap entries are covering n slot=
s
>> and an order-0 folio needs to be inserted.
>>
>> Instead of splitting all n slots, only the 1 slot covered by the folio
>> need to be split and the remaining n-1 shadow entries can be retained wi=
th
>> orders ranging from 0 to n-1.  This method only requires
>> (n/XA_CHUNK_SHIFT) new xa_nodes instead of (n % XA_CHUNK_SHIFT) *
>> (n/XA_CHUNK_SHIFT) new xa_nodes, compared to the original
>> xas_split_alloc() + xas_split() one.
>>
>> For example, to split an order-9 large swap entry (assuming XA_CHUNK_SHI=
FT
>> is 6), 1 xa_node is needed instead of 8.
>>
>> xas_try_split_min_order() is used to reduce the number of calls to
>> xas_try_split() during split.
>
> For shmem swapin, if we cannot swap in the whole large folio by skipping =
the swap cache, we will split the large swap entry stored in the shmem mapp=
ing into order-0 swap entries, rather than splitting it into other orders o=
f swap entries. This is because the next time we swap in a shmem folio thro=
ugh shmem_swapin_cluster(), it will still be an order 0 folio.

Right. But the swapin is one folio at a time, right? shmem_split_large_entr=
y()
should split the large swap entry and give you a slot to store the order-0 =
folio.
For example, with an order-9 large swap entry, to swap in first order-0 fol=
io,
the large swap entry will become order-0, order-0, order-1, order-2,=E2=80=
=A6 order-8,
after the split. Then the first order-0 swap entry can be used.
Then, when a second order-0 is swapped in, the second order-0 can be used.
When the last order-0 is swapped in, the order-8 would be split to
order-7,order-6,=E2=80=A6,order-1,order-0, order-0, and the last order-0 wi=
ll be used.

Maybe the swapin assumes after shmem_split_large_entry(), all swap entries
are order-0, which can lead to issues. There should be some check like
if the swap entry order > folio_order, shmem_split_large_entry() should
be used.
>
> Moreover I did a quick test with swapping in order 6 shmem folios, howeve=
r, my test hung, and the console was continuously filled with the following=
 information. It seems there are some issues with shmem swapin handling. An=
yway, I need more time to debug and test.
To swap in order-6 folios, shmem_split_large_entry() does not allocate
any new xa_node, since XA_CHUNK_SHIFT is 6. It is weird to see OOM
error below. Let me know if there is anything I can help.

>
> [ 1037.364644] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364650] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364652] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364654] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364656] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364658] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364659] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364661] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364663] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1037.364665] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying P=
F
> [ 1042.368539] pagefault_out_of_memory: 9268696 callbacks suppressed
> .......


Best Regards,
Yan, Zi


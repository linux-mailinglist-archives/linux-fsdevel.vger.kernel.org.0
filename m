Return-Path: <linux-fsdevel+bounces-56683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A47B1A908
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E61B6218B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2DA286D60;
	Mon,  4 Aug 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MIj63qHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF1165F13;
	Mon,  4 Aug 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331271; cv=fail; b=oDgelbqHumICA1fDdyzwH+/7D7KSPj5JzkuxDMLfLqJYeH2i7eNqwVV1ZeaxDaijfzB6uikZAoV10vxI6z23X+3qm1gepdYTxM+oWHhADjNDBWK1LFPX/ZfqZJGbNKWCCLaoQ0Sr1Nk8jrPiQqLi7duBgZX8xF+TfHV8CKxtmTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331271; c=relaxed/simple;
	bh=hkT0XUY6W1YO7vZt4xnqjMJABtp9HuUH20pVrlVuDjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgFbz+BsS05xzN7kzy+QXZ+zk/YLQBFSL5a+d93FSuAuBz/GpzFE7lWztJkst6xADQ0mke7q2mlnmvkVhocHpo/d02a2iWp3iqxF5UcPi8ofmu/oKfqmjTjtSuduLP8owfzZ4KmrjsFdNYEg6lSZZopOyqGqMx3azyMGslvFv+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MIj63qHN; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9EsOHC6oCiun3YuCBBuhFJ9gCDP6EKEvg2GE1dy+lL1niOEvkOt5czRj7DA5rcxeefhP6pL16WENeRdMyAj9q54IBPdIYhA0jtYfXwSwe9dTV7f3VSu1dEFstc1KHdXAyVgOm/XlBe74aSc+AfqzjUvPEIsiMFBrJPPsqyDgGblxh+Iom37qRIsOFkk28lQ15bjRo1ZaAWCodauxdlN+2rxBkF3CUtZOiGJWZXViEWttiyxjg3HXmsCGXmNji0wV3SPIDViFUZbOEm2iGR4LDsst5P4tpv303NbSEgiS/J1lQJRbbYQd4ujsrF6eryabDT1downgg1kbOGNunQRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GoKxU0qbCbwDdFVJZDFQWI3GVh2zdOoA2cHMqZmg/0=;
 b=HERw644leqsZFAatJjNMCQ/NrQ6wWQKXyF90zvNhiG08eolAMoGkIyi6MDyvgViKZ0B+DYWVJeEpOw7uK/X8IyqkbHNaV6U/5sleRIP3PAM9z+AZTIy25rJ0c9s2vVwEyRcIzXe/Ffv9UWKopjEv3BbX0q6gVjFbE7zbkRo5svpL4QnuElQka6Wozisd9U1lMD4Wn68U5nUUe5Y+sNH/nQdTS6BgpSMeZMiIGNzLzwOS7/5d2hZjgt8Y7LloYNavHOqhBo9FzF6uEQAP1A5Hm9dWvC2J8LLWPxSxqWetbYYjfmHK0BNZtJiexkPXPXZw5TZu54+MfFCm/c0X0Y75jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GoKxU0qbCbwDdFVJZDFQWI3GVh2zdOoA2cHMqZmg/0=;
 b=MIj63qHN8VlF6+zY6pgAoXtI3Z3BlPFn/iFGDEpaiA6gyrQlO8e2EASRLb7lbOCb1fQgXijKbiqSzZnwO+8FLgf0raj1ZuteSuVdTesNtV4P5dr76gzV62bydRTFr4a7ti0ltGGjMJ1tvW39rqAbrTqLhs7suLxtKE8pThX95bwnnt7+6sNMez+jJSlmY3o/HtYojCjZ/rXaHHVf10W+MJx002tefEil9dhkH0A1t8A0FNTTks52SE9kzq6YaiylrIrYTLMnieirh5he99vL5DT7XNJ3R/02JQoY/41zCY5/EifCnbnXRboQLsBBOfSATazCW82Nf75w1VIYFG3lpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Mon, 4 Aug 2025 18:14:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 18:14:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
 linux-block@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/5] mm: rename huge_zero_page to huge_zero_folio
Date: Mon, 04 Aug 2025 14:14:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <89583905-F5BE-4BFF-BFCA-2566ADE7D94A@nvidia.com>
In-Reply-To: <20250804121356.572917-2-kernel@pankajraghav.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
 <20250804121356.572917-2-kernel@pankajraghav.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0793.namprd03.prod.outlook.com
 (2603:10b6:408:13f::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: f56c5006-ebad-43bc-fbdc-08ddd382bf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sX45hspng0//EtwENMwLiSm05sm5zY6uYis0QgSpoG/FQ8kzAXopsb/+IEFK?=
 =?us-ascii?Q?XThUQ6C2Jz1s9vOiB/tUm1Aj8yf4ProKT1R8xsSBsZYrHCED95kAV99x5IoH?=
 =?us-ascii?Q?kIcPe3Y4braDt04ML/FdQgZQyrJophaNapG8vt3M+pW/pzJY/GwXVyCGYAQT?=
 =?us-ascii?Q?VxRJPmiR/gM1oEfWRtf3DUFsfIU8rEa3b8Ptj1jTTG2yT0QLDUAOyk2ME2EM?=
 =?us-ascii?Q?VXqDDDSupdfebMBQ4FZGYWZOk9zYYZK3Gkg1TveNN683MQbcCtPjryhnxQLR?=
 =?us-ascii?Q?jprrfiwWd8IbxeRsDtf/iS7BnYdSjyC7YSX+WEwCbMPzZlQt+9XPFvQfMU31?=
 =?us-ascii?Q?3MM4fLbOCOfIoHPTa5o0NVixR0uOKTML+cqjSxXdtCAjeZ5C1W/y1QaCzIH7?=
 =?us-ascii?Q?B06l0Ex8dwZ0fbOyp577/HvGoWrASqTBykKb9KqKpDrmfl7ON8T7xtPwmQ2R?=
 =?us-ascii?Q?cY2LYq98eP/xtrpE8YNxHtD784xEzJPAZW8p7WOTlfK7BMUOOhtAmrNDunKw?=
 =?us-ascii?Q?bMBOK4/mWvo3gF8PBBqP56AElFpZvPNK86eD1qCROkHtoy5vt80H0HkOaWB6?=
 =?us-ascii?Q?sG07lDAMVnBazqV1UYvIYVe22hJ6i67A3S3Y7a4MPwLenKyJBFyK29pn/Fux?=
 =?us-ascii?Q?YPbIzjpQgy2DIbzZpXBW6OihcUftZB6xEqL1TVyV+DlNQQQCplpiEzcPtsdG?=
 =?us-ascii?Q?r4AZhxkpQWvCUDOmlRnmGn7DQ94FsTfXansn7Td8qvgId4Qjd+1I+cMKVeT2?=
 =?us-ascii?Q?UnTjwr5Pe92h0EeRuVj7XOdteuoxyyev/0onfhdhBaKikNUys6y8/F4ENBQH?=
 =?us-ascii?Q?e4729NdRWaHlEEcK/J9FJhyAaw6CRa9nrOp8SeMfFPKi6mljAzyQGVpXvBzg?=
 =?us-ascii?Q?Ir+meCSF0z/r1l2sleSo1jcvqLPyBX39IUYwcH1UfWSDTlQo/DB0SkBezWdu?=
 =?us-ascii?Q?WScEUsCUM+IdWB7mpe4MTUKotWNWwN0unOne+GzOPcsoY+xbBfhETEVS8zdI?=
 =?us-ascii?Q?LqQ1tkflm5JSS9bUM12QQ5rf1X6YuKtT637FGkUki9Qm+fhJhqGMt/zS7vT6?=
 =?us-ascii?Q?s62wBNsLGYGivBBsrIB4IbgFt0OastTf4hcxc9VGQxdV8jzxHzPW3LHCoBQP?=
 =?us-ascii?Q?nOYPtC4GGvEsCumHt8KPYnEsvJAAEybzNqAEwh0qdUBllaOXeBgQJQcb56dy?=
 =?us-ascii?Q?hrer3Qn80DxjEDvkudTf/jRfQktzIJbnarXD0xexyXEWLTRUSFnj4mFbk+1K?=
 =?us-ascii?Q?f6cGZ/xkR5Z9jUMINtoIphvRj6IXHbMfD6fOWYR5kSAn7Kv3hp157LF7/mUm?=
 =?us-ascii?Q?+Fo32tU/e5djaKMXdIpzUUAYHvpb4UB8XAoNOV00meVryJiqF/KbIZQTdH2E?=
 =?us-ascii?Q?jltGP5vvsaxReu3lr+4cUdJ1tgNxGmHRdL2d1nR6ApGGfDXKkYRNDGiyncZD?=
 =?us-ascii?Q?P5JqKUMxvig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CN4vKywnxWW9YdMvAMtrj02n4A6WJ1LOAVUZSN3eoXe7reEQm6ikiJAE68OG?=
 =?us-ascii?Q?717HudvDVZI7ygLwYzCL+hCYm8S3oO32hPBhR7VZr/fCbdr0paTKp+VDZ5J2?=
 =?us-ascii?Q?WNv10f80LWzoJujvOEF//54lz2Zn/TN7MVvtQDdYuUmRQZ6rvFUF1JdAOBHE?=
 =?us-ascii?Q?sqSDzc2uo+6jzQ50YCz7jeJOsCkO7sJvVks3jn3SdLdj2smlqq2GWz4K98Fq?=
 =?us-ascii?Q?RarhqZFeLkcDG3UroNwibavAraAxG6tmZwSYsOLsv4S+9QEhZ8YWNZNVhrin?=
 =?us-ascii?Q?ENPYuTLaQ6xvzT+IWF8OxBMapXz4sBKzK4Ia1p+Xg4GhM3B7K80Om1Lzmz7i?=
 =?us-ascii?Q?JNydhwA7q8SFnhqD4gIEwkzusKtsSzH5UzsU0LCNEX7JdJZHyRR+D+FGAGd7?=
 =?us-ascii?Q?MVLIAdPN+vOgEkS/BeG6dOCS2g7K/lxWC7BzYMfIX+wjI5rvPnjKOVCJpOOP?=
 =?us-ascii?Q?nGUqTupDsh5fctYn1MREmpreJMpui+luNN8r2W7nnJMq2acK7pvRu3+O2rjv?=
 =?us-ascii?Q?qHUv3ZTHFcaltOlerdYgD1UdgwepMEtADJfAJIJlKTGwzi8QBXS5sbGmbZJf?=
 =?us-ascii?Q?3BEFlOJgB1dUrD0KIIg4s7WEyqggp6UlZ4w5YPsTE0iPlH7LJp22fD8isLGF?=
 =?us-ascii?Q?GbAl3gopXK/3b0ACdYvo3ALeQ2TQWFYf1BNSd83u2fER39QKX1GhpL1evvBF?=
 =?us-ascii?Q?xmqO+d9eRmy8tVs7dd/uzhN7oGBgky3S2IaaM0uLXgLcNXReko75+jDzNrQ+?=
 =?us-ascii?Q?g7QzzQ095iTvNDf8xg9lt/Ydbq5FN9IoslMS5HQTL8ak6/Oc9RGc2pzVPvjd?=
 =?us-ascii?Q?SXQFYaBxkx28pVvN6PZVFl3bT6TF9R1ydXL/U2Sote0BL8vTl4T75JrCS3q/?=
 =?us-ascii?Q?L7KDXV8FlLM6zHPRzFPycF/Fq+J1mGjU9jVFxHPBSLwAdhCx616Pu++DPUFT?=
 =?us-ascii?Q?oIeo1MDwvE2bBAlSQu+pUJY7iHslJsMtz1RZSd1lbBHqNy3Ht7vDfavA4JkE?=
 =?us-ascii?Q?LwRh/TEfy1J0l7FOn1BtOMi6pWjpxwhxnwujAXaUINnNHpBtzxsoZMYGT83r?=
 =?us-ascii?Q?486J/Fe7kTes5sbFmEl8BQBlLkMTnzN5vzTokdsg5QY7/zeQa0EjJuoucWN0?=
 =?us-ascii?Q?qiKzV5MgLH/vMSGS/8tFitgeE3siKYJLuMp4X69LfZ8MNEcNrCbQJomkFrfa?=
 =?us-ascii?Q?Kx9PBKqpOoNmpSmEewXPkLiW9F6K29DQPIy5AGLak/WgrnUFDCSfRR0kbMZV?=
 =?us-ascii?Q?0mOattjUHKgWjvZYrFxeORo3xr2RS/cNEvmYzH/XWVUU9cXoaQ/m+YxqR1Xn?=
 =?us-ascii?Q?GdixibkhXAlRejyNLNxpd/vxZZC1r9X3ndjWW1cpx9om9iSUuiRUHVF0/+jv?=
 =?us-ascii?Q?hgbwZ03GtRj9+KBV4KW8VhlxlIB+cN+ImIC6+sYkmQ9bSDOEm2oprgO1rYIH?=
 =?us-ascii?Q?n20xaGd13FT9IFj7Hd7KneRv+0oNKvnsrY7EoRCBzwmLIuX3Clz5OvRBW7lW?=
 =?us-ascii?Q?gIb/CQnclQyx0tKOl6646Pe9GV9XImTuWgChAVjfnz4evqqjeboanWxlbTCI?=
 =?us-ascii?Q?+dCm42wiHv4UxlKMYDwQV9argZfVrfuLV4VcCDtp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56c5006-ebad-43bc-fbdc-08ddd382bf94
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 18:14:27.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua1ncwvrUqG2C3XbdV5zlOeyc0YXRqtINg7J4rs11E7ENKNHfE5k29aKFRPbV5Rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

On 4 Aug 2025, at 8:13, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> As we already moved from exposing huge_zero_page to huge_zero_folio,
> change the name of the shrinker and the other helper function to reflect
> that.
>
> No functional changes.
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/huge_memory.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi


Return-Path: <linux-fsdevel+bounces-41409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8023A2EF68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 15:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE75C1881B0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B2235370;
	Mon, 10 Feb 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9rVWSKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8D234999;
	Mon, 10 Feb 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196753; cv=fail; b=hVDzda5BTxU5Z2j/25b9XdMZk/srY44MsW+0gxm/3L26B7tWMpSebgYB7JfCeSS6K/ItJktvzjs3oxvllWMxlxbwkzQC+3SIZcR7Q0tSSv5GfBzEjUIqtiAZk+GzW/Cz8n21sn965r6y7mqaNzoy4q/YpP9QkYl/pZJjKrtVXOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196753; c=relaxed/simple;
	bh=sslPx4Y9IpIxCumHZfV/+PhxCm6iUmvM/7KLp4cdjd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQgIXUCQqamt7MoJUDdAQSqcpIVZXmaMbj8FeMANf+TTOPsP5D+ITBS26qyaUp9p9etoQL5DrmqhrHocurQoDKSwhp42TvMaxjM0DxuxYd0ft7JnpyFhpC6hDTSD40Iz7LXDH4A27GhVKnk8zvQRQS8IQ75QaNBdIJ3xq0hM+Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9rVWSKi; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyxTzs9pGajYBkzSHlSlLIehIJYLOFscYTUuvqZgLp/H81A/iwsJ2oLUuhUcZ9Dg3V8PbRoxmxEL2x+nXvmj9k838rrymR73yg3WNAQ9t70prYoRirFxSevNanJFHrQBFNJkflaab4vtDAu2EkpK9ZHXIsIwAuGYgzm44ecOOkz25ABY4JKQaDluRGB9nMRCAOLw0UzUvWBl28jd/N5iJjuT9zD66zCWbFG8hUqK/sSRgwmV+Dd4E978nn8FHZ8xSTBT1vV/H/2H+7ZuhXPGREvSUNODHgCLSt0QSHyueQC5IF7/qnvu+EWE1r1d0Ja7CeV0Q+EH//QOeGjdl69GKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjaaVhbC81SQqWKkTvddboIME5f+e01DSe9CYaoa7ic=;
 b=t+Os8x2ZddBrjIcygX6jhoWYD15T9QfXHxAGKf521nl2WKP552gekjrhmWbHSnhmFyHZuSK1bFYDPIOAxQRuSD7UzeBgoakOHLwcsymLY/prmqrYGcFcv7boJYUHeJSpB+m6AGt4CdiXg0OiWaUv0cmc5g61GDkeHx5l31nSZkGrXCIi1HZSXPWu5sHRaLrU5TWFBCOnYB1aVk3E+UYpEWVgZYCBauph2L5xNipOimScWPfcZ7FkXng0p/C9hZ5+sjg6WOXi+ZQbwVwxMAv/phkp7enaaZstMzF4dtoNzrubwxkcXAOg091L2gtRPbAJZMGfRwf6MLr1S5iD0hg7gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjaaVhbC81SQqWKkTvddboIME5f+e01DSe9CYaoa7ic=;
 b=Y9rVWSKioDQi8fFczxssaoYe8K/Y8Sjaym7yj0SAT9DuB4X+cXgpGy/6LnrCETtGG2H55tGKONBa+pY1dt5kY05Bg3t0un1scNUSj6fmjvRxBSiwzf0tSNMdSeVIqqtZxw43Rnv9uCSFoP96vA3bxsojrbmiaaIhih0q06Qbp2GKIjh/FHg4+PbAQP6RbyxMbw3gtGy/XCAACcw/Vard/MqDNIzF4iH+xaaMsPi7Nk4ljoRtG3v/rWi4ILMaeOMfN2y0oKcLSc2XYRIM+GPgGUtadAuYM6WY6XaTj4xj5Vx0YBJXCRxOHvq54RmGAZAuR2ycRtg3OQ4Ko7ZGJ71XZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 14:12:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:12:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>,
 Jann Horn <jannh@google.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: xfs/folio splat with v6.14-rc1
Date: Mon, 10 Feb 2025 09:12:26 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <CD159586-D306-478B-8E73-AEDA90088619@nvidia.com>
In-Reply-To: <dda6b378-c344-4de6-9a55-8571df3149a7@bytedance.com>
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
 <Z6aGaYkeoveytgo_@casper.infradead.org>
 <2766D04E-5A04-4BF6-A2A3-5683A3054973@nvidia.com>
 <8c71f41e-3733-4100-ab55-1176998ced29@bytedance.com>
 <dda6b378-c344-4de6-9a55-8571df3149a7@bytedance.com>
Content-Type: text/plain
X-ClientProxiedBy: BN7PR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:408:34::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: d70828bf-55eb-4cb4-6233-08dd49dcf36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TZ81Pb83Pn6UQ8qZ32jndBZ7yyN4euxP6QYA+lZ7FwY8fTj0Zl8V4n00UbXS?=
 =?us-ascii?Q?3xlsKuh9aXM8zLNpR/epQXkHy5BHOZQWLbUh29vwpNnNtruBQQv4n5GF6vSi?=
 =?us-ascii?Q?b0mLwzKUOuzdZmg4oYuQrcvgerniGpfPftG0DcqDZlT9Pz45np51tzjcsPqR?=
 =?us-ascii?Q?pk1qFdf/rRlIegZgy233bHVeXJIwTYVdqwT8wLWbm0elxxmC3W42tK+fPDhw?=
 =?us-ascii?Q?jI4Gpd1XYoq+XyUotaPU03VBPkFKBPNYiryiuY9NKLk/tXmOBildoYsziOOC?=
 =?us-ascii?Q?ROr4lmCpKxd1AVXdoybEgUq0ldY9hdwNBZ5KnUY/R4lR2mOffWl39X4w5KoI?=
 =?us-ascii?Q?74Y01JtLANSnmwiBY9xAQ+qdf1dEzvwRND5iveSqr9H6VUVw2DfWEN5fgixS?=
 =?us-ascii?Q?OHR5TiCTkPydw7wgNhZpZX7FXZVYRh1GC/WGyNt2g2TyuJI6Ed5d+9zUuPwv?=
 =?us-ascii?Q?+xAjLxtbljaM3cRCboV2V3LTx+Hd3UjIxHXUZEgsNoSgxBseqypAJ3Tq9SDo?=
 =?us-ascii?Q?aRU0Tk/AMUiqzOeftthpkwInhNMMgkNYKpo6HA2GDPy7kyzmj5PLzCQF5Xua?=
 =?us-ascii?Q?lAg1P36QqtfSl2rhItAJ1VZtexpnPVjULqOiOlZ/mqUJi8rIwPo5DhS0caEu?=
 =?us-ascii?Q?YLdz1i6/5JdUa70Hes1LIHgoBCXZfVAIlGDoqMSNS0QDRf7TC8Mthg02usFj?=
 =?us-ascii?Q?CougnLKkIex07eS3i25ORnp2E2rkF1Rp8Wf46Dyj6daEFn3OjWlyfiMHp+fE?=
 =?us-ascii?Q?1bQWmGPUnbPNx/ENJdvomdQMviH980LZoJVshzt9AYyu0Y3Kcpg9k3YBQDkG?=
 =?us-ascii?Q?HNdfioOts1DEw+QdKYAABx7V251BYC06Q+Bmy1ziDLe7j3v+Ag1fejtAceL7?=
 =?us-ascii?Q?rnnTBGALvlFHT8yy2zZGamipkjK8tiJUhn/sl8NDtPr4I0JrPPpxmSaXiItZ?=
 =?us-ascii?Q?qOH2+ttmN8DkVhqCnEcfaWq13dd8mvxVjhSIJ6GSyYmHPikjz2RtRhO6/n8o?=
 =?us-ascii?Q?ZLJ9/PnmheJziFgbB6LZ51AQUwGG56qxtkxwJT8XolsOSD/MZocG552FPKyS?=
 =?us-ascii?Q?aVJD0lVCJPMS7TXshZkw/Fx8LQpDDpndtuekZ/8yodh5UcPuVc1OEKIc9yRm?=
 =?us-ascii?Q?cHPtVaW2iKK/8w2CqiaumpnDdWLeDNhc4uoOzgU+Mx0wHmYREteGz8hfjuYr?=
 =?us-ascii?Q?NFwF/ZMJEvO0P+yon49ybBO59C4dghyx+MGmxAPFoo5psxFpdYZ5zLveQv2H?=
 =?us-ascii?Q?5tQO8cLIvYQPeXs/W3FieoqZ2SK3RlBhrbSKV2viFA7NFL0r9ojb3clIoV3c?=
 =?us-ascii?Q?8B4sei3INAenV/PQqZ0q1nH7JGo9KfEECfasLNngii2NhFpLw16RoybFc6jj?=
 =?us-ascii?Q?GWwhSJbNT2+otZ02F4ce0zwY8xld?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BC1s0dU/kwjAGYWyEaSpHqg3g50z+MPbTnFYAne9KkSlrpXR3D5GRVGtEbRp?=
 =?us-ascii?Q?ElkJFOJcAu/RrIK1iZ+YXmCeM7XOMpDtsSKskAaTm337kBIEfxmDqQmM8wDj?=
 =?us-ascii?Q?vXsWePI/c83V3acYDg9CX+HUraZYJRXEXKH+xk+q1qgi6+yuarbcfjryc46v?=
 =?us-ascii?Q?jh55Tn2qIW0NI/tAeprSIlBm/n1JLNMMvKfgyuFNgVGUFp6OfSjzXD4hg+KH?=
 =?us-ascii?Q?uhjYim8s0/wab7UqEgCI7cu2wY4je6zDNU2uS+kmo/mjerhPSRa9+pYoy1mK?=
 =?us-ascii?Q?UjES4aONv8MSfxmX4/zhmfRpgFekPrlCTveITT/fGQdorjsYOWZS1cPZN7CG?=
 =?us-ascii?Q?8w+nUy8hCiKkFCqR2RuD9TQRpGTbkBRUkYsRkrl/tC4B33BQWqleutq4kW/s?=
 =?us-ascii?Q?YXiXdcWvSZm4EJ83ozB+u4+bTsgSQuXBbgRfPD9p3fLuo/HTIkQ1GhfDXT78?=
 =?us-ascii?Q?X40ClegrWdoqimEwcks+0AOrQXKnqStv2Zhrinnlh/cKBHngYC8vBNRjW8BI?=
 =?us-ascii?Q?UZX3DaSVg51ItspuKa97sB6QG874V7mu8cl/dn8fczaN12eQxFedWSy0lt4L?=
 =?us-ascii?Q?/F2Qh+Pjb5+sc8cWSG3z3Rw5rHTLipQh70xQXumQlEmLXO4YZZnEd7Dd4les?=
 =?us-ascii?Q?4QTjSR0vv44Vmsnhe0io2EbbgKKxWjiDOWwcdHbkQi/XNr5J2apSpcNgMzBE?=
 =?us-ascii?Q?0ee6fTrzDegafGWrWpzIH9oK6qfj1AGyJM77BTGjR13hg8G0SHu006/bil9d?=
 =?us-ascii?Q?B3h1AofGy5xXvOEgukfKqLmKFEA+NMZkSMqTfpxEKJCCi6rXuEcHdCN9bmTI?=
 =?us-ascii?Q?chRQFg0se+P6iuFHf3Px02NpZGM8zZUwwhazPVmZ0h6mKQ82lT4IPHzuLdLb?=
 =?us-ascii?Q?iBTAMS1TlUckuC8ZhAZ9VlchExTyuYuJsNHUGXGWFK0t9ceOvprAhNW6ICiJ?=
 =?us-ascii?Q?0ejgYy7d50ffTVQEdEMCQc/OdnG3+kDAui1dSQU2NTVpWpS590nUnoiBOk4r?=
 =?us-ascii?Q?VoZ75gCaAZwa0Ra80aulBWEu3qB3v6g3OZ9nIMgmb+HuO+Ssl8Z4OWIBdb+z?=
 =?us-ascii?Q?/ohGiTr+kK3il5xN7RCeGdWcXdtnjdrkgBpvnc5CBPxQsTUHcm6IBj+sBlO4?=
 =?us-ascii?Q?65j5vcBhVjCVRm13Nak8cs4jxocP4RlVrQhEEw4aO6Uph+P0qTe4EyBGYqOA?=
 =?us-ascii?Q?jd08+1QbLQP/TXVCMw5CIQ8mIqsQjeVNW32NdWwjKmxRudeaDDjrnxSAFPQR?=
 =?us-ascii?Q?wTRJ2brCG3OxpS/TJqkUNU3SoNSuOVXu2QEzl53epGq/ZM8JEamreMRvFQSi?=
 =?us-ascii?Q?XoqJa+2JRRHm0OqsZpj4RaFowjvOEJ0+bmNag+jhkUqKaPbVHmNVv0VpSPQS?=
 =?us-ascii?Q?qzt8pb+QqTWNZd9oxqhDLT3dcIrfMNmnGm4ngYelPOmydFwCggW3jJ/A2N90?=
 =?us-ascii?Q?GwkDbqTsjG4eOGlyx9q1NNQcUj3SaiJpd3658DdUh10OH0K7jCGPdM14Kejo?=
 =?us-ascii?Q?mgf64auLf6JKOLpKYZ3e3Oypl7pY8uFrQ5dUH2k6kc9UjTcRh07EvnPCPN/m?=
 =?us-ascii?Q?HZfjjR6T9ZrDdvTxmpc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70828bf-55eb-4cb4-6233-08dd49dcf36d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:12:28.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpnBbFfO2qi9+dycLsK7qX2U7y+Yq660Gzx4ZEbwTVTWniU0bb6MBrC/D8mGcW8L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

On 10 Feb 2025, at 3:18, Qi Zheng wrote:

> Hi all,
>
> On 2025/2/10 12:02, Qi Zheng wrote:
>> Hi Zi,
>>
>> On 2025/2/10 11:35, Zi Yan wrote:
>>> On 7 Feb 2025, at 17:17, Matthew Wilcox wrote:
>>>
>>>> On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
>>>>> while true; do ./xfs.run.sh "generic/437"; done
>>>>>
>>>>> allows me to reproduce this fairly quickly.
>>>>
>>>> on holiday, back monday
>>>
>>> git bisect points to commit
>>> 4817f70c25b6 ("x86: select ARCH_SUPPORTS_PT_RECLAIM if X86_64").
>>> Qi is cc'd.
>>>
>>> After deselect PT_RECLAIM on v6.14-rc1, the issue is gone.
>>> At least, no splat after running for more than 300s,
>>> whereas the splat is usually triggered after ~20s with
>>> PT_RECLAIM set.
>>
>> The PT_RECLAIM mainly made the following two changes:
>>
>> 1) try to reclaim page table pages during madvise(MADV_DONTNEED)
>> 2) Unconditionally select MMU_GATHER_RCU_TABLE_FREE
>>
>> Will ./xfs.run.sh "generic/437" perform the madvise(MADV_DONTNEED)?
>>
>> Anyway, I will try to reproduce it locally and troubleshoot it.
>
> I reproduced it locally and it was indeed caused by PT_RECLAIM.
>
> The root cause is that the pte lock may be released midway in
> zap_pte_range() and then retried. In this case, the originally none pte
> entry may be refilled with physical pages.
>
> So we should recheck all pte entries in this case:
>
> diff --git a/mm/memory.c b/mm/memory.c
> index a8196ae72e9ae..ca1b133a288b5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1721,7 +1721,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>         pmd_t pmdval;
>         unsigned long start = addr;
>         bool can_reclaim_pt = reclaim_pt_is_enabled(start, end, details);
> -       bool direct_reclaim = false;
> +       bool direct_reclaim = true;
>         int nr;
>
>  retry:
> @@ -1736,8 +1736,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>         do {
>                 bool any_skipped = false;
>
> -               if (need_resched())
> +               if (need_resched()) {
> +                       direct_reclaim = false;
>                         break;
> +               }
>
>                 nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
>                                       &force_flush, &force_break, &any_skipped);
> @@ -1745,11 +1747,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>                         can_reclaim_pt = false;
>                 if (unlikely(force_break)) {
>                         addr += nr * PAGE_SIZE;
> +                       direct_reclaim = false;
>                         break;
>                 }
>         } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>
> -       if (can_reclaim_pt && addr == end)
> +       if (can_reclaim_pt && direct_reclaim && addr == end)
>                 direct_reclaim = try_get_and_clear_pmd(mm, pmd, &pmdval);
>
>         add_mm_rss_vec(mm, rss);
>
> I tested the above code and no bugs were reported for a while. Does it
> work for you?

It also fixed the issue I see on xfs as well.

Tested-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi


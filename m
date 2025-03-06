Return-Path: <linux-fsdevel+bounces-43364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F34A54E04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A787D3A7E13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41A175D48;
	Thu,  6 Mar 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="gNHNUkn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC0B188724;
	Thu,  6 Mar 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272143; cv=fail; b=cwOwEr+AKnVAjdkyndcaaTcL6fXqOldqZoPwKxj2pcwlK6wKjYZ4d+DbuCHhacJu0/ydtb6DN54hvXBx3RHBSPcnl0zzxK78aGu+3vitxiGxwcKVU4V9orpSx7kcr9P/yedg0H71NZwDmrwtx8MtfS5KV8+TI6pW8sh182ZNyvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272143; c=relaxed/simple;
	bh=f/oSN8qP1ji3EhX6kJoIuICMDd4OuwFgtHdTRdHjpHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=K+ntS+mOcPUZFX85SW5p+85onUX1U/yH54uH8eD4ckeLpaiZyV/q4wJf8/3Asn+O1MCafQI85JWZLT4YL+65FbV4pei1SZOWbzHndA1S+R4K6wlO0tgXGCnqjxw5LE1wD0Q2/0NRaUDiuWhjMIz9/SEWaUeWknhCwWgcXvwMeQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=gNHNUkn/; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOcUwUWYRRcOywcdYKp7oHuO/a+rDO3h9G/qMmqCyiWq0V//UKDY/sCrica7YC53UDqfd+vjm3oghKmOcdwiL8X3jEXRQu8Vw4OYP2De5+G+OgZ6h6sYRmM38eNxyK9eItFVNd+PK12KdpGDcM5fisG7bUN9V9jz+wfOQoam2zDmI2vnOvc5EQQPluAH3FRAYrf9lAD6IGH6upHo/vVX9W8Xr1pOnH75ueqxmosMPqVD3ehn94GO1QongIxpK+CLYLnSvBrDSdi+cPwD2funPq5zDvVefhmhg+bfb9bLfRWerfzd9f37f0e9HXVrScCbEqpXAZR0Hq2QHEknOvEY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEpUlGQ3gOPNMoZkxf1TNWD8UFjjcto1VI28D+/Jpm0=;
 b=yrb7++UIus0IwTe4OYNxyQCXfn2wGElDNstmTNBPv5WSgOk/wrLOf3NTfWMa+KreUxKcvXPcxvvkiUvR3Exhg1axmp51n/FYB2h53yaU/v7Zmu/9SKP7AXd9IbCG06792PGn6xURl+smZkaRQlDyFV+dF+qcTHUkt3tjokKREEpdjPhFBFezBg2lfiD7IzqKl8jPHqRHA2x3f6NVI9wh95YsOBVdPaksJ8hustn758gCRpOK9z3ytVTRqOA18jJVfckrGXi0k6v1R7Agy76Cfk+1vhtM3PiftUddkdbhJ+ikTCwxhFKslXiOtwJE0OUI5bT6Deext6S6vp7c8VS9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEpUlGQ3gOPNMoZkxf1TNWD8UFjjcto1VI28D+/Jpm0=;
 b=gNHNUkn/aRJY752erZXG5zQJso/HCzKQuASTi4Cvmn2iYDfYVdivRTtW9UWiWWVpd2661wz5A91fjILihwFU1y39K0DUoIOvqo5IK1vcBFWmZO/ciVVb00/r79KNA0b6lAFtELwB7QloVOH1hSTjqm0Uh/qOUDyn/6SRnfIzvWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by AS4PR10MB6183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 14:42:15 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 14:42:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is
 still full
In-Reply-To: <874j065w1v.fsf@prevas.dk> (Rasmus Villemoes's message of "Thu,
	06 Mar 2025 10:48:44 +0100")
References: <20250228143049.GA17761@redhat.com>
	<20250228163347.GB17761@redhat.com>
	<03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
	<CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
	<CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
	<741fe214-d534-4484-9cf3-122aabe6281e@amd.com>
	<3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
	<CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
	<CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
	<CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
	<20250303202735.GD9870@redhat.com>
	<CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
	<87h6475w9q.fsf@prevas.dk>
	<CAHk-=wh6Ra8=dBUTo1vKT5Wao1hFq3+2x1mDwmBcVx2Ahp_rag@mail.gmail.com>
	<874j065w1v.fsf@prevas.dk>
Date: Thu, 06 Mar 2025 15:42:13 +0100
Message-ID: <87r03a43wa.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0022.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::7)
 To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|AS4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5e8569-4058-4d08-49f8-08dd5cbd167d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQXh0Ng6GuGztgrONlXwTOUTvFCyMKYnfHkIAfKNhu+RUe4ohGmO7gUBuKJ8?=
 =?us-ascii?Q?4WdiEYXv9DjeFdlsPK3uDCMBAMBAkPGJtX2vpcsw0P+eepuX4uOuyzO7MZkd?=
 =?us-ascii?Q?4Cc4+fw84htAxA1CjvulIE4fJ8WnKh58/Z7oYxmrHCFEb2hsqAc0BBDu6wGW?=
 =?us-ascii?Q?pQxlHxaPCbsDnHZvly7mBn7wGQrT/GdNHASfxbQ0MRV7jB8RG+YElAUiPVlc?=
 =?us-ascii?Q?84wvlB6PaDPUB8bq5DaOKTrce1iNVeJlPuf0obcvbQVxkZw3qc3RArlaWawB?=
 =?us-ascii?Q?gTdNUWFlzX9XVLPffdMaSTkn/Pnt5ks9KPihFoyLwMmG4z7bxO9Y8yi+P+MB?=
 =?us-ascii?Q?k133ACjYpucYKIPdQigEHn+2zPRAm3Muddf3VAnoSW3tbqsu0F8P1Eynb/OX?=
 =?us-ascii?Q?1rC9ZvS1MpjmIcfuFVjeUm5BI7SlnFp+87sMUpYtrQqSIVCCXFosz62QYeo3?=
 =?us-ascii?Q?mV7ErHGr0fN8dekoeGAwqZCKXbIoRE4QiysPSEjcK7H/IScVcA3piFed1T67?=
 =?us-ascii?Q?lFhrWbvL58gEHnInbIV8hK1EoaY/MA6J3QkUBhaDJDAfRQOfWWLslI+tpn0c?=
 =?us-ascii?Q?TPfRt6XGE7Gsqf8wysnyAUB6vPsaiQTKJMIHTcIekG5QMveuZ872dPp0lFPF?=
 =?us-ascii?Q?9QHz4ZV0XVxzXjrNKo7UH1jz7fuo+KkMTSxHFAoMlbxIuy5409WxshEzdNAj?=
 =?us-ascii?Q?FR5kwgJcSJZOJnKQEf1xj2s97IJX9Dzpi2EpxhSquQUwOqFpUmPOzzfoZC5D?=
 =?us-ascii?Q?UCAQMgfNZFvkCiS2YzoLRcQGPVCpVpETxVM0pI+uaokds7aAYk7RKKsOoMPN?=
 =?us-ascii?Q?voaWDjqqGXYJ7GPtHcxPlwMVQhctfWo7pWxXLRlikg8JqaeOwO0gAEhAEh8a?=
 =?us-ascii?Q?1KANTY9reSA/GZSIc0cshGDwvKH3k9U3+cG/qV+TKIiB9VG43LMhtAIziinY?=
 =?us-ascii?Q?kwzYDh8md37Ci6V9RU9Zdf4QXnVCHvyd7JtdOtXqMxx6Hft+c1IDJEeeXCgo?=
 =?us-ascii?Q?7gs39ZfLfxkiL2VH/jmzQPHdF48eQ7mExz6XWYz80XinrnPd58Ne7WXg8wr/?=
 =?us-ascii?Q?tD8fGgxa3dXDFz9wuylJN122q6QfpMx8flSvtWOFKy3TNXpmVMowIhN05RII?=
 =?us-ascii?Q?x1ew9zp1pT8xplRkw1275vOC7ueExO1k8r9DPp0poKD0tgcaRBVe3fSjLcnT?=
 =?us-ascii?Q?xME7vCpRBXVNd2GJSoTDgseW5NaV4+awX1CNbITYDn5XdQPY+NRK+HNCuum3?=
 =?us-ascii?Q?RTAsuArovmo8elsj2FaSNidKBKeUsybO4FpTD1aXDdWFlT6RpxNhxYJDR6CK?=
 =?us-ascii?Q?pYXhKnHIhzHsUvXC71JKpdxVCde4M3zRS0TFsnbQo19kpjLyVVZFWIW65sPt?=
 =?us-ascii?Q?rBtGfTmU3ZQn90S+NS4iUBaoj/rHANIMcvUZ6g8RV0ccawOts84pdEp+KYp6?=
 =?us-ascii?Q?0JexKWmfW14dxNi49pD6JsFCcgX2Hwbr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0jN1anBBS1E//4j8UR7gdrjjTyMePhwoQLA6+t4YC+2F6ealHuhnEQhkBSF?=
 =?us-ascii?Q?+dh2hg0h93AsuRIAEyBWGIXWxztlxjzNj9gQFxjqTOLL1xIFCzFcmmsiVoK+?=
 =?us-ascii?Q?We0EG4jvy2hEXVwPbTQle+iAWIBhkgHwcRb4J2pfs0QWKOda0ebm/ZxK3Nfr?=
 =?us-ascii?Q?Xx2CqFkfeV0Q3S3Yiry96TE8MiP4JHK9l+GUumNaFDMqLU8zXcxQSHJofSi6?=
 =?us-ascii?Q?x7hyasQsud68jwc4uCTVaan7cX/Z27C8E4pnPmTlG2Of49YkqZGFJMv3H3vv?=
 =?us-ascii?Q?IUdbQXJ/KvMh7Z/snQn+gzYYhHmeWETuHiLYOM1OwufJkG6r2t/qZE4Y/7C+?=
 =?us-ascii?Q?IzCeRFxL5JuBgDlJ8tDkWUgXF9rAH2/cYpufL/LxAIQG9sc8DOSn+Wq1FGxO?=
 =?us-ascii?Q?VmGebQQ3vsGLrjyw6TByau0xc/O1gjUBrL92bJivQsnT9ieelJORytMv1wgI?=
 =?us-ascii?Q?DkXso/mqI3Nt7WOW8bnGLmPOqXHDht0kmuY6JIKkYYtvTvF4ulaLbTYjrGLF?=
 =?us-ascii?Q?6NYR/JchqjUDUSriCrupVOOsJ9hqy8twJcWzIXGLf6kUgWdgjFchOdlEAeu+?=
 =?us-ascii?Q?3mSUMZziup2YYpa4XoE5vZQUgqn+2YK6gP+47FQBN5hoCRRiaMXl3q4i2g/h?=
 =?us-ascii?Q?e1XaxXpNngza+V9QM71DIVJQvIOMLfWpQgFqlP5/4RmEMslSZJZp6PpYyPd/?=
 =?us-ascii?Q?haODMErH2L44XUAwvHvu2JdCbwmsCZMSRFCDiNixdvwusoblHMUa48lYvWDO?=
 =?us-ascii?Q?NPFwfsLKoAmMVD80F6Pf/p2Yz1JebfiqlsExlpDJm9sJjsVC9hFF378vyULp?=
 =?us-ascii?Q?m8y719k5ciiBx3IsYi1omoBNzP39f8RRDB0MgiW02l3JdzwmDoGXnrfITan9?=
 =?us-ascii?Q?jeqNBLwTInpr2q32JaBUtWqKXZGG+3kwd4LN9FC92j1gj4qX5fObbc7JFDW4?=
 =?us-ascii?Q?eu9lEe88Ucr5qXPPMIYcygvUNt0pJrrkxJISYjf+Bnj8nHPjWtj8N17KBYLG?=
 =?us-ascii?Q?s7KpU4DkUVa/mcoMLrRjKtNbpe4GjJfesU2JEd7lTclKoMxFbjhAPeuLttrT?=
 =?us-ascii?Q?DlesTQr/qkikPex+htAF2qLkDQhoxr6QJY3/2kszWi0slYMZpSwiZ2fFYALX?=
 =?us-ascii?Q?LL+/Ws2aQYwUnZ49wBAb2HclWr14ACn3LyMHtuOjUh6CnJLzOgVaGtPmKKL/?=
 =?us-ascii?Q?C/BVGx+IS+dETC8rUgPOaaKfbBqiFJAyvr/Tt9k4TIgg+xDghGlAaeVl+xZQ?=
 =?us-ascii?Q?KN8Cw2DgAdtOOv5HQC7AgYamj3YXXjya+KkSZc7QCW+AvIEFd//EC7ptdygm?=
 =?us-ascii?Q?JXUFeE9Z9VjvcYrvO1XZZEL6jz672YQH9smqr4D47Gh6FuUF2VptxnwgBGYX?=
 =?us-ascii?Q?OEO9+Yg5XTSe1gYxhmbaW2DoUg3nw2rVcvHaPiSgSql8QmlMI075XPrCcABg?=
 =?us-ascii?Q?A3FOyLQK/QQF2DXbtCUEZ1/FB3P69F5wznUTELeolMSSEaJlpyqHz8wmLFhY?=
 =?us-ascii?Q?mWpTlmC8c/7SWNY+cbEfUOSwLx7I4suN6/xJI8Qtr84tdk5YmOAw/AdgteFC?=
 =?us-ascii?Q?snWdsBiltns0fwjnmPYsX2O3eX/7UzQ0Jn7VAD/icB4YVtKS6hMcNkN3t8xn?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5e8569-4058-4d08-49f8-08dd5cbd167d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:42:15.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZ1qmS1YfmpJgxWqzjIu16fyPNLVz7lPvEnPaXofU0vCvCwihhuLDHulmpJJubaxKTY9Gj9jXBlV9olm+ChOVPiZH/SyTp6k5AajhQ7qzh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6183

On Thu, Mar 06 2025, Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Wed, Mar 05 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Wed, 5 Mar 2025 at 05:31, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>>
>>> On Mon, Mar 03 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>
>>> > +/*
>>> > + * We have to declare this outside 'struct pipe_inode_info',
>>> > + * but then we can't use 'union pipe_index' for an anonymous
>>> > + * union, so we end up having to duplicate this declaration
>>> > + * below. Annoying.
>>> > + */
>>> > +union pipe_index {
>>> > +     unsigned long head_tail;
>>> > +     struct {
>>> > +             pipe_index_t head;
>>> > +             pipe_index_t tail;
>>> > +     };
>>> > +};
>>> > +
>>>
>>> -fms-extensions ? Willy wanted to add that for use in mm/ some years ago
>>> [*], and it has come up a few other times as well.
>>>
>>> [*] https://lore.kernel.org/lkml/20180419152817.GD25406@bombadil.infradead.org/
>>
>> Oh, I was unaware of that extension, and yes, it would have been
>> lovely here, avoiding that duplicate union declaration.
>>
>> But it does require clang support - I see that clang has a
>> '-fms-extensions' as well, so it's presumably there.
>
> Yes, it seems they do have it, but for mysterious reasons saying
> -fms-extensions is not quite enough to convince clang that one does
> intend to use that MS extension, one also has to say
> -Wno-microsoft-anon-tag, or it complains
>
> warning: anonymous unions are a Microsoft extension [-Wmicrosoft-anon-tag]
>
> Also, the warning text is somewhat misleading; anon unions itself have
> certainly been a gcc extension since forever, and nowadays a C11 thing,
> and clang has a separate -Wpedantic warning for that when using
> -std=c99:
>
> warning: anonymous unions are a C11 extension [-Wc11-extensions]
>
> The -W flag name actually suggests an improvement to the warning
> "_tagged_ anonymous unions are a Microsoft extension", but I really
> wonder why -fms-extensions isn't sufficient to silence that in the first
> place. Also, the warning seems to be on by default; it's not some
> -Wextra or -Wpedantic thing.
>
> cc += Nick

Gah, sorry, I wasn't aware that address didn't work anymore.

So Cc -= everything but the lists and Cc += Nick for real this time,
hopefully.

Rasmus


Return-Path: <linux-fsdevel+bounces-43329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5141A546E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF759173A18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38020E00D;
	Thu,  6 Mar 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="UI587/8w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4120ADCF;
	Thu,  6 Mar 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254537; cv=fail; b=i6XQUSfZ9Hd7+9uyxCWoAD39Qb4aO6YCqSCpMW8cAHo8a/0B0UGbJ3atWT4NDWWJxsBYXDbXctCUL4vO0i4JKTtjpJH09PSYF30NiYuSoRE6UeVEqkFJTs3b1WVJNXhWVo4kac63WmBr843eGEmt36ZW1DrLGo9d9QrjDLhHJ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254537; c=relaxed/simple;
	bh=WxnU4335Jv/nBOEd0oJdzlCIKFKaaMrYfsP0IrWaFUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=QhPTpykgK3kWt+HMy0MVd7DD68SAAXrBFM5BCQXdKFtgkGxTX8AYv67XJHBSCFax9O/6icAcrb5Am9/KvvczCTSVMHrrP78Zf6wK+uB/QGip5X9B+roSDQjj8c2cSMQlfGUdPGi8GtHRTS/TfonGwjR4wijc9srzUpTsDLMyHuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=UI587/8w; arc=fail smtp.client-ip=40.107.247.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLVlxxc3DktEOQfrc7IpXLW69i/Ej6ggc55yS5vfS7bkc04dLql7/OlHD9ojfKCIA8y8FVEyV+yFbmrv6ms5nm8q3sMq+akuqoRksdwe6pN7R3g+MK08kkamhyf0F1/PyflHIgU1bolPDRcwr/Z2rXlGJTKZ+CQ/K4dyrT92TlCntIJ0wpwJh+vo+qDCvX3tBTyCcl65YuqskJRKHwBE2yQklQRhh3OpqsFnRkhgfCRlLHgnjRqVEjF5KFo21NQULLqerGYp6ga5p6IyXaICCoZNXTldc5jrEog8UWiB7Bf5EHygzudiBx/r9VfctZGpcZakdMBYJOiWzMgoCpNsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZbODXkT7rHR1AeCMJZZuuuIRKtffZq4jXCq7AXQHB8=;
 b=EpDR2S/uN9SegvNU+mNN0SFgrAv4TZu+Wl1+Ulb9+BXqZEA+HFKyGUZI7n+heFrWWIq8S5eet0M1YezSY12S1he8VIQrNwnti+iU7+wqM8FOXd1KImzJNJ+yRkOo2a1woKJH80KmIKdZrEx3FUT5K6tEvarXMRe2HaNRUexXz0g86iDImliSf6+Ugfzu5QE0PbTZDOA3touy4378U8X4n/w2EIKJ8ZTLvrp1wHtCEbJwXTKoAkT8GjARauLhSrFsO0HrNvLFHiH3GLMbfQRF0fJcKmCCdn0EQ1/V2ETRQjw5c1YjZdaOEdNoFgYgIPWIRYUbsFbcmkAekIXbnjDfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZbODXkT7rHR1AeCMJZZuuuIRKtffZq4jXCq7AXQHB8=;
 b=UI587/8wFhC93yPuyUl8XlOAf8zdtin2ESz8bMGE07mY7fXpa622BfSDevvCCcMvzqs4hMCiUQx97EdJj+949JNDWpins2RicFxW6Gd2JSeYqAeP4B2p7YwwoJGu3EKbQUGMRauIxM1rY4MmRG19lH1LPrB+RUHE0JQVvnl7Gmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAVPR10MB7091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:317::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 09:48:46 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 09:48:46 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Mateusz Guzik <mjguzik@gmail.com>,  K
 Prateek Nayak <kprateek.nayak@amd.com>,  "Sapkal, Swapnil"
 <swapnil.sapkal@amd.com>,  Manfred Spraul <manfred@colorfullife.com>,
  Christian Brauner <brauner@kernel.org>,  David Howells
 <dhowells@redhat.com>,  WangYuli <wangyuli@uniontech.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>,  Neeraj.Upadhyay@amd.com,
  Ananth.narayan@amd.com,  Matthew Wilcox <willy@infradead.org>, Nick
 Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is
 still full
In-Reply-To: <CAHk-=wh6Ra8=dBUTo1vKT5Wao1hFq3+2x1mDwmBcVx2Ahp_rag@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 5 Mar 2025 06:50:26 -1000")
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
Date: Thu, 06 Mar 2025 10:48:44 +0100
Message-ID: <874j065w1v.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::12) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAVPR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f41413-9e45-4dde-4d71-08dd5c9416e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xaBsUSiF4YtbPH7qGe2xgLzo/AP75SQ0Rovw0Iv8F8ZsUeelV+Rk2kWWXGGG?=
 =?us-ascii?Q?15SCBbbMSh2L/9o6iAe54XyJRfKFdvMKA38lfmqPnLrkt63fcCZYVMZGg4LN?=
 =?us-ascii?Q?HXlMnYcuCwVrQ5gnjNiNuSDHPjQprJQM6sPJIyaQcq/bA9N0joGxW8RX7r0V?=
 =?us-ascii?Q?px7RzD2tdZfDDHszfBPbmYkt7mpCidEnMN6f1sMHatiF1OuDS1dS9XH2dqhz?=
 =?us-ascii?Q?6y8UUErEaSRtS+KfPRDKYKXOmBmL47GogFL6x8dsOqJ6cKUKw3qealOOhFQi?=
 =?us-ascii?Q?7S1IQKKRsrSbu54R4JvbGHZ7Ai7yFGLKvqzV6KjB9pZAf3MXJ7o9T8+uA0FN?=
 =?us-ascii?Q?Oc7IeC3qOmC4DQXcuboQJhoT6hWQxGcQ4XS0TrN7xmme8XMsYUaxCYeaa13i?=
 =?us-ascii?Q?9HzQ9K/uooN2S8GPHVhmxdPS/QC4qVmHAc9+BeIr2yc2q+v3d9ePswr7qFp0?=
 =?us-ascii?Q?b0Kv1WKT2AFeybLfnEjBkvKgcgvduhyrIi3uh0542xszcu9xBM1A1Y7KUJwH?=
 =?us-ascii?Q?1B17qZpOZ5/s4s8zOu8b3773NiaE0PwEoY27t3MztRTdWQoxo0E5fnO9+2Nv?=
 =?us-ascii?Q?aJI2HYoVELhd3F0VjcD8JRViTdPP8uF3HojZwqGM5mWpPg6AZg8K4hVcAsc+?=
 =?us-ascii?Q?yMw2uMRlXq7TJiOPXADNA09ZxBgKbV6uxLFnSb3HOoMDs1ccSGDbzbrOPwCf?=
 =?us-ascii?Q?pQbf4dzJwJZXYFIAoxR5RHUQ3iZUTYJgXE9fo+Z7ns+8v7GdVaxXa+nvZ4eX?=
 =?us-ascii?Q?smnO7LEU2aYQVxfbVwzNzMN+SBjSnDkU+QxIh4kH8CAN9hF8iDjqUpvhFppE?=
 =?us-ascii?Q?8wwa60fd6A4kmZlFeZaJBd8w1FMwZrn9nY8nGWWOfdF7pHQo41SsbmZBGc0Y?=
 =?us-ascii?Q?df+IgcVEjCSpbFxDlzQsLYMenSf5w4Uc5QEP+9MdjHEah06xdeo/d8TT2SVy?=
 =?us-ascii?Q?eK25sSpTqNaRGojGTHXbhUq+ek83GBWZCyqODUfFh8Wb70GWMCOQCGJmViwI?=
 =?us-ascii?Q?PR1bWdhfut3cmlK8NcoBEtOEmTcSXfPL8chpDgcjs/NniG17LDFqTnCWJ/tr?=
 =?us-ascii?Q?G+ziJTe6saICgRai74tkSDBBAR0pPgJ9n8aoo1wCP8wowH690fIpJQgHBAs6?=
 =?us-ascii?Q?kqqIefWrCy5Fwe7QAYNVCGkjXO59YBCvL2iRdF2qAsmhJha4t2jtjCbldcbz?=
 =?us-ascii?Q?DbsKO6qMCiV7eQ/oqt+hkYyhjmfPpn1zfIljaZ4a3i/jfeRwguWL1F7/J4F9?=
 =?us-ascii?Q?zSLCtVXwfzo55Qgz+DIISk0NWDoI89oiA62hBiA/KeY+vkNQUMjTHcKN8ku8?=
 =?us-ascii?Q?vv4Pmga68LvjLI/Cjs5PlY+8iZQ9UhR2REBgwyzzeEtKRfv249I/uOHBfnYY?=
 =?us-ascii?Q?LQX4PKYCxHSbRvY3AKY6BjIuxP9kN6VTisUQtX3lY9XG2aCYoFJtGR21PkcD?=
 =?us-ascii?Q?VGadhVfKXSJt5/eYk9cpTiS7aHv21CPi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHVeiPkHFtPzDbxIc9v/bfjQJADYR0HCOwQd9AUgWbo9i1F1ZW4CCL1nUzm/?=
 =?us-ascii?Q?D9MqaelmCDjsj1l+/y5hijBCPBaWhNoqD/gzRJn/lolHcGTDQ4UXiGV36kHw?=
 =?us-ascii?Q?stl/tqhsxHzSPtIFK9C3fucBsB7ZMQ75eGCl7SIjl5RZJIwXIeoqL5r9ZkD9?=
 =?us-ascii?Q?T6xhruunKc5wMv842cOYQh4lriXCANVZ+eLyTdUOj8/GEREp3I9GMAyVWPPj?=
 =?us-ascii?Q?x37Bg30c5GsY99wBHRqiu7ZpjFp2IfCAZMKrIZeFhCD+N4zGqJqPJBF/jrU9?=
 =?us-ascii?Q?g0UtiHgqLSkl8dRA7seRtJxP2lbXIT6/lDPO1dhILoQnuvdw9tRj141PohNd?=
 =?us-ascii?Q?KcFwFyBKJnL9gSUMbZaXx5Cnkt3hnkhgGhB67vedYkfyN4VfEMrG4tbpv+YM?=
 =?us-ascii?Q?mwMYY62Pe8m1y+OOe9nIJxKo9OC3/q5u9enX7UscJxX47g6No/+X4Cik/4ki?=
 =?us-ascii?Q?J8Du1bYAK3r91Za4NShHpQrMEhFiaN5eq7XV9YzkFK9sRz2C1uf/EDRV+PWw?=
 =?us-ascii?Q?JvSsUAOynQXnOIrMyZyFi/HJt2pAUExgBAgoE44w5Z85lPakSIAf9iyLQLc4?=
 =?us-ascii?Q?2/oy+Bs47nfW3lxC9on87isI7zrQ0/kP1j2zMBqZHpMBCoWkIBeDrme870in?=
 =?us-ascii?Q?i7xjtzdP7cczFRmBvMmM6Hiw77ZR0Ajzt/caB8prietAsnNdlKKGtY8av1lz?=
 =?us-ascii?Q?b+GKPLICKr/xpGLXVxNb2/hyP3MLkGQ824x7I4l1Uk8l+TuN0ScEKZpWY7Fm?=
 =?us-ascii?Q?atnjwirCUadPQIVTNOglYQtscLh+CUhjwmAReaaiK8wg8T4U7g8PaLbrn0S0?=
 =?us-ascii?Q?bmW0BrV7x3GmGfmMFsQ4GcDTUb5wzFw+9mY3SA+BNCDamEQ7C6Gz2NwVBEyM?=
 =?us-ascii?Q?LAPshwAbD73DFRf/D1n+bqDEPk7JICOdJ6UhCvd3RVDh1FyarFLNkjVXrqoU?=
 =?us-ascii?Q?LCK9GU2qofIUtG7FMPbEutpiTYSkewLmN2yEANI0Ik9fZLSo0wdQZ5V9G6aR?=
 =?us-ascii?Q?Kq6TAeDfAs9Geum5dhMd7ZymLSx07iHvZCMVkWCAwwqUn5h3KYYeRZVM6dgt?=
 =?us-ascii?Q?vKmyGI0xjedOlhqRke2gbxr56ZN6IJ1lgLuUJQFvTc5/NtXyCrFygMTDJMx9?=
 =?us-ascii?Q?8cuyGHlbYpNXHNJSDrRcYnUQvfzxxDp/ACESgQuAbrksk9CwVIeEFwLNoztl?=
 =?us-ascii?Q?NfjRCXGuyx1nq8zkr1Y6+9I1V92MxpBZR+CTQE+21o1v1+NRbNRmVswVprOF?=
 =?us-ascii?Q?BhHu9XOIisxwIWGLxPCRrD/dsEh548742FIXx8ve/qtJbuZHwDwfgP6Bc9jv?=
 =?us-ascii?Q?CLv/ry/dEhCwPj/xfLBY9yyzc8bU4YU9qHXMNGVH6yzop/IeK23JuE4BGJzO?=
 =?us-ascii?Q?tK+vyu7BH0NqTg4dVxPBLyFfRQ6HT5e5lUrdyU2UiydPyTX4iAD4fZv1raXO?=
 =?us-ascii?Q?kXGWbT7QcNsszIDs4aH2gpSb6L3vRgjxp9LccIO/VcgRDDoK3XrvNbu6k7O+?=
 =?us-ascii?Q?sYgJRKQv+BSeZtSDqqQbu8FdSLVkACP0euAl5Ku3zZIrUkCr9wwmJwaJ7BfY?=
 =?us-ascii?Q?3X5uAsKzue0cBBas4FMnD4NnP1Dn4kCa3SRKKMGW52H34TZahbwegUiV2P5s?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f41413-9e45-4dde-4d71-08dd5c9416e5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 09:48:46.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcS0RoRQ8aA/yHFXoFQrp6oN0ntrmPhAD+6fm7PyV1+cCzoyiM74C0hMQO8UoEQaprQdYlHWUkYoNXbSZyF9BAXjXv28NMe5DlOiezt6M+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7091

On Wed, Mar 05 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 5 Mar 2025 at 05:31, Rasmus Villemoes <ravi@prevas.dk> wrote:
>>
>> On Mon, Mar 03 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> > +/*
>> > + * We have to declare this outside 'struct pipe_inode_info',
>> > + * but then we can't use 'union pipe_index' for an anonymous
>> > + * union, so we end up having to duplicate this declaration
>> > + * below. Annoying.
>> > + */
>> > +union pipe_index {
>> > +     unsigned long head_tail;
>> > +     struct {
>> > +             pipe_index_t head;
>> > +             pipe_index_t tail;
>> > +     };
>> > +};
>> > +
>>
>> -fms-extensions ? Willy wanted to add that for use in mm/ some years ago
>> [*], and it has come up a few other times as well.
>>
>> [*] https://lore.kernel.org/lkml/20180419152817.GD25406@bombadil.infradead.org/
>
> Oh, I was unaware of that extension, and yes, it would have been
> lovely here, avoiding that duplicate union declaration.
>
> But it does require clang support - I see that clang has a
> '-fms-extensions' as well, so it's presumably there.

Yes, it seems they do have it, but for mysterious reasons saying
-fms-extensions is not quite enough to convince clang that one does
intend to use that MS extension, one also has to say
-Wno-microsoft-anon-tag, or it complains

warning: anonymous unions are a Microsoft extension [-Wmicrosoft-anon-tag]

Also, the warning text is somewhat misleading; anon unions itself have
certainly been a gcc extension since forever, and nowadays a C11 thing,
and clang has a separate -Wpedantic warning for that when using
-std=c99:

warning: anonymous unions are a C11 extension [-Wc11-extensions]

The -W flag name actually suggests an improvement to the warning
"_tagged_ anonymous unions are a Microsoft extension", but I really
wonder why -fms-extensions isn't sufficient to silence that in the first
place. Also, the warning seems to be on by default; it's not some
-Wextra or -Wpedantic thing.

cc += Nick

Rasmus


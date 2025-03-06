Return-Path: <linux-fsdevel+bounces-43327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CAA5464B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 10:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4001895FB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C7209F2E;
	Thu,  6 Mar 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="JWex97/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013010.outbound.protection.outlook.com [52.101.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CE20968E;
	Thu,  6 Mar 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253336; cv=fail; b=G7NHCrgSSpe7yWcCZWqIEgnSZRtDbU97+h6Db33YhqsK2nZourgfhM0BxMJItRjZnUD33EiWMYW9/3FXB463HjFN1NHx2uO+VRf45fLompPvZLppmK1ZTUIVEUDUY1DXVFc24yEEvSeTPpeZihvMMbJ/CwySVJKIh5tNYSPcgR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253336; c=relaxed/simple;
	bh=5Ioqcorjv3trBNRWYNnuo7wUFN6mpVHSvbLnF1JAytw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=G23XwyFi5UCl9BcrVkACt+5CJkjXZffBYN1S85CEZt3oSGXcVIkZAfD25wKXlRHViBf8n39mEBi3dUelROaj49MitIbB31ow8QXUKJT09hnzoTu11B2EVvplWp+vD9Xq4zLGaGVnpHRBVWr1SqQ854NmSnYM+kjyQADLwlWPY/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=JWex97/o; arc=fail smtp.client-ip=52.101.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEG+5dcpeC5Q8J/1YJvsGO5xhlHMdPzvijlRAL1Va5QaWEG13Xd3HktauD6lVvDFpeXjtY90yok8OWL6MwGHP5h7OfgHDetdCwXKILFnyd4qbDclcigCUuXTBwdSZrhUHpjAkyiaCLZqPi/fRDJg7BDHkoqPl2+AaFp411mClXRSSnaUkWDPfwCE0Ncowy1y8dTPzMEwqS4NmSMAzukYAF5EN812TqhlHJZFtBxIlOAkm8cORXWzLq2vV1xHVspQUiVixalY30iaBRBFg1BLRvsHDHf9um1g99D3uzgP/JsO9Kba2JWMO46AjBNnz14Zw0QQ2k0YpXylq4kCLdrWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW8SmfGXP7KGwJZC6VXBdp+4jexHMpAXx0kCQ9UPC4U=;
 b=LPxEhmvcMsxXiy3CUpgAGQogYZCUEMyWlWuehdk7cSe+g8aX1+MBu0QSqTNEt+9qRpTKsDZu1Nu3kQQ5sITGK36Zlwdjrv04FP6laQBx6LodoUtScPuyD1VI5WHSi6UP6NEXeVjLHuRok8hu6hciIangcKM8C/SYj6S3uOuPpJwt4gl/886Me91raTqAKhOR5uu3s3CkwgNXgxDbtEVWUCZY41zUpERE6S44tHk3rkXjc+e9DNGZyoNtSaj0cl4zV5XDYrcgfY0WjweeOnzhBx/vufEqG9sjndMJpQZwdv3k8WuetIpb+FWFxQKFOK7W5KmoCsKyKUQFedOTXy2ppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW8SmfGXP7KGwJZC6VXBdp+4jexHMpAXx0kCQ9UPC4U=;
 b=JWex97/ogIjfC3Wlkt8pFVrQWKNNiOQByRFaonBTjT4fWTgJpgiD14gNOjX3sD6YOj4MkRcfIkHgKVKdvIHHKHItJ2hHUh1ktziRIkyp293yvhzUff753Leu52hOXiDBW3oZgfcrfJxfuEHTgmTNfCMAHB2lr9Tx3h0ZDkalSoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PA4PR10MB5754.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 09:28:48 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 09:28:48 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Mateusz Guzik <mjguzik@gmail.com>,  K
 Prateek Nayak <kprateek.nayak@amd.com>,  "Sapkal, Swapnil"
 <swapnil.sapkal@amd.com>,  Manfred Spraul <manfred@colorfullife.com>,
  Christian Brauner <brauner@kernel.org>,  David Howells
 <dhowells@redhat.com>,  WangYuli <wangyuli@uniontech.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>,  Neeraj.Upadhyay@amd.com,
  Ananth.narayan@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is
 still full
In-Reply-To: <CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 5 Mar 2025 06:40:38 -1000")
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
	<CAHk-=wjyHsGLx=rxg6PKYBNkPYAejgo7=CbyL3=HGLZLsAaJFQ@mail.gmail.com>
Date: Thu, 06 Mar 2025 10:28:47 +0100
Message-ID: <878qpi5wz4.fsf@prevas.dk>
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
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PA4PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: be08770e-8bd3-4969-7c0c-08dd5c914cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qku0ccT3i4asRcgcP7n97wcJ18kL4rp/bfsRb1HTrwG3sLPtp8IOrd6jykGM?=
 =?us-ascii?Q?t7/nbLwPpYNE7y6TApIcygyvFKUcEMY+SEP5HSOWwSTqp5T+OyjK3j0UE5KE?=
 =?us-ascii?Q?QNzQLJ7G4zxzZNTs7DyPJXOsyx6EL2plCTE2JQi9v8Z2vd/vTxpTz/IcqFsJ?=
 =?us-ascii?Q?xqUGYxjJlD1o2+sIDiEW6rGk0MUcFCEvomdqCLHZrMLqH8oXT64q3VVIufxN?=
 =?us-ascii?Q?FMtkG7bx3wfRrm3s9u2i5kGnou7+U90XDs8rF0odMzEvJor0i0d68ZH9J7Bk?=
 =?us-ascii?Q?KUF1x7lAhMwwsZSPe0y/Kx3IN6uBsengsMyYMsiAh0+qHAnPHT1Bd5GF5j59?=
 =?us-ascii?Q?TEEF0TiN6KPzDXJ/6NqeJrqHxG5xZhCoesC0U8TidkrtiSvNHiNRocfnHUQV?=
 =?us-ascii?Q?BynV6loT4kfIl206KdaLFiYkDR0xlF1CL9+ZwjBkPlNHOWaCJ1LFs+LPauLf?=
 =?us-ascii?Q?dcTdrz7QGieGWvIF2eayln3M+u6uGUN1C/Mhpec3sIavelf/fvQk34DGd/8+?=
 =?us-ascii?Q?AwTdtp3ebpuGtJimCNzMuClxlwuxAtI9ISSGnZd8fNBCekipJCegxLzKXnnZ?=
 =?us-ascii?Q?zbuogrjcYOJr4W/yXgZQdgwmqNCw6bcVtI/WzZkDneV/E/sQ+RTleX8iIQha?=
 =?us-ascii?Q?HjnSNMYPShO38LTQh9b47DW60QgDaUdzlGm7VaSZ49B2owK2dXBwWbTspzSv?=
 =?us-ascii?Q?spQMXDd/H0G8v+ERehIS6LkbelCN1PDrfcKbztIDJs7bImNqi8K5owIhRk8C?=
 =?us-ascii?Q?OzOYWXcPMOupb4OmiRE9StW/VVT4AhP98M21UPJ2/aILZSvVS6jeag7DT9QN?=
 =?us-ascii?Q?NMd4YWXPyds7rmyXdFgkC/Jsapfp0L32ZWVsviPG6q9Ow4wxUBJqAz15zUeQ?=
 =?us-ascii?Q?nxgCPZRRvs4lmuQ7Rc2Zc2U78ft01L+5jld+LAJWeuIvQRQ+6JPirKTCiSzh?=
 =?us-ascii?Q?QdG1Ue7N7vJDROFA2CCPm0rR6ZfoIVFTp4NePJXBZkeFzoP57L/4CY1MxGq3?=
 =?us-ascii?Q?pUSdpn2EzDels/ndRPmMA5Sz3i8OWRH5xg7s7k9gcex84HoKkY/ezIOAxjeJ?=
 =?us-ascii?Q?a6b7lSctkQexEHxmUjUGd5pNmsrZZUr2xc5DzPkFmvNNd6AR3d69lsfRgoF3?=
 =?us-ascii?Q?l7H9IRlLNQWYwF/NiMyRML1CRePWT4Wlnq4r4tWE2ZFqawU3t39WQAscf2S2?=
 =?us-ascii?Q?e8+RDoQ/pUnBTCnnDd7lA3lKeVjGXr7J784D8yDuZ8LE+z1y7CZTgdx9hkJO?=
 =?us-ascii?Q?q2DGilhMzpcr9/cId1xF7aIjH3T7r6B8bDC6qfj9t4T6pgMhBIz2oO9vAPof?=
 =?us-ascii?Q?9bJdJNwJPvpht1E5erV0TQn1c80tNuo/qmOOeQuowBDovz2W964IoBPEUqNG?=
 =?us-ascii?Q?4PUxbC1zDS/QG2plp5VYdGl2634HTzFZBtUfoKqkDlaz9w1iAnVhUCNFC8oN?=
 =?us-ascii?Q?py282aXwS4Gis2TbT5BzXDxTjd9q6V/3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGyQHtXvZmw4BiDLkKtWahSXs0Ten2eIjpoj8dWoEa7g2S9Qa2HnLQANQyhQ?=
 =?us-ascii?Q?v1TeAemMz0nCFK8y0698G9c3CMWpuPpS/uyrw7DkhE0yVXpKqNzcQD7E8F2I?=
 =?us-ascii?Q?modK1DpO5kIKlHfpw3RUlWMnuI3Z+KgSrOpYZQBwN3lnMPD4U0exTGIJlNHO?=
 =?us-ascii?Q?8n1sx5McbQwNf4E8uDJs0o6c7yPxlUp+/pnD6Ln3v7mX3dID+IoVJVvTqPBF?=
 =?us-ascii?Q?XLpHzYvDnINV52k01S2RXGm/vrFTwzjqf3VDNFpgU8/N4E0NUYKZ8Ye0xenp?=
 =?us-ascii?Q?okXUNUwd91O6eMGvjHpD81i4MfN51LYcY1aShT9R8zZ8xIwxBZcAXaQHzedl?=
 =?us-ascii?Q?1x/gfSCeSNr1MFoUZEqIv+Sw2LLwM/pkG5P//SeW4nmNjUOTC/4/lF1QeDK8?=
 =?us-ascii?Q?7eI0MULD8q4M9TJUWsWTC1UQP0lwxXcW5r5wdbcy2NbzudyjcEszErcT3Rrf?=
 =?us-ascii?Q?HBMka0wXRD6oStVrM4c0/KiJvTA7Lce2dJkPVR491XKCVxQnHMEXa7F7fCyl?=
 =?us-ascii?Q?xqA6knagqkxvI183LQY+S/m41mkOmRqCITp210MQKQn+04nmfR14+yFrC1gK?=
 =?us-ascii?Q?8AVH9OLm2AnC4QAWIZiBIUlwAWFksukfpSjUq3+OAnuZ5GJxVKYFfnAkQvTg?=
 =?us-ascii?Q?NIkEtH9sL7YjL+GHvZ+EIvTHgnZ33wzKIkgpVkTkX6+2JJ2J4hhZnBjWu3Qy?=
 =?us-ascii?Q?oZF+JhoXZ/wMhYpJm//8IlEyFewltMy7eLRmVGHEOI6VBI42GIMbTmK7dxwM?=
 =?us-ascii?Q?yzJVzVYkuGG8zunglcrQbJa1jVrWdd6sBbYwcavP1RKgDQiVuDKG66rd/eVw?=
 =?us-ascii?Q?7zh0aUR/Op2VKs6GMl15y98fXHVDJ5kOxDDdhC9FYf/HwZNV/NvmR7Y65l8n?=
 =?us-ascii?Q?AvFLlrjawtKHHlhYPj0tDOv5TuYNovzRjLQergcincjNBViD79wig8a/yJf6?=
 =?us-ascii?Q?kVCnN3wfXbORq3LlhdLX2p7c1ggty9QevD0VV42PGdTItYTkO3XBbBIxdyg8?=
 =?us-ascii?Q?l3EWgLws2QLHVEZzIi3+3HxankI5ZkmHpNavJ6IDgCSXpjjhUaeOz80Nk8za?=
 =?us-ascii?Q?jBu4xoIW+d9uBnJpUfUU8WkNWk82y31cpEU5e1XMfcy9Lrn/A0xsZ/tFo8mH?=
 =?us-ascii?Q?0NSYmKphgXHXAfuTS0Uk5sm6AuXILrexjFuS/xHYjzemT0R9rLUZxtUB80bl?=
 =?us-ascii?Q?u/KAP5MNuszeIpLCMxlc19Oj6XJkzBynGDjJXVHvidZzjUzuJsfCD0ADoB/Y?=
 =?us-ascii?Q?P9F3ucYijRESJDAGNS6tJ1J1npvrtDaVlc7jV5T8sOTvCk02jyMVsRGXv3jg?=
 =?us-ascii?Q?hgP6DZohF260wy+lfY7WOSIAYPqbjA0Km+89GWPn/Y1vXl4qXCiu458OHX9d?=
 =?us-ascii?Q?X8+XKVCRU1qrr4ccKZyDjiSpXGfQAu3MO7X1OdHkP2hjumgQRhBuzuW5YUjr?=
 =?us-ascii?Q?JvPV/5bharIfcNz5oBHeRijgjirCVmfe1+VpraF7fORuyvqS5SbkLv5fGwSK?=
 =?us-ascii?Q?ZlTJQPkbEdtIKVIOUj7qeDuBV89cu08ltoo0k03tez47hyOtDmLQzV9tNPKB?=
 =?us-ascii?Q?j03FHUI59nITBUji6K6vhBWjylVOXRjhESEdoz25PtiBfL0VismaYkkm5rqZ?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: be08770e-8bd3-4969-7c0c-08dd5c914cd5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 09:28:48.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbtNIFDDPE90Mz84iKzePjCWEfwzXNdSW3IGdwMYWlm84RsrwovOHaKmCau/FtACsNaKXwh00rj6yIBzcLeAM2+k2ZWT7FtTqN+wBRnNULo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5754

On Wed, Mar 05 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Are there other cases like this? I don't know. I've been looking
> around a bit, but those were the only ones I found immediately when I
> started thinking about the whole wrap-around issue.

Without too much brainpower spent analyzing each case (i.e., some of
these might actually be ok), I found these:

fs/fuse/dev.c
fuse_dev_splice_write()

  unsigned int head, tail, mask, count;

  pipe_lock(pipe);

  head = pipe->head;
  tail = pipe->tail;
  mask = pipe->ring_size - 1;
  count = head - tail;

Open-coded pipe_occupancy(), so would be fixed by using that with your
fixup.

A bit later in same function there's the same FIONREAD pattern:

  for (idx = tail; idx != head && rem < len; idx++)
          rem += pipe->bufs[idx & mask].len;


fs/pipe.c

We have pipe_update_tail() getting and returning an "unsigned int",
and letting the compiler truncate the result written to pipe->tail:

      pipe->tail = ++tail;
      return tail;

pipe_update_tail() only has one caller, but a rather important one,
pipe_read(), which uses the return value from pipe_update_tail as-is

                 tail = pipe_update_tail(pipe, buf, tail);
         }
         total_len -= chars;
         if (!total_len)
                 break;  /* common path: read succeeded */
         if (!pipe_empty(head, tail))    /* More to do? */
                 continue;

and pipe_empty() takes two "unsigned ints" and is just head==tail -- so if
tail was incremented to 65536 while head is 0 that would break. Probably
pipe_empty() should either take pipe_index_t arguments or cast to that
internally, just as pipe_occupancy. Or, as pipe_full(), being spelled in
terms of pipe_occupancy()==0.

With that fixed, maybe one could spell the FIONREAD-like patterns using
pipe_empty(), i.e. using pipe_empty() to ask "have this tail index now
caught up to this head index". So "idx != head" above would become
"!pipe_empty(idx, head)".

Rasmus


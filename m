Return-Path: <linux-fsdevel+bounces-43273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0538A50380
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E670188B8BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8B24EA82;
	Wed,  5 Mar 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Fmr+C0me"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2088.outbound.protection.outlook.com [40.107.103.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF113AA2D;
	Wed,  5 Mar 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188718; cv=fail; b=qGVak4tlwL1kkG8jCiQ14NVFOPC/VrLyPH7gZG1DZTjhH5pwAZtLKge0xfQ4V5VoGM1GPycAgG10v676UoxujcoJauPs8L1yBeYv7AGMwmFdHhZJ83tLDo2yw9BNixRAjzd14602nlQHo8YSkzE64GuZEz71FHL+qPLz65NKRhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188718; c=relaxed/simple;
	bh=Z4D9pe5DDplyxWfMtL95oTCz1AVDETJ7ltrVGaAV/P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=BslxripIR2NepMcICooSB6xWYD3McviKQz2Wsr3qg0yuF0jcaBp6XuNQ8W+2meaZxgqlocFTSi4WkqucjQFRfyJBw6GCnRTkZ1ps67zR91NNsQbb3K46whIuGPN624+IAlZb9slAmWY38A+CYCjdYlykDzHPD6J5OwP6Jd5yqAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Fmr+C0me; arc=fail smtp.client-ip=40.107.103.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mS6FCeK2nY27WxhQs62t2LU1LC/TIy/sa0jxo1f4Tt7mHQwISPyMGFQ3sOCPfZmSSjm6Bzyx43O3d/YDR8qNcfHW4WGyWvEiFtCYl87SFk2PaVZqrjOwd+IVGcitqJfQVBysX7fIswbz4+sBbjRmeLSwhN/U3YR+K6PHP0eBXOx6orFZzzvgIUCVOYeshwpgC8DSxPcRZfbVqd5b5yfvHS1rjKamqGtlrTeBeZayHWxaZjLxInPniUIWNIEVVr3ia4e9DPMyR0jx/om8n8x+ZbXqYnCJi9rl9XXaJ4U8zDAXp/FXK6s64D/BT4JOTlVhZw3Uet4ts9NX3sDzk/fTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrRLkda+/ayA+SGYsuWdegosvea75rGQYCPNhlNI4Zo=;
 b=AVCeAIcBcv8/hupt016B4mZeEwXj2j44UUj/omBVlKI6MB6lZywhTU4X9b9kITpXkC6X7X4eSknS7fwkBGwRyOUXZjT7/qXEwqf76PaKcAgXXjsz6ibslzmBbN5MBI+697n5sZ3Cvie0DTTqsD2mxamn24ZHe6dyjh2cEgAmihWlPUxBQR0mI39Ft2bEWCY3+kKC508IOUxz+3R5bQh4xauyV7DXgVkR3ZBO7jrfrihC/u+gfH9XrZXqQRQbgS7r+41IeMq946B56COCe720kxfYZWzeZbKPqc7ZWt8isi0Alb9t8+yWlQS3774eso2Wuep50JkkivQAifmdwGqQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrRLkda+/ayA+SGYsuWdegosvea75rGQYCPNhlNI4Zo=;
 b=Fmr+C0meO0phtojZmaOaCckdbakce0kBzbZr1lRTpGTj6TeFVjhQ2yQmuGX7Ybdl3Q03mynQfH1EYTa67VtvWnmr100hAMS+eN2RsN38brjhv+S4xv3gPufyGvJ0pnrkgx2eKCniwd22Cgm5aJGnlJ2xbI1Jq13Nrfyf7GjWQuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:87::20)
 by DB5PR10MB7752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 15:31:48 +0000
Received: from VI1PR10MB2477.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e8:da5:4265:ce59]) by VI1PR10MB2477.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e8:da5:4265:ce59%6]) with mapi id 15.20.8466.028; Wed, 5 Mar 2025
 15:31:48 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Mateusz Guzik <mjguzik@gmail.com>,  K
 Prateek Nayak <kprateek.nayak@amd.com>,  "Sapkal, Swapnil"
 <swapnil.sapkal@amd.com>,  Manfred Spraul <manfred@colorfullife.com>,
  Christian Brauner <brauner@kernel.org>,  David Howells
 <dhowells@redhat.com>,  WangYuli <wangyuli@uniontech.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  "Shenoy,
 Gautham Ranjal" <gautham.shenoy@amd.com>,  Neeraj.Upadhyay@amd.com,
  Ananth.narayan@amd.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is
 still full
In-Reply-To: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 3 Mar 2025 10:46:10 -1000")
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
Date: Wed, 05 Mar 2025 16:31:45 +0100
Message-ID: <87h6475w9q.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::20) To VI1PR10MB2477.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:87::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2477:EE_|DB5PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f80764-2173-4675-d3af-08dd5bfad7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dP3weQQTe42EQGqZOVI00TjMZ1/o8i5YZVVELwF4CLJ3JDBXsxTwhm1KkVNw?=
 =?us-ascii?Q?jwDUEMj1P1PxV2Mb/Am1nVE/aT1cgQkOAjoMKMXeAsNVgJ/X3y7lKNXLXLvg?=
 =?us-ascii?Q?XAG9VeSZXkL0ZOrWE9DppzvVuueJh2QdZW1xqWyvwZfRHC2rPd6QKBC4ZJ8t?=
 =?us-ascii?Q?CPSNvGsKYdl5rVo3x0op3kwS1SGx38+4OZn0gUU/Od8XOARb7ymEl9D+aFA8?=
 =?us-ascii?Q?N7T55ReGudAkGPvb2mnF1nDgb2lb9nxFghK4v4o7Iq/uWX4n8Hkyekvst9EH?=
 =?us-ascii?Q?Be0PldeQiTGPLJS66NeSMJimcz0/vcaajg8gtq6bzaOP4zg6Q0i+/ra5xvOb?=
 =?us-ascii?Q?VCf4SYoAGkB/iYdREx7qXJPOH4lZW0EfuTy2rCxU6ow7WP0LJswwobWwScmp?=
 =?us-ascii?Q?Cy+8oCwAApcfNWtn5gtkJBRU4qbtxeqK0pf8YXmro+bl9zQRMWuC010s1gLu?=
 =?us-ascii?Q?7EEcbTDDZ+tmZJF+lWxPRhz6m6x9wia7BPa3k/8bzPQYbDpSJj3HKDc3XLyZ?=
 =?us-ascii?Q?AmO+9ucmv7JcJX9aJTCQn5ZDCtv3mD3KdMO67EfmCTEYkb5NEZz6eVdW0uQj?=
 =?us-ascii?Q?40lsBT/nJw8cU00MGMdDPsR7wMgYtsaHcqWropfbO4fuJ3H2WZy8Na+8F67P?=
 =?us-ascii?Q?UN+LPq44/yhQpIi0U5YR9dkaraD+eoY5Z2zlRfjs7ynpV7iehKXhzI43MHf3?=
 =?us-ascii?Q?pn8ExCx3TMSdN2+eO1fsKHXZBsFxz8Y2ZZVUQPF2puF2/p7ycxI1JYQ98My2?=
 =?us-ascii?Q?DBUyUTLNdjUxO4algKu9z5ED4TexA9RvE4yCfHFiHNHlgZTtT0DludfjHQWO?=
 =?us-ascii?Q?gLAO3EgbfxFT8/tSIB/Mx49rrAe02dxC2wrom+XwNOCBb+4rtq//+47JCL+z?=
 =?us-ascii?Q?rPLtWCHCLE4wYMgnNMIl9fSCza8SAumu1y6Pn5TbCuboSAm2LhlH/sbm/vx4?=
 =?us-ascii?Q?tGCnyAmAaBcRikMjmr8H1D2tMQqkZVEJSMIKhwuVLtfqJ+sP01PxktgOx9Fp?=
 =?us-ascii?Q?TYqaqseOrZi5MPWZvzAgSMyCVN2TiRMpqdOYO0N6OmyA/91EIwSsT0x33Dp0?=
 =?us-ascii?Q?YDga7AXlgFnurC2cJMePn46ihYCCAm3Un4bhfuecokrNELGk84CiXeQfzQcy?=
 =?us-ascii?Q?Z/gwqJqS6XhhfvlatuhrT4vPour7g7gaJUOLakNWFwvKdfOkgU7Xv3j4rkRm?=
 =?us-ascii?Q?KkNceX1zIKM2ppHcvgn5nas3ehia5KKELHhWMH492MTbcmc12lhOsGEi0M8P?=
 =?us-ascii?Q?OvOT4GbfymIvzJSDtM25K2qPzh+T+XrXMDFnblxyWciQhu7GdtHyomWBE53S?=
 =?us-ascii?Q?yEPmjHv1wSoUgjA9wj6a6aWLrS+vz/bFuUKytl7wHpNpz5H6Y+UU7eLJ+h8y?=
 =?us-ascii?Q?zri7/JSmaJArJWiIbGlPi5mIqd+VWwdSR1lRv2aV6gIC0Ec+62UwdPL8j0SK?=
 =?us-ascii?Q?S0rFfmpkoCe/Ne29leBHpLF+4BgdIXY2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2477.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kBYENrOLr17CukacpeeMvz8Nh3L7AN4EJOSMGxFaTseg8jMlOVHUE/kvM5uH?=
 =?us-ascii?Q?dV9G+n4xaapca/y9Lv2DVmRaCwLk0Es4xVClBVA7ynY1IuzO5mQo5KZEk096?=
 =?us-ascii?Q?d0p4gEpWICkwahDVvEFI1DCcZCrk12WDCo/T5THOIFwQzGdhFREH+NnNri7r?=
 =?us-ascii?Q?2hIaCeN25hA5zo3gCUZksW2bhSV3WrqA2AzbBdNVsJz7wqMRlB8dqP84EMwp?=
 =?us-ascii?Q?ck1DC3AEmEJd29YvMR4Kq3swi9i+bJfe9oGe20kojPwQfBrz4OuFcQ9LaYBt?=
 =?us-ascii?Q?/l1bgGcEsN0f63c3vm7d96EAVpA9tvLoMusWSaoTUcqLq8U9KH9ZMzL0k8dj?=
 =?us-ascii?Q?aedsRspdOKCph5KGO0RLoh317wM+OhHkMb9/1i6vWksdzFaC6EpLaigp72nL?=
 =?us-ascii?Q?VY3pIi79HtI5ymuhrYUh44r1YXTvVIBGGq7Vf2XXEPIO8UFFJvK/Oywo9cn/?=
 =?us-ascii?Q?SVzW5kRbyagUzRh3wmRImulTOyK9ThTS3Y9aKrhZwxMTJ7z5c4vY00pZgl/I?=
 =?us-ascii?Q?x+ViLKgv8PnjPRfY9dqrwWNRIDwD6bX/qeuqi767kFrGRxf9yfQNa7MgDLSu?=
 =?us-ascii?Q?3KomE9rMVxmI34xcKuyPxhXVQ0x5+vExjM3qBWeZc0Ia6U8rKV9jxR3hXo2N?=
 =?us-ascii?Q?A19eQpwSjvWgNE+vsffj55AuBCst1wurjS6FS3bwyTRNFR238er0Tc/Pyvnx?=
 =?us-ascii?Q?sJFXd9+TQxpby2bLQLuql109miHH7b8ilTORCP/AVmVdO6iijPamlJsd41Un?=
 =?us-ascii?Q?L7EXsPr4151B5TGEsm70/5wlrJdwdcS6dYh91Wd/j0FrVTfuJp//Ux3byt6T?=
 =?us-ascii?Q?RG3Psbmds0mwvuJycMp3yaRRp3ZdlXnzpFuLjWyN4E4o1Nl6LZJmw8bHfD3U?=
 =?us-ascii?Q?xOR9VAZUAq+oIsw54rwlwA4BGPrEvjzvc3V2w4ky2G+FkhANHSvKvHSFyj6A?=
 =?us-ascii?Q?/hx1fUwDzSfN2jnc9tA2u0PN/hgIVnMLXpZQlhdj1tuapbUJZsDXPOrQIVyz?=
 =?us-ascii?Q?eO2LbZRvk7G5tV1HtuzCsCR6xEsDGalMMtgehfe2GA2qtyQ87IGWmbngNyPc?=
 =?us-ascii?Q?9gl0tZpac9ole1xokBcsMx3WcQQAQGEOwoOFJI3qUWY5ZLpxKwPuSzKBajOJ?=
 =?us-ascii?Q?biPH2SHE3joazilkhZoYOe/haF7cEzyUamwkFmwAtyDOldVgwv1UeR13ww1z?=
 =?us-ascii?Q?qznw8ApaepLUQdE4WXjMcU626CRoUL8kzfIXnR7htkjHQqZ/xDanwCpaopmI?=
 =?us-ascii?Q?03pbj+gYPrAgrEP9CQkLItowGDvxhirEutLPM94twu72hp8SL8Y4wpGdSuuL?=
 =?us-ascii?Q?6sHnuXjJ3q1Ov8NvQ+bsbwzxXI7eRPtWxgemmE5yzosOho1VYOf8hGqomxMw?=
 =?us-ascii?Q?vfTRVBgLkoky3vFvpN4NcKtY7SEjWT4E9TsbFyD7MlvWj2/EtTdocHYbXlHP?=
 =?us-ascii?Q?TpD9MY7boXZ5nx2+TfnO6VW9kJgfwCAT5k0lBW92z20vFe2n2uaftZTImmr1?=
 =?us-ascii?Q?k9ZHbMa8zThoyRFb3HUKRm9tWfK2DkPcAn44nq/Ibt268ElZVGZ4pg6X3YUY?=
 =?us-ascii?Q?i2+q1QH8jQDHhN8Yhwwj0Khrygr+fYBa7mV26xSsrP8xF5jVEi2U3JkmRdyi?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f80764-2173-4675-d3af-08dd5bfad7f8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2477.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:31:48.3756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu47hBGzOrWMNxzwWXmLPPh5chlBnWDNE5SGYGh/4GIjpdOHAh048xoMiBZ5Wo82jwhHBDTVSFhpdtXBbV1zSX5SZN0/lSAb4WCphdtDLAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7752

On Mon, Mar 03 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 3 Mar 2025 at 10:28, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> Stupid question... but do we really need to change the code which update
>> tail/head if we pack them into a single word?
>
> No. It's only the READ_ONCE() parts that need changing.
>
> See this suggested patch, which does something very similar to what
> you were thinking of.
>
> +/*
> + * We have to declare this outside 'struct pipe_inode_info',
> + * but then we can't use 'union pipe_index' for an anonymous
> + * union, so we end up having to duplicate this declaration
> + * below. Annoying.
> + */
> +union pipe_index {
> +	unsigned long head_tail;
> +	struct {
> +		pipe_index_t head;
> +		pipe_index_t tail;
> +	};
> +};
> +

-fms-extensions ? Willy wanted to add that for use in mm/ some years ago
[*], and it has come up a few other times as well.

[*] https://lore.kernel.org/lkml/20180419152817.GD25406@bombadil.infradead.org/

Rasmus


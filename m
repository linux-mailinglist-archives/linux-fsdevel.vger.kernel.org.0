Return-Path: <linux-fsdevel+bounces-72522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19607CF9119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 782A83051ADE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3CF345CB5;
	Tue,  6 Jan 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="wv2tre5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021074.outbound.protection.outlook.com [52.101.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6823345CA1;
	Tue,  6 Jan 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712993; cv=fail; b=avLjWtN617MPzoMNsJJfPuxCCRFxliuueC9H5EyOhon37czkNoqDjaM/mDAJbcKBCrPpdOLij0JceHBGGQMt3P47ovTO0bOwHBAtvyEAN5MlqXfaQXDJZpuPjIzqU1t11S4IDBVGm1tz06kePrhswrvlgJ+7pD8ot61Q9yK61oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712993; c=relaxed/simple;
	bh=DwAAWrY2ULEWHNpvDEFJ13Cx7exSMLdXGN7Q9gufyKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CM4a1KFX57IWfKQ3EOo7ZqNZ4ES2kP/KQT4RDnOvuUeklz9HBBMQzhfDRoJ8cwG80JqutYxpkRNNJfzrbO5ofGHgGBB8NmNCsoEzjxsew0KhgnK7JPoimrOm0ukzhelBRBxfj3QsQIA+HYjd9HjQQ/YI6NvJjFUaVXiOuOSbnKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=wv2tre5w; arc=fail smtp.client-ip=52.101.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRmHAteqFuUlBP+Bjy2Xuf2m6g0kAPdaQz51TPpIYQZmzcqXUTiqw9tyxaMYlPArW/9QxIYyCowCcX4XluUJAfx/zWb+g0yLYAZjP69/NesAZCbnsIPJsDfeQeonxkSrFuR+6VYK+vIDzPqPYidoTDaC25MmustEcKZnPEf53ZFN9tfq5z0E0ONKDLeM4COCxLQrvv2mlSyPtbKS+xvSOc7Efj5hdsM65EpxAvyiHZwNA8iqv+Z6Sa3NEFUXkBr4KtbnOKhtVbdIE2j5xlN5ZKUkU1/RQ5WsLromNEAEF+1VxjtpujiB5gSqV35SBQgZ15ONSNLOTKlHx3j5KSQeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XziYBfRHkrgsgx+HIVpCW0HWoMIkZLQI18tqvHnGr9A=;
 b=WSI6xLOL3O2H1+IQztc1NYrlpo6n90OJHmdovixmmiD8Yk/i88n+MQYWbck6Kc/zQsyCirgjlbc/nyb1CezWaar+DpFM/VApTdJPLdc0KJJBsnmQMQEhiVhUQiyX/CWSN52/5i9xrNW1Euvt8+FGubpEloz7ZcionaSLNGl4+aj07AEGdvYlHPDQeB3JwNZVsEvG1JbA27jSdFIVRI91bmEDo6oR5GGAb2IlKI8FDu/GDCjMabnFiELkZkB3Ga10ZrHQs4ejwF7TgAhW5XxX+5HYbkaZ5s/az8ZnZ2hWbnoTWJSEUu7reRhHX5RDPDVr9sVDB6ZJjcjeGXLdpS1URA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XziYBfRHkrgsgx+HIVpCW0HWoMIkZLQI18tqvHnGr9A=;
 b=wv2tre5wYZ6aZKqRg6XvtaDNJyN3sSpyOBEjYwqiJiSLrc8IYywODGmUuplql9K5s8Fr5pHIE9ccxtsQ2L1mKslBMFsZiDS5x2F2MtCFkO/wYqYM7kA6ySgUCq3Eo11WB6kPreUuzWiUljUxPVeixLYWkRqLYlj6N9909h5YW3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6352.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 15:23:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 15:23:03 +0000
Date: Tue, 6 Jan 2026 15:23:00 +0000
From: Gary Guo <gary@garyguo.net>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, aliceryhl@google.com,
 lyude@redhat.com, boqun.feng@gmail.com, will@kernel.org,
 peterz@infradead.org, richard.henderson@linaro.org, mattst88@gmail.com,
 linmag7@gmail.com, catalin.marinas@arm.com, ojeda@kernel.org,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 dakr@kernel.org, mark.rutland@arm.com, frederic@kernel.org,
 tglx@linutronix.de, anna-maria@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of
 read_volatile
Message-ID: <20260106152300.7fec3847.gary@garyguo.net>
In-Reply-To: <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
	<20251231-rwonce-v1-4-702a10b85278@google.com>
	<20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
	<L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
	<20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
	<87ikdej4s1.fsf@t14s.mail-host-address-is-not-set>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0274.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: cd127f6a-d62e-46a8-0616-08de4d377c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E27G4enlFQzP/DJlAApl4d4BV3odDW8n0RWMRnJQ0+bUDg4WNEE9y8XfkvJI?=
 =?us-ascii?Q?/CzeqETZDBPTQMTA1dnMbzfj/eHFYPL6ISq/h3zD4gcVXx6q4UbQFhx2wvP2?=
 =?us-ascii?Q?NzSHetU6gaiRD3WXEpPYlE1ezhm++l5j8nbq/MURzwZK9qjrbTd9xG7Qc+Yo?=
 =?us-ascii?Q?5+76f4qx/huQFyjT5e/XLz7KAqf1T98ERy1XgZ978PCwK/EHuNcXnTz1UiuR?=
 =?us-ascii?Q?J5D20qEIHdTL0rcBcZtP6N/ftRqWckmyixuhxrijs5QuVs8ye5vBE4ZkmuuT?=
 =?us-ascii?Q?QNOrXBpMdrFIu9Er9DNY59BriHtjO8xGCZOHyOwBJKEplc0xZUVo3+TsURm1?=
 =?us-ascii?Q?G4cC7QxRpyz48urNtao161Qrww7eNk1N/m8zd++n5AMpVyLNpn5toiB0q4gG?=
 =?us-ascii?Q?q4n89V0BezQJowWjf6oH1GFZjXMwIzd/HlAvKTppWnrpfqNCix6tQzD0mJyB?=
 =?us-ascii?Q?BkSdX//n2yNWoo+X9K02K7Xux/wthpWC9K+rJrouirNfRO9w1F7CbA5HxVNc?=
 =?us-ascii?Q?m5nFBz8w2GlDNkTKioieu/56iRtpoMFiDO4arxto7pbzYyEfdKthb62Yi/K+?=
 =?us-ascii?Q?rtVXrFSx1ow4soL7/91pZfIbvMYuzryP+t90+d2crLtHMgLzHT9rX+WPYW4k?=
 =?us-ascii?Q?foH7L4qqdG8F/fWQDgWbEFbPy60ZDvgqrWocNhMlhK6t9PaeW1nYiUW+gpfp?=
 =?us-ascii?Q?F1LK8YjIRJ2pyFn8NZUQP9WTL5oKCfk6zVgI6s3+XbB5it02Ciz5XFhMnTui?=
 =?us-ascii?Q?0uorI+0VAh8eYpwJ/tHT0qDFtyktsMhOEAjuxT4hfHRClHFjeAfG0JTKSYD1?=
 =?us-ascii?Q?PjajjlHTvjr7tlDsq+6nNhCeH8ULHRcdK26/EB/SmJEgL0jWlHn8PtEFV2t7?=
 =?us-ascii?Q?kbSae+yhAlO51dnuuWTZFvvpB8On6dZiocVKLYTbhh6z0ErNMan1rDCTK1Bn?=
 =?us-ascii?Q?kFLAGmWGbZRjVkDE62kG7r9baR3Bsv0VEEqriTOqz/fUo2i1w1/IT0dR4D2B?=
 =?us-ascii?Q?yWoNs+nkQLwTP1xhapuq0G8yxxXp4Df43t0SoswDc+WRCraTgAO1bbq1jxBW?=
 =?us-ascii?Q?s0P/49tSj8yIUxLpT/jW5qLNkWHIH0Cthq2rsbjouJVi+pKtVivPs7NoZzhm?=
 =?us-ascii?Q?i8UXegp8PSH6IPXR8XyQl+9LaHFmZz+Y3UUNJqYNgsvLxZlMjzG81CPV0nWh?=
 =?us-ascii?Q?jpd7RgoTubZg7FR3t2rcFmAc6oMlVsy4wxLRmKG31CvwXgzoHc416gcxoewQ?=
 =?us-ascii?Q?AIi7SDyhuqxJg8MB4yh4L14jWbHp984kyJXs9L7WYheSdqfkMm+Ife21TCPv?=
 =?us-ascii?Q?Le2/qm7C7QdLuzuWwI/VVuDgDnxTzQMf8ULoTwUDVASWQNwSS19JX34H23/n?=
 =?us-ascii?Q?jXnnsTanxfY/garRy8HcikgglyWX00Z8o9LNPlMlxoBB3VQdieFaUf2mnMk/?=
 =?us-ascii?Q?CxT+2BMOCYHA9S3if2RwtTPKFaQS2MWO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kb1pHrfjtZGh8GyRUr7QCs2xmnWV4M6F9VYvQlp6Oryjl210khHbXAJNqPdT?=
 =?us-ascii?Q?dZcJteeA6F+1tMsoQeLgsIxtRkljYH26JXxBnb9H80Xhm7b9X2eAyr6MauS2?=
 =?us-ascii?Q?gpQmV33IkM4t2ms0r5FjMdFTRemIzrYXpBq/CkaSjYNrMnA+rq5etrbLRm2F?=
 =?us-ascii?Q?8UcAxNNXy2Uhf89qPMr5Xd2ToW945wTYs8Y9R+ISZqE+zcjQJbNEmHfGHhgM?=
 =?us-ascii?Q?Pz/r1SYUcjY40T0woObF02NiNRqtd/C0hr/s2xm6wCkyrM3pAAPRWoroo4ml?=
 =?us-ascii?Q?HgBdHQTgscyqLNB6GMXkpKnF0Xb6v/PFz3UX2Bn2qz0/7RQsBZikXFwVxRaS?=
 =?us-ascii?Q?GVvQRw7vEhGgpOQTV1GH2NXsXAknSyf8dGJ72RgCRX/m66Gda6CtvVxjd/bD?=
 =?us-ascii?Q?566zb5eaM3fFPe3hxCHcUa3X88+fyG2653uwa8Ebq6QPiJqQKSvVHNvkNyWM?=
 =?us-ascii?Q?Qqdm8XDCG4My0cB8h35XbEukcv0w27mx0P0gPMIvQqzyHRHkH6j1EO7C2O0H?=
 =?us-ascii?Q?VVoYWW4X18uimeGk7pKoIhelrPchCtWcyYNkC4E9z7Cqr2iAZhG+vyTUiCEw?=
 =?us-ascii?Q?hc044n/cJPtH675pwFrNgvQ9bnlWjI0UmhyIjs4f1LJwkDk6WYvZSkXWqrAy?=
 =?us-ascii?Q?YIIERXVE/vgaNo+b3+BTQmIewbitOpxG9zKbTmIYPC87pkE2Avb4hNCa2lCe?=
 =?us-ascii?Q?+ftgdnK43J0SBflhR26Djfury/GGz5T0N+j/PWhWjBd2A19vQCJzDaHc0GPi?=
 =?us-ascii?Q?ZuoA8OZB2OmmYie1wgqCuA7s38RIGyQ0XR1ZcMYqrT+j7kAXthitIT5tAA6+?=
 =?us-ascii?Q?OfFkDUHECI3DSAx6z8dYnBoNPK+c3dPA6Yv6ntMhYcKLjGTqN+BL08NVuXRI?=
 =?us-ascii?Q?U2xwr3h+WLJ9eLdLoyA5+CF2AAuJaClPkG3+eDj+37IUwYysmvuWeXE1iGhV?=
 =?us-ascii?Q?puYoVxqwzflZoVKwiuGb1ShxEwUBl83mijLnGUF9zd3q++x3ZTpANM0xf2Qj?=
 =?us-ascii?Q?hwuGGK55ySB8X8vF2u1SbzM57UkXGIqtHvJFbM8UHW4ani+DJr9HV2NtIc9S?=
 =?us-ascii?Q?ADaUPrQMEViYS4S7ixDeLfVtrnssBj9J86RLLo/NNAG7EdehVueFvNdsSeFb?=
 =?us-ascii?Q?HOcbDP07k29OJ7cVlOl/6BZeFXIKdacYWq/EfzrFg9ySCsXNYoR1lTv5h3MD?=
 =?us-ascii?Q?MkYMvh357qHhWkFd3wUEeS6qic6QDMJsTvfHlchTPA3WsEvcbyMgddt9JJI/?=
 =?us-ascii?Q?USegTyb4YR0DxkT6apekplBgHHcQpLgZjnVlxC3tp87dbfwmpscvMhZUlLKV?=
 =?us-ascii?Q?aTkacLTiBJ3B/N1PEzuL3P8d98gmHc4fxcy/N+DOvwQ8XmQUJzB+XhvJ851e?=
 =?us-ascii?Q?ESKsPv0QT/yWjTz3/lq2Pbh7RaeWVh02S84rl/BKzf4LhJ3evhofgk22qzUw?=
 =?us-ascii?Q?m2Ukx1WwcWtwmi/+yMIKKUFdSahM4K6BJY7BZ9gT/Uk+FsnOjr91l4qpfdjl?=
 =?us-ascii?Q?M4LQqo/zFCmNY2YB3Nr7l7Js1TWgV1R/om3wPi9P7GLqSb8Te5NBO3opU1VW?=
 =?us-ascii?Q?B8JJZKZwTiVBvmdXyQU86q+d8BmmvQ9tznkA1bt9QrmaCi1YQM/pyxkqcC8c?=
 =?us-ascii?Q?bXh3Z2QOPnx8CQf1mG0evU5VAiMPASOA+Q1dY8HfLFmkp6RR3YwLX+Gn7GMb?=
 =?us-ascii?Q?wNgw5qiN+1aCLM6kVIqQY73apWXqwhKM/pZ/Qvco3X1hvx5x+KDRJo8RJUk2?=
 =?us-ascii?Q?6xnI5uqqag=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cd127f6a-d62e-46a8-0616-08de4d377c61
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:23:03.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjRSI1QcAdE7tVpOrzn1EQdZqJInH/D5iVZDA5vbe9dWObhK1m6QnzrUHut53N8io1DC7p+jc5fC8Osip6tMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6352

On Tue, 06 Jan 2026 13:37:34 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
> >
> > Sorry, of course this should be:
> >
> > +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
> > +{
> > +	return hrtimer_get_expires(timer);
> > +}
> >  
> 
> This is a potentially racy read. As far as I recall, we determined that
> using read_once is the proper way to handle the situation.
> 
> I do not think it makes a difference that the read is done by C code.

If that's the case I think the C code should be fixed by inserting the
READ_ONCE?

Best,
Gary


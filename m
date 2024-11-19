Return-Path: <linux-fsdevel+bounces-35246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210B9D3027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 22:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CE3283768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF9C1D2B1C;
	Tue, 19 Nov 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FOB7YXsj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1719340E;
	Tue, 19 Nov 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732053209; cv=fail; b=lOB1y2bh5DNUUq4iELdAddNORNarjpOGMBhHcL3wLTAc3If65xl7/rufGc89XDQOXnYCvlUjhQWjNx6kYpUHUM2NYUakDGAH0umK6wuyCirIHcna7YPGn874ZHckj4Pbc/bfBOZVEl4HaxBbLfUp4H4TSA00zOysAhiu543838Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732053209; c=relaxed/simple;
	bh=YCXsvFh5cJi/axE25AOYgzowA+NI1bmbhKehHH+LwfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rrkCwwv2fgVWq5Ef08P7mUT6ALXxcXKWA61vW/SyCugtQda/CDyPcRLAba7ypnLBULUo/0xxzv5kXwI087yRyfV2pxVOD/37BjDVrX8PHgk3YKqVW9KvseDYfHOkcv80KeuU2vSUCqx6l5wQaRXcP/Ir6mqGUY27Nt3CehSOoUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FOB7YXsj; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLhsLK008712;
	Tue, 19 Nov 2024 13:53:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=YCXsvFh5cJi/axE25AOYgzowA+NI1bmbhKehHH+LwfA=; b=
	FOB7YXsjWgb/MxXzJ53yiii+E+BpxTxiqbzGQ41r49WWv5TBJhtWRRl7ze5MQgDm
	NhQ3WSfpd+Gf0lXvYJUHKacJ7jFU/fG2IPXFC/u/P6Lkci6o1vFdU7iFtY4tBqNk
	75JKgEOoMuhYi3aXHjkTupGE7jmZXw6I0VU9SZ5SowhjgDbmgI0MWjAtPakHaY5Q
	+y10CqTfneYo8zlv0avKopkcSMep4FrmAwdlwRqFbHPkLcrqAKhLSmD6Pup5IPUR
	wuUocrIqBLEmVzZ12L5i6DXJNPtKUWiwAtxYniAIFMTOowUpoeGkYlvLptthRXgC
	hDic9YWatDXEQw07u0AGjw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 430wx82qpt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 13:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICt1QxUOHtFAgNoc4orqzrhTsCUUfmxsAWy6n6RNIVZJZJbPyD95F4SMgUEdQHj4n/kbyVKlTYm6R3XY0LA7neGK3GDFt9jPj7jB33KaKT8cKXEyIGSQdzMwi605fSkSDhRh28PBFp7ZbCMl1bQ7fz1NEfakh+JmT4xwxdntXD5BzOVvGuBjg1eXSSPF9yyRLbaOkmlyvveOis04uRuwSlbvFlAgEGP+LQQE3vLd8KkZdpvMkaPaUQF4xm4nvzPMJmzoaFQH8z85QY2aTD11ccTga7+b4ZGo64ywiMJghNaaSOub22zuINjy56OQ4WUU79V7YsDUyJrXWVVZ73/G1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCXsvFh5cJi/axE25AOYgzowA+NI1bmbhKehHH+LwfA=;
 b=aUE6YblxrB1wbpUU1+YFX9XxV3vOJzF3jQGtclTSGB55mnzeyWmb7bBYyRlsDcHNKRnjkuwKgucOecweIq+z/1INtrsJkeAWyi+9aGrYRMktRx7AITYClnPlKNdOeClkFrr2ZsoYi7IQQqf/XrqDZgabts67QpErG2lB353WGJlM7/ktRcAZN6IWvJYs/HWkt3Ob0FPqlv6vxvS+SAAFR5LssKSMFIBhDfD1v4VM+AJskDtA16tDTGWdqD+NwcIDsgvNgiShAwuL+g+hokHJV/WY92L8FluO0Ap6QZtHuXRCyQljl9QnKW2dxgVTVRNVCDG6KT+OMy7Jmvjdhf+mhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH0PR15MB6116.namprd15.prod.outlook.com (2603:10b6:610:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 21:53:21 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 21:53:21 +0000
From: Song Liu <songliubraving@meta.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Jeff Layton <jlayton@kernel.org>, Song Liu <songliubraving@meta.com>,
        Jan
 Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Song Liu
	<song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "repnop@google.com" <repnop@google.com>,
        Josef
 Bacik <josef@toxicpanda.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Topic: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Thread-Index:
 AQHbNNya8stOo5GwQE2QhVtvXBjXrrK1AUcAgAJInwCAAOzHAIAAaR8AgAYTNoCAABHkgIAAAU8AgABq6gA=
Date: Tue, 19 Nov 2024 21:53:20 +0000
Message-ID: <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3>
 <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
 <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH0PR15MB6116:EE_
x-ms-office365-filtering-correlation-id: a6053ff1-385b-4a68-a33a-08dd08e4957b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2tHRVRZUW55Qlh5ZGNJVnBhUlF3WjVrdmwybmVnN0V5NDJQNndVN21pZlc5?=
 =?utf-8?B?Y25jV2tUOWZWaG80U1lobTVOdWRLVzlpamZhdDVJVjAyd1VkS0E3ZVQxUjZw?=
 =?utf-8?B?YjNUK1VsM0I5UVlXM2QvSExKcVVIZFNkQ2VIT09WSTc4L1J3TGVlaGllWUV4?=
 =?utf-8?B?cjh1MHg2blpYdkRqa3VJdk13Uk4xTkVXdFZ5b3BDVVE0bVU1TFl2aFZ6T0pC?=
 =?utf-8?B?UjJUQzVVdHZyc3dSdmU0dHBkS0xTbURXdG5uUFFUWUpNZFdMVHQwbHJGKy9n?=
 =?utf-8?B?QXEzb29CNDgxalkyWFdZalBzcFZlaHN3RTlFdWJaMTVyM1I3MDJJb2hIVWpD?=
 =?utf-8?B?OFJJa0hGSTR2R3RQZEJpT1RlQm9qakNsNTlPaUxFZUk3dVhUazRlbnBFTVBn?=
 =?utf-8?B?WjVwWlhtdkVUQWdIT0xGbWNOYzhBUHIyQUNLTTV2VDVqOXJ3R2szMDhwZG15?=
 =?utf-8?B?ZWwvaS9hclMvVG0rTnFhQXZhTVdWUnk4RTgyTWtTWEFpeW9GMkEyYVQ3SkxY?=
 =?utf-8?B?NHFSeDVZTE9DK2NBdStTQnFBOXBuRGVVWFp2TEwwMWZxSHdmNzZBOGd4OS8x?=
 =?utf-8?B?RVR3aEhvZVpNcFNXQUdyKzZjaFJGSjVaSzliNnpYUXlBZUtiajY2MGFTWGFM?=
 =?utf-8?B?clVmQXNwbnEwNVdKRlpDazdXZEZqSWNZS0JOSEh6dVFJOEZMMWJBWWNzaWxF?=
 =?utf-8?B?VkVTWXQ2THJMTk9pczloc0FqbDE1cGdSamVFRzRsNjRDVWNPKzRBdWpjak5W?=
 =?utf-8?B?S1luUSt2UVFVWVZlKy9jZFk1WjJaUUN1STQrNVZhZVc1QzBWNzYrclZyZE8r?=
 =?utf-8?B?c2lQeUhHdmo3R284Wmk4U0RIK2ZmWEtCdUE2YnFhSWpFc1NyMC9neDN1aXBz?=
 =?utf-8?B?OHUyYUVhTmZma1NsYmtXdzM2SkhZaUplQ0tDVkZzVFRUZDVqMHZkb1BlSGJG?=
 =?utf-8?B?RWE5TGpteW1jaUIwUTJqVVFBKzBuQ1NjamFlU2dMZ2FlS0Rzc1ROVmt0L3hI?=
 =?utf-8?B?Ymk5TnhCZ3UrRHVEQUVZTFgyR3EyRjlRTHRNRE9aa0JHaUF5elRDTW9tZkxx?=
 =?utf-8?B?OEVOdy9XaFdINWJvNVRxRmRNNk5wdkpPd2xNMHZ4NHpWVGh6S20wQXB4MEF1?=
 =?utf-8?B?bkhFVWtzdy85cy84MFFvdmNhY3JzTnlQRU5Lc04xUmZmbG9Ndi94YjkyRzhx?=
 =?utf-8?B?SUtGVWYwZGREK2w2MUJYQk1jS2dqV3U4b0xBY3luQ2dPaTYxVEZURTZRdlls?=
 =?utf-8?B?ZjZWVGhQTlVQMi9rUjFCWjRtU21CWG56VkNCUE54bjlPTGo5WEh1Rlhyb0dp?=
 =?utf-8?B?TmM4QnNZYzQ5WU5ETGtDVEtSTGVJcDJOZGMyVXh3NlVCempjQ0RtRGxncXJ2?=
 =?utf-8?B?Q1NiMEppMzlOUzNtdG9RYlNzdmE2c1pvT2FuR1c5QzVza2l6cExJdWlRdmZI?=
 =?utf-8?B?bkw1UDQ0UkcwUDBEMHI1OHVrMlpHVkpQaDJQcEgwYWdzcTFmRGlmbFlBaEhM?=
 =?utf-8?B?Z2ZnSTlmdDVIYnU3RU1HVXRFYXR1akVxS0lyUThhTTlIZFVlQ3VGcXAyU3Zr?=
 =?utf-8?B?N1BVZEJCYzZLTEY3QnB0cUhBU1NyVkNEcG15ajF5TXpYbFAvV1dhU0hzWld1?=
 =?utf-8?B?RUNYZXRrbDcxRlpSUWJBZFliekJwUlVHZmZUbXZNR1hGVHBtTHdNdXVUdUxp?=
 =?utf-8?B?blhhZFg4SVhZbnVCTlBwRHpCcmtHRHJ1M3QwQzBiNFV5OUdCYlBudllzUk9m?=
 =?utf-8?Q?c6dIGxD7cQp5s+WGO66WYeu0KId0XMbjc0Fi7jG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bG1DaXBETFAxTGtUeEJwL1plUkV6QTVyMnJabjRnVk9nRzltUmFYa2JnbEht?=
 =?utf-8?B?ZytjRTFjUStoZ1FxUk1wZU9PU0x6L2pjalJmN0JYZEEvK2lvZ1BnWXNOaFFh?=
 =?utf-8?B?MUpqRVFmMEhpZ05vamNnSVl6TVVxcVMwQzNPTGplZ1VNQVU2SXE3YnJ4YUor?=
 =?utf-8?B?RmNtb3l3K0NzZ2JaMzBxWWFVK1NQS1M2T2xIU0xadUF6WGRhbEluUXF0OGRF?=
 =?utf-8?B?M3pyem5oSzlSYk9SeFA2dDBtZnJUNzhsdElBWlNRWXVoZCtsckZ4ejBNU0Rm?=
 =?utf-8?B?TFJKRWltSzBNMzBlTC9jQ3VGMFhpdGhHMGx4SEhLOUZ1YjFuQzVkWGoySVFZ?=
 =?utf-8?B?M2szcjc3aUVsZVZuVDJDL2ZDVStQWmRBWHdyVkhPajBPZlB3dFB0RXh1YXdy?=
 =?utf-8?B?WXdBdWhkTzFkbzBjZmduTEN0amJIcC91R1JzVlJUcFZySFdISFEvVDV2NTRs?=
 =?utf-8?B?NkNibnVqSkNnSUR6ZVozOHZFeUdNZW8yMXNuQkZOTjBRc1dqYlRLRXArUzhx?=
 =?utf-8?B?THFiZnl4dVVnbmlJNjUyTHNhMDR3Sk9oREFsakxoYWNQem0rR0l1NmxiMXlS?=
 =?utf-8?B?SUYxQXVlLzJCbitSc1NZYUVOb2FodnNNamVZbCs2NW1lMzd1RmF5UWFIWUpq?=
 =?utf-8?B?cnpOeVpsVTV0a0FzNkRSaVN5ck1XVUpqSmZSYXAzUTBBbFdjdWZuM0FDSkhq?=
 =?utf-8?B?bWt2c0ZmWVhrUW01WmswTU1aeDZqSnYzcjRHQXhnV05jWG4xc1pRanc1dzZR?=
 =?utf-8?B?MkxLVHFheTh2TTZkWXVwaHB1Yk83cWk0b3BZeVgveTc3ZzBZMlV4NUhsSXFP?=
 =?utf-8?B?QS9yUlNwUjVKZ0hmOTUrSzRMU3NCOHJFL1czbXJwREZUb0ZIeGN5ei9YQTVS?=
 =?utf-8?B?SzhKRExRMU93N3pENjkwaDFoUEZWWGt4a3RNTGdld1ZrZ3U3ZUhkd2xDOVpW?=
 =?utf-8?B?c3Z1NjExSjg5UXJYWGZ2QThCUGVieU1DSWxtUmNBdTNaQjRTaHQra0c1VHRy?=
 =?utf-8?B?aXJSbFIzellweEpXOHlDQ254MStBRjRRQnhzaHg2ck1pUkJvUDNaSzlaNmRn?=
 =?utf-8?B?eTdSVWdGMFdoTnNBRGZyTnhrVVNEMFNGUFkwbzdNWXZySm1NNklxanlEZnFV?=
 =?utf-8?B?VCtZYXNCeUxwby8yVnFOZkJiNnl3ekN0NUpvTFlMMEM5b09zL2dHc0prWVl4?=
 =?utf-8?B?L21XOUptV2taWTRjYUpwZmtkejlORHE0dWZSeTRKRGJDK2lHclo0c0tEYjJm?=
 =?utf-8?B?NkpMMFhtb3hJNTJxWnpJOFJ6THdmd3lFbll3elFGVFZ2THVGbEpWZkhRMkJp?=
 =?utf-8?B?QUZ2Nmc5SlRKQlA4MXNQYkVGZmIwVlUyVDZyeUxUZnJzcFp5NG1aZjRtQmFF?=
 =?utf-8?B?RlMwaTR1T1dCWnlpdG1jQ04wWUJ3Z3VOejJPbWdJSGRYd1BKMmZXWkg5bHdO?=
 =?utf-8?B?UTlTYWtUYVV5akF6YXB5VjBDbm51U2pwaGFSV1dCM0QrbllaV2NSRWpBR0V6?=
 =?utf-8?B?NWRXZzY4NDhqYysyZEJsbEc2NmhXVGtXRHZJNzIrdXkzWWVUWnZBMWQ3UTNW?=
 =?utf-8?B?S3JBZGJrbDlqenpOaXN4V0tWTzNBNUFzcGpLNlJsczZ3VUE3L0hjZ2hLam50?=
 =?utf-8?B?TU5uc0NRdmVTemc2a0M5dGFMbXhrckFLeWlMWU5mSklMd2MwRUpxMjkzMkt5?=
 =?utf-8?B?aUt2QVZWL0lneTY4MEFNUGpGbDhtblg2UzJYcld4WkFoZ2t4UWo2N21jS1dV?=
 =?utf-8?B?bjRraHEyL2REaGdCRFk1b1JBNFhwZG83Y3plZnFMMENnVXk3a1FBbjk1TVlx?=
 =?utf-8?B?RXJPV2ZBdFJrYmJ6QkthdFVuSU9ScDF1UUlNU2EvQVlvMG82WXBMdzZaMGZi?=
 =?utf-8?B?SmRObldzRVl6R2VlVEFYRUxuMm1JR2VXN3lhSklFL3hyVEZFbzNSZkFLTUpt?=
 =?utf-8?B?SjJzc0dQZ2NWZ0grNDdXemVmV0hCL3lOQnQ2QjNyVlJmeW9nMnprRDl5WmlC?=
 =?utf-8?B?MXFhZ0lqNEhrZ3M0R1BGYkJsODZpMUJsUWlNbDJVakNrSFY4WWRQbGcvcHJu?=
 =?utf-8?B?RzkvWUtQUkpKNzQxMnQ3YUxTNWdGTEx3bjIyZW1TaHpEZlVBUWtZVllvOExO?=
 =?utf-8?B?Z2RBL3EzckV5S2diYUJzNVFWYWxDdG40Tk1iMENZdk9TUUtJQ2t5L25LSFFm?=
 =?utf-8?Q?fkY0NFom2vSDUEH07rLrjic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52703D8718D71F4F9D060AF642061A8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6053ff1-385b-4a68-a33a-08dd08e4957b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 21:53:20.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRoNxZSTYEkKqy5NtETLGZU9n3EBDw7+cUUrikjo05Ft7Gal59Y/N7dyCoccPXs20L3usWklLYkmqOGNYe/jAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6116
X-Proofpoint-GUID: IOv2sEQPp284zXJ1MKJ7rnWepcdvBY48
X-Proofpoint-ORIG-GUID: IOv2sEQPp284zXJ1MKJ7rnWepcdvBY48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgSmVmZiBhbmQgQW1pciwgDQoNClRoYW5rcyBmb3IgeW91ciBpbnB1dHMhDQoNCj4gT24gTm92
IDE5LCAyMDI0LCBhdCA3OjMw4oCvQU0sIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5j
b20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBOb3YgMTksIDIwMjQgYXQgNDoyNeKAr1BNIEFtaXIg
R29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPj4gDQo+PiBPbiBUdWUsIE5v
diAxOSwgMjAyNCBhdCAzOjIx4oCvUE0gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4g
d3JvdGU6DQo+Pj4gDQoNClsuLi5dDQoNCj4+PiBMb25nZXIgdGVybSwgSSB0aGluayBpdCBtYXkg
YmUgYmVuZWZpY2lhbCB0byBjb21lIHVwIHdpdGggYSB3YXkgdG8gYXR0YWNoDQo+Pj4+PiBwcml2
YXRlIGluZm8gdG8gdGhlIGlub2RlIGluIGEgd2F5IHRoYXQgZG9lc24ndCBjb3N0IHVzIG9uZSBw
b2ludGVyIHBlcg0KPj4+Pj4gZnVuY2lvbmFsaXR5IHRoYXQgbWF5IHBvc3NpYmx5IGF0dGFjaCBp
bmZvIHRvIHRoZSBpbm9kZS4gV2UgYWxyZWFkeSBoYXZlDQo+Pj4+PiBpX2NyeXB0X2luZm8sIGlf
dmVyaXR5X2luZm8sIGlfZmxjdHgsIGlfc2VjdXJpdHksIGV0Yy4gSXQncyBhbHdheXMgYSB0b3Vn
aA0KPj4+Pj4gY2FsbCB3aGVyZSB0aGUgc3BhY2Ugb3ZlcmhlYWQgZm9yIGV2ZXJ5Ym9keSBpcyB3
b3J0aCB0aGUgcnVudGltZSAmDQo+Pj4+PiBjb21wbGV4aXR5IG92ZXJoZWFkIGZvciB1c2VycyB1
c2luZyB0aGUgZnVuY3Rpb25hbGl0eS4uLg0KPj4+PiANCj4+Pj4gSXQgZG9lcyBzZWVtIHRvIGJl
IHRoZSByaWdodCBsb25nIHRlcm0gc29sdXRpb24sIGFuZCBJIGFtIHdpbGxpbmcgdG8NCj4+Pj4g
d29yayBvbiBpdC4gSG93ZXZlciwgSSB3b3VsZCByZWFsbHkgYXBwcmVjaWF0ZSBzb21lIHBvc2l0
aXZlIGZlZWRiYWNrDQo+Pj4+IG9uIHRoZSBpZGVhLCBzbyB0aGF0IEkgaGF2ZSBiZXR0ZXIgY29u
ZmlkZW5jZSBteSB3ZWVrcyBvZiB3b3JrIGhhcyBhDQo+Pj4+IGJldHRlciBjaGFuY2UgdG8gd29y
dGggaXQuDQo+Pj4+IA0KPj4+PiBUaGFua3MsDQo+Pj4+IFNvbmcNCj4+Pj4gDQo+Pj4+IFsxXSBo
dHRwczovL2dpdGh1Yi5jb20vc3lzdGVtZC9zeXN0ZW1kL2Jsb2IvbWFpbi9zcmMvY29yZS9icGYv
cmVzdHJpY3RfZnMvcmVzdHJpY3QtZnMuYnBmLmMNCj4+PiANCj4+PiBmc25vdGlmeSBpcyBzb21l
d2hhdCBzaW1pbGFyIHRvIGZpbGUgbG9ja2luZyBpbiB0aGF0IGZldyBpbm9kZXMgb24gdGhlDQo+
Pj4gbWFjaGluZSBhY3R1YWxseSB1dGlsaXplIHRoZXNlIGZpZWxkcy4NCj4+PiANCj4+PiBGb3Ig
ZmlsZSBsb2NraW5nLCB3ZSBhbGxvY2F0ZSBhbmQgcG9wdWxhdGUgdGhlIGlub2RlLT5pX2ZsY3R4
IGZpZWxkIG9uDQo+Pj4gYW4gYXMtbmVlZGVkIGJhc2lzLiBUaGUga2VybmVsIHRoZW4gaGFuZ3Mg
b24gdG8gdGhhdCBzdHJ1Y3QgdW50aWwgdGhlDQo+Pj4gaW5vZGUgaXMgZnJlZWQuDQoNCklmIHdl
IGhhdmUgc29tZSB1bml2ZXJzYWwgb24tZGVtYW5kIHBlci1pbm9kZSBtZW1vcnkgYWxsb2NhdG9y
LCANCkkgZ3Vlc3Mgd2UgY2FuIG1vdmUgaV9mbGN0eCB0byBpdD8NCg0KPj4+IFdlIGNvdWxkIGRv
IHNvbWV0aGluZyBzaW1pbGFyIGhlcmUuIFdlIGhhdmUgdGhpcyBub3c6DQo+Pj4gDQo+Pj4gI2lm
ZGVmIENPTkZJR19GU05PVElGWQ0KPj4+ICAgICAgICBfX3UzMiAgICAgICAgICAgICAgICAgICBp
X2Zzbm90aWZ5X21hc2s7IC8qIGFsbCBldmVudHMgdGhpcyBpbm9kZSBjYXJlcyBhYm91dCAqLw0K
Pj4+ICAgICAgICAvKiAzMi1iaXQgaG9sZSByZXNlcnZlZCBmb3IgZXhwYW5kaW5nIGlfZnNub3Rp
ZnlfbWFzayAqLw0KPj4+ICAgICAgICBzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0b3IgX19y
Y3UgICAgKmlfZnNub3RpZnlfbWFya3M7DQo+Pj4gI2VuZGlmDQoNCkFuZCBtYXliZSBzb21lIGZz
bm90aWZ5IGZpZWxkcyB0b28/DQoNCldpdGggYSBjb3VwbGUgdXNlcnMsIEkgdGhpbmsgaXQganVz
dGlmaWVzIHRvIGhhdmUgc29tZSB1bml2ZXJzYWwNCm9uLWRlbW9uZCBhbGxvY2F0b3IuIA0KDQo+
Pj4gV2hhdCBpZiB5b3Ugd2VyZSB0byB0dXJuIHRoZXNlIGZpZWxkcyBpbnRvIGEgcG9pbnRlciB0
byBhIG5ldyBzdHJ1Y3Q6DQo+Pj4gDQo+Pj4gICAgICAgIHN0cnVjdCBmc25vdGlmeV9pbm9kZV9j
b250ZXh0IHsNCj4+PiAgICAgICAgICAgICAgICBzdHJ1Y3QgZnNub3RpZnlfbWFya19jb25uZWN0
b3IgX19yY3UgICAgKmlfZnNub3RpZnlfbWFya3M7DQo+Pj4gICAgICAgICAgICAgICAgc3RydWN0
IGJwZl9sb2NhbF9zdG9yYWdlIF9fcmN1ICAgICAgICAgICppX2JwZl9zdG9yYWdlOw0KPj4+ICAg
ICAgICAgICAgICAgIF9fdTMyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpX2Zz
bm90aWZ5X21hc2s7IC8qIGFsbCBldmVudHMgdGhpcyBpbm9kZSBjYXJlcyBhYm91dCAqLw0KPj4+
ICAgICAgICB9Ow0KPj4+IA0KPj4gDQo+PiBUaGUgZXh0cmEgaW5kaXJlY3Rpb24gaXMgZ29pbmcg
dG8gaHVydCBmb3IgaV9mc25vdGlmeV9tYXNrDQo+PiBpdCBpcyBiZWluZyBhY2Nlc3NlZCBmcmVx
dWVudGx5IGluIGZzbm90aWZ5IGhvb2tzLCBzbyBJIHdvdWxkbid0IG1vdmUgaXQNCj4+IGludG8g
YSBjb250YWluZXIsIGJ1dCBpdCBjb3VsZCBiZSBtb3ZlZCB0byB0aGUgaG9sZSBhZnRlciBpX3N0
YXRlLg0KDQo+Pj4gVGhlbiB3aGVuZXZlciB5b3UgaGF2ZSB0byBwb3B1bGF0ZSBhbnkgb2YgdGhl
c2UgZmllbGRzLCB5b3UganVzdA0KPj4+IGFsbG9jYXRlIG9uZSBvZiB0aGVzZSBzdHJ1Y3RzIGFu
ZCBzZXQgdGhlIGlub2RlIHVwIHRvIHBvaW50IHRvIGl0Lg0KPj4+IFRoZXkncmUgdGlueSB0b28s
IHNvIGRvbid0IGJvdGhlciBmcmVlaW5nIGl0IHVudGlsIHRoZSBpbm9kZSBpcw0KPj4+IGRlYWxs
b2NhdGVkLg0KPj4+IA0KPj4+IEl0J2QgbWVhbiByZWppZ2dlcmluZyBhIGZhaXIgYml0IG9mIGZz
bm90aWZ5IGNvZGUsIGJ1dCBpdCB3b3VsZCBnaXZlDQo+Pj4gdGhlIGZzbm90aWZ5IGNvZGUgYW4g
ZWFzaWVyIHdheSB0byBleHBhbmQgcGVyLWlub2RlIGluZm8gaW4gdGhlIGZ1dHVyZS4NCj4+PiBJ
dCB3b3VsZCBhbHNvIHNsaWdodGx5IHNocmluayBzdHJ1Y3QgaW5vZGUgdG9vLg0KDQpJIGFtIGhv
cGluZyB0byBtYWtlIGlfYnBmX3N0b3JhZ2UgYXZhaWxhYmxlIHRvIHRyYWNpbmcgcHJvZ3JhbXMu
IA0KVGhlcmVmb3JlLCBJIHdvdWxkIHJhdGhlciBub3QgbGltaXQgaXQgdG8gZnNub3RpZnkgY29u
dGV4dC4gV2UgY2FuDQpzdGlsbCB1c2UgdGhlIHVuaXZlcnNhbCBvbi1kZW1hbmQgYWxsb2NhdG9y
Lg0KDQo+PiANCj4+IFRoaXMgd2FzIGFscmVhZHkgZG9uZSBmb3Igc19mc25vdGlmeV9tYXJrcywg
c28geW91IGNhbiBmb2xsb3cgdGhlIHJlY2lwZQ0KPj4gb2YgMDdhM2I4ZDBiZjcyICgiZnNub3Rp
Znk6IGxhenkgYXR0YWNoIGZzbm90aWZ5X3NiX2luZm8gc3RhdGUgdG8gc2IiKQ0KPj4gYW5kIGNy
ZWF0ZSBhbiBmc25vdGlmeV9pbm9kZV9pbmZvIGNvbnRhaW5lci4NCj4+IA0KPiANCj4gT24gc2Vj
b25kIHRob3VnaHQsIGZzbm90aWZ5X3NiX2luZm8gY29udGFpbmVyIGlzIGFsbG9jYXRlZCBhbmQg
YXR0YWNoZWQNCj4gaW4gdGhlIGNvbnRleHQgb2YgdXNlcnNwYWNlIGFkZGluZyBhIG1hcmsuDQo+
IA0KPiBJZiB5b3Ugd2lsbCBuZWVkIGFsbG9jYXRlIGFuZCBhdHRhY2ggZnNub3RpZnlfaW5vZGVf
aW5mbyBpbiB0aGUgY29udGVudCBvZg0KPiBmYXN0IHBhdGggZmFub3RpZnkgaG9vayBpbiBvcmRl
ciB0byBhZGQgdGhlIGlub2RlIHRvIHRoZSBtYXAsIEkgZG9uJ3QNCj4gdGhpbmsgdGhhdCBpcyBn
b2luZyB0byBmbHk/Pw0KDQpEbyB5b3UgbWVhbiB3ZSBtYXkgbm90IGJlIGFibGUgdG8gYWxsb2Nh
dGUgbWVtb3J5IGluIHRoZSBmYXN0IHBhdGggDQpob29rPyBBRkFJQ1QsIHRoZSBmYXN0IHBhdGgg
aXMgc3RpbGwgaW4gdGhlIHByb2Nlc3MgY29udGV4dCwgc28gSSANCnRoaW5rIHRoaXMgaXMgbm90
IGEgcHJvYmxlbT8NCg0KVGhhbmtzLA0KU29uZyANCg0K


Return-Path: <linux-fsdevel+bounces-31710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C2899A46E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787F4B219FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A17218D88;
	Fri, 11 Oct 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="CDCq7eBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB37216A05;
	Fri, 11 Oct 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651997; cv=fail; b=Sz2uItjelPMu2jpMW3qUJ8MeEsy47v7jNrXQUaphBXOtLWEIEdKZFKea+bbksr0ly3g5lSH58ByimQ5gBC8Q8tJQ7rx/SzvjKHyEcettLLgH2ARkl9oNeQB6gTZ5/7a68fPdAPOCWj14nZpONA+smNlVFUONa4o4FV40HBhF/+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651997; c=relaxed/simple;
	bh=q3eBQlmgRML2xlD0bejNvbhRfpUEAMAWgSM9lkGVAAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GzcrUGAOEQ2yWQh+JOgwFZKhljnDV6rAW86peS4BaH1IIAlTnLWHppGXzhZ7gZW40+dlQBhfFCrE8jl71I7MWAdXaDBBwUSjeWAtXEqBN8IISO4B3z4QWReZqCbiN0UsY3LDDDSZXoPdZm6iOewbTyW7dgn4luOz55W7RerLVZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=CDCq7eBU; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49B1f0kv009210;
	Fri, 11 Oct 2024 06:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=z0ycJEZrlgYf48kil5+9q1VgdHJ+rHLiGowTbWazTOE=; b=CDCq7eBUCAl/
	V7ehE4h5k4Q4/wo6s1YsjwdWVOFyvNrUu4AavxzI2YGRdgmqe1cUh6ouZCfFjHqL
	dqGsxuUhDtmG4d2/pF3CcAwa6PrCPK5loYVEELdltsVu8aKIWhebXmEcMQlIriit
	JfToKPHQySurrGy5dDWQBnNMORvln9XJsfRyVaiDcMUlEd6yP9eeXAgawJgWq4gc
	e1gGryIBXy8NuQ2RuWFMk9TasOlFJIen2+PNX2LniQpaj9peuHlD0xTdEAP3neRM
	WJggqIJoGKxq9Li2JbXV0VqgxmKlYQ3qRO1UL1lSM2DZ91KkEQfN0cLV8cng9CRH
	w9Axo62apA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by m0001303.ppops.net (PPS) with ESMTPS id 4262scu2xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 06:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEmrFXg4QnBr1gX0ds3p1SzxIZeSF8WSpUdqHeMcj3LZncuGtym4Ez0yZOlqhgJsxF4wNtqonujuofkloC3DF/y5ORtKNRY8qyc4aHl0CA8QRFdzZ7l6gb5GFRbHzJMKPGQjghKf6M7HCePkVojrczly9lLl1DxEeHChlcfSKo1UvgvKs4L5tjy5sGvBV5FPfo2x8xKNb5pAsDh5e+hdJjdfEXiGRB+rT2so1ZRlRJoSWZgsBekrXPNzQ5S6Odan4G5W6yWzXBkqSZAFx+dIcXd7Dax3nsdc63dceIKT4yvxYP/l8GEjWUCnKZqXnFclyyy7+U7NEbtAv0VnIbUCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0ycJEZrlgYf48kil5+9q1VgdHJ+rHLiGowTbWazTOE=;
 b=IA47mce9iEofi4e0s7xhTFaTux7wstp8bYPGh1Y0FFlM2jlb9zfbfghBzofodfbXTGlqPS4Jb7aURo13LecpUJk3abKGUxArhglCAwCmQW2GuR7oXX3tG6r/Ux6DdatAblGU5iA6T3+QPBBgpTrmsZSylGe1xMppmkt3efDwo36vrTiPvxIzOODSRT9jRlBwVCYxYCbxqWiRWsQr00zdyTuL6lm7vXsErJQ1ZGRS/rtL9Ml86ycPSJXUGIvpbsQ8kcJHX/Na7d/s1mUdEqIdWgWFsXgXNdBSqk+iQqPib8x+DBi7VMTxaxlCrfG8mEd7nT0e/tKx66f0csAiuF1szQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH7PR15MB6463.namprd15.prod.outlook.com (2603:10b6:510:304::9)
 by SJ0PR15MB4171.namprd15.prod.outlook.com (2603:10b6:a03:2ed::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 13:06:12 +0000
Received: from PH7PR15MB6463.namprd15.prod.outlook.com
 ([fe80::163d:d4f0:e6ac:6a44]) by PH7PR15MB6463.namprd15.prod.outlook.com
 ([fe80::163d:d4f0:e6ac:6a44%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 13:06:12 +0000
Message-ID: <c6d723ca-457a-4f97-9813-a75349225e85@meta.com>
Date: Fri, 11 Oct 2024 09:06:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Christian Theune <ct@flyingcircus.io>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
 <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
 <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <f8232f8b-06e0-4d1a-bee4-cfc2ac23194e@meta.com>
 <E07B71C9-A22A-4C0C-B4AD-247CECC74DFA@flyingcircus.io>
 <381863DE-17A7-4D4E-8F28-0F18A4CEFC31@flyingcircus.io>
 <0A480EBE-9B4D-49CC-9A32-3526F32426E6@flyingcircus.io>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <0A480EBE-9B4D-49CC-9A32-3526F32426E6@flyingcircus.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0768.namprd03.prod.outlook.com
 (2603:10b6:408:13a::23) To PH7PR15MB6463.namprd15.prod.outlook.com
 (2603:10b6:510:304::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR15MB6463:EE_|SJ0PR15MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b27802-5de3-43e6-e279-08dce9f57aed
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2U1R1YxVG1Ub1VJcWQ5YUdiTXcxTmVKWUg4K1ZleStZSkJOUWVLUENMeDlV?=
 =?utf-8?B?Y2dCL29qMGw4U0p1MmRZZkhTczNwUVRqQjEzRnVjNjl1QmJDUnYrYWtvOXR5?=
 =?utf-8?B?T3FrNHI3dUNvR1BhK0JRY1JteG5mUi9LWmFkTDdSL2hmQ3Brd0pRdlFmbG1p?=
 =?utf-8?B?MnJSK2EvQ282cWd0SzIrWEhlUDV6YUNhSjg2QzZHVDJkd28rLytLbE9pdnVE?=
 =?utf-8?B?MnVFNkFXUEE0Qm5WOWhCcUpnNU5xbnF2Yy9kNXd3Y0htVkNXNFpTaW9ySFMx?=
 =?utf-8?B?dllDd09hQ1laa2c5Tk4yZHlxalN6NzZ6Ui9CRXh5bUNEUnd2Nm1ZM3dhZGxH?=
 =?utf-8?B?S1VwVzZTdzhCSk9pK2NxZzczNXhxUy9UNld4bFQwYzJCaFFNb2t1ZGpvS1g2?=
 =?utf-8?B?N1o1Q081RUM5K1B1WHVrbGxkdndXTlBXbTIrcC9CS01Ba1JFRE1RRGQ0em1x?=
 =?utf-8?B?czkybWxQdFRQekJMZlg0eGU0cnEzcU5DTjRSbWRPVUVlYXMwTFBkeDlUV3ZF?=
 =?utf-8?B?bTQ3WDFKczhzSFZaK3hWVjAyWVJvOVptc1gyaEljNGdPMzJjd0FnUyt3cXc0?=
 =?utf-8?B?Y0RtS2ovN3dsNkY5cXovcmRmUUtYYU9GbmttMnArMm0zQ05SVGRoQ1lCa3lE?=
 =?utf-8?B?eTErMDdUN0VNaU5BbzlvQjNMUmh1ZDh5RmJZTlFwd1d5V3J0ZXdzUlV6d0xO?=
 =?utf-8?B?SlVhcDMwQkNLN1dFaXlSMU1jTWp0UkFxb2NUSVZWckZDbWZXN2dFNUpTMkVE?=
 =?utf-8?B?YVluM1EzSkNPL1FtSFQ2UXQ5a0k3Y3doT0c3dTZGSmlUWW95UmtPbm00alMy?=
 =?utf-8?B?RUxza0JaZnlXUDZsQzhFU0NURmZXQXpIaGt1aG9JeTZOcFBDcDJ5MlFPMUlO?=
 =?utf-8?B?K2x4NnRkWDd4anNodGtxUXpMNEZ3Lzg1cjRaQzczTlAzTkIzL3FCS1hHaC9a?=
 =?utf-8?B?dGJicnVKV0FpalhxOFhhMkJmT2tJaWxWbld4VGVvQzA3eHdGVzBFUkh6R3RQ?=
 =?utf-8?B?VFRKVDhHZE9way9BOXlRL2hGNndXYzBhVUZEbTdLWG56WG9VTjF5cENoWEUv?=
 =?utf-8?B?Njh6dlZ3VzVGNFBHbnFzTlhSVlhCTjAwVDlDemc5WmtRZFU4a0hMdkRGN0Mz?=
 =?utf-8?B?cGNCZVVVdE1TUU41OXVjRFFQWlNNTmp5bFNmVXhESWFoMVVXUFo4dHJHbDli?=
 =?utf-8?B?SzY5V1VQZmZ1WERWa0szYWk0alFsZVU5Wm9xM1lVbWQxTE85RzBwTlFTbW4r?=
 =?utf-8?B?Ylo5d1c3R3MwU0ZHZGVHUXlzcUJjR3VhNlRRRW8waXNDTFVLcnhZenpOVHFS?=
 =?utf-8?B?bThNRkJHZnVHM01seVdoUDBXc0dSc0hXVjE4aDljY0tBdUl6bVo2Y2xhbXhi?=
 =?utf-8?B?eTQ2RVkvUnFEMUtKMmZSNXBJNlRIVXNFakRjZ0NjSFVOeWQ5V3E1ZWc0dUxn?=
 =?utf-8?B?Z1p3cTMrQnRCZG5XdEpDdjZleFU1UHMrSTZ0RUpwUTIvVUxDQlpvTHQrZU1t?=
 =?utf-8?B?TWNsS2NCaUhJS1lNdXNrQm9LRHU4dkxtUDNNSVB1VkluempuTENYWk9kV0g1?=
 =?utf-8?B?UmowaXJMcmsxV0k4UVREMlRBL2U4cFgrYVVTTmZmSWg5UDZOVnZYZVFJUXph?=
 =?utf-8?B?d1VPaTJ0TERNeHZ6Sm9hK2h3VXk0UjdjU05YRFZiNWxzTFJmMTBTU29JQU1O?=
 =?utf-8?B?elcyUlZ0SFFLR2JLMEFaZDNDc3Vzb1BMdnVvNUhpTmZBUWF0aUJIekFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR15MB6463.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjFYQ2lDV0lYV012UjRrUlMvR1dkeHNPL1lhdmlIVE1mT2oySHcwRnp4MWw0?=
 =?utf-8?B?V1hZVUFRZDQzREJyd05VbjFNV0ltbklRWEJadmdjRHhyOFJGNmI0R2ZVRHRN?=
 =?utf-8?B?KzFJaXFNK3ZoQktzWEoyWmdNMEJyM2N5QUg1RWV1akV5Ulk4UjNUVVFzRXdx?=
 =?utf-8?B?NXE5SnhHb04wS0ZtUWxMbWpzZzdtK1RxQ0N1dUh1a0piWjR0QzlPNGlUUGIy?=
 =?utf-8?B?TmdMK2V1RTRrVWwrRlRwK1d4RnVwNkRnVWYzcFUxMXhtc1RWdURMTkJyTzha?=
 =?utf-8?B?dnJQeFZuWWNsdHl5NHVxb3JpT2lEalRFV3V3Tk9ydVJxNXdhNW1vejRCZG1v?=
 =?utf-8?B?UjhkeU9pQk5uK0tXUkx0dEQ1dm1VamNlNHU0RElIenFtaXFnWTJPK2ZkSU1q?=
 =?utf-8?B?UjRUalB6RyswZXdLRE02YXM4bnJpcnY0dC9EVlJLWXRDL1RQMmhod0c2QjRN?=
 =?utf-8?B?dHZqaUUyb2N2NkRIQ0RHR25uVDk1clBOelhxNHJWSVJZenN0VlVjY2dEclBC?=
 =?utf-8?B?SGUzdUMrYmZLM3YwTVlOVm10NEorWkxyMitNSWlYb09renloQUNLTHFSakFF?=
 =?utf-8?B?WXJINHNLWjN2OWFOdXdNVWloN3lkenljQnJiWmdNUlVCSTB1ajA1MGE0K1pQ?=
 =?utf-8?B?cnpBZmsrSld2VzlIdEp1d3BGV0REZFlIeFJCdy82aTgvV1g0ODN2Rm9lcjl2?=
 =?utf-8?B?REFmOWVVTXEzV2k4ZlFkTWdHYnRlUnRtMXZjUjN5a0w3Z1ZFWGVtWGNaYVJE?=
 =?utf-8?B?RnF0NXFja3BBdjU4Nk9uT1VtRVFXanM4WjVLZ3hFYUd1ZlcvVGg0K3Z0eUln?=
 =?utf-8?B?SVhFV2hhUi9WSTM0a2VpL25WMms3MGVFWGNyV3E3NzhKT084b3hPNTRHMTVM?=
 =?utf-8?B?SGNtV2lSWDNrcHRmR1ZVcTFLdmtDS1lSVXk2WU9sQ1hVOTFUcE1JbmUrQkNj?=
 =?utf-8?B?Q0NOSXBjSXR3UzNyamIrUkV5RU83ZnhmVVRWVzQ1YWk3V3A1dklOaWF6dXRD?=
 =?utf-8?B?VzBHQWlnT2NVNmcwMWdpbU84aWNPQmNIK1VqMk1BVVhXeE5jaXNvOTZaQmdp?=
 =?utf-8?B?Znl6SExCeWhFd0xveCtXZ1pQblU4Nm9WVThINlJTeW9nMEVsYlFUMkRkZmND?=
 =?utf-8?B?NGxnaVFOOTl2VnY2Mmo0c1ZYRzh2Rm1FQW1od1puWVkvTnVPSUJmZmJqSkFJ?=
 =?utf-8?B?d01DRTVvVFlhZ2RVWHRYSkFUMzZmelAwSnZJVjBzYlhTQTRTd3I5Ly9tbzU4?=
 =?utf-8?B?alZZU2ZRTzlPbDhnQ1pkcEN2eWp3WitWMTdhcDZUb2JBYmRFM2hTakJkY2R3?=
 =?utf-8?B?U1ZxUlhIL0lCTVhzUmxUQlIzRnJOcFlmZ1N4WFltSDNmcGlyNDRzZ0NVRkdT?=
 =?utf-8?B?a2VDT2hxbTlhK2ZkdDY3UitxR2V0V1dYNW5Dc3pQU1dxeEF3R1JpbGEwRFRK?=
 =?utf-8?B?aUYzQUtvTGRLVmZEYnlXTDR4ZHpNM0QyMmlKYWNmL29FNWMzQ2NJUnNyeTB2?=
 =?utf-8?B?U1NHVWhqekFoTWNhYXRrSXlMMC9KOXJ0enYzVTFlM1d4cUE0OTU2NWhFbEVU?=
 =?utf-8?B?bU9nL2x5eTBWbWtZeGRSeHRqdDVZVlpSL0xnSzhGcEJVTlpybm5aN3JMMUk2?=
 =?utf-8?B?LzJwTldzOFk0Mmx3a3FabjVMNnNKaEFRZVJiV1hxdldWVjVPT1ROQ1FRbUhV?=
 =?utf-8?B?Ymh3Rk5WZkxYdUpFZHhXOXM3TkdQR2ZFODUvVFJtcEs5ekxjd0RQSjVvMlpq?=
 =?utf-8?B?ckJQMncvSE5mTG1NYUQ2NDhlK0JtSGtmR1NueDA5blV5MG8yU3ZCU3J2MmUz?=
 =?utf-8?B?eVNlaXVMZ0tPS1J5TEIxZzNPcC83aVV2WEx5Qk8wUnU3U3pNdTIwK1hqTFV0?=
 =?utf-8?B?enJGT3h2RGtVK0I2aExtL2k0WGJHODBWT1RkdmtVVzB2ekc0ZkJISTd2RW1R?=
 =?utf-8?B?dDJVNEFVZHpRb1l2NlFZdDR1TUppUklvdGdHTUIvaTRoZzBvd0dNekt2Wktn?=
 =?utf-8?B?QWtGTU5Iazg4STkzd3FpNGU3ZCs0Q2o4MTRNTzROM2ZMSEE2RmwzbnA0c1V2?=
 =?utf-8?B?K3JLdkZPTzU2YWNxaWZMOVFXQU0xMGMvVWdvM1JQdXIrK3FKS3F6b2p4UVZL?=
 =?utf-8?B?OEd3Vmc4aStMazhLVkJzcHd1UXBwTWxQMTc0U1hxai9nOXB3Z25SQzg2S2Z1?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b27802-5de3-43e6-e279-08dce9f57aed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB6463.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 13:06:12.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2Opik4Xud0bWuhaL5OpSvwykVf3drbIm7BtyM3yOzZF4Jv5JfNWhWkqRq6iwkrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4171
X-Proofpoint-GUID: lzmD29wF1sWvzNsWfxEILoPzHNkcOLUQ
X-Proofpoint-ORIG-GUID: lzmD29wF1sWvzNsWfxEILoPzHNkcOLUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01



On 10/11/24 5:08 AM, Christian Theune wrote:
> 
>> On 11. Oct 2024, at 09:27, Christian Theune <ct@flyingcircus.io> wrote:
>>
>> I’m going to gather a few more instances during the day and will post them as a batch later.
> 
> I’ve received 8 alerts in the last hours and managed to get detailed, repeated walker output from two of them:
> 
> - FC-41287.log
> - FC-41289.log

These are really helpful.

If io throttling were the cause, the traces should also have a process
that's waiting to submit the IO, but that's not present here.

Another common pattern is hung tasks with a process stuck in the kernel
burning CPU, but holding a lock or being somehow responsible for waking
the hung task.  Your process listings don't have that either.

One part I wanted to mention:

[820710.974122] Future hung task reports are suppressed, see sysctl
kernel.hung_task_warnings

By default you only get 10 or so hung task notifications per boot, and
after that they are suppressed. So for example, if you're watching a
count of hung task messages across a lot of machines and thinking that
things are pretty stable because you're not seeing hung task messages
anymore...the kernel might have just stopped complaining.

This isn't exactly new kernel behavior, but it can be a surprise.

Anyway, this leaves me with ~3 theories:

- Linus's starvation observation.  It doesn't feel like there's enough
load to cause this, especially given us sitting in truncate, where it
should be pretty unlikely to have multiple procs banging on the page in
question.

- Willy's folio->mapping check idea.  I _think_ this is also wrong, the
reference counts we have in the truncate path check folio->mapping
before returning, and we shouldn't be able to reuse the folio in a
different mapping while we have the reference held.

If this is the problem it would mean our original bug is slightly
unfixed.  But the fact that you're not seeing other problems, and these
hung tasks do resolve should mean we're ok.  We can add a printk or just
run a drgn script to check.

- It's actually taking the IO a long time to finish.  We can poke at the
pending requests, how does the device look in the VM?  (virtio, scsi etc).

-chris


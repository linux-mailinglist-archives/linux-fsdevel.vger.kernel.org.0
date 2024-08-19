Return-Path: <linux-fsdevel+bounces-26319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CA9575C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5BEB21B45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB471598EC;
	Mon, 19 Aug 2024 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Fh8jobtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64A158A36;
	Mon, 19 Aug 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099760; cv=fail; b=gkqMbumy0wTcXTgtSH9FRwZWXErWTK24dAk31c+JVFLTXog4gPPdjDpm1O6SsG5L72n9/ZA/1PVj+3UgUoJX8Z69gNAq4iDFdzwJx/yeu1f0E656iBsE+zrEPkxHBZmo2oYXGelqD5C3X5Bxh4psyfQOHKvA9L/ubZr9r03E4Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099760; c=relaxed/simple;
	bh=XzIKJlmbeB3eXKd01qEXissQi/Rz7HoqOBjjMdHK1OA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usf+/u3yVORJ+JmDLkF7R7S7ZAVxVNtU31xlpapCG/axN9OCxKOaXQKkWyXfVN+1iM686eGp6uUsFHHLRJObfhRCjRvTBYYYp4NqWv/mYTU7qNbksbO1//JXJ5aERqVMcxSvhjnEfcjsx7G2Dx49rzH/e1qNuG89rFjTxaKNNzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Fh8jobtb; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47JFApe6022175;
	Mon, 19 Aug 2024 13:35:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=XzIKJlmbeB3eXKd01qEXissQi/Rz7HoqOBjjMdHK1OA
	=; b=Fh8jobtb6bluL8P4AtE0Up2eOrVB4lzZEskQYDVW3jrm46oK7z49xYv1GZv
	NvgUrVkdyU9k34yttKM/9aNFIjEQS/ED4WiHm4qW3cpR0gnWv7mTehkVoOGEzd2/
	+3OmN1qA2VFXBV+f23YqXxIZGTHMpSfAZ+qGcBp+ZiKDIa2mPodChfN5ZfSbTNpn
	k3arVs1p66V47GYYAyfq2PXkusRdSpfhcrz0Ua/fZi0E79O6YmQY/tl5l5d3Ckr8
	591yZav4SK24jB/QTEKFKcMrool+881gdHDZkZpsyynZH3+DFHMFsJnVMF7Uj8Lz
	1JSOyvC2Nz03wNUK8o/tYLPZJNg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by m0089730.ppops.net (PPS) with ESMTPS id 4148fdj653-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 13:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taxFp3Jy9+HpvvN+Mv1jm4KGHtohbuCJQU+N7NmsgrN4H8l6o+TLYj2RApw+mI4r8FZ1GD7P2IH9eCaEQk+aRlNHIJ6Wfg3S29HwC0YWNGv23wTiXNOeMyswcPWkgzB9z+9C6+3i2CdyY4DRKlr1uPkSMOKRLslGwYAQOzXXpE4ufZiM+xhJPsfyrjgNOSoLKJ/FhT7Ze99SSwLMIG450x5bBPOGQHznxtha/KUXE5QzPon34d9BnbUyFBx75KlSNXDyuG/2Yt3FiPx4EBSQirWIpKvcNiCk3cypD+iola6wMK1kUjHVkg5+Mas+4RnEz4A6jtaNeVRmDc6jf6EPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzIKJlmbeB3eXKd01qEXissQi/Rz7HoqOBjjMdHK1OA=;
 b=gNCLMeba0O4KCemWh6FuyHpBoR+om8usblTEsGYoSOJ585fk4bX3PZRZAw3J3gRLjjKFjFipKI9ibi7BeLyatGMVacl5hfae0a9s0qZXdUm4Tr1gwtgANrCukg0eTTTVc9YrahPJ/mXaH9pE6EYUeP8iwqKPwqQFlTifjl23ZG9DBVuCV3W9YQp8gz4i5TsX1h5ZIAHTmYeGsR5Y3hQyANun9ojt0xdddL4yL82FlSmpSTv8ExHeiSpZiFczcnku8w/CV/PO6XzYlSPJbGjh7ZHHYCLhN8lLhDhoSxe3R523CZk/wC8BNFRL0Zz+DbY9o7r+qvqdhSo3rfe5Pqum5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS0PR15MB6094.namprd15.prod.outlook.com (2603:10b6:8:12d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 20:35:53 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 20:35:53 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC: Christian Brauner <brauner@kernel.org>,
        Song Liu
	<songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        Liam Wisehart
	<liamwisehart@meta.com>, Liang Tang <lltang@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?=
	<gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Thread-Index:
 AQHa3u0J3x+q9TWVEkq4VV2cIBgMWrIIlswAgAAlQQCAACpzAIAAg8YAgARTMQCAIJSqAIAAQmAAgAAgpoCAAHu3AA==
Date: Mon, 19 Aug 2024 20:35:53 +0000
Message-ID: <370A8DB0-5636-4365-8CAC-EF35F196B86F@fb.com>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <20240819.Uohee1oongu4@digikod.net>
In-Reply-To: <20240819.Uohee1oongu4@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS0PR15MB6094:EE_
x-ms-office365-filtering-correlation-id: 03347472-cf64-4e36-86ff-08dcc08e8562
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zk1qOXRRMUxWRTA4Uml0ZzUzS0k4UFFVTS8vZCtiaTEvenhla05ZQVpYNVp6?=
 =?utf-8?B?b0k1S0Nzd1RreUZNSmUvRjVUaCtXTEhaaVVCZ1ZWN2xtNHBHNE84VDQvNEFp?=
 =?utf-8?B?OURVL3M3amFwaXBmZnplMmtvRjdjQ2tjTTU4TW1TeG8weU12M09xZlBqMnNs?=
 =?utf-8?B?UGlXa2FJSlF3d2pBMndCZkFUSGVqVnJQTy9BaWFwTzArSXZweXZRdXJhOUNn?=
 =?utf-8?B?cy8yTnRMMzFsVTlKQ3c0UWU2bmVYbXNmZENJRlIrK3ZCSGZ3eVpEMzlRVks5?=
 =?utf-8?B?bmFrTVhzbmk2eUFRam1IVGErbWRBYzRiWVlJS3ZZMHFPalhlQXNYUWkyQzgx?=
 =?utf-8?B?azQrQ3ppQlBtR3QvOVlidUlyZ21kdFozbm1hS1lPNWpCT3ZkeVM1Tkl2bnlt?=
 =?utf-8?B?VWR3U1RHb0xuRDFkNTM5eU9zeXpDZy9CM3JlZ0MycW9HWmFxdnlJVUxrcWxz?=
 =?utf-8?B?bDAwNkF4OW1yRDcvMWhMVm9QaFRXMHFuYmlJdnYvWnZnMXAxRHlXZ1IwMmNx?=
 =?utf-8?B?YUpuUnM0aWdOWlR2N1ZpNjBockxGSDBSeTZPeTd1NHY4K0oyYVlFMnhEenV4?=
 =?utf-8?B?K0pldm1uVFd2T2l0WFo1bGVtZ1ZJdi96NzRPTE8xZThpNFhBMjVMUkdUb2ph?=
 =?utf-8?B?RDJ3YXhRNXVjN3lqdEx3RlQvaGo5WFJQSWdPMGpSODRHZ0hlNzhSdlE1SE1O?=
 =?utf-8?B?T21ZNVZ0QmZLc1BzL0MyNW1QeXpEajNHMzMyQkE1aVpFRmpPOUllUFRNMUJh?=
 =?utf-8?B?NGdXak92ZkF5YkZlcE5CS2RpbWQvVWhJNWZYNGNncDhaYkFWY05PN09JeW1z?=
 =?utf-8?B?ckVLZThRSENPc0k2VDY0LzNNdkdZemxIamhOZjMvVjd0U09FY0N1T2MwKzZ4?=
 =?utf-8?B?Mlp4N2ErM1drUlVPMGp6SVB0N08xdnB6SnRKdVJnWEJIZDlOc3Z0VWVuaGhJ?=
 =?utf-8?B?OG9paVZiOVJaTWI0dW9aTTU0T1U0d21VcEovTTBSaVJOcHQ4cnNuK2o4cXdX?=
 =?utf-8?B?bEhDMHJ3S3hocEt4NW44WlI5N0VPSXJPQlRrOFFGNnNVRGJ6OVNyY3p0Lzdo?=
 =?utf-8?B?dmxLVnRYTU9GT2wvZC9ia3dSeFJwQ05ad0VlZEhlZGxNQjRNUUEwcEhPTzZK?=
 =?utf-8?B?QmhzalNSMDNRVVY1b0Y0N01GMFArZWNhQnhKa3lvcTlhRHF4aUY4ZmgzYVdz?=
 =?utf-8?B?cWtyVjRybzBhN056dU55c2VTalJiRWhhNDdrNHYwU1AxcUdERUVndFhyek5q?=
 =?utf-8?B?TFNJeFBzbThFeFRFWXlGaU9FRXVSdGRPV3o3bitDK2FPcEY5N0VTZmhJUTY4?=
 =?utf-8?B?NjhTcEJ6RGU0azBDaGp1QitaVDdoOTBpUDltUldEQUQ2UC93b29rbEt3RUk0?=
 =?utf-8?B?WmhMRnVSWXFtcWRXUEFPS3lUOTNDWlRSMUpldGxIN2VZSVhuQi92T2xWUWgz?=
 =?utf-8?B?ZlJTd0JCNUZ4VXpxaHFSVnExbnZoQzVMS0JOeFZZb1VBT2lIOHNWRmhIcXdC?=
 =?utf-8?B?S0s0RUlFdWhJQWI1OFRFY2trVEE1dG1rdHBBdVJXSXN5eDMrL2IycHRZaXBT?=
 =?utf-8?B?TnNsOVI2a1dQa1hqdUVRVEN3d0FYK2l6SkNhK2xmRE5MQUJ4eDhObGVCS2ht?=
 =?utf-8?B?VEVRTTBicnRxRndCRGVQaXJ1TUVJRThWSHlMWjkvKzhuSXdNRnJIbmJwcEZR?=
 =?utf-8?B?UnhadGxKOGFLZWNtcTgrd1lTcDdDWHhSdEwwbk9XN2xxcThNZisvZTJSdllX?=
 =?utf-8?B?V2ZQbzQxMUx3dEZoTE1oNVI4N1drRkRmYTJCeVl3M25tdm1QaHo1MERNUG1E?=
 =?utf-8?B?OVkxR1pxTU5nM3ZDdDN4aHI4THovS2lhRkt2eDBSdU1PS1lyY2ZTcFdPNjU1?=
 =?utf-8?B?QnZuRzBZNFN3dzVaQVVGU2ZjWnhHMHF0eGRHc2xnQjIzYmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SStvclYxQjdrc1c2aEJHc2NWTUZOWEpwTVZIZ3V4aVhFa1grUzh2S01meDVy?=
 =?utf-8?B?Ujg5N0h0SjNiWEJKMDIwVlNiM1ViUnZDb0RydUsxenhGM3V5eUxpaGtSb0Rj?=
 =?utf-8?B?WWczanl2anBaS0lxWmJHaVZIb2hSajh5SVl3YmZTZFN1ZDZ0UlkzaDdwSUNQ?=
 =?utf-8?B?Y244dm5hSVVySXlPbE5SeVBJSS9qTmtqSkZXdmFRNVBtVlFOanNHNjBXaVVF?=
 =?utf-8?B?RmY1aUhKTFoxaTg5WjU2clM3MnFEelFUNDNhZEhvWEljYlI2YW1ucFYwZlFU?=
 =?utf-8?B?RWUzclFaSTJsSTMybnZWZ1poVkpQYmdvTGhUYlpZV1JpcUVRN1ZkbUN5UDNO?=
 =?utf-8?B?VlZhbk9wR0RZcjNuYk5FZ1BUQldydTNyejJBN3lzbkVFZXpZYUlLUHllUmZI?=
 =?utf-8?B?L2dSRlRVWVh1bGRRNnlYRWxKK0RmQ1RQZDV5cGNNZ1JrMHR2NGROYTdxckh5?=
 =?utf-8?B?dGMzb2pkWjVZS01Ucis0blJMejdTZ2ROSlZGd21oa1JYbWtwa2REM1B6SFhv?=
 =?utf-8?B?UlRUbVdHYzJ4QlJqR2VxeDgvWjRzK210Vjh6MW9LeU9xTVg2RmlFaDRaTEJx?=
 =?utf-8?B?NEhhVFIwNE5DZzZVZEN3dnNRdlcwejdVRmwwUTFYdVlTa3c1bU9IbE9WTVZy?=
 =?utf-8?B?ZS93YVVNNDUvL3pYZnl4NFlUVnAvczhYL0hFZDcyTWhHN0tYQzI1T3p3RnRB?=
 =?utf-8?B?N1ptRFhCOG9KM0czY3hrTkRpTnB4K2FMcXpPWVlQT0QxakFjT2RLNzB5L1F3?=
 =?utf-8?B?MEpkR3dzbE5VK1NETVdGRmFYS1l6TDBVQUs5ZVVnTUxzejZlUDRWeGZ6S2Fa?=
 =?utf-8?B?VEtvZkRBbkZmaEV6aitSZXJBVVAycVRuUTQydjNXelA2T0IzVkxDUDJJNlFB?=
 =?utf-8?B?S21sV1h5RW5GTTFEbEVJL0xvTDU3RUJqbEI1OW5weUtXd01GRDNRWFo1TDhq?=
 =?utf-8?B?clBBREhHeEdBOElzVjdXWHNRQlZ5VFdPUEM0RnMySUtRUVZHVkhSbkJKUnh1?=
 =?utf-8?B?ZDN0dXNmMDdwL3gxZ3RkS2s1NHM2WDdCSXM3K29wRXpHS0VxdURsaS8weXVv?=
 =?utf-8?B?NHgzQjFQTU5pTTZ5cW5IZnhYWWU4K1BPNkJQOTlqNTlVV3E4bFdQU1ZvYXlS?=
 =?utf-8?B?b2xTck0zd3JQMkJOam91RjMrcTk1bklnWjVSOXU4ejZLTDB5ckR4UVFMSmVw?=
 =?utf-8?B?ZmdLclRPR1lKSndmZGZ5U0F4S0ZZUTVzUWE4blJGeU50ZmdSVk1tbGprNS83?=
 =?utf-8?B?OE9ndmFyaDExcTViQUdvMnkvelBpTnBldFExOFRDS0YwaFNyRm0zRTVzdmFD?=
 =?utf-8?B?cUtxcEUvOTdka0xMMytpazJkcnd4cW1oKytxRUtFNTlJejY1OEZhZFhGMGVp?=
 =?utf-8?B?ZFJrYWh5QzQ2YkRTNENZVWNtNTE4ZFhsaUZxRVNWbTNjcHVnM0xqOWttbDYz?=
 =?utf-8?B?M2JzbktiU3lwd0dhNTAvNjRCSlVSTHpRb0FDbVJsenM0WTArbVR3SnlOaDhO?=
 =?utf-8?B?cG5mOU5YaWZ6Y2lhSWZzK3JJWHdFQnF2QmVwRVQ5bGlpOEYyVUdpTVZuNkls?=
 =?utf-8?B?cWN5YzJUcUgzdm04ejNVS1lhUTh3dGE5Y1VKZUI4T0xtdjJlUzFuL2tCaUNG?=
 =?utf-8?B?aUF3Z3dzUTMxK1QrMjlPTHF2NnlFK1Q4RlBtNy94QVM5cFY3TlB2VDNrZFR0?=
 =?utf-8?B?RmI2VExFV2M4SW10a0l2emxIdG5vOXpkYTlaNzNSM2xwUWtrL01GZFJVR2tl?=
 =?utf-8?B?Z3BXOUJSbVI1SjFwenU0c3VybTBIaTNKQ2tRR1VpZUwrR0NVUkMvdjVMZkNm?=
 =?utf-8?B?Z3NyUHVzMGVUTzg1V2M1MmF0RVBVWWNNeWlkYzdNRE54UVQwRHN6SFY5R0k3?=
 =?utf-8?B?UVRwaHVNbUdQNXoyNVBNNmZick5HMUNCOUloR0liR2R5U2JYMWxTbXdDbUps?=
 =?utf-8?B?RzU5Q0RZNXp2Z3VESlQrK0lUdjU0ZmtRNTIraEdDVnY4RmEvVFpBL3FneUpp?=
 =?utf-8?B?VitHSU5QaEI5Smg0enQ3djlwU2RDekZjclZwSUNSTndXTUI5UWp6SUN1a0l4?=
 =?utf-8?B?bmtxYzBwdlBLVVpSUjJ1d1l5djFuOVlPVkg1UHo0ckNMV28wWHEyVmV2Zlht?=
 =?utf-8?B?cmYwQVZ3U1NKRXRhOEdEWExuK0JLNGx4dXBOcGw2TnQ4UGhGRGxKUVBXM3g3?=
 =?utf-8?Q?oQSQXL4P6SJc9xdgbDBjFhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1F43DE066D7974CB0935EF4007DD62D@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03347472-cf64-4e36-86ff-08dcc08e8562
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 20:35:53.5230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRLjBxG4ZklZHrjoaHpinIQ8TOdpYflgaho5utpt7uFMrnLk9Ru/cngrt4EjNCdCW5Dxdl2YjUxqP3gCvmv4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6094
X-Proofpoint-ORIG-GUID: kMMceY-E1RlD9we_QBw-8Q3FsbjwTJMK
X-Proofpoint-GUID: kMMceY-E1RlD9we_QBw-8Q3FsbjwTJMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01

SGkgTWlja2HDq2wsIA0KDQo+IE9uIEF1ZyAxOSwgMjAyNCwgYXQgNjoxMuKAr0FNLCBNaWNrYcOr
bCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiBCdXQgYmVj
YXVzZSBsYW5kbG9jayB3b3JrcyB3aXRoIGEgZGVueS1ieS1kZWZhdWx0IHNlY3VyaXR5IHBvbGlj
eSB0aGlzDQo+PiBpcyBvayBhbmQgaXQgdGFrZXMgb3Zlcm1vdW50cyBpbnRvIGFjY291bnQgZXRj
Lg0KPiANCj4gQ29ycmVjdC4gQW5vdGhlciBwb2ludCBpcyB0aGF0IExhbmRsb2NrIHVzZXMgdGhl
IGZpbGUncyBwYXRoIChpLmUuDQo+IGRlbnRyeSArIG1udCkgdG8gd2FsayBkb3duIHRvIHRoZSBw
YXJlbnQuICBPbmx5IHVzaW5nIHRoZSBkZW50cnkgd291bGQNCj4gYmUgaW5jb3JyZWN0IGZvciBt
b3N0IHVzZSBjYXNlcyAoaS5lLiBhbnkgc3lzdGVtIHdpdGggbW9yZSB0aGFuIG9uZQ0KPiBtb3Vu
dCBwb2ludCkuDQoNClRoYW5rcyBmb3IgaGlnaGxpZ2h0aW5nIHRoZSBkaWZmZXJlbmNlLiBMZXQg
bWUgc2VlIHdoZXRoZXIgd2UgY2FuIGJyaWRnZQ0KdGhlIGdhcCBmb3IgdGhpcyBzZXQuIA0KDQpb
Li4uXQ0KDQo+Pj4gDQo+Pj4gMS4gQ2hhbmdlIHNlY3VyaXR5X2lub2RlX3Blcm1pc3Npb24gdG8g
dGFrZSBkZW50cnkgaW5zdGVhZCBvZiBpbm9kZS4NCj4+IA0KPj4gU29ycnksIG5vLg0KPj4gDQo+
Pj4gMi4gU3RpbGwgYWRkIGJwZl9kZ2V0X3BhcmVudC4gV2Ugd2lsbCB1c2UgaXQgd2l0aCBzZWN1
cml0eV9pbm9kZV9wZXJtaXNzaW9uDQo+Pj4gICBzbyB0aGF0IHdlIGNhbiBwcm9wYWdhdGUgZmxh
Z3MgZnJvbSBwYXJlbnRzIHRvIGNoaWxkcmVuLiBXZSB3aWxsIG5lZWQNCj4+PiAgIGEgYnBmX2Rw
dXQgYXMgd2VsbC4gDQo+Pj4gMy4gVGhlcmUgYXJlIHByb3MgYW5kIGNvbnMgd2l0aCBkaWZmZXJl
bnQgYXBwcm9hY2hlcyB0byBpbXBsZW1lbnQgdGhpcw0KPj4+ICAgcG9saWN5ICh0YWdzIG9uIGRp
cmVjdG9yeSB3b3JrIGZvciBhbGwgZmlsZXMgaW4gaXQpLiBXZSBwcm9iYWJseSBuZWVkIA0KPj4+
ICAgdGhlIHBvbGljeSB3cml0ZXIgdG8gZGVjaWRlIHdpdGggb25lIHRvIHVzZS4gRnJvbSBCUEYn
cyBQT1YsIGRnZXRfcGFyZW50DQo+Pj4gICBpcyAic2FmZSIsIGJlY2F1c2UgaXQgd29uJ3QgY3Jh
c2ggdGhlIHN5c3RlbS4gSXQgbWF5IGVuY291cmFnZSBzb21lIGJhZA0KPj4+ICAgcGF0dGVybnMs
IGJ1dCBpdCBhcHBlYXJzIHRvIGJlIHJlcXVpcmVkIGluIHNvbWUgdXNlIGNhc2VzLg0KPj4gDQo+
PiBZb3UgY2Fubm90IGp1c3Qgd2FsayBhIHBhdGggdXB3YXJkcyBhbmQgY2hlY2sgcGVybWlzc2lv
bnMgYW5kIGFzc3VtZQ0KPj4gdGhhdCB0aGlzIGlzIHNhZmUgdW5sZXNzIHlvdSBoYXZlIGEgY2xl
YXIgaWRlYSB3aGF0IG1ha2VzIGl0IHNhZmUgaW4NCj4+IHRoaXMgc2NlbmFyaW8uIExhbmRsb2Nr
IGhhcyBhZmFpY3QuIEJ1dCBzbyBmYXIgeW91IG9ubHkgaGF2ZSBhIHZhZ3VlDQo+PiBza2V0Y2gg
b2YgY2hlY2tpbmcgcGVybWlzc2lvbnMgd2Fsa2luZyB1cHdhcmRzIGFuZCByZXRyaWV2aW5nIHhh
dHRycw0KPj4gd2l0aG91dCBhbnkgbm90aW9uIG9mIHRoZSBwcm9ibGVtcyBpbnZvbHZlZC4NCj4g
DQo+IFNvbWV0aGluZyB0byBrZWVwIGluIG1pbmQgaXMgdGhhdCByZWx5aW5nIG9uIHhhdHRyIHRv
IGxhYmVsIGZpbGVzDQo+IHJlcXVpcmVzIHRvIGRlbnkgc2FuYm94ZWQgcHJvY2Vzc2VzIHRvIGNo
YW5nZSB0aGlzIHhhdHRyLCBvdGhlcndpc2UgaXQNCj4gd291bGQgYmUgdHJpdmlhbCB0byBieXBh
c3Mgc3VjaCBhIHNhbmRib3guICBTYW5kYm94aW5nIG11c3QgYmUgdGhvdWdoIGFzDQo+IGEgd2hv
bGUgYW5kIExhbmRsb2NrJ3MgZGVzaWduIGZvciBmaWxlIHN5c3RlbSBhY2Nlc3MgY29udHJvbCB0
YWtlcyBpbnRvDQo+IGFjY291bnQgYWxsIGtpbmQgb2YgZmlsZSBzeXN0ZW0gb3BlcmF0aW9ucyB0
aGF0IGNvdWxkIGJ5cGFzcyBhIHNhbmRib3gNCj4gcG9saWN5IChlLmcuIG1vdW50IG9wZXJhdGlv
bnMpLCBhbmQgYWxzbyBwcm90ZWN0cyBmcm9tIGltcGVyc29uYXRpb25zLg0KDQpUaGFua3MgZm9y
IHNoYXJpbmcgdGhlc2UgZXhwZXJpZW5jZXMhIA0KDQo+IFdoYXQgaXMgdGhlIHVzZSBjYXNlIGZv
ciB0aGlzIHBhdGNoIHNlcmllcz8gIENvdWxkbid0IExhbmRsb2NrIGJlIHVzZWQNCj4gZm9yIHRo
YXQ/DQoNCldlIGhhdmUgbXVsdGlwbGUgdXNlIGNhc2VzLiBXZSBjYW4gdXNlIExhbmRsb2NrIGZv
ciBzb21lIG9mIHRoZW0uIFRoZSANCnByaW1hcnkgZ29hbCBvZiB0aGlzIHBhdGNoc2V0IGlzIHRv
IGFkZCB1c2VmdWwgYnVpbGRpbmcgYmxvY2tzIHRvIEJQRiBMU00NCnNvIHRoYXQgd2UgY2FuIGJ1
aWxkIGVmZmVjdGl2ZSBhbmQgZmxleGlibGUgc2VjdXJpdHkgcG9saWNpZXMgZm9yIHZhcmlvdXMN
CnVzZSBjYXNlcy4gVGhlc2UgYnVpbGRpbmcgYmxvY2tzIGFsb25lIHdvbid0IGJlIHZlcnkgdXNl
ZnVsLiBGb3IgZXhhbXBsZSwNCmFzIHlvdSBwb2ludGVkIG91dCwgdG8gbWFrZSB4YXR0ciBsYWJl
bHMgdXNlZnVsLCB3ZSBuZWVkIHNvbWUgcG9saWNpZXMgDQpmb3IgeGF0dHIgcmVhZC93cml0ZS4N
Cg0KRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQoNClRoYW5rcywNClNvbmcNCg0KDQo=


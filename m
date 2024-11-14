Return-Path: <linux-fsdevel+bounces-34833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F819C9121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892EB1F22EB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529F18CBEE;
	Thu, 14 Nov 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Mtw4sQhW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511D3BBEB;
	Thu, 14 Nov 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606731; cv=fail; b=e0QJeSwjXGmeTSQgiPQXzE67b45odlEuKAM9EauEgbVDNpMXnqffGZKGMeCxxCfFHr6ePYjM2EOSj9xSdgF88KRuGSad3KoXENtT1SAOmney6gtCHFKoW1ikqK/+5aFORBIh1efYq6jLjmcJFddUpsc30YMX2gYbI2+dkuxnbZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606731; c=relaxed/simple;
	bh=Sc8Hwb4Vt8u8Ba16lTU2aktm3RWReAcox3IcK3K304Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SO9SJdOvFlVxiRbF/oQfTSB3OncRzikruCmbQPirsplOudeCFAaTEvzMFgCv4za+gVyXNmJb0Og6mlpy26aZw6JLoKMqEpEvtxO92rpKrCw4VLC9TStRxiSKyqvQ7S9HBV/Krs6e97tC8XvqWykKVolmiXburUTLVBJoxMQNFYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Mtw4sQhW; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEHNNRS001356;
	Thu, 14 Nov 2024 09:52:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Sc8Hwb4Vt8u8Ba16lTU2aktm3RWReAcox3IcK3K304Y=; b=
	Mtw4sQhWnT/K6TakNiFriBxNsxHMPjJ6BAO+2GWL+d9lswJ1VViKAZWCVX0Vpkar
	KgSv2cVhOVKyjG47xdwcVkAdqKZPjR20rL8HRydCzgYNymyE2Zxlx9uCi+GDNbVK
	3xPwjvdyKwfn2Bs4fxm3crxS4KBM5+0mmUeJOxzTsgi9xLkpPuizvTXUUujOvmAL
	tnAuBXygRE8xjNIFbxl5sZQdShrMGycQ9lzWoz5phis23w/jvTrBhsl3Ei0W3a44
	Ga/rzZQ2/AFLMRJDRTXLAvsjObjescl3Rix2gXEG/fgBmaizgcbumTQyrkF0KXeA
	mv29SdIKQuXqyo9yGDd8QQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wmqbrs4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 09:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kogg29wkGJe/JMxeZVXvRvLrGuRD5zVF+p+B32DFROfvr/sJPxCDzbhOfSycdDFT1p8SE2KTuJq8YBqkRWYAAhHB0UpUoAks54iQZsX6SvUbGSpTQjHPOh1heUqbN11A0KQMKYn+KTfmhyjGAe+A15BY1YDvrV5bZEi9i0GNpiA3yyjblSy6uQwMJ5tPPao4durKaPBRAV0Vf5EGbzOBoE3OuUeVHO64XwfuOBQdzhhVQZjgxNIDPMng0ZBDwFui8fH9xvwjgzkelZWSmNxItky0ojpv/++56WfQgzoYhbzl3rMQrhkSjo0pvH6dPIPQiamFVLqJGjyWpn4DxylTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc8Hwb4Vt8u8Ba16lTU2aktm3RWReAcox3IcK3K304Y=;
 b=ZVWqM3DYDlAf6RzLvzUvCYW5TiMWaJL+e5nJK9/FmqOqDsuqG2ybiJtsCzDkK172Af8dxgjVqPnc5RqdQCRXBikKysu47R/cr3HVuD9212B805eVP4z9Kb1iMECe5hsED0Bar/6qllUCDz9IAzC1Qe+VOGQtbbKYCW1doqVUqdZpoPX8+IIc+AT7bTM4V3q9604jVw/Iq6FG7joLpz55EvHA7xKbf5Zby3zBB4BkdPaJHmHSMLKPfmSgXZmbwVZT4F+ie/EoE0GXltBRD8OXPXX/6iH7WpAUBmg2YD70h/ZQ4s/XZMsgxYqREsP5+uCRE5YFlK4zPkTuojDen3q0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4750.namprd15.prod.outlook.com (2603:10b6:510:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 17:51:59 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 17:51:59 +0000
From: Song Liu <songliubraving@meta.com>
To: "Dr. Greg" <greg@enjellic.com>
CC: Song Liu <song@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>,
        Song
 Liu <songliubraving@meta.com>,
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
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com" <repnop@google.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
Thread-Topic: [PATCH bpf-next 0/4] Make inode storage available to tracing
 prog
Thread-Index:
 AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yAgAEUSoCAAA4qgIABaxuAgAAU/YA=
Date: Thu, 14 Nov 2024 17:51:59 +0000
Message-ID: <03311B48-8774-4F54-AA4A-4220EA3096C4@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
In-Reply-To: <20241114163641.GA8697@wind.enjellic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4750:EE_
x-ms-office365-filtering-correlation-id: 3b3606b9-3e9f-41f6-cd7c-08dd04d509e1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEt2SG15RjV5NlJhNXBGR1N4L20wV2RTUzZjaFNQd0o1RFlKUDdWdEs4UUhT?=
 =?utf-8?B?SmkyR1pZQ0QwWHJpR0lGOXRzYkE1alQ5elRpNUJ6V2cxNk1NblZadUplelVD?=
 =?utf-8?B?MlhrWnVSTlN3MXpDTnY5VmpLd1RCMEV2UFNMV2Q3LzJ5UGU3NDdGaUs0WlJ1?=
 =?utf-8?B?dGlJOUNDRTBXZFBwcHowRDQxQmNBUk94dld1bkRSYXVNR25pWFo2MDRvdkIw?=
 =?utf-8?B?SGtjN05ocDQ2MGo1VWFrdmdQRm56dS9tK1F5eUR3WXpXd2Rxa0gyRFJrSTdy?=
 =?utf-8?B?c2c0SUo2SHFxOGxMUmJRNkFRWmYreW5FOVM4cUtxNjBnRlJzeUJiVDBhVzFN?=
 =?utf-8?B?WFBHc1Z4UTVweGk5bVJRU2lKWWF5VEVrZ0tHL25laktkb01hOGwwcm5OSTN1?=
 =?utf-8?B?cFFaYzRIODUzazI3cXBHK0RBZTd2cTF6bmpWVGtXTC9qWWQ0ZVhab05renNa?=
 =?utf-8?B?ZDdGTEJqckF4V1NpV0JnK0FhSzJ5Q3V1djdpemcvS0ZSRXk3bW4vRVEyMzgy?=
 =?utf-8?B?MnJVOGx5VlBMWkFBNXRlUTE2bFVqK0Z1UHp6R3RnME10Qy95UStIMWphOE5z?=
 =?utf-8?B?eEp2d1c0M3JMV3ZzVzRpdkpxcjhjVXBHeTE3WmlIaVJWcW9aQldYU3lUMDBr?=
 =?utf-8?B?UFFFRTFuVnJ2bndKSWZoTXF1dTI0OEtpMnl2ZklUTmtDT0ZpYzF1TnJDUVJB?=
 =?utf-8?B?VUlLT0poNUJqWGIzK21Nam12MWtnbmRoMThpQy9seDBMSVNONW5sN1FOSWI2?=
 =?utf-8?B?UFBENllzUGx4aHBpVEpzTkFiOHB1UDhvV1RDTGl6SUljVEtPa2Y4dnpqWGRU?=
 =?utf-8?B?SDBTQm9abEVrazR2TWZPanVYQzRmUnpuVTU3QWdNSVFQQ2l4TUhKTlZybUpY?=
 =?utf-8?B?TUQ4TDFmcG9PNm5qcjc5a3JyRVhhY0ZwYkprQjdkRDNaei9YTU9GcUQxNUN0?=
 =?utf-8?B?RUZwZG5jT3pzUUp2ZFF4YTBzOVROcjZYT0d4SktNRzJNdkVDQWVQZkh2R1gw?=
 =?utf-8?B?cU1lOXRiR0NQVWxxVXd4MTRGSFdxVmdpQmc5c0UwQU9valF5S0pMZjRGcHh6?=
 =?utf-8?B?UmYwU1E0MjVqV25FeGVmWU1xd2JkWTJ3OXIyeklFeUJydVVuOUNLbUdmNllI?=
 =?utf-8?B?Qjg4VXRXZmRkNzBnMGRPL25NSFF5dmRpcU0vK21oM0k2S2E2M1BxcnRZZlRt?=
 =?utf-8?B?K3Q3SWN6dXlUWm5CTDhyM25kY0drVm5zdnBUVG12MU9DbW92MW55eWE0Yzht?=
 =?utf-8?B?ZWJFN3g1M0lrS1RHWURvSDlJOEVLRWFwRllUTlN1azgyaG5kSDBxODhPd2NL?=
 =?utf-8?B?eHdsb25TekVLZXJqd3BTKzBVNHlnMnJEQUsvUTRlRkJIU25OaEFxY1k5emJz?=
 =?utf-8?B?ZlFubmdMVW5Sb3FuU3ZsVEd3Mm9uUEI2SUx6R2I1SkgvS2dlUWEwbkZWanJm?=
 =?utf-8?B?ZXU5cFlrVXJ5ZGdxWUwwRm91MDRaelk3N3hYdnpnV0lIVXFoY1Q5WTJvZXdR?=
 =?utf-8?B?bzhKK09nYTc4WloyYjA1YlBwVWlvaDJvYWJRcXZKYks3MitvRFZXdllKZUNi?=
 =?utf-8?B?eTJoNkFGQjFjNzhjTlBDbmJ6UTArNHkwbG9DTEVvTGJ4M0MzS1U1SCtqTTFk?=
 =?utf-8?B?L2VqaFl4Q244TGRTZ1dWdzBKZ2RtTzNlTXl2cStqc1ZUeittNXI3TzM3SEFI?=
 =?utf-8?B?WkxsM21zS2V2UTRRaVppYmhReFBBMUZIVGQ5d0lXdVZFNzY3MEd6dXREMTBM?=
 =?utf-8?B?K3piNDd0WjZIQ1FIVDA0bFMvYjMwT1VxcmpKd3JnTEFDdVZvZzRhNmtSRlpR?=
 =?utf-8?Q?WLvMG3gFQaDmFRaVEffG7jMQVoyE0FzgNj6Go=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVpGcWkxRnhWUTJETENIU24yVmxoOU45dHJhRStyd0VWeHEzcmJTY1VBeVFK?=
 =?utf-8?B?V20vM1cwRlhKRmMzRWV5RU94VDVkVkFIM05ZL0JZVUxDdHQrd2NrTEwyamtE?=
 =?utf-8?B?c24xek03clpaSE5LN2kvYW1WZDFXUGJQblBGQ2YramEwdHlwSisxYmV3cXg4?=
 =?utf-8?B?ZGQ5YTZkMmxhckE5QmhrY1Bsdk1RWTRNaGZoVEtIdXRQck5YUld0cm5ybWJa?=
 =?utf-8?B?QWtzSTFoMDdVK3EvclZYc3Z3YXNWUlhWWDE2TTdHNGNNdU1VK1BHZmFSUGR0?=
 =?utf-8?B?OERFQWthcVZMeGdnVWs3b051VUczcTd0OVZ3OTQ4dnR3dVdGSHN5T3RZMG00?=
 =?utf-8?B?VWJKaVE2Z3VZaWM5M044YTZwamo5cXIvK3Y3a3RWN0ZVN0RJdzRLb2lia2lU?=
 =?utf-8?B?M2FCT3VIVmY0YlFtVk4yUUJ1UlBsMXdjM2VVWTRQaS9PZ0Z2R3dReU00LzB5?=
 =?utf-8?B?b2FCUm94MG9hTHZrVE9TRFRMK0tpUDNMWjRTNnN4RHllOWtFZjhnTkJOcG1H?=
 =?utf-8?B?YlZPd1lMbWxsOUp1WDAzOUxnRTFWcTlkYUMvWi9KeWZkejRVdHZVZDk5VVBn?=
 =?utf-8?B?eVkxOVF5ZW1aaGJjV3ZjR3cwSGRmMkhvWFcrNks4V2RLbktNRGlDd0xJNUhC?=
 =?utf-8?B?OWoveHg0MlhtblNBS0ZFQ0FGL2IxR1VpbU5mV09LbEpvWTFUVkl1cmY2cmxZ?=
 =?utf-8?B?K1pMRTUxREp6UlQ5MFNrL0ZPcUp3UEdDeHhnNE5nU2VYUlJIaS9Mb2dWNk9O?=
 =?utf-8?B?VkVaVkQ5UEhOVTAxL25JZ3pSVGNQeG5Pb1hmUng0TXVESzZ2dGlweHd4YVM3?=
 =?utf-8?B?ZGl0MDQxSUtqRjZITDFrMll0aE9vcjBiSG5DSWFMbWtCdGZYNmNVV1BSdkxT?=
 =?utf-8?B?WnoyZ3hXVEdLcnFrVXRPcGhhdGhkTnBEVjJwbmp5aVdGSWFTajVpR0Ribmp6?=
 =?utf-8?B?M21ZNGI4ZlFQYy9NaVdFdzh4UmlxR2x4aTM3SU5lbFBEbjBKTkpwRkNpdXBF?=
 =?utf-8?B?MXQyTmtpZzMzQ3hBLzA5eXFseHFmai91M0k2NWxsejJNNzBUQU94UTR0aFIz?=
 =?utf-8?B?WXRwVW9ZOEk4VU1LU0FtbTNOUGsrYmVyL3dSTGNvTE9KejdOaVQ2eGl6Nmc1?=
 =?utf-8?B?MmU1MWVXeXdTNXl6SnRtejVTWWZ1SnY4U0JUYjgvUTk4ZFhKOVlWNWtpRTVp?=
 =?utf-8?B?dTYrOUpYaUtreUc2aDlVaEU3TU15SS9aQlhzNEdHazhrWXlTb2JZczhCeURi?=
 =?utf-8?B?dnp0WElJVGxKMmxYRFArV0M4eW1YR0FIQlIvYWkxTzFrOWhDQ3ZUUEsycVpD?=
 =?utf-8?B?NktRTjh0b09yRVV1cGcyQ0x3REw3eEM5aDdEU25aanJzSzUwQ3hZUFNSSk8r?=
 =?utf-8?B?TFJId2xXTFJCQVNjS0llNjdhVzZQdC9xa2Nua2Q4YWF3UG9JZGVTdzAzaEht?=
 =?utf-8?B?Z1FHUnkrM1VmaS91akdZUCswTkxvN0E1RlpLaDZZcXMxUDRRdzlHNG1wUTRx?=
 =?utf-8?B?cnNmeTd2THZqcUdqeXI3V0FsWXpjYmt0UVdPY3lFWjdqQjloV2Q0VnJZbjdz?=
 =?utf-8?B?bytOeUFYRHdZRDhDY1VBcmE3QWJqMlZaWG1zWDR4cU1tSXk5b2puN2svejVu?=
 =?utf-8?B?OUNGc3ZJMnpRZzJpdjRmc1RCNHJHK2hhMTc1bno3eklleTMxZWoxcDhiNEh5?=
 =?utf-8?B?bFRBaHVDdjd2TE05dGhNbDhIMktFMzV1VC9GK0VvYU9uQUR6a255OGdLY1hK?=
 =?utf-8?B?OHlaMVJqZmxxZlBFQ00yNjBaTS9XQzkzeFdaeWZnWFN0YkJoamtFRjRGd3Nu?=
 =?utf-8?B?SXhNeVNrT3lCR3pRd256ditoOUZ2NU5jTjMrT3dRWWlZZ3FtNW5uaFRuOWlK?=
 =?utf-8?B?WVovZzM3SVhJT01xSjhQSWUwZUd0MC9rYXNLdkZRUDVlcWpMZExLR0tXOHl3?=
 =?utf-8?B?Y1U4YndUUXNKazgraHh5OTJUZUtqUnR5MVJ1SWVXb05VS2lzNzhVb2UrMTVN?=
 =?utf-8?B?NlRZR2owSmRkQ3VsSUlrM3RzaEFHZWhGQWV5S2s0SVkya0lHV1JEK0JvMW9Z?=
 =?utf-8?B?TU1SY1RFUlJaN3BiODZBUHJwbm44d1FBeWRJamhCWGEwRzEvK3dMSzlmdUVO?=
 =?utf-8?B?WldoQThRRjBYN3hXNFo1dzUzbnhDRzFsTHFTdFRDajdBeG1jcGNCREJpVUdW?=
 =?utf-8?Q?S90qpVN4IXjkdidWAXKGcbM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D8BAC86ACF64F49B6F400FB62372569@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3606b9-3e9f-41f6-cd7c-08dd04d509e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 17:51:59.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pqzz2sNgAUph3fLw/xMBQVbE2IJXRu2RazUKarb87h/wYOWYiRaYCFGi/JdnPCQI0v6raAheRw3MVJHGG6scWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4750
X-Proofpoint-GUID: FH6I27bIeSMXjFDAe7ZfNNdBU7yPUzpi
X-Proofpoint-ORIG-GUID: FH6I27bIeSMXjFDAe7ZfNNdBU7yPUzpi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgRHIuIEdyZWcsIA0KDQpUaGFua3MgZm9yIHlvdXIgaW5wdXQgb24gdGhpcy4gDQoNCj4gT24g
Tm92IDE0LCAyMDI0LCBhdCA4OjM24oCvQU0sIERyLiBHcmVnIDxncmVnQGVuamVsbGljLmNvbT4g
d3JvdGU6DQo+IA0KPiBPbiBXZWQsIE5vdiAxMywgMjAyNCBhdCAxMDo1NzowNUFNIC0wODAwLCBT
b25nIExpdSB3cm90ZToNCj4gDQo+IEdvb2QgbW9ybmluZywgSSBob3BlIHRoZSB3ZWVrIGlzIGdv
aW5nIHdlbGwgZm9yIGV2ZXJ5b25lLg0KPiANCj4+IE9uIFdlZCwgTm92IDEzLCAyMDI0IGF0IDEw
OjA2Pz8/QU0gQ2FzZXkgU2NoYXVmbGVyIDxjYXNleUBzY2hhdWZsZXItY2EuY29tPiB3cm90ZToN
Cj4+PiANCj4+PiBPbiAxMS8xMi8yMDI0IDU6MzcgUE0sIFNvbmcgTGl1IHdyb3RlOg0KPj4gWy4u
Ll0NCj4+Pj4gQ291bGQgeW91IHByb3ZpZGUgbW9yZSBpbmZvcm1hdGlvbiBvbiB0aGUgZGVmaW5p
dGlvbiBvZiAibW9yZQ0KPj4+PiBjb25zaXN0ZW50IiBMU00gaW5mcmFzdHJ1Y3R1cmU/DQo+Pj4g
DQo+Pj4gV2UncmUgZG9pbmcgc2V2ZXJhbCB0aGluZ3MuIFRoZSBtYW5hZ2VtZW50IG9mIHNlY3Vy
aXR5IGJsb2JzDQo+Pj4gKGUuZy4gaW5vZGUtPmlfc2VjdXJpdHkpIGhhcyBiZWVuIG1vdmVkIG91
dCBvZiB0aGUgaW5kaXZpZHVhbA0KPj4+IG1vZHVsZXMgYW5kIGludG8gdGhlIGluZnJhc3RydWN0
dXJlLiBUaGUgdXNlIG9mIGEgdTMyIHNlY2lkIGlzDQo+Pj4gYmVpbmcgcmVwbGFjZWQgd2l0aCBh
IG1vcmUgZ2VuZXJhbCBsc21fcHJvcCBzdHJ1Y3R1cmUsIGV4Y2VwdA0KPj4+IHdoZXJlIG5ldHdv
cmtpbmcgY29kZSB3b24ndCBhbGxvdyBpdC4gQSBnb29kIGRlYWwgb2Ygd29yayBoYXMNCj4+PiBn
b25lIGludG8gbWFraW5nIHRoZSByZXR1cm4gdmFsdWVzIG9mIExTTSBob29rcyBjb25zaXN0ZW50
Lg0KPj4gDQo+PiBUaGFua3MgZm9yIHRoZSBpbmZvcm1hdGlvbi4gVW5pZnlpbmcgcGVyLW9iamVj
dCBtZW1vcnkgdXNhZ2Ugb2YNCj4+IGRpZmZlcmVudCBMU01zIG1ha2VzIHNlbnNlLiBIb3dldmVy
LCBJIGRvbid0IHRoaW5rIHdlIGFyZSBsaW1pdGluZw0KPj4gYW55IExTTSB0byBvbmx5IHVzZSBt
ZW1vcnkgZnJvbSB0aGUgbHNtX2Jsb2JzLiBUaGUgTFNNcyBzdGlsbA0KPj4gaGF2ZSB0aGUgZnJl
ZWRvbSB0byB1c2Ugb3RoZXIgbWVtb3J5IGFsbG9jYXRvcnMuIEJQRiBpbm9kZQ0KPj4gbG9jYWwg
c3RvcmFnZSwganVzdCBsaWtlIG90aGVyIEJQRiBtYXBzLCBpcyBhIHdheSB0byBtYW5hZ2UNCj4+
IG1lbW9yeS4gQlBGIExTTSBwcm9ncmFtcyBoYXZlIGZ1bGwgYWNjZXNzIHRvIEJQRiBtYXBzLiBT
bw0KPj4gSSBkb24ndCB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBzYXkgdGhpcyBCUEYgbWFwIGlz
IHVzZWQgYnkgdHJhY2luZywNCj4+IHNvIHdlIHNob3VsZCBub3QgYWxsb3cgTFNNIHRvIHVzZSBp
dC4NCj4+IA0KPj4gRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQo+IA0KPiBBcyBpbnZvbHZlZCBieXN0
YW5kZXJzLCBzb21lIHF1ZXN0aW9ucyBhbmQgdGhvdWdodHMgdGhhdCBtYXkgaGVscA0KPiBmdXJ0
aGVyIHRoZSBkaXNjdXNzaW9uLg0KPiANCj4gV2l0aCByZXNwZWN0IHRvIGlub2RlIHNwZWNpZmlj
IHN0b3JhZ2UsIHRoZSBjdXJyZW50bHkgYWNjZXB0ZWQgcGF0dGVybg0KPiBpbiB0aGUgTFNNIHdv
cmxkIGlzIHJvdWdobHkgYXMgZm9sbG93czoNCj4gDQo+IFRoZSBMU00gaW5pdGlhbGl6YXRpb24g
Y29kZSwgYXQgYm9vdCwgY29tcHV0ZXMgdGhlIHRvdGFsIGFtb3VudCBvZg0KPiBzdG9yYWdlIG5l
ZWRlZCBieSBhbGwgb2YgdGhlIExTTSdzIHRoYXQgYXJlIHJlcXVlc3RpbmcgaW5vZGUgc3BlY2lm
aWMNCj4gc3RvcmFnZS4gIEEgc2luZ2xlIHBvaW50ZXIgdG8gdGhhdCAnYmxvYicgb2Ygc3RvcmFn
ZSBpcyBpbmNsdWRlZCBpbg0KPiB0aGUgaW5vZGUgc3RydWN0dXJlLg0KPiANCj4gSW4gYW4gaW5j
bHVkZSBmaWxlLCBhbiBpbmxpbmUgZnVuY3Rpb24gc2ltaWxhciB0byB0aGUgZm9sbG93aW5nIGlz
DQo+IGRlY2xhcmVkLCB3aG9zZSBwdXJwb3NlIGlzIHRvIHJldHVybiB0aGUgbG9jYXRpb24gaW5z
aWRlIG9mIHRoZQ0KPiBhbGxvY2F0ZWQgc3RvcmFnZSBvciAnTFNNIGlub2RlIGJsb2InIHdoZXJl
IGEgcGFydGljdWxhciBMU00ncyBpbm9kZQ0KPiBzcGVjaWZpYyBkYXRhIHN0cnVjdHVyZSBpcyBs
b2NhdGVkOg0KPiANCj4gc3RhdGljIGlubGluZSBzdHJ1Y3QgdHNlbV9pbm9kZSAqdHNlbV9pbm9k
ZShzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiB7DQo+IHJldHVybiBpbm9kZS0+aV9zZWN1cml0eSAr
IHRzZW1fYmxvYl9zaXplcy5sYnNfaW5vZGU7DQo+IH0NCj4gDQo+IEluIGFuIExTTSdzIGltcGxl
bWVudGF0aW9uIGNvZGUsIHRoZSBmdW5jdGlvbiBnZXRzIHVzZWQgaW4gc29tZXRoaW5nDQo+IGxp
a2UgdGhlIGZvbGxvd2luZyBtYW5uZXI6DQo+IA0KPiBzdGF0aWMgaW50IHRzZW1faW5vZGVfYWxs
b2Nfc2VjdXJpdHkoc3RydWN0IGlub2RlICppbm9kZSkNCj4gew0KPiBzdHJ1Y3QgdHNlbV9pbm9k
ZSAqdHNpcCA9IHRzZW1faW5vZGUoaW5vZGUpOw0KPiANCj4gLyogRG8gc29tZXRoaW5nIHdpdGgg
dGhlIHN0cnVjdHVyZSBwb2ludGVkIHRvIGJ5IHRzaXAuICovDQo+IH0NCg0KWWVzLCBJIGFtIGZ1
bGx5IGF3YXJlIGhvdyBtb3N0IExTTXMgYWxsb2NhdGUgYW5kIHVzZSB0aGVzZSANCmlub2RlL3Rh
c2svZXRjLiBzdG9yYWdlLiANCg0KPiBDaHJpc3RpYW4gYXBwZWFycyB0byBoYXZlIGFscmVhZHkg
Y2hpbWVkIGluIGFuZCBpbmRpY2F0ZWQgdGhhdCB0aGVyZQ0KPiBpcyBubyBhcHBldGl0ZSB0byBh
ZGQgYW5vdGhlciBwb2ludGVyIG1lbWJlciB0byB0aGUgaW5vZGUgc3RydWN0dXJlLg0KDQpJZiBJ
IHVuZGVyc3RhbmQgQ2hyaXN0aWFuIGNvcnJlY3RseSwgaGlzIGNvbmNlcm4gY29tZXMgZnJvbSB0
aGUgDQpzaXplIG9mIGlub2RlLCBhbmQgdGh1cyB0aGUgaW1wYWN0IG9uIG1lbW9yeSBmb290cHJp
bnQgYW5kIENQVQ0KY2FjaGUgdXNhZ2Ugb2YgYWxsIHRoZSBpbm9kZSBpbiB0aGUgc3lzdGVtLiBX
aGlsZSB3ZSBnb3QgZWFzaWVyIA0KdGltZSBhZGRpbmcgYSBwb2ludGVyIHRvIG90aGVyIGRhdGEg
c3RydWN0dXJlcywgZm9yIGV4YW1wbGUgc29ja2V0LA0KSSBwZXJzb25hbGx5IGFja25vd2xlZGdl
IENocmlzdGlhbidzIGNvbmNlcm4gYW5kIEkgYW0gbW90aXZhdGVkIHRvIA0KbWFrZSBjaGFuZ2Vz
IHRvIHJlZHVjZSB0aGUgc2l6ZSBvZiBpbm9kZS4gDQoNCj4gU28sIGlmIHRoaXMgd2VyZSB0byBw
cm9jZWVkIGZvcndhcmQsIGlzIGl0IHByb3Bvc2VkIHRoYXQgdGhlcmUgd2lsbCBiZQ0KPiBhICdm
bGFnIGRheScgcmVxdWlyZW1lbnQgdG8gaGF2ZSBlYWNoIExTTSB0aGF0IHVzZXMgaW5vZGUgc3Bl
Y2lmaWMNCj4gc3RvcmFnZSBpbXBsZW1lbnQgYSBzZWN1cml0eV9pbm9kZV9hbGxvYygpIGV2ZW50
IGhhbmRsZXIgdGhhdCBjcmVhdGVzDQo+IGFuIExTTSBzcGVjaWZpYyBCUEYgbWFwIGtleS92YWx1
ZSBwYWlyIGZvciB0aGF0IGlub2RlPw0KPiANCj4gV2hpY2gsIGluIHR1cm4sIHdvdWxkIHJlcXVp
cmUgdGhhdCB0aGUgYWNjZXNzb3IgZnVuY3Rpb25zIGJlIGNvbnZlcnRlZA0KPiB0byB1c2UgYSBi
cGYga2V5IHJlcXVlc3QgdG8gcmV0dXJuIHRoZSBMU00gc3BlY2lmaWMgaW5mb3JtYXRpb24gZm9y
DQo+IHRoYXQgaW5vZGU/DQoNCkkgbmV2ZXIgdGhvdWdodCBhYm91dCBhc2tpbmcgb3RoZXIgTFNN
cyB0byBtYWtlIGFueSBjaGFuZ2VzLiANCkF0IHRoZSBtb21lbnQsIG5vbmUgb2YgdGhlIEJQRiBt
YXBzIGFyZSBhdmFpbGFibGUgdG8gbm9uZSBCUEYNCmNvZGUuIA0KDQo+IEEgZmxhZyBkYXkgZXZl
bnQgaXMgYWx3YXlzIHNvbWV3aGF0IG9mIGEgY29uY2VybiwgYnV0IHRoZSBsYXJnZXINCj4gY29u
Y2VybiBtYXkgYmUgdGhlIHN1YnN0aXR1dGlvbiBvZiBzaW1wbGUgcG9pbnRlciBhcml0aG1ldGlj
IGZvciBhDQo+IGJvZHkgb2YgbW9yZSBjb21wbGV4IGNvZGUuICBPbmUgd291bGQgYXNzdW1lIHdp
dGggc29tZXRoaW5nIGxpa2UgdGhpcywNCj4gdGhhdCB0aGVyZSBtYXkgYmUgYSBuZWVkIGZvciBh
IHNoYWtlLW91dCBwZXJpb2QgdG8gZGV0ZXJtaW5lIHdoYXQgdHlwZQ0KPiBvZiBwb3RlbnRpYWwg
cmVncmVzc2lvbnMgdGhlIG1vcmUgY29tcGxleCBpbXBsZW1lbnRhdGlvbiBtYXkgZ2VuZXJhdGUs
DQo+IHdpdGggcmVncmVzc2lvbnMgaW4gc2VjdXJpdHkgc2Vuc2l0aXZlIGNvZGUgYWx3YXlzIGEg
Y29uY2Vybi4NCj4gDQo+IEluIGEgbGFyZ2VyIGNvbnRleHQuICBHaXZlbiB0aGF0IHRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIHdvcmtzIG9uDQo+IHNpbXBsZSBwb2ludGVyIGFyaXRobWV0aWMg
b3ZlciBhIGNvbW1vbiBibG9jayBvZiBzdG9yYWdlLCB0aGVyZSBpcyBub3QNCj4gbXVjaCBvZiBh
IHNhZmV0eSBndWFyYW50ZWUgdGhhdCBvbmUgTFNNIGNvdWxkbid0IGludGVyZmVyZSB3aXRoIHRo
ZQ0KPiBpbm9kZSBzdG9yYWdlIG9mIGFub3RoZXIgTFNNLiAgSG93ZXZlciwgdXNpbmcgYSBnZW5l
cmljIEJQRiBjb25zdHJ1Y3QNCj4gc3VjaCBhcyBhIG1hcCwgd291bGQgcHJlc3VtYWJseSBvcGVu
IHRoZSBsZXZlbCBvZiBpbmZsdWVuY2Ugb3ZlciBMU00NCj4gc3BlY2lmaWMgaW5vZGUgc3RvcmFn
ZSB0byBhIG11Y2ggbGFyZ2VyIGF1ZGllbmNlLCBwcmVzdW1hYmx5IGFueSBCUEYNCj4gcHJvZ3Jh
bSB0aGF0IHdvdWxkIGJlIGxvYWRlZC4NCg0KVG8gYmUgaG9uZXN0LCBJIHRoaW5rIGJwZiBtYXBz
IHByb3ZpZGUgbXVjaCBiZXR0ZXIgZGF0YSBpc29sYXRpb24gDQp0aGFuIGEgY29tbW9uIGJsb2Nr
IG9mIHN0b3JhZ2UuIFRoZSBjcmVhdG9yIG9mIGVhY2ggYnBmIG1hcCBoYXMgDQpfZnVsbCBjb250
cm9sXyB3aG8gY2FuIGFjY2VzcyB0aGUgbWFwLiBUaGUgb25seSBleGNlcHRpb24gaXMgd2l0aA0K
Q0FQX1NZU19BRE1JTiwgd2hlcmUgdGhlIHJvb3QgdXNlciBjYW4gYWNjZXNzIGFsbCBicGYgbWFw
cyBpbiB0aGUgDQpzeXN0ZW0uIEkgZG9uJ3QgdGhpbmsgdGhpcyBoYXMgYW55IHNlY3VyaXR5IGNv
bmNlcm4gb3ZlciB0aGUgY29tbW9uDQpibG9jayBvZiBzdG9yYWdlLCBhcyB0aGUgcm9vdCB1c2Vy
IGNhbiBlYXNpbHkgcHJvYmUgYW55IGRhdGEgaW4gdGhlIA0KY29tbW9uIGJsb2NrIG9mIHN0b3Jh
Z2UgdmlhIC9wcm9jL2tjb3JlLiANCg0KPiANCj4gVGhlIExTTSBpbm9kZSBpbmZvcm1hdGlvbiBp
cyBvYnZpb3VzbHkgc2VjdXJpdHkgc2Vuc2l0aXZlLCB3aGljaCBJDQo+IHByZXN1bWUgd291bGQg
YmUgYmUgdGhlIG1vdGl2YXRpb24gZm9yIENhc2V5J3MgY29uY2VybiB0aGF0IGEgJ21pc3Rha2UN
Cj4gYnkgYSBCUEYgcHJvZ3JhbW1lciBjb3VsZCBjYXVzZSB0aGUgd2hvbGUgc3lzdGVtIHRvIGJs
b3cgdXAnLCB3aGljaCBpbg0KPiBmdWxsIGRpc2Nsb3N1cmUgaXMgb25seSBhIHJvdWdoIGFwcHJv
eGltYXRpb24gb2YgaGlzIHN0YXRlbWVudC4NCj4gDQo+IFdlIG9idmlvdXNseSBjYW4ndCBzcGVh
ayBkaXJlY3RseSB0byBDYXNleSdzIGNvbmNlcm5zLiAgQ2FzZXksIGFueQ0KPiBzcGVjaWZpYyB0
ZWNobmljYWwgY29tbWVudHMgb24gdGhlIGNoYWxsZW5nZXMgb2YgdXNpbmcgYSBjb21tb24gaW5v
ZGUNCj4gc3BlY2lmaWMgc3RvcmFnZSBhcmNoaXRlY3R1cmU/DQo+IA0KPiBTb25nLCBGV0lXIGdv
aW5nIGZvcndhcmQuICBJIGRvbid0IGtub3cgaG93IGNsb3NlbHkgeW91IGZvbGxvdyBMU00NCj4g
ZGV2ZWxvcG1lbnQsIGJ1dCB3ZSBiZWxpZXZlIGFuIHVuYmlhc2VkIG9ic2VydmVyIHdvdWxkIGNv
bmNsdWRlIHRoYXQNCj4gdGhlcmUgaXMgc29tZSBkZWdyZWUgb2YgcmV0aWNlbmNlIGFib3V0IEJQ
RidzIGludm9sdmVtZW50IHdpdGggdGhlIExTTQ0KPiBpbmZyYXN0cnVjdHVyZSBieSBzb21lIG9m
IHRoZSBjb3JlIExTTSBtYWludGFpbmVycywgdGhhdCBpbiB0dXJuIG1ha2VzDQo+IHRoZXNlIHR5
cGVzIG9mIGNvbnZlcnNhdGlvbnMgdGVjaG5pY2FsbHkgc2Vuc2l0aXZlLg0KDQpJIHRoaW5rIEkg
aW5kZWVkIGdvdCBtdWNoIG1vcmUgcHVzaCBiYWNrIHRoYW4gSSB3b3VsZCBpbWFnaW5lLiANCkhv
d2V2ZXIsIGFzIGFsd2F5cywgSSB2YWx1ZSBldmVyeW9uZSdzIHBlcnNwZWN0aXZlIGFuZCBJIGFt
DQp3aWxsaW5nIG1ha2UgcmVhc29uYWJsZSBjaGFuZ2VzIHRvIGFkZHJlc3MgdmFsaWQgY29uY2Vy
bnMuIA0KDQpUaGFua3MsDQpTb25nDQoNCg==


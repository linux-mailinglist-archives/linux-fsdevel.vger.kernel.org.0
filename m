Return-Path: <linux-fsdevel+bounces-37699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B069F5DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 05:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2337716A901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 04:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0A14D6ED;
	Wed, 18 Dec 2024 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="n15ReF1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774F3597A;
	Wed, 18 Dec 2024 04:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734496735; cv=fail; b=Uk0QPr7pVa9BarpELpV82djGEupNzaPuKMbeO3URVlcuMidyadq0ZKPvIlR080YqK2Lh11IZOw5I5kALsJWk048xlTD/nNLAq/l1UggMOzTyANPhvIjmqMIIxMF8rYjcJR3z1s18H80oSKJ2eW/7rfu1CI4Tr9YZCHEcV1yHVjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734496735; c=relaxed/simple;
	bh=ZFRDfFCL+/bK0fIn3UWHrEVpvaAE1evrSo0Ty8dq44E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tfkds34EtiJOWonbqgMf9GlCKmUbdKgHAK4yaoEhyC6alsHa9EqlC72QCG53I2mZmh3c9rhrr/yq4ehnvaxXpbsTP6bQ+ag901ZGqxnDPYV0nHxqyzO5DaJySHNAfV7/vNK3jtqkRP0Whl3Yv56W9qgJu6Z+yBCs5jyrZQK23ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=n15ReF1j; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI3mBQF024863;
	Tue, 17 Dec 2024 20:38:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=ZFRDfFCL+/bK0fIn3UWHrEVpvaAE1evrSo0Ty8dq44E=; b=
	n15ReF1j6brxBGQb4b5m9Ci247UQltDzYC1eBTglOlRIikYAsNcoEZkWC8D+kpq+
	8chQfS4EigTTYHd0oxWAxrGgmWnKC8/0ogVA+wgnaL7LuixpV/d15CYdgre4QQ1n
	CY5e0bkDBN5elhJ9OI6kznTcPKlJMFAWtb4TIwHBXR7NNokNZ8sBFwbjpA/N7Mm2
	HwAzE8hR1xKWsmSygV4TxCZVVdxu51TGBYu0db34YBMPYOApdcMOEj85G/aroopw
	UIDIz8p9+JVLlye465nN2vjiDOJsR8uEKCtaHamvkx65l2wFH/l4iked2J/HJz/X
	58z7r70Is/Y5eQSDK365WA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43kp2r8b0k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 20:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7kX9EB8pz2RKY9doT0VYmQB8MzpuL1Z+rjUlbgQCPYM2/Ax66Pg54hgV1zlmCeKdUc1jMzN+Az2fqLPYO+s65ETe4f/zzv/gMWhUpzAPHpFJx24eNkrzBtp0azTW2orOH/G95RMHV2gXI3eLY4jGa6+qBN0PPuNa0HFaoGBEav6jMM0jK8Bbb9v8PxJ2bkIYXOCbvBxKCKY5/VxBGRQgWPPqh9K4fk8rPCgR6qRf9OqCkrcXMzyuVFnBiGiLwXtMfrvm+NJXMHoOhDyouf81SJ4bjlxdwzaDS2FocMbE5NBONiTNny4GiePr2JyP/zoI02BWL8Xz8xdDO7dGbdELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFRDfFCL+/bK0fIn3UWHrEVpvaAE1evrSo0Ty8dq44E=;
 b=wMf4OqqJL1S4RiHF5TNJalcOEOSTanDswYvhdE/yhP7S1RlqQSK1gPWnqxE8UwDjvt8uR2iW3Ff0uz45FNCCPKueEQ1Iv8xoHy84APkM4etudJkP7+lOEF7mhF5NYB5B4q7LEWjNWr8Si/auy3Yh4XYHgxsZxzzBwOww58tgonD1epMjnPtYzEbmfvuCAvbJUiDqpZgjgvH33vN2YiUnNMF+eJfyLKCrdXNvUun8ftEr0wGJ8qDKcvvmz1qqSQ+yliaMaH/hI2V/iNFoFehcxfFJQb/+Ns/H699+u8c3rvOVqNJqinIkbZ5PS4OowTfAA8r9eAGwc72EevXwYh72Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH0PR15MB5986.namprd15.prod.outlook.com (2603:10b6:610:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 04:38:49 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 04:38:49 +0000
From: Song Liu <songliubraving@meta.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Song Liu <songliubraving@meta.com>,
        Alexei Starovoitov
	<alexei.starovoitov@gmail.com>,
        Song Liu <song@kernel.org>, bpf
	<bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        LSM List
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin
 KaFai Lau <martin.lau@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        KP Singh
	<kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Liam
 Wisehart <liamwisehart@meta.com>,
        Shankaran Gnanashanmugam
	<shankaran@meta.com>
Subject: Re: [PATCH v4 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Topic: [PATCH v4 bpf-next 4/6] bpf: fs/xattr: Add BPF kfuncs to set and
 remove xattrs
Thread-Index: AQHbUE5vyorksDdnSkCocDtARlbXhLLqpv4AgAAaOgCAAAIvgIAAqWUA
Date: Wed, 18 Dec 2024 04:38:49 +0000
Message-ID: <E05F5DE1-A4A8-4727-837C-808E2DA27BB2@fb.com>
References: <20241217063821.482857-1-song@kernel.org>
 <20241217063821.482857-5-song@kernel.org>
 <CAADnVQKnscWKZHbWt9cgTm7NZ4ZWQkHQ+41Hz=NWoEhUjCAbaw@mail.gmail.com>
 <7A7A74A6-ED23-455E-A963-8FE7E250C9AA@fb.com>
 <CAP01T76SVQ=TJgkTgkvSLY3DFTDUswj_aypAWmQhwKWFBEk_yw@mail.gmail.com>
In-Reply-To:
 <CAP01T76SVQ=TJgkTgkvSLY3DFTDUswj_aypAWmQhwKWFBEk_yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH0PR15MB5986:EE_
x-ms-office365-filtering-correlation-id: 16ffe11e-8974-42d5-3c0a-08dd1f1dddca
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1p6L2l1SVIrdkQ2Szg1ZW9vQ1hHVUlkeGQrVnhzSWZBQlJvejk2QnRJaTFz?=
 =?utf-8?B?dHFlWDArQWVnNHg1S1hzL3BGMEJQemZjb1NTaGhoM0djTmpaTmROOFozOGdT?=
 =?utf-8?B?UkhBQ2JjUVVxRlFTWk4rL2xybFlkelJtejFWeW15NE82K1BxMkRwenVBZk1O?=
 =?utf-8?B?UmxiRVpIYiszcy9JeFVXeDV6R2NRNm94cStHYWNNY1JTMmROdWJRS1BUMk9k?=
 =?utf-8?B?ZGlZaXZtL2psTDNzY1dPdW5DYUVpQ3BKZ3pMVithVjhoVzhNMkZQdzJrdlVB?=
 =?utf-8?B?d1l5WUlXV1h3dWF4VURDR24vMnRuOXFFTFgrNWZleS8rVmpoYVcvWktKbXQr?=
 =?utf-8?B?aVAyaGQrblZZTmRINzZGYzBmUFZlZzM4QjdPQmZEYXBUdktmZlRzeEVnMFJi?=
 =?utf-8?B?cXlWQ0pTSHF3YWpRMGk5Qk4vNTVKcUt4bXpiZEpvWWJhUVp3ZkNzem5BbnU4?=
 =?utf-8?B?NFNCV2dHQThySnFnSmQrdzdPY2x5UFl3dU9OSkx6bGRuMmV2SzdpazIzSTkx?=
 =?utf-8?B?Wm94aGtINkIxQXRkYTRodHN0cjd5ZDg2VDU5OU04THNTQm1KR3JVVlZma3ZW?=
 =?utf-8?B?b0tITy9JYzUyUkNTenk2Mm5kTzdzWDVkKzVaR3dnOG44ei8zaXQ0emZBb2NT?=
 =?utf-8?B?SXZjcUJIRUtpTEhNWUxQcjJGQlRxUHFkMk5ZOUwzTjQrV3ExNHdzWkEvWDBK?=
 =?utf-8?B?WURaalpxbzBlZkFyVDRJN0ptanhGbkZ6WXIrcEtBUWZ4a1R6N2p0Rjl3Sk1k?=
 =?utf-8?B?VGlsQ0Q2SFFOSmhuT1hLZTE2eVNXRWNQNEQzei9aczJzeG5QZytKZTd1L3Bv?=
 =?utf-8?B?blhpNU05NjJGSUY4NGZDMW5qcmljaUJoRkVOTDBRVGx0U2lVTTF2VXo1STZT?=
 =?utf-8?B?NVZnZGhLa0lJOThGSEZlbE5aQVVPbDRWamIwME43TVVxU3FGSXA1VDFlME1W?=
 =?utf-8?B?cGl6c0JMeERjcWREdFpEUm5lWjN6cUJLb2NNREVJK2FSZy9DTXdiaHQ4U3Nt?=
 =?utf-8?B?T1YxeFZOb290T0ZTbnZlQVRyc1FlQlFNRlJzOWdpUkhJRlVIWFRWampWdTVo?=
 =?utf-8?B?Y1poR092VHBsTkhMeWhRaUZ6azBLQm85aElvQnorZ2x6bG52S2ZmUGhERmM3?=
 =?utf-8?B?bzZnKzFyU3FtZEJRM0puZFBEdFlBTnJ1V0gydmtOeVd1bTBWMCtYYUJiQ0ha?=
 =?utf-8?B?NVN4YTRVYm1oM0kxVnQ2YWM2KzdMV2JFRGxiK3B1Nzg4ZFBkbk05a1JzU05k?=
 =?utf-8?B?RWo0VVpMK1RzSmRSajF1bmYyZCtnOEtkdmZTSjNXZVJGZkE5Q1RoZE14RTJ5?=
 =?utf-8?B?Mk92RzRuY2pVMjFzMytIVklsNFZzQVpybUpiV0VjdUt1OGlDOFpGS1dneEM4?=
 =?utf-8?B?RmpLcEtPa0tOM09SOHpSU3RzNHVhL3BHZFhGM28yTUk2NW4xbjFBUlZEWjZ3?=
 =?utf-8?B?MXBCNzJNNS92TEt2ZFJBaEpDVW83djFGdDJJSzlmOUZsRXlQaGdIL1E3V1Bp?=
 =?utf-8?B?N0JIbDJlM1RLSk96dUtjcGxNeUJDTHBtVjlzTksxdC9YdGxiOTdpMDA4cVZz?=
 =?utf-8?B?SkZzZklvUCtyUVBvcGNCcHA3Y3RXZzNhOWpHTHdwdGcxaUhiaUZCRzJ2ZHNS?=
 =?utf-8?B?eFA3VUNkc1JsUmdGY3ZkdVBWWXh5aDhscGU2REx2TEZkL1hVdlZKQlBuZ2g2?=
 =?utf-8?B?UUd6ckpickgzUUhCclJmcE05emNJVTM4YjhLRHFrOGsrT0lOaTlqYlFCNU9j?=
 =?utf-8?B?MXFwand6TzdmUElWb2hESTN1WmJId2FtSDl0ZXg3TGNaaWJ3V1Y2R0Y3bklN?=
 =?utf-8?B?clFtcTVQM25sWU1ORi9rMVQ1QVRuVWlPK1kxNWhLZnZUYjQ5dlNEYlgxdzJH?=
 =?utf-8?B?eERVcTVDem13bnhIbHF5V1l1ZVNXQTJaeUNFaHBaLzU4Zk5KZEF4QmVHOG4v?=
 =?utf-8?Q?iy3pFTEgfLyRMZN6oVDKqv4iAJC89sdS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTlmUDFsSGlBMzhMbUhJMkxpa2FlSmE3WlZMZEVkM1VTOTUzZXNySE1EZDlB?=
 =?utf-8?B?R1QzWGZFTUJtaDMxL2pxallNdE02aFkvR2NERzJJRlJkdFExTWl3YkFzTTF5?=
 =?utf-8?B?MUlMVXBrclcwbkoxUmFjSmNlVDZmWi8zb1U2Y1F2MWZkNEpLc3hLZ0hldnBC?=
 =?utf-8?B?SG9PMGRiaGFRbFZuNmxIRXYvV29DbFV2SnpxaXI4M3hTTCtmYWt6RkZXc1BS?=
 =?utf-8?B?a09kNTBlZVNZVGluaW5TZVY5UFdqbmNSV1JWMWNNRm1BTGpqN3NtMVM1eFNC?=
 =?utf-8?B?ZnhlMVg3K2JvZkNnZkdvNkdjQXFXVEsza1ZhT3lqb1pnZzNJdVd4L1RQN3p1?=
 =?utf-8?B?blVZT0RseGZrZnZrL3pmTnFnQUw0aENIaTJSOCtReUhxcUJvdkhIaDdEYXZz?=
 =?utf-8?B?QVB4Zk0xb0RzQzk0QzMreEx0YUs3THkrN2FiVXlQQXk3aFQzVlF6czE0T2xt?=
 =?utf-8?B?MFhtU2xaaU5VcXBvMWQzVWZFc3RuNGFaRTlqSE9PZW5uR3hPNlV1R05GM1ly?=
 =?utf-8?B?dktlTkk4T2NxNjBBekJqbzRob3Bwelhwb3BJaG9vc3lJZlE3TnAxY1lqK3U1?=
 =?utf-8?B?SUZ5bmFLY0FOWGlkUlRESG5lUDFYeU9wRjI2S1crZnRIdzJsSkt1aWptMkRV?=
 =?utf-8?B?dTFKa3BheFhCTXVCT0E0K1E0eTBEVGU2TUl4N0N6WG10aWExOXU3UnhnazNh?=
 =?utf-8?B?bXo2Zk5lRy9LeW50N3Vpa1NhWlgycWlPTk5BZ3Ixd2pCMWVFN3N4MzN0OVg2?=
 =?utf-8?B?VlkrWnhFVi90WmR6WW1DWkVSdExVWWtwZnVPUDQ3bUxsaXBFR3VYMEpieTFv?=
 =?utf-8?B?ZWpQQlkrRnF0K29ibm80SzVYRVN0R2g0WHRwV0poS2NEY2N4OGZZVmlMM1Zq?=
 =?utf-8?B?RCtwMXVyTzJ5OUYxdGg4aG5PQWNkYVJ2TXd6QlVpVlk4RkFBazJpclBFWk5L?=
 =?utf-8?B?V3FQcHRZVEk5NGFhbGs1UE5lakZmRkcrbGxSQjQ5VHdValVMbThGYjBjTFp5?=
 =?utf-8?B?T2I4UHlVcTBIeGluVmVsWmpqWW9hMUhsSzR0NHpBQWxJK09Ma3l6eG9yQVVt?=
 =?utf-8?B?ckZHcG9KYkpIclpNblp6Z0sya0h3Qmt1QnZCOHN0NFVFQmV3UTZjb253Y0cr?=
 =?utf-8?B?OStNMjFJNEJnNk5rR0c4dmhFVXBoOEpYemVzZ01BK2tocmt5a1ZKbTl6bUJZ?=
 =?utf-8?B?YU10VEdKK3YvTDFGY2o3Zy9wR2tlUjFpMHpCWDFuT2xHa2RVVjdZc3Nya3hI?=
 =?utf-8?B?MVFFNE5IT2t6REIyR0V6Z01HL25nU2IzNDRtcTk4bFhYdGJQeUwwMjNmTjBO?=
 =?utf-8?B?bHNhc1cwcWFqY3kwYjFMU1E0NUd6VjJZMXlqRE1kcHFaZWxldWIxZnI1RXZn?=
 =?utf-8?B?MUR1cjY1eWZ1c0JTbjllYnh4SEVkajh6NlZiRlIyTE1pNVNGTXhLdzhGMDJj?=
 =?utf-8?B?V0pZNUhweHNKaDhpWGpodVBkMDBiOHZnM050STNnRGFXaDFNL25paVlJMzBV?=
 =?utf-8?B?c2JPSVRHeHpXbGNUb3VwdGgvL3k3Z0dwWDR5NS9rYTJuL2VieXVtN0JXV1VY?=
 =?utf-8?B?ZTNBWWl6RG8zbHpXZERFMHVvUDdPTlhJY25OeFpCR2NOSG5UWHlVUHExcFQr?=
 =?utf-8?B?R2JtQnJkcGtERTl4NGJNaW5IenkyYVNsZXFJSWc1OFBvUG5vc1kxM1MyV3Er?=
 =?utf-8?B?RzV1UUdHOWlLV3V2ZGNTZzJoZ3lMQjlDUzdWWFk2VEhhYkM5WEFMV1FqWElW?=
 =?utf-8?B?Z0N4UFdVSU1XZjRERmpZTzM4d3BYWElhMmlMZVFUQWl4Nmg3NENYdnNyNXgw?=
 =?utf-8?B?TGdrR1l5dU14MXJySmVIbDVGQ3NxOE14dlNSeURueGpzSmptaXM4bk5qVjRk?=
 =?utf-8?B?RFNXbDhFcWJKU0VjNnBEb0gwYnl3Y3JRT0VnaUEzREFCMTk5SVBOYi9xYnRM?=
 =?utf-8?B?dVpJbkV1UWIwUmJyQzNZRWVWVEd0UEhSQlRPVTVkZ2xwN0dYa2VUUGZhRUQ3?=
 =?utf-8?B?NkJ3MjM5RkhRbkx4UDMwVVpmZzlGNHVxZ3huSnk4RDNEdjBWcTFHTlRudU80?=
 =?utf-8?B?akdiRk9MSFhhcCtFR0VXWk03TVczTWZrTnlQV3pLdFNmcUg1aUkrb2kxVWFH?=
 =?utf-8?B?em0zVSs0cExPV0lBYWVBWWtncmZHMks5UXU5eXVJT01JbWFOUk1RbTJSVG1I?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05F41F166779D1478684469C5B39F2FF@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ffe11e-8974-42d5-3c0a-08dd1f1dddca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 04:38:49.1985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kJeoqbBb1C5wZafpltNn9KfCzBsxv9S/GLFub8J2yQ9mDd5aUTHaKv8aRclUpm5qMhyCuLX6MANG5iYYUocsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB5986
X-Proofpoint-ORIG-GUID: f76r63uNYmSDlZMBDsEr0WY06hgyl59r
X-Proofpoint-GUID: f76r63uNYmSDlZMBDsEr0WY06hgyl59r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gRGVjIDE3LCAyMDI0LCBhdCAxMDozMuKAr0FNLCBLdW1hciBLYXJ0aWtleWEgRHdp
dmVkaSA8bWVteG9yQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIDE3IERlYyAyMDI0
IGF0IDE5OjI1LCBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAbWV0YS5jb20+IHdyb3RlOg0KPj4g
DQo+PiBIaSBBbGV4ZWksDQo+PiANCj4+IFRoYW5rcyBmb3IgdGhlIHJldmlldyENCj4+IA0KPj4+
IE9uIERlYyAxNywgMjAyNCwgYXQgODo1MOKAr0FNLCBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFsZXhl
aS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIE1vbiwgRGVjIDE2
LCAyMDI0IGF0IDEwOjM44oCvUE0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pj4+IA0KPj4+PiBBZGQgdGhlIGZvbGxvd2luZyBrZnVuY3MgdG8gc2V0IGFuZCByZW1vdmUgeGF0
dHJzIGZyb20gQlBGIHByb2dyYW1zOg0KPj4+PiANCj4+Pj4gYnBmX3NldF9kZW50cnlfeGF0dHIN
Cj4+Pj4gYnBmX3JlbW92ZV9kZW50cnlfeGF0dHINCj4+Pj4gYnBmX3NldF9kZW50cnlfeGF0dHJf
bG9ja2VkDQo+Pj4+IGJwZl9yZW1vdmVfZGVudHJ5X3hhdHRyX2xvY2tlZA0KPj4+PiANCj4+Pj4g
VGhlIF9sb2NrZWQgdmVyc2lvbiBvZiB0aGVzZSBrZnVuY3MgYXJlIGNhbGxlZCBmcm9tIGhvb2tz
IHdoZXJlDQo+Pj4+IGRlbnRyeS0+ZF9pbm9kZSBpcyBhbHJlYWR5IGxvY2tlZC4NCj4+PiANCj4+
PiAuLi4NCj4+PiANCj4+Pj4gKyAqDQo+Pj4+ICsgKiBTZXR0aW5nIGFuZCByZW1vdmluZyB4YXR0
ciByZXF1aXJlcyBleGNsdXNpdmUgbG9jayBvbiBkZW50cnktPmRfaW5vZGUuDQo+Pj4+ICsgKiBT
b21lIGhvb2tzIGFscmVhZHkgbG9ja2VkIGRfaW5vZGUsIHdoaWxlIHNvbWUgaG9va3MgaGF2ZSBu
b3QgbG9ja2VkDQo+Pj4+ICsgKiBkX2lub2RlLiBUaGVyZWZvcmUsIHdlIG5lZWQgZGlmZmVyZW50
IGtmdW5jcyBmb3IgZGlmZmVyZW50IGhvb2tzLg0KPj4+PiArICogU3BlY2lmaWNhbGx5LCBob29r
cyBpbiB0aGUgZm9sbG93aW5nIGxpc3QgKGRfaW5vZGVfbG9ja2VkX2hvb2tzKQ0KPj4+PiArICog
c2hvdWxkIGNhbGwgYnBmX1tzZXR8cmVtb3ZlXV9kZW50cnlfeGF0dHJfbG9ja2VkOyB3aGlsZSBv
dGhlciBob29rcw0KPj4+PiArICogc2hvdWxkIGNhbGwgYnBmX1tzZXR8cmVtb3ZlXV9kZW50cnlf
eGF0dHIuDQo+Pj4+ICsgKi8NCj4+PiANCj4+PiB0aGUgaW5vZGUgbG9ja2luZyBydWxlcyBtaWdo
dCBjaGFuZ2UsIHNvIGxldCdzIGhpZGUgdGhpcw0KPj4+IGltcGxlbWVudGF0aW9uIGRldGFpbCBm
cm9tIHRoZSBicGYgcHJvZ3MgYnkgbWFraW5nIGtmdW5jIHBvbHltb3JwaGljLg0KPj4+IA0KPj4+
IFRvIHN0cnVjdCBicGZfcHJvZ19hdXggYWRkOg0KPj4+IGJvb2wgdXNlX2xvY2tlZF9rZnVuYzox
Ow0KPj4+IGFuZCBzZXQgaXQgaW4gYnBmX2NoZWNrX2F0dGFjaF90YXJnZXQoKSBpZiBpdCdzIGF0
dGFjaGluZw0KPj4+IHRvIG9uZSBvZiBkX2lub2RlX2xvY2tlZF9ob29rcw0KPj4+IA0KPj4+IFRo
ZW4gaW4gZml4dXBfa2Z1bmNfY2FsbCgpIGNhbGwgc29tZSBoZWxwZXIgdGhhdA0KPj4+IGlmIChw
cm9nLT5hdXgtPnVzZV9sb2NrZWRfa2Z1bmMgJiYNCj4+PiAgIGluc24tPmltbSA9PSBzcGVjaWFs
X2tmdW5jX2xpc3RbS0ZfYnBmX3JlbW92ZV9kZW50cnlfeGF0dHJdKQ0KPj4+ICAgIGluc24tPmlt
bSA9IHNwZWNpYWxfa2Z1bmNfbGlzdFtLRl9icGZfcmVtb3ZlX2RlbnRyeV94YXR0cl9sb2NrZWRd
Ow0KPj4+IA0KPj4+IFRoZSBwcm9ncyB3aWxsIGJlIHNpbXBsZXIgYW5kIHdpbGwgc3VmZmVyIGxl
c3MgY2h1cm4NCj4+PiB3aGVuIHRoZSBrZXJuZWwgc2lkZSBjaGFuZ2VzLg0KPj4gDQo+PiBJIHdh
cyB0aGlua2luZyBhYm91dCBzb21ldGhpbmcgaW4gc2ltaWxhciBkaXJlY3Rpb24uDQo+PiANCj4+
IElmIHdlIGRvIHRoaXMsIHNoYWxsIHdlIHNvbWVob3cgaGlkZSB0aGUgX2xvY2tlZCB2ZXJzaW9u
IG9mIHRoZQ0KPj4ga2Z1bmNzLCBzbyB0aGF0IHRoZSB1c2VyIGNhbm5vdCB1c2UgaXQ/IElmIHNv
LCB3aGF0J3MgdGhlIGJlc3QNCj4+IHdheSB0byBkbyBpdD8NCj4gDQo+IEp1c3QgZG9uJ3QgYWRk
IEJURl9JRF9GTEFHUyBlbnRyaWVzIGZvciB0aGVtLg0KPiBZb3UnZCBhbHNvIG5lZWQgdG8gbWFr
ZSBhbiBleHRyYSBjYWxsIHRvIGFkZF9rZnVuY19jYWxsIHRvIGFkZCBpdHMNCj4gZGV0YWlscyBi
ZWZvcmUgeW91IGNhbiBkbyB0aGUgZml4dXAuDQo+IFRoYXQgYWxsb3dzIGZpbmRfa2Z1bmNfZGVz
YyB0byB3b3JrLg0KPiBJIGRpZCBzb21ldGhpbmcgc2ltaWxhciBpbiBlYXJsaWVyIHZlcnNpb25z
IG9mIHJlc2lsaWVudCBsb2Nrcy4NCj4gSW4gYWRkX2tmdW5jX2NhbGwncyBlbmQgKGluc3RlYWQg
b2YgZGlyZWN0bHkgcmV0dXJuaW5nKToNCj4gZnVuY19pZCA9IGdldF9zaGFkb3dfa2Z1bmNfaWQo
ZnVuY19pZCwgb2Zmc2V0KTsNCj4gaWYgKCFmdW5jX2lkKQ0KPiAgcmV0dXJuIGVycjsNCj4gcmV0
dXJuIGFkZF9rZnVuY19jYWxsKGVudiwgZnVuY19pZCwgb2Zmc2V0KTsNCj4gDQo+IFRoZW4gY2hl
Y2sgaW4gZml4dXBfa2Z1bmNfY2FsbCB0byBmaW5kIHNoYWRvdyBrZnVuYyBpZCBhbmQgc3Vic3Rp
dHV0ZSBpbW0uDQo+IENhbiB1c2Ugc29tZSBvdGhlciBuYW1pbmcgaW5zdGVhZCBvZiAic2hhZG93
Ii4NCj4gUHJvYmFibHkgbmVlZCB0byB0YWtlIGEgcHJvZyBwb2ludGVyIHRvIG1ha2UgYSBkZWNp
c2lvbiB0byBmaW5kIHRoZQ0KPiB1bmRlcmx5aW5nIGtmdW5jIGlkIGluIHlvdXIgY2FzZS4NCg0K
VGhhbmtzIGZvciB0aGUgaGludHMhIFRoZXkgaGVscGVkIGEgbG90LiANCg0KSSBlbmRlZCB1cCBk
b2luZyB0aGlzIHdpdGggYSBzbGlnaHRseSBkaWZmZXJlbnQgbG9naWMsIHdoaWNoIEkgDQp0aGlu
ayBpcyBjbGVhbmVyLiBJIHdpbGwgc2VuZCB2NSBzaG9ydGx5LiANCg0KU29uZw0KDQoNCg==


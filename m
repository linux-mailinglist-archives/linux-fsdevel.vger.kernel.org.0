Return-Path: <linux-fsdevel+bounces-41480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE09A2FAD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA40A3A33F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD626460B;
	Mon, 10 Feb 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="vGvGB/Wy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282D264603
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220049; cv=fail; b=MQGp8QbHpFlSh89ymkrRXumBrnk7P65rngXTXbX/fQq929JkZjW8GlTRvXeyUsIWTJLJ5wgva/UBksbzMVgaHjJxqYDxn2KuEycFbeluGMaYQgsfnbQrNXsHpWbwh7fcjovnV4Y5uC4ydofE5wNHkUcyAIjt1YS7XYQGi2oCpBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220049; c=relaxed/simple;
	bh=AYkYL3QYOkbJZiaucnJseom/Wef8NhQJWCAcYYPwsA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=is/nYzg9Jxp557NTCyQtstk5tWPlQ1VpES7/vtPd0K8xAcOZNOQqTyYkNerHfrBvqcef8kJlHsZX2Hy+En47LEvkVnA6+QZSgakF4/5AyrZulecKZoXfavjiPGmCT+qZfKSErTGylHQ2DwLHgTEMEWD5F2+W5thSZQfM9IJqB1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=vGvGB/Wy; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175]) by mx-outbound14-88.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 10 Feb 2025 20:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfpMUeZRM+nQyiOsqCXvYg8qdG0mRxDq/RE8BEv7tE0SjyrIVIp5md1m0QRtlNqREYd/KsIdYAzVvvLE8dlDz3BHkIL8h+LF3VoxISFXrBzRgyGfN5x+slOf9UBS5VHfxyDpSkOGXcbnzndd2gsOY8UNDKU1gCUlxbS+xxC/eUnyJMV9ztmNeK/JhzZ/8VpVzhi5ah0JHeUtByNq0Cnw9KnwdeZT1aMHeXYdwsUKa6VqfvvTCVUyw4HnQb4Xzymdliiqjy0/nEX6AwpYIW2l5dksw/FSGrXJX47Hkm5m3ng1Lo8+u6HUyBqktPcZU+VMWoImN16Ly43rVWw1OuL+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYkYL3QYOkbJZiaucnJseom/Wef8NhQJWCAcYYPwsA0=;
 b=DFNvrop1jkUxQhuJAI/u5CWX2GDnmshs2eBBnfWgbI/tXLCK8dOTztZ+FhKY25TwmkSUw92LrjMlqZUbHodRjP4m9GK080Bi+GSofhmHvs357dKhVgmm2kzs6IHV3kaBRxrLFi4LJsDauyjkCzuzqxJdAGyB2CZNB6+/UgcmVl5b+F/HPeJ+KU9RY8Vz3SFsKhxy/+3Ci4jBh2PmCc/qOS4M58keS4HbeLbI9echnIYC+K+2FC2AHA8xbCfjQjVGY1FXkPBZcz4oMO+AiEAZ9NJnTWGdUUP+yklmJFq2yy2yQI0OJvsmTKP2cgVYnvXQvjcHj+lw8UrmBX226tgQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYkYL3QYOkbJZiaucnJseom/Wef8NhQJWCAcYYPwsA0=;
 b=vGvGB/WycIQ6MWPiuoXmzIhH91Jf0Jn4vFFkd1eWCBaI+vU2wfkDyxcexriqCaxXl5gSF6H1R6dG9sZWFrsvJh2Jy9EF+ETW5S41y1Ndu44tj+Tb10xqxhNP0NunqlLztf0l09DV6OkOmPn85+dywvWAdGY0q5pr3+Ske+Tz2WQ=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CH3PR19MB8209.namprd19.prod.outlook.com (2603:10b6:610:1a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 20:06:56 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 20:06:55 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>,
	Miklos Szeredi <miklos@szeredi.hu>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey
	<mharvey@jumptrading.com>
Subject: Re: [RFC PATCH v3] fuse: add new function to invalidate cache for all
 inodes
Thread-Topic: [RFC PATCH v3] fuse: add new function to invalidate cache for
 all inodes
Thread-Index: AQHbe8josD7WZY035kqoE5BPMfyALrNA7aaAgAAJcoA=
Date: Mon, 10 Feb 2025 20:06:55 +0000
Message-ID: <a5c3eb63-0fab-4751-af2f-8cb48c06b47f@ddn.com>
References: <20250210143351.31119-1-luis@igalia.com>
 <2b65778e-7d26-4168-9346-6c1e01de350b@gmail.com>
In-Reply-To: <2b65778e-7d26-4168-9346-6c1e01de350b@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|CH3PR19MB8209:EE_
x-ms-office365-filtering-correlation-id: 0e4f4467-6d23-41f2-4e13-08dd4a0e77d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXhkeHBpZmJEQ3BpUWlSWmloM0F6WW1zTWhxMHhTc2x3b2FQeThrTVE5bGZS?=
 =?utf-8?B?Tk1VRW5aTFI4eTU2eWh1WVQrMWdxZHB6MHpISWNJUlBtV28wRURHdnpDWG9t?=
 =?utf-8?B?V0lyU2pmTGRSZVk5ZzNEV3dRbW5COEJZSGpiUFBEd3ZnczZrNGVCQk8rMWUw?=
 =?utf-8?B?K09ML2ZXOFJRNkV6cHNRVjZlRGJIaVFVWXphSXNzWmtmV2xad3AxNXd5WWt3?=
 =?utf-8?B?Qmk2MHpMSGh3ZVVoQVlPRktmVGdYQU00V2hBOEdXa0Rwcjd1VzB6dDI2cTFO?=
 =?utf-8?B?bGttVHIwRXVEYUhPem10K2I4NlZzaUhGWFFjOEQ3am9UTE9LR0F5V3ZpQUsw?=
 =?utf-8?B?RnZQSmUxcGpaMXllN2F3eXVLSkR3c0ZnY2VGVCtSRGRwZkN1c2NsUVVtamdm?=
 =?utf-8?B?ekVnZlgvNVhkRGFITHZkWU90YThUc3pKMC9JejJnL0psNTA3ZnB1TGNtbkYw?=
 =?utf-8?B?VDNQOE5MdWRxZ1gzaHFMbHRQTVczNk96YTQ3a1dtVjZWTk1RdGU3WUd6Z2Jn?=
 =?utf-8?B?RytZQ3MzcDN1ZXFsZERPYW8rWGsvaXpVbXVUQWo2ajE1S1Q4RWJCQjZ4Z3FO?=
 =?utf-8?B?WW5BUTFjWHUxQjBSSnRCaDk2OWtvb2Zld1FVZGF2KytvYlFzcmZFMkNsSi9v?=
 =?utf-8?B?UVBUM3ZiVnNWS0xHbHV4dkNnZHY1VTN0YzdFMG9USlU3aGltTDg0MmtNZ3BS?=
 =?utf-8?B?bE9XWHVuK1VReno2cVEwU0dOdExrd0NaclZzSmh3K2JxcU1ZU0UvczJZUGNM?=
 =?utf-8?B?TGkxaVFMK21HZGZCVHlLZDlCVzFVUE9JcmZ5TlV0Ym9sNE9LSGJqSXVOWE4r?=
 =?utf-8?B?bFJpeDk0QVJGYktrQVkrbHVZZUprSVQ4a3NVMHZPbjZBVGhmVXk0YkYySE5i?=
 =?utf-8?B?SVRJYWJMM284cW5nK2xoNWhES1YxeGxobjV0czFEVEp5akNEQ0t0Tjh4TnNk?=
 =?utf-8?B?T0R2UFhkeG90MXYwVWM5OUx6NEl5UXhiZGc3T2R2Y0JCcmgyT2ZGcVFCb0Jo?=
 =?utf-8?B?eDlsMEljaktvc3oxdjdaUkpuMGxjNnl6QTBxeC9HYzRuQW5WdUJYd1hNMktV?=
 =?utf-8?B?WFJET3g2R1J4MHBlQkxLTlY3SEV6RGJTb2xLeEJSb3ZKN3F5dkg5ZXFkUEFY?=
 =?utf-8?B?UExIcmhST1gyU2JnRlhhaklCVm1lT3JPMjRrTzdBOUFXT1hXbzdvczdScXpB?=
 =?utf-8?B?YTVVaE9IcW1Yd3Rab0JFMFpGZmZGQ1o3c0FQY0xxWmRkenlSSitjYTg1QTVL?=
 =?utf-8?B?RGNFMjFYQVM3QjRkZnZCTmJwMmsvNHc1V0psaFNZRHhIQk9MQ2FtUlVjSlAx?=
 =?utf-8?B?SitvQWN2VjFLcjcwVlZlT2lGNlRHbTgyZHkzd2sxbHpRWmNUdHBiL3hlT2Va?=
 =?utf-8?B?Ym92azM2M01sd2llcjE4MHgyVWhnVDZ3Uk1QeEZnQ1cvOSs3MGZua0srU3V3?=
 =?utf-8?B?SER3UUFwR1QwSGlVOUxscnNKWG1nUlljUmdSaTVwbmR1c3k0UFYzZlFBR1Bx?=
 =?utf-8?B?NmY1R3VBTGszTHBBVk5SaDlySjcwUTdHckVlN1RqMjRPR2ErWlBEeFlRWldp?=
 =?utf-8?B?TmRxenBTSmJCcExWa1VwWFdKYkkzVzAzNHJWQjgxVklMejJzK3ZNYU13ZmRN?=
 =?utf-8?B?eFVtd1VveXo1U3o1NVpMd3RTQ0ZEZlZtRnlBRGpmMEpOZUMrVFVjdTJ1WlBD?=
 =?utf-8?B?eFRuZWpQQjhLNm1Lb1lrdXA2RXNramJQM21XeWRRdmluRDZ0eXpCQzJqNExZ?=
 =?utf-8?B?V2pncjNBQzk0MEZvdVFqa1RWOHpVK2FxRjFmWGNwMklOUno4b3BTNTdMWTdI?=
 =?utf-8?B?eGdVMnlBb1ZMYmwwc3hBT0l1VDZ1NjNhUjdaMWhHWVMxS1hUc3l4QnJOMFpV?=
 =?utf-8?B?N2lkOUtxb2FmOGphZTBtQU93UFRzK05EbncycEk2c21VOXBEZ1VNUXYvZnRW?=
 =?utf-8?Q?tFrqbtgOTcIkzMrg80Xyq3hpAPxNeDbd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDV3K3pXVElxakJmYUhvZnVVdWowYUhpcktQVDF3YUhaeVA4dHNTaEpxUmFz?=
 =?utf-8?B?THo0MDFocGRsMncrZ3d0bS9rWUg5NzhEMVM0WHhUS2FDK3FKQUFwZjZiQXlS?=
 =?utf-8?B?VGdEUzlIdWJ4UUFwbHdsY3E3RlF0dG5hdVVram5pUTBuM0xUTExEdkFYK0xq?=
 =?utf-8?B?RWlwdmcyYU9aL05SYUZ6aHhRZy81OTNrZUp2UHVOQ3lpTmxWTmdnVHFVWXRt?=
 =?utf-8?B?ZzRBY2g2UGZrYk5qREJWWmdBMnNJNnBJK1dVOCtVYUhIckFURzRlS3NIcUpZ?=
 =?utf-8?B?dDdSRmRxWWpTV1haM2FQMldxR2hFQTN2YVpLMlVYVG9qUEUxZklBbU0wK0dr?=
 =?utf-8?B?a3lkSTFNOWluVWUrc1MxWVQ3MHU3cCs1M2o0MW1VMjQydzlNNEZaWnNSdngz?=
 =?utf-8?B?bVhBdkVTV3o5eVVzTjR4YWk0SWVUUWQvaUl6RXVnTVVIZFdHZXpRRTNVazVl?=
 =?utf-8?B?OXAyUVZZTHNHTHU4STZUcEMvaDEybWd6NXVMZU52ZEFqN0dENzh1YzhKV2NM?=
 =?utf-8?B?VDJUbEt4TDBlRHRGNlBlODBOZnZuMEpIWmJVcHVFWnpadHdISFRSbGM1NExs?=
 =?utf-8?B?WXJhREFKenorMmZoMHJoQWJZbFgvTEE3ZDhqNnhxK08veTlRQW91aVBwUEh0?=
 =?utf-8?B?WnlhSmtrUHd6ZGU2d1RvenVlRUJCK2FFb2VyTHBRMnQySmVnYnErZVllQTlt?=
 =?utf-8?B?dHI4bmZEYzF6VngyOGxmVVZTVkpENzg1NTV4OVJ2TXVnTlN1OXFZY2pxWC9p?=
 =?utf-8?B?bnA4cis2OTN4Wk1iZnVLVXJ5THVlZktaOTNyVlBEenBkMThkdDQ5QzJXb25C?=
 =?utf-8?B?eTNUdUdrbm13OW1hY25xQVlESFo1d2s1NEZaSFVMeEY0USsrLzljd3YyQ1Nw?=
 =?utf-8?B?ckxnWTJLZm02dENmaWw4TTA2eHpMZlJ6QXhDKzN5cWhVK0lIOU9KclhmRjBC?=
 =?utf-8?B?YUFtTUJVM2lzRGhYdkNnb3owSXFkUlZIcTFtbEpFV0V6amJkOXRKQSt4TkN4?=
 =?utf-8?B?NUxGWHo2Z1NmQ3Z2SklUcDJVSzVHYVEwWEFXODRBWUpHQ0xTT2VPSmhNUVlP?=
 =?utf-8?B?ZHhTb05yWHdIc0ZNOWhkYVlVUVlmQnhlL3gzcjFZelF2ODBuNnFpaEhYRDJR?=
 =?utf-8?B?NjRROXl0dFNwZVVVRm1vWVNYTXdGK2FXTzRUbkZjNmw4VHZONTQ2c0RzZlNJ?=
 =?utf-8?B?VlFLWGFPZFJpRm92YU5ZVVFMczdidU80SHI3WnphYk8zOHlQNEtZTkxIM3B3?=
 =?utf-8?B?QUMxK255NVh3NkhOcXpIaU1ObXhwL3lmc2M1RXRVc1JZWm03S3UyQnhwWGxz?=
 =?utf-8?B?QWdQeDl6d043T1FPMmhiQmx6YkhwK2tZaFBBMksvOW9JTjFnd0NXR2dibnVU?=
 =?utf-8?B?QlRPZ1JYdzEwRXRyTEIrTndNaHdKdkRVYTZSVnBGRndrbFJpVUhiLzJ1MzBO?=
 =?utf-8?B?bWdua1NxbGdGZG1mYUh6YXdsNG1ZcktZdlpXQmZNazU4L0NScG1kbHFyeUgv?=
 =?utf-8?B?RjFsTWNTa2lmSE4yZVdtb3BvdEhycnlxKzNhVUx2WjlPUnZZUVRDNE1MeWlU?=
 =?utf-8?B?ZklmRzBKbnpnYTR3Sy9KMVBWRnpUZ0FuWmtoZ0g0VE11eklXaHNoYzkxK0JY?=
 =?utf-8?B?NS9TaTRVdGYycU9JOWxIVEF6bjVSaTU4SHh3MGZpWFpoSTFjeXBVVng3NWV2?=
 =?utf-8?B?ZHQwc1ZPR1Bvc0R6V2dGM01OY0g5Tk40ZEZTRTFxRFFEMVFOSUhWMk1SbFg1?=
 =?utf-8?B?Z2cwTmlvczFEdTJ6N2lGeFpNZWJPUHBhY3puV1ExbWhRcisyeEE1WkZnT2lY?=
 =?utf-8?B?QXl0UitUL2tTeUYxVm16VVh4bDFEMEROUWRvb0FDQzhjNCt1TCtTTGpvZWlE?=
 =?utf-8?B?TkpQRk1VNHdzVnpkOW9DNDZXN0hKYTQ3WU5reGo0R1F4MUs2TGJWUXltakdp?=
 =?utf-8?B?UVFXZ29NSVZXRTN6UnYvbnhRYlMzNVRSNWNWNXpXdkxoUW1kQjcyWmJvaWVC?=
 =?utf-8?B?THZpajlRYUFlRjNEN3dtSWVCRm5VcVhzeHNrK09JODZ5RlF6cVNXSCt0bThj?=
 =?utf-8?B?ZVkwRzlseTB5Y05KNnRyNWJFazN1T09NTG1TUGg0RWZDeldrdWVvelQreTlp?=
 =?utf-8?B?TnNjZEo5U3cxeEJIVjN2N1ZrK3E3Y0pvdFRYQWRIcVVRWnZ5N3Z2K1F0aFhh?=
 =?utf-8?Q?0qoDkVaeOvoUBu++hLLPt8w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97884A258562A945980232119A5320A4@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 OEsSO+hiYUpc4G70RCGyl1ls1E8LmaCu0AjKd5iH4sbOvTX7tb4olt4zEkJwlw6n+tbzSGKaYJ7dxuVkAkVJ3Sn1tbBXJguIwHgFyPG6hzOUcnXypK9l442U2XGXPaSXCOJdBxFUhPv5lWuH7bc6kxGE3JLejsspgUdCl55faq5QrukJQXlQnYSebyL31SsO2pFiv2OBlyfTgryps/WSHqxxG8qo14V1tnJgdTFTxf6C3IYmUeIPr1aZy0lFxHNeKTgZbybnjDIWautWiirrgG8Vne2KtgfqzP3n0CdczpuXpFt3lvR9EmlAg8co79kcGN3b2U3891KUac2WStgM7hxjq2ziJE8+ejyT5RgO1CgqzC+zuWFj0xA6s5cKYiztEmxgSLyz8BMSmImDTs1DciIHTjAxpkL37TAj1ZHtFHnG/gsiN0VrzMfsBYlKHUduD0TumTmhupVeoDNuAMHKL4GK3ftm/GHyKtOBY1CqeJoeVTXxvABOrVStz3g0CH+7S4yYmGYYyoqxEkqCGZhDJFGa7GuCb6Du9+CeOzrFX0+I+8QqIFjPYGElxz3fnXykGy0Jo5Maqcdos45MtaSxgP1KldcUPlFb3rvlGhQn/nYBWU7fbde2FFgmpP3St5N9gyxzjiu2N8ae4Vg5ImBmBw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4f4467-6d23-41f2-4e13-08dd4a0e77d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 20:06:55.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCVS8VNS0lVE/d6OJ+M7FXGJdDKn9B4ISN+Y060NRVMael8cZSUNnMDBG88Gznjqidch7Y4ZlUFwPzml/oQVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8209
X-OriginatorOrg: ddn.com
X-BESS-ID: 1739220039-103672-19449-884-1
X-BESS-VER: 2019.1_20250208.0140
X-BESS-Apparent-Source-IP: 104.47.55.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaGFoZAVgZQ0MjCMiktxcIw1c
	zS3DIpJcXSxDDVyCTNPNnE3MTEzNRAqTYWAP1tl5BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262426 [from 
	cloudscan11-106.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

T24gMi8xMC8yNSAyMDozMywgSm9hbm5lIEtvb25nIHdyb3RlOg0KPiBPbiAyLzEwLzI1IDY6MzMg
QU0sIEx1aXMgSGVucmlxdWVzIHdyb3RlOg0KPj4gQ3VycmVudGx5IHVzZXJzcGFjZSBpcyBhYmxl
IHRvIG5vdGlmeSB0aGUga2VybmVsIHRvIGludmFsaWRhdGUgdGhlIGNhY2hlDQo+PiBmb3IgYW4g
aW5vZGUuwqAgVGhpcyBtZWFucyB0aGF0LCBpZiBhbGwgdGhlIGlub2RlcyBpbiBhIGZpbGVzeXN0
ZW0gbmVlZCB0bw0KPj4gYmUgaW52YWxpZGF0ZWQsIHRoZW4gdXNlcnNwYWNlIG5lZWRzIHRvIGl0
ZXJhdGUgdGhyb3VnaCBhbGwgb2YgdGhlbQ0KPj4gYW5kIGRvDQo+PiB0aGlzIGtlcm5lbCBub3Rp
ZmljYXRpb24gc2VwYXJhdGVseS4NCj4+DQo+PiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgb3B0aW9u
IHRoYXQgYWxsb3dzIHVzZXJzcGFjZSB0byBpbnZhbGlkYXRlIGFsbCB0aGUNCj4+IGlub2RlcyB3
aXRoIGEgc2luZ2xlIG5vdGlmaWNhdGlvbiBvcGVyYXRpb24uwqAgSW4gYWRkaXRpb24gdG8NCj4+
IGludmFsaWRhdGUgYWxsDQo+PiB0aGUgaW5vZGVzLCBpdCBhbHNvIHNocmlua3MgdGhlIHNiIGRj
YWNoZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMdWlzIEhlbnJpcXVlcyA8bHVpc0BpZ2FsaWEu
Y29tPg0KPj4gLS0tDQo+PiAqIENoYW5nZXMgc2luY2UgdjINCj4+IFVzZSB0aGUgbmV3IGhlbHBl
ciBmcm9tIGZ1c2VfcmV2ZXJzZV9pbnZhbF9pbm9kZSgpLCBhcyBzdWdnZXN0ZWQgYnkNCj4+IEJl
cm5kLg0KPj4NCj4+IEFsc28gdXBkYXRlZCBwYXRjaCBkZXNjcmlwdGlvbiBhcyBwZXIgY2hlY2tw
YXRjaC5wbCBzdWdnZXN0aW9uLg0KPj4NCj4+ICogQ2hhbmdlcyBzaW5jZSB2MQ0KPj4gQXMgc3Vn
Z2VzdGVkIGJ5IEJlcm5kLCB0aGlzIHBhdGNoIHYyIHNpbXBseSBhZGRzIGFuIGhlbHBlciBmdW5j
dGlvbiB0aGF0DQo+PiB3aWxsIG1ha2UgaXQgZWFzaWVyIHRvIHJlcGxhY2UgbW9zdCBvZiBpdCdz
IGNvZGUgYnkgYSBjYWxsIHRvIGZ1bmN0aW9uDQo+PiBzdXBlcl9pdGVyX2lub2RlcygpIHdoZW4g
RGF2ZSBDaGlubmVyJ3MgcGF0Y2hbMV0gZXZlbnR1YWxseSBnZXRzIG1lcmdlZC4NCj4+DQo+PiBb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MTAwMjAxNDAxNy4zODAxODk5LTMtDQo+
PiBkYXZpZEBmcm9tb3JiaXQuY29tDQo+Pg0KPj4gwqAgZnMvZnVzZS9pbm9kZS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0N
Cj4+IMKgIGluY2x1ZGUvdWFwaS9saW51eC9mdXNlLmggfMKgIDMgKysNCj4+IMKgIDIgZmlsZXMg
Y2hhbmdlZCwgNjMgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZnMvZnVzZS9pbm9kZS5jIGIvZnMvZnVzZS9pbm9kZS5jDQo+PiBpbmRleCBlOWRiMmNi
OGMxNTAuLjQ1YjlmYmI1NGQ0MiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2Z1c2UvaW5vZGUuYw0KPj4g
KysrIGIvZnMvZnVzZS9pbm9kZS5jDQo+PiBAQCAtNTQ3LDI1ICs1NDcsNzggQEAgc3RydWN0IGlu
b2RlICpmdXNlX2lsb29rdXAoc3RydWN0IGZ1c2VfY29ubiAqZmMsDQo+PiB1NjQgbm9kZWlkLA0K
Pj4gwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4+IMKgIH0NCj4+IMKgICtzdGF0aWMgdm9pZCBp
bnZhbF9zaW5nbGVfaW5vZGUoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0DQo+PiBmdXNlX2Nv
bm4gKmZjKQ0KPj4gK3sNCj4+ICvCoMKgwqAgc3RydWN0IGZ1c2VfaW5vZGUgKmZpOw0KPj4gKw0K
Pj4gK8KgwqDCoCBmaSA9IGdldF9mdXNlX2lub2RlKGlub2RlKTsNCj4+ICvCoMKgwqAgc3Bpbl9s
b2NrKCZmaS0+bG9jayk7DQo+PiArwqDCoMKgIGZpLT5hdHRyX3ZlcnNpb24gPSBhdG9taWM2NF9p
bmNfcmV0dXJuKCZmYy0+YXR0cl92ZXJzaW9uKTsNCj4+ICvCoMKgwqAgc3Bpbl91bmxvY2soJmZp
LT5sb2NrKTsNCj4+ICvCoMKgwqAgZnVzZV9pbnZhbGlkYXRlX2F0dHIoaW5vZGUpOw0KPj4gK8Kg
wqDCoCBmb3JnZXRfYWxsX2NhY2hlZF9hY2xzKGlub2RlKTsNCj4+ICt9DQo+PiArDQo+PiArc3Rh
dGljIGludCBmdXNlX3JldmVyc2VfaW52YWxfYWxsKHN0cnVjdCBmdXNlX2Nvbm4gKmZjKQ0KPj4g
K3sNCj4+ICvCoMKgwqAgc3RydWN0IGZ1c2VfbW91bnQgKmZtOw0KPj4gK8KgwqDCoCBzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiOw0KPj4gK8KgwqDCoCBzdHJ1Y3QgaW5vZGUgKmlub2RlLCAqb2xkX2lu
b2RlID0gTlVMTDsNCj4+ICsNCj4+ICvCoMKgwqAgaW5vZGUgPSBmdXNlX2lsb29rdXAoZmMsIEZV
U0VfUk9PVF9JRCwgTlVMTCk7DQo+PiArwqDCoMKgIGlmICghaW5vZGUpDQo+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FTk9FTlQ7DQo+PiArDQo+PiArwqDCoMKgIGZtID0gZ2V0X2Z1c2VfbW91
bnQoaW5vZGUpOw0KPiANCj4gSSB0aGluayBpZiB5b3UgcGFzcyBpbiAmZm0gYXMgdGhlIDNyZCBh
cmcgdG8gZnVzZV9pbG9va3VwKCksIGl0J2xsIHBhc3MNCj4gYmFjayB0aGUgZnVzZSBtb3VudCBh
bmQgd2Ugd29uJ3QgbmVlZCBnZXRfZnVzZV9tb3VudCgpLg0KPiANCj4+ICvCoMKgwqAgaXB1dChp
bm9kZSk7DQo+PiArwqDCoMKgIGlmICghZm0pDQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
Tk9FTlQ7DQo+PiArwqDCoMKgIHNiID0gZm0tPnNiOw0KPj4gKw0KPj4gK8KgwqDCoCBzcGluX2xv
Y2soJnNiLT5zX2lub2RlX2xpc3RfbG9jayk7DQo+PiArwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50
cnkoaW5vZGUsICZzYi0+c19pbm9kZXMsIGlfc2JfbGlzdCkgew0KPj4gK8KgwqDCoMKgwqDCoMKg
IHNwaW5fbG9jaygmaW5vZGUtPmlfbG9jayk7DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKChpbm9k
ZS0+aV9zdGF0ZSAmIChJX0ZSRUVJTkd8SV9XSUxMX0ZSRUV8SV9ORVcpKSB8fA0KPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgIWF0b21pY19yZWFkKCZpbm9kZS0+aV9jb3VudCkpIHsNCj4gDQo+
IFdpbGwgaW5vZGUtPmlfY291bnQgZXZlciBiZSAwPyBBRkFJVSwgaW5vZGUtPmlfY291bnQgdHJh
Y2tzIHRoZSBpbm9kZQ0KPiByZWZjb3VudCwgc28gaWYgdGhpcyBpcyAwLCBkb2Vzbid0IHRoaXMg
bWVhbiBpdCB3b3VsZG4ndCBiZSBvbiB0aGUgc2ItDQo+PnNfaW5vZGVzIGxpc3Q/DQo+IA0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJmlub2RlLT5pX2xvY2spOw0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+PiArwqDCoMKgwqDCoMKgwqAgfQ0K
Pj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgIF9faWdldChpbm9kZSk7DQo+PiArwqDCoMKgwqDCoMKg
wqAgc3Bpbl91bmxvY2soJmlub2RlLT5pX2xvY2spOw0KPj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5f
dW5sb2NrKCZzYi0+c19pbm9kZV9saXN0X2xvY2spOw0KPiANCj4gTWF5YmUgd29ydGggYWRkaW5n
IGEgY29tbWVudCBoZXJlIHNpbmNlIHRoZXJlIGNhbiBiZSBpbm9kZXMgYWRkZWQgYWZ0ZXINCj4g
dGhlIHNfaW5vZGVfbGlzdF9sb2NrIGlzIGRyb3BwZWQgYW5kIGJlZm9yZSBpdCdzIGFjcXVpcmVk
IGFnYWluIHRoYXQNCj4gd2hlbiBpbm9kZXMgZ2V0IGFkZGVkIHRvIHRoZSBoZWFkIG9mIHNiLT5z
X2lub2RlcywgaXQncyBhbHdheXMgZm9yIElfTkVXDQo+IGlub2Rlcy4NCj4gDQo+PiArwqDCoMKg
wqDCoMKgwqAgaXB1dChvbGRfaW5vZGUpOw0KPiANCj4gTWF5YmUgYSBkdW1iIHF1ZXN0aW9uIGJ1
dCB3aHkgaXMgb2xkX2lub2RlIG5lZWRlZD8gV2h5IGNhbid0IGlwdXQoKWp1c3QNCj4gYmUgY2Fs
bGVkIHJpZ2h0IGFmdGVyIGludmFsX3NpbmdsZV9pbm9kZSgpPw0KDQpJIGhhZCB3b25kZXJlZCB0
aGUgc2FtZSBpbiB2MS4gSXNzdWUgaXMgdGhhdCB0aGVyZSBpcyBhIGxpc3QgaXRlcmF0aW9uDQp0
aGF0IHJlbGVhc2VzIHRoZSBsb2NrcyAtIGlmIHRoZSBwdXQgd291bGQgYmUgZG9uZSBpbW1lZGlh
dGVseSBpdCBjb3VsZA0Kbm90IGNvbnRpbnVlIG9uICJvbGRfaW5vZGUiIGFzIGl0IG1pZ2h0IG5v
dCBleGlzdCBhbnltb3JlLg0KDQoNCg0KPiANCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpbnZh
bF9zaW5nbGVfaW5vZGUoaW5vZGUsIGZjKTsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoCBvbGRf
aW5vZGUgPSBpbm9kZTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBjb25kX3Jlc2NoZWQoKTsNCj4gDQo+
IENvdWxkIHlvdSBleHBsYWluIHdoeSBhIGNvbmRfcmVzY2hlZCgpIGlzIG5lZWRlZCBoZXJlPw0K
DQpHaXZlIG90aGVyIHRocmVhZHMgYSBjaGFuY2UgdG8gd29yaz8gVGhlIGxpc3QgbWlnaHQgYmUg
aHVnZT8NCg0KDQoNClRoYW5rcywNCkJlcm5kDQo=


Return-Path: <linux-fsdevel+bounces-34852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9141F9C9529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 23:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01BEB23E07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0261B0F22;
	Thu, 14 Nov 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DOvIjjUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19683170A1B;
	Thu, 14 Nov 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731623437; cv=fail; b=m7dkGfLWykCSgUdO7cByMJ6Mj2vf6RiPwU8mnD2auPYdZRg/eADuuBTohY2df4GhOCN5JAG1sZ+w2QMlUDHvMpNPwE590+m2GCSDQE1W/j0F3JSmKI2sajZAYfrR5yk8frXmCYHHfAh33MO++TazOqwX826yl1iZaxuJeePi320=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731623437; c=relaxed/simple;
	bh=1jJZCyIgOIysbkmJgQWWmoA83uuNbwEoPeig+I7jDek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOs5WMoRbpFXFWvGnVQcOvu5K73fWEKMWhoaAONaQX3aiY1C3W5DOkDT1Cp9hZxJqv/kRcCkula3yURKXr6nU5ie+bwsMt5lP2KPQAjuTzhXkdMu/uAOOil6P3lmBVBbUoEKj5MwG1haossfZ3Oi4BTmkpeIS8I5ZTLp1GtL7Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DOvIjjUM; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEKoZZ9004747;
	Thu, 14 Nov 2024 14:30:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=1jJZCyIgOIysbkmJgQWWmoA83uuNbwEoPeig+I7jDek=; b=
	DOvIjjUMYza4EufEgusmTCP+HAJxXflZZ4sE3ND+hqfSpUIMHFQv7rGdtCH8JdD9
	3sE4GNSoJSrQe2QZrvcBdz2kPZeZ9yB4tu9UXU4gM9f7Yd5fhA/tF4ycH2k03hHD
	fynWv00WLYn7JgpyoC8I8wESt5KXKWNYgNmUYOfz9HQtgcQSNoyXDB82Mnmt+wft
	4AM7NPgPCa8bW4quJ3H/HuJPHWa9D2/pWw9AFAdCVQfOBOjTEOr/0RODYtZB+C12
	v5QfZMLavvQLP7myvp/bygbvUiX772Yq8Q2qTLfzLoBk2ZNIJ2W6S1iMQf7i3Ppk
	F1xItC/U+Kn6MlHys+QGVA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42wr4vgwqg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 14:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPqsINngWzLblK4S4mj2z5LFTbk6iiuUEUir0ccLtorTvqz9csBbHosKhSImSiQcBoK29pKGZfPWSLWTRCiAh8kPM/IN+KBC+RtDuU51udXsbNTnWNZbao1Z5+7X1KPwS02DSrE1736pI33UQkt8Sd78lO7abgvhZpwMedztOwsKkCeHhFqYpYMq2jcN0yr7a7H+5r0gbYHyKcPAim43Rp5AEK6lOzhjc9UMsRYRu5Ve888jw9gr2wCj1a2zxlXIF2VMUNV4041itdJwnTanSEJj/ZhvhllhEZLghlhMRIW1SMW4ttLywWWhvYAusmxgtTLESauFwE1n9PJ54LcUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jJZCyIgOIysbkmJgQWWmoA83uuNbwEoPeig+I7jDek=;
 b=VcGVstrsDeQAeoZ4KP3uNh84QX8mX17sEEQLIJmyDWJ40JTDMzGsWC7yfA3PpnmRPNQA4k9/HZ7LKsuthDJf3qmCbkAo5W2jBgddnBGmyp8aA/ffnDI33IMX1/CLilDymh0D8IVxv/1/MZ9324Qqw75NNmPsWHVqfIg1JQllcx0L1quDiSRERCPhg98p0d1YPoDgOcHw9MznUr6m6I6RR/3PqOv+zL8tgvnS1FLwfn4QrxLDLqTW7XgtlS9JMKsWbF0hwg5VorKM+sHkWOB5hJ/fDE5bwvs2EDVD+GMCkKmNcgd+vX1BMr1+Tx9tCetRccpDU8gtmADRuQ2+Xsddyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CY5PR15MB5389.namprd15.prod.outlook.com (2603:10b6:930:3f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:30:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 22:30:29 +0000
From: Song Liu <songliubraving@meta.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
CC: Song Liu <songliubraving@meta.com>,
        Casey Schaufler
	<casey@schaufler-ca.com>,
        "Dr. Greg" <greg@enjellic.com>, Song Liu
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
 AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yAgAEUSoCAAA4qgIABaxuAgAAOzICAAAqvgIAAPekAgAALaAA=
Date: Thu, 14 Nov 2024 22:30:29 +0000
Message-ID: <B6C7997A-8A4F-4859-9817-8F73F883CF93@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
In-Reply-To:
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CY5PR15MB5389:EE_
x-ms-office365-filtering-correlation-id: cc423895-879d-46a6-884e-08dd04fbf190
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1ZkWnIzV0ViZTVETnROblUyNy9hZWpQdjFtZzBXWE5Ca0xWZndrVHc2a0Za?=
 =?utf-8?B?eDJSOWZGS3pNZmR0U0JMckMxTXhoVmdrdXFET3ZDbHQ4K0lDUXNXMzZSdDRu?=
 =?utf-8?B?aEpTOW9WYXlUcUlmOHpyZzJQNENKemc0U3VpN0JtcmI1NTc5aTlxR3h2b2xz?=
 =?utf-8?B?MnBmNzU2Z1Q4czlwREQvQ0l0N0YxcjhoVGR3T2F3ZEJOTFJrZUF4ZmRLVW1L?=
 =?utf-8?B?VlB2ZzhYTmZnTTFrWGNVd1A4TDFuYmgxMytGNks2QmZMdVdkSXZpOUlURjhH?=
 =?utf-8?B?SlJWUjlUY3FweG54UHpCblRjT29Rc24ycVhibkhoWTN6YXJXQmVNQzY4NlZU?=
 =?utf-8?B?bUpBazZsaVplWng0YTA1OG5ZZUNCd2JiNC9yV2lUQXZFNE5XbzhiMUk3MkNY?=
 =?utf-8?B?ZUhNejZmWENhbFg4bW9ySTk4MjFYTmk2Q3JnWVMwaWRDdTh4YndEWERPc1hE?=
 =?utf-8?B?Y25GTE53ZmhVRTA3WnhYOVhzaStlSkNTeklFNjRZd3YrV2FwVVF3NVVKMXZU?=
 =?utf-8?B?alZsTGF4YnF1MS9ySXNoQ0RxSXhqTEpBQmdkc3M2QVU5SlNxb1U1MVNOTU1i?=
 =?utf-8?B?MU5GQUdPUnFZeUttMCtQckNPaWQ2QUtHL1hGazM0aFZ5NWkrRUk5NEI4c0U1?=
 =?utf-8?B?OGhJaUlvM3RCUUgwd1VqKyswRE1UTUhiRGJnT0k4TFRob05MbHBVd1oreHhT?=
 =?utf-8?B?d29BODZtRG1keVVlejdwY0ZwUmE5N3RjMUpXbENpZFpvdXdmVHNrT3dsNElN?=
 =?utf-8?B?SnBocTQxTGppTmtWTnFVbUpKSFB0SkpoVmREMjlCeWd4TlNtTjZ3QlRzdEth?=
 =?utf-8?B?N25tbUdiSHh0REpQZWtWR0xsWXdXZHAvWXUvN09wMy9MQ0VucWhVNVlWZnhP?=
 =?utf-8?B?Y2pFdnp0UDkzdHpSTEU4cFlNSHZSNkwrUDllbnM5VE5SZGdjMVFoSWNJbThG?=
 =?utf-8?B?OVNKTmt1b1ZSUncxNVBEYkhqNjd1OE8wNC9CbW9LMlVTajVKbVJEdlltY3pT?=
 =?utf-8?B?V2I0ZVU3cEhwS09wM0toTWRENStwcHg1RXMycnpJd3ZJaHN4TXI3SGtCMmJD?=
 =?utf-8?B?ZlJXcysyNHdManlqZTVwc1hIcmt4QzJYeXJVcktOL2hqU3dGeWFoVklKSDFr?=
 =?utf-8?B?M25SN0dsNDRneWcvOVRKcTF3Ykk4VDd3VjdkQjNvTVFFWEFkZkZhOEtqN1pP?=
 =?utf-8?B?ek1BVmcxWU5uN0ZUSUFMZGN3ZlBySmhVK2paYU1HRFc2eXZqZUovNnFkdzkx?=
 =?utf-8?B?elJqYS84ODdYVEVBYzBaclRscW5JYzc3MmFYbWZ4NTlWL0tUb1NPNTVFK2xW?=
 =?utf-8?B?Z09PTVJnTnFPQWloMUFFM09DbkRYWVNET1BwZXhSL0xTSUloeE9SdWEyRWVW?=
 =?utf-8?B?NEhhN0srMStxdTFtSnlubFhGZUJLVU1FTWdTQnhlK1FUcUlKQjRNVytFVFNH?=
 =?utf-8?B?M0xnRW9sVXJZbkFpYk1GaFA2QXFJejJjeGl4bXRFVkk3ajFhb1o0SkUzaUx2?=
 =?utf-8?B?THBVbVB6a2RaSXJDdm9DSEdwbWN1UmtIMVpIOUdJb3g2OStuMUtLRW9PMU9C?=
 =?utf-8?B?NTNxTGpkNkpVOW8rWW9scUFhaTQ3YU5IaGRXaWFDbDdJMUFLOVFpakR3eG5v?=
 =?utf-8?B?dzE4bjlYbzRoSkJTQ0Y2K3Yyb2NjUXYxV3pXc0o1RkxReHdlaFhtSS9HMS93?=
 =?utf-8?B?aHRUdXlzNDBSMmRubGg0SXJOY0l1ZFh4OUplTmdmaDd6VzRCYlZVMmJTNi9G?=
 =?utf-8?B?endsZVhDUTAxY2p0Vmx0dGN4MWs1ZUJGYmxZb2tyYVVTR2hYWEZxNytkZG1p?=
 =?utf-8?B?c3ZOV1UrNVV3eDR1SUJCSmFoN0pXVEFncWd1S1RzcWY4R3JjMWp6Qnd0eTB5?=
 =?utf-8?Q?WmSWP6snxmKVk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjM1L01EMVFlM09kSTE2WmVkRU5ZZWhJZXdES09kWVRpTW5VVkk0MloyK2hI?=
 =?utf-8?B?WVJmSW96VGNkZWNEL3AvbGowYk1EcTJvczZhdjE2VzRLd04wRmdwemZQV1ZT?=
 =?utf-8?B?N1BiMGZ1ZW9RenVTREllNzJDSlM5VWhnQjJpVTZJV0tZN1cxT3lPTU1uUVQr?=
 =?utf-8?B?V1c4dUE3SDRydGwxU2grWXRNRnBXQk4xVDMvK1VSZU1UWFErTnJXTmMvdlFr?=
 =?utf-8?B?ZGgyT0VHb1hCMzNORDFFSjFBRGxyRWZjMWJSWVd3TG80a0UvdFBjdVRzd25q?=
 =?utf-8?B?SUJzNXh2VERQKzVxeDRBTXBrYk5RQ2h1Z0Z2UjNKMU5CejA0ck9HVUxncXFw?=
 =?utf-8?B?ems4WDNkeSs0bGk4L1JwMlRybS90VlBLN2tESm9oaDE0OGZZUlJnWjlPUTRH?=
 =?utf-8?B?Ty8xUEVpQWNSUW9IbmJBK04rQXUvQjk3WWN4SWx2Nit6MU8yQ3BqQitoOHgx?=
 =?utf-8?B?eDY3QnZJL0VvR2JEb01kZHZzQkwrSFZkMUZlRFRHeGU3QnNLUThNaWJ2UEVy?=
 =?utf-8?B?ck54K2w0bmR5TTdZMFluVWU3RXBvV3NncFJSOHFPSXdnSlU2dXZma3poYUM2?=
 =?utf-8?B?cWdnRmRMNkMyUUw2ZUVodHdNMHRSQXV3MnMrVmV0NmFJdjkzbWw3NjVyT1B5?=
 =?utf-8?B?cmJjNFRjeFFuZHBON2FreDh2QjlJUFJpLzdwZ05UekxjYnJWWTR6dy85aGRJ?=
 =?utf-8?B?TjhhbkswS3VUelNVNVZkOXE3bFZzRmsxUVBVdWk2M25sc3FOR2lKbnBaSi85?=
 =?utf-8?B?TWJsaFI1cEtzV3V6WXlkVjEvOVZCeEdhTUVUcUFmZnpSc0RsN3oyNkhGTUdO?=
 =?utf-8?B?QUtKVUloNkVOYU5MemoxSjlNZ0pybjlENS9TTnNmcDlkeDhKNy9SVmZ2dGNq?=
 =?utf-8?B?SWtiSWFPSjBYdnFHVjlESGwrbFZsUWhUVkllWS84MVRGVHRzaG5ya3c0VURS?=
 =?utf-8?B?eVpRUU4vc1hEc214cXlaVkh1Tmo2OFFsL1VLS0dQRnUwU0RJWk5CVnNRbnRa?=
 =?utf-8?B?L3RTSENKRHJVYUlRZG52NHBpNkpMNVMxY0cvdU1RamNRUHl0eE1ZVElHRlhD?=
 =?utf-8?B?d2RQcHdJWjJPci95ZWxBV25KYUIyazhKQ1BkVGN3TnNSNERBaTdCNDBMV1Vl?=
 =?utf-8?B?WkFKR3RxTEZCMmhRWW42NUFrSGxTdzlvYUlJclcrSUZuckxDVjBOOVpXTWhH?=
 =?utf-8?B?cFkyenRkRGtwNWlZWjhUSnBZeGVyU0QyYndMN09vSWVaT2J2VEtaVGVWSkV3?=
 =?utf-8?B?VXF6RlE4Q2podkVLdmNydTVHSzgwYThsSUdFWlJWdTRvTVZCU3lvWTZWTDI3?=
 =?utf-8?B?a1VlZ1VZTTU5ZG9nMkZySDE1RXJaQVZhRVBZT0IwZUppS3NYZFFvVnpUaVE0?=
 =?utf-8?B?T0gwMytETzI2L0lCVkUvbnNwVEtuK2lhc2o3ME1HYjFIcy9wMHd0aERoZ0Nz?=
 =?utf-8?B?U2prRzRoY3JxOVc1VVppOURsZWVBb2Zmb0hFNnBteHNhVXhaV2R5WXhuZTc2?=
 =?utf-8?B?c1NhTU9QQ21jSy9ieXI1aGJyYnl3b1lQKzB2TVNTdmwxb1EvcjdCZEpiUk96?=
 =?utf-8?B?TWxpQjNiQ29EdTY5UXBtVWZQUmdmdXJMVURuRHhrN05yVUtqOWZzU1FSOG1i?=
 =?utf-8?B?TnB2RzlTbnZwYmVDeFNCNWJHY2RrUVRJdmp1eGZRSXA0YjVUK01IQTB5S1VT?=
 =?utf-8?B?YUUraE5VaWpNbmVXUGhic3F4dUFJZlVWSktoekExYUpqaHUxTVp2cFI5Tk9W?=
 =?utf-8?B?UWFnUUNpdDZqNWJZY1p0dDNKQ3pSSnFLa1J6U3ZFK243ZVFuQ2JFQ0RzcWdP?=
 =?utf-8?B?eWUzcFNrUjhScFc4VVZvR2N6UmtxNTJpWjRySnl3YkUzTWVPSFdXZmdETmdj?=
 =?utf-8?B?K0h3c0VGTnhueWQ3TEg0SGI2U0pYMkdvZW9nUGtrSjdycERtWnFzSTVHNzVo?=
 =?utf-8?B?cUdiVzJRc2x5OU1pbUxsRHVPdm1FdFcyemJxcmpnVzZ2NVI5dEdudmJmejdz?=
 =?utf-8?B?dVZzVFhicWYzME5BWVRQdEhkbFVkbDUwcnRUdUVSUURYVGVSb3dTQTgvSWN2?=
 =?utf-8?B?dzh2aVg1RWt6bnR2UjRJWVJ5VFlkcjFGTGFQQ3ArMUNRM1JWSUg0ZG1Ta2JH?=
 =?utf-8?B?RFNMY2x1eVlOUEpmbWdaSU04cGtSclJMMVduaVJlM1NGdTRTN0RLZEtrVDRU?=
 =?utf-8?Q?DBSxIxNPGSDVklTHEjuQVLk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB139C8C5F26EE4E85BCE5DF7928E799@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc423895-879d-46a6-884e-08dd04fbf190
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 22:30:29.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9ID2YuVKrRu1tc15+83cjDlC89IchGEZmUbLwh0HN6aWVTCN26jpXu7W1RWt5LMgYYM/aJPR9/HTjuS8jgq9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5389
X-Proofpoint-GUID: 6tuWXVkQd1ZuCwt7r-krrPEc2w2-gNtX
X-Proofpoint-ORIG-GUID: 6tuWXVkQd1ZuCwt7r-krrPEc2w2-gNtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

SGkgSmFtZXMsIA0KDQpUaGFua3MgZm9yIHlvdXIgaW5wdXQhDQoNCj4gT24gTm92IDE0LCAyMDI0
LCBhdCAxOjQ54oCvUE0sIEphbWVzIEJvdHRvbWxleSA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBh
cnRuZXJzaGlwLmNvbT4gd3JvdGU6DQoNClsuLi5dDQoNCj4+IA0KPj4gQWN0dWFsbHksIEkgY2Fu
IHVuZGVyc3RhbmQgdGhlIGNvbmNlcm4gd2l0aCB1bmlvbi4gQWx0aG91Z2gsIA0KPj4gdGhlIGxv
Z2ljIGlzIHNldCBhdCBrZXJuZWwgY29tcGlsZSB0aW1lLCBpdCBpcyBzdGlsbCBwb3NzaWJsZSAN
Cj4+IGZvciBrZXJuZWwgc291cmNlIGNvZGUgdG8gdXNlIGlfYnBmX3N0b3JhZ2Ugd2hlbiANCj4+
IENPTkZJR19TRUNVUklUWSBpcyBlbmFibGVkLiAoWWVzLCBJIGd1ZXNzIG5vdyBJIGZpbmFsbHkg
dW5kZXJzdGFuZA0KPj4gdGhlIGNvbmNlcm4pLiANCj4+IA0KPj4gV2UgY2FuIGFkZHJlc3MgdGhp
cyB3aXRoIHNvbWV0aGluZyBsaWtlIGZvbGxvd2luZzoNCj4+IA0KPj4gI2lmZGVmIENPTkZJR19T
RUNVUklUWQ0KPj4gICAgICAgICB2b2lkICAgICAgICAgICAgICAgICAgICAqaV9zZWN1cml0eTsN
Cj4+ICNlbGlmIENPTkZJR19CUEZfU1lTQ0FMTA0KPj4gICAgICAgICBzdHJ1Y3QgYnBmX2xvY2Fs
X3N0b3JhZ2UgX19yY3UgKmlfYnBmX3N0b3JhZ2U7DQo+PiAjZW5kaWYNCj4+IA0KPj4gVGhpcyB3
aWxsIGhlbHAgY2F0Y2ggYWxsIG1pc3VzZSBvZiB0aGUgaV9icGZfc3RvcmFnZSBhdCBjb21waWxl
DQo+PiB0aW1lLCBhcyBpX2JwZl9zdG9yYWdlIGRvZXNuJ3QgZXhpc3Qgd2l0aCBDT05GSUdfU0VD
VVJJVFk9eS4gDQo+PiANCj4+IERvZXMgdGhpcyBtYWtlIHNlbnNlPw0KPiANCj4gR290IHRvIHNh
eSBJJ20gd2l0aCBDYXNleSBoZXJlLCB0aGlzIHdpbGwgZ2VuZXJhdGUgaG9ycmlibGUgYW5kIGZh
aWx1cmUNCj4gcHJvbmUgY29kZS4NCg0KWWVzLCBhcyBJIGRlc2NyaWJlZCBpbiBhbm90aGVyIGVt
YWlsIGluIHRoZSB0aHJlYWQgWzFdLCB0aGlzIHR1cm5lZA0Kb3V0IHRvIGNhdXNlIG1vcmUgdHJv
dWJsZXMgdGhhbiBJIHRob3VnaHQuIA0KDQo+IFNpbmNlIGVmZmVjdGl2ZWx5IHlvdSdyZSBtYWtp
bmcgaV9zZWN1cml0eSBhbHdheXMgcHJlc2VudCBhbnl3YXksDQo+IHNpbXBseSBkbyB0aGF0IGFu
ZCBhbHNvIHB1bGwgdGhlIGFsbG9jYXRpb24gY29kZSBvdXQgb2Ygc2VjdXJpdHkuYyBpbiBhDQo+
IHdheSB0aGF0IGl0J3MgYWx3YXlzIGF2YWlsYWJsZT8gIA0KDQpJIHRoaW5rIHRoaXMgaXMgYSB2
ZXJ5IGdvb2QgaWRlYS4gSWYgZm9sa3MgYWdyZWUgd2l0aCB0aGlzIGFwcHJvYWNoLCANCkkgYW0g
bW9yZSB0aGFuIGhhcHB5IHRvIGRyYWZ0IHBhdGNoIGZvciB0aGlzLiANCg0KVGhhbmtzIGFnYWlu
LCANCg0KU29uZw0KDQo+IFRoYXQgd2F5IHlvdSBkb24ndCBoYXZlIHRvIHNwZWNpYWwNCj4gY2Fz
ZSB0aGUgY29kZSBkZXBlbmRpbmcgb24gd2hldGhlciBDT05GSUdfU0VDVVJJVFkgaXMgZGVmaW5l
ZC4gDQo+IEVmZmVjdGl2ZWx5IHRoaXMgd291bGQgZ2l2ZSBldmVyeW9uZSBhIGdlbmVyaWMgd2F5
IHRvIGF0dGFjaCBzb21lDQo+IG1lbW9yeSBhcmVhIHRvIGFuIGlub2RlLiAgSSBrbm93IGl0J3Mg
bW9yZSBjb21wbGV4IHRoYW4gdGhpcyBiZWNhdXNlDQo+IHRoZXJlIGFyZSBMU00gaG9va3MgdGhh
dCBydW4gZnJvbSBzZWN1cml0eV9pbm9kZV9hbGxvYygpIGJ1dCBpZiB5b3UgY2FuDQo+IG1ha2Ug
aXQgd29yayBnZW5lcmljYWxseSwgSSdtIHN1cmUgZXZlcnlvbmUgd2lsbCBiZW5lZml0Lg0KDQpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC84NkM2NUI4NS04MTY3LTRE
MDQtQkZGNS00MEZENEYzNDA3QTRAZmIuY29tLw==


Return-Path: <linux-fsdevel+bounces-35045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA519D06BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 23:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CEB281F5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA071DDC37;
	Sun, 17 Nov 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mwxf/H2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87D1DB36B;
	Sun, 17 Nov 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731884366; cv=fail; b=nbboGbHe7ZlAkuoeiqjLJqprV2JFsO2ZIxbt0BLRg6kepjEP9hzWyhgYm0bRLF0gKLFwtaT0adNsB788xC0Hcp96QLi2hBDuazYt2rBgmIVPGb9GZej14zcBYdprASAJsgmkq0iGlqwjTjWNeCiBURl6+WTFMc2brAR6mV17TBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731884366; c=relaxed/simple;
	bh=mzIpFdA4dtKAeYVFa6ag7vzm1Y9dIEyaNAU5tKPwybk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HlMnmAOMDggoUa+bChBQGklDlgCb1HwCbPEVcDAZLpylq4oujfy5xLiXc7FlMDlW2oHhiA1lNj4q0+87AIKZ0w+RlqzKpQ+6kVB+xrY/If5VOeNQddPwCV089yg/6/5LedkeqCZft2VICzTmOvSzkLYz26kEAdzG/n/tmOFr7Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mwxf/H2V; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AHHxY5x026330;
	Sun, 17 Nov 2024 14:59:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=mzIpFdA4dtKAeYVFa6ag7vzm1Y9dIEyaNAU5tKPwybk=; b=
	mwxf/H2V9YjnJc5nFg4nxSZCjNzLKMIZGfRHw6vqhb7S7cgalEmpX58fz53q+x02
	wjHoMMQC4FAkHHTCATb9LagH9UQWlQdfc/FgYqbDKF/itB/nyTfAUveYXLFK04iu
	Jq/sf5nYCCyhTh0KymZ5kbTWOd1RoaFv/DSIqoI2on38+ci4MSrMqGm834Iq/41g
	uqAz8zL73shaHSd4zA0Qmm/1M0ySbdb7epYYE1tt2bHXGGRZt4mFHyIA5zOmXf/I
	ehGj/NiOUcVZtLtYueqKqfKOcg6GZp5KI61xztiHEfOOgmuJJK3x93eV4jUb3l5X
	CJY3LuX5YIwjPdbEheorpQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by m0001303.ppops.net (PPS) with ESMTPS id 42xqy1dr02-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Nov 2024 14:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBD+RpZ96taabtEDqaHydxYbzJNNqajroFdAE4f/q+3OvXTB6/6bLyIR4yAh9zzfQIrgfULBrYLUGdQn4ZhriZIu9PAWMbc+SV5xLCmaa/pcxXMkJvOHdFnswSy9dHTl6D7o07vf8LXQUbTxg0zhCEUfzMdAh6q7bu/VrYa248Nh5cDstOANtULwuYuZpSckTpqAKbjGs8shY8sRuW3r7uYHV/tLS/+YMQl8Zd7WqNAf/q/xqOUwLHCznu3k1lyYQiGbAaiZvy9EWL+U1/gaSOmytPtRrrHsK51HUYNIWLm3O6lT4wbDogMqJNSfzqhI4Wj1az17B8Him6XUHAgN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzIpFdA4dtKAeYVFa6ag7vzm1Y9dIEyaNAU5tKPwybk=;
 b=DBn5iOEYOO18nYQcUiidVAap4QkWjqXgyf4ktKuBBPyKSD+ubUHh0o7oANVxEwB/sy5q4MN80gQ/Rs4n/tnp6ny/pdEMW8D7/lYlWmQq54TjRekXIpWlk+07wObc3G0uwyDMPznZKDkWxKt5XBczBv5giunjnp2fpIgAZObAXEv5FIKk04cndsSHRakixG8NbQOyj+inydyWdzLQ8WD3eSAA44DAetj3NTu3jc4m4AYXGRbnWYwcvVS5crzFQk839bVeARGsacM6kRAP/AJa5eYKwTUR2ugafHAtRp4yyzIT0NsOMslBwTb9GGF60Lh7z3sd/FEPuB3FJCuQb9kSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3926.namprd15.prod.outlook.com (2603:10b6:5:2b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sun, 17 Nov
 2024 22:59:19 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8158.023; Sun, 17 Nov 2024
 22:59:18 +0000
From: Song Liu <songliubraving@meta.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>
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
 AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7Kz8jgAgAAJuQCAAGvfgIAAB6yAgAEUSoCAAA4qgIABaxuAgAAOzICAAAqvgIAAPekAgATKdQA=
Date: Sun, 17 Nov 2024 22:59:18 +0000
Message-ID: <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
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
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM6PR15MB3926:EE_
x-ms-office365-filtering-correlation-id: d06a93f3-e1db-4450-9e24-08dd075b77c3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emxEb0RhSDYyVElHQnVoR093UG1RQkY5VGwyUStrWUFmWE01TXB6RDVVYncw?=
 =?utf-8?B?MUdtMUpiR1hqWEx0ZVAvSHBwYVBQNktmWEZEcHpuZ2ZvOW5HbDBDYmhmVGd1?=
 =?utf-8?B?cURYRmtSWFJ1UnlrOVpQUk9CTk1wUHRDSXpINlF2T1o2Vm8xQXVHZzFzQkRB?=
 =?utf-8?B?Z0ZkSm14TnI1TTVTMVpoRVNNTjljSWdYSEJ2UHFrbGRDWHNGZXBadFJlY3Z1?=
 =?utf-8?B?OGRURXlaZjlMQnZLQnFXSzlrR0cwVTJibVYwV1V1SERRZ3RUUm00dmRNNHZt?=
 =?utf-8?B?OGhTSDI1VTZIcm1qcTdDOVpxaUZtelhBemJDNU1uZjRSNjFqOXl5ZVNlbHNi?=
 =?utf-8?B?b2l0YTJSRmFZeWxxNlJlbzNTUFBrUjZaUlpiczRiRDBzUGRKRkpseGpCMEYw?=
 =?utf-8?B?enB1dnB6bGJNNXVMMnpQR2tFdlJxclZMRE8ycVQ2NUt1MFEvOGFJK3JzSjN3?=
 =?utf-8?B?cVZYdTY5YXFHY0x4dHZOWkVBandZaDF2d1plTzQvVEhqL1UrQTV3Q0lWNHh2?=
 =?utf-8?B?SnRUQjNIVUVBNVRydHFJbEQyQzJ2N1o0U3ZhUXJ3Z2JBcjhYYnQxNXQwbHlp?=
 =?utf-8?B?TWhMejRVcm04QVpFNEltek9DSWVVUExvWnRObjN1QkVVUi90N3NIaWh4VGMz?=
 =?utf-8?B?T2ljdzZCM2FEMEhhak91bk0zdXhwc0lkZ2pKZEVpY2dwNTRUOUFIYkpxMXpi?=
 =?utf-8?B?cFRFaUIrSCtVbDhUU3pQTkhrcmpkWWtQMldnWVBkVy8vMHY1NkpVVTNWeFQ5?=
 =?utf-8?B?d2ovTDlZNkhmejFFNUZYSGg4Ly90MndmL1BCVkFIcDhiL0U4N1ZIZ1Yybm5a?=
 =?utf-8?B?Z2dKVXZieUg0OGtQVGpyZW91QUF1R1hkdGxENDJUNG9QVzVuR2F2QnJHdWVm?=
 =?utf-8?B?OHVjYTZueVA1SVk5cW1UVDJNMjRVdkh3eWtUS2d4Wjl4aVJIN0EvWG93NEVM?=
 =?utf-8?B?alhONm95YUhmZWxydGJZT3dUSm5hZXJBRnltOXd3QjAwcmtVZHpkVEg2RW01?=
 =?utf-8?B?Y0dVZmcwU1NweExYaTJnKzVZM01oTHpTT0VGTjg3bzdONC9FNkg2SGdzSE1k?=
 =?utf-8?B?R3BRSUsvbllLK09lbTNLU1RpM0k5RXduOVJjN1JYTnJ0MzIrdUI2OEgxajNO?=
 =?utf-8?B?RnRQTUVlREgwd0EyUDQxNWd1b0hRbjFNS1B4UUJKL0pLaVhtUUozZllhcTE0?=
 =?utf-8?B?MmlIWXpjelNzMGlqakU4VjdrclR6aGxMa3BJcUZhekNaNlFZaU83ZUxTcDN3?=
 =?utf-8?B?aXl1ME9WeW5GWDBTS0QvWkMwY0pTbFVVOWJoRGt5RkZYTnljZjJrTmZQZEtW?=
 =?utf-8?B?elBwbFdReHc4cm5BRm5VYk9WcGMyYzNDbENhYm9KV0ZPaXRpZnFzbXJwU3Zp?=
 =?utf-8?B?b0FHWU14QytrOEkvanc4WVNmdmRYOWE0YzNtNFBlc05FSEE1VmhIYkNFSTJv?=
 =?utf-8?B?WEgxSThLU3RuZTI0emYrZlA5aWp0dWlsNGRuMW9Fd2cyZVJvdXVpN25lV1o3?=
 =?utf-8?B?Qi9VOUNkR3pwQWlKTE1rRmRXd0JuSW5OdVloQmxBQkQxb3I2ZkJpSTdhN2lu?=
 =?utf-8?B?K2VBOEVJcTJ1c1FGQXhWcnVMTmFxUGVxM3lhR2Q4dzBFVUpJYkZ4b0RlRmNw?=
 =?utf-8?B?OTZMYzJtNElZbDd5UGFrZnVwOHdvZnpISm8yQlMzU05MdXNrNkxNcGQxUTdj?=
 =?utf-8?B?UHdReDViQ0hjZHN6U1ZYZkpCcklPS0Y0OUEyU0hrUnN6VEhGa3Bhd2s5NDJq?=
 =?utf-8?B?YytoUllDY2pKUzgxZUJUT2U5QWZSdkN0RlVwRWVURGJaN1BHTnNheHBUZkhD?=
 =?utf-8?Q?+6b+jMaVxvCGL1Ey9ZkDW8MmyNJv4GLGA8KK0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFBEaWZtTStUb3pjV1RGZEwzWHQzcGMySHJxM1RYSG1PRnA5WHl3R0RHT1dJ?=
 =?utf-8?B?dmwyRTZBaU9EYXZqaTJvdGkrdytwNDJYY2tBMEJNVmUzbUE2OG42bElvT2Jz?=
 =?utf-8?B?MXV4bTRBNWo3Uy9NandJNmZyZGRkTmhVdG1oQmRnNFEwdEF3UnptSmZ0NVJV?=
 =?utf-8?B?cXYrckgzNGFDOW5Ca1l4MVc1TnpNaktaQWYwL0MyZjRndFFnWXU5TmFTamFp?=
 =?utf-8?B?U08wMVZiWU9KdzJVUS83bHVOQzdybzBQU1VoT0ZCa1BCTDg5NWVod2taVGRu?=
 =?utf-8?B?YVh0UzFYUlZQY2h4SDN2TEtlTDhTTk1UK1JQMUlmeWVESlpIRCtOMWRMUGVT?=
 =?utf-8?B?QTE5MytTVWxVTUVIbHZoTG9xekRqRnRKMERGZGtQTzR0bjFNSkZTbEZFZWgr?=
 =?utf-8?B?aU1weHVvSVo1dGdjL0FtTFhUMllsdWQ0Zy9scnozdDVTcUJvSXFxbkhHaGY3?=
 =?utf-8?B?dzVJaUNOVkxleGFSUDVWMVZ4ZFNGQlBjSGlTamZtM1YvSit4c2xwVERxa0J2?=
 =?utf-8?B?NU9SUXh4L0FlSmNySFByNFphWDFRbkFsbkFvV2FpR0xSaU5XOHVvYVZYUURr?=
 =?utf-8?B?c2FGckpsZ2pRNzJRaTFvUE9RZElLRzY1MFh5MzFHUkxMaUZoYlJ2NThrUzFS?=
 =?utf-8?B?OVVHek5mMGlwY29zZWNUUE9RMXc4THRxYWNFNXBmNExueUp1U0ovdlI2UjhG?=
 =?utf-8?B?L1pYelhaY3FYakUza0pCRTBTbkZwZks4a3BxQmhKUTNJUjhXRzhJMVpaS1Ro?=
 =?utf-8?B?L3BvcnZDTVplWEREMFJ6Wm5oY3RtbUJwWUVHcXJtUDJpK2dlNE9obTQzeS9i?=
 =?utf-8?B?WjAvLzByT2RCUCtiK1lWcG5JaldnN1cwRVRwWmRsWk5qVk80QXh4UzZQSGNx?=
 =?utf-8?B?TW5sWUxLekVSYUpEa0FDY214cmRUdHZvWU55dzBMSDczRFN6OFp3dlkweEIy?=
 =?utf-8?B?WlJuOHdJai9Rckw3ejhhOE9VOXdweG1hWUszMWZuUjh0MEtXRjY2OVdudXJv?=
 =?utf-8?B?QkEzczlBOVRuOFBQWGhoTlVKSW10VWRtL3Vkak5PYkhjUFYybGhaUlRkTTFZ?=
 =?utf-8?B?QVRaTFVzNHJjM0M2azMrL0p4ZDFBQklhWTV2dUVpcXRaYVRrUFZPWDR3Nk40?=
 =?utf-8?B?STRzS2xHMUlSVEx1cjYycHR6dnJIcHVXd1pvWGI1Z0F2V0RJQUMrWnhRWFpj?=
 =?utf-8?B?U0orL2h3cVJzVWh3U0xhYnowd0taRTU1bkdDaElHeThEMytKUmtvYnhpWUJu?=
 =?utf-8?B?OVFBd0dNb2ZzWnRJRFBQdDVPY1hpckJKalVQQ1ZpWVJJQ3cyMVF3UDZnTWtC?=
 =?utf-8?B?REtxa1h4R2hLUkxSUXdFTlVkMmk0Y1FQK1ltSWlOdHlIaTIxc095bW9VZVYv?=
 =?utf-8?B?ZS8rRGlRODRncXptclMvM1dsVzNGNm5zVWp3UGNxd2xSWTc3cG5jQURLNGRR?=
 =?utf-8?B?d2NqV1kzZzI5T3ZLUERYRWd4akVzOTZtWWRDOVI3OGo0M1dNSUp1Z0h3bmJh?=
 =?utf-8?B?b3RsRlYwOVhtczBycmZaWXc3U29pbzlRRXVuREx1WFdyaUtlVFJaTXVrZWhk?=
 =?utf-8?B?d0dsN1BCS1czamVXSHBWbHRLd3NuM3ArNHhkSlFkemlLTDgwc3hINmdqZUhO?=
 =?utf-8?B?MXNyc3JVdGNwc0NVOHRLYllONGN6b2lKRWl1UlFvRWp6WTR1YkI0a1Y2M1hV?=
 =?utf-8?B?ZGpyeUNaTEQwWkJaQ0FwS1ppdEFQSmdabUJWd0x3ZXJKK0F4dUEwTjI3ajhh?=
 =?utf-8?B?dGZmcWFydDNNQXYwVVR2ZVNFWElqSWlKR3VGZmcybkNEamVwaEoxeGh4ZTU3?=
 =?utf-8?B?SHFYL3dwRzUrOERtakdxNzFxRnV0WCsyUWl2T0NzeWI2cWFTaWMzODQvdUto?=
 =?utf-8?B?YU5HdXZpVU0zSDBDU3ZqVWY3Z25aaE9EQStnVHpPdUUrNTd2dlhFdnlNeTVT?=
 =?utf-8?B?QVpPNXUxSVlsL25IYVVtcmIwTnp4YzE5R3o4QkhraVV6NThhYnZSa3pRM1Bx?=
 =?utf-8?B?TitMeFowMUdCenU3M3dmVlpkSTN3cEswQ0hZcnBmbWxRUTlkSm1Od0d3di9u?=
 =?utf-8?B?dlJzQmZzaGVPT21IYWg5OVJobytYdzh0dW56M21FejlwaUJwYUhqQ0pyMnJS?=
 =?utf-8?B?UlBhSTlRUHhQbGh6alFNSEI5R3lmNzNpREpvV1ZXN2dtT1gzaXUzNkdlemFC?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8ACF54598B132F4182EFDB958449CD15@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d06a93f3-e1db-4450-9e24-08dd075b77c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2024 22:59:18.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9O6DQxNfdSv3nC77WY5QPG3nWFpN5pSmGTkd0U/pbpCWNErnRnHXfEHNg8SX4tuek9DS4ZjGTWa/hk0uTVpSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3926
X-Proofpoint-GUID: YIdDzRtwT_dmBa-EZFIS0U9Jk3DesALL
X-Proofpoint-ORIG-GUID: YIdDzRtwT_dmBa-EZFIS0U9Jk3DesALL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

SGkgQ2hyaXN0aWFuLCBKYW1lcyBhbmQgSmFuLCANCg0KPiBPbiBOb3YgMTQsIDIwMjQsIGF0IDE6
NDnigK9QTSwgSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNo
aXAuY29tPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4gDQo+PiBXZSBjYW4gYWRkcmVzcyB0aGlzIHdp
dGggc29tZXRoaW5nIGxpa2UgZm9sbG93aW5nOg0KPj4gDQo+PiAjaWZkZWYgQ09ORklHX1NFQ1VS
SVRZDQo+PiAgICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICppX3NlY3VyaXR5Ow0KPj4g
I2VsaWYgQ09ORklHX0JQRl9TWVNDQUxMDQo+PiAgICAgICAgIHN0cnVjdCBicGZfbG9jYWxfc3Rv
cmFnZSBfX3JjdSAqaV9icGZfc3RvcmFnZTsNCj4+ICNlbmRpZg0KPj4gDQo+PiBUaGlzIHdpbGwg
aGVscCBjYXRjaCBhbGwgbWlzdXNlIG9mIHRoZSBpX2JwZl9zdG9yYWdlIGF0IGNvbXBpbGUNCj4+
IHRpbWUsIGFzIGlfYnBmX3N0b3JhZ2UgZG9lc24ndCBleGlzdCB3aXRoIENPTkZJR19TRUNVUklU
WT15LiANCj4+IA0KPj4gRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQo+IA0KPiBHb3QgdG8gc2F5IEkn
bSB3aXRoIENhc2V5IGhlcmUsIHRoaXMgd2lsbCBnZW5lcmF0ZSBob3JyaWJsZSBhbmQgZmFpbHVy
ZQ0KPiBwcm9uZSBjb2RlLg0KPiANCj4gU2luY2UgZWZmZWN0aXZlbHkgeW91J3JlIG1ha2luZyBp
X3NlY3VyaXR5IGFsd2F5cyBwcmVzZW50IGFueXdheSwNCj4gc2ltcGx5IGRvIHRoYXQgYW5kIGFs
c28gcHVsbCB0aGUgYWxsb2NhdGlvbiBjb2RlIG91dCBvZiBzZWN1cml0eS5jIGluIGENCj4gd2F5
IHRoYXQgaXQncyBhbHdheXMgYXZhaWxhYmxlPyAgVGhhdCB3YXkgeW91IGRvbid0IGhhdmUgdG8g
c3BlY2lhbA0KPiBjYXNlIHRoZSBjb2RlIGRlcGVuZGluZyBvbiB3aGV0aGVyIENPTkZJR19TRUNV
UklUWSBpcyBkZWZpbmVkLiANCj4gRWZmZWN0aXZlbHkgdGhpcyB3b3VsZCBnaXZlIGV2ZXJ5b25l
IGEgZ2VuZXJpYyB3YXkgdG8gYXR0YWNoIHNvbWUNCj4gbWVtb3J5IGFyZWEgdG8gYW4gaW5vZGUu
ICBJIGtub3cgaXQncyBtb3JlIGNvbXBsZXggdGhhbiB0aGlzIGJlY2F1c2UNCj4gdGhlcmUgYXJl
IExTTSBob29rcyB0aGF0IHJ1biBmcm9tIHNlY3VyaXR5X2lub2RlX2FsbG9jKCkgYnV0IGlmIHlv
dSBjYW4NCj4gbWFrZSBpdCB3b3JrIGdlbmVyaWNhbGx5LCBJJ20gc3VyZSBldmVyeW9uZSB3aWxs
IGJlbmVmaXQuDQoNCk9uIGEgc2Vjb25kIHRob3VnaHQsIEkgdGhpbmsgbWFraW5nIGlfc2VjdXJp
dHkgZ2VuZXJpYyBpcyBub3QgDQp0aGUgcmlnaHQgc29sdXRpb24gZm9yICJCUEYgaW5vZGUgc3Rv
cmFnZSBpbiB0cmFjaW5nIHVzZSBjYXNlcyIuIA0KDQpUaGlzIGlzIGJlY2F1c2UgaV9zZWN1cml0
eSBzZXJ2ZXMgYSB2ZXJ5IHNwZWNpZmljIHVzZSBjYXNlOiBpdCANCnBvaW50cyB0byBhIHBpZWNl
IG9mIG1lbW9yeSB3aG9zZSBzaXplIGlzIGNhbGN1bGF0ZWQgYXQgc3lzdGVtIA0KYm9vdCB0aW1l
LiBJZiBzb21lIG9mIHRoZSBzdXBwb3J0ZWQgTFNNcyBpcyBub3QgZW5hYmxlZCBieSB0aGUgDQps
c209IGtlcm5lbCBhcmcsIHRoZSBrZXJuZWwgd2lsbCBub3QgYWxsb2NhdGUgbWVtb3J5IGluIA0K
aV9zZWN1cml0eSBmb3IgdGhlbS4gVGhlIG9ubHkgd2F5IHRvIGNoYW5nZSBsc209IGlzIHRvIHJl
Ym9vdCANCnRoZSBzeXN0ZW0uIEJQRiBMU00gcHJvZ3JhbXMgY2FuIGJlIGRpc2FibGVkIGF0IHRo
ZSBib290IHRpbWUsIA0Kd2hpY2ggZml0cyB3ZWxsIGluIGlfc2VjdXJpdHkuIEhvd2V2ZXIsIEJQ
RiB0cmFjaW5nIHByb2dyYW1zIA0KY2Fubm90IGJlIGRpc2FibGVkIGF0IGJvb3QgdGltZSAoZXZl
biB3ZSBjaGFuZ2UgdGhlIGNvZGUgdG8gDQptYWtlIGl0IHBvc3NpYmxlLCB3ZSBhcmUgbm90IGxp
a2VseSB0byBkaXNhYmxlIEJQRiB0cmFjaW5nKS4gDQpJT1csIGFzIGxvbmcgYXMgQ09ORklHX0JQ
Rl9TWVNDQUxMIGlzIGVuYWJsZWQsIHdlIGV4cGVjdCBzb21lIA0KQlBGIHRyYWNpbmcgcHJvZ3Jh
bXMgdG8gbG9hZCBhdCBzb21lIHBvaW50IG9mIHRpbWUsIGFuZCB0aGVzZSANCnByb2dyYW1zIG1h
eSB1c2UgQlBGIGlub2RlIHN0b3JhZ2UuIA0KDQpUaGVyZWZvcmUsIHdpdGggQ09ORklHX0JQRl9T
WVNDQUxMIGVuYWJsZWQsIHNvbWUgZXh0cmEgbWVtb3J5IA0KYWx3YXlzIHdpbGwgYmUgYXR0YWNo
ZWQgdG8gaV9zZWN1cml0eSAobWF5YmUgdW5kZXIgYSBkaWZmZXJlbnQgDQpuYW1lLCBzYXksIGlf
Z2VuZXJpYykgb2YgZXZlcnkgaW5vZGUuIEluIHRoaXMgY2FzZSwgd2Ugc2hvdWxkIA0KcmVhbGx5
IGFkZCBpX2JwZl9zdG9yYWdlIGRpcmVjdGx5IHRvIHRoZSBpbm9kZSwgYmVjYXVzZSBhbm90aGVy
IA0KcG9pbnRlciBqdW1wIHZpYSBpX2dlbmVyaWMgZ2l2ZXMgbm90aGluZyBidXQgb3ZlcmhlYWQu
IA0KDQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8gT3IgZGlkIEkgbWlzdW5kZXJzdGFuZCB0aGUgc3Vn
Z2VzdGlvbj8NCg0KVGhhbmtzLA0KU29uZw0KDQo=


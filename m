Return-Path: <linux-fsdevel+bounces-61768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA418B59AA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7713E462FE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9823375B5;
	Tue, 16 Sep 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="nZMU+u6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B7334391
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033506; cv=fail; b=n9UmpmzMe7JZ6jCM2Wc43+dlXPcujllo/JhCnK6ToWMrRZR70vcHunvNLws97QxkwjDtkrIF2dX31Xj44mFYoZ7ILRFrrVEqEr9K8kLu8x5Y6JwuSqsVI+f8orwdmSRyff2xUqE4De4T508Fe829PFhbeChtuUjwMJge+O1/f+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033506; c=relaxed/simple;
	bh=kEnbR1/s4tHxzcwTz+fBfrqfQpEKjMIQUnOghWfxPvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mp1Kezd82xpVZqvISh8N3d98P5oUh8V29+o7EZoOorWJ7wd3zMvFHkxtpsxCDqopoD8RON9JUwuQNL3uv7+x/wAQv/4XNEd/J2b4p1MW5qujx3JQ1XdTSzMQyTXpDboad3jmrc+bJ/gLrNtbSsYa5LZBGAI3qj0GpGtuGH53Uo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=nZMU+u6W; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108]) by mx-outbound19-125.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 16 Sep 2025 14:38:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6Kr7lY7W247bs+nO4kIrjASgI7L5r8Tlha11f3cWg7R+VTHXsQKTxEcPu9PYjTCBRx6eLRB5cIMZS2y96pK8kMXQ0ojeypixWTGLlDkm2G2f+nj5vE+UbyGaFH0Ux6DiTtxNZFP0MXT1b+RH9D9+cOS5OewdFCkwGg1leksCOIKkveChSYyKOfDH0fJjmYIDVFVJsYpVoA6Fuf/68RbaE+adF4zmvwpCRd25tWILTe4U6f/C131FXjqks08q1mWGMHrTEuxlH5ykKY3/FNaS8I/IYbGE3yWhZ8dDFZHi7tP4u8kg+nhXxrjzwZKQR/Gmqgk0Gke+PQRaY15BxupQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEnbR1/s4tHxzcwTz+fBfrqfQpEKjMIQUnOghWfxPvs=;
 b=TzwOG2z6HKwfETSVzvi8+mVV8qWnz5UTCdKWfkhOGKqdQ4JvEsZCdCMtBcUxuG/Gl3+R4aaq53zAThf1ZRBBkDty6eCt25nP5W60bjxUSIu+To69L6taPkkQ9dSbXQs8F6Ygf7s2pklpBPdkd0SsoLXONTlUE3PHUXr8o0N55rOxsXkvOUL6LPiaqNxvdn5+cA+p9MEKjVjcFt8/DhHnybXcV8ZPac4sf6Ze2ceF9YCdk+t1jXAG0k09IuxvprOHZ3kRGXZcOLH1z1aR0RspFfBC8noTdCCe+FB+LGjdqB5kTxX7mB+4qWqME2zhZY+M1cClxQ0FlFCC79M3JLeVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEnbR1/s4tHxzcwTz+fBfrqfQpEKjMIQUnOghWfxPvs=;
 b=nZMU+u6WB83ZaOaW72nWqrnAxjhXfNYf2NGpy7w+Pw8n5LtqijujzQS+9OaC7GgHoHhcYYhui4hUk1A2AeeAEbQd0XFTrRpL/cLMiutoWMGH24k02qfg2OPIE1lzQzuLeBoG+qvxICP1TezSvUlnmmV8npHPdC0SPcO2soGvoCg=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MN0PR19MB5849.namprd19.prod.outlook.com (2603:10b6:208:379::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:38:07 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%7]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:38:07 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "John@groves.net" <John@groves.net>, "neal@gompa.dev" <neal@gompa.dev>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>
Subject: Re: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
Thread-Topic: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
Thread-Index: AQHcJqKytBrjrKfVcEGSiwQZ2x8pGbSV4cEA
Date: Tue, 16 Sep 2025 14:38:07 +0000
Message-ID: <22f77d71-03d3-486a-b3d3-0532804aaaf8@ddn.com>
References: <175798154222.386823.13485387355674002636.stgit@frogsfrogsfrogs>
 <175798154240.386823.11914403737098230888.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154240.386823.11914403737098230888.stgit@frogsfrogsfrogs>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|MN0PR19MB5849:EE_
x-ms-office365-filtering-correlation-id: b00b23fc-0394-4eb6-c992-08ddf52ea6de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXVKMTQwUTJzRTk2QkVHWnptcUIrSXFHYnBVbjAySDEvdlYza3FtVkVkeTFG?=
 =?utf-8?B?RjN4RzRtYW5TaWJUajdldGlxb3M1VGJodElvVGZpZGNUVm54RCswZFV3Mmpn?=
 =?utf-8?B?UDNXVFZFenVkUmFaSzQ4RVIzVURwdk1GWXdMZTRVSThSalYyVlZVQW92OTZE?=
 =?utf-8?B?UEczdFZvcXVSSkE0ZUNwcFRxdHcxQ3JPMm1INXloMzJxTjJ6Y3pCbkZXLzVZ?=
 =?utf-8?B?NCtoWXRsbnNzM3N3UXJNcmF6S0w4QkF3Z1pqUFkyWEo1TVA5aWZOTXkra1k1?=
 =?utf-8?B?VWJCV09Dc2JuM2FtRUlFcDhYdVZ5VHl5Tm9XTjdwdlZhYWlZODBuV25kd0ZL?=
 =?utf-8?B?Z2hkRVVyYWV6aHRlcW5DeWpYaEpEaUNDUFpZOENScCs3WC9uM1ZnV1ZHd1RI?=
 =?utf-8?B?VUIyT201dExQZlVPbFBqMXUrSHk0SHAvS2I1cFhyRWJPNVNuSWkwbFZFekVI?=
 =?utf-8?B?YnVPb2FHMHRnOVlKVHlFWXg1cjVFZ1pKc2VsTktIczhSeGk3dFJzZUxXVllK?=
 =?utf-8?B?M3RYeEU3R3loR2I3azExQjg2MWRCRjZGeUFYZVhiNnU3eExrOFFWbHlwbkpj?=
 =?utf-8?B?SllQWFE3MkREUjh6cVhtTThMV2ZPSU9DaXd2UkxUUkxRUUxOcnhObGpPZXRh?=
 =?utf-8?B?anJ1NlBVWDArZzVzQUh0RW1KSmNXMHpUK0hHaUU3L3NGRHFmRk96cG9IVlpM?=
 =?utf-8?B?eXc1ZmhpVjBOaVhqUXBvcGVZL3l1dEUzK0FCcldySWdLaVNQY1R1c3hwZ0E4?=
 =?utf-8?B?Lzc4V3IvWjREV3ltYXBsWHdadXRZejl2NkxoR0FMOGlqc3hjdURVMXVqM0JG?=
 =?utf-8?B?bkZNRGtsY01nVXZCYXFZamxRQkYzelN2Mkd0UFFrVTdqZDhVR280czdBallN?=
 =?utf-8?B?RUJuc0hSUG1QWGkvN1ZTOHFsZWJnNDNtbm4zL2NSb1BUc0J1VHpWVWc5cmJj?=
 =?utf-8?B?ZWY1VzBuS1Q0elM2ZUUvdlJROWQySHNRTC9pbkNsZHIzSE16QmZjMERaK1I3?=
 =?utf-8?B?ZTRwclY2MzA0Ui9ySFdkSjkyWTNaQWxyd3hvSU05VVg2TW14aVN2R2xUbnVi?=
 =?utf-8?B?dG40ZVM5cHBxSllOVjlYNW9WQWdqMS90Z2tlNmxVbDlPcUNoN05Zb1NjV2hr?=
 =?utf-8?B?REJnRC9VbU5pSUZUZG53Kzh5Q3BjVDcvNHg2Ui94eUtNMHpKUjNkaGVrbWti?=
 =?utf-8?B?Y3RLMTdiRzBHT3R4T01wQjJDUTNkbFllM0dnWDh5bG1tMGpFT2REajdtVE1u?=
 =?utf-8?B?SVZBNWFhc3dhL3poeHdmK3VHNmJZcU1TcDk1UnNEbmdGRkRlTmdMSEtXSFhq?=
 =?utf-8?B?bi9PQ0VUZ2Z6R0laZjcwdGNNdUdVZDRYaGV2RlAzMFVkejNvNEpjZFZGdHhl?=
 =?utf-8?B?M2pFR2pFYSsrSFVFdGlIS2xmRGNLUkVCcmRYczVISUZpdCt6NTJyT1hCQXdm?=
 =?utf-8?B?TGkrK0xCVGVsMkdJWE9zbTZsM0d6cUgvQ3ZaZDZxblhrQ3N3dDdNclFKZlNQ?=
 =?utf-8?B?NXcySGpRa25EaEt6aG9teGZzQzZTaUM2dVFQK2tvaW9seHZ3VXJKYmpTMFAw?=
 =?utf-8?B?cXRDek0ybWs0ZXZ6WDdLUTVSZXZ3U1JmVnErOWt4VE51d2t5c1VnV0VpTDd2?=
 =?utf-8?B?NHpBdm1KMnJhVEJnWnNWZUJxQjl0YlNZc2pnM1gxRFJuSDBoajZDMzZETXpY?=
 =?utf-8?B?L3p1RVUwRkxZNURUR0VweUs0ci83QnhWeDNsN09YbmxvYUl2dmFWdEdpTUJ6?=
 =?utf-8?B?TmNwNzVON203UlUrUjJLbDRSc29qVUhFZWhBZkswTnU0dWtFdUc2cnV5MmhV?=
 =?utf-8?B?dndkVUU3Vi9oM243V292bDVlWW9LN0kzK28xS3V6MGlZWHVkdnNSdXVpSmlp?=
 =?utf-8?B?UlB0RmJGeVE1eWFXbjZpSmlRUUFiRUNQWG1zVmZOdC9iMGFOcU16ckNYc1Zn?=
 =?utf-8?B?U1BycnlKY2FjS2NXU0l5VVQwT0lIU21iY2hWSDlmSmF4KzdKWWdBRUxrdHBl?=
 =?utf-8?Q?XOPIWod4IUnC5FXrYSqVeFyDStqYs0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2lKR1oxY2U3WTVKd011bWx0bGJoREI4aERWUFJCM2RmU3VQeXJFNWZnYnZY?=
 =?utf-8?B?YzZBN01xdXhGK0U1dXpqVlZWcnMxWnkxY1RSdE5jYUFNbVIrMmpLdG83NDhn?=
 =?utf-8?B?NU9jbzBXUmFsUVBJOGIrUFRFWHpuNDMwYkpzbXZZMDNOaGgxQi9EKzBoaXlt?=
 =?utf-8?B?QlBpQU5GdlBwelhGays5anptUDZYRHhzellsSGNLTis5V1o0Tks4L21VY1VQ?=
 =?utf-8?B?a1Y3ZXNFak94cWJZU3laZitlUm5rTkpQbUJ6YWpOb0Zra0pvanNsL1hlMVRj?=
 =?utf-8?B?KzZ5K3ZDQlQ2cUFUdDUyb3g2MWZxekFXWjBlNDRLYXd3bVMyck9Sa1F3OHFy?=
 =?utf-8?B?NmNIdHB5LzdTMDJLVW16ZzVmcVNLYlBmQUFOU3JqdDZCcjJINmc1WWNUOXFn?=
 =?utf-8?B?RW1zYnJ6UHl4QWNKVk9Vc2owNlI0TTlmU2VETnR3N1pzNkpmb3ZnVEpEMDNo?=
 =?utf-8?B?cnE4dHZ0TEJsYnJBTUdIMjMwbmZFam5FRzNqeEUxSWZ2enM0ZGN3NmxDTGFj?=
 =?utf-8?B?NlVuZDI4WmxxS1FKbTd2TGJhcWlJR2NvMG9XWThHTEM1WnA1dE1qZjltVFl4?=
 =?utf-8?B?VmFCc3BKMzVmSGJadjQ3SFNrTFBVYXpCaU5pRExyYmVyY1JkaUZ0ZVpGTWdi?=
 =?utf-8?B?am9ZdlNMaXB1aHJULzVpdW1VNXJUbEcvdTE4Y25jWGo1dVhobXlLRFZDcm9V?=
 =?utf-8?B?OUVvbTczZXB1RHYveXVIejZYU0VjbmYvYkMybjNzV3dlelRLUmdXVWNtV1Yv?=
 =?utf-8?B?enBxRTVWTkt6bkl1M3M3YWdhYUZ3RDRrK1U1R01uTWIzOXQxVldPK2JudS9Q?=
 =?utf-8?B?TXY5QzZDZ0NEaDlZVkQ3V3BnSVdkK09GV3dwVy90UFljT25mYkxvckl3TzNH?=
 =?utf-8?B?Lys2djNOUnEvY3BMNFM4MGxTd2V5cHZqeG9sMVdYSDdGZ3o2cEpXOUMvTFBZ?=
 =?utf-8?B?bWZiVkZYSkUvOEdtdGlLTE5uWGhZNHhPK2E2TVNFZmpjaXNEQXIybGhXMUhw?=
 =?utf-8?B?R0lUMHlmcUxnRHEzTzlCKytVNjk2YzAvZVVjZnBzZVFOaU5heWplOUxGc293?=
 =?utf-8?B?cGhsTjJqeHlCZ1VRK3Nnb0pKR0ViRFpGeW1sT0ZMMUVIcWJTTStrbk4rNWto?=
 =?utf-8?B?NzR5OTdQZks4YmMramQweXg3T2dCS21ySzd1eE5tR2c3NjNJZ2p4eHFxUVBj?=
 =?utf-8?B?dXd1OU1BZm1TbG9KWXZkajg5WG5DZi84aGRXOFBqOCtpeUhsUVhSNXZqeWRG?=
 =?utf-8?B?TlgzSGxFb0ZrUkF0RHBUWnlrMWJqWnpEK3E0c2plWkxXNlh5a3ZIaGhJeWx6?=
 =?utf-8?B?SkUxcGU2ZmQ2Rjkzb29qWGtaUGtKWGFlQkRad1I3M29JRHZPK3N1bDh4dzUr?=
 =?utf-8?B?ck9KR1Y5R05ud2dTc0NBNjl3Y29rRlRkdjB1aEphd2FhSWtIZzhzN21JQmJE?=
 =?utf-8?B?UzJkSlNIK0h0L09qNHJVU1doNG9tM3lJSjVNN1hrcWF4V3VoQ0p2ZWpSY2lS?=
 =?utf-8?B?Szc0SmxpQWdjSDltNXV6VFJnclY3RzBucjh3QUFzbGZuWGpLRVpYMDhwSURV?=
 =?utf-8?B?Tzl3ck9iaXgwQXhMakN2WnZGb1V6c3pwdzR0WEdZdHZiZWQvNVhuTUdnZG9J?=
 =?utf-8?B?WDlKQTNpOTFoaExMbklHZW5LaE5wOW91MUhNNmVlNnZLTE40NUV0RkduYWZz?=
 =?utf-8?B?UTFWTXdGVldqNGRpY0w1Qnk0REZjS0J0MFUyc2NybS8vZTZnc1NJdGZZcVM3?=
 =?utf-8?B?VWVXbEc3UktPZDArZFFWcUQ0Ykh1N0Q4aE1FbHVLT2hsL1dUSURBV3dIK2tW?=
 =?utf-8?B?cEROdnAwUHJrMVZsMHlVZWNxMEpCZ0VXbEs1d01RTU5ySDdiZDJNOEU5N1No?=
 =?utf-8?B?M2swWTZ2M0lyL2JKOHozdWZNY2ZkejFCUkhuRW9jWVhBV09Da2RrZWhCbUho?=
 =?utf-8?B?THNYdGZnajZrbGZpS2hkYkFET2lBWHFLZlBwZ2JEbmpuN1FhOWduYXJDc0tv?=
 =?utf-8?B?NVFKb0FyRGN2b3JnSVdqNVpnQmg1WWlaWlJoTG96S2JWc2FEM2hMY1RZMXdH?=
 =?utf-8?B?bGcwemFhVUV4b1dJVmN6Lzh3aDhveEUzZTh3c0NKN2EvbDVjYkV2eWRYbmRs?=
 =?utf-8?B?VkVvSUJTTXQvYmliZHc4d1hUYjRVeERLOTJPTUR4V2Y2NVR1NUxaTVFvVEpC?=
 =?utf-8?Q?u/kl0hECwdrSQN5MNByljXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F95A1F17A10187499C0A051BB89B4FC1@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pht6eaSLpx0APbm7BOsuLp4St0FDODVVQEwNt6i0DYOvci6wXIo3SbqlgiJUcLjxWNNH4WQ4kGziI9l8aEvl7T8VPXGdLJCtgLkq/+PBc8GfpUHUda8uhyV4/1FCrNbbAIkqJPwG+tsIZQ//AAV9/TwKj/G49WvbLdfNduDUOdKsBUuQITy1bWKSMfwvKNwG67wZ8kfB7xfA5pm1tD9QDe2fk46YdK2wtODv53Ky8io2NQFrMWLKbgKM3dVlM0LGLHJ422uphaIWwZzeJIH5Ky+GUfvind+JQoDSniEUMAq3e1DkY5Ma6Um9ChxxWmira9E6urvxAhY3RPivOSqIDvAKelrTeeTx5snTfDVI+u+uKmGr2vHATbXElhzHD8IKYx8nUlxR70wHDCCnAOJLw0wYfZv7/uyoeeScmy2VFZYLdCzwp7fpjBTXgNq8++SPlnGxOsIY4z6LNZy6jBnvbMQNU6gdTjjNT4Bk+R6ksUPRokn2Bst5rg6qqlBxeL5BMFJXfYNccA6i7xptfnV3fzH3qhB4DEyKukpWjcJjlAaNOG4Dp0YFdO02XEhJNS4ADavymCrc5Pd/kNNFwByAq5JwoM2h+IPkupskr+P5e9P4uaGSM0ELm0qi4Ng7BytgWNCHbgWr/fmG8POf6+bF1A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00b23fc-0394-4eb6-c992-08ddf52ea6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 14:38:07.3120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvGGrgXUvzFGc5tDj/5WuTiRseJy2v50Rw6sljS0ooJWVX8YXPrMTuPjtTpRaZcZ6z/ftgVq7+yWsAhgYTMsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5849
X-BESS-ID: 1758033490-104989-7643-3071-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.236.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZGRkBGBlDMzCwt1cAwxdIyOT
	U5LcnYOMnE0tjc0MjQ3MDAJDXZPE2pNhYAH7D1IEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.267533 [from 
	cloudscan11-97.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gOS8xNi8yNSAwMjo0MSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBGcm9tOiBEYXJyaWNr
IEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPg0KPiANCj4gZnVzZS5oIGFuZCBmdXNlX2xvd2xl
dmVsLmggYXJlIHB1YmxpYyBoZWFkZXJzLCBkb24ndCBleHBvc2UgaW50ZXJuYWwNCj4gYnVpbGQg
c3lzdGVtIGNvbmZpZyB2YXJpYWJsZXMgdG8gZG93bnN0cmVhbSBjbGllbnRzLiAgVGhpcyBjYW4g
YWxzbyBsZWFkDQo+IHRvIGZ1bmN0aW9uIHBvaW50ZXIgb3JkZXJpbmcgaXNzdWVzIGlmIChzYXkp
IGxpYmZ1c2UgZ2V0cyBidWlsdCB3aXRoDQo+IEhBVkVfU1RBVFggYnV0IHRoZSBjbGllbnQgcHJv
Z3JhbSBkb2Vzbid0IGRlZmluZSBhIEhBVkVfU1RBVFguDQo+IA0KPiBHZXQgcmlkIG9mIHRoZSBj
b25kaXRpb25hbHMgaW4gdGhlIHB1YmxpYyBoZWFkZXIgZmlsZXMgdG8gZml4IHRoaXMuDQoNClRo
YW5rIHlvdSwgUFIgd2l0aCBhbiB1cGRhdGVkIGNvbW1pdCBtZXNzYWdlIGFuZCByZW1vdmFsIG9m
IEhBVkVfU1RBVFgNCmZyb20gdGhlIHB1YmxpYyBsaWJmdXNlX2NvbmZpZy5oIGNyZWF0ZWQgaGVy
ZQ0KaHR0cHM6Ly9naXRodWIuY29tL2xpYmZ1c2UvbGliZnVzZS9wdWxsLzEzMzMNCg0KDQpUaGFu
a3MsDQpCZXJuZA0K


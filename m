Return-Path: <linux-fsdevel+bounces-34406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28549C50C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8250F282629
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857320C004;
	Tue, 12 Nov 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="m5I5tc4b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BF20B7F0;
	Tue, 12 Nov 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400534; cv=fail; b=L0UZs/NebIAdrVicQlJngdtERqDxxNpSZ51zccNdAI+c/BRlIG0DJzS4ok3jDNFEalGOctxM71BF5/jSWVSQ3AekILGd8aNVU1rKE7ZBtslW0CcSI4Sjj/PDx0AA8KOgC5VEvsjMTZSRzT/9q/0aMFP2pWoaUufzR8bQWFn+D1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400534; c=relaxed/simple;
	bh=zOPWs+ob3aWk1P1ZfW6F7JybAYUo+8QrFTuuqZwQrOU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tgmYAuPfEGasea9ADFtjYXt5JtT0GfL8sJ+Pfz8AFhtY96C1ux0xRiOmxU63mLiBEM5TfBT1eP+tgi2zRtMRLPdB5P0N5bRZWV+vHDQV/639JT0Vwvj7EHF3omYblddFiIDmEFOpgSKoTZHAQj6msTq2kRABaxFv7mIoaE4XaSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=m5I5tc4b; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC6VJ9R012175;
	Tue, 12 Nov 2024 00:35:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=zOPWs+ob3aWk1P1ZfW6F7JybAYUo+8QrFTuuqZwQrOU=; b=
	m5I5tc4bkAA+0peuus3g3L0JeVoq+l9KNs0GfnM9uVrpcVuMzmGQaUmLLfCxnDik
	Ta9nkWslnDq1vxZvCrfGVcYEVZtKdIAalO5uq0tHneqDvdmUDrbb9nHZE+dJRBn7
	zHtB/6fj9NISHYhvJmE1SzJ84a6fYLbllSD1oE0v5vCRpVRpmDqJBUZE2t5JGnMv
	m0rXKPN/egFusnEFRJXQy0p+f2HHRoqRURECJLfMl5Ds/wFN+UR+D92r05cqGgI4
	YcoZGqGQbPVva2fFjLvyMzzqiTss843p7RG6pHQeiyBJ8oYpa+04jPrAHcrRcj2W
	46g2I7bioB/S5WBq75x3lg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42v1ts8fkh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 00:35:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3iUnBD/gVWAJbIc0Vyx6ZIYRZ3YEJrPkBuFdUF8UrVOUXNxOYr2Qakvh7MPgvTDMa1xuemV7LrJR67Ko25rDbWoOcP76x9afwlXZlIjELh90PAg3UJYLBSoM4WIF6QsAyKUIeTZ0+vAI9IzDgOgz4ra7u8Wd5uBPPYwoQ3iX/Z9bGOE5/FdVM7z8W/ZtbNPhadmqLYuN3M6SrwYZykwnYpp1Du14BH+bhPwkP4Kikuzoy801w97qfZVxHclBFcQOLzxXUFFKhErLfHuWjExf8P+KjuS26dZr2ARC26uURj3kS0GbYQR/L9YyrRDFtkcFdTndOaLc7ruoIdq9NRBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOPWs+ob3aWk1P1ZfW6F7JybAYUo+8QrFTuuqZwQrOU=;
 b=UYbaCLFxrOCy5lm9WkkuurHtxdq+uvtYZowwLcGOFOZ9VrJS8CcCKDirJmImXzpoPDvI8mw+6aTIrwiDvgy395RyzqLshZ7HNTUtiiG9r1FyDZpXOpUZSsPTpo0wRvk/eNNece+ykUtwsJG1/2FnPGDzV0dDI+PVAbmthtL/EWKaYVKbZYBMEAyvT6ten9cBs+twZjh6+D+tLdSY3P0F+puZPE8cPGor7pX4Pl3iYE0zhHLaBga7IBCQgJ3JsuL5tbmgJJIsAaT2k/rJNPj+GuhxzuSaSY3N6rv+ngQ8wTSdyKgJiTUQvt3Sk39fMtOMgiq8H7EfziUh8CcDL+6j2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN6PR15MB6244.namprd15.prod.outlook.com (2603:10b6:208:478::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 08:35:28 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 08:35:28 +0000
From: Song Liu <songliubraving@meta.com>
To: Song Liu <song@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
Thread-Index: AQHbNNyP/8kz7bh9sEuMXmmPH8p6e7KzUeCA
Date: Tue, 12 Nov 2024 08:35:28 +0000
Message-ID: <7FA991B7-A858-41A6-BCE1-18A45FD0F1B5@fb.com>
References: <20241112082600.298035-1-song@kernel.org>
In-Reply-To: <20241112082600.298035-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MN6PR15MB6244:EE_
x-ms-office365-filtering-correlation-id: df415bc3-9bdb-4e93-68e3-08dd02f4f616
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?clVSQkEwSHV3dTlLeHl5Mi9JcnU1eExxbG0xeDlxR3Yxc3FlODF0WkhwT2xY?=
 =?utf-8?B?S0grUkE5V2hhRWtoempmUFdZQld0bVlPRlJ6SzgycEJQRTJvblo2WVZ4U1Zu?=
 =?utf-8?B?eEd2eVVUeGFyQkNncXVQZlFaZ3N6N0QyQURlRktzY2diRzF4V0ZSeWxiL0R4?=
 =?utf-8?B?RUtNRTh5anJuWHBid01BMGgwVHQzSnU5L1JDdVFuWWZiY0RRaHl0TEJxeWow?=
 =?utf-8?B?TWE3dmRLWWoydzdrdTlJeVNvajRTeURqeTVlWWdlVW9jaDkySW1vY3paSHhG?=
 =?utf-8?B?WlQ0Rm8wNk9Cb1duVFNiVlp3TEhDVy8vcEFhV09jOGMxckx2bDZ0djJhL3Zv?=
 =?utf-8?B?RUsvUXBoa0gyWWs0RnY0ZjNUY2N6VVphN2J1RXNKVXZrRldHZlhnYU1mSHlk?=
 =?utf-8?B?bHZ5NjEreXFHRGY5cXBVNWZFVm9tWVlHWEpBQVVrYzRLUUhRREJLSXNrWXJI?=
 =?utf-8?B?ZnJDNTJZNTZuS0NaK1RWeE9GU2hyM2wyUkFwOGpSUUZyK1k0aDZnd2JnY2Yx?=
 =?utf-8?B?RTFoSlU2TEtqdWZidng3L2F1ajlmNCtYZmhMUG53RFVlRFNLQVI0WlRVTXVN?=
 =?utf-8?B?T1h2VENFUkdyUjZsQ0IwcXYyUnhnb2hPOTJEWTZuWm1veVZsWXArYmhmOGo3?=
 =?utf-8?B?S3ZGU2huMTZTaEVacUFhL2RtNjFlQmIyK2JsazdDRmY5T3dHbDZBYWY2M3BQ?=
 =?utf-8?B?QndWNk5WN1BHUHUvY3FWalFwZ0l5bk5nMUVKL3E2VkZXaG1saXZpM0ZodjNE?=
 =?utf-8?B?Wlk1MldwblA4SjlFc1pGSGkzb3lIaDQ3TTNUUm9KNUlqNURYZWgydXF4Q2FX?=
 =?utf-8?B?Q1NNQklGT1FnbTU1WlMwSm9KbVJSS2crSHJsUVBNSndJQS9Xb0ZEVWJrUUgv?=
 =?utf-8?B?K0NqWUxTNWFqZGZCMXk2UU15cDY1OURrNXRlN0ZyQTcvZldtVmM2MTVMR2Z0?=
 =?utf-8?B?N3VXNzJaSytnU1VGalBJSmI0cTR2S1QvckhYTitldFlodjRMTk8xa0ZWUWtH?=
 =?utf-8?B?RDYxL3pxTVZFd3BhTE1GSjNxSDFsUTM3ZzZveUZmbDZnY2ZoeTRORVE1djJ2?=
 =?utf-8?B?Ny8zeTZ4eVdmLzBaVGxRZk1aSzJRQ01LTWZ4ak5mU0JSZnBHdFF6b1g1a1VJ?=
 =?utf-8?B?QTlNQ05KdTkyb1hSY050Zjl3NzYxZkEvbWZaald5WHVvZFhXQldib2ZYaUE3?=
 =?utf-8?B?N1JYRTdJUXU4WUM3Ris5V3NldnN3dnlSQlFTMld0NWJSTUZ6akIvdFNDTmFH?=
 =?utf-8?B?c2E3YVl0UjRNTjlxSXVPYVFUaXhxQURTWmF0VjZNVzVSc29hWC8rRlBKZnla?=
 =?utf-8?B?amsvaEhXaG1SNHdwZnFkbEY1RHlmQlZqdWJqbHFmekVKMmx1SG1USWZRWEk4?=
 =?utf-8?B?UFBQWDdmQmRTdU5Da0lvSkZVZFgvN3ExZ3UxNVU0bFUwenBjOEo0NzBQOElj?=
 =?utf-8?B?SEowd1M3MXNib2g5bHhjRDlmRVdIZXVpc0cvTSs5Rjd2NTBvaGZlMnZ2WTRI?=
 =?utf-8?B?bW9qNXAyV0N0QmNqRjZJLzRkTlVkem5KdGpTcVhzRnJKQXc0bVNPL2dya1Nu?=
 =?utf-8?B?Mk50U1dpOHYxelNFY0ZCS3Z6QzN1NHRXZ2c3aDc4YjZ0NjArVzREVGZSb2tw?=
 =?utf-8?B?QWJsd1k3bS9hS3RLYnZKUlloajdhWERpd0JtbnpsUXhSU1dZOGxReHh4T1Yy?=
 =?utf-8?B?VE01Kyt5SFFhbkcyRjlTUERUdlUvQTVDdXdWbmdCT1h5ZjBsN21VUVhyMisv?=
 =?utf-8?B?ZDNoQWxSdVl2S2NhaG54VXJuQ0QvNkFqbXFNOUsycHlEMXFLd2c2TnpWdU9j?=
 =?utf-8?Q?+5IJuTQjwJvTVrw9/55lqO+TVRORBA2a8J0YY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bEFUdW4wVlZUa016V0FjVkVGRmZ5RnVGb3V4aEszYnhrOGJBL1g2UFQ3M0Rt?=
 =?utf-8?B?V1JlVDNLalE0MlM1TS9LUURZaHhkL2FXUmdRUk1XZTRvcnBXMlR4SW8rdzN4?=
 =?utf-8?B?K2dBWElGUWsrVDU5SFBZU1plRmF2S08yeG9oNjFncUEwUVExUUE3YTlobC9C?=
 =?utf-8?B?OEx2RDVJK0ZPVWExQkRNUXpycHd3eTZoNjJJNVV6MGpyUjZSMUFUYmk0TnV5?=
 =?utf-8?B?Z1dBUzlaQWVDNUlGVnhpc0ZWc1JUR1oxVm9SNU1iN3dCU0p2YlEyRkdKY1FJ?=
 =?utf-8?B?MFp5ZDcxRityb3pXcTc4R1R4TGJwaDBmS2I4Z1ArMXBudStwbUN6RHQ4dzlh?=
 =?utf-8?B?Z0tTN1NxNnNuQUlrM0lpSGxsc0NGMXk4eWQzZFpMUXJFdm81ZzJ6WldNVkdo?=
 =?utf-8?B?cXhVV2s5akVQWk93UHNQUHRiTS9lRDZPZ0EzQk9CQ21WOW5qK082UWpEYVBn?=
 =?utf-8?B?M0p4bmNBMEtKQWZ3anlvM2E1bHJ1UWVrYUc3QnBNTTRlcENrOVlhM3lBWnNK?=
 =?utf-8?B?UEsyWlU4OEwzMW1tUTVIRi9mNUdIa25kR3QrTVB2ajl1UHo2SkNJSlY5d2lt?=
 =?utf-8?B?RjJwUHJMekVVYlJlT2JCWEUxS2NPNHphZHJCK2kxMHMva2hoNXBxRUZ4Y2V5?=
 =?utf-8?B?bDhVN2VDbEdhVTdwZVprNkorSGs4dllSclcwQTZOMEFSNFNsVDNZL2pvRDZR?=
 =?utf-8?B?cWVHa2lOaEl1bldEQ1c2eFpMQlRPL3lPRXlYSFBveW1sQlhQMjRHWkxZL3pL?=
 =?utf-8?B?dHNKdHNvaHpHMHNkNXVxclppVkRETGl5TS9vUmlpVkZjMHlyU2w4Y2tVQWd6?=
 =?utf-8?B?ZnkzKzJlOGhKVlNITys4T0ZXcmwzZGN1WHl1aDBxOVl1dkpIV0ZoQnpPU3h3?=
 =?utf-8?B?TTBvY0Z2eHY5WkFwd1JPbnNwdmUzN2diMFUvUVNEd05UZ28vYldHM0JTb0VW?=
 =?utf-8?B?SnNUa1JtUDgwSWlkZE0vYkRPNnpWQ3Rjdjg5MkRzTTJLK0NqbS9lSlJlc1RC?=
 =?utf-8?B?UnMvcGVFdjF2L3VSSzIrQ0VkakxSUEQzVy9Id2x5Yjk1ODkxNXhJRmVUcTVM?=
 =?utf-8?B?VThXSXNGakpqNXE1a2xUWHFJNFpSSGxGZ3IzOHl1cGQvbHF4UU94V2lObDUy?=
 =?utf-8?B?T0c5R3lMMkJXbkhCWjJ5amQ5b0ZqSzZySStTa0VCRCtBWVVrL2FIay94ZHVa?=
 =?utf-8?B?dFdRY3RjREFBK2RET2F4NGdzNUE0WDRYbkhaY1lJVUllN1hsUUtKWG1QMXdh?=
 =?utf-8?B?eTk2RTRwb2pFa3VxWkU4Rk9aUTgramJXWG1UczdWWHN0Q2hTT1M1VDBBVEx0?=
 =?utf-8?B?Q2NhLzk2cGNDOFhxdVVmQUhSbHVaT3lwL1RvTHJ3WUdrVXFtTGFna3huQktZ?=
 =?utf-8?B?Z2RGVUVNWmdnMWNpOVhHMG5CMnRHY1hsZTMzeDl5Vnp1L1NsaDQrK0UzWDVM?=
 =?utf-8?B?UWYvZXJBdlg0TmlTZ2d6aHRxYS9jc1FEaWVPTE5qTHJMaStUZlk3NTNIV2tB?=
 =?utf-8?B?d2UrTktOdTg4WVIvZjhSbHpvY1JqRUVMN3djcldtNmxQdHI5RTFheE9Od3Jt?=
 =?utf-8?B?SDQ2bTE5cDR4ck1vZXI4dGYwV0x5d2krZDE0czBkWldraDAzMWY3bkRZSUVQ?=
 =?utf-8?B?TXBWaDJFNEh1eGZ3NFNjdkFXOVpNWTlFLy9pR3RRUlRZVWRIRkIvVFU5dnJ3?=
 =?utf-8?B?YkR6WmMvRXdlT1IxZHpCcTVJdjZNODY0K05QWGpEcFZMSzRpcHJvVEVRM2M2?=
 =?utf-8?B?akdQWU1SblQ0ZnFTTVI5R1VNaWdMcW1aUVovYkxHcHZNelZCK1ZEQlJJT0xj?=
 =?utf-8?B?a2p1SG1XVEZyNlJ1R0Ixb0RSb2ovU3JrY3BxeGo3cXBRc05yeDJUM1RXTEwr?=
 =?utf-8?B?RVhhK1ZBcTI1UVdyRTArY0pmT0pGSW8wcmp2OXN2WlVzZE4xOUs3ejc4UzNV?=
 =?utf-8?B?SG9zZnZ1ZFZmMTZFaFpZVHdpN1NMcWtoWUVDQkFXak5WeVQ1N0dtY1dLWkRK?=
 =?utf-8?B?NjlaR2U5Rkk1R2RiRGhxREU2U0E1OC9SMjVZZWNnUlkvYmZuYUtRd3ZzSWNa?=
 =?utf-8?B?YUdyM1VhVlJiRk93STRETDJBSGpieSs0VEc0OEZSOXp0TnBhdkU5Zjg1Tzk0?=
 =?utf-8?B?QmlITGtpN2duOWZ4YlEyZUd1VVo2ZzJTVy9pOTRnQkJUODFhdWhQVndyQitr?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE587760B63BD642BB616BEF5D6AAC46@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df415bc3-9bdb-4e93-68e3-08dd02f4f616
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 08:35:28.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NGuggtzHqyhWrlMBxIQPoeOaACL+oD+CqLdRxIAhl236EPb+9UgwM/SjSOsokfVJT7RilNP1C8xLV30OBkqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6244
X-Proofpoint-ORIG-GUID: bGgEb-jkohQtSg3IDvCikPlDKSNTBUgX
X-Proofpoint-GUID: bGgEb-jkohQtSg3IDvCikPlDKSNTBUgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

PiBPbiBOb3YgMTIsIDIwMjQsIGF0IDEyOjI14oCvQU0sIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4gYnBmIGlub2RlIGxvY2FsIHN0b3JhZ2UgY2FuIGJlIHVzZWZ1bCBi
ZXlvbmQgTFNNIHByb2dyYW1zLiBGb3IgZXhhbXBsZSwNCj4gYmNjL2xpYmJwZi10b29scyBmaWxl
KiBjYW4gdXNlIGlub2RlIGxvY2FsIHN0b3JhZ2UgdG8gc2ltcGxpZnkgdGhlIGxvZ2ljLg0KPiBU
aGlzIHNldCBtYWtlcyBpbm9kZSBsb2NhbCBzdG9yYWdlIGF2YWlsYWJsZSB0byB0cmFjaW5nIHBy
b2dyYW0uDQo+IA0KPiAxLzQgaXMgbWlzc2luZyBjaGFuZ2UgZm9yIGJwZiB0YXNrIGxvY2FsIHN0
b3JhZ2UuIDIvNCBtb3ZlIGlub2RlIGxvY2FsDQo+IHN0b3JhZ2UgZnJvbSBzZWN1cml0eSBibG9i
IHRvIGlub2RlLg0KPiANCj4gU2ltaWxhciB0byB0YXNrIGxvY2FsIHN0b3JhZ2UgaW4gdHJhY2lu
ZyBwcm9ncmFtLCBpdCBpcyBuZWNlc3NhcnkgdG8gYWRkDQo+IHJlY3Vyc2lvbiBwcmV2ZW50aW9u
IGxvZ2ljIGZvciBpbm9kZSBsb2NhbCBzdG9yYWdlLiBQYXRjaCAzLzQgYWRkcyBzdWNoDQo+IGxv
Z2ljLCBhbmQgNC80IGFkZCBhIHRlc3QgZm9yIHRoZSByZWN1cnNpb24gcHJldmVudGlvbiBsb2dp
Yy4NCj4gDQo+IFNvbmcgTGl1ICg0KToNCj4gIGJwZjogbHNtOiBSZW1vdmUgaG9vayB0byBicGZf
dGFza19zdG9yYWdlX2ZyZWUNCj4gIGJwZjogTWFrZSBicGYgaW5vZGUgc3RvcmFnZSBhdmFpbGFi
bGUgdG8gdHJhY2luZyBwcm9ncmFtDQo+ICBicGY6IEFkZCByZWN1cnNpb24gcHJldmVudGlvbiBs
b2dpYyBmb3IgaW5vZGUgc3RvcmFnZQ0KPiAgc2VsZnRlc3QvYnBmOiBUZXN0IGlub2RlIGxvY2Fs
IHN0b3JhZ2UgcmVjdXJzaW9uIHByZXZlbnRpb24NCg0KSSBhY2NpZGVudGFsbHkgc2VudCBzb21l
IG9sZGVyIC5wYXRjaCBmaWxlcyB0b2dldGhlciB3aXRoIHRoaXMNCnNldC4gUGxlYXNlIGlnbm9y
ZSB0aGlzIHZlcnNpb24uIEkgd2lsbCByZXNlbmQgdjIuIA0KDQpUaGFua3MsDQpTb25nDQoNCj4g
DQo+IGZzL2lub2RlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+IGluY2x1ZGUvbGludXgvYnBmLmggICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSAr
DQo+IGluY2x1ZGUvbGludXgvYnBmX2xzbS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAyOSAt
LS0NCj4gaW5jbHVkZS9saW51eC9mcy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0
ICsNCj4ga2VybmVsL2JwZi9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAz
ICstDQo+IGtlcm5lbC9icGYvYnBmX2lub2RlX3N0b3JhZ2UuYyAgICAgICAgICAgICAgICB8IDE4
NSArKysrKysrKysrKysrLS0tLS0NCj4ga2VybmVsL2JwZi9icGZfbHNtLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA0IC0NCj4ga2VybmVsL3RyYWNlL2JwZl90cmFjZS5jICAgICAgICAg
ICAgICAgICAgICAgIHwgICA4ICsNCj4gc2VjdXJpdHkvYnBmL2hvb2tzLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA3IC0NCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL0RFTllM
SVNULnMzOTB4ICAgIHwgICAxICsNCj4gLi4uL2JwZi9wcm9nX3Rlc3RzL2lub2RlX2xvY2FsX3N0
b3JhZ2UuYyAgICAgIHwgIDcyICsrKysrKysNCj4gLi4uL2JwZi9wcm9ncy9pbm9kZV9zdG9yYWdl
X3JlY3Vyc2lvbi5jICAgICAgIHwgIDkwICsrKysrKysrKw0KPiAxMiBmaWxlcyBjaGFuZ2VkLCAz
MjAgaW5zZXJ0aW9ucygrKSwgOTMgZGVsZXRpb25zKC0pDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9pbm9kZV9sb2NhbF9zdG9yYWdl
LmMNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
cy9pbm9kZV9zdG9yYWdlX3JlY3Vyc2lvbi5jDQo+IA0KPiAtLQ0KPiAyLjQzLjUNCg0K


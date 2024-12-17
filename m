Return-Path: <linux-fsdevel+bounces-37667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54749F5967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 23:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F173188C612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D251D45FC;
	Tue, 17 Dec 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kQlRH8lI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3131113D276;
	Tue, 17 Dec 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472953; cv=fail; b=pDparjq+eSq93tcgF2tuVAQFPkZC/wnRfuYkyZ0aIKobdj1xAIgHKs8xNcJRpKjhh5Ht+wQB0Z/5190mbWODzhHs9bYQpdOJz43ZIW8MwxiSclPrNv7VNMG3XhV4R2DBh1BQ5YshfzdJkDfw4I+jd++wL0cn8dMbMVIsH1HSI88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472953; c=relaxed/simple;
	bh=dbn0AZfU/1yw/SSrEzgM3y8RZjvmxmn4xvjWRZ6iBNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G3d8S0zXXqkBYkCs3YluHobZQ4BK05KGRHvQhlbdDiNu5ntDENbfCZlkMejHakaLGk6u6oj3cqvQy9jHr/ftIFxyIHgoulIJ9NdLXEmPdjUloyaj48tYGzLTvbH5LCFhMD/CPQRWiLc5168U+xXxv06YQcri3+31Cjm8Xqir3SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kQlRH8lI; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BHGsBWt019081;
	Tue, 17 Dec 2024 14:02:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=dbn0AZfU/1yw/SSrEzgM3y8RZjvmxmn4xvjWRZ6iBNA=; b=
	kQlRH8lIJZgx1bgv1VUD7IjXcUfz2+fEZQmZ1t2IPoKnMkH8o0hMEpXJ1tprXV7Q
	OzF8B+/WLUebJcE6XJTobvpk+lROFwVQYCDHf/zMU5wO/ElFpckokVncaQi2uH+m
	ESFDtmbVrc+PDtJQP+tyxSKR5ormu1UpqAQLgIPBEM6wHxwXqmYikRXVOVHkt+KK
	j5tlSVUnoFt9Ch/n7/TEH0wi+va4OGJCheQqjfZ+vbpMqenmxV3NnvDEC61cNEyg
	bfEjCDzVHQZDP+gEc06455ljkacHTEobuWD/R3PxeZ5EEE9IqmXT5TSb2d9s3DGL
	9i7gT2A8WEd1uoZ+gstovw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by m0001303.ppops.net (PPS) with ESMTPS id 43kc42jy9q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 14:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uffs5M3fhdPbLh+7vW9ynhUmw5whOOZLbGNObe1M69L/rRA3GPBl0DBrN9+ktxUElw/B89ap3RGQFTtxnAbW/CeKPo7KOnGVCW5IBATL9aJ5WVf8vJLVvw2COK9ZaIjx/DkKRJAq1xhZFXUvGjCsHYcrgViIOtbJbZeM+XSofVwE79X0lpEhKj+miyq0neicL2aBij+SeeoNkA8I8Emwlil5AW1qLNgOB+29X1UB2x3tSSp7X76HfcAO/qdIBW8VUjE9yJjoUwH7r3FBe1IlO0d21848JW/1Ny+eEH3HUPVwVcVvYpl5+S2zmPKr5DNvBIB7TXaOpAhXFqooTD5L3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbn0AZfU/1yw/SSrEzgM3y8RZjvmxmn4xvjWRZ6iBNA=;
 b=LKGMJHr8cQDGBQwVlp0zuwyco3z4GS0KjH1P7rw1VkQMAWdZ6ec6coUvoV4JPriR93u4CMmWu2K4K2E+qW6vMLo3OrnQ4PxMnasNrI27dYLiqlrLEaiQuzTSvrgT5NfiMe6VJt/DwwVafEI/g8sk9Q1+RP5L7wOiXhHNnYPi3XzPCctYLDUik12rRmq5WLFk8X6C1SGLrkPCCJKom9lw3Tg9SXEZ2vO9sjFddEJTlaV8X55FdZFLp3Kwv6vObznrhqCFYyVbdT6sEZgcJUc885hf/SXa/IOHb6+L7E8cQl1Lho24U/Qvplu6x/ZpQ6e7t5Jdd07Ndl3F/oWNHdpKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS1PR15MB6695.namprd15.prod.outlook.com (2603:10b6:8:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 22:02:26 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 22:02:26 +0000
From: Song Liu <songliubraving@meta.com>
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "eric.snowberg@oracle.com"
	<eric.snowberg@oracle.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        Kernel Team <kernel-team@meta.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
Thread-Topic: [RFC 0/2] ima: evm: Add kernel cmdline options to disable
 IMA/EVM
Thread-Index: AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgAAJOgA=
Date: Tue, 17 Dec 2024 22:02:26 +0000
Message-ID: <6CD5F54D-E4CD-4B6E-AA73-4DC3F72ACF03@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
In-Reply-To: <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS1PR15MB6695:EE_
x-ms-office365-filtering-correlation-id: d53ccc99-780a-457d-7fdd-08dd1ee67e4d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWk1TFN5TzBPMWtGZEZyRTJTNk96djNKbElQUDdaMllnUnFpcm5rUkZ3UHNZ?=
 =?utf-8?B?RmhnSTByV3Z3UzdFZWtFd2RqQ1Q2eDhqY3lNUWFxMTNxcTdMNTg5MzFMRXBp?=
 =?utf-8?B?Q2pNNHZmNUFTQmJuczRPekl4Vjh4eDZWdEVpTSs4VU1mTHZlc0JneU81UEN1?=
 =?utf-8?B?RGZnVEtGdkdnbUVOdGpBSllTMDE1NUc2eitkMmV1WUpoZndrcmo4NXBwNmxu?=
 =?utf-8?B?b2dOUWphRWw3bFZWU0xEZFBqclY1TncvY0I4dC94SStTM0EvZmF6ZWdrbGtL?=
 =?utf-8?B?azFuRFNqaUtPWFozL0s0cWNYK3N5TWFPZjMvOFM4L0dQNG0xVmhiWElGSm1y?=
 =?utf-8?B?SWV6M20xR1FPbTBaZk1GUkNQZllTTGxFc0JQYkY1WFhqM2pZNEF1N203SUFO?=
 =?utf-8?B?N1ZoVDJvWWc4VTFkV0t1K2ZKU2RPT3k4TFRoT1g1Vy9iMi9CTFJvdGRENVFE?=
 =?utf-8?B?ZzgwNkFmcTNVNmZ5V04vNk1haVMwN3VFMGpaeG1uUWJwQmNxb0ZLZFBoaDBr?=
 =?utf-8?B?L3BjSEhGNVdGMG9uQ05UUGRmc3hlTGZkR3hJNnphcEtrTTJBQTd1em1kWk5T?=
 =?utf-8?B?K2d2RmNjV1hWMGtVNE0xbmFPU3ByenZqV0hCSkFJdkZXb0tEODMvNURMSmVW?=
 =?utf-8?B?QUJJeThVbWNYNTN3eVJvOHNSTFk3bmdLcVJXWmRjdUpDVk0wK08zQWJ6aHJq?=
 =?utf-8?B?TkFERlVtYnlkdmdKVnlLSXhuUVcwODJEK1g2cDcyelhOT1pJdHpra3NlWllB?=
 =?utf-8?B?YVIreGJ0alhyV1pjU2hUR2p0KzU5V0QrTGNNMXRMU0M0REYrcm9BWEVsS0Ru?=
 =?utf-8?B?QzY1RTZZcHlPTjZaVUxVUG5uNGxHQ3FzK0V3ZWh5M3RDeTk1NnhkeFpiMVpH?=
 =?utf-8?B?dVltUmxLbDNCaDBTSXdxUkJSSlJESGY3NzRoVzk2KzlnV1NmUWVXZWFnVTJH?=
 =?utf-8?B?d1NaZjQwUVlEQmNpYURjRmtYYWRjVG1XRzVZVklGN3g0N3V4M1RsT1FubFQr?=
 =?utf-8?B?QU5YQzJIeWNKYmNuNlFSU0NlSSswNllyMjd5cmdmcG1EdFBmdDVMZkNSeUd4?=
 =?utf-8?B?aFRCMStURTQwYVlxTWFLUk5TMmFCczR5RFFTMDJkY2puSnJwMmg5bldSc1F6?=
 =?utf-8?B?dE5NK1FibWNxSmtOSGczaE5IMkpXNUl0SUNJQVRnZ1l3N3l4bTlRVHVRaWpQ?=
 =?utf-8?B?T08wT2pLaWprNGMzMFVJSTh4MVlmVktURDRPSHUrSHVyN1dudEFFTHk2aFUx?=
 =?utf-8?B?cGNWWTFVVmU3YnQ2aE5nd1doaXlUZmRJVGJNS3dSZDBFQXBTM2lNc0kzWS93?=
 =?utf-8?B?MVpTTmxib2Z1Z0diOUNwQ1htZlFVWmFxWGo1NzRRUzJvYTlpVWE5cU5KZ2Yz?=
 =?utf-8?B?WFlaeTN4STBZZGdyTzNJSXJTdUlJWmtZMVZndUJIc3Q5Kzl2VFdaOXNRcXV5?=
 =?utf-8?B?MGlBUUdBVXFnT2htNEFKbHBvMHlMNytubStxMzEzbHV5RXVyRGJzUVJ3bEx1?=
 =?utf-8?B?a2orQkhCY1FxajNmMWpHT25EQzQ4L1JwaEIzQWhyWTcxQ0VnM2taNU5XK2xp?=
 =?utf-8?B?MnB5TVczUzVvV3UwWnVWUmdLTnlEYW5TQ1BLbitEdjF0bGJHenhFOHFsT3BP?=
 =?utf-8?B?dWFEdVFYdnEwc3ZEcG5CQlpFTkoyRzd3cjczd3I4YXZ0bVRDQWpxdUlmSVVZ?=
 =?utf-8?B?QUtRc2R2TkRGRm9nNHNkTjNCMFdFcmREQzdKT3FHY01VdGFndE9DVFdHTjVD?=
 =?utf-8?B?NTdwMDBLS3cvKytMRWhIVnE0QURBSzg2Rzd4RHhHK05Ba25xWlI5Qk5WUEtu?=
 =?utf-8?B?QkJrWm9QZlkrZjVuejR0eVdnUDZ1YzY1WWtER2RKVVhCNDlJMUhUaEN0U1FW?=
 =?utf-8?B?NXJLdldhdDFkOEdROCtPRk8rRm4zRnBNRHYyOTdFMVRCRGx2Q1lGYStycm9M?=
 =?utf-8?Q?43Chs9Q3qtXKFrdBCvFWpfo+MOD+cQEv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWNJaGVBM1l4UGRmL05TNE50TGlSSFErUWhkd3VrU2FXYUY4VWluczdEclBl?=
 =?utf-8?B?NEF5Mk1BWWFwdDEzYjhiSlRLS3FweTE2TU9RajVyV2Y1UjFkelV0OVFaaFND?=
 =?utf-8?B?VUY5RGovWitrMTVjTWFDVTB2bVEvaW10NUhPdlF1ZFJUaUVRV1NCUExtajdr?=
 =?utf-8?B?SmNpWFlZeDltc2NjNHFkRjJQK3ZyQjRDdDIxTjFUMWw1WmFjWlEyUnFNaTZM?=
 =?utf-8?B?RXU4b3g1RHVZQkF5ZUMvSkozWTdMR1BRK0VJMW15OGFxc1ZOSkZEenVkSmQx?=
 =?utf-8?B?Z2NSYTZOWDk0TC9LaVpFZWxXb1dzVXIwZ1ZJQWxIVG96U0YxVnovRnVVa1pY?=
 =?utf-8?B?OHk5TzVSeW5TOEtXYlBmSklOMmhnWGNWbUQyK3VzZzRVUHBaS3dJdFFQZ2Uz?=
 =?utf-8?B?VEl1eUpIRWQ1bm12TEZhbHJnY2V0cUhaY1FFTXZJa2dLQVd4UjBjUW1ETk95?=
 =?utf-8?B?a0JUbU43YVBVdHh5K0VubTZiSS9GUUl6enBEa0o1SjE5K3M3a0hBd3dHcTVM?=
 =?utf-8?B?RzZLbStZQ2Z4aGJmRC9yanZQWm5valR2VXBBdDZzQjR6TXBlOHlGVGI2eHFR?=
 =?utf-8?B?WjhVOHppNFcrMlpuK1RsVHhmVlRxdzN5UkVlZ0xDZHFlWTRaWDZnOWt4NjN5?=
 =?utf-8?B?YW1VQlV6Zk0vREVqdFdrU29DejE2c0tGcHcxTUJTUWFMWDg4dHF5R1RFVGkv?=
 =?utf-8?B?TXprbml0d1N4dzVDTUVDa0NFMHYramFUWmZkRDBrSnZiQjFLZ0g4eDMvbmhK?=
 =?utf-8?B?M29mM29lQ0RHdUVOelZlREdEUDBwNWxiY1BrTU9oL0JJQ0VVWnZxSUtyMjJX?=
 =?utf-8?B?OUtlMGpjbWVIQlpaYlFUNVhxSVMyaVlzN3lSWHhRZXk1MVBEOURIS0JQbi9K?=
 =?utf-8?B?eDdtcFdkN2x5b2hoYUJ1ajlkYUtvbGhRd2thbTU1aWY0TE9tUjhQeVRqN2Np?=
 =?utf-8?B?WkFvR3UwTlZkM3NMdktxM3NoV0ZzRlRCYlVRdFRZaHRBWWNEZEgra0JSKzVE?=
 =?utf-8?B?amRsYUlUcmFTVTJLdTRHZnFrb1YxSktqbyt0ZGE4ZGgxRlZRSCtmTDl3R05a?=
 =?utf-8?B?dGkxYW5KN2tOclMvTkpiT29TdmRpSG1ORTh5blNDQk43UnA3RzN2SmwrS0I4?=
 =?utf-8?B?V0VTWGV1bWpsS2l5R2Z5Q00zZjViazh2bGk5WWtNRTM3V2ZnTUxRbEE0RzlI?=
 =?utf-8?B?SEh2OTNYS0t6U0tXZ0xHNDBNeTB6d3lIRHhSU1lZMWZwV2ZhVjVwaDIwNGdD?=
 =?utf-8?B?WFJ2TGxRYXAxcm9qejlhK2pRNUtXTjFHV1BDMWRKNUtET1IxSGRCUmRwcGt4?=
 =?utf-8?B?VWFJK2g5RHZRUFJTVFZYUXZmVThPNENRZkpQaGYxbDdubldtaHZrY1BOemJt?=
 =?utf-8?B?blNlV0tlanF2VjhydzNtci9ITm1zOVd3YzE5MlNWcTdJeUlMN2dYeEdyN1U3?=
 =?utf-8?B?dVRKQ3FJc2Vjejg0VzlmSktEaGpJY05wMDRudktVUlB5VlZiYmYvL2tLRGoy?=
 =?utf-8?B?Y0dEQWxIQ0FwU1o5bURWZzZzNU1GQnZpbFdHU1ROM29JMHZ6ak43VzdSVFNz?=
 =?utf-8?B?amdWYXFJSDQ4dGNZSElDQnhxL29HcGdIQ0FQYnhRTjVYa05KUlVHc0F1dFp3?=
 =?utf-8?B?U0JjaTF1bi9UV3BvSGw2N0hHUUE0N0hlaXNodDVpRWVPYzhzV1Vlb1luWmdm?=
 =?utf-8?B?SnJpN0NJNXhObENTVE5aVEFaa2xQeXhnb1RkZjJwd0dFbUdmWDd0RDJOeUpu?=
 =?utf-8?B?NUNsdHVWdWVXcWhZRXN4QTE3TWZsYnRwOWxubjA2OCt6anNPRUZpOUVnSzFr?=
 =?utf-8?B?LzVDc1JNU3pPb2VtSWltNUpKUUFOaE40dk9UQ01iUXhydGdUZWY0aWV5Y0ZS?=
 =?utf-8?B?RHFtVFZVUzA3dVFObUhscCtLZDNscTlwMlFNZnd4YnZGektGY3MyNFNCTjhj?=
 =?utf-8?B?bXU4dEJyeGpNUndpc2dnb2NuZU1JU1M4dzBNMFR3QlhSemhxTzlqTyszaWkv?=
 =?utf-8?B?NTlzdUQyZFhtdHVxWDVvam1LR3hmSHZOYjFGSHA4OVdmNGN2SHNESXhvN1gx?=
 =?utf-8?B?Z2VIdDBuNnQ3MzFPRWNyeWw0ZDYxcnh1ZVR5TjBOWWNCdVc1ejZrd1NBdWhW?=
 =?utf-8?B?QTNPNzlFQUdBcFA1WWNtcTU2UW43UmQybTlxRTNXR0paMEx4T2JhM0tnckQ3?=
 =?utf-8?Q?m8MckBS2DiM026oCT+6HDN8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C00C3D0B5C29644E8EF1AAE96666087B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d53ccc99-780a-457d-7fdd-08dd1ee67e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 22:02:26.6258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yh34UOfhCl0lvEN8MSL+d6KRdM81fbgbPFKmsROjx5Tuu2CulAXXZwwgQWwC7L2injiMlT3vm3i3o9gPmy1pbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6695
X-Proofpoint-GUID: kOS-lfWjPeT7GMJqSz7sr2l9W8CabSWn
X-Proofpoint-ORIG-GUID: kOS-lfWjPeT7GMJqSz7sr2l9W8CabSWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gRGVjIDE3LCAyMDI0LCBhdCAxOjI54oCvUE0sIENhc2V5IFNjaGF1ZmxlciA8Y2Fz
ZXlAc2NoYXVmbGVyLWNhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMi8xNy8yMDI0IDEyOjI1IFBN
LCBTb25nIExpdSB3cm90ZToNCj4+IFdoaWxlIHJlYWRpbmcgYW5kIHRlc3RpbmcgTFNNIGNvZGUs
IEkgZm91bmQgSU1BL0VWTSBjb25zdW1lIHBlciBpbm9kZQ0KPj4gc3RvcmFnZSBldmVuIHdoZW4g
dGhleSBhcmUgbm90IGluIHVzZS4gQWRkIG9wdGlvbnMgdG8gZGlhYmxlIHRoZW0gaW4NCj4+IGtl
cm5lbCBjb21tYW5kIGxpbmUuIFRoZSBsb2dpYyBhbmQgc3ludGF4IGlzIG1vc3RseSBib3Jyb3dl
ZCBmcm9tIGFuDQo+PiBvbGQgc2VyaW91cyBbMV0uDQo+IA0KPiBXaHkgbm90IG9taXQgaW1hIGFu
ZCBldm0gZnJvbSB0aGUgbHNtPSBwYXJhbWV0ZXI/DQoNCkJvdGggaW1hIGFuZCBldm0gaGF2ZSBM
U01fT1JERVJfTEFTVCwgc28gdGhleSBhcmUgbm90IGNvbnRyb2xsZWQNCmJ5IGxzbT0gcGFyYW1l
dGVyLiBCdXQgd2UgY2FuIHByb2JhYmx5IGNoYW5nZSB0aGlzIGJlaGF2aW9yIGluIA0Kb3JkZXJl
ZF9sc21fcGFyc2UoKSwgc28gdGhhdCBpbWEgYW5kIGV2bSBhcmUgY29udHJvbGxlZCBieSBsc209
LiANCg0KVGhhbmtzLA0KU29uZw0KDQo+IA0KPj4gDQo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC9jb3Zlci4xMzk4MjU5NjM4LmdpdC5kLmthc2F0a2luQHNhbXN1bmcuY29tLw0K
Pj4gDQo+PiBTb25nIExpdSAoMik6DQo+PiAgaW1hOiBBZGQga2VybmVsIHBhcmFtZXRlciB0byBk
aXNhYmxlIElNQQ0KPj4gIGV2bTogQWRkIGtlcm5lbCBwYXJhbWV0ZXIgdG8gZGlzYWJsZSBFVk0N
Cj4+IA0KPj4gc2VjdXJpdHkvaW50ZWdyaXR5L2V2bS9ldm0uaCAgICAgICB8ICA2ICsrKysrKw0K
Pj4gc2VjdXJpdHkvaW50ZWdyaXR5L2V2bS9ldm1fbWFpbi5jICB8IDIyICsrKysrKysrKysrKysr
LS0tLS0tLS0NCj4+IHNlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtX3NlY2ZzLmMgfCAgMyArKy0N
Cj4+IHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX21haW4uYyAgfCAxMyArKysrKysrKysrKysr
DQo+PiA0IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+
PiANCj4+IC0tDQo+PiAyLjQzLjUNCj4+IA0KDQo=


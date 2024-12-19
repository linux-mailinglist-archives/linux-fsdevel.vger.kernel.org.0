Return-Path: <linux-fsdevel+bounces-37856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B069F8273
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F264C7A2025
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F9F1AAA0A;
	Thu, 19 Dec 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Hn0HBgnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857561AA1D0;
	Thu, 19 Dec 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630419; cv=fail; b=qzQGaD3O40XTkk5/n9EgvgDGfc/SvEeUWiTzV9Eo97tb+/q/0EUCYM5ZRfRmd8he4kuoiA1fsfidOOPamOmCYkc/NnpnHarxWOozw1eYSrHd1Ggw4n8hHhnC+LPwMbGGKMGh0+p1TIhGufXh85lrSTk17FPVd36Cpc+yfBaLol8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630419; c=relaxed/simple;
	bh=sWYo17XvQnZTo3R5yd+JBzWR5QulSRTHktQHfWgKKYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l8eUKvQQQNF1vd3klUd4jpeNjUJqA6wqgZiT4VOjxq8jGFLzLeG1WzSFtrcdoTP5/AMD3IFXtBLPcwZUmfdSS/4GMslDGduOikzBBGQwT2gqYhqrf580kkhcTWyduiTXYEq6DtHoN4hqy4k1zfR8Bqd/+3HIat9tGUiepqYzU+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Hn0HBgnj; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJGcdAQ028553;
	Thu, 19 Dec 2024 09:46:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=sWYo17XvQnZTo3R5yd+JBzWR5QulSRTHktQHfWgKKYY=; b=
	Hn0HBgnjIOv9E0zURBPv09RO/JVgcDABQHqmFRSpKvyU8pYQr8AGU9tLx8IQryvr
	4KXJUNqDDSC8tX/rDrlctxxJaXEnOy6AEr+d1x5bA3rXnrxST1M+gaDQj4yGePvq
	y8Lpzb+PsPF9VJxVK/phne0piIZVEiap4JAa2e8dTCkoG5NS3udLH1VsUdTAi3Kd
	WMCfKA8GADetZS/CZ/EOd+/eKdWX40Ii3FT3hHhuZVTMHJObTjQ3FZAKlD8QxLY+
	qryc2SzSVpUZCrX72r8qmhgWx4t9SlTAzVu/v3mktVRdMnNw+kkWV05pf6lsXvq4
	GJ8r4h3UxPwBk+2LQ6pOVQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43mq660k4w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 09:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjBNIOt+3UMMW5P3tZV4AoYWUPKNOCzcvlHrLu5sc8lT6cudd1UIxdz74ud5cb0CHO1MYu+xgsGBTLpCdVW3oRPuwvM1OnwiAFHqpaKjciGCWZ4H7ckUQLw0tvs+CYjTVzPGohdNiEQ3a915ias6UZAoWqjj4XMxXMVvgzEvdEm/zdwA5RQW+6GY6ml3RCF236AkE25dSBhfT8fWgHsY5EQwLiUgT5nSIZdK+fePmSzGlZ5aAtLgKMLtu2K77Sj2ReDwka3iMolGNFxJdC9J7IlUJW+Qe1LiqKhMKpY77GBXaHI4Zu0W8lNVmW0nzs9w44LO+MjCOt/Twv8WvMnyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWYo17XvQnZTo3R5yd+JBzWR5QulSRTHktQHfWgKKYY=;
 b=wZwYFoArabLXSBR6+oC3Px/9v8JIoMNxpuLUaf+5fAllq3yg+UmCxWwVKApDfhl18R2eJ1hL1aZ9Cfb5z0bPyWoIrpmk5Flrn2sXLZg8JGS+an0f1syKhlq8RSdnVRYUWiqxFXpXl6Z2tu7ahD1CWA+/VVJsv1DTUqPgrceEBEvd+jh+9bsuoW9pdsMmJUJkzDp4nK1moGxKek3xpGzCPEug/WaaOml5IBoJzdLq2D9nr/lVBsYWiDZrf79SRRq5/hSdRk8plNHQeQyoHKVqvW9CvAibnwsjGFBad4Cy9DoSybk0T/s3R1coCeXSjPBkb2peVqkQoeFPu3LTERWykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB5809.namprd15.prod.outlook.com (2603:10b6:a03:4e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 17:46:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 17:46:52 +0000
From: Song Liu <songliubraving@meta.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
CC: Song Liu <songliubraving@meta.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>, Song Liu <song@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
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
Thread-Index: AQHbUMHZ/pEEoDutDkiUOsUV91UKILLq8+2AgADjVoCAAGWuAIABejgAgAAjP4A=
Date: Thu, 19 Dec 2024 17:46:52 +0000
Message-ID: <358F6A59-C8ED-4CD6-996C-C68B3034B3F7@fb.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <bd5a5029302bc05c2fbe3ee716abb644c568da48.camel@linux.ibm.com>
 <C01F96FE-0E0F-46B1-A50C-42E83543B9E1@fb.com>
 <ac0d0d8f3d40ec3f7279f3ece0e75d0b2ec32b4e.camel@huaweicloud.com>
In-Reply-To: <ac0d0d8f3d40ec3f7279f3ece0e75d0b2ec32b4e.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB5809:EE_
x-ms-office365-filtering-correlation-id: a241b30c-13e7-4f32-b66a-08dd20551f62
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3BHWldWWFNOalZ3ZTNsSEUybEhUQyt0aXIwTldsbVlpYkxWSWlLL0hMQXQ1?=
 =?utf-8?B?Qmt5RXBtTlBPVnZvRFd2bzNGbVVsNVRvaC95c1NNTDIyTW15aVRQdjlwbG1a?=
 =?utf-8?B?TlZ0N1I5aURIc0M0ejcyR3h6VWViSW9nM2lUUUVpT3VxNERCRTd0S0ozTXJ3?=
 =?utf-8?B?eStsVC9ZSkxMcE9kRWdPR2hlVW9JeDVvOWJramFCNitkSDZ3bjkvYlpxNHFv?=
 =?utf-8?B?dXdLRUUxWEtKdmllcmRabERnT0UrV0twWWxlZ0FyUDRYQ0l4T0ZiVXoxcjV1?=
 =?utf-8?B?d2NkdUhxQWNIMVpmQm1qK0hxeVplTVNpdGFEa2taK1RYSDBPN2N4TWFabVEx?=
 =?utf-8?B?d1ptQjNLODNiWjhyTGRnbWlSa0tzRjBuRlg5amxla1I4a3prOWVaSHYwQmI0?=
 =?utf-8?B?VDJod0NqYzlWcjJkUDdCbmRyRm1IWGg2YXNEUG1wU1JyM2lkZjNYNXhMVkRG?=
 =?utf-8?B?c3hZM1hhRW1tRythL3RIY3R5cUZzVkY2aUNHL3FwR1FBYXMyNXNXRUo2V20z?=
 =?utf-8?B?a01OVDh5S3gzMVorOHltblg1REhwUGtmS015TUZYWHlnMkY1UFJCRmFZNUho?=
 =?utf-8?B?WUFFa1IvOTFTQmd2d1lMamdWcUpXUEVTeExHZzR3RXFjYTh4SnZvc2I0L2Yz?=
 =?utf-8?B?c3ppc0dTYW84WkxOTTFsMVJGdWwya0dtUzMxZkwrL3F3Q0VRS3JpNXRKOFBn?=
 =?utf-8?B?ZVRiVlpFTk1lQnpYcVRiRzFnSFpJc3BtaGJGenZRemtscGZNUjVsS0VYNkFQ?=
 =?utf-8?B?L3pvZEZsVzhPQmdLY3E3WGF0MUZJa1cvSGJvMjBxeHR1dEsraGtyQ1BkQy9X?=
 =?utf-8?B?elQxZGhQTHN3K2F6UWk3bGFpdjFCeWtkaS9JZ25OTGFFSnV0WFJyL0o1VjR3?=
 =?utf-8?B?ZDVHVXRwRzlsQXg2TFJNSWhYMDJZZFJqMWo0UUxwK3U3NmpNdUNBNnZBUlNV?=
 =?utf-8?B?MXBEbFFObENDQmw0SFBQekJsTmZOY3NXSWZTNUt5aGg4VE5yZ0Z4MnF3NGxn?=
 =?utf-8?B?Q1VDbWM3UnVuTk9ZdXd6RERkVUlkUlJtL2dnaEdHTzNqQXV6VFdHZ2toUjJr?=
 =?utf-8?B?TnpLUUsvKzNUODBGWkxZWXpWdzZyai9zMmJzK1FlN3pDQ1V4Uzlwa2VoOXp2?=
 =?utf-8?B?OHdzT1dyanJSVldMMGNRRFF6MW41Nk8yazJWZDBNUGJhR1JwNFRPeVd2VUVk?=
 =?utf-8?B?MWtQRGwvdlBaeWZ2RnNjbFZtdjYxTVVTenBwL3VhZFNHNFp0U25ldTJURDJ6?=
 =?utf-8?B?emFBazhSYkgrU0d0RElUb0YwR253OFYvTkVMNlRmbE9zdjlRTkoxdnZEc2Jj?=
 =?utf-8?B?em05eEk3SDZmTDI4U2s5OHZsQkNiRVFTYUx3RDdpQVdWdU5GMkZkSTJNblhr?=
 =?utf-8?B?WHJZOFVBNGNrTUFUMkl6dHVpbldqOFU3N3FQYTZXcy9VZEZ4S0NaWXREUlRh?=
 =?utf-8?B?aGpiOGd5VWRkOXZLbmZpNnF6UjlFMWJnMVRpYjVWMGZZa1R4eVI0aXYzbFhp?=
 =?utf-8?B?M3g5ZzdvbVA1Y20zNS9FRzJHTzRlbTNNY3dBQmw4Lzc1bllrR2xpUEtBY0w0?=
 =?utf-8?B?UFh1VlcralVNKzlqaHVaNjR0Q3J2Vk56aTYyOGNLQ1JNSGlrVG5MMDdaZDN6?=
 =?utf-8?B?TDdOTzM4SGg5OXFGUUI5VDRZRUd6MGRuMDhsVGVnM1pHajZrUU93dWJqRG5M?=
 =?utf-8?B?YnNOSWZjTndNQVFVTU1QdjlwMU9laTNTQlhVWm93eU9QeFZiVElxUnRtdmxM?=
 =?utf-8?B?bFROSVlra2NQQmI5YkZLeHY1M292Um9JSjZSREViQ2FRQ0p1YVpsSDQya2Uv?=
 =?utf-8?B?QTNpMXZlYXQyY2l5cmVZdENxVlNlcFo4RzhGa1dJc2NUZ2xZOE5iaEtacVRP?=
 =?utf-8?B?cnhaOUg3TENIRGlkZkdhNDd6MEdGemEzTUtuc20xb24rMjFrKzVwQVJGazE1?=
 =?utf-8?Q?p4kn24ThC93wGYaUEF6D04C5uPRQbSA/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3A0U0dCTEhNWG1RdTdIWVUxbHBTUlVDOGpobTBPVkcvZVlENFZFTU5rMFJw?=
 =?utf-8?B?SWRsS1BOOUNOU1puUi9rQ2xiT3hKZXN0TmlpQXNUa1B5RkllWU94TW5OK2lh?=
 =?utf-8?B?VU8wUGhSajNZWUZFcW9QYWtUNFlrdXZnQ3dvQU4vOFZYUTNtUnNEUzlSYnZw?=
 =?utf-8?B?bjlCQ1hsSjJFQmVzS0p0a2djSFZDWnBkb0RvUHFUbTI0Z0k4OGNzTm9ha3lI?=
 =?utf-8?B?U0VwTlQ2ejh6Y21meXZ5dVFNL0JKakYya2p1OVNWTDI4NlYzZHF0dmRpMm90?=
 =?utf-8?B?V0txdTZQV2M2aVhaRWY3WFRlb3g4TUhNMzVnc3FwcExhdmVUVXQ3MnBSeTJ0?=
 =?utf-8?B?YVUvTEh2YUVwd0J3aEhvcjBNWCtkTG5NLzlFd29OUnhUR0RuMmE3TnZzNEtJ?=
 =?utf-8?B?OUFwQndpWmt5RHdyTEJGayt6NDllbElONXRKcE9QbnBQSnhYZmNXdDhNSVUw?=
 =?utf-8?B?aW15Q1cycGlzODhGcTlBSFduTWdzdlhHU1dDRDFMdzFhbVcycnJuQW1LWDVm?=
 =?utf-8?B?NHNuakxBVXN0UW83M3E3SzFKZyt0ellPZVpxb05RTlZEL1l3dGRGcXhuNjJW?=
 =?utf-8?B?a3NYV2s1UWFaWG9zQXVqcXVuYlpoejhhNG1zMHUxUCtXNkFuL0grRWYrTVR2?=
 =?utf-8?B?WWZJeWZrV3h0YlhBY212NlcrWTdWcTdHeVFpTi83UStnRlg3VG85bmVBWktr?=
 =?utf-8?B?WDVCeXpWNHdDTTQxa3BLbTFUK2EvYkMxUUMyNGo1UFdMNTdocWxFMm9OZVlC?=
 =?utf-8?B?bVRhNldBcU55WE52aXo1VGxhd2tPckVuWHc0ZXBISGRES0Q5dlVOUU5rWW5r?=
 =?utf-8?B?NS9lem9IVzExMHhWNEJaWWpxQnhFVHN3a0kzWHJMcnpnLzUwWXhUVERzTitw?=
 =?utf-8?B?SFZoTXhWYVkwSWxBS3M0azQ5MUNaVmtpSFd6bklBbUxhR0w1SXRjSGVvYlhx?=
 =?utf-8?B?ZkNvNS9uNTkxRzZMMjV2Tm9nWjRvcVNiclhabVRxbmdIR3lRSTBkUVN2TW1o?=
 =?utf-8?B?N1RzT0dYeElJNlMwMVZ4azdpSjRLT3JOTWtlTUNXSWZqYzk2NDY0dmFReDVT?=
 =?utf-8?B?L0dCZW5xMjZFMEpmZlkzaHJuSDlseEFQTmxMZXNmTktFMXgwQmNsekFDV0xu?=
 =?utf-8?B?OWJpQUc2WEhnZ3ErTGQ2WmR1RTVjeWJoYXhWallNZzl2VVhSakRuN3FiZERr?=
 =?utf-8?B?cjB4dFBQbnZJQUtabmZJSlZjS1B4UTArTXRhSTlDYzlkUms2OGVLMklDRkln?=
 =?utf-8?B?c3BZRzJNYUtYUjdKVmpSbVl4VXNWc3JnSDJlaHBZY2dUZVZJTmpjS2NGdUFy?=
 =?utf-8?B?UHR3dEVKV1EvdDJPcGhldWNzMmwxYnFTOEFESTIwVXluRDVCKzV5MEFiTEpO?=
 =?utf-8?B?VkxmQWtOTkwwZW5VdmJBa2N1OGRLdDdjTzRySEtySWFCTzdNeElWSzFwOWFh?=
 =?utf-8?B?aFNTdW1sVFpteVgyS2UvR3l1TGVZZ1M0TW1GOVF4Um0rblQxZG52Zmk1R3ZS?=
 =?utf-8?B?dHJRL1o3SmNndzNDRGRtRHZFb1JZUmFRNEczT3gxdFdkbTJWdC9JUFZkL016?=
 =?utf-8?B?Mm5JRmNzOHpUZ3dOS0NTYThFdVhmN1RYVEZUVFZ3OUZCWXE1aWthVEx2Rmtz?=
 =?utf-8?B?YWhtVTBMSENRd3RUT1NUblUxMUUvdkI2U2xMWC96Z3Frcnc3VktXUDNtL1oy?=
 =?utf-8?B?T245WElEU29XUGJpYVN6ckoyY2lRdGs4NFh6YXFxRlh0ZzhiWm1yTWpYUm9l?=
 =?utf-8?B?SzN1QUk3bkV1aFRRcnY1eWdKMmRNbmx1a2tvQVYrSkhVZVc3ZXdpbWJXcjdG?=
 =?utf-8?B?aDViSG9iWmxJQjUzUE8xbS9CN0V3b3hMcXpnb0dBMmI3TEJPSjMyMG9iNHcx?=
 =?utf-8?B?alNrZnJXR29lYkRXYVBmWTJGMTdoRW9RWmNvTnBNb1lRUkdtY2t5RURzdlFq?=
 =?utf-8?B?RnV2NW5haWRLU25sV01MUk9HVzZnVlQ0cjB6ekYzdURIdStHbmFKOUVhdnIw?=
 =?utf-8?B?RmJINy9NOHhiQnJ0RnFydXJ0SWtWeEFRSUpNVk5udVRiQy9DaS9rcVF5QWV5?=
 =?utf-8?B?cDg0ektFRk92TitCNjJNOGdjRHpaeGJzVWdNRS9oSzA2VnJRdVQwZ1NVTzdU?=
 =?utf-8?B?QUZ4UlpvdHBObVptVml3TDV4bkpkQ2YwMTdHaE5raDl2cDBOUmZwU2MzWkxs?=
 =?utf-8?Q?MIxBOaTM/pdCFoQekY4lbEQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99DA27D25898B347AEB75B6E66AB361F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a241b30c-13e7-4f32-b66a-08dd20551f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 17:46:52.7232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2TvvcstmpxoMEBsculRiFrBPgbTENILueBQx4EIsvYnEkeHKH58VWjWJM0bTj1HXQmV0EUKXSoMaie5RkJspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5809
X-Proofpoint-ORIG-GUID: iXC7Flk2YL3SIpAWe1oRLNb3lC4ngxcY
X-Proofpoint-GUID: iXC7Flk2YL3SIpAWe1oRLNb3lC4ngxcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

SGkgUm9iZXJ0bywgDQoNClRoYW5rcyBmb3Igc2hhcmluZyB0aGVzZSBpbmZvcm1hdGlvbiENCg0K
PiBPbiBEZWMgMTksIDIwMjQsIGF0IDc6NDDigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5z
YXNzdUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+PiBJIGRpZG4ndCBrbm93
IGFib3V0IHRoaXMgaGlzdG9yeSB1bnRpbCB0b2RheS4gSSBhcG9sb2dpemUgaWYgdGhpcyANCj4+
IFJGQy9QQVRDSCBpcyBtb3ZpbmcgdG8gdGhlIGRpcmVjdGlvbiBhZ2FpbnN0IHRoZSBvcmlnaW5h
bCBhZ3JlZW1lbnQuIA0KPj4gSSBkaWRuJ3QgbWVhbiB0byBicmVhayBhbnkgYWdyZWVtZW50LiAN
Cj4+IA0KPj4gTXkgbW90aXZhdGlvbiBpcyBhY3R1YWxseSB0aGUgcGVyIGlub2RlIG1lbW9yeSBj
b25zdW1wdGlvbiBvZiBJTUEgDQo+PiBhbmQgRVZNLiBPbmNlIGVuYWJsZWQsIEVWTSBhcHBlbmRz
IGEgd2hvbGUgc3RydWN0IGV2bV9paW50X2NhY2hlIHRvIA0KPj4gZWFjaCBpbm9kZSB2aWEgaV9z
ZWN1cml0eS4gSU1BIGlzIGJldHRlciBvbiBtZW1vcnkgY29uc3VtcHRpb24sIGFzIA0KPj4gaXQg
b25seSBhZGRzIGEgcG9pbnRlciB0byBpX3NlY3VyaXR5LiANCj4+IA0KPj4gSXQgYXBwZWFycyB0
byBtZSB0aGF0IGEgd2F5IHRvIGRpc2FibGUgSU1BIGFuZCBFVk0gYXQgYm9vdCB0aW1lIGNhbiAN
Cj4+IGJlIHVzZWZ1bCwgZXNwZWNpYWxseSBmb3IgZGlzdHJvIGtlcm5lbHMuIEJ1dCBJIGd1ZXNz
IHRoZXJlIGFyZSANCj4+IHJlYXNvbnMgdG8gbm90IGFsbG93IHRoaXMgKHRodXMgdGhlIGVhcmxp
ZXIgYWdyZWVtZW50KS4gQ291bGQgeW91IA0KPj4gcGxlYXNlIHNoYXJlIHlvdXIgdGhvdWdodHMg
b24gdGhpcz8NCj4gDQo+IEhpIFNvbmcNCj4gDQo+IElNQS9FVk0gY2Fubm90IGJlIGFsd2F5cyBk
aXNhYmxlZCBmb3IgdHdvIHJlYXNvbnM6ICgxKSBmb3Igc2VjdXJlIGFuZA0KPiB0cnVzdGVkIGJv
b3QsIElNQSBpcyBleHBlY3RlZCB0byBlbmZvcmNlIGFyY2hpdGVjdHVyZS1zcGVjaWZpYw0KPiBw
b2xpY2llczsgKDIpIGFjY2lkZW50YWxseSBkaXNhYmxpbmcgdGhlbSB3aWxsIGNhdXNlIG1vZGlm
aWVkIGZpbGVzIHRvDQo+IGJlIHJlamVjdGVkIHdoZW4gSU1BL0VWTSBhcmUgdHVybmVkIG9uIGFn
YWluLg0KPiANCj4gSWYgdGhlIHJlcXVpcmVtZW50cyBhYm92ZSBhcmUgbWV0LCB3ZSBhcmUgZmlu
ZSBvbiBkaXNhYmxpbmcgSU1BL0VWTS4NCg0KSSBwcm9iYWJseSBtaXNzZWQgc29tZXRoaW5nLCBi
dXQgaXQgYXBwZWFycyB0byBtZSBJTUEvRVZNIG1pZ2h0IGJlIA0KZW5hYmxlZCBpbiBkaXN0cm8g
a2VybmVscywgYnV0IHRoZSBkaXN0cm8gYnkgZGVmYXVsdCBkb2VzIG5vdCANCmNvbmZpZ3VyZSBJ
TUEvRVZNLCBzbyB0aGV5IGFyZSBub3QgYWN0dWFsbHkgdXNlZC4gRGlkIEkgbWlzdW5kZXJzdGFu
ZCANCnNvbWV0aGluZz8NCg0KPiBBcyBmb3IgcmVzZXJ2aW5nIHNwYWNlIGluIHRoZSBpbm9kZSBz
ZWN1cml0eSBibG9iLCBwbGVhc2UgcmVmZXIgdG8gdGhpcw0KPiBkaXNjdXNzaW9uLCB3aGVyZSB3
ZSByZWFjaGVkIHRoZSBhZ3JlZW1lbnQ6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1pbnRlZ3JpdHkvQ0FIQzlWaFRUS2FjMW89Um5RYWR1MnhxZGVLSDhDX0YrV2g0c1k9SGtH
YkNBcndjOEpRQG1haWwuZ21haWwuY29tLw0KDQpBRkFJQ1QsIHRoZSBiZW5lZml0IG9mIGlfc2Vj
dXJpdHkgc3RvcmFnZSBpcyBpdHMgYWJpbGl0eSB0byBiZSANCmNvbmZpZ3VyZWQgYXQgYm9vdCB0
aW1lLiBJZiBJTUEvRVZNIGNhbm5vdCBiZSBkaXNhYmxlZCwgaXQgaXMgDQpiZXR0ZXIgdG8gYWRk
IHRoZW0gdG8gc3RydWN0IGlub2RlIHdpdGhpbiBhICIjaWZkZWYgQ09ORklHXyINCmJsb2NrLiAN
Cg0KVGhhbmtzLA0KU29uZw0KDQo=


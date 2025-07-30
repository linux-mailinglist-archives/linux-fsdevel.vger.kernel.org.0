Return-Path: <linux-fsdevel+bounces-56353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D962B166DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328515A5D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E972E1C63;
	Wed, 30 Jul 2025 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gBR+l6ir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193431624EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903502; cv=fail; b=XDBRplL/2Rbkil0otxdesT5I3zc9/Cnn948rDFovuJyrFttKzzWXPPWuZ+7n4DgO2jAwsNUOJK8yuG3ZEYa+p0KqZ4lvglPJGvTj50aVhJz9yzhqWs6mHtakr59HFd3Z8E3k+8hB68byl4FcI/vfVxQDcLljWNQfNEtkbPcijK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903502; c=relaxed/simple;
	bh=xJONdVyKkdQ0y8zIUgLwUm06xviS5jAMV3vIdX644z8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Red0ks79s05kjKuyEiqqd22EWjK5TblDh/KWhQ2IoNLnHMcAAwqm+TLZqXQNRUZj/k97SryxE1YmznAyN7n4crSpEZ4bKsl/95Zt0nzmZraW1gDqAGLJjYe99bcmiYwiy2awZ9dzh+HNxjvIbJJS6rZhRfRgsl57p5DvSHhMubI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gBR+l6ir; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHS3xc017151
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=b3WFGfl41DaUdUc4OsBE49MC/qInmxv/CtZbsFkvOMA=; b=gBR+l6ir
	4Bs7hy9ygpuJlEequNQWKgyaIMgMjjPxSI6BQjOMLLo4T0vKC5k8G1BkMCfsuWOM
	AMa3qsEjv5KSb+LYVNS0tvvwZZkaq2r6OXbPaRyBGSRNCIcfzTCqlOmhfDcJBVj7
	yOinw41gxXHtgKcRNALonkHA+DjHfLWBePMjjm3TSTf6VBqO+P90Udahz32zRnn9
	OuDGn5GhoZvcVrlQJU2rfmZtYAyesJ0nnbm6xbf8gzONeHZ8ncM4GQoS7zsGHbV8
	seMQzaXDigYTNFzduxp7Jn9KSL1KTzrDonWOC87/cViuTW/oIsiLKw0LF/PFH+QP
	EoZcExb1jrY3UA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k7y6bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:00 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56UJM4gM024700
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:24:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k7y6b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 19:24:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56UJNSEU026853;
	Wed, 30 Jul 2025 19:24:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4864k7y6b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 19:24:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HekDDeX1Fx8cT8syjL7I7quMToERuceetujr0Rx4bnP01WsQKzyh6xeoyj5FHtV/mw6PBFkLjuCFDijbWBpWMSXbfqTI7NxdYdqip90NMyWkklL86Zf5/d2QhHPV7CZWwulH9SHF63x7tFFUni572SDv4AB6grjD+kC3vqpas5P7IfzXVbD4PM9H3wrxMk0vkf+APuWyymubphBWNiAHgQGeRAn6rnx/hG6xR5XdYKr+FX0/P2zMUhmeu0fuJuUV7wcpz+xlEv6ky53wiqxAx+gbUORe4tw6WYMaZ4Wl1vsSXd/Dk5L8Rjh9u16iO/dAoNYOgFh9zk8OdSUp4fnaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjnhuZMoQ7hlSuCs2Nhy7Yp1Fjr4py6+iAfapEDFUDo=;
 b=luUu5GfCYb8kBjZ2DEE2AS3mutcOmA6t26zMBNbMED7SW9d7n+uiokhEPmsISrXwSS05IkRl002LJ4J/xMN5pb6auU7ZL9gUrAC++JTHifoDbp52p4Z7ZDRK0BqOGFMlJ6VNF3dwoyyUf2w4IkQMYMmPfFXYpPliwTvsm8vC43FZTOcPBREw4hnK8+E+h34n0JxORTyNteD+7iZE6r41TMz6IXSDTSpD1KGz7ga4vEt15Oet+ZOsTe3Ca8FgAyT3pa10l9pYjkP9lq8HiDqh/BmWabcuqnFyjI7xlE0SgPV1RbMdp40lCDNmUfzXIQ0JsFWsudtrP4jWUXcKbhPERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4862.namprd15.prod.outlook.com (2603:10b6:510:c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:24:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Wed, 30 Jul 2025
 19:24:55 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "leocstone@gmail.com" <leocstone@gmail.com>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
	<penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org"
	<willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] [PATCH v4] hfs: update sanity check of the root
 record
Thread-Index: AQHcAN9/a6Ijqcs5lk6/NujcDjeCebRLDYIA
Date: Wed, 30 Jul 2025 19:24:54 +0000
Message-ID: <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
	 <aH-enGSS7zWq0jFf@casper.infradead.org>
	 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
	 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
	 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
	 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
	 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
	 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
	 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
	 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
	 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
	 <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
In-Reply-To: <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4862:EE_
x-ms-office365-filtering-correlation-id: f0d304cf-c4d1-4aa2-0ef2-08ddcf9ec39e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTBnSWtoVzllcUhSMWt3L3NHVzgrODU4U0JXUi8xYmZQZzQzR1hieHlzNjA5?=
 =?utf-8?B?aXh1UGtja2FjQVZaTEUzbTB6SGtxcFJ2aVErNXRlK0V1eXBXeDlnWWpML3Vo?=
 =?utf-8?B?NWhBbDNPbk4vbkRwMHRicHBJc3p1Zkw2YXVGbnQxNnM2RmV1dkVQRGdwNW1W?=
 =?utf-8?B?b0FxTVphNmtleWJ1b085TVFDT3ZtYkQ0RlNkcloxQVdGK1p6cWY2eWFYL3Fs?=
 =?utf-8?B?NEZwN1BkMFVMcEd6SzVDUUJ2dFp1VkhrY2NDL21KckE1M0RFbnNqMzQ0WWhR?=
 =?utf-8?B?YkdqUWxKYjhWb3Y2cCtlN1djL3p0Z2lsU1phaWhWRWZtNU1USHJ0YTlTZXF5?=
 =?utf-8?B?cDNpSHNaYmlaWE1xQ3BWZTZ4MFdBMjRyWno4SmlYS1h4cmJtTzcraGd3NG15?=
 =?utf-8?B?dzZOenovRWQrMFdHdTFLcFByL2NpSVQvcFlkRy9rYTNwZXRyeFJ5QnJVblJl?=
 =?utf-8?B?T0JJTkhSZExCVEpsdkR3REEvNy9pc24yK3QybGpEVG5OcW5BRkd0cmhwdDRO?=
 =?utf-8?B?YW5zSkZqNUZxS1FCM3llSXdqTDdyRzNPdktSOGk5UUFFcmpza1Y3WWMzK0o3?=
 =?utf-8?B?RmRYemt2NjNYeFhoNnloMFN1cHAyME5QMS8xVUJmY2dQc2hMYzJjR2hwRFVH?=
 =?utf-8?B?TXNXNjlrQjNWcU5mWTVORGdLcTJZMTMrbDUyYUpaYittc2FGanlEOWppV3pI?=
 =?utf-8?B?Z3pQaHI4UlNPT0E1K1FISHE2Z0VSeDR5bGF2eFNJZlFrUmdxazRZcG51OXdZ?=
 =?utf-8?B?cDFqZU9oWkw0NlJsdjEwMVZGbDE3QlJ5Z2Z0bnVTWVdtN2k2cWVqNlA3Qkdt?=
 =?utf-8?B?V1N0V21BS2p0RTE1cGhNUW0vSlorVVBOQ2JKRldtRDZJYnZ0UWhOUmhLQ0hV?=
 =?utf-8?B?K1ViQ0tMWXVLSkJjOGpqQUVkK3JCTEJONGIvQnlkSTNYVjVZVzlpdG1KRUpN?=
 =?utf-8?B?RWRYZUE4MkVMRityWFJKaEtTQXo3RmxHVXMvSjVtakNGNzZhSXVqak8xOS9v?=
 =?utf-8?B?SFZ2d01aSEhNWGswbnlDMXJOYnlHWEE5Skc4U1djMGtMUkVsV1dPMW83d1hr?=
 =?utf-8?B?N3VsTGRoMzRYbjBtY2hIWkVYeXpoemVDZzlZY01CMUJielUzTjlMQU9KN2F0?=
 =?utf-8?B?a0ZIMlJGaHNnN1d5dGdRWVFEYWpVcFh0WkZTNGtYYTVBck5YVitsYXFobjdQ?=
 =?utf-8?B?d0hGQmdzZG53dGRPVGdPblJ6aEJjWElYTFhIWjlWQUw2MlhZQTRlc2s5akhL?=
 =?utf-8?B?dzcwT0JSbHkyTEg3SS96QmZNOFVxcXExSkc2WFJUWDBad3c3cW9NOUV0RXJE?=
 =?utf-8?B?bGR2YlRZK3BpeWk5ZTZKSVBqcUVucU9WcmplTDFqYnQ5V3poRkVTZjRMZGpu?=
 =?utf-8?B?ZUhKdUtKYVRmWE1UZURtRG95TTRmOXBGdEF3bkpJSWpJQXVzOXpCNjQ5VGlE?=
 =?utf-8?B?N25BNklXck9ZTEl0ZXZVMGx0cE4yUFF1NUczUjBxVGhORGQzbHhUbkpBTm1C?=
 =?utf-8?B?bnB3WWJlR3NuTi9uM04vWThCOE9qSWpxS3lwcG9ieUlQck9pZHU4T0NWMXZU?=
 =?utf-8?B?ZFMyN21jZkp5bVNYS3FRN1FqTjVmcklXSzg4M3VrVG05KzBIRU9IZ2ZIMjZW?=
 =?utf-8?B?Q24ybTVDSXNwTFZPNW11YmttRUp6UkcyMXRKRmQ2RENybXAzb0ZKZlBFRDFV?=
 =?utf-8?B?d2w1aFJUZFBLZEd6dHJ2MDVhZmxRYUt0K0VFRExmN0RmdjhxK3dqMFBTcE5l?=
 =?utf-8?B?MXFIREZXcC8wcnMwWTMxaytNMFpHa29SeHNtNGdSQjN5c09FR2JLRFg0a241?=
 =?utf-8?B?TFZyekx6QWFNamNFSjJ0RVRMeUJVenN3cXNRSCtOei9VNE1FZ2VrLzcwVkxE?=
 =?utf-8?B?RkZ2M1BpU1NKL3lFaUhtVTJuRTRWRG5KWW9VbG85OG1na0d0WHUzT250QzlE?=
 =?utf-8?Q?OKVtfxVIRYg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWZlOVZldGVwQ1hVcHE0VkdmelJrL0hRODNHY1ZyNE5GWm5BTTdDL01JUnR6?=
 =?utf-8?B?YmxKV2FFRjgzRllhMUZQVFp6Q0E3ZFdJeGVYVWhvNDlHY3pYYnNIVWlUM0I1?=
 =?utf-8?B?Zm05R2gva3FWSlRjMWY5VXQ5R1dOdklyT01iMTZtenBNazJXWmNRSnFLbTRN?=
 =?utf-8?B?elFkUEJqLzBGTTNacVorTzR5dCtZVlV5S1VKN0ZsdkkxRHIyaHVIbkJNRXMw?=
 =?utf-8?B?VTNiMytteldIK2Q1YmhKN1JGc3ZSNzE4cFAzRDVEV3YvSDdrd0pPS1RudEdM?=
 =?utf-8?B?N05DNG0yV1BpOWk3eEI2VUhrYm8vNXBJUG5tMmd0emYxWERldk5VbmlKd2Ji?=
 =?utf-8?B?RUYrd3E4eHhwR1d5VG1LWTZOMlNwczBTZEVMMktVdE0zSXl1Y25PU0VRMDQv?=
 =?utf-8?B?ZWg0aTNhejJEbHhKZExPN0dubTYyTEJMYzgyU3BUY0lGQzk2ZFhKRlpFREcr?=
 =?utf-8?B?NW10TDJzRnlJYkg4K0NzWVlqcVhlWjVqdXNWNHp3UEtJYk01MWRtUTl6YWdN?=
 =?utf-8?B?UC91K3VuSkNiZVArTDZZNE1zS2hQaEd2STJxaTdXdlZxV01LN3AvSGMwZWF2?=
 =?utf-8?B?ZmVrUjhEaGszZURhTG9qZUMycDNGVkxYRjQzV0hXQjg5eU1CNUs4NUh4bkJG?=
 =?utf-8?B?bDFMMVgydFUvd1VRQlhqdkFaT3V1VE43RkhrL0wvRWJHK2lWbmFpWW1KR3M1?=
 =?utf-8?B?Q0VveXdFUTQxVG9USHZWMUhKeXo5SjVXamNYVGxMUXlHTk96MFl4TlU2eG5n?=
 =?utf-8?B?UHI4a0drU0xlT3Y4ZU5oL3lJVkFBaVNvaHBEdjBhODdCYXhSK2I1OWhPZ0kw?=
 =?utf-8?B?SlU3NE1XaTE1LzJ0RVlUeDJBcVBvNEwzUitQWXV6TjhKdlpkTHZqL0pVckh5?=
 =?utf-8?B?ZjlRSDZaSnF2NDVuNUhaQklqTFVHa0c5SjR5THJjbjdrVkp1bFpoRFU1MW9k?=
 =?utf-8?B?VWFhS1d3L28vdU12OHBVc1RuMVg0L3QxWVZDWW5CN2h1Zm41aUhJdldSM0Jk?=
 =?utf-8?B?M3kzZ0FXRjkzbDczRVo1VjBrYlJ5WElGR3FQcW9NdTM5Y1I0QUV1cG8zVmg3?=
 =?utf-8?B?QnpMQ2cxRmxpQTZDV1Vmc0Rnc3BERktoSmxlL1ZEUURHeUk0UEJEdko3NGVj?=
 =?utf-8?B?UlA2V3J3bDVwbnY2VTlid2d1VzFnUVJsa3lZR2JjTGl4ODJXWnpxWDZBa2Y0?=
 =?utf-8?B?UDRUYlMrTzVlMjVxNkdTb2pJQllieHNkRjVzNVZKY2ZmbEdYcFJhbEFFQ0Ji?=
 =?utf-8?B?aVdZamxFa1VuRjhSUDJRajlCOGRrS05zN29RanN1UkxRaWVPRWtsSTl2TW5C?=
 =?utf-8?B?S2pZcE1UaEppTkFaYjRKQ1p2V1FHUGtjZjFkSVFMcXVqSEx4UytJUWg2NnNZ?=
 =?utf-8?B?YVp4OXV5bGFOaGxKeFM3NXVEZE55ekNBZzFhQjQvMnhYNktqeFk3TlJCaXlT?=
 =?utf-8?B?ZHVmK3pNWnZMVTRQUStrUFpmSVZrNGFvZERvQ3R1RlB0T1VleWs1VExlalE4?=
 =?utf-8?B?eFRFcGU2ZjZrNlcwcEZxSUorSXJHdWplaDd2VS9SUG5MRmtHcmJxRE1jV0FF?=
 =?utf-8?B?djZ6UUlreTVONHgvL3JJYWU0cDRzL1pJMFBzdmV0cVZyUnZjdEVtMGlJK1lF?=
 =?utf-8?B?NE1zU3d2OW1vcytCOElZdlFQbDhXR0lnNEtzRmlYL0dPelc1L0RxYkxVa25P?=
 =?utf-8?B?Um5iT0JYYnRYWkQyQlVwTDJVWGl6MEZISjRyczZGZE9PeWZSWFE1ZndLWWpn?=
 =?utf-8?B?ZjlWVTdGd0x5aVV4ZjBjdXl6TWxFaWpJZ0pyZmp5OS8waE1adHI3V1IrZGpx?=
 =?utf-8?B?blFvY3N4azBhdFhXN0J4eWtXTHN2VU92Sm9RQjRWdm9VSmxxU1NveVVhNTEy?=
 =?utf-8?B?R0FyMTNCN3hvdlU2MnJXRm5zNEFqZ2hnbVd2R0ZxSkQyN2x6Tm5xYnBhSmJu?=
 =?utf-8?B?UWhCcmdaanAxb1FJSUhoYVNYdXc0QTFaS204dTArVnBmNy9lcWhLS0NrSGRI?=
 =?utf-8?B?MGFmWkRTNmVKZEVwNy9RcWMreUxtNUszK2NBd2dwNDNldEpqTDQ2Umw2Z0J1?=
 =?utf-8?B?d1FFNlVJQTRJNWxYSEJHUDRvQ0JoYmVKT1N5NnhSclB5R1RXTjZRcUt1TlFz?=
 =?utf-8?B?MFVaSEhLTCtjdmRoUGs1Y1FDUWlWZ09wQTVQR24zQTB2RHRjMTM3Y0hwQVd0?=
 =?utf-8?Q?6oEzqWoTBLSO+pYQm0/hYCU=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d304cf-c4d1-4aa2-0ef2-08ddcf9ec39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 19:24:54.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alFeDclhhWdKx7EwjFMqGV0jswjf+o1wucChaEhGmsHfGv/wUSPFPwYbbL/oF1SonY9dyvlZXxCy2qws3MsCNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4862
X-Proofpoint-ORIG-GUID: c3xRlRqgtp5HD07OeOKtF34MVbJ5VxmN
X-Proofpoint-GUID: 2eVDGSd6XdmzKh4LzOlrTOw-omMLYprW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE0MSBTYWx0ZWRfXyumAhSnlyUQB
 lgLwTdvhvb0fg05mlvTa595TI/aqgzqoJp+7EkE6V9xKN6oIdxD6Q6/s0a2wRBplipgioCFvBtX
 jNck9eHnrLxqCzPMilGKR44aFaF6n0UBTt0Pj/m1F4QMsAvakRT8oRromHsSftzQrqE4jxJTasK
 WdIrNEmpp+CTtpheScYKY6RGenAe3xeDctGajQ72wR8iI9x8Rm+JqcR0dfjtFpAaNsCo0iL2fdu
 JZ22qTHHERMPacgt147+8hbivgHS22b2SsKs4+MOYEW7jxbavJJSh62a6Zhrwa69nRmI0KdOf1s
 MVEmLHyEOa4Ce+otfh/YeEjsatRTGxcEdYsno7J8wheaONarT44d4Jv9SZI5TT7l5+Gx0VTfTUA
 pohNSvM0YXMjDEENJYXxMdnvg0FEZjQ3TG4D4wEZ+HtGJvqu+XIds1bo8J+xQv2QQZsTfJp/
X-Authority-Analysis: v=2.4 cv=ZoDtK87G c=1 sm=1 tr=0 ts=688a718b cx=c_pps
 a=+wTz3zXVXQH4ZUjsIrltNg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=P-IC7800AAAA:8 a=hSkVLCK3AAAA:8
 a=VWBmn72FBt9KbntScDAA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <27B31418EEFB374CA8E13AC5BE55A74A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v4] hfs: update sanity check of the root record
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507300141

On Wed, 2025-07-30 at 08:21 +0900, Tetsuo Handa wrote:
> syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
> operation when the inode number of the record retrieved as a result of
> hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
> commit b905bafdea21 ("hfs: Sanity check the root record") checked
> the record size and the record type but did not check the inode number.
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b =20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/hfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index fe09c2093a93..d231989b4e23 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -354,7 +354,7 @@ static int hfs_fill_super(struct super_block *sb, str=
uct fs_context *fc)
>  			goto bail_hfs_find;
>  		}
>  		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
> -		if (rec.type !=3D HFS_CDR_DIR)
> +		if (rec.type !=3D HFS_CDR_DIR || rec.dir.DirID !=3D cpu_to_be32(HFS_RO=
OT_CNID))
>  			res =3D -EIO;
>  	}
>  	if (res)

Why do not localize the all checks in hfs_read_inode()?

We will do such logic then [1], even if rec.dir.DirID !=3D
cpu_to_be32(HFS_ROOT_CNID):

root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
hfs_find_exit(&fd);
if (!root_inode)
	goto bail_no_root;

The hfs_iget() calls iget5_locked() [2]:

inode =3D iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);

And hfs_read_inode() will be called, finally. If inode ID is wrong, then
make_bad_inode(inode) can be called [3].

If we considering case HFS_CDR_DIR in hfs_read_inode(), then we know that it
could be HFS_POR_CNID, HFS_ROOT_CNID, or >=3D HFS_FIRSTUSER_CNID. Do you me=
an that
HFS_POR_CNID could be a problem in hfs_write_inode()?

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v6.16-rc6/source/fs/hfs/super.c#L363
[2] https://elixir.bootlin.com/linux/v6.16-rc6/source/fs/hfs/inode.c#L403
[3]=20
https://elixir.bootlin.com/linux/v6.16-rc6/source/fs/hfs/inode.c#L373


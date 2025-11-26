Return-Path: <linux-fsdevel+bounces-69925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AA6C8BF92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D17093570D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 21:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2A26CE11;
	Wed, 26 Nov 2025 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gw1so4Xy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED9263899
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191371; cv=fail; b=iYXX6D6vN7rxNHUgBEm0UJwq8uMLKjuDUaqRFCphvumb5QRjsPv6SpItV/xw5hYkvcyBWXmIBuDXse+TdS7efNp2MmQrv6FTtKCN2QKfBVDde/Bd9QM/qqUZthIPex8AtYzZFJYMFkDNBpSzUo4FR8MiMTVBzXHGb0TkfEJMRVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191371; c=relaxed/simple;
	bh=LeRufXmQB12RGn3Y+blA6ZcInyQTzkKXg6tnzSUdLHQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=evhBcMREYYhnAKjDEsEbYTcIZIAgdLWVTATMJek4tK9mOdQEeWARYjf4XpbllO0WIDbJbMHGOuMQZTcKhBxrymkNyp95a2Upvrorj5qBX1HtTgU5LqLtJYobvIA9vPd6oJFvdSJe9Nd+iwqnAiTHThnxGqwws7g5c7+UBAd5Ngg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gw1so4Xy; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQGvdIS000693
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 21:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=O+cxMDcQW8f5Cz8gHuYdAWauWEm2tVeJo3BmScbpdhI=; b=gw1so4Xy
	kavbzSlit22SC0VfaaP36hc8m52aW9yu6ChfefZcpeFjQwOFBdvTuFWZ8IW2vbWV
	d+Vbu9k9axgdEdB3q+LYtnNSpRtrbtZeQnJRGLy1F6bDvxEjqchNZ58crl952dxw
	6pA4QrkLF4B3mzkk4/lt/P+t8sLJCvhBPu8YlYzjxFUO9acN8n09fU0e5vpE2bTM
	5RUOxj87zcpzfXwM4wLpE0P/ZJzHzDCWrlKtkHUCrjDSg6BBVBs7UgAA4uazxqFn
	7O0KUS0C9qejPhT3hYIBVkwH2w2uADG66sfPhJ/xYU62Dl1nik0b3+PVIcFvKGBH
	qf83w7EY8LRPrQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9pejs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 21:09:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBGxCiQtC7xQpCeI1owlII+sYLxP+N+syRECfB5cl9AY0p4UPA50MRs+eqIY6qheHwsC3MjX/wc8/vvqEIhz6WLW+w9LjGjE9N7/MWqHWJdl26VPqje21oxLKJszK98x5to/SaW6I9JFg7GVDErMxut25i0PO8wy+48odRYSazNd+TGJZ55JEzz1J5jf7KKrVVew0Xa/nFOYc1gbgFpLFAseArB4JNVIy2AhghzNQ05tio18zw8BW25yNW5SuvVJlteNMOaiGldylbRWgA8zqaUtkcuGgChh3pc3wSCagG1ZiGix6W4PLMB0NZcN3WRCwFFf77LYaQmS890w/9TBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJBFrQRSlFgDeUDC927PMfrOZbWT4P9KwEZNeJWvK1Q=;
 b=l9fYgwU3c0M/RFV9ob3SOqgSkt9ByLnf/qghzsRsn6ofNfZrCx7Nsl3Dcdj3vMRJcXtWlo2aRgoJWmbUgz3qx4Y/vyV9rD/KqNskayTU6d1dTB56ivZYsaYUfgrzmAxVR/dnGCOHZiW28LaVNOr07hUIa/2+UnC4/5tG2+5uldYE14uN1ahq7yFrSbPVDqUHGB8FGullWj8ErB8PyOdwhaLC8zjX26kE2FAgdyFcj5qsRbMuru89GBzDSk5bSFD/2iFwsSH1xQMn7VBaOQRcRTRECJLsJGZZwwE/poWOMA6OWkBvPhl5TtVKjgNH0QyoKUjYvI0cesuvm6TzJlBgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3747.namprd15.prod.outlook.com (2603:10b6:208:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 21:09:24 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 21:09:24 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com"
	<syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2] hfs: replace BUG_ONs with error handling
Thread-Index: AQHcXlBrdjdzGENNu0CSTE/8qaMJCrUFdT+A
Date: Wed, 26 Nov 2025 21:09:24 +0000
Message-ID: <18cf065cbc331fd2f287c4baece3a33cd1447ef6.camel@ibm.com>
References: <20251125211329.2835801-1-jkoolstra@xs4all.nl>
In-Reply-To: <20251125211329.2835801-1-jkoolstra@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3747:EE_
x-ms-office365-filtering-correlation-id: 7e641991-9f52-4e07-75da-08de2d3013d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vkk5TTJIMDlYNVJKVGlDbnZGaTJQVUxXTHFxdWZPbVNLZ1hDcFIwK2ptOHlx?=
 =?utf-8?B?aGJtZHA5WmdSaEpOTEVZeDlyZFFYVHJQNFhKWDFvYW9TbmpzYmovM2JDMnNv?=
 =?utf-8?B?aHl0UVVLKzVXb3E2MUxQdytHcFdLNWhNcmZybUJkNkxyUW13aTU2b1p2MklN?=
 =?utf-8?B?R0txWG5aRWprNFc3NnRRb3cybk5nSGtydHhjMVUzdVg2dytUUmpqY05RVTk5?=
 =?utf-8?B?SDIwSGZrQXlDcm9xcXBmV1c1bGhXd1ErdGxsaHZJL3lqaTNLdzRUNXRNZHlm?=
 =?utf-8?B?R05OR1lSenAzZ0dPSTVLVHdyT092blk2K0xjK3d5QmFXN3hkSWtGWE0vVFZy?=
 =?utf-8?B?VjFKdUZOd0FXYmJ1Ti9pak5QaUszOFV5ai9UU3ExRHhUVkVpTlMwQ3UvQllw?=
 =?utf-8?B?Q3hOcXZNVVc2NU5ibXZJOHZVWmRva2hmT3E0bGZscCtwYTM5UUgwUUV2TXY4?=
 =?utf-8?B?TUwrenFaa3ZDc0N3SFVLLzZsK3RnVll3T0llRHR3ZTlOTmgwZHRQQ0E1NzFN?=
 =?utf-8?B?SjRBUnNNY0p2VVc1ZWwxeXFlSUJrZjFJUUFZRVFGdGJqMlpVU2dsMEovTThJ?=
 =?utf-8?B?OWFJdzZCbmh4Y1ZtSWVkV0JwcTFKZUdIUFJXYUp3NWFNSTlVUE9FMkV0MnR2?=
 =?utf-8?B?cUlTMnk5RG8xdHE0ejF3N1dRdWdWTjA5Ynk0NUlJQTdmUkw5TUxGay9rOXV5?=
 =?utf-8?B?ZU1TclJib0VINVhvTk1CcTJxU1FhbUxST3RlZTUxMzNQZU1aMzJneU5QeHN3?=
 =?utf-8?B?TnlIUWJ5S1ZEcDNMUWprVDBTV2REYWlaYllVcjlwRDNLQVFRV3pJazY2aGtP?=
 =?utf-8?B?eWhERUQxbXFqMU82V0YxUUtRMnFaSWtVV3IyV3UydnBZSWV2bUQ5YkJ3d2N6?=
 =?utf-8?B?eGxVTnc5QTQ1R0pGSVI0OXdJanBNYkRwL1JyOWt2bHI1K2hoQjFoZHpoMEhk?=
 =?utf-8?B?RUx6MUJRZHMvRWU3czNTaTdQaEhZSlhKY3piMzlHczA1ZWhNSVJxbkVJZUVh?=
 =?utf-8?B?amFYZWtMTitRQjlNS0FVUXI5NXRsQVVZTWRLcUtTVUh0R2VBR1REa3I3cHR4?=
 =?utf-8?B?OU0ycmxZb01aeDRIV2t2UDBDanBSMjJYQ2FydHY2RU5PdGVDaloxaTRmLzhi?=
 =?utf-8?B?M01TRUxaVk1qRUNRNjNDcndwSnVZazFOblNJTjhydEMzSzdZazJVWnBDdERh?=
 =?utf-8?B?VHBiamtUcmhGaTRWdjgrZDdoNlFWUEp1czZMWjA1cWdQRFZsdmdUSkJkZWlU?=
 =?utf-8?B?MDRDZjNGcFlmWFNEdVdzZURETWNJTDc1VnhDZzc0bGVFejBzY28zaHZFeG05?=
 =?utf-8?B?R1crUjkwN0lqeGo0aUdTYUdOQWVDWlZoSFJrc3dkNWxNTmpkMTduYkpLTlh4?=
 =?utf-8?B?RklBWFdlUnRCVUhqYmVhQjMveEc1RUNlWExFeHdoZEFlL0RydWxoNUhyMlJz?=
 =?utf-8?B?V1RYR2VzNEF6N0dobXpKZzNlbE9WQ244M1pJZlpDYXJDQzc4d1lWV1kzbFJj?=
 =?utf-8?B?QWZFSkFlVUFNNkRnQlpnZm5ibnEyRXgrRjAvVUlpbWdySXVTMXRKbHhOSGpx?=
 =?utf-8?B?eVY0c1pXM1FSMnd2WlBhb2IrcjhNbnFnTEMxaThEOUZyOHBtV1N1eGQ1VC9J?=
 =?utf-8?B?Tm1BNUVJRkNwNXRYZHNFQVVXWEI2QnZSaHdUQ0kyZEE0NEtvMUh4aE1iWk44?=
 =?utf-8?B?TVNXV050eWh3NDV4U1R4Y2VGa3M5TWxOMUdqcjNpQ1pqN1RkeGpwK24wV25N?=
 =?utf-8?B?TzFUejlqM0pCQUJVSDBPbksrNlVMVktPeWJaQ2xPMFRhMHp6ckczMW1KUzU1?=
 =?utf-8?B?TTZwSThpZnAxYlJXVXk3aDVwS3g2WmlWVFBuelJSL2NPbUlNT2RxMFBHa1o3?=
 =?utf-8?B?MmI5MEdobFhka3J6d205MnlDeHh5L0dydFZOUzZnS0lyZk43ekN0eWptQ0t4?=
 =?utf-8?B?VDF2S1JYWk0wRUlyeFAvSFNDR0FiNTMwWURPMDI4RnZqYk9zU3k2UEswR3oz?=
 =?utf-8?B?UFl0Nml5WHp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1FaWk9FYThnSzdPUVU1MVAzOEx2aUk5R2VTQ3Z3anRka1d2YlYxem9YUjdU?=
 =?utf-8?B?bkpmSE1pb1NJa0FaSjFiajRKWXR1MWU4QXBDQ0ZyRGY3TjN0cmcwUXBHc1Ft?=
 =?utf-8?B?c1hKNGtrOWpFVlFtdHVaeW9EOExjMXlQNVNMN2RCcS9KUFVlVzg5SUxveFJp?=
 =?utf-8?B?TnFsS3VkUDBXY1oxamluTVRITmQ0amZQNUgyeW9QeHMwNmQ1bEd6bWdVZXdn?=
 =?utf-8?B?cnk2ZFZ4VVhEUEFOa2RFVzFvcWJpU2Q4Q09SbUtqSDJQY3NNS1FjNDNIME5l?=
 =?utf-8?B?WFlhTmptSU5TMWIvK1hmN3d1ZmRkdlBlWVkvSUtOeVdHL1diaFRyRzQzVnJY?=
 =?utf-8?B?MTZqd1F1SEhKUWFYVUUxVmtTcXFXT0FSRlJSOFF5bC9GL3N1V2wzbVgzaXJW?=
 =?utf-8?B?WWkxRUFUVEFHU3RZV1c0VjdMM2Fidk9JOUo3ckdtb0tCbWhYNXcxR0xQY3dB?=
 =?utf-8?B?cm1qQzEyWDg1ZjRpRVhmY1V4ZXNrMUVweHlHZkk5cXBvTTM5R0d2NTVEL3A4?=
 =?utf-8?B?RTFYbWNIdWVaUU13eGhMcHoxa0hIOVBZdzJGcFh6enI1OTJuTStoM2hPa1g4?=
 =?utf-8?B?RzNtTFdIUTk2emEwUnF5bEtidldVajhlN3pGQ3pmcXJlb0x6RXB6bEVLU0c3?=
 =?utf-8?B?bFhKM2E5STh6eHQvL2ZpN05yTWpOTy83UFlJem93Smo1YmJMRWRzMFVWbHV2?=
 =?utf-8?B?V2hYdzRGdmxoTlkxTFFPbk90Q0pPWmJqUlgycTVyczV1b1ZUNFNFZncrVk9w?=
 =?utf-8?B?RitWdjEyaHBZbnBBRFVPRWNHR1MyMWNoUmhJQXM2RWkrRDVOUzFxQWw3a0xB?=
 =?utf-8?B?NnNxRFBHTmpWRzhSUktRTXRzYWhxWHNOb1VhdFlTTXRLMnBtNnhrQkRlNDZj?=
 =?utf-8?B?Rm9CZEE4RVFsMGRyUlJOdHB1dXFBZm81QkJCazhNaHE0STdjdnVHMnpHbko3?=
 =?utf-8?B?WEFiK1VFTmZTWndtKzhGL21lMzc4bGdTcHEvNkYrSno4d2FES3JoV2ZyRTBi?=
 =?utf-8?B?RTdtUFZNYkIrL0xmeU9JekpGQW12b291bC9qakxXTHNuMTVBdXRkZjY1eGI1?=
 =?utf-8?B?djdSUHRxVmFoYXR3ZW5oMXZLaHFjenB4VHR1THA3SDk3UWZrRmNDTHVDYXJV?=
 =?utf-8?B?a2Qycnc3SW5qWk41SVlsSVVuQ3ZiY1hWdmlJSXBMVjRzZG9DaGZyZFBRV0dV?=
 =?utf-8?B?ZFdEdWV0ejJpWjF0Q0FxYzByZjFoOE9wL3QraklGNEhqMkF0S2xWSU9lTzRZ?=
 =?utf-8?B?RUthUE5ucFl2ckFDNXdDdGN4WHNLVjBwbnRTQWxvak9oL3BkbGNCcDZRWjlK?=
 =?utf-8?B?UGwwcEFMc1ZYbkFXY1JsNDVSbXdzTzlWTlRtUkxkOXZlanAxbGxwckdRWUg4?=
 =?utf-8?B?aDZtLzI2TldselVyOWZ6blFaVW92ZjZxTnJ1OUZCYlhSOTFYUFk4TUpZT1Zu?=
 =?utf-8?B?VlUxMTJTTVNFLzRGeTZoU0FIajdGWVViZnYwYzhFdGpuZ0U1ZExrbUJSb3FZ?=
 =?utf-8?B?TTI0b0VJVXJTam1SdlN6RXVDQ3d5V0ZIcTZJVVdvdkNtb1FLL1pkUkF2ZDg4?=
 =?utf-8?B?YXg5WE0xRVlsMG1VUDVBbFJXTERwV1NvbGszajYxRUJMTkc2UDVVaFZLdUNu?=
 =?utf-8?B?cHM5NVlWRWpQdmRLVHM4WWlMZXA2OGNXWUV4ajlGODJpbm5ubWlJdjhxM1c3?=
 =?utf-8?B?TGFLeGp0VE9GNzdXUGJSWnJWU3d3YzlxNTRkenRjNUdENWZ6TUh3bzR6dHVn?=
 =?utf-8?B?RXgzYnArZzQrWC9TZXNWTVVIYUU5aEtBeHBhck1FMEZ4eEh1M0l0cjZNNllC?=
 =?utf-8?B?c0kwRk1WdGdXTjJiS0RwTi9raldNeXRzZ0xxRE83RjFtSHRlbW9UYmpSZURs?=
 =?utf-8?B?MFVLSkxIOWRGN2dXZEtjVmFvRGVBUTZqVWJZUXNPV1B5akVPSURVY2ZxOFly?=
 =?utf-8?B?VThtaE9tZmRhczlkWXRMYXN1YWRYOU1CK3FxbGhuSW5PaHdyVFdWOWQ2YnB6?=
 =?utf-8?B?cE5ldkt6QU90M0R4OXJjNDlSOE9iZVdUK0krUmxKUTJnWUQxREdXVThUdis4?=
 =?utf-8?B?eHJIYzI5REtPbkNHdGdJOGZ3Z2lCeXdleFduOCtDV2tocmluWUdaQk9WNWFu?=
 =?utf-8?B?STVBc2VIREJ4dm1sWHY0bUh4a1hodTBFZ0U3OGFoOFFyU1doSmFTY2UrU0xv?=
 =?utf-8?Q?gw4sEHhrj4Z/UvN/1lKOd7M=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e641991-9f52-4e07-75da-08de2d3013d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 21:09:24.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hEMs1LkdYTl94Vu1Vfw1IMxiEXhkGMbne/SwJVDzjN78n3KijCOyBA/Jr3SS3OgGOXHMCTC6DH1zdiq6Dr6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3747
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX9KmZcVqza+bB
 OC+loSlKW4ylKB72yrPCZHAiNbPnkEVx/VHkyNhIbdEEfI1x/Z+DZ+FPB3+UsY3Ub9O9Kms46Xq
 JuxV8R8LpRMJUxH+zpneXKTT7qPPbK9v7bpQXnDUsgHTG7Lt4iYMxDvysGQgpnU97RxbsZn9J44
 XDAe1k4JZ6hKIyVx8gv4K4BbrU/iUV8acFEDW9HHCeLCAEx1/5kdb/s9Ln1rdzvZV1BNTsLwDi6
 /6HMKwUaDWCUsHpJXrBDqVnwii/0r1S8oGzZtOaK2SWHVM/JuziTJWnbTSTsD9tvvFIqKVdkLH5
 QrjKzKUBLSXp8c3OANfVekiRLzeq2j+HD4Hl09euoVQ+iqsoYj4uEPxhV14SZUxQad1pLVFFMX2
 4II1aguQbTCYFTJUumk8S0DiRGY1ow==
X-Proofpoint-ORIG-GUID: pNLYZqWj53dojlEaprgduylXQKUyLfhk
X-Proofpoint-GUID: pNLYZqWj53dojlEaprgduylXQKUyLfhk
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=69276c87 cx=c_pps
 a=cGw96uMdUXN41aDBKcSctA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=-ibLmwfWAAAA:8 a=P-IC7800AAAA:8
 a=xOd6jRPJAAAA:8 a=hSkVLCK3AAAA:8 a=FJfzTpWBagFooYhb7DUA:9 a=QEXdDO2ut3YA:10
 a=A6MkUVyZPcTV1i89ro0M:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cQPPKAXgyycSBL8etih5:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1FD33205CA5B440ACAA9096A3D2EF37@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] hfs: replace BUG_ONs with error handling
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

On Tue, 2025-11-25 at 22:13 +0100, Jori Koolstra wrote:
> In a06ec283e125 next_id, folder_count, and file_count in the super block
> info were expanded to 64 bits, and BUG_ONs were added to detect
> overflow. This triggered an error reported by syzbot: if the MDB is
> corrupted, the BUG_ON is triggered. This patch replaces this mechanism
> with proper error handling and resolves the syzbot reported bug.
>=20
> Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D17cc9bb6d8d69b4139f0 =20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/hfs/dir.c    | 12 ++++++------
>  fs/hfs/hfs.h    |  3 +++
>  fs/hfs/hfs_fs.h |  2 +-
>  fs/hfs/inode.c  | 40 ++++++++++++++++++++++++++++++++--------
>  fs/hfs/mdb.c    | 15 ++++++++++++---
>  5 files changed, 54 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..03881a91f869 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct=
 inode *dir,
>  	int res;
> =20
>  	inode =3D hfs_new_inode(dir, &dentry->d_name, mode);
> -	if (!inode)
> -		return -ENOMEM;
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);
> =20
>  	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
>  	if (res) {
> @@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idm=
ap, struct inode *dir,
>  	int res;
> =20
>  	inode =3D hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> =20
>  	res =3D hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
>  	if (res) {
> @@ -264,9 +264,9 @@ static int hfs_remove(struct inode *dir, struct dentr=
y *dentry)
>  		return res;
>  	clear_nlink(inode);
>  	inode_set_ctime_current(inode);
> -	hfs_delete_inode(inode);
> +	res =3D hfs_delete_inode(inode);
>  	mark_inode_dirty(inode);
> -	return 0;
> +	return res;

This modification doesn't look good, frankly speaking. The hfs_delete_inode=
()
will return error code pretty at the beginning of execution. So, it doesn't=
 make
sense to call mark_inode_dirty() then. However, we already did a lot of act=
ivity
before hfs_delete_inode() call:

static int hfs_remove(struct inode *dir, struct dentry *dentry)
{
	struct inode *inode =3D d_inode(dentry);
	int res;

	if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
		return -ENOTEMPTY;
	res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
	if (res)
		return res;
	clear_nlink(inode);
	inode_set_ctime_current(inode);
	hfs_delete_inode(inode);
	mark_inode_dirty(inode);
	return 0;
}

So, not full executing of hfs_delete_inode() makes situation really bad.
Because, we deleted record from Catalog File but rejected of execution of
hfs_delete_inode() functionality.

I am thinking that, maybe, better course of action is to check HFS_SB(sb)-
>folder_count and HFS_SB(sb)->file_count at the beginning of hfs_remove():

static int hfs_remove(struct inode *dir, struct dentry *dentry)
{
	struct inode *inode =3D d_inode(dentry);
	int res;

	if (S_ISDIR(inode->i_mode) && inode->i_size !=3D 2)
		return -ENOTEMPTY;

<<-- Check it here and return error

	res =3D hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
	if (res)
		return res;
	clear_nlink(inode);
	inode_set_ctime_current(inode);
	hfs_delete_inode(inode);
	mark_inode_dirty(inode);
	return 0;
}

In such case, we reject to make the removal, to return error and no activity
will happened. Let's move the check from hfs_delete_inode() to hfs_remove()=
. We
can ignore hfs_create() [1] and hfs_mkdir() [2] because these methods simply
processing erroneous situation.

>  }
> =20
>  /*
> diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
> index 6f194d0768b6..4b4797ef4e50 100644
> --- a/fs/hfs/hfs.h
> +++ b/fs/hfs/hfs.h
> @@ -287,3 +287,6 @@ struct hfs_readdir_data {
>  };
> =20
>  #endif
> +
> +
> +#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */

I don't think that rename existing error code is good idea. Especially, bec=
ause
we will not need the newly introduce error code's name. Please, see my comm=
ents
below.

> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index fff149af89da..21dfdde71b14 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -182,7 +182,7 @@ extern void hfs_inode_read_fork(struct inode *inode, =
struct hfs_extent *ext,
>  			__be32 log_size, __be32 phys_size, u32 clump_size);
>  extern struct inode *hfs_iget(struct super_block *, struct hfs_cat_key *=
, hfs_cat_rec *);
>  extern void hfs_evict_inode(struct inode *);
> -extern void hfs_delete_inode(struct inode *);
> +extern int hfs_delete_inode(struct inode *);
> =20
>  /* attr.c */
>  extern const struct xattr_handler * const hfs_xattr_handlers[];
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 9cd449913dc8..ce27d49c41e4 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -186,16 +186,22 @@ struct inode *hfs_new_inode(struct inode *dir, cons=
t struct qstr *name, umode_t
>  	s64 next_id;
>  	s64 file_count;
>  	s64 folder_count;
> +	int err =3D -ENOMEM;
> =20
>  	if (!inode)
> -		return NULL;
> +		goto out_err;
> +
> +	err =3D -EFSCORRUPTED;

In 99% of cases, this logic will be called for file system internal logic w=
hen
mount was successful. So, file system volume is not corrupted. Even if we
suspect that volume is corrupted, then potential reason could be failed rea=
d (-
EIO). It needs to run FSCK tool to be sure that volume is really corrupted.

> =20
>  	mutex_init(&HFS_I(inode)->extents_lock);
>  	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
>  	spin_lock_init(&HFS_I(inode)->open_dir_lock);
>  	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, =
name);
>  	next_id =3D atomic64_inc_return(&HFS_SB(sb)->next_id);
> -	BUG_ON(next_id > U32_MAX);
> +	if (next_id > U32_MAX) {
> +		pr_err("next CNID exceeds limit =E2=80=94 filesystem corrupted. It is =
recommended to run fsck\n");

File system volume is not corrupted here. Because, it is only error of file
system logic. And we will not store this not correct number to the volume,
anyway. At minimum, we should protect the logic from doing this. And it doe=
sn't
need to recommend to run FSCK tool here.

Probably, it makes sense to decrement erroneous back.

Potentially, if we have such situation, maybe, it makes sense to consider to
make file system READ-ONLY. But I am not fully sure.

> +		goto out_discard;
> +	}
>  	inode->i_ino =3D (u32)next_id;
>  	inode->i_mode =3D mode;
>  	inode->i_uid =3D current_fsuid();
> @@ -209,7 +215,10 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	if (S_ISDIR(mode)) {
>  		inode->i_size =3D 2;
>  		folder_count =3D atomic64_inc_return(&HFS_SB(sb)->folder_count);
> -		BUG_ON(folder_count > U32_MAX);
> +		if (folder_count > U32_MAX) {
> +			pr_err("folder count exceeds limit =E2=80=94 filesystem corrupted. It=
 is recommended to run fsck\n");

Ditto. File system volume is not corrupted here.

> +			goto out_discard;
> +		}
>  		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
>  			HFS_SB(sb)->root_dirs++;
>  		inode->i_op =3D &hfs_dir_inode_operations;
> @@ -219,7 +228,10 @@ struct inode *hfs_new_inode(struct inode *dir, const=
 struct qstr *name, umode_t
>  	} else if (S_ISREG(mode)) {
>  		HFS_I(inode)->clump_blocks =3D HFS_SB(sb)->clumpablks;
>  		file_count =3D atomic64_inc_return(&HFS_SB(sb)->file_count);
> -		BUG_ON(file_count > U32_MAX);
> +		if (file_count > U32_MAX) {
> +			pr_err("file count exceeds limit =E2=80=94 filesystem corrupted. It i=
s recommended to run fsck\n");

Ditto. File system volume is not corrupted here.

> +			goto out_discard;
> +		}
>  		if (dir->i_ino =3D=3D HFS_ROOT_CNID)
>  			HFS_SB(sb)->root_files++;
>  		inode->i_op =3D &hfs_file_inode_operations;
> @@ -243,24 +255,35 @@ struct inode *hfs_new_inode(struct inode *dir, cons=
t struct qstr *name, umode_t
>  	hfs_mark_mdb_dirty(sb);
> =20
>  	return inode;
> +
> +	out_discard:
> +		iput(inode);=09
> +	out_err:
> +		return ERR_PTR(err);=20
>  }
> =20
> -void hfs_delete_inode(struct inode *inode)
> +int hfs_delete_inode(struct inode *inode)
>  {
>  	struct super_block *sb =3D inode->i_sb;
> =20
>  	hfs_dbg("ino %lu\n", inode->i_ino);
>  	if (S_ISDIR(inode->i_mode)) {
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
> +		if (atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX) {
> +			pr_err("folder count exceeds limit =E2=80=94 filesystem corrupted. It=
 is recommended to run fsck\n");

Ditto. File system volume is not corrupted here.

Please, see my comments above related to hfs_remove() logic.

> +			return -EFSCORRUPTED;
> +		}
>  		atomic64_dec(&HFS_SB(sb)->folder_count);
>  		if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
>  			HFS_SB(sb)->root_dirs--;
>  		set_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags);
>  		hfs_mark_mdb_dirty(sb);
> -		return;
> +		return 0;
>  	}
> =20
> -	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
> +	if (atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX) {
> +		pr_err("file count exceeds limit =E2=80=94 filesystem corrupted. It is=
 recommended to run fsck\n");

Ditto. File system volume is not corrupted here.

Please, see my comments above related to hfs_remove() logic.

> +		return -EFSCORRUPTED;
> +	}
>  	atomic64_dec(&HFS_SB(sb)->file_count);
>  	if (HFS_I(inode)->cat_key.ParID =3D=3D cpu_to_be32(HFS_ROOT_CNID))
>  		HFS_SB(sb)->root_files--;
> @@ -272,6 +295,7 @@ void hfs_delete_inode(struct inode *inode)
>  	}
>  	set_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags);
>  	hfs_mark_mdb_dirty(sb);
> +	return 0;
>  }
> =20
>  void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> index 53f3fae60217..45b690ab4ba5 100644
> --- a/fs/hfs/mdb.c
> +++ b/fs/hfs/mdb.c
> @@ -273,15 +273,24 @@ void hfs_mdb_commit(struct super_block *sb)
>  		/* These parameters may have been modified, so write them back */
>  		mdb->drLsMod =3D hfs_mtime();
>  		mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)->free_ablocks);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
> +		if (atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX) {
> +			pr_err("next CNID exceeds limit =E2=80=94 filesystem corrupted. It is=
 recommended to run fsck\n");

Ditto. File system volume is not corrupted here yet.

Breaking logic of hfs_mdb_commit() looks like really bad idea. Especially,
because we don't return any error message. I am thinking that, probably, we=
 need
to consider of moving the check of next_id, file_count, folder_count from
hfs_mdb_commit() into hfs_sync_fs() [3] with the goal of of converting file
system in READ-ONLY state and returning error code.



> +			return;
> +		}
>  		mdb->drNxtCNID =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
>  		mdb->drNmFls =3D cpu_to_be16(HFS_SB(sb)->root_files);
>  		mdb->drNmRtDirs =3D cpu_to_be16(HFS_SB(sb)->root_dirs);
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
> +		if (atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX) {
> +			pr_err("file count exceeds limit =E2=80=94 filesystem corrupted. It i=
s recommended to run fsck\n");

Ditto, please, see my comments above.

> +			return;
> +		}
>  		mdb->drFilCnt =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
> -		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
> +		if (atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX) {
> +			pr_err("folder count exceeds limit =E2=80=94 filesystem corrupted. It=
 is recommended to run fsck\n");

Ditto, please, see my comments above.

Thanks,
Slava.

> +			return;
> +		}
>  		mdb->drDirCnt =3D
>  			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
> =20

[1] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfs/dir.c#L205
[2] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfs/dir.c#L235
[3]=20
https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/hfs/super.c#L37


Return-Path: <linux-fsdevel+bounces-20219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9E8CFE89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5DE280D7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5B13BC2B;
	Mon, 27 May 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Cis668k9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8E13B585;
	Mon, 27 May 2024 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807750; cv=fail; b=SGITJPZ8l529fk6m2INe/fHtlbcQ6xwXQqqd/dSIQDW/Hn2/hfUZ068PMy4QgQzAOPaBiXtTrWEROUK10n1SBB2rxvSGFhUxnNUTE1aMEM2H7riSOJL9KNKHo357sEwblemOJmrShozDqxr8z2riNrWTaRWtKfLK+r0azy8DbJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807750; c=relaxed/simple;
	bh=pvID+ZugZZfqayUOPjIXBsdTa3GXMvwRPSQS2gsEeNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BEBRTjsvGwMCzp0+YfxgntGfntxCrh7VtvYRN9h4H/WmJo3jEvZkTo778JVA6/klSxOSJkdGnFxKR/XGCDtp7WtI/O1yMm19Z2OJYjrlYTUsuYKBMPRWHgYnUFO9bn1gI9XpXeowd2wfJQxfq61io+mmfVP4hFfmOSatGL3sNeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Cis668k9; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAPY4U012266;
	Mon, 27 May 2024 11:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=S1; bh=n
	wXOu+3epKPFrkp9c8B9PZ1ELWMmTKe6ttROcxCBk38=; b=Cis668k91iR2JlLYT
	FwWe91v3WRABDIquaWSe/LIOvd5whDuziEsr4TrautKCm9kM+BLxhiYJYs8dkvoD
	KsQryB6R+mE0vxz9pUwSHzNk9DkXP3IJcBHti3UvBuf1XCEyjRgO0hHWnxDZ3qN/
	ZA7z6kkZ2R/UetGqDyVtyeIC+TwWbm2UiQruGf1opBLmTxJCewBjMSCwSLMOznPz
	sqr1SE5OpEr7COAHYfpS/46ejeC1eR035zrGtiK02W6V3QoLFcIYWICJAqP6vlYb
	TG32wqKBPRy/f+yh84EX0JLLoVUMwu7uiM6FtLoChsgKvOZ8i2eJxO25UA1/buLp
	snLPA==
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2168.outbound.protection.outlook.com [104.47.23.168])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yb8209qus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 11:02:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY6aD1T2R+qslwwpJijZndh2haz3dTthyvBq+wtEutyrBCgm59+hkN7tISpeITevhH4ZQ3byBguqRKUTKj5l+cJHV+rkaHG3wm5ZdXHEhD2VIadIYbltix7KBpNlr9gXz/IEUp++R1DjQwDnMJVaHH/rcNn07NGZ2djGUtdlgtBsL4zkijeoGy1vX1Cbn+eCrG7vd7Souia9u4n9yo5f7JnVuFZgIifuRKQc/EvTkqyLIgP0tFNcgMnF9/oCyPFJFsdAO6UkSiD0Qn9xm7Y/W1aooYmlR3TtTjGH3NnPuw9ioETztH+C4CmT/+V29I3JWtxyrNIS/+f2y2pe5PzKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwXOu+3epKPFrkp9c8B9PZ1ELWMmTKe6ttROcxCBk38=;
 b=UALP7JextFlokKLoritbz1Rb08egKXAi7rRmNkJTHvjukCo0LdU/PNQxS7ht04kO+yanQkgBV76dcgPVHzcj8XQeD8ZryJ9RIjMgUkRlWQLeOLoDAgD5x3J45UMCEnWErYLkX1fvt5QzQfYrJaBl5B0X7QW6YmRIK4doCZSEF67styIkMw7Z/sIS0tH4kKt4VmMpRdiR/MNQhYvoyE+g74rihIyuD4fFMdVIz+V2u+DkVhhlTVKBmY/2kr1tEhDM0QA/+YOyz/M3m0vIOS0BBUhxEJsYQxDLMr4VFtDKNMUK+a4Ru3k8pIIIUJ/FAbmESVSSCw/I7fkgUoiST1kCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com (2603:1096:404:c9::14)
 by OSZPR01MB6971.jpnprd01.prod.outlook.com (2603:1096:604:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 11:02:05 +0000
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1]) by TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 11:02:05 +0000
From: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 2/2] mm: swap: print starting physical block offset in
 swapon
Thread-Topic: [PATCH 2/2] mm: swap: print starting physical block offset in
 swapon
Thread-Index: AQHarBuqKQMfUh7E1kGrHyDTMsOgnrGjWEaAgAeYMgA=
Date: Mon, 27 May 2024 11:02:04 +0000
Message-ID: 
 <TYAPR01MB40483619A52F712D9265D4EAF6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
 <20240522074658.2420468-3-Sukrit.Bhatnagar@sony.com>
 <20240522145637.GV25518@frogsfrogsfrogs>
In-Reply-To: <20240522145637.GV25518@frogsfrogsfrogs>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4048:EE_|OSZPR01MB6971:EE_
x-ms-office365-filtering-correlation-id: 6ebfa70b-e19a-427c-437a-08dc7e3c7199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ij4kynrLAHObEAuv6SHmv3O0iEhN3hJqWxjKTWzYJfmB9833AFHeMEqaa8G5?=
 =?us-ascii?Q?LY+sL5yzsRxS1TrVmkvFg3td1rgZZRyDF0DNSNeoPg0hHW4wFJc58soGJ0O2?=
 =?us-ascii?Q?qQfOrvGjjIiC+88fG4Kg+kcvzDwyaUPo7UWjy+D1CfXcY6GQ40tM18v+rFDb?=
 =?us-ascii?Q?eHuD/SBgbNR9SRzoffQRMdJdG5n0UheZSIZRCoQC54xbj7gwjP/r1MeztZJY?=
 =?us-ascii?Q?nXK0T7RCKBMuTg23zqs1+HWrAVv0vcwSwNSOzvZrYP/qF9QB+B4pIfFUS3pe?=
 =?us-ascii?Q?BAF+57fwO6VSo50UqALHUKnglB9xIzpNXvep0wyuuf63pyXhslzuiuy+V8DQ?=
 =?us-ascii?Q?P10szbbEtXT19NOXaOeiJfILZmbz5CTsGxy3u/5AOaUMGWsYZV8uoHTV72iA?=
 =?us-ascii?Q?Bon8oJk0kYiu4gSmmcgxKiblNWDoxCmuTNczFQ10dMhKK2XKeavMrUMUxweS?=
 =?us-ascii?Q?pNE2L7G9jjuyJzcm3B2EJEeEv9k7V3TlihqTHZx9AHYw/DGAAyK9wx1l5Ro7?=
 =?us-ascii?Q?EUhUAe9VWO5iW00Yl+ID4OEWipXi4ElEAy0QB8YRFJ5Zc+ChSglw2MI2tJHJ?=
 =?us-ascii?Q?PkPLC0mgz482W4PqILJD6B51JL0W5TkfqkgiiatF28Mcty9JFd2QIm93MH+c?=
 =?us-ascii?Q?/eEm3MI58w0DyHI0H34TC7BLP/TMIxD2aMRNPK+oOo8aMSIPBmFa9y6FzOYp?=
 =?us-ascii?Q?WWuW5Tz+9u5cWZOMDgMVbr/5HyYC8WgwHX8f7Do03PjKUmrfP7RYWqfuGVa5?=
 =?us-ascii?Q?BYeR0SGMe/PWWW0dPU/PcNzE537ZA6DfPzsN2U4yc0nWEsXx8NRJr8CqoJMK?=
 =?us-ascii?Q?HBy4PCsbIQGapiu4x/508545ArGuCKiNvSiq+NRvPrvINVGsGUYBSOJzOAd/?=
 =?us-ascii?Q?+yt3IBqG19TQ9hICqLVZTIoDhQPpJFTScQprCSC4EVssX/cH5iv+DkMquNAR?=
 =?us-ascii?Q?lM0BkYX+KvCta6KiQSBx0NXwdBoElv0bMgBy5WEbI+ag6dLjlsHD4L5JhEVr?=
 =?us-ascii?Q?Ru5ndZrvQfSA+86MvW+cXO0uBDJvUK8aRxhDDNXQ9MqpTJgyOwh+RKSm9Hjb?=
 =?us-ascii?Q?TYazlhHHcgJISzQX/JBrvRsyjvw+SCtImd3y62JqWpNfocprX6nOi0Cvet7K?=
 =?us-ascii?Q?paL1WOHKkLLubHnop2xRjHA+jmhitrXIK1LoD9A3q5inZuXN01vLfykGwM8z?=
 =?us-ascii?Q?qSg/0b13W8q4SqDNeQKP8VF+EsvH958PIXNd1EUuGPZZjwUdt7VawBUkGHHu?=
 =?us-ascii?Q?l8zPF+bCAzmk6Lmbrz0EL7zTQTBzFdkvkDri8SONq2fb0EHUhHjPLBayqmvk?=
 =?us-ascii?Q?S1m0TOVJ7vfOw9n/87H5nL5ZwTwmeIOJryGUbT4ovQLBqQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?V0C9E/GHiYyFYeUZhuXYb7PmlrD00P++78Z0hmWRr8WaK76KqWmkHfgYxWuJ?=
 =?us-ascii?Q?jWv2L0Tn1+LyQZrFVo9YcPNwF+leXkqMVdUqHeYSFrZ1zkToHR7uxx2NmfvO?=
 =?us-ascii?Q?dOwAL7iyTT0inHcgbVjv/tTkldTJY/m6g1hjNr+EDO2RoGa09n73aF/OBwNX?=
 =?us-ascii?Q?tWJzs6QaN+VRXbSknVI/kI8J4+m4qyZYacovU5sneBAjNIEdCoum2TIYBb1W?=
 =?us-ascii?Q?5U6DRP3XLvRkpmbEoNNYDDmB1q56kkdmt9Nh3F+1Y7ftW5FnTSGp1Z6GnLE+?=
 =?us-ascii?Q?y6mpqYpikEO4IHnHQw1/V8xejBkYSiLrdQtOWQg9qEMEOmrUHRESMgYmxViy?=
 =?us-ascii?Q?cz1l7+CNGR2BQgZZ7IP28p4krscQWdSchESwAB1UYBz0qVdEt3TBxYUcZcKR?=
 =?us-ascii?Q?xjaQ/8SIlxdkaFjg3+rEyOpyixoZMJE008pKhFWjgUZLMkLoArrdwklcwjYQ?=
 =?us-ascii?Q?9n6uEaxa0pt3WrkZQxFAgP7TFQL7bVLLQxijJyFMFXrxK9BZ4MckB4ITQ+DP?=
 =?us-ascii?Q?gQZTQzrcmt6ctuze3yzEh/bOEBn5cjOqVCnDH3UFTLbvpJ7vPxbHKiAAIt80?=
 =?us-ascii?Q?NedBtYhCT2sD308UIYiCMArs4rULjaxll6+vreKE+wZWGaZZehaYqztQUihe?=
 =?us-ascii?Q?RdnIKwu53eKq8JZZNbwUX9hj/1/aCj8WY8nOh3OcllljJ65rzlTt4SE6gx3i?=
 =?us-ascii?Q?+g6No4ub/BMnZgBZnpKywYZ75a5IyFzgrgaYT7ZaTB1n3PZ5YMIHicqiK3uu?=
 =?us-ascii?Q?4YpPyiamyZkN1VXVQX3hE79RCyGuuidrpQPPmGs8QZiA9hVQfSgoih1npRgQ?=
 =?us-ascii?Q?UAz/Bh/AHh/e2B1KKlc60AdYdBh6T3EzIulVGdt6N+XufW9Dyl1y7Lu5h0bo?=
 =?us-ascii?Q?L4zplrJ3ux2oZ8dRwtoyhL8tl5f2yVmy//LkBMQuYHl3HUFrjwRrvKUq0Ubh?=
 =?us-ascii?Q?hKd1RaAU8cuEFHJHjWDOhRNl0t2W6Ka3JkWNUWmKBicQ4k3PSnb/faG9b5lY?=
 =?us-ascii?Q?gCMkgR5EYi3F3N1HXngEGnMQfCR27237tGx9FehxrgJhQycaYbr4pNGMEqP0?=
 =?us-ascii?Q?Dlx72mmPUrLC2MQC7Z2LmxjHkxB7LsTD6MD5dIxNK/CF6a1Qz4PjysEMczFu?=
 =?us-ascii?Q?am2pkLzvL7H/6ueQHDTeXwfEF/hTwZ6/ZrufFp7FPHtW8XKGACQOw8qyd8Td?=
 =?us-ascii?Q?bCx05ayjcfDh6WMAerIMpR6YuLOF+7Ume2xme6KFDP3YkMXaf6YLLMH3yafN?=
 =?us-ascii?Q?QYEKRJmF0UBCNMvUgnKHBWYY62fKG+NEWdgJtOi8aFbQP6BkdR3xuCeXOnuS?=
 =?us-ascii?Q?u26kXs/ijp/baTOJm4+mgcSfZdybneEMAR4wJd7FyVpcPitmCJ2N52wxPcY0?=
 =?us-ascii?Q?Ughh56hASzEuZmB/7rUmymzbd1TGzpZaxj2Ynz3wUQWrQhOKsnxBfew8m5UC?=
 =?us-ascii?Q?P0zn6A/A7YzcHjr5ggCjadvXEogZN8krML858fmwwqCkjSc8cL0EsLlnKRLt?=
 =?us-ascii?Q?tX0pcLqVOWh7m8g3yaVyyS50qnL4OI/xI0tjUFb+emg7tx9OMUfIOc+NaVi0?=
 =?us-ascii?Q?hFtkJ/FGQsrm6fC8trfwCRkLKVmrPQrfEf2LrkKC?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zQQzIF6mWNO/1zvRLN1LgSU9+Zb9vCesZuA5z7wW4vWPv0f0j41LeVkYZN2MnV49TIgLUduPg1u1H9RETf60fKPHcCrkvodtDpS4wQ91WisJOF29qC7zOaLk72YT6KNRdjPWgcUCZ7dhCi+xElTz/aoKXjaYsyz+yn5CqSSY/SN2ZCBQIVTRgv2dXJO8lil7LCgGrBRonARHaNUocozuX2DeOW60UmqBpoFZYwrHQ1ps/XYodeDUQ0ut8YhLoEp/ySpCb8gVn+lUC4lbTacAtcq+IrsgcP28SYaeJMlYI7QvthXvcSoxFH9xsU7qfZZ3yYGqUNxJUEL3nr67vXA/qXS8NTA//jJIjKrVF342fNJ3aHuz2KVEZbZB+MaglgwG2OjWXcztX3DUYLhBymCVu9gJwhUTTGu2mb2SuAG8QnRkIs7BkE42c0k98fqvAlakYS/TFmcGZw2XWgf1oHJ8jtpGueoSq3n8ryJIFmJUVGCGJOOE+91zbAc7RfCE29xP4okhDyUvqmPhchqIkn9z6Yq/k0xTBNhD7gVeQQ8gYsSL3a9XqUeKtGWGp7kA6+J/xzNy+5arsUcvOfQX28iPlko6dODAx7iEicHGR5sNa9xL5M11bJdp3ZwjNTNUDyLc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebfa70b-e19a-427c-437a-08dc7e3c7199
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 11:02:04.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5F0ENkTMGyrKimV0xiYrJ+bj1lDiQ4KulsxRiE/j/d+4t1la8u0CBiRxj+gQwi77FHqHf+rjtXvmXbXGQ3bd0EfThkLRUvwVDeGrbE6hnf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6971
X-Proofpoint-GUID: qaKH6VcbNDH0wgtHq0YqaQzWSNs3bnDW
X-Proofpoint-ORIG-GUID: qaKH6VcbNDH0wgtHq0YqaQzWSNs3bnDW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: qaKH6VcbNDH0wgtHq0YqaQzWSNs3bnDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_01,2024-05-24_01,2024-05-17_01

Hi Darrick,

On 2024-05-22 23:56, Darrick Wong wrote:
> On Wed, May 22, 2024 at 04:46:58PM +0900, Sukrit Bhatnagar wrote:
>> When a swapfile is created for hibernation purposes, we always need
>> the starting physical block offset, which is usually determined using
>> userspace commands such as filefrag.
>=20
> If you always need this value, then shouldn't it be exported via sysfs
> or somewhere so that you can always get to it?  The kernel ringbuffer
> can overwrite log messages, swapfiles can get disabled, etc.

I agree on using appropriate kernel interfaces instead of kernel log.

>> It would be good to have that value printed when we do swapon and get
>> that value directly from dmesg.
>>=20
>> Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
>> ---
>>  mm/swapfile.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index f6ca215fb92f..53c9187d5fbe 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -3264,8 +3264,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, speci=
alfile, int, swap_flags)
>>  		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
>>  	enable_swap_info(p, prio, swap_map, cluster_info);
>> -	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %=
s%s%s%s\n",
>> +	pr_info("Adding %uk swap on %s. Priority:%d extents:%d start:%llu acro=
ss:%lluk %s%s%s%s\n",
>>  		K(p->pages), name->name, p->prio, nr_extents,
>> +		(unsigned long long)first_se(p)->start_block,
>=20
> Last time I looked, start_block was in units of PAGE_SIZE, despite
> add_swap_extent confusingly (ab)using the sector_t type.  Wherever you
> end up reporting this value, it ought to be converted to something more
> common (like byte offset or 512b-block offset).

I could not find any swap-related entries in the sysfs, but there is
/proc/swaps which shows the enabled swaps in a table.
A column for this start offset could be added there, which as you have
mentioned, should be in a unit such as bytes instead of PAGE_SIZE
blocks.

> Also ... if this is a swap *file* then reporting the path and the
> physical storage device address is not that helpful.  Exposing the block
> device major/minor and block device address would be much more useful,
> wouldn't it?

For exposing information about swap file path, I think it wouldn't make
much difference (at least for the hibernate case) as we can always do
the file-path -> bdev-path -> major:minor conversion in userspace.
=20
> (Not that I have any idea what the "suspend process" in the cover letter
> refers to -- suspend and hibernate have been broken on xfs forever...)

By suspend process, I meant the series of steps taken when we trigger
hibernate's suspend-to-disk.
Not the task that started it. (Wrong choice of words, my bad).

--
Sukrit


Return-Path: <linux-fsdevel+bounces-56527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A77B186E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 19:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CFBA87FA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056028D823;
	Fri,  1 Aug 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CmpPBlzn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6641AAA1B
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070494; cv=fail; b=nw2X6DwAizt+D6lGiBj/xPzs4fF3F1b5pxYBvSC+AzGXAJFKJL8lq87v0H3DanrVwvMV2b9jBlcRfHHxjtipPHex5TFYPczT2mPZIJ7v2m2xK2q/COBlfppQ3PygMu7D2SAwh0meewy6Tmj8y7I0CNIp+va0iA7vorqpFjQ0OLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070494; c=relaxed/simple;
	bh=KFmouyIgxfKTFsXNJ56cvC1iotHbUktVNDr5WLf1HLY=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=I4F0UGALhUOjnYdDecZK1YpHoI3BplIUjOYGC6Cocx/GoKDD2VfY0dGZpLNffPrN8OMxDdrFv0qGPmJNyFh659SE0Yntw6ht0YzYs59fVrs3HoCVHZ3SLNIyKEpkbHXdCv5S73uOZ/ZSGKs//e/5sydclLMEBaWgunMZj68i5tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CmpPBlzn; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571F5BYV021870
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 17:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=J48ILgdmG6tnPAr4oVJNGNz5qgSDYq6k+NF/KIALw18=; b=CmpPBlzn
	A6WA5sPdcPnHNYk5KR3dcs5PliYSOoVAcUKtoeY7oqArn2ldj6bo/a+neHxb94/e
	ADX5S4uE0hZjLkwmtDsSNLsAwt3A2zL4snhlKHVK9161d36rHJq+tHeoTabLUHYO
	CdHC597MSKj/lWhMWNMxD3YYup1sqMQOQV8KV29mh+YWYMbWJ1ooFBq+LdVB2KaZ
	28agNsNToMPjlbshy9twtSHy8itLSH0NzwcJZ8bcCAd1DDXmZ2OHTog7I1rqdHoF
	wkehCF9T+cVE4kiSjD9fSoJGMPgJCTnLmJD8ee/cgZfJe+S1LAs6xHaOIhcrOPdV
	CzA5debe/iEgVQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qena6bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 17:48:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 571Hkkkb002634
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 17:48:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qena6bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 17:48:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0jk2e9iQvovcbvmHBymyu7gNZMpH0avIVF98bhhsOgR6o7trZCde0THWyC+EkyceuIx+bNFPoGjSfYZM3uk9sbLzbwpfr671uE200y390uyxmys/TM+FZnAecTWINHg4VWFBaaPiY03pTgYTHVSRFsdmveZgFe8gvKc9WDuMQGujgWOfbSPyhsZQc+UiPiKBxTANjiQQ/0R/qdJI0gP0H3WxhkYIXVLedSQZ4bSpe2Y8G7OrI6YalJR99A48QxBMNX5kIpXRJrs3lHvKHEICqFwTgSxUnwM19FpXds3WZ0yR15VAgRvj8A6klM+A17fQHkC59HAoC99/XaKOGVOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFb01OuCQcdxqrzFxmS55aLW4/1R+nDVwY/OP7LQqf8=;
 b=hMmmRUuC+1rvpb3D3elB5JFGAzdZwVD5PqKqFu7ehs8Yaos/PcAKT00SW7O8yGGIHaRAifRDJfgB75vyztYolVWEQGR5i5jAiA5TPcmDZl2Zp+6nBEfm9Vj6lSukT2BA4ZZamDFYLAr7f/oQ5iS5xk95YJJpryCIGZTMmQzWQrB5uxUVmYnvyWbIRjJcPn+Sxl5P7JcyikcOhTlno1hxTlF2EGxXg2M0cInvSx1aIzkqE2eQt0A4Ksi5nmL5+FyGgj0W0I+kJt8pHL9aJJnJLv6s7wxQP+0p9Usb6MKT+6K1ALqTJXcsBdmgf9OUbTAaNS3MskHo9YyCcxsA7fo4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB6382.namprd15.prod.outlook.com (2603:10b6:510:303::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 17:48:07 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Fri, 1 Aug 2025
 17:48:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+6f9eae7d87e0afb22029@syzkaller.appspotmail.com"
	<syzbot+6f9eae7d87e0afb22029@syzkaller.appspotmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
Thread-Topic: [EXTERNAL] [syzbot] [hfs?] INFO: task hung in hfsplus_find_init
 (3)
Thread-Index: AQHcAwspqZ78qZpDjEGCiFkh6tRoxLROEsgA
Date: Fri, 1 Aug 2025 17:48:07 +0000
Message-ID: <436f1a6997b0b257e538b079c3be766de34df98d.camel@ibm.com>
References: <688cfb9d.050a0220.f0410.012e.GAE@google.com>
In-Reply-To: <688cfb9d.050a0220.f0410.012e.GAE@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB6382:EE_
x-ms-office365-filtering-correlation-id: a9a89f51-a0d6-43c5-bc2c-08ddd12392fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SU14OURXSnFGTXJTSytDdGkwQXVmU1hra0h3bEFhbE1QMlByNVJCejlCdDdM?=
 =?utf-8?B?dnZzR1BodTlHZnIvQi94UVVQcGJFOHFFbVl2dU1DTHU3WGw5c203ZkJsUktw?=
 =?utf-8?B?UUcwdFR6UUs4eVNOa1AxOElSMXhyUVYxUFV1RVN4czI2YldRSWw2dEQyRXN5?=
 =?utf-8?B?WWM4VTlGYklLYmFMK2JwTVZ2TmxSMncrSkxIeFhVKzFvQmlHY1FsS09RTCt0?=
 =?utf-8?B?V1VvT3dJQWswZDBQM3dmdmhJL3E2dlQ1QS9YcDBqYzdrcEh0RzloNk1Wd2VG?=
 =?utf-8?B?NkVqRHRyTVhOL3ExUXM2SUNDc2pNWVJzUjQrbExXdWt5NFpvczlNSjd4VzRB?=
 =?utf-8?B?S0lQaXM2cm54K1RBdzNRRjhGZXNxZHpBY0F3Tm5OSVZOMzhCby9KNkwyUDB6?=
 =?utf-8?B?a2hNY3U5b2tjcjZ5eGwwZklpUm1mdDhDOHN2dGZrRklCNmNVWUI2TkNNOVYr?=
 =?utf-8?B?Q3RlVkwySXcxbkVReEo3Z05RUjJEekozclliS3A0ZjBYeTdiR2hPSjE0NERy?=
 =?utf-8?B?RTlOaGxGZWVzbjY4UUxDWGEyYzl6REJBR1ppd0tiaTFnSnc3d1hUbjVnbWhi?=
 =?utf-8?B?OGo0bC80eTE0Y0NabzUvRWNBbTFXVWdNSjcrZTVLNWZsV3hvNlhWbEozdkhL?=
 =?utf-8?B?MTA0emlNWTBhVjVMVzFScUI0eGRrWjg3aVNIN3hVSGU5emNxMlFNK29hU2wx?=
 =?utf-8?B?VUlhZW5vYVoxT1FLRncwdXlRazBaZWN0blJhM2JVVU10ZklpRkU0LzFQaGZL?=
 =?utf-8?B?SEljYmU4L3RMdmx5TUFVMXFnV3M3NnUvbmJveEpCU0VtN1B4ZXdudld3THZN?=
 =?utf-8?B?NlR0dHVrWUR3WUl2c3BqeVdKRFJXRDZ5aUs0MjNmdTVXeDB1ckhHRTdlcnNY?=
 =?utf-8?B?SGRZa1hydFRsK2ZYVEp4d3o4QXdqUDFXNmVXWC9LNUNNaHBQV01qMGc1aGxp?=
 =?utf-8?B?OXM2aTlSdTlrT1RTbk9XWXZNSmgrSzlwVC9nOWlEMzNPZngrNWJSL0x6U1dT?=
 =?utf-8?B?TTJXWFh2d3l1aVpMelMzQk9NemhSYm1FT2h4SUhTaWR6ekoyUGJBT0RsSS8y?=
 =?utf-8?B?Zzl0bEU1L3FUTU9kR0ZoSGxNVFBkVmxxemt3ZVlFK1NqdmxIeThqSEErS291?=
 =?utf-8?B?UmRCM21uWkc3WGRmQTFQSG9vSG1LK3lXV3E3SWVCcVlxRy85aDJwNE5nWTUx?=
 =?utf-8?B?TGJVeUpraWptOW4yVG5lT3JBdFdxdnRsRnVBcWM5Rko5K0xjeU9UME5YaCs0?=
 =?utf-8?B?QUZudDNqd0YvSjM0WHBkaHdFUE9TaGtYWjBqcnl0L2FnZlpFSWlLMyt6Z0U3?=
 =?utf-8?B?OVBiSHJ3QmJzR2tkWmJ4YzhjR21mdkZLL1N2UENyR01GemNaN0l2RnNNaDkr?=
 =?utf-8?B?b1JUUjNBZ1ZpUG9rU1ROTmxXZDZCcDhQSEtwYklVK1RYeEZaMG16N0cyS21p?=
 =?utf-8?B?cjBTcFRyM2syTkdYa2x2OUVueERaeE40ZlJhVCtvSThuaTJpeGFPaS9vdEFx?=
 =?utf-8?B?Tm5MYWROL0ZXNGJ6T3JtNjg3SC9PSjdaOVQzc3VvYThac0xGc2FLK0Juc2l4?=
 =?utf-8?B?akp4K3ozS1pxU3A4U1ZabjVmNmFvbEY4UFR0S2FWWFM5aHdqVDQzaDhybWVW?=
 =?utf-8?B?MCt1ZkM1UjJSeEdmY1ltcW91ODg4SE1aaVRIUHIrS20rUk1SOGxkL1d5dVRo?=
 =?utf-8?B?Y3Y4MlhZakJqYTNuWUE3ejY5ZkxrNnBFYjcwaFkvaEFRYmFnV3lqanE1Y2Jv?=
 =?utf-8?B?Q05OL2ROTkdwYTZkR2t6b0tRL0t1UDZKa25SUU5mSG15bW5seEU1SkFWWkUr?=
 =?utf-8?B?aHVQYTlsS0tYN1V2MjB5enFJVDdxdmMvcWNmU0dTSXFxZ000anBvYmlaUUpx?=
 =?utf-8?B?YTBma1IrSEF6aVdRak42UnRMbTA0YzBKaUFmOHprQVlKNGFzMVdDazkyMm9W?=
 =?utf-8?Q?48N7c9oFqtXvVnL1uyW+z4eiMEQ0Y8OT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFVpbjR1TmNNeDh2VFc4Y0tSTnVOMWxYU25WdXpqWVlOQk91Y2I4djVOUE9M?=
 =?utf-8?B?Q1dicDFnZXh3K05BekJKSVgxQnN1NEpJR2oyUUd4Vmh5YUVJY1RVOTcvQzBI?=
 =?utf-8?B?OHlGbWNvUHM4Wm45REZ3VWxzRjlqSmRraG8wY0NsWnR2NWl0QkwzR2x4U3FF?=
 =?utf-8?B?ZGJiT1A4eVRwek9Vajl3Q0pnWXlBbGFGdnRpd01pUmpOUWFCa0pvU3orRktU?=
 =?utf-8?B?YlVIeFNsNHNZUEZwL0dnU2FaR2p2TUZHQWR0OEE4eGpDZTR4WUNTdVBadHhC?=
 =?utf-8?B?QUUzTGpCQWdFR3YxRlRDU0RJc0tDN1JBbElNZFoveWxzM1pqRk4rMVpjR1lO?=
 =?utf-8?B?KzFsK2NrQXFQb2h1eGVJbW84Y01TRXJkWnR2SDBUNGlQano5WEM5M0tBYUlU?=
 =?utf-8?B?Zm5Pc3J6akE3ai8zVmxoUTgrUENZeU9oSTN3RjRNamlrSkkrcXJMRWpLWVRQ?=
 =?utf-8?B?SFdBRFkwb2ZVSzFLdnJrU0VXdG1IOC9zd01xR2RnNGRrbFBhR0t1dGpHYm0r?=
 =?utf-8?B?S2ozOU9rOXA2VVg1V215SjJsaDVaZE42V2N6U2l0WXM5dEdIemVNYXY1eEFY?=
 =?utf-8?B?OXd4cjU2cml3emw4RUtSaEJoZ2ZOZDJNWWRHOXpEWXE0YzRpdy96elhuQUpx?=
 =?utf-8?B?Wm5Rc2hWQzNsUUYxMEdZeUQwVDVDMlhRdjAwM3Bwalk3ZWE4eG5nYUd6d2RC?=
 =?utf-8?B?YVZuVWNlU1ZyeXpGOGxnVTRJazh4K2hzSWd0cWNNY1F1RGZwSkMydFNDUm90?=
 =?utf-8?B?amdJS1RWSHJxMUxjeStIcU5TODRKd2l4TUJsTGg0MkJ1MWRUVVVWWStXVVIx?=
 =?utf-8?B?T3BwNWFVT1Y0T1VNT29ZREZsK2d2RjJBT0FpcGxydmtyMzRCTW94UUZDQ0dj?=
 =?utf-8?B?Wm40alJkUGtYQjdtNGx2YkxUbCtzS1JPU3RnaFVuWnZhOFJPdzlMSTFEV2Vk?=
 =?utf-8?B?bGl2RmI2dVc2T3l5OHQxQUpGSUpNM2dTOUVPeWp1ZUpoamlUZmpwOGlwTzRX?=
 =?utf-8?B?NzBySzFUQUpUWWlHZDRRYnU5c1FvR21PZ1hESW12VWlXcFJiUTBrMWFWRVJi?=
 =?utf-8?B?akpmOGFQdG1tZTBDcDVwSFZQOVE0Y2RXVy9lOXVHODg0Q09CQ01Kckg2OWov?=
 =?utf-8?B?OWgxYktydEF1Qis3aFVVeVYwUEM5VFFrVVJ5aEJhSmFHL1phKzBZZmcvRVFt?=
 =?utf-8?B?M2VwWURHdi9yT3pweDhlYlpOQitJWU40TDEyNWV1RXdVNGIvNHpDa1U2RFhi?=
 =?utf-8?B?dGtDMkVZcXYrRVJpMHF5ZTFCYXc1N21oYmRpNFpEWEVkbmJEcXFia0ZjK1pn?=
 =?utf-8?B?WHp4djZQR2RLTitOcHhHVzgxeEJ0eEZnNmp4S3R1eW92UGtjMWt4em5DcFlY?=
 =?utf-8?B?alBVRVJpbEVpOGI5U3RDWHlkdEFqT0NYVUhSenF3UGRYVWZ0dGoyWUtvdkgx?=
 =?utf-8?B?MXoydVRJbTl1OFFzOEhNcC9zMGVmVmxjQmpKOS8yWWFsc0xCOU1CVkdNTGtX?=
 =?utf-8?B?MXZMQmFVNGE0aVhMMmZZTTFxUkM2VGs5NVovOFpYU3RKd3JySkJFRENPbE5a?=
 =?utf-8?B?WTEyMFJZZEI5RkdTQmtiaEpVNFduaC9yYitWeTQxZnJER2cyM3VJSlJVQUZP?=
 =?utf-8?B?UERUVm95ZGQ0WXNNZTFwZ1Rnd0pYSERlS012ZnFNcHNNbVY1UDIzOUlHTHBT?=
 =?utf-8?B?YzF2UGJ6NFRBcTU4cnQrbHZ4Z2FvM05vYitTRVZMajlRdy9paTg3aTJuWnpI?=
 =?utf-8?B?VHNPVUt4dlBQRDZGdWhPSEgraUZQZndPdlRUTmRQaEUrUlV2b1pNQ29sc0ZG?=
 =?utf-8?B?bkJkb21vaE5yVzc1NHNaVndIMmdRZVZweGMzdGlhWXVYTE45dHkvbUN1NzRy?=
 =?utf-8?B?OU43eG56SVd2QjgzL0tLaXRPNDhoV1VkRFNjbklQYVBBTG9SVk9QOVBCdEpk?=
 =?utf-8?B?Zjhra2RUdWNKZjBjRi83dzJwc2plTDJWa0VEWnBhaFU1a05nem11RUtwRWdQ?=
 =?utf-8?B?Q3ZIZlhpWFgwbG40ajBaRE5nZmNxUWo2KzlraldUNDJjWDcyT3dHT3hEZ2Vt?=
 =?utf-8?B?ZkRhQmZXeGVSYSt3TFhnMDBuckxiNUF3WmhDN2JvK0thZFVJS3ExT3BPaWJm?=
 =?utf-8?B?QTI1dnBxeHQ1ZHhvbjRlQkxJR3N1VU81eWdMajl1RjQ2Y1pDL0VOOGppbC9H?=
 =?utf-8?Q?SOGN4wVW1GnOwfm0ESd0NMQ=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a89f51-a0d6-43c5-bc2c-08ddd12392fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 17:48:07.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMAQv4PNsHpgyYmoJmJEXqr2zjnj39AtpZ+lrVHb5BV0I1nPVLB6aMUDxsT25pux6fbhPB1Qv6jaw2nNhamaFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6382
X-Proofpoint-ORIG-GUID: 3pcYwNPcVY3gCiGHe7ePJD3R4DPmCliy
X-Proofpoint-GUID: 3pcYwNPcVY3gCiGHe7ePJD3R4DPmCliy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzOSBTYWx0ZWRfX8dX3Qw3CS9DA
 uFU30OGQYXKcAiZNiPgXExBrzc4l+2FWLSb33mlIN6EdoXeCGIfazhS93X3lGw2qltv78/vXBcM
 Sy3J8zQLJ0hEjjRaQAUBrMg+oMFjV8qWb63mNpXOZvNPyS1LtIU+5e/QFlLotPoaRShSXEmdSy9
 xk11MYZPokqTFn/7UOAjujJfTD/UyFXN961Rjxo1ggO3PuzyRmfGMx/n3zx9ZUP/uFSb3jU5HyW
 EOep4uS0P1XAP00XALWGraF45GX5LkvjaN5EZbZZITT44KxXu3K1sLWfzqlTcK50ppfuvdoau5c
 vrA+E5zz4GXK4c/qbrxhgLHWd0FNY5jH+D05itbIwIX9VDIHNdF/NVWDp25EhCtWL0dYSu6uXZl
 EOElK8qVC6aWF8YRdyXQjsZlu4nRCy+HlvUhx516+Y2I7zspoY5xLlTpKaPJUcJDXXgWil6j
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=688cfdda cx=c_pps
 a=Dff2arrQVR4xu3ccdyRu6Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8
 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=sTLmlpSjqevkU3hd9pMA:9
 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=QEXdDO2ut3YA:10 a=slFVYn995OdndYK6izCD:22
 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22
 a=_sbA2Q-Kp09kWB8D3iXc:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <43E035C1032FBB468C8829E23655B961@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [syzbot] [hfs?] INFO: task hung in hfsplus_find_init (3)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=2
 engine=8.19.0-2505280000 definitions=main-2508010139

On Fri, 2025-08-01 at 10:38 -0700, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20

Issue has been created:
https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/237

Thanks,
Slava.

> HEAD commit:    f2d282e1dfb3 Merge tag 'bitmap-for-6.17' of https://githu=
b  ..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D144faf8258000=
0 =20
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8b51b56c81c07=
61d =20
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D6f9eae7d87e0afb=
22029 =20
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f604=
9-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D124faf82580=
000 =20
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D100642a258000=
0 =20
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/70f09e088d5c/dis=
k-f2d282e1.raw.xz =20
> vmlinux: https://storage.googleapis.com/syzbot-assets/9baa408863b9/vmlinu=
x-f2d282e1.xz =20
> kernel image: https://storage.googleapis.com/syzbot-assets/36063ac42323/b=
zImage-f2d282e1.xz =20
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7fea0d017f=
73/mount_0.gz =20
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+6f9eae7d87e0afb22029@syzkaller.appspotmail.com
>=20
> INFO: task kworker/u8:3:49 blocked for more than 143 seconds.
>       Not tainted 6.16.0-syzkaller-10355-gf2d282e1dfb3 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u8:3    state:D
>  stack:21000 pid:49    tgid:49    ppid:2      task_flags:0x4208160 flags:=
0x00004000
> Workqueue: writeback wb_workfn
>  (flush-7:0)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
>  __schedule_loop kernel/sched/core.c:7043 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:7058
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
>  __mutex_lock_common kernel/locking/mutex.c:676 [inline]
>  __mutex_lock+0x7e3/0x1340 kernel/locking/mutex.c:760
>  hfsplus_find_init+0x15a/0x1d0 fs/hfsplus/bfind.c:28
>  hfsplus_cat_write_inode+0x1e6/0x7a0 fs/hfsplus/inode.c:592
>  write_inode fs/fs-writeback.c:1525 [inline]
>  __writeback_single_inode+0x6f1/0xff0 fs/fs-writeback.c:1745
>  writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:1976
>  __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
>  wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
>  wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
>  wb_do_writeback fs/fs-writeback.c:2315 [inline]
>  wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2343
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>  kthread+0x711/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>=20
> Showing all locks held in the system:
> 1 lock held by khungtaskd/31:
>  #0: ffffffff8e139e60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8e139e60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8e139e60 (rcu_read_lock){....}-{1:3}, at: debug_show_all_loc=
ks+0x2e/0x180 kernel/locking/lockdep.c:6775
> 4 locks held by kworker/u8:3/49:
>  #0: ffff8881412ee948 ((wq_completion)writeback){+.+.}-{0:0}, at: process=
_one_work kernel/workqueue.c:3211 [inline]
>  #0: ffff8881412ee948 ((wq_completion)writeback){+.+.}-{0:0}, at: process=
_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
>  #1: ffffc90000b97bc0 (
> (work_completion)(&(&wb->dwork)->work)
> ){+.+.}-{0:0}
> , at: process_one_work kernel/workqueue.c:3212 [inline]
> , at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
>  #2: ffff8880332b00e0
>  (
> &type->s_umount_key
> #42
> ){.+.+}-{4:4}
> , at: super_trylock_shared+0x20/0xf0 fs/super.c:563
>  #3:=20
> ffff8880792320b0
>  (
> &tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x15a/0x1d0 fs/hfspl=
us/bfind.c:28
> 5 locks held by kworker/u8:4/61:
>  #0:=20
> ffff8880b8739f58
>  (
> &rq->__lock
> ){-.-.}-{2:2}
> , at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:636
>  #1:=20
> ffff8880b8724008
>  (
> per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: process_one_work kernel/work=
queue.c:3212 [inline]
> per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: process_scheduled_works+0x9e=
f/0x17b0 kernel/workqueue.c:3319
>  #2: ffffffff8dfd2f50 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_disa=
ble+0x12/0x20 kernel/jump_label.c:247
>  #3: ffffffff99c6aca8 (
> &obj_hash[i].lock
> ){-.-.}-{2:2}
> , at: debug_object_activate+0xbb/0x420 lib/debugobjects.c:818
>  #4:=20
> ffffffff8dfe6308
>  (
> text_mutex
> ){+.+.}-{4:4}
> , at: arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_labe=
l.c:145
> 2 locks held by getty/5605:
>  #0:=20
> ffff88803031a0a0
>  (
> &tty->ldisc_sem
> ){++++}-{0:0}
> , at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1:=20
> ffffc900036c32f0
>  (
> &ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 driver=
s/tty/n_tty.c:2222
> 4 locks held by syz-executor384/5873:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-syzkaller-10355=
-gf2d282e1dfb3 #0 PREEMPT(full)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
>  watchdog+0xf93/0xfe0 kernel/hung_task.c:470
>  kthread+0x711/0x8a0 kernel/kthread.c:464
>  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 5873 Comm: syz-executor384 Not tainted 6.16.0-syzkalle=
r-10355-gf2d282e1dfb3 #0 PREEMPT(full)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
> RIP: 0010:kasan_check_range+0xd/0x2c0 mm/kasan/generic.c:188
> Code: 0f 0b cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 66 0f 1f 00 55 41 57 41 56 41 55 41 54 <53> b0 01 48 85=
 f6 0f 84 ba 01 00 00 4c 8d 04 37 49 39 f8 0f 82 82
> RSP: 0018:ffffc9000414eb30 EFLAGS: 00000056
> RAX: 00000000ffffff01 RBX: ffffffff99dbe400 RCX: ffffffff819df6c1
> RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc9000414eba0
> RBP: ffffc9000414ec10 R08: ffffffff99dbe403 R09: 1ffffffff33b7c80
> R10: dffffc0000000000 R11: fffffbfff33b7c81 R12: ffffffff99dbe410
> R13: ffffffff99dbe408 R14: 1ffffffff33b7c82 R15: 1ffffffff33b7c81
> FS:  0000555574d53380(0000) GS:ffff888125d5c000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffcbbc35f19 CR3: 00000000714b1000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:13=
01 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
>  do_raw_spin_lock+0x121/0x290 kernel/locking/spinlock_debug.c:116
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
>  _raw_spin_lock_irqsave+0xb3/0xf0 kernel/locking/spinlock.c:162
>  uart_port_lock_irqsave include/linux/serial_core.h:717 [inline]
>  serial8250_console_write+0x17e/0x1ba0 drivers/tty/serial/8250/8250_port.=
c:3355
>  console_emit_next_record kernel/printk/printk.c:3138 [inline]
>  console_flush_all+0x728/0xc40 kernel/printk/printk.c:3226
>  __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
>  console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
>  vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
>  _printk+0xcf/0x120 kernel/printk/printk.c:2475
>  hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:101 [inline]
>  hfsplus_bnode_dump+0x322/0x450 fs/hfsplus/bnode.c:403
>  hfsplus_brec_remove+0x480/0x550 fs/hfsplus/brec.c:229
>  __hfsplus_delete_attr+0x1d4/0x360 fs/hfsplus/attributes.c:299
>  hfsplus_delete_attr+0x231/0x2d0 fs/hfsplus/attributes.c:345
>  hfsplus_removexattr fs/hfsplus/xattr.c:796 [inline]
>  __hfsplus_setxattr+0x768/0x1fe0 fs/hfsplus/xattr.c:279
>  hfsplus_setxattr+0x11e/0x180 fs/hfsplus/xattr.c:436
>  hfsplus_user_setxattr+0x40/0x60 fs/hfsplus/xattr_user.c:30
>  __vfs_removexattr+0x431/0x470 fs/xattr.c:518
>  __vfs_removexattr_locked+0x1ed/0x230 fs/xattr.c:553
>  vfs_removexattr+0x80/0x1b0 fs/xattr.c:575
>  removexattr fs/xattr.c:1023 [inline]
>  filename_removexattr fs/xattr.c:1052 [inline]
>  path_removexattrat+0x35d/0x690 fs/xattr.c:1088
>  __do_sys_removexattr fs/xattr.c:1100 [inline]
>  __se_sys_removexattr fs/xattr.c:1097 [inline]
>  __x64_sys_removexattr+0x62/0x70 fs/xattr.c:1097
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd613ef9bd9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff6590fb28 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
> RAX: ffffffffffffffda RBX: 0000200000000340 RCX: 00007fd613ef9bd9
> RDX: ffffffffffffffb8 RSI: 0000200000000080 RDI: 0000200000000040
> RBP: 0000200000000380 R08: 0000555574d544c0 R09: 0000555574d544c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
> R13: 00007fff6590fd78 R14: 431bde82d7b634db R15: 0000200000000390
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.116=
 msecs
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ   for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status   for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup


Return-Path: <linux-fsdevel+bounces-14710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BD87E300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B921F214E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21A20DC4;
	Mon, 18 Mar 2024 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WnKS0Dkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0220B0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739355; cv=fail; b=aUf4RaYNRzRujxZYvu1ORv/dCJVCYAIr/b/uiOC4NCPFBy8lax3fbFasta7WtOrYdJue9vDfhi0OO6gd7eIuS2u2lYyimDL9HAgNUx4ICVxm1PkSoYmwZp2xPP3chjDSw4lE9l2gaerR7TdHgjJ1JQTFyTBfSANsILGMA3DIcJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739355; c=relaxed/simple;
	bh=5fgkVcTPkfbFwdcYfXnsJvoPyn1t0G8cbBuN2+OfwI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aF7PPRGIxwUZjnBvAl3i2nPJAV2SDFHWkZB+5k3bWRG9HTptyyc164lyFnNO2lB7/axLIyLPpSGuiuG+mFn6notXPyKWilWmEYwH8RKxxCoA1KdOAWZGoZN1FDjVYdhFwlOMWwSVAZJcnYaGfQYdFNRKDpc8MqgpA2PMoWLZ0M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WnKS0Dkq; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I46nuZ011235;
	Mon, 18 Mar 2024 05:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=5fgkVcTPkfbFwdcYfXnsJvoPyn1t0G8cbBuN2+OfwI4=;
 b=WnKS0DkqO1vXv++7GWxmRp7ITbBB6oEeq0Vu++8v4ITY5FjCcYCp2E9qWFza8djFzpCw
 KTOwfvqQosrCzQ9kmisU/kjG5ecWVNOG9s1c4bHX9eJDSsZEgwiaid+z6wD7YW0nQAHt
 Tf3vBlBshtNWk02oPiUywzZY81KlUlUb84H1gXKWn5828hx3QA8Tc4dZbQ5cmGAsQsX7
 I9o6G6YS4ROdNmN4KFzsLnRdXu2iBKBz/U5dtrWRav5GlZm2FAj9JtwevfGXGFf6jJZ8
 qyhXMt3gtil1AAFm86yszlCizAV32gZXLzkUnRS9ZJhyRKPiWOxtchhtQFwDJhmscbQI 9A== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww0k4hrhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:22:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZxDXHE5OmJVuTzN3PbM/JNJ5mkRABP2UeJG9wbybd3fIZh8l5arSL4YmBrpN3ohgiiNINv4yJ/OKNRqRDBS/CDtkiK6rqJglcy8KvOUc9t4JI6OJWSbW1eMrmrrLHUEOzUDQyJgjOa7UruW1v1TMnZj2P3019ZzEi7jxTpm6qWXVRg7BwHd8bfJKcLzG5dOWhqMLzJXiHO+ii55BElLuzqA9oNm3ysfGOJf+vp6/updb1xDuXcZv0bPG7CRcmKU/ulVMrcuCm8uYxGuVLGzE9g1t8jcyur/Q4IJKrBTBkfdejQUlb7mrZw8eZU2EhOi+c8OoLb39kmxi9qwF/gc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fgkVcTPkfbFwdcYfXnsJvoPyn1t0G8cbBuN2+OfwI4=;
 b=YG0MhI3FGECgCTVcDhmYo2biIIoZC0GL3jCYBTJ9LjUEwnVI0vTJsJ76AtMSBTefR1V6YKh17Qspm2Bqk/nKMbn4Z5NvX3yN+rHKM7n008NQUbfsZDaSYqq5sz4hF674ZqizpKfzgOK1rVstjy77k399ozeY44DmLpl83oQ7o4UlLrjGK1/2Hy1Y4ND8oiwmn3mw/xFCnezMEl6x/RuqF/t4M3ZT0Q1377xHFIE9otXkVq4oRLbbRphrTDP0Pf3eh/EQja5qWtlc8fJ32N+p8cD5xAWJ2Op4+jjrfEpkPMXJOHSCuytQXomSxZJWBNuRYQpl06CEEtwWRJbSAdX1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:22:16 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:22:16 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 09/10] exfat: do not sync parent dir if just update
 timestamp
Thread-Topic: [PATCH v4 09/10] exfat: do not sync parent dir if just update
 timestamp
Thread-Index: Adj0JkwXCy4LGeDfTAq9PLjEVpoj9WEzKnWw
Date: Mon, 18 Mar 2024 05:22:16 +0000
Message-ID: 
 <PUZPR04MB6316593B3DD6A4A203633902812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: 7ce39508-99e4-4e6c-9a00-08dc470b607b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cVMExQaKl3ncunMAu72W/R/8nBwgQnceET4yrU3AXqbHF9k+CV9QkIVhzFwXPfRnexL+kiePJkyxAv7ylMhRJv4JCl0+HlDVXlUUorswLQ7qSLJJR/DH3UREUS6fQnShEoBM8DVFApJ4tk/l3l7cxR+yFXLPFYqtW0fZwDKq2UtPJUOZmxr18/gFMR2i9D246GZgkKLqQYzLwutB9PJ5Q7kLh3yynY138KB4Lifb7aMdVhPI/NgaH6uGi0BXxrLbeN5/IhE7NvGDofCMdFzxFBa3TCn32l+qUBeDwPL1PpEuWFe2Mrz7GCwoAQmrDt5MiJ6JM5XyEqx+0yNWK/cnBDyDMTnFvwcHhPPpCEZKpXH7oHkGq36Np/H6/31IdOTDO8C8kPzft+/c1KTENZI7qHiMEZcmaAa2ihjlyP8TKRG1sU0SfL8SCZpV/Ciclu9du5EJChIJZZr0vh2sB8BUnpX8Vuwx+uCjKwXubkVZ7PrJtzcBBrrgV3VRt1CpPmBP56siKGoqDlNdjNWrZ951YKdRz4XZwJbD9q7TcssjWkaKPD5/1HbdoEZw8yZpT3oCqVqUqtdwsDnc9Tx8/LTWDQrIfterBy4D6lKq/5WCVFvP8LvUZbPOixWDrGVOz5/n/xD/gM50XNTrPvwDZlb7IdPnWzjoiXrawN49+t0pjTqj1CLpsTJ53OTBF2Dj0NLX1cg1xYoCSalhRROiN1Iyeg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZzRYZWE5Z2loZGRRdGFCcGJwRGZRQ3J0Z2VRL0hURzVmTitnSTl3bUdMTVNB?=
 =?utf-8?B?TVQ3RzV1V3hLU29aZldXTzVLK1BGaEI2bUlhKzFIcGV6U245Q2pzdENKdERG?=
 =?utf-8?B?WEVGbEtSYzFqYjg3Q3ladndIV2lqOGZtR0lOSHh0eG5CTHJBMnZvNHZuYkZn?=
 =?utf-8?B?VnhRblppQ0l2TmJqWWdZTkZyMVZkb2ZCa1R0RnJYVzViOWg5YlJCd2svY3FY?=
 =?utf-8?B?Qm5nUlJrZk9rUENtbkgyTzd3WGgxN2xFdmVHUmx0d1RZdUVIME8xYlVUVWJa?=
 =?utf-8?B?cVJiQ1FMcGQ2ejlIWE13a0Fid2tLd21aNU9rRXh2dVp3aDJJaWZaZGxoRHR0?=
 =?utf-8?B?MUZSS3BFNit4aFBIOHNXOFdiL2NkLzR5eDRkUmsvZWJvVkIzNCtzRGxCWDVU?=
 =?utf-8?B?aUNWdlJHeVExTGNKRVR0cTBaQWNVVEdCbG90VVFkVHJINWpBZGdlTGVORVQy?=
 =?utf-8?B?dUY0bXkyRVZuUUNNUmZNSDNwRTZaZjY5UFJ6cjYva0tuUzQ1R0FJQzVHVHVL?=
 =?utf-8?B?MzR3Rm11Mkh5Q3dkdEtrSUxFVCtubjJYbm5XWHU2elhJMkIvQW03ZWtVVG5o?=
 =?utf-8?B?eGkrSDd4MlJFTjdXY0FqV1RZWG16TEJlR3RkVm9kU3YrUUJ1OFFSR3RtVXdr?=
 =?utf-8?B?VmFGWXZ6Qlg5TkZyYUxJYXNpUnBLb2NncFdXYUIwcGdFU0p2QnlCazZpeXBv?=
 =?utf-8?B?NmZiTGliejhNVFJBRzZyczhHNm44M0VIcEsyYlpOV0ZOWlh5T2JaTVJpTU13?=
 =?utf-8?B?SDh6V3JZYVl5blpZbWpqUGFPcXVGTEFSY2lJck1tdGRRSVNhbW1Ybk5yWWs1?=
 =?utf-8?B?ZkxBR2NXUkZ2eWlRZnhXSmNkTm1oL054dlZkVW8rMGt2TUVwOUk0LytSVW56?=
 =?utf-8?B?dkYzUzVBYkJNK0hMajUydHVBZlZXTVJxV2psQk5VZ041Wm9wY1daOVpYSndV?=
 =?utf-8?B?d1Z1QUZpZVJOekc4VWVqakhzcytRcWlRcENGTm0wbktBTXpNSXpqN0c3cVh6?=
 =?utf-8?B?UzRTcmo2TU1tN1BqV2prQzlLUTVNdHdKeTdwVFhESzRkbXNKYUFGeEJmK2li?=
 =?utf-8?B?NVFjSXlnbFAwK04zOVljcWE5S0lqTUdXRkw4U092ZWlWNXRDUFNLYVN6dVB3?=
 =?utf-8?B?dnlySGlCQzBzUFFVRnRhT2J3RlhnUEtvWHltbzdWa1V5di80SmRUTjQzKzdn?=
 =?utf-8?B?U1FFUXdBaERLMk9sMlFUQU12MzJxQitoOG16c2VwVnZpdnNWZ3BrQmFyZytI?=
 =?utf-8?B?VVFlWnY3blhIYStRZTFJWmxaYlZkU1pLUXYyNFlOK3NsSkFteDMvVE1KcHVt?=
 =?utf-8?B?S3UzUUJPQTdOMVA1Vi9VL3lCc1RBejB3MVVaays3RUFhUFp5ZWNzRmhDYkVX?=
 =?utf-8?B?eWlQYW9DUjMzcXVKd1ZSNE04VFRPV0Z1WWxFekQwQU5DMmxkc0tLSm9CSkE4?=
 =?utf-8?B?VE9HaEtrVzFBdkdiSXB5Q1BOY0pweHMzWmxTUTVRWHJRb2JnVW1qMEkzQ0Yy?=
 =?utf-8?B?UU9LQlNJSmpLQ0xCQkZwR0d6QUNFMFpicEhUeDV4dkZzZ2oxSkIwV2w5dWg3?=
 =?utf-8?B?cjJvdkgyMGdLNElJdTF2a2JqdVJjTnd1SnAxdTg0WVBFUzFNaDBsQmJrRFJT?=
 =?utf-8?B?eXpVc2ZmdmREYVl5a0ZVdGFsc2lBQzVSbk92V3hmYU9rNi9ZUHRFdVk1S0JU?=
 =?utf-8?B?U2xiYjJCQWhUSi83RXJRbkFJVUtKUDFNWGJrZEMxZTFZUTYzMFhSa3Z4UXB1?=
 =?utf-8?B?ZXpYQzZjQlFydTNMR3JENU85S2NFMVFhbThnS0RlNTFzV3MyWnFHWnRqWGJT?=
 =?utf-8?B?NUlJbWJnWkRwVnJ5OGxlZVNCNGhGQVZBbW1YR05oOEliRUpEZm50bFhNc0Qx?=
 =?utf-8?B?bmZQWmRZL045WG5Ia1pDNDZKT1paczFlQjlDMkVmZVFoNXd5NGc0c1EzeURo?=
 =?utf-8?B?eXo4TlJHRFNDbmJyWlkza1ZMTm84YmdEK2RpZzVST2loVTNmTURrL1dQa1dO?=
 =?utf-8?B?YXpmMEFtSGlXMjRBZ2pkSzZGbGw2K0dPR3RZU2JuQ2JxRDd6RU00WU5GV2E1?=
 =?utf-8?B?dUFKcm45VnhHTUU2ZGNRSXJPcGVIanYzSlFwcFFDQVgyMkRBWm01L3lXVnk5?=
 =?utf-8?Q?PocH4/CJmmHF8edVhyqCWswUF?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xnmZpxXShHIXLWTYmNcKC969i/2c3TTMZirb/Qihf10XnezNkHQ8z6lYhXKaFKWVWQT4wKLweZ/tWM0zcQ3EfBbxDpopyApByiZEzLhuVX0A6iBv9RkU6t7bnFVqcf7z1PT4aEC1JklyTpxC323kP+6jacPr4zuT98KBLmhH6mtIZLM5uNDcCpiH8wOzHX7V6EYIo7SNhkqKNLP3x5vf+II0LT4xcIoI6W034zUirIHXJ5yq5ioye2LvLQve3VLl5ddN2IvXK8Hd343aa2EUfprcYtAGwEIcdAyJa4hVsmO6NivXAPPTM54yMmBO8r1/2F6epBffPHk6qB+br5cVvmMGm8YYpJbPZxqYVmJAiAMRDW+6H/uLdkwTNvPLp1cVZhK2OAWHTKl96y6jZRLJM/T0KGjYKCYiqHAiJaDILLkVG0s3mU3VS0m2WbalGDTcZ7UFy4YG+jFncwu7EXTz4/IKbKm9c7wuLJp4ir1a3Yt8R2zv8xtkTaiv17W/lnZxoPaNTAKW4552eAfbXPgtwfbEVSxXXVgWJotDNo3e+mUXC+23jaRtRRONfwv6sHR/5/Uhdly4fgJvUB3BlOWVcF6wUmimcBjdAom6YJ44eGMne3osJQ+zG72B0yFBzuKk
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce39508-99e4-4e6c-9a00-08dc470b607b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:22:16.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oww6V3xxIOFzHzkJHGFsB35R7ZLOT8tKQ3tqvaiEB1EMs0GVyj9Mpjw10pnMvOyaieQgVrUZdb3KxoRCxhyzdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-GUID: 0OpP4SFI7DfIgjuHTHdySmBHbvliUCtc
X-Proofpoint-ORIG-GUID: 0OpP4SFI7DfIgjuHTHdySmBHbvliUCtc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 0OpP4SFI7DfIgjuHTHdySmBHbvliUCtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

V2hlbiBzeW5jIG9yIGRpcl9zeW5jIGlzIGVuYWJsZWQsIHRoZXJlIGlzIG5vIG5lZWQgdG8gc3lu
YyB0aGUNCnBhcmVudCBkaXJlY3RvcnkncyBpbm9kZSBpZiBvbmx5IGZvciB1cGRhdGluZyBpdHMg
dGltZXN0YW1wLg0KDQoxLiBJZiBhbiB1bmV4cGVjdGVkIHBvd2VyIGZhaWx1cmUgb2NjdXJzLCB0
aGUgdGltZXN0YW1wIG9mIHRoZQ0KICAgcGFyZW50IGRpcmVjdG9yeSBpcyBub3QgdXBkYXRlZCB0
byB0aGUgc3RvcmFnZSwgd2hpY2ggaGFzIG5vDQogICBpbXBhY3Qgb24gdGhlIHVzZXIuDQoNCjIu
IFRoZSBudW1iZXIgb2Ygd3JpdGVzIHdpbGwgYmUgZ3JlYXRseSByZWR1Y2VkLCB3aGljaCBjYW4g
bm90DQogICBvbmx5IGltcHJvdmUgcGVyZm9ybWFuY2UsIGJ1dCBhbHNvIHByb2xvbmcgZGV2aWNl
IGxpZmUuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNv
bT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogU3Vu
Z2pvbmcgU2VvIDxzajE1NTcuc2VvQHNhbXN1bmcuY29tPg0KU2lnbmVkLW9mZi1ieTogTmFtamFl
IEplb24gPGxpbmtpbmplb25Aa2VybmVsLm9yZz4NCi0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgfCAx
OSArKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhm
YXQvbmFtZWkuYw0KaW5kZXggNzllM2ZjOWQ2ZTE5Li5iMzM0OTc4NDVhMDYgMTAwNjQ0DQotLS0g
YS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtNTQ3LDYgKzU0
Nyw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfY3JlYXRlKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBz
dHJ1Y3QgaW5vZGUgKmRpciwNCiAJc3RydWN0IGV4ZmF0X2Rpcl9lbnRyeSBpbmZvOw0KIAlsb2Zm
X3QgaV9wb3M7DQogCWludCBlcnI7DQorCWxvZmZfdCBzaXplID0gaV9zaXplX3JlYWQoZGlyKTsN
CiANCiAJbXV0ZXhfbG9jaygmRVhGQVRfU0Ioc2IpLT5zX2xvY2spOw0KIAlleGZhdF9zZXRfdm9s
dW1lX2RpcnR5KHNiKTsNCkBAIC01NTcsNyArNTU4LDcgQEAgc3RhdGljIGludCBleGZhdF9jcmVh
dGUoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBpbm9kZSAqZGlyLA0KIA0KIAlpbm9k
ZV9pbmNfaXZlcnNpb24oZGlyKTsNCiAJaW5vZGVfc2V0X210aW1lX3RvX3RzKGRpciwgaW5vZGVf
c2V0X2N0aW1lX2N1cnJlbnQoZGlyKSk7DQotCWlmIChJU19ESVJTWU5DKGRpcikpDQorCWlmIChJ
U19ESVJTWU5DKGRpcikgJiYgc2l6ZSAhPSBpX3NpemVfcmVhZChkaXIpKQ0KIAkJZXhmYXRfc3lu
Y19pbm9kZShkaXIpOw0KIAllbHNlDQogCQltYXJrX2lub2RlX2RpcnR5KGRpcik7DQpAQCAtODAx
LDEwICs4MDIsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3VubGluayhzdHJ1Y3QgaW5vZGUgKmRpciwg
c3RydWN0IGRlbnRyeSAqZGVudHJ5KQ0KIAlpbm9kZV9pbmNfaXZlcnNpb24oZGlyKTsNCiAJc2lt
cGxlX2lub2RlX2luaXRfdHMoZGlyKTsNCiAJZXhmYXRfdHJ1bmNhdGVfaW5vZGVfYXRpbWUoZGly
KTsNCi0JaWYgKElTX0RJUlNZTkMoZGlyKSkNCi0JCWV4ZmF0X3N5bmNfaW5vZGUoZGlyKTsNCi0J
ZWxzZQ0KLQkJbWFya19pbm9kZV9kaXJ0eShkaXIpOw0KKwltYXJrX2lub2RlX2RpcnR5KGRpcik7
DQogDQogCWNsZWFyX25saW5rKGlub2RlKTsNCiAJc2ltcGxlX2lub2RlX2luaXRfdHMoaW5vZGUp
Ow0KQEAgLTgyNSw2ICs4MjMsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X21rZGlyKHN0cnVjdCBtbnRf
aWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGNk
aXI7DQogCWxvZmZfdCBpX3BvczsNCiAJaW50IGVycjsNCisJbG9mZl90IHNpemUgPSBpX3NpemVf
cmVhZChkaXIpOw0KIA0KIAltdXRleF9sb2NrKCZFWEZBVF9TQihzYiktPnNfbG9jayk7DQogCWV4
ZmF0X3NldF92b2x1bWVfZGlydHkoc2IpOw0KQEAgLTgzNSw3ICs4MzQsNyBAQCBzdGF0aWMgaW50
IGV4ZmF0X21rZGlyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwN
CiANCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKGRpcik7DQogCWlub2RlX3NldF9tdGltZV90b190cyhk
aXIsIGlub2RlX3NldF9jdGltZV9jdXJyZW50KGRpcikpOw0KLQlpZiAoSVNfRElSU1lOQyhkaXIp
KQ0KKwlpZiAoSVNfRElSU1lOQyhkaXIpICYmIHNpemUgIT0gaV9zaXplX3JlYWQoZGlyKSkNCiAJ
CWV4ZmF0X3N5bmNfaW5vZGUoZGlyKTsNCiAJZWxzZQ0KIAkJbWFya19pbm9kZV9kaXJ0eShkaXIp
Ow0KQEAgLTEyMzksNiArMTIzOCw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfcmVuYW1lKHN0cnVjdCBt
bnRfaWRtYXAgKmlkbWFwLA0KIAlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gb2xkX2Rpci0+aV9z
YjsNCiAJbG9mZl90IGlfcG9zOw0KIAlpbnQgZXJyOw0KKwlsb2ZmX3Qgc2l6ZSA9IGlfc2l6ZV9y
ZWFkKG5ld19kaXIpOw0KIA0KIAkvKg0KIAkgKiBUaGUgVkZTIGFscmVhZHkgY2hlY2tzIGZvciBl
eGlzdGVuY2UsIHNvIGZvciBsb2NhbCBmaWxlc3lzdGVtcw0KQEAgLTEyNjAsNyArMTI2MCw3IEBA
IHN0YXRpYyBpbnQgZXhmYXRfcmVuYW1lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLA0KIAlzaW1w
bGVfcmVuYW1lX3RpbWVzdGFtcChvbGRfZGlyLCBvbGRfZGVudHJ5LCBuZXdfZGlyLCBuZXdfZGVu
dHJ5KTsNCiAJRVhGQVRfSShuZXdfZGlyKS0+aV9jcnRpbWUgPSBjdXJyZW50X3RpbWUobmV3X2Rp
cik7DQogCWV4ZmF0X3RydW5jYXRlX2lub2RlX2F0aW1lKG5ld19kaXIpOw0KLQlpZiAoSVNfRElS
U1lOQyhuZXdfZGlyKSkNCisJaWYgKElTX0RJUlNZTkMobmV3X2RpcikgJiYgc2l6ZSAhPSBpX3Np
emVfcmVhZChuZXdfZGlyKSkNCiAJCWV4ZmF0X3N5bmNfaW5vZGUobmV3X2Rpcik7DQogCWVsc2UN
CiAJCW1hcmtfaW5vZGVfZGlydHkobmV3X2Rpcik7DQpAQCAtMTI4MSwxMCArMTI4MSw3IEBAIHN0
YXRpYyBpbnQgZXhmYXRfcmVuYW1lKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLA0KIAl9DQogDQog
CWlub2RlX2luY19pdmVyc2lvbihvbGRfZGlyKTsNCi0JaWYgKElTX0RJUlNZTkMob2xkX2Rpcikp
DQotCQlleGZhdF9zeW5jX2lub2RlKG9sZF9kaXIpOw0KLQllbHNlDQotCQltYXJrX2lub2RlX2Rp
cnR5KG9sZF9kaXIpOw0KKwltYXJrX2lub2RlX2RpcnR5KG9sZF9kaXIpOw0KIA0KIAlpZiAobmV3
X2lub2RlKSB7DQogCQlleGZhdF91bmhhc2hfaW5vZGUobmV3X2lub2RlKTsNCi0tIA0KMi4zNC4x
DQoNCg==


Return-Path: <linux-fsdevel+bounces-14701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673987E2F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3B21C208BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B120B34;
	Mon, 18 Mar 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="kXhyP3gl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69E1B94D
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739303; cv=fail; b=KPr4ETUmih4BViyF49xjAp76eaaEFvoeT+0Au4deQGS21DgIALBm+5FEiVo/eqhZInJKFIgr1qw8qf5gX9bWk+9+EmPB358NrBfawet6WB94+BvK1pWh1EaoD1fZbzvcCKwxaYDx+qyykb3gr0e9BeJvMW2CAt5YAG0OT+dnJHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739303; c=relaxed/simple;
	bh=7cOVubFIlhFNvCLQGlB90iKqF28smkZWCQ46TxlzYMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dVO5VQHiPXCKnnls9nDX3T7tTXp5gOH9DT7dSD7Ftczj/6nF/qLrnr9IeY0P8D6EQ1fZrool8zeMnL6rT1YvKfSBo6JJnLGHVhgTBJjTQDQQoMwxyTyH0vABq1PG0Yk1/xxO4K/oJ7A+tOtcofsvzRHFtTe2PsVJ7odiCuKN1gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=kXhyP3gl; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I0OSWY007075;
	Mon, 18 Mar 2024 05:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=7cOVubFIlhFNvCLQGlB90iKqF28smkZWCQ46TxlzYMU=;
 b=kXhyP3gloyMiPg/Q8uIk5iQSbsGKDF2/uFTlL3tdY4CHqHZwjqp+FiyAme+vhc9bZqA3
 +v9ZNZp7oRBVKe3FKx/ZQPbP+4jDobPbldWE3C/Uqi/gP1sY6BTY0UO95fu+RkoQdvLC
 VfmVrJV6rr+CJtN5kBH48As48bpKZIcnP/GnrHT+kNW7dhSJamOBXZmqH+ibpjgbs9OA
 vjPcngiBKc7B+phbkSLJtsnlK2MP14Y1xnIASnD2BUGi+owlRe4ytJQMh5oLHe4F23pZ
 UWHHPmaWJJ+0aNm6GnqoUJWsPGhy//PEc61Ps3L+8N7ixqziIoc8kAPK8L/ds34Ir1J9 2w== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww205hh07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBjwKqplbEAi0asvHer0Fgsdveuk+wXJ7GWHfXPud6SNMtPUdHJhr+SDlE7cvUWx9ZoICfVeXx8YciR6eEarxI0oUrFvuEy9ALLmoWghUziPIFJW8S5ons6AWuJ0ZRK9sC5spmxXEY5OlYrJ8nChLLC3daNE1f+rkaOr10nLzd/I7ynmANo3tNcjlbFLGvntASCGRVZASdPEeQtV/HzDDv0x3XE+8ZHaviqsvoPlCI+Lq5m+gBO26kDovNG9aqxnfwJrdHEBvzS3FKFOnzo+9dxbvsXE1Su3pY9Ouwe2Wn8c3NUg3qic4RYRryUoRoft3Bm4Dr++5y/ADLoeKo3yJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cOVubFIlhFNvCLQGlB90iKqF28smkZWCQ46TxlzYMU=;
 b=Bo6cvWrOrYajYA5geVUhoYdTbBZaYL5rCQW3CEWxBupVvM92WMrJUYzclCJJYqr2i0gL+cKnmIlJv+AoAgyddbQrLYeAfQ7ZAqqw4FwK23jU66ZoMgnQWUPQxv94MaUsRYbsk/LAcQUj7Z0Q4q7qqAhcXbMFcaK9FpG64COjzoHsRxfzAtq9VLUyaBjPunrStJ92zaVCrgxXSB5fuFePbw7P1jcwiHKlSP9mHn6JVzI7rKPqXkdbjPT+VUgp03H8WygfyliudOZ1ynT6QsxBZIvTaeKoVusyoRBqZYlRd0yEfsyZwqUqqhdvGAk3DKJF36h6ZuoVh1vmdr33mFEbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:21:22 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:21:22 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v4 00/10] exfat: improve sync dentry
Thread-Topic: [PATCH v4 00/10] exfat: improve sync dentry
Thread-Index: Adp47tV6USsSQJ/cTFGs+bK3kGoAQgAAr74w
Date: Mon, 18 Mar 2024 05:21:22 +0000
Message-ID: 
 <PUZPR04MB6316EF5633A3B44DDF90B425812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: 92d1f296-459b-4007-0b9c-08dc470b4028
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QLJafPfL2fChFQbzr9lclfMzckl1fSf0+lSfa7GIvur8kUvQnb9C5cPrWGN9AH/HdP55UsEV4B4xpCXK/ycHoV5N2hj/XPrQQI3vXtlJaFmcEPN8J/XhzbvsudaVALdd5j7cerHR3iAveYGksLHeixkWowuFweC/YytxU1QfRFZeTZ5ChkCsh39a9xadEdND2M40jG7VLGtg1AnQGNJmfVd8WFaZ+0YSpIRtcm9Nz6cQ+TK/8WM26ucHz3Q3fVwKD8IQXYpEs1kEiIxOguscMuveUK7g50cyDcZFCj4RunjYqQWQf74cD0Wl6EuUk+TXH4gzt/WjgZAtkBeezOD/nLw/zZRkWMv9nmy9OSeiS3wiZqGl0tIdPcCGEml58A2FWY88yTqs4m6ZxyuwzaYILxStGoCwayNg41pKZmaP/NvBIehwJGraUiboGsWbc3xPwpoljtIZ1PO7CGtF6H5bfnUk5fixYwFUnJL80t60427EHK0wozEfCKnPBoFIJ2klejDrbCKoDDaa+BG3g2TJdQ8Yb2cmfj2EN4jpPeADdDOpO9nH9M4+H4c17k07T8BUEkgpBAG1BQP4usIasbfU+tTFIrR6LDYUrRZ7uxKf76P9+ebbGNbCl+0HYLVeBPiDmgBHgtosoOAoHqPCdxYsFZ/ArfTE30Rgjcp+ZJhNQszzCavnVP7wRFQqOKPRYbpAJseCSxj8rJChk8OAxMM8Rg+PkZ8c5i49tIaqkHwKyRE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QmxuL2grRXdocGZjQlFuZS95Q1Z4c2g3TzUrY0VSV0JkUndIWERHemM0S2lL?=
 =?utf-8?B?Umk1czY2NEdNOVdpSVNOMnRTb3JaQzNvM2NQSDdmM3R2cE5xalExcUx6cWhL?=
 =?utf-8?B?U3EvN0g4bHdkdU5XYmU0UU12cGFVNVpFeW00d2hFWlU2Mmw5QUliWFc2ZXhZ?=
 =?utf-8?B?SHA0Zy9wQ3kwUTZORW55WFVVUWdiMG5zZEtkekRCV2ZHc1NzbDhpYUtZZTlx?=
 =?utf-8?B?RTJqM0Q0VDZobTB2cDFuVk9ycmJGUGNKK2R3TVhyRDVXWjB1R0ZqS2xzZSsr?=
 =?utf-8?B?ak0rUHIvYkZtZExYc1ROSXFDZ2NhaktHVSsxUUJqcGNVUGdFRGRXS2E3c0tt?=
 =?utf-8?B?d0pIRXZKMkdkVUE3eGlSdWRoaGJMRjBENDhqZ0ZyMUt0V2pkSVVKSUlFU292?=
 =?utf-8?B?MmZuQm5YSUdQVDlUMmZTSkJHTHZIb25Odmt4aHBXOTBxRm41TXlrb09PQzg5?=
 =?utf-8?B?TEIrM1puZVV2Smo2cXordmhLaWVtazEvMzd4d1ZvbkhORStONWYyUmxpSlpp?=
 =?utf-8?B?bC9IOFBwREdHZXBjQU9HS0pYS2UzNXh0b3lqbnMxQUhTSjF1TEJ1NVVFYXkw?=
 =?utf-8?B?M3RxSGhrcUdxNmNnQ1E2SFhDWk8vTW9aUlF2UnZCbDMvZFM4QkpDZHpEVE90?=
 =?utf-8?B?TUtYOHZOdWtxaVgwbEVnV3pZQitEcEdUeGowUjdVd05La256L21zMTZqUnVw?=
 =?utf-8?B?dkpFdkRYR09hbzFsbEdzQjI0alU2OS9OMEY4VVROcmNINlZQN1k0aHFnd1VF?=
 =?utf-8?B?U2IraGhZVjlFU0p1L1lRUWNpRmRWZlVyQ29GZWl3dmM3eExYUjV4MVRMYXow?=
 =?utf-8?B?eGxHK1R4UzJhSENGKzh3YnM2SDJnT2lTSGsrcXNNc1ZBT2hTMExNUnF3Q1RH?=
 =?utf-8?B?T2VQb1VsSVBXaVZmMVFCK2ZqTkxZVXNCalVTMWt2cmpoaE5kT0xFZ3Z4NWFB?=
 =?utf-8?B?YTFBUTFlR0Y4NUZQdklBbGRiLzZEamJDMmxZMDVabmo2M29OMGhJNlBneHBx?=
 =?utf-8?B?dDRzbmJLKzRSN3AvY2ZTaXhFM1NYcUJwdElUY0RmSUZ6WW1jcjJHUENva0dr?=
 =?utf-8?B?TDJ4OEloQm51ejZsRGFoRnpBcm1wTURQUVBJbnp1alpqTzNzajVrZVZSZ1Av?=
 =?utf-8?B?RCtJdU0vdmhRankrTDJ0WEJjL0F0TjlvalZXNU9NWWgzQlhPZml6eGNIU3Vn?=
 =?utf-8?B?QUJMckJJcStZa2J0QlNBeVhwNWhqNk91azdicTB0UUhMSUJlRnpoamIzOVhq?=
 =?utf-8?B?ajBJdGpUYm81NGhJZml1WGJ5cDN3d0U0SWttWWJlNnd2QXpleHVZNUV6NnEy?=
 =?utf-8?B?TEFBcHphdjZ4enJWVjJ4d3lPQ2o4cFYrWXQ3b29KcDJJZW1wTk1scGNVVFdl?=
 =?utf-8?B?K1lPOG52UkdNVVVqdGhpS3U2MGw1cmJ0RjZpZ2NMUnpQSWR6NnFSdVlKdTVN?=
 =?utf-8?B?MGM1VktMY0xNMUp2ZHV6djByejhyWjZPbWJ3dzNpaDV1azdDdkdYdEQ0MFdy?=
 =?utf-8?B?elFXU0V6VnpHNmFPUEZSL1FrdnlTT3BEdjJLWGNMQUxMZlpzV2Vka1F6NElF?=
 =?utf-8?B?VWEwbzhrSmFieDlDSG1qYnBJaWM3RjIxRXU5UkVSaFoxYTl1dUJOUktyS1FI?=
 =?utf-8?B?MHhWbG1GaEl3L200L3R3QXhDYVdUUTBKNUJyeHFoUVp4MDNheEgxTHlxVnlG?=
 =?utf-8?B?KzZEUjRKZ1JBczhtOWQvck5SUVhLS3VadHBkWWlQTEpSZWtmNm50VUd2RUpl?=
 =?utf-8?B?VlZRRjVxNEFhWlhUdkZGVm13KzFiYzUwc3NZdDFhNzNSQkoySjNtZDhxa3A2?=
 =?utf-8?B?RlVOSVhoVi8zOGpJYUtNSjF0N3Y5dFpBT0JlMGR3YndwZHAyYXFxK2FGQ1R1?=
 =?utf-8?B?TzRrVmdmeVVaN0NTVHRsY3JqZERKSXRrUTdyNzh3UGw4Ti93OWdmRDN1SmR1?=
 =?utf-8?B?bEM1VlY0ZWQ5YmtqSXpXa3cwOGE0aUtTNm9udVdpdkpMcDFJbVNISExpUzl0?=
 =?utf-8?B?RGZ4OHpBOVo4Zk1Zb0tUbTBGM2xkdjY5anpzd3Z5MGdQM2JEb2VlZzBIbC9a?=
 =?utf-8?B?YnlOYi9rZnZhWVArd3ZlN1pncE1iL2RpTkFqTjNIVUxrS1JaL0ZnV243SGk3?=
 =?utf-8?Q?93QoyX6WwJTi2yhMgI/fiTLTG?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YA5bQ6MTsTMS+cW1Vicgtd0nbSP7BVj7t3Mq+FnaanYv4avXwlST8xKVBh8sXQW1waTxy51EApFyf1k07TgNM2TeEt09MF81x+4cbTSzPYa9HGTKxSD7wTiKVhRVn+ngWLZNpzZFHIpIAL3Uy5ByOGIqheDbyEYfWQADM4Edo7hSaC9sEG4OHOCZWjklOAClJt2kz+JX7lKKiWBoL+4nKO9pdJKMDkBkUQmNLc/I0DuinkpqMvBtzWpLnPWgbIlrx7QGT20Exz7yiJP0EC6GDFGoBgSs1m2H1AOw04XscyJdlld5yxaDLs1rCSurTQZUM5xhuM9aS/BpKs6Qj6KwvQwqOnalHgGTRXgSH+RNtspHml88ZY1axtRAy46i6ap9XKzy5KKuwCnLG9vaBDyg7J1d1AfAS6lpwGowc9csrkz6XCvu2ayJS9pv8ez5fr9H4x1/rFc1n9ckxZhKlTAV3qNzVTOG1IebKF99H/3NPRa7EaBYK/CkU7ePZUH18ylAMXoMaNaE6cmxzKheCvisSo8nrTEYwyCLt4F+hgi/jFHso0pe9b9qhnLGcvPQQWYZw9VbYgsA5FK8xFw33lhKewwAoT5+3zUMxLz01YTKWI9rIHoouEJyMuxh+SGpaKM2
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d1f296-459b-4007-0b9c-08dc470b4028
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:21:22.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ms9guL/f7RR58BOhQLev3cSgZ3gPSe+jzulqiJYgdBqh8SVteyIodzOcuYaFlyWVeI+IvaZofACQzRSG3wnlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-ORIG-GUID: CHJD5f-2UClTNoF6OhFfrErJCcl4M32U
X-Proofpoint-GUID: CHJD5f-2UClTNoF6OhFfrErJCcl4M32U
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: CHJD5f-2UClTNoF6OhFfrErJCcl4M32U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

VGhpcyBwYXRjaCBzZXQgY2hhbmdlcyBzeW5jIGRlbnRyeS1ieS1kZW50cnkgdG8gc3luYw0KZGVu
dHJ5U2V0LWJ5LWRlbnRyeVNldCwgYW5kIHJlbW92ZSBzb21lIHN5bmNzIHRoYXQgZG8gbm90IGNh
dXNlDQpkYXRhIGxvc3MuIEl0IG5vdCBvbmx5IGltcHJvdmVzIHRoZSBwZXJmb3JtYW5jZSBvZiBz
eW5jIGRlbnRyeSwNCmJ1dCBhbHNvIHJlZHVjZXMgdGhlIGNvbnN1bXB0aW9uIG9mIHN0b3JhZ2Ug
ZGV2aWNlIGxpZmUuDQoNCkkgdXNlZCB0aGUgZm9sbG93aW5nIGNvbW1hbmRzIGFuZCBibGt0cmFj
ZSB0byBtZWFzdXJlIHRoZSBpbXByb3ZlbWVudHMNCm9uIGEgY2xhc3MgMTAgU0RYQyBjYXJkLg0K
DQpybSAtZnIgJG1udC9kaXI7IG1rZGlyICRtbnQvZGlyOyBzeW5jDQp0aW1lIChmb3IgKChpPTA7
aTwxMDAwO2krKykpO2RvIHRvdWNoICRtbnQvZGlyLyR7cHJlZml4fSRpO2RvbmU7c3luYyAkbW50
KQ0KdGltZSAoZm9yICgoaT0wO2k8MTAwMDtpKyspKTtkbyBybSAkbW50L2Rpci8ke3ByZWZpeH0k
aTtkb25lO3N5bmMgJG1udCkNCg0KfCBjYXNlIHwgbmFtZSBsZW4gfCAgICAgICBjcmVhdGUgICAg
ICAgICAgfCAgICAgICAgdW5saW5rICAgICAgICAgIHwNCnwgICAgICB8ICAgICAgICAgIHwgdGlt
ZSAgICAgfCB3cml0ZSBzaXplIHwgdGltZSAgICAgIHwgd3JpdGUgc2l6ZSB8DQp8LS0tLS0tKy0t
LS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
fA0KfCAgMSAgIHwgMTUgICAgICAgfCAxMC4yNjBzICB8IDE5MUtpQiAgICAgfCA5LjgyOXMgICAg
fCA5NktpQiAgICAgIHwNCnwgIDIgICB8IDE1ICAgICAgIHwgMTEuNDU2cyAgfCA1NjJLaUIgICAg
IHwgMTEuMDMycyAgIHwgNTYyS2lCICAgICB8DQp8ICAzICAgfCAxNSAgICAgICB8IDMwLjYzN3Mg
IHwgMzUwMEtpQiAgICB8IDIxLjc0MHMgICB8IDIwMDBLaUIgICAgfA0KfCAgMSAgIHwgMTIwICAg
ICAgfCAxMC44NDBzICB8IDY0NEtpQiAgICAgfCA5Ljk2MXMgICAgfCAzMTVLaUIgICAgIHwNCnwg
IDIgICB8IDEyMCAgICAgIHwgMTMuMjgycyAgfCAxMDkyS2lCICAgIHwgMTIuNDMycyAgIHwgNzUy
S2lCICAgICB8DQp8ICAzICAgfCAxMjAgICAgICB8IDQ1LjM5M3MgIHwgNzU3M0tpQiAgICB8IDM3
LjM5NXMgICB8IDU1MDBLaUIgICAgfA0KfCAgMSAgIHwgMjU1ICAgICAgfCAxMS41NDlzICB8IDEw
MjhLaUIgICAgfCA5Ljk5NHMgICAgfCA1OTRLaUIgICAgIHwNCnwgIDIgICB8IDI1NSAgICAgIHwg
MTUuODI2cyAgfCAyMTcwS2lCICAgIHwgMTMuMzg3cyAgIHwgMTA2M0tpQiAgICB8DQp8ICAzICAg
fCAyNTUgICAgICB8IDFtNy4yMTFzIHwgMTIzMzVLaUIgICB8IDBtNTguNTE3cyB8IDEwMDA0S2lC
ICAgfA0KDQpjYXNlIDEuIGRpc2FibGUgZGlyc3luYw0KY2FzZSAyLiB3aXRoIHRoaXMgcGF0Y2gg
c2V0IGFuZCBlbmFibGUgZGlyc3luYw0KY2FzZSAzLiB3aXRob3V0IHRoaXMgcGF0Y2ggc2V0IGFu
ZCBlbmFibGUgZGlyc3luYw0KDQpDaGFuZ2VzIGZvciB2NDoNCiAgLSBbMS8xMF0gRml4IGEgc21h
dGNoIHdhcm5pbmcgcmVwb3J0ZWQgYnkgc3RhdGljIGNoZWNrZXINCg0KQ2hhbmdlcyBmb3IgdjM6
DQogIC0gWzIvMTBdIEFsbG93IGRlbGV0ZWQgZW50cnkgZm9sbG93IHVudXNlZCBlbnJ0eQ0KDQpD
aGFuZ2VzIGZvciB2MjoNCiAgLSBGaXggdHlwb2VzIGluIHBhdGNoIHN1YmplY3QNCiAgLSBNZXJn
ZSBbMy8xMV0gYW5kIFs4LzExXSBpbiB2MSB0byBbNy8xMF0gaW4gdjINCiAgLSBVcGRhdGUgc29t
ZSBjb2RlIGNvbW1lbnRzDQogIC0gQXZvaWQgZWxzZXt9IGluIF9fZXhmYXRfZ2V0X2RlbnRyeV9z
ZXQoKQ0KICAtIFJlbmFtZSB0aGUgYXJndW1lbnQgdHlwZSBvZiBfX2V4ZmF0X2dldF9kZW50cnlf
c2V0KCkgdG8NCiAgICBudW1fZW50cmllcw0KDQpZdWV6aGFuZyBNbyAoMTApOg0KICBleGZhdDog
YWRkIF9fZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSBoZWxwZXINCiAgZXhmYXQ6IGFkZCBleGZhdF9n
ZXRfZW1wdHlfZGVudHJ5X3NldCgpIGhlbHBlcg0KICBleGZhdDogY29udmVydCBleGZhdF9hZGRf
ZW50cnkoKSB0byB1c2UgZGVudHJ5IGNhY2hlDQogIGV4ZmF0OiBjb252ZXJ0IGV4ZmF0X3JlbW92
ZV9lbnRyaWVzKCkgdG8gdXNlIGRlbnRyeSBjYWNoZQ0KICBleGZhdDogbW92ZSBmcmVlIGNsdXN0
ZXIgb3V0IG9mIGV4ZmF0X2luaXRfZXh0X2VudHJ5KCkNCiAgZXhmYXQ6IGNvbnZlcnQgZXhmYXRf
aW5pdF9leHRfZW50cnkoKSB0byB1c2UgZGVudHJ5IGNhY2hlDQogIGV4ZmF0OiBjb252ZXJ0IGV4
ZmF0X2ZpbmRfZW1wdHlfZW50cnkoKSB0byB1c2UgZGVudHJ5IGNhY2hlDQogIGV4ZmF0OiByZW1v
dmUgdW51c2VkIGZ1bmN0aW9ucw0KICBleGZhdDogZG8gbm90IHN5bmMgcGFyZW50IGRpciBpZiBq
dXN0IHVwZGF0ZSB0aW1lc3RhbXANCiAgZXhmYXQ6IHJlbW92ZSBkdXBsaWNhdGUgdXBkYXRlIHBh
cmVudCBkaXINCg0KIGZzL2V4ZmF0L2Rpci5jICAgICAgfCAyOTAgKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAyNSArKy0tDQogZnMv
ZXhmYXQvaW5vZGUuYyAgICB8ICAgMiArLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAzNTIgKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiA0IGZpbGVzIGNoYW5n
ZWQsIDI5MyBpbnNlcnRpb25zKCspLCAzNzYgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4zNC4xDQoN
Cg==


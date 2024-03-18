Return-Path: <linux-fsdevel+bounces-14703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59A87E2F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 06:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640DEB216DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306121105;
	Mon, 18 Mar 2024 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="gxebkXCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8324420B0E
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739321; cv=fail; b=ftlNe0jwYebiTEleK2axhTcjqbCixO11YA+DyHR12geT0/9N+RPtYQEZG20RjYoavqgNAUB9JJ1Rs0r4BVv3LbnWGyhIfMpvM3E2bbVAwW+XAIngSUbmd4Gh42+DapfZZvU9McbZ2pZBttfwiZ1nQ6YBQE/6oYbYFGJpJ0h8iJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739321; c=relaxed/simple;
	bh=PnhzH8fGr0WSfz7Yzn2ZxGPtd6zTHnHVS/hK3zIJFio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sIRVgRgIbAXdcj3908OEb6yZJuuaUM1oChEK1r1XFqCHxBla9g3CPIeQF3VQJ7KooZyQUe2de+CE4zruLL/h08Ad3b1CVy8I0zHoLXmMjAZ2ZSs8TlvT5U+bmQ7uRPsERktHNUKA26HHgbvvundWPQ8WWAST9RiZHZ/bf2fptsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=gxebkXCS; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I5EV3U022214;
	Mon, 18 Mar 2024 05:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=PnhzH8fGr0WSfz7Yzn2ZxGPtd6zTHnHVS/hK3zIJFio=;
 b=gxebkXCS48IBoOa45MheQKxXeSODFd2UYqqh11RQTa1Ic2wDxUIrffiVKs7BCdGPu67Y
 UfJQmx+3eNmkM9Yybk1ATHxao0wju5de+kYNSDrIxsicRRElUN4qtkFaxqnS0PiEXwQ9
 sPzCN2Hfjm/ZKW4ktbD6Ecz0Yckbw82n+ExU7+YI1M/sGxrbrvLkpD4Z05ANXzJsD92/
 aGJwdOOZs5bHcO3w4D8Hb23FZ38oGgW2cmTb683umMYxOvkKtfJw52phDe7gj+KD/Mel
 xZ53XmxNct6FrCHp69LRDY7tfaAmPk2KqmxgvM4GfNHoszBVTiFC8Fcaboq0rsIuIlqg wA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2041.outbound.protection.outlook.com [104.47.26.41])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ww1mg9qcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 05:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKKODVDRw7NDNl5C6N9ZLL0aoUEUeVALB1jBbTh+JEaZaH3vsyVDwf9oIlWvXvtW341lDrDlLq5aPkvaYa8HRep0Z/rxGiGFfzYD+yXnMbtqSl6wYxgJVVXhZ2Lq9IzupLEVzwK2dttu3Z+aJf9C0fYQrIcSKvQkl1MjdM4EByo14+Jbj9fYyr1GHZXVQhgL3FQtA0R7sgjCCXIWCBI33bm4H50jNp65xXqQH1aayTxEV3SKIJsD9qi7ILcUVY/OlpXaZM5/E62OkbzdtePGZvaUDxBFZu6NtlVKXtIIsSlgnYYwCaDp+0YJrAVm6TFdQ5KSUBEkEDC0nNadT2ggRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnhzH8fGr0WSfz7Yzn2ZxGPtd6zTHnHVS/hK3zIJFio=;
 b=IwNL/lqDgT1t8wzKDHaeGDdjkZS1a/kzRgaR4SJwBBlMRc7doLy+YwsfwtdMri3LzRTJUEz1v6YXA5/rXqBErIPANffkvCmGZbwumZPWf/CswOTnCFs8iencXMXbcum1FnOQOzpFuKm3nsU4+m/tYX4/rcrOQ9vE7LPwV4uT7J3vC+4k1qYHahC3YweweKOgHYfWBY9H8EVCXLewIPg7Rflae1hO0QUXRFDtWBgslUSjleSoxoEO0VdY9jnb54i22WiQeLn2Q/yZ/qWQYkcjOiHFyQHHGxh+sXrTo/HeNN2NWA+Lm0o+kQ68F/QfGW10cv2JV+opdCjLY/SZDSasgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB5895.apcprd04.prod.outlook.com (2603:1096:4:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:21:29 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:21:29 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 01/10] exfat: add __exfat_get_dentry_set() helper
Thread-Topic: [PATCH v4 01/10] exfat: add __exfat_get_dentry_set() helper
Thread-Index: AdopyBE5IlGSbIfjRuOO+PgQhKYhxBPKZcsg
Date: Mon, 18 Mar 2024 05:21:29 +0000
Message-ID: 
 <PUZPR04MB63161DB744A8EA42F181323E812D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB5895:EE_
x-ms-office365-filtering-correlation-id: 5fb0f5e8-25c5-43d4-210b-08dc470b4473
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1Gwhp6nbjdXkuVI+Emtx7gqZrLpmc/uAHp0j9cdAuE2JmiUWqnYJQMzIHr4mCBVmDKYvhGvDDupwshs3a0KY7rXjByEh9YIBtSzIBkJ2jVtSKUzvLoYAkJvIlMiJSzztqHKuHRHm9bW5npM0ajQwAqtMEAWbdJPAJAy67EM3be7oQe8/Q8SvqWnGZEE7okIKicFBZa5aBPf70NQ42Dp7TXCiVEgCOnIqV0NMJdCB8aAajnK4+zS7WCKFwOJ8bAnoFQsF4JTfptMRl0UT+H95TcJFkfyo2GYEbzuaZeSsMo85ppDjEJwUzacHrW/xpQMyhkBu7kTp1zba8YQSz+KjIl7Qw+qb5BpVN/tlZfEb9TcSryHC7aI6Z+oC00DCzycznBlN33dq3oks9tpYS9Wi6cg7+BGxoN8+GD4UO8g5d/hnZUy5Umm0f/mjV7FBVDn7LwdaNqcx790XAWKq6GiCNxnidR7WOm0DxSzUSJhBZyf9RYHJnW5G7xBOJhjrPUP8qxNzo4enkfq0ixeNRzdxFfEyzMTWE5d3vKlJHmJxErtJuffRt5TEKbx640UjLWTvW0fX0y/ElDkm8PGaW8LaozaIi+Oaq0LrmLOMzM4hZfzlc4koBeUWqyXPJ/YGn9flEe/fAoz3UomOiturWcbBPI2WA+nEbFRXIdZj3kz5r215/8LlsTB7JB9o7zGv2kcKbPuI6Kqs7+gaM3uQSPQMku9oS2f5R/uC9+qQk8e/P60=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YXQwVzNrMHlyZDFSU254OStNZWxBVjZVdWg5elNtM2tVYkIwaGFKYlBwSHlj?=
 =?utf-8?B?QzFwMjN6QThNTm5DU3JEbUo0ZGliOHZjTDBzUjhSRzV6Zk5ZUERVTjJ5MjV2?=
 =?utf-8?B?bXF2ZXlOeHJ5MXlwUmg5NER2cCs2ZlpvYU10OWJlSGtkQ2tkdXdJMXU3U3pj?=
 =?utf-8?B?eWJueno3MmdaU29IV3QyQTFmNC84ekpQMTd2bzRkQ1pxSWtiSkUwWDh1TlpG?=
 =?utf-8?B?VGJLZmN4WUdvenRoakdZcVh3dGF3VjVERm1UakczVzNudjNZaHRBQ3RUM1R2?=
 =?utf-8?B?OUE4SDB0cnlNUFU0dWVvckRzK1RuZ2V0UjQ4UVFNUjJmQnQ2eE5BVmdJOGVP?=
 =?utf-8?B?SVRCZVdaSzNxUTNqTTE4bndlcWxrTHAzdGhVMEU5QWhlbDZZU0oxUlNIRXNZ?=
 =?utf-8?B?dldxZk00OTl0cVRyS0RLU1FBZzFKa2Mzc2xXMnA2Y1RyMVlxcjVHMXlXZnNP?=
 =?utf-8?B?bk5hSjhkNitvemVHVFRCLzdvNEVHVnRwR2lOeVByK3d5UjZZUVBLd3BRaVNq?=
 =?utf-8?B?UFYrczBSSmc3bnVKVk1GeDAzM0FOc0NUTUJzVXYzT2laYlRpMGMrY0dXaDVl?=
 =?utf-8?B?b3NmdG9qUGhKNEs3QzREbDhzOXJ5cTZKTUpTajYxZmpVQzdDQ2dDMWkzQVgw?=
 =?utf-8?B?bXQ4cTVIS1RkRWRtYUN2cktlOFZ2U2ptV01XbVFOQTNmMkVnM1U1TnZ3eWxN?=
 =?utf-8?B?ckswb3NpTFl3MWlzSkNwa2lpZnNFcWtPdlE5YTV3VExDaTRwOFBRektaZG9W?=
 =?utf-8?B?MGxzY0VEODJwVnhLNVVsU3V5MysyRlFpeExYeGpobks1b2NJOUpOckRpTXV4?=
 =?utf-8?B?V2tpZURnT2d4RkR0SGxWakhzQURTZ01tOHE3anJLc1lKZjF3WC9uaklzS21m?=
 =?utf-8?B?Yzd1R3FPSzNHY1FNbE02KzlRN2tWbHg1WGh1SkEzT3pzbmNIallxeVd6VzZp?=
 =?utf-8?B?b1UvWVFBbHV1ZGlsWUdMeGxXYmhvbU9LTHBhRjh4bkNWVU5LUkhtSUZNK1FN?=
 =?utf-8?B?dEhJdVlYNndpUWVnTnlKdElwazlIUmg2RGM0YnhsV3NBZERzRUM2MmZxdUZZ?=
 =?utf-8?B?a0l1YVhpWnREY09sMG9vVzVKU2lrOUdyZTdBU1JmbjJWSmIvOWpqZFc2NXVi?=
 =?utf-8?B?a1Q4VUVmbTk1RUdmRWt6VW1lTzI2Q3NVWFRLcGpFaWIwN01PdE1VdUphRVB5?=
 =?utf-8?B?L25mUzhGU2g2Qm82SS9QZndXTExnQitlMEo5bS92NnpsdjhaSU15K0JTY1Ba?=
 =?utf-8?B?dDZ1RTJFZGRQNW1MVFVoWGtURTQ3VE50a3JBV2NSUDBmcW5sUThJYlJIQWpy?=
 =?utf-8?B?UWMwSGtZSXViT1VKaHZhSitqczBaMnpnTzE3SURiVUlSc1ozTUNoYzJJNEFB?=
 =?utf-8?B?L0RhcU1ZWjhMbGlLZndRbGMxYXlndDdIbGZ3S0MxZGFkUW5CMVFTck0xZVhp?=
 =?utf-8?B?bm5UV3BRWUZmWDZ1amMxNWZFSWhRR2h1UGVZYVlrVC9CejhDWWNjd0dJN2Fn?=
 =?utf-8?B?bHZ3bS82QTAvaGFyek4rZ0FQbjlxMGdlNlJNRUVPRmluU0EwUktQcTB6L25M?=
 =?utf-8?B?Y1Z6c3Awd1F3TVd6OVJOZThTa21acEJZeE9Bb25Ocnc3bTl2WG9YbjV6VlBK?=
 =?utf-8?B?ZzF2ZnNDOFlMblRpcExJcWNKUVBZK0V6aEtWa1hrbjJMUDZDeFc4bDVNeXJi?=
 =?utf-8?B?YWlxWFZGcDdLN0lUbk8zVXhDUVNCQ3QwMldrdkFCZFZXQXZsbnZsVDdHSXlm?=
 =?utf-8?B?dU8vV3BNNmZMTzRScHoraDNIMnJiYzV6SXB5MkoxdXRWQXNzcEtkN1d2aDVl?=
 =?utf-8?B?VVpnY0ZOMldESEx5SVVJMlpkMjVjRVlQM053TXBmMTI2SkQ5aFNKbjNhNFpY?=
 =?utf-8?B?b0s3bzJsM2taRTExc1NjWW1SZlBuYXJxL0FoZ0NzYklnWlg4b0d5UVRnMHVJ?=
 =?utf-8?B?dVp1RlpqaWg5RzJBcDFya2U5Q1FPbHBVVEVxWnFoZlJIYjZZSXQvbTcrVDZq?=
 =?utf-8?B?a0ZMQzB5ZndDQktPcDVFcnV6Ukw4U2NyRElvcFhWUmljSUFxMnU1bFpuSFlZ?=
 =?utf-8?B?TmR0VHZwSVl3RXB5T0xsTzVSQ2ZFd29UTUNTMzJEbFhDeHVKQzVIM2tleEFn?=
 =?utf-8?Q?vcy9kDv01UGzxxRiiRQ0wseBQ?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wyNtDLQrkXxkNIX3CGtIa5oUjWcJBB0VK1H6jj1NQCYXiQzu7DvCtEI9lBy9ia20cL3oOVbYR61pUBPwmDtGfk02xGZFhhFt9VrqEutS4N3Qy6Se1xgEWXhGQuTMzYUQrphkqHXUbXZnmDtVhy+R/JeFVo/bcelx4zak/VU9UgL27d3G9daxWk/xhSbl62t720K6+uA2NPEM+AWemN6BsxT3PuSqKxG+3xRjRBTICiOnragA21H0w683ImpLOvr43ecmtI8M+v0gY83fwltcUi6y5SAgQrQl9eiTRXL0+Fyvq+ecEDXl37mX+gPzBPCfFfQw6+K67W4EU/osPl9r3smEXMJ51GNG9HmRUOZ7MjoeRBTyDkgBT6Ipl3zORUE3L+hYNghZX0nxspx9qOJBzqJ3Z2Ra6XEi28FldnGhBqkmuZUkiJcer0txigEtBhqDi+lCYaGQqkGg00s/8YoUDFpeFMZnXIKhVJ/RUo4ZTWGTuoCtvBSRMG78f87vT4I+evVx2G0InGS8GOCGGkrxIYIKqXc4GRw99I2+K7Klvyt6CUCXgfv1JW8Gn7YTLoLvy2llVqo5mz7CZPkSf+MAx9KyM8Mpsq+vIk/Wc3l6PRc475RLsncYCdOGeDZk3rj/
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb0f5e8-25c5-43d4-210b-08dc470b4473
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:21:29.8350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnNIjrI7G2zQuCzD5OBtQDolQR73lJ5ASSyWwkyCgnXFWgjQ0ilxWtkplvK/F+h+862gVOB9umuSvzBef0FCXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5895
X-Proofpoint-ORIG-GUID: hznLZX5XCRJuzbMkCOfo3UzyrdpIuDSr
X-Proofpoint-GUID: hznLZX5XCRJuzbMkCOfo3UzyrdpIuDSr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: hznLZX5XCRJuzbMkCOfo3UzyrdpIuDSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

U2luY2UgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoKSBpbnZva2VzIHRoZSB2YWxpZGF0ZSBmdW5jdGlv
bnMgb2YNCmV4ZmF0X3ZhbGlkYXRlX2VudHJ5KCksIGl0IG9ubHkgc3VwcG9ydHMgZ2V0dGluZyBh
IGRpcmVjdG9yeQ0KZW50cnkgc2V0IG9mIGFuIGV4aXN0aW5nIGZpbGUsIGRvZXNuJ3Qgc3VwcG9y
dCBnZXR0aW5nIGFuIGVtcHR5DQplbnRyeSBzZXQuDQoNClRvIHJlbW92ZSB0aGUgbGltaXRhdGlv
biwgYWRkIHRoaXMgaGVscGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhh
bmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4N
ClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2
aWV3ZWQtYnk6IFN1bmdqb25nIFNlbyA8c2oxNTU3LnNlb0BzYW1zdW5nLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+DQotLS0NCiBmcy9leGZh
dC9kaXIuYyAgICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tDQogZnMvZXhmYXQvZXhmYXRfZnMuaCB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCA0
MyBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0
L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IDlmOTI5NTg0N2E0ZS4uNTQzYjAxYTU0Nzll
IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAt
Nzc1LDcgKzc3NSw2IEBAIHN0cnVjdCBleGZhdF9kZW50cnkgKmV4ZmF0X2dldF9kZW50cnkoc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwNCiB9DQogDQogZW51bSBleGZhdF92YWxpZGF0ZV9kZW50cnlf
bW9kZSB7DQotCUVTX01PREVfU1RBUlRFRCwNCiAJRVNfTU9ERV9HRVRfRklMRV9FTlRSWSwNCiAJ
RVNfTU9ERV9HRVRfU1RSTV9FTlRSWSwNCiAJRVNfTU9ERV9HRVRfTkFNRV9FTlRSWSwNCkBAIC03
OTAsMTEgKzc4OSw2IEBAIHN0YXRpYyBib29sIGV4ZmF0X3ZhbGlkYXRlX2VudHJ5KHVuc2lnbmVk
IGludCB0eXBlLA0KIAkJcmV0dXJuIGZhbHNlOw0KIA0KIAlzd2l0Y2ggKCptb2RlKSB7DQotCWNh
c2UgRVNfTU9ERV9TVEFSVEVEOg0KLQkJaWYgICh0eXBlICE9IFRZUEVfRklMRSAmJiB0eXBlICE9
IFRZUEVfRElSKQ0KLQkJCXJldHVybiBmYWxzZTsNCi0JCSptb2RlID0gRVNfTU9ERV9HRVRfRklM
RV9FTlRSWTsNCi0JCWJyZWFrOw0KIAljYXNlIEVTX01PREVfR0VUX0ZJTEVfRU5UUlk6DQogCQlp
ZiAodHlwZSAhPSBUWVBFX1NUUkVBTSkNCiAJCQlyZXR1cm4gZmFsc2U7DQpAQCAtODM0LDcgKzgy
OCw3IEBAIHN0cnVjdCBleGZhdF9kZW50cnkgKmV4ZmF0X2dldF9kZW50cnlfY2FjaGVkKA0KIH0N
CiANCiAvKg0KLSAqIFJldHVybnMgYSBzZXQgb2YgZGVudHJpZXMgZm9yIGEgZmlsZSBvciBkaXIu
DQorICogUmV0dXJucyBhIHNldCBvZiBkZW50cmllcy4NCiAgKg0KICAqIE5vdGUgSXQgcHJvdmlk
ZXMgYSBkaXJlY3QgcG9pbnRlciB0byBiaC0+ZGF0YSB2aWEgZXhmYXRfZ2V0X2RlbnRyeV9jYWNo
ZWQoKS4NCiAgKiBVc2VyIHNob3VsZCBjYWxsIGV4ZmF0X2dldF9kZW50cnlfc2V0KCkgYWZ0ZXIg
c2V0dGluZyAnbW9kaWZpZWQnIHRvIGFwcGx5DQpAQCAtODQyLDIyICs4MzYsMjQgQEAgc3RydWN0
IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoDQogICoNCiAgKiBpbjoNCiAg
KiAgIHNiK3BfZGlyK2VudHJ5OiBpbmRpY2F0ZXMgYSBmaWxlL2Rpcg0KLSAqICAgdHlwZTogIHNw
ZWNpZmllcyBob3cgbWFueSBkZW50cmllcyBzaG91bGQgYmUgaW5jbHVkZWQuDQorICogICBudW1f
ZW50cmllczogc3BlY2lmaWVzIGhvdyBtYW55IGRlbnRyaWVzIHNob3VsZCBiZSBpbmNsdWRlZC4N
CisgKiAgICAgICAgICAgICAgICBJdCB3aWxsIGJlIHNldCB0byBlcy0+bnVtX2VudHJpZXMgaWYg
aXQgaXMgbm90IDAuDQorICogICAgICAgICAgICAgICAgSWYgbnVtX2VudHJpZXMgaXMgMCwgZXMt
Pm51bV9lbnRyaWVzIHdpbGwgYmUgb2J0YWluZWQNCisgKiAgICAgICAgICAgICAgICBmcm9tIHRo
ZSBmaXJzdCBkZW50cnkuDQorICogb3V0Og0KKyAqICAgZXM6IHBvaW50ZXIgb2YgZW50cnkgc2V0
IG9uIHN1Y2Nlc3MuDQogICogcmV0dXJuOg0KLSAqICAgcG9pbnRlciBvZiBlbnRyeSBzZXQgb24g
c3VjY2VzcywNCi0gKiAgIE5VTEwgb24gZmFpbHVyZS4NCisgKiAgIDAgb24gc3VjY2Vzcw0KKyAq
ICAgLWVycm9yIGNvZGUgb24gZmFpbHVyZQ0KICAqLw0KLWludCBleGZhdF9nZXRfZGVudHJ5X3Nl
dChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcywNCitzdGF0aWMgaW50IF9fZXhmYXRf
Z2V0X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBpbnQgZW50cnks
DQotCQl1bnNpZ25lZCBpbnQgdHlwZSkNCisJCXVuc2lnbmVkIGludCBudW1fZW50cmllcykNCiB7
DQogCWludCByZXQsIGksIG51bV9iaDsNCiAJdW5zaWduZWQgaW50IG9mZjsNCiAJc2VjdG9yX3Qg
c2VjOw0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOw0KLQlzdHJ1
Y3QgZXhmYXRfZGVudHJ5ICplcDsNCi0JaW50IG51bV9lbnRyaWVzOw0KLQllbnVtIGV4ZmF0X3Zh
bGlkYXRlX2RlbnRyeV9tb2RlIG1vZGUgPSBFU19NT0RFX1NUQVJURUQ7DQogCXN0cnVjdCBidWZm
ZXJfaGVhZCAqYmg7DQogDQogCWlmIChwX2Rpci0+ZGlyID09IERJUl9ERUxFVEVEKSB7DQpAQCAt
ODgwLDEyICs4NzYsMTggQEAgaW50IGV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9l
bnRyeV9zZXRfY2FjaGUgKmVzLA0KIAkJcmV0dXJuIC1FSU87DQogCWVzLT5iaFtlcy0+bnVtX2Jo
KytdID0gYmg7DQogDQotCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIEVTX0lEWF9G
SUxFKTsNCi0JaWYgKCFleGZhdF92YWxpZGF0ZV9lbnRyeShleGZhdF9nZXRfZW50cnlfdHlwZShl
cCksICZtb2RlKSkNCi0JCWdvdG8gcHV0X2VzOw0KKwlpZiAobnVtX2VudHJpZXMgPT0gRVNfQUxM
X0VOVFJJRVMpIHsNCisJCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwOw0KKw0KKwkJZXAgPSBleGZh
dF9nZXRfZGVudHJ5X2NhY2hlZChlcywgRVNfSURYX0ZJTEUpOw0KKwkJaWYgKGVwLT50eXBlICE9
IEVYRkFUX0ZJTEUpIHsNCisJCQlicmVsc2UoYmgpOw0KKwkJCXJldHVybiAtRUlPOw0KKwkJfQ0K
Kw0KKwkJbnVtX2VudHJpZXMgPSBlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dCArIDE7DQorCX0NCiAN
Ci0JbnVtX2VudHJpZXMgPSB0eXBlID09IEVTX0FMTF9FTlRSSUVTID8NCi0JCWVwLT5kZW50cnku
ZmlsZS5udW1fZXh0ICsgMSA6IHR5cGU7DQogCWVzLT5udW1fZW50cmllcyA9IG51bV9lbnRyaWVz
Ow0KIA0KIAludW1fYmggPSBFWEZBVF9CX1RPX0JMS19ST1VORF9VUChvZmYgKyBudW1fZW50cmll
cyAqIERFTlRSWV9TSVpFLCBzYik7DQpAQCAtOTE4LDggKzkyMCwyNyBAQCBpbnQgZXhmYXRfZ2V0
X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQllcy0+Ymhb
ZXMtPm51bV9iaCsrXSA9IGJoOw0KIAl9DQogDQorCXJldHVybiAwOw0KKw0KK3B1dF9lczoNCisJ
ZXhmYXRfcHV0X2RlbnRyeV9zZXQoZXMsIGZhbHNlKTsNCisJcmV0dXJuIC1FSU87DQorfQ0KKw0K
K2ludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICpl
cywNCisJCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIs
DQorCQlpbnQgZW50cnksIHVuc2lnbmVkIGludCBudW1fZW50cmllcykNCit7DQorCWludCByZXQs
IGk7DQorCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwOw0KKwllbnVtIGV4ZmF0X3ZhbGlkYXRlX2Rl
bnRyeV9tb2RlIG1vZGUgPSBFU19NT0RFX0dFVF9GSUxFX0VOVFJZOw0KKw0KKwlyZXQgPSBfX2V4
ZmF0X2dldF9kZW50cnlfc2V0KGVzLCBzYiwgcF9kaXIsIGVudHJ5LCBudW1fZW50cmllcyk7DQor
CWlmIChyZXQgPCAwKQ0KKwkJcmV0dXJuIHJldDsNCisNCiAJLyogdmFsaWRhdGUgY2FjaGVkIGRl
bnRyaWVzICovDQotCWZvciAoaSA9IEVTX0lEWF9TVFJFQU07IGkgPCBudW1fZW50cmllczsgaSsr
KSB7DQorCWZvciAoaSA9IEVTX0lEWF9TVFJFQU07IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykg
ew0KIAkJZXAgPSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQogCQlpZiAoIWV4ZmF0
X3ZhbGlkYXRlX2VudHJ5KGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwKSwgJm1vZGUpKQ0KIAkJCWdv
dG8gcHV0X2VzOw0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmggYi9mcy9leGZhdC9l
eGZhdF9mcy5oDQppbmRleCAzNjE1OTU0MzM0ODAuLjAzN2U4ODI3YTU2ZiAxMDA2NDQNCi0tLSBh
L2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCkBAIC01MDEs
NyArNTAxLDcgQEAgc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQo
c3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlpbnQgbnVtKTsNCiBpbnQgZXhm
YXRfZ2V0X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBpbnQgZW50
cnksDQotCQl1bnNpZ25lZCBpbnQgdHlwZSk7DQorCQl1bnNpZ25lZCBpbnQgbnVtX2VudHJpZXMp
Ow0KIGludCBleGZhdF9wdXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hl
ICplcywgaW50IHN5bmMpOw0KIGludCBleGZhdF9jb3VudF9kaXJfZW50cmllcyhzdHJ1Y3Qgc3Vw
ZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyKTsNCiANCi0tIA0KMi4zNC4x
DQoNCg==


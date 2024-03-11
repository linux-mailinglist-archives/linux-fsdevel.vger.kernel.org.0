Return-Path: <linux-fsdevel+bounces-14104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59632877A5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65B51F21F4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DDB1864A;
	Mon, 11 Mar 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="J0kohaBg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA217C77
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131144; cv=fail; b=JLso+cdeSIJmBHLIfGj+Dpq7Kt5YAf7RM0nc+DfNYB6sNDdGxf4Dnu3S7AT6AKa2wxQ4IabPBEE2qczzWWM9SjRI/QUVJGl/DL/2bFhe+te7qPa6HittF8QCinKNoLShKxNWvh/B/iqv/JdqSCgJxDygxO0XkUPklKnwUCaRLT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131144; c=relaxed/simple;
	bh=/4u/TY6uNxij5w/Kj9dXl++kd71MU1xXNXwr9AXACS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oX+eJ2x+uWDLlIM9HO++3/tBnvpkXK6Y+2ZgTlkYl84Qyl/A9LOeYiN7L6uHNQK7UPikKGwtdYAIrCIxAyAo+EAlk2sxvSp+aUPIFynwQyau3RhlFSoqOOURpKAaQt7R8MChH3NkH3mTvXPtE/iGwEGQXg9tuwlRlPxZukJqKXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=J0kohaBg; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B0MdoW032336;
	Mon, 11 Mar 2024 04:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=/4u/TY6uNxij5w/Kj9dXl++kd71MU1xXNXwr9AXACS0=;
 b=J0kohaBgR3iN+vQzKjcfSYLKewC/zv8s6DM0F8HYj3H1ng7IFbB8FFjndC7RtGf1wZne
 kL+jF7pDgrpT+0N12mU+aYpiJkTT2CpPSD5obaCFofALMS/5eycLBvqUoVQCPGKzB5os
 PBevQAAWkEyzWicH7ipmt5ZJkZsQKj5Q3t20sWWguak5QpR3qVjTLgWgg0xLkP1WHBML
 2szQNWKmpuPw32Ozb/NoM7On9l1TV1sbpf6VGYcBdsTTeXQBEjWnhhlxtqm715B/Ion/
 1AiO+G6pEHGsYFl3diQHu6rhDYVwU4e6vupRAUgQ/+dgKoJptpgagLjNBADl4ctVOshT yw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wrdyk1knh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:25:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRJAmt+rmhlh3NTkBjrkxNqp1DbbY54dq5f1G6E+YSMF9CdZtA3ElglVwXcVdYyyhgHUttJbKL2OhUrBeQkgJ1Wz26KQ/+Wy3ZPp7oYSZFXnfTbp29LDvLYS/XYFWYUtVCbY7OrsZwFK311eJKKJnhGtcJtwBGP+dEA9xmINtFl/4UwgEDFQojtRFUt2qrTtuVMJvVIBcgBZSGBC758D4AQ1cLJ4x/38G0udKFwlxdeEQ+5T01dP58k/4KfppkDtDTADA8bYA6yWq2xq29c21JvCNUF5J+f8sLKxI3ftFOjag+YiZ8KBICL2ZutYwVChyH7XaoPaiyi1ZPbRJb9sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4u/TY6uNxij5w/Kj9dXl++kd71MU1xXNXwr9AXACS0=;
 b=hEnJkOCBZq+yB9+1cg0bs7k1NC50Q/Y1TJXvopZg4Fmlmdee6VgkwRN6fbkE4JY2RPdPYZgJ8qHLeK9O800aLcyBKuaqjLl6UcNG8giKU3h7MYONQCKop01LH/aZ49FiTsKMGkLI29saADwqdTvIJy2kgmViuBrIgAiirSzR0dpgHcLfQ/+Lz+dUEktKBSX2MYaqH1FcXdG+G8Sw6yprkxiSV4DupvF3r142EdZ5SnW0CIgDW64Dh2FQYbrjKkM6lV77ctlkU0EzQVC/YpYvp5NQgeM6PAoCSnQ2nSFVXAkLVa9S/Wz12UHFllO51ToIHj78WaoS2exsUb4h/1Hg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by TYZPR04MB6635.apcprd04.prod.outlook.com (2603:1096:400:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Mon, 11 Mar
 2024 04:25:27 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:25:27 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 09/10] exfat: do not sync parent dir if just update
 timestamp
Thread-Topic: [PATCH v3 09/10] exfat: do not sync parent dir if just update
 timestamp
Thread-Index: Adj0JkwXPMQ8nbBQR7SEkH+NN01tmF/RPSvA
Date: Mon, 11 Mar 2024 04:25:27 +0000
Message-ID: 
 <TY0PR04MB63286CBC1C3972C41550742181242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|TYZPR04MB6635:EE_
x-ms-office365-filtering-correlation-id: 1e20544b-576e-44ea-177e-08dc41834744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 G66UK8I6qd5iA83X6TVwnr7/o8z/DKmvsDfUpuo2q7fIBh3vl+fsJcU8jEFFCg7mkXoeF/UKebukPMbuxbEiaQ4FRcTaKbKhVot1KAMr27alKhdlPN8B14VqphcFZWPGKHEyVvZ7PVZD/UKqb6c7bpMZG/5Y0Q1H017MvVclDV6pWhFnVjdg7nT6YqgJ2aoy6KZnw0vKKcB+1uygrtiMd6ZQD0FWnqzbxh/A2WlCr8vnWORys6hmU/GJRKeSUkyJgnrL1nw4WexmBQS4BmjmgOR34ADtRmxlHODLCe7csd8K+zjuqbY0CGANr+9v7QcOp3Io60XM6P2sMa1rpSgYm//YeP55G/39Zed6nfowzW5yYAXjEqQF++lVE2AsBXjkzT7kicAxYKpiPETFmJIq8iaOXjXKLw/2oJdXSDWtEDSHMr0pWUSDuZg4fcbMa3Y0uMmE7agj9+O8YiSbZ9Id4s9LIlRrdz9gjdbehInMbduY35AKTi0ZAZuSJ35t0Gs4cC46xcwVqByLC7Lk5CSZqOoWx30LIECyv5fT6mngayMKOOm6/gm2ZQzmU0/D8nrZIuhBG54YyW2ObNUmcdfTILzTZjFLnhf2Qcde+60hcM5GZymSxK7GuavMCWARqYlQZI29iGjInScIR3JkTq9S4TDkDUlyoDUNqAS0mqU6kfM5HP9morOGggEhO7wvD2sIRYWOw0ghAbLKBk21vSb9og==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WUtBVWljWlhDajFwejFZOHBuYStQbEUwemM0dVJ6YTZYNWlUVVY0SXlCUnBx?=
 =?utf-8?B?cldUOEVzd2Jiek92cDgvOGY1WTNxQTIxejIvdVVBWXpLUEJXenkvZy9YaDZw?=
 =?utf-8?B?d1h1SWc5NmpQSC9vM1BvL09GVHM3dnlvd3YwNDVBQUlGOWVsYmsvNGZ0MHRh?=
 =?utf-8?B?dys0YURWV0VRVU80eXdKdzRWa01TOUx3OVFUZGFtNythcWRRRGV5NDREUHcy?=
 =?utf-8?B?MnJGUHlnaHlRRTMyT0xRVXhCMjlrTmlpQUtESEJ1VGk1eGtsSVBJdDBJWkJU?=
 =?utf-8?B?TkY2azFWQ3M3S0ZZeWZUYis3NnE5dUdtUC9mSFdVbDl3Njk4Z1Y1SGZScmY1?=
 =?utf-8?B?cERGQzV2cnRuUSs2d0YxOUcwS2xwWFR6Njc5TVVrSVBzRUZHV20yQ1ErYnpw?=
 =?utf-8?B?VVJDSndDQzg0U2hXL05sM2JlRTdzcFVScm1LM2lncUlOVEcvK3RtRHB0cXJS?=
 =?utf-8?B?eVhzcmUzaFNJenNTOWNKdFU3dEdxSy9PR2dtWmFUTHRWT1J1ZTVvalFrSU5p?=
 =?utf-8?B?Q2dHb0F5T2JxdTdIQitUdDRoVWI3WUppYXp0QVBXd0VLU1lIWDQ2OHN2TDJW?=
 =?utf-8?B?UXpNOWUyRFBBcUtQWjUvbnVlY3pHb2MvdlFPWWtMQlFDSlNweUxZeXE5cUJ5?=
 =?utf-8?B?Yi9pQ3N5MXJlbW53bVlzbG5Mb3MxY3Y2RGc0c0E1WmR6SE1GTjBhRnlVU215?=
 =?utf-8?B?cFVJT3ZQUXQza1QvUFcvWkNIU1R3MmFyRWQrMFdIdDFTQ1RUbXBUR2twRW1I?=
 =?utf-8?B?NUdXMzlhMmpsZDh1WVZDWVlsa09wM1dVYWV4WjdUN0lIOW9jRjhyQTBYL3FS?=
 =?utf-8?B?Ym5hcHUxYTNNWGRUSjJJMHpMOENOMFl0MmVBU1RCQ2ZGMHIvMkJ4TnBYYW9M?=
 =?utf-8?B?bkRjampSUjdKbWRuVy85QTNlb0dvQnUxdHQ4Yzhyem42cVl1NU9YMFFmUGpm?=
 =?utf-8?B?UkY4L2tVOGdzRmNRczJiR3ZJbFdWMjBwZ0NZS1JqTUxlUXpvOWFCbSt2bEVu?=
 =?utf-8?B?YTB2K0R1SVJkZUlXQXhzMmZmakxqQmZsYnhUNGoraStYVG4rL3ZIQk9xMTdj?=
 =?utf-8?B?TUVTVkhlQkQ3TWhTcTJjM1JJaUZsaVpWYjlzd3lyZGx0U2VNN2d1Z081c3Jy?=
 =?utf-8?B?eS93dE14T0pmUVo0dHdzZEp3V0xvS1ZzSGlkOFFwU3Z5T1lZcnFIK3dNbFVl?=
 =?utf-8?B?NmhIajAyUWtFSFd4bzJDK3Q5bGJON2pVVnRNdHNOYit5Y21UOUlBM1VBdlR4?=
 =?utf-8?B?UmwzUy9BSnNxWFp4QVV4NHhIT3dTRUJnSlJJNWwxbFN2OGVsOXNodUhTU3Z3?=
 =?utf-8?B?ZmFjeDZxREZSUnM2cXlPVUR5a1dyS3gxRlU2RFdTSlpTU0NjMUZyY1UxaTVE?=
 =?utf-8?B?K3ExWWRHeEtEUVZBVDNZaUo1bTBqNHIrTTZnc0I0Z2xRTXRFaVJXQzNxZG9U?=
 =?utf-8?B?OVFXcWxEQ0phbThUWUlQMTQ4ckQyRHJ2OG94cUs2QW1nNlc5Q1VicDFmaFVv?=
 =?utf-8?B?aEp3bnQ5cEhBUUQ3UGdXMUg1eG5lczMzY3haQWo2T055THB0aVFmcjRlWjBa?=
 =?utf-8?B?ckxiQW9RenJZaVAxZVBESFdGWXBkM252M1ptSDJpVUt4RVh6ZUtOOHltYi9y?=
 =?utf-8?B?VUswcjU1UFR6SU5UTm9FdDIvZDk0MUFQR3BhSE5TbnFZUERCNHZPZldQMklM?=
 =?utf-8?B?N1NGWXl5MFpYSTdVVE5jNnFPcFNjYjRKOGo0anAzWWNXKzE4a2ViYTN5TVc2?=
 =?utf-8?B?ZTA1NlFPRmFnRmlhR0xLOVJJUnovL0UyVE9PL1p4dy9MNEorZXJPc0N0N3lp?=
 =?utf-8?B?c3Z3Yzk0R1ZZQWo1ZmF0L3F4aFFscGY3UTgvUWdBNjJNRkEyaUUwRGFEZkkw?=
 =?utf-8?B?L1BnZkFzNWhoVktaZVBZSEF2dGt1TEFsa2JBYUw3OWpVNjVIRkpsL3A0WlhT?=
 =?utf-8?B?R2dxbVFraDJOUW9MeXcySktiMjhuR1Y0SVBmclNpMEdlOUJPMVNuaG1zNGdw?=
 =?utf-8?B?UjcvaFRGZy9tY1lITkJmd1U0OSs4dEovSWFja1FmMFYyYXNudmdBSFhEQXha?=
 =?utf-8?B?MVNkNmFkV0p1dTlPQUpYVkZJdUdyc2I5TStRRmEzdWo4dHZYYjJrR1JRbFY3?=
 =?utf-8?Q?E51stD2AZ0T0izkgR0nWiEBP6?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yy4TVqdmtswfRbmXii4PYglhlmC7PeQxbNur3XDXtlBOBPjvvoyMs67jhd0TFqEzBLl3jwcsdv3KFUo8E4yN7jsvy7VYaaA49bpQERYPM0aS52Vnro5AV7hpgqgJHlsinyPplRJ/JyTXOxcviFmDMuKUu7SNkaZs7b36cft0TXlAL8rc1L54lykPscOXUxEh/Qp1VUEzJytHLoSQSv1of9O2c2p3KdKKhfKphkVSjGYe7E3xeB4xlxA0gdL1m6WncD0XFLe67x3WdoosVac+iTEYW8+1fMl4AN9VbaGnvafeOOwLR/r7q9tbtAWLn3onAGGGM+SbJCj1m5Lqy0elRN558hivHVWQNe8WZ0GBkyQv07PMhwZ70zLxcTtIm7ZliO5ryFKTJTYaQcJfe/0UdhpDsGisiabiEOqAKr1bXAaN2BOnzX27NG7+edspxLEnJ4vJ9XMKqAjvXVVLoUCiLEbhsdXN4O7IE7c6saAER34cH03P3fJ1T8kLx1SqgS1ORFrIR4VVwUA9uW5n7qKhex0o9jKMP4RvFw2VPiWfLXDUvsg1vF7zaEZ43qqr79W7B1u7lvHK99VrG7LyPUIOmUka8XXhmNklJGyzkurKKh+Mz6+O0AIYYVaim+//qDGt
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e20544b-576e-44ea-177e-08dc41834744
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:25:27.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hyEfyLTI0mhu5YJsMfJ8axkBhR3o1Pxodi+8sSLmLuWTDwTYq6U+J0o1CZj2ykAaE316883KFxIoo1nXVEXALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6635
X-Proofpoint-GUID: pO9LMEOPQV3kl2RJ-m8l_Rn1H6__I4XY
X-Proofpoint-ORIG-GUID: pO9LMEOPQV3kl2RJ-m8l_Rn1H6__I4XY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: pO9LMEOPQV3kl2RJ-m8l_Rn1H6__I4XY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

V2hlbiBzeW5jIG9yIGRpcl9zeW5jIGlzIGVuYWJsZWQsIHRoZXJlIGlzIG5vIG5lZWQgdG8gc3lu
YyB0aGUNCnBhcmVudCBkaXJlY3RvcnkncyBpbm9kZSBpZiBvbmx5IGZvciB1cGRhdGluZyBpdHMg
dGltZXN0YW1wLg0KDQoxLiBJZiBhbiB1bmV4cGVjdGVkIHBvd2VyIGZhaWx1cmUgb2NjdXJzLCB0
aGUgdGltZXN0YW1wIG9mIHRoZQ0KICAgcGFyZW50IGRpcmVjdG9yeSBpcyBub3QgdXBkYXRlZCB0
byB0aGUgc3RvcmFnZSwgd2hpY2ggaGFzIG5vDQogICBpbXBhY3Qgb24gdGhlIHVzZXIuDQoNCjIu
IFRoZSBudW1iZXIgb2Ygd3JpdGVzIHdpbGwgYmUgZ3JlYXRseSByZWR1Y2VkLCB3aGljaCBjYW4g
bm90DQogICBvbmx5IGltcHJvdmUgcGVyZm9ybWFuY2UsIGJ1dCBhbHNvIHByb2xvbmcgZGV2aWNl
IGxpZmUuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNv
bT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9u
YW1laS5jIHwgMTkgKysrKysrKystLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWku
YyBiL2ZzL2V4ZmF0L25hbWVpLmMNCmluZGV4IDc5ZTNmYzlkNmUxOS4uYjMzNDk3ODQ1YTA2IDEw
MDY0NA0KLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFtZWkuYw0KQEAg
LTU0Nyw2ICs1NDcsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X2NyZWF0ZShzdHJ1Y3QgbW50X2lkbWFw
ICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQogCXN0cnVjdCBleGZhdF9kaXJfZW50cnkgaW5m
bzsNCiAJbG9mZl90IGlfcG9zOw0KIAlpbnQgZXJyOw0KKwlsb2ZmX3Qgc2l6ZSA9IGlfc2l6ZV9y
ZWFkKGRpcik7DQogDQogCW11dGV4X2xvY2soJkVYRkFUX1NCKHNiKS0+c19sb2NrKTsNCiAJZXhm
YXRfc2V0X3ZvbHVtZV9kaXJ0eShzYik7DQpAQCAtNTU3LDcgKzU1OCw3IEBAIHN0YXRpYyBpbnQg
ZXhmYXRfY3JlYXRlKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5vZGUgKmRpciwN
CiANCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKGRpcik7DQogCWlub2RlX3NldF9tdGltZV90b190cyhk
aXIsIGlub2RlX3NldF9jdGltZV9jdXJyZW50KGRpcikpOw0KLQlpZiAoSVNfRElSU1lOQyhkaXIp
KQ0KKwlpZiAoSVNfRElSU1lOQyhkaXIpICYmIHNpemUgIT0gaV9zaXplX3JlYWQoZGlyKSkNCiAJ
CWV4ZmF0X3N5bmNfaW5vZGUoZGlyKTsNCiAJZWxzZQ0KIAkJbWFya19pbm9kZV9kaXJ0eShkaXIp
Ow0KQEAgLTgwMSwxMCArODAyLDcgQEAgc3RhdGljIGludCBleGZhdF91bmxpbmsoc3RydWN0IGlu
b2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCiAJaW5vZGVfaW5jX2l2ZXJzaW9uKGRp
cik7DQogCXNpbXBsZV9pbm9kZV9pbml0X3RzKGRpcik7DQogCWV4ZmF0X3RydW5jYXRlX2lub2Rl
X2F0aW1lKGRpcik7DQotCWlmIChJU19ESVJTWU5DKGRpcikpDQotCQlleGZhdF9zeW5jX2lub2Rl
KGRpcik7DQotCWVsc2UNCi0JCW1hcmtfaW5vZGVfZGlydHkoZGlyKTsNCisJbWFya19pbm9kZV9k
aXJ0eShkaXIpOw0KIA0KIAljbGVhcl9ubGluayhpbm9kZSk7DQogCXNpbXBsZV9pbm9kZV9pbml0
X3RzKGlub2RlKTsNCkBAIC04MjUsNiArODIzLDcgQEAgc3RhdGljIGludCBleGZhdF9ta2Rpcihz
dHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlub2RlICpkaXIsDQogCXN0cnVjdCBleGZh
dF9jaGFpbiBjZGlyOw0KIAlsb2ZmX3QgaV9wb3M7DQogCWludCBlcnI7DQorCWxvZmZfdCBzaXpl
ID0gaV9zaXplX3JlYWQoZGlyKTsNCiANCiAJbXV0ZXhfbG9jaygmRVhGQVRfU0Ioc2IpLT5zX2xv
Y2spOw0KIAlleGZhdF9zZXRfdm9sdW1lX2RpcnR5KHNiKTsNCkBAIC04MzUsNyArODM0LDcgQEAg
c3RhdGljIGludCBleGZhdF9ta2RpcihzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwgc3RydWN0IGlu
b2RlICpkaXIsDQogDQogCWlub2RlX2luY19pdmVyc2lvbihkaXIpOw0KIAlpbm9kZV9zZXRfbXRp
bWVfdG9fdHMoZGlyLCBpbm9kZV9zZXRfY3RpbWVfY3VycmVudChkaXIpKTsNCi0JaWYgKElTX0RJ
UlNZTkMoZGlyKSkNCisJaWYgKElTX0RJUlNZTkMoZGlyKSAmJiBzaXplICE9IGlfc2l6ZV9yZWFk
KGRpcikpDQogCQlleGZhdF9zeW5jX2lub2RlKGRpcik7DQogCWVsc2UNCiAJCW1hcmtfaW5vZGVf
ZGlydHkoZGlyKTsNCkBAIC0xMjM5LDYgKzEyMzgsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFt
ZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwNCiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IG9s
ZF9kaXItPmlfc2I7DQogCWxvZmZfdCBpX3BvczsNCiAJaW50IGVycjsNCisJbG9mZl90IHNpemUg
PSBpX3NpemVfcmVhZChuZXdfZGlyKTsNCiANCiAJLyoNCiAJICogVGhlIFZGUyBhbHJlYWR5IGNo
ZWNrcyBmb3IgZXhpc3RlbmNlLCBzbyBmb3IgbG9jYWwgZmlsZXN5c3RlbXMNCkBAIC0xMjYwLDcg
KzEyNjAsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1h
cCwNCiAJc2ltcGxlX3JlbmFtZV90aW1lc3RhbXAob2xkX2Rpciwgb2xkX2RlbnRyeSwgbmV3X2Rp
ciwgbmV3X2RlbnRyeSk7DQogCUVYRkFUX0kobmV3X2RpciktPmlfY3J0aW1lID0gY3VycmVudF90
aW1lKG5ld19kaXIpOw0KIAlleGZhdF90cnVuY2F0ZV9pbm9kZV9hdGltZShuZXdfZGlyKTsNCi0J
aWYgKElTX0RJUlNZTkMobmV3X2RpcikpDQorCWlmIChJU19ESVJTWU5DKG5ld19kaXIpICYmIHNp
emUgIT0gaV9zaXplX3JlYWQobmV3X2RpcikpDQogCQlleGZhdF9zeW5jX2lub2RlKG5ld19kaXIp
Ow0KIAllbHNlDQogCQltYXJrX2lub2RlX2RpcnR5KG5ld19kaXIpOw0KQEAgLTEyODEsMTAgKzEy
ODEsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZShzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwN
CiAJfQ0KIA0KIAlpbm9kZV9pbmNfaXZlcnNpb24ob2xkX2Rpcik7DQotCWlmIChJU19ESVJTWU5D
KG9sZF9kaXIpKQ0KLQkJZXhmYXRfc3luY19pbm9kZShvbGRfZGlyKTsNCi0JZWxzZQ0KLQkJbWFy
a19pbm9kZV9kaXJ0eShvbGRfZGlyKTsNCisJbWFya19pbm9kZV9kaXJ0eShvbGRfZGlyKTsNCiAN
CiAJaWYgKG5ld19pbm9kZSkgew0KIAkJZXhmYXRfdW5oYXNoX2lub2RlKG5ld19pbm9kZSk7DQot
LSANCjIuMzQuMQ0KDQo=


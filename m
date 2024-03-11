Return-Path: <linux-fsdevel+bounces-14103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BF9877A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5761C20F3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2AE1802E;
	Mon, 11 Mar 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="J4BqeUmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5817BA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131142; cv=fail; b=AaY4luvCUlVzqLJfAdcwMizPtahvjSGXZBzN0llV6IKdgyHxLmDSVUsSLqfu04QLFIQVybeGVXzMR2QQsbdWYHbCbDb9qV6KaIvCfULZOSBAOqZ9vcSkZTqyVV2DRHae0Jgov8Vk4cq/fLAZ62PftqVh3EwYU97tLvbj4LdTTh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131142; c=relaxed/simple;
	bh=wjmzE3N8ZLCReZ+zcGvb7uzyCcTV2KO5e7dqaEhiDp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eWh8g9ZzRGoIIk33n41Nw6np1wp9OsJuXhjJbLw6AYX40BWPr1YzHP0DwCsrPNvMsPBNDn3Bxu6UUfroQHh42pv9PT4jrGyP5V8Kh/DJ5TdKwF1bohlReJ6ARTl4NEPH4js2kerjWw/5HSypOG0SY398krebVYHyxlTjdKCtJDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=J4BqeUmf; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42AMVSlA006255;
	Mon, 11 Mar 2024 04:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=wjmzE3N8ZLCReZ+zcGvb7uzyCcTV2KO5e7dqaEhiDp0=;
 b=J4BqeUmf07wPdnhbYw7/WBXmSzT5N2y5vIK1PnX84fr6WlZ2p+Y2KeECTpskHWrkHh7d
 nnGBEDKp5IIHQFVMMM7TgGfoIQ79cz8llKb/lJRlhMmAdkxIa+Nj919SsZEV1BwIAjTH
 lLLQ/UQAlsqJgaaM+5oljXT2evrbKT/SR7tuPC5EOKhCl0PPHe0ur5Fb2mKqBDxWS3oQ
 3J3drLZLzvGmw7Ir/ZM0JdfKR3Llx/5H3nmL7x5fRCqVQnr0JYwLcRuVhpObeFDazoYd
 aoC7HIPROHgTdXOic4dHxfazJBu+yHebbHX+Iw6SN8NFolxrf5i1vKLtVw2RJ7ZlvfAt nQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wrcx79nbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5M72KdCETWGrdW2eDARsZ0XAahD1LphJyXQobpfPU7aib5JJBYe54M+ug4lkvof4mKScxrxGIHf4alu8bD7TIZH0kRdP/0RGA3hcRv6QCKAVYaui2dlph8p8flLHjvUg6A20UXLooB4z1j37dgrUDOqgegwf0lvab/9p4gpq0hP2Dab8lN1fMO1tjeVDvDtgfsB3jXtiEZ12QEki7HhjuFLUF+cmTWeH7/eaSQjfsIcgLsnw82sK/4M3Qu1aPZC06feSO+3nsfQEQrlSPoJLFdLqyJ7H1KT2Ni7YxubpDaU7WyeQGK8vgA6UGcmid2xtdIgRr14KnltQDkLHKvU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjmzE3N8ZLCReZ+zcGvb7uzyCcTV2KO5e7dqaEhiDp0=;
 b=m/tJuHntGofTsGXUwDAqsv/E4Bl+6hJRKxAeC8CFJ32IxfRKDYg7hsb0VdqGSHL/a/s/jI2KX2HEyIZTnjNmWKSxpn2hGdueA948mTQ7smYaFgyxhqGpnZfhxk0wnORb6LcN0VUyfTMyIqmVr8b/bUPXY+PBwWUyTLK0G85m9+01PPaTGz7mtKE4Udp7MNvVXVqcbIEg076NHsh6G18E8510lEQwC6bhqmFneolzjmduBkR9/PPHf1bcCCIe31TAJQ2cBchoxc8Hcewn8E0zioLfLAdg9+gr/LcQAT69AGigSE5wdLuMLBSZ8ZZdC4VqP6lkIStepBbGoeBya2K6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by TYZPR04MB8020.apcprd04.prod.outlook.com (2603:1096:405:b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 04:25:23 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:25:23 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 08/10] exfat: remove unused functions
Thread-Topic: [PATCH v3 08/10] exfat: remove unused functions
Thread-Index: AdioqVU2cw34s+96S16hkmg3u1B6mHKwcanw
Date: Mon, 11 Mar 2024 04:25:22 +0000
Message-ID: 
 <TY0PR04MB6328D68ED0CA313F940D3EC381242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|TYZPR04MB8020:EE_
x-ms-office365-filtering-correlation-id: f0a367fb-c2c8-4f7a-210f-08dc418344c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 v3DIurtWohdRlpOfHzrVDFMlqwOUq9Naut8Hs4LfuI8IA3cqaVMnWI9SHkqHk7jQcXymJ7NsMOC2BwTKh6L+MlRy/PV+7OycyBnPAQazlRKb+5XSjoGnMRHbty7pMNfVKpFZ2puA1jOOfgkec5RtZxe0PBWWxXPr8zQGZVwzjE0JMfYz4o8ycQoj7BsOh2v5q55XftjVf9xA0yGG7snZnxrDS+FitIhxcgeqQyvqMnvksElgPTEM2irDAYdFrkdo7J11P5FCmpqLjhZSYOaA210xD/uVGVmBObkIdk+izFDZ/1zgzLMC2vguL0lOK286b6rOVupeg1lLDUAISdaBrM+f+01AzxcbBdPWxY5gxTvvwZ6795dWX5G+ZBksSsQPygdQEWRfYxqbAKFpVLdwEGf5P3gvCmfiknOm+8w/eS6ah3qSHGagENXTOcdMW4YrAsoifTB+FzwqYG0ywckboyy5qNpYV8aL89vT/qlqRN+Uk7bwgfhCvT8PbzeFSqmesbr0TLs/1OKcLNwdu3u/DPBjSFi5nDJdCPMxvWF4uEezO2QaJ3A2SG/RuCSSXtiF4JVkumhd3ZaUwPgvNrgKqF45wLCFM4kFjkC6NqMC9Dgv8cr3s0+mHbiQv6MwxhdFebKDFfxVoMUT/Bl6PPB1/i6KlI7Ps3xIWtiwNEBXxhICacoFmJSFcEEMSKJj4s6aSr5eir1JDC0+I0dfwwqWHLo/+19W/O6G0CcvuAep3NY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dEhubG94cTRVUHNIRm9IcTU3ZzU5VmJBbzFRSjNlR2hLWTBnMTBuRUdOMlVF?=
 =?utf-8?B?ekYxUEM1NFJMYW1DVy9KNUlBYmRzNHZMN0FYUTBqaDAvWmY3TzBmOWFQamZh?=
 =?utf-8?B?N254UDRHejdld2UxQ1FrYUtScUtuQktsNUJ6YnNLaDNzL3pvQ0srUGJzZ25H?=
 =?utf-8?B?ampzZTYvcFh5VG9yNSsvVWhxK1N5SXEyOXg1RE9BWXM3Y3FwMjZmTWx1ZVho?=
 =?utf-8?B?M0dqTzU5Y0lzMStVTk1YbUV3aVo2Tk5ycHlodmtod2lRNkUrNW1aRm9VekVh?=
 =?utf-8?B?UmI0dFFyZnd1cUlHbXBtQ3JYVnA4M3UwaE40a3ZOekRvb3J6cVJHVm1VS0lM?=
 =?utf-8?B?eTg3RTUwRUhUWEtsQWZpNVBYT3hYNmVuSExnV2VaZDhNQ2IwSDVvUlRqTnhu?=
 =?utf-8?B?TXBsZ0wxU2QwMHdkSTFFa2dCYWEyWE9zZXoyVmhKaDA0c3BCWEdwRUZleUNx?=
 =?utf-8?B?YVpQYmhPTi9neDNTejFRUnljTGMxVHkwTVlHOFVGZVYxWFAwRnhtN2ltWEk1?=
 =?utf-8?B?QlVTSnp5Lzc4Z3Z4dloraUpDcDd2SzFMQXN2eXVHQ253SmI0dWM1NVNiSFpZ?=
 =?utf-8?B?bjRiSk5oUnJ6RzhoeXEyUXhpYWh1WnhtZ0F0TUJoSVJ6UmlnOXBhOUluWWJY?=
 =?utf-8?B?M05rLzdNaUczRnZGZ2M0Z0NOcjJjMTAwc2o5dzBHbUlSNVdYOGlBZExxUVlP?=
 =?utf-8?B?bzRFL3VCOHI3N1lwaVR6QUNUUTFzWjlWWEZ2ditobEgxUnl2bSswSk1OeWtx?=
 =?utf-8?B?Nm8wU2NubXhnem4vTjVtQUEvVi9ZUzRwZFAzamg2V3dQd1RRV3N4QVZ2dlNY?=
 =?utf-8?B?RUhPb0xXQU5YeDZpOW5UZ0hhL2Y4a3RuRjQ4NUF1TW5EWGN0ZXp6ZnBIZVcr?=
 =?utf-8?B?Qm81WVZGeUhYLzJ4bXRkTDV2N2dlMnpua0NwYWRWeDJRMVNaK2xFVHpHamEv?=
 =?utf-8?B?dXNPUGh2UjFNcFJFMGJ0N0ltWlFMdGtFMjg2SWtrOUhlL3lxVCtCbEplUGh5?=
 =?utf-8?B?SFlsYlpyV09OSlNZN1ZoQnJ3bGppZlp4bFRKSHVuSmtqN0h1NDRKcDhCYVRW?=
 =?utf-8?B?T282WmtkYUV6TlhMUFErU2U2c0dQY0MzWWVtcjdJblpLU0hhU2lrZmtSbUdQ?=
 =?utf-8?B?Z0lNUGFNT3dLcWh3M0FocW1YWC80QTU2ckhWbzZ6UElOMlpsVWxlOHJUWU5V?=
 =?utf-8?B?WGpLQTJvSjFjblRmWFRwU0h3Zk9VaUtpUlBqc2dURnJvUHlFL3U4c3dzeWU3?=
 =?utf-8?B?Y2U3ZTB3SER3VFZkb21BWE84dm9RVjJSeGhyZnF0OE4zWGhtQXNJK2ViSEhF?=
 =?utf-8?B?NnRpUzBaQjJqTVVaalZadUNPdERqTFZNdDUwNHNEOXc5TEFOdDRaa1orN0Zl?=
 =?utf-8?B?Z3JMNHNkZEVpZWxnNHVDUldBWnc5WXZWbHExVDlXak53V1dJSzRxQmpKYjNB?=
 =?utf-8?B?NS93NUZENFl3UHJUQUZNeWRpRlVtYzNKdzRXNHJFSzhqcTUzSXdsMDZheDJv?=
 =?utf-8?B?S000ejNJbC9TdmRuTHpEVzhZMG4vcE1ESkRWR3NYSlVhMnd3S2Z5SzFvNTVS?=
 =?utf-8?B?bjlqUVBLVWxMMEIwM0xBam12MzBVRzVVMWIvSWhiTzZYY3JlcVorOTJ3ZEpL?=
 =?utf-8?B?QlludkxwV3k4Nnl3MFZjcGhOMklFOHNTT0hRWW55VGpuTCtabkl5UFh3cFRs?=
 =?utf-8?B?M2drc2ZKRDdIcFc3VVErWFlhdDFDVERCNzE1VTFYcUhaQjlFaGZWek1pWWM2?=
 =?utf-8?B?TnVSUE5DZFZ0NzFLYVVvRkIwU2ZJODAzTlV2eXNWTXBWSFd2a0R4UFA3dXRM?=
 =?utf-8?B?TDAybWx0WlNUOFpNWVhob3hsTXhCc2ZBeUxWV0RuUmJaMi9QU2pGVFYveUtM?=
 =?utf-8?B?TDcwdzBPOWIrQ3RoUkxTQ3hKdlNRZFVZVUZGS2JWL2k2ZTIwcDBURXFZVzFW?=
 =?utf-8?B?NGtlY0NDU3A1Wis1UEc5WXMrLzd4KzVDUHdhVHpCSGNYNDhOaS8xdzMyWGFM?=
 =?utf-8?B?NTQrV29objNsZkZTMmNobnZxMVB1SHRra2RvOHFqVHdsR0tCQkVxQ1ZQQ0Vj?=
 =?utf-8?B?b0dvdndXOHI5SjBmcGx5R0VXS1cza1ExV25yamlYdmwyeDBFaUIwNm9LcjBR?=
 =?utf-8?Q?H1Ao3I+fZxml9qjGAXn/Fh+kO?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YN7QFVsDanMnm+8GrtRZ6g9ItMtLcla+NQXlRfEzgJ4ZcS7GD7uMXpwF4F0GOYHJB51SFRyq+p8cSlr2cmyBRyIviNvZ5Ue2o6ueDpWw1SdSz9NK5nZL7BBrx8uvAgyW5x+GAcT3Lups6HsR/blN/m2IksmBKxxpSFBGd2EyMkpRH47Mk4yku74/hKBEhm9+l9KFLYimU5ALYU1n/7RTMprC0cM5bpQggfzkRBxegHqTjrJjIOXC1R+n1zXLqaO+4p1jUZ2+59kYv7GxljekVuOoDJ9BLnMR8pxcdQhtbtLFuQGbRm1wRLfJBb8H7NGDt3PXDjKD/Za9tLJo2eXt5UTK2J9FGn7eWoUM31hss2qNEeDh+Gw57Lgg3kUhdZ5tbAtW/SIAsb1Si821FPvl4+6fYCH1Dt1ZjewF9mLWUuCG1w63loXm4TOMHtT0XBtOIrjQdhem1IQ9cKGE39Z4jNqjCxicvidbiu2BvnqA4rz2Shcgvmr9XW5oYAm0q2FSsIOjQRZNT2U/Sj+8u9JkbCtSgzT8MO/RU5aYl+9y/LWK6Dk34V2DmwxcRBVNb8r8dJGT2/+YErrRDklN18JATp8LYANIi/40noRt+ADzX8q9Xu4LndxWRXBLS4lr3vZF
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a367fb-c2c8-4f7a-210f-08dc418344c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:25:22.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIzz7Qer4ZcimMnlsYfmRrVQRsNMr/RSKToecVLWb/QVzv9SnQUPpKstaGwcpjLvtjSXiVcfo1DOTSiJTDuOOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8020
X-Proofpoint-GUID: L5NOUtah5FfwEZ_65ClgOwh8N2NyXBur
X-Proofpoint-ORIG-GUID: L5NOUtah5FfwEZ_65ClgOwh8N2NyXBur
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: L5NOUtah5FfwEZ_65ClgOwh8N2NyXBur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

ZXhmYXRfY291bnRfZXh0X2VudHJpZXMoKSBpcyBubyBsb25nZXIgY2FsbGVkLCByZW1vdmUgaXQu
DQpleGZhdF91cGRhdGVfZGlyX2Noa3N1bSgpIGlzIG5vIGxvbmdlciBjYWxsZWQsIHJlbW92ZSBp
dCBhbmQNCnJlbmFtZSBleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93aXRoX2VudHJ5X3NldCgpIHRv
IGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+
DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBB
b3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQvZGly
LmMgICAgICB8IDYwICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgNiArLS0tLQ0KIGZzL2V4ZmF0L2lub2RlLmMgICAg
fCAgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2NCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4
IGQ0M2RjNWYwZDM3NS4uNDlmZTZiNzFlOTU3IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMN
CisrKyBiL2ZzL2V4ZmF0L2Rpci5jDQpAQCAtNDc4LDQxICs0NzgsNiBAQCB2b2lkIGV4ZmF0X2lu
aXRfZGlyX2VudHJ5KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAlleGZhdF9p
bml0X3N0cmVhbV9lbnRyeShlcCwgc3RhcnRfY2x1LCBzaXplKTsNCiB9DQogDQotaW50IGV4ZmF0
X3VwZGF0ZV9kaXJfY2hrc3VtKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBleGZhdF9jaGFp
biAqcF9kaXIsDQotCQlpbnQgZW50cnkpDQotew0KLQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0g
aW5vZGUtPmlfc2I7DQotCWludCByZXQgPSAwOw0KLQlpbnQgaSwgbnVtX2VudHJpZXM7DQotCXUx
NiBjaGtzdW07DQotCXN0cnVjdCBleGZhdF9kZW50cnkgKmVwLCAqZmVwOw0KLQlzdHJ1Y3QgYnVm
ZmVyX2hlYWQgKmZiaCwgKmJoOw0KLQ0KLQlmZXAgPSBleGZhdF9nZXRfZGVudHJ5KHNiLCBwX2Rp
ciwgZW50cnksICZmYmgpOw0KLQlpZiAoIWZlcCkNCi0JCXJldHVybiAtRUlPOw0KLQ0KLQludW1f
ZW50cmllcyA9IGZlcC0+ZGVudHJ5LmZpbGUubnVtX2V4dCArIDE7DQotCWNoa3N1bSA9IGV4ZmF0
X2NhbGNfY2hrc3VtMTYoZmVwLCBERU5UUllfU0laRSwgMCwgQ1NfRElSX0VOVFJZKTsNCi0NCi0J
Zm9yIChpID0gMTsgaSA8IG51bV9lbnRyaWVzOyBpKyspIHsNCi0JCWVwID0gZXhmYXRfZ2V0X2Rl
bnRyeShzYiwgcF9kaXIsIGVudHJ5ICsgaSwgJmJoKTsNCi0JCWlmICghZXApIHsNCi0JCQlyZXQg
PSAtRUlPOw0KLQkJCWdvdG8gcmVsZWFzZV9mYmg7DQotCQl9DQotCQljaGtzdW0gPSBleGZhdF9j
YWxjX2Noa3N1bTE2KGVwLCBERU5UUllfU0laRSwgY2hrc3VtLA0KLQkJCQlDU19ERUZBVUxUKTsN
Ci0JCWJyZWxzZShiaCk7DQotCX0NCi0NCi0JZmVwLT5kZW50cnkuZmlsZS5jaGVja3N1bSA9IGNw
dV90b19sZTE2KGNoa3N1bSk7DQotCWV4ZmF0X3VwZGF0ZV9iaChmYmgsIElTX0RJUlNZTkMoaW5v
ZGUpKTsNCi1yZWxlYXNlX2ZiaDoNCi0JYnJlbHNlKGZiaCk7DQotCXJldHVybiByZXQ7DQotfQ0K
LQ0KIHN0YXRpYyB2b2lkIGV4ZmF0X2ZyZWVfYmVuaWduX3NlY29uZGFyeV9jbHVzdGVycyhzdHJ1
Y3QgaW5vZGUgKmlub2RlLA0KIAkJc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXApDQogew0KQEAgLTU1
Miw3ICs1MTcsNyBAQCB2b2lkIGV4ZmF0X2luaXRfZXh0X2VudHJ5KHN0cnVjdCBleGZhdF9lbnRy
eV9zZXRfY2FjaGUgKmVzLCBpbnQgbnVtX2VudHJpZXMsDQogCQl1bmluYW1lICs9IEVYRkFUX0ZJ
TEVfTkFNRV9MRU47DQogCX0NCiANCi0JZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW1fd2l0aF9lbnRy
eV9zZXQoZXMpOw0KKwlleGZhdF91cGRhdGVfZGlyX2Noa3N1bShlcyk7DQogfQ0KIA0KIHZvaWQg
ZXhmYXRfcmVtb3ZlX2VudHJpZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2Vu
dHJ5X3NldF9jYWNoZSAqZXMsDQpAQCAtNTc0LDcgKzUzOSw3IEBAIHZvaWQgZXhmYXRfcmVtb3Zl
X2VudHJpZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNo
ZSAqZXMsDQogCQllcy0+bW9kaWZpZWQgPSB0cnVlOw0KIH0NCiANCi12b2lkIGV4ZmF0X3VwZGF0
ZV9kaXJfY2hrc3VtX3dpdGhfZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUg
KmVzKQ0KK3ZvaWQgZXhmYXRfdXBkYXRlX2Rpcl9jaGtzdW0oc3RydWN0IGV4ZmF0X2VudHJ5X3Nl
dF9jYWNoZSAqZXMpDQogew0KIAlpbnQgY2hrc3VtX3R5cGUgPSBDU19ESVJfRU5UUlksIGk7DQog
CXVuc2lnbmVkIHNob3J0IGNoa3N1bSA9IDA7DQpAQCAtMTIzOSwyNyArMTIwNCw2IEBAIGludCBl
eGZhdF9maW5kX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRf
aW5vZGVfaW5mbyAqZWksDQogCXJldHVybiBkZW50cnkgLSBudW1fZXh0Ow0KIH0NCiANCi1pbnQg
ZXhmYXRfY291bnRfZXh0X2VudHJpZXMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4
ZmF0X2NoYWluICpwX2RpciwNCi0JCWludCBlbnRyeSwgc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXAp
DQotew0KLQlpbnQgaSwgY291bnQgPSAwOw0KLQl1bnNpZ25lZCBpbnQgdHlwZTsNCi0Jc3RydWN0
IGV4ZmF0X2RlbnRyeSAqZXh0X2VwOw0KLQlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOw0KLQ0KLQlm
b3IgKGkgPSAwLCBlbnRyeSsrOyBpIDwgZXAtPmRlbnRyeS5maWxlLm51bV9leHQ7IGkrKywgZW50
cnkrKykgew0KLQkJZXh0X2VwID0gZXhmYXRfZ2V0X2RlbnRyeShzYiwgcF9kaXIsIGVudHJ5LCAm
YmgpOw0KLQkJaWYgKCFleHRfZXApDQotCQkJcmV0dXJuIC1FSU87DQotDQotCQl0eXBlID0gZXhm
YXRfZ2V0X2VudHJ5X3R5cGUoZXh0X2VwKTsNCi0JCWJyZWxzZShiaCk7DQotCQlpZiAodHlwZSAm
IFRZUEVfQ1JJVElDQUxfU0VDIHx8IHR5cGUgJiBUWVBFX0JFTklHTl9TRUMpDQotCQkJY291bnQr
KzsNCi0JfQ0KLQlyZXR1cm4gY291bnQ7DQotfQ0KLQ0KIGludCBleGZhdF9jb3VudF9kaXJfZW50
cmllcyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyKQ0K
IHsNCiAJaW50IGksIGNvdW50ID0gMDsNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5o
IGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggYjQzNDMwYWFjNjliLi4wZGVjOTEwMTc3ZTEg
MTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9mcy9leGZhdC9leGZhdF9m
cy5oDQpAQCAtNDMwLDggKzQzMCw2IEBAIGludCBleGZhdF9lbnRfZ2V0KHN0cnVjdCBzdXBlcl9i
bG9jayAqc2IsIHVuc2lnbmVkIGludCBsb2MsDQogCQl1bnNpZ25lZCBpbnQgKmNvbnRlbnQpOw0K
IGludCBleGZhdF9lbnRfc2V0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIGludCBs
b2MsDQogCQl1bnNpZ25lZCBpbnQgY29udGVudCk7DQotaW50IGV4ZmF0X2NvdW50X2V4dF9lbnRy
aWVzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQot
CQlpbnQgZW50cnksIHN0cnVjdCBleGZhdF9kZW50cnkgKnBfZW50cnkpOw0KIGludCBleGZhdF9j
aGFpbl9jb250X2NsdXN0ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgaW50IGNo
YWluLA0KIAkJdW5zaWduZWQgaW50IGxlbik7DQogaW50IGV4ZmF0X3plcm9lZF9jbHVzdGVyKHN0
cnVjdCBpbm9kZSAqZGlyLCB1bnNpZ25lZCBpbnQgY2x1KTsNCkBAIC00ODYsOSArNDg0LDcgQEAg
dm9pZCBleGZhdF9pbml0X2V4dF9lbnRyeShzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICpl
cywgaW50IG51bV9lbnRyaWVzLA0KIAkJc3RydWN0IGV4ZmF0X3VuaV9uYW1lICpwX3VuaW5hbWUp
Ow0KIHZvaWQgZXhmYXRfcmVtb3ZlX2VudHJpZXMoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0
IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlpbnQgb3JkZXIpOw0KLWludCBleGZhdF91
cGRhdGVfZGlyX2Noa3N1bShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4g
KnBfZGlyLA0KLQkJaW50IGVudHJ5KTsNCi12b2lkIGV4ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtX3dp
dGhfZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzKTsNCit2b2lkIGV4
ZmF0X3VwZGF0ZV9kaXJfY2hrc3VtKHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzKTsN
CiBpbnQgZXhmYXRfY2FsY19udW1fZW50cmllcyhzdHJ1Y3QgZXhmYXRfdW5pX25hbWUgKnBfdW5p
bmFtZSk7DQogaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCXN0cnVjdCBleGZhdF9jaGFpbiAqcF9k
aXIsIHN0cnVjdCBleGZhdF91bmlfbmFtZSAqcF91bmluYW1lLA0KZGlmZiAtLWdpdCBhL2ZzL2V4
ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCAwNjg3Zjk1Mjk1NmMuLmRkODk0
ZTU1OGM5MSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMNCisrKyBiL2ZzL2V4ZmF0L2lu
b2RlLmMNCkBAIC05NCw3ICs5NCw3IEBAIGludCBfX2V4ZmF0X3dyaXRlX2lub2RlKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIGludCBzeW5jKQ0KIAkJZXAyLT5kZW50cnkuc3RyZWFtLnN0YXJ0X2NsdSA9
IEVYRkFUX0ZSRUVfQ0xVU1RFUjsNCiAJfQ0KIA0KLQlleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93
aXRoX2VudHJ5X3NldCgmZXMpOw0KKwlleGZhdF91cGRhdGVfZGlyX2Noa3N1bSgmZXMpOw0KIAly
ZXR1cm4gZXhmYXRfcHV0X2RlbnRyeV9zZXQoJmVzLCBzeW5jKTsNCiB9DQogDQotLSANCjIuMzQu
MQ0KDQo=


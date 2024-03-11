Return-Path: <linux-fsdevel+bounces-14098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2C877A58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 05:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A87828208B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9B12E40;
	Mon, 11 Mar 2024 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="XnEPw9ZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C23125AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131122; cv=fail; b=JcZqD/8hXpTydy+PvVuLVnkuwNJHRqkU3kL7YpfgM4JDjegM59hwxEIZ5V7+r7wHVINeUGXgyEgm55KVh4UejOSPwcjsocF05eqZVceiOy8uiH7+H2TR/T1dpfoa6dXFVuc9+Om6YYaZ5IDJnsWon52eNgEG/Uh0TbCmd08HL6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131122; c=relaxed/simple;
	bh=6Dawln/6a0k7QjekUq6nmoqez5VyJWCkrhmjJFSQpas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGhMfwxuSD86nNDd6uI25OWHkBFnyB7uXDd22tPSW8UHgWSLYnHm3P8zuu/9IhBfhGmXszhFJprXNabY/uCPJUZxklyFyJaGdbYmPQc8rqvIYP2iuRtARNcjQqCB65FJI6+cj/JodyYjF9EDWk+8cDXlInVCPoSu1frxw+nON/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=XnEPw9ZD; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B2SAvV008497;
	Mon, 11 Mar 2024 04:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=6Dawln/6a0k7QjekUq6nmoqez5VyJWCkrhmjJFSQpas=;
 b=XnEPw9ZDLs0WuGydYW5HMScMi0F1NKlV3aowwBBa1hgiGHql2vB5BRNcsNdNFH/r7kS4
 b0rmrJTj56XYjA/O4aMK5WeWBe4+pqUtp8XNInS2/trFLAnhX2eCxgD9eci/7SG30pyv
 ihSOO2lSSKXdMYw6hwEeuNUi4KsHYvR72tPpDqWY6/96hQO8+z1u5E8tCo3c0IUWSN/e
 jVDFQhi3Re83VUCQgjZrlAmgTtOWUf0fWh5hd+iMll4kTBjqyGoXEQjUOEfRKMWMU0w8
 tzxs6/VtJAQ3L2nZ6rqnedG041lKJXN4/AEB94pz+vTdOy3STeC/jyS1lFkmuWBXyqUC cQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wrcx79nb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 04:24:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G98YJsKGtVds1JPrui79PUjeGBYXHDE+Mh0YSdpSw0CK2CcEJYriQafeONceUF3JBDBMyFkVuQcJ3k6dNq+pL57nQqyZqGSPvyYP1hjP5ABPjMWYRGd6W/YOARwytLEEh58+WfTTrHrWVV1BOZJ21s0VKX6f8eQjlsqHplyI+DC6cx0p1DbEuPKPSJuAloVpIO26QGrzsUHOBufXPxtwvugUINIOHjYHFB40HOFEh2t83AitLIJmAwKvvSjNsKRqHMfUHO6kny8bXyVJfnBVJPcVK1k3vUbrlPnH4Og92HWoTyhcgu4mgG/5dyxEEBEG2+MyVADmXmNQrXxOs+LkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dawln/6a0k7QjekUq6nmoqez5VyJWCkrhmjJFSQpas=;
 b=djwPrudwUZLoDyqZDCQl4cFww6IpL1VDIzY9Krai0TSea/7GoaqEV5gEBsirqMVGHw/qR12JWccM3vfF63SfcXhtRrIjfKTVFtjgB5l+v9z6tw6pJ2XZibDJMS2Wr/uyTbDYa6BB9FCOvwitiAlTp8JbZb1jxFdxGjUUhfAQx/ULqPkbm26XytJGYbBl+Fu73cL+6EfOgMGDlcYCtapzc6w/6zpK1m4/zKwC8lygtRZUN8QJiMT7f7W8Bmp9/4b9mkJnQbe3pE7Lo4tSxmYPepPEanIBOchDikmJ7bODsbF9Cyjh/onTPiYRgRe/H4A7c05eG6M3da5ZTw2AsFbnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com (2603:1096:400:279::9)
 by SEYPR04MB7362.apcprd04.prod.outlook.com (2603:1096:101:1a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 04:24:53 +0000
Received: from TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd]) by TY0PR04MB6328.apcprd04.prod.outlook.com
 ([fe80::c5b0:d335:658e:20bd%7]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 04:24:53 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v3 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Topic: [PATCH v3 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Index: AdoLEwb3BqJ/1QsqTGuzkEKI9476vhoVrEqQ
Date: Mon, 11 Mar 2024 04:24:53 +0000
Message-ID: 
 <TY0PR04MB632867D87989990B3C76FEDC81242@TY0PR04MB6328.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR04MB6328:EE_|SEYPR04MB7362:EE_
x-ms-office365-filtering-correlation-id: 9488a6f2-6b64-4078-e98c-08dc4183330b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Cd33AkKfjfH5VXqBfS7B/4DdpqLnn/IqeTBcH4H4rF2EsSF96lxzdnuQddxE5VMxLrYNiYFBig77RZZ/U9HgzjDSCiaEteGgzAYw7L8aQjOqx1jP2is0DZvo1g0MjqqiEtXlOAqt1dQd7DIdJUSdhucV7Y9dhVpiHIjcCAa8SHacxodpK4rLMfyMLePhIJ35gui0SzavOh7n6NlsdAcZqhlTkkJNnZ79Yv9mz+v86BuEiDWtax98/bVs+B0InfTK5v17lB+177+OebBYDC64r4VFSiyZuBYKks24wnzibz8zn0njbVjbjpXcqZAJcj86Ml/wi0zmuqWdzTfvkpvjjphKXSuoFVhCs6Gua4I+080jPlBuPoXHqoSiF+c3TK/DBgVhyUdAzwWZzQ/kkvDRxMJdirm+HnaACBFLL+f+CzyF++ipagIB7kWa8uV0aetu4+IOcCjl5JIg0y7/186paTwevse2PQDlDz4hG8YXhyDCL5v85x8heCluOO9z8qs4pSquNDWXyRwgu/ZkMLVdmcezPnOYFUtPejX1ITvWKxvYCcO2ZTZOaRLekDka0BUHRHgXjXK3DwAVYhdjYaaoA7nP071LnjQq59bsRJVzFyrsD4oKu71B48opmNWhUMj7RmZyHZ9JMnXGQrcFFblUJdH8TWHmaze1ZIJzqA/reoR7ZuRbCZBlDuN6ksQOsUu51nlnoC4VoqZAL/qG9Onx95bTqNf4lPHr5w3u8z9AbSI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR04MB6328.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dlZ5WjZPSzJOQUZyd21VaktCWjN6N1dmK2xsN1ZQVVcwbSs5ZFF4RVhUMFIv?=
 =?utf-8?B?TUlKQVEvOEhnUnFCVHF2YjRkQnQ5MTg1ZVFpZFliSFNIR3JHdEFZSUlaQkdx?=
 =?utf-8?B?TEpmL1hCSUJYVHlSUmJtZUdrS3VrK3V5ZExTcWtubG1ESTNjZWJveDVqUGQy?=
 =?utf-8?B?VzhLeVRGTmF5aTRlUjIyaWVoUmhXUjhwVkhGeUl0UkxyMjhMZjNTNUpyTmpB?=
 =?utf-8?B?L2l1WXdud25tRnE3OGxvTTBtdGliR3czTktIamJFOTBNVmVFMmozcStrSDI2?=
 =?utf-8?B?MDVINkRYN2liL2FiSnpLczh5TmM2enNjN1JUejFKZ1FnMGZyK1RtNHUycXNk?=
 =?utf-8?B?MC8xUng1YURlbjNLQzFhRmZPVUtib0pLTmRzdDF1cWZxQ2lqZFRING5GR3Bp?=
 =?utf-8?B?VUlPeFhXa2pVRllWNkxyMHduMXk3ZVd4OW9iU09GQlhxd25Tbks4blJtZ2ZT?=
 =?utf-8?B?RXRWVG81OFlrZHZBdlRxRE13MWNkOFB0azJrMjZTTzl4Ny9sem51NHd4M3d3?=
 =?utf-8?B?ZFZLV3ZraGprMTk0OXE3a2RaT09SMHN2OUlobUFzYUtzSEovWHc3ZFU4Tjdz?=
 =?utf-8?B?bWs4cVJndndKVmxGbHprSmFacTNtQlUrbGM0OVA1d3RLaXZnSWw1Wk9ZYklw?=
 =?utf-8?B?UDBocnhWMkl4Q1Rqd1FlMlNVSmoxUnRaQnBtdm9EUldxZGNXWFJNU0pHalFW?=
 =?utf-8?B?aS84MzlVWlZSbzlaVm1YaFJUQkw1dCt5a0xJM0VUOFVVeHVMdWg1T2NPbDd6?=
 =?utf-8?B?R29zb081SHFTMWozZFBVenJXbnk3MnVjQXhpcDlueHNad0RiT0gzNytCVlBq?=
 =?utf-8?B?NnR0Y1Q5Tnd2bm02bjdVSi9nbFJkaDMrREJicUJ3RUk4SUt3eGt4M3lqajlE?=
 =?utf-8?B?NTNYWXJrME94YWxxK3hFaUloR0grOGJhbWpleDBvL0tzY2xVVkpNSWtjZk1x?=
 =?utf-8?B?UnlKTUU3VDZqRTBBeTV3enNNZjg3UlFORlJuS29KWHBzUmM1TzQvSG5PZ2dk?=
 =?utf-8?B?bkQxNXAwandIWFNtSkExQVgyN3A2SXZJdkdYQWY3dytxK2xxQzdyNVVDUnlJ?=
 =?utf-8?B?d3ZnNEtZczFhM21UczNpQVB0bnR1OU82N2RMS0RQbFBXM0FhZ3h3U2NqQmpz?=
 =?utf-8?B?TzlIdzRmVXk0YzlvOHVYRFkwblNPT3ZmQzh3MlZvTSsyQmx1eUJNTktNNldh?=
 =?utf-8?B?NVlGR2pKdzVlZUxhb285amdHdTFoSmZobmJIdWdGVW95d0p6VXhzVktMbk1s?=
 =?utf-8?B?c0tGUlA0dHpsVGZlZFduY1piU3VtaVlkejZFMm53d1RMblljRWRCQTcxREhz?=
 =?utf-8?B?SHdmMWpqSXAyeGJQZkNRVVRKRGU2bVg1RGd1bXdncGpJM1JuWjdabWwwdDdw?=
 =?utf-8?B?dU5jYXNTRmx1dURRMEFXWVQxME9GbHFPWENkVzJZczhCY0NaNmd5bi9TN2hF?=
 =?utf-8?B?bExQRWJNRU9jRzN3MWRXV3FEZTRNemF3ZjVSb1RRV2tpck45ZCsvRlZBeXVY?=
 =?utf-8?B?STJWM2VuTWpoY25PTG5aYXJLRXBTUmZoYVAwWGdZazZZektKcGdhYXJkWnFQ?=
 =?utf-8?B?V0ZKdm9Pdm5vblp1ZWVNUFNPUHVrRnFsM2ZyUUkralVSTmdEWDRtOGU0VVU4?=
 =?utf-8?B?YVlsTGgvOG81U2NUN2JDMDRRSEo0SXBOT2VPNExCVjJtcFR1eGh5S0o4TnRm?=
 =?utf-8?B?R1FBRWRjb25EdXMzSElLdG1xWFgvOUFxOHVFaW4wSEh4NWN0NU1FSXBmRVVH?=
 =?utf-8?B?V3ZrQ1JtSVFFV2RoN05TczhQTDhWdFdzMkdWNTl3c3M5SlVuZDVaTVpNWEt4?=
 =?utf-8?B?dTJLNzd4ak9Pd3A3R25qbFNJVkRSUnMzeGsxcXMyWTcyOEhuYzBLSTM2bmUr?=
 =?utf-8?B?eGF4UTc3UzYyNCtkMVFIVnpZS2pXdmNENGNhdU1hZE9sZ2JCVHdlYkVjMUpM?=
 =?utf-8?B?MGRFUG5XczJKemlQUTlKL2F0WVpwbVhQczhTQW1EUDZ6UWZaMFNGbkc5S3VH?=
 =?utf-8?B?aGkxR1RCdVdQMDNZRzE5S1VLdkVwSyt6MmJiVGc5ekNiZDV3YUVVN3dPOVhz?=
 =?utf-8?B?WXVxbFRMVVdPSkVoZXRSajJxSkRMTEYvYUVSREFDcEVVNDVBbjdQdUlIRGZC?=
 =?utf-8?Q?F7n52cJ6eKfoVcKLVA/07JtKO?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sloVQ1dnxtV5dCveV1dJvUr1HYGYPjBw0u4yzPIRy9DFIJZ9bvmbnmz0vvE0r7I1sYUciNjiBucfeQd4Bvtmxo5SbWzxHOVmZsfMxGp+gGtIVvN5LWoETJmAZypVOB6TD824XOxjtdCOmyl/gR1txhxL4aNPQyGRr4oII62VcfN7YVdheAvTbKkgCqJBxWmYy1cXfZfc/zm2u/8+8GG+MpEeXBl6MmtZJai81Nml28QZkhBldzViIugDrro1iuUxzyroCeDWYFk6R59EWP3Kbo/YaR/E7O44i+R3mgu8FAN0sSe6TZVXBIIg5e7jay4gn2UGZWxcycrK+/8YEd3QT9+3mDPo/IpzQd7WFazM1lIEcz3GMZgvHlgfht39Xwg7batSFNE20K89NA/QU6Yeh+p1T/yuhWnlQQsGxgpEClH33pElsk5yK/BtN3wwn833+oDniXAhUn5NwMkvsVjKw9KgFG6P2SeHQsNdTlVER8Hna9MLRma/T12f605WH4bXxLAdGIUGePpOP4GhpRLNqulKCuG1GDnpKeVr6yIZg7pCo18J90wESPzzUoqeChQxZAw4vRggRvfczAcz1lNqJit2U646ta8PCzXepL+PejNxQjWJwFrEz5RZc+0V5lE6
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB6328.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9488a6f2-6b64-4078-e98c-08dc4183330b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 04:24:53.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7011bsws7ZuFj/2jPD9Y79XADVjHPHREsSBbQSEmiBS5wGSUjvUae6etVtbXKWQt4FI30Wmfuoh428shxVtxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7362
X-Proofpoint-GUID: DqpbZkLFKAC4aj6a65EkA_k1849gIseo
X-Proofpoint-ORIG-GUID: DqpbZkLFKAC4aj6a65EkA_k1849gIseo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: DqpbZkLFKAC4aj6a65EkA_k1849gIseo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_01,2024-03-06_01,2023-05-22_02

VGhpcyBoZWxwZXIgaXMgdXNlZCB0byBsb29rdXAgZW1wdHkgZGVudHJ5IHNldC4gSWYgdGhlcmUg
YXJlDQpubyBlbm91Z2ggZW1wdHkgZGVudHJpZXMgYXQgdGhlIGlucHV0IGxvY2F0aW9uLCB0aGlz
IGhlbHBlciB3aWxsDQpyZXR1cm4gdGhlIG51bWJlciBvZiBkZW50cmllcyB0aGF0IG5lZWQgdG8g
YmUgc2tpcHBlZCBmb3IgdGhlDQpuZXh0IGxvb2t1cC4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhh
bmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHku
V3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBz
b255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2Rpci5jICAgICAgfCA3OSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBmcy9leGZhdC9leGZhdF9mcy5oIHwgIDMg
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Zz
L2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IGNlYTkyMzFkMmZkYS4uZDRiMmNk
ZDg3OTAwIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0L2Rpci5j
DQpAQCAtOTUwLDYgKzk1MCw4NSBAQCBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCXJldHVybiAtRUlPOw0KIH0NCiANCitzdGF0aWMg
aW50IGV4ZmF0X3ZhbGlkYXRlX2VtcHR5X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3Nl
dF9jYWNoZSAqZXMpDQorew0KKwlzdHJ1Y3QgZXhmYXRfZGVudHJ5ICplcDsNCisJc3RydWN0IGJ1
ZmZlcl9oZWFkICpiaDsNCisJaW50IGksIG9mZjsNCisJYm9vbCB1bnVzZWRfaGl0ID0gZmFsc2U7
DQorDQorCS8qDQorCSAqIE9OTFkgVU5VU0VEIE9SIERFTEVURUQgREVOVFJJRVMgQVJFIEFMTE9X
RUQ6DQorCSAqIEFsdGhvdWdoIGl0IHZpb2xhdGVzIHRoZSBzcGVjaWZpY2F0aW9uIGZvciBhIGRl
bGV0ZWQgZW50cnkgdG8NCisJICogZm9sbG93IGFuIHVudXNlZCBlbnRyeSwgc29tZSBleEZBVCBp
bXBsZW1lbnRhdGlvbnMgY291bGQgd29yaw0KKwkgKiBsaWtlIHRoaXMuIFRoZXJlZm9yZSwgdG8g
aW1wcm92ZSBjb21wYXRpYmlsaXR5LCBsZXQncyBhbGxvdyBpdC4NCisJICovDQorCWZvciAoaSA9
IDA7IGkgPCBlcy0+bnVtX2VudHJpZXM7IGkrKykgew0KKwkJZXAgPSBleGZhdF9nZXRfZGVudHJ5
X2NhY2hlZChlcywgaSk7DQorCQlpZiAoZXAtPnR5cGUgPT0gRVhGQVRfVU5VU0VEKSB7DQorCQkJ
dW51c2VkX2hpdCA9IHRydWU7DQorCQl9IGVsc2UgaWYgKCFJU19FWEZBVF9ERUxFVEVEKGVwLT50
eXBlKSkgew0KKwkJCWlmICh1bnVzZWRfaGl0KQ0KKwkJCQlnb3RvIGVycl91c2VkX2ZvbGxvd191
bnVzZWQ7DQorCQkJaSsrOw0KKwkJCWdvdG8gY291bnRfc2tpcF9lbnRyaWVzOw0KKwkJfQ0KKwl9
DQorDQorCXJldHVybiAwOw0KKw0KK2Vycl91c2VkX2ZvbGxvd191bnVzZWQ6DQorCW9mZiA9IGVz
LT5zdGFydF9vZmYgKyAoaSA8PCBERU5UUllfU0laRV9CSVRTKTsNCisJYmggPSBlcy0+YmhbRVhG
QVRfQl9UT19CTEsob2ZmLCBlcy0+c2IpXTsNCisNCisJZXhmYXRfZnNfZXJyb3IoZXMtPnNiLA0K
KwkJImluIHNlY3RvciAlbGxkLCBkZW50cnkgJWQgc2hvdWxkIGJlIHVudXNlZCwgYnV0IDB4JXgi
LA0KKwkJYmgtPmJfYmxvY2tuciwgb2ZmID4+IERFTlRSWV9TSVpFX0JJVFMsIGVwLT50eXBlKTsN
CisNCisJcmV0dXJuIC1FSU87DQorDQorY291bnRfc2tpcF9lbnRyaWVzOg0KKwllcy0+bnVtX2Vu
dHJpZXMgPSBFWEZBVF9CX1RPX0RFTihFWEZBVF9CTEtfVE9fQihlcy0+bnVtX2JoLCBlcy0+c2Ip
IC0gZXMtPnN0YXJ0X29mZik7DQorCWZvciAoOyBpIDwgZXMtPm51bV9lbnRyaWVzOyBpKyspIHsN
CisJCWVwID0gZXhmYXRfZ2V0X2RlbnRyeV9jYWNoZWQoZXMsIGkpOw0KKwkJaWYgKElTX0VYRkFU
X0RFTEVURUQoZXAtPnR5cGUpKQ0KKwkJCWJyZWFrOw0KKwl9DQorDQorCXJldHVybiBpOw0KK30N
CisNCisvKg0KKyAqIEdldCBhbiBlbXB0eSBkZW50cnkgc2V0Lg0KKyAqDQorICogaW46DQorICog
ICBzYitwX2RpcitlbnRyeTogaW5kaWNhdGVzIHRoZSBlbXB0eSBkZW50cnkgbG9jYXRpb24NCisg
KiAgIG51bV9lbnRyaWVzOiBzcGVjaWZpZXMgaG93IG1hbnkgZW1wdHkgZGVudHJpZXMgc2hvdWxk
IGJlIGluY2x1ZGVkLg0KKyAqIG91dDoNCisgKiAgIGVzOiBwb2ludGVyIG9mIGVtcHR5IGRlbnRy
eSBzZXQgb24gc3VjY2Vzcy4NCisgKiByZXR1cm46DQorICogICAwICA6IG9uIHN1Y2Nlc3MNCisg
KiAgID4wIDogdGhlIGRlbnRyaWVzIGFyZSBub3QgZW1wdHksIHRoZSByZXR1cm4gdmFsdWUgaXMg
dGhlIG51bWJlciBvZg0KKyAqICAgICAgICBkZW50cmllcyB0byBiZSBza2lwcGVkIGZvciB0aGUg
bmV4dCBsb29rdXAuDQorICogICA8MCA6IG9uIGZhaWx1cmUNCisgKi8NCitpbnQgZXhmYXRfZ2V0
X2VtcHR5X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQorCQlz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLA0KKwkJaW50
IGVudHJ5LCB1bnNpZ25lZCBpbnQgbnVtX2VudHJpZXMpDQorew0KKwlpbnQgcmV0Ow0KKw0KKwly
ZXQgPSBfX2V4ZmF0X2dldF9kZW50cnlfc2V0KGVzLCBzYiwgcF9kaXIsIGVudHJ5LCBudW1fZW50
cmllcyk7DQorCWlmIChyZXQgPCAwKQ0KKwkJcmV0dXJuIHJldDsNCisNCisJcmV0ID0gZXhmYXRf
dmFsaWRhdGVfZW1wdHlfZGVudHJ5X3NldChlcyk7DQorCWlmIChyZXQpDQorCQlleGZhdF9wdXRf
ZGVudHJ5X3NldChlcywgZmFsc2UpOw0KKw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCiBzdGF0aWMg
aW5saW5lIHZvaWQgZXhmYXRfcmVzZXRfZW1wdHlfaGludChzdHJ1Y3QgZXhmYXRfaGludF9mZW1w
ICpoaW50X2ZlbXApDQogew0KIAloaW50X2ZlbXAtPmVpZHggPSBFWEZBVF9ISU5UX05PTkU7DQpk
aWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBiL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCmlu
ZGV4IDgwMGFlYTI5NDNlMi4uNWE1YTRmZDNjYmVhIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZXhm
YXRfZnMuaA0KKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KQEAgLTUwMSw2ICs1MDEsOSBAQCBz
dHJ1Y3QgZXhmYXRfZGVudHJ5ICpleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChzdHJ1Y3QgZXhmYXRf
ZW50cnlfc2V0X2NhY2hlICplcywNCiBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1
Y3QgZXhmYXRfY2hhaW4gKnBfZGlyLCBpbnQgZW50cnksDQogCQl1bnNpZ25lZCBpbnQgbnVtX2Vu
dHJpZXMpOw0KK2ludCBleGZhdF9nZXRfZW1wdHlfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50
cnlfc2V0X2NhY2hlICplcywNCisJCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZh
dF9jaGFpbiAqcF9kaXIsIGludCBlbnRyeSwNCisJCXVuc2lnbmVkIGludCBudW1fZW50cmllcyk7
DQogaW50IGV4ZmF0X3B1dF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUg
KmVzLCBpbnQgc3luYyk7DQogaW50IGV4ZmF0X2NvdW50X2Rpcl9lbnRyaWVzKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIpOw0KIA0KLS0gDQoyLjM0LjEN
Cg0K


Return-Path: <linux-fsdevel+bounces-43216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60337A4F7D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 08:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A232E3AC95A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB61C8632;
	Wed,  5 Mar 2025 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="E6i+x7yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61784D08;
	Wed,  5 Mar 2025 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159442; cv=fail; b=dZAfDPJLjr8jQsYqYH0IVVVWSM2/MNFBZ1+edL91a2cXw8UgtsbOy05KK29BNdWtapEU9OiwE/BeTZrPuP/ojauToHX+C8ToEuGyLJGmD+3kzSGCf0enzKzXUVqWxO7p6c0YCpqQ+J/pyS8mH8hd1AM8/UMmlmUx7GkcMVrAzJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159442; c=relaxed/simple;
	bh=N4tsaKJb0Oj0ugI31JywlxP4Q38wFUKay2m1qlbZa80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fgfz8fLLkJjnmEss8ntOuPKby/YU3J2ot74FkANQW2olxduXU3TUylOUT4ATzFxGo0RCGElSSlaQoUuaAgwLZkXi0Wd4l5kjzvGc/q5+LgEKfy8RPkidCzTejeu6OHIDgnq8g+Tduv1vl5bGgXKJixm6TCWq6b5dBdYXM5haIOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=E6i+x7yw; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWXlG1gu0ZFrqVu3kxdsdu4ypZ8NxSpFZ84ztFCVhnjPmKSYENGrqk607zo+1H4BLG+SvowWSuTqZKB2MWikGSgiaWh6zsZfKg94zHgGVWehQNjhZ1b2h9Cr0Wk38CyKgy7HkoSzoyWlH47BaAotHekteM+aNXtWPs61LX5wDHFhMSkEZh1I7Nx2kkcxOlKdT5zw7N3z9biIOtP9q5wZzLaZfbiwypK5K+NxIpywwEIgwxCXvHfzmiA1C/vbctNtgas982sfeOSWW3oxrneogE2IaJyg2NEEfh6OdGxiSCf/QKxugzfdhAN+qJ2vyhFLulO36/i3uArjr9+wqna1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4tsaKJb0Oj0ugI31JywlxP4Q38wFUKay2m1qlbZa80=;
 b=js9vRyxeHekfIWfEEdTayhdhu7Qahabgz57YtJrjNvhwiqSE2sRQrRtPJPwiJXZ7NCbfjLLZFsvcIGk+PHg6rOQx+FBjyFXD3bj4IxO1RqbT19Cjhj3cDakf12oyvN9+lr7hF2K0NmmJroKnUk2ILihbeCQJlI26YhI2FaxLnL/brC6YCFCL8JfHW7Axlphx5RC5eEr3jh2GTeOLI9Z6xyNHVKqZN1I8CQW7raNoOt83ByKzen6iGTUr+OdTa6xtw/H8pJU0rHV/KFSAwi38P1T+yydWKUCI82NrPzfMXMVkMmWPi9j5KSSnd9YLQ3CYQpZtyxoOVDmu9sczSBBoXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4tsaKJb0Oj0ugI31JywlxP4Q38wFUKay2m1qlbZa80=;
 b=E6i+x7ywDECvZZfXA3Cba/h+0PwccO4Spn2ekiGLc8yBkEuu319+Xi3i5lcx+zUa2HcbE61avh6sZ+7u+jOHYyQZg4ixRgbol00ikqJ5a4n7f3FG4AuBBlJlk3y/Ya38MmSH/iK2gRLm5nxGlMX7hQzGopGj/adFAkfiudoMJfmlIscqmVLAyKO16Jb+gY/fRELvF7boZNHWy5bUSIQDr5iD0lk6xEhrdo7vxz9ejx2gnbfetK0ia0WDwkxLFIgbwlyRcvfX/1bpwPaqD9onPCOOunAaVV35UyH0+PmIPKzYXn78Fm9yrFgvGudYcA+rd10j/1XXCMoejQn/xjbjug==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8742.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:20::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 07:23:55 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 07:23:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
CC: Sven Peter <sven@svenpeter.dev>, Theodore Ts'o <tytso@mit.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, "ernesto@corellium.com"
	<ernesto@corellium.com>
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Thread-Topic: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Thread-Index: AQHbjZ+NYa9MV5bGREaaqxHVliIiJA==
Date: Wed, 5 Mar 2025 07:23:55 +0000
Message-ID: <795A00D4-503C-4DCB-A84F-FACFB28FA159@live.com>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
 <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>
 <upqd7zp2cwg2nzfuc7spttzf44yr3ylkmti46d5udutme4cpgv@nbi3tpjsbx5e>
In-Reply-To: <upqd7zp2cwg2nzfuc7spttzf44yr3ylkmti46d5udutme4cpgv@nbi3tpjsbx5e>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB8742:EE_
x-ms-office365-filtering-correlation-id: 46cb4495-bc04-497e-3a58-08dd5bb6b013
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|8062599003|19110799003|15080799006|7092599003|10035399004|102099032|4302099013|13041999003|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXdacmxzTUp3Z1lhUFdEcE1hMmVPUTI0RXZhRDNsQTBFU2I0ZjNuUVhESkFk?=
 =?utf-8?B?azQweFhhYVFQUFNYbjB6THlCWFVBUTdkay9tYTVhQjBscjM2Ukdnc0Npam1J?=
 =?utf-8?B?aTdod0xCTHZJaVR2ZzZRNVdnd0JlRC9NZUlSSlFKcTZYUVk2d2g2K21CRmY0?=
 =?utf-8?B?eTFJT2ZnM0tKRGlrME1Ia3BNQ3ZTV1lOa2xTVURjQUpqYU1WcFNQMGF0ODhH?=
 =?utf-8?B?d0NTbUsrVmZXckxoS2swWjdKMStCVzV1bG9DZ1dUdlJBb0xIMUp0bHBMWWhh?=
 =?utf-8?B?aW5ZWmRjUnlMVi83WWtpWEVCT0ZJeXk4RkVveEdaMTZWc3hsRmxWQk1sbjJT?=
 =?utf-8?B?UXYzSnRCVkc1UTByOTA3Sm90V1JGa2xGbkM3RVJjaXg1VEJZbnNjWVkvUHdF?=
 =?utf-8?B?MUdKV3BxQ3FQUUQ0TzJ4R2NVMjJzUXRuU1J3VkMrNHpJazIzWWhzYUp4RUNG?=
 =?utf-8?B?NUtvb2FydjJXOUwvRHVQWDB4eGVicU44ZkR4cU5QSDhxK1hGTmVPWU1JSmZJ?=
 =?utf-8?B?V0ZQOTk3b2xmYjdEVWU5bEc0eHhOVllkTWdrV2dTcEIwNUUzWVZEZjVrSEpt?=
 =?utf-8?B?dzBlcmtLUnI2QWpVSlp4emFWVUQ0RTdGaThBdDE0aU5FbWJwd205RGYrc0lP?=
 =?utf-8?B?Yjl4SHdENDJLVkVHZkVoNExvbFI4V2ZROUlpbDlFUnBxV0NyenVuNVhvS1F2?=
 =?utf-8?B?bTN3SEhNcDBkVzgxYmIwcGdQVW5yU0IxQ0hEdjBuY3o3OGRHdGJhQmh4ZWR6?=
 =?utf-8?B?NmV5UUE3aW1QZS9qR1RkVjF2bnBGMU9mQXFQQzNxaTBXdmJ4eEZWVEJXM1VY?=
 =?utf-8?B?a1ZrWDJNNmg0czYzeXM4UTBzR2Z3VWF3S1ZRK0xkTmYycm9SbXdnRHNhR29U?=
 =?utf-8?B?TWJnd2pXODgzdUJCRm15T3JJSGR2VkFIbWorRUpqRG9EWDFDVEg5cUdwbWZo?=
 =?utf-8?B?elJTT242Wk0rNjE5azNFVFJwck51UnNWQ2RoRUFLNHdEbi9rb2VBcTA1Z1Fn?=
 =?utf-8?B?L0swMEpnOE5pNG9DZmJldS9heXlUUG9JSFVYY2VnUTNqV3orSEVsUDNvWFZv?=
 =?utf-8?B?WVJRQU9BN1htdGRLWEwwM3VCTk5lZDJpWkVxMG12d21DbWhmNzVNQlNDeWpM?=
 =?utf-8?B?aDgzTnE0RkFYK1g4aFMydUUwR2t1di9Rdy9TNEo0dmhBZEMxMVZXZi9KWXZI?=
 =?utf-8?B?RVpxZ1ZXdmxKV0FyVkc1RGZObXJPbSs4UENDbkRqWTVkY1dESlAvY3pmT2tT?=
 =?utf-8?B?ejJuNjJDU0M3elFrc3l3OE93VnVXV3FhcjN5Rkg1VHFNQUlxeER5ODdyZG1U?=
 =?utf-8?B?M3RIdklLK0tZQzVVdTYwN0FuRmRhd01ETXRhT2hKejh2YkkvNTE3dnJzRHRl?=
 =?utf-8?B?ekU4WmsrTWx0MEo5YzFJbys3SEg0ZEt5RXFtQUFRMUFZc0ZENEdlQlo3bGZL?=
 =?utf-8?B?YjVSc1YvYWo0N20zQjdybUYzcVZiT3MrUU5HVEs4QmtKM2ZTR3pTd1Z4enpD?=
 =?utf-8?B?NWg3R21WSys0d3RUbzNtYUJPaWtwMmRGV1dlVkc3REt3SG1ndVN6TDl2bmh6?=
 =?utf-8?B?aCtDczJhbXA0WUJTVnVwTTVuUk84TGU2NTRZcUNxZVl1ckNFM2xPK0NTRVJT?=
 =?utf-8?B?aGFGVGVMRWxGdGt1TVdCNm9ITmVra2c9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekErdnZCQ0FLY3hOMXp3SkQyaHNseTFQYjNDOFduWEY1OGdjb2tra0dDWGI2?=
 =?utf-8?B?M0dHaXZrZndBZ2ZwbVR5U2s5TDdxdGxyMW53YUhadSs4Y0YyZUZVam9EWTBn?=
 =?utf-8?B?aCtrUnBLNGFOVlpmSHBHSG4vMEtwYVhNV2dNYVpSR3dCNGlvOG9nUjdSVVBw?=
 =?utf-8?B?Y2o2S1gzcHVpWVczbEcxWVlYU2F0eStkMEN4SEk0dXVQTjVTQmpkT28yZG5Q?=
 =?utf-8?B?ZjVDVC80ME00aWhBam1tUGZJK2o0akhUSDc5L3ZaV3Y2cTlsT2xYdUJ4bHRm?=
 =?utf-8?B?bWJKNHlwWmVVTm00TXg4cHBDazJLUlhSRy9BMVlzNHJvdnZvL0w3azFHUTIx?=
 =?utf-8?B?anpIQXl0SEF5bWV6bUZ5azFHd3ZmeHJwWUNTQWN2MWpTb21sRmtYNlR3ZTV3?=
 =?utf-8?B?RDUxdHVraUxYTHhFUjRjZWt2VFBQdE1iWXM3RHFwNkwxNTJrT1F3MjRiQ2p6?=
 =?utf-8?B?b3pOd1R2ZFBCemtZK3BNeHJ3aittZ3VmN0wrUUt5R0t6d3B4Z1lhckhZRThW?=
 =?utf-8?B?YWR4QXlwK1hZOExnTUdMNnJuaUpOaHdZTDVORXV1NjhZcHhnazhVSEZ1OUdN?=
 =?utf-8?B?bW83MjBCdlFaSEwyeFoyWVVvYUFRSjI0clZ6V09CNkU1UTNPdFdXeDZQcU1h?=
 =?utf-8?B?SmUxTDZSNG41SDQ0NXkyd2F4eHVIMVRLVlhnUVFRV1VIU0pkQ1ZIZXNvaHdJ?=
 =?utf-8?B?YXRaYVZWTXVCUVdsa0x4Q0NwN0lObktnTUJaazZKMWo2QUw2dVVCNENjQzZV?=
 =?utf-8?B?TlBHdjc1a1dTVDh1YnV4a0d0QXJTU1h2M08rS3Y1bDdjMitGZ21zOWlNRkI5?=
 =?utf-8?B?L1hFcTIvbjF4U1JhWVBXbGhNMUpYcHZ1MUZYZk1OaFZQYnliRWJZbVg1L2FE?=
 =?utf-8?B?RnFaakxIRFJSVTFNWUh3N0RCWXVZOVlMNjJWS0VkNWNUQVhUME5PVkt3Qkc1?=
 =?utf-8?B?Mi9xMXdQT2k5UUN0WnAwVDR4NDNJUkdJMDRuWkRSRzU0SkdFa3NRN3dwUnRp?=
 =?utf-8?B?Mld1NjJxVCtGMlJua3FQbTJaQ0EvSEkwMUpacDdzc3gyOFVYeExvRWNMc3hY?=
 =?utf-8?B?Sms5ZHRiclpHM2JVL210cmw2YkhjZk1SNlE1ZEJSSlJHNzVFUm5QUlRvY2cv?=
 =?utf-8?B?L01nSVJmemhJNkpMOXEvVjJjV1N3L29pZStDNjVmQVhVdWc3SzBBL2ZqcGRT?=
 =?utf-8?B?QSthWm1QWnJaZlBOWExReE1KeWVVVHJUMnFIQ3ljRTZubWc4b2lUc0RNK29Y?=
 =?utf-8?B?cGRKeWVYdHhSOFdyc2paY2Y0TDkzamZPL2w1T1BtdWNaUmZzY0loYlhtR2Ju?=
 =?utf-8?B?dHIzMUR6TVhmK1E1M3MvRWhkNFJKZHoyN0ZNaTlrVkd2OUpkc2dqMmc0YU1t?=
 =?utf-8?B?UHpCYm5VWE1NRDZWSUduaGxpL2F4QjJrOVBMSUs5NS9SQ01tbkNkUTRFMTJC?=
 =?utf-8?B?VUp4VlRNVkNreHNDUWs3SEcwVnVLZVBjUmkxQ2FoSzFuZzEvaDdYVjd3d3oy?=
 =?utf-8?B?dExBWnhvaDd3OW5WaHFXRGxITU8vSzFEVVoxaWgyRVdYNmh6Z05uVmJyOTNl?=
 =?utf-8?B?blZ5SFBuZFFHbWFTWjQ1Y0lHRks4bWdsK0NSd0RvMU1BSUsydlAvRkNabWRF?=
 =?utf-8?B?MnVmK1FpOEovYzFYNGlKYmY3Mzg5eEEwSk9kWkR2L0Q3S0FsZFNidmp3dkV6?=
 =?utf-8?B?NUFwQWlybjQ4aEp6Y2NOc1VINVYvT2NlVmtVczUxUTgvbm05c1dMbWpDbjVF?=
 =?utf-8?Q?dHNLRqKGlngAqDH54fo1HYe76SRu6CuCuzWkicp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE9F94BF5A7491448F7B79BCD4C08771@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cb4495-bc04-497e-3a58-08dd5bb6b013
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 07:23:55.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8742

DQpIaQ0KDQpDY2luZyBFcm5lc3RvDQoNCj4+PiBMYXRlbHksIEkgaGF2ZSBiZWVuIHRoaW5raW5n
IGEgbG90IGFib3V0IHRoZSBsYWNrIG9mIEFQRlMgc3VwcG9ydCBvbg0KPj4+IExpbnV4LiBJIHdh
cyB3b25kZXJpbmcgd2hhdCBJIGNvdWxkIGRvIGFib3V0IHRoYXQuIEFQRlMgc3VwcG9ydCBpcyBu
b3QgDQo+Pj4gaW4tdHJlZSwgYnV0IHRoZXJlIGlzIGEgcHJvcHJpZXRhcnkgbW9kdWxlIHNvbGQg
YnkgUGFyYWdvbiBzb2Z0d2FyZSBbMF0uDQo+Pj4gT2J2aW91c2x5LCB0aGlzIGNvdWxkIG5vdCBi
ZSB1c2VkIGluLXRyZWUuIEhvd2V2ZXIsIHRoZXJlIGlzIGFsc28gYW4gDQo+Pj4gb3BlbiBzb3Vy
Y2UgZHJpdmVyIHRoYXQsIGZyb20gd2hhdCBJIGNhbiB0ZWxsLCB3YXMgb25jZSBwbGFubmVkIHRv
IGJlIA0KPj4+IHVwc3RyZWFtZWQgWzFdIHdpdGggYXNzb2NpYXRlZCBmaWxlc3lzdGVtIHByb2dz
IFsyXS4gSSB0aGluayBJIHdvdWxkIA0KPj4+IGJhc2UgbW9zdCBvZiBteSB3b3JrIG9mZiBvZiB0
aGUgZXhpc3RpbmcgRk9TUyB0cmVlLg0KPj4+IA0KPj4+IFRoZSBiaWdnZXN0IGJhcnJpZXIgSSBz
ZWUgY3VycmVudGx5IGlzIHRoZSBkcml2ZXIncyB1c2Ugb2YgYnVmZmVyaGVhZHMuDQo+Pj4gSSBy
ZWFsaXplIHRoYXQgdGhlcmUgaGFzIGJlZW4gYSBsb3Qgb2Ygd29yayB0byBtb3ZlIGV4aXN0aW5n
IGZpbGVzeXN0ZW0NCj4+PiBpbXBsZW1lbnRhdGlvbnMgdG8gaW9tYXAvZm9saW9zLCBhbmQgYWRk
aW5nIGEgZmlsZXN5c3RlbSB0aGF0IHVzZXMNCj4+PiBidWZmZXJoZWFkcyB3b3VsZCBiZSBhbnRp
dGhldGljYWwgdG8gdGhlIHB1cnBvc2Ugb2YgdGhhdCBlZmZvcnQuDQo+Pj4gQWRkaXRpb25hbGx5
LCB0aGVyZSBpcyBhIGxvdCBvZiBpZm5kZWZzL0MgcHJlcHJvY2Vzc29yIG1hZ2ljIGxpdHRlcmVk
DQo+Pj4gdGhyb3VnaG91dCB0aGUgY29kZWJhc2UgdGhhdCBmaXhlcyBmdW5jdGlvbmFsaXR5IHdp
dGggdmFyaW91cyBkaWZmZXJlbnQNCj4+PiB2ZXJzaW9ucyBvZiBMaW51eC4gDQo+Pj4gDQo+Pj4g
VGhlIGZpcnN0IHN0ZXAgd291bGQgYmUgdG8gbW92ZSBhd2F5IGZyb20gYnVmZmVyaGVhZHMgYW5k
IHRoZQ0KPj4+IHZlcnNpb25pbmcuIEkgcGxhbiB0byBzdGFydCBteSB3b3JrIGluIHRoZSBuZXh0
IGZldyB3ZWVrcywgYW5kIGhvcGUgdG8NCj4+PiBoYXZlIGEgd29ya2luZyBkcml2ZXIgdG8gc3Vi
bWl0IHRvIHN0YWdpbmcgYnkgdGhlIGVuZCBvZiBKdW5lLiBGcm9tDQo+Pj4gdGhlcmUsIEkgd2ls
bCB3b3JrIHRvIGhhdmUgaXQgbWVldCBtb3JlIGtlcm5lbCBzdGFuZGFyZHMgYW5kIGhvcGVmdWxs
eQ0KPj4+IG1vdmUgaW50byBmcy8gYnkgdGhlIGVuZCBvZiB0aGUgeWVhci4NCj4+PiANCj4+PiBC
ZWZvcmUgSSBzdGFydGVkLCBJIHdhcyB3b25kZXJpbmcgaWYgYW55b25lIGhhZCBhbnkgdGhvdWdo
dHMuIEkgYW0gb3Blbg0KPj4+IHRvIGZlZWRiYWNrLiBJZiB5b3UgdGhpbmsgdGhpcyBpcyBhIGJh
ZCBpZGVhLCBsZXQgbWUga25vdy4gSSBhbSB2ZXJ5DQo+Pj4gcGFzc2lvbmF0ZSBhYm91dCB0aGUg
QXNhaGkgTGludXggcHJvamVjdC4gSSB0aGluayB0aGlzIHdvdWxkIGJlIGEgZ29vZA0KPj4+IHdh
eSB0byBpbmRpcmVjdGx5IGdpdmUgYmFjayBhbmQgY29udHJpYnV0ZSB0byB0aGUgcHJvamVjdC4g
V2hpbGUgSQ0KPj4+IHJlY29nbml6ZSB0aGF0IGl0IGlzIG5vdCBvbmUgb2YgQXNhaGkncyBwcm9q
ZWN0IGdvYWxzICh0aG9zZSBiZWluZw0KPj4+IG1vc3RseSBoYXJkd2FyZSBzdXBwb3J0KSwgSSBh
bSBjb25maWRlbnQgbWFueSB1c2VycyB3b3VsZCBmaW5kIGl0DQo+Pj4gaGVscGZ1bC4gSSBzdXJl
IHdvdWxkLg0KDQpUaGlzIGRyaXZlciB0Ymggd2lsbCBub3Qg4oCYcmVhbGx54oCZIGJlIGhlbHBm
dWwgYXMgZmFyIGFzIFQyIE1hY3MgYXJlIGNvbmNlcm5lZC4NCg0KT24gdGhlc2UgTWFjcywgdGhl
IFQyIFNlY3VyaXR5IENoaXAgZW5jcnlwdHMgYWxsIHRoZSBBUEZTIHBhcnRpdGlvbnMgb24gdGhl
IGludGVybmFsIFNTRCwNCmFuZCB0aGUga2V5IGlzIGluIHRoZSBUMiBDaGlwLiBFdmVuIHByb3By
aWV0YXJ5IEFQRlMgZHJpdmVycyBjYW5ub3QgcmVhZCB0aGVzZSBwYXJ0aXRpb25zLg0KSSBkdW5u
byBob3cgaXQgd29ya3MgaW4gQXBwbGUgU2lsaWNvbiBNYWNzLg0KDQpPbmUgcHJhY3RpY2FsIHVz
ZSB0aGF0IHdlIGFjdHVhbGx5IGRvIGhhdmUgd2l0aCB0aGlzIGRyaXZlciBpcyB0aGF0IHRoZSBy
ZWNvdmVyeSBwYXJ0aXRpb24gb2YNCm1hY09TIGlzIHN0aWxsIHVuZW5jcnlwdGVkLiBOb3cgYnJj
bWZtYWMgZHJpdmVyIG9uIExpbnV4IG5lZWRzIHdpZmkgZmlybXdhcmUgdG8gd29yayB3aGljaA0K
b24gdGhlc2UgaXMgb2J0YWluZWQgZnJvbSBtYWNPUy4gV2UgbW91bnQgdGhlIG1hY09TIFJlY292
ZXJ5IHBhcnRpdGlvbiBhbmQgdXNlIGEgaGVscGVyDQpzY3JpcHQgWzFdIHRvIGdldCB0aGUgZmly
bXdhcmUuDQoNClsxXSBodHRwczovL3dpa2kudDJsaW51eC5vcmcvZ3VpZGVzL3dpZmktYmx1ZXRv
b3RoLyNzZXR0aW5nLXVwDQoNCj4+IA0KPj4gQWdyZWVkLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGhl
bHBmdWwgZm9yIG1hbnkgcGVvcGxlIChlc3BlY2lhbGx5IHRob3NlDQo+PiB3aG8gc3RpbGwgcmVn
dWxhcmx5IGR1YWwgYm9vdCBiZXR3ZWVuIG1hY09TIGFuZCBMaW51eCkgdG8gaGF2ZSBhIHdvcmtp
bmcNCj4+IEFQRlMgZHJpdmVyIHVwc3RyZWFtLg0KPj4gVGhpcyBtYXkgYWxzbyBiZSB1c2VmdWwg
b25jZSB3ZSBmdWxseSBicmluZyB1cCB0aGUgU2VjdXJlIEVuY2xhdmUgYW5kIG5lZWQNCj4+IHRv
IHJlYWQvd3JpdGUgdG8gYXQgbGVhc3QgYSBzaW5nbGUgZmlsZSBvbiB0aGUgeEFSVCBwYXJ0aXRp
b24gd2hpY2ggaGFzDQo+PiB0byBiZSBBUEZTIGJlY2F1c2UgaXQncyBzaGFyZWQgYmV0d2VlbiBh
bGwgb3BlcmF0aW5nIHN5c3RlbXMgcnVubmluZyBvbg0KPj4gYSBzaW5nbGUgbWFjaGluZS4NCj4+
IA0KPj4gDQo+PiBJdCBsb29rcyBsaWtlIHRoZXJlJ3Mgc3RpbGwgcmVjZW50IGFjdGl2aXR5IG9u
IHRoYXQgbGludXgtYXBmcyBnaXRodWINCj4+IHJlcG9zaXRvcnkuIEhhdmUgeW91IHJlYWNoZWQg
b3V0IHRvIHRoZSBwZW9wbGUgd29ya2luZyBvbiBpdCB0byBzZWUNCj4+IHdoYXQgdGhlaXIgcGxh
bnMgZm9yIHVwc3RyZWFtaW5nIGFuZC9vciBmdXR1cmUgd29yayBhcmU/DQo+IA0KPiBJIGRpZCBh
c2sgdGhlIHVwc3RyZWFtIG1haW50YWluZXIgYW5kIGhlIHNhaWQgaGUgZGlkIG5vdCBzZWUgaXQN
Cj4gaGFwcGVuaW5nLiBIZSBzcGVjaWZpY2FsbHkgbWVudGlvbmVkIHRoZSB1c2Ugb2YgYnVmZmVy
aGVhZHMgYXMgYSBiYXJyaWVyDQo+IHRvIG1haW5saW5lIG1lcmdpbmcsIGJ1dCBJIGdldCB0aGUg
c2Vuc2UgdGhhdCBoZSBkb2VzIG5vdCBoYXZlIHRoZQ0KPiB0aW1lL2Rlc2lyZSB0byBjb21taXQg
dG8gdXBzdHJlYW1pbmcgaXQuIFswXQ0KPiANCj4gSSBkaWQgaGF2ZSBhIHF1ZXN0aW9uL2NvbmNl
cm4gb3ZlciB0aGUgaW5jbHVzaW9uIG9mIHRoZSBMWkZTRS9MWlZOIFsxXQ0KPiBjb21wcmVzc2lv
biBsaWJyYXJ5IGluY2x1ZGVkIGluIHRoZSBtb2R1bGUuIEl0IGlzIEJTRDMgbGljZW5zZWQsIHdo
aWNoLA0KPiBhcyBmYXIgYXMgSSBrbm93IGlzIEdQTC1jb21wYXRpYmxlLCBidXQgd2hhdCBpcyB0
aGUga2VybmVsJ3MgcG9saWN5IG9uDQo+IGV4dGVybmFsIGFsZ29yaXRobXMgYmVpbmcgaW5jbHVk
ZWQ/IEl0IHdhcyBvcmlnaW5hbGx5IGRldmVsb3BlZCBieSBBcHBsZQ0KPiBhbmQgYXMgZmFyIGFz
IEkgY2FuIHRlbGwgaXMgcHJldHR5IG5lY2Vzc2FyeSB0byByZWFkIChhbmQgd3JpdGUpDQo+IGNv
bXByZXNzZWQgZmlsZXMgb24gQVBGUy4gQWxzbywgdGhlIGxpYnJhcnkgZG9lcyBwcm9kdWNlIGFu
IG9ianRvb2wNCj4gd2FybmluZy4NCg0KVGhlIG9yaWdpbmFsIGF1dGhvciB3YXMgY2xlYXIgYWJv
dXQgdGhpcy4gSXRzIGlzIGNvbXBhdGlibGUgd2l0aCBHUEw6DQoNCmh0dHBzOi8vZ2l0aHViLmNv
bS9saW51eC1hcGZzL2xpbnV4LWFwZnMtcncvaXNzdWVzLzY4I2lzc3VlY29tbWVudC0yMTU2NzMx
MTc4DQo+IA0KPiBUZWQsIGxvb3BpbmcgeW91IGluIGhlcmUsIHlvdXIgdGhvdWdodHM/DQoNCg==


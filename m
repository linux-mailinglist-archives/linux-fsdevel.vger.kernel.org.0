Return-Path: <linux-fsdevel+bounces-58287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C888B2BEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8671C7A2C70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A82773C2;
	Tue, 19 Aug 2025 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pbWeG64r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012053.outbound.protection.outlook.com [52.101.126.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD1257829;
	Tue, 19 Aug 2025 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598617; cv=fail; b=lIz3GAymf/JLTo+uwBnNGI7UB7m/4+pPgwlsjRW6YBCcH9eAj6mbeKjHX/+u2eg+cqOAd6pK0aLdrSfhfRFAlqDISyoNnNQbK6VSGqcfj5wUVh3bQT3k53DsDz+kdnVSt4tjhWdn5FKhyG63y/I7v+24Ip08evk+l6eBUm3WskA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598617; c=relaxed/simple;
	bh=GI0KmT3czsHe6PDfBviQ9k3LLvuUFWAYnsqiv1u9kCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQAnRMw8oMtFRK87bX702N9mfApyKJ3DP06M/qhaQayjatsJQtT3ckzXqS2d9vbdhiZQzVWVqp/Tn76iXrLkHZF+F5P0pzcxUKmDi/x8jd8X01vBo83b2Nde4aG0Ay7ssJKsUMxLuERt4/ymnjCj4nL/1NaTW0qmWB3ODVM5qB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pbWeG64r; arc=fail smtp.client-ip=52.101.126.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1LXzmxn+TOL8JzCovG+Oa6n5dhdTJjaQlCmROcn4COxkbiu7Gc8aGA8r+51ejIJHQ2bdO7cpuMRfvJ7lYnvsfkXWP0zUpAmt7dKu+hGlRincm4jt+oKwRkOt4CGMlNBjlfbmluYU2hzjU5jvX6vxeAetcBKjLMBR2ZQ0YSu/VVM7JPOrAsymbRB4YgifjSiLezhEhxP8z3fDN265OyiZ7SP+vgwl+2gmX2hPmC98D+6o//rSXsUX8JyD6CBeLZZGWS8MAQewhNkQYyRNPQkoj3tsazeUtUHKfAWHiTIL5/Kj9P5J9XUxOu8+P6egNAIPZNoPuPvLytISVYKh2SWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI0KmT3czsHe6PDfBviQ9k3LLvuUFWAYnsqiv1u9kCQ=;
 b=dPAm6imu9BczZNpc58tIiP8nao6wiWn5D1O+WEC3pIxlX9sX6aoiQhK1T2mtWwPUjscWAWcYoVW5WU35S88wr/hAWx60pabSq4H7pUyBHBwfw08X7wd4m738n/9qCvgtKjemMwDOaa9A35YYp26gPVOYWqUh+0O9Bn6HuZgu7AznaB+5n6VatBnQJUmxUgbXfEAVAhMKcaFveJQSQui5VP9hX3qANTjaS0QQFOjbtVu17ulF0O1jH4HB4IU51nggOn2DIW4GSXkThtQzZt3DrRwi9FrTmXISwZifZ++TE5LoLJfFpPo/qSsHJPAKL0hPsSqoCubHAMs4B9ioVNfFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI0KmT3czsHe6PDfBviQ9k3LLvuUFWAYnsqiv1u9kCQ=;
 b=pbWeG64rsnREuFSGdNgUFlJXOaB0LYLWvDMrTuyYZpnBnuhuA3e0ccYJbAcXZHzre+fbFLMUQvKoevRszp0YdrLy19nKXKZP25s/rRWNC6W9lGFM8WYHXbMKFqgcgto2QtS1dNMHYSw6f7Pj5FA7s1z76hnbBtdf7tOm7KcHaOh7Cw59ZeCfzyxQ+L1Kkwx03N8s0c5uX9euE7rvQ+T4QAx+ivq45i83itmPZlRTLo1lUYdIVUlnto+fEj4PnIYNy3SCELpjRj6Yvosb8nHlowLF35g4HAlfhhHqkw3Sgn4aQp02l14QH03ev1jo5LC7quIgLSgaqRPVhC0EFY7s6w==
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYSPR06MB6502.apcprd06.prod.outlook.com (2603:1096:400:481::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:16:51 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 10:16:51 +0000
From: =?utf-8?B?6LW16KW/6LaF?= <zhao.xichao@vivo.com>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>, "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>, "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exfat: drop redundant conversion to bool
Thread-Topic: [PATCH] exfat: drop redundant conversion to bool
Thread-Index: AQHcECJyzYSKU/nrkEmQI118AcGJUbRpLraAgACVx4A=
Date: Tue, 19 Aug 2025 10:16:51 +0000
Message-ID: <b2d3cc9e-86db-477e-afde-012a6f2fe493@vivo.com>
References: <20250818092815.556750-1-zhao.xichao@vivo.com>
 <PUZPR04MB6316487B10F6F2F62C0249598130A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To:
 <PUZPR04MB6316487B10F6F2F62C0249598130A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6020:EE_|TYSPR06MB6502:EE_
x-ms-office365-filtering-correlation-id: c02977c4-3a74-46d9-7983-08dddf0983d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|42112799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2FkUE5BMkdUTDZ3Z3RtSytYdnZLMEJoNUxBRnJWY2UyaXBsQUxnYno4a01r?=
 =?utf-8?B?YlBXdHBzTWQ5U0JpNkFQUFFkYVNtR014K2xmZDRLZ00zK1l4UE5UZW5kako3?=
 =?utf-8?B?RGFhQjBONUVRZ1pEd0s3SDJCaml0czlMNFVBa1hGNWszOHJrbUU0OWpCZmpF?=
 =?utf-8?B?aktSN1lpWGtDRE5nZDJwVVRIclZSSG5tZkVuVTdsc3A0MVliaXZrMlJibE1y?=
 =?utf-8?B?eW5ySDVDMklMUWhkVnovdXpvVUVBWVZDM2Q5TVQrMDJJclBWSFFoeE5wSG4x?=
 =?utf-8?B?T2VXZXdmYmlhdlBqdkd6SXZjZWgvTHNkc0pyWDBpdmpFWklKM0hLdmlKd2xm?=
 =?utf-8?B?VTRYT0Y2NzYyNmR2WGNiYkVhTEZxT2sxSWkyMmZIWGY0QjF6TURHdWEwS05P?=
 =?utf-8?B?Z0hwdUxKQ05xbGM3aGthN3VFUzIxbGN2YnYzZUhoS3c4Y2ZUcnNybWtpc1o4?=
 =?utf-8?B?MStsdmdLVHlqczRMTXRjV3UrSVVGcTJnL3lMVGpJU0trengyN1hvaUhTVHcv?=
 =?utf-8?B?alVmRWoweWtHc1lYTENrYTFZdlQ2Y2s1SDkyd0pPOTVldGg3cnpTWEVrRmNr?=
 =?utf-8?B?aDc3bTVERVo3WVEzQ0FLZERic3F1VHF3OUFhWTZOQnkyWU5FWE1hT3ZzTDdF?=
 =?utf-8?B?aXNaQUpsMy8yd1BrOHpPczdTTFpMdjlLVTlMNU16UmdHNHVIQWRNMDNZQkkz?=
 =?utf-8?B?TWRUTVVWQklJMzBQdmlRK2JBaWc2dTVOc2NMaXBhekxuVk1ORXRjdDFnTU9W?=
 =?utf-8?B?V0pTbnZnT3VUT0JuT3Z1bld0dnFVcWExWjdWdE9OdHVCS0RNVEpuam5lcFRK?=
 =?utf-8?B?cit2MmJDZ21sbVBEMThMbkszbFRGeDJDTmVwUWFKMjF4NXNtNTBUL2o4WmRm?=
 =?utf-8?B?MnR0TEt3bUlKOVZUUExFbHl2K0l3ZGRkcW1jN1JXcmo1YlNGTFl4NnVsMVVn?=
 =?utf-8?B?VjZ6b1llRm54bi9aUnRDUldyTXBLeFFicmRWYWpvZnV0NXV0b1EzNStvcUJl?=
 =?utf-8?B?YW8yRjMrOEV2WXZrNDVSU3JvY3VyZEFHVU00ZHBDaGhESFBURDJoQTJVdFpm?=
 =?utf-8?B?UnVvck1HQm1IVUFYWXp4bzRiS1dQMFptSU1lZ2tScGlLSDA5aC9JUmdqREpW?=
 =?utf-8?B?U0FJdVgxRTQ3YllyTHhNeVpnNCs0VHdhdVcySlVjNngvU2FWUEdtVkpIeGxQ?=
 =?utf-8?B?WHJoTlJ3eVpFTUFIZlZJaFVYZkdld3d6M1lBTGl5cTJGL1g4TFUvTkVzSjc2?=
 =?utf-8?B?V0JXenNxazRRUWxpOFhwZEQvL2pmcEFJUlY0T0pyUTJZSE5MZkpJeThRTFBx?=
 =?utf-8?B?cFdBZzB4QWlTVTVtanBGSkl4MFlpaWpQZTVNS2p5THMyOU1YVG9ReXBIdnJY?=
 =?utf-8?B?TnBJZE1wY3dxcDhJemRPREpDWk5TL2tSSW5FUUkxNjZodXBZaitLQTRjQ2Ft?=
 =?utf-8?B?c0trZ2NSbjV1MGtYVHZQajliZFBEUS8vZE5NSWNlZkVxVXJHbGhSZCt5WWVM?=
 =?utf-8?B?eWlZTW5SeDI0ejM0N0NxWlZpa1R6Y0RZSlNsY1F6T1p1ZC9OTE5kN1E1QW9E?=
 =?utf-8?B?L0ZXbkFWbHJucmZ5cWdJd1ZiL2tVclJiNlhlMmdXZHlkM2hqekpsYkE4NEFs?=
 =?utf-8?B?dEtNVHJGWWpVajZabHlpSU1zak5veFN5V05hRFpDVm1IOHJIdTRKTTBPdllE?=
 =?utf-8?B?ZVZsaHhLbkpmZ25MQWo3NkxENzY5dXA3Ri9zVDRENHNPZWthRG50NFdBcjQ0?=
 =?utf-8?B?MGxsbitpYWtSRlJEaGRwN1FKRElpSHFWRThGSFdMYmNaUWpTSHZnWlpQU3Vi?=
 =?utf-8?B?azk0dHR6aWdyMi9IOCtMWWFNK0NmWEIrUG9OSFpDdjUzRFRUUlZvWHVYOW9E?=
 =?utf-8?B?K1dRelpaQ3dPNE1LUGZsdWtJYkFXcU5PSDl4OHpCeHRFUFIwbkFWbXpwNDRz?=
 =?utf-8?B?ajBENlhBb3pPUEdUMHU0ZE5vTHZpZEYzbnBPZFAvcmZOOEpKVG5ITUJFMjZY?=
 =?utf-8?B?Vlo4TkExKzNBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUpkak5tVjVqak9DOXZRYXdGVjA1RmhwWU01QS9FdVRvdlRGMXF6ZjZBZDNq?=
 =?utf-8?B?S3A1NGRoMG5hYlVBbDcwcHkvUm5rem5vTTQrV2dsby9VL0lRQmZ6UyttMWxs?=
 =?utf-8?B?dVZCTXlXK3lPZ29GcU9HY0ZxQlNCUzhReUFuUTNucDFPR3J0Z0ZvekV5TkZw?=
 =?utf-8?B?VW1kc2FGYlNWbCtyNnZncVQrenpoK2JFREJxYTB5ZUdjNW5mOGRCT3lMeVl5?=
 =?utf-8?B?Y285c2N1T2U4MDFLOGV0cU5UZEtSUEFPY3BZYTNEKzNBU3VHTitKWTd6b2xl?=
 =?utf-8?B?ZWdlb3M0VHpoY2Y3OGRNbGFGQ29WbklSYWc4SGdoWUszZDRDcDkxaTZwdmFk?=
 =?utf-8?B?WlF3ZnFSa0RNWGhiNjlPQWxUWXFEaWN0MExnQ3RhV3JRMGxkWXk0UmRsYXFa?=
 =?utf-8?B?Q2FDUk5yVU1oc1ZNRHBPNHRsR3lBQk0xNHhoN29pTlluVUdOczVyOFAxN3Fa?=
 =?utf-8?B?WGsrbnIzTVVNQ2JodFhodkZTTmtrZGtzQmE3aGFhbFh6S1ZIQ3R4WWVEY0kr?=
 =?utf-8?B?NTVTWmtMYmVPS3JJdVdxS2ZJb0RMcEtZWGVPSWcyNXFCb2xKTjhZM2t3NDJX?=
 =?utf-8?B?ZnlldEYzNnVNMWpZYTlUdllHa1pENjg3eTBvSlQ3UGd1TGpsclFaWHg5WWkz?=
 =?utf-8?B?TU02ZW12SE5nd0xuWVZ4VWREVWJYR2JxVHJTdDRYUURHN1A3R2FMS2FaK3dM?=
 =?utf-8?B?SVlJY2JVdnZlRlpFVmZDVVVtRERicUl3eFRNNm5qTEphK3E1QmpCV2E2TGpO?=
 =?utf-8?B?RFl5Nkc3UFRKK1poL2t5RDFiNmRXYlk2dWdLN3d3THBPbmR2clg1OHMrb1ZI?=
 =?utf-8?B?d3lCL0NSVHBFRVlQWHQ5YjZsM0p0eVRqMEdwUnZBS2RTZzZWRWJjOTJpSmZT?=
 =?utf-8?B?TmFxbEx5SjJCcktyZ0IzQVlFSzM0N0ZSTzl6MGFjWG16RzgxMENEdy9pd0RP?=
 =?utf-8?B?Ti9HOHoxUmRhMnlsWjJjNE1zM2hGSkhJUHJuazErNk1RTDlHeGFmNk11UDds?=
 =?utf-8?B?Q1o3cC9jUjNFL05tckpLVlNCVFBXVEVKOU5sTy93aXFTN0NjTW81MGZMeFVQ?=
 =?utf-8?B?VkZNZXVQZTdSSlVNK1Q4d0MxVXRoS3NTRjY1emZpVGdVMVdtRmtjZXorN3I5?=
 =?utf-8?B?S3dzZmttUlFuSWtxY3FqWGY2MkpaVG9oY3F4UzhSSUEzOVNySXNzTGhYd2RP?=
 =?utf-8?B?c09aRXFtcVFwcWxPZURvVUVNM3VYQWZiazFZdTVmTnd6T3Z2eGdBTUlXRUhX?=
 =?utf-8?B?RG0xcWVHaWFxeFVXNGxrcEdwRUxnMEg4T3ZvU3ZsMTlFOWRic25kRDZZak11?=
 =?utf-8?B?Z0hpRVBqbXZPNTNCbUdncEw2OWp0Vnh2eHZjNHgvZnNhKzlCdlpvWGcza0Rs?=
 =?utf-8?B?RjE5dFQzTGVyZzU3dmxBU2FvVDlNNmNuc3M0WlJMeEtyNnVCTno5ciswcTFL?=
 =?utf-8?B?ZVZYNXl1QW1tU3o2UjFlZVNub1N4b1o4eVdPVXFhTUN6Y3NXbGlRZFRtRkov?=
 =?utf-8?B?b3A5WTZXdnJneGh0bG5BT1lBaVpkZElldmxVdGYxbmE1cTdaOEVLUWhKcVBs?=
 =?utf-8?B?R3cvTEpNNlI4cjJpMERNYUR0b3VDQll2RTVpK05aUmtibHg1Q0hBWWhkWE9j?=
 =?utf-8?B?eGNGKzVqTytJcWtGOUFWQmQ1UDJ6S2NqemRGR0QyR25VM2JUWTZaeTZCbkty?=
 =?utf-8?B?TlVhWlczZDNaaXVBdUQvN0oySmpqakZJR0FYRlZzR1FrNXhDN3JneGNqSEtN?=
 =?utf-8?B?S05Kdm1LQXlPNFJMUktLM0JaYlcwS3NXVG5MNWV4TlJreTVTa3p2Z2ZoM0xF?=
 =?utf-8?B?bE5qek4vaE5Eb09MYytER2xVUTM4S1MxT0R6aTJtTmVtTXExQ2ZjSFlZOUxn?=
 =?utf-8?B?K2g5cEV2WStGZ2l6TGREeDdRV3lpUEphcWNmckxWUFJTcDdxTG9JYXE2Z2cz?=
 =?utf-8?B?eDBGTDlxUzZJRGQyRXo2VWNRUFQyT0FvUFJJUXVIR1FxL2F4cGNHMVIvRFdP?=
 =?utf-8?B?VnpYWXJSODM2SFhPMDZBYUdvOW5LdU9ZQnMrUmpacEZNUU9uSlp3dTJMbFMy?=
 =?utf-8?B?blBJU2NHTmkzdUFSOGJLem5sVkJTMktSWXJOMklCK21tTWR6S0tlWjU1MWpz?=
 =?utf-8?Q?5IE4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A969E75445F70A4CB24C2801F393971E@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02977c4-3a74-46d9-7983-08dddf0983d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:16:51.6100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTNqrr+Qbgu7upi3nL4WMoawt/ffCaxU4VbcKmz7FbmMo7HwYLsKYYwk2Hqk6UmjLXRUAN/7dkvKUFuJuLvVAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6502

DQo+PiBUaGUgcmVzdWx0IG9mIGludGVnZXIgY29tcGFyaXNvbiBhbHJlYWR5IGV2YWx1YXRlcyB0
byBib29sLiBObyBuZWVkIGZvcg0KPj4gZXhwbGljaXQgY29udmVyc2lvbi4NCj4+DQo+PiBObyBm
dW5jdGlvbmFsIGltcGFjdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBYaWNoYW8gWmhhbyA8emhh
by54aWNoYW9Adml2by5jb20+DQo+PiAtLS0NCj4+ICAgZnMvZXhmYXQvaW5vZGUuYyB8IDIgKy0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQo+PiBp
bmRleCBjMTA4NDRlMWUxNmMuLmY5NTAxYzNhMzY2NiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2V4ZmF0
L2lub2RlLmMNCj4+ICsrKyBiL2ZzL2V4ZmF0L2lub2RlLmMNCj4+IEBAIC0yNSw3ICsyNSw3IEBA
IGludCBfX2V4ZmF0X3dyaXRlX2lub2RlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCBzeW5jKQ0K
Pj4gICAgICAgICAgc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGlub2RlLT5pX3NiOw0KPj4gICAg
ICAgICAgc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsNCj4+ICAgICAg
ICAgIHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSA9IEVYRkFUX0koaW5vZGUpOw0KPj4gLSAg
ICAgICBib29sIGlzX2RpciA9IChlaS0+dHlwZSA9PSBUWVBFX0RJUikgPyB0cnVlIDogZmFsc2U7
DQo+PiArICAgICAgIGJvb2wgaXNfZGlyID0gKGVpLT50eXBlID09IFRZUEVfRElSKTsNCj4+ICAg
ICAgICAgIHN0cnVjdCB0aW1lc3BlYzY0IHRzOw0KPj4NCj4+ICAgICAgICAgIGlmIChpbm9kZS0+
aV9pbm8gPT0gRVhGQVRfUk9PVF9JTk8pDQo+IFRoZSBmb2xsb3dpbmcgdHdvIGlmIHN0YXRlbWVu
dHMgYm90aCBjaGVjayB3aGV0aGVyIHRoZSBkaXJlY3RvcnkgaXMgdGhlIHJvb3QuDQo+IENhbiB3
ZSByZW1vdmUgdGhlIHNlY29uZCBpZiBzdGF0ZW1lbnQ/IEkgZG9uJ3Qga25vdyBpdHMgYmFja2dy
b3VuZC4NCj4NCj4gICAgICAgICAgaWYgKGlub2RlLT5pX2lubyA9PSBFWEZBVF9ST09UX0lOTykN
Cj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4NCj4gICAgICAgICAgaWYgKGlzX2RpciAm
JiBlaS0+ZGlyLmRpciA9PSBzYmktPnJvb3RfZGlyICYmIGVpLT5lbnRyeSA9PSAtMSkNCj4gICAg
ICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KSSBhZ3JlZSB3aXRoIHlvdXIgdmlldy4NCg0KQmVz
dCByZWdhcmRzLA0KDQo=


Return-Path: <linux-fsdevel+bounces-51666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733BAD9CBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F6C3B953A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCE2C15AC;
	Sat, 14 Jun 2025 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="qWH1+JcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915761BC3F
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749904999; cv=fail; b=p8ThN15RsRVNjXsTgdiRzzQwwqApf+vjSOYIpKobE6xcflTkgb3mH59SzkAWWnfAQFkDv1vr7yc0CFgybCxX1qun9BzbM89hEvuk3k3lFs+MfAdwde3v2ZlADXJUWIT+FhFCEmOx8vdy0cGxGRbX5PHg+bwgzHzvglIs+HGWKs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749904999; c=relaxed/simple;
	bh=2wEFBqa3TXPlVatWtrMeQh4vFH/pM5z9WxviWidJNHU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mLre1FRaBT6Q4TblzMvFQOFk+kz4TzElwDAJ0jZtpldlKKxWc44D/5e8GkooBb7zVS9gDl6mhA5sel8UtnmtxKYbVsF0Vp72cexDN6bpzUk1Xbqa+D6hVOeHe1YzxJUDtHe5KQUc/Iii21XxP4bz0yf9L02zoHHtVe9HSaJkvzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=qWH1+JcJ; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7Do1m3AUPpdI6ER/emYx/lPp+mgD6v2KWfZ62y7Rxqggv/A/bWhWM3gwy/Ca9MPnfE0Wvp/m3ygNniaawuiESx1Pu7AQVojXUBQ7b/RaKv/pAMxUhvcoTulc1vuKBB+cH9HtlMtzbq8CDCnhHX340yFm1BFMOFQ1VsxptFhIjFLd18E3LbQFWNndDTwBDiESmmEIONKkrHPk18kS7E7HAIusimNriCGTaz3lJG/Bb2Ie5i8CIoDEu/qTqj6V6Oyki9WRqoRVLYvg/yJmjv2NMFdM4B3s+g0QxP+ncmexcK4wJPpi3uQFrMoFo3kRt6fO/ilPRq8gPweo2TsR3Ts/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wEFBqa3TXPlVatWtrMeQh4vFH/pM5z9WxviWidJNHU=;
 b=TmHjLNm73Gk2Bxeg6nDT6RZOomLLBcF1LlY7a97jKGy8qwxOs/5c241PEE3nQl9wRL2vR7KBzlnLF8g613Mfda0zKKoi8afK7zlzQ5mXsWPtFSIeYGEAGkKPtr8EbA3UPtQ1WOQg6UrYHBe0eF1k0DcE5zCIIc0YOACqQXSEB2dC6aFG4ylSdkkWdJ3q0xGiGhyald2XDPi1YRIm4czClRJVVXULX3Qe36vl5k7/elRgl4PzeKbVygRnbjiWcn6b2sXOaskskVpuGmQMpsSmfL4g50wi2UpfFQVu6aSjjIUtA3HwvPN2qMVTbgTxKsMRtOO8KeNTRMEZ1D+iJitVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wEFBqa3TXPlVatWtrMeQh4vFH/pM5z9WxviWidJNHU=;
 b=qWH1+JcJiePB7hXQ0hT3iZheGZhkuU5CCMaDeHq4Wce0Ovxe/jvRMNoBtIbvwe6EWgqFDKbBzoo8sDNusEFxE+LXSjDRPNPX8Y5nac6PF9JMnKY8BuKlMbLDJSaZWsUrlFKuz/qSGJWvye8vO+7GTRUv8SmSWzGmW1KoYbuvY2FCNvZgRp/4rwggfwwVDAWpNRAO2ssdKSMAPYOPEAhaFQMvxzmiBpkgw06HtHkx5nGTyqgb41gOBW/OhH9HKb8k7UQb6kiyBW+hCp3VtK1TZ0zY1rXNRcYHn3s0A/+e/2ug09i4+BEqkZt5zDJMNG4B5PLOJTXvIJH0EkDKWqbLCA==
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com (2603:10a6:20b:16::28)
 by DB9PR07MB9651.eurprd07.prod.outlook.com (2603:10a6:10:2ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sat, 14 Jun
 2025 12:43:13 +0000
Received: from AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f]) by AM6PR07MB4549.eurprd07.prod.outlook.com
 ([fe80::67d6:5a88:7697:5e9f%6]) with mapi id 15.20.8813.024; Sat, 14 Jun 2025
 12:43:13 +0000
From: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v6] block: support mtd:<name> syntax for block devices
Thread-Topic: [PATCH v6] block: support mtd:<name> syntax for block devices
Thread-Index: AQHb05Mw2d+yowdH9USroxESr9J1DrQCrKKA
Date: Sat, 14 Jun 2025 12:43:13 +0000
Message-ID: <9aed755e3a24eb06928a6de1810fdf399989be0d.camel@nokia.com>
References: <202505282035.6vfhJHYl-lkp@intel.com>
	 <20250602075131.3042760-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20250602075131.3042760-1-joakim.tjernlund@infinera.com>
Accept-Language: en-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR07MB4549:EE_|DB9PR07MB9651:EE_
x-ms-office365-filtering-correlation-id: 7f5b61b8-af73-4004-ac4b-08ddab410726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGRaRVkyTU55Y1EzWldnY3liVzF4OTU4Z2dPM0FTL2ZpQi9QdmY5QVhRM1Bt?=
 =?utf-8?B?ZlUxNE45OGFnZnY2ckZCbzh0WHV4dVVZSkJXMXl4SHdFZU1PTEpvTzFDWFk0?=
 =?utf-8?B?Y0dqeGpUKzJMQ1BvZldVU0dhYUFuRFNIdGkyVXN5MG4rTXV3RExVSEZZemJT?=
 =?utf-8?B?ZGdkNTBCK0FMWlhaM29wQ0pRLzlhYy8ybGN3ai9Mc2FGaWp6NnNQYndSRWN1?=
 =?utf-8?B?SEVMWDhZdWlZOHJTV1pWSmR5WmQzRXBNckRQcEJDQSt1aGhWeDdDYjdEcVhj?=
 =?utf-8?B?ZkRWajRZd3hVODlQT3YzYmg0MTAzcWhlQ0FYWUwxWW9RREtUZmZ4bk9WK0k4?=
 =?utf-8?B?Q3B3bEo5aUFGY3hpUDE2SmNKOWV5NUl2bnlkT1dEcHg3bEpNYU41OXpHQkFV?=
 =?utf-8?B?QVU1VW5uR1RUV2pCOU9FMnhoNVdwTFh1WTlpK0RRZjVGWFRtUFZaUk5zejlU?=
 =?utf-8?B?VW54NW5rZTlmU2dEYUtJOWh5dFQ5N2Y0b0NGaHNKQWV2bjdSeVJyc0xsdXJI?=
 =?utf-8?B?NWp5a3ZTSW5tMnVxRHFsY0t4ZVdMczBydEdVcWx3SEt4K2R1cVFwYUFqOUo0?=
 =?utf-8?B?c2U2eTY3S2xSeDRZZjRsMk4zYXdpR0E2NUtLKzY1V25pcXpDRGdyZi90UVRx?=
 =?utf-8?B?VXhyeDlXY1FDbzlTZUVaQVkrdlkrVFJkaTY5VUxNdEhkY1gzMHpaUlFSODZv?=
 =?utf-8?B?a1FlY1BqZUlXQXF6R2JxL25NelRnYmsxRWtRc3dCSERNYnlOVTkzTzlENlJl?=
 =?utf-8?B?QlhHQjhSNDNXSENoZ25jTkgrbTduRklMcUZBRXlNVndYMEZXNjZJek9KMmtw?=
 =?utf-8?B?L0ZTQW5QOTMyMUhYdnNOeWMzc0toVktjK3JHb0EvdDZqWjgwK2szTHYrcGV1?=
 =?utf-8?B?czlMR1hYVmUzSUpHVkRYcGtaR2xwQUJ3K2xyMTBKZmRUbkdCSTZ2a3dnejdJ?=
 =?utf-8?B?M0tCLzBoaWp2L3dHZ3RSVjRsdERFNnhxTHdLcUVSTTdIVFFpVU82cDVqNnZR?=
 =?utf-8?B?alJYNDlPb0V0Z09naVlraCtDbDV1R3FSZWVySDF2cC9FVmdrMjA0WENLRUNI?=
 =?utf-8?B?bUpra3JRM2xnSkpnb3RuOURVeWhTTnlLZWJjRnZQOWtHZFk1MThWcGlqcVAr?=
 =?utf-8?B?UEt2Y3Bud1pyT2pIeHlJb09MMC9YOXM0K2NUVlMwRXBYRkl4clJjdE12MHY1?=
 =?utf-8?B?VFY5ejJTN1pKV1hxSUpvZVg5SzBLdk9XQXBSSVNNTENaSkVvMWFhayt2Mkdh?=
 =?utf-8?B?QTBIcDR4UnhpWFBFV2tDRWlpd3FTbWozQmMzd3lsMWpMZk16ODdMeTlULzl5?=
 =?utf-8?B?VU8yeXhVdng3VmxJVTYrdjQwVWVFbXpVT3lCcE92V0NSc1VIMEVja0p5THJs?=
 =?utf-8?B?Z3oyK1RtZHp4cktYVGwrdGZreEFnNDJmU1dpblZmcVZnNkVybE9XTEY0VnZO?=
 =?utf-8?B?S3k4OTFaMmNYS3BKdkl1dW94dXo1NkN4dDRxOEZnMDdXNFZ0ckxONUFmWWVN?=
 =?utf-8?B?WGNVQjNicUJ1ZFJtMHQ4YTU4VUhrU1hRU1AyODlwcld4ajFHNjAyNFc5VlRI?=
 =?utf-8?B?eVFTTkdsNEhaOThMNk1BTUJZUzBsWFhKYkR5VVdheWREVWw4TnZSdmFuMUV6?=
 =?utf-8?B?bkRTc1VQcnFiT0RMOFdITXNvQlhFWlQ4UGo1ZlFBcDN4cWlLeDlYZDFiazZ3?=
 =?utf-8?B?S0JzT0JwZ3VycGVtcnUxQWFLM0w0U0xGdDZwdTlhUEs0a2xNU3BtL1dXb3lU?=
 =?utf-8?B?VVJTOVg4RnR0ZVJsMDk1NE9aL0FDTC8vMTBUNmd2T2h3UkhYQnV6Zkp0RDZG?=
 =?utf-8?B?V2lnOWJKQ0tFZTVLSW8xaXFabnhuaUh6aGJxSWtlamNPeEVjRkUzQklwcWdn?=
 =?utf-8?B?WXNNc25SdC9ydkhIeHFERmNkUjVOUk9MdG5TNXJ0T2xDMS9VQlFVOHhDN1Jq?=
 =?utf-8?B?QXlHRGs1bzhyQzF4dGtuY1V2ZklzcFArazBtejQzM2lyaU1VZjQ2dnRYcEV5?=
 =?utf-8?B?cXdqckhwVEpnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR07MB4549.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTJMb3R3dVQvYTFGVU83TUUwUUUrY0swTC9tc2U3U0NyMUoveVlqMmlaU3ZK?=
 =?utf-8?B?NTZoVndxd1h5aVFUL0JwOFI1S21MUWZxQWVtTlF4dlo0SEdQR25zM1NhcGUz?=
 =?utf-8?B?eGR2TTFRV2s0M0VKTnhkSVpObmpuWkE5eTM5dGg2MHc4d1ZOdEtKdmZONms0?=
 =?utf-8?B?WnVvQU5JTDByOVlidGFrU0FUNHU2L29MVWVxMlBjQnVVdzhUb1h3MUVPYzh1?=
 =?utf-8?B?dXhsQTFvbTZFZFFvcnVtNE9mZEl1NTdQK1AraVdZbHA5N0lHdzJyZkhjM2lL?=
 =?utf-8?B?aUhaS2orZXI4TmhNK3JEc2ZxMVNwRjNRem5WWmFWdVZQeElpSi9LRHFVRWhM?=
 =?utf-8?B?L0FML2taa3RaQXVUc1V3SG1nTnNHc0NuSWdNbS9PcUxjaTNxcGJBR3pRcnd6?=
 =?utf-8?B?TDQ1Ykt2MmNWK0RmLytWSTZrYWc0WXczL2JSTHJIWEg2bjBEd3cwN0RRODhV?=
 =?utf-8?B?azVLRFRlbjhBaENQR0tiaW9Ha2NMVVRSZGxmK210bXJrVzBiSmJqY0h5MWxL?=
 =?utf-8?B?Mk5XbXk5REQ3Zk51dDdxQmRlVEcrb0tPS1J0d2MvQnRLTDMvS01HYkJYbDg2?=
 =?utf-8?B?QzNGVXhsTzBKbkRmdkpBUlVaUjI3YVdaSGhDWW9SNDM1bjZYNEZ5SnZpbmlm?=
 =?utf-8?B?S0RBVk9TZmptMi94T3hMMGFhenFFTmc2VTJGTzloRVdmakE3RFBWZUZXaS8v?=
 =?utf-8?B?cUt5a1JvMTJqQXZONUx5SDY2b3ZCdmRRRXJwTDZicTVlMWpYUVN3YkYxbHBj?=
 =?utf-8?B?cHFyRFI5T2ZscjhGTno1bElpRTJMajJKMGk1RnAwNFFYc2lnSFdWOGFpMXJk?=
 =?utf-8?B?SHpZUEhvaUpmd2F0N2Q1RGZwelRudmxnYkJ3NzhQNFFKdi8wSnhkcWNRQTJE?=
 =?utf-8?B?cnFuNGppWDRMRjdGL1QrZkpEbUMxdjQvR0xOK3EzaXREMnN2S0R2OExSK3JT?=
 =?utf-8?B?bzFJSW81ZnJJYWhrMmpNTkFwRXJ5Mk5iUUNpYUR2RlVXcUhJV0hEbzFCcVlZ?=
 =?utf-8?B?SUhGcHlXTEllb0lCSGx0YXlRNWVwZDIxcXR2MGlvbk9IUkRpeXZLTEw3UVo4?=
 =?utf-8?B?QkkzeURHVk1VU3QranVZcHN4U2hWeTFUWksvdW9lRHJjdVA5WmxKL3o1N1FN?=
 =?utf-8?B?bjFYUCtEcUNMeVk1T1JINElja3Y5TFp6U0hGMk0xVkRrVEhVUEVoWmFPeEIz?=
 =?utf-8?B?cEJBb1JLNmhpOHRZUktJR0FmQmtBVG1VdFk1T3dBOXFycGpXeGxEN2FLT3Zx?=
 =?utf-8?B?U0s1bEl6STM5ekhhOHM4VWxubmVjbFJVUHVZQVJ4WFR1MTZsSTBETVFDN2wz?=
 =?utf-8?B?ckM5U3lnSzVka2hqSmUyZWc1b1Jmd2lTTWw5aHpKczFQME5YMWdlRFJNZTlH?=
 =?utf-8?B?YXZXS3piM2pwMDgwWDZuQ1d3OHpuVFVDRGs5SXlsMUYxQm05ODhzUTBwTzlD?=
 =?utf-8?B?ejJnVDl6L2dwMTE3U1pWL0JRS0ZNU0dJaklxZ01YUHViOGE2bjdYQlQrU0JX?=
 =?utf-8?B?SVZDWkdlTTMrN3JTaXY3aG44VzZFSE1YZ2UrL0piSUxZemVaYy9ua0YvOEhC?=
 =?utf-8?B?cnNDUGcrSlp3NW9oT3MvbGlzYXVGdHJoWENEaDdBT2Jzd241dTVTU1ZzVUxQ?=
 =?utf-8?B?R2t0Ymo1N1lIK3Z2ZDdxblZqY0ZydHAxbkYwOWtXZGlwYkhDTHFkaDFKeXNi?=
 =?utf-8?B?dUVlNFpYeW5jaVg2Q0syRUQzMmpQalNWaERJTC9TbTBpOEdIZlNoV0FCTHNi?=
 =?utf-8?B?aDMxM3poLzJ4U3BXMFR5bHB6Ty8xUlFZTXBaUytaYlRjak1OOStjQzFmQWgx?=
 =?utf-8?B?SnFmblRKRFJVWk5mRzYrWlIxeDNKbjRrclpNRzdGVDArQlBFRUhMb0x2WTVE?=
 =?utf-8?B?bitrdkRPYlNuOHkzUlBTRXFsS1ZUV0NXaDNHNmdVMmhhNmkrZm5TSEM2Zlg0?=
 =?utf-8?B?cDlQL1U0Y0J3c0lyaHA5MW5VRUFZRkpWWGVjR0wxQmV0TE9qa3l3emxTbk9p?=
 =?utf-8?B?cHlNNEZzL3I0SXJjQ1AvWnF6QUJRT05ENzJjMTU1bjlLRkhDbDAvSTNnWElY?=
 =?utf-8?B?UlhBRkNMMTBiWUpDcXkwTjM2cS82TWh5TUN0RHBCdUFOWTBEbHEvSWFYSGRE?=
 =?utf-8?Q?oWH0lod88kl8Ob+FX8Ym6p1yI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49A0ACF09C807E42AED091E357DF5935@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR07MB4549.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5b61b8-af73-4004-ac4b-08ddab410726
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2025 12:43:13.7656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dgkBoVRkfDrrNqcHn342+UzL6uKm1hHxpAOb4KFRVqDQFTUkoZQvipbZLcjrpC4N/c9ioiLgT0iynvemhKaeu3qgeDWWe0Gks/LUqM5+GsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9651

ClBpbmcgPwoKT24gTW9uLCAyMDI1LTA2LTAyIGF0IDA5OjUwICswMjAwLCBKb2FraW0gVGplcm5s
dW5kIHdyb3RlOgo+IFRoaXMgZW5hYmxlcyBtb3VudGluZywgbGlrZSBKRkZTMiwgTVREIGRldmlj
ZXMgYnkgImxhYmVsIjoKPiDCoMKgIG1vdW50IC10IHNxdWFzaGZzIG10ZDphcHBmcyAvdG1wCj4g
YW5kIGNtZGxpbmUgYXJndW1lbnQ6Cj4gwqDCoCByb290PW10ZDpyb290ZnMKPiAKPiB3aGVyZSBt
dGQ6YXBwZnMgY29tZXMgZnJvbToKPiDCoCMgPsKgIGNhdCAvcHJvYy9tdGQKPiBkZXY6wqDCoMKg
IHNpemXCoMKgIGVyYXNlc2l6ZcKgIG5hbWUKPiDCoC4uLgo+IG10ZDIyOiAwMDc1MDAwMCAwMDAx
MDAwMCAiYXBwZnMiCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFRqZXJubHVuZCA8am9ha2lt
LnRqZXJubHVuZEBpbmZpbmVyYS5jb20+Cj4gLS0tCj4gCj4gwqAtIGtlcm5lbCB0ZXN0IGJvdCBm
b3VuZCB3aGl0ZSBzcGFjZSBpc3N1ZXMsIGZpeCB0aGVzZS4KPiDCoGJsb2NrL2JkZXYuYyB8IDIx
ICsrKysrKysrKysrKysrKysrKy0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JkZXYuYyBiL2Jsb2Nr
L2JkZXYuYwo+IGluZGV4IDg4OWVjNmUwMDJkNy4uMGU1M2NlOTk0ODFiIDEwMDY0NAo+IC0tLSBh
L2Jsb2NrL2JkZXYuYwo+ICsrKyBiL2Jsb2NrL2JkZXYuYwo+IEBAIC0xNyw2ICsxNyw3IEBACj4g
wqAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvYmxrcGcuaD4K
PiDCoCNpbmNsdWRlIDxsaW51eC9tYWdpYy5oPgo+ICsjaW5jbHVkZSA8bGludXgvbXRkL210ZC5o
Pgo+IMKgI2luY2x1ZGUgPGxpbnV4L2J1ZmZlcl9oZWFkLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgv
c3dhcC5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L3dyaXRlYmFjay5oPgo+IEBAIC0xMDc1LDkgKzEw
NzYsMjMgQEAgc3RydWN0IGZpbGUgKmJkZXZfZmlsZV9vcGVuX2J5X3BhdGgoY29uc3QgY2hhciAq
cGF0aCwgYmxrX21vZGVfdCBtb2RlLAo+IMKgCWRldl90IGRldjsKPiDCoAlpbnQgZXJyb3I7Cj4g
wqAKPiAtCWVycm9yID0gbG9va3VwX2JkZXYocGF0aCwgJmRldik7Cj4gLQlpZiAoZXJyb3IpCj4g
LQkJcmV0dXJuIEVSUl9QVFIoZXJyb3IpOwo+ICsjaWZkZWYgQ09ORklHX01URF9CTE9DSwo+ICsJ
aWYgKCFzdHJuY21wKHBhdGgsICJtdGQ6IiwgNCkpIHsKPiArCQlzdHJ1Y3QgbXRkX2luZm8gKm10
ZDsKPiArCj4gKwkJLyogbW91bnQgYnkgTVREIGRldmljZSBuYW1lICovCj4gKwkJcHJfZGVidWco
InBhdGggbmFtZSBcIiVzXCJcbiIsIHBhdGgpOwo+ICsJCW10ZCA9IGdldF9tdGRfZGV2aWNlX25t
KHBhdGggKyA0KTsKPiArCQlpZiAoSVNfRVJSKG10ZCkpCj4gKwkJCXJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOwo+ICsJCWRldiA9IE1LREVWKE1URF9CTE9DS19NQUpPUiwgbXRkLT5pbmRleCk7Cj4g
Kwl9IGVsc2UKPiArI2VuZGlmCj4gKwl7Cj4gKwkJZXJyb3IgPSBsb29rdXBfYmRldihwYXRoLCAm
ZGV2KTsKPiArCQlpZiAoZXJyb3IpCj4gKwkJCXJldHVybiBFUlJfUFRSKGVycm9yKTsKPiArCX0K
PiDCoAo+IMKgCWZpbGUgPSBiZGV2X2ZpbGVfb3Blbl9ieV9kZXYoZGV2LCBtb2RlLCBob2xkZXIs
IGhvcHMpOwo+IMKgCWlmICghSVNfRVJSKGZpbGUpICYmIChtb2RlICYgQkxLX09QRU5fV1JJVEUp
KSB7Cg==


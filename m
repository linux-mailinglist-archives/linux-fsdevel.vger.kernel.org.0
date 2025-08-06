Return-Path: <linux-fsdevel+bounces-56917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16DEB1CE50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 23:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF2F18C3D71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD620E715;
	Wed,  6 Aug 2025 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="FqkDDAHt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC919A
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515044; cv=fail; b=Qr8exZuwc2WKdI4dgXTxvREvWjyS+1/pq/TrZe4iKGRufIr1ox9QaTXbofShaGP20/iIFZX2TWxzihIopWSpHWjBQK7IT6Z5NEcDaicBroFNQZX1N+kbhP0oV42rXIkk3gtAg6Y9Re/yTdkTmYmHDm9InEZSX0229sqk+g1XbJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515044; c=relaxed/simple;
	bh=IHBh275J4C38lR3MmkWZ18YGvqxCyD6EfeebZO89Pzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BKAmfD8aex6tMBFVRCxCdwRuOlOAhJPfKucwxfI7trIpz+Om4LMMdw8BfhLYqkQbAOyXTrqBoRIfFod0xAmlhBRyVKVp/U2jULMUuAoqTcjSD6u8ijvaHLVK26KV9FVqUfk+/flrOhYHn000kvf3E6hyZzoqTGDuCbUiyEbGfmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=FqkDDAHt; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104]) by mx-outbound13-131.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 06 Aug 2025 21:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBDa8JIFN5rJT2QGkIqFPUApXaQNxelNJqz+GHE4Syz0gYXwgaUEWrl2vGnWORV2MaDI0TJ8yJ2oTo9JbLug62QsBy5p79BLCzKzssFSOwx6nwxdnqGzeXDfO8ezPILYgBIFyEauQxy9ZwTSwSm1iRxYQmg7dBNWCi8ikKtPWgoxT85akeWW90ewFFIJP2iwAv5fXaXZc57QQPyZ95KP4ci2tG+uyhrJJxj3C4ZI+a+y5aKnXvR/rOpEmKDtc3RwrcnoGmj0RAGtz9XxCjh1WUpiJ/eCWn097wTIg2CDY+jj5JYfo6BiwaoCqbkW3lVF+nNDO0mHF7u/MES4er5Ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHBh275J4C38lR3MmkWZ18YGvqxCyD6EfeebZO89Pzo=;
 b=IDtwOh2HszURAhptxP+SndiqAJUDTYFjTSI6Z57iHCJ/lvcv5HGsSbsdlRfsllXNd0d1Rfn4vIlO73cK6wvaX/yOE1JwylzKhDnSkOQQKm1P7rxhYnzNelGCfHT4Xq2LSN3BxY9gj0QI//rA+5YZ0+BF/vlkK+4WG5zH/bXm90+bg7h8F3HiQjuiyWnzVWcw9t8z31RD9+2QlpUGzTrB3Z9CRbHrCA8XXadNfuEtNnYR3GU4aKLXr4A2JwQYdzGSyRiBd0ATCYNG1DXgbXiJLkSfYkpTX+Llmc47oGMq656KEJ/RtTkz5D1CZLT09jKYvMi2qxagO0eoHVoZ14vNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHBh275J4C38lR3MmkWZ18YGvqxCyD6EfeebZO89Pzo=;
 b=FqkDDAHt8FFaRRpUtahKdv1n5lS+D59XvAXj3lsm/k1QsbWJ6oAf0auPDzXlyekXIowNZWlM6J0VD14q9cAJBkm7+SaDOoxZQizzDAiNFbZTNagpYjRIgxtxs74GP3iTBDhPO0ve8o2Q4zxLffflxZgUbr1UZ05dI15pmhbhoxg=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by IA3PR19MB8640.namprd19.prod.outlook.com (2603:10b6:208:521::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.12; Wed, 6 Aug
 2025 19:43:01 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 19:43:01 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <mszeredi@redhat.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Florian
 Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Thread-Topic: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Thread-Index: AQHcBjcGGVX9wmnd6EyEG1B/pM0GfLRVWXSggACuvwA=
Date: Wed, 6 Aug 2025 19:43:00 +0000
Message-ID: <3bf4f5f5-bfab-47cb-815b-979b56821cc5@ddn.com>
References: <20250805183017.4072973-1-mszeredi@redhat.com>
 <87pld8kdwt.fsf@wotan.olymp>
In-Reply-To: <87pld8kdwt.fsf@wotan.olymp>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|IA3PR19MB8640:EE_
x-ms-office365-filtering-correlation-id: b1ca6f00-6be7-4b5e-fd6a-08ddd52173c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzFVc04xYXhOTFd3WWlXOHFtaTRSRUs4QWQ5TGZLc1VHa01NQ0hPSlNHQ0pK?=
 =?utf-8?B?Q0NkZnNxTko5RzREUEV4TS8vY0dDUmVWQTIvUjVlT1V3QXJSTWo2cXBiSmEz?=
 =?utf-8?B?cWhsMjVVZEFNd25qZHpvSk8yT2xkT3grSzZSaGtxU1dFWmtCMlNMVldlMW42?=
 =?utf-8?B?WlpFTWlBN1pTY0xrTEU3d2ExTXRJMS9oOUd4bk1RaklZdUNPNHhLT3dRVkRz?=
 =?utf-8?B?cHpDdlNOOUxrV01iMWtBMkUrcE5MVnJUUEU2RWRuMzF2TUtzWk9YZDNpRk0z?=
 =?utf-8?B?TTY3SWthSi9ROEhNVnJsZVZSck13aXErS2hzNXZIdU9CV3ZTRnkrOXNaR3ZP?=
 =?utf-8?B?cWhqNk9TT09wa0tNVEhoZzRJck5jemEvK3dJWEQ5WU9abVBZNjNRa1RnMy9P?=
 =?utf-8?B?RmpxU0t5ZTgxQWh6aDdtSFZLdXA2VWhaQldONzNOcFArVUh6cE5qL1ZGYW5F?=
 =?utf-8?B?Yi9hdVhGcitnY25LaXRISmZvQVYvMnhORkVoVGpPVllwd1lNSHM2VmNxOEpL?=
 =?utf-8?B?THBjTU9iY0g4TmdYSkJqZVgyVTh0a21BYy9Ka21FVFB0b2p2T0VwTitaL3ht?=
 =?utf-8?B?aWRvb3l3SXRwZFFqcG5CWnE2NE1jU0lidzBCVmRsUnhEcm9SVjY2UzFPZHZD?=
 =?utf-8?B?ODBUNDMreDBudFVoajdKSDZGekt3K0w1NG9YaldFREcvbWRYaW5NL25MK3Ur?=
 =?utf-8?B?K3k5L1NjMExGd0FPMzhVSTBPRWtkVW5iN25rQXFGVWxBY3hRZnM5Q3J4MXFl?=
 =?utf-8?B?d2Q2NXRROGpxZUxJY0hFZkw1eHRoZVh2WVlFbTZnYkFCU1psdkhqaVJzc3hp?=
 =?utf-8?B?bEtQTHg5V2dUSTZJY0IwZnBVWDBRYi9XcCs1a3Q2SFBSQXR6ZHlHTHB4ZUs3?=
 =?utf-8?B?R2x5ZWZiUkNPZzhOQUZlUVYyZlR0Y1RGaVUxamU3eUlnOWUwS3JEOWxaL0RI?=
 =?utf-8?B?Lzk1MVk5UWovMlI1VjJyYmhIa0NXaDVBWHFpeml2ajduY3pJRTNLM3ozTlZN?=
 =?utf-8?B?N0lnT1k5NEFFSks5N3J3OTd0K1RPQTlxZEJlcTc4bkZaakNITllMMmZqNkZK?=
 =?utf-8?B?WG9vbWJGRERVRUtDVHdCMUtBcVFyb2lZTkU1cTh3a2NJOTFrWnROR2g0L1Iy?=
 =?utf-8?B?ZlgvdlAxUWlRdmUzdVdhdEE0ZW0yT3BUd0dkYUR0WjMvY1duajAvbXZpVnl0?=
 =?utf-8?B?RE9Yb0hZMmZCQ0FYVkhTRkhna0pDajJTMm5oeGR2a1pHQ1luSWVKUFAydmtu?=
 =?utf-8?B?ZmpzaHBQM0ZHNnEra1hrYk9aNVR4bnRlVTFFKy9DZXc0ckcza1E3QkUxQ05L?=
 =?utf-8?B?V01OenhtUHRkeVhhNGZaQWI2aW5KZ0FBME9lUCtibWxKVVRhSVNKRVJtNEZM?=
 =?utf-8?B?UjllTENoR1NVRGQ3NEhqSzhkeFZSdHZKeUJpZG9qbmJXTTZpSUthbnJUaUlq?=
 =?utf-8?B?Q3J6cGNHOE1JN2diMEFjUU95OHFjT0RzOGt2WjZaNUlaY0NUV2FyY25rN3Fn?=
 =?utf-8?B?WVZhUGpJdk43Z1dNL2FyZmEyL1RaZ2I1UGNHYndRQlVHbndwQnJnSHFHWHZS?=
 =?utf-8?B?NGp1Y1QwY1kwTHpaa3ZMQWdYaVlVVTlRMVFLK1pOY1dFclFrUHhFdTcvdWlm?=
 =?utf-8?B?MjZsY0hnY0ZkWk5xVlNYT2gvU2lpUDRGZy9wck1aOFBpM0lsUmQxVXlqNmhU?=
 =?utf-8?B?MUcvRTVrMUljQTlFUzJoVWhoWWw0S0FPd3hMYjkrSTVmZmNNcTVUV2NXVFBt?=
 =?utf-8?B?ZEhMaDVWOGpjY0hodkNzSEtQcmxSbE5NcjIyQ0xYM3pQSUVIeGRBVVZZR2pU?=
 =?utf-8?B?Q1JQUThOcDRSVkx6TlNvcVNpUzBlMWtqOEQ2SSt0ekxUdlNEWEd1aS9yWVFS?=
 =?utf-8?B?OFlGOGs4L0RLd2x5b2Y3STdoNkt3UUZyaEpqSU9UdTlRLzRoZlZ2RmxBQ1R3?=
 =?utf-8?B?NWlrNnRCOXY3VERSTThRUERMSjVtREFSZ1Q2dTl6enkwd0RWOC9NZlNrRzh5?=
 =?utf-8?B?Y0NaV3RwZjRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUVuVVFLRXRZL3pvZXZZc3RDQVZ5clIvUEhHWW8xZFU5R1lCLyttT0NZT3Fv?=
 =?utf-8?B?Y3FBMDVPaWlmSndmWlRLazErN0FlVzVITHpJdzFVNXZGaFJWNis2U0lPVlBn?=
 =?utf-8?B?RlR3dkZaSml3Lzc3UDUzU2tDV2w4M2lDakJpTHh5QjEvT0RNbC90Um1lZlRH?=
 =?utf-8?B?WGNjV1ljZXRpc2ZacEkxNU9kalFUQ29FM1FaczV1K2FNRVM1S0tiNDJoR3or?=
 =?utf-8?B?NktIOTVXM2pkU2VHNm9uVE5qWVEyRVZFd29nN2lZMUxKQktjalhCcUpNMlBJ?=
 =?utf-8?B?RHcyRmR0WVg2eW92NkhQNVMzL1FyYzNwTGxqSFhSL2JOZ2pGRzBOaVg1dWty?=
 =?utf-8?B?c1Fjd2ZBRFo3TTR0SGpDWWJoUTFGVnRhLzFYdXBZcjZVUzQyWEhZamRlUWJV?=
 =?utf-8?B?ajhYS05mcEFNVXVOUUlOTWV6K3FBd3phVWFFaC9DdCs0WU9wam4ycFZCd1g5?=
 =?utf-8?B?czhMTWxmUmdqYXE1Sy8rVGtkM0xuMGdJTEdCMGNrcnJGVnNzOGtKVm02SFZC?=
 =?utf-8?B?KzVXT1BXN0w0RCtyQzlwV0JEN2NrZ0ZhU09IZnpNcUoyQktXYlpzQ3VRUWxi?=
 =?utf-8?B?MEF0d0N1UVh5U2s3aVREV0hRQURac0w4YldiVUQrODhZZmlZOFZPVDVzc214?=
 =?utf-8?B?MlFScDJGdFhXaTZNa3dDeWhuYXZUM3p1Z252Ynd3YnZ1UEJRYTVMWE1YZFo0?=
 =?utf-8?B?b2ljdzhBNEp4WWJObXF1SnBGeTBJOFpJTml3QS9VYVNSckp0dGQ0NjRaUG5q?=
 =?utf-8?B?Z0V1bTRrOXJiaW1iT0J0Q1hPdERUczg1UElaU3VIWmZlekFlL1FmT2VUanN5?=
 =?utf-8?B?Q0twOXdQa2VkRDNxMmxrdTBsYmNrSkl6TXRxcGptR2cwU2xZK1ZZVnJWQmgz?=
 =?utf-8?B?UjI1YnlHdUxEaHFLeUZkVk5kSkE4Q2huSmNrYzRFRVZJRUtQQ2VrajlPSlVS?=
 =?utf-8?B?c2NibzFzeG41azI5OHpOeWl4TW96bDNxL0ZSbWZxNzdXTCtjcTFmblJCSHVv?=
 =?utf-8?B?N1dSbXlWQWJ3YllucDRxQ3hydC8rbDdDSlhUZWtDU2R4TUs3aSs3WWJtS3lo?=
 =?utf-8?B?NW5QRWFLVTBXbk5zOWwwcVV6alUrM1Z1dysrRnJWbnhFbXZFK0VXSUxxU3Bq?=
 =?utf-8?B?QUNaQmVDV09RY2ovNTNsVWRnYUR0OVB5SWJZUXhSYk5sTVM0UWF1SjJPRmVt?=
 =?utf-8?B?UjAvSWlPY2hwamJLYXB6UTYwSTJDU2d4b2RvOUhiS1ZMcGNxNndWTitFd3FU?=
 =?utf-8?B?U2t3OXZQT1RHd0tocTZRcldTcyswT1dVR1JTL01ObFFYdGJzemlBNWl1OXBO?=
 =?utf-8?B?QUhPMXVzeE90aUx1Tncrc3RpUTJxMk80WnNQdTczRlBMdUxCK3VUT3hLMm96?=
 =?utf-8?B?OW9QK1lFU1luYVJaMGQ3TFBaVG02RmhIMjNmTDVRM2MvYzJmTzlGKzdZekFT?=
 =?utf-8?B?SDZ1R1hvemw3RERDdEtxeWFabnhXbVRhdnhsYnBNajk2aU1GQVFrbjdCSzQw?=
 =?utf-8?B?c2JjaUlUSXVsZFJBM0lPcW0xdnllTHo5WVczdUs2Y0NXRkVyMGFESDI1eGYx?=
 =?utf-8?B?U0wrN2NRZmRRZUpUWnVpVE9VRTlFZUVyNVMwdmZjVnFFVWNSMjBKMHBUKzhU?=
 =?utf-8?B?TXlLNC9ZdldodHZrVFNIMEx1WFQxWTdPZFVHdDY2eElSOGlDeFJFNllzNEUz?=
 =?utf-8?B?V0tQOHpvQ0VaUkFFTm1SeEV1VkpDcFgvR1dDOHJodTNhdUZXMUtrS2tsYnZa?=
 =?utf-8?B?Z2swN3EwWUY2TVNOY3dvMG13bE1vamRWaUtLN2txbGJEcW1CQTJrL2Fac2Y2?=
 =?utf-8?B?czlsTHI1MkthQTl1cU9aY2kvcWcxZ1FZTHVXZHNTaWFGMXluQWk5eVdDUkZI?=
 =?utf-8?B?U1VNM3lzcFlPTTRPSjArNDBXZWdFYkdHcitCNXF4U2I0VFFSd3RQdUlGZHh2?=
 =?utf-8?B?Rm4zWEVRdWxhVmY4Yy9QTHdTSmNiQjN1akFPS0JBekhTYzd5VGZpQmlWZTI4?=
 =?utf-8?B?N3pTNGJzVXFpOHhnOXVadDh1dWY0ZUovSGUzeDFxMUJ1YWxsUzFhZVV4SlJO?=
 =?utf-8?B?elZibG9ScUo2MGNzUWt5Um1YcGRtUkJMSHZmWlFpRDJYRU5ZR2pDYTYvQ0pR?=
 =?utf-8?B?V1dxZWN2YzJ0VDlQeDJNd28vU3VWSkVVUjlkc3NXNmtJL29xNGRRQU41VE0w?=
 =?utf-8?Q?IhR8b6ezkOc322Nkipp/UKE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D38A41033E3E324998D616C6F97A0FF4@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sK5YZSaZ6vauwhkZdCepehoT4q0wwOWGHHvfscK5BNdySOrciUqigqINd/ruL3M43UgHgwQK75kvffMDMSnN1Ffk+4CqItfevPw5rMW35RosPAWcvwiAJLjaW2Tasl5qjfPz5rokxIQGQSeD+e1vjpDrV1ZLg3oQf7ZhuBoscr63m/DKFZm1gRHSDpMwoMNUa+zTvMeLI/LID7bHsSYWpS/l2MbzPREy+kLGvHbb0dV0dz3KX7d42Ce1GsVrQ9Re4g/wMQbyjECaHGlH+5MsrP+Ev2e2/8kicEm9GcfxDX7kE390o0a6Hy9hzBhM5yIFhiX38/+Zx5ZCkHek5EmSTEW/aE0cSd+76sVGmJ20b6+OE6D3INqE7TkTZ/EBpnmB1GroeBfdaGC89mRhY/9KnrSIk4Brz+Kaedy7VDoB/XhqC2YfAUjZhGL5dtJBSKaELeUeTuSEXbqIc/UCu0Abfxv+BWUEChNZvScClTjjfkZ6/4+ZRiHWLDPh+5b6YoAxGLuLZw1TZKF1xwVdhrEeow0cuJQsVYbxP1jjqwqQ54P7aPsdKF5plHC2n9HVgqGen/wNFAEUXX+/GF1eouwEAwRl1C80ApULPpcxc4+qbgB/io5vJoKLPgdVVqIklKnpVcR/AGvf5RzXjBV3vgqBKQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ca6f00-6be7-4b5e-fd6a-08ddd52173c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 19:43:00.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWgDowG1unzDmBMaBFUn+R2rD1BCtneWDeAHLSgB/RvkEo3MFoMljhZ2hA5cJAscU2VpsMKWBhzSgS+oU8e94w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8640
X-OriginatorOrg: ddn.com
X-BESS-ID: 1754515038-103459-9092-17938-1
X-BESS-VER: 2019.1_20250709.1638
X-BESS-Apparent-Source-IP: 40.107.92.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmZqZAVgZQMMksLdUiJSnNyM
	g0zSTRwtjExMjUwtLUwsA81djS0sJYqTYWAFZPyzpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266593 [from 
	cloudscan11-233.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

T24gOC82LzI1IDExOjE3LCBMdWlzIEhlbnJpcXVlcyB3cm90ZToNCj4gT24gVHVlLCBBdWcgMDUg
MjAyNSwgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+IA0KPj4gVGhlIEZVU0UgcHJvdG9jb2wgdXNl
cyBzdHJ1Y3QgZnVzZV93cml0ZV9vdXQgdG8gY29udmV5IHRoZSByZXR1cm4gdmFsdWUgb2YNCj4+
IGNvcHlfZmlsZV9yYW5nZSwgd2hpY2ggaXMgcmVzdHJpY3RlZCB0byB1aW50MzJfdC4gIEJ1dCB0
aGUgQ09QWV9GSUxFX1JBTkdFDQo+PiBpbnRlcmZhY2Ugc3VwcG9ydHMgYSA2NC1iaXQgc2l6ZSBj
b3BpZXMuDQo+Pg0KPj4gQ3VycmVudGx5IHRoZSBudW1iZXIgb2YgYnl0ZXMgY29waWVkIGlzIHNp
bGVudGx5IHRydW5jYXRlZCB0byAzMi1iaXQsIHdoaWNoDQo+PiBpcyB1bmZvcnR1bmF0ZSBhdCBi
ZXN0Lg0KPj4NCj4+IEludHJvZHVjZSBhIG5ldyBvcCBDT1BZX0ZJTEVfUkFOR0VfNjQsIHdoaWNo
IGlzIGlkZW50aWNhbCwgZXhjZXB0IHRoZQ0KPj4gbnVtYmVyIG9mIGJ5dGVzIGNvcGllZCBpcyBy
ZXR1cm5lZCBpbiBhIDY0LWJpdCB2YWx1ZS4NCj4+DQo+PiBJZiB0aGUgZnVzZSBzZXJ2ZXIgZG9l
cyBub3Qgc3VwcG9ydCBDT1BZX0ZJTEVfUkFOR0VfNjQsIGZhbGwgYmFjayB0bw0KPj4gQ09QWV9G
SUxFX1JBTkdFIGFuZCB0cnVuY2F0ZSB0aGUgc2l6ZSB0byBVSU5UX01BWCAtIDQwOTYuDQo+IA0K
PiBJIHdhcyB3b25kZXJpbmcgaWYgaXQgd291bGRuJ3QgbWFrZSBtb3JlIHNlbnNlIHRvIHRydW5j
YXRlIHRoZSBzaXplIHRvDQo+IE1BWF9SV19DT1VOVCBpbnN0ZWFkLiAgTXkgcmVhc29uaW5nIGlz
IHRoYXQsIGlmIEkgdW5kZXJzdGFuZCB0aGUgY29kZQ0KPiBjb3JyZWN0bHkgKHdoaWNoIGlzIHBy
b2JhYmx5IGEgYmlnICdpZichKSwgdGhlIFZGUyB3aWxsIGZhbGxiYWNrIHRvDQo+IHNwbGljZSgp
IGlmIHRoZSBmaWxlIHN5c3RlbSBkb2VzIG5vdCBpbXBsZW1lbnQgY29weV9maWxlX3JhbmdlLiAg
QW5kIGluDQo+IHRoaXMgY2FzZSBzcGxpY2UoKSBzZWVtcyB0byBsaW1pdCB0aGUgb3BlcmF0aW9u
IHRvIE1BWF9SV19DT1VOVC4NCg0KSSBwZXJzb25hbGx5IGRvbid0IGxpa2UgdGhlIGhhcmQgY29k
ZWQgdmFsdWUgdG9vIG11Y2ggYW5kIHdvdWxkIHVzZQ0KDQppbmFyZy5sZW4gPSBtaW5fdChzaXpl
X3QsIGxlbiwgKFVJTlRfTUFYIC0gNDA5NikpOw0KDQooYnR3LCAweGZmZmZmMDAwIGlzIFVJTlRf
TUFYIC0gNDA5NSwgaXNuJ3QgaXQ/KS4NCg0KVGhvdWdoIHRoYXQgaXMgYWxsIG5pdHBpY2suIFRo
ZSB3b3JzdCBwYXJ0IHRoYXQgY291bGQgaGFwcGVuIGFyZQ0KYXBwbGljYXRpb25zIHRoYXQgZG8g
bm90IGhhbmRsZSBwYXJ0aWFsIGZpbGUgY29weSBhbmQgdGhlbiB3b3VsZG4ndA0KY29weSB0aGUg
ZW50aXJlIGZpbGUuIEZvciB0aGVzZSBpdCBwcm9iYWJseSB3b3VsZCBiZSBiZXR0ZXIgdG8gcmV0
dXJuDQotRU5PU1lTLg0KDQpMR1RNLCANCg0KUmV2aWV3ZWQtYnk6IEJlcm5kIFNjaHViZXJ0IDxi
c2NodWJlcnRAZGRuLmNvbT4NCg==


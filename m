Return-Path: <linux-fsdevel+bounces-27864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640449648AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D287B23F36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33F1B0120;
	Thu, 29 Aug 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="HLuE4P3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75F1B0116
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942278; cv=fail; b=qPZ5qgCl2KkrUM1Tw9VPBHWhriNBtP1TY3BxDmZKsp68TRERp3ZTmeBZt1eYUKGcQ/olsx7ung+yDJ7V0rNNEsGwy6hw8cwRvY1t0UIG3GaPUuTMe++TzS1aTAIuSA04HsPTkY3Qce4RtEg4zZhzEc8SGl3kVY8Elf2zHHYDFeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942278; c=relaxed/simple;
	bh=gcdF9rJEf3cvgNfqTw+ZVJpAvawP9EEYcFTeEa8TyZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPclIp56dwz63qRbhOle+WwyGnIVqDHracayJXDWcXuk++NQXjFjsB9OWOxEC1Q1nOxabEj9tWyidqokI9aCe2og71tKZsfgnin1KTMiRTJJc5kd/OpoJEbkzJevy5KYJXZ1Kb+ZxkqxJnGE5KTIfi1IkM2iSAQNyOyepT3m4NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=HLuE4P3Y; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171]) by mx-outbound13-77.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 29 Aug 2024 14:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNFSNu0MtVPmt5e23GIC+C2JAPnh8yqTYymuSW84xarMf5ustxQch1c1On4CmDQfwoSeeHJotKXNWLPXZ6T61J/nSZp8oazcCJ95Ql4YpMvvxwLhvgFK66ru4CzKiChwyNI5NTr+TjBUAz7O22JVjUKZXq5acoupKnxaBZTpjaiMSMucEB7foIf76wZs1WXb+R84v8dINb5oYDq2Ct86iozoSI2gVHGojaVoOjhCmi0j/j3XoJ1a9oysBS28vidTf5DluYK8B5onT9SjRMxxwoH5xXjvdZW/ONWK9JIqb1Wco36ma0wg4awIFx4m6qSCtDNL1L1bdfEVSqpfBH1onQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcdF9rJEf3cvgNfqTw+ZVJpAvawP9EEYcFTeEa8TyZE=;
 b=J0Kv1NE1ibOdYQFvgt0pnH+dCozfOW18vq44fGk5pL6pBsaMH1Hc+wmbLdoBXMQVStLOpH4qQaD8arS4hkSoo2387PoLVHR0SWL3AAE56pBMs7pmtqmLumkbpd7AqqHkHEriMHZ8E4wlloK4lPg8ntnar2an1NDOTLlemteHr8HqDba4c5jLXHiQUb3uBNKwnf9vPYx/wp/AfFL23FUXf3Sk8vYtfGzXZq4Z1+e8M2XAg9ORn/1aYeF3X/2v4+kr0qt4vr47l1HzZClu35UEtv7KW6HjBhmp4EGopvrGscKJSin8OpmaaMBOYIGEGYAQY6EFjXhAmyFSW77gLveXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcdF9rJEf3cvgNfqTw+ZVJpAvawP9EEYcFTeEa8TyZE=;
 b=HLuE4P3YTEIeCq8dl21uMsL+oSg01u+AldWcQe7y4Adf/BiLYMzlnIfRPfIa9G/fRsSFrVeBXPVddUDtKT6yIYjLWw0ydmIrYhcEDtBxUIyypngnAZOrLHDVELwIryXA9y+webx489bWRsQhSnkNb3f1keAAneavXBsQMq2tKEM=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH7PR19MB8186.namprd19.prod.outlook.com (2603:10b6:510:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 13:04:39 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%2]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 13:04:38 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert
	<bernd.schubert@fastmail.fm>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "joannelkoong@gmail.com"
	<joannelkoong@gmail.com>
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
Thread-Topic: [PATCH v3] fuse: Allow page aligned writes
Thread-Index: AQHa7NNPtyDKGsbz7EGBL1Z84DeVcLIj0kiAgBp3EACAAAUBgA==
Date: Thu, 29 Aug 2024 13:04:38 +0000
Message-ID: <b3b64839-edab-4253-9300-7a12151815a5@ddn.com>
References: <20240812161839.1961311-1-bschubert@ddn.com>
 <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
 <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com>
In-Reply-To:
 <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|PH7PR19MB8186:EE_
x-ms-office365-filtering-correlation-id: 59e243ea-986e-475e-7b18-08dcc82b2397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHdpWVFGRTM1bnJsU24xOGk3VGswZTBHekNkNjhoT0ZaL3pQWmVvTm5oTWdO?=
 =?utf-8?B?ald1eHdzcWV0WHFBMDA5Y3FXWk9jRStsRnFGQ3hvQjlqMTZrR0Vpa2JjZUVX?=
 =?utf-8?B?VHRlNWw0MjUvQ2EzUWpjVlJIcHo4YlhsQjFEYm9NSzJDR0U0b0FEMG1pbTl5?=
 =?utf-8?B?RVZXTWJHZ0xRMEJzWU1IMENKZ1RlQmRYZ3gvT1gvbkhlVFdhd0NTR2RLOFU4?=
 =?utf-8?B?OGxjZzkraWpSTUd1MHVBQXc5Y1RhNFcwV0RTUjgzWmhTeTRPMEN3b1UwdUNv?=
 =?utf-8?B?SDJwRU9DaWVoaHdWUFVFUVloRW9ua1NwanRwRm5uVkd5S01zMkZkSHJUZ0JV?=
 =?utf-8?B?MitHVU9zR1ZoQkdqUHJ3ZVp0SWcvQmExTEN0RkJnZFpkbmdNUmY0OSthb1J5?=
 =?utf-8?B?L3hsYVM1c2tMZmpMNFVCU0RINmdST1EwVmtXYitxbzRVSXJoU1h3a251aW1m?=
 =?utf-8?B?VWQvR2Q0SHBFQTZ2djY5MzNwQUpmS3dMdERUemhsUGhwSzhaNmtGK2FsdVcr?=
 =?utf-8?B?S3RuUWZ2UDdkbGNXN21haUJQVkM2ZWNPZzBPQzYxYjcyalFmL1dvS1RjY1NP?=
 =?utf-8?B?THJXSGZOMFBJUEt1M3E2RWlINXIzYnZkMjRZS2l4U2lCRFNaTGRxdXVKZVda?=
 =?utf-8?B?aWpob2hiNC9DSEFzb2FMd1VBU213bGZpMnNuK3BITnNDR1diWWdHeDd3SHp0?=
 =?utf-8?B?T3EyVG1GTWNXamNRajdEZTJ3WkFoWlZ1ckVJZ3Z2NGloWlJzeXBoZUY2a1hF?=
 =?utf-8?B?NjVvWDExZWJUZURIcllBUXlVZk4zVVdSbnZPNlFPOG5oWUN5Sno1dVRUb1J1?=
 =?utf-8?B?KzBmTUN3a1Q1NFovajRxTHQ2TllXNk9WNE5Fd21temxzUkpSeGQwUVFsZWJq?=
 =?utf-8?B?Ty9QaGpBTUNHeWlDelhucWQ0NURMNTJJdGJoUmNTeTVCNlJocmF3cVlIMGpv?=
 =?utf-8?B?c1lDc0p0SUxxK3ZYbHZvU3B6UXpXc1pocnhsbjBoc2N2enZ1S05HYXZDNzlt?=
 =?utf-8?B?Q2xHUHUrTDVoL2lYM2tlK1JzcVJDdlF2d3FVQ3pCeSt0KzNXRnZUdkxpSTZq?=
 =?utf-8?B?QUhFTlpHOG45NUhoT3ZtK3AzYzhteHJnY25pQkM3RURjem4zNWNEZU96SWlh?=
 =?utf-8?B?dW10Tm95aWhUQ1dqTmthU0gxUm10b1RtZzBVUFlabVAyUnkxK2RXcjFGRlJw?=
 =?utf-8?B?aDk4NDN1RE96SmxMSjdOQXBGN3VnelNyRTdpem5jYU43bEVPQUVsOGpEQ05X?=
 =?utf-8?B?dmFvNHcvejBIdVQ4NXF4Rnp6dTcvNk4ycHlGQklwamw4UjdISlJFMExpcjd6?=
 =?utf-8?B?N3hwR3h3NTVkd0o2eHg2SWE3QjhMRUQ5TWhFQkc3WWxHS3ZJUVdVem05RUs1?=
 =?utf-8?B?Rit1c01FcHRKSHQxN25qTUsrL2tNZ05zVjMxb25YN1cxUXlTVWNnNElZVk9L?=
 =?utf-8?B?SE9Gc09TZTlhN0VZMUJoNHhxVVV0MGZId1ZEYVBPOGlRUzc2K0NDY3ArcFZW?=
 =?utf-8?B?SUFuSUZ5L3AvWXVXZGV4OG8ycTFPUlByajRqenV5UXMxaFBpUVJCZFg2eVhs?=
 =?utf-8?B?WDFzOXIyK3ZYbjg5Y1ZyYmdiaTZQYXZ1Unlya2xCM3AxRFBGbjJadFdaaks5?=
 =?utf-8?B?UjYrb1B6WVFDL0kvNUZKZVBnSHFEV1NCeUFlS2xzN3Q4cS96Qk9YQUd5Sk50?=
 =?utf-8?B?UytIRVBmWUE0R1lNeDZHUGpxbTk2YnB2NjRsUm9FOHFrTExWSGhRa1FXaUFG?=
 =?utf-8?B?ZE1hQlhOaFBPNVJjNWFnZjRmRFRiZkhLbWdjWnM3SkJmbVlYZndTOGdrVEly?=
 =?utf-8?B?M0p2ZWIycEs1SW80UlNJR1JyTUpUUjZWMlpwSnNrYkpYeVNpV2ZyTGNnNjJp?=
 =?utf-8?B?V0tvMFNjZnVOeWJnakg1Sk8vYTh4UzhNTUNTUnNxVXZWOUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEhzbFROb09wTjl4V0Foa2oyV3ozVHFucTBsdXNuSTlvTEx5ZHJ5R0pDamlv?=
 =?utf-8?B?bENpdlE2MTdDMGNuZXBSajhNUkFtT0VuZllKM0labUpWandzQndHM0EyRTlq?=
 =?utf-8?B?TWNIdnhzRFlaM09QSXRkN25VWUF2UzI3UmxFeVh1V2E4Zit6WStiZHpVL2p2?=
 =?utf-8?B?L2ZJWHltTTZ5Q2R2NEFkNmNJZzF6YmhtOVZ4TDRNVE1kUTRnZUVJNTFZdllK?=
 =?utf-8?B?N1dkZ1JSUlFiWGp3akZwc1hpdlBQYlZ3dkpKZytwODh4NEsxZzQ2MHYrWEJC?=
 =?utf-8?B?Q1k1d3h4dGM4TDRsWEh0ai95aW1CNFMzL0U4ZmEya3ZaMmZSUW92cmVKUHNH?=
 =?utf-8?B?UFJ4bk1JTm9PQmNSeW5DYXlSczVJUmJ5U0wxeHpEWXFvaTJWY1gvOUxlcElE?=
 =?utf-8?B?Y2ZxZ2dMU1g4bmN6SzMxQmJGbGJEWVg4eHJ2YTdjWUw5dEhBUEdoRWJHL0tI?=
 =?utf-8?B?NUF0cWhMRTZ3UFZHTmQzTEpwVUpZZ1Q1VXhnN3hLeXlYMjU4RUIwRk9yUkxq?=
 =?utf-8?B?NlRLZHhRemZMNzdIRFNSWS8xWjUzS1FKR2hEQzVHV0ttc0xCdnI5S3ppWVQy?=
 =?utf-8?B?TVJEdXo5VGlZcGx5L2hQbG1Vb2xzQ0tma29xOXA4TmU2U2MrYzUxRCsrUllX?=
 =?utf-8?B?eTJvOHVKcTBwMnBReUEvY2EvNU9tb2JqajE1Z05XeEZKTXJTOW9QQjRSRG9T?=
 =?utf-8?B?QTRhTHVsZmh6Vk9xVXBiUjN4bzBSVElMcTVoSWxBNUkyem5KRUh3anFHZkZN?=
 =?utf-8?B?a2dhREZyOE1rM2Q2dkpFcW9aWGpieUpzM1oxR0VidUltZEpML1QweU40a1Ay?=
 =?utf-8?B?Z1BCNkI2dktQVjVFZ2JwUHhSTGtzNGdVSUEvTmczVXlGdjQ0dTBNUWVqdWtQ?=
 =?utf-8?B?K2ptZG5lNlBrWWtJVytlaEhoVUVGNGJIcFg5OHdzc2dzVWlQK3ZuQ2VRckxy?=
 =?utf-8?B?MTVSMVJlSjRuNUNka240VFNocjd4Ny9xK1FZWlN4djRJcERLdnAyRzlmbnZi?=
 =?utf-8?B?cmU0cWxkRGlZWDJGQ2tnTW0vc0VYVTNvR3FoWCtBVVJuQVBHT1ZBK2w0QVlK?=
 =?utf-8?B?cTR4RlBJdnpzVTBXbmZONUp2ZHJYTUJRSCtScEYwK1VWVUc3QUwrZ1NFODB6?=
 =?utf-8?B?bTJTdGdzMlowWVFacGV0WTMveDlqSHVQMnJZMkZyWlR5YmprekpuYWtoTzVv?=
 =?utf-8?B?NzdreVVjZzE0RHJ6cnpEb0tGeHNkQjFBZEZHTnV0TEd1b0ZDZGkwZjFMNk0z?=
 =?utf-8?B?Rmo5Sy8yOUF1NzJwcDZCUVd3NkRJUGkrOHcvNmRMWXphbkNiWHQ4V0tpMUNi?=
 =?utf-8?B?bTQzSTdPY2dxN28rSEplRlNvcjJsZElqS3hDZG5oOGhSeXk4UWRxQkRJcTl6?=
 =?utf-8?B?ZUFiTTdVUkdDTlFhTjdldDdTWXJrZThCb3lIV2xGbENNL1VMdEUyblhDUStI?=
 =?utf-8?B?a3J6ZWpTS0Z6UDdqNGNaK2hYSlhZS3JiNmNhUDR4bGdHaVhUaWNuM2ZBcmFn?=
 =?utf-8?B?TTkxbjBtL1FOZWdORlpKaHE4ZmE1dDlEM0FQak5LOWttUXhtVk9wNUQ5ZzhV?=
 =?utf-8?B?ejg0TkJ0Um1qR2JkaHdGOElzdFVnZVBweTkwUWJzZ1Y1NGx4dEZPdDNLckh3?=
 =?utf-8?B?QkhiNXJLTFFqd25tSm1MeDBuWjk3ekFmWmU4ckZTdHZWUkl4Y3czY0drNVpI?=
 =?utf-8?B?OUdpcXVrN0Q5dnIxUG5ZMXZOWlg5SkNJWm9XRFZsUi91Y01qMmdhQUoyVjhC?=
 =?utf-8?B?RjBGQmlQN1pPVEhLRTdmdDRidGpIbE0vQVJaNlpHWlVKMElrekxrT1MyNmY2?=
 =?utf-8?B?NnR0dmZkWTQwbFRXeFV0VjF4YXZoSmo5R2Y5WDhxb3ZiQURLb2pzaWFKT2dE?=
 =?utf-8?B?UUtWUEJ3SXpia0VxSEF1RzI0Y2MxNURVNkE2N3E4elNTMVJlcUxQVkM0NzZL?=
 =?utf-8?B?cHNxT0YxUUNheUlvcnM5ZTluTENSd0t3VGJqMEFKemZPYTB0VHBpVGZROTJ4?=
 =?utf-8?B?dUJZSUxWOVNTREsvTmhXVlZxN1VOSE9aOUN4RnQ1NkZpNnFFOTNvc3JaVXNE?=
 =?utf-8?B?bDFnUnBCRjJvU2hzTTk1NzJVbWtnL2FRcnlRU1JjR2lCSWRSL1NFdk1lWnlJ?=
 =?utf-8?B?WUpQRldIR3ZSazdjVGx5dmVRM3dLTjhyYlY5aWpCVG1oNzZmOHhEUVJVVk9J?=
 =?utf-8?Q?Pi3wgxuJdVdYtRWC1PzZX9Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B40B6040E84577458A36A0066C1CF9ED@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	unQM6C+eQ45rYUUelJExryxnn8F8dDWqnTLcgiNZDr9naOHyOUjJ/Sf0ggNi1TeefZRGJ+MA2B4jRBQfA85gBC1CSWxz0y6hYFD2soKHX2ReDxgVN9+KkSd06sVxbMK+sbGbz4qNP4w45bR0lvImhWMMPLt9DjYx+K9m4G1qsQermN0EWZk7j70lsYABjo+QqtLdmvGYGaRQpuiDTi7cuRKSVoYU234TlgSnAwhH7WCtBlwSixWCypG5MXWMyYByjR2QuMKbq2kQ+T3ExhBViaci82OIz6IMaOR9QdCnNZ7+5fvQ2yLsh9wekdIaXO6w3/ZwciQn1mvD+QAg7YukADbx+fkrmE1JN2T5ZMQUZESl4m57GJOiMV0xIQ5liifBNZ0sVVudORlAgx5PkbTsbJE6qR9DnDISYUvMGs5+eSCIvQ9+gtstZp/sc2ozhynfmbk9a/sBv9AOUcZ23nTbv4giqwQ8il+1pYZsBdwHGSD7NykjfLOGAVAsGQq59Aqq3KzYKyslIOCJNZkoWMutJiIqZujqNl2piRg5xXn+BYc3JSRRT4rv2Wd4D4H4nLT78q7ZapF0WTJX+Vi/Q3oQ2ny5w5aZmAh/Iv8yzJ66tbyZz5tjtQVhMRLeIq0fLRYMqOujPRJwaoivdQcEn9wUYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e243ea-986e-475e-7b18-08dcc82b2397
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 13:04:38.5829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ws1LuvUNuYFNf/27vAzbv2WcBQU6dCaxTmpLdlKkZUL05zvmwTxBT9sIc9BingecJrRjilHgOmfHhOvta9fq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB8186
X-OriginatorOrg: ddn.com
X-BESS-ID: 1724942274-103405-12643-20394-1
X-BESS-VER: 2019.1_20240827.1824
X-BESS-Apparent-Source-IP: 104.47.56.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZmlkBGBlDMKNHSxCzNJDXV0s
	zYxDjFMC3R2MAwOdnMzMzYzDDV2FipNhYAv9gkvkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258675 [from 
	cloudscan19-53.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gOC8yOS8yNCAxNDo0NiwgTWlrbG9zIFN6ZXJlZGkgd3JvdGU6DQo+IE9uIE1vbiwgMTIgQXVn
IDIwMjQgYXQgMTg6MzcsIEJlcm5kIFNjaHViZXJ0IDxiZXJuZC5zY2h1YmVydEBmYXN0bWFpbC5m
bT4gd3JvdGU6DQo+Pg0KPj4gU29ycnksIEkgaGFkIHNlbnQgb3V0IHRoZSB3cm9uZy9vbGQgcGF0
Y2ggZmlsZSAtIGl0IGRvZXNuJ3QgaGF2ZSBvbmUgY2hhbmdlDQo+PiAoaGFuZGxpbmcgb2YgYWxy
ZWFkeSBhbGlnbmVkIGJ1ZmZlcnMpLg0KPj4gU2hhbGwgSSBzZW50IHY0PyBUaGUgY29ycmVjdCB2
ZXJzaW9uIGlzIGJlbG93DQo+Pg0KPj4gLS0tDQo+Pg0KPj4gRnJvbTogQmVybmQgU2NodWJlcnQg
PGJzY2h1YmVydEBkZG4uY29tPg0KPj4gRGF0ZTogRnJpLCAyMSBKdW4gMjAyNCAxMTo1MToyMyAr
MDIwMA0KPj4gU3ViamVjdDogW1BBVENIIHYzXSBmdXNlOiBBbGxvdyBwYWdlIGFsaWduZWQgd3Jp
dGVzDQo+Pg0KPj4gV3JpdGUgSU9zIHNob3VsZCBiZSBwYWdlIGFsaWduZWQgYXMgZnVzZSBzZXJ2
ZXINCj4+IG1pZ2h0IG5lZWQgdG8gY29weSBkYXRhIHRvIGFub3RoZXIgYnVmZmVyIG90aGVyd2lz
ZSBpbg0KPj4gb3JkZXIgdG8gZnVsZmlsbCBuZXR3b3JrIG9yIGRldmljZSBzdG9yYWdlIHJlcXVp
cmVtZW50cy4NCj4gDQo+IE9rYXkuDQo+IA0KPiBTbyB3aHkgbm90IGFsaWduIHRoZSBidWZmZXIg
aW4gdXNlcnNwYWNlIHNvIHRoZSBwYXlsb2FkIG9mIHRoZSB3cml0ZQ0KPiByZXF1ZXN0IGxhbmRz
IG9uIGEgcGFnZSBib3VuZGFyeT8NCj4gDQo+IEp1c3QgdGhlIGNhc2UgdGhhdCB5b3UgaGF2ZSBu
b3RlZCBpbiB0aGUgZnVzZV9jb3B5X2FsaWduKCkgZnVuY3Rpb24uDQoNCkhvdyB3b3VsZCB5b3Ug
ZG8gdGhhdCB3aXRoIHNwbGljZT8NCg0KDQpUaGFua3MsDQpCZXJuZA0KDQo=


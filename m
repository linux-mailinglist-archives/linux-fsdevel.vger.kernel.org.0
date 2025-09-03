Return-Path: <linux-fsdevel+bounces-60126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFDB417C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F10E7C3CF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8342E8B78;
	Wed,  3 Sep 2025 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="m4tg+gpT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012023.outbound.protection.outlook.com [52.101.126.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97412DFA24
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886664; cv=fail; b=LkIaoO/cyvkIVFSEiCf8e3XHoPA1l4AseGBgLZmwe01A+QQXacHbDLpKK3fqOz3PhwD3n3D6XsDDuzPnAptDgUeSp+CzjT+DsfdrBg4tSav+xuS1LhHniN3aPQMbRfa9Y0+UrLONLcRb+CtWvCcaf5bxeoEYSVwThHTXokoW2Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886664; c=relaxed/simple;
	bh=N3Dgnzc6fzwbadQDlQT6q7iUAigvGIgKJ7Zfbb7paa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DYr/0biFiG+Apg3CkBKtokLHDzxml0Yjp5CSjupq1x3MWPcZatL0ixESkiULYyEn4MRae4NH0rPEupwR7q7JJei1yc/082UO5v+c0BRYBKlwmEiltZRcv0CgFLQSpOdbLc+0STfNUgzhbJXNfBUzM9XnHn2zTF5ZbIHYTNgLdBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=m4tg+gpT; arc=fail smtp.client-ip=52.101.126.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmZHfGPh3RLa/+U2mBTmrEQWiSVewUkFADblLEGsrAzBqaFi70dItB4y240tlOApj6cpqrlJhnLQTJDWLO/UVEZGG0pOzOHnkUU2Rw266gDOqQaK5qjAwSbbyH1zr9SkfbBxnRKlI08Xt+MLl9debHs+oq1dpG8wSy5XecAvrNPflOMG4Ze41Y0/8wVwG0g+HPFKS5i8emYpNJZhwOFvhYiC/1h/SOwrqohMWT9rqtenipujUeYRtQMYPYpXUgPIgY5tyOYd38/DG4LZS9aT0wa5L3ax+c3OfN/zMLwVunhEP0wDfgf26XaXrsnBmLxaf5Bxuf12MNDpw0fnn+qUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKTKW1dsKis2sfU4K87a0r48GVO8wxC1/pJsM1HZUq8=;
 b=dk9wQsprjCjpH2o1xos6YfImlwT9+I5zKO9Nral5L48l9Xw6uxCxzbLJNCYvoqlJ1X2aZ7JWIa3jwDcvvsBuO2h9z8sLXnm2FrREfLQBEshOyd1V+oX497ZmnAEXMrwL3FluPHOEdHeMIEGoDWQrglnAeKxft5+hPvCoipIqd7pFnsDBdAUcYK+Jr2nGr3OqQzclEOYjfg1Auhg9jYYqJJXycmxW8XNjbbQG0wG252msmMmgwlyVkDXq9MGMb7FA7u5pB4FvKd1Ntayby44FI/dIfjVpnBqdqeY6M4AlVp7ATeGL8s63EheLtyvZjdliM52j1lcySceBRhkYHi/t3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKTKW1dsKis2sfU4K87a0r48GVO8wxC1/pJsM1HZUq8=;
 b=m4tg+gpT0LC9I+xi9GM8XZAW6KTR4x64qn1EwoV1bsSggzHnXmfNagO6GpMEXFjgsSB+F1R94wTbtkULtcHFdi05JvXFnmxqM+vhnp5wT+8ngQyt1WIiLjEsykox8hCcuGG4nblbDATN+nfgzs0mBCw/Cz/Q4LPRs0K2CW5nH2H8yRFKPnBeAQKQxzGv0uCCe4Qsq9EWIiUd7fzlgZDZ7JlRW+5YQ6tdn5Av3JKNeRiQ6s8BA7cCG0B2wsX2jx6tGemhybkGMrBnKuYwP2T4Ees5jNWtf4WaQBLtQ56KA5GBQKaESjR2WSLTfiWZaMzD+Ui4YG0GXKxwhuv55ECsyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5121.apcprd06.prod.outlook.com (2603:1096:400:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:04:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 08:04:17 +0000
Message-ID: <a21fe632-cac3-4c7d-9057-b71f8efbaf84@vivo.com>
Date: Wed, 3 Sep 2025 16:04:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: clear offset and space out of valid records in
 b-tree node
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com
References: <20250815194918.38165-1-slava@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250815194918.38165-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: d0006043-5f5c-4fc4-68d4-08ddeac07afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmNYTnhjRjVxWnd2L2tKcks4c0JJcmhtSGRjYWR4ZHpJYlQzaWFVTFZQQXFZ?=
 =?utf-8?B?N3JDSGxjRVpob2NBSDVOR1RHTHRkTzFqc0JtVyt2dGp4a3U1M2lLWGlGdGt1?=
 =?utf-8?B?R3hOU1VNQ0lnT0Q1VFZ3QlBFbWpuY2J3SlBWYzlVM3FzVjVFa0dLMlE3aTRU?=
 =?utf-8?B?NU9wQ1hRS2ZJK1cxWG1WVk1IOXlUV3hxTVVvWkdFajVJckVEQkdwd2RWNVRF?=
 =?utf-8?B?UW9md2lLN0lsRlVRUTFBVS8zQzJMOFdoc2FKaWNSZWdrU25tYUlTQzRSVHhv?=
 =?utf-8?B?QWVLelBsb0E4NkNKZ01FajZYaFM1QnNPakd2c2JQVTRtd21ET21kK0NCc1Y2?=
 =?utf-8?B?R1haWm1tYUo4Y3hTUTR1a3RYZS9hMzZ0bS92dW1RMmMyazVZVmNWc2FIMld6?=
 =?utf-8?B?REwzTG1mRnFBa01qZFRIdlZXYVFaTzZyN2s1aEFZRXVncVNVQWpaUno5cjZq?=
 =?utf-8?B?VHc1SFR2OVhOY1JoMnorbmlxeUd2STBsUGR6aFJuVTliN0RiMURMSlp1QnFV?=
 =?utf-8?B?UURLN0FKMmpXWkpwdExjVlVYdVlkblM0LzVLR0xWV1p1YTlkNjFnd0RzbmUr?=
 =?utf-8?B?UE5ETmVLNG8zVVpXaDBNSmhWc1ZDU3Zaa09UZVVZNHd4c3FyQ0JwWS9CQm1J?=
 =?utf-8?B?OWNFQUY4QXQzK3NZNTg3MURzVU1FVnVYZmZ6bDFpTVg1OHp3V1QwYlhTS2pQ?=
 =?utf-8?B?OXRMZjErMitIcHpIcHlnWlBERnNxMjdvaHVCV0xMRkVLOW1NU0laanFDajJV?=
 =?utf-8?B?SzhFSWdCSHJLQUJJTDh3Y1puKy9SNXNmeVBsTFFOcG1WUXBsbnhqencvS2xU?=
 =?utf-8?B?RDVsb0V4RWc5Sm8wbVQrNmdEY1dFTHVuUXJLdndTUk1RbVJFUGc5ZTJhM01X?=
 =?utf-8?B?TEtialdaWGZHR011ZjhUMGh1ak0rd3dQeUdlN1BWKzh2MUVDcUdoQlIySll1?=
 =?utf-8?B?Y0dBOEhUNWlKZ291WHhzSEllSlVUVzJrRTRyUFJkQmlmL3ExUlNwc1Z2Y1NW?=
 =?utf-8?B?STNGS1Rjazc1ZWxsQzRRcERqUFlrQVBsUlVJc250SzA0SG55L2pkZEtlTVZY?=
 =?utf-8?B?aWRYNXFlYXM3VHVHdTQxRGExK0tDWEdxQmhnenB4UTVoSDZiMHRKYzdTMnRU?=
 =?utf-8?B?bEpOSFN3d0djazFDOG1STWE0TTJhdnVoKzFoR1F2ZnYvcDlrekxiaVI3SlF0?=
 =?utf-8?B?dnhEUWNaeTVSbFBzZ1g0SU1tdWw3U0RieDdvK3RXK3pTa2VXZmM3b0d4by9M?=
 =?utf-8?B?dFZVUDB1N2EyVUpXU25KKys1MGZuUVJ3Z1pxRzJQY3Zrbit5YXpPdUVabzVv?=
 =?utf-8?B?R1dpOU5FZ2prVURHdytsVDI1elZFdHBvOEQvbjNoUmdmeVRPVlZDTkJZV0J0?=
 =?utf-8?B?Z1ptcUF1WGRiQ3h3TWhvR2huUkFacDVPSDlsQXZCZDRJQ2FLRGVsaTVvL2g5?=
 =?utf-8?B?STZGeUFtOTBHWTRMalNpWVgyRU1paVVuUTZzamN4MzQ1dGZReWkvR21zUnFx?=
 =?utf-8?B?TE0za1FYdCtVZ1ZiWExhU083VVFsdEpYT3E4UytCWVBYUmZFSTBOaVZFWWcr?=
 =?utf-8?B?VnZVRlFoS3RvZCtKdm9ZaFI2b2x6RjV0TldmUlJNdzBjSC9LQ1pQUjErc082?=
 =?utf-8?B?bTYvL2lBU0orQ3RIUnEycTNGVXNXR3p5NjZnMnppWVhEWVpSdXkyNGNUTlI0?=
 =?utf-8?B?U0thRnYwbHBzcFhpV3ZwOUhMOFFWZDFzeDZzenRZWFVPUlBsRjFldmdDUjZ1?=
 =?utf-8?B?NjEyWWNQYzRyMjZNQlBkdEhEL0tSMlZLVU9Tdjd5YXFsN2RGTWVFYm51UlJX?=
 =?utf-8?B?ZjZpdlhkdUR5SEV6VDFZdms2NWprYnRiSWlIa0NLTHZYa1lleURSU0FvUGEz?=
 =?utf-8?B?dTJWeEtZTkRvRDdCbUdkTWFsTzA2bUJXRlA0bEdpMnA2Y24zTVJwVHdzMlY4?=
 =?utf-8?Q?HInM6rYZb5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3I1ZE1VaFduUzF3dTczUms5RnVQWUtoSE5HbDRpRGN0dVNiQ0hLV3JwbmJs?=
 =?utf-8?B?WVZicVlURDQvQTVQZytLMW5jNFNYd1Z5L2pOS0V2QUt4MmFwVnpocEJyZG9r?=
 =?utf-8?B?clJza3lRNEtLem1OL2R3YzFGMERCKzliVWZRMTR2bisrQTZhTkJBOExMa0w0?=
 =?utf-8?B?Zmp2a2RZdkdNYm9pd3FUamd1WWlDNUJIY0QybUJvLzdOYVZhUStha0ppTEwv?=
 =?utf-8?B?MHZaVHc4YmJXVVMxWHpwczJ5L0F3RTIyRkFoUHhnVzN6SDdvUkZETk5FQVdE?=
 =?utf-8?B?S01XajhwUUZmN2hZeWZmcXc1Q2RjakFCZXdSMXlnYVRjZG40MXJ3MndJOWNP?=
 =?utf-8?B?bGZzZEhRVGFJRFBvT0ppSmxyYVdIRUtVdHVWQUM1dXM5ajBYVnY3VGRmbjUv?=
 =?utf-8?B?R0Mzcis0akdObmZvaUJEN2tCemc0UXdRUkkzSWNMLzlZbHd4QVZNRWNJc2Vs?=
 =?utf-8?B?L1AzdjFYM1B1WmtEK1RLS0VGYzNncEZzellKb09kWlFPVWxhTTBMU0VicTcr?=
 =?utf-8?B?NXZVamtrOHNUenVOQ1VoTzRlZGhtVXplOVRWdm03UEdtYjF3YkhCdXlUZnRj?=
 =?utf-8?B?K3lGMUxEcTRWcmRLM3ZLUVZKeFdjMnJWa2dhbGZHTXVIVmtaMG1xUVJ6WjZp?=
 =?utf-8?B?RHlCV2E0TzdyY0J6VkZQOHJDSDJtdzdhd1FnVmdYUnkzUGd5YVRsUUpqd0JN?=
 =?utf-8?B?TUs2NnNxMDNPQ0NUbVl3MWpFRjBxa0ducWNnK1Y2R2pZZS91bmZXSWQya282?=
 =?utf-8?B?aUVwNU9YdFZPVUpKN1ZmTlBSR1RWWnR5d2Y2VHE5Umt3UEQyTnpwdXIzcW9B?=
 =?utf-8?B?NGxDNERqb29zcCs2SlJGSktpLzVMZzhTWEptSWh6ZVZsNGlJcmYreVRDcXI4?=
 =?utf-8?B?aXVMaDRYc2RjQXNTZ1BRZE9jQ1k4NTVwN2ZwQTh6VkVvWkRZaVhxQXFCVlFJ?=
 =?utf-8?B?T1hpcHlyUmI2b04yaUNMWXdDLzBOYTZNUFV4MnBReko5SUxCeklmalA4OERk?=
 =?utf-8?B?RUFWME9xTUlOZGdPazN5Y3k1Y0lJOHgxNWVjejFQWmN3d2k2ZG1nZTd4LzR3?=
 =?utf-8?B?L3FMcEIzUmpaNUdpZUh1QWVPMjBYRDE0NlBGMjYyU3VzUERlWlRyNlFncHly?=
 =?utf-8?B?Mmd1Nk1LV1A1SUU1MENRenFuNUxOSjA3OEhEajFDY21hRzlIVXRWNFRaRDh0?=
 =?utf-8?B?dUMyd25TSnFLY3VCL0dBV1RETXVubjV4UjBSeldhci9pdVE0ZkwyWmtiMTM4?=
 =?utf-8?B?WGllcGdNd0ttQUFLbUF3MVZkaktYeVRuK0ZNKytoa1ZyVXQxUUxoaTVPMjhK?=
 =?utf-8?B?S3U5b1NVaGpsZ2Z6SnNjaW9EL3Y2ekxmTmZnOGVteHBCS2FGbHFmcU9nRytm?=
 =?utf-8?B?K0RLSXJHVXI3YXR2TjZSTDhMc2QxRSs4cXlUUTluVnd2UFhVNHRwWXVySExH?=
 =?utf-8?B?WXRjZVMwVTh5OVRoTmRWQlBxbGFhaFcva0JBZ2FwWUF5M3VSQSs0dGNRdkRH?=
 =?utf-8?B?RmJQUndRcGdxMlhCbWt2VmFhbUNJcTdPQndzYVFRT1o4TXgwbWtQS0xiNUFS?=
 =?utf-8?B?a3NvanhaTEE2ZWlDMS9VWElKK1IwL0RpTlN1Mk16a1JJM0tZREtJL2JVNTNz?=
 =?utf-8?B?WjVPTWxVZWUwcmMwSnBhbTBQNGhkeDQxZlY4dDV4VlNWSEJueXpJbHkxMllk?=
 =?utf-8?B?ZFhyVUNKM3Q2a1FYQ08zdHVIZStWTkQzR1lvaVZwVXJTd1EyUFM5ZDl5RDVy?=
 =?utf-8?B?eHBMS2tmWUdiYzAxa3JpK01ZTDRkSmN4RjFqUzY3VjVnNUxyV0J3UGxMRC9x?=
 =?utf-8?B?MVNTUHRMSU5aU0dqaVN6eFJwd0xZWkpRYjJxOFJYcTdGRkxrcGY1R2tqR1J5?=
 =?utf-8?B?M1hpUDZ0OUVjb0liT1VFZ01GNTNoUUtXRTBDc2tDbzg2VDlMM01tKzFuUGlr?=
 =?utf-8?B?OHFlUmZBckNES05BWDBZZHp2VU9TRm9YbUdVVzNaNUhWelRsTW5qVmtkckZ6?=
 =?utf-8?B?OEFLb281QXdNN25ZMkJHRkhHMHZsSm53Ykx1L2tmbDFWZ0JjYUFsVmxsWTVD?=
 =?utf-8?B?QjliK2lGQ3d4Um5vRG9YTUZPQ0hRL0pyem9PZ0ZiMGZmeXZ1V20yWTUydGoz?=
 =?utf-8?Q?HFPSsN0wAxDm2y+T7BNnMUin9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0006043-5f5c-4fc4-68d4-08ddeac07afa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:04:17.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+aTP33CiLzgtLH6L1GSDIP9NCBuTXNDnebW9Q9mF0iuN6iLGzQU36aN9OYdxvsTVJsYOLdC7sulw7Z1o2ISnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5121

Hi Slava,

在 2025/8/16 03:49, Viacheslav Dubeyko 写道:
> Currently, hfs_brec_remove() executes moving records
> towards the location of deleted record and it updates
> offsets of moved records. However, the hfs_brec_remove()
> logic ignores the "mess" of b-tree node's free space and
> it doesn't touch the offsets out of records number.
> Potentially, it could confuse fsck or driver logic or
> to be a reason of potential corruption cases.

Patch looks good, and I don't object to it.
But I don't know what dose it mean

'it could confuse fsck or driver logic or to be a reason of potential 
corruption cases.'


What cases?

> 
> This patch reworks the logic of hfs_brec_remove()
> by means of clearing freed space of b-tree node
> after the records moving. And it clear the last
> offset that keeping old location of free space
> because now the offset before this one is keeping
> the actual offset to the free space after the record
> deletion.
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> cc: Yangtao Li <frank.li@vivo.com>
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/hfs/brec.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 896396554bcc..b01db1fae147 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -179,6 +179,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
>   	struct hfs_btree *tree;
>   	struct hfs_bnode *node, *parent;
>   	int end_off, rec_off, data_off, size;
> +	int src, dst, len;
>   
>   	tree = fd->tree;
>   	node = fd->bnode;
> @@ -208,10 +209,14 @@ int hfs_brec_remove(struct hfs_find_data *fd)
>   	}
>   	hfs_bnode_write_u16(node, offsetof(struct hfs_bnode_desc, num_recs), node->num_recs);
>   
> -	if (rec_off == end_off)
> -		goto skip;
>   	size = fd->keylength + fd->entrylength;
>   
> +	if (rec_off == end_off) {
> +		src = fd->keyoffset;
> +		hfs_bnode_clear(node, src, size);
> +		goto skip;
> +	}
> +
>   	do {
>   		data_off = hfs_bnode_read_u16(node, rec_off);
>   		hfs_bnode_write_u16(node, rec_off + 2, data_off - size);
> @@ -219,9 +224,23 @@ int hfs_brec_remove(struct hfs_find_data *fd)
>   	} while (rec_off >= end_off);
>   
>   	/* fill hole */
> -	hfs_bnode_move(node, fd->keyoffset, fd->keyoffset + size,
> -		       data_off - fd->keyoffset - size);
> +	dst = fd->keyoffset;
> +	src = fd->keyoffset + size;
> +	len = data_off - src;
> +
> +	hfs_bnode_move(node, dst, src, len);
> +
> +	src = dst + len;
> +	len = data_off - src;
> +
> +	hfs_bnode_clear(node, src, len);
> +
>   skip:
> +	/*
> +	 * Remove the obsolete offset to free space.
> +	 */
> +	hfs_bnode_write_u16(node, end_off, 0);
> +
>   	hfs_bnode_dump(node);
>   	if (!fd->record)
>   		hfs_brec_update_parent(fd);

Thx,
Yangtao


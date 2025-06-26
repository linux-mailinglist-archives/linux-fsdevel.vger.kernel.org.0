Return-Path: <linux-fsdevel+bounces-53062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE1AE9701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BFD7AF0B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85923B634;
	Thu, 26 Jun 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Q51raUa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013041.outbound.protection.outlook.com [52.101.127.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3016A94A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923754; cv=fail; b=fBni8UA8wwMm0Tzo2/MPjKcm9ZdIz8x7ICwufNonH36S4jTmhAw5iE7SWqtJfcye5wxp3wAuKDvM9tRdgQ+YDLSv5LXWFzzN6qRqmfQgNnb+Gr3VqNone0iO3FV3ulq+IjsrwB+7ajcXH2UKfmi/TLtYdenr0DlgrH7sv8/tgjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923754; c=relaxed/simple;
	bh=Whhv/7rak3RyFzioaccoe22cWLA6/AygmvO+Oahig08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sRi+u4ZUvkJeS8hNJxng2NTCt/r3JNq213IDmqjyD1cnDtCZM/AIdDQDFIVQyLzyXoa8snv3bsttInDKnWwd8cmIY4V5Dv49vSnQYRGM0RVST73DqJRRdf2i/e1k8yHfOlmGvTlwFWtGwv6X2aeFBwodPP0H1dkiocHu42mwZyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Q51raUa9; arc=fail smtp.client-ip=52.101.127.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+hZLz6XOBqltZwpsFih7q4uHO782SaXeRIX/yYr8zV4gM7/GZC/7p69vN+4j9dAZEFSuUWCEQ/XyI7MsWxLjE5n7nPZgMsvYcXz/Xa0E4RZGmb/lhXJGF1TDa+87h4Ml1O5DyRZf7JMtKGGNmHiXVRK1yCcg8xmvdmXTBCDRD0pZfSO0ppVBVY4I2T2WBA61esVtus6lJ9ixk87XyJ2n//HZPPf0EkAyXcxzwhmRcecmkWCJW/B+b028yP/GY/qcQPCE+CN3/IsI0BKZ2cYqW9APxXe66G5S6kIcY/UqfDF1f3kMET4ycX/QCL0VtPvOcKuf91iYER5J/l/asqyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HREvyq9kKVqr1nqhPoYSL0gyolOS+vAFcBHq4gVrf0I=;
 b=Q2905RCXjOljpFgkAH/nSvmctKw7rjkbgYMzisomwdiCI1szg6HjeVQ7kM3BgBrNCOEna0/jQwglPzn8vHDyswJEsH779ZMUsqBhcUfQMHnXr+3eP67jdhM1EMcdEHSEESe1fQLIXqdMyV596cuVHn2wv+SnWeqntKTI2+WXFnrb3l82Z4lZ5QeKnXqlDWJJZig+ENDrmv2qKjkjrQiIGR1Ck0YjjH7hfrIfBgyl7e+kz+LgZf4agsPS680G7wjPKlODShe8eyYzu8oEB8irpsJLopyUV71jfU6HR1eWrluBmUtWqHAkBIKtJjygsWHJKIeD1MFxlBOA/WUhSS/noA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HREvyq9kKVqr1nqhPoYSL0gyolOS+vAFcBHq4gVrf0I=;
 b=Q51raUa9kS+9P3qdvXAKlhH7dIm0kaRouz/x5zTYdgduqUWEOL/FlQigzWZn7r0CEsYOXZSiU8dPPpU6IuX4WYTr1P9jFEuiVJrAyBuaJSitMmau4wZX4mAC3qThK1lMCG35nKf0gmePvK+w0nmpznHXnKcA2BMyBMgSTtoHk50xFEkRBUCm9tdU67+WS2f49C5I0g/eZivNxO/dtVT8n+HZEy+e2mIn2LNa1CKIRIRTKxG9zjmCM6COyqj2SbXig0NTRjp888h1Nguosr/gwLpeylwSH6cksOWmCnmj9uup+nUAxUm4MmohD4VGNmkI2QTv1cpDvtQtOSWD6lkGng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6738.apcprd06.prod.outlook.com (2603:1096:990:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 07:42:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 07:42:26 +0000
Message-ID: <6c3edb07-7e3d-4113-8e57-395cfb0c0798@vivo.com>
Date: Thu, 26 Jun 2025 15:42:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: add logic of correcting a next unused CNID
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com
References: <20250610231609.551930-1-slava@dubeyko.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250610231609.551930-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cad5064-e4d4-46d5-e9de-08ddb484fe79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3p5cXZmblE0c0RncFF4Ly9hdGVCeWZURnFYK3U3WkZROUphb1FOSElKQ3Jk?=
 =?utf-8?B?NUk5QUlZVk9TSlhtcURJdzQ0amlPdDQ4ZUJNMkFEcDY5SlZSRm01OVUzUXFZ?=
 =?utf-8?B?bTQxSElCK24yODM0Zy9rNVRuWTdKcjVVUy9MWU9xcEkwYkdTWEp2Mm5yWUJR?=
 =?utf-8?B?VEFCR3dOOGNuOHRtUzlvUEs4UGVYMmZCY3dMaGtadml6WHhBMlAySVdYMDRo?=
 =?utf-8?B?OURjeUZDRDFPR1VTc3o1azJuOFlSVEloZlVjRjlxTUhRckJ5N3lFYkZhSWxQ?=
 =?utf-8?B?UCtjNE1LeVdpTzB2THVnSkVEbFFVZU9jNUJ2V2F6RG9pZUNidkJnWGh5R3d2?=
 =?utf-8?B?MlRlNnJRS0x6SEY4aDdnd0x2TEdlVEdkOSs4M2VrQ1ZxcWlnSE15L1MvZUlB?=
 =?utf-8?B?Z205Qmd6RlRSeXVWbUdMc3RQajRoWHZ6czQyREg2UUFCVXF5NjViQ2M0ZWtu?=
 =?utf-8?B?Uzg0VklLRlg3cmRMZFVUZjJ6VkxybERaVSt6a3JHbGxtb1ZSeUcwTWEwVVJK?=
 =?utf-8?B?Ti9rRmcwTnZBNjRzeDhJS29PUWdROG4xSXZtM0hpYlZad3NUU0F5ZU5rTDdC?=
 =?utf-8?B?WXgzV3lyWDgrdTd6Nk4zcEh3cldCQjhrcVVQY2RmZzR4eVNDbmFSTzdhbFUy?=
 =?utf-8?B?VHd4U2hjQ3d5M3BiV0FsSmxlRFlkTUwyYkZIMWVwR3lkWTdFR09nSkg5eXJ5?=
 =?utf-8?B?emVhbFVVNXpuL0NSRWc4UEdYQ0psREhFeHNrN0YrT2tzVHFyTHZtYjMyb3R3?=
 =?utf-8?B?ekgxaWpZdjN4V0h0QWtiSHJYM0pETGJMdWZhVDl0WHFmWVBCVGJSTG42anh2?=
 =?utf-8?B?bnhTRUlGWUVsdEJFQVdLSmp0VjdPY3dKb0tNVUdmQWYwYlRoMWtVQnIrbnBE?=
 =?utf-8?B?TTZCNGxvek1zOXI5dW40RGpvN2RGWWRkUmNjUGFENzFvZzBWSUZBSmdYWmU4?=
 =?utf-8?B?VEh4WFFHWEF2bmxjZUpIblpKRVB5RHJZZ3lRYXhzamRSazhvVGFON0dpaVpz?=
 =?utf-8?B?Z3F4ckpqL2hUcGlKOG85VExiTStNdGUrTWw0aWNNdmVURHBnZ1IyN0w2b0U0?=
 =?utf-8?B?TkJpQitUcXpPQXY4M09hWnk0ZTRyNUFJOEFWbFNHVmhuczYxcmhxNGk5TVh4?=
 =?utf-8?B?WndhTXVvZjBHbzJOUWxaWHNqbVhmN2pkclExbE5pTkYyaGxWYjdod3h2MWZP?=
 =?utf-8?B?TzZtdm1RWjcrVlJYVUdmaVZsbVFHNkZxYldzazZvb3NyZmRZTkdBWUlnQmZB?=
 =?utf-8?B?OXJTTkVyOHFGclcwcXpteWdRK0RyenBERENUdzZNdk5oNmcyZE5JbFBiU2NP?=
 =?utf-8?B?K2Jocmo2RTQzNHhKRVVuMlB6Z2lvZ3g3ZStQdkliV0ovMGl2aW1KekpsY0lm?=
 =?utf-8?B?SU05T05aQlhrRnBQd25jeCtlS2tnWTArejNoUC9PTHZHclpCZzYxTyttMnRy?=
 =?utf-8?B?ZEVCbWVvLy9QaDRZbmNVNFBBV2lTVitoZnhkNXQwUFA3eTY4dUs4ejhpYTFY?=
 =?utf-8?B?cjFQZ1dCM3BJbVF3bnQ1VVUxcVFHVVdQSVVPcTh6b1BjVlpRNUFnTzQ5RGZ4?=
 =?utf-8?B?OUJWNGhKYk1WSGEvMjhlZVFGbnFVRjNybVRMUkhXNHJBNzlQaDBoakd1UXJz?=
 =?utf-8?B?SDBtNk9oV3ZGYlpDV04zMVk4d1dQcHhqeW9hMEQ5VERZR0R0RkwxdlpvMVJt?=
 =?utf-8?B?bHFOL1RHMko4YWtMMXJTdVc5RGY1Ky9OdTJCY3NDdGRTTmh6WlVyS3BvRWJ4?=
 =?utf-8?B?YUdRaWtoRW1aNXRpZjQyMFdvbzdDY3EyQlFiWlRKRWkyUSs2dDVQSFNGVlhs?=
 =?utf-8?Q?L2IvQdGx5Id9o64ql5+/fnfhjlQbjkyivA7gg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emxXQks0Mm95SXRrdWtMbkdIeW9QSk1lM0UzcTNybVl5NXBvK1BwaTVvVmxZ?=
 =?utf-8?B?b3RlWTFQZ252V1J4VzhSTEJzWm44QU8rUU1uMVg3NDF5ODFRZFRaUVBNdmp5?=
 =?utf-8?B?d21xMnd0YmY2NlNoa2VRd3g2bC84SG5uM1IxWmFTU0w1bitlQm9tUCt0L1BI?=
 =?utf-8?B?Yzh2Ky90VFpYVjE1UzFydGVTS2t6Q2QvaE9hR3RobDNXcEt3K2Fyenp6Tklx?=
 =?utf-8?B?cnJxTmIzVzFHeWRFcXdTaHdkQS8xWVRodG5ta0wxM0lyZ3Z1aFpvbitZRGd3?=
 =?utf-8?B?WTJOYVJVT3pEWWpBRzg1SThzTXd0b1VsWjRZeVpjYkYxeTlRN2hPWERWSnFp?=
 =?utf-8?B?N3piZW5pNzM2bUd6alBwVDlZa1JPTkFsTHBIdkduNnpwdUJLMWcwdTJuZnYz?=
 =?utf-8?B?L05hNHpoZER4WGxrUFVNeUNyTmR6eFd0R1g0eDFoRTh3dlYvV3lxRkMrRjQx?=
 =?utf-8?B?N2l3ODBkUWE1enJoeTlCdkJXdVFSNWh1bEd0bmFSNTRZSWxqU3JwRFlYaEVh?=
 =?utf-8?B?UXhHUGhHMmpnSXNZaVlwRCsxaElGdi9HQy9kVWJBU1FJTmI4dUVmS3g2WWFO?=
 =?utf-8?B?RmxMdGk0N1NJVnA1TDd2ZmJzNVhUeWgwV2x2OEZZZ2kyUzVuU2VCbEtYYnp0?=
 =?utf-8?B?cjdhTEZtSklUL1orR3VxMXA5VU1lS3I3SjR2VzNvRmVEdGZhdlRuRjdIZDhJ?=
 =?utf-8?B?bFU0MW5nYS9mREdCS05EZ3Q2aE5ZaTV6eUtWeUVLWHZqU0FWM0ZXNU42eGxS?=
 =?utf-8?B?dVlXVUcwN0tMQUFJekowNFJuWHJnbFRld25oRk1vY1FFNlF5djVSTzA2aFpY?=
 =?utf-8?B?MDJhSTN6YlVOaXJIcGNLWGFtbUh1R1d5b3lnSUUyc2w5Y2NyTWh5Y2FHWVFB?=
 =?utf-8?B?Y1Q3b2NKR2d4OHgzZ2hqN240UEhSTWJsNGdWUTlUcXJwSG1IM1RJbmxseTRx?=
 =?utf-8?B?MEFkd0MycVY4alIrYkhEcHBJRHBiKzM2aXAydTBNSkJPdEI4Y1BWWVJGbjg1?=
 =?utf-8?B?S1M5NGNWVzF0ZUNSbTlCaWJocVFtOEw5V1NUaGhpNVVLT2R3WVpmR3E4RHU1?=
 =?utf-8?B?NEFJSjFYWGx6d0ZQQ0hDYVgzOHJLWEtwOUVhUnVUQWFrOHlRYy8zYlYzSHA0?=
 =?utf-8?B?Smt6b0pFMHZGY1BOUWVNNlQxWXF3cnNpM3FLYVRHTXM0MldaRVhoRkFIbTcw?=
 =?utf-8?B?aUp6b3k2RUJydnRnWHhYTWdIbjZpcU5WOWNwbEdFbktLNHhXZmxDbXRxaW5P?=
 =?utf-8?B?Qllxd0F3Mnc0MlhXbDc0YlpyNERIczhwNHRtSitJQTAxY1N6Zjl6dVVkc3ox?=
 =?utf-8?B?ckRacXhkd29GS0NlWlk3QnpJSWdWWksrWXNGQlI0SDJOQUErQVVITVhpLytW?=
 =?utf-8?B?c3c2cEF0SFJsTlRKOFBxOUQwWEtVcll1SldwMzRRcEJaYWdtdndCT0taTlFh?=
 =?utf-8?B?VFFyVjRNRnZwVDFnWVJDVGFFK20rQkVuVWhCWlhVcTBIVTBqb1k5Ujg2ZVBW?=
 =?utf-8?B?OHVIYUJYZGZIbTVuajBWWlV1WmhLRU5iNmpOcmJRdUxtVXIvMXhNSmMzRkls?=
 =?utf-8?B?WXF3TWFwTnFWb1EwMjRVVmNCODA5RFJjd1VhckJwMy9wRHo0Mld1S0NHZlgy?=
 =?utf-8?B?Z3NYSmlKek5jSm1ZL2NtRkcvYUN5ZEZ5clFKNVlaU29KYkRnZDIxVHF6WG1M?=
 =?utf-8?B?OXd6cjU0SjlYeVZ1ZmhiWWFsQkpnRVpMdzVOM09URGRUbWM1N3gvQ0lBLy9O?=
 =?utf-8?B?UFdDVUIrbE1wRVVtVEF0REZtUlhodDNCaEpnM1d3YXo5Q0JwM1p3Z0tXQ1ox?=
 =?utf-8?B?S0FXQ1lLQU1kZDV3ZlVIS01mL2l3YjFvOHRJZUpHSTRTTmFQU25UQzhmNlJ0?=
 =?utf-8?B?TWZoeW1ubXBGazVaSS9YL3RyV1ljMTN4UEhIaElUOXJ6Y3hVQmQ5RExhbGQz?=
 =?utf-8?B?aVJMY2ZkL00waWMvZi9rb0dYNU1xRUptOEpTUTEySkNMbm9oVHp6V2VRejVu?=
 =?utf-8?B?VHlFdERhUFpSd3NlajlBdlk4MW5ybVJaYmlkKzhwYytBbVVkeEF6MVIyOTAr?=
 =?utf-8?B?MG45UWJDdkRvVDcxK2c2azdUTTZPczVzUXpGRW9TSmtJbmIvU2pKdElzOEZN?=
 =?utf-8?Q?uLCAv4IjFoSZ0bzhqsJDT+ybm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cad5064-e4d4-46d5-e9de-08ddb484fe79
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:42:25.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/n/1ll+BXv4+V/G1wqZwEFeoXfr4+t3DjrsUBmn+3IS+QgUdkmJhSIcdoDcFheOv97IljspZa2zST1ey5Eptw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6738

Hi Slava,

在 2025/6/11 07:16, Viacheslav Dubeyko 写道:
> The generic/736 xfstest fails for HFS case:
> 
> BEGIN TEST default (1 test): hfs Mon May 5 03:18:32 UTC 2025
> DEVICE: /dev/vdb
> HFS_MKFS_OPTIONS:
> MOUNT_OPTIONS: MOUNT_OPTIONS
> FSTYP -- hfs
> PLATFORM -- Linux/x86_64 kvm-xfstests 6.15.0-rc4-xfstests-g00b827f0cffa #1 SMP PREEMPT_DYNAMIC Fri May 25
> MKFS_OPTIONS -- /dev/vdc
> MOUNT_OPTIONS -- /dev/vdc /vdc
> 
> generic/736 [03:18:33][ 3.510255] run fstests generic/736 at 2025-05-05 03:18:33
> _check_generic_filesystem: filesystem on /dev/vdb is inconsistent
> (see /results/hfs/results-default/generic/736.full for details)
> Ran: generic/736
> Failures: generic/736
> Failed 1 of 1 tests
> 
> The HFS volume becomes corrupted after the test run:
> 
> sudo fsck.hfs -d /dev/loop50
> ** /dev/loop50
> Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
> Executing fsck_hfs (version 540.1-Linux).
> ** Checking HFS volume.
> The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking catalog hierarchy.
> ** Checking volume bitmap.
> ** Checking volume information.
> invalid MDB drNxtCNID
> Master Directory Block needs minor repair
> (1, 0)
> Verify Status: VIStat = 0x8000, ABTStat = 0x0000 EBTStat = 0x0000
> CBTStat = 0x0000 CatStat = 0x00000000
> ** Repairing volume.
> ** Rechecking volume.
> ** Checking HFS volume.
> The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking catalog hierarchy.
> ** Checking volume bitmap.
> ** Checking volume information.
> ** The volume untitled was repaired successfully.
> 
> The main reason of the issue is the absence of logic that
> corrects mdb->drNxtCNID/HFS_SB(sb)->next_id (next unused
> CNID) after deleting a record in Catalog File. This patch
> introduces a hfs_correct_next_unused_CNID() method that
> implements the necessary logic. In the case of Catalog File's
> record delete operation, the function logic checks that
> (deleted_CNID + 1) == next_unused_CNID and it finds/sets the new
> value of next_unused_CNID.

Sorry for the late reply.

I got you now, and I did some research. And It's a problem of CNID 
usage. Catalog tree identification number is a type of u32.

And there're some ways to reuse cnid.
If cnid reachs U32_MAX, kHFSCatalogNodeIDsReusedMask(apple open source 
code) is marked to reuse unused cnid.
And we can use HFSIOC_CHANGE_NEXTCNID ioctl to make use of unused cnid.


What confused me is that fsck for hfsplus ignore those unused cnid[1], 
but fsck for hfs only ignore those unused cnid if mdbP->drNxtCNID <= 
(vcb->vcbNextCatalogID + 4096(which means over 4096 unused cnid)[2]?

And I didn't find code logic of changind cnid in apple source code when
romove file.

So I think your idea is good, but it looks like that's not what the 
original code did? If I'm wrong, please correct me.

fsck for hfsplus:
[1] 
https://github.com/glaubitz/hfs/blob/linux/fsck_hfs/dfalib/SVerify1.c#L3242

fsck for hfs(which is quite strange):
[2] 
https://github.com/glaubitz/hfs/blob/linux/fsck_hfs/dfalib/SVerify1.c#L3361

Thx,
Yangtao


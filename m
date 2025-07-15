Return-Path: <linux-fsdevel+bounces-54924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BFB05474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C377AFEB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0C2749FE;
	Tue, 15 Jul 2025 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ontBzc2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012021.outbound.protection.outlook.com [52.101.126.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3626FD9B
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567303; cv=fail; b=j+4OywNVEvkAxGFDXGokGXSGYMJpnMuIZR33udbMeWiJi1iaivtRQipkKuF0m2ptJot/SPCUNtUyiYPJShnbS1CBVd5kVY3agTyLacBexZT4pzVdp45ZLx5gPQ+3g2LdF10O1/8ai3TKkRbvD2xhxPzdIgprx8uhPTLpTaaan28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567303; c=relaxed/simple;
	bh=C8G854hKhXUZpiIhQqPnOG4t0Bq+0EVoQwpnTsaU01k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AR64xr3Leunm0kui8FUa596TBsqpadniQ6+UryxZGhfxWfEneofz/JTZusqycVRiVGotmzP844es0ParbDgkl0Xs9j49+qg+s1vGpv5cK3OakZCDX6cRsEK4EyY9eP675nkN9CWOlWr1Kf6ZLwa6+lHDlAKPYtbihgHuoqUzC/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ontBzc2w; arc=fail smtp.client-ip=52.101.126.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubN4ZMtlsamzdbcwBnLwu3choJwsASA402HcrjH0XmJ6RPruxt6IUPtzHazPz46LjoaduWzLqbPdYqMpaAGBw62bE/jlH0nlL0xiM5uT9vNV0BonYjwqANoB4BwfFfixV3R9pkHlmexU565arZlgIuyRw7E0NuN12jw2cKa/HofYWLIupCyUyZgsvcXZ6OvTmtqsmowM7hAPrDSWWVDAZfF9aTDXyLj5kGilvND2CV6gNH6Ue1DYo9mnpfqnBu84nHHb7VQaL9VqtMdexdjwUN1TQjMzIMV1u1QvYbgZwyMg5xdZQWElQ2mISMmqSp7GJdfn5nxd/ep4TYUQeHm2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZeEQfVM+l/Bp6RvGPhyOpU8PXaW6Xak3js/F+SrT9Q=;
 b=LZYgi2zYtwkPr+wIh7S4wTLT4/a5y6ls8JSs88tDd9PD3ftriENB2Nk5LKPQMYw+6erWwr57RTqGRc4NVOI6mRl0SDO7dZZy62tjxogD8UlZaTaJcLVzsh7qeLg0+52bs4FjkbZtkJuxOGDqsllFRmM7o1uy6dJ1O1CNIcNuyb7zie4T1PpB1KyomnOAPseXCP/W6E0kxsFX9oT4KKkKoZgjqH5RHADK44+Fsi4A7XTE25LTuOOaypxWu6Snwv70NDv/Xk5JMHWtOl705qUzn5z05koq+EW4CFT81kvgadtln70Yv1025D6+GMrgWuHt4UjvJsH3u27Qv6F2ddy+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZeEQfVM+l/Bp6RvGPhyOpU8PXaW6Xak3js/F+SrT9Q=;
 b=ontBzc2wk0nBlRSwO/EXvXGcSkaWSL+SxDuJ3JTl6/gTD++OM1rTsVqUu/5PiTE3q6/22fBk23PvrQFxtoJQkn/huEmRWrWu1nipCYJ7kiKMen2vVQx3SFH86gWgbOnlKSqMjxHU28qd5hHNf8tTPwzCfnpyMQR+5t9ZuMMkuJko1glFfu9HNjOKY2MSRTG0J57cfHjFJuHm4dRttrZPhwuxQNIhIADKIKW4ZIS+O0KepvYIc0eEcNvf/hrbRPiKn5ptFGC+QOEliKfvJkpu6WyfW4aoEjMfGWTGVn2wtxWCrodJfh2GccHvilUZORcKjc0ueZdFAy3xpTNmUdSphA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KUZPR06MB8026.apcprd06.prod.outlook.com (2603:1096:d10:4a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 08:14:55 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:14:55 +0000
Message-ID: <ae8ea217-92c6-4294-a8ad-3414893d927d@vivo.com>
Date: Tue, 15 Jul 2025 16:14:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: add logic of correcting a next unused CNID
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250610231609.551930-1-slava@dubeyko.com>
 <6c3edb07-7e3d-4113-8e57-395cfb0c0798@vivo.com>
 <3025bb40a113737b71d43d2da028fdc47e4ca940.camel@ibm.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <3025bb40a113737b71d43d2da028fdc47e4ca940.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KUZPR06MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 15376494-e3ff-494d-d8bf-08ddc377adfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE1oTFdRcEQzSGhBM21mZGJERFNud1BZeG1yK1VIR1l0aWtFd1padndzQUNw?=
 =?utf-8?B?eXp2azdDbVlSZEpvRkl0M0FhZHFxa1BFNnkxNGJLaXM1aFdLdFJUNTBWeTQ4?=
 =?utf-8?B?dFZqZEczd3U1ZlpFc1N6TEJSZHg5MmphTnVUelVIUFBJSkpYdGx5OG44RUc0?=
 =?utf-8?B?VlQ0UGRJWmVnbk8yVGhyMDVvSGZqS1k3S0ozekJWREkxakFMMUZNMitQZG9G?=
 =?utf-8?B?VTlrTGZzaDEyanhHL3pUSDRXY3VCL280RU1CVGFJRGxybExaaTZRT3JrVXg5?=
 =?utf-8?B?RGk5MHFxSzliNlNwRVRPZUgvUmN6MU9PTnV0Vi9vTU9RbE9jN3JrNGl2eGZR?=
 =?utf-8?B?bCtrTzBob1RLeUdaMnhUdnNlcmFEandOZHdDOW5tZmQ1bG4wSStmMmoyZEdB?=
 =?utf-8?B?c0NEUEFUUGNhUlRVUEl4ZzFibnRKaU13Qm5qQlpub2lUYjdBMDZGNTcrR3Yz?=
 =?utf-8?B?OEhvNDliL011WlZORGRBNlN0WTZSQ3RTdUtneWJjSGR3Z1Z4WVh6VEhsSm9W?=
 =?utf-8?B?UW9QOUZxOGsyQlpYYTlhZnBCS0U5Wnc5bVBaVTMvN2t3eXBpZkNyVXhKV0Rm?=
 =?utf-8?B?N05wRnlXQ3kyMjIxRitpSWdjQjUwMVpNaEdxNXBHZXIyQ2NqZGxucG9BUHla?=
 =?utf-8?B?VkxiSDhhL1ZoL3FhYiszRTYvak9NWTdXM1JBM3BPOXgzWU1wZFZVM3JrSTZM?=
 =?utf-8?B?b1JsT0tESkNVSnJ2eWJzUGxKQjJYRVY4NlAxT1lhQStvNUxnVDUwdGZlTnZi?=
 =?utf-8?B?RmhLU1lFZTJ6elQ4OHJueDJaUk5DOUNYaE45dUJTeWRaaFl5ZEpaNmZVeHVv?=
 =?utf-8?B?N1JacWM0ZWlvQXRQWUJ3U3JRRFordXdmc1FYNXRHL0tocitxVmUzZi9qNzFz?=
 =?utf-8?B?cUlKYUVZazQwODZhaUVaVkwwY1JIN0prSDZnZDlQaHFiQ0M1TllTT3A2UUww?=
 =?utf-8?B?UUM0amNjMzhCSldINmlTQ1g0OHdRSTVHTm1mUmlBclZoZ0hwNThyRzFzRGF4?=
 =?utf-8?B?Q25PbTBkMURnUXd4TVQwQkM4ZVBXeTU2T0txZndRUVd6MDFLUk4vcGpZZjN6?=
 =?utf-8?B?TTVvbWt4TmFQK1lzR1FVWkwxYTBFUVJseFRNSng4OENnYnRobXA4WFZMZVV3?=
 =?utf-8?B?YUlFcUxiTWN1d0dNK2hjQlJzQnZBYm1mVFdpcVk0QlR6TjN1YnkzdUQ0dmp3?=
 =?utf-8?B?dDI2dVJPOGtqRDN1c09MWmdNb3F1U0Uydzk1SVhRZi9xdUFuRzNEanlvcVZC?=
 =?utf-8?B?c3VZanNwSFhkVFlKcEdQMHd4bzBCVVJjSm9yRm1aanEzT2FMbE4zVFBVa05h?=
 =?utf-8?B?dHdzbUxmN05GeE8xSVY1eTVaeFBwL2FGWVJMb0x4VDZZRFBkN3NDeW5kenhq?=
 =?utf-8?B?cXo1SDJ3QUZpc3NwUWhmUFQxd2czN3hEdkRhM1BrdFZCcEVKRG5mWkNBdG5G?=
 =?utf-8?B?T3lLeTRxMk9JQkd1bUdIT0J1bXI1UmtNTUU2S0ZOYnhFT3JvbVdpZ2l4QlRj?=
 =?utf-8?B?TDJUZCt3bENhOExyUTdrajQ3OENtV3VjNlZVTkJVQ0dGY0Z2blo4UkpETWdX?=
 =?utf-8?B?dDJKQmtZSHc5Q3prMWpaOVkwWTJGSkNhNnB5aFNSZDZ4WkhaRlllUnJOaGd6?=
 =?utf-8?B?SU5rWkE5NUpEN3pXNzUvczhqUVpqT09keTYzVzNmZWRya2xYZmdOUzVubUNk?=
 =?utf-8?B?dHc3bERSQ3NCTU5TMEJRQ1p2eGVpd211ZFhLenIwMmdKbXFKK2lnOUF4Nm50?=
 =?utf-8?B?dEphSElmc29UR3lHQ0pKa0NzZnJ3WWdBZkQyb2lrZVFNYkVoOGRvdU5NUW9N?=
 =?utf-8?B?NjFTSDNUMjZXWmJLSFpSMUx1YTk0TnZ1TDdnaWl3MFd1SDdMMVBwdzZhUVk1?=
 =?utf-8?B?b3BtTWZMYzlBc280anZQZ0ErZXh2MlptaEdld3l5WTI0WFFqU0JXb1FkVWJa?=
 =?utf-8?Q?pVbMZWxhK+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1NZWFVwNzB1ay9SNkkzTWVZNkxwdzZkUVVwOCtINmtSUWJKWGFaZC82MW56?=
 =?utf-8?B?NkJYYUlpdGY0L1Fvb2szZHdtV2ZNc2pSekZZKzFnVU9ZaVZIOWloV3UxUFk5?=
 =?utf-8?B?UGd5NEhEMHR1akdDcnVKSzR2VWdINUVNZkMxZmR6cGlLYUlFMzB3TWxUMWZu?=
 =?utf-8?B?MHFjM3FPVUMwcnF1U0VDaThQU1diaHoxUVdzSTkvdkNWL2VUbDlvY3NTQlhn?=
 =?utf-8?B?SnRJNlRvUndFRXNkTnBtOUFUOUZZUURXL21DVVo0Rk16R0F5QTBiK0QydjBl?=
 =?utf-8?B?QlpJTnpVVEtsVDl4dmdxemQ3cVBLdVU5M1hzL0J3cmRaNllyTEFIM1JPM1ky?=
 =?utf-8?B?b2NsNlc4ZStuc3Jzc2xSSEpYWVpMckZiampudXNta1hGeW5kUWpLUklYWEN2?=
 =?utf-8?B?ajZGb0J1UmxLZys5SHBocHFWRFZDa3ZQb1VneHJOcU0wSGJ5NWgweEZ1N014?=
 =?utf-8?B?bUhidkdaRytJOEk2ZlpwR1pmYmVWL0JSQ3BUanJkUmtQaFpoM0F1V1ByVXVT?=
 =?utf-8?B?bXo5TUJtNkdpN0VZQ2pOdzk0MmcxS1dLN2h0eHJ0cWx4ZkFOMDVhRUZZbGxn?=
 =?utf-8?B?Z2hCbXBlcHlnTnZ6Y09SbmhOVHJUY2ZnKzRJc0ZxZXNvck82eWUySTJIazlL?=
 =?utf-8?B?TitGZkp1WWI5OTV4d3l5dnNQSUJ6VE9BdmhLNWQrL01uNU1SdndnQzBtcjl4?=
 =?utf-8?B?cjdkZjUyMkpZNTh5d0FwKzdIUzZDQ2lwQzZSWk84TGRrc3JLbmVDNVF2OElG?=
 =?utf-8?B?azU4eU9RaXVVZ1NxYmNscG1KU1hocXZudXZINTNoUFVCaTcyVTRXaGduZ3Fv?=
 =?utf-8?B?ck0wMmtJTU1LSnFKeUlZSk1PZENNUTcydmZROHFuVksxOTRrcDZsMlNZTWFp?=
 =?utf-8?B?K0p1UTlsUy9OTDNwRk5WRUIzSU5naTVSeW1YQUc5MFJ1UTd2bWExbG5XNklJ?=
 =?utf-8?B?ZklRREZxdkVqckxsWEsyb3YwUS9lT1lEcCtCQzdXbzY5NEMwd3I1V2FzSnB5?=
 =?utf-8?B?R3JKdlcwM2NJWHBSYVQyVDlTdFMvUkJ0OXF0Nk1HK0pmR0d2MmxUL3J5aHFO?=
 =?utf-8?B?Y0hzSk5KNzBCemo2cy83WUt0VUc3ZXczQVJrZEN3ekcwMDlFR0dVMWdjbEpQ?=
 =?utf-8?B?RVFjN3owcnY0L0FrMk5HRktnOHlEa3M5SXZBWFJhTXcwQnRSVzNNRlZsQTdi?=
 =?utf-8?B?Tlo5WmZsYTVVNUhGa3lVYlFqRFNIb2t1aSthM0V3SE9NNUVlOEI5YnVtNVNs?=
 =?utf-8?B?YjRPWTkza3RJOXJkM2pidkVDRU1JOTFtS2FPeExFSlRsbm10bCtKMlMrNUUr?=
 =?utf-8?B?Mk9ybEhZMDNxVnRJYkNkTjdLZWpYRWVTQ01mZmYwQnBucTVYTHhFVm44cU05?=
 =?utf-8?B?ZGRhcDZLV3JoQnkvQUNrNWdFL3NTWDFYc2FKYzM3TXVBMW5BcURzcVdqVzNk?=
 =?utf-8?B?ODlNanY0V0VnTFRpK0srOHRtcHRFQzZveENqRjVHNllFRDI4akpxdDdpaVdK?=
 =?utf-8?B?a1lQZ1hUYUY0bzJUcUdrS2kwcXNCZ242NXpsSzBBS2tkdUdNaG42WndpRnhD?=
 =?utf-8?B?dkMzL3YwbnpBSXpGVlBPbUI1dXNhZ0JkOFJxY1YvK2tNaThodWxwY0JCZDAw?=
 =?utf-8?B?aGRXbmowd3NNY3dvOXFyc08vdXRLbnNDZ29PbGxNam8rZFEyRlo4V0FaaWlH?=
 =?utf-8?B?dDZIUXVyWkRRakFIUnk5Qzl4RWc2dVlOZHhqbkpTNzZ0RnJyQ25HWklZa0E3?=
 =?utf-8?B?OWpadklkWkFNdi9PbVN1a3U3UmVpVDBJTlBQVms2Q0RycTVmK1R2OGdyQUlz?=
 =?utf-8?B?S0xMcXhvNlJmYXEwdjEzMGR5dFEwek5tOTU0Mk5oc25RNjJJUVlFM01Ob0Qx?=
 =?utf-8?B?REtxZzN4UENPYjAxSWRERFRMR1NXR3ZQaThJSktJTFhEK3hTdzUrYk9xNExu?=
 =?utf-8?B?T3lSSGhubFJhZDQ0blluYndFZFN0YUgwSlVGOXVpbXBEd20yemw0L2ZtY3R2?=
 =?utf-8?B?d3hMR2tqWGRvZjNVNXZEdWR6NVRDUGpRRWlHN0pTN1NuL3JsU1VOL1V3WFJ2?=
 =?utf-8?B?SUJYWExQL3crYk1wWFRQa2hldjhRa0RvUFBkdEdoZ3V4OG9MQ2Rwd1RmM0tU?=
 =?utf-8?Q?COym/xYS2qSyUJ519zsw3pEt9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15376494-e3ff-494d-d8bf-08ddc377adfb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:14:54.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFoflmhao4ZIGzw1g3NvMKCHLYqJfqlHfS7Vp/zzL/SCCdOgFNShWHmoD5R5sIzEYNYLii46ZNmY1FfN01DwuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8026

Hi Slava,

在 2025/7/1 03:36, Viacheslav Dubeyko 写道:
> Hi Yangtao,
> 
> On Thu, 2025-06-26 at 15:42 +0800, Yangtao Li wrote:
>> Hi Slava,
>>
>> 在 2025/6/11 07:16, Viacheslav Dubeyko 写道:
>>> The generic/736 xfstest fails for HFS case:
>>>
>>> BEGIN TEST default (1 test): hfs Mon May 5 03:18:32 UTC 2025
>>> DEVICE: /dev/vdb
>>> HFS_MKFS_OPTIONS:
>>> MOUNT_OPTIONS: MOUNT_OPTIONS
>>> FSTYP -- hfs
>>> PLATFORM -- Linux/x86_64 kvm-xfstests 6.15.0-rc4-xfstests-g00b827f0cffa #1 SMP PREEMPT_DYNAMIC Fri May 25
>>> MKFS_OPTIONS -- /dev/vdc
>>> MOUNT_OPTIONS -- /dev/vdc /vdc
>>>
>>> generic/736 [03:18:33][ 3.510255] run fstests generic/736 at 2025-05-05 03:18:33
>>> _check_generic_filesystem: filesystem on /dev/vdb is inconsistent
>>> (see /results/hfs/results-default/generic/736.full for details)
>>> Ran: generic/736
>>> Failures: generic/736
>>> Failed 1 of 1 tests
>>>
>>> The HFS volume becomes corrupted after the test run:
>>>
>>> sudo fsck.hfs -d /dev/loop50
>>> ** /dev/loop50
>>> Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
>>> Executing fsck_hfs (version 540.1-Linux).
>>> ** Checking HFS volume.
>>> The volume name is untitled
>>> ** Checking extents overflow file.
>>> ** Checking catalog file.
>>> ** Checking catalog hierarchy.
>>> ** Checking volume bitmap.
>>> ** Checking volume information.
>>> invalid MDB drNxtCNID
>>> Master Directory Block needs minor repair
>>> (1, 0)
>>> Verify Status: VIStat = 0x8000, ABTStat = 0x0000 EBTStat = 0x0000
>>> CBTStat = 0x0000 CatStat = 0x00000000
>>> ** Repairing volume.
>>> ** Rechecking volume.
>>> ** Checking HFS volume.
>>> The volume name is untitled
>>> ** Checking extents overflow file.
>>> ** Checking catalog file.
>>> ** Checking catalog hierarchy.
>>> ** Checking volume bitmap.
>>> ** Checking volume information.
>>> ** The volume untitled was repaired successfully.
>>>
>>> The main reason of the issue is the absence of logic that
>>> corrects mdb->drNxtCNID/HFS_SB(sb)->next_id (next unused
>>> CNID) after deleting a record in Catalog File. This patch
>>> introduces a hfs_correct_next_unused_CNID() method that
>>> implements the necessary logic. In the case of Catalog File's
>>> record delete operation, the function logic checks that
>>> (deleted_CNID + 1) == next_unused_CNID and it finds/sets the new
>>> value of next_unused_CNID.
>>
>> Sorry for the late reply.
>>
>> I got you now, and I did some research. And It's a problem of CNID
>> usage. Catalog tree identification number is a type of u32.
>>
>> And there're some ways to reuse cnid.
>> If cnid reachs U32_MAX, kHFSCatalogNodeIDsReusedMask(apple open source
>> code) is marked to reuse unused cnid.
>> And we can use HFSIOC_CHANGE_NEXTCNID ioctl to make use of unused cnid.
>>
>>
>> What confused me is that fsck for hfsplus ignore those unused cnid[1],
>> but fsck for hfs only ignore those unused cnid if mdbP->drNxtCNID <=
>> (vcb->vcbNextCatalogID + 4096(which means over 4096 unused cnid)[2]?
>>
>> And I didn't find code logic of changind cnid in apple source code when
>> romove file.
>>
>> So I think your idea is good, but it looks like that's not what the
>> original code did? If I'm wrong, please correct me.
>>
>>
> 
> I think you missed what is the problem here. It's not about reaching U32_MAX
> threshold. The generic/736 test simply creates some number of files and, then,
> deletes it. We increment mdb->drNxtCNID/HFS_SB(sb)->next_id on every creation of
> file or folder because we assign the next unused CNID to the created file or
> folder. But when we delete the file or folder, then we never correct the mdb-
>> drNxtCNID/HFS_SB(sb)->next_id. And fsck tool expects that next unused CNID
> should be equal to the last allocated/used CNID + 1. Let's imagine that we
> create four files, then file1 has CNID 16, file2 has CNID 17, file3 has CNID 18,
> file4 has CNID 19, and next unused CNID should be 20. If we delete file1, then
> next unused CNID should be 20 because file4 still exists. And if we deleted all
> files, then next unused CNID should be 16 again. This is what fsck tool expects
> to see.

I got it. If we deleted all files, then next unused CNID should be 16, 
which sounds reasonable. In fact, then next unused CNID will keep be 20 
for both hfs and hfsplus.

It confused me whther changing CNID after remove operation is the best 
way for hfs. Because I didn't find such logic from apple's hfs code.

And only hfs failed generic/736, which related to fsck for hfsplus 
ignore unused CNID. Could we ignore unused CNID for hfs too?
Those unused CNID might be reused after setting 
kHFSCatalogNodeIDsReusedMask flag.

Thx,
Yangtao



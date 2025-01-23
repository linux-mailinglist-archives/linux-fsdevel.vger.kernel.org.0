Return-Path: <linux-fsdevel+bounces-39938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037A9A1A5E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E69188C526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED602116EC;
	Thu, 23 Jan 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="kXfFU3kM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF7211495
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643152; cv=fail; b=tU49RWmIalTyK3KUfTHqSgpfDX68ByoTZpYSWx8RBr6+KCkGSLWIqMucg2H0UQKES6RCAbZJJ9vxytgzE0T6LznJnWa7DkFU6Vyj/Fn34rbURgnlaw7aGCqTTw8+EQqEQ1ybKkOafccv0gTBbY5uk8MuMotHp6PhQvqHPNSV7T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643152; c=relaxed/simple;
	bh=97oqgGKH3TYuiZt6nfBhPWuDyXZ0KL7g9ei8OOoI2UM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ee5AR4mxV0kse1bSNLlBvoAFJmdFXdlXIj94rRfgJhxJFMrj7ye9EZ3f0X92F4dYQJglcfRn9+CSNkELLz/O6KNUzNF0mdH2gq0Jd38RhnzkCUWzzPWyTJe3UijqhdLokeQ03EV97i3XQICTInQLrDOiumdR7/6yEYVjEASa7yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=kXfFU3kM; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40]) by mx-outbound13-211.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 23 Jan 2025 14:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9YJJpNwUMbAbCqhOStW+04Q+DVDfPmQlbpgF7kXD7kaLEWQ3yNo+sQloVriS24NfHWV1JQG2wAE/QLZJphH8MWa5P8aLa9z2F65Oom9xp68MnK24Dlo44NzlHZ0Va7krHfgAmBZ+7Uxuj+7qLR/FRy9AewLfSf1xeWiaON+Do41LNKj7fm9YE6TgFLD+/LEDIWcUh/8hjXlZFCc4qpjDWw9RtrdzxpHPSjadsdFWeYbOuNAAZw8U0GpjTZlMgoL+XAYXwl/xSRAh1WHIXAabfF481wlEAm1v5eGuWUrF3EQq0EJtzmhsUulpd22H0DOD8Bb9edDBVffgStk7eftkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJB/Ohdc4U08SCgKh/zB95qcEjkDIN+KqWsucsZZvEA=;
 b=qe2CBF/MJ/teiNrGMtGUzoQG7wjqZyomuecGhCBKNaB8zcVx2GT21AmQc46eDf8dcGK4IZ6ooW37tkXaTTaXkB/Terh2O7Bjcmts/rbJ/IFC8MQ6K81tjHPTSJaMoLfLztwcjoLY4kGrq/mo6D858RGFmRbM4RS4KVaWRz3v8hlgjsq4pcg7Guz08rOOg/imylgDB6yuqnpAuXSYJNccRlzGXODo5csp4gVyKTix8jd4R+cyDiiM9ZBKYHJ6hytPwQ5/UR/v79A7EGFu9/AkKqHSfHPaPZLaDmiWi/inlxy8aufijbzBD1Md5MWBSd3BcHquUrfBuWziiY9SxMfFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJB/Ohdc4U08SCgKh/zB95qcEjkDIN+KqWsucsZZvEA=;
 b=kXfFU3kM+4ZCbqHsJBZG9WhyEoocZ4YYxOZLovoEobnsYVZ7NspMHolVzoGaBxuSJ5bdYlhDVo3uRhTEGQpciFdEv1eonjCeJYTfngv1TRTJssmfMzpbk18ZkaA0uNHkMiEZH9za5BxSjnSgfuDYgF8Nvp8TCSyP/i3l9ARzj4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by LV8PR19MB8700.namprd19.prod.outlook.com (2603:10b6:408:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 14:38:59 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 14:38:58 +0000
Message-ID: <4043cf99-7c8d-4790-badd-d3732536c504@ddn.com>
Date: Thu, 23 Jan 2025 15:38:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] fuse: make args->in_args[0] to be always the header
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <63469478-559b-4bad-9b0f-82b8d094a428@stanley.mountain>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <63469478-559b-4bad-9b0f-82b8d094a428@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0262.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::34)
 To CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|LV8PR19MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c9cbb6-6949-46f3-eeb8-08dd3bbbabc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V201c1FoS2dUV01EKzk2aXhOK0Fkai9zcGFkM2RNdmc0eFpNOEJxMFhRTkV0?=
 =?utf-8?B?UnRDKytmbFh6M1dRcmdZWWZVVGkyMWFqa1hwV3IxTlN2QllKc0NEUzBBYlc2?=
 =?utf-8?B?bVdNVFVDakVKWGNmdXRkeG5iSFN5T3FqTFJxYmFzcUMxS1RvbFg2RnlzWkFs?=
 =?utf-8?B?bC8zVk5iV3RpZGFwbnlNYlpUY1kwd2kwTVVMOVlZWm96TVg0ckEyTzFpWWh3?=
 =?utf-8?B?S1NnVnloRThKTzJXWkxiVHM1M0Nqemw5b2tOb3E3SmROdUU4U3V3VUo0Tk1a?=
 =?utf-8?B?L3RCdjJ5YjN2dGlOcGtFZVdtck9UZDIzdG1rdVhvcXlqdkx6VW9TY0RXeFVJ?=
 =?utf-8?B?YjN3Sld0KzVyN2ZCckJjSlRYYUJVTERoQ3JHaytMQTZ6aG5VWFNxdG0xY2hJ?=
 =?utf-8?B?QkFKSVQyRThNNUg4WlpPMEtSazgybnR2b2J4R21tcURnc1Z4dnRFMUNtVDVP?=
 =?utf-8?B?UzY1bGIvNm84NFZyUXNTU2FXMytEbDVxZGN6Uzk1b3Z5UE5NSDEzbFRrV1Va?=
 =?utf-8?B?a2lkcTh1Nk5sNzVyWGhsMzJyNmdpekZ0WTRCbkdxZFQ3OGZ0dDFTeEI3RG0y?=
 =?utf-8?B?T2IxTC8vKyszdWtpQUVNY2ZHSUNZTDdqL1hKeE1mcDF4WTVNRDZEdFVQMjhy?=
 =?utf-8?B?cnp1eUdHSU5LcjdHSDM1bzJuSGhmM1NOSjVYQXpBdWllS0dwTG5LdFcycDR0?=
 =?utf-8?B?YXh3V010cnR2WmE4V0Q5NHBqRGpXemNGN0JvRmh0UTMxY1lSSHd2THkyTElL?=
 =?utf-8?B?dU9oZ25abkFPcjEyaFJKWnFMcGtWakI5WXJCeGxGQ0xEYmhRS2Rnb2piTUdT?=
 =?utf-8?B?d1g1bGF2QTN1YWlrRFA3a0RTSTNGSXd3eTcwMDNUazJERWVJU1d2S25aeFpT?=
 =?utf-8?B?U2ZleXR5anROMGFnZDExTEloSUNSMG1pK2lHNytaZ3l4c3dod3U0TlAvYW9U?=
 =?utf-8?B?NzRRZis1U3FrUnVrZWhYOCt2WTkvdGJwU251MDQ4ekM5VmRGY25XV2p6TmMr?=
 =?utf-8?B?TmJnd2VCN2wzUHdRQ05hN2ZXZkV0N28wazl4Ujdhck9vcnh3U2Z0UFlsNG83?=
 =?utf-8?B?dkZDMFlPV3d6REtGSHZJbmwzZGtjc2thS2V4N2txK2NrUSsxZjg4SU5BdDdH?=
 =?utf-8?B?RXk1V2lRTUFxUDl4R2tTWXBvQ0pBMDFXT2YwdXMyZlIrWUtqdWNHREZZYzVr?=
 =?utf-8?B?MGUrc1ZYY2lFOGQxOG9tQ3NTaGdNYlEvSWo1RktSLzNMMjZiNTgvVnFNQkF6?=
 =?utf-8?B?TTdIb0QvNklGbUwxaXp5aHBaVU1oZ3o1aWovOTI2UUM0R1pEaC92VUVpMU5R?=
 =?utf-8?B?ZWNCNklMc29hZUFUZktJVjZyeG0xcUZRbXoxVkNrUVI4Uy9VRFlhaTRLSFEr?=
 =?utf-8?B?RGRzMmRmVkpZNkpYa0N2aGdLN1VGbDRTYk5KbWxwSE0zRWpuT1MwbitGWWpx?=
 =?utf-8?B?eWttMWR0YnJOVjBLQis4M2RWR2NuaElXa255OEZnT1g4Y2hUVmYwZG12cjVG?=
 =?utf-8?B?bWpIaXd1YXZ6S3BGOExSbTZRZzlLemdVd09rYlFKNlhOQzdKUWZqNzVUd3JK?=
 =?utf-8?B?am1aUjdpaUxqTjVrNUtySHloTGt1RFFNNzVYeDM1WTRLSEdCVEJpbFl0WHRS?=
 =?utf-8?B?Vm1lWm5rdmlkem5DRUJkNUJ5NlZrNUg1NHBFb1NlZ2U4K3ZtMHhlYVpWVktj?=
 =?utf-8?B?WE5lNGNXVWZLbC9NWE4xS1BiYStOZ0l3Z2FLSkFhM3Z3dTg2U2VvenhZei9p?=
 =?utf-8?B?UDNiOXJSbEdNNTNLNndCd1kwSExqL0Zua1h6bFdrRHpIVTVMMVF4ZkZQNExs?=
 =?utf-8?B?cmV5YXd6VFFTN3A3ays4b3BCK0E2NkZJcHJkdVc2MDdkbVFHaFNpZ2JKN3hk?=
 =?utf-8?Q?NlO5Pt/LlshSV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkZzcWZNaXNwYy91eitGUjZ4RG5TOGhYdWVSWkZTbnZjSnhPZnFZaDBwR3Nu?=
 =?utf-8?B?aHZyYU43TTNiWGFONkVHbzNkd2ZWVGw3b1hLMHFpM3dyc3ZOSnJIZXoxS20w?=
 =?utf-8?B?aFJIdjNFYmJvcWsxdHJWc25YVWJqSVV4SjJBcE5Rd2tQL1NaTXFOL0NLejJO?=
 =?utf-8?B?bTlBRVpRbytibitWZVE2dFA5eVYxVGQyMDB4ajk0U3BaUjVTWHEwQ0IwSHc4?=
 =?utf-8?B?RVlKYjJOU2R2VnJHakVoUGxteldFSElKVUl6YmhnbG9xWWMyT2cxU3YrbVlG?=
 =?utf-8?B?dGZ3MUtZUHNSWkxnbEM2djZUdTJacld5RndXTzJKdW9mdVRpUjRBeHVqZ3Z4?=
 =?utf-8?B?dVk3R1YwVnRIemFGUTFVbGpiZTRDanJPNURPRUFYOFY0cTJCZ3gyOVB2djJq?=
 =?utf-8?B?bXA4WFlmeEN6RDNsZ3lCalFPSjJsZEhBU3p2NnR6M3dZS2ZERzF1a2Yyci9R?=
 =?utf-8?B?N05pWXdsUjU4di93US9RYVFyd0xEd29pMGlTRU9sODZXU2RTdUU2R0p1WkpM?=
 =?utf-8?B?UnFmVThRVkZqQ2UxL2NTYk1vZlVpSERyTTdmM0t3dlVTbGt5MGJsRjhkTTJP?=
 =?utf-8?B?V0ZaU3p6Zk1GenhoYmQ3UUh3Z2xXTWUxeHRPTmEvVitaK0tvUHdvM1kycUVi?=
 =?utf-8?B?VmJJZWVwMzExMWdONlR6dFpOVGhrQlVtNk5KVWJ6d3ZaeWw3dmxoNjQwNkJD?=
 =?utf-8?B?QUk2cFlUM3NHZUU3bklTK1ROMVIzazc3b0tJTW5kdlQxd200VmluK2p4TWs1?=
 =?utf-8?B?b1VrdGxzTStnK3EwV0x3WjlzWE5qeXFLQzMrMUZWSnlaWUxRQjVza0Q2MFJ6?=
 =?utf-8?B?RTVSQ3M3bXdaYkJaSTljdDRCeXorUW1IdG45bmhIZ2pFYXBUUGs5eWZCMXk0?=
 =?utf-8?B?SUFmZXo2S1ZuQ3gzSjloUXdvZmNDY3RXMVR0bjFqUncrOXhhVTNVSk9tTnZq?=
 =?utf-8?B?RmF4S05DN1V1MDJYTm5ZeWZDVkxkNTRZR290dE1jTHVMTThFcWN1V2RXV01j?=
 =?utf-8?B?RUltVmk3cUx3WUJYU0thNkdMQ21pUmpkRGMyWDZZcFg5d2JRRzNQd2o2d21B?=
 =?utf-8?B?QTdOWk9JbVBoZ1RGb1lOVlYycUpCQWNCQ0l3VlZRZ0R3RXMwbWRZUTduVVJy?=
 =?utf-8?B?TnpPVUJleWM2V0ZGTTRPSytBSFhZY24rbUxpRGdQTEl6QnF6dTBZQVF6SElt?=
 =?utf-8?B?MGVBMFFjM2JSbTM4dG41a0lESmt0ckNNTk9URUxCZXQyRFNIWHFVWUtqMjFt?=
 =?utf-8?B?Rld1Z3h1VlRRZ0k1ekxONUlPSkRLWHBma0w3SEJnYXFPSm9pbVZGcnVJQ1pU?=
 =?utf-8?B?UmhYUHB0cU5yY3k2cjdWS2w4YjRzeG5lbXVLOExRSCtBNmdXWlFUREVuOTJ0?=
 =?utf-8?B?YjZON09RYUpPODBZVnVlbC83RW5EWldyRFlraW5DdElhd2FSWXpNbW82aHNT?=
 =?utf-8?B?emtVc0x3SG9WZ0xRbHUvR2J4eFRhclgrZDVWQUM0dy9XU2Y1V0RPNEIzT2RX?=
 =?utf-8?B?dkluMmtaL2FwZVo5NHI1Y0xVNTNPNW41OHBCd015ZFpYcGlaUkhtUkFERC9y?=
 =?utf-8?B?OFJxQnYwTWUyMUJkWnZUeVRZN2VFYWZ2LytXR2VlVkV4c0xEOUtVNXNyL3hQ?=
 =?utf-8?B?dk1UUzJHaVpjWmtxYWhhc01hdDNHeGlRN1RNMGxZR0Z6M2FDeDdOa0ZmSmgz?=
 =?utf-8?B?VXNHeGNkd2puTkJTcmgvMzRmb1RxeTJVcDlodkJmUXYxU3VOUnlrL3k3Qk1U?=
 =?utf-8?B?S2JvYVJER3FpWStZTEVVK0xsSmxJRGRoVFB6VVdjdlNuSzNVd1BmZ1ZGbDlI?=
 =?utf-8?B?M1U2aDdBdTlvYitSRForc3k5REVhSnBkVk8rT3FhYTYxcHduanNLd0oxQVlN?=
 =?utf-8?B?T1NiM00yVzE2Z2k2anV3Ui9ibVhadm92TWg3MjNtUVNETklTSXdqY0dDVXA1?=
 =?utf-8?B?cjJBRnRrS1UzeDE0cEFTSWpHYXpxS0RuUmVIRVllWldVRDkxNTlKOEh5WmFR?=
 =?utf-8?B?eEZCMURNaGw0bldRZWI3bGUyV2lmcGdJazNWZDhPQXFVMXo3MWZ6VTcyRnVX?=
 =?utf-8?B?ZmpqRzZEMlU5U2Uxb0Frb3pIZkxCNWxockF6bzhLYWZJUGFHSHY4bWt0OHJT?=
 =?utf-8?B?U1ZYaDJyZmRVU2NFeWM5V29jQmlRSzN0ZzkwNmdkMzdldGNGTXN5d3lzUUd2?=
 =?utf-8?Q?LLJi3V/nfe17zvWWqzuQH+p6wObG3+xjLHGeJLGTGlCP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p1C1ZEI0jwB+xsg2IdU54i4MAfj+aPtWKYdFvx0x/q/hKtph/gaUxEVJMfBdir8d3X4YYLQwmqnPAf0AoZp25UjbahPtC5wQgaQOp2HCP61CNOd9eRoW01EnXNxiH2o0vEkJb+/b6tQSqLSfyA7MVToB0IVvfvktGM/GhWqB7ZF8Zbs0VYsktOOHguWGQ0jI4SH/REOnY+rAhsYioo62ZMwTPmc8EnTcBt43ZhjBtULawSkNTjw5S/BbBfHIISryKCBOVO1kxehqjuS7Yqw9luIHK5fg1lMZf2UdKXxAoP3TCWrjdLZfF+mvciV8D4+qkph/T1BRxy3p8MhgyTZXtbB9m84PzxDVtI2L61c5ItEYKKEiew3sikIDQjI+HZTQSot0LPLuGTpN6A+w6eZ4KlVnK8aTvgoIGSwD02Efg5/h2WFq5eBXlayuJLn5QB9f0cVT9SAUdZEZFjYR0r6+vHXeX46cO5RNXQt16y+Wl8nSiWl57aWewQcnD3qNQX6gjbt6COArPr3XP4dudETI2Oc/KMsMmwIgiLRW8b2HWbnwiub0t1XdbcoH/TuxcMaUE5W7HRmQWQ4qG5cCYK751oCe4XMYxzPAFS9p5G2TzwZY9JbPR74l2f1uplQNu67snex9Neqtcp/nYgcnVzERlg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c9cbb6-6949-46f3-eeb8-08dd3bbbabc3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 14:38:58.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38CBTiVgXr8bDH/COkFAUMfdl/18VtsZUYw6UKiAd4qdy7/PRb4vKQiMSg7CSKVjOpx+QMsIyMnLaoqTZ5lgFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8700
X-BESS-ID: 1737643140-103539-13347-12959-1
X-BESS-VER: 2019.1_20250122.1822
X-BESS-Apparent-Source-IP: 104.47.56.40
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZmBkBGBlAs1TDNJCnJONnUOC
	3NMCXVMCUxzcg8KdksEchLM0syU6qNBQAfAQO9QAAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262002 [from 
	cloudscan13-176.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 1/23/25 14:34, Dan Carpenter wrote:
> Hello Bernd Schubert,
> 
> Commit e24b7a3b70ae ("fuse: make args->in_args[0] to be always the
> header") from Jan 20, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	fs/fuse/dir.c:596 get_create_ext()
> 	error: buffer overflow 'args->in_args' 3 <= 3
> 

Oh no, right. I just wonder why I don't get the same report

bschubert2@imesrv6 linux.git>git show HEAD |grep "fuse:"
    fuse: make args->in_args[0] to be always the header


Nothing reported except this:

fs/fuse/dax.c:285 dmap_removemapping_list() error: uninitialized symbol 'ret'.
fs/fuse/virtio_fs.c:944 virtio_fs_setup_vqs() error: uninitialized symbol 'virtio_cread_v'.



And no idea why it passes manual testing and all the xfstests (with ASAN
and UBSAN enabled). Just manually tested symlink creation with this patch,
no ASAN report, hmm.

Anyway going to increase the array to 4.



Thanks a lot for the report,
Bernd


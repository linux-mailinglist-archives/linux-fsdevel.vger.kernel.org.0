Return-Path: <linux-fsdevel+bounces-54113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE072AFB5C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6158318878EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5B2D8798;
	Mon,  7 Jul 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mB24d1qT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012030.outbound.protection.outlook.com [52.101.126.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EE1E22FC;
	Mon,  7 Jul 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898178; cv=fail; b=e5PMO/QJ/qh4hzRApbimWIibbXLKXgtsu2LkKIBKEkt3y7ToAGVzXXWqLWgeOPrF8u7rIjTSf+O/GdiEZq1i2aLUPiO0ZVbzyNL2M+nDmxSn4x/y2k6T2sy8NoqSVTQ9AHaq/VD104hiumMgjDC1K4Fd7p+rPibeTsifxWDdgBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898178; c=relaxed/simple;
	bh=3BabiXKC12eD3Ujx9vWvlgoFyHWbfIHq0D5na9Btb5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qkSRRuwVck8/nwgnbGXjg3TiI9LmRib/Wg74gUnGIMOlermWYcrzDa7/k+Q72BUUipPxJ4JU844txtSrF3XwGmXI1cOE4OEBAsh5m4vWk/vNf2WKZ90n0XCB9NtAjPv1cGOsXG5fRuWM++cRWWjeSr0kHFXS1ChvWJYBvKrwypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mB24d1qT; arc=fail smtp.client-ip=52.101.126.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAAJR6kFRARPxhTXx6SBfm7qzVvPt+4A5Gt0nxSFk9rvN9OpyTYXjF/Tm/M6DFMEG3+nYAtl/RZ0glpi5tnUokWrSc1SgPtlkJQaPATuekesFJMMzPThpGn1zWa09naNFz0+uYHgpQ+GKTpmFcJl7NU7kMbH7gOAR94coR2ynJHZ0yWJWEPPJ7FHr5OGzu77ymzmAzMuOyu7dsZOUo3Bo9YQwBzdadFCX20O0+IJifprvwKkQptDY/ySq8oOdIQzt7DHg91GnrCUikMKYwbso5tvjaCBt7nR0s3Irz+J3DTKHnJ/7FTB/KJCPvs+awsrXuSkxh1Mvk/jKI0cGgk06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGeF/QDQM6kOU7Z88PLGGb7evzXP40VihY8cK2RUYP8=;
 b=bkI3ZGGKTwAK44WA2go/NmDbvRiT/YWy/KCCDIyzsNRbaJ7qkZvA4ov9OnHh1xeR2dgTtqQDe5A+odC3vkBNJrmbd/FNMkBViW0Nua0VgqYWLeIVLjAvVv/6GJM1G481DbpcSHRxc+Qwbqq7h+CkMYBTYh0vAAqHRn8lba+gQ0y/gWoCuOJA/l+wRjS5pKl7COaLlXpbivhtLBXwWqu1agcx+PxHFJn8rp5XmVXUVDP2m/HuDIgVx7G0uAMhxdAhekY3WDB5xIhBulNm4a6JxeX7Bty0bzdL05bEVKvkcDDQff5cilBtsYPLisPLQzOYh2HLw1lmYCAohD58WqHrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGeF/QDQM6kOU7Z88PLGGb7evzXP40VihY8cK2RUYP8=;
 b=mB24d1qT3oE+i2XptD73qUmHHNhcpOz/RzoKETiyFJ2QX9qPkaGdQebWBhhrpKMtxZWE/OObZvQMZnrKeb1qJBqYrkJq1gtqOb0QXE4rRoK1HMV682ATo/0aXgug2huzUNCd3qPCSx0i/uD/ARD/iIgWkZqe07bHOiyvb5YHtFytxs6S9IKlyIAym5F577bH8VPK5ULpevMDNoe4nmoUb0uakqv4F9u4WyOrnjsZQcI7XxH3evsdNwGzWOTPsowncia7PZt8htuo8bPbXk7Lqn0Pq1XXEfzAIk4x28d+SLERfgvOKxRIhCvYqEvWLAmnNvPaiYTjgU6dbqbVKMlnhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6902.apcprd06.prod.outlook.com (2603:1096:101:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Mon, 7 Jul
 2025 14:22:48 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 14:22:48 +0000
Message-ID: <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
Date: Mon, 7 Jul 2025 22:22:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ed1d8b-a352-45b4-cd9a-08ddbd61bf49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aERVUHBNaGhLaHNmZXUyd1prQ3NuZHNsNUx0dUV1eE1DVEpqTE1yeVBDWmQ0?=
 =?utf-8?B?YlNZQTEvMnp4ZlR2NS9zYjBFZ0g4aTJUendkVFJ1TzJWYi9YU3VPYTJFVlFz?=
 =?utf-8?B?TmxJcHd1TzUrRCtWWG9NdXRaTXYra1Zqb3A4Z0FzVnNVSkY0SEdneERhKzJq?=
 =?utf-8?B?R0k0WkJQdVNFSW9YRHFFUnlsdjJmblpDV1VqRWpuZ2VPYzhjV0t2Ym11and6?=
 =?utf-8?B?N09LRDZKRHpiYVl3UWJwYVZXZ0NQSVFZMU9pb0RhMzBYcy9FMGtwSmZTckFG?=
 =?utf-8?B?d3VKUFJ1WUpwRldqd0FmdEtobHZsS3pKcmVnVUlzVVZZRTVHOXRuVWxZR3Ay?=
 =?utf-8?B?VnpWS1I4cWp1UGdGaGFGZWE5cHhCRFR4cmVzQXRTMjZTanNWRTFQeEo3Mm4y?=
 =?utf-8?B?dFBabnVIWVkyOHg0K1hBNzRKWVZDYWwybDR2RzVBQTJKMGU2bHF3TVRNalls?=
 =?utf-8?B?WlNzeStDR2VxSlNOYi9wWXFjMFpDN2V4WXVpVC9sMVc2WnAwRnJtRXMzVHFk?=
 =?utf-8?B?aU5OUXZZam5pVDRrVFpISzdnMmRWUWNKdGtIVWY4c3JZUWsrYzdseG5jQjJU?=
 =?utf-8?B?OFViL2lJbnB6cjAxdWdOT2plbnY2YlpBdXF4NTFWSWRyVjVXcEowU25HTkVG?=
 =?utf-8?B?QzRuditoSC9pbnJkQktEdmtubWdKTnVlcFFlS3VPWE5XV29UV3BoamNlc09Q?=
 =?utf-8?B?YVZNZ1YxYUQwaDN4MWhnVUY2N2ZYT2puMll5em80cVlXMmFKdzY0cldrMCtB?=
 =?utf-8?B?VmpZYzkwQnVwUXZyVFVsaU9UNWtyMmhHL0I0WGhyVUdObGJ0VC9JajNZZVF2?=
 =?utf-8?B?ME1qVU56dHdDY0QxbEI0ZDdBQ2hxaDBqRXZwd2VkRlVOWGRXR2ttUHpUNHVJ?=
 =?utf-8?B?VGgwWEdQbEZxYTZGSDhWWVBBMEpMMmtyNkxUdy9UeEhERUdDMmtYWUVQc1hF?=
 =?utf-8?B?d2NFd21IWXQ5bTZlbWx5dXh5Yms5UThFRjNuemNrMnFRSm9zSkxOelVGU1kr?=
 =?utf-8?B?MSszSFkwUE1qU01EUU5OZUNqcUUyb3VEcE9aUnE0dkxlbi9wYzBMQkJOMTRh?=
 =?utf-8?B?VE9jYXRnUXd5V09oYkxOK01aZURhWm5kTWs5RWdyUlE2UGt2cXRwUG9hK3Vl?=
 =?utf-8?B?eTd5VGFnYWZQeEFDNVFqVmdIazErREs2dGRSMkJjT3Uwa3daTElGSjRNNmZG?=
 =?utf-8?B?Wndvc1lxME1YaGFFMWdQVjdVUEgrcDVUU1VPMGtCRklTL2E3c0grKzVoency?=
 =?utf-8?B?alRJdDVTYTFXVzBkWFQ0VVBhL09xNERpUVhrQ1MzVnd3Z2dvc3B3S25nclcw?=
 =?utf-8?B?KzJSaExXZUN5TmJSbFJhZnhHMEsrTGc2aDF5WFVVbWRVR0VtZUdGRU50cmFk?=
 =?utf-8?B?dUVSZHJBSzRDZTRzTnBlZHpIN3doYmZNdG45TSs0R1M4QWVHRGhTZkpnVzVl?=
 =?utf-8?B?MnR1QVJaRVdvdzBVUVhuMVYrMmFCSjlTVnVmbGtxSmFVbDZrMzZmeGhjZzdV?=
 =?utf-8?B?Q2RkSW9ZWklUYVkrVnYySmdncmd6aVdOalRyYkVnUGkxMmpkN1VqZjVMbTFF?=
 =?utf-8?B?M1RISStOUThKTkxWci9MTXFacmZJbklvNzR0cWtLVDlFdzdtd3Rpcy9TRStC?=
 =?utf-8?B?VkpmUGh1alNLZCt3M3VaSWhmTCtSQ2RxbU00c2llWlBYZFMzeVJQRGwxYWZC?=
 =?utf-8?B?S0pBTTJvYlNLa3h4VzJFVmRxQ2daTHFXamlCMkxHeUdpL1FoRHZ5cmdxMGJi?=
 =?utf-8?B?MG1MVXNWZExsUm9IN1dCZmZKRzdXb0QyTVIyS2FWMkxjUjZQeHlIYThscy9s?=
 =?utf-8?Q?2ZTbMk5s1eKiwVSNJaeTn2j/u6FkDtO6ZlOGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFp0bncvc21DeUlIM2JsUENqbndvakUxekY1ek5NOS85V0xmOG0wREd1eEJx?=
 =?utf-8?B?VWQ1bHB6M1pmQ3BjUS94QmduNmJzaWkwd3RJbGZncUkwRUtPdGRCaUc0cmMw?=
 =?utf-8?B?N0E2bFBrKzAzVVdqNVEwRGFxMi9UUERzUVVMc3ZJbXRzWVYvdDgyRklCZ0ph?=
 =?utf-8?B?VStsSGVoL29oK2NReDk1ZDJZeiszYVMwTkxFYzl1aWVBK2FYSFpnRGZldkV6?=
 =?utf-8?B?cE9mUGNleUdMOWVnM0FHSkRnbGNrMnBaK3BMWXBUZDg3V1dDWGNPeDNMNTM2?=
 =?utf-8?B?dTNoT01mZTZLYTZYWmt1clFMbXVhMVVwc05zakVrZjJvcUVuamxVZThEaHBG?=
 =?utf-8?B?U2I5eXpkN05ucU1NODhiRkEyWVhwSHdKZERjSE05NDV2YXowcWxKWGZFa1Zm?=
 =?utf-8?B?YVd4ZzNiVWRucWZ1eHRJeVgweXhFU2Uyb3dTazBDR2FuMWJWcHY1S2lyaDNs?=
 =?utf-8?B?bzZ1NWdDS1krV04wc0sxK0hxYlF4ZkJmWlFHSFY0TVNRMG9FOENwTDZIQnJv?=
 =?utf-8?B?TW5qUzRsMzl2aHBmM2F6NncyZVZIUWY4TU5YaDFMMTdLYzdlajgrNUs3V1li?=
 =?utf-8?B?SjVWRzVrMTNRU1Y2eGxMWG9lZUIxMkNwNC9IQmlMaTIwMHdNR0Fpd1d1NEtP?=
 =?utf-8?B?OE9jbXp0VW5JOVpoeld0TStna3N1VElMdjVoMXlFUHUxNnY5Sk0wUFdZN2t0?=
 =?utf-8?B?ZkNsVmUrdCtRUTQ2cGhIMGh5S1RlOFRldU44V2NaZkVMZ2pvVndDMUhWNnp4?=
 =?utf-8?B?M1pCd3IrT2R0Y2xxK3ZGTC90WjBUdHVudThETlVDSVZkTEs1NFBoUWVCUmFh?=
 =?utf-8?B?Rlh0SFVLRThRU3ZGeDdvMmVaVXpmWjNIYnAvODJ5d0hSak4xTDNHa095UjlS?=
 =?utf-8?B?TFBGdTk3bVI0aU1yZ0t4bkNXTDRSWVRqODN5WittTlY2NTR6ZkVZUE1FVnpL?=
 =?utf-8?B?K05EUXd2OFNRRHo5VWRQSVFNQjc2WTZCRytaQ2gydmJqWS9vTU9vT2REUHZF?=
 =?utf-8?B?U3p3bWgxTUpzNkhnQnRTTFhyeEkxekkvVlZ1VzR4VWtUdUplRnkzd011U01T?=
 =?utf-8?B?YkVMWGNKOWtCL1FJa0JQank5dE0vSU0xTjQxWGVSV2hrdlpOVVkwSzFQQUNX?=
 =?utf-8?B?ZEtCNlBHUXIzcDlTeVlWME1xclE1cXZtVENMYmRmVHdLd2toT3J4ZjA4VThE?=
 =?utf-8?B?UXpWU00xOHhLYlpiMFVxOVB2VEVyS0l6bmZ0eVNiVHRWTkhkMllwNU9TTHNC?=
 =?utf-8?B?b0ZpT1NXMXFkbTZnZnpVbW5qTktlV3VBb3ZjRXhIK3BrcG9PZkg4V1BFZTZ3?=
 =?utf-8?B?UlZMQW9Qa2l0SDlwTXRWTlJwN1Rrb3JWajNtbnNiWFlmUXVyTW9rby9DV3da?=
 =?utf-8?B?WFZrSC9sOFB5S3JtWEo3dUtXMHBETFdnQjc0WjV0Nk4xU05tdHJuR1BlODU0?=
 =?utf-8?B?K20xVjREOHJ4Q3lsUzBBbU52cTJpSXkyQXdjK1IrbWFJWTJ0cDBWcHBWR1o2?=
 =?utf-8?B?MWZmVTZZN1RhMzRieVdEYy9hYUZKQ055Y2h3OXZ6ZlJuK0Z6SzJvT3d0bWEy?=
 =?utf-8?B?THl5Vjc2cGdRVjdtMVdic21tV01lV2w4bVJ4ZkpScysvZjFucitjSkRqUXdk?=
 =?utf-8?B?VTliVkxXNXVRYXlNa01OeTltQXJnS3o2aVQzQnRwaXVrMWNCWCtXckRJYjJD?=
 =?utf-8?B?ZHV4VmNPdEtzV3ZmbkptYUs5NnVOMTdvNFE5V3BOWVE3OWRuTlVOR1VFclFz?=
 =?utf-8?B?aGhUeU1SVkhQRUNicDgxZCtFemhVNVpGcElSMk9EMytqZTUvaEV6K25hUkZF?=
 =?utf-8?B?T3k1U081YmRsbHduYnEwSVdHS2l2aG5nWkNzTll5OGZ0V2tNR1NnYUZaY0k0?=
 =?utf-8?B?RjJCd2VjVjlESmZmVjRtUlRKUm9ocExjOGp5RTdkRlNnREZDL1BvUnl3SlBU?=
 =?utf-8?B?VmFlblA5STVBTTZ4VjI5ZkxmaEExbzVpQU5nUWVSbUlZak5HZ202TGZMWmdL?=
 =?utf-8?B?NjlwUVFSYUEyeEd5SURPdUJsMDc2U1hiMVUxaXo2SFRqdjJFZ0c4enZHem42?=
 =?utf-8?B?RHRyVjZ2K2p6ZkRrV2Y3TEZxSzE4K2Mwalo5QndCR015UnN1c0QvVzRnQWRn?=
 =?utf-8?Q?ZtumP3HVoIMieMMCJQr5thhmV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ed1d8b-a352-45b4-cd9a-08ddbd61bf49
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:22:47.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72qey+VtT4JWD9ifJcMjhZc+J6s9TCKKunf8iwTiEqsxGYQcWUbtI8zXz9C/XyJJtaWFD3LpW6c+SGjiZZKLWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6902

在 2025/7/1 01:18, Viacheslav Dubeyko 写道:
> On Wed, 2025-06-25 at 19:10 +0900, Tetsuo Handa wrote:
>> syzkaller can mount crafted filesystem images.
>> Don't crash the kernel when we can continue.
>>
>> Reported-by: syzbot <syzbot+1107451c16b9eb9d29e6@syzkaller.appspotmail.com>
>> Closes: https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>   fs/hfsplus/xattr.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
>> index 9a1a93e3888b..191767d4cf78 100644
>> --- a/fs/hfsplus/xattr.c
>> +++ b/fs/hfsplus/xattr.c
>> @@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
>>   		return PTR_ERR(attr_file);
>>   	}
>>   
>> -	BUG_ON(i_size_read(attr_file) != 0);
> 
> So, it's something like unexpected situation here. Why do we have
> i_size_read(attr_file) != 0 here? It looks like hfsplus_create_attributes_file()
> was called in incorrect context. Probably, it's not the whole fix. Any ideas?

161         case HFSPLUS_VALID_ATTR_TREE:
162                 return 0;
163         case HFSPLUS_FAILED_ATTR_TREE:
164                 return -EOPNOTSUPP;
165         default:
166                 BUG();
167         }

I haven't delved into the implementation details of xattr yet, but there 
is a bug in this function. It seems that we should convert the bug to 
return EIO in another patch?

Otherwise LGTM.

Reviewed-by: Yangtao Li <frank.li@vivo.com>

Thx,
Yangtao


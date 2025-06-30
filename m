Return-Path: <linux-fsdevel+bounces-53369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BDDAEE228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7E27B15BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20928DF48;
	Mon, 30 Jun 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3uVXFAQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B428DF0F;
	Mon, 30 Jun 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296148; cv=fail; b=szMG+ZqzNd2QplK5Q/5hUFJuc93HgvANxJZdsxfeE8QL4qcs+K67yDXxCdgluEqmoaUCEdpViZ8QjRMnawsN+K/zIUG+sZ8rPCAd6bGKVGADaTZg3jdOzIbv6ByUx+BOaLtYPnzaD1en4pZ//scG3FVZRKrCWqYZCzaKN080NQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296148; c=relaxed/simple;
	bh=QtijJKytlPRaxceP6y1n65TMur8124ilrglwXKPSZNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=msxTIU+/c6s4O1846m7L3Ym2Pz4mu06i/p4AhUjDbbc8Qq7WdNvL5o7F1AyQ56z7NLlS454HwjaKgqRPb6Ctm+F20zKYZGLiTZgGELYXW9YMD6PdMw8mPSKdGVao2VFpnKt0kRqQx6D+Cbl0K4C1bDr0281f0LN8YsqOSpyoi7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3uVXFAQR; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdHmIySzXopWHfBOwq4VojuuQiQ+GyRYoZT5oRzNAwipW2IWCW96b2pJrQwtQVCsPySRjE8ZAc4pX+XYG770O1G18DtLbaUSIhhFuX4Sl+iJbOU5q73ipKFFDk8JlvZ05//5a77gonLm5O3o0+NMlxoY960HfXKwQdsXm3RxVE2NwJbihCfYlG3NGyvM3dcvJ/ae2Dd68PyhCkY6RE0xDVWz1P3NS1jKQFJPXbUbPu1tNdijVHRru/9DNxJQvOBO42X64UlUtML4BCXMyPQqvjpWMyMkO+Azyfnl8oS7win22b3sAPejFSDWenhSBJkCi0ncVwLJ9ICfX97BsMoELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fvc2fXiEnpVth6wpWbVIjrdV2C1MVwvT3xjCHdqVNE=;
 b=N9JSsDEq+7iivu2M2USEPvm50K6omACw1OtJreeoZkqvcbnpv4gbkjURzbv5uVOyj4GSxlSWoyHH1wuV9ltAuUes/LABJIxThDeXpxB4aFFwM+Pl3G6vFkyiHf9CJKVLQ/DZTSba/zxm8v6IPc5IN1uJTQc+5667eR0nTTb9P55lIdyq5IQ255oYkcXy9eorI7xaOjbRNsQPB5NpHC1MrKCTrw/vMPFOFCpnxNHD6jzRplU7QGnLlM9twdM00GAgHPYNAv2fhPNoywOvKiSNqteZbkuFi3EIDBQwJ+26c80+5/EWFkqRgOrYiSIwgwwPbNzhshKovTitrWAVNEmf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fvc2fXiEnpVth6wpWbVIjrdV2C1MVwvT3xjCHdqVNE=;
 b=3uVXFAQR8ViMJfYs8FRmIW7+93K6x60D9ed27aBenjgU+7xwPn1guenDmUSKeOTMDFRwtYxiNHPEN1EvF3lQl90hXhc5UZBjkb/ky45u7PqgCPjQ2cp8faEA8cHzA3f1J0QHLFNH7Ct4beEw0ulWt+1DjrTwJ15TXpKEqyn/Akc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 15:09:01 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 15:09:01 +0000
Message-ID: <773266ac-aa33-497f-b889-6d9f784e850b@amd.com>
Date: Mon, 30 Jun 2025 20:38:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
To: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
 Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Jens Axboe <axboe@kernel.dk>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250527090836.1290532-1-namcao@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250527090836.1290532-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::16) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe58358-1179-487b-7a8c-08ddb7e80ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlloVXM1ZmIrekhDUVNvSDl1NUxPQjlwck12T205enVoSkhJL2tieWp1ZEl2?=
 =?utf-8?B?OEV2T24vQjExcEJyOHZKRy9IM2JjcEhUdHd1TDlFS3BXMVhSSSt3a21DdEY1?=
 =?utf-8?B?T3JLM3MwSUR3bk1jQ29LQ0tpb0lONmdvU2JJcUFRaFNlTEN1dUhvWkQwM0Zz?=
 =?utf-8?B?ZnVrTjJKR0lNR1h3WFFuZDR4UXVVM2dtTTRPNU9sdlhXZ2xXYVFWY2lZUzdM?=
 =?utf-8?B?YmxQREFuMEt2OExQcm1TOS8wVTVha2ZJYUNhZ25IN09NUG1TY3dDYWJSNmVn?=
 =?utf-8?B?bGdVQThyNlFpN3FvSUhBY3dQcjRxMFNkVkw3ZFd0bWdJQVNQL0QwbHZHSjRz?=
 =?utf-8?B?c1FyUmt4aEorN0paR2RvaTVIS3lwcmNMSEZIaU5aU1hmOUdSSk5BakNmbzYz?=
 =?utf-8?B?bGhNMGQ0RkliZ2tmenJib1Z0QlBXZHY0Qk5zakhSNHFiemZMamhWWGtJb2g0?=
 =?utf-8?B?djY0eW9NVWNHbEs3YTJhN2FzUHNkTVhkTWIwNUU2bEdTaXg1dlMySEhndEJx?=
 =?utf-8?B?U0lLVldqWnFFWjRVUmtGTFpHM1VnUGk0NWtyWjFhQ095ZFJmVDRvMDlxUndR?=
 =?utf-8?B?VE1VRm5VUFltRnYrWk9DSVRBSFRXU3NNRzFtTkJRWXVHV285NXJxRVdKMHJr?=
 =?utf-8?B?R3Z6REt5blNDRVZDbU5zeXAxUzFGTVdnODhxWFduVW1QV1djZ3JYaEVqZFpB?=
 =?utf-8?B?cGkyY2xXN1lsSFVmMitYN2xIalBvMlZZZElHOUhtRzhoa0hJdGZNb0dOaG1I?=
 =?utf-8?B?bzJOMkx2ZFBiaVdqcUlTWFJjdVJuT3FiQ3N2ai9VQ01KcnVVRDVRcFBqN1Fp?=
 =?utf-8?B?Tms5Z3VzdVVNWVE4Vi93TTV0UTlOczNLL2N0V013dHQ3R0ZPZG95NUZ5Yisw?=
 =?utf-8?B?T2FxUXY4MGhITUNTVkRZSGZlNm5CNzNWeEd6azI1WGI3U1hQNzQrMzdENlVp?=
 =?utf-8?B?TVVnTThPdzI4UEtTZm5xQ29uQzgwSk1DQVRadWtBN1hadDM0YWZxQ1IxWW0w?=
 =?utf-8?B?NGcwQk5sZWc0RkpPRUgwKy8xdXpzWVBlc2dxT2xoODdCODA0U28yaUY2YjMy?=
 =?utf-8?B?a1FCdHZUNDBISDMra3htTzBOejRiZkt5N3JYek1pUnhXMnhncUlJT1hLTDdN?=
 =?utf-8?B?ZE1JRkdOeWM4VzFwWjUrY1FMc3VrcW1JUVFVQlIyOVdMYTVBdWpRL2psdkdR?=
 =?utf-8?B?RlhXbEpnejEwNUR4TzBtODBGN2x3N1dDZGk0b2hJeURYWkxyZDhhd2N3eFJv?=
 =?utf-8?B?a2E2MVJmL3JQVkc5WU1tNUpoTjV6dnRmZ0ZJbi9kZ2hBbjUxdzhUSzVhY0lS?=
 =?utf-8?B?U3hBUzZMRjZNZkg4RkNxclp2UktFNC9qdVl2RUkzR0g4cEl3YzFjZjNCdnI2?=
 =?utf-8?B?T3pVUmw3WW8xTnlGaENKc1I1ZEZhY1FHU0toejh0K0daQmE3eGdpMElUYlJq?=
 =?utf-8?B?ZFZ5K1dQZVRJNHI2bXp4RzZ2elFlZHRWQnYweXFsUnpoVEtkVE1pbGxhaHBW?=
 =?utf-8?B?Nk9MemQvc3VaOW1kTUpZaCtDZWVMSUxsYkdGZnlIL2dkNGZzWFNaUktYNXV2?=
 =?utf-8?B?VXhjazN1Qk5wZE9aUUtsS3BMSmRDQXVHYlkzaytPaitsbklMNFE3RHZ6OWsy?=
 =?utf-8?B?ck5OeHJNLzdRVHk2Q2JNK0VOWlVFd1hseWpOSFc1b24xYng1ZVpPRnJCMTZj?=
 =?utf-8?B?SmVjeWtjNUt6REs3ZzRONHIvYkxBOE1IaHc4eFFEdFlFOWpBYi9DTDNDaUFM?=
 =?utf-8?B?aEVrZ3owYVAyVW1BL1ZwRlhDYmVvTlhIL1dsWDFsVGU4NDgxV3d5NEJwcEMz?=
 =?utf-8?B?MTdDWlFuK2pqZ3JLVGZtQVhqYnhCMGhPMnRCSElzcGowUUowamVpRm5COEoy?=
 =?utf-8?B?RHZkR0d5ZUR6Y2dJZmg4amlSNXRBaHRLLzg4MUlFcS9HSEpMamM4dFhrR2tN?=
 =?utf-8?B?K2Y5YWFpNGFDV0s1MTM2SXVrMTFpUmRZRTFmbmlrNEd4bVhqbmtyOXAzS2JF?=
 =?utf-8?Q?CRNK2Eav9ivnqqaCxiovFtjO1DRy/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXlUSTFhRXNlcW00ckMwM0ZRbnpwVm9ycG5CU0ViYWd3eXZxd3ZSMVA3amlk?=
 =?utf-8?B?bWE0eWcxWlY0cy9CQXZhT09QSnplNkcwSFNiU1hCOEpweDZwMVM4M1Flc2Nw?=
 =?utf-8?B?a3YzMlJHVXRIV1pPUHlqL0c3c3lSWVQwVWxJUDlINHJ0ejBCM2FDVGdlaHpV?=
 =?utf-8?B?eUl1aWgrR0xGNzRwYTlxUmUrSHd2TktWY245dlNqc1ZBUDVWRVZJNExYQWtG?=
 =?utf-8?B?S3JRb2l1VXpsUGdHdzNyVWJOS1NTYlJwL3d0eWl0akZRZUd6ZW1ZUW1FNmdM?=
 =?utf-8?B?amNtaHMveHpmd2tYajYvaCtKZ2h4Ly95RlNla2dxa21UNzRmQzhlTUtxVmpi?=
 =?utf-8?B?WGNtczhJbnkybjBCNU10QVkxaDNDRnJMQXJBS2h4ZTdOcHB2K3M2WGpFSFlM?=
 =?utf-8?B?ZytGRk11VkNWWHRCOWl6SldiUGNZVDZRSkV6OWp1QWR6K1BwOUZKWnRBNzBy?=
 =?utf-8?B?ZitGU3NicEJUemJ1cjg4N3lyTXlRazd4T3o5MDZVTXY3TFBQU0NDb0NZd3BI?=
 =?utf-8?B?K3N5RGRlbVQ1NVFpRmhKdENkWGp2RmxDeE41eUFmdGpuSFZlN1kzNWZvUVcv?=
 =?utf-8?B?ZlE3cFFQa1hnSzF1M0pUOWpwMHZYc25aVWZBNnVMTmMwdnBUbndZT1lVSUpH?=
 =?utf-8?B?c1dTZGQ3eEphWnE0TVJnWndMMGUzYThuVWsxOG00c2F5UlZvR1hKOE1tSDVG?=
 =?utf-8?B?K3NaNXRvb0JSa1BzcDJsb0ZldG9icHVzTExuQW9IcHVIRTJobFJpMzFKcjVr?=
 =?utf-8?B?azZvcFA2YXVCb2owR204TWkySTdXK1BXUTF4SHJJTFp0eU5MS1o1SC9PU2Nn?=
 =?utf-8?B?WUhERFJNaDlvUHdvQkFqRkprWVpwSW4yVm9IeTdTSDhHeW5ac24vam1IZTJ5?=
 =?utf-8?B?NmJrd1FuTGJ6aUhxRlVSUS9NL0lhS2I1dXZWTzZZbEJKaVRJWExQNW5BYWt0?=
 =?utf-8?B?bmpFc3JzN25uSmNFQmZMTkhrUU9IN2plNUV0WnBZbldGeUZtMG03VCtCRVdF?=
 =?utf-8?B?dzlhVlN6N2hyTWtRaCtrWlROc0trN3JPKzVpSmdjcTJHVHJ4djBLaWJkVVZ2?=
 =?utf-8?B?TnNOam01N1BUdEJSYWlaYXpmaFNSMTh3TS9EbTBoOUQ5ZWg5VG5rZVhsZVk5?=
 =?utf-8?B?V3NhQ3RJbjRmbE1hVGszV3JENFNOQTJBM2ZoeDVNcnBjd045SFEva3hBdWQ4?=
 =?utf-8?B?V2t4MW4rVEFDL0lxWm9LQ2JldWczY0M3ZkZjQkk5THJRVmN5RTUxMXlVMnNy?=
 =?utf-8?B?OVI1bWxiRWw5NFZaWTd3Y2xXaGsyd25wM2VYaEM4YkEwQ1JERit1YWZMU3Ns?=
 =?utf-8?B?RU43N0pRWnp4akhMQXo1djFwREJaV2NmWHVwWG5qSm9lUFF0MmJ5a2o5VFRR?=
 =?utf-8?B?cXcxQmZSbFp2MjNGQ3UrVGdybDNQNWp1TDdjVHlNQU5CdTlTdFJUaE9OQ0U4?=
 =?utf-8?B?R1hTcXVyalc3dm5tVzhzaWFOcHhocGFFOG1ncW55RlV4NWg3OVlmUXpEZk1v?=
 =?utf-8?B?cms1cFdlK3ord1B6aXlmZVZaMWhuZlJmSHQ2VmxOWktnL2RYSUJWUWU0elps?=
 =?utf-8?B?TEFvaTRnOHBkRW9zWjJOdE9wZEpvYjhuWUtjaDZKM055VzhGV1pjdXMxOG1T?=
 =?utf-8?B?cmk4TndVeGNsNU4wWmpPak9VdVowRmZFK1hJUDB3enVyNFRNNm9wZVJRMnpJ?=
 =?utf-8?B?cVN0a2NZdHAybkdEd00yOW95ZGJJd0hRaExSV3crN2lXZmR5VlNFeTRtYWVU?=
 =?utf-8?B?N1BrOHdNQUU4d3Z3QzU5bzJLQ1ZDTVBpYWdzN2FvNjJ0dEYyaUp0RHdEWlpC?=
 =?utf-8?B?a2hsVWw0TFdMMytBVEl3dW8zd05zODMyNEhhUFhTblE3UVNxUzhRL0dNeVNw?=
 =?utf-8?B?alJSZmtHaW1MWEU5dHdTbVl4U3IybDkvdC8wYWtYbFFhbWxjVXh5MXZXeXVY?=
 =?utf-8?B?UGtZYUgwMzF6RU8wNzZSbkpvZzNsWjBJZjl4QSt5ZTRWVVBHTDlWeDJMeldF?=
 =?utf-8?B?N3RsVS8xTU1mRzRKY05OVy9Ga3J6cXhqRmhvUHB1NGx5TG1ESS9kSE5DT3BM?=
 =?utf-8?B?Rzlmd3o2YkdwTWZjRFpjUGJvTDBzUWNHUGNnaFpxMG8wVVRYbWNYSVcxelRw?=
 =?utf-8?Q?kzNgv8xTO8Wtb+ULIQUj2bW9k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe58358-1179-487b-7a8c-08ddb7e80ba2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:09:01.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pET5jleB0iM8FavhpyMdCkN1S30gxjSUjiGFX9eEV1QemKy6uW552aEUeA4nY5xRfTwmYWBCziCOHvYFR/adzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

Hello Nam,

On 5/27/2025 2:38 PM, Nam Cao wrote:
> The ready event list of an epoll object is protected by read-write
> semaphore:
> 
>    - The consumer (waiter) acquires the write lock and takes items.
>    - the producer (waker) takes the read lock and adds items.
> 
> The point of this design is enabling epoll to scale well with large number
> of producers, as multiple producers can hold the read lock at the same
> time.
> 
> Unfortunately, this implementation may cause scheduling priority inversion
> problem. Suppose the consumer has higher scheduling priority than the
> producer. The consumer needs to acquire the write lock, but may be blocked
> by the producer holding the read lock. Since read-write semaphore does not
> support priority-boosting for the readers (even with CONFIG_PREEMPT_RT=y),
> we have a case of priority inversion: a higher priority consumer is blocked
> by a lower priority producer. This problem was reported in [1].
> 
> Furthermore, this could also cause stall problem, as described in [2].
> 
> To fix this problem, make the event list half-lockless:
> 
>    - The consumer acquires a mutex (ep->mtx) and takes items.
>    - The producer locklessly adds items to the list.
> 
> Performance is not the main goal of this patch, but as the producer now can
> add items without waiting for consumer to release the lock, performance
> improvement is observed using the stress test from
> https://github.com/rouming/test-tools/blob/master/stress-epoll.c. This is
> the same test that justified using read-write semaphore in the past.
> 
> Testing using 12 x86_64 CPUs:
> 
>            Before     After        Diff
> threads  events/ms  events/ms
>        8       6932      19753    +185%
>       16       7820      27923    +257%
>       32       7648      35164    +360%
>       64       9677      37780    +290%
>      128      11166      38174    +242%
> 
> Testing using 1 riscv64 CPU (averaged over 10 runs, as the numbers are
> noisy):
> 
>            Before     After        Diff
> threads  events/ms  events/ms
>        1         73        129     +77%
>        2        151        216     +43%
>        4        216        364     +69%
>        8        234        382     +63%
>       16        251        392     +56%
> 

I gave this patch a spin on top of tip:sched/core (PREEMPT_RT) with
Jan's reproducer from
https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/.

On tip:sched/core, I see a hang few seconds into the run and rcu-stall
a minute after when I pin the epoll-stall and epoll-stall-writer on the
same CPU as the Bandwidth timer on a 2vCPU VM. (I'm using a printk to
log the CPU where the timer was started in pinned mode)

With this series, I haven't seen any stalls yet over multiple short
runs (~10min) and even a longer run (~3Hrs).

Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Closes: https://lore.kernel.org/linux-rt-users/20210825132754.GA895675@lothringen/ [1]
> Reported-by: Valentin Schneider <vschneid@redhat.com>
> Closes: https://lore.kernel.org/linux-rt-users/xhsmhttqvnall.mognet@vschneid.remote.csb/ [2]
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v3:
>    - get rid of the "link_used" and "ready" flags. They are hard to
>      understand and unnecessary
>    - get rid of the obsolete lockdep_assert_irqs_enabled()
>    - Add lockdep_assert_held(&ep->mtx)
>    - rewrite some comments
> v2:
>    - rename link_locked -> link_used
>    - replace xchg() with smp_store_release() when applicable
>    - make sure llist_node is in clean state when not on a list
>    - remove now-unused list_add_tail_lockless()

-- 
Thanks and Regards,
Prateek



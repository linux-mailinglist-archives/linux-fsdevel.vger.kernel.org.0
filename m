Return-Path: <linux-fsdevel+bounces-47026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25086A97DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5525D17E827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05975264A71;
	Wed, 23 Apr 2025 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mvFRNgZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9EDDAD;
	Wed, 23 Apr 2025 04:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745382663; cv=fail; b=ZGwmXis7Wv838xky4JuE62RG5sjAkxD+gsSSrFjLsV0JjpwaC4q5xwKtCdTZFJJLagCi4SqQ5k+ny2MUAeOQ4ziGsWadNT2lZJwLHMBpx2WB/W5UhnulIg/8SNEFGTeIcBVbpPylir5Rt8RdKF1xXk13fJY6FrjXRKdcUB4i5R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745382663; c=relaxed/simple;
	bh=+dXDZZh/3Hbx9dzQZgYg3LeCFaypSEkZa5kuLLeEPaY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bUQZ5uqoSHsDbT85KKMNPKEgHmsU98DAcbIFD297Hq2V4n3Wpq8qwFGywTHJJ/6NBpfdpBK/jkQTQyBVB4Tt3qSAOTja8gwLyQiPF4AY364kEZQasgzwUshmrfuX+iMPlNEcmmvz4Rq7bA8S3uSjMbwYyz21QeLWCn6vdT6+gws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mvFRNgZY; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDYXEAzkoUK5hUwmuIgl+EunEl5zJmR5R+ICGi24mAIJi0FP4Tvbv43SFLCniINMpPNYguLCClF5iUNCm01QHpUBUscWht1/h5Os2W+qOfWYxTdBwB98wwFzIKDWtzX39n7FEwS6ErntBzfeF5E2581sAvePwtbbsGZU8ot9H5Y5Zm1nrg+acTDvbF2IXFTZ1Lo7KMy7EyTzyzgTY/qoEsKw1iO5Ao3nf0Sk6sKiVIlJ0OBzfQCGc7HduuPUUFZ8GYinEYa11FO68aXSNrWJuUQ0ulMRfgUKA2Jyx+ZhdLjBCWXnkgvHFp6qsGMrRkjeRWJWMw8YWY2FZUrwOoOktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTBeLjy/NNgoV/9Lm8kN1jah+jUvW0xauyZEvZSZrD0=;
 b=c/KRqsjGgAr3cWDxfx9ajdT5bPt2jSUSTzpIHM2012NYjWnLqIxFt3rrGXO195Sf//mKzh4ePjtmvcPRBTdijlOuF12HrsCrUvap9QCkba3ZdfG+RNazDlLCkKgDgSK4G0nvf5jSEu/pAId3vnbhWg3sOV91EnMp2yh78L7t6aqpuviI78mxRpPk9Fh7hiv/pxK8UP/wpiymVCaAoTXlm5ZfssQPfdkRp1CeVy+hNI3I9zTR52a6wITGxVuRlAyl6CGb7j9ZicryRaxh0N6c+9zJ1+CpvdfJZo4mPeiAe4Fy0TmkxxTfO0r1jqT2YNltO2sMQX9zY4GipcddL2ARUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTBeLjy/NNgoV/9Lm8kN1jah+jUvW0xauyZEvZSZrD0=;
 b=mvFRNgZYfWBu7MSWvYQzPNXZ/jpzWmrgPDxF1gF9879IjaL/gHtk6Bs6Fc0BRXNim4zuno9EcB6oMFw2zIuftMi38vMQ+rw/YIk2FYOFom/GEIH8M9FgTK1xOfFIh5n6vu7cIg4bc0noMkNfPcOuNy10Vddt/bZiIUkYRq6I0dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 04:30:58 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 04:30:58 +0000
Message-ID: <e866ab3d-32cf-48fe-ae98-31c20deb97bb@amd.com>
Date: Wed, 23 Apr 2025 10:00:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
To: hch <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "djwong@kernel.org"
 <djwong@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Xiao Ni <xni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
References: <20250417064042.712140-1-hch@lst.de>
 <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
 <20250422055149.GB29356@lst.de>
 <20250422-angepackt-reisen-bc24fbec2702@brauner>
 <20250422081736.GA674@lst.de> <20250422141505.GA25426@lst.de>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <20250422141505.GA25426@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dd0440-48b8-489e-050b-08dd821fa508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnpOVllrM2oxaDM5dTVjTDlLQWxFTWVhanlsYmdmemZaWmd1YzhSamRnOExa?=
 =?utf-8?B?cnhqSlp6VnZOM2ZPRkh2UTRtaEo5d2lhRUoveWRySXJwd3d5RzFFS2Y4V2Y4?=
 =?utf-8?B?Nng2MzJ4dzhoa04wV0REdEkyYlVmZEcwVmV6cW5Zd0R0NkNDMzJOUHJIeDJj?=
 =?utf-8?B?UmhwZnlvMzJOZUhxUzR0amxNZDlBeVU1MCtGdGUvRTRHVjE3Vi9UVExwSHBk?=
 =?utf-8?B?SDB4dUhWUHh4MnQzMzRoL21vamtHYkZ5MVp4TThvQUdFSmZzUXdkZ2JJUW0v?=
 =?utf-8?B?SktUTWU4bEhqT1B6a2g0MXdBVURWV1V0aG5ReWZqVHNPMmNXdlVpNUR1eER2?=
 =?utf-8?B?T3BCcUdHOWZ5QmJFQkhoWHlvZXRiZG95eVVwcmdrM0xNNU03VkhQc1hTM25x?=
 =?utf-8?B?V3F0bmtndEpHSjJheWMzeVhlTjBmb0s3RzVxMTRScE9VVUN3ZEpOek9wOXlp?=
 =?utf-8?B?bmlGb0t6d3lucTVYeTlBeUd3TU4zaUtrdS9lUGorWkxncjBtZXhCRlRpYjlV?=
 =?utf-8?B?YXR2cFF3em1kUjhHSHNVK3JON2NIeUdDdjdSS3RjcU1naWFTdm8rcWJFbzdL?=
 =?utf-8?B?WWFPWFpWaEhCOUVlM3BoaDNVb1Y4WWhrekhpWkNvbHMzT0RPSWh5SjZHUmZp?=
 =?utf-8?B?MndwNWtNMEFLOEhKaXZFSHlBUW5DUGk1TDRUOUhzQkpXMkViRTlYdjNmMGRI?=
 =?utf-8?B?a3dqSHdoWlBmZFhFZThzMjF1Q3ByQmprRXFSUE1ObkRxUjI3SFJmSHh1dERm?=
 =?utf-8?B?eVhwaC8xMm53cmJaNmZ5aEFubThMOVBKWmtSUnNTN3Q0VDZVSmlLZ3hKMGNL?=
 =?utf-8?B?SUppVnhWUEVUa2VYb1B5L0gzSkEzVmh5OTk4aGZWK083TGFrMk50OXNnaFR6?=
 =?utf-8?B?b09mZHZrOVlSc2ltRlFsWFBXYTZudXZRWFpxL3JQVUcxSkpMMXRSS2Y4UUE5?=
 =?utf-8?B?OUltQmpycHZia2ZNZVFVOXpqSFZSTGhHeUE1TnhLWTAwVzVsM0lkSmFTQjBK?=
 =?utf-8?B?ODdEUEVEbXpRM2MxTkcwNGdBYlRXVnRUVWlteTgwYTVGK051c0hqREZ5R1lk?=
 =?utf-8?B?N0JGdTBXckQ5Q1plQ0dZSkdHc09ERjJ3bS9rT2JKcjA5N3ZzL3BPbDZxOG5x?=
 =?utf-8?B?R3ppSDNHcHNKYytIUUpQKy9xeXgrbEhYb2hMeUI3UnR3UjlEd2prM2dXOGs4?=
 =?utf-8?B?bitSMnZxWkN2R0M5YUFCKzdZVk9SaTdpQm1LaWFWSGNPTUw3NUVOZW5KSGxP?=
 =?utf-8?B?ME1rTk9qSlZ3WTNKOXdieHJnOHZ2bHAzSEJUZ1Y5YzZPYkVHaXdYekZPSSsz?=
 =?utf-8?B?TTZxQ0N1eTB1NEJYeDdseVRUaFl3aUt6d0Vqa3RvV2kvNFVSWU1KTjArZEJI?=
 =?utf-8?B?bmwzVVVSU2xod0JUaUhvWlc4R3BIOXlLb2VJMGdEMHdxN29VaGczUlo1M0ln?=
 =?utf-8?B?SGJhR1BTN2lDeHhoTzl0eTl2cWR5MmtUUDg1aWJ0UlFEb2FhWjJDZ0JGekZu?=
 =?utf-8?B?UGx2V3JGSENJYnFUOWZJY20yUmhRN3ErMWZRV2RESHkyNkRIdU40Wmc5cEt1?=
 =?utf-8?B?VHd5cHhlb0diTUVLZmxzb2NPQVNhZjdLRG0rcGJXMEZoWExoVXNlRFpmZ2Jv?=
 =?utf-8?B?bkk5OGU2K3p1THdZbnJ2dXNHeXUySTNyRnVGcGhLdU1TcGpmZ1I2ejVnZ1c0?=
 =?utf-8?B?UkkvLzJiSGhWZDNkYUlYeFZZRThSSmJlODVIek1ubFhzWVQ5YlRkR0xEOHpT?=
 =?utf-8?B?SDdTWnZ2aTFPOGRuSFc5US9lTkkwenVub3ZsQ0M3RDFCN2RZLytoZ3k3d2JO?=
 =?utf-8?B?NVZlYk1ZSmhJZmgvZlhCS21hU1JDdmc2cjA1clVZOWpTcXF1UlZEa0xxUkV0?=
 =?utf-8?B?bmp6RUFTOUc3a05iUVNydVN6VjIrbGh3cXBwNmM4NGl5UWV0Y01ZN1hLbHNS?=
 =?utf-8?Q?uisid5rE0B8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEU5ZEdLUnRuRTR5QmJad0JralpKWGNJOWpHbHp3anRNNFd0SWErY0Z6RHBT?=
 =?utf-8?B?dTY0UXVBSkt2VzNFSDA2ZGFuN0wzSTdRTUc2bU9BeTdxUE5HeHI1d0tUMDhF?=
 =?utf-8?B?TFR1eXduaFN2Vzg0OEQvbTFWYlJnbktJNVR6QjN6NE12RitMNkVlakZPS0Za?=
 =?utf-8?B?SU1LUWV3Z0hnQ1J6NDY0SHNzbjVFbWhYclZHTGJvdzV5Vm9xbDZDdVNZazcv?=
 =?utf-8?B?bUlaK0QxOUV4aXA4c2JSYjREbmR4Sm5NSDBEdk8ydWV4Q0FYdlFoVkljY1lw?=
 =?utf-8?B?NmJ4SnJYWTBUMVp2UXBORDlJL05OSXFmTFo5bytBRUpxUjk0OE5KYnJRdGxu?=
 =?utf-8?B?Y3BkV3JhR2Z6MWZXOWFyeVBQa09aQ3RINU5DVjF2QWdQOUJ2ZmYrZXNwSmtw?=
 =?utf-8?B?MkZLcHphbzhpUWlNRzdZMEJnVm5RNEFkSitnNjBzeWVJcUlhbDlhU1cvMkVh?=
 =?utf-8?B?VmRjUlMxeDRvem5udDZOYlM2aUNwa1gvL1BnK3FmRnBjNE96MXpkeW9OeHls?=
 =?utf-8?B?Zm5tcGFubElxajVKLytmeFN6VFd1cjRVWmRTY2x2eUlLbUxIbUdOVWovbXFQ?=
 =?utf-8?B?OWdRb3dwamVFU0x5b1dpZTlVTGIrSy9pKzQrb096VUYwT3lUNW55V0p3VFFH?=
 =?utf-8?B?bm9UNDh4UUN2RUVjK1BTcmwwMnFhaGJpRDdQREh3TDM4MHg1bkk0b0pyTHJm?=
 =?utf-8?B?TGYxOUNrZTRGN0VLdVdSdjg4M2RrUG9TTnVQSldlT2xUdlR1UzJYRm5CZGFm?=
 =?utf-8?B?em5qb3NCRXhndVBaZzJCejc0Uy90ckVMN0V3RlRVQ0RqS3JjejNvUDRudzhr?=
 =?utf-8?B?L05LMWQ5dFpsWTlmcTkva3ZiZ2NHQ0YxTTFpQjJzS3k4SmIybGN6eXJ4NDhQ?=
 =?utf-8?B?N2VKUzBGOTd1TUNqZElLNnlEWFoyRnlneElDUk5oNm1yQm50VnVra2NWZXhC?=
 =?utf-8?B?VjNTKzJRaHJVcWpVQWMxSDJYSDNPdnVBbDZwWndBcGJzU2NMTkpQZFFjaTBZ?=
 =?utf-8?B?SUZUaXhhcHV1cmtFMGprQ0FBbDlVVnA0ZkZSN2tSZTFxUnppMmFSM1QvU3Vr?=
 =?utf-8?B?SlNMNGVYTXEyOXFqRkN5RGNXdlI2Q2NNb21DMG5SZ0hHRWtIUVVyR25uSWo5?=
 =?utf-8?B?RERIaFU0MDFSRGtPWnJCSEVZdnc5OW9CVVRlb3k0bVcwWVlpM0hQUk00UXF1?=
 =?utf-8?B?N1FPa2FHWlpwUUovMGhQelQ2NFE3UW5UWCs4YmlRY1dGVlRRR04wWHJSVVJr?=
 =?utf-8?B?TEtibTRrY21FZHUxNXF4K25NUFJXZVJ3YlFPMk1tV0VQelEzNGpTUW0yNlNX?=
 =?utf-8?B?YS9ZYVd6Y1dsc3AvSWx0Tk5kTDVhUEdzSUc0SDE1K1FaOTBmVG9BZWI3RXJG?=
 =?utf-8?B?RWd4SDFUdncvbVlqY1JNR0lsUkJWZkxTZlQvUEhWNG1QSUMzK0tZc3BhVDZh?=
 =?utf-8?B?WHJVTzk5R0FyQnRZdFRoZStHRnYya3orekFjUldqRXozbmU3L0ZaRS9zTS9k?=
 =?utf-8?B?VHFIbXdDUWVlbzdwQ09td1BoS0RyZG9tRVVJVzVSNlhmTXJ5WExKVmo5c0Zk?=
 =?utf-8?B?RTFybTlzMVQwQWQwa1F0K1hMVVBJV3k5RDMza0FKV3NsSXNwaWFIN2xWbHVa?=
 =?utf-8?B?YzBnL0NyTHdtWmsvbzZabXBvNjBmekowUDJ2c3oxMmhwbjdUQ00vdW9BWWhN?=
 =?utf-8?B?Wkk4RUxCeGk1WU94VldEREplVC84SC9UTTVZNTlHU3RKYU9EblZMbFlwSXJ3?=
 =?utf-8?B?YVZ3QnVIdmdJNWdxVHlncGNkMkpPTkxUUGFndDVWTEwrYUVsU3FlQkQ2NDMv?=
 =?utf-8?B?ZVVMMTZET2xpTGZoZ0RFRGd5a2RRbmN0US9lTmxrdXdyclJYOGtFR2dSWjZ3?=
 =?utf-8?B?NjBNbUN2ZllaWEJwTmp5S1RDZXFYbTd2WTJjYjZ3Qjd5dittMVVIdThwdSt2?=
 =?utf-8?B?by9lSGNHUkJwNktVTXJSalpLZFdubHNEWUhwaHFXYU5HanFoMnF0VHQ5aU1k?=
 =?utf-8?B?ZmFDNGcwUUowZ0hpd1FkdWxsOENxQWVQbTZ1TTUwOHZJSjBPNlVNZ21vWHBo?=
 =?utf-8?B?cHMxSWpuUVYvQXZtY09Vam13NTZIY0hVRDZ4K1FrYVF0QTNaaldzcUYzYzB4?=
 =?utf-8?Q?sTjuIJXEkRzlNMFXJD3P7hkFE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd0440-48b8-489e-050b-08dd821fa508
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 04:30:58.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Abc2db1rJbcuXfqohw7CwId5fE/7L3YAA0xO36QSYAhkUe9SO78aqpVGMuCnlnBBK7mvh0TOl12Qhu3iHpUdGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853


On 4/22/2025 7:45 PM, hch wrote:
> Turns out this doesn't work.  We used to have the request_mask, but it
> got removed in 25fbcd62d2e1 ("bdev: use bdev_io_min() for statx block
> size") so that stat can expose the block device min I/O size in
> st_blkdev, and as the blksize doesn't have it's own request_mask flag
> is hard to special case.
> 
> So maybe the better question is why devtmpfs even calls into
> vfs_getattr?  As far as I can tell handle_remove is only ever called on
> the actual devtmpfs file system, so we don't need to go through the
> VFS to query i_mode.  i.e. the patch should also fix the issue.  The
> modify_change is probably not needed either, but for now I'm aiming
> for the minimal fix.
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 6dd1a8860f1c..53fb0829eb7b 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -296,7 +296,7 @@ static int delete_path(const char *nodepath)
>  	return err;
>  }
>  
> -static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *stat)
> +static int dev_mynode(struct device *dev, struct inode *inode)
>  {
>  	/* did we create it */
>  	if (inode->i_private != &thread)
> @@ -304,13 +304,13 @@ static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *sta
>  
>  	/* does the dev_t match */
>  	if (is_blockdev(dev)) {
> -		if (!S_ISBLK(stat->mode))
> +		if (!S_ISBLK(inode->i_mode))
>  			return 0;
>  	} else {
> -		if (!S_ISCHR(stat->mode))
> +		if (!S_ISCHR(inode->i_mode))
>  			return 0;
>  	}
> -	if (stat->rdev != dev->devt)
> +	if (inode->i_rdev != dev->devt)
>  		return 0;
>  
>  	/* ours */
> @@ -321,8 +321,7 @@ static int handle_remove(const char *nodename, struct device *dev)
>  {
>  	struct path parent;
>  	struct dentry *dentry;
> -	struct kstat stat;
> -	struct path p;
> +	struct inode *inode;
>  	int deleted = 0;
>  	int err;
>  
> @@ -330,11 +329,8 @@ static int handle_remove(const char *nodename, struct device *dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	p.mnt = parent.mnt;
> -	p.dentry = dentry;
> -	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> -			  AT_STATX_SYNC_AS_STAT);
> -	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> +	inode = d_inode(dentry);
> +	if (dev_mynode(dev, inode)) {
>  		struct iattr newattrs;
>  		/*
>  		 * before unlinking this node, reset permissions
> @@ -342,7 +338,7 @@ static int handle_remove(const char *nodename, struct device *dev)
>  		 */
>  		newattrs.ia_uid = GLOBAL_ROOT_UID;
>  		newattrs.ia_gid = GLOBAL_ROOT_GID;
> -		newattrs.ia_mode = stat.mode & ~0777;
> +		newattrs.ia_mode = inode->i_mode & ~0777;
>  		newattrs.ia_valid =
>  			ATTR_UID|ATTR_GID|ATTR_MODE;
>  		inode_lock(d_inode(dentry));


Thank you for the quick fix, this fixes blk devices hang issues on AMD
EPYC systems as well.

Tested-by: Ayush Jain <Ayush.jain3@amd.com>

Thanks,
Ayush


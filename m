Return-Path: <linux-fsdevel+bounces-48453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5B3AAF4CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 09:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC087AFB4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22A22068A;
	Thu,  8 May 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WwsEs+id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4111FBCB2
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746689922; cv=fail; b=UECn8JvshxqUAU7afYwVSI74d1SdLceNvZwMCbBk7mgL/jDUjDhr5Ac94Aqm/bCaEPabliR0H0Ecr5KzTZN4OJnVjZnX7cleyhTObpoa+76Yrf1sQfj8BSuLv4lqW1XOSCTqfKAzvvMnIaodGmymGn7A9Ktg0HWAbrHW8skZeFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746689922; c=relaxed/simple;
	bh=PlMb4i33kHH7RQ9IIDbYXdRuoJqs5yGZB87yrG/WEf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AvhhEUe2cKsTyYUNRFqbteLd4n8m3q7ZhT+66uBU2ojh2NdXdm0RCbHICK2/b5aGbQyzmGMBpVLrt+Z9GjXuznEijA7qWtehErwy603dvDSLbanQ2Lnn7Ei+90oYD4MChTsL1A9IwFq3otfXpnypXYFV4sirUvTjsJoQkAXapJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WwsEs+id; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP90+xT1fWdSe63YQ7q24i1pQVouDzqS/fflr1E0d+miK/93X5bWH/fPjoVUSdtYXfZQ9aYB9/+vfo/iO+FcCZkjqA3Kv4zod0v0q0dBq+rQaohPJQ1WRezANPUlRXs4KIT/bYT5mVSBZ/hxd1ZEW5BmCZXlxVLAy8KsJo5TadVF5TwoXLuKjyLVA/bcrjAr9/4o3S6vFPDIA1uHUi35kddfpeoIEePQlFrS17nbTiwndg4kJeBQXvzltDfHF84Oh/ytzyUIAHY54JEHegoyIM17s+zDfbVpF8Mbe+W+pYSMICkpS0QwATvSXtsegxY81n1IsZekTsXjvkBR+t0Nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SkqHiTGYUN7kUayqfDujRs7znePjc3ng5Z/TM4jd5I=;
 b=bnsAhZFy1TB24A6XI6fqKNI0kAaGTWLHEVl24IJwG6GjdVWqZTFKSdXn/qApqEdhQRDkRKe3K617KhHxQeiLscKQwzdeF6+pFvyuRlBiLgL0xkd74VjQITktjbMAYZOTWyiSyKIhKEf3S0ffHNnS5uadAFwmswBkz0wYRm2XdDEh9bn66x8BMAH7OLYbBj68VJytO9Eg/4DdvUiYuihidRjwuyuRrgl+njjGviankgCMS670plD4EfGfwEM2DSvTglRvgwtCbqZdMZpg096sLPaQG450JMq1ISYrW3EP9jVjEnuCILooS4kKc2F3q/9SYfl5mLA0hevySSBZGOc44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SkqHiTGYUN7kUayqfDujRs7znePjc3ng5Z/TM4jd5I=;
 b=WwsEs+idYpneSmF3qFQ42XY0LUsecLU+chvCHz/BHPnB7uutGZ23GJrBOxQUj2KDzQ4IJNxkXuxhC9eDjkYmQW3m3i3JEr8nEc/3PQJNkFbUNpJYhxrYirzBs8/BxvI95Xoa5XxiaL4f+0Wh3o6p9diYc/sr6tKGY7a1pZY9Y5tg8IzYe/oOFrljqi6zl7yOWDesRnk2NjOdWs2G4RLguC8pa1bgYpS9BQZiKVDrnEdLVLbFu0udnYzYuim5JaHhhbvQgc1HGxbzmQOzSrvJvCKx7KtNqZChS2OVHS9Cgl9iTBUgjnHMF2W3gZOWbiPt2zSDsPPI9G72VHh8gZNw1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 8 May
 2025 07:38:33 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 07:38:33 +0000
Message-ID: <685d5423-5b6a-4a11-9bef-50224e479f44@nvidia.com>
Date: Thu, 8 May 2025 00:38:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] selftests/fs/mount-notify: build with tools include
 dir
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-4-amir73il@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250507204302.460913-4-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 69715411-a3bc-48dd-a2a4-08dd8e0355ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVNYZ2pMYXFkeUk2UjJkeE9UQlFQRU14RG50VnJrRFpOYmdoMytaOEorNGxO?=
 =?utf-8?B?TWhvaVVFTGVVSUFCVzY4aE9UUDF3VVVpYS9vTWdBUW4yY1c4Wml2UTVheFhC?=
 =?utf-8?B?VXZvUEFTNi9hODVSanhUbmo1YytJdXNvek5ENkMvaU4xaHNBOTcxV3dnSWJB?=
 =?utf-8?B?aTU1VTRQbVl2VmZsbDBrR2kzSVhuTU01eHdPdUJueXkzQmdQZHEyOVQ0VStH?=
 =?utf-8?B?d1JHOHNTYWFNQ2NHbytUMDlrMEw2Q1p6ZktCeUlnaGRhL05IcE01ZVowNHBN?=
 =?utf-8?B?bzB5bUo1WlY3b2lvSzIrbVYvalZNRXdKMk9FL05jSFBhamZwSFhmR21OM2ZK?=
 =?utf-8?B?ZjBXeTEyZ05rTWxjZ01ERkJ6eFA3NEo1RkNOVW5vV0ZQTjZQMGJRc2NTVERQ?=
 =?utf-8?B?MjdSQUlwZ3FpL1NzamY3UGpZK04yci9NSU4vM3FlYW1vYSt3UWp0RWZ5QjUy?=
 =?utf-8?B?ME9WVWV2djBhaDNlc0phNVJmY3orWTdxWkZ0Y01DUnl0LzhQeDZ4ZGlobTlO?=
 =?utf-8?B?SUk2RWloWmM2MXV5RG9iM0pCUFhMLzFkUENIazlEb1ZlUmVXb1ZiY3piWENn?=
 =?utf-8?B?Nkc1VXk4UzNVUnlJbW5wWllvcXlMYzFBL2crRjdvakNhdW53dmx4ck1xRGZE?=
 =?utf-8?B?ZTBySzJFblBGak1qQ1h1emdLTzBBYkpBcDM3ZDlMZFp0OGw4czNYLzZzMFZy?=
 =?utf-8?B?YkZtM21qMU55SFE5bG1McXJzc3lCaE9yVnhwZG5zcDdVMWFPa3ltN2NTaWRK?=
 =?utf-8?B?bkRmR3hHT3NDT2NqN1RFRG12STdSZlpFbzlsUXhvOFRpOHY0YlFJLzZEZlpk?=
 =?utf-8?B?dVl3bHJXQ0tOUTJwbmFZMUlLbkhZaEZHZXArS24vK21tR3hFdmhleVA5S1Br?=
 =?utf-8?B?S3luMnpYd0grNWd3RDdoc3lUdVBPTitwNzlRcUpRd2lObWdDalQ4Rk9MNG43?=
 =?utf-8?B?QUN6U1V4bjNCUmFsb3dvUkgvZi9ibVprL3lCdmVpNEt4YytIaUJYNGpVVFB5?=
 =?utf-8?B?NE5VQXptaFBqeUFEVHZBbkFXaWFzWmxMRzJxemNTMlNIUEFjclZzTXpuQlNu?=
 =?utf-8?B?NXZtYW5STzFaSHRWdHhRdkJmQnpiMTB5akNjYzhkQUp5N3lZUjA3RmY1OTV6?=
 =?utf-8?B?ZFFCTXBFa2o1cHFZWTNLR3NUbXNRZUJiSDEyOWZnUjRvaThSbFQ2Mk5rMXV0?=
 =?utf-8?B?UEt4eHdSeGFobERFQVZBTHVLN0J0ZUcvT21QWmc2NzIwalZ3NkFXc1ZkSHRu?=
 =?utf-8?B?bEhZTVRRd3l2VWNFSTdKbkhYV1Q4cnZTYmlkZ0crSW1qRFJLeUloNHAwc1NC?=
 =?utf-8?B?NXIwTm0rcWFOODZQbHExaURxU2ZmVmwzZHk4WnFwOGdRb3R3ditTMlAxd0dm?=
 =?utf-8?B?dFRxWkwrSGRzWEhCS1c2b3FJM3I2VEhDd1Bnb0w3U3lqN2Q3N2Z0cVBCa01I?=
 =?utf-8?B?YndNbU5zNUc0dFU2eWpFZlRNV1pxenZsWTRYTmdldzRTbjVEVWtXT2VYNmdr?=
 =?utf-8?B?TTl1c0E3R0dJU3ZnQ2ZWdVpsV0lkM1dPKzY1UTArMmRFRmx2c294UmpsWHgz?=
 =?utf-8?B?SEdiRTVTV1BlN01FWnU2YkxnZHhDSGEwekxvNlFmdjZERGxCOVljVHhJZmty?=
 =?utf-8?B?RVljeDN3Q0RFSnpZWnNzZWdGK0VTb2g1ZFZ1U0RZYzVraEVWQ1YvaTJpYy9s?=
 =?utf-8?B?SEtJdG1CSHQvRmhRYlBKMkxyRm8zZkdPaXBRd1hqVW1ZK3FtUkdna2VnNlMx?=
 =?utf-8?B?ZFJDL25GNGJnT0tWbC9YeVczbzhldG52d1paTXA3OTBpanFqMk9TN2FuOEc3?=
 =?utf-8?B?U0FmdFJDU2FtNHlBNDJld0FMUzhoQ0p2VnZTMEVMeTFlVzBDeDlLQzkvcmpB?=
 =?utf-8?B?SUZDZGVBYmxFdFhyQXNSL3RlN2VUYS9NNWt6Mkx6eXhqYVp5T0hCUHo5UXo0?=
 =?utf-8?Q?Tv3xRU6UGRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejArVmdmTlkyQ0JEVUFVL0ZhUWFYOHBiNFFOL29TRE9lZCtpS0ZMUjhoUGNa?=
 =?utf-8?B?U21ZbHhVNVBsYmlpZHNVSVpBdmxUajdhUHhLMFBVWVlqMk0wNjZ4RHJHN1lq?=
 =?utf-8?B?ZjcvRHNwd0x4M2Q3SkIrQU83U3ppeEF1VXVaZUNvTGVDVmxVMVZrZVVMTERi?=
 =?utf-8?B?VHJtVncvZnQ4L3MzeWVvclptM210NEFsUURheFpMa2VUdGI3RU9pd21KTDJr?=
 =?utf-8?B?T2RKN3lmSkJabys5TkNDQzF6MnN1T3BFR1dFaURRQVhDeDNYckphaExMemxS?=
 =?utf-8?B?cUxhcmFUK0htRWZTR0oyejloaXEvNWdLaTUwY1BLRW1yc241VFhZZEhxVFNK?=
 =?utf-8?B?RHRpTUxOT2VnTkNlak1SUm02OFlSNDBLQXdSOVJEYzFwTTF5OTJkZHRuZ1B2?=
 =?utf-8?B?OFhyaU05U3RVcXBBVHFDelNsMHdlN3pzMzlOdmlOMFJ6QjFsWHV4OFhSc1JU?=
 =?utf-8?B?czZrek5ZWTRIeGxzbG9yeWxMaUg1Q0FoMGFsbWpDVVNHYVhYczROTHp3VVJq?=
 =?utf-8?B?M2NWSjVFallNZGJVeGZNY2dmcjlMREIra2Nuc3l6aFpzcllnQ2w1RC9aOXN0?=
 =?utf-8?B?c2NEalJwQzNxQkt2RXF1R2orbzNUUHpJWFFSUjlzMm1pNmhSVlpobWJkNGtn?=
 =?utf-8?B?WS9rQjdPcjBFcW5YZUNqVEExaXhhOTloTHN2SGhxbElSdjd3UTZZQ0pkMnl2?=
 =?utf-8?B?SjFvd1A1Q2o2bEYxN2xuMXArYUtZK0FvMjNaWjRVM2EwUVBrSXdJd1cvdXlo?=
 =?utf-8?B?UEdFMXJXUnlPbDBTYjFycmVNc2VLME1HS0g5OFhWa3B0cjBBUjNaNmVkbHdG?=
 =?utf-8?B?NllaYnplLzlSTExPcitCV29kSUdEdW9oNUFCRG93ZzE0dmFBT2trUzJWNXdH?=
 =?utf-8?B?YTl5cDhCd1JVaEJmcmhtQVV5ZzAzaXhxQzI3MWJyYWtaNFpRRnltTWNwS3c2?=
 =?utf-8?B?S3RJNVp3N3dzSXluM3lWeEpueFd1V25PaytxZFo3ZTZiZlh5QUZYODBmMnM0?=
 =?utf-8?B?TGVBUE1Pc1N1TG5xM1k0RzNyeWc4Zlo1RmRHL2dkN2w2RWR3UzIyRjE0SE81?=
 =?utf-8?B?MFN0YU9BNDUwMXdad1Mwb05pMmVzdWtEVXVwclptZ3d4U25VaERubHp3VjV2?=
 =?utf-8?B?T0lYV0E0dFo1TE9XTDB1VEliM2MrZkd0ZmVMdTZWM3U2Z0xyUWcwRXJCNVBR?=
 =?utf-8?B?ek5LNDBtVjFXbHpkcDhQMVpGZTM0MzlZVkRwSlFJWVFYMmZ6bjFndkFXTzJ6?=
 =?utf-8?B?L3I4eGl3ODhNWTNMcnZXSmJ4dCszWUlFNWl5STU4VjJ6RExmQmlGelZ4RHRJ?=
 =?utf-8?B?TGlFNkRya0FtOUFqeWRFSFNkYkRqdlIzREY1YXc1Q3BoZVJLUGluSjNNUVpW?=
 =?utf-8?B?WlBZMUQwdUF2SGhRM3BLd2VKeElxL3JqRWs3b0hlVzlVd3RJclI2UVIxVlZD?=
 =?utf-8?B?QlQwV0UvVmdva0NDMW81WmttdUdMWmtCd0dhS0hPdkNoQkJzV3p4dTgvVE9j?=
 =?utf-8?B?YU45NGJrMU1yeTJpeWI1eGlZQitxcTJWMEMxZ1V5N2tlWWJCcG5JT0UydHdW?=
 =?utf-8?B?L1FGQUFHeWt6cWQ4Y3cyYTJNOWx4MVBtR1R4Q1BQSjNUSU1nN0ZxSHNlNmt0?=
 =?utf-8?B?N0hOWE9TdkFxTWp5L2pzQ0lKaXJON3F3Q2FhTVh4T1VLcE84MDlPaXBKai9V?=
 =?utf-8?B?aS9ZR0VHdWp2YlE5RjFwZmxTWi9aUU9iQWw0Mll2cERKUE5EVmFFdFFEMnVq?=
 =?utf-8?B?QTBjS0U3SjFodk9IOERFdmpaRWxVZGZ2Mllyd2VSTU5lMmdTR0JkMmoyVzZa?=
 =?utf-8?B?Z0lXNjduUDZhd1lZUFY4empSRXFDOXpWREYzWGxLZlVBa3U5ZkttR1FyWUFH?=
 =?utf-8?B?RGxVcUh1enhKRm1JYkprSzNuL1h1TUxsSm5wLy9WSUp2L2ExUFE5c3VHa3F5?=
 =?utf-8?B?dWE5NnBaUVd3OHlsMjE0N1hkNk1aK3NKdW1DczRqbVdicktuaGxuSTZBOTRX?=
 =?utf-8?B?OWRycFJZMnJDaDh6UWo5cVpTZ09TRTVqSW1oNUcwY1R4TStNdGNCU0Qzd0hB?=
 =?utf-8?B?RVgwVXk2N1c3L0hPMXBvNTBNbkgvRCtFdnJaaERGYVpoT3ZST3UxZG56Z2ZD?=
 =?utf-8?B?MWx4dXUyaDZreVNmWHlxdDNKalIyYVBHclJ2UzFKT0NiRml6UXRtUlhaNUU1?=
 =?utf-8?Q?yj7YvFG77qijhxo1KUaviHU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69715411-a3bc-48dd-a2a4-08dd8e0355ca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:38:33.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xH4raCYrlnwcrapVcyAw4hiQuUNLKPdOwE3KEIQ7BFzUarC//fON0y1XfZ9YcHL+notyGmZoyvEIwg5u8CGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541

On 5/7/25 1:43 PM, Amir Goldstein wrote:
> Copy the fanotify uapi header files to the tools include dir
> and define __kernel_fsid_t to decouple dependency with headers_install
> and then remove the redundant re-definitions of fanotify macros.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   tools/include/uapi/linux/fanotify.h           | 274 ++++++++++++++++++
>   .../filesystems/mount-notify/Makefile         |   3 +-
>   .../mount-notify/mount-notify_test.c          |  25 +-
>   3 files changed, 282 insertions(+), 20 deletions(-)
>   create mode 100644 tools/include/uapi/linux/fanotify.h
> 
> diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/linux/fanotify.h
> new file mode 100644
> index 000000000000..e710967c7c26
> --- /dev/null
> +++ b/tools/include/uapi/linux/fanotify.h
> @@ -0,0 +1,274 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_FANOTIFY_H
> +#define _UAPI_LINUX_FANOTIFY_H
> +
> +#include <linux/types.h>
> +
> +/* the following events that user-space can register for */
> +#define FAN_ACCESS		0x00000001	/* File was accessed */
> +#define FAN_MODIFY		0x00000002	/* File was modified */
> +#define FAN_ATTRIB		0x00000004	/* Metadata changed */
> +#define FAN_CLOSE_WRITE		0x00000008	/* Writable file closed */
> +#define FAN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
> +#define FAN_OPEN		0x00000020	/* File was opened */
> +#define FAN_MOVED_FROM		0x00000040	/* File was moved from X */
> +#define FAN_MOVED_TO		0x00000080	/* File was moved to Y */
> +#define FAN_CREATE		0x00000100	/* Subfile was created */
> +#define FAN_DELETE		0x00000200	/* Subfile was deleted */
> +#define FAN_DELETE_SELF		0x00000400	/* Self was deleted */
> +#define FAN_MOVE_SELF		0x00000800	/* Self was moved */
> +#define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
> +
> +#define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
> +#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
> +
> +#define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
> +#define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
> +#define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
> +/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
> +
> +#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
> +#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
> +#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
> +
> +#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
> +
> +#define FAN_RENAME		0x10000000	/* File was renamed */
> +
> +#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
> +
> +/* helper events */
> +#define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
> +#define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO) /* moves */
> +
> +/* flags used for fanotify_init() */
> +#define FAN_CLOEXEC		0x00000001
> +#define FAN_NONBLOCK		0x00000002
> +
> +/* These are NOT bitwise flags.  Both bits are used together.  */
> +#define FAN_CLASS_NOTIF		0x00000000
> +#define FAN_CLASS_CONTENT	0x00000004
> +#define FAN_CLASS_PRE_CONTENT	0x00000008
> +
> +/* Deprecated - do not use this in programs and do not add new flags here! */
> +#define FAN_ALL_CLASS_BITS	(FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | \
> +				 FAN_CLASS_PRE_CONTENT)
> +
> +#define FAN_UNLIMITED_QUEUE	0x00000010
> +#define FAN_UNLIMITED_MARKS	0x00000020
> +#define FAN_ENABLE_AUDIT	0x00000040
> +
> +/* Flags to determine fanotify event format */
> +#define FAN_REPORT_PIDFD	0x00000080	/* Report pidfd for event->pid */
> +#define FAN_REPORT_TID		0x00000100	/* event->pid is thread id */
> +#define FAN_REPORT_FID		0x00000200	/* Report unique file id */
> +#define FAN_REPORT_DIR_FID	0x00000400	/* Report unique directory id */
> +#define FAN_REPORT_NAME		0x00000800	/* Report events with name */
> +#define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
> +#define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
> +#define FAN_REPORT_MNT		0x00004000	/* Report mount events */
> +
> +/* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
> +#define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> +/* Convenience macro - FAN_REPORT_TARGET_FID requires all other FID flags */
> +#define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
> +				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
> +
> +/* Deprecated - do not use this in programs and do not add new flags here! */
> +#define FAN_ALL_INIT_FLAGS	(FAN_CLOEXEC | FAN_NONBLOCK | \
> +				 FAN_ALL_CLASS_BITS | FAN_UNLIMITED_QUEUE |\
> +				 FAN_UNLIMITED_MARKS)
> +
> +/* flags used for fanotify_modify_mark() */
> +#define FAN_MARK_ADD		0x00000001
> +#define FAN_MARK_REMOVE		0x00000002
> +#define FAN_MARK_DONT_FOLLOW	0x00000004
> +#define FAN_MARK_ONLYDIR	0x00000008
> +/* FAN_MARK_MOUNT is		0x00000010 */
> +#define FAN_MARK_IGNORED_MASK	0x00000020
> +#define FAN_MARK_IGNORED_SURV_MODIFY	0x00000040
> +#define FAN_MARK_FLUSH		0x00000080
> +/* FAN_MARK_FILESYSTEM is	0x00000100 */
> +#define FAN_MARK_EVICTABLE	0x00000200
> +/* This bit is mutually exclusive with FAN_MARK_IGNORED_MASK bit */
> +#define FAN_MARK_IGNORE		0x00000400
> +
> +/* These are NOT bitwise flags.  Both bits can be used togther.  */
> +#define FAN_MARK_INODE		0x00000000
> +#define FAN_MARK_MOUNT		0x00000010
> +#define FAN_MARK_FILESYSTEM	0x00000100
> +#define FAN_MARK_MNTNS		0x00000110
> +
> +/*
> + * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
> + * for non-inode mark types.
> + */
> +#define FAN_MARK_IGNORE_SURV	(FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY)
> +
> +/* Deprecated - do not use this in programs and do not add new flags here! */
> +#define FAN_ALL_MARK_FLAGS	(FAN_MARK_ADD |\
> +				 FAN_MARK_REMOVE |\
> +				 FAN_MARK_DONT_FOLLOW |\
> +				 FAN_MARK_ONLYDIR |\
> +				 FAN_MARK_MOUNT |\
> +				 FAN_MARK_IGNORED_MASK |\
> +				 FAN_MARK_IGNORED_SURV_MODIFY |\
> +				 FAN_MARK_FLUSH)
> +
> +/* Deprecated - do not use this in programs and do not add new flags here! */
> +#define FAN_ALL_EVENTS (FAN_ACCESS |\
> +			FAN_MODIFY |\
> +			FAN_CLOSE |\
> +			FAN_OPEN)
> +
> +/*
> + * All events which require a permission response from userspace
> + */
> +/* Deprecated - do not use this in programs and do not add new flags here! */
> +#define FAN_ALL_PERM_EVENTS (FAN_OPEN_PERM |\
> +			     FAN_ACCESS_PERM)
> +
> +/* Deprecated - do not use this in programs and do not add new flags here! */
> +#define FAN_ALL_OUTGOING_EVENTS	(FAN_ALL_EVENTS |\
> +				 FAN_ALL_PERM_EVENTS |\
> +				 FAN_Q_OVERFLOW)
> +
> +#define FANOTIFY_METADATA_VERSION	3
> +
> +struct fanotify_event_metadata {
> +	__u32 event_len;
> +	__u8 vers;
> +	__u8 reserved;
> +	__u16 metadata_len;
> +	__aligned_u64 mask;
> +	__s32 fd;
> +	__s32 pid;
> +};
> +
> +#define FAN_EVENT_INFO_TYPE_FID		1
> +#define FAN_EVENT_INFO_TYPE_DFID_NAME	2
> +#define FAN_EVENT_INFO_TYPE_DFID	3
> +#define FAN_EVENT_INFO_TYPE_PIDFD	4
> +#define FAN_EVENT_INFO_TYPE_ERROR	5
> +#define FAN_EVENT_INFO_TYPE_RANGE	6
> +#define FAN_EVENT_INFO_TYPE_MNT		7
> +
> +/* Special info types for FAN_RENAME */
> +#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
> +/* Reserved for FAN_EVENT_INFO_TYPE_OLD_DFID	11 */
> +#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME	12
> +/* Reserved for FAN_EVENT_INFO_TYPE_NEW_DFID	13 */
> +
> +/* Variable length info record following event metadata */
> +struct fanotify_event_info_header {
> +	__u8 info_type;
> +	__u8 pad;
> +	__u16 len;
> +};
> +
> +/*
> + * Unique file identifier info record.
> + * This structure is used for records of types FAN_EVENT_INFO_TYPE_FID,
> + * FAN_EVENT_INFO_TYPE_DFID and FAN_EVENT_INFO_TYPE_DFID_NAME.
> + * For FAN_EVENT_INFO_TYPE_DFID_NAME there is additionally a null terminated
> + * name immediately after the file handle.
> + */
> +struct fanotify_event_info_fid {
> +	struct fanotify_event_info_header hdr;
> +	__kernel_fsid_t fsid;
> +	/*
> +	 * Following is an opaque struct file_handle that can be passed as
> +	 * an argument to open_by_handle_at(2).
> +	 */
> +	unsigned char handle[];
> +};
> +
> +/*
> + * This structure is used for info records of type FAN_EVENT_INFO_TYPE_PIDFD.
> + * It holds a pidfd for the pid that was responsible for generating an event.
> + */
> +struct fanotify_event_info_pidfd {
> +	struct fanotify_event_info_header hdr;
> +	__s32 pidfd;
> +};
> +
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +};
> +
> +struct fanotify_event_info_range {
> +	struct fanotify_event_info_header hdr;
> +	__u32 pad;
> +	__u64 offset;
> +	__u64 count;
> +};
> +
> +struct fanotify_event_info_mnt {
> +	struct fanotify_event_info_header hdr;
> +	__u64 mnt_id;
> +};
> +
> +/*
> + * User space may need to record additional information about its decision.
> + * The extra information type records what kind of information is included.
> + * The default is none. We also define an extra information buffer whose
> + * size is determined by the extra information type.
> + *
> + * If the information type is Audit Rule, then the information following
> + * is the rule number that triggered the user space decision that
> + * requires auditing.
> + */
> +
> +#define FAN_RESPONSE_INFO_NONE		0
> +#define FAN_RESPONSE_INFO_AUDIT_RULE	1
> +
> +struct fanotify_response {
> +	__s32 fd;
> +	__u32 response;
> +};
> +
> +struct fanotify_response_info_header {
> +	__u8 type;
> +	__u8 pad;
> +	__u16 len;
> +};
> +
> +struct fanotify_response_info_audit_rule {
> +	struct fanotify_response_info_header hdr;
> +	__u32 rule_number;
> +	__u32 subj_trust;
> +	__u32 obj_trust;
> +};
> +
> +/* Legit userspace responses to a _PERM event */
> +#define FAN_ALLOW	0x01
> +#define FAN_DENY	0x02
> +/* errno other than EPERM can specified in upper byte of deny response */
> +#define FAN_ERRNO_BITS	8
> +#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
> +#define FAN_ERRNO_MASK	((1 << FAN_ERRNO_BITS) - 1)
> +#define FAN_DENY_ERRNO(err) \
> +	(FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT))
> +
> +#define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
> +#define FAN_INFO	0x20	/* Bitmask to indicate additional information */
> +
> +/* No fd set in event */
> +#define FAN_NOFD	-1
> +#define FAN_NOPIDFD	FAN_NOFD
> +#define FAN_EPIDFD	-2
> +
> +/* Helper functions to deal with fanotify_event_metadata buffers */
> +#define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> +
> +#define FAN_EVENT_NEXT(meta, len) ((len) -= (meta)->event_len, \
> +				   (struct fanotify_event_metadata*)(((char *)(meta)) + \
> +				   (meta)->event_len))
> +
> +#define FAN_EVENT_OK(meta, len)	((long)(len) >= (long)FAN_EVENT_METADATA_LEN && \
> +				(long)(meta)->event_len >= (long)FAN_EVENT_METADATA_LEN && \
> +				(long)(meta)->event_len <= (long)(len))
> +
> +#endif /* _UAPI_LINUX_FANOTIFY_H */
> diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/mount-notify/Makefile
> index 10be0227b5ae..41ebfe558a0a 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/Makefile
> +++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
> +CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +
>   TEST_GEN_PROGS := mount-notify_test
>   
>   include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> index 59a71f22fb11..4f0f325379b5 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -8,33 +8,20 @@
>   #include <string.h>
>   #include <sys/stat.h>
>   #include <sys/mount.h>
> -#include <linux/fanotify.h>
>   #include <unistd.h>
> -#include <sys/fanotify.h>
>   #include <sys/syscall.h>
>   
>   #include "../../kselftest_harness.h"
>   #include "../statmount/statmount.h"
>   
> -#ifndef FAN_MNT_ATTACH
> -struct fanotify_event_info_mnt {
> -	struct fanotify_event_info_header hdr;
> -	__u64 mnt_id;
> -};
> -#define FAN_MNT_ATTACH 0x01000000 /* Mount was attached */
> -#endif
> -
> -#ifndef FAN_MNT_DETACH
> -#define FAN_MNT_DETACH 0x02000000 /* Mount was detached */
> +// Needed for linux/fanotify.h

Is the comment accurate? Below, we are include sys/fanotify.h, not
linux/fanotify.h


> +#ifndef __kernel_fsid_t
> +typedef struct {
> +	int	val[2];
> +} __kernel_fsid_t;
>   #endif
>   
> -#ifndef FAN_REPORT_MNT
> -#define FAN_REPORT_MNT 0x00004000 /* Report mount events */
> -#endif
> -
> -#ifndef FAN_MARK_MNTNS
> -#define FAN_MARK_MNTNS 0x00000110
> -#endif
> +#include <sys/fanotify.h>

Are you sure that you're including your newly added fanotify.h? Because
it looks to me like you might be including your local installed version,
instead. I don't see how it can include

     tools/include/uapi/linux/fanotify.h

...with the above invocation.

>   
>   static uint64_t get_mnt_id(struct __test_metadata *const _metadata,
>   			   const char *path)

thanks,
-- 
John Hubbard



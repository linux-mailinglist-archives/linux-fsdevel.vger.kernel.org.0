Return-Path: <linux-fsdevel+bounces-58337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B1B2CC6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6B1BC06CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D1530F543;
	Tue, 19 Aug 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="QcnaMons"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2023.outbound.protection.outlook.com [40.92.90.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFA31194C;
	Tue, 19 Aug 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629526; cv=fail; b=Hy6qNkNAalRhNTP0FPoWFEBMkQt9a9OiByE6d0Kx6aGKhPPXQq0K7a1m+BQDbGWbx87K6qBRKvEYAqnOm5g6jNNSzUFpkC7tPsOO1bdWvoAUfKwtgF76vdMqx7mBZ1rbcSinoFx4DrILveD7Uu4zJL0R1+iJ7CB/3QaxpK7cmWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629526; c=relaxed/simple;
	bh=KxKdaWSXCCsWWufnm7b3cmpmeGBWEV8amhZ7wSsp21o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdDCB9nJSlhfkNwn6N9Dxp2SviAeT4HSoD8Vwge0ABnmKwavYed6zI9pZmfE+QXSJOAUqk9JGBYsCtM1KTYVY5kjdkXJO+WKBg0N5TEosYhdEtdHVJHTeg30tsfi2Zo0QTsHuEKjlnIOo5nH83RN3cnKfVhJZIG8a2PL9hQPhd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=QcnaMons; arc=fail smtp.client-ip=40.92.90.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRCuNuaB92wtvR9Xvd9i2tLR7+mHQJbniCt2RK77EIzS9CvbTTWLWkH8KdG+EgLDLlBuw3TwRc76QHpK8LhXO0c7GWw7emIU+os4tE8SzKbHjJ5e/zVJ7wUdLFe29nPysGuDheCWOFW7fnGfWKjeh6T9dhVTk+ntzPtbJJ/ee9pKvSqqZP3l2D1tavdeHrl+nSK0oQWpj2y55GJ66mcEf1uZjoxouk9WImWRjkax1oi2TF4KQ54X2hXpS1MfkMsGoTqjj9cpccwBRYnZkd/EOynD9Jf36mq5tZhPTWQ3IeUAp9WMhGJyoBLC9VsC+u/t8UJ9qojA6+0NpdF6qj2Q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYg0NRAUDd+ctHob8z0rVLRm0UJ8s9AWvALSagovX7E=;
 b=k6ltlBYf3QB+U8XK0Me3cD06Qg2hy8wqachEhbwvNT8eHFomc53AOKsKebwSs55mP8jOqvuEDrAttOC5ts30s9QMAFkmJvZc2ZhWZAGgTWTUo1tKPP/5tFk0PZXbucah4v4Wb7hXJdXuMFGxc6z8uD/q3ezqlyRtU5Dknm/BOUbIOZ41WxQTdl31GcOJ3OwPP2cjhHl802Ys2+CkF6fNWg1D1gCXCaNeT3IUrJsvpTAOF73AD4ETPfDSpzsb1qrQSw9Eb0mdVeFTQM7R+Jhf7/Ovjv1De/FjY5HBEiGNEtcTVXfdnjElTziYPMVcC1yNsr8Qwb5Owvkp/59fimznvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYg0NRAUDd+ctHob8z0rVLRm0UJ8s9AWvALSagovX7E=;
 b=QcnaMonsWGvVCC3sD/UAtE4cceKydr6K2M73Uo/dZvkEv0grG0Otl0krLp5K+OwTzOiS6wFWGEvACOkl5bzRxQ1RB3YRjP4DBUXSKgsrwjuYa9Za+jqIb4Djc7I8XWPEahED/aA4vX/KrG4ozsooIXMCNkD3qmPPeYFC9ScTpoitKk3W8v3a0lIH5qsOSy1NfNrwpxzwtYgI2GnXYJNH46LzoLvZBaq2/4xEMAtnsjXw+NH9hPYePG/NlU7vno4eCAKHwLt8Asln854gQEUJW8omUt/wNrfww2+zwGPiuHzt0utp6nQM6uDctTGYFEYeJm3yD3m6f4ZRY0EAyz3Gew==
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4) by DB9P195MB1659.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:392::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 18:51:59 +0000
Received: from GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::b175:8fa1:21bd:f192]) by GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 ([fe80::b175:8fa1:21bd:f192%6]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 18:51:59 +0000
Message-ID:
 <GV2PPF74270EBEE3A1663E566B8F640EC59E430A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Date: Tue, 19 Aug 2025 20:53:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16] exec: Fix dead-lock in de_thread with ptrace_attach
To: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Serge Hallyn <serge@hallyn.com>, James Morris
 <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>,
 Helge Deller <deller@gmx.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Adrian Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 tiozhang <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>,
 "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Frederic Weisbecker <frederic@kernel.org>, YueHaibing
 <yuehaibing@huawei.com>, Paul Moore <paul@paul-moore.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Stefan Roesch <shr@devkernel.io>,
 Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>,
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <dchinner@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>,
 David Windsor <dwindsor@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hans Liljestrand <ishkamiel@gmail.com>
References: <AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <AS8P193MB1285DF698D7524EDE22ABFA1E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB12851AC1F862B97FCE9B3F4FE4AAA@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285FF445694F149B70B21D0E46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285937F9831CECAF2A9EEE2E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEEDE0B9742310DE91E9A7E431A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <202508182113.63CF4DA866@keescook>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <202508182113.63CF4DA866@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::8d4)
X-Microsoft-Original-Message-ID:
 <26e19006-2786-42ca-93c7-059c499e2af1@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PPF74270EBEE:EE_|DB9P195MB1659:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deaa5b4-47a7-4069-f058-08dddf517a34
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|23021999003|461199028|41001999006|6090799003|5072599009|19110799012|1602099012|10035399007|3412199025|440099028|40105399003|4302099013|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVAyMkd2TU05K3d0VDlIWnRQckRVbE9RWnB2Ylh2Tm9DMGFsc1FReFlKMkt6?=
 =?utf-8?B?QlBkOW9FcTlQcFc3VXVXa3MxbFZSa1MxRU9zckFCeXBiYUZ3djkzN3V5QUNN?=
 =?utf-8?B?MThFM09IcjV1cktlOVBpWjN4SFFYdUhySHlIT3hBZXhIQk1ZdzNQekowMmZN?=
 =?utf-8?B?TnQzZHBwUGp3bnNIUHcxVzZlZTcweUZuV0laclliZWVuL3gwREYya3lmK2Vi?=
 =?utf-8?B?SXFZUi9JUEFXSGZTcitGL0QramJRSkcyTmoyRzZmSU95TnNpZXJKUlYrUkVq?=
 =?utf-8?B?TjdrbStvZksydmoxVDV6eFQ0WkFQSmRVcGRhNTRDbW5yQkRHRmY3Ui9teUFs?=
 =?utf-8?B?NlEyUWhTeWRtdVZmbW1qc09MVUhrMFZEMXc4YVZhMGttREVEUFFkWUJ0c1BO?=
 =?utf-8?B?dnZzOGlkTTk2WTR5aWZJcm1mazNJblR2dWFsSyt3c0hkM1BRdFpvM2JkUFhv?=
 =?utf-8?B?K3cybzhmbHh2NlVib1hRUlRXdmtiejY2NnVhSFdiNjU4dkRuM3U4c1B6R1JS?=
 =?utf-8?B?VFJQaW1qWTY5MEZlYm56WEJxZ0V2YytOUnQveElOZEFvaDluMk9zVk03WVRI?=
 =?utf-8?B?ZXZ1T2x3Z2FWZWI2SHF2MzlqWjBvREd2STdCZmZrVjJuL1pvTHZXTDN1NGc0?=
 =?utf-8?B?OWNySXU2bWw3S2hxL2VPSWYvNmlJSUhTQnhUbzM1Ky81UHlNa0dxRkkrclA5?=
 =?utf-8?B?U3ZPSmJWU3kvWlk2S3BJUDlaQlpyUVNsUUFvejRaRFhjRVVFMHRKWkVjTVFR?=
 =?utf-8?B?Y2lpUXRkVFZkR0tBYmZnVHBOWEtPbXdOL0dKSGE5Ynl1eElDOUVMaktTc2V1?=
 =?utf-8?B?ekpDZFZhNHRSVklwUWhIUWw4VUFuWWtEOUU2VU5hUW5iM2FZZkxScmo0WThy?=
 =?utf-8?B?OVhUaTV6K3g2TWNrRTJzb01KTG51Q3BZM05meW9saVo5eTlOV3hjUmxockNE?=
 =?utf-8?B?WjB1KzJlWnNWOVBBd2RtRXlER1pZY1R6a2lvdlBLd3dkNXRnWkZ5dnA4cXc2?=
 =?utf-8?B?M0VaMnhsTHcrUGNHYUVXVTAwVzhPWjl1MGtreE1KaHg4akJXWWRwc2NoRVdO?=
 =?utf-8?B?Vk5IeDZ3R2ZSeGd6THdyTC9nb2l2bHhVS0JXNi9sc0ZpT2dwMjRDR3VBS0FS?=
 =?utf-8?B?c2ZhZURWcVNYenova0lqeEk0byt3eE80U1Yvc2RHLzBUMnhSSlA5SWZqTEs1?=
 =?utf-8?B?REhybTRQRXJRM3dZdkVHSWgvRzZ5UTNIQ2U0MnU0RklxSzkvRmc3NU5obUJB?=
 =?utf-8?B?OXZYTkZKT1FqSlExVjlsQ3kyMGNQcE1VZWpHZUZoNlJHeTNWYjRMdFR2NFhm?=
 =?utf-8?B?SGo5RzRsaHdUbktIdjg2blQ1VTVwbHFyWmVxUWVuUW5odFRSTm1nMGN2ejY3?=
 =?utf-8?B?bTcxMkZTQkowWTNWZ3FQWDN5cGVIK3hSZGNwTXNyYm0vSGM4eEV2SEkvZlZw?=
 =?utf-8?B?bVZ1RWNEWTEwdERiakVORW1UQkR4a3ptZHNHSHZZZ21UTW81ajhjWmEvd2Vm?=
 =?utf-8?B?RURGdTRESnorNVdKZkx2UnFIWUg4YXJHVHlySjhMZjlWbWQwbmpxcmExcko5?=
 =?utf-8?B?UlJjL3JUV0lyQ2xLWWVGbDJMMTZYUEIwakFVRnZlWFpDd0taSUtEY3M1SUlh?=
 =?utf-8?B?UUNWRmpGaXhFaklXOVB2OGtuWEFrb0ZLdVZaMUlzV2pCdUU2MUU0Qms5Q0Z1?=
 =?utf-8?B?aUxGaWJiOEFXUGdmTUpMSUxxekY1K05tS3ByYXdjSnlkS3VaYmxKc3h3dG5L?=
 =?utf-8?Q?HQviWBn5vBfpJ2fblLVw3g3vPoEBKxlEFrTpGvG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGJCVEFyUUdOZEJHSXpvZmt2eCsvSXJ1MjRYaXdjYTZ6MFprNXdrVFFIamZI?=
 =?utf-8?B?WTVpV1ZTSXB5UkR6V3JVY091WlpHRk9JYzhEV2hEbGdLeXVaOFkyd0NVU1Rm?=
 =?utf-8?B?R0RIRDBMYmlEUzc3RnVMZ216dzlsNGovT1J0d1l4VDlCUXVBbklKNnZ0Ni9Q?=
 =?utf-8?B?ZG9oN09WdXF5Q0tiWHVFYUxaazRBK0k1amU3TEVUSis4NnRJN3VEa1JTNXZP?=
 =?utf-8?B?UGJ5eDd4dTFneUJaWC9BRE1VR3FYWGdZRFJMN1kzT3FYWGkyR3pYVExlRVhr?=
 =?utf-8?B?SzY3OVBCUDFvcDRkOFJEaWg4Y2xkbm05alVXb1hHWDBTQUhXSjdseHN3Qklo?=
 =?utf-8?B?VWI2Nk1OWmhhQ2ZnQkc3ajA1SXkxSXprZkpUTUFaTzMxcjZWSWhLc00wMUdR?=
 =?utf-8?B?aEw2NEpwY040Y2ZZWDF0anNwUnp2ODlYd1FXZFF2MnhRZEpSSGtqckhSSW5H?=
 =?utf-8?B?alFacGUwTHVzcWdmUzVFTUlxWXhFL1ZFL0lydDlnYVBtcE5lVWdrZWxNZXRi?=
 =?utf-8?B?aTYzUjdyWSswc2xWdzQxN2JXeHlYUUQvQ3NYcjNNYkpxYlRmNUs3NEFmQi8x?=
 =?utf-8?B?ZitBbHllL0JXQTVaazBRaHZYSUkwejhNWVhUeHE4RXBXNjNmREUxMnZuV2Fw?=
 =?utf-8?B?OGIzNFVKVS9PdTNKQ3B6R1NOaWxaVkg4WUR4M2pEMXo2T2dlTkJjKzRIS3lT?=
 =?utf-8?B?QXEwbGlFVjU2L25UVnlVZjdmcDB0b054d09uTXNuaGV1NFNSUTB1aDlMMjJp?=
 =?utf-8?B?QXN1dGhhdGd3djRIbldPS1dnRGtjU1VvTzY0dlNoSjFITmN6NUsvSThWdC9Z?=
 =?utf-8?B?VUZSV1ljR2ttOU9UV3h3MWVqbFBXaVFYbXZ6TTZJRW5LYkhwSUl3M3NCWGo4?=
 =?utf-8?B?WVY4TmtWOXRGbHhycHNTRXFUamZzWm9rY0p2MmF2eS9rdFpWWjVybjhEOTh4?=
 =?utf-8?B?dEYyVnFybDBoTm9HMDROWGlnM25kMjB6SkZCcUx6ZDRtUFFqQnFTc3hTWXli?=
 =?utf-8?B?TnhSeGVsa3dMWnZhQzJpNk5sNFA5OEN0UFRWZFh3bGp5aDhpa09LVThMa2o1?=
 =?utf-8?B?bFVOK0dJUGdyYUo5WGx3NWFLR3F1dG9sODdVb3JaRi9jUldpUDJObmk2ZzNG?=
 =?utf-8?B?dzR6VXZlaHhIa2RWMzVic1hxcjlyMFJtWVlaRjBzUllweWk5K2NBNW5DanBp?=
 =?utf-8?B?dWpwU3VrdEhTd3Z1Y3p1S0NvZVJuVXNiWmZTR2tpK08vZTRXWThxMWJWSkhq?=
 =?utf-8?B?SlM4cnBWcnN4dG00Qk5LZFFBRENJaWdHLzZWZjNSVHhVcDdySGlOY3B5Qy8v?=
 =?utf-8?B?K0xCbEI3UXZrZklHWm9hYnJFMHdJTzVaV1Q5Ry8zYngySkpNeUs0ZHNLdjR4?=
 =?utf-8?B?aENkZGlRS2UzcDYxYzY2Yzh5ZmplZythU1FhOFZQMC9BV2NGbUFMOVZjbkFy?=
 =?utf-8?B?Q2ttTzJTRC9iYVF5SmM3SWNhSVdINVBnZ2tmU0ZLcFdFbFduOFk4SURQU0ZX?=
 =?utf-8?B?QmJBYzNCenBhK0ZXNE8vVWttdEFTVlVYcyt5WjcvZFRRdTI3bVZtZm5SWlNi?=
 =?utf-8?B?d0ZYVUJRMXZOQUJwdVQwQi9sRVhYbnB6dUFDVEpZY2RoR0tLcS90V3VzNmo3?=
 =?utf-8?B?SXdkVTd6Uy9wandFWGpxWDFTM0d2eEZBbjFUZ1c3SzNQNVNCaHhlZ0lkaG0y?=
 =?utf-8?B?M2pkN0tjZlhYcGs5Q3BCc2had0dGKzl0Y2dqYml0U0lOekgzZmlDeUtKaHBU?=
 =?utf-8?Q?BE7DRkv2GwZds3vP1IzdG7X5SiIM7nKZiZ0pr2Q?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-87dd8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deaa5b4-47a7-4069-f058-08dddf517a34
X-MS-Exchange-CrossTenant-AuthSource: GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 18:51:59.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1659

Hi Kees,

thanks for your response.

On 8/19/25 06:36, Kees Cook wrote:
> On Mon, Aug 18, 2025 at 10:53:43PM +0200, Bernd Edlinger wrote:
>> This introduces signal->exec_bprm, which is used to
>> fix the case when at least one of the sibling threads
>> is traced, and therefore the trace process may dead-lock
>> in ptrace_attach, but de_thread will need to wait for the
>> tracer to continue execution.
>>
[...]
>>  
>> -static int de_thread(struct task_struct *tsk)
>> +static int de_thread(struct task_struct *tsk, struct linux_binprm *bprm)
>>  {
>>  	struct signal_struct *sig = tsk->signal;
>>  	struct sighand_struct *oldsighand = tsk->sighand;
>>  	spinlock_t *lock = &oldsighand->siglock;
>> +	struct task_struct *t;
>> +	bool unsafe_execve_in_progress = false;
>>  
>>  	if (thread_group_empty(tsk))
>>  		goto no_thread_group;
>> @@ -932,6 +934,19 @@ static int de_thread(struct task_struct *tsk)
>>  	if (!thread_group_leader(tsk))
>>  		sig->notify_count--;
>>  
>> +	for_other_threads(tsk, t) {
>> +		if (unlikely(t->ptrace)
>> +		    && (t != tsk->group_leader || !t->exit_state))
>> +			unsafe_execve_in_progress = true;
>> +	}
>> +
>> +	if (unlikely(unsafe_execve_in_progress)) {
>> +		spin_unlock_irq(lock);
>> +		sig->exec_bprm = bprm;
>> +		mutex_unlock(&sig->cred_guard_mutex);
>> +		spin_lock_irq(lock);
>> +	}
>> +
> 
> cred_guard_mutex has a comment about it being deprecated and shouldn't
> be used in "new code"... Regardless, what cred_guard_mutex is trying to
> protect is changing to credentials.
> 
> But what we want to stop is having new threads appear, which
> spin_lock_irq(lock) should stop, yes?
> 

Yes, but after the fatal signal is sent to all threads, releasing the
sighand->siglock is okay, since no new threads can be cloned any more,
because kernel/fork.c checks for pending fatal signals after acquiring the
mutex and before adding another thread to the list:

        spin_lock(&current->sighand->siglock);

        rv_task_fork(p);

        rseq_fork(p, clone_flags);

        /* Don't start children in a dying pid namespace */
        if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
                retval = -ENOMEM;
                goto bad_fork_core_free;
        }

        /* Let kill terminate clone/fork in the middle */
        if (fatal_signal_pending(current)) {
                retval = -EINTR;
                goto bad_fork_core_free;
        }

        /* No more failure paths after this point. */


>>  	while (sig->notify_count) {
>>  		__set_current_state(TASK_KILLABLE);
>>  		spin_unlock_irq(lock);
>> @@ -1021,6 +1036,11 @@ static int de_thread(struct task_struct *tsk)
>>  		release_task(leader);
>>  	}
>>  
>> +	if (unlikely(unsafe_execve_in_progress)) {
>> +		mutex_lock(&sig->cred_guard_mutex);
>> +		sig->exec_bprm = NULL;
>> +	}
>> +
>>  	sig->group_exec_task = NULL;
>>  	sig->notify_count = 0;
>>  
>> @@ -1032,6 +1052,11 @@ static int de_thread(struct task_struct *tsk)
>>  	return 0;
>>  
>>  killed:
>> +	if (unlikely(unsafe_execve_in_progress)) {
>> +		mutex_lock(&sig->cred_guard_mutex);
>> +		sig->exec_bprm = NULL;
>> +	}
> 
> I think we need to document that cred_guard_mutex now protects
> sig->exec_bprm.
> 

Maybe, I thought that it would be clear by this description:

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -237,9 +237,27 @@ struct signal_struct {
        struct mm_struct *oom_mm;       /* recorded mm when the thread group got
                                         * killed by the oom killer */
 
+       struct linux_binprm *exec_bprm; /* Used to check ptrace_may_access
+                                        * against new credentials while
+                                        * de_thread is waiting for other
+                                        * traced threads to terminate.
+                                        * Set while de_thread is executing.
+                                        * The cred_guard_mutex is released
+                                        * after de_thread() has called
+                                        * zap_other_threads(), therefore
+                                        * a fatal signal is guaranteed to be
+                                        * already pending in the unlikely
+                                        * event, that
+                                        * current->signal->exec_bprm happens
+                                        * to be non-zero after the
+                                        * cred_guard_mutex was acquired.
+                                        */
+
        struct mutex cred_guard_mutex;  /* guard against foreign influences on
                                         * credential calculations
                                         * (notably. ptrace)
+                                        * Held while execve runs, except when
+                                        * a sibling thread is being traced.
                                         * Deprecated do not use in new code.
                                         * Use exec_update_lock instead.
                                         */


>> +
>>  	/* protects against exit_notify() and __exit_signal() */
>>  	read_lock(&tasklist_lock);
>>  	sig->group_exec_task = NULL;
>> @@ -1114,13 +1139,31 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  	 */
>>  	trace_sched_prepare_exec(current, bprm);
>>  
>> +	/* If the binary is not readable then enforce mm->dumpable=0 */
>> +	would_dump(bprm, bprm->file);
>> +	if (bprm->have_execfd)
>> +		would_dump(bprm, bprm->executable);
>> +
>> +	/*
>> +	 * Figure out dumpability. Note that this checking only of current
>> +	 * is wrong, but userspace depends on it. This should be testing
>> +	 * bprm->secureexec instead.
>> +	 */
>> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
>> +	    is_dumpability_changed(current_cred(), bprm->cred) ||
>> +	    !(uid_eq(current_euid(), current_uid()) &&
>> +	      gid_eq(current_egid(), current_gid())))
>> +		set_dumpable(bprm->mm, suid_dumpable);
>> +	else
>> +		set_dumpable(bprm->mm, SUID_DUMP_USER);
>> +
> 
> Why is this move needed? While it's writing to bprm, I see it's reading
> from "current". Is this safe to do before de_thread() has happened?
> Can't a sibling thread manipulate things here? What lock am I missing?
> 

The credentials should be protected by cred_guard_mutex here, and/or
current->signal->exec_bprm in case there are ptraced threads.
 
I need this earlier because the outcome of ptrace_may_access
for the new credentials depends on the dumpability.

So when de_thread has to release the mutex, a ptrace_attach
is possible without deadlock, but the tracer's access rights must
be sufficient to access the current and the new credentials because,
the tracer will receive the stop event immediately after the
execve succeeds and the new credentials are in effect, or
if the execve fails the stop event will see the old process
using the old credentials dying of a fatal signal.

>>  	/*
>>  	 * Ensure all future errors are fatal.
>>  	 */
>>  	bprm->point_of_no_return = true;
>>  
>>  	/* Make this the only thread in the thread group */
>> -	retval = de_thread(me);
>> +	retval = de_thread(me, bprm);
>>  	if (retval)
>>  		goto out;
>>  	/* see the comment in check_unsafe_exec() */
>> @@ -1144,11 +1187,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  	if (retval)
>>  		goto out;
>>  
>> -	/* If the binary is not readable then enforce mm->dumpable=0 */
>> -	would_dump(bprm, bprm->file);
>> -	if (bprm->have_execfd)
>> -		would_dump(bprm, bprm->executable);
>> -
>>  	/*
>>  	 * Release all of the old mmap stuff
>>  	 */
>> @@ -1210,18 +1248,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  
>>  	me->sas_ss_sp = me->sas_ss_size = 0;
>>  
>> -	/*
>> -	 * Figure out dumpability. Note that this checking only of current
>> -	 * is wrong, but userspace depends on it. This should be testing
>> -	 * bprm->secureexec instead.
>> -	 */
>> -	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
>> -	    !(uid_eq(current_euid(), current_uid()) &&
>> -	      gid_eq(current_egid(), current_gid())))
>> -		set_dumpable(current->mm, suid_dumpable);
>> -	else
>> -		set_dumpable(current->mm, SUID_DUMP_USER);
>> -
>>  	perf_event_exec();
>>  
>>  	/*
>> @@ -1361,6 +1387,11 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
>>  	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>>  		return -ERESTARTNOINTR;
>>  
>> +	if (unlikely(current->signal->exec_bprm)) {
>> +		mutex_unlock(&current->signal->cred_guard_mutex);
>> +		return -ERESTARTNOINTR;
>> +	}
>> +
>>  	bprm->cred = prepare_exec_creds();
>>  	if (likely(bprm->cred))
>>  		return 0;
[...]
>> diff --git a/kernel/cred.c b/kernel/cred.c
>> index 9676965c0981..0b2822c762df 100644
>> --- a/kernel/cred.c
>> +++ b/kernel/cred.c
>> @@ -375,6 +375,30 @@ static bool cred_cap_issubset(const struct cred *set, const struct cred *subset)
>>  	return false;
>>  }
>>  
>> +/**
>> + * is_dumpability_changed - Will changing creds affect dumpability?
>> + * @old: The old credentials.
>> + * @new: The new credentials.
>> + *
>> + * If the @new credentials have no elevated privileges compared to the
>> + * @old credentials, the task may remain dumpable.  Otherwise we have
>> + * to mark the task as undumpable to avoid information leaks from higher
>> + * to lower privilege domains.
>> + *
>> + * Return: True if the task will become undumpable.
>> + */
>> +bool is_dumpability_changed(const struct cred *old, const struct cred *new)
> 
> This should be "static", I think?
> 

No, because I want to use this function also in begin_new_exec in the moved code,
to include the expected outcome of commit_creds before de_thread, to make sure the
result of ptrace_may_access is as if the new credentials were already committed.


>> +{
>> +	if (!uid_eq(old->euid, new->euid) ||
>> +	    !gid_eq(old->egid, new->egid) ||
>> +	    !uid_eq(old->fsuid, new->fsuid) ||
>> +	    !gid_eq(old->fsgid, new->fsgid) ||
>> +	    !cred_cap_issubset(old, new))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>  /**
>>   * commit_creds - Install new credentials upon the current task
>>   * @new: The credentials to be assigned
>> @@ -403,11 +427,7 @@ int commit_creds(struct cred *new)
>>  	get_cred(new); /* we will require a ref for the subj creds too */
>>  
>>  	/* dumpability changes */
>> -	if (!uid_eq(old->euid, new->euid) ||
>> -	    !gid_eq(old->egid, new->egid) ||
>> -	    !uid_eq(old->fsuid, new->fsuid) ||
>> -	    !gid_eq(old->fsgid, new->fsgid) ||
>> -	    !cred_cap_issubset(old, new)) {
>> +	if (is_dumpability_changed(old, new)) {
>>  		if (task->mm)
>>  			set_dumpable(task->mm, suid_dumpable);
>>  		task->pdeath_signal = 0;
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 75a84efad40f..deacdf133f8b 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/ptrace.h>
>>  #include <linux/security.h>
>> +#include <linux/binfmts.h>
>>  #include <linux/signal.h>
>>  #include <linux/uio.h>
>>  #include <linux/audit.h>
>> @@ -453,6 +454,27 @@ static int ptrace_attach(struct task_struct *task, long request,
>>  				return retval;
>>  		}
>>  
>> +		if (unlikely(task->in_execve)) {
> 
> Urgh, we're trying to get rid of this bit too.
> https://lore.kernel.org/all/72da7003-a115-4162-b235-53cd3da8a90e@I-love.SAKURA.ne.jp/
> 
> Can we find a better indicator?
> 

Hmm, Yes, I agree.
I start to think that task->signal->exec_bprm would indeed be a better indicator:

--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -454,7 +454,7 @@ static int ptrace_attach(struct task_struct *task, long request,
                                return retval;
                }
 
-               if (unlikely(task->in_execve)) {
+               if (unlikely(task->signal->exec_bprm)) {
                        retval = down_write_killable(&task->signal->exec_update_lock);
                        if (retval)
                                return retval;

So I will add this to the next patch version.

>> +			retval = down_write_killable(&task->signal->exec_update_lock);
>> +			if (retval)
>> +				return retval;
>> +
>> +			scoped_guard (task_lock, task) {
>> +				struct linux_binprm *bprm = task->signal->exec_bprm;
>> +				const struct cred __rcu *old_cred = task->real_cred;
>> +				struct mm_struct *old_mm = task->mm;
>> +				rcu_assign_pointer(task->real_cred, bprm->cred);
>> +				task->mm = bprm->mm;
>> +				retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
>> +				rcu_assign_pointer(task->real_cred, old_cred);
>> +				task->mm = old_mm;
>> +			}
>> +
>> +			up_write(&task->signal->exec_update_lock);
>> +			if (retval)
>> +				return retval;
>> +		}
>> +
>>  		scoped_guard (write_lock_irq, &tasklist_lock) {
>>  			if (unlikely(task->exit_state))
>>  				return -EPERM;
>> @@ -488,6 +510,14 @@ static int ptrace_traceme(void)
>>  {
>>  	int ret = -EPERM;
>>  
>> +	if (mutex_lock_interruptible(&current->signal->cred_guard_mutex))
>> +		return -ERESTARTNOINTR;
>> +
>> +	if (unlikely(current->signal->exec_bprm)) {
>> +		mutex_unlock(&current->signal->cred_guard_mutex);
>> +		return -ERESTARTNOINTR;
>> +	}
> 
> I mention this hunk below...
> 
>> +
>>  	write_lock_irq(&tasklist_lock);
>>  	/* Are we already being traced? */
>>  	if (!current->ptrace) {
>> @@ -503,6 +533,7 @@ static int ptrace_traceme(void)
>>  		}
>>  	}
>>  	write_unlock_irq(&tasklist_lock);
>> +	mutex_unlock(&current->signal->cred_guard_mutex);
>>  
>>  	return ret;
>>  }
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index 41aa761c7738..d61fc275235a 100644
>> --- a/kernel/seccomp.c
>> +++ b/kernel/seccomp.c
>> @@ -1994,9 +1994,15 @@ static long seccomp_set_mode_filter(unsigned int flags,
>>  	 * Make sure we cannot change seccomp or nnp state via TSYNC
>>  	 * while another thread is in the middle of calling exec.
>>  	 */
>> -	if (flags & SECCOMP_FILTER_FLAG_TSYNC &&
>> -	    mutex_lock_killable(&current->signal->cred_guard_mutex))
>> -		goto out_put_fd;
>> +	if (flags & SECCOMP_FILTER_FLAG_TSYNC) {
>> +		if (mutex_lock_killable(&current->signal->cred_guard_mutex))
>> +			goto out_put_fd;
>> +
>> +		if (unlikely(current->signal->exec_bprm)) {
>> +			mutex_unlock(&current->signal->cred_guard_mutex);
>> +			goto out_put_fd;
>> +		}
> 
> This updated test and the hunk noted above are _almost_ identical
> (interruptible vs killable). Could a helper with a descriptive name be
> used here instead? (And does the former hunk need interruptible, or
> could it use killable?) I'd just like to avoid having repeated dependent
> logic created ("we have to get the lock AND check for exec_bprm") when
> something better named than "lock_if_not_racing_exec(...)" could be
> used.
> 

My problem here is that we have a pre-exisiting code using
mutex_lock_killable(&current->signal->cred_guard_mutex))
and other pre-existiong code using mutex_lock_interruptible I would not want
to make any changes here sine there are probably good reasons why one is
ignoring interrupts while the others do not ignore interrupts.

So currently I would not think that a helper function for the two interruptible
mutex locking instances would really make the code more easy to understand...


>> +	}
>>  
>>  	spin_lock_irq(&current->sighand->siglock);
>>  
>> diff --git a/tools/testing/selftests/ptrace/vmaccess.c b/tools/testing/selftests/ptrace/vmaccess.c
>> index 4db327b44586..5d4a65eb5a8d 100644
>> --- a/tools/testing/selftests/ptrace/vmaccess.c
>> +++ b/tools/testing/selftests/ptrace/vmaccess.c
>> @@ -14,6 +14,7 @@
>>  #include <signal.h>
>>  #include <unistd.h>
>>  #include <sys/ptrace.h>
>> +#include <sys/syscall.h>
>>  
>>  static void *thread(void *arg)
>>  {
>> @@ -23,7 +24,7 @@ static void *thread(void *arg)
>>  
>>  TEST(vmaccess)
>>  {
>> -	int f, pid = fork();
>> +	int s, f, pid = fork();
>>  	char mm[64];
>>  
>>  	if (!pid) {
>> @@ -31,19 +32,42 @@ TEST(vmaccess)
>>  
>>  		pthread_create(&pt, NULL, thread, NULL);
>>  		pthread_join(pt, NULL);
>> -		execlp("true", "true", NULL);
>> +		execlp("false", "false", NULL);
>> +		return;
>>  	}
>>  
>>  	sleep(1);
>>  	sprintf(mm, "/proc/%d/mem", pid);
>> +	/* deadlock did happen here */
>>  	f = open(mm, O_RDONLY);
>>  	ASSERT_GE(f, 0);
>>  	close(f);
>> -	f = kill(pid, SIGCONT);
>> -	ASSERT_EQ(f, 0);
>> +	f = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_NE(f, -1);
>> +	ASSERT_NE(f, 0);
>> +	ASSERT_NE(f, pid);
>> +	ASSERT_EQ(WIFEXITED(s), 1);
>> +	ASSERT_EQ(WEXITSTATUS(s), 0);
>> +	f = waitpid(-1, &s, 0);
>> +	ASSERT_EQ(f, pid);
>> +	ASSERT_EQ(WIFEXITED(s), 1);
>> +	ASSERT_EQ(WEXITSTATUS(s), 1);
>> +	f = waitpid(-1, NULL, 0);
>> +	ASSERT_EQ(f, -1);
>> +	ASSERT_EQ(errno, ECHILD);
>>  }
>>  
>> -TEST(attach)
>> +/*
>> + * Same test as previous, except that
>> + * we try to ptrace the group leader,
>> + * which is about to call execve,
>> + * when the other thread is already ptraced.
>> + * This exercises the code in de_thread
>> + * where it is waiting inside the
>> + * while (sig->notify_count) {
>> + * loop.
>> + */
>> +TEST(attach1)
>>  {
>>  	int s, k, pid = fork();
>>  
>> @@ -52,19 +76,76 @@ TEST(attach)
>>  
>>  		pthread_create(&pt, NULL, thread, NULL);
>>  		pthread_join(pt, NULL);
>> -		execlp("sleep", "sleep", "2", NULL);
>> +		execlp("false", "false", NULL);
>> +		return;
>>  	}
>>  
>>  	sleep(1);
>> +	/* deadlock may happen here */
>>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
>> -	ASSERT_EQ(errno, EAGAIN);
>> -	ASSERT_EQ(k, -1);
>> +	ASSERT_EQ(k, 0);
>>  	k = waitpid(-1, &s, WNOHANG);
>>  	ASSERT_NE(k, -1);
>>  	ASSERT_NE(k, 0);
>>  	ASSERT_NE(k, pid);
>>  	ASSERT_EQ(WIFEXITED(s), 1);
>>  	ASSERT_EQ(WEXITSTATUS(s), 0);
>> +	k = waitpid(-1, &s, 0);
>> +	ASSERT_EQ(k, pid);
>> +	ASSERT_EQ(WIFSTOPPED(s), 1);
>> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
>> +	k = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_EQ(k, 0);
>> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>> +	ASSERT_EQ(k, 0);
>> +	k = waitpid(-1, &s, 0);
>> +	ASSERT_EQ(k, pid);
>> +	ASSERT_EQ(WIFSTOPPED(s), 1);
>> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
>> +	k = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_EQ(k, 0);
>> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>> +	ASSERT_EQ(k, 0);
>> +	k = waitpid(-1, &s, 0);
>> +	ASSERT_EQ(k, pid);
>> +	ASSERT_EQ(WIFEXITED(s), 1);
>> +	ASSERT_EQ(WEXITSTATUS(s), 1);
>> +	k = waitpid(-1, NULL, 0);
>> +	ASSERT_EQ(k, -1);
>> +	ASSERT_EQ(errno, ECHILD);
>> +}
>> +
>> +/*
>> + * Same test as previous, except that
>> + * the group leader is ptraced first,
>> + * but this time with PTRACE_O_TRACEEXIT,
>> + * and the thread that does execve is
>> + * not yet ptraced.  This exercises the
>> + * code block in de_thread where the
>> + * if (!thread_group_leader(tsk)) {
>> + * is executed and enters a wait state.
>> + */
>> +static long thread2_tid;
>> +static void *thread2(void *arg)
>> +{
>> +	thread2_tid = syscall(__NR_gettid);
>> +	sleep(2);
>> +	execlp("false", "false", NULL);
>> +	return NULL;
>> +}
>> +
>> +TEST(attach2)
>> +{
>> +	int s, k, pid = fork();
>> +
>> +	if (!pid) {
>> +		pthread_t pt;
>> +
>> +		pthread_create(&pt, NULL, thread2, NULL);
>> +		pthread_join(pt, NULL);
>> +		return;
>> +	}
>> +
>>  	sleep(1);
>>  	k = ptrace(PTRACE_ATTACH, pid, 0L, 0L);
>>  	ASSERT_EQ(k, 0);
>> @@ -72,12 +153,46 @@ TEST(attach)
>>  	ASSERT_EQ(k, pid);
>>  	ASSERT_EQ(WIFSTOPPED(s), 1);
>>  	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
>> -	k = ptrace(PTRACE_DETACH, pid, 0L, 0L);
>> +	k = ptrace(PTRACE_SETOPTIONS, pid, 0L, PTRACE_O_TRACEEXIT);
>> +	ASSERT_EQ(k, 0);
>> +	thread2_tid = ptrace(PTRACE_PEEKDATA, pid, &thread2_tid, 0L);
>> +	ASSERT_NE(thread2_tid, -1);
>> +	ASSERT_NE(thread2_tid, 0);
>> +	ASSERT_NE(thread2_tid, pid);
>> +	k = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_EQ(k, 0);
>> +	sleep(2);
>> +	/* deadlock may happen here */
>> +	k = ptrace(PTRACE_ATTACH, thread2_tid, 0L, 0L);
>> +	ASSERT_EQ(k, 0);
>> +	k = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_EQ(k, pid);
>> +	ASSERT_EQ(WIFSTOPPED(s), 1);
>> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
>> +	k = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_EQ(k, 0);
>> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>> +	ASSERT_EQ(k, 0);
>> +	k = waitpid(-1, &s, 0);
>> +	ASSERT_EQ(k, pid);
>> +	ASSERT_EQ(WIFSTOPPED(s), 1);
>> +	ASSERT_EQ(WSTOPSIG(s), SIGTRAP);
>> +	k = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_EQ(k, 0);
>> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>> +	ASSERT_EQ(k, 0);
>> +	k = waitpid(-1, &s, 0);
>> +	ASSERT_EQ(k, pid);
>> +	ASSERT_EQ(WIFSTOPPED(s), 1);
>> +	ASSERT_EQ(WSTOPSIG(s), SIGSTOP);
>> +	k = waitpid(-1, &s, WNOHANG);
>> +	ASSERT_EQ(k, 0);
>> +	k = ptrace(PTRACE_CONT, pid, 0L, 0L);
>>  	ASSERT_EQ(k, 0);
>>  	k = waitpid(-1, &s, 0);
>>  	ASSERT_EQ(k, pid);
>>  	ASSERT_EQ(WIFEXITED(s), 1);
>> -	ASSERT_EQ(WEXITSTATUS(s), 0);
>> +	ASSERT_EQ(WEXITSTATUS(s), 1);
>>  	k = waitpid(-1, NULL, 0);
>>  	ASSERT_EQ(k, -1);
>>  	ASSERT_EQ(errno, ECHILD);
> 
> Thank you for adding tests! This will be a nice deadlock to get fixed.
> 
> -Kees
> 

Thank you for your review, if you would like me to add some more commments and
maybe have any suggestions what to write and where, then I would be happy to add that
in the next patch version.


Thanks
Bernd.



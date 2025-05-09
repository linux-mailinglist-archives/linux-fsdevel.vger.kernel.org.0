Return-Path: <linux-fsdevel+bounces-48526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2DAB0816
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 04:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639004C8908
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 02:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31626230BD5;
	Fri,  9 May 2025 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebwlsbln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436722FDFF
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759167; cv=fail; b=rhnrJcuIb7S75lOl6rmZqbuZMSgdqWlAoXk87CDm1Tsg34Qfa4NYy03SuwMR//vqkGxTNi54VhdZ+2bTBvj6KNQPhkHZJ8U4KmCiPvjYfFTF8tfWTXVPqO7Pwj66UjydwQh7PxzKZ3D4LJyp8ugZZPXoPasnrf44EFDSG8TnW/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759167; c=relaxed/simple;
	bh=UJJGG1Y/ztaTSD89fCwweIFpKjWcrNcdWYuh+/Ht1RE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgCtwaYbHGeiYCOsGFkik/RdH3a9GQQnIi/oXvahdE+Vhg2B7yvQuoWisvHgZdcoAPRRsyigFEaWTAwpgBIgYmEVCix/C4vakvwSOUrms5NWGf6MkFMhUnPrGy/Wbixep7YvumROfLfkVl9h9/VSjXRXAJuCKDeJNuLucMmrAtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebwlsbln; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVKB3Q81sXvm01bbOS1Un0Zsz/3dwIdC5q/u/1edS54hjL/YefpS44nY6oPi7xiLcg0VGzx5+Xj9zVhbjSr+8STnTIBb4B5TzxbcXakioiQLOvIb0mM4xXeYVb7kcxT3HiFVQxY6Ub31hjZYYqRVAOZHvVvi7PeAwjd0D49dtATDI/QOe63QINgB+3KrzHyq47dQswk90TUrOkAaihdrq2650m+knbjSq9d6dhw5pwDnxuV0g1ZT1Qlql1EfBQfxTrJC+e9ZY03csKANkTW4DMm24rumjJYa1kOMKrGvhe0QYn0RrqYCOu4cSRdzsDwvk/fFgpk/Iob6etp4uFDtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3znBk58VYfJp0FJ7S/MaR0s/X07PIao9nEI9YCu2Xc=;
 b=hvnOgb+bHMILFHDH07hazZQbGxlvNdEvzDIIXjizwQ5s/WBzK6WaPNlPmrp4IlHHtNeRJD1SwNAa7mN13TU076Qmm+OGMqa1zx/3DslruTr56tqk/bt5iKhGRV3kP5QO/RmF9rIvBkUj5/26UjOeg0NnchnLgig7HumXu8sXaToYTIstzqGSg560v8bEqQ/Nf0Bcfkkg+Y+3ukdBZJGudZKVB69KTNC3rWXGWofAzNoA2nyDE4cuVp6s52aWD/fG+JfZuWl4vWZvyYFfqpUgLos8Hbbab06BKuUsTyy0BtHatHrpArWTqWa561p2+R3k3wMBpE5JdwzYANu6UWenGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3znBk58VYfJp0FJ7S/MaR0s/X07PIao9nEI9YCu2Xc=;
 b=ebwlsblnYyQRd8y2CN6ImU+WwMKlivlODrFcY2dTEZZA+lHKKq2NcHODTxoRhc6miE6Ktl3Xzc+qT3tB/YXQw2Qit4pwT44vEJ4aUBaZPDwsEDvWwnXVbCY4AEVpIZZZAlaqZzyAcCcig8Rrs/D/lvW5q0HIsJgPEAPeTJ9+bL9AoAfuTD+lPIUFJeMUOPIFze071j6puNHV4a+1N6VZ9o2i557XgUuec3ZriSr5YJSwID2DDu9y3aB/YDfLHEp62ULhlYSxMjrLbQ2AQyscwkdhmTqVAUXoLDCiiuZ+F0IpmRAaqATjwe/yim4NOyXFnTbpDdkytIPgmcWlPORBRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 02:52:38 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 02:52:38 +0000
Message-ID: <44fad486-d376-4a01-adf5-e7f29facdcea@nvidia.com>
Date: Thu, 8 May 2025 19:52:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] selftests/filesystems: create get_unique_mnt_id()
 helper
From: John Hubbard <jhubbard@nvidia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-5-amir73il@gmail.com>
 <3d19e405-314d-4a8f-9e89-e62b071c3778@nvidia.com>
 <CAOQ4uxidUg+C=+_zTx+E58V4KH9-sDchsWKrMJn-g2WeoXV0wg@mail.gmail.com>
 <a5f97646-379c-4146-9dd3-93dab9f6ba91@nvidia.com>
Content-Language: en-US
In-Reply-To: <a5f97646-379c-4146-9dd3-93dab9f6ba91@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d9816-326d-457e-61bb-08dd8ea48ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUhoMEo5dWpmNDJWZXBzSzNDNlNNNnlHNHQ0ZkVZMjdicEcyc05OVmxiWFF1?=
 =?utf-8?B?SUVSQVExS1haMDNsakZPZzd0aUJIWGRDQ05zME1EcVZndW5oQ0U5dlY3L3Ar?=
 =?utf-8?B?L011V3JBdUU1eFB5Y1FqN0pQZlp5K013SHo2VER5TWcrVlBiem45NklJV2lk?=
 =?utf-8?B?U0ZGQnpPUStUa1BmNzd6MWFyTWRpRGd1V3VuOWYrRWE0YTNCZXBPK1VncTBQ?=
 =?utf-8?B?b0VQKzc0Mk8vZ0pmaUF4T05xTGgwckwvS2ZWMWZqcDhLTU45Tk5hQUhNTUZk?=
 =?utf-8?B?REZ4UGhub0VpTHd2MnUvVmVRVjlsQm5lUjJVNm5kWTFkK1IyQzdyNXdDNXFP?=
 =?utf-8?B?MHNtbTVqb3VzSk1NZDNIWGt4b1UwU3NEcHZqVHIra3g3UlBGSDAyRW1SeFV0?=
 =?utf-8?B?bXNhekQvNU8vdEkyejhpWVhYWTljVytwV09CN1BjMitXL2x0amppV2pmeE5Y?=
 =?utf-8?B?aDNjUkZrTnRkWjcyV0hGQ1V6dlVmeFl6ai8wRjdJV1gxQjhuY2ZQYlNVaGpH?=
 =?utf-8?B?aFNCT3phTVlxaHR5WDdLMTNjSEJXQUhtVWtJanFESXp1N2VvWUM2b0R1MVNW?=
 =?utf-8?B?Vmt0TUxtOEZmWlpXcStHc1g0anIrenRnTmZydk4wNUJ6TkpPUlNSR1BlR0pT?=
 =?utf-8?B?SEhQRHZVVFJhM3hYQ21WUGV5ZitjNUJuTHg1WTBpZUMwVUhUc0hSTEEzN3Zh?=
 =?utf-8?B?cjFlcy9pbUU5a3BpZHJsSWk3aVNlNEpzSGpzM0UvWS95aWlyR01WbzJoOEc1?=
 =?utf-8?B?MGNHQ0xkVFlqallWNXhMeCtZcndydFF1cEZoTkNkb01iWUFCYUk4M1RIZzFT?=
 =?utf-8?B?TjZZbklYc1NZMys2K1lNeE1za0tGbzZOQ3VYYzZoZ1B2VjdsRWw1UW9sUTZR?=
 =?utf-8?B?OWNjNzF4cTFHU1UrYWgzZENaay9oR29Za3VFamwwQ2hCM3NFcHpYZldpUEM0?=
 =?utf-8?B?RHd0Y0FCOGgrd3ByUm1vQ3BpVzZlU1NWaUVUMlhoQTNDVyt0SHcyejQxL3JD?=
 =?utf-8?B?VWt5NUY3YUR0bEtyZm11bHR6eGpGQjQ3akpHWHBudnk1TjZvZ3pRdkFCMjhn?=
 =?utf-8?B?dnNVLzhYRkJ5UE0zQTh1bVFubGhHTXpUUWs3UHlseDlDVWpUcGtzMURHbUxT?=
 =?utf-8?B?S05kbFNIR3dXcWl5M2FkMDBla1VtTWpjZ0pudkwxTzRBL0c3TnJVWFBiNW54?=
 =?utf-8?B?MlRyZ1IwU1NyR0c5YXF6Y3dHTzk5aHM3eE1LQUxSOGdmUzBqUlgwWG5Zbmti?=
 =?utf-8?B?a0FRaVRna1FDYTFwaHVrSEZjanU0U2t2THZ2TG84WmovUFdrdDI3YW1vUk1K?=
 =?utf-8?B?SEx6UHNVMW5QRis2aXlmWFFYNjJsTWRpVFpaam9DdTVoQ3VFSURndVhSMkJz?=
 =?utf-8?B?QVpnMTRvS1k2aXZkclp1dmMvSzg2bEJjMjFYWFJkK0FOQzZTS20yeHQrSzNU?=
 =?utf-8?B?NEx3V2hJYWRPcUUyMHI3dTdvUGt1MEQ4anFSbzlSNGZkUi93QVFPaFJ0RnJB?=
 =?utf-8?B?bGg2dGV3WktLbjBsS0YzUFZrNmZPVzBkSDlGRE5KNUV0RU1ObWRkQ0k5Zzc2?=
 =?utf-8?B?VnRvVnFVTVhsWG12YzVzbGh2dEliSWtGM0wyQTdJQUVwSjBNaDNqUmNQNjNq?=
 =?utf-8?B?MmcyVDlFK2lwbW12Vm1BUVcvUHp6dE94U1hoRkFodllCT2s3TVdZaXJxWmZM?=
 =?utf-8?B?Qy9FOUJUbS9KSVFKcUUxdWN0dTBlUXVoZENSS1lkWjhITTBnV29yVlUvaTUx?=
 =?utf-8?B?M25uS0wvODhRTUM5aFNEWVdxYjV0dmx6OUg5UVAwUjMzWjJoMGRmS1p0bmZ3?=
 =?utf-8?B?RjN4V084S0lVd3VnY0IzajdMWFRySVJrdVhDMEdOckIwYWxmVjJJbTU2WGZE?=
 =?utf-8?B?OFp0bVpxZVpuK1N1RXZVVjRQcGN6SUwzWC9vME9IY1hlaFZiZS9BSGJLd2M1?=
 =?utf-8?Q?izof8yY/krw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2FXMTlyOHl3NTZKMjc5eHZiYnBDbFNSTXRXU3YzbEt4TTlmeHpjYXNRK3ZJ?=
 =?utf-8?B?QWtpckNUenVyaVhGSGZCWGZ6Znd5cmhvQzhZbDdJM1hIWjRyQ1QrSHE0RHFu?=
 =?utf-8?B?dGZ3ZThhcWp6V2NTTEloT3NjT2ZDTllKMDJZME94Uk5XMlBOajFuOEUxZDQ0?=
 =?utf-8?B?MUVoRi9EY3V4Rk56VEZOUW14bDdKMEUxdHVlREVxSmEvSzFHaWE1bWNjYlNk?=
 =?utf-8?B?NVNYcnBGb2JmYVFKY1d0SlJPQTkvZ1B5ZVZvUWhLUEJFRkVEVUpWMUNNeHVl?=
 =?utf-8?B?SE44MlN1M3VRSjhyK0NxQ1kxeVErRnNkMXRzNERIUHZNNkdxT2EvWmhIRGpW?=
 =?utf-8?B?OU5UckVzS1Nmb0x4dHZ5UlFNZzY1S096akVZSkg1S090aHBKaVc5YVJBMWVX?=
 =?utf-8?B?MzZxT2hTV25BdDlucFE4QW9IeXVsd1VqanhVTDVXcUZaMXd6M250dE1haWNQ?=
 =?utf-8?B?QjlDVG5uVHpJTXNGSitHZktFY3NWYlBaZlRJaU44RjBpd1g3bSt1aTFDQzkr?=
 =?utf-8?B?cHhBUlRxMGE5WXgyR1JRRTkvZWF6VnZkTEJ3VGxFZzBONXNWWXFEQ0xzdUFx?=
 =?utf-8?B?RkNoOTd5dkFCN2tKekdMYmo1UVgvMEcrdis2Zk01M2RKSjF0SFozSERvM29X?=
 =?utf-8?B?QjRKQWN0azZHWDcyUE1RcjBFN2FwVWwwK0lnMlZoOTQzUWwvOThqYXlLTHg0?=
 =?utf-8?B?cmxrd1FBRWxWdG5YSEZCR2xSUWhaTnBaK1RORURXYzYxbXUzcGM1L2k1dWtC?=
 =?utf-8?B?a2ZQSERNbjdkdHViRFdPODRGZDVhdjdFUWljdGdvNTQrWmFJYUdRQlRWa2RE?=
 =?utf-8?B?VXhCd2MwaHRmK0VOVUQ5bkJBcXJac0xCK2svZ3hhQnlMUkMyNllwMi9BQ3lB?=
 =?utf-8?B?ZXRhWVhmUzl4QWdKdllIZGcrUUZlVDhvVTJPZ01OYmViL2g3MVR0am9ZZVha?=
 =?utf-8?B?NDRXVlRRUVgzQ3FHSElmYWY3VzI4aHpxTU8xeWgxWktqS2xNUGhjZ2tYeFlr?=
 =?utf-8?B?Q29aNi9TUEp3K2lZOUVVTDJnck1hZXhvRklJMkFmRm5MMlhKUFllVzdJdkYy?=
 =?utf-8?B?SkFoSFVHcU5NU0NScHNwNkhraEN0N2o5RW00dC9LM1dWY2psbk1SQ0RlWkdC?=
 =?utf-8?B?Q3lPNjhqQlNxQ2dNZzgxYU50elRxK2JwYUQ1UDNPQjI4OVFLWDR6elZqRFVx?=
 =?utf-8?B?OS92NVFCVTMxUXhPQ2dmYk1pR3k5OFRDTm1KbmpNeWZDQjNabkVldyt5UHd2?=
 =?utf-8?B?WlhKeUFsWlhFbUVZVnEyeC80aDNVZGhOdEo3RGw2Yy9WU1VjZDZPSnpsbmNB?=
 =?utf-8?B?cVpiaERSM0dnZEJSTTUxa2hKNnhhM1ozc2Y3Rmw5cU5Cd0E5MlY1M05jOExS?=
 =?utf-8?B?Rm1HYTc1QmhGSmhOeVRYeW5wdVVwZHFzSEg4cFhQS25TUmdYbExyRnhxZVRu?=
 =?utf-8?B?U0h6bkxjTWpjVzZvY1ZNdDJUOEZjUm5ES1NSQW4yYWZxSWd4K2NONXZlWGhk?=
 =?utf-8?B?NzZUWDEzNDN5UTNPcEx5NUFIWFBKTDdXQXc5TEpuOE1hbVAwWVF2N1NtNktm?=
 =?utf-8?B?dDRPR3IrVVhyaDFsTktNSTRuNHJGcWJFNGQ5WndlbFhKQitOUnRjUWhXWlZ4?=
 =?utf-8?B?UjM0Wk9za2UrUUU2TEpzbmJYR2N1NHQrbzU5dHRSNytEVERoMStEYjJUTFpD?=
 =?utf-8?B?OXUyYnJFNWREYXEzd0JUeUUxbm5WbWR5UkZWTnJ1US92YjdMSDRnUnE2c085?=
 =?utf-8?B?d2VxcVcveGU0V1M5NERBL0pGYW5Mekl5M3lqK0wwSXoyWHkrS1YySjdVL28x?=
 =?utf-8?B?NU5aSVdDenB6SkQyZlVURnQ3NFNDNW1rUzZoSkxldFRzVUQrbFdsR1hPcVRW?=
 =?utf-8?B?Y0p3eVpDUEVPRStPTURkQURVb0p0UFpWdGJKUnVSMmxyNmhwV2dLQTRRVXRK?=
 =?utf-8?B?YkF6V083RUFlV1NwQUJZL3dibXh1M3FxVjFtQXF4eGpqZmQvTGgvcmgyTHFJ?=
 =?utf-8?B?MkIrSXo4U0hNWEE1azVVOXJDMlBzRThldVhUVEhBTVluS2JZVm5LRStlOEhw?=
 =?utf-8?B?OXJFZXA2c3g5b0RSN1VsSG90ejNSL3B5ZWd2cTg3aC9YZmxaWnlwRFM0dHZv?=
 =?utf-8?Q?NJav9XXYdgKYfp74Nyo3pOeEo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d9816-326d-457e-61bb-08dd8ea48ed2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 02:52:38.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVWJWBDjieOGd3uGZ1rcZHlfCUc2EFLBLB6fZwk5wib6i9F2NbguUSKFP7N3ZQm2iYoWNQye+avJZWwsjA9yZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806

On 5/8/25 12:35 PM, John Hubbard wrote:
> On 5/8/25 4:44 AM, Amir Goldstein wrote:
>> On Thu, May 8, 2025 at 9:43 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>> On 5/7/25 1:43 PM, Amir Goldstein wrote:
> ...
>> Is there a different way to express this build dependency?
> 
> Yes, but first I need to reload the kselftest build story back into
> my head. I *almost* remember the answer offhand, but not quite! I'll
> pull down your branch, just a sec.
> 

OK, I finally got a moment to remember this, and your approach is
exactly correct after all! So please feel free to add:


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard



Return-Path: <linux-fsdevel+bounces-36760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA879E90C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AEE1644B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 10:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8219821765E;
	Mon,  9 Dec 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pgTi4D4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D881DA23;
	Mon,  9 Dec 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741146; cv=fail; b=UsTrLVmufKX0g99FYEpK4dBh0uS6MrYXKDhbvrjd18PZS7ylG+VnkAq16XNwQzzzVvg/B/9wSyXookyzDIp3I7N621Dl0NS4breAgNEuWrX7PSZ/PE8Tmt2+h5XjV8wcafWWus6ZFVX227SGvOJ1+dv6ulUPzGd8W/3ScMaei8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741146; c=relaxed/simple;
	bh=oNhucx2A87Pi/GC8FWpSEtw9T4VXBfrK24r38I1cK18=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QAStBHWKuyk1HIx7+orKErhpmbHX0l1mt+boir6pn+/tr3td/eFshLzBpPPfeB3Hr8eZSXweSnjQEYpZOgg+ax6y9ilKCGG0IhvR9wf3JPjneI5D+4+zVk4vspP6u6F1WIPKOog/NjiifJ3sEpVOcnTUu+GH5/vRnZ8tivtRlic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pgTi4D4m; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5aMsVBz+ny84/yqlwdzOLo4ksOP82cJt1KTFMNhAlkeh/WkGuJJjL2bAtCsrtNrgQmkcVQVjlS97UeBPehzRFTAKLWi2NM54j89OMnegjijVKgKLoL2gEKLh6iz9s54fQpGA7VEmRT6zdXsIxRSh8IsM9atDLQcSLkOxfN4CF4UqVaDmw6Mbjao+MrzVbb+s6Em+gKDhXbgvppzgwihO2R774VYOAa8OGSseMWHqHW0JNMW7pBccs0o37Olog//QAQTLD0HVulUfGUrPckpbsD9CBFH9dxFSmHDvXsG3elebz7qE6qDFGzj7+z43VINpJDoPia4SHc0BUOIuBYMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YUO+VAK1Uh3niZMaADrsZNOPDOJkUA176z4pu6miXs=;
 b=JmFdZlY4bu0TVQI6UweuBlahJTEivYNpEBkeho0dxzsRWSdGKy4ELuy9EEjagoBHHmR/rBUlEB4f9QY00fGCd71MIAJRuW4Qudky9TTzOKaeJ+AHBtC53ZbDl8iiG9aYUftpMSJGn0AqN7itJNqYCm9Bgrw26ThH8BtwdPTAbbERBNyyCSRLYkvsPDgLGqP9T9kHiE03B9DtHYmTljpG2P7J4+IhDjIInB0gk6YFFB3CFVmHCiE0ZLr1jkxZgPNfv4Ep2VMXOshXR55BYe7p4+8ZQTbseO491UO4g1iVK3hZi8oC6SWCDpHLnVDnMBUY0l8rrlxRUkjGpsvIWY++qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YUO+VAK1Uh3niZMaADrsZNOPDOJkUA176z4pu6miXs=;
 b=pgTi4D4mfHGVIDF2V3MTmjG2vGcalJ0Rz7ULHqKnArpFJs8Od2t4V8bslki5Mcp4d2JGBgI/CDl3L93IuXzn/+vcignVShZ/BGXd/yFXT3tdnwZS8F+Mb8G0ofKLAiuw3hhL2R60v84NJnsOSHwOPU2HPRyEb5l+2tKoXIK6qRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 9 Dec
 2024 10:45:42 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 10:45:42 +0000
Message-ID: <e9f65f75-7f0c-423f-9fd4-b29dd006852b@amd.com>
Date: Mon, 9 Dec 2024 16:15:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/19] fsnotify: generate pre-content permission event
 on page fault
To: Klara Modin <klarasmodin@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 amir73il@gmail.com, brauner@kernel.org, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 Linux-Next Mailing List <linux-next@vger.kernel.org>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
 <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <5d0cd660-251c-423a-8828-5b836a5130f9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ee9b1d-2f2e-4414-0b83-08dd183ea070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2lMSmFLS2ZrUkRMY2lxOFFldTFiM2lwWkxieHV0R0I4ZzBZTzlCNitPTWlk?=
 =?utf-8?B?T3BXNTdETkFkb0h6YU9zOHlLZWhKMVBRMFpDdkcyaGgzZXZUcDNHVGV1UmlR?=
 =?utf-8?B?dkppcGlFdlhRUWw5ZUxQdlY3NlB1SmxrSXgwTU5aVlYvclQ5UStiUDc2dDBi?=
 =?utf-8?B?bzhvY01tZnQ4ZE1Kbkhid25sL09IU1pSVEdGNENySVRaL2srRHF1RDF0QzNT?=
 =?utf-8?B?STRxMzFIOW05Y3kzWGIzeXNRbTRkRjg0am84MnRPS2ZYVk12dmhNWDFQRDRF?=
 =?utf-8?B?MlpqQk5KcDYybXlsU0I3MjZPZzlzc0ZZbzIxWlJRWVNydnZDTmMvU0FaM0tP?=
 =?utf-8?B?TmtnM0VPRUd2bTcvMFl0b0drV3hQY2h2RVVPUm1nNWpmVW5vd1IybXVXaWFo?=
 =?utf-8?B?RHZ5QTJkNzZlR1RPazlNUmNjdjJWUU1YbjJNL293c2pZZEIzeE1aZlUzMTNV?=
 =?utf-8?B?blJYSlptR2Q3TkF6TVd3cDlZYUEweUcrTHM1bEJkdEdxUW9iSVF4YndvQmdo?=
 =?utf-8?B?SXFMOGplUTdDaUJBVzNQa2lKd2JEbitWL1Fad1B0K2lYais2M1BXd2NSbmlu?=
 =?utf-8?B?Q25VbS81aDVQejRBOVE0TWdjOFdzd1V1aEd0WkQvcmF4Q21kbnN3QTNpM3lL?=
 =?utf-8?B?eVpDWGN1SmZOTGpyQjYzY0ZhTGg2NWkxUGlnblpFZFNzVk5IZFAwS0xPSWMv?=
 =?utf-8?B?VDRJbFJGMm9mYTd1eTBHZlppYkNXWEdpS1N3ZTJGUHJ3dHhGMkk1U0RISnUy?=
 =?utf-8?B?WGgxMmRMTXZaN0ljSEg1WENQY0ZrR3d6M2d6VW1EU0YvQUdCbEJVVm5BTGh3?=
 =?utf-8?B?dEx3bFNJa1h5aWczY25YZGs4RG5zVXBFODJISlhjRXhJQjJJUkxGbVZBNzBz?=
 =?utf-8?B?R3BxRjBnYndQZ3ROVE5aMFFiVzNDRUh5WjFZcG0vZ1N3OGROZ0lnWC9EVm5X?=
 =?utf-8?B?bmFEYXFndHhvVXU3NlJPYjdMTFA4TlJibFlIVUF1MVU0S2s4c1N3bDFQODNL?=
 =?utf-8?B?SGFmNjhSV2F1dXk4L1hyT2l2NlZBbW9NQm1POFFYd3h6b2lrVGduQTdmVVRl?=
 =?utf-8?B?cEpycWxRSGNZaG1TZkN3TWdMYWxzUVljK3g0QXZEN2pXTk56WENEREdLajJz?=
 =?utf-8?B?QUY3cVIyUWFZUzhkZmpoZ3E4QkorWC9kNVRVM1E2NCt4UFdnZVdMNG5ST0tY?=
 =?utf-8?B?emNSUVNZUUxXaTRoMFhmMXRRcm1ncFRVSi9QNnpNNUx6OFQ4WkhzRlh5R05o?=
 =?utf-8?B?ekhXRHl5R2Y4Q29NQ29WNk9tTGRzR3ZtMENlS1VLY1pOaG5lcWdMbGRvTE5y?=
 =?utf-8?B?eFhaR01aNXdlNFFjTGN4RFVTcVdYL2hzanpWMFlMelcwdGM5T1NBQUxWZTNu?=
 =?utf-8?B?aUhXdzhCeFZzNHYvcGt1dWxjTDBsaTRrd2RGRUhhUnNDVnpXSHQxclllcUh2?=
 =?utf-8?B?OElJR1hMb25yV0tJY2IxZmdrMXUySGhEMmNKYWNObU9yV0JFNGw4SkZZNXFP?=
 =?utf-8?B?bWE2N0JvL3pnZ0JBMWpGS0YvRGVtQ1p5TXQrSXZvQTFNcEQ4ZnhnT0xqK05Y?=
 =?utf-8?B?bjgxN3A0Y0JEK3dqNERoYlZ4b2Y2c0UxZUxjbGdDWlZDTThXTWpXbEdIZVU2?=
 =?utf-8?B?SEJsUHcxcGlVVVl6ZVFFN09CYTk0dGt6bHhVYk5RbXBNNmk5T3NwRmwzc0dV?=
 =?utf-8?B?YzFwZENBcmRjallqSk5jZFdYNkpDelE1SEdsdWdvVnhhbVBEOXpYWXFLUGhp?=
 =?utf-8?B?Zm9PWlBYbWxWckw1WFgzZGZnRmNhbHQzZnppekNHQ2JKdVZEbXNOQ2JLZk9D?=
 =?utf-8?B?NWltcjFkWW1YYSt1UWRWalR6SGFRSjBwbXN0VDROQWF0SXNZdnJHVGxBWmE0?=
 =?utf-8?B?Qk5zTjJrWTZObXlsaVlRSDdHNjB1UGFwRHZWTG1SOFk0bHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHd2Yml6YlQ1N2YydEdUZ2QwQmlTL2ZZcXRrbHlDejVRRmt0OXNXRWkyMzVZ?=
 =?utf-8?B?bFQrM2lvR2ZRQ2tyaVV5amROWmx3V3lleW0yMEo4MHpucmNTZk5iWmNDMkp5?=
 =?utf-8?B?NGpGQWJOYml1U0kyMzAvVVNhaWZ2RVpqREo5QU4zWVFJRStYZHVaL0liZmNa?=
 =?utf-8?B?d3ljRmo1QmhTdmVhNVVsOS9GTlp5N09rN3o2eXRTQndvRDduc1lINlZkVWdO?=
 =?utf-8?B?cHBsMU05d0M1UHlqLzNTcVJKczNCcjcwZm80dTc5a3F0eGE0dE1iWmxKV3Fp?=
 =?utf-8?B?eG1rQ2FIYTJKWmdNSHp4T2JVSWRLSHY2Z0ZWMVRWU29NeFRSaVpWYXNySGsy?=
 =?utf-8?B?YjJ4UzBMQzA5VWlPQ09Jb1dydEMrRFJSRFcvSEhXTzFING1uaWVmRzhpM1dL?=
 =?utf-8?B?NVlSOXZ3VG9CVUpOSThidXdnTUUwRWJKOUwzdnBRWHU2UGNwOXZVS0MrZjZ3?=
 =?utf-8?B?NUZhK2xBaUxobG0xQmJyUlhGTEJkNkdET0djU2FqR1F4cDFqVmFUVEtFcFRE?=
 =?utf-8?B?RENKSEVKVGg4U0R0MVZsK1hJNHZGREwwVmhrdkRWNExKNSthSzk3eXZFNmhX?=
 =?utf-8?B?U1I0S1RYZWFkQlpkclhrOGl5UWRPS0VLVFhVZGhXMEFmVjlQa3FxRzcwRlo2?=
 =?utf-8?B?WXJFbzM2bUdtL21VZVRmMTlIUWR0WnAxSlFoZ016Ym91cEdqeDMreDVGWkkr?=
 =?utf-8?B?NlpnWGpRZFcyUGFsdHI4SzUxc01yeWNpMFNiOWE2Qjd4RjZZaWJsbzg1Q1Vp?=
 =?utf-8?B?UWNNUUpSR0plOTdkOE5BTlVlSkF0QVY2Z0pzZUZTVm5Ga3dndlFPVnFLMnda?=
 =?utf-8?B?ak85ZXRXOG5oTE1RRXlWVFlFOWhUeFFUMlFNcU9RVmRVbk0yUkloSlJaV1NU?=
 =?utf-8?B?NGJuOUdJc2JpRG83bFR4RzlMNkU1dnRuOTBiU2JVMWQ0MmNGVEM0clJER01l?=
 =?utf-8?B?QkRlZDhDWko0UlI3UUxqQXZPOFZQNVJPY0g2OTZwcGdpUk42ODZ4Mzk4a2lr?=
 =?utf-8?B?ODk5anBhTkRNakNYTjZQM2RvazRBNTU5NTRFVTRlcHpEamlXYVBwcFNHSXN0?=
 =?utf-8?B?eGFCd05tQndBeE5PeVlTRUp6OU5vdzg5UjFjaExjYVhGNEFVUm1NOHFqRks5?=
 =?utf-8?B?N0VGTnFGZDJlbW1QaUFCQURudEprM2hmSTlHd3MvWHNvWENMVm5hOUZ0MDNV?=
 =?utf-8?B?L01aWnBMUDRVbFZmWUNvYkdZNWJOcmg4WXhnTDhVeUp6SE9Wems4UW9FaG1y?=
 =?utf-8?B?b0JQR1NsM0lxT0lKUkhpNTlua1E5bEdyaElCMEJPeTJqOVpYMlRNQXNHL1E5?=
 =?utf-8?B?NjVuc05Pb295MXBrNEVCZlpoRm0vaEtJWk01bGxkRXJPdjZheFR0UXpYLzFB?=
 =?utf-8?B?cHpXNE1JK002OEpHVXhJQnpBSWc3czhBdXlRRC95NWN1dnlhWGpyZmRXck9D?=
 =?utf-8?B?aUtybG1mbE13a1RJTnVlWTFMMXpJRDM3NTgybHMyb1NmUUVJZnRmMDhwUVEx?=
 =?utf-8?B?NUFIVm9jTU9oQ3hrM255SFlMaGZ6N1kyb1JhNU9MdlZUMVNvWFpUVXRPWGF6?=
 =?utf-8?B?RVRDd3dxaG1mZ2twRXRaSVJTNTN2blpzbnFRVW8yZ0tGVjhVS0kzc3ZHOXhl?=
 =?utf-8?B?eC9aSEVGMi92QzRhSHJTQUt1YSt2eWdoWFRYMWhVNHcyS0d6Q05JVWJkc3ZD?=
 =?utf-8?B?cE5vMWpWTVVYeTluNlRZbEFKMS82TnZaaCtNMzdsdVRycTVDd1BiM2dwYlBs?=
 =?utf-8?B?QW8yVmVqMDh4RFowN3M4anBwamxYZUNoWURtSWw2TUFiR1BXSVRBUFd5MWh0?=
 =?utf-8?B?ejZZQjZzdzZFOVh1UGZJVWdScitEOGdFL2Z0Uzh4RUxXY3dXUlIvN2YvbkFH?=
 =?utf-8?B?V1NuMHZHSFRRYkNBdXd2OXF2ejVHcFB5Z2J6Y0FrTjdmVE1tZlhwSUJ1SDVz?=
 =?utf-8?B?YTVIeVg3bzNSYlpDRzN6UG5UNGhqaFUva1FpNjl5TnJKbjBBaTZZdk9MWU92?=
 =?utf-8?B?SVMwc2dWTXV4VmJHMmtsK0ZMRjlUNXhlZTZOTWgyc0NsSVRwblNFMUxxZ0c5?=
 =?utf-8?B?VEhIT21FY1N5UXhWb0Q1RXB5U05qR2dYYW4wOXk3bDljSUJzM1A3bmlyeHQy?=
 =?utf-8?Q?igsD7GjUK6y/H5ZsT3+WWeDZV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ee9b1d-2f2e-4414-0b83-08dd183ea070
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:45:42.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o712VDPP3Hsx1X+gbrj1NNifDIQ5VszfWboBUNKQU/0qwpI6OwuIIxyQbdIB6qP8w6UhTly1gNiFba0/mNZyoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824

On 12/8/2024 10:28 PM, Klara Modin wrote:
> Hi,
> 
> On 2024-11-15 16:30, Josef Bacik wrote:
>> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
>> on the faulting method.
>>
>> This pre-content event is meant to be used by hierarchical storage
>> managers that want to fill in the file content on first read access.
>>
>> Export a simple helper that file systems that have their own ->fault()
>> will use, and have a more complicated helper to be do fancy things with
>> in filemap_fault.
>>
> 
> This patch (0790303ec869d0fd658a548551972b51ced7390c in next-20241206) 
> interacts poorly with some programs which hang and are stuck at 100 % 
> sys cpu usage (examples of programs are logrotate and atop with root 
> privileges).
> 
> I also retested the new version on Jan Kara's for_next branch and it 
> behaves the same way.

 From linux-next20241206 onward we started hitting issues where KVM 
guests running kernel > next20241206 on AMD platforms fails to shutdown, 
hangs forever with below errors:

[  OK  ] Reached target Late Shutdown Services.
[  OK  ] Finished System Power Off.
[  OK  ] Reached target System Power Off.
[  128.946271] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Connection refused
[  198.945362] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
[  298.945402] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
[  378.945345] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
[  488.945402] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
[  558.945904] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
[  632.945409] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
[  738.945403] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
[  848.945342] systemd-journald[93]: Failed to send WATCHDOG=1 
notification message: Transport endpoint is not connected
..
..

Bisecting the issue pointed to this patch.

commit 0790303ec869d0fd658a548551972b51ced7390c
Author: Josef Bacik <josef@toxicpanda.com>
Date: Fri Nov 15 10:30:29 2024 -0500

fsnotify: generate pre-content permission event on page fault

Same issue exists with todays linux-next build as well.

Adding below configs in the guest_config fixes the shutdown hang issue:

CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y

Regards,
Srikanth Aithal
> 
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>  include/linux/mm.h |  1 +
>>  mm/filemap.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 79 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 01c5e7a4489f..90155ef8599a 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3406,6 +3406,7 @@ extern vm_fault_t filemap_fault(struct vm_fault 
>> *vmf);
>>  extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>          pgoff_t start_pgoff, pgoff_t end_pgoff);
>>  extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
>> +extern vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf);
>>
>>  extern unsigned long stack_guard_gap;
>>  /* Generic expand stack which grows the stack according to 
>> GROWS{UP,DOWN} */
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 68ea596f6905..0bf7d645dec5 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -47,6 +47,7 @@
>>  #include <linux/splice.h>
>>  #include <linux/rcupdate_wait.h>
>>  #include <linux/sched/mm.h>
>> +#include <linux/fsnotify.h>
>>  #include <asm/pgalloc.h>
>>  #include <asm/tlbflush.h>
>>  #include "internal.h"
>> @@ -3289,6 +3290,52 @@ static vm_fault_t 
>> filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>>      return ret;
>>  }
>>
>> +/**
>> + * filemap_fsnotify_fault - maybe emit a pre-content event.
>> + * @vmf:    struct vm_fault containing details of the fault.
>> + * @folio:    the folio we're faulting in.
>> + *
>> + * If we have a pre-content watch on this file we will emit an event 
>> for this
>> + * range.  If we return anything the fault caller should return 
>> immediately, we
>> + * will return VM_FAULT_RETRY if we had to emit an event, which will 
>> trigger the
>> + * fault again and then the fault handler will run the second time 
>> through.
>> + *
>> + * This is meant to be called with the folio that we will be filling 
>> in to make
>> + * sure the event is emitted for the correct range.
>> + *
>> + * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
>> + */
>> +vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
> 
> The parameters mentioned above do not seem to match with the function.
> 
>> +{
>> +    struct file *fpin = NULL;
>> +    int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
>> +    loff_t pos = vmf->pgoff >> PAGE_SHIFT;
>> +    size_t count = PAGE_SIZE;
>> +    vm_fault_t ret;
>> +
>> +    /*
>> +     * We already did this and now we're retrying with everything 
>> locked,
>> +     * don't emit the event and continue.
>> +     */
>> +    if (vmf->flags & FAULT_FLAG_TRIED)
>> +        return 0;
>> +
>> +    /* No watches, we're done. */
>> +    if (!fsnotify_file_has_pre_content_watches(vmf->vma->vm_file))
>> +        return 0;
>> +
>> +    fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>> +    if (!fpin)
>> +        return VM_FAULT_SIGBUS;
>> +
>> +    ret = fsnotify_file_area_perm(fpin, mask, &pos, count);
>> +    fput(fpin);
>> +    if (ret)
>> +        return VM_FAULT_SIGBUS;
>> +    return VM_FAULT_RETRY;
>> +}
>> +EXPORT_SYMBOL_GPL(filemap_fsnotify_fault);
>> +
>>  /**
>>   * filemap_fault - read in file data for page fault handling
>>   * @vmf:    struct vm_fault containing details of the fault
> 
> 
> 
>> @@ -3392,6 +3439,37 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>       * or because readahead was otherwise unable to retrieve it.
>>       */
>>      if (unlikely(!folio_test_uptodate(folio))) {
>> +        /*
>> +         * If this is a precontent file we have can now emit an event to
>> +         * try and populate the folio.
>> +         */
>> +        if (!(vmf->flags & FAULT_FLAG_TRIED) &&
>> +            fsnotify_file_has_pre_content_watches(file)) {
>> +            loff_t pos = folio_pos(folio);
>> +            size_t count = folio_size(folio);
>> +
>> +            /* We're NOWAIT, we have to retry. */
>> +            if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
>> +                folio_unlock(folio);
>> +                goto out_retry;
>> +            }
>> +
>> +            if (mapping_locked)
>> +                filemap_invalidate_unlock_shared(mapping);
>> +            mapping_locked = false;
>> +
>> +            folio_unlock(folio);
>> +            fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> 
> When I look at it with GDB it seems to get here, but then always jumps 
> to out_retry, which keeps happening when it reenters, and never seems to 
> progress beyond from what I could tell.
> 
> For logrotate, strace stops at "mmap(NULL, 909, PROT_READ, MAP_PRIVATE| 
> MAP_POPULATE, 3, 0".
> For atop, strace stops at "mlockall(MCL_CURRENT|MCL_FUTURE".
> 
> If I remove this entire patch snippet everything seems to be normal.
> 
>> +            if (!fpin)
>> +                goto out_retry;
>> +
>> +            error = fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos,
>> +                            count);
>> +            if (error)
>> +                ret = VM_FAULT_SIGBUS;
>> +            goto out_retry;
>> +        }
>> +
>>          /*
>>           * If the invalidate lock is not held, the folio was in cache
>>           * and uptodate and now it is not. Strange but possible since we
> 
> Please let me know if there's anything else you need.
> 
> Regards,
> Klara Modin



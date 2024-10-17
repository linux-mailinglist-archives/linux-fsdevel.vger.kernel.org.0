Return-Path: <linux-fsdevel+bounces-32241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96879A2A94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4A281974
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BD81DFD82;
	Thu, 17 Oct 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sx0Syxeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD41DE2BB;
	Thu, 17 Oct 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185480; cv=fail; b=oXKBpmOZkPoU5A9o8TP0UKVndd37l4i/JyaFeBeWhpm/hJ74IxRK3HNlQnjfDqnL51pS0JHSEp+/s0v/Z4Y281P2hVYk1YekCAPd8aBlar36nYyvL5z4ufM17KESMsqtJHmA+p+7SiaaRwGDmVcaN/FiKLE+ufOpAWoCehOw1pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185480; c=relaxed/simple;
	bh=h11UF9Lep9FVKo4+3lkw7BR/es7ROEfl/fzLAeJWAfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MLtGYmWbLhliVc5rJFBIXo1tXRFfxNN9eajCoKnWaEMj9TcYhBNUyNyHar9c/Mr4fjua599fB7eJInaNvi+ZjETw1CHhcoP613WbLIMMCBXVtawfauBVLBIncJmcHhD7C4EQPT3aaM5eflBqy/vJjJ8Ir/6wg6QC42xT2+oxNv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sx0Syxeo; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxqZdhgY7y7Ler15qRA6AhMidRqP9Etzaa0gTag7qP3f//gPZQKzauFyd+ADu13cZLiXZaw8BvMNvW/tlIB9lTf/LBQ0Stsz78e4eOLp/y4h1PesUFwao2H1u8giU7onENB4f6Y8A1w14Es9H4xDIbDVfOiskWtKcWJXwXAU9bdYoZO3/tt/N6nMSiHAE6NZ8Ip+CrEJ2wYYuYxp30pUUwwPivbNaqgFD+k8v8pb8pr8M+usJViJJRUKTQtlUmZb6EnwxI79gXJ/ID5WTSWYTbo38jV3QmsFASDLqRy0JXF+mpVdqUIFN5OOyCbSebATRr/fjdmB9qqSNdKWIOk+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsGwuh8/IjWkV8lEutqtDxVtfMAPlatKNNjQaWOUWnc=;
 b=gFntC9IeIy3/57SF3ZkT9MASxFZSlytplp3DQa+/ALVVZhr5JqkEHuBk5BwE8Mas6HHPqpYVpi33f5tDJOf98M59blTigoZ30ktb91ZudOvztXbYfcoJhxlMoyFlQ7Atfo0qG/m2QNqZKqejYYC/kn0gb58ZnzInWRNv+6GZTrGiAp0S03YPF8FZ+FcdOx4SgsFnLcjt0O00SNjve1deFpc77rEh5IJLIiq469u3z1hh2fmQEYCY9H09qHWnBj+BBVcUTT9tyziQoGYBTFyvcmxHPxx6zdZTOjyrvx3PBT+yflcL/0ZuffT1FjOfOC0tmbud2cByMDSH2XBktcgofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsGwuh8/IjWkV8lEutqtDxVtfMAPlatKNNjQaWOUWnc=;
 b=sx0SyxeoNnJSHapXTbazajEzcSdTC23OYeegIRaNbXYBz0DgZ5vn+00lXUBi1OO8amTnxVQjLH1XqDc8FuJQFKpVBzO1OMkY5Ld7ajrKLIiKpWWRx4e+V5FeR9fuGLla+QmE2yNCvln2DmuYmmly6IaKEJTh1GDcYnKuNh9oyCgw+xysNzjl/ZzpNJtqn9xn+wsuaziT7aIUGTRR5QLPtA2omqVEbqaEAke7mnQOtKnyNropasNBO3fhA6JZ34NPJG1GSdhJ37pL07nUC+Qn7mBZABXJtw+D9xDVACZHi1h1kX55ZDnLCwaSRJ5P938JUwEJsjGXshZy42XxlJdX2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:17:55 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 17:17:55 +0000
Message-ID: <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
Date: Thu, 17 Oct 2024 10:17:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::10) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: a4521d23-073c-4950-328f-08dceecfa3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTFvbHhSdE9IdVB3STRlNEM4ZzlKU1JJZUt6QkRJaFNXYWh3RzdWMkpSREhp?=
 =?utf-8?B?c3hxczlNRnZxY3FSeVFyK3NubnA0K2g5ZjdpMW9HR0lOWUFpcnY4V2poOVBY?=
 =?utf-8?B?aDFmY0hFNTllc1lkbFU3S1VYWGF1V3VtOVpnSFoyTFpEa2R5VllZcWVsNUts?=
 =?utf-8?B?RmFxUXhpdlhQUDY4bkthVkJETG1NYlpzZXNqN05FTjlKdTZZbk1yL3NTaGRz?=
 =?utf-8?B?RmdQV0U5L1BjN1hJSUZjU0RnblFxTTd6Yi9BbGxRRytvTWhSTC9jSjhKMDBF?=
 =?utf-8?B?ZTdUOVEzamdyOUxZYlBTbmR5dHJQZ1ZqOWVvcm8xMmhodmZsaHZrVGE4QlVE?=
 =?utf-8?B?dE9wZitFVWRNNGk5V2FvM0hhdmZ2LzFMRWtPRy9NSDM4TjJabkVEbmU4Y0NQ?=
 =?utf-8?B?em0ydVJONVkra2xBUlN1T0JWRlJMcFpGamNOeFoveU5HRWNlblpkOXo3WHh1?=
 =?utf-8?B?Wndxa0I1TDhaa3Q4YytiNFZWNSs0K1pBUHpqR1pTbHBRaG1tZGtLUEdKMzVo?=
 =?utf-8?B?VVltbmRrU2RON0NmMjNlTnZzWXEyTkFOelRoMWttUFlwbGxGWWMxL3FYR0hN?=
 =?utf-8?B?VzczVE1WZjNXZk5KSEpKNDN4TmNsaVdWQVV5WjF0ZjM1blpsNnBBSHFVRXlL?=
 =?utf-8?B?SmNkMndYcHlPVEVSREE2K1drTVljR2xUd1pINUxCWllCVS9aUHNybUl4UXpO?=
 =?utf-8?B?MVRLY3RBMzdaVGVvcmZpcnhlcW9EclpVaWtERVJzRExFT2RJTHFLOHBwSk83?=
 =?utf-8?B?VHpXZkhrKzI0NGRNSEZZaEJGR2Nxd3FnbVhwVGtrWmJDeE1wcjh4dW1JNFh3?=
 =?utf-8?B?NG5lWFFwQXZKcXZzWlJJWmxsbEZ1QjZYTTN5Vy81YnM2a2NCWk1PZlh2QWh4?=
 =?utf-8?B?aWZJeEVwYS9lWVEvZklsOURkU1dyU1ZEeWV1Z25jVENhM1A5cGhublRuTnpO?=
 =?utf-8?B?NUovZ1o1MWFrc3JsTVdHR3ZXTW53eEc4ZTNpNlF0MTY5anZRV0dPWXVsdEFi?=
 =?utf-8?B?VTNwb0NGOEtsaFJCdFI3dkhsbnJGTU5mQzdyekE5Q1RSTkJ1MjUyRVphMTZC?=
 =?utf-8?B?WnVucWEwUythK0ZzMGJNWnd4VnVma2MzYlNIblpaVENwK0lNNnZ2cVc0UEZJ?=
 =?utf-8?B?REVKazRwNkhRS25aMS9LNmtrY05xazM3U0ZEVUZlZHpOYnVRTUIzbGQ1bGhq?=
 =?utf-8?B?UGRkcGYySStYMnhQL3NETHBrb2hBU2xHR29GMVhQa1VRNFI1eVNFTkxoeGJ5?=
 =?utf-8?B?dkpLQU5wb0h3Z2ZEbGxnL0lUbHJjREVBcUpZQ25mZ3dIRWJaQ1pMalhBRFlO?=
 =?utf-8?B?aUdqeW1sb1VkaXZIL1VyNEVMWFJMNSt5S1RSMnMzSWY3aUFJMFgvTWdsZDFy?=
 =?utf-8?B?QVcyZFNXbDhNaE1RNUFpRnJyU1VmQnFSNVZTZVEvZTQzSysrR3pmOGtYK2s4?=
 =?utf-8?B?OWFYaVduQ0pReGtvRERaNEQ4RnVTUDNmd29RU2lROEwvYVJEQ3FUeWpJQnY3?=
 =?utf-8?B?UC9tcC80U1BjUHY4SkF6cnV1VjFPOHkya1RFNVBkRFdrWEdXc0NOT0VEY0Zn?=
 =?utf-8?B?K2dmSXJyN0pzT2FlaGNHT3daYUN5WmVoWjVwOExMWW52R25kbGhWc0h0QUQr?=
 =?utf-8?B?TCsrQzJiK3Y1UjAwNjVhZ0FSOXlmdlFqUDhxd2dqcVovVlJ0RWhHTHRsZDdn?=
 =?utf-8?B?UEk0dzMza2l6T2ZTV0hVVGxzWGJCWEw3V1pRMWNDWnNobzdBR0c5QW9aTUQw?=
 =?utf-8?Q?HGj0MxNA9h7ad8CNV4IPNawprLepbccikolaOkT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azRodktXenEyemMraThIQlJjOGxjR0FZaWduaS9scW1GdU1sZTBwR1AvNGpz?=
 =?utf-8?B?UnZtclczMlVwdXREM001QzdobFZKWVlXZjZKbkhDYnRKbWw0cnc5YmFlUVBP?=
 =?utf-8?B?VXFlQk5DYTBtWDFMY2lhNUhjUnNqQ2cyUlZpZDVVdXp6R0VHQWIzVktGbVRU?=
 =?utf-8?B?UFltbG5VRW9ua2hnRTYxQ1RtdkpIdlpoQlBZUmd3MWloMGU1OEdvSFFZR3F2?=
 =?utf-8?B?YUVlaWUrdGdjU2M0cTRGNmZ4c0FUM3EvTE8veG5MMjAyNEd2OGZSNGtTZ1l6?=
 =?utf-8?B?WFFiSGt0U0NyRjVmSUNLVGZEL1NjM3hLeS9nSnNYMHhzeTI0ZUtKTnljd3dm?=
 =?utf-8?B?OXVPYzErcXZMeXhpVjdFYlpnTlh3UlcyYmExMjUwQW1yV24rNmFlWHpGRCtK?=
 =?utf-8?B?c2drSDFMZHZnMHRwVWdIUDRIK3l5eUFlMDRCZGlHRTV1MFF0VmhCbzZVMTVB?=
 =?utf-8?B?N09Pb2szMUY4THBnVEx3VFZRclZESjlwSEp4a3R1SjA4NkZMeklqTTJnUE9o?=
 =?utf-8?B?SW5tZlU3eU1RUHlXRXViaHlYazRqdTNoQlBYN3VmK1FlbGw2c2p0TGtvQ3Fz?=
 =?utf-8?B?MmdxMVRFTUdXenNlWG43N1E3TjhuNHVZbUwvN001Y01sWGJlbUpLQ29SR05p?=
 =?utf-8?B?UkEvdXZpTUdKTzh2U0gvdnpoNStjL21YWXU5SGVDOTJzdHI3OCsrdTBLV24y?=
 =?utf-8?B?blJ6Q00yd1Q2L2RIQTVMNzJ0VVdjOXBWQWZmcHd1MlZQZlkwMUw4WEh1ZGRj?=
 =?utf-8?B?MHc0SVFKZ0x2WHQ2T3diU2pBaWszSGdoOFl3SVF0SmRZRVB3ZHFzS012ZlFS?=
 =?utf-8?B?YzE4LzdQd3dUT0xsTCtCSnlSRlpMcm9MMzk4WmVlWkF0bVV2aTVBVXB3U3Nz?=
 =?utf-8?B?dXFCblR5c2FoVDlUK1F3MEJHRDBUOFhEOTJVK2p0d01pNkY0a1Zib0VEYlZG?=
 =?utf-8?B?MzhHdUI0NlFXMmNCSVBobU93TU84MnloVkxxeFROQUNjMEdqdXdPSDM2UWlU?=
 =?utf-8?B?TXRRbmVCbjN2M3dZd0ROT21aOXFYcUZNOXlkZ0lhOXVaNXlMd0VqS0NvVVln?=
 =?utf-8?B?Ny9kdmlwOCtsWXVmL1BiT1FaaWRZVDNnR1lDTitKS2R0T3VzelhBNVZDd2hq?=
 =?utf-8?B?NnlOQ3dzMlZ5a0dPOVJsNkh3MFpkc2RlOE9kcFZXc3dBbWJjYjBRMWRuaWRj?=
 =?utf-8?B?WkhkbmRmR1JlRHIxSmJFNFhkaklRQmM2L3FFb3lTWEs5U25ENUNtTC9jQnR0?=
 =?utf-8?B?NmttWmZSNkNRbjZoT0tpeFZGTUx3eFdtdllOTnk0ekU3VW9kZFJtZ3VHbldK?=
 =?utf-8?B?eVk3K0ZjSDBQYTVwMkdNNlhGdlJVeUVWdDR5aGpjdFo3Y0l6SDNoWmRpTHpq?=
 =?utf-8?B?dGNJRVVkVHhRNTZSR2svdnkxdVAvU1Z1Tmx1alROQXhWZmpqcU5wRmdlSlJR?=
 =?utf-8?B?TGV4VDJKMSt3bkVHWXFYd3JpWEZiZXVTRkZHZHpQN3dQdWEvdmJKbHEyVTBj?=
 =?utf-8?B?RG5LT1VnOGJEUFlrWmRRNEkrVmhKQUFKMkNIZkVaWnNwdDlCQXBIczZwRU5a?=
 =?utf-8?B?YXlFMGF2U2RzcWdBR3BaOTVEc1hML1FmdTFBSno4MXg2TlJNRTNQdkF6NDFs?=
 =?utf-8?B?L3QzNHdPNEtlWDhKTGFpTzRMK1BDaGRaVDc2ZWNwT0V0WXluR25uSSs3aGxx?=
 =?utf-8?B?R3pIMSsvSEFRNldkbzg2YW5qT0NxZ3g1M1JaRHU3UzQ1SkRhbmNnc1FlaDVZ?=
 =?utf-8?B?WXo3SG91YU5leHBlbTMxZFU1UnRmSXVVWmw4bmlRUERBaDNESUhWR1V6UnNo?=
 =?utf-8?B?Q3d0U3dCR1ZPNVZ1SVdpTWcvUEkrU2hMTS9KSlBJdG5SZFJ2VDdFaTVFK1NU?=
 =?utf-8?B?S0Y0bjJzVkJUWm43RXQ2cDFJN1BQUVZvZVdPRGNNVkxHUC9lUjRwU1F1Mnov?=
 =?utf-8?B?MkpkK01hNFB1RzJ2UWVQMytnOVJZZ0dkUzViMGpJSkZJTm84R0RCamo5WVhl?=
 =?utf-8?B?VnVpOUtGZjB5UEtxY0RiQjV4NEE3NWdiTDY0WjhxZGtBL0pCUUJJRkd0MTlj?=
 =?utf-8?B?Q3Rvbk1GbFBaZXlCemlCeEo3ejkzT0RqaVZWeXBxVHdxRE9YbllhQXcyTTBn?=
 =?utf-8?B?dTFqdWNCZUJqQUVGUGF1dGMxYVhpTFhqWTRKMEZ3L25ORC9YSzdReDVzYlNW?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4521d23-073c-4950-328f-08dceecfa3dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:17:55.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoWPehkYXuJ2zbj70gngKyVvibs6q5XRvPKz0qYz3SFyx8ARm+CKEzKPSo8ZOAxem5sZrBr646vvjprnvrlZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
> +cc John, sorry I forgot to cc you on other replies!!
> 
> On Thu, Oct 17, 2024 at 09:08:19AM +0100, Lorenzo Stoakes wrote:
> [snip]
>>
>> In any case I think copying the header to the tools/ directory with this
>> linux/fcntl.h in some way stubbed out (we could even stub out fcntl.h
>> there?) is the sensible way forward.
>>
>> A 'just include the header' is simply not an option as it breaks the tests.

I should have read this one first, this morning, but I missed it 
initially. :)

> 
> Ohhh ok I think maybe we could have a good compromise that should (hopefully!)
> satisfy both you and John.
> 
> I can introduce tools/include/linux/pidfd.h that is a stub wrapper around
> the pidfd.h file.
> 
> So it can be something like:
> 
> 
> 	#ifndef __TOOLS_LINUX_PIDFD_H
> 	#define __TOOLS_LINUX_PIDFD_H
> 
> 	/*
> 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
> 	 * work around this by setting the header guard.
> 	 */
> 	#define _LINUX_FCNTL_H
> 	#include "../../../include/uapi/linux/pidfd.h"
> 	#undef _LINUX_FCNTL_H
> 
> 	#endif /* __TOOLS_LINUX_PIDFD_H */
> 
> 
> Then the test code needs only to update the pidfd.h file to #include
> <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
> the pidfd self tests Makefile and we should be all good.

Yes.

> 
> That way we always import everything in this header correctly, we directly
> document this issue, we include the header as you would in userland and we
> should cover off all the issues?

Very nice!


thanks,
-- 
John Hubbard



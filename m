Return-Path: <linux-fsdevel+bounces-63624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2EEBC7356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 04:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8043A02F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 02:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2281D435F;
	Thu,  9 Oct 2025 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hUXo/hoS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C51A9FBD;
	Thu,  9 Oct 2025 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977267; cv=fail; b=sxDSqKDhR+SZSBjvr58rqRED2BX/nCtuxHoE2VV0xwTd5G0I9CpD+LLySE9sVZx/Algl/3aQSmBcGFQP/GiPdRPZKvX0i0jcuELiJ5DYNp4oh2CvzilxYKtLbL+YsFSEzAglpx9+nY7DdxvBg6I6AWjWxNKYwHP2e1DQCirdHdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977267; c=relaxed/simple;
	bh=E/Fy0WxtE6LZ3UqRXfZFZTPEDC3RBRyGNTVQqn933Eg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQMM0lCkdovOiNypcPxGxcMVDy2XVVGePhHJaO582gUoBlAdeNf7UNpW4GTKvRKV1JKatas1he6qwBp7vJQDhszzk7SetMLMltC3wPPC561a+tq06sQpZRWRl/QMVg4h3VKSzGjrjgypCn1DVafhPbUxAkxZOn+XVqaQazz2gBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hUXo/hoS; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp8HQYbU3wKDKIIxPIeBDGsTBJKg+Uc67K1fBTGWdthkmVgkp4WaQdr535EVTbd0MEd986/SZuuhErDEuMnQzZHnOG0jsWUEwBFCeQorEj6Sub/yCSWKGMx01MltLTJ5nYJS0wjOOf2rIyGW1MV6SepdWJ7M+NnEQStC5TpLtUtELLWws0r9VTD2Tt5zTK8roXpYSlF8o/I6Jwj9YqrzdOL0iAIRehqxyJ1GDd5YeICPsTN9POraE4s9xyozXoItGg421AEJALywsux81gxcl9IXpWZHqAp4z4hzRbvJCd+wEP+yqM3J2PgMv4dQ9z0PoUQEQ7qYYqLR74aIyxkQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu/YYrXIVy86D90cbSf3sSiagP5FIjQW0BqCG/sjnKw=;
 b=vhz0saMk/jwac2BwYoMd6HZ1AP7aqFnqbibJzNjOe40d7QJyQIbwWWjyu9SBBiHTZnFu5QcQ6TDHRVSlHO6Dm85y3EvPUleSFg2bHPg7a2rmxvz/vlRXhHGl66ND3TfVd6vVtO1ijADdQ+fBAqF34vsUQucrpUxw024c+FGk4srMRA4Ni9q/pqF7lKlz383anPVfD7zjVtE5cz6NDRM9CcyjpnDbjQkLeuzmOCOfrlmG4j6HPfkn6G3kDbdgsC7sVJUECNZn6z1KTXU46q5gmxFkO3NmWCV+dvX/4/sSEjPGV7wZ9KOvdXbZc/wBV/LpfP6rXTfoBVM2qCksREThag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu/YYrXIVy86D90cbSf3sSiagP5FIjQW0BqCG/sjnKw=;
 b=hUXo/hoSc3UdISqAx9rhLGREPIGnZxjUM/jXNFhdM4+VnyLR12b6Y+TfQw7AIkTfH5r7YNyvuEt39F3ORipaWU63MYVIK6YpyPiGSfW9Q1aHWp1F1Stnfq7PD3jh6JykSe9KdL0oTl+jsqhiGE59NkjXsrLxDjwk/kZqZquRIVsoLYt9AUbv3hxFwVKchmYFjp4H4r8gJ9MGugPyMX+i1XE2aqxwB+biav1r3fNTbs4WBx9haogwyg43W6a820TR8QH5sAg54kTLYWx8VD2ezb8nYj0i4Vcm1yvEGqSAok2MP4LETrDG2uO7VSA2h9LvcECwOpeVGb/jxkUncpR9Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 02:34:16 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 02:34:16 +0000
Message-ID: <26e23ce3-6108-4428-902c-95863f25d3ff@nvidia.com>
Date: Wed, 8 Oct 2025 19:33:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: use enum for vm_flags
To: Jakub Acs <acsjakub@amazon.de>, aliceryhl@google.com, djwong@kernel.org
Cc: akpm@linux-foundation.org, axelrasmussen@google.com,
 chengming.zhou@linux.dev, david@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com,
 rust-for-linux@vger.kernel.org, xu.xin16@zte.com.cn
References: <20251007162136.1885546-1-aliceryhl@google.com>
 <20251008125427.68735-1-acsjakub@amazon.de>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251008125427.68735-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: dec961bd-137f-438f-85e2-08de06dc574c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3dEVElZeW5PNE5leFhtM2QrRzV3YzE1WkxYbzZ3aVJIRjhWV1hSdk9GN1Av?=
 =?utf-8?B?M2J3cUtlSUJVUHR5b2tEaEJxN1JyNVRTeitOTTNNNWNhbmhvQWwxVHZMSjFQ?=
 =?utf-8?B?OXpPeUdzZXpnSTVqWFlBMTNKU0dCbmszQzY2N0YvS00xNHBnUVdMcWNJRnNQ?=
 =?utf-8?B?T1RqUnVKVlE5SFh6STBlUnZtR3hVcE1iUmVpQjVKT2FEMEJwNVZDU0NFR1hy?=
 =?utf-8?B?UTRRNWlVRHRzajBuUE5QQ3F5eTVGSk9Zd21GbUtpWXMwU0s2UmhoVGJNUlcv?=
 =?utf-8?B?YUpjNzRGalJnbnQ5enYyUnQ3dUEvNmpNNkFUcnN2NlNBUHZjS3BaNTM4MkZn?=
 =?utf-8?B?NEp4aWxCY1V3OVZldXlXSnBQRGNNd2I5azJXT2ZmZE5XT3VOL3dEakxLZ2p0?=
 =?utf-8?B?VUVtc1pyUnROcXlOcDYxZmVSMktOd2Q5VFJnOURweXRwMERvcnBlUklXTUpr?=
 =?utf-8?B?a0sxYjZpaVdHM05xT3k3MklmR1k2bWpvYzdjcEFXTnJXMysySE5yemxqdElO?=
 =?utf-8?B?UTl6ZzhGdE5QQjF4UkF2TlkzUDQ0SDVHdmRzem52dVV4RTVod09WMThCMWNy?=
 =?utf-8?B?NkZqMmp5NHgwMEY3UUxLc0M0NFRpQkdKTnJWNlFnTHYvVk5qclNwYXlmQ255?=
 =?utf-8?B?aUFpUVpZZnMxVVZONkdHRm9LMXFFTUtiSm5sUGRTZjdYemlSdGx6aThZaDVD?=
 =?utf-8?B?Uy9aVzUyQUF1cmZDZW0rRjV3ZGVMOXBQOWtuTkNONUtMaGVjV0JNaDFLOVhj?=
 =?utf-8?B?TW5iNWJYRXVhQ2Fac3FRWlJaMUt4dTRnSVZDMCtQRm1MbG8yQW9rTlQ2azJH?=
 =?utf-8?B?TXRsTUF3QkFuZWJHSG4rQTdDaFJNS2czVDc4OWpPOVBZNTBHY2xZRXl6SW9U?=
 =?utf-8?B?bE1uTVRPeURsYWpVdXM3TzROTGVFOXRBY3FrN2swY1VhQzEzL2FFUWJTQmVr?=
 =?utf-8?B?OG5wK0wveEFCdGI2ek1XYkhSVWVWTjRGZmFkQm1RM0psUmFJTnF5Y3RYNTZ5?=
 =?utf-8?B?eDdBQlRXaVAyaGV5RW9qN3NONUZNL2ZReVMwMWhIaVR6K1RrMkI0UUhGZnpH?=
 =?utf-8?B?Q0xYYTJwRmVSZHd4WlREWGNva3duZDNCVVA5WXBkWWZzdWtpZ3FIQXA3RTlU?=
 =?utf-8?B?RitSYnA0c0V3QlVDK2RlSU1JV0kraEUxN1l4RjhXck1LUnoyOVBXeENGV1Er?=
 =?utf-8?B?ZFRtVTB5VXBUei9wdnlHK25MVXNrWml4ZXVOemluQ1prc3RNOWFzMjNhNEE0?=
 =?utf-8?B?M1ZkQ1AyMFpjUWJhZVVXaHkyZGEwYUk3dlR6UEE1NCtXMjJ3UWVid3hjcnJK?=
 =?utf-8?B?MVBwSStQNlNGaitMbURWZU1zazR6YzYwY2NibTNKT29VR3I1Z0pMd2FuUVVW?=
 =?utf-8?B?QWVMK2lnMDU2VitHNGFvb1JIUjJKVTQ4Ly9Udnk2b0NwcmIyWFVYc1NZaWV3?=
 =?utf-8?B?R3VJVjZBVFJya3BNT01sWk5oYVNOVFFnSG81eHFpRzNhSzBKTGNjcTMvbEdH?=
 =?utf-8?B?MWhMeVlkSzJOTS9iclRGWUV3Ykg1TytOa3ZubHhkTVdaUUk1NjMyWWJzN0Nq?=
 =?utf-8?B?ZkR3ZVZiNjhkTGwyM3prVXBtK1lYYmlmbVNCSklLTVBMZjNNdW1pNityT01u?=
 =?utf-8?B?K01UYnNoYTlIZ2JHSENhRmNFVUFTMFFCeGFESjlpL0sxd0FURk5TVE0vaUlv?=
 =?utf-8?B?VjVJaFFkQ0FXakRsUGk3M0NDbEd3ZTFQY3ZWNEFoU1BlV1d3WThJNFd0dTdF?=
 =?utf-8?B?NXhtTDliY1NiM2c1QXFwZlErbHNmNHEzYi9wY2VVRDA0N24vQ0lKQ2pLYlRx?=
 =?utf-8?B?UDZtSjBlbHlnZUhBc3czbmp3bzB5SkZlNC9ZQjlYVkVQUVNPQUlrejR0MVVN?=
 =?utf-8?B?Z1hPTW1zbzk1dW4rSDN0dkxxTDJIYTVYeGYvOFR2S3NOcDRXSk5WK1kxemV1?=
 =?utf-8?B?TWlKWXBuVitseXRjWElUU1ZSOE9kc3UyMk1MSGRRV3ErWW9HeVhUSVpEdlVt?=
 =?utf-8?B?UmhtRkQ4eXlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRRWWs3VTY4aGI2N1hKUlhpS3VmVnB6SW5sYmR4cG1pQnFrdjIvS1IvWnNP?=
 =?utf-8?B?MXhXcDlxWnJOYTJTVW9QMjF4UWpIMzJhYjV3R2E0cWZzMTlkZDJxckNWQkNt?=
 =?utf-8?B?anpvdCtnU1dYMndQWU1zNkM3ZVhHZUtlM0xvVW1JNlRBbk5KYjAwRHlEOENT?=
 =?utf-8?B?cmh1L25pN2VXVTdhclpWZmp3STRKMWtYOWRYTEhJb2MyaklmVDlWbkorREQ5?=
 =?utf-8?B?TXpnNDlscGkybS9OcVAzOHEwWHIyeEsxazlUK1Q5L3VHUzBjZmdXZW9UNzJQ?=
 =?utf-8?B?cjRvQlBKbmtvWlFxUklXYVVhOXVVVjJpUm1oelh4bEZ3dmVnVlpycUt5SmU4?=
 =?utf-8?B?WUZmS0xkdDRvR3lIYnFZaHNKY0tnb1VmbEt3bVArYnliTmRDMnBXMmFFMDZY?=
 =?utf-8?B?WXFiRkU3SHAxUFcwVHhHMUlpaWgvdHAva3ZjT3NjUXJtcHpPd1FiR0QwTzhE?=
 =?utf-8?B?NXlJT1Y2a0UveStNZDhnRFIrMGFIdzBFcng1U09lMnlzV3ZNWjN1UzF0a250?=
 =?utf-8?B?QjNMSmZIdnBsM1NCNHJobFVIODY2RVovajVMdFY5blFGSlBlMkN4UHpLazNC?=
 =?utf-8?B?cVp2MXdwVEVRYzNUU2xWdFhDZGFtWnB0dEZXclRvOHdYTk5KcHBBUGRLV0p1?=
 =?utf-8?B?ejJZTWFMVjdnSlM3aGtYRkR3UnM4MW8xNU92Y1FYMEFVbmVlSGlzTENOMUF5?=
 =?utf-8?B?TWczbkpjbVhnbU1tR1VXQXhNVEFOTCtiMFp1RDJwV3A3NktaTVk4ZzdLdkFt?=
 =?utf-8?B?R0xtdDdROTRJMGVHTHhzYzkvdFhZVk03V0l0UUpBUUticGdNaFhJUlFIM1R5?=
 =?utf-8?B?L2RLdjZOUTdEMHFhY1RjNEY3MVBWOVdVR1JDRUUyMjFrN2NrYk1paHVFTDIv?=
 =?utf-8?B?OS93V2M0MXZzTFpWSkhFRHl3Z1BQRnNWclo2RHhaRUY5RGdXTi9wSzY5OGxU?=
 =?utf-8?B?anhUeFlQOEl3R000aEV2a2xtbzY4cE00NVBRZG1LcWVsbmh5Q0xDMG5wZXMr?=
 =?utf-8?B?SHJnd3VyVGdOcnFkSU1yTG0xaTFpenhDL0xUYVQrT0FjK3l3YWxyeGVtTFYw?=
 =?utf-8?B?bGg1RnpjLzQ1My9MWE9rbjRmVjlBd0NBeHhDdktDd0I4bjh2KzVDTlEzbjli?=
 =?utf-8?B?cnhlNzNnY3g0dkdicFlJSkV5Q3VqMUZUOUJmTk44QnBwcFBrenhOQVVzcHA1?=
 =?utf-8?B?TjFRbnhRczg0UWpiSXF3VVVWTTkrbmdpM0lQS1d6OGxvY2k2ekMzTWxDQ1hw?=
 =?utf-8?B?MUgvTHZpZFJEeDFPQ2x6Z0FIUjBDVjJkeXFCdStZeGhrVlViS0d3WjZ4VmZE?=
 =?utf-8?B?THFFaTRrRnF0K1ZJN1ZJQXdzNEpRbWdnWWhBY0pQTFdFN0xqL0VuY3c3SWNX?=
 =?utf-8?B?b00rZHVBTSs1dEF4czV1dEFlWDROZm1ObzZpdkhQQzRKR2JxZnI0VUt3bTdG?=
 =?utf-8?B?eEJwdnA1Q2lnV2xQRk8vV1p1WTVLK1JDWHpSVWp4MTRxSEl2MnkweDFRK0hy?=
 =?utf-8?B?eTRnaDI4cW42OXZWUEdEU1pxQ0lNOVBWK3FMWGdnQjZEeW14VHkyN1I4ZDVi?=
 =?utf-8?B?bmNOaURvdjlhaU5VSy80VUp4VG1lYWRyQzhMQ0VFWVB5UzRCbjM2enVWazNQ?=
 =?utf-8?B?alVEcDlNK2phYy94N2ZTVHE3RDFjcDN1ZjFEWXg2TFJ1dHlMelowVy9ndTRB?=
 =?utf-8?B?Tk02V0ZCTlJQR0prQjJHWmQxTTFjZWZDc3FVeWpoYVFLU2ZlbFpaQzI0bDV0?=
 =?utf-8?B?SnhkY3dWdEhTT1JmSVBYbTk3RldwazJxaGJ5cEFTMXdEeEEvWjFmd1E3Y3d6?=
 =?utf-8?B?Qy9uVVBmK2tBWmQvbU9iNFZySVVscGNXQVJHbEZNbFl0L1pISlhydjUxODFr?=
 =?utf-8?B?azFUd0M1ODlnckM2bGIrRDZ3TjF3UXZBSllId3RLTHA3WjJUb1VjNS9CWEVy?=
 =?utf-8?B?emFkRXBrUTJKMWk5d09DdWh0aGp5YVdneEtYcWlNT3NEYVVGaTZJcGZ3R1NB?=
 =?utf-8?B?VDNEZWk3YTZyUkV4cG9Mb3lhNUxsQ2g3K0QxdmFsV1JXUjV3Sm9kMHRZalFo?=
 =?utf-8?B?OFB5L1plRkpvZExIVVhLSUJQYVZMRjg1SFZkYUZSMXI5SzJ1MGhFUW5vQXpv?=
 =?utf-8?Q?qJaoYd9pss2AjkGjjA2UFisOA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec961bd-137f-438f-85e2-08de06dc574c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 02:34:16.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aEd8idkyxbC10JYGwYu9HcBt6xWCksq3KccWqqHqk8QU12Zr3BRjZrS666DqOXg82/BYZ7/jsdrKw3a3M+BIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

On 10/8/25 5:54 AM, Jakub Acs wrote:
> redefine VM_* flag constants with BIT()
> 
> Make VM_* flag constant definitions consistent - unify all to use BIT()
> macro and define them within an enum.
> 
> The bindgen tool is better able to handle BIT(_) declarations when used
> in an enum.
> 
> Also add enum definitions for tracepoints.
> 
> We have previously changed VM_MERGEABLE in a separate bugfix. This is a
> follow-up to make all the VM_* flag constant definitions consistent, as
> suggested by David in [1].
> 
> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> 
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> Hi Alice,
> 
> thanks for the patch, I squashed it in (should I add your signed-off-by
> too?) and added the TRACE_DEFINE_ENUM calls pointed out by Derrick.
> 
> I have the following points to still address, though: 
> 
> - can the fact that we're not controlling the type of the values if
>   using enum be a problem? (likely the indirect control we have through
>   the highest value is good enough, but I'm not sure)
> 
> - where do TRACE_DEFINE_ENUM calls belong?
>   I see them placed e.g. in include/trace/misc/nfs.h for nfs or
>   arch/x86/kvm/mmu/mmutrace.h, but I don't see a corresponding file for
>   mm.h - does this warrant creating a separate file for these
>   definitions?
> 
> - with the need for TRACE_DEFINE_ENUM calls, do we still deem this
>   to be a good trade-off? - isn't fixing all of these in
>   rust/bindings/bindings_helper.h better?
> 
> @Derrick, can you point me to how to test for the issue you pointed out?
> 
> Thanks,
> Jakub
> 
> 
>  include/linux/mm.h              | 142 ++++++++++++++++++++++----------
>  rust/bindings/bindings_helper.h |   1 -
>  2 files changed, 98 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 70a2a76007d4..8b9e7a9e7042 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -36,6 +36,7 @@
>  #include <linux/rcuwait.h>
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
> +#include <linux/tracepoint.h>
>  
>  struct mempolicy;
>  struct anon_vma;
> @@ -273,57 +274,58 @@ extern unsigned int kobjsize(const void *objp);
>   * vm_flags in vm_area_struct, see mm_types.h.
>   * When changing, update also include/trace/events/mmflags.h
>   */
> -#define VM_NONE		0x00000000
> +enum {
> +	VM_NONE		= 0,
>  
> -#define VM_READ		0x00000001	/* currently active flags */
> -#define VM_WRITE	0x00000002
> -#define VM_EXEC		0x00000004
> -#define VM_SHARED	0x00000008
> +	VM_READ		= BIT(0),		/* currently active flags */
> +	VM_WRITE	= BIT(1),
> +	VM_EXEC		= BIT(2),
> +	VM_SHARED	= BIT(3),
>  
>  /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
> -#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
> -#define VM_MAYWRITE	0x00000020
> -#define VM_MAYEXEC	0x00000040
> -#define VM_MAYSHARE	0x00000080
> +	VM_MAYREAD	= BIT(4),		/* limits for mprotect() etc */
> +	VM_MAYWRITE	= BIT(5),
> +	VM_MAYEXEC	= BIT(6),
> +	VM_MAYSHARE	= BIT(7),
>  
> -#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
> +	VM_GROWSDOWN	= BIT(8),		/* general info on the segment */
>  #ifdef CONFIG_MMU
> -#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
> +	VM_UFFD_MISSING	= BIT(9),		/* missing pages tracking */
>  #else /* CONFIG_MMU */
> -#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> +	VM_MAYOVERLAY	= BIT(9),		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
>  #define VM_UFFD_MISSING	0
>  #endif /* CONFIG_MMU */
> -#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> -#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
> -
> -#define VM_LOCKED	0x00002000
> -#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
> -
> -					/* Used by sys_madvise() */
> -#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
> -#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
> -
> -#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
> -#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
> -#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
> -#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
> -#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
> -#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
> -#define VM_SYNC		0x00800000	/* Synchronous page faults */
> -#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
> -#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
> -#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
> +	VM_PFNMAP	= BIT(10),		/* Page-ranges managed without "struct page", just pure PFN */
> +	VM_UFFD_WP	= BIT(12),		/* wrprotect pages tracking */
> +
> +	VM_LOCKED	= BIT(13),
> +	VM_IO           = BIT(14),		/* Memory mapped I/O or similar */
> +
> +						/* Used by sys_madvise() */
> +	VM_SEQ_READ	= BIT(15),		/* App will access data sequentially */
> +	VM_RAND_READ	= BIT(16),		/* App will not benefit from clustered reads */
> +
> +	VM_DONTCOPY	= BIT(17),		/* Do not copy this vma on fork */
> +	VM_DONTEXPAND	= BIT(18),		/* Cannot expand with mremap() */
> +	VM_LOCKONFAULT	= BIT(19),		/* Lock the pages covered when they are faulted in */
> +	VM_ACCOUNT	= BIT(20),		/* Is a VM accounted object */
> +	VM_NORESERVE	= BIT(21),		/* should the VM suppress accounting */
> +	VM_HUGETLB	= BIT(22),		/* Huge TLB Page VM */
> +	VM_SYNC		= BIT(23),		/* Synchronous page faults */
> +	VM_ARCH_1	= BIT(24),		/* Architecture-specific flag */
> +	VM_WIPEONFORK	= BIT(25),		/* Wipe VMA contents in child. */
> +	VM_DONTDUMP	= BIT(26),		/* Do not include in the core dump */
>  
>  #ifdef CONFIG_MEM_SOFT_DIRTY
> -# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
> +	VM_SOFTDIRTY	= BIT(27),		/* Not soft dirty clean area */
>  #else
>  # define VM_SOFTDIRTY	0
>  #endif
>  
> -#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
> -#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
> -#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
> -#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
> +	VM_MIXEDMAP	= BIT(28),		/* Can contain "struct page" and pure PFN pages */
> +	VM_HUGEPAGE	= BIT(29),		/* MADV_HUGEPAGE marked this vma */
> +	VM_NOHUGEPAGE	= BIT(30),		/* MADV_NOHUGEPAGE marked this vma */
> +	VM_MERGEABLE	= BIT(31),		/* KSM may merge identical pages */
>  
>  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
>  #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
> @@ -333,14 +335,66 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
>  #define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */

Is there really any value in having these defines, at this point?

See below...

> -#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
> -#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
> -#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
> -#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
> -#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> -#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
> -#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
> +	VM_HIGH_ARCH_0	= BIT(VM_HIGH_ARCH_BIT_0),

Or just omit those bit 0 to bit 7 defines, and write:

	VM_HIGH_ARCH_0	= BIT(32),
	...etc

> +	VM_HIGH_ARCH_1	= BIT(VM_HIGH_ARCH_BIT_1),
> +	VM_HIGH_ARCH_2	= BIT(VM_HIGH_ARCH_BIT_2),
> +	VM_HIGH_ARCH_3	= BIT(VM_HIGH_ARCH_BIT_3),
> +	VM_HIGH_ARCH_4	= BIT(VM_HIGH_ARCH_BIT_4),
> +	VM_HIGH_ARCH_5	= BIT(VM_HIGH_ARCH_BIT_5),
> +	VM_HIGH_ARCH_6	= BIT(VM_HIGH_ARCH_BIT_6),


>  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
> +};
> +
> +TRACE_DEFINE_ENUM(VM_NONE);
> +TRACE_DEFINE_ENUM(VM_READ);
> +TRACE_DEFINE_ENUM(VM_WRITE);
> +TRACE_DEFINE_ENUM(VM_EXEC);
> +TRACE_DEFINE_ENUM(VM_SHARED);
> +TRACE_DEFINE_ENUM(VM_MAYREAD);
> +TRACE_DEFINE_ENUM(VM_MAYWRITE);
> +TRACE_DEFINE_ENUM(VM_MAYEXEC);
> +TRACE_DEFINE_ENUM(VM_MAYSHARE);
> +TRACE_DEFINE_ENUM(VM_GROWSDOWN);
> +TRACE_DEFINE_ENUM(VM_UFFD_MISSING);
> +
> +#ifndef CONFIG_MMU
> +TRACE_DEFINE_ENUM(VM_MAYOVERLAY);

The ifdef handling here for these two items, VM_UFFD_MISSING
and VM_MAYOVERLAY, does not seem to match the way they are handled
above in the enum.

> +#endif /* CONFIG_MMU */
> +
> +TRACE_DEFINE_ENUM(VM_PFNMAP);
> +TRACE_DEFINE_ENUM(VM_UFFD_WP);
> +TRACE_DEFINE_ENUM(VM_LOCKED);
> +TRACE_DEFINE_ENUM(VM_IO);
> +TRACE_DEFINE_ENUM(VM_SEQ_READ);
> +TRACE_DEFINE_ENUM(VM_RAND_READ);
> +TRACE_DEFINE_ENUM(VM_DONTCOPY);
> +TRACE_DEFINE_ENUM(VM_DONTEXPAND);
> +TRACE_DEFINE_ENUM(VM_LOCKONFAULT);
> +TRACE_DEFINE_ENUM(VM_ACCOUNT);
> +TRACE_DEFINE_ENUM(VM_NORESERVE);
> +TRACE_DEFINE_ENUM(VM_HUGETLB);
> +TRACE_DEFINE_ENUM(VM_SYNC);
> +TRACE_DEFINE_ENUM(VM_ARCH_1);
> +TRACE_DEFINE_ENUM(VM_WIPEONFORK);
> +TRACE_DEFINE_ENUM(VM_DONTDUMP);
> +
> +TRACE_DEFINE_ENUM(VM_SOFTDIRTY);
> +
> +TRACE_DEFINE_ENUM(VM_MIXEDMAP);
> +TRACE_DEFINE_ENUM(VM_HUGEPAGE);
> +TRACE_DEFINE_ENUM(VM_NOHUGEPAGE);
> +TRACE_DEFINE_ENUM(VM_MERGEABLE);
> +
> +#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> +TRACE_DEFINE_ENUM(VM_HIGH_ARCH_0);
> +TRACE_DEFINE_ENUM(VM_HIGH_ARCH_1);
> +TRACE_DEFINE_ENUM(VM_HIGH_ARCH_2);
> +TRACE_DEFINE_ENUM(VM_HIGH_ARCH_3);
> +TRACE_DEFINE_ENUM(VM_HIGH_ARCH_4);
> +TRACE_DEFINE_ENUM(VM_HIGH_ARCH_5);
> +TRACE_DEFINE_ENUM(VM_HIGH_ARCH_6);
> +#endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
> +
>  
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  # define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 2e43c66635a2..04b75d4d01c3 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -108,7 +108,6 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
>  
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
> -const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
>  
>  #if IS_ENABLED(CONFIG_ANDROID_BINDER_IPC_RUST)
>  #include "../../drivers/android/binder/rust_binder.h"

thanks,
-- 
John Hubbard



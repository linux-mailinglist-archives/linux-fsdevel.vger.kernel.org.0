Return-Path: <linux-fsdevel+bounces-48300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D862AACF7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 23:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00514A6AB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1C9218AC1;
	Tue,  6 May 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYb6t9KG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4774B1E4B;
	Tue,  6 May 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567291; cv=fail; b=YfP7konMRIsdiO3OzkHVlW7K0kfcfbKu3jBtVf3Koq30lj40Q3qFFIwjLgxbYPo5tGZtaANk6QK6jq4PDqvd7qz+1Xv4NqytWOCQYmMsIotT/9qP02FRTgaTVvMMzsfL8oGK+ISvldPPa3JEQFOYeGxnlOyocwiPqN88jn8X/Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567291; c=relaxed/simple;
	bh=FTqZaS4Nx21aootXfx/Si493U6kH3P1+S8KVSaMuaM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dU8rIdaC5XVtME2/f5ciXLiGvWrm6rQKeVS1L1+pu/3U6pO3V9kCdReiw3sT8yXQvGb8o2DghfZd5zSXO8mTGLoYC5bFyAWxkieMUdnzr7xsf9olsTa89S45HwZMQDpzWyIGHh1oK4Y8A5beelDcUIIReYNnt2Kkr5os7RcaLZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYb6t9KG; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsrI5iZMaKw00UbA26oAwazrZDAp9t0G8idk16qygGhjFDT4ewKr1ZsYtbYwiWJtCL/HvEiRrhPCxSIjpL1jiJrMK0SDPgQHX+wHxBbkU4OLS+piMzSdCiLP/LUoFVP1pGpgWkJQ4YelzHNcIgnQsNGJsyFkI87gbarUSr+1dnxjEIm3vuKCTO7UHUSSOA6/buLBntsaulLv+mxnfijhUeb6m4enLcNfvP4FvjEWMsR8jsMNQewVe8RWM2fc+7mm3ClrrfHDSiTiwcWI1fmZIqs2X1LtHv7xdwtQwSemQtrHAFAFVFJoO+4RHMM1CLn6jkPdH7t/u9qSLht+ncJjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu8swYFeuNnaRfL1EjOa6v3/yJlOZctfSsSsOwyZejQ=;
 b=lE8wN9purVtjOcAkx7Cp9Q7FjKqxGL3ATiTlo6pe6z+dNN2wj47EKjw7MhoSM8/rzoW7Xy84FOGJ+mNFVbYXtbyn/G92gyl+4jOt0dflP3JuWNhnzkEqembLu3qzW+z7lQMbWSYJfcbQ4izYcBmuhNLQeFDp/mwclPq1TWuFfs4uBgp1sS1HCWlyYIdBH46O3V1JB03V8xi48KTwzUqAI8CKiWiyKUsVK9J2SZ56365vDQH/QRhNXlJ7w9aMBKRGWxgo4YzvxJYhzbyXWevv80QzVN+Di0TyiUUrwGB/Za8e429PKxVEbDHeyU0qdTBx6b171JKcoojZdJ8uh0mPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu8swYFeuNnaRfL1EjOa6v3/yJlOZctfSsSsOwyZejQ=;
 b=AYb6t9KGuvI0PBrucnaxjqKwqdugLONLZd3Lxr27JefnAjH+VMyrv9SeREzOqeJ+5qDAH9ekxjkD43F/p3e5fVwwbAP8X+p9ZVr91r+9ZoTIlMqPAPzLvEzDajS7XZTYrUXwgg6eqngIHOFWKKKKGSebKQeKA5cNgB3PtAKo6OI0DQWJ0eUjX1Uc97KeSzETQjOGJJcusBTF1sHMRD9NXFfVIAbKXh8j6RLI+KqIieRE4wNDVW1kkHjPsxb1gPp+HH37h0p7+ujxqWlnwPMnI2FN7xfvKt+TGQEo5xeK9x7uJqoBHH5mcCfJkkX0hN8T8SOGfHc7JpQmxnIFRaX0tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.48; Tue, 6 May
 2025 21:34:40 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 21:34:40 +0000
Message-ID: <8f765dc8-421f-420f-bd3e-1a0d889238a1@nvidia.com>
Date: Tue, 6 May 2025 14:34:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Shuah Khan <skhan@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, seanjc@google.com
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <5b0b8e1e-6f50-4e18-bf46-39b00376c26e@nvidia.com>
 <20250501114235.GP4198@noisy.programming.kicks-ass.net>
 <17464a97-e7be-49d4-9422-96ff824dba7c@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <17464a97-e7be-49d4-9422-96ff824dba7c@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::34) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: fdac29b5-975a-40df-5555-08dd8ce5ced5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekxEeXZlR1FEUWJ3bjBqZXpUb2J0dERqN0FMcWVZTnVpeS9GUHhybEdGNzE3?=
 =?utf-8?B?cmprNUY0K21ERFpnTnZDU2F1dmc4Znp1cHNZWTkwTFRpbDVyMm85bkJUVDZq?=
 =?utf-8?B?ZExtbEtBQS9TcEgrWmU2dXpFZzFHYUU0bkpNeTlpekQwTUR2VWRYUW54VUFq?=
 =?utf-8?B?Mjd0L1JPNmFMam92WVdOWmFpL3ZvKzNZUW9Gak42bWJpdDh6NFFmcDU4Q2cy?=
 =?utf-8?B?S3BiaHhiaDF2VVBUVTh3V3QzMzVTRXE0em1Mb05XeTNuNXBSL25ON2lrU3FG?=
 =?utf-8?B?czhTTHAvSGFmYW9lSjF2R0oyTjdpajh4cHlNR1FWSlh6ZUJNME5TN3RCejc1?=
 =?utf-8?B?NU5HTi9WZkxXRWp1QVVsWlJJak1HTFJPaGJJaDBXTzRWUlhlRFlFZU50aVZN?=
 =?utf-8?B?OUpIUkJCQXR4Q3ZsYTRLcElNZ2FRZ2UySkFQS1A2b05YUWlXaGY3SnI0N1cz?=
 =?utf-8?B?TEsrZEl1cGw1QXRhZWNqdlJ0REl1NDE3aVlGdUxyWDNZMWxrc0JhTkpWV29F?=
 =?utf-8?B?MVpCWWt1Z2NuZHRkc2lFMG83TitqVHhaT0M0R3RyYWFqQU9HWW1od2VPQVFS?=
 =?utf-8?B?OUtoTlhoYWRqUTNkd3NUN0JNaXlGb1NiaVhjM2lUYkxYUHhGWTFFa0c4eWlD?=
 =?utf-8?B?Y3JiYkQ4bUZzM1JVZ0VtZzBEazNCSXRsVWFQdUlGZVNsOWtWUG9iV0pJOEIy?=
 =?utf-8?B?ckluWGJHNm83akdrSEZSMEVzbi9zdmJaclY0MXdCOVhjQ0xJTTZ0ckRtZHk3?=
 =?utf-8?B?bzNyallQYzN0SW02UEJCT0ZSOUhxb0lOay9PbmhGVVROMUF2QjdGWEJ3dUY0?=
 =?utf-8?B?Zk1qY3NaNFJqNXV4anI5d2I1ek5WUDZ4YmsxZDJibWY1ZzJZNEFFMURQNGRR?=
 =?utf-8?B?M0JaVGxXN0lyZTNTSGFUTWNRSXNLMWw4UGFlZERJY096ekc2OVhMcTk1anRE?=
 =?utf-8?B?NklpbWtTM1NsZzcxRHV2VEdaNmMwSGsrR2crOVE2RzNjTDVZM3J0aTVKZ2dM?=
 =?utf-8?B?TWNDdWx4anRGcUdhTnpjdGpWTWUwd3dyajBsNGVrUXRzQUQ5SisyU2xiOWlm?=
 =?utf-8?B?THFjYVNERzl1L3EwRUdJdjhjaTdOZEJBdUhTd0k2MHFjSjIzajdud05IQVZM?=
 =?utf-8?B?UU1WL0tCRXZ4VWlSMWMyTnJueUwxNmNqTFpSVGNXUy9OeWJtOTRUS2duR0ZH?=
 =?utf-8?B?SHp0U0hQM2lya3RnV2l5L2F1bXo3WEhteFZxZWkyNVAycnpFRHdFU2VjKy9N?=
 =?utf-8?B?dHFmYk1ibDhYaENxWnp4UlFoMnBsVDZjSG8vMW81Zld3dGpRc1cyeHpYeGhI?=
 =?utf-8?B?enh1cnJIQ0VONnVHbVVjcDlua0xBOXNVOVJhV2UybW9ZbXM2aGtOWTBXVXVm?=
 =?utf-8?B?aXVRZkRPVlloY05VYmQxOXdrVW54Z0tid1VGS1NQSGcwWkdLQUg0c3padENy?=
 =?utf-8?B?alNrcGgvN3BYWUlwSEk5TUVnd0VBV2p3Qk1nNURUVE9wV3JDYkEyUlZERVBu?=
 =?utf-8?B?UFQ3TEVZbFNCQWRpbm13dnNlZUdWUUNIVHg3bVJoell0T0NCZ2x0WDhuSGNx?=
 =?utf-8?B?bGtlK0RCVUxnQUV4WU00MmVuWVpkTEFlY3NQdlNGdHZsM0pCK2U2VnVKSUJa?=
 =?utf-8?B?bjZqaVdLcWo1VklQZGhtNzg4ZkdyLzhDZk94RWxLV2NtVjFrODFucDlSUVNR?=
 =?utf-8?B?ekpiOW8xR3l0bTJoZWZDeEhuUE5FV1E1ZGF4cHdBMWZmWUNwTEFsZTFPRWMz?=
 =?utf-8?B?ZHRXc25LUE92elAra2VFNEtmbEowVFNyYjVLbVhzYk4zbUNiYTlXaWpuY2pV?=
 =?utf-8?B?bWtYTzhkWTBDZWRTbldvN1NEQ2J0M1hxZGxYdDZhNno0N01HZXl0TjVxRlRC?=
 =?utf-8?B?WDNIS0Q5ZGd0VS90ZXpFcUoxbGR2akwxNlN0VUNQYjFxZEcwMVBEeUR4RkxQ?=
 =?utf-8?Q?QW3vGyZUKRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHU0bWJsRG1wQVJGaTF4S2RiUEVrL1NVWXpvNFJ5enZUL2haSGFFMXk2aTRV?=
 =?utf-8?B?blFRdWZRZGJNZ1drYmREQ3luNEhkMGlQTmlFOHE3YzNEbE1oQnhrNUJybU5Z?=
 =?utf-8?B?UEkyKzBpNGZleVlmVzUzQi83Y09XUUhpWS9BUWtPeU1NeC9mVFNSVzRUYXA4?=
 =?utf-8?B?QjNHWHU3UHFlcHhFNDNBNFkzMXNtRVh6eVRiM2pOY3BBNW1yWFNNV2kzUkFB?=
 =?utf-8?B?MzQvZ1VFdGIxREl4SDdJTmM3ZTV4UnhvRVZLa3lFL3JSL3dEUDQ4VDNzVDFv?=
 =?utf-8?B?Zk10RURITVVTLzRiOXRIL1ZVMXZZaUxJTU9ieTR5ZzdybnJOMFZvUHVhM2JL?=
 =?utf-8?B?TDNSWWtEd3JIVTIvOWMzbk1XbGRLaDYzZ3BRd2Fyd0ljK2tHemN4eUVzdmdn?=
 =?utf-8?B?V05XemxDUmwvdUxiUDU3V0pFZXR1THVUNklNajZ0cGFNZXB1MUdlVDA2b05Z?=
 =?utf-8?B?R0g2U00rNm4rTjFpYTdxVk9FMUVRdG1VV2dHbGF6MUVCWU1KRDVsMklmbmFE?=
 =?utf-8?B?OW9qNGl3Z1QxZHlaZFFtU0JlRjYxMEpab1ZQRkFwcGwxS1dXR3VwSEJZdkVq?=
 =?utf-8?B?aSsvcitqbWtHaTBXK01udFYvaTgxbFVEa3lNbEx1THJFM3ozTnJLeWVvMkJZ?=
 =?utf-8?B?a2FqUVVaeFZOazgyWHJleU9qNEowWSsrRitrckd6bXZ1WmhleHJ2V2NJSWpp?=
 =?utf-8?B?YlZWMzBJN2RnVDYrUHBmekd1M1BTWERRd1N4aXpYcTh4TXA5Y3VjZHdoTGFt?=
 =?utf-8?B?SHhvQnFyN3lqVjdjRUx5cE5LekRrV3dBK1VmRHFlYW9qY0RNUE9WbTRrcWg1?=
 =?utf-8?B?NlRpRFNhQU1uNWVPN3Z2YlJlSWZBQ0ZnVzBFd29ETG82amJYSGJOWkYxOExT?=
 =?utf-8?B?RTdNZXVpck5wT3VTNkZ2ZWNDRlBlbVB3dnlNM0pzNk9TRkNRUDNIZXRNcCtG?=
 =?utf-8?B?VTdqN0MyVC96ekNiWmtaUGpaV290MnpFRGV0cDk3Um1XbVJ0ek1DdzRmZkk5?=
 =?utf-8?B?TDV0UzY4WHNTTjVNTkpWK0dTeS9KRE9EeXRwNlNyeUIvU1FzYzBpQWN3ZC9F?=
 =?utf-8?B?dnJtMyt4WUhiUWxPVVZLa1BnQytFdm1OTWZwM3hLQjFQNlhGajAxVEJJVjUy?=
 =?utf-8?B?ZFI0cG5ZSDk0VnpDa0g2c3JjbmdpZUN4cDA2SDQvYjAzWEVhUTJ0YTM3ZXZN?=
 =?utf-8?B?UGZ2MEpwMXViaXI3cHM0VkltZ1Znd1VNWnREK09Pd2xrYTdzanNFRThOZlll?=
 =?utf-8?B?MklKR2wzKzh6MWpWRVdWbnlUUUFTRkdXVXNVSU9oZVpsMldic2pNbDNrUlRj?=
 =?utf-8?B?Um5XSlM5bThOMDNHRlI1Mmt0ZkRoREFaUmZ2S2ozMVc0TTUrRmEwS3RxdkFu?=
 =?utf-8?B?Q2RYMEJhNHFxT3l6eENRU1RnRzBib3Q0V0EwVTVuVW1YR2NvMDgrZnAwUXBB?=
 =?utf-8?B?d3BHbUEzYStWQXpnckNETTVzbjhzdUpLNG1Xb3NBWUgybUlKamMwSkRTdFJN?=
 =?utf-8?B?TDlHb1RzaEUxb1hyclhVazIrdVV1NFlFajY0czVKU0xwL3RMLzlKYlJCbjVx?=
 =?utf-8?B?aDlBbzFtQ0lscnF4dW8yT3FVbEUvQmpNS0ptNjEwWTBFOUorU1RRTFVYbmVN?=
 =?utf-8?B?MkgxZS9ra05oQkRqTFZJeHJvQmpRQnJkMDZvOEZ0ZEpRcHFGMTQ0SUl1UmlG?=
 =?utf-8?B?NjNqWGhUWmN3VHJSNDk3TXdOL05Mcjg1UjV0RnB6TDBna0dxNnBwblErc0lU?=
 =?utf-8?B?Z1dXRkNBN0pRT0p5OXd0ZDN3U0poVWV5MEZUcnBEZEJzcUpRbVN0dVZYVHZR?=
 =?utf-8?B?UlJDeFJSdzZuOHhPWCswZzNuVGVhWFBvVWJaU2RYNmkwQ29aOTZRWEIxN0U2?=
 =?utf-8?B?NnNXVGtsVzBGQmVRYTh4VkFIaTZWTDZoaXpiWmNRY0swVFN4d2tsd05DMDRR?=
 =?utf-8?B?b1RseEFmRXFvcm9TcllKd1hWUXBnNWJUOHVvc0JTeDkvSGZSWnFsZ3liUTZ1?=
 =?utf-8?B?bXpFYkhlWDU3WEJITHNoYnV5Ujl4Y3JhZVg2a2hJdG8xQmx4MlJHUTd4WXU1?=
 =?utf-8?B?bHBpOHg5WFNUOWlqRk1wRXhiUFpUNXNWU0RIUWw2MXg4VjFDUjB5VVBTZDRk?=
 =?utf-8?Q?1zvOoGPVfl2Eyaq0GNl1G7wa/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdac29b5-975a-40df-5555-08dd8ce5ced5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:34:40.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KakflZ2avcSEjumc9k3ab/JeZMOrHrEwGHqYoRi59aQF8hmhEA10gmFJEeyBTmZd4v9R6EycJonLuCPo7oZfJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580

On 5/6/25 2:18 PM, Shuah Khan wrote:
> On 5/1/25 05:42, Peter Zijlstra wrote:
>> On Wed, Oct 16, 2024 at 07:14:34PM -0700, John Hubbard wrote:
>>> On 10/16/24 3:06 PM, Lorenzo Stoakes wrote:
>>>> On Wed, Oct 16, 2024 at 02:00:27PM -0600, Shuah Khan wrote:
>>>>> On 10/16/24 04:20, Lorenzo Stoakes wrote:
>>> ...
>> Please fix this fucking selftests shit to just build. This is unusable
>> garbage.
> 
> I don't recall all the reasons why kselftests needed "make headers"
> One reason I could think of was that when a new test depends on a
> header change, the test won't build unless headers are installed.

...or until an updated copy of that updated header file is copied
somewhere, and then included in the kselftests. That's the approach
that I ultimately settled upon, after some discussion and negotion.

Details below.

> 
> If this requirement is causing problems for tests that don't fall
> into the category and we probably have more of them mow, we can
> clean that up.
> 
> John, you mentioned you got mm tests working without headers?
> Can you share the commit here.
> 

Yes. This one sets up the general approach, which is available to
all kselftests: TOOLS_INCLUDES. It also changes selftests/mm to
set TOOLS_INCLUDES in that build:

    e076eaca5906 ("selftests: break the dependency upon local header files")

And here is a representative application of the above, to selftests/mm. In
other words, taking advantage of the new file location pointed to by
TOOLS_INCLUDES:

    580ea358af0a ("selftests/mm: fix additional build errors for selftests")


thanks,
-- 
John Hubbard



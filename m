Return-Path: <linux-fsdevel+bounces-42113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606ACA3C7B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 19:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A6217B9CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D644921518E;
	Wed, 19 Feb 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XfF+1Txt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2123.outbound.protection.outlook.com [40.107.236.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85421481B;
	Wed, 19 Feb 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989878; cv=fail; b=aCO484qxBX+sNz7/w2HqoOnuS+gf/LZVOo0IKFcFjYE4CUvNVqVnTUGS1T7s+2bohWFZDBCvmBI1A0pEjEdDTn7FY7LfvCZDIe4VTHaqOmQHzYCpfyJZIedsSWbfQcjPBVYXuF5TQnQKttNVjwQjW1tbAzzYwN4Xj1Y510Zm1Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989878; c=relaxed/simple;
	bh=w1JoQAFdV2DfEJexxoGkgPzZjSvrkiD35j5dxII+IF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDlzHxdQKlQPdvQFqr3FB7Q6mb6JEmBRHAYKVQYI8lTlN0FMsNoMkHRbK+BjN96U90oChQN8q4QOle8LejTNpZ5f7PxTTcAyGLZIsWoBxwEMThr+N5b1LcSHaDeS5T80qCKAACZIrQs5XpMXFHyHWfyxsszW84cHyablIa9HuXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XfF+1Txt; arc=fail smtp.client-ip=40.107.236.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifr5x2tMGMA7xlTq8e/hHg+S8YTLVslBFBhyQn3PvN76ZeKIi4aSZsakonwS9pjFmwTQYkxCLJOKAQgAVAiCYoPKLPZamZ+wthqdg7vVqhl2LdbF1Ij1SP8EzUWPTBlgRX+ZUDqmxBTHDnmxOVNgqjGHbH0OXgPU60yU0VGcYFMVNj2hnyULWdE3vk1JVc3o2aSOohgHlyJs9PD6i9S5ya+5URjd6Su2tuqm9l7jEYLW4RtvH7QV13gnH9NqbG3JU+y2PiAZIbFMLvc0zVRRnTooN3NEXJqrI5MJYZ4cz1l8GJAVWjOXCSRkkgWodSLNoFtu/hM0Hjln72lgr/RCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQp1CRH2+SddS0VKwcPjjD1mGEO4fMPBYESq6vZ+RVQ=;
 b=Yf/PitLJHwBdySK35L2af6Y3MuNAp1YrYJ12ZIS5Mz2dEw703VcjHwDjeT6QxbCDbMcppii6Qv+oskiBX4PT4DEqoctnYuVHYJbNAb1ZtPpxrhXEaEE9t0VEvAfWWVa/9HMnTpzodC9Vo2JRaRj9Pni2/hBTUCj15Pg5RaTdtsmoem0FHQVBvfGx3buUa9Oz/wrDMzxBvNXWIsHA6ezwihaHRwTBCKIbD3Bp69gftCeZeK/6WsaarpozegYAVFi9W7jcUc6nJ/Zruj95kk+Wklj6zLKAQkCD/wzcyBvLOqpOLapSO72nVJoNAnKIPuHC/v1Uu3jf+zbU0g9zel9KMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQp1CRH2+SddS0VKwcPjjD1mGEO4fMPBYESq6vZ+RVQ=;
 b=XfF+1TxtgOzSq9jvMcpAVH4aL0z2/1g/3VUgErXkOIVcD4JuLGc2CiTADMou4Bkxxz924hUgcj0nBaBKVJgy2MMucz13uOI+T8F1ratNwkGVW4rniYyx0BA9aET/GpddrJNtfo+Cae6TihYWEL5FB/ZN2nX5Hg7uyV88XngRksY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MN0PR01MB7850.prod.exchangelabs.com (2603:10b6:208:37e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.12; Wed, 19 Feb 2025 18:31:13 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 18:31:13 +0000
Message-ID: <c681c266-6385-44dc-b6dc-a61b5425db23@os.amperecomputing.com>
Date: Wed, 19 Feb 2025 10:31:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
To: Catalin Marinas <catalin.marinas@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
 Pankaj Raghav <p.raghav@samsung.com>, David Hildenbrand <david@redhat.com>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <Z7Xj-zIe-Sa1syG7@arm.com> <Z7YSYArXkRFEy6FO@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Z7YSYArXkRFEy6FO@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::22) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MN0PR01MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: b246058f-ee79-40da-817c-08dd5113969f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGhVdVpxS1FyNzY5ZkhnTjFFaDFlRmJNWmtXQlRGVDlNYTRwbzE0NWx1VG9n?=
 =?utf-8?B?QXByb0VnRmpESm0yRVJBSmNrL01uMjA1TXdDTXpZOFE4R0REVzBNanVYSEI1?=
 =?utf-8?B?ME9HNG5Gbng4NnZVWkRMTk4vK1pvQ20rNjRqOUsvbmIrYkJNdlI4ZUF6RnJF?=
 =?utf-8?B?WVVhWHRVZTRWSVN0RnprN3JYNG1udEttRjVTUjhxYnRLVjFRYmd5OE1kM2Fi?=
 =?utf-8?B?U2lQNEwwQ1N4TTBmVDM2eStKV0s5SVMvSFI4b01mTzdNNWVPWFFPcTljd01V?=
 =?utf-8?B?cVE1RjZkUTlxdEU5emlnNEJ6TkI0L3FibHRSZ1ZkYXdmSmVJZkxCSGV6WmFW?=
 =?utf-8?B?V3B1c3N3VDd2Um40ZFBQWjZCT09pcUNDdHd0MmQwbFM1K1hjbVFMRE00VnJZ?=
 =?utf-8?B?VG0rNTZpV1hYZjRueEtObENiVWxOcU84bTFqOWFOMmpxT2UvMVBWdEZVQUJZ?=
 =?utf-8?B?RVA2cjA4MVZQMVpJdXV6U0RtdlZzYVlQdEpjT3ROUjRZS3ZBOWFISHp5RVB4?=
 =?utf-8?B?R2RJUjhlaWJqMm1QSWVBR2VMSURZQllIc2c0andYNk4rc1FDTzg0dzRoSEVH?=
 =?utf-8?B?K3RXRUo5czdBMDQ3UkVxNmRsL0xYK2pmMk15Vms5TFVNbzNXdWErZHFsdlVq?=
 =?utf-8?B?bFllOGFLNHJLUlB0WGFjZnJsZmtML2huMElUUnBETkFvcmptTmwrbWp0RzZu?=
 =?utf-8?B?UHhsR3AwaksxRjcrZTZtczdOMGwybFVyYVZaNkVtSFR1Sk40MUdoVFIxNlZz?=
 =?utf-8?B?UEtaUWtiazAxL0l0YldBRUtVWmRPV3p2ZlVlZEpndFdaR05rTDQ3N2VkU2pa?=
 =?utf-8?B?ZjhVU1BGaVF1ZkU5ei9VZWg4WHY5YThPWWh6Z3dlZjJkNEVaemp1cXBhYkJy?=
 =?utf-8?B?TU12K09HenRKcDVyWnNoY1FCaUNBSHhIeDFYUis4bTlvVWMzL0d6UWt3aTZ1?=
 =?utf-8?B?cGs4MGdwNVNHelM4ZmIvbXNsc0pEc2U4ZW13eEIwcVNxYVBNWDNTVC9tclpQ?=
 =?utf-8?B?UnVsUmlQM0w0VlgyYXNKVUQxdlBXdkVsZ2NtMk1lS3c5TWdSNWNURk5abWJT?=
 =?utf-8?B?RTZVSENGN0RPcU1iTjJIOGtkRXhJSlRQaVZrWGs4RWoxWUVrN251anU2bktI?=
 =?utf-8?B?dElUcmVhRFNleldlczNqS3UrVkVFTGNaYm5jSXluMHlHTjZ2d01uR1dDdkVz?=
 =?utf-8?B?QjRvK2pBWE9JN1Z4NTdIck9DVFJDOHZDcDNrSi9nYlY2cGZJRjU5eitkaUtq?=
 =?utf-8?B?K0xvVm5zakt2STdhaWRjSFVIM0VDeGkzdzZCaTNGOHJSU21HbjA0Ri9IK2w3?=
 =?utf-8?B?SDRaUnpuZitScC95M0tqUExNU0FGeU9zbElpditYaisxOEVDcWRoUnJ1SzNO?=
 =?utf-8?B?V0JUN2txOWJ4TytnRUZMZWY2d1ljN25lcnlmRGNQVjVrTHhjM3FiM25icEJ3?=
 =?utf-8?B?amc2cWU5NUJiWG1HYnNNS1Zid0xvcXNTVWs1Z1k1UDRnd2Rmak5MRER1Vlcz?=
 =?utf-8?B?MEJoM3RJVHdhNmxmOVpLUjhlRkIzbW5JVWNTam03WHBtcForejF1QjVKZWJ2?=
 =?utf-8?B?SXpsUndjZkQrY3haWk1vNHlvUU1oS2E1eUQwL2Z5ZjhMZVZwYm5OYktjaTcy?=
 =?utf-8?B?T2lGTm5mT3YvQjZZYVZodXZNNFc5TnlZeERKTk90OGVwaEFGZlJWaGRDY29p?=
 =?utf-8?B?ZC9aaEswVTRVRk4xNE9reVkrRnQzOTJYNUJDVlNxSHJzREpSazdEU1l6clQz?=
 =?utf-8?B?dUZNRDVvcjN3NjRtaGpiQ3JwV0MxRVM3dmdQa0xxcUdFNzE4SkYxRDlWdmYw?=
 =?utf-8?B?eEw2bFlkb0c1b2Y2LzZ6a1MySmd0ZTErcnJTZEhjZFNTV1B0K01uNG9nNGVX?=
 =?utf-8?Q?eSSZDxluz3pya?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW1TODJtZ2JFOWR1Wm93UEV5WmN5ejYyLzRHeWtZbHU2aDBjY2pnL3VBQ3Z1?=
 =?utf-8?B?UnhjQk56T3M4djEyOFVKUDd1Q1c3Ritnb082a1BWbXNnSzd1cUJOYlBxSmtl?=
 =?utf-8?B?dlB2bkd5S0U0TVl1aUovV0xDTlRPTUxoNUYxY3RZM05JOHNiUEQzdVQwZklK?=
 =?utf-8?B?alNGdFB5Y1pwTTRHNjk3WWZwTVY5ejY5cTlWQmpkVWJpWGFzcU4yUGtlcjdH?=
 =?utf-8?B?NzA4eFl3K20yVzlXVHJuViswdE9uOFVqZUl5QkhHeEhmcHBkbW5nMUZrM3Vz?=
 =?utf-8?B?RHgwWEdmNldPbm9OMGJWcHNManU2a0cyRmVqWXZ6c01kd2ljTmhWTnZ3N0F2?=
 =?utf-8?B?ZlZNTnRjZE9Xby96T3lkemlHanFwckUrTHU4M256NDVkQ2orZHppU1lVcCt6?=
 =?utf-8?B?U21pTjRUeU85bTRzbVlIcE9OazBRQXVyZDIwd29lcDB1VHd0UWZnd3k1UGdB?=
 =?utf-8?B?RDZyWTNHSlpPZUhGWmFIcWlHOUFaMDdTVGtMekpQUlpPZEwxc1c0aHVYRUZZ?=
 =?utf-8?B?aXhpUTI3b2kzTngvRGRkMVR0NnhYUzgwNG45K0lXVUZBaVBHRDNRWnpZNE9S?=
 =?utf-8?B?R0ZJdmtDUlRvU2tCcmVPbk9GbTlIVlpVa24vZC8xcVpRVHppbVRpaTBPRzNp?=
 =?utf-8?B?eW16ckxrS25tOUl1M1BtdFpubmNLVmhSekZxYy9pSkdGN2piZnVCcDhNMC9I?=
 =?utf-8?B?dGQ2WHhwVHJIK0piMy9LQTR3empYRE5ZU09MOXppc0MvM0hodEtHbXFPdHJJ?=
 =?utf-8?B?U09XSkFGNXVaNTdCSnZodXZya2tGMmVMbGx2ZWE3QkFxVDQ4WmxIOU1EVExN?=
 =?utf-8?B?WGhndnA0V3BTOW5Rb2ZCNW1sSkxwcnRIZkhOc2N1THRJcE1VQTNGaTFXZkVT?=
 =?utf-8?B?S0tNdVFyd1RnVy9zSnhEVmtRN0F2Tjg3RHAxOFFkTHRXMXlRZVhTczdIRi9H?=
 =?utf-8?B?VDlJSTFDMGdET1VaTzFhTlZnMlZSUUJWbXNZaG0xTk5CNTg5NGZ0SDlFYjl4?=
 =?utf-8?B?NnI1QzFSUERDYS95S0FYaXl2bUd4b0NjVGMzL2FtS0ZOTXpWNUpCanBxSGl0?=
 =?utf-8?B?TGljTk9CQ1F1TW9IcU5FWVcxb0hBWjZCeSswdXpBKzB2ODZkMHZ3Vlk0a3d4?=
 =?utf-8?B?eUN2aUJsKzZDMzhLR01nNnBWL2h5QmlKZXBlUlpXRU4zVjVNQlA0N2VRdURE?=
 =?utf-8?B?U1BEUTg0RUJWWXZXaUpkQzFLVFJ2czJYUFdFdGNnS0QyTEV6T1VldlBlQlNi?=
 =?utf-8?B?MHhMMlh2ZDVFczdPRmZ4R3J3cHo2MzBmNGJUaVh5Y2gyUzZteFo3MkY5YkU4?=
 =?utf-8?B?NTJIMEJGZVlGZ2xqaTV4RWxMVWk4MGFsaVplRG1ucXZ1RmpZWFZOclAyZVR2?=
 =?utf-8?B?T2oyZFdaUklyRHJjajBoZTE5bmR3TUExTjdBUlhyc1A4VkI1bTNTSXZIbXh6?=
 =?utf-8?B?ZHdnWFlqWjFRVTdBckVzTG5hb1BXbmtEbmZiRnJrZlFpNXoyZVN5THhJR1Ro?=
 =?utf-8?B?MFhMalgxYnN6RkhFS0xjS0pkdGpEUFRCZmp6NGU0RkwzTnZNN2tLZ0lhNXVr?=
 =?utf-8?B?OWxqdERVTnNtVzlSeUhVd1hjNHkvSWtIcGJiQmxTYzAwRGZPZHF6dDdTeE00?=
 =?utf-8?B?dEdQUWFUaVFhY3dDQWdja29jb3dIbWJLa2gvQ3JKZ1JyMnZSenR6OTZPTllp?=
 =?utf-8?B?VFNjTjRNNi9HRWdGR2xZLzRlZFh0SFFSMWxON3hGUWYzQXpycHZjZjFpY2tN?=
 =?utf-8?B?dy9YamlRdlRGWk1ibHNLb21XbVUrQno2cERnY2hVTC9jNFQzNENYRDhLQUV2?=
 =?utf-8?B?bGd2eDhva0JGdFp4RHdwVmY1bGhXSHMyQnU3a3F0ZXlFTzNiK3FUWG9taXgz?=
 =?utf-8?B?V29GaG1MR3J3RlFWdTA3M24vQ3QvL3BqaXBoT3UybGNtNTBYTXZZUVpnbHVN?=
 =?utf-8?B?SCtHZy9BSzdSTjVVK21VRW9IQjluOW93VGhTSXFQR0VET0wrZ2l0bCtXOGc0?=
 =?utf-8?B?anFiTGJYMlIzVFY1d21QQVdlZzF2NzdBM25XaDh0cVhBdG1QOHgrQ2ttblpu?=
 =?utf-8?B?U28rVmY1eFNxWXFwTUFaektRcXZ1NGMyZ25UYmIxRk9FZTBsMFFXY1BKYjly?=
 =?utf-8?B?NW9aZDFZUjBtQlJqOXBtS2pwNGxmbzBGU3VwajVKYWtYRnE5cldta05WZEdv?=
 =?utf-8?Q?fRvguxD7Mmd/Wm1XPNlZg7k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b246058f-ee79-40da-817c-08dd5113969f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 18:31:13.1297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tja+ZVzUXxzxPV085fM4COJec0C2RsBOGcrMw8CP9aP57UzVFdff+2r6w9AG5VDQVoHf7BeCW+OZlJmQj9ro2N4laFTfjXmsYaQl6bvj8Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7850




On 2/19/25 9:18 AM, Catalin Marinas wrote:
> On Wed, Feb 19, 2025 at 02:00:27PM +0000, Catalin Marinas wrote:
>>> On Sat, 8 Feb 2025 at 16:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>> Regression on qemu-arm64 and FVP noticed this kernel warning running
>>>> selftests: arm64: check_hugetlb_options test case on 6.6.76-rc1 and
>>>> 6.6.76-rc2.
>>>>
>>>> Test regression: WARNING-arch-arm64-mm-copypage-copy_highpage
>>>>
>>>> ------------[ cut here ]------------
>>>> [   96.920028] WARNING: CPU: 1 PID: 3611 at
>>>> arch/arm64/mm/copypage.c:29 copy_highpage
>>>> (arch/arm64/include/asm/mte.h:87)
>>>> [   96.922100] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
>>>> sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
>>>> [   96.925603] CPU: 1 PID: 3611 Comm: check_hugetlb_o Not tainted 6.6.76-rc2 #1
>>>> [   96.926956] Hardware name: linux,dummy-virt (DT)
>>>> [   96.927695] pstate: 43402009 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>>>> [   96.928687] pc : copy_highpage (arch/arm64/include/asm/mte.h:87)
>>>> [   96.929037] lr : copy_highpage
>>>> (arch/arm64/include/asm/alternative-macros.h:232
>>>> arch/arm64/include/asm/cpufeature.h:443
>>>> arch/arm64/include/asm/cpufeature.h:504
>>>> arch/arm64/include/asm/cpufeature.h:814 arch/arm64/mm/copypage.c:27)
>>>> [   96.929399] sp : ffff800088aa3ab0
>>>> [   96.930232] x29: ffff800088aa3ab0 x28: 00000000000001ff x27: 0000000000000000
>>>> [   96.930784] x26: 0000000000000000 x25: 0000ffff9b800000 x24: 0000ffff9b9ff000
>>>> [   96.931402] x23: fffffc0003257fc0 x22: ffff0000c95ff000 x21: ffff0000c93ff000
>>>> [   96.932054] x20: fffffc0003257fc0 x19: fffffc000324ffc0 x18: 0000ffff9b800000
>>>> [   96.933357] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>>> [   96.934091] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>> [   96.935095] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>>>> [   96.935982] x8 : 0bfffc0001800000 x7 : 0000000000000000 x6 : 0000000000000000
>>>> [   96.936536] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>>>> [   96.937089] x2 : 0000000000000000 x1 : ffff0000c9600000 x0 : ffff0000c9400080
>>>> [   96.939431] Call trace:
>>>> [   96.939920] copy_highpage (arch/arm64/include/asm/mte.h:87)
>>>> [   96.940443] copy_user_highpage (arch/arm64/mm/copypage.c:40)
>>>> [   96.940963] copy_user_large_folio (mm/memory.c:5977 mm/memory.c:6109)
>>>> [   96.941535] hugetlb_wp (mm/hugetlb.c:5701)
>>>> [   96.941948] hugetlb_fault (mm/hugetlb.c:6237)
>>>> [   96.942344] handle_mm_fault (mm/memory.c:5330)
>>>> [   96.942794] do_page_fault (arch/arm64/mm/fault.c:513
>>>> arch/arm64/mm/fault.c:626)
>>>> [   96.943341] do_mem_abort (arch/arm64/mm/fault.c:846)
>>>> [   96.943797] el0_da (arch/arm64/kernel/entry-common.c:133
>>>> arch/arm64/kernel/entry-common.c:144
>>>> arch/arm64/kernel/entry-common.c:547)
>>>> [   96.944229] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
>>>> [   96.944765] el0t_64_sync (arch/arm64/kernel/entry.S:599)
>>>> [   96.945383] ---[ end trace 0000000000000000 ]---
>> Prior to commit 25c17c4b55de ("hugetlb: arm64: add mte support"), there
>> was no hugetlb support with MTE, so the above code path should not
>> happen - it seems to get a PROT_MTE hugetlb page which should have been
>> prevented by arch_validate_flags(). Or something else corrupts the page
>> flags and we end up with some random PG_mte_tagged set.
> The problem is in the arm64 arch_calc_vm_flag_bits() as it returns
> VM_MTE_ALLOWED for any MAP_ANONYMOUS ignoring MAP_HUGETLB (it's been
> doing this since day 1 of MTE). The implementation does handle the
> hugetlb file mmap() correctly but not the MAP_ANONYMOUS case.

Yeah, thanks for catching this. mmap'ing to hugetlbfs file should return 
-EINVAL on prior 6.13 kernel. So it should be just anonymous mapping.

Thanks,
Yang


>
> The fix would be something like below:
>
> -----------------8<--------------------------
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index 5966ee4a6154..8ff5d88c9f12 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -28,7 +28,8 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>   	 * backed by tags-capable memory. The vm_flags may be overridden by a
>   	 * filesystem supporting MTE (RAM-based).
>   	 */
> -	if (system_supports_mte() && (flags & MAP_ANONYMOUS))
> +	if (system_supports_mte() &&
> +	    ((flags & MAP_ANONYMOUS) && !(flags & MAP_HUGETLB)))
>   		return VM_MTE_ALLOWED;
>
>   	return 0;
> -------------------8<-----------------------
>
> This fix won't make sense for mainline since it supports MAP_HUGETLB
> already.
>
> Greg, are you ok with a stable-only fix as above or you'd rather see the
> full 25c17c4b55de ("hugetlb: arm64: add mte support") backported?
>
> Thanks.
>



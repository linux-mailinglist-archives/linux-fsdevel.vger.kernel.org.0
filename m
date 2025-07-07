Return-Path: <linux-fsdevel+bounces-54045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12126AFAAD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFEA3B65BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74072638B2;
	Mon,  7 Jul 2025 05:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0kS8j36e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EFD2A1BA;
	Mon,  7 Jul 2025 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751865811; cv=fail; b=uR9knSGBB2iB4gdHnG5tESCZElXwE2++RLm+HWo7FGZGWW4iHHjj995ydZSZsQ/zq3+VwWSpPrxLg61H6jiXuCTP6tB3/F459bK5khk235fo7/igk/tVG00HXFrP1qCxcpqJjRBx8OIQUWjUICaLTGxDx2h+Bre+MVBfvQUtqTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751865811; c=relaxed/simple;
	bh=hGXom290rh+8M3MrO5Z0EDlclEET163u1uvEKJy6xp8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ta+7vNQNu0pDvQPZBGxwlCm+3G797rZyUxWPuNChZmKttzpfpcMdYd33Ig/P1Xz+J2YwdprHwK+rAt6N1UlrYDMrrU7y5s2VAa8K83CnUGal3xXJjvK8YyWEOHMb/f2bd3A7M8CpN2kHo0MQh4r7spA++abTJCZ4Wo4M0XS254s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0kS8j36e; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qspsn82H98x2knTBUUiIPbI1htoU9AHuEaJV26mb0sI99mJtZAKeD2pAvQNcCGF4KjJtJCTHRk90ofRG/Pl/BLh4+DXFJnmO+T+WyjH5HvzeIn6r8sh+bIP7s3OdzoAdxhx5GPorWLgEMWEHUspYwqI1IGXjBJ1n4RuPl4kJAfs1xt9WTzX0P+nMCyrGTADDxkFgylxrsoyqO+EWPDiJX7uixM7wBgpNOavH19oaoJq8uOQ0eOF+WmwQb2Yjt7BxteeasPfa6PsJpTggpjO9J8ziw6hYHUKFiFYVnOy+8VNocz4nt+a6MGL1s8ALQUNpLE9SshHTUOYpppwYOp/uUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+DJLPpvuaSt3bbjhhtEGoPfmhrfQv06BxuVWTPWLzo=;
 b=Eu3I+T7Bdweux2XG9SBCUF+gBumKGCbPPMm6IeTPHwSR9f8M9Gs47l3/50S2YVyyCdveFgu1V8T/1BkuwFRzxnqB+iGachB+6dKV9hY2C9ahNyXyVOCm6rro6SicjvoeHXgep91L7LRGImj4NTdONw0hDjU1C30k2JEOVCG5al6PzYtXJ24HZuopKM1yvvpLh6trKlNay2yzuG1oThCW6c/bGqqv6TjVSZ6YYU1jdpR9adJRuik/mCjkMBpY6sUrrWzPj1kjPjS4e7iuDJJtYar5es+wIiFyMZHdj9p18jutTFbCbr9ova86mbVl6q2rLkJLE45Bb8H+WjZ86bMIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+DJLPpvuaSt3bbjhhtEGoPfmhrfQv06BxuVWTPWLzo=;
 b=0kS8j36ejD2drG+zmcCsU5cCurWQh4MTTDXbQrtG1mVVB1II1AaTEqc0TxGxeCEHF/mlBB2Dw/1MKzFt5RcW4rajRCKZ5nhSnLJqV5nyyklynj/qVYNA55fDWZIINgKOm3OBFUfZ86PdcfuLUcGoByHfMDntcVcuV7y9CGE45Sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by IA0PR12MB8894.namprd12.prod.outlook.com
 (2603:10b6:208:483::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 7 Jul
 2025 05:23:27 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Mon, 7 Jul 2025
 05:23:26 +0000
Message-ID: <1ab3381b-1620-485d-8e1b-fff2c48d45c3@amd.com>
Date: Mon, 7 Jul 2025 10:53:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Christian Brauner <brauner@kernel.org>
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 pbonzini@redhat.com, tabba@google.com, afranji@google.com,
 ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 david@redhat.com, akpm@linux-foundation.org, paul@paul-moore.com,
 rppt@kernel.org, viro@zeniv.linux.org.uk, sashal@kernel.org
References: <20250626191425.9645-5-shivankg@amd.com>
 <20250701-liberal-geklebt-4c929903fc02@brauner>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250701-liberal-geklebt-4c929903fc02@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: c92cf473-bc6a-4b80-0e5a-08ddbd166681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk9mSmsxV1JvYjlBcmVOK0NtVzE5ZVB1bjNiNGlqYXpENFFFM05RRW55dnZi?=
 =?utf-8?B?enJMNG5lZEphWmVRcnFWVG8vZlFBQ29OaTdTWXh4cnJXYnMrWTBkR0xYeGRZ?=
 =?utf-8?B?VlMrOWZEalZxckpDVytHSFdYZ1ZzMldDWmVjb042NHE3SHRNaThwUnd4UnRi?=
 =?utf-8?B?aEZLWVo5czlKaVV4dU8vOWpMeVc3NDBlNmRDK2JISy9PMkxaOWh2Zkw1QkRv?=
 =?utf-8?B?OWhva3lmOU5VbDdNMVdRcjZZa2oxdW1OUCtZcTZ6akZ4a0p0U3BwYjlnTXF3?=
 =?utf-8?B?UE0xQzdlYkFiWU5Ncnd6UGFMcXFrMTBWb1RDZmE3ZmxwRjMyUllyRjJIM2Q4?=
 =?utf-8?B?Qk5yMnJMZ2dJaUZpUGNyYjM0MlQxZ1RNWnVENXdwRHRTYUdSR1J1Vk1pb2VS?=
 =?utf-8?B?c1A5QWZWMVFyZTFiSmJFN2VBWTdaS3VyQUN6MStmSXNrNEJkK2hIRnp1cmVF?=
 =?utf-8?B?ZWRqaFJlWDhCY0Z2QUJBNXRvc2FMUFd4V0Q2QmRGYzk4NW9UYnUyVzNQcHUr?=
 =?utf-8?B?UmZZTWJXL3FDU2kwY2lyRUhJV3RFcFRUNEI0N3RhTy9FZlZCd3luN2p0Smdi?=
 =?utf-8?B?SmNKczhYZUpiaUl6UGEwblI1a3BaODR0TCtkUHJucVEyZy9ITXNSdjdlUHA4?=
 =?utf-8?B?ZDUrVkpmN3hwd0x5RGVLeEVpU2FYVUR0aGlhY0JHRzFUUkVjdFB5aEpDcFFU?=
 =?utf-8?B?NDd5aTNxSzRna2QrSUhmNnF4bUZFOUZ0elFleXRGZVVwL0xUVy84K0MvQzBU?=
 =?utf-8?B?Rmtva3ZrbmFRbHAzU3B6WWJFWnJiUjc2TXExR28yMnVOa0xJZkdVT0VwVy9S?=
 =?utf-8?B?VUg4SnhqRFowMFcyZzFSOHJneng0VGJsRUtKNkZtRlQzR08veWpkRW9NZFRx?=
 =?utf-8?B?S0VHb1VvV3g4UEVFOWFkeU9IQjVSY3RKelVGNm8yREhvN0dRRW13V09VQVRD?=
 =?utf-8?B?cjU2RjBLVi9BbXIyeGFiM2twdmJ0a1NiK2hTMEZUNEVva3BhR3ZtMzBjaUVM?=
 =?utf-8?B?cjdrdll6VlpZMk1DeVF2Nkc0cDZMVWV2VG80UjBjYUNsUHBMSTFvZ0EwVGlI?=
 =?utf-8?B?MXRKVmpSenFsTHdDU3ZZOU1NTjRSdlk5MCs3WC91RnY3dko3bWNtenlGSERz?=
 =?utf-8?B?Mk5PZHJhTXlLR1BjLytuUEF2UFlNNDk5WUZKKzFDK2Z5M0ZjN0VTb0k5VVN6?=
 =?utf-8?B?OVdsRlppVUZSSEVPSW9KV25LWndtOVNVUnJhckdBd1F4Q1ZubnBiVW12SnRv?=
 =?utf-8?B?dkFXYURyS0lzSG15enlCaHBodkpYVkFTQTJvaXJRUU4vREN6dHJXL3RZeHJL?=
 =?utf-8?B?UW8xaUEwQzhaUnFReTJvcXVLRHZOU0NGbjJtSEZKYS8vTzFCWWd6YkNEV3U1?=
 =?utf-8?B?MTlwcEtBN3FDcEVremUvTGVsL3hnRmdNeE5SRDlIRXFLVlRucWpzTlBsdkhI?=
 =?utf-8?B?VCt4TzQ5citDZzhieFlvS2dzcmZrQ2tieTBiMjZDOEY1THBudmQxRzdnUGMr?=
 =?utf-8?B?SjM2dUZSN21EbkJsalJuTm5JMkNML2tyNWcvOVlkd0lqRy9LWlNuK2lvMHlV?=
 =?utf-8?B?emxwQjBHR05wS3BqdW04MW5Gd2VvMzNMM3kyYUhGRCs4UFd3S0dGWGlIVXJs?=
 =?utf-8?B?cU05SExFUlp0RUlqZG5rNitnN0xSa2VWZ0FPelhqS3hrbnhuNkhtZmhlTndR?=
 =?utf-8?B?emRtbW5XYXduNjcyNUg0Zi82WVNuc3BTQWJLc2JnZ2Q1STNhRUlKUlBQOTdN?=
 =?utf-8?B?RVpwRFNxaFA2REZQYktIWjRxMnZnWHJpRzFTaTE5TlFNc1VyK3c3dExNc2M0?=
 =?utf-8?B?RERUWC9PMnA3cXlLUmVaeVZ4WDhNUTBLZDVpbUVTVW9yYXMwblFlQ2lPaTJM?=
 =?utf-8?B?MzJPNE9vM0ExL2lvQkVxZkVPdk1iR2psdDBRQVNya01oR09mUVJZOG9vYlJ2?=
 =?utf-8?Q?J8qMIIe1ePc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9xQXRqa1NmZURnMlNFRUdNT09IeU9lSGNOc3FGQkp5b3lpMkdOYzhzRG95?=
 =?utf-8?B?SHpqZW1tMGxRd2gwS1NWemlXOXhnUnFVWnJUVk1ISDlrcHNRbk5kTWRsZ2Qx?=
 =?utf-8?B?enRIelRVN3d6VzhiSFpYSGVpWksyYnU2bzJuSUhXNEIzaUxsa0w2VURYdFJM?=
 =?utf-8?B?MDhKQWpQbG5jbzRmNURZaU95N0trdnZEeXhWWjY0VFlBd3dqWXhuZmxmVVB0?=
 =?utf-8?B?a3lTWEFGQlBJalhkR0R2UGovR1ovVHFGTmxnd2FQWnpuU3JuSWlhTmFzWUhM?=
 =?utf-8?B?dlJrajJqSU1icDV4N1A1MmZNWmJuQ1paYWlMdTJSbHZhaGNJRXduTWtMTDVY?=
 =?utf-8?B?eG8rNzZ2S0R2Qm5PQjdXb2tlYmFwTEZVRWt4cHIvYUdxUzJIR3BYckdBQit5?=
 =?utf-8?B?Y0tCc3NKbGRXMkVVYmRPR1BGVnE0enVhd0dBVk80NC9OczFnQlpJUU9WZUlq?=
 =?utf-8?B?ZjdteVVMeWk1Z09zSGZQdUd5a1Rsb0RTNnJCZTI1UWJ3am50bEdnVTU5andP?=
 =?utf-8?B?TE13MkpUaU5iMHdtbC90TE9WdTRwQ3llQjJOZWhMcDJ1Nmk5dUdvTFhERXdU?=
 =?utf-8?B?WHltMGpaMGUwS1Fyck9vZjB0Q2xocmVvQnJkT0dZK3NiOHcwTFU5aEtIdWh1?=
 =?utf-8?B?aWJSdzc0Q21NWnl6Q0FGTWpYckIxSUJxY25pK1VSV3NvUXpBNnYzWGJkOXVt?=
 =?utf-8?B?Q2Y0RWhjZFkwK1Iva1o4YUJKcklKWUsxa3ZIYjlwRmpTSmJ2ay82UHZRVEpy?=
 =?utf-8?B?SkdOelZDMUNYTHpSaDJta2pXOFR4R3RpRlEyMW1KNzl6UVlXSUVmU0FVaTln?=
 =?utf-8?B?Z2l1QkZXaDZaK1lock8vM0JkTWtadVV5RkQxeWNLejJrUnJ4NUZ3V3F1YkNW?=
 =?utf-8?B?aGZvUmwyNlpteHozUWZGRnQzUkVWV3VYQ21vWDJXYXhCNzhPSHRVa21QN3oz?=
 =?utf-8?B?T1ZMYW1Oa1ZTa2dhMjBQN3ZZWHNCeUVjYzZYVEQvRWpKdGJ6cm1VVEFUYlox?=
 =?utf-8?B?WHUwa2syRGN2NENiTUNBc0c1cFdLRXFXSXFUU1QzZ0d4Qk12aWRJT0krUVcv?=
 =?utf-8?B?dU5sT2dUcWlqWHkvUExZVVpES09QMmZQYkw4RnY3Z2Z5Q3A2TlBmVy84eFRI?=
 =?utf-8?B?a1dFMURYK1R3Nm9Vc2hZREswd0w0QzVsTjBNektqeDVOVG1xSUsydzdRdU5V?=
 =?utf-8?B?cmg3NlFhdk9qSnozcjdDS205MnNEbmpPM0NjM1djTGQrdlZjN2cwSGU5cWlN?=
 =?utf-8?B?dkM4VEVxbGdYUXh0SzVmUU9hUnp6eUFoODdUakFLb3pEMC9ady81Rm1NSVYy?=
 =?utf-8?B?anMyTFJ3cEdiQlIrR3Q5MW5uajg5cWtFNlRhS2JsNWpYOHZ3QmpMSXpNNEtH?=
 =?utf-8?B?eEgySFo4TVNRZmFFT2QyU0QrbEd2SWVsREtpVUtZdysyNGl2RStnQUFyQ3ZX?=
 =?utf-8?B?NlZsMERJeFhuc01tVUNTZkF2aTI2b2tsbzQzRVg4eDkyWXRGY042dWFlc1Z4?=
 =?utf-8?B?T0QyRU1pV0R3RE5OVlVQa0xoVkdKVTdpRmsyN0d6bzdDc3JudVUyVU1mTjV5?=
 =?utf-8?B?aXJZR3h6L0ZOSUhORFBQbkM1Mm5iaWhpZTZpaVhMSkV2VmhuVkNGdGJIa3Q5?=
 =?utf-8?B?RXRpU2w1RDlZdnpaRUtoRklJd05ab2V4b2VkbC9TcDBuTzdNOG5HcXAvWktD?=
 =?utf-8?B?Z0h4b1BacitLaURvRnpJUXRqRzdZSDJjQ1loV00zNklwU0FHaHJZVlM1MGt4?=
 =?utf-8?B?ZE1pSWJiNXRuSXU5eXpnRGhDK2RMbkRocUZqL1hLSzhwSnVvTzZINXZGejVN?=
 =?utf-8?B?Y3l5bWVHZnhhZnU5TmtnVVdVNDJDN1l1bGNncy9DUDVuYXRZeC93a3RLdC9F?=
 =?utf-8?B?MVk2YlpqSSt2TkJtQlN3TnJaOFpja3F5RmN6eHNONnJheXNQd05kVlU3amJ5?=
 =?utf-8?B?RXdJM2pyMitidTBqSlJoMHp4NTVvY0V4U1pLVUZHMnMxOUZXYnFnejNXd0Vu?=
 =?utf-8?B?WS9maEwzaC9aNEhDNkdQS25FclFoeDU3VWJiNWNBUTZzbjhOdWhTVkJnZS9j?=
 =?utf-8?B?bldnN05RVEZneURpTkpBVEVlUE9EcWRmdzdnejcvR2pNK0JiaHZPRmRkanla?=
 =?utf-8?Q?eGb9dT5IFYoi2jMHLlzy20O9e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92cf473-bc6a-4b80-0e5a-08ddbd166681
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:23:26.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXy5aN7ZvL6it53TnkjoH83IOD8jairimbFpZg9hvfwOfHMpdhE8h3V6ZYQepRYfsa9QCqOEEg/mqxJ8+EEbxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894



On 7/1/2025 2:03 PM, Christian Brauner wrote:
> On Thu, 26 Jun 2025 19:14:29 +0000, Shivank Garg wrote:
>> Extend anon_inode_make_secure_inode() to take superblock parameter and
>> make it available via fs.h. This allows other subsystems to create
>> anonymous inodes with proper security context.
>>
>> Use this function in secretmem to fix a security regression, where
>> S_PRIVATE flag wasn't cleared after alloc_anon_inode(), causing
>> LSM/SELinux checks to be skipped.
>>
>> [...]
> 
> Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.17.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.17.misc
> 
> [1/1] fs: generalize anon_inode_make_secure_inode() and fix secretmem LSM bypass
>       https://git.kernel.org/vfs/vfs/c/4dc65f072c2b


Hi Christian,

I think there may have been a mix-up with the patch versions that got merged.

We had agreed to use V3 of the patch (without EXPORT), which appears to be 
correctly merged in the vfs tree:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.all&id=4dc65f072c2b30ae3653b76208a926f767c402a0

However, it looks like V2 (with EXPORT_SYMBOL_GPL_FOR_MODULES) was merged into 
Linus's tree instead:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cbe4134ea4bc493239786220bd69cb8a13493190

Thanks,
Shivank


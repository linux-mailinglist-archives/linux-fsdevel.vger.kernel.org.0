Return-Path: <linux-fsdevel+bounces-65928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C960AC153BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E243BB99E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA9339718;
	Tue, 28 Oct 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kRojUPzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022140.outbound.protection.outlook.com [40.107.193.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FA338905;
	Tue, 28 Oct 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662579; cv=fail; b=UMsaHHCWzxn/T2+rNB3W6aNyBjQbUmUFmnIFkC99y74bXL+nFRpeBwHjl/Z3L5uQdrHNJA7R4pjhn95TYmnpjukFU2pzGnW67dZU9yyl3Y4IhV9ns8d4KlKjrWPXcLBACUJTb8LiFTjv0yicVEA0Zkn1wSuApCar5yC57eov9Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662579; c=relaxed/simple;
	bh=g0XFwbQmZgxZB92VFDcTudQ6A3cYLtOVQAKgk/O+Le0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ads9UXRYUhnNOYAje7vP+Qb5rgsbqYCcqJ27DdP6HBISKSAGeLzS4q2/LTRfFeAJRrElAhLEqkhMwP8st3RaDCdTTIPUbzSJqlYNEgjPjnQrbN4BTut3PxMt/WHaxZKO7r4g2QB1YtxLqtw6mWx1TwZRODI3dNwqbitQQ4+cKgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kRojUPzf; arc=fail smtp.client-ip=40.107.193.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pD5SXaGTeZWZEB8kC59uAqWV7FtDqnuMJKa6P7ftcgQoCRNdPM/6nKWc451iAErA0bue4blZK9aL16RG1bvvXWgtukXELiVW6Wd67dbB+gRGcG7YTvs6Uovha1Xr5ObQVUl6H56uPe73Cx/Cv8vIHlkP8Xro4EDgo8J2uLn8HxD/9TkXEdIg+RJyszIQAzl/MmLUCnJChdwbPQsUHukaowTZmuzWd8rLS55cL3EoBczsVpqqjnn5H9sUoiZOV/Xxqo839b6/Qwk0sUUQAjm4RuzmIco1TYOmP2upRpcpIUSqa3R3LmJHf0SzXp3Nhy7IN1eS4uNjp1AHlmrYlvMf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1LvJuUb5FWOPKJ5OQj0Wj8mtYu4ihD59ySETqHtU/Q=;
 b=SbTm0qTgYVtVmICd9CloACN40VB1CFg6lEq/EpGshHImguL3mvCtl/chuvLpZqzP8yGjHRUddZ2h6H5j66mC6EdwTK13cTaFMCzEEZ6RfvGz1ewvFiXohyoh7Fp1Ipn48CGs76Ecq6X/NldP/BI9AHZODNOXUgyHTDg414U11pBJERCLfipkjE79z+AGXnYFhCCUMWnGxW42NvJKwdGZz26a9KG2Kp1/0neTJpNdlfXy3RaUpOUHlMMeXorAYn1PWXB1CDRwJCN8U7KEtxnrE9y7KUjAMhBGDVLAx8SLXhKU+hcLDUsrFxPhUNdSqZZAw+NocOuXd3JTUoG7zccrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1LvJuUb5FWOPKJ5OQj0Wj8mtYu4ihD59ySETqHtU/Q=;
 b=kRojUPzfoIrU57962wz0Askfe10spCEUjEEDCnoUlPDckmP41Kvnao5NsQMlUm6vBBNd6Ea5kFAs+VO9RS2L51XdyIIGUvw9xc3LHy9dJLvtuF9qOYTUAu9u9q8wjs5OTM1JG7RdHBkSc/p6FwWJbtIbHyix/zQEdJy6R62FYvZqInLbDXN2u5PzRqfneE7AwA586Nt9ziOijfLf5qY3/ICTj4/7d1NVhiz/gIa5gRJYTv563J41BBlBJqWITf9bSgTXOjQlqqPi5NQlExpmwpetGQc0qbZ6Jozv4YIQ3t2yS9oRWgsVnoKT1tqgH+3aGBp1bw6fxEWRLNA9v2/6zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB11475.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:15a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 14:42:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 14:42:53 +0000
Message-ID: <0fccf3c6-c11e-475c-9669-356928846aaa@efficios.com>
Date: Tue, 28 Oct 2025 10:42:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 12/12] select: Convert to scoped user access
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.862419776@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027083745.862419776@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0050.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB11475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7975e0fd-c85c-4e29-467e-08de16304657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzRTenpJRFE3VVhKMGx0NG9TSENHS0JodkRrTS93KzVkOVYwMVhXRWZrRUVJ?=
 =?utf-8?B?QkNwYUpSOUhpdDlXQW9CbHIzOWdvMWdUSVIzVXh4VE4yVFlyVUFiaEUwQm90?=
 =?utf-8?B?SzgxdFpWUXFuQ3pFYnU4VWk5QXczS2hzc0EvZFFRRU9nTFExZGJCaXc1Z0ZI?=
 =?utf-8?B?UUkwbmVBYjFibG56T1d5UHJ5cHlNM083Y3V5WEdMUk5XUkFPRzNqOGVIK3ZS?=
 =?utf-8?B?UTFBQmJUbThsZjNpRkZ1Unp1NUoxWHQ2NG5zeFJ1WXEzZTltSTJPZHlISWtp?=
 =?utf-8?B?VnIxaTZiVGVRdEVscGRtaWJnUk5ySTExcW5CSlZQNW91VGtZZkkxMWJ0aVZK?=
 =?utf-8?B?bGtFN2djN21odExtbjRHblRsQlhwWll4WnpMdGVNRFc3Mkk5eHZRczljV0o5?=
 =?utf-8?B?UmNRVWFCK1FpVEMxNEZSa3g0MVR1Y095eXBsUDNMTUJTSVRJYThnWisrRzV6?=
 =?utf-8?B?UWcxR2s1dHRFL1hnK25sMTVhcjlrbXRoS00vZ0xVaGRDbE5GRHFPQUZwZDZ2?=
 =?utf-8?B?Zzc3bndsdnMvU0pkZlJhRmVFTURja0lyVEs4QU1xdWlQN2VIcW5VdU9OQ204?=
 =?utf-8?B?YjE5bTI1NDlJajhiSjhnNXJUbjBGZ3FCaXRBdFZJSzBTUUN0RmlWTzZoL0xT?=
 =?utf-8?B?dDlkR3VnOXhhYXJtSkd3bzZXREhPRGxyMDdhV0UxU0tBQkRrQWRzZkF3ZE8y?=
 =?utf-8?B?Rkd4WG9hOHhiZkdUcVBUYXlkeU5VYnY1WXRYdGMyL09jOXlYSWUvMVJKNDRz?=
 =?utf-8?B?L3RMRkVxc2ZVaWpGRE0wRktlc0RrRG93V3ROMm9jRmhLellEWUdDM1BqbDhl?=
 =?utf-8?B?Z2JuRHd5MlgxQzhLYUphMzU3bnpmdzdmY1lNZ3Z2WTFXSUpVbFhsZjNwS2Zv?=
 =?utf-8?B?MUZkNlhHRzQvbCtMcXZMbXF1eTNVZ1lBMXpkL0xINm8zcnhzZUlXMjZmZzFV?=
 =?utf-8?B?aUNnK01lSEdlRGxRM2FrVGEvbmYySmljd3R1QWtZVWMxRk1MN29YdEk2MWtD?=
 =?utf-8?B?TEx0b1dENDE2ejcvL1lpanMwRVJ0MlQ3OGxCSTNMRkFNWURoYndGc2V5WFZV?=
 =?utf-8?B?a0hXY0RseHNUbTNLaHEyOVA4S0Jxejd3SUpmTTI4NFkyT0tzZTR3dU8wd0ht?=
 =?utf-8?B?WUxXS0pHTjF4K1k5bWRkTUo5QUtnckJQN0tBTU45dnNQOG9WMFQ0USttMkRh?=
 =?utf-8?B?WUJjeXl1ZlVnbVVoT1ZIcklvcFJFTjNoeEpBQUhFQVZWczU5OEFrRjZXeWtE?=
 =?utf-8?B?aGsxblU3VGJ0eUo4M0hGR1ovMllGS0ZoNHRWNXdPSGJSb1Vha0NrZTFRN2Ix?=
 =?utf-8?B?dnNRQWhnb0FOYVRoUEZVTjN4a0JmWm01WmZNeXJoeXhoS2dpVHYxMlk5SVMr?=
 =?utf-8?B?aGlXWUhjbWVLNllNOEcrTUNXS0VKcDRLMFN3UDJ6WlFDWU05K0xTQkNFeWxF?=
 =?utf-8?B?ZTlQRmZENG1vcXdiU21PbU1mUHRIaGs1T041aENndytqT0R1b3dEUVBEOXpt?=
 =?utf-8?B?VFcvbityWTZqWlFPUklKZUwreXE2QjlQSFBwdy90OGFCTUVhbVpWVnNSZVk4?=
 =?utf-8?B?Sjg4MjZjTzhBL0xtbHQvKzZ4RUZ1ZzYya1hReUh2WmVzMUswZjB2WUEzZVpN?=
 =?utf-8?B?WDN4QUtKRVRkWGZ6bWtaWHE5SFJBTGpoWFVjVm9RTExlcnFuR1NNZytlUkZy?=
 =?utf-8?B?eE1OSjdraWd6VFUycDArdFJCdUs5dDl1ajRNTzdNN21lQjZUTHJkczNVNHdL?=
 =?utf-8?B?MGdmK0h3QVZKZW9UQVZLbFdzRk56VEtFRVd1b0JkNWhjUTdmdVlyb1g1cm1T?=
 =?utf-8?B?bVpaVGJ1RklDZ0UxS1ZCbEZ1NHVtU0dMNC9QZTdHUzE1WUo1N3c0djAzdjNJ?=
 =?utf-8?B?THBJSFFDdGl6cDVYNWRJZXF6OHJOSWd4eWdHVWhvazg4MXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0VTQlVTWTNLemZUcS9GdUJVUzNoWW80QUdxUjZnU3dTcXl5OERWMGs0c1Nl?=
 =?utf-8?B?L3BNUWhmUHpTYUJNUDJYN2FEK0ZmRVNnNVBkb3FBeGdFWWVNUTVIampmN3B3?=
 =?utf-8?B?TlJ1eGhOZFFsdGYrbzl1TEwrWFFLYk04LzR6WWwvT2ovc3oyYmk3b0NEbEpj?=
 =?utf-8?B?VFVIb0wzeTBBUk9TSEZBdUpnZWdDQ1pPcDR1d0lPTDZVc2U5Nm9XS0cwU3Rq?=
 =?utf-8?B?N2FiL1J2UWFqcHczNXk3WEV1Z0k0ck5QZnVQU2s4NkIwLzIzZVVTMVVmbVVV?=
 =?utf-8?B?dkYzekNkTkNhZHhJdm1MaDdqRkMzelB1eGJHT0Z1c0NUV2p5OHY1REI5M0Uz?=
 =?utf-8?B?RWFRd0R3Y0JpM3RzRm95bzdST3lDTlRscXFISjlWQ3BPRVZsZ0lxUEp3Kytk?=
 =?utf-8?B?ZmZtUEhITW5acnhlclVCM1ErMkkwMmp1dUk1N3N4c0Q5TW81UThaMHlFcmF1?=
 =?utf-8?B?TmFPRlp4dXJMb1JOWFdaVkxDNktXVmR5Y09pRkR1M0FZc2w4elVPSXdJR29P?=
 =?utf-8?B?QjBlWSsrZ0wza0EzaEZlMUFUU0tXS1hhbDdJNWVnamt1NG9tZG4vdGhxdjNv?=
 =?utf-8?B?REd6M3V1QzBFSUdaQ0ZqZjluYVk1NWtIaEhJZm5KNklpQVRiWE9kTGNFdWF2?=
 =?utf-8?B?REdBRzlDYzZiRUFaRzZZd3BlVmlLdDhLNTlTS05OVDRxdzFNWjNCUmJlcm1C?=
 =?utf-8?B?WmRtNWd2cGplaFNaMXVYQXBhSnF6UG5zb2pxOHpKd0t6VmdtU0ZsTGxvdFFR?=
 =?utf-8?B?YnBJWENBNWY0RTRsYlZsbldqKzI3dm1MbzVIa2Nxd0ZDWFU1OHc4R0R1MjM4?=
 =?utf-8?B?eVlsSGNtbGl2cnkrb0ljdVJvRGVCek5Balo3cDlWREh2VGRwdEx2dmwvd3Bh?=
 =?utf-8?B?UUtKNDhvV3I3L1NHMGNsbis0RGxmeS94bGdPR3JTWHBZQUVYOVBQd3ZQVnAv?=
 =?utf-8?B?bC9ZaEwrWkVWUWJuZlFWOE1oZ0RESGRxMGNnWldSdG5sV3RwRCs2aTlZNUhQ?=
 =?utf-8?B?Vyt6cG5JdHAxdXNBdENVdjhyMXFwWm9YMTczbkhoUldLUXhVUkxWcDVWMENM?=
 =?utf-8?B?RTRMZ0V6UkFtQXpMZWJYaUw4WjhHc3BDQzBsdlJjcncvS0dkVkc4bjlXMUpZ?=
 =?utf-8?B?a3MrQWhwcmNjT1o1bWtvNnBMSVloRHdQMStlUGZhSm1wNzlMSGY2Mm9XWWVs?=
 =?utf-8?B?dGphbVNTc0QxdkN1VEJJYVMwM3RaeHU3YXhpdTRMbXptYmxXOGFkRDFhMUpB?=
 =?utf-8?B?aDJrR3FsZXJEdEFvdGRabk4wV3pwcVlESExGK3QzTUVXYU1MWlo5Uk9mM2ZC?=
 =?utf-8?B?dXJQR1hZZHZtcXYvdXBTV21HckR5dnU2clk1cWkvOGUzeEdmUHdhdTFpcUo0?=
 =?utf-8?B?aFNKOW03dTA3clRkdWwxekRSUjVhWXhVY29veDlxTUxxSURvZGJNaldBVTVO?=
 =?utf-8?B?ZkZDZTlUamdOU09hN3ppYXZWR2s0L3hmWG5NazcvdEdjWEM4VjVHTlRGR3Q4?=
 =?utf-8?B?MjRuQUVvaG50STFHOW5ZNUZqbC9lSy9hNGtYZ3NCMkR6RE5HMWRSaUVyUk5C?=
 =?utf-8?B?Rzc2dEkvN3BnMGF0RWRGeFY1N1J2V3ByeFhScnZlZmVKWDVhNGdsRVlvWXhw?=
 =?utf-8?B?dmVhNnI5d3J0Yk5uSkFXc0FZZGovakpwUGhGV05IdTVKbFZER0NURnVkaytI?=
 =?utf-8?B?anRMWjI5TU9US0dxVDVZeGsrNGpvb25aYzFvUzZvT3hKWk0yUkpaaHhsZi85?=
 =?utf-8?B?Tk9KL0FIYzNHZ3hCbE9aSnZWVlk4Y3BiSHpJQW1hWG1ZNU5kaHZsR0hKelh5?=
 =?utf-8?B?dDRia0pnMFhORmxFQWcwcWlXQWczS01qTWVKbUNYQ2l2bFRiNEVXeGdGREpm?=
 =?utf-8?B?eVErbHhOeTZsOURqS1FnTE1lM002UUpCUHd5YjdxM1l3bDQ0eHM3VmFvd2Ur?=
 =?utf-8?B?WEpUQ01tZUJBUW9Md3Z4REFENjFFVHU1R28rby9BbkZBK1c2ZktOb3lLWW9T?=
 =?utf-8?B?MytuRGt1YXhrTXFMZlZob0RvMnQzN09LYmU4M0xEUy96SDhwM2FjdVl2bmFQ?=
 =?utf-8?B?RTBDOG1SblJYaHhJS0ZZSkw3V3hJV3lSTmJLM1lKc0gxTys4WExGVkE2dGpV?=
 =?utf-8?B?MWtSbWZoWmJrM2NyU3JXRHgyNlRXL2t3QUJEcGNjQTI0S090RmNlUWNiZ0Zu?=
 =?utf-8?Q?mB9cUw2u1/yc+quB+x0tVW8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7975e0fd-c85c-4e29-467e-08de16304657
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:42:53.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esqtzi6thdvkmIUsuPgq17zq216FckkYMHDTWN1Lskvvz0KOG7sCpNA52dB/AzBLsX/XGRkntyQ22m4Df6OmEqV05VllszfwDxMDPGH7fLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB11475

On 2025-10-27 04:44, Thomas Gleixner wrote:

> Replace the open coded implementation with the scoped user access guard.
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


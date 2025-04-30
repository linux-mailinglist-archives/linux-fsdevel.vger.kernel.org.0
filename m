Return-Path: <linux-fsdevel+bounces-47696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A899AA420E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 06:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EF41BA3A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 04:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335941DB377;
	Wed, 30 Apr 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="AeiM22vI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24A1C84C7
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745989007; cv=fail; b=Iv2T0aXVgtrfla/sYEEQaYlRUKtfhyHYZJSliDSvH/x+Wu1T22sWqF0uIMi+7yOwfoq6xYhR1AXseu8K6Hu29+pOiUo9U7qOShWMlAkSoBaNALfORjFZkGy4itVysnBBdZmHydrkhs+SlZFt/iZtEYfyUs/bum93Hv/wZhnrC/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745989007; c=relaxed/simple;
	bh=x2ZZv1R+ahjq3Jo4HgLAf34l3FpT44niJmJ0U8Ip8t0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iCnVCLFPkkfvt0qaAIFsn9yL0E7KFh3C9NFDM13Kczemb5ITYFbvlCxHqnPGzoGXAZx/eRj/IuEihaT4nxK4OofANokDuGVHZdiGU8uis4IDPPTLOxUJns1gGDwYvK3k7IMTlkRwY4xxYVkwsp8grDlfycTI7S+iywHgGDetpmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=AeiM22vI; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170]) by mx-outbound-ea45-154.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 30 Apr 2025 04:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxT1efwK83u+RDonjxtaVbJ2f61tUw8aBXjyqZJeDXzXn0lRqGffFrLt+TtFxS/KyMx2R5fabb79bAn5zoXYedKfZzePnDKnItDIukW667k7u/XcGTmYp+EaRgEeuWR/seq5Gsrp6Kln0hJGCCdPVvwFM2vuKHIIvOJCRAWzvvlk+RosXFjg6EBCAUIn0Lxln6nKK4XQ86HlOzBnbTthQLtroSxiKzWYSreTldt0GIxGf2IiuvcDgHtnITmXi5B3M3vy1zMFEnUOe9mLfbBvYMjIyD322z3PCIyPDb65uxHjv/VmSak5L84TGUYmNde4Bv5bVWvwI8ud+Zd/e46XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IcVlHisdJzNkGu3tX6Ew1ybDLVsDsz+dNbAxGqR+jC8=;
 b=MWmoFHWnMKRKjdCieoVt5NCAz5x07oG8l+f0dsquAE/XMuWUGqfcNY86nK9O/Xr7v/gKuvjjwrCxKzJnBBAw4gIIoPbzfmXmGr4TyaZH2mjcrEThWOvuxk4+oUW39aeYa8NoDjPYqWnyH/636Or/eVgw5yRR+biiDBmapwClCQDUZ4L3n9IBi9633+xlgGlo0IMyahZ75P0FgQFKY8fzVB57qxsJ8iZwtHhhW/kDOQVPw/tAkalF/T6ZKt0FRMveVZ+naz5DoEGxWOiu0NjQfocH3jh0/v0X5Nfds/j3Sz48Y4PHr9kgoUIv3uwZiKAr3XE/oQdUnGBrU4kovOd+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcVlHisdJzNkGu3tX6Ew1ybDLVsDsz+dNbAxGqR+jC8=;
 b=AeiM22vIhOJNc905LUhky13p+r2Z8eQwRoz2BqZcNeh51J+lKo6k4/BlWZbzT+J2k3V2sR6EE3KiwYmg4GQ4iE3k2V98rb0lQkT5EvjbAf7d/RdAB6RVj/vqRHLtpOr/7UOG9PO0Xssb2Zhs/oQTSw+2y3zQkLfj4sVWF14oScs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by IA0PR19MB7267.namprd19.prod.outlook.com (2603:10b6:208:439::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 04:56:37 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8678.025; Wed, 30 Apr 2025
 04:56:36 +0000
Message-ID: <0422bb51-2465-4219-9906-d24ad3c99e0c@ddn.com>
Date: Wed, 30 Apr 2025 12:56:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] fs/fuse: fix race between concurrent setattr from
 multiple nodes
To: Bernd Schubert <bschubert@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: "mszeredi@redhat.com" <mszeredi@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>
References: <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
 <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
 <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
 <CAJfpeguiPW-1BSryqbkisH7k1sxp-REszYubPFaA2eFc-7kT8g@mail.gmail.com>
 <0e1a8384-4be4-4875-a4ed-748758e6370e@ddn.com>
 <62a4a1dd-124a-4576-9138-cdf1d4cbb638@ddn.com>
 <21c22c82-8381-4aa0-97f8-7c3b8df901e8@ddn.com>
Content-Language: en-US
From: Guang Yuan Wu <gwu@ddn.com>
In-Reply-To: <21c22c82-8381-4aa0-97f8-7c3b8df901e8@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0774.namprd03.prod.outlook.com
 (2603:10b6:408:13a::29) To BN6PR19MB3187.namprd19.prod.outlook.com
 (2603:10b6:405:7d::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR19MB3187:EE_|IA0PR19MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: ed717726-2787-4756-9e88-08dd87a3626e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkRkSUFGWjhtZmxGalBIZ0FLaVErM1hQS2szc1ROUWQwTXE2amszVmpEY1l6?=
 =?utf-8?B?SFhJRmZhWUpCU2dXbkIxL3o3ODF4QyttZ2VodGRKQTl2ZG9ubElmKzlQeHYx?=
 =?utf-8?B?ZytMVjhMUkU5VkhUa1hwdHAzS2tRY0tVZjgwOHZiOFpJOU1KNmIxNnJHQUtm?=
 =?utf-8?B?bDZKWm85ODUvNEFhMFdjbFRFTVJLaDV1QUVyTUVUMUEvMjJjZWtTVnNtWklJ?=
 =?utf-8?B?aDNkcHAyRWF3QlJxRU5kZGhnZXdNd1lCVmhQd21yNVJDdTdSYXg1bzgzWnBY?=
 =?utf-8?B?NUw1cSs0L3J6N0kxcTlmU0xiKzl3SExvVWdKQVQ3STlmS1RZUERJY1MvSDVr?=
 =?utf-8?B?aTFtY3hlNlVSdktkMGNmcTRNMnAxZXFDK3luSUpGVmlCdFJDQkFSM0NkcHNT?=
 =?utf-8?B?NmtsaTFraTNnQ2R6bi8xZU9RWUlOMTg1aXA5QWZzd0wxanJrNzJ6bUV1NzdK?=
 =?utf-8?B?bS9PMW1KZU5PWUx1Y0tSS0pyQkppR0ZtRzkyNC9UZ3Myb1pCeXBhUzM1NVcr?=
 =?utf-8?B?SmFzbDNJdEVKT05FUThqTFUrQmhzZys3SFdFSUZYWGRSSjEydzBiMDVCQWRQ?=
 =?utf-8?B?TmFBRkxkNitEcStjcUE1dnlxTjUra3g0WFRXMWxkK2taemVXMXc5QmI5SVdu?=
 =?utf-8?B?ZW9PSU1VZytHVktWU2MwbzExamlvdVJhaVlTTW1tbVg1RVI0bTcwbFZMaDU4?=
 =?utf-8?B?eUs2SHc1d3lsWk9TekxqRUlyc2dvRk41eGRGOGE2OVZYaWdtLzU5TTZoTTRa?=
 =?utf-8?B?OXpuNjdmMmk3Q3kxSTdrVDAvaVBFOU96RkNlNmoybjBaTkY5Um9LTzhKaGJH?=
 =?utf-8?B?cHRxd0d1Y0V0NVRHaklVWmEzN2JmamgxeER1R1J3V2ZZY21ESXRZODdiVlJH?=
 =?utf-8?B?Q2ZRRFBzSzBoalJsTGdLd1pmSG1DM3pSQTFTNDd5aGZocHBOUVNsTVB1T1dQ?=
 =?utf-8?B?KzZkNVE4eG9BaEZDMGZDdHZudEVNVi8xUGFUb1pZTjFoOXk2N2hrSStMY0tm?=
 =?utf-8?B?d1VqWE5hQ0dLWWpLdmozZ1NTYTVXUys0cGFIOXoxMUZsam5DbEdxMUtBbDNj?=
 =?utf-8?B?YmRJejM1S3RNTU9JQ2h0SzdrTTljaGtXelg1b0tsYkdwQ2JGREdqSUhwRk90?=
 =?utf-8?B?SGhVSldMTHBjYkxkZnpMRkZlNTJVeWJRRi8reklNTWV4aGJqV2hnVkx1UU16?=
 =?utf-8?B?Q0VzRml5aTNldVUrNmdBdWJWRzJVWDFDcks3VUw2aktjK0pKaTNLeE8zbFQ1?=
 =?utf-8?B?b3RoZlN2Y2FSZXVjNTNjN1hxKzdHejQvVUhLVm5rV1ZOMEhlMWdTcnhoU3pz?=
 =?utf-8?B?OGNhTk1NUlRYYjUvWm1tTFU0YVdSUVVnZmxLSnk3N05Jek9GQTBuRGlCNmFF?=
 =?utf-8?B?ajJYVmRVMjFFcDA5ZUJUU3psL0hDK2ladXVseGhqZHdQOU5hRGpXWGVvNW00?=
 =?utf-8?B?M2xwTS91SUlKMlYxV244eTNjN0R2RUlFSCtmenNqOTQ1WlNSUVRvUit3R2Jo?=
 =?utf-8?B?VzllQjkwYnpWNzljNmQwV0tsL1pTVFNXQ1JuQ05JQjVBZHR4cUUzM0hSeHFm?=
 =?utf-8?B?SnkxODQ5YzFUZnlMNEUvZGhOczZJS1YzT1E4U1JJWFlUeE9vMm0yQXlvWkJ1?=
 =?utf-8?B?NHBiV3JnREJSMHcrNHp4RmYzYnJUdzVRWG1HbEc5WCtoL2k4aWZxSFNKbEt6?=
 =?utf-8?B?RkRUY2s1cUFRSUE2RjluMm5rWlBWWEYvNTRsRS8yVzFlc2pQeldsb2hHUXlM?=
 =?utf-8?B?dm85MDN6Y01RNFdrcmcva0x0ZjZuN0wyaUU2aDFUQXEzSUJIa0pncW41UXBG?=
 =?utf-8?B?ZEhrUjFxRXdQaGFuZ21JUHlTd1R3UWVNUGNwRm4wZ0lDclNBS0pzZWpLM0xZ?=
 =?utf-8?B?d2VrdWttVk9oZ2J2QitPQVdSazFnV3hzWEQwY3dVV3kwUDNSUHZPSFhDNEs0?=
 =?utf-8?Q?OvqqmULNTEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b014TCtwVjJZbGV1TWNCbVlVazRKMUp3U2piSjdvUW9WRXNsM2Q4eGtDQTlM?=
 =?utf-8?B?M1ZIaHVKWDhrdHZrandvdnNOQmNSK0RsVldoY2FYdWwwQmQ5dGN2Tlc3bU5B?=
 =?utf-8?B?MUkxcWRtb2xyZ29iUHFvV2xFeUtUaTVuLzdoSkhxaWdVWVR5TFNLTFlYaDdP?=
 =?utf-8?B?M0xqb0t6Ym1kNEFxYmZZTnRSYTM1aWZKRktPdE5LL29aNTRZWC9ZZkQvNVMr?=
 =?utf-8?B?Q0pCeVlocS9KclBaOXZUd3NNRUxMVUl1L2oxTVk3YTh6bFlVc1hxTTJRWUQ1?=
 =?utf-8?B?Vkl5VW1rSDFiZWFWbXcrblEvM2Q5eEJEZmtTTlpVWmpCWk15d1I4VXdzS2NY?=
 =?utf-8?B?OWJMcDE2WWNkQ1lBSGg1aDUvOXY2UlBNWDNuOGJoT0pyUjQ3d2QrTnpvb2o2?=
 =?utf-8?B?SEZ1SWFMNjl5ZTJLb0wzTjNyc1FISXM3dXdwc2RvVFlQMUI1YWl6WU44WHpp?=
 =?utf-8?B?WExzRDVORm8wR1dtOTlEeEU5ZUtpWm4vWVdFTEdTMFh3UDRNa2poQVlyV2Fj?=
 =?utf-8?B?anR5cUhWRGZGc2FhZ1RsRVEzUFRCQjk3ZjRTU3ladEZxR3ZVbnVBSUo5cTg0?=
 =?utf-8?B?elZOS0hQWEVucGdaSm9SbWpXRjhTUU1xWHFOMytBWnk3dmdTM0I3REZwYnNQ?=
 =?utf-8?B?QVdlOWJnbCtMT0RBODNqc2pzOGZPWk1NWC9sWDZBNjFSeUtEMTllRENJUHh6?=
 =?utf-8?B?bmNDdzhFbHYrNlRUMHFqZTk2ejBuekpFVDZDRXRBVVUzY1JJWWRkaEJsS2th?=
 =?utf-8?B?Y3d4NnhaNEl1T2tLajMxeno0Z0tEZ2NscGNQV1d1TVFVaEtNZ1pkcEp2Y2FL?=
 =?utf-8?B?K2FkeWNJMGh3RXNqU0NyV0FYZUpJNmxTVFJxS0ttVkdQQWZlMWNGNVJ5VlVm?=
 =?utf-8?B?d3JaNHNnZFBpYzhKQkQzUVNSNW1PQmp4cHFIOUlDbWFxOTVJU1JLbkpoSng4?=
 =?utf-8?B?UjFESmNmaWd6NkNVQXdzd0NJSUNEc1hXaXdVeWMrSjJjYkdQcUxuazRlMVJs?=
 =?utf-8?B?TEkxa2w1WjR2aWVxRHpWY1doTSsrdFMveDNudEhYWmRJNjJuNVI4eklHcEVC?=
 =?utf-8?B?dXdSYmFPdXViTFVsbTBEQWduT0lRY0VacGRCalZTdUVHdlArb2laSHVmYmR3?=
 =?utf-8?B?dDdjcG1JWkcvM2tKU3VpSzJRbXpnZkpROHZHM0pnS2Z0NXFYVnp3eCtrYnVj?=
 =?utf-8?B?QmZwZ0c2S201U1pjQVF3V0JlTUZabCtUaDhBcmN3WVJNR2VxTmlVNmFCTjdR?=
 =?utf-8?B?Z056KzBnbDk4K0J4WHdLd0duOXVTb1NnRkZoVWQ2L0RLZVlrcTRiRDREeUZU?=
 =?utf-8?B?WlpzQk1PRnhaSWpnT211Z0Z0eGJLak4xaStmTTFhR2x6L1p0SUJ4Q3BqeTdh?=
 =?utf-8?B?NmJTNDNaa0d4WnYxc04rdS90TnljektXSnlJYTNrVEg0QWtnYnUrLzlMS3h1?=
 =?utf-8?B?ekRSZitReWpteFFZWXBOK0RrSUxwcDd1T28wcjB5cXNlTS9yWEJWSGtmMGpE?=
 =?utf-8?B?RUcweVNPNUF3aTB3enVuTFE1QzFGOExRdVJMZ1dZdHBwbWRKNGQ2bGU4SURo?=
 =?utf-8?B?aTBDZktKSVVFNGtPdVcrTnNWTGdJbDg3bmhEc1c2SHRZNFhxYU8xSXRKVjFx?=
 =?utf-8?B?UnB6alBybkZaVXd5Z0hVeW0zSUJla1ptcmFkUW5PWWhUL3FoNUVzb2tVNDJu?=
 =?utf-8?B?RVFNWkgyVG92aitoRFYvTUdiM3ZxUFkrd250THNhV3lHeFQ3WnJwMUp4R2Iw?=
 =?utf-8?B?QWNKV04zMEJ1QmRyeFpjTXZKdktwNm91endNU3F0bWNnUzRkaUc1Zzk5eHFO?=
 =?utf-8?B?S2l5UUt3R3RYaENudlZWY0syelRzQVFQVHFxK3hXVHFzandKejNTVFJNNURD?=
 =?utf-8?B?OENEMkRpb00yVXQyTklFaGFMa2N3Y3JiVEppSWFEcnlQeFZ6bTMzNXZBd0c0?=
 =?utf-8?B?WXJ6N3ZvRU5oSlkxeUkxeUhJNmpoNk9YQk5BZmdGNHlYTDhLN3ZJa2QxdVB4?=
 =?utf-8?B?U3IvNVdhVkdIdlI0SkNGZXBGUGdCRjJMeFJkL2lhRlQra2FoeXF3T0NQaVNh?=
 =?utf-8?B?dEFqZUNCK3pKT3ZkeFVtcHRQdVZ6UXNsZkE0RHV4bjZDeUtCZHNvK2xPTUJZ?=
 =?utf-8?Q?kUpw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/cKcIt0Oh+IrCqKQ9uXq4NjCOEb9cWh/4HGXRTlllCtqXU26SY+BeiHV5CzGri1zr+EEXM9iASxcxL7GHVwYKYgM7SXvWRTuvaJlRqwPvxevTqwWx1KiXsrw67iYeAl5aT+LMm6s+LAujRibHAzTg9Ll0mmZSStIXVMLJmW6s1LQtJwoECuF+wp+BxZnmmwnVZ0tZWqppU69CU0Bhq+o9VjHkWh6LQG9SHvF+7ZHxihbrTga8tBxpFu4w3nKYoXeo6POys/MkETAuz+gQZXW9nbrlfiJs+fuvnOEwuz27+G0DNQA8bWhW1WYGUowxg8epnVWYQgByVli7ecA4+BKUgas/DukdrZcPXPF63P7Xz0LedP5GoPLqft4UnhFaZ3TxyR5kitEAfsHsbDKMPBU1g3GJXohSkEvU914ggZt0gIuesllOACqCUJyMOSVCLx/81ostD4+9rp9r6lZuJLnEWRLkTItwHPAzd2kq3fQoNax9sHequ9uEMu0frzI+qD5IbFbfV8P8Peey94VQF+Ei3DlhrF53rvjbKsHHnzlMBDVeqj18vfi7D4Y9J4iHZMaTgL95twaWWpcv+leqarrdOroSHNDuzSliNWXSnJ4g00WY+lvT+Kxtu543ZzJfVyaB+TKO1oehP6dkxaDTpaZbA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed717726-2787-4756-9e88-08dd87a3626e
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 04:56:35.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVqxYPWbn+Hsz8clGQsicOghKK5sXJhYnhNxyhphdbOktLZpiWor33Ob7QLANWwl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB7267
X-BESS-ID: 1745988999-111674-10552-44518-1
X-BESS-VER: 2019.3_20250429.0138
X-BESS-Apparent-Source-IP: 104.47.55.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYWhsZAVgZQ0DTZMi3FPNkgzc
	Ag2SDZzNLc2MA8zTLJLM3EzNjcMtVIqTYWAAvvs9dBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.264250 [from 
	cloudscan-ea21-205.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/29/2025 10:23 PM, Bernd Schubert wrote:

> 
> I'm kind of ok with adding my  Reviewed-by line, but better not in advance.
> Miklos also didn't add his Reviewed-by.
Thanks the reminder, and I will remove these lines from new patch.

> 
> Issue with the patch is that it does not apply
> 
> # b4 am 62a4a1dd-124a-4576-9138-cdf1d4cbb638@ddn.com
> # bschubert2@imesrv6 linux.git>git am --3way ./v2_20250421_gwu_fs_fuse_fix_race_between_concurrent_setattr_from_multiple_nodes.mbx
> Applying: fs/fuse: fix race between concurrent setattr from multiple nodes
> error: corrupt patch at line 11
> error: could not build fake ancestor
> 
> And then looking at the patch, I think all tabs are converted to
> spaces - doesn't work.
>
Thanks, and format will be updated from new patch.
Also, I will invoke checkpatch.pl to verify the format.

>>
>> ---
>>    fs/fuse/dir.c | 12 ++++++++++++
>>    1 file changed, 12 insertions(+)
>>
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 83ac192e7fdd..0cc5a07a42e6 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -1946,6 +1946,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap,
>> struct dentry *dentry,
>>           int err;
>>           bool trust_local_cmtime = is_wb;
>>           bool fault_blocked = false;
>> +       bool invalidate_attr = false;
>> +       u64 attr_version;
>>
>>           if (!fc->default_permissions)
>>                   attr->ia_valid |= ATTR_FORCE;
>> @@ -2030,6 +2032,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap,
>> struct dentry *dentry,
>>                   if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
>>                           inarg.valid |= FATTR_KILL_SUIDGID;
>>           }
>> +
>> +       attr_version = fuse_get_attr_version(fm->fc);
>>           fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
>>           err = fuse_simple_request(fm, &args);
>>           if (err) {
>> @@ -2055,9 +2059,17 @@ int fuse_do_setattr(struct mnt_idmap *idmap,
>> struct dentry *dentry,
>>                   /* FIXME: clear I_DIRTY_SYNC? */
>>           }
>>
>> +       if (attr_version != 0 && fi->attr_version > attr_version)
>> +               /* Applying attributes, for example for
>> fsnotify_change() */
>> +               invalidate_attr = true;
>> +
>>           fuse_change_attributes_common(inode, &outarg.attr, NULL,
>>                                         ATTR_TIMEOUT(&outarg),
>>                                         fuse_get_cache_mask(inode), 0);
> 
> We could also specific 0 as timeout.
> 
> fuse_change_attributes_common(inode, &outarg.attr, NULL,
>                                  invalidate_attr ? 0 : ATTR_TIMEOUT(&outarg),
>                                  fuse_get_cache_mask(inode), 0);
> 
Yes, we can set i_time to 0 here, and next getattr call will set "sync" 
to true from line 1327 instead of line 1325 in  patch.

1300 static int fuse_update_get_attr(struct mnt_idmap *idmap, struct 
inode *inode,
...
1324     else if (request_mask & inval_mask & ~cache_mask)
1325         sync = true;
1326     else
1327         sync = time_before64(fi->i_time, get_jiffies_64());
1328
1329     if (sync) {
...

>> +
>> +       if (invalidate_attr)
>> +               fuse_invalidate_attr(inode);
> 
> And then these lines wouldn't be needed.
> 
Ack.

>> +
>>           oldsize = inode->i_size;
>>           /* see the comment in fuse_change_attributes() */
>>           if (!is_wb || is_truncate)
>> (END)
>>
>> Regards
>> Guang Yuan Wu
>>
> 
> 
> Thanks,
> Bernd
RegardsGuang Yuan


Return-Path: <linux-fsdevel+bounces-45643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E94DA7A35C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D093AF4D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17724E00E;
	Thu,  3 Apr 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="OGOy3/I4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91625776
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685631; cv=fail; b=KVVQHHgLSzDx076mxJxaqv+VMn2fYOX31LV5UdvoBg/5lXCthqWSCwRvr5VMicqGHcn+e2x3XyXAwVwN/OfK1wyEe2S9O+ROKbE3kreBCT6v20v+R5Uii+TGEmIgjaht6gbOPo7k5EmYKE0D3EYtj9fvd/1U8tPsCLyLCyaje0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685631; c=relaxed/simple;
	bh=RD+oTYhnrPVgCj4yUaOzTDVymjv1bbdHkNMZsDQm0YM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZD9bUj/JAs3JcdDUGleNjALO0uKEydnJ4f0qY3Q5CorGlICmQFa03Qlv89rgPe0ic4U3cDgLuvCRurHRiFAI172p8bWWr9ZqztCwUY//u4UBmxiqSx0pNbF1AKnbe+RaZSS3KceT9UEH0pNI3vy6xVDyHSPMdYvtDtWbnmURXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=OGOy3/I4; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173]) by mx-outbound13-197.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 03 Apr 2025 13:07:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZrfZxn16A2hXxfuJL+e1Nlrwtrxx+DhGeMH5dW9+SnY/GPeJYGGZP4Qji9FjQU1/3ZzIzLzI0emUYc2BAvXPRxSq5/bKKx/VAG2srzbeRGhtJSaQ5LK3tP966gQUZkGTkYEzDBcs+4YqLe3EunnFrVW0pxPBwhhy9Rup3akcQFK+BLAdYI+cHkaOr6ojoHS4PWkRRUgC4ndtg54ymfWmbXb1gCqsZPEjEwt2IkrRj+8wsaweNeDIyKFH8Lk0aXAsvTwFbqWmxA8KGli+djChv1gvC06uDg3WBxro8cHV6z/Qtc0F+Ih0MsazO1urbCraPhc+fATF8pYeyz2UaPPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyGkVvkEObIbDccn+zaPh7qYvWuDtHLX3YxW1oB/UYc=;
 b=qqS2sjEfutW4eDHCXXXFD5yTd1H/qfYvhAj+kPjmkESGqb+4sheBp99xixTeWknwTdH6dqklc6BnOF/W4ANY2RwM1Xx4MbC1C0GKw2Q4jhYoYOLGPQXEfQRN/OVnTzhOWxjEiRN00h+zakY3lq/Ir/JtFzUzBvLTa40gDGBwjJA4jR6iJfT1HOt1rF6r+7O6aUmPgNKHkMeLDSmVmwVeTApzBTKbbRhofd6t9JlslyxSIWFYSRW5WhJoUYgfvpHo/Z5tPRdMFlwxibCIwvE/1sojMU6IthN6ER2/gxmflPtbinLtu9OXwZMSZd93U2ZjY70ZXzjkydmvjLbHF4fKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyGkVvkEObIbDccn+zaPh7qYvWuDtHLX3YxW1oB/UYc=;
 b=OGOy3/I4d1ZPBOYNB61pzT4yfUu5oZlC9qZVsxNu2A0Ifo6LzrYGNrL+iJ83Q/Lg2O0oFfiSz6Qi+S83Qt7tlwRqP97fhfyUQmnhPwuSjUKYhistV5Omn/0CzIx16Wo99PoHov6Sr/LOGLXhqoQLqZk/QbiH8THosFoHc6UgETI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH8PR19MB6593.namprd19.prod.outlook.com (2603:10b6:510:1cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 13:06:58 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 13:06:58 +0000
Message-ID: <ea639832-737e-4c4b-83da-d7a8356a0748@ddn.com>
Date: Thu, 3 Apr 2025 15:06:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fuse: Make the fuse_send_one request counter atomic
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
 <20250402-fuse-io-uring-trace-points-v1-1-11b0211fa658@ddn.com>
 <CAJfpegsZmx2f8XVJDNLBYmGd+oAtiov9p9NjpGZ4f9-D_3q_PA@mail.gmail.com>
 <b1f59622-5d4b-48d5-b153-a8e124979879@bsbernd.com>
 <CAJfpegvKbtbUmWw9EE92iV49+gn9ZpLF9B4sVnW-M39kzLFXEA@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvKbtbUmWw9EE92iV49+gn9ZpLF9B4sVnW-M39kzLFXEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0507.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::26) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|PH8PR19MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3406b3-00be-4705-e567-08dd72b06a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlhGS0I0Wnc4YjBQVnQzOVgxQVhTcUtXYUx6M0JaNHlQVEJPSjhOc0o1WmEr?=
 =?utf-8?B?cGdSL2gvWlZHNzVzKzNlR0pNZHFMSXFGRlZmb0I0WmhWa2hWOUF2QXAzOCt6?=
 =?utf-8?B?T0pnSTdCK2pwWHcrbVNadllGckxMdXFGZUNIRk1EY2NmY1RUazhyeXlVTFBL?=
 =?utf-8?B?WmZXV0hHaSs5dFFXeDRSdXhOM3hoNjFrVHk5VlhPN1Z4RG9zbjlqNnpac2pG?=
 =?utf-8?B?K0Rua1hBLy8vQ1o5bjFFSUJ0T2YrV3hFRi9GcE1hTFhQQ0JwR3ZSb3VSWTVN?=
 =?utf-8?B?RDlFQjBURDJBYmo2K1VrTjl5M3Q5cDNqM1V0c0R6VTY0cGkzYXZHTEc1elA3?=
 =?utf-8?B?L0trMy82UHducERJVEZIUGZQOWFpMlhQV3lvZ1RJeVNnV0tCOFZyQXpuOWsw?=
 =?utf-8?B?Qzl6a3pISXBQT2ppeExqMjBPTnY5cnFTbVJJMC9YNS93Umk3ZG05VklFVm83?=
 =?utf-8?B?dTJkRW9lMXNEbVBKWmxRL01tY3dOeTBpb2lHMWlOTWplVGdVR0JlOG1mSEtN?=
 =?utf-8?B?c2ZxSlZVZUdZR3RIbm03TE9nNm9kZ3dYanM3WVlTSlRiRW05WnFsaFJMcmZG?=
 =?utf-8?B?RmFZbWpiUjVlbnJobHZ2K3hHc2FISkkwVHRzcGpkZk5WbGZadFdEZy84dmxQ?=
 =?utf-8?B?MkFyZmFwKzBKY3JuRW45S3hLKzhPaFFiYzlPSnVHK0RBZGQwM2YvaHU3dzcw?=
 =?utf-8?B?VUJrbFdvQ0VpUHBITExqTFIraThoZVBibEttRW1ZNDBPeEZTaU9yNSs3YlJn?=
 =?utf-8?B?dWFBSHo1Tzc0aENPeTJVdkptcWpSVXVWRlUrSytXOVlDeDVTUFJrd1FXclY2?=
 =?utf-8?B?V3N2WDRVZE4ySFc1YTRNNTNSSklPRkhoZEdObVVQV0Nyb2twVFZja3Y5Y1Y4?=
 =?utf-8?B?Z0dxUEFvNWNocHQ1ZE11MmRhRUZhTmxYWng3TnVCRDYxTCtJVlIwTFk0d2t6?=
 =?utf-8?B?NFNkdU43dWh6RXA4K1dYZ0p2L1F1eUw5Q3UvM2xNOXk2ZHJucEpmSnRGaGRY?=
 =?utf-8?B?ZXJpMFVhMmVUOG9sdHNwWThzZml2NE1hRTdvcjNsTnU4WnF5L0o5ZDZ2YkhW?=
 =?utf-8?B?WjNUNGQvRnpwM1pOZGc5eE44SnhnREtaR1prWFBab2JuTjU5dEpKRE9oSnhh?=
 =?utf-8?B?YS85RGVsNGJ5aEhKSVE5NWVGNVN5UU16Qm1ncS9FU05nQi9nVkRkYlRzRnh6?=
 =?utf-8?B?ZzJLK3BOdmNacUM5Qm41U0dpL1ovZXJ6UnJqc0puVFIrczAyRERZa2U3ZFVU?=
 =?utf-8?B?cStjQmFPSWFEVWhxKzhwWEpiV1pwbEJWWDNVUFYydWFxNE1lTWJ1aS9RUlhu?=
 =?utf-8?B?SFYrbW1mUzhnOCtSSFYrcHhwZmNtR1JtSWNBL2Y5S3ZlbTYyVzRLQkIxYldv?=
 =?utf-8?B?S25DeGR5dDRndDBwSUFOL3pGVEFYMTlqc3BaWExzYW1zUE1JSFFCbHd0N1A0?=
 =?utf-8?B?WUJqRk0yS3BJVHNGOTFPZnlSYkdTZEtoSUVHQVdFV2owQmFKS2dLK0Q1ZE5J?=
 =?utf-8?B?TmJkdUFQMmovaEZaMEF0VXlIeTYyY2dSTGEzTGJYS3Q3SzJyd0VpNU8wVDRR?=
 =?utf-8?B?b1pETHB3S05qeE1rN1R1cDF6cC9HZHoyMjVLcnhMQ1ltQU44Z3FudHRYOVAz?=
 =?utf-8?B?NEw1RlVzZk5IT1Rab2ZSY2RMZk5veWtFVXBlOGZ6K1F6VU1Zbmo2Z3dRZTJQ?=
 =?utf-8?B?WmVRTzc3UllUcnRCd1VMSGVycDA5QTJoUXhvWEhyY2xRVzhlbWlMTUwyQ0xU?=
 =?utf-8?B?V0R1NUw0bklsQ1diTEVxN29md3VvVDVKVVpMWjdpeW9MRVRkUnpVdGNsOVBm?=
 =?utf-8?B?OW5DRDVzeFZXVjhMdGt3UjZJT0VBSjIrVS9TSGxEczU4MjZZcGFSNy9QTVU3?=
 =?utf-8?Q?PKe9SHr/fpZJm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU5ZMzFqVVkxcjJVM2NIbjdYME1EcEFpc3c3dlZiTTIxdWl2c0dEbFZHSDJZ?=
 =?utf-8?B?aDY3NU8xNW5IU25Rc0RDMUttT1dTd1U3d2hmdXljNWRTOXFMM255QlFrNmJW?=
 =?utf-8?B?azNXL21oemF5UTVSemErUUFQVU9QcXVkSmEyZENCakdxaGFsV1J0bEgySk5J?=
 =?utf-8?B?MWcycFJKYWVkSG5LNnYyb1NwT1A0c1d5STlTdWxzVXZXSmxoeHdsbC9uM29M?=
 =?utf-8?B?NGxyNWEramJvZThEOG9lMzVTN0ZBclV6aTUyb3gwOUUyMTBCVDMrZWd2LzhK?=
 =?utf-8?B?MDJ6RTR6bEhZeWNDZEdjT2RLcXRJd3UxNHBoQk5aQUFxM3JrSmViZXByelRq?=
 =?utf-8?B?TjZHeXRXcWFOU3lmelhHZDlqMFpCMlQ5NVFhZTNnYmt5Znp0aHkzK0ZFNkpH?=
 =?utf-8?B?K3VnT1ZBTnM5Q1pHVFBEc2JvZUJrS0xvWGQxdkZ1c2FFdW01MnVGbmxFcThv?=
 =?utf-8?B?M1RIOGJ1Y2NBQUJqWEgxTHNMRXN3Ykx5Q3NIQWdQZmNRczJTNk9XdmpSbkUy?=
 =?utf-8?B?L2pqczB4TUxuQXJxNDBUYS9CWEVFME92ZUJWVnh2RUZqVEQ5STJZRmozVkVM?=
 =?utf-8?B?SXZBM3MrNC9zMENPczNONjZjbjczMlVxekRNWkFSVm1TYWNKMVZ6T1JJOWlV?=
 =?utf-8?B?Zm0vWENTcStqaVcwZnl3NjN6RzZFc0hVWGNqK2JPUTRnaHlvMlhVaHVHU0dH?=
 =?utf-8?B?dnFPaXhEWDg5WFlBcVhWUXU5blVhVUtEbU85QkNQQ3dOdEJzaXYzVG9MUXdw?=
 =?utf-8?B?Z2o1cnhZTzJqdzhIRnBuYVNodFpCaGQyK21iOHY3Y3E1c3lTNjRWazl6aHRs?=
 =?utf-8?B?SXVBb3FUUGFWNnBQMUE0S2txeFplTzBNeDFRZXNJdGF4aHZaK0hicW9TSDR1?=
 =?utf-8?B?eHVLY2xRVWJSakFOaWIwT3RNcXVEa0pRb1BESW5nSWVZUEtSNVJvSUIrV3Nv?=
 =?utf-8?B?RlZHYmtKSTlmSlNKTUM4Ymg2NXJTQ3lzL00yd1FDMTFSSTZvY2x2QnppemM3?=
 =?utf-8?B?MGYydkRIRjlBMnVuamV3K3E0em9QTmRjbnNFcEVHSVBoT0FFcmJaU0JzQnJw?=
 =?utf-8?B?a1phdXVpb3NlYmR6QXFxR3JSOXc5dXFFTFFmejhkWFFxN1ByNXRwY0lPUHFY?=
 =?utf-8?B?dUVwUzdraGFRVGNIY0lDaW9xTHY3Vm9aVnM4Uks4anJzNUxuKzF1NkQrZjVT?=
 =?utf-8?B?ZWJlcEFPdlZMZVVTOUtqYXczT1JDNGZ6UjViNzdnNFlaVDZBcU9Cbk52cHVm?=
 =?utf-8?B?ajVScnN2RThxZktPMThacllPQlJpalVEMlJFbTdlOVRCYm5XbExBMWVyYUR6?=
 =?utf-8?B?VDBXMEV3S1R6SHpWN0p5U2h1S1pEVDR3VEMvamJwUkhyL3hVcXMzQzhBNUJH?=
 =?utf-8?B?NE5ML3dEMTllTEprRG9qemVZQkZlcmlTVUFXc3pFL2JacVRIZUFyVmlPU3FR?=
 =?utf-8?B?Sk1sUHB6YzJ5cytRYlBXYjRnQkRZZGZUdWsvcHdhc1VGKzdzZzhxNUtuT0FE?=
 =?utf-8?B?SHlHWjFqa1lpcklva0l3M1VhdGRWSEdDaFF6Q2Npc05OQVl3U2hCZytSckVU?=
 =?utf-8?B?aEZZZllJOE1UYllnZ09odjBQVllabWg4a0xOdHhNQzQ1dnhLQWVTZUZSNm1M?=
 =?utf-8?B?bkZDcHIreGpobk5mSHArSnBTdUxOQjVJemRKZEpna24yQ1BwWkdXUzFBaVND?=
 =?utf-8?B?dnNubEIzaGtaZG5Jak9Bd2Vtb0VUYTRSbmF1eXl3UEl0d2hzNTJMNm9kNVFO?=
 =?utf-8?B?ZjZHMEpObThISlhUcGgrYzVXdlEwZS9FNE5uVVdIdFpvOFlCd25uTW9jQW5Y?=
 =?utf-8?B?bnFuMkhodzAzMXlVOWNOMS9UZXpBREtNVDQ5ekJJWnVvYnNZK0h6TGhuSmQv?=
 =?utf-8?B?Q2NZVkNrTk92cEF6N2IrbUJlbWVaN0R2eUJmN21xaVIzWi9yYzNySklqelh1?=
 =?utf-8?B?NE00dmZyOVdSR08ySi9oZTdSYnJUdkJQeWJEN2FlcGpHeEVBdGpzU1UyUWVZ?=
 =?utf-8?B?VlBjaE1Xakd3UEJXZFRHYTIxbkh1NXRNMTA5S1ZZVVduNDM1YnlPTE9QaUU3?=
 =?utf-8?B?aW45NGxsTENFVm1CUjhzcFlzenFhR09YeVo1TEhiNmYxRzRwRytta29DU1dI?=
 =?utf-8?B?NWNwbEVtK3ZZNGZVMVJRcUJOSHl6bnpOTXpxd3FwQWMwRDlETVdISWlTdklv?=
 =?utf-8?Q?enD5efgl2+SCkfWzl7j0INNLGJUBRyYpSl9JLr89plQO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9rNexWUfs6xC2981hrZoc3d8YokPcLBZ4Tlw3gZypPB2ddgwqHoopjJt06nA5g0xOk60m0Yfps4/1bJLaMK5oBEY4YTw6NQJACrbPCpJs76vOEn9pUG0C52OXIcDry2fnBCnN/krJr5iPmYoBU40DokSV26bOkeVUkarUgQ9IWoVySIEr54srLL9UcGn9+mBRoh47ActIqv4/NEYN+aeq/HtBqdX5MFsPjNbJhe/VugPd2fqUt9+J/NVmSbyCvH+I1lcCNgtoOw/o6TUQ9mTeCcRlM4hNmqoHh88JNDHMVpy+px7lNkZv8hv6fg6UylUKyXlKmi+8zOGOi6u7Jm9TxnI/Z87yLSgWIhO0523Mz2G4GXEDprprNAl0HG3u41QR0TLJKxoOcvKMCH9boAtcFF4PNo3OjPYv9azT8QMhngwD8O3y40qATC3B1HbDvzJ1ERJWGDhcbEmh7FuaDMg1mYaAhdswbC1rxuHlil8K6s4LlZ/Et8B3C6I+6SHPCT/Z9ErymnZ1pBlXoJIMmatTk6CNR+Lq8Vkqke4UXlLq7288F2iExEVDKA4ks4G7OXYeZoZ+4YRvt5vghjPquFP3YJIt8ANtNvHCNgj0hBp95Kb9VKEG6Hai6ygeNAQkwZYp3GC3JNbEFcNZeVDIgrH2g==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3406b3-00be-4705-e567-08dd72b06a66
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 13:06:58.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6a49jTzcM560d72wMUhfDZrOA9OOJbZepqa9/H3Wryk5URkvOY03m2+mwObod4x/yf/wlumJCkwGlyEMeweU6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6593
X-BESS-ID: 1743685622-103525-8508-9716-1
X-BESS-VER: 2019.1_20250402.1544
X-BESS-Apparent-Source-IP: 104.47.57.173
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGBpZAVgZQMMXCOM3YLDHVMC
	kxLSnVyCQ5xcIi2dLUxCTJODXV1MxMqTYWAIGZYkdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.263622 [from 
	cloudscan15-58.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/3/25 14:15, Miklos Szeredi wrote:
> On Thu, 3 Apr 2025 at 11:16, Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> Hi Miklos,
>>
>> thanks for the quick reply.
>>
>> On 4/2/25 20:29, Miklos Szeredi wrote:
>>> On Wed, 2 Apr 2025 at 19:41, Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> No need to take lock, we can have that in atomic way.
>>>> fuse-io-uring and virtiofs especially benefit from it
>>>> as they don't need the fiq lock at all.
>>>
>>> This is good.
>>>
>>> It would be even better to have per-cpu counters, each initialized to
>>> a cpuid * FUSE_REQ_ID_STEP and jumping by NR_CPU * FUSE_REQ_ID_STEP.
>>>
>>> Hmm?
>>
>> /**
>>  * Get the next unique ID for a request
>>  */
>> static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
>> {
>>         int step = FUSE_REQ_ID_STEP * (task_cpu(current) + 1);
>>         u64 cntr = this_cpu_inc_return(*fiq->reqctr);
>>
>>         return cntr * step;
> 
> return cntr  * FUSE_REQ_ID_STEP * NR_CPU + step;

Thanks, updated.

> 
> ?
> 
>> Slight issue is that request IDs now have quite an up down,
>> even more than patch 2/4. Ok with you?
> 
> Being more obvious is an advantage, since any issues will come to light sooner.

I sent v2, non linear values between cores should be an issue we could
feel free to back to v1.


Thanks,
Bernd


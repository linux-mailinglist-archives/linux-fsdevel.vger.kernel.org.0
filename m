Return-Path: <linux-fsdevel+bounces-25848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D947951174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 03:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425D41C21895
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A4171BD;
	Wed, 14 Aug 2024 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="7uslIdn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9AB9445;
	Wed, 14 Aug 2024 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598106; cv=fail; b=kIYfzcIen2+8Wqjh3bBxLxoygmHeGUqW1Xf4WXhJqZljGrdOC62wqyy3mBbj/JenKQt2aU01nvgCasVOqp0HsUOnoWHIxPHWjQmhEoyObUeRarnMCXUFWjtoooZR429vhTwWpRG470gneIJkrvxoAq3dR4g4I6Iw4+/I7nTtA4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598106; c=relaxed/simple;
	bh=DlcNCIWxubePq8oVatJex1iOOTl+L+0YrWzLHpeQfYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkxowoodGEh20gLMnXTH+uriEgZSXwQuDPuhTbah+Ms2m0I7GypAlhbDa/qYGvLQ+nGl9dNX+7qR5rcHZPdAMSoiVFHeuibyVwmHHZJlnVfJJRsEAVAuxczEy4Pur4kk8t948I93Xe71ZEwzoBTF6hz+clNTEX4p8U9GnOhEfMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=7uslIdn1; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1723598103; x=1755134103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DlcNCIWxubePq8oVatJex1iOOTl+L+0YrWzLHpeQfYs=;
  b=7uslIdn1hHMwGdBN08A8PEX3dnsoycnaoaGxmEO+WCCx6Dqg2m+/uHfO
   6zRuZwk7Eyf6gJbeUthNlqJwd2P9/0J2x1uPT8YL8FJp7JFvsS4YEIiEU
   fHpaKOpZOm6kfHlcxjLA0Zxpqk52dkbhZQZ0Vk5cFGpkKicjXGQJxSb1Y
   I=;
X-CSE-ConnectionGUID: nQ0EcLBfS5iZZSev0AT2kA==
X-CSE-MsgGUID: s6s6iXYiRhWaX0y834Afyw==
X-Talos-CUID: =?us-ascii?q?9a23=3Ar33zPmiusuYlppcWcyIrB900eDJudESF4Xz0CUG?=
 =?us-ascii?q?DVGdbeoaYVwe5xPlnup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A34OZWA+RQXRqqxKpLPXeS7SQf9w2+PqvOHEMq5U?=
 =?us-ascii?q?5svncJHwrZx6TnSviFw=3D=3D?=
Received: from mail-canadacentralazlp17012027.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.27])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UM8o9eDCpUMFoLmLsScZv1zHiG9ob0kNnWc0Y5bQNwpPEJdiAnFH63IdzVlWka2VN/Q7KW7APFEMMSLO/SKKXOMzISD8RrGAxtHPE+ibitODyDVP3Sbg+Oj2BPDVspWdOAlXuruw+Vn+OsspLlgP6DTUlE2R6BOGNeov7TdpyEIE+2ogHGgUdw0a7sW+uWcXgT1aPUVCZdmAIUbQ3xQCg2lNytHrjMpP3RaSAYVpbpGA6yamSclt0u8hRWonKAEEU7Glzy1pQBPmJG4CKHEnuOSQrkxfZO3eULad8udApoGpkxC+v/SOb2oN5w67uvabbnmoKMC8PvmTDLayVKirGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRIDfQAaBr4HI/4X6OzXYR9sJ5nw84pLUBiouxJav6E=;
 b=hJ1FR9sT0e5r/aFO20V/YAfNZr3gjsNfUxq2AAroRviLuo1XwNTj3nwL5YRIJDRrotW4H/ACmFSRErDIj6xLNmUJORDAEFhv+fuBlSlNwwPVNZedGbvC5tmLVUMMITEFC8dnXfYVByNLg5t7SassgV51BBH+INPo1BdVo3MswQpqPXz30bFy0kR9vZK4iKmk6Gw940xar64chd1Vgm4yHcgJcWSWX4qruusdg9K1xShBetBwOTP0NUzFRktYdyDs2dHUBL7Ls5MTRXrhzf6YfCpLYGYVElBV1YeiTP4LW2WMg/yPJZsNKHLhwfWdyobMoFuLO1rT9U3d54PDRN0LLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT2PR01MB9509.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:bd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 01:14:42 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%6]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 01:14:42 +0000
Message-ID: <15bec172-490f-4535-bd07-442c1be75ed9@uwaterloo.ca>
Date: Tue, 13 Aug 2024 21:14:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 Joe Damato <jdamato@fastly.com>, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jan Kara <jack@suse.cz>, Jiri Pirko <jiri@resnulli.us>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <20240813171015.425f239e@kernel.org>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20240813171015.425f239e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0396.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::28) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT2PR01MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: 59f10792-6be3-4a32-5e71-08dcbbfe7a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEY5bkpzTzRvdG00TG9pK1J5V21ZRWhSYVJwdHdQOVNQZXIwcFRNa25RRFhM?=
 =?utf-8?B?bEhlU2VhZHdSWWdJbE1ldXZWVDdRcHVpQ1pBekZsTjBCQVgwaHpodWlWWWVt?=
 =?utf-8?B?SGt2RGRaMkZaY1NjL1lGSExST0s3YUFPSURJSFc3TWp5OW9NYUpRT0plZ1Bt?=
 =?utf-8?B?cXdyRVZ3eWI2RENGLzlzZlhpN3pIWUJ3cnBjWG5odXo1S1hQSjhneU5xcTFh?=
 =?utf-8?B?NjdmQ3hjakRGeU1VdVJnMFNDQ0N4RUs4RG1NT0JJOWNoa0kxTUdjSzV6MWl1?=
 =?utf-8?B?dHNKbGNmREZrd0xWL1FiYjFCOWhCUTlIWkd3NHZVaDkzNUhrN3BvZGpGNjFB?=
 =?utf-8?B?SDdaekd0VTBXY2kzTERySGlsdk1yU1V4YlN5RzF4Wi9qVGIvRCtEbXl3UmdZ?=
 =?utf-8?B?MkFzMHBqZTZLSllRdmluSTNZQkVsWHRGL1JZK2JZcEhlczI1OS9jUE0ramJI?=
 =?utf-8?B?MU1lZmtydHZnSGJBNU9qUytDcVpMeVo4bHcrU2RvUTdkSFZvMjMya2QvWUpP?=
 =?utf-8?B?M3d4ZnNLdUxoTHJNZlZCU0d0M0dnWUtuT1dVUWc3VU03OExFcmFjTS9nKzZC?=
 =?utf-8?B?N25IWDhOK1MzSmZWN1dyTks0dGNSR3puQVRtcDN4NUd4YjcxendTaWN3VHVL?=
 =?utf-8?B?TmkxNHh0QVBMQ3ZIdTQ2SjZvOFhPQUJkNGp2S25UczAyTzIxekdnTVQvOUwx?=
 =?utf-8?B?NE4rSXVrQ3lPeDZhR0kycXQ2VVFDV0QwM3hTMTMwSW8yYk55TkRqWGZ2VGdy?=
 =?utf-8?B?S0c1K25RK2tIekRNZFRXK2RJeDJ1UFR5eGQrQTV1RUp5bElDRG5US3hvZmRj?=
 =?utf-8?B?b0ZHNlVFQnUrZXhLa1JZbDZqamxIbUIrazdDVUxQY1NYb0c0QnhDdkV3RUNn?=
 =?utf-8?B?UU00ZmdGYmlqQjJlNzcxQlVIdHRGOGVXVUNwL0JGcFU5RXZZcHNCSzlFV2NB?=
 =?utf-8?B?N1B4UVg3aTJ2THByR1NNOWxZZU9oVmI1akhoQ2piSUJVSVpRaWs1dTRQOUNk?=
 =?utf-8?B?ckdpSFBRMEV4REovSWwwcHY4eFdTSmFCcitKaEpTUmRvd2FHREtCeVlwc3Y4?=
 =?utf-8?B?elAycWZvYXpYdXB1ajUzbldvMkJmRnJrOFN5SFh4WDJkQ2w4VnREd0lCU2wy?=
 =?utf-8?B?MGxUQWw5MGZYNzdnNVpTWEFscU9UWkNUbWdtUDJ2VklxZnVldTh2VTBpM1h3?=
 =?utf-8?B?eGRXQ3pvYnlXSHlvWDFmeS9JNzVhNThja2dCbzBpUUFvdEZaWkUvUmxCRTJ5?=
 =?utf-8?B?N29Qb1g5UDZsTktac1loSGRoWjRpOWJrYzRGVXYwNGlDMlErdFF1bmcrRHJh?=
 =?utf-8?B?QU1zSm9XckxVb2hjeFZyUkpBaTQxZUZ6L0lFQVE2ZjFHRURzSmNLc0VrbDJP?=
 =?utf-8?B?VXUveUFFUlVQRHovNVZtL1JEODJZL3llZUVrNDFmbzkxYjArdjlwdy9jYWV4?=
 =?utf-8?B?dUJLWFdEaXdpZ3JKNUtBanExcVRaOXZnanJKaEhHTUswMWFUZ2JSZjluWDM3?=
 =?utf-8?B?aEt4U0lQZ25tbVl3RURVMStiREc4V1VSV2JYcU1rKzBIdUpMVlQ5NG9NSjdl?=
 =?utf-8?B?QWFpYW1kTW5hSnkwN0J0RzJST1dlQ25IdktnUXQ0cnJuOFE2a29Kckw4b2Yw?=
 =?utf-8?B?eWxDd3JyTk52ZkVEVDZvVi9lVnRHUFprYy9wVzFENW9JLzQ3WC81UktKZDJW?=
 =?utf-8?B?bFpJWS9YdHlwR1RJbzNCOUpRQ1VTdmx2RlVjQk1kUElXNHZ2TTFjUldCUVpq?=
 =?utf-8?B?LzhvVDdpTXd5Y200eUdreFUybWpsRk5Xa1JmK1BEWDdpakJsTEJJOUk2Skwy?=
 =?utf-8?B?ME94UzN2SnFObmFQNDFiUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTMrcnNFOTE0ajRnNFIzYTBLaE9zeXpoTTVyT0pJblVDekpWVVFCVjF3VFhx?=
 =?utf-8?B?eWdkNUJlUEhxOVNaUnBacXZxTDlLZW5ZbXh5Q1c3WnBrbExHRWxQbWVDbFdT?=
 =?utf-8?B?UFQzWkUrTTEyWVpKZ2x2ZFpyNXBVa3cyb2VjWlJRNlVHa1pTanFFeUZoMDRC?=
 =?utf-8?B?c3NOVEZlRVpmU1F4SHBEUkNxVnp2a3BKcUhtemw1b0l0Ny8vcTg1NGpMWTZz?=
 =?utf-8?B?akMwOWVXaGVsbTRpb0hORS92Rm0wRm1oK1JNUW1rMy9VNXlPdGZtWFpFOXgr?=
 =?utf-8?B?eVdYaE5jMUlYYnZYcytNRFhjbW9Ec0I1QTVoMWRSK3g4bXBjaEpBU1I3SytJ?=
 =?utf-8?B?Q0dRSXVONDd6WERSbmlKd01BeklOSnRLVk1vYXJjbDArWk44RFpERTNneGV0?=
 =?utf-8?B?L1RQWWorR2xmaElscXg5am1hdTJXbWltVGRJanM0YVBIaXlnQ0x0MUR6dk9T?=
 =?utf-8?B?eEN1UTJSRDBaU0xRVHh0clJ1b0FNOE43RFdEaERERnd6bEs3WmJrK0xQcVdo?=
 =?utf-8?B?VnVaSDV5MXo0ck8xYmtSd2lsYkIweHJNYVBVVlcvMjRFbEFmNU12cTRJMGRQ?=
 =?utf-8?B?U1ErYys0ZXltWVdrMnJhMkt0Q2ZiKysreVZvc050L0ZqczdWOE9WM3NuSVJC?=
 =?utf-8?B?aVZic1VncGhob3F1cDgyM2VVWjZtVERFZ2kxUWlwNVFCTmtjTXczTTFOTWtP?=
 =?utf-8?B?UkE3N252cERVRHpBZGdnM1VBTGJLN3lpd2s1MGRtMHZ2MkQ4OGhtQ2oyclNp?=
 =?utf-8?B?SHh1S3YyTm44WHhPckpMNXd2amcxcG1WdVF4aTJaOXd6aUx0T1NVVHpvLzlU?=
 =?utf-8?B?alVJOFMxZm1lMTBFeW1sakNWKzg3STEyTjhoOHJTTG1tSE5JajVXMjRtd3Jp?=
 =?utf-8?B?ZWZWL1FTNjhWa29jc0pGRUlwVG42c0MrMENaSndlQjVWK3lWN1VoZzNhbHlS?=
 =?utf-8?B?R3hCTnZCVitNS2VNZTltVmVkSTJ4b2h3bTFvcE1tTHRZSDFZNjZINHpFanRo?=
 =?utf-8?B?bFdYYlEySmpVZVNDMDlYVnlxcmRGUkI0aHVKUUFOS0RZM1Z4YlZJKytkK3VU?=
 =?utf-8?B?QzR3aUMxU0FFVm9QMkp2ZkgwR0FRWHZMTldWVGdMbGVPb09ONFBBd2liWHR0?=
 =?utf-8?B?MzNSbVExL28wOFhxTVJRUENZN3dEb3BtWW9sWU1oa3VJSytiNXMwamt3NzlO?=
 =?utf-8?B?STZXNHo4MjVNS1FlOGdLZGJIS2FScVNISlVJZG1LTzN3RmQweGhHU0ZZR0xW?=
 =?utf-8?B?Zm1CTFRoaWttME5NMm4wdzExSUt6OFpOQ2lUc29NZFppSmVYR0p5Ym0wMTdN?=
 =?utf-8?B?VkRvRTJkbTBHaXRVQjJNWXpONjk4OUE5OGlLN0NXRDNkZGNxWkl2RXZFbWFm?=
 =?utf-8?B?T3A4K1dPUGZRTHd6NzhtZlg3VUtMcjc3R2x0ZVZqd3Q2R0dJc21RTUlSQkN2?=
 =?utf-8?B?L0ozd0IwYXpPb3ZaM2dad1loQWNHQkE1SnVZTStTZGwrZGxQc3lsWFl5RGdN?=
 =?utf-8?B?QmJQcVJCaEFoa3dzWGVxWmJ4dDV0RnRIQWpGaFdsNWVZN3FLRzFoSnF3KzRl?=
 =?utf-8?B?YzZZUmpmVTFSSEdjRTBNenVadUwreFR4aDcrM1llem5lckE2UkhtSGhmaXlR?=
 =?utf-8?B?cmVOYVNRcXVFVG11eTlSOHZrTTBkUG9SRFZwRWN0S0ZOUEZXRU9Za016cFZL?=
 =?utf-8?B?eWw0MDJReDhaaEdWN0JnR1M4aXFwNGVnVUd0aVROcytFb2pnRjZobHNxandv?=
 =?utf-8?B?MGpUWjNzY05HSExpZStnZGFPSkRzVUsyT0xXNFo4RDRqSnNZM212LzJUV0V6?=
 =?utf-8?B?VjlvK012R3NCM3RpMGZ0Umh5K2tabkphMWcvSUs3ckhBUncwNVBYZ1pMaDhm?=
 =?utf-8?B?VkVqRHY2WXdGaWhra2NPQ2ZsMndWSDRDZnFzdVpNK25MUGNodXJEZDNDcUxK?=
 =?utf-8?B?WG03ckhGYkVXUXptR0RjYTZJMFB6SHp4cTNLQnNkc0xuQ28zMmowTzE2N2lU?=
 =?utf-8?B?bHhvZ1dIcEw5RlBBQ3kxb2c4OUJsdkp6aWNabDYranUxQmthbjB5TDVoa091?=
 =?utf-8?B?WUlwZ3NoT2FPTXRjRzVDSmNGVG9IVDlhVGZ4Z0p6NmZOSitSM3NybGRXYm1j?=
 =?utf-8?Q?0UzSLsAI5UBwSKAINSQ9KDIlu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wZL0JYtbR5n/r/jwY3a+M68QlWRC1Do3ZWHChHEZ+WMw+x89e+qrywMqczHgPhNj4+pF11K6442xMVg36bh8QtYaxCQuC/QJev5ZcOCDmCi0Mtwm8uftbDdgo0utxohoIY7rBy8wDJqhWoqou0pDA9DWtU8KRpcBgHfaPkYF9WTGxyrUB9+bOW1AMvj3cD029pH8ZGnoO2OqAWAcTEWoJk7CjP3RfQS6AjOMwZE47xAOeILjdK4LUSU/XYYrb6OOND+rzcjOzQ2RjjiQ7tlrUDQzTipXbWXsacHDgthB5njhVec6kQP8mAlLiOybBw7vs6O6GvXM6weXKrUoa5kHAk6QRLkCzjIzKg6n9t1cyME5FuNrxF53KS7JDWl7c65O5ai3CThiB7sSodTCJCs5K2OHSB68iEh2TJx2zvMCQEYvVW+Vp5MzHXuWYPCNpzU2frLfflyipfnRxT80/HxUr/R2NSyiD9yGkfh3RLvbvAMBwcoj7Vid1MdFjCykHiQlvZsZ6L0W6/QPRumwnM7arYEV4+IseRgx9876HPGW0ZtJ0qpmzH0Gb5Lvt7VZ8b52GdOzEwGTVf1xDUB3vtKi6Roil3sox0pbvZMnKIeQSu+ZYdZp/k0H4EVGgBh72CLV
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f10792-6be3-4a32-5e71-08dcbbfe7a0c
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 01:14:42.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6plK3trbGDF8zMMEjoAaYwsOxFOVwrIpylejqcvKVqFZSIxM/MMtx3hQ+4S2Z1b/rOzwRJpUE9i7QNYb/tHFYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9509

On 2024-08-13 20:10, Jakub Kicinski wrote:
> On Mon, 12 Aug 2024 17:46:42 -0400 Martin Karsten wrote:
>>>> Here's how it is intended to work:
>>>>     - An administrator sets the existing sysfs parameters for
>>>>       defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.
>>>>
>>>>     - An administrator sets the new sysfs parameter irq_suspend_timeout
>>>>       to a larger value than gro-timeout to enable IRQ suspension.
>>>
>>> Can you expand more on what's the problem with the existing gro_flush_timeout?
>>> Is it defer_hard_irqs_count? Or you want a separate timeout only for the
>>> perfer_busy_poll case(why?)? Because looking at the first two patches,
>>> you essentially replace all usages of gro_flush_timeout with a new variable
>>> and I don't see how it helps.
>>
>> gro-flush-timeout (in combination with defer-hard-irqs) is the default
>> irq deferral mechanism and as such, always active when configured. Its
>> static periodic softirq processing leads to a situation where:
>>
>> - A long gro-flush-timeout causes high latencies when load is
>> sufficiently below capacity, or
>>
>> - a short gro-flush-timeout causes overhead when softirq execution
>> asynchronously competes with application processing at high load.
>>
>> The shortcomings of this are documented (to some extent) by our
>> experiments. See defer20 working well at low load, but having problems
>> at high load, while defer200 having higher latency at low load.
>>
>> irq-suspend-timeout is only active when an application uses
>> prefer-busy-polling and in that case, produces a nice alternating
>> pattern of application processing and networking processing (similar to
>> what we describe in the paper). This then works well with both low and
>> high load.
> 
> What about NIC interrupt coalescing. defer_hard_irqs_count was supposed
> to be used with NICs which either don't have IRQ coalescing or have a
> broken implementation. The timeout of 200usec should be perfectly within
> range of what NICs can support.
> 
> If the NIC IRQ coalescing works, instead of adding a new timeout value
> we could add a new deferral control (replacing defer_hard_irqs_count)
> which would always kick in after seeing prefer_busy_poll() but also
> not kick in if the busy poll harvested 0 packets.
Maybe I am missing something, but I believe this would have the same 
problem that we describe for gro-timeout + defer-irq. When busy poll 
does not harvest packets and the application thread is idle and goes to 
sleep, it would then take up to 200 us to get the next interrupt. This 
considerably increases tail latencies under low load.

In order get low latencies under low load, the NIC timeout would have to 
be something like 20 us, but under high load the application thread will 
be busy for longer than 20 us and the interrupt (and softirq) will come 
too early and cause interference.

The fundamental problem is that one fixed timer cannot handle dynamic 
workloads, regardless of whether the timer is implemented in software or 
the NIC. However, the current software implementation of the timer makes 
it easy to add our mechanism that effectively switches between a short 
and a long timeout. I assume it would be more difficult/overhead to 
update the NIC timer all the time.

In other words, the complexity is always the same: A very long timeout 
is needed to suspend irqs during periods of successful busy polling and 
application processing. A short timeout is needed to receive the next 
packet(s) with low latency during idle periods.

It is tempting to think of the second timeout as 0 and in fact re-enable 
interrupts right away. We have tried it, but it leads to a lot of 
interrupts and corresponding inefficiencies, since a system below 
capacity frequently switches between busy and idle. Using a small 
timeout (20 us) for modest deferral and batching when idle is a lot more 
efficient.

Thanks,
Martin



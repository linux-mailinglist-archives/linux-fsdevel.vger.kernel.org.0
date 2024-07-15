Return-Path: <linux-fsdevel+bounces-23650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B7A930D8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 07:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFC31C20FCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 05:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B313B2A9;
	Mon, 15 Jul 2024 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gzE/JAal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85002132494;
	Mon, 15 Jul 2024 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020965; cv=fail; b=P/wEz5hXf83dGFwAlELkHvkia0mGWeBDaUxAvcMkhaX+iLUVeNmDmIgQVH6THaYlVi5oH3LvEEYf4x0rSkgDY3Qjq5oM31hWVsZA1e203IM86WLArbSHK2Yzj1XSiMjH9ouIIwWufPf0sJVOVpCUic203sfcLtezNlUBta/nN0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020965; c=relaxed/simple;
	bh=RzF5BIg54w5WSmqiWK4tqx0h+nlhkbw4P3EectxltBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=itQdly4Sgzlc8vNQO5bkAEwII/Pt/vKwWjDVpXpGHfnpo7gyGRsFVfiQtcDaTg8IsXQeHWmhEegZiA5jq032u/L2f+oMuUzuBapm8q0cJXYCeZXAUpTiv5b6p2cdmfUG5MvBzp+L7YrDvVfiNO/lQv86/72qmWhtFaB3Eoe1P78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gzE/JAal; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFW2dtrJejrXqnxAPndmhvjWuAQk5foqPY4GmsJWYpOwaifLOmfbULUDeYNf4Z3VWiEyn3ft5FcIcZyZoct2Yi37S4dmOmmUDGavwhymAzcaxt88tEfCbVkvhSdlT5lFd+oWcJYj9s8TKoIaYqaDjMaLva/yiYSkIBPP9aaEHOutuLlg1bXfbr6ng8WWmS5Wfjodpc4TqS0N7p9yy6UPtxmUtJQm6/sk7DA7o+doCYZ05QPgdaKWB2h1AXV2oAi1JLOoEwpOt9HYuYmCx9+wGiTnIjutbYs3612qZniWOyhZRU50cq/2JkDb0+H2Y7qHNPJFpCUs1t1MfDHIxpP/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBg8lavJI7B2e9UOIbQ+gB6hLCDX/9Jk5JNwozZ5fp0=;
 b=hWvE+BQ2FNg1mC+eiXfSPVGH7ZMNLx5nYAl8+F2C4h7tjS80B/vXHMEc3Vaj4hRLvQthFtfQyknOt+klT/IjL1Aj032lK7O+QI1NFvUKXajJQhKFdT2+U0O9CNwomhR2aAzYbNs6R6OZ1tbiH5rK1CC6j8DqMA3jZ8Dj1NDIudCsXVpUS3jOWbvn/pAY7zzhgMk57dC3kVk5qokxKaJqt2WvvZ1/SUmqQD7E2HRS14fCxDzbAxIwnC4pq8XOR+knDMWAzQMHpGeqNlYpTldeXINAed3FYjQlViPPwWee4C59a1annXaBVGerIPvROm9yE6YZuDu7QQyzt64T8z5T7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBg8lavJI7B2e9UOIbQ+gB6hLCDX/9Jk5JNwozZ5fp0=;
 b=gzE/JAalo+8kOGZPfnhFhKBVEZwsvT4aldZmCKiC6rFQBKcBjOiELuwNCGZC6dylkoDoFOxD1QuvQoosdhxwIF2v4TWY1mdEYiRfGlSuhhMGWOnaj6enLFNAriTkUS9oWcs18N3stD1ciJFZWNMJMVCjD6KVfDJzUCZjOksH5J8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) by
 PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Mon, 15 Jul
 2024 05:22:40 +0000
Received: from DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207]) by DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::ec83:b5e5:82dd:b207%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 05:22:40 +0000
Message-ID: <56865e57-c250-44da-9713-cf1404595bcc@amd.com>
Date: Mon, 15 Jul 2024 10:52:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, david@fromorbit.com,
 kent.overstreet@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 nikunj@amd.com, "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>,
 linux-fsdevel@vger.kernel.org
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <4307e984-a593-4495-b4cc-8ef509ddda03@amd.com>
 <CAGudoHH4N0eEQCpJqFioRCJx75WAO5n+kCA0XcRZ-914xFR0gw@mail.gmail.com>
 <CAGudoHEsg95BHX+nmK-N7Ps5dsw4ffg6YPimXMFvS+AhGSJeGw@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAGudoHEsg95BHX+nmK-N7Ps5dsw4ffg6YPimXMFvS+AhGSJeGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::33) To DS0PR12MB6439.namprd12.prod.outlook.com
 (2603:10b6:8:c9::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6439:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa84524-ec68-463a-3e10-08dca48e259f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzUveE1KbE00STRUanIyU3U4R1lkUWFQd0R2dE0xeHVwT3AzeFVhZXE2UjEz?=
 =?utf-8?B?RU1tWDl3M3Q3QnVJMHhhNmFYYkxoci9mRTZNUkZONTlKWGxhSmFjTndudXZm?=
 =?utf-8?B?dnk1MHdMa0kwbmEyck1SVm44YXphZGdySnN0cDFyamRjTW9LS3lsUE90MjF0?=
 =?utf-8?B?enVXM1JxZWt4ZE1iblpnRzJ1eFdzNU16TjB5Wjg3Mm04Z2w5c1ZYV2Y1MnBW?=
 =?utf-8?B?TEt6SGpnME5NNzQzKzR2V0F6MHVYbTVWeExvak4zOGpCZnJsWmFKQm9meHhw?=
 =?utf-8?B?amRPLyt0WlNuN05zMmwwNnljWGdjMndLL1c1OTdQTWtkTEpRWWlzc3UzSHFU?=
 =?utf-8?B?L0E0Y1RzNG1KWXI3ZllRcTBYdXVWalRlMnRoS3RzM2w2ZGs2aEV5V0RNL0tl?=
 =?utf-8?B?aHFjT1FyaDhyN0E2QkFlWTNpNGdYRjFCVVBNWlU0djNmTFJHYmNlUWd2MUlR?=
 =?utf-8?B?NGQ3bnlXSG12NHkzSXllbXRvakpsU1ZPMFhNUXFwYnFMWlllNUpHSGt2QmIr?=
 =?utf-8?B?WDIyNkVmNGdYR2k5eEpoSlIzeFd5WllzNEVQL29jbklLbFE1SVZ1QmxUYkpK?=
 =?utf-8?B?c3NrbENMQzVhYWs2OXJCQitnb01UbVZDMU5vd0tOVU1jS3I5amp4ZEJoZE80?=
 =?utf-8?B?cGQydzRMYkRTTDN4UDdIdkNoUFkvdWdFTU83SHpGM3hLRXp2QkFKZ1RFNlRU?=
 =?utf-8?B?bUJldUVtU3ZRN01uZGRlcGUxR2M0cUMySnZmcDFDcEowaC9XSmMraHZEU2s1?=
 =?utf-8?B?V1RoaU1lVW9ZNW9ocDJqdDd0bnJhTDBwc3pmNFdiVXplZS9mVTBvTUZXQzBx?=
 =?utf-8?B?b2srV3l5eE0wU3Nid0FDRjBuTExJb2Q2VmZPK2J2b1JnL1h2WXFrc2FqMWNz?=
 =?utf-8?B?M2NBck9LQ1piREc4U0RqU2ZYYXBGN1I0QStMYU9Rd0JSRlFWU3VpckYxSmJQ?=
 =?utf-8?B?MXJPM3lWbEdSQmdJeW5CRC9qelJ0MWZnSS9BZmVsNGtPUTZKdTBGS2JwUkFz?=
 =?utf-8?B?RWhRY1ptV2hEWjBXeGZRTmlnaDRMbEdLbEsrM0JQQ0ZyTDV5WG04UUh5dU81?=
 =?utf-8?B?Z25KWjNKMFY3WEt1cFdiVjBleVUvRERzV3cxT2tjR2tHWWVyTEc0bXB4aWM1?=
 =?utf-8?B?dEhQMStFckhrNWp4NGk5dUlrUktzSW12QVdXSHk5TGFnSHBNUGkwRGtrc1hn?=
 =?utf-8?B?RXdRMEQ0VHFxeFk1Qm5VdUNQdUVWdjdXbWRIdWdiZE5BZ1BtS2Q0cTlNa0FC?=
 =?utf-8?B?ZjF4dEdISFZXOEc0dmh6cElHeUtxbG1TdmkxeGRMUTJaU044NXM5R21CczZv?=
 =?utf-8?B?Nm11LytLTzZFdmZONktGRXl3Z1Azd0RBSHBZWVR0MEQvYzVKWkNPVEUzYXNt?=
 =?utf-8?B?dCtHZTFJMXhxSXRzd1h4Y1M2bVJOWFdyREFRazY4Ny9IQjg1WFVKeW5xbSts?=
 =?utf-8?B?MUQ5UVVQaWYwWU1OSVJOdDRodUpaRCtMQ3dqWTF0T1RQNmJobTNNdDVIcGhU?=
 =?utf-8?B?V1lhdUxRZkx2Tm1nbmJhZzRSdUJkbWxNTC9qUXhFdTRnMjd1dDFhbWlrdHZT?=
 =?utf-8?B?MmUwLzlpVGIxaW53TitzNVF1Y3U5a2dxMk4xejJoTVNrR004akJCWU05QUc3?=
 =?utf-8?B?T3lsM1QxY1NGVE9LTjdjci9aNkx5MTMzRGpqYTh4N1dMSWtlMnBUclFJT2FE?=
 =?utf-8?B?VTZtbUNBZ1JMSXQ2d2ZjdTlWR3NqK3VlTTRYMGpmNEdXZjFYT2dGZFhqOHJn?=
 =?utf-8?Q?RRRSVf4w/U/ZCkOpmqBLbnZSKTOeFNHuuoM6Bjw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6439.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tLMGN3aDRLNUFaOWlPdmRkM251cURVWjVNK3J6UWxDVWg3RjVpZ3RIaXVV?=
 =?utf-8?B?RzRGQ2hGaDJURE54ZDZ2cUZwQWF1ejZOZ0ZUWTRnZHBPMEZmKytTek1WTnFC?=
 =?utf-8?B?a0xVclZDVW9nVGpOMlUvNG9RV2dMZmdRUnhaYkk4aG1Da0s4MVVCT3oyMmFR?=
 =?utf-8?B?M2NUL3hBcmNYY3diRFpCa214NisrYTZ2bE85WTEzZDNtTk5JeDdkblI4b0xk?=
 =?utf-8?B?T2dSbmFDSzU1RU4zMlRxTHNyZmFXZGpycUFManpxTnhFM1R6ekNETFNCSnRQ?=
 =?utf-8?B?N3dubWdnMzFDL0p2R09nbGpKbW5RRWdpRytic29kK3lWcFhaMU5aanppandO?=
 =?utf-8?B?MkZnUUdWS051ZHNmd1U0NjgxSXFJckJpMGtCZEMyT0ZzWGx3S2xzYk5RdnFj?=
 =?utf-8?B?bEc2K0g1R29UNjByWlErSU9iK0c4dURBTFBHU1JITDIrcmlqK0YvdVhkTzd2?=
 =?utf-8?B?OFpVMFRCOXBDRDJobDkwOTVEdVNPdFBUWU02cXVYU1RvekszL1VMYlUyYnI5?=
 =?utf-8?B?QWxQem1DaWV5RXRhSkxFSko4em5QSGxTUHFHbGg2b1AvaFh0WXJ5NWhyekxO?=
 =?utf-8?B?NDBuMUNESUJMZ2pXSXc4c29GclVzY2ZNNk5qSWt0MEJrS1FHQWZNRUpvMVZX?=
 =?utf-8?B?Q1dJQWh3WGNiZFZjeFl1cG5SbUJqY3BGK1dtWElLVHFPby9rTGgzNDdTclNX?=
 =?utf-8?B?b1BEcGo0dnFtbkE0YVFSR1B3Vjh5d25Dc0IvZExSSVBMR1g4UmpIRmZjWFJC?=
 =?utf-8?B?eU5WTDB6YlBFZmJuU0dGMlRWVXZZUEQvdEFIaStjN3ZxdEJscEhYUDZ2VUFX?=
 =?utf-8?B?YlRyR1hkdXBlR2pvKzdBOGtCTGZudi9lOUo3UUdYM1l1a0JJT2M5bk45bFZK?=
 =?utf-8?B?VTJvZEJDZ2dpTU5aM0ZTWFVUSm1NWVB6SHlEUEtSSFNyTjllY1loYkpCbzdC?=
 =?utf-8?B?R3lWcXJXMzNKMjJEM3BFY3NtV3Rycmg0aWwwQmFzMGZkek9ubkhOSUpoTTMz?=
 =?utf-8?B?c1RLcXAzeXNTS09BWk1zZWgzWkFiekpkckdqTkF0QldUWExFdWg1MzFYUTZZ?=
 =?utf-8?B?Q1NaVmxmRW91SHl0bkNBdldtUjBnNlRUVEhka1poNGozYXFuQmFEOVN6dHZk?=
 =?utf-8?B?bDJpcnNxY2M4R3JYYmxWNlFnYml1bHUyekR3djA4SzFmR2QrUUhxa0R1Qndo?=
 =?utf-8?B?cXhnSjV6N3hSbERWVU1SU09HSlR1VWtKQUh0QS9aS2hDMXlTWlFjNkpXTXFl?=
 =?utf-8?B?alllaHFza1NGTWg0ZTZveXBsNEcyT1pFaFUvbnpNNzdpQ2FDNEVBRWtINUJR?=
 =?utf-8?B?OXZ5QmQweXlzRnZLRWtEZExCYmMyK1d0WXBMdlNORUpGRGJGLzVVUVpvZTd4?=
 =?utf-8?B?WUhQODkzblZiaVJtRU44MTIvRXFGSzQ4WGtsa1FWS0d1ZzNWNWNJTXJ2WXFV?=
 =?utf-8?B?N1ZNaENNYUluRVFZN0Q3WjVJYVIyRUZzZlFWdmJmRVdiUWM5aTdpYnp3WlUv?=
 =?utf-8?B?YVNENGkwZFJYL2Q4NGRLQlA5OVFGV0F1UGd5UnNWckpSUWxZem9sRlY0elJX?=
 =?utf-8?B?bmVPUW51aTJhVGdPNzg2ZzAyUUVTc3I1TFVZUHlmd2Z0ZlNuNitKZDJ0bjVa?=
 =?utf-8?B?WE42c2ZjdWdNUzREUk5MWTJvN1FxRmJLREYvdUtyQzladmNLMGhEWlI2dmZs?=
 =?utf-8?B?ZUpBaEN3VEtrMXRrMTF6YTR3N3M1TkY2ZWd4amQycUNTd2FSTHpNTFZ0Rlhj?=
 =?utf-8?B?Q2xEV2dtY2svRkhjMHdEZnFqNmw2UmsvL0FWS2crL0ZpYTl5QVpZa2tlZFd0?=
 =?utf-8?B?Y2JWaUZqYjhxN1gxaTU4UURIZnRlMzUrVy9ITXlxbktwYWJ0ZlhDRCtqYUVv?=
 =?utf-8?B?ZzNmMm03dk1FNStobmhLY2xQSmc1WDBLTDk1eDhWOWg3bW85RXNsZFM2emZa?=
 =?utf-8?B?VFpSWElYZVZtUTREc3lMM0F4Q1F1OUs1RW9xamRXamlWMEhmRDl1ZEs5c2g3?=
 =?utf-8?B?UC9yV1paLzdjWDZHMG9mMWlRaEhHcmYxY1EyRkJ1YXZ5dkJ6b1BXVlFEelk4?=
 =?utf-8?B?V2Q1ZWFHMzBiTmpBZmw5TW1pb0ZMR3pvbEpkT0l0YkZiUVBOWVUyK2drMy9R?=
 =?utf-8?Q?jEIJhLvflLV+wI/GvOtRUgCr3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa84524-ec68-463a-3e10-08dca48e259f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6439.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 05:22:40.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gXYLSpP5IvJ1wY/Ur9QhTWc0wGUdOZyR54bCXGFMgzTk6ScFYE62hRkWdDoZyMEitDpxK3bLnzgcXkpF03/KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

On 10-Jul-24 6:34 PM, Mateusz Guzik wrote:
>>> However the contention now has shifted to inode_hash_lock. Around 55
>>> softlockups in ilookup() were observed:
>>>
>>> # tracer: preemptirqsoff
>>> #
>>> # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-trnmglru
>>> # --------------------------------------------------------------------
>>> # latency: 10620430 us, #4/4, CPU#260 | (M:desktop VP:0, KP:0, SP:0 HP:0
>>> #P:512)
>>> #    -----------------
>>> #    | task: fio-3244715 (uid:0 nice:0 policy:0 rt_prio:0)
>>> #    -----------------
>>> #  => started at: ilookup
>>> #  => ended at:   ilookup
>>> #
>>> #
>>> #                    _------=> CPU#
>>> #                   / _-----=> irqs-off/BH-disabled
>>> #                  | / _----=> need-resched
>>> #                  || / _---=> hardirq/softirq
>>> #                  ||| / _--=> preempt-depth
>>> #                  |||| / _-=> migrate-disable
>>> #                  ||||| /     delay
>>> #  cmd     pid     |||||| time  |   caller
>>> #     \   /        ||||||  \    |    /
>>>        fio-3244715 260...1.    0us$: _raw_spin_lock <-ilookup
>>>        fio-3244715 260.N.1. 10620429us : _raw_spin_unlock <-ilookup
>>>        fio-3244715 260.N.1. 10620430us : tracer_preempt_on <-ilookup
>>>        fio-3244715 260.N.1. 10620440us : <stack trace>
>>> => _raw_spin_unlock
>>> => ilookup
>>> => blkdev_get_no_open
>>> => blkdev_open
>>> => do_dentry_open
>>> => vfs_open
>>> => path_openat
>>> => do_filp_open
>>> => do_sys_openat2
>>> => __x64_sys_openat
>>> => x64_sys_call
>>> => do_syscall_64
>>> => entry_SYSCALL_64_after_hwframe
>>>
>>> It appears that scalability issues with inode_hash_lock has been brought
>>> up multiple times in the past and there were patches to address the same.
>>>
>>> https://lore.kernel.org/all/20231206060629.2827226-9-david@fromorbit.com/
>>> https://lore.kernel.org/lkml/20240611173824.535995-2-mjguzik@gmail.com/
>>>
>>> CC'ing FS folks/list for awareness/comments.
>>
>> Note my patch does not enable RCU usage in ilookup, but this can be
>> trivially added.
>>
>> I can't even compile-test at the moment, but the diff below should do
>> it. Also note the patches are present here
>> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.inode.rcu
>> , not yet integrated anywhere.
>>
>> That said, if fio you are operating on the same target inode every
>> time then this is merely going to shift contention to the inode
>> spinlock usage in find_inode_fast.
>>
>> diff --git a/fs/inode.c b/fs/inode.c
>> index ad7844ca92f9..70b0e6383341 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -1524,10 +1524,14 @@ struct inode *ilookup(struct super_block *sb,
>> unsigned long ino)
>>   {
>>          struct hlist_head *head = inode_hashtable + hash(sb, ino);
>>          struct inode *inode;
>> +
>>   again:
>> -       spin_lock(&inode_hash_lock);
>> -       inode = find_inode_fast(sb, head, ino, true);
>> -       spin_unlock(&inode_hash_lock);
>> +       inode = find_inode_fast(sb, head, ino, false);
>> +       if (IS_ERR_OR_NULL_PTR(inode)) {
>> +               spin_lock(&inode_hash_lock);
>> +               inode = find_inode_fast(sb, head, ino, true);
>> +               spin_unlock(&inode_hash_lock);
>> +       }
>>
>>          if (inode) {
>>                  if (IS_ERR(inode))
>>
> 
> I think I expressed myself poorly, so here is take two:
> 1. inode hash soft lookup should get resolved if you apply
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.inode.rcu&id=7180f8d91fcbf252de572d9ffacc945effed0060
> and the above pasted fix (not compile tested tho, but it should be
> obvious what the intended fix looks like)
> 2. find_inode_hash spinlocks the target inode. if your bench only
> operates on one, then contention is going to shift there and you may
> still be getting soft lockups. not taking the spinlock in this
> codepath is hackable, but I don't want to do it without a good
> justification.

Thanks Mateusz for the fix. With this patch applied, the above mentioned 
contention in ilookup() has not been observed for a test run during the 
weekend.

Regards,
Bharata.


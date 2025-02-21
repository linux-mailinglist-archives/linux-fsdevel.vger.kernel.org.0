Return-Path: <linux-fsdevel+bounces-42220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9CCA3F2F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 12:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A314218E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C72080E7;
	Fri, 21 Feb 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wQVEAebK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332282AE89;
	Fri, 21 Feb 2025 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137417; cv=fail; b=dZR4et+gNm7h/5iLTq4Q+JFhuX/lpwGPnB7MW6IU63kwTr93DZVozdihPcCaHVuZ2UREBr6ETte0/nEFiZir17TFoiFaME5vMBQGjZbIayh+Y1qVDRCVcbt3yxrFgPUazEyjaNDvGcEZmuu1+b4Kh+xuFljMMDNLyuxdXoO80LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137417; c=relaxed/simple;
	bh=dFXTtHq0Oa+VPdhmlmMRL1NrHRYQKYYp8jZmcRz6UIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJbNIeRW0190g4cF5SI6py6rgzFNKp77yykMjCkIJvcp70n+Chf2oLY5Ps3tjdkuhqw290WubJihhfE3R1sUAf8bDT0oidveadWv8NM2rieZgGVvoNJB/pVfDGM7w2Sc0wAnUFL0cq+HEhbWlstTVRd1Pv8X/kjGPHGUdSCJBpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wQVEAebK; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHWzzU7AyIFjlBQrsmhf3Cs0EHAs/7HLJsX0WJQGzZupZhapPHWlPiDg7Rc0LLKPFhKap1B+jU0FhktjTqVy6MfYP3FYAMOD1wANifoCXfZh/JXQo8a3YOrevOjRrzdekg35BmXQnL6cKVR7Fc0iaI6qcDZXp8L2eWPCLmG62iNLaTLCnDUlEMLLaCmNZmZUUZMlIZPC6PQnH5krXs6CadYOPJxiHKxsgnYIgFBQIKUoes4e+sNdASKRmWgb5vNYWVCsrKPTsNG7wVZ0Z4DXXcsgzctmEsHJcSGtpmiB07PWTv0jZNCduq6lkk8IZE17askAk/NbrAMQoXBcQIj04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GDebTrDY1Ebc+IVrZBBuwnKXFJE2oe2gYqY2JpEmr8=;
 b=GwwssmlWNGCeFcfktuB70lmeuN2Ax76lZD3QPs/Z8hFYrmCNVike05Sy6gx8iN+WmJyeQXqXoyatEo8gYVAdR+TcYy+vbHgOwIF3elRyGLXDgiF4MISlUO6BqCG95rDFolWcCQeK3JQkQq61Txlag6alDJwEhRm1whnJtdKjZg/gK1RrELJp30YbzkXyRgA3OI/GLdIH9L3CvwyKO4oRj7WbctZMaeHYWkfdW+8C7SoahcQ7jVdEPbTnt7K55F2FrK3berT+jgNUH0AaXXBb61K2O3qLGM4sbC92bV5AlENCksCHQiDW3r/mGvXoC7lsT/gX28N2ZBPPRf8ibDG3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GDebTrDY1Ebc+IVrZBBuwnKXFJE2oe2gYqY2JpEmr8=;
 b=wQVEAebKrLHBfa18t/d2McAeuUai+z5PBeC1NxJyrqyHMg/bYN4JOR1GIiMy4ZNqnzlt4Tbtv7QspstyP2RKy1ZtMUWm0GNiYQfcQE7Dh8HHPUKBq/ZmGxc/6EvXOssChmsmshmJe5ml97eKUHRHJnyT7GA0ZZw2cukmZ6xfL1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 11:30:13 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 11:30:13 +0000
Message-ID: <2b77e055-98ac-43a1-a7ad-9f9065d7f38f@amd.com>
Date: Fri, 21 Feb 2025 17:00:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/4] Add NUMA mempolicy support for KVM guest-memfd
To: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, seanjc@google.com,
 ackerleytng@google.com, david@redhat.com, vbabka@suse.cz, bharata@amd.com,
 nikunj@amd.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, Fuad Tabba <tabba@google.com>
References: <20250219101559.414878-1-shivankg@amd.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250219101559.414878-1-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::20) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 24dc0394-5097-4722-c072-08dd526b1add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1NBUEVLK0xVZkV0TnNsNVJLMHo5NmVwS2pMcTdFOERxRDJOSEVLWU9vYWNy?=
 =?utf-8?B?cjhnK3BSVzBoMjVObGJGak1EM1RYTUpsbVBiREt1SVZuQ21KNmNLbWZaZkpK?=
 =?utf-8?B?WEgzRlNzMkNiOFVRTUc4Vnp1SHlrdnFSTFVYcVRuMTN4all3UUR0Sy91cVFD?=
 =?utf-8?B?bzIxZTNNQVR5eFVHNHdiUHFLK3c1R3Y5VGtXR1VUTjhsTDdZanJqaUdYUisv?=
 =?utf-8?B?enp5cTZ4SEdNZWttbUVlT0cwUHJZN2dkQlM3bGwzZHlFeUtCRDd6SDdFbzBk?=
 =?utf-8?B?bVU4TjhaSVI4MGVKdVU5SG41TThxdE5DTHpNNVF3bVVRcW1tdFROWjVaeXd6?=
 =?utf-8?B?ZFBqc3lhbmNhdU9JVllBTGt3eGdJMDByQWZsdGtLTXc1SFhXMXVqWjJYYmd1?=
 =?utf-8?B?cVpMcXhhNDBScEE0MmNEMzBqaFpod0xJUDJkd01CVUdudmNSRzBPdXRaUlNL?=
 =?utf-8?B?cmRPTUxqOXk3REVzMFNjd3d6SDhEc25XZ0oxUzFqN1l4YTc4UzBWSlRidmhx?=
 =?utf-8?B?c2EvR0x0MDhoRlVyc0pSSnV2ejZFSDR2ZTB1Z2NkZ2F4dm1jWlB4ME5LaEZT?=
 =?utf-8?B?VlphT0xHV3dZbjNPMHdiaEsvc3FTakZySWhPQ1Y2aUdqTnQ4S0pwTkFrblhQ?=
 =?utf-8?B?bUE5RWVSbDVzWVFqNyt1VFJtSWRENHlQYmZlaFBLSmc3RHZVdzYzT29PMEpm?=
 =?utf-8?B?UHZJbmtYNHJ2N3lkcDR1Q0VWVlN3akRTS1ZVekxBZ2xQdFM2dDRSWFVYWDFN?=
 =?utf-8?B?dlpQVVdPRmZibTMreHhVTm1pOEg1V0krckI5OHlSeFI4YmR5ak1UR3lhd2N6?=
 =?utf-8?B?S2pSYUR3anhLZUF2NmF0dEliUHQ4UkM1Mmc3bVplYlBYYTVkVEcyN3J3YlRK?=
 =?utf-8?B?SHEwVHFSbjkyajEyWGlZV2lpQkdwNGtVaW1xakhUMkJHNHU2YmdqRmhvNmo0?=
 =?utf-8?B?Nkczcnl0cVVZdStVb2hoMUFpZytOSGozWGVuTXZBZmxFSW5vVlpwMkQveWdN?=
 =?utf-8?B?ZjdFMndONm1WRDMrbEJYMUc5NXBIQTVReE05RHZ5OXNjMVdEbXZMb2YwRXhE?=
 =?utf-8?B?K3NTSGFvU0t3anVhTElZMGNIR1FrNWNxWDZ5dlFtUWY5M2lOTDRyR2ZJcFg0?=
 =?utf-8?B?ZDRqTTF2eEcwSm5iY2s3eXhRR3M5OVViRGF0UmRjNXBFTlBUVHQ4OFRWaXBj?=
 =?utf-8?B?RzRud01BanN4T0x6K244VnpRd0N1RVhlZGZhZWwxWW5kVldNdTl2RXJIMnRF?=
 =?utf-8?B?N3NMNzlRTkMyUm9qMkFQdU5LVVRVNjZFVW5ydWYrM0kxRmR0VnN2L2Q2bXJT?=
 =?utf-8?B?REZVZFZIZXZjU2ZGd0dWNWtSNEpqRkZ4SElIN1VkcVhaMFdoOUdEU1F0VFA3?=
 =?utf-8?B?dktVcmZCVHdyRzhQeCszaUVuVTJXeTk4eS9lVTlma1dxVWlIRnBueVFnb1RR?=
 =?utf-8?B?Mk5oWFBWc1A0V0pjT05QQVlZM1d2WHB0K1cwMnZqQW84cXdzL0dsV1c3VWc4?=
 =?utf-8?B?bjJJV3UzOHdyU2dmY01uQXpLcVdwSkxJU3luM2lvdUcrbzN3VUtQVkpZR0Vt?=
 =?utf-8?B?dFBjOVY0ZEMya044MWpmWjJXOWVHRjUxVGd1RHJmMkRSNnAvNDNLMWRrcjdL?=
 =?utf-8?B?dTdaMEt5aXJZZ21OcEIzVzk0ejdnK0J1ZmJseVJIMDJEOVJBZm9DQjMzTlFN?=
 =?utf-8?B?NGozSkU0b3ozRDArRU9KSFBRVTZyM0tYWmlCMk1FL0RyWlE1WWlkenVPWmZt?=
 =?utf-8?B?Nk5SYUx0djllczgrYXBpRWZ3YmlwVm9IWW5HUUltNlZDQnZ1RTV1cjMrSlBS?=
 =?utf-8?B?ZGUzN3hBQ1BSS3RDU1BWQUp2eGZCdHVOT2s1ajZMUDZQOXgzZEI5T3k5eXh5?=
 =?utf-8?B?NSszZHQxbDFmRTVweEYzcmJQOGJNcnE2MzVMWk10WERHSkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0lpWDduRFNZOHBKdnZQTmNZZHJxTGVsMytiQWp1aGVteWdpUUc5Q2JPTG5Z?=
 =?utf-8?B?a2syTU9NenpOdVVrSHdPR0dLcHRGS1JlS3BBalZYY0F3VXhzSnBZaVpPZEdl?=
 =?utf-8?B?eHlXZkg3RXlEaXY2M1pOaXFiRmlVZzlKdTlJSDcwTmJ6OU5va3lNcjBHOWl0?=
 =?utf-8?B?K2hVNk9kaFhTSWNlMmc4VjBETVBpdElJMTVhUCt1ZEtScFRxSWdHb2x1ajBM?=
 =?utf-8?B?anIrQ1Y1dUduTDRBVDlnU2lTTXF3eHFMeGNSQkpoanlCeTBrWTJoNklEQnhl?=
 =?utf-8?B?V2NQZUtaYjhHdE1wdFVpMXRZZ05heGp4djk3djl4RDZHYUgrcTNEZTNQYzQr?=
 =?utf-8?B?aDlONVArdkU4VVAyaE14UmVLZHRReUxTdmhSYndtSEZ5MEZkMFNoZFFMN3NG?=
 =?utf-8?B?V0FSVzdtZ0prVzJyVG1EdTF3eWZiYk1zdHVYVldkS2Vkdk9xbFQ3K2hHMUtY?=
 =?utf-8?B?QkdwNFhleHg4TUd4WHBvVmRVMWxmYWFHOFFDQmJ6aVUzZGYyRlZPbFFIYTZJ?=
 =?utf-8?B?Z0daME1LUGxaQUluakxjT2JHUDRjcWJsVGJtZzM5UnpLMkVPSTIwTGpUeEkx?=
 =?utf-8?B?c3ZuanM5MVFNQTNJWExJM0tkL0kzbEtyVlZta2VielFGZlIrZEh4K3BsY3ZU?=
 =?utf-8?B?VUlOY1JVMDJqVTR6MDB3WUF2WllwTjk5VnV2Z1h3WUh3WjFmU2hWWjNBSlRj?=
 =?utf-8?B?U0U0N3Rmdk16eUpRTmJXbm1ReURTYitBcHp4RG1LZFJoQUlDeS9BMllEOWN0?=
 =?utf-8?B?R1lQd0JPMnRkZUtFMGFZSHZ1VzduRzZ1cXlUUDFjeWdFM3hCVFo4aU5nUzBO?=
 =?utf-8?B?cS9sT2pMclMyanE0cDIyU1NUVkdFRW4yMXRBdGNYaXFmbnFwNGwxamxaYmpK?=
 =?utf-8?B?Zkh5VWhTdUtKNmV4aVUyRDFmVDgrR1JjY1g1cjdpNXBZRUt2QTN1MzVhaWZQ?=
 =?utf-8?B?VENJc0pBanIvYUtaUStsaUN5RXBmV3ZNKzRIVk9qQVM2SmxWVWswTUdkTTJT?=
 =?utf-8?B?NE0xNlNCdDJHeWpYSjZaYnI2blJlQ0xJOFJ0a3ZBeVpaSFFZMzlUU1l1VGlp?=
 =?utf-8?B?R2RNVDBIbjgrNXMxeUpkZjBSU01zWE9NY3hZUmFvdlJWNEh0dzFITjVHNmcz?=
 =?utf-8?B?WFdNVTlPU1hydjl4Q0NZTXl5MGpTMEV1akRsTG9xaUhnZU0rVm1zeHJnWTRO?=
 =?utf-8?B?U20xamNvVXF2VXBOWXNUWmhEV1AxUTlhN2RXYmVGMmJkaXE2alJVR29Oa1pG?=
 =?utf-8?B?Q1UvMnE5ZksvYkZZUXFpUUE3M2duUVRVZHBjeER0eWpYbGFXaFVzTG1ESlZP?=
 =?utf-8?B?dng1RVlUV0JjaVZ0TTRKeDd1S1hQSmV3aXdSRG91Q0hsL2xHeWFYZkpUcngx?=
 =?utf-8?B?QklEMkpvN0dGYlNyWmxCTlM1dmN6dXgzNCtjTHNQSUo1S290alcrT2czMHZP?=
 =?utf-8?B?MFFJQ3pSWm5nOHppbkVuUUxHbVlxU0t1TTY1L0FmWTdia0RnMmtENG10RCtL?=
 =?utf-8?B?eHcwbXU2VXJxZWo5ZU1oUng2Ymw2M0w2SjF3dVlUNC92RlVHK0tiREtQMGhN?=
 =?utf-8?B?bkQ4YjN0NmF4eDJyR2FWZHBBUDY1amMyVldNTEVlUGkrYjRxSDhoRlVYTUFO?=
 =?utf-8?B?aEV5UU9GTyt3UnltYURyNkF3REhLcUtWZHhtYnJkTHVXb1ZjRVpuT1BvYlJs?=
 =?utf-8?B?d3diUi8rUTNsYUlmTzRGVVpMSk5yL25MTG40NjE0Q25aV21sK0JyYVhOL3FL?=
 =?utf-8?B?VytOMGhEV2NhVER2djRNZVNSVVhWZkFSTGhKRUdDOTNkWUxxN1FMRlZvcGQ0?=
 =?utf-8?B?NE94OFBKSTNrODRMeGVoY09KTGVpaW1EOFRlSlpnSnJRQXFnbVVDQmpEMnFO?=
 =?utf-8?B?eVIwY2o5NkVRMyswMEVlL3p4Qnc4cFd2NXRxdmg1RFpZYjEvZEZHWWxSY2Yz?=
 =?utf-8?B?R0JuUFhPUWVmZlV2aVh0WTVDc1FQbnVGQnovRHBBOTdIWkdRMTdORW9HajFM?=
 =?utf-8?B?Y2x6NkNGZnRGUjlEQldpSk4yUlBMbDdKYmhtbzhJcmxvL0crMFUrM2xkQTBV?=
 =?utf-8?B?QkZLY0hHL3FqeC9abUZ4N29IQUNqTmVoR20zdks0d2laRjJkb0E5UlFscWxV?=
 =?utf-8?Q?Agek2u2PQAAbu2HD2nxw8ErtV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dc0394-5097-4722-c072-08dd526b1add
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 11:30:13.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpTCtsFGFa5i0eLyJPtdViq2XOwMMVc0hOuWIgAL6IOlVRchWKVc8FKt8UnQvca8WE6kMGmbR8qGXhOTdHoQ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

On 2/19/2025 3:45 PM, Shivank Garg wrote:
> KVM's guest-memfd memory backend currently lacks support for NUMA policy
> enforcement, causing guest memory allocations to be distributed arbitrarily
> across host NUMA nodes regardless of the policy specified by the VMM. This
> occurs because conventional userspace NUMA control mechanisms like mbind()
> are ineffective with guest-memfd, as the memory isn't directly mapped to
> userspace when allocations occur.
> 
> This patch-series adds NUMA binding capabilities to guest_memfd backend
> KVM guests. It has evolved through several approaches based on community
> feedback:
> - v1,v2: Extended the KVM_CREATE_GUEST_MEMFD IOCTL to pass mempolicy.
> - v3: Introduced fbind() syscall for VMM memory-placement configuration.
> - v4,v5: Current approach using shared_policy support and vm_ops (based on
>       suggestions from David[1] and guest_memfd biweekly upstream call[2]).
> 

<--snip>

Hi All,

This patch-series was discussed during the bi-weekly guest_memfd upstream 
call on 2025-02-20 [1].

Here are my notes from the discussion:

The current design using mmap and shared_policy support with vm_ops
appears good and aligns well with how shared memory handles NUMA policy.
This makes perfect sense with upcoming changes from Fuad [2].
Integration with Fuad's work should be straightforward as my work
primarily involves set_policy and get_policy callbacks in vm_ops.
Additionally, this approach helps us avoid any fpolicy/fbind()[3]
complexity.

David mentioned documenting the behavior of setting memory policy after
memory has already been allocated. Specifically, the policy change will
only affect future allocations and will not migrate existing memory.
This matches mbind(2)'s default behavior which affects only new allocations
(unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL flags).

In the future, we may explore supporting MPOL_MF_MOVE for guest_memfd,
but for now, this behavior is sufficient and should be clearly documented.

Before sending the non-RFC version of the patch-series, I will:
- Document and clarify the memory allocation behavior after policy changes
- Write kselftests to validate NUMA policy enforcement, including edge
  cases like changing policies after memory allocation

I aim to send the updated patch-series soon. If there are any further
suggestions or concerns, please let me know.

[1] https://lore.kernel.org/linux-mm/40290a46-bcf4-4ef6-ae13-109e18ad0dfd@redhat.com
[2] https://lore.kernel.org/linux-mm/20250218172500.807733-1-tabba@google.com
[3] https://lore.kernel.org/linux-mm/20241105164549.154700-1-shivankg@amd.com

Thanks,
Shivank


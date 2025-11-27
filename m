Return-Path: <linux-fsdevel+bounces-70034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE8FC8EAD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 779BA34AAD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B283328E1;
	Thu, 27 Nov 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wvcZrZaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876893002A0;
	Thu, 27 Nov 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252216; cv=fail; b=lirSFWnaX/PkA2XnU3Odhel8Vmck27mEASRyYN9vu9JA9B0EQaNuumYpzHsPN1qjBEcuRc6qchth9SPdZArtZrAeLmOXG3tgFFSqxLmbcjWCpoDXWZM11IqYur1LBXVQRH3XqE4PJw1xKyDiQGQXyIwjrZaI6LS9u6897M64Hws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252216; c=relaxed/simple;
	bh=TInAPpanujxpRkcPp3vc0LmbV3P/Hv0RDZt87ST3neQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u1+62ZACKXXXXYWvN0SQ1kk12QHPk49a6GiCQiZmSDt551Zy+tOnsv+ILqSAzxAKXe0YqAWbyGH2QNYFC1FjzJiILLrDsdGspFH+FSNd6l662NL/nyf1cwu6PDMse7yhYdY9btwb+2QQTSENDA7MfR0cFWuMC8LW3J1u5Nt2Kqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wvcZrZaW; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvo+IKYEnz0E6gZx9iZtg5Gmg6SVIclflHr4CMUVMmTrzDQ1nSOEBHVNlo0SO+wUtqmN1UEw7jbSptkBJKNtPwP2IJmkGw9EKx7GQGPksANTdkixV2I4bxQ47HHmFOasedOJWXuC5RuhM3s0N8cWb9B/PHQA3XWgRx5LPn1gjvCqMwiKz6v4ob5nbeqo/ucd+x5DTnNnIwDPVBc5egevMTLmlWVFzFw1LDPnYJQj9UbA4k+nFju4b5GU1TqUhUgTOd92Ce6uU+X7HK1W4lzttRP4Y2e7QSB3G9pXldwbayVqx8gQv1yb2sKbNikHgM2W+AJJ8Pz3wncuVpSs6wN87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX4KDy0END5xjWVpycCPgFlsoDMsS8Ie0THXG7f5WeU=;
 b=KDlZMXxGIE8kgszWeB15AAgtXb+WcgZmbBzxlJvE5WSjHjML/aEhdjlu5livV3NG/93DsB4RhaUU1EW//H7+PS9DawWK6Tmsh29jksI5KvKRzsVaTWiRY8KOBFgTsIHNbO/1m3S1uPovBYg9V8SKVCGt+vU+zjdcz8f4OAn0P32NRd8lGsglP2dtUh9pd6JYr+PA8mxbAt6b/CqXN7eeG+Ni5yE8o+bg70PqADCT5pTNlkz97oNMlbEHOM4JnirGzuVGtxbtBgimj1z4HAC/JDIabHFcRfEBDt4FfNGCDhStJ9ygCv2PqvfAOMiAAYllRHZWj3tvpYYSS7h0Nn6yGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX4KDy0END5xjWVpycCPgFlsoDMsS8Ie0THXG7f5WeU=;
 b=wvcZrZaWk8HKJ9wsFoPhmLcT0+P1nrUe/aeTdP5A7fES4RiUS7wLJ/U8OjCpxoP/YSpe0vhHEZqpDmAqmWvHv0opU/C/Otzta/jWjtrRsT8obqz6EgPGspeDPXHr0huedkiuj8wexLk4rVYbkt8UIsDwzY6Zki5b0ndM32Pa++s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 14:03:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 14:03:24 +0000
Message-ID: <06dbd4f8-ef5f-458c-a8b4-8a8fb2a7877c@amd.com>
Date: Thu, 27 Nov 2025 15:03:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be outside
 given range
To: Matthew Wilcox <willy@infradead.org>,
 Jan Sokolowski <jan.sokolowski@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
 <aShYJta2EHh1d8az@casper.infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aShYJta2EHh1d8az@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcecc02-207c-4776-c432-08de2dbdbacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmhUUS9XZWxMa0JsbVhhNHdmYjVyWEs0dUV1QmZ0WTE2WTVleElvWXN0aEg0?=
 =?utf-8?B?TC9SazNJUzVWRDNJakE3NHBXN2NZVm9LTmlyQ0JIUms4dWFHem9SeUloWFhN?=
 =?utf-8?B?YlhHbEpxL2FEdWlBQkpHRm1oQTB1eTNVRG5IWjFkeFd4eWpyQklldTN5a2wr?=
 =?utf-8?B?L29TZGx0dmZSL1llcEo0NHZReDNsQjU4U2RZNU0zU3d1TE1jYmM3Y3loMmVD?=
 =?utf-8?B?MCtHR1VtVWNRUW04OFQvVzVQZjhIZjVDZTdFRTZLS3NMdTd5VjhnS2N2WGRS?=
 =?utf-8?B?bzNDL1ZHM0R5endDMk1VWGhtK2E0QmVXc3hjRzBpaFMwcHl0bzNZU3hySTJT?=
 =?utf-8?B?cm9BOVBHdFpQRkE2OHFMRVM2U3FJbW1JRWVlc25lUlRpL1BoaWtLNTREcWJU?=
 =?utf-8?B?YzJBbFpSUEFwTVRpTFZCbW1mM3phYW45UlBWV1BtajNMYVhZenVtTmJvUmha?=
 =?utf-8?B?TkFNbGJ3M005a2hGNk9NWExlWTNoOGhYa2lqK3FZSUZaaWFXbHgvcW1LSU5R?=
 =?utf-8?B?K3ltdHRrVmNyWlNOYlBkN21ldXJDM0JITytQL0cwVmlBTUpQeEtKZXhWV09u?=
 =?utf-8?B?YXZyelJTR29lM2Eybm80T2lNdGhvRTVwejNRalNjQVpzSFpGWThlSVd5a0w1?=
 =?utf-8?B?WGpxMFBhcGs1a0huMm93WXBxdkcrVXF5SEdIbnpxZ1M1bXlTNzZSUTQwUGNq?=
 =?utf-8?B?RmZmNFJGR1ptb2pETzI0MUc1RUV0U25aMVJ0Rml4SkJYU0kwaTA0MGs2UFVS?=
 =?utf-8?B?RW8yUkNEd2ZUQnlCcnhjWmRTMmRSK0Iwd1VoNmkvMkFFV1d0bXFsK1ZoZENL?=
 =?utf-8?B?OFQ0OXBmNGNUOTJhRzYzZUcxYUViMTB5eStjbWl2QTFWRkdHalhYWkc1Smdm?=
 =?utf-8?B?ZFNKZVNyNnJzc2JKTDVUdXFVRkhIN3d4R2dKUkdBVE5xNTNkVjNTSFdDbHFr?=
 =?utf-8?B?RlZjTFBtU0hMR2l6NHZGejd4ZDN0Z0hEejdmZ1JrWVlDalo0WGpSNFBEWkNN?=
 =?utf-8?B?RW9nZ05lUndyL2U3WWV1NjBUTUxhV2FNZElxTFEvVDN4TWhXT2hHZytxYURa?=
 =?utf-8?B?MFNrR1FIazNPQmtnR2tIbjZ3cHpDdHlVcFNZSENuVGhNTEpSeDFwMGFDVHEw?=
 =?utf-8?B?Uks5ZHdFZHR0VFFYZUNMTlc5Qk1hdTJWclpRUDVLU3lCeVRqTkQxdis1UEtu?=
 =?utf-8?B?VWwvOVZ5T3FteVdkandtRVdwMW1rVnQ2a1JWSkxSWTFHdGdaRklrdUowK1E0?=
 =?utf-8?B?M1oyRHF4MHJHMzBiTlNXUU1KemgrUHYyZmZBbFFsMjZLVEJQbk1saStvLzhQ?=
 =?utf-8?B?ejh3VEo3UGJUalVkemVCZ3BpeldTendKNDZsMnBpM3pVMmFIQWU2S1BZZkZL?=
 =?utf-8?B?cHl5Tjc0a2sxcW9zYzNpM3dZeTRDeDFUS0NkRC84WEJvTFJyWlR1MFR4Y3Vx?=
 =?utf-8?B?Q2JaRVVvRUR4Q0JsWHc1UkxOdlJ0UUtyeURqQTFxYUd0NzcwMGpDVnpKL2Jq?=
 =?utf-8?B?ZkJhUGE5anNzamF3ZnlhUTdOL0hodUhwazJ2U3VlejFhTyswUkx5Z0E1Qm45?=
 =?utf-8?B?bFRvRzVReWpHeHFIOGNYemZFbFRzVHBRRWpIN2llazZiQzFPYlRwTmNWcmUz?=
 =?utf-8?B?MmQ2aDFpRngrMzAydkJHUUlrdFVPSnE1azcwUlZ6TVFYc2RxUXFpZGRlWm9X?=
 =?utf-8?B?QnN5VEZBbnNXcXdYWlE4SXJteDZ3aHBQV2lST2RnL0NhZkVJaG5YVFZrSDJh?=
 =?utf-8?B?ZUk2OW4rTlpXR3VaYUN0VmhlQ1JESlFWdDZLR0U5N3dudmwxc09pTHBkOWlz?=
 =?utf-8?B?Wk5zYlpTQjZpeHcraCtmQ1hGSFRGeDRjNC9XeURKamJkT2xuK080eEx4djVl?=
 =?utf-8?B?NWNGTjc0T255Y1dZSGNNUmp1UzAwTGVwazZpa3lwN0Vpek5PK1FsQThJYjRF?=
 =?utf-8?Q?gwRwnRbkd+slgH8neprucUSg18vQaItm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTE3TTdyOVRnK1VvdUpGMUtGNGIrUHo5UFFVT1RDeWFUbWh6dFpKTmR3aEZw?=
 =?utf-8?B?alNkQUx1dDlIT1hPOTEzUWhGQjEwOTJ0cUMrSnZWZ1dMd3gwNmFSMEhFdTBM?=
 =?utf-8?B?VjdwM1B6bWpIdEo2N0hkR2tuVWpjYnVYVk1GQnRCMEFBazJBOUl5WFV2cHNK?=
 =?utf-8?B?di9BVWt1bzd2SzlSK3ZXdlFYYzhNQUNxZDRGZzNvWmsxbG1BdmNyazJIaXRX?=
 =?utf-8?B?SWYzaWk5aHJ2WXRRRHRGNml6Mjl2M0ZCeExhSGIxL0F1dFlzczEzVHIyeUYz?=
 =?utf-8?B?S2JtdkNnayswRk40YzRrSUgraDJFY292S3B0UnJuOGQ2bXNhakg1aHRkVVJ1?=
 =?utf-8?B?TmFOTXp6TGFUWTNxVytJejU3amwxRmg5YjVkV0hXNHJXb0N2YlNqVzBjaEMw?=
 =?utf-8?B?Y0J1cU9NK29aNWM3M2dYSFhMQTZUcDFIcmdDdVBHbm02VWsxM3dkSWxqYUdU?=
 =?utf-8?B?S3RFMW9lblVHYVZoL2p4aXRnaDlwVUExNzhoVzhmU3NUbkFYaGZYWjYrREUw?=
 =?utf-8?B?K3RyNUJVZ25BU2NxTkJNL1p6eWtxZFB6eWlVaXhzaEtvakJiUno2MHNVUUY0?=
 =?utf-8?B?aml4Qjc0THJxRXU1dXd6RVo0cUlpdHFFUS84Qjk3Ri8rTmNCZ2JQbUhoSW9o?=
 =?utf-8?B?dmhpMWliNkJUR2Q1NHZUNnZTL20rVlZhc0ZiQXZzUTFSZFFWKzNFTlZSL3NV?=
 =?utf-8?B?NURrRTBPUkkwWDRJVVo3bmRhSnVkRVZkUFpuZno3N1paVFRDL0tFa2E1V1Zi?=
 =?utf-8?B?WUs4ZFYxRjh5YmRXSFJRMmlBOHVqbjd3YTJnUGVjVHpqWG5USjVkVzR4RFVw?=
 =?utf-8?B?OXgrcS9MTjJUbUFFSkFiT09TUGhkV2hNQms3eGJBZEZtSUQxOE8zRmlJbTIz?=
 =?utf-8?B?aW81RERnMjhXNC9ZMCtHY2o4SDV4RFFGSDlKaEgweUdOSjNMUHBJeU00Z3pt?=
 =?utf-8?B?TTg3eW9wb0l5dlh1cVNIZnRTKzVzNkxDNFdhMUZ4R1lnZi9BdU1PeDNULzYv?=
 =?utf-8?B?VFV5bGVNR1J6WHJHZ2l3VFRCenFackVQcVRWYWVhY2dVRlRHUWJCWk4wcERv?=
 =?utf-8?B?RXRtaGtENWxDdDB3M3hlTk1ObzEwWVpJOFFxMEQ4MUtKZHREUVJ0NlpYVG9z?=
 =?utf-8?B?NURJSzJwZ2VBZzdldG9COW5qMzRxbmkrRS9uSFNQVlVOMTFVdDVqNm94SmF4?=
 =?utf-8?B?R3poSERPY0phdG40dE05ejdvVE84aXJTYW96dTZTZCtWZXlSZlNoTVpiZmxC?=
 =?utf-8?B?dWlyMVUyZUc1bHhVdlFhcUNhblhkZzZ4NGU4eFRjdjIyeGRuOWNucjBjbGRI?=
 =?utf-8?B?akRYWTR0R01hMThkSzB3OE1vamErZTZuS1pjRXFBWTBJdXlQakUwRVdRankw?=
 =?utf-8?B?SW5HY3N1TzNCMW9UK2dDMGM4OXZzSjNQYUhEaTR1a3ZnaXNuZzFoV3BhRmdF?=
 =?utf-8?B?Z3ZCTVJUZDRiclEySmgzbFNUMEpoVG9JOGN0OE1mdXdGNDAzL2FqZWtVcC80?=
 =?utf-8?B?Y2tNQ0pScFB6WWtvVXdpbTFvblhQNWhoYmU0WmwvL2U2aGxGajJzenpXb05o?=
 =?utf-8?B?Lyt0UTZEeUZocm82MnZCUCtaa1lVejFIako2K0lncWs5VHBSbWFQay9mamtD?=
 =?utf-8?B?MzZMRThjbWl2SVg4TndJdkpNK3Z0TlMvZ2UzNVVzVktjbjVhMEVJalFUUmpD?=
 =?utf-8?B?czdQUEE2WHlReXdsYTRCSDZwQmV5aSsyYktoYW9zZlZLMmhVSnp5V3huU0FY?=
 =?utf-8?B?bGVxQjBuWnZFVllORDFwbGpLMk1RUFpzZGpxaDBxWFp6dU94ZThrWEtUenFV?=
 =?utf-8?B?NVlweGFVTmNJNEFXYTV5eURYVmZxWnpmYzBiOFlEUUlwQk02Qnh1VUpTYVlF?=
 =?utf-8?B?ZFl1ZEZQU2lxKzZkQnhnNVNzNnllM2JjcGpybTIxaTJMNHdJa29QQXRDemhY?=
 =?utf-8?B?SUlWcEZOSEg4TlpXNTBYcml5UW1Yb2E3K0ludW1USE1LNis2bXVSOUdlYmVB?=
 =?utf-8?B?R014dGZIRUMvY052Vk41Sk1GejdNWlhYdGxpelQrWTZteHhWSnhRQW9UOHRQ?=
 =?utf-8?B?aGV6a3FaMGdaY0JsaVRGelpLZDE2SW55cTdkZW8zbCtJOFlUcXQxTzFJOWJL?=
 =?utf-8?Q?8uyQI4+w/E2W/I/q/y1Y8OTZ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcecc02-207c-4776-c432-08de2dbdbacf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:03:24.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzBX9/K2F6TWvfWnES6u6MsCFdi3iDWDC4JAgFOz5/zyh96aC01BPt9WwiIzvNEp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548

On 11/27/25 14:54, Matthew Wilcox wrote:
> On Thu, Nov 27, 2025 at 10:27:32AM +0100, Jan Sokolowski wrote:
>> A scenario was found where trying to add id in range 0,1
>> would return an id of 2, which is outside the range and thus
>> now what the user would expect.
> 
> Can you do a bit better with this bug report?  Under what circumstances
> does this happen?  Preferably answer in the form of a test case for the
> IDR test suite.  Here's my attempt to recreate your situation based on
> what I read in that thread.  It doesn't show a problem, so clearly I got
> something wrong.

According to Jan the observation he has is that this code:

idr_init_base(&idr, 1);
id = idr_alloc(&idr, dummy_ptr, 0, 1, GFP_KERNEL);

Gives him id=2 in return.

That clearly seems to be problematic considering that start=0 and end=1 should either give you id=0 or an error because idr->idr_base should be initialized to 1.

But I'm still not sure if Jan's observation is actually correct, cause I also don't see how that possible happen.

Regards,
Christian.

> To run the test suite, apply this patch, then
> 
> $ make -C tools/testing/radix-tree
> $ ./tools/testing/radix-tree/idr-test
> 
> diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
> index 2f830ff8396c..774c0c9c141f 100644
> --- a/tools/testing/radix-tree/idr-test.c
> +++ b/tools/testing/radix-tree/idr-test.c
> @@ -57,6 +57,21 @@ void idr_alloc_test(void)
>  	idr_destroy(&idr);
>  }
>  
> +void idr_alloc2_test(void)
> +{
> +	int id;
> +	DEFINE_IDR(idr);
> +
> +	id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
> +	printf("id = %d\n", id);
> +	assert(id == 0);
> +	id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
> +	printf("id = %d\n", id);
> +	assert(id == -ENOSPC);
> +
> +	idr_destroy(&idr);
> +}
> +
>  void idr_replace_test(void)
>  {
>  	DEFINE_IDR(idr);
> @@ -409,6 +424,7 @@ void idr_checks(void)
>  
>  	idr_replace_test();
>  	idr_alloc_test();
> +	idr_alloc2_test();
>  	idr_null_test();
>  	idr_nowait_test();
>  	idr_get_next_test(0);



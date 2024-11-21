Return-Path: <linux-fsdevel+bounces-35468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9244D9D51EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C87282B53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCA1B5829;
	Thu, 21 Nov 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0pXH3IpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84C14A0AA;
	Thu, 21 Nov 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210872; cv=fail; b=UmQQ5IZ59Szkp4y4qnP0OdAT6z4GMtEijUyq7u+ajrLqGyVsyF/J87yS8pkS30CeKXjeRfnRxR3dEIek4aWq1Hz4XN+Vkt6nKu4lxQYliqqU1Me+F+E5q7YvSyl2+JQNrPg5gNhQvTEIGrsQHu9B96BbR+VlPk02aRLMe/7y5A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210872; c=relaxed/simple;
	bh=hgHYMGzqlVOL6b5SE2Ngt5G8SulbSU9A9XbTBATlyLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mazp2ls6lJup5S/C2YpZmfQHNkmot9nJ1NLDsuEpe8iS2xbaD2D729kGn9n2OUxCAtlze8feTJoS8vaNZRByAWR2+OuOlk1LzQixaMAfrpBWC5X1Y3Ij24Fcw5th6KbDlbcdMU+bp3m2PqZksvak77OcqUzs7+uqhE1VkX52NnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0pXH3IpD; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ1SeCbIOQTVrqS9D/Kkqb7lqAERgcs4as3a01+JkjusKYGSiqVCZNr6EgFo9kVDyeDHXOU3nG7a+B2rS+Z5z4mUB4MFAOOaPs0e/NweAJr30pTYvxjvxhjDx0NNK0vufezDyY/1CnwOE16rJ056fNYI06CLOOe6RxIyvuZvM2VTiYoHNC3dFicohjRo4H3zD7cAg8vO6OYkFmbXdZ/vpRuWGb08cFuDSkMDMI4lTBICXrvDaIzBspG+vbVaZ/DDndUjgQxRaFqWTihgO02DV0F9q4oJj7eshy5q/Ol/ireO9uCOVs/AdvPuI8N42T3fZDQk6ULt5EkU08sB9VelJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KYKNqy7E/KjLUfL3f4YWBhR9uhHzR+m5sV5BOlIds8=;
 b=kDccM2rbj/+sNmYmh2rmtTWC6DMi6Z0jjes7fwGlLIIX14R0xoYw2KA1LYpyYvHfmKE2gJIdNFzeKy0WohG9AnxWlaQaDpthjkoZgKDWz+wPSjFXLX3PeqX7UJ8JLH2D3SXHOEzbwucokk5BQPKsuNoW/Jp4Su11k5rlwWJewu7BrBUYDDVUttHR0o0ZxAzjHeUgT+6BLUHpJBvEeAgOkjEZv6ilL5ezZZSiyf6PpDjv24dhFFTO7tBTOqXpUc6jjtnMe3Gh0H/bdERDuNWvkULHJ3iHXhsOzgz6F20YEeCwJF4b/KcHY9ABNADmRHIN/71iHCa9iiwzYAyOzbzb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KYKNqy7E/KjLUfL3f4YWBhR9uhHzR+m5sV5BOlIds8=;
 b=0pXH3IpDGxXymef6a+/+uBzDb9AfVMDKhmsRaThdOqwX5ayjXWpwNRgNonlKfSgDLv9n/PIGduT+tVn8hNG11qVVU4eipPsktF5oCEXMUCW5SuhqrhcFvOlQTkIPtNWTO3AUpJRb21+KPhUcaWKZ38jCuXyd0QVT8jeOGRLXoMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 21 Nov
 2024 17:41:05 +0000
Received: from PH7PR12MB5688.namprd12.prod.outlook.com
 ([fe80::b26b:9164:45e2:22d5]) by PH7PR12MB5688.namprd12.prod.outlook.com
 ([fe80::b26b:9164:45e2:22d5%4]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 17:41:05 +0000
Message-ID: <3349f838-2c73-4ef0-aa30-a21e41fb39e5@amd.com>
Date: Thu, 21 Nov 2024 11:40:59 -0600
User-Agent: Mozilla Thunderbird
Reply-To: michael.day@amd.com
Subject: Re: [PATCH v4 2/2] mm: guestmem: Convert address_space operations to
 guestmem library
To: Elliot Berman <quic_eberman@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: James Gowans <jgowans@amazon.com>, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org,
 devel@lists.orangefs.org, linux-arm-kernel@lists.infradead.org
References: <20241120-guestmem-library-v4-0-0c597f733909@quicinc.com>
 <20241120-guestmem-library-v4-2-0c597f733909@quicinc.com>
 <20241120145527130-0800.eberman@hu-eberman-lv.qualcomm.com>
From: Mike Day <michael.day@amd.com>
Content-Language: en-US
In-Reply-To: <20241120145527130-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:806:126::27) To PH7PR12MB5688.namprd12.prod.outlook.com
 (2603:10b6:510:130::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5688:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d24925-1af3-4fce-28be-08dd0a53aca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE1CaE9XR08vS2o0YXROeTNiNWM2aGJpeTNRbHhLTndPbGtyQWZEcXd4Tk05?=
 =?utf-8?B?eUZTOE1qcXBVaFR3eVY4dkJtQXRwVnNpUWc0YzFlZEgwNDJGZHdKVDUwTzU2?=
 =?utf-8?B?RUFwWTdScmd3dnJNczAzNi9RQldDM3Z6SUQ4SEZLSlpXdUdzMzYvR09FUWc5?=
 =?utf-8?B?SGh2QlNrNVQrdWRvVGdvejEvY3dWNTQ1ZnlZYkJkOUlhTWNuN3ExcjJJTlVN?=
 =?utf-8?B?TmdNalJuVnk2cXdiL2I5RTAzN2ZkOTNCckF1TlVRa1dabEJOTDhzdGN1Uk9Y?=
 =?utf-8?B?ZEE3a0I0V3FVMkFzYnQ2UkplOHlkNjg1SUk2aW5CaDJXbEpSbzJIZ3htQjM2?=
 =?utf-8?B?TnhXUmRJT28xNVA0U2IvT1JaTVYrcnBSbTB4emN6UWFhbzhhYWdqak44aW52?=
 =?utf-8?B?YTFwTWhacDRsS3c4Y0VUS0ordjFUTnUzd2N2VXM4ODNJakN5alhSeTBoNUVo?=
 =?utf-8?B?UFRZTUxkVnQ3NlZnTFdLT0N1WXJIdWRxNmZlaEw0bkU3N3pUeEF2N1JRSWFX?=
 =?utf-8?B?K1UzLzZuOGdoWHkrb29Eenhtelo1NzZJS3h4aWdrNFN6b1BHa2RwQ3V4OENJ?=
 =?utf-8?B?MkpkTC9KbUw5aTBGd3l2QVg5QTVTckp0cDcyN1lVdUQrNzVteTJRNUxqS2Ri?=
 =?utf-8?B?VC9SczRpYkNMeXh4SFd4MnF6K3AvOU9WbEE0cEVOQ0J0c3VENTNSQXpIMVhX?=
 =?utf-8?B?Uzd5cjZ2aUdNLzI1a1VZRk5kQzVzSVJ6T0JxOFQzelFaNzN3R1AvWEh0bGdr?=
 =?utf-8?B?eSsxWnNFa3ZkK2h1TVdYeG9IV0dORGlGb1FxVDJTVHYreDNob1FIci9pYS9r?=
 =?utf-8?B?VDkyS2pXVGl1a1NST3pjV0RISFlDZVlwcVBjV1cxVW50ODBXWHoxTjBHK0Jp?=
 =?utf-8?B?bDc4YU5KTUZDbnFQakZaL3haWlE0SUdJLytweFZLdUhKbHk2SUYrQmhSbUJs?=
 =?utf-8?B?N0lsWE1iaTVoUkNvWHUxcVdkK3pUUGx5ZS9OaE9lTG5RM3F0MCtPd1ZRU3dj?=
 =?utf-8?B?a2tPSHJXU3dXd0JtUktnblRrbUtlYVlLQ2sxM0RtbEZrcFBMWlZ1c2Qwdldp?=
 =?utf-8?B?YWRrblQ3dGxmRWFyT3JvcXc2eW9CZnpTY0xicy9BMjc1U0xoaElLVlNBN3NO?=
 =?utf-8?B?VGxBdDhGL0pray9tcld0K0xwSitQMGFZYmNZUzYrdEhmN2dESTlJRDZMNldD?=
 =?utf-8?B?V1MvZ25TdWY1dDFNOUt2M0N5L1QvOFJ1c0pnZndiMFlXRlNyRWRndFdDQzBm?=
 =?utf-8?B?disrVWhuaS85SThMTXVBQzE3LzRhS1BBMmxtejg2bUdsNS9EeEtXcWFKZEZD?=
 =?utf-8?B?ZnVNdXVPSFdjN1ZabklNVHl5Mm5UUVdlTzRCdTNPZ2Uvai9UWHVack93dVYz?=
 =?utf-8?B?MXhpTTN0bUNFOC80d281UkRtZ3VXaHJmL29KaXFqV01oT1BVQ0dPVURpdnNh?=
 =?utf-8?B?c0Z4c05XeStPZjBlbGVMS2Vjc1M1NnFZenF2amN6S04velRpNDJ5WWFQTXhn?=
 =?utf-8?B?bTdPTnpsOEQ5RHo0MFZmSTJ6Z0Vja2U4UEpoQjRYSXFqZ2dRdmVteTBPNUd0?=
 =?utf-8?B?WEt3aFZldU8rTGJiVEpDcTZjdHpqaWdLdVVxUXdNcGx2aGV2bmpydmxXd3R5?=
 =?utf-8?B?Nkh0dFdrZUlBalhKcGZuZWI2TU8xdjV6TytpVVgvTVREck93cUVna1FrUU5z?=
 =?utf-8?B?WkdnNnBuUlExSUhEaVhyYVpSc0xDaGowK1dlTXdlSWJEQ2dtVkRwcUFPYzJq?=
 =?utf-8?B?QnVYQWk1ckpLZ0Q5UkxzNURqRTI3b1BabTRpeGlMWWhXV0lWaXRJR3NvM3JR?=
 =?utf-8?Q?QWDTUos/OPIRU75kj3ZcZPLrb4cFSoLGeoQFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0wzaVVzcDBXMU1SUUhvQXNIeHlUQkYxTjI4VXIzZUkzL2ZiZmxzdFBMa0NS?=
 =?utf-8?B?ODNTaC9YeEdVQ2xFZmNUbkY3azlBZ250dEluT2d6Y2dsMlQ2eVFxWEZrT3Iy?=
 =?utf-8?B?eHN1OXN5aGZGWkNJWVR1T2xCd2NCN0N6cVNyTUs5WTkyYTBlQmN5MStKeHBk?=
 =?utf-8?B?T1FGT3IwSDFjRThWRUdLQzlOM3pya1I5bkJnWlFzVHNKK016bXduYytSTExT?=
 =?utf-8?B?YjdZVEdJK0Q4bU1ZZnNicnIxc3MyOTZlQUFjR2hJVTIxMW9zUUt6UmdYYWM2?=
 =?utf-8?B?Y3hrdDZRS3NKVXBVeWhobWZnMzhpaXRKRmM4b1EvUFRMT1Rkb3M3U1d4bnVB?=
 =?utf-8?B?TW9MQWU1WmhqT3BCVjN4UkJLYzhuTzIvcS9tVDdCTEMwU2NUYWxTSXhlQ1ov?=
 =?utf-8?B?TXdsK09HRmJqQThLcWQzWjhEL1hwOUNFVi9VVnltTGtHWWtFTWJGcGliR0tZ?=
 =?utf-8?B?Y3NsWDU5R28zbWxtUGFWbktkT0NXSXZnYjdiNkkrS0lpT2k2RVJzekJwNTBP?=
 =?utf-8?B?czY2WXpSVzZ6MTg5ZVViSEg5RFpaT0xiNVlIOE5pd3NpdXpaRkFxV3dsZ0x2?=
 =?utf-8?B?dFVQQ2I4S2hjbkcra2RzSWc2cTFkTWFTVlp1dm9oMm05eTgxZGxaMmxINnI0?=
 =?utf-8?B?Z0R3bVhUSEw0aERrbVNwZms4VVh3YkRRQWJBb1YxWVRqTXZCZmhJNHRNRU5C?=
 =?utf-8?B?dFZuc3JTUytpMHdscVdQZEI1RlRyUzRNN1NaTFl0WlNOWUFqMnNSajllQzIy?=
 =?utf-8?B?V0F3R05RM04rZGtoZVlYZ1FyeVlhV2ZYeTdDVDJtYmdnZUpnRDE0bG1ucG9H?=
 =?utf-8?B?WTlVNGtqQUlESFpSV2pVM2NpRVFhTnQ4OTB0a29jWloreVNMdW5DVjN6ckZC?=
 =?utf-8?B?UVdrU3JRSVJBc1V5T3dGOXFMOWpMMFliRDFVc3RpNG5zMmV5UFFXZDExc2FL?=
 =?utf-8?B?SFIycHZ5YS9ia0pCVzlDd3RGNlNxQzFMZWJ2ai9CYVlKSWtJMldQNmQ5NS9r?=
 =?utf-8?B?ZTVNeUNhVFUrWmVFY1AvanpyL2ZBdWhQOVRzdE4wRm1ydVU4eWNvTXR3VEI2?=
 =?utf-8?B?RC9RSmZpOVdSSjkrSmsveEZqSXV6ZGZSVSt5MFl4ZUpmVEQzM3kxRW5EMDJl?=
 =?utf-8?B?VUIrb2pMSlJDOEVWd2dnT0h6T1BPMmlqQlpRaDI3UDl4SVlkSzR6MC8vRWF3?=
 =?utf-8?B?QUsxTGJ2WWdPY1NwOWlBSXJDYVBBQkYwUFgwWHlnWnQzTDVOSG1xV3paWFhD?=
 =?utf-8?B?SGJ3YnJmRkkvSUlvWGp2eUtoQW05NWp2Q0NvTGYwYS9GaTVPek0vcm9NSUx5?=
 =?utf-8?B?cDYxdGxHNm4ya0M5MEhBeWptcTU1ZmtPSGNzT2xxdjJXaGVsNkpTb1VFV2hJ?=
 =?utf-8?B?dWdzWEk5bXFKc0g3b0dwYjlHLzR1Q05mVVp4WnRDVTJkbmxqTlhDYW9kZEpp?=
 =?utf-8?B?QlE1SFNHckdCQXZCZ2k1UG01RFA2SEFqTzIzL0ZoR2x2L3AyWWJHUkVyazc3?=
 =?utf-8?B?Z0NrVDZQWDBkZTZvVnJudG1nT0RSSlg1ZXhoQ3VVNEdBYkdCQ2hEZVArbjFu?=
 =?utf-8?B?YVV4bFl4YjJLV2Z1ZDgwT3JYUHFRT1QrLzR3TWptTjQweGhBQWk2bE1NcG1t?=
 =?utf-8?B?ZHU3dEhPSEpmNlpwMzdQMjVCaWZsZG5KMHovT2NUaHMzamQyTE5zeWw5ZE1t?=
 =?utf-8?B?elRPQVo4aG43MldQM0tiN0NVMDZ6NG9YcVBheDlLbWxJbXltblBOZzBRdGVW?=
 =?utf-8?B?eVozdWZFNVhpZ0hWalNVQVlVQUZFU2hTMnNyck9MUU1ucmxBbWlKUnVRZFAz?=
 =?utf-8?B?OUhITjQwUjBqV0lTWmRxWUI5MFdmaXdtaWdjTjB0Tlp6V2ZTeTFIVE9rdDZ2?=
 =?utf-8?B?MDlDSG0rc1dsVFpCM0xSU0dpaEk5WVZUamN1NThvaGFteWNTRmhOeUR5K1RK?=
 =?utf-8?B?bjJaOW1BUk1WZEV5bFFTa2ZZSWorSGZLb3lEZXZuSGZKTWp1MXpBRi9NUWhS?=
 =?utf-8?B?Rzd1MkdpU1hxdDNxMS9OTGZHdENBOTdMekxGWGliQ051aEZ6QmpuNS9yTm45?=
 =?utf-8?B?YVdPY29HUWp0YmRwZy94UmVlRDBraDJwd3hiRzVYanNCcHczQXJPaXJZbUxw?=
 =?utf-8?Q?TdRhmKLjlR09J6VYy1qb/qJPU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d24925-1af3-4fce-28be-08dd0a53aca4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 17:41:05.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjmtJeAEzUR4+YVuEiNIHvG+QftzPuFGv4cBjTJxmormRISgzElmVJC0/+DvMWlRanA9f0UizPbetDv8PNR4mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438



On 11/21/24 10:43, Elliot Berman wrote:
> On Wed, Nov 20, 2024 at 10:12:08AM -0800, Elliot Berman wrote:
>> diff --git a/mm/guestmem.c b/mm/guestmem.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..19dd7e5d498f07577ec5cec5b52055f7435980f4
>> --- /dev/null
>> +++ b/mm/guestmem.c
>> @@ -0,0 +1,196 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * guestmem library
>> + *
>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/fs.h>
>> +#include <linux/guestmem.h>
>> +#include <linux/mm.h>
>> +#include <linux/pagemap.h>
>> +
>> +struct guestmem {
>> +	const struct guestmem_ops *ops;
>> +};
>> +
>> +static inline struct guestmem *folio_to_guestmem(struct folio *folio)
>> +{
>> +	struct address_space *mapping = folio->mapping;
>> +
>> +	return mapping->i_private_data;
>> +}
>> +
>> +static inline bool __guestmem_release_folio(struct address_space *mapping,
>> +					    struct folio *folio)
>> +{
>> +	struct guestmem *gmem = mapping->i_private_data;
>> +	struct list_head *entry;
>> +
>> +	if (gmem->ops->release_folio) {
>> +		list_for_each(entry, &mapping->i_private_list) {
>> +			if (!gmem->ops->release_folio(entry, folio))
>> +				return false;
>> +		}
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static inline int
>> +__guestmem_invalidate_begin(struct address_space *const mapping, pgoff_t start,
>> +			    pgoff_t end)
>> +{
>> +	struct guestmem *gmem = mapping->i_private_data;
>> +	struct list_head *entry;
>> +	int ret = 0;
>> +
>> +	list_for_each(entry, &mapping->i_private_list) {
>> +		ret = gmem->ops->invalidate_begin(entry, start, end);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void
>> +__guestmem_invalidate_end(struct address_space *const mapping, pgoff_t start,
>> +			  pgoff_t end)
>> +{
>> +	struct guestmem *gmem = mapping->i_private_data;
>> +	struct list_head *entry;
>> +
>> +	if (gmem->ops->invalidate_end) {
>> +		list_for_each(entry, &mapping->i_private_list)
>> +			gmem->ops->invalidate_end(entry, start, end);
>> +	}
>> +}
>> +
>> +static void guestmem_free_folio(struct address_space *mapping,
>> +				struct folio *folio)
>> +{
>> +	WARN_ON_ONCE(!__guestmem_release_folio(mapping, folio));
>> +}
>> +
>> +static int guestmem_error_folio(struct address_space *mapping,
>> +				struct folio *folio)
>> +{
>> +	pgoff_t start, end;
>> +	int ret;
>> +
>> +	filemap_invalidate_lock_shared(mapping);
>> +
>> +	start = folio->index;
>> +	end = start + folio_nr_pages(folio);
>> +
>> +	ret = __guestmem_invalidate_begin(mapping, start, end);
>> +	if (ret)
>> +		goto out;
>> +
>> +	/*
>> +	 * Do not truncate the range, what action is taken in response to the
>> +	 * error is userspace's decision (assuming the architecture supports
>> +	 * gracefully handling memory errors).  If/when the guest attempts to
>> +	 * access a poisoned page, kvm_gmem_get_pfn() will return -EHWPOISON,
>> +	 * at which point KVM can either terminate the VM or propagate the
>> +	 * error to userspace.
>> +	 */
>> +
>> +	__guestmem_invalidate_end(mapping, start, end);
>> +
>> +out:
>> +	filemap_invalidate_unlock_shared(mapping);
>> +	return ret ? MF_DELAYED : MF_FAILED;
>> +}
>> +
>> +static int guestmem_migrate_folio(struct address_space *mapping,
>> +				  struct folio *dst, struct folio *src,
>> +				  enum migrate_mode mode)
>> +{
>> +	WARN_ON_ONCE(1);
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct address_space_operations guestmem_aops = {
>> +	.dirty_folio = noop_dirty_folio,
>> +	.free_folio = guestmem_free_folio,
>> +	.error_remove_folio = guestmem_error_folio,
>> +	.migrate_folio = guestmem_migrate_folio,
>> +};
>> +
>> +int guestmem_attach_mapping(struct address_space *mapping,
>> +			    const struct guestmem_ops *const ops,
>> +			    struct list_head *data)
>> +{
>> +	struct guestmem *gmem;
>> +
>> +	if (mapping->a_ops == &guestmem_aops) {
>> +		gmem = mapping->i_private_data;
>> +		if (gmem->ops != ops)
>> +			return -EINVAL;
>> +
>> +		goto add;
>> +	}
>> +
>> +	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
>> +	if (!gmem)
>> +		return -ENOMEM;
>> +
>> +	gmem->ops = ops;
>> +
>> +	mapping->a_ops = &guestmem_aops;
>> +	mapping->i_private_data = gmem;
>> +
>> +	mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
>> +	mapping_set_inaccessible(mapping);
>> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
>> +	WARN_ON_ONCE(!mapping_unevictable(mapping));
>> +
>> +add:
>> +	list_add(data, &mapping->i_private_list);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(guestmem_attach_mapping);
>> +
>> +void guestmem_detach_mapping(struct address_space *mapping,
>> +			     struct list_head *data)
>> +{
>> +	list_del(data);
>> +
>> +	if (list_empty(&mapping->i_private_list)) {
>> +		kfree(mapping->i_private_data);
> 
> Mike was helping me test this out for SEV-SNP. They helped find a bug
> here. Right now, when the file closes, KVM calls
> guestmem_detach_mapping() which will uninstall the ops. When that
> happens, it's not necessary that all of the folios aren't removed from
> the filemap yet and so our free_folio() callback isn't invoked. This
> means that we skip updating the RMP entry back to shared/KVM-owned.
> 
> There are a few approaches I could take:
> 
> 1. Create a guestmem superblock so I can register guestmem-specific
>     destroy_inode() to do the kfree() above. This requires a lot of
>     boilerplate code, and I think it's not preferred approach.
> 2. Update how KVM tracks the memory so it is back in "shared" state when
>     the file closes. This requires some significant rework about the page
>     state compared to current guest_memfd. That rework might be useful
>     for the shared/private state machine.
> 3. Call truncate_inode_pages(mapping, 0) to force pages to be freed
>     here. It's might be possible that a page is allocated after this
>     point. In order for that to be a problem, KVM would need to update
>     RMP entry as guest-owned, and I don't believe that's possible after
>     the last guestmem_detach_mapping().
> 
> My preference is to go with #3 as it was the most easy thing to do.

#3 is my preference as well. The semantics are that the guest is "closing" the gmem
object, which means all the memory is being released from the guest.

Mike
> 
>> +		mapping->i_private_data = NULL;
>> +		mapping->a_ops = &empty_aops;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(guestmem_detach_mapping);
>> +
>> +struct folio *guestmem_grab_folio(struct address_space *mapping, pgoff_t index)
>> +{
>> +	/* TODO: Support huge pages. */
>> +	return filemap_grab_folio(mapping, index);
>> +}
>> +EXPORT_SYMBOL_GPL(guestmem_grab_folio);
>> +
>> +int guestmem_punch_hole(struct address_space *mapping, loff_t offset,
>> +			loff_t len)
>> +{
>> +	pgoff_t start = offset >> PAGE_SHIFT;
>> +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>> +	int ret;
>> +
>> +	filemap_invalidate_lock(mapping);
>> +	ret = __guestmem_invalidate_begin(mapping, start, end);
>> +	if (ret)
>> +		goto out;
>> +
>> +	truncate_inode_pages_range(mapping, offset, offset + len - 1);
>> +
>> +	__guestmem_invalidate_end(mapping, start, end);
>> +
>> +out:
>> +	filemap_invalidate_unlock(mapping);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(guestmem_punch_hole);
>> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
>> index fd6a3010afa833e077623065b80bdbb5b1012250..1339098795d2e859b2ee0ef419b29045aedc8487 100644
>> --- a/virt/kvm/Kconfig
>> +++ b/virt/kvm/Kconfig
>> @@ -106,6 +106,7 @@ config KVM_GENERIC_MEMORY_ATTRIBUTES
>>   
>>   config KVM_PRIVATE_MEM
>>          select XARRAY_MULTI
>> +       select GUESTMEM
>>          bool
>>   
>>   config KVM_GENERIC_PRIVATE_MEM
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 24dcbad0cb76e353509cf4718837a1999f093414..edf57d5662cb8634bbd9ca3118b293c4f7ca229a 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <linux/backing-dev.h>
>>   #include <linux/falloc.h>
>> +#include <linux/guestmem.h>
>>   #include <linux/kvm_host.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/anon_inodes.h>
>> @@ -98,8 +99,7 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>    */
>>   static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>>   {
>> -	/* TODO: Support huge pages. */
>> -	return filemap_grab_folio(inode->i_mapping, index);
>> +	return guestmem_grab_folio(inode->i_mapping, index);
>>   }
>>   
>>   static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>> @@ -151,28 +151,7 @@ static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
>>   
>>   static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>   {
>> -	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
>> -	pgoff_t start = offset >> PAGE_SHIFT;
>> -	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>> -	struct kvm_gmem *gmem;
>> -
>> -	/*
>> -	 * Bindings must be stable across invalidation to ensure the start+end
>> -	 * are balanced.
>> -	 */
>> -	filemap_invalidate_lock(inode->i_mapping);
>> -
>> -	list_for_each_entry(gmem, gmem_list, entry)
>> -		kvm_gmem_invalidate_begin(gmem, start, end);
>> -
>> -	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
>> -
>> -	list_for_each_entry(gmem, gmem_list, entry)
>> -		kvm_gmem_invalidate_end(gmem, start, end);
>> -
>> -	filemap_invalidate_unlock(inode->i_mapping);
>> -
>> -	return 0;
>> +	return guestmem_punch_hole(inode->i_mapping, offset, len);
>>   }
>>   
>>   static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
>> @@ -277,7 +256,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
>>   	kvm_gmem_invalidate_begin(gmem, 0, -1ul);
>>   	kvm_gmem_invalidate_end(gmem, 0, -1ul);
>>   
>> -	list_del(&gmem->entry);
>> +	guestmem_detach_mapping(inode->i_mapping, &gmem->entry);
>>   
>>   	filemap_invalidate_unlock(inode->i_mapping);
>>   
>> @@ -318,63 +297,42 @@ void kvm_gmem_init(struct module *module)
>>   	kvm_gmem_fops.owner = module;
>>   }
>>   
>> -static int kvm_gmem_migrate_folio(struct address_space *mapping,
>> -				  struct folio *dst, struct folio *src,
>> -				  enum migrate_mode mode)
>> +static int kvm_guestmem_invalidate_begin(struct list_head *entry, pgoff_t start,
>> +					 pgoff_t end)
>>   {
>> -	WARN_ON_ONCE(1);
>> -	return -EINVAL;
>> -}
>> +	struct kvm_gmem *gmem = container_of(entry, struct kvm_gmem, entry);
>>   
>> -static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
>> -{
>> -	struct list_head *gmem_list = &mapping->i_private_list;
>> -	struct kvm_gmem *gmem;
>> -	pgoff_t start, end;
>> -
>> -	filemap_invalidate_lock_shared(mapping);
>> -
>> -	start = folio->index;
>> -	end = start + folio_nr_pages(folio);
>> -
>> -	list_for_each_entry(gmem, gmem_list, entry)
>> -		kvm_gmem_invalidate_begin(gmem, start, end);
>> -
>> -	/*
>> -	 * Do not truncate the range, what action is taken in response to the
>> -	 * error is userspace's decision (assuming the architecture supports
>> -	 * gracefully handling memory errors).  If/when the guest attempts to
>> -	 * access a poisoned page, kvm_gmem_get_pfn() will return -EHWPOISON,
>> -	 * at which point KVM can either terminate the VM or propagate the
>> -	 * error to userspace.
>> -	 */
>> +	kvm_gmem_invalidate_begin(gmem, start, end);
>>   
>> -	list_for_each_entry(gmem, gmem_list, entry)
>> -		kvm_gmem_invalidate_end(gmem, start, end);
>> +	return 0;
>> +}
>>   
>> -	filemap_invalidate_unlock_shared(mapping);
>> +static void kvm_guestmem_invalidate_end(struct list_head *entry, pgoff_t start,
>> +					pgoff_t end)
>> +{
>> +	struct kvm_gmem *gmem = container_of(entry, struct kvm_gmem, entry);
>>   
>> -	return MF_DELAYED;
>> +	kvm_gmem_invalidate_end(gmem, start, end);
>>   }
>>   
>>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> -static void kvm_gmem_free_folio(struct address_space *mapping,
>> -				struct folio *folio)
>> +static bool kvm_gmem_release_folio(struct list_head *entry, struct folio *folio)
>>   {
>>   	struct page *page = folio_page(folio, 0);
>>   	kvm_pfn_t pfn = page_to_pfn(page);
>>   	int order = folio_order(folio);
>>   
>>   	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
>> +
>> +	return true;
>>   }
>>   #endif
>>   
>> -static const struct address_space_operations kvm_gmem_aops = {
>> -	.dirty_folio = noop_dirty_folio,
>> -	.migrate_folio	= kvm_gmem_migrate_folio,
>> -	.error_remove_folio = kvm_gmem_error_folio,
>> +static const struct guestmem_ops kvm_guestmem_ops = {
>> +	.invalidate_begin = kvm_guestmem_invalidate_begin,
>> +	.invalidate_end = kvm_guestmem_invalidate_end,
>>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> -	.free_folio = kvm_gmem_free_folio,
>> +	.release_folio = kvm_gmem_release_folio,
>>   #endif
>>   };
>>   
>> @@ -430,22 +388,22 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>>   
>>   	inode->i_private = (void *)(unsigned long)flags;
>>   	inode->i_op = &kvm_gmem_iops;
>> -	inode->i_mapping->a_ops = &kvm_gmem_aops;
>>   	inode->i_mode |= S_IFREG;
>>   	inode->i_size = size;
>> -	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>> -	mapping_set_inaccessible(inode->i_mapping);
>> -	/* Unmovable mappings are supposed to be marked unevictable as well. */
>> -	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
>> +	err = guestmem_attach_mapping(inode->i_mapping, &kvm_guestmem_ops,
>> +				      &gmem->entry);
>> +	if (err)
>> +		goto err_putfile;
>>   
>>   	kvm_get_kvm(kvm);
>>   	gmem->kvm = kvm;
>>   	xa_init(&gmem->bindings);
>> -	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
>>   
>>   	fd_install(fd, file);
>>   	return fd;
>>   
>> +err_putfile:
>> +	fput(file);
>>   err_gmem:
>>   	kfree(gmem);
>>   err_fd:
>>
>> -- 
>> 2.34.1
>>


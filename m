Return-Path: <linux-fsdevel+bounces-40894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4541A28255
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 04:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B26F164E92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 03:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0221325D;
	Wed,  5 Feb 2025 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PrNp2Zby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81E212B18;
	Wed,  5 Feb 2025 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724879; cv=fail; b=I3IulQefYNNXmHiGblAvGr7UCY+It6RhR9IlU5R58xAKVva+3wnxDfVVHdafr5ajJyTFoxDKlOYhpLfXYXbNeubu9+njaXVpaIJY5W710PXRVSdhiwaa0G4iIPiU6Ub6wFL/aQiBDu7n0ozBILikOALIVXkOxICUS1i1pQR4SO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724879; c=relaxed/simple;
	bh=bjSsVSIMHNa49LmJZcX+bI0fXDywZsOo3g4G0n7L8n0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b+a2Le4PoF+2jbACrn6VGYrZg3QG/lRKEfMVX9jemRfgkeMKJfKnoyoAf7zWuZ6guL2yVgGHmboZXZKnbKiyRzSEP12iIXYyru3dgRkiL6KWyZg1/HW31WwKEkPklba0smoXnmYW1AVWqX1JqWzubZ9lpzBsjNqxrNK07coqmQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PrNp2Zby; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3A2W1gR4re2HmLwCx1BDEguwvAhlnw+CX3vdUApvUBOgaAujsZcxU6Nb/wAM7iRQZLBNxJT0s6BcrKbO2NAeKMRBq0KhZfhHlTaQ1UO9ls1FoWb5hd5uohz7zmcenf4/Oo0OVTxh+SjY962p/uT3GjdFmpYEJGtKDJ0X69/CIZo+m5OSEkkbHZoX4n+BWymLviEkXhgbVPfwGIY4mJmt96z4Rwtqamb/DdnqXrVw9L+mnp1bGPaLvSsvZ0v4ZMQws0sesCoDZfQ+MrXqI6WwASyEPYU/+ci/32b77p78+g41w48ocDMn6ezZCnkaymj48DRgLvhNXj1jDM6zCj6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZnwxVPqsgGdFLdc6IIUlNUNIszkuY0kexSUWRS8Y8A=;
 b=USF2OMhXZjkBBbN4uC6nMz1T0fZpxZgy/kD7+cbdnhY3VePOQMqJPeoAIfXKjOQNoWhot8GR/2xUi/J/3HMwuQ6ABWKXfBcB2LOQ+9f9d7L15RbBa/FWyaHoD9ziPsH1xpUAvR5TzXWsTm2OleHImmxI2AIilQ5R3A6JkAgdwInEnYruse+FKlJpu1NQxvW1ejbT/WDuq/U2+0bGJlVv2RgyeMJSbO42DnRjaQiodFI+7aXjXMszzT7Hugat7QbFw0ykOZtYcpN1skswBYEJheXzzC5DKgvhpwOVMaZf5HFib0vL03xyxk15SPxtkfTlt1Ro4RYGvTK0x2YcgK00EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZnwxVPqsgGdFLdc6IIUlNUNIszkuY0kexSUWRS8Y8A=;
 b=PrNp2ZbyN7B0UEodg6JuyXOpGEQVQo5wyZIyPZd1f7elcLZSwU5X7eh0Ya/khtr5fcJrbNIOxpMsVDdx6A1Wg/4JVcPXGXhf9cjtjtYUrQX3PylAeQUdchaNHNCyL1ikw4TnNbzc/CorH/qY/QudZMjBJLwfT2VnPe3Joey07/eHzlnRz6IoU1E8jtqk4wPjayygKVLPxvH0NbN7/wSWolfwN3BHLHvGAtMWd2LyKNucod4QKTQorlQXyC1/KIgw9VwxYv9vyHSiAbcqmRJ2kydKxBzMVDAk88GlRc8ty7qtufO0hPf+CoGua+dHhDYdtz1irkMf1+YekbOA7FzizQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 03:07:55 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8398.018; Wed, 5 Feb 2025
 03:07:54 +0000
Message-ID: <73f9d8f1-6fad-43bc-bcd3-c1de44322dbf@nvidia.com>
Date: Wed, 5 Feb 2025 14:07:43 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/20] fuse: Fix dax truncate/punch_hole fault path
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
 peterx@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev, Vivek Goyal <vgoyal@redhat.com>
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <8aa3a20b072f60344e1d7e9b77a95aaa4b6dfceb.1738709036.git-series.apopple@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <8aa3a20b072f60344e1d7e9b77a95aaa4b6dfceb.1738709036.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b09a479-5c56-4eae-c6ba-08dd459248ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWYzTTc1NnVSWlJMY05Rb1ZkdTFXSi9NTjJLRVJSeEVIb1U4dkd6d1dLb0hp?=
 =?utf-8?B?OE9ESllPRFJKRUJZMElNenVxL2xxVlRscWdYOEFBeis4cG9DYkxLOC9oUlFW?=
 =?utf-8?B?Mk5YQ2JqcmhBbkVWWWdySkdMb3JOd05nZ2grRXpwajh2a2N6WU5hcGdHRG0w?=
 =?utf-8?B?WTNMT3FObGVPZkwyOEpqQzN1L2JFc2VmVGkyZ0JNaTFxcm9rYVVlNFV5ekVv?=
 =?utf-8?B?S1hWMXoya3ZPNWNiekhrZXpRYS9adlQ4SmdPOHRxT3o0Zk5qMTg4Wm4vMTZU?=
 =?utf-8?B?a1VWaGdDeDV1SDI4cXk4RTRyZnZuU0hRNGR4K2ZQQ1Q4SEdwbWUxaHM0UEVG?=
 =?utf-8?B?NTB1YUNhblgwbGhiTUkrN3J1Q1BreEFzSmxhTGh0MHVCeU5sS3ZTZURHd1NR?=
 =?utf-8?B?TGpZWjVKYVpIdWFNd0F3MlNXSXVDRldQRm5MODdUOEc1K3hzZUl2Tm81NjNq?=
 =?utf-8?B?WkFXaHVPa0cvVGx1ZVMzVjgwclFEZDF6ZURJQXVtTEU1UjlxZFh6cUROdXU0?=
 =?utf-8?B?L0JNL2ZWdlhTMno3QXhWeUNEMjB0S1ZyV3hNSUJhVWtqeWNBbXdQTkdGRzll?=
 =?utf-8?B?VE5hUitHRDhKWFdvdENaZUdVOS9FTlBZL3liMzFlemFLbkJqcEpLZ2ZBSFdz?=
 =?utf-8?B?TUpKVDh4ZU5Rd2dVZWV4dFRUQlJIMFRkcGFvWGhna0V3dWZPbHFoMEpWNWxX?=
 =?utf-8?B?RC9ZRFFIVExaNFIwdmlxNHQxenlRbXZoNU9IVkFia1o5NzV5TkhwTllzdnhq?=
 =?utf-8?B?VTQ1MGtsdkJPY3Nlc3ROV1lXOXh4UmQwZTBBV0JkUVY3NXlhZjA4SGZUTnFJ?=
 =?utf-8?B?eVh0OXlXTFhwZENKWU1ZdnJEUG12RFI5Zi9BQUNFUzdJZzNCYjFqUXhNZisy?=
 =?utf-8?B?dTNvRTF1cWtvdXZPYlVpcHp2V3hmSGxvVHdBMGR3U2tWeFRBYkJTem5BQ0FU?=
 =?utf-8?B?Y1lFOVFPeFc2ejZnWUhLQWV4Q1pPMUt5K05WZTVBSDR3NUdrREdodExuNVNS?=
 =?utf-8?B?R3FpekJzbU81T04yK3llaVdkeVJWbmJIcG12SE9YSXRKd1hNWmtiTGtwMGdw?=
 =?utf-8?B?dEpsc1BBMWtFLzMzbkZ4UURhemp6aTNwWmZXTFFtL09PM3Bod0lUWHh5ZDZH?=
 =?utf-8?B?NUFqTExNSTE4SjhaN1ZVU1FOYUMxbGpXbFEvM0cyVVZ2V2tjZ3B3VDNsSHV2?=
 =?utf-8?B?bTU2Vno4RG0wK1JkU3dubldsUE1Rdy9QZmVOaHdEYzBPbzlSV1p5VWt1Yy9s?=
 =?utf-8?B?VVlJd0kwSGI3T1NGWFRxUE9KVURmRlEwZWhXVVg1d3lWcXZLcSthZFNmZVR2?=
 =?utf-8?B?K2NEeGlvTHhydzhrZXpwS1luR3FYN2lFUUNZZjFjTkYwWnZjMlc2Q1R2eGFF?=
 =?utf-8?B?OUliL0JROGdkQ0p4eEpLSEY2NStvTmtlS3dpTis1VjhhWjQzR2hOYU5aMlVD?=
 =?utf-8?B?Q2d1dWMzbkdicFFpamdPd2F1RHF2eEJsNlFMaFg5OThGTDRsUE15NCtxWG1k?=
 =?utf-8?B?MGdJZmp1NGJ5b0Q4RC85VW96Y1gyaEhZOThFR2Qyb3FUbi9Za3VuQTcwOUZE?=
 =?utf-8?B?cFB2WFp2ckhaWGRDdkE1WHBSclM1NjVNd3FQV2RSS3c1Rll4VlRSM1p1S2Fn?=
 =?utf-8?B?c09iNll2cGcxR2hYUVN3NDR3UEJwa1dXU0JST1k1VWhaVUlZU3N5WnoxcEwy?=
 =?utf-8?B?MWNJNmRzbkdYTHIzaXBoYW1CczNTOUhHcldnTnJuQ3UyQ1VqOXY2Qkx2RmFS?=
 =?utf-8?B?eGdmL2ZZR1pzSGJaU2F2UWlUZWhTMGNxak9lZVcwNzBIWHFuWVlXUUJBNHV0?=
 =?utf-8?B?ZG0zNkEvVkdvZ1FJT0pNeFZzdDJJd0Y0YjFMYkt5VHZFWXBNSmsvZTBXNmwz?=
 =?utf-8?Q?fi1qlm7qC4JR0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SllLcDhyRGtjMGRaRjJVWHFNcTk1OWZNOFBtaUhVTWE0QmhMVXJkMDdCbUJG?=
 =?utf-8?B?eUgzQ1hJRHZRL2RDZVQzOExyTWhBa0l3dGVkV0VLMTcwSUxabmhLVkJLbW9P?=
 =?utf-8?B?aTN4SU9sSGRMSWhOS1pMVUMvMHcrSUdwRXdUWWl1cUJOZ3MvcjgrMm5rSDlt?=
 =?utf-8?B?RzQxV1EreHE4S1A4L3IrQ0JqdktyejJQenlIRUtGNjdVSjVmZWdzN1ZtZG5l?=
 =?utf-8?B?aTZZcHdycDZtclRUcytDTGxPTzFaMFVlWUtkdWljUyt3dHJZUUZUVFBOSCtE?=
 =?utf-8?B?SGxmRm1LK3NWVXJlaTh2SXV2eTBBU09EY05oZ0d6ZUd0UTlHVEFFYTRHUlpt?=
 =?utf-8?B?QW80dUxwZlFkMisxQnBHY3VMQlBTTzFJcW15OWcxNzBvaUxnWVJEcmF4cjNx?=
 =?utf-8?B?RzVyZlcvaW4vS05MYzZua3J3b0hwQ2J5cWdJeXlWMFVDZTdFdHJBYytpUFI5?=
 =?utf-8?B?QmxEQWxHNzNIVHBYakZtZTM2RFZXTW5HSDZOaHMwWEdhWU9UTkoxSk1oeTNZ?=
 =?utf-8?B?eWl1Z1p0cDA2cFpkaSs0WEtLdGJJbUhJTTlWTTk2UGljYThzdGhFMmtTKzU0?=
 =?utf-8?B?dGl4aXdOZzE4Z2JZUk0rcWlOMmlWSVozZS82eVpvYi8xVWlNZWd6dXdMMHMx?=
 =?utf-8?B?Z2ZnVjRBaWovUzE2MDMvZmIycU8xSmtEd2pTWStnYTdTQnBjbldnOS8ybWps?=
 =?utf-8?B?ZXh4bUpYMXNlZEJSTkZvNTNsZVZiVnFCT0xEUDlramp2c1QxeFF0bGdYK3pl?=
 =?utf-8?B?QllvTGNOVlhid0xHcWMvQ2ZQU3pTQXFhK25GaU1sOVZ0SUMzK1ViMTJta3Rp?=
 =?utf-8?B?ejA1bE9QQWRDSFUxNVVSS2tsaXdNTjhaN3hEakdLR1VOVlM2Y3ZaVkxYekZX?=
 =?utf-8?B?OS9uOE9XbDRQWEtoZXIzT0hBT0R3d3cvZmJ0Vm5vS1JZZmRMUC8xcjd1L0ZM?=
 =?utf-8?B?UVJsaWNvNzVyTUhvWUNMbHRNZUJTM3ZZaVVKUmRtb250a2pDQ200TUZCemUv?=
 =?utf-8?B?eiswSEVPZld3RXBpNG1CSnU2ck5ZN2VLMUVJS3p1aUtNRmpiU01lWGNBVDlC?=
 =?utf-8?B?b09leU1ENEtZVVdhbjJJOVAweFpEYjE5OGt5V0l1Vms5OHEvRUs1aWNQWlhN?=
 =?utf-8?B?UkFoSTJSYXBTVEZaZnpXcWhTTzJJQmdyaDE4RUl6YUl1OFFSWlE0SmNtOTZC?=
 =?utf-8?B?ajBkeEVoU3JQa3BXZG1PamZZcjU3OUR3REhQUHRER0RDejFhcUxKZ0xwcUds?=
 =?utf-8?B?cVNmYk51S3l3dzlqYStRbU45RVRDTjE3QVBDeVRJTklHc29JSlRYa0xSVUVR?=
 =?utf-8?B?SGYzY3NXQTMzKzAyVllvM1VFUVlTMmRsRU0zNHVUNGYxek9ocC9KQjB1K1BF?=
 =?utf-8?B?ZEQ0dDBIUzFmL0xpTFFsNWhWRnF1UHFHOFVXSHZIQzBpbHNBQ0pKYUgwM2I3?=
 =?utf-8?B?Nk9tWDU3NTg2QitHYjh6K3FiZ2htK1hTaHlidEU0NDdvNGFLeENOck5MN25M?=
 =?utf-8?B?Wk4xcUNJK2xpMWxJUGlIam9PRGRaYWFKU1NSUFg0VmtrSmY5b0NFZE9YK3dX?=
 =?utf-8?B?MXBlYnhtM3hoQzh5aXV2K0R4bmNiUzVhUjZYQ29kbnNzc0NhSlhQZW15eC8x?=
 =?utf-8?B?WGhua3lmWEc0UVdTa0wvSEl4N1ZrMHBNbUx5UlBxQVBtamJkZzR5SnhOcDlz?=
 =?utf-8?B?SkZucnBndnNPYmx6ODhCZzFjaWVaQ1U4cXB3cFcvclJsSklwMHdQb1NLOUdR?=
 =?utf-8?B?U3FndkRyRGZtUlRjczhmZTdPV3hxUnFBOHdPSHNJTllaRTkrRkQrc3BWRlQw?=
 =?utf-8?B?QWlQaXMrbDgrMHdMdnFkanlQZ0IycEZBdzZwQ3krZ0Z6WFBFSDVBOXpnNUpm?=
 =?utf-8?B?TUxuNzJEVUtaYUZhY2hxRkNtRTZqWXFYbU10ai9kM3J4aVE2dGgzYnRYWW9L?=
 =?utf-8?B?RHEwT0NKM0FTZzRNSjZONHppVEw3K0V6ZzhEbGFrOGtrUEx6dXFlaXZXWGdI?=
 =?utf-8?B?cFgvMXpjZzE2NlFkSFRRS1BJWlFsQjVxemNtUmpnMjdzeXlZUGwrS1hMZUFK?=
 =?utf-8?B?U1ZFclNPdHZML1VhdUhzQnUzRWpxVjRPQXRyTi9wUWJ2Szh3cnZWSjVpVnFj?=
 =?utf-8?Q?viTGs1xoVlXiMg/bvlibzGP2h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b09a479-5c56-4eae-c6ba-08dd459248ef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:07:54.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpxGzoFRqWaZRo7urNGIVjxR/lOa2b3eemuZBUv7Ik9iaUKnEJ36OWXv2y3zmSjfMj7J4t3/5URH3c4VsPhRpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On 2/5/25 09:47, Alistair Popple wrote:
> FS DAX requires file systems to call into the DAX layout prior to unlinking
> inodes to ensure there is no ongoing DMA or other remote access to the
> direct mapped page. The fuse file system implements
> fuse_dax_break_layouts() to do this which includes a comment indicating
> that passing dmap_end == 0 leads to unmapping of the whole file.
> 
> However this is not true - passing dmap_end == 0 will not unmap anything
> before dmap_start, and further more dax_layout_busy_page_range() will not
> scan any of the range to see if there maybe ongoing DMA access to the
> range. Fix this by passing -1 for dmap_end to fuse_dax_break_layouts()
> which will invalidate the entire file range to
> dax_layout_busy_page_range().
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
> Cc: Vivek Goyal <vgoyal@redhat.com>
> 

Looks good

Reviewed-by: Balbir Singh <balbirs@nvidia.com>


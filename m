Return-Path: <linux-fsdevel+bounces-53159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41E9AEB155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE26408EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCEE2405E5;
	Fri, 27 Jun 2025 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2HA+qR0N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0251F17E8;
	Fri, 27 Jun 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012879; cv=fail; b=o9p5SzyzGDlvycFLpJ6RxwgTCeB+ZlQ1DGwTvyhz89vH5OO1ZyM17/+Rb1vx3G33unTcMFZ2fVfRTeiPP9a8poJFt4/E/ZYfaqOFD+j0XZ/6GUz9t8v3Cohfzb6BzYtcqx8sfAhZylQuMCGi92uooPp0GsSIdLpavgzrCEj4M4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012879; c=relaxed/simple;
	bh=i+9mlIwLl53AZ0nuWmeZ+olxAYX+sUtQTXtyRkhRkIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CD5C4uMNrsOfGG4I7JIBABM4A/bxKyAJjitY50Cwfs8vo7c2yipzTEmkNEPABljLX5QLl9wSLT/a9Rw/pRFMayjc0wFur6xDHt7v9o81SFJBwJv4sT3XC9VTW2bdsVTCGckyO50+g8sUF5I+7CE/j0UsThW12mLNCjwJcnDZHJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2HA+qR0N; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMcvEJswvkqWoCYmb/1ScaDvd5k9In0m+6YvZOQOYpMJh1aatgLskxitEQxlSQ9+eHWsQTLwUBYffWdt/+A+y21mSqGERh8/PsPzeFSVD2EOmsEXY+KVnHw17HoJBXM/o1mJiUpGAv39HOqpC5CPACdZ1XUxs7Ol+GSbGq0hTzu9YEGTNNFD3NJesbflqff7vJs8OKfJtbXqfQQMJhRrGWcJfc8SRTpBNRJV1DFaLC1Osp9UrUcDSt8XAbZi6JfNGeIvUyOVOShqsY1iimwimIZKKcibdxQw8yjnzcv10+Mo9wZhcNL+gitdzaVoFumV0NmLvhcItIttn88I/800jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8lffmM6beYEeSIe7NzI/7qcpC0VQHrOoBekByvJOcw=;
 b=nVyUEraWQUNP/1/gV4L9QagfOZFIC5xFiCDIdsEXWffFGHwcBNGg9j1decbRK5iFuunyiUmzpzlqqma9kTKla80gQek35eGD/byV08t6Ug5b4Y5wFw+oCTm2uOJkFGM7bxPUPHjTgd2Dh7HWv9Jfk0QZsG23Dhjyqa6o+9/xvhsQuwTki1CbuLmepHCJ8FtfjJj2NiPMdkGs8gYD3gXclRzQkG895ef8IzysKPu1q6Z6qTFGMlh2xa/8ky+gNb2oB/Fag+zPR2aiBNouB2MkYCDF5yRGvKEzAjOq0S9gunilnxYJzLaRy9VYyYWP4DsusHixf+TSeFN+694ZC/YNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8lffmM6beYEeSIe7NzI/7qcpC0VQHrOoBekByvJOcw=;
 b=2HA+qR0Nd4/UPdtV1y5uYmQ6mxIUpeRC43THRIjlyp/VO7lnpzR+kd+3q/NZ0I/orqbaYUCABtWhWr+KVKI8bQAUWjcJhMHrt/Fr7lhXaJpVXRFB7g3Fp5h/FaavcRuJ7wp6IRVuwKeU93tjOndwa+OozDl+eP+v8bch+5iwL8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 08:27:54 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 08:27:54 +0000
Message-ID: <9e4ffa68-1be4-4fcb-99a9-bb6e6aac7db9@amd.com>
Date: Fri, 27 Jun 2025 10:27:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] fs: generalize anon_inode_make_secure_inode() and fix
 secretmem LSM bypass
To: Shivank Garg <shivankg@amd.com>, david@redhat.com,
 akpm@linux-foundation.org, brauner@kernel.org, paul@paul-moore.com,
 rppt@kernel.org, viro@zeniv.linux.org.uk
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 pbonzini@redhat.com, tabba@google.com, afranji@google.com,
 ackerleytng@google.com, jack@suse.cz, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, roypat@amazon.co.uk,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20250626191425.9645-5-shivankg@amd.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250626191425.9645-5-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b523f19-d3c9-4402-36bb-08ddb554831c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTVNSXRueFZmM3VQbTVSL0EyU0xIeWJBaEh3Y1RxTXdZVng4WDVmNVNrY1A5?=
 =?utf-8?B?WnRBRUpLU3BEMWFwTTVVdkszYzFBZ3JzUW1Mak8rV0dHQTFTb2FQTGNRc2Nl?=
 =?utf-8?B?NU9ZYjFJNUR2NW5zZkdlb3NGbmhocmNpeEpDSitiMndYVEtMZjF6bm5CRXZF?=
 =?utf-8?B?eEl1Z3NybS8xOGNqWkdZY004N2VtNDlXQk9TNXZLRVArSElqSzlVbVVDeUxl?=
 =?utf-8?B?WHYxSnUrN0Y3Mk1EWTYrK3E2RWpTeERYUjUwdFNEbFFOOE1OL1lXajB0bFY2?=
 =?utf-8?B?bWpVTzh0OEQwRGtOZ2Nnc2M4RzNDcDAxZmRkWjVYSzFRaDM3R0tjZ25FM1Vh?=
 =?utf-8?B?ZXhVTWhTTXdKRmE3SmZwdjdBVkVEUU5GVXA1YkVkbHFhQUhKckpCNFBYOTJU?=
 =?utf-8?B?cWVScnJTckFyU0kvSmdYWjVvTFR5VVNOQyswbmVNdUVWaS95a2oyVTUvUUk3?=
 =?utf-8?B?MDBzSDU3VUV0ZHlqSUl6Uy9WTm5jcHlWU09SeDg0dXVjR0RSRDVnaXBHbEdM?=
 =?utf-8?B?TmVOVWtTdnFydnRnazBERFdGejBGN1BhTk90TjRaNEo0QzhUYUpZaW1oQmtD?=
 =?utf-8?B?bTJoZkN4UkZUNlkvMG9BTTd4N0NLZXRucDRYbUVkcG0xdEtVSHZBWThsTHBm?=
 =?utf-8?B?cTViTCt4RG00SWI2djkzNFJMQmM0NVdZUkxrQVFSMDRPeGFnT29ZR0lXVFox?=
 =?utf-8?B?dWREcUVuUjY5dU1uSG5QOVZoVlFyNGZSRGExRmtaeHFLaDZrQ2d3RUxRc1B6?=
 =?utf-8?B?TnM0Z29aU1hyZFBNSmtXUmh6YTJ5M1N3alZJQmZucVY4emdGcGxFTVRhNzFY?=
 =?utf-8?B?cFR3N1BaL2JGVzdaSDUzQXVudHJzSG81U0M1RlU1NkJSSzVSRDRRd3FHdnkr?=
 =?utf-8?B?YjZJc1RMdU5uU3JGVVVxSDlkcXB6RFJjVlZBREIycmxFbzNJa1lHR040Mm5h?=
 =?utf-8?B?WVdPTStyMnRIb2x0WDJPdnBwV2FQeGozaXJHcW5TaU8xSEVFbXBoWlR3UXpO?=
 =?utf-8?B?SEVaaXVGcHBIdGt1ejQ3MXI5OCt3TExHRklLQ0gwSmhzcVhrT3VuRkQvWGUw?=
 =?utf-8?B?S3VvNHMvd3lTakU3c2ZkNGovL3VCN1B4T0tkZ2VJT2VyVGpVbzVhSTl1NlQr?=
 =?utf-8?B?UUpGekhPSDRJcnJpMmllV25xclI2TnJLSVpVN2VmQkpVTVFZclNrR1FTa2hR?=
 =?utf-8?B?Qnl1VjFYWjFQa2E1OXdnT0pMTzZkY0Q5QUt0V3JJRGlUTnZZM0RsOWIzZUE0?=
 =?utf-8?B?SjNzQUdTMWt1S3ovK0Nualh4YTU3L3FmT1NlbEdJRFA4M0FmRlVBc2xyRmY3?=
 =?utf-8?B?UXFQNjNWRUFKaXpYbmxJbEd2WFFwSkZHRnpZbEh6aEE1aTNRZExUeDQ3NXlK?=
 =?utf-8?B?N1p6bWk4RkRXOGx1RklQL0pLamxHOGtMd0d1cXN2UEtrTEVTbGFMVEI2OUU5?=
 =?utf-8?B?YWdRMmRka2xLZFB2aU1tRDA5UFA1Nnd3VzEzUjdHdkNnbHlKZG95QnpsRlpw?=
 =?utf-8?B?WllqbXBVSFpoYlU1UWZUZDZHazk3bHVsYktacndFUzR1amEyd05lNTFKcjVH?=
 =?utf-8?B?dnl0SUk1cmlDR3duQTRuWWZ2aVdMdUFpRHhBaW1TMHU4WUJYNENFUGhBMFZj?=
 =?utf-8?B?bzkrK1N3Zm5NR3lpVE91ZGtyZ2E5RUFhWFR5aW55M3lRWmlOUDJpNmJnQ2Jk?=
 =?utf-8?B?Zi9rWVozSHJmM25vaXFUa3VVeHZ5ejRvWlpGRitRV09JVWlVOTN1Nlo5T2xI?=
 =?utf-8?B?WkYxeUsvMm5keHRDZjFWak9XWW1weFlyZ0V6TkpFTW5tMytJL29rU2wvRUpB?=
 =?utf-8?B?OWs5ZEVlRWkvb05GVmh6WGE5cm14cmtyVGoycGo0RkJMd0N4QlhGMEpoYnNS?=
 =?utf-8?B?U0lPaU1wRmVId1Uva2RDb0N3RkM5TU9waXJ2MkpDNE9tc055NGlsNjlwQkFY?=
 =?utf-8?Q?mbIMmuXDWnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm1Edmk0Z3lLNnY3Q3prNnJMUG15Vit1Y245TUVCNEdHVXQzcXE0OHhHekp2?=
 =?utf-8?B?TTZIQmltUHgwN25BL0QyakhEZVJFMlZaeUtuVm1IRWx2Wk1zWVZVaE9TK0RL?=
 =?utf-8?B?MzE1U2xrTThFK2ZtRHNVK2V1NERRNk1pTlpvSmJWU3N0SzRISUlENFI2SzNE?=
 =?utf-8?B?WHNGNVkyMm1jMW8xK0xLVldLUnNZdnExMDNqUFpLcXhsSWNTTHdtTVcwMmhq?=
 =?utf-8?B?UXNYbUJ5cDRXbkw2WUx1NXhvNkVPZERncXdHenZmcFpaMGNGU09iSkpocFdI?=
 =?utf-8?B?RnBqZ2l0OWR5dVVWdmdEbldHamhEeXJ1c0NRVG90Umd4S1lmWGZwUEF6TmZl?=
 =?utf-8?B?bHJpRmptV09LNHd6RDZnT3l3OGNaeENyQzMwNkMxWjNzcUpHdGhjLzNKVmhG?=
 =?utf-8?B?U25xRHQyL1J5bTJZWTZiK3l6WTZtOFNiOU9PdEcyNTdLT3NsM0c0MGJQbkxB?=
 =?utf-8?B?ZEpYcUxiRlZGNzBZbW5EME5GcjFWeGxkZHNuV29aWGFXdkRWVW9PajJvcks2?=
 =?utf-8?B?TitYSzRYcjdRekc3cjFVajdzMGQva3ZMUzNsc0Y1QjZZV0dZa2hJQzA2ODUv?=
 =?utf-8?B?S2hVNGZSVmpOYmZaZHc0VU1xdGdsc2h3MG1HVk9yYTgvQ3kxdm1sUnNQbExC?=
 =?utf-8?B?dnZKR2s3RS9FR0c4Nk9NOFB0b2hyUzgxZXBTMTcrZEZmOFZYbVFGalVPOEp1?=
 =?utf-8?B?bkdiakFVbStvNW5VSHUyc2hCNjJDQlU3eFB5VVRZUWd3VFYrV1pFZS9KNmw3?=
 =?utf-8?B?bjh3N1NWOHlRL0RmbEpwNkkyRUU1V0pZMDdkMjJhTU4rQXluVWV1NWhNa1Qw?=
 =?utf-8?B?MEs1ZnFqclV5MWVWa3NOcStlZkFPNVBaMld0TjRRVDhIakVjZC9lbmZpOHdl?=
 =?utf-8?B?QUU5OWE2RUt2QWFrWWJUTHZKN09MR0NhYmoyTW9IUzl6NWo5Njh2eXNNQnRm?=
 =?utf-8?B?SXo5S1R3MmdoOHFlOFVHVFdWYmFSSlZrckVrNlVpaHRlNDd3bGlwWHpaSjVV?=
 =?utf-8?B?WFBBUTNHMXN1MCtjVStmU0JIQWI1UkQ3cktNRi9obDNHYVovWVZQZTBZM3RE?=
 =?utf-8?B?R0UwMlJQaE9JV1pmNGF3M3NTc2k0cUxaZ1JvK1JxSUNoUStRV3puL0M4YUVq?=
 =?utf-8?B?TDQrL2wzVlZLRlRKcUxBb3p1MVNVZDNXaENrc3puZkw3NzIvTmdtdWwxMFdH?=
 =?utf-8?B?ZjIxWHg2YjlhVnRUem5Yd09WeHAwMFkyT1ZmZ0ExYWQvek4xNXc5WDNPSzR4?=
 =?utf-8?B?amtQM3VYK2U5cTg4MGpLNFFyQkE2aWVnKzhRdTcwM1p2aFRGWmZ4SUVaMm1v?=
 =?utf-8?B?bVduSndjdWNseWwvK3JGb3NzamJ3ZG1ncDJVQlJUc05SY1RnWWUreFZYUk8y?=
 =?utf-8?B?ZWE4WG51Z2tYVWIxMHJveHZkMFYzVUZDTXIwU2pZalo1cUYrV1JKVmFMZTdo?=
 =?utf-8?B?YWxxcEhteml4NmsrSHdLeGM5Y0ZxNzlrL2dESWgzMkp4OUw0bEZyamMrV0o3?=
 =?utf-8?B?NE5WOW9yT2YrVjZhM3BvVitNbmVpeDhnRGl3YndsQURNSDRCTHZQRFQ5UnNL?=
 =?utf-8?B?dmpsbXZUbTRSWVdVUnJnaU5vcjYwSlNWMEFTcktJREZvajhHOEptZURiTkI4?=
 =?utf-8?B?MHhoOGJ0amtxS2JoQkUyZ2NZcUlyUmVoanN1OFBEUzVNOENQRVZFZlN0eUhF?=
 =?utf-8?B?M0hrV2lnVGFRc3JGbms5UFRISTU0SHBzK054ZmhZQWgrNnE4UUZXRTM4cUNu?=
 =?utf-8?B?K0Yxb2FZSTFYWUlzZFIyc0F1UGJQTXNmK1lTUnNtc1ZWMnhaNEZQWUE1WlNt?=
 =?utf-8?B?SjhybURXZG5XZ0FCQ2VZK3pyTUdaWENOeWFFVnRkb0tPNU93TUhXTW1vamVH?=
 =?utf-8?B?WjJvRHNRYWorRjFQdUgwa2RQNHdFNjgyVVFUUGVZSjY4eVdVSjRoL1JvcjY0?=
 =?utf-8?B?K1ZWNDRLUllnTmJlUTZYQ0gzdk55SVVLRmNUN1hraUpjWG1kdmFYVXl0R2x1?=
 =?utf-8?B?ZlhOS1FmZTlNa09KbXlpQXNIT1Fka0NBUkdHRkxYbUNDQUZRemt4ZFlUdGpN?=
 =?utf-8?B?NGNTeDlJZWgrRjJXWHg2Yy9aamwydG9wdEwvSmZNUi8zajhVbVlOeHZSZ3RU?=
 =?utf-8?Q?qRQj6aWUnomHVxwqApq7YrbFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b523f19-d3c9-4402-36bb-08ddb554831c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:27:54.0212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19YPYcshmDlZbpH6bgAH+SylQSo5bQuHa8mjE5/f9qXEn+aZviLStGLaoj6k/ZMmN/5sWS2dRuLc/9Q5vLDuKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356


> Extend anon_inode_make_secure_inode() to take superblock parameter and
> make it available via fs.h. This allows other subsystems to create
> anonymous inodes with proper security context.
> 
> Use this function in secretmem to fix a security regression, where
> S_PRIVATE flag wasn't cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be skipped.
> 
> Using anon_inode_make_secure_inode() ensures proper security context
> initialization through security_inode_init_security_anon().
> 
> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Relying on 'anon_inode_make_secure_inode' for anon inodes LSM/SELinux
checks seems okay to me.

Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>


> ---
> The handling of the S_PRIVATE flag for these inodes was discussed
> extensively ([1], [2], [3]).
> 
> As per discussion [3] with Mike and Paul, KVM guest_memfd and secretmem
> result in user-visible file descriptors, so they should be subject to
> LSM/SELinux security policies rather than bypassing them with S_PRIVATE.
> 
> [1] https://lore.kernel.org/all/b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com
> [2] https://lore.kernel.org/all/cover.1748890962.git.ackerleytng@google.com
> [3] https://lore.kernel.org/all/aFOh8N_rRdSi_Fbc@kernel.org
> 
> V3:
> - Drop EXPORT to be added later in separate patch for KVM guest_memfd and
>    keep this patch focused on fix.
> 
> V2: https://lore.kernel.org/all/20250620070328.803704-3-shivankg@amd.com
> - Use EXPORT_SYMBOL_GPL_FOR_MODULES() since KVM is the only user.
> 
> V1: https://lore.kernel.org/all/20250619073136.506022-2-shivankg@amd.com
> 
>   fs/anon_inodes.c   | 22 +++++++++++++++++-----
>   include/linux/fs.h |  2 ++
>   mm/secretmem.c     |  9 +--------
>   3 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index e51e7d88980a..c530405edd15 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -98,14 +98,25 @@ static struct file_system_type anon_inode_fs_type = {
>   	.kill_sb	= kill_anon_super,
>   };
>   
> -static struct inode *anon_inode_make_secure_inode(
> -	const char *name,
> -	const struct inode *context_inode)
> +/**
> + * anon_inode_make_secure_inode - allocate an anonymous inode with security context
> + * @sb:		[in]	Superblock to allocate from
> + * @name:	[in]	Name of the class of the new file (e.g., "secretmem")
> + * @context_inode:
> + *		[in]	Optional parent inode for security inheritance
> + *
> + * The function ensures proper security initialization through the LSM hook
> + * security_inode_init_security_anon().
> + *
> + * Return:	Pointer to new inode on success, ERR_PTR on failure.
> + */
> +struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
> +					   const struct inode *context_inode)
>   {
>   	struct inode *inode;
>   	int error;
>   
> -	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +	inode = alloc_anon_inode(sb);
>   	if (IS_ERR(inode))
>   		return inode;
>   	inode->i_flags &= ~S_PRIVATE;
> @@ -132,7 +143,8 @@ static struct file *__anon_inode_getfile(const char *name,
>   		return ERR_PTR(-ENOENT);
>   
>   	if (make_inode) {
> -		inode =	anon_inode_make_secure_inode(name, context_inode);
> +		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
> +						     name, context_inode);
>   		if (IS_ERR(inode)) {
>   			file = ERR_CAST(inode);
>   			goto err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b085f161ed22..040c0036320f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3608,6 +3608,8 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
>   extern const struct address_space_operations ram_aops;
>   extern int always_delete_dentry(const struct dentry *);
>   extern struct inode *alloc_anon_inode(struct super_block *);
> +struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
> +					   const struct inode *context_inode);
>   extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
>   extern const struct dentry_operations simple_dentry_operations;
>   
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 589b26c2d553..9a11a38a6770 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
>   	struct file *file;
>   	struct inode *inode;
>   	const char *anon_name = "[secretmem]";
> -	int err;
>   
> -	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> +	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
>   	if (IS_ERR(inode))
>   		return ERR_CAST(inode);
>   
> -	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
> -	if (err) {
> -		file = ERR_PTR(err);
> -		goto err_free_inode;
> -	}
> -
>   	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>   				 O_RDWR, &secretmem_fops);
>   	if (IS_ERR(file))



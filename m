Return-Path: <linux-fsdevel+bounces-46238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63BA854AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 08:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C1E4C06D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF327D79D;
	Fri, 11 Apr 2025 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hycjP4uN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D38635B;
	Fri, 11 Apr 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354313; cv=fail; b=u7cOKsfTpKvH0zhLQ203FgmACj1STCgD37t/7RRGst/hnd0hf2kYNPLJY0HbBep37jHHwNN98BAoiCU68hTEMgL/k7HwRmcRN71R9mss5CTeLBgPOk6NTSQApdS6Wqg6wtHY9wCRZGZQKF9YuKl29uGHCKEv2UpaddavQl/dH6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354313; c=relaxed/simple;
	bh=yGD4+oEWH3mhJHREyfS81Syma0QAWzYU2dKfbQA1hCY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uhy250n6W52nC3YXHQMKZKxyK+vTPrOpTCJGDAcAYcS0iIYTNl1SDmS1JrK9XNGQczY/kuZukSKKJzkCyw6I5B1ED6zhmfCHFOFGa6LYgBZsmhWuYUyq302LOajOBXzMiLqrau0i3siXt9GS93XnW7tLpcf7GzeM3y5hO8ctH94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hycjP4uN; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9Xdcig41dXe/6Dj+xP7gbBXcVbZkAPRjD+DQqO5/Zdlj0EeNySyCZ8zBOS+LxnA96z4aOnqgyPqVxSNIK2CpGUl2zUq/VgP8jeo06VY2nJGFX6GznpVuyubFYu3ZeNUyiymCnRT3TiAhQFwLK527N4L6vFZ3y15dMPEr6j9vfL+DBotvUpEziQnk51w9RtmzSsV9RMk8m3byCnzFospKGlJwF/USAZjFkQ8Ez4f9GFVKVM2XogwILrEyFQqQ22NWVvN7W0qEKOAMQzjihEFE7dFd8OqD1HIbQ2kP+vqa1iagwC2hFJkzb0J1M/puO5io0BrE8wvsQdWDVAfKQy3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwslmbOobTCYPVkDH/sxVzW78KGZXXZihmaQROlUwlE=;
 b=qGnRcJTrL3ASd+vnOPWJQ7dYv43iaOmKWF7h4c0m1PapS+cyU+0kUyo3F4Xc36e5KBOi3tu1uVaUE7Hr8oEqCwhEsZNqYms4vqEyv76MO340eOsRTgx10aob3AMWdJ9WOkTnBth/ZApiRgpEZVWD5LrE4wXRh0eS1TGtp+1aHzDgNlyn4+4DUXggyKkcX30OXPFTUr6G5lMF0B3DwKRJyH8Nm+0AnEgbYbuDD6uRU9Rpk/p195Ycot6G7J0HrP98bPo0jRMnpfnPPl3q79bpr+1b6Urwbiy3GKBlwDVRsTV2eqt6uGQgHR0Ar2EPyay1TzW7rd3dRPyyzkpBGp9HEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwslmbOobTCYPVkDH/sxVzW78KGZXXZihmaQROlUwlE=;
 b=hycjP4uNEAO2SuPUXIDnUopdVZZPQVhhO/eWfalJjUQlvvtk3WAVxSA5ZYkfHwuYCt9XaMnCgyqTVBDiuwShTcgo34klXC76sve0LC7A1umDk2TjlVnSVLd8MiEZV0Tms4ZNGr6REjohKxKPJlZyYxJp9fsLSI+Bp9n7jwHDxiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Fri, 11 Apr
 2025 06:51:49 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 06:51:49 +0000
Message-ID: <e91f1c4a-5319-49dd-93fb-16275ed8607f@amd.com>
Date: Fri, 11 Apr 2025 12:21:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 3/8] security: Export
 security_inode_init_security_anon for KVM guest_memfd
To: Christoph Hellwig <hch@infradead.org>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-4-shivankg@amd.com> <Z_eEUrkyq1NApL1U@infradead.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <Z_eEUrkyq1NApL1U@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: ff12667c-9098-4bd1-8cbb-08dd78c554e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFlOdGV1MUVCUXdJWXIzZ3RpcjBVcEprU3cwQVRnMEtWOS9TNXg5SU55WTE5?=
 =?utf-8?B?Q2xQWVh0Ny9KYUNFYmJGMGQyWUFENGdVcHAxYUZUYi9BSkN6N3JjT3VQVkE0?=
 =?utf-8?B?Qnh3eVZxQThWOURVWk1BQ2FHTllQTjF2OEhMdHVEdVAyc0NRcnVnMHh3WTg3?=
 =?utf-8?B?Q0Z2MVhaaUFyVEtwRU54ZEsyZG5xUEljOG00MzcrRGZvd3dNTkNQVkV1YmlL?=
 =?utf-8?B?czgwdWZaemNEMk00aWhJWUpWcmNySlBwTFhPcGI2SlNFK0RvY3FlYUxNdnFp?=
 =?utf-8?B?WUxicU5DMFBaQzRleHo4SDg0cnFaYStPVzZSUzJIMEVHeXA3RjFKcjlLaTFr?=
 =?utf-8?B?cElsdFRxYXk5VTdSdlh2LzZKSkhuNDVRd3I5cTdzYUJqalZlMHpvMmlBTVRv?=
 =?utf-8?B?dEo3L0VUcGQ1MmJLZFU3dk5GOEY5cEtLVWZUTnkzalRKQTkwZHBsb3ZKcUlr?=
 =?utf-8?B?dkprUjJqa041Sjd6cjZyTjd4V3Q4dHdNN2U3RmhqcWk4Y0x0VFBkOG1tbi9o?=
 =?utf-8?B?azVtWnV3M0ZWT2xjUHJWWFd3YWZHTUwvTk9RZE1WSE1mQ3k4UktKWmR6QWNz?=
 =?utf-8?B?MWxEaEJseEMwT1VxTGxCWENuT0hYSlJ6azdKTkNGYWNkaTFodW5aVGNKOHJ6?=
 =?utf-8?B?bVJCQnliZ1pqOW5WWjQrekdsZmMrN1NRMTRNWGsySHZ3OXJQMENUTGNCVHBE?=
 =?utf-8?B?NTkwN0lsNW5JanI3bHFVbUIydDRLditSTEVyZnNlY09nZ0ZCdituY1d2T252?=
 =?utf-8?B?V29BR0JNeUxhMUpkbG1tWTY2d0JXV09TVDBBUTdYY1N5QXlsMXIwa2xNcGRZ?=
 =?utf-8?B?MGgrbSt5UThrMHFYTHAyQThuYlhlRG5FcjZwU2xwemhoSW1WSnlYQm1ybkpr?=
 =?utf-8?B?Ync1MHlMeExDZGxaZnlZNXoxNGRqcVFPU29PQkpEeGxSZitiTnROVVVWY3Yw?=
 =?utf-8?B?SVZlR2RCUmVGanZmRXZZNG53NkFKMEthb29uSjRsMnhxQVpEVjRNem1YMG9F?=
 =?utf-8?B?MEhwRXdveDZ6WE5Ubk85blByMFd3K1FlZzZvZFJmYjZhU1BidHJHUHFITERF?=
 =?utf-8?B?NUU3MU9JTEpDc1RJS3plN0V0S1FPNDhyWENiWEVHbmZUOW9MRXJHNlJIeTg1?=
 =?utf-8?B?U3d6Z1NBZ3h0TFpsZEZCQ1AvZHVGaEJwREs1a0xpbXlmNU15dVpEczVQN1Ay?=
 =?utf-8?B?R2hQV2hZV0xTNzE5R29TbTBCNkpIeUFpckVuUkFETnFTRGxseEZpQ0xPbmxT?=
 =?utf-8?B?QytDdTFJUjAyUDlmbmpXcWhtSHpJVEVwaEtGSnJvZkgrYlJCWjhEVEJKWmU2?=
 =?utf-8?B?VWFyT2NXR29iYkZNM25jK2hiL21NZ3UxNGJmV2tHTCtsWm45SEZFRnJtMjhy?=
 =?utf-8?B?ZWc4eHJSbVJta1JsUzVGeU5jb3kxN1FBOCtLUzFhd09rWFBrK0tQaStTajlh?=
 =?utf-8?B?RWhOb1BMQm40eXVMMDZjd01LOTdXWXV3d3Q2NjdTRjBmb2RIS2tKZmNVVEIz?=
 =?utf-8?B?Rytsb1JLT0NxWU5aQ3JmZ0tqd3FleVFnTFlUT3NDWXR6M2FxRnBhdkw1M24z?=
 =?utf-8?B?QkpSRHpFTmFLRFlDTE4vYXhXZkI1RkpPMURmSHZjL2NXdmlYcTBGb3ZzVzRT?=
 =?utf-8?B?NmZKUDV5bStzU2hiVytNUFNHOUlXSDVtR2NhY0IwdmFYZHJkZGt1MFM5Mzlh?=
 =?utf-8?B?eGx6N2xoc1BRL2dlY3lqVzZ5Mmk1bFArNDMwYTR3SnVJV2p3K0FWa1YvMXFv?=
 =?utf-8?B?N21Ebi81S1hnNldLMmNPTlJDaEs5NG9EanQ0N0VYTWUySmdseTdCKzh5SnZ1?=
 =?utf-8?B?Vm1lcTlOd21zd0RIbzZiMWdXRDlxNjJLa1RtRFlNY01GeHR6dit4cnVNclJS?=
 =?utf-8?B?RlkxTC9tQUdvd2VIbmpXd3Y5SU5mcmduZ3ROdjB0bVJaVFZTbjVid0E2aVNX?=
 =?utf-8?Q?nUgPo4iBUPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmxlV0VFL0hpZzg2U2kyU0N6RjVVTGF5L0VBRmw1TmZ1MHhWejhmQU1EZFVn?=
 =?utf-8?B?UkhTRVVkcXBERjFoWFRvYzZhUUF2cTBZYndZQmNDUnJpVmRCOTh4MzVOYzRE?=
 =?utf-8?B?UlBSaXdNTXhHaDJLbFVOcTJoVFVQdzdzaEp6UlZ6YkRwZXYzQ0lrWmp1ckpG?=
 =?utf-8?B?WUplMTZyYzE5a084UTN0RzVTLy8veDBvNjkyRDRhb2pvL1pSWnI1SUZTQkdI?=
 =?utf-8?B?NDNWWHRodlNKOFdhaG9wekIvSHhYQXFJUjkzbGNVSzQ3QU5JajJmMWE4RWo3?=
 =?utf-8?B?MkIwQWg1TzlwcmR3SDg5OHB3dTFOMkQ0amNPY3p4bkozMCtoQlhteDdFK3pY?=
 =?utf-8?B?VDg1bDVnY3VyL0RhTy9iRy80VmRQRGc3VEhuWUM0RTAxZmlvR3krSDFWS2Vh?=
 =?utf-8?B?OEdXMTF1VzRlSVljMDZ0clR5a3RKam1xVmxzOVQ3UFJlUVgvU1YzVmJKajM0?=
 =?utf-8?B?bGFtWFJmZ3ZDM0Z4V2p2OWRNRE8xVmFHbXZ6ZUpFZFo1TVd6UnlaR2RaeUVM?=
 =?utf-8?B?amRrd2NuOTNjU0dtSFV3eVhLVmkrNGU4a2xiRDJvdHdjTXZkVW1lZ1hjdlRQ?=
 =?utf-8?B?RXpDdUhrQ3NhZkZOWjM0QUxqWHQ1UFlXZVJiZnRYYkxQSmF0eGpVeURtVHBK?=
 =?utf-8?B?QUlBM0lUSnVkRXl3cjZKRmZZWEl0R1l5ZG5YcG9PaVM2NXE5a1RHK1NMd2xj?=
 =?utf-8?B?cEJmT2NTeUxQM1gxQWZzYnIwMzNBODUvMWFLdnUwTzFPSHFsRjlCZHZqQ2hn?=
 =?utf-8?B?b2cySzNRU29ka3lxT0M3aVRyLzZxQnpnQjF2MWVWWHRJdmRHN2FDUys4Sks2?=
 =?utf-8?B?U1ZVWTA4Y01ZNkVoZDV3RkFYNjZGNkxJWFBuSUt6eWJqcmRCS0trQXZhT2VX?=
 =?utf-8?B?YUg0dWc2OENUaWFPeFRxRmR0V01vQnRpbWZCZjBIKzh5MVFCcXI2V1ZKR2lM?=
 =?utf-8?B?WnNvd0hYTnBNVkpWMjJwQ1pla0ZRd3RSSk1vK0RDY0M3Q01LOVVEUC9zRDdD?=
 =?utf-8?B?QW9UQXhyQVp4QUFKZG9uQ0JrWXlMdVhPZERnMTZETFJjSng4UTVuaTVlZUpq?=
 =?utf-8?B?WEFxSFBON1N4WDJpd3NQVE81Rnh2aDVWRkhjQVVka3QyUTdvWUxTWjMzNEJt?=
 =?utf-8?B?RG9PNEtYYS91M0pOMGFnRWFpUzhnV3dlVng3SUdFTTRFeTFjODNLNm5hZ1FW?=
 =?utf-8?B?Y011R3l0QzhnU3hMbGZUY2duL0EvbG5VYkUwb0x2OTk4eExDaU9BY2lLMy82?=
 =?utf-8?B?VFZUTG5BQkswRHdVckFEc3VNNDNFaTBIZGp4SnkzdFBCSGhvYjNxOTR0eU1J?=
 =?utf-8?B?QWhwZFVZdW45V1JmUUYrRy9vUERIT3l4bWxTenhuaUZUQkM4bTZaZ0VrL1I5?=
 =?utf-8?B?SjgyTEdIU3ZXa0lmakM5dnlPd08wdTdNR1NscW9vUU1LZGcwVW53R1kzRmZp?=
 =?utf-8?B?S2dHelVxNVBOblBjZDZwNFNsOTN3NnpFUzJKSXlTUE12cFFzbHhlTTlhQmFT?=
 =?utf-8?B?U24zQmlybjBwdDRyUjUrS2ZTN0hHTWR1UHZhUTVzRjl1WmRlRFp2NlJhQmMw?=
 =?utf-8?B?N3BVajZNbTExY2FaSEZXSXF1ZGt0eFNXd1ZmMlVqU2xlN3VMcURnMGgzTnZs?=
 =?utf-8?B?azdlUG41VExLRXdpemg0V2d6VEZYK2VobXhBOUhKU2ZVRlRDcy8rdWV2N3JM?=
 =?utf-8?B?OU4rU2pkTzQxUG0rVzZaOGJJZzB3VE0weWpUZlYyYlFmeEJaS2w1b0IxTUZy?=
 =?utf-8?B?Rms5WWs4R0R0UVVScWQxWml6MVlXNFFnb05XQVdScnVBeDdONEJzUDFCMUcz?=
 =?utf-8?B?RmhkQlNVb3hGa200ZjBGbUZGcmRsYXExMXBFY3hPNjd0YWhGa3RlcHVNSCtu?=
 =?utf-8?B?dUtiSE5leFVuVURFRTFDMkdGYU93djNDSW5QQjZlMGt4aHNYSG55QlpyT3N2?=
 =?utf-8?B?UjVYOEhUcWE1TjlDQ3JWeGVucGswNG8zM3Y3QzBEdmtvUDA4aFJQTEptK25t?=
 =?utf-8?B?ZmV6b0V1d1pXQWkveEFBcW9aMnRtNURyUkJvQWxUOS9sZlc5SGRDb1RuODRP?=
 =?utf-8?B?WmVXYm1NMEkvODlvRVhkR0RaTGZFaFUxVnRYTVo4RGlXWkp4WE9UV09iTXZ5?=
 =?utf-8?Q?hZw/dHecZPo78H1YBiy/DcJF5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff12667c-9098-4bd1-8cbb-08dd78c554e6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:51:48.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM9d5WrJJuTaSPRTgNgmqk+uekUFp2Lg9sAXFfrJebhK0t9zPWhos0ToYRwj7p0iMxPuQPBgDCODeHg5+yQXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066



On 4/10/2025 2:11 PM, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 11:23:57AM +0000, Shivank Garg wrote:
>> KVM guest_memfd is implementing its own inodes to store metadata for
>> backing memory using a custom filesystem. This requires the ability to
>> initialize anonymous inode using security_inode_init_security_anon().
>>
>> As guest_memfd currently resides in the KVM module, we need to export this
>> symbol for use outside the core kernel. In the future, guest_memfd might be
>> moved to core-mm, at which point the symbols no longer would have to be
>> exported. When/if that happens is still unclear.
> 
> This really should be a EXPORT_SYMBOL_GPL, if at all.
> 
> But you really should look into a new interface in anon_inode.c that
> can be reused instead of duplicating anonymouns inode logic in kvm.ko.
> 

I agree, it makes sense.
I'll use EXPORT_SYMBOL_GPL in next version and look into reusing reusing
existing logic.

Thanks,
Shivank


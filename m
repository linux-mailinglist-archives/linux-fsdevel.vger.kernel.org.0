Return-Path: <linux-fsdevel+bounces-48449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D956AAF3D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64931BC1C3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFE32185A6;
	Thu,  8 May 2025 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hh7uQ/ES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F0217736;
	Thu,  8 May 2025 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686274; cv=fail; b=trlNvecV2CXsEPvqYZY0fN7s3bdD7Cw/0cB5/iDEhw2mhzWwNVKvGIyC7VrGQ2tsKn21JTf04yLc3cTKKXXmk5N5oz4JDaTMxzY54Eq0mwRvjPW/PUaZK2T1V2gNPQVy1Qgb6DJ7PQNkkrsD5XrFsyRtse6X6Rw7Xi/MFgEl2bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686274; c=relaxed/simple;
	bh=/T4fc8S0aGSn5oHrrGuJEuhleBLfW1/BWNgEugQm3Wk=;
	h=Content-Type:Message-ID:Date:From:Subject:To:Cc:References:
	 In-Reply-To:MIME-Version; b=Ay6/85ZS1YSBJ1Dz+T7/svOOC6YbFpbBcZmSpsaqrandtaBhNf5WWrjWFcGpS5OX0o79eSwtAKWUg9bjHUH/ytYqN6s2j15541jlx5qTF2MB2FhI8M2HzkpTrrOKYeoG5M6IUe3VjTAOBnApnecmqtLs3iy7RgdWA9Q6RpFlwGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hh7uQ/ES; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeJu8fdXBMikTVYaAF2dim02swyvBDIFNt6J0HYVV5hCGpp4px3zbhMfM9oCdY2j6cpH7nGbH0Zo8VHbGCluQlCd0I5FKXkPK77kZjzUXYB+RjYvI5PJ5dfK14fHV68laxQeM0jjQZNZKuZFMyBT3kkezbReGTDT9HNeDGC4lb/fwgHHU3mcoNWdDkIBxZSqcUb9Fxcv6K2c1r204Fa1apqEZeDbBCc9IzayvOX3ptEM77bk9e+p4oYV1Rd/ChNO+6JvgDLcRrTedGdVL/tDBmbCWyIuZANERL273VfE5J7aoNOnL2XWnj9HKBR7/4cc637vi28u7OHBSCHMOzEh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4gH6vmlqu/hX8l9hiih0kUqJdcHpHGqZserN/dDONw=;
 b=AywYH0bBSXji8p5ameEK9XyMcXM/nN/JRkb3PK1SyCj6/NXiu/fQ8fHwIloLOyPuNB3zUH+2LG6RDNhUEPuKBDFeQxBoGsrzIUSLVczILtsbU5dExDxD2fL2NPefg8TkNgBByxJFYbybZaZ/I1cA1jAKCXLDFD2tGOc4reGC1nmCQlchuCtKSb7WHIhuQsDM9JE23mVk4yHdKSs+oT1wIR0LF4isRppIeUHUvJZPITUY45ec7TQNNBm8FvOmq1tzjQHUbVR6ToMTA5hcv1hIoLMKBEPKcfFRbsnQZtet1wcINmNgxK6OoCgTsYyh13vrSTgjBCP3e8azhdP9hcZOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4gH6vmlqu/hX8l9hiih0kUqJdcHpHGqZserN/dDONw=;
 b=hh7uQ/ESm3G+z7SkfSqfKTazvwvvep9WyywAUlNgmwEa/Tes1SBASkaoln3APf2tUbUlBaq0hdqUa4eAwUckVkIBCGQSDLZ5LY0fVi93nIK/auuO820Q/f+ze22FWVrWj+X+tyAtewtjv80DuZpswm06WiXGZncS1tDZyLGVi7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 06:37:48 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 06:37:46 +0000
Content-Type: multipart/mixed; boundary="------------20J8wHG41v0zlwJYCL04QA7w"
Message-ID: <fc6b74e1-cbe4-4871-89d4-3855ca8f576b@amd.com>
Date: Thu, 8 May 2025 12:07:25 +0530
User-Agent: Mozilla Thunderbird
From: Shivank Garg <shivankg@amd.com>
Subject: Re: [PATCH RFC v7 3/8] security: Export
 security_inode_init_security_anon for KVM guest_memfd
To: David Hildenbrand <david@redhat.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Mike Rapoport <rppt@kernel.org>, brauner@kernel.org, Jan Kara <jack@suse.cz>
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-4-shivankg@amd.com> <Z_eEUrkyq1NApL1U@infradead.org>
 <b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com>
Content-Language: en-US
In-Reply-To: <b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com>
X-ClientProxiedBy: BMXPR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::20) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c919c6-e476-4e1c-b51f-08dd8dfad7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDZGbEs2TlNKRktVWlpPbHBvOXBLa0gxRlZPNGNFY0MzS0NTMjAzNGFEeXJp?=
 =?utf-8?B?Zk5FaFN3ejVtQlB6UTV2UWxHSy9IOWJrWXBhcXo0SDRYekgybW95N0RYSk9F?=
 =?utf-8?B?U0dTK0NuMkJaTStSbFJ4T1RlYWRDTWdxTk02NTFhSHZKSkV1N3ZQSURRTXQ5?=
 =?utf-8?B?b0haN0pOR24xOHZtdzNmR2l4OWFwYTYvakRNYXpWcDE4TnJQVy9NTXJzRzRo?=
 =?utf-8?B?OExSMHA0K1p0L3UvdE8wMEs3a0t2cE5PcGdnYmJOMjVBODVLL1RRMXB3aDY5?=
 =?utf-8?B?aWpWQ0JHTGdsN2pCaXBvRTRhMDlrMittMUFTTWpnbTJqRlJUdVNXQzZSajA1?=
 =?utf-8?B?K3hXcEVsNWxUSXl6L1VVc01Kb0dxRm1lR2NVU0loVm5nZTNXS3pHN1NRRDJv?=
 =?utf-8?B?VkhDbW5ndWNrNXZuQUJoN2ZLcnFrKzQ5R29YNXhkL05vWG5hL1d6d2RidzFs?=
 =?utf-8?B?d1NDa1hsbzJqdi85TmU5RmZCbEtMODcySW9uaVpCNXBaKzBraHZHR0JOTWEv?=
 =?utf-8?B?Mk44SDdaem11YXNieHlxRXIwbGFYeWhmbnZDSHRpZ0tnTGhleWFQMXNNS1l2?=
 =?utf-8?B?dDRBRGtoR3Q1azY3MnhMSkxoK3hNRUpGUzVzVlBVZTN2S3RuTitaMTBMMHk4?=
 =?utf-8?B?NjlycGpwd3FKQ2FLSU1kMWVNUWthc3d3VDBrVDZkVUlRdDFOUDUycnN3Tlhl?=
 =?utf-8?B?eEVOUUpNRUZmNmpZdkdKdnBrRlJOVjhDeDJid0FvcnZ2R1FnSWp5VkY3OXhi?=
 =?utf-8?B?dWptMGV5cVBIc3Q4VjRMRlJPMnJzclNsYUkzRVRpZVdZOFMxcWtSTGhRMHMr?=
 =?utf-8?B?a1V5am4rYTJUaW5lZW1wcWxqUzNCRURvRHEzQVhIaGRrMFl2VEdpMW5mVUZr?=
 =?utf-8?B?R3ZXemR4T3V6NVdvZ3llbmkxSXFqY3lGTFdxM1NRcjRGR0V4WjY0cVdlNmhB?=
 =?utf-8?B?RkxBVm5QMWxLVTk1QlFDYnpCeGRySnNWYUZYWHlIaHF3MVc1bGpWMCtSZ09u?=
 =?utf-8?B?aytYQjV3Ym9za0RGSFN4MFdneWQ5aURqejdDeG5EaHpueDBtUzBEZEZLU21M?=
 =?utf-8?B?TUp0UUYxbXJORTRhZDdIcjM2aEkxcE5oOGFZdjkyYW5WT0Z5TVA5WS8rVStN?=
 =?utf-8?B?bjk3Z3dnaTArKzQxdVBhYnhWOGp6NVF0OEdwNXpqeFEwNCtGZzhUdGlUVjhW?=
 =?utf-8?B?OGtWdWE3V1Z6SHpidGRsNTFIMFFvVE9wVDBQQS9Bb0lRY0d3UkVKVFgxRFh0?=
 =?utf-8?B?Sjd1MENsMkJXS0RuQytLNzl5SWR2TVNTZUxOMytqWm9ZSXdPbGFWVm5UZ093?=
 =?utf-8?B?d0o4WE0rYW9NeVBqUDFxSkJ4VUcrNGlmTmtpMnZUOThVcVN5amtLOXhqYjJ5?=
 =?utf-8?B?RXJPUXNzYjNlRHkxd1ZLNDZWWVVXU2U1VzVOT01XaUdNZlkxZXo1UjJ6SWt0?=
 =?utf-8?B?TjlrQUxoaXVBSmVhQlBuZGlXM0t6aTdka3ppREhxS3E1Rk5ORTJjOW9paXpN?=
 =?utf-8?B?Uk5VWFluUkZQSUtOVXJQZ0dLTGMzUVRxT2VPbVlLR0Y4VnJER09JdHhwV2Zv?=
 =?utf-8?B?NEVrREFVMGVwdk1nUkJhdnNiTG8vYXB4dysvWWQwdEVla1RRNUNHQy91N1ZS?=
 =?utf-8?B?MVJURm5aYWx5dDg4UjgrQjJGQmxLc1Z0VXp1SkZtS2krTHdMeUptcS9BZHZk?=
 =?utf-8?B?Ti9CSUFTazYzKzcwN1NUK09XUTg0Qkp1cEN5cm1XaXRma1ptNzNxNS96alhD?=
 =?utf-8?B?SDNtQmJSOEFnSWd1WEZ6SElkR0QwdGRLUkRCNXpnMU9hb082c3RocEUrQi9T?=
 =?utf-8?B?WkdBRUNCclluT053N2Q5ZjZrMEU0UUNYZ0F3NUc5ZGxGa2YrTTYrVit1OTgy?=
 =?utf-8?B?OE1QM0c3YndwemlBcGl4ejBFaUJTMG1lMU9WbFBoeGQ0ZlhtTWFrMFlnTjVY?=
 =?utf-8?Q?guI4Vy/msh0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0EwTXd6ZVlaL2xZZHN6WGo4S1ozVHVUSk9xM2NrTVluT0Npd3JJTmZOKysr?=
 =?utf-8?B?LzJBRTZiQVN6aXp4cSttVDhNNVkxeGRrU2ZZaWpnQjBTT0NFOW9lTUNYWk5z?=
 =?utf-8?B?UEdyMkxmcUhBNmkrSnVSSnhzb3lRQkRzdUw2bS9wQzhBZXNINVo3c3YycnpC?=
 =?utf-8?B?cFZXRnlLejBwS3RGQmx1d2FmbEdaZDZJQ1J1czVGZWpBd0I4WlU3U1ZKUWNQ?=
 =?utf-8?B?Y3lNNWtzKzhyZWp3MGZJdC83MjNhZHU0RGxMeFdSVDR2K0d2MzF5RFJHRXpG?=
 =?utf-8?B?bHNUOWRqaDJXRXdmYWp5RDJweFNtQUZmcmFCbVVsRnRtbHVwa0RIRTJNa2V6?=
 =?utf-8?B?SFZkSUF0UGR5QWE5QVFlU1Ruek5HZjFEQUZ0cWVzcnpoZXloTDNKQkRUZCti?=
 =?utf-8?B?TkFWOTE1eTJOZXBTRGdIV3F1aE15R2pPRlJieDl3L1o3bk9NQmZMcWtMRVV6?=
 =?utf-8?B?NVZaUHJuTUFBWGl1bUFmYVAvMTFERjJPWnBUK0RZeFhlcDcxYkFZd0dubFRX?=
 =?utf-8?B?MDdnazlKTzFqNFBYVWlPK3FaVDJXNXR5YllxT2JkWnRoZVZDcVA1VFcwems5?=
 =?utf-8?B?ZVRLTS9ORWtRazROa09Rcy9KdURtdTdocmRHL2tJU2F1YnJpQmhBdkQ2VEYx?=
 =?utf-8?B?dDFWYVpETWdXMUtUeTJOVUEzQlVUSWJGL05LSFF0bVdqcjFJOWFpWlk2dmFp?=
 =?utf-8?B?eU5OcjNuOGdRWWx4SEhFRysrZHFuWkV0WUQ5UXNsT3V0NXZnT21uYlVBMFhm?=
 =?utf-8?B?clNqdDFZcnF0Y2tVQ3liRW1VS0RVWkRreXlxWXczcnJzUzVzcFR1Sm0wNW1N?=
 =?utf-8?B?M0liRjVxVkxEdUlvNHhaWjN2eWNPVkdyOFc1WW1sUDAwN1VRcUZrc3M3TkE3?=
 =?utf-8?B?ZVB6cTFYUDNiOWdjZXJXMUJOdU9BRG15SFBMMmoxWVlMYjZFS3J2Rk1xWnlj?=
 =?utf-8?B?NXN6cXh4M2RRS3k0QmpJR1ZubDJWQ2JVZmVoVGYxeTRVWS9oL3lVZ01TRlJB?=
 =?utf-8?B?ZU1kb3lDSTI3YVdXTm85d3BaYUVSY2liU2hlVG1SVEllWDJ3T3A1NEZiaGxq?=
 =?utf-8?B?cUFkeC9wSERQdzhEd1V6WUp5Y0E5RThCR1VzQ2c5ZDllZSthYmphVXhtU0xX?=
 =?utf-8?B?bld5aG91K1d5c1BVc05TWW44bjF6eTZ0SS95Y3duUDA0YXp6ZEw2NklZOE41?=
 =?utf-8?B?WHMwdXhmcHZoREZwMWtjSnNiZmJPVXlEbzhtcnhoVmpBN0RReTdKZXBNK3B0?=
 =?utf-8?B?MUl0WXY3RUlDVzNzWjJ2T3dSVEVSb2NDTWlwRWhhUXR3Nlp0QUQ4L3NIRnkz?=
 =?utf-8?B?UGUvNnVaam9WNFdiWlZjME9RRXBPNWJPZ1RCTHNHdVVFZE9KK0s4bFhxdzl3?=
 =?utf-8?B?RGQ3QmVqOHhKRlV0Zm5TV1J5Z3UwRTdycGM3OC9EbE5xMzdEUXp1ZHpBei9l?=
 =?utf-8?B?dS9YeFk2UENOUmxMR204QlFmQ3duY3VIbkltaVBXb1NzbVRMREt6bkNwanlX?=
 =?utf-8?B?Tm5XM0lQRm1qSU9ZWGhmZWZwbTluZmxmMC94Tyt2NXI4NWFJL2p6TWhTamcz?=
 =?utf-8?B?SGo0RmF4eE9XZk1LelVwYnhBaWlxdm03Ty9JTWFXd3NmWEZnNDQvRGNIaTlL?=
 =?utf-8?B?SW55U0hMelN0ak1WUFVlMzNtQlNtUnNXVFhoVWZ1VWU2VUFwb0d1SUxvMzNj?=
 =?utf-8?B?dDJCQld4dVRGNGdoNDdBQmhBdlFjMEIvbVU5QURIQklPcHB2MjU2dS9hb0VT?=
 =?utf-8?B?aG53bExrb1RpNGZvM1Q3dkhJRkgxakZHOWVpQUc5VFc3c1ZmbUVLZ3NLb2Jm?=
 =?utf-8?B?Zy91U3R3QjVPRm9xWklTSzc2bm0rd1NMUk54dzVhK2pXU1N2TFdWTk5pMmtY?=
 =?utf-8?B?M0RnTk5Hb0NrT1g0ZmorcXFpUjUyYXlFQ2xRL1ZEZUprTndrY09DTjFxY29l?=
 =?utf-8?B?blhsNlBScUd5OVFZa3Z6NnBmSlgrSWpxL3d1b1lWTTA1YW5qSlk0c0NIaU5k?=
 =?utf-8?B?cURXaHdPam5Lc0xGQjlCNXhucVM2M0tOc3JQUmxOdThjRTNJYW11dmFTQW00?=
 =?utf-8?B?aTlsbW8zZ095U3NNbzlDMEY4aWE5TmZFQjcxcStaMnIrZkJ4a0RWNFZ2RmR5?=
 =?utf-8?Q?M2OotYNT7MSvO53OC4VBNGIdz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c919c6-e476-4e1c-b51f-08dd8dfad7aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 06:37:46.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+kqvJRsLZN/eb+T2NbKzjrVTNAeXu1Hlqr6xZJBcprInfLMYMPNFnvFLv6cOjo/9qK0XBEpyACiB6rManyGxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709

--------------20J8wHG41v0zlwJYCL04QA7w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/22/2025 10:55 PM, David Hildenbrand wrote:
> On 10.04.25 10:41, Christoph Hellwig wrote:
>> On Tue, Apr 08, 2025 at 11:23:57AM +0000, Shivank Garg wrote:
>>> KVM guest_memfd is implementing its own inodes to store metadata for
>>> backing memory using a custom filesystem. This requires the ability to
>>> initialize anonymous inode using security_inode_init_security_anon().
>>>
>>> As guest_memfd currently resides in the KVM module, we need to export this
>>> symbol for use outside the core kernel. In the future, guest_memfd might be
>>> moved to core-mm, at which point the symbols no longer would have to be
>>> exported. When/if that happens is still unclear.
>>
>> This really should be a EXPORT_SYMBOL_GPL, if at all.
>>
>> But you really should look into a new interface in anon_inode.c that
>> can be reused instead of duplicating anonymouns inode logic in kvm.ko.
> 
> I assume you mean combining the alloc_anon_inode()+
> security_inode_init_security_anon(), correct?
> 
> I can see mm/secretmem.c doing the same thing, so agreed that
> we're duplicating it.
> 
> 
> Regarding your other mail, I am also starting to wonder where/why
> we want security_inode_init_security_anon(). At least for
> mm/secretmem.c, it was introduced by:
> 
> commit 2bfe15c5261212130f1a71f32a300bcf426443d4
> Author: Christian Göttsche <cgzones@googlemail.com>
> Date:   Tue Jan 25 15:33:04 2022 +0100
> 
>     mm: create security context for memfd_secret inodes
>         Create a security context for the inodes created by memfd_secret(2) via
>     the LSM hook inode_init_security_anon to allow a fine grained control.
>     As secret memory areas can affect hibernation and have a global shared
>     limit access control might be desirable.
>         Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
>     Signed-off-by: Paul Moore <paul@paul-moore.com>
> 
> 
> In combination with Paul's review comment [1]
> 
> "
> This seems reasonable to me, and I like the idea of labeling the anon
> inode as opposed to creating a new set of LSM hooks.  If we want to
> apply access control policy to the memfd_secret() fds we are going to
> need to attach some sort of LSM state to the inode, we might as well
> use the mechanism we already have instead of inventing another one.
> "
> 
> 
> IIUC, we really only want security_inode_init_security_anon() when there
> might be interest to have global access control.
> 
> 
> Given that guest_memfd already shares many similarities with guest_memfd
> (e.g., pages not swappable/migratable) and might share even more in the future
> (e.g., directmap removal), I assume that we want the same thing for guest_memfd.
> 
> 
> Would something like the following seem reasonable? We should be adding some
> documentation for the new function, and I wonder if S_PRIVATE should actually
> be cleared for secretmem + guest_memfd (I have no idea what this "fs-internal" flag
> affects).
> 

Here's my understanding of S_PRIVATE flag:
1. S_PRIVATE tells the kernel that an inode is special and it should
skip the LSM permission checks (via IS_PRIVATE()):

​For instance,
int security_inode_mknod(struct inode *dir, struct dentry *dentry,
                         umode_t mode, dev_t dev)
{
        if (unlikely(IS_PRIVATE(dir)))
                return 0;
        return call_int_hook(inode_mknod, dir, dentry, mode, dev);
}

2. In landlock LSM:
S_PRIVATE inodes are denied from opening file and getting path from fd
syscall: open_by_handle_at
calls do_handle_open -> handle_to_path -> get_path_from_fd

static int get_path_from_fd(const s32 fd, struct path *const path)
{
...
        /*
         * Forbids ruleset FDs, internal filesystems (e.g. nsfs), including
         * pseudo filesystems that will never be mountable (e.g. sockfs,
         * pipefs).
         */
        if ((fd_file(f)->f_op == &ruleset_fops) ||
            (fd_file(f)->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
            (fd_file(f)->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
            d_is_negative(fd_file(f)->f_path.dentry) ||
            IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry)))
                return -EBADFD;

Using is_nouser_or_private() in is_access_to_paths_allowed() (allows accesses
for requests with a common path)

static bool is_access_to_paths_allowed() {
...
        if (is_nouser_or_private(path->dentry))
                return true;

3. S_PRIVATE skips security attribute initialization in SELinux:
security/selinux/hooks.c
sb_finish_set_opts(){
...
                if (inode) {
                        if (!IS_PRIVATE(inode))
                                inode_doinit_with_dentry(inode, NULL);

4. mm/shmem.c
/**
 * shmem_kernel_file_setup - get an unlinked file living in tmpfs which must be
 *      kernel internal.  There will be NO LSM permission checks against the
 *      underlying inode.  So users of this interface must do LSM checks at a
 *      higher layer.  The users are the big_key and shm implementations.  LSM
 *      checks are provided at the key or shm level rather than the inode.
 * @name: name for dentry (to be seen in /proc/<pid>/maps)
 * @size: size to be set for the file
 * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
 */
struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
{
        return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);


From these observations, S_PRIVATE inodes are handled differently from other inodes.
It appears to bypass LSM checks (probably saving some cycles) or In other words, it
ensure the LSMs don't try to reason about these files. While it expects the details
of these inodes should not be leaked to userspace (indicated by comments around
S_PRIVATE refs).

I think we should keep the use of S_PRIVATE flag as it is for secretmem and kvm_gmem.
However, I'm uncertain about whether we still need security_inode_init_security_anon()
for inodes that are already marked S_PRIVATE.
The two seem contradictory. First, we mark an inode as private to bypass LSM checks,
but then initialize security context for it.

I'd appreciate the guidance from the security team.


> From 782a6053268d8a2bddf90ba18c008495b0791710 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 22 Apr 2025 19:22:00 +0200
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/anon_inodes.c   | 20 ++++++++++++++------
>  include/linux/fs.h |  1 +
>  mm/secretmem.c     |  9 +--------
>  3 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 583ac81669c24..ea51fd582deb4 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -55,17 +55,18 @@ static struct file_system_type anon_inode_fs_type = {
>      .kill_sb    = kill_anon_super,
>  };
>  
> -static struct inode *anon_inode_make_secure_inode(
> -    const char *name,
> -    const struct inode *context_inode)
> +static struct inode *anon_inode_make_secure_inode(struct super_block *s,
> +        const char *name, const struct inode *context_inode,
> +        bool fs_internal)
>  {
>      struct inode *inode;
>      int error;
>  
> -    inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
> +    inode = alloc_anon_inode(s);
>      if (IS_ERR(inode))
>          return inode;
> -    inode->i_flags &= ~S_PRIVATE;
> +    if (!fs_internal)
> +        inode->i_flags &= ~S_PRIVATE;
>      error =    security_inode_init_security_anon(inode, &QSTR(name),
>                            context_inode);
>      if (error) {
> @@ -75,6 +76,12 @@ static struct inode *anon_inode_make_secure_inode(
>      return inode;
>  }
>  
> +struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
> +{
> +    return anon_inode_make_secure_inode(s, name, NULL, true);
> +}
> +EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
> +
>  static struct file *__anon_inode_getfile(const char *name,
>                       const struct file_operations *fops,
>                       void *priv, int flags,
> @@ -88,7 +95,8 @@ static struct file *__anon_inode_getfile(const char *name,
>          return ERR_PTR(-ENOENT);
>  
>      if (make_inode) {
> -        inode =    anon_inode_make_secure_inode(name, context_inode);
> +        inode =    anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
> +                             name, context_inode, false);
>          if (IS_ERR(inode)) {
>              file = ERR_CAST(inode);
>              goto err;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e3..0fded2e3c661a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3550,6 +3550,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
>  extern const struct address_space_operations ram_aops;
>  extern int always_delete_dentry(const struct dentry *);
>  extern struct inode *alloc_anon_inode(struct super_block *);
> +extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);
>  extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
>  extern const struct dentry_operations simple_dentry_operations;
>  
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1b0a214ee5580..c0e459e58cb65 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
>      struct file *file;
>      struct inode *inode;
>      const char *anon_name = "[secretmem]";
> -    int err;
>  
> -    inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
> +    inode = alloc_anon_secure_inode(secretmem_mnt->mnt_sb, anon_name);
>      if (IS_ERR(inode))
>          return ERR_CAST(inode);
>  
> -    err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
> -    if (err) {
> -        file = ERR_PTR(err);
> -        goto err_free_inode;
> -    }
> -
>      file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
>                   O_RDWR, &secretmem_fops);
>      if (IS_ERR(file))

Thanks for the patch.
I have split this change into two patches and added required documentation.

Best Regards,
Shivank

--------------20J8wHG41v0zlwJYCL04QA7w
Content-Type: text/plain; charset=UTF-8;
 name="0003-fs-add-alloc_anon_secure_inode-for-allocating-secure.patch"
Content-Disposition: attachment;
 filename*0="0003-fs-add-alloc_anon_secure_inode-for-allocating-secure.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3OGY0ODQzN2E4OGIzYjcwYWE3ZDgwYTMyZGI0ZjI2OWEwODA0ZDE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4K
RGF0ZTogVHVlLCA2IE1heSAyMDI1IDA5OjEzOjA1ICswMDAwClN1YmplY3Q6IFtQQVRDSCBWOCAz
LzldIGZzOiBhZGQgYWxsb2NfYW5vbl9zZWN1cmVfaW5vZGUoKSBmb3IgYWxsb2NhdGluZwogc2Vj
dXJlIGFub255bW91cyBpbm9kZXMKClRoaXMgaW50cm9kdWNlcyBhbGxvY19hbm9uX3NlY3VyZV9p
bm9kZSgpIGNvbWJpbmluZyBhbGxvY19hbm9uX2lub2RlKCkKd2l0aCBzZWN1cml0eV9pbm9kZV9p
bml0X3NlY3VyaXR5X2Fub24oKSwgc2ltaWxhciB0byBzZWNyZXRtZW0ncyB1c2FnZS4KCkFzIGRp
c2N1c3NlZCBbMV0sIHdlIG5lZWQgdGhpcyBmb3IgY2FzZXMgbGlrZSBzZWNyZXRtZW0gYW5kIGt2
bV9nbWVtCndoZW4gdGhlcmUgbWlnaHQgYmUgaW50ZXJlc3QgdG8gaGF2ZSBnbG9iYWwgYWNjZXNz
IGNvbnRyb2wgdmlhIExTTXMgYW5kCm5lZWQgcHJvcGVyIHNlY3VyaXR5IGxhYmVsaW5nIHdoaWxl
IG1haW50YWluaW5nIFNfUFJJVkFURS4KClRoZSBuZXcgaGVscGVyIGF2b2lkcyBkdXBsaWNhdGlu
ZyB0aGUgc2VjdXJpdHkgaW5pdGlhbGl6YXRpb24gZm9yIHNlY3JldG1lbQphbmQga3ZtX2dtZW0u
CgpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tL2I5ZTVmYTQxLTYyZmQtNGIz
ZC1iYjJkLTI0YWU5ZDNjMzNkYUByZWRoYXQuY29tCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxk
ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4KW1NoaXZhbms6IGFkZCBkb2N1bWVudGF0aW9uXQpT
aWduZWQtb2ZmLWJ5OiBTaGl2YW5rIEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+Ci0tLQogZnMvYW5v
bl9pbm9kZXMuYyAgIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLQogaW5jbHVkZS9saW51eC9mcy5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA0MSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2Fub25faW5vZGVz
LmMgYi9mcy9hbm9uX2lub2Rlcy5jCmluZGV4IDU4M2FjODE2NjljMi4uNDc5ZWZjZWMyMGJjIDEw
MDY0NAotLS0gYS9mcy9hbm9uX2lub2Rlcy5jCisrKyBiL2ZzL2Fub25faW5vZGVzLmMKQEAgLTU1
LDE3ICs1NSwzMyBAQCBzdGF0aWMgc3RydWN0IGZpbGVfc3lzdGVtX3R5cGUgYW5vbl9pbm9kZV9m
c190eXBlID0gewogCS5raWxsX3NiCT0ga2lsbF9hbm9uX3N1cGVyLAogfTsKIAotc3RhdGljIHN0
cnVjdCBpbm9kZSAqYW5vbl9pbm9kZV9tYWtlX3NlY3VyZV9pbm9kZSgKLQljb25zdCBjaGFyICpu
YW1lLAotCWNvbnN0IHN0cnVjdCBpbm9kZSAqY29udGV4dF9pbm9kZSkKKy8qKgorICogYW5vbl9p
bm9kZV9tYWtlX3NlY3VyZV9pbm9kZSAtIGFsbG9jYXRlIGFuIGFub255bW91cyBpbm9kZSB3aXRo
IHNlY3VyaXR5IGNvbnRleHQKKyAqIEBzYjoJCVtpbl0JU3VwZXJibG9jayB0byBhbGxvY2F0ZSBm
cm9tCisgKiBAbmFtZToJW2luXQlOYW1lIG9mIHRoZSBjbGFzcyBvZiB0aGUgbmV3ZmlsZSAoZS5n
LiwgInNlY3JldG1lbSIpCisgKiBAY29udGV4dF9pbm9kZToKKyAqCQlbaW5dCU9wdGlvbmFsIHBh
cmVudCBpbm9kZSBmb3Igc2VjdXJpdHkgaW5oZXJpdGFuY2UKKyAqIEBmc19pbnRlcm5hbDoKKyAq
CQlbaW5dCUlmIHRydWUsIGtlZXAgU19QUklWQVRFIHNldCAoZmxhZyBpbmRpY2F0aW5nIGludGVy
bmFsIGZzIGlub2RlcykKKyAqCisgKiBUaGUgZnVuY3Rpb24gZW5zdXJlcyBwcm9wZXIgc2VjdXJp
dHkgaW5pdGlhbGl6YXRpb24gdGhyb3VnaCB0aGUgTFNNIGhvb2sKKyAqIHNlY3VyaXR5X2lub2Rl
X2luaXRfc2VjdXJpdHlfYW5vbigpLgorICoKKyAqIFJldHVybjoJUG9pbnRlciB0byBuZXcgaW5v
ZGUgb24gc3VjY2VzcywgRVJSX1BUUiBvbiBmYWlsdXJlLgorICovCitzdGF0aWMgc3RydWN0IGlu
b2RlICphbm9uX2lub2RlX21ha2Vfc2VjdXJlX2lub2RlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
CisJCWNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IHN0cnVjdCBpbm9kZSAqY29udGV4dF9pbm9kZSwK
KwkJYm9vbCBmc19pbnRlcm5hbCkKIHsKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlOwogCWludCBlcnJv
cjsKIAotCWlub2RlID0gYWxsb2NfYW5vbl9pbm9kZShhbm9uX2lub2RlX21udC0+bW50X3NiKTsK
Kwlpbm9kZSA9IGFsbG9jX2Fub25faW5vZGUoc2IpOwogCWlmIChJU19FUlIoaW5vZGUpKQogCQly
ZXR1cm4gaW5vZGU7Ci0JaW5vZGUtPmlfZmxhZ3MgJj0gflNfUFJJVkFURTsKKwlpZiAoIWZzX2lu
dGVybmFsKQorCQlpbm9kZS0+aV9mbGFncyAmPSB+U19QUklWQVRFOworCiAJZXJyb3IgPQlzZWN1
cml0eV9pbm9kZV9pbml0X3NlY3VyaXR5X2Fub24oaW5vZGUsICZRU1RSKG5hbWUpLAogCQkJCQkJ
ICBjb250ZXh0X2lub2RlKTsKIAlpZiAoZXJyb3IpIHsKQEAgLTc1LDYgKzkxLDIzIEBAIHN0YXRp
YyBzdHJ1Y3QgaW5vZGUgKmFub25faW5vZGVfbWFrZV9zZWN1cmVfaW5vZGUoCiAJcmV0dXJuIGlu
b2RlOwogfQogCisvKioKKyAqIGFsbG9jX2Fub25fc2VjdXJlX2lub2RlIC0gYWxsb2NhdGUgYSBz
ZWN1cmUgYW5vbnltb3VzIGlub2RlCisgKiBAc2I6CQlbaW5dCVN1cGVyYmxvY2sgdG8gYWxsb2Nh
dGUgdGhlIGlub2RlIGZyb20KKyAqIEBuYW1lOglbaW5dCU5hbWUgb2YgdGhlIGNsYXNzIG9mIHRo
ZSBuZXdmaWxlIChlLmcuLCAic2VjcmV0bWVtIikKKyAqCisgKiBTcGVjaWFsaXplZCB2ZXJzaW9u
IG9mIGFub25faW5vZGVfbWFrZV9zZWN1cmVfaW5vZGUoKSBmb3IgZmlsZXN5c3RlbSB1c2UuCisg
KiBUaGlzIGNyZWF0ZXMgYW4gaW50ZXJuYWwtdXNlIGlub2RlLCBtYXJrZWQgd2l0aCBTX1BSSVZB
VEUgKGhpZGRlbiBmcm9tCisgKiB1c2Vyc3BhY2UpLgorICoKKyAqIFJldHVybjoJQSBwb2ludGVy
IHRvIHRoZSBuZXcgaW5vZGUgb24gc3VjY2VzcywgRVJSX1BUUiBvbiBmYWlsdXJlLgorICovCitz
dHJ1Y3QgaW5vZGUgKmFsbG9jX2Fub25fc2VjdXJlX2lub2RlKHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsIGNvbnN0IGNoYXIgKm5hbWUpCit7CisJcmV0dXJuIGFub25faW5vZGVfbWFrZV9zZWN1cmVf
aW5vZGUoc2IsIG5hbWUsIE5VTEwsIHRydWUpOworfQorRVhQT1JUX1NZTUJPTF9HUEwoYWxsb2Nf
YW5vbl9zZWN1cmVfaW5vZGUpOworCiBzdGF0aWMgc3RydWN0IGZpbGUgKl9fYW5vbl9pbm9kZV9n
ZXRmaWxlKGNvbnN0IGNoYXIgKm5hbWUsCiAJCQkJCSBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRp
b25zICpmb3BzLAogCQkJCQkgdm9pZCAqcHJpdiwgaW50IGZsYWdzLApAQCAtODgsNyArMTIxLDgg
QEAgc3RhdGljIHN0cnVjdCBmaWxlICpfX2Fub25faW5vZGVfZ2V0ZmlsZShjb25zdCBjaGFyICpu
YW1lLAogCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKIAogCWlmIChtYWtlX2lub2RlKSB7Ci0J
CWlub2RlID0JYW5vbl9pbm9kZV9tYWtlX3NlY3VyZV9pbm9kZShuYW1lLCBjb250ZXh0X2lub2Rl
KTsKKwkJaW5vZGUgPQlhbm9uX2lub2RlX21ha2Vfc2VjdXJlX2lub2RlKGFub25faW5vZGVfbW50
LT5tbnRfc2IsCisJCQkJCQkgICAgIG5hbWUsIGNvbnRleHRfaW5vZGUsIGZhbHNlKTsKIAkJaWYg
KElTX0VSUihpbm9kZSkpIHsKIAkJCWZpbGUgPSBFUlJfQ0FTVChpbm9kZSk7CiAJCQlnb3RvIGVy
cjsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaApp
bmRleCAwMTZiMGZlMTUzNmUuLjBmZGVkMmUzYzY2MSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9mcy5oCisrKyBiL2luY2x1ZGUvbGludXgvZnMuaApAQCAtMzU1MCw2ICszNTUwLDcgQEAgZXh0
ZXJuIGludCBzaW1wbGVfd3JpdGVfYmVnaW4oc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRy
ZXNzX3NwYWNlICptYXBwaW5nLAogZXh0ZXJuIGNvbnN0IHN0cnVjdCBhZGRyZXNzX3NwYWNlX29w
ZXJhdGlvbnMgcmFtX2FvcHM7CiBleHRlcm4gaW50IGFsd2F5c19kZWxldGVfZGVudHJ5KGNvbnN0
IHN0cnVjdCBkZW50cnkgKik7CiBleHRlcm4gc3RydWN0IGlub2RlICphbGxvY19hbm9uX2lub2Rl
KHN0cnVjdCBzdXBlcl9ibG9jayAqKTsKK2V4dGVybiBzdHJ1Y3QgaW5vZGUgKmFsbG9jX2Fub25f
c2VjdXJlX2lub2RlKHN0cnVjdCBzdXBlcl9ibG9jayAqLCBjb25zdCBjaGFyICopOwogZXh0ZXJu
IGludCBzaW1wbGVfbm9zZXRsZWFzZShzdHJ1Y3QgZmlsZSAqLCBpbnQsIHN0cnVjdCBmaWxlX2xl
YXNlICoqLCB2b2lkICoqKTsKIGV4dGVybiBjb25zdCBzdHJ1Y3QgZGVudHJ5X29wZXJhdGlvbnMg
c2ltcGxlX2RlbnRyeV9vcGVyYXRpb25zOwogCi0tIAoyLjM0LjEKCg==

--------------20J8wHG41v0zlwJYCL04QA7w
Content-Type: text/plain; charset=UTF-8;
 name="0004-mm-secretmem-use-alloc_anon_secure_inode.patch"
Content-Disposition: attachment;
 filename="0004-mm-secretmem-use-alloc_anon_secure_inode.patch"
Content-Transfer-Encoding: base64

RnJvbSBjYjlmMTE0YjMwOTdkNDlmOTlhMjI0Y2QzZDI0ODNkMTA2NzY2NTIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4K
RGF0ZTogVHVlLCA2IE1heSAyMDI1IDA5OjIxOjI0ICswMDAwClN1YmplY3Q6IFtQQVRDSCBWOCA0
LzldIG1tL3NlY3JldG1lbTogdXNlIGFsbG9jX2Fub25fc2VjdXJlX2lub2RlKCkKClVzZSBhbGxv
Y19hbm9uX3NlY3VyZV9pbm9kZSgpIGluc3RlYWQgb2YgYWxsb2NfYW5vbl9pbm9kZSgpICsKc2Vj
dXJpdHlfaW5vZGVfaW5pdF9zZWN1cml0eV9hbm9uKCkgdG8gYXZvaWQgZHVwbGljYXRpbmcgdGhl
CmFub25faW5vZGVfbWFrZV9zZWN1cmVfaW5vZGUoKSBsb2dpYy4KClNpZ25lZC1vZmYtYnk6IERh
dmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTaGl2YW5r
IEdhcmcgPHNoaXZhbmtnQGFtZC5jb20+Ci0tLQogbW0vc2VjcmV0bWVtLmMgfCA5ICstLS0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL21tL3NlY3JldG1lbS5jIGIvbW0vc2VjcmV0bWVtLmMKaW5kZXggMWIwYTIxNGVlNTU4
Li5jMGU0NTllNThjYjYgMTAwNjQ0Ci0tLSBhL21tL3NlY3JldG1lbS5jCisrKyBiL21tL3NlY3Jl
dG1lbS5jCkBAIC0xOTUsMTggKzE5NSwxMSBAQCBzdGF0aWMgc3RydWN0IGZpbGUgKnNlY3JldG1l
bV9maWxlX2NyZWF0ZSh1bnNpZ25lZCBsb25nIGZsYWdzKQogCXN0cnVjdCBmaWxlICpmaWxlOwog
CXN0cnVjdCBpbm9kZSAqaW5vZGU7CiAJY29uc3QgY2hhciAqYW5vbl9uYW1lID0gIltzZWNyZXRt
ZW1dIjsKLQlpbnQgZXJyOwogCi0JaW5vZGUgPSBhbGxvY19hbm9uX2lub2RlKHNlY3JldG1lbV9t
bnQtPm1udF9zYik7CisJaW5vZGUgPSBhbGxvY19hbm9uX3NlY3VyZV9pbm9kZShzZWNyZXRtZW1f
bW50LT5tbnRfc2IsIGFub25fbmFtZSk7CiAJaWYgKElTX0VSUihpbm9kZSkpCiAJCXJldHVybiBF
UlJfQ0FTVChpbm9kZSk7CiAKLQllcnIgPSBzZWN1cml0eV9pbm9kZV9pbml0X3NlY3VyaXR5X2Fu
b24oaW5vZGUsICZRU1RSKGFub25fbmFtZSksIE5VTEwpOwotCWlmIChlcnIpIHsKLQkJZmlsZSA9
IEVSUl9QVFIoZXJyKTsKLQkJZ290byBlcnJfZnJlZV9pbm9kZTsKLQl9Ci0KIAlmaWxlID0gYWxs
b2NfZmlsZV9wc2V1ZG8oaW5vZGUsIHNlY3JldG1lbV9tbnQsICJzZWNyZXRtZW0iLAogCQkJCSBP
X1JEV1IsICZzZWNyZXRtZW1fZm9wcyk7CiAJaWYgKElTX0VSUihmaWxlKSkKLS0gCjIuMzQuMQoK

--------------20J8wHG41v0zlwJYCL04QA7w--


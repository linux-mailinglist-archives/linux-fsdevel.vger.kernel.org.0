Return-Path: <linux-fsdevel+bounces-57636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2306B2404A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BBDC4E195D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474A2BEFE2;
	Wed, 13 Aug 2025 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DMVbovR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8A2BE65A;
	Wed, 13 Aug 2025 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063469; cv=fail; b=I8LvYWqIGpcKC8W2e+EoXKpCN6ZURhdUcdmwcOdXT9/eWHv+nhRKIWeIoNsFSLEg+Od5Dj2d4Em4bdw1f1Qan73NUHrqhOLMKIk/eSFzLPi9zSjJ9TpRb2Qz+vb9Rd3yMKPJ291sioDYnft1+lPjjK3vsah0/rgcc8pmEj2wUTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063469; c=relaxed/simple;
	bh=TJM/VcSVO+1JOjTm683VNfNrVeOT3Mfug5s93qRHmYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Te6VNgiFHKDebFHk/pqhL3OFbQ+pQmojOtwjT8XwKsmqTMkZAcUaoKKNc5fdf06ZQo78Yah3Qs5SFQSaYKUE9hLPcbIMlvXxgqgRc7yWJNu/aYSrhss6fPU691/INYlFh7g7L8uCj7hxM6mcYM3ScW4JhZUlRmKZDFZlAWlHdx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DMVbovR1; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTJshPQrn2wKX4LnLsElKJGUBqg0vTqj6+wsOKxl9fG1YBRNkF+UD9RLLfLAeoz0sv4S2X1Rd0GK5vQsJtYQ9mq8nNJtUKEi9a2X9KllAmD4iftvlVBXDKQSZg5KJbs/286TLyDoJYlWhcPzQgWKwMHDoMPHwQ7KiuYlzy1OISM0aKX2IU1IW8SP/ypolGtow4NVYmQiajW65egZIKVmC0/1cg3n4iHqpv6rzMMDyyF4CnJ6TJqPgk1V5EV22Ww9PkiAERMkqZLWYZOPfibmw9kV5gsudeROZkXdCExkh6UQp3+hUy8MV7lCdsJ3M/96izEXet31dPFTBwpsw9xJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vOYTpsGTVOGFYNM15RJAIpz6gk9oUTejV+wka+g71Q=;
 b=NHH9jqcTig3QO7e41OdaCDtjk8oVkv+mDrpGLBKDy+tjWj+c9SyHQqs29PWiDKe9UmZtHw4Ya2tRbRzMKjOWGYBIIvRhUrqvtAwNkbwLlhOsqKEVNpJGIAHA/FniWVRPYmns/VvR6ui7cRVJWEVXGbhvIfB7VwPG4fVgC3a9b/fRh+CNaOiW2hc2y3OttmV+ekuq424mYrVMeznT+eZQ/9hvMfWo2RIxts2UqA2ZWUMHN8MpFyOVfL9A/waSA7cIbj4s9+cBBPOuFjuWjbQFTo6NRZ3KSrZX6B915gVhgAj289KtEcXfOgMDomdSqiUKqoJQONWBZfOuZ02EaB4gXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vOYTpsGTVOGFYNM15RJAIpz6gk9oUTejV+wka+g71Q=;
 b=DMVbovR16GnkPA9CE4li6ZEr3Rgqv3PmMJLS3hIENiJveBGMwvv8MOGSdViJr0kL0jFeyo4RK3PFmeuTvEahDycLUeHAHjcUqgSMnYV4LsX5bslIWAKjhZsS5/E3CLMiUQ1p3rkLtD8SjowyKcpYlTKMDy/8iUZfHMpnUMnsLLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8) by PH0PR12MB7472.namprd12.prod.outlook.com
 (2603:10b6:510:1e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 05:37:44 +0000
Received: from IA0PPFDC28CEE69.namprd12.prod.outlook.com
 ([fe80::7945:d828:51e7:6a0f]) by IA0PPFDC28CEE69.namprd12.prod.outlook.com
 ([fe80::7945:d828:51e7:6a0f%4]) with mapi id 15.20.8835.025; Wed, 13 Aug 2025
 05:37:43 +0000
Message-ID: <c558354c-0103-42b7-aa29-741147c9330e@amd.com>
Date: Wed, 13 Aug 2025 11:07:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V10 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
To: Ackerley Tng <ackerleytng@google.com>,
 David Hildenbrand <david@redhat.com>, seanjc@google.com, vbabka@suse.cz,
 willy@infradead.org, akpm@linux-foundation.org, shuah@kernel.org,
 pbonzini@redhat.com, brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org,
 hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com,
 rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com,
 amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com,
 ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com,
 pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com,
 suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250811090605.16057-2-shivankg@amd.com>
 <20250811090605.16057-10-shivankg@amd.com>
 <cee2e489-d3c9-46d4-8d34-37c637c7bbd8@redhat.com>
 <diqz8qjpzh6s.fsf@ackerleytng-ctop.c.googlers.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <diqz8qjpzh6s.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPFDC28CEE69:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: d715649e-ba7b-4287-3d09-08ddda2b86a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWxKYlBrbDRMRlpVOWtqYTJ6TnNSYWYvT2hrVlVtTXVOMjFwUU9MMXV5QSsw?=
 =?utf-8?B?em94cGVWckk2ay82ZllqNlZXZUcxdk9oSDlxMlVDTXNPSXgvZzJidDlEaG8y?=
 =?utf-8?B?YTUxRjBqSXRLdUdlOWQ1OTM4cU9JUk5zMkFhQ2NNb1B6NkRIaisydElHM0pv?=
 =?utf-8?B?SjRJcHFOcitYNW52NWZxakl1M2xKeUVuY1ZxOThzNkN5bHB2bGJGa2xOY0xS?=
 =?utf-8?B?VWVWZkdaUGVsT05ZV1FIOHdBSzdDRHMvVG00OWVFVUVwYU9jbDAyZ1YwK3Uv?=
 =?utf-8?B?TkNtODBaWmV5MHdPZjBJUWF4RnBrUElGeHpQR2NnMmFSYTlaZkd2MTYxN2hY?=
 =?utf-8?B?QXZvQUJqR0UwSGdVdWorYUJ4L0F3TFdwWlpwNnBqZ1cyQkVFclA2aWp1TTZV?=
 =?utf-8?B?RFRnQ1k0OEpsemtPeG16SlhVd2pwNHJIOGNvMHpiV2duMXV3cDVTWnJ3MHFm?=
 =?utf-8?B?WExrdG94cnA5enZMM3lQbEhFY250S011WTlXMUJ3K083S2ZWMWR2bjN6NXNi?=
 =?utf-8?B?L3FTRndDRk1BdGIyU1N2QWovbXh0UGdKNWdJMUhUbi9hbmx5RWFqTlh6L0do?=
 =?utf-8?B?Rkt4bjV1cENvSmNBOUpOQldlMkw3Q3hrNE50d2pVTmVLTGlBWmRnYXlKRm42?=
 =?utf-8?B?bUhaVlArSUdIbUdNWmh4Z3BnaTc1QWJyRlRWN0hXUWpscmpYS0Yzd2lWeit0?=
 =?utf-8?B?MncxSkdJSUxFMzA3Z1BYd3lNVEN1Q2JEVzVHVm5uZ2IwQm40UmlWUnNPWExp?=
 =?utf-8?B?cW9EUVUyTUNDMkZIdTdMWVlxeGN6U3BUTnhFZ01zNmtITE9saVN5cFZ0NzY3?=
 =?utf-8?B?NlgrSi8yUFFLYjBxOXlMa3AxbS85YS9XYkFhSW5VeDRTVFIzbHY3Wm1NakEr?=
 =?utf-8?B?OVpETENqVFNwamhPZmw0THJZN2pnRUtGNHByaCtRNlBlY0tITHIzSWlDaGlF?=
 =?utf-8?B?TmVIWUl6WC9oalpvMWRjNjdueDZwYW5aSmpvMkV2dFRwckdhNVlLMjQ3aXFm?=
 =?utf-8?B?bzh2T1I4NVJKOXVFRWllQzUvZ1ZjSVorYjFNQU5HcElSd3U0MWJVczhMQ1JF?=
 =?utf-8?B?UHhrSkVoSmxWMHJ6TTNscjY1cGh4c1lVZlFJMHdFVEdOdTdMZFpvbW5wcjZI?=
 =?utf-8?B?VFVWQkZPaWVsVENrTEUxc3dJRVlKWUF0L2ZkaHNVTTZta0pITWZvOUVpeEMr?=
 =?utf-8?B?bkN2Z0w2YTVmQ0RFUHdjVXA5TWZjUzd6T3ZvbGxjQithL2NmcEpabmx1OEF0?=
 =?utf-8?B?RS84eDV2NFFhV0I2b25rRzBqYTBaVm5QUmp1UW9scytXb0ptdXZmaW1WQkF0?=
 =?utf-8?B?SVg0bUh6L0lzR3pwOU1lSXhGU0cyaGEzQzJ0VlZZOFRHYXhVYmJISGk4ZDVv?=
 =?utf-8?B?N2hvYVNvbituemthQS9abGU0QUJRcmluM1RYa0hqeEY3OWRFS1p5ZStsaGZJ?=
 =?utf-8?B?ZTJPYlFCN2kwWStTcXpOc2lIZ0FiYnZDekJnMzY1clhFL0I1L2xhUDhuaHA1?=
 =?utf-8?B?c3pQc1dOcWRMOUZZY1dpTDNzVmN5endJUVh0YU96OVRza1NuZWxHKzJncThT?=
 =?utf-8?B?eHdtc1cwd2tEOXZ3VWU2bUZDODdFTUc3RDdRbFppM1JsbFBOVnBWN1RjOFVY?=
 =?utf-8?B?ZDhhWHlVNDNtb0VzaThnOUpCK2czSW9DWHhCNGhlUjM5alUyRVBKZEkyclMz?=
 =?utf-8?B?UEE2eUkxY0hDdVd1bmx0TkVmSGIrZWRmUVhpN0E1N1hSUHVIbWNKeVVKYlYx?=
 =?utf-8?B?SzlSV2lydGZsTVJndDVuZ05Jc1JpTVY2Zm9JaFdEU2dFRjd2bEc4VG0rU3JW?=
 =?utf-8?B?VjdYM0lMaXNlOTFWRjVENzk3ZWdkNFB4WEIwMzdGcWxodnQzb05mZkpqV0xU?=
 =?utf-8?B?UVNBaVQrL0JmUG05WFg4OHpDUWhyZXRicS9neGhIb1NxRGF3TWxLRDhRVWhm?=
 =?utf-8?B?TUlBMGNVNWVyQksxcGtsRUtQNVVjOFNVcjBFeHQ5RmJ0YzRFYW5qL2V1Q3dB?=
 =?utf-8?B?ZjlCbjRBV0pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPFDC28CEE69.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2ZKYlNiTnh5SE5FQ2ErTFBpZ21PQ1h4a082U0Z4UHRncW9MTFAzZDZMcjJk?=
 =?utf-8?B?L3d2YXdxc3dkWG8xZTFMUURLLzJQbGlmeGx2Tlp4b3hoOGRMamoxNWdUZEkx?=
 =?utf-8?B?OXdIM3Ewc1E4K0JXQ2k4aTV0VVV1dEFxNmlPUkVGOHVEM2RQMXY4Tk5TbnEx?=
 =?utf-8?B?aDRXOHRBOC83c3JJRnplUzVkUHVZVnh5b0RYejJQaCtrMXJaVUx6RDFFbzdL?=
 =?utf-8?B?azV0TTZHMFZKci9USzBNbXpBNUtTZGxEMHg3dTF0b1lmcXc2YitkaEZaRUdu?=
 =?utf-8?B?dmdIWklybXVIQnhyeEpLT2lsMTBoVkRqQlRQaW4yM2hId096ajhobS81ZFl4?=
 =?utf-8?B?OG02cS94ZDNzQkQxeUx0SGR3d2hOR2dkdU9LcXFmYzZIWlFTTFpaY3pDN3dC?=
 =?utf-8?B?cEliUE5ZSThpREwzdTM4Vm5DN3VjYVROSHdpWUNnL3Z5T3lNSGRNbjV4SzBm?=
 =?utf-8?B?clRFaGluMHJWekF0eCtUMnFRWVh4Q1ZmaWJWSWdJSU5vZDFxOW5TU1RzUi9p?=
 =?utf-8?B?cnRnL28yYVdCWERxV1JvQkp3NFZUaEhVVFRoRURDeE9IZGdDaWRzb3k0NUdU?=
 =?utf-8?B?V1JkQ1dJbGFqZ0c3bzB3bThCWmRMbVA0ZmI3SnJyTFZGaE1RN0tNajZUMGVz?=
 =?utf-8?B?VUdvZDJYYU91cndNT1lMbmYxbUJKYjlNMTlwTDhzeWRyT2JNekZKRnZnUGV6?=
 =?utf-8?B?S2dZcUJFd1RVUEhlc3hheGJiTUdRcWxkaW5iTEF2Zk5wT2toUTQzekdUWUJD?=
 =?utf-8?B?bndhSEtIMjk5QVF0WXpQRUZaZVEwTXRXNEZhdVY1UndJb0lvWlczQm1wVXNr?=
 =?utf-8?B?MEVuR0cvY2dFVHBaZjR0RDdTS3d2Y1pLQjkydFlrSmNHeWNsRkVVMlRrOFg3?=
 =?utf-8?B?Qkp1TkxBdW5jc3ZybGJKUjJVcU55amMrM2JUbUFzeitMbWpHazlEVGdaMmZI?=
 =?utf-8?B?SndxWnY2ZFQ4MHhPYm9SYXBBWVM0UDZYbEU5WXRML0oxUm96VDErOFJFT2tp?=
 =?utf-8?B?TXZubVJxT3FObWtVdmdpSURjZXNldDRxU3Q2T0MzSEpJQ0tyNCtSYVhoUFlY?=
 =?utf-8?B?SGN3L29Hd295RDBrTSt0OFhVdmpqaFVHWU5SWG5pOG82ZndoVHp3NEo0T1pW?=
 =?utf-8?B?Y1hYb1JBdXU5Z0dGb1NDakxCQmJMSzN1T1hNUXFNZDZ4dEt6b0daWmZrN3Zz?=
 =?utf-8?B?OEZUMklIUzBWb1F4d3E1b2FlTmtPam1CVy9BZ2tNVzZTWnJ5T1BiUU9vRnNw?=
 =?utf-8?B?RUM3RWdNRUxyb2Urb25hYUF2eWJaNXEzOUZMZkpQamJxQ2ZOdVNHaDRITUV3?=
 =?utf-8?B?a2ZDaGpJNTZTYzFXRjMyS1VDRzdzQVJTVmh1S2VNMXlBV1drTWtsem82c0U1?=
 =?utf-8?B?UmxoQURHcG8vdVhhc25RRnpWTnJVV1pRWFlwRlZVLzlUMG5pR2VPTjZmTmQw?=
 =?utf-8?B?d0NmQTBOQkliNXY5aFkxODNSeVZLdkwwSUorcmN5RnZaTjBMbUxpVGJOUUpD?=
 =?utf-8?B?RmFtMzR3bHVHQThJeU1LZlY2WUx2bnVCRDhjYStySDR6V1BhNjAwangxc1NT?=
 =?utf-8?B?TGNXZnlGUXBOM0xRWHhqOGtWVWs1dWppSkZrUXBzVXdXbmxWOTAxZnIycVgw?=
 =?utf-8?B?N2RZcWhpVTJSSzcwSWN6SnFBQTB4Z01RQThlS3BxcXUrTVBtcEhVKzZERS9P?=
 =?utf-8?B?b3RhY20wZWRkcFdjTjhyZkcvcGVNcnlneTh0dTBCaURaSnI3ZDBOYjBGMUVF?=
 =?utf-8?B?ZHlkSmE4MUZRcEx2aE5HeG1ETTBmcFBFc1M3WS9URDRYK2U1TGxwVDVQZjBT?=
 =?utf-8?B?QXNtMnFUT0tUb1Rvck02c0JPeEhJSE10emxSMThobHZpMXI0aVJFWXA0VlBR?=
 =?utf-8?B?RkdxQWxFdWNldW53QjA1dTExT201d0krdTJXM0FEWWM2RWVtM0lqWnl6Smtj?=
 =?utf-8?B?NmIvODI1MkcxMW1HeFhOUHlKL3BUSkx2ZHI0WXlUY0d0NVQ0OTVHZEZRWnhv?=
 =?utf-8?B?SnFCSmhKVmVVWHh5bitQSG53dFpTbnFVd3BGaEgzSW5hNyt3T2tTbVBmcWpP?=
 =?utf-8?B?QldUMitVTGovcDRrOG9QL09mdnBsYmNremRXdm5lWGJmSVZVdHdFSkFjWVNp?=
 =?utf-8?Q?h1d3zYtVxz1eX4NSLSQR/ZkHx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d715649e-ba7b-4287-3d09-08ddda2b86a5
X-MS-Exchange-CrossTenant-AuthSource: IA0PPFDC28CEE69.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:37:43.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4n3ICy7rXpxkJhEmuRPj/0pyn4Mze0LCXHQfnMup07PqETVnFLXhi2cVAUvHs2X8q7gz+zH4Mok8BiE0J/NFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472



On 8/12/2025 2:53 AM, Ackerley Tng wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 11.08.25 11:06, Shivank Garg wrote:
>>> From: Ackerley Tng <ackerleytng@google.com>
>>>
>>> [...snip...]
>>>
>>> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
>>> +						  u64 flags)
>>> +{
>>> +	static const char *name = "[kvm-gmem]";
>>> +	struct inode *inode;
>>> +	struct file *file;
>>> +	int err;
>>> +
>>> +	err = -ENOENT;
>>
>> Maybe add a comment here when the module reference will get
>> dropped. And maybe we should just switch to fops_get() + fops_put?
>>
>> /* __fput() will take care of fops_put(). */
>> if (!fops_get(&kvm_gmem_fops))
>> 	goto err;
>>
> 
> Sounds good! Please see attached patch. It's exactly what you suggested
> except I renamed the goto target to err_fops_put:
> 
>>> +
>>> +	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
>>> +	if (IS_ERR(inode)) {
>>> +		err = PTR_ERR(inode);
>>> +		goto err_put_module;
>>> +	}
>>> +
>>> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
>>> +				 &kvm_gmem_fops);
>>> +	if (IS_ERR(file)) {
>>> +		err = PTR_ERR(file);
>>> +		goto err_put_inode;
>>> +	}
>>> +
>>> +	file->f_flags |= O_LARGEFILE;
>>> +	file->private_data = priv;
>>> +
>>> +out:
>>> +	return file;
>>> +
>>> +err_put_inode:
>>> +	iput(inode);
>>> +err_put_module:
>>> +	module_put(kvm_gmem_fops.owner);
>>
>> fops_put(&kvm_gmem_fops);
>>
>> ?
>>
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
> 
> From f2bd4499bce4db69bf34be75e009579db4329b7c Mon Sep 17 00:00:00 2001
> From: Ackerley Tng <ackerleytng@google.com>
> Date: Sun, 13 Jul 2025 17:43:35 +0000
> Subject: [PATCH] KVM: guest_memfd: Use guest mem inodes instead of anonymous
>  inodes
> 
> guest_memfd's inode represents memory the guest_memfd is
> providing. guest_memfd's file represents a struct kvm's view of that
> memory.
> 
> Using a custom inode allows customization of the inode teardown
> process via callbacks. For example, ->evict_inode() allows
> customization of the truncation process on file close, and
> ->destroy_inode() and ->free_inode() allow customization of the inode
> freeing process.
> 
> Customizing the truncation process allows flexibility in management of
> guest_memfd memory and customization of the inode freeing process
> allows proper cleanup of memory metadata stored on the inode.
> 
> Memory metadata is more appropriately stored on the inode (as opposed
> to the file), since the metadata is for the memory and is not unique
> to a specific binding and struct kvm.
> 
> Co-developed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  include/uapi/linux/magic.h |   1 +
>  virt/kvm/guest_memfd.c     | 129 ++++++++++++++++++++++++++++++-------
>  virt/kvm/kvm_main.c        |   7 +-
>  virt/kvm/kvm_mm.h          |   9 +--
>  4 files changed, 119 insertions(+), 27 deletions(-)
> 
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index bb575f3ab45e5..638ca21b7a909 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -103,5 +103,6 @@
>  #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>  #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
>  #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
> +#define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
> 
>  #endif /* __LINUX_MAGIC_H__ */
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 08a6bc7d25b60..6c66a09740550 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1,12 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/anon_inodes.h>
>  #include <linux/backing-dev.h>
>  #include <linux/falloc.h>
> +#include <linux/fs.h>
>  #include <linux/kvm_host.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> -#include <linux/anon_inodes.h>
> 
>  #include "kvm_mm.h"
> 
> +static struct vfsmount *kvm_gmem_mnt;
> +
>  struct kvm_gmem {
>  	struct kvm *kvm;
>  	struct xarray bindings;
> @@ -385,9 +389,45 @@ static struct file_operations kvm_gmem_fops = {
>  	.fallocate	= kvm_gmem_fallocate,
>  };
> 
> -void kvm_gmem_init(struct module *module)
> +static int kvm_gmem_init_fs_context(struct fs_context *fc)
> +{
> +	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
> +		return -ENOMEM;
> +
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	fc->s_iflags |= SB_I_NODEV;
> +
> +	return 0;
> +}
> +
> +static struct file_system_type kvm_gmem_fs = {
> +	.name		 = "guest_memfd",
> +	.init_fs_context = kvm_gmem_init_fs_context,
> +	.kill_sb	 = kill_anon_super,
> +};
> +
> +static int kvm_gmem_init_mount(void)
> +{
> +	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
> +
> +	if (IS_ERR(kvm_gmem_mnt))
> +		return PTR_ERR(kvm_gmem_mnt);
> +
> +	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
> +	return 0;
> +}
> +
> +int kvm_gmem_init(struct module *module)
>  {
>  	kvm_gmem_fops.owner = module;
> +
> +	return kvm_gmem_init_mount();
> +}
> +
> +void kvm_gmem_exit(void)
> +{
> +	kern_unmount(kvm_gmem_mnt);
> +	kvm_gmem_mnt = NULL;
>  }
> 
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
> @@ -463,11 +503,72 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
>  	return true;
>  }
> 
> +static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
> +						      loff_t size, u64 flags)
> +{
> +	struct inode *inode;
> +
> +	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
> +	if (IS_ERR(inode))
> +		return inode;
> +
> +	inode->i_private = (void *)(unsigned long)flags;
> +	inode->i_op = &kvm_gmem_iops;
> +	inode->i_mapping->a_ops = &kvm_gmem_aops;
> +	inode->i_mode |= S_IFREG;
> +	inode->i_size = size;
> +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +	mapping_set_inaccessible(inode->i_mapping);
> +	/* Unmovable mappings are supposed to be marked unevictable as well. */
> +	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
> +
> +	return inode;
> +}
> +
> +static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
> +						  u64 flags)
> +{
> +	static const char *name = "[kvm-gmem]";
> +	struct inode *inode;
> +	struct file *file;
> +	int err;
> +
> +	err = -ENOENT;
> +	/* __fput() will take care of fops_put(). */
> +	if (!fops_get(&kvm_gmem_fops))
> +		goto err;
> +
> +	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
> +	if (IS_ERR(inode)) {
> +		err = PTR_ERR(inode);
> +		goto err_fops_put;
> +	}
> +
> +	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
> +				 &kvm_gmem_fops);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		goto err_put_inode;
> +	}
> +
> +	file->f_flags |= O_LARGEFILE;
> +	file->private_data = priv;
> +
> +out:
> +	return file;
> +
> +err_put_inode:
> +	iput(inode);
> +err_fops_put:
> +	fops_put(&kvm_gmem_fops);

Thanks Ackerley.
LGTM


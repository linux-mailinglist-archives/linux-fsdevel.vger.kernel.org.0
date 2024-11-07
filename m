Return-Path: <linux-fsdevel+bounces-33877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAF9C0076
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FAF283BA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C91DE2B5;
	Thu,  7 Nov 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f9yimetb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EF199FA2;
	Thu,  7 Nov 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969680; cv=fail; b=agCyo80RhgdfGxLP7SYVm6kdRhK9nELKm9nozhE7/4cTpjtNiMyonOO1ul8j+NKq8ezUNx0wJ31yR6kf5OZCep6xt4nf8I1tkP6xHKNYlXu3q5Ghq7JNa5/KjVcQ0MTG/obxTE1/42vRpgJEjocNwgiPreHWNfuAsJiMWmq5HAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969680; c=relaxed/simple;
	bh=hAP/UBeJMMKqQoQauDwwL/ZyuE3KCprHnXmVc5e9bYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDxsKbPDo9gmJh4yf/YI6NvuEjzt6IpQ/mdY5RIkSvmn7iFzHGSWAj989ZV5m+9v/iwv9QfvbZupP/N/+CFrMe834JfPsoCFUKAQIsZ1mBzDBrSRGNF54ygH1nAjlpveACVCL6T8qhzuDuh2LK0A+nI8PcXqeKZbgJO93LDeLgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f9yimetb; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm9qPaM/tmPbFxELRUN2+Wu8T4elVfNOVaS1AsdlU/4gCUldfeVEuy4gsu0k648qPHIXiDGF+ibgaltlRhFELSNZHNeIsX8YaTv9+bb/b0Kq7+jVUyfl/undG90NfKy8+zaWmy1ckoWohUlF5LJOOvUKbW7aM85SSzlvXLe/RyM8evOx3Qvd6LwsuxDDWTzGf0atGQFQyk9AHSYhM2uMihaKVTS5sIeS+eILyMOnT+/JtZsxLbSFv/KiYiEz22h6ifzQKM6S+rM/yfrz8G3gT9H2qck3TVIQm44HVRjzn8/ROqsjoUSmCM9z8eTNGo+UhQ0V5ZuCYtp0yfXOvIX5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/Ztmghk0ekMKHppeyjI/SVZeme35m4F8pJguR4BZLo=;
 b=JbnRRJGqERvzbeX6ggIv6Nqy03TGUNd4NAhtJhRKuRx/j2/Ny58YQzvxjzTikNxDiMji3/VFmN3MKyrpUwPE4fSXUf0c0ADJJuHRjFBtxf7lnGA/+xAyxzmB1/tVkS2ewztrv0CoO0ooCMT1YdKSkS5YXgrGzbU+rY8mlXp+xnKXTAGKod5vWtFmuAO4RIiIyYM7mnVmOrxf71oJyS7uGWy2EBEUkBTebR+XWiu8KNWEzsW8OVOpMD0kW1GO7x76JMpknP41t+6JSUxlk5wH90CqDSsprCFtAQYfHDTfSiWqeugUNf/Y32ZUA4wBrjd7yjSu6zsdTgW2c+wsOovDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/Ztmghk0ekMKHppeyjI/SVZeme35m4F8pJguR4BZLo=;
 b=f9yimetb/28iW+wewy/szP1l8hryYoWxxYf1EV1ImYDbNILStlcMGaDuH+/FKHxisAFgkGHEZa2VnUaJP65vYs6qLVkCb2+p42p7D/fQfUtH4kY9dMWWFp/uPxbSY3vtM3rDgnWnEK/ajFmEr0v7cOZG5lPeP6LN69fbUHAucuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 08:54:36 +0000
Received: from MN2PR12MB4270.namprd12.prod.outlook.com
 ([fe80::2e50:d5b4:45f2:684d]) by MN2PR12MB4270.namprd12.prod.outlook.com
 ([fe80::2e50:d5b4:45f2:684d%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 08:54:35 +0000
Message-ID: <6004eaa4-934c-48f4-b502-cf7e436462fc@amd.com>
Date: Thu, 7 Nov 2024 14:24:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Add fbind() and NUMA mempolicy support for KVM
 guest_memfd
To: Matthew Wilcox <willy@infradead.org>
Cc: x86@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 chao.gao@intel.com, pgonda@google.com, thomas.lendacky@amd.com,
 seanjc@google.com, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, arnd@arndb.de,
 pbonzini@redhat.com, kees@kernel.org, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, Neeraj.Upadhyay@amd.com, linux-coco@lists.linux.dev
References: <20241105164549.154700-1-shivankg@amd.com>
 <ZypqJ0e-J3C_K8LA@casper.infradead.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <ZypqJ0e-J3C_K8LA@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To MN2PR12MB4270.namprd12.prod.outlook.com
 (2603:10b6:208:1d9::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f23d1e-fd3b-4c63-4aab-08dcff09cd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wi9kNGJRNFJSUFoyZElrVlFKWWx0bkJVaGZsZjlQUmJPd25QYnlBbFRPTkVo?=
 =?utf-8?B?N1FiS3R1Tmt0VzBGTjMzSmd5M05zYlMwOG1pNkNxOTNTaUVIMjd2YW14SjY3?=
 =?utf-8?B?dk1GNVhHdUh0b05Zb0tmdlVHMldmd0ZZZHNIYUVZa0lDQTB5M0ZQV2NQcC8z?=
 =?utf-8?B?TU5vRWZVQkNxQUNROGtFQmI2bGJPUXBzeTBxV1Yxd0FXVkxYdFhCa2Rua2Uv?=
 =?utf-8?B?dVVFZnlGN0RHTmVrNk5aQ0tCTFVQaWdHV1dsSVNRRFJWeW0vY3hQT3NURUFm?=
 =?utf-8?B?ZFI2MG0vOHVEcVRrUGFYWWRvellDSk0wQnlFNGxLM1gzdll6RXRkbC90aXpU?=
 =?utf-8?B?VVhzV2k2a1JmekR6ank2enBOMXQxazZ3MStWVjVGbEkzSFV1RlRtLy9sVjhC?=
 =?utf-8?B?WDdGaTk4VENBeUdJQmpKOWdtZW9xdnVqdnUzdWhRdko2VkFFcVVSQ0pvclcz?=
 =?utf-8?B?cGdUSE9BbDRraFB4VmR6SGZod0ZEU09uVTRwc2F4K1pKRWtFZVp0ZUNLbDRk?=
 =?utf-8?B?cnVOYktHd3N4SHUwOS9zVVA0T1dNMk1MNnlseVlzZFdtc1NjSFRHZ1hwL2ts?=
 =?utf-8?B?aXU0S3dDUTE2T2t6aHdrajlKRUJ0N3dSTkpza0tWamxSdm1jeU1vUzFGY0hM?=
 =?utf-8?B?SVlaYld1SjhjQ25pM3BxelNldEpZbjEyZ3VZeXY2MmMxelF6RldIRlJvR3I3?=
 =?utf-8?B?ekFsbGdCYVBDanNmaVNSeFc3bG9TREpFMEFRTTQ2ZnYzcDcwS1Z0UGhmT0Jw?=
 =?utf-8?B?WU5NMWRkbERBYXp2eGJkWTdIZ1pad2IwOHpad3dzVlMvbHJYbWxLMUFGNEhh?=
 =?utf-8?B?TDdmSjFVUVRRM05MYjVPYXNGZEIrRy80ZW0wQTZQVXNNOEFLbTZQT2t1WU1s?=
 =?utf-8?B?dm56NTZuWDhteGxWNlJTUmJMZVVzZnFlV2gwSVk3eExPb3ZMb2hvcGN4OXZm?=
 =?utf-8?B?SUhrK3VxRzFzTzlZeGEzd0FwSFVvVHR5MGxvS1dvUTZDNGN4VlBtS2k0NFl4?=
 =?utf-8?B?RkNzemdub1NhUVJLYzZ0ODNjUFhNaDBmSEVHbEZBREZ2RFpxdWg1elQwUUho?=
 =?utf-8?B?MEswY1pDNEZmbWo4c3dCVERZZ21RSktMSnlvMTNXeEZZWUt3RGJ2K0hPMklz?=
 =?utf-8?B?YVptaDA3dWRUaFpBUEdVTTNlc2FnbjBXZUhjN2JDbE1iMmVJZ0JUSlhaWE5U?=
 =?utf-8?B?eWp3Y2ZqZUZnVU1ibmc5Vm5wV3BDa2cwZEIxYitndGgvYldHampqaDZrOE92?=
 =?utf-8?B?ZTdQY2ZuS2dRWXBLUURQMTR1OEh6R3R2Ukx4SUc1QVB0b0w0MFdqNDdTM2wv?=
 =?utf-8?B?ZGo3ZTZzOUt3WlJGTk5hS1JNd0ZZZ3BUdnBlUWw1VmtMajV1enpJeGo0bkhT?=
 =?utf-8?B?bEYxdkxneTI3OHNIeVBFbWJMSDExbE5tU3Z2OGhOMHRtMDhlVE1zbHVuSXVl?=
 =?utf-8?B?bWtOUEhNb0RZMWxNMTJJRFVQQTg5aWVUNndicHdjcmZad3QvMUhjNk0xRTJn?=
 =?utf-8?B?YVkrZWRGeXV4WTJ6dk1NQ0FNd1pMOXFteHQ5cUZUOHB2VlluNmtjb0lnM1da?=
 =?utf-8?B?NzRkRlgwSVVaSTFkQ3VPRVBpRGFyYllJeEg2WVlhSEl6UVJiS1FMSURndER1?=
 =?utf-8?B?K2lzVG9HWTU1K2JCL0RwOGQrS0pJSmlOTGFYbWZZTDNYUE42eDNnVk9Xd3hL?=
 =?utf-8?B?T2t2MjdHS2lCdm9jbTdUQzB2b3FERDdVeXhoS0s0aWRkVVFXb1pEQmNpZ1d2?=
 =?utf-8?Q?LMVqfaW4CFWji9IHXfbHgvMbMNNe9G/uTRJyHt+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4270.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0VHcllVUUljU0lEcDQ0ZTA4aXcvMVljN1pyYWFJV0VUTWd0ZnB5Wkw0OU1B?=
 =?utf-8?B?SWNqTWh3NzNjT2VMNjIyWjI5Ym83QTY5V0E1TElhVk52ZTRIVnZNNVFUekNn?=
 =?utf-8?B?ajNWSEdLVDNUc2ZXUUhrd3FETFVDRHMvK09oa0NyMW53a1RpT3pqSi9rOGxa?=
 =?utf-8?B?UmIrdGo4UE5SUEEydkhVSUcvVEw2eDlka1dWSXIyOTgzMGVBZ3IxTi9JanQ4?=
 =?utf-8?B?ZUY2TmxmbDlrVHAvVlVmUVQzVi9MSnhjU1dGVWJmRnVvOVZXeHlvNVdibTJF?=
 =?utf-8?B?eWRSYzJWbVBHaUU0eG0rVGVjVE5hTlZiNVRZbjNnTDRsckVrVGNieDRFSHhX?=
 =?utf-8?B?SkttQXBrbURHU01mQ0I3dWxwM1Y3UC9jVWlDVzNtK3ZGdVRINFdBRXUycms4?=
 =?utf-8?B?WHZybzVUT0tLbHVwbHZUbU1JV3ppN1JFMHh0R0VwTmttWTd2MmxQQ3p0dFVM?=
 =?utf-8?B?ZDVXRFdHaTJEOWcxVDNzblE4ZW95Yllwd0prQVdTZ1JtMWFodjJLR2tUaW9y?=
 =?utf-8?B?blFaaWtVVjF4V20wTm1OWWpxcWpGRFhVSXdnaGtjVDZaNjkzWDdFU2xGelgy?=
 =?utf-8?B?eEpJTmxzZ0lpdWlmcFpjSVdrb2h6M09IK3o1ckQ5MFB5VXEzRWJNK2R3a01N?=
 =?utf-8?B?WXFZODZvSVkzRGpDcmNTRFBkYWJkTUZNdDlweE92YTZvV3QzY2ZVaXM3aDlH?=
 =?utf-8?B?RGRldVFiaDlpOE1IdkI2WXlvNTYyYXZDejFHcGU2VXFYOGZzY2JKRmVCLzB6?=
 =?utf-8?B?dnZYN2ZnOWxXKzBoUURDbWNCNk52TTFadmlnUnVuRlJMdm5qVXNIQzhLMnJJ?=
 =?utf-8?B?K29BS2pwWWpUMmJkcDlGMERMWHpVeGlVc0lDZFQwN2tnWmJlWmlJWlg5M1FY?=
 =?utf-8?B?dldRWFlwU1VBQ1BWNW5SbDdYY1g4NGdxU1Z2U1FKcm1XQng4Q2Z1OVhqVEFI?=
 =?utf-8?B?TldIc2U3WDlqRGhzSEg4ZWpUem1DalA0VUNaZklYLytWZVVhU1ZScm0wYnpO?=
 =?utf-8?B?eEg1N2FhYmxqd3ZpcFpqRHV0YnJ6UXk1VDRrUHBGOU1pd2g0bWIzU2tHR3pa?=
 =?utf-8?B?b3JMME9zV2pjWTJOMUZSeFVqeDhiZGdNTnkzMWU3RW9pR2czWXlTdUNmZndl?=
 =?utf-8?B?MlErcUlNbDRlbUpDTlFjUmY3c1JHejhhMG56SFgycURLZ2ZKY3RiYS9WUEht?=
 =?utf-8?B?MmlWT25ZSVAxUkJvVHlHc3gvblMvd2tlNndCK21qZDRYQW1qR2xicUE1bW9U?=
 =?utf-8?B?QnFSOUkwWm5YbzhRWVdEMTlCRXR2WnFlN253MEhXVXhaVVBvampIMGNac1pn?=
 =?utf-8?B?MWhFWkpGM1RYR0VTeExjektoK0VuZ2gwSnZBWjZJVEV6bDEyKzhNanVzeGtr?=
 =?utf-8?B?VUZmK1kvdHVjRDhkOFFvaFJ3WnZ6K1VKNFJSeEo0L0JaN2RQWGVDdDhaNVMr?=
 =?utf-8?B?UWtqaVlRMytPSkJxbWtSM1JmOWc1dVJUOUw3cnBRWVV5N3FpelJZRWhJN0VF?=
 =?utf-8?B?L01pYk5HUC9vclNicTFDM0lnd0N3ZGV2Zm5DODB6aGRBV0xnSnM4NXBRMFUx?=
 =?utf-8?B?MFlMQ2FWTjh1cHFZL2xwMDNWZFlEaDgydVRFVCsvWWhxSmozU3ZTd3ZMV1Bn?=
 =?utf-8?B?ZkFQeVRRK0oraUVFRURES25iYm1LcnVBdHRDckNIVkZiQWJyNFZ5YUdZUU03?=
 =?utf-8?B?Q29IV1JWbCs3Nm1PYWJWRG9zYlNyMzNxNHp4REJEbk9Bdm1yRldNL0lhOW5K?=
 =?utf-8?B?U1RJZTNTOWtMVmVTcUtScFpQNE1UUDBBdXEyMjdTZkdraEtndjNvc005UlVS?=
 =?utf-8?B?dnFYYjdlVUgwZjZRclRZTHF5Y3hoeE9iV2VrV3c5aGN3eE5nWjRLdEV3UXdx?=
 =?utf-8?B?MkJwOWlodUQ5U0RhWjVTdFR3bXRmVTlBd2ZhbzhsTGtMRlQ5K1hqSnRhTHF2?=
 =?utf-8?B?Z2tabzZ4UDNmN0RnaEk2OVRKblNpWW5NWmZLVFMzcUtNUDNNWncvVmpDWWJN?=
 =?utf-8?B?N0ZDZytnbTBXV3dML203R3ZxaS96a2pnN3VXb3N0cjBJL3JHVXRIZlluZ1Y4?=
 =?utf-8?B?cDl1SmpQVjJLbkx0VmprNDBvWm02TWxxNm4zemFvSDJVMlRlSjN1aURYdzdU?=
 =?utf-8?Q?Jp91xlGCqPZZrqtTC7bBDoMEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f23d1e-fd3b-4c63-4aab-08dcff09cd99
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:54:35.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY2176j5WWAFcGGyo7bpVgYCCYNKlSwA975HQaoRhZONGx3AsrkOF7CEH+nGaLXPlWUQleo2upwWQH0E+djbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836

Hi Matthew,

On 11/6/2024 12:25 AM, Matthew Wilcox wrote:
> On Tue, Nov 05, 2024 at 04:45:45PM +0000, Shivank Garg wrote:
>> This patch series introduces fbind() syscall to support NUMA memory
>> policies for KVM guest_memfd, allowing VMMs to configure memory placement
>> for guest memory. This addresses the current limitation where guest_memfd
>> allocations ignore NUMA policies, potentially impacting performance of
>> memory-locality-sensitive workloads.
> 
> Why does guest_memfd ignore numa policies?  The pagecache doesn't,
> eg in vma_alloc_folio_noprof().
guest_memfd doesn't have VMAs and hence can't store policy information in
VMA and use vma_alloc_folio_noprof() that fetches mpol from VMA.

The folio allocation path from guest_memfd typically looks like this...

kvm_gmem_get_folio
  filemap_grab_folio
    __filemap_get_folio
      filemap_alloc_folio
        __folio_alloc_node_noprof
          -> goes to the buddy allocator

Hence, I am trying to have a version of filemap_alloc_folio() that takes an mpol.


Thanks,
Shivank


Return-Path: <linux-fsdevel+bounces-64151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C9FBDAD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12D619A4668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661122F5A37;
	Tue, 14 Oct 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AreDtSg3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4324DCE6;
	Tue, 14 Oct 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464348; cv=fail; b=W6G7LYhI0o+Zib1iDU946521GjuM7q68hIROeUV+y9JiBZoUbzb/lgUz7u63mnM3VMDlTuvmP/KLbJ1gE8Ql0ZEa2U/bzG1Ck06ZmY4sEmlpFPOMFYy8/E00rTWS0tjGmJ1YK38YKWpAFWGzhW+onnaQK6kBvistqcvBP5ikqEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464348; c=relaxed/simple;
	bh=uts3O4elIvZKBBgkSAFCyKGk82I3Xhx3vXeJ1UkRPOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfVzRjvTobBJ1oUChlv8Slhns2CttQGH5C3CMpZVShuHm13OCiO18effbo/5+XlPlAW0dvmcjn/Cp3s8cSatLszDw4P/fGDFJXXMZPxvP9ZjRbOUn8rz2axhyYQ9k6suW2ZZdfXb0GS5CxGeqltehjuwC6ZeDcr7SdUWNYbdNps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AreDtSg3; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGfPGw22K5gn5D5owI0tMllZ/jSxbhE0HufWD0W65LMAoCUIPxmZbNmZfrXxX7tTAS9S3ssHQmvfQ2m+t3EccwwBfhr0ZDTd1Lrxd+w7GV/Rmyp6lPAv4SbajdgR0qMrMst3aP/bIK4kiyaeoxJaxzxjmNeM/DtkRgXwVIC0f5DpeEuMn9312Uhcxvvifr/WuH52sV32am0rp2l0Lbwrdh1+RSN9oUPJqsqMPymeLwF5EJnqXqF4BBEfAWD0cLk/f8JynQRm/tc6O0AL+RwqrWowKqwx8VilIPyiDcqXxqY/6hhZJFzhdHOyREnonOTXKkcFxjvJM3DOzS5D5RJgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbnX2IVPyaN8msnESvFVrjkSojxZXJ3Aigi19+6J408=;
 b=QAieLUXYpfV2T6IPuz2eZOOCZXzLoCPNat4SVmpruiskkJzYEsoWH/NmuQdYAh6WjpOTPL/wXIYuvWHqqokwb+j/d3OR69m+SDgzWs8dYUPd/p+9f/58A0bDse034Opt5rWg7paP8y0FXswcTOHIyHdHYbxzUrreBmUIy/AhSQroBy7nL5Xfmze6GJ7T1LoL84wx8VUYDfnFMgkdAAqFw0OtZ6yiaWNiXVbx2XPKEFtFX+ofIdml8a4PWXteqkjE0HLK9jKI1lSRnmjw/kOxBuUSVK5/fBKYf+XLGP5t8kLI0+2EgzAJHv26FO6RBkmDwZe/+M2kUKBIE+FXS6h/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbnX2IVPyaN8msnESvFVrjkSojxZXJ3Aigi19+6J408=;
 b=AreDtSg37bDd9DnrZKUr2DVAB93EV7+sNE+GE+Dxxyqm22Ge2BiSpV+72xUPSR/zTPjREBFA2VLNPLLskKk1SI4uRzQjc95I7UT60SBKWnld//sr9XeLi0z+gwEAfyRwtAF3y0XhJdCesjk9Mfjk+/r5NpLz3k877ruiZo6ROTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 17:52:24 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 17:52:24 +0000
Message-ID: <e2bf2bf1-e791-47e5-846c-149e735f9dde@amd.com>
Date: Tue, 14 Oct 2025 10:52:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL
To: Alison Schofield <alison.schofield@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250930044757.214798-1-Smita.KoralahalliChannabasappa@amd.com>
 <aORp6MpbPMIamNBh@aschofie-mobl2.lan> <aOlxcaTUowFddiEQ@aschofie-mobl2.lan>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <aOlxcaTUowFddiEQ@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc37286-6dc8-4524-3875-08de0b4a6e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2VVditWL0YvTlVOZTRjYU56cmZyVmZKSDY0d1FpS1FpSlkzTGJERURQSDdk?=
 =?utf-8?B?UTl1U2g0TWhsT0lFeDRsRFFGbzA0R0o0MCt5Q0dRbHFuUmxBZHlIUk5qd2xF?=
 =?utf-8?B?NTNDcG53aDFTMUl1azZGOXlpblc4T3N1RGJYT29XU1gxNS95VGxDam9uMWc3?=
 =?utf-8?B?K21IU3dOMEFOQ0RGS1dTSWdHdTVkSmlnMnRURlZFdFJKMU82TW5YNlBUSi9t?=
 =?utf-8?B?SWlpRlNlMTVaN0J3QTFZOW9tUWt4T1d2ZnBvWjh1bFFVejhvY2ZBYWxKb2R0?=
 =?utf-8?B?bzlkdUNjbFc5TUQ2eDBROXRNZ29WMFpCMDhSbjlVaThMdHVIa1lTS0REc1Yy?=
 =?utf-8?B?T3hFVDRUSzNBbHZaSFJVS05uTFA3WEM2QldhenljRHdNZnZRMXcyaUJ4bG1n?=
 =?utf-8?B?dkRnSlUvb2UxNUkrRlZEeThWYkcwSW5KZ2x2cndjWUhtcmx0RURCeHVKV3lM?=
 =?utf-8?B?Y1F2d0k5QzNYUjBWZmFoaEFmNTRwN1ZQeVVZZ0RSWHZEVmY5eTdlUEU1L2lu?=
 =?utf-8?B?LzlCV2VqQjFFTFZsaUFwZkFIdGk4WU8vcmx1SU9iQ2hpSFEybHUySVVEdWI2?=
 =?utf-8?B?UnNuRGNSTGVHWXptRlhKcmp5Y0YxYlkrZ051STlUdVpJOE5UNzhBckFYZncr?=
 =?utf-8?B?RXlNTWFUb3daellGeVV4ZHlGUURyVG9EbFVjM084aXZhbDlqYWFITm0wcTdl?=
 =?utf-8?B?bDVVRVJwNVVGZ3N2d2l2TzM3WE5BckZPUldqUWxGUXBpYVAyM0QwUHN2MkNY?=
 =?utf-8?B?K0RPRmk4Zkpod2J1RUVVZHB6ZFQ1cnJ4dlczNG5RQkJHSEFHRi9nN042MnlD?=
 =?utf-8?B?RFJRckpJWm9qNHhPaDgrd3E0MHZpcDdoMWhNR3FQZFVZQlhyTy8wMlFSdjA1?=
 =?utf-8?B?NXZwaEtPSlBreHBjVHhyWDJMTis0Z244QzQvangvMFRBMzhWNys4L3pVNTNT?=
 =?utf-8?B?bHJzVFQvTEEyYmVLQXN4L3YvbHliSWdVYkk5dWNtL2RzRHdNK005UEZWRStV?=
 =?utf-8?B?eVMzMTZKcEF4VDJ3RU1jdCsya3JBS3laQmRRVUZPMytVY0hoSWV5K1BuNTY3?=
 =?utf-8?B?MDdSS203NnRNdDBaMTQwZ3dnNVlJUWlBUWxhU2hMYVAyMG9OMGtPc3JoZ0M1?=
 =?utf-8?B?dkdJVjRaYlVSaVFCTGhaMUY2aWw0TUVNSXc1R3hxMkFybHI2SWFISWdwbnFB?=
 =?utf-8?B?WnZSK3J5dDF3c0JIM3FrL1VHdVhQTHgyclJ6eXFsd3VDZXk3TkdoYWtGMk9L?=
 =?utf-8?B?bWJIRjhKb3o5QXFuSDRucnk4S0drWjNHeU53dnU1WDRXTEovNFE1NExZTUww?=
 =?utf-8?B?V2tXY1F2Qk02MGdyUHhQVWZVVjV3bXBwU0VZQXZ5MVd6bk0vZUVSTkdCSmxD?=
 =?utf-8?B?blp4ZXhvb3phc1o1WTBjbUNiclVOWkFXS0lDZXJra1hvQmgyTlpBR2toa1hp?=
 =?utf-8?B?cU9zUXp3QmxuWldUZmdwNWpFZWUyT1NFM0ZqMVgzUmo4akxVMTlPZEF0dU5o?=
 =?utf-8?B?MzFLcDZ3eU5jQzdXdEFQYWpoYmQ4STdtc3MrK1JQR1Mzbjdvc1UyRlI5d3Jy?=
 =?utf-8?B?NjljcjJST29EV2swamZGWjV5Sld3cFpRbHhMRG1wR1dnOFk3Q0RUR0xGNWVM?=
 =?utf-8?B?cUZ2Z2ZnbFdldVJCa1lSREE3WVB0aW5RT2ZmMlhvK01HQVV3eEpBL2JoS3dL?=
 =?utf-8?B?SmtTejRYVyszVW1weXFId2ZvdEpRbkduTXNZZlZmNE1ORTQ0alhQeSt6bzZr?=
 =?utf-8?B?aXlySW1GTXJtWXNoVXhld3NaMkJWRTluUjVaYW1oTUZhTnF6MDArQW5Pay9i?=
 =?utf-8?B?UUZyU0xWbnhCbjNaQXlNNTBSZlFIVUxJaGJ0TnNpNmZYQlNtS2d3K3FhM2Fa?=
 =?utf-8?B?VUg3OEV1RXFqeEtzOHBFVDZ3bmg5aGdlY2RjRUh4SC9reGg4ZWlUSDdLUld5?=
 =?utf-8?B?Z0M5eTdJa3RLUWRLcFhaZ1hZeks2aGdhUmtENW12S0JOd3hHay82TmpHWFdi?=
 =?utf-8?B?WC9UbU01djhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0lRWUdvWjJJZFVXOVpzRkQ2cUhJRWRwWi9uSWFyVkk2S3MvSjh3ODFXY3hx?=
 =?utf-8?B?bjBuMHpNYm11TEE5NlNacmZiTjlDb0JTSnIyMmlZS3luTlJHQkszQ2RFSWpn?=
 =?utf-8?B?eVpvd3UvNkV0RnErZy9PSTJYMDRRWWpMNnR5SnEvajVQODU1TllNc0N0eGhC?=
 =?utf-8?B?cW56V1NPQ3JYL3R4MGVsdnBkM3B0NTM1SDVqTVpOekNYZG5JTndKbTBTemJE?=
 =?utf-8?B?RFhIQ2xXTm9FNjlVK2FaVXlMeE5Sb0FRazR6UHZXZU95SWk5dWpkRFVzKzNK?=
 =?utf-8?B?NEpQNWxlQlVETDg1SXExVnlOM2RlRDJZdk5rdFJDZ0R1TGlXYlZ2S0lKTGxy?=
 =?utf-8?B?NU5XSXAwSFEyNDBlU1pvNllCL0xBY1Z0YXdBVmRlLzBpS2g5a2MvOEVBZU8y?=
 =?utf-8?B?ajdnL1dVZWh0YnFBbFFFMGF4MWJNMGVFRTR0VzQzNDFUU1Q0R2R1ajNibllG?=
 =?utf-8?B?UEE2V3dXZklYdG1KOWZSMjgwTnY5d0ZqN21ob1h0MGJ2QVdsbWExdEtQaEZE?=
 =?utf-8?B?VXpjbVZTTDRJWG9xc2tidEZ4NWRObXVWZ1hRc0JDcDk5RXZtVEZCMGZFcWlG?=
 =?utf-8?B?OGFhRkF6WjNkdW1sOFZldzZiZFFZWVVKVDBobE9FamhpL0J0SldiTkdsRklX?=
 =?utf-8?B?Yy9uMjZiUlRaV0JoOUhzMW8wbmhBNVNjMmVySkJndldINStmUmplSjdnL3Vs?=
 =?utf-8?B?dVR4WmE0aThrVHcwZVZqMjFONHVyaTN5Z1B6YnkvK0FiZW8rMFRqNU9PMzdF?=
 =?utf-8?B?MEVzbWRrQmxJWGpnSFVreC85NC9vekM5Vzd4SmRLVHVCZTcrWHhQZWVtZng1?=
 =?utf-8?B?UTB3SkQ3L29NMkdsb3oyR2lSdHVqMWdlSm55QjArR1pxNHpKVU9ma3lvK0tl?=
 =?utf-8?B?dGp0TDhtNGdzMXdvSnR0SW8yRThJWTVrNGh3Z3VRc2p2QkxqUVBoTlNRNUNl?=
 =?utf-8?B?OTB3SVo5c01pcktUT0YrREN6MlRQcE5iZEMrMVg5VzAwNXpQeklyNFBCKzR3?=
 =?utf-8?B?bDUzNVlWMHFrY3ovUFl0WSt5K0N6VFdrNEovRVpJZERXdlBhK1ZveDEySjAz?=
 =?utf-8?B?RE9QdmlSREdOTCt1Z1NDQ0U2Njd0RTNtMjRhV1RzSS9pUnBOeHFnNndETHFQ?=
 =?utf-8?B?Rm45TnBhNVZvNE9WM0VTMHpoekV4ZDNzUnU1VWJnTzJXb0lxcGpMdCtMMDdt?=
 =?utf-8?B?NHNhdysrd0NVemJFYTVGWTAyZHJScjhCd1RRZHU2bDlzeGJFZU8vTUd0MnJa?=
 =?utf-8?B?OUVSUmRxcVZxclcrOWNZbldjbG4vcklOV2ZlK0Q0WTVuSk5uOWxCMnkxK0dP?=
 =?utf-8?B?SVRLRFgxNWUyUWcySHF4Z0JtRGs2MDdMQ05Kdzd6ZDlsMURKaDNSUGhKMWZH?=
 =?utf-8?B?ejN6ZUVzMFJIaEM5UzdjSjJ4SjVSNWJCNWlYdGtPbElHRGRDQlVQSW53RkNN?=
 =?utf-8?B?anJYTXRhb2o0RUJmSlRpMUIva3htZVFWMzJrZVkxajM3KzZJVE45cisydW1Z?=
 =?utf-8?B?YlZUb3JXclBXbUN1R3MxekZpS0lhVVVXN29WSlNYSHA3WjVINU11WTVsZktN?=
 =?utf-8?B?Qm1sQ2loMGNhSzRwcU1HZDVwMnhJa25PbDBQZjQvTlA4cjB0ZVNPUnB3alhL?=
 =?utf-8?B?NGhxaUtCZEdWRXRQQTRlMEQ2QmkzUG5VWVcrcEtBbC9rT2lXclE0RUhHWXhO?=
 =?utf-8?B?a1Zib2xCY25tMnNJQjJQbXNSeGIwVUpSZkt5LzVkWkxhMDRBOU1EVUFqVG0v?=
 =?utf-8?B?UlVzUTBuSGxwbno5Q0d0Q0VEOEtFNVVMOXd0bCtjT2VqNmI4U1pBUDY0ZGFP?=
 =?utf-8?B?T3NNMmQvZWFxUlQzZ1U3bEJaRUwzbHRXTk54cXVtcVRVU29JS0ZJQUxKQmN4?=
 =?utf-8?B?SHlYczh1akIwOFRWTkVtVmVCdkRwV2J5bFQ0SmlQOWE1by9CZW0xcGpIald5?=
 =?utf-8?B?dFV2NmkycTdsMDhJUEF6Sk1zdHdncXRVNUJ5UTZoZExCbWxYdDlld1ZoL2Zk?=
 =?utf-8?B?WHNrQThXVlR2QytiVGVmWWdObTB5eE1hbXdMTzIydklIQzA3Nld4YVVRMk1t?=
 =?utf-8?B?Y0dHRG5pRmJkZ3RKd00xZHlXZVA0Mno4UHByOTNMODJKUTJHc0YyOTdqZ0Nu?=
 =?utf-8?Q?EBn+VY9OUivSBtXJqa5+oxVob?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc37286-6dc8-4524-3875-08de0b4a6e3c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 17:52:23.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxArtrRkf/SHBJXE02IXkKJrYy+d6o6rmit4dz7yx3zFfXBpioLqHt/KGvRRzZ9xPNhsD6iwjRLPlIPrZJa8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833

Hi Alison,

On 10/10/2025 1:49 PM, Alison Schofield wrote:
> On Mon, Oct 06, 2025 at 06:16:24PM -0700, Alison Schofield wrote:
>> On Tue, Sep 30, 2025 at 04:47:52AM +0000, Smita Koralahalli wrote:
>>> This series aims to address long-standing conflicts between dax_hmem and
>>> CXL when handling Soft Reserved memory ranges.
>>
>> Hi Smita,
>>
>> Thanks for the updates Smita!
>>
>> About those "long-standing conflicts": In the next rev, can you resurrect,
>> or recreate the issues list that this set is addressing. It's been a
>> long and winding road with several handoffs (me included) and it'll help
>> keep the focus.
>>
>> Hotplug works :)  Auto region comes up, we tear it down and can recreate it,
>> in place, because the soft reserved resource is gone (no longer occupying
>> the CXL Window and causing recreate to fail.)
>>
>> !CONFIG_CXL_REGION works :) All resources go directly to DAX.
>>
>> The scenario that is failing is handoff to DAX after region assembly
>> failure. (Dan reminded me to check that today.) That is mostly related
>> to Patch4, so I'll respond there.
>>
>> --Alison
> 
> Hi Smita -
> 
> (after off-list chat w Smita about what is and is not included)
> 
> This CXL failover to DAX case is not implemented. In my response in Patch 4,
> I cobbled something together that made it work in one test case. But to be
> clear, there was some trickery in the CXL region driver to even do that.
> 
> One path forward is to update this set restating the issues it addresses, and
> remove any code and comments that are tied to failing over to DAX after a
> region assembly failure.
> 
> That leaves the issue Dan raised, "shutdown CXL in favor of vanilla DAX devices
> as an emergency fallback for platform configuration quirks and bugs"[1], for a
> future patch.
> 
> -- Alison
> 
> [1] The failover to DAX was last described in response to v5 of the 'prior' patchset.
> https://lore.kernel.org/linux-cxl/20250715180407.47426-1-Smita.KoralahalliChannabasappa@amd.com/
> https://lore.kernel.org/linux-cxl/687ffcc0ee1c8_137e6b100ed@dwillia2-xfh.jf.intel.com.notmuch/
> https://lore.kernel.org/linux-cxl/68808fb4e4cbf_137e6b100cc@dwillia2-xfh.jf.intel.com.notmuch/

[+cc Nathan, Terry]

 From the AMD side, our primary concern in this series is CXL hotplug. 
With the patches as is, the hotplug flows are working for us: region 
comes up, we can tear it down, and recreate it in place because the soft 
reserved window is released.

On our systems I consistently see wait_for_device_probe() block until 
region assembly has completed so I don’t currently have evidence of a 
sequencing hole there on AMD platforms.

Once CXL windows are discovered, would it be acceptable for dax_hmem to 
simply ignore soft reserved ranges inside those windows, assuming CXL 
will own and manage them? That aligns with Dan’s guidance about letting 
CXL win those ranges when present.
https://lore.kernel.org/all/687fef9ec0dd9_137e6b100c8@dwillia2-xfh.jf.intel.com.notmuch/

If that approach sounds right, I can reword the commit descriptions in 
patches 4/5 and 5/5 to drop the parts about region assembly failures and 
remove the REGISTER enum.

And then leave the “shutdown CXL in favor of vanilla DAX as an emergency 
fallback for platform configuration quirks and bugs” to a future, 
dedicated patch.

Thanks
Smita

> 
>>
>>



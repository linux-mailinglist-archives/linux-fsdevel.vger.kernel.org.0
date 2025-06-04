Return-Path: <linux-fsdevel+bounces-50669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8DFACE493
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62D43A8028
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2AA202987;
	Wed,  4 Jun 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yBosArz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4594E111BF;
	Wed,  4 Jun 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749063592; cv=fail; b=D0JUoFf3h63j7XiSvJfR6LOijmM+KE7NfHycdIb7SjJ6GaRAC2MTQqp1YzWasJnkDFgxGYouTmTSsKa4Z9VpL75QLWZ1NwHX+xY48v2bFd1NCN1RMGKwKjmBVkxjQP2VP72SOeRMBX77HVpdCiwPZBJF/zdFK6+U4LwfgIGTVR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749063592; c=relaxed/simple;
	bh=ijf2hrq94qHwZxPGOc+TBtsJ/XV+eNmmkpYdaJqIHpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LmDLy7hcYnJ5zL1qn6hP1HnT7WAg0OE2uI4VzFdrWCQPuNzdZY7bCq8K/dncsSlTx7bPCmoZ3AtkSti1xsCGgQh6L3QZt7IyTJFvdyS0JpJ9df2FszRTiRUv4nV+219adVGGFW3hTZS/Bhzh+NtVuU0xTt/6cTdyzfX7vWoi8d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yBosArz4; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apOX7CD9IxtA0IxKKWVNEPaAPDZulfyU1yZ2C3qDYIzH4Q50bS9vGiClOmDboro4fkZq+4AnMVy3J86ZapuywsboiM+caJHhR02sP1j3eKSDh2LlPk3kJ5lmWdTTLAajXWJrdsXVuCihgjtwk6cIxRfLBQnHGOvp+MiEWO9wgkviTf6AWWnSa+4wNhHbR8Jn1XHewJsx6aR3U+zKZ83AqC8zqH/cgo/3FTr8c29mjTYdV6EJITWlFGeS2hgEbqGD0vk8FD7p38j0V1Gj3auszTvUmruR3msWWafuVTSgAkt/lraUiwwV2mPWM3lzh1pLNMlRQYqdbi7O1JIVdXPXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgrERZGKBZn+Vmox3mJmIu4p6QzIe0/2gYqrYpcsRnc=;
 b=XWLxwPoBJJbZyB1Wxc3cAIVytheoJUxDSvTxb2bmGcdPm8z80h6nAhdBTFBTWjApFKhRv9H5CXtfbYzAhd8+Wif3TZRwIRATr4rcfRSm9RVKtaZYl4wyRzCQi+aOC+1WSKH4ZPtDTM0Sj29AwBjfg+uddiVSdgNLP4XcOdylDurTXK3OY7cq7KB4fduu0Wvl4xy6bzJ1qgMFMoahHDkP1IvxQfqEzs8jlCulk1AEiNYp5L6e/YdNANgNHZjsUPjYdyVUPhFMmsCJZYG2ptb9LMfKk3i+Xv9f9DezKIc9+ZjHdFV724NLAMy1XNLF3eVJ0T0t8gfqiCPGZ2SPdIkseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgrERZGKBZn+Vmox3mJmIu4p6QzIe0/2gYqrYpcsRnc=;
 b=yBosArz4gCjW0IaCRA3eNkZz4ymPOTpNwNPVDaiqnfL9VLzBtsk0vFv7srBtmiQiolZ828yyRX19bDmxcOStvLb1JxA0wlwvvHd0DeGmrIVQSB8J2FIqq6XQ6Ndfy+O+k/uPOm0INUJTvf0j4znmnAH6vJsCQLsr1AGCqzUPrFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 18:59:48 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%3]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 18:59:48 +0000
Message-ID: <4aefad72-e8f3-4ad9-9f8f-fc32612358a0@amd.com>
Date: Wed, 4 Jun 2025 11:59:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add managed SOFT RESERVE resource handling
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <a1735579-82ef-4af7-b52d-52fe2d35483c@fujitsu.com>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <a1735579-82ef-4af7-b52d-52fe2d35483c@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcf45b6-afbb-43af-d4f5-08dda399fa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3R1U3V6UmZGdXFtS2NQNEJLUmRzZ3pFQU5qOVFKOGpzQWRVUExPdEVYRzAr?=
 =?utf-8?B?M1V1MWdoR3VaUWhxZmwvMjA1Q1RYdU9vMEU5UWlEU0d3dDA4bXc4cVVvWFBD?=
 =?utf-8?B?eFNSb1ErZ2FVYzgzUUZvUXNOZ0s4MDJWTXdMeEVMNm5KaU90SG9GaVlrdFBZ?=
 =?utf-8?B?ZTl6Nkk5b2I1SEozdm80ajFFS2tEK01kaExYN1Y3eTZYYVNSYXJsVks1TFlt?=
 =?utf-8?B?WEVOeU1FQUE1OVdFenV5dzhYazE4bStlVkhtcFN3NG1na0FGTGhtY1RQWFpn?=
 =?utf-8?B?UGtkMXA0enRRbytPaWMreTZTL0RnK3VNZElrcmFZQnlPUHdHZjNNdmZwOGFB?=
 =?utf-8?B?bkRLMVNPcnBtclpQeUxOcU9RWXhyaHRtN3k0czB4UkdveXpNZ3I5Mjl6aFlT?=
 =?utf-8?B?Si9zVXNiZkdiM0dEV3BsTHNXcldZaStOUlk0R0JRZmR4b3V5bDFKOS9OcUc4?=
 =?utf-8?B?WC9lR0ZMVWVzcDNpNis5TGhTS255U21hRmpmc3NURDFpbEV4WHpWV3NEOWhF?=
 =?utf-8?B?ckExSEVzb1BYNGcrNnlRc2ZoSzIyS0xqeDRYYUg2ODJHaS9pVXZvR3RpUysr?=
 =?utf-8?B?bGpVc2VsSU1UQm01UDN1TkJ3cmRoRjlBUXhBMnJ6bnBBaGNsT01LdFcrSUpa?=
 =?utf-8?B?MHh6Y2JDWWlxZEFLbGtjYU1rM29DRmlyRGVIWDdVT0hNa3NzcllkR3U4dzk4?=
 =?utf-8?B?RjE1WDE4U0F5Vkg0T05lSzRwRDI0TllxYVllL2lnMWxPTlZaYUZQQitzOVlB?=
 =?utf-8?B?VFpCZDVpNnJNS2RYT1FuWjJKWjY1MUFXc2lZY2JIS04yeUpic01sOFdhY0Rj?=
 =?utf-8?B?UGxEUlcvMzVEeCtNNmRCRGxBam1nZ2FtdEtQcjE5ekZKUDBheHJsV1VnWEhz?=
 =?utf-8?B?dkM1RWZQS09DTUJQWEZtOTlsaHZieU9Zb2xzVWF2TzZUZ0RqNlNFUURDZTN0?=
 =?utf-8?B?dmVDbE1uYklBcTJhS01xV2dqckxqS2QvaUIrRzVsdk1PYVBGSS9ZbEoyMGZz?=
 =?utf-8?B?SUF1Q3Y4TWllRStxRHQ0U0VWalF5TnZYRmRPa0N0Y3lzaWYrKytFVDRiNWNX?=
 =?utf-8?B?aTVDZnBRNkVMTHlaN0Z0VmN5Q1IvYlVEeXVHQnNvejJoUjlLRlFIWDNJMUJy?=
 =?utf-8?B?TUJiRzU4Smg3QmZiK2RmQ2NKd1VzZXFHNENrT2VQWllPd1ByaGlNNXhLT3pO?=
 =?utf-8?B?M25UVVgzMXNEUDlpRThGUFgxRTFQTHQwLzRua2wreUQ5Z1dpcXE5Yy9QZUF6?=
 =?utf-8?B?bmVtc1UycEd0dHl2Y3pWelFHTCt5QWNhOGt4WnR2OFRsdG4xQ0pIbkE1dUg2?=
 =?utf-8?B?UmVQM2pVRkNoNWkzYTlNUVBiNlhpMmNmUldFZUtZVER5SXF0WnlPRU00MFRq?=
 =?utf-8?B?STRhbnFLWkFXZUFvSlZMWDFQZ00zM0IwZ2hYQTNBeFpQb3lKdzRocGZSSGhQ?=
 =?utf-8?B?SjNZUEhUWUVON1NWdTY3cFdONWswQ3psUm1ld0RzcGtOM1c4Y0V4NkNqMnpu?=
 =?utf-8?B?cDFyMzhQSDdGQjc5Nk83T2xpdHVIakVtQTVEYlJ0ZmxxL0lVbll1Z1NKa25a?=
 =?utf-8?B?MDZ3aENpaWNHaWVRZzVseEErS0xjVmNOWnlRdzdmcEZYcjRHWlpaa0dPbVNC?=
 =?utf-8?B?ODVNakM0MFppZHVoWmtLSXZwVnkyQzlPTlBkd3ROMFVHVEhCNjdBSTUyeWZL?=
 =?utf-8?B?RERlU3JuRUhGL2MvSkd6amx5NTgvMTJ6dE1RV0pWQzhRcHMwVFIyQjhGbGpD?=
 =?utf-8?B?ZldSUHNPb2JVQ3VlbEprTzVIQVB2QVVuZW8zUnFPNkpjWkh1aUpQbnJ1TERS?=
 =?utf-8?B?OW1DTGZzdjVDcU9wRThxUEJkWExMRXVxdHJ4aGViUm5Qcm53U1duZURvekVn?=
 =?utf-8?B?QXJHN09VZXhSNTlSWXlPeGlOSmJOOUh6aUdHbUtsUnhQYW9HUGIwQUtmQ1Ru?=
 =?utf-8?Q?txnpotEueTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0p3Zm5ob3BYZjRmOXhqd3lBNVk2MDFTMGxZR2tVSkRmdHlpRUdxSTRIV0hJ?=
 =?utf-8?B?MkMxQjc3RzdDS3ZoZzBWMFRXODVYU2lPaWFFdjU2RDVBVVFEQTk4a2RMUnRX?=
 =?utf-8?B?VkhjTElNMlhVYTNVZmI5UVRMTGlZbzI3aWdySklIdm9KMEd4ditwd0M3MTBx?=
 =?utf-8?B?dk0wRFBDS0J2cnM0QWcrMElpU3NWU2p2NGk5RUxCcU9jWVZWV2g1SG1XT1Np?=
 =?utf-8?B?M21EVElidG44c2lDUnl0VExEeUxHWG12K0p5RlFMSEFPeHZ6Wmd0NWxqcnp1?=
 =?utf-8?B?ei93SkEwUUZWbWUxZHVMdE5EODZldGd2UUdmc0R0Q3ZsWmlFY3BiNkxrUGth?=
 =?utf-8?B?Z1gxUzF5T2NaQWpsaHNTZ2VSbXRaWUdzRFMrZFRsall0U3dveHdzVkxCYld3?=
 =?utf-8?B?a2pYeUc4YUZoYTRqK0U5VlJCTXN3UjFKL0RaeVM2WXkvSFJZNkJudmhDSDRU?=
 =?utf-8?B?RXYyZit2T2lyWVZmdTg2d25pakVlWEFmbGhkbnJzTGFTNWlaYkZUWlVsM0lP?=
 =?utf-8?B?VExTN3krRklUTlV4Q2F2aTV0cEtoSm5oWTFGRVd3NUY3Y3EvYk9FZnhHTWdO?=
 =?utf-8?B?MnYxdWZmK3VZVnNnbGNyYlpHSkJoVGFLMndYZE1xNEVXNnVHRERCUEZleGV1?=
 =?utf-8?B?M3REMHlnOTJoekd4a1NLQy93UExTbTVhY2FOR1EzRE5DczFVcUdUWU5vU2Uy?=
 =?utf-8?B?S2g0bHFSYmZIUDBrQVNVR0NUNW44U0lFZEhCNGR4ZnRSeldTQmY4VmZ4K0Qy?=
 =?utf-8?B?RXJNaFMzdTZwdEl4UVdFNW5uT01nckJsczgzbWhSQk9LMmxkcTEzcUVHQlEr?=
 =?utf-8?B?NkY2aVJTZ0tYSXZQTDI0ZytzQlVka00veUt4RFdRUkUzazRRQytFOVNkY09m?=
 =?utf-8?B?MS9PWld0by9naHBLK1krVkV2aWtlOWExTTkrZ1htSlBVcXRIOFFwakx6ZnFw?=
 =?utf-8?B?TTRFblAwZ05ONFZNTUpUUHVYOVYvcW9aZGNzR0gzUVdBbEF1UE1qTlZiWkpK?=
 =?utf-8?B?eGdzeGVGanRqNFBKZ1ZSanVuUUl0Smh2RzZBdmhvOFc3bysxKzJ5MjNnNkFo?=
 =?utf-8?B?ZG9tdWozemZ2S091ajRLQ3BJcmtmWEFWRWhRTWI1VkwwQWord1hINnh4MDgz?=
 =?utf-8?B?RmkydG8zWGNLOFlaVVdYckFuREJVV01ocno0TldPaTNMWWRkWEVmUTVzWHVm?=
 =?utf-8?B?OWkzeE5COEQ5d2lYT0hkTk4wNEV4Nm5paFhTdHBVUEU5RmFsS1h3S3hSNGhU?=
 =?utf-8?B?RG5ld2xiU1NlQkRhclR3amJtQmVOY2dmdmNGUmJ2S0g3amYyMFh6c2JvdjFw?=
 =?utf-8?B?TlhBNXo4a0hCTG9XUXNzaEg2VjI1aFhOc0p5RGtQa1dMd2pQMnZ5OENkalZB?=
 =?utf-8?B?L0M0TjY1ODhWRTZPWEs3YUd5N0NBMTdEOFptZWx6NjJjdXNSK3pZVXJDU2Nj?=
 =?utf-8?B?UW1KTW1hQmZIdGFIaUdIKzdqQUxObi9RL1pIZkhXazJIVnBmMlVzUnBiZWlZ?=
 =?utf-8?B?ZzQvS0xpMitjaFBBblc4ek5YS3NvKzZubjFpay85eFZIN3o3OGNZTFBHbEcw?=
 =?utf-8?B?ejJXb0VsczBPMEpGM05TV2IrTFpVWVRtbnlkaTM5RXpLdE1PYVlsa2xZVU80?=
 =?utf-8?B?eFJKcEFMajNJYUROa3ZTK1hIaVhaQ214TS9XUHpHZEJsSDNTazB4LzI3Z21r?=
 =?utf-8?B?QUIzb3JpVmlnYU94Qk9GcWpzRGFaZXVqNjRTQWZ6UzFNMlVIZXZTVUYzdk1B?=
 =?utf-8?B?L21xRG51MFBkaEsxRWIvWlQvNjh5MWpMcVJYNUltNlNrRGhtdlNtSFZuN2w1?=
 =?utf-8?B?RGEwQUhUTzhHOVRjVG11V0ZhSk5MZHVXMFpDT3dhRVdhbzQ3cldpSjMrUWdX?=
 =?utf-8?B?R3dPK241Q2pIcVMwTUFTanA5dE1DUDZoWWFITjZRSnI1aVY4dWM4dlpGMnFz?=
 =?utf-8?B?THhreWljMStYTE40ZzA0c1VMZzFrNlc3aEhYb0ErVUhFdnBqRmpnVEwyUXZV?=
 =?utf-8?B?T05qQkE4ZllOMk1qQ3NFRlhHdVdHT1VtM0dnL0c4aEM5cTQ1QThpY1djNTU2?=
 =?utf-8?B?Vm1vUFgzQmZPcmg4QWJrMi8zZUt3TzNWZ05EdjhUUmM3cUJVOUdud3FXbis3?=
 =?utf-8?Q?OxLSdzQEBjYuBncGuLbzkGtF5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcf45b6-afbb-43af-d4f5-08dda399fa5e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 18:59:48.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL0VvLCZvmN66s/ha3R3ViY29RQjP4yRfSasmOO6YEWOb+IgfIAJLcPaN4FOEucnhR7PyBrRc/P4X39fcNLVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

Hi Zhijian,

Thanks for testing my patches.

On 6/4/2025 1:43 AM, Zhijian Li (Fujitsu) wrote:
> Smita,
> 
> Thanks for your awesome work. I just tested the scenarios you listed, and they work as expected. Thanks again.
> (Minor comments inlined)
> 
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> 
> To the CXL community,
> 
> The scenarios mentioned here essentially cover what a correct firmware may provide. However,
> I would like to discuss one more scenario that I can simulate with a modified QEMU:
> The E820 exposes a SOFT RESERVED region which is the same as a CFMW, but the HDM decoders are not committed. This means no region will be auto-created during boot.
> 
> As an example, after boot, the iomem tree is as follows:
> 1050000000-304fffffff : CXL Window 0
>     1050000000-304fffffff : Soft Reserved
>       <No region>
> 
> In this case, the SOFT RESERVED resource is not trimmed, so the end-user cannot create a new region.
> My question is: Is this scenario a problem? If it is, should we fix it in this patchset or create a new patch?
> 

I believe firmware should handle this correctly by ensuring that any 
exposed SOFT RESERVED ranges correspond to committed HDM decoders and 
result in region creation.

That said, I’d be interested in hearing what the rest of the community 
thinks.

> 
> 
> 
> On 04/06/2025 06:19, Smita Koralahalli wrote:
>> Add the ability to manage SOFT RESERVE iomem resources prior to them being
>> added to the iomem resource tree. This allows drivers, such as CXL, to
>> remove any pieces of the SOFT RESERVE resource that intersect with created
>> CXL regions.
>>
>> The current approach of leaving the SOFT RESERVE resources as is can cause
>> failures during hotplug of devices, such as CXL, because the resource is
>> not available for reuse after teardown of the device.
>>
>> The approach is to add SOFT RESERVE resources to a separate tree during
>> boot.
> 
> No special tree at all since V3

Will make changes. I overlooked the cover letter.

> 
> 
>> This allows any drivers to update the SOFT RESERVE resources before
>> they are merged into the iomem resource tree. In addition a notifier chain
>> is added so that drivers can be notified when these SOFT RESERVE resources
>> are added to the ioeme resource tree.
>>
>> The CXL driver is modified to use a worker thread that waits for the CXL
>> PCI and CXL mem drivers to be loaded and for their probe routine to
>> complete. Then the driver walks through any created CXL regions to trim any
>> intersections with SOFT RESERVE resources in the iomem tree.
>>
>> The dax driver uses the new soft reserve notifier chain so it can consume
>> any remaining SOFT RESERVES once they're added to the iomem tree.
>>
>> The following scenarios have been tested:
>>
>> Example 1: Exact alignment, soft reserved is a child of the region
>>
>> |---------- "Soft Reserved" -----------|
>> |-------------- "Region #" ------------|
>>
>> Before:
>>     1050000000-304fffffff : CXL Window 0
>>       1050000000-304fffffff : region0
>>         1050000000-304fffffff : Soft Reserved
>>           1080000000-2fffffffff : dax0.0
> 
> BTW, I'm curious how to set up a dax with an address range different from its corresponding region.

Hmm, this configuration was provided directly by our BIOS. The DAX 
device was mapped to a subset of the region's address space as part of 
the platform's firmware setup, so I did not explicitly configure it..

> 
> 
>>             1080000000-2fffffffff : System RAM (kmem)
>>
>> After:
>>     1050000000-304fffffff : CXL Window 0
>>       1050000000-304fffffff : region1
>>         1080000000-2fffffffff : dax0.0
>>           1080000000-2fffffffff : System RAM (kmem)
>>
>> Example 2: Start and/or end aligned and soft reserved spans multiple
>> regions
> 
> Tested
> 
>>
>> |----------- "Soft Reserved" -----------|
>> |-------- "Region #" -------|
>> or
>> |----------- "Soft Reserved" -----------|
>> |-------- "Region #" -------|
> 
> Typo? should be:
> |----------- "Soft Reserved" -----------|
>               |-------- "Region #" -------|

Yeah, Will fix.

> 
>>
>> Example 3: No alignment
>> |---------- "Soft Reserved" ----------|
>> 	|---- "Region #" ----|
> 
> Tested.
> 
> 
> Thanks
> Zhijian

Thanks
Smita


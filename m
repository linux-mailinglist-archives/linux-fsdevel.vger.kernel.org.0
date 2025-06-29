Return-Path: <linux-fsdevel+bounces-53234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D8AECF8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 20:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BE33B5662
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B1A238173;
	Sun, 29 Jun 2025 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AvnqrlAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870B43151;
	Sun, 29 Jun 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751221539; cv=fail; b=h8+9tTkVT5Hp6qCkL1xa41WZcq+jRSXAg99lB2Tbjh3XUFDkoVZ2yYaro0lVic97JiD+gxxwqdlc3ql/i+ICJmVGLyGdUqgglVrm58y9dTmxRK8lC3DP4CVka7DO8tz+4Pmh4ILki3cwTaprzMBm4kPzdNGCSuyIriE4n3KQhTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751221539; c=relaxed/simple;
	bh=4QjKCvifZTcFjypJ0pq3FKqK6OzTtr/6ReWAXSQakYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAmX1KAZQvnfH8kCR4diUGvy37RUHtUhL6OKuXU37OC6DtygBz3orHDRExTrX5e7bbMvdtC3QLtH/X1KJIQ635fXVf5EkeLgXVNYIBiu59Hr1vk7+L4dyNTnl8Dz6gZ8qqIO0mX8YXcJwrMaCG7rEzRaJtvbKJqtOLJ4/MTyrhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AvnqrlAR; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaDnVQ2fGYzoSSteyZj5ujI2shKKzuI5yrYo7yh8bMqobhHzzWrILYyw1t4AjiVHVRvz9x4laXwdnLpX8Gr53u9XWenBcvKtC3h72rScZryYX+co4DRq9Zqmu2X37sdXEmRdZY6UxYJvD9DCDRjqhKXpuwx96rV7yPFwog3tnqkX/4e3t766TZC5oYqjrBZu0XfNSfQrDySnmJIZIyIaE2jywUiSqNClyLuq53WidryI4iyoBdZAN1NyjcGSM8LtYxheGxqkPle5BbQAlkKmpZ3xRr6PcADAUntZzl4xQQDs4fLBiyOjBFuahzI5gOBKaFGKwBwrI+VjnbtMSrLSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ5bf5gsVspr0vviQQSRXt2IOUVsllRV1dLTe1irK1s=;
 b=NAqIWjz/4BGr5VxYXryVUCaTkxkVK7cyInKXvfQNnVmIcRHdbsStVB7fe6WmFxy6Z3oChIbGRmyBkqjL9R7B/W0NTKwhKsmFsKMT8sMxqFdlv/n9MAe4BRih+T48onqed0UCdCnVO6J4Nms61ppDeWtYsauDJ1HdiAD8wkDcYv6kEcSR/y1M6r3eAbGKP2v7yyAE6OFi4DL8oVALvPXQqHvc+h5k/4C72rOdirqqX6wVoS693PUV0+zEsMdpYpAJcNAW7yawXqGPu/veuFwvR46GBUqHMehyQWLz5B2GZTPecJ3A7ENiN1bu9P3Y7A6GufmCn5TXn1EfeX8wNJtjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ5bf5gsVspr0vviQQSRXt2IOUVsllRV1dLTe1irK1s=;
 b=AvnqrlARZ3Qe37VGJf3goRauojUJjQdE5O3gdxllVMWfkCM4mNH1Pg/QGSVDKgBmIRi3viWbHiHbovclxrZ1tx4g1GC+6PtUaXl35F5CCoxZnniRVc27aykTnWEOA7J5pnhbiHPfMMgcOEr6CrnvLb7jM8KXsUUrRuJjd1nswCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by CY8PR12MB7681.namprd12.prod.outlook.com
 (2603:10b6:930:84::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sun, 29 Jun
 2025 18:25:35 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Sun, 29 Jun 2025
 18:25:35 +0000
Message-ID: <8f00216a-cf11-4866-ba69-1d398e35f929@amd.com>
Date: Sun, 29 Jun 2025 23:55:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 5/7] KVM: guest_memfd: Add slab-allocated inode
 cache
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, kent.overstreet@linux.dev, apopple@nvidia.com,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-6-shivankg@amd.com> <87ecv9ojuh.fsf@DESKTOP-5N7EMDA>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <87ecv9ojuh.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::31) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 286c7861-8f65-4cf9-ed35-08ddb73a56cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkkvL0xFRUtBMmNHdmJGbFIyaUp3RHRLLzVnVWladld0cXdHUHppdkhaMGl1?=
 =?utf-8?B?a3ZwR25kSGtqOGlxTTMvbXB4NDJodnRSWE5xbVF1dkVsU3dZOFlReDJWZWFH?=
 =?utf-8?B?OVhYcGt2dVJ2dFpnL09MMU40VXYvTHVOVW9sby9BUjZmR1YyR2dOUTR5UUNP?=
 =?utf-8?B?alpJQ2J4eTRNM0hSTkpwNDc1cm03enNsMVgvbFd4NDRpWFlYNk5RM2NCd01s?=
 =?utf-8?B?Z3lEYS9SYWRUanJVYmZuVFNJMTFLZCs0Y2swMmFKbDdDbm1za2V3ajdFWHIx?=
 =?utf-8?B?TDVHN3N0ODZYYmFxMWZJV3YvSGdCY2l0eFNLVGZUZEZyOHAvaWVpWUNIODA5?=
 =?utf-8?B?K05zZDI2R25RL0xQUi91clVHUzlmNVAzRkdHYWQwWW5Tb050U1JDMVdDSzVa?=
 =?utf-8?B?ZmdEV0M5SHk0MjlRUDhScWdzc2I5TDZPbG9GbTkvMTdORmlWYUxwZlh4ZjJB?=
 =?utf-8?B?YkhMRkVZNklKZitoMGs4ZXN1M2VGcmlrWE5XR3I3RHA5aTdxR1JJN3lOeWZC?=
 =?utf-8?B?OVFOdnVpdE9ib2lOVFpUTm5tV1JwK1ZBcHcxYW0xOEZZdHlKVEV6ZVZoM0cy?=
 =?utf-8?B?Y2R2Z2FvUk9WZ1Y3dU1KRzJTR053aEl6UW9sNkRESlFLMG9xQ1NQNWZCbklO?=
 =?utf-8?B?dmF3cUg5OGZqamltL1I5b3RJemV3SUh1M21qNGxTcE1EdExzVGoxdmZmK3Jx?=
 =?utf-8?B?RTFTd0taYVBCK1I2QVpzU3FiODl2YlFnamhhdm5LMEx4VWl2dkUrY0JkUHVo?=
 =?utf-8?B?VDREdkJoZUJ4Y1U5TTN0QVNIeEdtTFZBVnVyMDJNTU1WcEZKRStwcjRwb04w?=
 =?utf-8?B?SStGYmIzUkYvYVBjQ3ZrRVZ3TlVjeTF6V3lGREJESzFPdlExdzhqeU9CU0FT?=
 =?utf-8?B?QlFIN0wxY0t2VUREQk9FbDg2c1BlRzdxL1dwc1h4ZWhiRURYcndtc3Uya09z?=
 =?utf-8?B?WlVqbk9kUlptTVJFQWYyTFJRVkJLU1pBd25XVXNaZE9QaVlKUFp5ZkVMSjNG?=
 =?utf-8?B?NVU2NDY2cWpuQVVrZHJUMmlzTXdzLzR2eGNUaXpTMGViV3lXYzE0TE8weUc2?=
 =?utf-8?B?ZHFmMm5oek5VNzlUaG15ZEdyL0FLdExubUR6d2dITWNQKzVWUGJkTHUvTXkr?=
 =?utf-8?B?K1BKYkdvSkIrQnRlWEJDbEJtVDZ0ZzVjKzJjUlByUEVFamZCcFlwdVliOU1F?=
 =?utf-8?B?bnBxNVZISGpBNkF4TGxOV2NTdTJNaDRFZkJwQ1dyTU1CL3VqbE1CeHVIS24y?=
 =?utf-8?B?dlovTjh2TWZ3TmFVdmVBSFg0S0JZV2ZRa3g0czRxZWk4aVR4UForV3Evcnd4?=
 =?utf-8?B?eENvTGQ2bk4xQWdaRjFCRzlWQUU3VVV6cUIzN3k5a3NHVGpDSWVvQnJXdWYw?=
 =?utf-8?B?bFlyUG9wVVhDeHFjTDg3NkwweUw3Uk5ybUNiTEVWeGZCN3pMc1RUZldrV0Vn?=
 =?utf-8?B?YUp4aFl2U1dFdXZQMnlyNHdtQjlwRnFvWEVBZHB1TG5XblgvcDZEMi9pUjBo?=
 =?utf-8?B?Zzkvd0M1LzBNV2M1dVVNTW9oRXV3TWRRRkRxZFppYjBxejkvNUMvUlFZV1FX?=
 =?utf-8?B?OWRWd3lLYTlTTTdMQ2dWTjljeFhuZlpWSmk0b2JybElRS3VvTHdTREV3cjFk?=
 =?utf-8?B?WklkUHFNQTZ1KzVqTkUrbnloNWRJeGpOeWk0MzZjQkdUVndKdWh6aTdYa3Rp?=
 =?utf-8?B?emRkYU1vNzBjc3drM2pWRWZFWDQzQkZtZWpQNHBPc2d5elBKc3FnRitONmdQ?=
 =?utf-8?B?WE9lMmRqOEhqNzAzeFVkTE9WcDVjWTcwVVlZQ1pnbTBDWU96NUF0Y1Y3WDlK?=
 =?utf-8?B?dkZrdXVMbFNZSS9VTmlYMUYrdVdrRmh2cjNqREd3OWlBRzRHOW12ZWhsOEJ0?=
 =?utf-8?B?Lzl5eGo0NHFZZUJFUGxOUVZ4U3l4TTZZZ01jeDJVRzgwRWF0RVlGTHNxTlJa?=
 =?utf-8?Q?GAk7F611nBY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ui84Y3FPaGtVVjNaU3Jlek5ndmt1amtCYThmVnlpWTdVdVA3YkFKNFBPNnBW?=
 =?utf-8?B?R0Y3emVVdGFOV2IvS2dReWpCd3M0M1Y4TEljMUdaT21WR0VWdUhKUTdsemtE?=
 =?utf-8?B?T1ZnMVNZNVB3bXp2d3NGUExjS21zekZ1Z3o1cDlMR2VqSStVTCs5ZSt4N0F2?=
 =?utf-8?B?MDdTbVViNzBzd1dNUHJMMUhoNDAzZG9KUHJCQUJZTGJsTmFRVUQ5MlpKNC92?=
 =?utf-8?B?MTAwSjh1bnVmVytmZm5zTnlYYWtrVE5zN2hJZFhtUmYvWFBySmsySVNBOVlS?=
 =?utf-8?B?MWRkeXZQYTJHTC9KdHRyZVZVUTJBZWZncHhLTXNBK2dXM1k4STQ5YUdUQ2I4?=
 =?utf-8?B?VDFPRDFCZDNtV2k3ZUZvWWxkd1BtOHZNb1MrTWhrdU9pSzdSZ0dUSkpSZm9X?=
 =?utf-8?B?ZzJSMi8xSEs5c3ROTVZEZ3NWNzNuMzZuR3lkR0dkczBwWXdTUWxCSWhkWkVz?=
 =?utf-8?B?cVgrV0dpVmRodVkrZ0xVWlhGYXI1Ulg1Q0pwMDFqRGMzQWRpaktuNm9sbHJn?=
 =?utf-8?B?dUhPMmdJc05nUEwwVERuRm0zWjVKNTdxTkx2MzBvQmNmSnAvUjg5ems4VUl6?=
 =?utf-8?B?UUYxWFh6SmczQm1DODh1L0hMTExrenlpeTQ5NmQ4dFcrNHVqN21naDF3UHp6?=
 =?utf-8?B?TEtvbkNWWjlaQXBlVm9lL2VZNGE3OTdCc1crRmoxa09JT1hTQzJNQVdyRERt?=
 =?utf-8?B?ekUyNUFDQzVtbnNHZDJOR0pWRVoxVXlYcU5yRGEvdGZMeHJrOStWLzZWaTRD?=
 =?utf-8?B?enBlUXZudVJKUHFwQW5NTGVhT1VwclZnbitOb3ZQNG4zQzBwbFQxM1dPdXJE?=
 =?utf-8?B?RzVkWEZxelVmMytCN2hiTjFaeHZtbi9GMkVtTncyYXdndWRaUmZQM3dhbHdu?=
 =?utf-8?B?Z3FwbWp3djlveDJhMys0clZBYm03c0NGaEZHVXNodUx3VXkrdXlHdHl1V09z?=
 =?utf-8?B?cVBlSWl1bzcvZ0IwQXRWS1p4TWtpN3BHVjNJbmhBZWoxM2Ztc0hsaUNucWox?=
 =?utf-8?B?d216b0JlZ3M4dEtOQ0x5YWRReGFiR1FCMnlhLzljL3RvNndGbGw0Q3RFN1E4?=
 =?utf-8?B?V1NNVC9DYVJMK0cyRjVHU3ZMVjdwQllNMHlNaWtuTzVwazkwbG5rbWcydlYv?=
 =?utf-8?B?OTFSNXhwY1BGbzFudUQxZ2JVQS9wekNkMUtYSlRRT1hkMHRhRzliYkRuTjZJ?=
 =?utf-8?B?R3FSbHNJZ3JubXdQQVpiYVdPUGYyUVNtcExJbmpHS1lxZHg4UmVjaEVMdHNX?=
 =?utf-8?B?ZUxVaTZFMWVQTmcxaXZDK29Ib2VkR2VGdmJiNGRyUmFzZXJreG1IcFRiWVcz?=
 =?utf-8?B?Mkw3NWRJcmRwbEdxTGNLT2QvQTZER05UclNvS2pURHAvMWh4M2NBRi9NSXk1?=
 =?utf-8?B?ejBpRWdvNWJlaWdWUVMydkMvcmE5cEpzNW85SkNNNVZ2Y1pJMy9ucDNRMUQ1?=
 =?utf-8?B?bEdEZFlXVVJzQ2h3eTRETVorL3VmTUxIZkhGWGtJVE1SaU1pSExOekVFdENK?=
 =?utf-8?B?Q2tuY0d6Zk1MeVZFMHcxR0JCUWdpNHFrcHNHUVFoNDM5MEl2MUdma2t5SExi?=
 =?utf-8?B?MVRKM1ZYcGNVZXlNRzRJQkRnWUJYc0ZUNm9aVUFqOTZhRENoa2hhUWt2azgv?=
 =?utf-8?B?UG1aNkhTVmIzMWtINVJ0aUV0OTE0dWdicWpvelVBNWVwQ2Y4YVJraG5YZDU3?=
 =?utf-8?B?cWp3OUlqZ1VJV3dkSTMzcXMyVkNNNUI3MnBKZ0NqZE5yNGRGS01HQVpSdUY3?=
 =?utf-8?B?Szc2S0ZFZ0pNTld6VERXVTd5a3RGN2hQaTdsSHFxbFArMmFhajhLbEgybzJo?=
 =?utf-8?B?NUZxQis1b00xdndLVGsyOHVRNWNjczRxNStqdWVzWlNSTjZiQ3paNFZXSVRt?=
 =?utf-8?B?RXU2RURiZy9tcGhYbFYxb2MyYjE2aHV5OHp2OGl5d0xWYzFHR21XOUFjNUZz?=
 =?utf-8?B?TU9JSUpWWkErYjBCRVFaRUwwV3dEZTRPRnhSRXRDOVhaSGRHcEtBMmR5NUlH?=
 =?utf-8?B?K3dlVkV1T0V2bFJzNmtOaUs3TTJENjlBZlg0VnVPT05nMEhxVFJHcCtSNExG?=
 =?utf-8?B?V3VtRmE5Z1VzNmJnb2txSDJHOERUcFhFQzh1TEVBT3U1VFJBWFRlWWZJd01z?=
 =?utf-8?Q?55Za9I2D0NxJREezFHrkUsYdS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286c7861-8f65-4cf9-ed35-08ddb73a56cb
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 18:25:35.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuGtdqfRGns2HGH3k8b0MYsUywu/HYvWFjKQb43tMBNIjcZnDdUC0BihOKnFGk6R4aka7XmdaMayW3j59geixA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

On 6/24/2025 9:46 AM, Huang, Ying wrote:
> Shivank Garg <shivankg@amd.com> writes:
> 
>> +static void kvm_gmem_init_inodecache(void)
>> +{
>> +	kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
>> +						  sizeof(struct kvm_gmem_inode_info),
>> +						  0, SLAB_ACCOUNT,
>> +						  kvm_gmem_init_inode);
> 
> Check the return value?
> 
> And, I'm not a big fan of (logically) one line function encapsulation.
> 
>> +}
>> +
>>  int kvm_gmem_init(struct module *module)
>>  {
>>  	kvm_gmem_fops.owner = module;
>>  
>> +	kvm_gmem_init_inodecache();
>>  	return kvm_gmem_init_mount();
> 
> kmem_cache_destroy(kvm_gmem_inode_cachep) if kvm_gmem_init_mount()
> return with error?
> 

Thanks for the feedback, Ying.
Good catch on the leak!

Regarding the missing error check, I noticed while looking at examples that 
kernel code is sometimes inconsistent with kmem_cache_create() error handling, 
but you're right about checking for failures, So I'll handle them properly.

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 7b8c548986d4..8cb83692f7a0 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -530,20 +530,23 @@ static void kvm_gmem_init_inode(void *foo)
        inode_init_once(&info->vfs_inode);
 }

-static void kvm_gmem_init_inodecache(void)
+int kvm_gmem_init(struct module *module)
 {
+       int ret;
+
+       kvm_gmem_fops.owner = module;
        kvm_gmem_inode_cachep = kmem_cache_create("kvm_gmem_inode_cache",
                                                  sizeof(struct kvm_gmem_inode_info),
                                                  0, SLAB_ACCOUNT,
                                                  kvm_gmem_init_inode);
-}
-
-int kvm_gmem_init(struct module *module)
-{
-       kvm_gmem_fops.owner = module;
-
-       kvm_gmem_init_inodecache();
-       return kvm_gmem_init_mount();
+       if (!kvm_gmem_inode_cachep)
+               return -ENOMEM;
+       ret = kvm_gmem_init_mount();
+       if (ret) {
+               kmem_cache_destroy(kvm_gmem_inode_cachep);
+               return ret;
+       }
+       return 0;
 }

Best Regards,
Shivank


Return-Path: <linux-fsdevel+bounces-46237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B1A85484
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 08:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4861888CFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 06:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717327E1A5;
	Fri, 11 Apr 2025 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nkqjprjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FD1EA7C6;
	Fri, 11 Apr 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353789; cv=fail; b=b/N1vxGv8lxU87MuFslhjM74cl21iMRT3nz9PKrquS77H14lzckgvi4AqapoakMJo9h7O+s9RpWLn68n2BcCSS1v8fmKQev/hdsCwAsFzMgKCJHqeMtc9VqDLdEph3v+0x8FkamokSzoyfx8XKFQoYK296WgNhEk0eHAuRU+Uks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353789; c=relaxed/simple;
	bh=nI78Tp4bgbVyYRJU+tOrOyXQghTovBGCiP6GJ4JlTkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sQWFptwWYOZAO2E1JG3bgWGaTgeUR4Ox6wwC8nJ/W8Qg+v18wLDlDRrZgVbsGe8CsRRHg3DcZyCbG3o0GD0FYLRqS8uaf3V0xoXR3HDD6EqfBTxcw9/9GRZtIPFd82pQSa6zFolBZb8HfwkMHtWCF7IQOw+tGq6ml4NjXBySQJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nkqjprjf; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgrklZ8ukfm3oFldyjTv/P7QH4XjcVH+b44SckniCbuUPvmo3yB0GIT9rb2SdeHr5TdK5YLqcGKeio3fRaDH8eJ6MwNb/Td65vrayCkJzdSfie5lBCN8VUIjddtYPFy1Q/Kc6iipO6a8VAQRFdlepKK+VOIxDPfbIsMPiPLCUhAZfcQnqqvIGQDBM1t+e8tkQfrtwPuszSB8/S/NuHNsSdB5KlHX+F4nWoGu/KZu+GGfMfSQshsNq5p9kqE457kATOdMACMkBvvKsRqQw+GrULOzl1gOiJ1IbmanD+JCQ6hNRSBgernzEjU9Z777e/3iZlLpWApz/pwJl66v+/ZtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l7CGmUtlbf5xnyuxQumjqeeLoHI8pJ6kYzQkbNfz7k=;
 b=KbxS2C4//gu+Bon8ZjDEAWA5Umx0OOeALMr5Hqjv6lEYuNG12T+KA5zCp+fHZW1lPMrevZIOW8KAUfTliOUd4AGcvXVBvDdN8pFU6MdoRaMj1R0dfB8f0nylKpQoM8a5CwbLOZFOljPW1O1R7yf9XeVjYvJ+JBeVO/T3ygNBjqrcLhUUwi+TKCtTl4LNVuDy1OQbai3H3xHdrd6DeheKV18uIs8vEVINiGl4vnHJ2gN0BLimOmo/yTGHtPewBl4WID+Dl9Tn0CQiHshBGdk5UOG1xk51zMr2JeoYrCRaR6W5qq1S/3sb+eSrPPMy202Cb4NKrLidqx0IljyxRxIm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l7CGmUtlbf5xnyuxQumjqeeLoHI8pJ6kYzQkbNfz7k=;
 b=NkqjprjfBYazhRoENuKKSd1CPllIHWRZ/3dMV8ZqwI4q83SGmunyKuFgkWKoj8xvHpiLYfwb4P/X66A60y5nI2rOvw8gbznXR1G9r0goxStxY1NQBCteJ18V1Ldu1NWiAuIunwzwY5SkPHLtr5W8sNUVPhypnBxuGBCwQstfWR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 06:43:04 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 06:43:04 +0000
Message-ID: <9feb99d9-85cb-48b5-b22c-3dfea2b9e190@amd.com>
Date: Fri, 11 Apr 2025 12:12:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 7/8] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
To: Ackerley Tng <ackerleytng@google.com>, seanjc@google.com,
 david@redhat.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-8-shivankg@amd.com>
 <diqz7c3s5e3x.fsf@ackerleytng-ctop.c.googlers.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <diqz7c3s5e3x.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::16) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ca86ab-99ed-4692-6ce2-08dd78c41beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDBXajBTdHpnaUpqNmtDNE1LckZnNXVKM1JrNTV0eHVCSnhjbjZEUnRIY1Fh?=
 =?utf-8?B?KzJGeVp2N1V1YVZZZklJWVI1UkxvV2RIU3Q2ZVNwTjZrZnRZRVJMenFRd3Ra?=
 =?utf-8?B?WUJwOW8yNHI1VXB4cHhFVGxEV2NHS0xvdjVDNitoNkQvekVHWUc0KzlJWklp?=
 =?utf-8?B?YnVYcm5rMGxXdGdzSTZnbk8vZC85eW11ZVF2eFM1YVN5OVdYYytoVDV5ekhV?=
 =?utf-8?B?UjhvdzVLMTlQalM5b0ZUMEpTV2ZpK2pQaldsT3Z5Rzc4ZkdqTERWNkFGQVZS?=
 =?utf-8?B?ZkZCUkhYU3VtYmhHenRGSm9WdHErWXF4QWh4T1NiR01ZYzVtS0VheGgyZElL?=
 =?utf-8?B?eHZhQ3ZuZy9OQVl2RDJaek9tQ3FEUG91S3ZlVERheTlxTnNHMXFLbW44eGFQ?=
 =?utf-8?B?TGpzYXdIZ2x3NnpscVV6ajRZb050ekYvRDBkKzd4M2g2SDZXOEY2MlIwU3pB?=
 =?utf-8?B?VUd6Yzh2WW9KRWExWEIrY2xDRyt1TXVwZHJlclpxTkhFOE9GRXpaRkFzWTE1?=
 =?utf-8?B?blV0TEx4M1A0aDhvQUp3RkFPQ1VXZ0ZNSXd6YUZaWDMrZExHTFZYWE5VN2pa?=
 =?utf-8?B?am1rN0pEbkNGb2didXI1SitZQVM5NGVWQmVpbWJkYUFWU3J1RmNpQTZDYWZa?=
 =?utf-8?B?Mk0rN2VkRWdqRG14M3RhZXZlbC9ZazRwSm9MVit0cFFDSGQ0OW9KS21Kc2ls?=
 =?utf-8?B?MitHNk54ZUhYNFo5RnpiWkFZSzJGQVA2RHIwZEgxdFNBbVNmVzZRYytzSHJy?=
 =?utf-8?B?MDRVU3ZjVDdnYWtCaXVaZURsZjdNUmgyQ1RKZlZsVXBkc1Jkc0FaS2hmUlRW?=
 =?utf-8?B?clpJVGsxc1p6SU9rOGJhdjdKYWZKMm9xNnBIWkVWVExTRHJKVUJJMU9TYml4?=
 =?utf-8?B?SEl4RnFCNElUYXBQZWVtcHg5ZEJEQ1JjbFpwRVM2MmpFTkYxd1dtSGJaUFZI?=
 =?utf-8?B?ZDM5RkNOMVZ4Q0ZjcDdoN00xSC8yVGlHZW9RMGNFVENONmJ4N2Z6eTYraDBu?=
 =?utf-8?B?cGJBTG4yTndJZVZKaDZpRlYxb0lCWnI4bkM3RFpNZjZvSmNEUytRdmxPZFNS?=
 =?utf-8?B?NGNQNlVTUlFWQkRyaU0zYkNZYlNHR3ZPSVlQem1GcXpCRjlYZFZKK1VSNDgy?=
 =?utf-8?B?bWh4WUR3ZERBMDlVcGgwSDBQaFgzZkNILzdXYjduTVJlSmpxNUk3Z1JtSlJq?=
 =?utf-8?B?ZW9zbDBKUmpSQ0FRYUFLVGlYSy80Vk1jMk5DU083RllaenlTNlZ4UmFzRHRE?=
 =?utf-8?B?SVFXalJmWHZiYlZMWkEzRXdlNUxBblowdWxvditWcUV3SWtsUlJzdU5nOUNY?=
 =?utf-8?B?NkYwYXlmYkFoYjhoUUp0eW9aQ29XZVBiTFBoOGxvOXl3SVRtUFprMXVTYVEz?=
 =?utf-8?B?S051QTJ5TTZEL3dUQmM1ak1RVnZKN2VUa1hsTVJNcERjOWtJL1Nxd213MWNF?=
 =?utf-8?B?RjRscVFzZjdybE5KZFZNWmIrSkhyQ3g3TElYcm1KL0tCSHdOeEhGNzFVOTI3?=
 =?utf-8?B?ZWJaeEU4bnVISkdCVnd0cVJ2ZXdleVB5RWpWK2VTbDBEVUNMc2lnSGNaaW1O?=
 =?utf-8?B?RGdLTE0rdGc4OTBmWWdnZkpuMGQ4VDUxVFRadDI5N0VuRnVyNTAwQy96Sklt?=
 =?utf-8?B?SHlyM2NnM2UxRGt0dy8xUi9zeW5ENHgzNko0QkRWSXRESlRlaDR6WmV3T0g5?=
 =?utf-8?B?eTc3Umc5NERSM3UySFQxa3BEZ0tEUU40dHRhaXBBRzRRZDFnRUhBdnhiOUJY?=
 =?utf-8?B?bjZSTllTcXNOZnB5ZmF2clJpSExKMWQ0aktPcE9EUlR4UEZhbXJEUUVpZEQv?=
 =?utf-8?B?NTdNd1VUSmx1amdsZG1MRFQ0UGlBaWF3bnJSUE1idnRjeDF2NVE5VHZKUTV6?=
 =?utf-8?B?MkpWWlpoQXEvWDR3Rk9PdGo2NThOZEovT1l6S1NxQXMrT1lPNlFFbHdpSndW?=
 =?utf-8?Q?GyzFql5dzts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmppV0JXZXFjVXRsREl2S1hiQVhvTEtZbjBSelNraU9UY3BTcjhRY2s1ZEkz?=
 =?utf-8?B?RVpRWUpBMHdvTDZnbGNNekx2NGZoc1VWU1pmL2hwRHlNZjlNcXo0cDBKalhw?=
 =?utf-8?B?ZG1ZTVJGY3ZocTR1Q0VzSmpMWUwyT3Vtby9teTNwdHZuR1dmY0lRMm5oM3l4?=
 =?utf-8?B?Rk12RFB3Z3VvWjhIVCtrZ3pkMDRkZDZPVExKT044dDNEQ2F1bmI1V1NMaXJj?=
 =?utf-8?B?VmkwWXdGc1IyZEFoNWl3MG9TQlVocVcrM0pOMzBQQURmUXIreThtRmdIdUpC?=
 =?utf-8?B?MDk0UCtWeGVVdFJ2OEdpQThJanN2YnAxaTdjcFF4SXhRNzZSRklQbjJGNFRt?=
 =?utf-8?B?QmdubWxxNEhBekFpRUFPRW82OWxsSk11alR5SVNUaEw5VkF1dlZobUJGanpU?=
 =?utf-8?B?VWswQzZUZGdCV0Y0Q2V1Y1ExUHN5ZHVJbjlGdERvaWdVWFFZK1BvUXVWcTJE?=
 =?utf-8?B?S1htc1UzTndrL2U2Y3VXbXpaVytLSDc5aGNZM3h2bHRsSEExaERhd25yV3FK?=
 =?utf-8?B?OTRDMHh6Q0ZVT0RuQWpqWDJxeFd6ajk4UkYxREswM0lUMXZFTDM1NytNaC90?=
 =?utf-8?B?ZVFtL09KdE9BZW8vMTNIVERCQXhUVDZtNnRNUFh4Qi9URDlTcFVISVI4WG42?=
 =?utf-8?B?dS9vS0pCT1dBQVVZT1U5ZU1CcjBzalZFMC9kNTFkeHptL0NNUjBwYVpabG9R?=
 =?utf-8?B?bUw2R0dVZzcwNGxwbmdraitodmZvMmJOd2FiWlloQ2FNdm5sYUVPL2t6M2c4?=
 =?utf-8?B?N2xLVWczV0dBb3FnVUNSbnVFY3NRZEp2eVczR2FMeThnRjFQb2JuTFRQamVC?=
 =?utf-8?B?bnRodG1yaUhwMUV1N2VZeHF0N1llRGM3QTJUMGxtdzYwV0FLTzJTbHJMa0Yw?=
 =?utf-8?B?ZEVhamFGcng4ZHdUWk9zaFRjNk5vN3NqanI4WVZub3dGN0VXRHJudldGL0ly?=
 =?utf-8?B?VGJZZjVHVW8xSURqK01NSjYxdCtzTSs0cll2L0UwbWV2MFJDeGlKdUFqU1ln?=
 =?utf-8?B?TTQzbDYwc1kyUVVIWDBIQXdIVjFPTTVyKyszUThSOXlhT1gxbmxtQ014dm5z?=
 =?utf-8?B?Y21POUZSOUhHWGNCWk11ZXZBTTE5eGxXQ3FiZlZKR0VWbGh6bHk0anpOWnJD?=
 =?utf-8?B?V25WWkg3VC8wTktlQXg1NXFiUW1DSDg5TW5HQUgyVFEwYkJTemtzTXluSmti?=
 =?utf-8?B?emx2R3lacTFZUFRnS2llQjlSY0J1dG1mOWUvOTkyNDJQUTl1SWlWaTZNMXpp?=
 =?utf-8?B?WlZmYVlkOVBabnE5N2hBQ1kzdGtTejBGMFY4Ujd1M2V0UkxHY29nMUcrSFpS?=
 =?utf-8?B?MGdVUDBJVXFwQ05YVkNma2ZDdlhsZWdUYkxVZllCUytuM3RoN3VKS3l1SmlI?=
 =?utf-8?B?SnFWMnVsdkVJNFV2cEx5SXRaZUhEL3NzTUE3bDlMbnVPWjVQeDQ5SVdxdlFN?=
 =?utf-8?B?OW9iYXozSGx4NTNyMHZIY3F6aFV2eExSTXNHbnM0cmgyc0krcGxxT2w4SW1E?=
 =?utf-8?B?RG43dmg5dXdYanJNWlpoaC85UVJDemlCSTB3bmswMlR2SkRlY0prdTg0SnF4?=
 =?utf-8?B?ckRCYWtFd2VaSzdIRHFSOXpBd3lIMllpUGhFTC9OTWZ5T2xmRVBGNVNIS3Zl?=
 =?utf-8?B?Z0RkUEVUWlFxVkxHb2t2di85WEF0cTRZbndFUC85amNBTGtXZnBiS0RtaXcw?=
 =?utf-8?B?VXZGQXRVWUtlbnk1M1hJUXlwNCtDa0d6dmtKU1d0QVhHcXBmK1FWMUJvbW5u?=
 =?utf-8?B?TkRTeVdqZGhGaXg2ZWJVeHJFSndvdmEyenptL1ppUU1JTWNwbGhQa0RIN1I1?=
 =?utf-8?B?TlpOS0xINmRaWnB2bUxzQzNMQ0RiN3JCcFVsbFNTMEorQ0xETXRWTWJCWE5X?=
 =?utf-8?B?OFhabjc1YXo1a2dUME5BWWlZR2VSVkUrL0RVc2hJcTZoSHdldHFYalZkQTg4?=
 =?utf-8?B?aUMrMCtsM0ZJRkdjQkI4cDRoSXlIR3hkaVJra3VaRU9NZFEyc0tYYUxPRzJ4?=
 =?utf-8?B?TjBnSzI5VUhRYUZ5eWNnTDVRR0hHSVRDeU1NeG0vbUY3cW1iOGdTLzNsWmJH?=
 =?utf-8?B?bVdNNmdiS241N3FtRmx1SzhXM2ZGYXJUZlpaa2VhZy96OUt0Nmd5YUlXMEoy?=
 =?utf-8?Q?lGrJk/cPM1Xdlc6dduPAx9f6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ca86ab-99ed-4692-6ce2-08dd78c41beb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:43:03.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5PcKLdyVGfXByR4nfvspeTSks4KhS/cNzIWX09rpjo24LqoBGTj+jIb5A8uxe3oeuetWwf6kDRHthDxuI+uCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881



On 4/10/2025 7:10 PM, Ackerley Tng wrote:
> Shivank Garg <shivankg@amd.com> writes:
> 
>> Previously, guest-memfd allocations followed local NUMA node id in absence
>> of process mempolicy, resulting in arbitrary memory allocation.
>> Moreover, mbind() couldn't be used since memory wasn't mapped to userspace
>> in the VMM.
>>
>> Enable NUMA policy support by implementing vm_ops for guest-memfd mmap
>> operation. This allows the VMM to map the memory and use mbind() to set the
>> desired NUMA policy. The policy is stored in the inode structure via
>> kvm_gmem_inode_info, as memory policy is a property of the memory (struct
>> inode) itself. The policy is then retrieved via mpol_shared_policy_lookup()
>> and passed to filemap_grab_folio_mpol() to ensure that allocations follow
>> the specified memory policy.
>>
>> This enables the VMM to control guest memory NUMA placement by calling
>> mbind() on the mapped memory regions, providing fine-grained control over
>> guest memory allocation across NUMA nodes.
>>
>> The policy change only affect future allocations and does not migrate
>> existing memory. This matches mbind(2)'s default behavior which affects
>> only new allocations unless overridden with MPOL_MF_MOVE/MPOL_MF_MOVE_ALL
>> flags, which are not supported for guest_memfd as it is unmovable.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  virt/kvm/guest_memfd.c | 75 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 0ccbb152483a..233d3fd5781c 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/backing-dev.h>
>>  #include <linux/falloc.h>
>>  #include <linux/kvm_host.h>
>> +#include <linux/mempolicy.h>
>>  #include <linux/pseudo_fs.h>
>>  #include <linux/pagemap.h>
>>  #include <linux/anon_inodes.h>
>> @@ -19,6 +20,7 @@ struct kvm_gmem {
>>  };
>>  
>>  struct kvm_gmem_inode_info {
>> +	struct shared_policy policy;
>>  	struct inode vfs_inode;
>>  };
> 
> What are the pros and cons that you see of storing struct shared_policy
> in a containing struct kvm_gmem_inode_info, as opposed to storing it in
> inode->i_private?
> 
> I've just been using inode->i_private for sharability and hugetlb
> metadata and didn't consider this option.
> 
> Could one reason be that struct shared_policy is a requirement for all
> inodes (not a CONFIG flag) but sharability and hugetlb metadata are both
> configurable, possibly at runtime?

This makes sense.

I considered using i_private but opted for the kvm_gmem_inode_info
container approach finally.
I think it's more extensible if we need to add fields later for new features
and it's more maintainable when the struct grows more complex with time.
It follows the established patterns in other filesystems (shmem, ext4, etc.)
which have proven maintainable over time - so I don't have to worry
about it.
Also, since you're already using i_private for flags, I'd have
needed to create a wrapper struct anyway to contain both policy and flags.

> 
>>  
>> @@ -27,6 +29,9 @@ static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
>>  	return container_of(inode, struct kvm_gmem_inode_info, vfs_inode);
>>  }
>>  
>> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
>> +						   pgoff_t index);
>> +
>>  /**
>>   * folio_file_pfn - like folio_file_page, but return a pfn.
>>   * @folio: The folio which contains this index.
>> @@ -113,7 +118,24 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>>  {
>>  	/* TODO: Support huge pages. */
>> -	return filemap_grab_folio(inode->i_mapping, index);
>> +	struct mempolicy *policy;
>> +	struct folio *folio;
>> +
>> +	/*
>> +	 * Fast-path: See if folio is already present in mapping to avoid
>> +	 * policy_lookup.
>> +	 */
>> +	folio = __filemap_get_folio(inode->i_mapping, index,
>> +				    FGP_LOCK | FGP_ACCESSED, 0);
>> +	if (!IS_ERR(folio))
>> +		return folio;
>> +
>> +	policy = kvm_gmem_get_pgoff_policy(KVM_GMEM_I(inode), index);
>> +	folio = filemap_grab_folio_mpol(inode->i_mapping, index, policy,
>> +					NO_INTERLEAVE_INDEX);
>> +	mpol_cond_put(policy);
>> +
>> +	return folio;
>>  }
>>  
>>  static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
>> @@ -336,12 +358,14 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
>>  	if (!info)
>>  		return NULL;
>>  
>> +	mpol_shared_policy_init(&info->policy, NULL);
>> +
>>  	return &info->vfs_inode;
>>  }
>>  
>>  static void kvm_gmem_destroy_inode(struct inode *inode)
>>  {
>> -
>> +	mpol_free_shared_policy(&KVM_GMEM_I(inode)->policy);
>>  }
>>  
>>  static void kvm_gmem_free_inode(struct inode *inode)
>> @@ -384,7 +408,54 @@ static void kvm_gmem_init_mount(void)
>>  	kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;
>>  }
>>  
>> +#ifdef CONFIG_NUMA
>> +static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpol)
>> +{
>> +	struct inode *inode = file_inode(vma->vm_file);
>> +
>> +	return mpol_set_shared_policy(&KVM_GMEM_I(inode)->policy, vma, mpol);
>> +}
>> +
>> +static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>> +					     unsigned long addr, pgoff_t *pgoff)
>> +{
>> +	struct inode *inode = file_inode(vma->vm_file);
>> +
>> +	*pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>> +	return mpol_shared_policy_lookup(&KVM_GMEM_I(inode)->policy, *pgoff);
>> +}
>> +
>> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
>> +						   pgoff_t index)
>> +{
>> +	struct mempolicy *mpol;
>> +
>> +	mpol = mpol_shared_policy_lookup(&info->policy, index);
>> +	return mpol ? mpol : get_task_policy(current);
>> +}
>> +#else
>> +static struct mempolicy *kvm_gmem_get_pgoff_policy(struct kvm_gmem_inode_info *info,
>> +						   pgoff_t index)
>> +{
>> +	return NULL;
>> +}
>> +#endif /* CONFIG_NUMA */
>> +
>> +static const struct vm_operations_struct kvm_gmem_vm_ops = {
>> +#ifdef CONFIG_NUMA
>> +	.get_policy	= kvm_gmem_get_policy,
>> +	.set_policy	= kvm_gmem_set_policy,
>> +#endif
>> +};
>> +
>> +static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	vma->vm_ops = &kvm_gmem_vm_ops;
>> +	return 0;
>> +}
>> +
>>  static struct file_operations kvm_gmem_fops = {
>> +	.mmap		= kvm_gmem_mmap,
>>  	.open		= generic_file_open,
>>  	.release	= kvm_gmem_release,
>>  	.fallocate	= kvm_gmem_fallocate,
>> -- 
>> 2.34.1



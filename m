Return-Path: <linux-fsdevel+bounces-52299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CADCAE1386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B707617840C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0F220680;
	Fri, 20 Jun 2025 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uU7B/vYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F982036F3;
	Fri, 20 Jun 2025 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750399184; cv=fail; b=u63PhPry4vNBpC0gic4aZxqBxmjSjKO0bIzRzUD8eN6tzJO73ZVxrBgUZxM5UziRlUiNxcERcTyHhBNQ4hfF5BsLJo4hUL/Fsr774YQ2OG+0D6EN54getbtOMWdn8IIWkRL076hqRivhHcJHZxuKtdG4Gwfm/WbcPF4D/QBy8mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750399184; c=relaxed/simple;
	bh=X+IYb02xrZVc7t61+URlEPzxdg2orFwzhdGS1gMBrtM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y20Z1NgWKpM4trhFTpeOOiXqm5PsArYqdGbogaCNVkkUND2KCNiNGQUnd8bf2N85Mce5Bii9ySWEunxtqwqvFmwCAHoaNunEfEgn1WPN4dAnENxDY2SJJt28PaqzDvShuo5hDUcUFhui1SGbm6N+T16UcndescEt9lUU6ArlAqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uU7B/vYl; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTcnPocA7a3bieGZp4b9rqltw8pCuLJLGPAz9qXqPyJ1dkEWC8z29qPlanPIbtyVGoQnMfSTZNXLI8juLz4EcT6VResrAPAy3foQQHAqT1nDJDKuKUHqkus2QENZEmsKPyrJcI3EA3K4IPlG1rm65a19gQ4v1ggV/xPgJBqnPRk10pg6Cw+vaYP8ApDyDwJG0NoVbXkkEg1QLeDpYH2GnRkSITLGrwhiQ/SYIpcJmPAX07PJbRjI696PFt0wnZ8Q8RgeeKGvv7Ns44Pr2hmI1CODX/1dFMM1MFVXIwqnOTK75RCnx8eor561UjhtahtdeKfsikOCc9EDjv4xCzF+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x8HJsxSvAjItEqhvoyDemyWsmkuuJxn1oa9vLyEP9s=;
 b=JqeucRG2HjpSokl58iHEthAvWk/F2tph5BOYaqClj3ufYF9PDn9ZHLL6PUAnKjB5uQi3aeJy/kQy97vZpW2SHbB3mR6ol+yP8Ul4Yseb0w4Zeod0s1bgbt60KbI/LqCiBPELjO3F0FZu28Xa3gjxaeVaXiex98VsZh0QwU5ZnGANlH3siQZAwcI8Y1Xze68g6slfGu8kqR8n7vO4Ip9Swf/RWaeL6aJAveIRZoopXDQltGHTwnXf+4UbxIF93CL/VBJP3NVnogvLNSVuCGeTTsqdNKCIiK93UztUA0fUxViTkFxbkTFc9Bg/wvFrBVFNkO7UTyCenZ82ExzZ0l2bXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x8HJsxSvAjItEqhvoyDemyWsmkuuJxn1oa9vLyEP9s=;
 b=uU7B/vYlxv7knHn66Ez2uS0Sginm3KwN0xY/B1J8v+gIAEkvCYTwoTO/wRggV+fn3h2loVKy1BS8foGdKXfh8SpI/6pVHzXi8oZlb6cbT7rUOm4K+Jq/e2rJKf8wkxCeUx/XB/CxEmeQLov30Dvo6qJUA6OAlfuztiRqGyJVLag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.19; Fri, 20 Jun 2025 05:59:40 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 05:59:39 +0000
Message-ID: <ce88982b-0a01-4673-a0f2-d490b66d0fa6@amd.com>
Date: Fri, 20 Jun 2025 11:29:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 3/7] mm/filemap: Add mempolicy support to the
 filemap layer
To: Matthew Wilcox <willy@infradead.org>
Cc: seanjc@google.com, david@redhat.com, vbabka@suse.cz,
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
 gourry@gourry.net, kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250618112935.7629-1-shivankg@amd.com>
 <20250618112935.7629-4-shivankg@amd.com>
 <aFQ0v0DfWgUvqK6L@casper.infradead.org>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <aFQ0v0DfWgUvqK6L@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::11) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e14431b-870d-4e93-fba1-08ddafbfa4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0ozK2Y3enV4SkoyWXdYTjBUdnZVVFdya1FkRHR1dThkUnRFeTdURk5QTW9O?=
 =?utf-8?B?U0V6OEtqd0pQNlNvVis4cDlWdHJMK3c1RlVhWkl0MStXNEhtQlZCSFNrT0lO?=
 =?utf-8?B?VkFMK3NrV3NYVTlQV3d0OFN1RjNzMVNxN1ZQZEQ0MDVNKytHc1h4Sk1lNjZJ?=
 =?utf-8?B?Uzd3a2lCTkJpcVFKNjJCMFhmRFVTQmkvSUc4VDNHWkVZY284QktTckNEOEp3?=
 =?utf-8?B?ZVArQ3VOZ08rQlhYamU1a1NweDM2U3NWbEhzMWloOWxGOThvcEcxSGNwSndE?=
 =?utf-8?B?a09EdDNGRHVYYUNTMnVPRWdNek05OHNrKzEwS3N6S2FCRG1JR3owSlYrMWRx?=
 =?utf-8?B?S2RQVkVvZHlxbzJONHdjZ2c3TTN0czhzaE9kS1Y0eWhUQ1ZUeDdVWHVQMkNQ?=
 =?utf-8?B?eEtoZ3UrZUFTUGM2NlBIYmpyR3lxTFk4NmhaYU1uV2tLVjZQZ3JxMUVQU2ZI?=
 =?utf-8?B?UDFBc1NkN2gya0gxVDlOdU53UWx0UlBaWXdENWFZeFlVY0xGNkZKTU9VVzY2?=
 =?utf-8?B?SXA0VmNreS9qVDI5bEZBYTdDQ0ROS2M5bkpKakVXcWZES0JIY0J1UThCVS9L?=
 =?utf-8?B?S3UzZ0pTYkhtVnRpMWJRT2l0ZVNUeHBpZEZQeUlIYnFmalUxQ1VzSGcwTVov?=
 =?utf-8?B?c2EzNUNmcGdhMkhkYjVtUjdOd2h6RnFlQmVnTlVlK1VKOUlNa2tQdjBNYUtq?=
 =?utf-8?B?aEZoV21mRytubXFIM3BXa2FZSEd0UWVLMGU2b2VkZzVTTjVUWmpKNUcrRlRQ?=
 =?utf-8?B?NHJEWUhiZXczYTlkb3lNZnFTOVFLZFU3YTRLOHBieEFpSmFocGQrUVJqQUFn?=
 =?utf-8?B?OUVSU3FSWE9wMm1hM0hjUEpkWnJ5RnNrNFl1bGd5ZW9ZNFRJQWZjVGx3cXFT?=
 =?utf-8?B?TXUzaHJSNFBLU05VWFVsdmRLcGhWSnhhb2lBSjJLekZhbnc2T0prSDJGWmpj?=
 =?utf-8?B?bGVhTER1MmRRdENSMm8vWTI0a0xmY0FWUkdKT3o2LzI2QXpXNE5tQktEbkR4?=
 =?utf-8?B?eEIvUHRRMFByYTlnUlAyZVB0aE1Kc0o2MDlaMG0rbUVNVWJhNytQYmFnQ2VY?=
 =?utf-8?B?dDVLQ2dZSFRzMDdDU1I5YndZcWpsVUQ5cU1mZzlEUGlzemgwdFZTOTJ2Y0Zz?=
 =?utf-8?B?MWVNVkFUQTJkbzF1UHE1VHJFM3EwN29sT1pGTUJxSWFJZWtscFNLY0VUM3Jp?=
 =?utf-8?B?NVNhZE9ud3NScjhyTHpnMHhoWmxROHBHSzk0KzhSa1luSk5rdVhZYmhTOFh4?=
 =?utf-8?B?MEQ1TkNsSjVpNmtNeFZYOXJMWVhIWVo0OE1ZREc0SHA5cTYyL3doTXJ6VEda?=
 =?utf-8?B?YzV2dmJZYUtqOXZrUEVTWm13OG94eW52M1NOdkJ2dDFwbDJGbTlMZ2JWcDh1?=
 =?utf-8?B?UHBkNm0rWnBlNDdFMFprQmI3SGdnUExudlg1dUpTM1c0RDVSd09oTit0bFN4?=
 =?utf-8?B?WXp4LzlnYjk3bC9EbWpHR3lkNGU0bGR6ckdncllldG1YclE4ZDhrVklXRHRX?=
 =?utf-8?B?NzZxQlNXMGVMTjBRc3RMZjhtWm51MWdyRDJ2RjZzTkRkVTRTbTE3OHVKYjJu?=
 =?utf-8?B?cERtNjgwN0dZRVB1dEZQaiswYWkxcXk0aXBwUmpFay9uajNSQStOaG9wRUtT?=
 =?utf-8?B?Q1NnTmdNZzI0ZFdQT0FaNW42cmV6T2Z3VWdOVnpVZ0RHaUpUQkx6RnFFd1d6?=
 =?utf-8?B?MVBoTU9QOGxwNkl3ZUYwbVowcWtjcHN0NGtCMFJpcmxlQ2hnV1kxaXRybzY5?=
 =?utf-8?B?ODhKK1pOOEpuUytkbVRpRVVWbGgyc1RJUEx4eDczTTFUZTNDdUFQa3pjTVAy?=
 =?utf-8?B?Y1N1YTdwcjZTblMzZXh3SzVUcGY0UGVzclJQT0lCeGhIZlNtOEE1T3JFQmpR?=
 =?utf-8?B?RzJxWUQvUGRHdmltVGpJaUtBRDRVMzZXc2U4dFJqWjhxMjRCZ25JVWtlK0Fl?=
 =?utf-8?Q?i8k04/YDY3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckZVS1V3ZkNacVlWWkI2SngyQ2lidHdkVlczQlhncTVOTEFsRlMzeDIzb2pL?=
 =?utf-8?B?WVZnWDRuYzEzSVFZQkRTb2NZckJHWGc3eDFvdEZ5MVhmdU83c0xsVXBTWHdz?=
 =?utf-8?B?MHJVNWlxZ3QzZU41V2dzR1p6Q21VUFFtWWdLYWE0cUUzcStmTk9pZ3AveGVw?=
 =?utf-8?B?YTIveDVkNHNLMStDWDdTLzFibVlyWnNtd09ZZjBQSWhSOEhMNVprVzF5d0x5?=
 =?utf-8?B?bDA4K1VORkpscVVvWlRPTjNaLytTRzQ2KzhpNHNGZGorZnA0MFQ4WmxYQVNh?=
 =?utf-8?B?dmd5bklPcCtlSlNLczhBWE5XeTJEOHFSdUNKcTN1R2JpSzVLNnJRL2NLaW9Z?=
 =?utf-8?B?eE9LK1JQREl5cFUyWTVTNlFmVUJSUExIRklDbTVPaStxdGdDRFpxak8yeGJZ?=
 =?utf-8?B?MTd5bmtOVzljVG93dGh1TU40bTJPM2NoYXRBRDQyOFM2MUp1Q2d4bkZtdXZ4?=
 =?utf-8?B?Y29XdnU2R0VSYWxxUGJQTnZFdkFSODBpVHIvN1AxZVFBdmNROEVQM2F2dXZJ?=
 =?utf-8?B?MXlPNDEwVHdwN0F6ZkRBSFgrU1hhU2g1QU9HcUJJOG05QmpOUVdXQ0lmZXVN?=
 =?utf-8?B?UXh4VFRVRXYrN25JbS9YSjllaU4wdFFSemF1eXN5aEZHaEE2amxGRmdQNUtN?=
 =?utf-8?B?U3NDUGZtS2JPL1BGa1RXTWMvT3F2WlpGYUF6R2lGY2M2MWZNTlZKcmhhN0k4?=
 =?utf-8?B?UTJ5Q1BSTFlXMVY3UkdWWmc4MTVJMXVNT0hlNmR5Y3RKZ1FjeXhoZy9Vc0gw?=
 =?utf-8?B?Y09ab2E0dVVvclQrOVBOczViMDFUd1FyMlV2a1IrTHh6VGd4OWhPcGNIZnVI?=
 =?utf-8?B?eHZTaXZ1K05PSVhwTlhJNTNKSm9TSGwwdzFIY3VhUmhNNTFDNFhOYXpjQlln?=
 =?utf-8?B?OThpU21Eb2o5Z1RvUHppV1ZBbC9pdkswdTNCMGdrYWlQZE9jSHZEcmZBSmFp?=
 =?utf-8?B?NHlya0s4K3lPTVduWmYrbVF4STF0NTJZenNUOVcrM29tMTV2NlVaTzMyT0pX?=
 =?utf-8?B?WWdtWThHTVJDOGo5bk5ONEFKejkxSnlEZW1uU0FseGVtZXZIMUxBTGVvcDNV?=
 =?utf-8?B?UW5Zdkc0SXhtdjAwZ1VZcXdqckUyT0VRK2phK3E5SDdqMWptMHZHbkdaWlhv?=
 =?utf-8?B?UXFLVkV6V3lYK2lJUEJ3Z2RuS2FOV25CY1ZleTByN0Y3OXJnOGp3UVVYd2hu?=
 =?utf-8?B?ci8wRXducTJQRWZIeGN3YkN5RXpYV0dkcDdZOUFSVUJ3RjBkblJmejdITFRl?=
 =?utf-8?B?VzE2MjVUN29zNUE4TGxnMnNkSUV4MjEwZ3pKTXFZM1VxbkllN09mNlZBSnla?=
 =?utf-8?B?U2F6ZzJmVnhLbG00SVNscEo0N0E3aDBLbzV4VHNlNUZxUVRoVUs1cnpBdnNY?=
 =?utf-8?B?U1o5UlMyK1VHWlZxYzJwaFd6NGZRL2xpNnBOeHNYdmlwUCtJck9WWG11ZVhx?=
 =?utf-8?B?RFdpQysvczJYMitVbDVEWFhFUW5BNExyTGdiMnNXMmhHVnBLV3BqU3I2cXV5?=
 =?utf-8?B?cTRWWjNTb2JxWWFkWXZVTldFbGM5VWRKUUp1cTg0N3VRRm1FODV0dks1bm1B?=
 =?utf-8?B?UU9VRGg2c1UrZVJVUnNxVWNIbStLOFNmMjNyWHhVcDdkMkpnWGJNekhvL25r?=
 =?utf-8?B?dnY2UGVYbzFxcVNXNDNnMkJMWnhvUmsxY0ozOGpIM2RQQVd4TWF3TzFBMWVJ?=
 =?utf-8?B?Zi81OVoyNENlaTFCQTM3aGJFeERTWllXTjkrKzhMaWR4YXczV3gzbUJmdnJN?=
 =?utf-8?B?MldrNmxlQ1RDNjZuRDNncGhHczRWQzEvb1EwUXFuRDdYWUFrUjhGaTl1czQ3?=
 =?utf-8?B?d0ZoNXRtQWNJYWxocjZob1lHOUR3R3hlQ0FKUUtTanh4YlVhTlhtQ0ZjQmMz?=
 =?utf-8?B?OGlkL0ZKVG5qa1BGc2NNdDI1NWdFWWZOdVdaa0hZSVNHMEJqZ3ZrK00rU0FY?=
 =?utf-8?B?NGNoV3JPSEtRTGxJYVVqK3lrSHQvcU4zUGkyN3pOcW50N1pMZjdtZHRSMzhK?=
 =?utf-8?B?cnU5ZDBGZEJUQkg5cHQwRjVUcDNzbTJiUXJ4S2JQZjVDNTVIRUU2eTlrZTVl?=
 =?utf-8?B?WTRTRVZiWmdFUVpQVUxNRlNEZ053UVdwZS9QZDM5ZEZqK3Q4NXZqTFoxaTBK?=
 =?utf-8?Q?1e7k1K1SePt8gHHhJtOH5NMAq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e14431b-870d-4e93-fba1-08ddafbfa4c2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 05:59:39.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIKgmWtVSeleTBGr0zKLTzUXQ0oJfzEiYY7OvqnykMga3HjFwHtmvrXey1ukPtfH0mxOXVThnzKetlrSimoyHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910



On 6/19/2025 9:33 PM, Matthew Wilcox wrote:
> On Wed, Jun 18, 2025 at 11:29:31AM +0000, Shivank Garg wrote:
>> From: Shivansh Dhiman <shivansh.dhiman@amd.com>
>>
>> Add NUMA mempolicy support to the filemap allocation path by introducing
>> new APIs that take a mempolicy argument:
>> - filemap_grab_folio_mpol()
>> - filemap_alloc_folio_mpol()
>> - __filemap_get_folio_mpol()
> 
> You don't use these APIs in this series, so I can't evaludate whether
> any of my suggestiosn for improving this patch would actually work.
> NACK.  Introduce the APIs *with a user*.  Come on, this isn't a new
> requirement.

Hi willy,

Thank you for the feedback.

filemap_grab_folio_mpol() is used in [Patch 6/7] in kvm_gmem_prepare_folio().

filemap_alloc_folio_mpol() and __filemap_get_folio_mpol()) are internally used
to support the filemap_grab_folio_mpol().

Thanks,
Shivank


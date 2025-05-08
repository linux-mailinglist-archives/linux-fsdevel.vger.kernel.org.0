Return-Path: <linux-fsdevel+bounces-48499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE8CAB036B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 21:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3077C1C2675E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3BF289358;
	Thu,  8 May 2025 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfKscLRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834104B1E7A
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731628; cv=fail; b=eqCBD8zPlvHhhCL4o+RN0lX/+D6u2Bl0e8KzICRPCinbF3JZr+YY7CZfT48ARAnF+6EMYE5KTyWiZBgIDTfy889Bg+CfF3ipYB70lRkWn/zKxZsxAuS0QpndQKdI1aIKiDe9/9Cd6aVFEzIlXXW0sBOsmwtRbOVsb6Q6GhRQg0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731628; c=relaxed/simple;
	bh=hZ/tOCVmBnjM2HvbNblUSn400UPlbaoUcFNbZUcH1TU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GgOmBqoxpLNb8gMDwDNVsOeDBDCA1SHiBKuUjhZ8/CDxRaZpN8R+tQMNnHkr+TkODuvhVgdYye8pg+siVO2aj4GOu7adUBGtwBxhGgf+NhvhTDZt5CrlnCQRPE5fx2yz50J1pxeUptmXhwN7Vl74XRWLiwbGXUf5eWqZ1SM5zLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfKscLRR; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ex9/915E+9iW4WADoIrzpn6L0/cIwWsQh+ZhEGf6ELsQBxdYhS8j2M7JtmApnBgkjovZj1PieZ2M2vaNTb85Ajy2qOZeBI6LMiRiBdrCAd9+nI+SnR3x6CiKdjYSu+FREfAl2yEX8/lOEgtfRVMrs10dqxxU0c0f9L1VPAL5484BIbniqTfakLwW0yJajEjUiXT6HGh2h474c7k+oC2scO0PKmD+6bxgPmKELDzfVmBEESixsnot8uo29aMsKm17dab96TXtxuWVzyYSIVw9Df3jNNL0hDCDtvDC+mlhXFWJcfJ495eXpvtqMh1uiQVsZ8ySY7gEHEoWMhqq+dgKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwBD2/cUcVQzOiPGvKqBqYpVKUp2ADhV3EiVN8VXZAE=;
 b=WobVnbNMfFvxK0RVkvXOBEBbHnUYFPC4iurZQLVy53kgh8gC8nTv+1h20b8/XMwL3ZYSSNg1xqsF+QueizRNYqOxhNVEiGngV4sXLmC7DwPP/WquUe2UJ4sXPtBvTacLHbSar+jtTKpWwrnGB2l4Na0vsQbpbE7Di4pygstWk+g7okXgS73AFAbNMWv8jJs1aTS9tnlhHiia6hsvf6jPKRu2DOZvbRF8NvVtt/snJyshQxR4zUd7sX7aLXfO0yiCbUfKMOOG0Bk04qFjB6jPhB7oxTqBlZJXnlbNy7Mx77YG/qpHEccFt2LkpXGOuP8oxGmIUS5RnfmMWlc92Mc9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwBD2/cUcVQzOiPGvKqBqYpVKUp2ADhV3EiVN8VXZAE=;
 b=kfKscLRR8Sb0sM+CSW7cclFDISYIGIoe8zbNvsqVAf8FdZ10EY7FO5FGZW6rhyQTKtYI99RLy1Rm+Vffsz5PgcnHXiNx7nd5IP1sQahMxEIqlHCd9RSnr9j/tRwlv8kfwygKf0F1Bo5uUBOBh2sH+KuJAiP5VnrnAqfYiSJiy/YEYKTD4MQbS8fvujKahcxwnO/MomjYJ4lkbzSC0bPcbPZzXMSNHdITPFiV8Sa0UhCKjnZhVnXC5F0cPCqdBK3N3I2wLdKXWd+3Z2lmYZyOKG2LoTto1k5/6aC0VGvPgtTiMFzg+Z4BmWEz8lGAZSZzJePrmIVskK/e+V2Bxg9H+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 19:13:43 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 19:13:43 +0000
Message-ID: <24b2e672-89a1-48a1-840d-6fd3e6468507@nvidia.com>
Date: Thu, 8 May 2025 12:13:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] selftests/fs/mount-notify: build with tools include
 dir
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-4-amir73il@gmail.com>
 <685d5423-5b6a-4a11-9bef-50224e479f44@nvidia.com>
 <CAOQ4uxgrpidT0CnuUpnqFp058sLPKMhXQDXiP6u7icRfDt58Gw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAOQ4uxgrpidT0CnuUpnqFp058sLPKMhXQDXiP6u7icRfDt58Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:510:23d::19) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: a5954d04-2c09-4e47-808e-08dd8e6472a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXRlL3hkb2RjdGUyNGxFNUcvZk5FTkkrWXVqQmR4SUw0TjdnczVEOFFoU0hl?=
 =?utf-8?B?UEh1ZDlTQmxpcEhHS0g2V3pmL3RCQkxWQ2VjNDlzbDFDempvTmtYc2dXNmI2?=
 =?utf-8?B?NUlQekt1MmVFdVpBbW1qZ3FvQ2NJa1R3N0VPYlB5Tk9lWGorMEZFbjltU1dy?=
 =?utf-8?B?VzdiS281YU84NHd6UkRYMjVkSkpZckc3TUxGSzhWZTZacVZTcXBFQXFCT1BM?=
 =?utf-8?B?WlNVWkUwZENnQjZ1c1doWWM1Q1dxL0ZZWjlPQ3pCZ2hzL2FHOUJwZ2oyejl0?=
 =?utf-8?B?eHkvUXpOcWxOZWFLZ1dHZkQ4c08wdGcyQThPUHl1SlJ3bmRVblFBc0dFOU8w?=
 =?utf-8?B?NW44Qm9mVmdRNVlRTkNVajRHc0Y5eFcrdnlUenBvZUU1WG4yVTJYeG5QSXZX?=
 =?utf-8?B?MFBoYURmQzI2VHFKb09hd1l4akRHZWlnMUVVWk5ubUJXQmwvRDU2TmV0OVpE?=
 =?utf-8?B?STgrN3BRMXlpbjFWQlU1dm0zVlgyQXBwSUJMMWUwWW1QSDFTNVJRU0pKSUVu?=
 =?utf-8?B?MFU0eTdmbHhaT3Z3Y3JYdWI2ZTQvT21mb1o0VmZtb2E3ZE8zeUNjWElIeE8w?=
 =?utf-8?B?ZndLdTdYYW0wam9DcDNQcGxhVDZyUUtsNWpCbnozRDZzdmNyWnErWkkreE9r?=
 =?utf-8?B?aFhoZlpqWTBHUlFLaTkyUWI4YUJUQkxyTDdxQ1pGNEdhZzg1dTBZR0s2YXRl?=
 =?utf-8?B?eXI4Qk9KSVNjaG94QzB0VEpQZUZKT2gzYW5OSFk1UmV1Uk43aGFnRDk1ajNF?=
 =?utf-8?B?K083YVk5bzBhRVBIdzVCa0pWQ3ZMUHJMY1hEM1p1RzVUL2l1S0FxZlk1Vnpz?=
 =?utf-8?B?ZndGQWVxSUVXd0crYjlSZWdTU1FyVXdvb0xoUGUvaStUREZUQ3pDeE52SVg2?=
 =?utf-8?B?a3JCaFZ5QlVQU2FrblRtUFkwQmtwVzRTd2ZrN2FPcTFrcFIxMHJoZ2ZaS2dM?=
 =?utf-8?B?OGxFSUpoR1NvMFRzdjhrL3BEcUFmeGpLamlpQVNCaWF6N3hpZmxiVGwxakFN?=
 =?utf-8?B?dlZCemdpRTA0NnNWUU1YVDkxeHdycGVpWWlPKzFkVzJEaHdaQW1zZ2pJVEZS?=
 =?utf-8?B?cFpsSFd1a1gwWDc0QzJMbjJWTHcvd0U2RU1HaFZHeWp0WGJuMWtZems1eFRw?=
 =?utf-8?B?VEtra3FZbTFXQXl5dzgvam5IU2hHTFBsV01GMjVodmZ5cy9pS2JUSHA4MjZG?=
 =?utf-8?B?TW5IUFc0UHF0OEdNSnNjUjlJYzdLY04xZlpvQjBNRWZOeUxuR3U2dTY5WHBI?=
 =?utf-8?B?dW11MmoxK2lRSmk1NmwwYWp1VEpXQktFbzN2dXdNencyQmxQN25OY2M5dkhr?=
 =?utf-8?B?dEVnL1JrdXJHZGdwMnJDbTZTWFVPL0k2dkcvZ2NIMDdleVRCdkZ6UGt3N0tS?=
 =?utf-8?B?VXJVaEdhUUhhUG5oUWVnSDlBNUlsaHdZMENwN2JJeEM2M3JiUXhienE2Qzg0?=
 =?utf-8?B?bjVrbW5sQTFxb3VCeGpwZ09uQldPdWZ0SU5qN2ovZnlGajJQb09OSzNlTUpB?=
 =?utf-8?B?dFhJKzc2TCtPVGhMLzAyMDdwUHZqZFVkeTR5MndxbEMwZkJTTWl0eGFSVHFD?=
 =?utf-8?B?QiswY0NHaXNDc21ybG8wQXIyeTVqZlpFUnc1M29lOUFUWEk4TExabkFOQ0Yz?=
 =?utf-8?B?K3J5YTNDTDgweGtwVHZTallZR2pNdWpVZ2doc0dkYXRuSWVGNnJONStGRUFi?=
 =?utf-8?B?bkhRWUpvZENSa2d3NGFtM2p2bCtNS0VDRGdISlNRdkh6T3VlMDBNNkNWN3pv?=
 =?utf-8?B?U1I4WFJJQlF1dzlwOXhZRTF2UDg2ekF0V3dXY3NEbUJyRGxYR0h5Y25xVlNt?=
 =?utf-8?B?REthelg2VEIzV1ZaeUV4cVhHeEt1aXVTVE1FTlIzc0pQL2FwT3VMKzd6bFNM?=
 =?utf-8?B?WnRKYUVibVdxTUI2OURWMWtZYmtuQWUyVlJVOWg4Mmd2MGtsU3lDaUExd2Jo?=
 =?utf-8?Q?1GVkmQ0MZ5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmpCUGY3eG5RcjB6Y09WamRmK0NVL05naTlyckZnRlp5aU52VVgyYTFMaGhq?=
 =?utf-8?B?WWxlWGNCaEY1SWo5QWIzRXIxajdFdTJZRWJKK3FlTjYwdWxxd3A4Qm50endZ?=
 =?utf-8?B?VmorK0g4R2lKby9tWmZ2djRldFJrTUZtMWVWbzZFVGNiSXd2QTZxbFNjY0cr?=
 =?utf-8?B?UFgrWUFwN3BUbTRKeTFWMnVmUnRNSEI0bnVJYlRSaVVjSEVMeDJGTkpOMmNh?=
 =?utf-8?B?QVRuTWdxYmtOWkp0T2V4RnorMkc5SitPdzE1K09NZWJxRzlUMi9VWHN3N0l5?=
 =?utf-8?B?MXFxSTBCc2Z4M0RocERlUzJLM2tacWdUZ0pkOXlmanZaSitSbTk0VkJrR3kv?=
 =?utf-8?B?WkdpVktidGV1dUZBdEt0Wjc4YzN2RlpXM2J5K0c4K2VkZ24rZEk3ZUd4a2R3?=
 =?utf-8?B?QUtHL0c2QjREaWt0aVZjK29kcXlUR1A2N21qbGpJNE9kMzZjeHZoZlRQOFBO?=
 =?utf-8?B?R0Y3eVBDVDRXSGhFYmVHaWVkdWdKNW9xNVFQRkgwempKUk1QcFRNZytwMFlv?=
 =?utf-8?B?MmFqNVprNTVJUisraGI0SUl1dkRsVHYyNFRkd2F3YitvdzRWN2t2UkJ1eVZ4?=
 =?utf-8?B?T2xrL1RIc2RPN0M5UG8wWnRpd3N2UnByN2dSdlBkWDdmeDF1eHZxUERsQnZk?=
 =?utf-8?B?bVdRT3RjMjJvcUhsUHE5NWh5ZGJjR2JLZnVHQTlNaEVkcG50Rng5dW0vTm91?=
 =?utf-8?B?OEl3R3dIMzZiWjBGbW1OK0FMdzRNeDlEbEVpYWNlU084L0RuUDYrRVovcThU?=
 =?utf-8?B?TWtBem9nS3VIbXJoVGtpUVBtSGRMeU5OMkhpSTh4dU4xbzBHWXpOd3ZzMUtx?=
 =?utf-8?B?MnBqcE5SMXU0RTN1V2t6THE4ZmpQQktqdURYbXQvS2J5dTN0Mnl5WEtuYVVP?=
 =?utf-8?B?MDJaZ1NlcHhqWUhNc0xLVXBEM2YxQmcwb21MVU5VS3dXSjRzdm5xeHpqazZL?=
 =?utf-8?B?YTcrdUhPc1NvaXZObm01YkxvdHZpTnBYelZ2RjRBdENHaHk4YktUOS9DaStl?=
 =?utf-8?B?bUJGRE9qZkRCSVI4b3d5TldNd0pvaFlYWWptb0VPSzZzM3NjQ3dGY0xFeXBD?=
 =?utf-8?B?STZyKzI3UEZUT2dpSXgzVzVZMkg5NDB4Q0xqa21mSloxcVlOMjYvNDN6UXhh?=
 =?utf-8?B?V2wxNlBJT29md2pycEFNV2NldTMyUnZxc2hNbTB1NU9oUmVqc2VaZzdBcm9s?=
 =?utf-8?B?VDN1a1ZRRytMaURmOEUrYzhXR3Boajh6ZnFWU2tDWittcWI4cGcvb3o5RkZ1?=
 =?utf-8?B?cTZPUkN6SzA4aWhqWTJZMUkrWVEyYTZWYzIwenpSeVpyUlV1RDVkOU9uSFI4?=
 =?utf-8?B?M3hOMWNMUWFaUmx1MXFITzVGOFhyMmpmK3hjTTJMNTI1WkZ0WC92Q2Vmcit0?=
 =?utf-8?B?VjhpTGdqR3d6U2w4THJXSWw3Q0REUkdkUzZYanUxWUVPYXQ2RmpTbldzV0py?=
 =?utf-8?B?OVVyRjBVRkcrbmJMUlFvNlltOEY1dVR6TEZrT045NU9raFlYenJzWTZyZnZT?=
 =?utf-8?B?cDlVekJFMmJOT2RaN21ZSzBYbTJqRXFGNFljK3F5aVgrMHZjb3dVVlVTKzdF?=
 =?utf-8?B?QU5TWGVDWXRrZnVva3hob3NDaHhSL3ArdDB3N0VuZ1haYlk4cmJVUlBPZGVO?=
 =?utf-8?B?WEt4eThOM0NVYVNOVVpwNzVyaWsrdWZZZVlDZ1BtMzE1aW41SDVrdUpIbDlj?=
 =?utf-8?B?R1U3UUFuNFl6bTVZeWdzY3VCaGttYjFlUDJLZzhSdHhMK2RaQjRsK05Kc1Zl?=
 =?utf-8?B?YXZkUlUxalBkeGtjODZjV0lLZ1U4YWVSOEFGdFpzZklKUWgyY0R3bFRzNG5S?=
 =?utf-8?B?MHEvTGNrTlVtZjFSUEEzS3VxaHplNmhPOU1QU2d0NG9KMTNlL2twYzU5eUhq?=
 =?utf-8?B?MUp0NVp5elBVczZYU3V4RVpVbk40SWI1UUpVd1UyYVd1Z1NaVnJuc2tVdm1C?=
 =?utf-8?B?MG0vek9xby80cElVbWZ0TEtDaEFaKzBDZ0huSmdra3gzb0hhS1R4TkNUL2d3?=
 =?utf-8?B?Q05xd01QbGNEblUxRkNscms1VXJ6cXMvSWhsaEFyWkNWV1B3YXRjS0Q3NHJs?=
 =?utf-8?B?T2NNMDNQTVJhY1JlZFd1RmppSDZ5cWE0TjEybms3eVRxVEVaNGczM0Eva2x2?=
 =?utf-8?Q?ZzJDwYvmvkhYuVhT8IloOA5MW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5954d04-2c09-4e47-808e-08dd8e6472a7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:13:43.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLQsBXXVfQc42Dde85sL+Ycxl1Qi92AS6YzQOLkTuUb2G/ahS7lUV0TpHT+Vu2SmRBYXxpAxDHwGAxrmETZXCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825

On 5/8/25 4:53 AM, Amir Goldstein wrote:
> On Thu, May 8, 2025 at 9:38 AM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 5/7/25 1:43 PM, Amir Goldstein wrote:
...
>> Are you sure that you're including your newly added fanotify.h? Because
>> it looks to me like you might be including your local installed version,
>> instead. I don't see how it can include
>>
>>      tools/include/uapi/linux/fanotify.h
>>
>> ...with the above invocation.
>>
> 
> Yes, it works.
> 
> My local installed linux/fanotify.h does not include FAN_MARK_MNTNS
> it is only available in my source and tools include dirs.
> 
> Does the fact that sys/fanotify.h includes linux/fanotify.h explains what
> didn't make sense to you?
> 

aha yes, that solves the mystery for me.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard



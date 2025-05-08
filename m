Return-Path: <linux-fsdevel+bounces-48454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3EAAF4EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 09:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AA04E138C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500A221703;
	Thu,  8 May 2025 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e5hPIQY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E4C221576
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746690223; cv=fail; b=MZkWhPFUzO62FYbfphWnx9LBJQKzHDgF8Vk3VScFEWeZNuTpOiQmgLY2tnRBphxT+eQMq3U3hsGujMM6nqhpDlskQoR2JV+Ij8ustQE2vTd2EnjGFSAYr+sihKRiGbX0yRunbfbvpGzBRuHosSpoBBwOkeC3F3wwDCOiYuKtlEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746690223; c=relaxed/simple;
	bh=jAm3RlkluJT/ZPDM7oziLUK6kjgN5U3mbpj8xp7eY08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8BRoItpby+c9ucuWZLGSDQGHSLzi3ZiRZjSjwe95FrFPFh66QRKqWEeSeZb9DHIb6NfmuTrGlWi9I64TuRkhTi/PUpCP12DbTbLlpWP490VI5hqMU8GlzIuAyUAtbuJDWqQrKshed9vIg4bAxM7OuKzjKyHDudI2l8+4Jc6KDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e5hPIQY/; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtrfejVwnU8viDgU6OAKodwV6k7kj67g1XYLfrQ6+qeTTQ7Fp1DOs1Yt6Ri/BfAKZND9BXd1Kr+6A4QilJ1pyEiPHA9o9VX3kfDrfN6vKeDQ631qUai3ESVf8LNxKQ/Im865MM+53FQNEQwAF29ifeVEYvzJau58vtKTK0/MsifJdqEtkKN+k7j4b/ccRMwHzamx2JYWghJhv8IRGqWoxCWBgM6yk41ElGR1QKPafRqhg0KIMpRDYxRYEx3RwnQZIDvJaxIKKUyXygh/KXUZkADeJ9eHnw4oo3p8S5kCgZ3MaBlL0AAA8kWbRrEqBLrPcuubQZVyMiQ7xFAKk6TcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEsYx5i2sgGAIq/7sCYo6sYRMe6ambTmhx/ZuGVL7Qs=;
 b=iu7iXdFFjVziuUwr0T9egy1yvmrcC9eCy1yRLwlIwkc0gsamFrpIITeHNkg+D1RE3vbRc2bBurST2Ci3H8wyTx89NNoo5l0Ui/z2EqbQvC1eWkhf1+gnSjpDMoehyvPTgLYIGkIq7u5o4j/xtaySgLhPfQFhxWya7RqdHQDm1UpRXOcLcUEnPmUL/XJGHxAWEOQtxyLB9cY4N+DddimtiFCc8q1dwaaCDMCHXD5PDoItJhyr56Y0keQ9IzGUBWl4ilF6tIWeD4Eefu36GSDGFhsFLvyAKWWv/uaFFsy44I5svLYNmgZ4JfQPepqDeU5je0zNq9Yzz4pDDlRVRsnIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEsYx5i2sgGAIq/7sCYo6sYRMe6ambTmhx/ZuGVL7Qs=;
 b=e5hPIQY/beSAKJTSGOXFlZDpC29lKLXoiIDrip+YcAv9J+Q5uGUQSe4dNaxjpS2bVhOz+E50sSR4ktQVVEjugMJ/Qrr8B/Ogd3EcgFcl+O1dxaK3/UaiVUKMgZpZksKpvaAA7WPeKg2zRBwzS08gEOskIJ9Yih1sA9KiYnfXWhIybzGTkB4q8+cMCFSWveStZIlrYB4FCPop1YNoWDdo7wVhHEIrZ0ZM4CYawasJsp9WcZf5WUGout8FNap6OXgSGI6jvMrnvTitauuSea5Ks1QgQpfdnHxV32U0D6g0mUSUjMg5iPxVwOI56dcq9s8Hor9P1a8ZsVYSlI1p0gWZJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 8 May
 2025 07:43:38 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 07:43:38 +0000
Message-ID: <3d19e405-314d-4a8f-9e89-e62b071c3778@nvidia.com>
Date: Thu, 8 May 2025 00:43:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] selftests/filesystems: create get_unique_mnt_id()
 helper
To: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org
References: <20250507204302.460913-1-amir73il@gmail.com>
 <20250507204302.460913-5-amir73il@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250507204302.460913-5-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f30ab7-1ca0-429f-5bac-08dd8e040b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0FEbDI5TmNDS2NtWGJyYmZOR1hHcXFZM3Vtck92Q0h3dEQxWmFBSEdDVWJl?=
 =?utf-8?B?MzVzbFlReG1lbFpyalFwaHIvOEpRK1FIQnBwS2NuM1FSUVdrVlJzVUhNa0Zs?=
 =?utf-8?B?QTYxdGRncmVLb3ZadGN1RVZ3TWM4UWdNSWtkZ1huVllXMCt0QjRySWhVTk9W?=
 =?utf-8?B?a285Vlp6cm1PMzdLaXJPd1dMbytXRUx3MTVyUUFnd055YmhMSFMzYlY1YlBo?=
 =?utf-8?B?dVAxWkVTUytDMHQxUVdlQU5LVUM2UitzWTN5WlJNWUdSSFU1Rmo3eGtBVGRr?=
 =?utf-8?B?QWNodlRuUnVFVEQ1aWF1cnlJS3JVV2I3VFV0L2VZTEIwb3BrUnZyeVdZeTA1?=
 =?utf-8?B?U1cvYTdYbWR2a0FvSFZ1Y1A2QzdJbVdnN0Y2eWZlRWhhcWtVZDc3WkJkUXVB?=
 =?utf-8?B?L0h1UUcweXROUHRld0FWQ053VXNXSkFZRmI5R21FQWhPZkdMMEs0eW8wVEE1?=
 =?utf-8?B?YW02Ukt4Q1d2NE82djQyOGk5NklET2NwcFZrUTJpRmZybENXVjhFNnZPenNt?=
 =?utf-8?B?L0xhc2t4RjF3cWM1dFdxNjlQUDM2M1cvMUQxZ3BkbHBlTTlIMGZZeTdMaExL?=
 =?utf-8?B?S2R0ZkFKOWNiMkJnNHM2Z0syREFZSlltU2c5dnVhVDQ0dE1UbzF6M3NBQm5j?=
 =?utf-8?B?OVlzSjVKM2doektqc1NTL2hpQjh2eDJ3TC8wRmpucXVvZFRQajlyUExPck1a?=
 =?utf-8?B?aGRGME5DS0syYXpzZHpSaTdxaml1ekQ0bnU2T1gyRG41SEZxOXFERU9GWkhr?=
 =?utf-8?B?RHV4MW1WZTNycndtMzNaUVhiTVhtVmR0cjRmbFIvcUYvNmsrbSs1UndoWW9i?=
 =?utf-8?B?SlRqeDNGa2wzVTB4d0xVRzdxazJTbU5pd2MvWVYwWjY0eXVWRGpoUGYzYmg2?=
 =?utf-8?B?M2g4VUVaSUx0Rk4rRTJneTFqdWQyZ1pxa0U0V2kwUnBNZ1hwWHF4RlRuY0dV?=
 =?utf-8?B?TW9HSWxIaEpObjBQQ0dNZkJ6clVTZ1FjeThieVE3ZmpPMG5LTHNJU3ptT0VZ?=
 =?utf-8?B?T2JFMmpDSW90VHBQK1NoQ1VKUitSS1M4cHNUR29nSDhxM0hUejl6MW5zRnlz?=
 =?utf-8?B?YURvWGNtWklGbTBwSzdMZlF1ekkzYnpKdjQxd3lRRmNFKzVXbW5ONFNOYlVs?=
 =?utf-8?B?cVFVRFBDWWFPc01TbVFJb052SGlSd3FZUGJrSzRKUGxZOGFFVkF1UGZUQVdZ?=
 =?utf-8?B?cnpMNHRxMzRheU1ORXlTT2hHU20wSWs3c0tsbTVrTTFZYmJ3SDJLYTk4UWVF?=
 =?utf-8?B?Z1poRGtIZE1qMXdnZzBDUVkrS0JRNWtYYTZKZE5RbW1NclVGeUNmVGpEcEQz?=
 =?utf-8?B?eFY1UExORzBXNlFINHRBZElnRDVHN1hHY2lXck5xM0xDM2ZvbkdtYnBaM1l0?=
 =?utf-8?B?dk15bXdyZmlvajdPOG1Rc2QrSVp6S1lkNTNtaVNkNFJTakZ0WUFEVUVrbHhR?=
 =?utf-8?B?SjAya09NVDkxaEtPNk9TRDIyQ1lEeE8zVzhCZnNKZnppeFdQek5BOHFtK2Fx?=
 =?utf-8?B?TDQwMGlUN2hxMzVZUGRhTnhCQnVHdkxnSUV2VEFuTjMyQ0pnbzQ0VHJIbEFF?=
 =?utf-8?B?K2QvRUpjcXJJK1NXakFRSDRQZUlmQTk3Rm5Qc1drS2FwMnd1MStMbDdrTFBp?=
 =?utf-8?B?S2FLTXpvQ3c5U0dVd1hJOGVoRkFDaUExRElRV3hDTDRqT2p4a0ZkMGFLaWFq?=
 =?utf-8?B?NDcwL1VPeXY2T2VxKzlCZlFLWHdXWWl3d3czVDFuT1g2Ykh6VFpFRDAwbFc3?=
 =?utf-8?B?TGo1Q2xRV0p3eTVvWjFLWmxuNFdYSnNvVVFUOHJTOHA3SDMrMmY3U2tOWWFM?=
 =?utf-8?B?Rk5CS3BuRjhMUkZpU1RnMHFoMGRlNGl4dHdjMEdoZXVoK3RGekUvUzRTQ0pv?=
 =?utf-8?B?dktsWWQwUHdyN05zRXNCdmJkVytjeDB1ZFhVUjZQSXZubzJKamNzRGdaUFhC?=
 =?utf-8?Q?pYajuKpo/wQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3IzTkF5NzBjWk5HU1ROdGQxWWkxSUljblc3cU5NcnVXcXE1QjFMOCtNbkdq?=
 =?utf-8?B?ZXp1anprTGtDOFEwcFFSVWRqenlubHNKdVlmMEhrcTgwQzE4dWYwQWJiWm5q?=
 =?utf-8?B?QWUyL2lTZmJDeVVRdjRzeVJ2MDBLci80M0Q4Qml6angreWhjSGt1NVY2SkZG?=
 =?utf-8?B?Q2xHUzhyN0ZpRVExckR6cUs2RnpPaUdyQTZOaEhnazhtOEZSMFEvOUs2ckI2?=
 =?utf-8?B?LzJrN0oyNDdUVVNuT0dTejEyUzQ0dDVZdHlTSWNOWmxMOVordlRkaW1SdGQr?=
 =?utf-8?B?T0dlQ3hNZ29vZU5HNnhvVDhjZEhMNWlQSUxiNVZUTGk5b2xKZFhSWFplQWsv?=
 =?utf-8?B?RUhnTVZmTTFZenZIU0ZMNzd3VlBSeUVZOW1tTjEyRVNkYzZrVTZqQW14TEVp?=
 =?utf-8?B?VEFXUVVFdEt4RW9kUDM0UlJhaTg0cmZPSXRHL2VUNVZFOXh1dWxNM1EwYjB1?=
 =?utf-8?B?MXVhT2YxVFpla1oyNkFVZmd1cm5rVlFFTEgyZGJQWGtkTnBlZnhKbVp2V1Jn?=
 =?utf-8?B?WGE5T2xpYVplQXdzUW5Db3pnR2xYYy9CL2g0dE1xRXRCRTNFbEtreC9YUzBs?=
 =?utf-8?B?eUIyUld5UitYREZUS0pkVXpOaGVHMjdlNDc1ZDBWeGVyUDU2RERIek5TdnJy?=
 =?utf-8?B?dDRMR09PQ20yc1QrK3FSVW9sNThTVm1DN1ZjRHNoZWkzZlkyZncvcTlBeW5Q?=
 =?utf-8?B?WDg4UlpheUlDejF4bXFDT08ySnFtaE4xcnpNaHRJa2piY0pBbXBzUTFDRHJl?=
 =?utf-8?B?aVUyL21vd2Q3NldqTTA3RksrNHg4SURtbWQ4TUFYRHNBbExIdWlOaDNXRGgy?=
 =?utf-8?B?RUxQQU5qT0RLbVZuOG5Da04vZGcvdjQ1a1lXN1p5L0dDS3oySzREYVhZS2tn?=
 =?utf-8?B?bndRNzc3cHBxaFYxUnZ3cnp3R3M1NlJmdEZ6cXR6eE9SNmh0QlVGR3FIMUJX?=
 =?utf-8?B?UHVNT0NqVnFVR1VTc2dDVFIyNnJwTzczNG1WM0NjVzlLcTMrVlhyMjBtUWF2?=
 =?utf-8?B?clFOOUJSYW1aZjVEdGtZaVU4TmlGOXViZTVidy90UHpac2NnQmxsVlVJd0or?=
 =?utf-8?B?S0RnbGsxSDN0VjAzOUt3M0htTHBBUDVhdGZLZFJtTXhZTUxiUjVSVjBqU09F?=
 =?utf-8?B?RDRjZjF4N1pYVXdMQnRla3hFSzhCckprc3l0SVNoVW5abVV5dlBwMitFOHpE?=
 =?utf-8?B?ZGVkVVNHbUpLamJrRm1tVkl0SmF3UG5TOEI5aDVoT0pVZXh5ei9nU1dwOWts?=
 =?utf-8?B?VXNubzNpcktCejdmVCtNQWNGbmROWEdFQ0tGODVJUEhYWlB2MEV1YmIyaWxy?=
 =?utf-8?B?VkpzWjhrRk1BUUs5YlVJQTJwc0FJbmQ5UW93RmdlQ1Z1MCs5V2FhbE53aFg2?=
 =?utf-8?B?dWlNaVYzSUIvUTRjZ1BNNkJUbEMycis2UktFMGFPRnNYVFdZTEpZUEJwWTdw?=
 =?utf-8?B?cGM3YkJ4T2VBMlpFR1NKd28vZTFwWjAvcmF6NFZyYUxtMVlVL1oxeTB1MTFp?=
 =?utf-8?B?U0Z6MUlPUlFvT2pQU29oaTl1Q0xHUWk0eFVmK2gycVVPcHkxK1dyR3p2eUx1?=
 =?utf-8?B?WS9jSXVxd2MzekszZDh5VGdFVWZlOXJBa051ZUprTHQ2VmFWRFdlYlliV2ZE?=
 =?utf-8?B?cDlUaTJzdHVSUm14bHdhZWx2OUUxb0FLWHVJSGRaQVc3dWVlNGE1VWV0MEtJ?=
 =?utf-8?B?cnRySS9vUjVhbG8yQjFFU2RtYW5LWXlHODV3bFdwOTRuMnpneVJ6VEVORnU2?=
 =?utf-8?B?eHk0VGZTSE9DK3lNODlobkpIL281QjlaZUxYbEN4ZzdpaU5ZVUNBc2ZBSXBG?=
 =?utf-8?B?TW1yUkRhU1JaZjhMdWVaTHkrN0J3Zms2YVpUM2h4VURSaklDVk80clFwUHo3?=
 =?utf-8?B?cUgvMHY1VWNtbE85KzZ6RnRXUStCSVcwSE8vVi9KQnYrMjJDaUFNK0k1blZS?=
 =?utf-8?B?MW5NdGJBU3Z6MGRrWFl4SkZua2RIYnJjakVtOFR1YWN4Q0xtU0I4RVhTUVdo?=
 =?utf-8?B?N1AyclV1ZmpFakFER0NEU25EYVd6L2xUa3EwRXM0SnI0UUpVR1Vjd2M4clpm?=
 =?utf-8?B?QTE5Vjl1eEozVGhvSTF3cXZLLzRTVjRmcU0vMk9rOE45YjIxbUZpUnFleWJQ?=
 =?utf-8?B?dEdPdEVlckd4MVJXZGVtWjRSUy9ucndJMG0zZVlDNmxGbmFqNjEzRnUvL3NZ?=
 =?utf-8?Q?5Q0TMf2sKj4McHHLQAMCpHs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f30ab7-1ca0-429f-5bac-08dd8e040b91
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:43:38.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbGL2tWOe+2sWQum/9Jwt5bfjWn0/ridcvaS13corDNqAQdPwY0LrzWnF5jR2nLacAvSfnfP8SyZbt94tvbAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541

On 5/7/25 1:43 PM, Amir Goldstein wrote:
> Add helper to utils and use it in mount-notify and statmount tests.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   .../filesystems/mount-notify/Makefile         |  3 ++
>   .../mount-notify/mount-notify_test.c          | 13 ++-------
>   .../selftests/filesystems/statmount/Makefile  |  3 ++
>   .../filesystems/statmount/statmount_test_ns.c | 28 +++----------------
>   tools/testing/selftests/filesystems/utils.c   | 20 +++++++++++++
>   tools/testing/selftests/filesystems/utils.h   |  2 ++
>   6 files changed, 34 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/mount-notify/Makefile
> index 41ebfe558a0a..55a2e5399e8a 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/Makefile
> +++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
> @@ -1,7 +1,10 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +LDLIBS += -lcap

This addition of -lcap goes completely unmentioned in the commit log.
I'm guessing you are fixing things up to build, so this definitely
deserves an explanation there.

>   
>   TEST_GEN_PROGS := mount-notify_test
>   
>   include ../../lib.mk
> +
> +$(OUTPUT)/mount-notify_test: ../utils.c
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> index 4f0f325379b5..63ce708d93ed 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -13,6 +13,7 @@
>   
>   #include "../../kselftest_harness.h"
>   #include "../statmount/statmount.h"
> +#include "../utils.h"
>   
>   // Needed for linux/fanotify.h
>   #ifndef __kernel_fsid_t
> @@ -23,16 +24,6 @@ typedef struct {
>   
>   #include <sys/fanotify.h>
>   
> -static uint64_t get_mnt_id(struct __test_metadata *const _metadata,
> -			   const char *path)
> -{
> -	struct statx sx;
> -
> -	ASSERT_EQ(statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx), 0);
> -	ASSERT_TRUE(!!(sx.stx_mask & STATX_MNT_ID_UNIQUE));
> -	return sx.stx_mnt_id;
> -}
> -
>   static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
>   
>   static const int mark_cmds[] = {
> @@ -81,7 +72,7 @@ FIXTURE_SETUP(fanotify)
>   
>   	ASSERT_EQ(mkdir("b", 0700), 0);
>   
> -	self->root_id = get_mnt_id(_metadata, "/");
> +	self->root_id = get_unique_mnt_id("/");
>   	ASSERT_NE(self->root_id, 0);
>   
>   	for (i = 0; i < NUM_FAN_FDS; i++) {
> diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
> index 19adebfc2620..8e354fe99b44 100644
> --- a/tools/testing/selftests/filesystems/statmount/Makefile
> +++ b/tools/testing/selftests/filesystems/statmount/Makefile
> @@ -1,7 +1,10 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
>   CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +LDLIBS += -lcap

And here.

>   
>   TEST_GEN_PROGS := statmount_test statmount_test_ns listmount_test
>   
>   include ../../lib.mk
> +
> +$(OUTPUT)/statmount_test_ns: ../utils.c

This is surprising: a new Makefile target, without removing an old one.
And it's still listed in TEST_GEN_PROGS...

Why did you feel the need to add this target?

thanks,
-- 
John Hubbard

> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> index 70cb0c8b21cf..375a52101d08 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
> @@ -14,6 +14,7 @@
>   #include <linux/stat.h>
>   
>   #include "statmount.h"
> +#include "../utils.h"
>   #include "../../kselftest.h"
>   
>   #define NSID_PASS 0
> @@ -78,27 +79,6 @@ static int get_mnt_ns_id(const char *mnt_ns, uint64_t *mnt_ns_id)
>   	return NSID_PASS;
>   }
>   
> -static int get_mnt_id(const char *path, uint64_t *mnt_id)
> -{
> -	struct statx sx;
> -	int ret;
> -
> -	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
> -	if (ret == -1) {
> -		ksft_print_msg("retrieving unique mount ID for %s: %s\n", path,
> -			       strerror(errno));
> -		return NSID_ERROR;
> -	}
> -
> -	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE)) {
> -		ksft_print_msg("no unique mount ID available for %s\n", path);
> -		return NSID_ERROR;
> -	}
> -
> -	*mnt_id = sx.stx_mnt_id;
> -	return NSID_PASS;
> -}
> -
>   static int write_file(const char *path, const char *val)
>   {
>   	int fd = open(path, O_WRONLY);
> @@ -174,9 +154,9 @@ static int _test_statmount_mnt_ns_id(void)
>   	if (ret != NSID_PASS)
>   		return ret;
>   
> -	ret = get_mnt_id("/", &root_id);
> -	if (ret != NSID_PASS)
> -		return ret;
> +	root_id = get_unique_mnt_id("/");
> +	if (!root_id)
> +		return NSID_ERROR;
>   
>   	ret = statmount(root_id, 0, STATMOUNT_MNT_NS_ID, &sm, sizeof(sm), 0);
>   	if (ret == -1) {
> diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
> index e553c89c5b19..9b5419e6f28d 100644
> --- a/tools/testing/selftests/filesystems/utils.c
> +++ b/tools/testing/selftests/filesystems/utils.c
> @@ -499,3 +499,23 @@ int cap_down(cap_value_t down)
>   	cap_free(caps);
>   	return fret;
>   }
> +
> +uint64_t get_unique_mnt_id(const char *path)
> +{
> +	struct statx sx;
> +	int ret;
> +
> +	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
> +	if (ret == -1) {
> +		syserror("retrieving unique mount ID for %s: %s\n", path,
> +			 strerror(errno));
> +		return 0;
> +	}
> +
> +	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE)) {
> +		syserror("no unique mount ID available for %s\n", path);
> +		return 0;
> +	}
> +
> +	return sx.stx_mnt_id;
> +}
> diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
> index 7f1df2a3e94c..d9cf145b321a 100644
> --- a/tools/testing/selftests/filesystems/utils.h
> +++ b/tools/testing/selftests/filesystems/utils.h
> @@ -42,4 +42,6 @@ static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
>   	return true;
>   }
>   
> +extern uint64_t get_unique_mnt_id(const char *path);
> +
>   #endif /* __IDMAP_UTILS_H */





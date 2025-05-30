Return-Path: <linux-fsdevel+bounces-50151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893DAC8969
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE51416B815
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179E212B3A;
	Fri, 30 May 2025 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OHj5DcMh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFF62AE6F;
	Fri, 30 May 2025 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591449; cv=fail; b=fcGFbv8W8rU8jwQc8PQv34bvLWhSFLOQc4jdBrc7SyigP/AoAG5eNKhzZc8xn7SiTq66Dy0NGsJXoJ/8XONu9divllDnYS++6EIT4HTtrZoz2HoCWPG74+0EzV/SrIXBKAPfg9UyDuyq7ezONuG9DEkpHDdX3MyQn4NT3fL4+BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591449; c=relaxed/simple;
	bh=ErcfisMGyspcZx5geFYqaeh8d70+JBJcTOwq2reAJqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mh2p7WkV324jtUaTIyfsLSzXOvUHLyA0ZSzd98h3HQQ3CqlJ7dr7MAQxAsaQGv8sJ4sExQ73FpsRFXCrwgt9cczjmsnVTm4gJTf7TOju/Dt7t82/9akEekrSfSrGDm+8CDNeVMdf24JDHciIet9lyBHtfxnE5F0FqgEG2WZYTso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OHj5DcMh; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNyd8dgKiSAnujKl8aE80BAl4HqO36cypvOlL8JbKJ637o9GeFnLpU1rEoysCflLwpfVBywIHmE6KJRH7ycVtDQoY9UF1R4abWSYv3m/WFHk1yvePwVq/O3E3RSGMcdXX/Usa0BsDisU7ndGEeyJ2Yy+h7BLaB5ufAsz5onfGAJ2rrRzz851Xq0ZgJva3PArXOD7BLHRpdW+5Ilb/O1ZRIOIDdtDTH4eoPnOyEs8KwsqbBXsj+eZLqh/SaCxpcdRXTAIz7kwL5QlI+TwPqYEQKJGkwzbTaIF/ZwYEjuW/0FD8IiXuflGqvL2w8dM0Uizn9xi60IEOwFHOAe0S18lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBxCyEtGefEvMUlYiN381Qq76phmheQ++jelHwJnVFI=;
 b=OGKq/enXuh8w9YGX3vf6ro0+9F3ivUWQJrtGmu4qiM7Cawa3s3xk0KLkJdxxkeOhjC3gWpk3O+tbWaNue+CThnqTJE6WzupcCYslO11U7jsroyAJYb5PxkKGIqPR4fqkSJXcnnH+OEJ40A4AV6UuiuCa1Rds3XKqtgSAeiAlO/rxAU/AlwQTafrHn3nZSoO4TsPjiwyA+c8qgPbsH6zkz22hEUcRh/yguGTYabYMXyzAOkPbOas2YluUzY+TGIu2PS4BOBfsgWfvn8Ue37yycEgfPZRQ9t2LLUbeFk2P2tP4ZNy3VwAuaVMVK9bOe75RfOVPcPLI2EPDHSaHo2spjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBxCyEtGefEvMUlYiN381Qq76phmheQ++jelHwJnVFI=;
 b=OHj5DcMhQH7iebxbRNiaOxAu0xCjWs+HRAu90a0fIDhD3mN3xTRTcTOiZ5onta9ddecfgXf3LkbXuofoOCa6KKF0dScl7biJ4u+tcPJSqaQUeHDVRJ8fW3pfaulx3nhmFL4bHEiWqCQNqAhFUvLo0WTbK6v1YmPmcs6Yq15lrmjulJXjXaqm9rLTvgWwJsXYPEP4s4NyJw3L1bWRdktV1EPPykdIxFKkaTp+8pCIJyigGWAlKfI1GzkGeLRKgmxP702HhDzzTfkdmWS+O7cFmUTDY57vz27etIRMwNK9b9KGF5qHlCgjCVqBNR2xiQzI/pDQ13slnOaR3oiFmsSTsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6415.apcprd06.prod.outlook.com (2603:1096:990:14::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 07:50:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 07:50:42 +0000
Message-ID: <86fbfa10-df44-45d8-93af-fa8f3cb0a391@vivo.com>
Date: Fri, 30 May 2025 15:50:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hfs: correct superblock flags
To: Christian Brauner <brauner@kernel.org>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250519165214.1181931-1-frank.li@vivo.com>
 <20250519165214.1181931-2-frank.li@vivo.com>
 <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
 <SEZPR06MB5269D12DE8D4F48AF96E7409E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <e388505b98a96763ea8b5d8197a9a2a17ec08601.camel@ibm.com>
 <7deb63a4-1f5f-4d6c-9ff4-0239464bd691@vivo.com>
 <20250530-gutmachen-pudding-d69332f92e08@brauner>
Content-Language: en-US
From: Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20250530-gutmachen-pudding-d69332f92e08@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: ca39ce50-0d3e-4180-ede5-08dd9f4eacee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxBS0lzSDAwRlRzY2o5UXc4L3cxRC9MRDNBeG9aVjdnZGE5L3FPUjgwei9G?=
 =?utf-8?B?ZFd5WTIwaXBzLzZUbERzbWhsc1pxS0FqU1BXcjNkUHU1L2QyUVAzY0VBbmRX?=
 =?utf-8?B?Y3hueEhCL1BHb3YzWE1qaDNrQUdubzJkR0NwbVhaZXdZOEg1amo2alNaNTdw?=
 =?utf-8?B?QlJyQmJ6MFE2MVVPV3FlRXVmZnQrT1gzcWtYbGR1aHpaazNtemx1eURCdW9o?=
 =?utf-8?B?UEc2dmRaT3lEYW5oRzIrMndFUmFEZVpWUnlzeEpkeFFCcnFLZmwrN29sUlg5?=
 =?utf-8?B?cGREb1Axb3g0RzdNMzBZMmQvd2M4OW5ERVI3b3ZtNWoxZFpNMGZUbG1Ib3lR?=
 =?utf-8?B?dEMwWm1iemM5WFhsVkUycXMwd2NhY1BTcjFJNXdvNmxwTjFleUZiMm5PMHFs?=
 =?utf-8?B?cWt1ajlkb09DbzQ3ZjRRTXhhVlJPbEppUStDTXRlVEZnM2t5RS9QelViWWR1?=
 =?utf-8?B?L0ZMSFZFS0hrRnowRStmOTFONnIwM2lMRndCMHI1OVIyOTRWdm01Z0hQTVBo?=
 =?utf-8?B?d0lhVjBJQ0NDMGNzcDBBdGtDMXNrUWkvQmpzaTlKYzRDK3V2eGV0dW84UVJT?=
 =?utf-8?B?Q1o5RGJld3RKZmtQWkJ1aXdEKzQzbkZvQ3RTRnA0VjJOeExuMUpvUExnaGp6?=
 =?utf-8?B?TTBmOU16QTdnNEs2WG1kUTlhc0lkRTFJVE9tR1JNMitFQUtybHViT1R4Q2g0?=
 =?utf-8?B?Q2QzaDZ5c1B0NTJYOXRwRjNnaWRnZW81QlBDS1pMV0pjekM4ekZldXMyWEEw?=
 =?utf-8?B?SnFLVDR6d2R5czAydWRsMEJ5WS9OeXRucjFvN2tOL1Jxb2ExYXBZRFRCNTFK?=
 =?utf-8?B?RCtPOEp1NDg1T1hjODhzN2h0UndnY1ZuRjlaSUJLSmcrQXRPYXVqSlN5NzZF?=
 =?utf-8?B?SUt1ZzF0dGdNanhlRVg0MWIxRUJhTjZDWUZlTDRMRThsdTBFUEZKS1QzMGRK?=
 =?utf-8?B?b2VNUm1xc1RDWlpXYzhNVGlzTnd0cG1QNXpHUjg0dkE3TURSa2pxbkNleUk4?=
 =?utf-8?B?WkNVc04zMlRuZVY0QkhRRXo2RVp2ZlFjS0d6MUZ3Rmp5MDVnUkRuTzRmb0ZG?=
 =?utf-8?B?YUJZdjQ1dzYvTWJmNzd4aVFtVktwdGx3WkxKSzRocGxraElFRlFqM1RRbWNm?=
 =?utf-8?B?L2ExY0EzTDdPSDVJcHlVSUJGR3Q3UTdqbWpUT1hraHNLaHJOQURDVUxnOUt6?=
 =?utf-8?B?bVB5S0Vtbi8yNVd4UGR0NlUydkhMRHdjaGRlSWJMNXhxeHRzOC9NNHk0RHFl?=
 =?utf-8?B?V240YWhZVU1OY25sdTBwelpDbEZBR3N6ZVNPSklabi90cTJzOUtpV0ZDZWdR?=
 =?utf-8?B?NmltaWR5RXBEVDMvZ20yVGxkMFMvbFdJazNhV0ExRjZxbXlYTXc1QlVLZEov?=
 =?utf-8?B?eDc1VUcvK1NtYlZHSGVzZklBUVo2SFlzZlJrdXFUaUNsN0VxRzl5bGJjYjh6?=
 =?utf-8?B?VGcya1ZIbllKTDQ2SUVJZGQvOGtmR3FlV2xwNUxOcVMra2NwYjA1TVdMeVhp?=
 =?utf-8?B?WUN4elB6dG05Z3ZwdGVvRlE0dGZXRktBazN4SDdveXFqTEdHOW55YmJxRmhy?=
 =?utf-8?B?dVlaMjZPWGdsY1lCbnRvd1Vza0dibm81cXJZUndWMjNYaUJSM0ZvVGd6ZWM1?=
 =?utf-8?B?MXhiWFJNQTNSSmhEUnpOZW4vMm51ZVRrK1JlWldVRHp0UXF6a2V4c254S3ph?=
 =?utf-8?B?bUppVlFOZ0JmcnZrOFBQdnpvakRJY2E5ejFDZ0RLeCsrVG40U21OdUkzYU5j?=
 =?utf-8?B?b1JsVDRuQnlPc05sTmhsMElRU0w0dWlnZmFJNllmanJySFFYa0lsNkxueExU?=
 =?utf-8?B?cU1iODZ1dXY1N1ozblpQN2thY2svbUhOTXJoTXVicGRwdUtzYnpkRkZRS0Qx?=
 =?utf-8?B?SEF0MEhESFdQbThUeVN2M3RkM0xqanBqdkZubUNmdlg5TkVoc3BoMUVkZ1po?=
 =?utf-8?Q?9dwKl3Drp1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGdmNlNFNktUNmRodzZCL2Z6eE9mTm5QemhLRzc0bUlCUDY2YmpFcE9lNlVT?=
 =?utf-8?B?cUZTMnJRVnBjdXMrV3NQb0hWVi9BSkRMWlFSYzZkSC9nSC85NkFvZ0tVVmtG?=
 =?utf-8?B?c0dYZm5NZFNSWExPZThHVjF3S1RkVmIxZzEwK1ZuYXdYZWp2NGdYdkhyRWVO?=
 =?utf-8?B?Q3BwTG5qR1F5NGh0aHhJcCtZeWpPenpSTTlRN0tCMHd3d1FDMkxzeDBqRXYz?=
 =?utf-8?B?Ky9XWEYrUzVmdU1YNFlqV21SdGxtUU9WSXY3RE0vQ1JWYVdId2dReEtZTU9l?=
 =?utf-8?B?SitRaFpVYVdySVI1blJFQjNKNCtacWxMWDJReVlkYjR0VmZ1RFN4QjFBcys5?=
 =?utf-8?B?UXpXVUcrYmM0ZDZaeVEyVHZyZDNQM0V1ZURGaVdVbml1bUdaME8waFRFN2JJ?=
 =?utf-8?B?bldsZVZjUmp6dTN5dXgrVEpBMlFHRGMwRlhBcTdnNksyaXpjRHU0ckNhbDR6?=
 =?utf-8?B?aG9XU2QzZVV1cit1T1p4WHU0ZnRZQVU3dTR4bDJoSG5BUG1tdGRTRXBvQWtT?=
 =?utf-8?B?SDhkZTRScTZiK2FZSUtTVzlyUWIrRmlWQUFTdTA2S1hjcFRGSS8zc0djWjVa?=
 =?utf-8?B?YVlWWm5PUFRLYnltbUxKTHBkOXROLzE4aTBMaXlBTUQ2N09WK1M3WWg2T25X?=
 =?utf-8?B?T1JXUXFCbU0wMTh4aEhNeVRCN1piandTRTB6UzNhQXdqb3RkTk5BSDRLd0Z1?=
 =?utf-8?B?UjROcVorN3R5UjhQUytqV01BeFBpUnoxZXNITS9Xd0xKNVBxSFVYTk1XSDRm?=
 =?utf-8?B?OGxNeHBHQXJsZ1NrZ3R1WTRXY3c0QkNWcEdEZytEL1pvUHUzQmFKK1VrVkpo?=
 =?utf-8?B?MlBTRGFQRFhXcjVmdXBhUjdBZHg1cmRyRy8yNEZ6WWphM1VhSllBMkNHQ09r?=
 =?utf-8?B?cEdIMW1ING9aVjJDT0kxQ3ZoSVV3MlBaald0NzJTSDJEODdXTndsaVF0bWRC?=
 =?utf-8?B?R0lKYmNFNCsyOURrYXIrUVYzTXc2ZWowOUh0TVBBemNIOHd3TWkvNVRUTnFj?=
 =?utf-8?B?YWtYTC82OUFWVEJYRGhrcFlMS0pnMnJGLzlrVk1jWThTaHlFSTdJQ0EzVWJ6?=
 =?utf-8?B?akFZOGlnM3JkcDY3NDBPY0s5YjZsN3VxVEZQTHhqY2xyZzNhbWJxN0JRWDNn?=
 =?utf-8?B?cmFVTnM4SWJEVFM4UWxPRHBpekU0a3V4M2M3T2hibU1QbUR5RUN5M1BpeEFr?=
 =?utf-8?B?OHF1ZG9DUVdtVEF6U09vazlWOWpMVGV3UmhKKzNmMWFFVTgwdC9FSHhFN2p6?=
 =?utf-8?B?V2t4bXE4MVBGbmIzcUs1VUJPVDROU2YzMmhZQnMzaWxNaEtDUnhmT1hiMXdW?=
 =?utf-8?B?UUMzWGRxcUkzT21KZlZCeFowelVpN0x3bU1abUoxVjNhRVpMMDlDWHZrQTVG?=
 =?utf-8?B?YjlHdkR3WUNUN3FSekJySjhYQzQ3WWhxTWlYR3pWdW1GeDY3dnJGK2pacm1K?=
 =?utf-8?B?RWd5ZnNEbWVLVForYWRQMUFXWC96QktLYjJaZVY5QU5vblBSMWdGbHltMWhN?=
 =?utf-8?B?dWJOL1JpemREN2w0M0tXL1owaGtYbEYwa01lV2dTNmQ5RmJZQmRuRHEyY2Ro?=
 =?utf-8?B?amdqbEtmcmo1Q056cGRHSEpaeVdOTUlsWUM1SkpLUUdBQWh3bGxPSUV1WWVU?=
 =?utf-8?B?QlZDKzNoUU95azlXVlFxMjZUQzdsaTBZeW0zdGhnaXJxbEVRRXNZUWZYVzVY?=
 =?utf-8?B?NGNJN2lZejFsTWkrMlhBVWprSEZDbkw1TTRaN08rSjNnR2F6bDdPS3BldFJp?=
 =?utf-8?B?TXdROEgxQzl2R2JZK2lTaFZEMlprZWtUVmpsaGNiZEJ5VkxibTVxd1lqK2Vr?=
 =?utf-8?B?RjluN20vU1ZnVzZnaU9MTHRkKzFySHNHRTh4RzV0aXRRdGtOUjdDaWd1aVQ4?=
 =?utf-8?B?YTRuZWN0djFCM2pKR2U3cEtIcWpGeWN6VTVCR2U4eHQwTm9PUGpVL3hUZWdj?=
 =?utf-8?B?S0piR1NBNXVNclhIcnlyaCtXVUtpZXB3N3hjM0NFc2hFcmJMV1BwcFRNcUlw?=
 =?utf-8?B?a1RpVVh4d2F5NHZxN2ZMMmZaYWJ3c1dRNXQ4ZUxaNVNpWVAyV0xsYmNKS3Ex?=
 =?utf-8?B?ZGJObmMxTDNIUlZBazJ3NnVkdmZiWktNcnhNcElocG9vNDdkL3pJRkhiTHF0?=
 =?utf-8?Q?G6Mpr/dIgKU9cDNHDfW58s7a0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca39ce50-0d3e-4180-ede5-08dd9f4eacee
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:50:41.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hr6gIvCjBntu6s4K3/9r0mxHLwH1FnFbzSsAckvxSXKXZx8nHiVj99pmV+dt1sv6WhicC41mj61wI457QF25Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6415

在 2025/5/30 13:21, Christian Brauner 写道:
> On Thu, May 29, 2025 at 10:25:02AM +0800, Yangtao Li wrote:
>> +cc Christian Brauner
>>
>> 在 2025/5/29 05:26, Viacheslav Dubeyko 写道:
>>> On Wed, 2025-05-28 at 16:37 +0000, 李扬韬 wrote:
>>>> Hi Slava,
>>>>
>>>>> I am slightly confused by comment. Does it mean that the fix introduces more errors? It looks like we need to have more clear explanation of the fix here.
>>>>
>>>> I'll update commit msg.
>>>>
>>>>> s->s_flags |= SB_NODIRATIME | SB_NOATIME;
>>>>
>>>> IIUC, SB_NOATIME > SB_NODIRATIME.
>>>>
>>>
>>> Semantically, it's two different flags. One is responsible for files and another
>>> one is responsible for folders. So, this is why I believe it's more safe to have
>>> these both flags.
>>
>> To be honest, from my point of view, SB_NOATIME is more like disabling atime
>> updates for all types of files, not just files. I would like to know what
>> vfs people think, whether we need to use both flags at the same time.
> 
> SB_NODIRATIME should be a subset of SB_NOATIME. So all you should need
> is SB_NOATIME to disable it for all files.

Thx to point it，I think I'll correct the incorrect usage in other file 
systems later.

MBR，
Yangtao


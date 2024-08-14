Return-Path: <linux-fsdevel+bounces-26011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735895255F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91DE1F23859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A03146D78;
	Wed, 14 Aug 2024 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D9InTITm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69235894
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673752; cv=fail; b=Rp8x1VCeW4MkLXQxDntjCWu5uGl+m0iUZwr/M20qmpbUljTtq4SX1esYNVCQwuovnehIzPTeA+3iJFYMgcnz/uDzBBkp+DzCk7Doo9crb7SAMXu2Jb7yUvc+lcF6aBIEb1kWFvE6cP0nzDXdA+HfFfubDS4McGX0F0wlP+ayDXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673752; c=relaxed/simple;
	bh=7FV8M//0h0iyHL2QIPHeTddPp21hFZiQzYOTbikribc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qO+g22lubDMtcIIJC2L1simfmRjOa+OCEiP5HXeXj2rl/8s04mCDBdpjXjiW7zpJiF88lKfhmbqQSe8Jupdw7rFLNTOgD7gQV5cU5mzUbnfFORtMZvA+Te5LMC9zV2XNFlpbexTq/jjE9kL/ahEGKFz/rHh0VoQ6gNOoZqykrDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D9InTITm; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA8N5/a7wTV5KVQ6sYITZHGwWmNEmEaIgDmZ9qxItpsbKafhNc/ZnWkjvIPBHK9Dbj8Rmddgl5aGtlU2n+GGd2QPOQH8L1y5I1CHnM4BeYABz55jeTpgPX7r2v8R+CmdEqeKl4cJ9FPfDc+SQXwwT+tEOoDUmV2v6J+c5+AQLd/X9mc/Edrw0X14khxigT9mhPuCu5xOijo/JBo2zwaD7U3rrgZeqs94HXJwwJ9TAvYmaDNrGnt6UKmI7OYNLSsvP/v/nmXiWDJTYKOJG9vChkBSuz0HDZIFGk+ZDPlbPswJgRj87zi/fjBlRKV8X6GsOG7hzzOIXdo3DHxHJspKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYy1aPPmedGCj8SwhwJi+SDQ2Lpo0JQBNqdFj4Nu1Gc=;
 b=Dh6E+H/d2cqG4G5lOV8AuUiyKrqVLC3YKZMlN4b30gtZsnM5XOnadfT1mPJnwz1uTIaaGpT64ifVbWHLU+12V786dz0qfdtmbiMbNEBmrPnjW1COOxWzlTb94zginHgEt2sHKM0tVL6vvaNXgp34llgwE/OaGdXrvnowTqHNqFqOiDVndmLby/6rFLeB79QjrUsNsZ9F1h+dFC1R+aRDinveiaqtdklDFg+vx4Z+bcye1fwRDTJMtHhhjzW1o2D7LkqKjNp9mX0lHr3/6HkhLrNLVJDFOlsLQ7ujctBmH0EMjYx5cwh5Z9YZzLuSjp3wh+NKWs6t8x34O5zJcD5lZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYy1aPPmedGCj8SwhwJi+SDQ2Lpo0JQBNqdFj4Nu1Gc=;
 b=D9InTITmlRwhS/cdo5vkEYvtp4CHrP5fMPEsam9/VPWkV+CyOiJXRE+NevvvuPjjyy+AQEBNYUcJH+FXG2iIArOGii5QR1+ymJKG5/hyUTlLDVIqIUfljrnCkO0YZjgU5NHY55YHYe4pEBaWrOOl8CNG24BaWG4DoRpl683dMlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 22:15:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 22:15:47 +0000
Message-ID: <09a1d083-0960-4de7-ab66-527099076ee4@amd.com>
Date: Wed, 14 Aug 2024 18:15:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] amdgpu: fix a race in kfd_mem_export_dmabuf()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <20240812065906.241398-2-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240812065906.241398-2-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 68da589e-4d8e-46af-e2e8-08dcbcaea611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnVMaXV6bTFGc2JFL3JyeU9nVHcxQjRXWDRRV3N6M1kzS1pzcjJnSTBCMnBT?=
 =?utf-8?B?aC9OMjJSWUU2ZnQ2bDA5blphK1RCdVUwSmVBSHJnY2xjWEFhVndab2h6UjZz?=
 =?utf-8?B?eUR0UEtHN2t3QVJBTHpiS1FMNENpcmRvU3FoRVBPekVtRFZzUGV0ZWtJMWdj?=
 =?utf-8?B?WGhGeDdpd2c0Zml6Yit4MFBaTHdqaHpOT0ZIUHRWU0dNR2JDOXdOM1BGZlVa?=
 =?utf-8?B?RTZ3SmhQeExCSTh5VGd2WkN2S216ZjlHOEtVendaQjVOc05qekhCaDZCbjAv?=
 =?utf-8?B?QmxRc0xwWWxDZmVzczYwSTZ2Q0YwVm5SSUtYRjN4aVpPVHJqcUhLMHA3RWxm?=
 =?utf-8?B?ZGhBNGlTbFo1RzZTK0ZQaHBWM0hOWWtyMWF4bnFsVGtSanVnQkorbWF3M1FX?=
 =?utf-8?B?N0RnT2p2azU5QUtScS9nVVJscW40WUZNcWFaWkNQVG52VlRuU20xbExkUEs0?=
 =?utf-8?B?UnROcFRIU0pMRlBBQTFaRS9zQlNmTWJzOUZZdTlnSmN2ek9SUDJNRXdaSFht?=
 =?utf-8?B?NEkwaXFtdTRHSlR2Q2hWbzZwbE9ZL2IrWkoyNHZjY21xeFJXcHdPYkxNYXNw?=
 =?utf-8?B?SGZPN3lFSGM5Y3lyaTVpazNWMi9OWXdFU0hFK2NzTmFFTUpwTEwxdmUxU3BY?=
 =?utf-8?B?djdDL0p5RFJxQncwclpSQ0pJS1R2Q2tSbnB4QW13QjNacnNNbjg5Z1kyRDUy?=
 =?utf-8?B?VVZrZnYxNm1aWHQvclFEbUs1Yk9VQkFBRnIvYXFPbWJYbXRxKzJFQU9laFZF?=
 =?utf-8?B?M0ExdzJ0WnZySVpIby9rRG55TlgwQXZBK3hWWnpudzVXN09ycEV6RWQ5OVNP?=
 =?utf-8?B?c1Uzbkd3Z3JidWJtWmZTZk9KRENadGdPL2FmbjlNdGR6WTVQRVpGTHl5dlB6?=
 =?utf-8?B?Nzd5VTF2S3NaeGdGcXhtUTBpNnpXM3B1K0xQSHZrMDF3T1JhZXc5T3BvVWdi?=
 =?utf-8?B?dG1lM2xEa2owMXg1cENmZUlzdHFZVitWamhPMnRGc0g0YjE3elZHWXRrYzhr?=
 =?utf-8?B?KzFGZjg5ZFQ2N2IxUEt4SEd6V25ObC9UVnpnS1BaVjRWZGs3bEdrOUFnRnAy?=
 =?utf-8?B?NHlKNkY1OVB4MUJaMG5ZUmZjSHhYOHNncjZRd0s1eXBmKzhpZ3lvOWl3RXhy?=
 =?utf-8?B?d3k0dmZaS2VzaHdZVklWdkJrRGR4Y0k1N3ZPTTFpaHFUTzR1K29oQzFXRlN2?=
 =?utf-8?B?ejd6dW9oQ3VEZ1RUNlVjQ0xUbDNiUXZnUkF0Y1V1blUxRHZGSWNJWlBMNnR5?=
 =?utf-8?B?YmtDb0piNUxUc0V2OFdJNUZNcEVJamN4WHNlL2NCa2dpQVJ3TFVxN0RvN0xD?=
 =?utf-8?B?OTdnZlFubk55NzdIR3c0VGs0MDVMYXdDQ3JnTjVmQlpjNEtFeUNrODB1bnpV?=
 =?utf-8?B?NzJBUTJqR1kxc3FtTktLNGhTZXJnS01tL2xITmNzTURtUWlZYkVINytaRXdQ?=
 =?utf-8?B?NmUyOFlkLzVORUFUQzlUSlRxSzRNdUkwdmg1QmZyaDZDOElTenl0TUFVRXBY?=
 =?utf-8?B?VmdwaWVkcklpOUlkcmdZcllFeWQxbGtlQlpsYzBCNExodkVCSmp6RStQL2Vm?=
 =?utf-8?B?NWZnVHo0ajBRUTVWNlhLd1g3aG9paHJFZEJtOWVDSTk5c0h5NVFDR0Y3OHI0?=
 =?utf-8?B?QU9OZ0JNdWxJemFFLzJCWVEwamRaVjVzOVNhdGZmZVl4OFZQTHhheVo1UXpE?=
 =?utf-8?B?NHNYa2VpTjNKQWc2OGI5UUlhejNCZDIzd2syZE9uQTZQemg4OWpJdHdjSnJE?=
 =?utf-8?B?MEtWdkNsWnFSQkF5aFRvMTljVStibzFzYVRtc0NwWHhkRCtvS0huQnJFMGxT?=
 =?utf-8?B?anFpdTdaRDZlTmtSQ0JsZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S042MlhlMU9PWVJhZE5Jd20wOVdpTTkrcnZBcUNFblg2S2s0OWk5a2VBa2dU?=
 =?utf-8?B?aFNjV2E4Rkx4OG56akRQOC95QXBZWFhCSUs3QktIODNXbVFmYnpHOUh5UFgw?=
 =?utf-8?B?cEp1VFdXd1RpUkk1eUVGaXZvL2g2dCtGMVZJMUkxYTN3WGIwRlVTNTlUMVFG?=
 =?utf-8?B?RmVpcUtQTEMzdlVXQWlRc2Z2NE5EYVFyZDlFcHA0eDR6QVV6Q0E4Tk9RUE9F?=
 =?utf-8?B?aFloUGVraXYrb1BvSmp0NVNUZmZFKytLdkZoelQyeTYwd1BneG9lWmFqL1hi?=
 =?utf-8?B?bmMxdExSclRmZ1hBeUNQS3grdjUwZTM0UTc4bEVURHNLd1U4U25iaGFxTWFB?=
 =?utf-8?B?c2p4MVFaTGV3R2w4a1g4djhRYXRHNGxURytHWWErSXRmZG90eThwclY1U2k5?=
 =?utf-8?B?N2RiNVVLTjFOak5HQ0xvYU9aakpISk95aDd4bUpIMTFQdEFyYXhtY3pBSUlw?=
 =?utf-8?B?QWxLdEg3VTBLWGVmdmF2WlQvT0dQdGtET1h5dEhyNFlYOWxyaVJNdjh6bTRB?=
 =?utf-8?B?ZXUxUG91N254N2syQnNoYTltR3hoc25DUzNab1BoT2dSK1pQRHoyUGVrb2J6?=
 =?utf-8?B?K2hLZzdNSnFHSFoybG1nbW1STFdNVG1zTE8vL0dVWVl4ZGxoeVR4b2tlRXo3?=
 =?utf-8?B?VkRFYlNpbzY2aHZjVVpZZTh4aUxiSVpNNDR4RGw1eXAyRFpNWjJVSHlDb1p3?=
 =?utf-8?B?Y0t1WXpaR0ZnbmUrRUJGK2dZenduc2I0bXNSWHZySTBsOExjRCtabFFsMUhi?=
 =?utf-8?B?M051ZHE4Y0t0SHhXYVEwQzdxVHlJTWowZ1JNQnpocjVnU2FyUHowNmo2ZCtP?=
 =?utf-8?B?bHVpam5DY3hZUHlZb0ZFaFc1SVd4OS8wTERUMjJDVkFLMDRQUGV1L1g3bDlE?=
 =?utf-8?B?U2xmUTM1UVhUSHkyTlpCUTRITTEyWGJBcWo1NEtOVldIVkZNbkZ0RGh6V3BT?=
 =?utf-8?B?MmFtY05QSEJWdDVtV0p5S2N2azhZUnlvY3BWTGRTTGpQMDFGdlg2QnYyN1Rx?=
 =?utf-8?B?WU8rZXRwdjBMaEQ1MXkrZkhLMzZ4VTE5WTY4bkc2d2ZHdllIQnpia0RTTVA1?=
 =?utf-8?B?U3dCTnZzNFJJVHVtRkRXZlRkSHlVam1LRDNFZk1uNWRwZFBSTmFHUGJhM0xq?=
 =?utf-8?B?M08rK2RXZ0lXNU5ubnMzYWYvYUkxVGhHMDNSb1BJbHNpalJMRXdyYWdSc21o?=
 =?utf-8?B?eHluREhVUVkyZEx5eUhDck14N0pEa0Q2SWdIUUFicmppZytWRGNPYTRYV1pZ?=
 =?utf-8?B?OUJtaUxCbCtEa3prQkNzdG1KWUNQYXdQcUg2ZksyVVJINlQyN2h3Z3RUQ3BI?=
 =?utf-8?B?cUJMRHc2YkY0UDluNHhOYkVZaUNuamlVQXRXN0tWYURqSlhPSFRnaSt4TnJM?=
 =?utf-8?B?WkRxUzR3blQxeUg4akxBb1BzTWZaZ3VDTEwyOTI4ekYzYzdLU0MvbVo1b0N3?=
 =?utf-8?B?YTZRYm9sY3hNUHVJWWJaZ2JTWmcwYy8xUjFjSElFTGUyWllOeHFQeU5OTmdH?=
 =?utf-8?B?MzN0MEp0RHpNS3NOTFE0dTRJRW9PM1ZtVXZDeWtBVUxCMkg4eTlVbStsUGRh?=
 =?utf-8?B?MzVZbEVtaEx4Zkx0MnFMd0dZdlRsR3N0TG9iMXBkODNLbWs3aUgvL3MxNUw0?=
 =?utf-8?B?dzRGNzRmVTljb0kySmFPUitNSUt2NDVuc2NZWVpsVGZQdWFXeXZ6ME5wRzdK?=
 =?utf-8?B?SUI0ajl0RXFwMit4MW85THZOT1BLM0lvYUdHR09SZFZ3T1VvdnN3TWpiUWFV?=
 =?utf-8?B?TzFQaVdrK1R2cE1ROVNBeklUVmx0bEppT2owckJVWS9xQ0FmTWZ4b0YvUVZK?=
 =?utf-8?B?MXhSUTl3WEh3QUxoWS9yY20yQS9zNnp3TlZmVHNXOVQ3Y3hqQzFhRUJSSHpj?=
 =?utf-8?B?VURtOHZjUHBJRVFHeE5pNjRJdEtIZVdJdk1OM2VUMzBhaldvUmRuN2dDWjN1?=
 =?utf-8?B?cDd6dEM4UlNYVmlWN1RhYU4zVnhGL0dXNEl3RTR6MUhRbkQ3NTRpbXhXK0NO?=
 =?utf-8?B?WDRMODN5SUNtVFora2tuNGMyZ2F5dTV3QTRYc29CMEpBQ0NGMU0xQzI0WFRU?=
 =?utf-8?B?Z1VYTmZ0R0oxN1NKZHpDcm5INWdrYUpyTjI1a2ptcURERVB0a0pUbU9aeVhm?=
 =?utf-8?Q?BTX39datYtnWMFORTdvMKjv8t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68da589e-4d8e-46af-e2e8-08dcbcaea611
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 22:15:47.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtENRcCthubuRbrvNSzdTl5fDlegl5M4cpIif7/CQrSHVL2NjFkQ2Yal9og2BsN90VTECdlzEWFiP9SiM+3sRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733


On 2024-08-12 02:59, Al Viro wrote:
> Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
> descriptor table, only to have it looked up by file descriptor and
> remove it from descriptor table is not just too convoluted - it's
> racy; another thread might have modified the descriptor table while
> we'd been going through that song and dance.
>
> Switch kfd_mem_export_dmabuf() to using drm_gem_prime_handle_to_dmabuf()
> and leave the descriptor table alone...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

This patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 11672bfe4fad..bc5401de2948 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -25,7 +25,6 @@
>   #include <linux/pagemap.h>
>   #include <linux/sched/mm.h>
>   #include <linux/sched/task.h>
> -#include <linux/fdtable.h>
>   #include <drm/ttm/ttm_tt.h>
>   
>   #include <drm/drm_exec.h>
> @@ -818,18 +817,13 @@ static int kfd_mem_export_dmabuf(struct kgd_mem *mem)
>   	if (!mem->dmabuf) {
>   		struct amdgpu_device *bo_adev;
>   		struct dma_buf *dmabuf;
> -		int r, fd;
>   
>   		bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
> -		r = drm_gem_prime_handle_to_fd(&bo_adev->ddev, bo_adev->kfd.client.file,
> +		dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev, bo_adev->kfd.client.file,
>   					       mem->gem_handle,
>   			mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
> -					       DRM_RDWR : 0, &fd);
> -		if (r)
> -			return r;
> -		dmabuf = dma_buf_get(fd);
> -		close_fd(fd);
> -		if (WARN_ON_ONCE(IS_ERR(dmabuf)))
> +					       DRM_RDWR : 0);
> +		if (IS_ERR(dmabuf))
>   			return PTR_ERR(dmabuf);
>   		mem->dmabuf = dmabuf;
>   	}


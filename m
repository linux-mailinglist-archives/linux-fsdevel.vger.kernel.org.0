Return-Path: <linux-fsdevel+bounces-20978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE998FBB47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE9281A96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D6E14A0A9;
	Tue,  4 Jun 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eco1G3IJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61810149006
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524529; cv=fail; b=YmwG/i2XSYskr9y23kKh7Xl8CpM56wtjoRLfhiNYy4qshx4jAp1A+cIUBVI9NEg5IcZSDHP7XjTfUGxznUsm2eE24KWm6txOvylPdNH+WRvvkfEESs4PEoB1zkURxr2JsT6kMpNIcpnw+GOSfQTPPPrHx8EVWTa4O2edsnRWogE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524529; c=relaxed/simple;
	bh=nW8PedGebvKpm4IejE3BB9zl91YAt9rMWwlM76Ueg6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PY6Q1r0IhrvK4Htxs71lHJNkBPc8HTHiOaKAmkiH6hVU2xhX2WKQ2fA16xymAveZ81H+ufUVLUbIzDSrT2HsMzS0xBzTH6vPDs0YqOmxjqFdTzepWKITsk9LYkTtB89lLdrJTM9Uwqtee4QNkbz/37EEhm/uf/MLPVq28fg4j4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Eco1G3IJ; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6weXxTbZuJlkIy4x7XMGoJefebBp88zj5t5uZDlGG8rJcEKzAvaEM7ydsuIcVNmkzBlRHW5xFwFR6s42nizjAr1I7QlI9VU/b6Ca7frIZ8GxJWzhuO87CPITE0MuSv8c0n8isv1Ee33NDGzQClDh3XH+VJzJUI9mbkkV81yRyO0E92ighBHTIeen8rtUxeBBwpJPwgHgET4rqSGc32Txf1zpofH5jNvpsOMUeCHBRRF84OdakjqlU3yN+EHHYJ2Jkbm+1DmLc/aT8BzEfaK1YJi6+BZfhZxdKhL41Mlb2plAXEdFqYhgm43hS+un8XO/szHN5r1Tz5fwxOBAplouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TplAcE29SeQUdNlXuixICfmVhUT9xyZSLNWyW6IHp8A=;
 b=Nf3mxpT/yd8dTdBbHY7h9cymZYQ/95kH2oPn1IOENBEuxRASMlu/5JJ/MPC7tCpYupmtRVMRfVIHxxGRM4EygRV3II8YAOwEjdZLh3h7qc25rA8oHVdSaQzGrYCRmAZcd1H8SGIemu7fvE2x87AJKEE8yC2UC86wWKbNwlPnVGY+guc2T7cVm9LY2YCke3Vkzi7FGilEdPSUj6oalYzUSRuZMfAm0ycrjBo7SjzVxV9g8dORgKt55AFRKndcFO3sENqfkPXt4jgOvQ7qxpYpxjB7cFgcfBDQZGdvJoPdW2S64BPnOh6CbqkU2Pj/kNTek5IlE4QqSt+rf8lzuq0OdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TplAcE29SeQUdNlXuixICfmVhUT9xyZSLNWyW6IHp8A=;
 b=Eco1G3IJjQ1L6mZqnjxY3EWtKhciw6YwXVNFWyRN/Llu4N8Qqxq2SFvreZC3ONHHGyCENRlaPnbnkAA5WTaKkOHvPA3oS4Y1zXyXZW2tmeyYjjzXeN0HEHIKU9Zn7AqYYILFSXhHU66nOQjgzGYKXasGSHSK7/LWm2UaI/7UciE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 18:08:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 18:08:32 +0000
Message-ID: <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
Date: Tue, 4 Jun 2024 14:08:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2][RFC] amdgpu: fix a race in kfd_mem_export_dmabuf()
To: Al Viro <viro@zeniv.linux.org.uk>, amd-gfx@lists.freedesktop.org,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20240604021255.GO1629371@ZenIV> <20240604021354.GA3053943@ZenIV>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240604021354.GA3053943@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::37) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: be5a6863-5276-4eb5-8d07-08dc84c15868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG13dDM0YTZNSU9JM1dEOVJmTGR2dDgybDZKSUkrNWJxMzR1Ri9KelpUcEJ2?=
 =?utf-8?B?RnhYWEhlZkM3cGVuZFJob2g3aENqOWU5TU81ci9ldllpSmZEVzNFMFRyeE9w?=
 =?utf-8?B?SXQ0S1N0VVNSclZocGNQeGtBdGdxM0pJYU5CWVdLbzBXZWJka1p6WTJNS3dy?=
 =?utf-8?B?cXVYOGdVMVlaSC9IaWlDY2o4a1BCU2ZuTUFnUmlVRUxUMzhnNDE4cW54dVR0?=
 =?utf-8?B?WXBqR0dOSlQxYlNFRUUwWWRTRDZGek5hVVUzYUJiZGxkek9OQlcxb3cxWlJF?=
 =?utf-8?B?ZlhWS29MdWVVRUppei9oMEI5aWJIa1hwNjBWMnRtZkNkSmgzc0FuK1JxRkUx?=
 =?utf-8?B?NXkveTF6VUtGY1Y2UjdNREFiMTRwNW9FS21kNENlTm4yL05VaDNtOExYeGhD?=
 =?utf-8?B?WTZ5MWhwdjVNbEIvYlAwbkZoazZkTjAyazEycVErTXJaOXpTZ3JMejNCTWZQ?=
 =?utf-8?B?djRyUFVKNXBhMHJWdFZuOWtJUGNEN2VCbGxnUS94V0pib0JrOWNWRnZoNUYr?=
 =?utf-8?B?bGVPTEdIU1ZIemFRMDloZnYwcTVmbHhzYksyWnlFS2hSSDU1S1p2Sm1NRnFQ?=
 =?utf-8?B?NmN6dVFrc1FndVRzSTQ0eVhZRHRUUU1HYm9wNzhUTUduRHh2U2VrZUlKT1No?=
 =?utf-8?B?VURkbkRFMGVtSzB4ZWhiTXZxTjlEcXlvNk00NVl4UDVwUVFzV2pZZDVXL0g4?=
 =?utf-8?B?aENIM2pLWFI1SDJoa1JrK0o1cTBpNUJNWGZNYnN4TGxjK0ZiNWY4dVhjRHY1?=
 =?utf-8?B?V2NWNEw2QXYzM2xZSnVhN0xqTFlORllUWWZZb1R0TkVhb3psNXprMk91ZGR3?=
 =?utf-8?B?ODR5MFZTVXJCRUN3aURWOG1nSTVWSDl1YlpwZHRRTXRqalVlUWdPUzZwL1dW?=
 =?utf-8?B?QVB0cVlDMjNrVlcyS3d1ekVSYnJkZE40RjRPQVBFbFJVYVJYRzNNRFVPa09i?=
 =?utf-8?B?aUUzUW5hOUR4c2FSREt0dmJ3SHkvdEl0bVBQQ3M2eDQyWERNanFnaWNad1dp?=
 =?utf-8?B?RjZtc3FON3BzNFVYclRRLzZST2syN3ZScmNyajQ3ZTNlQzB4MytvTEpLYUpH?=
 =?utf-8?B?MUxibEpvZWhYL3M1YnlvdjdGY2JxamxReElRaGIvQnV0OENNdi9pUWo3L3Vn?=
 =?utf-8?B?dDQ3bHcwWnVDYVVpOXlkS0Y3YnROM1lxT0JveEcvaHRiKzB4d3hVam5mdzI0?=
 =?utf-8?B?U0t5NWd0UmdqMDVJcUZjeEJpV0dpamV5VmlYbFJrQWtnaUswK09QRnNoc3or?=
 =?utf-8?B?aGR3U0xER29yS2dJSk81NjhVQnBScVFlTlV0YkRzVEkrUzltait6dEkzUXVC?=
 =?utf-8?B?OENPYTJxWXoyY2hyVytjY1AxRy9qbUtyNlJtRk5PRnlNWW52SWszbVVwNWJE?=
 =?utf-8?B?NkVMdXY5enhLL2VWY09TZXZGb3QvR1luNTVsdEsyRWw1Tm9ISE5xRnowRERw?=
 =?utf-8?B?WHpIRk5jSDhGaHdKdmxFdDNFSCszaHNnYU56eS9wMGxSaGZtN2NtcktnSG5w?=
 =?utf-8?B?M3JNZXNqYm4yaXZMMklnZ2dxdkhyaVVIRjNmdktPWlZzYmlIcDJSUE01c0Z5?=
 =?utf-8?B?Z2hMbzAycGh4SFFkaWpWbEN1UW5FV3djSXJXYnFOenJCN3o5dXkvczA0c215?=
 =?utf-8?B?QStCeWtLdFVTTjduNDhUNUJ6MHd6QlFMblozMVd5QURReFRrc3dRUHc2Wncy?=
 =?utf-8?B?VEI2aFhQRDVDL2RmQTVDRFh3dzNKbTlkU3RIWEdiWjdoTEpob1NEK3lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDdySE94UVRNOTFCb0xtZ2tQVDA1Y3lMY0FybnRlN3J3YXNTUnNDclV3OWtD?=
 =?utf-8?B?SklBa1hCOTN2VDA0bGQvaDdaTlhCbW4rbnM1ckhyLzhHMEtpTHBHalMwSlRL?=
 =?utf-8?B?a04vb1h1ZnRNendsWTdDbGZpckY1aUV1dXIzUXBjR0h1dzJXMU9ET1piYWU2?=
 =?utf-8?B?d0hpei9wTG9TZjZQMVVNcHRyQmQrTjNGaWVQZVROYllSVEVJeFBIUkpBdnNL?=
 =?utf-8?B?bjlETk02WEE2YkxmV2tsV0s5ZDdLR0Y4dk9LcWI0clJnS21zZjNsdENRNjda?=
 =?utf-8?B?bXB2ZkdFNCtTQWtiT2tDSlJ5UWwveExXcFFZVWkrRnBTeW1SeTFGU0w4TzVB?=
 =?utf-8?B?YjQzQmpMaEV3OFVpNEJ2dmM0b21ibFQ5Mm80djhJNjlIbWZRT1Nrby9HVjhs?=
 =?utf-8?B?eW1NcGVjdk04SW1QTE5neVM5U3ZrM2hCandsRjZ5TlRZZFhOeVdVL09Wek9x?=
 =?utf-8?B?ZjBKN1I3aTNTc1FQNW1mcEg5K3B4UDlZMW9SWFdqeUYya2JSSDhhYUJzQndU?=
 =?utf-8?B?aU5TTVU4SDN0bmJxdE93TUwrV1pueXVoeW1aYW1TOWl2VE12MGlqSEk4WERG?=
 =?utf-8?B?Q1J3OVJESnJOcy9wVm56cVBBVmNmeUl3cnRyQjg4ck1XcThsU1ptL1I1c3ZD?=
 =?utf-8?B?aENCN3JlNm05ZFo1aWxtdGY4V1JLay9GNTdhalNtd0NtY0htZUlucmdXcEdR?=
 =?utf-8?B?YVdiUzZLSFRoZkJwNmtUZHBKc09kcTVyQlZqdlFhcHdYSUJWeDlSSHNsZzQ3?=
 =?utf-8?B?c01uUzdiaWloUUhWN0tBSmdZREpqZWVkRUg3YlBFSXM2VmRmZVJoakZTUjFu?=
 =?utf-8?B?MVNmcllrK1lGVnR4cFJabGNTOUFEanZBbFB4TnFzYlFiODNWZGtUbWUzTjIy?=
 =?utf-8?B?eTBUOE9uWlNLZWxJL1MxMUhKKzBLeFJVYXc3emJhQUJHNmFQN2tta25FRXBN?=
 =?utf-8?B?VjJrQU53KzFqM0xxT1FlYm5VMXBZWmhqZ3VsSUxiVG9DMDRzOWtnSXBPY3F3?=
 =?utf-8?B?cGV4L2JxOU1ZQXpLN3JQbjNGTGJENmxkdnNERVZ0OVBFaHRCbnQzUXlLUFd5?=
 =?utf-8?B?cnJCaWxOOWVzb3pWODBUcHdkSy92SEZ4U1ZoUHI2dGJGdUo1VzRyNkRkTzg3?=
 =?utf-8?B?MHJYQkhMT09yRTNnY1g1dEVpYWRwWWhtSEZiRVBXNkdpbzF0S3N5UEt6aXd6?=
 =?utf-8?B?bm96VHVxM1N5QjJ2UksyN2VHZkFKZDlxRjZSb1A5QUVhSCtjMzN2bmIvcG1m?=
 =?utf-8?B?SWVETlkrN24zT3pVbGNuS2hybHYwbmNENWpLRDFVaHl6OS9KVkVSQmpPSEhF?=
 =?utf-8?B?Q3dxbW9ZN01iWE1taUNWeGxqZm5oUkZjREgrSnFzZWFpT2o3VDI5ZzNUZDBw?=
 =?utf-8?B?QStRN2l4cENJRHBMVHNrVDRrL0x0Yi83UjlMa29PSnUzSlhHL0xHNWdTQWsx?=
 =?utf-8?B?b2JHRGd3U0lsV081MkZpNnBrUE1rS0NUWG8wMG5KRU5qemw1QVhnZ2lROHIz?=
 =?utf-8?B?cW84NzZlbzFnUGE4VG1HQkFxcXh2TmJ4ajJaUE1qY09UbzRUU0FBTDRidXVl?=
 =?utf-8?B?ZDI4S01XL3MzMS9ncnp6bHJhYThBRENPdUFzcWx5Uzl0TWpWbHFpbXJPRGhP?=
 =?utf-8?B?QjlGRGF1VHpHUXZEVjB1Qy9VbVZ1R0IxSEVGN3haQU0yY3hQaTQwM08weXlQ?=
 =?utf-8?B?eU41R0pjWk9BeTBqQ2dYaDhIanZqOE5EcGtBRHk3UFhOcUF2emhMTnlTbnVF?=
 =?utf-8?B?T05NSmRKZ3dpOWpFb2FHd211bGFmZ1J2ZHEyeFJZYVMvbEgvY0s2dkt4UE81?=
 =?utf-8?B?TTN5cmt5WnZnVnpGSWRVSDY0VC93UXVXTG10cVRlaEpGa1U5cEI1T1J1akRO?=
 =?utf-8?B?S1I3cy8xV09zZUoyRGo3YW9qQUNlSXowdUVKNEZkNnV2TDl6TEQ4REFpbGhl?=
 =?utf-8?B?ZEpITVJuVm1pYTU3bFpaUyt0My84dGZjTlpmKys0SXpCTkE2WFcycnJSQ05a?=
 =?utf-8?B?TUVXOXVBT2VvVjZPMlJRNHZoOHdLblA3dHpaMENTeWdURmpnM0RlSW8vbnRu?=
 =?utf-8?B?VGFzUTZ5Yk9XSGFmMkhOTnVBRERqSVBoTWpFbFdXQ2YwTEJKVVhWRkYvWjd4?=
 =?utf-8?Q?TaWHTAOi/Qv+drhqpCb6dWBzI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5a6863-5276-4eb5-8d07-08dc84c15868
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 18:08:32.7541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFJQyah3cFJo3B61ZJGSzSKTN/feH4dEJrHTh461vajz3qEvgM8RmP9gEOh1BC854PW9wMhI4pU0UXK0Ky9vrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789


On 2024-06-03 22:13, Al Viro wrote:
> Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
> descriptor table, only to have it looked up by file descriptor and
> remove it from descriptor table is not just too convoluted - it's
> racy; another thread might have modified the descriptor table while
> we'd been going through that song and dance.
>
> It's not hard to fix - turn drm_gem_prime_handle_to_fd()
> into a wrapper for a new helper that would simply return the
> dmabuf, without messing with descriptor table.
>
> Then kfd_mem_export_dmabuf() would simply use that new helper
> and leave the descriptor table alone.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

This patch looks good to me on the amdgpu side. For the DRM side I'm 
adding dri-devel.

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 8975cf41a91a..793780bb819c 100644
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
> @@ -812,18 +811,13 @@ static int kfd_mem_export_dmabuf(struct kgd_mem *mem)
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
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 03bd3c7bd0dc..622c51d3fe18 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -409,23 +409,9 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
>   	return dmabuf;
>   }
>   
> -/**
> - * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
> - * @dev: dev to export the buffer from
> - * @file_priv: drm file-private structure
> - * @handle: buffer handle to export
> - * @flags: flags like DRM_CLOEXEC
> - * @prime_fd: pointer to storage for the fd id of the create dma-buf
> - *
> - * This is the PRIME export function which must be used mandatorily by GEM
> - * drivers to ensure correct lifetime management of the underlying GEM object.
> - * The actual exporting from GEM object to a dma-buf is done through the
> - * &drm_gem_object_funcs.export callback.
> - */
> -int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
>   			       struct drm_file *file_priv, uint32_t handle,
> -			       uint32_t flags,
> -			       int *prime_fd)
> +			       uint32_t flags)
>   {
>   	struct drm_gem_object *obj;
>   	int ret = 0;
> @@ -434,14 +420,14 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   	mutex_lock(&file_priv->prime.lock);
>   	obj = drm_gem_object_lookup(file_priv, handle);
>   	if (!obj)  {
> -		ret = -ENOENT;
> +		dmabuf = ERR_PTR(-ENOENT);
>   		goto out_unlock;
>   	}
>   
>   	dmabuf = drm_prime_lookup_buf_by_handle(&file_priv->prime, handle);
>   	if (dmabuf) {
>   		get_dma_buf(dmabuf);
> -		goto out_have_handle;
> +		goto out;
>   	}
>   
>   	mutex_lock(&dev->object_name_lock);
> @@ -463,7 +449,6 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   		/* normally the created dma-buf takes ownership of the ref,
>   		 * but if that fails then drop the ref
>   		 */
> -		ret = PTR_ERR(dmabuf);
>   		mutex_unlock(&dev->object_name_lock);
>   		goto out;
>   	}
> @@ -478,34 +463,49 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   	ret = drm_prime_add_buf_handle(&file_priv->prime,
>   				       dmabuf, handle);
>   	mutex_unlock(&dev->object_name_lock);
> -	if (ret)
> -		goto fail_put_dmabuf;
> -
> -out_have_handle:
> -	ret = dma_buf_fd(dmabuf, flags);
> -	/*
> -	 * We must _not_ remove the buffer from the handle cache since the newly
> -	 * created dma buf is already linked in the global obj->dma_buf pointer,
> -	 * and that is invariant as long as a userspace gem handle exists.
> -	 * Closing the handle will clean out the cache anyway, so we don't leak.
> -	 */
> -	if (ret < 0) {
> -		goto fail_put_dmabuf;
> -	} else {
> -		*prime_fd = ret;
> -		ret = 0;
> +	if (ret) {
> +		dma_buf_put(dmabuf);
> +		dmabuf = ERR_PTR(ret);
>   	}
> -
> -	goto out;
> -
> -fail_put_dmabuf:
> -	dma_buf_put(dmabuf);
>   out:
>   	drm_gem_object_put(obj);
>   out_unlock:
>   	mutex_unlock(&file_priv->prime.lock);
> +	return dmabuf;
> +}
> +EXPORT_SYMBOL(drm_gem_prime_handle_to_dmabuf);
>   
> -	return ret;
> +/**
> + * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
> + * @dev: dev to export the buffer from
> + * @file_priv: drm file-private structure
> + * @handle: buffer handle to export
> + * @flags: flags like DRM_CLOEXEC
> + * @prime_fd: pointer to storage for the fd id of the create dma-buf
> + *
> + * This is the PRIME export function which must be used mandatorily by GEM
> + * drivers to ensure correct lifetime management of the underlying GEM object.
> + * The actual exporting from GEM object to a dma-buf is done through the
> + * &drm_gem_object_funcs.export callback.
> + */
> +int drm_gem_prime_handle_to_fd(struct drm_device *dev,
> +			       struct drm_file *file_priv, uint32_t handle,
> +			       uint32_t flags,
> +			       int *prime_fd)
> +{
> +	struct dma_buf *dmabuf;
> +	int fd = get_unused_fd_flags(flags);
> +
> +	if (fd < 0)
> +		return fd;
> +
> +	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	fd_install(fd, dmabuf->file);
> +	*prime_fd = fd;
> +	return 0;
>   }
>   EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
>   
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index 2a1d01e5b56b..fa085c44d4ca 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -69,6 +69,9 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
>   
>   int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>   			       struct drm_file *file_priv, int prime_fd, uint32_t *handle);
> +struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
> +			       struct drm_file *file_priv, uint32_t handle,
> +			       uint32_t flags);
>   int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   			       struct drm_file *file_priv, uint32_t handle, uint32_t flags,
>   			       int *prime_fd);


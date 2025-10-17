Return-Path: <linux-fsdevel+bounces-64471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1EDBE8402
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48C3E4E7414
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F943321DB;
	Fri, 17 Oct 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="lIkG/ehU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79583321A1;
	Fri, 17 Oct 2025 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760699315; cv=fail; b=Z+TBiUzEAhqnAPZj++VYGKYIe1NX6eK4iwq9CVkhAMSpNfL4kvD8+KhWTIizgzQFGyX1tBXeYysd/JQTfZC0KS753OmAIsK1kz8U/ecBwUGJYOd/E0T1xV5ObO8TaTQHNQTEcMaI+FP4XI5bPMdTSGN4M/NxBzLy0cBwmnVwLbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760699315; c=relaxed/simple;
	bh=0fjTU61JZs30PW0/jLaKvgzXZIzNrkneX6MElunI+IY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IIbqrfA+4dRwkeAl00ilM1mTKyB+8PVJZjKbLdKE5Ao+jslc43pzAej0v0JMi3LzM5R2wYm+/VqEazZDm92r+It8xWNH8eB5lgZF62IaTSle0QSvkQ8uFrO+iiD9BC+NMJXgqDzRF7zXke+2Vogskb9Qto9EphXfe2lfGm6mv7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=none smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=lIkG/ehU; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhPZ5I96OBp9ved34BdkDlyIB1wde4txK5BvkXglwzcjnjbXh/lyS7vlPyoQxFf25HYq/ndYfEHvjLZBeW0bfup5EwJtS2v/ptTY8qNVc1dTK/IExn+qMLruDDZCqGmYG+zeCgDpJ/zCRyJSmSMf6rIWqHIsVNMPV+PIXmcqpVCigm/pDCntytDShTRH/nM/4loqbIW0PypWpwpe3UPEGNUbw/NkegcGgfkBYOYckLkixyzcX+b52TOX82p/By0Ri6V/bGqJdxW/BRNrCqkeBYyjccrdVlmD/YGuW2kr5s56PHkEMkJUd1zCZaZMrKZQJEi9Y2r9wBP6QDhhNBUfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flaioFGGLRITp6YlwyC7arKkUabJsWgtkcQzqeCnzVA=;
 b=yACdDpAR1004GwHFHhikhKJtNxWpYXr1uK6Fr+3JvkwuQgBkkB+EnXUVIaf1xEryfxwJveHjtQTrA981MepGTwNMPWIdvwQ4jdc5sX3s26e5GfBEAyfCNMyk0ZDESYThWTEV7r855jI0XlG5AWJVtsBELOpxpRD+GNbht5AlIYbVqQnGkAAw38ivZxE7vr/uNF0/DD+AcwavWcRQr0tgRrPM/M/vOeJ2eLcjCN1Wvdsz+eHTV73Cn65O87AT8UZSx3bd2/jcgRyeJCIC5SIpUKdrjtK5RC15RwYHexZD0yQj4mGefhs7Xu70g8OXMpUrX1jZymL0XQ6GJWoGQAl9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flaioFGGLRITp6YlwyC7arKkUabJsWgtkcQzqeCnzVA=;
 b=lIkG/ehUkV1cjvtRI1eo/Bo9rwjdLrPr8aG6fBNflVMYRBCACWFovcREZ2tajfbCaR+VUvgm1o3ztcSb4piTlp2cvbTs+ibn//8trp2cB2ciJ5Av7ejg4mV3704xB8AetuJNs0/5Qk7i964YrVikLprqw52bsgwYYaohZgVYAFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from DM4PR03MB7015.namprd03.prod.outlook.com (2603:10b6:8:42::8) by
 MN6PR03MB7597.namprd03.prod.outlook.com (2603:10b6:208:4f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 11:08:31 +0000
Received: from DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9]) by DM4PR03MB7015.namprd03.prod.outlook.com
 ([fe80::e21:7aa4:b1ef:a1f9%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 11:08:31 +0000
Message-ID: <adba2f37-85fc-45fa-b93b-9b86ab3493f3@citrix.com>
Date: Fri, 17 Oct 2025 12:08:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper@citrix.com>
In-Reply-To: <20251017093030.253004391@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0437.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::17) To DM4PR03MB7015.namprd03.prod.outlook.com
 (2603:10b6:8:42::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB7015:EE_|MN6PR03MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b755d4d-b1a5-4d57-ba2f-08de0d6d819d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk0yeU9ic2lFNDJoZkZNeGM1T2RWRnVFM2U0S2NnbU52ell1WVhUQjN2dTFx?=
 =?utf-8?B?RDZyWkljdjhkTkJpTFl5OTdTenhLckUrbElyanNVU1lETmxwclA1M1ZldUh0?=
 =?utf-8?B?VVhLSS93OS9ZYThXaWZCSlV3eHpyMlNEa3dFRG00ZXBLTU5yMWlscHQxRTdC?=
 =?utf-8?B?UFhrRExBQm1UbUVMemxZSXgrKzZoL3hBM3B1MUpjRXNpOS9LSUZaMnIwMHhK?=
 =?utf-8?B?N1d2N1c4cnlXOG1YeU9YWXJMalVQUjdkQW5pblF3YzhjSmROSS90NFVoQTJW?=
 =?utf-8?B?VWl5Tm9hazNXSnRsb1FqTEVmcHlRZGowWHpMMHRNams0Z1hlbXVHb0RvZ3Vm?=
 =?utf-8?B?L2w4RzFkUURuemtwbUdTRithZ0Y4MDUyc01mSWI4aHJXblREMWpFVnhva3NI?=
 =?utf-8?B?RG1lTHNDZnBLYTNFelZLZ3Nnb1IrRWcvb2Z0dWZhZzg1UDNlaG5ibG9RU3ho?=
 =?utf-8?B?K1JVUk0wdmVBK1ZadFM4LzNyTVBESEpVWlI1TTVYdFhaOENZZFZreGRsUEl0?=
 =?utf-8?B?d3hQbTIwdXhkRCtuOUlhei94U05WOVZzTHpVWFA4RGRrM2VMQmpYdE1PbFBw?=
 =?utf-8?B?KzNhbGRieUJmQ3BLa2MwZ0VSTUFkKzJoUURkajBUZENIWTdXNmZhRjkzVWVh?=
 =?utf-8?B?UE55TzQ1UGhYK2pPZVliUlI1dWh2S3M3cFBRNm0vQ2FnOEEwRFRCcGNmZVd5?=
 =?utf-8?B?QU83Qmx2dnh3bjYyVEQ4eWdDcFUweDkxdnFEV25jZldDRGwwSDFoLzNuZTJR?=
 =?utf-8?B?QjlrV2pFNWkwYlNPMVVvbGpGYmx3K2hsOEJLbUQ0ckY0VHk1bnZZWUpYOXhG?=
 =?utf-8?B?Vlg2VkpleUVIbDNlWURNRTVEaGdydjNQODcyQXdudHB5aDBnM3QzQ05Ka1p6?=
 =?utf-8?B?OHlZNHptcWJlVmVsaHRJSGljYnl2K1RVYklxOU14TWd5eXFWWENRMUdvYnRT?=
 =?utf-8?B?YkkwdHhlNGwrMFVwSytJc1BQak5FUzhtWVpMWTl4SWZZWGRiTGZxZnZoekRo?=
 =?utf-8?B?M1hiNFE5cWhJNGhXUldGY0NKdXJkRENaWVVEeFJmd3FjVDNYWUdKV29tYkFB?=
 =?utf-8?B?TjVTY0d3M3NCcnluUXFMWWJXTjU4UTNSeTZwdzdpaWpSc0RqR2s2WGx5b0cx?=
 =?utf-8?B?Zktkbi9QNFhXVWhhU1AyWkI3dk9CNTFUcFUxcmJFdnh2OGpQbkVObGZ2OGNm?=
 =?utf-8?B?bHNuaHpndGpPU0dRbEZsUmQ3cmZ0K2xwOWRyQVJIWm1qaWIwSmlVN21QVmtG?=
 =?utf-8?B?ZDRlakQ0YlNNNzdpWXFWSE16cm1tWHlQUEZHblc5ZUx3T0R5VmRQbU1tOFlQ?=
 =?utf-8?B?Q0lLMXZNMGRyQnNIZ2NYWTkyN1N5MUFnOEdXWkZkdStlZzNKM2xMazNETmRN?=
 =?utf-8?B?NDd6YmNTOGJXckVuVFEyWXRIbmwyajlMK0R3NGJXVXdQREZUU0lsMVE4bElC?=
 =?utf-8?B?bWh0eUkwWE1iUVdBM3lpVXZFdTdMb1RuWUp3NHFNeDFCU2RHc05UQk8yQVFq?=
 =?utf-8?B?K0NMd2F0K2YyQngxbXNNRjBhYVBrWFBud05WclJQQWFvMjI4WUY5RkNPVlRy?=
 =?utf-8?B?UzA2aG5CeUROY2REa256ZDFheEJhN1NncnZBQTgvNjZHT2RCT3h5Qkx0clpF?=
 =?utf-8?B?Tm1heXRYSDFobVhWczFxbnVtT1pOT3daSkxCbEVKdVNNK2FBdnFoaTFYSGx2?=
 =?utf-8?B?MURXSXFkaW1hRTVFaUw1UzJ5S3RTeUZvd05QSW5GYlM0TEpjQmxwVFlVaXd5?=
 =?utf-8?B?RkEvdkwxNS81VUI4VlVoK3I1WlNzVm9QSVl0MFhGdU1pNUNLanJwTC9jblhO?=
 =?utf-8?B?dEpVZEc1ZnZoWHJsN0NTRlBZZ00vcWZMZjcwdW1Xa2hxdkNRTzdnbTZMVHRh?=
 =?utf-8?B?RUQ5cGZjVUsrQ3VRWkM0bWVRSnlRL2MxUEJ6YnN0T1NZVy9QMmNLSCsrdUJC?=
 =?utf-8?Q?8Qvis0ZlTqZYLk1Jibi1yUaO5pAlwqm+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB7015.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmxtOFZXeHV6eXk4N0xmeDNBR1RjT3JsUmt3WXNyTGxvckFWaVpFdTAwODF5?=
 =?utf-8?B?Z0hWYW9pYk5zbjNDUEJLSkpHYnR6YkZNWnliT1VSSVZrd2NjWFhyUWl4RkNi?=
 =?utf-8?B?QUZBWEpnNnBpRjZBVEhxdlZ1RnJvVENOcWJhdndmalJWT2M0TXlIUnljS2Uy?=
 =?utf-8?B?K2VnWnNDTUVRYmRzeGhvRTVReUlIdGs5bEdoaEVWZ0hOWTY0eWhsQ1YyN09x?=
 =?utf-8?B?QjRKYVFHdXV5STkvdXpBRGVGTm1mWFNIeTR2R3Y0R1NXSlRWR1V1dEUyaUY4?=
 =?utf-8?B?ZGFpS1o0UXBMcU9FUE5ocjVHT1dISjl1T3B0OGxYL3dNNlU3VUpXN3ZWT1FW?=
 =?utf-8?B?S3NIc2dFUlpPWHlDWjlXdGRjTWtrNEdQRUdUSnZIRlNCSlZ6SmtSdGNnd0U2?=
 =?utf-8?B?UXNTVTk1YmY3WS9GWCtzMklzaVRhTnA4a2R6bzlkeS9RSWhzNWZWTm9GeFdz?=
 =?utf-8?B?bUpwMmszR0MydjFUWTRobGhMRWFTZlpEL1hzM1ZUa3IxL0ltcndtYjhManpU?=
 =?utf-8?B?RWg5bGxrYmJOVzZkNnpNaEFieWo2bFM1bGZVTCtmTlNIU0wvR0Fpbm9iVm1B?=
 =?utf-8?B?MG15ejRMQ2FOajlIOTJPR1E0VW1xN1RiQXRQRnhFbTM3M2hBbGJ2TUNiOFdn?=
 =?utf-8?B?YllvY1hoZ05uNFlXUEd4bVZkQUpwaU8rN3hOVG5xVVAxQXZwSXhPL2NEZm0v?=
 =?utf-8?B?NVRRRmU2anVQRnlhT1lWZUZmQks5aWk4WDhteEJscmM5Q1pzMTVPdGc5WWtQ?=
 =?utf-8?B?RU9PUjlQdVhGUWwwQW5FVkE2K0dENnhGOEtFbGdzWk8xYmhkYVhqV2NUY2Q2?=
 =?utf-8?B?Y1VpZU12d3JBdktnNDh5ZVptSi85M3krSExXbnNaN05JTVZaZHhnaXRvNlVG?=
 =?utf-8?B?YWVEYVRpMThyNW5uWUQrS05qNGxYMitGZU1Vb2dXNTROTmRPY0l2TGZIUEhQ?=
 =?utf-8?B?eGdJanpCdzIrOGlWNGxaWVZzbUFHbjUrVW8xOGRwSHdWeXRCSzl3MFlNTTVv?=
 =?utf-8?B?blRmcTducnZrdy91eHV2SlgwaGlzbVNqMkNoVU1jWlNLT1ZRVkd2Nm1KT2pQ?=
 =?utf-8?B?bjB3Y1BzbzVJZ0l3c3R3dE5sS2tMTmNTWDVjeWIwSEcvNlc1czJhaHR4bE5F?=
 =?utf-8?B?dHRWU0E3L2s2V0tSVW9VRDJEOEZRYXRHSXFoSnBvMi9hN2I1ZVRocGJLbzIz?=
 =?utf-8?B?OVhZV3huMnJYdWFZY2t2dVh2QzZ0UkhBY0xBWmFzQ3VBaWt5SUtZTUs0cXQ4?=
 =?utf-8?B?MmZ2OHEyOWtRVFFBZDIrTmo2bUQ4Y1p6clpWWUY2OTZDRFdGWGFlcDdTc2pG?=
 =?utf-8?B?Nk9tWkRIeitPdUlnVDFHQTM2QklsNXJhTUk5QTJ4QnZmYXZKRUtQeUNYcGhy?=
 =?utf-8?B?a1pKYjRPQ3k0aHc2MldmVnFmOW9ySlhVUmg0REExWnVXK21pNnhrNTBPaWFo?=
 =?utf-8?B?ejUvOFc3TmpGU2pzUjVadlU2SFhPUlJhL3ZBQnVWYktPYlg4TXhpMzdYTjdj?=
 =?utf-8?B?T1dLT0txNzdzdmlUREJGdDdDaHBtRmw2bytCekhZYU5jTzFrQ0VMcXJjNzdH?=
 =?utf-8?B?TzZZVHJ5SjEzdGpnZlpEL3FjNUZhVGRneXdMZW8rcGtSV2o1VEVrT3lBbzcw?=
 =?utf-8?B?REZhQktadUxhdHQ2N3Y2anE0ZGNlNFBMUnhyWWtkQmloVGlVZUpQaURqcVVB?=
 =?utf-8?B?bDllZ2tKZGNlYjU4Sm9hVTlWNFlxbmtMZHNrRVphOTJwd1JwSGdGUDRseGtX?=
 =?utf-8?B?TklhaC91VlZjeHExdStOcUIzck9NTXY1Snd0NVdhZlREWDczTkUyek5zUjY3?=
 =?utf-8?B?WGhUMnozQW9NbHRyNXBqdWNORjIvUmY1WHBrdFJDdU1UUm51ZERsRUJacDRW?=
 =?utf-8?B?ZUNWbm93bUt1RWtnbndOS205NzdHVncvY00vR2ZmM0tIakIvcFFZejQ2Q0RP?=
 =?utf-8?B?V0dOeE5CVmJJTklHUVQ0UUJwdEFmd0RxTFVnNFY0aU1weGZOUDUyaTcvTmlC?=
 =?utf-8?B?YjN5MEkwZG1taWJ5OHlZZ3cyVVRFdFhvT3FTSEx6ODdpY2k5OUNiUWMrUjh3?=
 =?utf-8?B?OEhFMGd0R2tpN3ZEWEtIeitpL1JvdlprUDFnQ0RQVUpIaEdwTldqTTN2VnEw?=
 =?utf-8?B?a25ueFl4L3M0R1hKZlNlTHBYTkZCWDdsa0hya2hiNlpDL3VOd2MwUmFxeUhV?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b755d4d-b1a5-4d57-ba2f-08de0d6d819d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB7015.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 11:08:31.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGRGZJUUkXn+NWSng3vx1fqf75cW3qGfT8mys30BgvHntJB1sOVS7kOvh0DytOuI34g7pkl+dbUH8gckv4Hz0CZgyD0O1oon8OcLa8SXIPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7597

On 17/10/2025 11:09 am, Thomas Gleixner wrote:
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> +#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\
> +for (bool ____stop = false; !____stop; ____stop = true)						\
> +	for (typeof((_uptr)) _tmpptr = __scoped_user_access_begin(_mode, _uptr, _size, _elbl);	\
> +	     !____stop; ____stop = true)							\
> +		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;		\
> +		     ____stop = true)					\
> +			/* Force modified pointer usage within the scope */			\
> +			for (const typeof((_uptr)) _uptr = _tmpptr; !____stop; ____stop = true)	\
> +				if (1)
> +

Truly a thing of beauty.  At least the end user experience is nice.

One thing to be aware of is that:

    scoped_masked_user_rw_access(ptr, efault) {
        unsafe_get_user(rval, &ptr->rval, efault);
        unsafe_put_user(wval, &ptr->wval, efault);
    } else {
        // unreachable
    }

will compile.  Instead, I think you want the final line of the macro to
be "if (0) {} else" to prevent this.


While we're on the subject, can we find some C standards people to lobby.

C2Y has a proposal to introduce "if (int foo =" syntax to generalise the
for() loop special case.  Can we please see about fixing the restriction
of only allowing a single type per loop?   This example could be a
single loop if it weren't for that restriction.

Thanks,

~Andrew


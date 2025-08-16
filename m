Return-Path: <linux-fsdevel+bounces-58070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C25B28ABC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 07:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FEC3BF36D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 05:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DC1F4625;
	Sat, 16 Aug 2025 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="a4WfHF6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE31F0E58;
	Sat, 16 Aug 2025 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755323578; cv=fail; b=bZenOIkO56mrIeYH7W0s8b1oRoH4msPTcH1wtQmh6L1ndqycrd+a1y9K+W+bluc+iBQtbYesIMhXwanDvU0cJxdGijdTIlsdxvmg/9abUZdWomQLnRqZWHMCCUlw33QYY+F6EtL8F7cpikDF2zCUNKtqXt8MssKxKnLkF/bcA1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755323578; c=relaxed/simple;
	bh=ONKNT2EeM0wOmEPOWLF+b6og0ZVXuSoMNRfBgIqMXiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htHFbYE9VqSGZ5A5YWQJ0/BlGX1DZpjb3hYft9BvR/PFgbiTPzzaf6joT0fASK8HhTknJWZiQ9auR0VegGz9xiEUbKxoykPf78XhImC6BnXDcDalHPPn9sn3ovXUKdbC95xlAu32KJkTEonpEiRJZ3CIEgG0IROHpwrr8rvomHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=a4WfHF6/; arc=fail smtp.client-ip=40.107.130.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpRURBJ2+QNrZ3U3OvnwG8D1qMRbn6dVYv4ZZm69K/iroXc0+71cNBP0V2NEbtkq3DIs3rtR0tMrkwj+eaB0YmupX+QXDzxBTKe3qWRGg7MK9637D2nyZaz+BcC9tYciskw0TvhcZaMOxGQKmyyeLPDVk64LUKXwJWeCu+bqzWJ6Rqt1X+TTqSe/GOcdlAMfV8MHyxeRF2+BUVp0IcRMlLlPZwUkYEYVLFXVWp5VnH/s7kHJ0eNOMa1HFE+EIewdajmlr0i7/xo0ZhEtCqjQDrU7xB6tTXA9631t0P8OYsSnrdoVj5XwFXxyThQXmnmqICbLYmh+rMvFED6Kes0nXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3N8CJDssW1rKYrjEHxPhTl/U69AKDCQllW/UhzNBERI=;
 b=m8hYSHjqOid35QTn/NVgYNaxMm024XHIx+fAPRszpnP7l4XN+/AKYdzAGDSxzKeeodWnqUXM/jO81J4WDFMW7QZai2tiTV36fRW3KU5rFb0Q8mvZuSz6bVGLH1Y5ac17D01flR73VwG2AzkrTUkC/ZjeWvJNQ4fILxPJUMxXxt/WCZ81j6xhpEx7kRdSEI8nEsdbB0W/v3uwHmzEktDy9YcbBnT2UZYu+iGIQRpJ14UJKugBZIKwJRJ6LJN4FSSa+ulXobFmJxJ/f9ZKMUZqaqAtv/DIk/Li6YrpKd85pJWZAu84E8JLjbYBNI08+WBHQsX+BgQ6zsjT1AkTEY1D6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3N8CJDssW1rKYrjEHxPhTl/U69AKDCQllW/UhzNBERI=;
 b=a4WfHF6/xEoGQDuynlT74WEeXRCRjy+iuWs9JxeYw5L7Yj/a50XZ+z0LNsPCzXcFA6b7DqAufei0t+OcE/YaMG0fhNMJvXBzq4I+3fMDssGl0AzZtQgSnA6WbI3b8v7+gbTW6t/lzzDM+lZdo8FoxlVUoS/K55ttIloy6ulMrS9+CPhU2lUKGncArwjRj0nja6g5/lNEMBqxGD/aOPi8abKOEjYfUu1rpKGCseXpKzyPxQZYKd2odWfuJSJUrh8nMV+dJsWb3rrGXQ+WpOMfQNrs7q1XgoL3GJWsIxSnPvf9rMM817oQN1wU/F2vRwXoLlDVF1Qfuq+pFhGQBLoq4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 05:52:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 05:52:52 +0000
Message-ID: <8f53c544-fd4a-4526-957f-9264a36aead6@siemens.com>
Date: Sat, 16 Aug 2025 07:52:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/4] kernfs: remove iattr_mutex
To: Christian Brauner <brauner@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz,
 kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
 gregkh@linuxfoundation.org, tj@kernel.org, daan.j.demeyer@gmail.com,
 Will McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, kernel-team@android.com
References: <20250623063854.1896364-1-song@kernel.org>
 <20250623063854.1896364-2-song@kernel.org>
 <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>
 <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a52617-54fe-4445-eb69-08dddc892385
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXREQnpNUEdabHRaOFBTdldUOTRwYVRQTTRjdW5CU3hnQWdkZGM5eko4OUlT?=
 =?utf-8?B?UFhGaUdtTHNhRGRWaVFKbWxYSUd5aUQ0WFdPN1NEK2NUU2ozcGo5Wm5NQ2M2?=
 =?utf-8?B?WFJJSzNtc2picDdHeW1CdXo3RCszTUlxYlNKdzcyTGxwS1p1OVJpNnJKOXgz?=
 =?utf-8?B?R2tQZk14OVV1b1hoQlNtWDJmQkc5aUxHcUt6YW5JUURYTzNUVG9QQTlvanlE?=
 =?utf-8?B?QjEvYjZlK3RWQjFYNWlqaUJ1T2dldDNUQnRzaDN6aWhFdlY1eXdCWWo1Qysr?=
 =?utf-8?B?cWJvUkhYSlVlS0VzUEsydVNrZHo3MGgvK3hNMjJQK3YrdnRJOFpxS2xobTFS?=
 =?utf-8?B?V0x0SVJOWTBsUE1DVjUrU25TUUtNWmpXVTF0bFZXRnIzWVVrcFhjazFOZS9o?=
 =?utf-8?B?Y3FBbHZHUE5vOTRkVDExZS9zMzBtQ3ZKQVVuNVNBa2dianFrLzYxejkrQjZG?=
 =?utf-8?B?SXNWUTArdmJ6R1dycVBLdUVxRWtIOGpYYzVSZ0p4KzNnNnErenhiaitNVll6?=
 =?utf-8?B?bThqMHMyY1lxUXV1K0hCR2ZUTzlwbUxHWFhOV2NLMWVZL0JYdjdQZVJ2eWxt?=
 =?utf-8?B?akgveE9GU2ZIL0NBclFGKzViT1FocHBuMXFOdEo5aTFVSGtLZk94b1lTYXJW?=
 =?utf-8?B?aWtRNWtrUHA5bGthdmJCeEltVm8zUW80di9EYzdrV1JSa0F5K2VKSHFEQ3Q4?=
 =?utf-8?B?OW1vQ01GNlgrRTJqdWFicnB0RnZmeG80cVFheG02SXFtUEljVGMyUkJlcFBK?=
 =?utf-8?B?YTVUYnNnV0tmZC9lV2VGS3EySktqVmxnWVZGVnpjeWlZL2lOQ2h2N0NBYXE2?=
 =?utf-8?B?NFdESTRWcVMxZzM5d3VBeVBrT3V2MDFWS0pVemU2VWFWSk9LeURRTHZaNVlt?=
 =?utf-8?B?VlVPaG56QjFhVmNUaFdKUmtvUjFMeEJINzdOeFBXL2NTbWVldnhKVGJ5T3Zy?=
 =?utf-8?B?WU5ucnUxQzFtdFlIT1NLdXRXeEx3WWpycmdKcS9WOTJWRFk2RWJ0ajM2RG5R?=
 =?utf-8?B?SmR0NEVxS25rNmt6dXFkanBUV0dYTjR2YmlUclN0WUNWRXJkNVgwSGVOaXBE?=
 =?utf-8?B?ZlBiTW85WkVha0Jid2VvTy9BT2JiczZxKzcwb3UrSXlxT2dCcWVvVTZEQS9D?=
 =?utf-8?B?V1BZUE5VWGpTbVhGUFJObFk4b1hHUVJaVGw3YkRIbmwzRFhsSDB3YlZYK1U3?=
 =?utf-8?B?T2JUem16bm9VOU1wWVg3Ri9EOWlDSzRzUFJZZHBCc3VGekVIV2V1dTd0U1Y3?=
 =?utf-8?B?RnMwVmdmb3B2UmQvSFE3NDhWWUQvcGt1YnJhNHY2UWllcEtSNmhVa1NxWlJF?=
 =?utf-8?B?M1htMDJRN3hiZE1QeG9XSlB3UllYQ1ppVGt1Yjk4N0pBcmZVYXYrQWFOS3ho?=
 =?utf-8?B?WmZtMVA3UzRvRzlwdDJUbnFtUjg0SmNXcU5rd2dlNlQxRnZUYkY1Tm1zMDNx?=
 =?utf-8?B?OEhWNlNoL0dPU2g4WGYxcXk2UEhsT082NHBoS1hFVTFvVzZuYkNabDFFMEMv?=
 =?utf-8?B?QjlkQ2pQdk0raGpmd2JiQ0pBK0QwTjVCSEZsTmxLM3UzV2JJOEE2WHRLTy9B?=
 =?utf-8?B?Q0RvakVacGNPNmY4UytZWkZqQ1FYWm5HR1A0Wkc0V0xrMlE1cENaWW8wM05T?=
 =?utf-8?B?ZnR0Sk1sRHh4akRTTWRwS3BTRzhYMzEvdmtoUzF2cTZ3d1VsT3Z5L0doVDlS?=
 =?utf-8?B?SFhVZiswSHkwNTMraHAwM1Z5aEROWlkxSzVIclg0RWRRL1hZMmRRVUxGR3p5?=
 =?utf-8?B?eitsMEF0SWJLMHZKVVBlUEpUbTZodDF0VWdHOTNqUXJ1cHJyMHFqdnoyOWVZ?=
 =?utf-8?B?WFh5WkVoTUF4dmR5SVJMc1dydlFJRlBoUjhQSlR0c2FZVmF3c3RGVlY5M2FM?=
 =?utf-8?B?NnUrWU5DVUhwZjRKY2lmajBlSnFuL3FGNzZDQ0ZYQXd2ZzJnL2dST01tbERW?=
 =?utf-8?Q?R39703aOahM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnl1ZFZNR01LZC8yUE0rQW1uWmlUa282am5iRlFsL240RWR2czIrM1RlL0xY?=
 =?utf-8?B?Y3p4RHorRXNhdFZJOXVJWC9tVGV1MDRhUzFWMVhRWSt6T3BCdUNZREJWN202?=
 =?utf-8?B?K1lGTW5kRVprZ2IrMnMwTml6MmtJSkhJeHhuSUFFOEs4dThROFo3WW0vS1N2?=
 =?utf-8?B?eHo5dmZHTlBzSmhMUXJjYS9rNXd2K3JaZ3UvT3FCWGovRDgzalZkeUF6MmEz?=
 =?utf-8?B?RTZlK1duclFjTzVjSy9yMDZUK1hJT2U2UGMyQjJ4OHJYZW9jVnJHTmRsUE5K?=
 =?utf-8?B?bG9aYjgxVEI2R0tIS3pxOG5FdjFwT3RqWG03aGdadzhEaWFsbTNKbzFYVXM4?=
 =?utf-8?B?N3lIandlQVpsY2s0c3J5alZBdkFML0p0a0QzMC96c21EZU0wVWZpZWZBUjBC?=
 =?utf-8?B?UWdtRldURWQ4N2xQUU94NVdOcTIyL1ZpQXRtR0hlOWNlUzZCZkFUNnFPSlc5?=
 =?utf-8?B?LzJ6dEZkSVFUaVRhaEwzazJkeTVVb2s1Sm1RWUQwTld3eGJ4RWdwb2JlTERY?=
 =?utf-8?B?QlRObWwxdmwyTU5taHZib1YrUk80ZE1La1NmODV0R2t3eEhXSG1vTGEzQ0Fm?=
 =?utf-8?B?ZFEvcjR5OVE3ZFFTNnJzSTJLbXR0dkhpRHBQMExSYTcxTEx2YkhWRTMzeWVy?=
 =?utf-8?B?QVJQeEJYM3VYT3luQkxSV1VyL2R5SFg4TEdvVnhiMkRvZVJ6SHA3MHBISDVz?=
 =?utf-8?B?L3pQVlcwTHBNVERFdnU5OHFwaWE4S3hEU24rRTZxMUZBMnlJd1g3VjZrTTND?=
 =?utf-8?B?dlJNWmRIeHlDZXRyb2RoVFFsUnlmQTlqM1RMRHpJaWllYVdFNXdLdHlEYkNr?=
 =?utf-8?B?USt2TUtZL1doVzNBaDNMdE00OTRmeU9RcHJYQlZSaXJDYzVXRk52cmZFNG5i?=
 =?utf-8?B?QnFoUEVjbk9WQ3hEOHM1OXlZRTR1ZXkvekdvc2pDUWIvb2kxMlpyZlQ0NUpC?=
 =?utf-8?B?REcyQ1FQQ3hFckhLMTdWWEdoaTFoMDJ6SURTYnMzVWVWeHFqazJmaEpGOTJw?=
 =?utf-8?B?WWJnVDBqZVljTXhYQjVVSWlhRGhVVENiUXYrRzNtZHVmNjN6Tmh4bmZxZ3pG?=
 =?utf-8?B?aXpjYUVpdWoxZnY4NWgrNW53YnBSa0p3NXkvOHJ1SVc5dlIrdGVBdU5JcWFI?=
 =?utf-8?B?RTlIOTlZejBqWERNQ1pjMHdtdFNWQ2Uyd21FUUxKMm1qWTRNOVljcHRNV0lS?=
 =?utf-8?B?ZFVUbW9Bd2drcncxRXhCZWsvbUhvZXM4N0RnK0RJOUhCcW9MS0NGU1ZueUIw?=
 =?utf-8?B?Y3c0V2xRNG5wWDZrOXJtS3Z0OHlkSnJYNU1PRDkzT3BSNTRLclRGeEFpbU1K?=
 =?utf-8?B?bHNXNDNmZzN5OHowa2YzMDNpV0U0WFdXN2FWV0NqS1hDcFBjMDBSa24yaE9m?=
 =?utf-8?B?K0FvRGVwR2s4bDdDRUh4MGtOYVkrVjdMME51ZnpDaFhHbzRJT0Q1eXFmaWJw?=
 =?utf-8?B?WGJWUGlSTVlYWGZoVGpJdVlKMnZHYmtqWTU0eG1ud2cyVUozNDZSRmx6UlZn?=
 =?utf-8?B?eGxzTFdiVGRMWGFXL2svTEM0NWhTVEdtNlg3eGtWWE1wWjRNbjN2ZC8vTHlw?=
 =?utf-8?B?VHlqMFZ0SVYrdGRZNDRWMitIUUlQV2VORGs1UHhSREtZTWQrREpnT3grd3hM?=
 =?utf-8?B?TkF1bWhDckJHSlBqdTE2cHlZTlVTN0crdmdZVnBXMTdndC9NY3dKay9ONnJm?=
 =?utf-8?B?NEk2eFlWWmZMY25WWC82eHRtV2ZqZGttM0crWGkza0JKd3RrUzBHRHBMRiti?=
 =?utf-8?B?Z0JiM25QZHhpYzRrRTAzVmJNNVFMNTBvamt2c0F3U2NkdmdJN3BRRGxXaEhU?=
 =?utf-8?B?dzRmVExqbzAzamVlQTNYdEVMY08yeU9JaVZPOCtsZGh4TkIwdnB0VTU2N2VI?=
 =?utf-8?B?bEk5eW80UjZCQjk2T0c1M0dWTy9wL1ZUZUQwaUNlY2NXQ0NRbGg3NTlJQWQ5?=
 =?utf-8?B?MGRTejMrYXBKdE05TldKdVVJYmpwNHFpTitjUWxtb1NreGZMd1ptVC9nSkM2?=
 =?utf-8?B?TEVKblViOGFHeXFKRFQyVHFDY2tyZFUwTVZEM1FlVGdDTTVQUVk1L0IyVmc1?=
 =?utf-8?B?bDVZYUV0azJaUy9vREIvM0Fod01MWmpxNDR2a1dvT0pwVSthMGRxeXNhZGht?=
 =?utf-8?B?Nm1raDNaanpDck1mNzlMaGowbW02TGVLYUp3bDVqdEdnQUdEYnJ5dkdscUZX?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a52617-54fe-4445-eb69-08dddc892385
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 05:52:52.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuCjKSCQbvNnDDC1X+s64Te1mJkQCDHiZErayfeo02vJ6gd9ZMt9UKdKoDjhBC1T+kEAArayQ5vv0j8vH4PASg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6237

On 02.07.25 14:17, Christian Brauner wrote:
> On Wed, Jul 02, 2025 at 11:47:58AM +0100, André Draszik wrote:
>> Hi,
>>
>> On Sun, 2025-06-22 at 23:38 -0700, Song Liu wrote:
>>> From: Christian Brauner <brauner@kernel.org>
>>>
>>> All allocations of struct kernfs_iattrs are serialized through a global
>>> mutex. Simply do a racy allocation and let the first one win. I bet most
>>> callers are under inode->i_rwsem anyway and it wouldn't be needed but
>>> let's not require that.
>>>
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Acked-by: Tejun Heo <tj@kernel.org>
>>> Signed-off-by: Song Liu <song@kernel.org>
>>
>> On next-20250701, ls -lA gives errors on /sys:
>>
>> $ ls -lA /sys/
>> ls: /sys/: No data available
>> ls: /sys/kernel: No data available
>> ls: /sys/power: No data available
>> ls: /sys/class: No data available
>> ls: /sys/devices: No data available
>> ls: /sys/dev: No data available
>> ls: /sys/hypervisor: No data available
>> ls: /sys/fs: No data available
>> ls: /sys/bus: No data available
>> ls: /sys/firmware: No data available
>> ls: /sys/block: No data available
>> ls: /sys/module: No data available
>> total 0
>> drwxr-xr-x   2 root root 0 Jan  1  1970 block
>> drwxr-xr-x  52 root root 0 Jan  1  1970 bus
>> drwxr-xr-x  88 root root 0 Jan  1  1970 class
>> drwxr-xr-x   4 root root 0 Jan  1  1970 dev
>> drwxr-xr-x  11 root root 0 Jan  1  1970 devices
>> drwxr-xr-x   3 root root 0 Jan  1  1970 firmware
>> drwxr-xr-x  10 root root 0 Jan  1  1970 fs
>> drwxr-xr-x   2 root root 0 Jul  2 09:43 hypervisor
>> drwxr-xr-x  14 root root 0 Jan  1  1970 kernel
>> drwxr-xr-x 251 root root 0 Jan  1  1970 module
>> drwxr-xr-x   3 root root 0 Jul  2 09:43 power
>>
>>
>> and my bisect is pointing to this commit. Simply reverting it also fixes
>> the errors.
>>
>>
>> Do you have any suggestions?
> 
> Yes, apparently the xattr selftest don't cover sysfs/kernfs. The issue
> is that the commit changed listxattr() to skip allocation of the xattr
> header and instead just returned ENODATA. We should just allocate like
> before tested just now:
> 
> user1@localhost:~$ sudo ls -al /sys/kernel/
> total 0
> drwxr-xr-x  17 root root    0 Jul  2 13:41 .
> dr-xr-xr-x  12 root root    0 Jul  2 13:41 ..
> -r--r--r--   1 root root 4096 Jul  2 13:41 address_bits
> drwxr-xr-x   3 root root    0 Jul  2 13:41 boot_params
> drwxr-xr-x   2 root root    0 Jul  2 13:41 btf
> drwxr-xr-x   2 root root    0 Jul  2 13:41 cgroup
> drwxr-xr-x   2 root root    0 Jul  2 13:41 config
> -r--r--r--   1 root root 4096 Jul  2 13:41 cpu_byteorder
> -r--r--r--   1 root root 4096 Jul  2 13:41 crash_elfcorehdr_size
> drwx------  34 root root    0 Jul  2 13:41 debug
> -r--r--r--   1 root root 4096 Jul  2 13:41 fscaps
> -r--r--r--   1 root root 4096 Jul  2 13:41 hardlockup_count
> drwxr-xr-x   2 root root    0 Jul  2 13:41 iommu_groups
> drwxr-xr-x 344 root root    0 Jul  2 13:41 irq
> -r--r--r--   1 root root 4096 Jul  2 13:41 kexec_crash_loaded
> -rw-r--r--   1 root root 4096 Jul  2 13:41 kexec_crash_size
> -r--r--r--   1 root root 4096 Jul  2 13:41 kexec_loaded
> drwxr-xr-x   9 root root    0 Jul  2 13:41 mm
> -r--r--r--   1 root root   84 Jul  2 13:41 notes
> -r--r--r--   1 root root 4096 Jul  2 13:41 oops_count
> -rw-r--r--   1 root root 4096 Jul  2 13:41 profiling
> -rw-r--r--   1 root root 4096 Jul  2 13:41 rcu_expedited
> -rw-r--r--   1 root root 4096 Jul  2 13:41 rcu_normal
> -r--r--r--   1 root root 4096 Jul  2 13:41 rcu_stall_count
> drwxr-xr-x   2 root root    0 Jul  2 13:41 reboot
> drwxr-xr-x   2 root root    0 Jul  2 13:41 sched_ext
> drwxr-xr-x   4 root root    0 Jul  2 13:41 security
> drwxr-xr-x 190 root root    0 Jul  2 13:41 slab
> -r--r--r--   1 root root 4096 Jul  2 13:41 softlockup_count
> drwxr-xr-x   2 root root    0 Jul  2 13:41 software_nodes
> drwxr-xr-x   4 root root    0 Jul  2 13:41 sunrpc
> drwxr-xr-x   6 root root    0 Jul  2 13:41 tracing
> -r--r--r--   1 root root 4096 Jul  2 13:41 uevent_seqnum
> -r--r--r--   1 root root 4096 Jul  2 13:41 vmcoreinfo
> -r--r--r--   1 root root 4096 Jul  2 13:41 warn_count
> 
> I'm folding:
> 
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 3c293a5a21b1..457f91c412d4 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -142,9 +142,9 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
>         struct kernfs_node *kn = kernfs_dentry_node(dentry);
>         struct kernfs_iattrs *attrs;
> 
> -       attrs = kernfs_iattrs_noalloc(kn);
> +       attrs = kernfs_iattrs(kn);
>         if (!attrs)
> -               return -ENODATA;
> +               return -ENOMEM;
> 
>         return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
>  }
> 
> which brings it back to the old behavior.
> 

...but it looks like v3 was merged as-is in the end, without this fixup.
Is there some separate patch in the pipeline, or was this forgotten?

> I'm also adding a selftest for this behavior. Patch appended.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


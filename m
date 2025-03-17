Return-Path: <linux-fsdevel+bounces-44178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A6CA64530
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79CCC171353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6740A21D3E7;
	Mon, 17 Mar 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DvIpu7Ex";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="txAyyZNW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F721C9F3;
	Mon, 17 Mar 2025 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199757; cv=fail; b=uBaTT+ZZmWZqBcr+f087m15mrU4OmxkuY2you2ariHojoN4KkTxg3LLzxlGa+aWoTOyFk1UeaG5OBcWXCgMMNlV8NLw73ES7+3xPHY0a3a6a6dcvp3anDgcfci6QiuONDxcC5TPaBqSydvGf9F7+4BPxHj9LLB2LMKayFOiKxOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199757; c=relaxed/simple;
	bh=EaqJV4OOD4Rg6VkeieTmM3PDF91DV75Fsr+sHxXCKxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WnyhVOUL+zWQ55dil+RI4+g0TSTq36FltTYrhAmOZoLgYnZJW2ZUtDBcZc+Tapm4v8NwQ9SPyDDqLFj3pVTwFWpGo5VeG2MEDnkQ5UVvLsW4HTykw4836joNrgTrrCasl2VMPBOvc3NpI/DIt7xrbbotRfc/P2oZvT+M/T51K8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DvIpu7Ex; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=txAyyZNW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7Qhjw031111;
	Mon, 17 Mar 2025 08:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Rqc1ziQ2CdEIMc5P3LTW3hLAAQHcHnIWTXEL1g4aW5w=; b=
	DvIpu7ExDh49ZmkHMCcKDM4BNQBAU9gml1PqUNOMe7J8OETG92SkM5o4OL2yZSvs
	iV7ZWsXarjNYSP6AfqUUncq5t244sF1sZr8t4rHpFaNuT6CtmRtFSlwr43Nelfh2
	8A+8xHf82/Bmb0OA8PNDhVIFLL2C7dTt7XFj950oSU9yo9jBrfp6PoDK0O3tYxcR
	qJnYBEZBjcSUjhaiAPqmqj8JYSAjR4apFg9hzbt4gKzIvY0VaHtq2+KKdZagoXdZ
	eIwadgXbhiH7A6JGDiIfFYpl0hHYie85r9MKnaLB8wDrIC5qEjIrOM+Fn1oYrUs6
	v4asOqy7Vt1gpjpvn0EfQg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hft5k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 08:22:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H89fGi022372;
	Mon, 17 Mar 2025 08:22:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc3ve1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 08:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE9POUa+xEf6bV/PHKNJbX1BEbUmF9XMSIhjb4suO5AYkPKgfaG3uZxrQEr+krazyI+5JPgvY+WH+h/qTmddRjvKqaijEwrK/uii7waHNEN7Jw1VYiLtY3nS2GE2OUNJ3QjNhCPeiQr2mm7TmVtypgXrfZlQcY6EYxIcdDMtPOHUy6/s2xb1ZIFKbhi4VckH2U4tSFwaNXC9j+ET8L8Vk8eewxx7AN6PnLFYTsGj1zXo8x4KBoYRUfvkIF9Z33Iv3fZsLG3zLkMkedyYLQ7fdelAXavoBfAxmj707sZMjjztGbqdpcohH+J8cWcSGlgW7fdFrfHYdOmZs3jHeeXh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqc1ziQ2CdEIMc5P3LTW3hLAAQHcHnIWTXEL1g4aW5w=;
 b=jddI8CHYJyFuzJ7MUuGur3lIvyGEiqgNDTYrm7oVp7F6nCPYpbF5xLIVQH3qwuwsdS4twEjo7/lP5CtG5Bwn5is+HBxZUMzxnE763EZyY4HhVUR8cTaSENr77PhQMlKveV29N2JvIpH6i+oJeLqj0W4a/9MTROfNErQE/0s7jJuBOldN3DcH0nJkwg+yLbYbzMmUyvXDYnLZvIDYLyNRLyhSCP7eMzHXa8XIsJFAJLcDV+t4YzCV/k9ezoE3CGqhZAwA3QKXM787vczWH72KRELJ8di9nCtI3V0azRcDiYGxLQidtQMRB/P4qLsyKONDdcMsnlJsALLKwk3hlgZrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqc1ziQ2CdEIMc5P3LTW3hLAAQHcHnIWTXEL1g4aW5w=;
 b=txAyyZNWWEqFc6v2I6MVHEa+gQSpipqAEPpYhZUN5lqwZSUgn+etzXSMLCj8EJJW5s6+acTpFof1cQGmFosXD2frPg8my3Gpg/cdplFpwyTwj8CbNy3j195yJgAj9aqSNjSyVVXnfo4GyqU5iN10SAGZkgB0n9fG+VRY64j39v8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:22:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:22:11 +0000
Message-ID: <0ba8601e-2271-49d4-bfb7-50f4ff13baf3@oracle.com>
Date: Mon, 17 Mar 2025 08:22:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/13] iomap: comment on atomic write checks in
 iomap_dio_bio_iter()
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-3-john.g.garry@oracle.com>
 <20250317060828.GB27019@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250317060828.GB27019@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 4013963b-2045-4fd7-e9f2-08dd652cd0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHVYWUhjZUhZTWp5bE54bnNJUGZJbThpUmhHRitFcU5mVXlqNjUwWkxVQ1F3?=
 =?utf-8?B?TWljNXpQVDg1bzgvQ1lvT0EwWHFtS3h1WitjcWd1dGZiM3gxSHRwYWk2K2lj?=
 =?utf-8?B?RDhRanc0YU9IZmphclpZTWQwSkt2VUFWVDBvcU1pVW9oUXNwYW02VUhic28y?=
 =?utf-8?B?VWZyMlZCRjMzZHVuc0tqSWkrbFU4NzFySVdLWGw1ZGdxb0J6cVhNOEU2QklP?=
 =?utf-8?B?cjVSWUFnTkZZbWFBQWpPZHBBaVpIQ2tna3Z2VWl2QnpsRkVsNU9IUUU0Tlgy?=
 =?utf-8?B?V1Z4d3dlYTZWTXRvZXpvZUZIYVQrM1BwUXNpWWZuaktPVFBqWk9EZU83TnVT?=
 =?utf-8?B?UEFBTi96QStyQ2hxd04rM2V4MWpqeGlrc2ZCSHR4NlNSaGdJK1k2NjlKVUdt?=
 =?utf-8?B?TGJ0aWtKSm5nMWRHMW1EdWNlM2VIemkrQjFKbWdkaU9CVGhhTFVtdllqb0ly?=
 =?utf-8?B?UGRDd0JGc0RZcVBVRUFacksydUt6eGVkTXF2QjV1MGl3WFhtamppRDQwWTll?=
 =?utf-8?B?b1hjTXZlSTk1MGk5eFp3OVpLVlhuZ3hEMTRQQ0lLTy9mUXNYNFhTempLQlky?=
 =?utf-8?B?dFBqV2ZUZURnSEwwT1ZXeHBxU2lVVFhxSEl1REZZWiswKzFLTmVnMlZOZW44?=
 =?utf-8?B?MWxjdGw2bi92MDVNc0RYWk02ZVo2RlA4K2NKZktVYTRKeTFueEVmaDY1WVFz?=
 =?utf-8?B?NG56THBONkdSazFEN0pJaVo0T3pNUHdtcXh5T1JsMkIxTzRTZHo3REkvMkh3?=
 =?utf-8?B?MlhMYWc5Yi9HdW8vT3dlRERsSGplM1c2Y2hjejhuOVora1J4WlBodmEwMDE5?=
 =?utf-8?B?TDBOUE84SmZjbzU2NnJCY3BLQ0dwWXo2cGRZb2hLUXV0cGRrVkhMYmJmcENy?=
 =?utf-8?B?MnZLVkFON3pQU1RjR3NZWjh5eE1YNFd0VUVscFFTTWZORTN1SUtrcDdrclFi?=
 =?utf-8?B?S1cvTW01di80czgxZ1F6VklOUG5YTitxWEYzN25lbXlxMlgwMXJwMTllcVh3?=
 =?utf-8?B?dmNMbzlwMERmVE4rdXlBU01CMWxZSGRWUGZxQlBoMkVyRjJEdXN0UkxWd1dT?=
 =?utf-8?B?UTExUzBwaDEzWHE4OWVZLzVWUWdUNzNEVENSMGx4WE0xTWNCRG5BWTYzV1pN?=
 =?utf-8?B?eDVSTXlWRDRlOWhaVXdIZjRLRnpUaUgrcDZCVTFCcVFiTHVtdk5IOU5CYnk4?=
 =?utf-8?B?MGxRYlZiZk9EM3libWd5UzZ3Ry82czQ3SVBzek1PWHA0SnpMaHVLL24zYlE2?=
 =?utf-8?B?aDRzUGV4K1JNZFFNaDlXS2lQUVlROTJsVHpRa2VRQUI4ZGN3STgyakM1OGY4?=
 =?utf-8?B?ZXpwSCtpQ2pCUnBNNDZrMUo3TU9vdjI1MjBHeDVEbE1BaitidGVNT1RQeXhS?=
 =?utf-8?B?WHdlZ0liem12bEhGY2Jxc3JpVDZJeVM0d1JaanFGUVRzeWMwcXFFcjZScUto?=
 =?utf-8?B?RC9qZHovZTloSGd1bnBBQklIMlFCeW92UGJ6MUoxZmQ5bU8xOHVFeTJ1SGJu?=
 =?utf-8?B?TUFQTXRJWVl5S1RDYVN6SHBCTUtzZzFQNXNva1JQN25jTUdNbFNkNGROUlUw?=
 =?utf-8?B?QXlKSzRzVmNaN1RrSWtCUXdzSlZDNGdSZ21HUkp4b1pwWHVlVTVhdWdMaEQz?=
 =?utf-8?B?YnFkWUpmbUpyTTdvUng4dXp1cVpVTHVpWk0yNGtJSi9XR1ZkRnVHbE9iKytv?=
 =?utf-8?B?UG8rbkIzekJQSS9SVGRqTnlBRWY4WC9LbXl2Z3NjR2E3TjNGNC9wOHNlR21h?=
 =?utf-8?B?d082WXRXQnEvZ29DaGFKRzFpbnJINXgrbHl0bHdWcUlQVDc2ZFZzWTlEVnIz?=
 =?utf-8?B?RWVIcjJuN2t4azdERXlRRlFWalNqMTc0dmdjeXZ3cG82bVc2QkxLRkNad2Vm?=
 =?utf-8?Q?LMwIrgFmwVJ3v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGxiM29LWDczWGx5dEhyYWlQbDFMZ2VPeDBvMHhHbXJJQ0JVaktwb3ZXamlx?=
 =?utf-8?B?KzRYV0Yva1FCS0h1aDkyek5WSjNjb2cyZ3BXUDJYemQ5d3JlSGo0T2tFZ1U5?=
 =?utf-8?B?ZWpDSGJzelVmODFvS0diZjJFOG1PV0dIS1haNFRDWVEwc25ZOTZaMzk3REpv?=
 =?utf-8?B?SU9zdUhBb0hrenMybERzNkNtUFJBcEgyWS9sbkNNbytLQVBiZUZKTjRBN2pW?=
 =?utf-8?B?WG9nZXhCc21CdUVtL0dIdEViZ2tNVDZraGtSTjVlRW1xNWNWZnRXL2R4UElR?=
 =?utf-8?B?VHNERkFWNkxQeDdacnBlZ3c1d1pORGxMYWQ5aDR3VURUbnI5N0k5ZjBnM3l6?=
 =?utf-8?B?ei9wZStqWnNWZ0RHZlhZbzR3MnpTQkRBa2Rha0xNZjJwZVM2dnpiaHVyS1Vt?=
 =?utf-8?B?N3JBcEQvZzlydXQrZ1BTS2ZRRFkrcUdYdVBXb3BRUndPYWhxdFNhQ3R2bzQy?=
 =?utf-8?B?VWFvN25IVCtrYXZIcE1WbnFtcWxBU0g5QTNpZnVsZVdrRmRhejczR1U4Y0xT?=
 =?utf-8?B?c2ZZZHY2NklTcUE5czRvWW56V2h2RzUzeERJUlNWa3FPU2pmenJNWmF3RGRX?=
 =?utf-8?B?UkJva2pFbzVQYS9HYXdSamNKSy9GYUJZQ2FzcjZYSk8xK2NzUWlOY0ozdG1B?=
 =?utf-8?B?UWdXRzVIZzFEbGcyVE15R3V6MXhXWm12d1ZuemNQVnBNYzdOSWFiVEloMTNT?=
 =?utf-8?B?dzltc09vSXJMRndnTEZjdzF1WTVZY1ZyUTZZQWZMaFJhNmZYUzVFK2xVZnFQ?=
 =?utf-8?B?akVwK2c2RjNhc0JsUWgwR0ZKUkdVeXE4RFBNNWxkVlJLc2Q2ZCtEcDJhdzQw?=
 =?utf-8?B?VVoxN0JxL0xkMkpla2xUWFpGRmZ5a3hiR2VJVld5alRnZEExcTI1OUJGUGk5?=
 =?utf-8?B?azBxaW1kQXZRQ3ZHU0pCbGg0MXhieDVYd1d6QzBFSnNtWnZTMEpoYzRQZjI1?=
 =?utf-8?B?b0xxZDFXd20vKzJuTm5RRFdNRXA0QmQyMHVWK2FIdGs2QTJXcTBYV2JKKy9x?=
 =?utf-8?B?Z2tGMHh4dUFhZGVPRzRnMHBvR1Mvc2dTRTR0Z1dGRDA5NTgzNVpPN0I5eEhT?=
 =?utf-8?B?YVRuNmRUaE5KRDRGbEZ1QW84TkUyRTJWNnJsZkVBM2t5cG5qeTQzOEZFcitO?=
 =?utf-8?B?YjZ0bDRpVFhSZmh0UWNMVC9IdmVYc2hYc0g2cldiQzhqTHlDL2VBaDAwMTRR?=
 =?utf-8?B?RzVQMG9LZ1Y3dTBmaTB0RXlIQU0rUWE0NlROZlAvdUhQSklIZlFSaTdXeVpR?=
 =?utf-8?B?VUhQcUwwZWRlTWFFZHZzbVd4OWQ5bmphdjlvN0xzUy8xTENtbmxJT2RTMG9P?=
 =?utf-8?B?TS94cmllK3pkanFVb2xrSTFvdVBJRmtPVGVUTWxQZTA4azVSL3BKU01rVy84?=
 =?utf-8?B?REpITjRLMXpLN2p0RHlRbkZQdUNpbENJa2l6YitIZVh4N2ZqZFdFODlzUzYw?=
 =?utf-8?B?S0hXUjhYY1pCNllha1JhMVRZTUV6NWVQU2NnbGU4U1ZZZi94MHluZmE0bUVR?=
 =?utf-8?B?d1VsTk5zQVF3RFlzOTY1U0E2aFZmSUpIZmM3bnduc2RkVTRuSGdhcWpYbWtX?=
 =?utf-8?B?bGZ4dlpYUS9OTXoxWW9oRjFqQ29jQTJLUktjckhFRnUrK3hESmJ4QVc5T3hU?=
 =?utf-8?B?M29OVkJ4NHdWUHkxc3ZrclpyTmY5djEzS3VYVCtGUmNIRHJVTTByRFFXVVlW?=
 =?utf-8?B?cUxHd0JBUDRTVHdJVTRSTmZ3Yjg2SUcrcVJpUXRQWjZoeS9BTUNrRE5Fdmdj?=
 =?utf-8?B?MTdVNHMrSXhYTFNBVkVQN1pWTmo1b20ySDFHdmhXcXN2T0lXUm94WXFmZVBC?=
 =?utf-8?B?RzZPNlMyQTJQQmNCQ24xT096QTRkODNPSEtma0x4NFhZaW1TMEdnZU1IME96?=
 =?utf-8?B?REQrNTdQZkNham1sOC8zK1Q0QlRFQnE1V0I0OWNIQ2ZLSUZIRkgzOFhmZ0dy?=
 =?utf-8?B?SWdZSStHc1RBUEtzNk1wRVU3Q0haY3htMzFpdStSZWlBRjV0cUxzNGl5d2xL?=
 =?utf-8?B?RzNZaDZnMGdlem1oYVI0YkNkbDl2bkphcGx4OUNiS284WnhjVXk4UHZMekdP?=
 =?utf-8?B?WVVMaWRRUTVWUDhYVG1rUXBiK0NDdUtWcDRieTg3dVpTdmdZRE96d3J5N0Ry?=
 =?utf-8?B?MHZnRkZZOW9QK1o5SnB0V0ZHdXp1ckZRdUdQbEVvMXF0SFNTMExFTlJjb1Vo?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ISP0AOcHLFZFd07FZTW8PAPOODTt96rE+RuCaA0y4h+DYFVlmR/3eCFWG1TfdPg6lecb7vJEY31KBaxYzftZVkd86KexXTcwiq2wxtRDLk1F9+aZpuv9MzFKF/Go6STx1OHfVKJwQ1mKoPo9pTfbugyI4g6PjOERecWSquG/iLiuaOOlffphCzLR3fcMcno1X58IFDxCLZc/hgglejtPVSHcTeBWdbGmg4cAS+kttRSxDFosebMJhu1Qh9lhHxB6pXKxxdmQEWxuOobFrGd4Yop0Ns4oVYEYUOD5TnZLl0WUSSPWfqJ6kvO0JF28VJOuDwBNoKaizTA+t+eZ4m3w+wb1Z23iL7S0FGN92WcZQxuZIdmdO0dxBgHvLf1OdoIJYZEsLgoDT8KEFUCPO64XiXYNXqTdlDIANu1zmCtYRCRfh1BecLDUkN9CYlJdjzmlDCctOnDiacKnWNxIc1UOnJBOBSSZT9i3x/nbNv2RqliFSd4EOvd11AP+xj+fc6LZL290D735l7s2YcePNZGa8Zq2saxHtQN0sjD2trxsSGluHN7lsZzv2z4zFx7j916g1ipVf0yN4UNb7S9kAXe3ed/Aao7WmW6gbmDvPSg/jHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4013963b-2045-4fd7-e9f2-08dd652cd0b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:22:11.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ABPU+kAF9x1+sXWhpjGcZJo2/46oQAjjl7wjQ8JSIWsdluyF+F2udvLSXgto2sd59ricmM0mAQ9FXfvtnXZ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170060
X-Proofpoint-GUID: lNcSdsJy_ONF6opsWXrGPbVrVS7Cdk74
X-Proofpoint-ORIG-GUID: lNcSdsJy_ONF6opsWXrGPbVrVS7Cdk74

On 17/03/2025 06:08, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 05:12:59PM +0000, John Garry wrote:
>>   		if (iter->flags & IOMAP_ATOMIC_HW) {
>> +			/*
>> +			* Ensure that the mapping covers the full write length,
>> +			* otherwise we will submit multiple BIOs, which is
>> +			* disallowed.
>> +			*/
> 
> "disallowed" doesn't really explain anything, why is it disallowed?
> 
> Maybe:
> 
> 			* Ensure that the mapping covers the full write length,
> 			* otherwise it can't be submitted as a single bio,
> 			* which is required to use hardware atomics.

ok, fine.

> 



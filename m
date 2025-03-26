Return-Path: <linux-fsdevel+bounces-45094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947BFA71B20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C4D3A95B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF231F4297;
	Wed, 26 Mar 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQXwbfj+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yKnBvMRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81D3A1BA;
	Wed, 26 Mar 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004281; cv=fail; b=nEnXEyLbYJEmmxEZFcQIbwBILm4aQlde+14zfSyEB8ncAt/xoFrqj4Q7oLpDIsUbkWZyv3NuQxLYhF1p+LNil9FX6/xrTaUcF19nPMJ3/YeL8LQCqgcKjg8rHDL+Gjfvc5YCQWrVw5FsoIlaSSkddfNoUGBh77g2FlWwpOMaRCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004281; c=relaxed/simple;
	bh=5aFymzzJk2cpn0cwBY5AVcjPCqwXjSsrNPGxxlK3G2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lf7k+cNH7aSnxxtwtxn8jLssMWIfBikF2wNCCBYVifYfKVzZ4I8NwL4vJPPGfGUkO9vC8J4AegRD4hpkuwjjUqge7qlQSMQgUZeBQTEnWdvmw8ikQ2RR/cgB1/lkgE7BQyAN+O2ZCkIoIpwigHd1DqGe0zQLd534dpu64k7KWd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OQXwbfj+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yKnBvMRS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QEg8JA025212;
	Wed, 26 Mar 2025 15:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nG2eF77ESMBFsrY1FL9HSe5s+QvwbnNzTnVod/AII9M=; b=
	OQXwbfj+EUH27QUlkGVdhLvGE9KmcFdSW+hAc1+uCtPoHSr49YQIx5mQhiP7vcp/
	4KtHoAGIyTuHB85fSW/83v4amfpTeLqYrHzmcuB4uG2rQi3TDoJujMKBhvFFYNxi
	5ZXZ3ctHq8x7Ejl/FShr+Mrap+wqSEZuDuWW9vZegTxbhoJDeJcOYAORyJY4qFbm
	NOF9WfLhcktt8mynJRo5QINveTl0hjujFaMPFSqCed3pS+vk132KmGBOaLHdS24x
	iaI21j4NOkPjuSNsyWDQaHuSaVZQEs/rzBku1wxHHZ+1aGYBrKXKs3bhbPDW7naA
	Bfwj+mnQkCPHw9pjhq79OA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn871nxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 15:50:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QFTr2K036466;
	Wed, 26 Mar 2025 15:50:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5e2efp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 15:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYGe7xzs6sDi4hb7IfUXb98pSI5v8GBZtUAwFryJG1cy+PkBbTApBv7zNGTktMrQTrwFbupPvkl17+UtKfJCmilBiepCmdAXVl31S0pO1i+99HV27HxlUjghTOOb7BlG0mFUEyBFoNjNkbw6gPCZFvm396Snqp+bHYELlxIGV0Xu58AEDjXVedrivY/Yr6OauAbW4zI7ghpmeyxfFF2FQyO9b6EOz5aCvzcwZeNNE5O8yVF7hfmYpM+MO5hi9lsMlJSii3xmNULvwMWYBbTJ8ksmjaRVcfdaUmXWd3Op1wMjdXOnOcUEDvGD+P6Kr6yQ25/rKMpRTTovGhKk0ShjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG2eF77ESMBFsrY1FL9HSe5s+QvwbnNzTnVod/AII9M=;
 b=hvuEGkZv1AojYwRIUFJhY44P4CwHNHbSNVl9NhsrvLgzyJpu13QTgQBH4j2HNOD7sFy18Gjbw4+pA6astIPcEdmciZ08oN3UFhgSmDNWziOj61BpSJpqlvQiL1uTmIw3vEPi7La5G+CqwE5lcaEReK7I2bWC6J9dZ4BISoahrnHoVI4DIiuDk5YNdJsdh/3ILsDRSi2rWrw/9khHXy2iLoNKcPlh0VVIdPxm0Pk6erEyGWk2shQVy308M8/0q3MfcUc290muCuQPNx3g3cqLHnbkJncGUda20HOj5lkTMemxB1ImEK8Tm/kvo1P5Zslot3WfakeQF8tZBwJwWW5L2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG2eF77ESMBFsrY1FL9HSe5s+QvwbnNzTnVod/AII9M=;
 b=yKnBvMRSN315KZHQ6L+nd64YU9l6XDP2Mves5LNaOm2t1X7bYYILrLbL73wYU6e6UHPOf5LNEjaMEHZdOrvYnO6c/E/JtjQLT0Iviv4mt9KiKooHq4z5aybldDmgLYiBSmtP5OvtAkluzOyUGJO4QR6Qn6rn3nSHbE69PVVpe28=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4442.namprd10.prod.outlook.com (2603:10b6:806:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 15:50:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:50:51 +0000
Message-ID: <8377df78-42fe-486c-acd9-3bcfbbc43cf3@oracle.com>
Date: Wed, 26 Mar 2025 15:50:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iomap: rework IOMAP atomic flags
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250320120250.4087011-1-john.g.garry@oracle.com>
 <20250320120250.4087011-4-john.g.garry@oracle.com> <87cye8sv9f.fsf@gmail.com>
 <20250323063850.GA30703@lst.de> <87bjtrsw2d.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87bjtrsw2d.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: e041e851-c416-4454-8e5a-08dd6c7dfc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTZUVDdOTkpVdnRsdGtsWmR5Q01BcUk0L1R1a2FSREFUVVZzVUE1amM4K1ht?=
 =?utf-8?B?V3F1OEtiNDlqOTBzelZSNUVwUjdsdWlRUGRGSytwTHZRWjhmU1o1M2RYNnZO?=
 =?utf-8?B?Njk4R29XZ1hqWjJWMVhuNERaM2IrSE8ra01uMjdMVmEzcDJzQitUUVJVUEVt?=
 =?utf-8?B?SkNFMitzRVMrMGF0U05ZaWYzUlJzbDd0aWdhWE9tUVBNUzVVcGtTTWw4NHcw?=
 =?utf-8?B?TnB5cFNrbitwNHlSc1FtcXdOZlE5VmNIWFRpNkk4Y25mcXQ3K2VsY1NyWVFo?=
 =?utf-8?B?WTZWWk1NcXhjdVZRdk9yWnIzVkF5STNaRGJmUmxzTWpsZU1KQTZQSUlsSnBq?=
 =?utf-8?B?djBQdEJuL2NyNm8wTGFlVjF6ZDZRWGxwQWR1RVJ2Z2F3OUdOV0lsV3JZYXZn?=
 =?utf-8?B?Mi92amN3V1V6Sm4vYnNtcEd0QlA3VFRIYzE3YW9KN2kvRXpSbjUvVFlKV0s3?=
 =?utf-8?B?UjArTGZ6cG8vOHJmRWM5Q3J4ZnFMUUsvQk5hRjBvV2FZbXRvbkNRc3FXL1pD?=
 =?utf-8?B?ZmhtTkEyWlkydlkzZlVoK0hTNnZReVR4dDJhWDcxdlFnVGF2cFltV3hBZ1li?=
 =?utf-8?B?VkR3eDR4V25kckF0NGlvS2x5Wm5GWkhWbWVxdzhWYzhGT29Od3ZSVnhGNCtp?=
 =?utf-8?B?U2hQYUpOOUN4eHRESXVpcnhKMG94Rk9PbG5UbTNKMXAydXZjdEZMSjZFY3VQ?=
 =?utf-8?B?eFQ0VTlnS1MrdVhvVDNYS1dHOWZRWTcza3ZBcjYxMGRGYTZ3WjlqbkRqSzRN?=
 =?utf-8?B?RU5DeVdnS25PaHNycnkzTXRLbmRibFFiZm5tOEtHVm96NGUzZGw3OWh0NVFR?=
 =?utf-8?B?eC9pYkM3VWhvMWJGNlNFSlBzeE1RSUpSdXljODMyU2xtZGpnakJZUUZhSjVs?=
 =?utf-8?B?NzBrU1VlTUhMWWd0V0ZqWjlza0hsYWJabVliZTVqaVpTS0ZMNkRZSEM5SG5i?=
 =?utf-8?B?cDJibHpzd0NIU0NQNTlnazk1WHZJOWRQMjJBUlhaZWVCeHJvMzU4VXNkS2Vm?=
 =?utf-8?B?SWpad1FuZFZ3TEp3ZVNtaVJNeWpnL05CTDJpVFJ6eXVFTWxxRFNRcFU5cXAz?=
 =?utf-8?B?TTdPWG0vL0p1TWJCcTRpbnJGZ0MvUDRiTFRlUU56UldJaVNoNDdxaVVLSE5H?=
 =?utf-8?B?TFZiKzczekZHWTRpNkVTSWtLT1lRRXRUbTBkZGJsOFh3c0kyMVFKbWszaXgx?=
 =?utf-8?B?SStPMFh4eExGazJFeWJXOFdxc0xvSSs4UStKV01RTTlrb1l0UU1sUGpWSFk2?=
 =?utf-8?B?NVhPbWxVR3BMWnhSM3hub2ZjK0t5WVVoMmVJOENmWVBkeFU3MXNVN0NrcDhN?=
 =?utf-8?B?TjhyREJwbEcrdGNrK3ZxSHBTeGVwcXhSMGpBN2hwNGNlbGk5RVFYRXVLdENx?=
 =?utf-8?B?Rm9hWThkUFM5VW41T2laZUhuUTQ1RkV2b1ZDbktMa1VadUFrZkR6TGx5bld0?=
 =?utf-8?B?QlF2M0ltRUlkUnRqQTM5eG4raWFTcENFYUt6bHAzYzJXMzBoaEhpSVRrS0Iv?=
 =?utf-8?B?SGpkNDQ2b3Q5ekF2eHNDTnUrTFRWT3g4RXRtWEtNTk1qZnhzWFZ3Rm0zSCtC?=
 =?utf-8?B?anFnTVdzZDh6NW1UUkt0bzNoa1RpTVRVVnRmZFJ4MzV0VTljRUU4OGpyOHhp?=
 =?utf-8?B?RVF4VkUyOHFtZ1FLNnhBSThacHdlelNLZmNqWmcvc2c3cm5peldQT3g0ajU5?=
 =?utf-8?B?dUxjbzNUNERSUTM0cXVVc1JvRnBieDh6UXdBVXpWZXdNQmxBc2cxTEthQUlq?=
 =?utf-8?B?T1ByTHBCUmN3V25ZUGRYOTFDck43QXZHOVAyRFIzM3ovTVF1ZXovOEhHOXNZ?=
 =?utf-8?B?Qk1BN2I5NXE4NnZxaDhrYXhXdHQ2c0taalBNUktVblM2KzV5SkVvVmdNRGVL?=
 =?utf-8?Q?p3o0vL5yzQo0x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cS9oYVp4QTRlMXpaU3NvdUxWdXRuY0JpUnk3R2ZBY0NvU1E0a3B4WkZXR3E1?=
 =?utf-8?B?U0pscGVLcHduMTF0R2ZzeTF0M1hMd1o1MUxSWUpRMkFBcHROZ2dMZEZnN1Bp?=
 =?utf-8?B?UGVjeVZXd3hYZVRWeVlqUzFOZjFqRzB6U1lhNE5xVkFFcHg3MXpoMFBNVlQr?=
 =?utf-8?B?ZCt0V2tWUU0wRms3L3Q1VDlaZUlMQ1o4a1kzb3QwdDdhSDdtTlFXTmllMzJz?=
 =?utf-8?B?cGpHVW93dkRhRktRUVZVRFB3MXFLaVFQekorRUR4cDhmMWo4U3pVSmczdWp5?=
 =?utf-8?B?d2pIUjd4WFZRblBWQ29tNVo1Q25rMUlSNzA1N3h5U3NmbU1nbCtUeHlDUU9p?=
 =?utf-8?B?N2FFbWFkdkptN3M2YWQwYjBpWWZkZHV5WTB3YzBEcmVYb29Ray9vTENyY2Yy?=
 =?utf-8?B?bUszNFBhZFlTek11cmVLWE9YNSt0UXU0WUNQUHIyZFA3UjVqVmkrZWJLWW1X?=
 =?utf-8?B?ckpxSDJ1R3JadFJDRnAxTVo2b1IwRVhqSHA3c2R1TWJOR2RxaVZUUWZIc3Fr?=
 =?utf-8?B?bUxHY1kyc0F6ZXp0S2RNWEZMUVlkNlhMb1RqaTFKNW5FRXllUk5uS2lLYzRs?=
 =?utf-8?B?TEVKYkJlNk4wR3lsaFBERnZkaEViZzZvcmlScXN5MXNHd1JPelBteGhGSGtX?=
 =?utf-8?B?STNzUHA4ZTdZS2xyai9XTFRhaDBoRTJ3NHRYT2hYakJ5UGNvNndjVXhSZE0r?=
 =?utf-8?B?NkhLZThOYlZBMFlyZzBHb1o3UVFKSWxRc0haenRZK09samlhRnV5c1RXV0dt?=
 =?utf-8?B?MWgvTFM5UldNL2dWQjE5SThwT0djK3VmS3hQaUF3azMwcWRIY2ZNYU1VRWJV?=
 =?utf-8?B?OVdpc0VZejFsMXRiTTE2N2xmQmNwUThsYVVxd01LTzlOMTZ6eUk2bXVqZFZF?=
 =?utf-8?B?c2dMRVo4R0dVRlN3dk1WYW9uVklzZW4zdkh6eFhpc3NTdEV5RG9xYk90WGRj?=
 =?utf-8?B?aXF1eUdtYlhqbzM2OVF1OEQ4TzZYV0hXR1M4a2xLcjBrak1aa3Nhc2s3Z05K?=
 =?utf-8?B?YVpPc1JBZFhha1NTNG51YmdBanI4ZmpxZWhaZHoyaXkwU1JaTEphUmhtVmZ2?=
 =?utf-8?B?SldwOFBUZEVCL1NxZ0dSWFRLQWM3R212WVNKUkdaMWlMblFEUmlqQ0R4MnRP?=
 =?utf-8?B?SkNVREE4U0tHZTNiZDQxMmpidGc0RFFFTXAyRjM0MFhRZ2xOZXNSNVBkVVJT?=
 =?utf-8?B?Kzg5RjVnTzhrYlljdDlyMjVzMVp4UzNyRWJ2eDYvNGR5ay9lblA0Q0ppcExs?=
 =?utf-8?B?UXp4c1dNU0VWaWZIdGtLK01aNy9rLzlxRUtHWDZPczl1bmNPWkRISFRsTEVC?=
 =?utf-8?B?eG5UcjF3bEFxT28vQ01pSEhqT0c3YUlXdTNYUktXdDExYVBUcjFkY0pKVVY2?=
 =?utf-8?B?NW9TMnU0dm9uVThVK2FuSSt5c01CQzNIVXQ1NUxTTFBkQVJMaFB4V0I3SVNN?=
 =?utf-8?B?VGI1dEgvS2prZ2FGbk9TTFNwcDJtNnFnQnd4UU5xMXJDcUY3U2tLVnhWOVRm?=
 =?utf-8?B?NFBYdVZXSWxtZ3hSTW12VHhmWXNsTURaamJDaHdiS3NxdjJVR1ZTdnZ5UTVh?=
 =?utf-8?B?cjRqZFZKK2VITThZVnc4UUpmZ1JqTlo5Q3FhSXdBUGFJeUoyWnArZW5zem0w?=
 =?utf-8?B?Q2c1R0E5QlhSMWZOR1d1cFRwcm9paU1UQWtvT25uY29GSlZvQXBLWEk4TXll?=
 =?utf-8?B?dkVwY3A3Nk1MOHIrbVRWclBuVW9Qc3Ntd05hbGNnL01WRTZkYjNiaExObnoy?=
 =?utf-8?B?c2RmZXF6QUpMKzd2aWorTUt1d3ZMeGxIK0xoOUl4VG05MzVxN2hKVVRBYjV4?=
 =?utf-8?B?b3FmS0o3bjViZ3hTZGRQQkVWZjNhdkIyUU9lYnBHNS9YSWxGNWhuODRVQ1Ny?=
 =?utf-8?B?TGFQR1RDY3h4QVVoV2xyWlhLcGZVbnI5cndVQVAwVnJjS3hVcDNTVHFvZ1Fy?=
 =?utf-8?B?Z0V3THBsQWNTQmhxeWlEYmhqZlJwc1ZLTmladEhDMTZmQ3lrR2ZYSnVEOTc2?=
 =?utf-8?B?bnVUVXFhT0tIakVNTHM0TzEwc2F2RG9nV3ViVXp1cHFBZXphMUM3c3FSdk1o?=
 =?utf-8?B?dHROSlNYUTVCOHdwMVl3WXlyLzRQeFZpcTVHalc5MzB6dStyTnc4ZngzVzRY?=
 =?utf-8?Q?3BokAahUTU+pKzngbednZObn8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5snjEE32JVzZYXK/afRGugwPGUkMuGom61H7d5YFCZweXti2YKvCsNAotzbF397SrDEv8ctLpMGgngeQxu/Cv8Dep3oItSTRd/IMe07s4PK3EUJ5rFP7UVLN8UJ1Xtv+bJD2A8nmzInoPLLrjWgrMKYRM0gT14MXor3wlYMrh7EX0imm1LYpbWiuoknhpiEltwQIy0Cbv8qDYDHqoWubtV5gWh/RswUz/WxLTvVYWzZFyCdTH0Kvb71j7jnPUyv2CGxfD7UUOkdCAlCWPjivH2S9/zV6ddh1ZeBX4ACScGI8tapWV9wDOccqMDvBpIb8tXcXhzAzyCUSUtMi5joE/r0+D95JSCzQ0slzB+zUoPbOP/iMl/CiLulZBIKjz1k11QEZSCqbG0x8yEpdaNdEYQM8hGxAVwNNN/BYJtnvK/MrvkCTBlY3yQ8TYeAfM3uuPHn0EsjDjV6rr+9H0XNYnVpo93bF34gwOL5DW1dSHyGq/mSZG/WRSAwWtWf0ZOdmlF9Qf/5kjzcZyc+Ig/llfhKahEzeKfBeK+eQxaowgqXv0rnGjJrEnAYpC+nb2Vl2S2FteIF1i+ceS+VgN17/X0UXwGba+eMQZG6r/3Ab7yg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e041e851-c416-4454-8e5a-08dd6c7dfc38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:50:51.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCwlweXZPYxvZQFwkKaqDLE1ttqKmaPyTvkjvGntQfxPbAbEI2QB1i4CQfOrzGtbPpyPXz7L6IJhjAECc64gWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260096
X-Proofpoint-GUID: C1HVWOsoUmYnEQqPpC-qJX-avWbJbtad
X-Proofpoint-ORIG-GUID: C1HVWOsoUmYnEQqPpC-qJX-avWbJbtad

>>> So, I guess we can shift IOMAP_F_SIZE_CHANGED and IOMAP_F_STALE by
>>> 1 bit. So it will all look like..
>>
>> Let's create some more space to avoid this for the next round, e.g.
> 
> Sure, that make sense.
> 
>> count the core set flags from 31 down, and limit IOMAP_F_PRIVATE to a
>> single flag, which is how it is used.
> 
> flags in struct iomap is of type u16. So will make core iomap flags
> starting from bit 15, moving downwards.
> 
> Here is a diff of what I think you meant - let me know if this diff
> looks good to you?

This is still outstanding, and it would be nice to fix this ASAP.

How about we go to 32b and change IOMAP_F_PRIVATE for v6.16, while just 
fix as suggested originally (by renumbering) for v6.15?


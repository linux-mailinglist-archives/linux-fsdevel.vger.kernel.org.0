Return-Path: <linux-fsdevel+bounces-43834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1025A5E63F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0ACF7AFC8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0681F55FB;
	Wed, 12 Mar 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="farw6o7h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qV4ul7St"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37371D5160;
	Wed, 12 Mar 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813275; cv=fail; b=mpdN1f5fmYNishBiuDCd/f8US5D9j0d/nJKcQBVUUdag9n7gwU/8utFJjnc7CUuO+BnnLwBm4CXiWjjSCPxZ/+M92TDVrLYhHLLaYzklr73LqEK/AWkPyKr+am60avjtc3MaXG8TDHlUs+OVtJdJRKABaqcw/4ekD0pFc5S0vQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813275; c=relaxed/simple;
	bh=EliVWkdzoiy9ExlEixRERgVqA5qFhOWUM7CQnm+pD9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n6JrwkxG2HB7OeHvSR9ykwlZJrb9L86semZc1ooIwYOgH82eJvoL2FgQnUryIuXMXODY4UsTXnKTPSgLv080SMaug/bDoJ/RsSj29w0MdBB+soJSA7yqMPPg7PUs9xiEF2d5ca2Xx50ZrQEcznjSFv4ZKzhhZAIs6NgZVh6l3y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=farw6o7h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qV4ul7St; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CItnKe015482;
	Wed, 12 Mar 2025 21:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d3JAZJv6YrgbNa3fEQaOBkktPChm7exV6mErVUOE0zM=; b=
	farw6o7hzjGcxxiPVsuHaUdUZyKP8ktp0uGSoGGto7hzVWv4xO+IYjto7L7cJqDG
	vSaKWxZkVgsKHKg51iZN26ojIkXfShDZyoe+H87NHcwUdc7oZDffmOKmcvYpFya7
	sCUmTNgiagNQpRTYIad9U+YkM/N2ENWpNClJvjbfHqbCsh0SN/noWF+vW2yI19qo
	TM4mzfQEiyk3tebpfQPAzJpvOhEg0cZii9sO8dSoPdJ1ATkDKVDmVanRTsmV3NtY
	vrFY36UlpDWNVqivoW4F8s0IDEZQ/jFK2hH4pK56bNh8UXg0kcRV9knCAnG0C12M
	Jf29qJYIFqTD+x3dISmIhQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dju5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 21:01:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CJwlna009577;
	Wed, 12 Mar 2025 21:01:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn3tx79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 21:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5mr/AoGVxR07iS2glDkD+Cpb/K4kcqyfxbj7IM4V8Dw+LHberl/JZkLlaan2m6A6M81bIY6Xi5OCteTYzNWi4vkJVrMCIaKVzA6itn8XDto6G6En/fms3FzYPUxcwLe5fhXqVDdb6LCD7A20oNKCQV96et+MatZJ0p6QZdcHHgIjL+f6IgYHQtjweAdUV5sOU34MAMF13+TF9H2B12ItSevSV2wqg6wdaSrXfKfyfqM7OhzJngTorPrQQyQlYF3IKT1HJmJip92fOtUzCiG+9i2z9J96F9xjqkEeb23FtwZn2MMKZPFZP0g5nSC6XpiCDfdA5WnrqRfnx5JWDIjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3JAZJv6YrgbNa3fEQaOBkktPChm7exV6mErVUOE0zM=;
 b=qs5841M1aWcCM6r/cz/miG0Pa9HLl/keVVoBCv/bFuilxnob6gPy7FFqS8dCc8U3+ZACJfX73crfInqOu8buNrHhxztLTbbbqsjxz9CTLG/mIy9WLsaePrbc5nmnxUBDafWT38sWSLREw7MtH+namBZ+UzUcELzWwfJr2KifZ3v0TqC+lGn2cWfCpSSSmRi99dSa8nDM7RijuNU4++qyEpMi5SY55yEG4XoHrQ4XZUCJPaQnx7dUomUTgpEEERy7DAxfkJSQZQ4hfa7KkJvRR0JF7Ops8NMuWdUJpOJ0IbdLnKqkrQPxV7VZyKXBt3/pFtXrmIurJtjveXxtapl4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3JAZJv6YrgbNa3fEQaOBkktPChm7exV6mErVUOE0zM=;
 b=qV4ul7StAyrMGv5VWDDCQlPM6DYIM6UQcozwZtdyKTwkJwx+5yY58Z+CgMivhMJCmWUgbemTbKe8evOZg+NHbpMC5J05GW+2TF+g07HpaNZv8OS9fMrygb7nFO3S7hNsqvwVlNfm50h0PZZGsvePyddtRHkwHCVoIjbF1CFndK8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7205.namprd10.prod.outlook.com (2603:10b6:208:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 21:01:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 21:01:02 +0000
Message-ID: <cd3db475-39c6-4610-ad66-8bfd99e03947@oracle.com>
Date: Wed, 12 Mar 2025 21:00:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] xfs: Allow block allocator to take an alignment
 hint
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <20250303171120.2837067-13-john.g.garry@oracle.com>
 <Z84QRx_yEDEDUxr5@dread.disaster.area>
 <ad152fa0-0767-45cb-921e-c3e9f5eac110@oracle.com>
 <Z9Hl39cS-V2r-5mY@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9Hl39cS-V2r-5mY@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0247.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: aed93949-c31a-4bea-3885-08dd61a8ff61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWkzM3FNSkpwTEJ1OGo1dHF0MG9IYWl0a3FEeEsrM1MybmFrWW8zMGZ2U1lO?=
 =?utf-8?B?aW1JVjdtaklTcEgxM0tWVlp3K0JSZmw1cHNGTWlxYXVGbU8xMkg4VFRFQWdk?=
 =?utf-8?B?a3UyVVFYVUJlRHgvdGpKY0pUNlRueDl5ZzNUSmJyRTA2WUhoRHN6cVRPbks5?=
 =?utf-8?B?MjRYY3FtY0pIbyt4VEwxV0F6N2hSVmw4dnJGbzBOeEYrY1dhSWZEaEtUeE84?=
 =?utf-8?B?cTZTcGFCRjRaNzlaSUVtaFppbStGWkd5NXFVdUdQZDlJM1pYT1U3OHdaWW5J?=
 =?utf-8?B?TytkQmpUU3RJVmFpVlNVOFUvZ0VQNHd0aUQ2eXgzNzk0MzJycjk5VFFQZUJu?=
 =?utf-8?B?TjZ1bWg4QjNJMzdwQmZyRW90WjloV1E4YS9kSjdNRGw0RWxIdmg4QkRmelM2?=
 =?utf-8?B?aStzZ09adEtFdlU5amw1OGNjM28zRlg4Vkk2OThCNlJJZEhkY09zVE4yeFJt?=
 =?utf-8?B?cVZXOTUvaWxpQ0VDR2g0dXJqZ2pZd3BDdXFPYWpIWEFaWDJET1JHRjZBMm05?=
 =?utf-8?B?SlR4L1cySCtyUlYrM1BXRWh5MS9sNkFmZmxISDhTMGxhNmkxNHVPYWhYSEIv?=
 =?utf-8?B?bHl3YkVEaVduZUsvVnloWUtsclpnOFFDWTBpb0hIY1AzZEdKdlowWURyRlht?=
 =?utf-8?B?VEpjRk00SFJUVDAyeCtTUjk2cG52WTBtemtJQ0xQWHJ0OVZXQkdiRjUvdjJF?=
 =?utf-8?B?MjFheUxhdlJsdFR2dzN4YVZJSm5BYm5FYmZPUDdpRlF1K0hEVDlRUEVveGZO?=
 =?utf-8?B?aGh0dVVoQmRreHkyUlFiZlllWEp5WWxuQ3V3Q1Z0ZWlaaFd3bUJCcUMvWWR4?=
 =?utf-8?B?azg0cnNsUWhBcytkNlppeWZCbjRzeXh5Nm9HM2IzazR3KzRQQ0FpY1JrajVQ?=
 =?utf-8?B?ZUR5ckFjSmdvc2ROYjlxYWJqR2pNWEtWV1pHd3dpMHRkeW40bjNkYzFTSW9U?=
 =?utf-8?B?Q2V3QXBuVnFTMFFWQ0xDZGdPK3FpM043Rkp2a0M4cDJIZ3c3TnBNNWtNNlFX?=
 =?utf-8?B?MUptN1J3V1lTZWk0S0FRWFVJMGdZRWFzdXc5bkI5S1QrM1pKNmEzcGZ0Q1BZ?=
 =?utf-8?B?TGkwUGNRWVBOcGZ4SzkzOWJGYnV1VzdSZ3NaN0RNN0NMZHd4WlhFTW8vKzQ4?=
 =?utf-8?B?SUF4c0d0Mm9iam80Q0dNOTZsQXE3OWhnY0hHYlNnc2J0eXA5R05nZWhGdjFY?=
 =?utf-8?B?NG4zRXJBSGs4QWpIb3Q4RlpUVzY5dlJBSFdUbkhQeGZ6MFhyWVhwV0x3VENB?=
 =?utf-8?B?eWNkS0VGaDRoUG1SZFE4WU8rbWZHeVJSOE1EQmRGNkhpdE85VllvMWFCVnh0?=
 =?utf-8?B?RVJrb3IxZktPRFM2K085UVZHcW42M2dnQ2E3aHVKaC9iRHNRcFM4VEJtdkJE?=
 =?utf-8?B?ZnNJN1RvcVFtL2ZNMmpZMDNRNm5LaXljTzBaSklEZEpZNlZ2NU85bGVNS3d1?=
 =?utf-8?B?UjBpTytOQ0Y2SmFtaHMwVjMxd1dJN1IzTllVME8rRjNyS1Jicy9uek96aTFx?=
 =?utf-8?B?UVZYTDB2TktBRkVOeGU4ZHhWdExnOUV3TkhONFFMZ3NTMmRoMktTb21RQXR4?=
 =?utf-8?B?UVk3cUhFNVJ3MVQvRlU2OGswMGYrcENrUEdWN0JKQWVOK2dYc0FCakJzMVFS?=
 =?utf-8?B?cExaY2x5NGI4dzF5ajB0bkRMT0FBTUEybUVVci9wQlptRVoyZU1MOEhWbFZY?=
 =?utf-8?B?ZXhrOE1qem13OHJwUExjamZGQys1UHNlOXNLWTg5SFE0aXFCZ3pQb2hrUjF4?=
 =?utf-8?B?dE9jK1krbVc5VFV5OXFlV2JMY0t3KzZyUllyeUNnR0VaUlZPWStPZS9tdnBP?=
 =?utf-8?B?d3hDd3gyQ0hDd1owRDNrTi93RnRVSGdkS21sU1VWM1JHR2gzTS90ekprc0Ja?=
 =?utf-8?Q?3Vach1sYYqUjK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alV0NGwwd0pnY2svaW5HQ1JGR2E0WGVEa0l3ei91L05qQVlkblQ5ZmpqVFZi?=
 =?utf-8?B?RVFKK0FtTisyS0V2Vnc1Y0dJOHh5SzFGWklpdmJ5OWtnSGdTR2Jia0Jxdy9C?=
 =?utf-8?B?REtoeE90WVNOZlA2N3V2a3B4WE1UdjRSZ3d3UHVIZnhCbHdmY2pkNUxMS0xC?=
 =?utf-8?B?VVVaN3h6ak1vaG9TQktiY1pMenB3TVI4RUpvRGdHak9USElXd09QQnN6TTF2?=
 =?utf-8?B?eTVGVUNURGFudldlUURtRVVOdy9KaSt6T3ZpdExLRDBFZ2g3TWZoTGF2aEUw?=
 =?utf-8?B?TjlXWUFsdjN4eTQ1aWFPTThLNjRFVmtJbG9UWjRCMFltS0YxQmlFcnpuZzZn?=
 =?utf-8?B?bkV4a3IzUjBrMG5nN1p1aG5wdDhOb2hiUUtGTkFRTVdvb05Ec3E4WHVjZWxG?=
 =?utf-8?B?T2JqSkxzR1Z1VDc5K29pY1cxSkxBMWZJMlNGd0tRL1FWTVZPT1NxTU1QVWhF?=
 =?utf-8?B?bTFVdDM2K3BpS0p3ci80SklNQzFUV3kyUU84cUNMbnQ4MmthY0RIQTQyZHU1?=
 =?utf-8?B?UzlqYTJPbFBXb0tUZGZQamdqSE5Bd2NXQjVpb3Q3WS9ES3NWQWxaK3ozVHVB?=
 =?utf-8?B?dHpXTWZBV2xDQWtVQnZ0UTBSREFvUER1bTVKbEwyRXIxK2Z4S1ZobjNmZW9P?=
 =?utf-8?B?Sjh2QVg0USt1amV5VkdRVnZOc2Y3NnYxcU5yWmdaek05V29SS25mNDlwUldX?=
 =?utf-8?B?TER2TmVDWEFDQ1pSSUVIOFRXbjI4ZmJrUXFwOEdUSXlLbHpXYXhVUVViNzBL?=
 =?utf-8?B?ZmxYbEc1a0JxZllhay81N3R4dTJwN2NxdFNXTi9tdjVKQXY0Y2QyREtyNHFL?=
 =?utf-8?B?QWhLVm1NR3FTZUhyMzk1TkVlcy9EMEUwWFNGTks3ZFlyd1lTNTFmbVNzQXEx?=
 =?utf-8?B?YkxmYjhPMkROTkxveDRZWjBEYzJiUGw5UFlMZTRFUDhMbmdpU3p1RDRHblE1?=
 =?utf-8?B?T1hTdTR3b2ZjTFdFbjFPSU02MnRpUG16T0NOSjMxelJzNWZocENGdEVVYm5F?=
 =?utf-8?B?UjVwVkFkOUk2NlMrY3dNNzZNQ0NlTllGQXhNWXIyTmVUY0pwRWw2OHJRNHZq?=
 =?utf-8?B?S01ITG5pa1NNSk5mRDQvOHNPWnNFLzZTQThtR2dtZ0RVYWRJb1FYY0FRYklV?=
 =?utf-8?B?Rkl4dC9KYXloZy9ISzVYNGFpbW9YUnAzWmZsSTVGWkNzYTN4SmtMaW9YTjBL?=
 =?utf-8?B?My9YSHFIR0d1dVgxUTdHaTdRMDBtYzB0ZUlha1FLS1RJWkdiYmxlS1I3cStF?=
 =?utf-8?B?Ui9NWnAwSkpYRkpoM1V4VFVsZGljc1h1QTJGTXBTSytjUmh4V3VBQ1VwQVRC?=
 =?utf-8?B?dUllR01mNVNvV2dnMUJycnNpcy9Xd3JSMFBEWjFJV1FTWUxpWldDR2t5N3RT?=
 =?utf-8?B?cDg1NW1WMCtLcWVQcEhYL2xBRGhTZ213OFM3MXBpVm84eTZRNkY1UU9KZjRF?=
 =?utf-8?B?YVArQlJwMExCc3k1eTIrUmZJYWsrcGpJWXY3c0JIR0h3MGtyQkZTYTVsZGRr?=
 =?utf-8?B?KzVST29ra09UU2lWMGxzNTNGQlMzS2p3a3EvTVBNK1RyZFNqZHo2d3JWUTAw?=
 =?utf-8?B?QzVNQlcwajRac01YT2l5bzI5K2JyMnRYdktiZzE5dFRCN2xnTEd3aXM0TmRv?=
 =?utf-8?B?L04yMHlFSmRSWkJpc1BkaHJLMU5OeFdqOEtQUE05YktVTko4REhrQ1VldlJu?=
 =?utf-8?B?cXIyc2NHWW1obWhIbExveEtNME8vQVM4ejdrQm5LeU4zWE0yVG1wR2ZTb3pI?=
 =?utf-8?B?OWVmR0pjNVJLUWpZZDFNN2I0cURuZDVIMTJWaGlKVHg1MC95WWZFY3ZMa1pq?=
 =?utf-8?B?RVYvcnB4V2dUWm5KRWpOY0NDRk9mWWtWM0U4MTBNaklmWFV3VzhJcmpKZmJG?=
 =?utf-8?B?dnNxSVl3TFZ3dlBLeWZoNGhIWjRZVGhyQVA1amNzenFKSWxETUsrYU1DRGVp?=
 =?utf-8?B?WC8ybmNoY1NpRlBrMXF1ekVhNktJZWFsY1pML2dGbTZpQ29HWDNWWWVRajds?=
 =?utf-8?B?VzNDNUIrMWJzUUlFNUtwQWxwRkpIdUZ4MFdMbi8xZVFLNUc4ZXJFNVBObm5G?=
 =?utf-8?B?aERDV2U1OWpkMmt2Mi9tZU9OaHFtL05kY2ZWdnNkaTdiMUNnc0Z1WFJMNkNE?=
 =?utf-8?B?c1BOYVlHQlZBQ09XYlRaV2tQYitmaXRlditFQ1pjQllCZ2ZLeWRwSlNTVEFa?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZFdJXiMhbj8Syzh28UZsGfvU0tGSnz2lGCkIysZofy68tPpY30rLmFO4rm1bFdn4bVWCBG8/HMM6TxRWmJEOq/D8SKHRuUG4sZUvoid5fijI+Jfse8sV3F4xhDPM+w16Ltxe699Gkg6gM9vQcKOVcVrrAkaoRpqZVOqfR7ciBPkTS1wgbuYW5B0Qtus5cs5Ya6jI8P4Dzcky0UJl0Lag4kC7KXfo+GjguIUZLC5y7aiE4F5v0g8hQ4Xbk5QmP9AeEK8yYTKHaox/WYbqJJJKz+JV/ApF8QwTkwJ3RHfkWR5SLjfL3vwE2Tigl+pGhhscNcvQdfuXIJsrVuOTdccxQEeVB8uL7jB4o4k+1M6u1rUt5iRI7LoBAkhUkBqykMI9nSSaBfKnnsSHC4K+LhIEA9wpo8IvhvwKV/wCE2iypQaCuQbq3AHWH+BKQ5VWoOQdP0nRf3H1TKa57Jk6a37/JTWBYPQKd9a4b0QOokLZjyRZPWYwLUrV/zdBcv2B2w31qGeszZsL+v6chvAv/XLzJ3m1IAl6LFBTbdGc/4nro+QzZeyB47eQiaP76wj65MfbUbrHho7IaBsWOEQFnOaXIf5hKKh73j6iOlWTRPf2e2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed93949-c31a-4bea-3885-08dd61a8ff61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 21:01:02.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P1/ApF6WzDD3Zv+ybaSCW88L+3bCBzCQG/3OldlG9Wjales3jY9hIqC9pXACDPaXJswFxDblQHyJnSYI4QPrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120148
X-Proofpoint-GUID: oPLnUMbb6TLQKJjbVLSM0P7fTPigqmRE
X-Proofpoint-ORIG-GUID: oPLnUMbb6TLQKJjbVLSM0P7fTPigqmRE

On 12/03/2025 19:51, Dave Chinner wrote:
>> We are never getting aligned extents wrt write length, and so have to fall
>> back to the SW-based atomic write always. That is not what we want.
> Please add a comment to explain this where the XFS_BMAPI_EXTSZALIGN
> flag is set, because it's not at all obvious what it is doing or why
> it is needed from the name of the variable or the implementation.

ok, fine. But that is as long as we just are doing the alignment for 
XFS_BMAPI_EXTSZALIGN (and not always, as Christoph queried).

Thanks,
John


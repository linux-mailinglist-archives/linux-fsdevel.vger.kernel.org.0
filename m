Return-Path: <linux-fsdevel+bounces-43862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D9A5EB8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357947A3872
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2373C1FBC81;
	Thu, 13 Mar 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gbWnERzv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H6Ot7s17"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DC78F4A;
	Thu, 13 Mar 2025 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846306; cv=fail; b=hX6mFUsgUMeNJ3sjODL6QefsiyctAG4MjYoYIda+gRGt1QxrgAbZ/OtD7bPnYhEs+f7Rcf4qZsVqQr/Q6X5/ruZ0ELjbTOLRDyWkEkiY93/nog07cq8Oo952Wq5QCE/jPyYzidIAikjyIp5sTA7lBF1jsOVc0TlN2q5DTWmZuYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846306; c=relaxed/simple;
	bh=OJReS0DfMPNKqbr9Pl4kI7OWGVtt+VqmujvR4RtRrf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YOq3PXi62kibgbYgKCDEZGXf6UoEJ8/sxrbH3R3oNYUR2tadK4KWfTdknaOxu+DRbhcZ3PSBNU7G+G7mPeTDU7QcrIQTxb+imfiasJvktQziv0kTAtNuYcvIEGNNetsyPsjEBbM5eLLm8mKd5j7RcEOdUXnP05v1KMCfZYoxX5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gbWnERzv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H6Ot7s17; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3tjDb008197;
	Thu, 13 Mar 2025 06:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M3Cz2ygUs5+i19aIsZIbGlBWepne1H5KrjcqpFo+3ho=; b=
	gbWnERzvrue2tL6PmaiP6hOCeftqDiiVvwqhCRvrX0Eg4shvL4N3qLNQLyUSzRA7
	HNXEUJ0BwhFAcL3OeAc1sQthONOumvvGNvd1DmbrDOUceG2//9E3sVWN7xhuINjs
	cwXIj6hUoLAexxCjO37rDh6+wV59KPT8HnEw7dDAZq0kBZepI3jAEGOz7tyIRUsk
	+XeUBXmm4lZ63AZ7GUp1cShLaIDW+TbOSDbblESASQ+Q/2KUMpajXB4gKMnQq+4H
	x5RP5FfTov5UuTjwtmHBBkRgQRyL4yuzEFlIedestPubttaAAfP/BGdv5qZKYTgF
	Dq0v8VLWEK3Y4TD7LpGW+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4duhmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 06:11:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D4FuW9019485;
	Thu, 13 Mar 2025 06:11:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn1fr35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 06:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfN9P93ADAX0exMEHhuMoZCAGptBbbO9I8keMnWU3P8D5NNtkR1ZYJZCIyET4oA5bq4ZAeSf20OrpgMpFIjWX1mUPlw17wnCcQ6DJoPMDARHxC/8x6fDK2TVDqyY8MZ4Os+ST7HoECL9h61hMzWah4pWZN8aAyWmiI6Se60HxWh7a+qVehqkYdRn+B6kV+gAM9fGU8yvQ9MY49mFyQi6swZ0AzRluOBM/XrksmrizKYPs+dcUQnhZeP41yi2lCxMp0qopJqRs+G1/I2aTmCJyhzjVgOdKJt0fV/raQlHVquxHhZtW/ZecvIudx9EHLokmWLh/auON0GGs6/D/pvr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3Cz2ygUs5+i19aIsZIbGlBWepne1H5KrjcqpFo+3ho=;
 b=rQ047s75ilna57U6SwDcHJnKEj869jbSAJgdFeTfbZRL3nzabJ9R5L+qL7ojf99F/amqGuAd8FsObbHwQUKZuKFvchyTAIz6zX9swo5OGJd+0DkebnX9ww00da860CjVQs+LxmIZIsjXxPshnzntHCjTFGacXrpXo6f+cJeDf2LzGulhAuEdGaUFNqzxBXjJHw2t59Yw85BRJDR0xn3Vja4y2GbM7akop+x1o4xnErUTPImW5UUgFYZNf9mZQtw1wynpV9uE43NzdQIw0IfHZmjpUZQNxqsVUgbnRvrvZL9ZsZ+XKRvgRewqAXHiYBvOIWfEaRJ2mdLsbbpgflV6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3Cz2ygUs5+i19aIsZIbGlBWepne1H5KrjcqpFo+3ho=;
 b=H6Ot7s17awJTY0HkFHu0utYqc7Y4ooMW/DlntFzIMMZMmGdKgRQ4Mro0/zldHxR+boh5PEJgyFSCdM1PoBln/jGYOGrGCAyq0BWnVnuPX3OsForwVS6XIs8PESvtlzals65Jfv42TjjcG+KV16vEJUKm7B66Rgqz4Q5t7Exl9Zg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5069.namprd10.prod.outlook.com (2603:10b6:5:3a8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 06:11:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 06:11:14 +0000
Message-ID: <68adae58-459e-488a-951c-127cc472f123@oracle.com>
Date: Thu, 13 Mar 2025 06:11:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
To: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org> <20250312154636.GX2803749@frogsfrogsfrogs>
 <Z9I0Ab5TyBEdkC32@dread.disaster.area>
 <20250313045121.GE2803730@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250313045121.GE2803730@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: b4133c12-1deb-4c1e-2f83-08dd61f5dc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXJUZGpLaVRWb2NadVQxY1FPdldmSFdSdFJJUFArcUtwaFA1UGc0SE1WMXlT?=
 =?utf-8?B?bytKdzhqZUhIeXBvVUdSejA5V29pRXFhMnlyN01TdWcralJ5NVBBZTZQODkw?=
 =?utf-8?B?anoxYnZudFZSakJ5YTgzSmhsV3VXNnJnUmhWRW5rbE1LUDNaSGVObk1PMDZ1?=
 =?utf-8?B?aFBIN2NZbjE3VFJRVHAzeTU2VzNHeFVvbEJBYmdxTkVCYUpUeFpYcGEwYkox?=
 =?utf-8?B?dlJUSW5zRS80Skp0NjlRczVmOTIxMG5wcTd4clhmSUFLTDhPSDY2bDR6bjZM?=
 =?utf-8?B?cFAyUnVQSVBlZzRyUmd1U2lrOXU1UXBVV0xOOTVESzBWVmZjQ1pUTTJFbHdp?=
 =?utf-8?B?OUIyNVZKNkN0YWE4RXoyWUF4MHA0RWRKQ1BiSXdobWZ4K3ZDcmxNanBTbEsr?=
 =?utf-8?B?SWZmZHFyRzI0cFp1TG43REhkUnNLeDNLZGZkNmt3YWxzRU9RcVp6aUxEMEhD?=
 =?utf-8?B?QXo5ODJHbmwrZlhTYW1oYVR3ZXFNUHBqekQ2MTZCd25nb1ZBMEpXL2JmU3pv?=
 =?utf-8?B?ZHVUMG1kK0p6bWtmQUpmNFFuWkxGK0Y5MUc5T202cU9ZOForcUt2UGo5QmEx?=
 =?utf-8?B?SEd1R2FIYlh6Vm55aDQ4SStpNnd1VnYwN3F4TU54WCtrc3pULzJNMWlOeTJK?=
 =?utf-8?B?VTIzVnlidXVzdUNhU2VtcmlBODJxYmNpclhhdllVOGdZVXdFb3FCMXNBak5U?=
 =?utf-8?B?Mklla3VUUEs1alVnNjJOZTBRZDJOTTI5Q052aWZ5clN3UXh1MUNZZGU4QTVL?=
 =?utf-8?B?T1VxdEgvejhVbXJHTXEwbkt1eWJxL2JXRXVSdnRpQ3FSaVZ2NEZ4Ujg3bHo2?=
 =?utf-8?B?bGNwMi9vcGhGd0hSSGpRUVptQjVSRGtVVDRkczhWL1lLYS9UVmw2Y0lJbEhP?=
 =?utf-8?B?TDZXTUFlb1lYY0wrei9CdzkydGRmaEd2V1VCUTM3UWJsTzRXS1NuQisvbVNQ?=
 =?utf-8?B?Ui9mejhSUkR5bE1lcE1uS0ZBcHJySWJlY1BDMVJaUlRzOHIxYXpaenZFT2ZL?=
 =?utf-8?B?TFBYcGdNQnpsTU5GdFZhWHZELzc0WTFlenZGeXpVWnZ3RnByR3hMUkNQdG94?=
 =?utf-8?B?K1Z2c1NrdWhzcHQzTDQ4dXlWaHZ1Z205YnlIZnVBK0U2Vkd4eTBJaEd6YTBp?=
 =?utf-8?B?UWh4WVJ3T3FvNVhIalQvbHUzOHBwN0xwQ2F1MWNkN2I0NUNYWWhES2ZnbDZK?=
 =?utf-8?B?WXo0enZCY1lSNXRoUHpzV3FpeStKUzg1cUhOb0hDZldCSE5sU2lPbVJxcUlS?=
 =?utf-8?B?KzBsd2RZUlhFZWZGZTBsWCtLem9OeTZWeHNvQnJlZGlaeUNmRkl6Y0s4dTFx?=
 =?utf-8?B?MkY5YkY4L1BjZG5FSzZsVzAvVFBKMHc2bGFMVHlmU1padjlLR056Wlp4dlJz?=
 =?utf-8?B?SUFRRUNNc1RYUEt1VytUNWhYRUxrZCs1SHhkZ201UVlnMWc3WHNoUHRndGRu?=
 =?utf-8?B?QVpRV0FkRm1CTUVCZkNwV2xkUWcvV0ZaTUcrZ2sxTit4K0J0QWZhV3hxL2ZU?=
 =?utf-8?B?NzhMSGtOWDN1UzFqb1N0QTYxVFpRSlRaLzVzTUtFbEFma3FSYTU3aHYwcUFx?=
 =?utf-8?B?R2dabW9MVVlKMCt2R3l5RjlMT3Z1K2k5N2R1MVRrdTlpOEpRWlUyaWpsck5o?=
 =?utf-8?B?QU9yeUk5SXZWWW5KSDUwbXZHV29lUkN1c3h6TjFSU0VXOW9VV2NrNk9La2JW?=
 =?utf-8?B?SjhscjRzQVVoVFgxb1FVczVRYUJLbk1VdU9WdEhKcGZ1TmlzYnlHbzZyUFhM?=
 =?utf-8?B?blNpNGVEdUNsYjIwYkVLN3A2TnRSN1NNVEJPL1puY3pFZlEvWnFPMWR4SEZL?=
 =?utf-8?B?UURCZVcwc1RKNjloRWhmbVl0cGozT2NxY054dzRweVFvaXhvbEkvTlhjc2xl?=
 =?utf-8?Q?JBN6OTZ4IoqhC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnJpK2tUckVyWEFZNDNrRnNSdTdCWllPSUxNaFgxbFh6VThzNEQxOHNmalc2?=
 =?utf-8?B?NjhBTlBRaHFHcXhzMEJnOHhpTWdndERuTGJhbU1qK0FTT0FRT1EwS3piWnF0?=
 =?utf-8?B?WFBEV0tMcERxWUFrcmMwaVZMWDlFcEVCajlvYlkyWFEzdDkyYm5CbFQ4OFNk?=
 =?utf-8?B?RzU4dnhrL3AyWFdPaWFwekpYOHpOeVBnakZBSkZYVnhJQVdTajc0UVVzUW9J?=
 =?utf-8?B?V0p0RGNhcE9MQ2Y0bjR0QWNCamZ5WCtLbldxbW1TeU9Pa1BrMWE3ZHBrY1N1?=
 =?utf-8?B?bG81SDJYblNvK1JmNUhsYndLcnQ5WFZrMWpsaFhyQ0Fhck1HQUVHVHRzS1dj?=
 =?utf-8?B?NGxNcUQ1UkV0S3d2MlRBcHdjSHRLSlVhaTc0YlVLcUVPM2dtTHFiQTdGTWI0?=
 =?utf-8?B?ekE1K1puZ0JoRVY5eDIrbW55cDh6b1NhSXJLYS9sZWtEcnpQaXBQSG9hSytT?=
 =?utf-8?B?b2c4a3BaMGRDY2NiR0JqZGpyKzVvcUYxYUVlaW14MDJCL1B2dGdZZm4vdzlS?=
 =?utf-8?B?dElncERzZTdWSmdIbDR6UGZVa3V2c0lYdTNnOTZTaFVQUnpuUk9SOVM1YU8r?=
 =?utf-8?B?V0puRUIwT0wyUGpBZWN5aGFHcURsUmptZFRGV204Q1Y0SlNpNTkvTDVJL3dN?=
 =?utf-8?B?ZjFsSXlQWXlpdXNlUXVLTzV6d1A0bjRTTk4zTGYrc0g0Q1VHZzVvUlBMcUx1?=
 =?utf-8?B?UlFkM1o1RmNCWC9NRGVCKzJhOVphdmdNcThwZXdrWXM3Q3YyaHhIYVZzN21K?=
 =?utf-8?B?MkZueFM4K21BcVI1aFlJVzdqZHZVMWYzMndoNHJ4RzRsMzdWUlM2WkthVURL?=
 =?utf-8?B?RVl6V2xDRmIvT1YrU0JsS1diWjNFSWdoRWhxdHF0RzBLcXhvWXlvSXhIN09B?=
 =?utf-8?B?RmNJclRUSkhoaExZT0Rad251VHB6Nzh3OTlLN21iVUMxbVdaODIzT3czSk5z?=
 =?utf-8?B?cnZNbFJSaE1uVE1EcW5KcGYvblB4Z0JMMDVZR1hBZW1Qb0Z0dVlsbjVwVTZK?=
 =?utf-8?B?c3RadmltdUY4TnFDNXV2aUZWN2hlVDBHN09HUytDUDRwWllNVDNmeW41TFg1?=
 =?utf-8?B?UU4rcDJpcGRna0M3dFhMMGJMU3RzQktiRi9jU29kT1RlUG9pTUVaQzQzSGZa?=
 =?utf-8?B?WG5zSVFEZnRQSi9scW5YOXFtWTkydWdmZVdaZ2wxWVdheDdmNzJTR2RpUkRE?=
 =?utf-8?B?N0R3SHZVODh2NnlzTlYxWGIvU1NJdzZjcERlMGJLS1JTaWhRdm5aNDlDUmlk?=
 =?utf-8?B?dVpoN1Vtcm9id2FrYU1XWEp5dWpleDlyOFNQUWtFREZPMGhSeTU1eDU1ODNx?=
 =?utf-8?B?UGlPVm9FSDN5RU5rdDhyeFF4TmNvdFhhMG1uSFVMSE5ReGp1Q1pxMy95S2xM?=
 =?utf-8?B?aTVxcXhwd3lYamY4b3dMRzdESGJmbEpiRlJqM1hZMVFJZHJ3WUZzUHJ0aWty?=
 =?utf-8?B?bWxRQ1QrdGJneWYvUXcyaFZrbC9aQVFJYWJQMFhRWDZtT3o2aHltQ0dXdGV6?=
 =?utf-8?B?TGU0MjR2VjM5djBLU2x5MlpVN2JVc01lYXl6WVNkTXlJUThBakFza3JrY3lO?=
 =?utf-8?B?d0w5MnBrT29jblI1aEJsMHR1dnU0OXVhb0M0UGN3djB4NklkYUpQTVAxRUR4?=
 =?utf-8?B?RHRsekhrZktzR0ZRckY4VTY4SUNabHM4L3Fuc3J0VlFORy9ydWVKQWkyK25j?=
 =?utf-8?B?U2tObHRFSzNFUENwdE0rVHRrb2MrWENKYTIxWUhHYVlXKzJUblgxaitFZWtC?=
 =?utf-8?B?OWNzYngxZVI2T25MbkdVSDFydWdQeUJNQXhtdXdCeWFkVlA0WTIzRWNSdjB0?=
 =?utf-8?B?VHVyMlpvN3gxTmJ2QmZkWTE4c05hMy9vakloN200dHJrblp4VWcxbC9oLzFM?=
 =?utf-8?B?VlB4VmNUcjlyOERxeUhHWGoxR2FrVlNBU0tRRGdpSkhEUTZZMEFMMjRaQzJG?=
 =?utf-8?B?SmtPUHVSWXYyenNYY2Zka0gwSDFDak5KR0h0S0ZpWjhtMFB0bVJKZHVtZnVG?=
 =?utf-8?B?UGdnNkV3RldJeDlsbVVPU01zZGN6cHNSc0VkcHJhME11RU1JSWZKdksxdEhY?=
 =?utf-8?B?VHM3U2RMVVhFeVM3TmJDWlZ5OTZ0UGxBVk93Q0RJL0s1VCtaeDJMdC9Cd0ZX?=
 =?utf-8?B?VE44bFREbkhIU3RoVkovKzRXRTN5Tkd1MThnT2htWHNpVHdib2lBSGk5enVS?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wy34ZkTFkNuuqTPRD2enExpJgFofKd5vr4Fe/XPjwB30zp3yVnelrMbG0xta/qtWorP20c5Tbb0JkKgJd2cEaw1JazBBDBRwQPIijzWd0TltbNOrA/ZsRe5YA8jKIAdv01Y2vn7aVy+vY2UX7hnWkBgXXGZtIDOfBCc08u4fDcD2v6wep0DfLLdZ4NVXQV5E1HHXwNv/bSFqiMItIQcEeG9RXc7mCwvNxhSaRKmPM+H3XzxaFqsM/shmgw9EKG9Wa/DZFaM9ubHusXp5VYGfJ8vjJIM5v3KgTPYgIFuzcVrwfe0QGS+pjl6KO8voIP6kCn6srf1YZMoUNP+XI1blfoBJOLnl8uo43fzGYR7Bf0EDeRLfY4ltS8f7jzpvVnSybaSfY628QejwpJ0OgPwbUcgYtm3X+Rk+VTlB7FgA/LZBGAmd/QvCprG91dGtOoTg4qQ2XggVNgj/4yHDrisL0uqIchNbX9pWCH5eK5006q7JRucXaCAo9meFda4Klf2rIh8cFZTIsKOP5HeH7PCRAS3rs3fgSvDIQoHR+kR0zHplbD3KuTWD1yVepiorwhC1gyY0Ht+NHi/T2cJimyEjB+Yw51WbMUXsDq4Q/i7AgsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4133c12-1deb-4c1e-2f83-08dd61f5dc07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 06:11:14.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9toadtLXOM/rmZClYA3YLmNpn5nTBLpHV+bphGBoMORiXTRKeiUYSRVSaSXPixNOPeH8pROvlQWfvjBuZoPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130047
X-Proofpoint-ORIG-GUID: NxY9HdO76OMelz7o01oBNTKZA50oUqWR
X-Proofpoint-GUID: NxY9HdO76OMelz7o01oBNTKZA50oUqWR

On 13/03/2025 04:51, Darrick J. Wong wrote:
>> Hence if we are walking a range of extents in the BMBT to unmap
>> them, then we should only be generating 2 intents per loop - a BUI
>> for the BMBT removal and a CUI for the shared refcount decrease.
>> That means we should be able to run at least a thousand iterations
>> of that loop per transaction without getting anywhere near the
>> transaction reservation limits.
>>
>> *However!*
>>
>> We have to relog every intent we haven't processed in the deferred
>> batch every-so-often to prevent the outstanding intents from pinning
>> the tail of the log. Hence the larger the number of intents in the
>> initial batch, the more work we have to do later on (and the more
>> overall log space and bandwidth they will consume) to relog them
>> them over and over again until they pop to the head of the
>> processing queue.
>>
>> Hence there is no real perforamce advantage to creating massive intent
>> batches because we end up doing more work later on to relog those
>> intents to prevent journal space deadlocks. It also doesn't speed up
>> processing, because we still process the intent chains one at a time
>> from start to completion before moving on to the next high level
>> intent chain that needs to be processed.
>>
>> Further, after the first couple of intent chains have been
>> processed, the initial log space reservation will have run out, and
>> we are now asking for a new resrevation on every transaction roll we
>> do. i.e. we now are now doing a log space reservation on every
>> transaction roll in the processing chain instead of only doing it
>> once per high level intent chain.
>>
>> Hence from a log space accounting perspective (the hottest code path
>> in the journal), it is far more efficient to perform a single high
>> level transaction per extent unmap operation than it is to batch
>> intents into a single high level transaction.
>>
>> My advice is this: we should never batch high level iterative
>> intent-based operations into a single transaction because it's a
>> false optimisation.  It might look like it is an efficiency
>> improvement from the high level, but it ends up hammering the hot,
>> performance critical paths in the transaction subsystem much, much
>> harder and so will end up being slower than the single transaction
>> per intent-based operation algorithm when it matters most....
> How specifically do you propose remapping all the extents in a file
> range after an untorn write?  The regular cow ioend does a single
> transaction per extent across the entire ioend range and cannot deliver
> untorn writes.  This latest proposal does, but now you've torn that idea
> down too.
> 
> At this point I have run out of ideas and conclude that can only submit
> to your superior intellect.
> 
> --D

I'm hearing that we can fit thousands without getting anywhere the 
limits - this is good.

But then also it is not optimal in terms of performance to batch, right? 
Performance is not so important here. This is for a software fallback, 
which we should not frequently hit. And even if we do, we're still 
typically not going to have many extents.

For our specific purpose, we want 16KB atomic writes - that is max of 4 
extents. So this does not really sound like something to be concerned 
with for these atomic write sizes.

We can add some arbitrary FS awu max, like 64KB, if that makes people 
feel more comfortable.

Thanks,
John


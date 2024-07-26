Return-Path: <linux-fsdevel+bounces-24325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C692B93D51D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D228507C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79AC1CAA4;
	Fri, 26 Jul 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FuDl9nuP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z+WR8lIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0C17C9E;
	Fri, 26 Jul 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004205; cv=fail; b=KcU4243m/uOpyoJt/YAiYzhG8SZ2SI6klHsIoVUC+HbtPRT+GVOWi6wiBlSKVV5C0wgKFBCgBXszY7eK//bEmAQlcuoaBAIitZIv2qmc53lpCvwr7CWS2A3iocAHd9jMii0dah5+K/boBd/iguxq/u0v7eYYk4bb5L0bCTuZxdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004205; c=relaxed/simple;
	bh=RNFutEpoeWBhoKltN4C/evGppv8/7R6YeLaRGPgRitA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bfVAqvj0ai2ra8zPZTxQ1MQc8L426ma6kTHhffQdjDv7sR//h1o5lgj/QwIYEcrhaE2SSAsnttepO68oROslcgTPfk20zk8PpegCTT0xTAiMGzaWAqRTqIO5wyZdt3lDZQYL+lPvMYsS2kg07ZTs9GJpWbn8DZASQRT1p+Xwh4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FuDl9nuP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z+WR8lIi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q8tWkt026130;
	Fri, 26 Jul 2024 14:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=55DergVDQaxaAT9GzN851zBhbcLwYUO9xM/gOylIm4c=; b=
	FuDl9nuPgFW085tGIBFW2RAtN2yk90VpusIs35yzLWgpmYsXoyKZJ3ptM5EAZiZY
	oxOBPTphEtpsJNQe6yoQIepRagaBb8wnRuWwsu9Z6Sv3rkZvZGMPz7fApgyWlqGm
	AlktF+4Il7JJr89xyrJjbSE4X7SU0nHDsZ3id2N515BiH+k6Pheu85XhabymalEO
	MnCvhvmZabK1M2AWpTXidZslsmGke37tYcXnsQbtwCuekf7E4NDafDBar6u4gLrF
	yp1fYa4lZZ/CBv5AA3v6LpL2YJ2PhptUIGd/ei8mtv5XZCfvQcH7LAlOEVo++Pt/
	h18x4V93pBibEWD+BWzHgQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7nuh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:29:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46QE4Slk013501;
	Fri, 26 Jul 2024 14:29:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h2a5rawr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 14:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXcM+ftiLnmMhSJxqJS2g2HItA4CN0TZPj4jTKM3yQxP0TjECphVw8EuSd10QP5h8B8VK7nAUHwdm+UjRzSkiRjKDyI+c5Sfn5MLb0gmvoJdFzqvRD8L1ialDgPOO6N0aToR5d7y5uPdMBlFwvk/HO3SQ+DU7LXMyraf5N5VYUwLfrjHITAsypp7u9rwaRho2NGfY3nortLd2ogPLHSVCl+9jymKj1G8B7e+wjz5y2L58ydaGLseBWeisC0e1lgg9PIYp5OmDpJL0JcHCUz7LA6/iEEvEP8GOxC0uIQdBr5nhM0gwGkpEuczZxkORfjr/X3Oei1OR3FUbVxECsH1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55DergVDQaxaAT9GzN851zBhbcLwYUO9xM/gOylIm4c=;
 b=lh7ePc4aY4lIqOlw5lfG6PCsTLo4r9JdQfg6s5saac6Uupc0RgQpYcMM9gMa3l5jVfnEEudiKcGK20Jq5nh/XjIiTz/km155+16r6rDk69dSUzrX17u9nsijPU5pqHAh9EDT/kdobpXAdxquTgZybK/Tv5ISi/wPHHjKIN3JxpJi0PLZI/XF8L6PSwdFmS8k8vSu9CCdnZ0KuKRbr8Mkd1njs0vdxhlVS315fIXB2mzTLfCjx7ebMD2S3QcwdBSuFhH0wuON8ectBDA6CqEQQ8PzwD92Qa0wLh3u6Di6jre2A+FQuPCKoaXY1HUOKWA81JlYzb/ti/T/8e9Ppq6fRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55DergVDQaxaAT9GzN851zBhbcLwYUO9xM/gOylIm4c=;
 b=Z+WR8lIiw/14BMOguaDLiBBT7SbrVNueC+vuIeuXW5eJP/HzvjYfc1NT0qgwzw3ppq3E4C7voMkRPQqJNiXVGiOaL00kDKQbuCgLAGe4U/wJyr5e6x83GcmXSA+ajcIPV7strn6bqM1YS9sBKftRpkIGbrlsckr0D9DaeWJT0Hs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 14:29:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:29:52 +0000
Message-ID: <c8be257c-833f-4394-937d-eab515ad6996@oracle.com>
Date: Fri, 26 Jul 2024 15:29:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
 <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0062.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0219e80c-9f51-4086-462d-08dcad7f693c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG9oZTNTRDQwTW1ZbU9xeTcwUVB4SVZtVUJHU09XaHMzdlJCb2J5YzJUMmpt?=
 =?utf-8?B?V1lQSjVaK2ZhbU80SGlsREl2aWJMYmlpSTFCa0F3dEJ5a0JLWExwb2p0VUY3?=
 =?utf-8?B?OEpsYWlqTFM2SU0rVDRlemRLWmRKVW1QQVhmUUR1OTZaeVl1MlJKVmZFN0VB?=
 =?utf-8?B?ZDBXRVIrQlZ0SFU4S0szQjlSU3FBYlg3S3RydHhqWHE2YnRmWjdlK2VIdHg4?=
 =?utf-8?B?U3RKT2EvZzJEU3Q1YmtJNG9ja3g4eE5EcEFXZzh1WDdEQzVxSms3aEJqelZq?=
 =?utf-8?B?cW42alVEbVFjUE56d3hkTkk0M1lZZHZGSUl1d3AyM1gzTUZ0Z0NNNFlYb2lG?=
 =?utf-8?B?aWFxZ2tXSHhKZ2RaNU9xU3UwcjZ0TzZnT1h1ZTdJSWVScVpvcW5PenRFSnpz?=
 =?utf-8?B?Um9XNFAzN29VNk9hWS9tWENRcTcrWnRXRXBRNWczUTdvZ1YxZW1hT0wzTkdR?=
 =?utf-8?B?ZHE3SEFmNmVrZzJVK2pnZjN4UG1haU1KMC9jc0Fic1BDSDJsNlFoazVBSXZG?=
 =?utf-8?B?QnFRYzFBQTJ4dmJhcnJQQ1p4Y0g1NTRvZ2pla3hOV1g2MWcwZzZQY1p4MG5n?=
 =?utf-8?B?blpzZ25Ndk9zOGUxeE1JRFEwOWFXVnNQbHJkL2xYN0hvUnNFcG5JdkhKSjNG?=
 =?utf-8?B?YWt2N1U5Wm55T0VDaC80QXQ5MHBXVHFUcXVhT3RvN3JQVzZ5NEtRQlJvdWhC?=
 =?utf-8?B?RUJ1VElraTY2czZhMEdDZHo2VW5sNUx6SkJ3blJWUTV3UDl3djIva09wKy9l?=
 =?utf-8?B?SzZXZllxamdseWNyUDVQTXllZ3dDckpmeTZRNUpRd0Q4OTBXUTZqeUtmMTJ5?=
 =?utf-8?B?Nk96UEtNS2pvYjBPeXc2ci8zVkVPTEpWSjQ3OW1tL2ZLZmtRYk44bzVXZEkr?=
 =?utf-8?B?R0k2WVFCdEFrbDBaUUhQcEJVTkpMY2NmOVpaM04rekF3S0QybjJqeDdlLzZs?=
 =?utf-8?B?QU5jL0xPMk92SlQzZzl4eFI5eG9Xa2c5VTg0SktJT0VWZjV3enh5TGhTYkw1?=
 =?utf-8?B?RzJ3dGJKQlNpbVJrRFVxc2wzQjQ4TWl0cW51bTcwL0Z4UU1ab1NycE85WEZC?=
 =?utf-8?B?OXlOcFEza3Uza1VCZmVlNytJQWZURmtVQkdjMmdPNXB5QlgvMGFFdFVOdW9h?=
 =?utf-8?B?ajQ2NWhvSlRxMWgwb1paQUdBNGhWdlpJWVVzR2NydXBtNWowQ3VkcDk2OFl4?=
 =?utf-8?B?OGI2R1dLNXgwakxINUlxZ3h0SHpUUVZnWGdUYkN6L1BWRkpRaUZPM1dGTHI1?=
 =?utf-8?B?cCsramFzZlM3OFp6ZE9BcW1YZ2h0eUhvUnpORnl3NnIvL01SYi9FR013M3gr?=
 =?utf-8?B?SGQ3YU9MTXVTaTk5RFczSXFzYzRibkFKQmI2aXRCRmtWRmp0TVQvVEhVWm9y?=
 =?utf-8?B?dmZnbGxKYy9Qd28vYnhFQk4xaW9tUG54ZCtRYjhQdEtiUFNTb1NEMHhydCs1?=
 =?utf-8?B?MHJnanlQbWJ0N2pnUnlrYiszd3piaUxMTGtqc3UvblNKWS92RVBNN085cU5l?=
 =?utf-8?B?elQ1SEJaQ0dNbFRyVmZjWmJickpzRmRYb0c2Y2RDNTV1WStxdnM3a0JQWGMy?=
 =?utf-8?B?VzYyZ3prSGE3YnBnMWhmVnZ0bUhhRm1ZWXdZVS8xYStPOXVVbGU3ejBUbmJH?=
 =?utf-8?B?cHA5a3VXWEF0bGdreXo0L0Y2MzVXZG10Zlk2d0VzcGdDRHFSRmVYeWtKRU9l?=
 =?utf-8?B?bjVDRVlBeWJWQ1NtejZrekdEMHFaZ0ViNDRJSEpUanRjMmtMckoxMzRnYjMr?=
 =?utf-8?B?NDZQY0J3d2NES0xvYlllcC9jUWlzS1RCOXA0TkJPelhmRFZlZEI2MTlUaHZl?=
 =?utf-8?B?V3lxQlBkQndEajM2VUZGQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWl5TVdxTmRxMTc4SUFFWm1SZ2ltVzB6ZFd6S2tLRGxjeWtVSGNpWjlWMHh3?=
 =?utf-8?B?V2xPdlgwZmRWTkRoOWlpbEZyVDl0VnRRNEMxTSs3d0k5empmYVY0SGVuZDdB?=
 =?utf-8?B?ejh6cWN0a0pDc041RldYVGZPbDZQK1VPZ0x6cytaeXhzdHF2M1RVZWg1QkZV?=
 =?utf-8?B?eHZ1ZWZWSkhWVHUyNm1ZVy9DWXVSZzRzL3h3RWJmUGxxNHJpV29panVMckcv?=
 =?utf-8?B?TTdxb094MEVkcjZTWVVvdzNzem1JM3orbGxTUS96S0w5S0txWDdFS1FVTFc5?=
 =?utf-8?B?dE9nR2JJaTJyZE5NV0F3eUE1aDVLMXBGTG9tbmowNjlvbkNCdmRiRnhCdkcw?=
 =?utf-8?B?Y0o1aVhnalhUV1E0OFdMbG5oNmxScDVsVlNKVlVsSFR2MDhSdGszcEVJN09Q?=
 =?utf-8?B?RjIxSENFN2hhZ0prWkRtaUdNbHJXOXN6SUNuSDVzdzVjaHJ5QkYxSHdSbjR3?=
 =?utf-8?B?WWM5TE9jLzc5KzRFalFLNGpWbmRhdUlIZXdNZDRzclh2RGdWRllVV2tLcEhW?=
 =?utf-8?B?UWNBZlI0UWsrR214c3FLQUpmU2N2dGt5bkdFVWtuYWJEZzFBVDN6QTdHYWUz?=
 =?utf-8?B?QkZZbTlUeEhUZ2hheXFXVTV5dndmb0lLbmVTMnVZQkthYVE4SjdHQ3RjWEh4?=
 =?utf-8?B?VFJZQUFneUdlTW52V2hvRktyWGp6YlpiZ3RJM3ZkcUY0ODN3OCtvN0dNMG9G?=
 =?utf-8?B?MzhpUnRGUFZidkp3MmtDbCt4Y2ZpS2IwRWJNWTJqejdnaFdUNGxpbTlXSms5?=
 =?utf-8?B?REtYblNDSm9oQ3U0NUJlNUg4THBIeTNoaU5vRUkyU0N0WGUrLzFNNWtSelN5?=
 =?utf-8?B?eGc1eFFaY1B1aGx4Sm52K2djQnVJaEE4OE40NUFBc2F1dDdZUWZ5WjM3cFNp?=
 =?utf-8?B?aTNLdHEwSlVNdS9XeG1BUVArREJqSC9CU2lvTGNaK0JZT0VEWXlPZXE3NEc3?=
 =?utf-8?B?dmpMMEZ6YVhKcnFMZVpCVEd2WDRIMUxnb0krL1RjTlVyOWhqQUttL05PK296?=
 =?utf-8?B?aGxTaHlEblhJVEVKd1M0K0puYkVhdDI4NmgvNWpTN0tqcEhhdlByMzR3L1BY?=
 =?utf-8?B?Q3YvMERkTUpQeDRwSW96a1RNZ0hXbGVYRVY1YWFUd1loNmErU0VaK25PMzhU?=
 =?utf-8?B?b05JNE5ucVl0RkREWkxFRVVNV3ZkNWlrYnRGY0lIMW9KTmRXR0dMOEhuR3pS?=
 =?utf-8?B?a1BzZEVIdXJDaGVmMExjRUVrcmNGZ0M3VGFrMlNLNkRoOFBUZ09jTU51ajR0?=
 =?utf-8?B?ZVVQRTBjNkxiUGJ4VTMrTHRibndETHZkVWh2eWN0ZC9qNldFbWdtLy8rNHlo?=
 =?utf-8?B?UGEyNnJIYVdXZ2ZsQXZQeE9WTFc2NHBZNFp1Q216VTF6ZlRTaWtSVm43VnQ0?=
 =?utf-8?B?eVlqaG9LL21TV3JnajhkUzE2T1lqaGp0RTZVdy9wZ016d3BEaGwvN0hLMkU4?=
 =?utf-8?B?NlppUUhhR0ZqVFRWcm5Odk1aSHAyWTdkQXVhRlhaSGljbkNwWE9jNXJNRXNZ?=
 =?utf-8?B?czFvRnkxdGZXaWs2Q0pKOE9sYWlHSXlhV2kzeHVSaTNPVUgyR1lPTGVmQ1FO?=
 =?utf-8?B?UDRLUW96V0Q3TU9nRUdQMFo5bE1lT3FMQ2NENXZUcDhGQ3BVdXhjNVhKMHBh?=
 =?utf-8?B?SEEzMmE5ZzluYnRTaGdPakRaSjlvMWRvaUpHUkJ4RkROQkI2TERvMzlwbk15?=
 =?utf-8?B?YVE4YXVmOFRrdkVYV3AyTEs1QkZxcG5pWk02VHVIeWExS203UXYwaXdvRWUz?=
 =?utf-8?B?cVBzVHN1RUthYTNrS1ZRMHYwaUlGNjl1SExiVmsraG5JY2lxT1NjNTdWd2Z4?=
 =?utf-8?B?Njl0VlRERHVlM1dSNkhUNVZDRS9DN2x1d2ZFSCtOUWNNbTM0dityMnp4L3ZV?=
 =?utf-8?B?RWpld1hHY05USkhRVEZFNlhIdVltZGF4VUZFR1FxTThBcE9XTDJYVWdpQzh2?=
 =?utf-8?B?UU9VS1lMMGFvQkc0a2FneWxob1RkY2F6M2RVdEd5MDJaK2x6MkxuZFN1cGRy?=
 =?utf-8?B?NkpuZkhyWVJaczBGcjE2T015a0RoTXFyRmtQYWlLeEszRWttL2tETVI5VnRM?=
 =?utf-8?B?Z0JhNTJ3ck5NUjl0SlVWa01ua25XNU9ydFFNb29DODN5QVNzNjlIckZBR0ll?=
 =?utf-8?B?Y0o5N3dDcnZjZVE1eGhGSDB1QkdiWGdoanJjL2t1TGk2Tll1OE80ZVFyZTVZ?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6yP9CmbRP/x5P7xdNaBR8z/F1sVuClLh6WtcDLFzrXBytYTxcygh5vHYFBd54+gTeSnOD4mRu4ZpY3uCITlK5SGzF6NLqIb7K60rn3SqnT1fB6CAKEs49YimQ9IizH1JzSIzYTuTwb6it5f51gLcZscricXVWMe16yw8avoC89I+eO7BUyIWL11JY8VauxULYQVsIzs+D1j4JzJRPmGw4ccXllL4DoKsVFnglaVh2BrYwJrqGiaxTFQL0KSlS+sCfu+dfWRrdsvrOUCNiuVz5CAKEdj5D0ZxwTYiMYUYM+sqcIDvCGkOERVBWx0MaTnB4cW5JHqi/C1C0ji7Gv4fEvghLebweR2DmuxcFYXUJYTLRx5LcprMa5UD9bhu+Yvg2xsPDqdcGEdSDthsP3fsJ3f/qCsVn6KebiBLRxeQPiFWvOc0XBaHewTsXAKX7Him2eC62vSw7fH1XrPOfg0n+yZN7HqSeIrDe57YDu1AiwEI0+iuhAUF8WMAAiMu4MdaFBV5iCbN1aubTNyygk3vaBKQj1Gkq4JCTCwNKLVjdxxLHudzYxNXacUKdbHx75xMmgassZZUhpX/4j6Gn9Dil8kLm3Kn8Z17uk8sR2tmezA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0219e80c-9f51-4086-462d-08dcad7f693c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:29:51.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc+ZGegEh3VDLh1Ifx4RsLi5OLmXLMFf+0eie3AsGQFQSU2JKgg7Bv2hXNOuJq9fAfZifFmzFm7mw28Zt9lwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407260098
X-Proofpoint-GUID: 915kHHOQRc6Gl1VQwl7xoWdIHlIvZeyN
X-Proofpoint-ORIG-GUID: 915kHHOQRc6Gl1VQwl7xoWdIHlIvZeyN

On 01/05/2024 02:07, Dave Chinner wrote:

[trim list a bit]

> On Mon, Apr 29, 2024 at 05:47:39PM +0000, John Garry wrote:
>> For FS_XFLAG_FORCEALIGN support, we want to treat any sub-extent IO like
>> sub-fsblock DIO, in that we will zero the sub-extent when the mapping is
>> unwritten.
>>
>> This will be important for atomic writes support, in that atomically
>> writing over a partially written extent would mean that we would need to
>> do the unwritten extent conversion write separately, and the write could
>> no longer be atomic.

I have been considering another approach to solve this problem.

In this patch - as you know - we zero unwritten parts of a newly 
allocated extent. This is so that when we later issue an atomic write, 
we would not have the problem of unwritten extents and how the iomap 
iterator will create multiple BIOs (which is not permitted).

How about an alternate approach like this:
- no sub-extent zeroing
- iomap iter is changed to allocate a single BIO for an atomic write in 
first iteration
- each iomap extent iteration appends data to that same BIO
- when finished iterating, we submit the BIO

Obviously that will mean many changes to the iomap bio iterator, but is 
quite self-contained.

John




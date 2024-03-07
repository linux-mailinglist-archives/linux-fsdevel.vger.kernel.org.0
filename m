Return-Path: <linux-fsdevel+bounces-13871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF03874E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1571C22D0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33012CDB6;
	Thu,  7 Mar 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FyXm4Quz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r3//Tg2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFAA12CDA4;
	Thu,  7 Mar 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812286; cv=fail; b=eQAyH3rDRzBIO3VcZF5ifTS3pa8FUDiErsPMaoRVROs30Sta0B3HL1f3jQxSFeZCTzf5RbsmpN15PW035IDB65T1peco4B+G+IzpWji9cmdXMGLbgAk8FlitPON21ji1YhXXzLLpv2H+QsBGiV4l0YuYB3IIcIkIA/0IuBl3u98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812286; c=relaxed/simple;
	bh=4/GWRaOo1taFPvbCPpSPRzTSIxBi+SsjlV9/KOxilBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ip1GDA+Bhb0bPXftT0Q4ErZ1ttUI4uX9bCCiPCZzuB+Rb7TVkmNICSpsoNpOtQlMF+ImIp2VSqbeDsAYamxqCXBG0rgF8ehiwVPYkjDEWLOvGfJfXZglc+TzkddIJ0eZXe2fiqZ9NOMydogGSMsGKRrJFus5nqtZB1yUxCAAZzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FyXm4Quz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r3//Tg2g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279n5jR020673;
	Thu, 7 Mar 2024 11:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2Pglwro0bs8gx11Zppg7byyGipV3KuuoXhVTcAIYREY=;
 b=FyXm4QuzA79pakawwv9ZvhJrxFhzfusEv8eyEfU1fKLfRJxPmc6zvD7eVjHJppEnrc0C
 sB6ucaABZsTtCLM3psz8eucwkMg9Q6eMzDBUxxg2KPKIGp26/N5fx4EgFnYoQiAMfZCj
 8WmBaaczOicKwD6lQ/uPUFbsoIV3jZeabMnH09ixqP46p+IMG7qcUGpAtT4tNT+WNqCb
 PzTHVmZ1C1YoUG4HhfCkf/8YlvkbO3ZIeqfsemhp3wB0fe4rixlOV0iUR+CIxTxQxXJY
 EI8bwE9tD/zukTEsCZXhY4a0PoO0wNx3WorYEsSaq5QJMYJVF1egXF5ErmK3oDp4XBK0 mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4bndy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:51:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 427A4hVB031816;
	Thu, 7 Mar 2024 11:51:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjb3p31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aINh2u0WcegfyNlmtGnTofiYnzluIhYp7dFA1oj7+U+5zH3m5eCgV3z2hIUnFJwA5bKB//n3+Y5aJRfduOUnyFi6EJB8R9WoKvtzUgqtXdDLEhcdih/9CuACtL16+4D2BSutAVBJ3Qw+NcBPHXxkPpWcyUA8iB7q64lWfxKi23GzX4VYshN9cju+v4gTIfsG8v1Dg+XJOlVSqtGEKn6Mtq0IqA5lUNpzh3jRFGBh/mfzV5ZAwQrw1TuskixwWHl3U71q/VVPz7bkBhB678wWn5CUmGFRP+1TVfBRUl3pPy11mIRl7cmSdr4ptm/FKe012MSanA7drMhpN2yV83TsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Pglwro0bs8gx11Zppg7byyGipV3KuuoXhVTcAIYREY=;
 b=HlNa9y6rmVaYQmpnjWLiJVDs9u99+NJl58TrJTW93x0kJRVk0BQ8enMvoF2MWmXb2GwV7x6iS4LWtQP+ncUfIWkmfawZRNlK1npqLVjYjEKxjlSItKR8jYx00jNT+9SAue/IN5zkKqlrRX0W4POk7zO4rIXgtdEdUfygLTX7TXKXzsMU8St/LhO5XICI6WGDEtV4xK/jBv2ywWqcwyT22SHjUd4nVWJ9tsnL+OYcKR53pgFF70nF0kcvntKaZQEupK4CXiUuMXRYH58aqL4ED89hxjdEutCmAJdFKiW+1qQvvfl0pzBhrT5W0yzSe5VLJUDDGunMcOiYzhT9u4jJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pglwro0bs8gx11Zppg7byyGipV3KuuoXhVTcAIYREY=;
 b=r3//Tg2gt80hAaalenFlJAk3OpEIzL1VbHT5gfFlWYptIsgcYRZA89kYLdEgl6AtVGttqpym3u32PydZ059BJZ6BYOtpqOvdbVcbzsSMHDMZ9Tr+azzvTcSmYpErOO3H9DIZyVWJyyjSA9tBi2+BJE1hhOPLbS7r6W+fskf189o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4202.namprd10.prod.outlook.com (2603:10b6:5:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 11:51:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:51:06 +0000
Message-ID: <685223a2-4a67-4b70-8726-5a666224b2b5@oracle.com>
Date: Thu, 7 Mar 2024 11:51:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] fs: iomap: Sub-extent zeroing
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-8-john.g.garry@oracle.com>
 <ZejcyPPX3bVdvJyV@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZejcyPPX3bVdvJyV@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cb3167-a6df-4757-6c2a-08dc3e9cdf26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zJKPqdTHAob4yPhj3EhmfmmnJz5dFLl8XlRarZbJg1ygzpn6oaxsQSclN12mdcLc+RK7xzWWYqEpjcEYx1FInONAHCrXPCqXooC1lhNNVGJDz/LzZFDWiY569TaxD3NiBC++7tzdRaV+HfQANoU0ac1FctbH3K/JT0BQoEC4M0G/wkNM0Fmci2IdBnZs5L5SNY+nBVkvXQZvxxHfAXCSO6CDgrTLBBYCkft3QkMcN3nP+z8VvP3CAIhZe1GkOf0dYe0vjFauIy/VXfcgThu0kxU/GeIALVz88mIOcrhnDz039TYmaNWTPWTJ0naXtebAJoGUdxQ9dAei8wMADQpWIQnH5nzY8J3HNEHjOc2f3ZTxQkKo7/CxKc9NdUXQmKVU7+D+Ljk/CMV4bYYscfodXxnQQvES1JpNOl4BCnutqwnr+35fgC9VMBAjvBFf+WZ/Tcs1CmNVZR1E3a0Dok6bTrmCMqbuvgkmtRMCLmkrv9IyVyC99OZScVDTYPn8cwgd/+ZI90lbHcm3bCPvdXrp2IpoO/940xqQV7r+FScuw0ZFpqyC5i9n9q2CTSZdkl95CZ0IScoXoHwrafCqV291KB5VAsjRAFiZfCek/HQNsRfFGCQnSaDynf1mveW7eskkInH5du2dqxxUe6zwkRSLKw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzNGQXdTRVozTXdCNk9TNThDRnlEMERqcGVhRjNjRXFQVlJPajJXa09TM2FC?=
 =?utf-8?B?VkdNeVZMUVI0ZUJjanlQdCt3T2IxT3BhMTcwWmxIelBlQWN2eVZMTDc3RDNk?=
 =?utf-8?B?eVlONDdMdzFURkY5aXhsQXp2UUQ5MFBxZ1gwQ1U0MkQ5emZkSUh3UzljV1hy?=
 =?utf-8?B?T1lwZFFsbFUxT29MUUdJR3J2TDFhR0RVZnJaVWhBeUhwSWtrZ2hhOXZIYVNW?=
 =?utf-8?B?V3hzZTVqSFRxWjVsRjMwSENKMWdFdS9vTWJCRHc4OHVvRlk5K052RHVqOUZX?=
 =?utf-8?B?SkZoV0o5VjNVbVBNdzl0TXlwUXBwclNNUEdtaUcycjhuK2tTQ0dDK0JhTHY4?=
 =?utf-8?B?dnFzNUdmVmN0aU5nbERUY292a0d3Mm43RWxrV2RNMVpNMHJ6Mlhrdkk5MU5r?=
 =?utf-8?B?TThJRVF5K3FGNHBQa3BKcjZndFlJQlZ5cktPNWtrWWw3TUtldXJKdlZmYXdQ?=
 =?utf-8?B?UU9FR3QwclBxQ2tCVWkrcnRqTi9pUE9uV2FXd2l3c0c1SjFUNVpKU3dUemZt?=
 =?utf-8?B?aTJMb1R0MEdTd3pQOXVSdmZ6OGptYTVBeGJDUXgxWVJiNGJ0WHcvVzlSL3Q0?=
 =?utf-8?B?dDZrSEpDL3E3ZHBuUEtTZUhLY2VlZmVtclNTb20zZzR1c2tpUUIySlh1ZkY3?=
 =?utf-8?B?RXZXSjFZRHhZcTRpVm45dmhoMVVBVG9hZlFUaVJBVmtWUTVEOFliTi9DRnhW?=
 =?utf-8?B?VTJLRFJjTmZrL0xHVUloRUhrQjAzaHhuNEJ4b0RRUlBkdFp5cDVWMTJVT2oy?=
 =?utf-8?B?NVhnRjVTSWFnbkY0amppMTJyNEtBNWRES29kVWIwSmU4SUplWHhldnlseVNt?=
 =?utf-8?B?OWViWnU5NE4yelpCTXdYeW9PRndzR1hOSFNscXFad2hKTUtWbFZwSU5uVUVB?=
 =?utf-8?B?QjhxNHkyUEpsbVQ5N0dkTjJZdEJnTDhmRDF5NXprUVllRkpFOFlRNDZESndJ?=
 =?utf-8?B?SytjbGNqWmRIYnptcW1IdElySmEzMzVkZERGMHhScUUxWkNEaHBXaU9PQU9L?=
 =?utf-8?B?b1dQenIzd1VRUGNKY0U0VlhWQjB0Uzh3S1JXaWIwLy9PcUJJSGJSaTlUTEh6?=
 =?utf-8?B?aXdGQ2MwS21JaktpSXNvbVh3L0FXc2pvQ2ROaGVock5xT0IwU2RTZkVHaFNP?=
 =?utf-8?B?Y1R1c1ZOWmxNTklMcDBYSTNEV0ZXMGM5eVBXRlVUQ09lcXF0R2VzdEgvNURu?=
 =?utf-8?B?dE16RVZpMUZveVI5VkRHQmRkMG5XQXluUHoxREJLdWcxNU5YaW9mb0dIUncw?=
 =?utf-8?B?NkF4TDJYb0RTK2lJVlBKZHBRNVlTcVhlOE8zL2Q1dzdYd3J0M2tpaGFzSTZl?=
 =?utf-8?B?eWdzOWlGVDdsUi9Sb25tbGNOZ2VaS0kxWG1rbFNNZ01hYzlqT3pQdHl2dE01?=
 =?utf-8?B?QkNCNncrSSsvenI5YitEekVDd01pa3hMb2Rva2RUNmVRYWJwU1hYaHNuOXZF?=
 =?utf-8?B?V0xWUFBGNjU2RTdGYkRGalZpYlZjZ01CNldoQXk0M1NINGo5TzNuRU9Mbmlv?=
 =?utf-8?B?WlMyaGdkMGlWaGdha3M2MFROamV4blh2QTVnWUtEOGxPTWo5RkhneEk4VlZG?=
 =?utf-8?B?U1Y2RzU4Q3N4OXFkRTdhQUMyb0hYRlBSRkVXQ0puRG40RS9TcGEzWnhZYXhY?=
 =?utf-8?B?SEEwUC9wL3F1NkFqMkIwNWV3bVA5UDRBdklMNSszcEdleVIxTEtqTVZydngy?=
 =?utf-8?B?Wm83dmNqekw1Ym9WVi9NRXBFT0tFYjYzaXB6dnpiWmlGTFVxcGlpSVdVRWcv?=
 =?utf-8?B?UkRMYkN1U0EvT0U4OVo4c3VaYXRvZmFTZVMxMzBmNTZoSUdJSS9zTnptemp0?=
 =?utf-8?B?UVZRQWtSWWJ4VVg0endQNmZ5SzNOelJUVXptOEV6Ulg0Qm5yZkhseTFIdUQv?=
 =?utf-8?B?TS9uWUFPTUhqNXk1bGkwVFNtV0R2V0E3MHo5WEo5aWtDMXVJNHpaZ1FReVpk?=
 =?utf-8?B?VlI4NWxmdzFrN1BEVmowN1FxRVVBd3V6MFYzTTUwK1ZNaFFqTzZmc29ZR0U3?=
 =?utf-8?B?MUd3VW5YZ01tZnNjdVZwOFQyMlg2MXkyTnhMcGJVczZCbHBLeExWaDlTaC9q?=
 =?utf-8?B?b09RZU5Iam1RU2VUREdSN3M0RWxLc2VYMmtZNk01cVpibGtDa2xVRlpGYzJ0?=
 =?utf-8?Q?LVejT4ClnmWL29yT1kpOMYqW8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Si+qXiV2rA0WiW/6H9DTmnKDpfL8HiLJA2Ow2x46CNPEWopKgS6KEXDGqF4PuwDy5JRISr2p28eStp63KAATTQELvweRI+QZBYklX2FRPlSwLL46pTzIKb/Ex/AdU6BNSTtXORgN/WY/eD+xke0KbJFccfryzKTr+g448j2nym4NgVk235ytwwy2tE+Ennlp5wz68Fqh7qFb7X4dmFftmW0lHKGJRecRT0TPYPVDt9+JoHwsJgI1rzXKrgXBBnD3Rbavd7Bz5+7wHsUxl7QH7z9YsFBrXRtKsttqD0PH8kHqirdNg2DS/BexpdxFdBlF51eKXC48ekaqsuUDQljfiBQNdm4RzrOPfAoZbqpsrNMenJA6yCq048yQx9ZqVOFYFAAv+nCqcUouqlee90meMjPVe9CM9sAsJ7o0IUZaJ3+rkYVPxKDCDULikzpiXMWt8JSHJfWlVQlbCHBIGvHs92WdcUJkdFrjehMxjV1MlsX5cvln9vS9xdUmVbQlqq6WsJucJFOEyLkaO4UTJvkhubS8BhMbfcIWJNUyERhJonImdJD4Mbs2EIfuPwbP2RbjlCS0mOQvqvKl1odbYSylRhhQE6Pk96ng3T9WVNnwQJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb3167-a6df-4757-6c2a-08dc3e9cdf26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:51:06.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNdLfGK5OMSz3Nd4gF39QoSSQxFHaLOOp2kowxAhyRZ2D2M/CEbvTlHINfzqFR7MFYwpanrkWW+HCXKQ3+vA8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070087
X-Proofpoint-ORIG-GUID: ehiwCwK9Bb66FTrXgmirfTyFq0rIUkQ6
X-Proofpoint-GUID: ehiwCwK9Bb66FTrXgmirfTyFq0rIUkQ6

On 06/03/2024 21:14, Dave Chinner wrote:
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index bcd3f8cf5ea4..733f83f839b6 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   {
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>> -	unsigned int fs_block_size = i_blocksize(inode), pad;
>> +	unsigned int zeroing_size, pad;
>>   	loff_t length = iomap_length(iter);
>>   	loff_t pos = iter->pos;
>>   	blk_opf_t bio_opf;
>> @@ -288,6 +288,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>> +	zeroing_size = i_blocksize(inode) << iomap->extent_shift;
> The iomap interfaces use units of bytes for offsets, sizes, ranges,
> etc. Using shifts to define a granularity value seems like a
> throwback to decades old XFS code and just a bit weird nowdays.  Can
> we just pass this as a byte count? i.e.:
> 
> 	zeroing_size = i_blocksize(inode);
> 	if (iomap->extent_size)
> 		zeroing_size = iomap->extent_size;

Fine

I was also thinking of something like i_extentsize() for vfs, which 
would save requiring adding iomap->extent_size, but decided to limit vfs 
changes.

Thanks,
John


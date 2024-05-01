Return-Path: <linux-fsdevel+bounces-18420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077AF8B8855
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 12:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4011C232BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4452F6A;
	Wed,  1 May 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cTcRz75P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dt/11LVw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202743A1A2;
	Wed,  1 May 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557824; cv=fail; b=kai52ytF02ct7rpaPyNiFmpUcAH1tnS2ZcP7/F6MOa6vwMTsCDKikKKlLW6lpKaQac25lp8XFgiSdAGMGhlWtYetLZtXFFLYMje49CdqWLKvpDUSNTp0Ogn9VQKLrz377cFWaSbFku3K2Co234tqTXh52VYklnaxSQRYfg6vYKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557824; c=relaxed/simple;
	bh=yGTPRsPRJknTEc0CYWmZFFDMCgyjjsTYeorIdFdo6sg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tqPMdqHPBM2UJ6LQB2RrkaWKtAp1hF8UPtU3Yk0Inppio3SMIlvw6AhfIF+sNJ8jkEht9pBdb2w1dc+Ekn09VOSX/ES6XdciJYw97ZxTshzE7eCK3qK9st9hJ8F6qAuWRnlIFk5RaEC4m6AfKun95iPAoEIhoHj8dlzRE5JDF/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cTcRz75P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dt/11LVw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4412j09J002560;
	Wed, 1 May 2024 10:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6LY9AklkoQW5U3F2bqkuWMC86UTTsix3CAHQw6t0z4c=;
 b=cTcRz75PWZGwTLRMDaHpWCuLUQHZMEIbhH7WIavA+CMMWoVjnrblBbELgy+NO3lxSqN+
 U5zYNTSEt2EYUBCJSewrk9tnT8HUbUh7rHhLrgcPhyAYhLh318S49UyPRVgGR0vglMpq
 cBkCNaCSfLFrXbyNdpkFAlYWrjuSYQPeDpO7Oggb6YOGnJmAx4IxcEKL1mrfN3daPt1I
 Fljsk0CExK0VG1LVy8FjeiGA/EcQxJyavNMpif4ILSI87s9F2H66GbjsK3wsetaYoJ8e
 xFGRwizwb6CxuR42lFPFYGax4sbVvSIlzvkmXZaBMg1dKbj6ULILYoXmnYcolTB0N04P Lg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cpvv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:03:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4418LAUL008609;
	Wed, 1 May 2024 10:03:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt96j2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 10:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luTfLxxBuJ+LtTR7XYZhU20mVFGsda7HxwyiSxTocuUmF6UjO6Lk2QPrKWFqSJnsyPHIoIFZocjWEc2638/sAzahofYIZeFUPT8Gsdj6DbB3nYrFMOLO4tegW039564kqcmI4Z1JdJmOPAxVfO122g6USS0eI2YQIez4/WCpYx2jLcYuKOOBWGfPrFkez04xKPDg/2plgvkoltZWsuMkbjkkK/58rabH+KSzsJv5OM8IBCay3kLmgz/pOgy9XrP2SOV0b7oxIldoLBmYWLEiZR2xBMVE0FIM1TaTXEb7h0wE321SqFR6f61TKrlA2l8DCXX9xrXyB+RtdiSvj8oXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LY9AklkoQW5U3F2bqkuWMC86UTTsix3CAHQw6t0z4c=;
 b=iCrqKs6bVId9S+7At20QxnAK9FXFOVhfVzJKSumdy9hdrXBeIs+kIesxnOwsbF3BOyVRAOLe/TBfYIb0QAxZT+X9h5DHwTgOBbGatMn+dije4fmWRVCRRtoVDPDS5K7zMP04u3QOk4fGXlaQkn3Xx9MVSi9WEGp5vDxWIy0qSvygOjD4EBpm563OouzdtRNrhHF3nsNOHUH37lnw+njk0ATrP9hgEBVt1i+l0F2ufN09sJ7AYX8N30YTAZA6y669KNn+rKVNuMqP3xJmOYFV3KxCQifoN4JQ6aH/SDayQvkm+BEXsO7D2UYgNLhcx4KzBxnIh4e6atfulB2uOjoupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LY9AklkoQW5U3F2bqkuWMC86UTTsix3CAHQw6t0z4c=;
 b=Dt/11LVwMUArCdQE9qv3HcdZZzEGPLuKUDj9Z5ZOtmQdSgpwvNYnnieWTvYJuy0RcV2jtAGHCEgbWOEJd49JODbf7wOJJUAFAhZTKlTbRBkGSZAAuY0RGdUlGJ42OX0hXkGiA6UMt2bK66tcWLSM74LAHmBmvB5/L0liZEGS6Lk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7051.namprd10.prod.outlook.com (2603:10b6:8:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 10:03:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 10:03:12 +0000
Message-ID: <cc54060a-2dc3-45e4-b47c-a9926553e59b@oracle.com>
Date: Wed, 1 May 2024 11:03:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
 <ZjF9RVetf+Xt70BX@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjF9RVetf+Xt70BX@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: bda5cf96-6f01-488e-eda4-08dc69c5e8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UFBYOHdENTZtUG1UL1gveEc3T1g0V0RtalRETUZUd1pKREU2YXVWK3l5RHVs?=
 =?utf-8?B?NlV0RTF3UFl0Tlh4ak1ZMUN5SFBtMjFtUVltQVRSekVKdVRKbkRnT2ZGZFdq?=
 =?utf-8?B?cFl0TjhEaGZZNWdsYjA3Vm45ekhzYytscDg4ZXZKWFlsa0wrSVM5T1JpRFo5?=
 =?utf-8?B?blJqU1dDYlNwTWVDQ3Q5UUZUazFXMDh5RGtmOExtYmVrUnJ3cUxrK29JTG0y?=
 =?utf-8?B?UVVvZ25DM3VqVG1IeGFvQnRwNmdJdktqaldNRVY3WkJxbG82SHVaTVc3WHVI?=
 =?utf-8?B?RGJ5bDM4OG1jcjZScm5FT0tiU29SSWNPRVBWb3VNWDRUdjRjdHVGMUplN3dl?=
 =?utf-8?B?bDNlSWNVWGVwOUxHb3NPaEM2RjZXOS9Pc3RYUHFJQVlUWmZVb1d1VkRITEpm?=
 =?utf-8?B?OFR0OTZ4d1hjQzhsVmpLcTUxQ1JNdG1pSkZNUUEzU3NCV2FnZWRad0NMNGVP?=
 =?utf-8?B?TGpndWZERVRpN1pFMmN6czlCZE54SEw1ZElWakt3T0U1TnYyWGR5V25uTnlr?=
 =?utf-8?B?dU4xYWtBOTFGeHVnaS9yQ0t2VEtPSDc5RnhNNjVjQ2pXeUxUVDZBMy92WTFM?=
 =?utf-8?B?WmJxb1o2TnpObXFKWlYxVGo2Rm82WE84ZHVQYUVHM2luZDNQZWxVbSttQVR0?=
 =?utf-8?B?S2VZRGZYaG1UVW1YUkFMdjU5MWVFNGozazY0b2xoM2NheHo4YTM1M0gvb0Zk?=
 =?utf-8?B?dkNWc25vQXJQbHlGWndaUmk4S1dVUk9FWWM1cE5ELzlmckR5SFU0cTYyUEVW?=
 =?utf-8?B?aXBSUkxYUEx4bnBzUkNuS3VETkU4bjFmVi92NEVDa2dlc2ZUTEpZS1NGUUlH?=
 =?utf-8?B?bHhWV0hBRWlCdXpOZjIwOWxVRzdVem9NbTE1NUo1SnlMQzdUdnRFMStaY2tw?=
 =?utf-8?B?ZjNOZlFiSVoxVVNPa2lxdExieVVHdTg3TUZTcUluNmVDd1RNWVJzRGlpZXNS?=
 =?utf-8?B?dVlJRGhhTFFLV1BtNlBjVUJIeUpjY3pyLzd4L3Vrekc0aTh5Zzl0akFwclNL?=
 =?utf-8?B?eHJubndvMFJmQzMyYlRuS2NRL0M0VjNvUENNR3BLNUFONUs0dG8xK2V2ODNy?=
 =?utf-8?B?OXRCSHVrWENOL1lYTFBuaXJCWWpGWEtqaWZWV3JVamg4Y082THB3d2xtNUY2?=
 =?utf-8?B?RW56Tk13YWtvSnNoREdLNGJoRUt1WTVLNElScXBpdkEwdzVTQ2RJUG1oclRP?=
 =?utf-8?B?VWNNSHc0VnBVRkxoS1pFa0k4ZjlCODR2dDlnNkJiczVrbHVibVowUVVPRC9P?=
 =?utf-8?B?NE5EYWpKcWp2WEtuNE92dGt6RmNUb2dtaS9YRjJWM3lvMUpqcW1ubEVwQWRL?=
 =?utf-8?B?UE54Lzc2M01ZUGxNbTAwdHlVd3FlU1BjTm9ZajcvMFd6Tks3anVnS25qbU0x?=
 =?utf-8?B?THY0QWNuK2xFVXM1TU5TREJpc0VuOHU0WEp6eGxyV3Bkc2t1Mm5SNitsN1h5?=
 =?utf-8?B?SWFlb0VtSk9kYXRjbjRLRFQzOVF2UEhhMmhhdmwwNnIybEZlRGNrT0ZleXEz?=
 =?utf-8?B?YlVjMmp0NkgxQVRaNHFOZm9DTWJkNWI4YlNGMmp0RGs2ZkNpSE5OOHVxdHUx?=
 =?utf-8?B?dWhZRE5qdnNqbzRrR0YxUXJTaGFPTThmZmpXQzh1YmJEQkZPYkxJWS9OSmx4?=
 =?utf-8?B?TXF3d0cvNTdrdVBDYmxGUzFxaXBTM3hoQzViL0dLS016NzNrejJ3cGtyL3lR?=
 =?utf-8?B?K1gwYjk4WUI2dEMzeWt5NGRWQVI1VXRqSFNLQkVhSmQxRWd3ZWcvbmZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZTA1YjNiTlJwbGZicUE0MHVxZGhIN2JRbXM1WXUxVERJUVpMaUpocmlRbnBj?=
 =?utf-8?B?TnQreU11NVdLZ2pPaUtsNEtpQTFUdFVKYmQwZXhRVWZDTUdtRnllb0JRTC9x?=
 =?utf-8?B?b01jYVZGTVJIdkpOR2tCNjBLbDlhRHF0R3VvamhNZEhCVTNhcUNxOGdVWE03?=
 =?utf-8?B?YWFjd09aWnRlQTFkZy95K1J2Mkpxd0Z2L1pBbjNoTVR0alUwdG82Sm52UE5k?=
 =?utf-8?B?dzUyM3g2dEhVYTdDemYzK0NOMDZjUEFOUlJCcUd4cjNMQjh6MVdRYW5qUGNq?=
 =?utf-8?B?S0RlYVZ4bEFmb0VBMEhpZGgwbFM0T09jdXlWZy8ycHAzV0RadEJ1VGpNMjUx?=
 =?utf-8?B?UkZTeFo0d1NYZzZQUWJMeDF6WmVxaEJmNmRMZkorQ3ZQWUxpcUM3ek0zakFZ?=
 =?utf-8?B?emZlMUplL2VFRjNqVjFhR2dRdkQ1dnpuVnZ0bnBhc2FDRUlkSlI2WWdURUZY?=
 =?utf-8?B?VkltVnpyR0lBak42dVAwTWs0bC95cG82NTh5U1h6TEZqQUt1MVFtamNldTds?=
 =?utf-8?B?UDBia3FVVUpiMDVORjJ4TElFNGtOcW83WEFjdkZwZjAyOXJ3N1ArV1hEQmpP?=
 =?utf-8?B?QnJEbDlJOG1OK1dqYkV1SWJ5MXVmaGhmVkVqYWRyRlBTMXkxYXR4ZkMzc3ky?=
 =?utf-8?B?bVIxWTVONUZMcjdDQjRFeXo5TW92TWtEZ3hsOENuS3JhTGVzT1gwdll6d2lM?=
 =?utf-8?B?QjNDajRuT1hQcDMvdm1OWWhDd2ErbUpybldNK3pWeGtsSVgyY2RUS2pCbUNj?=
 =?utf-8?B?ZmtyMUxKdUhEcklGV1BSMStDRHhESjlqaEpZWEw3Mm9FRExqbU5wMzFnMlVk?=
 =?utf-8?B?dUpwdFRoc1ZHSHFHakVKRVFvOVpBaDBsSnRVY3FCL2ZkT1VXem5PYkNhMTk5?=
 =?utf-8?B?YTZzOWIvUGZHbHVBNHlqL2hMMFRaditNUE42WmFwVytBcVhYdHlTbTNqcVlp?=
 =?utf-8?B?RjZoMVdBWjgzQlY3RjR6Wk5VRjljNkxodS9aaWZVMUN4ZVMvRVYwenByWW9N?=
 =?utf-8?B?QzJRek5wWjRnWktUMnBJVHIremFrWWtvWEpJczREWEZTWTd3aVBIcVhERHRN?=
 =?utf-8?B?K3Y3bURWSHFyTWRhWHlTeGxQeXMydk93OUZabDluR3NqN0hKYUo0cXFBcE1D?=
 =?utf-8?B?WGl5OXVqelRUZG5BbHBIL3Q0a3hGUjFnTXVFT05yNkFZOTN6VmJRUDJWTTJp?=
 =?utf-8?B?Vmo0ZFVYRStYZXBVaGZaZk1tdEhOSGVmd1RlNEozQ1R5OUtyUGZmZEdxTW91?=
 =?utf-8?B?RGhrMkNLdTA5aERzV0JwdXcyMUFKMWlGTGI4WG1waFRUNXVQQTJybVRtN0E3?=
 =?utf-8?B?ZHFielZwVmdtc2RXVEF1dUZtWkY0Yko0cE51MThQUlVoWFZGSktiUXNSM1M3?=
 =?utf-8?B?UXl2VlY3M2JVTTZGV0hHODZlZU5OQTRoeGdHTVQ0WmM3QjZpUjRpcmpsM2RP?=
 =?utf-8?B?dWx4RVI5TmVsZCtIaGdkL3BralN5bkh2anNsY2RCZTd3Q3ozMXR4ajdheVNa?=
 =?utf-8?B?UmVjOHg5bzZDVVNjdzVSZGtLdHpqcHN1VmpBTHJaellyTDBaelVtY2FyTjNB?=
 =?utf-8?B?blNnTU5SYWNxeWVSZFRHWkhuVVAvdHNNcWVIbkxsR2FCWWZOV0NYWkVQN2Zy?=
 =?utf-8?B?VDg1ZHU3SjMxSUN6UlhhejlUWmtwMWFpY2JGN0xqS0puUUY3MnRXcFhDSnhi?=
 =?utf-8?B?aHV0K1czRDJIc3M0NGhDWXVrajdLOW1GK0ZuaDA0djJrQTJ5Q1lXbi91TDhK?=
 =?utf-8?B?ZmVSSUI3UUtoRkVuZ25SckMyVldMdDBaRWVidll4SFozaUEraDRDQzZNUzNW?=
 =?utf-8?B?clpvZGtUTUQ1d3VWdERLWkcyd0JwUXF5Z05RaWUzQ0FjY0NMcjI5bUlveDVR?=
 =?utf-8?B?OVRJd3hLUE5tK28wWTlQV2YzTG5IMGJwVlJrc093V0ovNHhjMlNXeTJqcGx5?=
 =?utf-8?B?QXdSc0owWUt3TURmcURBL1VONTczSTNua1ZiMTduZXJkYThVSVBpcm9YeHIx?=
 =?utf-8?B?MUdWVjE5N2Y4bW1SYWtZL2lkemlEZEpBYTAvcklqYmRtakk4cnl2Z1ZHcVQr?=
 =?utf-8?B?NGR0QnRWcE5iZ1ZEVWY1cTVIL1dhdnlhVXV0QnBRSHRxV3ZGUmswQ2pTUkhP?=
 =?utf-8?B?OGhIc0IzMU5jMEFReDZQS25GNU5PNmlsbzFhR3BqUE5PRHBYWWZhYmZBeExW?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ypXDGhfsDyQ8fHTcczdW3sA29flHhgmbfiqVTizVE5m/StFKDgvqwwhwg5R2zKpwCDvN6qo+KqM/SX3oi2RuaBKObKRR1L0AdfofpYmgOqbCuKI8Q14moWlAjf/OyltmMQPbuKKefogVc6Tuh7yAUXqJ1EULuDC0e6MXB9aQb4+uKbT8tGsKDJV1gimRx95kuwMOda1FqUusme5zDytRSBTl1pBKAaOcg9MFMD+8nrb4r89xgEzfOVELIrFlBmdOCK8/BDB0yDqWFxfNmyqYUHGhYbvwpmDa/yaR6AmpxwpaN67Nxs20OBp+GYmxtJtZDpONd33xXv1572WHaPmzDNkOaXubMfrNmPxJF4uIYewyUQ74aVMm+LHrLLkKZXUu7S8+CM8gP2M6dr+hMm0pvVEVhC3yZ3+8KvDbT6lniQSQIj3XC/HkrMIfWUfZ1Zz7qjDFySbfjyWNBzqR1G3ZQiyzuMXr890SopNkBtVNwznAAJt+8hANZSWbSTdj8VIYk51cg1i7G7H+e0lVvwFRXrOYfMjxxXRhihKCY8CnlNgtoFp3eWjdpb4wyuODt4EEdnfzOFLbF4LQQxV5ym7m6Ku0zhWjU09nzaods9TlMUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda5cf96-6f01-488e-eda4-08dc69c5e8fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 10:03:12.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va9ij/r+hAutPG5c2CmPo9eD6voK1eGpOZuvb86uyoX3jhlXxD6mHWcUVZkoWvpZnLCXbP+NAF8755B3ThF5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010070
X-Proofpoint-GUID: mQPRSZRA0YpluBNHp6TENZAf7OxyCgws
X-Proofpoint-ORIG-GUID: mQPRSZRA0YpluBNHp6TENZAf7OxyCgws


>> +/* Validate the forcealign inode flag */
>> +xfs_failaddr_t
>> +xfs_inode_validate_forcealign(
>> +	struct xfs_mount	*mp,
>> +	uint16_t		mode,
> 
> 	umode_t			mode,

ok. BTW, other functions like xfs_inode_validate_extsize() use uint16_t

> 
>> +	uint16_t		flags,
>> +	uint32_t		extsize,
>> +	uint32_t		cowextsize)
> 
> extent sizes are xfs_extlen_t types.

ok

> 
>> +{
>> +	/* superblock rocompat feature flag */
>> +	if (!xfs_has_forcealign(mp))
>> +		return __this_address;
>> +
>> +	/* Only regular files and directories */
>> +	if (!S_ISDIR(mode) && !S_ISREG(mode))
>> +		return __this_address;
>> +
>> +	/* Doesn't apply to realtime files */
>> +	if (flags & XFS_DIFLAG_REALTIME)
>> +		return __this_address;
> 
> Why not? A rt device with an extsize of 1 fsb could make use of
> forced alignment just like the data device to allow larger atomic
> writes to be done. I mean, just because we haven't written the code
> to do this yet doesn't mean it is an illegal on-disk format state.

ok, so where is a better place to disallow forcealign for RT now (since 
we have not written the code to support it nor verified it)?

> 
>> +	/* Requires a non-zero power-of-2 extent size hint */
>> +	if (extsize == 0 || !is_power_of_2(extsize) ||
>> +	    (mp->m_sb.sb_agblocks % extsize))
>> +		return __this_address;
> 
> Please do these as indiviual checks with their own fail address.

ok

> That way we can tell which check failed from the console output.
> Also, the agblocks check is already split out below, so it's being
> checked twice...
> 
> Also, why does force-align require a power-of-2 extent size? Why
> does it require the extent size to be an exact divisor of the AG
> size? Aren't these atomic write alignment restrictions? i.e.
> shouldn't these only be enforced when the atomic writes inode flag
> is set?

With regards the power-of-2 restriction, I think that the code changes 
are going to become a lot more complex if we don't enforce this for 
forcealign.

For example, consider xfs_file_dio_write(), where we check for an 
unaligned write based on forcealign extent mask. It's much simpler to 
rely on a power-of-2 size. And same for iomap extent zeroing.

So then it can be asked, for what reason do we want to support 
unorthodox, non-power-of-2 sizes? Who would want this?

As for AG size, again I think that it is required to be aligned to the 
forcealign extsize. As I remember, when converting from an FSB to a DB, 
if the AG itself is not aligned to the forcealign extsize, then the DB 
will not be aligned to the forcealign extsize. More below...

> 
>> +	/* Requires agsize be a multiple of extsize */
>> +	if (mp->m_sb.sb_agblocks % extsize)
>> +		return __this_address;
>> +
>> +	/* Requires stripe unit+width (if set) be a multiple of extsize */
>> +	if ((mp->m_dalign && (mp->m_dalign % extsize)) ||
>> +	    (mp->m_swidth && (mp->m_swidth % extsize)))
>> +		return __this_address;
> 
> Again, this is an atomic write constraint, isn't it?

So why do we want forcealign? It is to only align extent FSBs? Or to 
align extents to DBs? I would have thought the latter. If so, it seems 
sensible to do this check also.

> 
>> +	/* Requires no cow extent size hint */
>> +	if (cowextsize != 0)
>> +		return __this_address;
> 
> What if it's a reflinked file?

Yeah, I think that we want to disallow that.

> 
> .....
> 
>> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
>> index d0e2cec6210d..d1126509ceb9 100644
>> --- a/fs/xfs/xfs_ioctl.c
>> +++ b/fs/xfs/xfs_ioctl.c
>> @@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
>>   		di_flags2 |= XFS_DIFLAG2_DAX;
>>   	if (xflags & FS_XFLAG_COWEXTSIZE)
>>   		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
>> +	if (xflags & FS_XFLAG_FORCEALIGN)
>> +		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
>>   
>>   	return di_flags2;
>>   }
>> @@ -1146,6 +1148,22 @@ xfs_ioctl_setattr_xflags(
>>   	if (i_flags2 && !xfs_has_v3inodes(mp))
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * Force-align requires a nonzero extent size hint and a zero cow
>> +	 * extent size hint.  It doesn't apply to realtime files.
>> +	 */
>> +	if (fa->fsx_xflags & FS_XFLAG_FORCEALIGN) {
>> +		if (!xfs_has_forcealign(mp))
>> +			return -EINVAL;
>> +		if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
>> +			return -EINVAL;
>> +		if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
>> +					FS_XFLAG_EXTSZINHERIT)))
>> +			return -EINVAL;
>> +		if (fa->fsx_xflags & FS_XFLAG_REALTIME)
>> +			return -EINVAL;
>> +	}
> 
> What about if the file already has shared extents on it (i.e.
> reflinked or deduped?)

At the top of the function we have this check for RT:

	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
		/* Can't change realtime flag if any extents are allocated. */
		if (ip->i_df.if_nextents || ip->i_delayed_blks)
			return -EINVAL;
	}

Would expanding that check for forcealign also suffice? Indeed, later in 
this series I expanded this check to cover atomicwrites (when I really 
intended it for forcealign).

> 
> Also, why is this getting checked here instead of in
> xfs_ioctl_setattr_check_extsize()?
> 
> 
>> @@ -1263,7 +1283,19 @@ xfs_ioctl_setattr_check_extsize(
>>   	failaddr = xfs_inode_validate_extsize(ip->i_mount,
>>   			XFS_B_TO_FSB(mp, fa->fsx_extsize),
>>   			VFS_I(ip)->i_mode, new_diflags);
>> -	return failaddr != NULL ? -EINVAL : 0;
>> +	if (failaddr)
>> +		return -EINVAL;
>> +
>> +	if (new_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
>> +		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
>> +				VFS_I(ip)->i_mode, new_diflags,
>> +				XFS_B_TO_FSB(mp, fa->fsx_extsize),
>> +				XFS_B_TO_FSB(mp, fa->fsx_cowextsize));
>> +		if (failaddr)
>> +			return -EINVAL;
>> +	}
> 
> Oh, it's because you're trying to use on-disk format validation
> routines for user API validation. That, IMO, is a bad idea because
> the on-disk format and kernel/user APIs should not be tied
> together as they have different constraints and error conditions.
> 
> That also explains why xfs_inode_validate_forcealign() doesn't just
> get passed the inode to validate - it's because you want to pass
> information from the user API to it. This results in sub-optimal
> code for both on-disk format validation and user API validation.
> 
> Can you please separate these and put all the force align user API
> validation checks in the one function?
> 

ok, fine. But it would be good to have clarification on function of 
forcealign, above, i.e. does it always align extents to disk blocks?

Thanks,
John



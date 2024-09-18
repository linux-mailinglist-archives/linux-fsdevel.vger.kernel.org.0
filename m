Return-Path: <linux-fsdevel+bounces-29629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587E97BA23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 11:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65BA7B26A3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E440B178CE8;
	Wed, 18 Sep 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XTcCLvba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2151547E1;
	Wed, 18 Sep 2024 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651775; cv=fail; b=Pbp9kGXPILtU7B9LfRMnWKpaNMz4tDbWmpVVOzd3tnzu9VBlUSn1WWoArYOzzmtLiX7K2yjYM2qUzDDPujf3BfP4DJSvdwzUEPC7klo7sj4H5NMH5vdhdqnQwTzDlfJiH0IZorBi6U68NQXFs2qPMZ+OiPmJ0SRGj005GYri06c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651775; c=relaxed/simple;
	bh=tVkCaFQnDJHOIWhfvCo2UhiwO6aHOPm4za3vz8bQYmA=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=NEnH3uRTxUV9Ul+My/39Wb+jeiMDDJU0qB97BzpzeEZhsVmtpx33z6K+N93GiKLqdBBnXNM0m9152D+/tH4CUk+zOC6vSrrqwGTj7C4K7SPEZphcv/0rXNUWUq8W/B1mR0qHadbyZCv7ew5HRsw8JF4SWa1pkJ80mRgHhPgY0HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XTcCLvba; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I5FCbu026061;
	Wed, 18 Sep 2024 02:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=s2048-2021-q4; bh=YS9dXvVb13IwvXY0J
	m7umk6S0LZofTTA4NHOCUUjZ54=; b=XTcCLvbajt/EQWhbSz4hGikpbGCmuIASW
	fqGPoH9nDu6jW9cSTRu4CrV8fow1ArEGKTrN5tWglmP/3SC36VSt1jRqDxT8G7SM
	92eTr6lpUhWK6//2N18ICGSG6/Dznx5S1mysteOwm7ckDH5dlRIqVkmAnqr9KWkN
	/DwJEym70kbpmAn+JeGVDYUKNsK1YykoLO6XVCyDzB+aMbbuTX2yxWWzE8VeqFnf
	3RamWdqelYuGsF4pC5EU0Fs25vHteFrSQwe++c1q89HaKVbe40rz/1KzmUzK8cMo
	8nmYCu7BcNN5f/w3lBHbe+eDi0LmCq4L1ReiVbiQfvKpBtMsqlRTA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41qrheh3bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 02:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8ACriwWWSjQHHLr+hAtjo6f/JpQgnGuRqlDJksGZ7wphP6RxY6aTbEqUe4IJs/dKYRhM39CKxfLcDmZPIZ1XPdOAzzOkSAvtMvhdKm4+p56xG8p2smSJMd8/WVOBiSpxd6mbPb9J/Sq1qtv9bfjc5PjT89jJ4xGgUyy38sNb7OB0h8RpaGgHUpW8uSLYX6qR77drK7Spaa+4y3JgBQjT9rWDLbMLzirb3ATwj13ublFD0xgCo1ozAu8YhEeF3CD+3CwtLbDdB26Y5DpWAL8obH3pE6ko6fLth5WbdBKGARwXgdp2faFsI/7vQXmNs/hokSH4lZxfr2eXQBc9/YWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtRClKSdvBsg+gA8lBc/CQ812nlCnPSqjJb/GjSlBIg=;
 b=vPKete6VP5Cy9EOCEMBbrs6SvysXjGs5rjnmeR8JNlzGSQMxkD4PH/2NEKx7EYCbygcq+ux5R0RP9aQ9MzUCoUDWnJl0zee3BgczXrbH/GElgTyoSBNps5uko1RWsRzWW95FRRmr2NdLPNthSyYtfmVMeWodRPFDJsj12CJIGCXR/ReMqZsMsI37CxJxn6TeyOqqreJ7RDcMflGw/aNLo8I6EmvtZ+kf8jMB4quZkjbMqGBFmXms04qacVpkr6Zda/1B08Q86ZT4qfkg4P57MD6zGc/IpW9mb1uZcrTI0DpOGWuBbDIJTwgKTOSqm6CEKtw08Sr7tXxlq9aFfDq2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH0PR15MB4229.namprd15.prod.outlook.com (2603:10b6:510:1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 09:29:10 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 09:29:10 +0000
Content-Type: multipart/mixed; boundary="------------vsit6LI53uSLmZTsVGLYOE7S"
Message-ID: <459beb1c-defd-4836-952c-589203b7005c@meta.com>
Date: Wed, 18 Sep 2024 11:28:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
X-ClientProxiedBy: ZR2P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::9) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH0PR15MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5deb54-47cf-4733-dba6-08dcd7c459fb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNWdmlyd05NdG5rcktUZC8xWDJWQjdHOXRPK3BSQW82RzRCMysyU0NISnI4?=
 =?utf-8?B?U2RwYW42b3oyNmk3WnNtZ01HRVhmcHJqMy91MnNPNGthenNtUzV2cWRHOFNv?=
 =?utf-8?B?dE9tR3QyeVZGQmtiYmxac1Rmdmh2blpIbmUwazhsbjIvbXZGY3haZUtnWGxN?=
 =?utf-8?B?T3BRYUJkaWtpVTliSDQ1aXA1RTluV092a01RbGc5aE95cGRKL2E3RlpzM1Zs?=
 =?utf-8?B?cFpUVDN6enRwUDc5YmVvVTEvZHB1TGZhTWl2SnlMVGNJYWhSWFYxWitVS2g1?=
 =?utf-8?B?UDhUdDQzSzVvQ3h0dHVFNm5UTVIzb05pNHZYbk43dmJhYXl4TjJ4V3lqcmpB?=
 =?utf-8?B?eHJmcXV2WjE2VWRLOVFsUzVlYWRNb1FqTmE0dk9haGNrOVpyN0VUZkc4aThV?=
 =?utf-8?B?K0pNWXZRSEE4YXppV0tBR2tWMmtKd29LVFJDZU0wSXY1TnN0V2Q5WGEvUGtL?=
 =?utf-8?B?a0hMU0R5UURRZEI5eC9jWXJ3OFAzZ09Na0tkK3RaZ2FOcjFjS1VXaFplNWJF?=
 =?utf-8?B?YVgya1k4dnVHZ0R1c0I2RDJFdUNVTDVrK2lLT3FiV1JSSHFRZE5UaExBaTZ4?=
 =?utf-8?B?TGRyd0xTeFJXS0FJcUE3bmQwL1B2ZlpKLzZRM1NydTF1dHQvaU9YTzM1dExj?=
 =?utf-8?B?WW9MV2o5TTVxMkg0d2QwdFBVeERDNDh1NFFZaFY4WXhYbjJIZkdMNy9vbjU1?=
 =?utf-8?B?QU5zT2VuVFJSSzV6R3ltQ3g4Rm5LLzBxaHdkWEpmcXJ4blgxejcyMmpqMXVZ?=
 =?utf-8?B?Uk1yRHN3TGxxYk9YNjRMTzBkcU8xSkQ0Q0c4TXJab0FhV280NTlaNkhmTnZU?=
 =?utf-8?B?eGZpNE9vaEMvdDZPZkU1Vmd2Q1g4VTF4ZmNsa3Q0WTZ6cTFYV2FrOWhXZitm?=
 =?utf-8?B?RVREWk1CS25UT2EzSURvWTJ0RTRjZVJHUUJXR0FpS2o3Z1g4enduUWllUGdT?=
 =?utf-8?B?WjNycnB5RnNKdEd5YzR4S3NmbFo0N2V2VHJJREpJSVh3L1loVFZHbEZIRFBG?=
 =?utf-8?B?OUFlZHg1ZFBnamNMaWo4RlpLYTRDWVQwaGxJanlCVVordm40Q3BQZnMzRzdp?=
 =?utf-8?B?MmVMVk1ZajlodkgzQW53clpFRWY2UWZvU0hoR0ZYcUR0akloMlVhakZ6Sk5x?=
 =?utf-8?B?cVczQk5EZWZ0NVNYZ0hJZGtUSFZoTGRaSEJGdFhOR0lQR2ZlRHlpeTdQOTYv?=
 =?utf-8?B?Yll1QzhKNm5XWHFHQXJtekc2V09JS1Z0eXhsUExld05VeUp2YlFSM0lpd3c0?=
 =?utf-8?B?MHp0YStmRkI0eVZYWUNZMlZlSkhpSmZTWWRFRnVMMXFHQWx2SHlVYTVESnNx?=
 =?utf-8?B?cGFGcFJXT3BpSExUVGpBdTF0OGE2MmIzZ2p4aWViMVlqcXJjeUJPR3N5cGdt?=
 =?utf-8?B?dVNtZ1cxZmJWckM5VHNIS3p1TGQ5eHlCL3YxL3YvSUJJTGVSTmdXM0tMS2lZ?=
 =?utf-8?B?VXNGQmFqdzhJVGlaWUZLU2JlNmpCZG9aSVczWjBTWDZtbkdwZHBOekQ2S1Z1?=
 =?utf-8?B?UldnaHVrc05taGhWYm82VUFMSHdaVjRXRi9tZHlxT2ZXOTFxZ3paZURyRnRy?=
 =?utf-8?B?QkYrMXp3ODBsbkJjRmZIOW9lQnJkQ0V3aWZrVFcxejNnRjU1OTh6VUpDVjF5?=
 =?utf-8?B?WHFCMzhhL2hUdjNJYXFPQUpORWlneHlTYkgvTit1WHJJNEZxK3BFamNadlNX?=
 =?utf-8?B?OGRiZnlXbXQ4NlRTNXgxc0lLTGZLdDJmWUF5WExpendiSWo0V3ZiVTFLR2E5?=
 =?utf-8?B?YlNVYlZ3UkUvODEySnJ1UjY2V24wTzRhUyszR1JwUTRUV3o5ZHY4M3ZpcVpV?=
 =?utf-8?B?TEg4WXBtN2FXK2xFT0Qvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEtmamZQU0xNSm94c2ZtM25PVGpzb0tHVzFjZmxzZTY3bGc0c1dwYWxPdVBm?=
 =?utf-8?B?TkNlV1hIMHBmWjNXRERjcXYwelRBNjEwaloycEVVd1YvZ2grWThZaEdDYUVD?=
 =?utf-8?B?QVkvampjV1MySjhILy9YcDJmclNCNFR3KzN1aTVzdXpmZWpTeUVMYzRUdlhW?=
 =?utf-8?B?ZWVXWFZVRUx4UlR2cGRSTkdZeVZpOEdMZkRBQXQ3QnpaRnE1dFJsZWpZQU0y?=
 =?utf-8?B?RGhIcGJZSU1YTmswRnBVUkI3YzdZa0lJUVM1cHNTempnY29kT251U256dzRO?=
 =?utf-8?B?cWRmMVBRUVdoMjY0SUpHdml1c0lJL3pjWWhWSS80Y2ptOGI2eFNuQ09WQWFa?=
 =?utf-8?B?SGV3dEE3Nzc3c0dlWWVNbzVwOUMxY3Qzd1dKdktHbjhiZG5KbUlucG43WDQ1?=
 =?utf-8?B?OFdIOEY1VGNBem5QMm9EOWcwZWsxY3g4dkxJOTNwN0hlVnpGWmhpQWFUVUJG?=
 =?utf-8?B?dDlsMmQ1Qld3UGI5OWtJY1lFd3ZuMmNEcC9PNnhpRFYwZGlYd2dMbTE5Qk1M?=
 =?utf-8?B?TGFOWW9nLzZ0NmQzcTVUYWhPOHk1dDBhSzNLanN0RUt6bjdyQ0MwbG1VQzJw?=
 =?utf-8?B?NW85eWJCdzVqK3dPM2NpbXE1RjdMdUhPK1B4WWZwcHdDYUdCcmlhMHE5R1Jm?=
 =?utf-8?B?VVVQc2pFeTJhUEU3Z1BOR3FBZXpTOFVlMGZneTBMdmtEMytRK1lwV2tsVlB2?=
 =?utf-8?B?b1RYRC9yQkxXbnNNSkQvK2tLSzFyc2N0SHB6K1VCRXBLVGkzSWMxTTNDRWxF?=
 =?utf-8?B?eDZ6Y0x1R201VW9OUlhyVUo0N3R6SnYvNEJxNnVIL2dhbm1HaktVOEkyTy90?=
 =?utf-8?B?S1hLWjRMaUFFSXdjbkJJeDgzeEQwdGY4N2U0ZE1EcFB1VDVGUzJ2QnRHdWFj?=
 =?utf-8?B?RFZUMFFqd2J0eVpZWmNaQWdmSmVzcWV6WW1JUkUvL255OGtyTnZXUkpzd0kv?=
 =?utf-8?B?OERSeEsvVGRYeE9GZVVoZEJlRlRiY0UvMnlLV2hyRFprc3MrTndWUUNuZFVw?=
 =?utf-8?B?M2p0cVlpeHA2OWhLWStTd0FoY3VSY0dnWGNnTHVyVElnRlpFN1pXbUZNRkpE?=
 =?utf-8?B?L2FBcEhzaHZGaUIrYkp0UDRWRHVtc1hCamNqR3RKeFh0YmlqK1EraUtRZHVx?=
 =?utf-8?B?SlRPd2prU01YTEE3cVI5SURZQ2NoUm9zNHkxOWFRQ2FjenZrbWUwem44MmNU?=
 =?utf-8?B?UnFMM25qeHZsb3lxWkYyVnczMGZBbW9vQU9XbWRWSmhQZlkvWUlxRi96TE5U?=
 =?utf-8?B?QUNISUxnYmFaZTU3Yk03cThaVDNrekc4UGRpbjhTNVhYQUluK21zSzdkZmN0?=
 =?utf-8?B?N1hrRmVxUzZ5ejVBVXY3V3M0cG1MTjNwNkVXL1dtWm1FOHJLZVVGN3FHcDN4?=
 =?utf-8?B?aTFHUElNSjdOMU03OGZTeDIvanZZc3dtNWlIcHVIa0JUdENnKy9lVXhJQ3d6?=
 =?utf-8?B?L1pxN2N2MmFDdlJWamVUZERMcDN0MzZCNEZmU1J3UkJlWXlPU2JGNVhsMHFh?=
 =?utf-8?B?WU51WHQwbkw1Wkdqb3UvQ01QZW9iVDdZMzhwaitkSE5XMWVRSXB3Y3hJREZ5?=
 =?utf-8?B?ZHM3TmZEV2pOa0RobU9PRXN0a0VxUUx2ZkZOOFNQSGQzc0ZwcGxtK29Pak1D?=
 =?utf-8?B?ZEgvWG1HbFViZWRjZFlVaXMzQXdrTzNKYWlzVlBGVVBOZUZMQ1U5dDJaUnNt?=
 =?utf-8?B?SGJkdGJhcmJ3WW44L3g1UnM3b0VLN1A3ZnFkNWFUVjNJQkx5NUk2bWRrR282?=
 =?utf-8?B?N3NQYzViRlFYWHF4R24wWk9NL3VQS2dYUUdMVnJJNWsvcU5QYzBDdFh6SjFF?=
 =?utf-8?B?a1Eyc0kxdmN2a2RPZ3BVRnAyWVI1b3ZnaFFTZmRyS2psWFE0NFc1eUhkU1dP?=
 =?utf-8?B?MnJybjhhSzV0bTNWRmNJb1FuckM2TllDM2d3RklUa1doQjE2WHljbmVTSEg5?=
 =?utf-8?B?VlV4ck5XQnV2RE9NaSttUHp3eWFNV0R6Ly9jb0FZcUtvajVXM2RtSlFCSzBj?=
 =?utf-8?B?U0FFNkY1REVmSjdtbFdtUXNZLys1L2dJNHd3TGVjUGdXanc3RnJoMzZQZ1NG?=
 =?utf-8?B?d2tnUGZadGhyMitlSEJ3ZlNmSnMydFhFZmJGWm9mQ0VKVC90a3Z0UWFxQTFt?=
 =?utf-8?Q?51LA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5deb54-47cf-4733-dba6-08dcd7c459fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:29:10.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3r2Vga8uDk1lQAErGKb9vvyv719ZF+VM+TQg/gyrnyUZf/XIQHxSvYTrLEzTvYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4229
X-Proofpoint-GUID: _26uf-8ysRJmdGTdV6U8YtvpWb3xzhbm
X-Proofpoint-ORIG-GUID: _26uf-8ysRJmdGTdV6U8YtvpWb3xzhbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_07,2024-09-16_01,2024-09-02_01

--------------vsit6LI53uSLmZTsVGLYOE7S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

One or more of the originally attached files triggered the rule module.access.rule.exestrip_notify

The following attachments were deleted from the original message.
radixcheck.py

Original Message:

On 9/18/24 2:37 AM, Jens Axboe wrote:
> On 9/17/24 7:25 AM, Matthew Wilcox wrote:
>> On Tue, Sep 17, 2024 at 01:13:05PM +0200, Chris Mason wrote:
>>> On 9/17/24 5:32 AM, Matthew Wilcox wrote:
>>>> On Mon, Sep 16, 2024 at 10:47:10AM +0200, Chris Mason wrote:
>>>>> I've got a bunch of assertions around incorrect folio->mapping and I'm
>>>>> trying to bash on the ENOMEM for readahead case.  There's a GFP_NOWARN
>>>>> on those, and our systems do run pretty short on ram, so it feels right
>>>>> at least.  We'll see.
>>>>
>>>> I've been running with some variant of this patch the whole way across
>>>> the Atlantic, and not hit any problems.  But maybe with the right
>>>> workload ...?
>>>>
>>>> There are two things being tested here.  One is whether we have a
>>>> cross-linked node (ie a node that's in two trees at the same time).
>>>> The other is whether the slab allocator is giving us a node that already
>>>> contains non-NULL entries.
>>>>
>>>> If you could throw this on top of your kernel, we might stand a chance
>>>> of catching the problem sooner.  If it is one of these problems and not
>>>> something weirder.
>>>>
>>>
>>> This fires in roughly 10 seconds for me on top of v6.11.  Since array seems
>>> to always be 1, I'm not sure if the assertion is right, but hopefully you
>>> can trigger yourself.
>>
>> Whoops.
>>
>> $ git grep XA_RCU_FREE
>> lib/xarray.c:#define XA_RCU_FREE        ((struct xarray *)1)
>> lib/xarray.c:   node->array = XA_RCU_FREE;
>>
>> so you walked into a node which is currently being freed by RCU.  Which
>> isn't a problem, of course.  I don't know why I do that; it doesn't seem
>> like anyone tests it.  The jetlag is seriously kicking in right now,
>> so I'm going to refrain from saying anything more because it probably
>> won't be coherent.
> 
> Based on a modified reproducer from Chris (N threads reading from a
> file, M threads dropping pages), I can pretty quickly reproduce the
> xas_descend() spin on 6.9 in a vm with 128 cpus. Here's some debugging
> output with a modified version of your patch too, that ignores
> XA_RCU_FREE:

Jens and I are running slightly different versions of reader.c, but we're
seeing the same thing.  v6.11 is lasts all night long, and reverting those
two commits falls over in about 5 minutes or less.

I switched from a VM to bare metal, and managed to hit an assertion I'd
added to filemap_get_read_batch() (should look familiar):

{
	struct address_space *fmapping = READ_ONCE(folio->mapping);
	BUG_ON(fmapping && fmapping != mapping);
}

Walking the xarray in the crashdump shows that it's probably the same
corruption I saw in 5.19.  drgn is printing like so:

print("0x%x mapping 0x%x radix index %d page index %d flags 0x%x (%s) size %d" % (page.address_of_(), page.mapping.value_(), index, page.index, page.flags, decode_page_flags(page), folio._folio_nr_pages))

And I attached radixcheck.py if you want to see the full script.

These are all from the correct mapping:
0xffffea0088b17200 mapping 0xffff88a22a9614e8 radix index 53 page index 53 flags 0x15ffff000000000c (PG_referenced|PG_uptodate|PG_reported) size 59472
0xffffea008773e940 mapping 0xffff88a22a9614e8 radix index 54 page index 54 flags 0x15ffff000000000c (PG_referenced|PG_uptodate|PG_reported) size 4244589144
0xffffea0084ad1d00 mapping 0xffff88a22a9614e8 radix index 55 page index 55 flags 0x15ffff000000000c (PG_referenced|PG_uptodate|PG_reported) size 4040059330
0xffffea0088c9d840 mapping 0xffff88a22a9614e8 radix index 56 page index 56 flags 0x15ffff000000000c (PG_referenced|PG_uptodate|PG_reported) size 5958
0xffffea00879c6300 mapping 0xffff88a22a9614e8 radix index 57 page index 57 flags 0x15ffff000000000c (PG_referenced|PG_uptodate|PG_reported) size 112
0xffffea0086630980 mapping 0xffff88a22a9614e8 radix index 58 page index 58 flags 0x15ffff000000000c (PG_referenced|PG_uptodate|PG_reported) size 4025236287
0xffffea0008eb6580 mapping 0xffff88a22a9614e8 radix index 59 page index 59 flags 0x5ffff000000012c (PG_referenced|PG_uptodate|PG_lru|PG_active|PG_reported) size 269
0xffffea00072db000 mapping 0xffff88a22a9614e8 radix index 60 page index 60 flags 0x5ffff000000416c (PG_referenced|PG_uptodate|PG_lru|PG_head|PG_active|PG_private|PG_reported) size 4
0xffffea000919b600 mapping 0xffff88a22a9614e8 radix index 64 page index 64 flags 0x5ffff000000416c (PG_referenced|PG_uptodate|PG_lru|PG_head|PG_active|PG_private|PG_reported) size 4

These last 3 are not:
0xffffea0008fa7000 mapping 0xffff888124910768 radix index 208 page index 192 flags 0x5ffff000000416c (PG_referenced|PG_uptodate|PG_lru|PG_head|PG_active|PG_private|PG_reported) size 64
0xffffea0008fa7000 mapping 0xffff888124910768 radix index 224 page index 192 flags 0x5ffff000000416c (PG_referenced|PG_uptodate|PG_lru|PG_head|PG_active|PG_private|PG_reported) size 64
0xffffea0008fa7000 mapping 0xffff888124910768 radix index 240 page index 192 flags 0x5ffff000000416c (PG_referenced|PG_uptodate|PG_lru|PG_head|PG_active|PG_private|PG_reported) size 64

I think the bug was in __filemap_add_folio()'s usage of xarray_split_alloc()
and the tree changing before taking the lock.  It's just a guess, but that
was always my biggest suspect.

To reproduce, I used:

mkfs.xfs -f <some device>
mount some_device /xfs
for x in `seq 1 8` ; do
	fallocate -l100m /xfs/file$x
	./reader /xfs/file$x &
done

New reader.c attached.  Jens changed his so that every
reader thread was using its own offset in the file,
and he found that reproduced more consistently.

-chris

--------------vsit6LI53uSLmZTsVGLYOE7S
Content-Type: text/plain; charset=UTF-8; name="reader.c"
Content-Disposition: attachment; filename="reader.c"
Content-Transfer-Encoding: base64

LyoKICogZ2NjIC1XYWxsIC1vIHJlYWRlciByZWFkZXIuYyAtbHB0aHJlYWQKICovCiNkZWZpbmUg
X0dOVV9TT1VSQ0UKCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNs
dWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5o
PgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy9zZW5kZmlsZS5oPgojaW5jbHVk
ZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZXJyLmg+CiNpbmNsdWRl
IDxwdGhyZWFkLmg+CgpzdHJ1Y3QgdGhyZWFkX2RhdGEgewoJaW50IGZkOwoJaW50IHJlYWRfc2l6
ZTsKCXNpemVfdCBzaXplOwp9OwoKc3RhdGljIHZvaWQgKmRyb3BfcGFnZXModm9pZCAqYXJnKQp7
CglzdHJ1Y3QgdGhyZWFkX2RhdGEgKnRkID0gYXJnOwoJaW50IHJldDsKCgl3aGlsZSAoMSkgewoJ
CXJldCA9IHBvc2l4X2ZhZHZpc2UodGQtPmZkLCAgMCwgdGQtPnNpemUsIFBPU0lYX0ZBRFZfRE9O
VE5FRUQpOwoJCWlmIChyZXQgPCAwKQoJCQllcnIoMSwgImZhZHZpc2UgZG9udG5lZWQiKTsKCX0K
CXJldHVybiBOVUxMOwp9CgojZGVmaW5lIFJFQURfQlVGICgyICogMTAyNCAqIDEwMjQpCnN0YXRp
YyB2b2lkICpyZWFkX3BhZ2VzKHZvaWQgKmFyZykKewoJc3RydWN0IHRocmVhZF9kYXRhICp0ZCA9
IGFyZzsKCWNoYXIgYnVmW1JFQURfQlVGXTsKCXNzaXplX3QgcmV0OwoJbG9mZl90IG9mZnNldCA9
IDgxOTI7CgoJd2hpbGUgKDEpIHsKCQlyZXQgPSBwcmVhZCh0ZC0+ZmQsIGJ1ZiwgdGQtPnJlYWRf
c2l6ZSwgb2Zmc2V0KTsKCQlpZiAocmV0IDwgMCkKCQkJZXJyKDEsICJyZWFkIik7CgkJaWYgKHJl
dCA9PSAwKQoJCQlicmVhazsKCX0KCXJldHVybiBOVUxMOwp9CgppbnQgbWFpbihpbnQgYWMsIGNo
YXIgKiphdikKewoJaW50IGZkOwoJaW50IHJldDsKCXN0cnVjdCBzdGF0IHN0OwoJaW50IHNpemVz
WzldID0geyAwLCAwLCA4MTkyLCAxNjgzNCwgMzI3NjgsIDY1NTM2LCAxMjggKiAxMDI0LCAyNTYg
KiAxMDI0LCAxMDI0ICogMTAyNCB9OwoJaW50IG5yX3RpZHMgPSA5OwoJc3RydWN0IHRocmVhZF9k
YXRhIHRkc1s5XTsKCWludCBpOwoJaW50IHNsZWVwcyA9IDA7CglwdGhyZWFkX3QgdGlkc1tucl90
aWRzXTsKCglpZiAoYWMgIT0gMikKCQllcnIoMSwgInVzYWdlOiByZWFkZXIgZmlsZW5hbWVcbiIp
OwoKCWZkID0gb3BlbihhdlsxXSwgT19SRE9OTFksIDA2MDApOwoJaWYgKGZkIDwgMCkKCQllcnIo
MSwgInVuYWJsZSB0byBvcGVuICVzIiwgYXZbMV0pOwoKCXJldCA9IGZzdGF0KGZkLCAmc3QpOwoJ
aWYgKHJldCA8IDApCgkJZXJyKDEsICJzdGF0Iik7CgoKCWZvciAoaSA9IDA7IGkgPCBucl90aWRz
OyBpKyspIHsKCQlzdHJ1Y3QgdGhyZWFkX2RhdGEgKnRkID0gdGRzICsgaTsKCgkJdGQtPmZkID0g
ZmQ7CgkJdGQtPnNpemUgPSBzdC5zdF9zaXplOwoJCXRkLT5yZWFkX3NpemUgPSBzaXplc1tpXTsK
CgkJaWYgKGkgPCAyKQoJCQlyZXQgPSBwdGhyZWFkX2NyZWF0ZSh0aWRzICsgaSwgTlVMTCwgZHJv
cF9wYWdlcywgdGQpOwoJCWVsc2UKCQkJcmV0ID0gcHRocmVhZF9jcmVhdGUodGlkcyArIGksIE5V
TEwsIHJlYWRfcGFnZXMsIHRkKTsKCQlpZiAocmV0KQoJCQllcnIoMSwgInB0aHJlYWRfY3JlYXRl
Iik7Cgl9Cglmb3IgKGkgPSAwOyBpIDwgbnJfdGlkczsgaSsrKSB7CgkJcHRocmVhZF9kZXRhY2go
dGlkc1tpXSk7Cgl9Cgl3aGlsZSgxKSB7CgkJc2xlZXAoMTIyKTsKCQlzbGVlcHMrKzsKCQlmcHJp
bnRmKHN0ZGVyciwgIjolZDoiLCBzbGVlcHMgKiAxMjIpOwoKCX0KfQo=

--------------vsit6LI53uSLmZTsVGLYOE7S--


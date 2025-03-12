Return-Path: <linux-fsdevel+bounces-43784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F8A5D805
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FC71897194
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64014234988;
	Wed, 12 Mar 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qpqqlxvt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jd5es0iI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395411CEACB;
	Wed, 12 Mar 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767716; cv=fail; b=tAQ1bJ9YQf8i/I8vX7SXscBHWwifL1CKBHHXiW/gMM9pI44crU+yUCriPWl5ABHq2LqXLtEA20nTNKJUxfl7xv7apfaHFXCHVPG4aGLQuJ+5yhWldWiyyFIVGTcs0TM4k4xuiiS/p0BhoK8DzhsFpS3W8dQXmDAUilYnWD81O7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767716; c=relaxed/simple;
	bh=1kqDrSh01r5+FhwXj51J3McChNWF2kg8Xe43ZAVwnZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3NQ4p3WVGpBtwxdgNTslJbPPJ0BRQD9iu65CR5w1/63GAulde83RHIbR9LMCpblblebF2DtxLtsGG8BRbBP22o97RYSSIyQPwlbvvVptgLpZiKZ+3dB4NghQnk+dQPkUr7bpulUz/scQJ+eVYXOlS01HjPm59CdsKLNuVuuZcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qpqqlxvt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jd5es0iI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1gDh5016264;
	Wed, 12 Mar 2025 08:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FPK8Sd9O7ltad6bIGeULk5Jx1QQeCObCXPyf3YWTU5E=; b=
	Qpqqlxvt0JCqAbCmqokJRYBVXAErZbOAyncqXgE+8FdcG0xSa5ok9XJwJw0n/Ynb
	CwpCOu6NjLBQGLKAqof8+SCRMDbMCWgFI6bsc/ZNMn/iYU89cWMkRN6YV9EURipN
	l2ZsxmI0OKXS0rjI0Uv5vF7wYJtnsRUWBS9kycRfRVXUBFqrlChK1r+5hpKAHBhL
	geI4NsRih/pGD+Kp99f4AaOaQLs/J7BgxMpJipTuOZpc8Ey9yfwZwN3ibFGYfSWl
	45frCSVeD5nkciyJMmDKlhH7DEXjYWCkZ9MF5shpPFAeHsK92O6kNUgHmd29+r7J
	yI+R5Bg0Fmgq98HOMw/dxg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4ds5uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:21:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6trJ8019464;
	Wed, 12 Mar 2025 08:21:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn06u3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbCANKxlcqIr9IU7ITKPM8CtKtb5a5Cavm5bT4PuEifnN6fEI1UcY8w+be11lb4y/FJwBN9/2/hFu097GFLRZXtUDIzuJGQXh9tSnXGacs4nGGWS8ohd0VTBmBMGw+ojO9BTIg9TKC2lF8aaL1dbwKcidEhXwyhWgVDRHaP+ZXMzV01u42ka9l+Sx8AtXJPFWQAP0SQKXOziG6ZPyTd8s0D20Zr19mw85NMOY0fWJF4dlb0MO84htTSik6ZcsLw0mUKpptOHPuHfSiRf+NOaKeHEP2c9RWBrWeK5eKN7GepW3/YDpnFkq0BmtMlSPAByqxiFJGIhLXjCU5JROD8rzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPK8Sd9O7ltad6bIGeULk5Jx1QQeCObCXPyf3YWTU5E=;
 b=PX2zkYmZJoihvk+hci1fVDgIBo20gey7l416I7SSDMFX8pTYVCnH5zB4txEff4mWK5oibdhPfr9O8gGJPYnexivHbRbkY64TaAPyT9OIjntzOXi14tmbgmlEY5wi4Mf6YhRBvcdbPYLkRI4cwUPfl5n+XCRJYKXNURIfNYWJoIwIUdnBxsj73OOgbM9ROvnva22t+NnquEqGgrbRivAY3mhkUeVabzSDce56x2/jrSkuwVYA0Nr1/SVbcWvhgPPilq1TU90E0mcwnmb0dCnwC2fMlzsJkfPaaq687GK1LaLCZ6Aivy+bP3gMA4e+/V5Zlct3OJX/MV3kC+iMcroBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPK8Sd9O7ltad6bIGeULk5Jx1QQeCObCXPyf3YWTU5E=;
 b=jd5es0iI/s9nk2ywdQvzY/LhIzifCObnwRXSQqf3TYo0CzFSLT4aziyjpK+bhgMfWl4OixiPsb1Invg27mo6lRwoTulFUicJUrhXQVto0Ul0iFYTJEj4PW4D/h7w7sYd3aEZiQYx+7Sy7VLL5YPbpE4Wy6a36BDK6XN4V+JK2GM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:21:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:21:44 +0000
Message-ID: <10486098-fee5-4f66-afe0-f0120e134e97@oracle.com>
Date: Wed, 12 Mar 2025 08:21:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] xfs: Switch atomic write size check in
 xfs_file_write_iter()
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-3-john.g.garry@oracle.com>
 <Z9E1AwaFni3o00sZ@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E1AwaFni3o00sZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0631.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c851b4a-2867-4c32-95fd-08dd613eec76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0RYODBBSlZuSFZjZjVvNHMwQzZIeTlPc0lBSnJXRXBGTVZpQjNkdjFubWdH?=
 =?utf-8?B?Rk5oL1dqMFJ1OVR4YnU3bjc3MExkTUdZcVErR1hsNmtzOTk1QmFlZU5rVjND?=
 =?utf-8?B?WjFMdnFscjY0cmJwaDFzUm5oV2w1MFRVMUh6UDFPWTFIY0g0bHJibUV3R1BU?=
 =?utf-8?B?eEQ1M3N1ZDNOdU1BbzBUWnJleDMwSEhsNnNndmxPS2tmYktSdXhZOXRGTG1C?=
 =?utf-8?B?L2cyRmhvNzJmNEtWaytUV3pwSzNVZisxVnB2YnZJakNQZDlNNkYxekJCMm0v?=
 =?utf-8?B?VFQ5Y3J5UVJtbldGclZyZEtoWWF6a1JGMC91MjNhQWYrQkNhUFNUbldoVzdE?=
 =?utf-8?B?eGxMamdSYU1ESDhYY2MxZUw3bVZOdFVEMENBTXkvS1hKbUtxM1BlcndJRXc1?=
 =?utf-8?B?UFd3a3RnamhpSWVXRHlpcWdLSXRSUlAyUExnQlJpdklxdjQ2SGxnbzdkZFlR?=
 =?utf-8?B?dmVCalNuU1lnNG1SbDJmTGt4eWVQSHpSWi9ZQ09iN2trWlpIS2pyUW45aE1z?=
 =?utf-8?B?dXkxdDk5Q2RwM0EyZ2hvTU1YZS9wNUo4Zy9GMnlvQmpJT0FjdHhHN3BqMXFW?=
 =?utf-8?B?MWgxOUtTMmRva28vb0h3V3FjODNZWUl2UE5Nc01QMG03b3RndG1wcWVKWGM0?=
 =?utf-8?B?SUozU3VObUVyamFqVjF0TVlzbHRwMGltSUJ1bUdudkNoQTRoc0VrNXg4eUR2?=
 =?utf-8?B?WkZSV3d4T3d4S1NQY2pKK00vU3NNRHZjdTY2cmtncG95WWNGWDZDMVZMcmFG?=
 =?utf-8?B?b2YySkRBb1QraTdKeGJyZEVhV3VmRGltcVlPUk9nVjZHaEpYU0UwQzUveHR5?=
 =?utf-8?B?ZkNkV0lla2M5WVpIUk5yNmloWDhMN0ZuMG94UWc2cURYckgxVGUyRU5ZbEhr?=
 =?utf-8?B?VjUvcGNIeXozZGVvRWh1cm9wQit4T3Y0OVVnUGlVTDJyL3NyaFAzdWtNT3g2?=
 =?utf-8?B?MzViNytWeWExMFV2WVU1ODRhZ1BUR1NGanAwaWdjYVhTNWV2SjlUVHRtMUJI?=
 =?utf-8?B?SVVwL2JyVWYrQUdKNVR6YVd4Tnk3WVZOZHptQ2ZBeGI3MHBhRUZyekJGdkRq?=
 =?utf-8?B?WmZ0REZKa3dVSXZJNnRYMVlzd1QvQXNwN041WVZzTllBRnRnczFnczhUK0hX?=
 =?utf-8?B?M3g5M2J1cGZHTmVjY0I4aWpTUnFVMXcyNjl5MWZxVXNmMCtHT0RkWGFIL0kx?=
 =?utf-8?B?MUJoUW5XWFRmeTEwcnRaK09HcE1IRlI3NVhxYjVSYlFXRWJvK3pPUTVtREtC?=
 =?utf-8?B?Umoyb3gwUERrUCsydGRTTWV0REZua2YrQ2JaZk8zdVpqZWViWk1DVjFGY3B4?=
 =?utf-8?B?b2ROUjdTZVZNNE9HSVBBTG5UVFhZUXJYVDRxdHZDN0Y1OHZkMVE5UHR2SWxV?=
 =?utf-8?B?RkdlQ3NOeFdsMjlmNDBTbkM5ZG1hc0JEU0taMWFHbUlkdGx1US9CQk1IVkQ0?=
 =?utf-8?B?NHVRb3VDVDRqcXc1bjVLejRtekI1bTJwSHh3WGpNZmdqcExXTWJPVm9BYVYw?=
 =?utf-8?B?MUE4Y0QzZlpDK1RvSVFZRUIrLzFNQWFEQm9LS3JYSWFXckVuUFRyZXZKZ3NB?=
 =?utf-8?B?M09aNFFNNGp1bVBGRTVUbzVJeTdhNE52ekNlbThhU3ZGbVpDbDBPK0FJVnZS?=
 =?utf-8?B?TS9IbWRXZTNRSHJoR1Nmdys5U0ZFTmVoTDN4S2FFWXY2L0hBa2NzOEMzZWZ5?=
 =?utf-8?B?bGdYT25wcEVKaWJqTFdWU0Ftd29HZkwrTlBLa1RPUi9UOSt0NnBXUTdONEti?=
 =?utf-8?B?K202SThnOElhbm0vazFacGx0azhncWxsRnNlbm1QWXVEZVFjeHhaYVQzYSs4?=
 =?utf-8?B?RFE2NFZZWXMwNmV6Rkk0bmRvcE5oTTkzcVVrNlBZamxhb3V1VEo2VnRYZ2k4?=
 =?utf-8?Q?Xd148UAxvdkoj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnFCRG5PdWR0Sit4UU9MOXJHVFVERksyT2JCN2ZFMStyZW9oWGtLcnhWMVc0?=
 =?utf-8?B?QXhNT0kvUGM1RjIrTnZXWWJtRDg1S0ZVY1lYd21GMVhxV1VqSld0TUloRU9S?=
 =?utf-8?B?bFBzcWQ3TnhVQlVCamtrWldjU2lYVUFUOU1mTGpYNWRYR3pVNm5PQWxBY1RT?=
 =?utf-8?B?Q2VZODFJNnc2WkI1UEFYZE5JZ0h5K2t0aUdOZ1pyNjArV0pSQXZGSlY0TXc0?=
 =?utf-8?B?am05YnZBSHBKbytWcUxFRWdwY3FyMmIwVUtnckh3dk5sMFczUnRVQWtWMGt6?=
 =?utf-8?B?ckcweVRocDFJZTFnV0pPMHd6RzFBS0w2WmluSXBwb2x1VWhRVU5wbWV2cExP?=
 =?utf-8?B?NUVGOGNzUEplOFZPbzFMMTVKYkpTRmQzUmE0d1JmYk4xWEpVaWZzRkpmYjd2?=
 =?utf-8?B?N3pITzZlcm1kWlJiQXo3anJPWm5Zemo4Uy9VNWgycTQ4RWNLb2VSeDFzRzE2?=
 =?utf-8?B?NGMwby9RWUVtdFVCeWpCMlhySkRnbTFuSmVid2IrdWJsdGMwTzlGV0VpWmZF?=
 =?utf-8?B?a3psV3pqNWF0a2tiVERSdW9MRUhSOGQrbkR6bjh5N1diNU02L3YwdkFXNjBX?=
 =?utf-8?B?UVd5RW5ydW9PWlY0clBseWl6V3ZLUnoxM1l2b01LUVRNSTR2ZHhTN3RJMHkr?=
 =?utf-8?B?aytrbzNpR2tWSTE1eGVWNjlLTkkwNjd2Ym5Fd3BFK2EzdHZoQ0huZVNKN0d6?=
 =?utf-8?B?bU84M3FrR0JadUVQSXBobjhEclpUVFVDVTl5NzdOQUhZaFdBbmRSSmozdkNK?=
 =?utf-8?B?MjdGZFR3eTVNVmtNVnJTb25GMy8rOW80a01QTjBYblp3ZVlNRUZXaUxPcWp3?=
 =?utf-8?B?MUdRWERKdWxIRHp1alpZelVIMllvRklYYXoxSGFFelhZcGRpNUtJUnRnVFlT?=
 =?utf-8?B?SmdWc0pncDd1SUlqWHhCTGk3UlovZ3pqYmR3S2hnRjFJcTBmU0k0a0tHMjFD?=
 =?utf-8?B?ZkgrVWR6NVdxQXFTTVNJNVpaaHUvWHRiRjdJd3BpTitQbFNodjYvZjRDL1A5?=
 =?utf-8?B?L25STHdrTjdVZWpHTXhKNEJDZlJiOUJlaThIVk91U2xQOWtBQ24ya2FGRXpI?=
 =?utf-8?B?cit6OXBEeXlTb2pNdXBzdkxBUlBicWc3azd2elhjemtVaXlST1l1V0hIQXY5?=
 =?utf-8?B?N1AwZEZ6bzdrK1lhYmZZNlVoMElXUFNpa2VNVEMwQVVROGE4eXVUdFByaWRa?=
 =?utf-8?B?SG5Gc3RtdE5UaExHbXErSVBSaWYzNkY3aTdMOVVmNHdxTkcramdiVEFGalk3?=
 =?utf-8?B?RDNKa1paYUVYczQ0emwydWtYbytNY0RLSW1IZ21QREFyQlE0MjdQdE9DUGV6?=
 =?utf-8?B?b1RJWUtQa1lKTFlnRm81d0cydTA2OW5UaXhlUVQ0TFFQSm5sVEV6cTExMnZB?=
 =?utf-8?B?aXF2c00wb1pNRUd5YzgzMXJRNjBhb3VNZjRIeWZLaXZGNXhjVE85V3Rla01s?=
 =?utf-8?B?bytqUGxXRFI0R3ZrdEhPU2owSm12aEJ6cklWSWtmZjE5MUNNazFhL1RUMm5x?=
 =?utf-8?B?OWhiZk52b0lWOUpmUEEzSmxENTJUSDBiTnFBNVF6UXBkdFcvNkptK3pnK2l0?=
 =?utf-8?B?Z3RhZXpmRHRwWjNQd2NvRlNIOUh2aHRXTWZmTGJodzNtMExRN3BvZUlOKzY2?=
 =?utf-8?B?VmcvZkc1dDVNd3FGYTNuUlNKbkp0d2I4TjhEVSszcmZ4WlQ1clVVR256Wjhl?=
 =?utf-8?B?cEdzM1VKa09OdFJpRGhIckRndTY2V3F5ZTcrbTEyNld6Nk9jdGNZZjBlVy8z?=
 =?utf-8?B?b1BRQ0plQWtEYjUzUHFGRUhQSVR4TUdrcm55M0FJK05kL29Ka3hmNnhGQkFh?=
 =?utf-8?B?TmFSN3BSWjRqbDU1SUlKWUZ3ZHUwNzV0dDJyNjM2Wk4rQjdzZ3BsbjFnQ29j?=
 =?utf-8?B?NkhUekw1bkM2VlBzdHg4WkU1QmttWHUyWnI2T2MwK3ZVN2xNcmlyNlZzSk5y?=
 =?utf-8?B?bDg0RDZEZW1UZm5hWlA0TDdlMEpRSzlsNzdFVmNmZ3g4dExqTmFuSjZCTFFw?=
 =?utf-8?B?bXdPMXgzaTlnWWNnWHJMWC90L2dNTU94cjY5NGNPZFRVblNQUTZ5RjIrM3lh?=
 =?utf-8?B?aFpOTUZYOWFTU0R6ZEdNT1BvZjFXY3FTZWozeDZjSHlnQkRKd0RBNGFscWJB?=
 =?utf-8?B?UE9JRUtKWGtlY3VjVXpaK25KRkszdXUwMVBSWFZ1UUtreEZIVkt6ZVBleFlh?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mn7cq3ILmXGVPd4IBLNwohkc5ppjMuLuggLWIulgw6zk+OiUZKV1BpFqzMgY8JWJ9l+C8bOqll05C5z79cJkyyz67ulJKD+v3eLmtnBbdsfbWfTOmldH7dCMVTR43kvyYXoCTxBJR9aCenlRVyjPPofQQGPXAHPEZgfvRzmZDEs74U1AacMBCyvlgGxQtUL8nESgay23tZVaF82Dnt7OPeQdHxFV7Sk1HoS/nYLy7GoV+WqejOknwHQTYBcnrp46bfxqo26/Lg8PhxpoofYNCfRviseEKLYnw1Dgxm/tTBfCb/4ogQyhNlGyQzxPg/Q14n8Gzpx1Hci28EEcBDKo/RmfcR1WAnA5pQlHJR+y0k/8/orc8YK0b/gq6+4yOxNNlBtJWPx5tUQXyLS6jnrTsOwEMULGICw99BFOtr4sjcQnGbdwL8osjXvPLQXQRTkIDZdASI7qG8z2n2/8krLoVWUxnsUYcGr+vwZRVF8kTiqg5CZuNDY6CXOHo0Fekw+KCzV7SoA1gNA35vbagBCFLTIrhev7xOmmXWpahNUqzQEt3yNaAIRtJVnc3iDNL4980dLfD3kPJQbRb1Pg0XkimIhroLzy+pml/UOu0MN5gD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c851b4a-2867-4c32-95fd-08dd613eec76
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:21:44.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UWCiqHsRLJblH97vDnGGZ7qEKcw3EwqQujyoaopJ2gjxAU9+6SWEZoBnoRh+1qxweje0TeDYzfwa2Fe5uddbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120055
X-Proofpoint-ORIG-GUID: lwzLnPffjtun6b2lax0OiyhKHswOljOq
X-Proofpoint-GUID: lwzLnPffjtun6b2lax0OiyhKHswOljOq

On 12/03/2025 07:17, Christoph Hellwig wrote:
>> +void
>> +xfs_get_atomic_write_attr(
>> +	struct xfs_inode	*ip,
>> +	unsigned int		*unit_min,
>> +	unsigned int		*unit_max)
>> +{
>> +	if (!xfs_inode_can_atomicwrite(ip)) {
>> +		*unit_min = *unit_max = 0;
>> +		return;
>> +	}
>> +
>> +	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
> 
> This is a rather ugly interface.  Why not have separate helpers for
> the min and max values that can just return the actual values?
> 

ok, I can make that change.

Thanks,
John


Return-Path: <linux-fsdevel+bounces-43874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D0A5EDF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB043A7F17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0D260A4B;
	Thu, 13 Mar 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LUehwrFb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gm/lK6du"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D571EA7FC;
	Thu, 13 Mar 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854293; cv=fail; b=UTle3gl6wPZGVm2YHfxIBD0RnaHJ2VtfgxANjNQD7E+sPgAcaBKQjlI/4R78lUWTTwUeGVt7ofwUtCYXNRsYdODzvaw8Mg0ouVrNZ9uLsINvF8MSLvPJCF3TfIQQiBl4qXas1Y7rzOr/lGHsKN4lzlzzmYEBiYbeMDS38QFvVVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854293; c=relaxed/simple;
	bh=JHeFxwVb+1/KDhztI+0idfDE/bgUBqFXuup3V9gVa2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFeZ/bEWW6OHy4pfXuNdEsZsrRA51riBqo9lt8qIn4fLD1JxkEdDbHr72fNi/iEQkRWpjkFwol31B3aARjM8+qgMbPxq033SdEWAWn/dVTJBWWdwv79ZhB+d6dXGykEASGsL0NLFl5TOw+/X/4epx/8A07bLFA3kqeHyVi2TBKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LUehwrFb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gm/lK6du; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D80mFn001647;
	Thu, 13 Mar 2025 08:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JHeFxwVb+1/KDhztI+0idfDE/bgUBqFXuup3V9gVa2w=; b=
	LUehwrFb653pfiGR9t2bl5pe/cZ3wz1/OSMgtjThlxdmM7rx3mHWwLg2bVhujhYT
	C/22o/fwSnyOK6ZvdpQR14AAB99oeIDjRNs/qSiZVhykkoWtWFoIlweiLqPmk3Yp
	82u5syBkZ04NUE4HXzApQ0HIzaTqARg1OH9VeJClpvyA70p8tsOQYFI2s7K2XYMO
	3Xn79+Cry3ersSs/YL74w6MoDL/Y0EmFDITbXJUfcnqZ8zDT/iwp/mhlQFZyzgjf
	L41kN1Jgt1IF6Z2G/CwnzCC1MP/I0mQeixW4Z4Q3WtTmwgNUtFqhAcngOCmUIJqP
	BjmXtmgZpqEyE1gOplK71A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dungs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 08:24:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D6kmiE019431;
	Thu, 13 Mar 2025 08:24:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn1kk1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 08:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpi821n+9HKR4Rgg/O8sDaTXKYO/NZ6CLb4EGen0jdOsa6mhJgSO47H3uy5vzyZiRJPyPfHNVMv0ny1TL75DLCn89+z64mlcSuEAMEubvqJO62myAFwTqKP+kGdku5/wR5KLkqnF32dULFPCJRREpSqusWilzhMPFKGXNkm6HrD7xNt0nFEvoWTkdK1PktQsZbIJnkNgbILfI2gMUzWaM1aaLpTjwSvQtGDpAGRDTe1IOoIWgAa5EOr6QR4jZfHSHhA/a92coZbq8bAwSr3gjfg1z0Xm7l0p+hoi0pAVvn52annSdbUZ0UqW6mltBXFGOpsEKF9z4VJAlt78EtLlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHeFxwVb+1/KDhztI+0idfDE/bgUBqFXuup3V9gVa2w=;
 b=iRMv8dIJILahO45pQ58MWc/LWvzRSKnFdwxU3horFIUZYvYMBu+eLVXnN7C03QGLpN6RO1vdWA2TR05DsjvS8Eb4OmNNKdw2UQfT8Oz0p6v5EzbqFQLgsqBNs4FrRAI439I/NP9+asPvf6BkX5dNaKbX1lkwSD4NO10Qy4AXbiyhFGrxUj/YBnntWyHAhkmGeVBbLGsloPDdEnhchzvPXfR1EP7+BIc5QqRoRvMAc7IZc8H3yro0iRfZ3PSbXQAMTWTr1xEEwAzXHE11qWfiRjG5k1f1XK9/IyiFr1lVNolq3w0Lvl03vfguZvoCRf7UwtyulIUF/UMj7US5yo4UvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHeFxwVb+1/KDhztI+0idfDE/bgUBqFXuup3V9gVa2w=;
 b=Gm/lK6duhfCC55ezCp3waWFJJcArajxK4Atf/fWutODxI8i/ipU2bguJBvOJRPIO9S1WpSoW+Awijwa/0/w1+U+280UeDCLZ2cgO+wqg/59P0s05u5NrHX4uKpLI7UX45HLBD6uoyM7OGCu+RQ+qjZ64LgtaMrwLZtVmSN9Zfws=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5029.namprd10.prod.outlook.com (2603:10b6:408:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 08:24:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:24:38 +0000
Message-ID: <129aebdb-190f-4cec-aac8-afe73b418689@oracle.com>
Date: Thu, 13 Mar 2025 08:24:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, djwong@kernel.org,
        cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org> <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
 <Z9KC7UHOutY61C5K@infradead.org>
 <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
 <Z9KOItsOJykGzI-F@infradead.org>
 <157f42f1-1bad-4320-b708-2397ab773e34@oracle.com>
 <Z9KSsxIkUbEx5y2L@infradead.org> <Z9KU0gJwSW8IdPH2@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9KU0gJwSW8IdPH2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b96b550-fae3-405f-42e1-08dd62087eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1rZTBmK0xlWFZ3ZDlpclZ3bVNUMUJUOGU0T1AyMEtRazVXdUZyT1c2aDNa?=
 =?utf-8?B?VWtGd25NN3oyT1lxWThjTTZLYkdjYWw4R3BtTUx2d0dpUnRWZ05QRDJmcTJw?=
 =?utf-8?B?cDU1L0ZGOG5CTE1ZMUFBRWVkcUFYcmttNXhYR0xjQ3V2V0lFM25IdU13RWNX?=
 =?utf-8?B?TlRBS09jSFpVYVpDN096RnZSNkxieTI5TFZvQXV1S090a21RVGlHcHNNUTVa?=
 =?utf-8?B?eGlJbWVneVBPMmNUa3NhQmZZcHd3b2lrZkhtR2Zyci9kaGY0a1Z5cUJsL3RB?=
 =?utf-8?B?RjV1OTlBcVNTZlJtL0p0eWk5MGdqWXZFTEplTzJwbnMyRTRBaldHeFllSWRL?=
 =?utf-8?B?NUhaT2p4VERNV1FSTW1DRExVNnZkbE5IVFVjeUpVb3JPemJSN3gxanVKL1N2?=
 =?utf-8?B?VzR4dmVmRFR4SjRDNlRQcWI1SEtRek5oSzhyYlA4aFdUZXFCNWVLay9MRzky?=
 =?utf-8?B?WTdHUnFqczFETXU3dkxuSENKcE41VzZkRGZjZlVIbUlxSTFUZVZTNHJBZXYz?=
 =?utf-8?B?c2lMSHo4SmlnTnBNdHhvenM5a0xuMS9EcTRSMythVDg1OXZGV0ZjWFN5aVZB?=
 =?utf-8?B?SDN0NjdEQVMxcnhNY2dCdXZvVlVNUWt4cWNoVXIrQXNsL0JqWGYxQ0t2cG9q?=
 =?utf-8?B?SG8rZGJRTWpDeEhzbVZqK1doY0JUUy9paWRSa3Q2OHhLM0RuMVpYbm84RW5N?=
 =?utf-8?B?UytnN2hXaDFUOVlueC9WZS8xUjhlUnFiSEdMMmhvS0lLazdSdWJGMXcrTHhp?=
 =?utf-8?B?UGJyR1Y0eTlmSHJsMEVLV1E5cUNGdXlYWHFoeEtBNFBoVW16ZVV5d2I2bnBK?=
 =?utf-8?B?dUdDU1hWRndMWUVKOHNMYVhpSTVISytlSnh5b25YWEJSSlc4TmFtZ3dob1lI?=
 =?utf-8?B?Y25WZkI4MnRERll4V08yYWs4cTc2YUlwU1VOdzJHZE1hUlNMTk5HUkszNE9o?=
 =?utf-8?B?OWlOWDZBYlVKMkJTeWx5SzllMTNneVUwekw1WmxtREN0WDB1SC9JbzdJSGdN?=
 =?utf-8?B?b1pjQkF3Y1BDNzJDN1hZcTFQTDgzUFBFNW5qaW9oMlN5N1hGNitvSDR2UzJl?=
 =?utf-8?B?OWYzdkJWeVpIRHBUM3diT3NURlJXNHhvNmR6TzE1d1k5UG9MWXNHdFFZYlZT?=
 =?utf-8?B?S2x0bWtBWWo3K0E4MWtna1gzazVvL0dCSCtpTjBGVVZxQU1xVEdKQ0JaZmhX?=
 =?utf-8?B?ZzVIcys4YW80dWlTaklMaXArWFJoWEZuQzVaNjFMV3VrWlJhZ1BGbkFVdHJZ?=
 =?utf-8?B?UWdBcTRRTUNROXJsSVk1Q0hNNmVDdmVzUGNUUW8rRTBXc2l0aE0rM0QzaTQy?=
 =?utf-8?B?UkgzSE1ER0dDajhPTTBsN0FwbjFnTDJ0Q3FqWkNTbjhHRll5d1VoQXhvTjZt?=
 =?utf-8?B?ZHl3T0tZMTU3V0xuOElsdTArR3lPNms4b2ZQQUpqOFovL1M0UXVQeGEyQytm?=
 =?utf-8?B?SHd2cis2VWxobC9RUVFnQzEyZ2grdktFMlJQZlhoYmxRN2Jsb3ZINUhVZ0Mw?=
 =?utf-8?B?TEFTZjZYT3RyaUxLQTZiSWxvdGI5ZW9sV1JkS3dRcXpldWNSNDAxaEl0ejFS?=
 =?utf-8?B?SGEycWprUnBVNlIwdmlDN09oMHZ0Z3lkZGFZRENVZDRscERNYUNsbnp1YVNH?=
 =?utf-8?B?WDJEZ0RvRVFMOXlDc0dSQi9FbXREdEw0dzRVYlk3b3NsY3BoN3Z6allNU0xu?=
 =?utf-8?B?STdGb0krNmM1TjV2NzhDSU4xK3hXd1Vta05rK2JGd2FmZ05NSGpvckFvd3pO?=
 =?utf-8?B?ZXFHdGtzT2J3akcrOXRYSGUrM0FFeG9zVC9Eb05yT2Z2TjZSbWhzODlDNmNB?=
 =?utf-8?B?ZmFEUUZZY1ZPSS8yMXRuU29WMmFxaEhrUWl4QUhIdUlSci82eXp6YnpWWGtS?=
 =?utf-8?Q?1BjXm/EXPyJY/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFlHTUNZYlQ0dkJCcWpGY2ZESWQ2SUFEQ1EyRTE5YndHdS9QZS9ySVMvMklT?=
 =?utf-8?B?QTBaLzQrYkRPVnNrY2dYNHNNMUNkUGRxZVRPZjk0WGZRbjd4ZjhxKzBydU1T?=
 =?utf-8?B?RjZxMU1RYmdLL21mOWgzTThldG41YXFsNUkyeTNha0xtaWJRUVZBVWVLM2Za?=
 =?utf-8?B?OFl0UUtMRnZCdkgycnNPQ0N1TjN4NUhvem4yWlZkRWJOQmRWZlE4ZFpBRHhx?=
 =?utf-8?B?V0htejRZd0RseW9ZdVNqU2IvRHgwTEJndnZDbndFa3FONVM4MmtvV1Uxckp4?=
 =?utf-8?B?VENxTlI1TjhQeGdSMERMKzZ5K0IvQUJrREZNcUZNbHl1MDVFVWw4SEpoSEZv?=
 =?utf-8?B?Q2xvR2xvS3FsMG9LdUlwcU01QjErOGRxUWFmTkVQdW0yeHNvTUtWR1VWQUps?=
 =?utf-8?B?Y2ZwRTBPWmdKMkFSVzZrSVZRZU9ES0pNbE9OeGE5ZXFURjZTR0Y1Q0JXYk5E?=
 =?utf-8?B?dENodWZzTXNZMlhxUGNCN1AyS3dLY2tVbjZEWGhyWXhXTHpCVDB4bXpvemN2?=
 =?utf-8?B?WCtjQVFWaXJjZEppRlduU3d4QWVGaFpCN3R0K1JiTnhIVHlSM3dGdDlhK05G?=
 =?utf-8?B?ZXlHV05GSXNCM2sxSzB3WkpYZlhtdzcyK2h6aXJCOENWdy9GbFRkcFBROXl5?=
 =?utf-8?B?SkJueVFXTm5YSmJ1L2J0bmtwN1NGNU1LamQxSUluWGxlZXZpaXFJbGcvQUhK?=
 =?utf-8?B?R1dQdEhtQkp3ZkxMK0lIangvMTd0eWtHcTdhUThudzRnRHRpTkM1VGVZQjVR?=
 =?utf-8?B?VGovRDltM3FQang2c0VwOE4rdkdlL3M0dU10SmdKbXd4cWNkRWRsL1V3TU9C?=
 =?utf-8?B?TDhGLytodldRVVdtQVlIOEZRYVJmdW9KWUF6ZzZrTVNmTiszN3I2Yk8rWUFq?=
 =?utf-8?B?d0puYXRnb3FCM1luWDhSOU9rV0pVeUZWbE9mV0lqNGx2b1FuS3hQTURobG9G?=
 =?utf-8?B?cmVpYkpKcmdwY3dlQWoxUWFnZkxjN2VyeHBFdUM5M3g4Mm5Pdk9IemVabU5J?=
 =?utf-8?B?TDIxTUFyNm9qREdsS1YzY2JrZ1I4ck0zUUdKZFdVV1R0Ykl2ckZYclpkV1dm?=
 =?utf-8?B?S1BHc1JUUkpPekFpS3F1UXJ2QjA1OWdWNWdkWW5ja1B0OHRzbWNrSGxaL1Jp?=
 =?utf-8?B?Q2xBWi9WbkRHYzgxS2xxMEh4NDFNeHlGRDZDTTRRbUFHMTRSQmZ0RVhEaHhx?=
 =?utf-8?B?bG9ESDJnbG9xM01aai9YREtkYXNqaGFmSkltam5QMmYrWXdxaXIzdGU3VW0x?=
 =?utf-8?B?aEZFQWl6enV6R2piMW9zd3Z4S29iYnc3eDk5OFhXbUU4RGx0dU1vYUMyaElv?=
 =?utf-8?B?U0hWcjVidmovTDZaRkluQ3BVbitROUFWMml6RkVUTlZRSGVHVkNYWHl1N29Z?=
 =?utf-8?B?QTNtdS8vaUJlN3Y4WHhYTzM4RkM2bU1iR0J5bkNIWnVsbXMzZWdWVzJuWkZk?=
 =?utf-8?B?eERTaDA3ZTMyYnFWSXFkaDdHNGpHQjhxSythdit2SDdZeEcwSkdqbzAyTC9w?=
 =?utf-8?B?TUdEVkJKSDcycEMrREZLRitSL0lHeXVRc0RCR2cxSGNyUDd5U1o0M2FCenVy?=
 =?utf-8?B?eVJFNlBWdjhrRW54b0p4eEdRU2xHL2NjbGxveEovTGhQNXV3RzdqOFJXOGhS?=
 =?utf-8?B?M2xEMTRpN0NidVBuQTBSRlFIbFBYV1c4cytxanNuZ2hXMXdmQVJXNGZsbnMz?=
 =?utf-8?B?RHp3eS8zaytva0R4d09ZSmU1QlRFa0ZtWnZHa2tsTDJKRDFPMDFhbHo4ay82?=
 =?utf-8?B?NkNQeURmTVNuWFErekNDTURvNlRuWEtxbXRBYkNoeTVUODFlZDhnZnhOSDJj?=
 =?utf-8?B?Wkp2SmRSMWlUQWVxbkVYU0E2cm8wY0FXdzlvUXN0UWkxTXduWnRRWkd1b0Ex?=
 =?utf-8?B?aGUrQVhGY3Z5NWZCa0xkbHBYbEI3T2hpWW9uUXl0WlBOSXJkenV0L2trMFBP?=
 =?utf-8?B?UXBjdGxLcXIzbnk0MzIvaFlFREZONDIzQmVGYmI5Rlh2Z24vRForRlJEVUY2?=
 =?utf-8?B?TTJ4QTBjajNNQm5kMmdQN3NxNnN4NDRya3dKL0ZWZW5FblloNmU5WkRycnNW?=
 =?utf-8?B?VkJmaVZIR2YzY3h2WkxJUkFYMkZQYkdDMzlRaVlQN3pTalVrMnZVd05sT21u?=
 =?utf-8?B?UG01Sy96cUtWTHZkT01EL3JhWitWaXRXMjNOTzZVMnJNSFZUNnNYM0w5NUVp?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tb8gPWYWg/U3HaWT2H5Aatkd9LYeRaeRzsuca3RyoVyz4iFSkLRBpBbV1I39ecc3qsF6k3KYvc0rac8xCXJr2qOvI/+bTPoNsz8HCMMHoKGzeh197dEhNTIKGMWOatQ8N36Kj4u3mOpiJWEZX4j0tAl81MIB06j6+RWWEStsOHL57P6YZf9oeyB++2p+12dgGJ8/0eXe+CtlnVXcTeW2sjE6jOqXSma83TY/954iG8aOXEnztcO25S7/WD6xjJFEuQcLlaU7uqE5DddDo2zb829g8PVhhX/RovWGWEsRIiMMmhy/0qLHbCwg37aj4Px7H2+c7ROzZ7FneX348wPBa2aiV0um3YtksCk91AsWWym4Vi8io6Tb4leuk53UN6gsyAo3CPiFXvbKZWWnniTSdYvnoJomQShlcSwFjiR5eFLT3NUPUQ5JGqfgW1J9FosixIlgU8eP26ajmW7bkmeguqKA88M01DDncYD9IHaG/hJfwmpiaTPe816Dn0QVeU4o66PngvAJ5QTAUwym+3aapLXpqY8cpH8TG9z98yimuZyI/Ir082ad+XqzYt0R6kqyfaCS5dnyAi1Ykh/Yng5isvw7PDNRWC1HW0Kbg1B5HAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b96b550-fae3-405f-42e1-08dd62087eec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:24:38.8006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdEFCGvaGLz/qp7hGySlf8dBgPjxoNPXFG/NQSiylJFKKmzXVLz3zrqqrXmdWKmnE7L8ko9ymlzgVKkxRHOo+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=872 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130065
X-Proofpoint-GUID: 07zFqgCmuGLWJYtNkKssaKUu3n3tLbQI
X-Proofpoint-ORIG-GUID: 07zFqgCmuGLWJYtNkKssaKUu3n3tLbQI

On 13/03/2025 08:18, Christoph Hellwig wrote:
> Something like this (untestested):

looks sane, I'll check it further and pick it up.

Thanks


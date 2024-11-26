Return-Path: <linux-fsdevel+bounces-35897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D83A9D96D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5EB283FDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17E1CEE9A;
	Tue, 26 Nov 2024 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QF3uk+Mr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wfaPHNy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1AD1CEE92;
	Tue, 26 Nov 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732622295; cv=fail; b=loqrIT3/eX4j6FJfPKvOijFu+dswaQ0EhV+78k1Ds3ToIuGCKtG75Q9zhNIsXnhnERgh7tPcH/9zEyFP2HohAKi1NPR3A4asUMkP2v19roVxP2lxPkqe4RVXJ1rl1WU70ybMYEvotKih8sV001Onw0YOQzSrOAus8yhDsb7zOAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732622295; c=relaxed/simple;
	bh=Aj5sQi4p3A6qoyyPGWeznyGaQ4GA3UIoA/yYa860j+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GX9D0gj6F/phDz4c5CO6L/CUNgN5oqL+7PxSUzBCXyzwYlwf1XcyfYSaMxr2Wr872ZMVxqrcQIp3FEcSM41iczIJpljNMH6R5pOas8ykjisTARQWiQuaLr6UOy63FE8d3pz4ZTmBQOAnEtRaufAO2NF2a3X29sS3tD0ivKvaFAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QF3uk+Mr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wfaPHNy9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ1MjKT030926;
	Tue, 26 Nov 2024 11:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tt56kw67W4Fcc3DdTjf3mFd7BhnBNZGvlh5EDU+5xzQ=; b=
	QF3uk+MraPwTGKlBObe0Uc87qq9EtWymiKLyVE8W8Cm/KuH/LJKniEl7Wa9ghDQp
	9z1ByUEK0Sckkgi5ijl1p2S5omdSrgvpr3vDVjSL36EBGaj4X5zjFEHrLQOKOaJP
	YWKCrdXFQs2cwho2jsAZa8i7/l2t+lBD6BvPzsfMOhRrDxkMNcJusoyo+8m+c3d9
	rnMz7MXBSjnq2QMpPk4V8HA4or01jfTA2Z/nIYNatrUr6/xr22dW4Jfzq4Wt0L1T
	qnnMeRFAQBQgYwoFg2GdONwCAM2a7vwV1UKgydTuT42aHfBd4ObT3lE4n14V5b3N
	5QkYSsPZnYyqu/03UhbLAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43382kd94h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 11:58:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQB5Hrw002657;
	Tue, 26 Nov 2024 11:58:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g92hx1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 11:58:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkMfsuwWvZt3lChR9exouOps+gQBNKs8Ey4MRERI208g4EaBt2aHa9qVZx0kg7x5vUWkuzMdJJFnUJo5LwcyH7SI2tqbgM+dvKKF4ZnEJC8X1SAsR1u2MHH+RlkZUJOEqtpD8NY8sWZu6uFHYWxPpUgUiobMfEuKt3WwP/EuZwc4VVoo74hABg9M3xPTTHb5BQ2hlgzP8LkJHAQ7fW8wcM83gdzYmnrYmlo6gcMrW1+qzO0qw8tsIaRxX15h0xtJKdo1pVDoD4oH+/i3FlXK61HVH/EFx9a/4vGXyecTVDghenlghloIcqRDJTyyonhWvjroZn/fKmIjTWDuTUOxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt56kw67W4Fcc3DdTjf3mFd7BhnBNZGvlh5EDU+5xzQ=;
 b=gl8odB87q3gScVRQO2yehJxlONyefgsbmup4cgWpS2iVBvj+euyEYwLI0Y8mh2JXi5kyQiglaF0gDhbq6Oprgce6oveZNgh8iRGFohdwVWdxVPAuGS5CG2bU/B8jEyFANwt0tV58MiEdWg3wTTFR8AFJ4MccqwRWqP7rAitFNG8080mUTvI4U0oyolsYpyuH3F3hiWLlU26SXt0a51RqmKiThUqpHDHimNbtd9gEgAOtRmEIxj1yo8tiRK8ILB4XBBrw+BqRneqLpVzZEXdLwA/QxqATKQVeTqncZxv9v++Gr+fI4H/b4B51LM1N1wAMCBaZPo1cX1prsD/or3IsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt56kw67W4Fcc3DdTjf3mFd7BhnBNZGvlh5EDU+5xzQ=;
 b=wfaPHNy9ISdgKBiqtHrcj2iOySLbSXAb3cnvYKpRvxmhrrTPfUmmCWsMfrobePagM0ZEM3WCsHKAD4fQILT5xf2Zw6+kWNRSDdeinqdEopiO716uewtlb/fnylabLYPlL/BPZBahxV4ti7BEF/RD6LHqp6wy6agVnEAxrCu4GzU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6707.namprd10.prod.outlook.com (2603:10b6:930:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 11:57:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 11:57:47 +0000
Message-ID: <5459b3a5-a9a0-43be-8e61-a3799848dafb@oracle.com>
Date: Tue, 26 Nov 2024 11:57:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] readv.2: Document RWF_NOAPPEND flag
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, dalias@libc.org,
        brauner@kernel.org
References: <20241126090847.297371-1-john.g.garry@oracle.com>
 <20241126090847.297371-2-john.g.garry@oracle.com>
 <20241126115257.r4riru6oot5nn6x6@devuan>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241126115257.r4riru6oot5nn6x6@devuan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6707:EE_
X-MS-Office365-Filtering-Correlation-Id: 737168c4-0fea-41b3-6031-08dd0e118b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEFDQVRUVTVPS0tIUWRJcXB3VHFBRkRmQWlFMDU5QnIzVHZva0wvc01qclpB?=
 =?utf-8?B?MFZOOCtka0t4WEFLSFNkSVo0a3RCU1JvU3dpQzBwbGJqVEp4MUxGRUhsSWY5?=
 =?utf-8?B?dGUybHFDdEREUTlnZGVPS05yOWp4ai9UYzNZbENVblJyMks4SDlKbXVmUWEr?=
 =?utf-8?B?K2JsM28wMHhXckFtRTMyVGNsem9DODY2L3c5bENId0liUjdaZlBDUHFCaXJR?=
 =?utf-8?B?TlBhNnlyc2wydjJUS1BRTlp0aTcvL3lDVWMyaTIwTW8rK2JaRzRKZXkvbnhh?=
 =?utf-8?B?NFVKK2xGM3oyN0xLcFhMQ3BDT053UmR1UTFoZWlYY1l6SmZBby9JWHFxWlg4?=
 =?utf-8?B?RDVveFZqejg4TDFKMkZBc25PbktTa3RLOGdlZUpMVjBxTFRYTWtBaHRYVzlo?=
 =?utf-8?B?aStiemppcWFaNi84Vm9jN2h4WUtpQ2NzZHpoTCsreWZGZS9PODJLTUMrTDlR?=
 =?utf-8?B?dXVDeHV2SFJhTlpZTCt6aGpBWDFnbEFxSzFybGdYaXF6MytsbjlHYmM5RUZ0?=
 =?utf-8?B?UEN0cm5uRTFaa2ZQaUlmU08yZUJhMCtoMkw3NGNzQld6TVRXaFE1bVdGazB4?=
 =?utf-8?B?U093bXpuNmlld0EvblRFZW1hMW80YnNxbkZ0SzV6c1VMVzdYQnYzVVdwbnR1?=
 =?utf-8?B?dFZML3NLL0VHdkJTODQ2UFU3TzVYRWxTUHZlT2o1L1NWZm1JRWlaM1lPZVhy?=
 =?utf-8?B?VG8xVkJ0OEJ2R3pvNWlKaWJpTzI1eU93a3JGbW1HdnNUdjVCSUFyWmlLUysy?=
 =?utf-8?B?THhZT2VBVmxBUE9xek1IYVRKS2dmeEVOM1V5VHRiWGFHUEhRVUlZTFNJcVFk?=
 =?utf-8?B?bDEvNWdkQU90bmw5VjcyRzBRTTU3Q2JPNERsUmN0VDZYaWJFcThRclJMRUwr?=
 =?utf-8?B?WWR5ekxSWkhOZloxYWRDWVRWSk5IQnk4NFhLajJTRHBPZ0pSQnpYaUV0b1Rq?=
 =?utf-8?B?cTJISmQwVFNlV1ZOcWt3ODN3MjQxeXFIVXkyTHJpUkZHMEYyNWFJRlNFUnBO?=
 =?utf-8?B?Q3dveGsxY0xBdngvZ0F2bXpabnNDQlc1ZTNkWHE4WW55RkNxM3BsZi93Lzlu?=
 =?utf-8?B?T3RtblBreWxyb2J5bDhjdWJMeWR0Z1Y5eWd4cVc5Z3BrY0hZV0RQUE40V1NV?=
 =?utf-8?B?K0ZGL0FVMVZ4TXBxVHZObUtnb3o0MHp6MFc3UE0yaTZuRkc5dm9yVVl5alFi?=
 =?utf-8?B?a3J1eWVFeHhFcW9Yc2tUK3ZsY2lGTkgrZ2FCUkc4bWNmbGxKeEpTTGYxcytG?=
 =?utf-8?B?RGdtRHg3MTZUdTFKRlpRL3dBZTAxc3Y0T21Lc3ErUk5tWkw4VnMvMkh0Tnht?=
 =?utf-8?B?dWR5RDE4Wkh3ZXFvRk1rYU41d1NhNHNpNWN2a0M5UUZuZm8xUThjSWVXTjZI?=
 =?utf-8?B?d3ZDZldzT2YrZmlkVDVuc2cwVWRVZTl6cjVDOHVnRGZkSUNUVS9TeFFJOGhI?=
 =?utf-8?B?RmNxL2x2bzFteHFBbTFxSEJtbEZDalo4cDhUOS9vcGU4dFd5cEV6a2VUbzFq?=
 =?utf-8?B?NGdGK3BFbW9CSHhYR3B2STlvLzNmZWhSS3VPaGNFUHhkWkk0UG84M3o3NW1k?=
 =?utf-8?B?VFlVaVE0a1VYWlc0SHRjc24zLzFMakl1NHRSV09ZTlRUMHdsdjdzRWVSOEtV?=
 =?utf-8?B?M2RrQmI2M2ZjWTVvT0hqT0s4NE9kWkl5dHdQTUd6UXJHaS9mRzVpUWE5MjlL?=
 =?utf-8?B?L3podXhJb1R3OEE0Qmd1Mys4bHdOZDcrYS9SYUo2N24ydW1TSFJTKzhQZ0hU?=
 =?utf-8?B?S3EzYUtHbUtuWHZqNlZvRTlKcStHbG9VKzM3VmlGVStnck9DU2lRTy9UVmth?=
 =?utf-8?B?SHlBTHZIcFRWcVdJeVJ6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERGOGlHSVNGUXBDNGFHY1NaUGFyYnlDTVFmVDJwTXpGd05RbDd3SG1sdE5D?=
 =?utf-8?B?WkVRNXk5NXRsOU9ZQmtjb2FIYjV3ME4vcmx2SlpGRExLd1I1L1JxdWNDNnll?=
 =?utf-8?B?MUwxWjBQUEJsdUROSEdEeGVZQk10ODhWZk11b0V4TFFtSmNzOWx6NG51SVJE?=
 =?utf-8?B?UnBqV2NBYnlMTGpKaXMrY3Y2c1JEOWd0VnRJNDZURVNjYmNMV1JLY05UaDZn?=
 =?utf-8?B?RHpFN3RuZ3pzMEZDNU81b1RqQmNYdmF1VmZsOUhmWkZnWHhZRDNhN1Z3R0lW?=
 =?utf-8?B?bGVlTXNqVkRBamVrNnZmN3p1UE5KRnhxNWExaTdlY1dNaUlQdmNhbHFRZmZG?=
 =?utf-8?B?N2tJOFJ5Skp2L3ZjdEppN0lrYytJNXRoS2VQRjVWaFRQS3NsTFhFODFLK3d2?=
 =?utf-8?B?Z29KZkYyZTR6cnJoMkVlcWt2TkE0R0l4VDAvVWJ3SGpXZk9TTVBtTllPWURL?=
 =?utf-8?B?Tkl1MXcwWlp3b3dBVjZoMmZ1TjltNEtKcU1ZNnQ1aTRQVEpmWHEyWnhuaHJj?=
 =?utf-8?B?ckZXZTdXSTNiei9QbEMwQzJEc2dLWXpMcHF3TkJrRjFrK1UrY0h0akhJWk0w?=
 =?utf-8?B?OTI5dVVYa29LS0hnZXlxT1UyaFRLY0J2TG44ZVhwUkl1YWdyZ0RTNmNKbCtn?=
 =?utf-8?B?dmxjZ001M1oyZElKMFVHdXhyLzJUeXBkTFl3YnhXNm90NHRBaHJSTHN6Y2pU?=
 =?utf-8?B?OGdOd05ROTEvRk9zTVN1aWZ0UlFFcFNkUXJBYlBYRXgrQlhZbGY0YjFNYjNm?=
 =?utf-8?B?aGl3eHREejhwN3V4U0Nyc1ZkNlJsdW91ZmFQdmhib29jNCtiVHRISk5CQWVh?=
 =?utf-8?B?RjZjWVR0dmkwQWNBeFJ3SThmU1dkWEVRYXo0WEFHTFJtVkNCVlhzTmduSHJy?=
 =?utf-8?B?Z0dsb2JscSt0bm4yZlNYWEZ2RUpENUlzNkNieExiQXV1WTJqaHVvREJWd3ZV?=
 =?utf-8?B?MWVRd1plbTFMbXcwNjRnZng3QXRxNWFxM3JmL2tsMVJXUjR1aUx0ekNxSGRF?=
 =?utf-8?B?VXhjV092R01xbFZUVGZQUHg1a1ZLZmljTHU2SGorRzVFZTNmZTd5RVQrNkY2?=
 =?utf-8?B?eFY0b1paTm9teU5nVkJ5SlM5eGRMRk11cTJRNzdTZ29CS2N2Tmw4QnNod1d6?=
 =?utf-8?B?RStib1pxNXJaM1VPUzIwQUJ5YllDYUtIOWt1ZnlEWjRMR2pTOGxvQ3g4Q1Zp?=
 =?utf-8?B?NW1QVDE1Zktobll3S1RWcTJ5V0Faa1l2VzAxZXBQYXRYR2VTVzdTUUMzSDRt?=
 =?utf-8?B?UW1XeXlZaFNUdnZHVExrMUpUdjhGVDB4eTQ1NnlDWjVCVCtjT2g2MXJ0U2ZG?=
 =?utf-8?B?dFowTjhEblNMY25VQjgyRE1Icmtjd1BTS0tiWllTQTV1SFYxREJyNFU1czZ3?=
 =?utf-8?B?QnVCUnV4MkJWU0Q4KzcrTmdrdUVDeFJQNTJOMU5yZ2lFWlFBTlJJdjVqcmxh?=
 =?utf-8?B?Q1NGT2sxVUFtTFYwVVY1a2tRRVpGaTh2Y2x6RjdGelVVbFgxTEVTbnp0aVdo?=
 =?utf-8?B?TzVMOHFuMC9vTGdpZXg5WmduRS9NMmZXTGg2UnY3dEJEM0dIdFhIaXJlL3NT?=
 =?utf-8?B?RWYxRzk0V2NHdzZEc1g4VUl1RVhFenhWY3VIb3h5RVBIUmJyc09pVndtRjdk?=
 =?utf-8?B?Q0hLQ1c1eHh6ek9tQWVtY2doSktiK2EzaU5NRnplRFArQzY0Wm00ZE1SV2dS?=
 =?utf-8?B?eUVEeFRRM29YTUxZQWZTZy9zQUJIblVvMkQ1WkxSTW1UazVJeUw1a1BYaXVH?=
 =?utf-8?B?TGxkNTJCR0g1dGRqQjVkQnpMOHJYMm9KUEM3V2xQRjhiazMxTjVEcjhIVjNF?=
 =?utf-8?B?RE91TU9BaU91aUxmN0d4cHQ1L05IeVpiS0Y0UlJJQzZvNjhPVWVReWYyME9R?=
 =?utf-8?B?K0JQM1g1V0g2T09hTGtXWHh5a3Y1VmVDUURmbWdiWkpaN2VLVGY4ZExhTzdJ?=
 =?utf-8?B?bURUcFoxdFhLRFBGc1p0MEpjaDA0NGRCZnU2ZEJZMDNvMEpSYmhYc0pFdGhs?=
 =?utf-8?B?VHYrc1o3bDZ1aCtIV29pTmRHRGZZNFJpVmdIeDdjVnhuRThxMnpJRnlhRUh3?=
 =?utf-8?B?UDl6MTV3K0ZYejM1aVBlZ0c3c0dmY2JYeCt2TmhGamFwa2ZEb1dZaFI1ckdn?=
 =?utf-8?B?K0xGR0VLYllUSEk0WlIzQ2MwVUhqWDJIRzhiTUhDNzcrQU1hVXB3L1MwbGFn?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IWcqWZEUI9dmDUqx/S1hvWnqirSFIuJ8XOhl9skNv6vG2GJ67dFooPz81pYTmU5VPuMb6+0MBDXDv1T5oZC9BMMHAeCBOHS7xmfNdL7TILbnP5V/sL/izp/YVTc/2yvq0t62SpGZ9WMaj2V8QK/fKSDy05c+gQdWAB78b8NTHFikIeCJGvPaFW8bKoDuB3waMgN+eGnk0xA7dH4TPxhx/QMKOe46XqUXcqW7L5s4vEHxsawopblY+UlGoxdbKJuRrWdllYBnfGcMPEmo0tzZRNwn1C8+FwtJYtRzyBgKN3fS+IT4OsRGp+adDVW+AqFomYdOiS+pKtVcC4BRXjRsJtHroOvmLMTSCVpRXSHiN4yH6knOdAVEUn/D8aO73eSF3RpRDGnKM4ubYb6P9MRSbE7PW7RlmqKWzucaoQv50SqplL4sBgbn6ocBKulxmRFU/2h6iojn8e1LPwxTNqMWBA/hHUahe42m06DK9seKSGJnSDa845tuYVR107tOloxvDE4ol4cUCqyk5l3LxF0ZLHU3W0u7ynG/EsvQEEXUF/9W08tpGiOLdtVW8WipOTerjFZ2PJ9oNhbGAQh3MdHNpXd2SXLNDMjs+M0dfk05p78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737168c4-0fea-41b3-6031-08dd0e118b95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 11:57:47.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0pT7HM3a02fJ5AxbiPSnfje7nzA2lUEys7dCDTkQOu+HU9pGWsEH4v33lBHvfqrujagiR89/GK7IWnuQLMDKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_10,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260097
X-Proofpoint-ORIG-GUID: 4UUjysEkyjMXcDhDJfQsgi4xMn_2uTWq
X-Proofpoint-GUID: 4UUjysEkyjMXcDhDJfQsgi4xMn_2uTWq

On 26/11/2024 11:52, Alejandro Colomar wrote:
> Hi John,
> 
> On Tue, Nov 26, 2024 at 09:08:46AM +0000, John Garry wrote:
>> Document flag introduced in Linux v6.9
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   man/man2/readv.2 | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/man/man2/readv.2 b/man/man2/readv.2
>> index 78232c19f..836612bbe 100644
>> --- a/man/man2/readv.2
>> +++ b/man/man2/readv.2
>> @@ -238,6 +238,26 @@ However, if the
>>   .I offset
>>   argument is \-1, the current file offset is updated.
>>   .TP
>> +.BR RWF_NOAPPEND " (since Linux 6.9)"
>> +The
>> +.BR pwritev2 ()
>> +system call does not honor the
> The other surrounding paragraphs talk in imperative (e.g., "Do not
> wait").  This should be consistent with them.  How about this?:
> 
> 	Do not honor the O_APPEND open(2) flag.  This flag is meaningful
> 	only for pwritev2().  ...
> 

That sounds fine.

> Thanks for the patch!

No worries. Let's wait a bit to see if any comments from fsdevel people.

Thanks,
John



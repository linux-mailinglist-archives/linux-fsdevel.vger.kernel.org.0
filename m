Return-Path: <linux-fsdevel+bounces-18426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0878B894F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 13:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31023284FA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3207F7CE;
	Wed,  1 May 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IwEsjy+I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XXHG0QAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A57710B;
	Wed,  1 May 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563405; cv=fail; b=Zz5seZ5RmKa2ehIGmt7X4abgESD3FjhYoSxx6S8eJoP1DdO65rm4nCh+rIzCrX7bSfyt0jTN6Jda8S5ObncX27HUMSTLW3kalo0aIibGnb6NyXpqR51ZANdd9jGon64zsBheSkDm27SYbvmMrlV/DDExQ6RodEL2xcAh1WCd7d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563405; c=relaxed/simple;
	bh=dJNS3sZGvFTdpt3brjDDXRk+mG5+miY5qz/IKEpj2HM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lpDqawRHT7iMZRA0kohZQhJ+nLJ7bnlN1lzNX1FVKiDsjbVImY36ADkFb4/rncn1YhV6zShQ2LKYT5Dh+SdOYS9WgVRPSLCTCLoYli8091hM5iccItPCbM9l+XuS8+J1mMHWdIZP7Z587d1ZaqKnT/JRXBkwIcqpzvLcIUJgbaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IwEsjy+I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XXHG0QAg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441ASQc9000841;
	Wed, 1 May 2024 11:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JGRNBvC3/N+VOr+sWUDvPh7J4Vf9Jg/NApNFm/EJdmc=;
 b=IwEsjy+IWw4pPV1bs4mqVkKwb7EB0zkFyrdsvKoV8C1AKJOhvO0ZgZafZQ8uTNPStglP
 +8BYJZ79efuclIWHoO5FL9cI4LBNtRi2Pw9qfUmsFtVaeqiVmrTHiF4+Pj6MeJf1GLJR
 rDQft1FZD7mli8PZiGCSbpC264QzY1ssuYWlUlVEvJwyD6lWai1aZC5/dRbuEgdnBp3l
 tfEzRZmj9fxcwIMAl/GvBwOENkXRznZKirpfO8WZ/COdWHSy5LI7TudhsufsgFhly5qr
 nGzfgnJJZjwWZcgiHgKfpjEJO74JY+t0qQcf82Kih1qy4Dtkrne57tLDJR2TKgKMiBsQ iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsexyay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 11:36:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 441B9L09033191;
	Wed, 1 May 2024 11:36:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt8yrav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 11:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7/jrz4nN/cCkIYgI64hoHfPitsGvWauygIq/sgVgxcQpI3Taxcr38aN9nLlYZGXer0HdEmdzW7+JWEkKRBa1iNw6r4gYCTwN4v1pflh/VF9VrP8dLbOT8404K21BhDHRdKfVfe2+79qqalCarQnxcIasHqd1jHzuw4GfE6Hy/jJrAwzsLH8/A+5kxqvAqyQXW7Z4Ef6YrpRL+090YEywS4kC8B/Q/h4UUry6YVywn3gUq2Vd6/fN5GCULmlxz3oQYk4AOuiDBX+fPBa7chWFvkrl12MEvBNVRerK8zcrDawkqGm5paSxyN3iV0gBylIzceN6hANSbubKZ8BrUiyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGRNBvC3/N+VOr+sWUDvPh7J4Vf9Jg/NApNFm/EJdmc=;
 b=AHHqnTvywRuKk/0rSJQhE9VM5jDZZlkBDCXLqpXsVaonXz2SqP6o//UEwQJLLyHA0v4w1g71TR9dFlX4qJIPEA4iiYTbHQX28a0E/T4aUjIZIPI2NDuzsrCYNp8SnFqNoVYl0ZNX8y5KmXMjITaGprPuikBYPZOVYYiA7OxRIDWY4uiHToERMBjal/B93QlFFGjcr8hSbuF/grsyKig/jQaRQsCQbdUZAVNlX9dAhXUydmUrqtmO8UBU3BdSSI827HyxiUx/9ZfoGbNIxgBxJeHroXzCtaW7zLxvYhMASb5g9u4crnavVxg1fRXiyhIJ2g0BCsIprbx1inLBejs5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGRNBvC3/N+VOr+sWUDvPh7J4Vf9Jg/NApNFm/EJdmc=;
 b=XXHG0QAg8WsOU0y+rCaYAwOaKks+5IXlJ4z/wbCirS6oI6rKDBx/pP92vP67h7owpm3gKD/1NqRBaGX38PhUACU00RrVkaa+UkcV7ADidA0U9ruH2+z9gsPtt9WikkQVv4BbZl84hQu2Vpt3VN1dBXJcl/nNI9V3VmRc8suljVA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 11:36:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 11:36:17 +0000
Message-ID: <0eb8b5b6-1a59-445c-8ac1-1de2a1c0ce4a@oracle.com>
Date: Wed, 1 May 2024 12:36:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/21] fs: xfs: iomap: Sub-extent zeroing
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-16-john.g.garry@oracle.com>
 <ZjGbkAuGj0MhXAZ/@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGbkAuGj0MhXAZ/@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f3be51-390b-4575-1dcc-08dc69d2ea08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aVBhWFhoZitYRi85NEloM29ON0FjRkxjZTRXOW9ObW9DeUU3SUtRNEU5K3hL?=
 =?utf-8?B?M2RNM2E0SGZhTzEzOHVzV2IrdCtCMThkV1R0d0ZxcThnSHJEMnZKU3pOaHlu?=
 =?utf-8?B?K1ZXcXAwWi9LVGVNdG5jdlE0bkVRQ2wxbk9CVk80OXhTZk15R25jZWJ1Vk1C?=
 =?utf-8?B?Y3hxRENpMisvT2lOSVdVenR1YWZ3QjJYMlB3OVJNdU00amI0WU1xM1F5RmMv?=
 =?utf-8?B?dEU3NnRwcXNDMUhQYm1IL2xLSEp6MXppMENscnpVVnMycnVVakxmcjdmcEZo?=
 =?utf-8?B?dzdCNGRCbDN6K3BqelkyelJVbUcwaHpjV0d6MnF0eHBjSHM3amh2QVROQmsr?=
 =?utf-8?B?NktXOGZGTytsVjV1MHN5dHlCVW53YWg2YmFRVFZBQjdpeWJmaDhxSWpHdmxx?=
 =?utf-8?B?ZCsrR1dEWm41NVRXZTk3bW5UZWl5ckUycUlRNk83ZWloTStUb2JZeGNDY0ls?=
 =?utf-8?B?dlY1ZGx6V0V5R2ZQbGRlbkdEUGlCTmNDdkN2MG1WbVJVVUsrZnZ0b21nR2Q4?=
 =?utf-8?B?N3VjM2NURjdtSjBsbFR1cytBU0hCcmdnWDRiemx1M1poazNKSkR6VEZzQ3l6?=
 =?utf-8?B?TFhwa2l2d2tNM1Y4VDNIZEhGUzBWaFYxeWxackcwdVpkL2ZSTFBBSGQ4dy9T?=
 =?utf-8?B?S1BVckFqWTA3MWlFOGZlcXFtdFRhVEVQRHp1a0NsWXQrdFlqVzlNMU9ibytl?=
 =?utf-8?B?VWVkVzMzcDNYaGxpZlJpQ21ZeHB5aUlvOElkS2VrVHg2WjB5SEpyRlpNcnVZ?=
 =?utf-8?B?dkNvR05vRXZkUTRTREJuZlJGOEYxVUNnbVJ2RmZJMjRUZmFKQkF4NmxKMEox?=
 =?utf-8?B?RGZzSldWT2ZJaXYxcUgvVUxTZmxQblNhbkZmWHVyTDZ3WXFqQ0NaSzZCK3VR?=
 =?utf-8?B?bHVFYzRWNlFTQzRXZ0tBU2FlSTc2ais0ei9pbGwraHBTOTBDZ3Y0RStmSDVJ?=
 =?utf-8?B?UzlXaXFnNTgyN0lXN2l5M2NXUHhPMHhaREZYUHB3ZmIrSXRxaVNLL08wMW5v?=
 =?utf-8?B?aUdKOGpwYnhGZ3c3aE1mWUNTaEY5Z1ZNa2ZZc2RFNG9BcGFSWEZ4L3JsVmt3?=
 =?utf-8?B?b0N2RjZwR0k2OGtNNklUN0F4Q0lzRUJlSndoc3lndTZyU2p6SlJ2cnFJN015?=
 =?utf-8?B?UzlFYjg3TVpORlI2cVNzRzRYalIrN3E3WkhRZTBTbExwZ1dEYTVlWjU2dWcw?=
 =?utf-8?B?SUl2TjJXc0JHSm0wSDhkVGxkY3pOcVM4K21vUXZJWUdmbUR4dzdWNkh0YVV6?=
 =?utf-8?B?NmR3WFNvcnFBL0s4Nm5yZzVkdE16VW1tTEROdGJoOUU4cFQrdkxqczNzTk9z?=
 =?utf-8?B?a2o1TTVOaGdmaDFKNEYxNzUzTG1sM1JIYW1PZGh2VEdFaTZRKzE4TzBOU3Ft?=
 =?utf-8?B?Sk5qVGI5UEVSb2U1aXRlamxBVlZ0OWVzQ3dlc2I5ZDQvVTdESDdkQTN2SjNl?=
 =?utf-8?B?L3JCZzFCUDJpZldxSDJ2ekZGMUIvZDBHNTlZQURQN3FhRWQ4cGZKY0hEUVp6?=
 =?utf-8?B?UUp4enpSYUtjRXBxd01hWitQcTljQmMxYlQ2T3VmYlZwUjl4MXhtNEF1Mk5R?=
 =?utf-8?B?Y1pFd1lDcHNrNW42Q3pSa2xVQ0p3SnlFbzlhV1ZSUWh2R2tsZFRYV1JYY0p3?=
 =?utf-8?B?VlZ4M3V4WUJpNm82czd1UkpKLy94Q3F4ajEyUm9ib0VWOWFjdDZCdlJMN3hv?=
 =?utf-8?B?c3lSZDVubmhmR2x2c09oSTBVY2dQWEMyNFpRQXVYMzk4cndBOVZZeFFBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnV5Ym03T3ZNNWY4KzFUYkJrbHI4RVhnbmZzeWxhVnZiNzdDUW5NKzhzbHBp?=
 =?utf-8?B?YzFoVWlOR3kwUkFlMWs2dUVTaEVvdjVjUXBiTllYc2ZRVlNHSkphYUgwbEZl?=
 =?utf-8?B?VzFxTjZxT1FRUDZPV2s0OGxBbDZmL2hmbUVGamVlSit2WVVNYmU2ejVoVnpG?=
 =?utf-8?B?UGRGcWV6Qnd6WjdkNmtHRW16UUcySVBKQzdlR1R3cVRadVVnVDdKWUJ3MnN0?=
 =?utf-8?B?S0ZqUUF1YzV0VnMwZFYxWDlPVmhpT1Y2eVNHMVNKMWEvR2l4UFZ2dHdQODI2?=
 =?utf-8?B?VVc1YlhQRmxIWEkxaGd4N3RsVjEzaTNidUh0M0RWYmRwTnhKQ3BBbzV4eWNP?=
 =?utf-8?B?bTFCMU1JQUYyS05Sb0pHS3p3TW4weVROSE95NE8xc2FGR29vdlBXQ1lLalJ6?=
 =?utf-8?B?QVMrYld2RVVNOTdFYXhOS2NmUXFNTkVoMmNwb2lNa0pJU3ZSZTV3NEpDVXRW?=
 =?utf-8?B?VUt3TUFEWHNtZnVQRENVMUZ5MnI3L2VuN0pJcUhlL2tUOTRqYTU2S25uNzQz?=
 =?utf-8?B?M05YaUo4cU5KYlBTVkFqSDlFdzN6NHEyTisrQXZiUUl6dzNZOG50SzMyVnhQ?=
 =?utf-8?B?ZC9uSW1MNnFSWGRZUGtVY0lCWkFha1hSV0FYUHh6NVFmQmc0c1hmM1YvVFlG?=
 =?utf-8?B?SGthRk5HeWdYcks1aGNxVGd1QUkwVFplcm1ObWp3ZzcyTGJwcnQ5a0JxMFBV?=
 =?utf-8?B?d1MxT0pidkVEbTAwOG1jOWMyYmlMdCtjQXUvc21LcDY4Wk1NUHVmY1ZmVGVS?=
 =?utf-8?B?YkszOEJLTUxJeEx5cG1xejBBbGlQUFk5eXYvdEF0U0ppQTJUZ25PZzV0Umtl?=
 =?utf-8?B?WitGYVoxWHNtc2pkVmNLeG83RjcvU0IwUDBxQS9tSVUrVUZLWndVaG9uT25o?=
 =?utf-8?B?eXhJS0JqZ3ZnY3hMT01FM0VZRXcrKzI1Ti9wbGNZTjUzcnFQSzVRZHFPZmVu?=
 =?utf-8?B?RGZCeWpxOGVyaHlvVkFhS3JUVzlVSmVlbzVPMXhORk5QUENnWVVBRHdlV3Rn?=
 =?utf-8?B?b29abDBhcXo4dW9WZW5oRnZHbDVzWmQzOGU3N2FNNGhFdmlyeFJpRS9NTmhw?=
 =?utf-8?B?ZDBmbVRrUE1NSEs4TUMxcTEzSlExZUlrUm1KSDRpRHB5Lyt5YVpIVmR1TU4x?=
 =?utf-8?B?alFrVnJFM283TVBBQS8wN25FMFpUWGppWEpRTTh2c24wZG5NdVdEUnBJRGJG?=
 =?utf-8?B?eTlJVTY4Nmo3TmRsbHRUMldJVUxLSDVyMEM2VmM1UzdFams5Ym51RkFZb25p?=
 =?utf-8?B?dG9OeU1PY25jeTZUWU90aXI0VFdOenp3WEJDNHRYTGRpSERyQ0hZYW5yclBx?=
 =?utf-8?B?YzBKSmM1cTN5aUtjT21LN2RTTnA0R05xOUU3bDlHOXFCdndRN3lvN0VtcFBV?=
 =?utf-8?B?YVVVaXJjMjh6TGgxa1VQSWIrLzVJc0QvS1hVQnY3NjlTaEFZalQ4Y2w4Nmd1?=
 =?utf-8?B?aGNPelBPSEs5dnNTUHJQRjJac3VLbEZkOXZQZDlvQU9NOXFaQmRjb1g0YS9D?=
 =?utf-8?B?ZGVFbnk1bStOVEYxREswRDdudVZZbTJHNHN2NjVjQ051bXFrVElVczNBU29B?=
 =?utf-8?B?K28wcDhuMTI5QzVYcWhIUXRGNTBlczRXdGp2Q3BnblI3ZnVmQXhBcFFzNjJv?=
 =?utf-8?B?UnN4TTUrWlVYY3l1Umt5S1NmM3ZraWVwWlZtZnBDS0dCMkw2aDJRUGNxZUY5?=
 =?utf-8?B?aFMvNlBRMEFjMUJTNjlpdjZnNGtvY3RpeFUvMXQrR0VlOWZqMTR6bWRuNzEw?=
 =?utf-8?B?STRlSFJIWm9LVU9yb3d2WWY1ZytFQkQ1OUJ3UUtDY1A4bmprbTZ5YmY5cXJR?=
 =?utf-8?B?cEdMdG05TXJlb0xWenBOVHNyTHJNcGNMeFp4cGVYUkpVWUN5NkN6V1VGZENo?=
 =?utf-8?B?KzJneDlmTCtMTzJYcm5qektUK0R1VlRoWC9VdFpFSUtQTkI2YnRTTWE0MEdp?=
 =?utf-8?B?bW1rc2pLcm5XQWEyU0dLS3dVS255dnAzeU5oVG5Md1dyVTF5U0ZvMnU1MERE?=
 =?utf-8?B?aEt6dmRGRHF1NWEvVTkvVnNacEViT3FOemFOcUx5anl6RXhoMGRwOHEwZkVZ?=
 =?utf-8?B?c3UwcW9ObjAxbndHVGhlMWRtMndsUUJPZzFZaGoyRU5mQWZIcml2V2dIZDYy?=
 =?utf-8?Q?HL0s4isemGD9UFTf6qW6XPLGZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H0MBkU1MdI1TU48Ph710ciJ5XB7Y0RcRJVq40Y8/DRwimAebGs7ynp9ikjShoMzaJh+dbLhFJD+yjINQcBXfEpUzrLmlDWFyII+Tz11YFUuxzKc25YQyAtZeQ2w3t/nWKHY4H9zV/BOwYnthI/MoNbmynV8xmP1zv0MRR7d9m00VKXloHCbA/mOLlMuixDURIwUfPxY93tqOAF09HSmEy/fNqud52DQfpF653fp6xZYtx6QasDFRYv+da/JfMWbmy7Sh9JdDjm+zuF3LNb/engZFPDZLwd7G6x71SsMse42FyJ9JGDFtGLpW+AXTbYt5yEeFslJXHY6I9gI95JdOj0ARonOpgHxDNX66VWE3gsZwrq8XFouhodeZdvdkpWF9VAbamokIdh6hKr+aboXwawoBOCm45f2wITrLyAs2LoSdIQdYLMm3lE1y3Kyp51GxT6O7BZ55al4crhPe5SmFlnsmhd1HtuQuvDvj91PdqdFlhcCS2TnqQNdM0yEHCHybeI+rtlndTYdTWoS6u/Im187qPpUsObUN6W0tVWKpZv3sHO5jVMMwRYXgmOMRVX8q+8BJGel9UadlE5cMCevSvz/DeXKmrj3wp6mvACI4TT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f3be51-390b-4575-1dcc-08dc69d2ea08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 11:36:17.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFfIfxjIyf2FuOvMyJBXHaOPb13/KkgXk48ac9Py51i9S/e4pRmjUoi3w+oonFiR2S48SA4jFw/qz1qKWAf7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405010080
X-Proofpoint-ORIG-GUID: CnRu1_afS67ps0ou2lBVmi_jB_XfxrOG
X-Proofpoint-GUID: CnRu1_afS67ps0ou2lBVmi_jB_XfxrOG

On 01/05/2024 02:32, Dave Chinner wrote:
> On Mon, Apr 29, 2024 at 05:47:40PM +0000, John Garry wrote:
>> Set iomap->extent_size when sub-extent zeroing is required.
>>
>> We treat a sub-extent write same as an unaligned write, so we can leverage
>> the existing sub-FSblock unaligned write support, i.e. try a shared lock
>> with IOMAP_DIO_OVERWRITE_ONLY flag, if this fails then try the exclusive
>> lock.
>>
>> In xfs_iomap_write_unwritten(), FSB calcs are now based on the extsize.
> 
> If forcedalign is set, should we just reject unaligned DIOs?

Why would we? That's very restrictive. Indeed, we got to the point of 
adding the sub-extent zeroing just for supporting that.

> 
> .....
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c  | 35 ++++++++++++++++++++++-------------
>>   fs/xfs/xfs_iomap.c | 13 +++++++++++--
>>   2 files changed, 33 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index e81e01e6b22b..ee4f94cf6f4e 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -620,18 +620,19 @@ xfs_file_dio_write_aligned(
>>    * Handle block unaligned direct I/O writes
> 
>   * Handle unaligned direct IO writes.
> 
>>    *
>>    * In most cases direct I/O writes will be done holding IOLOCK_SHARED, allowing
>> - * them to be done in parallel with reads and other direct I/O writes.  However,
>> - * if the I/O is not aligned to filesystem blocks, the direct I/O layer may need
>> - * to do sub-block zeroing and that requires serialisation against other direct
>> - * I/O to the same block.  In this case we need to serialise the submission of
>> - * the unaligned I/O so that we don't get racing block zeroing in the dio layer.
>> - * In the case where sub-block zeroing is not required, we can do concurrent
>> - * sub-block dios to the same block successfully.
>> + * them to be done in parallel with reads and other direct I/O writes.
>> + * However if the I/O is not aligned to filesystem blocks/extent, the direct
>> + * I/O layer may need to do sub-block/extent zeroing and that requires
>> + * serialisation against other direct I/O to the same block/extent.  In this
>> + * case we need to serialise the submission of the unaligned I/O so that we
>> + * don't get racing block/extent zeroing in the dio layer.
>> + * In the case where sub-block/extent zeroing is not required, we can do
>> + * concurrent sub-block/extent dios to the same block/extent successfully.
>>    *
>>    * Optimistically submit the I/O using the shared lock first, but use the
>>    * IOMAP_DIO_OVERWRITE_ONLY flag to tell the lower layers to return -EAGAIN
>> - * if block allocation or partial block zeroing would be required.  In that case
>> - * we try again with the exclusive lock.
>> + * if block/extent allocation or partial block/extent zeroing would be
>> + * required.  In that case we try again with the exclusive lock.
> 
> Rather than changing every "block" to "block/extent", leave the bulk
> of the comment unchanged and add another paragraph to it that says
> something like:
> 
>   * If forced extent alignment is turned on, then serialisation
>   * constraints are extended from filesystem block alignment
>   * to extent alignment boundaries. In this case, we treat any
>   * non-extent-aligned DIO the same as a sub-block DIO.

ok, fine

> 
>>    */
>>   static noinline ssize_t
>>   xfs_file_dio_write_unaligned(
>> @@ -646,9 +647,9 @@ xfs_file_dio_write_unaligned(
>>   	ssize_t			ret;
>>   
>>   	/*
>> -	 * Extending writes need exclusivity because of the sub-block zeroing
>> -	 * that the DIO code always does for partial tail blocks beyond EOF, so
>> -	 * don't even bother trying the fast path in this case.
>> +	 * Extending writes need exclusivity because of the sub-block/extent
>> +	 * zeroing that the DIO code always does for partial tail blocks
>> +	 * beyond EOF, so don't even bother trying the fast path in this case.
>>   	 */
>>   	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
>>   		if (iocb->ki_flags & IOCB_NOWAIT)
>> @@ -714,11 +715,19 @@ xfs_file_dio_write(
>>   	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>>   	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>>   	size_t			count = iov_iter_count(from);
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	unsigned int		blockmask;
>>   
>>   	/* direct I/O must be aligned to device logical sector size */
>>   	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
>>   		return -EINVAL;
>> -	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
>> +
>> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
>> +		blockmask = XFS_FSB_TO_B(mp, ip->i_extsize) - 1;
>> +	else
>> +		blockmask = mp->m_blockmask;
> 
> 	alignmask = XFS_FSB_TO_B(mp, xfs_inode_alignment(ip)) - 1;

Do you mean xfs_extent_alignment() instead of xfs_inode_alignment()?

> 
> Note that this would consider sub rt_extsize IO as unaligned,

> which
> may be undesirable. In that case, we should define a second helper
> such as xfs_inode_io_alignment() that doesn't take into account RT
> extent sizes because we can still do filesystem block sized
> unwritten extent conversion on those devices. The same IO-specific
> wrapper would be used for the other cases in this patch, too.

ok, fine

> 
>> +
>> +	if ((iocb->ki_pos | count) & blockmask)
>>   		return xfs_file_dio_write_unaligned(ip, iocb, from);
>>   	return xfs_file_dio_write_aligned(ip, iocb, from);
>>   }
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 4087af7f3c9f..1a3692bbc84d 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -138,6 +138,8 @@ xfs_bmbt_to_iomap(
>>   
>>   	iomap->validity_cookie = sequence_cookie;
>>   	iomap->folio_ops = &xfs_iomap_folio_ops;
>> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
>> +		iomap->extent_size = XFS_FSB_TO_B(mp, ip->i_extsize);
> 
> 	iomap->io_block_size = XFS_FSB_TO_B(mp, xfs_inode_alignment(ip));
> 
>>   	return 0;
>>   }
>>   
>> @@ -570,8 +572,15 @@ xfs_iomap_write_unwritten(
>>   
>>   	trace_xfs_unwritten_convert(ip, offset, count);
>>   
>> -	offset_fsb = XFS_B_TO_FSBT(mp, offset);
>> -	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
>> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
>> +		xfs_extlen_t extsize_bytes = mp->m_sb.sb_blocksize * ip->i_extsize;
>> +
>> +		offset_fsb = XFS_B_TO_FSBT(mp, round_down(offset, extsize_bytes));
>> +		count_fsb = XFS_B_TO_FSB(mp, round_up(offset + count, extsize_bytes));
>> +	} else {
>> +		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>> +		count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
>> +	}
> 
> More places we can use a xfs_inode_alignment() helper.
> 
> 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> 	count_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
> 	rounding = XFS_FSB_TO_B(mp, xfs_inode_alignment(ip));
> 	if (rounding > 1) {
> 		 offset_fsb = rounddown_64(offset_fsb, rounding);
> 		 count_fsb = roundup_64(count_fsb, rounding);
> 	}

ok, but again I assume you mean xfs_extent_alignment()

Thanks,
John



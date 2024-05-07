Return-Path: <linux-fsdevel+bounces-18942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE98BEC06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 20:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EB9B21470
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A168B16D9B0;
	Tue,  7 May 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SU1ZThEr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xsw+jeo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED416C85E;
	Tue,  7 May 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108187; cv=fail; b=uSk4OZG5O8Re407CuyOZPrBFLa9rUoe2p9dRnv2IbVV9/SQPbDQKv0aubkD7Qbv3AGCStkKpLoZaKA1Ehcq67y+AzRqE+iLqZtHLZV7qMeHvieA/ZEecvioaeAFTht/lzIEC+K5dY2cRFptytDrNIeT4EmT6N5xzhTh6hJXz7/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108187; c=relaxed/simple;
	bh=vnyK467lhxqdVzBZtdhUIimES708RjRY6vps0PrtFjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tf+8Ff6xPaIOywN+0UwnIx3nDEETevy4cEzgVkl7RZx3Gm/djCU7Qd9sYrM3kCOI0awwo3PPr9IiIWx92yTDOk2hVQdGJgDt2fsMoIfp2wY8srDMxc/8uyaiZC41j/A9PxRxzYeDqNrXgt1fNQWsG5uW0J9DHsjWMfkOalyoqQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SU1ZThEr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xsw+jeo7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJmTC014423;
	Tue, 7 May 2024 18:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vnyK467lhxqdVzBZtdhUIimES708RjRY6vps0PrtFjY=;
 b=SU1ZThErUuE8+lRRY+xZ/KeJFpeEBTm6dEy52wAsZU0J9oloDpU7GKhOdBcX2tJtqvMP
 57HuE8Vc4jWsr/lovq84BHB8rBfFCeLP1D78W/kySWAXWLJaXqhJVG1zrbJZAwNi0/OF
 BkA/p/5nkPpbK9iMAA7JeCBJQRX3EM3iiwmnbm4Mdze2WHioGsJdoNUlIzFdPOf2fxwn
 Bi+gwVKZnYzD17TWTUfabVaIAZelS5yg6Blt/llTvpZlFy5I5mdHuboLkORTq7H+mMyC
 oHPBjoALODGTLEsDGL2XpIwueEHQh9qTIEO0RB0kCb5JNVCrGVy8yuTw23iJuhze5fM4 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv02sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:56:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJ2bD020171;
	Tue, 7 May 2024 18:56:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfk1d29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 18:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXZtrIdnFbkpKgtZX+zMvaf+l+UmvTJYHnbsCVvWsxEb/T0jjVifT7Sz7JB/ZunZJXUw2MwPbXXIl3didvHqTIAJtsryWrrAE2auUpB0EWdEm1gRdQFfeIBuV7OKnu33lP9nplB+gBlkiHbeH/C0NdsoiTVRBa0oJAf7wwxvFuueOsQzctNP8BvKDmz3WGGNl+zU3+xiYdjvHV0Pj3IkZ3hfMgJZ/dJiGCzpU2baR479qf5jEmSrBbF3afu1kgHcF8G1G4KJs9iGV/BNQ5JlFHCFGIWNRKXvVUEb2ANIEdPd6hI/bBUuBU4ZLYQXqKMotfcfY4SyNDxR0fsCiVSg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnyK467lhxqdVzBZtdhUIimES708RjRY6vps0PrtFjY=;
 b=XPvmgfGuDrISL10RrwlQbUE7W4BKAOAcbhfzcatD2dniPIJC+f8sYKQJwxxWmfSO7B6t/XYhT5gljTCkdf/SRI3s35wdnpIZoQuI6rrFWt2NWQENoKssr84VO55AGWr1Q2daDQTnYMPSrmWHIqt/hV6kzIAS/0XdfgcjXQXfFKMjocqRNBCOPsb9Hxwhq7T8A7khGz6wPnyPIo1cxKKPpcBFwJ9eC+5DnNfM6HCNnO5U9ImOECybCfi0U8MDipbsArP+HxPO54Hf80p2236MwykZa6xoXua32VpvPxUYoiPnqxtRv/OwM0GeWTrV8QOu6U5epMiPXg8pujXVV7mM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnyK467lhxqdVzBZtdhUIimES708RjRY6vps0PrtFjY=;
 b=xsw+jeo7NLtiVN1+TA0CwaRz2n46K4J7ly1zxy7j/7L0CzQ2qT5CpLXK1yNHF6QbO0ZPSHo3+9ZjT5JJq/tqrOOoVFXTodEEPH6BhvylNHwhyfF92G/PxvLaaPkZKC34iB520iZoUICI+YgZnBrAIZegRyq/mNhmEQSt4Quib5Q=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5887.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 18:56:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:56:12 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: kdevops BoF at LSFMM
Thread-Topic: kdevops BoF at LSFMM
Thread-Index: AQHaoK6kn/4s7u6OMUeGcEgiWsFjN7GMHwwA
Date: Tue, 7 May 2024 18:56:12 +0000
Message-ID: <52468D49-FD75-4A56-B8DF-D8DFAC617BE8@oracle.com>
References: 
 <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
In-Reply-To: 
 <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5887:EE_
x-ms-office365-filtering-correlation-id: a90708ed-5580-4a6d-7576-08dc6ec75d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UjY2L1RtbGc4M1lOSTdWcXpxS2NTSThkZk40Nmo1R3pFOVhrYnJNbFRzZ24x?=
 =?utf-8?B?Umtya2JCZTJ2V3JENjgyTks5MVlrL2dNTDVwS1pPS1ZGeFA1M2ZwSTlkUVEw?=
 =?utf-8?B?eHZaQTV4UFl5Y3JCUlM0NTFUVFVURFFRTmhLcUY4dFN1ZTdaYjlOak1tai9I?=
 =?utf-8?B?Q3VTSFEyRmtLZTJxSG1BRWpaSTIwWkdSQU5IYktNdjF6eno4Q0lFTTJtajQz?=
 =?utf-8?B?aFA3eW9UTmErY2NKUzhwOUplQXZqc2UxRGl5bExTa0hFQVlWYTBwdDdlT0s1?=
 =?utf-8?B?bmZSUVdBc3V0RmFOeTRsSUc0SU9LQWVScDQvNjVaRmFqdE1qMTJUNGdJNDlY?=
 =?utf-8?B?eTVSejhHS3c5N2JMaDdmbERvazhxb2p6QzkyU1lZQ3RUdmEzUTc0ZGlndHlv?=
 =?utf-8?B?M1g2MlBGb1RLVnR1aHBTRUZxaW5QQ25WZkR2YjJMQk1ReEpYcktEY0R6REJB?=
 =?utf-8?B?SXptbnlsakpHdmtqRWZGMkRjNzN3MC9rdnlhNGJ6M3kzWFN6YUI2SDJFZTQ3?=
 =?utf-8?B?ZldzZXlDa0pXVGFaeGFObkpEdGRsd1BNQnM0NU5kV1A2UGhOYnh4WVo2ODNy?=
 =?utf-8?B?dlR6Q2xITWY3Ym5VMlNhUWc5Z1Rwa0U1QXM3bzlZVEU5OStDQm5va3UrdWJX?=
 =?utf-8?B?V0YzNnNHT3dvbFB5QW9xeUZIMzRlVnhpLzlDMjd5RUtMRDZkcDM4cFppWXps?=
 =?utf-8?B?L25FeUlORFR5ZE9ldDNwZGY4RzBBVmFxNHdrU1Y2U0lJZ3J5aUpLUWtQVVlu?=
 =?utf-8?B?YXBaNVJhS3BtbU5NUjhaR0pVN3RBNVVBS0xBYUlXdW5vM2FPTEcydmNaaVJp?=
 =?utf-8?B?MlR5NCs5MUJWeHd0a0hOVG5lbG1xbldacjVUNEVPQlE0QUhyM28rOE5RM2E1?=
 =?utf-8?B?aUxvWm5kV2tEYjNUS2RPZjlvZmNYT1ZCUXNyRVpzMlZQaFN4UVRWM1B5cFZk?=
 =?utf-8?B?R1E5MUpQYkhOYm0xeUFmbXJRY1g1TmZIbENuQ3JzcmlPUDBMaGNhK2ErRDk3?=
 =?utf-8?B?R3Z2aU5MRDBIYUw1MFhUU2tLWlkyeVNrajdxekd1TXhkRW81eWEwQ3VWWEZa?=
 =?utf-8?B?NndnNWY2SWdYUkJmRlp3SzA2WFFjSEVQdFpqSzJ3bkxpeFc3R1F1bFU1d2Jz?=
 =?utf-8?B?VWxWMjRFZDRTbVpMNUFJT1pzTFUzWFAycFROM1FrdFdRUC95QUs4dGZkbFZX?=
 =?utf-8?B?REJmcjZZYVEwYWx1TTFQM0h0emUzNmRlS0ZxM0o2NWZXRndBVWFVaU5DZmNJ?=
 =?utf-8?B?SlZtZlVFQmFRaUdmRHg0aWRId2RHUm1VckVwaXZDYkptUmJsMm9FenJFSjNZ?=
 =?utf-8?B?QTlkQVFuOHdNSFJFRDlhaXY5UXExS3hqSXcwWUI3ckJhMWx3b1J3a0Vqc05x?=
 =?utf-8?B?Sk5iYXV2d3Y4dXRiRzRqQWtYNHI0RjFZeEl6NkM4bHc1cDZTTCtPcDEwUTNO?=
 =?utf-8?B?UE1VWDEvM2MySE1Qc3FTYUg1YzV5eXJSWWIycDhYenNxeWltVlpSa2IyNDhy?=
 =?utf-8?B?VXdkeE8wU0RjcVpQWGNHbExrY3FnemROYU5zTm55R0w5NWJOdnBpVEs4M2FF?=
 =?utf-8?B?RXFFNjltUmpBdkVYU3VIL2hCSUdON0lMbDNlYmd4VzBxaDVtRmh6MmZISFpj?=
 =?utf-8?B?OXdaRFpTc01JalZmWXlnR3k1VGFYTkxhZFZGWjBpUGFidkxDYWMydExtVlNa?=
 =?utf-8?B?N2RFMm9HaklQdWo4T1pld1FlZUpkcnVoOXZRYUtlVDZjVHFKZ1RJaGR3Z3ph?=
 =?utf-8?Q?1aD2leCKgi90QVka21z/RSH0zMwyVwXzJyTxBEU?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MW43Z0h0WGgvdXRicmd3S2ZhenB1bkczbE9Qa1R6OFBpb3RDQXVTOWVDb3dK?=
 =?utf-8?B?R3QrQVI0WE4rVHh0eWU0blVFRVhGRVI0M1o3K1dQVFMrTER3QTFVVi9qK251?=
 =?utf-8?B?TTVYb2hncXY2bS8zKzFSWi9PdWRNZTJvSzdJL0JycXFpTjNwTmdYS1crZ1oz?=
 =?utf-8?B?Vy9VT3VjUWdrWEp1emRiNEVUa1RjN0R2SDJlbGlSWDlsRm1mTVYybWFXK1Rz?=
 =?utf-8?B?Y0R6MG9qVlhIajdIK2I2WXdpeEJmR0RDbUx4a3pkbmxIOFUxem04di80bDBq?=
 =?utf-8?B?YTM3ZW1qcmFOOFpFM0RSNkFEWFcrb2JYNk5IVTVnSEc5d0pqSkRYNGVXUHlM?=
 =?utf-8?B?MjFSTTFyR25TWUxrZWl3WThzdHRqVDh2RGtlVXVkUExJODd5TStMMGtQSkVo?=
 =?utf-8?B?Szk0dnBOQzNxVWdBbFNwaVI4VWltU3E4YUZ4NXhWQVdJVWdIZnoxUk5kRWl5?=
 =?utf-8?B?SkxTSjc2ZXJLTkVJc3NrQUpDRkhxTmV2eHoycG9jTWJEelQ0VjV3b3BMY2R2?=
 =?utf-8?B?dEpZYWczdkVNak9pdUtna3l6UExKb0RpNENENVNHcU1CNi9EQXVlMk9Id24y?=
 =?utf-8?B?cXBDTWZWcm5zL1Qrdkh3ZzdCUzdDRm1FRTdaMXdaNEw0aTVyYy81TUFza2pS?=
 =?utf-8?B?RVVBTXgzQkhCWXVaLzNja0ltZGJyeGNkQWNjZFJMc2lRSDhMbkU0Um9BZnJi?=
 =?utf-8?B?bzZFcEtWTFowVWkwWEw5NUg3M2RpdXF6OEFmYU44VjhKaThxcGc3SDlkdDdx?=
 =?utf-8?B?YkJmQ1ZvUUxOclB3bzNka2NsL1orY3ZxZW9tSk5CL1M3aFNjREVUQ3lIaHV5?=
 =?utf-8?B?bnBFZnlHb2tzRmJsamRqQTdHMlFpbEdPd1d6bktZZmNzcXZ3K1FrMDNtVWxT?=
 =?utf-8?B?TmJjbnFzc0drbGxRZ3JGUFkwbWpKVnZROERCTzJBMVNEakEvTEJiUU9sWnRy?=
 =?utf-8?B?aHBrRE5oeXJ3Kzl2Wm9VZjd2V0NTdzB1aXlkUVpFSWpKZEdQaTZkTFc4NDFM?=
 =?utf-8?B?ZGRqbTVvWXR0VHFiaGQ2bVp0WVlBNWY0SUdMbGRyekpPZ1lJZDNjS3hqNnNB?=
 =?utf-8?B?bTB1YWo4SkE1clVKbkxtQW9jVEZWRXNrSE9tcDdWNHhadFFzRUpZMXRrWllX?=
 =?utf-8?B?UXh6L1FpYWE5ajJsUUJ6d0puZnJsZHZFQXlBNWlGRjNnbnNFSkdJd1hpZkhK?=
 =?utf-8?B?cXRkUDBuU2U2MEt6S0ZsOVNxQVVGWldxdU42eWVEV0o2Qi9PYkdORTVkTFJO?=
 =?utf-8?B?V1VDYnhnb0RQSUJkRHZ1WktaYXBodU01ZWF5cSsvazY4NHlzcW81QmxMREEy?=
 =?utf-8?B?bFduSlJRcllPNXFIby9WaldaeTZTNTB1TnY5ZmJVclJMeHJNcFZmWXdsU2pU?=
 =?utf-8?B?YkIzckJKSUtlaytsbllKYlM4SGFJUlFvUDlvVHg5K0RGV0RmUDNZa0ZUM3h4?=
 =?utf-8?B?TU5EM2hwbjV5L216VzE1TnM1alVDTDlzWlJlcGhhUW55VUtOd2FuQUVYUGFo?=
 =?utf-8?B?VGhBYklJRW8rM0Nkd3ZwMzQ5dkVsR0lQNjArcndpdVRTeGNhL2dnSkJ5TUl1?=
 =?utf-8?B?NjJsZnhWWmJybUJ2SHFNOUNjWTZEWVFhLyt2WHZaSEx1Z3BDWkk2YXMrQ3Vr?=
 =?utf-8?B?di92ZnNRNkIwSDZpLzI0aGc0TjMzTjg1Z3ZmK0JwbU1zZk5hSmVLMUd6MXJJ?=
 =?utf-8?B?RnhiMDlUSW8wQUUvcWxhVjl3aHJ5UUo1emlUZzErMStsdWNidFpzYTdIWG5H?=
 =?utf-8?B?V2xsUyt0WGlvNDltaE4xTHdsOFRDeE9PNXRmOTh0Mm5UVHJaNnY3dXF0eTZi?=
 =?utf-8?B?azVxQ2pXWmh4cTB4SG5iZCtkZ0V4MXE5bWludmd0MHdEOEV3UmxVbW4wUEw4?=
 =?utf-8?B?NVd2QXl5K01FYmZUV1BwWFdTNXVGNExXNEZrVWtpaU1DMnluZlo2UmlUamFp?=
 =?utf-8?B?MnJOTWpwdmhsQlEvV2hGelJiS0NBRHpBUnJ2NXJ3a2U1V0YwcTN5bVoxV2lC?=
 =?utf-8?B?N01iVzZnRUIrb3JaS2pURkxLenBQWnJhbFFxUnBTT1ZyZlVkbENkMURsd0RD?=
 =?utf-8?B?QXAvVUVSWndkbFBFcTl1bTRxUW9odDdoQ2NrQ3QwNFJ6Q2paeElneHAwQlNk?=
 =?utf-8?B?dDYvNVpUbmQ5cjdnZEhXSVQyODRscTFmVmg1NmRJRlJ3TE9yT3BlMmlvTmpL?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97461B4AE6B3C44995918B8D07692BAA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NZH+8VhglJfDLtwc93xoGie1h4/mHGz4nrNLn1kiVCzSh2bI6dK7RhowHAT2x95K3cmb+viRQPec2DkiR16WCJzsFlT5F+VRg2UMqeuqbXtw7oTgglBKeNM5QAZCj9tBInGlNN78cceT/QQttUKLzXngSlFZZuZ9MI8S9/DwQYzhP5OxFasq95R66p1jHaT5Y4v0O6b4iuAk6NwUQB1UELhmNvE3Xs77nqVYXFo2mi/ArcVowbE/WXLcAkRObZNFIotaDjWSLB+tMMBhe+XRktnX8hjk7pgJ+jYKzGXIlBZxoEdC3FH5IEJTcPK/wyTwtHnXI30Mhg0PNXXubBO5/AcHRD0MVTfccklKZPAUOJF+2neFLC6zg8tY+zRgkEQ9IOXe6lWb4OKB52zZJIHPY9TSje2bPv1o9EcVrs1FPX5IDSzRObzQOaDE9BkjrGzVxXx0BcmV6HSYhgJ6n7KpomgwtnK0GMgfdks2POWSvLvdLBBnZ07X9cSRkBjexMdZOtFGBnQBBeCcIaWPr75YM8LZ/Q1zgq6IKERA/qw7RRoe9+Xhheh6qf2trzH0eG2oJ8RpBVTOY3Y/Mt7QcJKljrklOE24Ei+eERTxdRwDcTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90708ed-5580-4a6d-7576-08dc6ec75d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 18:56:12.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CR4YNbZVC5+zZfeOj42J6DeWdeFBLLSOWIZaBBGHKfYpN2tMDT3wCnJJWKbq5kGYo95FCYvyUopK7UYi952Cug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405070133
X-Proofpoint-ORIG-GUID: ijhP_fMSoDuUfhPZH6XeYncjQZfG7zfB
X-Proofpoint-GUID: ijhP_fMSoDuUfhPZH6XeYncjQZfG7zfB

DQoNCj4gT24gTWF5IDcsIDIwMjQsIGF0IDI6NDTigK9QTSwgTHVpcyBDaGFtYmVybGFpbiA8bWNn
cm9mQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gRGVhciBMUEMgc2Vzc2lvbiBsZWFkcywNCj4g
DQo+IFdlJ2QgbGlrZSB0byBnYXRoZXIgdG9nZXRoZXIgYW5kIHRhbGsgYWJvdXQgY3VycmVudCBv
bmdvaW5nDQo+IGRldmVsb3BtZW50cyAvIGNoYW5nZXMgb24ga2Rldm9wcyBhdCBMU0ZNTS4gVGhv
c2UgaW50ZXJlc3RlZCBpbg0KPiBhdXRvbWF0aW9uIG9uIGNvbXBsZXggd29ya2Zsb3dzIHdpdGgg
a2Rldm9wcyBhcmUgYWxzbyB3ZWxjb21lZC4gVGhpcw0KPiBpcyBiZXN0IGFkZHJlc3NlZCBpbmZv
cm1hbGx5LCBidXQgc2luY2UgSSBzZWUgYW4gb3BlbiBzbG90IGZvciBhdA0KPiAxMDozMGFtIGZv
ciBUdWVzZGF5LCBmaWd1cmVkIEknZCBjaGVjayB0byBzZWUgaWYgd2UgY2FuIHNuYXRjaCBpdC4N
Cj4gQm9GcyBmb3IgZmlsZXN5c3RlbXMgYXJlIHNjaGVkdWxlZCB0b3dhcmRzIHRoZSBlbmQgb2Yg
dGhlIGNvbmZlcmVuY2UNCj4gb24gV2VkbmVzZGF5IGl0IHNlZW1zLCBzbyBpZGVhbGx5IHRoaXMg
d291bGQganVzdCB0YWtlIHBsYWNlIHRoZW4sIGJ1dA0KPiB0aGUgbGFzdCBCb0YgZm9yIFhGUyBh
dCBMaW51eCBQbHVtYmVycyB0b29rLi4uIDQgaG91cnMsIGFuZCBpZiBzdWNoDQo+IGZpbGVzeXN0
ZW0gQm9GcyB0YWtlIHBsYWNlIEkgc3VzcGVjdCBlYWNoIEZTIGRldmVsb3BlciB3b3VsZCBhbHNv
IHdhbnQNCj4gdG8gYXR0ZW5kIHRoZWlyIG93biByZXNwZWN0aXZlIEZTIEJvRi4uLiBzbyBwZXJo
YXBzIGJlc3Qgd2UgZ2V0IGENCj4ga2Rldm9wcyBCb0Ygb3V0IG9mIHRoZSB3YXkgYmVmb3JlIHRo
ZSByZXNwZWN0aXZlIGZpbGVzeXN0ZW0gQm9Gcy4NCj4gDQo+IEFnZW5kYSBpdGVtcz8NCj4gDQo+
IEd1ZXN0ZnMgbWlncmF0aW9uIHByb2dyZXNzIC0gaGF2ZSB3ZSBraWxsZWQgdmFncmFudD8NCj4g
QXV0b21hdGlvbiBvbiB0ZXN0aW5nIGZpbGVzeXN0ZW0gYmFzZWxpbmVzDQo+IHhhcnJheSAvIG1h
cGxlIHRyZWUgdGVzdGluZyBhbmQgdXNlcnNwYWNlIHRlc3RpbmcNCj4gT3BlblRvZnUNCj4ga2Rl
dm9wcy1yZXN1bHRzLWFyY2hpdmUgc3BsaXQNCg0KcmVzdWx0cyBhcmNoaXZlIC0gd291bGQgYmUg
bmljZSB0byBoYXZlIHV0aWxpdGllcyBmb3INCndvcmtmbG93cyAobm90IGZzdGVzdHMpIHRvIG1h
bmFnZSB0aGVpciByZXN1bHRzLg0KDQpXZSd2ZSBhZGRlZCByb2J1c3QgTkZTLCBTTUIsIGFuZCB0
bXBmcyBzdXBwb3J0IG92ZXINCnRoZSBwYXN0IHllYXIuIFdoYXQgYWJvdXQgOXA/IGJjYWNoZWZz
PyBPdGhlcnM/DQoNCkknbSBhYm91dCB0byBhZGQgc3VwcG9ydCBmb3IgY3JlYXRpbmcgaVNDU0kg
TFVOcyBvbg0KZGVtYW5kLiBXaGF0IGFib3V0IE5WTWVvRiBhcyBmaWxlIHN5c3RlbSBiYWNraW5n
IHN0b3JlPw0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==


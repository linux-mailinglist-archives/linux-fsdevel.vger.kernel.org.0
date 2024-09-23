Return-Path: <linux-fsdevel+bounces-29843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8182F97EB8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 14:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46E71C21348
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE22199221;
	Mon, 23 Sep 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ONJfMr2t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rnMzdlFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E1198A0F;
	Mon, 23 Sep 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094811; cv=fail; b=lJDaBsU6tT2yA+1QZkj+rz3eH0tmJA9+tes44lMcZQVBKGjV8Hufd6Nz8UoEU7ktGO7uJNUt7T1j5AV6FWslKvSvHco4bpOsziQNYJx+gRf7oaliZJS5WBjwnMb1oSgJDIHq/5TTKu9AA7PLq9N0jL92C8GdQf95mzf89Auvx+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094811; c=relaxed/simple;
	bh=YM4wOn3IlO3FAMPkC5TJUVvn1aJR9dOrzujNIaoByjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dcXRAy3T1mR3EBoxOj3+pDMZGvS39kmuUJKWBKwyAyuToXBiuhK0pN4YG3RUBqafh7qbjZ8igDvg5neiCrmOepOHY5/JXZW9JDtvK2jkHHQ+oj7E2dL91tUhSsCX4NaEVvLXFIp71kRkf9Wc6m8zztjHYHuttTF+rim2W9Rf1Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ONJfMr2t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rnMzdlFv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBiV7D013649;
	Mon, 23 Sep 2024 12:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=fK7j7RVDtRait1E2hJnJpyODuvoR7z6/aGR6nfmRe/4=; b=
	ONJfMr2tvzEs10bo6k0q9eYXxp6GQoyhMvkT9lUanGvhC4GvErRknweA+SiH51wp
	HOVCzWiSyrjnywPXYsYZ6d4vDVjcTf3n94j344DA2JB13BHonl8KvpXFhZoxogAf
	/Bk3OQkUxFYqYQm6gFPjgucQjty5lRk8skExUDgjBzNs6wv/cEB6ja4G0zYWxgyT
	uPEemn8G+0l8wEperZ0ZnuUVmjpHFEzyqE74HjlTxexn6/D4kl8W8B32K8hR6fxl
	nzU/OPhwfmdJ8zkBHpgu+ZmGv3cGaY3WB0lSMuFBUMEYoDv9MIecpbV7q346MLfX
	67cbZiLZLiRDZSvJHS5S3g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6ca2m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 12:33:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NApCaN024908;
	Mon, 23 Sep 2024 12:33:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7qgsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 12:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4YnW2bFI83ExB7/+N1BzGcm9YVlaWn4d3XTOoEv71pR3Z4z8U4Efi/9rG4YcDVWGI+1bsHRsU3ohTtVTCfJQzI2s+eE0l2MX+qWnvmc2A+i9954KoFlj0FhkZdx8dLoN9QjQu7GJ5Y+VdfaZRDWEMwMPq2TSGYDnQRFg9XR7HXSezb6O6dXjxZ0Jd891MwYiLztW1foZMoXpFbwi5nnRzOlihSSIFncIOmO5YfCdDzUJ0GD+1Ix4u7mEO5526NX2UpDlRiBYBzccX9l7E1lP+fqE29liiOxmVh8ok3gUdQZpSw42n9RFRAPHf4ArlEbDCcFwZIkOLzgcyRpQGshvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK7j7RVDtRait1E2hJnJpyODuvoR7z6/aGR6nfmRe/4=;
 b=GLbkqve4R3vkcmwIkjkxwxwaW5XZFD6ZaIJnrbZ8LsWZablEiP6KCdrUWxn/BepXeP5E/F2G+RkVankcfnLFNm/iFbda+C50kbe/GXrM3Z0zg3LzLVKZHEhgdx5tVqDTq724hCzGtsdRiNSS2zbuLgshcgHiF1RuhtFhO29j5pE45JmDyMjtSlqwksDFZMNT8CCoK/Wadxd69ttFPIRKlStAaedglzQBBaHDubQh1OzOtRNT6Ht7mjQatT3bSTVFmXFPlWdEu/5GZHrWvWzW9QorzLqdZcDdYVdq6dBEtHKiCQYRFiOiuraXMRdY5wcMr1J55fl0WJnuWe78lXhwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK7j7RVDtRait1E2hJnJpyODuvoR7z6/aGR6nfmRe/4=;
 b=rnMzdlFvVOiq5hixKxIadjgmnZKRzO/u8iIhmk6hZd/xMtvr2U05ZD+nTFmAIyadugNDfmhjuUAi/JeHsdoHwPJfBAp3hn9Y29EJxOn4j3LdNmggJUlpSYS+NqQnZeYNJBVv3ErTEx+sj1gGBA9v/wCGq1IrvOHV78cjJe9vW4Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Mon, 23 Sep
 2024 12:33:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 12:33:16 +0000
Message-ID: <c702379b-3f37-448d-ac28-ec1e248a6c65@oracle.com>
Date: Mon, 23 Sep 2024 13:33:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani
 <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        catherine.hoang@oracle.com, martin.petersen@oracle.com
References: <877cbq3g9i.fsf@gmail.com> <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area>
 <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
 <Zun+yci6CeiuNS2o@dread.disaster.area>
 <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com>
 <ZvDZHC1NJWlOR6Uf@dread.disaster.area> <20240923033305.GA30200@lst.de>
 <cfdbb625-90b8-45d1-838b-bf5b670f49f1@oracle.com>
 <20240923120715.GA13585@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240923120715.GA13585@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f752982-78e1-46db-536c-08dcdbcbe591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a21QdjJ2RmJVLzlIdEhmTDVmR1ViQVFQbFVhNUJNa0Q4a1ByU2NPb0F6MG9u?=
 =?utf-8?B?M3FzcVVka24vREY1cFhmK1JLRFhYaGRSQnZCSmxRU1VoR0Q1bVptZWFaR1o4?=
 =?utf-8?B?YThrZEl0bDRWZE1rejdRVXFhK3hvMG1CTmNwQnlqbDlKV05kNHJZUDBxL2pX?=
 =?utf-8?B?aGUwMHJrMjRGTEplUU1UaGlXNjVyRGZTUTVmdEJycFkrV0hPSVFKWUNBM0ts?=
 =?utf-8?B?RmZiTzJwSlVNZzZ3WG1GM2RwcURmTnlPdllURTBJK0Y5bFdZQ3hUcGUzcDVq?=
 =?utf-8?B?RzZWN3dmUFVtUmdKa2YyRUNaS3lqZytUdmdwZmZNbVIvbUw0TnF5WU1vWGhh?=
 =?utf-8?B?bHd4MHoybnVQczR5NjdFN1NlNXFRZmlmbWVoSVc5MmViYVFhcXVhSDFMU2p3?=
 =?utf-8?B?VzE3TTFRejFiTDVxc1hJSTlwM2YrWkJxTXkwazNGaFljQmpZbzZGM0UrVXlj?=
 =?utf-8?B?MUNZbDhTQWpaRzQ0TStDd0NjUlpCNW8rejdrSk9MbGRMY3phRlpsSGNVUS9H?=
 =?utf-8?B?dHFaaGkvbENhcFJFMW5Jd3pVTEphYm5idUZpdVcvc1VKMCtES25QZkRJRHU5?=
 =?utf-8?B?eWoxWjg5ZDhRYVRlWUROaStQdW5ZaFhrUU1YNHNOcDJ4T3ZldkdCWi9OWllJ?=
 =?utf-8?B?TjB4ZFdqbThQai9TVGZ3VnF4dENXUXpWdEtWd1Z6d0NqK1grZzJRRmZVYWpv?=
 =?utf-8?B?R0MzeDZpMlVZTkcwaXpVR3pyYTdCNGxwamZHaXpZVjk2OCtaRXhFeUtzUldC?=
 =?utf-8?B?NUZwUm5xNDR4VXQxTkdMQy9uWTVXcEYxV25teDg3WkE0T0JseUU1Mk96RFlU?=
 =?utf-8?B?MXFuYUFvSWRPTG93aFdKRTVvbXZnK3dQREVRWkswTGEvM0h6d0xsTTFRVEtH?=
 =?utf-8?B?U3pkY0NrVnpTaUl2Z0JYaGJEOWdiNlk4V1VOeCtFQ3R1Z3J3TkJRcVN4aThu?=
 =?utf-8?B?MU9EL1lCYkh0K2FnQzRJKzI2RmxnelpvU0VtaXdFcklHbTBvamRBM3pHT1JI?=
 =?utf-8?B?dWUrVExkaHhFVS9LcWgrVzhoaGI4U3hEM3FQeUVEZi8vckpQMGxaOFJOallz?=
 =?utf-8?B?TFRxYXRtTHlpcDdidFFjb2gyOG9jTnBhemZBTGFsYVVZZG4zMEViVXQrWjBx?=
 =?utf-8?B?bnVBTzgvRHduQXIxK2xFYWhYSHhsSmpuelpzS0Y1dnllME81b3kvNmIrNDVy?=
 =?utf-8?B?WHlkSldYRGZLYkFOdGFTdnFwb0dCL0p5T1JCUlRrT01xSjZwaTByTmJsd3px?=
 =?utf-8?B?UlVIN2dUWTlQUGUvb3VoRndUWFlNR0NuRnh3anBXcU1rT0xLejY5WmJnZ1pt?=
 =?utf-8?B?aUIyWDFMU3pNZ1BiUUFnSk56WWtXbkgvbEJ3WTRldUdnR3l0ejZWdGNEUkVu?=
 =?utf-8?B?NXduVzZ2V3NhUlZza3dkMm81dUNibXc1T0tOYnNQTGxUa0c0bEZrMkZMVGtM?=
 =?utf-8?B?dWU2aVVtenNlUzByb0RjUkYxU0JtTkZZazAydkJZZytIT0VYRlBZT2hDZDkx?=
 =?utf-8?B?ZVZDeThCNDBEbDYyL1VoalpBMFB1Z0prWDZreVhienRrR3pyMTBwZkpad1Yx?=
 =?utf-8?B?dHZCYjJzMko4V1pWQWFzSVhiSUY0aEpOalVEcFA0dFBFdkl4ZEV1YWlLY3N3?=
 =?utf-8?B?RkF2NVVnUnl2M1k5ZGJodWthODNzVW1EUzhuWlVBU3BkRU45Q01hWU5RU1NK?=
 =?utf-8?B?ZmVrYmI1MkVyK3JKOU56Z0wwUGdXZEVYcWpxMmozQmhMMDh6VDlFS013PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0tFMTRPU2syQy9BZm5pRkNUTnVVZjR4MkpUVjNic25kZ1FvQnFtNjRNSW1i?=
 =?utf-8?B?aWJyUlY3NFZZenZudmFqSE9vMmZJcTAzdkhoUktDbEdvN081S1lRQ0NTSW85?=
 =?utf-8?B?SVBsMHNwOFQvZmFnaE9lbzVIa3ZNeDZNcXRtS2tULzJuT1kyekVIaWhtSXJU?=
 =?utf-8?B?Ui9VeGFyV2lEb1VEWWdBRXZGL3IzMVRWWDUyWmN5Y3JRQVhhcHFoUXNSTCsy?=
 =?utf-8?B?Rnl2L0xzTkY0dUd3RUt1dEhVMStkbG1FWXYwV2w3c2VaS1ZOOElpZis1d3BK?=
 =?utf-8?B?anhOci9TbkRmQ2dUNEhyTW40VHUxbllpUmV0N3YxdmhVMjVEVlkxZDN3V05v?=
 =?utf-8?B?anRCUG1XWEhRZ0Myb1lPRUVRUWpDRElpTVJWT3JXUWl4L1Q3Umh6MnZQMTlD?=
 =?utf-8?B?VXZFUEg0K240aENXT2h3VGJodGNXTDBVczkxSDNIZGxsTyttaEp2dUFEWWNz?=
 =?utf-8?B?RWxKQURqejV2MTZYUEc4L09iRTVBcUxPSlVVNEMzdTJ6aDROWTg1eitTbzVD?=
 =?utf-8?B?aktvNkNGWWNJbmsxOFVUYWFwcC8yT2s5R1RidWYrdVkvQjVnNFFMb2x6WTZl?=
 =?utf-8?B?RTFQTkJ2R1NLRHh5TTNMSDZaQWJ6bVdQTUpBV0lkYythR09JL25aWTFmTjh1?=
 =?utf-8?B?VFk3Ti9iNlNERmpJRXlGdlFMc045ampxRkhrbUNWek5FMFNzbVRDaVpkVG5U?=
 =?utf-8?B?eWVBU0xQNDRubEwwR1FFcEVpdjIvNHMrSVlzRXE5V1hsd3VGOVAyckx2Mi9a?=
 =?utf-8?B?T21hNVZhNjQzNkltS21INlpScHlZVnUvTzM0dVJSZkN4d2crL1g1aER1cDc1?=
 =?utf-8?B?NHZveFNweXR2dk9EcFkyM2xoZ2I1QXdkSjRjejZrczBKN3ZpWjg0aTZ6N0xO?=
 =?utf-8?B?OVlLRmdUb3Mwck5FNU93cDgrTngrN1VmYmRaZ1k4MXl6N2FjVTl0K1ZZZ3N3?=
 =?utf-8?B?ekI4Qkdtd3Yvc0xUR05FTnppTUFTNVcwUUY5Q1RFcEZUNVN3Vm1tUThjaXNt?=
 =?utf-8?B?S0U4LzRDUHZ2d2VwRG5nR1VBcTdIVkYwOUdBMkZieE9DVTZpdHhJRXNndG8v?=
 =?utf-8?B?V0FQTm1RWnA2SHJ3R004Nk5lWnhvd05zbUliMHVHQ2Njd05DcjRjSWh2MWcy?=
 =?utf-8?B?RWE1RGVLeWk3dyswUFhXb2lpWnRXT0haRk9TVks3UlNRd3o1NjAxelM4WU1n?=
 =?utf-8?B?d3JTZDQyeUY4RmtYR2h6MDBQeUVIMEpIa0M3NUI0VERHUjhqcGRpRjIyL3No?=
 =?utf-8?B?TGhJNFlpbDBXY1BCM1R2enlaSmMyamtXM2FIUnRoeDExM3lKenVYS1BqdEpl?=
 =?utf-8?B?bTg3U2h5S3hSR3JnYzdqZDVGN29lTzhBMFZjNkhBWFlIaCtGREJxNWUrMGpy?=
 =?utf-8?B?WkxSVmQvenJMMU5naTNIQ2RPUC9RWVU1ZjdvVWdFS25UcVArRGpDVlJiUEhR?=
 =?utf-8?B?V2xxd3VRQU50SnpLWnVsOHVDVjF0MGswakIyM2I1LzlacDlsWU1FN0FrdmQ5?=
 =?utf-8?B?RFlIenpiY3c5MS9BU2dBdUppbXNmay9tbERLd1pMZVNPM29WM1R6T3JvWjM3?=
 =?utf-8?B?MGc2eEF4QUdreEdkVWtPYjRXMWNNN0pDdDZGZGNRSWlIcjZMa1RBcGMybi94?=
 =?utf-8?B?cGswMGpqVUFYbEhFekdkMHFUMUR1Z01sakpLWDhaTXhoZkJlREsyRnV6YklY?=
 =?utf-8?B?b21uQ0psOEpaMzZUcXp0UE5LUE5Ua3dSUHAyWDEzWGVwanZTSFJsTFhFTFVv?=
 =?utf-8?B?aklQNUUxb2Q5emtNcXQrcTN5bG9oZEUweXFJSEo1dEZZU2JKZGlnM3NqZXYx?=
 =?utf-8?B?QWFydC9hOHRGc3NwTjFPaEd0S1VBZ2RoSTlTbVFOTEM0QXpoVkJDa1RaYUo1?=
 =?utf-8?B?bzFkanVlMW1nL1ROMTloMUZ4TkZPMEtpMXk0L1QrTFcrZit6aGpUcFp1TFBC?=
 =?utf-8?B?ZFVxT1ZTVkFoMytBbjJzZ1QwbGtvNHF3ZkphQVh1TC9zYnlnUVozWVlMdmpm?=
 =?utf-8?B?c3dwMkVkNlNpVEsyR1ZlVWZrVWVHZGJmRkFDQUp5TjFIcFJaZUZrcTlJS01P?=
 =?utf-8?B?NDVpSGZSbTlmOGNUN1grN0c3LzRNalhXZHJsYjN6QzFEY2tub3hEeDhUWjhP?=
 =?utf-8?Q?Q7qzZEetCamnR+VXW3MzexEf/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/9/qcZUF6s3w8ilHuSF59QVCQ/04W4RsGVohwZqVep3/b1tArbM69bQCAjHkieKQ8G7rixYE1ofUErED+2wh0Nk0t+Gi73yQWEMtJIVZ+wulF5i9YpoBhaOxJk+qixaUTwCuktreNgpuzJj0N+WP6Za8j9ox86EkXZrd53/cgNYJRlDHhxWQ2qEYmj3LBhI79tvWhMKLR6iNkY2J20bbjGkPcIYxcoxC2VmwQIKLgBf5qRx38bYO0L9HK36WEdl/CBxYDVHltsYk4QlQEiWfJMVMpOXa8Oz9ux8kU0zwn/hxxt1QDLqh7rpEKJZ06kaYpUla8emGpen7mfi1J+NfLFDdaxKb6UH6VxEmZKybBA58N/gSzIgoUgDROisZbpXuDINklPK2PmkINx1DL15StMbsvV/0fPF1DY6OEkUacIG3kWfe4nShQCzk0ijp8W/PmsCWifJvntEzecvVtePtY3wqlGDIvjNp+eMOFrshulWqRnI07Ek0AdE6Zes8dmicARa7bL2zpSqO5Lm2oUwspkJbaTKKoieJOwdOrrhL7+7cZNOUfVBHm4YtZBPX11G4AZju+EshH7glZcdJZ4ld3qHTh8EXQmYJZ72Mkd/xmkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f752982-78e1-46db-536c-08dcdbcbe591
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:33:15.8504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNDnZBxHTltzl5AHgz8LdBpROzqCN2gcYvA1ThsYWJDLEGvzQDgSKXWsb02Z1BWnT0ZyRWaG5yfiQJPivPbyEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_05,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=919 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230092
X-Proofpoint-GUID: VyE61b_ulEyJCR5J277LeoU-NVIBQs2u
X-Proofpoint-ORIG-GUID: VyE61b_ulEyJCR5J277LeoU-NVIBQs2u

On 23/09/2024 13:07, Christoph Hellwig wrote:
> On Mon, Sep 23, 2024 at 09:16:22AM +0100, John Garry wrote:
>> Outside the block allocator changes, most changes for forcealign are just
>> refactoring the RT big alloc unit checks. So - as you have said previously
>> - this so-called madness is already there. How can the sanity be improved?
> 
> As a first step by not making it worse, and that not only means not
> spreading the rtextent stuff further,

I assume that refactoring rtextent into "big alloc unit" is spreading 
(rtextent stuff), right? If so, what other solution? CoW?

> but more importantly not introducing
> additional complexities by requiring to be able to write over the
> written/unwritten boundaries created by either rtextentsize > 1 or
> the forcealign stuff if you actually want atomic writes.

The very original solution required a single mapping and in written 
state for atomic writes. Reverting to that would save a lot of hassle in 
the kernel. It just means that the user needs to manually pre-zero.

> 
>> To me, yes, there are so many "if (RT)" checks and special cases in the
>> code, which makes a maintenance headache.
> 
> Replacing them with a different condition doesn't really make that
> any better.

I am just saying that the rtextent stuff is not nice, but it is not 
going away. I suppose a tiny perk is that "big alloc unit" checks are 
better than "if (rt)" checks, as it makes the condition slightly more 
obvious.


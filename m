Return-Path: <linux-fsdevel+bounces-75649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEw5N58leWnmvgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:52:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA139A7C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B5B302D10A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE228B40E;
	Tue, 27 Jan 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KDPpFfKA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W/LfX7uG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AE1D5CE0;
	Tue, 27 Jan 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547154; cv=fail; b=W5ltilC1lOJHqWvnft2PcoLdszTaOzQOaxRM7R2ML45g2Swo6Gfc9AzMHJJDGmibzYWQJmYSXc/hk6UPG2bWp0b0hf0P8DBGTjgKvu/9kFbuSR9yyEqAkiwDfjf1II2iPOei/N9HuJLgc41P0sFDJIHWxCT4Waz+OMfrprI3Qwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547154; c=relaxed/simple;
	bh=ZCQDuAKZswiKuSsUUA+Ufrkc5IU7NxAAO+esRHJyjac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgAjx4jDI2xjpmlA+WOdGO9a9mD+EzpNX5NwGem2J6xv0pbgmKycnrZGPqyZDRdxZdkpwpg5yNj75+GROfWdlVp0HRyYovQAX8CuizHxLgdDS693ZWwziq/0XN+JP8tP01H6rOcLU1d2qCyE9JHTTDliJucTaGBC2fnhy6xKIyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KDPpFfKA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W/LfX7uG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RJwep14172363;
	Tue, 27 Jan 2026 20:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F0+IEc8X5GXYVTIilpr0m64pz0PD/UKWA+WKMnjS3sc=; b=
	KDPpFfKA+rkG0Ru0gMg+t4ZfB6xO98MoWUmSkIAY1qC/8HRms9uLUs4nVfA/8Swx
	IcqojCPDXj3OEwJa0Xq6Wq8O9G0bQbfgnIl3uzn6fgY99Q2DKrQb2YyCiEAiaUxT
	/nByQmv/HemNZIuqs5LWe/6ru2eOzKwOP0HwM0S+NmkGZQ+tilv3ams8RVcDV8Tf
	WkpAoqBIl3LSeUf+ggSUwABifigumO2frKEhtz0iBuZcinagiSp8iatTTtY4sD76
	kIPGkisv91NdWZl6DJxBwNjaWaRkWw+9PJhoTmI+gyv8tx0WCox/GB1Z7leu0r5K
	4e3hU57rQt4pqLIwd9VJaA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by39r872h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 20:52:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RKOhaU001716;
	Tue, 27 Jan 2026 20:52:12 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmheh4nu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 20:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeCmMGXbEZVf/ZLALn3Jsibhc0ubfwc5KJRB2WGARC0NtxAWPIhhttoTHgO5Erp5rKhV0otQmu9K8G/C6d4F7lPQHtaqmQX6HtaZvrBTSOIk1XzLf8+80vlyrYzn0os2hIAtmSTGSD9rwP4p6EJDc0u7JFsgQSJSLDVuqcg+ekaeetuHkxb44bb6qPCbrVa4Hh3n3EYp2ZwOhFdZmPKRt4D6y5ghNQ+tvaNTvhwdhTxWosgoQmIW1kxJ2SVL1oHH2P4diCGJRleBGfeqtr6QYHUwlLereLzVlI89hgO2dZwvxB1giYDZB7dNptzGy0/+tCHIkx8D4TKimO2DGwIFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0+IEc8X5GXYVTIilpr0m64pz0PD/UKWA+WKMnjS3sc=;
 b=se5YYIK1zcdvUszm4tlG2r1jtzLoUvcUEE5jz96Gh49Ww2f2KiCM+LB4AqjWLjRRdh4JEi+nCCqMKZOokeb4lTlx4zh3FQTh61HLFXAx8HcKH0SskEX6rKZXkRlVhdFFTiuMa1nCCMYLBleZqnt9JSiB46/pB+gcVqzl+U2Q7oboWsQ+09q9NmH+czBB3TaZffVFblWx13sZJwDxKMPqoFaQWPsx0fuG8zNiZHEscUULykqaLExxpptsf9A/28kISZeemWBpYmv9Oc3hZvoOHpbHEaFf/r+jaHo7WclTlH06iGxGx02Ku4Mto6Svf2W9WgiCo0Zgh2DGyZ4lrnjUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0+IEc8X5GXYVTIilpr0m64pz0PD/UKWA+WKMnjS3sc=;
 b=W/LfX7uGtO6dKxP9zPoZfsKckXgHM0hmuBOOwra4uUsC2nntZFM6r6RPFtxguxa3mVIQdVWIpqIRUWKcSz+v6IhkAvq7icOURsdMFypLTYAzjuWf1zuRJpQaCtwgEFDuLQSm2sFB15hfN1Tibp7F51Domy76qNqyZTjgj2tx620=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CY8PR10MB6731.namprd10.prod.outlook.com (2603:10b6:930:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 20:52:08 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%6]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 20:52:08 +0000
Message-ID: <c034364d-1a41-4d4e-a211-16a07afe695f@oracle.com>
Date: Tue, 27 Jan 2026 12:52:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] NFSD: Enforce Timeout on Layout Recall and
 Integrate Lease Manager Fencing
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260127005013.552805-1-dai.ngo@oracle.com>
 <5d2288d77498582f78152bdb411222930a7e5978.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <5d2288d77498582f78152bdb411222930a7e5978.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CY8PR10MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 9431286c-10bc-44d3-8ec7-08de5de5ef9e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WTdZNjlLWFgrR21KODhMTG1RTE9ZZjhiWWNoZFcxUkJsQ29EekVXMXRnVEs0?=
 =?utf-8?B?bGdYdXJFWjRRcDRSd0tIWWIvN0ltODluNGpSb09zdkx6VVVOREduL2k1T2FP?=
 =?utf-8?B?WUNtOGFubVIra1BibXFjREk2aEcyMlBhQUthR2V2NUNmTklhQXRUYW9DYk9y?=
 =?utf-8?B?bU9MR1VUaEVwQUw4ZGtqZzFoazRPSkVZaFJQMVNVamZJNWxTTHNSSXZhNC9M?=
 =?utf-8?B?aElVNmVwOFhVbENqVW4zV3AxbndZTU5hSlptTjhmSDJ3T2NxZU5IbkFaeThv?=
 =?utf-8?B?dlFZOW1NZUpFNzQ4Qzl1U1YwRzI2WUY3OHRMWFRPMjBPdWhHanc4MDZSYlVE?=
 =?utf-8?B?TTJRUzNXYVU5dmRoa3ZGdERYYlFQUnBkRWN5UElKaVc1Y0RVZjh0cm1tOGJv?=
 =?utf-8?B?NG5yak5GNW5KVTdZQ0hLTGk3TG5oUjVUQ2U3RGRzSXFMNHd6ZEplcmt0VVVy?=
 =?utf-8?B?eUk1QmpGZ1lrYVkrZEg0cUJDZGZ2czQ3Zi90a0tzRE1SK3NqZWFHUFpKSHhR?=
 =?utf-8?B?VmJoMUpBeVZZQ3VkYXFtclAxeHltbFBidnQwd0JRWnI3NWJnYWMrT05ibjNV?=
 =?utf-8?B?WUpXcjJoSUFIUkt3Z29QSUQ1Z3JBWmxGaWNXekZyUjZoYjFvUnJRa0ZIUHRX?=
 =?utf-8?B?R2twTk5YWENVTVROMUc3NEU4SG5WYzhVQTlheEUrQmYxZVI3WXR5OU5sbXlJ?=
 =?utf-8?B?MERXbkx5OXBKK2hNRzVMY0loa2VhSDMxVWdJZ05NeHViVDhnb0VLS3JYdzhs?=
 =?utf-8?B?bVFIRjJkYTlYOHZlaUZmQjhnVFc1QnFvUEpHZi9zUENuRnk1Y0Nlemo4aEJC?=
 =?utf-8?B?Q05UWTM4UTdlNlhTb3dJd0dxcjRjVUI4T0VKS3N1a1lMTXdQRzFxR0Y5TmNT?=
 =?utf-8?B?RmpIVnhTM2hWQjJhMnlUcDliTDNqMldmQkoyQ2tKMmgwUnJmS243bTJXQjNw?=
 =?utf-8?B?ZHo2Zjl4ZllDODF1V2c5a1YzMmtxWHJwd0dRNGhhYlUxa2pZSitpOGdzbmtF?=
 =?utf-8?B?OXcwLzBGemt3TzlMaUdPcGlScEd6SWUzTGxSUHAyaXFmb0wvVE5MQ05Lc1Q4?=
 =?utf-8?B?NnBiTVBJcVJlTFBIZDZZbVI0VVZ6bHl1K0ZzbFdMdXVwcFNwcUlGaWE5QWtD?=
 =?utf-8?B?SXl0dEk3eUxCOFdTS2p1NFlVMUlsdjhXWDkzWHlLUGtSUjhUK3l1VTc5dSto?=
 =?utf-8?B?a2ZmQmVJVldIa1lMcWFZaUJZVGZaK0JENUVMaDBZdDFhMjhiclV2dG1LanV6?=
 =?utf-8?B?NG45bkc0Mi9FMEkvaC9DcVp3dkpOaGhoU1JnZ05EY3NQQ3hwbzdISUJFeTdr?=
 =?utf-8?B?MHd4ZGhZZS9NckQvMnFVeC9jSWlFbk1xeVZEWWRHMVJkYXlaNXVNNEVMaFFM?=
 =?utf-8?B?VVljWTc2WFhxNTFtOVhmUjBYOWQ1QmFIVXFlTHRuM3NNemZQaHhlTk0zQ1pZ?=
 =?utf-8?B?ZTZOb1lOaVpVR0o1UmZEYVVHRWdTdnQwV3lnMHpneXF5clJEN0ZEQUlwaGNP?=
 =?utf-8?B?SmhyaHYzclI0bVNMTTlhQ2xvNTdDOUtabktvZGpUZFlQS1FuVUFnNUVpcVZl?=
 =?utf-8?B?ZkxWVitMaCtjZWF6NUg2NDJIWnV0d3oycno2eEN1eUNQWTRtRzlhQ3poTVU5?=
 =?utf-8?B?eHFzaGVqY05IMXlWN2pCUU1hSGJqTUFBL2hRK05jd3d5WVZwa1E3WTRFRWdt?=
 =?utf-8?B?QWlCWUJFcHo1YjE0N0RhaGVTTTJSbzJVdHN1Wlp3aVNTOThBaFdodktmbExP?=
 =?utf-8?B?OVlML0Z5am5JVkZqNGpGWm5vSXFSVmZteUNORE5TMGx3TXYvK3hUVnhGZ1FT?=
 =?utf-8?B?SzhPY3FMWHk3V3Ztd1BTRHExUGNnS2FYS21MS1dST3o1dFJuekRuSHBPbmpV?=
 =?utf-8?B?UGxyM2RqSWM0SjNiT05YRGFVRndwZHF0MXZ2VDhiZGFyT2t6UW90RFgxY0FB?=
 =?utf-8?B?Zythb0hoZ2JhTGd3ejJFcGt6ZGtNQ0Y4Z3VPYkcwWVRRTEl6SnlsejQyMUlI?=
 =?utf-8?B?dEpJaEkrS25OOWpBT3lZTnlrbFdPVXVlbi9zVkg2Z2ZqNCtad1lxUlZ5bEVz?=
 =?utf-8?B?amt1Q1kzajBSMjI1ekc1NWxIRnFQTi9hbUtlMW92YnZDd01hQ0QyYUx6bGFl?=
 =?utf-8?B?Nk9CV0doOGliTG1EaXFkWVN5TzVDMG92R1pVOEhQdWlVS0taSFBQdTJDdWFL?=
 =?utf-8?B?ckE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NXNwa08yczZaNlZZTDB1aUJEUFZLOXdXeld3WnhBa1RCZ0l4eFZkbWE0cGhO?=
 =?utf-8?B?UVlYNm5ERkhJWDNscmIvOTBZdmdQL2pDVkFzbHYwK0lYQXNkZzliQkJWektL?=
 =?utf-8?B?UWY3S2JPbGloU08vSExUeFJtRG1qcmEvTlNkbVEvQzNLVms2b2MyTXRBdnc5?=
 =?utf-8?B?eVAyeXl1eVdWQkRDZEFPTHRGSXZNdmk2RHFhTkxvemw2cmR1T01zdnlDaldU?=
 =?utf-8?B?eE9kejJuM05SN3JieEErT3pFWE83Uy94ei9YcmRLMjgxczBwYzI1dXEwVDQw?=
 =?utf-8?B?MSs0NFBOV2EzemJGWWp0em42RUdpOERIV0N1em9ENDBibnBjL05EMEVWeGlD?=
 =?utf-8?B?djBlb2NkdUgvaWtkZHhuU3RYV2RJY21rbFJrNUlTWHVFRjlQTXREVnpVNFM5?=
 =?utf-8?B?QmhHRDJ6UHlWNnJJMHl3U21YVkVJYmNNZE9TM3VUMFRmWTBvM29zY1R4bUdP?=
 =?utf-8?B?a0xUUnJiYm9jbnRaYTA5MkJxUFVLUkVZemtxL0hyMXRlZmszS1E0cmU2eFY2?=
 =?utf-8?B?eUM1WlIzUFF6VUlqRGlLTVVsL2lVZjEyaExVTXdyTEFkWUhNbUo0Q0syd2JJ?=
 =?utf-8?B?eE5nWjV3NEVtN0lsNXBnUkNhQXA5TzNyc0tNbW5pL3dhK01pc2t4VjhrMDhy?=
 =?utf-8?B?bGdJRjVucWNhTGdHVFVmdHR6cUxSaHlSSEZwdml4d1piUkdDWGpTTnpSY2JS?=
 =?utf-8?B?aFJhRXFMV2VtN0cyR3ZuV2ZmdE12Q2JFM0U4QVRZc052WWpka01CZkpOWFBX?=
 =?utf-8?B?TytXTHdiYnJWdWR0VHNYOUpKMjl5cnhTQlJxMFpaWnQ3U245MlpoRTQzNTZW?=
 =?utf-8?B?akR3dDJmd0JsLzgzaUtkYjdmK1d2NzJ5a0tpOUJIRVV2QlpzY1hRUzE0SzNF?=
 =?utf-8?B?VEdCNG81QzlNSElJNXh0d0FrSFJyTmIraW0wZTc4bkp0WGJKZ1NhSjVteFRu?=
 =?utf-8?B?NEJ0REhHdXYxeW1wQ210WExwcWN0NGFQK2tIMFZQaEJNc0YzeUMrTE51aEhk?=
 =?utf-8?B?Nm5oYnVsanBIUXdNM3Erd1gvQStzcEJjRjdEL3NZMG9HQnk0OXcxb1RKS0RZ?=
 =?utf-8?B?ZEpYY3ZBYlkwUzVOcVhJNm9vQytJRCtRSmV0eTFKZkVzNHhxZzUxVVNhVHMy?=
 =?utf-8?B?TTVSR3ROTmxqVG5nWVI4S1JLTWhqSWtBRVYxWUN0RGorYjZHLzNZbks2STBC?=
 =?utf-8?B?aWhhQkRPdEVucDM2Ni9lcEJ4YlRyQVUwdmJzMi9MUFRIb0t1YThvY21mTzl6?=
 =?utf-8?B?NmpPOXBlNHdIN3dxM3YyY2NPenBDVTNNNkF1NzBvZk1WekMvTlNXS0tEMlkv?=
 =?utf-8?B?dU5aSlg3STFwWUVSbFFkNk4xTnJJOEZGblA3SlhQV1JDZE93UUg3OUQxc2Qr?=
 =?utf-8?B?OFVFTm9UZkRRNXFZR2R1THAwcktWN01EM0NLeW94R215Umx6U2hCdkFTejVs?=
 =?utf-8?B?b0xDRDlOZzhWVXJ5bjR5WnE2UU9aNmx5SDdRM3pjMlJQTFpoaG5SUTQxNzFQ?=
 =?utf-8?B?RXlySk0yQXRqaFMreU56VXdxc05pK2ZqMzBxRVBwMDlCalpXTER2Kys2NFg0?=
 =?utf-8?B?TTB5Syt2bHpQaVpDUVZ3ZkVNSHFQa1p6dG9YOHRlMjRic2VsYkNqQXZETWt5?=
 =?utf-8?B?Z3N3SVIzUzdFeGZDckRqaGoyN0Z6bDdJUFY0MjNZRHNlcEh2bW9BODNlMGt3?=
 =?utf-8?B?SnRmRU5nYUwxVWppQWxRMTV3ZWU4bEgxOUUrMTU1WDlEUUFvWjg3bXJyRE1T?=
 =?utf-8?B?akM5QWhBMWxxQkFDZzNGS1A1eEdDZTBFczIyUS83dk5saFdVWHlOcjhBK1lI?=
 =?utf-8?B?L2MwSXhLRTc0YUJweEE3RXRvME5WRFhGcU40ZWYyZmFrOTRDWUhYclBxL25N?=
 =?utf-8?B?WGFPQVU0aGhua2VxK002T1RNWmJKeUVveFZnblFjdUVZSEFodkdrOXhXRndz?=
 =?utf-8?B?UWRJbHdvbjU0a3VrMWZkbmppTVFpS09Zd3N2T2lPNjFrU3JSaldaNks1NUpG?=
 =?utf-8?B?SnQra01aQ2lUVnhKdXVHSm0zeFAybUpBcmxDUjVQV29yT2tTenRSZXU3NjR5?=
 =?utf-8?B?UzF6ZTZ5bFFwOHU5NEc0cWlCbFNBVy9Xd1BkQVBnaWVqWHRBTG1uUlpybXlJ?=
 =?utf-8?B?M2RqcTVsd09JRTMyN1h6N29nczBDT1dyM2hLdEIrS2tZU3ltaDM0WHg2T0dI?=
 =?utf-8?B?N2JrVk0rWkNqdm0wdTFjeWFhZDNSbldObjhoblpUOEprUFk4V1lwWk5ta09B?=
 =?utf-8?B?cVVMbmNEYUZmMXVSeTllTVRKQW5UV2ZIU3pVVWV6YjRGZzVIT2hlaGtlVk5Y?=
 =?utf-8?B?cjF4N0w0RWQwdUNIcU9PV2dIcXJ0YzZFV1pUSUcvVktzV2V4T3VXQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zP0214UddPXgEs2AALz1kP6rdKNh01YvbFIy44LtcJRBDZiiMGhFTRzy7/hnB6g5fcKq2qrB1MPhAqYkkofnbQorFb32Bsy0eGVlMFQOi78F9Cw+u6a09DvTMdwJj6HQT5XArqUprLOsIDAU2qHlPhbNxA38mCPairjebaOekNxgOCk/UBAevQECWXH8VUKpstfRyjEAoid51Cnd1nSfo18tp2v69LJfq6SjSHOVy7Gb/CoQLT8nl1t7om5+BvSD+W3nNoRrm+Ip18/vPw7XPCzxAZInI3V4wcbwmjvaDHBIf+0AZBZIvVHNBY+c9TVGuGub1Lz3jFcDyNH9N+bgRzftK5BYkbiC6xyGdrneZH1Q/HkPT+M2JeQwUP8pZZha1rHS/Y7ZLgIlVsA9LYRLDhYakreQI+73o0JmdE+AT622yQfFK8AtsVsbtLPbHFQ3MIcfYN3Gbl3K3CVeOEPpvm/4B4pyQ8Oi8cGiigX7Cbon0V+rE2CIg1dnHlwMQ6R16RTAOUMkP2FMRt4yL//GhD2mc51yTlgqf2Ziw/5wZYDS096YiGcZ0sLvMMft6jOUI2UQbzzYtMfUScNH3xQi5UWnRjUOjChQWS7gm+MvDoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9431286c-10bc-44d3-8ec7-08de5de5ef9e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 20:52:08.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzNrWABk/sYxO8c0Nd97bZ/rWkpJlMwf3AItuTbJ9Tl2w9QyU7Sk7Lnf/hyB4fbbTou6LP8nkEYpAPdDKa5nUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270169
X-Authority-Analysis: v=2.4 cv=LaoxKzfi c=1 sm=1 tr=0 ts=6979257d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=tAIU39baYqGFQjD6YGEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13644
X-Proofpoint-GUID: 5_StLutnSREBNH6tWEFQtBQ_S5kRLq93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3MCBTYWx0ZWRfX6KdRbQI5sfOP
 jTCJnQ6gd2tGP5OtI8vqN1S3uDjljqCplQkdsNkImlyof+Zv1lQBh/Ph6hpsLGBNfsBch6gZW9t
 fnfz0SoV9GuYfedHJFWEooRLsKwHG26ZfnqJfu0F7crImFjYXA7aadQBbm4Hcq+EABInSy82F9n
 ZKTUKM1u/21wEsyyAMYKHEFiBoQnpBYjS4MbaAlWhaVkrFxBWc0D8Pi4YZ/wXnp1ZWvPosHt+Rg
 DfSP6U4rBX5Qq4aknq8DNBVlZU1G84SbGxks00cBmSIkx9oDMGV/xJ9fi0k8jzq4i0AAdmBVKaT
 y9rMqhwrEtPDrWfVefSCOXJw5fYG3T/5ZOOEwBP4JXVq51bgTuKttlyAcYPO1DdYhcrfWGlJ/8N
 EphVMoh2W7cjcMypU08sCERR/wvUA+yE5GfnFnNIe2dnON/IU465TfwJcP7n1XCkR68ecQpOM+i
 25AqF43cBr/dYxK7d/GWEMwMA7i/kPdDRG2ErAYs=
X-Proofpoint-ORIG-GUID: 5_StLutnSREBNH6tWEFQtBQ_S5kRLq93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75649-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3FA139A7C4
X-Rspamd-Action: no action


On 1/27/26 9:54 AM, Jeff Layton wrote:
> On Mon, 2026-01-26 at 16:50 -0800, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with
>> exclusive access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  2 +
>>   fs/locks.c                            | 10 +++-
>>   fs/nfsd/blocklayout.c                 | 38 ++++++-------
>>   fs/nfsd/nfs4layouts.c                 | 79 +++++++++++++++++++++++++--
>>   fs/nfsd/nfs4state.c                   |  1 +
>>   fs/nfsd/state.h                       |  6 ++
>>   include/linux/filelock.h              |  1 +
>>   7 files changed, 110 insertions(+), 27 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>> v3:
>>      . correct locking requirement in locking.rst.
>>      . add max retry count to fencing operation.
>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>      . remove lease_want_dispose.
>>      . move lm_breaker_timedout call to time_out_leases.
>> v4:
>>      . only increment ls_fence_retry_cnt after successfully
>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..a339491f02e4 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>   
>>   locking rules:
>>   
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     yes             no                      no
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..1b63aa704598 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove = true;
>>   
>>   	lockdep_assert_held(&ctx->flc_lock);
>>   
>> @@ -1531,8 +1532,13 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> -			lease_modify(fl, F_UNLCK, dispose);
>> +
>> +		if (past_time(fl->fl_break_time)) {
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
> I'd not bother with the return code to lm_breaker_timedout.
>
> Make it void return and have it call lease_modify itself before
> returning in the cases where you have it returning true. If the
> operation isn't defined then just do the lease_modify here like we
> always have.

Ok, I will try this approach.

>
>> +		}
>>   	}
>>   }
>>   
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..69d3889df302 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,6 +443,14 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>   
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + */
>>   static void
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>> @@ -450,31 +458,23 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>>   
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		ls->ls_fenced = true;
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		nfs4_put_stid(&ls->ls_stid);
>>   		return;
>> +	}
>>   
> I don't understand what this new mutex is protecting,

The purpose of this mutex is to ensure that once this function returns,
either the client was fenced or not fence and not fencing in progress
(some one is in the process of doing it).

>   and this all
> seems overly complex. If feels kind of like you want nfsd to be driving
> the fencing retries, but I don't think we really do. Here's what I'd
> do.
>
> I'd just make ->fence_client a bool or int return, and have it indicate
> whether the client was successfully fenced or not. If it was
> successfully fenced, then have the caller call lease_modify() to remove
> the lease. If it wasn't successfully fenced, have the caller (the
> workqueue job) requeue itself if you want to retry. If the caller is
> ready to give up, then call lease_modify() on it and remove it (and
> probably throw a pr_warn()).

Ok, I will try this approach: have the fence worker doing the retry
instead of nfsd so that the fence worker is only scheduled once to
do the fencing.

>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>>   			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
>> -	/*
>> -	 * Reset to allow retry only when the command could not have
>> -	 * reached the device. Negative status means a local error
>> -	 * (e.g., -ENOMEM) prevented the command from being sent.
>> -	 * PR_STS_PATH_FAILED, PR_STS_PATH_FAST_FAILED, and
>> -	 * PR_STS_RETRY_PATH_FAILURE indicate transport path failures
>> -	 * before device delivery.
>> -	 *
>> -	 * For all other errors, the command may have reached the device
>> -	 * and the preempt may have succeeded. Avoid resetting, since
>> -	 * retrying a successful preempt returns PR_STS_IOERR or
>> -	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>> -	 * retry loop.
>> -	 */
>> -	if (status < 0 ||
>> -	    status == PR_STS_PATH_FAILED ||
>> -	    status == PR_STS_PATH_FAST_FAILED ||
>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>> +	if (status)
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +	else
>> +		ls->ls_fenced = true;
>> +	mutex_unlock(&clp->cl_fence_mutex);
>> +	nfs4_put_stid(&ls->ls_stid);
>>   
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>>   }
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..1c498f3cd059 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -222,6 +222,29 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
>>   	return 0;
>>   }
>>   
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct nfsd_file *nf;
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	u32 type;
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf) {
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +
>> +	type = ls->ls_layout_type;
>> +	if (nfsd4_layout_ops[type]->fence_client)
>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
> If you make fence_client an int/bool return, then you could just
> requeue this job to try it again.

Yes.

>
>> +	nfsd_file_put(nf);
>> +}
>> +
>>   static struct nfs4_layout_stateid *
>>   nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   		struct nfs4_stid *parent, u32 layout_type)
>> @@ -271,6 +294,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>   
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +	ls->ls_fenced = false;
>> +	ls->ls_fence_retry_cnt = 0;
>> +
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -708,9 +735,10 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
>>   		rcu_read_unlock();
>>   		if (fl) {
>>   			ops = nfsd4_layout_ops[ls->ls_layout_type];
>> -			if (ops->fence_client)
>> +			if (ops->fence_client) {
>> +				refcount_inc(&ls->ls_stid.sc_count);
>>   				ops->fence_client(ls, fl);
>> -			else
>> +			} else
>>   				nfsd4_cb_layout_fail(ls, fl);
>>   			nfsd_file_put(fl);
>>   		}
>> @@ -747,11 +775,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
>> @@ -782,10 +808,51 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * @fl: file to check
>> + *
>> + * Return true if the file lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +	bool ret;
>> +
>> +	if (!nfsd4_layout_ops[ls->ls_layout_type]->fence_client)
>> +		return true;
>> +	if (ls->ls_fenced || ls->ls_fence_retry_cnt >= LO_MAX_FENCE_RETRY)
>> +		return true;
>> +
>> +	if (work_busy(&ls->ls_fence_work.work))
>> +		return false;
>> +	/* Schedule work to do the fence operation */
>> +	ret = mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	if (!ret) {
>> +		/*
>> +		 * If there is no pending work, mod_delayed_work queues
>> +		 * new task. While fencing is in progress, a reference
>> +		 * count is added to the layout stateid to ensure its
>> +		 * validity. This reference count is released once fencing
>> +		 * has been completed.
>> +		 */
>> +		refcount_inc(&ls->ls_stid.sc_count);
>> +		++ls->ls_fence_retry_cnt;
>> +		return true;
> The cases where the fencing didn't work after too many retries, or the
> job couldn't be queued should probably get a pr_warn or something. The
> admin needs to know that data corruption is possible and that they
> might need to nuke the client manually.

Yes, will do.

Thanks,
-Dai

>
>> +	}
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>   
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 583c13b5aaf3..a57fa3318362 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2385,6 +2385,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..57e54dfb406c 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>   
>> @@ -738,8 +739,13 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +	struct delayed_work		ls_fence_work;
>> +	bool				ls_fenced;
>> +	int				ls_fence_retry_cnt;
>>   };
>>   
>> +#define	LO_MAX_FENCE_RETRY		5
>> +
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>>   {
>>   	return container_of(s, struct nfs4_layout_stateid, ls_stid);
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..13b9c9f04589 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>   
>>   struct lock_manager {


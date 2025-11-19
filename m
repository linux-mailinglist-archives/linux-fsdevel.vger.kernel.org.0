Return-Path: <linux-fsdevel+bounces-69122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52CC70498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 139B54FF356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D8C341077;
	Wed, 19 Nov 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PU1ZP+WD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jKo9eDhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D60327C12;
	Wed, 19 Nov 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570154; cv=fail; b=eYJF5zlomyMJyeypViU2xl8IbM3I13rscVDkFjr5NLXdrYM0lBwBzEZDs/i0q0wzAmyewvTjrBmyRIFe+cu7J0cki95KoGufQBo15sjV/5yURJAEr+1vlL32Nqs6Ksvni2pgxjcyhob4t1P1RSXR7m5zcAQiM9ydfsiSbNv9zyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570154; c=relaxed/simple;
	bh=cQOnbHLBOX3H+CmAmP7aEcLGalqU7e+kKYyc4iQ3/zU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XYcrD7obeEWZPKg7wFbX1d6Yy7fmVix33kxiL7n1HfhVkKUHPyeSsZJp28tUKFyQqwbDKYx0HrQ2Z/L6J8JqELjwq1Z8SRdjAUZuMQsG6DPQzGfcN/uyXx/7MWi0JkmuRczPNixcljNtz106ysENBLh88vCjBXoCJrvf0EdH1yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PU1ZP+WD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jKo9eDhz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJEftMI001653;
	Wed, 19 Nov 2025 16:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c8Y7r1yyIg8GgPuQBNKkfAOskV3VKvUlJyXvT51IYJc=; b=
	PU1ZP+WDrVcmi8Kj/PvMbDm/H6xsuLkT5R1p/fok1LBbOhAWyMXT+1fE2BpEZ9P3
	JQ+8GjqdY+QVBBd/r8fzd01ScXvIJhPWA0b+MTpdurfHuS5tnIV6GProHeIv4dGo
	D5qOmFauQWyfujwMaAFwJuIBA1/gDEe0Q62zEE9iAQTACnPZ0bdOfBwnVHjL4ykW
	NHUHVRnGrABxk+VIYLEhscoxx924E/NpZ2ignCimirdwEp+/zyFHOGIZqKI5R3xA
	Eq/mzGP6+kg81t5gnM/9/uT73ixei4ofgB9wq7cRprxQSp2mqGFdSpIf0hBGG4QU
	I39DcZkVAKP+CLI3ztCGiA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbuq9n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:35:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJG3jJ5002613;
	Wed, 19 Nov 2025 16:35:14 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyatywq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:35:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SufFyyOzbw4qgr/oazygGsc9wV2o9pNvyzwXjCiq8fT6fO3VxisIGUy87xK0+13MxggxjAjx/52pJna/NCoZrYPb/UeadjvRAd3C5xrHyhzucHwZWYVi0tIfzRGDzf+H03ldd57gwcuDfi3EDt8dCe9BG/2/7Vv/DDRjTTv8O+DQr64EPcAupFWl0RxoNWzNnJy/22MVmRtFFNYud+qDbJTkcDV3SrfGw8t+tB868bqjkAcjw5JlG19piQnBLK5vaFf00EfdP6pgzZPipH+tGNmGkDK3Z9DeBELr+7CaajZRdTxnT3azA7YuahKTudE2KoThmpqsRv3QzORXBN8bSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8Y7r1yyIg8GgPuQBNKkfAOskV3VKvUlJyXvT51IYJc=;
 b=CdzXhCcTB58xycZxjQ1aYsNREyAQFru3NaPflgDuyrci/8PaDF82fBzxzcPelJT43e77wzASgWp2qmWi6b4mcbieXXOzltTw1yphyraqK4Bd6L9qg6286ZB16RhV6CcRs++eWIWcY7NP+jrkcy8XuT/nNASkSc674Q7BMZDd8VGODhVTbS9d8vcA5SLPecUbhOJX++fHd9A/cSHFUU0eR17aTP5EsYpTVq7oGEZY+LBC6YIBnORydxIx+L2R0am3QfG6CUyNDZACIJPrtdzqeu5k58dox6mNCXiX/LSd3xFHSouUSX9b8Q8BpSMk/qlYK+DXuHBhV0/gyroT8wg4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8Y7r1yyIg8GgPuQBNKkfAOskV3VKvUlJyXvT51IYJc=;
 b=jKo9eDhzYQ58al7fKK3nshRQR5c87aVpoA1XJPSHjOo6IDJxs9ICiAhRgI0868og0DWPDUFZTuqokyo+Q+2kVFBB/vhnK6HTrNXa2EQUBnOxLy6xKY70pqVXeHwkEngkqHvef61NCjmlhsjaiOwqfYKRyMrQrWnnMjsnTm9VexY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH3PR10MB6881.namprd10.prod.outlook.com (2603:10b6:610:14d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:35:10 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:35:09 +0000
Message-ID: <d923bca3-3d7a-4839-a59f-c0aa426c4fba@oracle.com>
Date: Wed, 19 Nov 2025 08:35:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, jlayton@kernel.org,
        neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <967cc3ea-a764-4acf-b438-94a605611d86@oracle.com>
 <e43b83f1-cc9f-41b6-b659-bb6cf82f7345@oracle.com>
 <20251119095654.GC25764@lst.de>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <20251119095654.GC25764@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH3PR10MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c61e7b-b024-44a5-07fa-08de27899afc
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?T28rTWdMd0crOVFNbHpxa2RuR08yNFBnclJXUnhHVTVmdzZIOEkxejNzVGtt?=
 =?utf-8?B?WGZ1V0kvcUthT3c4ZVpTdkxVMXdsSVdUVHRrK21vWlY4Z2Ria05GOU9xODdM?=
 =?utf-8?B?QzJCMkZYK0dxYWIxZmJETzFwQUE0Si9rYVo5b3VKVnJIanpLZHJDR2ZNd0pR?=
 =?utf-8?B?OU9xbE9LZnFVelhnOHc0L1pVblhPV2dJU0dXWStoUmlzbVhmUHdjdkphd2ha?=
 =?utf-8?B?aks1dkp4bVk4QjdQQllrRkZQOW84RVplZGVqUSsrSE9ETlgzVW5UOGx5SWZP?=
 =?utf-8?B?OVlFd0xhamgrbmtqUmJVQTBWVHFiaVpGTWJScWswcTR4SlVHMnlYYklWVzlm?=
 =?utf-8?B?aitPM2ZaMVpGZkNFMlRpa2s4WE9wcUFleGNWZFBtY203TjV1TVdabFNCYU1h?=
 =?utf-8?B?WU5ZUFJUWTQxdldnMHJEQVJzMVJlejJrNysrTHNCbklnOCtXS2xGaE4wd3A0?=
 =?utf-8?B?cWFVNkl6R1ZManhNRnB2NjJQTEo0bWcvTVBBUEF1WTdBYzROcUlTWnBnN1Fh?=
 =?utf-8?B?ZDZrbjdxZHVKM1ZUb2w0R2J0eU95MHVYNVJuVTFKYkN5NjBVSkxUM0NqZXdO?=
 =?utf-8?B?TGpuQ21BSjM0T2Njem9kaVJHNFFKZnl4MitCS0x6Yi9XeVloamdXVUxkTC90?=
 =?utf-8?B?YW5ubEJkekhJVEU5NTN4WmYydHl1WnNQSUdWVGg0T081YWRFRjAxQ3ZSNTVq?=
 =?utf-8?B?NjBqaWZra29YTENSd05Bdnc4NjhKbCszS25mMnNOSng2V3JjRXYyUUhXNXJD?=
 =?utf-8?B?WFJnZXcxbHlCa052WlhZWll2cHA4V0xkU0hWbUQxc3VPQUhpQVZMWnJzQTBl?=
 =?utf-8?B?T1NSbU1YOXg5VVU4MEQraUtvcXgwWkVVYyt6MUtDSGJnQmhGWEI3ODdwZ1lY?=
 =?utf-8?B?cjYvaEhzazlTN3E5ZC82cWtxeENnS2tuZWxCbkl2TGdWZFJlczJqOEJseUMx?=
 =?utf-8?B?SGhBLzM5aHNHYnhIMjFHemU2Y210RDNDUnp3bUx3aStvYWFXK2pZOWRDaU1N?=
 =?utf-8?B?aTZaZGFyUUJyQ2J4ajlFb0VjMzJpMFN2K08vY2FoeFJkU2RTZ2kzYlpPNWs4?=
 =?utf-8?B?Q2QvNlhPenlYVHd0NE9HTDh6MXIyZ0EyZHBCeDFQMWxFVlgyaHU4cEdTTjV5?=
 =?utf-8?B?d3FUZkY3cUJhM0xpWSt5ZjgwYTNRRUIyZTJkakM3VVIzVDk1WFp5NFpVYkVS?=
 =?utf-8?B?MDRGRGhpV0pIbU5IWVJuc2MxQm14bEhseWUzbmdWLzFLSS96dUlhOXpiUGY2?=
 =?utf-8?B?TnhqSUZNd0doUnBrQlZWOCtrM0VDQlo4OWFrcDF6Y1huL3BoODFwQzd5Z2U5?=
 =?utf-8?B?L2ZuL1l0VWZCUXdyVjQxZFcwS2hTSVpKT1A5c2E2aWc4QktWTGM3aG85YXdi?=
 =?utf-8?B?OUFvaUpRVWtZU08za2lXYXZQVzZ6NWFqUWZzVlViQW1XNDhPaUR5bmRGRG1S?=
 =?utf-8?B?NjhySWlDc0ErbmNvQmlqVUl4c1V3eW5wNitQblBCMElJcTNtblJOdExYSUow?=
 =?utf-8?B?OVVTT0lDUFF0VTlNZlBPWlRWdVYvN3hueitkWXdBTHZDRzdOQ3VLMUtRMmdX?=
 =?utf-8?B?Z01PV2hKTU9Xa3J0NnZmTHg1SXpiOXIvYlVvMlZ6VjZZcG5zaUVyZVc2Njk4?=
 =?utf-8?B?d0NkZUEwRDFiNVpwWGRYOUlNdHJKanNTSCt2UElONVEwb0JBT2orcjJhL2lP?=
 =?utf-8?B?b3o5YldrMTg4aXFlRFNSamN1eFBUbjU1WlV2RHhCcVp5cnNwSzZ0K29vZS8v?=
 =?utf-8?B?NW5FcnhwQnF3d0UzZ29mWFF4SG1NNEo4RzhkNEU0a0VpUGl3UU9mWW80S2Ns?=
 =?utf-8?B?S05pc0U0b3NjZ01rMDl2akhIcFdxODRLZFZkS05QL0xvY0Q0UEc0V1lJcWRy?=
 =?utf-8?B?dGRlNmV4VmRVam93WC9ZeTRPVEdvVDBiNXA0UVJYOVNnYXBDaE4vQlBtdk52?=
 =?utf-8?Q?rFwPo3raVzDWMNEXGSobXyjcJiASxC4K?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZUN4REUyMU45VGYrSWJSenVFWldSTkV6aWF0eVNpVWpVdndpUlNzc1JDOEVZ?=
 =?utf-8?B?M1lZR1BrVllKYk9jMGVFWVdwR09xaVBXUTZZOUU0RFZtYmlvU2pXQTRjc0xh?=
 =?utf-8?B?RXhKZWxNM1MrTStQN3RRU1FkaXR5RHVFZmxscFpSUUdlM254S2ltSWEvTk1o?=
 =?utf-8?B?b29CNDhhdzFUUWZMY0dNWEN3VlU2clI3SjZMNDdvVjU5clVkZWNOMHdwSjVv?=
 =?utf-8?B?R3pNWXV6RU1ncUJTeU90YWFNZ2NNd0FHc3FEYmpPNTdjQ25kTUtzeWQ5amNu?=
 =?utf-8?B?MkZSOWtJWm4xdVB4dEtRUXFBTTR3WUlFaloxV0J5T1dWNWIzUXBuMWJBV3d1?=
 =?utf-8?B?K29meXpSYzRYZnFud1ZkaDNsSy90aWhnS25neWtGQWtmcjFoNXdMZTJkaWxT?=
 =?utf-8?B?MVpibTRSeE8vMEJobVF6d21RR01XMkc3Vm1iSkxNTVFUbVJyK3ZoS09sSVF4?=
 =?utf-8?B?TDZWZ2tZcTNFL2FuMG9jVE5GTUF6akwzV1FjWFJiSStjM3pYSm1ZWllkdVhM?=
 =?utf-8?B?WC9UUDFtenJERWZxRGlXMmxMck5XWk9UM2pCVmh4RFdSTE9wRUR2NGUxWS8y?=
 =?utf-8?B?TmVRdm1tSUloZ3ppTUJoSEhyaFhKQjJlemRIbjd1c09WbnlRRHBFMTdZd3N4?=
 =?utf-8?B?UHhnUFduM3pBTnY2SDZ5c0J2d1dsU2NFL2pRVlpxeWlmOGlDdXVnWVZGMERq?=
 =?utf-8?B?WWxLQ3F2aUJpb3FmVXZ5Sk5XczhOajk2RGVmK0tMd2M2bGxxWFJwUXU2czRK?=
 =?utf-8?B?dUhUMnc4SksxVUxNZ1ZyWlJheGljdmNyOGRVOEVzajg0STNZTURJYWhLU3FB?=
 =?utf-8?B?alZtTWRCazhiUjNkTTJsT1JDN0REMmtmRGdGKzJ3ZE9GMFdYU1lLdC93TGht?=
 =?utf-8?B?STNHdGZqRHUrTWFNREpmREZXYXZ2L2wvVnpRb0crMlRnOTJnamJXaDNhWGpB?=
 =?utf-8?B?Smh0N3JtNjNiZ2w2TnVNeUxxcjE3UThFM0tJazBlYlhwZVZXSGYzSjMyOWU2?=
 =?utf-8?B?cm5yTUtiK2U2b3hsQ0JHTnl4aWFKS1JPc0ZDTG53cDBMd0FMRzhNWUxSenF4?=
 =?utf-8?B?aEFzVzRiVnBSTEpNc2FjcHk2OFczd3hRaUFZUnNqS2Yyd1dycmNTOGxMbEpm?=
 =?utf-8?B?cXJTNldqMjZPdThQcE1laWh0M0x2bUhOUkxlQkNNSlFqUHNZc0tvS29LSmg1?=
 =?utf-8?B?eldTRTFrY0JnOE5FcEwwaElvNmhiY3ZMT1dqRHc5eFJybHVWWTRmalFnNVJs?=
 =?utf-8?B?SFBlQU1uVkVJWlFWMjQzbC9FMHI2RzhYM3pkVmRseFoxTVpiNlkyQjhadkhI?=
 =?utf-8?B?eTFnQSs4aGU0aEg3d2J4b0dFb3ROaTEvakVabXRqd291TXpiMmdrYTByenBV?=
 =?utf-8?B?Mnh4SCtGdlNJRDBjS1U2Z2JKN0VuWXZqVDBrdVJVM1U0YWpzeFhJOTNMaVdl?=
 =?utf-8?B?cEJTN1JkWGQxdFBYTHl2UVcvY3c4RGlHL2ZzYUlIUXVNVmc5c3Q2aW5qYngz?=
 =?utf-8?B?a0o5VWQ1OHB0WlAxeVNvQ2Jnd3lJWmFMRGwwNWg1SStmOHpJNm5vU0RoUGNz?=
 =?utf-8?B?bmJMNEZMWXlmejdVOWRJek5GZVdFS2RwMjFiTDVFajNjemVtZU1YYW54ZkRh?=
 =?utf-8?B?VlN6K2hVUVNOQXNBUWRVUkh4WnBQMlV4dTMzNFhyMjNZMzFXMHdpMTI2dkxp?=
 =?utf-8?B?Q0tFMUh5OGkrR0htVGZzRzZPdkVNK04vQlppNFIydmZoOU0xajZrbzNBcUdH?=
 =?utf-8?B?QVo3YzFZWi9TWGNLMzZEeDFlT3pyUDExcDR4VjZ3RzBHSUNUOWFIclU3OS9I?=
 =?utf-8?B?U3JJVnJhbHcrK2Z5bitseG9kWkJHdFdzalgySmRyYzZPN2w2VG5Kb2NZbEV3?=
 =?utf-8?B?eGtLNFJpMXNuNk9RQTBFRDM5RnJQQVdZUUZhN04zVUlJUEcxTXVZd0h4WE90?=
 =?utf-8?B?cUV1Qk1KUlBwOFZZNmNCMzJOejY4QTJqU2tHZHdBSkM2eXVKMlRnUm9NVjNw?=
 =?utf-8?B?UXJQbTQ2T2s5aXBma1R6eTF2RCtKQzkxaUZoOUxxZkpjMXVZVE1udFFQQzgz?=
 =?utf-8?B?UEVySG5RbnRBT0JRMGNhNTBJR2o0aHgwWUJpNmRjeHRqLzBQd3Fnbzh2TTJl?=
 =?utf-8?Q?rbmr2weMSMWHOKQqpIhOcbs6d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2dHnZTvfes3QVMdePdr4JeDan/wxn/l5Yp/Ia+xWfLt4BxpbwhIblmOydT6kmRUtCJ6wXNlkukWfUnwESWRh/vWYqNrIyQmbjJ7xT9JHSW7CpdzAtZPZQ1O1ktv0f0DBMDQQW2IuwIZM5nBZThH06xjOrI99+X7qhVctrzPfUIlenic4q8TrYY+yVCerdsareIy6pq865o9Ez/tvPYLiufjYiAYlOt+6Gf5eEI0R2eMLpl90oNnNuWnPNuEGUv9c13qaGC89AR4WFEQzA9QCyi3Xvlel/Kabf0+gcUG5tp843oj6VkX+H6fx+4kcFqh9Z1KekLqYhe1ELagfBTBQf6/VsBxuVwD/mHFcqQid/fUXrRxbGTA0qzWA23a6mClIJrEuL1JkN6/TuenILpKNLszs+XFJS9GdFQFcViUfuqYkoSh6pVLfoWWdx9CMZEE1unFF0Sz/zhJfyEX++IAZDYZz6pftewMy9cM6waV1Tnq4pAyfUAazGLxYCxKSPQ9mChm+aWWgWNNkuXk6fThqO4wzLNZpLEjAP2PNbn/4RdU4JANdZigcAK10NCbb81iuuINmf88vYgcAxBltcXH4wr+qwmTspfdwgNOj3KCrL9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c61e7b-b024-44a5-07fa-08de27899afc
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:35:09.9283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCzHKTzg3d1bgmh2plnuelp+tm/rJY0pa6xHFNzDwqoLT4n0qSwWV/UY6SXH/WYgZ/w5jdiYapslH6Bifn0MOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=918
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2HqXU4EYnaeV
 gTJguBZ08SUy6x2zHkUqyvbjqqRMjHRuzSAlLq7y5YoNBvy3yo3GXSKp+gg2rPI2Btml9VLSXUW
 0BgfztzG/vF6ro2b8HhJWiSspuHsmvJa9KQdxVgXD51PXi1vg7CByPW+T5CXLKXHjKPXYPkmCEJ
 LWxT1Jw3bB57rjemWJdVEkf5OhVdlPNKPCqNTm+ewTKaGgZ+BcjNhBnyKkrLb3pAlQ1j6u8AYbV
 FUJpzZHiJAgIoaeVDyuBmSwiZ48b1z/IP87W0+cTokb/W4XzeXH8d7j1+AElnhmTTsAJL6OJDgc
 WQd3rZk0cpZ8KXU4NX8UaEGuDaObpflmOm3LVPrJIE7rxUdFkmp1bxfZ/GeHgk70g9HsizcyWzC
 fuqQPiFgs+tXdM4EJ3SYCyJe3w1WtQ==
X-Proofpoint-GUID: B-aUymxC6G48DPpBCz5mteb-OsXFHlZ6
X-Proofpoint-ORIG-GUID: B-aUymxC6G48DPpBCz5mteb-OsXFHlZ6
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691df1c7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EmVVaUAQ9X8KYMxxXgIA:9 a=QEXdDO2ut3YA:10


On 11/19/25 1:56 AM, Christoph Hellwig wrote:
> On Sat, Nov 15, 2025 at 12:20:43PM -0800, Dai Ngo wrote:
>> break_lease is called from many places - the NFS client and server,
>> CIFS and VFS. Many of these callers do not handle error returned
>> from break_lease, some don't even check return value from break_lease.
>>
>> Until we fix all callers of break_lease to handle error return, which
>> I think it's much more involved, returning error from break_lease is
>> not possible.
> There is about a dozen callers.  Although some might not want to handle
> this error, having a flags argument to opt into for the callers that
> can and want is entirely reasonable.
>
>> I have plan to post a separate patch to check for layout conflict
>> caused from the same client and skip the recall - same as what's
>> currently done for delegation conflict.
> That would be very useful.

I will work on this first then wait for Jeff's patch to go in then
come back for this server hang problem.

-Dai



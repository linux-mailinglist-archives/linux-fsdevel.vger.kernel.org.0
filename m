Return-Path: <linux-fsdevel+bounces-43779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95195A5D7C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C037D3B63AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D4A2309AA;
	Wed, 12 Mar 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jB/8dWDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZQWzER6G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711B1E260A;
	Wed, 12 Mar 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766734; cv=fail; b=DEeRrJgfm9T7GX64QyoFSz6wcALQ2NJcSqO3BZRbz5kibQ/98o3cj62MAy0GgCSJIMHCGUsLXJ+e2GqiSJUsQqRoVo4xG9U4CWj8L0haMBsC2WMpXCJxfeWoUSLcco0r3c6px2IMWCDXFMEFPee9vqMkFu2k/WSCryJudwHPabg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766734; c=relaxed/simple;
	bh=8iO9qFznh++NR/GARAk8Tk7cccjseP+wyCpOsVBhS4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AzGJwbQYZ6rZWjLdgudjGTy/tA1VzpgTZEENgaxTqUTDKq/6EoGf3O/y1m6kp9MQpaj4WyY1BFIxAS9/uMZLUN5RLxgggdfMskVFSanoHgJrt96+1L4wCEpVczS67vjZXRh0Yj68Puq7smzqRxZPcF/Aq4lWab2gsN7sPhUUmew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jB/8dWDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZQWzER6G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1fqoW016947;
	Wed, 12 Mar 2025 08:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fl6Onmj9m2ztqK+aqxGFp/WKN4HfA1w2JRbmqdIpi8Y=; b=
	jB/8dWDUrJZ2OkduKo3Hvm2b6tkCD7be8NXSQv6slirg7mbtNzEhOOjohlELGAER
	/zeRElwIEF8BaLoW4ySfd6a/2XxMJ1Fst3CsvhzLcOwAmpEKi8MDVl6szMwGy0qu
	uw+TPvs2YRxdppMkF+Fig9kLolQVmpfBxlaoTrNkfiCiwoaY1+/eNh4Shkn/CJUq
	yPeMQGUoQ6I9jyjStUmQVjhANqminSLXzsep+tIxm9/4fjcZIkOEgqKcC5bQd6f4
	H96SM5876RK7RCv3cqsV4zJ4N1Bc0DT16HjAfoDLzfhBfQyCt3UZxvXPAySY3qjA
	ihssg4eGk4DcipjhH/ZPnA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h949c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:05:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C71DV6012218;
	Wed, 12 Mar 2025 08:05:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn0xnnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUabe2o7VwcYJN3UnvUyKk+xs925T/Hp6Cz7fKidJ6a+d+2eI78rLEmyfl1FKP4xAC1/k4CYmPb8Jc4VPWxj7wcBYnnK2miDRG4CE17pcAAIJvdC5E0hN3px4hZuQHV1VGDu9gDhxDPnn3n6WLtXqzmS1sBqmW+lsEaKHZvjhA8re8YjXvqYDm8cZZmXAypGK7Ql6VWCGCFuubydecEpP3oWw//qefyR5rKXneRbSWsN+lARj7bZjtQ8t26E2s2ERJ+RHEya34P6qJsi4CSvMXrVWwyB701QOAWVBgIQgwvevDqVnW73vKUk3hPTeMlizxDTpZLEJ1iRHRhbkGQK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl6Onmj9m2ztqK+aqxGFp/WKN4HfA1w2JRbmqdIpi8Y=;
 b=cNHHOydeXfw4Q3DgTAiEauZWQ/SQF0uYpNknzXF+nrY6Efp3uqhdoiHbNkB9PI6yrRtfcJ3fUNiw+ecoHY3oaad7CzLLoH6t1LfPeXJyChLrF+StSiyIy4Q/o9zvn3eX+VLGTNe0A61/x8JDovM38rPKBuSM8Bl7QDVGoaCmfHYX+i+kMf0gTm3Nf5vy8uIwo8UBwJvIJoTF95TmRtfOiR7iMNYJRVVP8xM96cGlxLsQTFswncY+eXOyZnpM15n+d8wRmX9P8QXYRhn1XsStZggqxp7fQYv4HkXoCzpgnGZBQEzB3ZDRBxVh6gTNSnfhvgrhZm068EJsee1rYIdZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl6Onmj9m2ztqK+aqxGFp/WKN4HfA1w2JRbmqdIpi8Y=;
 b=ZQWzER6GiFbtITin/+6/0ZYZabTPd58RYbRjtEtGtwZamXDxMeLsOTUsBBicghIFn1nEseZuowWSw5yMgDsqvauIcV9Yy3fi2yBmxWOSZVp9vI+gn5wRo94So5UXxKZLJ49NipGGH15lTowpM60oDz81jD8u5tO1/yn0zoZcLbo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:05:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:05:18 +0000
Message-ID: <4d9499e3-4698-4d0c-b7bb-104023b29f3a@oracle.com>
Date: Wed, 12 Mar 2025 08:05:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] xfs: Allow block allocator to take an alignment
 hint
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-10-john.g.garry@oracle.com>
 <Z9E679YhzP6grfDV@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E679YhzP6grfDV@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0409.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a4c293-0453-4ffa-b263-08dd613ca0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0xxeVFDS1VHa28vYkhJTFQraUFPQ1JZYTVZZnlNOTB1dDVTYVQ3YXE4UVVT?=
 =?utf-8?B?WWVRL0tBdWFQZ3MwNG40a3Q4YmhkeE9DRXZXU24wOFlNZmZZK045VTg5dlhP?=
 =?utf-8?B?dlcrZXpnMFBSQm9lcmlaVUhyeFM2R0thY1FpcVpVRkJvL205TlhYdExCYUNE?=
 =?utf-8?B?dXpySW1WMmxUWnZYbWREMmcrYU5KOWdaNzFNcUdQbkJrNndHSGI1MnRMR0Jy?=
 =?utf-8?B?cjVWRExyeDNURnVLS1VTdXo1T1ZLVmFUSUU3UmRtd05aRGRoTzVkcFBQWUw0?=
 =?utf-8?B?TVpuKzhlbU9MR2pQYnU3NDdnZVE5VDY3SmdGWjFRVlRha0VxdS9UdEZhaGZF?=
 =?utf-8?B?RmV6VzJEYlpBQnpCRHZySGJVU2JJWGR3SHhDVEtCNUlEdGZoZ0loYWQ4cjgr?=
 =?utf-8?B?ditPL2YwaU5vTTBFOGVZOE40NlhaN1lUU2hIUVZFaTAwRE5MUjhGRXNnMmNS?=
 =?utf-8?B?S1VYY1hVS21kQVMwdUx2cEZRK0FhQ3pMOGVFQk00V1VKcnR0YnJNa3lwQk1C?=
 =?utf-8?B?MTA3MTFDUzVJRENxU2xlM1VIdmR2MWpla2FjeEh4R1h3b1pkckdzOXR3ZjZ3?=
 =?utf-8?B?RThlL04wTWx4K3BVdU9hV2tSMDNXSStKOCtsMTRCRnRCYWE2WXRMZVYxZlJQ?=
 =?utf-8?B?N0YvU3I3WjNBWHMydFkzblVaa096enlPNWg0Qklsd1lzNjNQMm05UjR5UFN2?=
 =?utf-8?B?c1pWZ0M5UkhhK1hFeitnV3BVSzY3d0RiRTJOTjJLOWpzYlVrQm0rRkNsOTdh?=
 =?utf-8?B?c2tId2x6NU4zNmozaHh2aytLSGV1cUMvQms4THZ3c2dWNjFQd3psZHkwaTEr?=
 =?utf-8?B?aTg3UjlhYXNLbDgrRUd5L25UbFRvUHo3UDJJdUtNTVhnQmdpNFlybWJnLzRL?=
 =?utf-8?B?bktQcGFubThRS1NFMXNjVzlCZXh3U3AxWWhoOEQrSFpEOC9tU00vaExNZ0o2?=
 =?utf-8?B?YXliRUZjYURrQm1UTHYzWVhIcnlISHVzZktmRHNvaXVob3F4TUNPc0d1ZG9h?=
 =?utf-8?B?aHhHbC85OXkvb3dxSnlwNXlWeFFVcEJCTnhYSDJoaHlqeTYxc1R0OFE1eEcv?=
 =?utf-8?B?QTBnWnIwemE3VTlQRWZ3RnRxMUUwa0RlTnY5d1pHeW5YbmFTdW5mVEx0YW10?=
 =?utf-8?B?eExvR2V2YjlyTWpYSjNjQTdGMktvSUd3a0RFL0o3MUVqQngyMEZzWHorTnN2?=
 =?utf-8?B?eFJjbXJ5Y1hJQi95Z0VCUHdEa0dMdWJKKzgxK0tpNTFhVjlHSUZMMlMyVmFT?=
 =?utf-8?B?QUJGL3hQQ0VYTVl3bU1kQWVWVTA5aE8xVjRwS0QyaHExMC9zeE1mSmVJUzMy?=
 =?utf-8?B?d3ZZdzFLL20rdGVXNSs2Q0sxZGVJYUZmcWhlTzg3RE5WSnM1YVY3T01FbEZ3?=
 =?utf-8?B?bTR0YmcvUjA3WWZLNUpmcDdVTXh2dGdWejNaVCttdDVpVkNYczZGN3I4SUZX?=
 =?utf-8?B?L3NBcS9MN1FFdERCQStjbm1XTEw2em5FbjI0UFdWZnBmZnZRRU5LQW5TeDl3?=
 =?utf-8?B?RGVtL2R4UFV3R2swbk9DcGdra1B4K2VjVTN3TWpMRmVNZkowSEVWeWpNT0VK?=
 =?utf-8?B?UGV5MEtONXZ1bGt2ZHhzaC84a1BvaTBncW1iS2l6MHl3ZEJ4TEh2WWg1QlJ4?=
 =?utf-8?B?UEJtRlFzMzJjdXZGTXgvZ2ZoQ2NXS2hnVzQ2SUdLM2lReTJZTzc4RDBHaXdD?=
 =?utf-8?B?RVpwZVpXYWp3bjVlNjdMME9QQ2hrUy9xUTJ0M04zZTQ1NDVvOTJURkxwY0N5?=
 =?utf-8?B?OGxVbnMwTEdUNUhNTVk0NGYraDBZVFdLUU9mTkRUQTZNK3djWkVnVXpZeVN3?=
 =?utf-8?B?cWJ2bFl5ZExKNmhwR2JkUENUbHZ6ZnltT05wRCtzaE1qdURQNml6VmUvemhU?=
 =?utf-8?Q?j5Azoapgc2wr8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmhucTQvT2xPZGk2V1dRc2VWbXl3VGwreGhFQ3pEWXZtMUVzRG1UL2JBV29U?=
 =?utf-8?B?M3g0K0ZIS3dMV0kwTDBZbTlxVXhvUjN5bmNSYzFqS1doMEpkYXBKZUh3Rkhr?=
 =?utf-8?B?Ynp5dDZJYnM2cUc5alNtQ3ZjVG1TMjZHc0xyclFQS0ZxZEJnb083akxKMlpx?=
 =?utf-8?B?WDNCL2hCSCtNdXZBUjRjc0hUakQwQ1VYZDJRKys3MTAwUmRUeDk0QjJ4SXNH?=
 =?utf-8?B?VzNmN1FXTkdEbDZYTjl3T2JLbTdvWmRmWEtiSlBtK2xGVTMycGwrOFFZNW5w?=
 =?utf-8?B?aSswaFdNemtma0htTGxIRzVvRHJTT2JIN2MxYmRJai9uaUxyU1VzcHJEZkpV?=
 =?utf-8?B?YmpWcUVJNmVnS0dLVERsYk9URmppYzJISjZtOVFtOHAzWHRwZ3dVUkRFT1RY?=
 =?utf-8?B?MVZGQjNtdS9IUlFQYUxycnBqSVRvTW1BcWFlMmNidlA1Q3RROFdBWEd4R3oz?=
 =?utf-8?B?ZFh0L3FnOTdqR1N6YXlmeXJkM0hBRWEvRHJ5L25STnAzb1hBVlp2V1p2ZTRK?=
 =?utf-8?B?VURrWWtuS1QxZ3l0bkVIK2psUWdVYzVDWlVpOG45V2xGZGowNUVwTGgyNXlG?=
 =?utf-8?B?eVFrZWRWVHRVWElLd2kwTnpSM0RvOWhyM0Ivd0J4UlhQdXRIaVNQN3JKSWFW?=
 =?utf-8?B?ZWd0Q21nVG0wNUdSRTVaSlRhZDRRRmludEQwOXVEK1dtNVloRWlhT3hYb3Qw?=
 =?utf-8?B?YngwZ1lYZmtvT1NTdytNOGtEM3p0THVGdE1aNWhYOXhjMTRrN0dDRnhPOHVt?=
 =?utf-8?B?eGplM3FWbXlTS3d1QU9zY21BdXJRdUFOaktCR05aNXRzY2k3d2cxME1rbnEx?=
 =?utf-8?B?dnM4N2hZNDhSMUUyek1DWGRzTC84RzRBVjZGYXRKMEpkeVljRnJiUTNXeWgv?=
 =?utf-8?B?QmovZE1NSlo1OU9TOWxmaUxxSDRVc1Y2RzBBOXAwZzgwTGFSUTJEODhDR1g2?=
 =?utf-8?B?ZmV6a3cwYk5GVlRwOFJQbURVaWNWdzgwNU8ySWlSR2FoWGhiUFdIeEhzWmNO?=
 =?utf-8?B?ZjJwTTdMYUhZd0psR0lpU1IvaTBGamh3UlpJVk50US9Sd2FrV0lGMmU3djlJ?=
 =?utf-8?B?QXhRRlErSWFucXRleHFBUUE4WUJLM0dablJuZHNUMmw2eGc3UWdpNm85Y3hX?=
 =?utf-8?B?UUlBNUZERW5qOE1pY3U5a0xBL25hR3VZVDJmb2dvSTkzYm91TUVDSm13bUpr?=
 =?utf-8?B?TldUM05ib21FdlhuTXgrdjlQeHFwL200MGlibm9sS2pyMklMMnRqY3FrVU1I?=
 =?utf-8?B?WVJjUlk0cHdjdU1FM0pMVmR3WXhVemcyaEhUdWlqMHBGNjFOS1BtVVBIWVZS?=
 =?utf-8?B?VGZKazg4bWF4Z0l4QW5GZ1VVS1pRVHFXNXpiUXJHcGdMZjd0U0tZMklkSXBj?=
 =?utf-8?B?Mm5XRFVxWDJVZkFtTnZGN1k5eVB0VGViNkJNQVhNeTdoYkI1QjVwSzBXck9p?=
 =?utf-8?B?WFFyNlAvd2tYbTFUMDBaVGpTckJvVTdCbGxzc29YanJ0Mm9HWW5JcmkwNlZz?=
 =?utf-8?B?R1A3MVBXMGk5Y1JYSzhtTU9yTStJRXUxWCtkUzNCSmMxWTJzR2dxU0cxT0J5?=
 =?utf-8?B?MnBTaU5scGNkOTV0QnZvRHlId0JEaVBhQ3k4eDViZDl4UW9XZngrdzJiZVlP?=
 =?utf-8?B?ckhpM0d2ZEExVzNXU09qY1ZYYVdOeVVhUXIvc005b21FaFZLV2ErR0NOcDVz?=
 =?utf-8?B?aUwxRnBKNmlJLzMxK05mcldOY2ZJTE9tcE0xdmI3VGRBL09iZDBiNkFuWXRR?=
 =?utf-8?B?TnVoSFFpSTZkcklIc3lhSlE3UVlONjFYZVJ6NDhwUFcvOGdURTZpRnFubExF?=
 =?utf-8?B?VHNCK1ZiY2xHeXBqTFBjZVBjRnBRbSs3UFNsQ2Y5QTNiUHl6b3drc1JLWUo5?=
 =?utf-8?B?enFlOC9QcEw0eTU0WlVhUVdVV09CRjliMDJPd3RtNS9pMG1nZ214Qk0ralpL?=
 =?utf-8?B?Ynd2MHQ1d2QyeG5RVUZrVXh4OTltV00vWVhVT2pxVURwL3NQT1EvbE0wT1JV?=
 =?utf-8?B?RllwdnYwR2hnVGZiMWc5UWJ6WVEvRm5QcTdGSmhtTzBtN3c2R3FzMmxtcU9E?=
 =?utf-8?B?Q2JtMTJ4WUdZNmJta1lLVVdTQmV1bnhQay8yR3VycWR5a2xwTDBsSVhNWnY3?=
 =?utf-8?B?MUhGMFhtNWYrVFZBTE9VNzFxZ1FzU0dKWmZMcWsyN01tUkdWVDJ6cTEwdzJM?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wfcZHMV2vvAoMQpCNmeOIHMWlRFLo4iEIidtpvbMwM71sWej1dTQPWz0mlAUc07Zj2z4Pu/3L6O99Tg2qwnR6hIdVjQVQbBjcwH3NUHWe4N/z81U5cW/Y/nsE1PhBVJYb118lI2AiB/3jXoK9ktv7W6sphLIebzr1z7yVVrH3iNo//rzhZvsh7XsU5MAsxV2bHeKDoHh/7ch/0Fk4sOXO9IA1DMcysszrTQxerbDsyw4+NbyNwMG7mRchj1WGM7vl7wwrX/hUs4C/MON7ji6PJILSqD7Ri+437Y5Bt8AXrbUcCFvuJDd0RHArRbNvh6qek5HH/6Ed0GJ2TcoyCLkXStKPfZiiTcSvVhgF/uPzzr+a3NRKrNQLTRdSsCOqKtY/kbXVr7SBDkZ5XCNKnfogl4hGbS5Owpr05V/k1DSJ63AVTN5r5cS5TdoarTpFDeBcnNEIaWQBjZ1cCPK9OlhEt19uCinDfCyZnZX/AKZGqk0udRsQDcH2Of1fF5qhQ+cSaY8HciILL/okTZxGaoGA9XdDuvTtzetH59gkI/oxeHzctwNI3yY+PDfDDZJR2VVNFcMTmhReDmrltGcAB8/86hO8C2rC6Dq84fQUxmdfjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a4c293-0453-4ffa-b263-08dd613ca0c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:05:18.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2m4Ru0AiuFrbRlp35rHw/51204gROVtLWBby8GUeN8V7a7urKnInuEOSG5pH+GpfjyeByqXdGWU3XpWx4WfAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120053
X-Proofpoint-GUID: Ms9muMvNcRIN98MOEQPL_hSzAhoU-gHl
X-Proofpoint-ORIG-GUID: Ms9muMvNcRIN98MOEQPL_hSzAhoU-gHl

On 12/03/2025 07:42, Christoph Hellwig wrote:
>>   	else if (ap->datatype & XFS_ALLOC_USERDATA)
>>   		align = xfs_get_extsz_hint(ap->ip);
>> +
>> +	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
>> +		args->alignment = align;
>> +
> 
> Add a comment please.

ok

> 
>> +/* Try to align allocations to the extent size hint */
>> +#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
> 
> Shouldn't we be doing this by default for any extent size hint
> based allocations?

I'm not sure.

I think that currently users just expect extszhint to hint at the 
granularity only.

Maybe users don't require alignment and adding an alignment requirement 
just leads to more fragmentation.

> 
>>   	bool			found;
>>   	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
>> +	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
>> +					      XFS_BMAPI_PREALLOC;
>> +
>> +	if (atomic_sw)
>> +		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
> 
> Please add a comment why you are doing this.
> 

Sure

Thanks,
John



Return-Path: <linux-fsdevel+bounces-14111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA6877BD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 09:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B472812ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26DA125AC;
	Mon, 11 Mar 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OG1R6qFH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jr3CvqUh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B421173F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146561; cv=fail; b=lyYQECgM6tX/nbre6vdXpB9AwemVabnI6B86EoEylOx/cPWX6HSosjiRqB+mU8vKvEGJAv/BkINc7KF6piOoEEaL1lent1Ki2AJLZTVYK9l0GjRviaQSzuuyYDhjdNO2pC4TM0wQul3JxUe67HQscC+rGOeEy1Xw+pY/E8B23Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146561; c=relaxed/simple;
	bh=9JHA6b4oUzTPqbZOVS39IeMnGPIJ73bDe2nqr18tLk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ewAuLbXKNtKbeBJUg6NAuY6/4QVPtepi1Vu7vmU2UvPUz8qBICXhXrSNAk7yjsYTI9fhpzHK2JD4hQLwvltqFaahVf2BBKnkWupji2uL2rubeoP4iN60n+vQ1CaC+KBwFUKQpT2o3SeczGWGFipRpjvEgocJamptw7TmH1+rdZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OG1R6qFH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jr3CvqUh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B8DnHe020831;
	Mon, 11 Mar 2024 08:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=a+QhqhdouqQXFiwS43oiuPeyC1FDV4CroY0KqXXalQE=;
 b=OG1R6qFHi0C4cV8/vOVDDIHgTicyXoPL+W/xnpx/qeiSWpJrWMXL7bho9dahWOu2T6kP
 smdD/9KP6tdf+q6c8DL4jJ0E7hd1YNmNqx65LkAaGdeNAki3K0ulBzLb00k4oWyt0LL9
 iFP12HgrKdsnjrHJMeGIObkDxJ+8nr2KOhvi5YdFIOBAflDbvPbWZmN1IN1TEVl6f4L4
 KBfZ8tWMEBHDPnHUQFJEzyQIjOihgySNwQ5t62cByqxtnhM5F+eWoe1qmEOeV74DLspZ
 e6ygmtNx/2KtyxeNQHTdC981P+8isLo+2o/hmWdCQYSRjX6uwoNvtRr36PCUXmr5ZgoZ vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3tq85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 08:42:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42B7xdch006160;
	Mon, 11 Mar 2024 08:42:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75f6cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 08:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC2MFLuoaAnhq1Re4LfQW7wdl5J0KRfl7SsWGYEsxGaMbzdrsubpUwKTWs/UWFtdB7ABOBfDnXhoZgAieo9OQlkJyYHH3Gh9395ZrJB+tqtwQz+WT0IEarbsFKpMK73xVwussuSMGE6neoMef04J7G/4uAAPRUGJSdyyM+GNwL6w4bUMTCJebIMGpMhuNXRxRnCGB5yaz3Ndz7WROtrLTPy3EaDktOCIlRQk9FbZfeCWj0/3c4p1FBjGklygb67MD6iEVMh0pBjMZMIPQqoBobpl+KgDF92ZG01BRWie33UUqTCvZ7pmC5aNXovpYUU0/wqBEL2n7BiP6gJ21tM3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+QhqhdouqQXFiwS43oiuPeyC1FDV4CroY0KqXXalQE=;
 b=h8WuXTV3k8R5xlkpqXIR3lBUb5TFNLIyM4+PrU/ZPpMctWhgiLTOR5gIm9MhJv6Ok3BFzIx7d/M4opLm1VkPDPB3fN6lXG8vZcAniwhvOQnk2ygL1X4p75llZzf8mJ8YfREEQXocwR3YOP5XKTAjEZTEATZffWihK4BQ8E7WUaHHhd8yBGSJp4s/mJEtN9fsKcDMG3R2UQxUGqwgmf0rXb/cB2aNSjglwFSWkShyDo3D21qlITrOUVGfaLaPg0NfpdVj1xjE31hQwrVw6WQNSjmvY2r7Putiq/4FemLpf8L7CZPN7rn0YjIIbJthXuSgL14RSDCUKRfyud+7rTmEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+QhqhdouqQXFiwS43oiuPeyC1FDV4CroY0KqXXalQE=;
 b=Jr3CvqUhzyFV8t/sPtX7KId1+afMLk5Lvb9Tagw7w7KRkA6lhUDLwb4UmDV0qNjZqsJnMqXvoR2+b22ePHq12e7pU2Lfjqca4dTFY4o379Yl2EgI2qk/9MoqUnbieYFS3LdRqFiL3emV+ymHpGe2JJLDcwWSqi+HZO9REEHGVJU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 08:42:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 08:42:26 +0000
Message-ID: <238b05a9-6d25-4721-93f7-d15b6c0d2620@oracle.com>
Date: Mon, 11 Mar 2024 08:42:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
To: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20240228061257.GA106651@mit.edu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240228061257.GA106651@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0356.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 5494af9e-b511-4839-cac1-08dc41a72da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H925DTGQG9yQgjflGEw7HfmX9LPqBEgCBwR94xZH/dJeVT3Ct5MpjNqsLXioH30/JQz+RnhwhNVjxh0JrUIpFwusM82UhcjOiml2NZAR+aLCTf2O/aJl8Wmy96L0+Lojx0a3wraCcaNXjtcr1Ayf1ze/gucoPt2O+qE0vtN43RtWPS21DxLdlMuW0p3EaN4YJimuhcxRkKOeH7IobDYCz37yHQjtutR9E4xV3b3TOsoloexthKuLD9Dqgu2j2K90ERFWgmgTA9UGpmtO51CjT3heX1m8o5lEDexcveSpmlzjhY7x5tKIRBCH1x9t7V41+T2n5OXGlVZCfMsnIeazGxlvdycFMF1sig7W2xppPlPf0c6IF1h6BJ9fIlm4IOC4M7CTXG1ViQCtHeq8XO2UZI+miWIo1wrvGaU5nSJ6AEB/coepO6tfwCyMivhKdxlanwHFgh8yB2U4AaVBqhxHU5AUfNPIp3nOylTghA4hBRnaeupSmXd5o9D+qdjwNQS5xm8d4oBRdio6LyW3aMczDId4KkJZr9irXwWmvS/647+M3Ntg05oEz096ieBLwnG520f7fIpHAhD/h7ZrixlMguy2SH7kK6BdPteJQo5p1hgZAhLfNs0zk4F+se0HdB4r
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tk12WGpGV2cvTUVGVVpFeWYyNTZjb3VIN283TDBhL09yRnc4dDRpZkpnR1J1?=
 =?utf-8?B?MlJqWSt1TlJJT1loMDVySUxFQURKTmhTM09wOHNEM3pFTnh6TWVjM2E4cHFy?=
 =?utf-8?B?b0Z1YjRCUHgxWnFZeGkxSVJQZE8vWEswMm5QRVN5RmdXb0dlS2xGdUFkb0pr?=
 =?utf-8?B?UGpMdk5vOSs4ZzNoM2E0dWgyYmVsbDAyZGhyNzlwZnBoeWxLeVpTQUlFOW45?=
 =?utf-8?B?STFTNmxkUFpaWEFLb1RhVnJaMFJRUHJURXF1eUQ3V3VEaloxTU15ejhjK3oz?=
 =?utf-8?B?RFdWVUcyaXVvSTNMYWpNZzN3a3Ficm5JN2RBNXRuSFN6TzMrUWZqczM2K1Vy?=
 =?utf-8?B?N24xeFY5VXFQSk00T1RwWlBxMFJKaXpURXUwcTV5Y29uSENOMFdoL1JpaUlP?=
 =?utf-8?B?VGppVTVwdGRnMFprdmxTelJhc2lKUUpFekZJTE1BajdUSEduQTIvcDdUZG9l?=
 =?utf-8?B?WTdkV0FrSGRkMkpwZXFHdSt5ZktPY2gvTVZKbzBEVkhIclZXdDI5bkdtSXI0?=
 =?utf-8?B?NE9BYjdvS3UxSzNTNW1XeTFvVjlwYm9KaGV3dlh5NU1lZVVldGVRWVYwVnFp?=
 =?utf-8?B?cXdwMEl1ZHlmdG1paGloVlB6bFcrbFpEOHp5dXhpaFoyMzM1UnFDSWhjbGtR?=
 =?utf-8?B?WVlueVUzTmwrL3kwU0R0eFd5Uk91ME1GNm5aM2Yra1lCVEZkWERSekMwN0sy?=
 =?utf-8?B?TGJ0eFpLOTdhL2VhNmhneU1XdktGelhwRzF4R3FIYy9yanVSUElEVCszdjN4?=
 =?utf-8?B?MFV1V3NEUHN0QzM3dW9GVGNsdTRDZDRSUDVMY2RURW1BS2V1U3NsaDlvbmU3?=
 =?utf-8?B?MEZFNnBiNGdMM1VRMkZ0dHhtbXJ3MWsxRENEaHExaHEwVllSRXF2ZFU4Ykx4?=
 =?utf-8?B?Umo4SDJhOEEvckVrL2FvajFsMGpUaDlhaCsrajRGdGRKa0ZCVXB4UlQzVlNW?=
 =?utf-8?B?VkNKb1l2Y1BOTm9vd0NxZ3ZVRTJxTkpqcGJWeE4vbDJLRkQyYnlaVkFhczRW?=
 =?utf-8?B?U1dIVHZiZkY5MHZxbTkwTU9SK080eVhvNUtDTkxOV0ZBcHJVR2ZoS3BWWnBv?=
 =?utf-8?B?LzlNMVFXNFM0ZE52SGJDbEZOWUVtdmtxbi9Sd1RPWmRZd2VOQ0J3OGVXbjRP?=
 =?utf-8?B?QytsdTVGeGRiMmZ5QUNqYTdXUGxTeTJheVF1bzdFVXdzVDZremRnZXBvd1hR?=
 =?utf-8?B?eTk5Q2ZsSEdPdWZTUXFjRkNncEhxdWFlUU5rSW1ZSWZQUitaOW9yNzIwVkk3?=
 =?utf-8?B?Uk00ZC9Fc0hHTGVNSFdJUTQwMVc2RVMwZ095QUYzSTJpTThoU1lGenlWM3or?=
 =?utf-8?B?WGxoMWpxdkVUWGZDbkRjcC8rYVc2aVpzK0t5cGpIM2c3dFkxZDF4K3VDZHZ6?=
 =?utf-8?B?RzVteUpMV0hzQy8vV2U0UkRaajBhNTJFOFZib2I1d3lkMElkWUh4dnQ1OXgw?=
 =?utf-8?B?U29ZYlNVZVBkYmp2OTVMVmxSRlg1S1FLNGVhQlJzOWJvSVhpcmU5SC9TVGc4?=
 =?utf-8?B?TnJLVGxkMys4dzF5T0NjMkJwaXEvQkZIMVh1WkxMcTZ5MTc5QWt3c04vTHYz?=
 =?utf-8?B?bFVoUzZGSG1MdUtPTVJNYnVGMnVGTUwvK2l6VWRpTDJaWU85R2hQMTQ4TjBa?=
 =?utf-8?B?OEFPd0Y0N1lFdEpzRTFSeXBqUzY2VGQyZTlPOFlhbjYwZlBZYUtsR2RjQXhq?=
 =?utf-8?B?b2t2SGVJTnlSZ2EwUVRkYXJCa1hVcFZvUHdrcUxLUUdJT2ZwNkFTOTc0VmNX?=
 =?utf-8?B?TzZZT3lrZG5lMnB1WkNMbUdkbUhMbkc1Rk9IV3JVSGJ6ZEtROTdyRmFYQVdZ?=
 =?utf-8?B?eU82UDFrUkJaQmVVZGVmbjcvdStqL0tOOUlMajBZTmZ0ZG5ZeXhHT2JxZU1y?=
 =?utf-8?B?L3I4SWtDOGhyOThxUEgyN1NrUVRvdnlndys2UUlnU0JNWTZlN2ZycWc0bWZE?=
 =?utf-8?B?MlNWSkJYN3dLNTFmTys1WExSMlVDMHdCR0Vqa09rWmZqZnZmbFQ3Q1Nmendk?=
 =?utf-8?B?Zm1LZnc0QnJMeStXa1BQVy9CWmgwanRuOWorcDFPL0VDTGRwWHBwNUQzeFhW?=
 =?utf-8?B?MlNSczg5czNJQU9SOFBZZ2hYaHFzbWdhTFR1Zk5MUGs3TXptME9jRjdHMk5G?=
 =?utf-8?Q?UYv5xQ/KeSChHTcj9rr43vA6C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zgi/hcubZF1CVFmjC2QBvdd093uYXbm9zkELKz/jeBfs5EqgT+KYJ0ybWNtVWIc/qRKQg7Poyh2R3aBY76d+vEZKkBypquwVBH7LvJFiV20brk74Ke67uWhpY0hXdiNtsB1p9Ok3Kh3Dz33zJfwvQKQkF4D2fI6uqKotX8Uszdl2Tk1fGefFueH/hePUoh5zDDrkr+5MJ83FjwwvJk/VgqzzWxHVZB02i6WoZfZrCJ9EHmatSzdRvvTaOM4IXw3Pz72hACrAwGQ14dzkq8IHj+am4s3Ade/uMQ5kRbKm9UtfuL2+xXtIwTmjGBufdMqI2K3um36z5SS03fQDGKBws2zSKws4w8ig9QUzcunZ+SNi8j9118NbV5aaCrKE0Bu6Qdz1bAZWdO2lYH9QD5cCsYpdIWSYqNA8rObWGE610TWB6Z6KrAK2ANxQnkB+S68BMc9Aqmu6QjHeRH5eUAZCAqKqldfOlCD2KFWPMebEWmx1fnRVZZQWyRYkl5p7JXLsdhcJ0lHZamSGO477DfuObwpfLX0dFaI8gMCAZiWjoGHRurRnjGjRVw9Qjh+9FOSojYeFcPSEm9BZb6o5IG3wrNZxT/H9IY2hKCmuWnFKn9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5494af9e-b511-4839-cac1-08dc41a72da0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:42:26.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7KKLOkNVpzoNiAKHX0ESsEc/musWWOjEvopmJFQSbtB1ZOAo2MQggdsGcdemsbz1YxfXw0h0EEzmqvxm5I7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_04,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110064
X-Proofpoint-GUID: 6f_9JzIZbRmEZ3o3twJgA9v1jvwJer-t
X-Proofpoint-ORIG-GUID: 6f_9JzIZbRmEZ3o3twJgA9v1jvwJer-t

On 28/02/2024 06:12, Theodore Ts'o wrote:
> However, this proposed interface is highly problematic when it comes
> to buffered writes, and Postgress database uses buffered, not direct
> I/O writes.   Suppose the database performs a 16k write, followed by a
> 64k write, followed by a 128k write --- and these writes are done
> using a file descriptor that does not have O_DIRECT enable, and let's
> suppose they are written using the proposed RWF_ATOMIC flag.   In
> order to provide the (stronger than we need) RWF_ATOMIC guarantee, the
> kernel would need to store the fact that certain pages in the page
> cache were dirtied as part of a 16k RWF_ATOMIC write, and other pages
> were dirtied as part of a 32k RWF_ATOMIC write, etc, so that the
> writeback code knows what the "atomic" guarantee that was made at
> write time.   This very quickly becomes a mess.

Having done some research, postgres has a fixed "page" size per file and 
this is typically 8KB. This is configured at compile time. Page size may 
be different between certain file types, but it is possible to have all 
file types be configured for the same page size. This all seems like 
standard DB stuff.

So, as I mentioned in response to Matthew here:
https://lore.kernel.org/linux-scsi/47d264c2-bc97-4313-bce0-737557312106@oracle.com/

.. for untorn buffered writes support, we could just set 
atomic_write_unit_min = atomic_write_unit_max = FS file alignment 
granule = DB page size. That would seem easier to support in the page 
cache and still provide the RWF_ATOMIC guarantee. For ext4, bigalloc 
cluster size could be this FS file alignment granule. For XFS, it would 
be the extsize with forcealign.

It might be argued that we would like to submit larger untorn write IOs 
from userspace for performance benefit and allow the kernel to split on 
some page boundary, but I doubt that this will be utilised by userspace. 
On the other hand, the block atomic writes kernel series does support 
block layer merging (of atomic writes).

About advertising untorn buffered write capability, current statx fields 
update for atomic writes is here:
https://lore.kernel.org/linux-api/20240124112731.28579-2-john.g.garry@oracle.com/

Only direct IO support is mentioned there. For supporting buffered IO, I 
suppose an additional flag can be added for getting buffered IO info, 
like STATX_ATTR_WRITE_ATOMIC_BUFFERED, and reuse atomic_write_unit_{min, 
max, segments_max} fields for buffered IO. Setting the direct IO and 
buffered IO flags would be mutually exclusive.

Is there any anticipated problem with this idea?

On another topic, there is some development to allow postgres to use 
direct IO, see:
https://wiki.postgresql.org/wiki/AIO

Assuming all info there is accurate and up to date, it does still seem 
to be lagging kernel untorn write support.

John


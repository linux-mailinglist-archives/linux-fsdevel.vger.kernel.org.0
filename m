Return-Path: <linux-fsdevel+bounces-74747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OlAG/oScGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:42:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E76D04DFEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1873E72E73F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A83E95A0;
	Tue, 20 Jan 2026 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lM5eCIkX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U37ZEeGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1353C1FED;
	Tue, 20 Jan 2026 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949324; cv=fail; b=b5jcV/bdR/3jP0+qBnpzQvVxJqN4AOIIRCYSMo8cnFZOWKXOOhUh2y7SvGG05z3b8MsxMODP25T1lp+aH/7LDflKcE7EVEHYnUNrVrR6q8oGt9y2DVoGj+L0tQWLEHrSVGu0VoGViVrJsmpLg7WvL0su1jOXpw1JaWXirtpxSrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949324; c=relaxed/simple;
	bh=SsZm6dZ3Vz9jxlGxsnXUQOosSq2SFrVOQDohCktfmWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HKpYihEwJzRmFW5wdyPUOdweBrN+ovWSO0evZxJkX9xJYzTx5weqENCPJrnHPQknbbc28UZUMbw0x8AAvSOA2vjusfaeklMpCjcWl+1Joifcp7vCmL8Uxh0aPJf8G0SdDQcWdq5pVTY1Ju3BIWOzhwSI7gSYT8GyWFtUfLZecls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lM5eCIkX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U37ZEeGl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KIbXnB3265101;
	Tue, 20 Jan 2026 22:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jf35wMR9dzAvWljHd6bkdh7+Hw1Wx1LtqgBuey1s3bM=; b=
	lM5eCIkX7f9YFVwjBNBqQceMlKcmEWsxLGuIq46Tzbc4ZL6/EXfXn9xiMiAodLC2
	LmUJbZCJk6lSCpLKPj12m5kFG4KJXAIuTFbueiDzDMjdNY3VWL5CG3fNrlkez6g1
	l0+B5Y8CuHc9/bCiaQlfwLrmdSYDBFHRXGtpKaCKjSOIbXcQI7ZpThLhDYJJ/LW1
	K01sni+AVgPz/7VDbe6LOtANnLSuVs6xeD2J83AQvmXfHaLLkciwht2MS78iQrTL
	XyKIGv1Uy3mW+aFNEooENPMcY9y4JU9E8xW/yc8mrqKZ+bUg/xtA9BuMTg2hD/RM
	CsFbRroDgUzEnm0LUJcR3g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8cp8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 22:48:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KMjVO9039386;
	Tue, 20 Jan 2026 22:48:31 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vabr1y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 22:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBdWfJZav5wha98648NIWO/FuD1xUaaPgVGVsRHdih4Uw5jEvjmAJt/0qK6dQ2t431AbZvLBOtKRpSvTC++bOFa8XHd8FtyQMwW9tlBSvnlyF/1h9oEOu5eIsKlyfLNUnZp59uLVrdtghyjyg9G3T9JQPwpaI6lb+0aWLlFhZSmNy4mCpkaiowq0BYpF0cCPxL3lKZqpoHMMARWLcyn8tLcP25WtstkkElnN1tkkSDacfd2qbeynHr3hpWGO4NQR+Noz+bY7Oe7ZwqwOAuIF3us/D0rEP+qRkKnhOI1SkDUifjKbaWsn3hzRyvPU8eq+Xtb/GGCnO/lpFRnNDj5x9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf35wMR9dzAvWljHd6bkdh7+Hw1Wx1LtqgBuey1s3bM=;
 b=mrmkpkS/PGzCM4IviuviQ+5BNfMwwtZHARYP4GKlyprt8BDZf0IkjsBup6/iLPX6hqWs1k/GBrUOR4AjqtyxB8TuMIgHbjPTdQOIVG2K28+yZTKqRpSngy/j80raNOrqwOrw65YI7+Yg6hhWNqRTGbpg4g5DaM4FzmrWgUVZVkzkoEugK/1XuXOl+aD4a5dvIIV9OhiZdNnb5hkL5D6VA2dTLNFW4VanwJO9YwAYwYZ/KhMKEejZ0t0gcjQbCUGEccEKEmaAW/XD8tmDh6/Qj2HYHDw/EI9B++YDL1E81VSj6KPrrJQE2cF2n/fdBGve7L1rUCO4KnSAhUjsUvGAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf35wMR9dzAvWljHd6bkdh7+Hw1Wx1LtqgBuey1s3bM=;
 b=U37ZEeGl612LSAzjJpg9bOpj/R9gHfSMhhTnr4JcQ3qjXDBZFdjl+kUPP1T7jnbBGz6+NyGqJT3jkp392bcGfjEIYmIgR59+HpiZ3DNb+/onO7Vv+Q6fFazrkGBe33G+6F9bdDjU2Pat+Jq70pzpKE6eLgEMBgaYnqC5RLzdxAQ=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:48:28 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 22:48:27 +0000
Message-ID: <0b8ccb71-4727-47b0-84c7-0d4a4abbe390@oracle.com>
Date: Tue, 20 Jan 2026 14:48:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
To: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
 <f02d32dc80e1a51f4a91c5e3ce2a5fe10680e4ea.camel@kernel.org>
 <a1dc8306-6422-45c8-a5b0-8d10a4d89279@oracle.com>
 <f2203e755aca4da45b099b18aac03b0a9d299343.camel@kernel.org>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <f2203e755aca4da45b099b18aac03b0a9d299343.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CH3PR10MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: c55894ab-6540-4f15-7997-08de58760690
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d3hpaFBDSkRPclM5WWlScy9LbkJ3MHY3U1J0b0JvM3hLWHNvaTgydXhVSkxz?=
 =?utf-8?B?RUZNUm8xcFpGdVFNa2ZkZzZteERCZVZuNkNiL2cxM1NMSGpPb01VaENtV3lW?=
 =?utf-8?B?d1k1eUF5aC9lVDRDb3doakhQenNiQWpSUEZtUXlWb2w5ZnhtNU03VFdKQlVp?=
 =?utf-8?B?bThkVlpFckM5Yk84cUo4TXlhWVRpZG9sVVRNUG5pclp5c0ZPVnBydlNyOGhy?=
 =?utf-8?B?d2JOKzdNbnlZSXhwSnpESThodEN1SlYzOWxOeU5SY2R1dEZ1QXhWamVHSG90?=
 =?utf-8?B?SUo4M2Q0U2s4dXhQUmlHcXRBdlNHV29KYXZMMjVBOWRUVC85YUc3WmpNVVRk?=
 =?utf-8?B?VThweEJ2S3N6NFRHT1J0MTc0aG56Y0JqYWs4amxkckxOcU1mNFlwSG41WXpQ?=
 =?utf-8?B?ZnVXZ1dRTVBWb0w1VXJPSHM0dHNrQVk2RVZSRGxjdDQvVGlsdlV0d1krNGNI?=
 =?utf-8?B?d21vL0xnTXNvQ1hKYjByRVBMak8wNDBGT3Z5K0NGbGU5TEgycG95RGd1RnRY?=
 =?utf-8?B?clF0SW8xUThMRWlyL1pTK2JZOS9TUjNHbzhPeU1DMFlXWmFEbTNnb1lwYWR1?=
 =?utf-8?B?NlFZeVhMci8vUi9pNGMybWU2M2xxMFY0bVZQdHRoUkZ1akd0SUpybXZCVlhp?=
 =?utf-8?B?dGtCYWRxcDJuVFc3eERySlE5b0xxSWI3UVlHR3U4Y3dVc1FtRUtKdXhVNVNk?=
 =?utf-8?B?dklBVk8yWCs4L0k2MyswOHRWTGliUksvd0VUVDgyWkNWNUpxYXpodDhUbWVo?=
 =?utf-8?B?K0Jwb255bnVhQkg5OE52QkwwR2FITzVwSlhiN3NxR2RuaTNTWWwwcUF2bklo?=
 =?utf-8?B?NDI0Rm9EeDEwbjNZSUdpaFJiSVJvWnQ4dFBHbVFQejZYOHZzMU1ZOE5WNzEw?=
 =?utf-8?B?cnYrNURIM3BKck1WVmtqUk93NGlsQVBwM1NIRGd6YXc5aHBBazhzcit6Vmha?=
 =?utf-8?B?eTJwWGVYcy9MMzA3cjRqZGFhbmYwWFlobG9vU2Jmd0N0TDMzUGx5bDF5amd0?=
 =?utf-8?B?TDIwWll6R3NyT0xQLy83QmtCbElpRENlMitEZmlNR3hsMHQ3QWlFK0pFQWtT?=
 =?utf-8?B?eEU3QkNEZVh6b0xaQXNZOWFmY2RZNmpFdjh4Zk8yak4vWnFFTWpYcXdZQW9F?=
 =?utf-8?B?UEpVUlUwUGhyVVd2Q3FVUXYyTzhFL2oyZFVqUS9LeXVlUUx6VDVnUHJ6Qlky?=
 =?utf-8?B?ZHBQSTdrTXp3djBBVXpCb0tjK2locTVXSXQ2U3V2YnhuWWxOU2RtWTNGR1Fr?=
 =?utf-8?B?ZFR5Y2RBV0N0aVgvOW8xSElWYzFhL0JsQUlnOC9PbVlGbTE3MDVMdFdTT3Rr?=
 =?utf-8?B?eUtyemVPWVBkNzZKSWlQYUIzVjFmYXprZldVaDdSSEVoMFc5TGZSUWpraUFu?=
 =?utf-8?B?QytwOFBSUEdRdUxVbXNubEtVT0NteldSZmpWQlZBUFNQOHRJSlZtZkd2SjRV?=
 =?utf-8?B?aTNkTVRrL3BFcVFDN3FsRDU0SnRMUjVVUzlnQ0daSVZWWWZBdExnMzMyVDNm?=
 =?utf-8?B?cFNWcTdYU051SXRIUzczN2prL2FZdDFYdk1XaFdTdUptT08zaUJoL2llWFow?=
 =?utf-8?B?VmFxNi9IZXp0d3pKYXArVWZPeldLS2lzUE5JZXRoeU9xdXM4RjlwaUQyR2FV?=
 =?utf-8?B?Qk5UdWhMQXlEOXRTbHRWeGdOOGRqKy8zVWdRRUdvcStCSmlXSG95R2VUQWU2?=
 =?utf-8?B?VHdwa003b204QlFJcjhXTHRsQ25CTmRLRUpwS2Z5TEN4TFlmdkMvRWt6V000?=
 =?utf-8?B?eEZxNzdrSkJ5bUtYb09mQnRCRUhuTzFrL1c0UE1USFVGcDRyU3Zra0hMVE8z?=
 =?utf-8?B?VWQvaWJpdTlYditSTURCaVp2LzQ4bXJwWjRpeWJmK1ZWckV3QUhIZmxmeG14?=
 =?utf-8?B?VlpYWWVwbWRBQ0lVNjJEdVdBd0RreCsrdjA1OU4yNmYwRnNjZk1mNVN2ZDhj?=
 =?utf-8?B?bmtCVEkza2t3dXVOanl5V0NPeGVTclhiZDV4S1phVnZBZFBkU200NnI1d3Iv?=
 =?utf-8?B?OWhIMjJmZkorYnU1UHpadHNZbUJ1bElPV2N6VnlvdkREeDNGVXRocUJaWmNB?=
 =?utf-8?B?dHNsZ000NWVzcTN6WG05QVluNGpqSmR0MUUzOVU0NWttaThLZ1AxZnpsakRi?=
 =?utf-8?Q?rO40=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WkdsMERabmE3Tk0vWGxraU5NUTdiVlg4U1NMOWt6ZkNtdHNaZWFMK2NKNWN2?=
 =?utf-8?B?bFRabnh1MnVWQzZwQzRUTVZTZEFhSkdZc0tDT0RGMWk2bnUxL3Z5OVZYUTli?=
 =?utf-8?B?Y0RKclcxRUVyL0xmcW00bTRnVEhtVzRtSlRGblBoRFVJTHk2WHZRT05iYnFG?=
 =?utf-8?B?b2Z2ZDVhdXZLOFArems0TXJUanMwUXNXbkdJWFM1NE9waDVMV3JTZlZzZWJH?=
 =?utf-8?B?QmFIRiszemlJRWhxaWdab0Y4OHhST0pYQnc3MXhjbXUyMTdiZUVGZzRadEQ3?=
 =?utf-8?B?SmRsa01ZYk5GaWFMVURyMVNVNGtUTm8weEVISVVRUG5HZmQ0M1FOVW56Sm14?=
 =?utf-8?B?OFVRM052dTlmT2xGU2lRRXpMbUh5dEh0K3JxVmNXYWYvZUdUaGJ6RkRuV3NH?=
 =?utf-8?B?U3FNY0VSbGRlTXZwR2pLeHB6OUI1Njd3dXNGU0cyYzM1UTBsbU8wTFlML3FM?=
 =?utf-8?B?eFJnbUVJc3dteS9LY0JMSmJFVGJScWRveUFpb1IrYWtWdDRDR3REMm9LUXRz?=
 =?utf-8?B?NWZBMmhqNVBwK2JET3VNUTcyUkRGSnlQK09NQWpUcGh5Mnd1djdyYjR3dHhE?=
 =?utf-8?B?d0ZuTXZ5cUJveG1EaDhrTjlDUUdBNWp1LzBDRW9tVDV0bjhOZUxrcmR2V3Av?=
 =?utf-8?B?SzMwZ3dMS3lxM1lyOFpSWUJLSDBOZUJweVd6Lzg1Ny91VDRRTGdGak9iZFM0?=
 =?utf-8?B?TStZbHUxQ0dDRjBaRWJpUHBaTndvb2Nld1ZCaXlKY3ljZVZ1WTE4VjRNVHZj?=
 =?utf-8?B?RWQzVnJwWXVTMWZ3MTZXN2UrTmcvQVhUY0VTM09DUW5aVk1QdXZMQm5iZnJB?=
 =?utf-8?B?V1FFKzgxZkFWcDVSeENqVGdpd2ErN21rNG1USjc2SlNVVGU1dVJrTHY3Nnd1?=
 =?utf-8?B?S0oxTEFhbmhucHJCQ0V2Y2R5T0hVMHhTZDFHRmNiQmpaRVhtdCtSRXRKaUpJ?=
 =?utf-8?B?T2ZuZkt5Y2V0RERMYjdOVHhKT0Fvb2Z0UW5NdFhRejZBTjYyeHZNek9YWnM4?=
 =?utf-8?B?OU1RbVc1WGo3SEFtSlJSY29qRGxTTkNLZkZoTlR0QXNIYkNZVWN0U2d1RGpy?=
 =?utf-8?B?QWpwN2lrWnFlanl2aHhWYnFyUHNzVlVpZkhuU2loME1EbEdGSUpVQmdaU2Nv?=
 =?utf-8?B?bmhFdUl1emMzNmpNZEVuL0szcG9yUzVlTGRURThiZ3B2YktNcmJYcCsvQWJR?=
 =?utf-8?B?ZkZOL01VUC9DeFgyOERJM3ZETDJMM05BZnZkTmFGSUhQelh4azcyQ1pZMHJy?=
 =?utf-8?B?MWpRQU1xZmlkUVVpTWM1bDBaS3JLdmxSc1hlZ1NiQjRIVHZqVXh2LzU5NHgw?=
 =?utf-8?B?S2s3OU5tWTJEU2gxQ2hOUGV0ZUhBeVFTSEcyWjFjVVByWDVGbmwrM2U1d3NM?=
 =?utf-8?B?cGNQSGxKSGdtREQ2T3VMVmFGS3hXUTZSamJveWp2V1hzTUJyR2pMbWY3SHJz?=
 =?utf-8?B?QWRKK3crbVRwRCthaERiSUg1K3VTWVY4RHRWQ2lQN0ZoKy81dkVuNi9XZ09Q?=
 =?utf-8?B?Y3J4cVgyTmtFNWZXYis4WUtvSUs4NDJYeXg3NGZGY1Vtd2hMUUhua2pWTFpK?=
 =?utf-8?B?MHlNMURLUVVLVjN4anpySFdoMmxEbWY5WHZTelJSYU9vTWkvUDV6b0d2bXln?=
 =?utf-8?B?cjM1bXcraEttQUJtSFYzQXhwcE5UejkvbzRYSExJUHY5eEk0NVBrOHZ5VThP?=
 =?utf-8?B?OFdKZEVCdTRKTkt2MGpreklYVmV2d0FJYjRxd1ZVNXpDTkRmL0V1bU1ZamhN?=
 =?utf-8?B?S256ZXQ3MHRUR0xoSjVuQ0VhUFNYNXJwdEw0elExRzg2b01jNStkTGNIaDFx?=
 =?utf-8?B?WnpnS244dVVTOTNPTVNvdllhaitVRzhDYmZNU3lKbEh1UndtRmJTN3VMUzJC?=
 =?utf-8?B?UTNSNG1NaTZaYXNYNEp3WVFXeXpRYXpPdis1MFlEUnNycXcwT3pFY2ZNS1px?=
 =?utf-8?B?QmtaamRlVWhBQ2xsMHU3MWxCam5xMlRIWndDUXJ3eG5ZdDZwQ2FKV0dHQ1JM?=
 =?utf-8?B?VXUxeTFPZXhkN1JDdkZBNS9iQi9LSzdmSzZJYmJ6MVpxSWtudUxiWSsyMXlG?=
 =?utf-8?B?V1pDYVB0R21YY1BWa0gzZy9qbmVvcVM2TkdncFhRa3hWSGgvczVucVpmQTF2?=
 =?utf-8?B?YnlXL2gwUTdtT040b2NGbkNnRXdySzRyd21zNCtrTkt0ZW9BZ1pTMWNPRFRW?=
 =?utf-8?B?ZXRXYVQ5YmpCT1N2cW1vNkhpWjJwQUhvaGdPa2VuSHNHUDlMZC92SS8vcy9S?=
 =?utf-8?B?TXJCZWI3NEY4Q0RsRVFyLzBUOXVXK0RIZXY2TVlOVXZjdzhUdmFLMVJyOUxV?=
 =?utf-8?B?V09Eb1Z1bEo3eENRVVFhWGNDWmQyMVIwbmdnK2lzWUFoRUN4Q2Njdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xhz2t/goTfvLuA5gI6igklQPFE9J7siSFefQXj9JoivYX65z7HTDp1wiKxNxLdRDcMfe1yocP46BcldnsRPR3TBZ6XNUmFY+rp+woHWj5etR/S4jveSC2BrvYKM7uTjpSaR8+IW5RXkQXpKQ0iBazT/aTkPDq8UmqZA+zzZtAnamUZaHZSIbiBmKpWiAxiY3GKKt70xMJtCODClhTiaLiTEZRubJxGwQOb1UdD4X2MH2G0OKKYgdIbybYhuJCJxn5VhstziN1w92AkVLo+XB5oRnACzsnn2RY+c1d77p7N1e05TfYfHxOjFhRtevaheneFYn8OnzoRA8gviTEIHNXrfZCu2zryjKnm0Up3T0pTMCVAdDVhC2kmMLABxoG5y7Vid8xVC53kEJK5GJg7CpnsGnYBJBWE49BUZT5W8XnNjfUqWJN62VOR13h9sJYG4IDCz74I9h8OfiWZ1Kl73Wpr1V/Y+06P/ChFaKEeJOl0XB6wec0uxgJ/UCpGSZ/nD/3FILBYuoJONbmwM40f5B8tlCrxTTVlWyTypaYYfa3loMCRyhn/2t7imcW5pt/kKPDUapRRQNSLtaHlP3GAiSTnYsWcqWtHQeFYrNmki2U1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55894ab-6540-4f15-7997-08de58760690
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:48:27.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ltjUV+sVhQtju0Uf7gjKGiI0yv23vJ5gC+hxMGmGb6Uj2SAS3onv8V7Y/ANLekhPdnYt8V2/JqYqW0aq/SfKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200189
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=69700640 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=XVlZSN03RrDhwIXDFo0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE4OSBTYWx0ZWRfX1EepGCPTejw/
 j6k6d8085ii6DhYUP0OsJoZjj/zR64DbELh0AiI+pktVdPO+x6Ty2DZGJydjnwKRxTZyagsdu/z
 Yxw8pGsPzsCi4u7HkRjX25cyqKiVQDppPem3PDmUKoFs7oj2DbLdIoZvzQeb92Y4PPsrBY9eN7W
 73no+eT/MUUvu9oGt/eTZwRsN6KNAcXgvSAucx7v4XOc/O6opht2aID0YZpPnuSeFNVXK0cmSjR
 b7gDnZt34FvXgNwmdzK42Y8Umt/tHUNV/HatgEKD6yxR4jituAuohSsRopfDeOUVcQset3p0PHL
 SbhBcn1vIVKBR/dABy2OZNrbODR/fy0J9EU+60V5C866VEHl35+CPge8KFQhnEHYG3ZosS/VDO5
 XND2vaU2MTJ93A2QfSYopDnCC5/E5xmitxtCSykHXMk0EHl8Ft8yte3q/4UvhWrFC0mtwIXn9j9
 LJDupL/WglPeqNq276g==
X-Proofpoint-ORIG-GUID: dDMYFkm2O6lwlGySWu3jxXjayHHTDBfE
X-Proofpoint-GUID: dDMYFkm2O6lwlGySWu3jxXjayHHTDBfE
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	TAGGED_FROM(0.00)[bounces-74747-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,oracle.onmicrosoft.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E76D04DFEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 1/20/26 1:28 PM, Jeff Layton wrote:
> On Tue, 2026-01-20 at 13:22 -0800, Dai Ngo wrote:
>> On 1/20/26 12:41 PM, Jeff Layton wrote:
>>> On Mon, 2026-01-19 at 09:47 -0800, Dai Ngo wrote:
>>>> When a layout conflict triggers a recall, enforcing a timeout
>>>> is necessary to prevent excessive nfsd threads from being tied
>>>> up in __break_lease and ensure the server can continue servicing
>>>> incoming requests efficiently.
>>>>
>>>> This patch introduces two new functions in lease_manager_operations:
>>>>
>>>> 1. lm_breaker_timedout: Invoked when a lease recall times out,
>>>>      allowing the lease manager to take appropriate action.
>>>>
>>>>      The NFSD lease manager uses this to handle layout recall
>>>>      timeouts. If the layout type supports fencing, a fence
>>>>      operation is issued to prevent the client from accessing
>>>>      the block device.
>>>>
>>>> 2. lm_need_to_retry: Invoked when there is a lease conflict.
>>>>      This allows the lease manager to instruct __break_lease
>>>>      to return an error to the caller, prompting a retry of
>>>>      the conflicting operation.
>>>>
>>>>      The NFSD lease manager uses this to avoid excessive nfsd
>>>>      from being blocked in __break_lease, which could hinder
>>>>      the server's ability to service incoming requests.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>>    Documentation/filesystems/locking.rst |  4 ++
>>>>    fs/locks.c                            | 29 +++++++++++-
>>>>    fs/nfsd/nfs4layouts.c                 | 65 +++++++++++++++++++++++++--
>>>>    include/linux/filelock.h              |  7 +++
>>>>    4 files changed, 100 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>> index 04c7691e50e0..ae9a1b207b95 100644
>>>> --- a/Documentation/filesystems/locking.rst
>>>> +++ b/Documentation/filesystems/locking.rst
>>>> @@ -403,6 +403,8 @@ prototypes::
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>            bool (*lm_lock_expirable)(struct file_lock *);
>>>>            void (*lm_expire_lock)(void);
>>>> +        void (*lm_breaker_timedout)(struct file_lease *);
>>>> +        bool (*lm_need_to_retry)(struct file_lease *, struct file_lock_context *);
>>>>    
>>>>    locking rules:
>>>>    
>>>> @@ -417,6 +419,8 @@ lm_breaker_owns_lease:	yes     	no			no
>>>>    lm_lock_expirable	yes		no			no
>>>>    lm_expire_lock		no		no			yes
>>>>    lm_open_conflict	yes		no			no
>>>> +lm_breaker_timedout     no              no                      yes
>>>> +lm_need_to_retry        yes             no                      no
>>>>    ======================	=============	=================	=========
>>>>    
>>>>    buffer_head
>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>> index 46f229f740c8..cd08642ab8bb 100644
>>>> --- a/fs/locks.c
>>>> +++ b/fs/locks.c
>>>> @@ -381,6 +381,14 @@ lease_dispose_list(struct list_head *dispose)
>>>>    	while (!list_empty(dispose)) {
>>>>    		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>>>    		list_del_init(&flc->flc_list);
>>>> +		if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
>>>> +			struct file_lease *fl;
>>>> +
>>>> +			fl = file_lease(flc);
>>>> +			if (fl->fl_lmops &&
>>>> +					fl->fl_lmops->lm_breaker_timedout)
>>>> +				fl->fl_lmops->lm_breaker_timedout(fl);
>>>> +		}
>>>>    		locks_free_lease(file_lease(flc));
>>>>    	}
>>>>    }
>>>> @@ -1531,8 +1539,10 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>>>>    		trace_time_out_leases(inode, fl);
>>>>    		if (past_time(fl->fl_downgrade_time))
>>>>    			lease_modify(fl, F_RDLCK, dispose);
>>>> -		if (past_time(fl->fl_break_time))
>>>> +		if (past_time(fl->fl_break_time)) {
>>>>    			lease_modify(fl, F_UNLCK, dispose);
>>>> +			fl->c.flc_flags |= FL_BREAKER_TIMEDOUT;
>>>> +		}
>>> When the lease times out, you go ahead and remove it but then mark it
>>> with FL_BREAKER_TIMEDOUT. Then later, you call ->lm_breaker_timedout if
>>> that's set.
>>>
>>> That means that when this happens, there is a window of time where
>>> there is no lease, but the rogue client isn't yet fenced. That sounds
>>> like a problem as you could allow competing access.
>> I have to think more about the implication of competing access. Since
>> the thread that detects the conflict is in the process of fencing the
>> other client and has not accessed the file data yet, I don't see the
>> problem of allowing the other client to continue access the file until
>> fence operation completed.
>>
> Isn't the whole point of write layout leases to grant exclusive access
> to an external client? At the point where you lose the lease, any
> competing access can then proceed. Maybe a local file writer starts
> writing to the file at that point. But...what if the client is still
> writing stuff to the backing store? Won't that corrupt data (and maybe
> metadata)?
>
>>> I think you'll have to do this in reverse order: fence the client and
>>> then remove the lease.
>>>
>>>>    	}
>>>>    }
>>>>    
>>>> @@ -1633,6 +1643,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>>>    	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, c.flc_list) {
>>>>    		if (!leases_conflict(&fl->c, &new_fl->c))
>>>>    			continue;
>>>> +		if (new_fl->fl_lmops != fl->fl_lmops)
>>>> +			new_fl->fl_lmops = fl->fl_lmops;
>>>>    		if (want_write) {
>>>>    			if (fl->c.flc_flags & FL_UNLOCK_PENDING)
>>>>    				continue;
>>>> @@ -1657,6 +1669,18 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>>>    		goto out;
>>>>    	}
>>>>    
>>>> +	/*
>>>> +	 * Check whether the lease manager wants the operation
>>>> +	 * causing the conflict to be retried.
>>>> +	 */
>>>> +	if (new_fl->fl_lmops && new_fl->fl_lmops->lm_need_to_retry &&
>>>> +			new_fl->fl_lmops->lm_need_to_retry(new_fl, ctx)) {
>>>> +		trace_break_lease_noblock(inode, new_fl);
>>>> +		error = -ERESTARTSYS;
>>>> +		goto out;
>>>> +	}
>>>> +	ctx->flc_in_conflict = true;
>>>> +
>>> I guess flc_in_conflict is supposed to indicate "hey, we're already
>>> doing a layout break on this inode". That seems reasonable, if a little
>>> klunky.
>>>
>>> It would be nice if you could track this flag inside of nfsd's data
>>> structures instead (since only it cares about the flag), but I don't
>>> think it has any convenient per-inode structures to set this in.
>> Can we move this flag in to nfsd_file? set the flag there and clear
>> the flag when fencing completed.
>>
> No, there can be several nfsd_file objects per inode. I think that'd be
> hard to do.

Can we move the in_conflict flag in to nfs4_file? I think there is
exactly one nfs4_file for every unique inode in use by NFSv4 clients.

We can get to nfs4_file from:
    file_lease -> nfs4_layout_stateid -> nfs4_stid -> nfs4_file

-Dai

>
>>>>    restart:
>>>>    	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>>>>    	break_time = fl->fl_break_time;
>>>> @@ -1693,6 +1717,9 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>>>    	spin_unlock(&ctx->flc_lock);
>>>>    	percpu_up_read(&file_rwsem);
>>>>    	lease_dispose_list(&dispose);
>>>> +	spin_lock(&ctx->flc_lock);
>>>> +	ctx->flc_in_conflict = false;
>>>> +	spin_unlock(&ctx->flc_lock);
>>>>    free_lock:
>>>>    	locks_free_lease(new_fl);
>>>>    	return error;
>>>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>>>> index ad7af8cfcf1f..e7777d6ee8d0 100644
>>>> --- a/fs/nfsd/nfs4layouts.c
>>>> +++ b/fs/nfsd/nfs4layouts.c
>>>> @@ -747,11 +747,9 @@ static bool
>>>>    nfsd4_layout_lm_break(struct file_lease *fl)
>>>>    {
>>>>    	/*
>>>> -	 * We don't want the locks code to timeout the lease for us;
>>>> -	 * we'll remove it ourself if a layout isn't returned
>>>> -	 * in time:
>>>> +	 * Enforce break lease timeout to prevent NFSD
>>>> +	 * thread from hanging in __break_lease.
>>>>    	 */
>>>> -	fl->fl_break_time = 0;
>>>>    	nfsd4_recall_file_layout(fl->c.flc_owner);
>>>>    	return false;
>>>>    }
>>>> @@ -782,10 +780,69 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +/**
>>>> + * nfsd_layout_breaker_timedout - The layout recall has timed out.
>>> Please fix this kdoc header.
>> I noticed this too, will fix in v2.
>>
>>>> + * If the layout type supports fence operation then do it to stop
>>>> + * the client from accessing the block device.
>>>> + *
>>>> + * @fl: file to check
>>>> + *
>>>> + * Return value: None.
>>>> + */
>>>> +static void
>>>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>>>> +{
>>>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>>>> +	struct nfsd_file *nf;
>>>> +	u32 type;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	nf = nfsd_file_get(ls->ls_file);
>>>> +	rcu_read_unlock();
>>>> +	if (!nf)
>>>> +		return;
>>>> +	type = ls->ls_layout_type;
>>>> +	if (nfsd4_layout_ops[type]->fence_client)
>>>> +		nfsd4_layout_ops[type]->fence_client(ls, nf);
>>>> +	nfsd_file_put(nf);
>>>> +}
>>>> +
>>>> +/**
>>>> + * nfsd4_layout_lm_conflict - Handle multiple conflicts in the same file.
>>> kdoc header is wrong here. This should be for nfsd4_layout_lm_retry().
>> I noticed this too, will fix in v2. Kernel test robot also
>> complains about this.
>>
>>>> + *
>>>> + * This function is called from __break_lease when a conflict occurs.
>>>> + * For layout conflicts on the same file, each conflict triggers a
>>>> + * layout  recall. Only the thread handling the first conflict needs
>>>> + * to remain in __break_lease to manage the timeout for these recalls;
>>>> + * subsequent threads should not wait in __break_lease.
>>>> + *
>>>> + * This is done to prevent excessive nfsd threads from becoming tied up
>>>> + * in __break_lease, which could hinder the server's ability to service
>>>> + * incoming requests.
>>>> + *
>>>> + * Return true if thread should not wait in __break_lease else return
>>>> + * false.
>>>> + */
>>>> +static bool
>>>> +nfsd4_layout_lm_retry(struct file_lease *fl,
>>>> +				struct file_lock_context *ctx)
>>>> +{
>>>> +	struct svc_rqst *rqstp;
>>>> +
>>>> +	rqstp = nfsd_current_rqst();
>>>> +	if (!rqstp)
>>>> +		return false;
>>>> +	if ((fl->c.flc_flags & FL_LAYOUT) && ctx->flc_in_conflict)
>>> This should never be called for anything but a FL_LAYOUT lease, since
>>> you're only setting this in nfsd4_layouts_lm_ops.
>> I will remove the check for FL_LAYOUT in v2.
>>
>> Thanks,
>> -Dai
>>
>>>> +		return true;
>>>> +	return false;
>>>> +}
>>>> +
>>>>    static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>>>    	.lm_break		= nfsd4_layout_lm_break,
>>>>    	.lm_change		= nfsd4_layout_lm_change,
>>>>    	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>>>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>>> +	.lm_need_to_retry	= nfsd4_layout_lm_retry,
>>>>    };
>>>>    
>>>>    int
>>>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>>>> index 2f5e5588ee07..6967af8b7fd2 100644
>>>> --- a/include/linux/filelock.h
>>>> +++ b/include/linux/filelock.h
>>>> @@ -17,6 +17,7 @@
>>>>    #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>>>>    #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>>>>    #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
>>>> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
>>>>    
>>>>    #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>>>>    
>>>> @@ -50,6 +51,9 @@ struct lease_manager_operations {
>>>>    	void (*lm_setup)(struct file_lease *, void **);
>>>>    	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>>>    	int (*lm_open_conflict)(struct file *, int);
>>>> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>>>> +	bool (*lm_need_to_retry)(struct file_lease *fl,
>>>> +			struct file_lock_context *ctx);
>>>>    };
>>>>    
>>>>    struct lock_manager {
>>>> @@ -145,6 +149,9 @@ struct file_lock_context {
>>>>    	struct list_head	flc_flock;
>>>>    	struct list_head	flc_posix;
>>>>    	struct list_head	flc_lease;
>>>> +
>>>> +	/* for FL_LAYOUT */
>>>> +	bool			flc_in_conflict;
>>>>    };
>>>>    
>>>>    #ifdef CONFIG_FILE_LOCKING


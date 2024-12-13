Return-Path: <linux-fsdevel+bounces-37349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669E9F1370
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646AE188D597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766F1E47AD;
	Fri, 13 Dec 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QFkXCyLh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v3ww9Sdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307718C004;
	Fri, 13 Dec 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110172; cv=fail; b=D6nIQOD2qdt66ZazmdY5CGtLPq3e7Ccg9ZJjvGnWcAy3+73BBtTScYoyP6pCsbiiRYax9W/mrQB9WfDuatnSlLUbQucRjE4HFGB/I1SZdNO/ywq/R9ft/AmF6jTYDl3iYoZkAaHLvXMgZTNmYMFpLtL+iUlPcQxprAvHieksJ/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110172; c=relaxed/simple;
	bh=B69ejQ9aBNJxom1Erf3c+U8QexYjYxYcRHd7s/yHZb0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=krA5etlIWnUsloszN5qRnqxGNm7ZGLTm9aE+gjfJg1/O4h4hOkbJKjUgw6wGlmv/3+3bYQcyitJLOCnpYoZ2iD6nWIrbvLPoeDWa3d3CuF5+xAjt9G5ECL9bdqjUN/HxRIlk3Qis+2LRzxNcfcTRD4Of7qVpctCWbCDdZga0E/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QFkXCyLh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v3ww9Sdd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDjqTV022542;
	Fri, 13 Dec 2024 17:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=O27Ir2o75RBnuQMgnzF+90w5mhbRfwbYX8D9F2bgv2M=; b=
	QFkXCyLhqVWaTwv4kTr3OKvX8NCNE4oAeHnaRMETkA9BBi7JSMq7p7bZpVWuQ3PD
	8Wn/bYzLtkDscecv1G//ZWPXejTk+LN1xrV9aX5uYVw/DdmdqV1QKu4ThfAEN27K
	3lwo05wl2P1KLdBjaBbFw5VPcvsNi8bwIfrlaeS8ZLZguyuDI5JdkFveSN/Yb6ym
	tHiv9wl7Z1zB00jw8gf5gY468NejGstEKnBNNHK8JZYAevDmV7F15lYW2Qyg/ynL
	0THZKdj6/DbXtLvHkcRS7xRk3yh8tGj1+oRDte8rwBuCU5Hur/7bQwLUxLlJAK+B
	oPmoxGW/NsdSFFccGOn2sg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89dnwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 17:16:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGYPs5038249;
	Fri, 13 Dec 2024 17:16:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctkb4hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 17:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l10LpFZz/cGX+2cvQFji+9LEUp6jZdfrUnhcGwvoKE3vytYfDUtaDyJRWWG+Md+YO5xQmyCYnxGA6E39mui/CTpB62e7+G1o3tA72FfIr2T/mXzP8n4X8PDDxZVvdIBb2AC98x2i8HbnUDwjL3LNXSVGb+wyhaBaz8ACRaz51p9GzR3lkBnOmM3FbDgAo4f/Pm/xgB/2E49bguio7m8njn2zJwiJTfnfn+z+IQzVCkFegPk+q6+HzIrNVcP8sosVwqp0b8npzyLvAn1xFRnxMZzkcUPswPuf6sqeu6odoXRPCNjIpF3mjzSNGlxeGW9P+w81L3h/rnOjDt59ub5wHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O27Ir2o75RBnuQMgnzF+90w5mhbRfwbYX8D9F2bgv2M=;
 b=KunF6f+TUIG+59yTVaqs15RVEsxoCSUmWBKBrS25+PIWn73+t/6zD/BpF5ae4xpQXayXWGTy3ep0It51CE/omwQoWxVEG7PINeI5czrLQGCzxoC4UYHsM5WBJHU/Rexa9P49d5R7UdYrFTpbmqlEy5385xftoMysaGUliffjbOp1fRRIltsnHggx9KdFJaBAieq3Gsfflen3PfaHYGpNLo/mz25orUvyuOTHqqgjpeaKiyo4cibGZRhXreGoHqHISuuKjuKuSd+fW6Vk8DWgUKa9xg1gBzWLwhvuLHtUs/W5XO8kgpQ7sq6xYAbQkb5NzBgcKoDE/q/fRLesfyBApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O27Ir2o75RBnuQMgnzF+90w5mhbRfwbYX8D9F2bgv2M=;
 b=v3ww9SddB1FEPl1fqn43fHlwD2U5TXRBzsZ54FJbMUuF4Ap6Z30eTtShYnlb+Z2QPKj2r0wtWfSyUnktUdRHXJMyCmYrMmDFKJUeoHG5CtocDbLDGCA6GuX6PQ4K0gRLzbzBSPfc9+e1WyPC6IWejm7HYZ0/xOeMbPi7zv+3ej0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7918.namprd10.prod.outlook.com (2603:10b6:408:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 17:15:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 17:15:58 +0000
Message-ID: <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com>
Date: Fri, 13 Dec 2024 17:15:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241213143841.GC16111@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241213143841.GC16111@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ce36dd-c882-4d2e-9e15-08dd1b99cf54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1lxTUFnS00wMkZpQmdjOEx5MkkxYktUMnRpTTVzK3Y2SkV6ZDcrVHNpMU5N?=
 =?utf-8?B?dmRmdmZkWkVwemxQWnJTMmRCbWtYRUswcmNwSURkU0JNK3Vrd1pjZEc0QVp0?=
 =?utf-8?B?UFJ5Rkx3NXRKb3k0K080ZWNTaWxsazlDRDk2cldXckt1WXZaQ3hrUnhWYkNT?=
 =?utf-8?B?bG9Sb1hQRTRub1ZlR2dzYmxwSUJldG5UVDZpb3ZEVkFCVkJhcDZueUx2MHRC?=
 =?utf-8?B?Nmh2RWNJcDZ5RFNBUkFNNUxCMERpVmg3dW0yTjkyVUY4MEprYmN6ZlZ6Unk4?=
 =?utf-8?B?b2Z3cTdidHZ2ODk1S1A4MFBsTm8xalFMZHFBZjRZcHN2MGQ5Mm5EeE53QVVB?=
 =?utf-8?B?b0JuK2QzV0g3bDIvUGlQZzUvYXdpRWRrMUYwVTBFa3J5RVRkQW90SGUyTlJn?=
 =?utf-8?B?UjZmdTluMEd6d1JILzhJSUxJSGI0Y0F2dzFiYmt3TXFZVjNUeUVBVzB4NUFN?=
 =?utf-8?B?cWRtQytaaCtYZUhjbVFza0ZMU2lGWC9MM2Z0RVZHdHUyRmZCRDc1U3pEVVph?=
 =?utf-8?B?MnJXZHZBYkZHV1UvNllscnkvcGFUUjZvRXZ5NUk4RWxpUWtyVjM1Y0JRaC9X?=
 =?utf-8?B?a0NVNnBpMGd1d1QrcXcwVTNhSWVzbFB0Uy96Mm9BSUZ0dWZrYkQwbDZ4TEtu?=
 =?utf-8?B?VVNiemZyWWxaVms3eEx5eFJudkdlZDRidElLd003SzgxbitzY29idndoZktK?=
 =?utf-8?B?ZGNjcEkycDl5aUN2bFZKS2lYaU9mbmIxZkxGQ3EveXJOc3BXZGlVS0ZuMVhF?=
 =?utf-8?B?MGE5aGxhQW1BQVBzSldwaTFud09odWk4SFlScjRJL0FnR1lhSUZJZlFOdk5v?=
 =?utf-8?B?THN3T1NoWmRsUDVlMTRXS0F3eWxsTzNJWU5nQ2RhbldUd200cHJhWVRGYnVY?=
 =?utf-8?B?NEZCQWlkR1p3NzhDTFRMT2hkQ3h1SnJvbmhva0ZaS3dUZ0gzeC9pVllwZk1T?=
 =?utf-8?B?QUxNYzZKc3lnM2ZyQkRibWpDdzRBdC9oUWhCMFZZcmJ1Vno4MHI1THBHK045?=
 =?utf-8?B?U2VmUGdySHJEODFGb1hnbDFZcVIreHNmbFVaWU9CZVRQVmwxbWJYbkV3bXV0?=
 =?utf-8?B?aEV4TC93cjlZRjdwTVh2bnVFZEt0c0RhbitjelJPYmxBZFBoZnFvTjNGbGFa?=
 =?utf-8?B?bkZPMTJISHlzemNWSjNkSVgyQ1c5MzlKQTFIZ2NXRVJ6Wm9HVHhsa1BjUXVY?=
 =?utf-8?B?SVVxY0hOVUFzN09ZTHhkYmdtMFlnZ3BBUmxWSlh5RjhXY21XaVVFektndmdH?=
 =?utf-8?B?K1N5ZTRyRkgwNmxVbzdDMEM5UVlveGtTVUVaRmFub2taL1ZIWlhJZjBHL25T?=
 =?utf-8?B?dkRNS3djbkIyUllTRTdMM0pYY1dRdG9uVUpVSENCNEdvM20wWXJmQ2xEZkIr?=
 =?utf-8?B?WGpyZ0IxNWVxZFBYcjBjcC9Uam5xR2dxYjUyL1hrT2tnYi9IKzZwRW5ZRGxk?=
 =?utf-8?B?K05IaW1uV041ajRUQi8vMW1jNzVJWmtJai9VQ2tyRDB2WXRaVUlWL2FoTHVh?=
 =?utf-8?B?NFlXYjdtc1pwenVtSjBURjd2blFTVm1DdVR1QTFKc295WGxQcFI5NFlBaTJn?=
 =?utf-8?B?a29ZTGtMV2R6R3FyWHVsVGFiekJnWW1jckhST3FwZXFXVmZOaVE5aHFlbzln?=
 =?utf-8?B?QUdxZWQxVzU4MlE3Y3BWN1BrWnpKMlNPSVh1OWZuMHdDWlNoeUFZaHRxWmtB?=
 =?utf-8?B?SXFnN1ZYeWxzd2J3SWdWWXZkS2I5c2E0VEE2SWZsdXI5bk1kUWdTNGpPTnhz?=
 =?utf-8?B?aU1PSGdXaGcrV0xsVlFTK0dHQmY3VHZtM0dWSXVNaUhwOVR6T3o1Z0JSbTl2?=
 =?utf-8?B?VHZieTVvTEVMZ1BhT2QzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emtVckZPWmhzY3lYbEJEeWd1NDNKRDZYVlhRWkFkWXd3TVo1WTRIb2JXcEZz?=
 =?utf-8?B?cklGUWZBNnpDeFk2bWxwNFhBSGlKNnhhSkZIV2t4QkRMWFhEcVZaMDJDZU0w?=
 =?utf-8?B?cjhnOGpBQzdiMFBLcmErNXJDMi9VNXBaSUFJMXI2VEtkVXpyMDRMU0NVVzJu?=
 =?utf-8?B?L3FTQmNZWjBYSU1zb0V0dzZqN2FEMDllUkQzc29Jak10Z2g4bjY0UTF1RTlX?=
 =?utf-8?B?ODByam5OVzVtN3ozYndGSUVPZy9Tak14Zk1mc3BwNGFkU0lDNi9vNmJ4THBT?=
 =?utf-8?B?UW4wdDZLelYzbHhlUjhsVThFQmZSb0hpWkQ0d0VnbDU4ZkM5bG5QUHlYN2ND?=
 =?utf-8?B?TXloZXY3dFd6U1ZsemV2YzR4Y29aNFo3RVU1RURKRlNyM0hrMU8yYXlkSjl4?=
 =?utf-8?B?Q0EwWkVqN2wyNWhvaTh2OXMwL1RSbDJNUXA3c3pVYmdTSzdtMlJEVGgvNGdh?=
 =?utf-8?B?NkVMUGw3bzJvNldVM1Y2NjE1cTlGcS9NbmdUOTRtQmpTdytHQjF2V0dubno0?=
 =?utf-8?B?a2pONVFQZUJMMFcwc0lFc2JYMFhYUkVacEliTTNIYStQczJlT1MxUDVFcFIz?=
 =?utf-8?B?Qk5aUStYVDQzVm1xMmx2L1RNeHN1dDExSXFmcjgreTVOWFNPeDcxd3NtMjZz?=
 =?utf-8?B?ckptQ2pUN0RZRnEwUUwwTWVmWHA2U0xyUjVnSUJwd0xCS1ltNUdBYVdFSzRh?=
 =?utf-8?B?RTZqTWVEZ1RtaUdWbDlabGxvK2tCSEMwL1V5WXgvM1hLRnE4NUtYcHhhMC9O?=
 =?utf-8?B?aGRpclp2TXpud2VEbXFDUGUyVXd0aUt5TnZUOXNnbjY2cUxOVXM1OVpBaHJ6?=
 =?utf-8?B?UjNFeE8zVElRSnlwZ0tKRXk4VnIwbElxSWhhN2tQVSttTXVhZnRQSzBMbGJL?=
 =?utf-8?B?NkxpbEJIUkxxWmxpQzF4RXNBZWh1TWVUK3hTdDVVTE14TG1jVUpFQXpjSk5P?=
 =?utf-8?B?OWtnL3FieW5kQTB4WFYwa2x1c0VyMk1mcjB2MU5yT2kvREdXY2lCZ01NM3p4?=
 =?utf-8?B?bEZhWHFEYkdHcWxkVHhDWUFzLzhLc3UreDNQanpCNnFpcDFuaUduT3Zpc1p4?=
 =?utf-8?B?djN3U1pSVlBxQ1ZqNUYzanJBemIzWmNMZ2w3MjNHa1ErOW1IblpEeUJ2L1Fk?=
 =?utf-8?B?cTlnckNDS2MzQVI3bVlsQ29xY1RDTndEMTZLTDA4NXp4TERvc3duRkszNnBk?=
 =?utf-8?B?SFl4WlhNUmVOS3RLdTBZTjBQcUVkREhmazRUOG01QU1IV2FNS3RYVzZRcFpD?=
 =?utf-8?B?bi9MSEZQZ2dCakROTjh1czJtQjA5cHJNOEhISytTNnJ5eEtlUjlTUFlmWW00?=
 =?utf-8?B?Y1poL0ZCaG9UVUlkQjVYWmtEaW5JSGF5TTBWUm1mM0t2a1pkaVBodm5HaGNq?=
 =?utf-8?B?NUF1ZGJQRE5iQjJOMXdxMVRUR1hqd0NNUEUvcVRzckJ4UmY2U0Z3Y0VyeUc0?=
 =?utf-8?B?VjdzOVltVHF0aG1xSGgzc3Q2WDJSeEtGQjVKQUN6Zk0xbW91S2dQajVZMTAx?=
 =?utf-8?B?SlBvdEdwYVgzdUNtcmcydEx2THN4Zm9RSnAvcUN5QjBLMzhFSkpyczlXSkE5?=
 =?utf-8?B?TmpremRQWVB0dks3cWg1dE9UcW1ESDJWWC9qNmJzcGl5eVNjeDRLMys0b2Vu?=
 =?utf-8?B?Szl1VDVXcmxLc0d1a1prbm8raDJ3MUR3RVIxUFB1WWdMTEdWc2MvNC9sS2Jo?=
 =?utf-8?B?a05LUjJFbGlUY2owMWpseWUwcm1BM2pZbFRKWFNSRElhUmsvYjhRNTZ4bUp0?=
 =?utf-8?B?WWdtd3c1RFA4Sm1sT1pYdXBNVlVQOTJIdVBEMHoyQnlOdnNDWFNEU3RPSUUv?=
 =?utf-8?B?UGg1VGVTOGdwTW1zTnU1NHlvV0ZtN0l5bnVIVHY1NXY4RGtod0w5dXZnWVBm?=
 =?utf-8?B?c29VaXJ2QXBJUjg4UVpJblBhK3BQbnRjeUdiSzlMZEdCS0EzTDRjZldIYjFZ?=
 =?utf-8?B?dzIyb2xwbWozVkN5aHFqWU85ekZJYWxqdzh5Z2hiQzUzNlZTQVQzK1pkQ3NL?=
 =?utf-8?B?YWVtNGRabjAxcWlSRFlTNG9MM0IrcTMrSlF4TVRxdUZzZTBvLzR4anlnVGcx?=
 =?utf-8?B?VkRzeWpBT1lvd3JvbVNWRGV4SE93b2xpZUFUNk53dlJPVGJad1VENW5TTmtn?=
 =?utf-8?B?Yi9xc2JrZFJLUHRWdzBSVGwrMUdXQnJjZmRRMkFQeU9TWHlNRE1IMy9GTU9K?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RrW2edHUFgqfGroughS2WOaHzOf9C6HnDK6Gzf5dO3Qbfzay9sJMDrt4JgJ2uKSKQ1nNrssskOvROsOq37GulXiKLvfhi2ckpBR4FOB0TtQpXYqWASoL86mgR7OobFiqCaZZ5Ds777przN1zw85YhCMUpdbfEgCfGp8PLdkDtgz8y4pGRejIdMGZZmgLfjlZBtFyZVECRxwVEbnuvGoa3FYqqSTgqGzB+KtqbXc9QvQohc7wJG2Yx0uGv1THRZ74tcOkDvdbENF9jcYw4t5pIOhFJvEBzA/KzlFGLMqONdisgbmozGXS3DKpaBUQlG/70uZPtWwejP6xrs+5x/ODGtWoV+aFxpJWoy+FbHw/4zIiCIUsKW7b6SZA0tyOfsOIyxUqf68Cyjp7aKE2WSpXrhcX7YSUZlrQO/FaHRW/xxmd9PiAX+RrOMWxdAuM+lAiCRgrDCwbTx7xV3Gb1xngf4WJKYPIpx1EnX+UqhWtdVcE4AU0xhhXjJv6IxSi7JZqK9vtltpQyJxysPNdoTYqcGW0fhqrLtg001mq3Z4MjWvRKI44yVY5ZOTS20xFQ/+yehA7WloRNKbM5H+RwaYSgFYo2gKt1KsKh4s4SP81UPI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ce36dd-c882-4d2e-9e15-08dd1b99cf54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:15:58.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAP3c6SVUfboklCXVxBuO1BgV5VAJeUKFRu7D4MFXXUhD8lFx6RykALAO5CTGK9I6r6M6J2tfgUgIGWv6Kck2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_07,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130122
X-Proofpoint-GUID: eaTZZYMQiQXU-k0ZMPl49CnPb81tKpXx
X-Proofpoint-ORIG-GUID: eaTZZYMQiQXU-k0ZMPl49CnPb81tKpXx

On 13/12/2024 14:38, Christoph Hellwig wrote:
> On Tue, Dec 10, 2024 at 12:57:30PM +0000, John Garry wrote:
>> Currently the atomic write unit min and max is fixed at the FS blocksize
>> for xfs and ext4.
>>
>> This series expands support to allow multiple FS blocks to be written
>> atomically.
> 
> Can you explain the workload you're interested in a bit more?

Sure, so some background is that we are using atomic writes for innodb 
MySQL so that we can stop relying on the double-write buffer for crash 
protection. MySQL is using an internal 16K page size (so we want 16K 
atomic writes).

MySQL has what is known as a REDO log - see 
https://dev.mysql.com/doc/dev/mysql-server/9.0.1/PAGE_INNODB_REDO_LOG.html

Essentially it means that for any data page we write, ahead of time we 
do a buffered 512B log update followed by a periodic fsync. I think that 
such a thing is common to many apps.

> 
> I'm still very scared of expanding use of the large allocation sizes.

Yes

> 
> IIRC you showed some numbers where increasing the FSB size to something
> larger did not look good in your benchmarks, but I'd like to understand
> why.  Do you have a link to these numbers just to refresh everyones minds
> why that wasn't a good idea. 

I don't think that I can share numbers, but I will summarize the findings.

When we tried just using 16K FS blocksize, we found for low thread count 
testing that performance was poor - even worse baseline of 4K FS 
blocksize and double-write buffer. We put this down to high write 
latency for REDO log. As you can imagine, mostly writing 16K for only a 
512B update is not efficient in terms of traffic generated and increased 
latency (versus 4K FS block size). At higher thread count, performance 
was better. We put that down to bigger log data portions to be written 
to REDO per FS block write.

For 4K FS blocksize and 16K atomic writes configs - supported via 
forcealign or RTvol - performance will generally good across the board. 
forcealign was a bit better.

We also tried a hybrid solution with 2x partitions - 1x partition with 
16K FS block size for data and 1x partition with 4K FS block size for 
REDO. Performance here was good also. Unfortunately, though, this config 
is not fit for production - that is because we have a requirement to do 
FS snapshot and that is not possible over 2x FS instances. We also did 
consider block device snapshot, but there is reluctance to try this also.

> Did that also include supporting atomic
> writes in the sector size <= write size <= FS block size range, which
> aren't currently supported, but very useful?

I have no use for that so far.

Thanks,
John



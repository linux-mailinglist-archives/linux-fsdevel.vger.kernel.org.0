Return-Path: <linux-fsdevel+bounces-46554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B94A8B66B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0357A9661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C6242913;
	Wed, 16 Apr 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WU2IZ5tp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QTI+xxKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C81C1F05;
	Wed, 16 Apr 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798138; cv=fail; b=gM60KHVlhEPsBTCoxkI3N2f6lEtRS+X3KlVxLfaPlWo/VWnXLQljiDWcRTJkUgpdhZLnfDYA6J2TuZM+l+iQvcysKdecXIGK6Rl7kC9xcb4pHzgReU369kaVj+xr0bnY5f8evZvtlr3m+4Y0oURsXDpX9ExwXi0WjKhFhNMnoUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798138; c=relaxed/simple;
	bh=4Vp/+KnN1zaIiOArfnSDPd1IflKdkZE9VSN7CIhXqYA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a7XuJXVB9ocAbhstVW2o4nG/sXVcosSsZtn0959/ffGdMMUnDuwsPPW9XkD1jnOLwE/juB8/ef9b5NahJmBuU0tweMEbn99UBa1Bcx6XZqN0lfZUA5YLD1pDYcSpzi+mKAW4xpkCSKiQ4fivV4GifIUVlUDmDp/koN2nctEIphQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WU2IZ5tp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QTI+xxKc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9N04c014614;
	Wed, 16 Apr 2025 10:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EgXDnW0OaKkBCX7ix2w+5FyiBTWc21rH18Ic4c94Tps=; b=
	WU2IZ5tpI6xHgU5ggPEYfEDOXyCFpWQc9lRn4NN7FoAZNfbrysKhzrhZJNTXR6UB
	2qXV2HKrN7B6USefzhJRs92Ay3fp7iwWmruxrSfzlua0F4gVsSfdv/TJTUCmAJez
	UHKftbwb81cpIqnRlzbSLleVve6tuAzEJxXYGRYN/I1HJMotQuA7fpM3Z1k2mQTy
	YMZT7Osjl+E1DM2mK4Qi2qjqX/qoT0ZpcCTPHeg3Gn7sFR7mL0oCFkU2/sOXDipN
	aO3fcPo9pocMO/XNl4RU/6crT0fUuK8H6pJ9KDTLsYnEiN09/hCvOvEMnChitNSu
	EhiknrWPR8hStQmXmg3/NQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944bh94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 10:08:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8ZBMm024730;
	Wed, 16 Apr 2025 10:08:32 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d51mq1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 10:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vuwp+WI3Q2O932581ekXl+HfWOoO2KRtTWmxUWWlj7qkt9qOY+VxxQLVv1og4sxwvV7YuPPUWQcnJmctdSogVdJkZtCxb1AuQpkazECiTq3Jz1rJtiQmtlh9x+FXG4bLCMyFxrYadm9ASlwDZ/aZy3lYEx4DMoh8gIDvU+Epk6yoj2SD/VPIInJnS1Yzi7Bp2qNEtXyzn+/z2t7IO4rgbilVYmkvSkgsUDVlYyOBRjulzPKXjGRReBsyY2sk00CYcHJhUGxbjPy7bXriXK3s3qti1Y3PSLBtXLMNAW3NFyLQFcWGFCeblXQyFO2oFiv0WjKLb170fY0m0por3MTwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgXDnW0OaKkBCX7ix2w+5FyiBTWc21rH18Ic4c94Tps=;
 b=VSPGGs2UyMemmMPi4pr07s3klUOZheTNpmyEIffPVpUd//ZW4PoS2A7UcVmEnoRnKuhnO5HnlJDucUGL/jaGSxSf2G8MrTkeGH/tKx9OVr+p8I6h3/7yxABRUE1vWSuYDIDFpGS0iwO6p4ZrXrhxojXGjVQSTsb3pAItFpLX7CrdXPP8OOOA8jmzCdSItIb5T9KDhrm8dGERgouCaowFBJvdq6P4v9fywb6g9kPyCgwJUWWgF7im3NlVBl+NlZH9W853HCQLIlDTMBag+opPVEM9W9al7u9h7dwxK41NozfC0Ib8SNTJkijMCnZOGMuqHJdovhbQDckeTSDqDmZ5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgXDnW0OaKkBCX7ix2w+5FyiBTWc21rH18Ic4c94Tps=;
 b=QTI+xxKcDfDWDcg9R0adYaUko75jKdKMI232s5AAvrG5kEbXloKN7leaVGIHG+ck5zOTkKZXQ2JiT0k0nIGQI2Z0sU2BQMHuZVWaF+8E31IgL2tauQjLs/he1PaZ/uqy0j9xrNmxPe/2MX6cZ9OQ8XTbpv7XXejh+Idsqm5qTxY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 10:08:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 10:08:29 +0000
Message-ID: <81f0fe3e-4c1a-497d-b20e-1f8d182ed208@oracle.com>
Date: Wed, 16 Apr 2025 11:08:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7.1 14/14] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-15-john.g.garry@oracle.com>
 <20250415223625.GV25675@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250415223625.GV25675@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: aa660eee-13a8-42fa-fbe8-08dd7ccea2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eExVeDIweHZ6L0hOckYwNnJ5TnVyT1BDeUxFUlZxWlhXbVJYODdGMXI3Zm0y?=
 =?utf-8?B?NnQvbnBRT25UeXlyeWtKeUxPMXFoK21sQ1NBYlY0VlZ3Q0xtdnhtbFBqRDhs?=
 =?utf-8?B?amZ2UXJOOW1jZmNOdkNGS1R0RjdEUTc4MTVRRVplQm1VVDBZSGUrZkpjQUVH?=
 =?utf-8?B?bXlubFdxMzhRejdLT2JHM0VGdFprVnMybjAxSGJucnZ0MnZITWRGeEhCVVMy?=
 =?utf-8?B?NTRxVzQxMDFhSFJOTmhPV3hDMDBpcWJNejhwQ0gvYitLRUlnSGs3VFNQcUg4?=
 =?utf-8?B?VVpoVUpUeWdHbkowbHpZT3kra0lKZWw0NHY5WnhJYTFOTUNLR1A3ckhlWkQ4?=
 =?utf-8?B?ZFVjWEk0NkcrWE1ndDFncXo1bnZZdWM1VVJWUC9ESC9QNUgwcmN1SnF6OFNF?=
 =?utf-8?B?MWFzZHNISjI2Qmc2WUpadWNyUFpQVklXV2pPYXNxZzVPd1pNZy9ZQVdnOWQ4?=
 =?utf-8?B?c2RCb2FRQjJBL2QyTU1lRFRMUVhWc3lNeWwvYzBpNWdBYnlaWTZsMVNtc0Uy?=
 =?utf-8?B?ajQ5dE5MK0xNVUdxUGFZUGl3WUpDM2F2MFRqS28xMUZSNzNldjBzWFJXaW92?=
 =?utf-8?B?QlJKeW53Uldtd0ZibTR5OFZwaU43T09KV0J5a1NuRHE1NkFwSW11R3VUMVdw?=
 =?utf-8?B?cEl0b1pVSFpBRVdTVysvTDMvN1ZIV2w0Z2s0TTZtVlRycFZRTlBQMFhTV3BO?=
 =?utf-8?B?N3JqbVJleGZONVFqMFFHQ0pZRVhlRlhPcWExUFhZQlg4emVPMnBZRFlwYURP?=
 =?utf-8?B?T3gyL0JzSWZ0SUZsbmt1WnZKQUJ0U2k5NjIvMjlhRTY1WmVaZm5FS3oxQVBt?=
 =?utf-8?B?MzV1YWFKTjk4SzljTG5YT0haY0NUUXNYMFYxNHhiN01ZZ1hiQ1NndTRIc3hX?=
 =?utf-8?B?RWZPT1dHcm9sTyt6SjM5OE12UmdkRmp1Y2dEdHl4TnR1c3VRWGRnOEhldXFW?=
 =?utf-8?B?NXRtVEw1S05rR3hJczNhSmNRWG54b2tyRGpxMHd5ZW9mZnhiYTJvVE9uT3Y2?=
 =?utf-8?B?dkphUkFyTTRmT2tFMmdKbnF1bFZkck9WSG9xS0hWTnNVNHJnZlo5RkMyTzFk?=
 =?utf-8?B?ZlpMb21TeE5qS0RrRHNsNTFkR2I4SW4yZ3hjVlBsRzNMNU5pV1hnUkJQK1d5?=
 =?utf-8?B?em9PRjdyYjNYRlN5bkF3eGRpdVdINXRXNTV4SGxYTVFlUjJIV0Q0bUJjN3dM?=
 =?utf-8?B?VnY5MGo1aU51aUZUS2s2YmQvdGFKcnlCd09DQlF4Ly8wV1BmcGFrczgrR2th?=
 =?utf-8?B?Z3UvaEZkUzMvcDVWYnVmQThQYXdrRmpOM1M4QUVZUEZXTXEvV014SStXYUk5?=
 =?utf-8?B?djVNd1pNejAzSWN0NlA5N25obks5RlBuZ0Y0akFxR3hNd1pBRXF2QUVVd2Rm?=
 =?utf-8?B?a2FrNVJkeEw2b2ZOMHNieFY2MHcxUVlMKzQ1OGluTXRLZHd4MElXRE1zeHlW?=
 =?utf-8?B?QWRoWWZKNGlRZ29OZ3lYTEhVRzRDUkRCeEJ6YUFXaExYemthcUNlemJyMHY1?=
 =?utf-8?B?aS9IK0E3REIwNGw0WThCTkhyaXlLRGR0MHc2eFlieEpkY05uQUM3eXFQYTlI?=
 =?utf-8?B?MGhuLzFSUFAya1JERjYxN2VrcW5HWEdtb1hMaEU5TGc0V0tFejRxU3NmaC84?=
 =?utf-8?B?VW41UmZsYkJ3TlA1ZE9wU1FPdzVRTGZyaEJIem1OMWpOZGZLYkhxekFwczRj?=
 =?utf-8?B?L2RSMElWWTFoMXZzYkZHS3dFZ0tWS1dzWDRtMnNiNDBDeElmZC91WkZrY0py?=
 =?utf-8?B?bDEyamVNMXBMRnppYUZNWXJRNUVqRjdCUUtjUGYrOU1uc1JrZzVEUWx0N3ZB?=
 =?utf-8?B?RTVJSUxNZWZpZ1ZmdEd4UmVrZXBDMEt6YUd4cnZHbkZhR2hsOHlzVHNvWWNm?=
 =?utf-8?B?WDcwWCtrVGZrd2xHSUVWMGFQd2xlWm8vVFRZemRHQm9TUlJTcFB5SGVkUEFk?=
 =?utf-8?Q?6McFx1XYpVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCtnZEIxQmpKSkpnSGxaREdEd2tLdXQxU05hYUNNL1NyS3pBaHBiSCtlR0x6?=
 =?utf-8?B?b084R1gyTUhhcnFXS2p4WmJDeHVyN0tEdGtvOHUzYTNzbmZBUVZ3RG4wNzN4?=
 =?utf-8?B?Q1V4a0ozZmxBWTFzUjRMeWZ0MHpsRDRBNG8wcDBXc1NFbGIvVEZPQlhmZEdE?=
 =?utf-8?B?UWd0OGdxMFgydlJ0Sk4zQ1JyNWJyU2NvWU1CU2xISjVVWWE5SmRlbCttZk1r?=
 =?utf-8?B?UWRkVnlOZXpkQ3FFRmdJdDlhcEthbThBWVdDakUwYnJJTXZFRnZaOXVPcXBH?=
 =?utf-8?B?N2RFTUcvVjhtdEcvWXp5N2VKS2x1WGRsS1pnMlhxdk5VWVEwdUdsMUZHTmVa?=
 =?utf-8?B?LzhzN2lNSUNKRkFIVzlTSEtrOU9qbkF0MGJPaDZqVis2ditvZWlSL3AwbVNh?=
 =?utf-8?B?bGFWYTdUYmtOdUN1eUVRUVM3UUhKaStld29kSFVkTGc2d3ZPTnRxOUx6Ymxa?=
 =?utf-8?B?cE9vczFLVnJmSk1ua0tQVlNqdFN5dVEzSkFCV2F0TDhyR3ZLSFdSZFR4WEsr?=
 =?utf-8?B?RTBka2ZrNGpnS1Z2SXVXSGlmZzVGeDBtdDVTTDhaR2xzN0NCRzhRZWZGd0N3?=
 =?utf-8?B?OGc4eDMwR2JGYlpDTDgvN1FXVHF2emxPRG0waWFUTUlLdCsvbkR5YnlqWEg0?=
 =?utf-8?B?d3BDWjlQQnFyWUpFNE1Qdi9lNnZPdmx2bEhYYmpVRm9HdjFBbDduV3VEci80?=
 =?utf-8?B?V2ZRVGh3RzJzREdOWVpsYUh1MFV6UXdxNzk2cjBHY1lkKzNEa0xQbmUreUFV?=
 =?utf-8?B?aTdtT2tlM2NEZzNSc3pneUw3bWxWd0pVYy9YeHAxclRwYndzakVBN0VSMHRx?=
 =?utf-8?B?ZUVRSHlTVjhMRThDbmhZbVVhVzRCbThEVzMrVUJmK0N2Rmk0TDhPSTZaZlVW?=
 =?utf-8?B?Mk5PMEdPbDQ4bEJ4VUhkNWFrVEtNeEQzNjJxMGdBUHFWbWt4Y2hCakRQVndm?=
 =?utf-8?B?NGJQTlJwSVZFMGl5NUl3UnhIVmFHNER4YkxQTDBua3VlMU1tOXg5SFcxR1Fx?=
 =?utf-8?B?MW5ZN3RHWlpBYndLQXpYSUN1V25OeXhHZGk2c3hCSTAva0wyR1k1OSs4REhV?=
 =?utf-8?B?dXc5N1JrMkF6UUxWVkZ0N294MkNGUGthaUFuS1pPakNRdGgxbWxLRTl3Y2w1?=
 =?utf-8?B?OEplbDJhYVlscUV6aGNmQnYrQmhjTGp3MTVzWWhZU0k3eC9jQmpTeFFHUmtG?=
 =?utf-8?B?SUVDaThiV2VSWWZFUlh0NHVudTUxR1NiSUxYblpYcE9YdHRRdjhFZTRYdzI4?=
 =?utf-8?B?V0tsZzk4clJrZ2ZIdzFoTThiYjZFdDJyUTBPU1hQa0RLOTVHcUtLYlNrM011?=
 =?utf-8?B?UXpDYmtUN0QvZ0NNSThPcllKOGJ6dnJWK0xIdTFkam1DM1UwSkkrNXJUbDNy?=
 =?utf-8?B?VkdUbnV6ZlVtd3dzcGFCbnZjTDhOQzVLWW5zTjZpQ2tlaGxqTHYrRGlBRkM3?=
 =?utf-8?B?NGRRLzM3ektMMGVrT3VsWFNIYUxMWmwwcitod1lhOHJhMzlIUWN1N1Rtd0NC?=
 =?utf-8?B?N2VldCtWd1JpQW0yWi96dFVuSk1tYlgzQlduR09KYm14M0Erd1U5M2J2Wmsx?=
 =?utf-8?B?L2tPVXd1MmU5UEQvZTJvU2FGYmxGTFFxQnVNODVkUjk3cHExb1ZoNzArWXRw?=
 =?utf-8?B?U3ZNcm1jQS9UVk1vTVkrNUtUT3NCSFowTWdXTGZVdW14R0RwaXgrb1ZaeE8w?=
 =?utf-8?B?RWx1enJWeHlvdVowb1V4Q0pyTEcrU1loWktCVjZiUHQvZnJiN3lOampiNmNM?=
 =?utf-8?B?eXc0Vkk1eG9MMGp5Q2JtVWFoOXFhRjExYlY1R25zNHRORk5OemZ0NmN1UjJG?=
 =?utf-8?B?d0ttaEh2ajdSbXFUUnVvL3BQNjlLemJIMFQ3STI4ejFDVktFWHcvSnpNWlh5?=
 =?utf-8?B?YzBXOUZDTUw3MkkrRDVNR1pnQ2VoRlM2Y1FWYVpGVEZUanlJMTI3eHJHUlBD?=
 =?utf-8?B?RkVWdnFLSXlzSUNWRDdqSE1LcmRHbmRFTTRhdHJZalRNSUVmcmZTOVdLRTlh?=
 =?utf-8?B?UkpMdW9ubzA1Skd5S3MrRFBvekRuL2RLYVJJT0x2a0w1WVluajllTEh4Niti?=
 =?utf-8?B?WWRpWmdiRXFzTG5mT2xFM2gvTEpGS2N5SGR2UTRKZnZQN2JRUk9iMHNUMWtE?=
 =?utf-8?B?NVRCbFM3M3pjbUVKcjhyeGJKQ2IvZXpKOGZkRzUydzBwYmpHb096WTQyMkRm?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZhUNNw6i34VzEAFhk7EwfqKNajHJWwMZES7AIFP8JhRwNyII74Pc/LqaMpsmOhMqZZEuA2doXeYUcc57OTux4yAQP00o/3HJrjlsgznIdgNHuk14kIgIrd4qA02O5Eo7k7t+F+OtNrZTnX/i6VXGzmsD+mdZz/aLbYJTY8H1zHw+8yeKB1Bq2G3OH5ByPjIavmew0ku0NjVziydbH8MpGKAcIpTkc/2ICufB5aQbJHF4HEbyWreJ9EavQrrr++joE2/H45h3fouFUSdj8DOI+A7cEsbhYosXXcQyRZ+v78dlBJ9VSUobh/l2b2wretxAFvfyK2Wf1U81Bw8d1Y53X4HdpdaGoYKtVLdSx2KM3TodwdOuiVnrrYynyI0N1msdepZJDg3swTue1YBSkDghX0BlNy5jZuYE0X08SIlxNeuCNK8FAbh2WFc6SMJmxYx0IgmPcck4OS20COt72LudJDDK/NMHLzPrALkcTsM0VbR3YZwa+R/XwzVK/KcdiCoXjQP/FXPXWeaB2olCZ2G0efMkIeeSZlFrWge+rijo7Aj85/amP5g6JxtxkPmLsKJNi9RkK/0WB0LHpzlh8BEB8NE3HZJjRkf0SLv22vSkK4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa660eee-13a8-42fa-fbe8-08dd7ccea2df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 10:08:29.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRMfaMMvshzXRwcRXiNsur5TZ4NsGCqiRKt3aQBL2L096PCXrZ+qm8DVt1FnisYZ6akdKLphxn63HQiivhNYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504160083
X-Proofpoint-GUID: cYQ268rkF3qAwdlvCfIrGQC1g2drYMxC
X-Proofpoint-ORIG-GUID: cYQ268rkF3qAwdlvCfIrGQC1g2drYMxC

On 15/04/2025 23:36, Darrick J. Wong wrote:

Thanks for this, but it still seems to be problematic for me.

In my test, I have agsize=22400, and when I attempt to mount with 
atomic_write_max=8M, it passes when it shouldn't. It should not because 
max_pow_of_two_factor(22400) = 128, and 8MB > 128 FSB.

How about these addition checks:

> +
> +	if (new_max_bytes) {
> +		xfs_extlen_t	max_write_fsbs =
> +			rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
> +		xfs_extlen_t	max_group_fsbs =
> +			max(mp->m_groups[XG_TYPE_AG].blocks,
> +			    mp->m_groups[XG_TYPE_RTG].blocks);
> +
> +		ASSERT(max_write_fsbs <= U32_MAX);

		if (!is_power_of_2(new_max_bytes)) {
			xfs_warn(mp,
  "max atomic write size of %llu bytes is not a power-of-2",
					new_max_bytes);
			return -EINVAL;
		}

> +
> +		if (new_max_bytes % mp->m_sb.sb_blocksize > 0) {
> +			xfs_warn(mp,
> + "max atomic write size of %llu bytes not aligned with fsblock",
> +					new_max_bytes);
> +			return -EINVAL;
> +		}
> +
> +		if (new_max_fsbs > max_write_fsbs) {
> +			xfs_warn(mp,
> + "max atomic write size of %lluk cannot be larger than max write size %lluk",
> +					new_max_bytes >> 10,
> +					XFS_FSB_TO_B(mp, max_write_fsbs) >> 10);
> +			return -EINVAL;
> +		}
> +
> +		if (new_max_fsbs > max_group_fsbs) {
> +			xfs_warn(mp,
> + "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
> +					new_max_bytes >> 10,
> +					XFS_FSB_TO_B(mp, max_group_fsbs) >> 10);
> +			return -EINVAL;
> +		}
> +	}
> +

	if (new_max_fsbs > max_pow_of_two_factor(max_group_fsbs)) {
		xfs_warn(mp,
  "max atomic write size of %lluk not aligned with allocation group size 
%lluk",
				new_max_bytes >> 10,
				XFS_FSB_TO_B(mp, max_group_fsbs) >> 10);
		return -EINVAL;
	}

thanks,
John


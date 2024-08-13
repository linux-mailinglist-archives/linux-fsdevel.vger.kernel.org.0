Return-Path: <linux-fsdevel+bounces-25804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6A950A67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395FF1C22A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63531A2C20;
	Tue, 13 Aug 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d3v8UffL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i1kJS/L0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A111A08CA;
	Tue, 13 Aug 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567058; cv=fail; b=r8yJb8MFHCPTWU7fSnBVKFbovF5ms+j5z1wZVReQVT5IzAzViBx1LXFH0hHHV5CWHUsjsjvb8A6SbJCnaZN9eL84BiQLVVUAE5V4g5jfbIRgpPLYhoecvBkh1zd30930B+m2OyHMz4L5o4W4uVfvBATOxyTV8ukl3e+0nYa7EzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567058; c=relaxed/simple;
	bh=R4TNwoUQ34uM3y60oye2mjfs3Zbk9ty/bjQsfakBfbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uu868aFiuZIWFvOmqY0v2Kz4nGiKThP8fD9ghjQKtsjkb9QyMeTxeLMFRdW9k3ate2sDl/tTLED0Vfor/9kcAASSEfXCWQKDQYB2dVPSx28XfhkBbJnO8hnBTTXiO78rwqKSAPln+GPFpYANpkmbDyxZ4/fQ8DkH8LlFptP0EBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d3v8UffL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i1kJS/L0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTHn021469;
	Tue, 13 Aug 2024 16:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=uogWhrXDWya1MOmagrwFqyvFD5Xa1n4v4lHkxGsQFL4=; b=
	d3v8UffLwyM3oxXUnJQcp0jo0QODLi4Zh1PZcgut8M7Yz7R5n/tnvvMC6RCgbFDe
	SHua1LFoZNimzAj7SGz8J2SCnYwrm9h4LdTg/bJnXQLAprBREAEs5Gy7hljy32P/
	qXWNneHRt9UBwM4L/ck9t9TYDJ8sMQyYZqg9aVOtJTbYCQD+znRWI3xZLs22ErW8
	/I5ygJc+rDh9+y5NGKteULkxM0IzEJBVhBxMo94JYlN5YJlry70IAljGk+fYX9r8
	rlg/SlMmK+dXWITx7yuhUHcd1hxNKjAxY45buzfswb7L2Uw4m0IkG7DxIt6CkxZ8
	wkU2KuQW9jQ1qq32kwQ+7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wytteery-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGWvco017699;
	Tue, 13 Aug 2024 16:37:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9pe3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nasw1ZdwxxK48ijUHGEm3EggSWyx2VhTUYccX2q6G9c+P5QvOieiiF81phhivnGHrV3RyADugQ+XyfElBml++u3WFvbUUZuToBhpVQRBelqYcvOxIBQ4tVQrf3Vvp5P2ZMjJIGcRJ+P5hD7efx1BM3OjXNRTAXa84AgFTUBDIqc+G4Yx14I0jxc21L2rpM0BHJeq8XyRR1Se4xx9F0SK2DAFhrMx/RXB0DyulH1Rd4kod42qiAWQJaPXRdnQQC98Anmm/D1RgSplwmWgyUdIOVK+zB9jz3GKwW7I5uiO8j3vIkaLE6jHJniwn4df7Wk3hQ5TYJnYTrI2VCT7RnNIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uogWhrXDWya1MOmagrwFqyvFD5Xa1n4v4lHkxGsQFL4=;
 b=SVuBS/rL1WAYzyGVqaP2o3cnAR+Ft94MySVnpG0KrXK9dHi1nm/Z7yxK+BTiSxOhA0P3tagpbmDvhVzRbkdiDfeVMr5LMGrnP8xBQiJ/dZaGF3G16gOag4BpbmwgregJZK5j/Wi33HC7PWXGLJya4bf+bGcXzyicsRxx58deSk+OsK4MpXknph3/a2rvm+h8L+3zUamh8b5Q0VxnVExcr5GlAd2+2L8bVn8SiPvDMF9gUyiRaN2C4omF85eAtoMoNEeKCiBzHssN1jZh1ln7gaHrewziXxPSU6lQQhZRCb2x8wjIsdmLWtkwFHLtspqmkccVjCwTgE3ihfsZivTMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uogWhrXDWya1MOmagrwFqyvFD5Xa1n4v4lHkxGsQFL4=;
 b=i1kJS/L0knJfGFONtRliF5IhlKnstUFCiHjshFsbs0DkIjFWP+J1woLXdz+hbfYdFUq764A9eh1oROS6VGsH+hBYBiCWQUUdOp9xy5yI/FjBLKb1+cbvgEce2w6FPPJeG7tcqXtx0B+bCIbHAghd8fvwBVRVK0gg3fuzr8RDOZM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 10/14] xfs: Do not free EOF blocks for forcealign
Date: Tue, 13 Aug 2024 16:36:34 +0000
Message-Id: <20240813163638.3751939-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: afa4220d-8034-439e-f8e2-08dcbbb6368d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjGa9BaDWzfM5srOlWqUiHYlKTQDxsbMWIFiwtrqjNPRAwMmyLbrk4iqAlG5?=
 =?us-ascii?Q?cuxC9b4X75Zjyygm3te/xy44jLcGaDMD9EhXAH6AzA7p/9HIy1oT1H6uLh3+?=
 =?us-ascii?Q?3RyfVAw2l8yMBRUcKoE+BJNBLhJuPFDTad3EZ+3LM2ky3EFK++j80oUOI0Tb?=
 =?us-ascii?Q?qBLM1Ks4H+aiYHyKyg561t2qs+h03uy9NLDgreYmTDpGYHNsrpVw1Cq0mWUz?=
 =?us-ascii?Q?2EHxevb254KJKhGfy5EdvkRKpvP4MHgnmFzU6E4zPQnmmOVYd6+vGUvaW0pF?=
 =?us-ascii?Q?pA/W7NaIKUVCj7XLEZ7WLN0VrSCL8oWwaYJV3UNcBGdc8EUeMOU9YNztgDA1?=
 =?us-ascii?Q?WkjZ0KSQc6PGeZwSaKaX9yOPA+5nT+Nux9jmAkoZsgapImmV83zhAcmJQBTu?=
 =?us-ascii?Q?MTD7wer10kg9LDcCvx3Qo7xNqOfuTa6OW6WRqUk0AvY73rMLYMubRwr94C1u?=
 =?us-ascii?Q?0opmJlB1Jcaak6IdwYptUZG1NWGux52I4YbAD5goXizPBkkAqrRuJXNN/XXG?=
 =?us-ascii?Q?hLcaA8j2zeEwlbkpuBh7DgXW1BaWr2xi6HVV/ahlm/W4+oFs3qSDmFbS4Q5A?=
 =?us-ascii?Q?hrNOPG3LGi7dGhua0vTvTCaagdXtcKE+Ag45DDR+8/rUjgO9kwIPIdwgfROx?=
 =?us-ascii?Q?nGYeUJpVixh/bQ6yWRR5OE1YxnlhQiTyokoZgcf6nHtM96me17vp87ygYehd?=
 =?us-ascii?Q?DEx4kjxK+QZCkyXiv12eDEiQ5SxOJltGqliNu+RQ1nHMsYIQ5UW8bBM6q4mW?=
 =?us-ascii?Q?Tu9pyBkeTjhJIoAmrHsd4jr2geFocbompWxaNmk1uJPQbYCueu25SbYaVId8?=
 =?us-ascii?Q?VWbpMS+vFkRx9f8uNFN7UqUrQqmMTfDnVUs3BYmtOfAC/FLpYudZh58kS9aA?=
 =?us-ascii?Q?sf9tSr7gt+J6AkOx5I9Bo4uN9OuremnbqZAqEhI43b/lV/1Ilwnn/s/hzIKR?=
 =?us-ascii?Q?OBXrNvMwccmgUJ/NcRwkgkTcZk6EmwiExe4nU1BFWRf+hlUsTVop/INfIHJ8?=
 =?us-ascii?Q?J3k/mOo6xZh6YUih6TtkA+qyj89rN//TAy7Nk/qz1KjyIvMSjDIAgvbjRo/g?=
 =?us-ascii?Q?38QACbUED3NF8jq4311LwaDTvsRGG4FtKcM8DavwovQKdqAzYOnpmqaFmPh8?=
 =?us-ascii?Q?zgmNRvyjHVnY6Yp6H0qHGYpNBV9pXckng6Mkln5QYicWqJbBy7A4r/z/UxcL?=
 =?us-ascii?Q?Rz8kurJaEVxAjeVoa6BrmOsMcG7GdcYk23vMpeaDPMmMchOIKG+2pfK8xfv1?=
 =?us-ascii?Q?s57Ht4SR0VuxEJA99vvErPMxz/hCkD7HBrLc2PPOXDi189KQ7inGjdk65rb2?=
 =?us-ascii?Q?POo81aiinFIM+Ma4iTvrjlwObKm0wGmZx9Qz1a4QnedSfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ag9TKPQOcwceVaYZklCnM3vlnwbRc8jYwUPqmbEg+cOQ8rBU+zbcoCG8y84?=
 =?us-ascii?Q?/JIIO9pQXYJe7s94MKxf4yR9vVjGlVhl9NHkkgTOlVcwDs1mJZGegmBRjsCq?=
 =?us-ascii?Q?5up/J5UqgodDEomz4BLfxr+BWEhs4yLm8ZMRzGZNi5XvBWQH3svcXPnP8OJS?=
 =?us-ascii?Q?jjKMZdOD0ITjBd5Tx+xdCeiat44o3Ge8zNe+0NHq3200C/qDgUni+2LcHChQ?=
 =?us-ascii?Q?65ot1ivf4itSxhe2p6mHgSfNG1ehi42vL1yfnJNfP1NEpdiWnJN+3dg/9gJo?=
 =?us-ascii?Q?lZeHttRfRmeUrngK2/ocbsPeOn15PQWfl0Tnb14r5fsIAD/rkuUulKL5rKAG?=
 =?us-ascii?Q?ub5kxzNf7W6oXLoQr0R2XX8SxFiL+G4/SXv1ckawb/5pN9czPMvf+Ty3qvU/?=
 =?us-ascii?Q?s2rHTXcMcO09FGaUOu63G5+YlVPaOG9WpGLScXeembB9YHP1/ZGJKhyfbZ8s?=
 =?us-ascii?Q?0p0y9gNSGdDmb2sSFx2VMBvE4TgVmeJptmz5WVpEZaEhZqQXtipBtD1fncXr?=
 =?us-ascii?Q?p+piISNnQbBXiBG1p52cSvaahPSX/MihIUat/cnFcoWt8EgDB/CPzBkrrNOX?=
 =?us-ascii?Q?Zc5VqvoV419woXmFgvt+cEe4HvkoCBzvPWBgsyxcTP7oElZiCjTXFxBGwMYl?=
 =?us-ascii?Q?wF6CX5l+n9KtFksRL/Mr9Mv8xaariiCV21IGPQfjRVJwjiZ4P/3lD1vhnVN/?=
 =?us-ascii?Q?9luJu4YX84RKTMxqhOtdnGLU5mNZG73sxF6uhiykJP2jjY7V8WPrMWRUD0Nl?=
 =?us-ascii?Q?lUx1Xdu3yxjIKsxj5oHZfhfGXNTFBsy754B83CDR4YB8K2NtzLkwHiEsOhLh?=
 =?us-ascii?Q?tKy0KMDv47RZ6Ag87SCCzKPJn2e4+mkJ+gx6DY+xy85Z83ucNlXJ6X7Ctq0/?=
 =?us-ascii?Q?3fdZFUtgiSHkiQe7R82rdXKRtn2uJcahpppWOzFFe6rCEOKerFzenU3M1ZSV?=
 =?us-ascii?Q?qYdpRJ/Ybgz09FbkAQ/CAJGC4nSRZ2f9Kebylzz9DKLtmKb49jTVK/a4GsQa?=
 =?us-ascii?Q?J9eGjcaji51w3czPwRwJG8bCvy4EBtMti7NBmED7PSiVjJMA8aEe0gte5ZPl?=
 =?us-ascii?Q?QHEWzhtdFU9857erX6jUiWhD7jYX3RIpgO7juuN41njRaa/gqcaRhcE7H5Ot?=
 =?us-ascii?Q?NhBfzdL35u4Lcw6DS+qtSrHrWTSu1RTuLao+/NPhtCz5/uFB046KNww0xKD8?=
 =?us-ascii?Q?1Wi7jYmu23fa/WTzJN2VjTh9xPaA+CWlTSxcpUpzsVaOJDws60bfrXJSx9Lu?=
 =?us-ascii?Q?l4Prfikq2V4/IWVHWj+MdmF2jrp7GuywVtjPuxoYh9ZVFcv2BLE/jyV+2JHM?=
 =?us-ascii?Q?1spI7Z3NQ0Nn2/2+l5IwvfoMARf4yjvz+4BnV1pIzmbk2Fma6TnsPXw6JGzo?=
 =?us-ascii?Q?ZXSmTT82dqgWK5n1VBa/UejUEmP6d+mlAzKgqRyK7P/OsZ19VaT9noslL98u?=
 =?us-ascii?Q?y+m+93r2A3L1JtSW8HsNZel6NCgOr62UYnDRb1jMBNJ5XOurrYTyRZQxWcp9?=
 =?us-ascii?Q?EqVJ3z6ylDgxPLjNZwF72+iDbILg3sAXyquepIEPiGKT2TKPl/+JM06kw3Js?=
 =?us-ascii?Q?O/tB6o+KLJBlooRiwTb4dxHv3R8XexykyN67PpzZKok8olHlFGmEan+P6Pe7?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y//JxnZpaLw6yWGW+xGLr+ryRXsMRi/JJ+x/JpuzmvF6hLqEEQ3HX/v8F0Xk2ElkGvE7N1omZ/IcOPkK6EblXjH3dXGm4ZwcSKOvC/UIEVYImjJ3dXV6uPcluDA/WpQ/HZ2oJZtMCE0+ROaVUIWeCqwvjK9VATw+KeTOLbH+iFT2C5Oc52hv9zpb7cWpOTcngxLK3FbG5fJXd4ByWKtTTumn8Uyc4BB/xXbZH7V9GjZNATNdT4pamB4JPL5HoiGyGVznHnb+fahIqg6fyjQJLDJZ0uaccf/gstIjjepr/9GwfwKBGcxrpGT5TTFg3CLqZV3APBIrvcR9UQzyhbMLn5n6bdhIlW9m5vMD892h+4Zy5nszYh8ACXGIt6eoPxbFuac89bC4yeqL1hr/gPwAMMiOlkMbNbJOEay5rpAysfa/zBbXMmYdvKIE0auzNaR1v/SwMd+KeS5V5u8mqJIqt4nMwMUkCVFjdbyuVbmcsaUs3IiLzMkk4ykfUmQEmmpyp0h3vIjYwNSOkmR//GIQ7DMuokw7xsmM9BU7fZ5errkSI+KbdQYe3yR+M0i0awGMkjxZmK5dAiiHP1d1p48GguyG89+nL0EU1/g631pVRuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa4220d-8034-439e-f8e2-08dcbbb6368d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:25.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0RHGQ3eX2+AVxf6Of67/wnJU3mS84e1heBbRRd2KCyiYkpbej5JrHZJ1J1r1dMomoCL65Up2R+lZwJ+AxLWUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130120
X-Proofpoint-ORIG-GUID: B0IlbtRFsZRFG8SyfZKrMIigGnS_MekA
X-Proofpoint-GUID: B0IlbtRFsZRFG8SyfZKrMIigGnS_MekA

For when forcealign is enabled, we want the EOF to be aligned as well, so
do not free EOF blocks.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  6 +++---
 fs/xfs/xfs_inode.c     | 12 ++++++++++++
 fs/xfs/xfs_inode.h     |  2 ++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fe2e2c930975..7a51859eaf84 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -536,9 +536,9 @@ xfs_can_free_eofblocks(
 	 * range supported by the page cache, because the truncation will loop
 	 * forever.
 	 */
-	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (xfs_inode_has_bigrtalloc(ip))
-		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
+	end_fsb = xfs_inode_roundup_alloc_unit(ip,
+			XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip)));
+
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
 		return false;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 5af12f35062d..94ab3f4d6cef 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3129,6 +3129,18 @@ xfs_inode_alloc_unitsize(
 	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_fsbsize(ip));
 }
 
+xfs_fileoff_t
+xfs_inode_roundup_alloc_unit(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		offset)
+{
+	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);
+
+	if (rounding == 1)
+		return offset;
+	return roundup_64(offset, rounding);
+}
+
 /* Should we always be using copy on write for file writes? */
 bool
 xfs_is_always_cow_inode(
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 158afad8c7a4..71acddb8061d 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -643,6 +643,8 @@ void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
 unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
 unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
+xfs_fileoff_t xfs_inode_roundup_alloc_unit(struct xfs_inode *ip,
+		xfs_fileoff_t offset);
 
 int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
 		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
-- 
2.31.1



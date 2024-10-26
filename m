Return-Path: <linux-fsdevel+bounces-33014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D574C9B15E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044011C214DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD91C175D;
	Sat, 26 Oct 2024 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q/KnNi3u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UVBJ97sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A871B4F39;
	Sat, 26 Oct 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927543; cv=fail; b=f2IWlL1L5hJJnpuKgBO4HkPyzyziuRFndMMXtC+G4OCxk5OQVtEgkSk4iwx3NLx5D2bV9zsjSfz8KradBEkkCuUdnyeACW8PMcRFm/LBr3GK8nQFqlTRvmPxWTGt1/Ef3FU+cd3U7Uv+b/V0Ij/aqSjupWolamTsZTe9yFbImyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927543; c=relaxed/simple;
	bh=nmd33tz+RsvGErxgfURnJZUoF6Jk9JXr5vUjQjkwjU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oVeD+rjyhM0jTExW/ozu7rgUtyor2/TRQMzBLmiw3dF9wUDLb4LSH0dZ2emR8QetrTm6MmkwWXqvYV/cWJBBXl1xnqrahKN+4Oe8cPmpqlPUthTuth0XNUjaTxClRKR5VkYurtCJuC3vgj/Hso9JKG5b16vrSoJycY652Y/OiPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q/KnNi3u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UVBJ97sw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q5qHOd017637;
	Sat, 26 Oct 2024 07:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wY6kdgChMItf6mowLK+7M+e6qDkjxAzv9eXffTxVzSk=; b=
	Q/KnNi3uK/iBAMboyb+Hdnx30+MrM4tA0kc6D75M0UZLJ/dLx4HY7jEZYSjJ912u
	aL9wUWSsgDzc7g6WM4cNXHc8b8xNHaGvNk2DOceGHp8Po62iOxaDMmw0e9DfFYfU
	AXd9OIY36ovBQ0nQ7AM/l4XbV85zWTiQOWpOc4Qer+5XahLRN6M1lzYGOVPlbMLe
	FN/lnky9q25BmdQuLHPsjCMYwn0qfybbZJRbrOmfTiOrmg0kPtScf8gtG4rfMTa0
	AebA905pN/QMWBg3hwMQQmF17PcLHFSYbFvlSL78+Y6P4oSLIbsx6/XN9ZVeNch3
	cMh/HEI2puoTZHds71KZ9g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8r4r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3E028031353;
	Sat, 26 Oct 2024 07:25:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42gpvacxv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQjCs2PRcNSO33s5Z6P/BuCU3/wHAV6tiwnu9paaRdKS1lXMV6HJTmbNzz8KXOD/724DA3Qstz78AkdxUEpQDX3I4N79kXWdS26H4s0MJPW0k44Wo7wVxvgW4rzIKhRwao9WH+BqMY5cXn/JP7bpRfwrHbkWvzsJuzPDMf9Ae9eSGU1v5CTMX1C3oraHralA0xBFC0FqBYFlsbDByOzFYlBwZuMa6lAzCkV8qoqph2bjKeX87wTKNQAbRgCkP+rP8nUWoIFw+E9rBRNKViI+rCoFIPD6S4auy6YbqEH1sZE6yIvmQ/obU6rRXRNOiVB3MtRttJezaT4OstRuZ+SzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY6kdgChMItf6mowLK+7M+e6qDkjxAzv9eXffTxVzSk=;
 b=kw6B4el9+XyugaUKQ0y2MLJFwcMLBF9tsaqsfArMyAtdBeORNJSe/a0b3LtkSsiEnvVB2MUM1/5nlA0d3FixpmBzpXzB1yu7IqwkFjZktOjIWID3R308yjR9FUMh1DUSCDMqTEZ6PKDIBWL0KDQpH63VMbMbE276N8h1rGJd7ZtlekgAUMai5e5EcmrSUl9jMhov3CY66zaPuEJFC5K5uCs4XcR0eLNLSJsGIKxUQOPi+b7foHD3ku2FJuddqsgiFxkC/ZXFVJp2Qxxli38DrvY9PXW4TbCkSjRCJtZ9m/6arB87V37E62N7RdEAZY/p5Y9eLnTPRZMfeeMg49+HQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY6kdgChMItf6mowLK+7M+e6qDkjxAzv9eXffTxVzSk=;
 b=UVBJ97sw4vcw9F43zbZ1OkghdQtdoHiFBwATXBy6ehabfGpwgXW2bjhHQPy9OslIBGPMp56RLtFPWYawLl7Ud1YNkceX5ErHU8OXxAPvImCR9aD8j/zEFCUg7EBlb+Brg0ckvYEWiLWZAlSnkRL3LQwW9n9dgptOBBlZdIAuhLY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 07:25:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:25:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v6 5/5] selftests: pidfd: add tests for PIDFD_SELF_*
Date: Sat, 26 Oct 2024 08:25:01 +0100
Message-ID: <57394004d602b648818d4a2809e599ea967997f6.1729926229.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: f1708817-4a43-43eb-0790-08dcf58f5a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/XJLk2IX2wKblQwaSTS7Vgyr8Njbov/dziH8lxhCeSow/H8JdR/+q21hIAd?=
 =?us-ascii?Q?iUGtBuPhQHceB+JPZMduax5q51fq/WxMfb1undEQJEUaTnKsg/vs48zrZ8xk?=
 =?us-ascii?Q?ZlGerxhQIALN56LEZlrCgLZgNqKpY2FR7cjGoj+x74ee0EAnHRyD/grEETNu?=
 =?us-ascii?Q?FQIq/6L72l5qfDLleDw6pgE+Rgy4o4QOMxqZDf7phdDHKEP6rWWcn4U06mms?=
 =?us-ascii?Q?iY5iYWywd06Nbkfxk1ERRVPUOlf7pMNObeGTyEr3c0Gvc2znIdr+AXnYOhDW?=
 =?us-ascii?Q?gWc1c0TiGyAmWBrC3AIME4Qx2lQ4zu6Y9ER2bqrNvYkRp0PN7poebR78G0pO?=
 =?us-ascii?Q?loNjcCZq/xtX3utRx2R6G2eGzH1WoTWX9DKzqFsTQJVeGjuyBscwVWuzJYvv?=
 =?us-ascii?Q?qof8gcD5Y491h2xYxpNTDfwLR6SzFU9cLX8Y1DA5S3l3/PEogSY2/YLysrug?=
 =?us-ascii?Q?RZsGcJ14W17RZoNyltWD0XR3kSkSofnavixXz42T5eO9UFwnhI9ajVmb5yww?=
 =?us-ascii?Q?UJpS+akaSVqqiEcoF5DkHSfg4qXja4fCyPf1cCUDN4ySfGWl6WfX8gJt4Xtw?=
 =?us-ascii?Q?MRFgbem1ev3/IMBV7FQhc+YCjaX5Oad3G7OnUefcnm1ZndL1Lb+EfSLP6lQ8?=
 =?us-ascii?Q?sKEk9eL7j4sK+HQZG+7uvwfFRJ2byvqHsbmGJgP79uTeFiAkdL9kvoA1BpNt?=
 =?us-ascii?Q?zxa7BbwdLG+z2cjoULvNWTpmeVtqCdEt7b5gMT2SiF+JzaE/g6TX6Yzm+PdE?=
 =?us-ascii?Q?rR6lvJZf7spDt1aJC/kKUSsYDCu83p7Ya6oKlUzBhJoBSCM2jD89od8jM/mb?=
 =?us-ascii?Q?RgX9yH/Ozzsq93yOVYvhvyg81lfEyg7G6cILLVXvAPXN26USvE+PwWQvCL3k?=
 =?us-ascii?Q?W2+4XjBqJq4/JE9/q9vVOBgrzHr1s5RSPk+/v+7RZFFOVbZyK9unEIjy8DgH?=
 =?us-ascii?Q?loljSxLVf72j6IG/Z4PJ2fL7zavFsjO383nM7+HtLU+nLpIhvFO05FIyg+yE?=
 =?us-ascii?Q?AKq6nPjxaFoo/u+Y/EmF8Tqij13n+cw3O3Qgt6S6wPaKf04M2eBTEVtO/yI5?=
 =?us-ascii?Q?szscqQy76VOT+XZZ558Zz+Fez8jOnIFE114oU4GH0X8gk1sT8tkvK8hwlEEf?=
 =?us-ascii?Q?rJUB7aDKjXcpl1fg/okT+2/lvwzJnEAODG+RDza2x/2Z2wAgAdW+9JdSSS6j?=
 =?us-ascii?Q?dzesyNloKriM/tfQ7osK3mdbv+LCl3TgmlGIxLQuIrja8FFy6sl1TD5KzFal?=
 =?us-ascii?Q?v4/hY+U22C//xKmBv156+xTSZlB3rs6qHF9ncPnXznCj7IEnArL7REmTrwTp?=
 =?us-ascii?Q?3ok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpThJQrw0XMmvxso6xuL06a2e7Ss6EB8iUf1jdMjsDmkKvPe7URNPBfW6Fat?=
 =?us-ascii?Q?126p0jnPQ9TqrEcAGDiYV2fY4TqvXrIZqu5oBbHp68dwmANJMTj2flvnfee8?=
 =?us-ascii?Q?MhIwnx/+sC8OkWda25/TMAzz/MsRwDFOvFJeLl+fxrNDQ06LE6HRW2fV0s7G?=
 =?us-ascii?Q?OxZp5jU5LWDIQRX/XQSsb9aSyHTCn2CSSzjN6Q/bXjPuwfgrrf3yHkUzw3TS?=
 =?us-ascii?Q?cm0s3u/bFXdn+RkoygO8QEtVk7BDWneXSuwe1nd4UggbP/r/vxEsOv02tqkh?=
 =?us-ascii?Q?hzD0a7n4DkKLbD4+yDW5OM//FdnzwTuHJOoUG8tVUsb4VdZ1GKjgy8rKm1Re?=
 =?us-ascii?Q?GqWD6Bdmp41mYBwrxkWZ6CgAV2LSA01Y8hWKGWVtGWfuyy2tpG4c/7OlJnqn?=
 =?us-ascii?Q?dMDkBWxL7xKFUwslkKSVbRY1J3fKHhWRUa1VGFyZ6NbXA9uJni+wA24N3Sqh?=
 =?us-ascii?Q?gjgivl60JJRXbqyfb12dxO6BSqD3b9vGdBYwfVVJ2mS5MJAVLrBe2UhCNd9c?=
 =?us-ascii?Q?PSEhuZ8qQHM9GcqLyezXAwTvSO4WZ4AZb8HnKbaVWeQE209sQDmQOt5tSBGL?=
 =?us-ascii?Q?G9WyvyHO6mVSw4Jv3L+uL4TFAI+0KjI54knEHko7MNjYuKJ3ws6FTuVoop8b?=
 =?us-ascii?Q?Uac4k9FQ3a3JKe2Rt/9mACQLfV5469Zcf5pKhQMDDPueGOq5NaaPC57g3LoZ?=
 =?us-ascii?Q?V2EG2lVwwNdhrkjLNnbNrmzVJIj31Homlgc3rspWBLBPXeldmnxKd91xHPWl?=
 =?us-ascii?Q?D0CX2s7dr6cYq7Z7amZfTdvI60zJ2Eq8knXtDTCB+sO9AmZGJu0Ld0NUiS+k?=
 =?us-ascii?Q?pDeXFSQiLvnFeqj6j5rsHZeODfD4kk6CUy/3dIoDdvzRQC4BEp+VZmaak1QR?=
 =?us-ascii?Q?QpEwMOAIKMa5ZJR50sKC7bPcEO8G8aDjsRtvPhGxrw8yARqK/OKS7IdfLISw?=
 =?us-ascii?Q?EAC0Sew8+0esTuUJN+DzDuVIu2/hjAlf5uf3PasyZmKoC2zbe5CxVreuz2GC?=
 =?us-ascii?Q?PZKf3CP8i8IoznFIWczzLmz4PKdUmg5dRVk3mKFT4Gf9QKS1P9JfqW2ZnD5G?=
 =?us-ascii?Q?Gj+ciEG6CfGmZ4dFKlWPlynJEMCGHzNiC9U1SMx954YP30gvyatV6Yig3fjV?=
 =?us-ascii?Q?POSMYEcjrbmrHA6RRRe4fObdjheMVh5V0eKlxb8eU/nBF3LBLlcHFlf6SWPD?=
 =?us-ascii?Q?e0lC1iWQ75A4FHGWNnys7WjIQArafbAlgACAqMHUfydtVTeTq+ZGs8dNd7SC?=
 =?us-ascii?Q?+3YbYhJf+ljE3yMUn3aJnq/wjwpxagOVvZwNJwm6IU+stnR1/drXAJXN5Y8M?=
 =?us-ascii?Q?dEvb/7OpVm58lDNz6NNBoxvnrj2I4p/tyJYuRL3Hg7hyPJgZsdDuSEDB9xwl?=
 =?us-ascii?Q?fNOK9tXhuFnQGSOkCmq3Zz1RiyO54iRyDxynxhXu2p5s0FUU3s/BW6fqTNhF?=
 =?us-ascii?Q?PMHEjnsu9iYxZaXuJli8olK0oVY3hFAQCcNbPs2V738/5G3PsOeFyNMtsHKu?=
 =?us-ascii?Q?fpwh5PMJ1+5yk04Zhoiu09vgTXsmn4yEQoMgs6i9n09I7TJtgGTFouNHmd71?=
 =?us-ascii?Q?lXZAUo4LuPe5Z2TrkTwGBjxz8oxgeuoKNcmM6WaxJNDYMZDmRK8hWehoorP0?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QYS0daoIaemHEcJsk8wOl253G4/4mWD6RihMpWDmsRrf41UOvQeAO9omN1MT0wZnoc4bpyritK3vIHCoq92vfjHM5JjSgpg2IRZGGF0cxX6zeHyiENq+DK4O4sQKlFwlRYL6oCO5yxtfhuTd3J7uzQcmm5gd0pv2jlPTKqWdQI1ltCDlY4XCdddVkdsYnbTxbKgQC/fYAdL1MlxVRHiMm08ZYOopRY1SnsAWXvzO7AdTGPVF46eMidqDJ6GAGEk7ugMFrZREbkeu30Bv13Ox8ZYo3TOyfuiooa6Fxo+fOXJH9naqR14RwWjoCMKEdg5vQKdTSvw+u1K1Mgp54/UUfxriFPKQbDQOYA0Iw9aWhHVhB2c2noHOQkiaJW9rJWMtLE7flGMvwStiONN4Q2M6sjW7QYgj7hCE+DK9TnrXVXQ5ewKzRK/b3yfJrbxR2HLZM322c0zVndLyGgR7GUwotwlIS63BN7Sxa+8Lb7fzcYe61EcXD80nZPi5ytDWF7kKkA/8rT0iuwzMKEVwigR5lPtrE5pNvUFot/ZI9JUHhYNYP//mhji9+be/HcsTaGptPCB0Pd2DvyTh42oW8RjGKnXDn47iDZybj3HbSE8V4bs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1708817-4a43-43eb-0790-08dcf58f5a53
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:25:22.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTml4uQPcxgERo+OD7jzQ8uwCP6lw63T+s1S9mdXdUhLwcaSXAKairROPcO9twQeAvyV3gebj2C6Did3f7cwjeaGfu7WLyJqm09LVkvAMWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260060
X-Proofpoint-GUID: Imd0_rXcSwhwayZgf4R56LFD8soy3VqW
X-Proofpoint-ORIG-GUID: Imd0_rXcSwhwayZgf4R56LFD8soy3VqW

Add tests to assert that PIDFD_SELF_* correctly refers to the current
thread and process.

This is only practically meaningful to pidfd_send_signal() and
pidfd_getfd(), but also explicitly test that we disallow this feature for
setns() where it would make no sense.

We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.

We defer testing of mm-specific functionality which uses pidfd, namely
process_madvise() and process_mrelease() to mm testing (though note the
latter can not be sensibly tested as it would require the testing process
to be dying).

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |   2 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 4 files changed, 218 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 0f3fc51cec73..1dbe48c1cf46 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include <linux/pidfd.h>
+
 #include "../kselftest.h"
 #include "pidfd_helpers.h"
 
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..48d224b13c01 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -6,6 +6,7 @@
 #include <limits.h>
 #include <linux/types.h>
 #include <poll.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -15,6 +16,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <linux/kcmp.h>
 
@@ -114,6 +116,94 @@ static int child(int sk)
 	return ret;
 }
 
+static int __pidfd_self_thread_worker(unsigned long page_size)
+{
+	int memfd;
+	int newfd;
+	char *ptr;
+	int err = 0;
+
+	/*
+	 * Unshare our FDs so we have our own set. This means
+	 * PIDFD_SELF_THREAD_GROUP will fal.
+	 */
+	if (unshare(CLONE_FILES) < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	/* Truncate, map in and write to our memfd. */
+	memfd = sys_memfd_create("test_self_child", 0);
+	if (memfd < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	if (ftruncate(memfd, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+	ptr[0] = 'y';
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	/* Get a thread-local duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
+	if (newfd < 0) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	if (memfd == newfd) {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	/* Map in new fd and make sure that the data is as expected. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+	if (ptr[0] != 'y') {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+exit_close_fds:
+	close(newfd);
+exit_close_memfd:
+	close(memfd);
+exit:
+	return err;
+}
+
+static void *pidfd_self_thread_worker(void *arg)
+{
+	unsigned long page_size = (unsigned long)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = __pidfd_self_thread_worker(page_size);
+	return (void *)(intptr_t)ret;
+}
+
 FIXTURE(child)
 {
 	/*
@@ -264,6 +354,57 @@ TEST_F(child, no_strange_EBADF)
 	EXPECT_EQ(errno, ESRCH);
 }
 
+TEST(pidfd_self)
+{
+	int memfd = sys_memfd_create("test_self", 0);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	int newfd;
+	char *ptr;
+	pthread_t thread;
+	void *res;
+	int err;
+
+	ASSERT_GE(memfd, 0);
+	ASSERT_EQ(ftruncate(memfd, page_size), 0);
+
+	/*
+	 * Map so we can assert that the duplicated fd references the same
+	 * memory.
+	 */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr[0] = 'x';
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Now get a duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
+	ASSERT_GE(newfd, 0);
+	ASSERT_NE(memfd, newfd);
+
+	/* Now map duplicate fd and make sure it references the same memory. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_EQ(ptr[0], 'x');
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Cleanup. */
+	close(memfd);
+	close(newfd);
+
+	/*
+	 * Fire up the thread and assert that we can lookup the thread-specific
+	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
+	 */
+	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
+				 (void *)page_size), 0);
+	ASSERT_EQ(pthread_join(thread, &res), 0);
+	err = (int)(intptr_t)res;
+
+	ASSERT_EQ(err, 0);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..bbd39dc5ceb7 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -752,4 +752,15 @@ TEST(setns_einval)
 	close(fd);
 }
 
+TEST(setns_pidfd_self_disallowed)
+{
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	errno = 0;
+
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..440447cf89ba 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static int signal_received;
+static pthread_t signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
 {
 	if (sig == SIGUSR1)
-		signal_received = 1;
+		signal_received = pthread_self();
+}
+
+static int send_signal(int pidfd)
+{
+	int ret = 0;
+
+	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (signal_received != pthread_self()) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	signal_received = 0;
+	return ret;
+}
+
+static void *send_signal_worker(void *arg)
+{
+	int pidfd = (int)(intptr_t)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = send_signal(pidfd);
+	return (void *)(intptr_t)ret;
 }
 
 /*
@@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
  */
 static int test_pidfd_send_signal_simple_success(void)
 {
-	int pidfd, ret;
+	int pidfd;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
+	pthread_t thread;
+	void *thread_res;
+	int err;
 
 	if (!have_pidfd_send_signal) {
 		ksft_test_result_skip(
@@ -66,25 +98,45 @@ static int test_pidfd_send_signal_simple_success(void)
 		return 0;
 	}
 
+	signal(SIGUSR1, set_signal_received_on_sigusr1);
+
+	/* Try sending a signal to ourselves via /proc/self. */
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
 			"%s test: Failed to open process file descriptor\n",
 			test_name);
+	err = send_signal(pidfd);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on sending pidfd signal\n",
+			test_name, err);
+	close(pidfd);
 
-	signal(SIGUSR1, set_signal_received_on_sigusr1);
+	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
+	err = send_signal(PIDFD_SELF_THREAD_GROUP);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
+			test_name, err);
 
-	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
-	close(pidfd);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+	/*
+	 * Now try the same thing in a thread and assert thread ID is equal to
+	 * worker thread ID.
+	 */
+	if (pthread_create(&thread, NULL, send_signal_worker,
+			   (void *)(intptr_t)PIDFD_SELF_THREAD))
+		ksft_exit_fail_msg("%s test: Failed to create thread\n",
 				   test_name);
-
-	if (signal_received != 1)
-		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+	if (pthread_join(thread, &thread_res))
+		ksft_exit_fail_msg("%s test: Failed to join thread\n",
 				   test_name);
+	err = (int)(intptr_t)thread_res;
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
+			test_name, err);
 
-	signal_received = 0;
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.47.0



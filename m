Return-Path: <linux-fsdevel+bounces-8716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F253E83A864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB24B28437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B52B51015;
	Wed, 24 Jan 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BrUUxpyg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lhRDiLxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132750A94;
	Wed, 24 Jan 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096514; cv=fail; b=jnSObqyo4CknzG9Zirj2kWvoK/5rsGV5Fy6iWRgXSQR3TdzFk/N1e0hKH8nfeWJb5istegfYnDaGf5s3Pvf3+aIXQuNv9YHdPHq2QfJZJcXpNIy2S2Olb+MfeFhzvrm1TYk8N/HsZ/aS55VBKICb/Dt2d5rlw0Xq0W7Ih/LX0bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096514; c=relaxed/simple;
	bh=S6f1cwkJCIX++aKJcUZ1t+kwWC1MVD9rKmWW3IkMtgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2/1u9YBpVkcqEj5xCeDh//Cwg3Pg+vaZ84KM7UhLtQ32Ur5AqFnAGCCBhfbS/HvmPwrI1fys6I728g5WbSn/tFje7S896NsoLJsYw/a9Jg/S6KN9BT0iQaerhhVEV+3nwMcpUvZNQXGKgi4JeWu3IA0JXi4VQhdgxBE9TOhb3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BrUUxpyg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lhRDiLxL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAxSDD019689;
	Wed, 24 Jan 2024 11:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=BAz30FGSJKBWQdieIPEuEvrCdtFXnCfG/jKd13sqpvM=;
 b=BrUUxpygMY4wXU589Q2673jHxoY+DobQMh+blmZAOQOIHbGnhJTpCan8fJGZVXQx3hwq
 JOQPhgvszmIvT+/ahigJcLibzXRuMOO5d5dBfAcDFzuZ4Z0KS5l7mhSoAp72szdNQ/Po
 MjOxjXdErSx1rbtyT3Hy2pddEwR6sctz+GS4noAwLw/FSlQqFFBVIagreRNESULVbMUp
 gRsD+N1egnnQS9QSZrZOlRwx2LPL9xuOl2C5n4fWaHivRmkgMFJgh1GNaZyJV/+5toT1
 kyXR8OFAvM2RMFV4USkZNeVnm2JzLC3SnI7pDA/+eG3oQskiygzewVBYBSg0im4g7IE3 /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ansx9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBPAN5006158;
	Wed, 24 Jan 2024 11:39:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32setbq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V55suHW54Ua7Rki+sURSc+xJF/LYClsE6s9oJUbrDkw/B1wo9Dh5WN3CzbqKJ23cul/E6iG/H7tB+Vey0RL5x6a8nLulmO/QmwYVY/5iWXe6ezfZKo72ZiFI6zK8uMKnN4J5bkmtQcDmBYWc0iRRYoPWQJQZnZNl6cJLfOLDeZI9ew0lI4CIpAu8ikLS+2SUJfZw0D2Bo+KEH7RtuLF9xGZfCCbu+xDYlccwyj4SlCpZbsl0/oUD2er5pQpdifh0VgNtwMnYTOcEVeO8BjfwHPrn7VIL6pDTF9JLRpsUY4oTtMEbou+cukD6SPViNsY7zVuUExKFFBtedAPGFS51/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAz30FGSJKBWQdieIPEuEvrCdtFXnCfG/jKd13sqpvM=;
 b=TFjhNKkHV7yydzEmXaUNqCG1IIhQQwAEHXnq1wlqqg6eAHZg1ZfJ2i7i9BLKbAkd5aTdGSpp7TP2BPa+JWJG22jPBbnEBUjM4ao960SfSZ7HnYjW42Dtk3rWGDDpB4erPj+IHtB/v3qC2x19HT2OgK6z7CAeYpNg+hDOPnZDFu7BnVD58uuQuCUgP1evS/NU29zBkaP1ZOqp5hFCKT7ETdrujMJ7rlq4J67JxDu3c0mCrNi+ZGmWtFshyeb057aDZJF32tLqRaprxaNMDX2j3IrnP1N8w7ruPtsPjxISYOs9c5wJ7reFs/YySryj+U/Dn+X+YzmJztudgdxAgk9hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAz30FGSJKBWQdieIPEuEvrCdtFXnCfG/jKd13sqpvM=;
 b=lhRDiLxLaIT6ftXIap+JckQk9cz2Dz2dqU9+SKd1kIjyFPb6QdFFPVNtlbMYNnk1OAHzngArTiclAiQCVoqKXwGP1mW7ie1il6tCIjCwHrMDv9KYQ6AUb6CqLGfIEULXov7mMQGAUO9zRsL00WNLZJyNzlTR0bhT2eHaol3pS8A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 14/15] nvme: Support atomic writes
Date: Wed, 24 Jan 2024 11:38:40 +0000
Message-Id: <20240124113841.31824-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0290.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 468739b1-6f45-4f62-76b9-08dc1cd11d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4GoE8z//j/3QIFIHJgwZgl7aS9Ve3AmfGVEx/ImnPrMrCZjCUt3jL1SyRmR9OaYbyOiA/W5jxi/mRmJn6cZEIevUg93RcBGGTrUtymHqJkt95u2Uka00R2V62kH385yJYuL+SI584TVhLmhg5FI+P97N9/gC948HNUKA1KfsVLBVwClSyKLmzUyP3R3BkDExCixPfmm63Rj2LbkydiyOZ8TA7udC846IhiCRhOnAtCuFP+wvkQHbqCU6yjSt5kTgnLBobs6msg5do7lDFo7woMxGSKtFwCybSI8PUwFDj8Cs+MyXZrE6n9kaMOkex4ckUvlw2qzLoHyWB4cUNncoyed+JV/0yLFH9878+HN5I8kBiCRW9SO7q4cWzrTBspD3VIn5LSYTAmiaqZ8Sf0YrLYofLIgJ+QYhI1AEEJJVjpWKdCRQNPY4D4dxLD/JCDCPTfj7GdpewxueE48QYQvTQsfCiiKHStXmrDRodNBJDyzljleFQAxetjKvsw6q5cDcECnpz3xN6V4yrWr8ywDhBaLBKfs+MfuaDM2ZJjb2JEny+18nOwbA0SMjA10kW2U0bhrvt7CuIL6aAxN/zjQu3qJXJX1ItpKbQ/u/yBAVQEU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(1076003)(6512007)(107886003)(26005)(2616005)(38100700002)(6506007)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(6486002)(478600001)(54906003)(66476007)(66556008)(6666004)(66946007)(316002)(921011)(36756003)(86362001)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wGRijSKK82H/jaqh3sLfp5JQxNIKUpXmZdCXXj0Dk0T7uCSxMw9W/LtNF9WM?=
 =?us-ascii?Q?KPuMYxMio5b0RJ8Mlb/pW53OVpXWYE3YXlrDOBoe+EwbGY7ffOUUTQjOQBMd?=
 =?us-ascii?Q?uZ52lZ1MC887Nr7TuEzV8gsTzuoWml9Omxsvt5CyIkJbPTwavWOlotXB+cyp?=
 =?us-ascii?Q?U478VQOLF/InqWUZL0q3QkhaeWa+/6fQN8I23VWeR56u4cKZLmimx8JNeEsK?=
 =?us-ascii?Q?oL3Hujd7I5DzVStEdNp7DRb/bX+B6DBLJ8ob1hQoV6S5mmu2Om2NJ9BfGbW0?=
 =?us-ascii?Q?MbWyhOuFraBxuC76sQYKbT+xXuzWshY9mHtAeIfpSzkUhVrLQ51FCp6vjgct?=
 =?us-ascii?Q?qoym3mPp3/csQi/X6cj1nPqMZjb1jXzSGN6h6y9qzx6BY0Ih64i+MSW6GJMB?=
 =?us-ascii?Q?QbpKirY9fo9+EdpIKQDLS2W7Om0BgI6enay8u6g/HgqbFjp+J+L2K17Gb+8c?=
 =?us-ascii?Q?ApIRGCsK9TA0jyMh9vUapYcM2pDz5P8vHuoxiC56cURL4J2GB/sbBviGMFNB?=
 =?us-ascii?Q?2wVwtAtMCt3sAyra3qMcrYifvWG4LcHgvR3ifOoPzPkZLAQWvMSoizR++8be?=
 =?us-ascii?Q?O1yFnKQLp18KuNEsYXxPex2OYCiCa8kFKaWGNKlilK7gyK/oDhF3S0dVjrxs?=
 =?us-ascii?Q?IAChRvz7RWY/yOC6cGoN7uH7Q7Mv1KhEEuuA9vJK9uiYAGNz1gJ1cvx/D5KU?=
 =?us-ascii?Q?AYD+fbwoDNpkIyb1cCsoDpyOOxm2Jq0kv2bnjLq88kNYhu+GdmW1OGpjESx3?=
 =?us-ascii?Q?Xaal4PMQnEB8dcwWb2eSw6ndLnatRRcZQ1hqFKq0W5Mq0Ob4V5P0b215zmJg?=
 =?us-ascii?Q?pt6JjMmLGOWtT1EvuW55bl9bdRtodpNNkr8f6aUsvCTatso4h8P0SZeY9yPQ?=
 =?us-ascii?Q?pqgBx8nsxRVLjaakA91H1T4vYxfrXHYDH99iC7DbqnYrEJc6QdxrDWz9wI1G?=
 =?us-ascii?Q?4MSE7sTFuIfLYzMhoGIFtvXPhKwd3WZh1j26vIbWykSG3QRHD17R8oL+7SB1?=
 =?us-ascii?Q?476KB2qQTCR5Rz8VYtBN7Xltf6gtJbbRLYhBJ2V09OlmX8kCEaNXcJ8JJvBE?=
 =?us-ascii?Q?UpKPaOM1f11drYHWYwihqz+Uo2li6+3OaiylB38s1Hey+00z5J2qUOdQjyiC?=
 =?us-ascii?Q?F5nhsIpi8XxJ5dCLPYc+1QEgvpIo0abwkVUMn1t1X1yebnBqDyExHpYwmUb9?=
 =?us-ascii?Q?o6hMluxAfjpKUJZQwWer4tIzUET+LNXks2uvd9cTdX1EzWqY7u6PnTma8Zzs?=
 =?us-ascii?Q?+iaqjYLTrRtiyrc3Kv9lD3/d65AN8whwCAGlcTy5FeCjyhNVVFvvR7dcvBJc?=
 =?us-ascii?Q?25n32qtsZHbcIEOkIrvha+NfTxiU/Do9yJQwOju4pV4AKptQbGS54HfyWj+w?=
 =?us-ascii?Q?TCB1jyPEO81KEyAAbj2Oc9pzJvYi494ft/xezzbaz9UWVSugl4Vk5RNfpN6U?=
 =?us-ascii?Q?wGuiN/23/lKsC9Dfrn66giOXEGIqoi5z8koyGv6rm6PCS+TeaRL8yXhmIogU?=
 =?us-ascii?Q?MOGEz7RQKANldpU4GuSwd47q1HDqUchUM1t7ta3Mq8bMFUylyGIVzGt0cCwy?=
 =?us-ascii?Q?PwQB07Jq8GlnwkprTW8YHsCs2ta/wsj8Kh8D18G6xksDHCQxNZ0zhKbi1RKJ?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yQKTsQYE7OYh3bAbKBAxsQYptkiQL5TkL6+H2alcMY9oyzxVI02ZJ4S+arGZHTxbmvHNVhIFO0OJF83zcOyTfR/odi+y8rdRZ5787nqgNwXW474N/zRMoPhJ+GsG6ufg5wybOkArB8hHHkkYpit0EfOOKOPy1J59azrfrqCweItu+848ZYA6sSe5ePlJSuQlI3XEIFR+5+Zmdm73jww00S86HZHYkicMbGFY8YAc4kwajpQYcLoHyAzbl5FSBJrKyClGNibppDz6caMj08OtkFlYH7CqSmR4GGS12ijbTLuQNtWwKKoI+azVW1/SiCVSjslE0Hus+sCGJEDjSACAAdzp0u/Gwn3MoAW51Cq6eyUHgt+yPA74FaGM74279ogY0AqAaf7o9/QAM2NDCKecoqfsV1z3upGxUsJpCvhNOtxgNKZZ2uHpF0Pk/u37tdt0iWYZ9IxK/czMuJkHALamYQ9BYsU7OPlarhVJe1M8aOcuQjHHFgCy6ySQXV/i2RwIIqR8b6DsMqUBCSo9jXK5DYH2pvfcQpxvM4G44Hy6aDtBK2oO/rVI28kZz2YZYjYRkMkc3+exW7Pj3UMVs7hq33Dl31+P1KrvwA/7Utbiakk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468739b1-6f45-4f62-76b9-08dc1cd11d0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:24.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF3zqRoFschKiVEqXAijQzDHHdb7k8Tt5txIOnzarqj0qQOBB3AGf3vv4E0yY3YK4TzRafTSf66QAbk2XO4kQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-GUID: ubca-UJOmyGm77r0jJ8vO84Sbo6DBAjt
X-Proofpoint-ORIG-GUID: ubca-UJOmyGm77r0jJ8vO84Sbo6DBAjt

From: Alan Adamson <alan.adamson@oracle.com>

Support reading atomic write registers to fill in request_queue
properties.

Use following method to calculate limits:
atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
atomic_write_unit_min = logical_block_size
atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
atomic_write_boundary = NABSPF

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
#jpg: some rewrite
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..5045c84f2516 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1911,6 +1911,44 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
+static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
+		struct nvme_ctrl *ctrl, struct nvme_id_ns *id, u32 bs, u32 atomic_bs)
+{
+	unsigned int unit_min = 0, unit_max = 0, boundary = 0, max_bytes = 0;
+	struct request_queue *q = disk->queue;
+
+	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
+		if (le16_to_cpu(id->nabspf))
+			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+
+		/*
+		 * The boundary size just needs to be a multiple of unit_max
+		 * (and not necessarily a power-of-2), so this could be relaxed
+		 * in the block layer in future.
+		 * Furthermore, if needed, unit_max could be reduced so that the
+		 * boundary size was compliant - but don't support yet.
+		 */
+		if (!boundary || is_power_of_2(boundary)) {
+			max_bytes = atomic_bs;
+			unit_min = bs;
+			unit_max = rounddown_pow_of_two(atomic_bs);
+		} else {
+			dev_notice(ctrl->device, "Unsupported atomic write boundary (%d)\n",
+				boundary);
+			boundary = 0;
+		}
+	} else if (ctrl->subsys->awupf) {
+		max_bytes = atomic_bs;
+		unit_min = bs;
+		unit_max = rounddown_pow_of_two(atomic_bs);
+	}
+
+	blk_queue_atomic_write_max_bytes(q, max_bytes);
+	blk_queue_atomic_write_unit_min_sectors(q, unit_min >> SECTOR_SHIFT);
+	blk_queue_atomic_write_unit_max_sectors(q, unit_max >> SECTOR_SHIFT);
+	blk_queue_atomic_write_boundary_bytes(q, boundary);
+}
+
 static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		struct nvme_ns_head *head, struct nvme_id_ns *id)
 {
@@ -1941,6 +1979,8 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
 			atomic_bs = (1 + ctrl->subsys->awupf) * bs;
+
+		nvme_update_atomic_write_disk_info(disk, ctrl, id, bs, atomic_bs);
 	}
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
-- 
2.31.1



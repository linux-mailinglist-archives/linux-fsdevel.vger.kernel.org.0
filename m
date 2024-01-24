Return-Path: <linux-fsdevel+bounces-8712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD4F83A850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AFB29628C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F42C696;
	Wed, 24 Jan 2024 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ep0yv8y/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mGQGCCYZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36521AACD;
	Wed, 24 Jan 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096440; cv=fail; b=XcMPkHfR0wGQLtgeUyJu7wO2eDfjr9qt3b01YK3qMBZ+1qi5kIdP1uq1x5NQw2DaMp1IjGXGa2vgV1nJx5rnpabLRi9IOzxQ8CwDX63eoBjHqADljBVf3bpJ5g+q9ZXvSJ+zd5hpz/GudN6ImXgttlk4BsyicWcGDNdaAdcE5hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096440; c=relaxed/simple;
	bh=toR9iL+t8mTkuO3FjPDFegghwI50RoiC9kcncLg0+/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FxYjtgw/syxn0YK3QVkiOPizaON47nwCwsvO6FCBt+ExEyXpdpp+Q7nutZhLwm3B2xpGA2IDldvDVwhCQYXEmQX9sH1GC3a9TVS2FPaIR6QybJ+az+z3mKvC17MFDpufzEGGzQCw3hfAgRiJ5149hy1ArLSMqoqcuLe1TheEzKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ep0yv8y/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mGQGCCYZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwiDh019763;
	Wed, 24 Jan 2024 11:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=rGq3Yj4y89tvii5vJ2UgFo9EVo2/UqGJONVuMZeJncU=;
 b=Ep0yv8y/3BMU62Z9FQFcBu2l0RSOsdml2bK/+MXzwuzegwJFzIAsq51C9kPKAiZVHnn6
 Ayfac1jdg5pEZxlgruv3L+MaV/T75SQ7C0BgZos0vVIttC8N9gflQXeZJz0/cRYuKlVM
 mYTTHy+0X7G506vB4N3RyO80f8t6cOKSTjDg7NOJnNgRld5+RrjYnFmVuGQrxCRBoID4
 KaZggQA9+nO1zes4e3c5+UAmhfjCJ6k5RJ8AUdgjptdykLUAaGtJbmeQYXox5jbQyT83
 qtcT2ZtSthjRXEtX36Vb6T9ALCVB4xy5rxyqVBshqlVGBa4u9d3hFJYh2T9JMEXaK6J/ tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w262r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAobaG040723;
	Wed, 24 Jan 2024 11:39:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs316wnws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7HNqn9T0WJ1tCTKdrQOJWg4hEZ1G5iBl/ZEFmHLMOs/PB1tJU6R8L8l0idvjEU+TKXQRFoYNcftfSQMjD14nTjRV1jUdZsBKHTeeS1lhnHxvv5MpG9XrScdp5l/ayog71huGQthAgGGRwZkghA7rEehKF/vnEq6shEL5xEIYWlIdu2sNJPs/tSZ2Ce1kzkxn+s0pDSNLQtr31aocRCeio7emitwh/Pq0vcqP9nd3pFTSuUoDPpthTO3NkehzFdTr7Jh3XVetMlWYCn2qctFCrFtfi9NFd79WX+CvNzzs4+LqPiN4M4LpOz44uviHaa5ZKYSULx5nyK+O00SQRYzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGq3Yj4y89tvii5vJ2UgFo9EVo2/UqGJONVuMZeJncU=;
 b=Y+afiYJ3xq0DOtwsIg1x9E/THIDRxewL45YO0u/r2KqNA1mBUChPsa8YlkwV8ZYEq8pjaf4CBRnrjZyFSlnXWgRssEcjqxKMOJI5i1S7rL7rfBO1Dw4lXvct8TBp5rfRK2MDaWdxpKryktLx2OOfaA3bNrYU4jCIJ76DXaC9KdpnBgObhpeL4HJqzDJJDx/idXP+/TdENKit9zRDj2GsjUl7VWU4u/v4PTo5Q7s9v8y9Q7RVKUKFr5gSq+W8mnIRu9QFsQFvvwiTz1V5P5oWaKdfo/RBdhi9q2XMDmHI5HzU9FeI9TRN3WtW/NnQMoT7H79DenEh9V9sNxUrPpynVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGq3Yj4y89tvii5vJ2UgFo9EVo2/UqGJONVuMZeJncU=;
 b=mGQGCCYZfWDFQZBCXca04Q6PV5kWywHVMskulJ6BliEG4g9krEgkhkAy1entRmPtgGKsBl/qLJBXGWfF7cA/NNnNwlE9ZJQSEI5LQZlhqJI4L0WSAfQ2gZDPO0vNcnzziKU1Mmcw4kediXU/LU56kidEEtpt5wRL9aIeeg5Yjik=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 09/15] block: Add checks to merging of atomic writes
Date: Wed, 24 Jan 2024 11:38:35 +0000
Message-Id: <20240124113841.31824-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:208:32e::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8d8779-026c-4bee-b4b9-08dc1cd1197c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+MK+12SzSZB4AKxY4bV36utNtxAeX32W2B2jrAv332fVnyfWBVydD13ZfFuOv+UtwcMkwhr+aHFBtiB7HBWCEwfnFEL/yn5o0tLykhxjEtCm7oA/gKC/V9fLb2PyZteqp0MCdqhQKvGSselyi0pNo3i6IKRFLK1TsikAwthfJd6LbduUYRpCVbd67ebfnXufr0x0oQojy2O3pZQawbJlxzU6wCKOfFfkNCkz+8NbWHT5nm/Rreoeg+GfjEFEAVJ8+GaeyVdTg+msu30GTP+yxk8Sgkt/IZmRuD0O3zdsGdun9OIeOHua216zvuBjIL5UZBUvYOJqLDLKnm7blEH8HNkyOcQcyfzc5ouE+nvSAXSs/rG5veq+e6Mn92RS1VuNZ2ZEIDQ3Z0NqmdGAXUdKMuHf9vyjwnCWM2D5BuPQhYfITXzYmi+MeeGy4hCgGCuL9ek0/RgOrGuEbUbxrQzskVOnPSWvkofZ48d/ksQTGp640FTwEFLwhrpC8B3inbUAoEjrubS/exw192ekWIegm6xu9xRVZdVBwqgDIAO0aiWz6BmoxT/y99TeFGSEhFC7BCHpPFnafDjfZ6qq50lGj4IecTgQxZ1pyIuGryhqv6E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(1076003)(6512007)(107886003)(26005)(2616005)(38100700002)(6506007)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(6486002)(478600001)(66476007)(66556008)(6666004)(66946007)(316002)(921011)(36756003)(86362001)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1hVAsKXNDcs409w8+bgkdinSa1zrRZDZSurK/N3sUsqao6aA8xftejCn6coK?=
 =?us-ascii?Q?8SzDoouPuA41KC7RzQ/5QEhkes2MF4D9FIRLhp5EybXhm0OG2rE2bIwZp7d8?=
 =?us-ascii?Q?cNxwXG8zFbuVzVTB4UBtPhLtqjEud1rqcG7UkcB8crWkq6EjIRmOTIw0oCjZ?=
 =?us-ascii?Q?Y3ROlctngR8RhVvtVGCvyn3L5hJ/H/eKog0U53ccqkz/wqDEMNLcvVsZYF01?=
 =?us-ascii?Q?0XExa2fCyHtDe9Xv8eigbGMFXL+CxrBHXz0y4Wl+rK4I3OtkmUO7tcH8ccn4?=
 =?us-ascii?Q?RCHvRu+fLUHE+Kob4aP5sVQz+aCP1Z2ZfrUjX7lhJ9UkSPBnpsFlwwznzajO?=
 =?us-ascii?Q?lZEkyopdG4Zh4IwyyG9kbjMsgI2OcJ47NogrkQyU4cSI05HKdB1icHg6m8PD?=
 =?us-ascii?Q?SajSADicAXzcCwLm3048KIsr8+nXttlCXZlm3k/GlRRc8nlqy4A7iy42WFTd?=
 =?us-ascii?Q?Q3ht4XeLWC3Uv82s3jwaQ+sWVpBzHg/42fQ3ki9VpGWEvV0UKloBlk1NANdi?=
 =?us-ascii?Q?nALXuaZwo6Q3cyH4YMNlVovBft4fwI4dt6h/KP1FrGngg4St15X95zmmv9zQ?=
 =?us-ascii?Q?S8d6lszXbyn8SydbFvmP6sD2qiz1UwLX3dUFeDJGUPfFv5leckF/ImjK/mN8?=
 =?us-ascii?Q?aMnPFe85Mqa+Cqgm6AwJwYNTqLOkhxoAVICk5VfPsijqOcLbAhjTY/gx8SQA?=
 =?us-ascii?Q?uyb4SRrAfqPV8GoXJpGmU1AynXSortAJl4aC92+JY/PaarNbeWTkAAO2iHhd?=
 =?us-ascii?Q?qkmu80vWOG+FlZMfWbwoIs76anMqsqxJk9gmfff9ha1iRs2mBBlQorYmjBqZ?=
 =?us-ascii?Q?BTHHzr2FBJ/akVjjfwrE2GKWpMcWvWv1CTL+Fwon7iyLgvSQrQQXrj2EZjSj?=
 =?us-ascii?Q?RIk2jwjoXTvTpywuzbEFDknbAxdiP2hK6fcJROMtzVgIyBuX2F5g9fe+a/iR?=
 =?us-ascii?Q?DB0FGA0LybQUHqtojn3swcejlCucTx6xRPhWo/cfOagIkWc7eRjnS6r6xh6f?=
 =?us-ascii?Q?wnBHiAHtnCHcsESmEL4s26smONfkqfkcrt6HwMJjThk/JLkzLKAb40idr6IB?=
 =?us-ascii?Q?9BWJL3mmJCnNHk0bwIRR7E1dONRtQ8HOdB8sfR5xKXYvbK0hiCcBXSGR06vN?=
 =?us-ascii?Q?wu1LCkt7iprMgf3bfHKHXzdqVDushEnG+T/7qVYG3sIgwRTbTWsOdCXjahdz?=
 =?us-ascii?Q?61XUmd8yn+5H9FcldBM9ROS+wDHx03La9Q8rQ96FTZc5Lz25c+fXkZW9euYX?=
 =?us-ascii?Q?Fw4tRwp/s2rRBztdswdsIzUj75W0bcwpFpHVMzLaieFDmwqFNCMAW6ImqCK2?=
 =?us-ascii?Q?rrY1Yy39snEOco0bdyKv9ukd+9ng2P7qqS5jrdfdaT0IPzEQt060he7WrBT9?=
 =?us-ascii?Q?BS6U3tfiBKvmsnRcCpBArbbM3WxOgLdRqCFhJJSjciQIsolT76B9ayTGaP/B?=
 =?us-ascii?Q?CrTBaJ4NZhfxCaTQY3COFEKi+0ei1W4LkI6/6+W6+vfpBLCX1rfvTDKYUlnE?=
 =?us-ascii?Q?X0hsrx2Xwbk/OLJ37auz3acOsq0hkuDd+LjgbuZyyFKFvuIicSMd5Ap2b29/?=
 =?us-ascii?Q?LFLmgLFWVMFAgTa5rtJIb0fj7vDTjJL74vIp0xkV1/HjGo3ewDBptIVajC6D?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tPPP3TySyWrOgWk+8r7QlKlyb8DD7qL4CAaiXh1mQnqMiRtVDeRM7Y/gd8QSBEHGJjZtr6ABmTL8SmxisRZPcMqUyR2IPv1G65NlsyG4dPMCf2/Ho0pz4+0rkCe5bxfFbshpFQLg6BksWIfQ59ywDgQ4tVTDRWkSvYqx5QeRBaJ5nuKtSqJJ6q6+5WOIRd25bGWK5CAYf6QZQDIe2Y09+g+cA3aXU5MFFedhI66dtPKo6VsUumtdtf9hLbHHdzRaSfiGdlqSrr8wFkZAXmckPlnfdBIVFVlQlEPHSis5+ogsJ9k1i1LGGqfhk+QF9ZBs7hXd9iVj+2QNHXJoXpM8cmB9pXR+dytGhv+bP5VzttyRj10+NzGBkoQqfJrohov0+mYljshtEs8krFvS+f6AtO/pz6eZqdaXO8Pmn7oeWm4/ynbeDstIk3gFEupmrwjdB4HkASReR15HAGbruOkOkCXDB4EhMrThT7z4+YaPTQ98IjzUQ1lAhzrILiGAW5z7c1R7A8SasSX4Rkm6FlZ6TJiVBDcA8C4nMRCH+v8DkXmI5ArjFonvXS+ExKFlmGMAeaf+5qW1PUsTQ0+DUrxdxdoKMqpCtsi8UCxTfj1sznw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8d8779-026c-4bee-b4b9-08dc1cd1197c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:18.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKcOUC8gN3H2yZKyv5m1iz6WbxmiaVuITQIqDRCHtAek0MG+kFmZg4wMClAzFFZc1wGW2574hizTd2+As/uN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-GUID: jSlye0d3cZdXEi0fKdQ_QJxaz5ZuUHj-
X-Proofpoint-ORIG-GUID: jSlye0d3cZdXEi0fKdQ_QJxaz5ZuUHj-

For atomic writes we allow merging, but we must adhere to some additional
rules:
- Only allow merging of atomic writes with other atomic writes. This avoids
  any checks to ensure that the resultant merge still adheres to the
  underlying device atomic write properties. It also avoids possible
  unnecessary overhead in the device in submitting the whole resultant
  merged IO with an atomic write command for SCSI.
- Ensure that the merged IO would not cross an atomic write boundary, if
  any.

We already ensure that we don't exceed the atomic writes size limit in
get_max_io_size().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9d714e8f76b3..12a75a252ca2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -18,6 +18,42 @@
 #include "blk-rq-qos.h"
 #include "blk-throttle.h"
 
+static bool rq_straddles_atomic_write_boundary(struct request *rq,
+					unsigned int front,
+					unsigned int back)
+{
+	unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
+	unsigned int mask, imask;
+	loff_t start, end;
+
+	if (!boundary)
+		return false;
+
+	start = rq->__sector << SECTOR_SHIFT;
+	end = start + rq->__data_len;
+
+	start -= front;
+	end += back;
+
+	/* We're longer than the boundary, so must be crossing it */
+	if (end - start > boundary)
+		return true;
+
+	mask = boundary - 1;
+
+	/* start/end are boundary-aligned, so cannot be crossing */
+	if (!(start & mask) || !(end & mask))
+		return false;
+
+	imask = ~mask;
+
+	/* Top bits are different, so crossed a boundary */
+	if ((start & imask) != (end & imask))
+		return true;
+
+	return false;
+}
+
 static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
 {
 	*bv = mp_bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
@@ -659,6 +695,13 @@ int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
 		return 0;
 	}
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		if (rq_straddles_atomic_write_boundary(req,
+				0, bio->bi_iter.bi_size)) {
+			return 0;
+		}
+	}
+
 	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
@@ -678,6 +721,13 @@ static int ll_front_merge_fn(struct request *req, struct bio *bio,
 		return 0;
 	}
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		if (rq_straddles_atomic_write_boundary(req,
+				bio->bi_iter.bi_size, 0)) {
+			return 0;
+		}
+	}
+
 	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
@@ -714,6 +764,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		return 0;
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		if (rq_straddles_atomic_write_boundary(req,
+				0, blk_rq_bytes(next))) {
+			return 0;
+		}
+	}
+
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
 	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
@@ -809,6 +866,18 @@ static enum elv_merge blk_try_req_merge(struct request *req,
 	return ELEVATOR_NO_MERGE;
 }
 
+static bool blk_atomic_write_mergeable_rq_bio(struct request *rq,
+					      struct bio *bio)
+{
+	return (rq->cmd_flags & REQ_ATOMIC) == (bio->bi_opf & REQ_ATOMIC);
+}
+
+static bool blk_atomic_write_mergeable_rqs(struct request *rq,
+					   struct request *next)
+{
+	return (rq->cmd_flags & REQ_ATOMIC) == (next->cmd_flags & REQ_ATOMIC);
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be held.
@@ -828,6 +897,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
+	if (!blk_atomic_write_mergeable_rqs(req, next))
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -955,6 +1027,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
+	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
+		return false;
+
 	return true;
 }
 
-- 
2.31.1



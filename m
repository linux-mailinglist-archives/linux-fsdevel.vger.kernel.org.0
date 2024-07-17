Return-Path: <linux-fsdevel+bounces-23805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1704933A09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86D1283E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB83F9D5;
	Wed, 17 Jul 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z104ODjX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GCebraI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C882574B;
	Wed, 17 Jul 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209013; cv=fail; b=HRSDnXDthoNxs+u5QAu8wMEA4L/LxziTCVkN337x68y+mgnHdfaoI3hAg7wDWuLrHWILHnvbuODCrd4plE23FM21bf8w1eTPAIv13D2+Oh2+wM7OyegrmL6VFLJR/UEOBw6/gyseV54ZHkHfZUDio0fFtI8GZRaNKOvA2o9cScw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209013; c=relaxed/simple;
	bh=mCbkSwA9xp6AhgDle/vsNwG6ujcIBW2T3rD/HwlLMcM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a9OBJU4yAvS/Z5sx/0xhlED5Xu39jjyLHxqvnVwnLRtreAbvMRgCHP6o8YZgmfd9v12zezgFMRD374a+Pccb5gx48p3dA17ec4kiL2ZZ7uvi84YJhFIsTQxzTi59EGxZDAxQ7+HQPfd82RImqgbTBcSGYq69YJCTaOLROBDZ0qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z104ODjX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GCebraI/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H9ZTqH030453;
	Wed, 17 Jul 2024 09:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=p6enn8WNe81vZp
	FZotSRh7IaK+hHL8iPH2bjsVpGBMk=; b=Z104ODjX+AEy9ieTxTxrNKj1ELfluR
	LyDyClDxtgWTIVnrG6aqenhSuNKtl4gh4jalgUXk0ylj/eqi+UBuEURxXAXbe/J/
	RPQb3ICAB1kfaeAc6IvxTGKzhLjd8GHSApJgJKRsW1VOyxjDBmewjDvhCVmagR5V
	BMKHK/WJPvxYgKvYOBCHgeSGkPsXPM5ZwWJIFt0ZmHkMiVQ/Nm27zO5FHkB+xMvl
	6Q3d5SHMRQtRIoFcAEDw4AvftWVBSbKPDoImAYQ8UZMI83cKZFpUoCoMAJSERf+G
	KpP/Qgh+EE0Z5Iw98HX5wBX+7CcNuwwicFQv2O0uugK+zf7PJZI6t69A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ebf2g01f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46H7PEni006705;
	Wed, 17 Jul 2024 09:36:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexb3k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUbidLubXjzPVBaqltWgtIqtN66jN4Zul/+TfWB8kcFuI/I5RMtSuxAP/h0wWrzL5ws/8OjbGUjUJ75OcO6HUZ1h0J+OKFWr5Cm9sFeHLkWfXyGIhaXwJeOxsTe1GtIU//QHGJJOT0QP4tay3q4BmV7MAekKpHemD+jYUOg5eR974CSlWl570JafhzHeEARuEk/Qw/ECyrytU5kTK0t2MZwe0bbOKCRPlPIx5lHu1ZD4TgzGJjnRgYSxsBFdl1jKdT2s7rSVa6/1bI26ZX1LKdkJVlhMQGppXfYcLm/QGjgVfnHt2aPnrfGOmr495Z6qXYdTz9JSdjmo+rTQjsofFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6enn8WNe81vZpFZotSRh7IaK+hHL8iPH2bjsVpGBMk=;
 b=bJn5SYcdIM2zH1TgbzrwdHmnDieO4pV/2dlny1Zl3TpTrIHAIUVsUQt+sVW3LmwqnpdpPvA9BrMJZNbrrM0/AwvWsbwSYsJZKX2I2Y2BzPSfFcop2SjxKSWM3rM865UcBHfrCfqgZPt6vqxWuUvFjGbyjFj7rZ/67jFUPekXj4f09ZWm1LAhU8UGSc9RAwbfAxx7bR1Mc0zHayP/g5x43OkZr8Yu/Nfz9Hyvr5F0pOHR8YS9S0v59831OjaCE9O5qy6XDFPSjf62GjiWeNz3RU5tN3vJTctFGxWFghpvnnOnvXZa0PmiRLbQM0Izq9c4KNIyyWcF+Yf3wTmanyRfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6enn8WNe81vZpFZotSRh7IaK+hHL8iPH2bjsVpGBMk=;
 b=GCebraI/hIIhHH2lFUr11rNiLnOK/WFzjJqsp0gRJysw1kgP+Z2jQ8XpOkH2JxS9Z5mfToh5XY6IhgZcEB6W17Z0p8yeiEwqmx/7a84qZZrExmNJ3c0Tl3p0OyjQQjNaTXP0na/cbsoabYbo5OMVK11aram/hUKS4EitAtrhbGs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 09:36:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 09:36:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 0/3] man2: Document RWF_ATOMIC
Date: Wed, 17 Jul 2024 09:36:16 +0000
Message-Id: <20240717093619.3148729-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0391.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: e89c3342-0d4f-4c74-2b6f-08dca643f4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7CLLj8AmIFKTwLIrHKYxc9mN1yplO6ndyVHpBzjuqS5vdE3zUlKEynZR40gy?=
 =?us-ascii?Q?0GI3giGP7zMNSrtG4wcWZDkRtvBXbAD/jzXE4OTxIUb6MSOztTy2Os9LlaNx?=
 =?us-ascii?Q?o5Hr/3FH/rlGIzUiLYxcqLndcHMaTl89GNBXDQ8DC9nrI0RyxUjqqGGi2AOc?=
 =?us-ascii?Q?KwDK+LjpTbjUPM6eVx9qegYm1ypLEQPoyzGNNYbgZLCQ6EFNWQPPxtdrk6x0?=
 =?us-ascii?Q?4ivZLKcvyggLxPzik+QRN2wNweLuMomw5q20vasZ1fc3i+YhDnjHNL9A0MRl?=
 =?us-ascii?Q?xl2k6E6f6ESYRSWM+dBJSJEJEAbNj1Botc9j07PAF7WN2N9rZ6eg8TfkCjbO?=
 =?us-ascii?Q?Ju2y57d6YmG4tNLsjzuzmb+sJBOhmLVMa4mO+pb3+5lxp2vpE9G2EX5FgLcF?=
 =?us-ascii?Q?aP9F6tTrrFdY8UYcQWFOzL/bYKXeOvhngVdxl/lfCsF5h6iZIslxVS870YN4?=
 =?us-ascii?Q?qFXT0kk1VvlgQpzPeNL4Mfg/+UBdWMOydhWhb8mP7JGOc38fsUn+8VopmOQI?=
 =?us-ascii?Q?34OZWjdAmUj8FeMWtEpGy3rbQED+AnSBvxC11zVF2je1eNuHg2RghY0cVIXX?=
 =?us-ascii?Q?kFgWm7QIUr1fPG75naWsCxLVWLvm1+fZAuV8xH4aD6YKeYhuhKlzZM49Zrwq?=
 =?us-ascii?Q?9yCtzFBMRdqra9bJUZUxCzL+hLZCbkiWGR+BYBUjF093JmTIQ+73jpwdGb9/?=
 =?us-ascii?Q?bgsDogCLuWcEG9kYmcpyq2yV8pkcnr3JyxwPyog0BAkFK6mIqKjc648UYztf?=
 =?us-ascii?Q?76eXIXSldoVcz81khZ2zrKJBJEfl2QAnvrQ2kf8f6++ThHetCwt5Y04PFeRs?=
 =?us-ascii?Q?PxaP2Rv3hDUM6+Kuz1PU09Vup+0Uap+K1YDI0WiY7KSrGtjiJ9VdKWBmP/Pq?=
 =?us-ascii?Q?0EGb2Wbywp8WI/UBZGEFPU6NkHC4wm4k4etQarOQ6Fqtjyd4Gr43O4i62TN5?=
 =?us-ascii?Q?Z6qi1rqr9KfTz9wv1E2NB3xxAFizQHMN8u16zhNYV5Loz4Wc1N62zKV9jrAP?=
 =?us-ascii?Q?Ca+OlledYUe/qUclNgWLeMV3wdYI+V+FAD1mK/s4Bfr9z+RtxmDwLAPv966q?=
 =?us-ascii?Q?l5cBLMX/suh3iV2CB4ZCC/moECyQMFCm33op+E/8r0BESqIdaihkWys0fd5Z?=
 =?us-ascii?Q?Dwke+4xqDk+bweq6Iae7A50htjwTNXKAgrn1VmDETTYWbddHqqG74bl/MmB7?=
 =?us-ascii?Q?vI2mIVGcz8Mwysl5ya1kFOC4itKSKSdTEjX/UZS9hNdjqp6tRL7BSIRT1JQO?=
 =?us-ascii?Q?GufK5B4wpEBz/OFCdZBLYYOyo5AtCHSV25X56JrSTcgWmL4b69q7PHIUmS9u?=
 =?us-ascii?Q?Ze2m1MRZACnqkDs+Tc5X8kZbiRDZ3v+TOCepH+KtGbRMEA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n8H/ZjsiuD1FH+tSRWlbjdK44PLUR6uP7/d++I28xGIadyi5vEiaUMy4iQkv?=
 =?us-ascii?Q?jouaBC27hIyuyBzgcFJCDCnPNx4Gw5lquE7FtGN9HY9YPxhWZf47L6CvRPFn?=
 =?us-ascii?Q?lAa6TYMuDa+rMRJRa1HjKF7+rRgAs8D2F6p03IJzpnzL7whHqu4YgJVV5UIO?=
 =?us-ascii?Q?hwDoTg/NFI9M/A/3p3OohBDnk2XTw7BZQ3RasJCwWJqJjg3Hm0nKZrz5Kavy?=
 =?us-ascii?Q?GvvlHZVKqXMZ+6UgAcsjIzBoTC81DIvvKveu08HMh7hask36EheyqnD9BbZp?=
 =?us-ascii?Q?e98fc9j4CrQHOnNISthxpCxBNhSCfsgFoVTHnLBQo/534u3IHxDjZtWeMzx+?=
 =?us-ascii?Q?5jY21xUAy0gyFxDWGMDCqbqkHkMKnz7NgbneaHoJ0n8rHuYI/3lq6JyMyKQW?=
 =?us-ascii?Q?333lWbg0HLkfdoic06WRfxr+jAfKMik1wHc0ZTG761Ee9dmFY8RHzXkv8QJx?=
 =?us-ascii?Q?8MqWNnsLYbii5JLJrdYwVJEWfPAZZUmwzepFfC8ZVb7XYMKPM48F/NmOym1i?=
 =?us-ascii?Q?0jUCd5jFZoi2HSiMBCMPyLpbqMW7B7+xCTao384A7Yu2EX6rKWd0S5gglY7/?=
 =?us-ascii?Q?tmLnnvwHLjd9lZ6shZ9SVgGiI8LWTCebguqaVDhNXOcji+MWufduuH6ORMyd?=
 =?us-ascii?Q?s3BeEHTXGNgxhrx9bmaUHFMHFBHmzy04jt/h5hYjXjYGkgOZdSbCiRVUH3xl?=
 =?us-ascii?Q?jFXFW8DE2i+BRFQv43OISF6Db6G29ohqeoSzgJB1Gs3Wb/YXnI7amtk0fDuB?=
 =?us-ascii?Q?tzZwN6ulcmSx/hbxCmnr6WIrbHEzfni/Fmv5lQ+G1bYAoP7GVlFhZrTlomnW?=
 =?us-ascii?Q?S9dmoaAQ88akUfRa7PWa9Fc5n1SkPqs08DJDPmYRl1soYH5qdiox3z52L+Ub?=
 =?us-ascii?Q?0f4qfZSs4vEoQQ5NRq0zqJCk0itWbb+jqsZPplcqSbx1NpP+9mXod0yvm+qa?=
 =?us-ascii?Q?9GxGsRC2QxH+5P+MBrCXgjUKENOTwi1jXvwEssKEYEtxtYzB6tdhOH8NmsFR?=
 =?us-ascii?Q?HFjzoLRfbluZazOpcxK4My3dFJYYW0+BNzti+cNa7DJycMTrhNQ9+bseZeS0?=
 =?us-ascii?Q?J/BwfQgsQ6MPJOyc+4LgqYnPMTohfDxvaFniwJHlqCmsP6JueMsDzzjkNNGd?=
 =?us-ascii?Q?341DBBAmDk0ZLHuBYK3fVWQYEmIpkbwb7u1VtYWCVtb6pDip/pCJvU/+huFn?=
 =?us-ascii?Q?72prQPzqrNsYX3l4D7FvNAr5e8Fxr1BesWCRYWTNASue/1zkX2ZmcCAHAoJ/?=
 =?us-ascii?Q?wHFBt2U0Gl6p7Izs5Iihp/ku/thMYvmgo3HmscESntjgu++PszU13po4B9vm?=
 =?us-ascii?Q?cNeLNp1mJ1CERdT7DsoielikLf3+JCDuP87zyfj+v8U9Of4KB5ww68uSUbMp?=
 =?us-ascii?Q?bQH5SNwWdV/zATMzYYadOI3MxWU/WP0NlQY7xFsBMCSQVa7MsMNjGgLlpnY6?=
 =?us-ascii?Q?7PXljTeZ7BlhxaPC6NWNeFG/a2DR7ttwLiuf59ykZYd6EyTzagxreL6s+67Y?=
 =?us-ascii?Q?0MDM88VlODvrIvRSNPMgwLDY/NX3t3gflc9xCq0DumGqRRn5RYnxD4tabvDE?=
 =?us-ascii?Q?ErBxlXFa9bqPoWO6atSzQYhyX9HyVVLFoKr+YUKeyZSWQZ4VqLPbJNxmwh+c?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KPPOnywDneCOVrT4YABmhaXo1RPCobVmOBPpFl2P2YQy6bcOVCV+FSqTlRow1VR027gY3YjY9jwwCrIKNHAn1JOC78F+nbhXasKK9lIPzyr04CQ3IoRZfArp0c71giVu9k5kyGxtI3Xpbf1xksf18ZyvykqGT7FxBXaCUVGXzDRuIXQK4EXAmP8jtAdWrElYU7FTiILtKKi7eGaPZF5/vEADPDPA+BNd6zzpSjP7spShb9Ia7oMZWdNe0L80pPbx+LMlSQ+AxIc6de1FzGt71r2yAsZ2MOt1/stntrssUwOK7jWNwzY2uXb2FXLFDJa5XV4C0sKs1YioIoYOXsO3O0bjNCODN39cb5fy9qZjOV9PLjlQDTRirwrb4ox7TSeWi2epegH3tjf6lWsTuHiAwM6RRLy/iUysN9CTvy6+ObgrEe3OKIU7wbsNZ0BQD4w9ZfYiQTq4RVp5XrRO9ArLXyUc6b+xYRM51Pxqji37Xue092iH/C+uWWeNkTM7gv5XCgQhOaBHc7xSuZxzVGI5YjsOOT+vRDhnhupi28+1rETO2f9sxf3AVs6C1H7/EssypJTt+OV/mH03YLGA3QMK9K6GsF5Gz6KJ/zzMOsMem3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c3342-0d4f-4c74-2b6f-08dca643f4c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:36:38.0662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHXWB0WGTur8HGj9bpIY4rTrGl830X7tcnzfpGwznibFBfpHgwFjoa0NiZJOq4pNSdTKzCMpmxl0TpphScjQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170073
X-Proofpoint-GUID: LWcWqUNK5VvmjZadB06v06Mz402KbXep
X-Proofpoint-ORIG-GUID: LWcWqUNK5VvmjZadB06v06Mz402KbXep

Document RWF_ATOMIC flag for pwritev2().

RWF_ATOMIC is used for enabling torn-write protection.

We use RWF_ATOMIC as this is legacy name for similar feature proposed in
the past.

Kernel support has now been merged into Linus' tree, to be released in
v6.11

Differences to v3:
- Formatting changes (Alex)
 - semantic newlines
 - Add missing .TP in statx
 - Combine description of atomic write unit min and max
 - misc others

Differences to v2:
- rebase

Differences to v1:
- Add statx max segments param
- Expand readv.2 description
- Document EINVAL

Himanshu Madhani (2):
  statx.2: Document STATX_WRITE_ATOMIC
  readv.2: Document RWF_ATOMIC flag

John Garry (1):
  io_submit.2: Document RWF_ATOMIC

 man/man2/io_submit.2 | 19 +++++++++++
 man/man2/readv.2     | 76 ++++++++++++++++++++++++++++++++++++++++++++
 man/man2/statx.2     | 27 ++++++++++++++++
 3 files changed, 122 insertions(+)

-- 
2.31.1



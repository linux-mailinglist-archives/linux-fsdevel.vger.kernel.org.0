Return-Path: <linux-fsdevel+bounces-45956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0554A7FCE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4FD3B8035
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E84269D1B;
	Tue,  8 Apr 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DQ/G3hG+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wXykadOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF1A267B10;
	Tue,  8 Apr 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108982; cv=fail; b=iFS9mUUicrEZ4WCWiq1iWdEMjrLrpDdo6RDcRI8GJT4zPhV/rSQ+ct4OI1x5q5tA25EPC+6Fzeb/HW7GnR8GwKCpS+vL2SJfvKTbAukd3XkML3/qoHFqrqN9BQ6CXPloh+p2n19v+Fqz9zO9Bk00l73rrcslqCSzUEudyN6JhUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108982; c=relaxed/simple;
	bh=OtcZ1JjmwkA+Di90YuoOT/ZTbDYTSvuniwky34srzkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8n92lAhhqwLi7RDFD/qU/OQ3inpe8FyODB8Y+hP8PvJYughLg3a+uW1lGB1r0UrX3zmGJ5nvvYBjXtTdI4Y+EIVADCa8mXALkpLTzjy1Dtsn1IzjQr6VHqUnLkEjtgkbI/Yc8Cm8CMccH98F0U/S4dqCTEuP2Kic/aHJ2blui8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DQ/G3hG+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wXykadOa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u7bA001178;
	Tue, 8 Apr 2025 10:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SLhGRlJUXYp47GZ9Wbfu4+42Nx1zvsZliC1vm/tALkc=; b=
	DQ/G3hG+vrkRw1ubq0HM6ngXDpUN7pAD3+rW/vP5dSfEGKre9NarB4sb3DvDPy2g
	lYGBe5jJwSxitgD3e8MBeqgUDKkN+3aMAZexcWAfyI5gPjKXhA1WXVG2ydV/6+23
	arW7Ul+F7XRam1Nfxu+svgq6YlHUtmpn9hypAaONQmXKrRlwmxWuMTBEcMkSsfRc
	qGo1ICKvi34UV5wwgv4LRQf2wLOyz+Nourj5vzHinn+QIvs9j+lpYHbbkd+mtBQH
	hCnhIQHefKZP9TMKV/RjQRQeVNKv040QjUTMtG8xH55s0lk2aQnB+2BE1nbgKcRa
	nAtxuN1cjPG1rQOy5jH+jg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebmgfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538A6fsP001900;
	Tue, 8 Apr 2025 10:42:49 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty93d71-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5CRLx+n58Si1iZCslTTVa9jJnOd70lEjFwdG7sosyTkd2ywjj1kWmquLWeHWFpTJadi5n1FdXAIzT1Qs1z+va4zf/7ZzBilk90MfqiSSKiQapwAJOMKOKvhIrOnzMgK7xKvHPLI2TFJc30V8I2yeQPsRjls3ZB/Swr9xg/JIcdAiw+0tiAU/BnrufUm196+KFjOhRTPYYs/ZpvDs1C4BEhqh8PrPMaM6RehyFVCOawtbc4RRuDdnga0M/Zx7K7Fi0qADRa+RZ5UZvPFJulNwuriCH9bSnV9T/vV+IN5ARvl/o/+xFp+U286X4f6jbiXyKYDLCfWI0xYQewF0QJHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLhGRlJUXYp47GZ9Wbfu4+42Nx1zvsZliC1vm/tALkc=;
 b=P8Ixv0gzbv7Qyd10uQq3PjsvIgbRs4dNUOcYoil9vba16q1vyIjn6J2/z3jWkE/+2QegDmGbj52l5Vh2MK4ANqgPQnpinHdxPiYYikBIlf4iou7CQUPK7ZcI+bq8YaWoM7Gbyuf1yjb1gBgqOohBAkYM+JjgIg17KW0SVzPvxh6BPA8AtUDG0iCQkguQ26PJO6opDx65TVRDWthQ7F3eZFC9ukyomqPcZ+XoBteLs6LiWoQqaJaiyxrSM/DpO6DErKezsocPN1R/0AElnu0Qk8BMPnOauBYZl7VkwgvzIuo13/NkpCnWW7K/6ud4eQiG94JRHhs2zDJRd39hKRBd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLhGRlJUXYp47GZ9Wbfu4+42Nx1zvsZliC1vm/tALkc=;
 b=wXykadOaug4i9r3f0dmCDQFaui1v3/Z7LLutf4d+3VQkH3DaJCSWA/8d0MXjDb+JL7pvswnUn7SIvQiOTlCf0/xAZYD4nbdVWfUL8LOB/Bfebz5xIfv88ees7MV3sSa2STg2iCSleFwWrHbAIY/doF287j0VMvgqw3hnahPyNnY=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:47 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:47 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 07/12] xfs: add xfs_atomic_write_cow_iomap_begin()
Date: Tue,  8 Apr 2025 10:42:04 +0000
Message-Id: <20250408104209.1852036-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: b42dac4e-74ff-4713-8867-08dd768a1a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4q5HFDQqVzOWztjhOnfeLSxtWGZQ3WZtjRfd8hm3kCJLKf9vX+zKBLGiXg9T?=
 =?us-ascii?Q?7EKj6TE6/5D3MmGWALCDi7X2b93rVZi++yc+TBtRLn5WbHuW7likSlEnG9js?=
 =?us-ascii?Q?vDupdrt1uEPxZ4eMCZs+cK593BNMlurvnuFFxQrmbmuSqXrnXa0V00+vSNDr?=
 =?us-ascii?Q?jlTGzxoL7b96/iFTMvInkwipfZLiEdyYOiKluPALosh713lJONTfgm7xCwrC?=
 =?us-ascii?Q?FkaAQGo4aEH0lGG6+U3y9+qJHKMKYE83VVLuIEAgKZ6HVg8o+iRG0+lHgpmX?=
 =?us-ascii?Q?UGfo8Sln7jBDq2CNcl4Tn9ELU0I8ZZCwdJFg0VAi1HL6M2nj955ZaDOPHl2D?=
 =?us-ascii?Q?wp36VwsxNgOTifffAljqkNeshvvrx7SwO1NI+sxIwKScojQPx5c1Z1TRdm06?=
 =?us-ascii?Q?K/QAL4w5Vg6TAdEUro+anmzTh3Rnf4vISWKGbRy6IuBv+BCTOvh6DUHi5413?=
 =?us-ascii?Q?pfu11349usulpR6qppvYiOLJ0cDBBN3rhV8OwQIV6jPYlpv7usGQrhF7aYUk?=
 =?us-ascii?Q?0eg06WcQyndMh4BlwN0tb4S1kb68LuqoaGmMWjneVHuyoL73qjiZDraqJsbG?=
 =?us-ascii?Q?xfQXI5Ra6YsAK+QnhSjCiO/q6jHSS7/4xTyBn5RzkF6yPqceulOWDD+p5KIb?=
 =?us-ascii?Q?VZin9hEg7/ccsmmfEkwVAx9akL8xNOs6DS4s5yzIvBz+dGHq+MspW8yK7H77?=
 =?us-ascii?Q?Jz6hsI5Zfqua6NSop8f2Rx2sUupY4xvrG73aRjFLhpZKEFwG/0/xOByKhUCx?=
 =?us-ascii?Q?nGdbY8dm9t7T4vCZTKhK8ildG9tyT2rvIPcHDj7gqmoGpmYQ0rmuwKlxT+mT?=
 =?us-ascii?Q?FjJ5MYn+CKmakV+9W9jQA8hY1aJwVjk5x3Rb8kkBSUHB3r5aUDC7B+olWr7h?=
 =?us-ascii?Q?4nm6Ey7K4AEenF24FcP5RLLkNW0zzo69n2CW2omfGSkxPN4p9aouDNoRu59m?=
 =?us-ascii?Q?QXv1zMSUngjFAJZk0Fb4MTtGcYQdzd/AEu9bw+MoTJM/pPqBpcogqpA8ljGk?=
 =?us-ascii?Q?XLIShQmOgZFdddShhupEqz9QmM6LwmdskBxBbIlarqvbvp6A6tUigD+RZJL1?=
 =?us-ascii?Q?iOwiqlIgCMP5ZXAZ6967T04f9QPZcEek7yAe11R10mucFdQ+YprrguEQdaTj?=
 =?us-ascii?Q?7u9wimOswU+MtnWGS4pT0wwTTLUGA6lY10lp2M7lmeHlARAoGNwLnoQAsjsq?=
 =?us-ascii?Q?RpLLTZJAbmuHO+d0/biaY0xt4V9Rqv1PR3Yxtx3m6aJzvpog9g1v7KfTb2r7?=
 =?us-ascii?Q?7dHDjKJ+5hYCS8qDxjpOpj9QQOxWQ6OigBr4XkP647dPxpyfcPmu2Jam5KbS?=
 =?us-ascii?Q?JecNzyVgAXtJzQpuw2Hebwm2oLP7VRDOofHAIYEiwSlNFxvP3CqSswDI4Cvw?=
 =?us-ascii?Q?XKjndu5cPwa/OibTjOdSyMETiNCZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hI8vO/GhW+OeyeN1PVOVMeTc7k1HBIXNtzgr1+bbLtizTgeTQSdKvxrRsE7I?=
 =?us-ascii?Q?DgkTGMlFvMxxcv+aa4FhmNtqK2Yx+deIrrOAH+NYwQE2poUqtavtLBXZw4yq?=
 =?us-ascii?Q?OsF4SSV2JvLu8u5Uczfvyob6g8aUWvTo1fCOdtV7suJD+rsb1ND5E1MY+tcF?=
 =?us-ascii?Q?z91MW9E1f88e+wPU9a/doXyoUpwDz1SmSl5wc2nr4U9k5lhojOGI6zRakU4N?=
 =?us-ascii?Q?QqRKcEQoXN28dvLsJrdOars1SLuoyV8GrgkHAR4gN2ADh7UWIDcfVZ6h67kB?=
 =?us-ascii?Q?yT6lf69f+vgNuoS+0wcLwCxqjbbS25tZhxLD7C+51gyx3+a+V3a1peWW0eWT?=
 =?us-ascii?Q?kinoCqcaMIZOKZQxEjcL6mk7gbO5pEtk99F3xaGpmShXeehCbOWy4ylS38ha?=
 =?us-ascii?Q?hkaE93qPwuqRHjvcu5DR1Ix++WWFvxym8yWlGKWveRs2Q5pls9Ks2hJtUBqi?=
 =?us-ascii?Q?OqnLhtYX7ba/HjDOahhAh+nOGv5ZDpvAKQJt+OXoX+a7exN1icMMMSA6ZPPy?=
 =?us-ascii?Q?z7yWUgs+7Y4amcmJ9O7KTyc5OpkyKft4d1D7/9Ss20VSfN931pT72MqVh3Ev?=
 =?us-ascii?Q?39KyqlUKqzz5vhOAje5/0WoeNva46nL/acB2wicYbLgPuDBo3ZK7JLKjyTe+?=
 =?us-ascii?Q?xQDYAEAWYD/FOw5ZDlM9h6Glc0Fq/qdBWu8KGt4zw5CikK9VCsh3XBGywqLz?=
 =?us-ascii?Q?5mEFBrFKwbt4hLADy+MqRxIUwtQCU9j0Zmu8SjHnoRbvDiZSVrO+jlilJ457?=
 =?us-ascii?Q?f/p+Kv9X+9lYuSWI95VQbUQU9+nuhHwn54Kp6wm4DCy6BavNngM9WmqBA6h4?=
 =?us-ascii?Q?6Cwsuygvg6E6FW94zv1UFOZ8Xe85pkJljayMaceAWshgFyp7fDkh+HIwm2D+?=
 =?us-ascii?Q?yllbzJsdk00gU97nS4kqbcgtlp08iLSu2YIHaA7CtIT0RhqqRVTM/utUyqw5?=
 =?us-ascii?Q?PomOnVUW+sgwDiLfL6NvPaD/nxpKsx0KfOvjgw6Z1ua9DXChMh7KLip3NqjO?=
 =?us-ascii?Q?P8rPR0/cQEL3Xvlx6fPbus5Ux4aFPIj72gDI0F/PMyUchIyE0lCpQUsDQYXS?=
 =?us-ascii?Q?nN74K5MWUzlJ27ucFR9r5USQGuJu+yp4XAvGWJ8+FJwE/Y5qM/YdeDmv3Zg6?=
 =?us-ascii?Q?RYpjazuHg/i60z4hzOHZdoGRVFstzUBYQPy5KwWZVHhesoQqH3S/6iRVnPPk?=
 =?us-ascii?Q?bi4fEP78mx7Z7dUpzc1mSe76nGXGmzcHAaHdvO5v7rVNG7/nfcgUnJ+sgc2w?=
 =?us-ascii?Q?bJSNgripmn7hfV8YHqFPboxkfxJ3co1qJpvQwBOXHPfLcQJtSOR0xVqpe6z3?=
 =?us-ascii?Q?z9zPjGtgCtvcjhBqfA8fG9uGs9Lr0wDeRFdai2IOgo5aNm2MeLlMXihn8hzy?=
 =?us-ascii?Q?5uYemUWJ47RKnQIT3KO2+rdQVK89QjHvVnpOhAKTZ4kgVnAia3dSOYVYor1I?=
 =?us-ascii?Q?1UWYNFLO3eqxmfymJS73GKQGGvuBfQeOY6iNIyqgnrA9zAu/FUWuhNP+rokH?=
 =?us-ascii?Q?rnxJFCeF7KfSYU/kV+A6FVgHKHpT+6GGthlkKhOim1TwCtNgKPYZI5aWWT8p?=
 =?us-ascii?Q?zUDmU0qHBBjRgdEdbqPcsb76kROdyZ3QDqcY6k2M9NDP0lPvh4JqXs0FAxrn?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SQcN1OQV4DCjSF573iHhubWS9yvq54Xz40d2UHEsqN3jJJLAusaDohAbfFSV2v6L5apECdMj7tVcg4RYRwYX0w0GmYMUfqJN2g9KDSw3q/8GTeaVieB1l/t+JDLGDUsH4ENVxE2X6N6H4SxLiIINUst/NVlyDYBlmiuNqK7VI1KUD/mvensAm0f1G/9gorYXOD//NmKfriEFs76eKvFPEUdluffFdyUMdCTJX69fNdCdB8Lw00aKsEaeHZ9Q4DQ8NcKifLdiffRHQ2XSidtHu3HrKylNlIrDhZ7DdhS7LQjFM0VNnP8yTgWlwDbJNx1416yqll3RysGVFnrO8WbJAiLZ0Fk6D4YIiL3dBPqOuW3en+/Yn3pltZsetkkKbxiB5liKDacX7o0rP/BUFnkBC5zl6EHaWwiVpri1FlWC7jL3DNvj5endhUI3sKfPVmpfn+Hs1CDFAJWfGnMZfpPYajyWYbRNSqTwBlfYEvNs4ZY82GnWTokci0aHF+AZF1srnQYaBrZdB2Sc/Sj9/9Nno6MgNr+fVXoZr9D2X1RjEHZEo3JNUceR4WA4cTbfAOV470kSc86+TrOrTZpCzDocbiVZSopkuqBcM3hJWpDDqio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42dac4e-74ff-4713-8867-08dd768a1a29
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:47.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoBZ+ZqTyGSHwFNmqon6qGrun108kP3z6ZBci8RKVCI3Hfw3suvXqMpbUiRU6p1Z8UVyzIjLziaeIVjOhdCZCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080076
X-Proofpoint-GUID: PYZ0bb_1teCmjecI7UIDgwqfgwxI-9eH
X-Proofpoint-ORIG-GUID: PYZ0bb_1teCmjecI7UIDgwqfgwxI-9eH

For CoW-based atomic writes, reuse the infrastructure for reflink CoW fork
support.

Add ->iomap_begin() callback xfs_atomic_write_cow_iomap_begin() to create
staging mappings in the CoW fork for atomic write updates.

The general steps in the function are as follows:
- find extent mapping in the CoW fork for the FS block range being written
	- if part or full extent is found, proceed to process found extent
	- if no extent found, map in new blocks to the CoW fork
- convert unwritten blocks in extent if required
- update iomap extent mapping and return

The bulk of this function is quite similar to the processing in
xfs_reflink_allocate_cow(), where we try to find an extent mapping; if
none exists, then allocate a new extent in the CoW fork, convert unwritten
blocks, and return a mapping.

Performance testing has shown the XFS_ILOCK_EXCL locking to be quite
a bottleneck, so this is an area which could be optimised in future.

Christoph Hellwig contributed almost all of the code in
xfs_atomic_write_cow_iomap_begin().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c   | 118 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h   |   1 +
 fs/xfs/xfs_reflink.c |   2 +-
 fs/xfs/xfs_reflink.h |   2 +
 fs/xfs/xfs_trace.h   |  22 ++++++++
 5 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cb23c8871f81..fab5078bbf00 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1022,6 +1022,124 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	int			error;
+	u64			seq;
+
+	ASSERT(!XFS_IS_REALTIME_INODE(ip));
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (WARN_ON_ONCE(!xfs_has_reflink(mp)))
+		return -EINVAL;
+
+	/* blocks are always allocated in this path */
+	if (flags & IOMAP_NOWAIT)
+		return -EAGAIN;
+
+	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write,
+			XFS_DIOSTRAT_SPACE_RES(mp, resaligned), 0, false, &tp);
+	if (error)
+		return error;
+
+	/* extent layout could have changed since the unlock, so check again */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
+
+	/*
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
+	 */
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_unlock;
+	}
+
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
+		if (error)
+			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
+	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index bd711c5bb6bb..f5d338916098 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..379619f24247 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e56ba1963160..9554578c6da4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1657,6 +1657,28 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
+TRACE_EVENT(xfs_iomap_atomic_write_cow,
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_ARGS(ip, offset, count),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(xfs_off_t, offset)
+		__field(ssize_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->offset = offset;
+		__entry->count = count;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx bytecount 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->offset,
+		  __entry->count)
+)
+
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.31.1



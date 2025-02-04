Return-Path: <linux-fsdevel+bounces-40736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8474BA270CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50AA3A551F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B52101B3;
	Tue,  4 Feb 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oxxM/Lkc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DtuIdSJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77E20DD60;
	Tue,  4 Feb 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670535; cv=fail; b=ZRZxhEmspFlPAw+AHiXjE3/e2Jk8+4pJevwlgdlaT/sv9dkyR8khXGnsYzkzKeJj2wqHWoDpO5cg9bR9xPF+sMd/ZzWLRc84dqjyvSvuVxQHQopjq/UdllDUCisC+TrD19L2V3FxhQ9IRjEt8mgiSRo/ZudDrG57M9T/3+C3Hfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670535; c=relaxed/simple;
	bh=u5mxsLX5hla22/rJACVa2GSJbhhPTPwcbChL834OUhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VFyWMYDadzKl5d0Y0F3UjzNEKNiVJOJR/A0te6gCFoU9rEYnguHv6Ho0fmCIZ4igrOSa7RYz+5G4iCayoq/VNVgDm+K29ldb93QMP9PcMj2AZoVdbJVU9NCtlRKQdVO6It6Z/FUSjtM5AL/yXYhBCjqFktJECJ9NS8IuUzNYcPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oxxM/Lkc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DtuIdSJG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfZIf010983;
	Tue, 4 Feb 2025 12:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TugdJ2Bg+DyAyFUFXMhdpYGkMYSabiuNO4bgVzO6LTQ=; b=
	oxxM/LkcC5PbbB4TPA98/LfUBbEVfBSZ7Pc5iAaLBNIiQyWI9uKOmFNJiltGIoj5
	/NRQ0bGi1KCgTxziI3Okt9MozF71FNI5/Wny3WSZi3P81RaGp39HXC1SMOvmrnjw
	SuXazyIt9SljB3GGc4QLQnInSXBb5HMkpIiz9I3jbs4gfLw1ANyo1ch1wykzV4ZO
	vzlYQhf3e//xQk0cgVoMUyMHoZMaP60OLxcj4izWLWuIozvdd6VsgS6073zmrlPc
	MUcLwb78PyQhjXBJnbmhGDz+r9qpchp6Db+96bUB9k1ONGOmxtDJ5jjkRGGWKzyV
	gVDenqeQQoSNxDKuP9kVMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgvrun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514AcOQx029134;
	Tue, 4 Feb 2025 12:01:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p2w4kd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR/SMGmRvIt2BCavsG7fBD14oZZo2aOGNXRM0jEqL83kjd4dPv7aRj8LgxyEpgoUFItS34bwdcBcsd52RLZB/ehb1+audBNDwguN+m2kLrVOZuRctKjSr+qrNfdT0XApPe7IPiObbsqng5RQ5tHLcXlKt7noiIsSER7foR7KKD8dzG6ovB78mJnGCkl8wqOzP/knWnSmWUFG7ZxLhfh32ReF7+/R1+9GqriUW30A8GF6OFBRbK1WQ8ey0v7JvGrAKt34N0TiCq3liKORwAbWIL7+9tbzMbyBMXWk5bmMzmH0Cq8FBBp2Zin42kyGnKvuM5tqEq3qoO05cRNGPH4WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TugdJ2Bg+DyAyFUFXMhdpYGkMYSabiuNO4bgVzO6LTQ=;
 b=Z0azEK1FK3ftE5l/mnTf7gkrisjVT96Yh0+AINnMzNshzVHrD31xX+2QXB7O00UK8OxJp46ITI5Aeriwl2Or84D/wia+0v5IjHpnJDmKXqvpz52Td6J3HWVEuo/E/D/QLOs+8y9GGui2gS/SmNYRbc2YcAC0jSxXWNLHRpp861pWlngMvNqWLJt7+RzJYh+n7vyfMGttYKlOVhV5vm5aX93BmTkkLnTxTj3YgoG4sntSdxBthLO9kjZs4L+dahgE56SFYpQLe41AzuHolrgubyvBkhi7dkJ2jyP7u2mBXZJlueGs7e309ejFccspKE7EZBMgxXmtM/o49i0Rb24U2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TugdJ2Bg+DyAyFUFXMhdpYGkMYSabiuNO4bgVzO6LTQ=;
 b=DtuIdSJG/SQOsgnXKdtRb+iIH+4aCQdvpaEwNYGa1yL+RsvwcjUGaItLkz2eRcV1347Hpq6ybULCUEHRORFiiopI7LKgkVgbPG30kXW88iXPtVrm2zCdgB6hBeK9/VS2LR9wrZBJGTZipsqtSPfe8Cug06/dbnKTAtKYzAWIwZ0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 10/10] xfs: Allow block allocator to take an alignment hint
Date: Tue,  4 Feb 2025 12:01:27 +0000
Message-Id: <20250204120127.2396727-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:408:94::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: e21187ea-4455-4c47-2322-08dd4513b836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNPBBF9a6+1Qqz/35XUYLFkAlsEtmI1Ci5XnGjV8HzHkGYOAFk1LIMBtIAVO?=
 =?us-ascii?Q?9J0OH7EtXF2hR7MkYhyJUliAmK0VKBPvIxmxSNnHus/Wv3MD7Ookk80CNUgH?=
 =?us-ascii?Q?jjmVZojgvgWqa42FWSbLkrYI5NuPPPSzKW2rie9kb+QxFkkLgFqvjx5axg/d?=
 =?us-ascii?Q?GUo5ROtQ+4QMhlStr2/rCWcb+1uOOXdazsfV2FM4jNMRLidYhQefZCQfxmt8?=
 =?us-ascii?Q?hgI79zAepj4aoKMcbhhen9ZHZbK80QtVK3nHDzHSfUpZ77/v4vQl2Dbrjb5M?=
 =?us-ascii?Q?budvxUiU72cHNZvU+U0F9sYbenuylMXz8Gqxxke+aCF4ARECSLKvQBCWjILe?=
 =?us-ascii?Q?p6Wk4aXsj9rVo3Kr+lslkirK3YC4eNdQbPicxqZLUkjAvaG59YTBq18/Ukgi?=
 =?us-ascii?Q?kWS42HX2g+ipOTevtZuIDK82SqPjSJzK7qlk5SbZCwTrqckkF9UvJPn1iGcP?=
 =?us-ascii?Q?ndBoTie0W0OMVRgsZD+RcQ0LHs1Q58mdl/roIyxiRuhgXnDQkzwRcvZYURiN?=
 =?us-ascii?Q?c+wrV8WN0yINtgnpg2TVflDexjSndpKsC6MnbEUtrnNfqgdIP3cOu6zwnZjQ?=
 =?us-ascii?Q?FZ9m/yxKIFCDCQH3T4sbL+CBm+us6iWEqzGdV+2Q25rnszGhnf6zaCK5tw80?=
 =?us-ascii?Q?KqH5H3yL7itWT4zKZ4SfVeFgzDaLMnYKTiOzl+0aOc9BiQFOVTmf3hlm0vPR?=
 =?us-ascii?Q?htjo/8RVKUQXhHd1h7AgVtB/BFTNyNucBL0FzCxmqJfFdB8q88X78LcXktiW?=
 =?us-ascii?Q?NYYndwlqBebz5G8F4cwSLyd+70ZmZHHPGeioIBXeOx9mr10ee5YWbl3VcBfp?=
 =?us-ascii?Q?sLXd9+1/aejgxUL2JSGxz0qQx/bfvXhO1Mh5VEK04e6BktOuBXTTc+tzYP9q?=
 =?us-ascii?Q?asWlnlLdi4KAxRkk/9QBhJXrIXEXT8zArdY8ssSULaY5Nblccg55IylY8TeN?=
 =?us-ascii?Q?m2iB3QpdHR3ueZCwmgxwoT5efNo2P86PPE4D+8tLR2214VTJpg6KpQwFrynF?=
 =?us-ascii?Q?jk5uY0cz5zHNpwwEgDajEbmehzE1EeCQsptffnWH8eDjGe7ETFjZlcWo77BL?=
 =?us-ascii?Q?uA9T/1oWDUJAKv2lhgzQSdv8vLOBNjBPKxqIHlF29g1OdV8cdo22qS0a8f5Z?=
 =?us-ascii?Q?j841YW0D5tLq93w5CAo8u9jkApntyLJIA3bJ/bitaWgjQ0yfICMLmkBBReqK?=
 =?us-ascii?Q?RNlxNijOQumuptvANJU/9sUUq/Unr9tfvn6dKD0yXEFlmR83Qq+DbfsGv2W2?=
 =?us-ascii?Q?ELEZmd0jYVDGK2W573F/R24lmmJKYS+JwvQDdrHE4jjXc2bqsHJTRqOqgd2e?=
 =?us-ascii?Q?Wm3HtH5Uksd5V9p3oHgbQTSnGb41yKTfYT4wkYOMhCWL7R9njKWBuAurcwGJ?=
 =?us-ascii?Q?nH3D77HBecVZ8PzxxeJAXaZ3+Txd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?viTC76PNyUH3xogp4wiRQhRMtK8pXFR9+ILAABcdvLPukUckj4Y90F34+x/y?=
 =?us-ascii?Q?pLnU/5mi5JIqFbFxj7ioj6JY1xAVk5XJuncFDFemxyf3b6EknSPWx+/qDcOz?=
 =?us-ascii?Q?attiqDeyFnEtU1LzxMIVW74WjHHCJ/YcqzTg3IG1BFXJvgOgs6GX/arPJ2Ub?=
 =?us-ascii?Q?IYozHtNsI4Iy6qXFPD7iFPFWCPTcsai+M+TadxF2DuSPf1+aQD7e8zACO4X/?=
 =?us-ascii?Q?VcJhHfNJQb2Zcv8xELjOSetya983reMBPfUTOoYFSs8RiLYlAWleLE1OpNT5?=
 =?us-ascii?Q?7CpevsbdEj4yIC0Kl8tt2agwo9i7GE8SGYhL/Cy38/Z4if/k2VsEWrG257fu?=
 =?us-ascii?Q?HpaUdthlmSso5+/qVIf+xcJpuyS+4NAMVRJl7gf6dAZZtZMWy04BPg1PnbA/?=
 =?us-ascii?Q?uz95+N/s9tAdJlLM0hu9mbR+OFVUc0vPqHEM99+RW4CcO1tA2PpXxaXcivw3?=
 =?us-ascii?Q?XCketiTGpjDyp5N++IcfDH8vWBbMwXF7CfrBGRqa1ZYI6lWrBjMqKUdbpTeB?=
 =?us-ascii?Q?XD5G3crrNPDt0ehTd35mwyuWId6Hmyf5Fm1AjVDGbaC4p7I8UFcoxGTnXNHy?=
 =?us-ascii?Q?Mtk2ZEPQ0ux8k26Ap00yq7yWRFmc3wpJFnhrBFrvGf0dYUG64ozGjN94knMy?=
 =?us-ascii?Q?b8fgI7SirMFayLcbDojZ6dddU3S6wTPGpAqcFpegqi74jFkaegdEiwTN7n3e?=
 =?us-ascii?Q?+UH4rN9xL4g+8fBk95qm21+U6R2H8v5pwi4i8jUx4TLNrM5YRHyazNFpcuF0?=
 =?us-ascii?Q?znEHOiVkZQ7R7BI8SaVqP4EijS8uQygGgHUX9glwH4H8/9CAECFA8ZXf+0Bg?=
 =?us-ascii?Q?RMvLWsW3cPV+uDXx5NDB8t65+RGuOaQ2pA3V0vJhGLbJ2JnzzGs6yWhxgXtS?=
 =?us-ascii?Q?+e23IcmFvF9NXsDtI4dpa0J6tyXiOkdwnbSRz1ONCxGgg7axOXiGB3RFC8ra?=
 =?us-ascii?Q?B4U5yBf43Rq1jY77DcpEfeN3qTv54Zmkhh9C866tNMmIylQ2G3FV8uw+gQKw?=
 =?us-ascii?Q?RpABCslBRHNa6M8RTzhp1XD2lBCvxXfQdfbMGzS+ni9S2C49qeyL6j5IW9S1?=
 =?us-ascii?Q?w0GuDHsAqeZhV3yng0sT7Kg15r2G2b/cOVmw1yFzGwEQDrGFqwldR9FZrHmd?=
 =?us-ascii?Q?bRDyscGgWEzel0VJ+gwKjPDtWIgoVl5hJxsp7vCwhmF7VdmQsOmGBaxD+Ara?=
 =?us-ascii?Q?YE6QUYF1+EoAFoYCQwQCinMFVav5q0qBReQo337xDMCOfmGULeDJy3/TA8Sa?=
 =?us-ascii?Q?1BXSuCHRv3B5JSAiYye38V/g8B6r3262BHaul2gSa5b6096/7j0NOKj1tsyK?=
 =?us-ascii?Q?mSfl95qM258b7zQ9s1SpfMnVUTfUMykEcWRGdg3GFojnkGXOI85Iy2YIPjjj?=
 =?us-ascii?Q?Zm4Mglwy21/U6+J8bdJc3dUK1VIQZZ3TID1oqK6KxxfEeg5/dkBV33HfrLfT?=
 =?us-ascii?Q?uPWsdxb7+EGE4IYYyD38nmrrUFkgyXl4EmBp17fMxAwOslGC5ZLhIFNlrsFt?=
 =?us-ascii?Q?evgZEOP9hr27TovYJE1ACNjzrfRm+Voo0Mo8rwLQ8c39AonGDG7hCh/Faueo?=
 =?us-ascii?Q?HSF0dsA55Db42ytYWcX1kM5mlUNyswJrJMDxVKaVaL2LNcb2AnvIYY46hsBK?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QoNkKfQ+TnT9+88y1ZeaZQbGBy1GvaPPHQauwPaX59jlMbpdy8TADO0RW0F/VLpx7vbHAwDWuAQ/0RG+bF0M/ZhhtYdQ0zMWvvDrohhl6cCEWeFYDqLHcs2FMnBJitTfgDZRU9+l59iKlNzeOAEG8AzM+/cW9DCvAWBHlkfSki4ojtDoY2WKCSRdHdpUacL5od9b+5h5qDJIO/F+yl9QQRVKMaBMKJ90KpKUWmkxbsnydhwDXPRA/ex6boYyMzvsjynZAK+YgNXS5ofaqldTuelLUtOd3KhQufkqx4dk3Cuzq3yHrh8+83oIBNurseWmBXTGqPYMvqgxMUVBV6HhQv06FKfV4/3NprQ51PSQRLbCCSDiw0hC4U1XlZhlYA9eC5gjY5584BppP6nWM15cWD4gygZpgD8tkNfN6p/gF639F3uy7zBZUoAFcFBBoCAqKq1VbMPkuNRLBHGWdviOVaRKbRQ2KAmsBliLVDhu3/XJsSuWxBOGqTUzTa+SN7CbzW2vUzhWYn/jz+ZqO2Z28tPrpp+3W8aRqrlELnfaICkAMNMkk2FUjhh/wXIecY6UmcKx6C9YRY5Wv7w+XHXnHxDYGNPddjgUsUeVRbLu5IE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21187ea-4455-4c47-2322-08dd4513b836
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:55.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsxHu/OC4xbz6QmaXbYeIDUaKGICjf6Vi1LNEBBaOVWOhcougwVxozZLUB5S89DUF/4c3j07ds6jZzSulglU2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: Jvp-b1_HDeNxIdtcEZbaKQI4VapYJV7D
X-Proofpoint-ORIG-GUID: Jvp-b1_HDeNxIdtcEZbaKQI4VapYJV7D

When issuing an atomic write by the CoW method, give the block allocator a
hint to naturally align the data blocks.

This means that we have a better chance to issuing the atomic write via
HW offload next time.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 fs/xfs/xfs_reflink.c     | 8 ++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 40ad22fb808b..7a3910018dee 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	if (align > 1 && ap->flags & XFS_BMAPI_NALIGN)
+		args->alignment = align;
+	else
+		args->alignment = 1;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
@@ -3781,7 +3787,6 @@ xfs_bmap_btalloc(
 		.wasdel		= ap->wasdel,
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
-		.alignment	= 1,
 		.minalignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 4b721d935994..d68b594c3fa2 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to naturally align allocations */
+#define XFS_BMAPI_NALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_NALIGN,	"NALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 60c986300faa..198fb5372f10 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
 	int			nimaps;
 	int			error;
 	bool			found;
+	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
+					XFS_BMAPI_PREALLOC;
+
+	if (atomic)
+		bmapi_flags |= XFS_BMAPI_NALIGN;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
-			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
-			&nimaps);
+			bmapi_flags, 0, cmap, &nimaps);
 	if (error)
 		goto out_trans_cancel;
 
-- 
2.31.1



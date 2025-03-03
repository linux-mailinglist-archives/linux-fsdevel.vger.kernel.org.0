Return-Path: <linux-fsdevel+bounces-42977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A318A4CA1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC8F3BAC44
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F0253348;
	Mon,  3 Mar 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1T7sxTq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OzBkdlgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF729253325;
	Mon,  3 Mar 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021915; cv=fail; b=CytMjjnmWLa/PDbVICZ+d/WLiVkVEXRmSCL2wtgUM7FiqLjEHS/eq+N+r5lWjU80vVbf8wPjCL9V/Z7ZMhJWABMozRGDDYFl67iO9TwUZde+hj8rhNjXZBbjVBWjZxSeGzNvxJUSYLyNPTVecJ6Ciolyo0RRz9dokmH45hpri8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021915; c=relaxed/simple;
	bh=BLbwDKiELBy2e+k1mUIiQb8HZkntx+nDiWZLSXEh5kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VlKdIoP5Apf34ZcNwd6gv2STRda4R7bnQ9QcwX9v7yUe0sJIXwO9a4sUbL6xgcmlWna1W2yPYfV06sGgT1gLRIz19u7afftW2XTwRsFXlpici4rVbiDMJcNIoCcmAnuNOtauq4nYJN7Td6GTX4Jk39LxeyyB5ok7fgnp6nDqDuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1T7sxTq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OzBkdlgV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GXSWj015522;
	Mon, 3 Mar 2025 17:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gCSMxwYRZK1J/IKIf6CXsfHMMPxCr9kdpGpGCDzZVrQ=; b=
	I1T7sxTqDVe1byH5iDHzQBGJAf4EN8EY0jZJ3daW5abKp2LxH/Rye+8ycmJNznpP
	7oBApVi1MGSXA/t0C5ue6mhjLDs8Lglj5zzIReYPqvR/U6kYss9F5sXA8K4fsSmT
	uT5F+r5hh22TWphiG2X/0tWqhcYcgv5biRJC/8qc9BycT2JpD3tPwRgiNnCk3C24
	cBs2spfziCIKCdHRdcRW2R/mnaphe1lTml4KnK09FR4WepwFuIpax9SJ3Hq27bEU
	gbrALpWO8+wBHX3fl8Hip0kMmS0XHrLrjdEr8revJr5Q0/gCx5XDcIUfOBbh9WJ1
	rF4GwLSAV9yNysFUZKV44g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uavu4x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GKA28038307;
	Mon, 3 Mar 2025 17:11:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe1f2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTY8/DBZMO+IR3aNqjdf3M63J8EU9Rr6hq6RwLobMGeVkseINpeansxua0lpZaSJJFDw0Idv09V9MnTSK0IHaxiFNn4Rc3W7ki+z+WdCaqgavSzA0JLeUX8wGFhOh2F8+geoqB2t3/QhuSpxIi9GDw+PjhWJxUrngj/hDb5D2u/s0C/3mz1FehW3rL9MrQyLxUCQzCusvmP7AH+risUz6zq5wlkc/+Lqv4wAEi68kcvBsoiKFjfAUg3jbYF8fa4YYZL5aQP5UrnE8v3KGINQn73zT/QI51NS/EsI3XAs3nZ5a7Ro8HkhsqJpboG00ZttdxKzhkajeFszlEd2ofUHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCSMxwYRZK1J/IKIf6CXsfHMMPxCr9kdpGpGCDzZVrQ=;
 b=Ndb3K3YrSLQBHfe5cKeOaEJucJsaR/zqboXAy3Pyy3bShuXG754/ZXhYOUKAyuujZ2shoLD1rTvUmzp68WyfhQpUHruA31hVuylUbI4Rdxxsl+SWt8oDpbiCswZcQjsayCgcmI0bAnwcLZU6lGGz/3HiCXRErxBXMUQdkJ7EzdvJe0A2n0eR2BOjXsGfdS6S0engJAVbgVFVf7TIOrlAGbZXlToEutXHTd7eBA8ZMm1RkpWaoHHaq0K949dYY4etSf+ZQAa0k4PnVYVwWd5GROXtxyvI+rOVjsK8Ga+I7Wr9OVXHn/nybKXsIXXX3qfH/R5T2OJH7DepptBb9qjdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCSMxwYRZK1J/IKIf6CXsfHMMPxCr9kdpGpGCDzZVrQ=;
 b=OzBkdlgVwCAWFJh9h2pnvNBiQGfDfmVxxod3IOTHVxY4RuRdW487u0by0CzDfymzQD6MGuqkvnFGNUVqd3JrAApHyFEB3YpPVZhhyzqir326DLV2l1oFmc7aS915h4R7eSklSqmQwmZd6y6GRu7AzXUpxGkQJzHTlCduCzT4GPA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:11:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 04/12] xfs: Refactor xfs_reflink_end_cow_extent()
Date: Mon,  3 Mar 2025 17:11:12 +0000
Message-Id: <20250303171120.2837067-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 72df70fe-33cc-44c6-dbce-08dd5a76783c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vx8cWGU9x0+I44pitMU2KtscR3PEYdq585y6YPBtHOlNDLvCzFk8Uc2Ts5ym?=
 =?us-ascii?Q?ylcVw2YYJvYsPSfle8ms2tv1hsdT5fcBmvQ+o9ArkmLf4Hvb2p1xpP2j2Ruz?=
 =?us-ascii?Q?NmQJ89TBgv71brFsvDyMYk7xsp27bBcVKlGJOKo8xvUdO8lYIllRz/s+SqM3?=
 =?us-ascii?Q?7umNp+8lJ5Q3CBkqPJsnlhq8aMxV4PkGpyXqFxPWO6WTA44u66mDxs8d/m8T?=
 =?us-ascii?Q?HXykVTsp+NmrcF8kJUKhwqxDzeD5LXH5RQ1W6xM+Ybc2aaFjbJXppfM62Lqe?=
 =?us-ascii?Q?Wsh/gBSR/wUjfo0Dy10wT3YhK5dzgWrzFvZzvTnbi5ohvvpJ9dluvfNecuua?=
 =?us-ascii?Q?AMKcXRhPNYcE+g3ItlOp4MVXxKJpGXUAw2TOraRNxXG+qf6QwV43U+8A8o8d?=
 =?us-ascii?Q?QxOfvWCVVxYXoP4lPulVDsLFF7oCUj7D9Qige8OpQDBbbB610mqi9l4TwRnZ?=
 =?us-ascii?Q?xUyUj3dYHbCVP/lPcakk+gfhMXysZadzc0E8cjX1ztILMRW8xca0XS4R27cH?=
 =?us-ascii?Q?3ZSXEdnA9ZSo8cBsiY+W3r8N81wgb/aupq+lYy41MFXzRJ2WVRjMOi24ybOA?=
 =?us-ascii?Q?DevPdKLkjFiLg+vdAlksBV2IbAAAvU7g+c8vmBaYVg4puWtk41yigoUUW0Pp?=
 =?us-ascii?Q?TRsnOtl/XoIZZMw6XEdU4N73JEdw5kQBLffshKDebmlQbTAiQ5Xs827ra78u?=
 =?us-ascii?Q?OqHd1kqzxP9Q+Lz7H2kxhbYjd1uyY2ANa9XwU60Ij5SUhLcxP07TJ/azPJTo?=
 =?us-ascii?Q?qZAEuwibym/ylyEZZaCgjKMAKrkfrHTD/4uF1H86vtL6p58D9TiWo9E7Azia?=
 =?us-ascii?Q?s9gkf8HxG+TA0f7bvNiDOdXrPSr1h18RTDsTNuytAnFvnSrMkplX/XmRvxSy?=
 =?us-ascii?Q?QFyKv4ResCsRJ77dxOvKpD5UvnHWisa5Sdz5kAnAFi49b1vgdRUX/ImShLRl?=
 =?us-ascii?Q?oCpkbB2xrgG/XASZRg9q5sshDKp7W71x7+ppgNLURe1u633/sW0yeZejpt23?=
 =?us-ascii?Q?ycBh3Hx/rU8EFZTGtBJb7uUkaQXdJA9aA3hQ+64o9res6jh9h3C8smCGzjdm?=
 =?us-ascii?Q?svwZ05Ce3urBnp9wmBzJ5M+MJEQOi0PqxWDHQLxtbDLhnKGjcDKE3lCPijei?=
 =?us-ascii?Q?E+ZAXn/pgtDhE8/fugUrwrpwIiNqKgpanGKXVd2Oew2mcu4kRIE/OPRswx2Y?=
 =?us-ascii?Q?rCH0M52gmALLc4hg01+EpDKuAQC45Lfb0aZFh9NQfKvRdNnGvnJc6UZGXJz+?=
 =?us-ascii?Q?HVU4Q6Ky70i15A+NQI1C1iLeztFyzpNCyxsEo/5lQtL011H6y8H0jBRf9WqE?=
 =?us-ascii?Q?cKsPxNg68I+lDtFANBWO3EXkmZF8fh6dINurTEQdIR0Osnjx9eE7h4M/cL5j?=
 =?us-ascii?Q?i42OGxWh42dLJ4wCPBgGuF4j+9KB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcfjuQrQDBsKa8gud7e1hV3RhL/Dr4z+VJOyLmJU9ujNyeaHvyZEMzweCSP0?=
 =?us-ascii?Q?zpivZjI8QyYi9FfSJFxbXxp6ie/lACEowKX7EDhIK1UzwPdllVUao0cYyKfG?=
 =?us-ascii?Q?Ft5ExLqVd9Nsdqy2f+ij2liW9D4NiuHPQ7+OeCnAhURYTXE819tSOu+RY6DN?=
 =?us-ascii?Q?u2ukfz67iCmelIz+8yfJwq6qYoP9mYu48IXQ5T0Qa71EE62nDNnb01OnhLhI?=
 =?us-ascii?Q?feo1D9SU6JVA6ioz6uzVh/gu5Wfoqafq+lBJZHM/RA7ud7rkLFlKgZF882FL?=
 =?us-ascii?Q?CLq5v4eNIyXi9MTVd5pnK4jjgLhzJ3GWWp29fXDM2fuBUiNG4czPNLDDMgUU?=
 =?us-ascii?Q?SpW62KOGkJsqMa57wqzweeMJgpBN4T9umXZEWkjuqbXSPQwLlRn0KI1D843o?=
 =?us-ascii?Q?BK6MZ0A4jf6gui8ktVfaSocbKpmC5Tlux6MX4O8UXtZK71L2MjbfWgvGfOP5?=
 =?us-ascii?Q?D3cfcl2OKfzFNzThHawY7DGKUg6sp0MszVP74+M/HxmnAoa5OOW60+Yz8Hyq?=
 =?us-ascii?Q?ZdaYBNccR+7qMKgTn1yO6OZKrzwz7+myRa9G3IR1FXud711Y95T9+Q5pKz2t?=
 =?us-ascii?Q?bImHmH10OzxIDcloir9+c7KSnA0OfAi76uBbRrQlyprw54YEIAMyHTRvs8qS?=
 =?us-ascii?Q?Htw+UkMYXqGuLl7wxbVI9LG3JbFFBdyNU+g5TEC9TVfbWtRCkJhL2cbK6HLN?=
 =?us-ascii?Q?hoa3bMVY8OFNOmJYHKmcDTit864wGoU/DT0ituEpzihWToLVh5xcDjzSz9ey?=
 =?us-ascii?Q?zMdB9fbWj3R2EaiCU2D+vFYAC12k4/txXjw1+HTX1XieSRtP2mbZ5rEVCmqn?=
 =?us-ascii?Q?JN9iz8Y0tQLtR6ST53I5/wq9rSsq0FxcY6errwoUSyWLefEa+MbCLR1gm0SA?=
 =?us-ascii?Q?ETieW9djNccSnf0iWXC6XJhLrtPlcBhaDY9KTVt11vSl3IKk2AgwshzoGM2P?=
 =?us-ascii?Q?wwWXIY0XmkfwynhqaoIcoaohNegzhABMQvsTXieA8Jp5+dHyBrwzW0P5Pkh/?=
 =?us-ascii?Q?bJSKL5mAiw8ZwCdp0xW3YL4GxtasT73Ytv8u0TLCSi2Wk7n3mX16+C+G/OpU?=
 =?us-ascii?Q?eVf0MELZl3viUvfPrKaDIJ8YvN0aZH9XucKbJu/6JOQkGjMYOCN4kCDUpETJ?=
 =?us-ascii?Q?vAVYkPlgeKHErXPRp++iK/W3pnoyKwkAeIwp1XVQv27hN22CduEKbs1UI9wU?=
 =?us-ascii?Q?7LDs8FSFVB03utZ1iebyDx9Suk3Qee8/0ZLDFSNABYXtDxhqW7waau1iQy3T?=
 =?us-ascii?Q?iQJFMaWiiQhuz5esMUsYKJReEa3MbHq1TUB79eZgU75xmOcvJKVNpXjHbLoZ?=
 =?us-ascii?Q?Fi05/EBpvVVnLyuguXzBN/pRcaz6gUK0PONy5LsW9rIjVIVNCmHNMWgsKzt/?=
 =?us-ascii?Q?Mvm6sphf0vLwRpqQfj3rPfsVbF0a2TrQwSv3gEkL1oNjZDWGXaLIKqqmyR/b?=
 =?us-ascii?Q?wJo+nzXl0+1Q1PQrQZqJuA/eDle26/F4Hqa3nILPWek4LkI+ebHwxTsp+/O3?=
 =?us-ascii?Q?RbQBX/3K1nJC5yi26VVMu/ERgY/myF3/bwdUb/wNxsJEB6QBBKeLpjRAift4?=
 =?us-ascii?Q?zkRLd/+UKOqeYObndsF0PGjTJ9gaJINPaaZDnoZs/mScvlV/FlZpgkiNBEgK?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fRwqhHvvrUJAnB+3ej9u1hpOGcbt/4Lz22ca0bkeLMgxEHjQUBSAZJ6wCtTeXCa7GKhHEZFYcrlqd1PB03H/v5cjcJ4XfJQ2/y9vaSkR+q0fS37CRGZPQgjyIX8+R8LGwWVtdGqABCHxFuXYC5BLONzzq8/bQCbCMKcjwMs6V0ZAlKMmBt6432lzhAu6F5IWP9d+jGghDh29N98hl+Wr8xfuE7hCbTKnGyMp3wLoliUbSNVqx5KatkLnsVx5jzY7CyolcCjRvDNuz7dhUFxbIu2cMHfHXBvfqUv8mH/n+gms/l79iFhgyb5Wh8/2Bx/8E87O06IAU0enmLOzcOFHPpwtIi0E5GVjR7qFA9zzn3mbvuTtGABfrv61pV0ll68GeCrr9Wdy5dfwvjobSDSXWMMa0tjkh3EvMqhK4aie307RuZRxtLEZdHw15TE7sicXPkhh7+a8Z12uv4B5tkkUn7brMyP4me7DIKJfLTu0D0DIG0h/B2HJQ0onocZUz/z8c1LIgQg/letHEpmTz/QOWBqn6+TpGPENoA/eeFquNrD/3i+oIj2i6ECE0+BNmFot+9jgRa1f7PwhMAFLaZNqOR/dojJ04K1eYNh3/DkngXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df70fe-33cc-44c6-dbce-08dd5a76783c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:42.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvHxJc6UgbzBDr+86bGj+OpBr9tlQlo9SiXPwgBLunxJAEdN8Gh3M7X9bT8SeF8rC0Xn911DudtXgxl91H0I2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-GUID: A9EVtTglATzCT7_VkyE0Fx2V__pjUD6D
X-Proofpoint-ORIG-GUID: A9EVtTglATzCT7_VkyE0Fx2V__pjUD6D

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 0eb2670fc6fb..3b1b7a56af34 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -788,35 +788,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -825,7 +809,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -839,7 +823,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -848,14 +832,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -884,7 +868,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -901,17 +885,46 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1



Return-Path: <linux-fsdevel+bounces-43927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C554AA5FD55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DB73BC20F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379D26D5CC;
	Thu, 13 Mar 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Av7HuVwd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sADk6DDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9726BD8A;
	Thu, 13 Mar 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886036; cv=fail; b=JZGZ1IzD0emy3+WaviaBDjrI8cqQx6m2a7V42nm0NIiYjay/qQcQgi2Hb5EbGM7DhAcyoH/Qf1AAOhpFDLOZHMWdPWAgS76s6vPaMugQPhlIu0BvPTN4tclskXWXdrqJgGsz4++wBy41JpSdppBNZcm/7q7NLUzzUxwdE4bsnI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886036; c=relaxed/simple;
	bh=zAA7aPZvQrvow04gOQwjctQlzwbE0Zf7NEICbqapJ4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUVxHPvAH31g7XSYzGUrZyZSdeEgdumGJWBADFJ47zFIZlwWq6XXDE2fpg3RgwPh01/MLjfRQj9tW01+YLBDkqIpZyOpAL2TAfWTyepk/FJ6zafRvmd9ipLrSqd4YlmkJY5SXH+dJ6YkE0uPGRy09OLVN4BEFf89iHFES+FFw4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Av7HuVwd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sADk6DDl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGto0g031915;
	Thu, 13 Mar 2025 17:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rSlhLfdMpFpmVdgfoOaSj5B+fiHz/24J46hcIDzKwQo=; b=
	Av7HuVwdAJd5NiwtnC93HKCVufaot2ijO40hxuqtZjRKehzp44a/+/Uqs5Yfit7O
	QjJG2Q2desMgeefNFQxE6oCBpd3E8IdvqXHVmWQhN0oZsuMKkZV4otdfcbLnLFo4
	/OCeCJoT4O0An6pl2Sy7/60Bz9NX+Ut31ubJoUo2i4G7hg9nv9x59Xd9paIzghu9
	K86uQNCkmKm8meKiwqqCZENAM0lhIbTDAyZAmE08ROaqlokpjZcSBfpBiMgiVdpx
	W1w3YTMWitE7WlXhHopz1uHp9bg4j9OCz4+b9qktGil4CyNN0ahysApBeveRKOhc
	K4D+EImtqOz2lWoKiFxD8A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4hcse9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DG4wmw002399;
	Thu, 13 Mar 2025 17:13:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn90p3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxmXauSbKwWGc0aH7ReD+tGYyqwg1rRvjHz0U4EQmGm33hvFb8uIcxKgRz0t27G+iwSJp7VnsPuUoM6GXx4U7jEmZ+iP33hPB/v+g7YBFmRKp2V3bSkfz+n1AdGa9wTtXOziaGK8ynMjTLbFY3W+suR1VJocjZ5cQWEPOjJuAhMFu3DTnRre4bN30d99W4Z8Detq/LamTdz3XFKTz6fF7DNbPPN1QQ+SzW5cuyN1y/m49fZ6D2qLXJGamc8hzNLmXbOQyUJJQ0Fkn0Tr84f/tOBOJvRK9ZfBSRhuR4qaSYqKQ6doRH4IBTAweQh+Kj8DTiVmAmKI76pLl/Qb8Us3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSlhLfdMpFpmVdgfoOaSj5B+fiHz/24J46hcIDzKwQo=;
 b=fS9QnCjTB+hMeTaRkRs3Nku2sYWTk37Ev3/xRNKiXMUOCgi/02EfzFIJH9fgcgUNpuPq/1l2+14t0gkCVw5vnsrixf6i6ECf4Cea4UM/j2YY0YNCYbOvno7sh8x8gIS1LkLZ3DSqSLTz6wwczhLvMLLqJd3VLh92eTNIoxDtoYddDfR+V3eAFtYErya9XVajT7RPCvQhfNsqxLs7y5Xq965Zh7dW0KKHTBNauoAYUjUb2zMzxU70MyfFUSGUPYvnkEYXKtBIXdV/UawP6OzxCcnFphoz67T2Jt2xjXdo7U8ovtAUrAipCm2gwIQBCJycoVFynq3Rlb56s5lXsRrLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSlhLfdMpFpmVdgfoOaSj5B+fiHz/24J46hcIDzKwQo=;
 b=sADk6DDlIuY11FAc0Ht1sOwWBK9ofMHYAc4CjBvPgYWer0/Pgn4tpGWNdRmqG1Tryg3hkTwAB+QcgxxBFORI7y5oFDFf/9Rx4Kttmy2LJn13/2Dn9N78qjLjowtkhYyo1Xpnqhv+Q4Xpg+WJ20edmSVz2+kpnJW5UBM0GGQE+1k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 08/13] xfs: reflink CoW-based atomic write support
Date: Thu, 13 Mar 2025 17:13:05 +0000
Message-Id: <20250313171310.1886394-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:408:e7::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 98734852-b13c-43f2-43b8-08dd6252644e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLjrSnjWGLe/GniYzZAKLkfwycKJMHaN8VG5VzVVgaygLmogMWFIxjiMTxgA?=
 =?us-ascii?Q?GaZ5HDH/70g1aFaC4PMHYd6F5b7iYlutNQ7asMkPEwB6fjoAyLmTAd3cnzCe?=
 =?us-ascii?Q?1NbQloA8TzpcMSXu1WnQIIKbGHTADrblT8FkgL+u1AB4QFWEgD498JdwvrQJ?=
 =?us-ascii?Q?EHbosd7oTSwxK3215/TZozTXvqHhvvEt6AHJb7EDQqv8GxBXW+lUxdFihkgC?=
 =?us-ascii?Q?AmUaTtE+mSSxm2LIL0S2VN817UG+gtta5+Xci+D/UFsKZ3uCCLgPyeQWou3P?=
 =?us-ascii?Q?MM+CLrMroRbdmEZ8GBlWJoNYEMd9/mny8Q7hS2N6TF6ScL1IDRFHESRUN/RN?=
 =?us-ascii?Q?vYZE9Wx06umgoGCtzz8Up4pIr7bcH+o24AQOEiFRNwzWG7UrrdnhvA0N9bL/?=
 =?us-ascii?Q?43d2w7Kq+0N1Fqdx9tJ8PhBHKIVCUjkETDtjsMAa0szQ0tCv7dc5bsMC9PHO?=
 =?us-ascii?Q?eEfYRCL6EMO9dVslexrZYfDc5m9ttH6y9Db1LgukR53ggmY3aXqPs7ZFL/qI?=
 =?us-ascii?Q?yW04MBNpnm1i0F9Ppdw6r40NagDCB9kMWeR/YHgHAy6PJU2BsL+mDVRgYAYq?=
 =?us-ascii?Q?3KuprDIMqHSJJU0PkI9Oa46QzLFhZWnhPIwQHd/CrbENsmJTQMT8eo5ghB+Y?=
 =?us-ascii?Q?jI+22fkeFGI02IsEvDxsMTgSnqHkDOninM3ajyfO94IRWMc9hge0JXnGn6OA?=
 =?us-ascii?Q?3MAeLw4Tbz2UAQ8k+GpdnKVlq2isDK6dN1pinQiW2oyEPrqm3cCzguPHRjQs?=
 =?us-ascii?Q?Pl/fI3eFdWYDrtOX3UQ3GzHhCGwrziKfJGAuN7dYaVR3mugd03u6x3kc2sId?=
 =?us-ascii?Q?i1Ui02OfaKSajlYIIGUKY47OpnhVC3NiHy5xeNWpq2GQJh2zasw79DUOHs3m?=
 =?us-ascii?Q?o2J1waV3RyOpSr9/A2+kAAb6I+RGrLAhh50e7fLtj6d6FfYcLfdAswURLrtd?=
 =?us-ascii?Q?Gpv7AhKtbZwXHglgi/j/Jm0kbreNmkHhXAJM2Hw3vEs/CPpenFH50gxjQVoy?=
 =?us-ascii?Q?NxQBDcIhY8qjuEQ9CZdcyAZQkpFu8HsAJwPlLl809FUkmCHS6gl/3FV2cCgV?=
 =?us-ascii?Q?SGRZ/wii3HbxbY52koJFM8TGrWkxSoYCfnqO0ATTBSwDdUH9kL5E6YTvInnz?=
 =?us-ascii?Q?wmZVp9p/ZMoW1tP+FjTC4daSJ/40yjaBujYgWGHViG/pWf+lB//JFJN0ZPYe?=
 =?us-ascii?Q?DXb8UJ722Qj1SFOWMLu1iEdd6EofuZ/nzjG2eoFjHP+hu0bx74F1b6Zk1XBg?=
 =?us-ascii?Q?Jj/YVLy70hYzMakprfcZwfFR67srnwnMt7XQE1iVyfquFKr+ZQY+JBuGw7EG?=
 =?us-ascii?Q?7qhHL6SmhxWm1OCrnsMAUgBR1a28fM+I0u7OY4tYgUZVTOpNStq2oirwVdOl?=
 =?us-ascii?Q?/QzQigqtokoa9iCc94HaCfle/LM9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9OCQS5TIzd2nL7gva9DI8NRP+YRXZS1fpJjzVQdhlFoSnwBG/7gVfHi+1yHt?=
 =?us-ascii?Q?5OEJAWdGLZcBOfh+mbBKP78APOxwAc8gfjjKrn7cHhIsxdpKow+dnyb6bnx5?=
 =?us-ascii?Q?iqGtnzjFnKMF/+fXZRYtwzmfKOVlQ2UsRE/gRRynms9Xzct6456joD3DCkdq?=
 =?us-ascii?Q?/YVmXYxxNwMO/AbWtHVg/xBY3lFGz6s7q+WtQ1Sa76K8dSacCw7GLQ+hTsCK?=
 =?us-ascii?Q?WrpO7OTCFoWFxkYr0H7gnIdYwtVxsnaOZ+mUybgZqio7b/QEEuCaQB2QFAEA?=
 =?us-ascii?Q?4Dh+CUdUPU/lfMXl+laaK985PVKoGexwbY/6/cPAmq6RZJLubB7ME3U/Kgn+?=
 =?us-ascii?Q?2qGIdzIUmiB4whm7mKBPx4fVzrytAJx+84Lro5C3DxLX6ex+/Un9R9VYoNTM?=
 =?us-ascii?Q?YJMvBSn0lxS0vxtW7i1KMmPIODzjoZp9if3u+leNdL3kYph0boYWkCHDqlWU?=
 =?us-ascii?Q?VfVpG5lFKPjz3ORWqgKxQX4LW2mlf67tiWt/O02Fv4i2B/CxCkno45nv5H00?=
 =?us-ascii?Q?wp/eGC+9Vq4hlgUhUaMUspDnLrVnqsbPmUCT1tujt+GTJIOkYIVZTpQ/p4fR?=
 =?us-ascii?Q?4NF3uYWbsxJN3Vw6gR/8cJSxoAqd+0YIqEzLGSvy+MqZdC0cESaoigl4q9Sh?=
 =?us-ascii?Q?DvRHesPe1RZUUh+9ZdYXdGkz4NI4w5nd+g8g07NdojI9HtynFjfik9yTUkws?=
 =?us-ascii?Q?oPigesGNSHYZE3ZqKzh33Uulc2nENyWAV89EB/XrDUyrQkU3SdRqlJF/DGdC?=
 =?us-ascii?Q?3Y6OBRL6vRCGUdHYVs4p7zqR2JaYWPNGzz+KnoC+k0m0ywX7kKTdV6uAexsB?=
 =?us-ascii?Q?fhySswFenv1HyfML+3D8A1qATFLjPXNl1XCNCEKweIqDmthTBL1v46rosfM1?=
 =?us-ascii?Q?H8U/E1wXC2w4SyO52RxnfnmpmCpv3ZVqIk4nWR145fTuMCsSFlKV1Esx3fZp?=
 =?us-ascii?Q?vvsmBPQnib6SzrZjjW4hHELkC9UOeec9XFnFn7Uhz4KnEfN5fFmSc/OFEhGc?=
 =?us-ascii?Q?fF77SD0760siV4VmW9dUOD6LOqGSALgNJ0pjzEM9LeGshqUGGpm8rsNI5OBR?=
 =?us-ascii?Q?iP0tRJSbcxJrcN9lCgPXK/NWULmxJirdUz6mJq72Hjp2DnCiGFw7FKDWwcYp?=
 =?us-ascii?Q?tUBMVVld/0tdlDMp6U9ZrnKA/Q99wQe4UuUXmROBhsU3EDGFuWa/d3f9ABuZ?=
 =?us-ascii?Q?y6WnKcC3GPrGj6iNuewHOXFVgiWvKfwu+vcB420yY90MrNb0dxjeT6ViQeGs?=
 =?us-ascii?Q?y3AntmLFQ/wGvd7rbFUFQP9Kmcp4GpcxJAXY1A5RCfl/n1+Viu/C3n1T4//t?=
 =?us-ascii?Q?GyDclEYvkHwUSvuxE3E9DUpCGdHeQIwcr/6ilSTuVZKAmVEUM5g5nwMHDYOk?=
 =?us-ascii?Q?ZX4cyxoH5sxQPnAm0TO1qsGX6yN2CYO6RiFOPPLgzprP5i1jWlVjVYJwCHSe?=
 =?us-ascii?Q?eq4R4dPwX/JfaFUAmB9PDtFyk8v47/xlDc2ikoEDTDmQBHGXr1brRiZkwQvF?=
 =?us-ascii?Q?ENJoUOzXuid5msjIKjqzb0B1XyAun2ZHcIOFaXc4AOvQxPtz/iejLO6FE6eC?=
 =?us-ascii?Q?3SjNUXNpJoWXa5sIQIjtttxyt5MHLxVbq5Sl87xgE9br+p/XjBIyiac8gXRe?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IXOX7ll0QnHePQgkfkZaVuIRNN7kximSU93kiW2jaXPiJYQxbokpVoKfmQxFqQP/5+RXVYMeqYPiT2zAs32mXf5tNrt7bi6TsASm8OmMOyo6oZ/XR7TBzHwF5XoUDTpeud1xBAH4IL5Jr8cS6q0hN31vqTxO1w8qKnxJAZZ7apr9Io1IlVfcUGJyntqiEqmc0V65D8Zf3MUFEA6l4LXkip7f1lJKgWCojzgyxEQ2ejMsBPPaqP6hKtERe4X9z3bME+GFL+tMXGheo5SGRuI6rafqAuPvO9WXQQ+vb1o50sQlsxhXENu3b5fgj5st52wv2zI/hOoYykQptZOVKVPaYAhm1fC/AgTsXjvqK4K3QDUu1nsSnBLJXHNoVcc4WWaVI+xaC1KUJsr5OdSYhQcyMN0cKrP0Q2vCigldCzDpfIj37pkyzVXLhDmx6g6m2390d06wNRjdinOcPHpjUSxBfoeptySVLrnYNyzvEEsmCofk/jGpIjUawxYOO9kN4Ecc/r+U2I8DLGqUxvp2//LClL2WKGiKRCa2DfqkjR+TC0qHdZj3Ki1uT+rPP0CCHX/ytCQLbJZ8ta9jXbRm5uwXLExDHRRKljRkkc8sWxkUf8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98734852-b13c-43f2-43b8-08dd6252644e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:36.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDC1n0jF4rT5X2lqF8ielDkTqKWdMyC4VncUR5Tuxw4zUHUnS6TIY380FBVv49oxmg7XS7YbRtN2iJNS5iQ1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: np4HNy4fquf37NCZ_XgmAkdoDZ2YqgTB
X-Proofpoint-ORIG-GUID: np4HNy4fquf37NCZ_XgmAkdoDZ2YqgTB

Add reflink support for CoW-based atomic writes.

A new flag - XFS_REFLINK_FORCE_COW - is added to indicate that a
COW fork extent mapping must be returned from xfs_reflink_allocate_cow().

For atomic writes, the idea is that first a CoW fork staging extent is
allocated and then the data is written to the new extent before finally
atomically the mapping is updated.

The semantics are that if XFS_REFLINK_FORCE_COW is set, we will be passed
a CoW fork extent mapping for no error returned.

If XFS_REFLINK_FORCE_COW is set and we find a real extent in the COW fork,
then continue to return that directly, as this would this belong to either
a. the same CoW fork extent which the atomic write previously allocated.
b. a pre-existing real cow extent which is unwritten

A atomic write cow fork extent should not be shared with other inodes,
and will only exist for the lifetime of the atomic write.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 18 ++++++++++++++++--
 fs/xfs/xfs_reflink.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 674a812ecb4f..690b1eefeb0e 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -466,7 +466,7 @@ xfs_reflink_fill_cow_hole(
 	*lockmode = XFS_ILOCK_EXCL;
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error || (!*shared && !(flags & XFS_REFLINK_FORCE_COW)))
 		goto out_trans_cancel;
 
 	if (found) {
@@ -582,9 +582,23 @@ xfs_reflink_allocate_cow(
 	}
 
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
+	if (error)
 		return error;
 
+	/*
+	 * For no shared data extent, return only as long as
+	 * XFS_REFLINK_FORCE_COW is not set.
+	 *
+	 * For XFS_REFLINK_FORCE_COW set, we always return a COW fork extent
+	 * mapping. That would be from either a previously allocated unwritten
+	 * COW fork extent, or else a new COW fork extent needs to be
+	 * allocated. A previously allocated unwritten COW fork extent could be
+	 * from an earlier call with XFS_REFLINK_FORCE_COW set or from a
+	 * earlier normal unshare of a data extent.
+	 */
+	if (!*shared && !(flags & XFS_REFLINK_FORCE_COW))
+		return 0;
+
 	/* CoW fork has a real extent */
 	if (found)
 		return xfs_reflink_convert_unwritten(ip, imap, cmap,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 18f9624017cd..f4115836064b 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -11,6 +11,8 @@
  */
 /* convert unwritten extents now */
 #define XFS_REFLINK_CONVERT_UNWRITTEN		(1u << 0)
+/* force a new COW mapping to be allocated */
+#define XFS_REFLINK_FORCE_COW			(1u << 1)
 
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
-- 
2.31.1



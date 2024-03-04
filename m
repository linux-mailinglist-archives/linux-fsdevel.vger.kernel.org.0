Return-Path: <linux-fsdevel+bounces-13458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A06870212
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B1F282C9C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A623F8F7;
	Mon,  4 Mar 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oVv7bLYh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OELpXlc/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3F3D98D;
	Mon,  4 Mar 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557525; cv=fail; b=s7o6mN6aPL018XyaYAyHd3cw1nv79SLbWXKsHeYx9zZmFblufhSiRiMSWfPyNv3DizryloT01rk2mZcaFjk+F909hkiY90vW5dSdls11M6E36m9ksiS8A9gKfBbilpo0BlRojRP+I+51xuVZslQuRnlYMPLRrsl+0wt7MElL7Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557525; c=relaxed/simple;
	bh=z5kVOe7JLqM7hxtt0Rcv6dFyxS/cazNMp0CGhuDI1wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q61NZj3uGaITxkBxRVZQSf0P9cU/tuP2DBCFVE0OQfKmQQ0w63TGIkrXe55mXkItPkyquoD5xE1UXnTJhRytv0RIs0J79Br0dYWPFWC4YXWnV2Rfe5t2RVvk/LSahJ0gLJqpMFzCbeQmGzxVlzZPPzn7hcBHA17Km5jmgDsrGkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oVv7bLYh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OELpXlc/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTBGs006563;
	Mon, 4 Mar 2024 13:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=vWqEZRauMLCEuyAifF3eRr8tHs1zawA3aqG+JkoQQSY=;
 b=oVv7bLYhDkUiaBziKpW30QDSaLx41NKomk/m0OM2W0qQBgamT0ktbSDbEqNTyQsAYrRV
 rkqUjBpONclsZ0UjNgOv1u6vuLRfZCEFL3peJhU8pe5ibqACktoXOnLPWBzKDrTmeBB5
 a4cy3o5pUXfPyx3KsQwAqb8+T00Kisf2j0lTAve3zujCzr3w7imsDVl1FumSWhpVTJn/
 HCsoTPNKPGXVBbHL32nw1ZqLrjqgim7Ypc2WLIE+bovnZcb1RxVzFGpJFSq0TTc4byqk
 42mU01KlbpJ8CTsKqQymys1UySwFDkTTJhlfr90WuSK3HEZUbxkQ33bK4ggWVpIskRkf rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthebktu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424D0m7f016930;
	Mon, 4 Mar 2024 13:05:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qp2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldQyZnqOfGobXC92+ooLvbQfN6FzGGCOlORiUv1GaiEtj6NrP4SZ57EaWWQ+Tqi9YsJ8GiatrwaTBUq3P00POCqIYQLHCX7u9T71oDR9lscaWETPulzM3kLAefbPTUnUSHv/2lLsFkZSnuo6KJRnGaw0MJpNhJmup/ly8YJSgpgR5yTtXf4r2NqPhfOsdKhW4EzRXLDXcq33UFp9Gf2flusEOlMb/E+uMZAPwmbPDidkglpnu+KmthL8hc7GRhse+ufeSrPY5d2Ccp461gceqQ9XScbgopKpcfkD0tSnxz6t3Z5bv7A4vAVAaKyVLAaQv43s7+fjQX/0nL66az1vMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWqEZRauMLCEuyAifF3eRr8tHs1zawA3aqG+JkoQQSY=;
 b=jG++op4u12o/oFI08YeHaPk2pmiPODhfb0IxVgCTSEffWZTMgyF8jid4k7jrAv2LQyYWZe0cLYWtpq/v869sf1sNPag/FnWJUhE/SohFHJHrhWUwXK40DjBdE/xHBonG7eUcXflygjxz5XJ5k96bdEXtQvnI6XHNmWlTZ4bp8pk1KsKpePJ2q7z2Xp+hLmM42oD0FEvcu2Yw/RhfEQ85oubCfqT3pG2tBmyab6iyQqw0V3fc2IbpE8gPYTrb0jLt6iAi1AOiBaY4L4Hk1Bf4g5FaEFqQ2pI9/waLmRPwpY2r9Y9zdifdKQ4Hb8BmoTS4r6cUOKU8VwxcGlc2aFZJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWqEZRauMLCEuyAifF3eRr8tHs1zawA3aqG+JkoQQSY=;
 b=OELpXlc/ZP/H5pfqYvHcXRwiNIkPLiL0SbBCx8znKFo6G0ethRtgAECrKAE5s1zZGh8B8T95qae3MnLe+W1LRJqwwT0seFPfRXi/NI/gGnUFoEYhZVXWiCDLzYuFAHSZdsZS04eQA+5SFXYjMOGyK87M056iTC57GyNm61lT91g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 04/14] fs: xfs: Make file data allocations observe the 'forcealign' flag
Date: Mon,  4 Mar 2024 13:04:18 +0000
Message-Id: <20240304130428.13026-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9645b6ab-b197-41ff-74c3-08dc3c4bb666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	L+1SfFHDjOGuHUP3qD8CrXbrFmc4cXZqTBlxk6/siSWi5Q+wT/aaJmJJJztWCyp+WuA51J7+huE16CoHy2SoHt2d2OE2KkjzDSWOlqHoxEA7CkgvwT9ipnNTJt+DSyt/FXlnkYXmk8g2S+KZdc+oTFnVCyuuHltSGoccfWjY9dBIpmRwfwyCgIh3pDoAM10mbInqUxcJ9hb5XsnEJloPWfHQZyxF+NOWxc23hnvL8EFBslTf8+LpuIldLSR31IkM0Rl3vv8JENpDfeKmbrSY6jaVhXE81TbjNifvN20m+q6WUpLuuZrBi9tVkGsdItxsA2UIsZJvP6eKRIOHa0yeWCssRtWuCGYvi09T++80i/66oUaaKmZX2fmLSiIXuqxAmX41lvwPyf6n2L1sAeu3b68SHD+K80pl4XLuvxi2X/8N88iGBliYU/SOz0Db9guuqORkQaz8UxRrMViVPAqFocAc9cfX+x7iAnbnKsMjB481yi9weuQjBQxVz/oYc0ocdMPfG5aeuGma6Ti8qFmm1Hf7+NXOvhnrqlyNQAW7BEaFhY/nVfeFFsAa2RUubLhQcmb+iukq+8LA41laKcHBGsRhIEtd8XOfybaxf6JlIK72YX/JhmxZoU64te2bEVngaaDNxtMKJ/TxqnwcSWn7wOBHl1DpSiPKx5o5xCfyesM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2mkuQ2MP77LqZBuAX3c0D2xO4u6J753w1x+WddP0AgdVOUyBSNZ7AmYPwEbv?=
 =?us-ascii?Q?19MegR3xZfcKtHGYtMRzdMJDQBnuSS85LoSVZ1oY3IlbR4dJW+/H94uZd8OT?=
 =?us-ascii?Q?euOB9mmfoAqmMfpVZuv1ogl3pDz4Pzb5OQqVy/xzdR6tIfz7AqQl2i9EZbNh?=
 =?us-ascii?Q?rorB32xwrnECNrNbcCSvYFpvXmaQ5D2C8482m2nuGX/9r4/qD6DslMs7krbs?=
 =?us-ascii?Q?ogI1uO5cUTEjTeJz146Ve9ZlU7c6nzkgbF3oZPupomK6QX/ZH2NKDQK3E08S?=
 =?us-ascii?Q?NWkVP/X6/DPOlU1rjfD/fYf5juHHuVXSMXpBU7gOmcVNH4/u3E/zIUOl/oNj?=
 =?us-ascii?Q?klQptGcWjHW2x6sCbcxZ3M4Gpq7a/xZTAlj/Fep03FdoXkiEtVK/HrUOX2dk?=
 =?us-ascii?Q?LQBPSAcl28RthL4L6Fj45LF7E5IGQtRV4bQNObwVgEogzyQxwaXAGx083MCY?=
 =?us-ascii?Q?zvMPq8VGwLOl4HKo7jbnFfURkvj+LmSEG78+5q3RVoAWlQMmpiXHZijag3Lg?=
 =?us-ascii?Q?kEIPszrSNUoKrO6dMEAbYdxN1NQNzSrz8i/SRaxdnHxkrexrhgjWCd0/Lagd?=
 =?us-ascii?Q?3O7UzgtAjfkpBXLsI0+GB1u/qUOr6YtAqsjNqasC/lso4MV+/7PQo/D4jvcG?=
 =?us-ascii?Q?gzCgBXkKmofUbMeZ7jM3OPhMtIIUZ1eFUAjR7wPPIkmLCDyGZpsFoaTI7xB9?=
 =?us-ascii?Q?f2CeZFBv+TDhtBm7D+rix08W1tOd5nqHy2tuIkj9Ke7/IqAKbfv+iODUfivm?=
 =?us-ascii?Q?cw8hccgBGsJTW1eJ1xJfkiFrK8K7LhkVDh+fv/sh+Ms2xqJog3UHQbQdzjle?=
 =?us-ascii?Q?P6p5k/Lm3W9DeMeG+1Ox+Bu/d5rfsgd6KOJk1u9qv7TSzyjVEBSkBYeaIwGh?=
 =?us-ascii?Q?uxpbymOLqjLq3+oszEB3XYkRl/k9pRNiN11KunftXkUgOtsO8hxjCq+dl3PM?=
 =?us-ascii?Q?G9Jv8LxKckuUsUaaQ58Hxs4GxIjL/dgxTZlbzcLkik0T60+H2hNaUjmv+8Kq?=
 =?us-ascii?Q?eCQfnC41+ubxgVk7jhzeUbPUvj2EZOxfJU0NinFTKAbuaPxm+9mOUZPejLVu?=
 =?us-ascii?Q?AX/36Y9Px7ZgC7VlkwrXlnHD5Gd0zoptT+HNLgAZetvmAGoE2IjOvJu6epi8?=
 =?us-ascii?Q?rtG507Cot2C7vvEaoGdPQTYjRhEQ8CXPi0LtZyCcmsGpafEhemF6zbP80Z0E?=
 =?us-ascii?Q?sELQRAREb7Jmwf71pOOHPLYw3tim4XfpTyKT3lRKo9mYP7VaMor9GYN54/5d?=
 =?us-ascii?Q?n8ekzjlDRINGqi09KfDXI8viFykglVFGOxpq/1GsY2rWV/eNBSPYLiSIkcm8?=
 =?us-ascii?Q?9KEBBdyI3MxoHyx4NH8MQz66u3EXTKcX2mIOxeGtkuNBqBPoLTVE6JK0JPBR?=
 =?us-ascii?Q?xlMQhYM6Lwks0VWjPERPJAuyCYkHrwqmMQGVsvhAStck+8AI3/2RywBOKqNa?=
 =?us-ascii?Q?VhR5ix1JsmCGpmGgN+I0yIoSB7CRYc7g+ig5SFirLD/w+lFKx01tWjt5jY78?=
 =?us-ascii?Q?2HA2iAzxxWEYN40gdEH1H1fL4+S8sY1e+G9GB9QbtxbFy1s9xYnDUC2Lh4OT?=
 =?us-ascii?Q?vP6p7S6698CC8HS/RuumJzl51eZq+fHatOEOGIYgPJXyHLQhi6HEfrxO7F53?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wb48EXPZ8ZOYYvs2XqMiwEHfqXKac4iCez6fgtWPSzML6w/SvyLj55KJDQV7TQRqTx0MpLyMZ9MF4OhDTsy1UtFgqHMAiMIr8+kVA9rx8cWKHdn2gdgkwG5gZ7vkqwJGCUfs+ppRtm/KOMlQlkv4/T+qnA5q8CHisd8HIHr+6rSbRdUYVajvBRf2HMQ2YLaSn9r1LXjqJ2SKf518f3ylHFcrbTt19IuIwsugb33QEtPrtLbuJt/PvuD5E/K/aJIbxO2oG5rSOiNNp+aE8XOvjfRhPXV1cwAeIq+p2cCZytotlHKrSqlw+iMXeoLSW7KIN1Y0L5T/j/woLhFeaq1xT6q8oyDj/KwDuGQcpB4fraQnzNFxnhM36C9xhedLTRQetx9fd8GqkNQ49bEBjOVQ1KZa37eYqHabWvkIciQwOKdsZ3G7KcRo+mn2t4/a0/in4aJ7WFu5sGqQlUUW7n7UCpWwVBkZrL+QQtrrPqRtr0nFh8PHGxgF/NNsLW7qtYvNiEm19D4GTKpEGKgmcvgyrk/OoalLu9dLwKb4KYeZzK+PX1wQ5G7JZ/tlfVNsEols1r8Y5Shhnu2F5DQ2DXStulm6mJD4uM/nC2PuFd6Rlzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9645b6ab-b197-41ff-74c3-08dc3c4bb666
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:06.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMBGPa83PN2f1EUJCo8/zRLB3QCLAg31VmbpEyU6cHj+HaSFM8NBI4J0qeXos1FPxMHtwnNW3A3+yK9jCIgP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: 6Xr8T4MKQ-Ioi4bh1YQsfOitooYWmmfX
X-Proofpoint-GUID: 6Xr8T4MKQ-Ioi4bh1YQsfOitooYWmmfX

From: "Darrick J. Wong" <djwong@kernel.org>

The existing extsize hint code already did the work of expanding file
range mapping requests so that the range is aligned to the hint value.
Now add the code we need to guarantee that the space allocations are
also always aligned.

XXX: still need to check all this with reflink

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Co-developed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 22 +++++++++++++++++-----
 fs/xfs/xfs_iomap.c       |  4 +++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 60d100134280..8dee60795cf4 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3343,6 +3343,19 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/*
+	 * xfs_get_cowextsz_hint() returns extsz_hint for when forcealign is
+	 * set as forcealign and cowextsz_hint are mutually exclusive
+	 */
+	if (xfs_inode_forcealign(ap->ip) && align) {
+		args->alignment = align;
+		if (stripe_align % align)
+			stripe_align = align;
+	} else {
+		args->alignment = 1;
+	}
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
@@ -3438,7 +3451,6 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.minlen = args.maxlen = ap->minlen;
 	args.total = ap->total;
 
-	args.alignment = 1;
 	args.minalignslop = 0;
 
 	args.minleft = ap->minleft;
@@ -3484,6 +3496,7 @@ xfs_bmap_btalloc_at_eof(
 {
 	struct xfs_mount	*mp = args->mp;
 	struct xfs_perag	*caller_pag = args->pag;
+	int			orig_alignment = args->alignment;
 	int			error;
 
 	/*
@@ -3558,10 +3571,10 @@ xfs_bmap_btalloc_at_eof(
 
 	/*
 	 * Allocation failed, so turn return the allocation args to their
-	 * original non-aligned state so the caller can proceed on allocation
-	 * failure as if this function was never called.
+	 * original state so the caller can proceed on allocation failure as
+	 * if this function was never called.
 	 */
-	args->alignment = 1;
+	args->alignment = orig_alignment;
 	return 0;
 }
 
@@ -3709,7 +3722,6 @@ xfs_bmap_btalloc(
 		.wasdel		= ap->wasdel,
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
-		.alignment	= 1,
 		.minalignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 18c8f168b153..70fe873951f3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -181,7 +181,9 @@ xfs_eof_alignment(
 		 * If mounted with the "-o swalloc" option the alignment is
 		 * increased from the strip unit size to the stripe width.
 		 */
-		if (mp->m_swidth && xfs_has_swalloc(mp))
+		if (xfs_inode_forcealign(ip))
+			align = xfs_get_extsz_hint(ip);
+		else if (mp->m_swidth && xfs_has_swalloc(mp))
 			align = mp->m_swidth;
 		else if (mp->m_dalign)
 			align = mp->m_dalign;
-- 
2.31.1



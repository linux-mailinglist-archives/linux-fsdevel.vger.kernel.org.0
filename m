Return-Path: <linux-fsdevel+bounces-13469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF4870248
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDD7287EBC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB853FB20;
	Mon,  4 Mar 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aA0lwIoW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QnwwdA8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3B3F9C2;
	Mon,  4 Mar 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557663; cv=fail; b=UJO6cDgrDdP5J9uHPoXBKhqMYp3mK1WtiytOZt214MtFzLCfGn6mrV0CLsE571Ojjvk7xkG6Y9j0hWgB5Ld7TnzhICfHY6+qt1rcd7V9ErR8tQpCSFh3l2P2/xCWV2BcnbWqQI+otVCaya1XwS+UIzW9/+vd4uLkqIoCiTVKXew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557663; c=relaxed/simple;
	bh=bya5+n1lE9I2rj+emKMw47YgA+nop4TXUk+4hhTNEbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auzyBL7h+Z0XzIIOD/e2MUr5eJawi0Xdrrdnmd5bszceCYNxuX+Sg1ETKZkD/4+rbhoJwgDRpEUQMJTklyTzk2Cj75JaekjiTUEFFNACEC38RYMHGJ9bcIXoIdurGUvKXASDMj8hAs3bcubxodAeggEicks7786lKxWu293JgyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aA0lwIoW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QnwwdA8Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BT879016931;
	Mon, 4 Mar 2024 13:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=YKeU5/UbS9tXv6rTbtg85ISQ6CHZttBeC7rs34WbSAM=;
 b=aA0lwIoWkbS4znMDQyG1rOXUmdF5zWmeIUWIngKvrNVq6Qy7QFFM2R+4FCiUt34aHbLQ
 Mdo7bHvZlywyr0DA/l3nM1T1p3874lgropE6g3IH2raGZs3495iUey9PQMxBsShMllfW
 h6CYLH04Up8xg65eU8ugScNyR9v1Vt86dKTTHgUJ9Eo89H8iHo3GsbViPEuCU3gWzeSA
 5bFPKtTpaTKDwHoXGRh1OUCbBfjy4Tg1o5U7Qx/vzYbWmIkLWtqzyl482C8NutWjMyF9
 fU/8VH4U8fiigy18orp2wrG60Ws6ifu72xjSxQ43qwP5bUUBPnfrfm5RhxLVTQ2VdRM2 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dbkbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424Cc6gG015200;
	Mon, 4 Mar 2024 13:05:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj607gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAFCtZNIdk2i041Xy5WXnjvlOHlyWVom04xg1C3tbiOoIo+xOmBP2N+d4r6Xxk99Dg3VMunJX/3XvJUhT/6ffQlDvYMwzej8sN/p7MPXQegXSWOnY+ZyodLIX8CcMhyg5qj3z1e676s8a25E/KWYZcLZwxGqIJVJSHi2OwJDRUfVTF+br4TIQOv/ssW9putJYdZGr5dVcku9DTatgUasj3/Oe5zfIuB2lQK/6ygGgUOGNiC5gNAvYo3ViZBKtz6Wzdv/e5CdLFItFJH9ZTazy5EmyJ+nvwZwp6EPrzhaRuWROmZ4eBLgkXSBOoRZkA/4li3XxPjdB1ho/QE5AEuJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKeU5/UbS9tXv6rTbtg85ISQ6CHZttBeC7rs34WbSAM=;
 b=d2B1zaEj8duWDr3rnsKMr6aA4znB3M3hM+aANUTZVo611TDnHyDkAeDravff6/QMqmJInAiA/MOLvBFxKfdWXXjwuEeYVWg8d2lPdysDa9OdrzZeh0yoTdw0ZGqgaOFKtRyf+Mf6caKSFmJNMwjFLkfQu/KQ3NTUmRiVyAKgmMGwUWsFBhe2MoQCYNPLVVCp+oW5GeC82gKjtJHYy8HC9Q++2/+ne2EfIFGzLsEAu3VeBWO8qwAPHyDDscSVRiABhVLldyWiHDWi0alcjm5xTX9tFuYuoimnwzoO1k0sEpLd3yeZ0XUT8JJbLJcOyY3qDZpQsobHZFxfcQ6pNqehQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKeU5/UbS9tXv6rTbtg85ISQ6CHZttBeC7rs34WbSAM=;
 b=QnwwdA8Qwiu/NWDsoazTQjtaN8WPyRzwXC8YY/AbfE9m/L6Z+FwTanPV+u0kSgK1gvsQD27a5u07wg1LBkHabBhZmv2B4TYXpOhdBz9Z+gS2bRiQOsZSOlC9PByb7zYjti5eSTFSnrUHmkdWD4SWavo4uxagnlb3Q1M/BDISoso=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 13:05:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:25 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 13/14] fs: xfs: Validate atomic writes
Date: Mon,  4 Mar 2024 13:04:27 +0000
Message-Id: <20240304130428.13026-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 11aeb72c-93f6-4dd2-a632-08dc3c4bc1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UF2H7eJDpIGtXh0Cwl4MQQnAab8li2phPunS+E+aOMnjxftTuez6MbEe/fHBycYKMsKuU3uiunsCyg5o6L4Ya+0kLSG2EHFBFyZL51W0wFGuXzjAbb4G74DNMHiaJ+qI3aDIP3EJEQdJig+Ka2GeBBqKzKfh42L2PnV4MiYHQHC6EOnobCpmAFG6OcuOVZ3CbPa5RmSL9mKPApg/KNKp3nHheX86xaMLJnnoNdRFMOTsg/Jz+t5BL5OfRHeogTWszjF4WODh8n39xK27NnWx+X0B7Bu49t4QYkesta95CpaOY7cJOmNY+gH6jqktdmARx5DZZGQ9DZxNy3C9++zOKSqekU5zhAc50kWsyQ+Op3cu4pEucL+oaznTR/RqrnLrOAYoqnDA5NKKfm+59xB3TL+xDwxLOMiVfZIMOqTSvJ9KTFwtSjXYxmEMNJIc5nDvlfZwmtfyaZgtVi9boRPNxmfDgTMj4MPCnvIE64dcRnIBF9pwvZdjhNIu3FsIGhZ5LMOX1P5Ojf7qh2xVLzPvghUflVh3BSsa0MT6CKmHysVm5pPk56fbDxyzW8FLMSko3S6MTbT2iXp+Es2HmDQvo2f1gr9cUO2FUEnLAbjI/Cudt2jEBudZuCS+k+SzcFUkjZDyswetlYVuIomb8969gLUAzsg37shpwQAGcvKG3SY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6MJxle0zvcJgrXnbom0zEA1tRHlkLxt3gObr9E6KyLjhNKQqQ2vUNWlzTtMq?=
 =?us-ascii?Q?LrCeRUwWwvzjLDXZy2OXthK9DR+z2DkhHh56TcjwAA+Cb+iC1PCPVYs570Wc?=
 =?us-ascii?Q?Z3glHSQsTttCCuepFpk82Q66AsXvFYHoOnvXXJFz+yhSMDrtkB8Or8t/9i2P?=
 =?us-ascii?Q?tzZLmdWZM0vcLbBEaXFQwlQoh47+mXUiiFXZHp59FtK3joee4kDxj4eiFLYB?=
 =?us-ascii?Q?eBe7JYHHMDzoPOwwbCgBF01c8s4gPAsSdzKpT+y1mq5t3hoHHBbUTZDKgBZV?=
 =?us-ascii?Q?pj20MZCHTAj8bdXEuImAnN4wGOZtrFm7FWXKFegUbZy+u5NJZD3agOLQCqUo?=
 =?us-ascii?Q?mLGxMxy75AHMPJxBWjAJ3Wp+QhDDOJNdAYXMAH8c5sg5ZYlUDX1iuipuW2fz?=
 =?us-ascii?Q?ILzDf01p/ws7Nvhk4QqishG1rXhivzlIkFLGsvQ8zyup3OgrqHNi2SSbOucX?=
 =?us-ascii?Q?gSca/06bMB1HbC9rSsmk/VssRmlSEJuRj19G4BZHjvf1AJVmUpK21kdRfQhD?=
 =?us-ascii?Q?YdrSXlrM5QpCVskVrkpINIEdVkEtg+Agg/65AFVH1E6kjjfXi5QBy3u2aoKw?=
 =?us-ascii?Q?XWSlT4KnGWTK04OOfkYHBtZz0LVQ51uNlDn5KKcHG16OgDQF0QXYMoByyR9W?=
 =?us-ascii?Q?TKYkBCuW1OcTbOTgBYTAzV6OtYL1fy+HEc9gsSbElrEi4MmOKu6VwVCbMvtc?=
 =?us-ascii?Q?GXhaIdTF3u2Z/deUWFYQQ9DDpAWLm3XhIHILC6/Hv8WNMNRbN3OhubPzZ3Ka?=
 =?us-ascii?Q?QDEnIa4Enf/Rd46vHK8oKzc2ogHIvPd8G2CVvTRLitTIW/0gshQpzeZxyCTj?=
 =?us-ascii?Q?t7miU5AjMgacrPEZoV28pglF+/8waGmVXZBIM96dz0FUjlWc5VWKxot6B5rT?=
 =?us-ascii?Q?j74bWmPMMb0ItBi/HXmh0a84cE3asdX3lxwwXq2mZoS6hoOf3ii2dXOZ6Fk8?=
 =?us-ascii?Q?V8sIScjycVyJctBRdHXFTAkr05T8qbaxvJP1jJazK7jU3T3xkdV7hwRoxL5I?=
 =?us-ascii?Q?b4BD+j4aLAgle1qs8CzZ/5nrl6votuCOZTaChdcsDz2RWHg9/v4V63vDbnIr?=
 =?us-ascii?Q?RZ+GD2srUl8C2JGY5SlpHXQiWQQqOUrlPcmZcskzUFfbeQqK19s3jiE/fkgE?=
 =?us-ascii?Q?yP9XFCTnf8YNs7t+jWtFDgMwOslbCqJQJhNs0XOWbt6ITrW9VwWo98ffB4WW?=
 =?us-ascii?Q?tYn6AdLtf4+gKK1xynQke6LpX0gX7gvDnAVSk8rSY6nzBNZA085YA45ldgKE?=
 =?us-ascii?Q?h7oLtZ088Hxf1l7HJ3tHaLvqOpc/PmKWB+kTCB98HA2BItAbKRFTGlZS7VyU?=
 =?us-ascii?Q?+bqJYhjbU/MiqfG58JvVaPZ+O0Hn46Lrb/7NUaUKLNY62Be05iAkrPbdnDGS?=
 =?us-ascii?Q?nWIG9sH/IsCOMX5DFFFA0RZGzIMpBEqHmUDuOpTInLzF6RlmgSQmlb9AFs8A?=
 =?us-ascii?Q?9bMw80CPu82po0H0lrNX8xT+5ayrO+FBGo7wGGKt5/fCZfhspyMmcyKGCloA?=
 =?us-ascii?Q?RNskE56Ivj7XP8sFCvONPxA+K0ZVlghJbdg0QLhLD0OFCSHsIeDfbo2qFecP?=
 =?us-ascii?Q?j9wf2T7CcAEiDNFe3OHtGkDCL10JMBydvRC7PmKG/rvtMgUc46u+6I9fD1Yj?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Xs9hehA4fuTSSukiqrJ9XFg8/SHD7toJS4PKHp6eg0U+SRkdMH+Gr1OcJC2nL4yAW6M01tpAUMicuMk7Frg0zvCP1Oz1pituhUT/B33ytvq+JNYtAYCRwxhN9mH+RjlgnBsAusPn1ywLtVI3Q7qm/ZJELnJ6SooJy4r4lPBO2/DQcLjH1e67n71cE2CzkXGtif1CPR4uJSfgj3qHvNocar2TrQDLlRW01yMcpI+kP9/mERWnC5HmO8ArN8xaD+oCvMbBsOWpVxWXv9YtsTDOZq1UYThGg38BcWM2QsrMnEb1kIJj7v6OUtT26+RWrHew2YMte7bKGsalGUDLtHaJBawsvRsKVoM1IP7+1s/xoYEbLHA+V4IB2BOiqVIokaeZcJBiRKG7Ia9xBnBRlSrgZP93ATvsmhzdMamzmKiDISXaO3tRqQszmGIz9g/pl5zAoakVCf/A7DeKoMjlQjueCyLeZjeJfYWwHDGCjo/KypwigDa63ttglwyFNy89TrqMcOdUANVnBrLOJooXQup5HuBubBevERoWH9TtNswj76sT8+gep9SgBlWev+qR2St4oQQjh9YUsQeQVbcQIlWH48aSYlXNSXGbG/n6YRR147M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aeb72c-93f6-4dd2-a632-08dc3c4bc1c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:25.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2jT+TW8QlCPaYU+plKS0p9pWyXElOLrHKhUI9jDOWl5RNvmjpQYMhl4acSceXziULVz8MVK988wu+ofhmCmjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-GUID: OdW0a3HQdkTLDYAqz4R11zCLjRCmob6_
X-Proofpoint-ORIG-GUID: OdW0a3HQdkTLDYAqz4R11zCLjRCmob6_

Validate that an atomic write adheres to length/offset rules. Since we
require extent alignment for atomic writes, this effectively also enforces
that the BIO which iomap produces is aligned.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index d0bd9d5f596c..cecc5428fd7c 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -709,11 +709,20 @@ xfs_file_dio_write(
 	struct kiocb		*iocb,
 	struct iov_iter		*from)
 {
-	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+	struct inode		*inode = file_inode(iocb->ki_filp);
+	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
 	size_t			count = iov_iter_count(from);
 
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		if (!generic_atomic_write_valid(iocb->ki_pos, from,
+			i_blocksize(inode),
+			XFS_FSB_TO_B(mp, xfs_get_extsz(ip)))) {
+			return -EINVAL;
+		}
+	}
+
 	/* direct I/O must be aligned to device logical sector size */
 	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
 		return -EINVAL;
-- 
2.31.1



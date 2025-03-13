Return-Path: <linux-fsdevel+bounces-43931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C58A5FD71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5719817F03A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4126B2CC;
	Thu, 13 Mar 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YDMYM5az";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s3cZIsRz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C526A084;
	Thu, 13 Mar 2025 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886097; cv=fail; b=sgVr3XEIl1Ro0z7yScBPL+rjQG6byj5U2F+tX+bqDIEtxjNF0w1JV7aEIfw2/r4QSliHvQoTMXro9DBqqP6mJB1LT9mhsHwz2ccn1aH4nd4jboU/jhZ6SUHV9gdfTop5KGAW9SjTsm9Tt4NFRkKiCoJNziiti7/WUHErJHtqNu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886097; c=relaxed/simple;
	bh=te4syDCRWfaVmtxUNIxlqLbOyVJuoljgbl+C5TTrqVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pt+Brk3LMGuTvyM/+UKsTJnofbPbqy8XDrhCVkwzyzi/IeN4/sMJ+fn/+d+8oC/JkmILh3JnhJ4pAenKHBnNYGauktxNGNEjqfndyOs1MUBfX1MIJjp+ILArzjQWUkHm4Eam8XDDSl4iSLGQD636ZGnBrqIfW5KoUbrJh7lynUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YDMYM5az; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s3cZIsRz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtpKO006995;
	Thu, 13 Mar 2025 17:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R3HKbY4Hbei3+mLT9Y/8EExioRxpww7HTGmTBPnNYsI=; b=
	YDMYM5azsYLpX/4fOX7V2KfY7F3dRC26RmX5A4p/XRzZoXZQC/Witf8bMSsAas47
	Tjl2h0aVoPsw+0ws0ZJcf/C7385OGeBHuggUw58FXR+DHdxetH9SY5U7zEzyjGNv
	OmjUUeSxK7XRS/uzL+pNGsf0RrP8VxND6oVwQqfXYvDaU4hiugzbg8urJjdfStp0
	lT6LVtEPTdLWrs++//3rhQUH48GdlfPb9Pg1jhwzUjDQyK1A+yAWe/Ojja7vd6zd
	fJ3TrHnsjxqZZxcS4SMrZweBWXik6F9hZmhjKoZkZ+7nYINwwP4Sgh6adk8v9mNd
	Re0oVWBPcv0zkFg6DC8ulQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dmrt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGaVT8002391;
	Thu, 13 Mar 2025 17:13:44 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn90p62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2J8K1g+yyZ4ClKJvwl5I/oWn1uDGB+bxUsebbql7G2TciHX3T0suS3+kSiTeRH4y++CR0pCPmMxrvCTkLcAyXT9j1CFBoAIxMJ2o8xFXVCm6X0dA1jVDD10dly+E8EeZqwEIQGyaJNdpADQOwqgHlUKZBdJusdH2DqGas+W/NFQ/+apQU/K/GhJo4IZhBaCprWJnygoSE9rpTh6bE+8V/mJTkiSCxUJh2JF40DoNXQjMPNYecmj+LaUH9fjYTlFvU7aBU4kELMNRKGMXDGpNaOBMCMQLOGPA9GLkcUzlkKAPruPdNlC+wK5pdKbUAeuyZLck7fhuz3+2MDSXPBrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3HKbY4Hbei3+mLT9Y/8EExioRxpww7HTGmTBPnNYsI=;
 b=GpW77DybpnbGHEV8WlnjTIovSm6JlPT9AX0HoOwUYxYWKHgUf8aDPZI9ODjsoCYXCYIX7EXqeGvy+ZC/DR2k5wJm7LhY6q8lFLm2CFQjH6tRdYW//0Z9wd/50or0zbEK09R5gX5qmVUd6Ie1qQVvukKOd9e8h4j3940laxepuI/FHQwQtEeXgtotV0MwhoqIcx/lC3u67FWk0NhKGlOwab5bM31edf7rNUZYSA7FbW8hSQwjyxvs+knuDkLq9vIKO7XkH/12dzsP+n6+15Ljn3k3HYXYPQ2+xMZDfuUIQW6cJFH45ogmQqkLCj3ImWCnlu4IK34qpD3Gu5kw47551w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3HKbY4Hbei3+mLT9Y/8EExioRxpww7HTGmTBPnNYsI=;
 b=s3cZIsRzXfpij4XwpBjzJ09b4sb0vrPVf4V7+9v2uSnGvZkztlkkUm4yHwg1d1BesiSEUKlunigFZcEOnSkRVU0m1YotcnLLC/7jRrg9MXm9Wrt/dc1NPUpOi65XTHwhKEqtWrBeweGtHYe8AxK6aQvkej4ykVIJJuxueWDfTH0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 12/13] xfs: commit CoW-based atomic writes atomically
Date: Thu, 13 Mar 2025 17:13:09 +0000
Message-Id: <20250313171310.1886394-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0645.namprd03.prod.outlook.com
 (2603:10b6:408:13b::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 2794c045-18a9-4ed4-fb0b-08dd6252679e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cnFMOrPL9G1OnMNK9WDKawInT4ITvUQ1hjFvvuYCra4aHBkqdrcUWU455qQx?=
 =?us-ascii?Q?K7VudMxL0AgxHUrYIeiYw77lPyyy/zuuCNxFBV7uNerUra+CB0HdRGenkjb1?=
 =?us-ascii?Q?fpKnImhWUVVM7cfCtXsMC5dcIRW8wDJIBPiVVs5IiHTHsvzMbZ+IWtyeCdzM?=
 =?us-ascii?Q?Nfd+HxzDKXIdO4FPiUN1xStUcGm4WWAsNxb+0AErB73h9GDhB6/EQ3GRfQRl?=
 =?us-ascii?Q?z1JLxPDMA6ijvhqkgT+2/vz0dkfdYLDFMpGm5sCuoBfmyx7R8MPQ01IOwBit?=
 =?us-ascii?Q?SrBTTetT1DdyuXIADJPaKvEdjz4c7CDJVzBmoJphBVTUF6lXDhQvY5zO6SVV?=
 =?us-ascii?Q?sUVSQjveuS1DmK2bTSorQGDC5LJA0P++8eBavdiFEHkXuftAoHid18xcfopi?=
 =?us-ascii?Q?eZekVn4o0gVzMDLoF3ub10RaORSIm0X8DwfoINtdDKMK867gHcel0QgY83PA?=
 =?us-ascii?Q?2PAr+culZ3tFjJ9xtCtb93mROqyuR0uSFsFqQaefAzKu6//Bh8CzzY3Qq34q?=
 =?us-ascii?Q?B9WwHd5opvm24vwpSB9mcmfbFey+iOzc0Ix4o7PA3ShpisVJ/D7oINc37PcO?=
 =?us-ascii?Q?RQGypqaqTswySOk2VEFnXpqsX7Mr6Hsl5701u1/MptkJzt1X4xYc7kLZublq?=
 =?us-ascii?Q?eGxBZC7PchtFhtmDNsAyFjlemgps/xTh1PA2z1YAZGCkuobOpnJtgk97L8G3?=
 =?us-ascii?Q?lyPzpvLAlwTP4ths0hxGtHNRYjJdb7bjzLdM5whQYZIUDx/72NpIorrTjmUd?=
 =?us-ascii?Q?ajyxyO82ytkuUqel1mgXkLeiXugthEuGwQsBOx2k8+mecqHMgpvBDL3n3R8q?=
 =?us-ascii?Q?Gz471XLu68OuhYBrVPXO81cDHIdW/Dys99pX6CszOR+CZAN7Tx2fd1mxXVX7?=
 =?us-ascii?Q?gsjm6cDJKMDXKMzVIsEQbtV/e8hC9aaotroyNb5oQSao0NYZ5rBn7aPGGrut?=
 =?us-ascii?Q?BpExElfEVptsA/zCsJ0weJpkCN3WQW+U0WhH1f1YOgehIh5vPyowT+Jo8NLx?=
 =?us-ascii?Q?tmie6sXT9qGYZN6JDncdtPM1MA0wRMs7ny9WihBjEwMyHJHBc1LEhn+K/DEW?=
 =?us-ascii?Q?zeLPWyFhFLLfQaxEqNA19eC03upuiA4exWI1xi8DQXs5Myy4CGb/nntmX69c?=
 =?us-ascii?Q?bb9NIE0fXQCpzmu1GrsVtQpkRPDGS/IJ3YtOQifLNXIwiBSageAjtlTzRGVl?=
 =?us-ascii?Q?157arokeKNAVj3EbjnaulbQ3O74mfaS4C7dIpN/qSzVwQCYOmoJK31htjw9C?=
 =?us-ascii?Q?wXKHu69YayhkR4yr71kV4YP0ALOkC6YG2qF3j1v/N7t5O52NrwE3kUwvJOY3?=
 =?us-ascii?Q?MNTUil88TmnCNl0fr7DTynya9j81kzJipMK4AhRX/ikR3LR95auPgtct/MPc?=
 =?us-ascii?Q?a2dtoppNoWTSqDfb4oaGeYoF77D+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TXd+imwkBba63AgsieH/HCcyPbDxG1nHFELdcGqU7NUHkU4/UAlKsV16SBsp?=
 =?us-ascii?Q?HSEnpSux/H+sHEiTWVquHirpKTKjQW7b3bLFnbxlMbibyd0nxZHE492hiaFm?=
 =?us-ascii?Q?UnqkeOenJeVPeJeTSQj6FDVY/Jv8NlhnZC4XhSaGbjRaPfgOLUaOt5ezHYmm?=
 =?us-ascii?Q?7BLiefViRR1IXZBXx7viO7CzLI9p7ws2+tlyE9SkD1Lybs4I0sjBkh4e8Bfq?=
 =?us-ascii?Q?OV0Fe4PeQCvYoP+ZTDKXDSFaR24W5X2UDcKTYHWIHv7/Zp79af4TU+Dc+Jao?=
 =?us-ascii?Q?fCdCABEcLVwzfOMwj/Ql6yzSDPoWOMVSCTt5nVoUAwa4+Xf18N+7R05sumfN?=
 =?us-ascii?Q?69UkUOa6NctY87yDiouDscIf8JXazJql7nsFsZnKRf13XHks40dGd9gAusJQ?=
 =?us-ascii?Q?0zYnQOuU24PxWIz2MiH3c7oHivc/S7BErbsn6jR2zt4hYkwly7MlughnJr4b?=
 =?us-ascii?Q?z+pxPvIH+9UcKkG707k4VQVASAE6U09i6V0pLsavjjw+512Z524PXNLFIMpE?=
 =?us-ascii?Q?mUJjt4KtPZK0DcNSpLuLZSCC1d6MJkUG+LdhO6eljxj2VVNgfKFkVjivpyIA?=
 =?us-ascii?Q?qXul9i4s9spvr4U3nVZbB5yr/23T7SHSETkSCKtbWk3z5nySpyGIvSzAIJ7N?=
 =?us-ascii?Q?uhHjArs8HqPvYnb/7lEgoYxiiEjSA+vNWudoqck3kz3VW/iniFlrT9ymyY5c?=
 =?us-ascii?Q?UaGEUj3WeMSkhM6IUcbHgsC2vAP6BAHivRT7K6syp17GabQD3wCFCmsuF9/+?=
 =?us-ascii?Q?NMcHmsShKnamS39+Djtv6UifzgT1++4tdGSjBU4BLryMUGPu1Pp6bTF0DF5r?=
 =?us-ascii?Q?VsndteCPrMB+ITI3rEsHCyzfb0xXnxgqHeZeXLtiKHohZujSkTn/xNwOqtUv?=
 =?us-ascii?Q?8aH+ya4BA0NTTdZZBpxb4b11o6dUYChWDko4b2KL8tTg44HjVt9MF5xRX/C2?=
 =?us-ascii?Q?WsRJo3w2lFaB5QdxJD6bdmSJWb3S9QzEBavJocKqjZc7UuUEzZ0zDjervypc?=
 =?us-ascii?Q?PrCG9NLb7FvVOflkkVPWotPke4OAB8rxDd9Os5moyaEGaM1wcHMsBxVBxE3x?=
 =?us-ascii?Q?wJzni6SVRQAcgIhBuKF75VQ6lsZu/hhHYZLYonXr6T74Ai3s1aaVrnEkNUvQ?=
 =?us-ascii?Q?5YBoDN3M1hiE8B2RUhGL9tiA93DU/8DLj6HLhYhMiARVLvP/oJ5llZmDg0N9?=
 =?us-ascii?Q?XwOY9QA7ctkT5eovh4NAHLDkUD96u5lCx+3BWH7kkjcphLQrwsezBYBXuVYZ?=
 =?us-ascii?Q?7j81bSbKYcUOslEvA2zq/bQ+hMokC3JmH1WCA8Mz073QkO5y35SnNNUQR0td?=
 =?us-ascii?Q?YCqpTl24pDLOSN0xg8QuQpYW9+3tUoZXW1oYF+UOPnjOVBoDZurrtgt0ItKN?=
 =?us-ascii?Q?bjLId1nFk999K68HXNofWrX/Lh5xO8p/B8z50Gnsd67OVVepKOZHBUmkixjY?=
 =?us-ascii?Q?Y/gwlU7DhwkYWoecD+Q/QkdTwpMkvpy6YzpfwG5RdH1PioL90SQFKfEY2e2Z?=
 =?us-ascii?Q?TJ67usHoYZEzddeTitPsOdFFFZmnUJDpu2bXk0QQLNyYwP8jOEoFUpM/Zm5J?=
 =?us-ascii?Q?ZMMhZuqYAyjxhviJom/p0gxLKE6Gb8EYcxzimUfO5bn27Mz8QjnpimBmRqY0?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lFr8w+DFDaVsIMu8hPeZsWucmYT4HF2I4vHi8qMuBvwNzEuvEEVAhJ4FOcCB0lJUhR8cHO8d1++QQti/JGAHPg+QRIRncH/tPVJFZN53zkInwKxF4cvVjDkV/qzdLjx+pjF9/tbv5C8ucq/X/b4H4l6kQ7djvYSAwWeykY0/CSOeBzINbS5svjjJPEfNkg6olbyBvsoscU93O6MHAddricj8fugohGS75SvV5izsDYbtWuXAHUHjOrw/YFtaab0F+VpAnldSIOcxD2eGNFeC8bs+1ECjpBhyXNjd5l+bHj0tMx3N3LR6e0Eoo6NkEN+jYuQ/tL1UcUljGZwFc4OnLsotd14zv5IctxIeWFwj59a0H6n+DcflrwUV4A/wgo2CdVxm4YMLyO8Rywm36BHgX0YG3wHmzl/7aBSBDSTchl3U0NFKOgzJMhdi0OHSMmrvpKOmunmWjB7fZHD0VHqwPd12ETntOM5wYKBiIwdXqHHcl0HdNEF77OjtJ82eGyjN+CzkBzhj4zf14rrFDEH7VKmvpSUPgwNPxorEhZ5meFOQDoAo34EzJI/f9uHiC9qQyzSHNkWEcaUUy+EgfovTqkpK7dxaQpFHhikWYSjwGTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2794c045-18a9-4ed4-fb0b-08dd6252679e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:42.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdT17nu7qtO6+AxJOJrNZWa0NyUj3wyWVLU1yhAkapv8fYs9IzvoodL4fza4/iwfzCBtjPpaDNpIOtotKF7Xkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: VR4hTqV5soxA2MDTT_Hd3H52tP1hukYt
X-Proofpoint-ORIG-GUID: VR4hTqV5soxA2MDTT_Hd3H52tP1hukYt

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Note that there is a limit on the amount of log intent items which can be
fit into a single transaction, but this is being ignored for now since
the count of items for a typical atomic write would be much less than is
typically supported. A typical atomic write would be expected to be 64KB
or less, which means only 16 possible extents unmaps, which is quite
small.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c    |  5 ++++-
 fs/xfs/xfs_reflink.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  2 ++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 029684b54dda..b6b714693d1a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 9a419af89949..b983f5413be6 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1006,6 +1006,55 @@ xfs_reflink_end_cow(
 		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
 	return error;
 }
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
 
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 0ab1857074e5..969006661a3f 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -53,6 +53,8 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1



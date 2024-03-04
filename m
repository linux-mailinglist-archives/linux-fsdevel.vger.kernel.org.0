Return-Path: <linux-fsdevel+bounces-13457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6944D87020E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FC1C20B06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE83E497;
	Mon,  4 Mar 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGRSPwTJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F6liDskB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0788A3D97D;
	Mon,  4 Mar 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557522; cv=fail; b=nCWJaOFE4YN9WszbxuAVYk1AMYwm5qiBeCAvsitXCJ1uxO71x4EMk4jY4jspGYvld+sfMa/h77ifEtUwYgpsPaUjb5s9tHsY/EhBMWXcMdcLubRAL1fUQTPUakHxMPveCMtymx0x+JRoIQuyE8sStXCpRRfhN5VWrQCZOHZJCFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557522; c=relaxed/simple;
	bh=3TNDRfpQZBbZDP5g+gv4yqfcE8w3c5zXPn98QLwPw/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6JTk9HE4i91me4h3oIl57zL6i9q29EaDML5iOYF9xRZ/RjvaXBwqHct6lQNW3+iV78wS1ktnxJ7Kb0IjHjTcrCzqKj8JLoLsm4hIE9cvvIKMowGiegeKb6MuymcfTynGG/0wIFXjQcVUvCdz3VhOMRt17IPMOiR10o+ViczWSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGRSPwTJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F6liDskB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTBa7006577;
	Mon, 4 Mar 2024 13:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=JQS48Dxw1ngoL36+Udps8THtJx2l30nDWNbGS5e6exk=;
 b=aGRSPwTJQU9OKnnjwBgNKcOzsVzk0yEejcX3Isy7ftXvn12dx9PWMynguoOfbuac2Hj5
 fi1nmHwTVXeKd/UALi6wXYHqJmK9OZ9qFRD+seWQMGOZtEvNjj1FBr9D6I6Er4VXBC49
 6BmgYfxs93yQ1xQcnTWxipl1/LMBI1h1Un0t8VHJYI5iRS+ILTeFTmIyUJUQs5DnDlbV
 3ROzbnnveYkxdkSMJtIS9SrorlAiEvh0YuqZJWoY/hq7mR/XThUmVtCRcB+Odki4dni/
 a3eLWKAgC0PqUinAyw5jKAaALEFcyGkZzk5KzhJZSbwKgSNMPFjjSsqYlrnLtbqJ+Rkj /Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkthebktj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424BjGqI033198;
	Mon, 4 Mar 2024 13:05:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj63t66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzUAhFyeAKu5QPiquyyunpndGj4rN3I4Sh+NPPLZqZneowx8OKCUbpra60FLNZRMalDpGBBFRZXqzPSjt5FRMH9nGnVfRlMGOC6CGsP/+99R3K3ddWwmRQqS9KcTFs76wQc4LNDrJAEtLPzy7qWCLDbB5Ag9UmoGg/kjOirhvGizZNFMgYKwdpgHi394oXliX+Dlq8tdRwVsRzGZDhRSst+Aj9kYfhdLT/DXE3l2ebXx5IhId9wko7vlkMLStKBSX+V53sc6dmEM3bjdWjSr2cWk+qNegQiHR2Y8yZTYaM1mAMX6NFWmH1GR5yWjJj2K6+S/8wkEti3o9nOUHCejwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQS48Dxw1ngoL36+Udps8THtJx2l30nDWNbGS5e6exk=;
 b=YI+7UVKBXZ+AMzzylZwytZBQZETbA1j1JRTzmJ/P3cHqZgHn2GutQyaff3RkFzzFktR7WTWPQKkcdFrNF3+BX29zjkBwE/1D/vwiDtgXz8PP3dRjqHrDh45AmVrno76hJJyY4efGnWnq2QnO0Fdvffn5wR0honZ/t1TSI5N0AV4djVYwfrjM2TRALGWORsmwPBYE7Lkxbg0aUNVHELx9z26KiVn0tiGmixAqu941Lw2BkWiTNqM22rcrRXIvNYPrvWNFEAyNcF1X0II5VW4SlLOXnDZgh/A4jt9VMoOdSuYz6zSvWYQ8jz1o/vtvYZz9FYrVKs79bDtpedJ1kb4vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQS48Dxw1ngoL36+Udps8THtJx2l30nDWNbGS5e6exk=;
 b=F6liDskB/6Q8Ea1uHepYRf/t+CyfpHUs13C0fTyidUb+DHQjRca/dIHzvMJIQKPs9SPXZHCQTD6JF4Z0xRC8xzDrIfmnq86TEy36QvJ25FOIOo5QccMlw2Pw+R86sEUjYGo0ym1ODALF5ViHW+MZSQEN+PRMuU6rVOoFe8lihpg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:05:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:05:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 02/14] fs: xfs: Don't use low-space allocator for alignment > 1
Date: Mon,  4 Mar 2024 13:04:16 +0000
Message-Id: <20240304130428.13026-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240304130428.13026-1-john.g.garry@oracle.com>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 33106870-0f6a-4a65-dfdd-08dc3c4bb396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q5qo6pwKcefJF6o/gqX6Pn88cBi+lpI40rYBrWZSjHa3Ui34dmtMI9300ZPrB1PTSGiEEWXrDtEtnPK9rV5jg6r6R4gcbgCpln7n5Aa2mHjuTeWr5nblFi53UYT36PBzJfSDqW8ExpWebEVEJj9uydmApY3v7yNlxX+DQi3W6v4DiXXh9Ba7FnaH81M9lSC0QjMlp+ijr/r+XyWVqYCZt6Ks6V2SySYV20E2p0T3qdjE2hCf9Q9NpCXJfxsnlsmAt0G9n44Ce+jS3afJ93I6Y41Qg0gSJGwydweBhEp/V1xYk7TT7N3J1/P9IM5CIDArdzPsbcj9yClW9fqpMjPUsbvuzG1mAALn8fP8xs14Yv2lfAZklylU4/vbqw6l7XzXS9xSmBycFkftPW/Us96YjnvycrND7w3B/n54tu3xJ2O0Zc6Mas6odZ4brTlq4zjTaF3ka/bLcghwayV6lhENZyLp6/HNwOmmkC5HIUU6qBmP1xolfJni6PbHmNdtpXGRiRMDQbp1YgPp8DOMfvR0pb2tXewiEOeSPFMcByKxBBlElyUafj0/sS7i6bJ/iXI/A0kFIVYJLse2gtBVka3fES+/Rdmrd5nnpJY+vT2vil34x/cYV/AWVX76cjVXt5o5QVYWzMMfZO8TRirTIIjwGRAA02kudV0l9kDFQDM9bNo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZY+bJBlF+6kX4ZID/cc3AwvPyP/oDMzh0jaR8APAGdNPGaKxf1utb3nD1p6h?=
 =?us-ascii?Q?E1Zlr/g13dIwi8bBU9HVt62J46QVV1fgfLvOcHmPPo3kJVGfxCv/9GdzbNih?=
 =?us-ascii?Q?UA8H9R49KNVwnwYO8XlRVB/7VcG4r8sWD1hyKjmkeV2uNv7DjYDSFR0tGgml?=
 =?us-ascii?Q?P6KIPeAWFl/kk2SmpO8o2np4D4nEm8mCPsYhscNYEjL7Z2d8bPGAnvq0rrhO?=
 =?us-ascii?Q?oEvRS6PH1VzwqVOixvbWqsRDN1selVasMzpLoYyRfDKsYGDLPEJNoX32mA75?=
 =?us-ascii?Q?p/loeIZU23ngHRg+HSjaSv7qLfTM07gfJwmcdCfwl6QdrhKs+eHNIFlNHQLB?=
 =?us-ascii?Q?LFccSIk1jcWPWOA60lWCjklLD3rt4JUWOpQP7IqNjhzjLuDkznQCKNDAc/oI?=
 =?us-ascii?Q?pGv2xxLh+EZsD7C3T/XFSU27TQ6GMhKl1lcgZei88n87HBSQsziZvMI7FqJC?=
 =?us-ascii?Q?rryV0dk26UMCI5V/2s0W+ur8HusIXTchxWNoUY/qPa7zBEz3ZUFKFWp8nBL0?=
 =?us-ascii?Q?fCXEsHd7vRxQie94PXgIGgUcLMNbxWWuFe//qu3psdcJr38PglrSNkTCASOG?=
 =?us-ascii?Q?ia4fT+ygtGIGVoV3gNV0MA6UxgtdNIOdQ/UULvnbb1/l+/Zmfx3/zcOMsv2R?=
 =?us-ascii?Q?lg7Voth4I43NXUguDiS4sKcU9ZBbvwAb4s0C/T2TY2OyyYFH5vvcw9bTAgID?=
 =?us-ascii?Q?KygATu0FxctKuRfiPSN5j1K2nyRaHWcadtkl7YXKXL/0tbM9qn+NeH6LbsaQ?=
 =?us-ascii?Q?Er92JDDqszRpKiPFsszp1P7/vhKyQ9EYHHX/WfK4hBHQdiWOSf2+kCJUmVG2?=
 =?us-ascii?Q?xd4I3+lnZJ0YFxSSs/DmIVfrYdjHcOlsKinf1StH/B/Mct3jdPtLEPhoYz5S?=
 =?us-ascii?Q?P3uXiUrvX5xzmylSzg8y4gNBWrIfLtjagk3Lg+63JhhiTDbt1WMdmxPC0I7F?=
 =?us-ascii?Q?/clpD0mJrAT8BQ1z5P1q8SYNc+/8dtEScE+W/Y8aL3TeqyW9t6Z4q+yLTulr?=
 =?us-ascii?Q?oYt4AyKxe7PC++Hm8n4ZZWXIhpmHy1UmCi2mHW4CeoRsOMf1/lvmfwC1ce12?=
 =?us-ascii?Q?YQ/tWuWydlxAtYQ0vT8ugY9zxqBrx2u2MCqAKvg8KYB+4L/exhZYLRQHzh/d?=
 =?us-ascii?Q?UExQFt0rC+rQsZr9VSnac61r64PdHMzD2Mr+jZfo/m8wW1/HmEaiEz2QiHBg?=
 =?us-ascii?Q?1nY0spRhTtK0rCsj7A6hz3TZj6B0cuAuBq/Fp5MzKjARyI7venTPafteXSnv?=
 =?us-ascii?Q?k40CivwtOBzebsny5FT6ZUX7O7p/CGI61mO7yFs/dUcWPSwBT57WbivzlOwo?=
 =?us-ascii?Q?ZMIs2Y3mt5A0C3lki396kSNaDGml664BVPBYB43LFdLk5z8X7j6v8nxuR2AQ?=
 =?us-ascii?Q?nWf8vj4lHP9MsPYXqONSluq2zpj9k0IxQbOxRR+JzylFBr7CZbNaTvtErgCT?=
 =?us-ascii?Q?Apzc1U40qjSIEoGZus5nS/0MvLw0Iz9Opzphi7mLKQu0hYZAERIGspOPhXvh?=
 =?us-ascii?Q?VGNKw3Pai2Ui4J4P6VstZIM5gB/mecO7h7LTDFMTXcoIbAXxPmaDVanlUQ7y?=
 =?us-ascii?Q?PHuReKFKbSAuRD5k5fIXwyPIfpbwYUS4qhqIt8P8RD9dm6PnhABnZmHfh3EZ?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XKB1rnHjq0utvPD3Hg5f8kS8njzw3DvB0dHMAHw6GGp6UwLClB/pGRnfXCCW0i7Y+NdR1Xg+9PsiH7vR9AdzOJeNaYO9VPdfNmLNj2ctXRZHKKCDYu7bwGidxi2nzAopus2O53TJofQpO+iYPllpx4k2PL8qFPla9qVgGBJD+JyELMKZ6oCKzqrvvUXcMyFisF26gDPDZgXpsY7a/DgXAlW4+f/iIOao6uiqDdzDX+bK9QHitSYwG1rzM/FjbdaQoIllCZv2DySIWslUuc4VzZb37cEs+98gZvvB6g+8BrMW3T86Eey1eySEXsI2rbGfXr7x7l+rc9tUW7PqPKYwLVpxU79Qfltnk5MeYFoty8DS44Whtqtrxavo5xSAGu3kFzNlbKuk12JJ6/2paAiq+zdQcMctfbPlgyGUeP0lRKvKWe1CwFtvPKeLgHSPFlg63C3WPuhS0rCXm5Mqp3Y9hOmuKJ7Q+S+ToCljQBg8Qyb0I93F6KjhCF09ER0C29Hd9qP/uadQlzVKnijOlXERoBovPLVLcAim2h2NZmgeBEpQeR8rIGHUPiwnwmIlBUB1XQ3aNsnR0OONyK2R15UdaGpU9jnIethvhZDGgmWzVvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33106870-0f6a-4a65-dfdd-08dc3c4bb396
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:05:01.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9KDo2KfYw8ny48PSQ50AQk5qNJtLU3hBzQJusz9hUqzuhr0w27BRAV/cbRqzoCWBdHI/NgA0MbSTedBnuDTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: 2wqFaGHbUswHckFaghkkHgiDsTaNTnLn
X-Proofpoint-GUID: 2wqFaGHbUswHckFaghkkHgiDsTaNTnLn

The low-space allocator doesn't honour the alignment requirement, so don't
attempt to even use it (when we have an alignment requirement).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index f362345467fa..60d100134280 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3584,6 +3584,10 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	/* The allocator doesn't honour args->alignment */
+	if (args->alignment > 1)
+		return 0;
+
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
-- 
2.31.1



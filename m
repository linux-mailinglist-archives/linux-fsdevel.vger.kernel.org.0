Return-Path: <linux-fsdevel+bounces-8770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6B83AC18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC2D1F21538
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC82914;
	Wed, 24 Jan 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KfvqcCf6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RpRyZNSL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3F12C535;
	Wed, 24 Jan 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106616; cv=fail; b=cUd1ZSQAIH2UTI8SRiCUwXZHVPkVFEc3ywgZ9tESiQ9ctzlH9MezQ8ses4QV5gcKlCp42HyDtXTiZ92VlmbsjVS5nTV8Cge8T3XQXBWO7SynzZgsI2ehGpWN6uaH4Ca51PelNVFyFkMFEUfxp875VCVkXWg/SkxR5pE139cmIyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106616; c=relaxed/simple;
	bh=9uX7HUcEFacerr0HXW6je1/BaVBjfMMtp5jGY9GvPh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOEVjqvpj8GeGPrtaTLioXrDInLh4wnYt71khoyWZWwPu/O+5lTd0zhUg0TPQZRqz0oMC5FCdGy+MSFMq91PNlBGBQ4WPaZDm7kStW7/D/b14K6AClJfmloWJHgjphDIeo3wQDE0cmFjFItgACsZo1No2/kbYRQULyt0tAozMxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KfvqcCf6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RpRyZNSL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEEZiM026736;
	Wed, 24 Jan 2024 14:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=HUCCJu+kJZY/w/0AnOM/kMQ+pyn5EdF6M4LTo7IXxm0=;
 b=KfvqcCf6Pmhcrd5xnQ+MuDeVFu8UKP5P68e07DvASCKnnvhmhA8xOWhyaC4xfcVnFtOE
 LIotmoMcd9u2yC+BBV2Ej5LVzF2Yaqcw0Oyx32Wo2AyH4LDOdJBxutN+cJcl9fN6l6wc
 HGtDaP7SnGtt+VxeIUJsWi6KBxcHuRoknARR7Vy82SEgxS+alJT2qLW4uCAxgTxRu1aW
 7bMIAPDG+Gb9Tb9eyGN+wy/s71uYmUE079dETP1J4hz7isruUYIiSnCQXiks2mXd3hDg
 5ZIeORyDNKB1D7jKqnJ7HpxCdyeBkxfxfDIexzdBWPtRkI2K15glBhQ9kO44lus1sghH TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuuuc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE1L2D029572;
	Wed, 24 Jan 2024 14:27:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs372rr2v-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYRU7+92b2d2tDPS5L1NOpRRZul+voe16f0CYGFa2+hd/CzJsk3pEWQj2gWmwZM6inELCxMChFzIAiZrS2daW7G3D8INzbktss1vyZQKSjG/1tZ6MideMABgd4hICsSBQpKxMaDMZSqc/BkSPQob4QsQOhQryfBvzaAn908qFUTU+iUWCXQN3yoax2b33ejI0zNF8NBD8DN9UVoj1qCNQEjJBIjIRa0JuMtU4WROQ8TyhDi6H1avaDUS14fu3N4YE/Xt6/d1ESyT1C4EjDi5wSADIq5US04TiCtR7fZf6SPKws9d2SqBSu0nUNsrJZ0qNPFw1KO4n5uhMm63EJrmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUCCJu+kJZY/w/0AnOM/kMQ+pyn5EdF6M4LTo7IXxm0=;
 b=DKhJm54xkLVb/M4cGelnvsD3HEC/zljJM+/IOLcJ9wWaHl67eY8ZugMICAkQAHvNlQ22ck5SbzJRSmSU/hgltKzuc/j91sPHkfnIAFxW434VMG7+2EznwK5pAoDadjKQ4kSdaI9gWu9ssbn4M3fm83ie1ehG2VPKAb2niYQk68FK1RBaic1Qg9QZA5u+8oUBYiAKJGLU6sV+zxr0PbTfOVzIYEdluCmJOpSw8krga0QJx3194q86pOJnx5qTgl6mTzvmn0iP6JIUUSTyjuuJFp5Gk0TcW24E6wizWqQYF+VmhCSsNuBWpctcUN2pDKagkhp/AotDw2cm07c2lZ6GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUCCJu+kJZY/w/0AnOM/kMQ+pyn5EdF6M4LTo7IXxm0=;
 b=RpRyZNSLOoX6Rb3r7i+YAk/YhKE2jW8/SwoFlJobQuOzrc8jl22POTStMVFa8sw4eKUBO0+bUmi2bnFNz51XhU8pqdkFFjWo+iXRNw1rAJGJGnYaounAFlJAUxMXSBJhCvuLEmkiu016Z05/HDf1VT/0Cvi+PBZ0SMqe9dEZTxs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:27:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:27:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/6] fs: xfs: Support atomic write for statx
Date: Wed, 24 Jan 2024 14:26:43 +0000
Message-Id: <20240124142645.9334-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0435.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e855d2-7705-4a97-37ce-08dc1ce88ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IQHBd8JuD0mP+dN3FWLTEJ2tWAEVpr8Y6e59W+Owqa8EkGtMrbCquK3MihA/lb0X3rfXJDsu+nmi1+e/b9aJ3I8Su7hVVMed8PgC5L4Sha1Tbwu05+ggla2a6HgMrqzmrHBerOMczBVAgabhxYXU479OtgZgJXmrIl3l6zqcuABEzww1OZlf7R6aKjgaYyYz99dwQRVYzUtCHyEZtW1lsUwjHA0bGhNNAaXiExnVUnGW4m4VJy9lg3xQdWXof1qBi553MfYi/pfGV4NXWwxVyWjFk23vaogkuL2v3Iiyz36CqGq4gS0yUJVYyos3z6bxxIjf2fc0o9PNpR91gF5UHTiXCE4WwX20wLpqVUEFALJb2BJWlc6watbi/9MVtia5csXNT60o8oxnrsZJ5ie2J1+7GBqW+6QPUOzwXicb9+CPmYjs5ZSxtchZlkzlkG8ZzWofAg51p5R5/ug25fAmgNj0LBA3W9uMZwUAtq0IWAbWyfKzctDwfQUswce5QsSb9I3ogNw0TAk+nf/7IY0dap3PDFQ8RKJMtiFulSyERJYdPMm1VzNDKHHMY6gYSDTf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(41300700001)(36756003)(86362001)(103116003)(38100700002)(107886003)(2616005)(26005)(6512007)(6486002)(1076003)(6506007)(2906002)(478600001)(6636002)(316002)(66946007)(66556008)(66476007)(6666004)(4326008)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Db3mglmNsBzfRh5Xd9bM2TZ5p5gutRT9WtENBUoACiFPnJNG5SdGUSsWULa+?=
 =?us-ascii?Q?sIphUy0JXVCR49j+Ej20yfueQDxGejchP+cyQ+Jl8RP7VZdymQOUmRjIvxV1?=
 =?us-ascii?Q?lF4A+SxxFK/ZweOuRMMERTh0UpArtqJYPLYGAynOBiDz+1uUKesdZd+pa6hn?=
 =?us-ascii?Q?dD4OIbidOH+OFPz744vk6i+13QaNk8SfgVK8NYm82Bdw1pHw1ygYd/m21zkM?=
 =?us-ascii?Q?ejP8gmruAWhAjI/D9Cq6qcLfHiJCEpnka94cxFKo0Tna6z6j1blyPsI+n40M?=
 =?us-ascii?Q?upJYV6RNTk/JneR1S+EX+AyCNR6APXZKry/upsxtVMS4pvHC2V8uopkreqs+?=
 =?us-ascii?Q?3BF/ropPKjm5z4McwhLGyps7I33ETTE05AxWvizzSFY+TDVcf29Iq/owudZh?=
 =?us-ascii?Q?yNKZ/pQypUcHYDB+Qk8opDp5/4LP0fLZwmYHXIx31ycRpgYCvvjFw5UQeW4T?=
 =?us-ascii?Q?p/fb3cC4vsChtz0o6R3COSXJrxFz+eHV1ctEQ5VJyS8OWHUcIZFSu5z/mABM?=
 =?us-ascii?Q?qA6ht6Qs6Z7DYfsLHwsYNwz/hYueswfAEaIzq8w5ag1cg9MU2DIKj/Q3wCON?=
 =?us-ascii?Q?vmotB9+rGx6oMc0BXASNBy7S3e8OAiDy90UTVcs95bKFS8wv3y/D8exzC5mu?=
 =?us-ascii?Q?qZrVcLv5JD/Aq4iRQqrpwucjRdYS/W4Bpyqw5aaa/UbmIwwXR8GQQcec/OS9?=
 =?us-ascii?Q?F9ajmV19cpaSLkNg0X7oS4zn3SL3fotrQjPRgB4oR2p58mJ/fr8UHrP5Uset?=
 =?us-ascii?Q?1ZeDf+x2bKhz4mAgsEmJDudATAi+2fVnGa30uLmajx1t8p0HfQwPrpEGX9UU?=
 =?us-ascii?Q?FcQOp54k/NjHAXcVwv957XtfI6TUqBfDv5NQ6sHxFfuDvejA0oG5MSM/Trvz?=
 =?us-ascii?Q?akyzZBTeBIB6ARjW7W7wVr9U9Ahmb+/mtothf/QLf7WNnHwUTvt2yef4+Z3m?=
 =?us-ascii?Q?DsxwwONDtBHSsCoGETJR7xpnzL9Odr+RVBPnTFre6GqKLZ8Z0tPhIz0PAdKy?=
 =?us-ascii?Q?7xHaJw6OI7TN/FD+pza4rPxEYjR+AhwaWGzpT8QodYuyvSqGzG8F+pPw6XjK?=
 =?us-ascii?Q?zIkFEePUAUCeGujcfwqqiVS2JCWv6/YzZyzO+0hgOUquix1gI/FXjMBHuAwL?=
 =?us-ascii?Q?t7USY3Hk3zCiauDskklig/5Y+qrfSM8vZk/5qWXOzy+NKScBxnFM2ytalIp4?=
 =?us-ascii?Q?0LmYWD7o57B9SD2Ur3EI7UpPtC5YBgYVtvNIWjNVCmeRhNJK2p326g9jWlhp?=
 =?us-ascii?Q?tAr52NgvA1EQu7otl0h/YKe0pwedp+tYYdzl0YsA+mcWU+TgLFioNPobOFPs?=
 =?us-ascii?Q?S2FPpPq9zTLi4KkXKa70K/14I78+bxV7uvgO1+7SiAKxjxUF8VVpWL2A2W2x?=
 =?us-ascii?Q?3QmIutEgcX+BYlOm98V+f8ZOTy63Vxept9caZrUAaa5tgCi4AkArDdzQkKNr?=
 =?us-ascii?Q?nAo0cUZRi054CLMVA51sIzWtBwSutq85m/3d9LhRkAsVvCrCt5EAN+Q3ss09?=
 =?us-ascii?Q?oTJrn4GU2+zso3wRFWFjV/NLzp/mPuYpjIQPYc79IKuNBSvoEXgc8yRgYVnx?=
 =?us-ascii?Q?lYSvTzKK5hsqdQ7u5xeHPdFDV+4UdmNhEjT5S8sdU//Mlk06hIV/OrIM4xv+?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cKQ8eNxPFdGNojtFlIkpkO81PVDoKFx6aOTkJYEhP8qWh1BlQG8Y2Fhfth2hDOTkbuFH1pV3kA/yigasNhxjMyhxYrB9ztcclCvwCuT69yqFKb4/Hl7tBEgQNm89IaVB/E7o/LhQ2Fbt6PR26dlLra6HFJqHn9OtjDdDo9tvOuPvRhnpDlBjG2MtZpumF/HlZs9PNztLqmOTolVVZc6lGKTeayyYfdsNDUh0GoHIFUExa9GC4mqSSnNDzRBTD8fanmsaKk3gsVYPjkZTbvY0XUpdyUBTNJPhFI9vL9yl4UJYATCmiva8OqRA/k2/dtaayLXG5/VhxDz/mmT7ioFZFkMMKOzhZYLkn1Apnjjg1D2VnBNwQbexmGyPMmL4RYM/UOm0NgtrnOhneVDhA5B5e3rNM2/lW00sIB246+A16scPiA24GiaV06DC4bdUCF+ATsKDa/KGCScQyVzDk1nBlFWjNB6WAg1vh8vqRqfnUqjOL+bNLkMgVTpWoQyFfNK1D7TQy0EHMhCuU2kkC9mHa27nr6Ui/PxleV17A36oLH7fP9JJx47Kv2x54aIgVcwGLOSOhkvGyRqUl4a4U9KHfyKzKaoaBXoyqBhhoG4YoQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e855d2-7705-4a97-37ce-08dc1ce88ad7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:27:06.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5GtSfaAOxiZ7/pK2ts21e1W+cWKJXdXmlL2+EL/cSP3e2ZC3Xp64xX30bJyTuh21m18py19epRtAzoK8dxAcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240104
X-Proofpoint-ORIG-GUID: MRuRMQem1csCBN-TI7MUrlZwme2dHj76
X-Proofpoint-GUID: MRuRMQem1csCBN-TI7MUrlZwme2dHj76

Support providing info on atomic write unit min and max for an inode.

For simplicity, currently we limit the min at the FS block size, but a
lower limit could be supported in future.

The atomic write unit min and max is limited by the guaranteed extent
alignment for the inode.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iops.h |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a0d77f5f512e..0890d2f70f4d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -546,6 +546,44 @@ xfs_stat_blksize(
 	return PAGE_SIZE;
 }
 
+void xfs_get_atomic_write_attr(
+	struct xfs_inode *ip,
+	unsigned int *unit_min,
+	unsigned int *unit_max)
+{
+	xfs_extlen_t		extsz = xfs_get_extsz(ip);
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct block_device	*bdev = target->bt_bdev;
+	unsigned int		awu_min, awu_max, align;
+	struct request_queue	*q = bdev->bd_queue;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
+	 * atomic write unit of BLOCKSIZE).
+	 */
+	awu_min = queue_atomic_write_unit_min_bytes(q);
+	awu_max = queue_atomic_write_unit_max_bytes(q);
+
+	awu_min &= ~mp->m_blockmask;
+	awu_max &= ~mp->m_blockmask;
+
+	align = XFS_FSB_TO_B(mp, extsz);
+
+	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
+	    !is_power_of_2(align)) {
+		*unit_min = 0;
+		*unit_max = 0;
+	} else {
+		if (awu_min)
+			*unit_min = min(awu_min, align);
+		else
+			*unit_min = mp->m_sb.sb_blocksize;
+
+		*unit_max = min(awu_max, align);
+	}
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -619,6 +657,13 @@ xfs_vn_getattr(
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
 		}
+		if (request_mask & STATX_WRITE_ATOMIC) {
+			unsigned int unit_min, unit_max;
+
+			xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+			generic_fill_statx_atomic_writes(stat,
+				unit_min, unit_max);
+		}
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 7f84a0843b24..76dd4c3687aa 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,4 +19,8 @@ int xfs_vn_setattr_size(struct mnt_idmap *idmap,
 int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 		const struct qstr *qstr);
 
+void xfs_get_atomic_write_attr(struct xfs_inode *ip,
+		unsigned int *unit_min,
+		unsigned int *unit_max);
+
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1



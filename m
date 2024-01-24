Return-Path: <linux-fsdevel+bounces-8766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C283ABAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E49283B0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5AE7A72F;
	Wed, 24 Jan 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IpzFDCTi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XOIm0UvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366A7A717;
	Wed, 24 Jan 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106441; cv=fail; b=uxKetRsZsSwb9aLk0dHge+RNN4YpnXnXof4nURz8vjchaygtVdOejiS+1lWMAoLwneqbA+qLI2Tkc0FYmBUxMXQWRi3k9EZX1s4/RkRBDlBEWDZmCJCZQmdZy/IBBXbzxXDNTATU8zxoS/S9aIVbjjvTmKs7G6XPlvjRC8fpfh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106441; c=relaxed/simple;
	bh=1F4LDydEgnez3sthhEWkJHq9EBmg0YgzYniy2Cs71jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S06FYF2ooaiaxMpjTMTd49jfu5vVAqkDbuOqaE6kQIPOgbvrhDfLqRRpac4GEQMsuBgB9NmZbjVNRS98anAuHegK4JakamGXhIKyPk5TnNnJxMOwPp9jJ0ykG4Og1hee2CUUYR6pFjbeDRWHPGnK9MZGyDKpTuJnfcZ1vbx/5M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IpzFDCTi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XOIm0UvG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEDsLP031407;
	Wed, 24 Jan 2024 14:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=JdGHMEoXa48N6sUic+VoCq5TSyjLvTgzgCyyELdJUjk=;
 b=IpzFDCTih+yYU0YEleQlnRJqJuhN2Pqp17iLeur9LHgZ2VFtVbt3Stg5doW6c40pqp2v
 2Qdps9FTkdTNdU3L49kXyAAI1+4SWhmVfuyhoZrh/WJXKPZ5kmiZvLVezlysBF/koQG4
 5nBVDKi645DpTl9rjLfJYjWzHlS8Yi2p6WUfp2D2/wCEc4XovqHB83LfJXiIkdEBeWs5
 DUHT+kHZ1EqVwgWqld+wGlbjcFykfIhwTznh0sDWM8MIsAOdZHQD6gRJqertrMfxnqgf
 hcmD7onkDMSMc5wp3rrKids36F45ON9oaIl6xl+uPV04zX0BUCJvm1yu0IpeqnJ7HniS Wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w3tyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OE44UL031478;
	Wed, 24 Jan 2024 14:27:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3248nxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:27:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anyr2Lr95HvvRIei/f0FswMsitchXd6myCHxw+s1Q9G0dnZ6nbk9+DKrRMSxhqHzQ81EUgOY+ledYeTbE2pPlAFb6d2LeHObvet3QRU5C+ELkmYYRSIRRHCraMC9Qx4NCWBGF40XRVGnUyhz5ehmT/3sDfIdqdaowUPEkA7djgiwfMe4WWNbG1R9HuGoqYRLANYPWJIkb3uRoaWVhRBtnD3C0Lp7r0uKUL5RYc16eNIwh8WIRVduxrhn9F1QdDOEkQHZdurBelGVuw8RzzhmwQauZ5HItf3kckIktMAlnfAZNtRVOwk6bBCK8bsX08eTZOUsl1N+IAK/Nar2PxvEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdGHMEoXa48N6sUic+VoCq5TSyjLvTgzgCyyELdJUjk=;
 b=EBkGmBAAgorBkGifdgjlzDIN5GjUF1klCV2O+Huv9N4bYEwH27AxmgvkFi/CuCFIYt/K/DfKxN5+jckZtIZWLuwKIIlZyRRb1cjy359R5M3nBypPVSJ8g7Jh2u+/IS8Gb3++bw6bvTDfL09p/yQhe7otLM/zXRWWV3iB975EHpSsZclshIbIlX5OU2b2akP7/m2yTxn0KJHnWUaQxmN4zeJXp8JbYsio2XPw/WbgUfF31+VM9LnDoHC/C9acZ05qaHLK7lAQeQURQW0twaOmyRG1OD11KT9f/5sWcxyRkgstTrK//tW5iNqDkwMw9OucZOdmwvuk5t6T+0Pm9+ViIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdGHMEoXa48N6sUic+VoCq5TSyjLvTgzgCyyELdJUjk=;
 b=XOIm0UvGuNNi6HPZCVvNIQ5/3knJpSDL5GINux6R+B3uott/TTEiTenz85looUwi5i07aE1bFk89m3zH+b6/ndgDYP8SY0S/M4+T8TQ+xO0Ru+mWAYdvGnOa/nK/k4wE+NV1Y4VT5qy73iQYAMEgrOmNSuXwimewyhGKHTKy3RY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5212.namprd10.prod.outlook.com (2603:10b6:610:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 14:26:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:26:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/6] fs: iomap: Atomic write support
Date: Wed, 24 Jan 2024 14:26:40 +0000
Message-Id: <20240124142645.9334-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142645.9334-1-john.g.garry@oracle.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 177f6864-3bf2-49aa-2310-08dc1ce885d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0x56Cz+3qNHPsnlrVvEamqOR5QJx5zRONma7uLqFGOMlXYNhcb03G9BmkeTPRqLCsca0z7jb6B1WWWOVybVzKdIxPRo7F6lUZB9+k3i17f8GTCjfmu9LxZWM1gLm1cXdmHnm6xj90ZGfObchJY6q543dQIq3v3mQNkWPKnBAUC5tDXLzc5J80lqYpzfVpzpdCUwq3OEA+6VYET/fMNI0tC9Gw9X7oD/hZT8iV7cacF50enVBAnapMbaodoMP7cs5+IBbQhmoYMrTEExMd2OYVF94SngxgosZ2Pzt3qd+BQwS5jMXlaro6R+qbjnLMNSrw6Rs4EjHkP+sA5OAZhH42qX0VXeautozvtzJqU7BFGctKf+jUK2HxW+r7Eo4e5TJcAoxwb453D3iq9tNp3YrJKovG4wSrROzIR8vInq0ZHDHSNAij1N63Raws85CuYD+DMPPo01GkgGltmW7TqRhZxXGAZxZXF2xP73uY/dlv+CgX0iJ/Sxzg3+ySpO9WY5AJX2/H87Gr/k/WCWZnbvIaQYq9CqsUlwnYC8Rh/KPs6rhsCpjV8WwXovk7b8sOl9B
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(41300700001)(36756003)(86362001)(103116003)(38100700002)(107886003)(2616005)(26005)(6512007)(6486002)(1076003)(6506007)(2906002)(478600001)(6636002)(316002)(66946007)(66556008)(66476007)(6666004)(4326008)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gTRNx11NvUzy4vWQWfUaN5ZUwJvi2TUqpm7WJ96Rn1VTi0wsf57tJ3Ix9oHU?=
 =?us-ascii?Q?EbOYLY8Cdg+YDg//u1mIK689EIroF8dXYMIy22nvldVTB5qvAO0ty6FkRcNX?=
 =?us-ascii?Q?avdEk1y+cEDPDsX1BHBlpiB9wmQKwq2Pm5SUb5wb0ZCNxJgGNCPWoyqLAqBK?=
 =?us-ascii?Q?fLpavJMAhGrfSzSOda33XaQEr6hbTkTtGYFMMPvJI1EforbPO3feDE5CGUHB?=
 =?us-ascii?Q?DqLnALRtirl1oMoStvzWg5Ovm6edX7VWraUU3wj3Ek2TNrZWR1nJqMBdapTm?=
 =?us-ascii?Q?c9Br9EB/Y2Z/5GNg99GzARGSgV9CYiNN+meMKWP6uskmK49sQIWFPdZE/UUT?=
 =?us-ascii?Q?V3BqVDpS8wODVbr7RayKrOqcevHoW9OV/WkKkhtOmP7fX/VaEYRuc6L+b9GC?=
 =?us-ascii?Q?zS4qbW8+pu96JJHim2Plwvaa2I6snOccxG7VTqcDSpmCdPcPmj0oeQNDIMy9?=
 =?us-ascii?Q?n0tmAshuV21kojd9b+98u8Ne1Mo+HwjbdEY4bGYI6k734CyKV+N1S7tnWKxh?=
 =?us-ascii?Q?SbGldtzn5aIPpxPMqAssC24dW/73vp9qct7kgdapQJ6IX88qa4I28ZKDLoCC?=
 =?us-ascii?Q?qPausG1UB9M/gODmsv5ylPKxi6xKazhsYssfQAHRIuyt6qIhWT1UjPDyt9tZ?=
 =?us-ascii?Q?lnycmXJmuYkB+WjkMPBJX9yCu2MyQ3/T7bL0JPjI1rmwY8fiTve7p8P9n1Be?=
 =?us-ascii?Q?TomK2LlZ0jeQXWnpQ5aZC9Z4OVqlqMBtxNW2J92feMdGB3eRFXUkfC2rwM+i?=
 =?us-ascii?Q?1Bww6UJeYnejpvthhLSHRZNRzCRYAq/Is4tfcjx2FNAS/9fjVD7+KGAWzDUt?=
 =?us-ascii?Q?7cVV9Nx7ZD8iLaznBILvMv1fg5V2uDOSA/MYToUftYbMawnPs0WUQ69a6wQi?=
 =?us-ascii?Q?lcbhjl3KW6uvx42++UBOEGpg/OBE+lB1idymaQEyAhcLvJ+RFBSgpSBNFH6j?=
 =?us-ascii?Q?mN89k28dN3+lkSsJsuOl2grOCO2quyd0CvXrXG54/zLFxbcK/Og2wh4EegZH?=
 =?us-ascii?Q?IY226g97vcI/IhO80dtpFaXMOMbNPg97KvGfLmG8Nc3GElLnaDDh23kCUM+U?=
 =?us-ascii?Q?PKlqZ2tm9TI9fxzu8YflAwD2PYGaBSq8otX7uTicE7kTrXhvwH26dGE1N7qy?=
 =?us-ascii?Q?taF4wFFEbisx6XqG4pGXjU2uRgLz1frs1s4KzaXmiDbOSLKnLR4pQ9EJiaZb?=
 =?us-ascii?Q?GQfWciIm7p7oG5AiO9bjZG8XqTT3WAztK0448KeRJSdLgtn27/Q7SXrxd1O2?=
 =?us-ascii?Q?BUks3vK5y8PYlwCsoE8i22UFgXPelz6EeYfKYl8lduUdotR9Kcurw8UVOlQn?=
 =?us-ascii?Q?kw4Q8Ek0Olt1CeuYt0zijLa+Sx5A0kNEhWhgvYGI3qCUGiYLL/DSkqs6Mvse?=
 =?us-ascii?Q?NyjmS8gYQpjhyrIN75M7bmRbfs7VBu+/pjOyKFnD53r2TL/rnhYwLpXUresr?=
 =?us-ascii?Q?ZhmbYRBMo6wPv7QTp6Y/xS1rTNVWOgHnmekMUMoP+LxhCg52l7dMr6i5lBLq?=
 =?us-ascii?Q?6l2g+Yirx4nSgw1Y9EtMqbHOtbrweegUtqzc9xbh6mIpkyaQ3dAp9dKj7Ttg?=
 =?us-ascii?Q?OzUrADJ2tGCut7d6rX/HbxP5vCdQQAk6SgqsxY6AQIotOxeAxl4xIQ55MVqR?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aaLYAtzhDPggR+Jik9KvIl6R7fmVX664Jwqi1BXix0/rwGARm3CFpHyDQCCoj+KHVCl+XLaDbJSIE5/M99ST4egvl8EkDaWpR2oFMI8Fc3uCZJMwffg+LNBs6NkWB75fJF4HIZKtPEEkOtdl1+SCCiyLlSS60j0pZEsUBIiVTt9yfrdIoUjXbv4nPtA8BiT7dUurVmST5LaDQaDqtS9LxO0qNso6+B4RTgNAoxcnq3ALME2JR7kHB+G5X5afjN1TMOaur4q7DaQO9N15TgdK4FgGbUtZku6uzVuIEqxgoyMIav9hC6w3GekTCaA7OybDx9YuARrs90z6wyOIwYIML3QsS5N0CXOz21xvNx+8BGu6zxRTnD93XVq0dxHNNyUgBqEIJsrxacEJWDlB6SLp840fXRcVw+rLQFUa0z2QHz7rgrIjzMa4QV8CH4UFoK3artd+i1VxT1Cp3T+HgcJ4lNXePGQIyVM7TaTv/jupSrffURrJ+jcLM7/dVuIz1ptYTP5D0sDUSPQAKtXfuJf9fVX3uTqSLmkDeHjk0vValkeA3s6n+gxFdJotHIDFbt6UoX8T2oWbbwa5qDsyW+ltzrzPYvbf5n19eszamf4Xz84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177f6864-3bf2-49aa-2310-08dc1ce885d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:26:58.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HcBySDtY1ULErI17hvpqWapmiVZUL6FRQjT3G/OZyaUawC0kU1xdZLfHkN62c97XI6q14hzLiiz9w5LTUP4yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240104
X-Proofpoint-GUID: 8hcAyRpJxxR8cGWoZZ2mqznduwYdNHLv
X-Proofpoint-ORIG-GUID: 8hcAyRpJxxR8cGWoZZ2mqznduwYdNHLv

Add flag IOMAP_ATOMIC_WRITE to indicate to the FS that an atomic write
bio is being created and all the rules there need to be followed.

It is the task of the FS iomap iter callbacks to ensure that the mapping
created adheres to those rules, like size is power-of-2, is at a
naturally-aligned offset, etc. However, checking for a single iovec, i.e.
iter type is ubuf, is done in __iomap_dio_rw().

A write should only produce a single bio, so error when it doesn't.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 21 ++++++++++++++++++++-
 fs/iomap/trace.h      |  3 ++-
 include/linux/iomap.h |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..25736d01b857 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -275,10 +275,12 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		struct iomap_dio *dio)
 {
+	bool atomic_write = iter->flags & IOMAP_ATOMIC;
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	loff_t length = iomap_length(iter);
+	const size_t iter_len = iter->len;
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
 	struct bio *bio;
@@ -381,6 +383,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
+		if (atomic_write)
+			bio->bi_opf |= REQ_ATOMIC;
+
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
@@ -397,6 +402,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (atomic_write && n != iter_len) {
+			/* This bio should have covered the complete length */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto out;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
@@ -554,12 +565,17 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 	loff_t ret = 0;
+	bool is_read = iov_iter_rw(iter) == READ;
+	bool atomic_write = (iocb->ki_flags & IOCB_ATOMIC) && !is_read;
 
 	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
 
 	if (!iomi.len)
 		return NULL;
 
+	if (atomic_write && !iter_is_ubuf(iter))
+		return ERR_PTR(-EINVAL);
+
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
@@ -579,7 +595,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iomi.flags |= IOMAP_NOWAIT;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (is_read) {
 		/* reads can always complete inline */
 		dio->flags |= IOMAP_DIO_INLINE_COMP;
 
@@ -605,6 +621,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
 			dio->flags |= IOMAP_DIO_CALLER_COMP;
 
+		if (atomic_write)
+			iomi.flags |= IOMAP_ATOMIC;
+
 		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
 			ret = -EAGAIN;
 			if (iomi.pos >= dio->i_size ||
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index c16fd55f5595..c95576420bca 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -98,7 +98,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_REPORT,		"REPORT" }, \
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
-	{ IOMAP_NOWAIT,		"NOWAIT" }
+	{ IOMAP_NOWAIT,		"NOWAIT" }, \
+	{ IOMAP_ATOMIC,		"ATOMIC" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..9eac704a0d6f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -178,6 +178,7 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
+#define IOMAP_ATOMIC		(1 << 9)
 
 struct iomap_ops {
 	/*
-- 
2.31.1



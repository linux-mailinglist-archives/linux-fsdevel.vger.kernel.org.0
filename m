Return-Path: <linux-fsdevel+bounces-13455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5D870203
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CA81C21A39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59D23D560;
	Mon,  4 Mar 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="expRhtz8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xsA+gFMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11C3C6BF;
	Mon,  4 Mar 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557519; cv=fail; b=qE8ATL59Bq0unQnzSo/dsy460c+rbB0KUzfehoAWwG94v1ntGYQmfvomJ6Wo+il9x8sX2j3CHHkNlH1nzhFPiteFi8OCHqhBv/d0kFyeJNQOtNslnA2YwcVi0YEr4dlFnhlIZvjDbTxShDyLhJBzHcvEyfrnvF5yiFkaabTZjtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557519; c=relaxed/simple;
	bh=xNQwUitkDZfeGuGIbNExKzUKnnQVHICh+K1gLw/jXRk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YmrDxIqR6N5uzNM6qoTO02q/SRwlnEnlFQISVKhFztFbNYU9Z5b+eowlO88W6a658fqdSxdnLIN3qJSy2SyLKSvp2/Qi1G2JhqwF1rUb+EWs3wfqizBgrkqVWRC8H53WLuHxrzuFT/HYojaau0pdg2rZcNuIfPT91xf4sGvxBz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=expRhtz8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xsA+gFMT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTm1B028515;
	Mon, 4 Mar 2024 13:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=fk73XJa1WWF8JwpLrevrw5kFok4q/L5GEfNIsnm0+d8=;
 b=expRhtz8IDnuG4fAizickkDLOTMRDvHBmxtrjPBxI+sW+SomX+r1EpPykOfn/anRbRle
 fgVwDBgXBSMoHKFy3twIvg82yCHLFKWjDb4AqfS6F3UsWWIVrgtmv9yUnCLDKpsst+D2
 FGXiNES6lpvA7x136W2nNlfN2+0K2kP0S0qSEgjZYoxCTQicmqfwDU4vaYXjsNWRlXAd
 AUe0gZxsMB55mPKe3R5zU3pcLheqXPXk8EGKIR8TnKiZkg36a+0xpLOI+qLVWn7K3mCW
 R65acdlqWfmJOY+z2lM13APhrhmmrEQXuWzAnL+0zno3DZyhHZQBVuyB6bxLpl1WeQ4A pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnuuf9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:04:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424CHn35019267;
	Mon, 4 Mar 2024 13:04:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5qgfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 13:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=immSoiTEJnp3OEDxmYphsssic31SdXHyL8dtyDndMkoJiuqzLiJHDq2CexYNhh4H/O3Lx+2aLxFMOL11UZvOyOLED09DWJBx1CW/xYruoBrAMDpG2JUW4bibAgKcmrLJyryH/4J/q4sAyeulAFZc8Yl8lN2V160AxwYuq1l/TRepT9YWXEA5Bh7lLqSAX4JCv32ETOjOfgzGfpKjgUcN8u2+IkusgoWFTW4oiI4QQcUkEuCi90xKtRIVvCWPO0qdbpN1ABgXXkhxSE6EQMMvQafv0RsxSMInRTnkg56CbwV1jHrFYLlSpHRSnhNhBw5P0o6pxcTQsY51K3bT0BEWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk73XJa1WWF8JwpLrevrw5kFok4q/L5GEfNIsnm0+d8=;
 b=WkpET4LfJIJkYagQMdCP79Bqz8UWTP4zvTKDRiTtYjmTeQ+wldk4d9bx6OkjwBKBs3x18bHwaWtLvaI+WLO6Mn1pLp2gi470u/3IW0V0fTDlZ2RlEqow1HRYxZvbf0eQbp78bVRJt+VPEvYGq0dBFsy4JBbyN4t1aHK07jbFHH4HBYEEPflX0rey3y4dPiAJFnj9Q3LtpDZFRhU1NaPSVh/Db30VNnn4ElN7FTH0Zb8cPtD6SFOESVJY9ygq0WofRNqfTL8JX3MpRYrqUsggYDNB32UeBUK2YCb0UOvhT8iZMt6Lqnd2Oe7jYpamf0AZ/oPaGaE0IVMdEFFUEt4SFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk73XJa1WWF8JwpLrevrw5kFok4q/L5GEfNIsnm0+d8=;
 b=xsA+gFMT3lGoG8HNR3nSAeBrMkuhSf4ba9/4alD9r5Fxo5tLGtPRVjFP9jTIENBrbuBz9kn/oB6m41H9WUB+GF/Yasgey9HMLvHCuGuU7/VdeW+2chcL7yYMlfwxHk2kc9uPLOykyzAF3uNWHwdba7VI6l0B+TuF7hGdS52o+Uk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7805.namprd10.prod.outlook.com (2603:10b6:610:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:04:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:04:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, david@fromorbit.com,
        axboe@kernel.dk
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, linux-block@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 00/14] block atomic writes for XFS
Date: Mon,  4 Mar 2024 13:04:14 +0000
Message-Id: <20240304130428.13026-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: c04f2a3a-749e-41b2-163c-08dc3c4bb0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	URLEi1gNXzBtEbMfYXePI1/0vltRvF7q99K/oaLvkyROpOtLZ3UaRs8NBBhd4nT1j1vZ78U4LJeI+YLB0/NUYkLJR0r9nlGXsp+/Un0TERA7QPLS1QvJBRKDe8r+ErdxfBo3VdvyULuoBSaNDyj0f3YOOYIauBWcXS52fN1cbxusZOdEGuS92l9pJ4haOqNenhw4aARxonCB6KYWDHnPRj31oF4m/Vc2Nzet/7hOhDrJlPjKnkt1cbmLmqUgoCw6tMMHU57IoM3ZA0ESKl0Jh/RH7LlGvJJqifBBY0IzwNzRT0NoXtHsPaQoLZtKiWuYhX0Xi6aLGHu/V+wbQ9M6Fyup3irvjA6qj0UBla90YxY66vtVzptesiLW8FMDJFpNvQn2XiFP0uTHZCIHJDrOglYW8NlNLnqqzeyYlLqA/H94EGYCyQ4baG3zVn4ozQ6si3iRsnnp7sukJCHgoO8ji2cJdla9FjXD4o5R+mUpQS4dHJcRT/FCjEV/L9au1BCRZQoSUPGAU7qusPvohshFctrBSDkYPgqqJB0JJREWQjMIgAUEvM6KwQkUOiOUfx+v2kESJ+NqifFQ0wVTPiRTr68o4a8qcYWADnckveBG9HTBcdhWKgAKe57NU2uG8944
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dCMdisYN0FpoqBFHTFoIsmm4s+zfT1laN1bT5MNC2X+0WLUxkwDUy/0tW8/P?=
 =?us-ascii?Q?ukzLGd16K8tePxODSsGGxE5h+rZiiI75ix7m/onDaZepeN/rgWJnxVmhgKjn?=
 =?us-ascii?Q?Glp2BO7faJCY+rOMBJ2PxVBykTDWpokFSidTWSFnQEz/y9F79efnLekttpEV?=
 =?us-ascii?Q?uH0pOM+Sa4ZnYifxwaIgNY+WdaMXLMWnp+7oR/WMvu5quqQyTWD41JDLwgUE?=
 =?us-ascii?Q?T0d9O0TNPnR8WXhwL4LNd6C/BW5EP3lJnUGgeh8y/Pn9YPVBLR26ebVtdfpD?=
 =?us-ascii?Q?WzjIQ8OMnnNw738kncR+Id5yqwgGilWy369G6vPUrli3K0vZoH39em+fOBKt?=
 =?us-ascii?Q?3YjG4dPv38MZEWDdeTQ8l1yV5TdD8Iqxi+EQf0g+anjJfez2OnomB1e6rT0f?=
 =?us-ascii?Q?gAsFtcbZgKw0drVGBblmg2hzlNYK0Mhu+CiLIKJSM/PRdD7Oqxrnxw5jp/pm?=
 =?us-ascii?Q?iywsEpKq5H46CJ/nggB1IOPLA8ZThd4WRHmtwTrgJady492NWuiDvSfV0xTr?=
 =?us-ascii?Q?IJK2K9E8d1RjnHulIwsc6QykkTzUkSvU2ec+4m2rCp05ZUEv47HvObmu5Va4?=
 =?us-ascii?Q?+eLXh9AdzJiBCHteqXnsHQLK0mB8dWXklJGyW35CWV3aerdFvMRAnPicfEBN?=
 =?us-ascii?Q?mhTooomTAa36Hdkg+WBe60d+BhYGgk15H6RVZ4frurqGS51fApyuasRwoEd5?=
 =?us-ascii?Q?KtjvJQwVR5TTRwwmKq1ui9ELsCR3ExO3/VouJ5ibEwzh9hqKey8cdYm0mdGY?=
 =?us-ascii?Q?D8YeV18nhyaSrEYpJ/Oz22x3mNPoA7pi1Rxn/2GTbJGTsEfTLOu39eOq0c/H?=
 =?us-ascii?Q?M11Ugs7pqAyMhM7jqmZNX/rpaLud+3kE4Xep0NtUkdAsOsOzfoEAtxZzJhht?=
 =?us-ascii?Q?dz+D43JBaR2eCjPVNGV3BsHrthQzkWG3Ib/q/rckgOk1pO+OFbeOUmSkJcH/?=
 =?us-ascii?Q?a9Ol/maoJtTxUDC3k8IlJr8vAIwsi4NiTW6TYQALSAcCo5HjAoMkBbQQZIpb?=
 =?us-ascii?Q?jgDoYN0mGai2L9sIKKcrRnRVJDlpZ0+Petxp4EIud0kEwu40G82Uws0OEwMM?=
 =?us-ascii?Q?JoECvlzivF6egcWnoyfOnQZTHrk0C2JGesersBfGWERBNwspy3VUvlD5P5FB?=
 =?us-ascii?Q?hXz1sd0BxsO7iJvZwMxY52qg3xMzeuYiW3olsQF9n5cIX03uZDNT3466MBlC?=
 =?us-ascii?Q?ZmhuB+i21VO4ctlo2R9/PFQ5wAIxICtOObusTRCXWeInmGLOIOB2e+l73uUA?=
 =?us-ascii?Q?vSxjBEDnFwyedSzzXecLT4uwQA5BwX2E9j+lpVa8G/0/Eh6zSMDGWPc0Zfco?=
 =?us-ascii?Q?GyvpdjqJZLcVuscWqTn3icDosKJKuTaGHOd78L4RRMTIBc8V69PO2bAQcpp+?=
 =?us-ascii?Q?HbsKQblHxUsHC0O7N6I1Er9CbvQ8rynvJh7YjA/qZGHGDASd7eaH2i+BWDY6?=
 =?us-ascii?Q?AHTtweQTpLV/wpFRXebfZPN3F7U/QrRhEghsD/tQ90hRAmM0Ecf7WZlrRHiy?=
 =?us-ascii?Q?8u/friRKvE8IpOGO/YZO0QU+2NBFctgrS65yFkoitGtIwpfTt5dMPz3BEUIy?=
 =?us-ascii?Q?qpLlTqL7tRlc4reg2+9yvcamFbFw0fSP21U3bm+slfduLfH+WcOwiWqXdfSe?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Mq2dgdH9F4BLz+ZuO2L93W0lg8BRjdgPW/7GuMC3f7u4dQKGGS98h3q6ApoYl+nVJLegaMjNR/Ps2PcrNDcciVjp/tnzXfMIlBn7bKoh5t6I5ZWHkjEOVo0pNTgOs5qXCOhP+YvFcjmexX+VNwCjXzmBG0T38H7kdK1eesUvxVMEa+G21LUdA1oRcupa44IoPJNHMWzJ5cM+NIOPsvg5llOWhHTCyq+XNi+pVR3cRWuiLsT1Wpdwb2ja8Zl4r/AT/UnG9goQl0ZNDINv+VqCVakFMvMBfgnXBVPbJsz8wZdiq4+traec+eyIGRSQH3RJlu+7e+y1HZEmur63Nkmuc1YEcjdEjRgTqYcIPeRuyMDm03NdO9N4gKcyN7C0ZS+VYnZdSCGrjbXrQP99FNM2/tWuCRYOX4YZBPIjlUmAelF0mqUoKYv8NGv1syT0jGcJ+ELx2KPvnIry7Rx2aD1IHuyCKnUPR4cdXb4aglzmTKkNtd3TOmro+V9FVM1OAQeTDnthjQ83owTswmpOiW1/DdN0ArnAmhRaq0zmBDAbAPQwYOodqi1+o1lE+RGuyNm96QOweVEoKz369fUlkC8/cKPcXiLwdnHaWXqKkJ3l8Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04f2a3a-749e-41b2-163c-08dc3c4bb0be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 13:04:56.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thsj/prLtW9a5arg2fa7AmMXImnPiEKPN/JSKNxms7LlNxh/q+3bAT3QwxUF40E9EVlJIFm/2CCrsODRsNwnPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_09,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040098
X-Proofpoint-ORIG-GUID: 02gk-A0QnAP5xNYuwVpNU2eoKtXhbQJT
X-Proofpoint-GUID: 02gk-A0QnAP5xNYuwVpNU2eoKtXhbQJT


This series expands atomic write support to filesystems, specifically
XFS. Extent alignment is based on new feature forcealign (again), and we
do not rely on XFS rtvol extent alignment this time.

Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.

A FS can be formatted for atomic writes as follows:
mkfs.xfs -i forcealign=1 -d extsize=16384 -d atomic-writes=1  /dev/sda

atomic-writes=1 just enables atomic writes in the SB, but does not auto-
enable atomic writes for each file. There are no mkfs checks yet whether
the underlying HW actually supports atomic writes for at least 16K, but
this will be added.

Support can be enabled through xfs_io command:
$xfs_io -c "lsattr -v" filename
[extsize, force-align]
$xfs_io -c "extsize" filename
[16384] filename
$xfs_io -c "chattr +W" filename
$xfs_io -c "lsattr -v" filename
[extsize, force-align, atomic-writes] filename
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 4096
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

Note that, apart from "Do not free EOF blocks for forcealign" change, XFS
forcealign support has not been updated or comments addressed since
originally sent in:
https://lore.kernel.org/linux-xfs/20230929102726.2985188-1-john.g.garry@oracle.com/

I was waiting until this series was progressed for updating forcealign:
https://lore.kernel.org/linux-xfs/20231004001943.349265-1-david@fromorbit.com/
I don't know the status of that series.

Baseline is following series (which is based on v6.8-rc5):
https://lore.kernel.org/linux-block/20240226173612.1478858-1-john.g.garry@oracle.com/

Basic xfsprogs support at:
https://github.com/johnpgarry/xfsprogs-dev/tree/forcealign_and_atomicwrites_for_v2_xfs_block_atomic_writes

Patches for this series can be found at:
https://github.com/johnpgarry/linux/commits/atomic-writes-v6.8-v5-fs-v2/

Changes since v1:
https://lore.kernel.org/linux-xfs/20240124142645.9334-1-john.g.garry@oracle.com/
- Add blk_validate_atomic_write_op_size() (Darrick suggested idea)
- Swap forcealign for rtvol support (Dave requested forcealign)
- Sub-extent DIO zeroing (Dave wanted rid of XFS_BMAPI_ZERO usage)
- Improve coding for XFS statx support (Darrick, Ojaswin)
- Improve conditions for setting FMODE_CAN_ATOMIC_WRITE (Darrick)
- Improve commit message for FS_XFLAG_ATOMICWRITES flag (Darrick)
- Validate atomic writes in xfs_file_dio_write()
- Drop IOMAP_ATOMIC

Darrick J. Wong (3):
  fs: xfs: Introduce FORCEALIGN inode flag
  fs: xfs: Make file data allocations observe the 'forcealign' flag
  fs: xfs: Enable file data forcealign feature

John Garry (11):
  block: Add blk_validate_atomic_write_op_size()
  fs: xfs: Don't use low-space allocator for alignment > 1
  fs: xfs: Do not free EOF blocks for forcealign
  fs: iomap: Sub-extent zeroing
  fs: xfs: iomap: Sub-extent zeroing
  fs: Add FS_XFLAG_ATOMICWRITES flag
  fs: iomap: Atomic write support
  fs: xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
  fs: xfs: Support atomic write for statx
  fs: xfs: Validate atomic writes
  fs: xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 block/blk-core.c              | 17 ++++++++++
 fs/iomap/direct-io.c          | 24 ++++++++++----
 fs/xfs/libxfs/xfs_bmap.c      | 26 ++++++++++++---
 fs/xfs/libxfs/xfs_format.h    | 16 ++++++++--
 fs/xfs/libxfs/xfs_inode_buf.c | 40 +++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_buf.h |  3 ++
 fs/xfs/libxfs/xfs_sb.c        |  4 +++
 fs/xfs/xfs_bmap_util.c        |  7 +++-
 fs/xfs/xfs_file.c             | 60 +++++++++++++++++++++++++++--------
 fs/xfs/xfs_inode.c            | 28 ++++++++++++++++
 fs/xfs/xfs_inode.h            | 11 +++++++
 fs/xfs/xfs_ioctl.c            | 49 ++++++++++++++++++++++++++--
 fs/xfs/xfs_iomap.c            | 19 +++++++++--
 fs/xfs/xfs_iops.c             | 38 ++++++++++++++++++++++
 fs/xfs/xfs_mount.h            |  4 +++
 fs/xfs/xfs_super.c            |  8 +++++
 include/linux/iomap.h         |  1 +
 include/uapi/linux/fs.h       |  3 ++
 18 files changed, 324 insertions(+), 34 deletions(-)

-- 
2.31.1



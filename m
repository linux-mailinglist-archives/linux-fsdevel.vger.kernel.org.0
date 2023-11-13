Return-Path: <linux-fsdevel+bounces-2804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F47EA327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513791F22481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1322F04;
	Mon, 13 Nov 2023 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bWGbd0pB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VkmshDAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D122EEF
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 18:59:00 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0E910DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 10:58:58 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADHiO8c022247;
	Mon, 13 Nov 2023 18:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=lwbCDMJ4HEYWI8pQujd0Bu3x6yhArIskfTXLhCEK7zA=;
 b=bWGbd0pBKHfpwXsi0/eJcmI2LU9/ijEhevO2VG8DS/qaY9UUCWkIr19I8z3W1pH8UYIb
 a9EfBThXlPPlZHqvh4TobjBOneEq3wzxS1u4DFryPrpT8nXXN6viEc3aDse/ShMh38q9
 fS+ThGh8mZdrcsGC1MDztfXRXEwKcLmZx/MM5iN4j4LTgBWW50vSCgDHvYyftLunVhuj
 qp9Sl5vAD+t97YUy76skq00JV8HPcUFZPV49XzxnRJxP+Dp1odiWx07yhG2+qkFZzuQd
 1IISkrYFB1Fb7lB12S5jfMxtGdGtXZI7moSKYY+Z4FzV3spZB4j8X+u8O5P+g2lrKWnH XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stkh51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Nov 2023 18:58:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADIOru4004552;
	Mon, 13 Nov 2023 18:58:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k24fhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Nov 2023 18:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVned3Sijy+x3GZU1VMg+kc0yK5GckAOyh/UGILMRPQDLOcm3SYfM8jiX1k5r4+O5AfGgtnMtvfHiB4HQN4QjXF1UUwMH6kGd3x7QtIR62vqDYXPPsxwDEZSiBDchfD/b8ZVAuMzXPNEuqrzEogDlLDHbf7CHaPnelTTaDvNw4vhRaECcISp/CgMbx/ZfJ6vHxZ12cpYOeupUZlgQAeU3JmEIM3fh6se+uQhYnTpddHpGFjve+YeHWgzAbfgotReJyWWDujVQhT1K/SdBvaAodfZrIGahuJLYmrdhyra3k3kHP2ignq+sXJJGL3kkiSpmbtpBcUZ3nEcbPOhBCiZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwbCDMJ4HEYWI8pQujd0Bu3x6yhArIskfTXLhCEK7zA=;
 b=dSjELdjzV9QhODz3VqcW0Q8J2HcdXaEM/mzUi7ASNHo3/AoO0K5ULj0WYk7/CxyKicJNNN5//D7ad/9TpsGGSoBIIkOIcIzSDC+1Jhr9taWa5AckZcc22LeOhLJbxAayAewxtLjtTnWnh0UJkqcp2y557BgtST7Py341WpToybQxYyoNkQv2k0iw0f4kNOu3DMcdQDv5Dq8VPejtdO0+St+Qbgp2dyjFJvSF17A6LIC0vzr2V7z40WTVTFZPiIgYERtWLcyTSX6XJ2+AzSjBLFThXEEkd0mAMwmwMtPBlOD000/iYpNzyOkA2+hAZ4RcXbmlHuNnnh8lJ6To7s8Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwbCDMJ4HEYWI8pQujd0Bu3x6yhArIskfTXLhCEK7zA=;
 b=VkmshDAspJ7ZTLGdGuQpavRHGgzRCej/cUrhzrD4ZAMJmkZxczaLphhe/HVUSToTMQqI/gBtlmtRZNsmoNYtj8WdoZ1oqW04Qrkb6q0MgUCRQjqecRFOJEvaLBY5DTK7kCQRJJsvw0OV3Vp0Stf/C/buHrN5+0Z9pB2aymfsFGw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4825.namprd10.prod.outlook.com (2603:10b6:610:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 18:58:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 18:58:33 +0000
Date: Mon, 13 Nov 2023 13:58:30 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: tavianator@tavianator.com
Cc: cel@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
        hughd@google.com, jlayton@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v7 3/3] shmem: stable directory offsets
Message-ID: <ZVJx1jvSZjupTyWk@tissot.1015granger.net>
References: <168814734331.530310.3911190551060453102.stgit@manet.1015granger.net>
 <20231113180616.2831430-1-tavianator@tavianator.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113180616.2831430-1-tavianator@tavianator.com>
X-ClientProxiedBy: CH0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:610:b2::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 32011036-72ec-4f0c-16e6-08dbe47a8897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Nky5kbcmk7GbwCs+L5XLgSWfVuxVYaS6SuW7/nXlxbbDLi2FZAYvaR+FUJzNX9W4WOGR27F+yBpGiEa03h2CNER+uhPCa8uQRCJagHyitfP1MJjbT2S9uUl1K/Gurn3qISHEE4ochNNEYaSxgmDINFN01+K2UXjmU5czYNQjkKO+eiVo9g7nVKgTfCsECwMdXVTpxtP4hLmDtOGDYig6nJMLJgqUIZkRqI/26Nn1OUEoedMC3qDsLssOmKUOh1t7Ct8aJUqY3POF68/Hx7XRlFeaHI2vW7mGUMjuYUnVNjK7/GkqVGNCtggOlmtUjC1BxBUfeAgIrna7R+xDg03eoEIm/ufecRgNTR/XLDcHqlzplPKgHgbA5sZe7FKq+Ovg7f2XaIjGZKbZm5ExyptMdNw53ps8NDVwhAlTWgJyAdlkvpgXAe3NjJguUOkZw4m/+SMReTvDqy2rERZt0u/2GcEwM4XRMGaTPIx5PMUHZamt43Oz59Ht/TTR1t/CLkm5UpgQWURWDqh/nJMi/YKdRmXrb1LA7ISMivMFD7o4kpodSUNUUHfdNDxVvq9Geo9AZg6ErAJ11PwIl+ZRHqoVgA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66476007)(6916009)(316002)(66556008)(66946007)(86362001)(38100700002)(26005)(83380400001)(6486002)(478600001)(966005)(8936002)(8676002)(4326008)(44832011)(6512007)(9686003)(6506007)(2906002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CL0wzmiISVsOI2qjqBPpfvBSS/JPgwr+1KbpfHtCyCCqQ7gRBe6xjK767iul?=
 =?us-ascii?Q?fjBO97VPO6UhqD0Y6ntY7N2WNrQTvoY2cYn3vAkl2ql0Eko2FaHaKHr8/J93?=
 =?us-ascii?Q?oUk+U1vhM6wFePhzs8GIeCMoSYUaRdits2wQMF9P+W6hD/AknWlXXy6vy1+d?=
 =?us-ascii?Q?h2MizVnTW26Zy/Pt4CKDaPJ4nk/eFznmnDWjcK0q3Cr1mgrMVeaqYgoesS6l?=
 =?us-ascii?Q?R1TTN04bxpazqMSMYCwpN3EK7LIIFk9eIfQB/sQKu7cWFYcZP6Aa0QQ1G9aS?=
 =?us-ascii?Q?ktw5AZghrAhabyBvmwH1w9y/PMzcieGe1/9/JXKcXseUCg2O1dGdz2ItyRZM?=
 =?us-ascii?Q?+uUO2ZN4VwN/7Is4p/ZRT8c8Yvy/u159c6HFV5ExQwbXZjLjAkjUcwxmuI0X?=
 =?us-ascii?Q?B0vZPFi9Hnwa5Vjbs16WfQSotHQzfqy3axU8mHD7EiSuk9aaS/RfKPfykmit?=
 =?us-ascii?Q?JIetUILaqGAt/Qh93Kn+bdso7qF8/vQiB1z14AAW64M8jAZ8b0L3BDac9vIg?=
 =?us-ascii?Q?quHuEJlcX4FdDqz+XPeikXElxiz4lax9kjU0ndyB8eUuujckMJtJWs7FTFce?=
 =?us-ascii?Q?WM5JStR4Xw6w1z6+jwYIovqZ4HqChMJA08nVFshUuC0Ty15PZTwAAphHLMVQ?=
 =?us-ascii?Q?iHbeubMD83stNnOTCSbapsBPRN5UOXN4IEUpEq++hZYXkstOpzzqRWbCezV2?=
 =?us-ascii?Q?nKsekCeM0K/mmwc8d2lbXA0TntFV8Qp6LSrvNdgnnQeLBDhL0jYQhdiE15Zr?=
 =?us-ascii?Q?nFZvvDyaA0f71R1I3M458P/WGMPa6s0mBXJejGniuSyiYgiHQjNKHy762VbE?=
 =?us-ascii?Q?q8QdJZ1lnf47qFrOKJof0Zq+Sfllz958ztWwVQgJB183pGY1cq58crClHbKw?=
 =?us-ascii?Q?Ai8CKRbsupbwSaxh3GPiR1pre9ZpKWCPmerjqnQ+XfOGeus7dI78cLy8UhGP?=
 =?us-ascii?Q?oE4C+58G+usqxW1qbVI6gsu0mQ/lBgSgOg5kTE3PSa88yE4ex+JlmJlNZFbK?=
 =?us-ascii?Q?l3LeXoM0p3AgXmDgrz/CkwoQFixcHaap6MI08cMwsRD8F69vPAWZUhq19l7p?=
 =?us-ascii?Q?Jhu5Wvwyrrkx+YHoOdSuDacdSuEQ4HrvBsss5MZFbpsf4KCj4FTETUqoGYBk?=
 =?us-ascii?Q?DqGe+zq0YU4Y+1IzscAZi9sQFfFYziJna5oBIK40sVUcsMvVCU4BaNB5iO1q?=
 =?us-ascii?Q?9QtPLLJuzximJe8Hh1t+uIIQPzlZ/xzglhd+r7enAXKzYFQX/gSZFXYcuFls?=
 =?us-ascii?Q?kTdv7ZWl1ygJvn+rhuhAUUXCAHmuJHxO9t9e9HqUnQzVuXEhHIz6uPHteW10?=
 =?us-ascii?Q?UBX0qgzbCrGhlhi2dG5dlI+LYCWwxmepC7xwZyxfFJ1Yx0sk5LhTmECRxBNP?=
 =?us-ascii?Q?AySfwdQSKl9objsRl57Os3KWoU06skDIvNeZUB8YMyQLqqnc+Rx66dRuPA0e?=
 =?us-ascii?Q?OjzeoxIjrHEqGxJi6f9FJreO6uDteN7nI42565+B/Yyc83+1CkfXy1W8tZYY?=
 =?us-ascii?Q?wRQjInFvFWb0W+iDyJNG3zmkz4upRYHDUhQzCa4r4lOTz3Q3Z98UxlIelspE?=
 =?us-ascii?Q?YeA3RkHdOjiIxEkW3hWkBELi1G2z42ohRXBfOidYUmHDj0yvpf9W6ToB7Whs?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?EBv1q2Q0FXtW5Su+HOrIVOAV/YikRWdyCKI1u3DUasMA8paNGIMtToHai+Pw?=
 =?us-ascii?Q?wWl+zb4tzr11k4iDMP29xml6BYTrvbsZRxtpY8swLyOAjZVE84YvMOJoYuwj?=
 =?us-ascii?Q?jpsbubPbpOgMpJL3Mpcrzof2KahAxtBFXp5qdADutmmQSnclTgL+LHwEOFga?=
 =?us-ascii?Q?hYCqUBTL9/KIA0UH0WAZ0yYRN+qcWY+b1nQqJ9L4JPzHHgZru+0tsk2J1U4v?=
 =?us-ascii?Q?3MXi5tOp1NE0CCZg0PMI2K2GpQm9nBNcC9yGyR5GsXOESUhs84cq/ZIsxp96?=
 =?us-ascii?Q?YPOfX5kuriDhzD1HmL97RGmi5cWyP/l+80TqgGKnlxOL1WVbBRJi4rJz1wo2?=
 =?us-ascii?Q?BrUiSoGOhkMCiQ9nF33Oh1XXSQ8SnbA47EDRouFFhxjd6+cQsvPwF7s0/sq/?=
 =?us-ascii?Q?uc/Hp+1yNUW07yDR7oX975ySBPNdqZ4FR1F7VzUJ2isr06Wh9OX/rFK9MC++?=
 =?us-ascii?Q?6/MYz6r+ocszeR88nxGfho0Xqei7CQSCHHaGk1LwT69/GP9ARNXQJjdVhUJQ?=
 =?us-ascii?Q?YKuhvC2inE9knDZvCbJRW6uky43tUVTzHf40pJJKnPw8amby4/Ker4DLDffa?=
 =?us-ascii?Q?3CQNUy+l3xBKZZreavDxwX7Ylf//dNYrGmRFSeDELEudNVQ4ffXSq8r1RHGl?=
 =?us-ascii?Q?rYJj8i4QLMbER9l83rmcmSB+85QZi3RFbK14woSzh91jFWsjw/O0dneAtnVS?=
 =?us-ascii?Q?KRQtuiUS17Kq5PwwvjtEc6ecO+brm3e1eN+tzrLMb6DKOgxZhEZyVCi07KUB?=
 =?us-ascii?Q?mJAZh39qen7ebEsIp+T0T7WmxgAFAwr/vEXt1o7/gJ097TNU83ZibOnXBLxJ?=
 =?us-ascii?Q?PtLe/xwhz76zM7weqRGuIdokdJ3X6TAaGBOKHov178XaQMdZ7KQymV5fqwMv?=
 =?us-ascii?Q?QK9ga2TYACnQnEnzq0pAuc5i0fmWeFO5buB2AHlSzUzjIJj6nGMkRGb0k5E4?=
 =?us-ascii?Q?FBpnbNwc8syp/FcQDnq7nE9r2jjxfhFc/mYkJVLuf9MLxX4sQ3T0+joBqNF6?=
 =?us-ascii?Q?1xCj40h/dRSQwcmGPbdW6qspCw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32011036-72ec-4f0c-16e6-08dbe47a8897
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:58:33.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghz4gre/xFm9q/fogzDF9m4c3t7XY49zbxWCH2uXoi6iwf1OMIioPOgWVRZlimGpAP3y1ahphIgXCF0glLNhlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130153
X-Proofpoint-GUID: uN8j5YVT9C8enHN1F6NIMvss1f316OLf
X-Proofpoint-ORIG-GUID: uN8j5YVT9C8enHN1F6NIMvss1f316OLf

On Mon, Nov 13, 2023 at 01:06:16PM -0500, tavianator@tavianator.com wrote:
> On Fri, 30 Jun 2023 at 13:49:03 -0400, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > The current cursor-based directory offset mechanism doesn't work
> > when a tmpfs filesystem is exported via NFS. This is because NFS
> > clients do not open directories. Each server-side READDIR operation
> > has to open the directory, read it, then close it. The cursor state
> > for that directory, being associated strictly with the opened
> > struct file, is thus discarded after each NFS READDIR operation.
> >
> > Directory offsets are cached not only by NFS clients, but also by
> > user space libraries on those clients. Essentially there is no way
> > to invalidate those caches when directory offsets have changed on
> > an NFS server after the offset-to-dentry mapping changes. Thus the
> > whole application stack depends on unchanging directory offsets.
> >
> > The solution we've come up with is to make the directory offset for
> > each file in a tmpfs filesystem stable for the life of the directory
> > entry it represents.
> >
> > shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
> > directory offset (an loff_t integer) to the memory address of a
> > struct dentry.
> 
> I believe this patch is responsible for a tmpfs behaviour change when
> a directory is modified while being read.  The following test program
> 
> #include <dirent.h>
> #include <err.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/stat.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[]) {
> 	const char *tmp = "/tmp";
> 	if (argc >= 2)
> 		tmp = argv[1];
> 
> 	char *dir_path;
> 	if (asprintf(&dir_path, "%s/foo.XXXXXX", tmp) < 0)
> 		err(EXIT_FAILURE, "asprintf()");
> 
> 	if (!mkdtemp(dir_path))
> 		err(EXIT_FAILURE, "mkdtemp(%s)", dir_path);
> 
> 	char *file_path;
> 	if (asprintf(&file_path, "%s/bar", dir_path) < 0)
> 		err(EXIT_FAILURE, "asprintf()");
> 
> 	if (creat(file_path, 0644) < 0)
> 		err(EXIT_FAILURE, "creat(%s)", file_path);
> 
> 	DIR *dir = opendir(dir_path);
> 	if (!dir)
> 		err(EXIT_FAILURE, "opendir(%s)", dir_path);
> 
> 	struct dirent *de;
> 	while ((de = readdir(dir))) {
> 		printf("readdir(): %s/%s\n", dir_path, de->d_name);
> 		if (de->d_name[0] == '.')
> 			continue;
> 
> 		if (unlink(file_path) != 0)
> 			err(EXIT_FAILURE, "unlink(%s)", file_path);
> 
> 		if (creat(file_path, 0644) < 0)
> 			err(EXIT_FAILURE, "creat(%s)", file_path);
> 	}
> 
> 	return EXIT_SUCCESS;
> }
> 
> when run on Linux 6.5, doesn't print the new directory entry:
> 
> tavianator@graphene $ uname -a
> Linux graphene 6.5.9-arch2-1 #1 SMP PREEMPT_DYNAMIC Thu, 26 Oct 2023 00:52:20 +0000 x86_64 GNU/Linux
> tavianator@graphene $ gcc -Wall foo.c -o foo
> tavianator@graphene $ ./foo
> readdir(): /tmp/foo.wgmdmm/.
> readdir(): /tmp/foo.wgmdmm/..
> readdir(): /tmp/foo.wgmdmm/bar
> 
> But on Linux 6.6, readdir() never stops:
> 
> tavianator@tachyon $ uname -a
> Linux tachyon 6.6.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 08 Nov 2023 16:05:38 +0000 x86_64 GNU/Linux
> tavianator@tachyon $ gcc foo.c -o foo
> tavianator@tachyon $ ./foo
> readdir(): /tmp/foo.XnIRqj/.
> readdir(): /tmp/foo.XnIRqj/..
> readdir(): /tmp/foo.XnIRqj/bar
> readdir(): /tmp/foo.XnIRqj/bar
> readdir(): /tmp/foo.XnIRqj/bar
> readdir(): /tmp/foo.XnIRqj/bar
> readdir(): /tmp/foo.XnIRqj/bar
> readdir(): /tmp/foo.XnIRqj/bar
> readdir(): /tmp/foo.XnIRqj/bar
> readdir(): /tmp/foo.XnIRqj/bar
> ...
> foo: creat(/tmp/foo.TTL6Fg/bar): Too many open files
> 
> POSIX says[1]
> 
> > If a file is removed from or added to the directory after the most recent
> > call to opendir() or rewinddir(), whether a subsequent call to readdir()
> > returns an entry for that file is unspecified.
> 
> so this isn't necessarily a *bug*, but I just wanted to point out the
> behaviour change.

I'm betting dollars to donuts that the v6.6 tmpfs behavior doesn't
match the behavior of other filesystems either.

Thanks for the reproducer, I'll look into it.


> I only noticed it because it broke one of my tests in
> bfs[2] (in a non-default build configuration).
> 
> [1]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.html
> [2]: https://github.com/tavianator/bfs/blob/main/tests/gnu/ignore_readdir_race_notdir.sh

-- 
Chuck Lever


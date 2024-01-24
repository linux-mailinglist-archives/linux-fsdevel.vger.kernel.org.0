Return-Path: <linux-fsdevel+bounces-8714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8604A83A85A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C5AB27D5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251F4F5F2;
	Wed, 24 Jan 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J+00KHaf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hHITNpJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814D2C69F;
	Wed, 24 Jan 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096501; cv=fail; b=oh2vVMEmaiUOLD+BLVjy5kO0dy5XcH3304aNC2AEMwswjA1dNSx+86y38FuB2EdxAdEDXjztljsZSi9Po0p7cYkkpbUZgdpRdgGnr0NPI+8+qSLkwX4BZxDP4vXl3N24bqHfO/y44zmJJA2MV2Dq4BFGM7n+r3OusmvRxammYJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096501; c=relaxed/simple;
	bh=rqg+aPem3Eu9+hiL3re8qTwC2/cIZIBrMFtbO7M02pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WM7eLr8IINLvHg6Jgekup/IOuYiHCAx6qwJxYVUuf6xSczSPnXQ9FtCO4uEs6D5VdFQJ+rCEzGEXY7gsc26bmNkUQv/ncRQtb9IACUuk84XE5vpSLaonUrf1qdVOm0VB6I2P/KzJv1irtHJXEa57bf5rnuXk5SwN4okCdRXqhNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J+00KHaf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hHITNpJM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwi1f019751;
	Wed, 24 Jan 2024 11:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=hxFxtZezNioZYeMyVS4tuzmqgmdZtTTEjDURJOhcqD4=;
 b=J+00KHafVivsQou7nSNAoSTd+Ks2xB6WShAbfBoG9Y+Ghtyjb3F5T9ie/HHPQJPGqqkJ
 ulyAXaYBc6KbWu2BafnEV/LO7S4j3HokXpXYeT1DcQIJPPTptTP7PvhUcb5IfHIhzJ67
 XyuLqGMOvybvo/Ph9zk4X3sUYDMfO5mAjWsTKZT08h+nx6njhYwAtXjBfFWvhqU1T73D
 /tvnyaXlYnEJrK0gcm2tSKTiOtt3DzUY5IXQ1F51DTvGI4VnqBUENSNyjrIB0GEJFrTv
 5KMPmax6Z4ru2tFfyTjkgw+bl/EXCSD0mwIXg2NW6gTMzqJUt9egLU/R0Mrm9AO8n7w8 Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w260j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBSk74006248;
	Wed, 24 Jan 2024 11:39:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32set4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7m70buIXS+Yd1m/0l/1ELni6nWwsNa6DlRngjF0P8u7TpevI83HH9FyekjNOpSpbROx9fmPCEGEX4eMCHvXYB+KTHcEQH/WY3MygnmMaLymyfY6nfuEEhLLZzqjqme9cm59JKuKlpyI3DluQvfjAgHTJVWO4Bq2Wb3x7WbkhIjzNOXCO78kvsewlhpmFXGRET/6MPWOm35kOpfd5/pWv/hwBpzPWj284R6XJeiKNdJYY/CU+WuhNcXcRJhT1pI6JHVtivOERQgGH/EvzLh29TUDZl6OoJk+KSr8R/APH6121WtxvS0n+LnXmh1dMe2TZDG/ceLG/qyaZLa7AsN5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxFxtZezNioZYeMyVS4tuzmqgmdZtTTEjDURJOhcqD4=;
 b=nkA+LFfIVwLD31eojrX4spXD2vlwTN0RsoSwrAn51ikROndXud+pyo5q0khoRdU7szy3H0BxHNjsnxtMTgp/scQbyNQa+YHfircvCvWlYrtT6T+j9cgax/aBRgekulkMMC9VFJqXS9eE7oqeZGncINv3CkVM7+gehNfrjomcm83EdJGq6tfINDtTWd2TO9BRuQZDimknpT8hFseMnacA3vLrjBnjr0nyRdEA9VNuALcSUU+Kr7414HLtgzYY773lyYlWEyCGlyXTam+5djSprbX+4k1GdjACk0OxUNam7MwYAIkVSfJV6P4/bs8tTJ7U7LxC+tO9eeiLJdkYZU9kIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxFxtZezNioZYeMyVS4tuzmqgmdZtTTEjDURJOhcqD4=;
 b=hHITNpJM9FwQZ7/b5ee7coNK7Mfn2W1KsORckwjX73PbooFA2gzf7/qdj78Ovb2yj9GAYXM+gdJq4SoZbg/pxBAv7VsLkTfD5KQoUEIP9aE3xFbdsDOaRMj6dyu5t1Su/9aZmOw4M6xVWaGUzZ6MqZWIKGmL0K8yvnHRffVRXik=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 03/15] fs/bdev: Add atomic write support info to statx
Date: Wed, 24 Jan 2024 11:38:29 +0000
Message-Id: <20240124113841.31824-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 03887da6-ada7-4013-6c4b-08dc1cd1159f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zBQ0264e0zKZJ1JDdcAYAY+ve6cQFzOREKebZWxp9y+mxM9H6jYF75L83bAS21/Pb6ajj2S0n0rhCv/cutsO2Etc71jwMvw3CwrWYv/Sapr9U1UvlQllOKdNEijVKjmAOlgMZLdVuPQVCwbbYEPLMmUs7q+TROmrt8wgNj3mI4irHkvVlfgTyn7t4AlbtoZ9HgpuDQ421/ufokoam3stWxvcg3htbPof/OBvinxxq+SGrmjiIvcezFywar+6Sr9ul7nkXMnRXUWHufEjfnevg08UAYyXpsRI2yCyvgp7SykvaSNCOF2bf9HWDUkiROUJngIHf/hpX7RaL/KzVG4lB/0lEDK4UQPj4fI5mD284z1ubgiIm2c+8hf6mxjA8H4FNXoG9CXGd6L97ZlOTpq/aiHqwf01CL+qIj/LCFArdFxIb/5aKGYiKL6X3pIiPJFtJ2/sZziRons7U5l8bk/vfHEKSiYC8BKcFisf0/AJ5W5AwdrjrFXck70OTxXaHlAQr+9+ZtxE2qQNfJf+3COqRBdas/EoM5Zmgv0UTqdODqTPPa1Fj8hGIOWPHPClxGF+qVxmW1WlbGhwZStoGLy8c9u1El2dPDblkeaMqO4BK+4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(54906003)(66476007)(921011)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C9hLoQORauqHDYE4O674akPz+LqNguh9K7l8nFnB/VojUGKa95bsoqJ6Xuy0?=
 =?us-ascii?Q?jyg4PZwHn0DU0ocr8amV3DL+qy6DyWIhc7SlGQMG17TurYWSiv6b/c8Ds20c?=
 =?us-ascii?Q?l5gJtxLTm2czcWBtKOXETchg0UYwBWy4WlhrYhmjW4+GlXqgk3KGnJDojkZe?=
 =?us-ascii?Q?BAiC8T6HdlKmi58ruCGHwo3MMNLvWbv3T+CmIntfPkzsaRiYQDWQS2cx8SXj?=
 =?us-ascii?Q?HOZEX++wDzyqQOqP7jceGh2/wFYWGUCRKuifFkoDO5MOXPZQAMLc7Q76s5m1?=
 =?us-ascii?Q?1YWKmd2wYnctr7/bFfvM/P5YjIKgYslB9ij37tcmIlFi+wx2kbUQylUMiDsr?=
 =?us-ascii?Q?crAK6xg2hwRCItCTyweWERmHXIgAtCOoAWL6L3jH+QsxnIUwDrYOSvDpxSdF?=
 =?us-ascii?Q?pBvuP2Rm/73JBbSXHgSsYcD6k9sv0Cv908xtP4Z8dPnZecVwpupEUSHAhb0U?=
 =?us-ascii?Q?wsEfcdwo4jZRy+im2ZXipm5uY5ExFJPJurUpoig/a+HoOqVjzD17h1xrZ7bB?=
 =?us-ascii?Q?EtIpxAAgS0cBzHXBC4MbyC2N87AXc3Azmn3eShB7ZRiOdqv4wIIb/UsU9m3P?=
 =?us-ascii?Q?hBgw4iff9FZQPmunLwJfZCzhaVo0Ugo6EcATy7BWs+cKjVOWM3ojyYx0gkqB?=
 =?us-ascii?Q?CuLhP08gcE1e0uvXYlfUd1kDgqulb3b7Mu5hh28B2w63Wn1vPI+JOeKkfWM9?=
 =?us-ascii?Q?v6x4u+VMl3eyFWsrsvyVUsF/V4jDV+wtIToPxMaAtE7QPHjVrbCGwP2UpHbZ?=
 =?us-ascii?Q?jgOar9qqGSbiqVwJVTKgO+/zsf7Cgxox+4uu7SHKZknTnLbNB8mzzMFSCpMn?=
 =?us-ascii?Q?bcK5O4cmeaL76TZwsPCJFauhyFap73SDZfyjNBYi06NwUEbuADh/Sm/qeZDj?=
 =?us-ascii?Q?lInwatWinFoeIGkkmrOeRP0SpQN2ACEkY6C2VGzTVzqOPE4Ir2iZ4Nvyx+zG?=
 =?us-ascii?Q?4hfo/yw5/UsmgeFNr6Me3SWcBsxxviMCODtLO3s7HV44QFJC0FAh8sW8Wt6r?=
 =?us-ascii?Q?JrCEB15Ok0IxHOmIV5HbecFBAnicv6CZRGn88TqjUEb16D1nzQih1/KUZTvZ?=
 =?us-ascii?Q?WbrjnO0Rt+QCVJQdsAnUUVNE9YoYdsPQOIF7SgpNRPNyIMGkC4t3RCqquV+7?=
 =?us-ascii?Q?JaifZjWo+VqMKKzW97vMNH0HdCefhhOwMQS2ZEOqnYnih+Yo3aqVWcQsioqo?=
 =?us-ascii?Q?iHkk3MJihvFrgCi5U5MtSOyFkn0vOK+6QRCmhJpB1gutVnx3NFYNrHqZBISC?=
 =?us-ascii?Q?d1ezYN8tqkXH2FVEFEvmmNRnooOQp3AoYBisF5nRwPu+QoBa05glYzYXXWgJ?=
 =?us-ascii?Q?Jv1iEcx8jBlEsYBLBRbH4SYslNmER75LOSMtEu/eVFXUFdADAP8rKacWSH2R?=
 =?us-ascii?Q?OikLsScZ9/TLaRgvlGeMvmBGFVLWWjHNTcMoMkWGJYqHFJYKb12K/SYiezCs?=
 =?us-ascii?Q?PRnUjlLFI0ME66dEIjotAbBwtPUOnPRNNO09KBz/HLHzgfMwg/PwwFx5JiUa?=
 =?us-ascii?Q?lX2gCJ2i39oUItUv4PCqLcr0W9ok72jhVJ4VjJtzsZ8hVpFnUbu6K17xAggR?=
 =?us-ascii?Q?K2n1ZsBGqUiRvUmydPI6KTajaerZa4jF6YqYzcaYCSkNbLyrH2UL4Cj/W6He?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c7QXgCUY355+g+tCff30S0kFNEpaOKwg572aDIikEXC/KdgSC+rdSrSgJlq6dBjQpX6PblBg3iJZKdO9YsNS89TXzea+THf3p9ygyRbBqQNgO20sR0S6cr0KdN9g2lrfan80/c1SMq5DUMRGtEYhs39utd+fAJA+JDVz5QHTOfRDqQbwsU3y6Xwx8qdDhr0tClKkcGb5n5XOR2R/r9wxfm9lj4/X77TmqEdEcOfuf5RcwUe4stg0ZkFzThg3LOnUutOBE0hZLD06UYvO0aE8Yr4sAi/hTvO7S4xbnNE6hIISJ9R08YzijgsKwJtAKytvxOLbLtT2etPKEtzRpTJ4bC4Ln57NfInsnsmWHJuqNigTs2aYp6S2ZGjWfdOLgm2nvfnsEd2XdASaj8kTSRrU8Cnk5TWrppiewbIUEiLojBH+Uf9EuM4Sc76pQE1T84bjK9F4+WXeadblk0TIKnknBN3c3rqp1s2MgN0jQWPSEXFMfJXCfR+Di09yhUIi2jczb2+T6M3u4KNS7DeERznmsclnWTvdBHWlkbMI7FNPYjAB1U90XErvLCBFOEEXyzuBszgFRsjNS6o0VXw+oWZ30VRTWnhhsWmC6OrzkkqDXIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03887da6-ada7-4013-6c4b-08dc1cd1159f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:11.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GG6I+kCxKI62zpam9B2vNOLGF1kusZSTMitIT7k/IS3glQQ8CYusRG4I3j71aBbNbP2tRNAus0DraXWRq4JJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-GUID: REcnc5q1sY2IWKGKkUsDqEZQQ0Su3r8t
X-Proofpoint-ORIG-GUID: REcnc5q1sY2IWKGKkUsDqEZQQ0Su3r8t

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Extend statx system call to return additional info for atomic write support
support if the specified file is a block device.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              | 37 +++++++++++++++++++++---------
 fs/stat.c                 | 47 +++++++++++++++++++++++++++++++++------
 include/linux/blkdev.h    |  5 +++--
 include/linux/fs.h        |  3 +++
 include/linux/stat.h      |  3 +++
 include/uapi/linux/stat.h |  9 +++++++-
 6 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e9f1b12bd75c..2185084ffc89 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1116,24 +1116,41 @@ void sync_bdevs(bool wait)
 	iput(old_inode);
 }
 
+#define BDEV_STATX_SUPPORTED_MASK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)
+
 /*
- * Handle STATX_DIOALIGN for block devices.
- *
- * Note that the inode passed to this is the inode of a block device node file,
- * not the block device's internal inode.  Therefore it is *not* valid to use
- * I_BDEV() here; the block device has to be looked up by i_rdev instead.
+ * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
  */
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask)
 {
 	struct block_device *bdev;
 
-	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!(request_mask & BDEV_STATX_SUPPORTED_MASK))
+		return;
+
+	/*
+	 * Note that d_backing_inode() returns the inode of a block device node
+	 * file, not the block device's internal inode.  Therefore it is *not*
+	 * valid to use I_BDEV() here; the block device has to be looked up by
+	 * i_rdev instead.
+	 */
+	bdev = blkdev_get_no_open(d_backing_inode(dentry)->i_rdev);
 	if (!bdev)
 		return;
 
-	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-	stat->dio_offset_align = bdev_logical_block_size(bdev);
-	stat->result_mask |= STATX_DIOALIGN;
+	if (request_mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+		stat->dio_offset_align = bdev_logical_block_size(bdev);
+		stat->result_mask |= STATX_DIOALIGN;
+	}
+
+	if (request_mask & STATX_WRITE_ATOMIC) {
+		struct request_queue *bd_queue = bdev->bd_queue;
+
+		generic_fill_statx_atomic_writes(stat,
+			queue_atomic_write_unit_min_bytes(bd_queue),
+			queue_atomic_write_unit_max_bytes(bd_queue));
+	}
 
 	blkdev_put_no_open(bdev);
 }
diff --git a/fs/stat.c b/fs/stat.c
index 77cdc69eb422..bd0618477702 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -89,6 +89,37 @@ void generic_fill_statx_attr(struct inode *inode, struct kstat *stat)
 }
 EXPORT_SYMBOL(generic_fill_statx_attr);
 
+/**
+ * generic_fill_statx_atomic_writes - Fill in the atomic writes statx attributes
+ * @stat:	Where to fill in the attribute flags
+ * @unit_min:	Minimum supported atomic write length
+ * @unit_max:	Maximum supported atomic write length
+ *
+ * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
+ * atomic write unit_min and unit_max values.
+ */
+void generic_fill_statx_atomic_writes(struct kstat *stat,
+				      unsigned int unit_min,
+				      unsigned int unit_max)
+{
+	/* Confirm that the request type is known */
+	stat->result_mask |= STATX_WRITE_ATOMIC;
+
+	/* Confirm that the file attribute type is known */
+	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+
+	if (unit_min) {
+		stat->atomic_write_unit_min = unit_min;
+		stat->atomic_write_unit_max = unit_max;
+		/* Initially only allow 1x segment */
+		stat->atomic_write_segments_max = 1;
+
+		/* Confirm atomic writes are actually supported */
+		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+	}
+}
+EXPORT_SYMBOL(generic_fill_statx_atomic_writes);
+
 /**
  * vfs_getattr_nosec - getattr without security checks
  * @path: file to get attributes from
@@ -259,13 +290,12 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
 
-	/* Handle STATX_DIOALIGN for block devices. */
-	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
-
-		if (S_ISBLK(inode->i_mode))
-			bdev_statx_dioalign(inode, stat);
-	}
+	/* If this is a block device inode, override the filesystem
+	 * attributes with the block device specific parameters
+	 * that need to be obtained from the bdev backing inode
+	 */
+	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
+		bdev_statx(path.dentry, stat, request_mask);
 
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
@@ -658,6 +688,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
+	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
+	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5490b988918..443f08239308 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1541,7 +1541,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
@@ -1559,7 +1559,8 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+static inline void bdev_statx(struct dentry *dentry, struct kstat *stat,
+				u32 request_mask)
 {
 }
 static inline void printk_all_partitions(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..c316c0a92fff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3164,6 +3164,9 @@ extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
+void generic_fill_statx_atomic_writes(struct kstat *stat,
+				      unsigned int unit_min,
+				      unsigned int unit_max);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..2c5e2b8c6559 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -53,6 +53,9 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u64		change_cookie;
+	u32		atomic_write_unit_min;
+	u32		atomic_write_unit_max;
+	u32		atomic_write_segments_max;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 2f2ee82d5517..c0e8e10d1de6 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -127,7 +127,12 @@ struct statx {
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u32	stx_atomic_write_unit_min;
+	__u32	stx_atomic_write_unit_max;
+	__u32   stx_atomic_write_segments_max;
+	__u32   __spare1;
+	/* 0xb0 */
+	__u64	__spare3[10];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -155,6 +160,7 @@ struct statx {
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+#define STATX_WRITE_ATOMIC	0x00008000U	/* Want/got atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -190,6 +196,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.31.1



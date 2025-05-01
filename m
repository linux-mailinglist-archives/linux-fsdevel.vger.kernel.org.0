Return-Path: <linux-fsdevel+bounces-47850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B1AA620A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E396C9E02CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629F22A819;
	Thu,  1 May 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZW2pkfg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wbrdn1wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BF229B1A;
	Thu,  1 May 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118869; cv=fail; b=DidChPjAmJKWwdjvuNTO7W9g7yUELDK/An3ROOlpWQkGptPi0ff119VB/PhKZVcnUx1a/PjOntrlkZKZA3+A36rHO9lQ89y7CzOnsjss1rGBqDziXdoOfqlNCsELn2YXKnINALje+kJKvJE3zGRn/lXISOESJkFdsrzKCu9gYJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118869; c=relaxed/simple;
	bh=bao8ro5jB2y+yAP3hljkJAZmi18dQqmKw3XotU1xy8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edrMd6jEOBkyWBb0sDWDVtSrVSWmC/2nMNuZL+oc5xZQIT2fEQIsTXNkmPR9Uwhxxa4DqTRaOlwR4aACx2nS8foth0MuMA7sGEk6W00lIXpCKEFIQJahSdxZx2LyoEV6VK7qfvnxcE5IUsZlMjHJpyG/FqSjc6AGx2HrDSGHYLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZW2pkfg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wbrdn1wk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk0YO028532;
	Thu, 1 May 2025 16:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=; b=
	AZW2pkfgXnzwNmE8iEg/dFGdyiPFpxJ/+6e9BbFJTn9NnLEVcuyKAZUUB4PcH6MT
	1PEUd/5Sme4qZkmqSsDnKlX8XtjSjNXWIJELsc33eh0PWuMzYZrk/KN3VmBIRTAO
	JyESMB8BOHViIaqlxnn3zsSy+vkU0Li+1cUFGC6ckYM9GMzX2L3aIjuYHV6K2N6r
	LX/dDXBNv6IqTXkO/ZCl9b9hhOOw8MnINY3sXDGPgO/+0QPUNl2n9yDgHtouIpDR
	9G8DajQak7m7njMFbRub4SDtE7lotW6D3ZbM7lt31DybeDeIJAyk+obCM2oeiImF
	DAOd2YUOcPmepoL418+RZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uckg21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GKbAg013815;
	Thu, 1 May 2025 16:58:35 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011029.outbound.protection.outlook.com [40.93.14.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcs6x1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4t+4kocCWYLXdfelfUbXgZeQAUPPpVPowJheRs+Y/NMAfl1kRFAZr6aEuEuuK3xUiyciZrVinOFPtbvMOpG0jrSkb/0wvHDiJWMWXMJvpBGXSmL4YQV3ub/IGV12vIFNR2Joam2x3O7Bhq7xgwAZTGBSlTxnytIOA7URJHuiZu2/SlytuHUhy9rIboReu3oOrcS3lxvs6fNVUWf5nCM0LY4MAAoic+IoL72Q8mj7rF9ti+8Cp9axcCJIIElmTYcWt+c0wO6ivpbS1RmTK5iKCB5t2O1Q1bwqhTTY3CIWZ4v/86WGEWHc+j3WWUh4PIyVH0ZCHjfH3vpp6RJkwEGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=;
 b=Wcyx06Upx2ofsOFltKLINSk7JBLbWgnwK3SJCbUkTHUirEyDJepRCE6L9fai0gimMJvxhxm83o/I2QeyRaw62Gpqv1DLXZHmQBU0TIkOQb1ojdeIA72M1olg2hACpkxUzxG8n9xA1xyg0Q1rccuF0MFiukeBchtkdpe1Q/HfLZZXiOm7e1TzVYhrbNPtnDNbNCcw0xdHXp2vtXhm3u/n09F7nqWC5024XCJk7mXNi9nAwe4JlBp1mkLBZrE5M0ML8Ye2qibNixBgJvto8sn+81ZJktIB/P1el0Y27BOwDyPazGmCX3Dda1UaBi25Ig4kxPdl6o1x14jI9lBEojZLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QDj8Rz5l/t++iluDX5lk+BX2LQlZEDF6iZSgvNbB6E=;
 b=wbrdn1wkOUg5uD0Wn1GrorGsJLRjTKD2pqx/+3oYqYp8ZskK0i25oZNaAfg1Pkngk1tXv08YZUM85nsR7c9D+oAEKLFCM+1axSxBR4weZTZTwyLueVF4o8TXfGg+rrC3nwW3jqVacym+t67mqCjjVtSdiTFJtyf2V1XjjG5p4DQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 07/15] xfs: refactor xfs_reflink_end_cow_extent()
Date: Thu,  1 May 2025 16:57:25 +0000
Message-Id: <20250501165733.1025207-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0318.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 7599e14b-4a13-4700-0eae-08dd88d1535f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zkHlRgeG5cplEYKCkMiXMztBMS8W1IVLEf43ZGgFnEOPw2CWFFacv9MxrNDE?=
 =?us-ascii?Q?sCxUAVCgZm1L30P743Is9zgx+puyHcjI9hwxvNz5INZJja9pTL21sTtO+U/c?=
 =?us-ascii?Q?P0dsQPvOKoRWUME/uYG4P9LtlY1QKPesus54DrLT8N2qnBSKbH/Afy7DhG1u?=
 =?us-ascii?Q?rOY9kalOcovKHaqYohmFrDmPh+cHGeelovIst+F2AHUZOSwQpn+bO7iMN+0M?=
 =?us-ascii?Q?pthYHJ+gd4rP2fH87rb3qmHi+BC2A5fKtRXCEztfH7oIWaFODuxKGYp94zbM?=
 =?us-ascii?Q?muFZLrjgxkP5snJOITU4Z/97GkHfSuIFQJt/F6fQybW4ZnN6X/NYcslOcdjt?=
 =?us-ascii?Q?tROkP1H7L2ZIl20zVn6ayaQAJyKioxSiQZSQ0p3WHye8XYYqTk6yLwNExO1W?=
 =?us-ascii?Q?0e7Bdnf/MXiq/xP+vpR1fLY+jKqFY366NkyAzHfKeTAB/9K23nm9UpLC35xo?=
 =?us-ascii?Q?qgSf2nI+2BvzjPErGnasCbD0GhrjpZxsivBMBm2zV96mfw8K9lq9PYPxTuDB?=
 =?us-ascii?Q?Aeu1ivhoNoyae7dOt1Hl0v7xeeNxF4OczFnCI82ERPRLB3z9VDJ/8uwQ3YER?=
 =?us-ascii?Q?bYK6rgqYcQFCtqMEHfPylS2p4zKBuWBQQR0+DHQ+sfacbrNB5XVg6Yd1oLr6?=
 =?us-ascii?Q?VPyoAs7l3ag5CPG7XGkNGdKefZckdNjmcg3RkWSaIJSLFQjVEbOkUF+7zVEa?=
 =?us-ascii?Q?Dzj2Q/HOrTiZDa+0RtWK0LS1S4ZzrG8rN+VS2DA+dXHyeiAlKGJV538/NUDl?=
 =?us-ascii?Q?m/lTRRFkct1OzGQ+FlEeLT/Mr5y1y1Xoe9ucgK+UvxEvQ0hL1lIdtltxFGdu?=
 =?us-ascii?Q?u+CPyhFAhRiZtP0f6IH1TnfqpOW5H93ZOxUW8vGoTaR4j7WgZspDg/Tf6Nfy?=
 =?us-ascii?Q?DkS9U4UVPEoiHVl9qNcsK8+E/Nz+PZxPb5KdcTA/wngK+SiPxQCzCPzsmjPB?=
 =?us-ascii?Q?Ac+HW0UTOKoAIx2gDB6oJ2PPXkkpQ42UuSvAxujy8pZ1PBnMXwNh4BDkZuXg?=
 =?us-ascii?Q?5YUtesQG7A3SFSGPbdEOhB/A30xhW2xh+op1x/+HwPtpCmWyLbBwBc7ni0ly?=
 =?us-ascii?Q?PhP9JNlScgiKbfTSYSJ8hOQH03o06G0Getoq8eNAWwBluK97ZmV3zU4iHBR4?=
 =?us-ascii?Q?NnfOTIUIM0plgPomR6R6VhFCAADfIFaPg2+zzsQdWrZHh5KpFVJW6x6L0Wtm?=
 =?us-ascii?Q?eIFImol1wzj87bD5sYXfPxqDihiTm1PWBdwXSKG6nFH84+aYSUCATaO4LPeG?=
 =?us-ascii?Q?thQySUnBSkbWJ4mOiQHxh8Eqi6AIwQNBGsanOHX6aPW2CmiNJVQ3t6pkSmsF?=
 =?us-ascii?Q?q07Tw41YBDyCW5eyXelC6pya3NsmHws7fTUIksozWsADxR2nJJPV1bagLV+4?=
 =?us-ascii?Q?IDm2rXP3WyuHoOfkpCwXblxsdTNEJYYKLzE9JPYoByaRx2thuMbnKvizw4rY?=
 =?us-ascii?Q?Juoer6fB9ig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4H1caVazdUwCZnMahUpydGdS52avoXc1LfHnwRWvPr7Br5jIOIwL718MCA01?=
 =?us-ascii?Q?Yo4LgnOmovdFcd34MqHE1NIbf0X7+y/0mXfNrVIPxcXKXcEL+755Nc2Rw9na?=
 =?us-ascii?Q?FTdM2d8xtge8xlxPOHEAnTg2IPOU0/YMfR66EcK0wj7nOML3UdyGs3TbAcEc?=
 =?us-ascii?Q?DdATWXK3is0NYE5K0ybXim2h4QMfL+2N0s778pYQgEndtv4HV+aduQtYYV6G?=
 =?us-ascii?Q?MFcQA1+MLbrQUYrE1RCH826rXRXpNY47ViBPKPpxjEMvw/VJPfndATUylUla?=
 =?us-ascii?Q?4UGA0I7GSP1OebuQPJ2jMZVZcoxVl9uCku6iIOohX2SySrsbwaqfWM5AJxW1?=
 =?us-ascii?Q?pWtmxCTxOa7YREIiuSNhGt4NcVpXMWZniTvGJWWLBhmJo0/QrV7RgTOQqCdm?=
 =?us-ascii?Q?SWCsilnIki1U4llFhTIM+7uoRZk4zIkawMckGb44jk5SfGnDgXCDpcZQzfD7?=
 =?us-ascii?Q?sUE98zdAG7KEdWtGvLDFZsmQkEotUMcNa0CB7KyHfG/UFe0j6qEwmqaPyCqt?=
 =?us-ascii?Q?WntOWIgEoR5NkbRaw9yA+TVdz5Y2++U42acwMYMrOVOfxnOGFcWqgB7iU9V3?=
 =?us-ascii?Q?4DDOqJAazxmuCnOABMyOS5NV/7zKRQY0ldxrAEt1gHgMlY7YE/om9P0T2VLC?=
 =?us-ascii?Q?RoLq6hg+rn2S7eGkPFayYwmADMfs7VtL6SvEv4uVpnaM5RbET6DT0WDjZvYg?=
 =?us-ascii?Q?IaIya/raibgCDw5aZ+MblSk3qUiFXJ1UhMt+OVz/ErBTG73f5QBiuMDFg5I8?=
 =?us-ascii?Q?ozDsgOqOPoI/BuYwCgjjsuDL61RqrH0LoN1ZzlIFDxEbuY7jOf2mxszayvTQ?=
 =?us-ascii?Q?pYuQaOH7PN0sY/5fwvecD9ft6DndoMorrIFLpKPypYTHNawybfCZ/O/PjROH?=
 =?us-ascii?Q?qFFfZrrRX5mLFRxPAKBj9C9W0u21fS9fzdQgCzUxV2Lx8RUUkMN3PTnwHSCf?=
 =?us-ascii?Q?CoJP4w0jKyOV7njPJ/PXyP48mqwvXOdiKhc6ey9o1ORLv+nbEcDTx3128nFZ?=
 =?us-ascii?Q?5+BiZxs55PlUoW/EX9KDGgd0DK5c816p61/MuWwjweUXDGqFLfAki+u+N+C3?=
 =?us-ascii?Q?KaJf8LKhK5a0C508L3os1SH5QOhQC31DculQcSd2llWCz32ueen3istyguZ4?=
 =?us-ascii?Q?jWGZA90i1n058vbgb/RtIap/qdZf+EEpmQnq9nk6JhgYRVsmnDhC9qd9mJvL?=
 =?us-ascii?Q?g60iZh+w/Xz/XM3rgquMW5cwSAoNv2+stlLOoVKhmpAITLexq8mBMqaFyJc9?=
 =?us-ascii?Q?THpu1oABo99ZnNoOBOdLxafS9ga0UMGw7gquwsF+pUhh/+AJNVTduOcEJTmi?=
 =?us-ascii?Q?+kMNzCyCw1gm3xmhL44h6hl5ciaZgmY+WrpCl25yWyEQXG0ZMBtQD31yVibm?=
 =?us-ascii?Q?f18Ss40TR5l9cClwK/BfJBPYnyzdhipg7CbZm8q1ZsfyMWsRnsEE3bT1MT3y?=
 =?us-ascii?Q?zpUT84gg+13HF/amYXlrYcijPwU5+nwBCEUQYLe95XxQWWbFxMC3vU4s1Rbf?=
 =?us-ascii?Q?kY8uYlWXidI8hssINEGemqrBcZ1aKgKTNqKn4nw7uerXV+bZQKjLUNEAJARv?=
 =?us-ascii?Q?8udnePJVSDKU0vYCiWQHyqa09FKOnXt7cY+GML0ukynfC1LVK8A+LuiNCctB?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QDdJpCSxzxZJZBm2D5vA5zaeh32Ndp9D053ciS0YYA9FJ9vgICywziQht8zHB1w2lQrROf9Nok+0UEPH2d1MyfGL+aj/AoSsyvn+7DqeynXcFprszbgOYMs+7erfMQqxZFQ3jrP0rWrjFDgPWQe1VW+t7CfCKi3O4twUrABC1/nde7hp6vNUmQawqeo9nnY76l+AcG3PLqU5z6t0P2xA7uPZyF/kI8ZBzAgvlhbwG6bvFs3ynOSNUQbDIQvJm6AgiMHSYhfF3HwEwbo2WE1t7qGolnaQOLP29uVDOnIlbJaEFmMigbyPhhyrUhf7eIzoRwqhSb7o6pI164vPQT+Cy7ndKdzPUiFx0020SGzG/SNNbFcjZhO0gCYACnUASSav+GJfhCWmiIeKm9aYKLE+wPfxGq/ZytYLC5rT4TdlgsiuecezInDQzYHRXdlpnJWttzSYNXvJy52ZXcuz8wBBuCro1jYwJZ+kxTRO4BYj+aSy9zaNPPLWUaGtCvple+kFloWKc3Ud/J84ok20KS3/qJ42Lc0ZzUYCS0h/SdK834ykuvumac4un+OP5wZksQQa6mE93sZ7Eh+68Vs17c0Ry1+KR4G0g2YrEa4WO8btfDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7599e14b-4a13-4700-0eae-08dd88d1535f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:58.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7PeLcZouR+zo3S2sf/R3G8sIYpDGBQVL784GmKIgywrMRYX2nW15qJ4i47GO2S2JGXc3+llVQlyfsITzgGiOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010129
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=6813a83c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zPHwHgG4P_mrsmFPOIUA:9
X-Proofpoint-ORIG-GUID: YaX2B70ZAK4L0ONA-iSLXlJualF8UYKc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX9gr+DjsZQ640 ufUbK1E89fd/BAkFuFh2cS5KGuuo7lxxyiq2EKYdGiv6ApTR6thNHQYAtfFWCDgl6YOXHPOCxYe sWDiThsPiaEyshLdyRsgGvjMMWl4DYvZ3c6gLFa2w6gOLIv74Rh57Gg/jApAa+a6/jgypOpOQyR
 JrubmTpmJhgC9jRcDb0qwFPJahPuglBfiYEabuXoMJQ9e1hQEzfncFtfNYPaoks0D8O0EywVkk9 9d01IMDoQssen2Ko3Bn3RwZ+1ah7/yPAezfyy14BJM8CXqd2gY4lhOsHxCeZXWQI8DUvymEqD6A ExAu6+YE8pOg4sRT/EMMn1TM06313/y2zNw9Ls+HSNP00M0WlgqiHzwpw+PARN259HHaPP6qbEw
 bhuLOrjGoOfynowF5emqYZ9S2toXPCv7wmwpEfYmtVKl7c/3uWjF7W8jXUR2T3T6GLq+h7vT
X-Proofpoint-GUID: YaX2B70ZAK4L0ONA-iSLXlJualF8UYKc

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 72 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..bd711c5bb6bb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -786,35 +786,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -823,7 +807,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -837,7 +821,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -846,14 +830,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -882,7 +866,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -899,17 +883,45 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1



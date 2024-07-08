Return-Path: <linux-fsdevel+bounces-23279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEE492A167
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93756282F74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4A48005B;
	Mon,  8 Jul 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oN54VI2k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ml9ASv9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6797404B;
	Mon,  8 Jul 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438975; cv=fail; b=iAo5ccCr7rom99eIhrMyojHFkT16+DfbMYWYRH9EF8DLcAgmSdNo9ANadXAJ5rFSxgohb9/8LzZuz27M9Xbc2Oc2TLxRvPn0Z5QrwsmsqvlnDdrrYKJl83XnHcCcf/pXIDiemNaAWivbXZ6gT7ENZeftib/CGyb3uichOFW+zPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438975; c=relaxed/simple;
	bh=jXxV3IicEyPv504WFOBbh1WYmaWWH3HGBHpniktyjP4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SJg2mBVZq75119j3zTgZ0ikb/GRonQcfe5ySZuoPRj4VX6jrNhecnHsOb3IlBhc80vUsgEV1Vo2OErRYBazmuKy9/BF484Mj9q3daE2dUHzRegj5c0O63OxpFvnHLINxike8n9CRHlhov0stTbzuXEnnqQP1tCx510X7ue2qURM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oN54VI2k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ml9ASv9Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fWKf018091;
	Mon, 8 Jul 2024 11:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=Ldv77hVjWDLBxs
	99754OGFhZEWxYqCqskZ7AdV8IuAI=; b=oN54VI2kcBdkR+D8Dl0ymU8TQBRM7a
	E+pGRhn17+UdxtApWFpGTegCAW6N4nvdZ1mdwxlBI0bbZ7c5bX4TEDT+ZGZwYjHP
	JYQG9tmPbqsXnXx/ZmuaKx3aPYaqqzivXR2MLo7TI9uxUJSVAkbecR9gzMuN2Ycx
	knmyf5ZbnueMlm1wcl7r//zSvgKGqsYJ2kUjqpPz3tvEyaOUeXk+KpcZyDt1Y7tU
	rreTH5RsO58oud6zWSEJcStI0Fd2xu+eoqTa8kprewCnZ+Y85kZPNDq8upYQprKq
	CCOW0jfoq/CF/dFCwrb/S4siNh3JfwELOFKLWf4jjjgz5n9HH4+0x/xQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsstca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BRc22004521;
	Mon, 8 Jul 2024 11:42:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvc13wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYleOzFM80SQsewXQLtwWik/ur7jPUBizjr6Bpxu/LdJruOpuIHTHAz5PkzT8nfhUrfnYOaM12Dp4vqZNAnuZ+gJlylaQQpeEV/1RMx72GXb5IBE4rivNgSFxV0MWUnA0ZIJDLwFO7thpATw2iEBDN75kTxeaq1cwNedgstp2FUCm0yqklgUw9GHGMZjwXhmCYB6c+ezToQ9fEEpfMPbDZSJkQkREcvC6J8R3tzKxtigPboUwpSLAMz+KhTfGcZ4kJSM6hbhITu4YFeTC/B/eEmHOQJ/65DnGsLUUUDz7DrP20VTbMmyebZrhmB0kmlbMJ+UigaoKi9kbihDjhW4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldv77hVjWDLBxs99754OGFhZEWxYqCqskZ7AdV8IuAI=;
 b=OhJ/xObc+xfPMa0Izc83dYIN3IE811M+TWoeNhDC9R7px1gt9UTqIUKeeT9it4A1KpGTd7r3xI6cP+PWU9o515lKbc9zIBwvn7C4c3x1LZ5Flvm/q0gA/Vgi2oU8iDDoXE0PuYOeXuxVx2K5i9GWGKn0+48aF3FUxc4JJu1HOinOCwQJDKL+aZ/DfT7/JvfzCCBbr0Y5S/YyBH7LVfIY+nQZzzYhfPCXudSmVsy8tBVLZtQoSKfxOCaOKnIvBx/v7wVhLdz0wBsR1bEryNXDVD2JTaMRz9tFpEX0fBRmRMSMQRTiMw1gLzgaHnLAF8+Rj0NcBVBhiU7kBbUvEgp1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldv77hVjWDLBxs99754OGFhZEWxYqCqskZ7AdV8IuAI=;
 b=ml9ASv9Z7tuHs7Oi5B5WnDC1EKJe05Zohc6A8GdQQulGxtO5s8aQkkY+v17c2LU5WfVIdBR6Bxayz4G5hqOIdZlb+cIM31Rb6ubOMFN/jP0p1d/09l4rW7N16cLqDFU7QlpA7YMiJjoB62BM7JzCjHdmBUqY1ecaUVgXpsPt1/s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 11:42:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:42:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 0/3] man2: Document RWF_ATOMIC
Date: Mon,  8 Jul 2024 11:42:24 +0000
Message-Id: <20240708114227.211195-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9b9e0b-e675-43f6-3457-08dc9f431320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tzn6MBuXcbmWFHD4LQnvyQOT5RDnRzppIeU4lSHFUP8K/Ag44SYsCMNooE6m?=
 =?us-ascii?Q?sIDgV2IHL0+Zq/gFy5aWqBR9TPtH9l6ZoJqLmvscFmohT8FGhn64cnGQHQ06?=
 =?us-ascii?Q?8Svj38/0yHy6T8+crZPebwkwAojp79uDDrzfQ9VdBM1gOYhSpsz11PvXc0sy?=
 =?us-ascii?Q?KN8TK7n4HZ2CdhS4sa9UsX0lsx7p0J01XQ6cdtSaGKQb0WJ2JBPyR5ZMl9K3?=
 =?us-ascii?Q?EpoFGGAGoSjQ6t9kdTNAUX1aksBWN01PX886Digymi4n5rdYxIbxW3e0cUvL?=
 =?us-ascii?Q?doiyEVVlrGMyvy6f4bzo24AKSi7jJHcWblj+UTFCVaKRqE8q8z+9H6IMl/oH?=
 =?us-ascii?Q?i4YBsd4deC6TJcung9RLvcuadvUbicuC7A9IUBVZz+tBmqqvNKjiFmTiTI1J?=
 =?us-ascii?Q?SDPuPHfhAJYOeQ5r0EmO6voG9UGoStKLZiEIJPLiM3i9/aUZEq00PsjHj6C1?=
 =?us-ascii?Q?sEYNwBwSEJ+Iv9t7xWy2OtejkuWXaXbLoNTbucHwW1sIKd3zQCVhjwQ6gNGR?=
 =?us-ascii?Q?cFnR44kZLCITSmri+jW5JLau8kzXRRHyolsu5qzQDdoMxQDJX20HOaWY6OVJ?=
 =?us-ascii?Q?TLX7e68cCIJVvyG7oZTIeTbD3Wlp9y2sNr2fKnH7b+zb4HEUdSdx0mV7VQ4e?=
 =?us-ascii?Q?69GfGjDUX9FgMcMXcECKdfwCIGLNEV3hcnE4HTZic7Q6MSlp5gLX7M+3j2Ln?=
 =?us-ascii?Q?dlAcJ37JG82cNZVG286Y/OpGAGQN/hFl3FSWpNzTI22SJb7r6ZscMHO+7dhf?=
 =?us-ascii?Q?u93UydzKA2zapm3KZP4i3LGLMgeDCyNcUdfrPLOb4DYK+1lgyfI8+LShMJb1?=
 =?us-ascii?Q?t0is+ZJmF4E1kmZ/8wUe7hyppNV2QvBrfwUhVi7uB0m2X3ZhB6mjQY86pVD6?=
 =?us-ascii?Q?qHWjrHQF861SQbbMC/SV6D4Un9QSAc86Ci4XTQ6SgLzrCwJqX2m80Jx3SwPK?=
 =?us-ascii?Q?ULz4PzbKeVfCUTYQhVpunN+4dCw8Ju/6pHBcSljiYwqC6C5OxBej4ZGZkrnx?=
 =?us-ascii?Q?TIrkwJRKZ7zNB+NVSitKbA1ZGxD0I4/dwVN0ccQ1A6n5+6DAi7Wvo1lw8NnN?=
 =?us-ascii?Q?nvBInmljx69HJoJ5NPGvxftX2pK7j1jL7Fje41XhJFZaMU12lwiLzt5Jt8rv?=
 =?us-ascii?Q?vpatcmixPlx5YjYZOrliFOQvx7m3k5ox3BGf6Oeo6PYEXaMAmQEC7itlo1pw?=
 =?us-ascii?Q?KVHHJ/JBM648Zoy6HUwxTvxwSTZ55JXVr+aZNyJQa6eacdth9VEOLFwSVZsw?=
 =?us-ascii?Q?i56DWxUZu4nRJuxhgtNL2TPMoSyWyRDXv+KiwYLeicT2LE/u+GU3FCsQnP2D?=
 =?us-ascii?Q?zHI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aakT9OQSJKaDRRI7E1H3INpYWtZpnIphNSN++dEFDCuI4AM+f2Yx0SvkPyu6?=
 =?us-ascii?Q?42YnuMAm5GKfmu3TY/Reh/1pcM4B9ziyezb7Gca8GoX/Y24IWcr22T4hoPpW?=
 =?us-ascii?Q?NgRQW8LdAh74zSGFSS1yv5onKAZFDISmR1UoUiV03EK0zRwHqju8Pe/zzEOw?=
 =?us-ascii?Q?dbqXf7KPCA3QApRLNxp+lLjmmYZ81vVYC887GBMyiFOTazQrbvXsESpQBRDQ?=
 =?us-ascii?Q?nEaWrkrNTWB0MicDbzhGStU0q5nqRkL/KmUQ4yBBpWCGqmjMzGuS+YQZKkm0?=
 =?us-ascii?Q?LZSASRE6xNoi81T7HOuRLH3hnJzoYgprRkOWjT/DwbV6s7X+kil0yvxcTPLm?=
 =?us-ascii?Q?97aohVLbPiBqY7PXe2M0Ff9CB9MxexlhuB/S4h/VdQ4U9EQqSOhK7QIuhNCg?=
 =?us-ascii?Q?KHAf6KnZuJXsHaWcZDQD9g+5XRXQYy8FIP8i1oLzCkY9jBs3/wmU+pv7ff/I?=
 =?us-ascii?Q?PY0zNRCWOFEotNzBVbPrYUEVRV24c6/KUmhLrET6sknJiY6p16N4h0hkinuZ?=
 =?us-ascii?Q?es7rZjPjAsYk0WaFm+8zDoLCHsXx+92N0fsDDd2Z/7CT4OIbbz2uP2HvgluD?=
 =?us-ascii?Q?tfZ9Gn5973x9vsz/Cgpgy0n3QHjtQ8ButgCk4nN/ghiDr2v6JWkvbA2cgi/h?=
 =?us-ascii?Q?Qz21wahg3x31kx0Zfdip3Rv9LZLIHCroqqgWcCzLVcDC4Vt+yAypcU7f6b18?=
 =?us-ascii?Q?0MNfbJJMuDsl1bjgs/+EyRR+yjPxw+4/UXD5qGkdybUIM+HqhzwjFpF2VHk3?=
 =?us-ascii?Q?PwA3GVsaee4fryB0qq9ZU35uWRsWwIfxlYsX5tLO7+vm+i2KznbMMrneXuYk?=
 =?us-ascii?Q?5yVBKQmpSygo7Oanj4sja7NEN+Hf+LtP0GsO1PvOTJoOVF82O+jjNl4e8FJ9?=
 =?us-ascii?Q?iSm/KMfgL6FtSHvqjFX70mwzSYWqi0AD3RmqAAKnUDCOdc/tYwaV6tO1haPG?=
 =?us-ascii?Q?fzS+EijlXdT11XA5hLDxspBpKO0CJsJOpdS7yzRE5K+rSBT2KUQvKEGD+G5C?=
 =?us-ascii?Q?bHlnw8eOcaECSDmRjEXaTZMDc7gZSX+ejueU0Z8AVY7Q6aLgSchAj+wks41y?=
 =?us-ascii?Q?9QBQMFmWk8cPFthpIdc1dBO6tCBjXp8dDadqCOnPGAkUhVCy2gPR0y9nZQZo?=
 =?us-ascii?Q?C3qlAuO0d7m61SkLDdIvPCMLE1naWqKfdTgPOxYsJSao735r7cEj9fwmWfJL?=
 =?us-ascii?Q?uKrKmfghcQMQ6or+np3Itrda+jyQP7VbKMHobwXZzZvpSuDYrAVy1P65OAQz?=
 =?us-ascii?Q?7wLNA+U8rQ0B0JcGlcwak1Lnepk33Hx1+0c1YxwivXe228soe73aQxhg6N3Y?=
 =?us-ascii?Q?AuaQ712DX8VwINwNWfLIh9d6aAykwpwFxJ+dJlpnxnYuwwGrLi8XlKWBVbEn?=
 =?us-ascii?Q?eBRVRXb4Yn774+F1fLPWxEnIFhiMDWNDjpHYtcdSVGxj0QnP10SWgoJZZupI?=
 =?us-ascii?Q?hVTyf0vw2t3IMYYgWGHlR0OLcs6Mdt0C4Ucn/N1eT1af+U0g6sEYrXfz+8iV?=
 =?us-ascii?Q?r32KxtJ9NDMBdc9i0EndrFc7V0TCiFwpMM8CNctrkQS0jRMQJG1h4Ht3cDcV?=
 =?us-ascii?Q?HEKCoeHM2NzbVYvB0zRLlNRXcqbFJ/IjME+Nyjyf4ce6r0CuunE6vx0lZorg?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EvMcCbXhn7AuxPfsgaJMyIvQ1Dd/pNckuWW8AZXbwQjleT1sn2qB54+mSIyCaD+thxg3Ygf/Ue4oTBySYj3oBtykU+pSUkM6wD4s6Y0ttOFf3KI1frhklVRQenX+D0B/C/j7eIpUk7GV07ei6SfNxRJD6Bj0FzmNzbnKT9zshh7ZJZIBw+8riUeuvlxTN58iYNG9vKhdYUdm2DFQWQMO0mGlwq97UwcBDHdI6rdmH8PYAmiApB9cASjrW/OIHsklwZM3cQDJOcSFx0x49Jrnmpk0ybtuZHDz8MkgLH13HMiYa4B/Li2/xnng5LjDo1rUv6/wuyqP//uDICf/HZGa14PJLk1diKCcrpQv3Z3/FTfVH80Z3RveMMH8LxwJRGQhFTZBJhetDCdztKlgbiFd4VPrRr6cn5/p/k/jNXFXlsgjn+80FZWJlBTgKwOWOFR9kcyeXhK+1bhAmhvvah2PP/xhVnpTs8LOsItGD+krT7zb5Cje6doKVliXN8uHesQp3u5qpYbovS0b8r3O+FwrH8ll6+C3YG8mT+g1Q9Y4hTOh7jdc9RRVIrz1rLNehInPlfQagG2vyCN6iGozhHulF3blnyZMRetp4zfId9VgYlk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9b9e0b-e675-43f6-3457-08dc9f431320
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 11:42:41.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1FLAtKNMhRHFC/2gqmTSw4jtiEO4IgVlWEuLYptQ//f3OjIKx5afFzJ0qgi7SmLeWfQsb3asIECOY1lkomtSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080089
X-Proofpoint-GUID: 5tFEBacqHeiqM6BFYHPHKr0bc1U7pS_0
X-Proofpoint-ORIG-GUID: 5tFEBacqHeiqM6BFYHPHKr0bc1U7pS_0

Document RWF_ATOMIC flag for pwritev2().

RWF_ATOMIC atomic is used for enabling torn-write protection.

We use RWF_ATOMIC as this is legacy name for similar feature proposed in
the past.

Kernel support has now been queued in
https://lore.kernel.org/linux-block/20240620125359.2684798-1-john.g.garry@oracle.com/

Differences to v2:
- rebase

Differences to v1:
- Add statx max segments param
- Expand readv.2 description
- Document EINVAL

Himanshu Madhani (2):
  statx.2: Document STATX_WRITE_ATOMIC
  readv.2: Document RWF_ATOMIC flag

John Garry (1):
  io_submit.2: Document RWF_ATOMIC

 man/man2/io_submit.2 | 17 +++++++++++
 man/man2/readv.2     | 73 +++++++++++++++++++++++++++++++++++++++++++-
 man/man2/statx.2     | 29 ++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)

-- 
2.31.1



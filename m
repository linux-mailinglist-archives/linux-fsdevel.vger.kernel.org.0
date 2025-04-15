Return-Path: <linux-fsdevel+bounces-46480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A3A89DBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 14:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592A3176B31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C072BCF70;
	Tue, 15 Apr 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jZfad1If";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nQigCMFS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B902951AA;
	Tue, 15 Apr 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719436; cv=fail; b=L1bRYnByG0f3B1Z7gNHwuhhs9Nu32o5ADp9cqWEiZ9htKisR8FyhAQYizutGJ1HoGUIZXcrCOfhNx0RYIN7Pp3Lgf42mvocRU6+0joxy7/o5m597ez3qQIi2Cg7FRl6Y8jMfmf4XAhgISIljKRp+UaaTgN4myO788U04HB3xA5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719436; c=relaxed/simple;
	bh=zBQfneQEn9MLPLkN0UENksfgp5YgjItqdq3BwiLZj00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9LIWRKSS8ZyrmZHjz64jxV78j9VGXAj4y4vVpShX/xCcpZkC5ex0ur2YdnEx1X0Tu9z3/wHfHNmh6BDJUroLmm02wRVwLO0fS/elpQ1m9dRfxUxyPXTjdzW8luqxc29zgWjZtR4fW8jNrtaZNIAkuo7T2tPOcVd3pmPNaWgCjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jZfad1If; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nQigCMFS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6fnpr004641;
	Tue, 15 Apr 2025 12:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LltWOGl6SlVjEa7vYqIEd6MsnjZZquN5aMr1VPeFob0=; b=
	jZfad1If1CI0D6vi4MtgbGHc+YF80+Bzb/w0k4LyBlZ1QRu9sC2py9/wVwhDt9Tf
	GX0Ogoe8dyQmVkJOH8jIS2Prm7SKAZmuQ8GS9lCrvLm/uT+GWvQddwMY9jInnSr2
	urpkp6vq5bf9tk320BYtNQnwOev7rZvwpVmR+dg+cVurMEQOgMOQVSDNu8pcohMt
	ODW1fz5HRThmnSXHaWiQRpQyv4CpBy0nNbByJYQfIB3j6FqKOH+PUyA469//66ZR
	wKMrtz9tcEIErmbccynSnLiEQz/EqVq5Xkzcysng7R+w516x57Ui9qOS1DnIBtjY
	uDxu02WU6Y8B1wp6KcHVbg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180w9j50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:15:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FC0hr0005663;
	Tue, 15 Apr 2025 12:15:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5v5p17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:15:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjfYxOBI45jrosCN/M2WCzg63fC8Ih6ez07+ZaZf0MfYwv4+8JPFY9MrsJdxcAOvbWqOnXB/GPiCW2t2Pm4Zz4QoVGZqn6NToRSflYVgtDqv2zuXPtR5+pIh3Md+eWNZR6jXl1TgY0uz5PhJNMe0OwJcjPMIZ5uV2+uRwB7SEIsVeuSd1vKvkBz/2FPeIQtVsFLfrdu3vuRyIfk7xyLOcfvN/LQGdFXm1ipAJZNwh5LliM6+G2yGJYfugNO/x4Epd42yL1Vmc5wzmz5Ct/jO6OwAaRxWMiylEA2aS01xq6N15DSZLV324sByJ8LV5g0XzfKvhULjRxDFprIikiapuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LltWOGl6SlVjEa7vYqIEd6MsnjZZquN5aMr1VPeFob0=;
 b=RBMN9YagA0XUTbxpUQrLpJaDh8DpOk6OssXxA26YCymD/wzDl1eNqQ+X36BwP8F9akBAr6ajgvZLg6iR6pHa2wPxJOOYaFUsTyN3vbh+Y4RAJSrcd5Ff91yTzf8yOTdWwlxVvARuPhbyPbQMF0iA7ADoeLOi8U3jkQ+B4IbOSZZbt4qiytfnsmhVLB417EiD3F6ZVX2iUwwLVMQnrGLY3XWT33XImSh1zB1fitCKoIFVbp6XIQBmD0NUdJbVf4laxpFXjQbfZcAT2afhn9N4lZy+z7wseJof3SjKd90oORFNENgG3GGqOBLBlpP4w10pohkWo0xrf9mtWPqfsvaV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LltWOGl6SlVjEa7vYqIEd6MsnjZZquN5aMr1VPeFob0=;
 b=nQigCMFSqUUN8OtoUbI0wuTv56XSoXvlRlWjxoTUjpmD54X8iEoVArCLGXxmtpXKTkrAhC5BfqL0sjgPd4hNcikTud77gV56dloEDJnGIPYe4TGMeF3mjDGuSzfcj9lkueaAQTGbVWAZwbaJ9oJ4oHTASWw283YRoBj2xfxIqV8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 12:14:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 12:14:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 12/14] xfs: add xfs_compute_atomic_write_unit_max()
Date: Tue, 15 Apr 2025 12:14:23 +0000
Message-Id: <20250415121425.4146847-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250415121425.4146847-1-john.g.garry@oracle.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN7PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:408:20::43) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e49d2c-4291-4d31-b62b-08dd7c172255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JNjlVOOHKVJwozqI82kEJd85YTHORcdmXKfjT8CbeJI67mjomc5vX5+YmLOo?=
 =?us-ascii?Q?6z8hv5nDmjWvwiRKeeF3Vr2WKXlYbNx4OrLQMZKif6QR3y436whTI1Ux9t4x?=
 =?us-ascii?Q?3Fg4WeEgzZaJB8h5oAx2WpvzW9zevowjw29Kx15PHEN/m7ltcDsWDgrFEiyn?=
 =?us-ascii?Q?UZg9TRbLcn6d3ArSXpBuPlle70TgOZS3KhVzQNs+0nI2IGmsO0jybYOmtirz?=
 =?us-ascii?Q?sQ8JVLRDchhcgcDlK8YRHQ1o10K2DUiaeZ7fe7wuevx7xY2U2yH699EQElBU?=
 =?us-ascii?Q?E1u1MGFr/OerGfO13BnBHAFUJ0s9QRHop6PFfRulV7OPSb2koT3ZEaVd6Kww?=
 =?us-ascii?Q?HqT00c/nM1uZLYYJB1GEpPcGqDrOmaMFnPauzHhx89RdXfvHESF7cICnNiBk?=
 =?us-ascii?Q?XgCQaXCySY2M//qSZItkK5wSsAH/rx1Hh62cBXwpTpSc37wYdNS1u0qP01/T?=
 =?us-ascii?Q?DzrIKtkxKUbJ1I8/yytJJwpVO1uWvBCA63yfIhsE3yXwwwPNWW2d7eJApQB1?=
 =?us-ascii?Q?CIAicMfFx+o20g1ijPWoK4YZQdEbT8oaXtF7sH2Jq1nFvXq1hoCjA6slFyV4?=
 =?us-ascii?Q?opB/MPNY8F5dqg7w3V3/i9CWVBRKECshFcDXY5aMXapTy5W7Q7DT2quEtsoJ?=
 =?us-ascii?Q?PxPaKii0Px/fSiM9yN3UBa5tqnvYYzZ/NDwuVe19oEskvvvxIo0fwHfJEYk6?=
 =?us-ascii?Q?BwOFzw1DhAHC2TZGHLFX1BAh0bmsjps+Ga9qO8aBU+vTQODc8RT/m4fYDCDV?=
 =?us-ascii?Q?9tAyAUuzDveQV7LWOoE1ALAgmTcZ8sbBj5OZnGLevxzxUfLyCxcpf/RX5mZu?=
 =?us-ascii?Q?BTcSbAocGqzNwBUTBzXfQ3gygrxii1hiEHYi9Hc/AG+OlPAsP3O8n4PFyvZ/?=
 =?us-ascii?Q?R6hkFuK8Bc7sTDz2Em1fSR0g3ezWOLsciYduNUReo//zRb7d+bbDmzwhn184?=
 =?us-ascii?Q?KhAaIYWg+COw5q/fARFC4TCFiFTEIO84dAC+DsQdk2hYr5xJ/K53aueK5Y4m?=
 =?us-ascii?Q?s4M7/KtYxfS1dCJTu/rG/6y2ENakACPz2n7ezK2UiE0ydESvEZNk/1fWGPlk?=
 =?us-ascii?Q?o05yKeMu5O9gp6rSMAE26fPRcvEhZrcPFeqDxu83VwRa/+CqdNIU01i9JZ2U?=
 =?us-ascii?Q?VsMhfrjunhVkan+kC29/BykzrrppuLiyTTpc1VTXBJYEC8iR7WNMAz/6H1Z9?=
 =?us-ascii?Q?bf1PrkXnJ5X2foa+2EC8gqkwLhra6mgF236MGLL08e033C8fMCBskCIMGQ7j?=
 =?us-ascii?Q?ZNP6+h20khCuGvqe33sXYWJ63titEn2+wjJk+Ua+luZ7GjTOlbjiwVoDwoQe?=
 =?us-ascii?Q?2ihlWfNUh2+Kyny3U3ZoIYXiPPbVGgi0tzfugr3ww5gcn4ogDlXl/mvRILPK?=
 =?us-ascii?Q?vwhkWzXJh5waTrh8IEfGRKzKB/QN4sf0QpnmoznEYcCDfE3ihvXHVsmP+RP3?=
 =?us-ascii?Q?JaBn4Q99/Pc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EasITj/hZXlFsap7CdOCV3+qmlQZcsQ01LC6lJf2gQh+D7MUkQa1MiEZYU6Q?=
 =?us-ascii?Q?+mIlBF4r5JagYqe0aLxs/w5p4mOJ1ciTfjTXtto9R6IGJGjfiYryzJJ3qsfu?=
 =?us-ascii?Q?WXnrm5F6faWpN3o64Qpu1IVr7uYHwHXjPuARup9WG/Ot51DxIZmMdItTHZKj?=
 =?us-ascii?Q?W+wD/jQ3y69HAP4bC7nWEElzvoG5g7ajPONNpkTRNoZxD23vz/ZgiIs+SW3L?=
 =?us-ascii?Q?KvyMppIIom8yMXCmJsM75L6a6q7l93138tk7gCFtUlbAHUf704Em0lNs3O52?=
 =?us-ascii?Q?dxLnnUWikNnTgdVuYPzfOx2fhYOrpLmJKXQvM6CaOOTwR2bOmPnAiXWrwJ6U?=
 =?us-ascii?Q?BU+vdJrEF03eXVv01RondpguE2/A30nv8kl2OsnFhGuiX8eJVjXO9uKLQpol?=
 =?us-ascii?Q?98+3cFjI923j8PRmLBijjRhiqg8A3ny8UmpmoRSoie3Xz23zYTHYXJIE/axp?=
 =?us-ascii?Q?ZCwUzaL7NatNJOQq9MAv3EX4AnvPD20ybZuOZ3q0Rw1M7tVYYuX7L8atIqU+?=
 =?us-ascii?Q?WD57CQSN4vL/LwDrX2dfM1NRVik3AVntJjgUplMCoD7cy9IOkAL0uAYg8QsT?=
 =?us-ascii?Q?UlHaJREB8C/CTkLRW+cTUJIs1oU+O6k+KhEJ0AD11WRJWoxjT49zNVJRpXZP?=
 =?us-ascii?Q?uj8v4LJzp7/uyaq2qmV+g4HeFmbGXCtggebcJ5MT5kvg7akMI7zYrhaVJP+e?=
 =?us-ascii?Q?fSo3/BfB+B6alqPIGws9wMySLFvG4FISnSBVxDsKZemhEx2dXytrl249TDBW?=
 =?us-ascii?Q?/Xl2w2EnhCgUGlm09ueeFbqQNnTn+yKzanADatXHseoOcC9mBo2+GB+s5qHu?=
 =?us-ascii?Q?BGcS1lscgRHficu4ti5+GEwa4en3QWgrG+v2JuUW+vXHcssJttU26QYLAbP9?=
 =?us-ascii?Q?A/45ND7XhRPfM4u7lRTWlSuM2VGdZBqfk9Mp5cUSSIBpNGzPMV6cEP6lhPKJ?=
 =?us-ascii?Q?XXIHEfwRKCXbXDULcIXv7YOe+Q0+pjAWa3IHJh67ZLSlwamQpdpuG/Nbn6iS?=
 =?us-ascii?Q?vuXGKu1auwlSRJyKsL0m/oRaj59Cz9k4azJR9g236hmIZIzADUo6TR2B7v0Y?=
 =?us-ascii?Q?nu82oMog4FsvoY7q/JpR1hSbWEGfw3/nUs4LfC+yOLTmRy4fbWTjLNbS3uB5?=
 =?us-ascii?Q?VENo2JQgSahxgEIRvdhZP3XDu+2rG5QntkR8+zIw7ftSHhRIfWLWqNjkPaIt?=
 =?us-ascii?Q?Y9IjaS8QEhCq5HesedI24YrVoY4Prf15zx5CoM7F8P4wggGX03skIwBq6F8l?=
 =?us-ascii?Q?MA8amLHD2KVJlvps9MvkqDLjSA7AjYhxvyO1O9OBkkLN6FuML/IRLVl8WniZ?=
 =?us-ascii?Q?yxe0SeEOT0PqEUuy61m0a0UZeb13+oRVoFEA1StZ9NZvWy2xg/unb7kCnuOG?=
 =?us-ascii?Q?4G9zmQB4swjDNhgqYHQyKWgk2W9gzm3qbjCGx3IxOxTRoogWOgUgbboq9Fxb?=
 =?us-ascii?Q?LyiGklXsL3Zygb0TYI/N2kPEsOeAE0pNOqLLBAYl7hTHQHOFSV47V+T2oTzj?=
 =?us-ascii?Q?/DHMdqwNraEBKBxZ1EQhubPZvPE02NUdnDeGIRw1n1lQ4PcjIspoYxXG/JnP?=
 =?us-ascii?Q?HnUCAmk1Z5A08/83tzdseTn6Ibh4tbTSYKikgf/pHyYulASsgKN2ShxcbZ8z?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OAYOIP6pb0LIGsD8q4ixNSQ7VBFFI0htu4+hBUJEKxPCd8boVGESmlQWL+jxEpb2wslwmYx5Nv45Ohw3BPCcZ3fcsU3M4IttR8FMA/NeWSYNzz+GA4/1lQpMJQfMjplfa0J6KAiFAuKK+1MxYqOUZB5VR1d5CwdRJ7AylRbeDqmx3KI+pqNkmVkoaV3vZtcN33KqD4StMYpfhY8PugyBuaFc0LQvegN1DXqPxwU0WsyHXpPZnbISbLzQmOz5vRE7jJmIJDqjTpoO1jiUpqBiVX5lkPz+iKEtQHar5SLHo5zU59YwK7P9BzRX+3eFox4BaglzvKqZ+FGaTO0uNuuAFQGlToChAX6HeqFDP/c0qWAeLOFSixeGzbfyMDhjCUkKukRe6QdvrKp+QtUWE6RHPIUAjZr8bCFbDUOzAxtN5gWx2uOdPYdWldM0nPNq9IlqvGx1QA9VbDsKhyTNc7hN1+KuWOjGAMYVtlLGFC5qfm7VnEcOZhIKEWqDyYWMUuYfy4vkWfMpa7WVe5UmJbJaCNTWofRzUFkeTvWA01vgtCKDmwnWQgxlOaOcRicRJZTIxXG0VyrgS8ERA1DJNUQI9NeUva0Bn3tm3FsDGPlm/Qs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e49d2c-4291-4d31-b62b-08dd7c172255
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:14:56.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+IPW87cFtLib29RTrVj1f67b9S3minvPV/6OJHWLFpEe18ahXofmBKqHelltbOYkax5VKFNGR9UWS9nHCe4xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150086
X-Proofpoint-ORIG-GUID: mMgH7on7F0BoqNbdeQ8G1-mM3bemiEfb
X-Proofpoint-GUID: mMgH7on7F0BoqNbdeQ8G1-mM3bemiEfb

Now that CoW-based atomic writes are supported, update the max size of an
atomic write for the data device.

The limit of a CoW-based atomic write will be the limit of the number of
logitems which can fit into a single transaction.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

Function xfs_atomic_write_logitems() is added to find the limit the number
of log items which can fit in a single transaction.

Amend the max atomic write computation to create a new transaction
reservation type, and compute the maximum size of an atomic write
completion (in fsblocks) based on this new transaction reservation.
Initially, tr_atomic_write is a clone of tr_itruncate, which provides a
reasonable level of parallelism.  In the next patch, we'll add a mount
option so that sysadmins can configure their own limits.

Signed-off-by: John Garry <john.g.garry@oracle.com>
[djwong: use a new reservation type for atomic write ioends]
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 90 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  2 +
 fs/xfs/xfs_mount.c             | 80 ++++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  6 +++
 fs/xfs/xfs_reflink.c           | 13 +++++
 fs/xfs/xfs_reflink.h           |  2 +
 fs/xfs/xfs_trace.h             | 60 +++++++++++++++++++++++
 7 files changed, 253 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 797eb6a41e9b..f530aa5d72f5 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -22,6 +22,12 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_attr_item.h"
 #include "xfs_log.h"
+#include "xfs_defer.h"
+#include "xfs_bmap_item.h"
+#include "xfs_extfree_item.h"
+#include "xfs_rmap_item.h"
+#include "xfs_refcount_item.h"
+#include "xfs_trace.h"
 
 #define _ALLOC	true
 #define _FREE	false
@@ -1385,3 +1391,87 @@ xfs_trans_resv_calc(
 	 */
 	resp->tr_atomic_ioend = resp->tr_itruncate;
 }
+
+/*
+ * Return the per-extent and fixed transaction reservation sizes needed to
+ * complete an atomic write.
+ */
+STATIC unsigned int
+xfs_calc_atomic_write_ioend_geometry(
+	struct xfs_mount	*mp,
+	unsigned int		*step_size)
+{
+	const unsigned int	efi = xfs_efi_log_space(1);
+	const unsigned int	efd = xfs_efd_log_space(1);
+	const unsigned int	rui = xfs_rui_log_space(1);
+	const unsigned int	rud = xfs_rud_log_space();
+	const unsigned int	cui = xfs_cui_log_space(1);
+	const unsigned int	cud = xfs_cud_log_space();
+	const unsigned int	bui = xfs_bui_log_space(1);
+	const unsigned int	bud = xfs_bud_log_space();
+
+	/*
+	 * Maximum overhead to complete an atomic write ioend in software:
+	 * remove data fork extent + remove cow fork extent + map extent into
+	 * data fork.
+	 *
+	 * tx0: Creates a BUI and a CUI and that's all it needs.
+	 *
+	 * tx1: Roll to finish the BUI.  Need space for the BUD, an RUI, and
+	 * enough space to relog the CUI (== CUI + CUD).
+	 *
+	 * tx2: Roll again to finish the RUI.  Need space for the RUD and space
+	 * to relog the CUI.
+	 *
+	 * tx3: Roll again, need space for the CUD and possibly a new EFI.
+	 *
+	 * tx4: Roll again, need space for an EFD.
+	 *
+	 * If the extent referenced by the pair of BUI/CUI items is not the one
+	 * being currently processed, then we need to reserve space to relog
+	 * both items.
+	 */
+	const unsigned int	tx0 = bui + cui;
+	const unsigned int	tx1 = bud + rui + cui + cud;
+	const unsigned int	tx2 = rud + cui + cud;
+	const unsigned int	tx3 = cud + efi;
+	const unsigned int	tx4 = efd;
+	const unsigned int	relog = bui + bud + cui + cud;
+
+	const unsigned int	per_intent = max(max3(tx0, tx1, tx2),
+						 max3(tx3, tx4, relog));
+
+	/* Overhead to finish one step of each intent item type */
+	const unsigned int	f1 = xfs_calc_finish_efi_reservation(mp, 1);
+	const unsigned int	f2 = xfs_calc_finish_rui_reservation(mp, 1);
+	const unsigned int	f3 = xfs_calc_finish_cui_reservation(mp, 1);
+	const unsigned int	f4 = xfs_calc_finish_bui_reservation(mp, 1);
+
+	/* We only finish one item per transaction in a chain */
+	*step_size = max(f4, max3(f1, f2, f3));
+
+	return per_intent;
+}
+
+/*
+ * Compute the maximum size (in fsblocks) of atomic writes that we can complete
+ * given the existing log reservations.
+ */
+xfs_extlen_t
+xfs_calc_max_atomic_write_fsblocks(
+	struct xfs_mount		*mp)
+{
+	const struct xfs_trans_res	*resv = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int			per_intent, step_size;
+	unsigned int			ret = 0;
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	if (resv->tr_logres >= step_size)
+		ret = (resv->tr_logres - step_size) / per_intent;
+
+	trace_xfs_calc_max_atomic_write_fsblocks(mp, per_intent, step_size,
+			resv->tr_logres, ret);
+
+	return ret;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 670045d417a6..a6d303b83688 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -121,4 +121,6 @@ unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
+xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 00b53f479ece..860fc3c91fd5 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -666,6 +666,79 @@ xfs_agbtree_compute_maxlevels(
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
 
+static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
+{
+	return 1 << (ffs(nr) - 1);
+}
+
+static inline void
+xfs_compute_atomic_write_unit_max(
+	struct xfs_mount	*mp)
+{
+	struct xfs_groups	*ags = &mp->m_groups[XG_TYPE_AG];
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	/* Maximum write IO size that the kernel allows. */
+	const unsigned int	max_write =
+		rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
+
+	/*
+	 * Maximum atomic write ioend that we can handle.  The atomic write
+	 * fallback requires reflink to handle an out of place write, so we
+	 * don't support atomic writes at all unless reflink is enabled.
+	 */
+	const unsigned int	max_ioend = xfs_reflink_max_atomic_cow(mp);
+
+	unsigned int		max_agsize;
+	unsigned int		max_rgsize;
+
+	/*
+	 * If the data device advertises atomic write support, limit the size
+	 * of data device atomic writes to the greatest power-of-two factor of
+	 * the AG size so that every atomic write unit aligns with the start
+	 * of every AG.  This is required so that the per-AG allocations for an
+	 * atomic write will always be aligned compatibly with the alignment
+	 * requirements of the storage.
+	 *
+	 * If the data device doesn't advertise atomic writes, then there are
+	 * no alignment restrictions and the largest out-of-place write we can
+	 * do ourselves is the number of blocks that user files can allocate
+	 * from any AG.
+	 */
+
+	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
+		max_agsize = max_pow_of_two_factor(mp->m_sb.sb_agblocks);
+	else
+		max_agsize = mp->m_ag_max_usable;
+
+	/*
+	 * Reflink on the realtime device requires rtgroups and rt reflink
+	 * requires rtgroups.
+	 *
+	 * If the realtime device advertises atomic write support, limit the
+	 * size of data device atomic writes to the greatest power-of-two
+	 * factor of the rtgroup size so that every atomic write unit aligns
+	 * with the start of every rtgroup.  This is required so that the
+	 * per-rtgroup allocations for an atomic write will always be aligned
+	 * compatibly with the alignment requirements of the storage.
+	 *
+	 * If the rt device doesn't advertise atomic writes, then there are
+	 * no alignment restrictions and the largest out-of-place write we can
+	 * do ourselves is the number of blocks that user files can allocate
+	 * from any rtgroup.
+	 */
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
+		max_rgsize = max_pow_of_two_factor(rgs->blocks);
+	else
+		max_rgsize = rgs->blocks;
+
+	ags->awu_max = min3(max_write, max_ioend, max_agsize);
+	rgs->awu_max = min3(max_write, max_ioend, max_rgsize);
+
+	trace_xfs_compute_atomic_write_unit_max(mp, max_write, max_ioend,
+			max_agsize, max_rgsize);
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1082,6 +1155,13 @@ xfs_mountfs(
 		xfs_zone_gc_start(mp);
 	}
 
+	/*
+	 * Pre-calculate atomic write unit max.  This involves computations
+	 * derived from transaction reservations, so we must do this after the
+	 * log is fully initialized.
+	 */
+	xfs_compute_atomic_write_unit_max(mp);
+
 	return 0;
 
  out_agresv:
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 799b84220ebb..c0eff3adfa31 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -119,6 +119,12 @@ struct xfs_groups {
 	 * SMR hard drives.
 	 */
 	xfs_fsblock_t		start_fsb;
+
+	/*
+	 * Maximum length of an atomic write for files stored in this
+	 * collection of allocation groups, in fsblocks.
+	 */
+	xfs_extlen_t		awu_max;
 };
 
 struct xfs_freecounter {
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 218dee76768b..eff560f284ab 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1040,6 +1040,19 @@ xfs_reflink_end_atomic_cow(
 	return error;
 }
 
+/* Compute the largest atomic write that we can complete through software. */
+xfs_extlen_t
+xfs_reflink_max_atomic_cow(
+	struct xfs_mount	*mp)
+{
+	/* We cannot do any atomic writes without out of place writes. */
+	if (!xfs_has_reflink(mp))
+		return 0;
+
+	/* atomic write limits are always a power-of-2 */
+	return rounddown_pow_of_two(xfs_calc_max_atomic_write_fsblocks(mp));
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 412e9b6f2082..36cda724da89 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -68,4 +68,6 @@ extern int xfs_reflink_update_dest(struct xfs_inode *dest, xfs_off_t newlen,
 
 bool xfs_reflink_supports_rextsize(struct xfs_mount *mp, unsigned int rextsize);
 
+xfs_extlen_t xfs_reflink_max_atomic_cow(struct xfs_mount *mp);
+
 #endif /* __XFS_REFLINK_H */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 9554578c6da4..24d73e9bbe83 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -170,6 +170,66 @@ DEFINE_ATTR_LIST_EVENT(xfs_attr_list_notfound);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_leaf_list);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_node_list);
 
+TRACE_EVENT(xfs_compute_atomic_write_unit_max,
+	TP_PROTO(struct xfs_mount *mp, unsigned int max_write,
+		 unsigned int max_ioend, unsigned int max_agsize,
+		 unsigned int max_rgsize),
+	TP_ARGS(mp, max_write, max_ioend, max_agsize, max_rgsize),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, max_write)
+		__field(unsigned int, max_ioend)
+		__field(unsigned int, max_agsize)
+		__field(unsigned int, max_rgsize)
+		__field(unsigned int, data_awu_max)
+		__field(unsigned int, rt_awu_max)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->max_write = max_write;
+		__entry->max_ioend = max_ioend;
+		__entry->max_agsize = max_agsize;
+		__entry->max_rgsize = max_rgsize;
+		__entry->data_awu_max = mp->m_groups[XG_TYPE_AG].awu_max;
+		__entry->rt_awu_max = mp->m_groups[XG_TYPE_RTG].awu_max;
+	),
+	TP_printk("dev %d:%d max_write %u max_ioend %u max_agsize %u max_rgsize %u data_awu_max %u rt_awu_max %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->max_write,
+		  __entry->max_ioend,
+		  __entry->max_agsize,
+		  __entry->max_rgsize,
+		  __entry->data_awu_max,
+		  __entry->rt_awu_max)
+);
+
+TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int logres,
+		 unsigned int blockcount),
+	TP_ARGS(mp, per_intent, step_size, logres, blockcount),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, logres)
+		__field(unsigned int, blockcount)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->logres = logres;
+		__entry->blockcount = blockcount;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u logres %u blockcount %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->logres,
+		  __entry->blockcount)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1



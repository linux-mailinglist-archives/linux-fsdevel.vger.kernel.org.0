Return-Path: <linux-fsdevel+bounces-45960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DFA7FCAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7A167A9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150A26B087;
	Tue,  8 Apr 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lEOt6qyB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bdkVvNYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD026A1AD;
	Tue,  8 Apr 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108990; cv=fail; b=q70wfewxCUNCNz3lVs1FLNr1ocMKNlazQrkfOP92rrlTgSWqpED87afWOGkv5o3c2qhf7FAh487j2vPJIGxDyDMSQ7zgH6RDuU/JU4QsuarT5GCFx6iQnlRczx7Ex/8+hF0qHkHDtTlmmGFTEvt4YbgTpyXpllybNFcO2K0iUV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108990; c=relaxed/simple;
	bh=Qka5esl4do73t9eWxVnRmzqc4T+aOFN3BaM4tqH47E0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3V5ddjdnaOQm5otxG+oiCL51scas9vtQhM1xKFiD9f235vBIHEO0f2nWi+HVB6NBIHiWQCf8fRN9stAXEXTtiMFEYaM8UxGJbe8pz8ePgkomdl9CFlhgOASlfZEEj6dOLgG8i3CbuBgDUCiIGNPzQooONWzN6UsojSOrSDNeu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lEOt6qyB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bdkVvNYU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381u4bi025619;
	Tue, 8 Apr 2025 10:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L8T9k8/yZ2/9JgtUeIXvx7zT/lKWVjyAkFouKFEyQro=; b=
	lEOt6qyB56gasdhN/n2rkyDfzJKc8wtr3OBpcaH+o/WAJG/OVi/7KswWwKgqBZ1g
	8ztnSOkSmHijzWQe/sKPDPArZ7npHObgs4ZY3ozfIsUdIZzZyqZydzAWDpLyX4T3
	GcizgeUgn/vZB4s7D1r1Oo2oxJg3tUHYPR/4HTai/5azCxRKo0ReYJHlVVh2iqqS
	08ii5ci9vZsW6BbOMq2vb8901t8onCoKYD/SeGn9Qel2OMaUYRZ75VUXsBxhlDPt
	U48GyUxqqhWutFMCM3OhZr6yPzC59q0oBzSXHyxeEB+cBJamt7vfePo2DuTB4M6C
	yKu3u7r+LGjJvsx7MjjYpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tmfat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5389gFML001477;
	Tue, 8 Apr 2025 10:42:56 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty93dd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCYATMyWXACLkZZNNkK7spUZ3MZJvzPzze1yaXuTaEP4EpCqtMQo1zxffWmRLNfWCwl2q7vYpG5Tyde6q25/c1Ks/u6vcwtkFjz/u3RdyZtHzj29QodTjrwd+IzGCAPeNkkO6lkoBtcY2y4XclmX+Fe5MOtvuwMwExbOPiG0XL483PHNLcIuKoR7HwTmRZ5BndNiRpxb2FNOgK9QQGlZKTadBGfUGA2GlMFEQOBZDJ45yFTQa2jqkRRJHu2jHIqow1sv4gdCXgHjS1M3BzQ5y5KJ5KY/SWLgsGJzxUZDCmmJe8KcJlrI64yuxWdJ/Z28i9pNQXF2VIhhQhwUa91Mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8T9k8/yZ2/9JgtUeIXvx7zT/lKWVjyAkFouKFEyQro=;
 b=G0NW+NGL9zmjh/ib/S2m/PUHqVtfeuAgwRvQyH2vO1QVGk3j2zTSNAhc8a8x1cvzG1jliZ6G/MOfnCpI5rbXoCG3qWVtIwQC/i2DNZAmGyO8wc1V4SOyl6/5R/NWtFEQjwql8JajXXPJRRl0l2BhguFxyCnJQneEYLEHXxjXPHf564KbBRW4MDj1f5CPyGIVGKHGlC1/ipgHPM1RgUzBB8Iv5A+m89R+sR5Obw/pB+eEYmCeNNAUB9FkhedU76N0ld4qAxlxDpbpFOvOdzebTRUcxLr0UbS7+HE8qrKIWdF+VtI4PuOFffR4BgEF8H3TnzCs7VZq4tuuO9SDWBGYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8T9k8/yZ2/9JgtUeIXvx7zT/lKWVjyAkFouKFEyQro=;
 b=bdkVvNYUbMq+O+Rkp7Wi3g+9HJyVVXFFQmXrmg67aHKdfe2xmIWzwXUd/GTbktq0fliPic3r3BDyXyGy1vMTHk0bvhhL2ktCDFssE+UbAJ3Dr8YjoZOZnbNfoU/FLXBLyO5QPvjp65nt5uWITI+GIwkVNZaqI7ATivCMRbfXjVg=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA1PR10MB7486.namprd10.prod.outlook.com (2603:10b6:208:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 10:42:54 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 12/12] xfs: update atomic write limits
Date: Tue,  8 Apr 2025 10:42:09 +0000
Message-Id: <20250408104209.1852036-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0010.namprd15.prod.outlook.com
 (2603:10b6:207:17::23) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA1PR10MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 8519a017-82ff-4951-1098-08dd768a1e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7m0/kj6M0xSCNc5wEhqsfkmeWQfZiqxX4ReQIEfCSiopabeEy4dncFVCl/P6?=
 =?us-ascii?Q?5cc5Do8NqIEGIIGfQbRv7uC/DSiQYtTiX3iRdUnJ3copfpvnRUW7pLHsA0xq?=
 =?us-ascii?Q?TcXEFs8BK3xVntQ5Zu7IFda+cRmq+NJdJPLGSnw6NCpfC4FvEbwziZTXG0kc?=
 =?us-ascii?Q?eqXqGjl5tdDbKUbuk9i1XPSJjNgtwoNGPmzRnTn8ZrvIfi2TaUgnhWTK8A01?=
 =?us-ascii?Q?EI1kaDg3Z1wjUueT6mCDL4MXOIj0YzRVfmCFxHTCxdmZbUryjxRftwjpt96L?=
 =?us-ascii?Q?T6ixGqvSsnPlxCu8YICuqdp0RoJNxTg+IAMsVgE/wycRbprxFDRl/0w1S/3Y?=
 =?us-ascii?Q?Zm7Sg8omNZ1+w7myqXXsaNwdk43xXV7c6ShO2/O4koSAVWRFdn3uH4lSZyJG?=
 =?us-ascii?Q?p7DYLtr0qav3mV+ZGOZEOf7LXY/cIGThchr2HcCkUPddPPm+6RXl4D04OH1I?=
 =?us-ascii?Q?iHwTAt0tp81YxQRwIcLLQUbAV6ZTfMXJfe/+cfRFWakDvjvVD9fX7GfXaMzk?=
 =?us-ascii?Q?KuDx5RjOVqrHnIsYb0ofNTufE1b+17KH16dnB1H+5U/DUWVnagKXt7d+GvMy?=
 =?us-ascii?Q?UUEQmQJx1Fpd/0SUSLzMd2ciHOtuooD7+hy8WN/4cp3SrtDhNBdpZ1V/m09J?=
 =?us-ascii?Q?g70XkqPiwxpHS2+A0SVtKkIbqVoSc1GbgB3cA1dD/81jmt+ht38zZ2mY/TZT?=
 =?us-ascii?Q?aCg8PJ9vdCnYpnCV9G/4FNeNd4cQdGAKnluBjieZLAMZCd/EX/5NmGGD5+cE?=
 =?us-ascii?Q?n+TPSPZJVrAVRUYawrA/iUUFrIlX4BhpOIg4oVBEwMf28dqAjtF37SdgKakd?=
 =?us-ascii?Q?0yV3mRklMvfXH/e+0kj8rUDRgwsm6Rl6HchlP9ZYDlz6gfjOL6zHQyXfOFwj?=
 =?us-ascii?Q?21ykWCUOEhqJFfcf4002Zcl6B8UQYGjZWdJmTb3e4rHztF1Ky7T5mO9Djjry?=
 =?us-ascii?Q?9RcvvFW7ALqKjCTbAMooJXC/VEQshZrm1QC0g6R3NfPneY/DynOHAPXBTl+b?=
 =?us-ascii?Q?L2FLXxNIu03gZSr7rr+haaM02kVPrU+/LSeTbqvQfDDRE+s5XGtRffbDb+vJ?=
 =?us-ascii?Q?RwQSY2x0IQEk7woQ04OQeM0cesmzI/fpSHzZ5i/D9FMQhVeJlWVeKyhPqTQe?=
 =?us-ascii?Q?st5aaXqIgNN30kNpDmmULjOqpgiomJVF9iJQjvcYrgcVbpiPrZeP6lLIdxOx?=
 =?us-ascii?Q?954lSMxBmXGdZGvCqP1q7xztGM/KuZ54V/ic0JrwYK4U7RLwHOUdFNBPtBMW?=
 =?us-ascii?Q?qixMLQ7PcacedfjvzeFCTHtgHVRNdgS1j0OIZAdAIyLHCINemCBsYAiQAIVc?=
 =?us-ascii?Q?E1c+qoX28jmoRZmbUQUJgX1rBWw7xsXv3DPBy55QZxKe0JQLDF81E3Up1gJa?=
 =?us-ascii?Q?1wcmgKDes5/n/zg6cy++FJ7oyknA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbU3BkNd+SqsznevcGHxmlmdCeKeS8SkBFa4zvKDYmW690wGMJyqFhckOimA?=
 =?us-ascii?Q?SNWXC+HLGYajmlAYg9GOLtlV3fnbAlnUpO/yC+sv/F4Csj++tvR4Rjh95Z9G?=
 =?us-ascii?Q?Et6V2kZAXW22/p7B6qywOj59YHe5DpgcY8H6LI0EG7xr9RHaCgqDQodhbmlw?=
 =?us-ascii?Q?cIVbEBDavL+2G/rcN18C/Qv4wGWoxxHeHMkGOerem9Vqc9kJSQlY9yDsFY6+?=
 =?us-ascii?Q?ha4TRGN60VbJOvmrwYO4zGJTYU26E1YU0Ae9fuWeGnJKyMHAgaZpOkGOPitA?=
 =?us-ascii?Q?d+XEQCux+qJzxXG5Dbwr05p7aQz1RbSsb+RPHwzJTPY7ebSKAMpvF2d/H5sd?=
 =?us-ascii?Q?TLNKejEpJVe0oVnivWzEgnzPQflOcX0rB7von0LBysfmsBrw9+UpJbGpn4/0?=
 =?us-ascii?Q?mABf1Vce4C9ah5vCWfgFH0WmG2CaE/QyJRbFRLxiXjPWkx0vFtbVQwQWTNqY?=
 =?us-ascii?Q?RS88e/liwnN6wIGy7Cag6jIetmJozwJhZSquDIy3TVCPAYh5G7yEUxIxcVsr?=
 =?us-ascii?Q?UvLgqzgyGYn0M3+gz+P37u4EueZbLvuGEaIVc0wEmIcG6m2PMpq7r5Ol3LM7?=
 =?us-ascii?Q?61uZW0QX4RcB0k2xddTUEMcAy2dpqj9zbrgbxNAhZGyuS0JHbs13JqZPilrf?=
 =?us-ascii?Q?V93jN3m0eXsY8iZs3IAodlaIqUB32Dx1PBhtE+QuY/HoOfkEMyvDczSHt+ja?=
 =?us-ascii?Q?zg/Xxc4/6l3NLMobi34uD/GottRYqDDJnA9FJIU2gEOCe0x171J0am9gkpI7?=
 =?us-ascii?Q?q3ThFYcrczS4qIk0Gq/lJSw4wwMTPYr/vrdJbAfS3YgYW75uDBA+ftOxl7GP?=
 =?us-ascii?Q?QAndsCi5LrGgfkGJEkKsEd4lF1XdBbtRmgnmL/WgHRj9K12BcUEOe0tQ0NCq?=
 =?us-ascii?Q?tMwdbaRaYubtM1Y0/S0kzMAtYd/waJrpnYpMFhrBX9eWtHxmrSlQOw2xdDe7?=
 =?us-ascii?Q?RtkgQaNbyUWYuhevMvUXKgyBNO4tXUHeP20kfQ7jG8OqmqayoiIXPwzdXMYg?=
 =?us-ascii?Q?JQTE8p0gVJXWzqoRAWXkMIOQ4pP+bl+H17kJH/52pgyfagh2m/XJU5PBsrnF?=
 =?us-ascii?Q?r802uuHwNXECkj1wd798nTU6Law+A15hgWR7tdafEcMENQrJbs4mz4PcA+Cp?=
 =?us-ascii?Q?Cq7kftI7TfCk37RQRsXlvunaTi3GyGY9GwW0E9HZ84FuJtjYOldwu/VYQ2kZ?=
 =?us-ascii?Q?j2cI2RkAiVYdym1CDPkgznhfl8RQRvmg0IVvA/kugloHmx4x12E1hWJXv6Ln?=
 =?us-ascii?Q?zqrTkanTIxl8s5YT/mqAy+bdCraO0NTxaodeSWcnmjLkJp2Nji8qtrvBZdzf?=
 =?us-ascii?Q?Z8NY8SyagmcmYpV7F77v7/DiYjAtMaKOyshx47sw8YKUtvwwo6YrnTB9MoCh?=
 =?us-ascii?Q?nJX0w4ZBv1m9miud57VXsvSnBQYCSuGoc1D7tWHgYytRnunp/1fC9kUGgWyp?=
 =?us-ascii?Q?6LLhpCLFtp773209pRdmO64f14ice/M0jVSQSaDsAfX1eH1QD8Q+iTVQ/4/T?=
 =?us-ascii?Q?Wcgsw7pwNBrCIkZSuwYEwpGkkEFrSIIhnikCWyGjIJEkloojE3oerol3adcj?=
 =?us-ascii?Q?qEN7qUO2SSm/c3QB+SSDmpsTbkCF7MzwbD6sY5YH7OCYLgbVHsL77VkaKfQN?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4dge3eM8rXCxfihvsJlSnLVMaz1OljIpSb2GKm2pA+2+FKLis4uNV2ayKXheYWM1M092RCUvwokIDkdp5nzg8lPoW8PnjN5UxYWgfLI6+7DJD2m0d0WHX3/gInJL1NTSZXPqDMGgB1CjkaAYUoQxBT0gMCRkNA1/a6vaBfCKvD8C280O4+QoJ1wPFjW8u3D+CWP3z/uE1NMqgQGbLYtvjXU92zUxjcesUgtH0R6QbrFiOyWevpMNX4JaDRJJxXlA+5HHAoF4IAgL7roek+MWoyk8uwRR/CJ89kpUJgH0D1UbVJCuHZ6tZarJgey6/MXs5LtmdZ5FGmlsNLnT9BIsh+bSynOLNAjc9j3T2C4R0ddjrESt65HKE2rhMWpcJYeR7OiW33QDtbPPxbbQmaFD1/0RjYBizR4bgeltDhTgwNeeo9iqXf/aAkCfb1tBqiSvUUkC7HpBYySC5MRyzWNVaWuuk9w1RRt22xst3G0NDuHSZCrs9FAu919S4ssvnNkz/QSxwRt94ROtLlhRva+Lmknxre0MbmLRj0Ny42egVtltsztA8HW1L0m7rylFzd4fSDv07JR0uob8TPPMpSQkMvBdFjVAKxn9VxzSUmNtsaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8519a017-82ff-4951-1098-08dd768a1e0a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:53.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbB/rxwG+DN3JJ5yy0NKiovoVenuKnFPChqvd8xkCKbkDk+u7qv5MhspuTuB0/RAJIhdPJ4qjv2lPsd2yGWhgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: 1eFCvZL5ioGlawa1n_KBsRFIvD5mj_vB
X-Proofpoint-GUID: 1eFCvZL5ioGlawa1n_KBsRFIvD5mj_vB

Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().

No reflink support always means no CoW-based atomic writes.

For updating xfs_get_atomic_write_min(), we support blocksize only and that
depends on HW or reflink support.

For updating xfs_get_atomic_write_max(), for rtvol or no reflink, we are
limited to blocksize but only if HW support. Otherwise we are limited to
combined limit in mp->m_atomic_write_unit_max.

For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
> 1x blocksize, then just continue to report 0 as before.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c |  2 +-
 fs/xfs/xfs_iops.c | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 81a377f65aa3..d1ddbc4a98c3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1557,7 +1557,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
+	if (xfs_get_atomic_write_min(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 3b5aa39dbfe9..894f56f1a830 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,27 +605,52 @@ unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomicwrite(ip))
-		return 0;
+	if (xfs_inode_can_hw_atomicwrite(ip) || xfs_has_reflink(ip->i_mount))
+		return ip->i_mount->m_sb.sb_blocksize;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomicwrite(ip))
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If no reflink, then best we can do is 1x block as no CoW fallback
+	 * for when HW offload not possible.
+	 *
+	 * rtvol is not commonly used and supporting large atomic writes
+	 * would also be complicated to support there, so limit to a single
+	 * block for now.
+	 */
+	if (!xfs_has_reflink(mp) || XFS_IS_REALTIME_INODE(ip)) {
+		if (xfs_inode_can_hw_atomicwrite(ip))
+			return ip->i_mount->m_sb.sb_blocksize;
 		return 0;
+	}
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * Even though HW support could be larger (than CoW), we rely on
+	 * CoW-based method as a fallback for when HW-based is not possible,
+	 * so always limit at m_atomic_write_unit_max (which is evaluated
+	 * according to CoW-based limit.
+	 */
+	return XFS_FSB_TO_B(mp, mp->m_atomic_write_unit_max);
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
 	struct xfs_inode	*ip)
 {
-	return 0;
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+
+	/* if the max is 1x block, then just keep behaviour that opt is 0 */
+	if (xfs_get_atomic_write_max(ip) <= ip->i_mount->m_sb.sb_blocksize)
+		return 0;
+
+	return min(xfs_get_atomic_write_max(ip), target->bt_bdev_awu_max);
 }
 
 static void
-- 
2.31.1



Return-Path: <linux-fsdevel+bounces-38323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A173A9FFA17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB918834A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DDA1AAA32;
	Thu,  2 Jan 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hxpghGNX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mRjnV7x5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591231B4140;
	Thu,  2 Jan 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826699; cv=fail; b=VI23ojv8tK4D6A149ZBJCvVHenF0XT0VEf1sF/u2CG7NOtaRqB5DUrL3AiMLiE2exPAAA8HRUkRxLB3MK+UiCYbbgZD98PXyCF1+1ocofdK9cWTbSFHMNIgE0Hv2hU3lD81U6t4TiFNVTC0xL9UqYjiAPOeXTVJa1LS5gBTDAy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826699; c=relaxed/simple;
	bh=kWgiwjQoCWVCg4ulv6EuuV+2onieZIrHz2ifgwcsd9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajT0hfiS/vX96PYtTdK1X89RVTsAHMRHyoiHv3S62MmPsQ0+fZtEQLBzuR8TVA3Ie+Isp+JILw6jWwbPJ6GsULB4wESUY9FUcn6noimbB9jihUf43L6zIli9e0SL2zh0snQswSC+YJQ6VDVdk2tQVRQ+0am2dkgBkMJqa9iOBe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hxpghGNX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mRjnV7x5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtrfU018980;
	Thu, 2 Jan 2025 14:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Pi6nNeWKVWfsgMMYNfG6r2SBEVk0r2mrnQLm9/GjiPI=; b=
	hxpghGNX+BrMVby9r6dukWnnYR6ZWTWsmtFpT4J/SBWkBCwA9bxCR/tUA8x95xI6
	Hp3C/scNTEorBgR4AHdSDvBjLX1vr0v8wuU8R9/brm9e0LW+z2G7RhjKNpoB4hSG
	RO9lOIfzWXOLRbdqKjPFQE5UCqLJbaaK2/lXir6X/QwCzPVMyjWHoukgZBGbJD+s
	3LPi8tfvhuX7aO6s3Im5qVT7Nonnzoz0NpBl57gxFGonNxOyn0fTDBrnYSAj8IU+
	WJPP8vkpm+LfWduDWjrTqEmeLzZgCumD7QLpBpo/BaaSTHmXWQ5UUp2+ZL/qfE7q
	31KnVl0wItaJf16q1ZINcQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a5e39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502CqmBM033469;
	Thu, 2 Jan 2025 14:04:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8bg1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVaXaP0sxS5MzW1tT6Nfp/YblOL5AvUDy/Z/LqYh1W9XiUX+bo9zu12l0B0Mb21nwZPxD6uYen7zrIZnr7ZhFjBH2Pg/gppjuRFQP0m/W7XvbGU3GFg93mOhVgbwVtpYv9c+7rMdbJTZHpfoROE/BvY4H0pEa5eszplctB6iapQK8YjvZu/prfm1vcuf4MgcBOfi38o3gUiihBGDyh7IuxddEoNUroG68RHdXgsVDoKspSQb/NRHCgGj9/LjbaOt1PioDUg9eFM9VMA3Qzl/hW6Kb9fOyDrmdPAwDT5awDzZB2qo1X3SNCNvWpkjhgOoX3fbCxumUEPIXVYDstrM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi6nNeWKVWfsgMMYNfG6r2SBEVk0r2mrnQLm9/GjiPI=;
 b=SlHUuBVJpYiwDetapkO2eDzaQ3EieIyWBq3YROnqzN8HPcNtDeT7EguDAvRn0AWklMDNG0GxRsAMuNY2JVrpTFW/KLPLJNbrkoy5GeiNEMEeazzJikwxoEmRwFsamjO8d72dxB3trFsU/AzClyjfl3RCwncjziblVYr3/9WWK8adKt1pSp6nB8PH+IfxeWRYseGD4JKPyHy9Eo0M2Wlv8S6vfDeK4XtrC9x6DsO5rmT0KVZUMKMr9AqJm4FibQzHmhln8FM50rENaQqagDoOgyEA7Tr6Xu68xm9mOpNXGrKyNLKEpDsLrkvCwvJV2YEtVLloYISxUhDrzCKP2pg4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi6nNeWKVWfsgMMYNfG6r2SBEVk0r2mrnQLm9/GjiPI=;
 b=mRjnV7x5978W0Eft+/3V1tqBeiYkw3U3RJRWBGkEmGT+O9ix8kr8Do3Q206cmj/HGwFjNuJFYinz50eyhXOyBq/Tfdc7gzYkiSAu78JoeuJaK/2jP/q5IoM4h8Umyh3xRasdBlXJuIM4egLvxyr36NoS0Tb5pCfxMrXp926FB0I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8164.namprd10.prod.outlook.com (2603:10b6:208:514::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 14:04:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 3/7] iomap: Lift blocksize restriction on atomic writes
Date: Thu,  2 Jan 2025 14:04:07 +0000
Message-Id: <20250102140411.14617-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250102140411.14617-1-john.g.garry@oracle.com>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:208:23b::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a183e3b-df1b-4cbf-b57e-08dd2b366574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ptjqqd5tw8CVgqH40NcevktjxHcwkcktjkmXImDHcGTZ4mULI+5p2rB6Wcih?=
 =?us-ascii?Q?b/Sllz4eOpIIWk1K1dArqDNx5r3GmkGEhxJLTWlx1a3239ebcoCMQ9oRRVk2?=
 =?us-ascii?Q?fDvOxmHuCnqRwnuK7JK6evBjKZTv645c/zyx2XYoR8/nFBb/4EbTeAMyR8RH?=
 =?us-ascii?Q?hIJymDm04fHPusGHBlzaSWNRr1T0bsiiyv4QbNGfVqSTJfBsSvpRPDT/19jN?=
 =?us-ascii?Q?NquzZnVeFT/1oAeXfGVJVI5YiNiy3xaZqhL0au21YPwEmOymtrmGCVxiyZlI?=
 =?us-ascii?Q?l0bgWoD64De4gKb7JxD4vREHmsPqG2A8/XHGE4vTV8qFo6jnZY5GVMFeifyo?=
 =?us-ascii?Q?7MobD6YBUEO1rtd8Fi1WMeY79FL6L0ySt8hZTbrhVRGwetoz5PCv0Lgc8Njd?=
 =?us-ascii?Q?OUw9Uei8Wim3M76LWbcNSCYIC3GCn84D1Waz0qAdSazn8jWBV/e34F8+XLLE?=
 =?us-ascii?Q?0hfGNRfLgxWOFOIcvrm2mzQOfr2dVGK317wdB1o4pexGs0p/QX3A6UT6O4Ox?=
 =?us-ascii?Q?X8+TaUMKCrFcvCMTIKQBRbMXvnoaxzX4i8/QqBBJURx2d8VqBxdxMiYVvLEL?=
 =?us-ascii?Q?qauVGUSk2lcL3tohL4gQSx+sNBX1hl2IkpDDzYhRVrWaCz2zf8HNzEzSQWWQ?=
 =?us-ascii?Q?hi7JSz7ngG5r57o0J90o/V3LTKx4mOxFGDfU4oogTWaoMT/5t576cHLlOBac?=
 =?us-ascii?Q?p3ohlYBqmHtYrv1sqsREmXcZ3WNT7wxdYO4mY1d4ra5hqt15s2dZboWGAa/2?=
 =?us-ascii?Q?C2wPLJP2UUqe8vekUCOi1QeTvFxPzqfUeecpUO++LRDlEXesdAgz7sbx78LX?=
 =?us-ascii?Q?I1gpbtXy3iiM8h9YeUG1RRN3glfVetuzvVS7yfedO3Mb4obt458ZvjI4tgbz?=
 =?us-ascii?Q?Brk21e5BZE0kNdJ0uJUQc6AP9Dsw7dTJKDli9aaIAVa/iDmA/L2BcF4S3f9w?=
 =?us-ascii?Q?fR0q+JQldBV1gjmElkPKQEfgNIXgbAXJwn10mUy1+FonHBCb1NTGq1QV50w6?=
 =?us-ascii?Q?obyooynTVpK/4mNDPC6P49V1sOtib38so+p1ewQ8ZBv8latzhj+pISTr36+r?=
 =?us-ascii?Q?M0XIJWpE+r4b0ZRgThJXZWl0zp1Js0j4VaXpo5LF63aKGNRuLtBkyT5UdM4i?=
 =?us-ascii?Q?LMrp6DIFyxvwEHMRfEPTj6qEReJcNX6jngPuJSCPthnZbZUZkppTyBwHFh8B?=
 =?us-ascii?Q?y5ipeJn69ef5Z9IG4mcsJDfo/Ldqo4/Q85Cge7yiu32N2oDNDM0aHqoMg3WR?=
 =?us-ascii?Q?Vq2/CVf9jzp+8LpPiGl0IHjjtw05IS2mDoZtKmEEY0cfzSsagczV42Oo4O3R?=
 =?us-ascii?Q?WYAmh7mcHkH+G7pmhtEAP/y558Vuwi01gAjpm7DGVRXfpWZZzTRGA5P/dWJX?=
 =?us-ascii?Q?mZcp7uArCdpdPGzpRQW1OLEhBiv4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2q5ZgBJEoX79vjqvZy3UWi9+gnkIr6SaLV5uyjZ6siiyMH/M0yJUnu+wFpDN?=
 =?us-ascii?Q?pt6y3uJ5FeLoFzr/Rn0ig8s16q6CiUWoemuIvMKi1F+K1Mz+q4SiYHg8XaYR?=
 =?us-ascii?Q?0JPdlemtjglv7FGKZZgciXVs1ywvb7sV8kveXVhQrRxToUB3cqGEoKoC8Esz?=
 =?us-ascii?Q?9veyyU8h7UnvyKbYDSB027Cb2sx9dD7sKtOyDHdpG4dxEz+dqKaWBY2itzsI?=
 =?us-ascii?Q?DfP7fd7GeXgMqL4Tdk7RP55cxwkKiWKruaSQnDVocnshwKX0jLseKXIHjYps?=
 =?us-ascii?Q?zd8p8pOXNYTloUwwsL+9cpwDkR7Daobi0i6kaMvK+3RiG4ah77/0zQKIRyMZ?=
 =?us-ascii?Q?z5mNxuMArn64WCd64+1F3tQ78ga2/lKgK6ZQcB0B5B5dgJpnrfpuKpcU5gsL?=
 =?us-ascii?Q?lw9CFgSGnt3bO3tBHLeqHrknvug3uht5rZNAMbRoOI+6lIZIZrucUo+rDHjm?=
 =?us-ascii?Q?9FdFn6OZkmZA4ScQosifDZKzU0gafw7BsQ7vj6Ewpz1WJ6U8txDjUE0sVDWe?=
 =?us-ascii?Q?CKxK2edbK6a3/BQiDFpQjHtajIohrVFllQja+OK+abhHwUb6CYL2inbYJi1a?=
 =?us-ascii?Q?cpC/MkAz80fYFIenquvgSR7nSumrR6eoGHJM5c84PSX8FqgXYPzn7kotit+l?=
 =?us-ascii?Q?V/dHIshN9trqL0QsLfryS6XjHFHzpTGL3gEIgnDN5kLu7+/yBJKbZ7kkDOoE?=
 =?us-ascii?Q?lr+2NcXm3G/Tpsz47B71MiNSTUXsfT3NzTRFXM94RzcWvZLcXBs498WVP2Uo?=
 =?us-ascii?Q?rza59OmxvqTN5tZYCEf9Al8937c+KtromDxoNWqc3v+Qz9h8fLSLB2DnDACb?=
 =?us-ascii?Q?rXCC/rdxgyTSFMNVLpinOXEcFlSp0L+T5UuvShQ9ltg4ZLbPSdy2sYmsifkb?=
 =?us-ascii?Q?YEXe8aogA/c6RMEnnnLzzxo0Yoxe0L24oQhuAjiyvOvlAfhwexOAXPz70C13?=
 =?us-ascii?Q?cexGKfHz0PvmatQ1S7LC6NUxkldSzDOl1ruYaeQSd8c8IflBSbv5vsojnCag?=
 =?us-ascii?Q?Lw0JiZeYLB+qWMQb4V/OvswIRBHP2bpNz97PPvKQ1P/jC7u1P1zpDn3rkiJn?=
 =?us-ascii?Q?aM9D5J4y6MhOBE3HRot6XtikNTDosXVgH3X1upwoGPku/nJZyr0JtzBv4bVa?=
 =?us-ascii?Q?CXlWfkP/O4R4DxC5r2CtghWEXI7uArHf1OrEeWDJDxlCZ7PMELchZKqJxDu9?=
 =?us-ascii?Q?w4SR/xhVIVEjabEcziZuJmTtknfa0SImC2rqi0yn9dAzYpWv84dJxXv5twvy?=
 =?us-ascii?Q?kTojtjBh+bCfMk+oa2ovwRvDCje2x7tp68GwlW7BRYHg6PaVbb9DXrx0ss+C?=
 =?us-ascii?Q?btwGZJALYKEkiXmNgWm4kbr6h1EXK4P3y8xjzsahPA4QrVQCIO14MUUwDSPy?=
 =?us-ascii?Q?PvuUrz8z2fMnSlfmt7ZBJTTZnkpVI7ZoU/OVf0hJWhmltV1kKKcTSwamRQt0?=
 =?us-ascii?Q?lrNviHBkDYe5xrS62Xw096U5a1Zel+/g/PwjuyyDpWOsCDnYjvMlgNm5S8DV?=
 =?us-ascii?Q?D64UaHCd6/U4mgtREd7rRVzcCgqJmeK/rc/Av30xhcsQ6U9hqohlaBgFEnlb?=
 =?us-ascii?Q?whWbJEaDB38fTKlmf3gdnJ2pbrm3PDujG4enWXtsJAOndZPG4sPLpMgeX/yr?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hu+z23HXHRk2b1drler9Vb+5lHSNTgM1Dr8DvtcDhkN7pbjss+I/SYr9B83NikEImjyU02ap7UXOIRvtCWPn7CWG88uc31mLhCWkZvhRXOnPfhHPNz5/ICKJKHvrQCpoHSXimO3PVolXz8ngUwXvBsP5g6BwIgkKylSzyYxGdiPtSODXwDF7b79hVpZjlNYfvSsadzzA/5jnjSnkrAAsvcXT5Fthut0Lznuw1xnUDLQYL1aKhzXxK+hFnQHWHWJ2wW0xvl3i9vm6IGczAQVhM7dYnooiaS4Ov0TFCpWKnkk+Gw/oaVygd/9TtmjalJwn3ZNeA+dQLvZNpXc6y/1qzo2fW2ZwOUlmE5INHNkBqlENFPZXhbLkXOTZ7zciWY/d1sNHC6Yk/LXUDwIqqniUgwCWkup3vbmWBCDSU+5LdOPb7kwYu6/jAtusGj9IVCg1gZOzixLkHjU77rsnFeD6qQdO7kaa0wjM8g6SdlsegCZVr5dDbOj8FEl48EJqbz3M1tSGrKuMUtn2an+fHzaYqqyWGUTkpUbsE3y5a+ze/1/mw1avCWFDWZwPFOONv8W8MSFZvc4IgkvSs2zIQCgH1U3QLOz3Nty9F2Z9yk90a/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a183e3b-df1b-4cbf-b57e-08dd2b366574
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:38.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCcwQ5ZvFXFuo5lwnzj2fwa1nQgEbJfhiGMtHVkQBbXnzvN3EssM7ebm2cSLz2uIclMNMy/7dPKMeMR45qbu/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: fti-B7houOccjxpx9_VMsNrCZ_MjE_nY
X-Proofpoint-ORIG-GUID: fti-B7houOccjxpx9_VMsNrCZ_MjE_nY

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Filesystems like ext4 can submit writes in multiples of blocksizes.
But we still can't allow the writes to be split. Hence let's check if
the iomap_length() is same as iter->len or not.

It is the role of the FS to ensure that a single mapping may be created
for an atomic write. The FS will also continue to check size and alignment
legality.

Signed-off-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
jpg: Tweak commit message
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 18c888f0c11f..6510bb5d5a6f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -314,7 +314,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != fs_block_size)
+	if (atomic && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-- 
2.31.1



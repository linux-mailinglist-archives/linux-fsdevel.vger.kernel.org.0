Return-Path: <linux-fsdevel+bounces-66342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CCC1C4B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4A394FBEC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337B2F5484;
	Wed, 29 Oct 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HaCIRQV2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ozXywsM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23F2F2914;
	Wed, 29 Oct 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756690; cv=fail; b=LQYzJ4c/g1LIVsdQHoVdUAxuvr3/EoFqRSYz6GP4WFx6Ixl2pIM3Ro4JcSCnMhGI9h0Uio4U8mBJ84k50Lgazm06v42bEiW+itk22yHjO5II+4s9RjWNqPb/LpTP4M7Q8ecNT8AzKx+oSbyn6GDIyp1/daZcCBOBdnxw3hL5yMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756690; c=relaxed/simple;
	bh=nQIg3PeOPDuy6OLd2zDYcsqTeT17N0N+AUtLt2A0nHU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AUGoCHnE1GnDrYoC6ebzjaPbdrml6W9toWLfMPb0xJ4gRbYYV27lYtAit0fWzrodaA9FCG7G+2P3cEM3m8uypIxGR9WtxbJlOjuiaAcZjn2InazPNB1nePMDRjFw7WtutpmPfaDe0lnDDaP3WrrnuES8mmHfr1jErfdxi2ZnEFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HaCIRQV2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ozXywsM+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfwYH012503;
	Wed, 29 Oct 2025 16:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ly7rvMT6ZO1fAbSz
	//cCni1NYOO1/TKZ57kY0wkEKtU=; b=HaCIRQV2qqlfVsruLK8FOwEX7vEmROuf
	+9KcinKR4l6++PxG6mtDq5FXpR5WIj7uhTdmF1Y+EvBWp7t5zeLflzLbkCgEyFEb
	8KiaqXlWCZLX5nxIJmflIyV0DdTLLhU1GXFrZ7Dh6U4o+Cg2D3PL/4Ew9zOU5MnX
	7eraTJwei/oCmj2QdRyU5qzpwpS5VIyCyP2qsqNwP2+APcc+ZJ7Mq9Q3Gbew2OTV
	ZfXgr8U37SVOm8UMpPeE5gt3Y2jXfMNcUUDnnCUdUm+WOzenJhgqALJbWQ0uoPZa
	WjDp73HsP86WTGjDuIykHxS39ZzXriJ1WhVmCRGoF/VgTk1M9UOM/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3b4w1p41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TFWEZF022996;
	Wed, 29 Oct 2025 16:51:06 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33xyfvr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjZeS7enQ56lxmkB412h053aC/tS6PcJOhHIf4JV8j30AliFlpfYpHxGI0OSruCbas8ZwdDAqZT+5wVRrMItsikM5dUBIyWm56Iryra5+xCKWeSKpgHSSTK8zw3QBikjpej8XVmvNGiZS1lUL5j1Y4dWVpq1iKaCohQID8Caw+gD39gAZBAbTXr18T2w4DNtrU2YG26wULjTv1T9x28VKD/5JwTKBOE5ZagqaAeuGIMD3Xkg3rYx9eQnwDlIEp8AtdYe575MsyHOl8fxP2EsdFHkRiOI1Rl7kUmc9eRpbA+XvwV5sgtTbnZ6yD9gH28Z9vK3qckonyaxL6754bDk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly7rvMT6ZO1fAbSz//cCni1NYOO1/TKZ57kY0wkEKtU=;
 b=QJq+Zlx3Rl5hhifVOeViEz2jrTLVhx8rpc13uDjyhFFM5nU8pZdUsyFyTr2FK2tnpShae7F2uZ++13MnwMw0Ls6ziKPlHWgfjeW5hp3YOpBwEK/DlTuDCHBbS6zgI+78HMz3VhWJ2w7DoOI6FUy+ceFXfrhdwadQ8EtXflb/nHVRFuHHeLzX5ZJhgOIm7QiBNZx+C4VXDYjZXv2TJzQ9UHjiWgh+QxjPaxb+bFEvD0AvWFAMoaLqVRQ43TdhiZ/C4Ioj9pWVGNOroBYM39wEhTG429K8vDmvwSzLQZdvjQjaU1akuc1Oxym0ADTH+EyX2AMdyRmL4rtkgmG7BzzY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly7rvMT6ZO1fAbSz//cCni1NYOO1/TKZ57kY0wkEKtU=;
 b=ozXywsM+8ZDObqqFuas5mSD0Tbc8A6bF+Nn46OcOeoSavo/HUU4841MvvRFKMVBfFMrhSg0Sk4WrEYxojInmDRAWeT1Kt0jCF7+tu7M1/sFnnMuU7Kr7SNGTEv//oK2yGhiD9NBXMM6uz0gNLn8nwbvp5mXBRSHQWPG/ucXcJiA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 16:51:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 16:51:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 0/3] introduce VM_MAYBE_GUARD and make it sticky
Date: Wed, 29 Oct 2025 16:50:30 +0000
Message-ID: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0427.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::31) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf65f2d-92be-43a3-3612-08de170b5736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ukRB1MRkcYeaGYiWqV9Vk56rGx/XpGVVzMXf1v2jl35sEODDm60V1ESWoUg0?=
 =?us-ascii?Q?GMdndil7SUmT7BavSGL8VyqoQyLAjOqVV0obRdQKTRBnefXhI5oISG4gcIgR?=
 =?us-ascii?Q?Olm4/z+H3M/XjkOg9kJwuiIRbo3RKiRsiMpQ0m81crilfGfNZX4/lCO4+NhJ?=
 =?us-ascii?Q?D4J0hr9e+/NYrqPYpfUkEZrRY4Akq6qhcPMsB7Yq9ulfxfV1UXCP+S4HzVKg?=
 =?us-ascii?Q?d8jSpeYFviempTXihjRTXkj0eJEv0Z3nR+p2eZ24LT4gvfllg7ijHZQXzsvZ?=
 =?us-ascii?Q?R5DCkgiqlU4hO2p19v+oMgP02boeR5MQzjvSGgkfVtEfCutNpG2ssZUzrMGy?=
 =?us-ascii?Q?QjDwypAfw+vP6DOncmHTe5GhW8+ZgVkc5E/lq4RwBX5cIs2u3OSBtVLfCFsM?=
 =?us-ascii?Q?pbxyOLvOqHn+2Q9BGIKeMNqGr7VQsCRfTwma8C7Neo+tblckH191Hr5dAben?=
 =?us-ascii?Q?/VtwOyGGbcwECpioobryY4oPT3LB0N5QIZ3QFG6ApZNJiuoPwtnqcq44YMOG?=
 =?us-ascii?Q?q9jRfctXGr4BsGYCh3fnMOWiEOuqj/6LxdmnOm0q7O2S7Im4pRjbLBRQlYCW?=
 =?us-ascii?Q?pnXG3kqXkvjQu4/uJ3WV+sZd+qMU55UJQ3lnnVOI2e/ydM79qG22Ct3Vb21t?=
 =?us-ascii?Q?mvaKV9dpiXXcnk+2dQkY8CfzOuCRqXVY5NjHjyD9zZk0ibTW0lieaRv2XQzF?=
 =?us-ascii?Q?LDDvD6hsirIj02ADumGyAb8sQWFCnM9/PuZssgJ0RopxER5+/M9orQFbx1kc?=
 =?us-ascii?Q?nHssB0zuW3XW/I2a6FzmeG0X8b0HcXAuJFuNP+VrQxVfzTB7ESFKfkIkHRQY?=
 =?us-ascii?Q?KcmXc6cTln79MzT2rA/2n6vygp+hS+hgMz79siqMcn16TuLNh9aZjvKXja0D?=
 =?us-ascii?Q?VBh7X7nALAAZq/h/SPzd/j+eLHR7OM7KS/wqIk4iSq4/Lx+sXB8jh38Ajydm?=
 =?us-ascii?Q?RsOqu0+b9yXHnMxb0hItOuFt0IBEIeoxTA8cmDdpun+G7SURx+Uk6K6VPmdJ?=
 =?us-ascii?Q?v77bPfQRjcZrknl5WvFZ1OBvTsb8FAN5Hg30CDt+Q+DlgqalxUPzNIoLtNZA?=
 =?us-ascii?Q?rtT+hv6xAaKh74XJp9qWrSQLzecFBAFn7BdTvAaWBOcX2kzd6gq4ETL51AXq?=
 =?us-ascii?Q?7m1sYWuppNsB3UzRboEB6G3Y32mMEMSLL4avPQbC6Bw3kFbvLy7dd2tkWPa1?=
 =?us-ascii?Q?E53W3FXfjVc5cNYP1fTuDRnO6Ti6Wbcr1sWcEIeZ1LF+3do7YEGhQti8xYNe?=
 =?us-ascii?Q?AeEOZ+4qbJ5Giy6KfW5EmZaqCXsz2DN3P9dvT2+1ed7HU3IjklUEMJy0lsFA?=
 =?us-ascii?Q?3857Tv+nUGF065RetGsBr7BQhg5q8CyBtyGw9mDIoSzhBBIKLr1glXRX7RLn?=
 =?us-ascii?Q?30scr+5cIRlzR0iA1Kcm1E5DWB9wC759z7pKKGDTI+DVY+E8c3dvj9KUOUAb?=
 =?us-ascii?Q?ISP8O2w3U9m6ak7Il0/C7S43ord+DiDb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAhRjbzqLrzLHkxAsY0KPc3J31psGSWY2GogrMl95rdoFPKmpMkXMv/2MdMR?=
 =?us-ascii?Q?KS4PN0HaONV/mg2psyrv8Wt+new3EfirLAz17LZ4cF8obnKJbF+eNUk0dWie?=
 =?us-ascii?Q?8Jjexl9nOYjYDFJgDytFzs1FTf35cwr3oD8WxONmt+wG+Bb/QT8erK4s7kN0?=
 =?us-ascii?Q?w6BFPrD4lKK7ZBqUJs5DpcYwe/txJKop6pu6mAgE3TQcc7i1Em9vVkjKFiQ+?=
 =?us-ascii?Q?PWO1RBW4JdNBwysULzzGcQpeD7295/Up5zaW2MNgFuhbDvZ9+wT4VoPr0Asj?=
 =?us-ascii?Q?qgGPGq+pnfk2JinKvHPQcDfl2rpZkIrZjVpAD6pxntS2ANUnQQvbFwsoExkr?=
 =?us-ascii?Q?5hCBi1neHIwBLSsPh0RfAraCEoC74NNGbTuFa359MNgEGR4Rk+hqDgh9mHUT?=
 =?us-ascii?Q?6iXZHG/ajLn7qB3fyL4QgTx8WrcDHPBBu5ewtU69DZxl3kSLmyimTbEs7zmc?=
 =?us-ascii?Q?xhOIyhUSEymQq6xEJHAMoW450yrOjJKeicj3SlUW6WSMg/2biQDCr1r+KSG2?=
 =?us-ascii?Q?/EhCH0zl3GCHN/Nd4bYbNBLU6M+K8Mg7ebwuQIm7NxDHzY4/kZar+8lCh9Dj?=
 =?us-ascii?Q?yUHjKve9MlOtkBwwphQtI0O67pK9XxONCO+XQgZRYnFugckRTLSYo3tugDgF?=
 =?us-ascii?Q?Nw0N0Rnc44eTLblhFQZPkLB+sWyQOMzM5GJz6o+ZTBMk3AWhdWyhHR++wuVS?=
 =?us-ascii?Q?JRiHXr8dNcl/cQ8owaWpVt2M1btypFwaWWhQZq91KnPzdYIMsTt2HQMnu8OQ?=
 =?us-ascii?Q?uiTsmZKPjgekfTOgbyrB3xEJX7ILXqZrH6waxiJb3YEG6zkKLUnCbljUzFoc?=
 =?us-ascii?Q?6NkGqUgw+KvUWF6gVzbJB5k2ajn65Kr5JM/9lvMwmDrVy1WnrSfYNghOcACj?=
 =?us-ascii?Q?slbIe9robq/v7fwL1Xuo0IrMahxqJOoftlZYrizu4bbozCfpHM76o73wmOKB?=
 =?us-ascii?Q?/AQpP5F3vHPcEeCTwDe1PKmdki1PATcv/caOSup1Phl+2mgqcRFGvTZ3AeZ9?=
 =?us-ascii?Q?DrMhERSM5QFdOlJ9JWMzP/SvGDJjaUwpasLzKyMsqh/mQyueo4Qj2j5Wrska?=
 =?us-ascii?Q?RfKgCyOeX5qciST9C7JOkohb+XgzTv3AUvipvAeo+SImbjH2W4Xf1Db/kQXN?=
 =?us-ascii?Q?55e/gxtgNwHOOm6WOHYM25HAINQfWqVzHl0hqDj8weTnrR1/913geEXr4TRX?=
 =?us-ascii?Q?U8Z9HaMDSTez+ry0xiXXQGGNDVLujCdcUJvvYAmTVIyFMTUCv7MbrT5eWJU3?=
 =?us-ascii?Q?nMT0A+sq12sWESz0wnbd4a7vY+dpaPLIeRSAs7vKSlSjzZZ6TQJMN0ZEGZ+p?=
 =?us-ascii?Q?XlDyKj3jsGnuu5L4GUFrIF2PpLZ1G4DLUgAPrGKhYKVyiAo7zs4x39DIlUss?=
 =?us-ascii?Q?c13MfS3cTPkavq0dzvZE33LwgD3qfZvvsC/V3DmfYBmXMRHqKkfCCrpCk7bE?=
 =?us-ascii?Q?jmg1P+vb3Ywezw0Jn1MKrVmoii2ZeVYouTA51L4fuBkji+tMaVB0tuAFbE7H?=
 =?us-ascii?Q?4MsxyavHe+urZCDQT8ag8KJPlPdsYe3szeR5G9lab8lgTttNSR/QzVL+04ao?=
 =?us-ascii?Q?zPC/RkJtQTD02E7U/S9/9o03/gtCJ8gnhTMZ57XzM9JNFcICo3uPDRu9Uufr?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V06g2CwrJNiOZnOG+359JdFtdFC81xKCWkF4+Ydt+7MZrOllwwiMRkQ3USBj3KVvcmEBrVksvNWTzmOSQOr+8TuZM26iw15sQxMV3MQFmFSU7T5wudqqIDM0/gOa7hVoBFJ8LjfdhvNC+FDdw3q4WSW+J+yebhQF2EDq/tm4RHcU019kQEsk1pZuPBu9qktjVUu57KA2zYKbxLHNy9D2GbpP6Nd/jde3zhKKKlNFKYl+Ny/ax43fUuoh9p0vVD221+KtR9rzumlacIeSXSzrf3tWcGf9mX15LGiRVsw8Mlrn85iDXgCdhrGPPGfnMk2aJ+bhnzSI3Sw/5C+rpqyjrdWhnEpy+mw4FQg6XSbgHBTmb94O9XEAB3F39C1yXC5q6eFAHHrO1uJZOjJ2Zm9jCsN1FbW/Vh0Aw9O9OcbOh6HXnxEJ5wbJc8gnHVvT7PXvW35nPvBHAdV3HBEmftZfoFtv24MR8b953WZi22Ic31wKKoAIhVB2ZJzb9zSPLfH66KoBHx0ljZC4z8Mq+IGHmQfXtc7KI04IgbZfunpx9sQMACKKdUQJ5Kfz8JNtfhDfzthRg4JGxg7bfL4SV0oyIN4WuEJWrzXmdr9YAuxghww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf65f2d-92be-43a3-3612-08de170b5736
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:51:00.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1x0FVH2l7r9G04LMsgbWvQjzbPqMWsH7JWSRZ8mkArbWwXv5rfq0Kkx/DFHTsNzsdOPsGPISHZwVJZJPeJNbDlRF/VELCqNqoWJpfKnoj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290133
X-Authority-Analysis: v=2.4 cv=R9YO2NRX c=1 sm=1 tr=0 ts=690245fb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=_-iHkvAjI3e40l1ULnEA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyNiBTYWx0ZWRfX+N1HxVr276Am
 oSNVAhYd9eauLXjo2EljVZIMIDISCEKPFrHz9NxWPLbq4TLy2pCiWy65KgyjViFjhCwqtIfrAgK
 e81536mPvRXk/SSG6Pp98tVHGIHLqvBOMzILUUgkCDk8PQ8PC3PqW+4+D36FR4wXLDO1elwcFlN
 Y107+yAWzmuYDbiuQtnGvUDmDPyofN0WkgUVEmnOvM4WS1ZrXCCI1Erg9ffJikg6DNSi3osS1v9
 ReuQrMMD0zp1C8qt4PFCvozf1gZenbfsJVdfkvnq2b9A1Sy4lR+bASh9ndrEMvLj7SPgEnxBhnC
 t2TWJ7+Z4N0TByaO7FzQ0jl28zMLzzcqEM2bR3cTIzt5tTfYi6xMXRbmRApk940sxAFkjl27hxd
 SiBXvQlAKiWayViGRdXHnJggNP94XQ==
X-Proofpoint-ORIG-GUID: wONaKkuDG7YUwffc7T8G3koFzKSYYv8v
X-Proofpoint-GUID: wONaKkuDG7YUwffc7T8G3koFzKSYYv8v

Currently, guard regions are not visible to users except through
/proc/$pid/pagemap, with no explicit visibility at the VMA level.

This makes the feature less useful, as it isn't entirely apparent which
VMAs may have these entries present, especially when performing actions
which walk through memory regions such as those performed by CRIU.

This series addresses this issue by introducing the VM_MAYBE_GUARD flag
which fulfils this role, updating the smaps logic to display an entry for
these.

The semantics of this flag are that a guard region MAY be present if set
(we cannot be sure, as we can't efficiently track whether an
MADV_GUARD_REMOVE finally removes all the guard regions in a VMA) - but if
not set the VMA definitely does NOT have any guard regions present.

It's problematic to establish this flag without further action, because
that means that VMAs with guard regions in them become non-mergeable with
adjacent VMAs for no especially good reason.

To work around this, this series also introduces the concept of 'sticky'
VMA flags - that is flags which:

a. if set in one VMA and not in another still permit those VMAs to be
   merged (if otherwise compatible).

b. When they are merged, the resultant VMA must have the flag set.

The VMA logic is updated to propagate these flags correctly.

Additionally, VM_MAYBE_GUARD being an explicit VMA flag allows us to solve
an issue with file-backed guard regions - previously these established an
anon_vma object for file-backed mappings solely to have vma_needs_copy()
correctly propagate guard region mappings to child processes.

We introduce a new flag alias VM_COPY_ON_FORK (which currently only
specifies VM_MAYBE_GUARD) and update vma_needs_copy() to check explicitly
for this flag and to copy page tables if it is present, which resolves this
issue.

Finally we introduce extensive VMA userland tests to assert that the sticky
VMA logic behaves correctly as well as guard region self tests to assert
that smaps visibility is correctly implemented.

Lorenzo Stoakes (3):
  mm: introduce VM_MAYBE_GUARD and make visible for guard regions
  mm: implement sticky, copy on fork VMA flags
  selftests/mm/guard-regions: add smaps visibility test

 Documentation/filesystems/proc.rst         |   1 +
 fs/proc/task_mmu.c                         |   1 +
 include/linux/mm.h                         |  33 ++++++
 include/trace/events/mmflags.h             |   1 +
 mm/madvise.c                               |  22 ++--
 mm/memory.c                                |   3 +
 mm/vma.c                                   |  22 ++--
 tools/testing/selftests/mm/guard-regions.c | 120 +++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c       |   5 +
 tools/testing/selftests/mm/vm_util.h       |   1 +
 tools/testing/vma/vma.c                    |  89 +++++++++++++--
 tools/testing/vma/vma_internal.h           |  33 ++++++
 12 files changed, 303 insertions(+), 28 deletions(-)

--
2.51.0


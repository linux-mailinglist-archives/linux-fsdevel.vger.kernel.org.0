Return-Path: <linux-fsdevel+bounces-20660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575F48D66EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C67028C107
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7910B176AC0;
	Fri, 31 May 2024 16:33:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0C1649D1;
	Fri, 31 May 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173215; cv=fail; b=OiKWo2XZ3W7BwofuBP+hpACn5KMfZQk4RH0IeTFrgwolYun4cxtAJmPdVbLk+0k/Hz/aFKuC+7TIrjduqrZeZrpS7Pxw5UilS6R4i3ao/BgHCweW24sxB+mZWTxPHPbauPdm5WTlaoKOwLUcGLpG8X/Btpu0WB2mbsKyGKwrPk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173215; c=relaxed/simple;
	bh=Co/pl70fYMu2sj7o1fDOxN5OoHkk0lAPZRamHbaBOZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oX9kiOaUq5Rfu/7GZGRj70XNGJ4Dc16IKC+xk2HeEcT66Etdh2mG464mAWB5CemjiW750NA1QlMue1RbgKYyWvhLmcyjN88jSWcYbKm5E0/bRAJNJ1gBEHcYrLALkc40gw4+gFha7mc5D3HqMcy+DrqwIxAsySaqxyqncZ96mcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9T95H006927;
	Fri, 31 May 2024 16:33:20 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D377W4Om/B0uMZ6r68PRB5C4y7gbR0BZHCpVT9AmPfiA=3D;_b?=
 =?UTF-8?Q?=3DNc5BWX3ZqaFj9IcP94zLjvBXkGxszs40HZHHCcHP8+Axn1d1y+XJ5o9hugPv?=
 =?UTF-8?Q?H0rOy8kt_JoTTBab46XbuN80mw8cC/UvI7RE5z7Ayo7RvRZhYjZkBmQCJG22+DV?=
 =?UTF-8?Q?DYySHASrmYfw5j_G7bPitQLU3B/KwJDyGvYm+CeihS0AmAuCQpI1XKWbBLknRf+?=
 =?UTF-8?Q?bGg3MhVx6wq1q6WeMmN2_XCyxg3pG4+mqhv6bMNXB+G4DPJEj2RtpzFKH+bW9gH?=
 =?UTF-8?Q?ID4CoON9Ey5HOzd3L0hU/Qj6kc_aIKF00mIobiFjg9SWCuDacQM+2+tnJagmPVD?=
 =?UTF-8?Q?ogbYamE4qx/yAumTqgWt7vU3SvNivEXL_HQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9urhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFaLYb006199;
	Fri, 31 May 2024 16:33:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c8kmkf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2VW0eyokTJJ13ulzssSpElTKSnd/MDL86qKxoE0peNuSsSwWKM9Z2FX+s2ZxnNG/1HZHc4tk4TpBdzJSbUxTxJfFXAXlIansBbao7uPwymsuSCPMds0Kk/r6SIZnQNY3ZKu6nQphjzOyaveYP8vi3wITqSOSLlWHHHUGvMFUlYEDArMqFly6ksOU/5VTpYn7N9RNyzT60D3BWqg8W9dHAvnDXrDscQwznFbT4i3o2N2G+ML/odKRk/tCf14g+J1TZ7tBfrB+2HCDbA83RNYHvXpH8+kSwDaag65BCP/n/r3EBf1L27o3MrAiRZW2vCumgbMDmbyxhwB37xTYQqH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=377W4Om/B0uMZ6r68PRB5C4y7gbR0BZHCpVT9AmPfiA=;
 b=ZRrMZ0JynuzPfaa2UWEibn6s3n0Bd9S1kHHPeBVgyBNXm71pwEah46NvE/39gKXSDWLqOH1aU8fDJBcngjigYsKseRamDv8CFDooJyhtnssb15YjphjIEQhSCrEsFfH2/xmqEPQkm3L6X1lpkayI8gsr3nuy6bJQyikYBPnaoIfQJsZvdpBEoHo3gGJuGhW33nL4Dkyb8eMAv41X19toPrEnMY5uSRE0COZtsC3Ub0G3VWfP4D/BIspLcmn7zh2by4+HuV+VJbGMwkV2QPO1/VDo6tpgnq1J37oAAj0uXapwSZWr0/tLlt7AYBT6APJuSH6WaF55GNaTx9BS3CA4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=377W4Om/B0uMZ6r68PRB5C4y7gbR0BZHCpVT9AmPfiA=;
 b=WPLVunZgPnwGGg/LC9X1PtOyaZBUpSHn6Y+yD66UfdTrPtZxEwh9u3Vp9C/A80wo+6WViFxMVYkbyi2RYfmgHageV58UkBytrLmOej01cb90xzjDFjU08Tw0yiGpe6e4Vka6ddzmMrVHKp2VvpWAYG7/yBd25eVPUKKo2NbrQ88=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:32:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:32:48 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] mm/mmap: Introduce vma_munmap_struct for use in munmap operations
Date: Fri, 31 May 2024 12:32:15 -0400
Message-ID: <20240531163217.1584450-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0436.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::8) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ae8b52-7eeb-478e-c1a3-08dc818f4efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+JN2XF8F2r3p9g/1Xx/JsLr+MMuRyXHU5gZUF2soCPhpaz+Y1DgZ6Z22ApKB?=
 =?us-ascii?Q?Oz7pKssgUO6dPqRwKv/hPAdYWDU5LbO7DUmTKfAoPPuOfKLG662foxVQ6BqT?=
 =?us-ascii?Q?TtQ5Si2n1EnWSS1j5Bmgt6fC5kT9Zads53JUDbO/qRJgu9W9WFmGsGt99H54?=
 =?us-ascii?Q?iwgqu9R7NANCuQOgCmb0QrkoJZNUv1NN12erH4jzEbSJGdNj/ozZC8SOaxtn?=
 =?us-ascii?Q?8Jyyn32ge9IpFreBOzeJZkmARR1U61W+lh+RrWgYPdYAZYVgEq7VJs61ePIf?=
 =?us-ascii?Q?6liYj+DeYM8YhKmXdDVuVqi1BcmILSMf9taLL0E6KKUalgwVRIZjFokOorQc?=
 =?us-ascii?Q?lZMmvMIaFj/N3jM7outXUVKZ3cv2z3GuRLKUrYHficsx5fAzgHlFjHYsQt1a?=
 =?us-ascii?Q?ciuMpOasxmqiPUpKG2KmVEVwhJRz+BIA+IHlP4zLRWcLF80lrKiV9fUmqXaS?=
 =?us-ascii?Q?MWsdS+J8Afpd6LaSn8AUcrpPFfBG2T4o3hXCZ6vnVLlNiVqgD50jdt1gTu5u?=
 =?us-ascii?Q?SmPBe8ANBlon4vfJ/IaGNiFms4iZYORd47eBXl4+szfeWLaCGNKPL1qqnOUJ?=
 =?us-ascii?Q?Sglhd1ye9fC+a+n9zI0yrO2c7vM+dNexgDkgR/gMWS7TVnQ8gnI/k00SN6T3?=
 =?us-ascii?Q?vyXzpsKYGWJyo+JKsYe/+SHDIiJ8hmBViAwBuDxQyErL+nIgKaBZXmpscIFW?=
 =?us-ascii?Q?MKUB/j2zPlHIuSCANvd4KPFeRZSwkOusN+TkgGJ4Ye5NwcmA6f8618b2OQ2F?=
 =?us-ascii?Q?ZHF5YuOAD5QrZa2PrdM/qxP9EZFLcP5yVMa9WfZtGT1c5jvKxyX+Lm5csq6P?=
 =?us-ascii?Q?MEASFz/dXzbsi5jLGkg7lienTpvp2JjtqP3CB5YVdUwKPPgzixhyNGw37API?=
 =?us-ascii?Q?gRYH6J7AfptLuqLuzjg56Bd09odO28WVkFHbdLO1LvxtjoO6lta1x8Vp7x9i?=
 =?us-ascii?Q?3FqB1frY7uKpIJeFamtnD8n3tX7z1MZjo+M9yJLYPns09ZYR3C3pyNodTbEa?=
 =?us-ascii?Q?IkszPtgSM/LnuFJ6BXSpniFl0TYlB14B2EfrOnvHlhZEd+169hx87tl+Bzwr?=
 =?us-ascii?Q?vjX7DLsBYpxawr8U9NV4NbtyCg9Zpde9sPMsnmHV+l8+DHhqTnOUngyYT+rS?=
 =?us-ascii?Q?w4IuXJvaN65r7k2rIOkYRtwTLAgYctsb0ymdXYeBDQlPvL22PH7PZtFWLVBa?=
 =?us-ascii?Q?2Qq44wVfHL77MuVSg4S1Fh/SBuUzeC1ghAJ7sX6MXlkIknCp7F9qMt3qBVyW?=
 =?us-ascii?Q?/luAQ1f8Z6H+V8Gh0EEQh4HDX1LfGxK05mZVpWHObw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n27W3g7Eiil5kPYrS2vQaMj4H48E+87bHEpAZ5Kawd0u3AahCvkrbhc6/sKk?=
 =?us-ascii?Q?OOoF9I03XbjM18q1u4fLfhSgH4IwDPzOmB0p9SC8huTERKWknfb8ukJE7BQA?=
 =?us-ascii?Q?EPXamidxB54gl+Ex1D28iq0FhOMUIyRm9OJ3KrM9239khe3qCpJ8C7t961KH?=
 =?us-ascii?Q?C+bJPBB9g7aMCMPfn5OBk3p10ttAXWXDerPP8MXtPwHQ6lVe+6dCUkfT45tf?=
 =?us-ascii?Q?hdjcBMuXcYGxFC/4hR4xsWPEv4avbqGMZ4aIo/SWJkdpgr1GeO97+KpkFWUG?=
 =?us-ascii?Q?jozC3eoQvzgq/dTSM5mt2zg1qW9Y/+6yJa5Zg57w/Ahwz/IO89LvK8SDPaYK?=
 =?us-ascii?Q?bJ7l+fIlh1XyUixUucu6DS97QJEx1AlagVQ+8MEvEO6qoMdUjzwynJCN77Yg?=
 =?us-ascii?Q?hOngUxP7UZ34Ju9bb2JYaBLrNRkWVvCltdTVLDnRxVnzNxA168XVN+CHh/Td?=
 =?us-ascii?Q?XseQvbF56q6dy7MssirYLy5pQvaCxfGihH1gkItUyeMfs9GX2KKUabRL7e4Q?=
 =?us-ascii?Q?yWAN0/XPINQBnYAqK08MrUjj+lK2ItxDDFCO7zpcUlrb41JPgXWRowonj/hD?=
 =?us-ascii?Q?nwvjTPpFgseqDb/mPbc515cqt3xN/UYetzF5S1Rh10gXGCzsuz9F4s7GXeIa?=
 =?us-ascii?Q?XiF5bac2uxWEjlqIvoJeB+wHcFAl4qpS6fGSNudaISNk6XMVC2i58QMAw2sM?=
 =?us-ascii?Q?sKNFehoczsBO1XPxBreOHi+2AGYK3K3hLBBhz1jKA/bKF0KwuACdS3mH8GPe?=
 =?us-ascii?Q?wNqLYUC4cyoh2WA35+4etfRtS7Zue60/B2vYPl4MW+z8YznFCVhsN+OewqpV?=
 =?us-ascii?Q?0eErVV81Tbfrj6Nro+t6Ed1tyfAkxowxbCNMli25LKjP/veeCc+LTvXROrge?=
 =?us-ascii?Q?+0MZoBOY9IfIOQzk9uMsGNRuna1IVW2NKuObX8i3eL5EuQhyiC+KuQ37D/4O?=
 =?us-ascii?Q?bvDIWs9qCrwdTaKDNxaCtVlNrBKi4jRNLmb7BHnfDISbGfDzCTknmQnzwFiU?=
 =?us-ascii?Q?tjlwFS+yVze6rp0vRCmrgNgAYRxag72iZVx3Ng/gjKDHedjYmMbkuI1YiQc5?=
 =?us-ascii?Q?mlOpdc8qeI6YDPyGuAyy81fFvDi/cDKBNIK239DCp2u5VDoaFW1gXF2epNsA?=
 =?us-ascii?Q?dRpje4GnfERpf8QpVKEQWZlHYQxpBqOySuFWVwuOz1WxAE4W06OH0+qnF/Vo?=
 =?us-ascii?Q?hydoFQUWOvuxYvpHGrO3CRDjoGMjLSw7wsFDvVv7pNQZgR700tUvOXjI9kRd?=
 =?us-ascii?Q?rizb5OuIyAaOiVZrAPrLJ6pLct37mnsi1JlUwjoM7iLHj/rPHM9YI8p6CfwM?=
 =?us-ascii?Q?xxWEkLCqi6Dak612Z425oJMiXCsH/+nyKd2Q1MOlmqL9R7CPjWQM7AgFqAoX?=
 =?us-ascii?Q?zBjAth9i0dqr1yxUOwMwIzgAoYd3nB8ThmCGjlx1+FhhVR0Mpv6/nsstOxU1?=
 =?us-ascii?Q?eMsu9JVjCbg2SfYQo4WGYryp6SWGBjk3KobsqT1PQmq3LX34UqYOTd6rOwuh?=
 =?us-ascii?Q?O35duFiiAFxq7iPqNykv65MuBDOhTdGzl+HutSaSU5WnVg4xB+Ml9BuJKXYn?=
 =?us-ascii?Q?PfXMIoxrWNV4i8clC7c4tescVqPhH489olUmQYoA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OLS7ICUOL3wQeweKR8PBFPeYcMwNP+gZuUkPPT6ZTudBKpDwvEjF8JSwpwLqlfe3hiP4YdXu59ICsYT9InimNTgu9g8Fdt5rB8kTa+f0djF5Nr7EuQEEOnVMwTSZf026+eAPeTVWRZ/c4eNMw5Sf15ZWwqryzqfyByOLb9MXOphGzoDFo9T5JmCmTalQ/wMjQokkXsqIWqcBQ3vMj3ZTDEfMuaPtZrbVO27hTTE0THmkUtj9MWFtUeGMsVII8eU4qq1ehhZ+oCk77uiLtVWfmGj/lQ6XRHHsccgjlqlTHK5p03FH7wg9k5YCSdNqKsn2va3TyvA3qHZXf7ykQ2Y1k1+xDfdzjjdApvtnguWcRcF+XBKNJAy95L9S4+nhKAhThQDXkHitaeqn1u1Xn4lnhFFTnZEDPUJBkJGcr0zeRv/k+8xnCZVRyEdFP8/+dKNfuy9lAd4HMsczVm/L/7v3LWaZBUHk8kr34OnCpc2TYJuRDrU+/lwzlgC3hmIyq5vwgGh9gpSqvmsIldY9tNVcUOkdOS+xyT5Ft1LWKA5EmqiAcZuwewnpa+Bm+yibkHW5q8wcXQubQn4uMLWK68LfitNXMHaf2PqNQ81jGnyj52Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ae8b52-7eeb-478e-c1a3-08dc818f4efd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:32:48.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR0D2Oeu1t71C3gBCiKE0QnXptzfLzc6zVYLK0KBWId7pQ30ZdULmcgRIMObgNqqj5frYzBhZ8NYEszM72rZ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310125
X-Proofpoint-GUID: lkIdZBPl9AUwRW4GLUKwWtsXNxBc3z4T
X-Proofpoint-ORIG-GUID: lkIdZBPl9AUwRW4GLUKwWtsXNxBc3z4T

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  16 ++++++
 mm/mmap.c     | 133 +++++++++++++++++++++++++++++---------------------
 2 files changed, 94 insertions(+), 55 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..6ebf77853d68 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1428,6 +1428,22 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct list_head *uf;		/* Userfaultfd list_head */
+	unsigned long start;		/* Aligned start addr */
+	unsigned long end;		/* Aligned end addr */
+	int vma_count;			/* Number of vmas that will be removed */
+	unsigned long nr_pages;		/* Number of pages being removed */
+	unsigned long locked_vm;	/* Number of locked pages */
+	bool unlock;			/* Unlock after the munmap */
+};
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index fad40d604c64..57f2383245ea 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -459,6 +459,31 @@ static inline void init_vma_prep(struct vma_prepare *vp,
 	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = 0;
+}
 
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to altering
@@ -2340,7 +2365,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += nrpages;
-
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
 		remove_vma(vma, false);
 	}
@@ -2562,29 +2586,20 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
 	int error = -ENOMEM;
-	int count = 0;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2595,17 +2610,18 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -2614,24 +2630,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -2641,16 +2657,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2659,21 +2676,21 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
@@ -2686,38 +2703,44 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return error;
 }
 
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start,
-		unsigned long end, bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+/*
+ * vmi_complete_munmap_vmas() - Update mm counters, unlock if directed, and free
+ * all VMA resources.
+ *
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
+ *
+ */
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
@@ -2746,11 +2769,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -2758,8 +2782,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (error)
 		goto clear_area_failed;
 
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
 clear_area_failed:
-- 
2.43.0



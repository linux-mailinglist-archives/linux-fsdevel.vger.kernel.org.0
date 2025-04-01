Return-Path: <linux-fsdevel+bounces-45410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A2A77331
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 06:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475823ADC7A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 04:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFEC1D2F53;
	Tue,  1 Apr 2025 04:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VT3/EBiF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ikSNNO7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB67FBA2;
	Tue,  1 Apr 2025 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743480218; cv=fail; b=kekoD5ud2xz7qbWmxWmvk75AP81ZlmZ7VMbCNKtSEBZBds7umfwmDnni1g+h+e+mFtv4J771o9/Gv1TWlflhGbq7tsILtTFS6vetlYA+0sBFLfcviR2OTNgkRx8UIY37q4Wdlw/wkcb1LfSPhc9quiaoH25WQqSr5gjy8LSUq4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743480218; c=relaxed/simple;
	bh=ftLAUzutnFZ0X15/nVmLMqJ8FL7sGDa2UXNClqdcKqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W9EwrDHWMj4+HAyH7l64PtG2CHrvZCzZj3aPSFUvwLJm5H2+hAu3a6rrAiIemSdIIGYj0ob+857qMnVu/VvaQbHcglKHT+JZ+4vVrKUoaV8vU9BPTzwA6lZJGkYhEdSM3hDVabG561v3931b0PigvzxTKBeavWw7h+QhZSOLDGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VT3/EBiF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ikSNNO7e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5312vwUR019958;
	Tue, 1 Apr 2025 04:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KYjfG15IwmrFPszd9I
	5mF/AFQpZ4a1wM3L04TacOT6Y=; b=VT3/EBiFXUzraQOnyK8w1p6HbpSYS6uz90
	wtjVZ7JZ+qT8pAyp/CnHNMPfQaaCx/YeQkSGq1vwCBIbfJUC5zh06FaCO7LI0MhP
	VQSlSIK+HL9Y86se22pDk0JbX3OpmfjwKNgoNqUCXjqgDzBVJsdCQCvH4KupijhA
	mFnf1CQRUpQQajuAwlQbY4/GmCm3IsJGO63Rw5SPhMeurGnItdGUCS7a9YY6akAY
	J7UaKQtG0SHSpoJcqVYmxQ8H8HKJIr0dwS8MGvD1ypVxYqosiDT7eiWaY60W2in2
	s1Q9GQ/TTsgaGG1pJQnelCmajwu7x4C7wSiJWZPjrmEOWprrfhBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs5c99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 04:02:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5312fvMS010747;
	Tue, 1 Apr 2025 04:02:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45p7aervfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 04:02:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH5s/1b/qNB7oSD5TzQNM4JAWtIgQ7FXnuYWrwN0Rjc9eDauxg/691TUU9J9Z00Wyd9tOD6H+ze8EZe9Bwpp7rTqvKs3OhFT+8Tjbr3rmk4l+87ng6UwmHGeqE67/yNnBfi8pHYv+8bHFthLGjCQgF4Yq8QxrXHZE3KnwZo+kjbi3VXrSNAoaGDjwYhy6BTFkwMqTNp6OjKPuoGAe554tpuuSFtnctWEGtsinusVt+4WsuW4XqNp8bCtBMiowrJIKtXsxGZSOBiPpiO1rN5kZZpHcmjgv1bpfGCH4lG1fnnBxaBgDwGat2vsEvK1PGIr4gJcRveCwJgogP8hDWSASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYjfG15IwmrFPszd9I5mF/AFQpZ4a1wM3L04TacOT6Y=;
 b=VNd78IASagqkg+Yi+mWTEcvsghRD0CJ7iAEhhCK5DUo+fA7teV8eFItffLEFuFEl+hvOLbCSiikTlYkMtl1KIavljfME10jzznri/yFPB0fO1neBYdKDDkwc2LK9MGRNCWNl2TLYgsBJuJjJRs2wl/hTq4MkVf/sy0itUXGkJXhA0do+Ss+pjyWRsyx0TiBLq7IShQHpPJo1X+S8ctdgIP090aaFEDScfM8FCPIMmXKI4cJFNyeI7dm6mygw/4J/4jfKPRnpSoXGXysN1tSl+DE4cZxa82+GRYhs/T1gvxpc1BIIAK4h319iVhJNun86O71Tiq/1LYCnT/jUZmJ+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYjfG15IwmrFPszd9I5mF/AFQpZ4a1wM3L04TacOT6Y=;
 b=ikSNNO7e0kFidFtWDar3ZUsR945XsM6NiqdQLN/kik1kjhgXuROuApuAPgX6v1B3KsLhbvcTakOOHkKTB09KNZbdEKOIVb2zx0kuuwn/iH2LfFlR/S42IJHH2WUKcVkXaU47Pm4ySdfaF/4LpoENk6dQoiumCCn5EC/8HvIItgU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA3PR10MB7072.namprd10.prod.outlook.com (2603:10b6:806:31d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.36; Tue, 1 Apr
 2025 04:02:42 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 04:02:42 +0000
Date: Tue, 1 Apr 2025 13:02:30 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
        laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
        mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
        david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
        ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
        mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
Message-ID: <Z-tlVsM2Dq70gC4r@harry>
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-2-bhupesh@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331121820.455916-2-bhupesh@igalia.com>
X-ClientProxiedBy: SE2P216CA0127.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA3PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c85e9ac-fa97-4cf7-671f-08dd70d20cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3o75kBK3YUU8vn01NhyAc/FQLWmwLynRPOfPH9X18PULL1JKEZEEFKhujFD?=
 =?us-ascii?Q?YihZOvz5QdXxiR6fesLCWDlx5rjQemgvEEvHsguRxNHkaltomoY3s56b0vCA?=
 =?us-ascii?Q?ZmJmbA0YbmycJxb3e+KUt0f/fZ9sP5RYBT8piqoGeTkBNx6uo2kA3In9SG+9?=
 =?us-ascii?Q?MzV2U5sQTWcNZDs/uZ2wbzd5+7IhpfwcVpgEwFuED3YmOHlMvsnxMz/x/DjA?=
 =?us-ascii?Q?46fa3sRkt0O7vYKklrHofmyTwqi0YL3THutTMuUXOhZ4tnkwP0Usmh4fW4HU?=
 =?us-ascii?Q?ra7L+jBpNNaCuDM0mT+esznPBJEemUT61Qo+zJKqI564AfKSIXly7DqP3+iw?=
 =?us-ascii?Q?mdIVWKNZrIh8bvHwW7jR0tf1VcUgOXZP2EBhchxUQkxupsMhVn7f0ueTSO5L?=
 =?us-ascii?Q?JAhOp3D+FazJOQMN3RSMuZrm8NCDsRrTybwD1MPPhmRR5g9DAGu39rDSQ1xb?=
 =?us-ascii?Q?kCUlwdLBzkBfYF6mAyNfy45yjo6b9eaKK8UG04cJMu2gbwdSlJS24M4fADlS?=
 =?us-ascii?Q?G+XbKMidE7qmjee+SjM8pblJ3GSfcJ+X2H+t45bKvd1agq1e61GxkaqwA5as?=
 =?us-ascii?Q?/chB7hSgjE+nwD48og0o1V41p0xMF89T3YuJbzhqTqpPHhZIL9u6mvziWd9r?=
 =?us-ascii?Q?foqtDLRDSk70t8CKyGSTdFFAQf/LjaKElPYQQ4vxGEKev1zyEMDbf6cXG8Ew?=
 =?us-ascii?Q?cJ4lrq2kpB+BW+raDKdRcLTq3MOUhABYd8uhOz1EiuQQEZJ24EfbjrkTMPCz?=
 =?us-ascii?Q?OTDygjLCUVhLbs1TqE3xX3sp+0hbulpVcWPf94C7nXopRlocjfijjavKxrPR?=
 =?us-ascii?Q?aLL3TQg+mYXjPlQVae5e8kMQmxr1xAWX6lb59Gdtj4ptxZm3vjQ9BSeh9Ud5?=
 =?us-ascii?Q?B92Ke+p3ZVV+r/0NOLq4dDL+dTAW269WF0ig1vnT1S0f5yLAtI33GktPiq7+?=
 =?us-ascii?Q?g9hSkBHBg5knJ76ixfZOrhQddQwkHsoqdtPjOgMJZjNNOa4pvkPclNCrUPSb?=
 =?us-ascii?Q?PZ895Rf2IKBFBxLTJohtzpIeVD1mIl176M/FORLA7a1Biv+hukpg88SBdvRl?=
 =?us-ascii?Q?Hjd7tfpwguDLJjbher/qMCycZ4bN1+Cxx+simpb8vDSF61HMvM/EEtxjXWK2?=
 =?us-ascii?Q?+qswuujBbU7/b2m4Vtbzjh7nm9A75z+HJpR4lkhbtPBp1+GCn5qjVu8J+iIc?=
 =?us-ascii?Q?htUkE9vpF7jGGzjXCfrqs/DtgZy1AbHTdbTJulVDIGQsuryStVjYEf0BQlG9?=
 =?us-ascii?Q?IDDjVOehQoLIlarQCHJe+F5sxxw2xhv/g9GRtpxTX6NoJTTNZpyH895rdCJQ?=
 =?us-ascii?Q?kSxvDdf0H3V2RGp/vWVmcUmV9EE+11lqN0907aewxFG4slbxeQnWCv6W7+FB?=
 =?us-ascii?Q?/EW7RgeYUDJKZ82dxPAxjtnnITa9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmybC5xnbWRDjEiCIJW35OxtiyONWKQrFPvryaz5RktXfFhkoZIL3o3Eo+5C?=
 =?us-ascii?Q?b7U85TjvlvyQLEMTMKZbHiGfui8x7Hi6aqCFtwV0PdHu6OvJkWTMKk2XQY+S?=
 =?us-ascii?Q?3wyGIvt2haqFtlvIAro97JSrvTGMsewx98I/ly/XpQuiYaLeC4O1GGhV3G4x?=
 =?us-ascii?Q?z2GRZEcvCePn2GWreEaZsbVxf9VD59uV9pffS74590+3aciK7puL2W5pu/7t?=
 =?us-ascii?Q?fdRPQQh7FevGt3B6p42rL0JsQylOIJLomfzYLhbjyZeNnG29Yv0Yaqn5+KCv?=
 =?us-ascii?Q?3vQcfrWSCDoq8w+jwHsSylx7CcEmLPtjaWBJi2ZWnVHGOibb8FQoQeyYOSQw?=
 =?us-ascii?Q?65c30wcXoBnfmIIG0ralTTVaXlWSilBk/R/Jnyo2LHP1Z0KQUc43tyN2Fm0D?=
 =?us-ascii?Q?gOiOs6HLT85g3Ort5pyIdUc4u+JXT9sZaxxfegvb757XUA+lxb8p18vtYxgs?=
 =?us-ascii?Q?iWo960mdzZNiSz2Wn3MBNv4ttaCaFesqeZgrfrA+J/CLDSeu80HWgNvD8B6G?=
 =?us-ascii?Q?viH33JkQ4LxxTu3suoUnzi1x5F4wOMpeAz58kDRuryRDyTPA8AOxMDjXZJse?=
 =?us-ascii?Q?H5acSImm6Vx5gPXSGgeFqMXJEus+7ryTopcGAlS05o014QryU55I9r8hsw3V?=
 =?us-ascii?Q?3jvwebNnEeyEnvYwdyudQV3c2UBKBDSphl3CU/mwFwPVgdIIFnyRqJZmygU/?=
 =?us-ascii?Q?U3aiRDIqXRkUALE/7q64a+Z/E+d35ry9ehANR9lSb4hv5UWmfodOSJtogFJp?=
 =?us-ascii?Q?7+6igi6V9unqCHNr+yyzUDwOQk74ClrnWugxLZ01TtLQzDnn4JAJk4PAVHaf?=
 =?us-ascii?Q?7XMFJkSE5hDcmh+BCKkIStsAf23+Nwe0uoEnoJ+wb/3EgHHqTHbXKLW3eGzC?=
 =?us-ascii?Q?ZI5RpWDK7TztlqEuurnQJ+D5Mf2NdEayZ/AQFdVd1AGulRkPnn3dXdpn0/P+?=
 =?us-ascii?Q?5ySK6bR6puX55SoH5g7nuPkz61jX7twgFrM+y/4IzANdVjXKdbD7Ur0lv3sj?=
 =?us-ascii?Q?WWI6b3/4UBGA/dPloNdXODUiOl7xp16FCVl+svgoe1e0Qz+nhOWrcdQgK7u7?=
 =?us-ascii?Q?IlXUxJrUV9xydbqYVLE5BdO5q8kAL2xun2OMbWAFnlc/xVMvoKixoGcdsUWI?=
 =?us-ascii?Q?EhXFz58Y4BSLbapOcmqLxSOyRYwDgsyyjtABaMBAtqWPbHmlBD1WolUjvk2/?=
 =?us-ascii?Q?2Iqk1H4y/Hjy3eFMO5g3h6UaUe4gvHV2FW0c4O2PXgcyiYHsO50NOMXaOLDk?=
 =?us-ascii?Q?vACCcN0Uc5zuV2XZQwFuidJ/glRHXF146gcape4acZbi4c99rSo++YrrHkWJ?=
 =?us-ascii?Q?qj9cDBPsMAQfLWii5kc2aiJwXCfEQsregVydySDDVpOYC3MH0fuhDx0mi1BJ?=
 =?us-ascii?Q?7TtebRdy3Hl8BgUTzuS38e7kcLIrGVshQnNHN6Pcx8Fwy29rfl/cPprdDuI9?=
 =?us-ascii?Q?W38M75aYHTQ+YjVhLwY7d+NExgCBBMIxa5gvBPJ8pToCfSpC/IlqxgypiIHA?=
 =?us-ascii?Q?myE2HmJ7sh00+3BIWvMJ8rf3o5bRT3+5rEsW4Rx1Egc5Nci22hTfJr9VXjzy?=
 =?us-ascii?Q?uFxOWFyg2K8rqOAWu3kFEbmIiT1k1iE0/lnv/Uzf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RQbSg3bD9FiMkgSsoQHGV4sRnqISoJvPVeW4SKJxbHYBgflWCePmdwQrS85mz9bHm4WmTtEKweCZAHDFvAcDkibXCHZTaVGTY+f1mSwJ0keQPuk8H8HgrAF6Jwmo1t0QZ2LZZ7qem0gjFx0SJ/BkS/tC/RLpMP3V/OUARS6o1m6JVyKed8aQopi8U3b9LsmypS93Otceu2EEwIaL5SPGN66oMUElKGP+mcgv8mMAtp4AjbTWq5LJA7hitwS9BbMEhiKL1hrBYPsCBPTB7NZU3LJgXJVx1W7GnVxDVM31ow0F02hthDuhcexET78VWxtPfpTv7k0JBFxvDSuxzhMDp0XZh16rIQ/S/F8KBULps3ECgSUq2BOLbwkL6bG6YnJU7MQfoHlh16lJ4C3hix+j8XEuX1N56c1Se8goxRWDmHlUWKWmr0inld5mJD1C9fJdD2FL5lBBDk4qBNOomTYy3RSM5ekCE+8KmsNx4LCDmtKobNXunfqSzj+S/K4fX0TemqqLwGzVb95EUft1NYWGebyDWERrOKBghkTqHoKQd9/8PD9hJEieUBD9aN371K5kHXQ4OPqvTz/X4JyJM90JNNC2AdevDkOvxlAgcqumNeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c85e9ac-fa97-4cf7-671f-08dd70d20cdd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 04:02:42.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVeAwNkc86oH27V4PfsML+hYpvECrXOc/1Xl9e18LxevaPS+uRPInW5BOMYYwDgrX6T1rjK/4vAZf5mYWrt0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504010025
X-Proofpoint-ORIG-GUID: PddGwZcPbf5ZWK17zorLdR21tuLD2dRq
X-Proofpoint-GUID: PddGwZcPbf5ZWK17zorLdR21tuLD2dRq

On Mon, Mar 31, 2025 at 05:48:18PM +0530, Bhupesh wrote:
> Provide a parallel implementation for get_task_comm() called
> get_task_full_name() which allows the dynamically allocated
> and filled-in task's full name to be passed to interested
> users such as 'gdb'.
> 
> Currently while running 'gdb', the 'task->comm' value of a long
> task name is truncated due to the limitation of TASK_COMM_LEN.
> 
> For example using gdb to debug a simple app currently which generate
> threads with long task names:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
> 
>   NameThatIsTooLo
> 
> This patch does not touch 'TASK_COMM_LEN' at all, i.e.
> 'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
> that all the legacy / existing ABI, continue to work as before using
> '/proc/$pid/task/$tid/comm'.
> 
> This patch only adds a parallel, dynamically-allocated
> 'task->full_name' which can be used by interested users
> via '/proc/$pid/task/$tid/full_name'.
> 
> After this change, gdb is able to show full name of the task:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
> 
>   NameThatIsTooLongForComm[4662]
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> ---
>  fs/exec.c             | 21 ++++++++++++++++++---
>  include/linux/sched.h |  9 +++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index f45859ad13ac..4219d77a519c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>  {
>  	struct task_struct *me = current;
>  	int retval;
> +	va_list args;
> +	char *name;
> +	const char *fmt;
>  
>  	/* Once we are committed compute the creds */
>  	retval = bprm_creds_from_file(bprm);
> @@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		 * detecting a concurrent rename and just want a terminated name.
>  		 */
>  		rcu_read_lock();
> -		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
> -				true);
> +		fmt = smp_load_acquire(&bprm->file->f_path.dentry->d_name.name);
> +		name = kvasprintf(GFP_KERNEL, fmt, args);
> +		if (!name)
> +			return -ENOMEM;

Is it safe to return error here, instead of jumping to 'out_unlock' label
and then releasing locks?

> +		me->full_name = name;
> +		__set_task_comm(me, fmt, true);
>  		rcu_read_unlock();
>  	} else {
> -		__set_task_comm(me, kbasename(bprm->filename), true);
> +		fmt = kbasename(bprm->filename);
> +		name = kvasprintf(GFP_KERNEL, fmt, args);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		me->full_name = name;
> +		__set_task_comm(me, fmt, true);
>  	}
>  
>  	/* An exec changes our domain. We are no longer part of the thread
> @@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	return 0;
>  
>  out_unlock:
> +	kfree(me->full_name);
>  	up_write(&me->signal->exec_update_lock);
>  	if (!bprm->cred)
>  		mutex_unlock(&me->signal->cred_guard_mutex);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 56ddeb37b5cd..053b52606652 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1166,6 +1166,9 @@ struct task_struct {
>  	 */
>  	char				comm[TASK_COMM_LEN];
>  
> +	/* To store the full name if task comm is truncated. */
> +	char				*full_name;
> +
>  	struct nameidata		*nameidata;
>  
>  #ifdef CONFIG_SYSVIPC
> @@ -2007,6 +2010,12 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
>  	buf;						\
>  })
>  
> +#define get_task_full_name(buf, buf_size, tsk) ({	\
> +	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
> +	strscpy_pad(buf, (tsk)->full_name, buf_size);	\
> +	buf;						\
> +})
> +
>  #ifdef CONFIG_SMP
>  static __always_inline void scheduler_ipi(void)
>  {
> -- 
> 2.38.1
> 
> 

-- 
Cheers,
Harry (formerly known as Hyeonggon)

